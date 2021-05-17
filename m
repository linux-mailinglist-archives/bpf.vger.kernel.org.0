Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C61DD382A5B
	for <lists+bpf@lfdr.de>; Mon, 17 May 2021 12:56:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236556AbhEQK5j (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 17 May 2021 06:57:39 -0400
Received: from mail-il1-f200.google.com ([209.85.166.200]:44813 "EHLO
        mail-il1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236505AbhEQK5j (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 17 May 2021 06:57:39 -0400
Received: by mail-il1-f200.google.com with SMTP id p6-20020a92d6860000b02901bb4be9e3c1so6000831iln.11
        for <bpf@vger.kernel.org>; Mon, 17 May 2021 03:56:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=Mvw1ZMzypgw0dQW963IDZFGXoWO2KAZbgmwYDsY4n3I=;
        b=n/uMUmJzrRfkW3nNbFquwsyQqzpypFGpSjc92T4ejP1MDhMh3X8GIu4+UfzaGuDqsI
         +9EWS0j44aXYJublM4KsX/in2Gfb5ul27qbZEhjNsnwvmSD7Z/oMQ+W6cbETzIY7sm6p
         Y35J+lGhNH+Ux4n48Wm517zV+2b49rSuB2i9I83p3ae07XTPx9tx1TsPFToMNWMcKvwr
         j699JWjiXOeL6xqhIlM3X32nI9Q7RU20WgusTv3+DZjPxxUJo7hQ6n0kSMFfuNjJ1vOn
         3/fjvJ4xdzGGG8PZIuwBMI8LdAN+NltdOFqJAopBGjd5u9USmfi+YHLsvViUNz9YJ9QR
         1R1A==
X-Gm-Message-State: AOAM532Q/oXWJtlR6Jf0M08PSgq3Yw0HbRPVbx15+MFBnGXyIu2z5so3
        AqSqjBvQic7WEFSdL8Gdy1PF1OU+ygttEGXwlADpEwSviWbi
X-Google-Smtp-Source: ABdhPJwcoreSZ65eBKWqAeGid1eFwnSu3Jb5EUFDNlwPnE8ubwDlEEHGQk72Yq0jPhbf3scDuQ/rLtPj6xuAApTY4mEU0twlynJx
MIME-Version: 1.0
X-Received: by 2002:a5d:81c9:: with SMTP id t9mr7528052iol.45.1621248982635;
 Mon, 17 May 2021 03:56:22 -0700 (PDT)
Date:   Mon, 17 May 2021 03:56:22 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b3d89a05c284718f@google.com>
Subject: [syzbot] WARNING in __perf_install_in_context
From:   syzbot <syzbot+0fb24f56fa707081e4f2@syzkaller.appspotmail.com>
To:     acme@kernel.org, alexander.shishkin@linux.intel.com,
        andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
        daniel@iogearbox.net, john.fastabend@gmail.com, jolsa@redhat.com,
        kafai@fb.com, kpsingh@kernel.org, linux-kernel@vger.kernel.org,
        mark.rutland@arm.com, mingo@redhat.com, namhyung@kernel.org,
        netdev@vger.kernel.org, peterz@infradead.org,
        songliubraving@fb.com, syzkaller-bugs@googlegroups.com, yhs@fb.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    18a3c5f7 Merge tag 'for_linus' of git://git.kernel.org/pub..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git fixes
console output: https://syzkaller.appspot.com/x/log.txt?x=1662c153d00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b8ac1fe5995f69d7
dashboard link: https://syzkaller.appspot.com/bug?extid=0fb24f56fa707081e4f2
userspace arch: riscv64

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+0fb24f56fa707081e4f2@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 1 PID: 8643 at kernel/events/core.c:2781 __perf_install_in_context+0x1c0/0x47c kernel/events/core.c:2781
Modules linked in:
CPU: 1 PID: 8643 Comm: syz-executor.0 Not tainted 5.12.0-rc8-syzkaller-00011-g18a3c5f7abfd #0
Hardware name: riscv-virtio,qemu (DT)
epc : __perf_install_in_context+0x1c0/0x47c kernel/events/core.c:2781
 ra : __perf_install_in_context+0x1c0/0x47c kernel/events/core.c:2781
epc : ffffffe00027d7ba ra : ffffffe00027d7ba sp : ffffffe00818faf0
 gp : ffffffe0045883c0 tp : ffffffe006dbaf80 t0 : ffffffc4010812b2
 t1 : 0000000000000001 t2 : 0000000000000000 s0 : ffffffe00818fb50
 s1 : ffffffe01ca95000 a0 : ffffffe066d79118 a1 : 00000000000f0000
 a2 : ffffffd010ada000 a3 : ffffffe00027d7ba a4 : ffffffd010ae31f0
 a5 : 000000000000123e a6 : 0000000000f00000 a7 : ffffffe00027d6ba
 s2 : ffffffe066d78f70 s3 : ffffffe01ca950a8 s4 : ffffffe00aacfc00
 s5 : ffffffe006dbaf80 s6 : ffffffe066d78f78 s7 : ffffffe00d98bc00
 s8 : ffffffe006dbaf80 s9 : ffffffe00458c0d0 s10: 0000000000000000
 s11: 0000000000000000 t3 : 2699545dc3e5be00 t4 : ffffffc401031f97
 t5 : ffffffc401031f99 t6 : ffffffe00f58c1f4
status: 0000000000000100 badaddr: 0000000000000000 cause: 0000000000000003
Call Trace:
[<ffffffe00027d7ba>] __perf_install_in_context+0x1c0/0x47c kernel/events/core.c:2781
[<ffffffe00026bcbc>] remote_function kernel/events/core.c:91 [inline]
[<ffffffe00026bcbc>] remote_function+0xa8/0xc0 kernel/events/core.c:71
[<ffffffe0001452b2>] generic_exec_single+0x1a6/0x212 kernel/smp.c:293
[<ffffffe000145452>] smp_call_function_single+0x134/0x2ba kernel/smp.c:513
[<ffffffe00026af46>] task_function_call+0x90/0xee kernel/events/core.c:119
[<ffffffe00027c5da>] perf_install_in_context+0x174/0x2e6 kernel/events/core.c:2902
[<ffffffe000288d1c>] __do_sys_perf_event_open+0x10ea/0x199e kernel/events/core.c:12169
[<ffffffe00028fa72>] sys_perf_event_open+0x34/0x46 kernel/events/core.c:11775
[<ffffffe000005578>] ret_from_syscall+0x0/0x2
irq event stamp: 1944
hardirqs last  enabled at (1943): [<ffffffe0003b3950>] mod_memcg_lruvec_state include/linux/memcontrol.h:979 [inline]
hardirqs last  enabled at (1943): [<ffffffe0003b3950>] mod_objcg_state mm/slab.h:296 [inline]
hardirqs last  enabled at (1943): [<ffffffe0003b3950>] memcg_slab_post_alloc_hook+0x2ea/0x46a mm/slab.h:327
hardirqs last disabled at (1944): [<ffffffe0001452ae>] generic_exec_single+0x1a2/0x212 kernel/smp.c:292
softirqs last  enabled at (1900): [<ffffffe0020f5fd2>] spin_unlock_bh include/linux/spinlock.h:399 [inline]
softirqs last  enabled at (1900): [<ffffffe0020f5fd2>] release_sock+0xf6/0x122 net/core/sock.c:3085
softirqs last disabled at (1898): [<ffffffe0020f5f06>] spin_lock_bh include/linux/spinlock.h:359 [inline]
softirqs last disabled at (1898): [<ffffffe0020f5f06>] release_sock+0x2a/0x122 net/core/sock.c:3072
---[ end trace 757ee55d225523fe ]---
------------[ cut here ]------------
WARNING: CPU: 1 PID: 8643 at kernel/events/core.c:3210 ctx_sched_out+0x312/0x548 kernel/events/core.c:3210
Modules linked in:
CPU: 1 PID: 8643 Comm: syz-executor.0 Tainted: G        W         5.12.0-rc8-syzkaller-00011-g18a3c5f7abfd #0
Hardware name: riscv-virtio,qemu (DT)
epc : ctx_sched_out+0x312/0x548 kernel/events/core.c:3210
 ra : ctx_sched_out+0x312/0x548 kernel/events/core.c:3210
epc : ffffffe00027ca5e ra : ffffffe00027ca5e sp : ffffffe00818fa90
 gp : ffffffe0045883c0 tp : ffffffe006dbaf80 t0 : ffffffc4010812b2
 t1 : 0000000000000001 t2 : 0000000000000000 s0 : ffffffe00818faf0
 s1 : ffffffe00aacfc00 a0 : ffffffe066d79118 a1 : 00000000000f0000
 a2 : ffffffd010ada000 a3 : ffffffe00027ca5e a4 : ffffffd010c9c740
 a5 : 00000000000384e8 a6 : 0000000000f00000 a7 : ffffffe00027d6ba
 s2 : ffffffe066d78f70 s3 : 0000000000000004 s4 : 0000000000000000
 s5 : 0000000000000000 s6 : ffffffe00aacfd40 s7 : 0000000000000000
 s8 : ffffffe006dbaf80 s9 : ffffffe00458c0d0 s10: 0000000000000000
 s11: 0000000000000000 t3 : 2699545dc3e5be00 t4 : ffffffc401031f97
 t5 : ffffffc401031f99 t6 : ffffffe00f58c1f4
status: 0000000000000100 badaddr: 0000000000000000 cause: 0000000000000003
Call Trace:
[<ffffffe00027ca5e>] ctx_sched_out+0x312/0x548 kernel/events/core.c:3210
[<ffffffe00027d7ee>] __perf_install_in_context+0x1f4/0x47c kernel/events/core.c:2799
[<ffffffe00026bcbc>] remote_function kernel/events/core.c:91 [inline]
[<ffffffe00026bcbc>] remote_function+0xa8/0xc0 kernel/events/core.c:71
[<ffffffe0001452b2>] generic_exec_single+0x1a6/0x212 kernel/smp.c:293
[<ffffffe000145452>] smp_call_function_single+0x134/0x2ba kernel/smp.c:513
[<ffffffe00026af46>] task_function_call+0x90/0xee kernel/events/core.c:119
[<ffffffe00027c5da>] perf_install_in_context+0x174/0x2e6 kernel/events/core.c:2902
[<ffffffe000288d1c>] __do_sys_perf_event_open+0x10ea/0x199e kernel/events/core.c:12169
[<ffffffe00028fa72>] sys_perf_event_open+0x34/0x46 kernel/events/core.c:11775
[<ffffffe000005578>] ret_from_syscall+0x0/0x2
irq event stamp: 1944
hardirqs last  enabled at (1943): [<ffffffe0003b3950>] mod_memcg_lruvec_state include/linux/memcontrol.h:979 [inline]
hardirqs last  enabled at (1943): [<ffffffe0003b3950>] mod_objcg_state mm/slab.h:296 [inline]
hardirqs last  enabled at (1943): [<ffffffe0003b3950>] memcg_slab_post_alloc_hook+0x2ea/0x46a mm/slab.h:327
hardirqs last disabled at (1944): [<ffffffe0001452ae>] generic_exec_single+0x1a2/0x212 kernel/smp.c:292
softirqs last  enabled at (1900): [<ffffffe0020f5fd2>] spin_unlock_bh include/linux/spinlock.h:399 [inline]
softirqs last  enabled at (1900): [<ffffffe0020f5fd2>] release_sock+0xf6/0x122 net/core/sock.c:3085
softirqs last disabled at (1898): [<ffffffe0020f5f06>] spin_lock_bh include/linux/spinlock.h:359 [inline]
softirqs last disabled at (1898): [<ffffffe0020f5f06>] release_sock+0x2a/0x122 net/core/sock.c:3072
---[ end trace 757ee55d225523ff ]---
------------[ cut here ]------------
WARNING: CPU: 1 PID: 8643 at kernel/events/core.c:2668 task_ctx_sched_out+0x5c/0x60 kernel/events/core.c:2668
Modules linked in:
CPU: 1 PID: 8643 Comm: syz-executor.0 Tainted: G        W         5.12.0-rc8-syzkaller-00011-g18a3c5f7abfd #0
Hardware name: riscv-virtio,qemu (DT)
epc : task_ctx_sched_out+0x5c/0x60 kernel/events/core.c:2668
 ra : task_ctx_sched_out+0x5c/0x60 kernel/events/core.c:2668
epc : ffffffe00027ccf0 ra : ffffffe00027ccf0 sp : ffffffe00818fa70
 gp : ffffffe0045883c0 tp : ffffffe006dbaf80 t0 : ffffffc4010812b2
 t1 : 0000000000000001 t2 : 0000000000000000 s0 : ffffffe00818faa0
 s1 : ffffffe066d78f70 a0 : ffffffe066d79118 a1 : 00000000000f0000
 a2 : ffffffd010ada000 a3 : ffffffe00027ccf0 a4 : 0000000000040000
 a5 : 0000000000040000 a6 : 0000000000f00000 a7 : ffffffe00027d6ba
 s2 : ffffffe00aacfc00 s3 : 0000000000000001 s4 : ffffffe00d98bc00
 s5 : ffffffe0050495a8 s6 : ffffffe00aacfc00 s7 : ffffffe00423cdc8
 s8 : 0000000000000000 s9 : ffffffe00458c0d0 s10: 0000000000000000
 s11: 0000000000000000 t3 : 2699545dc3e5be00 t4 : ffffffc401031f97
 t5 : ffffffc401031f99 t6 : ffffffe00f58c1f4
status: 0000000000000100 badaddr: 0000000000000000 cause: 0000000000000003
Call Trace:
[<ffffffe00027ccf0>] task_ctx_sched_out+0x5c/0x60 kernel/events/core.c:2668
[<ffffffe00027cdca>] ctx_resched+0xd6/0x1ba kernel/events/core.c:2719
[<ffffffe00027d80e>] __perf_install_in_context+0x214/0x47c kernel/events/core.c:2801
[<ffffffe00026bcbc>] remote_function kernel/events/core.c:91 [inline]
[<ffffffe00026bcbc>] remote_function+0xa8/0xc0 kernel/events/core.c:71
[<ffffffe0001452b2>] generic_exec_single+0x1a6/0x212 kernel/smp.c:293
[<ffffffe000145452>] smp_call_function_single+0x134/0x2ba kernel/smp.c:513
[<ffffffe00026af46>] task_function_call+0x90/0xee kernel/events/core.c:119
[<ffffffe00027c5da>] perf_install_in_context+0x174/0x2e6 kernel/events/core.c:2902
[<ffffffe000288d1c>] __do_sys_perf_event_open+0x10ea/0x199e kernel/events/core.c:12169
[<ffffffe00028fa72>] sys_perf_event_open+0x34/0x46 kernel/events/core.c:11775
[<ffffffe000005578>] ret_from_syscall+0x0/0x2
irq event stamp: 1944
hardirqs last  enabled at (1943): [<ffffffe0003b3950>] mod_memcg_lruvec_state include/linux/memcontrol.h:979 [inline]
hardirqs last  enabled at (1943): [<ffffffe0003b3950>] mod_objcg_state mm/slab.h:296 [inline]
hardirqs last  enabled at (1943): [<ffffffe0003b3950>] memcg_slab_post_alloc_hook+0x2ea/0x46a mm/slab.h:327
hardirqs last disabled at (1944): [<ffffffe0001452ae>] generic_exec_single+0x1a2/0x212 kernel/smp.c:292
softirqs last  enabled at (1900): [<ffffffe0020f5fd2>] spin_unlock_bh include/linux/spinlock.h:399 [inline]
softirqs last  enabled at (1900): [<ffffffe0020f5fd2>] release_sock+0xf6/0x122 net/core/sock.c:3085
softirqs last disabled at (1898): [<ffffffe0020f5f06>] spin_lock_bh include/linux/spinlock.h:359 [inline]
softirqs last disabled at (1898): [<ffffffe0020f5f06>] release_sock+0x2a/0x122 net/core/sock.c:3072
---[ end trace 757ee55d22552400 ]---


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
