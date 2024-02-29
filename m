Return-Path: <bpf+bounces-23092-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 195FE86D6C6
	for <lists+bpf@lfdr.de>; Thu, 29 Feb 2024 23:21:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 83A3B1F21479
	for <lists+bpf@lfdr.de>; Thu, 29 Feb 2024 22:21:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E479574BF1;
	Thu, 29 Feb 2024 22:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EUNJzMNc"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B8F616FF37
	for <bpf@vger.kernel.org>; Thu, 29 Feb 2024 22:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709245291; cv=none; b=hvMba1PNUcFUTLnDIwyF8A4HNi4d9A7IDsyEU7ANX0uHlOfy+6OipCbOXos6NdLnCgGy02qoMMxNaekniPl2pR/pN6ak6UVz05gWsZIOly/Su/6TCR+n5JEIdXyvp90WlEnL6htAHd+S4oGXEXdNkRV+VKSQCV/xl1WtBa4a+ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709245291; c=relaxed/simple;
	bh=vYwYTGKC0UHziBY349tY77TN42oQjsuAcN1ujonNk+M=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=IvcXfMmt0ljzrif9dDivBbDVcur6WMju/5vHuuTff3BWFoRXefScsPRa82oQg+WMShxg2XfberV7WRkkvcQ8PvAwbVB+epMc/nae7ahCYjRIm4aq+pXE8VVoFgWCQ2DARuUrFBp7bLWiLAXjEH6Mhlj/Sy4nTOHG7DD+4QIDjpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EUNJzMNc; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1dc49b00bdbso15021885ad.3
        for <bpf@vger.kernel.org>; Thu, 29 Feb 2024 14:21:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709245289; x=1709850089; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/eBWdjPypUKBmZCYYBgrjpyCyNGOUhvO1KBd7gaJp0U=;
        b=EUNJzMNcj/8YH/as6B47xO0jPO7B2hUihg382Nf8RntHqwMTMZJkrPoYlYYUHkM48v
         wCppg3wLl912e7bLDZABJkRxm5HKLdBEoStOCif0IAZUbjyM1yJ/aoRPI5aGFRzMe9lN
         KX+4luW59qP+e7eNnH7qB/aHs+z1k3WeCOPQX8OVuAnWuVcNQ2eC4uefDHHbwdWLAN3b
         JxV0/PlcCYpAzTxGzIgWL4c10F2+llxL6ZzqWjQm1IbLiqHIYgThxY2WiNjNRwfc2FPI
         f7qgiWajySIfSY4brd31dO5c7U6i+TyXQU1AAQ0478T+jN2n9Ir2kr5+X8/ziaBNnnHa
         gNkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709245289; x=1709850089;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/eBWdjPypUKBmZCYYBgrjpyCyNGOUhvO1KBd7gaJp0U=;
        b=ooyT+ya0NVPKV6367SnYQ8WfdBtVZvj7G6P5Je0CouYef3ydV/nb5mMdAGE6aMlCq5
         qd26OxQhR7g6Jub+CSIEs9SxRzmSMQlrbpsgZyj82H7nu1QhLU4whim84EeQHZNXqxsd
         sedYcGiLcUPuFkW3gsLpoiRXzx5Y4fopdg/Lnyr+gi0OP5ghSS2RI3NpMPXSqrOojpVu
         1VAriVvMsaj55jiXURSCWfCkxi2QGYlcg9fn2zxQqU8IIWXjZ/bvKxaun1k6XbMkBR+Q
         F+6AutzxVB/sUcDKTPex2l47MASEhjg1PeFlyIw3E5tAQvXE5KNXFaOSnZH04bn3M5YQ
         E4jQ==
X-Forwarded-Encrypted: i=1; AJvYcCVSQha7uyjmdgdfBNKH42wKFfq7glzyBzZD85TPjRXL+gqD+WnBtk3r74CJQonTXFMPBqhlShwtxUy7Dbse7r8HuDSu
X-Gm-Message-State: AOJu0YyqRm9qoJzWLEIUOCZvlvbyuS3MCjtDvVI/6rwkA7P9YYg4pwtD
	3mq25Pz+ccbN0Idg9ZmLz+S+K+5FgYQQA6JhcHMXpf9EY/GFUpkg
X-Google-Smtp-Source: AGHT+IG9x1IsmciU2uIeU9ukTxi+i0qH8yB81KcwWGjE8xDV+9uuWhXfPP5Xh2yY2Fly2YDu0Goi2w==
X-Received: by 2002:a17:902:7d8b:b0:1db:fcc8:7d96 with SMTP id a11-20020a1709027d8b00b001dbfcc87d96mr3234024plm.14.1709245289461;
        Thu, 29 Feb 2024 14:21:29 -0800 (PST)
Received: from localhost ([98.97.43.160])
        by smtp.gmail.com with ESMTPSA id j14-20020a170902da8e00b001dc96cb0358sm2010604plx.206.2024.02.29.14.21.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Feb 2024 14:21:28 -0800 (PST)
Date: Thu, 29 Feb 2024 14:21:27 -0800
From: John Fastabend <john.fastabend@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, 
 =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>
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
Message-ID: <65e10367cb393_33719208c2@john.notmuch>
In-Reply-To: <CAADnVQJTEo8c1=vs8avDakMKYjBopVXKNQ5f=bgrBSqELZhBow@mail.gmail.com>
References: <20240229112250.13723-1-toke@redhat.com>
 <20240229112250.13723-3-toke@redhat.com>
 <CAADnVQJTEo8c1=vs8avDakMKYjBopVXKNQ5f=bgrBSqELZhBow@mail.gmail.com>
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

Alexei Starovoitov wrote:
> On Thu, Feb 29, 2024 at 3:23=E2=80=AFAM Toke H=C3=B8iland-J=C3=B8rgense=
n <toke@redhat.com> wrote:
> >
> > The hashtab code relies on roundup_pow_of_two() to compute the number=
 of
> > hash buckets, and contains an overflow check by checking if the resul=
ting
> > value is 0. However, on 32-bit arches, the roundup code itself can ov=
erflow
> > by doing a 32-bit left-shift of an unsigned long value, which is unde=
fined
> > behaviour, so it is not guaranteed to truncate neatly. This was trigg=
ered
> > by syzbot on the DEVMAP_HASH type, which contains the same check, cop=
ied
> > from the hashtab code. So apply the same fix to hashtab, by moving th=
e
> > overflow check to before the roundup.
> >
> > The hashtab code also contained a check that prevents the total alloc=
ation
> > size for the buckets from overflowing a 32-bit value, but since all t=
he
> > allocation code uses u64s, this does not really seem to be necessary,=
 so
> > drop it and keep only the strict overflow check of the n_buckets vari=
able.
> >
> > Fixes: daaf427c6ab3 ("bpf: fix arraymap NULL deref and missing overfl=
ow and zero size checks")
> > Signed-off-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
> > ---
> >  kernel/bpf/hashtab.c | 10 +++++-----
> >  1 file changed, 5 insertions(+), 5 deletions(-)
> >
> > diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
> > index 03a6a2500b6a..4caf8dab18b0 100644
> > --- a/kernel/bpf/hashtab.c
> > +++ b/kernel/bpf/hashtab.c
> > @@ -499,8 +499,6 @@ static struct bpf_map *htab_map_alloc(union bpf_a=
ttr *attr)
> >                                                           num_possibl=
e_cpus());
> >         }
> >
> > -       /* hash table size must be power of 2 */
> > -       htab->n_buckets =3D roundup_pow_of_two(htab->map.max_entries)=
;
> >
> >         htab->elem_size =3D sizeof(struct htab_elem) +
> >                           round_up(htab->map.key_size, 8);
> > @@ -510,11 +508,13 @@ static struct bpf_map *htab_map_alloc(union bpf=
_attr *attr)
> >                 htab->elem_size +=3D round_up(htab->map.value_size, 8=
);
> >
> >         err =3D -E2BIG;
> > -       /* prevent zero size kmalloc and check for u32 overflow */
> > -       if (htab->n_buckets =3D=3D 0 ||
> > -           htab->n_buckets > U32_MAX / sizeof(struct bucket))
> > +       /* prevent overflow in roundup below */
> > +       if (htab->map.max_entries > U32_MAX / 2 + 1)
> >                 goto free_htab;
> =

> No. We cannot artificially reduce max_entries that will break real user=
s.
> Hash table with 4B elements is not that uncommon.

Agree how about return E2BIG in these cases (32bit arch and overflow) and=
 =

let user figure it out. That makes more sense to me.

> =

> pw-bot: cr



