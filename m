Return-Path: <bpf+bounces-22991-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D81386BED7
	for <lists+bpf@lfdr.de>; Thu, 29 Feb 2024 03:16:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 548EFB25263
	for <lists+bpf@lfdr.de>; Thu, 29 Feb 2024 02:16:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64982364DA;
	Thu, 29 Feb 2024 02:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AU8i6Gpt"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E8FA36AF2
	for <bpf@vger.kernel.org>; Thu, 29 Feb 2024 02:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709172988; cv=none; b=gXN4PK3tGc89hOBKT07gndL+nlyhjFu1CxWRNRCQCK0NSq40C3jKWmT9CEoeG4zBO0FxO2QjcxR25NgPhbiuPfQhDWr9GeNO99fZdw5kI5T+UBfNSudM8C/rAjqidb8epbmORST2fSGMt0XmQO9ebduUEB4l2TEKdcvpyXENJ6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709172988; c=relaxed/simple;
	bh=7mDeKI1IUcMxywfrWLjr1ossjEpjYX1XaAD8kQF9DWs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A8DmQXpx7B6TW/ESF1WZkLaIkq5qj3W5k9W2IMdTzZkv6onnXrg2KSUqgrcJiVUS01hJ1TsXm15/m9umTdy8ymmU8qJDcxew20FLrTcCwmPuTQjgN9yLym9YMRkYA8tfUU+2ST9VumsVZFXQHIDbBHm6BkFIJUCGw7azhMLfD28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AU8i6Gpt; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-6861538916cso2074756d6.3
        for <bpf@vger.kernel.org>; Wed, 28 Feb 2024 18:16:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709172985; x=1709777785; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mKonHNqHFuJNVeg7AkkzXLHtSYhLumrafEIBFOUkNi0=;
        b=AU8i6GptQZpK9Y2Po94tQARa9Qf1W+HwRiyFggS8hk1Yva1eTMhTbLqSAp25EtAARh
         FZ46i+0C+tOXeF21+IVixEYH5U0tfFSvNzk0zpg4qyvArm5pmf0JhoGebnjlbgIvOMy0
         sos4aKNg9ktRhGjyMoPXxJw5mg0ouxvUCVXWHdJ2XnHoBioz+MxR1KlRA9c0FAbHlO3x
         BTBC0UCctYLYWx5r+agrY4z2jcK7kJLksF56qQR4LcTrHNjMC8Z/LozJuZqP7JPpup6A
         Xxb7VvfAJi9WY5eTtIAOHDCJUIoxPyKZFutlmLhkKNdkPtCh4Oh14Ps0rc1xNsvI7SEF
         4sNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709172985; x=1709777785;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mKonHNqHFuJNVeg7AkkzXLHtSYhLumrafEIBFOUkNi0=;
        b=MXdxHR1LarO52j9ENLcJ0SJ+yJazBWXbe1OHpHE6Zl8vWKO51Ty9m8pYaV2tZvDCGL
         0Ic1CuJWTRFcltGeuiz4Ir1ib3pdMb3ZSxosoxqEmDnXRMRYpakFACKPVL+gTCuiRQUx
         L8a9XuqKpqbu/Vz90fpr+gTVOFy0pc96zeb5qyWiaD/2lLPdAs6TgdRU0ChdxNHXeVe7
         UL6qDdH3HL+CMtTF4Jqg08JqIGTH1XRhra2yRKR+VfYGHFTmySJc+VOlmYcckvBs1YGZ
         6ClObTdWce9Wx15AWnIrvHy4D5kjmkEPheWhYXX7HG/NoQR8Y+i+cQ4W1WlBK8H+ocii
         QdRw==
X-Forwarded-Encrypted: i=1; AJvYcCWy3Q+vSFj+0UeT8G9071GSm/V8hjPXau3FAtAIDy7MMWU6+9My9X5Fwms/So5dtispHrnMz/bTVoxqOxaFUsyo2m0y
X-Gm-Message-State: AOJu0YxOBmTdkAjCsWaclYFSqiIePAz5d0aH1k7Fq84NNf42yi2wXFwg
	Dq3weQ/X+aCgyApNUDdfmbHDPWjny24BmN+IwMNZEU/NDOf27HQZjQws1pvaOrXcKuYC7WuFVBY
	lZ7dr62IhV/jyvn8V1rPGENomxOQ=
X-Google-Smtp-Source: AGHT+IH8f7KOSYDeNmXkVaG5JahIWZ5brarivNZdUHM4/eiMsnhYC1EAb2N9t0ezBjPXq1hpzE2OyMUhaw4OTa6wlms=
X-Received: by 2002:ad4:4c4b:0:b0:68f:9e2a:e049 with SMTP id
 cs11-20020ad44c4b000000b0068f9e2ae049mr909936qvb.30.1709172985238; Wed, 28
 Feb 2024 18:16:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240225100637.48394-1-laoar.shao@gmail.com> <20240225100637.48394-2-laoar.shao@gmail.com>
 <CAEf4BzZfUnV+k6kGo1+JDhhQ1SOnTJ84M-0GVn0m66z9d6DiqQ@mail.gmail.com>
 <CALOAHbARukciMpoKCDGmPRWuczS8FYLxNOK41iaHUOy1gHhDpA@mail.gmail.com> <CAEf4Bza3DTS4H7t1bx5JrJSrZgmbKS6-4A_pRQjocWBPsD3RHQ@mail.gmail.com>
In-Reply-To: <CAEf4Bza3DTS4H7t1bx5JrJSrZgmbKS6-4A_pRQjocWBPsD3RHQ@mail.gmail.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Thu, 29 Feb 2024 10:15:49 +0800
Message-ID: <CALOAHbCH8q_xPJBW=Eq-nwsS9N-EVnwt_dkKS_RjdHZMGsqq0w@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 1/2] bpf: Add bits iterator
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com, 
	andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org, 
	yonghong.song@linux.dev, kpsingh@kernel.org, sdf@google.com, 
	haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 28, 2024 at 2:04=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Tue, Feb 27, 2024 at 6:25=E2=80=AFPM Yafang Shao <laoar.shao@gmail.com=
> wrote:
> >
> > On Wed, Feb 28, 2024 at 9:24=E2=80=AFAM Andrii Nakryiko
> > <andrii.nakryiko@gmail.com> wrote:
> > >
> > > On Sun, Feb 25, 2024 at 2:07=E2=80=AFAM Yafang Shao <laoar.shao@gmail=
.com> wrote:
> > > >
> > > > Add three new kfuncs for the bits iterator:
> > > > - bpf_iter_bits_new
> > > >   Initialize a new bits iterator for a given memory area. Due to th=
e
> > > >   limitation of bpf memalloc, the max number of bits that can be it=
erated
> > > >   over is limited to (4096 * 8).
> > > > - bpf_iter_bits_next
> > > >   Get the next bit in a bpf_iter_bits
> > > > - bpf_iter_bits_destroy
> > > >   Destroy a bpf_iter_bits
> > > >
> > > > The bits iterator facilitates the iteration of the bits of a memory=
 area,
> > > > such as cpumask. It can be used in any context and on any address.
> > > >
> > > > Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> > > > ---
> > > >  kernel/bpf/helpers.c | 100 +++++++++++++++++++++++++++++++++++++++=
++++
> > > >  1 file changed, 100 insertions(+)
> > > >
> > > > diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> > > > index 93edf730d288..052f63891834 100644
> > > > --- a/kernel/bpf/helpers.c
> > > > +++ b/kernel/bpf/helpers.c
> > > > @@ -2542,6 +2542,103 @@ __bpf_kfunc void bpf_throw(u64 cookie)
> > > >         WARN(1, "A call to BPF exception callback should never retu=
rn\n");
> > > >  }
> > > >
> > > > +struct bpf_iter_bits {
> > > > +       __u64 __opaque[2];
> > > > +} __aligned(8);
> > > > +
> > > > +struct bpf_iter_bits_kern {
> > > > +       unsigned long *bits;
> > > > +       u32 nr_bits;
> > > > +       int bit;
> > > > +} __aligned(8);
> > > > +
> > > > +/**
> > > > + * bpf_iter_bits_new() - Initialize a new bits iterator for a give=
n memory area
> > > > + * @it: The new bpf_iter_bits to be created
> > > > + * @unsafe_ptr__ign: A ponter pointing to a memory area to be iter=
ated over
> > > > + * @nr_bits: The number of bits to be iterated over. Due to the li=
mitation of
> > > > + * memalloc, it can't greater than (4096 * 8).
> > > > + *
> > > > + * This function initializes a new bpf_iter_bits structure for ite=
rating over
> > > > + * a memory area which is specified by the @unsafe_ptr__ign and @n=
r_bits. It
> > > > + * copy the data of the memory area to the newly created bpf_iter_=
bits @it for
> > > > + * subsequent iteration operations.
> > > > + *
> > > > + * On success, 0 is returned. On failure, ERR is returned.
> > > > + */
> > > > +__bpf_kfunc int
> > > > +bpf_iter_bits_new(struct bpf_iter_bits *it, const void *unsafe_ptr=
__ign, u32 nr_bits)
> > > > +{
> > > > +       struct bpf_iter_bits_kern *kit =3D (void *)it;
> > > > +       u32 size =3D BITS_TO_BYTES(nr_bits);
> > > > +       int err;
> > > > +
> > > > +       BUILD_BUG_ON(sizeof(struct bpf_iter_bits_kern) !=3D sizeof(=
struct bpf_iter_bits));
> > > > +       BUILD_BUG_ON(__alignof__(struct bpf_iter_bits_kern) !=3D
> > > > +                    __alignof__(struct bpf_iter_bits));
> > > > +
> > > > +       if (!unsafe_ptr__ign || !nr_bits) {
> > > > +               kit->bits =3D NULL;
> > > > +               return -EINVAL;
> > > > +       }
> > > > +
> > > > +       kit->bits =3D bpf_mem_alloc(&bpf_global_ma, size);
> > > > +       if (!kit->bits)
> > > > +               return -ENOMEM;
> > >
> > > it's probably going to be a pretty common case to do bits iteration
> > > for nr_bits<=3D64, right?
> >
> > It's highly unlikely.
> > Consider the CPU count as an example; There are 256 CPUs on our AMD
> > EPYC servers.
>
> Also consider u64-based bit masks (like struct backtrack_state in
> verifier code, which has u32 reg_mask and u64 stack_mask). This
> iterator is a generic bits iterator, there are tons of cases of
> u64/u32 masks in practice.

Should we optimize it as follows?

    if (nr_bits <=3D 64) {
        // do the optimization
    } else {
        // fallback to memalloc
    }

>
> >
> > >  So as an optimization, instead of doing
> > > bpf_mem_alloc() for this case, you can just copy up to 8 bytes and
> > > store it in a union of `unsigned long *bits` and `unsigned long
> > > bits_copy`. As a performance optimization (and to reduce dependency o=
n
> > > memory allocation). WDYT?
> > >
> >
> > --
> > Regards
> > Yafang



--=20
Regards
Yafang

