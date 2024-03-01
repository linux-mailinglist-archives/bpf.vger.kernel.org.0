Return-Path: <bpf+bounces-23114-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F054D86DB94
	for <lists+bpf@lfdr.de>; Fri,  1 Mar 2024 07:41:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7490283370
	for <lists+bpf@lfdr.de>; Fri,  1 Mar 2024 06:41:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF0C867E7A;
	Fri,  1 Mar 2024 06:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jEdoVtNb"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7D9E67C74
	for <bpf@vger.kernel.org>; Fri,  1 Mar 2024 06:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709275285; cv=none; b=L9siIW/QIK7/JQX32Wr49AKxiqsDksa3S/nTOmF9zgJxMgWiAr+tUq0a++Bxcne+7OXpqjSDxDrM4livCADcZc3bvgUTMN26CwWNzd15IOB7bWOezIAiZC8L9T1fsIPZyEhfriDWNwIikx5ajcHFCEY+EOhpXmkDjyjS0hETs3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709275285; c=relaxed/simple;
	bh=dU7EKhhWYgOQ9qVvswaHxsMA8UnOiqwY6+gXNpQxVZU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U7bTawIK8nKQ4IkVoYpkGXDZPqCu+t8Z9M9ABZJn1cgAEEbgGx3sffl0jilNj1GHssEE/VLC86B5sxuQPUg2a3CbmG2tXGT8zLhGNXZzbYqauTKScSVKryWm/SEQ8teJ+zNpYlhYaYpMGJ8tHmRnh2PVXV49jpiwVEzOHfYFdyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jEdoVtNb; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-68f9e399c91so12774526d6.2
        for <bpf@vger.kernel.org>; Thu, 29 Feb 2024 22:41:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709275282; x=1709880082; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gps5hwQrFgL0mTSjwEthHZH1oYf0ia9nVjWmrNj7xhw=;
        b=jEdoVtNbEF5Gs0jiDtrHzrgoImgp9THEqmT8LChSf9v5EJBIqkqAx2GqEvssc6hup5
         H4WVrtx8MclHRiEmxlKhHo5GshnMH2O3tL/cqzMAUD5ClaDUYDRq3l55i3JK2DgAbrGM
         D0cWd1w0pGC7d9ZFEeQ5ua/CC4jHI9ymbZaB3ECa2/XnH7Ag5T841NEUuSfQ9g+IuwRY
         HPbSHQDIcnyZjeHqhZwbBWq16+V6sFcq356Dph5kezdNK44cwr+m0Vmf1dU3V1ywGOO5
         z8faK6tEXQ+zRuowr/cbs7YnVuRo3LfN4lBhLSmc0ixv761jxESbdd4kI5Q9r7YGJ3mY
         3rdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709275282; x=1709880082;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gps5hwQrFgL0mTSjwEthHZH1oYf0ia9nVjWmrNj7xhw=;
        b=E4QYI+xfksuVoY6OkpTXrSQF7HgOY3qOUIb8rcxBRvFTzzFaln6E0Enjt8YitxHqdj
         xU7C7QoC4PhrUn+NIf0KamQNK4V8EYzNTVTk0BSNLAtHr0MA0Xwck1OGPn1g/5dlTIwz
         5DAXhmIZuEbr9PQkgqwj1nL3P3poMnQmvoDwRaTyB29UcqyYe2UKNyZVIUsGmOGvnYha
         uKHUVX4u4QNda+YSEZ2mYXy3IV4U96mFKOHffbqesR3L0p60L6lMT3xsy/Uv/czEivbV
         eERi2Yt8cvxSHmWyWNb3ryDcTJW9FOw0hyXwU31VZ+RgRMFueyndro4/60oAAcZ1sQrS
         aYiQ==
X-Forwarded-Encrypted: i=1; AJvYcCWk5Qe1gBlRu4Hju/GdbBUer9Xghqj7I5w5XR+y8E8QOFK4G3JW5Kt1zftVz59CYeq6cqU6MSvWwyaONGNtQMRHsA1J
X-Gm-Message-State: AOJu0Ywg+406enBsg3yulOb+otWGR+aN3mpcQJLy8TKjodyf498u1SaL
	YpOfXn+YRP55JptI1+NZPjW1aLyoGtyYzCbGimWgbdY6XbeHaMHtjj0tQSFjJKxihKGXBnE+pMS
	6tSISo1Y3BsLwSfOPoxwSOsG8QPk=
X-Google-Smtp-Source: AGHT+IGUwS692XtEdW+GlnqAT9DLAYaLkDgdEp9t5y1V/L1KY2GaM+J3P7OktsLJUGHdfeAT1xSvofzA+UTlm4o8rKs=
X-Received: by 2002:a0c:e610:0:b0:68f:e76d:e3f with SMTP id
 z16-20020a0ce610000000b0068fe76d0e3fmr818242qvm.53.1709275282639; Thu, 29 Feb
 2024 22:41:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240225100637.48394-1-laoar.shao@gmail.com> <20240225100637.48394-2-laoar.shao@gmail.com>
 <CAEf4BzZfUnV+k6kGo1+JDhhQ1SOnTJ84M-0GVn0m66z9d6DiqQ@mail.gmail.com>
 <CALOAHbARukciMpoKCDGmPRWuczS8FYLxNOK41iaHUOy1gHhDpA@mail.gmail.com>
 <CAEf4Bza3DTS4H7t1bx5JrJSrZgmbKS6-4A_pRQjocWBPsD3RHQ@mail.gmail.com>
 <CALOAHbCH8q_xPJBW=Eq-nwsS9N-EVnwt_dkKS_RjdHZMGsqq0w@mail.gmail.com>
 <CAEf4BzYK4o558CcQt=yzKZH+M-eD3z0GpdUORcapJKXAHZJy-g@mail.gmail.com> <65e102f6ebef2_33719208c8@john.notmuch>
In-Reply-To: <65e102f6ebef2_33719208c8@john.notmuch>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Fri, 1 Mar 2024 14:40:46 +0800
Message-ID: <CALOAHbBCp=KsGadzr+Yjmyx9UZXgxzuWPMzG9OLu7XsBd6eNpw@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 1/2] bpf: Add bits iterator
To: John Fastabend <john.fastabend@gmail.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org, 
	yonghong.song@linux.dev, kpsingh@kernel.org, sdf@google.com, 
	haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 1, 2024 at 6:19=E2=80=AFAM John Fastabend <john.fastabend@gmail=
.com> wrote:
>
> Andrii Nakryiko wrote:
> > On Wed, Feb 28, 2024 at 6:16=E2=80=AFPM Yafang Shao <laoar.shao@gmail.c=
om> wrote:
> > >
> > > On Wed, Feb 28, 2024 at 2:04=E2=80=AFPM Andrii Nakryiko
> > > <andrii.nakryiko@gmail.com> wrote:
> > > >
> > > > On Tue, Feb 27, 2024 at 6:25=E2=80=AFPM Yafang Shao <laoar.shao@gma=
il.com> wrote:
> > > > >
> > > > > On Wed, Feb 28, 2024 at 9:24=E2=80=AFAM Andrii Nakryiko
> > > > > <andrii.nakryiko@gmail.com> wrote:
> > > > > >
> > > > > > On Sun, Feb 25, 2024 at 2:07=E2=80=AFAM Yafang Shao <laoar.shao=
@gmail.com> wrote:
> > > > > > >
> > > > > > > Add three new kfuncs for the bits iterator:
> > > > > > > - bpf_iter_bits_new
> > > > > > >   Initialize a new bits iterator for a given memory area. Due=
 to the
> > > > > > >   limitation of bpf memalloc, the max number of bits that can=
 be iterated
> > > > > > >   over is limited to (4096 * 8).
> > > > > > > - bpf_iter_bits_next
> > > > > > >   Get the next bit in a bpf_iter_bits
> > > > > > > - bpf_iter_bits_destroy
> > > > > > >   Destroy a bpf_iter_bits
> > > > > > >
> > > > > > > The bits iterator facilitates the iteration of the bits of a =
memory area,
> > > > > > > such as cpumask. It can be used in any context and on any add=
ress.
> > > > > > >
> > > > > > > Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> > > > > > > ---
> > > > > > >  kernel/bpf/helpers.c | 100 +++++++++++++++++++++++++++++++++=
++++++++++
> > > > > > >  1 file changed, 100 insertions(+)
> > > > > > >
> > > > > > > diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> > > > > > > index 93edf730d288..052f63891834 100644
> > > > > > > --- a/kernel/bpf/helpers.c
> > > > > > > +++ b/kernel/bpf/helpers.c
> > > > > > > @@ -2542,6 +2542,103 @@ __bpf_kfunc void bpf_throw(u64 cookie=
)
> > > > > > >         WARN(1, "A call to BPF exception callback should neve=
r return\n");
> > > > > > >  }
> > > > > > >
> > > > > > > +struct bpf_iter_bits {
> > > > > > > +       __u64 __opaque[2];
> > > > > > > +} __aligned(8);
> > > > > > > +
> > > > > > > +struct bpf_iter_bits_kern {
> > > > > > > +       unsigned long *bits;
> > > > > > > +       u32 nr_bits;
> > > > > > > +       int bit;
> > > > > > > +} __aligned(8);
> > > > > > > +
> > > > > > > +/**
> > > > > > > + * bpf_iter_bits_new() - Initialize a new bits iterator for =
a given memory area
> > > > > > > + * @it: The new bpf_iter_bits to be created
> > > > > > > + * @unsafe_ptr__ign: A ponter pointing to a memory area to b=
e iterated over
> > > > > > > + * @nr_bits: The number of bits to be iterated over. Due to =
the limitation of
> > > > > > > + * memalloc, it can't greater than (4096 * 8).
> > > > > > > + *
> > > > > > > + * This function initializes a new bpf_iter_bits structure f=
or iterating over
> > > > > > > + * a memory area which is specified by the @unsafe_ptr__ign =
and @nr_bits. It
> > > > > > > + * copy the data of the memory area to the newly created bpf=
_iter_bits @it for
> > > > > > > + * subsequent iteration operations.
> > > > > > > + *
> > > > > > > + * On success, 0 is returned. On failure, ERR is returned.
> > > > > > > + */
> > > > > > > +__bpf_kfunc int
> > > > > > > +bpf_iter_bits_new(struct bpf_iter_bits *it, const void *unsa=
fe_ptr__ign, u32 nr_bits)
> > > > > > > +{
> > > > > > > +       struct bpf_iter_bits_kern *kit =3D (void *)it;
> > > > > > > +       u32 size =3D BITS_TO_BYTES(nr_bits);
> > > > > > > +       int err;
> > > > > > > +
> > > > > > > +       BUILD_BUG_ON(sizeof(struct bpf_iter_bits_kern) !=3D s=
izeof(struct bpf_iter_bits));
> > > > > > > +       BUILD_BUG_ON(__alignof__(struct bpf_iter_bits_kern) !=
=3D
> > > > > > > +                    __alignof__(struct bpf_iter_bits));
> > > > > > > +
> > > > > > > +       if (!unsafe_ptr__ign || !nr_bits) {
> > > > > > > +               kit->bits =3D NULL;
> > > > > > > +               return -EINVAL;
> > > > > > > +       }
> > > > > > > +
> > > > > > > +       kit->bits =3D bpf_mem_alloc(&bpf_global_ma, size);
> > > > > > > +       if (!kit->bits)
> > > > > > > +               return -ENOMEM;
> > > > > >
> > > > > > it's probably going to be a pretty common case to do bits itera=
tion
> > > > > > for nr_bits<=3D64, right?
> > > > >
> > > > > It's highly unlikely.
> > > > > Consider the CPU count as an example; There are 256 CPUs on our A=
MD
> > > > > EPYC servers.
> > > >
> > > > Also consider u64-based bit masks (like struct backtrack_state in
> > > > verifier code, which has u32 reg_mask and u64 stack_mask). This
> > > > iterator is a generic bits iterator, there are tons of cases of
> > > > u64/u32 masks in practice.
> > >
> > > Should we optimize it as follows?
> > >
> > >     if (nr_bits <=3D 64) {
> > >         // do the optimization
> > >     } else {
> > >         // fallback to memalloc
> > >     }
> > >
> >
> > Yep, that's what I'm proposing
>
> When I suggested why not just open code this in BPF earlier I was
> mostly thinking of these u64 and u32 masks we have lots of them
> in our code base as well.
>
> I have something like this which might be even better than 3
> calls depending on your use case,
>
>  int find_next_bit(uint64_t bits, int last_bit)
>  {
>     int i =3D last_bit;
>     for (i =3D 0; i < sizeof(uint64_t) * 8; i++) {
>         if (bits & (1 << i))
>            return i;
>     }
>     return -1;
>   }
>
> Verifier seems plenty happy with above.

I'm not quite following.
Regarding the find_next_bit() function you mentioned, it seems it only
retrieves one bit at a time, necessitating a for loop for execution,
correct? Consequently, the verifier will likely fail the for loop.

--=20
Regards
Yafang

