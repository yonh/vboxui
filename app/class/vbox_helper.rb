require 'awesome_print'

class VboxHelper
  def vms
    data = `vboxmanage list vms`

    returnList = []

    if !data.empty?
      list = data.split "\n"

      list.each do|line|
        matchs = /\"(.*)\" {(.*)}/.match(line)
        if matchs
          m = Machine.new
          m.setName = matchs[1]
          m.setUuid = matchs[2]
          m.setVminfo = self::vminfo(matchs[2])
          returnList.push(m)

          ap m.getVminfo
        end
      end
    end

    returnList
  end

  def start(uuid)
    `vboxmanage startvm #{uuid} --type headless`
  end
  def stop(uuid)
    `vboxmanage controlvm #{uuid} poweroff`
  end
  def save_state(uuid)
    `vboxmanage controlvm #{uuid} savestate`
  end
  def pause(uuid)
    `vboxmanage controlvm #{uuid} pause`
  end
  def remove(uuid)
    `vboxmanage unregistervm '#{uuid}' --delete`
  end

  def vminfo(uuid)
    result = `vboxmanage showvminfo #{uuid}`
    map = Hash.new
    if result != nil
      items = result.split "\n"
      items.each do |info|
        if info != ''
          kv = info.split ":"
          if kv.empty? != true
            if kv[0] != nil
              if kv[1] == nil
                kv[1] = ""
              end
              map[kv[0].strip] = kv[1].strip
            end
          end
        end

      end
    end

    map
  end
end