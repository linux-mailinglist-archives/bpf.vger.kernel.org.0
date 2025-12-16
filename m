Return-Path: <bpf+bounces-76685-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 91F6ACC1072
	for <lists+bpf@lfdr.de>; Tue, 16 Dec 2025 06:46:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C20C83002D09
	for <lists+bpf@lfdr.de>; Tue, 16 Dec 2025 05:46:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1246C2D24A0;
	Tue, 16 Dec 2025 05:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KxkiRqov"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 422012C3757;
	Tue, 16 Dec 2025 05:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765863986; cv=none; b=oHNPOptPokkRO4OW+areotgn1A2nS36hW3Q78/5+hlNP8R58TbWpRNKDFo7VnY/oAjxs5J7T+U3eaqvoV9QhxXpX0Bwb3d+YkZqZBiDZPlpa2vk5j8xNNDNgOq37EO60hyf0hCZk+mnsVuXFZeeOnk49yGq07a6Zw3h7KBwJ7fM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765863986; c=relaxed/simple;
	bh=io7zDeq1oaPd40zwYHqzLX6cyyeEdCPYC//fm3f+xgo=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=pg5a5+BDMpqTsCMOqj4YRq1rn2UIMwFfXQcmxYECym5KC9Wlk3jCYngEWvT/toA8AtnulXCoWPFUohxxs6XuJw+9DwipsrScauURhEw6UI6Xtgfw5Kx1NgiX8Z2Jr8auWVeeiMvcXIyXJFZ7em5bwIYLoZhvi8L8XOv+eiYy0lM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KxkiRqov; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3156C113D0;
	Tue, 16 Dec 2025 05:46:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765863985;
	bh=io7zDeq1oaPd40zwYHqzLX6cyyeEdCPYC//fm3f+xgo=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=KxkiRqovSDKK5+WJE/Z/uJIvznEif09XhqW4Xa14ZONuV4e3sx/QnZjBLM75KdHeF
	 IcA5Oevr8HpkyeiUVBgRVdzJwt3NFhP6PLU8rBkxC3WIz08L4rs/JmGxK+iLYo6Shc
	 LjNtoyGA7O4ifiYBHJZetBNGDm+oMqxp2yCtADnZ+r/Gqm3VjK9ULJ6ONypXfGiLHl
	 WCBkzuKa/F+iKx4sbXZBDs6I37xvL7/hzsr23zsrdT3gbBwFg/1OfmCwSGo7bXWStu
	 rbb4H8xPPjZZtNxU5rmp+/Qp5BYzwXLKhzMSNFPbxsggVZw6RAuqCVv4kw2OjOEH+/
	 5fD95LK+VJ+Bw==
Content-Type: multipart/mixed; boundary="===============5291971639307312139=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <0956384a0b29a47199ebc6f2d1e88c6e2da6eec21b145df1846e56e7097534a5@mail.kernel.org>
In-Reply-To: <20251216052623.2697-2-kerneljasonxing@gmail.com>
References: <20251216052623.2697-2-kerneljasonxing@gmail.com>
Subject: Re: [PATCH bpf-next v2 1/2] xsk: introduce local_cq for each af_xdp socket
From: bot+bpf-ci@kernel.org
To: kerneljasonxing@gmail.com,davem@davemloft.net,edumazet@google.com,kuba@kernel.org,pabeni@redhat.com,bjorn@kernel.org,magnus.karlsson@intel.com,maciej.fijalkowski@intel.com,jonathan.lemon@gmail.com,sdf@fomichev.me,ast@kernel.org,daniel@iogearbox.net,hawk@kernel.org,john.fastabend@gmail.com
Cc: bpf@vger.kernel.org,netdev@vger.kernel.org,kernelxing@tencent.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Tue, 16 Dec 2025 05:46:24 +0000 (UTC)

--===============5291971639307312139==
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
> +
>  struct xdp_sock {
>  	/* struct sock must be the first member of struct xdp_sock */
>  	struct sock sk;
> @@ -89,6 +95,8 @@ struct xdp_sock {
>  	struct mutex mutex;
>  	struct xsk_queue *fq_tmp; /* Only as tmp storage before bind */
>  	struct xsk_queue *cq_tmp; /* Only as tmp storage before bind */
> +	/* Maintain addr(s) of descriptors locally */
> +	struct local_cq *lcq;
>  };

[ ... ]

> diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> index f093c3453f64..9b637d5e4528 100644
> --- a/net/xdp/xsk.c
> +++ b/net/xdp/xsk.c
> @@ -1212,6 +1212,30 @@ static void xsk_delete_from_maps(struct xdp_sock *xs)
>  	}
>  }
>
> +/* Initialize local compeletion queue for each xsk */
> +static int xsk_init_local_cq(struct xdp_sock *xs)
> +{
> +	struct xsk_queue *cq = xs->pool->cq;
> +	size_t size;
> +
> +	if (!cq || !cq->nentries)
> +		return -EINVAL;
> +
> +	size = struct_size_t(struct local_cq, desc, cq->nentries);
> +	xs->lcq = vmalloc(size);
> +	if (!xs->lcq)
> +		return -ENOMEM;
> +	xs->lcq->ring_mask = cq->nentries - 1;
> +	xs->lcq->prod = 0;
> +
> +	return 0;
> +}
> +
> +static void xsk_clear_local_cq(struct xdp_sock *xs)
> +{
> +	vfree(xs->lcq);

Can this lead to a double-free? When xsk_bind() fails after
xsk_init_local_cq() succeeds, xsk_clear_local_cq() is called in the
error path, freeing xs->lcq. However, xs->lcq is not set to NULL after
the vfree(). Later when the socket is closed, xsk_release() calls
xsk_clear_local_cq() again, causing vfree() to be called on the
already-freed pointer.

The path would be: xsk_bind()->xsk_init_local_cq() succeeds, allocating
xs->lcq. Then xp_assign_dev_shared() fails, triggering the error path
that calls xsk_clear_local_cq(). The bind fails and returns to userspace.
User closes the socket, triggering xsk_release()->xsk_clear_local_cq(),
which calls vfree() on the dangling xs->lcq pointer.

Should xs->lcq be set to NULL after the vfree to prevent this double-free?

> +}
> +
>  static int xsk_release(struct socket *sock)
>  {
>  	struct sock *sk = sock->sk;
> @@ -1241,6 +1265,7 @@ static int xsk_release(struct socket *sock)
>  	xskq_destroy(xs->tx);
>  	xskq_destroy(xs->fq_tmp);
>  	xskq_destroy(xs->cq_tmp);
> +	xsk_clear_local_cq(xs);
>
>  	sock_orphan(sk);
>  	sock->sk = NULL;

[ ... ]

> @@ -1360,9 +1385,18 @@ static int xsk_bind(struct socket *sock, struct sockaddr_unsized *addr, int addr
>  				goto out_unlock;
>  			}
>
> +			err = xsk_init_local_cq(xs);
> +			if (err) {
> +				xp_destroy(xs->pool);
> +				xs->pool = NULL;
> +				sockfd_put(sock);
> +				goto out_unlock;
> +			}
> +
>  			err = xp_assign_dev_shared(xs->pool, umem_xs, dev,
>  						   qid);
>  			if (err) {
> +				xsk_clear_local_cq(xs);
>  				xp_destroy(xs->pool);
>  				xs->pool = NULL;
>  				sockfd_put(sock);

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/20257706446

--===============5291971639307312139==--

