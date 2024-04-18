Return-Path: <bpf+bounces-27166-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B03CC8AA3E2
	for <lists+bpf@lfdr.de>; Thu, 18 Apr 2024 22:11:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D387A1C20C03
	for <lists+bpf@lfdr.de>; Thu, 18 Apr 2024 20:11:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56F71190690;
	Thu, 18 Apr 2024 20:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="kLbTVmQk"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED47E190678;
	Thu, 18 Apr 2024 20:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713471038; cv=none; b=kv8lzNKFdIRcJD7Ja7M0hKtltlb78LFFDbGYzLTaMgiJzEFgNSnbO+K0eXDMxGysXEVQyjPVi3Q6OF/d2cdlDwbQJej+J8j7oWDECe5RGETJGh+fcR8yp/Y8cuEYZmhaKtVuPmNfmD5pfOFD1BIQkLBSYSt1Yu2twj8OjWtW728=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713471038; c=relaxed/simple;
	bh=F84q09468QAuvyxXBUXYfaghdOKp4HFLLHGuiyrs3a0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=IYK1JAGPFCA5olkqlDrvRaflBHKrMGfwLtlUVdENniXIsZL1wFpyyW94Xah19hxmnmfwpXVUQq5/yIRihPXzd3OS5kC4AU/gqywNPu1E5rjdpj0LOYQxRnP/OSZMJufmZs/4vm3DbaTYyX0eK8vEcwEayfp0xA7TTcSSuEdI+uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=kLbTVmQk; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43IIIk8M021455;
	Thu, 18 Apr 2024 20:10:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=Z6VrvUaNnN1z7gpcFIt1Tmie9n0FAyRjnFpoT2QRMtE=; b=kL
	bTVmQkWedT59Qh4TJvZUzLEU8+rJO9Bty8idvYX5lP0lRgVoVDBi57mZM4n2BShO
	rGCqCPMx+bKmnMf6BzJlA9pgx2cjWVZPybQ8En9YakdvcRq/0bJnKfFkBM9QJFdG
	BoleIzc8JbMrFHCn7+HY363jjPohmBkAtyYsxyFZfakENjDVBdhbLXdBM82OAuic
	KU/bRG/29HCvq2IdpToNTS4iZD83/qEbzEKFmV9SW4XBeNUPGqCKej55GydINyRd
	pvCe/HOgmNxPifEJo73+3+61xUO4CfPuOlAU1ZLMOcTVtq9SEhaaNLxQo/K6Hmhi
	zDywzdZxOeL+GqJ93/iA==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xjx54hv3f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Apr 2024 20:10:14 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43IKAEUV026821
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Apr 2024 20:10:14 GMT
Received: from [10.110.72.56] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 18 Apr
 2024 13:10:09 -0700
Message-ID: <cb922600-783e-4741-be85-260d1ded5bdb@quicinc.com>
Date: Thu, 18 Apr 2024 13:10:08 -0700
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
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        "David S. Miller"
	<davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Andrew Halaney <ahalaney@redhat.com>,
        "Martin
 KaFai Lau" <martin.lau@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Daniel Borkmann <daniel@iogearbox.net>, bpf <bpf@vger.kernel.org>
CC: <kernel@quicinc.com>
References: <20240418004308.1009262-1-quic_abchauha@quicinc.com>
 <20240418004308.1009262-3-quic_abchauha@quicinc.com>
 <66216f3ec638b_f648a294ec@willemb.c.googlers.com.notmuch>
From: "Abhishek Chauhan (ABC)" <quic_abchauha@quicinc.com>
In-Reply-To: <66216f3ec638b_f648a294ec@willemb.c.googlers.com.notmuch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: cj0pgGtvGJm6HELW5bhHtjm9-_3lwLcI
X-Proofpoint-ORIG-GUID: cj0pgGtvGJm6HELW5bhHtjm9-_3lwLcI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-18_18,2024-04-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxscore=0
 suspectscore=0 malwarescore=0 phishscore=0 mlxlogscore=999 bulkscore=0
 impostorscore=0 spamscore=0 lowpriorityscore=0 priorityscore=1501
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404180146



On 4/18/2024 12:06 PM, Willem de Bruijn wrote:
> Abhishek Chauhan wrote:
>> tstamp_type is now set based on actual clockid_t compressed
>> into 2 bits.
>>
>> To make the design scalable for future needs this commit bring in
>> the change to extend the tstamp_type:1 to tstamp_type:2 to support
>> other clockid_t timestamp.
>>
>> We now support CLOCK_TAI as part of tstamp_type as part of this
>> commit with exisiting support CLOCK_MONOTONIC and CLOCK_REALTIME.
>>
>> Link: https://lore.kernel.org/netdev/bc037db4-58bb-4861-ac31-a361a93841d3@linux.dev/
>> Signed-off-by: Abhishek Chauhan <quic_abchauha@quicinc.com>
>>  
>>  /**
>> - * tstamp_type:1 can take 2 values each
>> + * tstamp_type:2 can take 4 values each
>>   * represented by time base in skb
>>   * 0x0 => real timestamp_type
>>   * 0x1 => mono timestamp_type
>> + * 0x2 => tai timestamp_type
>> + * 0x3 => undefined timestamp_type
> 
> Same point as previous patch about comment that repeats name.
> 
Will take care, Noted!
>> @@ -833,7 +836,8 @@ enum skb_tstamp_type {
>>   *	@tstamp_type: When set, skb->tstamp has the
>>   *		delivery_time in mono clock base (i.e. EDT).  Otherwise, the
>>   *		skb->tstamp has the (rcv) timestamp at ingress and
>> - *		delivery_time at egress.
>> + *		delivery_time at egress or skb->tstamp defined by skb->sk->sk_clockid
>> + *		coming from userspace
> 
> I would simplify the comment: clock base of skb->tstamp.
> Already in the first patch.
> 
Will take care, Noted!
>>   *	@napi_id: id of the NAPI struct this skb came from
>>   *	@sender_cpu: (aka @napi_id) source CPU in XPS
>>   *	@alloc_cpu: CPU which did the skb allocation.
>> @@ -961,7 +965,7 @@ struct sk_buff {
>>  	/* private: */
>>  	__u8			__mono_tc_offset[0];
>>  	/* public: */
>> -	__u8			tstamp_type:1;	/* See SKB_CLOCK_*_MASK */
>> +	__u8			tstamp_type:2;	/* See skb_tstamp_type enum */
> 
> Probably good to call out that according to pahole this fills a hole.
> 
I will do that . 
>>  #ifdef CONFIG_NET_XGRESS
>>  	__u8			tc_at_ingress:1;	/* See TC_AT_INGRESS_MASK */
>>  	__u8			tc_skip_classify:1;
>> @@ -1096,10 +1100,12 @@ struct sk_buff {
>>   */
>>  #ifdef __BIG_ENDIAN_BITFIELD
>>  #define SKB_MONO_DELIVERY_TIME_MASK	(1 << 7)
>> -#define TC_AT_INGRESS_MASK		(1 << 6)
>> +#define SKB_TAI_DELIVERY_TIME_MASK	(1 << 6)
> 
> SKB_TSTAMP_TYPE_BIT2_MASK?
> 
I was thinking to keep it as TAI because it will confuse developers. I hope thats okay. 
>> +#define TC_AT_INGRESS_MASK		(1 << 5)
>>  #else
>>  #define SKB_MONO_DELIVERY_TIME_MASK	(1 << 0)
>> -#define TC_AT_INGRESS_MASK		(1 << 1)
>> +#define SKB_TAI_DELIVERY_TIME_MASK	(1 << 1)
>> +#define TC_AT_INGRESS_MASK		(1 << 2)
>>  #endif
>>  #define SKB_BF_MONO_TC_OFFSET		offsetof(struct sk_buff, __mono_tc_offset)
>>  
>> @@ -4206,6 +4212,11 @@ static inline void skb_set_delivery_time(struct sk_buff *skb, ktime_t kt,
>>  	case CLOCK_MONOTONIC:
>>  		skb->tstamp_type = SKB_CLOCK_MONO;
>>  		break;
>> +	case CLOCK_TAI:
>> +		skb->tstamp_type = SKB_CLOCK_TAI;
>> +		break;
>> +	default:
>> +		WARN_ONCE(true, "clockid %d not supported", tstamp_type);
> 
> and set to 0 and default tstamp_type?
> Actually thinking about it. I feel if its unsupported just fall back to default is the correct thing. I will take care of this. 
>>  	}
>>  }
> 
>>  >
>  @@ -9372,10 +9378,16 @@ static struct bpf_insn *bpf_convert_tstamp_type_read(const struct bpf_insn *si,
>>  	*insn++ = BPF_LDX_MEM(BPF_B, tmp_reg, skb_reg,
>>  			      SKB_BF_MONO_TC_OFFSET);
>>  	*insn++ = BPF_JMP32_IMM(BPF_JSET, tmp_reg,
>> -				SKB_MONO_DELIVERY_TIME_MASK, 2);
>> +				SKB_MONO_DELIVERY_TIME_MASK | SKB_TAI_DELIVERY_TIME_MASK, 2);
>> +	*insn++ = BPF_JMP32_IMM(BPF_JSET, tmp_reg,
>> +				SKB_MONO_DELIVERY_TIME_MASK, 3);
>> +	*insn++ = BPF_JMP32_IMM(BPF_JSET, tmp_reg,
>> +				SKB_TAI_DELIVERY_TIME_MASK, 4);
>>  	*insn++ = BPF_MOV32_IMM(value_reg, BPF_SKB_TSTAMP_UNSPEC);
>>  	*insn++ = BPF_JMP_A(1);
>>  	*insn++ = BPF_MOV32_IMM(value_reg, BPF_SKB_TSTAMP_DELIVERY_MONO);
>> +	*insn++ = BPF_JMP_A(1);
>> +	*insn++ = BPF_MOV32_IMM(value_reg, BPF_SKB_TSTAMP_DELIVERY_TAI);
>>  
>>  	return insn;
>>  }
>> @@ -9418,10 +9430,26 @@ static struct bpf_insn *bpf_convert_tstamp_read(const struct bpf_prog *prog,
>>  		__u8 tmp_reg = BPF_REG_AX;
>>  
>>  		*insn++ = BPF_LDX_MEM(BPF_B, tmp_reg, skb_reg, SKB_BF_MONO_TC_OFFSET);
>> +		/*check if all three bits are set*/
>>  		*insn++ = BPF_ALU32_IMM(BPF_AND, tmp_reg,
>> -					TC_AT_INGRESS_MASK | SKB_MONO_DELIVERY_TIME_MASK);
>> -		*insn++ = BPF_JMP32_IMM(BPF_JNE, tmp_reg,
>> -					TC_AT_INGRESS_MASK | SKB_MONO_DELIVERY_TIME_MASK, 2);
>> +					TC_AT_INGRESS_MASK | SKB_MONO_DELIVERY_TIME_MASK |
>> +					SKB_TAI_DELIVERY_TIME_MASK);
>> +		/*if all 3 bits are set jump 3 instructions and clear the register */
>> +		*insn++ = BPF_JMP32_IMM(BPF_JEQ, tmp_reg,
>> +					TC_AT_INGRESS_MASK | SKB_MONO_DELIVERY_TIME_MASK |
>> +					SKB_TAI_DELIVERY_TIME_MASK, 4);
>> +		/*Now check Mono is set with ingress mask if so clear */
>> +		*insn++ = BPF_JMP32_IMM(BPF_JEQ, tmp_reg,
>> +					TC_AT_INGRESS_MASK | SKB_MONO_DELIVERY_TIME_MASK, 3);
>> +		/*Now Check tai is set with ingress mask if so clear */
>> +		*insn++ = BPF_JMP32_IMM(BPF_JEQ, tmp_reg,
>> +					TC_AT_INGRESS_MASK | SKB_TAI_DELIVERY_TIME_MASK, 2);
>> +		/*Now Check tai and mono are set if so clear */
>> +		*insn++ = BPF_JMP32_IMM(BPF_JEQ, tmp_reg,
>> +					SKB_MONO_DELIVERY_TIME_MASK |
>> +					SKB_TAI_DELIVERY_TIME_MASK, 1);
> 
> This looks as if all JEQ result in "if so clear"?
> 
> Is the goal to only do something different for the two bits being 0x1,
> can we have a single test with a two-bit mask, rather than four tests?
> 
I think Martin wanted to take care of TAI as well. I will wait for his comment here 

My Goal was to take care of invalid combos which does not hold valid
1. If all 3 bits are set => invalid combo (Test case written is Insane)
2. If 2 bits are set (tai+mono)(Test case written is Insane) => this cannot happen (because clock base can only be one in skb)
3. If 2 bit are set (ingress + tai/mono) => This is existing logic + tai being added (clear tstamp in ingress)
4. For all other cases go ahead and fill in the tstamp in the dest register. 

> 

