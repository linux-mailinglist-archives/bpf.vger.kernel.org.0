Return-Path: <bpf+bounces-29638-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D79A88C4028
	for <lists+bpf@lfdr.de>; Mon, 13 May 2024 13:53:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 068AC1C213EA
	for <lists+bpf@lfdr.de>; Mon, 13 May 2024 11:53:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F93A14EC5A;
	Mon, 13 May 2024 11:53:14 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09CFE14D29E;
	Mon, 13 May 2024 11:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715601193; cv=none; b=fuxcoUd9FfggwgpZD78naucb/92j1E5S+kqwNSBZe7wdmn5m7pOkw9V2ee5JVHBea/9wE+OA+eSw+XnZy1lsKyKGDZC4GMSAMgtN8R3CAXhYn/VWeiTtx4sVYq1gyvziHJbQ0X0B48cUfZQETkGj0NfQRAt6CyxSNUDVn1Hvn1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715601193; c=relaxed/simple;
	bh=973yi3/moS9nP33izvSYXjFm6aTvdo5cVj1K5rMMWH0=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=F+zkIMDNZayZnIX39HluC0h3baJK88AwAUwSyJhEUh8cvrnibKcnIed0rLkD4YjEgQtTeFoJ3nKZ0d/N8V7OvG/rhzaBEXT8uGZUCNGbtwhfJVssRLqIpzGajDlNmEp3f7NZnxu2f15CiCRnzPeWPjnuvNRdzji5BLiKRPCF2Zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4VdHpR0cMWz1S52Z;
	Mon, 13 May 2024 19:49:35 +0800 (CST)
Received: from dggpemm500005.china.huawei.com (unknown [7.185.36.74])
	by mail.maildlp.com (Postfix) with ESMTPS id 75184180060;
	Mon, 13 May 2024 19:53:01 +0800 (CST)
Received: from [10.69.30.204] (10.69.30.204) by dggpemm500005.china.huawei.com
 (7.185.36.74) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 13 May
 2024 19:53:01 +0800
Subject: Re: [PATCH net-next v3 11/13] net: replace page_frag with
 page_frag_cache
To: Mat Martineau <martineau@kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Alexander Duyck
	<alexander.duyck@gmail.com>, Ayush Sawal <ayush.sawal@chelsio.com>, Eric
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
	Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>,
	Jiri Pirko <jiri@resnulli.us>, Boris Pismenny <borisp@nvidia.com>,
	<bpf@vger.kernel.org>, <mptcp@lists.linux.dev>
References: <20240508133408.54708-1-linyunsheng@huawei.com>
 <20240508133408.54708-12-linyunsheng@huawei.com>
 <334a8c67-87c8-a918-9517-0afbfae0d02b@kernel.org>
 <b8877f3a-831d-f899-9678-b1665739dbe9@huawei.com>
 <9a3cea15-2001-2222-0d0d-5f61f90507c3@kernel.org>
From: Yunsheng Lin <linyunsheng@huawei.com>
Message-ID: <444d0349-476b-a04b-f6f1-d59ee57e2054@huawei.com>
Date: Mon, 13 May 2024 19:53:00 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <9a3cea15-2001-2222-0d0d-5f61f90507c3@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500005.china.huawei.com (7.185.36.74)

On 2024/5/11 1:29, Mat Martineau wrote:
> On Fri, 10 May 2024, Yunsheng Lin wrote:
> 
>> On 2024/5/10 0:22, Mat Martineau wrote:
>>> On Wed, 8 May 2024, Yunsheng Lin wrote:
>>>
>>>> Use the newly introduced prepare/probe/commit API to
>>>> replace page_frag with page_frag_cache for sk_page_frag().
>>>>
>>>> CC: Alexander Duyck <alexander.duyck@gmail.com>
>>>> Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
>>>> ---
>>>> .../chelsio/inline_crypto/chtls/chtls.h       |   3 -
>>>> .../chelsio/inline_crypto/chtls/chtls_io.c    | 100 ++++---------
>>>> .../chelsio/inline_crypto/chtls/chtls_main.c  |   3 -
>>>> drivers/net/tun.c                             |  28 ++--
>>>> include/linux/sched.h                         |   4 +-
>>>> include/net/sock.h                            |  14 +-
>>>> kernel/exit.c                                 |   3 +-
>>>> kernel/fork.c                                 |   3 +-
>>>> net/core/skbuff.c                             |  32 ++--
>>>> net/core/skmsg.c                              |  22 +--
>>>> net/core/sock.c                               |  46 ++++--
>>>> net/ipv4/ip_output.c                          |  33 +++--
>>>> net/ipv4/tcp.c                                |  35 ++---
>>>> net/ipv4/tcp_output.c                         |  28 ++--
>>>> net/ipv6/ip6_output.c                         |  33 +++--
>>>> net/kcm/kcmsock.c                             |  30 ++--
>>>> net/mptcp/protocol.c                          |  70 +++++----
>>>> net/sched/em_meta.c                           |   2 +-
>>>> net/tls/tls_device.c                          | 139 ++++++++++--------
>>>> 19 files changed, 331 insertions(+), 297 deletions(-)
>>>>
>>>
>>> <snip>
>>>
>>>> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
>>>> index bb8f96f2b86f..ab844011d442 100644
>>>> --- a/net/mptcp/protocol.c
>>>> +++ b/net/mptcp/protocol.c
>>>> @@ -960,17 +960,18 @@ static bool mptcp_skb_can_collapse_to(u64 write_seq,
>>>> }
>>>>
>>>> /* we can append data to the given data frag if:
>>>> - * - there is space available in the backing page_frag
>>>> - * - the data frag tail matches the current page_frag free offset
>>>> + * - there is space available for the current page
>>>> + * - the data frag tail matches the current page and offset
>>>>  * - the data frag end sequence number matches the current write seq
>>>>  */
>>>> static bool mptcp_frag_can_collapse_to(const struct mptcp_sock *msk,
>>>> -                       const struct page_frag *pfrag,
>>>> +                       const struct page *page,
>>>> +                       const unsigned int offset,
>>>> +                       const unsigned int size,
>>>
>>> Hi Yunsheng -
>>>
>>> Why add the 'size' parameter here? It's checked to be a nonzero value, but it can only be 0 if page is also NULL. In this case "page == df->page" will be false, so the function will return false even without checking 'size'.
>>
>> Is it possible that the pfrag->page is also NULL, which may cause
>> mptcp_frag_can_collapse_to() to return true?
> 
> Not sure. But I do know that df->page will never be NULL, so "page == df->page" will always be false when page == NULL.
> 
>>
>> I just found out that the 'size' is not set to zero when return
>> NULL for the implementation of probe API for the current version.
>> Perhaps it makes more sense to expect the API caller to make sure
>> the the returned 'page' not being NULL before using the 'offset',
>> 'size' and 'va', like below:
>>
>> df && page && page == df->page
>>
> 
> Given that df->page is never NULL, I don't think the extra "&& page" is needed.

Not checking the extra "&& page" seems to cause the below warning, it seems we
have the below options:
1. ignore the warning.
2. set offset to zero if there is no enough space when probe API asks for a specific
   amount of available space as you suggested.
3. add the "&& page" in mptcp_frag_can_collapse_to()

what is your favour option? or any other better option?

net-mptcp-protocol.c:warning:variable-offset-is-used-uninitialized-whenever-if-condition-is-false

> 
> - Mat
> .
> 

