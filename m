Return-Path: <bpf+bounces-23159-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CD58786E70B
	for <lists+bpf@lfdr.de>; Fri,  1 Mar 2024 18:21:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31584282171
	for <lists+bpf@lfdr.de>; Fri,  1 Mar 2024 17:21:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DCA8612B;
	Fri,  1 Mar 2024 17:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TqZMmOcM"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 721316AA2
	for <bpf@vger.kernel.org>; Fri,  1 Mar 2024 17:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709313673; cv=none; b=RcwbWI/1lvl9yjJXjc1lkV6Glj7pwIbqZkWUcqB1TbLtfia7rcyk2hT3ccKUjVoAlI73nKoMtn35ihP/4APVN/MPyMoRc+exMJI//R8j45e++Z6owAUpB950xPMM+ak/0BC/IeK6+XOb84dl/tS6K6mZO8bzkLg9QDuWJ4ydo40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709313673; c=relaxed/simple;
	bh=vldD/h5QogbQBTcgMoPCHQlfhelK5/ZRdrACvfFMVC4=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=qmxguFoK9d3ns2cNZ6Sp18mEBA2FFzpbe/zB8QQtZVXnQIcx0OHw8WVpL9hl2h8KRJFaTeyZhO7BEVpM+MUN2T/0S+no8odqygXXOfG409/Sk7sgHBV6tSWE7mmNYCE5spsSA48d55eDy/P4jeqBdLC/7qN9tLdMdMFRoYSoIlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TqZMmOcM; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-3bd72353d9fso1354393b6e.3
        for <bpf@vger.kernel.org>; Fri, 01 Mar 2024 09:21:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709313671; x=1709918471; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ND12PBLU7YV402kuLAPVAsMifFFJ4XfndyLwxMoeutk=;
        b=TqZMmOcMvB/V1GCOPodXkjoWjrN0WVhZrjv/N6ZwuZ7WXFi1iKJI1F/XobIyA0NYgK
         9QrdO8DWYU12I/I9A2HGydC40UCi8+zHfcgDf/xH8XWSFw+nfvG+BCXzGNLLWE6O3Uyo
         T/qVW63qMrpSVh5yBkjhMLvTqvZzcJ58qmd9Fj/s8ajqRmZdcSBwn79rP2qP+n5y/7LJ
         f3Z82byJ8/JRsdUVZJ7vz3ESyD9kL41cNffxEeh9NCeAB9DfguWEYym9mWGbY6Dx1kQm
         HUZWI110sH6lam3nqGL9Rly0fKqNY+KLZ98RusftspLtwCMOM+Papr5K2a5k2r/l3Qfv
         6fng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709313671; x=1709918471;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ND12PBLU7YV402kuLAPVAsMifFFJ4XfndyLwxMoeutk=;
        b=Wyt4U9veEyvqF1//tI3v/zFkqDQOnMfo6GnTpCBCYGOKZbhCzkFfS2pgv2JO1KkX6J
         2jrZtx7SXCmu/pyV0Uq5Ctm109cmUw0nBeQpJU6syCgRj9fZ0mNAOrSh07TO3d45n2/z
         fCRoSBz29bmVz/uY/hRwPpwqi1AKQnT7y/pnuK5GWDPBOf4taWnow/pwBCp2YrjAj3/C
         MqgeZTtVZcJvGX2/xAJ8qp24tSCjBP1L7pB4sRU9Tjs/eBGMFqSay+B2QJUVnby47KSz
         lRvOsUlL0ZeP5jpveQOOdiDs/UBtJIAiTcn2BRQuPW31icJVV0y6DSNgIU2IJRLpfDsf
         QEkQ==
X-Forwarded-Encrypted: i=1; AJvYcCVA7iyv75+DLXX92fFTTw3mG4lp/NV05kE7dMtW1g3pHUvSvLMuEciN7U1Ig2MkMf4yFX/l2kJTl2mzkejkRHYbTrqA
X-Gm-Message-State: AOJu0YxasYGmVTJYOiI9aqhT0eJgvK1Q8RZbj9qigtHB732xTPKLBoLa
	73u3Cj5firt4I/COmhLaicHKEOQIcuBbqb3M4wGL3vQKkMJpeQphHj78QH6eMpM=
X-Google-Smtp-Source: AGHT+IHQtrYQt7PMSdPyljsTitkQhUTUqWd3oXKA5WwyCBkZF4wM0MvBy7rYxLxmepSmUkXyRdjOhQ==
X-Received: by 2002:a05:6808:a19:b0:3c1:a9ef:e8a0 with SMTP id n25-20020a0568080a1900b003c1a9efe8a0mr2270888oij.48.1709313671441;
        Fri, 01 Mar 2024 09:21:11 -0800 (PST)
Received: from localhost ([98.97.43.160])
        by smtp.gmail.com with ESMTPSA id f36-20020a635564000000b005d8b2f04eb7sm3192888pgm.62.2024.03.01.09.21.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 09:21:10 -0800 (PST)
Date: Fri, 01 Mar 2024 09:21:09 -0800
From: John Fastabend <john.fastabend@gmail.com>
To: =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, 
 John Fastabend <john.fastabend@gmail.com>, 
 KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@google.com>, 
 Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, 
 bpf <bpf@vger.kernel.org>
Message-ID: <65e20e8522e00_5dcfe2085e@john.notmuch>
In-Reply-To: <878r32b04u.fsf@toke.dk>
References: <20240229112250.13723-1-toke@redhat.com>
 <20240229112250.13723-3-toke@redhat.com>
 <CAADnVQJTEo8c1=vs8avDakMKYjBopVXKNQ5f=bgrBSqELZhBow@mail.gmail.com>
 <65e10367cb393_33719208c2@john.notmuch>
 <878r32b04u.fsf@toke.dk>
Subject: Re: [PATCH bpf v2 2/2] bpf: Fix hashtab overflow check on 32-bit
 arches
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Toke H=C3=B8iland-J=C3=B8rgensen wrote:
> John Fastabend <john.fastabend@gmail.com> writes:
> =

> > Alexei Starovoitov wrote:
> >> On Thu, Feb 29, 2024 at 3:23=E2=80=AFAM Toke H=C3=B8iland-J=C3=B8rge=
nsen <toke@redhat.com> wrote:
> >> >
> >> > The hashtab code relies on roundup_pow_of_two() to compute the num=
ber of
> >> > hash buckets, and contains an overflow check by checking if the re=
sulting
> >> > value is 0. However, on 32-bit arches, the roundup code itself can=
 overflow
> >> > by doing a 32-bit left-shift of an unsigned long value, which is u=
ndefined
> >> > behaviour, so it is not guaranteed to truncate neatly. This was tr=
iggered
> >> > by syzbot on the DEVMAP_HASH type, which contains the same check, =
copied
> >> > from the hashtab code. So apply the same fix to hashtab, by moving=
 the
> >> > overflow check to before the roundup.
> >> >
> >> > The hashtab code also contained a check that prevents the total al=
location
> >> > size for the buckets from overflowing a 32-bit value, but since al=
l the
> >> > allocation code uses u64s, this does not really seem to be necessa=
ry, so
> >> > drop it and keep only the strict overflow check of the n_buckets v=
ariable.
> >> >
> >> > Fixes: daaf427c6ab3 ("bpf: fix arraymap NULL deref and missing ove=
rflow and zero size checks")
> >> > Signed-off-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
> >> > ---

Acked-by: John Fastabend <john.fastabend@gmail.com>

> >> >  kernel/bpf/hashtab.c | 10 +++++-----
> >> >  1 file changed, 5 insertions(+), 5 deletions(-)
> >> >
> >> > diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
> >> > index 03a6a2500b6a..4caf8dab18b0 100644
> >> > --- a/kernel/bpf/hashtab.c
> >> > +++ b/kernel/bpf/hashtab.c
> >> > @@ -499,8 +499,6 @@ static struct bpf_map *htab_map_alloc(union bp=
f_attr *attr)
> >> >                                                           num_poss=
ible_cpus());
> >> >         }
> >> >
> >> > -       /* hash table size must be power of 2 */
> >> > -       htab->n_buckets =3D roundup_pow_of_two(htab->map.max_entri=
es);
> >> >
> >> >         htab->elem_size =3D sizeof(struct htab_elem) +
> >> >                           round_up(htab->map.key_size, 8);
> >> > @@ -510,11 +508,13 @@ static struct bpf_map *htab_map_alloc(union =
bpf_attr *attr)
> >> >                 htab->elem_size +=3D round_up(htab->map.value_size=
, 8);
> >> >
> >> >         err =3D -E2BIG;
> >> > -       /* prevent zero size kmalloc and check for u32 overflow */=

> >> > -       if (htab->n_buckets =3D=3D 0 ||
> >> > -           htab->n_buckets > U32_MAX / sizeof(struct bucket))
> >> > +       /* prevent overflow in roundup below */
> >> > +       if (htab->map.max_entries > U32_MAX / 2 + 1)
> >> >                 goto free_htab;
> >> =

> >> No. We cannot artificially reduce max_entries that will break real u=
sers.
> >> Hash table with 4B elements is not that uncommon.
> =

> Erm, huh? The existing code has the n_buckets > U32_MAX / sizeof(struct=

> bucket) check, which limits max_entries to 134M (0x8000000). This patch=

> is *increasing* the maximum allowable size by a factor of 16 (to 2.1B o=
r
> 0x80000000).

Yep. From my side makes sense ACK for me. Maybe put it in the commit mess=
age
if it wasn't obvious. =



> =

> > Agree how about return E2BIG in these cases (32bit arch and overflow)=
 and =

> > let user figure it out. That makes more sense to me.
> =

> Isn't that exactly what this patch does? What am I missing here?

Nothing it was me must have been tired. Sorry about that.

> =

> -Toke
> =




