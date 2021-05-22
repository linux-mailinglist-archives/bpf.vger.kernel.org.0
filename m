Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8AE438D73A
	for <lists+bpf@lfdr.de>; Sat, 22 May 2021 21:28:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231311AbhEVT3x (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 22 May 2021 15:29:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231310AbhEVT3w (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 22 May 2021 15:29:52 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83A4EC061574;
        Sat, 22 May 2021 12:28:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:
        Subject:Sender:Reply-To:Cc:Content-ID:Content-Description;
        bh=JZZHqK8bHE0lasm4SgtHg84GIgUgf8Ii9J02KWLU8Wg=; b=xGCfJYeYXUkHaGQxE/D9AIATvJ
        LZiYsbaeL9ZdT+ukzFpEYz8lIifOXqXvyJTUcckSY13w0K6533RBBXzBV8xu+wMPmzrfIYOmRCP18
        W2dqJ6n6oy/lBTejeAoZeIeUu3B6hq1cOBh5HwzYL4k4peIAgvgRYIjj3IP20ptAuDBm2lU3+7eHz
        vKftthfc5/nWQOT3zNwKMn37LRtv9gwzlOHu2AGVQEc0DHKqkBoneeTjhD6i61RKjj933b9bnWOhc
        WVeQXuaZpe5cNb2vEOWYd/MzUzGrHOKCoVTmlMVJj8agkbiwUuaFEEAc//ccSbidE97j8vEw1TLbr
        tJsdGPmw==;
Received: from [2601:1c0:6280:3f0::7376]
        by bombadil.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lkXIQ-000BY5-OD; Sat, 22 May 2021 19:28:26 +0000
Subject: Re: Failed to start load kernel modules on 5.13.0-rc2-next-20210521
To:     Hritik Vijay <hritikxx8@gmail.com>, linux-next@vger.kernel.org,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        bpf <bpf@vger.kernel.org>
References: <YKlWqLh61Rxid7l9@Journey.localdomain>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <21727ead-5092-8900-74e9-ee73774b0b97@infradead.org>
Date:   Sat, 22 May 2021 12:28:25 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <YKlWqLh61Rxid7l9@Journey.localdomain>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 5/22/21 12:08 PM, Hritik Vijay wrote:
> Hello all
> 
> I've been trying to compile and run 5.13.0-rc2-next-20210521 from
> linux-next. It compiles successfully but when I boot it, I get an error
> saying "failed to start load kernel modules". At this point, the
> keyboard becomes unresponsive so I am unable to dig any further.
> I used the config that comes with Archlinux kernel plus the default
> choice to any new option. I've attached it to this mail.
> I generated the initramfs using mkinitcpio (30-1) script, the configuration to
> which I've attached as well.
> My host computer has an encrypted luks volume which contains lvm which
> in turn contains all the filesystems (including /).
> The kernel boot options I used to boot my system is: 
> initrd /initramfs.img
> initrd /intel-ucode.img
> options rd.luks.name=500ac0a9-69ab-48f4-ab29-26328b206a7f=sherlocked root=/dev/sherlock/root rootflags=discard intel_iommu=on iommu=pt vfio-pci.ids=8086:3166,8086:4210
> 
> The same configuration works perfectly with the stable kernel.
> 
> In order to investigate further, I booted the same kernel image inside a
> virtual machine. I used the same initramfs and copied over /lib/modules/5.13.0-rc2-next-20210521
> in the virtual machine. This time I was able to interact with the
> initramfs shell using the serial console. 
> Here is the dmesg from inside the virtual machine:
> 
> [rootfs ]# dmesg

[snip]

> [    0.703422] Run /init as init process
> [    0.703424]   with arguments:
> [    0.703425]     /init
> [    0.703425]     \\vmlinuz
> [    0.703426]   with environment:
> [    0.703427]     HOME=/
> [    0.703427]     TERM=linux
> [    0.703428]     serial=tty0
> [    0.745097] BPF:	 type_id=29677 offset=170152 size=4
> [    0.745744] BPF: 
> [    0.745995] BPF:Invalid offset
> [    0.746382] BPF:
> [    0.746382] 
> [    0.746803] failed to validate module [jbd2] BTF: -22
> [    0.810494] failed to validate module [crc32c_intel] BTF: -22
> [    0.895810] failed to validate module [crc32c_generic] BTF: -22
> [    0.975781] failed to validate module [libcrc32c] BTF: -22
> [    1.149204] failed to validate module [serio] BTF: -22
> [    1.165209] failed to validate module [serio] BTF: -22
> [    1.165321] failed to validate module [xhci_pci_renesas] BTF: -22
> [    1.168234] failed to validate module [crc32c_intel] BTF: -22
> [   33.222665] random: fast init done
> [   55.452163] failed to validate module [crc32c_intel] BTF: -22
> [   55.493354] failed to validate module [crc32c_generic] BTF: -22
> [   55.576653] failed to validate module [libcrc32c] BTF: -22
> [   61.671703] failed to validate module [jbd2] BTF: -22
> 
> 
> The status of systemd-modules-load.service was:
> 
> systemd-modules-load.service - Load Kernel Modules
>      Loaded: loaded (/usr/local/lib/systemd/system/systemd-modules-load.service;
>  static)
>      Active: failed (Result: exit-code) since Thu 2021-05-20 01:05:41 UTC; 3min 
> 48s ago
>        Docs: man:systemd-modules-load.service(8)
>              man:modules-load.d(5)
>     Process: 93 ExecStart=/usr/lib/systemd/systemd-modules-load (code=exited, st
> atus=1/FAILURE)
>    Main PID: 93 (code=exited, status=1/FAILURE)
>         CPU: 24ms
> 
> May 20 01:05:41 archlinux systemd-modules-load[93]: Failed to insert module 'ext
> 4': Invalid argument
> May 20 01:05:41 archlinux systemd-modules-load[93]: Failed to insert module 'xfs
> ': Invalid argument
> May 20 01:05:41 archlinux systemd[1]: systemd-modules-load.service: Main process
>  exited, code=exited, status=1/FAILURE
> May 20 01:05:41 archlinux systemd[1]: systemd-modules-load.service: Failed with 
> result 'exit-code'.
> May 20 01:05:41 archlinux systemd[1]: Failed to start Load Kernel Modules.
> Notice: journal has been rotated since unit was started, output may be incomplet
> e.
> 
> 
> I would also like to mention that I tried both 5.13.0-rc2-next-20210520
> and 5.13.0-rc2-next-20210521 without any change in the errors.
> Also, I generated initramfs based systemd and busybox both. The dmesg
> output is from the busybox version and the systemd-modules-load.service
> output is from the systemd version.
> 
> Further, I took the same config and ran `make mod2yesconfig` in
> order to eliminate the module based errors entirely. 
> This time the kernel failed to compile (perhaps due to low memory)
> dmesg contains the lines
> 
> [17742.379990] oom-kill:constraint=CONSTRAINT_NONE,nodemask=(null),cpuset=/,mems_allowed=0,global_oom,task_memcg=/user.slice/user-1000.slice/session-5.scope,task=pahole,pid=292673,uid=1000
> [17742.380003] Out of memory: Killed process 292673 (pahole) total-vm:12034912kB, anon-rss:4269536kB, file-rss:4kB, shmem-rss:0kB, UID:1000 pgtables:23612kB oom_score_adj:0
> [17743.802356] oom_reaper: reaped process 292673 (pahole), now anon-rss:0kB, file-rss:0kB, shmem-rss:0kB
> 
> and the output to `make -j16 all` is 
>   DESCEND objtool                                                                                                              
>   DESCEND bpf/resolve_btfids                                                                                                   
>   CALL    scripts/atomic/check-atomics.sh                                                                                      
>   CALL    scripts/checksyscalls.sh                                                                                             
>   CHK     include/generated/compile.h                                                                                          
>   CHK     kernel/kheaders_data.tar.xz                                                                                          
>   GEN     .version                                                                                                             
>   CHK     include/generated/compile.h                                                                                          
>   UPD     include/generated/compile.h                          
>   CC      init/version.o       
>   AR      init/built-in.a      
>   LD      vmlinux.o            
>   MODPOST vmlinux.symvers      
>   MODINFO modules.builtin.modinfo                              
>   GEN     modules.builtin      
>   LD      .tmp_vmlinux.btf     
>   BTF     .btf.vmlinux.bin.o   
> btf_elf__write: failed to add .BTF section to '.tmp_vmlinux.btf': 2!                                                           
> Failed to encode BTF           
>   LD      .tmp_vmlinux.kallsyms1                               
>   KSYMS   .tmp_vmlinux.kallsyms1.S                             
>   AS      .tmp_vmlinux.kallsyms1.S                             
>   LD      .tmp_vmlinux.kallsyms2                               
>   KSYMS   .tmp_vmlinux.kallsyms2.S                             
>   AS      .tmp_vmlinux.kallsyms2.S                             
>   LD      vmlinux              
>   BTFIDS  vmlinux              
> FAILED: load BTF from vmlinux: No such file or directory       
> make: *** [Makefile:1275: vmlinux] Error 255              
> make: *** Deleting file 'vmlinux'
> 
> I captured the above output in my 3rd attempt to compile the kernel
> after mod2yesconfig as the previous two attempts crashed Xorg itself.
> 
> Can someone please let me know what's wrong here? 
> I would happily provide more logs if it is required.
> 
> Hrtk
> 

Hi,
Here is a reply to a similar message/problem:
https://lore.kernel.org/lkml/CAEf4BzZuU2TYMapSy7s3=D8iYtVw_N+=hh2ZMGG9w6N0G1HvbA@mail.gmail.com/

so it looks like Andrii is still debugging this problem.

-- 
~Randy

