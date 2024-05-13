Return-Path: <bpf+bounces-29678-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D03E8C4A2C
	for <lists+bpf@lfdr.de>; Tue, 14 May 2024 01:44:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 24302B21BE7
	for <lists+bpf@lfdr.de>; Mon, 13 May 2024 23:44:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54AAF85939;
	Mon, 13 May 2024 23:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NjNYnPRL"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C06C885622;
	Mon, 13 May 2024 23:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715643859; cv=none; b=C8WC1rPfJZppXzqx2wBhkiwYZ/speoY36PZfreaYPrCg6AznKImGP7mbf6YwvmHCMkG4MzWoLY8VWOto+KdfO29ead7t4ZvcyCozoBLcTTWszvdTZNy34AsmKeEwtoVHIl2pAZRMkh+5PIMYihHUZsnHQQgo/Vw9jkatN5FArMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715643859; c=relaxed/simple;
	bh=G3IvKKUo7Fg0MTYOPPCwaU5WF0TElpgBbZXvzcAdX2g=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Eog6dLfuXwlxQ7RfoGuzx8hHGWmco5ePfT+Pv7RbxexIWIFY5fXEmM/lCh6rVCKxS+TuhMjRXyo5TOXMhehvzFmVZczYGmngXhgf/EfgU3PX+hGbmdSLFzNNWr1GDOATO274CoPVM5Qy8iWPQjC++LRXPd8qdFjRwa2ZOr3qp0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NjNYnPRL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23B69C113CC;
	Mon, 13 May 2024 23:44:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715643859;
	bh=G3IvKKUo7Fg0MTYOPPCwaU5WF0TElpgBbZXvzcAdX2g=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=NjNYnPRLL1xOtTtE3GPQWJCEzsdM2v7MU3aj12ve9yEIB62WeEZaYFnDGsYouHk+Q
	 p0DObeynWtbokCcujzjYtQwxMXlgSTwFpSHOh5Ma/TmrVk9Nq5kT+D4eWRJEMxCwLF
	 3DwlONtK1CpD+79fRbczEmIs1pcunRAr6Tsgfk/UBKA/56eTEEsXAT9wewgQdQyW5G
	 IOivE05HE5juwXO4ZVn2AfE+shtH/bijT/MiS1uug+XWsrvPauNlu7PkXakpkSs72E
	 nNL2jv/E0WlosMEveLrkPKnzWryiVFcDvMmkZMHhlHIX2f7ohsQLAqL6WOyK+3gDfi
	 nRXU5LK1kIFKw==
Date: Mon, 13 May 2024 16:44:18 -0700 (PDT)
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
In-Reply-To: <444d0349-476b-a04b-f6f1-d59ee57e2054@huawei.com>
Message-ID: <bcd2a227-9d0e-6d81-2439-2b7f1922bccb@kernel.org>
References: <20240508133408.54708-1-linyunsheng@huawei.com> <20240508133408.54708-12-linyunsheng@huawei.com> <334a8c67-87c8-a918-9517-0afbfae0d02b@kernel.org> <b8877f3a-831d-f899-9678-b1665739dbe9@huawei.com> <9a3cea15-2001-2222-0d0d-5f61f90507c3@kernel.org>
 <444d0349-476b-a04b-f6f1-d59ee57e2054@huawei.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Mon, 13 May 2024, Yunsheng Lin wrote:

> On 2024/5/11 1:29, Mat Martineau wrote:
>> On Fri, 10 May 2024, Yunsheng Lin wrote:
>>
>>> On 2024/5/10 0:22, Mat Martineau wrote:
>>>> On Wed, 8 May 2024, Yunsheng Lin wrote:
>>>>
>>>>> Use the newly introduced prepare/probe/commit API to
>>>>> replace page_frag with page_frag_cache for sk_page_frag().
>>>>>
>>>>> CC: Alexander Duyck <alexander.duyck@gmail.com>
>>>>> Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
>>>>> ---
>>>>> .../chelsio/inline_crypto/chtls/chtls.h       |   3 -
>>>>> .../chelsio/inline_crypto/chtls/chtls_io.c    | 100 ++++---------
>>>>> .../chelsio/inline_crypto/chtls/chtls_main.c  |   3 -
>>>>> drivers/net/tun.c                             |  28 ++--
>>>>> include/linux/sched.h                         |   4 +-
>>>>> include/net/sock.h                            |  14 +-
>>>>> kernel/exit.c                                 |   3 +-
>>>>> kernel/fork.c                                 |   3 +-
>>>>> net/core/skbuff.c                             |  32 ++--
>>>>> net/core/skmsg.c                              |  22 +--
>>>>> net/core/sock.c                               |  46 ++++--
>>>>> net/ipv4/ip_output.c                          |  33 +++--
>>>>> net/ipv4/tcp.c                                |  35 ++---
>>>>> net/ipv4/tcp_output.c                         |  28 ++--
>>>>> net/ipv6/ip6_output.c                         |  33 +++--
>>>>> net/kcm/kcmsock.c                             |  30 ++--
>>>>> net/mptcp/protocol.c                          |  70 +++++----
>>>>> net/sched/em_meta.c                           |   2 +-
>>>>> net/tls/tls_device.c                          | 139 ++++++++++--------
>>>>> 19 files changed, 331 insertions(+), 297 deletions(-)
>>>>>
>>>>
>>>> <snip>
>>>>
>>>>> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
>>>>> index bb8f96f2b86f..ab844011d442 100644
>>>>> --- a/net/mptcp/protocol.c
>>>>> +++ b/net/mptcp/protocol.c
>>>>> @@ -960,17 +960,18 @@ static bool mptcp_skb_can_collapse_to(u64 write_seq,
>>>>> }
>>>>>
>>>>> /* we can append data to the given data frag if:
>>>>> - * - there is space available in the backing page_frag
>>>>> - * - the data frag tail matches the current page_frag free offset
>>>>> + * - there is space available for the current page
>>>>> + * - the data frag tail matches the current page and offset
>>>>>  * - the data frag end sequence number matches the current write seq
>>>>>  */
>>>>> static bool mptcp_frag_can_collapse_to(const struct mptcp_sock *msk,
>>>>> -                       const struct page_frag *pfrag,
>>>>> +                       const struct page *page,
>>>>> +                       const unsigned int offset,
>>>>> +                       const unsigned int size,
>>>>
>>>> Hi Yunsheng -
>>>>
>>>> Why add the 'size' parameter here? It's checked to be a nonzero value, but it can only be 0 if page is also NULL. In this case "page == df->page" will be false, so the function will return false even without checking 'size'.
>>>
>>> Is it possible that the pfrag->page is also NULL, which may cause
>>> mptcp_frag_can_collapse_to() to return true?
>>
>> Not sure. But I do know that df->page will never be NULL, so "page == df->page" will always be false when page == NULL.
>>
>>>
>>> I just found out that the 'size' is not set to zero when return
>>> NULL for the implementation of probe API for the current version.
>>> Perhaps it makes more sense to expect the API caller to make sure
>>> the the returned 'page' not being NULL before using the 'offset',
>>> 'size' and 'va', like below:
>>>
>>> df && page && page == df->page
>>>
>>
>> Given that df->page is never NULL, I don't think the extra "&& page" is needed.
>
> Not checking the extra "&& page" seems to cause the below warning, it seems we
> have the below options:
> 1. ignore the warning.
> 2. set offset to zero if there is no enough space when probe API asks for a specific
>   amount of available space as you suggested.
> 3. add the "&& page" in mptcp_frag_can_collapse_to()
>
> what is your favour option? or any other better option?
>
> net-mptcp-protocol.c:warning:variable-offset-is-used-uninitialized-whenever-if-condition-is-false
>

Hi Yunsheng -

That static analyzer is correct that "offset" is *passed* uninitialized in 
that scenario, but it doesn't recognize that "offset" is never compared 
when page == NULL. So, it's a false positive in a way.

I don't think implementing fix #2 in the page_frag_alloc_probe() macro is 
best, since the warning is specific to the MPTCP code and other 
page_frag_cache users may have reasons to choose nonzero default values 
for the offset. I suggest initializing offset = 0 where it is declared in 
mptcp_sendmsg().


- Mat


