Return-Path: <bpf+bounces-27456-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 98B2E8AD450
	for <lists+bpf@lfdr.de>; Mon, 22 Apr 2024 20:49:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C934286735
	for <lists+bpf@lfdr.de>; Mon, 22 Apr 2024 18:49:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CC4A157488;
	Mon, 22 Apr 2024 18:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="vuZ4leAg"
X-Original-To: bpf@vger.kernel.org
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFCF8156C77
	for <bpf@vger.kernel.org>; Mon, 22 Apr 2024 18:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713811589; cv=none; b=YqVWdpaxZwnYVROhO1gfewTBw7x4H4SIutD7PGDqDuKSjx0Vv9A5Bjd0KFF08xQ1/KYjHhDXtRAwz9+xeo3TPoXPASdb6UwJFiiff7NtbUWbAFyxmQNmCZ33sQw6iiWjgYVteA4Oh/PB74+8I5ar/zOR8Wr8oEUlIuBHmUM/o6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713811589; c=relaxed/simple;
	bh=noHXfVMJV+yXJVx0vjokRg9H1rF7im7quabjLuDwldk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tv1CF7EJpjj3Jm8zjEXM56hRFsRlUogbB2lLHavtpx47/XFAkBoUhcXcTLEfOWV6/yXh+xyiHh3jYPURNkkXGlza0x1oPeaOtzomyHP8CYP/igMSivymmo0tXAzVbMbOzlqAA5dFbSMQY5R2i442Vmd5rqSKGO9AhFXmyLZGuhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=vuZ4leAg; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <c90fcc07-38bf-4d0c-9729-5c071134e4e1@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1713811585;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Hmx5bIC9HXhYXvBA5QU87uwq6RGHLvRpwGDnjq22S+Y=;
	b=vuZ4leAgw32yhPRgHio+YtpCjzv1H4dHtDy0TivOTncN32ArN5czGV5iz5prcT5D3wDHoi
	ahs0/U5jkJoiGF9yc/FjHxd6yCYqpbbtGaQeo6LnPzm/U0u4r1Xa3SD657PZZEbLYmPPNz
	FR4oSCPUfKKHPcwTmVFHKs7EJ9K3XkU=
Date: Mon, 22 Apr 2024 11:46:19 -0700
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
 <c6f33a36-1fac-4738-8a4f-c930b544ba62@linux.dev>
 <6b6bd108-817c-4a58-8b69-6c2dde436575@quicinc.com>
 <79ca7697-339a-4f72-ab12-5a3094b294f3@quicinc.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
Content-Language: en-US
In-Reply-To: <79ca7697-339a-4f72-ab12-5a3094b294f3@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 4/19/24 6:13 PM, Abhishek Chauhan (ABC) wrote:
> 
> 
> On 4/18/2024 5:30 PM, Abhishek Chauhan (ABC) wrote:
>>
>>
>> On 4/18/2024 2:57 PM, Martin KaFai Lau wrote:
>>> On 4/18/24 1:10 PM, Abhishek Chauhan (ABC) wrote:
>>>>>>    #ifdef CONFIG_NET_XGRESS
>>>>>>        __u8            tc_at_ingress:1;    /* See TC_AT_INGRESS_MASK */
>>>>>>        __u8            tc_skip_classify:1;
>>>>>> @@ -1096,10 +1100,12 @@ struct sk_buff {
>>>>>>     */
>>>>>>    #ifdef __BIG_ENDIAN_BITFIELD
>>>>>>    #define SKB_MONO_DELIVERY_TIME_MASK    (1 << 7)
>>>>>> -#define TC_AT_INGRESS_MASK        (1 << 6)
>>>>>> +#define SKB_TAI_DELIVERY_TIME_MASK    (1 << 6)
>>>>>
>>>>> SKB_TSTAMP_TYPE_BIT2_MASK?
>>>
>>> nit. Shorten it to just SKB_TSTAMP_TYPE_MASK?
>>>
>> Okay i will do the same. Noted!
>>> #ifdef __BIG_ENDIAN_BITFIELD
>>> #define SKB_TSTAMP_TYPE_MASK    (3 << 6)
>>> #define SKB_TSTAMP_TYPE_RSH    (6)    /* more on this later */
>>> #else
>>> #define SKB_TSTAMP_TYPE_MASK    (3)
>>> #endif
>>>
>>>>>
>>>> I was thinking to keep it as TAI because it will confuse developers. I hope thats okay.
>>>
>>> I think it is not very useful to distinguish each bit since it is an enum value now. It becomes more like the "pkt_type:3" and its PKT_TYPE_MAX.
>>> I see what you are saying.
>>>>>> +#define TC_AT_INGRESS_MASK        (1 << 5)
>>>>>>    #else
>>>>>>    #define SKB_MONO_DELIVERY_TIME_MASK    (1 << 0)
>>>>>> -#define TC_AT_INGRESS_MASK        (1 << 1)
>>>>>> +#define SKB_TAI_DELIVERY_TIME_MASK    (1 << 1)
>>>>>> +#define TC_AT_INGRESS_MASK        (1 << 2)
>>>>>>    #endif
>>>>>>    #define SKB_BF_MONO_TC_OFFSET        offsetof(struct sk_buff, __mono_tc_offset)
>>>>>>    @@ -4206,6 +4212,11 @@ static inline void skb_set_delivery_time(struct sk_buff *skb, ktime_t kt,
>>>>>>        case CLOCK_MONOTONIC:
>>>>>>            skb->tstamp_type = SKB_CLOCK_MONO;
>>>>>>            break;
>>>>>> +    case CLOCK_TAI:
>>>>>> +        skb->tstamp_type = SKB_CLOCK_TAI;
>>>>>> +        break;
>>>>>> +    default:
>>>>>> +        WARN_ONCE(true, "clockid %d not supported", tstamp_type);
>>>>>
>>>>> and set to 0 and default tstamp_type?
>>>>> Actually thinking about it. I feel if its unsupported just fall back to default is the correct thing. I will take care of this.
>>>>>>        }
>>>>>>    }
>>>>>
>>>>>>    >
>>>>>    @@ -9372,10 +9378,16 @@ static struct bpf_insn *bpf_convert_tstamp_type_read(const struct bpf_insn *si,
>>>>>>        *insn++ = BPF_LDX_MEM(BPF_B, tmp_reg, skb_reg,
>>>>>>                      SKB_BF_MONO_TC_OFFSET);
>>>>>>        *insn++ = BPF_JMP32_IMM(BPF_JSET, tmp_reg,
>>>>>> -                SKB_MONO_DELIVERY_TIME_MASK, 2);
>>>>>> +                SKB_MONO_DELIVERY_TIME_MASK | SKB_TAI_DELIVERY_TIME_MASK, 2);
>>>>>> +    *insn++ = BPF_JMP32_IMM(BPF_JSET, tmp_reg,
>>>>>> +                SKB_MONO_DELIVERY_TIME_MASK, 3);
>>>>>> +    *insn++ = BPF_JMP32_IMM(BPF_JSET, tmp_reg,
>>>>>> +                SKB_TAI_DELIVERY_TIME_MASK, 4);
>>>>>>        *insn++ = BPF_MOV32_IMM(value_reg, BPF_SKB_TSTAMP_UNSPEC);
>>>>>>        *insn++ = BPF_JMP_A(1);
>>>>>>        *insn++ = BPF_MOV32_IMM(value_reg, BPF_SKB_TSTAMP_DELIVERY_MONO);
>>>>>> +    *insn++ = BPF_JMP_A(1);
>>>>>> +    *insn++ = BPF_MOV32_IMM(value_reg, BPF_SKB_TSTAMP_DELIVERY_TAI);
>>>
>>> With SKB_TSTAMP_TYPE_MASK defined like above, this could be simplified like this (untested):
>>>
>> Let me think this through and raise it as part of the next rfc patch.
>>> static struct bpf_insn *bpf_convert_tstamp_type_read(const struct bpf_insn *si,
>>>                                                       struct bpf_insn *insn)
>>> {
>>>      __u8 value_reg = si->dst_reg;
>>>      __u8 skb_reg = si->src_reg;
>>>
>>>      BUILD_BUG_ON(__SKB_CLOCK_MAX != BPF_SKB_TSTAMP_DELIVERY_TAI);
>>>      *insn++ = BPF_LDX_MEM(BPF_B, value_reg, skb_reg, SKB_BF_MONO_TC_OFFSET);
>>>      *insn++ = BPF_ALU32_IMM(BPF_AND, value_reg, SKB_TSTAMP_TYPE_MASK);
>>> #ifdef __BIG_ENDIAN_BITFIELD
>>>      *insn++ = BPF_ALU32_IMM(BPF_RSH, value_reg, SKB_TSTAMP_TYPE_RSH);
>>> #else
>>>      BUILD_BUG_ON(!(SKB_TSTAMP_TYPE_MASK & 0x1));
>>> #endif
>>>
>>>      return insn;
>>> }
>>>
>>>>>>          return insn;
>>>>>>    }
>>>>>> @@ -9418,10 +9430,26 @@ static struct bpf_insn *bpf_convert_tstamp_read(const struct bpf_prog *prog,
>>>>>>            __u8 tmp_reg = BPF_REG_AX;
>>>>>>              *insn++ = BPF_LDX_MEM(BPF_B, tmp_reg, skb_reg, SKB_BF_MONO_TC_OFFSET);
>>>>>> +        /*check if all three bits are set*/
>>>>>>            *insn++ = BPF_ALU32_IMM(BPF_AND, tmp_reg,
>>>>>> -                    TC_AT_INGRESS_MASK | SKB_MONO_DELIVERY_TIME_MASK);
>>>>>> -        *insn++ = BPF_JMP32_IMM(BPF_JNE, tmp_reg,
>>>>>> -                    TC_AT_INGRESS_MASK | SKB_MONO_DELIVERY_TIME_MASK, 2);
>>>>>> +                    TC_AT_INGRESS_MASK | SKB_MONO_DELIVERY_TIME_MASK |
>>>>>> +                    SKB_TAI_DELIVERY_TIME_MASK);
>>>>>> +        /*if all 3 bits are set jump 3 instructions and clear the register */
>>>>>> +        *insn++ = BPF_JMP32_IMM(BPF_JEQ, tmp_reg,
>>>>>> +                    TC_AT_INGRESS_MASK | SKB_MONO_DELIVERY_TIME_MASK |
>>>>>> +                    SKB_TAI_DELIVERY_TIME_MASK, 4);
>>>>>> +        /*Now check Mono is set with ingress mask if so clear */
>>>>>> +        *insn++ = BPF_JMP32_IMM(BPF_JEQ, tmp_reg,
>>>>>> +                    TC_AT_INGRESS_MASK | SKB_MONO_DELIVERY_TIME_MASK, 3);
>>>>>> +        /*Now Check tai is set with ingress mask if so clear */
>>>>>> +        *insn++ = BPF_JMP32_IMM(BPF_JEQ, tmp_reg,
>>>>>> +                    TC_AT_INGRESS_MASK | SKB_TAI_DELIVERY_TIME_MASK, 2);
>>>>>> +        /*Now Check tai and mono are set if so clear */
>>>>>> +        *insn++ = BPF_JMP32_IMM(BPF_JEQ, tmp_reg,
>>>>>> +                    SKB_MONO_DELIVERY_TIME_MASK |
>>>>>> +                    SKB_TAI_DELIVERY_TIME_MASK, 1);
>>>
>>> Same as the bpf_convert_tstamp_type_read, this could be simplified with SKB_TSTAMP_TYPE_MASK.
>>>
> Willem and Martin,
> When do we clear the tstamp and make it 0 in bpf_convert_tstamp_read? meaning which configuration?

When the bpf prog does not check the skb->tstamp_type. It is
the "if (!prog->tstamp_type_access)" in bpf_convert_tstamp_read().

If bpf prog does not check the skb->tstamp_type and it is at ingress,
bpf prog expects recv tstamp (ie. real clock), so it needs to clear
out the tstamp (i.e read as 0 tstamp).

> I see previously(current upstream code) if mono_delivery is set and tc_ingress_mask is set
> upstream code used to set the tstamp as 0.
> 
> Which means with addition of tai mask the new implementation should take care of following cases(correct me if i am wrong)
> 1. ( tai mask set + ingress mask set ) = Clear tstamp
> 2. ( mono mask set + ingress mask set ) = Clear tstamp
> 3. ( mono mask set + tai mask set + ingress mask set ) = Clear tstamp
> 4. ( No mask set ) = Clear tstamp
> 5. ( Tai mask set + mono mask set ) = Clear tstamp

No need to check the individual mono and tai bit here. Check the
tstamp_type as a whole. Like in pseudo C:

if (skb->tc_at_ingress && skb->tstamp_type)
	value_reg = 0;

untested code for tstamp_read() and tstamp_write():

static struct bpf_insn *bpf_convert_tstamp_read(const struct bpf_prog *prog,
                                                 const struct bpf_insn *si,
                                                 struct bpf_insn *insn)
{
	__u8 value_reg = si->dst_reg;
	__u8 skb_reg = si->src_reg;

#ifdef CONFIG_NET_XGRESS
	/* If the tstamp_type is read,
	 * the bpf prog is aware the tstamp could have delivery time.
	 * Thus, read skb->tstamp as is if tstamp_type_access is true.
	 */
	if (!prog->tstamp_type_access) {
		/* AX is needed because src_reg and dst_reg could be the same */
		__u8 tmp_reg = BPF_REG_AX;

		*insn++ = BPF_LDX_MEM(BPF_B, tmp_reg, skb_reg, SKB_BF_MONO_TC_OFFSET);
		*insn++ = BPF_JMP32_IMM(BPF_JSET, tmp_reg, TC_AT_INGRESS_MASK, 1);
		/* goto <read> */
		BPF_JMP_A(4);
		*insn++ = BPF_JMP32_IMM(BPF_JSET, tmp_reg, SKB_TSTAMP_TYPE_MASK, 1);
		/* goto <read> */
		BPF_JMP_A(2);
		/* skb->tc_at_ingress && skb->tstamp_type,
		 * read 0 as the (rcv) timestamp.
		 */
		*insn++ = BPF_MOV64_IMM(value_reg, 0);
		*insn++ = BPF_JMP_A(1);
	}
#endif

	/* <read>: value_reg = skb->tstamp */
	*insn++ = BPF_LDX_MEM(BPF_DW, value_reg, skb_reg,
			      offsetof(struct sk_buff, tstamp));
	return insn;
}

static struct bpf_insn *bpf_convert_tstamp_write(const struct bpf_prog *prog,
                                                  const struct bpf_insn *si,
	                                         struct bpf_insn *insn)
{
	__u8 value_reg = si->src_reg;
	__u8 skb_reg = si->dst_reg;

#ifdef CONFIG_NET_XGRESS
	/* If the tstamp_type is read,
	 * the bpf prog is aware the tstamp could have delivery time.
	 * Thus, write skb->tstamp as is if tstamp_type_access is true.
	 * Otherwise, writing at ingress will have to clear the
	 * mono_delivery_time (skb->tstamp_type:1)bit also.
	 */
         if (!prog->tstamp_type_access) {
		__u8 tmp_reg = BPF_REG_AX;

		*insn++ = BPF_LDX_MEM(BPF_B, tmp_reg, skb_reg, SKB_BF_MONO_TC_OFFSET);
		/* Writing __sk_buff->tstamp as ingress, goto <clear> */
		*insn++ = BPF_JMP32_IMM(BPF_JSET, tmp_reg, TC_AT_INGRESS_MASK, 1);
		/* goto <store> */
		*insn++ = BPF_JMP_A(2);
		/* <clear>: skb->tstamp_type */
		*insn++ = BPF_ALU32_IMM(BPF_AND, tmp_reg, ~SKB_TSTAMP_TYPE_MASK);
		*insn++ = BPF_STX_MEM(BPF_B, skb_reg, tmp_reg, SKB_BF_MONO_TC_OFFSET);
	}
#endif

	/* <store>: skb->tstamp = tstamp */
	*insn++ = BPF_RAW_INSN(BPF_CLASS(si->code) | BPF_DW | BPF_MEM,
			       skb_reg, value_reg, offsetof(struct sk_buff, tstamp), si->imm);
         return insn;
}

> 
> This leaves us with only two values which can be support which is 0x1 and 0x2
> 
> This means the tstamp_type should be either 0x1(mono) and tstamp_type 0x2 (tai) to set the value_reg with tstamp
> Is my understanding correct ?
> 
> Do you think the below simplified version looks okay ?
> 
> static struct bpf_insn *bpf_convert_tstamp_read(const struct bpf_prog *prog,
> 						const struct bpf_insn *si,
> 						struct bpf_insn *insn)
> {
> 	__u8 value_reg = si->dst_reg;
> 	__u8 skb_reg = si->src_reg;
> 
> BUILD_BUG_ON(__SKB_CLOCK_MAX != BPF_SKB_TSTAMP_DELIVERY_TAI);
> #ifdef CONFIG_NET_XGRESS
> 	/* If the tstamp_type is read,
> 	 * the bpf prog is aware the tstamp could have delivery time.
> 	 * Thus, read skb->tstamp as is if tstamp_type_access is true.
> 	 */
> 	if (!prog->tstamp_type_access) {
> 		/* AX is needed because src_reg and dst_reg could be the same */
> 		__u8 tmp_reg = BPF_REG_AX;
> 
> 		*insn++ = BPF_LDX_MEM(BPF_B, tmp_reg, skb_reg, SKB_BF_MONO_TC_OFFSET);
> 		/* check if all three bits are set*/
> 		*insn++ = BPF_ALU32_IMM(BPF_AND, tmp_reg,
> 					TC_AT_INGRESS_MASK | SKB_TSTAMP_TYPE_MASK);
> 
> 		/* If the value of tmp_reg is 7,6,5,4,3,0 which means invalid
> 		 * configuration set the tstamp to 0, value 0x1 and 0x2
> 		 * is correct configuration
> 		 */
> #ifdef __BIG_ENDIAN_BITFIELD
> 		*insn++ = BPF_JMP32_IMM(BPF_JEQ, tmp_reg, 0x1 << SKB_TSTAMP_TYPE_RSH, 3);
> 		*insn++ = BPF_JMP32_IMM(BPF_JEQ, tmp_reg, 0x2 << SKB_TSTAMP_TYPE_RSH, 2);
> #endif
> 		*insn++ = BPF_JMP32_IMM(BPF_JEQ, tmp_reg, 0x1, 3);
> 		*insn++ = BPF_JMP32_IMM(BPF_JEQ, tmp_reg, 0x2, 2);
> #endif
> 		/* skb->tc_at_ingress && skb->tstamp_type:2,
> 		 * read 0 as the (rcv) timestamp.
> 		 */
> 		*insn++ = BPF_MOV64_IMM(value_reg, 0);
> 		*insn++ = BPF_JMP_A(1);
> 	}
> #endif
> 
> 	*insn++ = BPF_LDX_MEM(BPF_DW, value_reg, skb_reg,
> 			      offsetof(struct sk_buff, tstamp));
> 	return insn;
> }
> 
> 


