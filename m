Return-Path: <bpf+bounces-23081-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B6EA86D4B4
	for <lists+bpf@lfdr.de>; Thu, 29 Feb 2024 21:46:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 59DBF1C21FB0
	for <lists+bpf@lfdr.de>; Thu, 29 Feb 2024 20:46:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A3EE158D77;
	Thu, 29 Feb 2024 20:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WV3ZPBh9"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 909E514BF57;
	Thu, 29 Feb 2024 20:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709239180; cv=none; b=EVDvE9h9rpIr4FUFMFS5PLdrLnhIxBng2BJssz84HQPFFpKqf8IM3wTCCGSS/DakU7KrWifl0Zoqw8MKuSHS5Y/Lw0Xy7dGPEaQbvykzZ1dP3VLCVYGn4NReC56ApS5OKiBftmz1t+A+lPFSFjE5UPQIcl2W1fSPy8qyKbD2AC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709239180; c=relaxed/simple;
	bh=B+M+BX4GSk9XU2Zt5arn3kVSOj/DdLUCPL1b5EzPo0w=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=Q1ADWFcnf4CJtiiWp+7K/9EEDUiTKzkfZLJGtIWjAWdKBFRlzMgNnvxLco2Fa9hf4f4ALe/2M0vRiLykt3y191c6e3089frJq2dmyk8tfANAawBFog3rn4DEnmGa4+hy+Cbz36gwT4yK6YdJT/u8L5xCCoDmnpCO1r3g8wWxpR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WV3ZPBh9; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1dc1ff58fe4so12207445ad.1;
        Thu, 29 Feb 2024 12:39:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709239178; x=1709843978; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CltTZohNET3MTMYyF/2FXyGhZH7B87OJCWb5gP5mDbY=;
        b=WV3ZPBh9v0qC2U28Y49vuxjBQ4o0ORit6kAqbbo/XdnfcRx+2L21ENKH2LORXv7OtZ
         XI+3zE4SestjKvLkVACu2jSugOD0zlq+spM6n5fpB6QHzvaQqh58qVf+Bg7ghEj508ly
         R9oHVzavB/F3z//3UG06GM0NPDWo2Jd3avXm1DUcZmucLUTFCLChIO21Bx2DIt3jImN+
         ZwRkuQ+4sLGNAezTwbeTaSjbmryJTwdPMjHCvvEirWCj97qm2MeEIS+QD9m5UQ/CEnyC
         Z6p6BvrcutcQZypkfZRjC8yEX1LWI8tF0oFfrzLRr6KcOLsHUC2TRQIcBO/9eBSr7g/5
         x7AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709239178; x=1709843978;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=CltTZohNET3MTMYyF/2FXyGhZH7B87OJCWb5gP5mDbY=;
        b=O6eSPGK3P5PesoyeYgVvnOlU8xmTTXf5PKVuMBB2w1TgdlET59BQQ46RC24Lk9UkNt
         Cj9igrufMnJShVtwFibEsYn3L2+vsZR5dQqSv6lhJXAnI7oU2cZz+iQjKV7hrkvPpNuz
         XsDjwphDy+H8kltLE5PmcbFB5ckqYT2ysn7Mpnsj7dryoEctcr37dBj2zcdUNEDrt28g
         rlUZuRFP8qRkhD2IIlPtXELNmDPyKc6hnyVcIU0hbLxABajtD6Iq1m02g79UGD1SvQVH
         jgva/fhKoKSlfbISjfK/ESLsX31bcQot79R90c+9RIqavKQ6SyXHO8UXwoRlBq6IhruN
         76vw==
X-Forwarded-Encrypted: i=1; AJvYcCWCQTYPPEnKsMVhWahm3sz/wkp0EDXiD59HNiolI0v6xrYcqRGpnQxqFrF7AWsw2F53hfC6VfG/RrQOkGO7EYo0PZne80jlcwUxTtL/oXTuX1G7u7verdc6l/5B
X-Gm-Message-State: AOJu0YyntGgk7O29qPj5Zns/IkzETvi28HFMWWOS3ka0eBGl4Ym7L9AA
	a7RSGFxHegzWjXbsprY7udOGSXBREdtfQVdze2pFAbuIZg/8/3hp
X-Google-Smtp-Source: AGHT+IGF4pSLb+yBjdqoX1FoorcH2PoMUIu0ffzSSlbXs1jC4Y0owSUSF8ZRe8EghH5CgKEwuv3xWA==
X-Received: by 2002:a17:902:da85:b0:1dc:a60f:1b6a with SMTP id j5-20020a170902da8500b001dca60f1b6amr3808783plx.13.1709239177658;
        Thu, 29 Feb 2024 12:39:37 -0800 (PST)
Received: from localhost ([98.97.43.160])
        by smtp.gmail.com with ESMTPSA id w1-20020a170902d10100b001dbb14e6feesm1946248plw.189.2024.02.29.12.39.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Feb 2024 12:39:36 -0800 (PST)
Date: Thu, 29 Feb 2024 12:39:35 -0800
From: John Fastabend <john.fastabend@gmail.com>
To: =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 "David S. Miller" <davem@davemloft.net>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Jesper Dangaard Brouer <hawk@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, 
 KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@google.com>, 
 Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>
Cc: syzbot+8cd36f6b65f3cafd400a@syzkaller.appspotmail.com, 
 netdev@vger.kernel.org, 
 bpf@vger.kernel.org
Message-ID: <65e0eb87a079e_322af20886@john.notmuch>
In-Reply-To: <87zfvj8tiz.fsf@toke.dk>
References: <20240227152740.35120-1-toke@redhat.com>
 <65dfa50679d0a_2beb3208c8@john.notmuch>
 <87zfvj8tiz.fsf@toke.dk>
Subject: RE: [PATCH bpf] bpf: Fix DEVMAP_HASH overflow check on 32-bit arches
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

> > Toke H=C3=B8iland-J=C3=B8rgensen wrote:
> >> The devmap code allocates a number hash buckets equal to the next po=
wer of two
> >> of the max_entries value provided when creating the map. When roundi=
ng up to the
> >> next power of two, the 32-bit variable storing the number of buckets=
 can
> >> overflow, and the code checks for overflow by checking if the trunca=
ted 32-bit value
> >> is equal to 0. However, on 32-bit arches the rounding up itself can =
overflow
> >> mid-way through, because it ends up doing a left-shift of 32 bits on=
 an unsigned
> >> long value. If the size of an unsigned long is four bytes, this is u=
ndefined
> >> behaviour, so there is no guarantee that we'll end up with a nice an=
d tidy
> >> 0-value at the end.

Hi Toke, dumb question where is this left-shift noted above? It looks lik=
e fls_long
tries to account by having a check for sizeof(l) =3D=3D 4. I'm asking mos=
tly because
I've found a few more spots without this check.

> >> =

> >> Syzbot managed to turn this into a crash on arm32 by creating a DEVM=
AP_HASH with
> >> max_entries > 0x80000000 and then trying to update it. Fix this by m=
oving the
> >> overflow check to before the rounding up operation.
> >> =

> >> Fixes: 6f9d451ab1a3 ("xdp: Add devmap_hash map type for looking up d=
evices by hashed index")
> >> Link: https://lore.kernel.org/r/000000000000ed666a0611af6818@google.=
com
> >> Reported-and-tested-by: syzbot+8cd36f6b65f3cafd400a@syzkaller.appspo=
tmail.com
> >> Signed-off-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
> >> ---
> >>  kernel/bpf/devmap.c | 8 +++-----
> >>  1 file changed, 3 insertions(+), 5 deletions(-)
> >> =

> >> diff --git a/kernel/bpf/devmap.c b/kernel/bpf/devmap.c
> >> index a936c704d4e7..9b2286f9c6da 100644
> >> --- a/kernel/bpf/devmap.c
> >> +++ b/kernel/bpf/devmap.c
> >> @@ -130,13 +130,11 @@ static int dev_map_init_map(struct bpf_dtab *d=
tab, union bpf_attr *attr)
> >>  	bpf_map_init_from_attr(&dtab->map, attr);
> >>  =

> >>  	if (attr->map_type =3D=3D BPF_MAP_TYPE_DEVMAP_HASH) {
> >> -		dtab->n_buckets =3D roundup_pow_of_two(dtab->map.max_entries);
> >> -
> >> -		if (!dtab->n_buckets) /* Overflow check */
> >> +		if (dtab->map.max_entries > U32_MAX / 2)
> >>  			return -EINVAL;
> >> -	}
> >>  =

> >> -	if (attr->map_type =3D=3D BPF_MAP_TYPE_DEVMAP_HASH) {
> >> +		dtab->n_buckets =3D roundup_pow_of_two(dtab->map.max_entries);
> >> +
> >>  		dtab->dev_index_head =3D dev_map_create_hash(dtab->n_buckets,
> >>  							   dtab->map.numa_node);
> >>  		if (!dtab->dev_index_head)
> >> -- =

> >> 2.43.2
> >> =

> >
> > I'm fairly sure this code was just taken from the hashtab implementat=
ion.
> =

> Yup, it was :)
> =

> > Do we also need a fix there?
> >
> >         /* hash table size must be power of 2 */
> >         htab->n_buckets =3D roundup_pow_of_two(htab->map.max_entries)=
;
> >
> > The u32 check in hashtab is,
> >
> >         /* prevent zero size kmalloc and check for u32 overflow */
> >         if (htab->n_buckets =3D=3D 0 ||
> >             htab->n_buckets > U32_MAX / sizeof(struct bucket))
> >                 goto free_htab;
> =

> Yeah, I don't see any reason why this wouldn't be susceptible to the
> same issue. I'll send a follow-up to apply the same fix there.

Cool thanks one more question above.

> =

> -Toke
> =




