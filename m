Return-Path: <bpf+bounces-66750-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D36E9B38F69
	for <lists+bpf@lfdr.de>; Thu, 28 Aug 2025 01:56:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8FC927AB6B1
	for <lists+bpf@lfdr.de>; Wed, 27 Aug 2025 23:55:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2132C3101A9;
	Wed, 27 Aug 2025 23:56:30 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-io1-f79.google.com (mail-io1-f79.google.com [209.85.166.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4263327A919
	for <bpf@vger.kernel.org>; Wed, 27 Aug 2025 23:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756338989; cv=none; b=Ig25MXUDKvFaq2PQ6SejXfuaU+le76TpiDgp2aFORLAbADWBYejODjmqepL8NLQQSvgCvY7TCrMJ34jZSNGs4qZxNyJmbSBNr7nELaBoUGWmhgbt4ETXodXyg0K+LpBVp9ldFdDo061mQtvWEoB18Zhw8Rb76kUKfAc4N26gJ8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756338989; c=relaxed/simple;
	bh=hzHwndWEpS0xTFzEybcfdp9UUiSixkUsYAWoAuFCkvw=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=LXqQ9BaAi0Y71L0Wm6pB3p4vQt4FVb+HKXyC7cFK6od9+egkKrr87LUFS0w/iOV/hSuK6zquSmrVVTy92FZsWdzNYU6Q2+BlTLd3Gc09wzo7L7On8wehCIPdvk4I/f9t5OUGk16Njt1dk9Yes7XmcRXp4hGedVjrKqRoj0kfbgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f79.google.com with SMTP id ca18e2360f4ac-886e3612570so40537739f.2
        for <bpf@vger.kernel.org>; Wed, 27 Aug 2025 16:56:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756338987; x=1756943787;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XhWQ9iGoM04g6lfAV7PCS2cBnF3cJ7MMLrdxlmgfU58=;
        b=ANJxcrxrT51BmSgKtRiJK5i4GV6CySeE1vzgkCs+221FwiiBsPIfl9E6muGq6IyEXm
         cCKRPhbOnjU/3twviHSHAyiZl/XDF6gJJTTUWjr3spi+gLZuGSAg1/atKr6qSRii0RS1
         LK/dARf3rJhULRmgdDy88K2utYPAiXZLSxnxgBnM/1Eawy/fwcQj4EHoSeUoj8T4YFUu
         mMLTl7cptBlMvIpw04uwH20Lx3Ck1gmoCq4SHP6SWB16WKM9mGinDkuhaXINO03jBU3Z
         F1JbUhU7B0BSY7uZGbq9oJZSp+IICqgGjJaDI0c0DWAX/jKK0qwCqt8WfV+h6I6n1x3/
         Am4w==
X-Forwarded-Encrypted: i=1; AJvYcCUnincS+E4cAm/Rto1LduqDWk82pyIpXG525aax3aU3eAQmC5wcJcFqu4x7pA4Q72dQxdg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbiPkubINXUjZUvzeH7w+dRrSMggFM5QimKlKVHXNYcbQRQI36
	kZa8zx2NEBkyrnLAEn399shK3hU8ETEJ/mfz5yVaHZlbzDCPEyaI6czpLwnFLhEwiw9qXcGw2pk
	YuLoErnSn87dkytm/5Sk3OFBJu56NbQynx+CSP7RrqXm+XB+XptOMxDg/gUo=
X-Google-Smtp-Source: AGHT+IHYTpCmTA9elqP3yQfROErw/tzlU6n6h5Za5qE+Y2KuAVEcc+6LONSRIgaB18ds0rawccpxgaGQwtGeymsNR5DgDbYgYjeS
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3e02:b0:3ec:2275:244c with SMTP id
 e9e14a558f8ab-3ec22752632mr192176585ab.0.1756338987431; Wed, 27 Aug 2025
 16:56:27 -0700 (PDT)
Date: Wed, 27 Aug 2025 16:56:27 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68af9b2b.a00a0220.2929dc.0008.GAE@google.com>
Subject: [syzbot] [bpf?] [net?] BUG: sleeping function called from invalid
 context in sock_map_delete_elem
From: syzbot <syzbot+1f1fbecb9413cdbfbef8@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, davem@davemloft.net, eddyz87@gmail.com, 
	edumazet@google.com, haoluo@google.com, horms@kernel.org, 
	john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, martin.lau@linux.dev, 
	netdev@vger.kernel.org, pabeni@redhat.com, sdf@fomichev.me, song@kernel.org, 
	syzkaller-bugs@googlegroups.com, yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    8d245acc1e88 Merge tag 'char-misc-6.17-rc3' of git://git.k..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11513062580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e1e1566c7726877e
dashboard link: https://syzkaller.appspot.com/bug?extid=1f1fbecb9413cdbfbef8
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=109d7062580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=126bea34580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/096739d8f0ec/disk-8d245acc.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/83a21aa9b978/vmlinux-8d245acc.xz
kernel image: https://storage.googleapis.com/syzbot-assets/7e7f165a3b29/bzImage-8d245acc.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+1f1fbecb9413cdbfbef8@syzkaller.appspotmail.com

BUG: sleeping function called from invalid context at kernel/locking/spinlock_rt.c:48
in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 6107, name: syz.0.17
preempt_count: 1, expected: 0
RCU nest depth: 1, expected: 1
3 locks held by syz.0.17/6107:
 #0: ffffffff8d9a8b80 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:331 [inline]
 #0: ffffffff8d9a8b80 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:841 [inline]
 #0: ffffffff8d9a8b80 (rcu_read_lock){....}-{1:3}, at: bpf_test_timer_enter+0x1a/0x140 net/bpf/test_run.c:40
 #1: ffffffff8d84a760 (local_bh){.+.+}-{1:3}, at: __local_bh_disable_ip+0xa1/0x400 kernel/softirq.c:163
 #2: ffff888032e15a98 (&stab->lock){+...}-{3:3}, at: spin_lock_bh include/linux/spinlock_rt.h:88 [inline]
 #2: ffff888032e15a98 (&stab->lock){+...}-{3:3}, at: __sock_map_delete net/core/sock_map.c:421 [inline]
 #2: ffff888032e15a98 (&stab->lock){+...}-{3:3}, at: sock_map_delete_elem+0xb7/0x170 net/core/sock_map.c:452
Preemption disabled at:
[<ffffffff891fce58>] bpf_test_timer_enter+0xf8/0x140 net/bpf/test_run.c:42
CPU: 0 UID: 0 PID: 6107 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT_{RT,(full)} 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2025
Call Trace:
 <TASK>
 dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
 __might_resched+0x44b/0x5d0 kernel/sched/core.c:8957
 __rt_spin_lock kernel/locking/spinlock_rt.c:48 [inline]
 rt_spin_lock+0xc7/0x2c0 kernel/locking/spinlock_rt.c:57
 spin_lock_bh include/linux/spinlock_rt.h:88 [inline]
 __sock_map_delete net/core/sock_map.c:421 [inline]
 sock_map_delete_elem+0xb7/0x170 net/core/sock_map.c:452
 bpf_prog_2c29ac5cdc6b1842+0x43/0x4b
 bpf_dispatcher_nop_func include/linux/bpf.h:1332 [inline]
 __bpf_prog_run include/linux/filter.h:718 [inline]
 bpf_prog_run include/linux/filter.h:725 [inline]
 bpf_prog_run_pin_on_cpu include/linux/filter.h:742 [inline]
 bpf_flow_dissect+0x132/0x400 net/core/flow_dissector.c:1024
 bpf_prog_test_run_flow_dissector+0x37c/0x5c0 net/bpf/test_run.c:1416
 bpf_prog_test_run+0x2ca/0x340 kernel/bpf/syscall.c:4590
 __sys_bpf+0x581/0x870 kernel/bpf/syscall.c:6047
 __do_sys_bpf kernel/bpf/syscall.c:6139 [inline]
 __se_sys_bpf kernel/bpf/syscall.c:6137 [inline]
 __x64_sys_bpf+0x7c/0x90 kernel/bpf/syscall.c:6137
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f637004ebe9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fffc4e2e8a8 EFLAGS: 00000246 ORIG_RAX: 0000000000000141
RAX: ffffffffffffffda RBX: 00007f6370275fa0 RCX: 00007f637004ebe9
RDX: 0000000000000050 RSI: 0000200000000180 RDI: 000000000000000a
RBP: 00007f63700d1e19 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f6370275fa0 R14: 00007f6370275fa0 R15: 0000000000000003
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

