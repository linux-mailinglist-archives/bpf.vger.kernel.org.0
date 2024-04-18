Return-Path: <bpf+bounces-27178-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C2B68AA4EE
	for <lists+bpf@lfdr.de>; Thu, 18 Apr 2024 23:57:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C1F1BB2250B
	for <lists+bpf@lfdr.de>; Thu, 18 Apr 2024 21:57:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36A29199EB0;
	Thu, 18 Apr 2024 21:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="hdDV1nrZ"
X-Original-To: bpf@vger.kernel.org
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F18A9199E88
	for <bpf@vger.kernel.org>; Thu, 18 Apr 2024 21:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713477444; cv=none; b=QYiLbMgRr3wWrZNjlSSgC0tV5a/Ey189JQMZVmsHw2agjz6021SHuVB0G3wJtURBO1gZzOM8Uwe5O6l6slqC3AEZedNfvg/Gvvawn2gzw4NpmQOh4WtRt7gLNQtVc9FJoLQePbpaEZ9xcZ6/cimc7wv8OUCpBI8gilz66KPuOag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713477444; c=relaxed/simple;
	bh=zooV8U1KdjxrLXansfLdXT2+NI7EJnxfn32RZkboLRk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ab4dowA2pKXcZUwz2HCqFR6Uodkell68GaUfs3izE+1JUAbnCGf5foPNKNMjbQ/rWYk4iQ9YJg4Y4hb1+BE3xSyivaayMQaJ/qPe1WXc2fbvJmBO4dWPrMhabwb/1Byx0nvwHPUNpKhk425E59Q2DgTAqjgSzHeacFV77m/Xzc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=hdDV1nrZ; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <c6f33a36-1fac-4738-8a4f-c930b544ba62@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1713477439;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=biLTizcyKoXID4ZbzhVKkocFif6oiK6wrP0PDSnRgzg=;
	b=hdDV1nrZbThWa8XN/NOAuO1TL/Ie+Qg92kBzCL9omoSluxR1TfCLUx3kwj9uwhbZkQYaly
	uNfd4ePrxFLgf+WRQfHgp2SaiXqpRKDRAXNl3xVPpKLOw7cA/oobIZEK8kVA4zAI/YhO1e
	GatKGoshXof6N78AwIH65m7xeSRUk7E=
Date: Thu, 18 Apr 2024 14:57:12 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [RFC PATCH bpf-next v4 2/2] net: Add additional bit to support
 clockid_t timestamp type
To: "Abhishek Chauhan (ABC)" <quic_abchauha@quicinc.com>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Andrew Halaney <ahalaney@redhat.com>,
 Martin KaFai Lau <martin.lau@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, bpf <bpf@vger.kernel.org>,
 kernel@quicinc.com
References: <20240418004308.1009262-1-quic_abchauha@quicinc.com>
 <20240418004308.1009262-3-quic_abchauha@quicinc.com>
 <66216f3ec638b_f648a294ec@willemb.c.googlers.com.notmuch>
 <cb922600-783e-4741-be85-260d1ded5bdb@quicinc.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
Content-Language: en-US
In-Reply-To: <cb922600-783e-4741-be85-260d1ded5bdb@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 4/18/24 1:10 PM, Abhishek Chauhan (ABC) wrote:
>>>   #ifdef CONFIG_NET_XGRESS
>>>   	__u8			tc_at_ingress:1;	/* See TC_AT_INGRESS_MASK */
>>>   	__u8			tc_skip_classify:1;
>>> @@ -1096,10 +1100,12 @@ struct sk_buff {
>>>    */
>>>   #ifdef __BIG_ENDIAN_BITFIELD
>>>   #define SKB_MONO_DELIVERY_TIME_MASK	(1 << 7)
>>> -#define TC_AT_INGRESS_MASK		(1 << 6)
>>> +#define SKB_TAI_DELIVERY_TIME_MASK	(1 << 6)
>>
>> SKB_TSTAMP_TYPE_BIT2_MASK?

nit. Shorten it to just SKB_TSTAMP_TYPE_MASK?

#ifdef __BIG_ENDIAN_BITFIELD
#define SKB_TSTAMP_TYPE_MASK	(3 << 6)
#define SKB_TSTAMP_TYPE_RSH	(6)	/* more on this later */
#else
#define SKB_TSTAMP_TYPE_MASK	(3)
#endif

>>
> I was thinking to keep it as TAI because it will confuse developers. I hope thats okay.

I think it is not very useful to distinguish each bit since it is an enum value 
now. It becomes more like the "pkt_type:3" and its PKT_TYPE_MAX.

>>> +#define TC_AT_INGRESS_MASK		(1 << 5)
>>>   #else
>>>   #define SKB_MONO_DELIVERY_TIME_MASK	(1 << 0)
>>> -#define TC_AT_INGRESS_MASK		(1 << 1)
>>> +#define SKB_TAI_DELIVERY_TIME_MASK	(1 << 1)
>>> +#define TC_AT_INGRESS_MASK		(1 << 2)
>>>   #endif
>>>   #define SKB_BF_MONO_TC_OFFSET		offsetof(struct sk_buff, __mono_tc_offset)
>>>   
>>> @@ -4206,6 +4212,11 @@ static inline void skb_set_delivery_time(struct sk_buff *skb, ktime_t kt,
>>>   	case CLOCK_MONOTONIC:
>>>   		skb->tstamp_type = SKB_CLOCK_MONO;
>>>   		break;
>>> +	case CLOCK_TAI:
>>> +		skb->tstamp_type = SKB_CLOCK_TAI;
>>> +		break;
>>> +	default:
>>> +		WARN_ONCE(true, "clockid %d not supported", tstamp_type);
>>
>> and set to 0 and default tstamp_type?
>> Actually thinking about it. I feel if its unsupported just fall back to default is the correct thing. I will take care of this.
>>>   	}
>>>   }
>>
>>>   >
>>   @@ -9372,10 +9378,16 @@ static struct bpf_insn *bpf_convert_tstamp_type_read(const struct bpf_insn *si,
>>>   	*insn++ = BPF_LDX_MEM(BPF_B, tmp_reg, skb_reg,
>>>   			      SKB_BF_MONO_TC_OFFSET);
>>>   	*insn++ = BPF_JMP32_IMM(BPF_JSET, tmp_reg,
>>> -				SKB_MONO_DELIVERY_TIME_MASK, 2);
>>> +				SKB_MONO_DELIVERY_TIME_MASK | SKB_TAI_DELIVERY_TIME_MASK, 2);
>>> +	*insn++ = BPF_JMP32_IMM(BPF_JSET, tmp_reg,
>>> +				SKB_MONO_DELIVERY_TIME_MASK, 3);
>>> +	*insn++ = BPF_JMP32_IMM(BPF_JSET, tmp_reg,
>>> +				SKB_TAI_DELIVERY_TIME_MASK, 4);
>>>   	*insn++ = BPF_MOV32_IMM(value_reg, BPF_SKB_TSTAMP_UNSPEC);
>>>   	*insn++ = BPF_JMP_A(1);
>>>   	*insn++ = BPF_MOV32_IMM(value_reg, BPF_SKB_TSTAMP_DELIVERY_MONO);
>>> +	*insn++ = BPF_JMP_A(1);
>>> +	*insn++ = BPF_MOV32_IMM(value_reg, BPF_SKB_TSTAMP_DELIVERY_TAI);

With SKB_TSTAMP_TYPE_MASK defined like above, this could be simplified like this 
(untested):

static struct bpf_insn *bpf_convert_tstamp_type_read(const struct bpf_insn *si,
                                                      struct bpf_insn *insn)
{
	__u8 value_reg = si->dst_reg;
	__u8 skb_reg = si->src_reg;

	BUILD_BUG_ON(__SKB_CLOCK_MAX != BPF_SKB_TSTAMP_DELIVERY_TAI);
	*insn++ = BPF_LDX_MEM(BPF_B, value_reg, skb_reg, SKB_BF_MONO_TC_OFFSET);
	*insn++ = BPF_ALU32_IMM(BPF_AND, value_reg, SKB_TSTAMP_TYPE_MASK);
#ifdef __BIG_ENDIAN_BITFIELD
	*insn++ = BPF_ALU32_IMM(BPF_RSH, value_reg, SKB_TSTAMP_TYPE_RSH);
#else
	BUILD_BUG_ON(!(SKB_TSTAMP_TYPE_MASK & 0x1));
#endif

	return insn;
}

>>>   
>>>   	return insn;
>>>   }
>>> @@ -9418,10 +9430,26 @@ static struct bpf_insn *bpf_convert_tstamp_read(const struct bpf_prog *prog,
>>>   		__u8 tmp_reg = BPF_REG_AX;
>>>   
>>>   		*insn++ = BPF_LDX_MEM(BPF_B, tmp_reg, skb_reg, SKB_BF_MONO_TC_OFFSET);
>>> +		/*check if all three bits are set*/
>>>   		*insn++ = BPF_ALU32_IMM(BPF_AND, tmp_reg,
>>> -					TC_AT_INGRESS_MASK | SKB_MONO_DELIVERY_TIME_MASK);
>>> -		*insn++ = BPF_JMP32_IMM(BPF_JNE, tmp_reg,
>>> -					TC_AT_INGRESS_MASK | SKB_MONO_DELIVERY_TIME_MASK, 2);
>>> +					TC_AT_INGRESS_MASK | SKB_MONO_DELIVERY_TIME_MASK |
>>> +					SKB_TAI_DELIVERY_TIME_MASK);
>>> +		/*if all 3 bits are set jump 3 instructions and clear the register */
>>> +		*insn++ = BPF_JMP32_IMM(BPF_JEQ, tmp_reg,
>>> +					TC_AT_INGRESS_MASK | SKB_MONO_DELIVERY_TIME_MASK |
>>> +					SKB_TAI_DELIVERY_TIME_MASK, 4);
>>> +		/*Now check Mono is set with ingress mask if so clear */
>>> +		*insn++ = BPF_JMP32_IMM(BPF_JEQ, tmp_reg,
>>> +					TC_AT_INGRESS_MASK | SKB_MONO_DELIVERY_TIME_MASK, 3);
>>> +		/*Now Check tai is set with ingress mask if so clear */
>>> +		*insn++ = BPF_JMP32_IMM(BPF_JEQ, tmp_reg,
>>> +					TC_AT_INGRESS_MASK | SKB_TAI_DELIVERY_TIME_MASK, 2);
>>> +		/*Now Check tai and mono are set if so clear */
>>> +		*insn++ = BPF_JMP32_IMM(BPF_JEQ, tmp_reg,
>>> +					SKB_MONO_DELIVERY_TIME_MASK |
>>> +					SKB_TAI_DELIVERY_TIME_MASK, 1);

Same as the bpf_convert_tstamp_type_read, this could be simplified with 
SKB_TSTAMP_TYPE_MASK.

>>
>> This looks as if all JEQ result in "if so clear"?
>>
>> Is the goal to only do something different for the two bits being 0x1,
>> can we have a single test with a two-bit mask, rather than four tests?
>>
> I think Martin wanted to take care of TAI as well. I will wait for his comment here
> 
> My Goal was to take care of invalid combos which does not hold valid
> 1. If all 3 bits are set => invalid combo (Test case written is Insane)
> 2. If 2 bits are set (tai+mono)(Test case written is Insane) => this cannot happen (because clock base can only be one in skb)
> 3. If 2 bit are set (ingress + tai/mono) => This is existing logic + tai being added (clear tstamp in ingress)
> 4. For all other cases go ahead and fill in the tstamp in the dest register.

If it is to ensure no new type is added without adding 
BPF_SKB_TSTAMP_DELIVERY_XYZ, I would simplify this runtime bpf insns here and 
use a BUILD_BUG_ON to catch it at compile time. Something like,

enum skb_tstamp_type {
         SKB_CLOCK_REAL, /* Time base is skb is REALTIME */
         SKB_CLOCK_MONO, /* Time base is skb is MONOTONIC */
  	SKB_CLOCK_TAI,  /* Time base in skb is TAI */
         __SKB_CLOCK_MAX = SKB_CLOCK_TAI,
};

/* Same one used in the bpf_convert_tstamp_type_read() above */
BUILD_BUG_ON(__SKB_CLOCK_MAX != BPF_SKB_TSTAMP_DELIVERY_TAI);

Another thing is, the UDP test in test_tc_dtime.c probably needs to be adjusted, 
the userspace is using the CLOCK_TAI in SO_TXTIME and it is getting forwarded now.

