Return-Path: <bpf+bounces-46268-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE0FB9E6F76
	for <lists+bpf@lfdr.de>; Fri,  6 Dec 2024 14:47:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9082128390D
	for <lists+bpf@lfdr.de>; Fri,  6 Dec 2024 13:47:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0E6E206F0E;
	Fri,  6 Dec 2024 13:47:24 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f207.google.com (mail-il1-f207.google.com [209.85.166.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C73B013B5AF
	for <bpf@vger.kernel.org>; Fri,  6 Dec 2024 13:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733492844; cv=none; b=FjRpJZzoAlWCSF6TMesQCfrfxmFj1WBQkTC4g1U85v5Hi5NFq9OURiqLmOWvjB8jVXbWAagMroCl+UVSIDuPb79uAOpjVWP1oRDT4gUVuDvdMR25x1g95QzFrQHub4F4wFzKyZS/0xD6uRIUYJPNtmE4XSPRwnSNcOVXf572qLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733492844; c=relaxed/simple;
	bh=CGjkfpE/iqpjTkKByuC9/m2KrcsyrYtsoLpoSb7Qy0Q=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=EPRu8ahwFtyKC5BXk7L2pQuosWaZAnwa/9U0LzG2/WjphvkcsYbTywM/jaEq1r2FJP7E8oWJtLBOCAeofopIX1jjxCY0OeIIr55Aw5k912I7JugHRDILVgsWoSWXFwnRp58MDiYEIh6WmrqGGenRlMAu+6wNC+Fyh0L0SvZ9swg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f207.google.com with SMTP id e9e14a558f8ab-3a814bfb77bso4923905ab.0
        for <bpf@vger.kernel.org>; Fri, 06 Dec 2024 05:47:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733492842; x=1734097642;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NuAws6VQ8mGzerpOo6fFbh4rcQNx+TjOqsMRzbhwfg8=;
        b=WeInpujhM+1ZN1HrsTRzTB3TniPGV5Ht4KKvSrLBi14AenkDrEx3XKcjJ2ATVHl1YB
         8Ph4lvrqZVnhAkDE4qS6DwsHRzjQC32x1m48eMzIwXIFqE22ESk/8PyxCqpIUMIJMUkM
         2rxe7zgJoCGm0gPoRbGvr2F4yYCS68LW0QTF2JPrNqObof08Mi2F0ilhur1FJtw4HXlI
         euCCGJ0Fh7dtLJE2iIBOJd0+IeMSM1D/m1AUCMzw6vo4EyKgGsLLsbxXoO5jX5iW5yCj
         pcgmVSsAkilEmmo/xxK6s7rlM62CTBu9WXlovbewEccg1Q5QYXOBvPM0ZacCa3KGSuWe
         5QdA==
X-Forwarded-Encrypted: i=1; AJvYcCWvWadxsLIt7nrcWmdUk/b5GGvxUIgTkf1igrlxtt+4kE68YSeRBX5L8i0pLSjC3uMbYdo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAJSZDmVJNQJsqef7UXsNRbI+L0UVUY/FhF1N8YLM3eCveO3lJ
	Pqv+qrUENFBuS//KKUbVX8E7D6sDHf6lff9gbGHfeRVMigMfJHT+or/hy2T0Kdr3JBHgDi/AiQb
	SjD585Lzd1oBu38P/hghc5H5z8NXT4ADT7GuPDpCl6zVxb2kyagUsQiQ=
X-Google-Smtp-Source: AGHT+IEzYCyVg0n08ARqutqBP3VrdhRVOZlrvtE48PAkMGLxogk6wmuaeci376uhZ1eQnDEnARYnRMO88MOEkQwlRcvWyLeU9V28
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1aad:b0:3a7:cf75:30b4 with SMTP id
 e9e14a558f8ab-3a80761d9a4mr85129845ab.10.1733492842016; Fri, 06 Dec 2024
 05:47:22 -0800 (PST)
Date: Fri, 06 Dec 2024 05:47:21 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67530069.050a0220.2477f.0003.GAE@google.com>
Subject: [syzbot] [bpf?] general protection fault in bpf_prog_array_delete_safe
From: syzbot <syzbot+2e0d2840414ce817aaac@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, eddyz87@gmail.com, haoluo@google.com, 
	john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org, 
	linux-kernel@vger.kernel.org, martin.lau@linux.dev, netdev@vger.kernel.org, 
	sdf@fomichev.me, song@kernel.org, syzkaller-bugs@googlegroups.com, 
	yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    e2cf913314b9 Merge branch 'fixes-for-stack-with-allow_ptr_..
git tree:       bpf
console+strace: https://syzkaller.appspot.com/x/log.txt?x=13b5ede8580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=fb680913ee293bcc
dashboard link: https://syzkaller.appspot.com/bug?extid=2e0d2840414ce817aaac
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=132a2020580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1291d0f8580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/487d8ef2aead/disk-e2cf9133.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/899f2234c9d5/vmlinux-e2cf9133.xz
kernel image: https://storage.googleapis.com/syzbot-assets/ea8993a0dfd6/bzImage-e2cf9133.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+2e0d2840414ce817aaac@syzkaller.appspotmail.com

Oops: general protection fault, probably for non-canonical address 0xdffffc0000000002: 0000 [#1] PREEMPT SMP KASAN PTI
KASAN: null-ptr-deref in range [0x0000000000000010-0x0000000000000017]
CPU: 0 UID: 0 PID: 5849 Comm: syz-executor326 Not tainted 6.12.0-syzkaller-09099-ge2cf913314b9 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
RIP: 0010:bpf_prog_array_delete_safe+0x2d/0xc0 kernel/bpf/core.c:2583
Code: 00 41 57 41 56 41 55 41 54 53 49 89 f7 49 89 fd 49 bc 00 00 00 00 00 fc ff df e8 ce 84 f0 ff 4d 8d 75 10 4c 89 f0 48 c1 e8 03 <42> 80 3c 20 00 74 08 4c 89 f7 e8 54 6b 5b 00 49 8b 1e 48 85 db 74
RSP: 0018:ffffc90003807970 EFLAGS: 00010202
RAX: 0000000000000002 RBX: 1ffff92000700f38 RCX: ffff888034eb8000
RDX: 0000000000000000 RSI: ffffc90000abe000 RDI: 0000000000000000
RBP: ffffc90003807a48 R08: ffffffff81a1aa9e R09: 1ffffffff203c816
R10: dffffc0000000000 R11: fffffbfff203c817 R12: dffffc0000000000
R13: 0000000000000000 R14: 0000000000000010 R15: ffffc90000abe000
FS:  0000000000000000(0000) GS:ffff8880b8600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 000000000e738000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 perf_event_detach_bpf_prog+0x2b0/0x330 kernel/trace/bpf_trace.c:2255
 perf_event_free_bpf_prog kernel/events/core.c:10801 [inline]
 _free_event+0xb04/0xf60 kernel/events/core.c:5352
 put_event kernel/events/core.c:5454 [inline]
 perf_event_release_kernel+0x7c1/0x850 kernel/events/core.c:5579
 perf_release+0x38/0x40 kernel/events/core.c:5589
 __fput+0x23c/0xa50 fs/file_table.c:450
 task_work_run+0x24f/0x310 kernel/task_work.c:239
 exit_task_work include/linux/task_work.h:43 [inline]
 do_exit+0xa2f/0x28e0 kernel/exit.c:938
 do_group_exit+0x207/0x2c0 kernel/exit.c:1087
 __do_sys_exit_group kernel/exit.c:1098 [inline]
 __se_sys_exit_group kernel/exit.c:1096 [inline]
 __x64_sys_exit_group+0x3f/0x40 kernel/exit.c:1096
 x64_sys_call+0x26a8/0x26b0 arch/x86/include/generated/asm/syscalls_64.h:232
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f9408276e09
Code: Unable to access opcode bytes at 0x7f9408276ddf.
RSP: 002b:00007fffe6c98ad8 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f9408276e09
RDX: 000000000000003c RSI: 00000000000000e7 RDI: 0000000000000000
RBP: 00007f94082f22b0 R08: ffffffffffffffb8 R09: 0000000000000006
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f94082f22b0
R13: 0000000000000000 R14: 00007f94082f2d00 R15: 00007f9408248040
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:bpf_prog_array_delete_safe+0x2d/0xc0 kernel/bpf/core.c:2583
Code: 00 41 57 41 56 41 55 41 54 53 49 89 f7 49 89 fd 49 bc 00 00 00 00 00 fc ff df e8 ce 84 f0 ff 4d 8d 75 10 4c 89 f0 48 c1 e8 03 <42> 80 3c 20 00 74 08 4c 89 f7 e8 54 6b 5b 00 49 8b 1e 48 85 db 74
RSP: 0018:ffffc90003807970 EFLAGS: 00010202
RAX: 0000000000000002 RBX: 1ffff92000700f38 RCX: ffff888034eb8000
RDX: 0000000000000000 RSI: ffffc90000abe000 RDI: 0000000000000000
RBP: ffffc90003807a48 R08: ffffffff81a1aa9e R09: 1ffffffff203c816
R10: dffffc0000000000 R11: fffffbfff203c817 R12: dffffc0000000000
R13: 0000000000000000 R14: 0000000000000010 R15: ffffc90000abe000
FS:  0000000000000000(0000) GS:ffff8880b8600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 000000007f382000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	00 41 57             	add    %al,0x57(%rcx)
   3:	41 56                	push   %r14
   5:	41 55                	push   %r13
   7:	41 54                	push   %r12
   9:	53                   	push   %rbx
   a:	49 89 f7             	mov    %rsi,%r15
   d:	49 89 fd             	mov    %rdi,%r13
  10:	49 bc 00 00 00 00 00 	movabs $0xdffffc0000000000,%r12
  17:	fc ff df
  1a:	e8 ce 84 f0 ff       	call   0xfff084ed
  1f:	4d 8d 75 10          	lea    0x10(%r13),%r14
  23:	4c 89 f0             	mov    %r14,%rax
  26:	48 c1 e8 03          	shr    $0x3,%rax
* 2a:	42 80 3c 20 00       	cmpb   $0x0,(%rax,%r12,1) <-- trapping instruction
  2f:	74 08                	je     0x39
  31:	4c 89 f7             	mov    %r14,%rdi
  34:	e8 54 6b 5b 00       	call   0x5b6b8d
  39:	49 8b 1e             	mov    (%r14),%rbx
  3c:	48 85 db             	test   %rbx,%rbx
  3f:	74                   	.byte 0x74


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

