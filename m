Return-Path: <bpf+bounces-26867-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C85C8A5BEE
	for <lists+bpf@lfdr.de>; Mon, 15 Apr 2024 22:01:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D9361F26747
	for <lists+bpf@lfdr.de>; Mon, 15 Apr 2024 20:01:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D2E9156665;
	Mon, 15 Apr 2024 20:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="pOd14QbR"
X-Original-To: bpf@vger.kernel.org
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA278156237
	for <bpf@vger.kernel.org>; Mon, 15 Apr 2024 20:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713211252; cv=none; b=uBRTlrc12O34YRu1PPzgYSeMR2MKRX3vY8DHafKXf8dzf3EN0VH+tJlPDdqe8w7vOHVDevzeKJcpSUhl3SGGCiyPgQFfgjAa+Mtiw5OxiwSnE0TlALW6LRjsAGUfocqldklusKS6HqxFoADi+vQgKGZtXg/L6m/J7quy4sjd3Yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713211252; c=relaxed/simple;
	bh=Wng/zjvzq6AH7/m1b0joVL/p8BnUv1nNNKBDl6nF7sY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JCUGTDIzZhdM+SFO3yCKCzUQq314gZEljEE7lInsYCuTUY/TGZ6caiq0yvJlOHi/RTn0GUuWj3wZ/SDtnXlnHdt62xYknCRy8DOWIGDoinK436oWMv0fBVaZae2sCIrTMpdLGYNgZ/7fsdTWbdXJIMqGH32udIRVhxvihnoq0iY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=pOd14QbR; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <617e2577-8de2-4fde-bbfe-2d6280c48c29@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1713211248;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0SJ/k5TZL9DMkDb6OS5NjYq8QZGa3dXX1/Ar8kH56co=;
	b=pOd14QbRT99LhYEk7rHt2FDGGGkJZco+GAC6Y9PWAlKTh3I//gxLAAKKq0TjqfuN5xy+Hb
	obfsgalSovughcoaw1ZPnVR0iRjO7IM1kAmqIptIIyuLtfpx14bKNG3T5jPEmwigXS5yfK
	JUGW32P7QwW5J7wem8Tco4LTO2a9zDs=
Date: Mon, 15 Apr 2024 13:00:42 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [RFC PATCH bpf-next v3 2/2] net: Add additional bit to support
 userspace timestamp type
To: Abhishek Chauhan <quic_abchauha@quicinc.com>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: kernel@quicinc.com, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Andrew Halaney <ahalaney@redhat.com>,
 Martin KaFai Lau <martin.lau@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, bpf <bpf@vger.kernel.org>
References: <20240412210125.1780574-1-quic_abchauha@quicinc.com>
 <20240412210125.1780574-3-quic_abchauha@quicinc.com>
 <661ad7d4c65da_3be9a7294e@willemb.c.googlers.com.notmuch>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <661ad7d4c65da_3be9a7294e@willemb.c.googlers.com.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 4/13/24 12:07 PM, Willem de Bruijn wrote:
>> diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
>> index a83a2120b57f..b6346c21c3d4 100644
>> --- a/include/linux/skbuff.h
>> +++ b/include/linux/skbuff.h
>> @@ -827,7 +827,8 @@ enum skb_tstamp_type {
>>    *	@tstamp_type: When set, skb->tstamp has the
>>    *		delivery_time in mono clock base (i.e. EDT).  Otherwise, the
>>    *		skb->tstamp has the (rcv) timestamp at ingress and
>> - *		delivery_time at egress.
>> + *		delivery_time at egress or skb->tstamp defined by skb->sk->sk_clockid
>> + *		coming from userspace
>>    *	@napi_id: id of the NAPI struct this skb came from
>>    *	@sender_cpu: (aka @napi_id) source CPU in XPS
>>    *	@alloc_cpu: CPU which did the skb allocation.
>> @@ -955,7 +956,7 @@ struct sk_buff {
>>   	/* private: */
>>   	__u8			__mono_tc_offset[0];
>>   	/* public: */
>> -	__u8			tstamp_type:1;	/* See SKB_MONO_DELIVERY_TIME_MASK */
>> +	__u8			tstamp_type:2;	/* See SKB_MONO_DELIVERY_TIME_MASK */
>>   #ifdef CONFIG_NET_XGRESS
>>   	__u8			tc_at_ingress:1;	/* See TC_AT_INGRESS_MASK */
>>   	__u8			tc_skip_classify:1;
> 
> A quick pahole for a fairly standard .config that I had laying around
> shows a hole after this list of bits, so no huge concerns there from
> adding a bit:
> 
>             __u8               slow_gro:1;           /*     3: 4  1 */
>             __u8               csum_not_inet:1;      /*     3: 5  1 */
> 
>             /* XXX 2 bits hole, try to pack */
> 
>             __u16              tc_index;             /*     4     2 */
> 
>> @@ -1090,10 +1091,10 @@ struct sk_buff {
>>    */
>>   #ifdef __BIG_ENDIAN_BITFIELD
>>   #define SKB_MONO_DELIVERY_TIME_MASK	(1 << 7)
>> -#define TC_AT_INGRESS_MASK		(1 << 6)
>> +#define TC_AT_INGRESS_MASK		(1 << 5)
> 
> Have to be careful when adding a new 2 bit tstamp_type with both bits
> set, that this does not incorrectly get interpreted as MONO.
> 
> I haven't looked closely at the BPF API, but hopefully it can be
> extensible to return the specific type. If it is hardcoded to return
> either MONO or not, then only 0x1 should match, not 0x3.

Good point. I believe it is the best to have bpf to consider both bits in 
tstamp_type:2 in filter.c to avoid the 0x3 surprise in the future. The BPF API 
can be extended to support SKB_CLOCK_TAI.

Regardless, in bpf_convert_tstamp_write(), it still needs to clear both bits in 
tstamp_type when it is at ingress. Right now it only clears the mono bit.

Then it may as well consider both tstamp_type:2 bits in 
bpf_convert_tstamp_read() and bpf_convert_tstamp_type_read(). e.g. 
bpf_convert_tstamp_type_read(), it should be a pretty straight forward change 
because the SKB_CLOCK_* enum value should be a 1:1 mapping to the BPF_SKB_TSTAMP_*.

> 
>>   #else
>>   #define SKB_MONO_DELIVERY_TIME_MASK	(1 << 0)
>> -#define TC_AT_INGRESS_MASK		(1 << 1)
>> +#define TC_AT_INGRESS_MASK		(1 << 2)
>>   #endif
>>   #define SKB_BF_MONO_TC_OFFSET		offsetof(struct sk_buff, __mono_tc_offset)
>>   


