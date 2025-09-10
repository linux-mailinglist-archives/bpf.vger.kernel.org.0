Return-Path: <bpf+bounces-68012-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31D0DB51757
	for <lists+bpf@lfdr.de>; Wed, 10 Sep 2025 14:55:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6EE443A5B96
	for <lists+bpf@lfdr.de>; Wed, 10 Sep 2025 12:55:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27A4731B115;
	Wed, 10 Sep 2025 12:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="OG2iC4d2"
X-Original-To: bpf@vger.kernel.org
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C8B731AF3F
	for <bpf@vger.kernel.org>; Wed, 10 Sep 2025 12:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757508904; cv=none; b=CAHA+mxnd7OJfQPab3+briCJDkyKmn+vQuSs4wc/2268p0psTnMjv+HQyo9CtCqnS+3jofwKJxGOiAbfYlVC5L1P0gXOoAFT0psN0uTEvDbOrprNlLGPsgDkkqEI88XC41Es+HX67QMINkMPWkkMTslIUI25dTXA1w7HCbMQ23U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757508904; c=relaxed/simple;
	bh=rC7WX95sqxOT8v66OLVfAxNmWZrbsDnyocl0QsPkanA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kC2sDh4uV3k8bad9PvqGcglHwMrkAo35hd97Zcqo0f3o0tWXZLVUREviDteSIxkDhiTF/22jpgeCMZA3vHzBlhIKcqxoWYYYilSeRHOv5Fgw9hVOTun+mQe19gC7h13BAmWmbdOECwoXDSz+qcOyq4E5z723cEDBGa5pxmZeN4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=OG2iC4d2; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Forwarded-Encrypted: i=1; AJvYcCX9qyi37CVvPepzx8S81erPIz4yD5v/DR9gRZ39ilme0CI06rOUzs9Elc/T5rBCey1YXVQ=@vger.kernel.org, AJvYcCXnAdn+QiPQlL+BK+1oO+YsW43W4kNGROgXaIxQg/6yH/4sPwkjAQ1MAnQxBBFW9snkHdPDF6pIiJBr@vger.kernel.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1757508900;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UMkFEykw6CDHcCxpRG3Ctye5mxgPw1tmO5woFImiW2w=;
	b=OG2iC4d2RvJ3jpIflZNbR1pAbESc49ZOOYVVlgxmMe12mNTZcCbA2Pib0RCIJc+xXg/GjI
	auu8oQs1yOOkl+0BnU/pnyoZPGuwUCIVEg1rMZDYIu/UsuLVkF9dNoJXauXW9uTQRg21BX
	GPvT6SvkeomOGDRaGsIXQ4+MK16WgkU=
X-Gm-Message-State: AOJu0Yz8fdrqxZauIqqN8scjy4pD908kOoUDP4ToY226kSaCOiV7viTR
	apd5ogmrfFM/zHCyw3nAoQACbrUPUudJucZu/YnUoXx9nkOHUXeO57ToqFscnBPRx+Uhyjk+ApQ
	FrDfoP3ne1gFqvN1gZgokNWk4qCt4OMU=
X-Google-Smtp-Source: AGHT+IEF3eQ6UlcRwDeEpxd1PL/TBSKLn4agQK0TqsOV7RfLeqWe4bZiUjFZd7iV35M7UX+D6Fe2DO6sCezbXMSn6Vw=
X-Received: by 2002:a05:6214:20a9:b0:727:e0b5:beaa with SMTP id
 6a1803df08f44-7391f3041a4mr162984186d6.6.1757508895553; Wed, 10 Sep 2025
 05:54:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250910024447.64788-1-laoar.shao@gmail.com> <20250910024447.64788-3-laoar.shao@gmail.com>
 <CABzRoyZm32HT2fDpSy_PRDxeXZVJD35+9YqRpn9XWix8jG6w8g@mail.gmail.com>
In-Reply-To: <CABzRoyZm32HT2fDpSy_PRDxeXZVJD35+9YqRpn9XWix8jG6w8g@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Lance Yang <lance.yang@linux.dev>
Date: Wed, 10 Sep 2025 20:54:18 +0800
X-Gmail-Original-Message-ID: <CABzRoyYqGsABGVgXbH3Sts3yBsk7ED=BsKbcP3Skc-oWeFsN_w@mail.gmail.com>
X-Gm-Features: AS18NWAsoUIhBQUf1uoUzmIJVtw-dLaFewCMwdt6vFR159yx-71Dyff6aabB_sY
Message-ID: <CABzRoyYqGsABGVgXbH3Sts3yBsk7ED=BsKbcP3Skc-oWeFsN_w@mail.gmail.com>
Subject: Re: [PATCH v7 mm-new 02/10] mm: thp: add support for BPF based THP
 order selection
To: Yafang Shao <laoar.shao@gmail.com>
Cc: akpm@linux-foundation.org, david@redhat.com, ziy@nvidia.com, 
	baolin.wang@linux.alibaba.com, lorenzo.stoakes@oracle.com, 
	Liam.Howlett@oracle.com, npache@redhat.com, ryan.roberts@arm.com, 
	dev.jain@arm.com, hannes@cmpxchg.org, usamaarif642@gmail.com, 
	gutierrez.asier@huawei-partners.com, willy@infradead.org, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, ameryhung@gmail.com, 
	rientjes@google.com, corbet@lwn.net, 21cnbao@gmail.com, 
	shakeel.butt@linux.dev, bpf@vger.kernel.org, linux-mm@kvack.org, 
	linux-doc@vger.kernel.org, Lance Yang <lance.yang@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Migadu-Flow: FLOW_OUT

On Wed, Sep 10, 2025 at 8:42=E2=80=AFPM Lance Yang <lance.yang@linux.dev> w=
rote:
>
> Hey Yafang,
>
> On Wed, Sep 10, 2025 at 10:53=E2=80=AFAM Yafang Shao <laoar.shao@gmail.co=
m> wrote:
> >
> > This patch introduces a new BPF struct_ops called bpf_thp_ops for dynam=
ic
> > THP tuning. It includes a hook bpf_hook_thp_get_order(), allowing BPF
> > programs to influence THP order selection based on factors such as:
> > - Workload identity
> >   For example, workloads running in specific containers or cgroups.
> > - Allocation context
> >   Whether the allocation occurs during a page fault, khugepaged, swap o=
r
> >   other paths.
> > - VMA's memory advice settings
> >   MADV_HUGEPAGE or MADV_NOHUGEPAGE
> > - Memory pressure
> >   PSI system data or associated cgroup PSI metrics
> >
> > The kernel API of this new BPF hook is as follows,
> >
> > /**
> >  * @thp_order_fn_t: Get the suggested THP orders from a BPF program for=
 allocation
> >  * @vma: vm_area_struct associated with the THP allocation
> >  * @vma_type: The VMA type, such as BPF_THP_VM_HUGEPAGE if VM_HUGEPAGE =
is set
> >  *            BPF_THP_VM_NOHUGEPAGE if VM_NOHUGEPAGE is set, or BPF_THP=
_VM_NONE if
> >  *            neither is set.
> >  * @tva_type: TVA type for current @vma
> >  * @orders: Bitmask of requested THP orders for this allocation
> >  *          - PMD-mapped allocation if PMD_ORDER is set
> >  *          - mTHP allocation otherwise
> >  *
> >  * Return: The suggested THP order from the BPF program for allocation.=
 It will
> >  *         not exceed the highest requested order in @orders. Return -1=
 to
> >  *         indicate that the original requested @orders should remain u=
nchanged.
> >  */
> > typedef int thp_order_fn_t(struct vm_area_struct *vma,
> >                            enum bpf_thp_vma_type vma_type,
> >                            enum tva_type tva_type,
> >                            unsigned long orders);
> >
> > Only a single BPF program can be attached at any given time, though it =
can
> > be dynamically updated to adjust the policy. The implementation support=
s
> > anonymous THP, shmem THP, and mTHP, with future extensions planned for
> > file-backed THP.
> >
> > This functionality is only active when system-wide THP is configured to
> > madvise or always mode. It remains disabled in never mode. Additionally=
,
> > if THP is explicitly disabled for a specific task via prctl(), this BPF
> > functionality will also be unavailable for that task.
> >
> > This feature requires CONFIG_BPF_GET_THP_ORDER (marked EXPERIMENTAL) to=
 be
> > enabled. Note that this capability is currently unstable and may underg=
o
> > significant changes=E2=80=94including potential removal=E2=80=94in futu=
re kernel versions.
> >
> > Suggested-by: David Hildenbrand <david@redhat.com>
> > Suggested-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> > Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> > ---
> [...]
> > diff --git a/mm/huge_memory_bpf.c b/mm/huge_memory_bpf.c
> > new file mode 100644
> > index 000000000000..525ee22ab598
> > --- /dev/null
> > +++ b/mm/huge_memory_bpf.c
> > @@ -0,0 +1,243 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * BPF-based THP policy management
> > + *
> > + * Author: Yafang Shao <laoar.shao@gmail.com>
> > + */
> > +
> > +#include <linux/bpf.h>
> > +#include <linux/btf.h>
> > +#include <linux/huge_mm.h>
> > +#include <linux/khugepaged.h>
> > +
> > +enum bpf_thp_vma_type {
> > +       BPF_THP_VM_NONE =3D 0,
> > +       BPF_THP_VM_HUGEPAGE,    /* VM_HUGEPAGE */
> > +       BPF_THP_VM_NOHUGEPAGE,  /* VM_NOHUGEPAGE */
> > +};
> > +
> > +/**
> > + * @thp_order_fn_t: Get the suggested THP orders from a BPF program fo=
r allocation
> > + * @vma: vm_area_struct associated with the THP allocation
> > + * @vma_type: The VMA type, such as BPF_THP_VM_HUGEPAGE if VM_HUGEPAGE=
 is set
> > + *            BPF_THP_VM_NOHUGEPAGE if VM_NOHUGEPAGE is set, or BPF_TH=
P_VM_NONE if
> > + *            neither is set.
> > + * @tva_type: TVA type for current @vma
> > + * @orders: Bitmask of requested THP orders for this allocation
> > + *          - PMD-mapped allocation if PMD_ORDER is set
> > + *          - mTHP allocation otherwise
> > + *
> > + * Return: The suggested THP order from the BPF program for allocation=
. It will
> > + *         not exceed the highest requested order in @orders. Return -=
1 to
> > + *         indicate that the original requested @orders should remain =
unchanged.
>
> A minor documentation nit: the comment says "Return -1 to indicate that t=
he
> original requested @orders should remain unchanged". It might be slightly
> clearer to say "Return a negative value to fall back to the original
> behavior". This would cover all error codes as well ;)
>
> > + */
> > +typedef int thp_order_fn_t(struct vm_area_struct *vma,
> > +                          enum bpf_thp_vma_type vma_type,
> > +                          enum tva_type tva_type,
> > +                          unsigned long orders);
>
> Sorry if I'm missing some context here since I haven't tracked the whole
> series closely.
>
> Regarding the return value for thp_order_fn_t: right now it returns a
> single int order. I was thinking, what if we let it return an unsigned
> long bitmask of orders instead? This seems like it would be more flexible
> down the road, especially if we get more mTHP sizes to choose from. It
> would also make the API more consistent, as bpf_hook_thp_get_orders()
> itself returns an unsigned long ;)

I just realized a flaw in my previous suggestion :(

Changing the return type of thp_order_fn_t to unsigned long for consistency
and flexibility. However, I completely overlooked that this would prevent
the BPF program from returning negative error codes ...

Thanks,
Lance

>
> Also, for future extensions, it might be a good idea to add a reserved
> flags argument to the thp_order_fn_t signature.
>
> For example thp_order_fn_t(..., unsigned long flags).
>
> This would give us aforward-compatible way to add new semantics later
> without breaking the ABI and needing a v2. We could just require it to be
> 0 for now.
>
> Thanks for the great work!
> Lance

