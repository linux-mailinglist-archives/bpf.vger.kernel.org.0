Return-Path: <bpf+bounces-72105-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DD9FAC06AD6
	for <lists+bpf@lfdr.de>; Fri, 24 Oct 2025 16:22:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF3ED3A8075
	for <lists+bpf@lfdr.de>; Fri, 24 Oct 2025 14:22:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C01FE2046BA;
	Fri, 24 Oct 2025 14:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="ezQP+7u3"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9A371F5827;
	Fri, 24 Oct 2025 14:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761315755; cv=none; b=i0yScdX/rFZLCOKhyBeXyyETHTF4IFtgufwGz8tp7elKSidPZtvOF6JFTTh5pNXGwxvLCW3m3W9OwJb8CWHwPVz1PxWR+gyuuf/5+du8ixvbgtKry/zPz2rmN9oxumLE/zowWhK9blhWPXQ/+FmW1FsfWzEpX0bK8+YKI3Y9cew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761315755; c=relaxed/simple;
	bh=2AIS1AnyVXmYXs2B/o3OhQYHrOJcyrvIst6+oyJcSEA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N/oCYZH7U8erD3OUboltOL0e4TZWDkSHHMJ2aBSXx6ubOX2MxW41Jr+To61TP2a8oE5HcFdtSNmTmKkejDLno32P5+8lQI7gXvWbnTLHgSMDv1KgUCofKkOf9H2Q8ihkfY98aHYyYCC7Oh7NwxRYl3AQKWQ+6HqVEyCCyfWDROI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=ezQP+7u3; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59OBwgYl419537;
	Fri, 24 Oct 2025 07:21:55 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=b/ol2wZmOZszG9k8vxf893BYtcntNjtXKAqt3ZVyZ6M=; b=ezQP+7u3tFEf
	zrYyaDhCkTMVQFov2O0qB6+PQ8nFCiz5xUxgfcMk2tR+A3R95RZzzaKIuV+0udnJ
	CETmgt5bY2oOqy9mzXp4dlGP2sajgZMdyujqwW9Jd3+LwfTJJnmgMKee2hmQcqYr
	WcE4brwFFiA3z7jYttDF5dcSZDq9hbl8VFDOJu5glQxQ96K+O8D1SKa4j6JalBSI
	O5tzYojsleliqP7yWdADgof1zsQg4uANQ8T4e/jCWi4UAfCyP24qMqFgbZnB9oHV
	Z2N/UdAhoSxb1Rht4AfWxZvy79778q+JYsFec/by5KkZgF6k0yclfpMdaDfD7DNN
	vDn6vxt7NQ==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4a09288x7k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Fri, 24 Oct 2025 07:21:55 -0700 (PDT)
Received: from devbig091.ldc1.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c08b:78::c78f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.20; Fri, 24 Oct 2025 14:21:52 +0000
From: Chris Mason <clm@meta.com>
To: Vlastimil Babka <vbabka@suse.cz>
CC: Chris Mason <clm@meta.com>, Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@gentwo.org>,
        David Rientjes <rientjes@google.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Harry Yoo <harry.yoo@oracle.com>, Uladzislau Rezki <urezki@gmail.com>,
        "Liam R. Howlett"
	<Liam.Howlett@oracle.com>,
        Suren Baghdasaryan <surenb@google.com>,
        "Sebastian
 Andrzej Siewior" <bigeasy@linutronix.de>,
        Alexei Starovoitov
	<ast@kernel.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <linux-rt-devel@lists.linux.dev>,
        <bpf@vger.kernel.org>, <kasan-dev@googlegroups.com>
Subject: Re: [PATCH RFC 02/19] slab: handle pfmemalloc slabs properly with sheaves
Date: Fri, 24 Oct 2025 07:21:35 -0700
Message-ID: <20251024142137.739555-1-clm@meta.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251023-sheaves-for-all-v1-2-6ffa2c9941c0@suse.cz>
References:
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI0MDEyOCBTYWx0ZWRfXwTD/VmjTrZA6
 JRMZKrwqksV2xp1yhJWxwn6gzdqQ6FLs2fQ0eb7xBONuzcwgzrrSURnRmWBCizGKI+13LbnEIl4
 ylNtvCoS+qc8ZaNrun/2WUn50FZBKyvgRCtxu011MC4I60o1A0gUQr7LQe1DnOC1f19Mw9W27VB
 MlWsAS28QxLMenEBX7/purq6SIW3f2Ls4I6uC6IrLhRbaN7uAosLW6+sFcqB5q5bySPDl5GzzE5
 R9gNXo0vhN4ZummzWu1+T3C/Fckz++HJCysc3xdveEplf4WxEoLA0JxvzvfFP6keHpZ+LjYmoHz
 lUK8NtClWc9hhIyXgA6umSdgtc7sWHlWqXnnspAxBWh4MhmjJc8arJC6lHS0Uji0i8FsmPJ+NE1
 uMZWCoJMv2b3asDyr7V0u3Kf1VWvBQ==
X-Proofpoint-GUID: 1v7_B19uZD_UKIAK3zHZIbCsxtzfqkFk
X-Authority-Analysis: v=2.4 cv=aK79aL9m c=1 sm=1 tr=0 ts=68fb8b83 cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=PCJbmnWxFXnHO1kFQDsA:9
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: 1v7_B19uZD_UKIAK3zHZIbCsxtzfqkFk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-24_02,2025-10-22_01,2025-03-28_01

On Thu, 23 Oct 2025 15:52:24 +0200 Vlastimil Babka <vbabka@suse.cz> wrote:

> When a pfmemalloc allocation actually dips into reserves, the slab is
> marked accordingly and non-pfmemalloc allocations should not be allowed
> to allocate from it. The sheaves percpu caching currently doesn't follow
> this rule, so implement it before we expand sheaves usage to all caches.
> 
> Make sure objects from pfmemalloc slabs don't end up in percpu sheaves.
> When freeing, skip sheaves when freeing an object from pfmemalloc slab.
> When refilling sheaves, use __GFP_NOMEMALLOC to override any pfmemalloc
> context - the allocation will fallback to regular slab allocations when
> sheaves are depleted and can't be refilled because of the override.
> 
> For kfree_rcu(), detect pfmemalloc slabs after processing the rcu_sheaf
> after the grace period in __rcu_free_sheaf_prepare() and simply flush
> it if any object is from pfmemalloc slabs.
> 
> For prefilled sheaves, try to refill them first with __GFP_NOMEMALLOC
> and if it fails, retry without __GFP_NOMEMALLOC but then mark the sheaf
> pfmemalloc, which makes it flushed back to slabs when returned.
>

Hi Vlastimil,

We're trying out the AI patch review automation on the BPF commits and it had
some questions about a few of these.  Since the goal is to actually test the
automation, I'm putting them in unedited, but I did try and make sure they
were valid before sending.

For this one, I'm not sure if the behavior AI is flagging is intentional or
not, so it feels like a reasonable question to me at least:

> diff --git a/mm/slub.c b/mm/slub.c
> index 4731b9e461c2..ab03f29dc3bf 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c

[ ... ]

> @@ -5331,6 +5340,26 @@ void *kmem_cache_alloc_node_noprof(struct kmem_cache *s, gfp_t gfpflags, int nod
>  }
>  EXPORT_SYMBOL(kmem_cache_alloc_node_noprof);
>
> +static int __prefill_sheaf_pfmemalloc(struct kmem_cache *s,
> +				      struct slab_sheaf *sheaf, gfp_t gfp)
> +{
> +	int ret = 0;
> +
> +	ret = refill_sheaf(s, sheaf, gfp | __GFP_NOMEMALLOC);
> +
> +	if (likely(!ret || !gfp_pfmemalloc_allowed(gfp)))
> +		return ret;
> +
> +	/*
> +	 * if we are allowed to, refill sheaf with pfmemalloc but then remember
> +	 * it for when it's returned
> +	 */
> +	ret = refill_sheaf(s, sheaf, gfp);
> +	sheaf->pfmemalloc = true;
> +
> +	return ret;
> +}

[ ... ]

> @@ -5497,7 +5528,7 @@ int kmem_cache_refill_sheaf(struct kmem_cache *s, gfp_t gfp,
>
>  	if (likely(sheaf->capacity >= size)) {
>  		if (likely(sheaf->capacity == s->sheaf_capacity))
> -			return refill_sheaf(s, sheaf, gfp);
> +			return __prefill_sheaf_pfmemalloc(s, sheaf, gfp);
>
>  		if (!__kmem_cache_alloc_bulk(s, gfp, sheaf->capacity - sheaf->size,
>  					     &sheaf->objects[sheaf->size])) {
                                             ^^^

In kmem_cache_refill_sheaf(), does the oversize sheaf path (when
sheaf->capacity != s->sheaf_capacity) need __GFP_NOMEMALLOC too?

The commit message says "When refilling sheaves, use __GFP_NOMEMALLOC
to override any pfmemalloc context", and the normal capacity path now
calls __prefill_sheaf_pfmemalloc() which adds __GFP_NOMEMALLOC.

But this oversize path still calls __kmem_cache_alloc_bulk() with the
raw gfp flags. If the calling context is pfmemalloc-enabled (e.g.,
during swap or network operations), could pfmemalloc objects be
allocated into the sheaf? Those objects would then be returned via
kmem_cache_alloc_from_sheaf() to potentially non-pfmemalloc callers.

Similar issue exists in kmem_cache_prefill_sheaf() for the oversize
path at the function's start, though that code wasn't modified by this
patch.

>  			return -ENOMEM;
>  		}
>  		sheaf->size = sheaf->capacity;

[ ... ]



