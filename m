Return-Path: <bpf+bounces-75293-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0820EC7C6D7
	for <lists+bpf@lfdr.de>; Sat, 22 Nov 2025 05:50:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 109513A7617
	for <lists+bpf@lfdr.de>; Sat, 22 Nov 2025 04:50:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83E4D23D7C8;
	Sat, 22 Nov 2025 04:50:24 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f205.google.com (mail-il1-f205.google.com [209.85.166.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A29BB1EEE6
	for <bpf@vger.kernel.org>; Sat, 22 Nov 2025 04:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763787024; cv=none; b=keRdl2dgyBky2a/ADfAbRn9DfAgvZqJmnERZpnWBTelLgZoecHQ9vMbzeg1tsu6SaVmyDSUJp0zDkFZTQUoCPsVBM/AuwkY7zrTlY2rxt4/d0x1FErvqmWI9CRK8Evu+2M7gWbzN7joriyO9PFllOtS8sUZAo1weicrSIUfbSN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763787024; c=relaxed/simple;
	bh=aZhF8nWhBEcpq4QDyNkJ8KSvofb+bHw7SF5aWtdyKjQ=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=C7zdwa4YfPsVQrtB7dXThxCMq3JGbGqUaeIjAiGKVO8UpiyheVk+1SpWN4PamX2KWmT63T9sy9isOCMpyzI3BxosecPQEXxJd5dhTVVFcpkR5tCB4uXwBFU4kJHmpSW9QCq6PN0lTDAQ/8yY/trkx7VzOc/CyDWbdIAHi1o8fzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f205.google.com with SMTP id e9e14a558f8ab-43335646758so25415355ab.3
        for <bpf@vger.kernel.org>; Fri, 21 Nov 2025 20:50:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763787022; x=1764391822;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=X9gO6e312mGCmC0HQWhrOUvHJzaaStscRS2wI5F6Ck8=;
        b=RNl9Mv2FoPXlUd4JIOmu6tzVzJwZ/giVxLCYaEfcXgNJ0vZRmHfJkcaIH/A2QrQ+pn
         B8jdHhLyMmQiDI8DWox8XoILhE3y+PcKH640oEe8cDtQKTen7Jijx9crpCenUpWXrS++
         AqfQL5Zzl8ZVBO2CERmBDIh5m12lBKnL9avDWv89zYI1tjxq5M1xxTK++hjCuX0RAl18
         dewsr86EiZquQ0Ym26W9v6PMj4NOUHxRlajh/MTE5p7sOUEo2odosPlcpkQLBqjKpQfA
         97g8wCPpGqenopJ+YL58Jr/gYe1XM9Iu/SGx2Rxf1rekKONxK0ZlMngueVaplrU9P9+Q
         vdwA==
X-Forwarded-Encrypted: i=1; AJvYcCXTJA7SA4d4eA5AbWf82S5xmbdcFzCF1WSRlsaajTchBpuDAf9/12+8EmSrC5X9B1ZVAc4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNdVMMCww4aldWTXsGPg4kRMSgva8z0Q7R9qPSaEEGMX/j273C
	0MSbZJkdo35YrY3SSVUwtKuiJo8oNr8Z+oFyrN+tlD3wpIXCOt7L3LbXfiL4ePvC0ueRMMjlKNv
	DQGnELOB6HrZpzM3heU4uK+NQIXvQ0N8zg5+C1WRT+xEQrh6SIhf/a+xq4TQ=
X-Google-Smtp-Source: AGHT+IH8IRcu4U2ZEaCqvQruAqa9VgNJMgcydnXn4kMj4jKKUOElmrlmWFnrFm98+m6lmEVyuAf4nADVMRUscCpCtwIZWwhTZ3so
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2162:b0:433:30e0:6f68 with SMTP id
 e9e14a558f8ab-435b8eb45c3mr39556895ab.24.1763787021745; Fri, 21 Nov 2025
 20:50:21 -0800 (PST)
Date: Fri, 21 Nov 2025 20:50:21 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6921410d.a70a0220.d98e3.0053.GAE@google.com>
Subject: [syzbot] [bpf?] linux-next test error: WARNING: kmalloc bug in bpf_prog_alloc_no_stats
From: syzbot <syzbot+48df175b68984f0d4198@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, eddyz87@gmail.com, haoluo@google.com, 
	john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org, 
	linux-kernel@vger.kernel.org, linux-next@vger.kernel.org, 
	martin.lau@linux.dev, sdf@fomichev.me, sfr@canb.auug.org.au, song@kernel.org, 
	syzkaller-bugs@googlegroups.com, yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    187dac290bfd Add linux-next specific files for 20251118
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=13803212580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f3aa05e175a53177
dashboard link: https://syzkaller.appspot.com/bug?extid=48df175b68984f0d4198
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/5c9f9e2c17d9/disk-187dac29.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/abf1aa794deb/vmlinux-187dac29.xz
kernel image: https://storage.googleapis.com/syzbot-assets/3e5ce6fc9bfd/bzImage-187dac29.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+48df175b68984f0d4198@syzkaller.appspotmail.com

------------[ cut here ]------------
Unexpected gfp: 0x400000 (__GFP_ACCOUNT). Fixing up to gfp: 0xdc0 (GFP_KERNEL|__GFP_ZERO). Fix your code!
WARNING: mm/vmalloc.c:3938 at vmalloc_fix_flags+0x9c/0xe0 mm/vmalloc.c:3937, CPU#1: syz-executor/6175
Modules linked in:
CPU: 1 UID: 0 PID: 6175 Comm: syz-executor Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/25/2025
RIP: 0010:vmalloc_fix_flags+0x9c/0xe0 mm/vmalloc.c:3937
Code: 81 e6 1f 52 ee ff 89 74 24 30 81 e3 e0 ad 11 00 89 5c 24 20 90 48 c7 c7 e0 db 96 8b 4c 89 fa 89 d9 4d 89 f0 e8 75 8d 6c ff 90 <0f> 0b 90 90 8b 44 24 20 48 c7 04 24 0e 36 e0 45 4b c7 04 2c 00 00
RSP: 0018:ffffc90005107b00 EFLAGS: 00010246
RAX: 9deb18dd39b86e00 RBX: 0000000000000dc0 RCX: ffff888079fadb80
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000002
RBP: ffffc90005107b98 R08: 0000000000000003 R09: 0000000000000004
R10: dffffc0000000000 R11: fffffbfff1c3a708 R12: 1ffff92000a20f60
R13: dffffc0000000000 R14: ffffc90005107b20 R15: ffffc90005107b30
FS:  000055557fbce500(0000) GS:ffff888125b74000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f171365c470 CR3: 0000000076216000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 __vmalloc_noprof+0xf2/0x120 mm/vmalloc.c:4124
 bpf_prog_alloc_no_stats+0x4a/0x4d0 kernel/bpf/core.c:106
 bpf_prog_alloc+0x3c/0x1a0 kernel/bpf/core.c:153
 bpf_prog_create_from_user+0xa7/0x440 net/core/filter.c:1443
 seccomp_prepare_filter kernel/seccomp.c:701 [inline]
 seccomp_prepare_user_filter kernel/seccomp.c:738 [inline]
 seccomp_set_mode_filter kernel/seccomp.c:1990 [inline]
 do_seccomp+0x7b1/0xd90 kernel/seccomp.c:2110
 __do_sys_prctl kernel/sys.c:2610 [inline]
 __se_sys_prctl+0xc3c/0x1830 kernel/sys.c:2518
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f1713790b0d
Code: 00 48 89 44 24 18 31 c0 48 8d 44 24 60 c7 04 24 18 00 00 00 48 89 44 24 08 48 8d 44 24 20 48 89 44 24 10 b8 9d 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 1b 48 8b 54 24 18 64 48 2b 14 25 28 00 00 00
RSP: 002b:00007fffcecd72f0 EFLAGS: 00000246 ORIG_RAX: 000000000000009d
RAX: ffffffffffffffda RBX: 00007f171382cf80 RCX: 00007f1713790b0d
RDX: 00007fffcecd7350 RSI: 0000000000000002 RDI: 0000000000000016
RBP: 00007fffcecd7360 R08: 0000000000000006 R09: 0000000000000071
R10: 0000000000000071 R11: 0000000000000246 R12: 000000000000006d
R13: 00007fffcecd7788 R14: 00007fffcecd7a08 R15: 0000000000000000
 </TASK>


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

