Return-Path: <bpf+bounces-63815-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC867B0B33F
	for <lists+bpf@lfdr.de>; Sun, 20 Jul 2025 05:03:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6756E3B929E
	for <lists+bpf@lfdr.de>; Sun, 20 Jul 2025 03:03:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4900E13B280;
	Sun, 20 Jul 2025 03:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L1/qk6xH"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E530EEBD
	for <bpf@vger.kernel.org>; Sun, 20 Jul 2025 03:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752980630; cv=none; b=cS+jVuPPVDoAKJEGs41tmbHGc1b8kN3peWMe+QdJXZdu/+AaLaEI8OVSm6OEgbd4DCLaCvxXWyVe76YT5vkQJW+bjE16KJfoRxhghNVG5eN1+ggZWU81020ydUMrITDRAxaAJaYBJmEwuoyrKwDgO/720e6ExHmfYiJaj56+xSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752980630; c=relaxed/simple;
	bh=BOce4MbA8ktWc2us+aViFZnZInpJO9ewtJThK51bNGg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q/6JCDsdZ3tRU5gTqvq2BC9HwEbjG1jrTb3QZY0iJ2PEySc9HLVkpI7N2ewb6g5HW+Ws2WvQjMh1dFrueYjE4yM1aoTLLm8MYht6LMYyCRGXQQduFDcofc9qT+16A3WLH0LvDsMkVwmRUa523JJVv7wWe5zgTvXceXOJmlub/bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L1/qk6xH; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6faf66905baso41344076d6.2
        for <bpf@vger.kernel.org>; Sat, 19 Jul 2025 20:03:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752980628; x=1753585428; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zCjuC119tyiMw7gaePzpsOiGU0ul4JjOaj2XTy2l69A=;
        b=L1/qk6xHKuJE4zHYZpLNmhgYZLa5ayXRY3bLq2E60VwdwxN00kAp61YhBp7pLREHvs
         1cM/Q8T9ywK5tRvB/yfYUMIjh7/9W8vno/F+R4LSHwazwWZH16GYeewuuDF498JLM2Qq
         CkCWESm0MG2jRwY3tJ2rfELAy/k34anqyLWHPVOUdHsSsVVjC6vjIPFZxACsf4usPQl+
         0/oG9iK/QkwzvMDMtzQFhbjNuj39URPeHlOJJSMaj2oVWmyCY1YqrxV7bLg1nAp8zBXV
         WXoDo/c7GtlJdYJElgNuUKa1FQBpMMS3duthgKCd0LxMtCY9NqxR5UiNW9/NM0mCqJ+v
         rFHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752980628; x=1753585428;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zCjuC119tyiMw7gaePzpsOiGU0ul4JjOaj2XTy2l69A=;
        b=kwqtDSgJS86Yt/SCcqHsgY+SsNjsJhoU5MHb5wkDnnIpiyV6DnFMkMOZqDYRs0Lo49
         mwCh+2P88j7qHt2p6h/7RroG/bxSxAeOiZwOhHuF5U2en2v1RG4W6EhlNbNB+cVT4dXc
         NbkNu4tHbJs54/XbuWBz3pMgztOV1vjqq8AGMHqxjwTB63hiZdhLwRY8iZzwZ9rB3DCd
         YNdDo1vnD5HKxSpdHemHjI307HrB/tzQOttUvCOFEPFpgWblIrkw5b+M10HR80D783D+
         u0ySX1kLdOi1H1UogHG6T8eHh6CAeNaxKava13xm84uoo/DMaJfrVoOZuqRAbctaU/ON
         bY0A==
X-Forwarded-Encrypted: i=1; AJvYcCX4XNUFG1/rw4PuI20Z9vwOJtdg4X5mFtY69lM+n1FfidtFn8yApfArBKLqoviJCnakVMc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBI5/1pEFcxjnrWUfwwYVKSOPh6Fy9u4dtF0CAWCvSnTSPsyZ5
	1OowxS9hXmQSxIeUoWr2WyboxKFnQnust53LZL1L+bNoWepr2QuYrk6Fy8xZShIcdqgQbSyQNZF
	OUuLWPGrVTMccwfxgOehxIC6VdkljwI0=
X-Gm-Gg: ASbGnctaWB4TSEpPv+V58nM6gI6nKvsvr6OyvxK4cQ8lmnRaEiflO5Nb2bv07WdKSZH
	bCU7i37ndVi4LSCFE1l8QTuK2476rgOvWj+bUKVYoGIll8oiMszX3dfeMqAQxpNbuqbB2d2I1xq
	Naaz3McuB7ozLgc/BKSanpk7yIhA42LgPE4S9FPRAiDHaV8ZzHDSxJLBj5RbbumU2oc9NJH4VAz
	4iN/aaSNcphi7FfGQs=
X-Google-Smtp-Source: AGHT+IFhOPYOf/lckF/l/0RcodINTrGCuCkeA4w9OuSdtZDV82b9jV+CxWQUwA5sEfoCOGGbPl3M/yeg8nq9/Fl1lSo=
X-Received: by 2002:a05:6214:5d0f:b0:702:d822:9381 with SMTP id
 6a1803df08f44-704f6a6ba4fmr278869956d6.19.1752980628228; Sat, 19 Jul 2025
 20:03:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250608073516.22415-1-laoar.shao@gmail.com> <20250608073516.22415-4-laoar.shao@gmail.com>
 <f37a0f14-9185-4ebd-aa2f-39d377902a89@gmail.com>
In-Reply-To: <f37a0f14-9185-4ebd-aa2f-39d377902a89@gmail.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Sun, 20 Jul 2025 11:03:12 +0800
X-Gm-Features: Ac12FXwhvamZBGFJ_Yw_P0mAAohn5C7tPLVHgwv3BzaZced3l3dpggPaVLhZxs0
Message-ID: <CALOAHbD_BaE2i71A_0gr1O31_UUGApg3=sGuCE0unafonvYAaA@mail.gmail.com>
Subject: Re: [RFC PATCH v3 3/5] mm, thp: add bpf thp hook to determine thp reclaimer
To: Usama Arif <usamaarif642@gmail.com>
Cc: akpm@linux-foundation.org, david@redhat.com, ziy@nvidia.com, 
	baolin.wang@linux.alibaba.com, lorenzo.stoakes@oracle.com, 
	Liam.Howlett@oracle.com, npache@redhat.com, ryan.roberts@arm.com, 
	dev.jain@arm.com, hannes@cmpxchg.org, gutierrez.asier@huawei-partners.com, 
	willy@infradead.org, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	bpf@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 18, 2025 at 12:06=E2=80=AFAM Usama Arif <usamaarif642@gmail.com=
> wrote:
>
>
>
> On 08/06/2025 08:35, Yafang Shao wrote:
> > A new hook, bpf_thp_gfp_mask(), is introduced to determine whether memo=
ry
> > reclamation is being performed by the current task or by kswapd.
> >
> > Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> > ---
> >  include/linux/huge_mm.h | 5 +++++
> >  mm/huge_memory.c        | 5 +++++
> >  2 files changed, 10 insertions(+)
> >
> > diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> > index db2eadd3f65b..6a40ebf25f5c 100644
> > --- a/include/linux/huge_mm.h
> > +++ b/include/linux/huge_mm.h
> > @@ -198,6 +198,11 @@ static inline int bpf_thp_allocator(unsigned long =
vm_flags,
> >       return THP_ALLOC_KHUGEPAGED | THP_ALLOC_CURRENT;
> >  }
> >
> > +static inline gfp_t bpf_thp_gfp_mask(bool vma_madvised)
> > +{
> > +     return 0;
> > +}
> > +
> >  static inline int highest_order(unsigned long orders)
> >  {
> >       return fls_long(orders) - 1;
> > diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> > index d3e66136e41a..81c1711d13fa 100644
> > --- a/mm/huge_memory.c
> > +++ b/mm/huge_memory.c
> > @@ -1280,6 +1280,11 @@ static vm_fault_t __do_huge_pmd_anonymous_page(s=
truct vm_fault *vmf)
> >  gfp_t vma_thp_gfp_mask(struct vm_area_struct *vma)
> >  {
> >       const bool vma_madvised =3D vma && (vma->vm_flags & VM_HUGEPAGE);
> > +     gfp_t gfp_mask;
> > +
> > +     gfp_mask =3D bpf_thp_gfp_mask(vma_madvised);
>
>
> I am guessing bpf_thp_gfp_mask returns 0, as its something yet to be impl=
emented,
> but I really dont understand what this patch is supposed to do.

This change only introduces a placeholder for the BPF program. It
might be cleaner to squash it into patch #4.

--=20
Regards
Yafang

