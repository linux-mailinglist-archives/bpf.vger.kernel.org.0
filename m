Return-Path: <bpf+bounces-23063-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5BD686D08D
	for <lists+bpf@lfdr.de>; Thu, 29 Feb 2024 18:26:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69F4C2875EB
	for <lists+bpf@lfdr.de>; Thu, 29 Feb 2024 17:26:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9CF570AE0;
	Thu, 29 Feb 2024 17:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GwuY9CfI"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C07B970AD9
	for <bpf@vger.kernel.org>; Thu, 29 Feb 2024 17:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709227607; cv=none; b=jl+7Uo+lW7mUQmvU8xTH3YYAYUqkxBGkJ33rw+Vp7yH9MFVcoQJS5EETs+QoGpMILPKTnThHFNjSdyUX3zEzGUzwNFtpLPyFst/in/NZIn79mY1EHCAFw9Ehuc5SXsCN7NnJrxNowzid1reiCU+Kx7Mi6KaeJsEnlohTtUGq7ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709227607; c=relaxed/simple;
	bh=15YicwvZkW8JHxeXXFd1hFjYIpGyPGh3imKZX5+k8KI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=joUPZkP5jFzIcoOp+w34WXSuHURof6OyFXkTTi5mLfbLCwye1dfYwyi3B+nc+fT3cRr5AXc4ix5vblQtzriZytDU4fD4KdWXg2sgdWeUcH+EDhnDX6afARPMNT/4rpAWbkKmNYePXohu627Q+iaQ1AZK4dcj7FdpBYAdGD8SRfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GwuY9CfI; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1dc5d0162bcso11393285ad.0
        for <bpf@vger.kernel.org>; Thu, 29 Feb 2024 09:26:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709227605; x=1709832405; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g00HojBpyOTsYenjlIrN2W7GGlzRhtVsGWGuunBoG5g=;
        b=GwuY9CfIkAPgw3Rb6kCaqWvElqt1yR2XoC0bk8xUmHGCDeU2a3pr1ceYBcfX0mTNqb
         PO9xOUoINzVm2ev0yyZ3mNNv0Cukp3D/m/S5i37ZIWQHCj88lGMt8fvazcEXgZUi5dd1
         t6I3u7kcpFSmHi/M1by8fqtmpmiV540CaIcIfgIyNseLAsMmp4/ozMOBDQYkTaQuSYqt
         o2DkpYD5kdV/qBg1uIbccErhc7+ZxdQ4JDxv3qv9I6dHBgCgemTtTbl9emy69BHVOHEQ
         KNUUnsKi0gKhvhBCo4aUnl/jQdq/LcN8cKA4Xez3+7D9RavMHfvKhFL9sZd7x6Tn7Zbo
         hqwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709227605; x=1709832405;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g00HojBpyOTsYenjlIrN2W7GGlzRhtVsGWGuunBoG5g=;
        b=vXH4H8OzwDNh7P5ve9/oT4NeNE2w4WmVvplm3qVZl1tVCYOKy2qFfzFzhdGDA86xYQ
         TH1P9gCpbIzGFSDKy0buFZ9QwsLHGoA1xJQrEone1DJQv6GAslHg5i8e8pANqex7w2i5
         TF6WXCDpemIEzmU6/62IO3di4Lnpo5hwckR8pPejuOBBe2isvptkXvpCXDy1k3KV/vCH
         Dd26rUVuMxjD7MGKXTmnuksFHYNrscGsUD2u+S/i7Iv6o0CfjDnIGZEFsvzPscIOasWI
         abEvHnT/Aj75AUEbL0cb+sRLNqcu9LdWzs27Yv5c8mC1RxWCpGlyR94pGIB1OEtWoE5t
         h2yw==
X-Forwarded-Encrypted: i=1; AJvYcCVQLVwiLp1NgqOF1SKR0m6KwVwopQ2oqMsovvxm415+WAp/KoN+AQN+PzKlIUvKUiqdap+YBTHuW/+RA1/qTLjtvxR8
X-Gm-Message-State: AOJu0Yy+S2AFmZZ8X5jGlHtXWdA4WPyLcrVgeSEFKQLoWiyITm43c5Wb
	PvxFyFfPIvYFcEpo6dG16Var4dq/QKwGWstsqY5SpKeNmOMe3raX6aNIcDci7S/2DDNetYeucFI
	4R5GYY7hjcPUP4ZIgNoub47LW8peRwBO3
X-Google-Smtp-Source: AGHT+IEqhl27DmLXchR91HkSDJ4H3qme6Ri4It9s3KPmzgAOa+aviDYF+C2FADzhOm/ywRIwT3GyEJib8KemjGCjSFU=
X-Received: by 2002:a17:90a:8b12:b0:29a:b988:ab64 with SMTP id
 y18-20020a17090a8b1200b0029ab988ab64mr2669436pjn.7.1709227605001; Thu, 29 Feb
 2024 09:26:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240225100637.48394-1-laoar.shao@gmail.com> <20240225100637.48394-2-laoar.shao@gmail.com>
 <CAEf4BzZfUnV+k6kGo1+JDhhQ1SOnTJ84M-0GVn0m66z9d6DiqQ@mail.gmail.com>
 <CALOAHbARukciMpoKCDGmPRWuczS8FYLxNOK41iaHUOy1gHhDpA@mail.gmail.com>
 <CAEf4Bza3DTS4H7t1bx5JrJSrZgmbKS6-4A_pRQjocWBPsD3RHQ@mail.gmail.com> <CALOAHbCH8q_xPJBW=Eq-nwsS9N-EVnwt_dkKS_RjdHZMGsqq0w@mail.gmail.com>
In-Reply-To: <CALOAHbCH8q_xPJBW=Eq-nwsS9N-EVnwt_dkKS_RjdHZMGsqq0w@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 29 Feb 2024 09:26:32 -0800
Message-ID: <CAEf4BzYK4o558CcQt=yzKZH+M-eD3z0GpdUORcapJKXAHZJy-g@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 1/2] bpf: Add bits iterator
To: Yafang Shao <laoar.shao@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com, 
	andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org, 
	yonghong.song@linux.dev, kpsingh@kernel.org, sdf@google.com, 
	haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 28, 2024 at 6:16=E2=80=AFPM Yafang Shao <laoar.shao@gmail.com> =
wrote:
>
> On Wed, Feb 28, 2024 at 2:04=E2=80=AFPM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Tue, Feb 27, 2024 at 6:25=E2=80=AFPM Yafang Shao <laoar.shao@gmail.c=
om> wrote:
> > >
> > > On Wed, Feb 28, 2024 at 9:24=E2=80=AFAM Andrii Nakryiko
> > > <andrii.nakryiko@gmail.com> wrote:
> > > >
> > > > On Sun, Feb 25, 2024 at 2:07=E2=80=AFAM Yafang Shao <laoar.shao@gma=
il.com> wrote:
> > > > >
> > > > > Add three new kfuncs for the bits iterator:
> > > > > - bpf_iter_bits_new
> > > > >   Initialize a new bits iterator for a given memory area. Due to =
the
> > > > >   limitation of bpf memalloc, the max number of bits that can be =
iterated
> > > > >   over is limited to (4096 * 8).
> > > > > - bpf_iter_bits_next
> > > > >   Get the next bit in a bpf_iter_bits
> > > > > - bpf_iter_bits_destroy
> > > > >   Destroy a bpf_iter_bits
> > > > >
> > > > > The bits iterator facilitates the iteration of the bits of a memo=
ry area,
> > > > > such as cpumask. It can be used in any context and on any address=
.
> > > > >
> > > > > Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> > > > > ---
> > > > >  kernel/bpf/helpers.c | 100 +++++++++++++++++++++++++++++++++++++=
++++++
> > > > >  1 file changed, 100 insertions(+)
> > > > >
> > > > > diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> > > > > index 93edf730d288..052f63891834 100644
> > > > > --- a/kernel/bpf/helpers.c
> > > > > +++ b/kernel/bpf/helpers.c
> > > > > @@ -2542,6 +2542,103 @@ __bpf_kfunc void bpf_throw(u64 cookie)
> > > > >         WARN(1, "A call to BPF exception callback should never re=
turn\n");
> > > > >  }
> > > > >
> > > > > +struct bpf_iter_bits {
> > > > > +       __u64 __opaque[2];
> > > > > +} __aligned(8);
> > > > > +
> > > > > +struct bpf_iter_bits_kern {
> > > > > +       unsigned long *bits;
> > > > > +       u32 nr_bits;
> > > > > +       int bit;
> > > > > +} __aligned(8);
> > > > > +
> > > > > +/**
> > > > > + * bpf_iter_bits_new() - Initialize a new bits iterator for a gi=
ven memory area
> > > > > + * @it: The new bpf_iter_bits to be created
> > > > > + * @unsafe_ptr__ign: A ponter pointing to a memory area to be it=
erated over
> > > > > + * @nr_bits: The number of bits to be iterated over. Due to the =
limitation of
> > > > > + * memalloc, it can't greater than (4096 * 8).
> > > > > + *
> > > > > + * This function initializes a new bpf_iter_bits structure for i=
terating over
> > > > > + * a memory area which is specified by the @unsafe_ptr__ign and =
@nr_bits. It
> > > > > + * copy the data of the memory area to the newly created bpf_ite=
r_bits @it for
> > > > > + * subsequent iteration operations.
> > > > > + *
> > > > > + * On success, 0 is returned. On failure, ERR is returned.
> > > > > + */
> > > > > +__bpf_kfunc int
> > > > > +bpf_iter_bits_new(struct bpf_iter_bits *it, const void *unsafe_p=
tr__ign, u32 nr_bits)
> > > > > +{
> > > > > +       struct bpf_iter_bits_kern *kit =3D (void *)it;
> > > > > +       u32 size =3D BITS_TO_BYTES(nr_bits);
> > > > > +       int err;
> > > > > +
> > > > > +       BUILD_BUG_ON(sizeof(struct bpf_iter_bits_kern) !=3D sizeo=
f(struct bpf_iter_bits));
> > > > > +       BUILD_BUG_ON(__alignof__(struct bpf_iter_bits_kern) !=3D
> > > > > +                    __alignof__(struct bpf_iter_bits));
> > > > > +
> > > > > +       if (!unsafe_ptr__ign || !nr_bits) {
> > > > > +               kit->bits =3D NULL;
> > > > > +               return -EINVAL;
> > > > > +       }
> > > > > +
> > > > > +       kit->bits =3D bpf_mem_alloc(&bpf_global_ma, size);
> > > > > +       if (!kit->bits)
> > > > > +               return -ENOMEM;
> > > >
> > > > it's probably going to be a pretty common case to do bits iteration
> > > > for nr_bits<=3D64, right?
> > >
> > > It's highly unlikely.
> > > Consider the CPU count as an example; There are 256 CPUs on our AMD
> > > EPYC servers.
> >
> > Also consider u64-based bit masks (like struct backtrack_state in
> > verifier code, which has u32 reg_mask and u64 stack_mask). This
> > iterator is a generic bits iterator, there are tons of cases of
> > u64/u32 masks in practice.
>
> Should we optimize it as follows?
>
>     if (nr_bits <=3D 64) {
>         // do the optimization
>     } else {
>         // fallback to memalloc
>     }
>

Yep, that's what I'm proposing


> >
> > >
> > > >  So as an optimization, instead of doing
> > > > bpf_mem_alloc() for this case, you can just copy up to 8 bytes and
> > > > store it in a union of `unsigned long *bits` and `unsigned long
> > > > bits_copy`. As a performance optimization (and to reduce dependency=
 on
> > > > memory allocation). WDYT?
> > > >
> > >
> > > --
> > > Regards
> > > Yafang
>
>
>
> --
> Regards
> Yafang

