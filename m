Return-Path: <bpf+bounces-36728-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 915E694C68C
	for <lists+bpf@lfdr.de>; Thu,  8 Aug 2024 23:57:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1F69EB21029
	for <lists+bpf@lfdr.de>; Thu,  8 Aug 2024 21:57:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B75D615D5B8;
	Thu,  8 Aug 2024 21:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="cjVqUrjM"
X-Original-To: bpf@vger.kernel.org
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76B8E15820F
	for <bpf@vger.kernel.org>; Thu,  8 Aug 2024 21:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723154234; cv=none; b=uncphnDmaFT+sOny+1T4JPXjjUIk/eUYduKAuG11Ldw+q2M8CHOIk8VQU0fWBsBGLqYwgXQc1RcdID9kF9hyJwpTOqd7yIsJcF5DnfBsiqoZIwYIiZMa8GyewoQ3AXZwcWugg4y9lz8XBbduIjz2vo6e2P9EkZs15DeWvEys4v0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723154234; c=relaxed/simple;
	bh=cRhQcypevBzaB2B9KNuJNK6QHkHTAGjp/85oXTIZCBM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q57Yd0V69dTBewKUMtRC3zpC83LVYGfSEEw21Lg6pEKQvdflVk0eq9v0HCJl1KWy26cs6NZ+FEH3PzoBcnOWQVwZy5NJmBb13cCCbSQFKSpEhJrMEl/AiMCJKuU5UDa4KBoHOGl6TAMc5ltp+ciDQR7rGmbNPw2NF/RI28ZvxzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=cjVqUrjM; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <bd8ee84e-bc30-4635-a82a-f144e99ee345@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1723154229;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NdUQHWvrmaG1NwRK/E+Jvl41oMdmYq5JUut2+HcSGpg=;
	b=cjVqUrjMU+U2YnyTOhmSO+WsTlC+8GnskV3sYigJ1JtcRJ2I3AQj7aAQqrEERucyV8EZzu
	jgy8ivdTLdQWAPhFfGEfrbItBFVUjQ2oBGti5g9A2oVL4HtjjYNehqPcgao6BMMQFEnxOa
	O6AaYkFkrOK76VKCelKHmU88QrSzf+8=
Date: Thu, 8 Aug 2024 14:56:54 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v6 3/6] selftests/bpf: netns_new() and
 netns_free() helpers.
To: Kui-Feng Lee <sinquersw@gmail.com>, Kui-Feng Lee <thinker.li@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, song@kernel.org,
 kernel-team@meta.com, andrii@kernel.org, sdf@fomichev.me,
 geliang@kernel.org, kuifeng@meta.com
References: <20240807183149.764711-1-thinker.li@gmail.com>
 <20240807183149.764711-4-thinker.li@gmail.com>
 <da9922b7-c5f3-4a33-a707-14672a8a30dd@linux.dev>
 <ebf9d37a-ce27-44ab-a4da-312c73f8b6d7@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
Content-Language: en-US
In-Reply-To: <ebf9d37a-ce27-44ab-a4da-312c73f8b6d7@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 8/8/24 1:38 PM, Kui-Feng Lee wrote:
> 
> 
> On 8/8/24 13:27, Martin KaFai Lau wrote:
>> On 8/7/24 11:31 AM, Kui-Feng Lee wrote:
>>> +struct netns_obj *netns_new(const char *nsname, bool open)
>>> +{
>>> +    struct netns_obj *netns_obj = malloc(sizeof(*netns_obj));
>>> +    const char *test_name, *subtest_name;
>>> +    int r;
>>> +
>>> +    if (!netns_obj)
>>> +        return NULL;
>>> +    memset(netns_obj, 0, sizeof(*netns_obj));
>>> +
>>> +    netns_obj->nsname = strdup(nsname);
>>> +    if (!netns_obj->nsname)
>>> +        goto fail;
>>> +
>>> +    /* Create the network namespace */
>>> +    r = make_netns(nsname);
>>> +    if (r)
>>> +        goto fail;
>>> +
>>> +    /* Set the network namespace of the current process */
>>> +    if (open) {
>>> +        netns_obj->nstoken = open_netns(nsname);
>>> +        if (!netns_obj->nstoken)
>>> +            goto fail;
>>> +    }
>>> +
>>> +    /* Start traffic monitor */
>>> +    if (env.test->should_tmon ||
>>> +        (env.subtest_state && env.subtest_state->should_tmon)) {
>>> +        test_name = env.test->test_name;
>>> +        subtest_name = env.subtest_state ? env.subtest_state->name : NULL;
>>> +        netns_obj->tmon = traffic_monitor_start(nsname, test_name, 
>>> subtest_name);
>>
>> The traffic_monitor_start() does open/close_netns(). close_netns() will 
>> restore to the previous netns. Is it better to do traffic_monitor_start() 
>> before the above open_netns() such that we don't have to worry about the 
>> stacking open_netns and which netns the close_netns will restore?
> 
> Do you mean to open_netns() in another thread at the same time and
> interleave with the open_netns()/close_netns() pairs in the current thread?

I didn't mean this case. I don't think there will be a test calling 
open/close_nets() in different threads... but will it be an issue?

I was trying to say having the close_netns() restoring to the init_netns for the 
common case. Easier for the brain to reason without too much unnecessary 
open_netns stacking. Not saying there is an issue in the patch.

> 
>>
>>
>>> +        if (!netns_obj->tmon)
>>> +            fprintf(stderr, "Failed to start traffic monitor for %s\n", 
>>> nsname);
>>> +    } else {
>>> +        netns_obj->tmon = NULL;
>>> +    }
>>> +
>>> +    system("ip link set lo up");
>>
>> The "bool open" could be false here. This command could be acted on the > 
>> init_netns and the intention is to set lo up at the newly created netns.
>>
> 
> You are right! I should enclose this call in-between a pair of
> open_netns() & close_netns().

I would just move it to make_netns() and do "ip -n nsname link set lo up".
Yes, the traffic_monitor_start() is after the lo is up but I think it is fine.



