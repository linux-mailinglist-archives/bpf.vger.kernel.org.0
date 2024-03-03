Return-Path: <bpf+bounces-23265-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 16C4286F3D5
	for <lists+bpf@lfdr.de>; Sun,  3 Mar 2024 07:48:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5F00AB22F0B
	for <lists+bpf@lfdr.de>; Sun,  3 Mar 2024 06:48:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42B4579D8;
	Sun,  3 Mar 2024 06:48:26 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D7D61869
	for <bpf@vger.kernel.org>; Sun,  3 Mar 2024 06:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709448506; cv=none; b=lJUfwEejbwtuRJYef6SboAkgStfEbSqNMXLm2d8ge6MO0IUqd8Ov3KzjF6fLaSBL24eJVgVtVfykPGHHRLM08OvBJy7pM9nLdKvITw9BgH/ihp7EMy6ZBSK2RjmLwAtB0nlunNW0eCcenTOcMny/1Dr2+YU2+NbZWaANoLp2vjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709448506; c=relaxed/simple;
	bh=/RkFaEv69N54+n+alVnD9ZvnuO4IILRdNsLvW0GRjzc=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=nea16HcHMMmFsfhcKjDCJXBo+bUkTQWrhLRfJccs4y0gxu6FHw2wHMCDMHb5FU/wK1C1B3u3gyL36fTG26pJCkxshu12QqcG4IMbbL1ETzhYe1GD2/dN1VTKcbpJgMy4oyXOsvqKa8QJuAudXmkcQphSlaxzAgDibkU3g+i/v+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7c84b5812e2so13751439f.2
        for <bpf@vger.kernel.org>; Sat, 02 Mar 2024 22:48:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709448503; x=1710053303;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oRY+Um+nXIGBLfrwGmjSxp5HdHzDmIRFT9dg5t6FNxM=;
        b=b52dZ/l8FQUeGIKPMPp0rGgxfHx6VUhDHBnDNk62C+EMEgiAw9MbEjr3iRptjd9RvN
         iNTLIKSZrBA3pln2sXRZrAuYHtLJKWdTM6tEUYUqJj7YsKwUl64soH2kSzIej50F9Nde
         Qc00/S0F6PfzHatrrtTLhEetRRtUq0QBWVBuqfIGSP3c0NG0IFAxk1HMIWc/XtKi1vF2
         6w768JMnFGqp+5U+8jt9INnt/Xtuh2aJfvvEo3vZ27zuyZp7Vb18UBGNZPmCdpiUPM+B
         WdXhYq2pnQHq2eQ8YLKSeulvTtVqKY7z8O3lKPq8i3cp0fYWPpOTMBPtxVYDeHcu75uN
         o0Jg==
X-Forwarded-Encrypted: i=1; AJvYcCUP2ir9dwGjJIxv8U/5J/2QcbEP3p8rPJWhEVVbkYhHn4W4lyEeV/EQS+FjuJpxObCoos90pyqkfVQ5eg/qtQYFCmSZ
X-Gm-Message-State: AOJu0Yx4wAwxncfgjMneY6FmtTTXQXFEuZfrEjKig/mF5xnCk6oZ2A/9
	4pJz8HDKIKvmuL6hD0CVTOllNhMXqB1zWBD/IAtYsls9ZoJZfqVqyhZmwfrR5k2g6mNtzsFglnY
	5DLVz64CcmL9qmm8aTgwBcMo7yPubWtXCPFLSUACK/a9ffhYXnz22jxw=
X-Google-Smtp-Source: AGHT+IE1heZQPqpGkYgIJVnl4gI9nkm/6x7o0digqOKV0BpZ6VtEwn+t6V3vbw7pMW9K1zA98fikUSotPAiW2peux02dXSCvZjJ/
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:408b:b0:474:eb37:5718 with SMTP id
 m11-20020a056638408b00b00474eb375718mr4757jam.0.1709448503711; Sat, 02 Mar
 2024 22:48:23 -0800 (PST)
Date: Sat, 02 Mar 2024 22:48:23 -0800
In-Reply-To: <000000000000a1a6990611ea8b4d@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d3640a0612bbfe22@google.com>
Subject: Re: [syzbot] [bpf?] KMSAN: uninit-value in bpf_bprintf_prepare
From: syzbot <syzbot+c2dc95f7d0825a145992@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, haoluo@google.com, john.fastabend@gmail.com, 
	jolsa@kernel.org, kpsingh@kernel.org, linux-kernel@vger.kernel.org, 
	martin.lau@linux.dev, sdf@google.com, song@kernel.org, 
	syzkaller-bugs@googlegroups.com, xrivendell7@gmail.com, 
	yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    04b8076df253 Merge tag 'firewire-fixes-6.8-rc7' of git://g..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=117de082180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=80c7a82a572c0de3
dashboard link: https://syzkaller.appspot.com/bug?extid=c2dc95f7d0825a145992
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15289dca180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16bc0bba180000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/a4610b1ff2a7/disk-04b8076d.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/991e9d902d39/vmlinux-04b8076d.xz
kernel image: https://storage.googleapis.com/syzbot-assets/a5b8e8e98121/bzImage-04b8076d.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+c2dc95f7d0825a145992@syzkaller.appspotmail.com

=====================================================
BUG: KMSAN: uninit-value in bpf_bprintf_prepare+0x1ec4/0x23b0 kernel/bpf/helpers.c:934
 bpf_bprintf_prepare+0x1ec4/0x23b0 kernel/bpf/helpers.c:934
 ____bpf_snprintf kernel/bpf/helpers.c:1060 [inline]
 bpf_snprintf+0x141/0x360 kernel/bpf/helpers.c:1044
 ___bpf_prog_run+0x2180/0xdb80 kernel/bpf/core.c:1986
 __bpf_prog_run288+0xb5/0xe0 kernel/bpf/core.c:2226
 bpf_dispatcher_nop_func include/linux/bpf.h:1231 [inline]
 __bpf_prog_run include/linux/filter.h:651 [inline]
 bpf_prog_run include/linux/filter.h:658 [inline]
 bpf_prog_run_pin_on_cpu include/linux/filter.h:675 [inline]
 bpf_flow_dissect+0x127/0x470 net/core/flow_dissector.c:991
 bpf_prog_test_run_flow_dissector+0x6f4/0xa20 net/bpf/test_run.c:1359
 bpf_prog_test_run+0x6af/0xac0 kernel/bpf/syscall.c:4107
 __sys_bpf+0x649/0xd60 kernel/bpf/syscall.c:5475
 __do_sys_bpf kernel/bpf/syscall.c:5561 [inline]
 __se_sys_bpf kernel/bpf/syscall.c:5559 [inline]
 __x64_sys_bpf+0xa0/0xe0 kernel/bpf/syscall.c:5559
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcf/0x1e0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x63/0x6b

Local variable stack created at:
 __bpf_prog_run288+0x45/0xe0 kernel/bpf/core.c:2226
 bpf_dispatcher_nop_func include/linux/bpf.h:1231 [inline]
 __bpf_prog_run include/linux/filter.h:651 [inline]
 bpf_prog_run include/linux/filter.h:658 [inline]
 bpf_prog_run_pin_on_cpu include/linux/filter.h:675 [inline]
 bpf_flow_dissect+0x127/0x470 net/core/flow_dissector.c:991

CPU: 0 PID: 5018 Comm: syz-executor377 Not tainted 6.8.0-rc6-syzkaller-00250-g04b8076df253 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/25/2024
=====================================================


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

