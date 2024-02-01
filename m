Return-Path: <bpf+bounces-20990-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AEBB8462A2
	for <lists+bpf@lfdr.de>; Thu,  1 Feb 2024 22:31:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E73A41F255C9
	for <lists+bpf@lfdr.de>; Thu,  1 Feb 2024 21:31:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D40F33EA67;
	Thu,  1 Feb 2024 21:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E/TxOPyS"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 889183D0A4;
	Thu,  1 Feb 2024 21:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706823091; cv=none; b=HWiaz4EOh/e8QHyGNR8apVPWOB0XCNeXFgq6XDeEhkTUjalIt4btc9i9cVUN8mb5e+8wKec4iKvz83lk6boda9pDHhFn8QX1okjzzQt3x+1hh5YdOYe/+DV6MkGLhefi5TvaQ3M4424+70kYgQcSYTr9A1ftTOAqm/CqX87CSas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706823091; c=relaxed/simple;
	bh=RKRuJZDcHzJVM6OssyI2c9q6nynqY2AMDTYesXnZMbk=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UN1wUkugUuAp7EzZMQxtduzr2klH0gQFF5STWICE8FIr+5uHQyp21JOAeTpCjT0L0H7odryF2v3UQ3RJEOS52keLE7VK56Vg0SCeTZknhLuCNfVDTLCmOFU2UOJU+Tt2fWOpBcKT6RBOVRLC9Dwp7AxJ/X60g2ALUEW3ebvOwpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E/TxOPyS; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2d07b400bb8so11758851fa.2;
        Thu, 01 Feb 2024 13:31:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706823087; x=1707427887; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6n8vJLvrRSpKLu7nGCkmJY4eBysRiYCB7GixziU7X0g=;
        b=E/TxOPySE2pqLynu8KFzs0ssVLGqYDnXnU1ZKf47UswAcFZzApzty7vC0jlqqLJFnz
         a+IJ1wTXg5d6aabuPE3Rz5TyL87BlH2T1owLZrDCXQ9DllWWSX6bmZ3uIHtXV9aCyCwy
         GAjnPLGQ/XYxLpGFk6byFgKSdaOIud4ZdfE1gjBlTWg5MYyOmI3gWeEsneroVrVyiLZV
         Z0Q5F9kRPk2rlv85k5ErxiXTGk8iitJFW6yV4GIQkgt7/xZpp8/TvUWcEa9+tmrzAdtB
         1nw6v8KkW3W0hDMLm4Tlguk0qkhy5wETpao77X+vFcgM7F7ll04O5kk6vmsqB+SiNLD0
         /xAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706823087; x=1707427887;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6n8vJLvrRSpKLu7nGCkmJY4eBysRiYCB7GixziU7X0g=;
        b=KXoQDWmAPiv7T1Z0Soh+1445rnw+AS8ZCKwt9ka2cOPRobgiZULutBozg+WMf6oQbI
         o7U7a4TeiOESZaXehiFbepJT4RQUMM8K1FK8yWHHx60Trd41XRB4TXdiT8QUWMIjkbiQ
         qNGzDN3/aQ5by98jBQnlcPlxIwaGPLJeZL1OjChhOZ7m50kycGckaf+7AxdRXc4eAivz
         IvUlB+oDj7aZA6R61JFcsBp6njt5uD1nqVmxgIt/tILZydOdzGbWZ7GTY7j5Z4qhML1M
         PbIC3lvUnS605Qe0NGlCSoW85Y+Ymyf3xogYQ+3mJkxRAFwwioCDy5FNq+b2iGHNWerE
         /3Yg==
X-Gm-Message-State: AOJu0Yyw+76TwpmcHl3SjU/87lF7Rzq9cnMas7blpSpLNFLnRVEk4Vd2
	Zntuz8Hq47h6AewoozNcjEHveFfgolHIYTGgygsV86ke2i8y2Xz6
X-Google-Smtp-Source: AGHT+IFZpTq6sX/Q2weicpKcCIUYb85KsqHg6gZUYWvLCcabBWw6E9n/nVeUeRXTFtD/6IEDYXFU/Q==
X-Received: by 2002:a2e:9cce:0:b0:2cc:f02c:c972 with SMTP id g14-20020a2e9cce000000b002ccf02cc972mr2044536ljj.14.1706823087011;
        Thu, 01 Feb 2024 13:31:27 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVzzRqCvJmDAI2yE2jluj5IE8d5RIOgvJEF2HyxvE8agxW5qGdW3kkSUwN3uLk7Xo+UbPs4ZPje5SRcbc3L3gyieNGoQE5/+9tHlLEgxAGy/KTbnjWBOKbHSaoOketgMWqnQE+361MERJoRuL4BdtDLBUOzqiOAvWoQyg6Qj5SWda/jKL04vSnDi+AMlC8oj5enjJYDBVl995/pZ7RvypjUWotuf51mrptvwQC7++46NctRrSV/LYSOFEOIfhyw/s27SG2g40Cud3dRIIHty81nblFKTMSc4gfv6e4G1IXhuJbBXu6fld5Q6VZYAZB2W37faY7S2WWqeNQYHYo10dUfxLW2G8Z+C4e5CQYIYk3LAXP/7xyoV+vW1s92yYumZBj6DyijbbMPwkpNzNxupxXq3gI/XF3AI62ZY0CUFjy/ruAcnrdfyOVrzPuPrV/s2RFmCQPVdY1VRq6f+zz5oS1590qBKZyxF97COq019bkLLTwhBvSBq9pU1nb8D8Af
Received: from krava ([83.240.62.96])
        by smtp.gmail.com with ESMTPSA id n7-20020a50cc47000000b0055c63205052sm196016edi.37.2024.02.01.13.31.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Feb 2024 13:31:26 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Thu, 1 Feb 2024 22:31:24 +0100
To: syzbot <syzbot+0e9c9f96dbdc31a8431b@syzkaller.appspotmail.com>
Cc: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
	daniel@iogearbox.net, eddyz87@gmail.com, haoluo@google.com,
	john.fastabend@gmail.com, kpsingh@kernel.org,
	linux-kernel@vger.kernel.org, linux-next@vger.kernel.org,
	martin.lau@linux.dev, sdf@google.com, sfr@canb.auug.org.au,
	song@kernel.org, syzkaller-bugs@googlegroups.com,
	yonghong.song@linux.dev
Subject: Re: [syzbot] [bpf?] linux-next boot error: WARNING in
 register_btf_kfunc_id_set
Message-ID: <ZbwNrPmewQXuMDwU@krava>
References: <000000000000e447290610580f33@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000e447290610580f33@google.com>

On Thu, Feb 01, 2024 at 12:44:30PM -0800, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    51b70ff55ed8 Add linux-next specific files for 20240201
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=17b05288180000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=88d85200b6a62126
> dashboard link: https://syzkaller.appspot.com/bug?extid=0e9c9f96dbdc31a8431b
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/f2d3a98d07e5/disk-51b70ff5.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/d525430ddf13/vmlinux-51b70ff5.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/6d1ec0b50066/bzImage-51b70ff5.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+0e9c9f96dbdc31a8431b@syzkaller.appspotmail.com
> 
> greybus: registered new driver hid
> greybus: registered new driver gbphy
> gb_gbphy: registered new driver usb
> asus_wmi: ASUS WMI generic driver loaded
> usbcore: registered new interface driver snd-usb-audio
> usbcore: registered new interface driver snd-ua101
> usbcore: registered new interface driver snd-usb-usx2y
> usbcore: registered new interface driver snd-usb-us122l
> usbcore: registered new interface driver snd-usb-caiaq
> usbcore: registered new interface driver snd-usb-6fire
> usbcore: registered new interface driver snd-usb-hiface
> usbcore: registered new interface driver snd-bcd2000
> usbcore: registered new interface driver snd_usb_pod
> usbcore: registered new interface driver snd_usb_podhd
> usbcore: registered new interface driver snd_usb_toneport
> usbcore: registered new interface driver snd_usb_variax
> drop_monitor: Initializing network drop monitor service
> NET: Registered PF_LLC protocol family
> GACT probability on
> Mirror/redirect action on
> Simple TC action Loaded
> netem: version 1.3
> u32 classifier
>     Performance counters on
>     input device check on
>     Actions configured
> nf_conntrack_irc: failed to register helpers
> nf_conntrack_sane: failed to register helpers
> nf_conntrack_sip: failed to register helpers
> xt_time: kernel timezone is -0000
> IPVS: Registered protocols (TCP, UDP, SCTP, AH, ESP)
> IPVS: Connection hash table configured (size=4096, memory=32Kbytes)
> IPVS: ipvs loaded.
> IPVS: [rr] scheduler registered.
> IPVS: [wrr] scheduler registered.
> IPVS: [lc] scheduler registered.
> IPVS: [wlc] scheduler registered.
> IPVS: [fo] scheduler registered.
> IPVS: [ovf] scheduler registered.
> IPVS: [lblc] scheduler registered.
> IPVS: [lblcr] scheduler registered.
> IPVS: [dh] scheduler registered.
> IPVS: [sh] scheduler registered.
> IPVS: [mh] scheduler registered.
> IPVS: [sed] scheduler registered.
> IPVS: [nq] scheduler registered.
> IPVS: [twos] scheduler registered.
> IPVS: [sip] pe registered.
> ipip: IPv4 and MPLS over IPv4 tunneling driver
> ------------[ cut here ]------------
> WARNING: CPU: 1 PID: 1 at kernel/bpf/btf.c:8131 register_btf_kfunc_id_set+0x261/0x290 kernel/bpf/btf.c:8131
> Modules linked in:
> CPU: 1 PID: 1 Comm: swapper/0 Not tainted 6.8.0-rc2-next-20240201-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/25/2024
> RIP: 0010:register_btf_kfunc_id_set+0x261/0x290 kernel/bpf/btf.c:8131
> Code: 16 e8 b3 fb db ff bd 0b 00 00 00 eb 0a e8 a7 fb db ff bd 0d 00 00 00 89 ef 4c 89 f6 5b 41 5e 41 5f 5d eb 45 e8 90 fb db ff 90 <0f> 0b 90 e9 22 fe ff ff 89 d9 80 e1 07 80 c1 03 38 c1 0f 8c da fd
> RSP: 0000:ffffc90000067940 EFLAGS: 00010293
> RAX: ffffffff81b7d510 RBX: 0000000000000000 RCX: ffff888016a98000
> RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
> RBP: 0000000000000003 R08: ffffffff81b7d311 R09: 1ffffffff1f0b5bd
> R10: dffffc0000000000 R11: fffffbfff1f0b5be R12: 1ffffffff21e0e1d
> R13: dffffc0000000000 R14: ffffffff8caa77c0 R15: dffffc0000000000
> FS:  0000000000000000(0000) GS:ffff8880b9500000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000000000000000 CR3: 000000000df32000 CR4: 00000000003506f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <TASK>
>  fou_init+0x50/0x110 net/ipv4/fou_core.c:1239
>  do_one_initcall+0x238/0x830 init/main.c:1233
>  do_initcall_level+0x157/0x210 init/main.c:1295
>  do_initcalls+0x3f/0x80 init/main.c:1311
>  kernel_init_freeable+0x430/0x5d0 init/main.c:1549
>  kernel_init+0x1d/0x2b0 init/main.c:1439
>  ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
>  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:242
>  </TASK>

should be fixed by https://lore.kernel.org/bpf/CAADnVQJT8nOiiX90g3Pm7Ud0hzBBjBOQmPtPV1iwUYKMcuBFig@mail.gmail.com/

jirka

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
> If you want to overwrite report's subsystems, reply with:
> #syz set subsystems: new-subsystem
> (See the list of subsystem names on the web dashboard)
> 
> If the report is a duplicate of another one, reply with:
> #syz dup: exact-subject-of-another-report
> 
> If you want to undo deduplication, reply with:
> #syz undup

