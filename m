Return-Path: <bpf+bounces-27398-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01D348ACAD3
	for <lists+bpf@lfdr.de>; Mon, 22 Apr 2024 12:37:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 248CB1C202EB
	for <lists+bpf@lfdr.de>; Mon, 22 Apr 2024 10:37:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25D5F1448E1;
	Mon, 22 Apr 2024 10:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NvNn7XoQ"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BBE722625;
	Mon, 22 Apr 2024 10:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713782222; cv=none; b=FC+CL44JNJZbYLUIFdpE2Y7/xt0DYJd4tmfBuTW8zy0P9Q4kvN/tMktZ3mdoj+iZEpN41J0CxI7RyRZzrVLn8OZBFl02Ohv3V53e7H1WWGjiY3AhmlBns3H2hliHi4PIsb1AhFR7x70HmQ/pE18svrdqTgMSRnQxDHrEIXitYcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713782222; c=relaxed/simple;
	bh=n8gef8RT3nsKxxTBm2NGWXOHd1tFNZoyt+MDsqul+48=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o86EEeBRyf3xd3dP0FFunNA6j7i7o8HDl/nlf0/KVRaC3PfW3C7gDb7N2j1YsPURQNlnuKBLMTa/9BhNFpsWaquOpPc9eL+lx4zyc7ZvY988KFlHKPeZn+MsxxcTomlt7lOF14PWAaJs+Bpp4OspWtia7EJ73HhnhBToweUb2Ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NvNn7XoQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28746C4AF08;
	Mon, 22 Apr 2024 10:37:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713782222;
	bh=n8gef8RT3nsKxxTBm2NGWXOHd1tFNZoyt+MDsqul+48=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=NvNn7XoQ4uPkrqZcjCndtaZg70gIDsH4sf+qGcMYwfW2Bc6NU/dpDAeooE7RewFK1
	 HGHzUUYGAJueM1EgLymPtjlaEXARapga2nQ4Bk5r6rfscrpRI5lJ0tmsY74V2NuNnw
	 mMkbTJ3ASI66xJWKVOnQPaXClwD424n2k9Hh/TDAnfg4Jm2pDw1gPLO0PrXPfhfbqx
	 CeIFqVFKA4X/u+ymC6nNBdnQH3GdmgCSwOtFuPlYH+Zd2oFgKu2/nZCxZHNqGvWw++
	 cwHCCAv2HUh65/dxIsflVsEpmJwQwSIRNjX2hA83jcY1Ht1LtA+8Px1bIVFFTsagte
	 L8Ib3aHEBUVLQ==
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a55b2f49206so134025966b.1;
        Mon, 22 Apr 2024 03:37:02 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVHV/UbgBZS7NRJLVZpBmMR1yxwBrLxc9yO5mO1A3XJns5kZMv13oU7Youx5UGkUcjggB4wjYwIbvXGdgQZXSGWX/yzu86qNyUZktfBh6YO06mca91lD/sBMD806Vb/SiaT
X-Gm-Message-State: AOJu0Yx1otPquVcI6OEY9ahg0d/pRt0pisxZQgNeCjxtzHXtmRN1ynXG
	bUhus2NRShae5OYBlsWpZdLc1m4BO7gZ+3t5weaM9JlpTM9KvVOMOQDGoL8JBdqQ0NSfdg3hTiF
	ozPMmOd8r/2Yu8c775tO+h/VkHlY=
X-Google-Smtp-Source: AGHT+IFu7UwN1iC7BnyDvN+FKlE2N8iPA5hSsckiuKIVyNMwvEhsLlsThB45VcSYmiLDake06egnWkcfrY2JSboMgio=
X-Received: by 2002:a17:907:7215:b0:a55:75f7:42fb with SMTP id
 dr21-20020a170907721500b00a5575f742fbmr13673572ejc.24.1713782220612; Mon, 22
 Apr 2024 03:37:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0000000000004792a90615a1dde0@google.com> <CAADnVQKoPfHC_o7jSa0W-gC=fqodmNDeoRO8eaTPN_NxBuXD6w@mail.gmail.com>
 <ZiLzUgbW6dw-FYtf@google.com>
In-Reply-To: <ZiLzUgbW6dw-FYtf@google.com>
From: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
Date: Mon, 22 Apr 2024 12:36:48 +0200
X-Gmail-Original-Message-ID: <CAJ+HfNhNB9uMzri1xcyKmdEnDCm8YetoUWU6r_ms+aiqo3j8EQ@mail.gmail.com>
Message-ID: <CAJ+HfNhNB9uMzri1xcyKmdEnDCm8YetoUWU6r_ms+aiqo3j8EQ@mail.gmail.com>
Subject: Re: [syzbot] [bpf?] BUG: unable to handle kernel paging request in
 bpf_prog_ADDR (2)
To: Stanislav Fomichev <sdf@google.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, 
	syzbot <syzbot+838346b979830606c854@syzkaller.appspotmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Eddy Z <eddyz87@gmail.com>, Hao Luo <haoluo@google.com>, 
	John Fastabend <john.fastabend@gmail.com>, Jiri Olsa <jolsa@kernel.org>, 
	KP Singh <kpsingh@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	syzkaller-bugs <syzkaller-bugs@googlegroups.com>, Yonghong Song <yonghong.song@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, 20 Apr 2024 at 00:42, Stanislav Fomichev <sdf@google.com> wrote:
>
> On 04/19, Alexei Starovoitov wrote:
> > On Mon, Apr 8, 2024 at 8:53=E2=80=AFPM syzbot
> > <syzbot+838346b979830606c854@syzkaller.appspotmail.com> wrote:
> > >
> > > Hello,
> > >
> > > syzbot found the following issue on:
> > >
> > > HEAD commit:    fe46a7dd189e Merge tag 'sound-6.9-rc1' of git://git.k=
ernel..
> > > git tree:       upstream
> > > console+strace: https://syzkaller.appspot.com/x/log.txt?x=3D125962231=
80000
> > > kernel config:  https://syzkaller.appspot.com/x/.config?x=3D4d90a36f0=
cab495a
> > > dashboard link: https://syzkaller.appspot.com/bug?extid=3D838346b9798=
30606c854
> > > compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for=
 Debian) 2.40
> > > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D134ecbb=
5180000
> > > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D141a8b3d1=
80000
> > >
> > > Downloadable assets:
> > > disk image: https://storage.googleapis.com/syzbot-assets/f6c04726a2ae=
/disk-fe46a7dd.raw.xz
> > > vmlinux: https://storage.googleapis.com/syzbot-assets/09c26ce901ea/vm=
linux-fe46a7dd.xz
> > > kernel image: https://storage.googleapis.com/syzbot-assets/134acf7f53=
22/bzImage-fe46a7dd.xz
> > >
> > > IMPORTANT: if you fix the issue, please add the following tag to the =
commit:
> > > Reported-by: syzbot+838346b979830606c854@syzkaller.appspotmail.com
> > >
> > > BUG: unable to handle page fault for address: 0000001000000112
> > > #PF: supervisor read access in kernel mode
> > > #PF: error_code(0x0000) - not-present page
> > > PGD 800000002e7b1067 P4D 800000002e7b1067 PUD 0
> > > Oops: 0000 [#1] PREEMPT SMP KASAN PTI
> > > CPU: 0 PID: 5060 Comm: syz-executor351 Not tainted 6.8.0-syzkaller-08=
951-gfe46a7dd189e #0
> > > Hardware name: Google Google Compute Engine/Google Compute Engine, BI=
OS Google 03/27/2024
> > > RIP: 0010:bpf_prog_a8e24a805b35c61b+0x19/0x1e
> > > Code: cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc f3 0f 1e fa =
0f 1f 44 00 00 66 90 55 48 89 e5 f3 0f 1e fa 31 c0 48 8b 7f 18 <8b> 7f 00 c=
9 c3 cc cc cc cc cc cc 40 03 00 00 cc cc cc cc cc cc cc
> > > RSP: 0018:ffffc90003b07b30 EFLAGS: 00010246
> > > RAX: 0000000000000000 RBX: ffffc90000ace048 RCX: ffff88802aa89e00
> > > RDX: 0000000000000000 RSI: ffffc90000ace048 RDI: 0000001000000112
> > > RBP: ffffc90003b07b30 R08: ffffffff81bf633c R09: 1ffffffff2595ca0
> > > R10: dffffc0000000000 R11: ffffffffa000095c R12: ffffc90000ace030
> > > R13: ffff88802ac3ae28 R14: dffffc0000000000 R15: ffff88802ac3ae28
> > > FS:  000055558f759380(0000) GS:ffff8880b9400000(0000) knlGS:000000000=
0000000
> > > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > CR2: 0000001000000112 CR3: 0000000077cfa000 CR4: 00000000003506f0
> > > DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > > DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > > Call Trace:
> > >  <TASK>
> > >  bpf_dispatcher_nop_func include/linux/bpf.h:1234 [inline]
> > >  __bpf_prog_run include/linux/filter.h:657 [inline]
> > >  bpf_prog_run include/linux/filter.h:664 [inline]
> > >  bpf_prog_run_array_cg kernel/bpf/cgroup.c:51 [inline]
> > >  __cgroup_bpf_run_filter_setsockopt+0x6fa/0x1040 kernel/bpf/cgroup.c:=
1830
> > >  do_sock_setsockopt+0x6b4/0x720 net/socket.c:2293
> > >  __sys_setsockopt+0x1ae/0x250 net/socket.c:2334
> > >  __do_sys_setsockopt net/socket.c:2343 [inline]
> > >  __se_sys_setsockopt net/socket.c:2340 [inline]
> > >  __x64_sys_setsockopt+0xb5/0xd0 net/socket.c:2340
> > >  do_syscall_64+0xfb/0x240
> > >  entry_SYSCALL_64_after_hwframe+0x6d/0x75
> >
> > This one looks interesting.
> > But I cannot reproduce it.
> >
> > Bjorn or Stan,
> >
> > Could you take a look?
> >
> > Probably a race in xdp dispatcher setup or the way cgroup-lsm
> > logic is doing it.
>
> Managed to repro it by hacking the C reproducer to attach bpf prog
> to /sys/fs/cgroup instead of syzkallers custom path. Will try to
> poke it a bit more..

Stan, did you get anywhere? Please share your hack, where you manage
to reproduce the issue.


Cheers,
Bj=C3=B6rn

