Return-Path: <bpf+bounces-26672-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ED6D8A37B8
	for <lists+bpf@lfdr.de>; Fri, 12 Apr 2024 23:15:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C27421C216AF
	for <lists+bpf@lfdr.de>; Fri, 12 Apr 2024 21:15:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2058F1509B8;
	Fri, 12 Apr 2024 21:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="BCfS9slo"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31085249E8;
	Fri, 12 Apr 2024 21:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712956526; cv=none; b=ZJ9U9rbep7unGYRXdscUzXQoddavKkPsO1g4yPz7H878/D5Au7cKBArJ5vML1r1dnvFd7Aqry6lALcaOnnnHD7rFYZ7nAmQJ5AwnsEgOc4Q+y6Fenj2SmXZsi5K2IKJXjkEwXHqZvHgm/q6NyAGAfEF+mv/KSAvuKQ0mr7VO5po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712956526; c=relaxed/simple;
	bh=HjTZA9cux1BkDiz0t8NTsvUvXMtenUhHKaPG79+snsM=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:CC:References:
	 In-Reply-To:Content-Type; b=MZ4FLvauhY3ffHHwUTpIHqNzd6cx/hCItrpjEDd2nf6Un9dFCPmwrHNISjDYzkl2YZRIZUlvBR6f72oiKWBZ1+ZOOWTVCkydw+YsQY+HnkQoT7VzFClMqVl3QlsrP8LP52OiMU7Ri7cws/XBldzvIFzeJ/9SpgAPWgG8QuXdHFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=BCfS9slo; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43CKef48005887;
	Fri, 12 Apr 2024 21:14:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:from:to:cc:references
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=MdhezSHgd1h2H9jE2kPe/W4V4Gl6gWIHPcj0TElSSxU=; b=BC
	fS9sloGqPmi0wpsWb1FIygWIiyj4fH47uVyYZOfzgr/c7VYH9D74hxuaX4cnw4VP
	bQWLtfQdbLyuoRnwpwezG8YvfP3eDx1fdnynaFrg2I4N26KEwzGCxzvRauCyGmN+
	gcZP49jSXBYfhVYjE7yBqxJwMeMVdC0/lLUUf3CnSiRWazVSK2TEdge6hV7YHnKE
	zuwYd8v14aMynXzixP5npb2tYDQCnvywSTlYzMC2vFPdB8Rbzd60D7K+FDvwRUy+
	qigI69/4vYkxXPqCfF0uo4Jctu7fSRtHqbLwetHOjmqlx1zHmFbm0PQGqzmAK5jn
	4R/kTbSkWtBfCHiZlp/w==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xf6khs612-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Apr 2024 21:14:57 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43CLEudS020045
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Apr 2024 21:14:56 GMT
Received: from [10.46.19.239] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 12 Apr
 2024 14:14:52 -0700
Message-ID: <03581ae6-15a2-41a7-9619-74797ebec105@quicinc.com>
Date: Fri, 12 Apr 2024 14:14:51 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH bpf-next v1 3/3] net: Add additional bit to support
 userspace timestamp type
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
References: <20240409210547.3815806-1-quic_abchauha@quicinc.com>
 <20240409210547.3815806-4-quic_abchauha@quicinc.com>
 <6616b3587520_2a98a5294db@willemb.c.googlers.com.notmuch>
 <f28de1e7-4a9b-4a97-b4f9-723425725b58@quicinc.com>
 <fcdf6dc6-81ff-48b8-822b-80c097efc07d@linux.dev>
 <ab91c5d7-d968-4d57-9412-e8684c9a4cc6@quicinc.com>
In-Reply-To: <ab91c5d7-d968-4d57-9412-e8684c9a4cc6@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 8vvQ081teDfzk6LN3uisyM6QpJZQM72C
X-Proofpoint-GUID: 8vvQ081teDfzk6LN3uisyM6QpJZQM72C
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-12_17,2024-04-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 mlxscore=0
 priorityscore=1501 malwarescore=0 phishscore=0 lowpriorityscore=0
 adultscore=0 mlxlogscore=999 bulkscore=0 clxscore=1015 impostorscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404120152



On 4/10/2024 4:39 PM, Abhishek Chauhan (ABC) wrote:
> 
> 
> On 4/10/2024 4:25 PM, Martin KaFai Lau wrote:
>> On 4/10/24 1:25 PM, Abhishek Chauhan (ABC) wrote:
>>>>> @@ -830,6 +833,9 @@ enum skb_tstamp_type {
>>>>>    *        delivery_time in mono clock base (i.e. EDT).  Otherwise, the
>>>>>    *        skb->tstamp has the (rcv) timestamp at ingress and
>>>>>    *        delivery_time at egress.
>>>>> + *        delivery_time in mono clock base (i.e., EDT) or a clock base chosen
>>>>> + *        by SO_TXTIME. If zero, skb->tstamp has the (rcv) timestamp at
>>>>> + *        ingress.
>>>>>    *    @napi_id: id of the NAPI struct this skb came from
>>>>>    *    @sender_cpu: (aka @napi_id) source CPU in XPS
>>>>>    *    @alloc_cpu: CPU which did the skb allocation.
>>>>> @@ -960,7 +966,7 @@ struct sk_buff {
>>>>>       /* private: */
>>>>>       __u8            __mono_tc_offset[0];
>>>>>       /* public: */
>>>>> -    __u8            tstamp_type:1;    /* See SKB_MONO_DELIVERY_TIME_MASK */
>>>>> +    __u8            tstamp_type:2;    /* See SKB_MONO_DELIVERY_TIME_MASK */
>>>>>   #ifdef CONFIG_NET_XGRESS
>>>>>       __u8            tc_at_ingress:1;    /* See TC_AT_INGRESS_MASK */
>>
>> The above "tstamp_type:2" change shifted the tc_at_ingress bit.
>> TC_AT_INGRESS_MASK needs to be adjusted.
>>
>>>>>       __u8            tc_skip_classify:1;
>>>>
>>>> With pahole, does this have an effect on sk_buff layout?
>>>>
>>> I think it does and it also impacts BPF testing. Hence in my cover letter i have mentioned that these
>>> changes will impact BPF. My level of expertise is very limited to BPF hence the reason for RFC.
>>> That being said i am actually trying to understand/learn BPF instructions to know things better.
>>> I think we need to also change the offset SKB_MONO_DELIVERY_TIME_MASK and TC_AT_INGRESS_MASK
>>>
>>>
>>> #ifdef __BIG_ENDIAN_BITFIELD
>>> #define SKB_MONO_DELIVERY_TIME_MASK    (1 << 7) //Suspecting changes here too
>>> #define TC_AT_INGRESS_MASK        (1 << 6) // and here
>>> #else
>>> #define SKB_MONO_DELIVERY_TIME_MASK    (1 << 0)
>>> #define TC_AT_INGRESS_MASK        (1 << 1) (this might have to change to 1<<2 )
>>
>> This should be (1 << 2) now. Similar adjustment for the big endian.
>>
>>> #endif
>>> #define SKB_BF_MONO_TC_OFFSET        offsetof(struct sk_buff, __mono_tc_offset)
>>>
>>> Also i suspect i change in /selftests/bpf/prog_tests/ctx_rewrite.c
>>
>> ctx_rewrite.c tests the bpf ctx rewrite code. In this particular case, it tests
>> the bpf_convert_tstamp_read() and bpf_convert_tstamp_write() generate the
>> correct bpf instructions.
>> e.g. "w11 &= 3;" is testing the following in bpf_convert_tstamp_read():
>>         *insn++ = BPF_ALU32_IMM(BPF_AND, tmp_reg,
>>                      TC_AT_INGRESS_MASK | SKB_MONO_DELIVERY_TIME_MASK);
>>
>> The existing "TC_AT_INGRESS_MASK | SKB_MONO_DELIVERY_TIME_MASK" is 0x3
>> and it should become 0x5 if my hand counts correctly.
>>
> 
> so the changes will be as follows (Martin correct me if am wrong)
> 
> 		//w11 is checked againt 0x5 (Binary = 101)
> 		N(SCHED_CLS, struct __sk_buff, tstamp),
> 		.read  = "r11 = *(u8 *)($ctx + sk_buff::__mono_tc_offset);"
> 			 "w11 &= 5;" <== here 
> 			 "if w11 != 0x5  goto pc+2;" <==here
> 			 "$dst = 0;"
> 			 "goto pc+1;"
> 			 "$dst = *(u64 *)($ctx + sk_buff::tstamp);",
> 
> 		//w11 is checked againt 0x4 (100) 
> 		.write = "r11 = *(u8 *)($ctx + sk_buff::__mono_tc_offset);"
> 			 "if w11 & 0x4 goto pc+1;" <== here
> 			 "goto pc+2;"
> 			 "w11 &= -4;" <==here
> 			 "*(u8 *)($ctx + sk_buff::__mono_tc_offset) = r11;"
> 			 "*(u64 *)($ctx + sk_buff::tstamp) = $src;",
> 
>
Martin and Willem,
After the above changes, patchset v3 of these changes passed BPF test cases . Looks like we are good to go with final review now. If you have any further comments
Thank you for all the comments and design discussion that we had as part of this patch set series. 

Testing :- 
1. https://patchwork.kernel.org/project/netdevbpf/patch/20240412210125.1780574-2-quic_abchauha@quicinc.com/
2. https://patchwork.kernel.org/project/netdevbpf/patch/20240412210125.1780574-3-quic_abchauha@quicinc.com/
 
>> The patch set cannot be applied to the bpf-next:
>> https://patchwork.kernel.org/project/netdevbpf/patch/20240409210547.3815806-4-quic_abchauha@quicinc.com/
>> , so bpf CI cannot run to reproduce the issue.
>>

