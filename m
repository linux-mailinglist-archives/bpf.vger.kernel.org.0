Return-Path: <bpf+bounces-14660-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4500E7E75E1
	for <lists+bpf@lfdr.de>; Fri, 10 Nov 2023 01:21:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE066281488
	for <lists+bpf@lfdr.de>; Fri, 10 Nov 2023 00:21:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D6C1382;
	Fri, 10 Nov 2023 00:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nh8c8tyM"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E808A367
	for <bpf@vger.kernel.org>; Fri, 10 Nov 2023 00:21:11 +0000 (UTC)
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60EA2211D
	for <bpf@vger.kernel.org>; Thu,  9 Nov 2023 16:21:11 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5b053454aeeso20673397b3.0
        for <bpf@vger.kernel.org>; Thu, 09 Nov 2023 16:21:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699575670; x=1700180470; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=LxhicvbpcfiNB/SqLWsFJ4NUajhrTtHz+OGFndK/8ko=;
        b=nh8c8tyMKxIWrQPKrSQ1qfBQB/W/26TVnWevTZDDMQFxK/zhFeTVui3RKTHSaz2jD/
         FyM791H2ruDAStCQufWEu12WqObROZxlc8jXvAA281Mtgk/De+OweDVjwtR4Wiv4fE9K
         aZNG0SfLXTamVI8PoIBgmb0ChdQ9oxI5t8avD7kWjXvZrtF6T6BDp6L8Ie7XJtp+m1Ya
         kBO0SYiCpr48M2pMlfhqWBFxfQ4Ko6uBU1elBhMBzlHOsAirUMojHPOvh/DtqZbgmEcZ
         nZB2BttpSitnONBiEakVlo2RG04xB6IJ/pfORli5T6cY/1j6mG9LIf5Tj2ZK/2qF7PT5
         qtrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699575670; x=1700180470;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LxhicvbpcfiNB/SqLWsFJ4NUajhrTtHz+OGFndK/8ko=;
        b=a2Ocj97sCI2ievmoJYHzOOemlfIxoa/hdVLuEAC2gofLJoBR0DGnxHg+P6M/hGvZdH
         xX0FW+nEXXLGSWVpDaq+M1c44lQCij/vsezerF0W7XimUZKVTFIYrhGYn+BLGNb+VgaB
         J3BylL8b/wEcnGo5Uu1TgmaO5IXKNjY5MsOyFdrKcX1oCkrzABM2W/Yaw3nC3Hmm7YEr
         /QLsxrR1jZ9F4QRrQ72Gd9jFWnTZacmE1tvgLHlKSqLYggM5oojqkrByP4LyQNb3L8SA
         7BEUEoIPfUVdZXUlFAQqab89Qzi3rSVJC4HvwOea1m62lq3rGFxTpmD/DoyaHnVSh39u
         Nacw==
X-Gm-Message-State: AOJu0Yy2vcx9B24yYhafRnVubmMUusE/WZjGYlb39mpxIKMnkNUGhWTz
	kDvow5w77se4I3MDEKhZuVjrDAk=
X-Google-Smtp-Source: AGHT+IHdM+b0I72d1ra/enktoSSFQzegUY0et8CAIHvRq/SiuJsSKmN48rIXNlL2wN3x30H9sl2gKqM=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a05:690c:e19:b0:5bf:5d6e:1f5a with SMTP id
 cp25-20020a05690c0e1900b005bf5d6e1f5amr115872ywb.3.1699575670629; Thu, 09 Nov
 2023 16:21:10 -0800 (PST)
Date: Thu, 9 Nov 2023 16:21:09 -0800
In-Reply-To: <000000000000d078d30609b138ba@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <000000000000d078d30609b138ba@google.com>
Message-ID: <ZU13dQb2z66CJlYi@google.com>
Subject: Re: [syzbot] [net?] BUG: unable to handle kernel paging request in nsim_bpf
From: Stanislav Fomichev <sdf@google.com>
To: syzbot <syzbot+44c2416196b7c607f226@syzkaller.appspotmail.com>
Cc: ast@kernel.org, bpf@vger.kernel.org, daniel@iogearbox.net, 
	davem@davemloft.net, edumazet@google.com, hawk@kernel.org, 
	john.fastabend@gmail.com, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="utf-8"

On 11/08, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:

Looks like we need to have a distinction between dev-bound vs
dev-offloaded. I'll try to poke it.

> HEAD commit:    8de1e7afcc1c Merge branch 'for-next/core' into for-kernelci
> git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
> console output: https://syzkaller.appspot.com/x/log.txt?x=158c647b680000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3e6feaeda5dcbc27
> dashboard link: https://syzkaller.appspot.com/bug?extid=44c2416196b7c607f226
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> userspace arch: arm64
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=104da6eb680000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14df3787680000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/0f00907f9764/disk-8de1e7af.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/0502fe78c60d/vmlinux-8de1e7af.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/192135168cc0/Image-8de1e7af.gz.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+44c2416196b7c607f226@syzkaller.appspotmail.com
> 
> netdevsim netdevsim0 netdevsim1: set [1, 0] type 2 family 0 port 6081 - 0
> netdevsim netdevsim0 netdevsim2: set [1, 0] type 2 family 0 port 6081 - 0
> netdevsim netdevsim0 netdevsim3: set [1, 0] type 2 family 0 port 6081 - 0
> Unable to handle kernel paging request at virtual address dfff800000000003
> KASAN: null-ptr-deref in range [0x0000000000000018-0x000000000000001f]
> Mem abort info:
>   ESR = 0x0000000096000005
>   EC = 0x25: DABT (current EL), IL = 32 bits
>   SET = 0, FnV = 0
>   EA = 0, S1PTW = 0
>   FSC = 0x05: level 1 translation fault
> Data abort info:
>   ISV = 0, ISS = 0x00000005, ISS2 = 0x00000000
>   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
>   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
> [dfff800000000003] address between user and kernel address ranges
> Internal error: Oops: 0000000096000005 [#1] PREEMPT SMP
> Modules linked in:
> CPU: 0 PID: 6085 Comm: syz-executor153 Not tainted 6.6.0-rc7-syzkaller-g8de1e7afcc1c #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/06/2023
> pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> pc : nsim_setup_prog_hw_checks drivers/net/netdevsim/bpf.c:320 [inline]
> pc : nsim_bpf+0x1e0/0xae0 drivers/net/netdevsim/bpf.c:562
> lr : nsim_bpf+0x8c/0xae0 drivers/net/netdevsim/bpf.c:554
> sp : ffff800096c67790
> x29: ffff800096c677a0 x28: dfff800000000000 x27: ffff700012d8cf00
> x26: dfff800000000000 x25: ffff800096c67a00 x24: 0000000000000008
> x23: ffff800096c67820 x22: 0000000000000018 x21: ffff800096c67820
> x20: ffff0000d3834cc0 x19: ffff0000d3834000 x18: ffff800096c67580
> x17: ffff8000805c1258 x16: ffff80008030c738 x15: 0000000000000000
> x14: 0000000000000000 x13: 0000000000000000 x12: 0000000000000003
> x11: ffff0000d4ab3780 x10: 00000000000000bc x9 : ffff800085ce8bf0
> x8 : 0000000000000003 x7 : 0000000000000000 x6 : 0000000000000000
> x5 : ffff800092dee000 x4 : 0000000000000000 x3 : ffff80008030c754
> x2 : 0000000000000000 x1 : ffff80009001ef50 x0 : 0000000000000001
> Call trace:
>  nsim_setup_prog_hw_checks drivers/net/netdevsim/bpf.c:320 [inline]
>  nsim_bpf+0x1e0/0xae0 drivers/net/netdevsim/bpf.c:562
>  dev_xdp_install+0x124/0x2f0 net/core/dev.c:9199
>  dev_xdp_attach+0xa4c/0xcc8 net/core/dev.c:9351
>  dev_xdp_attach_link net/core/dev.c:9370 [inline]
>  bpf_xdp_link_attach+0x300/0x710 net/core/dev.c:9540
>  link_create+0x2c0/0x68c kernel/bpf/syscall.c:4954
>  __sys_bpf+0x4d4/0x5dc kernel/bpf/syscall.c:5414
>  __do_sys_bpf kernel/bpf/syscall.c:5448 [inline]
>  __se_sys_bpf kernel/bpf/syscall.c:5446 [inline]
>  __arm64_sys_bpf+0x80/0x98 kernel/bpf/syscall.c:5446
>  __invoke_syscall arch/arm64/kernel/syscall.c:37 [inline]
>  invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:51
>  el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:136
>  do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:155
>  el0_svc+0x54/0x158 arch/arm64/kernel/entry-common.c:678
>  el0t_64_sync_handler+0x84/0xfc arch/arm64/kernel/entry-common.c:696
>  el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:595
> Code: 96b3720d f94002c8 91006116 d343fec8 (387a6908) 
> ---[ end trace 0000000000000000 ]---
> ----------------
> Code disassembly (best guess):
>    0:	96b3720d 	bl	0xfffffffffacdc834
>    4:	f94002c8 	ldr	x8, [x22]
>    8:	91006116 	add	x22, x8, #0x18
>    c:	d343fec8 	lsr	x8, x22, #3
> * 10:	387a6908 	ldrb	w8, [x8, x26] <-- trapping instruction
> 
> 
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
> 
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> 
> If the report is already addressed, let syzbot know by replying with:
> #syz fix: exact-commit-title
> 
> If you want syzbot to run the reproducer, reply with:
> #syz test: git://repo/address.git branch-or-commit-hash
> If you attach or paste a git patch, syzbot will apply it before testing.
> 
> If you want to overwrite report's subsystems, reply with:
> #syz set subsystems: new-subsystem
> (See the list of subsystem names on the web dashboard)
> 
> If the report is a duplicate of another one, reply with:
> #syz dup: exact-subject-of-another-report
> 
> If you want to undo deduplication, reply with:
> #syz undup

