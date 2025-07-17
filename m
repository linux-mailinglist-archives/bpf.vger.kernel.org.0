Return-Path: <bpf+bounces-63627-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C2E8B0914C
	for <lists+bpf@lfdr.de>; Thu, 17 Jul 2025 18:06:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E881165A87
	for <lists+bpf@lfdr.de>; Thu, 17 Jul 2025 16:06:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 647902F8C33;
	Thu, 17 Jul 2025 16:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hTBn7jKw"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4785935963
	for <bpf@vger.kernel.org>; Thu, 17 Jul 2025 16:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752768379; cv=none; b=pmQgF8Xg0s6E7D5GzyeLmP8YSXV6+3Z7GjKFAIOZEAm2H1HI3Vt9L3paG9GgpelSWOram6G4eIUFhXI47J0K2ACc84JLOIleuVhUbMdFsqcjpuCW5jtlGVahbT4mWer+r/KD0IQ5mlaabShpvi7x3BjmwPQL2Qr4RVaqINgwDYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752768379; c=relaxed/simple;
	bh=y1JBSNE0c9PX/Z/pEbZck+65KwM3iDWR2EfPVREX5so=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z+pb6nUrLXQUYOJdwsN3R5oJsf5b1XBImcFJErdaM7sga8alH/CnpnebqotVgzk5Q7FV7B+X84V5QXQoSS2u5YVf5bkkR/DZQi0AV6+7d0sZF+gxhWaeC5fExklMLAXheBVA8KsSV9l7Vqe5uZaKw66BcAAs/2OD+E1qEKX94zI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hTBn7jKw; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-ae3b336e936so222476966b.3
        for <bpf@vger.kernel.org>; Thu, 17 Jul 2025 09:06:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752768376; x=1753373176; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oNaOhocBhBO7oI/BRKzs2RUfkmKsF3Hfw+nSdB03cjI=;
        b=hTBn7jKwNXiAkxmnJN/Uf5QbEbKJz1fXNGqvZJjHri5txkC9Et6/Fb7o/e0tVxPMTL
         6mWmW4CMtwP8TBw6D2is7wx6kO+z+kVEeH2ARwC1+uZyswVJwWPWHy5neUm4NsafIAWv
         WXvwmNaR1IsMIVjSWlY7H8rSHz78UsL6pi+dix+TCKnLY0elzqfh28SVPHOO3sxvjvLS
         0UXiwhZ0q8znEapx76UQvZAVnQlWgBQUjf+fDwhswz5Y+5LUqGi2dEG/9/mwY4gMM2sV
         O4/uw/tpp91VLxXaFoEUlBVzWcGoZaDBmM5YoynKsV5xDRxfzLyqF/iA5Rl1jlrlHsmm
         sp8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752768376; x=1753373176;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oNaOhocBhBO7oI/BRKzs2RUfkmKsF3Hfw+nSdB03cjI=;
        b=T+YqpVNDzqFQfBWZnos/YJeBQqDJL5bRXIAILdRvuITniQJ/L9zP7GvM/dXeNHQ20E
         aGTU+CxCbr1+LzLnfFt9OJnmcDM8W4w2ig6geG1tKqS7luIdyMHElM7en6K4GpFavhs8
         HqDekkTuN/13ERm00/JOp1+O9VH4Mrg0eUkPFjgbiOysD/aSR59G65iW//SRByGt59g1
         /ogD81gC3+JaxV/JZxq0c/QrgPYV0Cid4v0P+dZx/H5tVso0O6rvhoVqBywktaca4IBQ
         gmA0Yf5uLB3yITZ+MiOaSL3HCb9if3xmAraPHDs2wA2kWEueqWrBYaIWloMig0Uf1dpP
         XlTQ==
X-Gm-Message-State: AOJu0Yw6HG0M0LZwOyx5VRjOe5N1jTJ1j06CcB0jQis9hs7lsywOUhG8
	JS5ZpPhtG4ljCwnvPZo7MZQiv5HRzgBb/YcCWzz7RjujCjMDurM9QvMf
X-Gm-Gg: ASbGncu23vVsM0ShhAgtKFQf2mU+eRJPwyBIpvMnK4CKn7OfI3VooPI+tC7IaIbve4H
	NtbBTMysfBvepTpdcIFi5Y4PQlB+lGqgLzvU3SLLYoDxGW+P9mPFoLkkOMGZFv9lDWWYwadDbCm
	RNCFgRyFfUkDQFfqWVarqmN0McCsX+nlFOC5mWGPV6hj5P4ae5yTJ/+FWSTQkBopS9hxh9Vngxe
	i1ca/4vDb48pC/Hmbr9oyYSpYCAyf/3XJUnD0B76Umsg5ROBETXAXVKFnNEDBjdOpjkXWjbpK5r
	3wXEf0XhoUfzQbX79/afmI57LUHtX9NH40ObBzlj7GVN0BW80joxKdfyDViJVHaYs1nHcn14PyJ
	eK9nAzx/98dLMtHa4NVkTVK3fnGCjRe8K0iibjCP9uos7zu0ZcyjADNUA9uMtq/ggbz0icF8=
X-Google-Smtp-Source: AGHT+IH9CzyZmBVApG7N+ZEw636FiE9i07oBG0nCBOE6sQ50A3+ug0R3b3rY6Mdv5LgNbnlVIDVIGg==
X-Received: by 2002:a17:907:d504:b0:ae0:b717:746b with SMTP id a640c23a62f3a-ae9ce2003demr758011366b.61.1752768376198;
        Thu, 17 Jul 2025 09:06:16 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1126:4:14f1:c189:9748:5e5a? ([2620:10d:c092:500::7:8a92])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae6e7e9118dsm1371641166b.21.2025.07.17.09.06.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Jul 2025 09:06:15 -0700 (PDT)
Message-ID: <f37a0f14-9185-4ebd-aa2f-39d377902a89@gmail.com>
Date: Thu, 17 Jul 2025 17:06:12 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 3/5] mm, thp: add bpf thp hook to determine thp
 reclaimer
To: Yafang Shao <laoar.shao@gmail.com>, akpm@linux-foundation.org,
 david@redhat.com, ziy@nvidia.com, baolin.wang@linux.alibaba.com,
 lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, npache@redhat.com,
 ryan.roberts@arm.com, dev.jain@arm.com, hannes@cmpxchg.org,
 gutierrez.asier@huawei-partners.com, willy@infradead.org, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org
Cc: bpf@vger.kernel.org, linux-mm@kvack.org
References: <20250608073516.22415-1-laoar.shao@gmail.com>
 <20250608073516.22415-4-laoar.shao@gmail.com>
Content-Language: en-US
From: Usama Arif <usamaarif642@gmail.com>
In-Reply-To: <20250608073516.22415-4-laoar.shao@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 08/06/2025 08:35, Yafang Shao wrote:
> A new hook, bpf_thp_gfp_mask(), is introduced to determine whether memory
> reclamation is being performed by the current task or by kswapd.
> 
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> ---
>  include/linux/huge_mm.h | 5 +++++
>  mm/huge_memory.c        | 5 +++++
>  2 files changed, 10 insertions(+)
> 
> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> index db2eadd3f65b..6a40ebf25f5c 100644
> --- a/include/linux/huge_mm.h
> +++ b/include/linux/huge_mm.h
> @@ -198,6 +198,11 @@ static inline int bpf_thp_allocator(unsigned long vm_flags,
>  	return THP_ALLOC_KHUGEPAGED | THP_ALLOC_CURRENT;
>  }
>  
> +static inline gfp_t bpf_thp_gfp_mask(bool vma_madvised)
> +{
> +	return 0;
> +}
> +
>  static inline int highest_order(unsigned long orders)
>  {
>  	return fls_long(orders) - 1;
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index d3e66136e41a..81c1711d13fa 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -1280,6 +1280,11 @@ static vm_fault_t __do_huge_pmd_anonymous_page(struct vm_fault *vmf)
>  gfp_t vma_thp_gfp_mask(struct vm_area_struct *vma)
>  {
>  	const bool vma_madvised = vma && (vma->vm_flags & VM_HUGEPAGE);
> +	gfp_t gfp_mask;
> +
> +	gfp_mask = bpf_thp_gfp_mask(vma_madvised);


I am guessing bpf_thp_gfp_mask returns 0, as its something yet to be implemented, 
but I really dont understand what this patch is supposed to do.


> +	if (gfp_mask)
> +		return gfp_mask;
>  
>  	/* Always do synchronous compaction */
>  	if (test_bit(TRANSPARENT_HUGEPAGE_DEFRAG_DIRECT_FLAG, &transparent_hugepage_flags))


