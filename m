Return-Path: <bpf+bounces-43757-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 71A339B977A
	for <lists+bpf@lfdr.de>; Fri,  1 Nov 2024 19:28:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E3BA1C20DAA
	for <lists+bpf@lfdr.de>; Fri,  1 Nov 2024 18:28:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7879E1CEE82;
	Fri,  1 Nov 2024 18:28:24 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 833F51CEAAF
	for <bpf@vger.kernel.org>; Fri,  1 Nov 2024 18:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730485704; cv=none; b=kRTB8cC1SMPdG4l10EEl9NUcuOyG0TmErZgkJZsv+sx0uKFfx+CUf7jjze8eKGd9FadjGBK1OzAn+cIrqDYv3BJqifg1APV1G8FpdBoPor1Lfbs0aeCT4FHKiUTGE4X/Mkw8L/w/LNte1mxF3fIKYtBgRnmXfkJyyGN6EP1VpPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730485704; c=relaxed/simple;
	bh=RxUz8hP6n8+xXVE02nbooRfUtZubUNXEmHUJQcUSWJc=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Jczp+Y7t2qi/jn7dq3RgOI4BzjpNcgZKbWJ91RhOyJcq3y/cqr+TheAZsDbCE0isqJ1sOSW6b7xKazHgw/SipoJYjMiHSnDSw2JOzRQkw5p7AD8RNYFJg/hUneZe9cLfhcbXPSJr3isDxMgPw4ivaqv2nyiE6JhkLGRVcZnj6Ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a3c72d4ac4so23244585ab.3
        for <bpf@vger.kernel.org>; Fri, 01 Nov 2024 11:28:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730485702; x=1731090502;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Z4+84nmlv0lKLv0dedPeY/ox7erDl9+rEa+D6hDDZ6E=;
        b=QpXJzge1AK+jqk4y/8HRoBZt8WSrmcpaMvQBjkVd0HRp8cbqCyQRFzzqR/az/dxSTA
         TkyB+/yA/z9trl3J6xB/FfhANnHradxdf8fMlAbgIJmQel09cIpOP4WAEXfsX5tNqjxY
         2Q+Db5RG+KpGjQNf1OO/GB9E5DLKgJs4iOqsJh5iyeljrIY5Pig13MssZrWAS3qYl/rb
         r3tgJmLtdPKRgXLI+PBi7REasUTgEd3QmzhaWq/vrvPhDc0Ho3zLaWEjhJoTTHLOGKBY
         b7NwQdqBHp6dAw8rqbyzQuf/ZGcW9Km1B3jkNoMn/Jz2rFOqrCRSS8nAMl1kuPE22Wfo
         LKrA==
X-Forwarded-Encrypted: i=1; AJvYcCUXF08rtW7sCYeMTAOe9I2BlZ8kfmukSN045Z/HTNap9fMtuMPZ4kp28+Z/aDNzHv8pIaI=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywckxpzmm/H4iN0ITFtqj6ASKmELHNh7koG4VT45fyCgTYIVOfk
	XCRdna/HYRX7hlTQ2a4nloJVVRcnt1l339jyqAVrXHDgtj02M7nqeZirnFfUKuQv1LTdNEppWfk
	k2ybMQJ1oDoxMDdJd3BhXC56L12Eu8ouYdWC03Y3ZIp/Vie39hzDFX7g=
X-Google-Smtp-Source: AGHT+IGA6nayHw/c8gBNIrtsEXqYLDYNrWg+S0POTLUSZe8oqXGLg3vG7wEzROYpek1ssxoFad2A9vPpqAVXwgiK5j+9vFVPYEex
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c4a:b0:3a0:9043:59ac with SMTP id
 e9e14a558f8ab-3a5e2656d22mr130470365ab.25.1730485701749; Fri, 01 Nov 2024
 11:28:21 -0700 (PDT)
Date: Fri, 01 Nov 2024 11:28:21 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67251dc5.050a0220.529b6.015c.GAE@google.com>
Subject: [syzbot] [bpf?] WARNING: locking bug in bpf_map_put
From: syzbot <syzbot+d2adb332fe371b0595e3@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, eddyz87@gmail.com, haoluo@google.com, 
	john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org, 
	linux-kernel@vger.kernel.org, martin.lau@linux.dev, sdf@fomichev.me, 
	song@kernel.org, syzkaller-bugs@googlegroups.com, yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    f9f24ca362a4 Add linux-next specific files for 20241031
git tree:       linux-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=14886630580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=328572ed4d152be9
dashboard link: https://syzkaller.appspot.com/bug?extid=d2adb332fe371b0595e3
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=174432a7980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14ffe55f980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/eb84549dd6b3/disk-f9f24ca3.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/beb29bdfa297/vmlinux-f9f24ca3.xz
kernel image: https://storage.googleapis.com/syzbot-assets/8881fe3245ad/bzImage-f9f24ca3.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+d2adb332fe371b0595e3@syzkaller.appspotmail.com

=============================
[ BUG: Invalid wait context ]
6.12.0-rc5-next-20241031-syzkaller #0 Not tainted
-----------------------------
syz-executor304/5844 is trying to lock:
ffffffff8e9ba4b8 (map_idr_lock){+...}-{3:3}, at: bpf_map_free_id kernel/bpf/syscall.c:468 [inline]
ffffffff8e9ba4b8 (map_idr_lock){+...}-{3:3}, at: bpf_map_put+0x9a/0x380 kernel/bpf/syscall.c:902
other info that might help us debug this:
context-{5:5}
2 locks held by syz-executor304/5844:
 #0: ffffffff8e939f20 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:337 [inline]
 #0: ffffffff8e939f20 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:849 [inline]
 #0: ffffffff8e939f20 (rcu_read_lock){....}-{1:3}, at: map_delete_elem+0x338/0x5c0 kernel/bpf/syscall.c:1777
 #1: ffff88807b870410 (&htab->lockdep_key){....}-{2:2}, at: htab_lock_bucket+0x1a4/0x370 kernel/bpf/hashtab.c:167
stack backtrace:
CPU: 1 UID: 0 PID: 5844 Comm: syz-executor304 Not tainted 6.12.0-rc5-next-20241031-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 print_lock_invalid_wait_context kernel/locking/lockdep.c:4826 [inline]
 check_wait_context kernel/locking/lockdep.c:4898 [inline]
 __lock_acquire+0x15a8/0x2100 kernel/locking/lockdep.c:5176
 lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5849
 __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
 _raw_spin_lock_irqsave+0xd5/0x120 kernel/locking/spinlock.c:162
 bpf_map_free_id kernel/bpf/syscall.c:468 [inline]
 bpf_map_put+0x9a/0x380 kernel/bpf/syscall.c:902
 htab_put_fd_value kernel/bpf/hashtab.c:911 [inline]
 free_htab_elem+0xbb/0x460 kernel/bpf/hashtab.c:946
 htab_map_delete_elem+0x576/0x6b0 kernel/bpf/hashtab.c:1438
 map_delete_elem+0x431/0x5c0 kernel/bpf/syscall.c:1778
 __sys_bpf+0x598/0x810 kernel/bpf/syscall.c:5745
 __do_sys_bpf kernel/bpf/syscall.c:5861 [inline]
 __se_sys_bpf kernel/bpf/syscall.c:5859 [inline]
 __x64_sys_bpf+0x7c/0x90 kernel/bpf/syscall.c:5859
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f9ad03385e9
Code: 48 83 c4 28 c3 e8 37 17 00 00 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffd14d58828 EFLAGS: 00000246 ORIG_RAX: 0000000000000141
RAX: ffffffffffffffda RBX: 00007ffd14d589f8 RCX: 00007f9ad03385e9
RDX: 0000000000000020 RSI: 0000000020000300 RDI: 0000000000000003
R


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

