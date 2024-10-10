Return-Path: <bpf+bounces-41654-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 486BB9994ED
	for <lists+bpf@lfdr.de>; Fri, 11 Oct 2024 00:07:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 76D671C22E85
	for <lists+bpf@lfdr.de>; Thu, 10 Oct 2024 22:07:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F5261E5705;
	Thu, 10 Oct 2024 22:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="G8WgUXjN"
X-Original-To: bpf@vger.kernel.org
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57F271E47B9
	for <bpf@vger.kernel.org>; Thu, 10 Oct 2024 22:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728598057; cv=none; b=mSjSJ5EiCk2EkGJFzAQqsIVD607mafxz+Poahm39fSKlkUeKifRgo5YFi7iKmSQvX4fdYVstvuWY4mGd/QofwFpsUzSaI8wGaDnaN2eZt3TiNs9C5N75tPatfZJOCX6xWeBestBqzo0G+uxk40ABeLcIyakcWKxWYbw566QnVpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728598057; c=relaxed/simple;
	bh=LaigjFxQUjyMv6ZYoJS4ypnJpFkCLTNIgoboW2nLLuw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KQoTdy5ZHsLWQEzFisRCR5S2EGr+g1IcNBkydv4POn5HhZlWhZhtra9Q1z3i5ffnKYwJkl8IkmdxxfedotOgaw+J/dF96YSPI4/VlroA8y1WTnTvlHGT8Ao/2OJEOpOyj3IpzVEPFvLwk8SqBXvlmfANEFf2SGaCKE4w/9WwwUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=G8WgUXjN; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <7b090ca5-7997-4371-8d79-7862a7e27052@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1728598053;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZIUGJGUITBa6JcDz8UXnyNpp/2ZzVbzWjWLZ1LXlwiw=;
	b=G8WgUXjNyEmQTm8/SIZtf9N2kwcCRr5sMy/zFIdcstX/QzVAQov5rYfUnd22ugVrJm53eh
	NRM/vGQWHfiiGJ5miTSIJvusNkMuNbBKrQSBA5unFCo466q3w+c86gWA0Ps9DrBtTGfr7e
	L2/Db+t8KlMMlG5eIkEZezLSKszqUdg=
Date: Thu, 10 Oct 2024 15:07:23 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next] bpf: Add rcu ptr in btf_id_sock_common_types
To: Philo Lu <lulie@linux.alibaba.com>
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
 andrii@kernel.org, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, xuanzhuo@linux.alibaba.com,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241008080916.44724-1-lulie@linux.alibaba.com>
 <80cb3d4b-cebb-4f08-865d-354110a54467@linux.dev>
 <2e3f676a-ef03-4618-852d-ceb3b620a640@linux.alibaba.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <2e3f676a-ef03-4618-852d-ceb3b620a640@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 10/8/24 7:23 PM, Philo Lu wrote:
> 
> 
> On 2024/10/9 03:05, Martin KaFai Lau wrote:
>> On 10/8/24 1:09 AM, Philo Lu wrote:
>>> Sometimes sk is dereferenced as an rcu ptr, such as skb->sk in tp_btf,
>>> which is a valid type of sock common. Then helpers like bpf_skc_to_*()
>>> can be used with skb->sk.
>>>
>>> For example, the following prog will be rejected without this patch:
>>> ```
>>> SEC("tp_btf/tcp_bad_csum")
>>> int BPF_PROG(tcp_bad_csum, struct sk_buff* skb)
>>> {
>>>     struct sock *sk = skb->sk;
>>>     struct tcp_sock *tp;
>>>
>>>     if (!sk)
>>>         return 0;
>>>     tp = bpf_skc_to_tcp_sock(sk);
>>
>> If the use case is for reading the fields in tp, please use the bpf_core_cast 
>> from the libbpf's bpf_core_read.h. bpf_core_cast is using the bpf_rdonly_cast 
>> kfunc underneath.
>>
> 
> Thank you! This works for me so this patch is unnecessary then.
> 
> Just curious is there any technical issue to include rcu_ptr into 
> btf_id_sock_common_types? AFAICT rcu_ptr should also be a valid ptr type, and 
> then btf_id_sock_common_types will behave like (PTR_TO_BTF_ID + 
> &btf_sock_ids[BTF_SOCK_TYPE_SOCK_COMMON]) in bpf_func_proto.

bpf_skc_to_*() returns a PTR_TO_BTF_ID which can be passed into other helpers 
that takes ARG_PTR_TO_BTF_ID_SOCK_COMMON. There are helpers that change the sk. 
e.g. bpf_setsockopt() changes the sk and needs sk to be locked. Other non 
tracing hooks do have a hold on the skb also. I did take a quick look at the 
bpf_setsockopt situation and looks ok. I am positive there are other helpers 
that need to audit first.

Tracing use case should only read the sk. bpf_core_cast() is the correct one to 
use. The bpf_sk_storage_{get,delete}() should be the only allowed helper that 
can change the sk.

