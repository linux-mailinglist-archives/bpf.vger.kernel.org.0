Return-Path: <bpf+bounces-64682-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C7D8FB15629
	for <lists+bpf@lfdr.de>; Wed, 30 Jul 2025 02:01:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C48218A7501
	for <lists+bpf@lfdr.de>; Wed, 30 Jul 2025 00:02:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45256C13D;
	Wed, 30 Jul 2025 00:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="f8MfzOPo"
X-Original-To: bpf@vger.kernel.org
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2EA77FD
	for <bpf@vger.kernel.org>; Wed, 30 Jul 2025 00:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753833704; cv=none; b=lzVpk6Mv56V4xAAdndZLplDnCrOVIu3pv7pf1dvfdsp/wIlyAW32ZEBmbfAf7bUloj4tu6LP+abQUN1Am8vkBGUEoYR8RH/OFxoPnwcZBtCs5Km/eyYRMT1+u517q0Cpl6J9s4nQ1wYKcl9dmQ+FMzDpmFa9KIsILZ8FViy0/jA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753833704; c=relaxed/simple;
	bh=4bBcfMtEliYvXjsUbVZmSns3TZJz/pS56DEpoXnsR2c=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=vBuxlOskbqnsq/xAYlXM83moBULZLWT8VIELUo3mK0QOw21odOOn6D4JvxEARNz8ohrsVC9PaXaDiXx6c9nvWFNwVXbIxoucNsKlkl/pLPcUUn0GsduRIqlq3FA/yC+7iJ05pZ6FiuChDGDHoaOUbTooVmkR01terYdGGLOF3jM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=f8MfzOPo; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <cdd57fe6-ed8c-4cc9-a1dc-8563160a71e4@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1753833689;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EGslqIBQ0Jw1GqnwwqSZ43pV+rMIGnwUWZDT+W8tX5Q=;
	b=f8MfzOPoY++K6wtrICBP6K34bIOeWP0rTTrkdJW6fIBHuivLDWN9ea3hMHZmJdtIjOcWpX
	UznhJehuF+H0dM5iGz4m0bug//Q4PaLxF3HoSd3ZB1XhvBxEHHUT4Zd/Mka8PGH0X2wYmz
	WzCM0OjlqmL6j2yfaTeWnfBpQOxQBsg=
Date: Tue, 29 Jul 2025 17:01:24 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v3 4/4] selftests/bpf: add icmp_send_unreach
 kfunc tests
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
To: Mahe Tardy <mahe.tardy@gmail.com>
Cc: alexei.starovoitov@gmail.com, andrii@kernel.org, ast@kernel.org,
 bpf@vger.kernel.org, coreteam@netfilter.org, daniel@iogearbox.net,
 fw@strlen.de, john.fastabend@gmail.com, netdev@vger.kernel.org,
 netfilter-devel@vger.kernel.org, oe-kbuild-all@lists.linux.dev,
 pablo@netfilter.org, lkp@intel.com
References: <202507270940.kXGmRbg5-lkp@intel.com>
 <20250728094345.46132-1-mahe.tardy@gmail.com>
 <20250728094345.46132-5-mahe.tardy@gmail.com>
 <382ff228-704c-4e0c-9df3-2eb178adcba8@linux.dev> <aIiP5l24ihrS2x-u@gmail.com>
 <996bb1dd-e72e-4515-a60f-c5f31b840459@linux.dev>
Content-Language: en-US
In-Reply-To: <996bb1dd-e72e-4515-a60f-c5f31b840459@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 7/29/25 4:27 PM, Martin KaFai Lau wrote:
> On 7/29/25 2:09 AM, Mahe Tardy wrote:
>> On Mon, Jul 28, 2025 at 06:18:11PM -0700, Martin KaFai Lau wrote:
>>> On 7/28/25 2:43 AM, Mahe Tardy wrote:
>>>> +SEC("cgroup_skb/egress")
>>>> +int egress(struct __sk_buff *skb)
>>>> +{
>>>> +    void *data = (void *)(long)skb->data;
>>>> +    void *data_end = (void *)(long)skb->data_end;
>>>> +    struct iphdr *iph;
>>>> +    struct tcphdr *tcph;
>>>> +
>>>> +    iph = data;
>>>> +    if ((void *)(iph + 1) > data_end || iph->version != 4 ||
>>>> +        iph->protocol != IPPROTO_TCP || iph->daddr != bpf_htonl(SERVER_IP))
>>>> +        return SK_PASS;
>>>> +
>>>> +    tcph = (void *)iph + iph->ihl * 4;
>>>> +    if ((void *)(tcph + 1) > data_end ||
>>>> +        tcph->dest != bpf_htons(SERVER_PORT))
>>>> +        return SK_PASS;
>>>> +
>>>> +    kfunc_ret = bpf_icmp_send_unreach(skb, unreach_code);
>>>> +
>>>> +    /* returns SK_PASS to execute the test case quicker */
>>>
>>> Do you know why the user space is slower if 0 (SK_DROP) is used?
>>
>> I tried to write my understanding of this in the commit description:
>>
>> "Note that the BPF program returns SK_PASS to let the connection being
>> established to finish the test cases quicker. Otherwise, you have to
>> wait for the TCP three-way handshake to timeout in the kernel and
>> retrieve the errno translated from the unreach code set by the ICMP
>> control message."
> 
> This feels like a bit hacky to let the 3WHS finished while the objective of the 
> patch set is to drop it. It is not unusual for people to directly borrow this 
> code. Does non blocking connect() help?
> 

After reading more on how sk_err_soft is used, non blocking won't help. I think 
I see why tcp rst is better.

