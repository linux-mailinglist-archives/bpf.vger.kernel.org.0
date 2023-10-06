Return-Path: <bpf+bounces-11515-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C41807BB18C
	for <lists+bpf@lfdr.de>; Fri,  6 Oct 2023 08:30:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A78051C20A3E
	for <lists+bpf@lfdr.de>; Fri,  6 Oct 2023 06:30:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59B0B63CE;
	Fri,  6 Oct 2023 06:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="CoivroCh"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60A00523E
	for <bpf@vger.kernel.org>; Fri,  6 Oct 2023 06:30:01 +0000 (UTC)
Received: from out-201.mta0.migadu.com (out-201.mta0.migadu.com [IPv6:2001:41d0:1004:224b::c9])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB59CE4
	for <bpf@vger.kernel.org>; Thu,  5 Oct 2023 23:29:59 -0700 (PDT)
Message-ID: <47294480-506a-e22e-7466-3cdc106c395e@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1696573796;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rG5Ff9znLNDf/VzoV0lfrajhNAh/LlwOqwUkx96AOjA=;
	b=CoivroCht4AHq/DflGYIogpH2FhfWMxVhLstpWtx7PXGESHLg5Gxmox+G6ZNPGHLOLNl5M
	sMZrkhIjPPhFgE+wVwcQSg1dlf6uhp5mhmS18wabo6TP1asK9qD1q97ONXJI7J3JYdG49h
	r7ZNa+nq3faHMe2W4ajWczIgZ8EepOA=
Date: Thu, 5 Oct 2023 23:29:50 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf v2 1/2] bpf: Derive source IP addr via
 bpf_*_fib_lookup()
Content-Language: en-US
To: Martynas <m@lambda.lt>
Cc: Daniel Borkmann <daniel@iogearbox.net>, netdev <netdev@vger.kernel.org>,
 Nikolay Aleksandrov <razor@blackwall.org>, bpf@vger.kernel.org
References: <20231003071013.824623-1-m@lambda.lt>
 <20231003071013.824623-2-m@lambda.lt>
 <5bef21a3-18c0-e335-d64e-bcd6f1e304a4@linux.dev>
 <e7b992e3-8059-4058-8561-cb017c200c8d@app.fastmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <e7b992e3-8059-4058-8561-cb017c200c8d@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 10/5/23 1:16 PM, Martynas wrote:
>>> @@ -5992,6 +5995,19 @@ static int bpf_ipv6_fib_lookup(struct net *net, struct bpf_fib_lookup *params,
>>>    	params->rt_metric = res.f6i->fib6_metric;
>>>    	params->ifindex = dev->ifindex;
>>>    
>>> +	if (flags & BPF_FIB_LOOKUP_SET_SRC) {
>>> +		if (res.f6i->fib6_prefsrc.plen) {
>>> +			*(struct in6_addr *)params->ipv6_src = res.f6i->fib6_prefsrc.addr;

A nit. just noticed. Similar to the "*dst" assignment a few lines above:

			*src = res.f6i->fib6_prefsrc.addr;

>>> +		} else {
>>> +			err = ipv6_bpf_stub->ipv6_dev_get_saddr(net, dev,
>>> +								&fl6.daddr, 0,
>>> +								(struct in6_addr *)
>>> +								params->ipv6_src);

Same here. Use the "src".

>>> +			if (err)
>>> +				return BPF_FIB_LKUP_RET_NO_SRC_ADDR;
>>
>> This error also implies BPF_FIB_LKUP_RET_NO_NEIGH. I don't have a clean way of
>> improving the API. May be others have some ideas.
>>
>> Considering dev has no saddr is probably (?) an unlikely case, it should be ok
>> to leave it as is but at least a comment in the uapi will be needed. Otherwise,
>> the bpf prog may use the 0 dmac as-is.
> 
> I expect that a user of the helper checks that err == 0 before using any of the output params.

For example, the bpf prog gets BPF_FIB_LKUP_RET_NO_NEIGH and learns neigh is not 
available but ipv6_dst (and the optional ipv6_src) is still valid.

If the bpf prog gets BPF_FIB_LKUP_RET_NO_SRC_ADDR, intuitively, only ipv6_src is 
not available. The bpf prog will continue to use the ipv6_dst and dmac (which is 
actually 0).

> 
>>
>> I feel the current bpf_ipv[46]_fib_lookup helper is doing many things
>> in one
>> function and then requires different BPF_FIB_LOOKUP_* bits to select
>> what/how to
>> do. In the future, it may be worth to consider breaking it into smaller
>> kfunc(s). e.g. the __ipv[46]_neigh_lookup could be in its own kfunc.
>>
> 
> Yep, good idea. At least it seems that the neigh lookup could live in its own function.

To be clear, it could be independent of this set.

Thanks.


