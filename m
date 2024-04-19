Return-Path: <bpf+bounces-27266-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 365CE8AB756
	for <lists+bpf@lfdr.de>; Sat, 20 Apr 2024 00:42:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8E011B2131C
	for <lists+bpf@lfdr.de>; Fri, 19 Apr 2024 22:42:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAF5213D636;
	Fri, 19 Apr 2024 22:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WLTX7PNr"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25EFD2BAE6
	for <bpf@vger.kernel.org>; Fri, 19 Apr 2024 22:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713566551; cv=none; b=SxdDvvibMRGCcmUQJjQgKGk/PdKDn9Gd1JDZoTQlF+85RN/8oUxSxEkSj2CjEHn80P+WEu+sU0U9yD+YC1F9b+IaOolBrvojUFR0G0V2tFJhdK8aUgk5uIe244ujRdrt9XopECGA7RCFE6xSqWQGHBIIyvTrgnhUSY1QqR/AilA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713566551; c=relaxed/simple;
	bh=MfpVQcZKZfxcqXnDZkBgrvdLNjb2kvU8wneTGgoLZgA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Jo5ccw6ZFWs/BWddm0ZIRWGG35wygsaQsyNCkh7dG5f1ZXrD2E46fbneGNNEOJ9GFVSEx3JMnRj9IaFLZsjybCIy7poqr53O4JZmrOH7fMdNVOYoRA63Ruq+q2nZMYDVAigKi213IXWMqXuyykQ19t+/YSsA7xvPb4XQ1rk1cgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sdf.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WLTX7PNr; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sdf.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-6ef9edf9910so4058097b3a.1
        for <bpf@vger.kernel.org>; Fri, 19 Apr 2024 15:42:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713566548; x=1714171348; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iy+MJbkT751OdEUQWG0XxX91zD+CE48zRuMpRKz7zBA=;
        b=WLTX7PNrDnlk7UpZ34IygZXakQ7i0wB6OoFRSWM3zhc60ABzrJL5XyuK1X6X2yGLMm
         3h20ZbPbtn8ggbalzcZc9RiZnDPUgu0kDpSSqoVhC5nVPIyawnW/AsZMYREkDvT2vdMN
         eNgYqf6jp+ATjEHJFBzRvM+rzgLF2IlFJ5s7JdRpzHZsT02nNwEWzFl63tNbXlyzq97M
         Lekmg/dZM+BbMZEvXKxCU3aLgKLJoSt3o8lrE9twGjI7de/zOBGOF43sUYcz8Q6fZhbv
         RB8P/nessnxaqNO3yI5REEYlUksE1vH3+DoevE2v2jkBTch8frahFQth65LKm/YKLN97
         d01A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713566548; x=1714171348;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=iy+MJbkT751OdEUQWG0XxX91zD+CE48zRuMpRKz7zBA=;
        b=iDkveCexwWplfma/MMImVq+uCF6u34CuTzxM6YxaDCx0kjDpJRjLcggumxHrrXUnkE
         FtRS0/pbqly2wjDB5dEr15S4WAZ6rdgnmeq3szfcgrJm/ACie7hDZvrbAEwP3nF9ICUE
         tDU2Yk1cp+31GyLjGnUpbQAumFuuvRdYCsl/uhzBojhJXVw8ymptV0cYbcRCTDz5ysEB
         YAQjxoRDCkI23wGfIXmquvqog9f3siTGFYgmWpFUtyqoXyHOjmCovM7zbD8sIgvIa4CN
         kVwWyPWFa99UR380oQU8fx0yfQvsdEiaNM1aEZTVpKFuQqXl26hDSpNvJNSaNLwMG1vE
         IxyQ==
X-Forwarded-Encrypted: i=1; AJvYcCV21k3GmP/HC1CXGF5txuxAOlKYchN7GCnCnk9NIik2W60DWxnfLo/22uvR6Vmhs3sFneewOme7xsf1lFQubZPsO6o6
X-Gm-Message-State: AOJu0YwJyM6NAyiA9/QR4uA5vCwO/ziZ9RP2qpl4cKvTo8GdAjRyzStv
	hgJdAV+HkAeMUoV4hhtluOo90Qt+1vEjWuDvVKaDaujY4qieU2+FJ0oBgwVU1kFE7w==
X-Google-Smtp-Source: AGHT+IHEbFTGGZKOj1oYxGql7quFyu9P/6RgwR2+0LCeGrTUXbIjOmu+vuCD6k+g58hhOyh2nId1a+I=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a05:6a00:3a0c:b0:6ea:be7b:2eda with SMTP id
 fj12-20020a056a003a0c00b006eabe7b2edamr343604pfb.6.1713566548418; Fri, 19 Apr
 2024 15:42:28 -0700 (PDT)
Date: Fri, 19 Apr 2024 15:42:26 -0700
In-Reply-To: <CAADnVQKoPfHC_o7jSa0W-gC=fqodmNDeoRO8eaTPN_NxBuXD6w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <0000000000004792a90615a1dde0@google.com> <CAADnVQKoPfHC_o7jSa0W-gC=fqodmNDeoRO8eaTPN_NxBuXD6w@mail.gmail.com>
Message-ID: <ZiLzUgbW6dw-FYtf@google.com>
Subject: Re: [syzbot] [bpf?] BUG: unable to handle kernel paging request in
 bpf_prog_ADDR (2)
From: Stanislav Fomichev <sdf@google.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: syzbot <syzbot+838346b979830606c854@syzkaller.appspotmail.com>, 
	"=?utf-8?B?QmrDtnJuIFTDtnBlbA==?=" <bjorn@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Eddy Z <eddyz87@gmail.com>, Hao Luo <haoluo@google.com>, 
	John Fastabend <john.fastabend@gmail.com>, Jiri Olsa <jolsa@kernel.org>, 
	KP Singh <kpsingh@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	syzkaller-bugs <syzkaller-bugs@googlegroups.com>, Yonghong Song <yonghong.song@linux.dev>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On 04/19, Alexei Starovoitov wrote:
> On Mon, Apr 8, 2024 at 8:53=E2=80=AFPM syzbot
> <syzbot+838346b979830606c854@syzkaller.appspotmail.com> wrote:
> >
> > Hello,
> >
> > syzbot found the following issue on:
> >
> > HEAD commit:    fe46a7dd189e Merge tag 'sound-6.9-rc1' of git://git.ker=
nel..
> > git tree:       upstream
> > console+strace: https://syzkaller.appspot.com/x/log.txt?x=3D12596223180=
000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=3D4d90a36f0ca=
b495a
> > dashboard link: https://syzkaller.appspot.com/bug?extid=3D838346b979830=
606c854
> > compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for D=
ebian) 2.40
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D134ecbb51=
80000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D141a8b3d180=
000
> >
> > Downloadable assets:
> > disk image: https://storage.googleapis.com/syzbot-assets/f6c04726a2ae/d=
isk-fe46a7dd.raw.xz
> > vmlinux: https://storage.googleapis.com/syzbot-assets/09c26ce901ea/vmli=
nux-fe46a7dd.xz
> > kernel image: https://storage.googleapis.com/syzbot-assets/134acf7f5322=
/bzImage-fe46a7dd.xz
> >
> > IMPORTANT: if you fix the issue, please add the following tag to the co=
mmit:
> > Reported-by: syzbot+838346b979830606c854@syzkaller.appspotmail.com
> >
> > BUG: unable to handle page fault for address: 0000001000000112
> > #PF: supervisor read access in kernel mode
> > #PF: error_code(0x0000) - not-present page
> > PGD 800000002e7b1067 P4D 800000002e7b1067 PUD 0
> > Oops: 0000 [#1] PREEMPT SMP KASAN PTI
> > CPU: 0 PID: 5060 Comm: syz-executor351 Not tainted 6.8.0-syzkaller-0895=
1-gfe46a7dd189e #0
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS=
 Google 03/27/2024
> > RIP: 0010:bpf_prog_a8e24a805b35c61b+0x19/0x1e
> > Code: cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc f3 0f 1e fa 0f=
 1f 44 00 00 66 90 55 48 89 e5 f3 0f 1e fa 31 c0 48 8b 7f 18 <8b> 7f 00 c9 =
c3 cc cc cc cc cc cc 40 03 00 00 cc cc cc cc cc cc cc
> > RSP: 0018:ffffc90003b07b30 EFLAGS: 00010246
> > RAX: 0000000000000000 RBX: ffffc90000ace048 RCX: ffff88802aa89e00
> > RDX: 0000000000000000 RSI: ffffc90000ace048 RDI: 0000001000000112
> > RBP: ffffc90003b07b30 R08: ffffffff81bf633c R09: 1ffffffff2595ca0
> > R10: dffffc0000000000 R11: ffffffffa000095c R12: ffffc90000ace030
> > R13: ffff88802ac3ae28 R14: dffffc0000000000 R15: ffff88802ac3ae28
> > FS:  000055558f759380(0000) GS:ffff8880b9400000(0000) knlGS:00000000000=
00000
> > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > CR2: 0000001000000112 CR3: 0000000077cfa000 CR4: 00000000003506f0
> > DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > Call Trace:
> >  <TASK>
> >  bpf_dispatcher_nop_func include/linux/bpf.h:1234 [inline]
> >  __bpf_prog_run include/linux/filter.h:657 [inline]
> >  bpf_prog_run include/linux/filter.h:664 [inline]
> >  bpf_prog_run_array_cg kernel/bpf/cgroup.c:51 [inline]
> >  __cgroup_bpf_run_filter_setsockopt+0x6fa/0x1040 kernel/bpf/cgroup.c:18=
30
> >  do_sock_setsockopt+0x6b4/0x720 net/socket.c:2293
> >  __sys_setsockopt+0x1ae/0x250 net/socket.c:2334
> >  __do_sys_setsockopt net/socket.c:2343 [inline]
> >  __se_sys_setsockopt net/socket.c:2340 [inline]
> >  __x64_sys_setsockopt+0xb5/0xd0 net/socket.c:2340
> >  do_syscall_64+0xfb/0x240
> >  entry_SYSCALL_64_after_hwframe+0x6d/0x75
>=20
> This one looks interesting.
> But I cannot reproduce it.
>=20
> Bjorn or Stan,
>=20
> Could you take a look?
>=20
> Probably a race in xdp dispatcher setup or the way cgroup-lsm
> logic is doing it.

Managed to repro it by hacking the C reproducer to attach bpf prog
to /sys/fs/cgroup instead of syzkallers custom path. Will try to
poke it a bit more..

