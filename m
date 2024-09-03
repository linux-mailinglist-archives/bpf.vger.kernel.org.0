Return-Path: <bpf+bounces-38770-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F28BD969E4C
	for <lists+bpf@lfdr.de>; Tue,  3 Sep 2024 14:48:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2D9F2B24483
	for <lists+bpf@lfdr.de>; Tue,  3 Sep 2024 12:48:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E6CF1A7274;
	Tue,  3 Sep 2024 12:48:01 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E16951A725B;
	Tue,  3 Sep 2024 12:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725367681; cv=none; b=DBXxPmqoTCQ7t+ldPKIhUUTtlx2TlDzkA7r+TJELunLoi2Kq702SAQAvvlaI1KlbT3fR2S/aVj4ZjUH03b7vCAjBeZN1uAKY5Kj3uzjCP2qW7gl7PrMlg8YZC+cIdZcbBshKuAr92RETITSwt0ztoeqmX9cZgfRLc/xqrTPPcok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725367681; c=relaxed/simple;
	bh=mYbd71lGUzUQ57BmQj8HsgapoJknNeb9nR0CqAID+lk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=CsEEDuKZXcaWWBZvAzjVej3Vtgpr1YsWQakM7aaoxu4exKFN0m/yUDTYgrvlLwgu8HlUGBi54NUBQjaY9oWXMjnbRdskdS1aIbB+yguMWW7RU2I2QeePjPD8xbM0YHZJo1OzqjMFDHQe3CfD4XS1JSles8okOmvi4mYuCSjg2uQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4WylkX0PhbzyR2T;
	Tue,  3 Sep 2024 20:47:00 +0800 (CST)
Received: from dggpemf200006.china.huawei.com (unknown [7.185.36.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 8284B18010A;
	Tue,  3 Sep 2024 20:47:56 +0800 (CST)
Received: from [10.67.120.129] (10.67.120.129) by
 dggpemf200006.china.huawei.com (7.185.36.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 3 Sep 2024 20:47:55 +0800
Message-ID: <6b9503fe-566c-49bb-97b9-941090f9cf7e@huawei.com>
Date: Tue, 3 Sep 2024 20:47:54 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v17 12/14] net: replace page_frag with
 page_frag_cache
To: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>, Mat
 Martineau <martineau@kernel.org>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Alexander Duyck
	<alexander.duyck@gmail.com>, Ayush Sawal <ayush.sawal@chelsio.com>, Eric
 Dumazet <edumazet@google.com>, Willem de Bruijn
	<willemdebruijn.kernel@gmail.com>, Jason Wang <jasowang@redhat.com>, Ingo
 Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Juri Lelli
	<juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt
	<rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman
	<mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, John Fastabend
	<john.fastabend@gmail.com>, Jakub Sitnicki <jakub@cloudflare.com>, David
 Ahern <dsahern@kernel.org>, Matthieu Baerts <matttbe@kernel.org>, Geliang
 Tang <geliang@kernel.org>, Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang
	<xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, Boris Pismenny
	<borisp@nvidia.com>, <bpf@vger.kernel.org>, <mptcp@lists.linux.dev>
References: <20240902120314.508180-1-linyunsheng@huawei.com>
 <20240902120314.508180-13-linyunsheng@huawei.com>
Content-Language: en-US
From: Yunsheng Lin <linyunsheng@huawei.com>
In-Reply-To: <20240902120314.508180-13-linyunsheng@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemf200006.china.huawei.com (7.185.36.61)

On 2024/9/2 20:03, Yunsheng Lin wrote:
> Use the newly introduced prepare/probe/commit API to
> replace page_frag with page_frag_cache for sk_page_frag().
> 
> CC: Alexander Duyck <alexander.duyck@gmail.com>
> Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>

Hi, Mat

As new refactoring and new API naming is used since v14, the
replacing patch have bigger change to use the new API naming too,
so I dropped your 'Acked-by' tag when using the new API.

It would good to review it again so that this patch doesn't
break mptcp when you are not busy, thanks.

> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 37ebcb7640eb..5fbddd9de53e 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -960,7 +960,6 @@ static bool mptcp_skb_can_collapse_to(u64 write_seq,
>  }
>  
>  /* we can append data to the given data frag if:
> - * - there is space available in the backing page_frag
>   * - the data frag tail matches the current page_frag free offset
>   * - the data frag end sequence number matches the current write seq
>   */
> @@ -969,7 +968,6 @@ static bool mptcp_frag_can_collapse_to(const struct mptcp_sock *msk,
>  				       const struct mptcp_data_frag *df)
>  {
>  	return df && pfrag->page == df->page &&
> -		pfrag->size - pfrag->offset > 0 &&
>  		pfrag->offset == (df->offset + df->data_len) &&
>  		df->data_seq + df->data_len == msk->write_seq;
>  }
> @@ -1085,14 +1083,20 @@ static void mptcp_enter_memory_pressure(struct sock *sk)
>  /* ensure we get enough memory for the frag hdr, beyond some minimal amount of
>   * data
>   */
> -static bool mptcp_page_frag_refill(struct sock *sk, struct page_frag *pfrag)
> +static void *mptcp_page_frag_alloc_refill_prepare(struct sock *sk,
> +						  struct page_frag_cache *nc,
> +						  struct page_frag *pfrag)
>  {
> -	if (likely(skb_page_frag_refill(32U + sizeof(struct mptcp_data_frag),
> -					pfrag, sk->sk_allocation)))
> -		return true;
> +	unsigned int fragsz = 32U + sizeof(struct mptcp_data_frag);
> +	void *va;
> +
> +	va = page_frag_alloc_refill_prepare(nc, fragsz, pfrag,
> +					    sk->sk_allocation);
> +	if (likely(va))
> +		return va;
>  
>  	mptcp_enter_memory_pressure(sk);
> -	return false;
> +	return NULL;
>  }
>  
>  static struct mptcp_data_frag *
> @@ -1795,7 +1799,7 @@ static u32 mptcp_send_limit(const struct sock *sk)
>  static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
>  {
>  	struct mptcp_sock *msk = mptcp_sk(sk);
> -	struct page_frag *pfrag;
> +	struct page_frag_cache *nc;
>  	size_t copied = 0;
>  	int ret = 0;
>  	long timeo;
> @@ -1829,14 +1833,16 @@ static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
>  	if (unlikely(sk->sk_err || (sk->sk_shutdown & SEND_SHUTDOWN)))
>  		goto do_error;
>  
> -	pfrag = sk_page_frag(sk);
> +	nc = sk_page_frag_cache(sk);
>  
>  	while (msg_data_left(msg)) {
> +		struct page_frag page_frag, *pfrag;
>  		int total_ts, frag_truesize = 0;
>  		struct mptcp_data_frag *dfrag;
>  		bool dfrag_collapsed;
> -		size_t psize, offset;
>  		u32 copy_limit;
> +		size_t psize;
> +		void *va;
>  
>  		/* ensure fitting the notsent_lowat() constraint */
>  		copy_limit = mptcp_send_limit(sk);
> @@ -1847,21 +1853,26 @@ static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
>  		 * page allocator
>  		 */
>  		dfrag = mptcp_pending_tail(sk);
> -		dfrag_collapsed = mptcp_frag_can_collapse_to(msk, pfrag, dfrag);
> +		pfrag = &page_frag;
> +		va = page_frag_alloc_refill_probe(nc, 1, pfrag);
> +		dfrag_collapsed = va && mptcp_frag_can_collapse_to(msk, pfrag,
> +								   dfrag);
>  		if (!dfrag_collapsed) {
> -			if (!mptcp_page_frag_refill(sk, pfrag))
> +			va = mptcp_page_frag_alloc_refill_prepare(sk, nc,
> +								  pfrag);
> +			if (!va)
>  				goto wait_for_memory;
>  
>  			dfrag = mptcp_carve_data_frag(msk, pfrag, pfrag->offset);
>  			frag_truesize = dfrag->overhead;
> +			va += dfrag->overhead;
>  		}
>  
>  		/* we do not bound vs wspace, to allow a single packet.
>  		 * memory accounting will prevent execessive memory usage
>  		 * anyway
>  		 */
> -		offset = dfrag->offset + dfrag->data_len;
> -		psize = pfrag->size - offset;
> +		psize = pfrag->size - frag_truesize;
>  		psize = min_t(size_t, psize, msg_data_left(msg));
>  		psize = min_t(size_t, psize, copy_limit);
>  		total_ts = psize + frag_truesize;
> @@ -1869,8 +1880,7 @@ static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
>  		if (!sk_wmem_schedule(sk, total_ts))
>  			goto wait_for_memory;
>  
> -		ret = do_copy_data_nocache(sk, psize, &msg->msg_iter,
> -					   page_address(dfrag->page) + offset);
> +		ret = do_copy_data_nocache(sk, psize, &msg->msg_iter, va);
>  		if (ret)
>  			goto do_error;
>  
> @@ -1879,7 +1889,6 @@ static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
>  		copied += psize;
>  		dfrag->data_len += psize;
>  		frag_truesize += psize;
> -		pfrag->offset += frag_truesize;
>  		WRITE_ONCE(msk->write_seq, msk->write_seq + psize);
>  
>  		/* charge data on mptcp pending queue to the msk socket
> @@ -1887,10 +1896,12 @@ static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
>  		 */
>  		sk_wmem_queued_add(sk, frag_truesize);
>  		if (!dfrag_collapsed) {
> -			get_page(dfrag->page);
> +			page_frag_commit(nc, pfrag, frag_truesize);
>  			list_add_tail(&dfrag->list, &msk->rtx_queue);
>  			if (!msk->first_pending)
>  				WRITE_ONCE(msk->first_pending, dfrag);
> +		} else {
> +			page_frag_commit_noref(nc, pfrag, frag_truesize);
>  		}
>  		pr_debug("msk=%p dfrag at seq=%llu len=%u sent=%u new=%d\n", msk,
>  			 dfrag->data_seq, dfrag->data_len, dfrag->already_sent,


