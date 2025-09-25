Return-Path: <bpf+bounces-69710-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D2E0B9EF1B
	for <lists+bpf@lfdr.de>; Thu, 25 Sep 2025 13:38:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 600621BC4068
	for <lists+bpf@lfdr.de>; Thu, 25 Sep 2025 11:39:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 535C32FB96C;
	Thu, 25 Sep 2025 11:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XeIL2a5R"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54E192EB5B5
	for <bpf@vger.kernel.org>; Thu, 25 Sep 2025 11:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758800321; cv=none; b=Q4gJZuXT3ILLuFPvcUybqKEKBopv8yLH1m+nPGGV7Kj8M7kLWBnGhh24H/wEVuHk8NGBwxtrXF3ScfIOEwnGXetqs8z06+S7SHCxR4hWsFfIyhkkQvFS9BBv+S5CVGj8h1E7ixIHHK2PsTCaXbtLaMrtnvgww+ttG2odCSJG4x4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758800321; c=relaxed/simple;
	bh=MPmpW9KjecilXj0o57I2sOWYamYKOiiwJaTMsr/IhRo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lD0r7LDoiEWd4sMSkZ/ZzXu7RVQu+T3XA+HCjm8r3PeH8E+mkddNJll5DSoltWF2ecwxPWIzdKueJXG6ggfWiJsdYMGVTttPEeQ9/acQkr5VKmcBS2yOa1jbbow41SG3YaEtAcfUj4meqn3/CgVTErx5zPbmGDnHQMcFWEcWGdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XeIL2a5R; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-856701dc22aso84331885a.3
        for <bpf@vger.kernel.org>; Thu, 25 Sep 2025 04:38:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758800318; x=1759405118; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dxqroIT0bJ4gLlcnSWTcG5okvXIsZwteqLXkgpBpuRM=;
        b=XeIL2a5RQJ5n8jZntrgyvcAMUK6NqAscvEFjbwXK6epKeAxVf+d2PfzsUj/kYBi4m+
         5bwV/6eB7edGWr5vWsGB1HKbL0G04mp6XdEVIDs3uGraS4KZF3HcOO7eC/gDcN6tCcnI
         AOcsgITC/GkKOnmaUaDxzK7W0mYiXxcNlZMoBjDtHhZn5dE12RDgYM0/GJv8le5yDR+I
         Va/RVmFbLlHtgBwhIpCPPWWwdag8AdhUnBSy5ClHnSFvren4Fhij+op/B0hfLiOH57cf
         I7IPHE2KkxK7eQ3zkWd3S9KeoU4H/bz/KJcCSf6H4dQb8JH/MZOao+IW3PyyNacIQCZl
         /THQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758800318; x=1759405118;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dxqroIT0bJ4gLlcnSWTcG5okvXIsZwteqLXkgpBpuRM=;
        b=QbfMQxNeG8mDF+LjkMFtToFuEtnCTsePAU9GdYbo4k5HU8Z0Hluq8mEmtjxKXGWx7c
         7U4S454SeUSR4jGczGsN7dDItXx/KsHjf0wSJY/vw5/K+zuaeOHpTBGiEHdxaorhkiw7
         /LN8OqILBuSE20elV7dqzQzV4H8XSlq0DdzFEJa9JLnyfZa4UDPjm/odXmMBZpl1oFYs
         9hhaDN3EzuL3JSbkB4fyll5D4fgd6uiunnL6iNqVKQIDB88XyzzohSnC5VddwA08pBYP
         9+vbJSrqIANHMa9ytxYRoCoBu/JXK3N8NvS7I8+z5u+Ug60FwxVEBJ0ZB8OHW2IemA+g
         d3vg==
X-Forwarded-Encrypted: i=1; AJvYcCXU6MfbUKDBoY2e3DS7Eejj2ET+ikK/MPzSMQaFOiiC7Pzb/h4mxlV8jFh/9UruZ22177A=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnUqZfvFCBiP/MOFrzZ6GJ3OxPzllAqe8v9kFj2lnlU3or2CJc
	gRRISq0lW+iFtJNCF8YpJeVdtN9GhZIdam4g+KZyUofL/TSSMyT0aVaqRPlg9uLs2fTStbmaM2Z
	1Sko0GzDurfJkCwwkZlPaJ4R3h9WZ4Jc=
X-Gm-Gg: ASbGnctpWfZerF889JaJGiEVI2QR4Bt+NmpDStcAJJA4qPWoDxdzWYrXiOP2F9TfAbI
	J82M6Ejfjv9w9I688/TRkw9LEk3nJesFksGttSLybJLUi3txh7PdWGgWaKUtaXnWyMJGPOmARCE
	e5QKRTr262EsD0TILMqsNeTd8LmfD3fws8GY4jhShMRF4rSmiebiLfOR6FsrMlzmskpksKywRC3
	C+bd+DWU9PVsSLtd9E9wRP6Dnxoa2lnBySS2DQs
X-Google-Smtp-Source: AGHT+IEjqFiMZ84yVMmL8aqHzutnqyfPVAvHhHZi1w2Zyv0MzO2zv3PyHq0KNksiUWqn8ZVtvz5/v5ORndsZtS+GvZ0=
X-Received: by 2002:ad4:5742:0:b0:7e4:ee39:738 with SMTP id
 6a1803df08f44-7fc45d03d94mr42335986d6.67.1758800317940; Thu, 25 Sep 2025
 04:38:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250910024447.64788-1-laoar.shao@gmail.com> <20250910024447.64788-3-laoar.shao@gmail.com>
 <CABzRoyaFv4ciJwcdU=1qQNvSWE_PPQonn7ehE7Zz_PHNHfN4gA@mail.gmail.com>
In-Reply-To: <CABzRoyaFv4ciJwcdU=1qQNvSWE_PPQonn7ehE7Zz_PHNHfN4gA@mail.gmail.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Thu, 25 Sep 2025 19:38:01 +0800
X-Gm-Features: AS18NWAPI6UtnnMnTVeKsaXnI6UeT7SK4r6__DsbeZCo6L2UhwRp_pLiTM-6Da0
Message-ID: <CALOAHbA=On41GnxAQOh__5ff20NSCO3bzG6trOd=+tymeJndbg@mail.gmail.com>
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

On Thu, Sep 25, 2025 at 6:06=E2=80=AFPM Lance Yang <lance.yang@linux.dev> w=
rote:
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
>
> I've tested this patch on my machine, and it works as expected. Using BPF
> hooks to control THP is a great step forward!
>
> Tested-by: Lance Yang <lance.yang@linux.dev>

Thanks for your test. I will post a new version ASAP.

>
> This work also inspires some ideas for another useful hook for THP that I
> might propose in the future, once this series is settled and merged ;)

Excited to see it!

--=20
Regards
Yafang

