Return-Path: <bpf+bounces-23158-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E380B86E705
	for <lists+bpf@lfdr.de>; Fri,  1 Mar 2024 18:16:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 111921C23700
	for <lists+bpf@lfdr.de>; Fri,  1 Mar 2024 17:16:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A1836FC8;
	Fri,  1 Mar 2024 17:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i++y2is5"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 691878825
	for <bpf@vger.kernel.org>; Fri,  1 Mar 2024 17:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709313372; cv=none; b=IPRI9GyBUUWeVwu5leHhqwH7Mru41D6763fojiiP1K8JdIxs3rZAcB9OOZoVf08vKkN3zvDj41RVma4cLeHANCWNnOVptx2010fNmAoDYJj/TdRvRPD5an4lypfiMZ1ETKvX5Wrv0Mk0iN3Hu9ibsbMrYJmJOrZee0WIkYjegHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709313372; c=relaxed/simple;
	bh=uU2M0zmN5qbD6sVMPfKQcr4nVgXOwzVUYxhoof1/wqQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j4PvFRN68YGPy9wW9ApacLZLaFScVOo6dKT/giYE9D7cYA7Z4QSvQj4xUnO/z9B8u68AsGg8jJDEc3JD7kfNapEgvgyWaNRwBBGXyConP7wclA41c1dmHjngGRKpgj3lDMM/bKVKltkAOhL2pckngX4DV3CvZMlbXZKzUukvizc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i++y2is5; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-412a9e9c776so21179065e9.0
        for <bpf@vger.kernel.org>; Fri, 01 Mar 2024 09:16:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709313369; x=1709918169; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zh6VGK2wJiuVWjc3TBelv2KtlcgOIUcIq2uEAqbpC10=;
        b=i++y2is5vxldIeNXGLsjxpct8sg5FT40IlpvkPtBe1lmD8/uLac3VeVn3n41rCrGPk
         Y1yyDIHI25k1S4MW7UAJwMgpJgLcc4Z6vpcyEMHceGM7Sp/T4E4gfFF6DnhxlZ+QMTFc
         ucGx930No3hHPTuLzpvTVC7HnBU13H5/79VG3Y+quo/RqOrDvnbWDBkwUG3qlF1f5eHF
         /i/xxu+1pOOI0yqjyu1CRNsxPU93nAeaXTgl4wlz7Via8zb7lQoEsK8NtpiFdv1VLxUg
         3wimBXlymRc5PQWpQ43MWiuHKqyxCSVb2Y0HFnvgOFbRX5oIWiTobdaoVVodw2yT15+S
         VP4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709313369; x=1709918169;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zh6VGK2wJiuVWjc3TBelv2KtlcgOIUcIq2uEAqbpC10=;
        b=c/p1BuGIES/V9lHR4/3J/HHAE5/PnCm0PDabwREdn0NMvdbSqWDAt/lccsmtQ6ABM0
         dkBw7leZVHKq7nLRc5co4PhCkldSZNkJPhRRTyOSTCaFBLCmaQaiktkxxzY1lz71Hnhb
         T+TzC9g/uGneNj6wxKmT87325mrBDPzS6xdwmofdaddT4IDOlY4xibLD5o+gO+CNiO+y
         J5k5v2ArQPZziHJtp4l+rcgBKx1KcoxNUl891VZNlA9b97bU8nYz+4FS7Gg5EZVMabnI
         JKIVo1a9AOwX6zrCTE7NjabqTNYZLQVN1vVy8lvOKxZrWknMpKsdhhtS4f9B+ISLjF/c
         pUgg==
X-Forwarded-Encrypted: i=1; AJvYcCWjZp4mVfd8zsG4/71GBL/gdt6A7EOiT59nx8exPCk9ND/JYClHFGbkBL0NZlaHWy1vgGTTYDXNhReJBbOFC8kevlMA
X-Gm-Message-State: AOJu0YyP8kxXcPUPGNUfhiyLDsjBrk5ULyabxqB80sGdgMQRPNSvz+wD
	5m3gzXB/NhilApPUUdEEq4oBHped21sgG011jOg3wj953FkWL2aJWtXvnxbkhKcfbXUt7UJ7iLt
	n+HH3awXcLg8RuQHpHS4gPbS5R68=
X-Google-Smtp-Source: AGHT+IFgjJfyGF7o03uje3Xr/QIJbKei5wtKeke8J6RLcuS1l6jhHfNlT6p0wOxHq8lh0V7ZgLxXpheKFHPnGFFhy5s=
X-Received: by 2002:a5d:4707:0:b0:33d:e02a:c552 with SMTP id
 y7-20020a5d4707000000b0033de02ac552mr2494255wrq.34.1709313368476; Fri, 01 Mar
 2024 09:16:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240229112250.13723-1-toke@redhat.com> <20240229112250.13723-3-toke@redhat.com>
 <CAADnVQJTEo8c1=vs8avDakMKYjBopVXKNQ5f=bgrBSqELZhBow@mail.gmail.com>
 <65e10367cb393_33719208c2@john.notmuch> <878r32b04u.fsf@toke.dk>
In-Reply-To: <878r32b04u.fsf@toke.dk>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 1 Mar 2024 09:15:57 -0800
Message-ID: <CAADnVQLzVJRut0v2dQPbBUDW971Fd-EjkOf0pyLh5-W7wYwiYA@mail.gmail.com>
Subject: Re: [PATCH bpf v2 2/2] bpf: Fix hashtab overflow check on 32-bit arches
To: =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>
Cc: John Fastabend <john.fastabend@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 1, 2024 at 4:35=E2=80=AFAM Toke H=C3=B8iland-J=C3=B8rgensen <to=
ke@redhat.com> wrote:
>
> John Fastabend <john.fastabend@gmail.com> writes:
>
> > Alexei Starovoitov wrote:
> >> On Thu, Feb 29, 2024 at 3:23=E2=80=AFAM Toke H=C3=B8iland-J=C3=B8rgens=
en <toke@redhat.com> wrote:
> >> >
> >> > The hashtab code relies on roundup_pow_of_two() to compute the numbe=
r of
> >> > hash buckets, and contains an overflow check by checking if the resu=
lting
> >> > value is 0. However, on 32-bit arches, the roundup code itself can o=
verflow
> >> > by doing a 32-bit left-shift of an unsigned long value, which is und=
efined
> >> > behaviour, so it is not guaranteed to truncate neatly. This was trig=
gered
> >> > by syzbot on the DEVMAP_HASH type, which contains the same check, co=
pied
> >> > from the hashtab code. So apply the same fix to hashtab, by moving t=
he
> >> > overflow check to before the roundup.
> >> >
> >> > The hashtab code also contained a check that prevents the total allo=
cation
> >> > size for the buckets from overflowing a 32-bit value, but since all =
the
> >> > allocation code uses u64s, this does not really seem to be necessary=
, so
> >> > drop it and keep only the strict overflow check of the n_buckets var=
iable.
> >> >
> >> > Fixes: daaf427c6ab3 ("bpf: fix arraymap NULL deref and missing overf=
low and zero size checks")
> >> > Signed-off-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
> >> > ---
> >> >  kernel/bpf/hashtab.c | 10 +++++-----
> >> >  1 file changed, 5 insertions(+), 5 deletions(-)
> >> >
> >> > diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
> >> > index 03a6a2500b6a..4caf8dab18b0 100644
> >> > --- a/kernel/bpf/hashtab.c
> >> > +++ b/kernel/bpf/hashtab.c
> >> > @@ -499,8 +499,6 @@ static struct bpf_map *htab_map_alloc(union bpf_=
attr *attr)
> >> >                                                           num_possib=
le_cpus());
> >> >         }
> >> >
> >> > -       /* hash table size must be power of 2 */
> >> > -       htab->n_buckets =3D roundup_pow_of_two(htab->map.max_entries=
);
> >> >
> >> >         htab->elem_size =3D sizeof(struct htab_elem) +
> >> >                           round_up(htab->map.key_size, 8);
> >> > @@ -510,11 +508,13 @@ static struct bpf_map *htab_map_alloc(union bp=
f_attr *attr)
> >> >                 htab->elem_size +=3D round_up(htab->map.value_size, =
8);
> >> >
> >> >         err =3D -E2BIG;
> >> > -       /* prevent zero size kmalloc and check for u32 overflow */
> >> > -       if (htab->n_buckets =3D=3D 0 ||
> >> > -           htab->n_buckets > U32_MAX / sizeof(struct bucket))
> >> > +       /* prevent overflow in roundup below */
> >> > +       if (htab->map.max_entries > U32_MAX / 2 + 1)
> >> >                 goto free_htab;
> >>
> >> No. We cannot artificially reduce max_entries that will break real use=
rs.
> >> Hash table with 4B elements is not that uncommon.
>
> Erm, huh? The existing code has the n_buckets > U32_MAX / sizeof(struct
> bucket) check, which limits max_entries to 134M (0x8000000). This patch
> is *increasing* the maximum allowable size by a factor of 16 (to 2.1B or
> 0x80000000).
>
> > Agree how about return E2BIG in these cases (32bit arch and overflow) a=
nd
> > let user figure it out. That makes more sense to me.
>
> Isn't that exactly what this patch does? What am I missing here?

I see. Then what are you fixing?
roundup_pow_of_two() will return 0 and existing code is fine as-is.

