Return-Path: <bpf+bounces-22841-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C71186A82F
	for <lists+bpf@lfdr.de>; Wed, 28 Feb 2024 07:04:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43207282ED6
	for <lists+bpf@lfdr.de>; Wed, 28 Feb 2024 06:04:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA45F219F6;
	Wed, 28 Feb 2024 06:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cz9GEWXW"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11AC021353
	for <bpf@vger.kernel.org>; Wed, 28 Feb 2024 06:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709100255; cv=none; b=oczP9ytTeoITTFnMQNBd5FZwzE7aL+/y3R6YMVxfV2ajZ7S/g3ehwZPDDGFvCUX/DHZiSokyVq/hjl7JEHxVCGilP3rh1WODFXh/pN6zoqNFKJVHbrppg+JYsfXVH982mNRTFrHK8XBjZyP1V2Dvat5m6AXsN0mAGZFY3Cnc3Zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709100255; c=relaxed/simple;
	bh=Q+NQSPbL1l0N456mN14FI+WseBRXloRhX4/xwpaQUwI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PiI3VzsuOQv7w5/mN19XF1mR30IRPmfk5nnT99eobP4nXoe7LYbdfDeOwO/wTaUVl6QkFqqmgw5RbxYF1//ER0PfIVuzYn4or25tVJBfW8lXBKsW3KIYdpeNofDJlU1An92pWwIdnCB+mMoW2v5BSo3+leYwVg3oZe16iYmrYaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cz9GEWXW; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1dc49afb495so44413215ad.2
        for <bpf@vger.kernel.org>; Tue, 27 Feb 2024 22:04:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709100253; x=1709705053; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wyC8LF2CQgY9zv75H03KRBNpKgVB2t3kqw7+cQ5tMOQ=;
        b=Cz9GEWXW0R2fKSs2NZAV9/klH+c1UF/F80zspPrxr5MoRNYoQU1ciDd/IIlTAsd1jd
         dnvZu+J+fG88s5nRiBJLahbrd/P9jNaViZR9/ngCAn0rJNnwAanFK0as8o6AMoWpAmpT
         mmmCXDYZG/oOiceX1wwJB+nypRpy8vAL0kwxFlTdupYkQJGk1cgF+GuRnwPOr9eed4LT
         djxlTqenIldzII60s9VclfzGSVfi/6Xat1n5lgMJtwmrnGi02VvdlbNwayquJ4KPIWP+
         SpNUXSgFHULdQsdscQonAD/Xs5hFzIHk635MDXdyDHy/MSIrEO6viYJv4Zw5irDxRQVt
         xPtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709100253; x=1709705053;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wyC8LF2CQgY9zv75H03KRBNpKgVB2t3kqw7+cQ5tMOQ=;
        b=HHPVoKfxm8/Ofz9Neub25X67UpnGlpPq+HC5AtRbWakfV8dimLXBk7KYnDfscrehHR
         ebDhSyGYU9TFKhBb9XXoSfA5xUPJzmGptL1Anmkst2KTgn7ttKmaTXjalYfxRpJaVRjE
         4ylFPw83n/w5oIm31Rhx3au3JgViY9WjLF1pakz2FgvFS9ydESxB4fzSVnFIoUfo4gV1
         xD526AfoUoMkgweN+IZ5TGJYIrTOq9EjanEUUA117dT+zy0S7v/etuCP32qCx1V0WwkY
         dCG0BhbBcsF8K615eiuLTlOL30oBrw9Ewi/Qx1NiSaJ4M/UNUCNmQl+M6k2Ci9jBVo4f
         6LXQ==
X-Forwarded-Encrypted: i=1; AJvYcCXl6PrLOc4Wtr+j/VluY2D5MmSzVPu3Y+nF2jjol/c0FBELcQeCuw4z1IurZV2BQGvtUz85ngSp4LRNQSqzEMVlvPRZ
X-Gm-Message-State: AOJu0YycVj5FC5W++uWZQrIxrD1GWe6NJVJj0agidminIW/hIoYu9nbX
	3Q7GdYsa1W1P5ZDlyHXqtrsTEGCdxbBkzm5fkXNEbCKWACx0eXPmYFdW7xr/XAajGm9kVbINXI5
	jdi9lI9J2Ut2Cfl1ZKYwqEGugKPo=
X-Google-Smtp-Source: AGHT+IHGg2zx+rXHCNfjZb+HhbjLhFHnjkpQSMNw6s2MK1cm/gsJKX5h/euNk1g7/2hi8ylIc7dDn1vO+sc7Gd9/SY0=
X-Received: by 2002:a17:902:e5c5:b0:1dc:4bf6:7eb4 with SMTP id
 u5-20020a170902e5c500b001dc4bf67eb4mr16082868plf.31.1709100253288; Tue, 27
 Feb 2024 22:04:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240225100637.48394-1-laoar.shao@gmail.com> <20240225100637.48394-2-laoar.shao@gmail.com>
 <CAEf4BzZfUnV+k6kGo1+JDhhQ1SOnTJ84M-0GVn0m66z9d6DiqQ@mail.gmail.com> <CALOAHbARukciMpoKCDGmPRWuczS8FYLxNOK41iaHUOy1gHhDpA@mail.gmail.com>
In-Reply-To: <CALOAHbARukciMpoKCDGmPRWuczS8FYLxNOK41iaHUOy1gHhDpA@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 27 Feb 2024 22:04:01 -0800
Message-ID: <CAEf4Bza3DTS4H7t1bx5JrJSrZgmbKS6-4A_pRQjocWBPsD3RHQ@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 1/2] bpf: Add bits iterator
To: Yafang Shao <laoar.shao@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com, 
	andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org, 
	yonghong.song@linux.dev, kpsingh@kernel.org, sdf@google.com, 
	haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 27, 2024 at 6:25=E2=80=AFPM Yafang Shao <laoar.shao@gmail.com> =
wrote:
>
> On Wed, Feb 28, 2024 at 9:24=E2=80=AFAM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Sun, Feb 25, 2024 at 2:07=E2=80=AFAM Yafang Shao <laoar.shao@gmail.c=
om> wrote:
> > >
> > > Add three new kfuncs for the bits iterator:
> > > - bpf_iter_bits_new
> > >   Initialize a new bits iterator for a given memory area. Due to the
> > >   limitation of bpf memalloc, the max number of bits that can be iter=
ated
> > >   over is limited to (4096 * 8).
> > > - bpf_iter_bits_next
> > >   Get the next bit in a bpf_iter_bits
> > > - bpf_iter_bits_destroy
> > >   Destroy a bpf_iter_bits
> > >
> > > The bits iterator facilitates the iteration of the bits of a memory a=
rea,
> > > such as cpumask. It can be used in any context and on any address.
> > >
> > > Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> > > ---
> > >  kernel/bpf/helpers.c | 100 +++++++++++++++++++++++++++++++++++++++++=
++
> > >  1 file changed, 100 insertions(+)
> > >
> > > diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> > > index 93edf730d288..052f63891834 100644
> > > --- a/kernel/bpf/helpers.c
> > > +++ b/kernel/bpf/helpers.c
> > > @@ -2542,6 +2542,103 @@ __bpf_kfunc void bpf_throw(u64 cookie)
> > >         WARN(1, "A call to BPF exception callback should never return=
\n");
> > >  }
> > >
> > > +struct bpf_iter_bits {
> > > +       __u64 __opaque[2];
> > > +} __aligned(8);
> > > +
> > > +struct bpf_iter_bits_kern {
> > > +       unsigned long *bits;
> > > +       u32 nr_bits;
> > > +       int bit;
> > > +} __aligned(8);
> > > +
> > > +/**
> > > + * bpf_iter_bits_new() - Initialize a new bits iterator for a given =
memory area
> > > + * @it: The new bpf_iter_bits to be created
> > > + * @unsafe_ptr__ign: A ponter pointing to a memory area to be iterat=
ed over
> > > + * @nr_bits: The number of bits to be iterated over. Due to the limi=
tation of
> > > + * memalloc, it can't greater than (4096 * 8).
> > > + *
> > > + * This function initializes a new bpf_iter_bits structure for itera=
ting over
> > > + * a memory area which is specified by the @unsafe_ptr__ign and @nr_=
bits. It
> > > + * copy the data of the memory area to the newly created bpf_iter_bi=
ts @it for
> > > + * subsequent iteration operations.
> > > + *
> > > + * On success, 0 is returned. On failure, ERR is returned.
> > > + */
> > > +__bpf_kfunc int
> > > +bpf_iter_bits_new(struct bpf_iter_bits *it, const void *unsafe_ptr__=
ign, u32 nr_bits)
> > > +{
> > > +       struct bpf_iter_bits_kern *kit =3D (void *)it;
> > > +       u32 size =3D BITS_TO_BYTES(nr_bits);
> > > +       int err;
> > > +
> > > +       BUILD_BUG_ON(sizeof(struct bpf_iter_bits_kern) !=3D sizeof(st=
ruct bpf_iter_bits));
> > > +       BUILD_BUG_ON(__alignof__(struct bpf_iter_bits_kern) !=3D
> > > +                    __alignof__(struct bpf_iter_bits));
> > > +
> > > +       if (!unsafe_ptr__ign || !nr_bits) {
> > > +               kit->bits =3D NULL;
> > > +               return -EINVAL;
> > > +       }
> > > +
> > > +       kit->bits =3D bpf_mem_alloc(&bpf_global_ma, size);
> > > +       if (!kit->bits)
> > > +               return -ENOMEM;
> >
> > it's probably going to be a pretty common case to do bits iteration
> > for nr_bits<=3D64, right?
>
> It's highly unlikely.
> Consider the CPU count as an example; There are 256 CPUs on our AMD
> EPYC servers.

Also consider u64-based bit masks (like struct backtrack_state in
verifier code, which has u32 reg_mask and u64 stack_mask). This
iterator is a generic bits iterator, there are tons of cases of
u64/u32 masks in practice.

>
> >  So as an optimization, instead of doing
> > bpf_mem_alloc() for this case, you can just copy up to 8 bytes and
> > store it in a union of `unsigned long *bits` and `unsigned long
> > bits_copy`. As a performance optimization (and to reduce dependency on
> > memory allocation). WDYT?
> >
>
> --
> Regards
> Yafang

