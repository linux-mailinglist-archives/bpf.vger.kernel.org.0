Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 63CAA19AD64
	for <lists+bpf@lfdr.de>; Wed,  1 Apr 2020 16:07:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732896AbgDAOHI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 1 Apr 2020 10:07:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:57964 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732898AbgDAOHH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 1 Apr 2020 10:07:07 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3CB0C2077D;
        Wed,  1 Apr 2020 14:07:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585750026;
        bh=T0msRMRpBAVH8M6vyVQQ0AQirZWcf/8dKWh2xCf+kAI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=b/dFIbzT73059bfL+OphJWOrS39i/CeHYwGjBv9gd03wZqxhL9cV3vd/lcLALW5/z
         CmfF3HlRwL9PbCWSQqqXVy8IT5VwHbxWMV6XBP26Nk/G81XciudkTM7mWouY0ZRvPw
         bmR9nP3YuXjaAowfJQ8EuoAMqrrlQTmst4YBK6JE=
Date:   Wed, 1 Apr 2020 23:07:00 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     kernel test robot <rong.a.chen@intel.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Peter Wu <peter@lekensteyn.nl>,
        Jonathan Corbet <corbet@lwn.net>,
        Tom Zanussi <zanussi@kernel.org>,
        Shuah Khan <shuahkhan@gmail.com>, bpf <bpf@vger.kernel.org>,
        lkp@lists.01.org
Subject: Re: [tracing] cd8f62b481:
 BUG:sleeping_function_called_from_invalid_context_at_mm/slab.h
Message-Id: <20200401230700.d9ddb42b3459dca98144b55c@kernel.org>
In-Reply-To: <20200326091256.GR11705@shao2-debian>
References: <20200319232731.799117803@goodmis.org>
        <20200326091256.GR11705@shao2-debian>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Steve,

On Thu, 26 Mar 2020 17:12:56 +0800
kernel test robot <rong.a.chen@intel.com> wrote:

> FYI, we noticed the following commit (built with gcc-7):
> 
> commit: cd8f62b481530fafbeacee0d3283b60bcf42d854 ("[PATCH 02/12 v2] tracing: Save off entry when peeking at next entry")
> url: https://github.com/0day-ci/linux/commits/Steven-Rostedt/ring-buffer-tracing-Remove-disabling-of-ring-buffer-while-reading-trace-file/20200320-073240
> 

Hmm, this seems that we can not call kmalloc() in ftrace_dump().
Maybe we can fix it by
- Use GFP_ATOMIC.
 or
- Do not use iter->temp if it is NULL. (it is safe since ftrace_dump() stops tracing)

What would you think?

Thank you,

> 
> in testcase: rcuperf
> with following parameters:
> 
> 	runtime: 300s
> 	perf_type: rcu
> 
> 
> 
> on test machine: qemu-system-i386 -enable-kvm -cpu SandyBridge -smp 2 -m 8G
> 
> caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):
> 
> 
> +----------------------------------------------------------------+------------+------------+
> |                                                                | 2e2bf17ca0 | cd8f62b481 |
> +----------------------------------------------------------------+------------+------------+
> | boot_successes                                                 | 13         | 0          |
> | boot_failures                                                  | 0          | 8          |
> | BUG:sleeping_function_called_from_invalid_context_at_mm/slab.h | 0          | 8          |
> +----------------------------------------------------------------+------------+------------+
> 
> 
> If you fix the issue, kindly add following tag
> Reported-by: kernel test robot <rong.a.chen@intel.com>
> 
> 
> [   16.821280] BUG: sleeping function called from invalid context at mm/slab.h:565
> [   16.822211] in_atomic(): 0, irqs_disabled(): 1, non_block: 0, pid: 158, name: rcu_perf_writer
> [   16.823164] no locks held by rcu_perf_writer/158.
> [   16.823650] CPU: 0 PID: 158 Comm: rcu_perf_writer Not tainted 5.6.0-rc6-00081-gcd8f62b481530f #1
> [   16.824856] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.12.0-1 04/01/2014
> [   16.826220] Call Trace:
> [   16.826667]  dump_stack+0x16/0x18
> [   16.827265]  ___might_sleep+0x104/0x118
> [   16.827947]  __might_sleep+0x69/0x70
> [   16.828600]  ? __fs_reclaim_release+0x17/0x19
> [   16.829374]  slab_pre_alloc_hook+0x34/0x6e
> [   16.830107]  __kmalloc+0x48/0xe8
> [   16.830710]  ? rb_reader_unlock+0x2b/0x3c
> [   16.831205]  ? trace_find_next_entry+0x84/0x133
> [   16.831723]  trace_find_next_entry+0x84/0x133
> [   16.832217]  trace_print_lat_context+0x4b/0x437
> [   16.832730]  ? rb_event_length+0x56/0x67
> [   16.833186]  ? ring_buffer_event_length+0x34/0x79
> [   16.833728]  ? __find_next_entry+0xd3/0x1c2
> [   16.834190]  print_trace_line+0x69d/0x767
> [   16.834666]  ftrace_dump+0x285/0x437
> [   16.835055]  rcu_perf_writer+0x25f/0x34e
> [   16.835476]  kthread+0xdf/0xe1
> [   16.835823]  ? rcu_perf_reader+0x9c/0x9c
> [   16.836264]  ? kthread_create_worker_on_cpu+0x1c/0x1c
> [   16.836834]  ret_from_fork+0x2e/0x38
> [   16.837270] rb_produ-160     0.... 6528532us : ring_buffer_producer: Starting ring buffer hammer
> [   16.838318] rb_produ-160     0.... 16529141us : ring_buffer_producer: End ring buffer hammer
> [   16.839349] rb_produ-160     0.... 16558157us : ring_buffer_producer: Running Consumer at nice: 19
> [   16.840382] rb_produ-160     0.... 16558162us : ring_buffer_producer: Running Producer at nice: 19
> [   16.841401] rb_produ-160     0.... 16558163us : ring_buffer_producer: WARNING!!! This test is running at lowest priority.
> [   16.854781] rb_produ-160     0.... 16558164us : ring_buffer_producer: Time:     10000604 (usecs)
> [   16.857354] rb_produ-160     0.... 16558165us : ring_buffer_producer: Overruns: 6117960
> [   16.858322] rb_produ-160     0.... 16558166us : ring_buffer_producer: Read:     4356190  (by events)
> [   16.859404] rb_produ-160     0.... 16558167us : ring_buffer_producer: Entries:  44650
> [   16.860329] rb_produ-160     0.... 16558167us : ring_buffer_producer: Total:    10518800
> [   16.861226] rb_produ-160     0.... 16558168us : ring_buffer_producer: Missed:   0
> [   16.862124] rb_produ-160     0.... 16558169us : ring_buffer_producer: Hit:      10518800
> [   16.863087] rb_produ-160     0.... 16558170us : ring_buffer_producer: Entries per millisec: 1051
> [   16.864123] rb_produ-160     0.... 16558171us : ring_buffer_producer: 951 ns per entry
> [   16.865074] rb_produ-160     0.... 16558172us : ring_buffer_producer_thread: Sleeping for 10 secs
> [   16.866105] ---------------------------------
> [   16.866725] rcu-perf: Test complete
> [   16.878198] random: fast init done
> 
> Elapsed time: 60
> 
> qemu-img create -f qcow2 disk-vm-snb-i386-9-0 256G
> qemu-img create -f qcow2 disk-vm-snb-i386-9-1 256G
> qemu-img create -f qcow2 disk-vm-snb-i386-9-2 256G
> qemu-img create -f qcow2 disk-vm-snb-i386-9-3 256G
> qemu-img create -f qcow2 disk-vm-snb-i386-9-4 256G
> qemu-img create -f qcow2 disk-vm-snb-i386-9-5 256G
> qemu-img create -f qcow2 disk-vm-snb-i386-9-6 256G
> 
> kvm=(
> 	qemu-system-i386
> 	-enable-kvm
> 	-cpu SandyBridge
> 	-kernel $kernel
> 	-initrd initrd-vm-snb-i386-9.cgz
> 	-m 8192
> 	-smp 2
> 	-device e1000,netdev=net0
> 	-netdev user,id=net0,hostfwd=tcp::32032-:22
> 	-boot order=nc
> 	-no-reboot
> 	-watchdog i6300esb
> 	-watchdog-action debug
> 	-rtc base=localtime
> 	-drive file=disk-vm-snb-i386-9-0,media=disk,if=virtio
> 	-drive file=disk-vm-snb-i386-9-1,media=disk,if=virtio
> 	-drive file=disk-vm-snb-i386-9-2,media=disk,if=virtio
> 	-drive file=disk-vm-snb-i386-9-3,media=disk,if=virtio
> 	-drive file=disk-vm-snb-i386-9-4,media=disk,if=virtio
> 	-drive file=disk-vm-snb-i386-9-5,media=disk,if=virtio
> 	-drive file=disk-vm-snb-i386-9-6,media=disk,if=virtio
> 	-serial stdio
> 	-display none
> 	-monitor null
> )
> 
> append=(
> 	ip=::::vm-snb-i386-9::dhcp
> 	root=/dev/ram0
> 	user=lkp
> 	job=/job-script
> 	ARCH=i386
> 	kconfig=i386-randconfig-g003-20200324
> 	branch=linux-devel/devel-hourly-2020032505
> 	commit=cd8f62b481530fafbeacee0d3283b60bcf42d854
> 	BOOT_IMAGE=/pkg/linux/i386-randconfig-g003-20200324/gcc-7/cd8f62b481530fafbeacee0d3283b60bcf42d854/vmlinuz-5.6.0-rc6-00081-gcd8f62b481530f
> 	max_uptime=1500
> 	RESULT_ROOT=/result/rcuperf/rcu-300s/vm-snb-i386/yocto-i386-minimal-20190520.cgz/i386-randconfig-g003-20200324/gcc-7/cd8f62b481530fafbeacee0d3283b60bcf42d854/3
> 	result_service=tmpfs
> 	selinux=0
> 	debug
> 	apic=debug
> 	sysrq_always_enabled
> 	rcupdate.rcu_cpu_stall_timeout=100
> 	net.ifnames=0
> 
> 
> To reproduce:
> 
>         # build kernel
> 	cd linux
> 	cp config-5.6.0-rc6-00081-gcd8f62b481530f .config
> 	make HOSTCC=gcc-7 CC=gcc-7 ARCH=i386 olddefconfig prepare modules_prepare bzImage
> 
>         git clone https://github.com/intel/lkp-tests.git
>         cd lkp-tests
>         bin/lkp qemu -k <bzImage> job-script # job-script is attached in this email
> 
> 
> 
> Thanks,
> Rong Chen
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
