Return-Path: <bpf+bounces-72118-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 16FF6C06FC9
	for <lists+bpf@lfdr.de>; Fri, 24 Oct 2025 17:33:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4CDEF3B9719
	for <lists+bpf@lfdr.de>; Fri, 24 Oct 2025 15:30:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC3AF2C21EF;
	Fri, 24 Oct 2025 15:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="u1H8joWQ"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 989C826E16E;
	Fri, 24 Oct 2025 15:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761319811; cv=none; b=mNAYMLjWzi5zR8sI8+1XFU0W3jEoRnuxyzcS/wMV0tczuLyXZ9ECByq2nDymR2vbezY7FU+yMZMlvEbYCmKujV4oluN/rS/b0ljzdnUDNZs90+jSofoUtasWuCxAEEwyorSdi217AoYETuFS7t0oehVI6Gn92xhHtBDNWIogD6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761319811; c=relaxed/simple;
	bh=xgEHwFgWaca40F8wGyBUFn8xI4qBVKtnd8Q7QUCNcqI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RLMeJmsrzpbE4fOGY8t0PEGnov6y06yDdQcN4KCvEagNWJGBiOH4zxzVrd6S2WLBJMlbjbvRNWYYeIDwe/22Xywa/cgBPe8eYmLGtnbHciO21AfP3WoVilsi7UK0iS38c/uTXpeLDXeOAPFPRYje0Sa0gsfi5QiOe8dExzbdvig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=u1H8joWQ; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
	by m0001303.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 59OE2RhP2211218;
	Fri, 24 Oct 2025 08:29:42 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=JYg1vP9W9v0SXXkTSNQM/3alSk45Op1+j7AlOwvEtcM=; b=u1H8joWQSvKP
	lsrsEERu6cI1x3A5mfYS1zL8z0TQ0khpcMO8oYoKKD8h7+McjWX/ktRh8T6OlVd7
	YTYfYTTlFhlbaEQxQ089POCXDGW4O4ZiFd2+HPGFe8v+yA9+5tITFlTOMM2QswD0
	VpUEdNRVGQdCV9aikoHsmDQz2VGUO5389kHXGxz0TnWP8qKuS0sG6TTGir/ES96V
	H2xX4fayiv6t2blL54E3ElLvGNPYJyjqq481ODsOAu1/biqcHXXU3LECt5+qHjhO
	SVER6vuEUb3vlKr76lyqRFBGrbkBT5ZmPfENEG/Igm50m98ee4vYpQFalDF+f+S/
	E+f1ht3MRA==
Received: from mail.thefacebook.com ([163.114.134.16])
	by m0001303.ppops.net (PPS) with ESMTPS id 49yxkh4c3r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Fri, 24 Oct 2025 08:29:42 -0700 (PDT)
Received: from devbig091.ldc1.facebook.com (2620:10d:c085:208::7cb7) by
 mail.thefacebook.com (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.20; Fri, 24 Oct 2025 15:29:40 +0000
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
Subject: Re: [PATCH RFC 06/19] slab: introduce percpu sheaves bootstrap
Date: Fri, 24 Oct 2025 08:29:09 -0700
Message-ID: <20251024152913.1115220-1-clm@meta.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251023-sheaves-for-all-v1-6-6ffa2c9941c0@suse.cz>
References:
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: kkk2s3qprms9Z7I2EC8CkdtQeZfZNQk7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI0MDEzOSBTYWx0ZWRfX7OIXVkMX9geX
 7pzjGpPRSpFcTx7fX8n9LXsYKQ3g0QZRGy/YPxIO393qaVutmBVwI5lA7gFo2Q5Hwa8+P741e63
 xa6tJDDXt4JLNHQXxoIcH9J3r2OhtgnPlM4/Dr6jsPRXB1oEw/kPigXQ63CZR62E3oWIRwP92bI
 Uyw/Rir17bhjlbv9m3LRbTZKG10KB7hH/N6P1EqnkT0Cqw/05VrvLihNzZyUp7LDWbJDlLeGXcc
 H/V7buo1lPWg9avwKIjQpsh4ufOJ0RbDY3XF7efzaPcvEl+kxGuwx0N75gZk9lfpaNVUS9+08yq
 tCSqvOvqHCgRAFoEYuICfiy9uaKRTDvTQ2t2EAEZ5GLOUuAXhopMjOObCyRbGyHI7KdUgqT79Bs
 +PdwDPQk/r7OGlJSV6buVYTVGDTVHg==
X-Authority-Analysis: v=2.4 cv=RqHI7SmK c=1 sm=1 tr=0 ts=68fb9b66 cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=7e5GxzTNbid4F3B1EgkA:9
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: kkk2s3qprms9Z7I2EC8CkdtQeZfZNQk7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-24_02,2025-10-22_01,2025-03-28_01

On Thu, 23 Oct 2025 15:52:28 +0200 Vlastimil Babka <vbabka@suse.cz> wrote:

> Until now, kmem_cache->cpu_sheaves was !NULL only for caches with
> sheaves enabled. Since we want to enable them for almost all caches,
> it's suboptimal to test the pointer in the fast paths, so instead
> allocate it for all caches in do_kmem_cache_create(). Instead of testing
> the cpu_sheaves pointer to recognize caches (yet) without sheaves, test
> kmem_cache->sheaf_capacity for being 0, where needed.
> 
> However, for the fast paths sake we also assume that the main sheaf
> always exists (pcs->main is !NULL), and during bootstrap we cannot
> allocate sheaves yet.
> 
> Solve this by introducing a single static bootstrap_sheaf that's
> assigned as pcs->main during bootstrap. It has a size of 0, so during
> allocations, the fast path will find it's empty. Since the size of 0
> matches sheaf_capacity of 0, the freeing fast paths will find it's
> "full". In the slow path handlers, we check sheaf_capacity to recognize
> that the cache doesn't (yet) have real sheaves, and fall back. Thus
> sharing the single bootstrap sheaf like this for multiple caches and
> cpus is safe.
>

Hi Vlastimil,

We're trying out the AI patch review automation on the BPF commits and it had
some questions about a few of these.  Since the goal is to actually test the
automation, I'm putting them in unedited, but I did try and make sure they
were valid before sending.

> diff --git a/mm/slub.c b/mm/slub.c
> index a6e58d3708f4..ecb10ed5acfe 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c

[ ... ]

> @@ -7733,8 +7782,7 @@ static void free_kmem_cache_nodes(struct kmem_cache *s)
>  void __kmem_cache_release(struct kmem_cache *s)
>  {
>  	cache_random_seq_destroy(s);
> -	if (s->cpu_sheaves)
> -		pcs_destroy(s);
> +	pcs_destroy(s);

Can pcs_destroy() handle a NULL cpu_sheaves pointer? Looking at the
error path in do_kmem_cache_create():

    s->cpu_sheaves = alloc_percpu(struct slub_percpu_sheaves);
    if (!s->cpu_sheaves) {
        err = -ENOMEM;
        goto out;
    }
    ...
    out:
        if (err)
            __kmem_cache_release(s);

If alloc_percpu() fails, __kmem_cache_release() now calls pcs_destroy()
unconditionally. In pcs_destroy(), the first operation is:

    for_each_possible_cpu(cpu) {
        pcs = per_cpu_ptr(s->cpu_sheaves, cpu);

Does per_cpu_ptr() dereference s->cpu_sheaves when it's NULL?

>  #ifdef CONFIG_PREEMPT_RT
>  	if (s->cpu_slab)
>  		lockdep_unregister_key(&s->lock_key);

[ ... ]

> @@ -8608,12 +8656,10 @@ int do_kmem_cache_create(struct kmem_cache *s, const char *name,
>
>  	set_cpu_partial(s);
>
> -	if (s->sheaf_capacity) {
> -		s->cpu_sheaves = alloc_percpu(struct slub_percpu_sheaves);
> -		if (!s->cpu_sheaves) {
> -			err = -ENOMEM;
> -			goto out;
> -		}
> +	s->cpu_sheaves = alloc_percpu(struct slub_percpu_sheaves);
> +	if (!s->cpu_sheaves) {
> +		err = -ENOMEM;
> +		goto out;
>  	}

This error path triggers the call chain: do_kmem_cache_create() error
path -> __kmem_cache_release() -> pcs_destroy() with NULL cpu_sheaves.



