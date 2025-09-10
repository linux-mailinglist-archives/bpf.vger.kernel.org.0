Return-Path: <bpf+bounces-68011-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D44CDB51728
	for <lists+bpf@lfdr.de>; Wed, 10 Sep 2025 14:43:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C9881707DB
	for <lists+bpf@lfdr.de>; Wed, 10 Sep 2025 12:43:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0E6B31B13F;
	Wed, 10 Sep 2025 12:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="oYS6I0KF"
X-Original-To: bpf@vger.kernel.org
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0024C31196C
	for <bpf@vger.kernel.org>; Wed, 10 Sep 2025 12:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757508207; cv=none; b=pyswqEaVtFbGMoQxE7ebekeTFFt37DRMvdJSFzYeGCGUgKQSdBcqh3AcncOgPc4ZD+6AdDqI9dbwZo2wXVj3CKKf2UhkvFhAilOHHuzqTBMICLem1IhqBG6G5EttCg43ZFzyUo32goJJXPXLIdZVwJw762yuy2XWlMX0kWitNzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757508207; c=relaxed/simple;
	bh=1Ad3b74urJ/RMTOHlVyMzYhsdm3dYbzUIK1fkOPCFiM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VELmI/o45wM4fGkEff65z1vG27K48ZTjSgkgXsTTSx3n2mXzd6JtJROwGHatc4iUjHybc3FzovrPHlSyC23fMifKESLkWuGu85I/IDwue1sC+kTHd22HhggSwILqwABLjS2Nrc5fHCBD9FwTqKFnxj5XMSfF62C4/JvAVLDzna8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=oYS6I0KF; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Forwarded-Encrypted: i=1; AJvYcCW/Cq/Mo8KfVUuNYjUBtyr1cJKyacWfIKxFH+N2UqjphZk8SPCB3pUVwC2svkeLoKMSz+o=@vger.kernel.org, AJvYcCXBSgi3U9We1XCS8M+uWHA1cee+8PyezN6gUNiLVUBF2hOfuUJ7RXsXbWQGZl1CwJFuRm+qUVOAb0zg@vger.kernel.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1757508202;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cWOnY6bsoNbRGhI6jrKdlgeXeUlIE02ttDreMjH2ThU=;
	b=oYS6I0KFGcBY/upNaGvHQ2bTg7Dx6yLmcaFn7N7drhXxYJWFSJzgUTHKeBvC8IKSgYv0FT
	BL4OSjIHyCA2qjCCrIy4ZvlBzIprKy5PeY0UW17Dtp/HDkF8R9JaPpJj/ZzleIi2Wv7BGr
	dF8uenint62QEHDFYkLo15AAALgC1NA=
X-Gm-Message-State: AOJu0Yw6U1WicDklK8nwE1JsnBX175rHgNN2f7tyjVlMsCpkq3Zm68bF
	gtq+iq5P420UwpeMS1v7pbGKQZh6+/OSrrY8kkTv66sUIfEa7dCH/PuJ1BF8unv1i3QhXS03Itq
	9Mf67tBNjKYUd232RWJSaIpmhW9e1Tlk=
X-Google-Smtp-Source: AGHT+IGS4IyMyT2B5rjpMHdQ/sH6F7nZ01XypbWguYA7dCWguRiSUdDaKM5DsDcnWRSvBhMGTGMkWFlbQbHkoeCdCfo=
X-Received: by 2002:ad4:5de2:0:b0:70f:abee:f9ba with SMTP id
 6a1803df08f44-73a21485479mr148779516d6.12.1757508200059; Wed, 10 Sep 2025
 05:43:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250910024447.64788-1-laoar.shao@gmail.com> <20250910024447.64788-3-laoar.shao@gmail.com>
In-Reply-To: <20250910024447.64788-3-laoar.shao@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Lance Yang <lance.yang@linux.dev>
Date: Wed, 10 Sep 2025 20:42:37 +0800
X-Gmail-Original-Message-ID: <CABzRoyZm32HT2fDpSy_PRDxeXZVJD35+9YqRpn9XWix8jG6w8g@mail.gmail.com>
X-Gm-Features: AS18NWA2-rrAiWS-c1ep0R42ZfRXwiuMPFMEj6A1tty0wp_Sw-BPEy3kdhILrOo
Message-ID: <CABzRoyZm32HT2fDpSy_PRDxeXZVJD35+9YqRpn9XWix8jG6w8g@mail.gmail.com>
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
	linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Migadu-Flow: FLOW_OUT

Hey Yafang,

On Wed, Sep 10, 2025 at 10:53=E2=80=AFAM Yafang Shao <laoar.shao@gmail.com>=
 wrote:
>
> This patch introduces a new BPF struct_ops called bpf_thp_ops for dynamic
> THP tuning. It includes a hook bpf_hook_thp_get_order(), allowing BPF
> programs to influence THP order selection based on factors such as:
> - Workload identity
>   For example, workloads running in specific containers or cgroups.
> - Allocation context
>   Whether the allocation occurs during a page fault, khugepaged, swap or
>   other paths.
> - VMA's memory advice settings
>   MADV_HUGEPAGE or MADV_NOHUGEPAGE
> - Memory pressure
>   PSI system data or associated cgroup PSI metrics
>
> The kernel API of this new BPF hook is as follows,
>
> /**
>  * @thp_order_fn_t: Get the suggested THP orders from a BPF program for a=
llocation
>  * @vma: vm_area_struct associated with the THP allocation
>  * @vma_type: The VMA type, such as BPF_THP_VM_HUGEPAGE if VM_HUGEPAGE is=
 set
>  *            BPF_THP_VM_NOHUGEPAGE if VM_NOHUGEPAGE is set, or BPF_THP_V=
M_NONE if
>  *            neither is set.
>  * @tva_type: TVA type for current @vma
>  * @orders: Bitmask of requested THP orders for this allocation
>  *          - PMD-mapped allocation if PMD_ORDER is set
>  *          - mTHP allocation otherwise
>  *
>  * Return: The suggested THP order from the BPF program for allocation. I=
t will
>  *         not exceed the highest requested order in @orders. Return -1 t=
o
>  *         indicate that the original requested @orders should remain unc=
hanged.
>  */
> typedef int thp_order_fn_t(struct vm_area_struct *vma,
>                            enum bpf_thp_vma_type vma_type,
>                            enum tva_type tva_type,
>                            unsigned long orders);
>
> Only a single BPF program can be attached at any given time, though it ca=
n
> be dynamically updated to adjust the policy. The implementation supports
> anonymous THP, shmem THP, and mTHP, with future extensions planned for
> file-backed THP.
>
> This functionality is only active when system-wide THP is configured to
> madvise or always mode. It remains disabled in never mode. Additionally,
> if THP is explicitly disabled for a specific task via prctl(), this BPF
> functionality will also be unavailable for that task.
>
> This feature requires CONFIG_BPF_GET_THP_ORDER (marked EXPERIMENTAL) to b=
e
> enabled. Note that this capability is currently unstable and may undergo
> significant changes=E2=80=94including potential removal=E2=80=94in future=
 kernel versions.
>
> Suggested-by: David Hildenbrand <david@redhat.com>
> Suggested-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> ---
[...]
> diff --git a/mm/huge_memory_bpf.c b/mm/huge_memory_bpf.c
> new file mode 100644
> index 000000000000..525ee22ab598
> --- /dev/null
> +++ b/mm/huge_memory_bpf.c
> @@ -0,0 +1,243 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * BPF-based THP policy management
> + *
> + * Author: Yafang Shao <laoar.shao@gmail.com>
> + */
> +
> +#include <linux/bpf.h>
> +#include <linux/btf.h>
> +#include <linux/huge_mm.h>
> +#include <linux/khugepaged.h>
> +
> +enum bpf_thp_vma_type {
> +       BPF_THP_VM_NONE =3D 0,
> +       BPF_THP_VM_HUGEPAGE,    /* VM_HUGEPAGE */
> +       BPF_THP_VM_NOHUGEPAGE,  /* VM_NOHUGEPAGE */
> +};
> +
> +/**
> + * @thp_order_fn_t: Get the suggested THP orders from a BPF program for =
allocation
> + * @vma: vm_area_struct associated with the THP allocation
> + * @vma_type: The VMA type, such as BPF_THP_VM_HUGEPAGE if VM_HUGEPAGE i=
s set
> + *            BPF_THP_VM_NOHUGEPAGE if VM_NOHUGEPAGE is set, or BPF_THP_=
VM_NONE if
> + *            neither is set.
> + * @tva_type: TVA type for current @vma
> + * @orders: Bitmask of requested THP orders for this allocation
> + *          - PMD-mapped allocation if PMD_ORDER is set
> + *          - mTHP allocation otherwise
> + *
> + * Return: The suggested THP order from the BPF program for allocation. =
It will
> + *         not exceed the highest requested order in @orders. Return -1 =
to
> + *         indicate that the original requested @orders should remain un=
changed.

A minor documentation nit: the comment says "Return -1 to indicate that the
original requested @orders should remain unchanged". It might be slightly
clearer to say "Return a negative value to fall back to the original
behavior". This would cover all error codes as well ;)

> + */
> +typedef int thp_order_fn_t(struct vm_area_struct *vma,
> +                          enum bpf_thp_vma_type vma_type,
> +                          enum tva_type tva_type,
> +                          unsigned long orders);

Sorry if I'm missing some context here since I haven't tracked the whole
series closely.

Regarding the return value for thp_order_fn_t: right now it returns a
single int order. I was thinking, what if we let it return an unsigned
long bitmask of orders instead? This seems like it would be more flexible
down the road, especially if we get more mTHP sizes to choose from. It
would also make the API more consistent, as bpf_hook_thp_get_orders()
itself returns an unsigned long ;)

Also, for future extensions, it might be a good idea to add a reserved
flags argument to the thp_order_fn_t signature.

For example thp_order_fn_t(..., unsigned long flags).

This would give us aforward-compatible way to add new semantics later
without breaking the ABI and needing a v2. We could just require it to be
0 for now.

Thanks for the great work!
Lance

