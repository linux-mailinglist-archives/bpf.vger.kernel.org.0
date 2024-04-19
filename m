Return-Path: <bpf+bounces-27214-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ED0008AAC57
	for <lists+bpf@lfdr.de>; Fri, 19 Apr 2024 12:02:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1CCB21C21023
	for <lists+bpf@lfdr.de>; Fri, 19 Apr 2024 10:02:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F32E97C0BD;
	Fri, 19 Apr 2024 10:02:37 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D048177F11
	for <bpf@vger.kernel.org>; Fri, 19 Apr 2024 10:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713520957; cv=none; b=nbe9fz91vIxxpEmFj3PEqZCtg6aHA8z5dgj0bGp0enSMeN1h4cqUXuu5KCdxkTabSaRQP6boyr1ZqeHPcH9xRA2TE0zny6Ep0q5BScXCgnIKn/7huScdJFgaspCF/Fr+3NzL7ehoIh7gVX4dq5Js1zKELfB+6Y/kJyZKQP3YSvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713520957; c=relaxed/simple;
	bh=Tn22zvqABpEw2xzVGlUAUm5GrhlqYp+YGZ8SBmqcoJw=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=HrI3Et12qxAOtRmlSn/581uqUdLOqbo5tYtCgDDWEJr7R9Bb6coIPTyU4zQPDyrgbrA8MLfMV42w8fV2WxLfts/Iefl0iVVRuLv3oSgpKC+AOFgB+jUtQ23gOpiWFsiQ/U62xTy3NzXgPds+4Wr54AmWN0JOod4MApE/Hx0MLKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7d6bf30c9e3so258819739f.2
        for <bpf@vger.kernel.org>; Fri, 19 Apr 2024 03:02:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713520955; x=1714125755;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ynPtKylq8X+4aLPDiT4qx8aIg5ZAy8z6WAeie2jrlxE=;
        b=ePz96dR+5auUcM43KJt1rDOclxABj3smheB/vJcDMKD072u0en3DaxxLhpm1T9vZhp
         IgrPQsMmOl7Ztkxa1TGTNxrmzH5SHOvbTSj4M9Gu9m9pQBxJ2XkcqxuF6fvPUPvCKreP
         nmykaBIEv7XtLMyFddATUPjY3v0YeM+9ei2m6AU4xsts7Nd9t1kUArFCEHEA2EwVgEbq
         GnDpbjXBSdgk4/pBxyS6Pt3mE4+7tNV9uCEjabMlU27RQ00+tfZJPx98o/bmWFJINQKh
         2wUMttRvJfIXdPmVI48+ffeRpwF7O6R0upl/oCJYZ8SxALjHZcMWuTKQYSyjEuh0DIul
         glSQ==
X-Forwarded-Encrypted: i=1; AJvYcCU9jimaXqo8psm/FnZcQPwjmP8JnzxEhFtTopokNgrlLX6VoaOmiuWphJTbMtL+TdgMUfFflnmZ8PEo0ihcDc1VKMtI
X-Gm-Message-State: AOJu0Ywh4lSA/eVs8Ty0GvLtiZITERETR2Xj8A1lSpSRZwQRamWgYtS+
	hw9RBmxdKTqyRlbeMAQltSRXOvuwzOndCTEqjUMdUpujfa/h08oi8+h8r4pHlUJD9EYT8wBps8T
	aIRl/jTwD5NUAcpDyoRvoikCt7SpPwb2qeh/gYh8Roa+X833adP7gjEc=
X-Google-Smtp-Source: AGHT+IGHd7JEGe67TGfzMYED7GMFT+xDRiBDq+5d4uGXSHkkfwvuvO0kElvRJkGh8gJahNVkE6H9QFN5VkYmqWeMBIHlCZAN7Gog
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:860d:b0:482:ced6:e5f5 with SMTP id
 iu13-20020a056638860d00b00482ced6e5f5mr127743jab.1.1713520955110; Fri, 19 Apr
 2024 03:02:35 -0700 (PDT)
Date: Fri, 19 Apr 2024 03:02:35 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d84c150616702f04@google.com>
Subject: [syzbot] [bpf?] [net?] WARNING in _prb_commit
From: syzbot <syzbot+f86f028ee75b0f7e6e5d@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, davem@davemloft.net, edumazet@google.com, 
	jakub@cloudflare.com, john.fastabend@gmail.com, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    fe46a7dd189e Merge tag 'sound-6.9-rc1' of git://git.kernel..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16834853180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1a07d5da4eb21586
dashboard link: https://syzkaller.appspot.com/bug?extid=f86f028ee75b0f7e6e5d
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/b42ab0fd4947/disk-fe46a7dd.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/b8a6e7231930/vmlinux-fe46a7dd.xz
kernel image: https://storage.googleapis.com/syzbot-assets/4fbf3e4ce6f8/bzImage-fe46a7dd.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+f86f028ee75b0f7e6e5d@syzkaller.appspotmail.com

------------[ cut here ]------------
------------[ cut here ]------------
raw_local_irq_restore() called with IRQs enabled
WARNING: CPU: 0 PID: 7777 at kernel/locking/irqflag-debug.c:10 warn_bogus_irq_restore+0x29/0x30 kernel/locking/irqflag-debug.c:10
Modules linked in:
CPU: 0 PID: 7777 Comm: syz-executor.2 Not tainted 6.8.0-syzkaller-08951-gfe46a7dd189e #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
RIP: 0010:warn_bogus_irq_restore+0x29/0x30 kernel/locking/irqflag-debug.c:10
Code: 90 f3 0f 1e fa 90 80 3d be b2 b5 04 00 74 06 90 e9 3c f8 03 00 c6 05 af b2 b5 04 01 90 48 c7 c7 00 c3 0c 8b e8 98 c2 7d f6 90 <0f> 0b 90 90 eb df 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90
RSP: 0018:ffffc9000336f098 EFLAGS: 00010286
RAX: 0000000000000000 RBX: ffffc9000336f210 RCX: ffffc9000e40e000
RDX: 0000000000040000 RSI: ffffffff8150f3f6 RDI: 0000000000000001
RBP: 0000000000000200 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000001 R12: ffffc9000336f218
R13: 1ffff9200066de15 R14: ffffffff8d785660 R15: 00000000ffffece4
FS:  00007f130d20e6c0(0000) GS:ffff8880b9400000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b33226000 CR3: 00000000235ce000 CR4: 0000000000350ef0
Call Trace:
 <TASK>
 _prb_commit+0x280/0x2e0 kernel/printk/printk_ringbuffer.c:1727
 prb_final_commit+0x1a/0x50 kernel/printk/printk_ringbuffer.c:1780
 vprintk_store+0xa6a/0xb70 kernel/printk/printk.c:2289
 vprintk_emit kernel/printk/printk.c:2323 [inline]
 vprintk_emit+0xac/0x5a0 kernel/printk/printk.c:2297
 vprintk+0x7f/0xa0 kernel/printk/printk_safe.c:45
 _printk+0xc8/0x100 kernel/printk/printk.c:2367
 __report_bug lib/bug.c:195 [inline]
 report_bug+0x4ac/0x580 lib/bug.c:219
 handle_bug+0x3d/0x70 arch/x86/kernel/traps.c:239
 exc_invalid_op+0x17/0x50 arch/x86/kernel/traps.c:260
 asm_exc_invalid_op+0x1a/0x20 arch/x86/include/asm/idtentry.h:621
RIP: 0010:__local_bh_enable_ip+0xc3/0x120 kernel/softirq.c:362
Code: 00 e8 b1 6c 0b 00 e8 cc 68 42 00 fb 65 8b 05 0c f1 b0 7e 85 c0 74 52 5b 5d e9 d9 44 84 09 65 8b 05 4e a5 af 7e 85 c0 75 9e 90 <0f> 0b 90 eb 98 e8 f3 66 42 00 eb 99 48 89 ef e8 29 e0 19 00 eb a2
RSP: 0018:ffffc9000336f568 EFLAGS: 00010046
RAX: 0000000000000000 RBX: 0000000000000201 RCX: 1ffffffff1f3eed7
RDX: 0000000000000000 RSI: 0000000000000201 RDI: ffffffff88cc0674
RBP: ffffffff88cc0674 R08: 0000000000000000 R09: ffffed1002b75801
R10: ffff888015bac00b R11: ffffffff9349a260 R12: fffffffffffffffe
R13: ffff888015bac008 R14: ffff888015bac000 R15: 00000000049396b8
 spin_unlock_bh include/linux/spinlock.h:396 [inline]
 sock_hash_delete_elem+0x1f4/0x260 net/core/sock_map.c:947
 bpf_prog_2c29ac5cdc6b1842+0x42/0x4a
 bpf_dispatcher_nop_func include/linux/bpf.h:1234 [inline]
 __bpf_prog_run include/linux/filter.h:657 [inline]
 bpf_prog_run include/linux/filter.h:664 [inline]
 __bpf_trace_run kernel/trace/bpf_trace.c:2381 [inline]
 bpf_trace_run2+0x154/0x420 kernel/trace/bpf_trace.c:2420
 __bpf_trace_console+0xc7/0x100 include/trace/events/printk.h:10
 __traceiter_console+0x67/0xb0 include/trace/events/printk.h:10
 trace_console include/trace/events/printk.h:10 [inline]
 printk_sprint+0x1e9/0x300 kernel/printk/printk.c:2178
 vprintk_store+0x4e4/0xb70 kernel/printk/printk.c:2273
 vprintk_emit kernel/printk/printk.c:2323 [inline]
 vprintk_emit+0xac/0x5a0 kernel/printk/printk.c:2297
 vprintk+0x7f/0xa0 kernel/printk/printk_safe.c:45
 _printk+0xc8/0x100 kernel/printk/printk.c:2367
 __ext4_warning+0x19d/0x210 fs/ext4/super.c:1031
 ext4_group_extend+0x4d0/0x570 fs/ext4/resize.c:1860
 __ext4_ioctl+0x3617/0x4570 fs/ext4/ioctl.c:1316
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:904 [inline]
 __se_sys_ioctl fs/ioctl.c:890 [inline]
 __x64_sys_ioctl+0x196/0x220 fs/ioctl.c:890
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xd5/0x260 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x6d/0x75
RIP: 0033:0x7f130c47de69
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f130d20e0c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f130c5abf80 RCX: 00007f130c47de69
RDX: 0000000020001412 RSI: 0000000040086607 RDI: 0000000000000008
RBP: 00007f130c4ca47a R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007f130c5abf80 R15: 00007ffcc968f808
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

