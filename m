Return-Path: <bpf+bounces-64764-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F75AB16AC9
	for <lists+bpf@lfdr.de>; Thu, 31 Jul 2025 05:19:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 56CEA1763EA
	for <lists+bpf@lfdr.de>; Thu, 31 Jul 2025 03:19:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5497B238C2D;
	Thu, 31 Jul 2025 03:19:30 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f205.google.com (mail-il1-f205.google.com [209.85.166.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74963189F20
	for <bpf@vger.kernel.org>; Thu, 31 Jul 2025 03:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753931970; cv=none; b=NhQKDK8uWnXimvArKvTl/6BwSf3Bj1NHRpJC2YWTHcwJZmhp1wROfLI37/19ruw+c4CTnHYWZP4CYkM3prlVDMjbVDzUTZQQ8j1MUUuvVYC0HPGoQROYzb7mJ8IDK04wPA4UNK991PEn5faFQCRvLcavSkHV68uHPYWDVA5EYm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753931970; c=relaxed/simple;
	bh=QOWXZ1u5miZVW5A7kgtKezMlQ7leAPMuOCuZvry7FA0=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Y+c0KiDE43x5GTV3HeHvlC3VlBVOfv10NZLoOCA/5iVkD6yN5bl3Roi3CrL6XCAF2b+/0+KNjfph70JyOecHOCj0Z8BuKAjRZms48bIoydW2FF+PW2dW9uGZyenlrFUA23pYUlLPkldtpflAbKFlkmwFBY+ct+LRdvOQy4gw3J0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f205.google.com with SMTP id e9e14a558f8ab-3e3d7e44ac5so9873195ab.0
        for <bpf@vger.kernel.org>; Wed, 30 Jul 2025 20:19:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753931967; x=1754536767;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TojKsEFn8kH9CmWm7e08zvyw3NVVu0cjp/vBb8SYeGc=;
        b=bLjy+iFyDmad7FXjA7yQZl8huCuVlsqG36Ms2dVqt7QWN7d7RxYvca61apy/Rs3iW5
         CbXX7NX6CPgbW43XhvWYyjzNmNZtbOwuej6b4pyyl8F3tVI2OAHEOErkjbjBlf/JURmz
         TaszJpeD9lzZ4H80VZIwVNEyT4yVSDB6zTRgGhA4lYIEwROz7IoP7vyD+n57fJA38P8U
         1t9H9WVeweuCnFX/aCazmyVNhtiziB7rRMnKD5cz5YpsLwRTUq6pLZB9tmc+J8S0TALX
         n+B6ip22MnpHz4GyhuKBaRcTowoavVBos5keDgLIQPBSYXIiz8xMgcRtYmsSOqkbWWaW
         EPgQ==
X-Forwarded-Encrypted: i=1; AJvYcCVz5I/kzAHTMrZDjMpMqDF+q5/xySrjogm7R0OK8krlX6hl6ZfjqA58Y+d0Nppw/GKBUSs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMDtvc6JZOFCQL3oNCexnbJlIuMqLIzGnQ+NY0yXBxcOjUVBDB
	i1rtG46qzR0bEtPivh0Iizf5yBrM4et6mPnKO3K+I/Gd5cH1u/alirgsA9F6LwF5VplUs4OMywu
	DxvpeFvEMwk3ARr1CFYhbeDz3yScvjjHUWVr437UAUY4zgM7kJQwPD5gH1GY=
X-Google-Smtp-Source: AGHT+IGDNZ48o8H8gkDb9o3Nr/GGGpJrMDOS5blJrYaVkbE3xUBfHlcdiSzfpWJGXHfpDphv7FzvYaAwevewUJ6d7w011NjkphfU
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2610:b0:3e3:f9fa:2c8c with SMTP id
 e9e14a558f8ab-3e3f9fa2e8amr96270275ab.12.1753931967624; Wed, 30 Jul 2025
 20:19:27 -0700 (PDT)
Date: Wed, 30 Jul 2025 20:19:27 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <688ae0bf.050a0220.5d226.0011.GAE@google.com>
Subject: [syzbot] [bpf?] WARNING in convert_ctx_accesses
From: syzbot <syzbot+ccac90e482b2a81d74aa@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, eddyz87@gmail.com, haoluo@google.com, 
	john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org, 
	linux-kernel@vger.kernel.org, martin.lau@linux.dev, sdf@fomichev.me, 
	song@kernel.org, syzkaller-bugs@googlegroups.com, yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    e8d780dcd957 Merge tag 'slab-for-6.17' of git://git.kernel..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=151049bc580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d32de89be62206c8
dashboard link: https://syzkaller.appspot.com/bug?extid=ccac90e482b2a81d74aa
compiler:       gcc (Debian 12.2.0-14+deb12u1) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=131049bc580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11cc2cf0580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/c62f8561b026/disk-e8d780dc.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/abb3e0f20140/vmlinux-e8d780dc.xz
kernel image: https://storage.googleapis.com/syzbot-assets/117094d1e482/bzImage-e8d780dc.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+ccac90e482b2a81d74aa@syzkaller.appspotmail.com

------------[ cut here ]------------
verifier bug: error during ctx access conversion(1)
WARNING: CPU: 0 PID: 5822 at kernel/bpf/verifier.c:21448 convert_ctx_accesses+0x2045/0x2920 kernel/bpf/verifier.c:21448
Modules linked in:
CPU: 0 UID: 0 PID: 5822 Comm: syz-executor130 Not tainted 6.16.0-syzkaller-06699-ge8d780dcd957 #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2025
RIP: 0010:convert_ctx_accesses+0x2045/0x2920 kernel/bpf/verifier.c:21448
Code: c7 c6 a0 95 b5 8b e8 ea a5 07 00 e9 a4 f9 ff ff e8 50 6c e8 ff c6 05 16 03 bd 0e 01 90 48 c7 c7 00 96 b5 8b e8 6c 02 a7 ff 90 <0f> 0b 90 90 e9 f1 fe ff ff e8 2d 6c e8 ff 0f b6 1d f6 02 bd 0e 31
RSP: 0018:ffffc90003dcf6e8 EFLAGS: 00010282
RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffffffff817a3658
RDX: ffff8880775dc880 RSI: ffffffff817a3665 RDI: 0000000000000001
RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000001 R12: dffffc0000000000
R13: ffffc90000ace048 R14: 0000000000000004 R15: ffff888023798000
FS:  0000555582c6c380(0000) GS:ffff88812471e000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000561e04e07000 CR3: 0000000071c4c000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 bpf_check+0x5960/0xc600 kernel/bpf/verifier.c:24736
 bpf_prog_load+0xe41/0x2490 kernel/bpf/syscall.c:2972
 __sys_bpf+0x4a3f/0x4de0 kernel/bpf/syscall.c:6022
 __do_sys_bpf kernel/bpf/syscall.c:6132 [inline]
 __se_sys_bpf kernel/bpf/syscall.c:6130 [inline]
 __x64_sys_bpf+0x78/0xc0 kernel/bpf/syscall.c:6130
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xcd/0x4c0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f75a63f53a9
Code: 48 83 c4 28 c3 e8 37 17 00 00 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffeb40793f8 EFLAGS: 00000246 ORIG_RAX: 0000000000000141
RAX: ffffffffffffffda RBX: 00007ffeb40795d8 RCX: 00007f75a63f53a9
RDX: 0000000000000048 RSI: 00002000000054c0 RDI: 0000000000000005
RBP: 00007f75a6468610 R08: 0000000000000000 R09: 0000000000000000
R10: ffffffffffffffff R11: 0000000000000246 R12: 0000000000000001
R13: 00007ffeb40795c8 R14: 0000000000000001 R15: 0000000000000001
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

