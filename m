Return-Path: <bpf+bounces-23168-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A761986E7E3
	for <lists+bpf@lfdr.de>; Fri,  1 Mar 2024 19:01:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2CBB01F27C0A
	for <lists+bpf@lfdr.de>; Fri,  1 Mar 2024 18:01:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B9871798F;
	Fri,  1 Mar 2024 18:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KC8J4lb8"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C113BE6C
	for <bpf@vger.kernel.org>; Fri,  1 Mar 2024 18:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709316065; cv=none; b=iolJbTKUHK775BCDQC1zvxukHl1vW66xuovTyWD8B9gjIcQm4bjRy3nmIT/jfimmQydk83RiI7xQlxjinzcjgtzPBX+NJCt2ujZnvvMV4glDp2v8hEqoqiwCCYYkqLR5S65UZeqfo+K1URyGlNCxZMfpqUQWNvOlfzsgA1CBnKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709316065; c=relaxed/simple;
	bh=gg+0xuuGr2zxmLzOTGwd5fb3Ef5XwpJ7LhGuUJp2h9Y=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=eujeyjebozdCRC0mfJJ+ebMAlgtVOqFWQ7imjSTWoWjUD1i9DvsQsX1pzwZMD3CPeLnMhL1iygFQKU8LE1Zr0G6ur5tzQiSYIEreIiKToE0mdg1RTtTmkUwKM73tXp9CiTJnykQW6fXsXKKnfwKKyiWSfXyehpBlSvrTyFlJzKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KC8J4lb8; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-5ce07cf1e5dso2147329a12.2
        for <bpf@vger.kernel.org>; Fri, 01 Mar 2024 10:01:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709316063; x=1709920863; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3W1q0kjp4FDZT759aLIu3ybGIycF4MUAkdCF9b/BhRA=;
        b=KC8J4lb85CCZrzuIiEnsxnmudLnNFPDQQFi1rnmsrkiFXf+Tbb/DhHih6XSP5Qvgu/
         VnM2eLk6ue9tY0EYacdFMEZI6SP8T9UbDNWKzwM3AqArcxDJFL3zEKOaVnFoqFacEPAI
         4xKyVpiCmG0G2I2DACa6/maut2cWokzh69oROOu0p8GsAd/6go2hSKBuHyc391usQz1m
         f/n1krli/PILCKqH6vUsE760roiGCJaSDl2taUnslzJS70n3kJq3U7x6ljWyh4HcyPg0
         yrG492T93ANPxeL2shNN94/+Y+wRphhZ322hfwHLOukkhpxPa0uji/HKJcEZllRqrdOM
         rqYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709316063; x=1709920863;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3W1q0kjp4FDZT759aLIu3ybGIycF4MUAkdCF9b/BhRA=;
        b=dBT1oRKuz2AodnwHlk50rA6MX95OlhZ0vznWOicHl1S4XIfbDVDZQjpBO7jzZsIQlE
         lv+Hhc6rrJNpU/9jocxQ9bUAx0pI67+cvFXiGBdJI07Y4AEvAS2EAkzdxjMxLYB2cCiV
         gaW4rmd9bLYZNI6hjcbH0iHKc3AFqG/mT321BJlNX+TfXJJuJggLCFJbb5LcBpH46nqw
         JxB9VGY3R2pYCUy+WgbRjUdLx7t23+ZNNWeLbpvsuMZ3bstcDsErXBZDIJWYbBBAkuW0
         JQ/HgEWIy8WJSGvhj0o2WTLsGDLmm7F0+9rNX083yX17cs1VuVfISRYh3QXx75kNPax/
         MTBg==
X-Forwarded-Encrypted: i=1; AJvYcCWviFuX8mr0LMns5Lo6Ogs7Z+dqAKPNJAos+LsDzqcy9rnJLNH+KSrA76qEfGoRmNhz5wCRGOdgE7evtiWO5DlCgdb/
X-Gm-Message-State: AOJu0YwozujOboZCXztsxs9W4qeGBfmZNxo/6l5r348sFCPESd+Fr34J
	K4nNanNqK26Je/bOhcKPhGj6bjL4sEqAes5TuYlrNexawu7Zxn6D
X-Google-Smtp-Source: AGHT+IEVuauCNm6pqiSwqjE43Of0p3ji7A0zg6g+k+lILWOWm1zK6KyY1FVvi2LVM5wo4mXE+syPYw==
X-Received: by 2002:a17:90a:f405:b0:29b:1658:e575 with SMTP id ch5-20020a17090af40500b0029b1658e575mr2163567pjb.19.1709316062572;
        Fri, 01 Mar 2024 10:01:02 -0800 (PST)
Received: from localhost ([98.97.43.160])
        by smtp.gmail.com with ESMTPSA id sw14-20020a17090b2c8e00b0029abf47ec7fsm5762357pjb.0.2024.03.01.10.01.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 10:01:01 -0800 (PST)
Date: Fri, 01 Mar 2024 10:01:00 -0800
From: John Fastabend <john.fastabend@gmail.com>
To: Yafang Shao <laoar.shao@gmail.com>, 
 John Fastabend <john.fastabend@gmail.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>, 
 ast@kernel.org, 
 daniel@iogearbox.net, 
 andrii@kernel.org, 
 martin.lau@linux.dev, 
 eddyz87@gmail.com, 
 song@kernel.org, 
 yonghong.song@linux.dev, 
 kpsingh@kernel.org, 
 sdf@google.com, 
 haoluo@google.com, 
 jolsa@kernel.org, 
 bpf@vger.kernel.org
Message-ID: <65e217dc4d34_5dcfe20887@john.notmuch>
In-Reply-To: <CALOAHbBCp=KsGadzr+Yjmyx9UZXgxzuWPMzG9OLu7XsBd6eNpw@mail.gmail.com>
References: <20240225100637.48394-1-laoar.shao@gmail.com>
 <20240225100637.48394-2-laoar.shao@gmail.com>
 <CAEf4BzZfUnV+k6kGo1+JDhhQ1SOnTJ84M-0GVn0m66z9d6DiqQ@mail.gmail.com>
 <CALOAHbARukciMpoKCDGmPRWuczS8FYLxNOK41iaHUOy1gHhDpA@mail.gmail.com>
 <CAEf4Bza3DTS4H7t1bx5JrJSrZgmbKS6-4A_pRQjocWBPsD3RHQ@mail.gmail.com>
 <CALOAHbCH8q_xPJBW=Eq-nwsS9N-EVnwt_dkKS_RjdHZMGsqq0w@mail.gmail.com>
 <CAEf4BzYK4o558CcQt=yzKZH+M-eD3z0GpdUORcapJKXAHZJy-g@mail.gmail.com>
 <65e102f6ebef2_33719208c8@john.notmuch>
 <CALOAHbBCp=KsGadzr+Yjmyx9UZXgxzuWPMzG9OLu7XsBd6eNpw@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 1/2] bpf: Add bits iterator
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Yafang Shao wrote:
> On Fri, Mar 1, 2024 at 6:19=E2=80=AFAM John Fastabend <john.fastabend@g=
mail.com> wrote:
> >
> > Andrii Nakryiko wrote:
> > > On Wed, Feb 28, 2024 at 6:16=E2=80=AFPM Yafang Shao <laoar.shao@gma=
il.com> wrote:
> > > >
> > > > On Wed, Feb 28, 2024 at 2:04=E2=80=AFPM Andrii Nakryiko
> > > > <andrii.nakryiko@gmail.com> wrote:
> > > > >
> > > > > On Tue, Feb 27, 2024 at 6:25=E2=80=AFPM Yafang Shao <laoar.shao=
@gmail.com> wrote:
> > > > > >
> > > > > > On Wed, Feb 28, 2024 at 9:24=E2=80=AFAM Andrii Nakryiko
> > > > > > <andrii.nakryiko@gmail.com> wrote:
> > > > > > >
> > > > > > > On Sun, Feb 25, 2024 at 2:07=E2=80=AFAM Yafang Shao <laoar.=
shao@gmail.com> wrote:
> > > > > > > >
> > > > > > > > Add three new kfuncs for the bits iterator:
> > > > > > > > - bpf_iter_bits_new
> > > > > > > >   Initialize a new bits iterator for a given memory area.=
 Due to the
> > > > > > > >   limitation of bpf memalloc, the max number of bits that=
 can be iterated
> > > > > > > >   over is limited to (4096 * 8).
> > > > > > > > - bpf_iter_bits_next
> > > > > > > >   Get the next bit in a bpf_iter_bits
> > > > > > > > - bpf_iter_bits_destroy
> > > > > > > >   Destroy a bpf_iter_bits
> > > > > > > >
> > > > > > > > The bits iterator facilitates the iteration of the bits o=
f a memory area,
> > > > > > > > such as cpumask. It can be used in any context and on any=
 address.
> > > > > > > >
> > > > > > > > Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> > > > > > > > ---

[...]

> > > > > > > > +/**
> > > > > > > > + * bpf_iter_bits_new() - Initialize a new bits iterator =
for a given memory area
> > > > > > > > + * @it: The new bpf_iter_bits to be created
> > > > > > > > + * @unsafe_ptr__ign: A ponter pointing to a memory area =
to be iterated over
> > > > > > > > + * @nr_bits: The number of bits to be iterated over. Due=
 to the limitation of
> > > > > > > > + * memalloc, it can't greater than (4096 * 8).
> > > > > > > > + *
> > > > > > > > + * This function initializes a new bpf_iter_bits structu=
re for iterating over
> > > > > > > > + * a memory area which is specified by the @unsafe_ptr__=
ign and @nr_bits. It
> > > > > > > > + * copy the data of the memory area to the newly created=
 bpf_iter_bits @it for
> > > > > > > > + * subsequent iteration operations.
> > > > > > > > + *
> > > > > > > > + * On success, 0 is returned. On failure, ERR is returne=
d.
> > > > > > > > + */
> > > > > > > > +__bpf_kfunc int
> > > > > > > > +bpf_iter_bits_new(struct bpf_iter_bits *it, const void *=
unsafe_ptr__ign, u32 nr_bits)
> > > > > > > > +{
> > > > > > > > +       struct bpf_iter_bits_kern *kit =3D (void *)it;
> > > > > > > > +       u32 size =3D BITS_TO_BYTES(nr_bits);
> > > > > > > > +       int err;
> > > > > > > > +
> > > > > > > > +       BUILD_BUG_ON(sizeof(struct bpf_iter_bits_kern) !=3D=
 sizeof(struct bpf_iter_bits));
> > > > > > > > +       BUILD_BUG_ON(__alignof__(struct bpf_iter_bits_ker=
n) !=3D
> > > > > > > > +                    __alignof__(struct bpf_iter_bits));
> > > > > > > > +
> > > > > > > > +       if (!unsafe_ptr__ign || !nr_bits) {
> > > > > > > > +               kit->bits =3D NULL;
> > > > > > > > +               return -EINVAL;
> > > > > > > > +       }
> > > > > > > > +
> > > > > > > > +       kit->bits =3D bpf_mem_alloc(&bpf_global_ma, size)=
;
> > > > > > > > +       if (!kit->bits)
> > > > > > > > +               return -ENOMEM;
> > > > > > >
> > > > > > > it's probably going to be a pretty common case to do bits i=
teration
> > > > > > > for nr_bits<=3D64, right?
> > > > > >
> > > > > > It's highly unlikely.
> > > > > > Consider the CPU count as an example; There are 256 CPUs on o=
ur AMD
> > > > > > EPYC servers.
> > > > >
> > > > > Also consider u64-based bit masks (like struct backtrack_state =
in
> > > > > verifier code, which has u32 reg_mask and u64 stack_mask). This=

> > > > > iterator is a generic bits iterator, there are tons of cases of=

> > > > > u64/u32 masks in practice.
> > > >
> > > > Should we optimize it as follows?
> > > >
> > > >     if (nr_bits <=3D 64) {
> > > >         // do the optimization
> > > >     } else {
> > > >         // fallback to memalloc
> > > >     }
> > > >
> > >
> > > Yep, that's what I'm proposing
> >
> > When I suggested why not just open code this in BPF earlier I was
> > mostly thinking of these u64 and u32 masks we have lots of them
> > in our code base as well.
> >
> > I have something like this which might be even better than 3
> > calls depending on your use case,
> >
> >  int find_next_bit(uint64_t bits, int last_bit)
> >  {
> >     int i =3D last_bit;
> >     for (i =3D 0; i < sizeof(uint64_t) * 8; i++) {
> >         if (bits & (1 << i))
> >            return i;
> >     }
> >     return -1;
> >   }
> >
> > Verifier seems plenty happy with above.
> =

> I'm not quite following.
> Regarding the find_next_bit() function you mentioned, it seems it only
> retrieves one bit at a time, necessitating a for loop for execution,
> correct? Consequently, the verifier will likely fail the for loop.

In practice for small sizes uint64_t and uint32_t we don't see any
issue. Just a comment that this can be open coded without much
trouble in many cases. Not against the helper at all.

> =

> -- =

> Regards
> Yafang=

