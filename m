Return-Path: <bpf+bounces-69266-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D9F4FB9329E
	for <lists+bpf@lfdr.de>; Mon, 22 Sep 2025 22:04:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA2B71907436
	for <lists+bpf@lfdr.de>; Mon, 22 Sep 2025 20:05:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90AD3311959;
	Mon, 22 Sep 2025 20:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="kBXlNV/M"
X-Original-To: bpf@vger.kernel.org
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A9DB2F5320
	for <bpf@vger.kernel.org>; Mon, 22 Sep 2025 20:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758571467; cv=none; b=RGrqASuk+gM9m/bp8gy+4ILZXcfH2KMVFD8eBaHFIM4pzFJfFcVhpRKu3tw6cV+nPOe5qeGGp9i1qrnXE/65c8xQGuZMl6YpYEziXdmxo+JoPUxogq2Ij4+oFWILQt+MUKsRLRgOoYJUKE/XxACV1PB58jzCQ0XR3nyk4Bopb8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758571467; c=relaxed/simple;
	bh=nEWUEPU9ZaGtLMvGM/0LN7V+or/Ug2aPSdhvsvhwit4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r/abZoCb0Siyt2LsaejUhIH9pHkrjXIRZjTQkSRFxj8Qfk8EOAdzHWNSMMOrDBkNa4MnxozPYrF9r//6srzn3Bu11XblmILLVLTJId/SjW6qZkVDdzjM5674Vk2uyCNJCGR9PDA5BUKXks9LV7A5VgYN4eCGGNXIgVTmdx+PrUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=kBXlNV/M; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <f870f375-f9a5-4c36-80df-8062ec3eddd3@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1758571453;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RbuGqL0IYOWc1/oaCHbaa4DTqV5D4FcE0xJf+txHDaM=;
	b=kBXlNV/MlPQ9EYTKQxRiSl20Og3/J+Qlfb6j08aR0Z4J5ucCmsHPfa6wXnXmPT5fQgjYvJ
	7l3IANVW6Ox9HHKxFhCr7HD83haQK5XtxGRofNnFzCm9C1QlO+AgbTNGCOQJ5CN3gbw+Mw
	Cc6ci5BkhtdH2oPX+tXec1DnMaCJ61U=
Date: Mon, 22 Sep 2025 13:04:04 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v6 5/7] bpf: Support specifying linear xdp packet
 data size for BPF_PROG_TEST_RUN
To: Amery Hung <ameryhung@gmail.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org,
 alexei.starovoitov@gmail.com, andrii@kernel.org, daniel@iogearbox.net,
 paul.chaignon@gmail.com, kuba@kernel.org, stfomichev@gmail.com,
 martin.lau@kernel.org, mohsin.bashr@gmail.com, noren@nvidia.com,
 dtatulea@nvidia.com, saeedm@nvidia.com, tariqt@nvidia.com,
 mbloch@nvidia.com, maciej.fijalkowski@intel.com, kernel-team@meta.com
References: <20250919230952.3628709-1-ameryhung@gmail.com>
 <20250919230952.3628709-6-ameryhung@gmail.com>
 <10e5dd51-701d-498b-b1eb-68b23df191d9@linux.dev>
 <CAMB2axPU6Aoj6hfJcsS0W7CDL=bvAFLtPm2ZrsJef3w+aNoAXg@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
Content-Language: en-US
In-Reply-To: <CAMB2axPU6Aoj6hfJcsS0W7CDL=bvAFLtPm2ZrsJef3w+aNoAXg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 9/22/25 12:48 PM, Amery Hung wrote:
>>> diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
>>> index 4a862d605386..0cbd3b898c45 100644
>>> --- a/net/bpf/test_run.c
>>> +++ b/net/bpf/test_run.c
>>> @@ -665,7 +665,7 @@ static void *bpf_test_init(const union bpf_attr *kattr, u32 user_size,
>>>        void __user *data_in = u64_to_user_ptr(kattr->test.data_in);
>>>        void *data;
>>>
>>> -     if (user_size < ETH_HLEN || user_size > PAGE_SIZE - headroom - tailroom)
>>> +     if (user_size > PAGE_SIZE - headroom - tailroom)
>>>                return ERR_PTR(-EINVAL);
>>>
>>>        size = SKB_DATA_ALIGN(size);
>>> @@ -1001,6 +1001,9 @@ int bpf_prog_test_run_skb(struct bpf_prog *prog, const union bpf_attr *kattr,
>>>            kattr->test.cpu || kattr->test.batch_size)
>>>                return -EINVAL;
>>>
>>> +     if (size < ETH_HLEN)
>>> +             return -EINVAL;
>>> +
>>>        data = bpf_test_init(kattr, kattr->test.data_size_in,
>>>                             size, NET_SKB_PAD + NET_IP_ALIGN,
>>>                             SKB_DATA_ALIGN(sizeof(struct skb_shared_info)));
>>> @@ -1246,13 +1249,15 @@ int bpf_prog_test_run_xdp(struct bpf_prog *prog, const union bpf_attr *kattr,
>>
>> I just noticed it. It still needs a "size < ETH_HLEN" test at the beginning of
>> test_run_xdp. At least the do_live mode should still needs to have ETH_HLEN bytes.
> 
> Make sense. I will add the check for live mode.

The earlier comment wasn't clear, my bad. no need to limit the ETH_HLEN test to 
live mode only. multi-frags or not, kattr->test.data_size_in should not be < 
ETH_HLEN.



