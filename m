Return-Path: <bpf+bounces-29203-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 981128C12A4
	for <lists+bpf@lfdr.de>; Thu,  9 May 2024 18:22:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B98B01C216C4
	for <lists+bpf@lfdr.de>; Thu,  9 May 2024 16:22:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDA0316F8FF;
	Thu,  9 May 2024 16:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mqSd014o"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3918C16F85D;
	Thu,  9 May 2024 16:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715271728; cv=none; b=UK0bYPTa7NORf1TXQeuwyMJIYlUNnjMe7BKME8GGS1XyfzXxDgiN0sFcwIOR0GfRsQ1AP9HCMmJ9XntMdRoEe8agxQAqqrKtsNC3+zKdprHJ7LDckpBUnugR7EUj/IjeqV8j4a3Ge1QdzRuSpkR/lKdhXTm+D/6zKtgK26onjII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715271728; c=relaxed/simple;
	bh=IL8r0xvUD4MebH1iIU9DukAU1bJeaYL6vvG94QxaVag=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Eh26W0gr5+qBn46ZhOl5K7kUAOC9TLJPq8LCkV+je0osDmDyNN6FNSBos3nqy8BB9n81MFUbkjf/vieU7G1r50ZG5+sTkEZIUdKs32L4hskoJmS+onEv2rjgLjJG8rh2GlD4ZBxb8Y6NCv764uMMD+QIvpU2efZZc1NfZ57SlwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mqSd014o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A560C116B1;
	Thu,  9 May 2024 16:22:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715271727;
	bh=IL8r0xvUD4MebH1iIU9DukAU1bJeaYL6vvG94QxaVag=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=mqSd014oPs9qMHfbf/w8UGWecJ/yMDeavDW24z8I4EtEKoQeD7wUBGkkSeaQbqviB
	 7Hhh2L/zrybj872eMv3TTgYZMkgsoczJhjH1hgBU9UXXo86WNk2fiPGXZurnJialdC
	 BVgFon/xiKXRw6Sp584BztAToQj1JJIDU11EPN+7FBnaFG+IH2HtB3NOGP32Lswvtc
	 a6hrGif9DMQkpjLlBGXx4lpNNU6GAR+1Rgwi98ywB3s10lSkOAoN58c6LpFRthelWY
	 JDQYpaAZErNik/8VqDYJwKChrTECMtGImS7jCCS/sjSt5xFlbtFQP9Il14xUowCWx4
	 TOjoj1Wxr7vWQ==
Date: Thu, 9 May 2024 09:22:05 -0700 (PDT)
From: Mat Martineau <martineau@kernel.org>
To: Yunsheng Lin <linyunsheng@huawei.com>
cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
    netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
    Alexander Duyck <alexander.duyck@gmail.com>, 
    Ayush Sawal <ayush.sawal@chelsio.com>, Eric Dumazet <edumazet@google.com>, 
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
    Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>, 
    Jiri Pirko <jiri@resnulli.us>, Boris Pismenny <borisp@nvidia.com>, 
    bpf@vger.kernel.org, mptcp@lists.linux.dev
Subject: Re: [PATCH net-next v3 11/13] net: replace page_frag with
 page_frag_cache
In-Reply-To: <20240508133408.54708-12-linyunsheng@huawei.com>
Message-ID: <334a8c67-87c8-a918-9517-0afbfae0d02b@kernel.org>
References: <20240508133408.54708-1-linyunsheng@huawei.com> <20240508133408.54708-12-linyunsheng@huawei.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

On Wed, 8 May 2024, Yunsheng Lin wrote:

> Use the newly introduced prepare/probe/commit API to
> replace page_frag with page_frag_cache for sk_page_frag().
>
> CC: Alexander Duyck <alexander.duyck@gmail.com>
> Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
> ---
> .../chelsio/inline_crypto/chtls/chtls.h       |   3 -
> .../chelsio/inline_crypto/chtls/chtls_io.c    | 100 ++++---------
> .../chelsio/inline_crypto/chtls/chtls_main.c  |   3 -
> drivers/net/tun.c                             |  28 ++--
> include/linux/sched.h                         |   4 +-
> include/net/sock.h                            |  14 +-
> kernel/exit.c                                 |   3 +-
> kernel/fork.c                                 |   3 +-
> net/core/skbuff.c                             |  32 ++--
> net/core/skmsg.c                              |  22 +--
> net/core/sock.c                               |  46 ++++--
> net/ipv4/ip_output.c                          |  33 +++--
> net/ipv4/tcp.c                                |  35 ++---
> net/ipv4/tcp_output.c                         |  28 ++--
> net/ipv6/ip6_output.c                         |  33 +++--
> net/kcm/kcmsock.c                             |  30 ++--
> net/mptcp/protocol.c                          |  70 +++++----
> net/sched/em_meta.c                           |   2 +-
> net/tls/tls_device.c                          | 139 ++++++++++--------
> 19 files changed, 331 insertions(+), 297 deletions(-)
>

<snip>

> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index bb8f96f2b86f..ab844011d442 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -960,17 +960,18 @@ static bool mptcp_skb_can_collapse_to(u64 write_seq,
> }
>
> /* we can append data to the given data frag if:
> - * - there is space available in the backing page_frag
> - * - the data frag tail matches the current page_frag free offset
> + * - there is space available for the current page
> + * - the data frag tail matches the current page and offset
>  * - the data frag end sequence number matches the current write seq
>  */
> static bool mptcp_frag_can_collapse_to(const struct mptcp_sock *msk,
> -				       const struct page_frag *pfrag,
> +				       const struct page *page,
> +				       const unsigned int offset,
> +				       const unsigned int size,

Hi Yunsheng -

Why add the 'size' parameter here? It's checked to be a nonzero value, but 
it can only be 0 if page is also NULL. In this case "page == df->page" 
will be false, so the function will return false even without checking 
'size'.

Thanks,

Mat

> 				       const struct mptcp_data_frag *df)
> {
> -	return df && pfrag->page == df->page &&
> -		pfrag->size - pfrag->offset > 0 &&
> -		pfrag->offset == (df->offset + df->data_len) &&
> +	return df && size && page == df->page &&
> +		offset == (df->offset + df->data_len) &&
> 		df->data_seq + df->data_len == msk->write_seq;
> }
>
> @@ -1085,30 +1086,36 @@ static void mptcp_enter_memory_pressure(struct sock *sk)
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
> @@ -1793,7 +1800,7 @@ static u32 mptcp_send_limit(const struct sock *sk)
> static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
> {
> 	struct mptcp_sock *msk = mptcp_sk(sk);
> -	struct page_frag *pfrag;
> +	struct page_frag_cache *pfrag;
> 	size_t copied = 0;
> 	int ret = 0;
> 	long timeo;
> @@ -1832,9 +1839,12 @@ static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
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
> @@ -1845,21 +1855,26 @@ static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
> 		 * page allocator
> 		 */
> 		dfrag = mptcp_pending_tail(sk);
> -		dfrag_collapsed = mptcp_frag_can_collapse_to(msk, pfrag, dfrag);
> +		page = page_frag_alloc_probe(pfrag, &offset, &size, &va);
> +		dfrag_collapsed = mptcp_frag_can_collapse_to(msk, page, offset,
> +							     size, dfrag);
> 		if (!dfrag_collapsed) {
> -			if (!mptcp_page_frag_refill(sk, pfrag))
> +			size = 32U + sizeof(struct mptcp_data_frag);
> +			page = mptcp_page_frag_alloc_prepare(sk, pfrag, &offset,
> +							     &size, &va);
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
> @@ -1867,8 +1882,7 @@ static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
> 		if (!sk_wmem_schedule(sk, total_ts))
> 			goto wait_for_memory;
>
> -		ret = do_copy_data_nocache(sk, psize, &msg->msg_iter,
> -					   page_address(dfrag->page) + offset);
> +		ret = do_copy_data_nocache(sk, psize, &msg->msg_iter, va);
> 		if (ret)
> 			goto do_error;
>
> @@ -1877,7 +1891,6 @@ static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
> 		copied += psize;
> 		dfrag->data_len += psize;
> 		frag_truesize += psize;
> -		pfrag->offset += frag_truesize;
> 		WRITE_ONCE(msk->write_seq, msk->write_seq + psize);
>
> 		/* charge data on mptcp pending queue to the msk socket
> @@ -1885,11 +1898,14 @@ static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
> 		 */
> 		sk_wmem_queued_add(sk, frag_truesize);
> 		if (!dfrag_collapsed) {
> -			get_page(dfrag->page);
> +			page_frag_alloc_commit(pfrag, frag_truesize);
> 			list_add_tail(&dfrag->list, &msk->rtx_queue);
> 			if (!msk->first_pending)
> 				WRITE_ONCE(msk->first_pending, dfrag);
> +		} else {
> +			page_frag_alloc_commit_noref(pfrag, frag_truesize);
> 		}
> +
> 		pr_debug("msk=%p dfrag at seq=%llu len=%u sent=%u new=%d", msk,
> 			 dfrag->data_seq, dfrag->data_len, dfrag->already_sent,
> 			 !dfrag_collapsed);


