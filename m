Return-Path: <bpf+bounces-27444-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 605188AD17C
	for <lists+bpf@lfdr.de>; Mon, 22 Apr 2024 18:03:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C7FFB1F2392B
	for <lists+bpf@lfdr.de>; Mon, 22 Apr 2024 16:03:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14CE6152176;
	Mon, 22 Apr 2024 16:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dfWvv06A"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C949153581
	for <bpf@vger.kernel.org>; Mon, 22 Apr 2024 16:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713801824; cv=none; b=mu+o3F791mXsqKaPlH+DB8RK1Zq5Edbv6oJWzBjQbqbJfB3yM+Q65ZOTF43MA0ai5BZPaaUu3G7zqvaMuvXnJgZp1jCh6Rzc5o3f24EX71IJK0CMWcLjsdcWa9E/TYJsiYRlguPV3+0JakzyUTUTX09G0Jyf8hrUDTFUH4Id/+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713801824; c=relaxed/simple;
	bh=o7xInYt7mqYcLYiHYrPWO6hUeUy4Gvju/GrSYq5PzB4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s6BmgntUoDu15wrl/B68nbYSMr8p2YwoXGDeeqZjYJRM8K419vJnQOmzzqnbB47VKnLbb8Vs/GSsoUlmDmvTEN3TJ+6SxWm+4GbxV2sYvC2ZfISRrDITH2XEohYN8SUsjoep+PDow6SK9lstEL+4lPl4mUaXC7H2r730QbBCXuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dfWvv06A; arc=none smtp.client-ip=209.85.161.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-5af27a0dde1so447573eaf.3
        for <bpf@vger.kernel.org>; Mon, 22 Apr 2024 09:03:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713801820; x=1714406620; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N4dSFLclJoGUNND2F9ap2xz5ZtpVXhVADCdCntPAVe8=;
        b=dfWvv06AZRMLJVv1USulOI04Fp7UOmhchHotMiVhxrtySN9nmSaVcWCw0F1W3jZhV9
         7imvK5oeC+g9ywUNpQCNQtV1jEJDW//wKDJG1hKglZZzcM9ODGEWickcrnHHd0DkHN5c
         o9OVwqTFZXL7O7W9Xc9Ih8Pd+vGS3WvNzugvMcDROHui2q1mUCHXcqJ/QlnQwA4efeRE
         PsmJmQC02pFlVfTIXnT5fmlO4uGxDNKb4YoRd87ij9hlD4/bkEqYi8j2KKsVF1RStkBx
         qdFgyWPKFviItBgK/rsokYCeGAgq5Kg9dsBrCaJoe+TPYuF6/bfaFQSU2IvlyhkHuCdw
         GYhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713801820; x=1714406620;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N4dSFLclJoGUNND2F9ap2xz5ZtpVXhVADCdCntPAVe8=;
        b=hhaS6NQAENwpbYvUmw8J/TsvdyMkewmpxaM8lyQ+7BGt8voML+ty65VFraXAk0BXw3
         wAZ4zLf6rNgspa4yi3Lh7cGYsvLZUmHfdhJRa5+D3i5OjnKT+9PP1cRtRgcdrw+MJPtL
         rXkxJjX1vDFl71YT5G5RghiJJYhckCbeb20h9OferwWRH4Qc5OWgJiw0Lhi/eDvIrBVI
         k30nOR4XIem2m4Q1Hp1ZrkNxkJzK/Y1JZNsrnkcI20pUIlqZt8vOUdToknzpK5TsIuZw
         3FxhCHfEx/GI4uORJ9hfUOVptVYg9A3iD2H1QrkI95F4Rvu+J4KNAuReGmSnEy270yh2
         wiRw==
X-Forwarded-Encrypted: i=1; AJvYcCXxGY0MZi09csk27ygkOafiFYsss9ucVKBiVzUOdQvHUieWAz5oy0mID3mc/fMsBoxwG8Sgsm7VH33HfO/edzt47+8C
X-Gm-Message-State: AOJu0YzfcwyEb5WrKwWP8RQAP4cY7YNnfuvLRJFG7pAE0EMnR7G+z5fV
	SyD2lJAPPNsN1Za535NevXdzkJSJhZzzJ7nbcv4+vD4cS1skfKTgCfBku8zp4ztgXvelSa6uaOB
	QNsoyMIfdmb0u+denSaaz8GZaLrdSKaocMtZT
X-Google-Smtp-Source: AGHT+IFJobejGLyCoyenfsOS02ghwo0U1T7zg7dlHbo0B7PeCmw9xCl22bfNLsNgpLJQff80FnaKoYqE1avaLLAXWss=
X-Received: by 2002:a05:6358:f109:b0:18b:3c71:fa14 with SMTP id
 jh9-20020a056358f10900b0018b3c71fa14mr2257779rwb.5.1713801820334; Mon, 22 Apr
 2024 09:03:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0000000000004792a90615a1dde0@google.com> <CAADnVQKoPfHC_o7jSa0W-gC=fqodmNDeoRO8eaTPN_NxBuXD6w@mail.gmail.com>
 <ZiLzUgbW6dw-FYtf@google.com> <CAJ+HfNhNB9uMzri1xcyKmdEnDCm8YetoUWU6r_ms+aiqo3j8EQ@mail.gmail.com>
In-Reply-To: <CAJ+HfNhNB9uMzri1xcyKmdEnDCm8YetoUWU6r_ms+aiqo3j8EQ@mail.gmail.com>
From: Stanislav Fomichev <sdf@google.com>
Date: Mon, 22 Apr 2024 09:03:26 -0700
Message-ID: <CAKH8qBt-PgGmM3B6-oyt_VFaB4R+2ywcHfCGCQfUj-w+iHTDOg@mail.gmail.com>
Subject: Re: [syzbot] [bpf?] BUG: unable to handle kernel paging request in
 bpf_prog_ADDR (2)
To: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
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

On Mon, Apr 22, 2024 at 3:37=E2=80=AFAM Bj=C3=B6rn T=C3=B6pel <bjorn@kernel=
.org> wrote:
>
> On Sat, 20 Apr 2024 at 00:42, Stanislav Fomichev <sdf@google.com> wrote:
> >
> > On 04/19, Alexei Starovoitov wrote:
> > > On Mon, Apr 8, 2024 at 8:53=E2=80=AFPM syzbot
> > > <syzbot+838346b979830606c854@syzkaller.appspotmail.com> wrote:
> > > >
> > > > Hello,
> > > >
> > > > syzbot found the following issue on:
> > > >
> > > > HEAD commit:    fe46a7dd189e Merge tag 'sound-6.9-rc1' of git://git=
.kernel..
> > > > git tree:       upstream
> > > > console+strace: https://syzkaller.appspot.com/x/log.txt?x=3D1259622=
3180000
> > > > kernel config:  https://syzkaller.appspot.com/x/.config?x=3D4d90a36=
f0cab495a
> > > > dashboard link: https://syzkaller.appspot.com/bug?extid=3D838346b97=
9830606c854
> > > > compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils f=
or Debian) 2.40
> > > > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D134ec=
bb5180000
> > > > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D141a8b3=
d180000
> > > >
> > > > Downloadable assets:
> > > > disk image: https://storage.googleapis.com/syzbot-assets/f6c04726a2=
ae/disk-fe46a7dd.raw.xz
> > > > vmlinux: https://storage.googleapis.com/syzbot-assets/09c26ce901ea/=
vmlinux-fe46a7dd.xz
> > > > kernel image: https://storage.googleapis.com/syzbot-assets/134acf7f=
5322/bzImage-fe46a7dd.xz
> > > >
> > > > IMPORTANT: if you fix the issue, please add the following tag to th=
e commit:
> > > > Reported-by: syzbot+838346b979830606c854@syzkaller.appspotmail.com
> > > >
> > > > BUG: unable to handle page fault for address: 0000001000000112
> > > > #PF: supervisor read access in kernel mode
> > > > #PF: error_code(0x0000) - not-present page
> > > > PGD 800000002e7b1067 P4D 800000002e7b1067 PUD 0
> > > > Oops: 0000 [#1] PREEMPT SMP KASAN PTI
> > > > CPU: 0 PID: 5060 Comm: syz-executor351 Not tainted 6.8.0-syzkaller-=
08951-gfe46a7dd189e #0
> > > > Hardware name: Google Google Compute Engine/Google Compute Engine, =
BIOS Google 03/27/2024
> > > > RIP: 0010:bpf_prog_a8e24a805b35c61b+0x19/0x1e
> > > > Code: cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc f3 0f 1e f=
a 0f 1f 44 00 00 66 90 55 48 89 e5 f3 0f 1e fa 31 c0 48 8b 7f 18 <8b> 7f 00=
 c9 c3 cc cc cc cc cc cc 40 03 00 00 cc cc cc cc cc cc cc
> > > > RSP: 0018:ffffc90003b07b30 EFLAGS: 00010246
> > > > RAX: 0000000000000000 RBX: ffffc90000ace048 RCX: ffff88802aa89e00
> > > > RDX: 0000000000000000 RSI: ffffc90000ace048 RDI: 0000001000000112
> > > > RBP: ffffc90003b07b30 R08: ffffffff81bf633c R09: 1ffffffff2595ca0
> > > > R10: dffffc0000000000 R11: ffffffffa000095c R12: ffffc90000ace030
> > > > R13: ffff88802ac3ae28 R14: dffffc0000000000 R15: ffff88802ac3ae28
> > > > FS:  000055558f759380(0000) GS:ffff8880b9400000(0000) knlGS:0000000=
000000000
> > > > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > > CR2: 0000001000000112 CR3: 0000000077cfa000 CR4: 00000000003506f0
> > > > DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > > > DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > > > Call Trace:
> > > >  <TASK>
> > > >  bpf_dispatcher_nop_func include/linux/bpf.h:1234 [inline]
> > > >  __bpf_prog_run include/linux/filter.h:657 [inline]
> > > >  bpf_prog_run include/linux/filter.h:664 [inline]
> > > >  bpf_prog_run_array_cg kernel/bpf/cgroup.c:51 [inline]
> > > >  __cgroup_bpf_run_filter_setsockopt+0x6fa/0x1040 kernel/bpf/cgroup.=
c:1830
> > > >  do_sock_setsockopt+0x6b4/0x720 net/socket.c:2293
> > > >  __sys_setsockopt+0x1ae/0x250 net/socket.c:2334
> > > >  __do_sys_setsockopt net/socket.c:2343 [inline]
> > > >  __se_sys_setsockopt net/socket.c:2340 [inline]
> > > >  __x64_sys_setsockopt+0xb5/0xd0 net/socket.c:2340
> > > >  do_syscall_64+0xfb/0x240
> > > >  entry_SYSCALL_64_after_hwframe+0x6d/0x75
> > >
> > > This one looks interesting.
> > > But I cannot reproduce it.
> > >
> > > Bjorn or Stan,
> > >
> > > Could you take a look?
> > >
> > > Probably a race in xdp dispatcher setup or the way cgroup-lsm
> > > logic is doing it.
> >
> > Managed to repro it by hacking the C reproducer to attach bpf prog
> > to /sys/fs/cgroup instead of syzkallers custom path. Will try to
> > poke it a bit more..
>
> Stan, did you get anywhere? Please share your hack, where you manage
> to reproduce the issue.

Yes, I think the problem is more naive. The syszbot reproducer manages to a=
ttach
cgroup_skb program to a cgroup_sockopt hook :-/. I'll try to send a
patch this week
to fix it (need to write a proper selftest as well).

> Cheers,
> Bj=C3=B6rn

