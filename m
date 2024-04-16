Return-Path: <bpf+bounces-27014-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AC5118A78C0
	for <lists+bpf@lfdr.de>; Wed, 17 Apr 2024 01:41:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 354F61F22631
	for <lists+bpf@lfdr.de>; Tue, 16 Apr 2024 23:41:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71C6613A898;
	Tue, 16 Apr 2024 23:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="OVOWgNkF"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 294F012E1CE;
	Tue, 16 Apr 2024 23:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713310874; cv=none; b=tVHnZSehwYK/iFwsQPkmC//c5rk6otYEGAmXLxSz4nUwwoN54l28hw4BCXxsVqrWG2bEHJrobrI/kdGLO6V5rvp3kae6gl3A33q0MlpdGwc5KvuXFCYPi5My86vZWBFC1m4cHV99fHp9vwUrhTPq8HyxB3Eu3O0G0YdAU4ft5JA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713310874; c=relaxed/simple;
	bh=bICZAsXgYGT5YWWOuMl10d7+YEs7h/CLvGEmAXXw3M8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=nDiIYgYMxMqZ1pVppOsJritE3BER+ea4PV8SGPXCDZVN0hqne7sYE2Mr8UhfvGMfBRq8HWG+XfsXOV3Y6GrL5LKd1JnmcLYFm9bD0FUaVhVkU2mORc4jLJ7VJucePbOAId4fcNbSq5Xj+aaMbSWlv68EAA7qi3JnxYTjLriNU8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=OVOWgNkF; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43GNBICL005996;
	Tue, 16 Apr 2024 23:40:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=of/cLQJhseuXknQ6XKSZPirrsTVR+NSnRl42Oh7x+68=; b=OV
	OWgNkF4DQ9h65JBh8VyMhobHYT1HdHJEbLyHsW44S/IsyZ59QMftya4nUgFtDd0z
	UmzNOMsB+Z+6g7re71Cke0jMSWF7z6oUsD4TxzpI27YWuPxbQHxUaOMCQa5n9nNO
	EA4cBWC3Hpaz04ymPBQs9tZvZ0Tl5v4s106pf02WtF2aubpLepDHfMOkg8eI46+k
	bmE3HggGYnRLguWoOvZ4TJoLvpGVM3bYp2xEb5fG7OGt3LCU4n90zSOGKI4M8U3Z
	G6NlJBFrdFaScYK0PJ2wCewB2rYtOBZM1gkD3WVvMvbEVitAEND9uE9CH66t2DEf
	EKL8VFU9Y3iUF4iY1IMg==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xhswvsvs4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Apr 2024 23:40:45 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43GNehnE017108
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Apr 2024 23:40:43 GMT
Received: from [10.110.24.237] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 16 Apr
 2024 16:40:39 -0700
Message-ID: <248cfe7f-cc29-4473-960f-0b036b43a52e@quicinc.com>
Date: Tue, 16 Apr 2024 16:40:38 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH bpf-next v3 2/2] net: Add additional bit to support
 userspace timestamp type
Content-Language: en-US
To: Martin KaFai Lau <martin.lau@linux.dev>,
        Willem de Bruijn
	<willemdebruijn.kernel@gmail.com>
CC: <kernel@quicinc.com>, "David S. Miller" <davem@davemloft.net>,
        "Eric
 Dumazet" <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Andrew Halaney <ahalaney@redhat.com>,
        "Martin
 KaFai Lau" <martin.lau@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, bpf <bpf@vger.kernel.org>
References: <20240412210125.1780574-1-quic_abchauha@quicinc.com>
 <20240412210125.1780574-3-quic_abchauha@quicinc.com>
 <661ad7d4c65da_3be9a7294e@willemb.c.googlers.com.notmuch>
 <617e2577-8de2-4fde-bbfe-2d6280c48c29@linux.dev>
From: "Abhishek Chauhan (ABC)" <quic_abchauha@quicinc.com>
In-Reply-To: <617e2577-8de2-4fde-bbfe-2d6280c48c29@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: yuMeAIjQjXmhhvEyVuLphiAIzj8JDkiz
X-Proofpoint-ORIG-GUID: yuMeAIjQjXmhhvEyVuLphiAIzj8JDkiz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-16_18,2024-04-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 priorityscore=1501 spamscore=0 impostorscore=0 bulkscore=0 adultscore=0
 lowpriorityscore=0 malwarescore=0 clxscore=1015 suspectscore=0 mlxscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404160155



On 4/15/2024 1:00 PM, Martin KaFai Lau wrote:
> On 4/13/24 12:07 PM, Willem de Bruijn wrote:
>>> diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
>>> index a83a2120b57f..b6346c21c3d4 100644
>>> --- a/include/linux/skbuff.h
>>> +++ b/include/linux/skbuff.h
>>> @@ -827,7 +827,8 @@ enum skb_tstamp_type {
>>>    *    @tstamp_type: When set, skb->tstamp has the
>>>    *        delivery_time in mono clock base (i.e. EDT).  Otherwise, the
>>>    *        skb->tstamp has the (rcv) timestamp at ingress and
>>> - *        delivery_time at egress.
>>> + *        delivery_time at egress or skb->tstamp defined by skb->sk->sk_clockid
>>> + *        coming from userspace
>>>    *    @napi_id: id of the NAPI struct this skb came from
>>>    *    @sender_cpu: (aka @napi_id) source CPU in XPS
>>>    *    @alloc_cpu: CPU which did the skb allocation.
>>> @@ -955,7 +956,7 @@ struct sk_buff {
>>>       /* private: */
>>>       __u8            __mono_tc_offset[0];
>>>       /* public: */
>>> -    __u8            tstamp_type:1;    /* See SKB_MONO_DELIVERY_TIME_MASK */
>>> +    __u8            tstamp_type:2;    /* See SKB_MONO_DELIVERY_TIME_MASK */
>>>   #ifdef CONFIG_NET_XGRESS
>>>       __u8            tc_at_ingress:1;    /* See TC_AT_INGRESS_MASK */
>>>       __u8            tc_skip_classify:1;
>>
>> A quick pahole for a fairly standard .config that I had laying around
>> shows a hole after this list of bits, so no huge concerns there from
>> adding a bit:
>>
>>             __u8               slow_gro:1;           /*     3: 4  1 */
>>             __u8               csum_not_inet:1;      /*     3: 5  1 */
>>
>>             /* XXX 2 bits hole, try to pack */
>>
>>             __u16              tc_index;             /*     4     2 */
>>
>>> @@ -1090,10 +1091,10 @@ struct sk_buff {
>>>    */
>>>   #ifdef __BIG_ENDIAN_BITFIELD
>>>   #define SKB_MONO_DELIVERY_TIME_MASK    (1 << 7)
>>> -#define TC_AT_INGRESS_MASK        (1 << 6)
>>> +#define TC_AT_INGRESS_MASK        (1 << 5)
>>
>> Have to be careful when adding a new 2 bit tstamp_type with both bits
>> set, that this does not incorrectly get interpreted as MONO.
>>
>> I haven't looked closely at the BPF API, but hopefully it can be
>> extensible to return the specific type. If it is hardcoded to return
>> either MONO or not, then only 0x1 should match, not 0x3.
> 
> Good point. I believe it is the best to have bpf to consider both bits in tstamp_type:2 in filter.c to avoid the 0x3 surprise in the future. The BPF API can be extended to support SKB_CLOCK_TAI.
> 
> Regardless, in bpf_convert_tstamp_write(), it still needs to clear both bits in tstamp_type when it is at ingress. Right now it only clears the mono bit.
> 
> Then it may as well consider both tstamp_type:2 bits in bpf_convert_tstamp_read() and bpf_convert_tstamp_type_read(). e.g. bpf_convert_tstamp_type_read(), it should be a pretty straight forward change because the SKB_CLOCK_* enum value should be a 1:1 mapping to the BPF_SKB_TSTAMP_*.
> 
>>
>>>   #else
>>>   #define SKB_MONO_DELIVERY_TIME_MASK    (1 << 0)
>>> -#define TC_AT_INGRESS_MASK        (1 << 1)
>>> +#define TC_AT_INGRESS_MASK        (1 << 2)
>>>   #endif
>>>   #define SKB_BF_MONO_TC_OFFSET        offsetof(struct sk_buff, __mono_tc_offset)
>>>   
> 
Hi Martin and Willem,

I have made the changes as per your guidelines . I will be raising RFC patch bpf-next v4 soon. Giving you heads up of the changes i am bringing in the BPF code. If you feel i have done something incorrectly, please do correct me here.  
I apologies for adding the code here and making the content of the email huge for other upstream reviewers. 

//Introduce a new BPF tstamp type mask in bpf.h 

#ifdef __BIG_ENDIAN_BITFIELD
#define SKB_MONO_DELIVERY_TIME_MASK	(1 << 7)
+ #define SKB_TAI_DELIVERY_TIME_MASK	(1 << 6) (new)
#define TC_AT_INGRESS_MASK		(1 << 5)
#else
#define SKB_MONO_DELIVERY_TIME_MASK	(1 << 0)
+ #define SKB_TAI_DELIVERY_TIME_MASK	(1 << 1) (new)
#define TC_AT_INGRESS_MASK		(1 << 2)
#endif

//changes in the filter.c (bpf_convert_tstamp_{read,write}, bpf_convert_tstamp_type_read())code are accordingly taken care since now we have 3 bits instead of 2 

Value 3 => unspec
Value 2 => tai 
Value 1 => mono

static struct bpf_insn *bpf_convert_tstamp_type_read(const struct bpf_insn *si,
						     struct bpf_insn *insn)
{
	__u8 value_reg = si->dst_reg;
	__u8 skb_reg = si->src_reg;
	/* AX is needed because src_reg and dst_reg could be the same */
	__u8 tmp_reg = BPF_REG_AX;

	*insn++ = BPF_LDX_MEM(BPF_B, tmp_reg, skb_reg,
			      SKB_BF_MONO_TC_OFFSET);
	*insn++ = BPF_JMP32_IMM(BPF_JSET, tmp_reg,
				SKB_MONO_DELIVERY_TIME_MASK | SKB_TAI_DELIVERY_TIME_MASK, 2); <== check for both bits are set (if so make it tstamp_unspec)
	*insn++ = BPF_JMP32_IMM(BPF_JSET, tmp_reg, 
				SKB_MONO_DELIVERY_TIME_MASK, 3); <== if mono is set then its mono base and jump to 3rd instruction from here.  
	*insn++ = BPF_JMP32_IMM(BPF_JSET, tmp_reg,
				SKB_TAI_DELIVERY_TIME_MASK, 4); <== if tai is set then its tai base and jump to 4th instruction from here. 
	*insn++ = BPF_MOV32_IMM(value_reg, BPF_SKB_TSTAMP_UNSPEC);
	*insn++ = BPF_JMP_A(1);
	*insn++ = BPF_MOV32_IMM(value_reg, BPF_SKB_TSTAMP_DELIVERY_MONO);
	*insn++ = BPF_JMP_A(1);
	*insn++ = BPF_MOV32_IMM(value_reg, BPF_SKB_TSTAMP_DELIVERY_TAI);

	return insn;
}

//Values 7, 6 and 5 as input will set the value reg to 0 
//otherwise the skb_reg has correct configuration and will store the content in value reg. 
                 
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
		/*check if all three bits are set*/
		*insn++ = BPF_ALU32_IMM(BPF_AND, tmp_reg,
					TC_AT_INGRESS_MASK | SKB_MONO_DELIVERY_TIME_MASK |
					SKB_TAI_DELIVERY_TIME_MASK);  <== check if all 3 bits are set which is value 7 
		/*if all 3 bits are set jump 3 instructions and clear the register */
		*insn++ = BPF_JMP32_IMM(BPF_JEQ, tmp_reg,
					TC_AT_INGRESS_MASK | SKB_MONO_DELIVERY_TIME_MASK | 
					SKB_TAI_DELIVERY_TIME_MASK, 4); <== if all 3 bits are set then value reg is set to 0 
		/*Now check Mono is set with ingress mask if so clear*/
		*insn++ = BPF_JMP32_IMM(BPF_JEQ, tmp_reg,
					TC_AT_INGRESS_MASK | SKB_MONO_DELIVERY_TIME_MASK, 3); <== check if value is 5 (mono + ingress) if so then value reg is set to 0 
		/*Now Check tai is set with ingress mask if so clear*/
		*insn++ = BPF_JMP32_IMM(BPF_JEQ, tmp_reg,
					TC_AT_INGRESS_MASK | SKB_TAI_DELIVERY_TIME_MASK, 2); <== check if value is 6 (tai + ingress) if so then value reg is set to 0 
		/*Now Check tai and mono are set if so clear */
		*insn++ = BPF_JMP32_IMM(BPF_JEQ, tmp_reg,
					SKB_MONO_DELIVERY_TIME_MASK | SKB_TAI_DELIVERY_TIME_MASK, 1); <== check if value 3 (tai + mono) if so then value reg is set to 0
		/* goto <store> */
		*insn++ = BPF_JMP_A(2);
		/* skb->tc_at_ingress && skb->tstamp_type:1,
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

//this was pretty straight forward 
//if ingress mask is set just go ahead and unset both tai and mono delivery time. 

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
		*insn++ = BPF_JMP_A(3);
		/* <clear>: mono_delivery_time or (skb->tstamp_type:1) */
		*insn++ = BPF_ALU32_IMM(BPF_AND, tmp_reg, ~SKB_MONO_DELIVERY_TIME_MASK);
		/* <clear>: tai delivery_time or (skb->tstamp_type:2) */ (new)
		*insn++ = BPF_ALU32_IMM(BPF_AND, tmp_reg, ~SKB_TAI_DELIVERY_TIME_MASK); (new) <== reset tai delivery mask if ingress bit is set. 
		*insn++ = BPF_STX_MEM(BPF_B, skb_reg, tmp_reg, SKB_BF_MONO_TC_OFFSET); 
	}
#endif

	/* <store>: skb->tstamp = tstamp */
	*insn++ = BPF_RAW_INSN(BPF_CLASS(si->code) | BPF_DW | BPF_MEM,
			       skb_reg, value_reg, offsetof(struct sk_buff, tstamp), si->imm);
	return insn;


And the ctx_rewrite will be as follows 

		.read  = "r11 = *(u8 *)($ctx + sk_buff::__mono_tc_offset);"
			 "w11 &= 7;"
			 "if w11 == 0x7 goto pc+4;"
			 "if w11 == 0x5 goto pc+3;"
			 "if w11 == 0x6 goto pc+2;"
			 "if w11 == 0x3 goto pc+1;"
			 "goto pc+2"
			 "$dst = 0;"
			 "goto pc+1;"
			 "$dst = *(u64 *)($ctx + sk_buff::tstamp);",
		.write = "r11 = *(u8 *)($ctx + sk_buff::__mono_tc_offset);"
			 "if w11 & 0x4 goto pc+1;"
			 "goto pc+3;"
			 "w11 &= -2;"
			 "w11 &= -3;"
			 "*(u8 *)($ctx + sk_buff::__mono_tc_offset) = r11;"
			 "*(u64 *)($ctx + sk_buff::tstamp) = $src;",

