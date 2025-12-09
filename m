Return-Path: <bpf+bounces-76354-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E82ABCAF72B
	for <lists+bpf@lfdr.de>; Tue, 09 Dec 2025 10:29:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D1D743070798
	for <lists+bpf@lfdr.de>; Tue,  9 Dec 2025 09:29:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33B6B2E9EBE;
	Tue,  9 Dec 2025 09:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HQFQawjH"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5F4C21FF55;
	Tue,  9 Dec 2025 09:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765272541; cv=none; b=Vx9n6lPyaVL+ApEv+PE29U/k+LUb1mdAg/mFOV7HdBL0Z8qDhqF8m9KUmZNLGMEXsGCfsYa3OQcTQ2tRfEEWQ2EaHMhXy4EkS7PPHH87ESHoBR8aO9Ej3S7wX3H9j4ro4hZ27eIQSdKMZXo9gA5tKt9IDu3TAE8lJfz2IvU8aiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765272541; c=relaxed/simple;
	bh=jx2KIko/Fqa9qyMhadSjV4S3vv1GlDszkYIBehGYlc0=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=kcMabfDftPBlcxB9HEtOGKxX+md6MR6llbG1nwPCXvnEch0h/3akU2RoKTjO41d8/0VFJYmBa6/6cSfYVnJ57SfMZIfkvs3qJRL9AEIMkoSjqFaUlL/WgHIxPwl48uN3+D9zAiqLioUM0XjDHqSKPh0akpB/Pr6IbzIqjOqzcFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HQFQawjH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79852C4CEF5;
	Tue,  9 Dec 2025 09:28:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765272540;
	bh=jx2KIko/Fqa9qyMhadSjV4S3vv1GlDszkYIBehGYlc0=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=HQFQawjHq6qiIDx0OllfcIPK/+7Yqhy/2OKUv+/IiVmxVpVMlk9j9ZTDohNG6w9GE
	 FwXsgyv6mslAZkRdhT4ZDusUhwxyJfzYLM3VRC+FOB7IDua5sIspo9Jb0+ZKtrtwH3
	 VMXrduWCcIeU7fF093VjiSnvpoMeCKw2fRaxUxCmLnZsdbTgO4vBWvuIJv6RO537hm
	 qhRByeyjI++7Dkz9caRM/w+VQ51Bl6VcnSLEmfEk9NqOLR13h/R6KRcjYnPuAAoGRo
	 BEgJohqzBmgajPVKXKFK07C81IJX353jm4r8M6yAntWYwmnYaH2BqrSQLvKtoaVczr
	 G3a5/DeTSgpOw==
Content-Type: multipart/mixed; boundary="===============5365739234643047043=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <3b8d7e918263a668f37e7c991de87d9473d01604ae5e61c5a40310ef00ffc017@mail.kernel.org>
In-Reply-To: <20251209085950.96231-2-kerneljasonxing@gmail.com>
References: <20251209085950.96231-2-kerneljasonxing@gmail.com>
Subject: Re: [PATCH bpf-next v1 1/2] xsk: introduce local_cq for each af_xdp socket
From: bot+bpf-ci@kernel.org
To: kerneljasonxing@gmail.com,davem@davemloft.net,edumazet@google.com,kuba@kernel.org,pabeni@redhat.com,bjorn@kernel.org,magnus.karlsson@intel.com,maciej.fijalkowski@intel.com,jonathan.lemon@gmail.com,sdf@fomichev.me,ast@kernel.org,daniel@iogearbox.net,hawk@kernel.org,john.fastabend@gmail.com
Cc: bpf@vger.kernel.org,netdev@vger.kernel.org,kernelxing@tencent.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Tue,  9 Dec 2025 09:28:58 +0000 (UTC)

--===============5365739234643047043==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/include/net/xdp_sock.h b/include/net/xdp_sock.h
> index 23e8861e8b25..c53ab2609d8c 100644
> --- a/include/net/xdp_sock.h
> +++ b/include/net/xdp_sock.h
> @@ -45,6 +45,12 @@ struct xsk_map {
>  	struct xdp_sock __rcu *xsk_map[];
>  };
>
> +struct local_cq {
> +	u32 prod ____cacheline_aligned_in_smp;
> +	u32 ring_mask ____cacheline_aligned_in_smp;
> +	u64 desc[] ____cacheline_aligned_in_smp;
> +};

The prod field is not initialized in xsk_init_local_cq(). Since vmalloc()
does not zero memory, prod will contain garbage values when first used.
The next commit in this series (722af5ef5295 "xsk: introduce a dedicated
local completion queue for each xsk") uses prod with lcq->prod++ before
any initialization occurs.

Should prod be initialized to 0 in xsk_init_local_cq()?

> +
>  struct xdp_sock {
>  	/* struct sock must be the first member of struct xdp_sock */
>  	struct sock sk;

[ ... ]

> diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> index f093c3453f64..ce165d093105 100644
> --- a/net/xdp/xsk.c
> +++ b/net/xdp/xsk.c

[ ... ]

> +static int xsk_init_local_cq(struct xdp_sock *xs)
> +{
> +	u32 nentries = xs->pool->cq->nentries;
> +	size_t size = struct_size_t(struct local_cq, desc, nentries);
> +
> +	xs->lcq = vmalloc(size);
> +	if (!xs->lcq)
> +		return -ENOMEM;
> +	xs->lcq->ring_mask = nentries - 1;
> +
> +	return 0;
> +}

Can xs->pool->cq be NULL here? In the XDP_SHARED_UMEM path with
different queue_id or device (xsk_bind()->xp_create_and_assign_umem()->
xsk_init_local_cq()), xp_create_and_assign_umem() sets pool->cq =
xs->cq_tmp, but there's no validation that xs->cq_tmp is non-NULL
before calling xsk_init_local_cq().

For comparison, the non-shared umem path validates cq_tmp via
xsk_validate_queues() before reaching xsk_init_local_cq(). Should the
XDP_SHARED_UMEM path with different qid/dev also validate that cq_tmp
is set before calling xp_create_and_assign_umem()?

> +
> +static void xsk_clear_local_cq(struct xdp_sock *xs)
> +{
> +	vfree(xs->lcq);
> +}

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/20058064407

--===============5365739234643047043==--

