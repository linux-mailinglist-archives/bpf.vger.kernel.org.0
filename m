Return-Path: <bpf+bounces-77028-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id EE1D9CCD2B3
	for <lists+bpf@lfdr.de>; Thu, 18 Dec 2025 19:28:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C4C5B305AD90
	for <lists+bpf@lfdr.de>; Thu, 18 Dec 2025 18:28:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38414327214;
	Thu, 18 Dec 2025 18:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TGv9BDwb"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05F54326942;
	Thu, 18 Dec 2025 18:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766082478; cv=none; b=XiQxxhPksQ/Mt/eipN4CaNc4/+kdZp5h27p41mpHSDoGaLdONXcA7sGUcmpNKBO8cMGFBfb1cD6req4W1ru+HBOQ+0TNGltaaxs83GzjA7F1fqGcIgEW18LLSHRqm30ydsqw097fQb60CEbccCVRYlhVoPcmfwjwicOi67uyu0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766082478; c=relaxed/simple;
	bh=Mvj4FCjmHlpKdYwrWcQq3wTMAQrnZkyN14FqozNk20U=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=EITqtjtTntvjjmC2Uv6rBPZM2TrUe1jdfuAODBjGmgvUlfpnKZvh+oEoCZJzCv7dRyDO0gMIaPN9cQQddQ6xaSdhSm5brsZDHE6SNejnWJ+121NK+H5nLKek821ogXLN7zulDzOOXStvYkHbHjOvdiCVHhtqQRG+hYQp3ZvfhYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TGv9BDwb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82E46C4CEFB;
	Thu, 18 Dec 2025 18:27:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766082476;
	bh=Mvj4FCjmHlpKdYwrWcQq3wTMAQrnZkyN14FqozNk20U=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=TGv9BDwbFdS5oDyADb7rlyym4EY2f1vBxnVZg4upOhXucUXPZU1hr6Isxi6W9d3Z9
	 iKpzHMk+kKDEtTa27K8OKXUPkMcD4HoWJ+UKrC5w17XOC6V5sO6Rrdj/PTi4nHBbnx
	 hrv9wDonsW2GSzXiuU86EWvCjbJfskIuvrYbGMwBMceDMGZbeEQzR1JHw5TjGfujC4
	 g+0FRg+yaAHrkuqL9S1YqFFbqxwgeOaadNjmDyyaClvEEuc/ShU//UPQ0wQwOJrimG
	 IyWVnUugtpN/7BZ9sL95OM9k+bfk2f9risXS3c23tfL97wim8sKYOIwpBX/TNYdvko
	 YCgOLE03upsYQ==
Content-Type: multipart/mixed; boundary="===============2847465728903958225=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <1a31d5b805f81b28ea95cdfdd57b8e2fb88ab29bfbbc034b4443978b4dddb5c6@mail.kernel.org>
In-Reply-To: <20251218175628.1460321-2-ameryhung@gmail.com>
References: <20251218175628.1460321-2-ameryhung@gmail.com>
Subject: Re: [PATCH bpf-next v3 01/16] bpf: Convert bpf_selem_unlink_map to failable
From: bot+bpf-ci@kernel.org
To: ameryhung@gmail.com,bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,alexei.starovoitov@gmail.com,andrii@kernel.org,daniel@iogearbox.net,memxor@gmail.com,martin.lau@kernel.org,kpsingh@kernel.org,yonghong.song@linux.dev,song@kernel.org,haoluo@google.com,ameryhung@gmail.com,kernel-team@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Thu, 18 Dec 2025 18:27:56 +0000 (UTC)

--===============2847465728903958225==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/bpf_local_storage.c b/kernel/bpf/bpf_local_storage.c
> index e2fe6c32822b..4e3f227fd634 100644
> --- a/kernel/bpf/bpf_local_storage.c
> +++ b/kernel/bpf/bpf_local_storage.c

[ ... ]

> @@ -488,9 +516,10 @@ bpf_local_storage_update(void *owner, struct bpf_local_storage_map *smap,
>  {
>  	struct bpf_local_storage_data *old_sdata = NULL;
>  	struct bpf_local_storage_elem *alloc_selem, *selem = NULL;
> +	struct bpf_local_storage_map_bucket *b, *old_b = NULL;
> +	unsigned long flags, b_flags, old_b_flags;
>  	struct bpf_local_storage *local_storage;
>  	HLIST_HEAD(old_selem_free_list);
> -	unsigned long flags;
>  	int err;

[ ... ]

> @@ -574,20 +603,37 @@ bpf_local_storage_update(void *owner, struct bpf_local_storage_map *smap,
>  		goto unlock;
>  	}
>
> +	b = select_bucket(smap, selem);
> +
> +	if (old_sdata) {
> +		old_b = select_bucket(smap, SELEM(old_sdata));
> +		old_b = old_b == b ? NULL : old_b;
> +	}
> +
> +	raw_spin_lock_irqsave(&b->lock, b_flags);
> +
> +	if (old_b)
> +		raw_spin_lock_irqsave(&old_b->lock, old_b_flags);
                ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Could this introduce an ABBA deadlock between two bucket locks? If two
threads concurrently update storage on the same map with different owners,
their new and old selems could hash to different buckets with reversed
order:

  Thread 1: new_selem -> bucket_A, old_selem -> bucket_B
            acquires b->lock (A), then waits for old_b->lock (B)

  Thread 2: new_selem -> bucket_B, old_selem -> bucket_A
            acquires b->lock (B), then waits for old_b->lock (A)

Since the locks are regular raw_spinlocks (not rqspinlocks yet), they
will block indefinitely in this scenario.

Note: I see that commit 615477732ee8 ("bpf: Change local_storage->lock
and b->lock to rqspinlock") later in this series changes to rqspinlock
which has deadlock detection and can return -EDEADLK instead of blocking.
However, in the current commit the locks are still raw_spinlocks.

> +
>  	alloc_selem = NULL;
>  	/* First, link the new selem to the map */
> -	bpf_selem_link_map(smap, selem);
> +	bpf_selem_link_map_nolock(smap, selem, b);
>
>  	/* Second, link (and publish) the new selem to local_storage */
>  	bpf_selem_link_storage_nolock(local_storage, selem);
>
>  	/* Third, remove old selem, SELEM(old_sdata) */
>  	if (old_sdata) {
> -		bpf_selem_unlink_map(SELEM(old_sdata));
> +		bpf_selem_unlink_map_nolock(SELEM(old_sdata));
>  		bpf_selem_unlink_storage_nolock(local_storage, SELEM(old_sdata),
>  						&old_selem_free_list);
>  	}
>
> +	if (old_b)
> +		raw_spin_unlock_irqrestore(&old_b->lock, old_b_flags);
> +
> +	raw_spin_unlock_irqrestore(&b->lock, b_flags);
> +
>  unlock:
>  	raw_spin_unlock_irqrestore(&local_storage->lock, flags);


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/20346662777

--===============2847465728903958225==--

