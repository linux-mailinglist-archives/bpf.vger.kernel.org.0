Return-Path: <bpf+bounces-72107-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E0A3C06B30
	for <lists+bpf@lfdr.de>; Fri, 24 Oct 2025 16:30:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 099061C04AED
	for <lists+bpf@lfdr.de>; Fri, 24 Oct 2025 14:30:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ECC031A7FB;
	Fri, 24 Oct 2025 14:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="lNiDEF6C"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5227C313552;
	Fri, 24 Oct 2025 14:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761316208; cv=none; b=Hxyo0WprC0EALul//gW1s3D2pUG3Lotp+JWPaADPy9xqaHnfsWJzDv8tkqFQHJdOFHxcSaUSaoj15U++2FZ3BCeLXVMHsNvEpYnLVQCJTW+HsnT5iNIdtxy9/dcq+366rr1d/U7zSm7LTll3DYFAySQ/h3Kf1OI1XPQz4lKXenU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761316208; c=relaxed/simple;
	bh=sXzz58hqxduSzGRDh3mLu3YJJIeqMSKkD/Imsf7uYNQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MFSepCTZnBDkRZlrnaisuz0EV50vSrZhDF5npimdpz6qwHIQop28Wzc6Hj588tDrghBGmZ4G/WBbFFuslFhZOhi1ccdEjHQK49cdOs30krcnE29VfhNyGzRi/25qoQeKPb+3TAuX68L8SQ6fevJ3IB+fCuYdKpIzq8pB+C5JGOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=lNiDEF6C; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59O2UEjG1836665;
	Fri, 24 Oct 2025 07:29:45 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=6/h0G3p+CogW+KUD4A3h3rSaunnYLJugMgdAj9+txKM=; b=lNiDEF6CSP20
	iTsKdShjwOWG080Ql4m0WuuhKTv/PnaxXYtx2oBXzSdEmmHN7jcBUwvLpsJ0l19i
	2pN7xUXlwxalCx8zy3oAclMDLf2a059pw1umjoGUI1AgU+a0ybhiKuP4g6gRBzfB
	L+k3vdZxzdnpzDjAMGaF8dQgxXkmg6C0sgUroTyp/7DXOvXQwxICSzLS6CXdk1XR
	kgWoLESaE3lsZEq28cnhZibtC0cya778ashO/hCetb0FJPb2O0jFYSQKcKKDr0Fa
	Yu0eoA8r6/MNE7kizbFCOCj9p1vhSMYZCMshku3Yz6hOLBoRoNX6W98joaTZs8QU
	eq2VFCVJDQ==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4a00qr3bp6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Fri, 24 Oct 2025 07:29:45 -0700 (PDT)
Received: from devbig091.ldc1.facebook.com (2620:10d:c0a8:1b::8e35) by
 mail.thefacebook.com (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.20; Fri, 24 Oct 2025 14:29:44 +0000
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
Subject: Re: [PATCH RFC 10/19] slab: remove cpu (partial) slabs usage from allocation paths
Date: Fri, 24 Oct 2025 07:29:20 -0700
Message-ID: <20251024142927.780367-1-clm@meta.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251023-sheaves-for-all-v1-10-6ffa2c9941c0@suse.cz>
References:
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI0MDEyOSBTYWx0ZWRfXzo7mh/+QEEto
 lN48tJt90rZ0v9oBAvXPrAsfwe+CenqqyK68LR7o0BOfvJujTaqFIdwroPduE2PBMa7VnKqUE/B
 hR/lbf4iinufGfA1AoIc8lE3vKY7y4Hw5m21adIOtvFfDgLbh7c/rKrhMA+6RLDywjI9qT/AoPU
 QMz8k7g4r2r6F7d78Ky9USlLG/pqBLtW9jbItBaZRSJncw/ge9eg3eKLxO5qPcfnkt2yRAOGPDZ
 0oDHjSRBppMO5yVVZV2peChq0H2i7zjAjvg8Sie6K49tWvOlXv5+AOIWEC9CFAuuk3C2lzCpqtT
 +WAgDcHMs2kxxD4qDJk65eXaVVatHMy1wdEZjZIXRWbu9DTaF8gSAizL8JMHUtenNSM7KaKQCvX
 uRzKVvQvjM8o8dsWfoKrJwWlFoOyMA==
X-Authority-Analysis: v=2.4 cv=YfWwJgRf c=1 sm=1 tr=0 ts=68fb8d59 cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Qud2Co-4zkO9aUnGrzwA:9
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: whmAAHXeJ-9g96VK63zLv5mAQoKsaiQB
X-Proofpoint-ORIG-GUID: whmAAHXeJ-9g96VK63zLv5mAQoKsaiQB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-24_02,2025-10-22_01,2025-03-28_01

On Thu, 23 Oct 2025 15:52:32 +0200 Vlastimil Babka <vbabka@suse.cz> wrote:

> We now rely on sheaves as the percpu caching layer and can refill them
> directly from partial or newly allocated slabs. Start removing the cpu
> (partial) slabs code, first from allocation paths.
> 
> This means that any allocation not satisfied from percpu sheaves will
> end up in ___slab_alloc(), where we remove the usage of cpu (partial)
> slabs, so it will only perform get_partial() or new_slab().
> 
> In get_partial_node() we used to return a slab for freezing as the cpu
> slab and to refill the partial slab. Now we only want to return a single
> object and leave the slab on the list (unless it became full). We can't
> simply reuse alloc_single_from_partial() as that assumes freeing uses
> free_to_partial_list(). Instead we need to use __slab_update_freelist()
> to work properly against a racing __slab_free().
> 
> The rest of the changes is removing functions that no longer have any
> callers.
>

Hi Vlastimil,

We're trying out the AI patch review automation on the BPF commits and it had
some questions about a few of these.  Since the goal is to actually test the
automation, I'm putting them in unedited, but I did try and make sure they
were valid before sending.

This one seems pretty unlikely but still worth fixing:

>
> diff --git a/mm/slub.c b/mm/slub.c
> index e2b052657d11..bd67336e7c1f 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c

[ ... ]

> @@ -3575,15 +3532,15 @@ static bool get_partial_node_bulk(struct kmem_cache *s,
>  }
>
>  /*
> - * Try to allocate a partial slab from a specific node.
> + * Try to allocate object from a partial slab on a specific node.
>   */
> -static struct slab *get_partial_node(struct kmem_cache *s,
> -				     struct kmem_cache_node *n,
> -				     struct partial_context *pc)
> +static void *get_partial_node(struct kmem_cache *s,
> +			      struct kmem_cache_node *n,
> +			      struct partial_context *pc)
>  {
> -	struct slab *slab, *slab2, *partial = NULL;
> +	struct slab *slab, *slab2;
>  	unsigned long flags;
> -	unsigned int partial_slabs = 0;
> +	void *object;
>
>  	/*
>  	 * Racy check. If we mistakenly see no partial slabs then we
> @@ -3599,54 +3556,54 @@ static struct slab *get_partial_node(struct kmem_cache *s,
>  	else if (!spin_trylock_irqsave(&n->list_lock, flags))
>  		return NULL;
>  	list_for_each_entry_safe(slab, slab2, &n->partial, slab_list) {
> +
> +		unsigned long counters;
> +		struct slab new;
> +
>  		if (!pfmemalloc_match(slab, pc->flags))
>  			continue;

Can get_partial_node() return an uninitialized pointer? The variable
'object' is declared but never initialized. If all slabs in the partial
list fail the pfmemalloc_match() check, the loop completes without
setting 'object', then returns it at the end of the function.

In the previous version, the equivalent 'partial' variable was explicitly
initialized to NULL. When all slabs were skipped, NULL was returned.

>
>  		if (IS_ENABLED(CONFIG_SLUB_TINY) || kmem_cache_debug(s)) {
> -			void *object = alloc_single_from_partial(s, n, slab,
> +			object = alloc_single_from_partial(s, n, slab,
>  							pc->orig_size);
> -			if (object) {
> -				partial = slab;
> -				pc->object = object;
> +			if (object)
>  				break;
> -			}
>  			continue;
>  		}
>
> -		remove_partial(n, slab);
> -
> -		if (!partial) {
> -			partial = slab;
> -			stat(s, ALLOC_FROM_PARTIAL);
> -
> -			if ((slub_get_cpu_partial(s) == 0)) {
> -				break;
> -			}
> -		} else {
> -			put_cpu_partial(s, slab, 0);
> -			stat(s, CPU_PARTIAL_NODE);
> -
> -			if (++partial_slabs > slub_get_cpu_partial(s) / 2) {
> -				break;
> -			}
> -		}
> +		/*
> +		 * get a single object from the slab. This might race against
> +		 * __slab_free(), which however has to take the list_lock if
> +		 * it's about to make the slab fully free.
> +		 */
> +		do {
> +			object = slab->freelist;
> +			counters = slab->counters;
> +			new.freelist = get_freepointer(s, object);
> +			new.counters = counters;
> +			new.inuse++;
> +		} while (!__slab_update_freelist(s, slab,
> +			object, counters,
> +			new.freelist, new.counters,
> +			"get_partial_node"));
> +
> +		if (!new.freelist)
> +			remove_partial(n, slab);
>  	}
>  	spin_unlock_irqrestore(&n->list_lock, flags);
> -	return partial;
> +	return object;
>  }

[ ... ]



