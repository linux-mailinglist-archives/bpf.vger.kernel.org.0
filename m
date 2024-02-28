Return-Path: <bpf+bounces-22834-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0485086A68C
	for <lists+bpf@lfdr.de>; Wed, 28 Feb 2024 03:26:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 834011F24185
	for <lists+bpf@lfdr.de>; Wed, 28 Feb 2024 02:26:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0748E19BDC;
	Wed, 28 Feb 2024 02:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KoiBpM9N"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11ED13205
	for <bpf@vger.kernel.org>; Wed, 28 Feb 2024 02:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709087160; cv=none; b=ZqAVbALCvvFllUYTqGraiU0hoicPBwkshrQLuoR+2U+VjfD/H/e7MnNU7f6knGkFqTYcg25Bf2aEN5zpiPG1nbs2YsP5l2eOA6S2vod2OwjbI7ber05l6Hv1atjIqEhQdgg6ktz4t5ZH5IouRdkLLa2/coo//2tMuMEIcIJQWAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709087160; c=relaxed/simple;
	bh=rwNWSEOMrkFUoHbjRnAwWwXzHG+NdIrpfVo/55wcMQs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Qu65lP21gR2njjjToYSMK2jEp6Kj2Gle5dTI1MIZH33Mtzw3ZqvOweZyMOZBG4SzmVIrQmDn9PQ7M1j3pEmNvi3TUFILgP17Ajubx810wj2UR4Nn8HYHL06cJ8wam21AcOw4MyK8VgMdDaSmm4ZmQlMoF58gt4RyrDVdMGrasdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KoiBpM9N; arc=none smtp.client-ip=209.85.161.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-5a027fda5aeso2680817eaf.1
        for <bpf@vger.kernel.org>; Tue, 27 Feb 2024 18:25:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709087158; x=1709691958; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W3QCVS2QMw+ywpw/2I7ngqH8zB6AbxkWqcKsnpRLsZY=;
        b=KoiBpM9NV9Tq0lrGMGfOWmIKC023b/RUz6qT+O92miDQGIDkIwVgCn/gATS93PdER4
         h9Qg1yT3mrUrXb08ZeKdSrTBiJu0opea0LEZ4840DHoX1oPcr99jZvNcjujCVprRf1uS
         KWcVW0T9jmlX0HCiVU7s04n074UydlCFd0IxQWANJYYZGt9vCG/3mG4Zfu5AI0M6hUIi
         I7gFAbEf2HeFxPuEtuxAAPRCtJGbv42RexGx/5SnC/t5YrHLa/3Ssn7ZELFSwBoOGx8u
         79HKp+DrJoj1xlyG/3KwPtsWtpWXvG534sjq9TZ6+Pt4XwWj+ynXd5Q6pNUye0nKnw00
         pFvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709087158; x=1709691958;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W3QCVS2QMw+ywpw/2I7ngqH8zB6AbxkWqcKsnpRLsZY=;
        b=wPN9wNQkhQZrUsD7NWtPy+xnAT9zcakD8ye8UVxgJHHhxmo7lhUCn9Ijg2/IuZ+JQR
         fcgUiJriyoGlYwwB4vDlWmKYOww4kpp2N72SDZ0WaYtoO02pt2COm5+QyoLM4+Yzyzdk
         3uBLfR9mf3GWWkV4NKogJ90AxDisPpyjd34+xgOcfCdBn7qrmqPAqTUjtBOAp2U9VK+8
         mYOk2LjRHQWXUvWaHkvMuddxS7IVSVz1qJU4Z/iLw4bX5tXqnFVC0Xl9JYpBll+M8o4A
         djdbxr+o4oTvj65TKDsX6i+UTbm/r7z37tB7IQHbFDX8VJTUBCKkFMI/mgYemsVk0BW0
         HD6Q==
X-Forwarded-Encrypted: i=1; AJvYcCVYKDu6X0V+KjHxv/xsKMNrjkaFXPLTvKuHlCoNoBNb9+U2rAT1VewSC4Nvr/VNnCSpCr1E7+3K4m+06FOBKACIThYQ
X-Gm-Message-State: AOJu0YyQQ7prdiK/zUBM3aMkjAumoRc+/9WGZGwH+idzkA7xd1Q8QWSD
	MVXlhyxJfElWur3td+3793lHYsUUSDTU+6K0ajhfnnVZkw3IEGnfwxVbMVKD2vgcizEH/3zPzOF
	rdSzG9eK6Bji4IhC5XK5PW5hpdgo=
X-Google-Smtp-Source: AGHT+IHsly1qu+7hb4tMmJpigMmOkDnWGh0u4l+DhfxFTU/63SY7hN9LrrLSTuTSHI5tKdvjZr9h1LnaBaFv+X0HeFw=
X-Received: by 2002:a05:6358:b3c8:b0:17b:583c:c4b7 with SMTP id
 pb8-20020a056358b3c800b0017b583cc4b7mr16380780rwc.3.1709087158001; Tue, 27
 Feb 2024 18:25:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240225100637.48394-1-laoar.shao@gmail.com> <20240225100637.48394-2-laoar.shao@gmail.com>
 <CAEf4BzZfUnV+k6kGo1+JDhhQ1SOnTJ84M-0GVn0m66z9d6DiqQ@mail.gmail.com>
In-Reply-To: <CAEf4BzZfUnV+k6kGo1+JDhhQ1SOnTJ84M-0GVn0m66z9d6DiqQ@mail.gmail.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Wed, 28 Feb 2024 10:25:19 +0800
Message-ID: <CALOAHbARukciMpoKCDGmPRWuczS8FYLxNOK41iaHUOy1gHhDpA@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 1/2] bpf: Add bits iterator
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com, 
	andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org, 
	yonghong.song@linux.dev, kpsingh@kernel.org, sdf@google.com, 
	haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 28, 2024 at 9:24=E2=80=AFAM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Sun, Feb 25, 2024 at 2:07=E2=80=AFAM Yafang Shao <laoar.shao@gmail.com=
> wrote:
> >
> > Add three new kfuncs for the bits iterator:
> > - bpf_iter_bits_new
> >   Initialize a new bits iterator for a given memory area. Due to the
> >   limitation of bpf memalloc, the max number of bits that can be iterat=
ed
> >   over is limited to (4096 * 8).
> > - bpf_iter_bits_next
> >   Get the next bit in a bpf_iter_bits
> > - bpf_iter_bits_destroy
> >   Destroy a bpf_iter_bits
> >
> > The bits iterator facilitates the iteration of the bits of a memory are=
a,
> > such as cpumask. It can be used in any context and on any address.
> >
> > Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> > ---
> >  kernel/bpf/helpers.c | 100 +++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 100 insertions(+)
> >
> > diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> > index 93edf730d288..052f63891834 100644
> > --- a/kernel/bpf/helpers.c
> > +++ b/kernel/bpf/helpers.c
> > @@ -2542,6 +2542,103 @@ __bpf_kfunc void bpf_throw(u64 cookie)
> >         WARN(1, "A call to BPF exception callback should never return\n=
");
> >  }
> >
> > +struct bpf_iter_bits {
> > +       __u64 __opaque[2];
> > +} __aligned(8);
> > +
> > +struct bpf_iter_bits_kern {
> > +       unsigned long *bits;
> > +       u32 nr_bits;
> > +       int bit;
> > +} __aligned(8);
> > +
> > +/**
> > + * bpf_iter_bits_new() - Initialize a new bits iterator for a given me=
mory area
> > + * @it: The new bpf_iter_bits to be created
> > + * @unsafe_ptr__ign: A ponter pointing to a memory area to be iterated=
 over
> > + * @nr_bits: The number of bits to be iterated over. Due to the limita=
tion of
> > + * memalloc, it can't greater than (4096 * 8).
> > + *
> > + * This function initializes a new bpf_iter_bits structure for iterati=
ng over
> > + * a memory area which is specified by the @unsafe_ptr__ign and @nr_bi=
ts. It
> > + * copy the data of the memory area to the newly created bpf_iter_bits=
 @it for
> > + * subsequent iteration operations.
> > + *
> > + * On success, 0 is returned. On failure, ERR is returned.
> > + */
> > +__bpf_kfunc int
> > +bpf_iter_bits_new(struct bpf_iter_bits *it, const void *unsafe_ptr__ig=
n, u32 nr_bits)
> > +{
> > +       struct bpf_iter_bits_kern *kit =3D (void *)it;
> > +       u32 size =3D BITS_TO_BYTES(nr_bits);
> > +       int err;
> > +
> > +       BUILD_BUG_ON(sizeof(struct bpf_iter_bits_kern) !=3D sizeof(stru=
ct bpf_iter_bits));
> > +       BUILD_BUG_ON(__alignof__(struct bpf_iter_bits_kern) !=3D
> > +                    __alignof__(struct bpf_iter_bits));
> > +
> > +       if (!unsafe_ptr__ign || !nr_bits) {
> > +               kit->bits =3D NULL;
> > +               return -EINVAL;
> > +       }
> > +
> > +       kit->bits =3D bpf_mem_alloc(&bpf_global_ma, size);
> > +       if (!kit->bits)
> > +               return -ENOMEM;
>
> it's probably going to be a pretty common case to do bits iteration
> for nr_bits<=3D64, right?

It's highly unlikely.
Consider the CPU count as an example; There are 256 CPUs on our AMD
EPYC servers.

>  So as an optimization, instead of doing
> bpf_mem_alloc() for this case, you can just copy up to 8 bytes and
> store it in a union of `unsigned long *bits` and `unsigned long
> bits_copy`. As a performance optimization (and to reduce dependency on
> memory allocation). WDYT?
>

--=20
Regards
Yafang

