Return-Path: <bpf+bounces-28721-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BB1EB8BD691
	for <lists+bpf@lfdr.de>; Mon,  6 May 2024 22:55:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42B001F22C22
	for <lists+bpf@lfdr.de>; Mon,  6 May 2024 20:55:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBB8215B969;
	Mon,  6 May 2024 20:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="NuakUEX4"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8544EBB;
	Mon,  6 May 2024 20:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715028920; cv=none; b=s302//mOCSsa4Ml5UuIttWUD2F6736H2/zN0GCWGtZ4gPZc+zz4mDCy1pu6gkziVPN3T9ffU8GKwnz4xgnv4WpHkc82tw1hvUW55sOP3lURFpOXTzFV4bp1c3uKp6aHeiknefvKwWzReD4IS33dw875vgdKuH0R5yyyx9ycFbHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715028920; c=relaxed/simple;
	bh=zsYXSqg2n/1ah/YTvjCN967/45hjqQPv1RO9SMjV/Eo=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:CC:References:
	 In-Reply-To:Content-Type; b=EOZ86QH/liKJUYbOcfarh9smKaV3WIGa9tmd0w6jHhp+yV1e/H2Ca/jQRMH6gcrfETgmp4Ee/1AEXbUujmcLdgGCzEsNOL0BCZLvt3855vu3pFf9t9cTRSODGU7gjVpgf6srsJ5Ae1OZKnXJVuvEJNdJol0tfIROl4csMorM1K4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=NuakUEX4; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 446JTpeM014613;
	Mon, 6 May 2024 20:54:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:from:to:cc:references
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=Kv69+7R48+QnbJhVNIvr/Qv61FV1e5Dtt9U1qxJx1JM=; b=Nu
	akUEX4bXE3DXP3Ui3F0C1lFoEpObzGYLLjTFx2RBEx7FFjv7j1tl7Si83aRPUQnD
	s9pRkrtHEVP8/T96bKDl0UTzdPgzExnTCSVExHLuKMjj+ymrasMeZahcL4WUM9Om
	yKoCOER7JwmyHFQSv7l0ICO+rles8J0W1BHji2ezBAlQQOEt/J6O6ZC35n1xqfEt
	aQjqCEISNfMN4Rq2oJvWHXgozNCsqEZoW9ktKk+PMPreHAmlMsnGA1IUhpVLBglE
	tnVHXlpmLaQkC4M9hlzy8SSyK11w54/iiiSGz6vGHiNxykR5p8nsYPA7B68K1t+Y
	miQGU3bQHBiAh0jLpnmQ==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xxuthhfr1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 May 2024 20:54:51 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 446Kso2X002955
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 6 May 2024 20:54:50 GMT
Received: from [10.46.19.239] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 6 May 2024
 13:54:47 -0700
Message-ID: <1480064d-1825-4438-9d30-bc47a694cc12@quicinc.com>
Date: Mon, 6 May 2024 13:54:47 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH bpf-next v6 3/3] selftests/bpf: Handle forwarding of
 UDP CLOCK_TAI packets
Content-Language: en-US
From: "Abhishek Chauhan (ABC)" <quic_abchauha@quicinc.com>
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
References: <20240504031331.2737365-1-quic_abchauha@quicinc.com>
 <20240504031331.2737365-4-quic_abchauha@quicinc.com>
 <663929b249143_516de2945@willemb.c.googlers.com.notmuch>
 <d613c5a6-5081-4760-8a86-db1107bdc207@quicinc.com>
In-Reply-To: <d613c5a6-5081-4760-8a86-db1107bdc207@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 6YSHPwehz8suafbnxX3Jd7NDxBQxowtR
X-Proofpoint-ORIG-GUID: 6YSHPwehz8suafbnxX3Jd7NDxBQxowtR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-06_15,2024-05-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 malwarescore=0
 adultscore=0 mlxscore=0 bulkscore=0 lowpriorityscore=0 impostorscore=0
 mlxlogscore=999 clxscore=1015 suspectscore=0 phishscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2405060151



On 5/6/2024 1:50 PM, Abhishek Chauhan (ABC) wrote:
> 
> 
> On 5/6/2024 12:04 PM, Willem de Bruijn wrote:
>> Abhishek Chauhan wrote:
>>> With changes in the design to forward CLOCK_TAI in the skbuff
>>> framework,  existing selftest framework needs modification
>>> to handle forwarding of UDP packets with CLOCK_TAI as clockid.
>>>
>>> Link: https://lore.kernel.org/netdev/bc037db4-58bb-4861-ac31-a361a93841d3@linux.dev/
>>> Signed-off-by: Abhishek Chauhan <quic_abchauha@quicinc.com>
>>> ---
>>>  tools/include/uapi/linux/bpf.h                | 15 ++++---
>>>  .../selftests/bpf/prog_tests/ctx_rewrite.c    | 10 +++--
>>>  .../selftests/bpf/prog_tests/tc_redirect.c    |  3 --
>>>  .../selftests/bpf/progs/test_tc_dtime.c       | 39 +++++++++----------
>>>  4 files changed, 34 insertions(+), 33 deletions(-)
>>>
>>> diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
>>> index 90706a47f6ff..25ea393cf084 100644
>>> --- a/tools/include/uapi/linux/bpf.h
>>> +++ b/tools/include/uapi/linux/bpf.h
>>> @@ -6207,12 +6207,17 @@ union {					\
>>>  	__u64 :64;			\
>>>  } __attribute__((aligned(8)))
>>>  
>>> +/* The enum used in skb->tstamp_type. It specifies the clock type
>>> + * of the time stored in the skb->tstamp.
>>> + */
>>>  enum {
>>> -	BPF_SKB_TSTAMP_UNSPEC,
>>> -	BPF_SKB_TSTAMP_DELIVERY_MONO,	/* tstamp has mono delivery time */
>>> -	/* For any BPF_SKB_TSTAMP_* that the bpf prog cannot handle,
>>> -	 * the bpf prog should handle it like BPF_SKB_TSTAMP_UNSPEC
>>> -	 * and try to deduce it by ingress, egress or skb->sk->sk_clockid.
>>> +	BPF_SKB_TSTAMP_UNSPEC = 0,		/* DEPRECATED */
>>> +	BPF_SKB_TSTAMP_DELIVERY_MONO = 1,	/* DEPRECATED */
>>> +	BPF_SKB_CLOCK_REALTIME = 0,
>>> +	BPF_SKB_CLOCK_MONOTONIC = 1,
>>> +	BPF_SKB_CLOCK_TAI = 2,
>>> +	/* For any future BPF_SKB_CLOCK_* that the bpf prog cannot handle,
>>> +	 * the bpf prog can try to deduce it by ingress/egress/skb->sk->sk_clockid.
>>>  	 */
>>>  };
>>>  
>>> diff --git a/tools/testing/selftests/bpf/prog_tests/ctx_rewrite.c b/tools/testing/selftests/bpf/prog_tests/ctx_rewrite.c
>>> index 3b7c57fe55a5..71940f4ef0fb 100644
>>> --- a/tools/testing/selftests/bpf/prog_tests/ctx_rewrite.c
>>> +++ b/tools/testing/selftests/bpf/prog_tests/ctx_rewrite.c
>>> @@ -69,15 +69,17 @@ static struct test_case test_cases[] = {
>>>  	{
>>>  		N(SCHED_CLS, struct __sk_buff, tstamp),
>>>  		.read  = "r11 = *(u8 *)($ctx + sk_buff::__mono_tc_offset);"
>>> -			 "w11 &= 3;"
>>> -			 "if w11 != 0x3 goto pc+2;"
>>> +			 "if w11 == 0x4 goto pc+1;"
>>> +			 "goto pc+4;"
>>> +			 "if w11 == 0x3 goto pc+1;"
>>> +			 "goto pc+2;"
>>
>> Not an expert on this code, and I see that the existing code already
>> has this below, but: isn't it odd and unnecessary to jump to an
>> unconditional jump statement?
>>
> I am closely looking into your comment and i will evalute it(Martin can correct me 
> if the jumps are correct or not as i am new to BPF as well) but i found out that 
> JSET = "&" and not "==". So the above two ins has to change from -   
> 
> "if w11 == 0x4 goto pc+1;" ==>(needs to be corrected to) "if w11 & 0x4 goto pc+1;" 
>  "if w11 == 0x3 goto pc+1;" ==> (needs to be correct to) "if w11 & 0x3 goto pc+1;"
> 
> 
>>>  			 "$dst = 0;"
>>>  			 "goto pc+1;"
>>>  			 "$dst = *(u64 *)($ctx + sk_buff::tstamp);",
>>>  		.write = "r11 = *(u8 *)($ctx + sk_buff::__mono_tc_offset);"
>>> -			 "if w11 & 0x2 goto pc+1;"
>>> +			 "if w11 & 0x4 goto pc+1;"
>>>  			 "goto pc+2;"
>>> -			 "w11 &= -2;"
>>> +			 "w11 &= -3;"
> Martin, 
> Also i am not sure why the the dissembly complains because the value of SKB_TSTAMP_TYPE_MASK = 3 and we are 
> negating it ~3 = -3. 
> 
>   Can't match disassembly(left) with pattern(right):
>   r11 = *(u8 *)(r1 +129)  ;  r11 = *(u8 *)($ctx + sk_buff::__mono_tc_offset)
>   if w11 & 0x4 goto pc+1  ;  if w11 & 0x4 goto pc+1
>   goto pc+2               ;  goto pc+2
>   w11 &= -4               ;  w11 &= -3
> 
Martin, 
Please ignore this. It has to -4 and not -3. I figured it out. 

>>>  			 "*(u8 *)($ctx + sk_buff::__mono_tc_offset) = r11;"
>>>  			 "*(u64 *)($ctx + sk_buff::tstamp) = $src;",
>>>  	},

