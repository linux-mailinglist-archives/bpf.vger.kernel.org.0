Return-Path: <bpf+bounces-65891-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 42972B2AB75
	for <lists+bpf@lfdr.de>; Mon, 18 Aug 2025 16:48:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E41D18A67D5
	for <lists+bpf@lfdr.de>; Mon, 18 Aug 2025 14:40:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8060A3112AE;
	Mon, 18 Aug 2025 14:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mt+7xKYN"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 206393101B1
	for <bpf@vger.kernel.org>; Mon, 18 Aug 2025 14:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755527741; cv=none; b=FPWEcud86rS5qIBInThz2y5eD3Wyj5tXtDnKGbruLCSRmN2YbLSkgk7ICh5CVNKuW8BreKtif4UtZj+r8DFQ9Yjdh2i411SpQ77ARRdrUTGX8amCCCppLO7OcRCK0t/u4lGXzOUieIQ702CTsilpHBzsIOv+dcpVal7QdGwXZBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755527741; c=relaxed/simple;
	bh=HFBo7hdMQ1KDbJoP8ilsLuZLyXy7+SYKfk/dXE1xyz8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XOBMxo9zQH4cL3WFFBFQ5TlVpbvxgYLCPKzUxaqbfQuaKdncrd/D4fEnJFZcAs46JG6M/UuhMDo+ix7Xhatb49yNZUB2l+CsQ11Ppi7TV3Conb1fR0xK+QVhzqIKR/9C1Z/aCGkU7jhiV9tjLCXnbaM2hNMOR99yDAQLh89e6ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mt+7xKYN; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3b9d41c1963so2050567f8f.0
        for <bpf@vger.kernel.org>; Mon, 18 Aug 2025 07:35:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755527737; x=1756132537; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=y3e5kfEUDKfGYIXxIjzYAU/86sxkzjQ1VNlVdUi79RM=;
        b=mt+7xKYNjaX64mRi4aYmlIUS2Az2cXBLH8nv1BAFKXj4+Odf+9Zs6S0CBqnFAr7m+H
         nrKShwYxn90HJ5QZ9Qz9Z5UTXmWSSuCWch/exG4//Kjzqt5p8cSphi+At3wHsG2HeZuB
         DI0Z09XraA0SiwexS2RtkrziU74qt3UhZK6+1FUbonWo9Qk+U0W5z3TtfuELACfkM0YB
         EYGhX511MILjmtEDEXRmUqVjvS9/nSe7OkOA08Xj8ZGRu/X8y89mC09S2IGvjsIEJdi2
         MJq3ZfrzdlXs42SypWk3jz52RTFypVLMzPsLglrRYCIi9mzSXhIJVyIst5FF0OmIOC1F
         P1jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755527737; x=1756132537;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y3e5kfEUDKfGYIXxIjzYAU/86sxkzjQ1VNlVdUi79RM=;
        b=rN5k6pED/N59mjKZUwYIL7rJtP448IYy9en6B6QJirl1mog2sUn9Wsl35OiCWAY9Px
         /19TPPfyyGpZ0Xl+k8Za8YU7YWMrr+sZ1lbq8k0fonkWYczB47S8m91FJUS5gfGxk69y
         MOmHBw6izXK17I6YUGCyTpPHBPWViuqOxXbi2XTQcJhn5T8lKspiY+ZgBATz9NI+Gm6T
         g0XSzlQKJpNupQZOxXi3gdAjKhQPW4sbPSsmfO6iJ4Utse7dotY8tP06+JCjtAh3yS8W
         19Sr6uzqDfHvKd2Qrjl9uNehZAtGDgZa8k8UlUAvo9PliEqusEcjEqBs8iKc8kx0ebcq
         9/uw==
X-Gm-Message-State: AOJu0YzNsWi+ERc7TITrkJCvWlawqBtBuifxrYP/wTaT4GLFLXxzI8ak
	gXqZ79ox1TdDn6ppSabvO/ekmfra1mGM7kJoBRWcuUe8CHHgPT7zAzQJ
X-Gm-Gg: ASbGncuzzV9FwFl1+lItEogVe1qmvBW560tD3cmEyvnauX+1hlZLvo7Rh4uK9Gun99Z
	mMvOAyHfQfINa21fxvolohTBLiD9tNmyyIZWdaNFZA8qkeylsVdV4/SRVYqIBJb7tBoYXYQQXSA
	Vd9yOiSqYMDtw8mo9PTrEu1vFYbO5U/oklzqG4y5CQOqI/wCtvM9SL7OytM2OaSE2XWGhFscGzL
	zxW6uH8YsMpSNN732P5wvOMktW1zwuOHo2F1cKEIaFCd8tjZiTJLhoMuBABYstT9fPZyEQRiBI+
	EvbOLH+uV5iVXUnSh9nWI4y2wtp14RMjbBuyWd6+SYm77rozf9wct54pFSfVxRxrysdHfsXIisI
	53hFcwbdOjTbHbls/hKNA7PVxerEdPtXGa7QL5tIkZZwNNY0OFk2Jvu2TFcgxhlhtl9CmRHU=
X-Google-Smtp-Source: AGHT+IGd4KB5hN6IAjw7Zw7PYXI04wFRsSFFB1xN3zkVuWTsabwKlquBZCHv4Fnsn+ONVvTIZmyzEw==
X-Received: by 2002:a05:6000:24c4:b0:3b7:644f:9ca7 with SMTP id ffacd0b85a97d-3bc694261a0mr6819966f8f.25.1755527737051;
        Mon, 18 Aug 2025 07:35:37 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1126:4:14f1:c189:9748:5e5a? ([2620:10d:c092:500::5:7223])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3bb68079341sm12856749f8f.50.2025.08.18.07.35.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Aug 2025 07:35:36 -0700 (PDT)
Message-ID: <36c97fc6-eaa9-44dd-a52f-0b6bf5a001d9@gmail.com>
Date: Mon, 18 Aug 2025 15:35:32 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v5 mm-new 0/5] mm, bpf: BPF based THP order selection
To: Yafang Shao <laoar.shao@gmail.com>, akpm@linux-foundation.org,
 david@redhat.com, ziy@nvidia.com, baolin.wang@linux.alibaba.com,
 lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, npache@redhat.com,
 ryan.roberts@arm.com, dev.jain@arm.com, hannes@cmpxchg.org,
 gutierrez.asier@huawei-partners.com, willy@infradead.org, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, ameryhung@gmail.com,
 rientjes@google.com
Cc: bpf@vger.kernel.org, linux-mm@kvack.org
References: <20250818055510.968-1-laoar.shao@gmail.com>
Content-Language: en-US
From: Usama Arif <usamaarif642@gmail.com>
In-Reply-To: <20250818055510.968-1-laoar.shao@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 18/08/2025 06:55, Yafang Shao wrote:
> Background
> ----------
> 
> Our production servers consistently configure THP to "never" due to
> historical incidents caused by its behavior. Key issues include:
> - Increased Memory Consumption
>   THP significantly raises overall memory usage, reducing available memory
>   for workloads.
> 
> - Latency Spikes
>   Random latency spikes occur due to frequent memory compaction triggered
>   by THP.
> 
> - Lack of Fine-Grained Control
>   THP tuning is globally configured, making it unsuitable for containerized
>   environments. When multiple workloads share a host, enabling THP without
>   per-workload control leads to unpredictable behavior.
> 
> Due to these issues, administrators avoid switching to madvise or always
> modes—unless per-workload THP control is implemented.
> 
> To address this, we propose BPF-based THP policy for flexible adjustment.
> Additionally, as David mentioned [0], this mechanism can also serve as a
> policy prototyping tool (test policies via BPF before upstreaming them).

Hi Yafang,

A few points:

The link [0] is mentioned a couple of times in the coverletter, but it doesnt seem
to be anywhere in the coverletter.

I am probably missing something over here, but the current version won't accomplish
the usecase you have described at the start of the coverletter and are aiming for, right?
i.e. THP global policy "never", but get hugepages on an madvise or always basis.
I think there was a new THP mode introduced in some earlier revision where you can switch to it
from "never" and then you can use bpf programs with it, but its not in this revision?
It might be useful to add your specific usecase as a selftest.

Do we have some numbers on what the overhead of calling the bpf program is in the
pagefault path as its a critical path?

I remember there was a discussion on this in the earlier revisions, and I have mentioned this in patch 1
as well, but I think making this feature experimental with warnings might not be a great idea.
It could lead to 2 paths:
- people don't deploy this in their fleet because its marked as experimental and they dont want
their machines to break once they upgrade the kernel and this is changed. We will have a difficult
time improving upon this as this is just going to be used for prototyping and won't be driven by
production data.
- people are careless and deploy it in on their production machines, and you get reports that this
has broken after kernel upgrades (despite being marked as experimental :)).
This is just my opinion (which can be wrong :)), but I think we should try and have this merged
as a stable interface that won't change. There might be bugs reported down the line, but I am hoping
we can get the interface of get_suggested_order right in the first implementation that gets merged? 


Thanks!
Usama> 
> Proposed Solution
> -----------------
> 
> As suggested by David [0], we introduce a new BPF interface:
> 
> /**
>  * @get_suggested_order: Get the suggested THP orders for allocation
>  * @mm: mm_struct associated with the THP allocation
>  * @vma__nullable: vm_area_struct associated with the THP allocation (may be NULL)
>  *                 When NULL, the decision should be based on @mm (i.e., when
>  *                 triggered from an mm-scope hook rather than a VMA-specific
>  *                 context).
>  *                 Must belong to @mm (guaranteed by the caller).
>  * @vma_flags: use these vm_flags instead of @vma->vm_flags (0 if @vma is NULL)
>  * @tva_flags: TVA flags for current @vma (-1 if @vma is NULL)
>  * @orders: Bitmask of requested THP orders for this allocation
>  *          - PMD-mapped allocation if PMD_ORDER is set
>  *          - mTHP allocation otherwise
>  *
>  * Rerurn: Bitmask of suggested THP orders for allocation. The highest
>  *         suggested order will not exceed the highest requested order
>  *         in @orders.
>  */
>  int (*get_suggested_order)(struct mm_struct *mm, struct vm_area_struct *vma__nullable,
> 			    u64 vma_flags, enum tva_type tva_flags, int orders) __rcu;
> 
> This interface:
> - Supports both use cases (per-workload tuning + policy prototyping).
> - Can be extended with BPF helpers (e.g., for memory pressure awareness).
> 
> This is an experimental feature. To use it, you must enable
> CONFIG_EXPERIMENTAL_BPF_ORDER_SELECTION.
> 
> Warning:
> - The interface may change
> - Behavior may differ in future kernel versions
> - We might remove it in the future
> 
> A simple test case is included in Patch #4.
> 
> Future work:
> - Extend it to File THP
> 
> Changes:
> RFC v4->v5:
> - Add support for vma (David)
> - Add mTHP support in khugepaged (Zi)
> - Use bitmask of all allowed orders instead (Zi)
> - Retrieve the page size and PMD order rather than hardcoding them (Zi)
> 
> RFC v3->v4: https://lwn.net/Articles/1031829/
> - Use a new interface get_suggested_order() (David)
> - Mark it as experimental (David, Lorenzo)
> - Code improvement in THP (Usama)
> - Code improvement in BPF struct ops (Amery)
> 
> RFC v2->v3: https://lwn.net/Articles/1024545/
> - Finer-graind tuning based on madvise or always mode (David, Lorenzo)
> - Use BPF to write more advanced policies logic (David, Lorenzo)
> 
> RFC v1->v2: https://lwn.net/Articles/1021783/
> The main changes are as follows,
> - Use struct_ops instead of fmod_ret (Alexei)
> - Introduce a new THP mode (Johannes)
> - Introduce new helpers for BPF hook (Zi)
> - Refine the commit log
> 
> RFC v1: https://lwn.net/Articles/1019290/
> Yafang Shao (5):
>   mm: thp: add support for BPF based THP order selection
>   mm: thp: add a new kfunc bpf_mm_get_mem_cgroup()
>   mm: thp: add a new kfunc bpf_mm_get_task()
>   bpf: mark vma->vm_mm as trusted
>   selftest/bpf: add selftest for BPF based THP order seletection
> 
>  include/linux/huge_mm.h                       |  15 +
>  include/linux/khugepaged.h                    |  12 +-
>  kernel/bpf/verifier.c                         |   5 +
>  mm/Kconfig                                    |  12 +
>  mm/Makefile                                   |   1 +
>  mm/bpf_thp.c                                  | 269 ++++++++++++++++++
>  mm/huge_memory.c                              |  10 +
>  mm/khugepaged.c                               |  26 +-
>  mm/memory.c                                   |  18 +-
>  tools/testing/selftests/bpf/config            |   3 +
>  .../selftests/bpf/prog_tests/thp_adjust.c     | 224 +++++++++++++++
>  .../selftests/bpf/progs/test_thp_adjust.c     |  76 +++++
>  .../bpf/progs/test_thp_adjust_failure.c       |  25 ++
>  13 files changed, 689 insertions(+), 7 deletions(-)
>  create mode 100644 mm/bpf_thp.c
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/thp_adjust.c
>  create mode 100644 tools/testing/selftests/bpf/progs/test_thp_adjust.c
>  create mode 100644 tools/testing/selftests/bpf/progs/test_thp_adjust_failure.c
> 


