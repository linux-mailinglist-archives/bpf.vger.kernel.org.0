Return-Path: <bpf+bounces-38077-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EF8295F228
	for <lists+bpf@lfdr.de>; Mon, 26 Aug 2024 14:55:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45D452835FD
	for <lists+bpf@lfdr.de>; Mon, 26 Aug 2024 12:55:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1141A17C9B5;
	Mon, 26 Aug 2024 12:52:22 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B76A17C9B0
	for <bpf@vger.kernel.org>; Mon, 26 Aug 2024 12:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724676741; cv=none; b=EIEh/SVzCETjZLnTo4DaMF+zlQg+RDvluF6TL9A1FNomwYwx20VragdlnhwFMRZL9ECy52V4WwnJcz7YXmkXfMJqvE2JsvBXSG6mzybd8mho62KzU14IaMfDE/hEoA+hRDa5lxi75moPObRAikki33MoLDwzhJDV3Mu6LYtLoNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724676741; c=relaxed/simple;
	bh=iewPIKWwxjnmmShXWzD5eMbFV7rnrhci/Hk0xB9wvw8=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=ks4WNbAb5PscsqFyfkTKZI3kJRIIOt20BFhUpBZhiMqk1u5+Oc+CZFGaE680HLd7TAKkbe9UvsO7TFBr8QRnYscW7FSxHT/j5TdVlQa1mSqKt0PZis4bpI+y/pw3C7Ph96W47m/xxkthyIFYhL1NCmTP4elkVUFhtK3KGsFV+kE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-39d4c656946so52518695ab.1
        for <bpf@vger.kernel.org>; Mon, 26 Aug 2024 05:52:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724676739; x=1725281539;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yhLXBV41EvVRxq0pyiOc1zrWFwcXv7kRA5fXB2u90mg=;
        b=GVvU2YAr/93mSAZxYy3GboJdBlrJwe6nher2lS7pAYTOS0plXWeoMWrKLoVJJLISaG
         L1cLhuVNddyGRms5msxrKR7LhJ9ZbxSxpSxBRO99ero6RxMTTZu3nQ5LJEh87Gl6Guux
         mZR8CCWMBZ+7/c5m6FAw9aYEM9koi4tRb/kjKR4Gu5FL+JRjN3T8kks9Qv94FwX0zMVt
         TbLXDXG5hwfGyP2jHw2ISllOXkbacIruNiRD8YEhWiRjMyrJnRYTpxw+Vy3zJs5J4T+V
         fNgFUmg9WvaTfnKNYvgQkRjXCvSN0gnEedf5Cu4tAbWj5zw3JnR2HtkFEdmN6BVb1IIC
         Xz8g==
X-Forwarded-Encrypted: i=1; AJvYcCU8gBVtcOju+UPw0rBBCkQskUmO/pbvr2JKIjcY1a37Jb4I8hK3vCpPt780kGR5ZpU+xJg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzz6f+5G2HIxo/EYgX8w5Pogbok4gha11Le7GSn0dXEOv/zSLhP
	ZjfdXn2jhmnGaBPblBwBWGm2TdfhCIobVy1vYbN4nJD9o9jT7KbSwIssr8BUnTnvI0NYTifpVLm
	L7/KQUnIlbr/bALK28uFbp92V/3n03Vzm3Y1cR1Up/+QFYpRndGpDVbc=
X-Google-Smtp-Source: AGHT+IHJ39gp+EnjPi6uHTN0u9WeqDEqRBpSQB3idE7i4A9GHa4RS6R179Kowo9wzYygVvoiKtBfMht1Xh+SpdxWXecCN+aJE2p9
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d9c:b0:39d:300f:e911 with SMTP id
 e9e14a558f8ab-39e3c98359cmr9506465ab.2.1724676739248; Mon, 26 Aug 2024
 05:52:19 -0700 (PDT)
Date: Mon, 26 Aug 2024 05:52:19 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000654086062095987d@google.com>
Subject: [syzbot] [bpf?] [trace?] WARNING in bpf_get_stack_raw_tp
From: syzbot <syzbot+ce35de20ed6652f60652@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, eddyz87@gmail.com, haoluo@google.com, 
	john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	martin.lau@linux.dev, mathieu.desnoyers@efficios.com, 
	mattbobrowski@google.com, mhiramat@kernel.org, netdev@vger.kernel.org, 
	rostedt@goodmis.org, sdf@fomichev.me, song@kernel.org, 
	syzkaller-bugs@googlegroups.com, yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    872cf28b8df9 Merge tag 'platform-drivers-x86-v6.11-4' of g..
git tree:       bpf
console output: https://syzkaller.appspot.com/x/log.txt?x=1628ae09980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=df2f0ed7e30a639d
dashboard link: https://syzkaller.appspot.com/bug?extid=ce35de20ed6652f60652
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1439fbf5980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14b5382b980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/72b6e311a539/disk-872cf28b.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/0c44549e5bb0/vmlinux-872cf28b.xz
kernel image: https://storage.googleapis.com/syzbot-assets/fb02c268f118/bzImage-872cf28b.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+ce35de20ed6652f60652@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 0 PID: 5229 at kernel/trace/bpf_trace.c:1917 get_bpf_raw_tp_regs kernel/trace/bpf_trace.c:1917 [inline]
WARNING: CPU: 0 PID: 5229 at kernel/trace/bpf_trace.c:1917 ____bpf_get_stack_raw_tp kernel/trace/bpf_trace.c:1990 [inline]
WARNING: CPU: 0 PID: 5229 at kernel/trace/bpf_trace.c:1917 bpf_get_stack_raw_tp+0x1c9/0x240 kernel/trace/bpf_trace.c:1987
Modules linked in:
CPU: 0 UID: 0 PID: 5229 Comm: syz-executor357 Not tainted 6.11.0-rc4-syzkaller-g872cf28b8df9 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/06/2024
RIP: 0010:get_bpf_raw_tp_regs kernel/trace/bpf_trace.c:1917 [inline]
RIP: 0010:____bpf_get_stack_raw_tp kernel/trace/bpf_trace.c:1990 [inline]
RIP: 0010:bpf_get_stack_raw_tp+0x1c9/0x240 kernel/trace/bpf_trace.c:1987
Code: 6d ee 1e 00 65 ff 0d 96 86 64 7e 4c 63 f0 4c 89 f0 48 83 c4 18 5b 41 5c 41 5d 41 5e 41 5f 5d c3 cc cc cc cc e8 88 ad f4 ff 90 <0f> 0b 90 65 ff 0d 6d 86 64 7e 49 c7 c6 f0 ff ff ff eb d1 44 89 e9
RSP: 0018:ffffc900020de6f0 EFLAGS: 00010293
RAX: ffffffff819eddb8 RBX: 0000000000000003 RCX: ffff88807dae0000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 00000000fffffffc
RBP: ffffc900020de730 R08: ffffffff819edc87 R09: 1ffffffff26e6708
R10: dffffc0000000000 R11: ffffffffa0001c68 R12: ffff8880b9236238
R13: 0000000000000902 R14: 0000000000000000 R15: ffffc900020de748
FS:  0000555580bbc380(0000) GS:ffff8880b9200000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f7721d2f110 CR3: 000000002f1be000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 bpf_prog_e6cf5f9c69743609+0x42/0x46
 bpf_dispatcher_nop_func include/linux/bpf.h:1243 [inline]
 __bpf_prog_run include/linux/filter.h:691 [inline]
 bpf_prog_run include/linux/filter.h:698 [inline]
 __bpf_trace_run kernel/trace/bpf_trace.c:2406 [inline]
 bpf_trace_run4+0x334/0x590 kernel/trace/bpf_trace.c:2449
 __traceiter_mmap_lock_acquire_returned+0x93/0xf0 include/trace/events/mmap_lock.h:52
 trace_mmap_lock_acquire_returned include/trace/events/mmap_lock.h:52 [inline]
 __mmap_lock_do_trace_acquire_returned+0x286/0x2f0 mm/mmap_lock.c:102
 __mmap_lock_trace_acquire_returned include/linux/mmap_lock.h:36 [inline]
 mmap_read_trylock include/linux/mmap_lock.h:164 [inline]
 stack_map_get_build_id_offset+0x9af/0x9d0 kernel/bpf/stackmap.c:141
 __bpf_get_stack+0x4ad/0x5a0 kernel/bpf/stackmap.c:449
 ____bpf_get_stack_raw_tp kernel/trace/bpf_trace.c:1997 [inline]
 bpf_get_stack_raw_tp+0x1a3/0x240 kernel/trace/bpf_trace.c:1987
 bpf_prog_e6cf5f9c69743609+0x42/0x46
 bpf_dispatcher_nop_func include/linux/bpf.h:1243 [inline]
 __bpf_prog_run include/linux/filter.h:691 [inline]
 bpf_prog_run include/linux/filter.h:698 [inline]
 __bpf_trace_run kernel/trace/bpf_trace.c:2406 [inline]
 bpf_trace_run4+0x334/0x590 kernel/trace/bpf_trace.c:2449
 __traceiter_mmap_lock_acquire_returned+0x93/0xf0 include/trace/events/mmap_lock.h:52
 trace_mmap_lock_acquire_returned include/trace/events/mmap_lock.h:52 [inline]
 __mmap_lock_do_trace_acquire_returned+0x286/0x2f0 mm/mmap_lock.c:102
 __mmap_lock_trace_acquire_returned include/linux/mmap_lock.h:36 [inline]
 mmap_read_trylock include/linux/mmap_lock.h:164 [inline]
 stack_map_get_build_id_offset+0x9af/0x9d0 kernel/bpf/stackmap.c:141
 __bpf_get_stack+0x4ad/0x5a0 kernel/bpf/stackmap.c:449
 ____bpf_get_stack_raw_tp kernel/trace/bpf_trace.c:1997 [inline]
 bpf_get_stack_raw_tp+0x1a3/0x240 kernel/trace/bpf_trace.c:1987
 bpf_prog_e6cf5f9c69743609+0x42/0x46
 bpf_dispatcher_nop_func include/linux/bpf.h:1243 [inline]
 __bpf_prog_run include/linux/filter.h:691 [inline]
 bpf_prog_run include/linux/filter.h:698 [inline]
 __bpf_trace_run kernel/trace/bpf_trace.c:2406 [inline]
 bpf_trace_run4+0x334/0x590 kernel/trace/bpf_trace.c:2449
 __traceiter_mmap_lock_acquire_returned+0x93/0xf0 include/trace/events/mmap_lock.h:52
 trace_mmap_lock_acquire_returned include/trace/events/mmap_lock.h:52 [inline]
 __mmap_lock_do_trace_acquire_returned+0x286/0x2f0 mm/mmap_lock.c:102
 __mmap_lock_trace_acquire_returned include/linux/mmap_lock.h:36 [inline]
 mmap_read_trylock include/linux/mmap_lock.h:164 [inline]
 stack_map_get_build_id_offset+0x9af/0x9d0 kernel/bpf/stackmap.c:141
 __bpf_get_stack+0x4ad/0x5a0 kernel/bpf/stackmap.c:449
 ____bpf_get_stack_raw_tp kernel/trace/bpf_trace.c:1997 [inline]
 bpf_get_stack_raw_tp+0x1a3/0x240 kernel/trace/bpf_trace.c:1987
 bpf_prog_e6cf5f9c69743609+0x42/0x46
 bpf_dispatcher_nop_func include/linux/bpf.h:1243 [inline]
 __bpf_prog_run include/linux/filter.h:691 [inline]
 bpf_prog_run include/linux/filter.h:698 [inline]
 __bpf_trace_run kernel/trace/bpf_trace.c:2406 [inline]
 bpf_trace_run4+0x334/0x590 kernel/trace/bpf_trace.c:2449
 __traceiter_mmap_lock_acquire_returned+0x93/0xf0 include/trace/events/mmap_lock.h:52
 trace_mmap_lock_acquire_returned include/trace/events/mmap_lock.h:52 [inline]
 __mmap_lock_do_trace_acquire_returned+0x286/0x2f0 mm/mmap_lock.c:102
 __mmap_lock_trace_acquire_returned include/linux/mmap_lock.h:36 [inline]
 mmap_read_lock include/linux/mmap_lock.h:145 [inline]
 acct_collect+0x804/0x830 kernel/acct.c:563
 do_exit+0x93e/0x27f0 kernel/exit.c:861
 do_group_exit+0x207/0x2c0 kernel/exit.c:1031
 __do_sys_exit_group kernel/exit.c:1042 [inline]
 __se_sys_exit_group kernel/exit.c:1040 [inline]
 __x64_sys_exit_group+0x3f/0x40 kernel/exit.c:1040
 x64_sys_call+0x2634/0x2640 arch/x86/include/generated/asm/syscalls_64.h:232
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f7721cb3389
Code: 90 49 c7 c0 b8 ff ff ff be e7 00 00 00 ba 3c 00 00 00 eb 12 0f 1f 44 00 00 89 d0 0f 05 48 3d 00 f0 ff ff 77 1c f4 89 f0 0f 05 <48> 3d 00 f0 ff ff 76 e7 f7 d8 64 41 89 00 eb df 0f 1f 80 00 00 00
RSP: 002b:00007fff639ca6c8 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f7721cb3389
RDX: 000000000000003c RSI: 00000000000000e7 RDI: 0000000000000000
RBP: 00007f7721d2e2b0 R08: ffffffffffffffb8 R09: 0000000080bbd610
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f7721d2e2b0
R13: 0000000000000000 R14: 00007f7721d2ed00 R15: 00007f7721c845c0
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

