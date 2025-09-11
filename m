Return-Path: <bpf+bounces-68080-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80896B526AD
	for <lists+bpf@lfdr.de>; Thu, 11 Sep 2025 04:49:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 27DFA17B8FA
	for <lists+bpf@lfdr.de>; Thu, 11 Sep 2025 02:49:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8745A22156A;
	Thu, 11 Sep 2025 02:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YNSeQBy+"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 046F51DE2BD;
	Thu, 11 Sep 2025 02:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757558974; cv=none; b=FGV4gxXK6QvXn4AsTrWJjm4UAP7hSJJi6qD4i9E4w7GgghRU71QgXnGt9q9G58BiHhoAAQ4KFoFs6VF8iHHMux6KkSPk8XZm//gIvuHKHiE0D+OtK4vgDWCEmjrTljLa8fKq2H5DM+e8M4AfOYhaFvJwp16D12NeRqPrU39nd8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757558974; c=relaxed/simple;
	bh=0oO5IQf3F2t4U6+N7F5O4tbUDSn19sInPAKiWSPwcPY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ur/fRkdH54NYb/MpZhMIi0upm+6AJ9MuOX3BtjES3zZ0w0fKpbpp2LcfhNIug9E5poUdX90+2zp8BW6mqPLqH4Zz4RO6VNThcUuMJSnRnD3egC03wGmgn+jNhhfQnw9tfjyu7KApjJfA+renq6f5FT+u+ay9S4yZ2NXUAsZa24Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YNSeQBy+; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-726e7449186so3108316d6.0;
        Wed, 10 Sep 2025 19:49:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757558971; x=1758163771; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mPkvLMLUO4/MeSrlRc20PFaOfOQfZFZatjMRvIBVqIE=;
        b=YNSeQBy+ZMtavHNC77xQdaTkC4Uqu1Fmg9NaJg+AtNSjYzncKbxxW0rHgsMnGsJw2r
         N7/jDUO7hd4WQXD9v9ROsZbiTc1/+QNfV/CQR8Uci6lPjWUuZHGjJjPTv2AyS4CN94Oq
         jkIOI3XIC0+TqsgDsBNkhCGLYToLepV0/6jSvQbtJPmR6E49IQ2dCHOPGU9iNzalo04D
         cMxdltYM2F2aCyFdqzwhZqGhblzFgdDu4bHHeV+6TKm54sEv2QJTS6jsb+ezBw9Qsq8W
         ZHsqpqhdCSYWfD0DbFQaz+eiXxbOg78c/sbmW0JvccE65WQjQdu7tYyROnoiu1swUPK6
         Vd0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757558971; x=1758163771;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mPkvLMLUO4/MeSrlRc20PFaOfOQfZFZatjMRvIBVqIE=;
        b=PL2Tbt7OqfF+guzaMtvkrApbK0w7u32R2qXtBRalWe5PuxcHhRXx6P6cu21d9E2DyJ
         w1K+QTNjN3pcbQKRl1GAJLzGdvdr+8kC6AFWJJvrVwrdT/u//uV/j7T1QUhPtWoYUy4i
         lTc0SC27BKj67QKpppyQhBTTl7CFEj1YD7iJYX9f0xc8isXxF70U1N/ulH4YmFaTUGhG
         3QToHquIeHZ8/Ray+0A1jOI8uytO5fRBTtBoc7/3FvHKN2BvEbSEl7QUshFWjz7G1hWo
         zwNNMosttkGeQy8yPqg0GV1vLX8GaCs6Ejgez7+0vwmfEe0eJyXIs8Zd+KDKpdSflD2L
         1MxQ==
X-Forwarded-Encrypted: i=1; AJvYcCVFRd9+9VajGbuEeqTldIBPgXYS0/EHelNhA3OnEkvbmvBm4RcutfoLiMLeNRu/jMFi6EQ=@vger.kernel.org, AJvYcCWcspvfgHJk+sZAElY6leBpA3TZfbPSQ6wlLb2BtfURsNhpdAIoXeGY6vsYi/Fxl55Hd+Ihb1iC7u/d@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5wPpQL5Ckxjx9hcLa9pT5MAlLC0MFlsqNm4DY9wPA8poRdJow
	bJiZBCKnVUe6CFWelwNeOqjipTdIVaYBMwJcups1o+Hc5vpuoM58LaXY4rZMNdtuFPEILYHYbIO
	O4aTVBDqlGujqf0Z/39/QqFAOasQ0XpI=
X-Gm-Gg: ASbGncsLHpL3JMoIucXl4v76krXIHabVGaPYuvO5MfUDwGbM9vptB+XFNspjLOAaeGb
	LW4iDpmDyQxgH/j8L5IyV462bp8IPXeyvHudW/myQktznum9SoZ4p3FaiKOGZxCzDpEfEC8knni
	kgiARZJiW679KFVoFQJwhkqTDWjDP3++tM51t/cMRAeljL12rDks9L/UNRU09ZFCnPOMzC8fKdL
	/2uautZloxxOKcOHmrhVyHF+4ZvMYB+VUPM/COl
X-Google-Smtp-Source: AGHT+IGqscjg9YNQgZdBNOy6g5+0CDhJK0qHro2vjyAAA8dy6Xw4gh+wTZvmnYMWSlPTMxgNC1MioX6UzB7j+ICQZ0c=
X-Received: by 2002:ad4:5f0f:0:b0:729:aa08:11f5 with SMTP id
 6a1803df08f44-7394587e3b9mr199292636d6.64.1757558970712; Wed, 10 Sep 2025
 19:49:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250910024447.64788-1-laoar.shao@gmail.com> <20250910024447.64788-3-laoar.shao@gmail.com>
 <CABzRoyZm32HT2fDpSy_PRDxeXZVJD35+9YqRpn9XWix8jG6w8g@mail.gmail.com>
 <CABzRoyYqGsABGVgXbH3Sts3yBsk7ED=BsKbcP3Skc-oWeFsN_w@mail.gmail.com> <ac633edf-4744-4215-b105-c168d3a734ce@linux.dev>
In-Reply-To: <ac633edf-4744-4215-b105-c168d3a734ce@linux.dev>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Thu, 11 Sep 2025 10:48:54 +0800
X-Gm-Features: AS18NWCKZiA03E-aejW3uz2mDNVDJGB6xG9JGVb75n2Lnhn-9uYRcZZKPr2Dc4I
Message-ID: <CALOAHbAfzDNdx5LTUhH+eMgVfdG35gAM5subeByP97x53=CWLw@mail.gmail.com>
Subject: Re: [PATCH v7 mm-new 02/10] mm: thp: add support for BPF based THP
 order selection
To: Lance Yang <lance.yang@linux.dev>
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

On Wed, Sep 10, 2025 at 9:57=E2=80=AFPM Lance Yang <lance.yang@linux.dev> w=
rote:
>
>
>
> On 2025/9/10 20:54, Lance Yang wrote:
> > On Wed, Sep 10, 2025 at 8:42=E2=80=AFPM Lance Yang <lance.yang@linux.de=
v> wrote:
> >>
> >> Hey Yafang,
> >>
> >> On Wed, Sep 10, 2025 at 10:53=E2=80=AFAM Yafang Shao <laoar.shao@gmail=
.com> wrote:
> >>>
> >>> This patch introduces a new BPF struct_ops called bpf_thp_ops for dyn=
amic
> >>> THP tuning. It includes a hook bpf_hook_thp_get_order(), allowing BPF
> >>> programs to influence THP order selection based on factors such as:
> >>> - Workload identity
> >>>    For example, workloads running in specific containers or cgroups.
> >>> - Allocation context
> >>>    Whether the allocation occurs during a page fault, khugepaged, swa=
p or
> >>>    other paths.
> >>> - VMA's memory advice settings
> >>>    MADV_HUGEPAGE or MADV_NOHUGEPAGE
> >>> - Memory pressure
> >>>    PSI system data or associated cgroup PSI metrics
> >>>
> >>> The kernel API of this new BPF hook is as follows,
> >>>
> >>> /**
> >>>   * @thp_order_fn_t: Get the suggested THP orders from a BPF program =
for allocation
> >>>   * @vma: vm_area_struct associated with the THP allocation
> >>>   * @vma_type: The VMA type, such as BPF_THP_VM_HUGEPAGE if VM_HUGEPA=
GE is set
> >>>   *            BPF_THP_VM_NOHUGEPAGE if VM_NOHUGEPAGE is set, or BPF_=
THP_VM_NONE if
> >>>   *            neither is set.
> >>>   * @tva_type: TVA type for current @vma
> >>>   * @orders: Bitmask of requested THP orders for this allocation
> >>>   *          - PMD-mapped allocation if PMD_ORDER is set
> >>>   *          - mTHP allocation otherwise
> >>>   *
> >>>   * Return: The suggested THP order from the BPF program for allocati=
on. It will
> >>>   *         not exceed the highest requested order in @orders. Return=
 -1 to
> >>>   *         indicate that the original requested @orders should remai=
n unchanged.
> >>>   */
> >>> typedef int thp_order_fn_t(struct vm_area_struct *vma,
> >>>                             enum bpf_thp_vma_type vma_type,
> >>>                             enum tva_type tva_type,
> >>>                             unsigned long orders);
> >>>
> >>> Only a single BPF program can be attached at any given time, though i=
t can
> >>> be dynamically updated to adjust the policy. The implementation suppo=
rts
> >>> anonymous THP, shmem THP, and mTHP, with future extensions planned fo=
r
> >>> file-backed THP.
> >>>
> >>> This functionality is only active when system-wide THP is configured =
to
> >>> madvise or always mode. It remains disabled in never mode. Additional=
ly,
> >>> if THP is explicitly disabled for a specific task via prctl(), this B=
PF
> >>> functionality will also be unavailable for that task.
> >>>
> >>> This feature requires CONFIG_BPF_GET_THP_ORDER (marked EXPERIMENTAL) =
to be
> >>> enabled. Note that this capability is currently unstable and may unde=
rgo
> >>> significant changes=E2=80=94including potential removal=E2=80=94in fu=
ture kernel versions.
> >>>
> >>> Suggested-by: David Hildenbrand <david@redhat.com>
> >>> Suggested-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> >>> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> >>> ---
> >> [...]
> >>> diff --git a/mm/huge_memory_bpf.c b/mm/huge_memory_bpf.c
> >>> new file mode 100644
> >>> index 000000000000..525ee22ab598
> >>> --- /dev/null
> >>> +++ b/mm/huge_memory_bpf.c
> >>> @@ -0,0 +1,243 @@
> >>> +// SPDX-License-Identifier: GPL-2.0
> >>> +/*
> >>> + * BPF-based THP policy management
> >>> + *
> >>> + * Author: Yafang Shao <laoar.shao@gmail.com>
> >>> + */
> >>> +
> >>> +#include <linux/bpf.h>
> >>> +#include <linux/btf.h>
> >>> +#include <linux/huge_mm.h>
> >>> +#include <linux/khugepaged.h>
> >>> +
> >>> +enum bpf_thp_vma_type {
> >>> +       BPF_THP_VM_NONE =3D 0,
> >>> +       BPF_THP_VM_HUGEPAGE,    /* VM_HUGEPAGE */
> >>> +       BPF_THP_VM_NOHUGEPAGE,  /* VM_NOHUGEPAGE */
> >>> +};
> >>> +
> >>> +/**
> >>> + * @thp_order_fn_t: Get the suggested THP orders from a BPF program =
for allocation
> >>> + * @vma: vm_area_struct associated with the THP allocation
> >>> + * @vma_type: The VMA type, such as BPF_THP_VM_HUGEPAGE if VM_HUGEPA=
GE is set
> >>> + *            BPF_THP_VM_NOHUGEPAGE if VM_NOHUGEPAGE is set, or BPF_=
THP_VM_NONE if
> >>> + *            neither is set.
> >>> + * @tva_type: TVA type for current @vma
> >>> + * @orders: Bitmask of requested THP orders for this allocation
> >>> + *          - PMD-mapped allocation if PMD_ORDER is set
> >>> + *          - mTHP allocation otherwise
> >>> + *
> >>> + * Return: The suggested THP order from the BPF program for allocati=
on. It will
> >>> + *         not exceed the highest requested order in @orders. Return=
 -1 to
> >>> + *         indicate that the original requested @orders should remai=
n unchanged.
> >>
> >> A minor documentation nit: the comment says "Return -1 to indicate tha=
t the
> >> original requested @orders should remain unchanged". It might be sligh=
tly
> >> clearer to say "Return a negative value to fall back to the original
> >> behavior". This would cover all error codes as well ;)

will change it.

> >>
> >>> + */
> >>> +typedef int thp_order_fn_t(struct vm_area_struct *vma,
> >>> +                          enum bpf_thp_vma_type vma_type,
> >>> +                          enum tva_type tva_type,
> >>> +                          unsigned long orders);
> >>
> >> Sorry if I'm missing some context here since I haven't tracked the who=
le
> >> series closely.
> >>
> >> Regarding the return value for thp_order_fn_t: right now it returns a
> >> single int order. I was thinking, what if we let it return an unsigned
> >> long bitmask of orders instead? This seems like it would be more flexi=
ble
> >> down the road, especially if we get more mTHP sizes to choose from. It
> >> would also make the API more consistent, as bpf_hook_thp_get_orders()
> >> itself returns an unsigned long ;)
> >
> > I just realized a flaw in my previous suggestion :(
> >
> > Changing the return type of thp_order_fn_t to unsigned long for consist=
ency
> > and flexibility. However, I completely overlooked that this would preve=
nt
> > the BPF program from returning negative error codes ...
> >
> > Thanks,
> > Lance
> >
> >>
> >> Also, for future extensions, it might be a good idea to add a reserved
> >> flags argument to the thp_order_fn_t signature.
> >>
> >> For example thp_order_fn_t(..., unsigned long flags).
> >>
> >> This would give us aforward-compatible way to add new semantics later
> >> without breaking the ABI and needing a v2. We could just require it to=
 be
> >> 0 for now.

That makes sense. However, as Lorenzo mentioned previously, we should
keep the interface as minimal as possible.

> >>
> >> Thanks for the great work!
> >> Lance
>
>
> Forgot to add:
>
> Noticed that if the hook returns 0, bpf_hook_thp_get_orders() falls
> back to 'orders', preventing us from dynamically disabling mTHP
> allocations.

Could you please clarify what you mean by that?

+       thp_order =3D bpf_hook_thp_get_order(vma, vma_type, tva_type, order=
s);
+       if (thp_order < 0)
+               goto out;

In my implementation, it only falls back to @orders if the return
value is negative. If the return value is 0, it uses BIT(0):

+       if (thp_order <=3D highest_order(orders))
+               thp_orders =3D BIT(thp_order);

>
> Honoring a return of 0 is critical for our use case, which is to
> dynamically disable mTHP for low-priority containers when memory gets
> low in mixed workloads.
>
> And then re-enable it for them when memory is back above the low
> watermark.

Thank you for detailing your use case; that context is very helpful.

--=20
Regards
Yafang

