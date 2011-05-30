#!/usr/bin/env ruby

## sort output of `show ip int bri` based on IP address field
## `show ip int bri`の出力をIPアドレスでソートする。

class NetWorkUtil
  class IPAddress
    def initialize(ip)
      @ip = ip
    end
    def <=>(other)
      _num <=> other._num
    end
    def _num
      @ip.split('.').map {|d| "%08d" % Integer(d).to_s(2) }.join("").to_i(2)
    end
    protected :_num
    def align
      @ip.split('.').map {|d| "%3d" % d }.join('.')
    end
  end
end

module Kernel
  def IPAddress(ip)
    ::NetWorkUtil::IPAddress.new(ip)
  end
end
file = "/home/t9md/tmuxlog/cat65"
IP_REGEXP=/(?:\d+\.){3}\d+/
lines = File.read(file).lines.map(&:chomp).grep(IP_REGEXP).
  map     { |e       | vlan, ip  = e.split; [vlan, IPAddress(ip) ] }.
  sort_by { |vlan, ip| [ip, vlan]                                  }.
  map     { |vlan, ip| "%-10s %s" % [ vlan, ip.align ]             } 

