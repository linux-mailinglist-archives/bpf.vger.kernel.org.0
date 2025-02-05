Return-Path: <bpf+bounces-50497-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E8E7A28729
	for <lists+bpf@lfdr.de>; Wed,  5 Feb 2025 10:56:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E00B1882B4B
	for <lists+bpf@lfdr.de>; Wed,  5 Feb 2025 09:57:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5583E22A4FE;
	Wed,  5 Feb 2025 09:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N/DN2p6D"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AD881D7985
	for <bpf@vger.kernel.org>; Wed,  5 Feb 2025 09:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738749412; cv=none; b=qNFSzZoWnW0OCRyg3EugsRKtXrUmdyBP2zDXdu+fff2mqEz7SXCydNQLrE+QxyXL4eREU3GKthLhltcb5rIZADpoIMFzKHKq0BQuKzXJhpcy3355fH+fx0sB2PkShv85Z5G5HoeZd7IKHi3vfR1vM9pPvvrT2MbeIyxnp2ciMlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738749412; c=relaxed/simple;
	bh=fHm4aY4H9Wf4L9RYU2LfLKN5f8hnmYNFMJNBfg7Mbiw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uXdjsBBtm4GkS+6IhKNWPp2CGyfunhN9jPKbejCb4M27rIWXpgtoUHb8rpQSB6dLsHMWl3LS0eOsjX5CkD6hiXf8wWUgzZ+dOExqSfcAgGLRcfvwTfDx/ucULmrlYtCe600UoxGpdAHaINvkYC7doiotI84VqmkJcZ8d4HjbtWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N/DN2p6D; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-38dae70f5d9so860278f8f.1
        for <bpf@vger.kernel.org>; Wed, 05 Feb 2025 01:56:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738749409; x=1739354209; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jfp7YVWxhvI4ElaP8pbKiC1S3/RfhpnvTUJiU0DPeuc=;
        b=N/DN2p6DjHqVh06iOUhHtq5J4XKuptYZSV6iHLDKDidUtCT9ZsIAJr2HF8VGjI68q7
         3vJIPEUgus1AN/fGKBdQPHNVEjcm4ox+/OOzagYi1gTYvIelNgN93mFahqJa3EKAJ47e
         xiQRnVOZLJ2Bl8rgZClRiU2fBsF/gLLxBiyvhIvwsIlyLJ5YrEYvnu9HSBVsSQsDv/Kd
         OXoZ0TsHU4Y1R+fSRHbpjg16uqW+W49W757OnlP/lqdM8AdsiPCUyOU89ddVjFt95tEb
         M4kBdkt45l54E6dFFEIPetOfLv7KnPsM9kr/jbsO+znHkdQKfn07U2swEtHm2TLKayYu
         9w6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738749409; x=1739354209;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jfp7YVWxhvI4ElaP8pbKiC1S3/RfhpnvTUJiU0DPeuc=;
        b=kGY/zBSL2ARpUSs294NazRclxIhARfDn79G/YDYg1BZe3kmKOJHC3xD4iJIIJzQaUD
         4N0Micd52D+qRAZwHux8uURZsMtW0TzFXqVdZ0pE8y0ASluPfImAIB2uvkgCSvMfycqH
         C0vIuEWUSX2zLkVyYFpe6SLQYeGCWDFElGScuUJzSnqJ7s8WarXbFGfyLDXoXHx2sP6g
         +dFl61IeiwrSF6al8YXrrghDirCtwjGn/x8RUPKIyxajja4GLODkT5XCbMdUoQlp+iSY
         dx5i+D/n7WKbkk86AN92M8Bjk5q1oN2ikXG04hb1z9UTjDwnpmQpS3w+o5w2LYGYY9Mr
         q95A==
X-Forwarded-Encrypted: i=1; AJvYcCVPnuzkxrQhF4t/Qp0ZE8e45GQ2KbTkTlxrI2BX//nGhKXfmuEvUh7DLzF9K+fDw4s+eU0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yws0cpeOqziDYF51hoRnOm1AmxRd6Q2KKx6d0Hvj6XGbhPaho7E
	g7dUbS2uGm8PAwZSaocl1enuDcVKG2lIqDj8G6eYCHaYFXf1aAjGneklidFMPxGTM41H72tRI5T
	uqVZFx4I52GtQdBQKyycWslA1nSY=
X-Gm-Gg: ASbGncsHAIbtaXkHfeGHMrHKvOIIL4jeMQzHTTZYBprAuSV5wX8R313PkYhR1BzTn+Q
	HLkPj7yBCmipv6g9PfMGuoXJpa9pUgReSf5hvJ2ugJugJuCGlX6u+mEWu2942rcmLlkKra79q7v
	FHZ7S9lpn6S+A+
X-Google-Smtp-Source: AGHT+IFJUMJ9qW84KLKw9pKgqwGSCRqwMdEwxJ08P5ajTs5dBuYIpaSQB0UO2w6V5i++gmDCWqoo5c4s0MoqdRheueU=
X-Received: by 2002:a05:6000:156b:b0:386:3dad:8147 with SMTP id
 ffacd0b85a97d-38db48aca35mr1357294f8f.32.1738749409108; Wed, 05 Feb 2025
 01:56:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Z6JXtA1M5jAZx8xD@debian.debian> <d8893a20-4211-2fd6-e9d1-b65e81367950@huaweicloud.com>
In-Reply-To: <d8893a20-4211-2fd6-e9d1-b65e81367950@huaweicloud.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 5 Feb 2025 09:56:38 +0000
X-Gm-Features: AWEUYZljcN2jH7bvELLULJSbmeTY1QwIrBFdybUqoZS9WmCFhaUncyXvl59sbFY
Message-ID: <CAADnVQLNSUOz7kSwMr0dfgT1gk02S1wNgJOhk-5h_d01AM2RbA@mail.gmail.com>
Subject: Re: handling EINTR from bpf_map_lookup_batch
To: Hou Tao <houtao@huaweicloud.com>
Cc: Yan Zhai <yan@cloudflare.com>, bpf <bpf@vger.kernel.org>, 
	kernel-team <kernel-team@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 5, 2025 at 2:19=E2=80=AFAM Hou Tao <houtao@huaweicloud.com> wro=
te:
>
> Hi,
>
> On 2/5/2025 2:08 AM, Yan Zhai wrote:
> > I am getting EINTR when trying to use bpf_map_lookup_batch on an
> > array_of_maps. The error happens when there is a "hole" in the array.
> > For example, say the outer map has max entries of 256, each inner map
> > is used for a transport protocol, and I only populated key 6 and
> > 17 for TCP and UDP. Then when I do batch lookup, I always get EINTR.
> > This so far seems to only happen with array of maps. Does it make
> > sense to allow skipping to the next key for this map type? Something
> > like:
> >
> > diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> > index c420edbfb7c8..83915a8059ef 100644
> > --- a/kernel/bpf/syscall.c
> > +++ b/kernel/bpf/syscall.c
> > @@ -2027,6 +2027,8 @@ int generic_map_lookup_batch(struct bpf_map *map,
> >                                          attr->batch.elem_flags);
> >
> >                 if (err =3D=3D -ENOENT) {
> > +                       if (IS_FD_ARRAY(map)
> > +                               goto next_key;
>
> It seems only BPF_MAP_TYPE_ARRAY_OF_MAPS supports batched operation, so
> map->map_type =3D=3D BPF_MAP_TYPE_ARRAY_OF_MAPS will be enough. It is als=
o
> better to reset err as 0, otherwise generic_map_lookup_batch may return
> -ENOENT.
> >                         if (retry) {
> >                                 retry--;
> >                                 continue;
> > @@ -2048,6 +2050,7 @@ int generic_map_lookup_batch(struct bpf_map *map,
> >                         goto free_buf;
> >                 }
> >
> > +next_key:
> >                 if (!prev_key)
> >                         prev_key =3D buf_prevkey;
> >
>
> Make sense.  Please add a selftest for it. Another way is to return id 0
> for these non-existent values in the fd array, but it may break existed
> prog. Just skipping the empty array slot is better.

Let's not invent new magic return values.

But stepping back... why do we have this EINTR case at all?
Can we always goto next_key for all map types?
The command returns and a set of (key, value) pairs.
It's always better to skip then get stuck in EINTR,
since EINTR implies that the user space should retry and it
might be successful next time.
While here it's not the case.
I don't see any selftests for EINTR, so I suspect it was added
as escape path in case retry count exceeds 3 and author assumed
that it should never happen in practice, so EINTR was expected
to be 'never happens'. Clearly that's not the case.

