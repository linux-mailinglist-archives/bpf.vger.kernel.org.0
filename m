Return-Path: <bpf+bounces-72101-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C81EC069CB
	for <lists+bpf@lfdr.de>; Fri, 24 Oct 2025 16:06:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4167A5008CC
	for <lists+bpf@lfdr.de>; Fri, 24 Oct 2025 14:06:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD4EC31D727;
	Fri, 24 Oct 2025 14:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="fnXo7b6r"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D57463101C4;
	Fri, 24 Oct 2025 14:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761314787; cv=none; b=KXkTZ+ujlnEfO11g1B4FCaXIeVKfuCGIcHVjgmCixdMGv//AInAmVEaz95Gw1NXr07ZfDXPfV4F6EfRu5L8DCHNYDxQSu1M6A/UeNG33CrhhSaLit3+jcrlAWGfp+fBkSKpqOGbtB/VV6MMsTzYetZFrsiR4RTInjqUKZEco08k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761314787; c=relaxed/simple;
	bh=5ETnDsHEDrXuHKeZH0Uvbu+f03ISsrW34MyNUHQaBrs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SKDTca0+8X0n/ZVrMfYeTESs1sob3KobCW7s4IR3JxzHgbfZAtoqB+lUTDAlJGZ4FTuljp5EpnuaWRy4OnTJ2LbtjJ2Ui1nP+MqgOvSM1sVO0kOwM67+lWcGfejHjIgjEstk6gJxOsnd3R6z0ebSpGSuKRS+6V91w0tjk9a12Xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=fnXo7b6r; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59O2USQQ1836938;
	Fri, 24 Oct 2025 07:05:39 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=d+lSgdkA9+bEZAYGayqSUgiThyPvWrBH7x+H6ZQsxL8=; b=fnXo7b6rWJVD
	bMcf8mfLj4lFbsB8T8fVIJVThjcZ70GY0iSMWqfS+/Q2/0piWstJzxXWoE9MFBPI
	2NNDPbecaed1qI0kky0qRZNr+ZkfsHloHD5n1wEIH0kJNkhAlZs/I4OZE8oQrDGr
	S02s9fc+/6Im5sEoKhysYT01mBI4qnh9rqaUsopb91hClwLnpEYVuMIgZ2FAQs1R
	sfnifuxn8LpvBzSmi3SrEUf9fMb1On0ldS+gMGUuWW87PeCs9J6wPrHSw6YBps9O
	MjvEdvaAr4u0l2vN82Osd0DdDAa+4Z+lc0AelVEQaPVQklsZFmTGoVgBSPSdqRW/
	N7w7N/rMhw==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4a00qr3619-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Fri, 24 Oct 2025 07:05:39 -0700 (PDT)
Received: from devbig091.ldc1.facebook.com (2620:10d:c085:208::7cb7) by
 mail.thefacebook.com (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.20; Fri, 24 Oct 2025 14:05:37 +0000
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
Subject: Re: [PATCH RFC 07/19] slab: make percpu sheaves compatible with kmalloc_nolock()/kfree_nolock()
Date: Fri, 24 Oct 2025 07:04:12 -0700
Message-ID: <20251024140416.642903-1-clm@meta.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251023-sheaves-for-all-v1-7-6ffa2c9941c0@suse.cz>
References:
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI0MDEyNSBTYWx0ZWRfX/YulqWc9km6x
 rZ9QcTf19ercfPCVy42mSwO7q320WyUffMX/ZOVV7/0+LFbBFHmAfk2Z1nHq59y7qfsbHdViGRD
 io4nb8k8yiW8czQRYEwRQEohNhFCUEl4NRmZCYsgFJZlRxj1PtPgWgZzuVIHIIhPct9t2Wfu13D
 SLHDI/8l3xJYV14IBIkFzMZH2jMjSo9AdnQtxANe+GN3UolHaVOk7d0MrciDj2ba98RBSEmnLzO
 kdTPYGW/hzVqoNvRfKQibEWBbPQz4XKL0KqpaA61zheqxCgwbjLC/NI+Q6G3Ayt2KkYvzXNpdE0
 FNU6tWhrKW6R4RJlXT9SFRQZnB8ZN5hzY5AQz5eKeJWqoWxcu69Fpr1LA7wONxXD7eMaFZm2vNM
 KjiYAhsQxFDrI5BZx4kLTH5W8/mBsA==
X-Authority-Analysis: v=2.4 cv=YfWwJgRf c=1 sm=1 tr=0 ts=68fb87b3 cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=y43Pqs-daWJVC1BrHOAA:9
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: ypt68hrsJxSCnWKUb2JArGmMBobBfU89
X-Proofpoint-ORIG-GUID: ypt68hrsJxSCnWKUb2JArGmMBobBfU89
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-24_02,2025-10-22_01,2025-03-28_01

On Thu, 23 Oct 2025 15:52:29 +0200 Vlastimil Babka <vbabka@suse.cz> wrote:

> Before we enable percpu sheaves for kmalloc caches, we need to make sure
> kmalloc_nolock() and kfree_nolock() will continue working properly and
> not spin when not allowed to.
> 
> Percpu sheaves themselves use local_trylock() so they are already
> compatible. We just need to be careful with the barn->lock spin_lock.
> Pass a new allow_spin parameter where necessary to use
> spin_trylock_irqsave().
> 
> In kmalloc_nolock_noprof() we can now attempt alloc_from_pcs() safely,
> for now it will always fail until we enable sheaves for kmalloc caches
> next. Similarly in kfree_nolock() we can attempt free_to_pcs().
>

Hi Vlastimil,

We're trying out the AI patch review automation on the BPF commits and it had
some questions about a few of these.  Since the goal is to actually test the
automation, I'm putting them in unedited, but I did try and make sure they
were valid before sending.

This one is a little verbose for s/NULL/ERR_PTR/ suggestions, but:

> diff --git a/mm/slub.c b/mm/slub.c
> index ecb10ed5acfe..5d0b2cf66520 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c

[ ... ]

> @@ -2990,7 +2998,8 @@ barn_replace_empty_sheaf(struct node_barn *barn, struct slab_sheaf *empty)
>   * barn. But if there are too many full sheaves, reject this with -E2BIG.
>   */
>  static struct slab_sheaf *
> -barn_replace_full_sheaf(struct node_barn *barn, struct slab_sheaf *full)
> +barn_replace_full_sheaf(struct node_barn *barn, struct slab_sheaf *full,
> +			bool allow_spin)
>  {
>  	struct slab_sheaf *empty;
>  	unsigned long flags;
> @@ -3001,7 +3010,10 @@ barn_replace_full_sheaf(struct node_barn *barn, struct slab_sheaf *full)
>  	if (!data_race(barn->nr_empty))
>  		return ERR_PTR(-ENOMEM);
>
> -	spin_lock_irqsave(&barn->lock, flags);
> +	if (likely(allow_spin))
> +		spin_lock_irqsave(&barn->lock, flags);
> +	else if (!spin_trylock_irqsave(&barn->lock, flags))
> +		return NULL;

barn_replace_full_sheaf() now returns NULL when the trylock fails, in
addition to its existing ERR_PTR(-ENOMEM) and ERR_PTR(-E2BIG) returns.

[ ... ]

> @@ -6047,7 +6070,8 @@ static void __pcs_install_empty_sheaf(struct kmem_cache *s,
>   * unlocked.
>   */
>  static struct slub_percpu_sheaves *
> -__pcs_replace_full_main(struct kmem_cache *s, struct slub_percpu_sheaves *pcs)
> +__pcs_replace_full_main(struct kmem_cache *s, struct slub_percpu_sheaves *pcs,
> +			bool allow_spin)
>  {
>  	struct slab_sheaf *empty;
>  	struct node_barn *barn;
> @@ -6071,7 +6095,7 @@ __pcs_replace_full_main(struct kmem_cache *s, struct slub_percpu_sheaves *pcs)
>  	put_fail = false;
>
>  	if (!pcs->spare) {
> -		empty = barn_get_empty_sheaf(barn);
> +		empty = barn_get_empty_sheaf(barn, allow_spin);
>  		if (empty) {
>  			pcs->spare = pcs->main;
>  			pcs->main = empty;
> @@ -6085,7 +6109,7 @@ __pcs_replace_full_main(struct kmem_cache *s, struct slub_percpu_sheaves *pcs)
>  		return pcs;
>  	}
>
> -	empty = barn_replace_full_sheaf(barn, pcs->main);
> +	empty = barn_replace_full_sheaf(barn, pcs->main, allow_spin);
>
>  	if (!IS_ERR(empty)) {
>  		stat(s, BARN_PUT);
>  		pcs->main = empty;
>  		return pcs;
>  	}

Can this set pcs->main to NULL? When allow_spin=false and the trylock
fails, barn_replace_full_sheaf() returns NULL. Since !IS_ERR(NULL) is
true, the code executes pcs->main = NULL and returns pcs. This violates
the documented invariant that main is "never NULL when unlocked" (from
struct slub_percpu_sheaves comment at mm/slub.c:481).

The caller free_to_pcs() then dereferences pcs->main->objects at
mm/slub.c:6208, which would be a NULL pointer dereference:

    pcs->main->objects[pcs->main->size++] = object;

The execution path is:
1. kfree_nolock() calls free_to_pcs() with allow_spin=false
2. free_to_pcs() calls __pcs_replace_full_main() with allow_spin=false
3. pcs->spare exists and is full (size == s->sheaf_capacity)
4. barn_replace_full_sheaf() trylock fails, returns NULL
5. !IS_ERR(NULL) = true, so pcs->main = NULL is executed
6. __pcs_replace_full_main() returns pcs with NULL main
7. free_to_pcs() dereferences pcs->main->objects causing NULL deref

Should the check be if (empty && !IS_ERR(empty)) to properly handle the
new NULL return case?

> @@ -6093,6 +6117,11 @@ __pcs_replace_full_main(struct kmem_cache *s, struct slub_percpu_sheaves *pcs)
>  		return pcs;
>  	}
>
> +	if (!allow_spin) {
> +		local_unlock(&s->cpu_sheaves->lock);
> +		return NULL;
> +	}

This check is never reached when barn_replace_full_sheaf() returns NULL,
because the early return at the !IS_ERR(empty) check above executes first.

[ ... ]



