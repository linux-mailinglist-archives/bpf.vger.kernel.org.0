Return-Path: <bpf+bounces-70436-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DC637BBF0B4
	for <lists+bpf@lfdr.de>; Mon, 06 Oct 2025 20:59:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A7B964E2E45
	for <lists+bpf@lfdr.de>; Mon,  6 Oct 2025 18:58:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E50F2D29C8;
	Mon,  6 Oct 2025 18:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="VAI7Z+7o"
X-Original-To: bpf@vger.kernel.org
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3463E22A4E9
	for <bpf@vger.kernel.org>; Mon,  6 Oct 2025 18:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759777135; cv=none; b=Qfo4fuh+GZyTVtXOwj1h7bZbPUgJHK97Ir4yk0qUrOvCHV12il2wpzXo0N2xiHzQ+QTSn46oNBJ7sQDQCP8zhFiTMXfqIwtHv2iuDB8em56GKJNzRhSSOdpmRaIzh0QTycvpH03bV9WSS4PhaK61y4zAgesahh2lxfeMk7EDfo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759777135; c=relaxed/simple;
	bh=YBqSieB4qLpmYaWDxVWzgzQUBVS+12mli69w3nhQ8H4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=txb8kJwqZkZkcFlXHs7H8pKb1DXTCH6GfFcDSp+3G/IeJsVShQrj79ZA0R0ln8yNCB/KfZ/YKd8BNmZZCxRzgpE+YfygbhO4gdRXYLqNE1SLvvgA3s8gkNcmBSA2rsvdpFEQXIf2WurdmB3HPBZTblGZpteaiEYCoYhZFYBZo3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=VAI7Z+7o; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <82c4c97e-83cc-4f42-b3a0-11f46a7495d6@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1759777129;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=E+QUGCwDbqJin70bJIePnnfI+sRkOuxV9B4sLyA6fLs=;
	b=VAI7Z+7oBXnvqZUeCHUpm+OSXvEmQMe55VnUvD7JA6p4q7gYEU5eO54kdpP1mIaA24qXxu
	pGxuiYpGM+8y6jQscVCpUo7eROdkXcYrq3nhcmPP4zqFCYN6PAm+yUJ4XcJydm7xo0OVVY
	F0suxy7d7KjiO6fNwpchMeIKJ3TLVZI=
Date: Mon, 6 Oct 2025 11:58:41 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v5 3/5] bpf: Craft non-linear skbs in
 BPF_PROG_TEST_RUN
To: Paul Chaignon <paul.chaignon@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>, Amery Hung <ameryhung@gmail.com>,
 bpf@vger.kernel.org
References: <cover.1759397353.git.paul.chaignon@gmail.com>
 <10502e40a894fc60abf625ec631eadc5ad78e311.1759397354.git.paul.chaignon@gmail.com>
 <943df0e0-358e-4361-81a0-ec7a4118cf29@linux.dev>
 <aOPMWoiFY78QT5Er@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
Content-Language: en-US
In-Reply-To: <aOPMWoiFY78QT5Er@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 10/6/25 7:04 AM, Paul Chaignon wrote:
> On Thu, Oct 02, 2025 at 11:27:52AM -0700, Martin KaFai Lau wrote:
>> On 10/2/25 3:07 AM, Paul Chaignon wrote:
>>> This patch adds support for crafting non-linear skbs in BPF test runs
>>> for tc programs. The size of the linear area is given by ctx->data_end,
>>> with a minimum of ETH_HLEN always pulled in the linear area. If ctx or
>>> ctx->data_end are null, a linear skb is used.
>>>
>>> This is particularly useful to test support for non-linear skbs in large
>>> codebases such as Cilium. We've had multiple bugs in the past few years
>>> where we were missing calls to bpf_skb_pull_data(). This support in
>>> BPF_PROG_TEST_RUN would allow us to automatically cover this case in our
>>> BPF tests.
>>>
>>> In addition to the selftests introduced later in the series, this patch
>>> was tested by setting enabling non-linear skbs for all tc selftests
>>> programs and checking test failures were expected.
>>>
>>> Tested-by: syzbot@syzkaller.appspotmail.com
>>> Suggested-by: Daniel Borkmann <daniel@iogearbox.net>
>>> Signed-off-by: Paul Chaignon <paul.chaignon@gmail.com>
>>> ---
>>>    net/bpf/test_run.c | 67 +++++++++++++++++++++++++++++++++++++++++-----
>>>    1 file changed, 61 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
>>> index 3425100b1e8c..e4f4b423646a 100644
>>> --- a/net/bpf/test_run.c
>>> +++ b/net/bpf/test_run.c
>>> @@ -910,6 +910,12 @@ static int convert___skb_to_skb(struct sk_buff *skb, struct __sk_buff *__skb)
>>>    	/* cb is allowed */
>>>    	if (!range_is_zero(__skb, offsetofend(struct __sk_buff, cb),
>>> +			   offsetof(struct __sk_buff, data_end)))
>>> +		return -EINVAL;
>>> +
>>> +	/* data_end is allowed, but not copied to skb */
>>> +
>>> +	if (!range_is_zero(__skb, offsetofend(struct __sk_buff, data_end),
>>>    			   offsetof(struct __sk_buff, tstamp)))
>>>    		return -EINVAL;
>>> @@ -984,9 +990,12 @@ static struct proto bpf_dummy_proto = {
>>>    int bpf_prog_test_run_skb(struct bpf_prog *prog, const union bpf_attr *kattr,
>>>    			  union bpf_attr __user *uattr)
>>>    {
>>> +	u32 tailroom = SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
>>>    	bool is_l2 = false, is_direct_pkt_access = false;
>>>    	struct net *net = current->nsproxy->net_ns;
>>>    	struct net_device *dev = net->loopback_dev;
>>> +	u32 headroom = NET_SKB_PAD + NET_IP_ALIGN;
>>> +	u32 linear_sz = kattr->test.data_size_in;
>>>    	u32 size = kattr->test.data_size_in;
>>>    	u32 repeat = kattr->test.repeat;
>>>    	struct __sk_buff *ctx = NULL;
>>> @@ -1023,9 +1032,16 @@ int bpf_prog_test_run_skb(struct bpf_prog *prog, const union bpf_attr *kattr,
>>>    	if (IS_ERR(ctx))
>>>    		return PTR_ERR(ctx);
>>> -	data = bpf_test_init(kattr, kattr->test.data_size_in,
>>> -			     size, NET_SKB_PAD + NET_IP_ALIGN,
>>> -			     SKB_DATA_ALIGN(sizeof(struct skb_shared_info)));
>>> +	if (ctx) {
>>> +		if (!is_l2 || ctx->data_end > kattr->test.data_size_in) {
>>
>> What is the need for the "!is_l2" test?
> 
> There's nothing limiting us to only tc program types, but I was
> wondering if it makes sense to open this (non-linear skbs) to all
> program types. For example, cgroup_skb programs cannot call
> bpf_skb_pull_data to deal with non-linear skbs.

The bpf_dynptr_* and the bpf_load_* can still be used to handle the a non-linear 
skb.

One thing is all "!is_l2" program will get an -EINVAL now after this patch if 
either ctx_in or ctx_out is specified. Am I reading it right?

> 
> Even the LWT program types would require special care because ex. the
> bpf_clone_redirect helper can end up calling eth_type_trans which
> assumes we have at least ETH_HLEN in the linear area. I wasn't sure it
> was worth opening this capability to these program types without a clear
> use case.

I thought the linear_sz has been taken care of below such that it must be at 
least ETH_HLEN anyway. Why "!is_l2" still needs to be rejected?

I am not familiar with the LWT but I recalled we have fixed some cases on the 
ETH_HLEN and they are now tested by the prog_tests/empty_skb.c.

I think I am missing something on how is the non-linear skb different from the 
linear skb here for lwt if it has ensured there is ETH_HLEN in the linear. I am 
not sure how active is the lwt/bpf usage now. If it is hard to support, I think 
it is fine to exclude it.

CGROUP_SKB will be good to be supported at the beginning though.

> 
>>
>>> +			ret = -EINVAL;
>>> +			goto out;
>>> +		}
>>> +		if (ctx->data_end)
>>> +			linear_sz = max(ETH_HLEN, ctx->data_end);Here. linear_sz must be at least ETH_HLEN.

>>> +	}
>>> +
>>> +	data = bpf_test_init(kattr, linear_sz, size, headroom, tailroom);
>>
>> Instead of passing "size", should linear_sz be passed instead? Unlike xdp,
>> allocating exactly linear_sz should be enough considering bpf_skb_pull_data
>> can allocate new data if needed.
> 
> Indeed. Thanks!
> 
>>
>> Should linear_sz be limited to "PAGE_SIZE - headroom..." like how
>> test_run_xdp() does it ?
> 
> That changes a bit the current behavior. Currently, we will return
> EINVAL if a user try to pass more than "PAGE_SIZE - headroom..." as
> data_size_in. With the test_run_xdp approach, we'll end up silently
> switching to non-linear mode if they do that.
> 
> I'm not against it given it brings consistency with the XDP counterpart,
> but it could also be a bit surprising.

I think this is fine to accept what was previously rejected because of lacking 
non-linear skb support.


I would prefer to have similar expectation as the test_run_xdp for the parts 
that make sense.

