Return-Path: <bpf+bounces-27072-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C3E5C8A8DD6
	for <lists+bpf@lfdr.de>; Wed, 17 Apr 2024 23:25:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1E62BB21618
	for <lists+bpf@lfdr.de>; Wed, 17 Apr 2024 21:25:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3892684E00;
	Wed, 17 Apr 2024 21:25:21 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 859FD657CE
	for <bpf@vger.kernel.org>; Wed, 17 Apr 2024 21:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713389120; cv=none; b=gMlTpznMPF9AJXuKSVrW4S+fQUxCHlq9hEvOrjDGPNb3pzipbmP9xzP/JvYJBIKMfAbvU83yfaN9vQxnqs27am8NSgScjKhooXOwIFjorOKgDBSgIYg/GHOm3sU6TU3V9jIGYd83t4E3xwhWz2efU8DB8GvzhZu+kK+zDFseStM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713389120; c=relaxed/simple;
	bh=zuepX+b7EKccYFICDr9JFMM45fMCuiGRrgqD3FvuPuo=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=UhbHJjIZ4KLIy8qT/KNCB2xjT0FljUNuMmFrzkWEEfkVLzoloKBC34gnEYg8iqz/RcPNnxsuxwOIBFYsQFaVYETBMFuExu4d9Cw4Xl6aEcvCdh00LPdfcBwbNMlbTAMwaKeoohTYQyycDGXmQ8o5oY0F3L3bGoI2u+MoMP62iiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7d5e9c1232dso26868139f.0
        for <bpf@vger.kernel.org>; Wed, 17 Apr 2024 14:25:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713389118; x=1713993918;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NZC1n+8WGjMqyH8/u1eDu2rBP2vWkCU5Eb2xBcQ2Ems=;
        b=pVx9TgybuO2PyxoADbEIfOCeRjKD4opTuB8N+rhkp6LThtdLJ2/YrqYzJwz9Dm7id4
         /0d4+2t8fDVJlleAnrp2Dfm4hnANjpgq9YB+6BkEz+GUiepO43jY5rRAA5vWFGEU9MMX
         tuc+H/RQPhgHrBw+lXeJwFcEydQoqWIxX3J0S0UEF4DwzZuWjSw0SETkevH4XDP30Slu
         lqJsfLItzzpawYm3EbbPcZ6xZo01j3tlNzGTRT+FX4gGq+k/hexkAJ4gtwCW48ko7Ejk
         t7D+cenuA3XJAYBw3i/snaCDzmSwxtXkjQg4hLaZCvuUd75OWiN8BExhDdFnfOZjb9gj
         lmKQ==
X-Forwarded-Encrypted: i=1; AJvYcCULhEF7H1cTYTFesEt6Q5mbO+FDYgQ9A3RqR3BrO292Mmq+OBFri2t0NhnNwx3J1gB1cPw98MaIcOuIXjM+eNtM352c
X-Gm-Message-State: AOJu0Yyz0Ea1fRG3ZRHIXJIB+L8wsQske05Xr0/SGT0LpfsDNWvbzOW+
	oSDYlarqHUITsa3KRNxHy/+TfiZJS3kaxwGNf5JWRm5q+kYKcqfpDB4glq8TC3886eaqgXaSrbj
	cb+amWcsTtekww/vVN1/FwrW5M4zuhCiwczA0w+VJ1tLpjXD2r79yRik=
X-Google-Smtp-Source: AGHT+IEcAonNlyOsc37A+w0t0RMsyKGFJTXKMMgJEWjKcrfDPZ8Qso5N+f8+1P8NgMUaG7Z9bw0hofRq2zF3SHWQg4ULgIf1ICvw
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:4112:b0:482:f323:b373 with SMTP id
 ay18-20020a056638411200b00482f323b373mr22113jab.2.1713389118683; Wed, 17 Apr
 2024 14:25:18 -0700 (PDT)
Date: Wed, 17 Apr 2024 14:25:18 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c80abd0616517df9@google.com>
Subject: [syzbot] [bpf?] possible deadlock in queue_stack_map_push_elem
From: syzbot <syzbot+252bc5c744d0bba917e1@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, eddyz87@gmail.com, haoluo@google.com, 
	john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org, 
	linux-kernel@vger.kernel.org, martin.lau@linux.dev, netdev@vger.kernel.org, 
	sdf@google.com, song@kernel.org, syzkaller-bugs@googlegroups.com, 
	yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    f99c5f563c17 Merge tag 'nf-24-03-21' of git://git.kernel.o..
git tree:       net
console+strace: https://syzkaller.appspot.com/x/log.txt?x=14ee6467180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6fb1be60a193d440
dashboard link: https://syzkaller.appspot.com/bug?extid=252bc5c744d0bba917e1
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=157093d5180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1039a7cb180000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/65d3f3eb786e/disk-f99c5f56.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/799cf7f28ff8/vmlinux-f99c5f56.xz
kernel image: https://storage.googleapis.com/syzbot-assets/ab26c60c3845/bzImage-f99c5f56.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+252bc5c744d0bba917e1@syzkaller.appspotmail.com

============================================
WARNING: possible recursive locking detected
6.8.0-syzkaller-05271-gf99c5f563c17 #0 Not tainted
--------------------------------------------
syz-executor327/5092 is trying to acquire lock:
ffff8880754591d8 (&qs->lock){-.-.}-{2:2}, at: queue_stack_map_push_elem+0x1b2/0x660 kernel/bpf/queue_stack_maps.c:210

but task is already holding lock:
ffff8880153871d8 (&qs->lock){-.-.}-{2:2}, at: queue_stack_map_push_elem+0x1b2/0x660 kernel/bpf/queue_stack_maps.c:210

other info that might help us debug this:
 Possible unsafe locking scenario:

       CPU0
       ----
  lock(&qs->lock);
  lock(&qs->lock);

 *** DEADLOCK ***

 May be due to missing lock nesting notation

4 locks held by syz-executor327/5092:
 #0: ffffffff8e1dacc8 (delayed_uprobe_lock){+.+.}-{3:3}, at: uprobe_clear_state+0x54/0x290 kernel/events/uprobes.c:1545
 #1: ffffffff8e131920 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:329 [inline]
 #1: ffffffff8e131920 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:781 [inline]
 #1: ffffffff8e131920 (rcu_read_lock){....}-{1:2}, at: __bpf_trace_run kernel/trace/bpf_trace.c:2380 [inline]
 #1: ffffffff8e131920 (rcu_read_lock){....}-{1:2}, at: bpf_trace_run2+0x114/0x420 kernel/trace/bpf_trace.c:2420
 #2: ffff8880153871d8 (&qs->lock){-.-.}-{2:2}, at: queue_stack_map_push_elem+0x1b2/0x660 kernel/bpf/queue_stack_maps.c:210
 #3: ffffffff8e131920 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:329 [inline]
 #3: ffffffff8e131920 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:781 [inline]
 #3: ffffffff8e131920 (rcu_read_lock){....}-{1:2}, at: __bpf_trace_run kernel/trace/bpf_trace.c:2380 [inline]
 #3: ffffffff8e131920 (rcu_read_lock){....}-{1:2}, at: bpf_trace_run2+0x114/0x420 kernel/trace/bpf_trace.c:2420

stack backtrace:
CPU: 0 PID: 5092 Comm: syz-executor327 Not tainted 6.8.0-syzkaller-05271-gf99c5f563c17 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1e7/0x2e0 lib/dump_stack.c:106
 check_deadlock kernel/locking/lockdep.c:3062 [inline]
 validate_chain+0x15c1/0x58e0 kernel/locking/lockdep.c:3856
 __lock_acquire+0x1346/0x1fd0 kernel/locking/lockdep.c:5137
 lock_acquire+0x1e4/0x530 kernel/locking/lockdep.c:5754
 __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
 _raw_spin_lock_irqsave+0xd5/0x120 kernel/locking/spinlock.c:162
 queue_stack_map_push_elem+0x1b2/0x660 kernel/bpf/queue_stack_maps.c:210
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

