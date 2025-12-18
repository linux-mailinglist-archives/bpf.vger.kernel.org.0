Return-Path: <bpf+bounces-77027-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B99ACCD2C8
	for <lists+bpf@lfdr.de>; Thu, 18 Dec 2025 19:29:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AF7C5305BC78
	for <lists+bpf@lfdr.de>; Thu, 18 Dec 2025 18:28:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40DF832E142;
	Thu, 18 Dec 2025 18:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jfI+0Y/k"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E34543203A9;
	Thu, 18 Dec 2025 18:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766082478; cv=none; b=lbG8xjnBR+0bxY6gmv3BpQTrltFvXXDWy4wGy/qP3oeuRyiG0iUQah3+aF5/1TMBVOs1HVht0/il9D/AT1blsSP0vYTI/T6XdzYZMeLg3RNHhtFu7DGDDcpY62PBn949HaC6HiuyZBwVDkpqrGOTIpjMqIKuS2+vX/MaHLYmXVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766082478; c=relaxed/simple;
	bh=oYUba6vJ5SzDXLUp72SyzQKr8V2W/tdcBlIxcaBRVPE=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=rDiqq7ltGLgopuAk/je9sqQtTYLBWhYRrRcaDtw+0PHLwzhG295pJx3mItnRcJh+GtHZdZFWEpj+zkyUf1hZtEfRNyZE8Bx8C7XnOpqQSdtuLyDqLWHjrXKZi3WaQHVBWY+z557MaDSkw0sIU8j9Ogs5F1Zgy4nxiABUZOdOZ5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jfI+0Y/k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 162FEC113D0;
	Thu, 18 Dec 2025 18:27:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766082475;
	bh=oYUba6vJ5SzDXLUp72SyzQKr8V2W/tdcBlIxcaBRVPE=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=jfI+0Y/kzCWCTWC51TN9GPsXVeB91fMkP3cBSiZpn03GFYVoVmSGj6VsR6j5PpAw6
	 A+3YyBYmtgrEC0Tv2dRyzjeALl7/UUw+YITBSpWFGtSnlS6ToJqqn8EvzNqReGIADU
	 uvzU+cJkK/JjnFHsby0DrAx5xGlGcLtEiJk5TWu2wO+dtc8q+pu8MOoPrJUj45Q9Fe
	 fT8S8ok+WXaBxgld8Gmqqyw8hY/fexpoTcJlTttN8M0R1i1s/XqGi2lF5eO6nIzJY4
	 Ig04+HCUFhbGdCV+8lNzeE9lSvSV0kpNGKHz6QvBmswVNBaWf5OqrnQAsZ2abiKL75
	 9CD9R/yH+/Iog==
Content-Type: multipart/mixed; boundary="===============6921028758858748024=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <cd6f7bf79d96dff7196dfc0b33d72d91280bbb2de5042cb9d817918ebf4c7209@mail.kernel.org>
In-Reply-To: <20251218175628.1460321-5-ameryhung@gmail.com>
References: <20251218175628.1460321-5-ameryhung@gmail.com>
Subject: Re: [PATCH bpf-next v3 04/16] bpf: Convert bpf_selem_unlink to failable
From: bot+bpf-ci@kernel.org
To: ameryhung@gmail.com,bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,alexei.starovoitov@gmail.com,andrii@kernel.org,daniel@iogearbox.net,memxor@gmail.com,martin.lau@kernel.org,kpsingh@kernel.org,yonghong.song@linux.dev,song@kernel.org,haoluo@google.com,ameryhung@gmail.com,kernel-team@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Thu, 18 Dec 2025 18:27:55 +0000 (UTC)

--===============6921028758858748024==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/bpf_local_storage.c b/kernel/bpf/bpf_local_storage.c
> index 0e3fa5fbaaf3..fa629a180e9e 100644
> --- a/kernel/bpf/bpf_local_storage.c
> +++ b/kernel/bpf/bpf_local_storage.c
> @@ -367,7 +367,7 @@ static void bpf_selem_link_map_nolock(struct bpf_local_storage_map *smap,
>  	hlist_add_head_rcu(&selem->map_node, &b->list);
>  }
>
> -void bpf_selem_unlink(struct bpf_local_storage_elem *selem, bool reuse_now)
> +int bpf_selem_unlink(struct bpf_local_storage_elem *selem, bool reuse_now)
>  {
>  	struct bpf_local_storage *local_storage;
>  	bool free_local_storage = false;
>  	HLIST_HEAD(selem_free_list);
>  	unsigned long flags;
>  	int err;

The err variable is declared here but not initialized.

>  	if (unlikely(!selem_linked_to_storage_lockless(selem)))
>  		/* selem has already been unlinked from sk */
> -		return;
> +		return 0;

[ ... ]

>  	raw_spin_lock_irqsave(&local_storage->lock, flags);
>  	if (likely(selem_linked_to_storage(selem))) {

If this condition is false, the if-block is skipped and err is never
assigned. There is a race window between the lockless check above and
this locked check where another CPU could unlink the selem.

>  		err = bpf_selem_unlink_map(selem);
>  		if (err)
>  			goto out;
>
>  		free_local_storage = bpf_selem_unlink_storage_nolock(
>  			local_storage, selem, &selem_free_list);
>  	}

[ ... ]

> +	return err;
>  }

Could this return an uninitialized value when selem_linked_to_storage()
returns false? The commit message says "always succeeds and returns 0"
but err is not initialized to 0.

I note that this appears to be addressed in a later commit in this
series (615477732ee8 "bpf: Change local_storage->lock and b->lock to
rqspinlock") where the lock function returns into err before the
condition check. Should err be initialized to 0 here for correctness
in the intermediate state?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/20346662777

--===============6921028758858748024==--

