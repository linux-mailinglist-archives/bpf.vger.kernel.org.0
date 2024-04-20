Return-Path: <bpf+bounces-27273-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9FE88AB840
	for <lists+bpf@lfdr.de>; Sat, 20 Apr 2024 03:14:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91DE628210A
	for <lists+bpf@lfdr.de>; Sat, 20 Apr 2024 01:14:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62BC91851;
	Sat, 20 Apr 2024 01:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="TltDCI7X"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 144165382;
	Sat, 20 Apr 2024 01:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713575635; cv=none; b=FC91E1eRyMipSGENSZ+8KgwYkOdeuv914qOhrEP8/jec0ZSYSn43jHF9i1wqSxy1NZ7hz/Ud8Dn0ZVijhKk2BdZoQHaGRbBkOpMMBvVg2kSdQILdkxgGSgyLBlYxKTXyJaGNwqhCDUESjhrG0Vk3K0iPVtYlTPkOlH5V23s3Ye8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713575635; c=relaxed/simple;
	bh=Hk1svNgXwfFIrQdQxIyRYR0rDzTAJ63xuHHdFQpGMA8=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:CC:References:
	 In-Reply-To:Content-Type; b=lKEBQvUnW/eIgCQyJAtG2M+c/VvcJu6sGCTgKj8HQcu9Bp/z5Hk5UGMUUN4stCEy1hrUVvvRAGej1m4c4gsbFbL4Myb1EH3fxk6YysBROp2df/Ndwtq0B6oiveXVXoS0dXZf9a+gTFMLKIHRO2/UiSGXvgbP2hCrv/3QPWYfaQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=TltDCI7X; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43K1DQeC005734;
	Sat, 20 Apr 2024 01:13:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:from:to:cc:references
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=Iz09JlUu4ttzsZ1gIpSRDs7W2LQ2ZfKxWOVKD6ckK8U=; b=Tl
	tDCI7Xi8TcVp/AqFNVvLVCVLI/Et2OE1+50sbymOZWpdWU1n/ZlbT4TWMNFVlfLW
	5p9mqJgZ5Tr1sC6lHI7Maujj9DYfoQMbisre78xdFKOUJBpOZ71pQTP7CtWQj3Zr
	VMuo3w/+ZQcTtd8lj1576Zb3UFQFDWNOJdoImw9eWcNSbZWE77XBwo/RJ4f4kF4I
	bgTtl7BFNLOR3zLspTpofIdmxwQ0KSZ8KZlsG1oouLp/kXbNA26b7ihI0j4Qe+A0
	QCux0sLbYEQ+dShrODNMHt7OLq0Y1FR0A291elFuRrnktI6gVhl+VRFzifEPu3dZ
	qhL3gtepMkQBHIatkN6w==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xm3uqg00u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 20 Apr 2024 01:13:25 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43K1DOZP027412
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 20 Apr 2024 01:13:24 GMT
Received: from [10.110.72.56] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 19 Apr
 2024 18:13:20 -0700
Message-ID: <79ca7697-339a-4f72-ab12-5a3094b294f3@quicinc.com>
Date: Fri, 19 Apr 2024 18:13:19 -0700
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
From: "Abhishek Chauhan (ABC)" <quic_abchauha@quicinc.com>
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
 <6b6bd108-817c-4a58-8b69-6c2dde436575@quicinc.com>
In-Reply-To: <6b6bd108-817c-4a58-8b69-6c2dde436575@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: UX1E9lDaajyniJqMcJxPMPMUgBwMlX4M
X-Proofpoint-GUID: UX1E9lDaajyniJqMcJxPMPMUgBwMlX4M
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-19_17,2024-04-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 adultscore=0
 malwarescore=0 spamscore=0 mlxlogscore=999 mlxscore=0 bulkscore=0
 phishscore=0 impostorscore=0 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404200004



On 4/18/2024 5:30 PM, Abhishek Chauhan (ABC) wrote:
> 
> 
> On 4/18/2024 2:57 PM, Martin KaFai Lau wrote:
>> On 4/18/24 1:10 PM, Abhishek Chauhan (ABC) wrote:
>>>>>   #ifdef CONFIG_NET_XGRESS
>>>>>       __u8            tc_at_ingress:1;    /* See TC_AT_INGRESS_MASK */
>>>>>       __u8            tc_skip_classify:1;
>>>>> @@ -1096,10 +1100,12 @@ struct sk_buff {
>>>>>    */
>>>>>   #ifdef __BIG_ENDIAN_BITFIELD
>>>>>   #define SKB_MONO_DELIVERY_TIME_MASK    (1 << 7)
>>>>> -#define TC_AT_INGRESS_MASK        (1 << 6)
>>>>> +#define SKB_TAI_DELIVERY_TIME_MASK    (1 << 6)
>>>>
>>>> SKB_TSTAMP_TYPE_BIT2_MASK?
>>
>> nit. Shorten it to just SKB_TSTAMP_TYPE_MASK?
>>
> Okay i will do the same. Noted!
>> #ifdef __BIG_ENDIAN_BITFIELD
>> #define SKB_TSTAMP_TYPE_MASK    (3 << 6)
>> #define SKB_TSTAMP_TYPE_RSH    (6)    /* more on this later */
>> #else
>> #define SKB_TSTAMP_TYPE_MASK    (3)
>> #endif
>>
>>>>
>>> I was thinking to keep it as TAI because it will confuse developers. I hope thats okay.
>>
>> I think it is not very useful to distinguish each bit since it is an enum value now. It becomes more like the "pkt_type:3" and its PKT_TYPE_MAX.
>> I see what you are saying.
>>>>> +#define TC_AT_INGRESS_MASK        (1 << 5)
>>>>>   #else
>>>>>   #define SKB_MONO_DELIVERY_TIME_MASK    (1 << 0)
>>>>> -#define TC_AT_INGRESS_MASK        (1 << 1)
>>>>> +#define SKB_TAI_DELIVERY_TIME_MASK    (1 << 1)
>>>>> +#define TC_AT_INGRESS_MASK        (1 << 2)
>>>>>   #endif
>>>>>   #define SKB_BF_MONO_TC_OFFSET        offsetof(struct sk_buff, __mono_tc_offset)
>>>>>   @@ -4206,6 +4212,11 @@ static inline void skb_set_delivery_time(struct sk_buff *skb, ktime_t kt,
>>>>>       case CLOCK_MONOTONIC:
>>>>>           skb->tstamp_type = SKB_CLOCK_MONO;
>>>>>           break;
>>>>> +    case CLOCK_TAI:
>>>>> +        skb->tstamp_type = SKB_CLOCK_TAI;
>>>>> +        break;
>>>>> +    default:
>>>>> +        WARN_ONCE(true, "clockid %d not supported", tstamp_type);
>>>>
>>>> and set to 0 and default tstamp_type?
>>>> Actually thinking about it. I feel if its unsupported just fall back to default is the correct thing. I will take care of this.
>>>>>       }
>>>>>   }
>>>>
>>>>>   >
>>>>   @@ -9372,10 +9378,16 @@ static struct bpf_insn *bpf_convert_tstamp_type_read(const struct bpf_insn *si,
>>>>>       *insn++ = BPF_LDX_MEM(BPF_B, tmp_reg, skb_reg,
>>>>>                     SKB_BF_MONO_TC_OFFSET);
>>>>>       *insn++ = BPF_JMP32_IMM(BPF_JSET, tmp_reg,
>>>>> -                SKB_MONO_DELIVERY_TIME_MASK, 2);
>>>>> +                SKB_MONO_DELIVERY_TIME_MASK | SKB_TAI_DELIVERY_TIME_MASK, 2);
>>>>> +    *insn++ = BPF_JMP32_IMM(BPF_JSET, tmp_reg,
>>>>> +                SKB_MONO_DELIVERY_TIME_MASK, 3);
>>>>> +    *insn++ = BPF_JMP32_IMM(BPF_JSET, tmp_reg,
>>>>> +                SKB_TAI_DELIVERY_TIME_MASK, 4);
>>>>>       *insn++ = BPF_MOV32_IMM(value_reg, BPF_SKB_TSTAMP_UNSPEC);
>>>>>       *insn++ = BPF_JMP_A(1);
>>>>>       *insn++ = BPF_MOV32_IMM(value_reg, BPF_SKB_TSTAMP_DELIVERY_MONO);
>>>>> +    *insn++ = BPF_JMP_A(1);
>>>>> +    *insn++ = BPF_MOV32_IMM(value_reg, BPF_SKB_TSTAMP_DELIVERY_TAI);
>>
>> With SKB_TSTAMP_TYPE_MASK defined like above, this could be simplified like this (untested):
>>
> Let me think this through and raise it as part of the next rfc patch. 
>> static struct bpf_insn *bpf_convert_tstamp_type_read(const struct bpf_insn *si,
>>                                                      struct bpf_insn *insn)
>> {
>>     __u8 value_reg = si->dst_reg;
>>     __u8 skb_reg = si->src_reg;
>>
>>     BUILD_BUG_ON(__SKB_CLOCK_MAX != BPF_SKB_TSTAMP_DELIVERY_TAI);
>>     *insn++ = BPF_LDX_MEM(BPF_B, value_reg, skb_reg, SKB_BF_MONO_TC_OFFSET);
>>     *insn++ = BPF_ALU32_IMM(BPF_AND, value_reg, SKB_TSTAMP_TYPE_MASK);
>> #ifdef __BIG_ENDIAN_BITFIELD
>>     *insn++ = BPF_ALU32_IMM(BPF_RSH, value_reg, SKB_TSTAMP_TYPE_RSH);
>> #else
>>     BUILD_BUG_ON(!(SKB_TSTAMP_TYPE_MASK & 0x1));
>> #endif
>>
>>     return insn;
>> }
>>
>>>>>         return insn;
>>>>>   }
>>>>> @@ -9418,10 +9430,26 @@ static struct bpf_insn *bpf_convert_tstamp_read(const struct bpf_prog *prog,
>>>>>           __u8 tmp_reg = BPF_REG_AX;
>>>>>             *insn++ = BPF_LDX_MEM(BPF_B, tmp_reg, skb_reg, SKB_BF_MONO_TC_OFFSET);
>>>>> +        /*check if all three bits are set*/
>>>>>           *insn++ = BPF_ALU32_IMM(BPF_AND, tmp_reg,
>>>>> -                    TC_AT_INGRESS_MASK | SKB_MONO_DELIVERY_TIME_MASK);
>>>>> -        *insn++ = BPF_JMP32_IMM(BPF_JNE, tmp_reg,
>>>>> -                    TC_AT_INGRESS_MASK | SKB_MONO_DELIVERY_TIME_MASK, 2);
>>>>> +                    TC_AT_INGRESS_MASK | SKB_MONO_DELIVERY_TIME_MASK |
>>>>> +                    SKB_TAI_DELIVERY_TIME_MASK);
>>>>> +        /*if all 3 bits are set jump 3 instructions and clear the register */
>>>>> +        *insn++ = BPF_JMP32_IMM(BPF_JEQ, tmp_reg,
>>>>> +                    TC_AT_INGRESS_MASK | SKB_MONO_DELIVERY_TIME_MASK |
>>>>> +                    SKB_TAI_DELIVERY_TIME_MASK, 4);
>>>>> +        /*Now check Mono is set with ingress mask if so clear */
>>>>> +        *insn++ = BPF_JMP32_IMM(BPF_JEQ, tmp_reg,
>>>>> +                    TC_AT_INGRESS_MASK | SKB_MONO_DELIVERY_TIME_MASK, 3);
>>>>> +        /*Now Check tai is set with ingress mask if so clear */
>>>>> +        *insn++ = BPF_JMP32_IMM(BPF_JEQ, tmp_reg,
>>>>> +                    TC_AT_INGRESS_MASK | SKB_TAI_DELIVERY_TIME_MASK, 2);
>>>>> +        /*Now Check tai and mono are set if so clear */
>>>>> +        *insn++ = BPF_JMP32_IMM(BPF_JEQ, tmp_reg,
>>>>> +                    SKB_MONO_DELIVERY_TIME_MASK |
>>>>> +                    SKB_TAI_DELIVERY_TIME_MASK, 1);
>>
>> Same as the bpf_convert_tstamp_type_read, this could be simplified with SKB_TSTAMP_TYPE_MASK.
>>
Willem and Martin, 
When do we clear the tstamp and make it 0 in bpf_convert_tstamp_read? meaning which configuration?  
I see previously(current upstream code) if mono_delivery is set and tc_ingress_mask is set 
upstream code used to set the tstamp as 0. 

Which means with addition of tai mask the new implementation should take care of following cases(correct me if i am wrong)
1. ( tai mask set + ingress mask set ) = Clear tstamp 
2. ( mono mask set + ingress mask set ) = Clear tstamp 
3. ( mono mask set + tai mask set + ingress mask set ) = Clear tstamp
4. ( No mask set ) = Clear tstamp 
5. ( Tai mask set + mono mask set ) = Clear tstamp 

This leaves us with only two values which can be support which is 0x1 and 0x2 

This means the tstamp_type should be either 0x1(mono) and tstamp_type 0x2 (tai) to set the value_reg with tstamp 
Is my understanding correct ? 

Do you think the below simplified version looks okay ? 

static struct bpf_insn *bpf_convert_tstamp_read(const struct bpf_prog *prog,
						const struct bpf_insn *si,
						struct bpf_insn *insn)
{
	__u8 value_reg = si->dst_reg;
	__u8 skb_reg = si->src_reg;

BUILD_BUG_ON(__SKB_CLOCK_MAX != BPF_SKB_TSTAMP_DELIVERY_TAI);
#ifdef CONFIG_NET_XGRESS
	/* If the tstamp_type is read,
	 * the bpf prog is aware the tstamp could have delivery time.
	 * Thus, read skb->tstamp as is if tstamp_type_access is true.
	 */
	if (!prog->tstamp_type_access) {
		/* AX is needed because src_reg and dst_reg could be the same */
		__u8 tmp_reg = BPF_REG_AX;

		*insn++ = BPF_LDX_MEM(BPF_B, tmp_reg, skb_reg, SKB_BF_MONO_TC_OFFSET);
		/* check if all three bits are set*/
		*insn++ = BPF_ALU32_IMM(BPF_AND, tmp_reg,
					TC_AT_INGRESS_MASK | SKB_TSTAMP_TYPE_MASK);

		/* If the value of tmp_reg is 7,6,5,4,3,0 which means invalid
		 * configuration set the tstamp to 0, value 0x1 and 0x2
		 * is correct configuration
		 */
#ifdef __BIG_ENDIAN_BITFIELD 
		*insn++ = BPF_JMP32_IMM(BPF_JEQ, tmp_reg, 0x1 << SKB_TSTAMP_TYPE_RSH, 3);
		*insn++ = BPF_JMP32_IMM(BPF_JEQ, tmp_reg, 0x2 << SKB_TSTAMP_TYPE_RSH, 2);
#endif
		*insn++ = BPF_JMP32_IMM(BPF_JEQ, tmp_reg, 0x1, 3);
		*insn++ = BPF_JMP32_IMM(BPF_JEQ, tmp_reg, 0x2, 2);
#endif
		/* skb->tc_at_ingress && skb->tstamp_type:2,
		 * read 0 as the (rcv) timestamp.
		 */
		*insn++ = BPF_MOV64_IMM(value_reg, 0);
		*insn++ = BPF_JMP_A(1);
	}
#endif

	*insn++ = BPF_LDX_MEM(BPF_DW, value_reg, skb_reg,
			      offsetof(struct sk_buff, tstamp));
	return insn;
}


>>>>
>>>> This looks as if all JEQ result in "if so clear"?
>>>>
>>>> Is the goal to only do something different for the two bits being 0x1,
>>>> can we have a single test with a two-bit mask, rather than four tests?
>>>>
>>> I think Martin wanted to take care of TAI as well. I will wait for his comment here
>>>
>>> My Goal was to take care of invalid combos which does not hold valid
>>> 1. If all 3 bits are set => invalid combo (Test case written is Insane)
>>> 2. If 2 bits are set (tai+mono)(Test case written is Insane) => this cannot happen (because clock base can only be one in skb)
>>> 3. If 2 bit are set (ingress + tai/mono) => This is existing logic + tai being added (clear tstamp in ingress)
>>> 4. For all other cases go ahead and fill in the tstamp in the dest register.
>>
>> If it is to ensure no new type is added without adding BPF_SKB_TSTAMP_DELIVERY_XYZ, I would simplify this runtime bpf insns here and use a BUILD_BUG_ON to catch it at compile time. Something like,
>>
>> enum skb_tstamp_type {
>>         SKB_CLOCK_REAL, /* Time base is skb is REALTIME */
>>         SKB_CLOCK_MONO, /* Time base is skb is MONOTONIC */
>>      SKB_CLOCK_TAI,  /* Time base in skb is TAI */
>>         __SKB_CLOCK_MAX = SKB_CLOCK_TAI,
>> };
>>
>> /* Same one used in the bpf_convert_tstamp_type_read() above */
>> BUILD_BUG_ON(__SKB_CLOCK_MAX != BPF_SKB_TSTAMP_DELIVERY_TAI);
>>
>> Another thing is, the UDP test in test_tc_dtime.c probably needs to be adjusted, the userspace is using the CLOCK_TAI in SO_TXTIME and it is getting forwarded now.
> Noted ! Let me check and evalute this as well. 

