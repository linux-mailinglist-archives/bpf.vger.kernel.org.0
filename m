Return-Path: <bpf+bounces-21836-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BBC66852D46
	for <lists+bpf@lfdr.de>; Tue, 13 Feb 2024 11:00:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2EADA1F2A9E2
	for <lists+bpf@lfdr.de>; Tue, 13 Feb 2024 10:00:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFF6A224C6;
	Tue, 13 Feb 2024 09:58:16 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFA9C22EE4
	for <bpf@vger.kernel.org>; Tue, 13 Feb 2024 09:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707818296; cv=none; b=e1jCazVONkIJuazRTFo+FHd10SC0yYSIcsuN7fszpa+VriqH4maR9nTZlWi1i0wOiUJDj8WuKMHOL9PRDLELNRvqZqm5DTF1e3CF02iYTNAodSub+CGpqbU7EeAHm/q81Bz377AAwdkUSAOxZqTsRPyfy4eqr0hfraGD37s+d10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707818296; c=relaxed/simple;
	bh=buHQqgA9PJmKH08QqCJcwEZzYqGaox6glEvk7ezmG9w=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Re2l+5oHD735DPYw006YURWmwHXYub7bcdJFaxPCi6gReMtjZc4f/iT4+RU4R6MBFj5exKrjQRHglh4WcY9gqcIpaL5o2OAhpltZ0ULp9jay3tani8IcWCVd7aZId/Qsk4E4pkQmCKn2YbPQNCfFt4xBTRxkEsFWAERy2LiKB1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-363e7f0c9daso26787915ab.0
        for <bpf@vger.kernel.org>; Tue, 13 Feb 2024 01:58:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707818294; x=1708423094;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3G4oWomSO8B+fHRBn+T30jaygW1WjcEa8TRPVgJlG6M=;
        b=NB++SYHI0wByv8Hy50jXZBBP1JT1RPJAdd4us+U1dRHvbCsedtH8G+5uxfZVJNNeTN
         BQ3phRgiWbAadN0CVwJogcFgBHdP/yp4IzV7Hiln8eCUhckIShKVsPX8I/hOREI6xbf4
         jCkxC0VvvI0uTXi3aWxpTHyRtUIBkkW7wqiCyt5O2QwmFzfWwO24P3NUYap00ZA+J9JL
         8yt11CXi9Mi6JAO81c0+G0V9Tsm31HYRzh+M0WPcvtXhdCbZFGgXQ+3Z/pHaJqGxNu2d
         WOOeStmUYf58Tmt0IUnzOOP+LqWhLVdCZwOGqlfsZA0k4hxv7G2/f2bsgJY21v2xIgnZ
         qtcA==
X-Forwarded-Encrypted: i=1; AJvYcCU370GcTCBjT0xSFcxay6p6wobjNh/rrkgqY0kbKAM3tuJ0aIM5puzbHKeykw6PxMEr1NJFv5BxCFBEYYbAKePu7fP6
X-Gm-Message-State: AOJu0YwIx3B9llIfE+sN4ZBQpVgBBrLKmmq161oJU9fdFgukZt4lZsPA
	eNsaBVNvtUtw6Td/B6Z7b0BUO87rwR4jVXJpJtzQYnb3/mgQESNxGt5OR8XQSdY1vwm1sME/wX/
	NWaulfdlxBkh0AeNlTO4oPu+g6Mu8B2Gy8TdT47sIYAdHo1iX2hhQ+SI=
X-Google-Smtp-Source: AGHT+IGfsKCOOK1a+TeuJvZKuzJnFeJYixWJAsDzFlaOfHhAzRdLKZH9O5FFbcGvwxuCQNKg9ZBmpbPGY9piOqjA3RhxLIb17JDy
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c2f:b0:360:134:535e with SMTP id
 m15-20020a056e021c2f00b003600134535emr168811ilh.1.1707818294088; Tue, 13 Feb
 2024 01:58:14 -0800 (PST)
Date: Tue, 13 Feb 2024 01:58:14 -0800
In-Reply-To: <000000000000b8f8610609479fa3@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c299950611406e55@google.com>
Subject: Re: [syzbot] [bpf?] [net?] BUG: unable to handle kernel NULL pointer
 dereference in sk_psock_verdict_data_ready
From: syzbot <syzbot+fd7b34375c1c8ce29c93@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, davem@davemloft.net, edumazet@google.com, 
	jakub@cloudflare.com, john.fastabend@gmail.com, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, mukattreyee@gmail.com, netdev@vger.kernel.org, 
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    577e4432f3ac tcp: add sanity checks to rx zerocopy
git tree:       bpf
console output: https://syzkaller.appspot.com/x/log.txt?x=149a6fe0180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5e23375d0c3afdc8
dashboard link: https://syzkaller.appspot.com/bug?extid=fd7b34375c1c8ce29c93
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17e2ddf4180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16c5d592180000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/d512cc35258d/disk-577e4432.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/83484fcd4968/vmlinux-577e4432.xz
kernel image: https://storage.googleapis.com/syzbot-assets/dc2452784eec/bzImage-577e4432.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+fd7b34375c1c8ce29c93@syzkaller.appspotmail.com

BUG: kernel NULL pointer dereference, address: 0000000000000000
#PF: supervisor instruction fetch in kernel mode
#PF: error_code(0x0010) - not-present page
PGD 8000000023d8f067 P4D 8000000023d8f067 PUD 7af79067 PMD 0 
Oops: 0010 [#1] PREEMPT SMP KASAN PTI
CPU: 1 PID: 5255 Comm: syz-executor278 Not tainted 6.8.0-rc1-syzkaller-00195-g577e4432f3ac #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/25/2024
RIP: 0010:0x0
Code: Unable to access opcode bytes at 0xffffffffffffffd6.
RSP: 0018:ffffc9000437f8c8 EFLAGS: 00010246
RAX: 1ffff1100482de5c RBX: ffff88802416f2e0 RCX: ffff888023a7bb80
RDX: 0000000000000000 RSI: ffff88802416f000 RDI: ffff888023a96800
RBP: ffffc9000437fad0 R08: ffffffff8957112c R09: 1ffffffff2590c84
R10: dffffc0000000000 R11: 0000000000000000 R12: dffffc0000000000
R13: 0000000000000004 R14: ffffffff89570ff9 R15: ffff888023a96800
FS:  00007f8dfb0eb6c0(0000) GS:ffff8880b9500000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffffffffffffd6 CR3: 0000000023dae000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 sk_psock_verdict_data_ready+0x232/0x340 net/core/skmsg.c:1230
 unix_stream_sendmsg+0x9b4/0x1230 net/unix/af_unix.c:2293
 sock_sendmsg_nosec net/socket.c:730 [inline]
 __sock_sendmsg+0x221/0x270 net/socket.c:745
 ____sys_sendmsg+0x525/0x7d0 net/socket.c:2584
 ___sys_sendmsg net/socket.c:2638 [inline]
 __sys_sendmsg+0x2b0/0x3a0 net/socket.c:2667
 do_syscall_64+0xf9/0x240
 entry_SYSCALL_64_after_hwframe+0x6f/0x77
RIP: 0033:0x7f8dfb16c729
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 51 18 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f8dfb0eb218 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007f8dfb1f6368 RCX: 00007f8dfb16c729
RDX: 0000000000040000 RSI: 0000000020000980 RDI: 0000000000000003
RBP: 00007f8dfb1f6360 R08: 00007fff2e940fc7 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f8dfb1f636c
R13: 00007f8dfb1c3074 R14: 656c6c616b7a7973 R15: 00007fff2e940fc8
 </TASK>
Modules linked in:
CR2: 0000000000000000
---[ end trace 0000000000000000 ]---
RIP: 0010:0x0
Code: Unable to access opcode bytes at 0xffffffffffffffd6.
RSP: 0018:ffffc9000437f8c8 EFLAGS: 00010246
RAX: 1ffff1100482de5c RBX: ffff88802416f2e0 RCX: ffff888023a7bb80
RDX: 0000000000000000 RSI: ffff88802416f000 RDI: ffff888023a96800
RBP: ffffc9000437fad0 R08: ffffffff8957112c R09: 1ffffffff2590c84
R10: dffffc0000000000 R11: 0000000000000000 R12: dffffc0000000000
R13: 0000000000000004 R14: ffffffff89570ff9 R15: ffff888023a96800
FS:  00007f8dfb0eb6c0(0000) GS:ffff8880b9500000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffffffffffffd6 CR3: 0000000023dae000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

