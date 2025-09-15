Return-Path: <bpf+bounces-68375-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 422E9B57096
	for <lists+bpf@lfdr.de>; Mon, 15 Sep 2025 08:45:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 09A5017BA35
	for <lists+bpf@lfdr.de>; Mon, 15 Sep 2025 06:45:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EA4D29BD92;
	Mon, 15 Sep 2025 06:45:52 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 928082857EA
	for <bpf@vger.kernel.org>; Mon, 15 Sep 2025 06:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757918752; cv=none; b=JWmrKjsFe9l+Ru7lz2qO1eVclSdK22dPr3DAjPCXvzn2yuvvMH6fiJ0yUHQwLQLaPNyAmb1RoTwR5rR4hVvYZxV8du0STRCasyWw3S6cg2wDiw1aU97KcpTysDlt4lMP50UO9OcPS7S+FHnJb3y/Ad3w5K+sCqjCVq9BPMLU2fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757918752; c=relaxed/simple;
	bh=AT+AsuPqq2WK618t+s+7STR3Dkg/bh9+8b7gdwQ4Pas=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=Y5ZFluU4KSeXyReLvTuURexhU74UAjNS0op0Pr1aGziRz9rlbrzfnx/91veseVLjRUVhhxjL4CjNi1YQHUtdJ6IXudEpkr/BZZnyVn8HntvqlVTopZaMEl7XtnzUW5tzuXl7RfsMffQt5Zd/eX2Cxz06WKpdNZSuU3HwlvBXNZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-42409f4ca72so4254915ab.2
        for <bpf@vger.kernel.org>; Sun, 14 Sep 2025 23:45:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757918749; x=1758523549;
        h=cc:to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tRpDH0c43wMNSp492H9yM0XmbIa153wmucFVV5Ne+pI=;
        b=G44KbAQRBTp99QmE8WOVdD+dRfs/k3HMCD9DqdzJgM2qsU4yeSxljImkEWfXeRK1tW
         I5j7hvCljG6fRxyCBKb125jm8idN81vf/36pPYwCi6a6PmTIYqOoVMlDmy/+xCrslMyr
         3A8w40GcDQ+4AhX3GyqpS3wIEkZjfNrxyll7DKNIRgagsRtzo9ytZwwiIcjxGWly1+VA
         DKweUNRJiCLJbQuPuhKYRvNg7PFRjqV6yhfwX/rCvz4kHp9Zj9L3UkaiiweKtqBR7rM7
         7Afp3Zu/QmeXOeyO56o7kJ4MzCuXzpObN7kJyr8OYGcNI4FdbLNDRITq1aRB8sKXieWG
         vXOA==
X-Forwarded-Encrypted: i=1; AJvYcCUXcADtyR7vV6EoGN8q+zhCc4eyO8cFVvCUEvZ1vigiJCtiB8eyXXVXWUy/i3lPuMfDr+4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZFfTHCdIbVI+2RlUyax3oewxzqX/yhR31kCeunOT38IFiZWUr
	zvzHrnM6Bjf4xHuYnGfhH5wgdguWy29RCOWNqlYj675v/xvF99e2Ffn3ceYeEW9or3g60shKNj2
	8roSRbLzy5MRVnz0yuXpTN6Vs+Au9Zcj+J16mGocLJd07rst3kIdQU2i7o/k=
X-Google-Smtp-Source: AGHT+IFVSZZKqeePGsG/TXtAejtgXy7U2o7zwtFTJRvSH5efZbQvZ2g1bLoQuc9pDXBVNU8NkjS2jIPObvKytLhOb7GRf3Oob//T
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:5e84:b0:423:f9d1:e913 with SMTP id
 e9e14a558f8ab-423f9d1ea88mr48095635ab.31.1757918749706; Sun, 14 Sep 2025
 23:45:49 -0700 (PDT)
Date: Sun, 14 Sep 2025 23:45:49 -0700
In-Reply-To: <cover.1757862238.git.paul.chaignon@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68c7b61d.050a0220.3c6139.08de.GAE@google.com>
Subject: [syzbot ci] Re: bpf: Support non-linear skbs for BPF_PROG_TEST_RUN
From: syzbot ci <syzbot+ci25fe01996a034937@syzkaller.appspotmail.com>
To: ameryhung@gmail.com, andrii@kernel.org, ast@kernel.org, 
	bpf@vger.kernel.org, daniel@iogearbox.net, eddyz87@gmail.com, 
	martin.lau@linux.dev, paul.chaignon@gmail.com
Cc: syzbot@lists.linux.dev, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot ci has tested the following series

[v2] bpf: Support non-linear skbs for BPF_PROG_TEST_RUN
https://lore.kernel.org/all/cover.1757862238.git.paul.chaignon@gmail.com
* [PATCH bpf-next v2 1/4] bpf: Refactor cleanup of bpf_prog_test_run_skb
* [PATCH bpf-next v2 2/4] bpf: Craft non-linear skbs in BPF_PROG_TEST_RUN
* [PATCH bpf-next v2 3/4] selftests/bpf: Support non-linear flag in test loader
* [PATCH bpf-next v2 4/4] selftests/bpf: Test direct packet access on non-linear skbs

and found the following issue:
kernel BUG in bpf_test_init

Full report is available here:
https://ci.syzbot.org/series/23791187-8fc0-4c8a-bebc-3909e311c11e

***

kernel BUG in bpf_test_init

tree:      bpf-next
URL:       https://kernel.googlesource.com/pub/scm/linux/kernel/git/bpf/bpf-next.git
base:      a578b54a8ad282dd739e4d1f4e8352fc8ac1c4a0
arch:      amd64
compiler:  Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
config:    https://ci.syzbot.org/builds/037e1e74-be70-4216-ad05-430c2deea0bb/config
C repro:   https://ci.syzbot.org/findings/adf84c1c-28ba-48f5-9638-8339635cebe5/c_repro
syz repro: https://ci.syzbot.org/findings/adf84c1c-28ba-48f5-9638-8339635cebe5/syz_repro

------------[ cut here ]------------
kernel BUG at arch/x86/mm/physaddr.c:28!
Oops: invalid opcode: 0000 [#1] SMP KASAN PTI
CPU: 1 UID: 0 PID: 6014 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
RIP: 0010:__phys_addr+0x173/0x180 arch/x86/mm/physaddr.c:28
Code: e8 02 2a 4b 00 48 c7 c7 50 d1 fa 8d 48 89 de 4c 89 f2 e8 e0 2f 8b 03 e9 4d ff ff ff e8 e6 29 4b 00 90 0f 0b e8 de 29 4b 00 90 <0f> 0b e8 d6 29 4b 00 90 0f 0b 0f 1f 00 90 90 90 90 90 90 90 90 90
RSP: 0018:ffffc900032d7b68 EFLAGS: 00010293
RAX: ffffffff81749722 RBX: 00006180047f3080 RCX: ffff8881079b9cc0
RDX: 0000000000000000 RSI: 0000000000000061 RDI: 0000000000000000
RBP: 00000000000000db R08: ffff88811fcc20da R09: 0000000000000000
R10: ffff88811fcc2000 R11: ffffed1023f9841c R12: 00000000000000db
R13: 00000000000000db R14: 0000000000000028 R15: 0000000000000061
FS:  000055557464c500(0000) GS:ffff8881a3c13000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 000000001f984000 CR4: 00000000000006f0
Call Trace:
 <TASK>
 virt_to_folio include/linux/mm.h:1180 [inline]
 kfree+0x77/0x440 mm/slub.c:4886
 bpf_test_init+0x1ba/0x220 net/bpf/test_run.c:686
 bpf_prog_test_run_skb+0x2c8/0x1700 net/bpf/test_run.c:1039
 bpf_prog_test_run+0x2c7/0x340 kernel/bpf/syscall.c:4590
 __sys_bpf+0x581/0x870 kernel/bpf/syscall.c:6047
 __do_sys_bpf kernel/bpf/syscall.c:6139 [inline]
 __se_sys_bpf kernel/bpf/syscall.c:6137 [inline]
 __x64_sys_bpf+0x7c/0x90 kernel/bpf/syscall.c:6137
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f502198eba9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffd90d34788 EFLAGS: 00000246 ORIG_RAX: 0000000000000141
RAX: ffffffffffffffda RBX: 00007f5021bd5fa0 RCX: 00007f502198eba9
RDX: 0000000000000050 RSI: 0000200000000240 RDI: 000000000000000a
RBP: 00007f5021a11e19 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f5021bd5fa0 R14: 00007f5021bd5fa0 R15: 0000000000000003
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:__phys_addr+0x173/0x180 arch/x86/mm/physaddr.c:28
Code: e8 02 2a 4b 00 48 c7 c7 50 d1 fa 8d 48 89 de 4c 89 f2 e8 e0 2f 8b 03 e9 4d ff ff ff e8 e6 29 4b 00 90 0f 0b e8 de 29 4b 00 90 <0f> 0b e8 d6 29 4b 00 90 0f 0b 0f 1f 00 90 90 90 90 90 90 90 90 90
RSP: 0018:ffffc900032d7b68 EFLAGS: 00010293
RAX: ffffffff81749722 RBX: 00006180047f3080 RCX: ffff8881079b9cc0
RDX: 0000000000000000 RSI: 0000000000000061 RDI: 0000000000000000
RBP: 00000000000000db R08: ffff88811fcc20da R09: 0000000000000000
R10: ffff88811fcc2000 R11: ffffed1023f9841c R12: 00000000000000db
R13: 00000000000000db R14: 0000000000000028 R15: 0000000000000061
FS:  000055557464c500(0000) GS:ffff8881a3c13000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 000000001f984000 CR4: 00000000000006f0


***

If these findings have caused you to resend the series or submit a
separate fix, please add the following tag to your commit message:
  Tested-by: syzbot@syzkaller.appspotmail.com

---
This report is generated by a bot. It may contain errors.
syzbot ci engineers can be reached at syzkaller@googlegroups.com.

