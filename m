Return-Path: <bpf+bounces-76222-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1943ACAA87F
	for <lists+bpf@lfdr.de>; Sat, 06 Dec 2025 15:30:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 30136301D309
	for <lists+bpf@lfdr.de>; Sat,  6 Dec 2025 14:30:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFDB82FA0C4;
	Sat,  6 Dec 2025 14:30:36 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-oo1-f77.google.com (mail-oo1-f77.google.com [209.85.161.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4D0F2F12DE
	for <bpf@vger.kernel.org>; Sat,  6 Dec 2025 14:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765031436; cv=none; b=Hd6apdtof/nA8xVahXzWqE9kDCJKdv+sGR4JcGNBCSYzTG3BrdteJ2k5UnCH3MM//C1WBQoi8koFnLXcbb27cDyvsF87p6/zX0OhDYRTmh1O1T0xtuwoB+GwBewiflLK1EEBvlgnjkR8u5G/g8OkWu+spLR9fmSJEfdfPFYdbIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765031436; c=relaxed/simple;
	bh=3TFhak2YSahSxHE1YUSKNyfo7KjekW4gq4U4X+O9aAM=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=rkM4kmxepGmuqHCAC9pr7EDUt545iOuILWokq5xUsK3dOpbbzRxI487HiLflOB+S2b+PS33afw89FrogBQ3wgPbyAG6mC1DsR39J9Ar3xxoLa2L+/dniLNgcaJqgztFLmhLadEgCDML4uxvPmUOsLYRMR1WGkBpqlFCMIoMo3Bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f77.google.com with SMTP id 006d021491bc7-6579875eaa2so4291488eaf.3
        for <bpf@vger.kernel.org>; Sat, 06 Dec 2025 06:30:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765031433; x=1765636233;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=22XLJG4IoHX/vssE3jx4zVEhx1Ft3Or66I+HMCqbSKs=;
        b=nfatK3PAzGLD6VfY9lGShfWDLWt7oEKpaRHYLBUlcM33poeX0wyKoLDV6qX3dtFj6R
         o3EU0lvfj1tL52/BE4eD4XzCe9p4vdvQZcbMYudFxAxBGs77TLcuGoqD73M7ps9sqG/O
         YAmB9dlaR6bMdo6Wok8IT6upSQvgf+vcD/5AyDFDMlpB5H8ApeLWy4uPpKV3OW1Z0s4X
         silkGM4XVTtMhFAfcvv0XBZRJ1cDNZP2AcS6KBgplhEjeIoZ0k8EcDkpIYqSeRip3LFF
         aQrxqu3CgquXsOisCd1Lyp9G2+xZ7679GA8FdLRzDAndDIQbSxw1qgsLi5u/rDzx0YCk
         lM4g==
X-Forwarded-Encrypted: i=1; AJvYcCWrtaI9LoJE+pXx9vQEWqdZ36fD5YXYTP9w0qK2AgCkEca1BtI7Zk05YP53WZi204YkF8A=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCg08TgkU0Sgc7v/4Vu9Ptw41byjiPUEP/aqKpwIkoPSRj1ASL
	165O7pCcOWxqsdgH+OPNaevhq+UTeuZEPn6qXbNnJaNTZeBglKjNKKaLDXCubbZ6tWVWc17L7UK
	YxoQ7PWO0/XPdy3QTBdvrqz0toiv4NOq5oU/Iqfi/+b7tjsKnR0r5g/BEHtY=
X-Google-Smtp-Source: AGHT+IEEj7MYdKDsPLMjpUH5K24m9WFXs3U4v7IiFPMBic29e52jpBICNzlK0PRVYoNg/wIVEnk1YgNZCozrqPcGwUi8sQAOACEW
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:200f:b0:659:9a49:8fc6 with SMTP id
 006d021491bc7-6599a973d3fmr966986eaf.63.1765031432847; Sat, 06 Dec 2025
 06:30:32 -0800 (PST)
Date: Sat, 06 Dec 2025 06:30:32 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69343e08.a70a0220.38f243.002c.GAE@google.com>
Subject: [syzbot] [bpf?] KMSAN: uninit-value in handle_bug
From: syzbot <syzbot+ba80855313e6fa65717a@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, eddyz87@gmail.com, haoluo@google.com, 
	john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org, 
	linux-kernel@vger.kernel.org, martin.lau@linux.dev, sdf@fomichev.me, 
	song@kernel.org, syzkaller-bugs@googlegroups.com, yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    cc25df3e2e22 Merge tag 'for-6.19/block-20251201' of git://..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16c2eab4580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6c445efc9db431cb
dashboard link: https://syzkaller.appspot.com/bug?extid=ba80855313e6fa65717a
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/a1afac06cfc1/disk-cc25df3e.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/7bd5369ac00a/vmlinux-cc25df3e.xz
kernel image: https://storage.googleapis.com/syzbot-assets/e183dedd04c6/bzImage-cc25df3e.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+ba80855313e6fa65717a@syzkaller.appspotmail.com

------------[ cut here ]------------
=====================================================
BUG: KMSAN: uninit-value in vsnprintf+0x15d9/0x1b30 lib/vsprintf.c:2911
 vsnprintf+0x15d9/0x1b30 lib/vsprintf.c:2911
 vprintk_store+0x3ae/0x1530 kernel/printk/printk.c:2255
 vprintk_emit+0x27b/0xc50 kernel/printk/printk.c:2402
 vprintk_default+0x3f/0x50 kernel/printk/printk.c:2441
 vprintk+0x36/0x50 kernel/printk/printk_safe.c:82
 __warn_printf lib/bug.c:187 [inline]
 __report_bug+0xa53/0xe80 lib/bug.c:240
 report_bug_entry+0x148/0x1d0 lib/bug.c:265
 handle_bug+0xe1/0x230 arch/x86/kernel/traps.c:430
 exc_invalid_op+0x1f/0x50 arch/x86/kernel/traps.c:489
 asm_exc_invalid_op+0x1f/0x30 arch/x86/include/asm/idtentry.h:616
 reg_bounds_sanity_check+0x577/0x1450 kernel/bpf/verifier.c:2742
 reg_set_min_max+0x3be/0x450 kernel/bpf/verifier.c:16572
 check_cond_jmp_op+0x3a87/0x5380 kernel/bpf/verifier.c:17016
 do_check_insn kernel/bpf/verifier.c:20441 [inline]
 do_check+0x23ef/0x16a50 kernel/bpf/verifier.c:20581
 do_check_common+0x2217/0x3370 kernel/bpf/verifier.c:23865
 do_check_main kernel/bpf/verifier.c:23948 [inline]
 bpf_check+0x1e78c/0x27610 kernel/bpf/verifier.c:25255
 bpf_prog_load+0x2af6/0x3100 kernel/bpf/syscall.c:3088
 __sys_bpf+0x7df/0xeb0 kernel/bpf/syscall.c:6164
 __do_sys_bpf kernel/bpf/syscall.c:6274 [inline]
 __se_sys_bpf kernel/bpf/syscall.c:6272 [inline]
 __x64_sys_bpf+0xa4/0xf0 kernel/bpf/syscall.c:6272
 x64_sys_call+0x31c3/0x3e70 arch/x86/include/generated/asm/syscalls_64.h:322
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xd9/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Uninit was stored to memory at:
 vsnprintf+0x15d2/0x1b30 lib/vsprintf.c:-1
 vprintk_store+0x3ae/0x1530 kernel/printk/printk.c:2255
 vprintk_emit+0x27b/0xc50 kernel/printk/printk.c:2402
 vprintk_default+0x3f/0x50 kernel/printk/printk.c:2441
 vprintk+0x36/0x50 kernel/printk/printk_safe.c:82
 __warn_printf lib/bug.c:187 [inline]
 __report_bug+0xa53/0xe80 lib/bug.c:240
 report_bug_entry+0x148/0x1d0 lib/bug.c:265
 handle_bug+0xe1/0x230 arch/x86/kernel/traps.c:430
 exc_invalid_op+0x1f/0x50 arch/x86/kernel/traps.c:489
 asm_exc_invalid_op+0x1f/0x30 arch/x86/include/asm/idtentry.h:616

Local variable run_ctx.i created at:
 __bpf_trace_run kernel/trace/bpf_trace.c:2063 [inline]
 bpf_trace_run4+0xdf/0x590 kernel/trace/bpf_trace.c:2118
 __bpf_trace_sched_switch+0x221/0x290 include/trace/events/sched.h:220

CPU: 1 UID: 0 PID: 23594 Comm: syz.7.5009 Tainted: G        W           syzkaller #0 PREEMPT(none) 
Tainted: [W]=WARN
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/25/2025
=====================================================


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

