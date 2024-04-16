Return-Path: <bpf+bounces-26950-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EB8258A6BEC
	for <lists+bpf@lfdr.de>; Tue, 16 Apr 2024 15:11:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 60E961F2199E
	for <lists+bpf@lfdr.de>; Tue, 16 Apr 2024 13:11:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E3E412C549;
	Tue, 16 Apr 2024 13:11:36 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5370312C462;
	Tue, 16 Apr 2024 13:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713273095; cv=none; b=ox6sr3F4MGbeFgFsrhD9MAxaaHIUXXS/vlvJsNSSpD9az4dCLQNmv5QqPd0Q828zNQMQzjoBeH8wOGuz0UGEXFB+rMyIo7U9twdc5+YknKxtgF56YaLIYfFPf3mg8sErhJb/JUecqYFRkMU7+UPC8x2NP7oT3ZE5HGClSKr/Zyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713273095; c=relaxed/simple;
	bh=VtghAz6a6yMkKLtdSyh9PvKwZg9JMfOvq9+2URGMbVY=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=RmPYDqPXOfdzPwPi8QYWJv+o+PbIkwbooyQo17ki3nMwz4bIB2FhJmsz0EFAAvPGbf3/L28iJjApulF4UWWTJmygS6mCx+pgxNkkwKg8xAaeL5UDRdsdZCJ7bX2YC9ylI8tXq6qFy1YHXjkdeZmrGhL4UGcQOc4Ka8PpuAVO6kU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4VJkqs31Nmz2CcLY;
	Tue, 16 Apr 2024 21:08:25 +0800 (CST)
Received: from dggpemm500005.china.huawei.com (unknown [7.185.36.74])
	by mail.maildlp.com (Postfix) with ESMTPS id B099118002D;
	Tue, 16 Apr 2024 21:11:22 +0800 (CST)
Received: from [10.69.30.204] (10.69.30.204) by dggpemm500005.china.huawei.com
 (7.185.36.74) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Tue, 16 Apr
 2024 21:11:22 +0800
Subject: Re: [PATCH net-next v2 13/15] net: replace page_frag with
 page_frag_cache
To: Mat Martineau <martineau@kernel.org>, Paolo Abeni <pabeni@redhat.com>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Ayush Sawal <ayush.sawal@chelsio.com>, Eric
 Dumazet <edumazet@google.com>, Willem de Bruijn
	<willemdebruijn.kernel@gmail.com>, Jason Wang <jasowang@redhat.com>, Ingo
 Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Juri Lelli
	<juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt
	<rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman
	<mgorman@suse.de>, Daniel Bristot de Oliveira <bristot@redhat.com>, Valentin
 Schneider <vschneid@redhat.com>, John Fastabend <john.fastabend@gmail.com>,
	Jakub Sitnicki <jakub@cloudflare.com>, David Ahern <dsahern@kernel.org>,
	Matthieu Baerts <matttbe@kernel.org>, Geliang Tang <geliang@kernel.org>,
	Boris Pismenny <borisp@nvidia.com>, <bpf@vger.kernel.org>,
	<mptcp@lists.linux.dev>
References: <20240415131941.51153-1-linyunsheng@huawei.com>
 <20240415131941.51153-14-linyunsheng@huawei.com>
 <c5a8eabb-1b46-1e9f-88c9-e707c3a086c4@kernel.org>
From: Yunsheng Lin <linyunsheng@huawei.com>
Message-ID: <cb541985-a06d-7a71-9e6d-38827ccdf875@huawei.com>
Date: Tue, 16 Apr 2024 21:11:22 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <c5a8eabb-1b46-1e9f-88c9-e707c3a086c4@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500005.china.huawei.com (7.185.36.74)

On 2024/4/16 9:37, Mat Martineau wrote:
> On Mon, 15 Apr 2024, Yunsheng Lin wrote:
> 
>> Use the newly introduced prepare/commit API to replace
>> page_frag with page_frag_cache for sk_page_frag().
>>
>> Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
>> ---
>> .../chelsio/inline_crypto/chtls/chtls.h       |   3 -
>> .../chelsio/inline_crypto/chtls/chtls_io.c    | 101 ++++---------
>> .../chelsio/inline_crypto/chtls/chtls_main.c  |   3 -
>> drivers/net/tun.c                             |  34 ++---
>> include/linux/sched.h                         |   4 +-
>> include/net/sock.h                            |  14 +-
>> kernel/exit.c                                 |   3 +-
>> kernel/fork.c                                 |   2 +-
>> net/core/skbuff.c                             |  32 ++--
>> net/core/skmsg.c                              |  22 +--
>> net/core/sock.c                               |  46 ++++--
>> net/ipv4/ip_output.c                          |  35 +++--
>> net/ipv4/tcp.c                                |  35 ++---
>> net/ipv4/tcp_output.c                         |  28 ++--
>> net/ipv6/ip6_output.c                         |  35 +++--
>> net/kcm/kcmsock.c                             |  30 ++--
>> net/mptcp/protocol.c                          |  74 ++++++----
>> net/tls/tls_device.c                          | 139 ++++++++++--------
>> 18 files changed, 342 insertions(+), 298 deletions(-)
> 
> Hi Yunsheng,
> 
> Just focusing on mptcp:

Thanks for reviewing.

> 
>> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
>> index f8bc34f0d973..368dd480c4cd 100644
>> --- a/net/mptcp/protocol.c
>> +++ b/net/mptcp/protocol.c
>> @@ -959,17 +959,16 @@ static bool mptcp_skb_can_collapse_to(u64 write_seq,
>> }
>>
>> /* we can append data to the given data frag if:
>> - * - there is space available in the backing page_frag
>> - * - the data frag tail matches the current page_frag free offset
>> + * - the data frag tail matches the current page and offset
>>  * - the data frag end sequence number matches the current write seq
>>  */
>> static bool mptcp_frag_can_collapse_to(const struct mptcp_sock *msk,
>> -                       const struct page_frag *pfrag,
>> +                       const struct page *page,
>> +                       const unsigned int offset,
>>                        const struct mptcp_data_frag *df)
>> {
>> -    return df && pfrag->page == df->page &&
>> -        pfrag->size - pfrag->offset > 0 &&
>> -        pfrag->offset == (df->offset + df->data_len) &&
>> +    return df && page == df->page &&
>> +        offset == (df->offset + df->data_len) &&
>>         df->data_seq + df->data_len == msk->write_seq;
>> }
>>
>> @@ -1084,30 +1083,36 @@ static void mptcp_enter_memory_pressure(struct sock *sk)
>> /* ensure we get enough memory for the frag hdr, beyond some minimal amount of
>>  * data
>>  */
>> -static bool mptcp_page_frag_refill(struct sock *sk, struct page_frag *pfrag)
>> +static struct page *mptcp_page_frag_alloc_prepare(struct sock *sk,
>> +                          struct page_frag_cache *pfrag,
>> +                          unsigned int *offset,
>> +                          unsigned int *size, void **va)
>> {
>> -    if (likely(skb_page_frag_refill(32U + sizeof(struct mptcp_data_frag),
>> -                    pfrag, sk->sk_allocation)))
>> -        return true;
>> +    struct page *page;
>> +
>> +    page = page_frag_alloc_prepare(pfrag, offset, size, va,
>> +                       sk->sk_allocation);
>> +    if (likely(page))
>> +        return page;
>>
>>     mptcp_enter_memory_pressure(sk);
>> -    return false;
>> +    return NULL;
>> }
>>
>> static struct mptcp_data_frag *
>> -mptcp_carve_data_frag(const struct mptcp_sock *msk, struct page_frag *pfrag,
>> -              int orig_offset)
>> +mptcp_carve_data_frag(const struct mptcp_sock *msk, struct page *page,
>> +              unsigned int orig_offset)
>> {
>>     int offset = ALIGN(orig_offset, sizeof(long));
>>     struct mptcp_data_frag *dfrag;
>>
>> -    dfrag = (struct mptcp_data_frag *)(page_to_virt(pfrag->page) + offset);
>> +    dfrag = (struct mptcp_data_frag *)(page_to_virt(page) + offset);
>>     dfrag->data_len = 0;
>>     dfrag->data_seq = msk->write_seq;
>>     dfrag->overhead = offset - orig_offset + sizeof(struct mptcp_data_frag);
>>     dfrag->offset = offset + sizeof(struct mptcp_data_frag);
>>     dfrag->already_sent = 0;
>> -    dfrag->page = pfrag->page;
>> +    dfrag->page = page;
>>
>>     return dfrag;
>> }
>> @@ -1792,7 +1797,7 @@ static u32 mptcp_send_limit(const struct sock *sk)
>> static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
>> {
>>     struct mptcp_sock *msk = mptcp_sk(sk);
>> -    struct page_frag *pfrag;
>> +    struct page_frag_cache *pfrag;
>>     size_t copied = 0;
>>     int ret = 0;
>>     long timeo;
>> @@ -1831,9 +1836,12 @@ static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
>>     while (msg_data_left(msg)) {
>>         int total_ts, frag_truesize = 0;
>>         struct mptcp_data_frag *dfrag;
>> -        bool dfrag_collapsed;
>> -        size_t psize, offset;
>> +        bool dfrag_collapsed = false;
>> +        unsigned int offset, size;
>> +        struct page *page;
>> +        size_t psize;
>>         u32 copy_limit;
>> +        void *va;
>>
>>         /* ensure fitting the notsent_lowat() constraint */
>>         copy_limit = mptcp_send_limit(sk);
>> @@ -1844,21 +1852,31 @@ static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
>>          * page allocator
>>          */
>>         dfrag = mptcp_pending_tail(sk);
>> -        dfrag_collapsed = mptcp_frag_can_collapse_to(msk, pfrag, dfrag);
>> +        size = 32U;
>> +        page = mptcp_page_frag_alloc_prepare(sk, pfrag, &offset, &size,
>> +                             &va);
>> +        if (!page)
>> +            goto wait_for_memory;
>> +
>> +        dfrag_collapsed = mptcp_frag_can_collapse_to(msk, page, offset,
>> +                                 dfrag);
>>         if (!dfrag_collapsed) {
>> -            if (!mptcp_page_frag_refill(sk, pfrag))
>> +            size = 32U + sizeof(struct mptcp_data_frag);
>> +            page = mptcp_page_frag_alloc_prepare(sk, pfrag, &offset,
>> +                                 &size, &va);
> 
> Since 'size' was updated to contain the maximum available space on the first call to mptcp_page_frag_alloc_prepare(), is it necessary to call it again instead of checking to see if 'size' is large enough for the mptcp_data_frag struct?

As the first call to the mptcp_page_frag_alloc_prepare() with the size
being 32U, the maximum available space might less than '32U +
sizeof(struct mptcp_data_frag)', in that case we need to call the
mptcp_page_frag_alloc_prepare() with the size being '32U +
sizeof(struct mptcp_data_frag)' anyway, so I am not sure if checking
the maximum available space on the first call to
mptcp_page_frag_alloc_prepare() before making the second call will
make the thing simpler.

> 
>> +            if (!page)
>>                 goto wait_for_memory;
>>
>> -            dfrag = mptcp_carve_data_frag(msk, pfrag, pfrag->offset);
>> +            dfrag = mptcp_carve_data_frag(msk, page, offset);
>>             frag_truesize = dfrag->overhead;
>> +            va += dfrag->overhead;
>>         }
>>
>>         /* we do not bound vs wspace, to allow a single packet.
>>          * memory accounting will prevent execessive memory usage
>>          * anyway
>>          */
>> -        offset = dfrag->offset + dfrag->data_len;
>> -        psize = pfrag->size - offset;
>> +        psize = size - frag_truesize;
>>         psize = min_t(size_t, psize, msg_data_left(msg));
>>         psize = min_t(size_t, psize, copy_limit);
>>         total_ts = psize + frag_truesize;
>> @@ -1866,8 +1884,7 @@ static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
>>         if (!sk_wmem_schedule(sk, total_ts))
>>             goto wait_for_memory;
>>
>> -        ret = do_copy_data_nocache(sk, psize, &msg->msg_iter,
>> -                       page_address(dfrag->page) + offset);
>> +        ret = do_copy_data_nocache(sk, psize, &msg->msg_iter, va);
>>         if (ret)
>>             goto do_error;
>>
>> @@ -1876,7 +1893,6 @@ static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
>>         copied += psize;
>>         dfrag->data_len += psize;
>>         frag_truesize += psize;
>> -        pfrag->offset += frag_truesize;
>>         WRITE_ONCE(msk->write_seq, msk->write_seq + psize);
>>
>>         /* charge data on mptcp pending queue to the msk socket
>> @@ -1884,11 +1900,15 @@ static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
>>          */
>>         sk_wmem_queued_add(sk, frag_truesize);
>>         if (!dfrag_collapsed) {
>> -            get_page(dfrag->page);
>> +            page_frag_alloc_commit(pfrag, offset, frag_truesize);
> 
> It would be more efficient (but more complicated) to defer the commit until the loop is done or the maximum frag size is reached. This would perform more like the older code, which only had to call refill when mptcp_frag_can_collapse_to() returned false.

page_frag_alloc_commit() is a inlined helper, it does not seems
to be an issue here as it is updating the reference counting
and offset as the old code does with less overhead.

Maybe what we could do is to do the prepare in the inline
helper instead of a function when cache is enough, so that
we can avoid a function call as the old code does, as an
inlined function requires less overhead and is generally
faster than a function call.

But that requires more refactoring, as this patchset is bigger
enough now, I guess we try it later if it is possible.


> 
> - Mat
> 

