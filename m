Return-Path: <bpf+bounces-48997-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C49E5A12F01
	for <lists+bpf@lfdr.de>; Thu, 16 Jan 2025 00:15:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 410293A5ABF
	for <lists+bpf@lfdr.de>; Wed, 15 Jan 2025 23:15:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BBC21DDA14;
	Wed, 15 Jan 2025 23:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KxoR92Sd"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF2281DC982
	for <bpf@vger.kernel.org>; Wed, 15 Jan 2025 23:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736982923; cv=none; b=WdhFHaCgyCXyHwGP8CpRfpAhK7N2AStEs2yGnTW1cdxjWRdMHDZ2oFcEIuZvZ3/1p2pkWigZFePs7Zn6SPCMVzHrPmcRSFmHRkzS8/uT+dAfx7UZLBiqYaSmcKpfI2SBWBOVMoWCWeJ8QaBrQMmNKAUdq/WEU1VCLB+pyigYnh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736982923; c=relaxed/simple;
	bh=GjK1vvyRUCTmvONy2lTSoG+/lfgY4GjMWN32SMeDAvA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g9MQNebI7thbg1g9CUhYhrraFfWId/X/iNiKKbo8InBdbXGdVH011CHZQhhqpobCE4LrvupH+UNCfOAtTPXuNj/4LNC/oEysu0LnxUogjE0EeroRBoOkuo8Ny4rvYYcd0/ToFH2D9YLFFIU0NkboIKVk0fjVc8M2TNJgwZSfffo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KxoR92Sd; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4362f61757fso2190055e9.2
        for <bpf@vger.kernel.org>; Wed, 15 Jan 2025 15:15:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736982920; x=1737587720; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mgw2OJBwLljHvsYzR/kjGTspzbsGhv33WTN+4cKKAwA=;
        b=KxoR92SdULy9hvagvD8zANT5X8jO/AnvXwtsJXjRiSG8+HWTtbMpIM0nMwQ3vH01lM
         vGRvNpVvDxyAzUfWmtC1S7J/bHdU8yCdHMxdFF/8Kh3xxsyVsBnfXgPYaRFv6QLfWoAr
         qBl8GCi6rLy3RZNe0f9OlWsUsq/sM85Wl1IY810syW1emOsvlZ0wASZCu/AlGBDvwZI5
         h+z9yqcYdRcyFyIt/QAOgffVnx67P9CZNT0GZH3QMSjBBpaBQywSsw/StE9OPJYsFstA
         U1zTi8OF/L4j0tgC8HRaabV7MVc7blebOf3tjLz0ZWYS00T2eAmCiugNPR2yoRmKC6VQ
         HN8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736982920; x=1737587720;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mgw2OJBwLljHvsYzR/kjGTspzbsGhv33WTN+4cKKAwA=;
        b=FS+FeNUVf/wNYnTm++oTBMJvvK7ps8UJ3JXrmdh0kas922QHBkDXfCMSRR10Oz359U
         gOcTEcLjrg/A1HGhOLFUZiD8SekdAGHDaeN+HszG8LWvE3KfU3u+gXyT0omEEQSihl7q
         pA6i5E1NnVEZ7mhFpMPEo/thBCN2c+WPClBHE+UVyhBRNbfn5AcYWvNBBfl8ML9fXwXz
         Rbc9NPswBfuV2QVrRZCb3yQJ7qrtfA24gNq9/DMYPf0jasZrBXLpJF0RdgfE5eevyGb3
         gdUzGxGNq+uAMX55fVICgK9B8vhvXz1iFYG0h6TLOi1CSKyc21b4yg4u9BHs/JlzREpE
         8HhA==
X-Gm-Message-State: AOJu0Yxari+tE/y+YYhORoHgcLNBOEAJpAOk8dZtn62Ay7rKW8h0ubv5
	d8ndVd5Gwj2LPDTzA6Qr3SWXl2V3LUYwHQQ4Xq38n4Ul0uiwE9pWFcAEsAQve7C/CXoKQPCrNhj
	AM7A9v7Uc3S+m756yjdcyD4N/QN0=
X-Gm-Gg: ASbGncun8vhKKxmA/u7GJ34rJ28T4qFarX4z89SsIyPNk3v/lkIfInuKFlybgubx3Jz
	X/gabxLnsdzmz3Xg3dU4bKq8VzKcgXlFdSIrRFxRVrb+zd0FpS/l8XA==
X-Google-Smtp-Source: AGHT+IFZxa/YyLENIta0ohBOdKPRMerHYG0hyhLWGSEwLN3/6MaD+aUZihZRYyl0F6jSkpQQAfnOfBjKYkvmnxPPj+o=
X-Received: by 2002:a05:6000:460b:b0:385:dffb:4d56 with SMTP id
 ffacd0b85a97d-38a87317e45mr26387484f8f.53.1736982920100; Wed, 15 Jan 2025
 15:15:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250115021746.34691-1-alexei.starovoitov@gmail.com>
 <20250115021746.34691-3-alexei.starovoitov@gmail.com> <d273c11b-19c0-4d25-b449-6d84f58c5836@suse.cz>
In-Reply-To: <d273c11b-19c0-4d25-b449-6d84f58c5836@suse.cz>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 15 Jan 2025 15:15:06 -0800
X-Gm-Features: AbW1kvargeHy_8egiu4qs9-6n6zF-u4SSC7PsI9lpRW_o5Wc1UnKYbdz_CdhNEo
Message-ID: <CAADnVQLU5JDUq70nE4+1wGf9Uh27oPahaVXxKHPKLAm5=ptiYQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 2/7] mm, bpf: Introduce free_pages_nolock()
To: Vlastimil Babka <vbabka@suse.cz>
Cc: bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Peter Zijlstra <peterz@infradead.org>, Sebastian Sewior <bigeasy@linutronix.de>, 
	Steven Rostedt <rostedt@goodmis.org>, Hou Tao <houtao1@huawei.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Michal Hocko <mhocko@suse.com>, Matthew Wilcox <willy@infradead.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Jann Horn <jannh@google.com>, Tejun Heo <tj@kernel.org>, 
	linux-mm <linux-mm@kvack.org>, Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 15, 2025 at 3:47=E2=80=AFAM Vlastimil Babka <vbabka@suse.cz> wr=
ote:
>
> On 1/15/25 03:17, Alexei Starovoitov wrote:
> > From: Alexei Starovoitov <ast@kernel.org>
> >
> > Introduce free_pages_nolock() that can free pages without taking locks.
> > It relies on trylock and can be called from any context.
> > Since spin_trylock() cannot be used in RT from hard IRQ or NMI
> > it uses lockless link list to stash the pages which will be freed
> > by subsequent free_pages() from good context.
> >
> > Do not use llist unconditionally. BPF maps continuously
> > allocate/free, so we cannot unconditionally delay the freeing to
> > llist. When the memory becomes free make it available to the
> > kernel and BPF users right away if possible, and fallback to
> > llist as the last resort.
> >
> > Signed-off-by: Alexei Starovoitov <ast@kernel.org>
>
> Acked-by: Vlastimil Babka <vbabka@suse.cz>
>
> With:
>
> > @@ -4853,6 +4905,17 @@ void __free_pages(struct page *page, unsigned in=
t order)
> >  }
> >  EXPORT_SYMBOL(__free_pages);
> >
> > +/*
> > + * Can be called while holding raw_spin_lock or from IRQ and NMI,
> > + * but only for pages that came from try_alloc_pages():
> > + * order <=3D 3, !folio, etc
>
> I think order > 3 is fine, as !pcp_allowed_order() case is handled too?

try_alloc_page() has:
        if (!pcp_allowed_order(order))
                return NULL;

to make sure it tries pcp first.
bpf has no use for order > 1. Even 3 is overkill,
but it's kinda free to support order <=3D 3, so why not.

> And
> what does "!folio" mean?

That's what we discussed last year.
__free_pages() has all the extra stuff if (!head) and
support for dropping ref on the middle page.
!folio captures this more broadly.

> > + */
> > +void free_pages_nolock(struct page *page, unsigned int order)
> > +{
> > +     if (put_page_testzero(page))
> > +             __free_unref_page(page, order, FPI_TRYLOCK);
>
> Hmm this will reach reset_page_owner() and thus stackdepot so same mental
> note as for patch 1.

save_stack() has recursions protection already. So should be fine.

> > +}
> > +
> >  void free_pages(unsigned long addr, unsigned int order)
> >  {
> >       if (addr !=3D 0) {
>

