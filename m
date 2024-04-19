Return-Path: <bpf+bounces-27191-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E68E38AA63A
	for <lists+bpf@lfdr.de>; Fri, 19 Apr 2024 02:31:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9DC08282E5C
	for <lists+bpf@lfdr.de>; Fri, 19 Apr 2024 00:31:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 274BEA5F;
	Fri, 19 Apr 2024 00:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="lu4Ec9S9"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28D84384;
	Fri, 19 Apr 2024 00:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713486671; cv=none; b=MmbWyxQ1n5MulQ6LMYlZTkrF5nDnyl26lON72cyZL8wJsDXKbWg7kMgt90+pOKkKFGpLr/8wM5XovmS5uLNnpLX57e6bEgBr4ktJUipV1ETUlHgVKUYSFjGDtAV2uUeGL8gskw7VuxPY8Zu+mNnPtdJs7ZZPW4526LZR1JcymGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713486671; c=relaxed/simple;
	bh=Isrb3QzoCKiK2Z9sLsn4/2jFFK854EtKK/gj8VRmMGA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=TbJU11YOTfWzoUMfxdpeykB8ZzKsWwPgwZG5TSb3MLQ3mdzvZJBqIQq2LUBTJ1ELc8CcQtgdqhYgRFhs1CojF4xx1U2VQBGK3wbXfQo29Ycyw9Hrh6yc/jxPEtpZMEF8FBFbM2HEgwqgpUTsjKWRN3YQvFDY4ZUABJCTYdC0ZWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=lu4Ec9S9; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43INVJDX012342;
	Fri, 19 Apr 2024 00:30:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=DP3WH8T5u2Mj0DWTVnv9SHT0caAhXrzISup6jX5KZl4=; b=lu
	4Ec9S9AMTkiuVgsQ7LOUuxroETMkOPjssA9tT11+EJM4MoEvTCnNMf1g3FP68Dx3
	/p4UMweyFDnf74sqdHZ2ZM4XzNyBs6wZJJ8bANBYI/dZY7rAEuro9hblPyaBYxk+
	4KflFFJWMjxynyO/nfCWAUhTYNLbDzTlige0ovt1KaByX/OiuqkfelK7GJVjpzOB
	FQu5j5Q33+ge+AviRCviS620GO06IaoxPqp9CfGNcwvacUf9Q6b5oixRCp9Vgczg
	fWaieyRWFUNU/ZFeY8pxpOq6lK86Ad3XOJKD0UzBrPHz9PeziVHIYiYTW1giOO1a
	up/Nerk4zj1JhO1SzeCA==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xk9s78gwr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Apr 2024 00:30:48 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43J0UlPR008644
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Apr 2024 00:30:47 GMT
Received: from [10.110.72.56] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 18 Apr
 2024 17:30:43 -0700
Message-ID: <6b6bd108-817c-4a58-8b69-6c2dde436575@quicinc.com>
Date: Thu, 18 Apr 2024 17:30:42 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH bpf-next v4 2/2] net: Add additional bit to support
 clockid_t timestamp type
Content-Language: en-US
To: Martin KaFai Lau <martin.lau@linux.dev>,
        Willem de Bruijn
	<willemdebruijn.kernel@gmail.com>
CC: "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Andrew Halaney <ahalaney@redhat.com>,
        "Martin
 KaFai Lau" <martin.lau@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, bpf <bpf@vger.kernel.org>,
        <kernel@quicinc.com>
References: <20240418004308.1009262-1-quic_abchauha@quicinc.com>
 <20240418004308.1009262-3-quic_abchauha@quicinc.com>
 <66216f3ec638b_f648a294ec@willemb.c.googlers.com.notmuch>
 <cb922600-783e-4741-be85-260d1ded5bdb@quicinc.com>
 <c6f33a36-1fac-4738-8a4f-c930b544ba62@linux.dev>
From: "Abhishek Chauhan (ABC)" <quic_abchauha@quicinc.com>
In-Reply-To: <c6f33a36-1fac-4738-8a4f-c930b544ba62@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 2MMPP5jOi5zHREaa-J_w6hD-ijBrTD-w
X-Proofpoint-ORIG-GUID: 2MMPP5jOi5zHREaa-J_w6hD-ijBrTD-w
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-18_21,2024-04-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 spamscore=0
 phishscore=0 mlxlogscore=999 priorityscore=1501 adultscore=0
 impostorscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=0
 bulkscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404190001



On 4/18/2024 2:57 PM, Martin KaFai Lau wrote:
> On 4/18/24 1:10 PM, Abhishek Chauhan (ABC) wrote:
>>>>   #ifdef CONFIG_NET_XGRESS
>>>>       __u8            tc_at_ingress:1;    /* See TC_AT_INGRESS_MASK */
>>>>       __u8            tc_skip_classify:1;
>>>> @@ -1096,10 +1100,12 @@ struct sk_buff {
>>>>    */
>>>>   #ifdef __BIG_ENDIAN_BITFIELD
>>>>   #define SKB_MONO_DELIVERY_TIME_MASK    (1 << 7)
>>>> -#define TC_AT_INGRESS_MASK        (1 << 6)
>>>> +#define SKB_TAI_DELIVERY_TIME_MASK    (1 << 6)
>>>
>>> SKB_TSTAMP_TYPE_BIT2_MASK?
> 
> nit. Shorten it to just SKB_TSTAMP_TYPE_MASK?
> 
Okay i will do the same. Noted!
> #ifdef __BIG_ENDIAN_BITFIELD
> #define SKB_TSTAMP_TYPE_MASK    (3 << 6)
> #define SKB_TSTAMP_TYPE_RSH    (6)    /* more on this later */
> #else
> #define SKB_TSTAMP_TYPE_MASK    (3)
> #endif
> 
>>>
>> I was thinking to keep it as TAI because it will confuse developers. I hope thats okay.
> 
> I think it is not very useful to distinguish each bit since it is an enum value now. It becomes more like the "pkt_type:3" and its PKT_TYPE_MAX.
>I see what you are saying.
>>>> +#define TC_AT_INGRESS_MASK        (1 << 5)
>>>>   #else
>>>>   #define SKB_MONO_DELIVERY_TIME_MASK    (1 << 0)
>>>> -#define TC_AT_INGRESS_MASK        (1 << 1)
>>>> +#define SKB_TAI_DELIVERY_TIME_MASK    (1 << 1)
>>>> +#define TC_AT_INGRESS_MASK        (1 << 2)
>>>>   #endif
>>>>   #define SKB_BF_MONO_TC_OFFSET        offsetof(struct sk_buff, __mono_tc_offset)
>>>>   @@ -4206,6 +4212,11 @@ static inline void skb_set_delivery_time(struct sk_buff *skb, ktime_t kt,
>>>>       case CLOCK_MONOTONIC:
>>>>           skb->tstamp_type = SKB_CLOCK_MONO;
>>>>           break;
>>>> +    case CLOCK_TAI:
>>>> +        skb->tstamp_type = SKB_CLOCK_TAI;
>>>> +        break;
>>>> +    default:
>>>> +        WARN_ONCE(true, "clockid %d not supported", tstamp_type);
>>>
>>> and set to 0 and default tstamp_type?
>>> Actually thinking about it. I feel if its unsupported just fall back to default is the correct thing. I will take care of this.
>>>>       }
>>>>   }
>>>
>>>>   >
>>>   @@ -9372,10 +9378,16 @@ static struct bpf_insn *bpf_convert_tstamp_type_read(const struct bpf_insn *si,
>>>>       *insn++ = BPF_LDX_MEM(BPF_B, tmp_reg, skb_reg,
>>>>                     SKB_BF_MONO_TC_OFFSET);
>>>>       *insn++ = BPF_JMP32_IMM(BPF_JSET, tmp_reg,
>>>> -                SKB_MONO_DELIVERY_TIME_MASK, 2);
>>>> +                SKB_MONO_DELIVERY_TIME_MASK | SKB_TAI_DELIVERY_TIME_MASK, 2);
>>>> +    *insn++ = BPF_JMP32_IMM(BPF_JSET, tmp_reg,
>>>> +                SKB_MONO_DELIVERY_TIME_MASK, 3);
>>>> +    *insn++ = BPF_JMP32_IMM(BPF_JSET, tmp_reg,
>>>> +                SKB_TAI_DELIVERY_TIME_MASK, 4);
>>>>       *insn++ = BPF_MOV32_IMM(value_reg, BPF_SKB_TSTAMP_UNSPEC);
>>>>       *insn++ = BPF_JMP_A(1);
>>>>       *insn++ = BPF_MOV32_IMM(value_reg, BPF_SKB_TSTAMP_DELIVERY_MONO);
>>>> +    *insn++ = BPF_JMP_A(1);
>>>> +    *insn++ = BPF_MOV32_IMM(value_reg, BPF_SKB_TSTAMP_DELIVERY_TAI);
> 
> With SKB_TSTAMP_TYPE_MASK defined like above, this could be simplified like this (untested):
> 
Let me think this through and raise it as part of the next rfc patch. 
> static struct bpf_insn *bpf_convert_tstamp_type_read(const struct bpf_insn *si,
>                                                      struct bpf_insn *insn)
> {
>     __u8 value_reg = si->dst_reg;
>     __u8 skb_reg = si->src_reg;
> 
>     BUILD_BUG_ON(__SKB_CLOCK_MAX != BPF_SKB_TSTAMP_DELIVERY_TAI);
>     *insn++ = BPF_LDX_MEM(BPF_B, value_reg, skb_reg, SKB_BF_MONO_TC_OFFSET);
>     *insn++ = BPF_ALU32_IMM(BPF_AND, value_reg, SKB_TSTAMP_TYPE_MASK);
> #ifdef __BIG_ENDIAN_BITFIELD
>     *insn++ = BPF_ALU32_IMM(BPF_RSH, value_reg, SKB_TSTAMP_TYPE_RSH);
> #else
>     BUILD_BUG_ON(!(SKB_TSTAMP_TYPE_MASK & 0x1));
> #endif
> 
>     return insn;
> }
> 
>>>>         return insn;
>>>>   }
>>>> @@ -9418,10 +9430,26 @@ static struct bpf_insn *bpf_convert_tstamp_read(const struct bpf_prog *prog,
>>>>           __u8 tmp_reg = BPF_REG_AX;
>>>>             *insn++ = BPF_LDX_MEM(BPF_B, tmp_reg, skb_reg, SKB_BF_MONO_TC_OFFSET);
>>>> +        /*check if all three bits are set*/
>>>>           *insn++ = BPF_ALU32_IMM(BPF_AND, tmp_reg,
>>>> -                    TC_AT_INGRESS_MASK | SKB_MONO_DELIVERY_TIME_MASK);
>>>> -        *insn++ = BPF_JMP32_IMM(BPF_JNE, tmp_reg,
>>>> -                    TC_AT_INGRESS_MASK | SKB_MONO_DELIVERY_TIME_MASK, 2);
>>>> +                    TC_AT_INGRESS_MASK | SKB_MONO_DELIVERY_TIME_MASK |
>>>> +                    SKB_TAI_DELIVERY_TIME_MASK);
>>>> +        /*if all 3 bits are set jump 3 instructions and clear the register */
>>>> +        *insn++ = BPF_JMP32_IMM(BPF_JEQ, tmp_reg,
>>>> +                    TC_AT_INGRESS_MASK | SKB_MONO_DELIVERY_TIME_MASK |
>>>> +                    SKB_TAI_DELIVERY_TIME_MASK, 4);
>>>> +        /*Now check Mono is set with ingress mask if so clear */
>>>> +        *insn++ = BPF_JMP32_IMM(BPF_JEQ, tmp_reg,
>>>> +                    TC_AT_INGRESS_MASK | SKB_MONO_DELIVERY_TIME_MASK, 3);
>>>> +        /*Now Check tai is set with ingress mask if so clear */
>>>> +        *insn++ = BPF_JMP32_IMM(BPF_JEQ, tmp_reg,
>>>> +                    TC_AT_INGRESS_MASK | SKB_TAI_DELIVERY_TIME_MASK, 2);
>>>> +        /*Now Check tai and mono are set if so clear */
>>>> +        *insn++ = BPF_JMP32_IMM(BPF_JEQ, tmp_reg,
>>>> +                    SKB_MONO_DELIVERY_TIME_MASK |
>>>> +                    SKB_TAI_DELIVERY_TIME_MASK, 1);
> 
> Same as the bpf_convert_tstamp_type_read, this could be simplified with SKB_TSTAMP_TYPE_MASK.
> 
>>>
>>> This looks as if all JEQ result in "if so clear"?
>>>
>>> Is the goal to only do something different for the two bits being 0x1,
>>> can we have a single test with a two-bit mask, rather than four tests?
>>>
>> I think Martin wanted to take care of TAI as well. I will wait for his comment here
>>
>> My Goal was to take care of invalid combos which does not hold valid
>> 1. If all 3 bits are set => invalid combo (Test case written is Insane)
>> 2. If 2 bits are set (tai+mono)(Test case written is Insane) => this cannot happen (because clock base can only be one in skb)
>> 3. If 2 bit are set (ingress + tai/mono) => This is existing logic + tai being added (clear tstamp in ingress)
>> 4. For all other cases go ahead and fill in the tstamp in the dest register.
> 
> If it is to ensure no new type is added without adding BPF_SKB_TSTAMP_DELIVERY_XYZ, I would simplify this runtime bpf insns here and use a BUILD_BUG_ON to catch it at compile time. Something like,
> 
> enum skb_tstamp_type {
>         SKB_CLOCK_REAL, /* Time base is skb is REALTIME */
>         SKB_CLOCK_MONO, /* Time base is skb is MONOTONIC */
>      SKB_CLOCK_TAI,  /* Time base in skb is TAI */
>         __SKB_CLOCK_MAX = SKB_CLOCK_TAI,
> };
> 
> /* Same one used in the bpf_convert_tstamp_type_read() above */
> BUILD_BUG_ON(__SKB_CLOCK_MAX != BPF_SKB_TSTAMP_DELIVERY_TAI);
> 
> Another thing is, the UDP test in test_tc_dtime.c probably needs to be adjusted, the userspace is using the CLOCK_TAI in SO_TXTIME and it is getting forwarded now.
Noted ! Let me check and evalute this as well. 

