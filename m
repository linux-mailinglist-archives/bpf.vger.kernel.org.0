Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10B2B2AC176
	for <lists+bpf@lfdr.de>; Mon,  9 Nov 2020 17:55:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729776AbgKIQzD (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 9 Nov 2020 11:55:03 -0500
Received: from www62.your-server.de ([213.133.104.62]:60328 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730149AbgKIQzC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 9 Nov 2020 11:55:02 -0500
Received: from sslproxy01.your-server.de ([78.46.139.224])
        by www62.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <daniel@iogearbox.net>)
        id 1kcART-0004ec-AK; Mon, 09 Nov 2020 17:54:55 +0100
Received: from [178.196.19.221] (helo=pc-9.home)
        by sslproxy01.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1kcART-000R0h-3b; Mon, 09 Nov 2020 17:54:55 +0100
Subject: Re: [selftest/bpf] b83590ee1a: BUG:KASAN:slab-out-of-bounds_in_l
To:     kernel test robot <oliver.sang@intel.com>,
        Daniel Xu <dxu@dxuuu.xyz>
Cc:     bpf@vger.kernel.org, linux-kernel@vger.kernel.org, ast@kernel.org,
        songliubraving@fb.com, kernel-team@fb.com,
        0day robot <lkp@intel.com>, lkp@lists.01.org
References: <20201109145445.GB13878@xsang-OptiPlex-9020>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <8f040468-f45f-d272-af37-b7e634aeefa9@iogearbox.net>
Date:   Mon, 9 Nov 2020 17:54:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20201109145445.GB13878@xsang-OptiPlex-9020>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.102.4/25983/Mon Nov  9 14:20:27 2020)
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Daniel,

On 11/9/20 3:54 PM, kernel test robot wrote:
> Greeting,
> 
> FYI, we noticed the following commit (built with gcc-9):
> 
> commit: b83590ee1add052518603bae607b0524632b7793 ("[PATCH bpf v3 2/2] selftest/bpf: Test bpf_probe_read_user_str() strips trailing bytes after NUL")
> url: https://github.com/0day-ci/linux/commits/Daniel-Xu/Fix-bpf_probe_read_user_str-overcopying/20201106-033210
> base: https://git.kernel.org/cgit/linux/kernel/git/bpf/bpf.git master

I've tossed them from the tree for now as it looks like these are adding regressions
for regular strncpy_from_user() calls, please take a look.

Thanks!

> in testcase: trinity
> version: trinity-x86_64-af355e9-1_2019-12-03
> with following parameters:
> 
> 	runtime: 300s
> 
> test-description: Trinity is a linux system call fuzz tester.
> test-url: http://codemonkey.org.uk/projects/trinity/
> 
> 
> on test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 8G
> 
> caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):
> 
> 
> +----------------------------------------------------------------------------+------------+------------+
> |                                                                            | e65411d04b | b83590ee1a |
> +----------------------------------------------------------------------------+------------+------------+
> | BUG:KASAN:slab-out-of-bounds_in_l                                          | 0          | 4          |
> +----------------------------------------------------------------------------+------------+------------+
> 
> 
> If you fix the issue, kindly add following tag
> Reported-by: kernel test robot <oliver.sang@intel.com>
> 
> 
> [   54.933739] BUG: KASAN: slab-out-of-bounds in link_path_walk+0x8f5/0xa80
> [   54.935295] Read of size 1 at addr ffff88815f726951 by task modprobe/114
> [   54.936720]
> [   54.937199] CPU: 1 PID: 114 Comm: modprobe Not tainted 5.9.0-13439-gb83590ee1add #1
> [   54.938907] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.12.0-1 04/01/2014
> [   54.940683] Call Trace:
> [   54.941008]  dump_stack+0x84/0xad
> [   54.941008]  print_address_description+0x2f/0x220
> [   54.941008]  ? pm_suspend.cold+0x70e/0x70e
> [   54.941008]  ? _raw_write_lock_irqsave+0x150/0x150
> [   54.941008]  ? link_path_walk+0x8f5/0xa80
> [   54.941008]  kasan_report.cold+0x37/0x7c
> [   54.941008]  ? link_path_walk+0x8f5/0xa80
> [   54.941008]  __asan_report_load1_noabort+0x14/0x20
> [   54.941008]  link_path_walk+0x8f5/0xa80
> [   54.941008]  ? walk_component+0x670/0x670
> [   54.941008]  ? deactivate_slab+0x3d9/0x690
> [   54.941008]  link_path_walk+0x91/0xb0
> [   54.941008]  path_lookupat+0x12f/0x430
> [   54.941008]  filename_lookup+0x19a/0x2d0
> [   54.941008]  ? may_linkat+0x180/0x180
> [   54.941008]  ? __check_object_size+0x2bf/0x390
> [   54.941008]  ? strncpy_from_user+0x24b/0x490
> [   54.941008]  ? getname_flags+0x13a/0x4a0
> [   54.941008]  user_path_at_empty+0x3f/0x50
> [   54.941008]  do_faccessat+0xc1/0x5d0
> [   54.941008]  ? stream_open+0x60/0x60
> [   54.941008]  ? exit_to_user_mode_prepare+0xb9/0x190
> [   54.941008]  __x64_sys_access+0x56/0x80
> [   54.941008]  do_syscall_64+0x5d/0x70
> [   54.941008]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> [   54.941008] RIP: 0033:0x7f3cc3f345f7
> [   54.941008] Code: c8 ff c3 b8 01 00 00 00 0f 05 48 3d 01 f0 ff ff 73 01 c3 48 8d 0d 19 9b 20 00 f7 d8 89 01 48 83 c8 ff c3 b8 15 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8d 0d f9 9a 20 00 f7 d8 89 01 48 83
> [   54.941008] RSP: 002b:00007ffde47f0b68 EFLAGS: 00000246 ORIG_RAX: 0000000000000015
> [   54.941008] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f3cc3f345f7
> [   54.941008] RDX: 0000000000000006 RSI: 0000000000000004 RDI: 00007f3cc3f39bd0
> [   54.941008] RBP: 00007ffde47f1c70 R08: ffffffffffffffff R09: 0000000000000000
> [   54.941008] R10: 0000000000000022 R11: 0000000000000246 R12: 0000000000000000
> [   54.941008] R13: 00007ffde47f9330 R14: 000000000000000f R15: 00007f3cc413e150
> [   54.941008]
> [   54.941008] Allocated by task 114:
> [   54.941008]  kasan_save_stack+0x23/0x50
> [   54.941008]  __kasan_kmalloc+0xe1/0xf0
> [   54.941008]  kasan_slab_alloc+0xe/0x10
> [   54.941008]  kmem_cache_alloc+0x166/0x360
> [   54.941008]  getname_flags+0x4e/0x4a0
> [   54.941008]  user_path_at_empty+0x2b/0x50
> [   54.941008]  do_faccessat+0xc1/0x5d0
> [   54.941008]  __x64_sys_access+0x56/0x80
> [   54.941008]  do_syscall_64+0x5d/0x70
> [   54.941008]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> [   54.941008]
> [   54.941008] The buggy address belongs to the object at ffff88815f725900
> [   54.941008]  which belongs to the cache names_cache of size 4096
> [   54.941008] The buggy address is located 81 bytes to the right of
> [   54.941008]  4096-byte region [ffff88815f725900, ffff88815f726900)
> [   54.941008] The buggy address belongs to the page:
> [   54.941008] page:(____ptrval____) refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x15f720
> [   54.941008] head:(____ptrval____) order:3 compound_mapcount:0 compound_pincount:0
> [   54.941008] flags: 0x8000000000010200(slab|head)
> [   54.941008] raw: 8000000000010200 ffffea00057da008 ffff88810020b070 ffff888100209bc0
> [   54.941008] raw: 0000000000000000 0000000000070007 00000001ffffffff 0000000000000000
> [   54.941008] page dumped because: kasan: bad access detected
> [   54.941008]
> [   54.941008] Memory state around the buggy address:
> [   54.941008]  ffff88815f726800: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> [   54.941008]  ffff88815f726880: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> [   54.941008] >ffff88815f726900: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> [   54.941008]                                                  ^
> [   54.941008]  ffff88815f726980: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> [   54.941008]  ffff88815f726a00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> [   54.941008] ==================================================================
> [   54.941008] Disabling lock debugging due to kernel taint
> [   55.025235] lp: driver loaded but no devices found
> [   55.026765] Non-volatile memory driver v1.3
> [   55.031388] ppdev: user-space parallel port driver
> [   55.036641] dummy-irq: no IRQ given.  Use irq=N
> [   55.039897] Guest personality initialized and is inactive
> [   55.041228] Floppy drive(s): fd0 is 2.88M AMI BIOS
> [   55.041729] VMCI host device registered (name=vmci, major=10, minor=61)
> [   55.044234] Initialized host personality
> [   55.047105] Uniform Multi-Platform E-IDE driver
> [   55.048446] piix 0000:00:01.1: IDE controller (0x8086:0x7010 rev 0x00)
> [   55.050325] piix 0000:00:01.1: not 100% native mode: will probe irqs later
> [   55.051887] legacy IDE will be removed in 2021, please switch to libata
> [   55.051887] Report any missing HW support to linux-ide@vger.kernel.org
> [   55.054769]     ide0: BM-DMA at 0xc040-0xc047
> [   55.056784]     ide1: BM-DMA at 0xc048-0xc04f
> [   55.057890] Probing IDE interface ide0...
> [   55.070346] FDC 0 is a S82078B
> [   55.759777] Probing IDE interface ide1...
> [   56.679473] hdc: QEMU DVD-ROM, ATAPI CD/DVD-ROM drive
> [   57.519821] hdc: host max PIO4 wanted PIO255(auto-tune) selected PIO0
> [   57.524835] hdc: MWDMA2 mode selected
> [   57.526678] ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
> [   57.528434] ide1 at 0x170-0x177,0x376 on irq 15
> [   57.540083] rdac: device handler registered
> [   57.542134] emc: device handler registered
> [   57.543705] st: Version 20160209, fixed bufsize 32768, s/g segs 256
> [   57.546315] SCSI Media Changer driver v0.25
> [   57.550619] cs89x0: cs89x0_probe(0x0)
> 
> 
> To reproduce:
> 
>          # build kernel
> 	cd linux
> 	cp config-5.9.0-13439-gb83590ee1add .config
> 	make HOSTCC=gcc-9 CC=gcc-9 ARCH=x86_64 olddefconfig prepare modules_prepare bzImage
> 
>          git clone https://github.com/intel/lkp-tests.git
>          cd lkp-tests
>          bin/lkp qemu -k <bzImage> job-script # job-script is attached in this email
> 
> 
> 
> Thanks,
> Oliver Sang
> 

