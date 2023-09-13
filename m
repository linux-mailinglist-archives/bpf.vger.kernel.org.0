Return-Path: <bpf+bounces-9854-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6436E79DDF6
	for <lists+bpf@lfdr.de>; Wed, 13 Sep 2023 03:49:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B97E1C20E6E
	for <lists+bpf@lfdr.de>; Wed, 13 Sep 2023 01:49:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13C24396;
	Wed, 13 Sep 2023 01:49:28 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D14D8384
	for <bpf@vger.kernel.org>; Wed, 13 Sep 2023 01:49:27 +0000 (UTC)
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA616B2
	for <bpf@vger.kernel.org>; Tue, 12 Sep 2023 18:49:26 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-501cef42bc9so10320839e87.0
        for <bpf@vger.kernel.org>; Tue, 12 Sep 2023 18:49:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694569765; x=1695174565; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kqqZczQ5FB/PKTV0ke6RrJq1FMBCiNEbSD8ICMiDreA=;
        b=frEBD4cQEeNnHTpCsrZmn//Onwi+rrQvaQcjHzkpGpWyyp840qclpJ8wNr9WXHTl2k
         kLsJQ6BtNWzZxZzwIOROB9i0frk/ImfEWjLnHusI1i24/O/oDF51wLZdz6FGvSvTUqrN
         Wd1e4+T+cy0ucU3C9UVvX82dDfH+VnbsMDZdesEDCzgKZBcAQtNxtA3/9/BjiYAxZVfr
         unL6bdfT+Cu0mmSGKzeQ65+ELwnP++1xfcNXC2bVHlvwQW1dCVI+D75+bVFI7jL5iz0d
         gG9DEWGeF4vSvoqAhM2GUXzOu7imQyaYh1g9rGK8Smo8V1Wh47k9Fnl6v0as9T6DIYbN
         e7SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694569765; x=1695174565;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kqqZczQ5FB/PKTV0ke6RrJq1FMBCiNEbSD8ICMiDreA=;
        b=shPtTlzBiH0pamI0yZeDjVHvX0/Wk17MvdffXhjd8QJYHqr+3Jxw6OmCsL4SwaXnvV
         qaqadlbQhIAmfM1jo6ewKbtFlw9t3Bdv128yZpmr2nSf2/nETdqSkO7r5AqRIbe7P3Rk
         YYw7zUgroJw2PwjOJcU6eutOzcdIGjdzBzk/5RkhrvtyQ5Y9QJxFK91Um1OxT8QZDv4N
         VLn6or9vvyLKquQzPQ5JY6txilqhNqShYumdrYO1eJ4DNQV1nz+QfhGM5orI8DjnwlZj
         KFeSxBPCPCOvDkC7FWrrh3M9RxfXNH7pBwpRPWl8R9mY6hMrYn+C/Dl4sXCizY/oKoMi
         rKSA==
X-Gm-Message-State: AOJu0YwARmkR5mR3mB/TvNn5B1a6haINEvPcGHmrt2L+X0/ZkXbDJ+l2
	f55bYCDoT6Gi+9OwustQn4k9H1pRcqWXDLW8ZiE=
X-Google-Smtp-Source: AGHT+IGacUHwSkxZGr6lt+NcVz6m4lp1xChWzJ0aP0bsdILioH5c/G/+/uERWNltTlNWXigL4p2kihjhDmHT7TUjfkw=
X-Received: by 2002:a05:6512:2e3:b0:4fb:8ee0:b8a5 with SMTP id
 m3-20020a05651202e300b004fb8ee0b8a5mr684818lfq.46.1694569764669; Tue, 12 Sep
 2023 18:49:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230830011128.1415752-1-iii@linux.ibm.com> <20230830011128.1415752-2-iii@linux.ibm.com>
 <CANk7y0iNnOCZ_KmXBH_xJTG=BKzkDM_jZ+hc_NXcQbbZj-c33Q@mail.gmail.com>
 <mb61p5y4u3ptd.fsf@amazon.com> <CAADnVQ+u1hMBS3rm=meQaAgujHf6bOvONrwg6nYh1qWzVLVoAA@mail.gmail.com>
 <mb61p4jk630a9.fsf@amazon.com> <CAADnVQJCc6t82H+iFXvhs=mfg1DMxZ-1PS3DP5h7mtbuCW79qQ@mail.gmail.com>
 <mb61pv8cm0wf9.fsf@amazon.com> <CAADnVQ+ccoQrTcOZW_BZXMv2A+uYEYdHqx0tSVgXK31vGS=+gA@mail.gmail.com>
 <CANk7y0hK9sQJ-kRx3nQpVJSxpP=NzzFaLitOYq8=Pb6Dvk9fpg@mail.gmail.com>
 <CAADnVQ+EpYBTGMJ0MBdK8=qKrYseicxpA1AE+BmHu1CFoOPUvQ@mail.gmail.com> <CANk7y0g73bZpikgHtV1Z=c+1msE8vzZx9ZWHjJd_6FBFOEZNXQ@mail.gmail.com>
In-Reply-To: <CANk7y0g73bZpikgHtV1Z=c+1msE8vzZx9ZWHjJd_6FBFOEZNXQ@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 12 Sep 2023 18:49:13 -0700
Message-ID: <CAADnVQLJ-OG4GhYJ7K4BqoHT8hBBT2OHSkZErQZU2xTh02TiJA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 01/11] bpf: Disable zero-extension for BPF_MEMSX
To: Puranjay Mohan <puranjay12@gmail.com>
Cc: Ilya Leoshkevich <iii@linux.ibm.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	=?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, 
	Johan Almbladh <johan.almbladh@anyfinetworks.com>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 12, 2023 at 5:22=E2=80=AFPM Puranjay Mohan <puranjay12@gmail.co=
m> wrote:
>
> On Wed, Sep 13, 2023 at 2:09=E2=80=AFAM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Tue, Sep 12, 2023 at 3:49=E2=80=AFPM Puranjay Mohan <puranjay12@gmai=
l.com> wrote:
> > >
> > > Hi Alexei,
> > >
> > > [...]
> > >
> > > > I guess we never clearly defined what 'needs_zext' is supposed to b=
e,
> > > > so it wouldn't be fair to call 32-bit JITs buggy.
> > > > But we better address this issue now.
> > > > This 32-bit zeroing after LDX hurts mips64, s390, ppc64, riscv64.
> > > > I believe all 4 JITs emit proper zero extension into 64-bit registe=
r
> > > > by using single cpu instruction,
> > > > but they also define bpf_jit_needs_zext() as true,
> > > > so extra BPF_ZEXT_REG() is added by the verifier
> > > > and it is a pure run-time overhead.
> > >
> > > I just realised that these zext instructions will not be a runtime
> > > overhead because the JITs ignore them.
> > > Like
> > > s390 does:
> > > case BPF_LDX | BPF_MEM | BPF_B: /* dst =3D *(u8 *)(ul) (src + off) */
> > > case BPF_LDX | BPF_PROBE_MEM | BPF_B:
> > >         /* llgc %dst,0(off,%src) */
> > >         EMIT6_DISP_LH(0xe3000000, 0x0090, dst_reg, src_reg, REG_0, of=
f);
> > >         jit->seen |=3D SEEN_MEM;
> > >         if (insn_is_zext(&insn[1]))
> > >                 insn_count =3D 2; /* this will skip the next zext ins=
truction */
> > >         break;
> > >
> > > powerpc does after LDX:
> > > if (size !=3D BPF_DW && insn_is_zext(&insn[i + 1]))
> > >         addrs[++i] =3D ctx->idx * 4;
> >
> >
> > I see. Indeed the 64-bit JITs ignore this special zext insn after LDX.
> >
> > > > It's better to remove
> > > > if (t !=3D SRC_OP)
> > > >     return BPF_SIZE(code) =3D=3D BPF_DW;
> > > > from is_reg64() to avoid adding BPF_ZEXT_REG() insn
> > > > and fix 32-bit JITs at the same time.
> > > > RISCV32, PowerPC32, x86-32 JITs fixed in the first 3 patches
> > > > to always zero upper 32-bit after LDX and
> > > > then 4th patch to remove these two lines.
> > >
> > > I have sent the patches for above, although I think this optimization
> > > is useful because
> > > zero extension after LDX is only required when the loaded value is
> > > later being used as
> > > a 64-bit value. If it is not the case then the verifier will not emit
> > > the zext and 32-bit JITs will emit
> > > 1 less instruction because they expect the verifier to do the zext fo=
r
> > > them where required.
> >
> > You're correct.
> > Ok. Let's keep zext for LDX as-is.
>
> Yes,
> let's do
>         if (class =3D=3D BPF_LDX) {
>                 if (t !=3D SRC_OP)
> -                       return BPF_SIZE(code) =3D=3D BPF_DW;
> +                       return (BPF_SIZE(code) =3D=3D BPF_DW ||
> BPF_MODE(code) =3D=3D BPF_MEMSX);

Agree. imo that's a cleaner approach vs changing mark_insn_zext().

