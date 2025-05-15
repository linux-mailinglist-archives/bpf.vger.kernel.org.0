Return-Path: <bpf+bounces-58327-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB5C5AB8BA5
	for <lists+bpf@lfdr.de>; Thu, 15 May 2025 17:56:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EB0A07B705D
	for <lists+bpf@lfdr.de>; Thu, 15 May 2025 15:54:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C21321ADC6;
	Thu, 15 May 2025 15:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WQeaK4v2"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F31C2063FD;
	Thu, 15 May 2025 15:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747324561; cv=none; b=Vc0Vq81LPtA+U/XMBY2lSFCdZAq1qBvPGNv0e3nQh55xYuy0R9kbgOWzOc4zPS1jMSKWqj3IN8PVAfbf2wthkWivhQnLM/gHnGocGYAsBjE7oCBRufFW9G/aycvgzVXPwtTrcVH/Jkda7Lx9EYHqFiyQ0NX/VDR+eW1u8jbjBT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747324561; c=relaxed/simple;
	bh=O55uhgQpQzLsyENNHRRz6x1XHa1JD1E17OSbBXJLGic=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f9ksQn0dsW5UMoUyCNdeJ1qn82HNjG2i+ALyigNKe6dOK03LP4n9xK/9l6feilPPhB06RhBP3j7BazWGb0Co2Wbplq6zK3IdLuRYZWX7vXrT+JCD8aCfNL2j4Dy3HrlC7OzXVVb0GeaK8BZq1MrXffBu14buMH6ikGeIPTb6Hqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WQeaK4v2; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-742596d8b95so1577506b3a.1;
        Thu, 15 May 2025 08:56:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747324559; x=1747929359; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vwSFGwblpcsKCcrB2EaJfjOE897XBCx90z+dK4NApfc=;
        b=WQeaK4v2r5dcEJQWmlS3kftGDNLpV6exTwTmY8L9iErYBh3i9NOHhYzzZurFlV14jt
         rAMNep5x4aNJXjp4lIVLJRQAuW5Bnbd5L6+4YAytvKI4xn1TpuVDsbJO+LUj4mAyAhqw
         FkRm2iVVjr0NABmbXIwaDIAqh2JB7rmIbSUZ3h7KbDbN0BJpQGeibOjRnkNPy5aqMhjI
         P4Ro6Rpt4F98EttNxFSOokE7CLc3rmpdiYyWl8JcZnBOudPjZGvJmvKXNL8XxHBws+tT
         BBAhBgxbPcWewp89rh8hECo7tFh/MugfED8AEd853MV0tGJ7SATwfKoQ7dhklApRxf4U
         6E3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747324559; x=1747929359;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vwSFGwblpcsKCcrB2EaJfjOE897XBCx90z+dK4NApfc=;
        b=Nm2YNABiWIp0PyClytBzGCF+hSI8wHvoKsEh9UvLrTMZkXHXv2dLlb2xNgiT+/ksi0
         LFUuUp00yElPZOT1fS68DDD3FDb2F7adlwjxIDJGgcKFshGL2ix+6Yk0Nmk/zePmRing
         YN3W4nnyPd8Ufn+MKEvGBQPZ+6NHjfvf1WmjFyXWOCTQdoReDYjB16JLOPQIRs63WrDl
         XauLraqFJjaqUCOYdOhJScRcrEKy5M6oMs1SwyuuXKSReyInsnaZPvFBydMGhAzv3nlN
         aDvIsm5B70Rb9xDk7ZbfGTvi1qiuuCyHCykTJ8gOZb2SKxVazDj5f2CPT1OVTbojsx7M
         pVOw==
X-Forwarded-Encrypted: i=1; AJvYcCVQZrxop4b1ZufdW1sg6vtX3kL9VTQHuneJ3J8q24c8EytkrNRCaMndoFUs467Fty3QVOxmfAr0/2MZ0oWw@vger.kernel.org, AJvYcCWUbED+IVKvRIJnGB2NPkzrolbJNDNUVhHOT66igJT2Pj0O1KUlWDO1PSlKPb8HG/FQSds=@vger.kernel.org, AJvYcCXSLqE0bnPghapQ0xRfxfRKmQVHq/sul2mcmJE5xqt1Y01M2PNLgqkXDWvfIIbAhE61SuBuDG+oblvm62391jnJ@vger.kernel.org
X-Gm-Message-State: AOJu0YyA8GrPdLAVi/NiD+USTt6hJpWffpZRsNAB2PrfXU5fNcH0E7z/
	NHDb/7TqsbE1dtHU1lNo2vX/gHVFdtLV1uIMR80uDB824T5oEpGbVoYQzZI8WxmjeOFqG/0svRR
	9gSTIMqhWDJ0APYgmJcmQnCoB/wc=
X-Gm-Gg: ASbGncvUohw6ilU6C9GK/9Lg7lslQ/8+UNhpmfKq+hFXk80A/YffQYw1Tui1Z214V4j
	4bw0KmKRcxA4NH3ntahXg+w7pT9Dv/+kGKDRm71Ag45wpp+abu7GYZXPK7qsemHEXfJeUf8TYdM
	NjBJPx6yGSMa4LOYWkAXg7XcGj1nm1KSd3XOkT6QgZ6J1Y2ZZh
X-Google-Smtp-Source: AGHT+IGPRrFhMchsBX4IRYFKA90fZIR29juTVsQz3ECzVcxmLv3gFJTu0IYlEsPOUVwab+bsFo7Aben+HpCoDAX2kxE=
X-Received: by 2002:a05:6a00:98b:b0:73e:23bd:fb9c with SMTP id
 d2e1a72fcca58-742893623a3mr11801798b3a.23.1747324559490; Thu, 15 May 2025
 08:55:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250515-bpf-verifier-slowdown-vwo2meju4cgp2su5ckj@6gi6ssxbnfqg>
 <202505150845.0F9E154@keescook> <202505150850.6F3E261D67@keescook>
In-Reply-To: <202505150850.6F3E261D67@keescook>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 15 May 2025 08:55:47 -0700
X-Gm-Features: AX0GCFvq9CisTH8nZcYpH-mCimU9toiO7n-whCQ1cjhCwfk1tPJQRG6tXDh3K98
Message-ID: <CAEf4BzZbPMKwu49UDizqT_3ZuDPsNXvTa+Tp6pae0P_YkUT7JQ@mail.gmail.com>
Subject: Re: [REGRESSION] bpf verifier slowdown due to vrealloc() change since 6.15-rc6
To: Kees Cook <kees@kernel.org>
Cc: Shung-Hsi Yu <shung-hsi.yu@suse.com>, bpf@vger.kernel.org, linux-mm@kvack.org, 
	Andrii Nakryiko <andrii@kernel.org>, Ihor Solodrai <ihor.solodrai@linux.dev>, 
	Andrew Morton <akpm@linux-foundation.org>, Michal Hocko <mhocko@suse.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Uladzislau Rezki <urezki@gmail.com>, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org, regressions@lists.linux.dev, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, 
	Eduard Zingerman <eddyz87@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 15, 2025 at 8:53=E2=80=AFAM Kees Cook <kees@kernel.org> wrote:
>
> On Thu, May 15, 2025 at 08:47:47AM -0700, Kees Cook wrote:
> > On Thu, May 15, 2025 at 09:12:25PM +0800, Shung-Hsi Yu wrote:
> > > Bisect was done by Pawan and got to commit a0309faf1cb0 "mm: vmalloc:
> > > support more granular vrealloc() sizing"[2]. To further zoom in the
> >
> > Can you try this patch? It's a clear bug fix, but if it doesn't improve
> > things, I have another idea to rearrange the memset.
>
> Here's the patch (on top of the prior one) that relocates the memset:
>
>
> From 0bc71b78603500705aca77f82de8ed1fc595c4c3 Mon Sep 17 00:00:00 2001
> From: Kees Cook <kees@kernel.org>
> Date: Thu, 15 May 2025 08:48:24 -0700
> Subject: [PATCH] mm: vmalloc: Only zero-init on vrealloc shrink
>
> The common case is to grow reallocations, and since init_on_alloc will
> have already zeroed the whole allocation, we only need to zero when
> shrinking the allocation.
>
> Fixes: a0309faf1cb0 ("mm: vmalloc: support more granular vrealloc() sizin=
g")
> Signed-off-by: Kees Cook <kees@kernel.org>
> ---
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Uladzislau Rezki <urezki@gmail.com>
> Cc: <linux-mm@kvack.org>
> ---
>  mm/vmalloc.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
>
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index 74bd00fd734d..83bedb1559ac 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -4093,8 +4093,8 @@ void *vrealloc_noprof(const void *p, size_t size, g=
fp_t flags)
>          * would be a good heuristic for when to shrink the vm_area?
>          */
>         if (size <=3D old_size) {
> -               /* Zero out "freed" memory. */
> -               if (want_init_on_free())
> +               /* Zero out "freed" memory, potentially for future reallo=
c. */
> +               if (want_init_on_free() || want_init_on_alloc(flags))
>                         memset((void *)p + size, 0, old_size - size);
>                 vm->requested_size =3D size;
>                 kasan_poison_vmalloc(p + size, old_size - size);
> @@ -4107,9 +4107,11 @@ void *vrealloc_noprof(const void *p, size_t size, =
gfp_t flags)
>         if (size <=3D alloced_size) {
>                 kasan_unpoison_vmalloc(p + old_size, size - old_size,
>                                        KASAN_VMALLOC_PROT_NORMAL);
> -               /* Zero out "alloced" memory. */
> -               if (want_init_on_alloc(flags))
> -                       memset((void *)p + old_size, 0, size - old_size);
> +               /*
> +                * No need to zero memory here, as unused memory will hav=
e
> +                * already been zeroed at initial allocation time or duri=
ng
> +                * realloc shrink time.
> +                */
>                 vm->requested_size =3D size;

This vm->requested_size change you are adding should also fix the
kasan issue reported by syzbot ([0]).

  [0] https://lore.kernel.org/bpf/68213ddf.050a0220.f2294.0045.GAE@google.c=
om/

>                 return (void *)p;
>         }
> --
> 2.34.1
>
>
>
> --
> Kees Cook

