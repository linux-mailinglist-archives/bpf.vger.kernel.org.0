Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4214947D92E
	for <lists+bpf@lfdr.de>; Wed, 22 Dec 2021 23:13:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238079AbhLVWNS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 22 Dec 2021 17:13:18 -0500
Received: from mail-io1-f69.google.com ([209.85.166.69]:55057 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229769AbhLVWNS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 22 Dec 2021 17:13:18 -0500
Received: by mail-io1-f69.google.com with SMTP id s8-20020a056602168800b005e96bba1363so2031550iow.21
        for <bpf@vger.kernel.org>; Wed, 22 Dec 2021 14:13:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=f/bM15rE1P3oiPUnfpraP5G6wa3R2qGfubVJB9H598U=;
        b=IZ+HdPiyX4ICFXmFK+fGKH9NxYxvlC1wbC6uOwFgi2Ml04RpIjMtT8wbZQ+D73osLF
         pVizy/uaeIPnlCwP+dh53ZoDCcaCdfv/E/DkczivZvdkXwheC5qWg3kBKLBkycRlBzNq
         qxD3kFpHzHIGevCRIZtPRLkw/5uQUb1wZYVX605r0ZLnaXHo2ELVrab/WVzHZ4ybopFu
         my2LknmpPhFCqxcFWB6nIeSyvP5ik4x8c5l+lyL4pMiDhHsjS3kFwLGy0vopybPCCc+6
         D/XTy+VWYYiCLnzIdSQf7bp5IDz1TQ9hviErcLpuZbF3DioTVfAfctcvGhrQvCJzo3dD
         kRWQ==
X-Gm-Message-State: AOAM530Dg4edlOgBBeky8G3UKO8B5UCAUWbzBD2UdJTJxn/SJdmf6Drg
        nsZdNm5fVXj6kADANextIO1//96s+rDcbryEseRfMMG0KOXa
X-Google-Smtp-Source: ABdhPJzSy2IJuEdD5OgvrhTE12dPDNF/iA4nDreUkcZKOKiFQ3kkVmr7ygItBaZzv1rwqTjk2Zkjd7YqxNWLaOCJqxvpMkgPmd7f
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:170c:: with SMTP id u12mr1884027ill.53.1640211197826;
 Wed, 22 Dec 2021 14:13:17 -0800 (PST)
Date:   Wed, 22 Dec 2021 14:13:17 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000cd9d6f05d3c36ddc@google.com>
Subject: [syzbot] INFO: task hung in cgroup_can_fork
From:   syzbot <syzbot+304cbc9725238275b855@syzkaller.appspotmail.com>
To:     andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
        cgroups@vger.kernel.org, christian@brauner.io,
        daniel@iogearbox.net, hannes@cmpxchg.org, john.fastabend@gmail.com,
        kafai@fb.com, kpsingh@kernel.org, linux-kernel@vger.kernel.org,
        lizefan.x@bytedance.com, netdev@vger.kernel.org,
        songliubraving@fb.com, syzkaller-bugs@googlegroups.com,
        tj@kernel.org, yhs@fb.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    9eaa88c7036e Merge tag 'libata-5.16-rc6' of git://git.kern..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11872543b00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=fa556098924b78f0
dashboard link: https://syzkaller.appspot.com/bug?extid=304cbc9725238275b855
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=154716a3b00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=111e92dbb00000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+304cbc9725238275b855@syzkaller.appspotmail.com

INFO: task syz-executor812:3663 blocked for more than 165 seconds.
      Not tainted 5.16.0-rc5-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor812 state:D stack:27552 pid: 3663 ppid:  3654 flags:0x00000000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:4972 [inline]
 context_switch kernel/sched/core.c:4972 [inline] kernel/sched/core.c:6253
 __schedule+0xa9a/0x4940 kernel/sched/core.c:6253 kernel/sched/core.c:6253
 schedule+0xd2/0x260 kernel/sched/core.c:6326 kernel/sched/core.c:6326
 schedule_preempt_disabled+0xf/0x20 kernel/sched/core.c:6385 kernel/sched/core.c:6385
 __mutex_lock_common kernel/locking/mutex.c:680 [inline]
 __mutex_lock_common kernel/locking/mutex.c:680 [inline] kernel/locking/mutex.c:740
 __mutex_lock+0xa32/0x12f0 kernel/locking/mutex.c:740 kernel/locking/mutex.c:740
 cgroup_css_set_fork kernel/cgroup/cgroup.c:6090 [inline]
 cgroup_css_set_fork kernel/cgroup/cgroup.c:6090 [inline] kernel/cgroup/cgroup.c:6206
 cgroup_can_fork+0x888/0xeb0 kernel/cgroup/cgroup.c:6206 kernel/cgroup/cgroup.c:6206
 copy_process+0x3636/0x75a0 kernel/fork.c:2292 kernel/fork.c:2292
 kernel_clone+0xe7/0xab0 kernel/fork.c:2582 kernel/fork.c:2582
 __do_sys_clone3+0x1ca/0x2e0 kernel/fork.c:2857 kernel/fork.c:2857
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_x64 arch/x86/entry/common.c:50 [inline] arch/x86/entry/common.c:80
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7fbc074509a9
RSP: 002b:00007fbc074022f8 EFLAGS: 00000246 ORIG_RAX: 00000000000001b3
RAX: ffffffffffffffda RBX: 0000000000000031 RCX: 00007fbc074509a9
RDX: 00007fbc074509a9 RSI: 0000000000000058 RDI: 0000000020000080
RBP: 00007fbc074d8408 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007fbc074d8400
R13: 00007fbc074d840c R14: 00007fbc074a6074 R15: 0000000280000000
 </TASK>
INFO: task syz-executor812:3664 blocked for more than 172 seconds.
      Not tainted 5.16.0-rc5-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor812 state:D stack:27552 pid: 3664 ppid:     1 flags:0x00000000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:4972 [inline]
 context_switch kernel/sched/core.c:4972 [inline] kernel/sched/core.c:6253
 __schedule+0xa9a/0x4940 kernel/sched/core.c:6253 kernel/sched/core.c:6253
 schedule+0xd2/0x260 kernel/sched/core.c:6326 kernel/sched/core.c:6326
 schedule_preempt_disabled+0xf/0x20 kernel/sched/core.c:6385 kernel/sched/core.c:6385
 __mutex_lock_common kernel/locking/mutex.c:680 [inline]
 __mutex_lock_common kernel/locking/mutex.c:680 [inline] kernel/locking/mutex.c:740
 __mutex_lock+0xa32/0x12f0 kernel/locking/mutex.c:740 kernel/locking/mutex.c:740


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
