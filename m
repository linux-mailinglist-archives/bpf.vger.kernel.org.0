Return-Path: <bpf+bounces-32177-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E80D1908652
	for <lists+bpf@lfdr.de>; Fri, 14 Jun 2024 10:30:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98FD228F459
	for <lists+bpf@lfdr.de>; Fri, 14 Jun 2024 08:30:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 074D018FC60;
	Fri, 14 Jun 2024 08:30:23 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f206.google.com (mail-il1-f206.google.com [209.85.166.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D9CF18FC6C
	for <bpf@vger.kernel.org>; Fri, 14 Jun 2024 08:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718353822; cv=none; b=ipmhU77vAaUxCy6/l9kltD9sdQLmc8B6OnQQgOWuAb/LSseYvJHH8KIhdPeeIBGs503lsdOMFQ9exZXPHvvcdAYGNgjNp+QKD7Bdu4TgRhFDsWjosxYX1KENOBY3/5DPOEUz5l0fyvKGdPc3G/Y0SMJHT4sWhekWYC2Cks8X3Qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718353822; c=relaxed/simple;
	bh=TIsWinQmZcpgnuKTbf25dCpfKF6hkc9UokT1TMEEntw=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=CKtcscuI9BPygKf8lmo6MEEVWy8lzGsyAn8N9Np2wY7ypTQc7mGxHrSkmZeHYUssdYEENd9y26oIIDv6EAZIgILA9Fle07hE81xhSl5xQplORfJoAZqj6rI/Ca7D6OGc5X1xYUw9y5zgy42cXYbNLiVWpLAtGL5z2LzPRn2I/5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f206.google.com with SMTP id e9e14a558f8ab-3746147204eso21872245ab.3
        for <bpf@vger.kernel.org>; Fri, 14 Jun 2024 01:30:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718353820; x=1718958620;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YA1htI/BDzTzi2+wIpm6aatc4oEDGAHH/0MMFvo5/aQ=;
        b=KXoBUXkynPrOBLEBaiXYz/obG695FTS1dTBc4WWCXbAhN8eKeob9aVWGm3Cr+b4a91
         ZEF0Sw6W1VJxs2goHOlVwUIK0q0bDXYzuBYrRr7KWpC9NtsQRmS/CySIAjBx4N2WyIWT
         M8STQtrKHgUYK56JPrkJOGVaOjLaS5r7v/2kIh0trlr0Zbk52ZJr9N9wOO/k4HKGm3G6
         EGkd3JazpU6fXTuvvfzun+1IgDrM3i7hJg6OsMuerdcJP6Ug5ayhQ4rpvr7NUwa1uIRp
         QjcfiDpkH/e0dNQomRCfA2zxn6jN3JnSXDLmHZXBxk7XIMEh6hNP24o8P/zBHtqvPPIg
         jR6A==
X-Forwarded-Encrypted: i=1; AJvYcCUmbCGyW6aEYWuhv7zQg3yBqC+fgIf1GTzKiLSHPj5JER9JHItixbBJfKTSurFrWaHAPb2lQMf1K5qXADXwc6XttlKW
X-Gm-Message-State: AOJu0Yy8QOaBgN7nUNz7Puegg5pFXT+r9SjvQKgUak74JWD0DOVx7RWp
	uHbYdmVetKfbxCPE6atBF5xAf4DfHCP2uX5VYDxUsmod0hBqtmWWs4AgnV/Ooj2DgushAAOuz6f
	Y6rXqdUbmAOi2s1DTH7d7gSev7DAUJmkl/nrqiY0PcmYZDgtvntEdrNs=
X-Google-Smtp-Source: AGHT+IHHPk88hCAzrFHq34yZJXX0iSXuLF/CyrXS2Wr8FiNbEKrKkLtjLpSaWTQcxuWkWSuxPROnnZ9kISsh7El3qVBMFKeVbWpQ
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:194d:b0:375:dad7:a664 with SMTP id
 e9e14a558f8ab-375e1036551mr1448095ab.6.1718353820426; Fri, 14 Jun 2024
 01:30:20 -0700 (PDT)
Date: Fri, 14 Jun 2024 01:30:20 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000010b246061ad56d2e@google.com>
Subject: [syzbot] [bpf?] WARNING: locking bug in __pcpu_freelist_pop
From: syzbot <syzbot+520605fec365a2b46c6f@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, eddyz87@gmail.com, haoluo@google.com, 
	john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org, 
	linux-kernel@vger.kernel.org, martin.lau@linux.dev, sdf@google.com, 
	song@kernel.org, syzkaller-bugs@googlegroups.com, yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    2ccbdf43d5e7 Merge tag 'for-linus' of git://git.kernel.org..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13f9f9ee980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=81c0d76ceef02b39
dashboard link: https://syzkaller.appspot.com/bug?extid=520605fec365a2b46c6f
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7bc7510fe41f/non_bootable_disk-2ccbdf43.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/13cdb5bfbafa/vmlinux-2ccbdf43.xz
kernel image: https://storage.googleapis.com/syzbot-assets/7a14f5d07f81/bzImage-2ccbdf43.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+520605fec365a2b46c6f@syzkaller.appspotmail.com

------------[ cut here ]------------
Looking for class "ead->lock" with key __key.1, but found a different class "&head->lock" with the same key
WARNING: CPU: 2 PID: 8320 at kernel/locking/lockdep.c:932 look_up_lock_class+0x133/0x140 kernel/locking/lockdep.c:932
Modules linked in:
CPU: 2 PID: 8320 Comm: syz-executor.2 Not tainted 6.10.0-rc3-syzkaller-00044-g2ccbdf43d5e7 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
RIP: 0010:look_up_lock_class+0x133/0x140 kernel/locking/lockdep.c:932
Code: c7 c7 20 b9 2c 8b e8 cc 53 74 f6 90 0f 0b 90 90 90 31 db eb be c6 05 f5 86 ef 04 01 90 48 c7 c7 40 bc 2c 8b e8 ae 53 74 f6 90 <0f> 0b 90 90 e9 62 ff ff ff 0f 1f 40 00 90 90 90 90 90 90 90 90 90
RSP: 0018:ffffc90003f9f5f8 EFLAGS: 00010086
RAX: 0000000000000000 RBX: ffffffff9427ba10 RCX: ffffc90025be5000
RDX: 0000000000040000 RSI: ffffffff81511296 RDI: 0000000000000001
RBP: ffffffff94ae7da0 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000000 R11: 20676e696b6f6f4c R12: ffffe8ffad032900
R13: 0000000000000000 R14: 0000000000000000 R15: ffffffff94ad8be0
FS:  0000000000000000(0000) GS:ffff88802c200000(0063) knlGS:00000000f5ee3b40
CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
CR2: 0000000031822000 CR3: 0000000028238000 CR4: 0000000000352ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 register_lock_class+0xb1/0x1230 kernel/locking/lockdep.c:1284
 __lock_acquire+0x111/0x3b30 kernel/locking/lockdep.c:5014
 lock_acquire kernel/locking/lockdep.c:5754 [inline]
 lock_acquire+0x1b1/0x560 kernel/locking/lockdep.c:5719
 __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
 _raw_spin_lock+0x2e/0x40 kernel/locking/spinlock.c:154
 ___pcpu_freelist_pop kernel/bpf/percpu_freelist.c:131 [inline]
 __pcpu_freelist_pop+0x18b/0x9f0 kernel/bpf/percpu_freelist.c:188
 alloc_htab_elem+0x2e2/0xad0 kernel/bpf/hashtab.c:1023
 htab_map_update_elem+0x390/0xde0 kernel/bpf/hashtab.c:1168
 bpf_map_update_value+0x2c1/0x6c0 kernel/bpf/syscall.c:203
 generic_map_update_batch+0x454/0x5f0 kernel/bpf/syscall.c:1889
 bpf_map_do_batch+0x615/0x6e0 kernel/bpf/syscall.c:5197
 __sys_bpf+0x18cb/0x5830 kernel/bpf/syscall.c:5752
 __do_sys_bpf kernel/bpf/syscall.c:5795 [inline]
 __se_sys_bpf kernel/bpf/syscall.c:5793 [inline]
 __ia32_sys_bpf+0x76/0xe0 kernel/bpf/syscall.c:5793
 do_syscall_32_irqs_on arch/x86/entry/common.c:165 [inline]
 __do_fast_syscall_32+0x73/0x120 arch/x86/entry/common.c:386
 do_fast_syscall_32+0x32/0x80 arch/x86/entry/common.c:411
 entry_SYSENTER_compat_after_hwframe+0x84/0x8e
RIP: 0023:0xf72f1579
Code: b8 01 10 06 03 74 b4 01 10 07 03 74 b0 01 10 08 03 74 d8 01 00 00 00 00 00 00 00 00 00 00 00 00 00 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 8d b4 26 00 00 00 00 8d b4 26 00 00 00 00
RSP: 002b:00000000f5ee35ac EFLAGS: 00000292 ORIG_RAX: 0000000000000165
RAX: ffffffffffffffda RBX: 000000000000001a RCX: 0000000020000300
RDX: 0000000000000038 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000292 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 </TASK>
----------------
Code disassembly (best guess), 2 bytes skipped:
   0:	10 06                	adc    %al,(%rsi)
   2:	03 74 b4 01          	add    0x1(%rsp,%rsi,4),%esi
   6:	10 07                	adc    %al,(%rdi)
   8:	03 74 b0 01          	add    0x1(%rax,%rsi,4),%esi
   c:	10 08                	adc    %cl,(%rax)
   e:	03 74 d8 01          	add    0x1(%rax,%rbx,8),%esi
  1e:	00 51 52             	add    %dl,0x52(%rcx)
  21:	55                   	push   %rbp
  22:	89 e5                	mov    %esp,%ebp
  24:	0f 34                	sysenter
  26:	cd 80                	int    $0x80
* 28:	5d                   	pop    %rbp <-- trapping instruction
  29:	5a                   	pop    %rdx
  2a:	59                   	pop    %rcx
  2b:	c3                   	ret
  2c:	90                   	nop
  2d:	90                   	nop
  2e:	90                   	nop
  2f:	90                   	nop
  30:	8d b4 26 00 00 00 00 	lea    0x0(%rsi,%riz,1),%esi
  37:	8d b4 26 00 00 00 00 	lea    0x0(%rsi,%riz,1),%esi


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

