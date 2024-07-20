Return-Path: <bpf+bounces-35137-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE89D937EA5
	for <lists+bpf@lfdr.de>; Sat, 20 Jul 2024 03:54:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D172D1C2142D
	for <lists+bpf@lfdr.de>; Sat, 20 Jul 2024 01:54:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 219845C82;
	Sat, 20 Jul 2024 01:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BBiylfuL"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D2BD63A5
	for <bpf@vger.kernel.org>; Sat, 20 Jul 2024 01:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721440464; cv=none; b=uNJT5iz839wD2BgOgvGvJc7pF+WrDopxFTPwRiHdYU9GlVnh4q9onNQG93lGpA5fyRZndJYFCOsNYra/UKWx3zqb0kV+ppCDs5bePqJD6Oo4gPSr4G6IC0KlwiZV6ZlmirltgV4u19yWt92AfPtw4+tt1gjXJMAqh7ayjFfbTxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721440464; c=relaxed/simple;
	bh=Y3qiMNVLMVvrZZJhkxiF6GG3d0v/Rbr0C9G1w4ZDIrE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YI4OimKLy5sNesaALnuZDyVA8jA0vpAiOKk2yJg/31UQ/OiwZxOeRcX56lldz6beeZC5BotKf645PvnGascr/XCKBRiGo53awdjczq9SacOZ4xJhPQjxnXHDVx3I+dvt5ZUZydczTMcZb3oduukc9C2L5Wy56nj/NduJAbL50lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BBiylfuL; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-36887ca3da2so506474f8f.2
        for <bpf@vger.kernel.org>; Fri, 19 Jul 2024 18:54:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721440461; x=1722045261; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Awdxii093SM5AK9vYy/+/5rTxCtvaQDa488oNbTeaYQ=;
        b=BBiylfuLRybGeAhQoU8HET9poP3moNRSp2LKaRk4Wo8BmLiuft5lhNlNy1NmL33WWG
         Sioxx5h//Iw7otr3snPSZnOp/5pq2HzBauQWc8t439wOqJVyX8hpSpRcrebA4h2pDJT4
         C5ykzawHz+JgATB8iJ0bkBr21FOKHTY5L0PP6FF9PMhZJDTHxe5nVX+dlgjU0pE+GmtA
         HW4BRtbrnw5WzXWXe6FTmwRRImWG/oo5BEDaUfjyoNYvz55CWpTI7ZFbxdVBdHqqSMwm
         /GhPqMWsItZcaym3JfEnmkEeW2lTRvU6k+56mvFZvjOq0U5zVhgTDV49r+wwrL+qXNBC
         p7oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721440461; x=1722045261;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Awdxii093SM5AK9vYy/+/5rTxCtvaQDa488oNbTeaYQ=;
        b=tGpUHHpX0X9NtRoL1n3PDM5yeejgiVUuJHHhQrDqV0OEPHkkO7n9Zr81J/xU7MQJ3n
         St4QBFS6EkzSAxrbW7EY10WSaJZFKyrM84xJKuE02NmkMLnCcz2KkG9n7jTa0q60z3PR
         sPYT84wWm9lGXyxflCD+K1MchLJV66eRZkgeBCgOFpHYoVNaNId/cWkfNimQD5XAFZhh
         K2v3CZbQ/VH8X3tITECt2fC6yH3UCUFZSywvPqeYA7g7DuZKhKFaxo9WQe14wqJ0Oj2m
         MEA1LH1NHkZQ6PYHXH4t4XxDVFPl02jN4mmtsrrAPOtaWoJ/Phs8MuOyeWmPPZgjh2Jm
         GqQA==
X-Gm-Message-State: AOJu0YypVfQpr2KkMapxyL9Zh8mRbU0qTdPE5gQRceAv7gfOpaa+CoX6
	0QA9tdi+cGJGaQy1rd3HM/KLZCPFp8DpVEAzNuEWVkBbTDfu4+5f5rwqK5hNvD178Jfc78cFNHu
	YgzViFHm2P0bsyX10jDH2Bog2r28=
X-Google-Smtp-Source: AGHT+IGDFmxhMIR/45vTUD953qQPLD9NBeqb2nV2fza6ixL3I0e4AIeVHmZi49ikthdmCazpZmNGw6EGsG2A7gGxog4=
X-Received: by 2002:a05:6000:2c1:b0:367:9792:8bd4 with SMTP id
 ffacd0b85a97d-369bbc90875mr61605f8f.43.1721440460948; Fri, 19 Jul 2024
 18:54:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240715230201.3901423-1-eddyz87@gmail.com> <20240715230201.3901423-12-eddyz87@gmail.com>
 <CAADnVQ+2SC6w2h+bNBEZ-R--RVk5zgz2AA-x2=7X8azL26ua0Q@mail.gmail.com>
 <86c8004aab94e0e833b438ef2fba25f0835a9aa8.camel@gmail.com> <f27a6146f8ef01fe01efc8b69cba1263b3f45ce9.camel@gmail.com>
In-Reply-To: <f27a6146f8ef01fe01efc8b69cba1263b3f45ce9.camel@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 19 Jul 2024 18:54:09 -0700
Message-ID: <CAADnVQKgn-3gQoxg7z6tBRfykF=8u5T+3yYnghCZa0p2kzsrbQ@mail.gmail.com>
Subject: Re: [bpf-next v3 11/12] bpf: do check_nocsr_stack_contract() for
 ARG_ANYTHING helper params
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Kernel Team <kernel-team@fb.com>, 
	Yonghong Song <yonghong.song@linux.dev>, "Jose E. Marchesi" <jose.marchesi@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 16, 2024 at 11:15=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.co=
m> wrote:
>
> On Tue, 2024-07-16 at 03:03 -0700, Eduard Zingerman wrote:
> > On Mon, 2024-07-15 at 19:00 -0700, Alexei Starovoitov wrote:
> > > On Mon, Jul 15, 2024 at 4:02=E2=80=AFPM Eduard Zingerman <eddyz87@gma=
il.com> wrote:
> >
> > [...]
> >
> > > > This might lead to a surprising behavior in combination with nocsr
> > > > rewrites, e.g. consider the program below:
> > > >
> > > >      1: r1 =3D 1;
> > > >         /* nocsr pattern with stack offset -16 */
> > > >      2: *(u64 *)(r10 - 16) =3D r1;
> > > >      3: call %[bpf_get_smp_processor_id];
> > > >      4: r1 =3D *(u64 *)(r10 - 16);
> > > >      5: r1 =3D r10;
> > > >      6: r1 +=3D -8;
> > > >      7: r2 =3D 1;
> > > >      8: r3 =3D r10;
> > > >      9: r3 +=3D -16;
> > > >         /* bpf_probe_read_kernel(dst: &fp[-8], size: 1, src: &fp[-1=
6]) */
> > > >     10: call %[bpf_probe_read_kernel];
> > > >     11: exit;
> > > >
> > > > Here nocsr rewrite logic would remove instructions (2) and (4).
> > > > However, (2) writes a value that is later read by a call at (10).
> > >
> > > This makes no sense to me.
> > > This bpf prog is broken.
> > > If probe_read is used to read stack it will read garbage.
> > > JITs and the verifier are allowed to do any transformation
> > > that keeps the program semantics and safety.
>
> Ok, my bad, the following program works at the moment:
>
> SEC("socket") // <---- used wrong program type
> __retval(42)
> __success
> int bpf_probe_read_kernel_stack_ptr(void *ctx)
> {
>         unsigned long a =3D 17;
>         unsigned long b =3D 42;
>         int err;
>
>         err =3D bpf_probe_read_kernel(&a, 8, &b);
>         if (err)
>                 return 1;
>         return a;
> }
>
> And it is compiled to BPF as one would expect:
>
>        ... fp[-8,-16] setup ...
>        4:       r1 =3D r10
>        5:       r1 +=3D -0x8
>        6:       r3 =3D r10
>        7:       r3 +=3D -0x10
>        8:       w2 =3D 0x8
>        9:       call 0x71
>        ... return check ...
>
> So, the point stands: from C compiler pov pointer &b escapes,
> and compiler is not really allowed to replace object at that offset
> with garbage. Why do you think the program is broken?

This is apples to oranges.
Compiler sees that the address of 'b' is taken and passed
into a function with side effect.
Whether 3rd arg of bpf_probe_read_kernel() is void * or long
is irrelevant. Compilers will do it, because it's a C language
requirement.

> I don't mind dropping the patch in question, but I agree with Andrii's
> viewpoint that there is nothing wrong with this use case.

bpf_probe_read_kernel() is not special and it's 3rd argument is
some kernel address. Whether it's stack pointer or anything else
is irrelevant.
JITs and verifier are allowed to do any optimizations on stack
and any other memory completely ignoring presence of
bpf_probe_read_kernel() and what is being passed into it.

Tomorrow we will teach arm64 JIT to replace stack spill/fill with
spare register read/write. There is no way we're going to special case
a particular fp-16 slot because fp-16 was passed into probe_read.

