Return-Path: <bpf+bounces-66936-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B86AB3B241
	for <lists+bpf@lfdr.de>; Fri, 29 Aug 2025 06:56:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56DF53BF4FD
	for <lists+bpf@lfdr.de>; Fri, 29 Aug 2025 04:56:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 248BE201033;
	Fri, 29 Aug 2025 04:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zz/Jatyo"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CB491F8BA6;
	Fri, 29 Aug 2025 04:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756443405; cv=none; b=IOwQZC1qA3WkPXaUxT9l36KiS9L/ntGyzKmbiGb1GtAc/G2OwixQTG9XKVS8q90msnO773TMtvem2lYEY0Sjjfy9v3ueYzURbsFMeAEReLBJvuF+Az+5CaYrb08EfzzCHZ0Sp5eDyD/yR+ALUElYIQ/qgF3HYyJmlm0n8Kixxgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756443405; c=relaxed/simple;
	bh=rlMwh0ZusaeNnDDZUrztnPVbqGAayQPFWOV5sNNVUYs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BCTG9n6j6QtYQsbuAqqPqv3rroMStBnBdwD5PXOatSmZyn7KxKdpsQxphAiHRTCtAoZkuJaaDYo9W9FcV3HyLgBu38e3r9gny9ICVMPOMpMGASpm7DJ6vfZO8okxu6LojZNYxfBOd/ZQClnGt2dzKS3z6kk9Iuw/hQn5MoxN4oI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zz/Jatyo; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7f901afc2fbso155325085a.0;
        Thu, 28 Aug 2025 21:56:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756443403; x=1757048203; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KNryYBJJVfQELDTrjz1KnvzL2xecRXp3PVwLzaUrbpo=;
        b=Zz/Jatyo2bx9EPtABaq3AD/yz4dbaOHFf2aqiA5MGgo6XUZPRdwnP9TGa5wJ1904/k
         TU4t/xKyISmrj5l4yNcgLvTz1FfE7L95r/weKY4RAbIGc/dbbOM7ZpqJGAzhHfQyPKYi
         GogCu+9insPvJ4xkPkZ7TLK274bH34x5vlBVS0nhesRQEmNcf07O4zm2arfxkDEy5QRr
         YNmNcUeB0zmPavve3rjUVFGibEfy8jbzeQGG0eCuED0Rp4XZaa0KzQQDGoZ3b8J0aUJL
         30nyjnZVHE5HL2nSf7IUz7htM4iBV2CWgoh+xMpjv26eHJMQeuDFZFnlbjhdnhINgTAy
         P9Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756443403; x=1757048203;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KNryYBJJVfQELDTrjz1KnvzL2xecRXp3PVwLzaUrbpo=;
        b=qGxJIBwuiiRCHJFW3GEXrpmtoEHjvEEh2hBVoTf34nlw1KVqgp9kVz2pCE3oenZ8fZ
         lDHZdQOP3M9SA7JzJeLYidw065zWqYKM84ANb83D6sa50i+54lsg0wyxOQFto92Cw0NR
         5vcsuqMFxrtvi54xGchMs/50Q6c0Hbs0y0kGTuk62rUAaFOiHAMUCFygG0+ZQg6xdkdI
         QtvXE+slGiCUkfY64UzU2yqba65o/mo0P/F/5H2KEwGVlPujwDJAp56bVszVi0SjF6yB
         Qdci5x+By8Yo6dZb5aZKi3NGEbU/w/UnSZJoqmAkofvjESHPvEnUcTGgoY6lhWK2Wz76
         pD4Q==
X-Forwarded-Encrypted: i=1; AJvYcCUQIpqDRV9S06Oj6gtbanPbUx9mIqaQ2vADpZr60vwR80yBB9X7QV6PrQCQ3mhAYO67Ayldz4VT6EkV@vger.kernel.org, AJvYcCWIGetRqlmNsfpjUh0NJxCed3CCPefViI0Di8ch4StRzpj3M0j5WBPohxWjiWt5+YpHqeI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXgMm7b1dDwR646mjzpzS8ymEOO5ZWllMapLeyEFEZO5jhwISw
	0xLURfFbSzzg2S6uEKzL1+QVkGhP6LEaPSle11uyeigwejyVCWUXOyO9sQRzpe3T6RoRpOW/vPI
	pNwv/83D9J+fqOMcXJumZwcn3AC0rfd4=
X-Gm-Gg: ASbGncsg2V2WEtQ08wWM/qLm2kNmyg/wQcRat0YKTZwd3vo+kKnphK4RZsxij+tdTc+
	WV6SWJIlCub3lRlow24DY0Y17mGmYLmk6vBrBThNyPEGmNKhTisqNM33Ohl50JPl7pObcy8Cta/
	WldvdKFCUDI+Krf3e10YVmR6CKKQ4AqaD2qTFDpDOs/OfqdQezyCjj81HWfpLrDdO50JSFx/moY
	5Q+//X/Mda8QHy60w==
X-Google-Smtp-Source: AGHT+IER+nM+4LqnTVVsRA0C/YRbwEY2iIeChjcQqyAqsqSfTBP1dTQx0YTtFem6RkzVwlWqhUcSmkomW7o4OpJu2UM=
X-Received: by 2002:a05:620a:2983:b0:7fc:8834:a8a6 with SMTP id
 af79cd13be357-7fc8834ab4bmr147951085a.16.1756443402922; Thu, 28 Aug 2025
 21:56:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250826071948.2618-1-laoar.shao@gmail.com> <20250826071948.2618-2-laoar.shao@gmail.com>
In-Reply-To: <20250826071948.2618-2-laoar.shao@gmail.com>
From: Barry Song <21cnbao@gmail.com>
Date: Fri, 29 Aug 2025 12:56:31 +0800
X-Gm-Features: Ac12FXygzLGLDRPOyTzO4Xch95XvlKZwEGk1nOgFbtgG9eYsTL90i6vr2LXC7WA
Message-ID: <CAGsJ_4wa0gC7FQmUP9HQxbacheKFRCqMbnfXwugeyOzhOS4McA@mail.gmail.com>
Subject: Re: [PATCH v6 mm-new 01/10] mm: thp: add support for BPF based THP
 order selection
To: Yafang Shao <laoar.shao@gmail.com>
Cc: akpm@linux-foundation.org, david@redhat.com, ziy@nvidia.com, 
	baolin.wang@linux.alibaba.com, lorenzo.stoakes@oracle.com, 
	Liam.Howlett@oracle.com, npache@redhat.com, ryan.roberts@arm.com, 
	dev.jain@arm.com, hannes@cmpxchg.org, usamaarif642@gmail.com, 
	gutierrez.asier@huawei-partners.com, willy@infradead.org, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, ameryhung@gmail.com, 
	rientjes@google.com, corbet@lwn.net, bpf@vger.kernel.org, linux-mm@kvack.org, 
	linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 26, 2025 at 3:43=E2=80=AFPM Yafang Shao <laoar.shao@gmail.com> =
wrote:
[...]

> @@ -4510,13 +4510,18 @@ static struct folio *alloc_swap_folio(struct vm_f=
ault *vmf)
>         if (!zswap_never_enabled())
>                 goto fallback;
>
> +       suggested_orders =3D get_suggested_order(vma->vm_mm, vma, vma->vm=
_flags,
> +                                              TVA_PAGEFAULT,
> +                                              BIT(PMD_ORDER) - 1);

Can we separate this case from the normal anonymous page faults below?
We=E2=80=99ve observed that swapping in large folios can lead to more
swap thrashing for some workloads- e.g. kernel build. Consequently,
some workloads
might prefer swapping in smaller folios than those allocated by
alloc_anon_folio().

> +       if (!suggested_orders)
> +               goto fallback;
>         entry =3D pte_to_swp_entry(vmf->orig_pte);
>         /*
>          * Get a list of all the (large) orders below PMD_ORDER that are =
enabled
>          * and suitable for swapping THP.
>          */
>         orders =3D thp_vma_allowable_orders(vma, vma->vm_flags, TVA_PAGEF=
AULT,
> -                                         BIT(PMD_ORDER) - 1);
> +                                         suggested_orders);
>         orders =3D thp_vma_suitable_orders(vma, vmf->address, orders);
>         orders =3D thp_swap_suitable_orders(swp_offset(entry),
>                                           vmf->address, orders);
> @@ -5044,12 +5049,12 @@ static struct folio *alloc_anon_folio(struct vm_f=
ault *vmf)
>  {
>         struct vm_area_struct *vma =3D vmf->vma;
>  #ifdef CONFIG_TRANSPARENT_HUGEPAGE
> +       int order, suggested_orders;
>         unsigned long orders;
>         struct folio *folio;
>         unsigned long addr;
>         pte_t *pte;
>         gfp_t gfp;
> -       int order;
>
>         /*
>          * If uffd is active for the vma we need per-page fault fidelity =
to
> @@ -5058,13 +5063,18 @@ static struct folio *alloc_anon_folio(struct vm_f=
ault *vmf)
>         if (unlikely(userfaultfd_armed(vma)))
>                 goto fallback;
>
> +       suggested_orders =3D get_suggested_order(vma->vm_mm, vma, vma->vm=
_flags,
> +                                              TVA_PAGEFAULT,
> +                                              BIT(PMD_ORDER) - 1);
> +       if (!suggested_orders)
> +               goto fallback;

Thanks
Barry

