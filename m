Return-Path: <bpf+bounces-68153-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 00D33B53857
	for <lists+bpf@lfdr.de>; Thu, 11 Sep 2025 17:55:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0397AA7A2D
	for <lists+bpf@lfdr.de>; Thu, 11 Sep 2025 15:54:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6C5535208C;
	Thu, 11 Sep 2025 15:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="jk9cn2Lo"
X-Original-To: bpf@vger.kernel.org
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBE8A352FD1
	for <bpf@vger.kernel.org>; Thu, 11 Sep 2025 15:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757606047; cv=none; b=Jvls6EGmlNQOIRm6KDvqNnMrSdDyAYF1DUJyWVUDsf3zevLuIQN+7BRWKCvhC0NFqZgMo/r0N5BL30E1cyn9u0K7948bH2dj3lkLWWXvtASFxWzpMDMAYMU85uFVXJJO9Szaw9Rt6ECD7SJJfnVDiS7beNrjYgahVAtg6LJKF+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757606047; c=relaxed/simple;
	bh=VEBRenWFNA5Gge2DB4XVJ+EG9DM8eTh9AsWwYWpd6o4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NIC9BDSxnSTZtCYbO+J4ysYmTsgVLJ7c9zZNn0sraEY29FIrYR7NuRmTYBRdYoqCfCQQ++45BBZrIkb9Inm0NNRcCS/qICTgMFSKBotHAlUJYAzFWPo6YZZ1gPh5Zken68YpDczEG6V6GYOjeHaRLVIulAc4kzlYb2DrfdZIzzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=jk9cn2Lo; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Forwarded-Encrypted: i=1; AJvYcCUWVhBpysWf2i6ZlBOAEjdflG5bLI3RSe0felkQR8x6ffZKJWYLiptogPXdJihqRUikx+7wmOD/Pi2s@vger.kernel.org, AJvYcCWWnsD06aW+Ckluu2YPrX6e3uTdT+buHmsOn9NjfDoOkP7frCqbr2oL1d+ldvNa7x8BNIA=@vger.kernel.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1757606042;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uGts6uY/eXXZ4jOhJeaDgu9s/XIV0Y179Z31AUQ/R3I=;
	b=jk9cn2LoLVjLxO6RLNHaiNINj8YoOx8ZhjxkuHf91KOkmtn0OSZKUSX51HoKtS//NqPHTp
	S7Zy6dUVyujwPNUgfVrJZPeX3gzLWZ+G7ngKSHLFVdGK1zwTrjIxHEX34alPnOwQ0J9kiL
	tMgs7ECJ5TVZeR4YTE1MpKsU3VBypHI=
X-Gm-Message-State: AOJu0YwNE2mFEj7fjUld8q17bbjhBKS6//ZdKAHOOUbdBIP0EYjMVZsS
	04EtlcdS9JTw6lGVtONuLS1O+eRPRmQlXkJfj76IzqWxE+9QEK2Jh/AB2lWjClDfJ5T0BLwd1j6
	u1WxnqkH0629+IvXsMEL+68pu7oxf6eU=
X-Google-Smtp-Source: AGHT+IG8RU5WUTbItIq64fMUvoQl7NiAmvFL95+B7zkbK88FTqWjmJTl8UIuRNKQ8Vgk15ueCOMsjt6KmiQM6iVjSCY=
X-Received: by 2002:a17:906:dc8d:b0:b04:4de8:7c70 with SMTP id
 a640c23a62f3a-b04b140d189mr1986469666b.14.1757606035821; Thu, 11 Sep 2025
 08:53:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250910024447.64788-1-laoar.shao@gmail.com> <20250910024447.64788-5-laoar.shao@gmail.com>
In-Reply-To: <20250910024447.64788-5-laoar.shao@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Lance Yang <lance.yang@linux.dev>
Date: Thu, 11 Sep 2025 23:53:02 +0800
X-Gmail-Original-Message-ID: <CABzRoyZQMDodwBEJwNOoJNASJBP50xMhLdvo+kKENyDKWcRAfw@mail.gmail.com>
X-Gm-Features: Ac12FXxOxggsu2EceF8FpAM16vMzK0st5G8fBe8c1465wRynAe4bps1_2BSr7P8
Message-ID: <CABzRoyZQMDodwBEJwNOoJNASJBP50xMhLdvo+kKENyDKWcRAfw@mail.gmail.com>
Subject: Re: [PATCH v7 mm-new 04/10] mm: thp: enable THP allocation
 exclusively through khugepaged
To: Yafang Shao <laoar.shao@gmail.com>
Cc: akpm@linux-foundation.org, david@redhat.com, ziy@nvidia.com, 
	baolin.wang@linux.alibaba.com, lorenzo.stoakes@oracle.com, 
	Liam.Howlett@oracle.com, npache@redhat.com, ryan.roberts@arm.com, 
	dev.jain@arm.com, hannes@cmpxchg.org, usamaarif642@gmail.com, 
	gutierrez.asier@huawei-partners.com, willy@infradead.org, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, ameryhung@gmail.com, 
	rientjes@google.com, corbet@lwn.net, 21cnbao@gmail.com, 
	shakeel.butt@linux.dev, bpf@vger.kernel.org, linux-mm@kvack.org, 
	linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Migadu-Flow: FLOW_OUT

On Wed, Sep 10, 2025 at 11:00=E2=80=AFAM Yafang Shao <laoar.shao@gmail.com>=
 wrote:
>
> Currently, THP allocation cannot be restricted to khugepaged alone while
> being disabled in the page fault path. This limitation exists because
> disabling THP allocation during page faults also prevents the execution o=
f
> khugepaged_enter_vma() in that path.
>
> With the introduction of BPF, we can now implement THP policies based on
> different TVA types. This patch adjusts the logic to support this new
> capability.
>
> While we could also extend prtcl() to utilize this new policy, such a
> change would require a uAPI modification.
>
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> ---
>  mm/huge_memory.c |  1 -
>  mm/memory.c      | 13 ++++++++-----
>  2 files changed, 8 insertions(+), 6 deletions(-)
>
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 523153d21a41..1e9e7b32e2cf 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -1346,7 +1346,6 @@ vm_fault_t do_huge_pmd_anonymous_page(struct vm_fau=
lt *vmf)
>         ret =3D vmf_anon_prepare(vmf);
>         if (ret)
>                 return ret;
> -       khugepaged_enter_vma(vma, vma->vm_flags);
>
>         if (!(vmf->flags & FAULT_FLAG_WRITE) &&
>                         !mm_forbids_zeropage(vma->vm_mm) &&
> diff --git a/mm/memory.c b/mm/memory.c
> index d8819cac7930..d0609dc1e371 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -6289,11 +6289,14 @@ static vm_fault_t __handle_mm_fault(struct vm_are=
a_struct *vma,
>         if (pud_trans_unstable(vmf.pud))
>                 goto retry_pud;
>
> -       if (pmd_none(*vmf.pmd) &&
> -           thp_vma_allowable_order(vma, vm_flags, TVA_PAGEFAULT, PMD_ORD=
ER)) {
> -               ret =3D create_huge_pmd(&vmf);
> -               if (!(ret & VM_FAULT_FALLBACK))
> -                       return ret;
> +       if (pmd_none(*vmf.pmd)) {
> +               if (vma_is_anonymous(vma))
> +                       khugepaged_enter_vma(vma, vm_flags);

Hmm... I'm a bit confused about the different conditions for calling
khugepaged_enter_vma(). It's sometimes called for anonymous VMAs, other
times ONLY for non-anonymous, and sometimes unconditionally ;)

Anyway, this isn't a blocker, just something I noticed. I might try to
simplify that down the road.

Acked-by: Lance Yang <lance.yang@linux.dev>

Cheers,
Lance

> +               if (thp_vma_allowable_order(vma, vm_flags, TVA_PAGEFAULT,=
 PMD_ORDER)) {
> +                       ret =3D create_huge_pmd(&vmf);
> +                       if (!(ret & VM_FAULT_FALLBACK))
> +                               return ret;
> +               }
>         } else {
>                 vmf.orig_pmd =3D pmdp_get_lockless(vmf.pmd);
>
> --
> 2.47.3
>
>

