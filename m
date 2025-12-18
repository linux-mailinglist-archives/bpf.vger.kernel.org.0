Return-Path: <bpf+bounces-77029-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F837CCD2B6
	for <lists+bpf@lfdr.de>; Thu, 18 Dec 2025 19:28:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3F541305AE3E
	for <lists+bpf@lfdr.de>; Thu, 18 Dec 2025 18:28:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF63F325728;
	Thu, 18 Dec 2025 18:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xj1cMl8Y"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D30D13126BE;
	Thu, 18 Dec 2025 18:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766082481; cv=none; b=n5AWmQp12d/c/pYZj6AuOShhiDCKGRn7Z6HkifbytwKF+/qVKk+q39csVJrYlmVCcqj6FFyXuuVqBYBkI0/1JrJGJEMmtod0dHI20QhWdgJDmZRcg/prUr4hDSEmbtG4Gue0MhzPEJXd/wq4bZAiTZEgeBDDJ2IR9+kGQ3yRynA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766082481; c=relaxed/simple;
	bh=sOmCQApvY7MQRYUL2cFCwah6QCaJh7ECm+G7QeKmctY=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=JrNhHMBnGMttyPq6kW0t7rZU/EYMoSedtKpaC+0Lb3fefa8LPBpBK+VphI9tmFy2sg68mLfT2ZyX6VhLn0/cDWI/e4Eiw9wk8ozzNYYgmRyXCNXX3PVAdjl5sgYwdCc4ZfEuOQcvSltFLCPE/JWKPOyknyb69R/0Tkux6axa6Cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xj1cMl8Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D059C16AAE;
	Thu, 18 Dec 2025 18:27:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766082478;
	bh=sOmCQApvY7MQRYUL2cFCwah6QCaJh7ECm+G7QeKmctY=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=Xj1cMl8Ys+hcTQuaHtyW5wOtmtfENQ+tqKZMOapXSpCwOtxGOozC0iJeUNeqLloes
	 XaWNDFVC55YOSnmsYPGsIT/f7SXmTbzktIuUhRNOp0N4I1sKn8E+3gakiYZbcF5gKS
	 V+BgW7thdQr91U+QbK5vN8uj9JV1LrinrXBtDzGkYmsXTogtteboRvztMQlL+5ZPJY
	 m+fX9O4G8b5BlmEfS6fbb3/pIZHY1NaiJsnNFGlKIbZxx7GxyDmB+s2f+YvDqL39QG
	 bECeZKOaiTimQV0unnNo9zzwjqdIjBIfmUl6Ackzbk2jofCGMvnPSI6xXTpISIDIY8
	 m7KcF/h8efwKw==
Content-Type: multipart/mixed; boundary="===============3549994344081258731=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <fe0e4007f3dac99d114d50ed365885795aa2c22f648e72b57c5ff7e8762f57ce@mail.kernel.org>
In-Reply-To: <20251218175628.1460321-6-ameryhung@gmail.com>
References: <20251218175628.1460321-6-ameryhung@gmail.com>
Subject: Re: [PATCH bpf-next v3 05/16] bpf: Change local_storage->lock and b->lock to rqspinlock
From: bot+bpf-ci@kernel.org
To: ameryhung@gmail.com,bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,alexei.starovoitov@gmail.com,andrii@kernel.org,daniel@iogearbox.net,memxor@gmail.com,martin.lau@kernel.org,kpsingh@kernel.org,yonghong.song@linux.dev,song@kernel.org,haoluo@google.com,ameryhung@gmail.com,kernel-team@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Thu, 18 Dec 2025 18:27:58 +0000 (UTC)

--===============3549994344081258731==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/bpf_local_storage.c b/kernel/bpf/bpf_local_storage.c
> index fa629a180e9e..1d21ec11c80e 100644
> --- a/kernel/bpf/bpf_local_storage.c
> +++ b/kernel/bpf/bpf_local_storage.c

[ ... ]

> @@ -382,7 +390,10 @@ int bpf_selem_unlink(struct bpf_local_storage_elem *selem, bool reuse_now)
>  	local_storage = rcu_dereference_check(selem->local_storage,
>  					      bpf_rcu_lock_held());
>
> -	raw_spin_lock_irqsave(&local_storage->lock, flags);
> +	err = raw_res_spin_lock_irqsave(&local_storage->lock, flags);
> +	if (err)
> +		return err;

This change makes bpf_selem_unlink() failable, but bpf_local_storage_map_free()
calls it in a while loop that continues iterating while hlist_first_rcu()
returns elements:

    while ((selem = hlist_entry_safe(
            rcu_dereference_raw(hlist_first_rcu(&b->list)), ...))) {
        WARN_ON(bpf_selem_unlink(selem, true));
    }

If bpf_selem_unlink() fails (returns error), the selem is not removed from
b->list, so hlist_first_rcu() returns the same selem again. Would this cause
an infinite loop printing warnings until the system becomes unresponsive?

[ ... ]

> @@ -719,7 +743,7 @@ void bpf_local_storage_destroy(struct bpf_local_storage *local_storage)
>  	 * when unlinking elem from the local_storage->list and
>  	 * the map's bucket->list.
>  	 */
> -	raw_spin_lock_irqsave(&local_storage->lock, flags);
> +	WARN_ON(raw_res_spin_lock_irqsave(&local_storage->lock, flags));
>  	hlist_for_each_entry_safe(selem, n, &local_storage->list, snode) {
>  		/* Always unlink from map before unlinking from
>  		 * local_storage.
>  		 */
> -		bpf_selem_unlink_map(selem);
> +		WARN_ON(bpf_selem_unlink_map(selem));

If raw_res_spin_lock_irqsave() fails, WARN_ON() prints a warning but does
not prevent execution from continuing. The code then proceeds to iterate
local_storage->list without holding local_storage->lock, and eventually
calls raw_res_spin_unlock_irqrestore() at the end without having acquired
the lock. Does this cause issues with the rqspinlock held-lock tracking,
which unconditionally decrements its counter in res_spin_unlock()?

Additionally, if bpf_selem_unlink_map() fails, the selem remains linked to
the map's bucket list, but execution continues and
bpf_selem_unlink_storage_nolock() removes it from local_storage->list and
adds it to the free list. When the selem is later freed, would the map's
bucket still hold a dangling reference to it?

> @@ -734,7 +758,7 @@ void bpf_local_storage_destroy(struct bpf_local_storage *local_storage)
>  		free_storage = bpf_selem_unlink_storage_nolock(
>  			local_storage, selem, &free_selem_list);
>  	}
> -	raw_spin_unlock_irqrestore(&local_storage->lock, flags);
> +	raw_res_spin_unlock_irqrestore(&local_storage->lock, flags);

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/20346662777

--===============3549994344081258731==--

