Return-Path: <bpf+bounces-30332-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 79C3E8CC81E
	for <lists+bpf@lfdr.de>; Wed, 22 May 2024 23:22:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1AD081F2237D
	for <lists+bpf@lfdr.de>; Wed, 22 May 2024 21:22:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72EB31465A6;
	Wed, 22 May 2024 21:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="sDWie67Q"
X-Original-To: bpf@vger.kernel.org
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D627146D68
	for <bpf@vger.kernel.org>; Wed, 22 May 2024 21:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716412920; cv=none; b=OirGsKUQ7mr8aU/j3119kMgtcS7wKUd9vTNUm5ZuwtXtYKvpOgO34jweYhyU725JBR7sXBnYDgR14dsdqWaAeNVF8y7/PuTtOrSb5jQZGqAyfQX7tl5kq6zf0ASp59KC4nPQzbFcr53esSfY3k313Fw/l2pO3zgAGPsaGFfTTMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716412920; c=relaxed/simple;
	bh=SSgk8482ZaF89bgG3EdFDqQTlXtPCmkeFX0QoOj4SAo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s8tNPRoCECXIW+I83aC9Z9Z3rhLoPiIpvXBjsHt8EKLZG3rXenkkzCYHalNGwUBnBd91kFH1DousT52OQGaRkUPGpTCF6wklXHHirvlctCAoyvZbpHWlBQkoE61K5/B46Vs7TywFOiQy2Tf/8T55zklNulUdhMPzBQFgFLNvRRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=sDWie67Q; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: horms@kernel.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1716412916;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=onLSCHAGlv69WP5loYzyOhQjtl4gRyVJX/kSKV/blNw=;
	b=sDWie67QeCzYpP6e5u6R5un4iPHjlsQOP7to9GVS1K24Pn5/QdwrfV48THVX4kEeON9pwF
	2eXa9xXEIOFHpTmTc06Yd1xB4LKCEUAap11yZia4FWDOoQtQyc0gxt+gUK3N/kATV0qUSG
	+qAWGy3OxqPBlMn6Ar9TPHRd+fLubSA=
X-Envelope-To: martin.lau@linux.dev
X-Envelope-To: andrii@kernel.org
X-Envelope-To: ast@kernel.org
X-Envelope-To: mykolal@fb.com
X-Envelope-To: kuba@kernel.org
X-Envelope-To: bpf@vger.kernel.org
X-Envelope-To: netdev@vger.kernel.org
Message-ID: <8fdc5079-149b-4690-9036-c906059659e1@linux.dev>
Date: Wed, 22 May 2024 22:21:53 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 1/2] bpf: add CHECKSUM_COMPLETE to bpf test progs
To: Simon Horman <horms@kernel.org>
Cc: Martin KaFai Lau <martin.lau@linux.dev>,
 Andrii Nakryiko <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Mykola Lysenko <mykolal@fb.com>, Jakub Kicinski <kuba@kernel.org>,
 bpf@vger.kernel.org, netdev@vger.kernel.org
References: <20240522145712.3523593-1-vadfed@meta.com>
 <20240522183207.GB883722@kernel.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20240522183207.GB883722@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 22/05/2024 19:32, Simon Horman wrote:
> On Wed, May 22, 2024 at 07:57:10AM -0700, Vadim Fedorenko wrote:
>> Add special flag to validate that TC BPF program properly updates
>> checksum information in skb.
>>
>> Signed-off-by: Vadim Fedorenko <vadfed@meta.com>
> 
> ...
> 
>> diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
>> index f6aad4ed2ab2..841552785c65 100644
>> --- a/net/bpf/test_run.c
>> +++ b/net/bpf/test_run.c
>> @@ -974,10 +974,13 @@ int bpf_prog_test_run_skb(struct bpf_prog *prog, const union bpf_attr *kattr,
>>   	int hh_len = ETH_HLEN;
>>   	struct sk_buff *skb;
>>   	struct sock *sk;
>> +	__wsum csum;
>> +	__sum16 sum;
> 
> Hi Vadim,
> 
> sum seems to be is unused in this function.
> And, fwiiw, the scope of csum looks like it could be reduced.

Ah, leftover from previous iteration, thanks for catching it!
Ok, I'll move csum to the "if" block in v2.

>>   	void *data;
>>   	int ret;
>>   
>> -	if (kattr->test.flags || kattr->test.cpu || kattr->test.batch_size)
>> +	if ((kattr->test.flags & ~BPF_F_TEST_SKB_CHECKSUM_COMPLETE) ||
>> +	    kattr->test.cpu || kattr->test.batch_size)
>>   		return -EINVAL;
>>   
>>   	data = bpf_test_init(kattr, kattr->test.data_size_in,
>> @@ -1025,6 +1028,12 @@ int bpf_prog_test_run_skb(struct bpf_prog *prog, const union bpf_attr *kattr,
>>   
>>   	skb_reserve(skb, NET_SKB_PAD + NET_IP_ALIGN);
>>   	__skb_put(skb, size);
>> +
>> +	if (kattr->test.flags & BPF_F_TEST_SKB_CHECKSUM_COMPLETE) {
>> +		skb->csum = skb_checksum(skb, 0, skb->len, 0);
>> +		skb->ip_summed = CHECKSUM_COMPLETE;
>> +	}
>> +
>>   	if (ctx && ctx->ifindex > 1) {
>>   		dev = dev_get_by_index(net, ctx->ifindex);
>>   		if (!dev) {
>> @@ -1079,6 +1088,14 @@ int bpf_prog_test_run_skb(struct bpf_prog *prog, const union bpf_attr *kattr,
>>   	}
>>   	convert_skb_to___skb(skb, ctx);
>>   
>> +	if (kattr->test.flags & BPF_F_TEST_SKB_CHECKSUM_COMPLETE) {
>> +		csum = skb_checksum(skb, 0, skb->len, 0);
>> +		if (skb->csum != csum) {
>> +			ret = -EINVAL;
>> +			goto out;
>> +		}
>> +	}
>> +
>>   	size = skb->len;
>>   	/* bpf program can never convert linear skb to non-linear */
>>   	if (WARN_ON_ONCE(skb_is_nonlinear(skb)))
> 
> ...


