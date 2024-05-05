Return-Path: <bpf+bounces-28634-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4C358BC263
	for <lists+bpf@lfdr.de>; Sun,  5 May 2024 18:14:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7ABC1C20F63
	for <lists+bpf@lfdr.de>; Sun,  5 May 2024 16:13:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCA7352F68;
	Sun,  5 May 2024 16:13:35 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f205.google.com (mail-il1-f205.google.com [209.85.166.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF642374FF
	for <bpf@vger.kernel.org>; Sun,  5 May 2024 16:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714925615; cv=none; b=ePPQhYIt89dTV/jytbBpBclZv2yU57l7JppqhZmQLJClooW768suWK3ZWcYRqmd5Njrk17DnEK386rmU89uyUx6yrERI8EQK27IeY46u0v+AQY3YEoHc8C43UzHt0tcSPO23FhBvTa74SpaEpvcJi+sAoaVtWNBEFWdNbOZ4LB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714925615; c=relaxed/simple;
	bh=b3AWUJT6Y2r0Cpa7zIUm4iw7ILdY7k2g+YUuZ57sH1I=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=gfUwD+SaLDGToS+pM6Mlp2TLGLewswH8TlAqzdWnxU+nHu4EaX+xOeq/saAxauvALHX0450PNM06ELQfi1cN4jWwNOFo6fNrrSq6OAoMn0TASF2I5npjmFjtujVmlnGfvYRFpjAM1ELP9JuuZM+EO44ksP+euH/F4rWU/oEislw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f205.google.com with SMTP id e9e14a558f8ab-36c89052654so12753035ab.0
        for <bpf@vger.kernel.org>; Sun, 05 May 2024 09:13:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714925613; x=1715530413;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iOkOYyTsI2vSWVysiza8WXlk82ny5djsTkzb/e0BsTU=;
        b=HGqhtEzUTm62e5ZTGyVxpB2Is7V9uUlMYZ8UVx8hBwJ3iJ5AKCiQshS0iO/Ts5PPyf
         Q8dbMTP0KJGAm0YD2RrxXAM5grq9bZVvT74uKly89qcaYplLU/PCbMdCSlHjtMaRzr/e
         O3VITqibzlJDPGlExvY148+OPAtcnKkyzeM12ZxuHPTmeJhjKoCik2SN0BKeSpxVSlGr
         yXQyD3xGQmOrlcuurKZTEpowsC2L1vrg1dZGEThTW+EwME3BD8yVW0LFBu/H2TdnjRka
         6Z4GN8aepvbhMFa8VJUhDcS0DToSQ4fqvS2i/SGGxfqYj6t66zwoDKWR4UuKf5kaZCiL
         /nZg==
X-Forwarded-Encrypted: i=1; AJvYcCVMag5npYK1g9O5EhsSAJJc4F+jvnEAJqp5hXT+v6putZ6nMnNNq4hBzNnfdpFoW8sJE0XHa7av3L96e5O8yQhT9Prd
X-Gm-Message-State: AOJu0YxCXbXQUlVPhirAIMKDE4eShqJPPpt0ZXfHwR0WXwrxR4cNAEnX
	7FjYIgEBbJUWrpfNwtELhxTsvJqf/sk21njhRnbxBB3scO9NbKyPmrtAtN79MDmrlwDGdidvCB5
	kvUvGljBdRC0gZXpAAwHcN2b+OGaDs+YYZi54UOrmKl7JIGMmd6iG9YQ=
X-Google-Smtp-Source: AGHT+IGzaDtHTd652SVXpU/3SW9jscejDSs9amYM117DIykGl5yAVUT1+ijoGvZAh74TcjXYjJ+v53eltDlqf8S3ZXcI7Ag1Cf/u
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:20c3:b0:36c:1004:9aa1 with SMTP id
 3-20020a056e0220c300b0036c10049aa1mr377919ilq.3.1714925613190; Sun, 05 May
 2024 09:13:33 -0700 (PDT)
Date: Sun, 05 May 2024 09:13:33 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000fda0400617b73b57@google.com>
Subject: [syzbot] [bpf?] [trace?] general protection fault in bpf_get_attach_cookie_tracing
From: syzbot <syzbot+3ab78ff125b7979e45f9@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, eddyz87@gmail.com, haoluo@google.com, 
	john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	martin.lau@linux.dev, mathieu.desnoyers@efficios.com, mhiramat@kernel.org, 
	netdev@vger.kernel.org, rostedt@goodmis.org, sdf@google.com, song@kernel.org, 
	syzkaller-bugs@googlegroups.com, yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    a9e7715ce8b3 libbpf: Avoid casts from pointers to enums in..
git tree:       bpf-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=153c1dc4980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e8aa3e4736485e94
dashboard link: https://syzkaller.appspot.com/bug?extid=3ab78ff125b7979e45f9
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17d4b588980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16cb0470980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/a6daa7801875/disk-a9e7715c.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/0d5b51385a69/vmlinux-a9e7715c.xz
kernel image: https://storage.googleapis.com/syzbot-assets/999297a08631/bzImage-a9e7715c.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+3ab78ff125b7979e45f9@syzkaller.appspotmail.com

general protection fault, probably for non-canonical address 0xdffffc0000000000: 0000 [#1] PREEMPT SMP KASAN PTI
KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
CPU: 0 PID: 5082 Comm: syz-executor316 Not tainted 6.9.0-rc5-syzkaller-01452-ga9e7715ce8b3 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
RIP: 0010:____bpf_get_attach_cookie_tracing kernel/trace/bpf_trace.c:1179 [inline]
RIP: 0010:bpf_get_attach_cookie_tracing+0x46/0x60 kernel/trace/bpf_trace.c:1174
Code: d3 03 00 48 81 c3 00 18 00 00 48 89 d8 48 c1 e8 03 42 80 3c 30 00 74 08 48 89 df e8 54 b9 59 00 48 8b 1b 48 89 d8 48 c1 e8 03 <42> 80 3c 30 00 74 08 48 89 df e8 3b b9 59 00 48 8b 03 5b 41 5e c3
RSP: 0018:ffffc90002f9fba8 EFLAGS: 00010246
RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffff888029575a00
RDX: 0000000000000000 RSI: ffffc90000ace048 RDI: 0000000000000000
RBP: ffffc90002f9fbc0 R08: ffffffff89938ae7 R09: 1ffffffff25e80a0
R10: dffffc0000000000 R11: ffffffffa0000950 R12: ffffc90002f9fc80
R13: dffffc0000000000 R14: dffffc0000000000 R15: 0000000000000000
FS:  0000555578992380(0000) GS:ffff8880b9400000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000002e3e9388 CR3: 00000000791c2000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 bpf_prog_fe13437f26555f61+0x1a/0x1c
 bpf_dispatcher_nop_func include/linux/bpf.h:1243 [inline]
 __bpf_prog_run include/linux/filter.h:691 [inline]
 bpf_prog_run include/linux/filter.h:698 [inline]
 __bpf_prog_test_run_raw_tp+0x149/0x310 net/bpf/test_run.c:732
 bpf_prog_test_run_raw_tp+0x47b/0x6a0 net/bpf/test_run.c:772
 bpf_prog_test_run+0x33a/0x3b0 kernel/bpf/syscall.c:4286
 __sys_bpf+0x48d/0x810 kernel/bpf/syscall.c:5700
 __do_sys_bpf kernel/bpf/syscall.c:5789 [inline]
 __se_sys_bpf kernel/bpf/syscall.c:5787 [inline]
 __x64_sys_bpf+0x7c/0x90 kernel/bpf/syscall.c:5787
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf5/0x240 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f53be8a0469
Code: 48 83 c4 28 c3 e8 37 17 00 00 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffdcf680a08 EFLAGS: 00000246 ORIG_RAX: 0000000000000141
RAX: ffffffffffffffda RBX: 00007ffdcf680bd8 RCX: 00007f53be8a0469
RDX: 000000000000000c RSI: 0000000020000080 RDI: 000000000000000a
RBP: 00007f53be913610 R08: 0000000000000000 R09: 00007ffdcf680bd8
R10: 00007f53be8dbae3 R11: 0000000000000246 R12: 0000000000000001
R13: 00007ffdcf680bc8 R14: 0000000000000001 R15: 0000000000000001
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:____bpf_get_attach_cookie_tracing kernel/trace/bpf_trace.c:1179 [inline]
RIP: 0010:bpf_get_attach_cookie_tracing+0x46/0x60 kernel/trace/bpf_trace.c:1174
Code: d3 03 00 48 81 c3 00 18 00 00 48 89 d8 48 c1 e8 03 42 80 3c 30 00 74 08 48 89 df e8 54 b9 59 00 48 8b 1b 48 89 d8 48 c1 e8 03 <42> 80 3c 30 00 74 08 48 89 df e8 3b b9 59 00 48 8b 03 5b 41 5e c3
RSP: 0018:ffffc90002f9fba8 EFLAGS: 00010246
RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffff888029575a00
RDX: 0000000000000000 RSI: ffffc90000ace048 RDI: 0000000000000000
RBP: ffffc90002f9fbc0 R08: ffffffff89938ae7 R09: 1ffffffff25e80a0
R10: dffffc0000000000 R11: ffffffffa0000950 R12: ffffc90002f9fc80
R13: dffffc0000000000 R14: dffffc0000000000 R15: 0000000000000000
FS:  0000555578992380(0000) GS:ffff8880b9400000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000002e3e9388 CR3: 00000000791c2000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	d3 03                	roll   %cl,(%rbx)
   2:	00 48 81             	add    %cl,-0x7f(%rax)
   5:	c3                   	ret
   6:	00 18                	add    %bl,(%rax)
   8:	00 00                	add    %al,(%rax)
   a:	48 89 d8             	mov    %rbx,%rax
   d:	48 c1 e8 03          	shr    $0x3,%rax
  11:	42 80 3c 30 00       	cmpb   $0x0,(%rax,%r14,1)
  16:	74 08                	je     0x20
  18:	48 89 df             	mov    %rbx,%rdi
  1b:	e8 54 b9 59 00       	call   0x59b974
  20:	48 8b 1b             	mov    (%rbx),%rbx
  23:	48 89 d8             	mov    %rbx,%rax
  26:	48 c1 e8 03          	shr    $0x3,%rax
* 2a:	42 80 3c 30 00       	cmpb   $0x0,(%rax,%r14,1) <-- trapping instruction
  2f:	74 08                	je     0x39
  31:	48 89 df             	mov    %rbx,%rdi
  34:	e8 3b b9 59 00       	call   0x59b974
  39:	48 8b 03             	mov    (%rbx),%rax
  3c:	5b                   	pop    %rbx
  3d:	41 5e                	pop    %r14
  3f:	c3                   	ret


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

