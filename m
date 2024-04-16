Return-Path: <bpf+bounces-26880-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 22B4E8A6070
	for <lists+bpf@lfdr.de>; Tue, 16 Apr 2024 03:37:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 313891C213EE
	for <lists+bpf@lfdr.de>; Tue, 16 Apr 2024 01:37:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 366DE7484;
	Tue, 16 Apr 2024 01:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C9ZIUnbF"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A68127464;
	Tue, 16 Apr 2024 01:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713231426; cv=none; b=ndRVrfbZRa/1yc92TKSLrb5HAT3bpvUMS4HpVsd9uoEJR43E3kU7UZ+S8+N/P96SHWN01fHCz93F+TU6Ls2+17d5sDcwjj5p6Emw/SNqFb1vVoVufaI1WsNchJcae69w2RfBH8DqlS8kQV84j+KS+fSPAFIDJ3aop7ZWFa1OJ8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713231426; c=relaxed/simple;
	bh=MRnZAn/34/F3uJzAswtdGPYBP2MTvfc7DxyHqDFZPv0=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=c/BhO+0VISJ99bTPACSluL9RoVkE7hpSJwV1nrI8JDO5DTj9kmH75AsWrOm6oV9naEKAAecuqnmKp7G8U9lW+Y54TvRvofSk6vAdZYWp4QbovcpEH2g0bq8yMO7gG8jatbCu2bDWYV5VXgolNg3651IH4Ny5J1nADg/MNAYy6iU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C9ZIUnbF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B616C113CC;
	Tue, 16 Apr 2024 01:37:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713231426;
	bh=MRnZAn/34/F3uJzAswtdGPYBP2MTvfc7DxyHqDFZPv0=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=C9ZIUnbF8xh0maYgafKeDukAR2aeT1Rt6m7K2ugQmk3IGeVfsihYYbtq1pFn670UR
	 5xBf0WObLpZpdGoVO1Qkmsz8Hr3MunXRaLBz80pZIIHrVYzultJFe/2WhM6xNIpHDL
	 QbpHf6nnl3TGyHyaT1LdkkezNGjH3H7V0LydiO5e4tQkw65he8/xiY+UcL7DyvqjmP
	 +sXDpglVwlNx+11TFrJF94NT//QARhkZKh1OiKxnpjcL4zsXxzY8Vm9q5XBQrmSOPe
	 gzh7L7EkwWSo007LFgLgUO5aUyLR/QVIvt0PJAUZOaeQ6EcDSLDEIMdTHEZkbM61zQ
	 k+8T4xUnvaNqw==
Date: Mon, 15 Apr 2024 18:37:05 -0700 (PDT)
From: Mat Martineau <martineau@kernel.org>
To: Yunsheng Lin <linyunsheng@huawei.com>, Paolo Abeni <pabeni@redhat.com>
cc: davem@davemloft.net, kuba@kernel.org, netdev@vger.kernel.org, 
    linux-kernel@vger.kernel.org, Ayush Sawal <ayush.sawal@chelsio.com>, 
    Eric Dumazet <edumazet@google.com>, 
    Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
    Jason Wang <jasowang@redhat.com>, Ingo Molnar <mingo@redhat.com>, 
    Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, 
    Vincent Guittot <vincent.guittot@linaro.org>, 
    Dietmar Eggemann <dietmar.eggemann@arm.com>, 
    Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, 
    Mel Gorman <mgorman@suse.de>, 
    Daniel Bristot de Oliveira <bristot@redhat.com>, 
    Valentin Schneider <vschneid@redhat.com>, 
    John Fastabend <john.fastabend@gmail.com>, 
    Jakub Sitnicki <jakub@cloudflare.com>, David Ahern <dsahern@kernel.org>, 
    Matthieu Baerts <matttbe@kernel.org>, Geliang Tang <geliang@kernel.org>, 
    Boris Pismenny <borisp@nvidia.com>, bpf@vger.kernel.org, 
    mptcp@lists.linux.dev
Subject: Re: [PATCH net-next v2 13/15] net: replace page_frag with
 page_frag_cache
In-Reply-To: <20240415131941.51153-14-linyunsheng@huawei.com>
Message-ID: <c5a8eabb-1b46-1e9f-88c9-e707c3a086c4@kernel.org>
References: <20240415131941.51153-1-linyunsheng@huawei.com> <20240415131941.51153-14-linyunsheng@huawei.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

On Mon, 15 Apr 2024, Yunsheng Lin wrote:

> Use the newly introduced prepare/commit API to replace
> page_frag with page_frag_cache for sk_page_frag().
>
> Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
> ---
> .../chelsio/inline_crypto/chtls/chtls.h       |   3 -
> .../chelsio/inline_crypto/chtls/chtls_io.c    | 101 ++++---------
> .../chelsio/inline_crypto/chtls/chtls_main.c  |   3 -
> drivers/net/tun.c                             |  34 ++---
> include/linux/sched.h                         |   4 +-
> include/net/sock.h                            |  14 +-
> kernel/exit.c                                 |   3 +-
> kernel/fork.c                                 |   2 +-
> net/core/skbuff.c                             |  32 ++--
> net/core/skmsg.c                              |  22 +--
> net/core/sock.c                               |  46 ++++--
> net/ipv4/ip_output.c                          |  35 +++--
> net/ipv4/tcp.c                                |  35 ++---
> net/ipv4/tcp_output.c                         |  28 ++--
> net/ipv6/ip6_output.c                         |  35 +++--
> net/kcm/kcmsock.c                             |  30 ++--
> net/mptcp/protocol.c                          |  74 ++++++----
> net/tls/tls_device.c                          | 139 ++++++++++--------
> 18 files changed, 342 insertions(+), 298 deletions(-)

Hi Yunsheng,

Just focusing on mptcp:

> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index f8bc34f0d973..368dd480c4cd 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -959,17 +959,16 @@ static bool mptcp_skb_can_collapse_to(u64 write_seq,
> }
>
> /* we can append data to the given data frag if:
> - * - there is space available in the backing page_frag
> - * - the data frag tail matches the current page_frag free offset
> + * - the data frag tail matches the current page and offset
>  * - the data frag end sequence number matches the current write seq
>  */
> static bool mptcp_frag_can_collapse_to(const struct mptcp_sock *msk,
> -				       const struct page_frag *pfrag,
> +				       const struct page *page,
> +				       const unsigned int offset,
> 				       const struct mptcp_data_frag *df)
> {
> -	return df && pfrag->page == df->page &&
> -		pfrag->size - pfrag->offset > 0 &&
> -		pfrag->offset == (df->offset + df->data_len) &&
> +	return df && page == df->page &&
> +		offset == (df->offset + df->data_len) &&
> 		df->data_seq + df->data_len == msk->write_seq;
> }
>
> @@ -1084,30 +1083,36 @@ static void mptcp_enter_memory_pressure(struct sock *sk)
> /* ensure we get enough memory for the frag hdr, beyond some minimal amount of
>  * data
>  */
> -static bool mptcp_page_frag_refill(struct sock *sk, struct page_frag *pfrag)
> +static struct page *mptcp_page_frag_alloc_prepare(struct sock *sk,
> +						  struct page_frag_cache *pfrag,
> +						  unsigned int *offset,
> +						  unsigned int *size, void **va)
> {
> -	if (likely(skb_page_frag_refill(32U + sizeof(struct mptcp_data_frag),
> -					pfrag, sk->sk_allocation)))
> -		return true;
> +	struct page *page;
> +
> +	page = page_frag_alloc_prepare(pfrag, offset, size, va,
> +				       sk->sk_allocation);
> +	if (likely(page))
> +		return page;
>
> 	mptcp_enter_memory_pressure(sk);
> -	return false;
> +	return NULL;
> }
>
> static struct mptcp_data_frag *
> -mptcp_carve_data_frag(const struct mptcp_sock *msk, struct page_frag *pfrag,
> -		      int orig_offset)
> +mptcp_carve_data_frag(const struct mptcp_sock *msk, struct page *page,
> +		      unsigned int orig_offset)
> {
> 	int offset = ALIGN(orig_offset, sizeof(long));
> 	struct mptcp_data_frag *dfrag;
>
> -	dfrag = (struct mptcp_data_frag *)(page_to_virt(pfrag->page) + offset);
> +	dfrag = (struct mptcp_data_frag *)(page_to_virt(page) + offset);
> 	dfrag->data_len = 0;
> 	dfrag->data_seq = msk->write_seq;
> 	dfrag->overhead = offset - orig_offset + sizeof(struct mptcp_data_frag);
> 	dfrag->offset = offset + sizeof(struct mptcp_data_frag);
> 	dfrag->already_sent = 0;
> -	dfrag->page = pfrag->page;
> +	dfrag->page = page;
>
> 	return dfrag;
> }
> @@ -1792,7 +1797,7 @@ static u32 mptcp_send_limit(const struct sock *sk)
> static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
> {
> 	struct mptcp_sock *msk = mptcp_sk(sk);
> -	struct page_frag *pfrag;
> +	struct page_frag_cache *pfrag;
> 	size_t copied = 0;
> 	int ret = 0;
> 	long timeo;
> @@ -1831,9 +1836,12 @@ static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
> 	while (msg_data_left(msg)) {
> 		int total_ts, frag_truesize = 0;
> 		struct mptcp_data_frag *dfrag;
> -		bool dfrag_collapsed;
> -		size_t psize, offset;
> +		bool dfrag_collapsed = false;
> +		unsigned int offset, size;
> +		struct page *page;
> +		size_t psize;
> 		u32 copy_limit;
> +		void *va;
>
> 		/* ensure fitting the notsent_lowat() constraint */
> 		copy_limit = mptcp_send_limit(sk);
> @@ -1844,21 +1852,31 @@ static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
> 		 * page allocator
> 		 */
> 		dfrag = mptcp_pending_tail(sk);
> -		dfrag_collapsed = mptcp_frag_can_collapse_to(msk, pfrag, dfrag);
> +		size = 32U;
> +		page = mptcp_page_frag_alloc_prepare(sk, pfrag, &offset, &size,
> +						     &va);
> +		if (!page)
> +			goto wait_for_memory;
> +
> +		dfrag_collapsed = mptcp_frag_can_collapse_to(msk, page, offset,
> +							     dfrag);
> 		if (!dfrag_collapsed) {
> -			if (!mptcp_page_frag_refill(sk, pfrag))
> +			size = 32U + sizeof(struct mptcp_data_frag);
> +			page = mptcp_page_frag_alloc_prepare(sk, pfrag, &offset,
> +							     &size, &va);

Since 'size' was updated to contain the maximum available space on the 
first call to mptcp_page_frag_alloc_prepare(), is it necessary to call it 
again instead of checking to see if 'size' is large enough for the 
mptcp_data_frag struct?

> +			if (!page)
> 				goto wait_for_memory;
>
> -			dfrag = mptcp_carve_data_frag(msk, pfrag, pfrag->offset);
> +			dfrag = mptcp_carve_data_frag(msk, page, offset);
> 			frag_truesize = dfrag->overhead;
> +			va += dfrag->overhead;
> 		}
>
> 		/* we do not bound vs wspace, to allow a single packet.
> 		 * memory accounting will prevent execessive memory usage
> 		 * anyway
> 		 */
> -		offset = dfrag->offset + dfrag->data_len;
> -		psize = pfrag->size - offset;
> +		psize = size - frag_truesize;
> 		psize = min_t(size_t, psize, msg_data_left(msg));
> 		psize = min_t(size_t, psize, copy_limit);
> 		total_ts = psize + frag_truesize;
> @@ -1866,8 +1884,7 @@ static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
> 		if (!sk_wmem_schedule(sk, total_ts))
> 			goto wait_for_memory;
>
> -		ret = do_copy_data_nocache(sk, psize, &msg->msg_iter,
> -					   page_address(dfrag->page) + offset);
> +		ret = do_copy_data_nocache(sk, psize, &msg->msg_iter, va);
> 		if (ret)
> 			goto do_error;
>
> @@ -1876,7 +1893,6 @@ static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
> 		copied += psize;
> 		dfrag->data_len += psize;
> 		frag_truesize += psize;
> -		pfrag->offset += frag_truesize;
> 		WRITE_ONCE(msk->write_seq, msk->write_seq + psize);
>
> 		/* charge data on mptcp pending queue to the msk socket
> @@ -1884,11 +1900,15 @@ static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
> 		 */
> 		sk_wmem_queued_add(sk, frag_truesize);
> 		if (!dfrag_collapsed) {
> -			get_page(dfrag->page);
> +			page_frag_alloc_commit(pfrag, offset, frag_truesize);

It would be more efficient (but more complicated) to defer the commit 
until the loop is done or the maximum frag size is reached. This would 
perform more like the older code, which only had to call refill when 
mptcp_frag_can_collapse_to() returned false.

- Mat

> 			list_add_tail(&dfrag->list, &msk->rtx_queue);
> 			if (!msk->first_pending)
> 				WRITE_ONCE(msk->first_pending, dfrag);
> +		} else {
> +			page_frag_alloc_commit_noref(pfrag, offset,
> +						     frag_truesize);
> 		}
> +
> 		pr_debug("msk=%p dfrag at seq=%llu len=%u sent=%u new=%d", msk,
> 			 dfrag->data_seq, dfrag->data_len, dfrag->already_sent,
> 			 !dfrag_collapsed);

