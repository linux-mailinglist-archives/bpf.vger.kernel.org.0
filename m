Return-Path: <bpf+bounces-55888-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 914DBA88A78
	for <lists+bpf@lfdr.de>; Mon, 14 Apr 2025 19:56:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8312A17CC60
	for <lists+bpf@lfdr.de>; Mon, 14 Apr 2025 17:56:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ED35288CB1;
	Mon, 14 Apr 2025 17:56:30 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f208.google.com (mail-il1-f208.google.com [209.85.166.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64B231A3A80
	for <bpf@vger.kernel.org>; Mon, 14 Apr 2025 17:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744653390; cv=none; b=DRFVLKp3eBuVZ9SIYHm2i9128vYnL5xkx8TH8KYENTQiRiPCKxOzSsUlKqPC6zBGCbsG4WKceHushwXPMkDHOCb24cbladXfSEnHhIKkOPN1k+nXzqbBa8vkJ1JXSi6ZwRo8jBGYqvDknRkyBPZXMT/o8NfyS3h23xvJ+PIx258=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744653390; c=relaxed/simple;
	bh=vURsV5YemUJpkFCD8/ru1TOKMX0gLac4GhfJzyhDhNY=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=moo4u24nlz5vY8jJfXunQRsVomVwS4AiSKkpOMvJQNnk02fbEiFC1u6cSov88P1gDa7vMbXvDFjBjfYTRb2lZm75ExCeUFqR8ucG1J+mDTN90Ysilczy7PnaMpt9Fmjv9daElE+3lDc8y0d3tGG70QJanfLtFlHw1SEHWcKKlcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f208.google.com with SMTP id e9e14a558f8ab-3d5b38276deso82541325ab.3
        for <bpf@vger.kernel.org>; Mon, 14 Apr 2025 10:56:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744653387; x=1745258187;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jeg5X6QWTF4VMRVVGYQBw2YC73USHKVbHSY/hdZira4=;
        b=HKx5/bCUBkam3owI049dUjKLWsksJ92JR40gFa7CEB5cEUCvv/pFjEmUr+DPdmf92+
         Oyq4P+ezUK0ZZmapsuPj1c4XXyABFpkuuPjx7fPceXYhXjxGsa3WUh5RZHiEY0UjvYdx
         tqSpQFAwFSLjG3hFUSjQ4mqRasEZibELHtOAHvrkAw0vSQ8nwY92txiy5n0ymJtZeKnK
         XkAeFPxzEUzzT/QzK67gBBhIZuNBoTdBLBJSiT/DbnPR04zAH/Z5xhSCcm+bikeoebfq
         /yARW07kl4v0JHlYOehnUym7ILzYizA+IQpgniJUab2j+uuTiOSlh8RyPap7JsMkzma7
         Iqbg==
X-Forwarded-Encrypted: i=1; AJvYcCVimsOjbeUgicYftiMN8HuiGTyijLKyl/jqjykEio2OjN/ieAJmxCao4F4S+T4IsjiEiQc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHVRzWIiF2qWa9UBzKMBTSMyaz+FcDBIye5ivXD2FEFwn7i2kY
	fRTeYBvgtCP+ScabOSuT9PDmopyW6iAAY34v2Z2mSlMhEIKoysQmb8119V0RYYsQb3ISo70Biue
	AdHfjYRcrXfXo1teAeL18BrTSi9/yHyZ1wNreYOHIU4kxI4jm0L/J+GQ=
X-Google-Smtp-Source: AGHT+IGOZEpqBg1uASY2cZWVzXvFrbR6IiloKxN3T5L2xMhcC6HYS8rfng7IwSQumXz61ZtH34LWAcJWt4B+YZTpt4wDVpV7FBSN
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:b25:b0:3d4:244b:db1d with SMTP id
 e9e14a558f8ab-3d7ec2033cbmr122573145ab.6.1744653387299; Mon, 14 Apr 2025
 10:56:27 -0700 (PDT)
Date: Mon, 14 Apr 2025 10:56:27 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67fd4c4b.050a0220.3483fc.002e.GAE@google.com>
Subject: [syzbot] [bpf?] general protection fault in drain_mem_cache (3)
From: syzbot <syzbot+18139576507d899c8066@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, eddyz87@gmail.com, haoluo@google.com, 
	john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org, 
	linux-kernel@vger.kernel.org, martin.lau@linux.dev, sdf@fomichev.me, 
	song@kernel.org, syzkaller-bugs@googlegroups.com, yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    8ffd015db85f Linux 6.15-rc2
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=138f4fe4580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=251b23b325792e6a
dashboard link: https://syzkaller.appspot.com/bug?extid=18139576507d899c8066
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/a3556a7b414f/disk-8ffd015d.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/f9ce6c909417/vmlinux-8ffd015d.xz
kernel image: https://storage.googleapis.com/syzbot-assets/cce0709aed9d/bzImage-8ffd015d.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+18139576507d899c8066@syzkaller.appspotmail.com

Oops: general protection fault, probably for non-canonical address 0xdffffc0000000000: 0000 [#1] SMP KASAN NOPTI
KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
CPU: 0 UID: 0 PID: 6517 Comm: syz.3.129 Not tainted 6.15.0-rc2-syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/12/2025
RIP: 0010:free_all kernel/bpf/memalloc.c:268 [inline]
RIP: 0010:drain_mem_cache+0x92/0x580 kernel/bpf/memalloc.c:638
Code: ff df 48 85 ed 75 17 eb 63 e8 9a 2f d9 ff 48 89 ef e8 12 ea 32 00 4d 85 ed 74 51 4c 89 ed e8 85 2f d9 ff 48 89 e8 48 c1 e8 03 <42> 80 3c 30 00 0f 85 57 04 00 00 31 ff 89 de 4c 8b 6d 00 e8 a6 2a
RSP: 0018:ffffc900035a7a58 EFLAGS: 00010256
RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffffc9000c74c000
RDX: 0000000000080000 RSI: ffffffff81e20d3b RDI: ffffe8ffffc3a7a0
RBP: 0000000000000001 R08: 0000000000000001 R09: fffff91ffff874f4
R10: ffffe8ffffc3a7a7 R11: 0000000000000000 R12: ffffe8ffffc3a6f8
R13: ffff88807d5941d0 R14: dffffc0000000000 R15: ffff88807d594018
FS:  00007ff686c4b6c0(0000) GS:ffff8881249b9000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000110c3406c4 CR3: 0000000052f32000 CR4: 0000000000350ef0
Call Trace:
 <TASK>
 bpf_mem_alloc_destroy+0x145/0x6d0 kernel/bpf/memalloc.c:754
 htab_map_free+0x37f/0xab0 kernel/bpf/hashtab.c:1551
 bpf_map_free kernel/bpf/syscall.c:861 [inline]
 map_create+0xe54/0x1db0 kernel/bpf/syscall.c:1557
 __sys_bpf+0x47cc/0x4d80 kernel/bpf/syscall.c:5816
 __do_sys_bpf kernel/bpf/syscall.c:5941 [inline]
 __se_sys_bpf kernel/bpf/syscall.c:5939 [inline]
 __x64_sys_bpf+0x78/0xc0 kernel/bpf/syscall.c:5939
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xcd/0x260 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7ff685d8d169
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ff686c4b038 EFLAGS: 00000246 ORIG_RAX: 0000000000000141
RAX: ffffffffffffffda RBX: 00007ff685fa5fa0 RCX: 00007ff685d8d169
RDX: 0000000000000050 RSI: 00002000000008c0 RDI: 0000000000000000
RBP: 00007ff685e0e990 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007ff685fa5fa0 R15: 00007ffd6ccab8d8
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:free_all kernel/bpf/memalloc.c:268 [inline]
RIP: 0010:drain_mem_cache+0x92/0x580 kernel/bpf/memalloc.c:638
Code: ff df 48 85 ed 75 17 eb 63 e8 9a 2f d9 ff 48 89 ef e8 12 ea 32 00 4d 85 ed 74 51 4c 89 ed e8 85 2f d9 ff 48 89 e8 48 c1 e8 03 <42> 80 3c 30 00 0f 85 57 04 00 00 31 ff 89 de 4c 8b 6d 00 e8 a6 2a
RSP: 0018:ffffc900035a7a58 EFLAGS: 00010256
RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffffc9000c74c000
RDX: 0000000000080000 RSI: ffffffff81e20d3b RDI: ffffe8ffffc3a7a0
RBP: 0000000000000001 R08: 0000000000000001 R09: fffff91ffff874f4
R10: ffffe8ffffc3a7a7 R11: 0000000000000000 R12: ffffe8ffffc3a6f8
R13: ffff88807d5941d0 R14: dffffc0000000000 R15: ffff88807d594018
FS:  00007ff686c4b6c0(0000) GS:ffff8881249b9000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fdbb12d7d60 CR3: 0000000052f32000 CR4: 0000000000350ef0
----------------
Code disassembly (best guess), 1 bytes skipped:
   0:	df 48 85             	fisttps -0x7b(%rax)
   3:	ed                   	in     (%dx),%eax
   4:	75 17                	jne    0x1d
   6:	eb 63                	jmp    0x6b
   8:	e8 9a 2f d9 ff       	call   0xffd92fa7
   d:	48 89 ef             	mov    %rbp,%rdi
  10:	e8 12 ea 32 00       	call   0x32ea27
  15:	4d 85 ed             	test   %r13,%r13
  18:	74 51                	je     0x6b
  1a:	4c 89 ed             	mov    %r13,%rbp
  1d:	e8 85 2f d9 ff       	call   0xffd92fa7
  22:	48 89 e8             	mov    %rbp,%rax
  25:	48 c1 e8 03          	shr    $0x3,%rax
* 29:	42 80 3c 30 00       	cmpb   $0x0,(%rax,%r14,1) <-- trapping instruction
  2e:	0f 85 57 04 00 00    	jne    0x48b
  34:	31 ff                	xor    %edi,%edi
  36:	89 de                	mov    %ebx,%esi
  38:	4c 8b 6d 00          	mov    0x0(%rbp),%r13
  3c:	e8                   	.byte 0xe8
  3d:	a6                   	cmpsb  %es:(%rdi),%ds:(%rsi)
  3e:	2a                   	.byte 0x2a


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

