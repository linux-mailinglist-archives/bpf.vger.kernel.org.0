Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D47AC2A8E64
	for <lists+bpf@lfdr.de>; Fri,  6 Nov 2020 05:32:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725830AbgKFEcp (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 5 Nov 2020 23:32:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725616AbgKFEcp (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 5 Nov 2020 23:32:45 -0500
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F971C0613CF;
        Thu,  5 Nov 2020 20:32:43 -0800 (PST)
Received: by mail-lf1-x142.google.com with SMTP id u18so60340lfd.9;
        Thu, 05 Nov 2020 20:32:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xxPk4qPIYtCB6PNLNLWC1SWVlhF6S51Z89AuPAA/CpM=;
        b=fjsJpmBSDgU8Hq7QA7QEwxEiMMVfdDsDeTAU7pMJrubrDq5V7h1I3ubAXkpi6ouOA7
         oVfAggtYjXDn58ZA2aJqzblysPeDijxbnGvr9wEtwSHx1oAaAW0Ocpj25JK3NJYUd9X/
         WZAmfeudgn3oZyHzrVXBjM+oXAWBk14Z4XgO32HcLopRPYNhMUE5u1ILJiH9I3XDrjGV
         8zp60Z5uNkJGGq97KNvRSGv+0dBtzIM/RXagc0YV8UFK4+b+1kuOKlOALyPYpO6fCjdA
         fDcOBMP9KHGQ2GX6IYiYC+5Uzsn2YYApzvGTDjy5oWpoLA3pFrWGxMdzxjhClBEO8RVl
         1B3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xxPk4qPIYtCB6PNLNLWC1SWVlhF6S51Z89AuPAA/CpM=;
        b=A65Xm8zmbJwB/mZLljeU3HH9MSlIJxnqVmJsa/00f0TObwew3H0H5fyu8MmyjsCSPN
         W95F7WGH2E43bNj+xFFRpr176gyp3WgU3La6HglwTixClRxVvF7jtwYMif0tk6hTky/h
         H59s50BD36DRZrs08ntGhLY4qBYj5Wqh52+GU3UkmtlKn8p4UPgJRjvdIyaG65cnhWG/
         1piLaTSusFpVCWQWQTXAE62MkVRvDX35dgAN+jNpZoR0UYSLFSQYt72B+KmKNdCX8NTZ
         jHCuaeUTE32X/TiKCyFypdTvdPsV3GTyqPJ/tY4S6ilds1yvTRk3pm+lO+X4nfSecIta
         8Ayw==
X-Gm-Message-State: AOAM530eySgm9CPuF2qd+RV8C4xAwpbg92VzFwuXo3UPgbkdB4rnss+1
        3C7ibEvFtuYLMqdChE9SBOAvoMsmIIp3tiaMl6Y=
X-Google-Smtp-Source: ABdhPJzt52pZqGzS5gfG5wbXSzorsVuvxafHToZ6xCHkg7xk3c2DQQiPPtpasr2ldQd3mvE/mGtoj5cbOzgXwTDJ4VE=
X-Received: by 2002:a05:6512:3049:: with SMTP id b9mr112833lfb.554.1604637161834;
 Thu, 05 Nov 2020 20:32:41 -0800 (PST)
MIME-Version: 1.0
References: <eb78270e61e4d2e8ece047430d8397e000ef8569.1604456921.git.dxu@dxuuu.xyz>
 <20201106020930.GA18349@xsang-OptiPlex-9020>
In-Reply-To: <20201106020930.GA18349@xsang-OptiPlex-9020>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Thu, 5 Nov 2020 20:32:30 -0800
Message-ID: <CAADnVQLcwB8ebbpuqnjvqebGp4293zd4s4nAawJ=EaU-6+wXpA@mail.gmail.com>
Subject: Re: [lib/strncpy_from_user.c] 00a4ef91e8: BUG:KASAN:slab-out-of-bounds_in_s
To:     kernel test robot <oliver.sang@intel.com>
Cc:     Daniel Xu <dxu@dxuuu.xyz>, bpf <bpf@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Kernel Team <kernel-team@fb.com>, 0day robot <lkp@intel.com>,
        lkp@lists.01.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Daniel,

the kasan complains about the previous version of your patch,
but your v4 version looks equivalent.
Could you try to repro this issue?
The code looks correct, but kasan complain is concerning.

On Thu, Nov 5, 2020 at 5:56 PM kernel test robot <oliver.sang@intel.com> wrote:
>
> Greeting,
>
> FYI, we noticed the following commit (built with clang-12):
>
> commit: 00a4ef91e8f5af6edceb9bd4bceed2305f038796 ("[PATCH bpf-next] lib/strncpy_from_user.c: Don't overcopy bytes after NUL terminator")
> url: https://github.com/0day-ci/linux/commits/Daniel-Xu/lib-strncpy_from_user-c-Don-t-overcopy-bytes-after-NUL-terminator/20201104-103306
> base: https://git.kernel.org/cgit/linux/kernel/git/bpf/bpf-next.git master
>
> in testcase: trinity
> version: trinity-x86_64-af355e9-1_2019-12-03
> with following parameters:
>
>         runtime: 300s
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
> |                                                                            | f4c3881edb | 00a4ef91e8 |
> +----------------------------------------------------------------------------+------------+------------+
> | boot_successes                                                             | 8          | 4          |
> | boot_failures                                                              | 14         | 15         |
> | Initramfs_unpacking_failed                                                 | 13         | 7          |
> | Kernel_panic-not_syncing:VFS:Unable_to_mount_root_fs_on_unknown-block(#,#) | 13         | 9          |
> | BUG:kernel_hang_in_boot_stage                                              | 1          |            |
> | BUG:KASAN:slab-out-of-bounds_in_s                                          | 0          | 3          |
> | BUG:KASAN:slab-out-of-bounds_in_l                                          | 0          | 3          |
> +----------------------------------------------------------------------------+------------+------------+
>
>
> If you fix the issue, kindly add following tag
> Reported-by: kernel test robot <oliver.sang@intel.com>
>
>
> [  324.803835] BUG: KASAN: slab-out-of-bounds in strlen+0x53/0x5d
> [  324.808932] Read of size 1 at addr ffff88813be5f380 by task trinity-c0/7148
> [  324.809979]
> [  324.810240] CPU: 1 PID: 7148 Comm: trinity-c0 Not tainted 5.9.0-13430-g00a4ef91e8f5 #1
> [  324.811397] Call Trace:
> [  324.811797]  dump_stack+0x156/0x194
> [  324.812387]  ? wake_up_klogd+0x49/0x5e
> [  324.813118]  ? vprintk_emit+0x297/0x307
> [  324.813680]  print_address_description+0x25/0x4b7
> [  324.814354]  ? printk+0x54/0x5d
> [  324.814877]  ? kasan_report+0xad/0x187
> [  324.815531]  kasan_report+0x140/0x187
> [  324.816187]  ? strlen+0x53/0x5d
> [  324.820931] [child7:7142] Tried 16 32-bit syscalls unsuccessfully. Disabling all 32-bit syscalls.
> [  324.828848]  strlen+0x53/0x5d
> [  324.828864]  getname_kernel+0x19/0x257
> [  324.828874]  kern_path+0x19/0x32
> [  324.828887]  lookup_bdev+0x52/0x182
> [  324.828908]  __x64_sys_quotactl+0x1fe/0x4e97
> [  324.833228]  ? kvm_sched_clock_read+0x14/0x28
> [  324.837181]  ? sched_clock+0x5/0x8
> [  324.837748]  ? sched_clock_cpu+0x18/0x151
> [  324.838396]  ? up_write+0xd7/0x399
> [  324.838944]  ? security_file_mprotect+0x93/0xb0
> [  324.839686]  ? __x64_sys_mprotect+0x31a/0x6a9
> [  324.840405]  ? fpregs_assert_state_consistent+0xae/0xd3
> [  324.841253]  do_syscall_64+0x34/0x6c
> [  324.841808]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> [  324.842540] RIP: 0033:0x7f77ba3311c9
> [  324.843079] Code: 01 00 48 81 c4 80 00 00 00 e9 f1 fe ff ff 0f 1f 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 97 dc 2c 00 f7 d8 64 89 01 48
> [  324.845838] RSP: 002b:00007ffe42abbe58 EFLAGS: 00000246 ORIG_RAX: 00000000000000b3
> [  324.846978] RAX: ffffffffffffffda RBX: 00000000000000b3 RCX: 00007f77ba3311c9
> [  324.848039] RDX: 0000000004000000 RSI: 00007f77b8719000 RDI: 0000000012121000
> [  324.849923] RBP: 00007f77baa1d000 R08: ffffffffffffffff R09: 0000000000000000
> [  324.850961] R10: 00007f77b8719000 R11: 0000000000000246 R12: 00007f77baa1d058
> [  324.852032] R13: 00007f77baa246b0 R14: 0000000000000000 R15: 00007f77baa1d000
> [  324.853117]
> [  324.853292]
> [  324.853372] Allocated by task 7148:
> [  324.854203]  kasan_save_stack+0x27/0x47
> [  324.854779]  __kasan_kmalloc+0xed/0x104
> [  324.855365]  kmem_cache_alloc+0xcb/0x135
> [  324.855971]  getname_flags+0x51/0x3a2
> [  324.856536]  __x64_sys_quotactl+0x1c1/0x4e97
> [  324.857205]  do_syscall_64+0x34/0x6c
> [  324.857749]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> [  324.858495]
> [  324.858656] [child2:7150] Tried 16 32-bit syscalls unsuccessfully. Disabling all 32-bit syscalls.
> [  324.858746] The buggy address belongs to the object at ffff88813be5e380
> [  324.858746]  which belongs to the cache names_cache of size 4096
> [  324.858764] The buggy address is located 0 bytes to the right of
> [  324.858764]  4096-byte region [ffff88813be5e380, ffff88813be5f380)
> [  324.860587]
> [  324.862729] The buggy address belongs to the page:
> [  324.862755] page:000000009f9037ac refcount:1 mapcount:0 mapping:0000000000000000 index:0xffff88813be5ffff pfn:0x13be5e
> [  324.867328] head:000000009f9037ac order:1 compound_mapcount:0
> [  324.868165] flags: 0x8000000000010200(slab|head)
> [  324.868875] raw: 8000000000010200 ffffea0005a88688 ffffea000459f288 ffff888100252300
> [  324.870009] raw: ffff88813be5ffff ffff88813be5e380 0000000100000001 0000000000000000
> [  324.871126] page dumped because: kasan: bad access detected
> [  324.871945]
> [  324.872192] Memory state around the buggy address:
> [  324.872947]  ffff88813be5f280: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> [  324.873980]  ffff88813be5f300: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> [  324.875009] >ffff88813be5f380: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> [  324.876036]                    ^
> [  324.876538]  ffff88813be5f400: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> [  324.877588]  ffff88813be5f480: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> [  324.878621] ==================================================================
> [  324.879657] Disabling lock debugging due to kernel taint
> [  324.882776] [child2:7152] Tried 16 32-bit syscalls unsuccessfully. Disabling all 32-bit syscalls.
> [  324.882801]
> [  324.933069] [main] kernel became tainted! (32/0) Last seed was 2498072066
> [  324.933099]
> [  324.969750] trinity: Detected kernel tainting. Last seed was 2498072066
> [  324.969776]
> [  324.976192] [main] exit_reason=7, but 7 children still running.
> [  324.976217]
> [  326.978916] [main] Bailing main loop because kernel became tainted..
> [  326.978943]
> [  327.015587] [main] Ran 32788 syscalls. Successes: 10983  Failures: 20991
> [  327.015610]
>
> Kboot worker: lkp-worker04
> Elapsed time: 360
>
> kvm=(
>         qemu-system-x86_64
>         -enable-kvm
>         -cpu SandyBridge
>         -kernel $kernel
>         -initrd initrd-vm-snb-72.cgz
>         -m 8192
>         -smp 2
>         -device e1000,netdev=net0
>         -netdev user,id=net0,hostfwd=tcp::32032-:22
>         -boot order=nc
>         -no-reboot
>         -watchdog i6300esb
>         -watchdog-action debug
>         -rtc base=localtime
>
>
> To reproduce:
>
>         # build kernel
>         cd linux
>         cp config-5.9.0-13430-g00a4ef91e8f5 .config
>         make HOSTCC=clang-12 CC=clang-12 ARCH=x86_64 olddefconfig prepare modules_prepare bzImage
>
>         git clone https://github.com/intel/lkp-tests.git
>         cd lkp-tests
>         bin/lkp qemu -k <bzImage> job-script # job-script is attached in this email
>
>
>
> Thanks,
> Oliver Sang
>
