Return-Path: <bpf+bounces-69351-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFCFCB951B8
	for <lists+bpf@lfdr.de>; Tue, 23 Sep 2025 11:02:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48DA83A4781
	for <lists+bpf@lfdr.de>; Tue, 23 Sep 2025 09:02:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72C8F31D388;
	Tue, 23 Sep 2025 09:02:34 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f205.google.com (mail-il1-f205.google.com [209.85.166.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FC772ECD33
	for <bpf@vger.kernel.org>; Tue, 23 Sep 2025 09:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758618154; cv=none; b=s9//fj6sT8JITAudXV8wARhHNN9KQTTcV1DLM/wUk2gQG+FMh2DIac/sR8yQiIjtD/UEoNiGTlPygEQt+QZlY+ByMfpRUSg/xHz2eouKbeeyN2LT1/d6+zGgCGw6YdSqTttQyfoT9QuwwQmRHH2KOL5J8z3tKiPCySRoeLwMzWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758618154; c=relaxed/simple;
	bh=9cdjBUOvaenS1SvUrOQfePrP4+lJYNoP0MFF0Iphy6w=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=dAnN4u3a680PFA6Zh4fCYiE+YJ66DQyk9maWTLF/ncoEBq9ncjnYMiHDryg7i8JVvsg9U/OalJGBJXgCOZJduLY6o/RzhigBv2UDu2NylfompiVpgg/1Sdz4SbBLa2CrfJIKlo4cGvRSQXs4WZgC5hwaMkFaEfGSK2Z8AQ+cL4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f205.google.com with SMTP id e9e14a558f8ab-4248d44a345so42676025ab.1
        for <bpf@vger.kernel.org>; Tue, 23 Sep 2025 02:02:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758618151; x=1759222951;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uqLnm2IV4iRJ0QPNc8H+0uuFGcNyE2JfSTTgxiSiusk=;
        b=kMQI8HZEifrkRCR5Q0l77RNZKfkAfm54ybU/W9MVhNLKXX/bdqkoZ8n2qSdlOBg4H9
         W7wvmK00kw2NrTd8wmp+DZEoZ4iGS8sKfdosV8nm/uIkh9y3DJr4N8OMw208lpCsATKB
         ij9LarJpnUMrMGn8mXfor0lpnVxebzUuP4nS4XrrOmMk8JWsReY3W2SMt8Y4nR0keTpU
         VzSexBGIuWg22+HAJKHGcsj0e4W/VrlyHM2MufmUZq4FxxCR1Tk9gdGH1bkRoZ8MAWnx
         jPFv636IeSIDM7kYOEDSrj8ntlOrqUYcR3cr403hHWdGAyx9NxvFVTJ4daYJvYtl1cHs
         41Uw==
X-Forwarded-Encrypted: i=1; AJvYcCVsbfKTuMc0QZDenm2zEQuh4fa/dGyWL6mq05QkSsidrV+X3xvFd1GHxFYO+Rf9uNVz8kU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRMm8lwgxg0mrBOHG4QcdJGTgxTz1+/rjzdBQLrHqxwERx8gVw
	BcXUkVLgV5rLAVVAE1MM1bslOC8hYiBnUuK+tLAYYapTqJvE5plBynNOk1DePxQrQKRKQrmuhxa
	wr1hGh4VzzF9hDz/9XtOHFfGLJKF9xBIa2PIF6tsAaNk5Cx6v3+4YZ0STjs8=
X-Google-Smtp-Source: AGHT+IH/l6Q4yau15bir0aQevIA+o0yPxgBau9pNkmSLV48NAAVuv9PTR5A+vOkJCwt2wa/NyZGWgMZT2tbsWxkmsC7DGxWDlpQm
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:258a:b0:423:b2b8:99c6 with SMTP id
 e9e14a558f8ab-42581ea4925mr21839885ab.21.1758618151577; Tue, 23 Sep 2025
 02:02:31 -0700 (PDT)
Date: Tue, 23 Sep 2025 02:02:31 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68d26227.a70a0220.1b52b.02a4.GAE@google.com>
Subject: [syzbot] [bpf?] general protection fault in print_reg_state
From: syzbot <syzbot+d36d5ae81e1b0a53ef58@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, eddyz87@gmail.com, haoluo@google.com, 
	john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org, 
	linux-kernel@vger.kernel.org, martin.lau@linux.dev, sdf@fomichev.me, 
	song@kernel.org, syzkaller-bugs@googlegroups.com, yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    cec1e6e5d1ab Merge tag 'sched_ext-for-6.17-rc7-fixes' of g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=175418e2580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8f01d8629880e620
dashboard link: https://syzkaller.appspot.com/bug?extid=d36d5ae81e1b0a53ef58
compiler:       gcc (Debian 12.2.0-14+deb12u1) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=113bf8e2580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1608c27c580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-cec1e6e5.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/2833a04dba30/vmlinux-cec1e6e5.xz
kernel image: https://storage.googleapis.com/syzbot-assets/632491f232df/bzImage-cec1e6e5.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+d36d5ae81e1b0a53ef58@syzkaller.appspotmail.com

Oops: general protection fault, probably for non-canonical address 0xdffffc000000000c: 0000 [#1] SMP KASAN NOPTI
KASAN: null-ptr-deref in range [0x0000000000000060-0x0000000000000067]
CPU: 1 UID: 0 PID: 6117 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:print_reg_state+0x2dc/0x1010 kernel/bpf/log.c:719
Code: c1 ea 03 80 3c 02 00 0f 85 5c 0c 00 00 48 ba 00 00 00 00 00 fc ff df 4c 8b 7b 08 49 8d 47 60 48 89 c1 48 89 04 24 48 c1 e9 03 <0f> b6 14 11 84 d2 74 06 0f 8e 45 0b 00 00 41 0f b6 57 60 48 8b 44
RSP: 0018:ffffc90004e67398 EFLAGS: 00010206
RAX: 0000000000000060 RBX: ffff8880275a5000 RCX: 000000000000000c
RDX: dffffc0000000000 RSI: ffffffff81daeb8b RDI: 0000000000000005
RBP: ffffc90004e674b0 R08: 0000000000000005 R09: 0000000000000002
R10: 0000000000000000 R11: 0000000000000000 R12: ffff888037df0000
R13: 0000000000000003 R14: 1ffff920009cce79 R15: 0000000000000000
FS:  0000555587b13500(0000) GS:ffff8880d67b2000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000200000000100 CR3: 0000000033bb5000 CR4: 0000000000352ef0
Call Trace:
 <TASK>
 print_verifier_state+0x234/0x1170 kernel/bpf/log.c:775
 do_check kernel/bpf/verifier.c:20071 [inline]
 do_check_common+0x283e/0xb410 kernel/bpf/verifier.c:23264
 do_check_main kernel/bpf/verifier.c:23347 [inline]
 bpf_check+0x869f/0xc670 kernel/bpf/verifier.c:24707
 bpf_prog_load+0xe41/0x2490 kernel/bpf/syscall.c:2979
 __sys_bpf+0x4a3f/0x4de0 kernel/bpf/syscall.c:6029
 __do_sys_bpf kernel/bpf/syscall.c:6139 [inline]
 __se_sys_bpf kernel/bpf/syscall.c:6137 [inline]
 __x64_sys_bpf+0x78/0xc0 kernel/bpf/syscall.c:6137
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xcd/0x4e0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f1041d8eec9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffd44cefdd8 EFLAGS: 00000246 ORIG_RAX: 0000000000000141
RAX: ffffffffffffffda RBX: 00007f1041fe5fa0 RCX: 00007f1041d8eec9
RDX: 0000000000000094 RSI: 0000200000000100 RDI: 0000000000000005
RBP: 00007f1041e11f91 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f1041fe5fa0 R14: 00007f1041fe5fa0 R15: 0000000000000003
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:print_reg_state+0x2dc/0x1010 kernel/bpf/log.c:719
Code: c1 ea 03 80 3c 02 00 0f 85 5c 0c 00 00 48 ba 00 00 00 00 00 fc ff df 4c 8b 7b 08 49 8d 47 60 48 89 c1 48 89 04 24 48 c1 e9 03 <0f> b6 14 11 84 d2 74 06 0f 8e 45 0b 00 00 41 0f b6 57 60 48 8b 44
RSP: 0018:ffffc90004e67398 EFLAGS: 00010206
RAX: 0000000000000060 RBX: ffff8880275a5000 RCX: 000000000000000c
RDX: dffffc0000000000 RSI: ffffffff81daeb8b RDI: 0000000000000005
RBP: ffffc90004e674b0 R08: 0000000000000005 R09: 0000000000000002
R10: 0000000000000000 R11: 0000000000000000 R12: ffff888037df0000
R13: 0000000000000003 R14: 1ffff920009cce79 R15: 0000000000000000
FS:  0000555587b13500(0000) GS:ffff8880d67b2000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000200000000100 CR3: 0000000033bb5000 CR4: 0000000000352ef0
----------------
Code disassembly (best guess):
   0:	c1 ea 03             	shr    $0x3,%edx
   3:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1)
   7:	0f 85 5c 0c 00 00    	jne    0xc69
   d:	48 ba 00 00 00 00 00 	movabs $0xdffffc0000000000,%rdx
  14:	fc ff df
  17:	4c 8b 7b 08          	mov    0x8(%rbx),%r15
  1b:	49 8d 47 60          	lea    0x60(%r15),%rax
  1f:	48 89 c1             	mov    %rax,%rcx
  22:	48 89 04 24          	mov    %rax,(%rsp)
  26:	48 c1 e9 03          	shr    $0x3,%rcx
* 2a:	0f b6 14 11          	movzbl (%rcx,%rdx,1),%edx <-- trapping instruction
  2e:	84 d2                	test   %dl,%dl
  30:	74 06                	je     0x38
  32:	0f 8e 45 0b 00 00    	jle    0xb7d
  38:	41 0f b6 57 60       	movzbl 0x60(%r15),%edx
  3d:	48                   	rex.W
  3e:	8b                   	.byte 0x8b
  3f:	44                   	rex.R


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

