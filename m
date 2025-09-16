Return-Path: <bpf+bounces-68520-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D7FFFB59B1E
	for <lists+bpf@lfdr.de>; Tue, 16 Sep 2025 16:59:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E2F518834DA
	for <lists+bpf@lfdr.de>; Tue, 16 Sep 2025 14:59:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AACF3340D90;
	Tue, 16 Sep 2025 14:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ci9CI1Mg"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E0C723643E
	for <bpf@vger.kernel.org>; Tue, 16 Sep 2025 14:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758034752; cv=none; b=N69Weu854O/jUhET+Md+04AMAjZmFDiD3MpYHY+KlulcN2U2/r50M6Fuo0K572nCpC5+TXNletPcgV2Goaon4ZAHYscGHeMsTwaX8+jfRetZnJ/Muxjt4x2veMrc7dXiI967qj5Fhm5DSv6Ex0ul3ECu2uu8Is2v8pKoYWLZ/zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758034752; c=relaxed/simple;
	bh=PR0zmaOZJBbt+XAHa8hctTIc/eGT/MN9AEEioSCGn0k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Bke9oq5n1WGq+yTGE+GsQO2GP5bybCaE7ZlYvFqi31w9hkm4Iu+iR66xsaQe7T99Cv+cY58AYaJrJgZjhQpS+JSIECu/3SWNV+RevP+kZy+vyCDairK7L3jRBmbfC/uyRmaO0oAeVxWQKksOxlJh45MkMzi1ox1B7yKLzBZhB0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ci9CI1Mg; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-46070cf4dc5so2621575e9.1
        for <bpf@vger.kernel.org>; Tue, 16 Sep 2025 07:59:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758034748; x=1758639548; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZxAAsfbNQ4UmN7WPYIVbS5YnVkLnDKyxCgQcXMA76KI=;
        b=ci9CI1Mg80ytIg8nUbIt/je2cXx6P1N0Ie9rGBQbKsbzXXhdYQFEduSmd3+KXMWZsK
         AaFeFsDFreccY54FR7oGOPa3Ii5DzjDkFWEpoksnC9xIbj3FrtKs/GKEd4lrRYCfmJfp
         mEYguPbtmziBNIf6W8reIpr45yrg5JRnT1tEngjtPjL0nWlKRw7CTr49WOmJj9ewFgPF
         YTQOwJxKwDxo54JIsPZirB9bSUQ0XFywfdzuoFX1+/pO9W5fzp12HalIOzkyrSL5PMXi
         SagpmqJAknYj3rDZd0+N3aJyqG5ROc5uPvKX/lWBobw2pOTSX2Z0nkEOrxYsz9Nss8Gr
         2/cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758034748; x=1758639548;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZxAAsfbNQ4UmN7WPYIVbS5YnVkLnDKyxCgQcXMA76KI=;
        b=KVz39mJV/QqNsedCQN6xm3T0hHlZZTEBwCcaWtLMn4XyRb/Tr4RUypxpDjGgT1MRDA
         FJzcorslJ7fFJOmoVNFmwlLCmtpTTx5oE0Y1syvT7dD3bQTFnCIrC1zvHZut5Y4/hXFL
         Z1nJhqsXb3PzrK1lcus2H9pD7wdTE+Ui15FrFNOtd4Ddrc+MDKgi2nTupW5rfRv78sNu
         wLSoYELwDDdmCnr02o8yVjujclSoHu0GEgtPsYB6ORhBQiKrR3AaUmNlVTAqcuoXmgrc
         wYjRRShBaog9Um98t+UFxmt5sGq2WU4sxnbEj+u6iBATUYYjIZIWQ7nATF9bzgA+AMmY
         zc1A==
X-Forwarded-Encrypted: i=1; AJvYcCW11YblExCM+QfQykTZwx24Y5KNqfmB8l1a+t3XtWbjneo9G/UScG+mATRXErhbOedbnC0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpzVTPtCQ6ncZI2ovpOEihhDZcMaErxCvK8hjDtEFEIHlkuenx
	FBn8RmSBlP4JEqGKwvFlOPDqu46bMIpd6WgLj2UctGKYVp+adjD6S9DVdJ6xetV/ZQ7eofZNHv5
	G6uCTALomH36BULELKBkWQYOJ4tzus2I=
X-Gm-Gg: ASbGncveexeAR4htzm+U2susHYq2Uar2xFRtlzQg0IYK39qZK0ALoZ9GLlX0qwNa0XO
	+qijLZvuyC/QCt1wXtC1CUGghqO9/Z5FJKlH2nF68gcuKornEW9OmWy7iKKE4QGYRKjR8NJ8Aox
	eF3yVDzC3360rbMO5waIPtHAK2Balv/qGnc33oNjjY+Q+sPfvvkT7T8Y/E+2Uq1z+qrCBLib/Gs
	hzhyemUuw0l/0WT56ydWVMsU4hUfSHt
X-Google-Smtp-Source: AGHT+IHPDJzbK4gi0+IOKq/h082l6PYRTjMh+LBhmtZ3jehnQsgrNIrZIXGE2fBs1X31GKHcGB6UlpVdv6cgyugWjCM=
X-Received: by 2002:a05:600c:ad7:b0:45d:d2cd:de36 with SMTP id
 5b1f17b1804b1-45f211d58bemr121275885e9.12.1758034747579; Tue, 16 Sep 2025
 07:59:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250828013415.2298-1-hengqi.chen@gmail.com> <mb61pjz2nmyu4.fsf@kernel.org>
 <CAPhsuW5-Q7F9-6hUWJ9XhS37fZrJjk7YNmbHriQM_rDW07X5KA@mail.gmail.com> <mb61p4it2a7cu.fsf@kernel.org>
In-Reply-To: <mb61p4it2a7cu.fsf@kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 16 Sep 2025 07:58:55 -0700
X-Gm-Features: AS18NWBygMCz5oy9aosrsO-kdEiLZSHYQA2BAfQbh8CROertx3YlCrXQT55BsrM
Message-ID: <CAADnVQLjCT46WmdOpNUDMA-QxmFQJj185Pi2jdNnzYUcEuhX1g@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf, arm64: Call bpf_jit_binary_pack_finalize()
 in bpf_jit_free()
To: Puranjay Mohan <puranjay@kernel.org>
Cc: Song Liu <song@kernel.org>, Hengqi Chen <hengqi.chen@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Xu Kuohai <xukuohai@huaweicloud.com>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 16, 2025 at 5:51=E2=80=AFAM Puranjay Mohan <puranjay@kernel.org=
> wrote:
>
> Song Liu <song@kernel.org> writes:
>
> > Sorry for the late reply.
> >
> > On Thu, Aug 28, 2025 at 5:10=E2=80=AFAM Puranjay Mohan <puranjay@kernel=
.org> wrote:
> > [...]
> >> Thanks for this patch!
> >>
> >> So, this is fixing a bug because bpf_jit_binary_pack_finalize() will d=
o
> >> kvfree(rw_header); but without it currently, jit_data->header is never
> >> freed.
> >>
> >> But I think we shouldn't use bpf_jit_binary_pack_finalize() here as it
> >> copies the whole rw_header to ro_header using  bpf_arch_text_copy()
> >> which is an expensive operation (patch_map/unmap in loop +
> >> flush_icache_range()) and not needed here because we are going
> >> to free ro_header anyway.
> >>
> >> We only need to copy jit_data->header->size to jit_data->ro_header->si=
ze
> >> because this size is later used by bpf_jit_binary_pack_free(), see
> >> comment above bpf_jit_binary_pack_free().
> >>
> >> How I suggest we should fix the code and the comment:
> >>
> >> -- >8 --
> >>
> >> diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_co=
mp.c
> >> index 5083886d6e66b..cb4c50eeada13 100644
> >> --- a/arch/arm64/net/bpf_jit_comp.c
> >> +++ b/arch/arm64/net/bpf_jit_comp.c
> >> @@ -3093,12 +3093,14 @@ void bpf_jit_free(struct bpf_prog *prog)
> >>
> >>                 /*
> >>                  * If we fail the final pass of JIT (from jit_subprogs=
),
> >> -                * the program may not be finalized yet. Call finalize=
 here
> >> -                * before freeing it.
> >> +                * the program may not be finalized yet. Copy the head=
er size
> >> +                * from rw_header to ro_header before freeing the ro_h=
eader
> >> +                * with bpf_jit_binary_pack_free().
> >>                  */
> >>                 if (jit_data) {
> >>                         bpf_arch_text_copy(&jit_data->ro_header->size,=
 &jit_data->header->size,
> >>                                            sizeof(jit_data->header->si=
ze));
> >> +                       kvfree(jit_data->header);
> >>                         kfree(jit_data);
> >>                 }
> >>                 prog->bpf_func -=3D cfi_get_offset();
> >>
> >> -- 8< --
> >>
> >> Song,
> >>
> >> Do you think this optimization is worth it or should we just call
> >> bpf_jit_binary_pack_finalize() here like this patch is doing?
> >
> > This is a good optimization. However, given this is not a hot path,
> > I don't have a strong preference either way. At the moment, most
> > other architectures use bpf_jit_binary_pack_finalize(), so it is good
> > to just use bpf_jit_binary_pack_finalize and keep the logic
> > consistent.
>
> So, in that case we can merge this patch.
>
> Acked-by: Puranjay Mohan <puranjay@kernel.org>

It's out of patchwork.
Hengqi,
pls repost.

