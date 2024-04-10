Return-Path: <bpf+bounces-26454-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 589E18A0145
	for <lists+bpf@lfdr.de>; Wed, 10 Apr 2024 22:25:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73DF01C240E2
	for <lists+bpf@lfdr.de>; Wed, 10 Apr 2024 20:25:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31A09181BB1;
	Wed, 10 Apr 2024 20:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="lBUfENUh"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DA52176FB8;
	Wed, 10 Apr 2024 20:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712780742; cv=none; b=WRE92vrCamjPFM3ynL4Cy99FfcSJpqHSRoPyOKw+koDLQyQ3Vo06NIfZq4gZ0xqP8y5+hMEQri+LukU+M7JG5U0lFpfNffrTLafirxSvPn955eGyP6mdYwWxDgVJ5HO1LnK1ZhcpxiAK2TSvD8fP0gvvtLzrqfaAC8osA6x00yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712780742; c=relaxed/simple;
	bh=u6DKXuFbPgR88LCvNoG0DSKe8rP0fHKl287uyv1IQbk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=HFxm8EYcmhya8qHVbIHMReLa4myvArvgsGN8AFBkBdlsH9j6pFIyPqPQQ2ItrCHp+KO3E6C791a3SR3Xwec1CHWVXo034hIwS5shCvzdVsNQhWtl6NywYzmEJrwovC+wlT9RRQAZFG/LRM7wbODKF8OJMHboYL+y3zK77HyzPik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=lBUfENUh; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43AJGYDu003626;
	Wed, 10 Apr 2024 20:25:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=jINjEjvSSP5bNK5P/FCApB46IDUURxWBAWQdLOFdDFo=; b=lB
	UfENUhcTD1XvWkvkGUriKWB/j7JkkijG58zOKajxsgBdYWz/KLzOab56Tg22cck2
	4mZajZAXKGj52uTGsQuTVtEufB45N/CUqk8v+AbPJ7m8ZCyUST9xrKoRz8KoN7CJ
	fSFiUGQnOk5I7oEhAqNUejHvJavk5QniuHoDhnZSJqltKYRz9SateIgWQLPjTcXK
	wAENjXQYOB6SLF3h7C1J5vePJzYNZX3MPMS5/32erbY8sUq0gn5wRwfcpRBa/4D4
	ZcFMQvi8iVSxRe2+2j9NAseMNnHhXJ/oa48x2H94BMdzfK8J0jGGuFEuQw4Z8c93
	0a2AcM587k/PMY8wAdMQ==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xdpnfu75f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Apr 2024 20:25:18 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43AKPG3V030773
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Apr 2024 20:25:16 GMT
Received: from [10.46.19.239] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 10 Apr
 2024 13:25:12 -0700
Message-ID: <f28de1e7-4a9b-4a97-b4f9-723425725b58@quicinc.com>
Date: Wed, 10 Apr 2024 13:25:12 -0700
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
References: <20240409210547.3815806-1-quic_abchauha@quicinc.com>
 <20240409210547.3815806-4-quic_abchauha@quicinc.com>
 <6616b3587520_2a98a5294db@willemb.c.googlers.com.notmuch>
From: "Abhishek Chauhan (ABC)" <quic_abchauha@quicinc.com>
In-Reply-To: <6616b3587520_2a98a5294db@willemb.c.googlers.com.notmuch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: ffz50uPFbL1gapGka2M94Qs9ik3DVJ7G
X-Proofpoint-ORIG-GUID: ffz50uPFbL1gapGka2M94Qs9ik3DVJ7G
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-10_05,2024-04-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 mlxlogscore=999 malwarescore=0 clxscore=1015 spamscore=0 adultscore=0
 lowpriorityscore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404100147



On 4/10/2024 8:42 AM, Willem de Bruijn wrote:
> Abhishek Chauhan wrote:
>> tstamp_type can be real, mono or userspace timestamp.
>>
>> This commit adds userspace timestamp and sets it if there is
>> valid transmit_time available in socket coming from userspace.
>>
>> To make the design scalable for future needs this commit bring in
>> the change to extend the tstamp_type:1 to tstamp_type:2 to support
>> userspace timestamp.
>>
>> Link: https://lore.kernel.org/netdev/bc037db4-58bb-4861-ac31-a361a93841d3@linux.dev/
>> Signed-off-by: Abhishek Chauhan <quic_abchauha@quicinc.com>
>> ---
>>  include/linux/skbuff.h | 19 +++++++++++++++++--
>>  net/ipv4/ip_output.c   |  2 +-
>>  net/ipv4/raw.c         |  2 +-
>>  net/ipv6/ip6_output.c  |  2 +-
>>  net/ipv6/raw.c         |  2 +-
>>  net/packet/af_packet.c |  6 +++---
>>  6 files changed, 24 insertions(+), 9 deletions(-)
>>
>> diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
>> index 6160185f0fe0..2f91a8a2157a 100644
>> --- a/include/linux/skbuff.h
>> +++ b/include/linux/skbuff.h
>> @@ -705,6 +705,9 @@ typedef unsigned char *sk_buff_data_t;
>>  enum skb_tstamp_type {
>>  	SKB_TSTAMP_TYPE_RX_REAL = 0,    /* A RX (receive) time in real */
>>  	SKB_TSTAMP_TYPE_TX_MONO = 1,    /* A TX (delivery) time in mono */
>> +	SKB_TSTAMP_TYPE_TX_USER = 2,    /* A TX (delivery) time and its clock
>> +									 * is in skb->sk->sk_clockid.
>> +									 */
> 
> Weird indentation?
> 
I will correct it. 

> More fundamentally: instead of defining a type TX_USER, can we use a
> real clockid (e.g., CLOCK_TAI) based on skb->sk->sk_clockid? Rather
> than store an id that means "go look at sk_clockid".
> 
>>  };
>>  
>>  /**
>> @@ -830,6 +833,9 @@ enum skb_tstamp_type {
>>   *		delivery_time in mono clock base (i.e. EDT).  Otherwise, the
>>   *		skb->tstamp has the (rcv) timestamp at ingress and
>>   *		delivery_time at egress.
>> + *		delivery_time in mono clock base (i.e., EDT) or a clock base chosen
>> + *		by SO_TXTIME. If zero, skb->tstamp has the (rcv) timestamp at
>> + *		ingress.
>>   *	@napi_id: id of the NAPI struct this skb came from
>>   *	@sender_cpu: (aka @napi_id) source CPU in XPS
>>   *	@alloc_cpu: CPU which did the skb allocation.
>> @@ -960,7 +966,7 @@ struct sk_buff {
>>  	/* private: */
>>  	__u8			__mono_tc_offset[0];
>>  	/* public: */
>> -	__u8			tstamp_type:1;	/* See SKB_MONO_DELIVERY_TIME_MASK */
>> +	__u8			tstamp_type:2;	/* See SKB_MONO_DELIVERY_TIME_MASK */
>>  #ifdef CONFIG_NET_XGRESS
>>  	__u8			tc_at_ingress:1;	/* See TC_AT_INGRESS_MASK */
>>  	__u8			tc_skip_classify:1;
> 
> With pahole, does this have an effect on sk_buff layout?
> 
I think it does and it also impacts BPF testing. Hence in my cover letter i have mentioned that these
changes will impact BPF. My level of expertise is very limited to BPF hence the reason for RFC. 
That being said i am actually trying to understand/learn BPF instructions to know things better. 
I think we need to also change the offset SKB_MONO_DELIVERY_TIME_MASK and TC_AT_INGRESS_MASK


#ifdef __BIG_ENDIAN_BITFIELD
#define SKB_MONO_DELIVERY_TIME_MASK	(1 << 7) //Suspecting changes here too
#define TC_AT_INGRESS_MASK		(1 << 6) // and here 
#else
#define SKB_MONO_DELIVERY_TIME_MASK	(1 << 0)
#define TC_AT_INGRESS_MASK		(1 << 1) (this might have to change to 1<<2 )
#endif
#define SKB_BF_MONO_TC_OFFSET		offsetof(struct sk_buff, __mono_tc_offset)

Also i suspect i change in /selftests/bpf/prog_tests/ctx_rewrite.c 
I am trying to figure out what this part of the code is doing.
https://lore.kernel.org/all/20230321014115.997841-4-kuba@kernel.org/

Please correct me if i am wrong here. 

>> @@ -4274,7 +4280,16 @@ static inline void skb_set_delivery_time(struct sk_buff *skb, ktime_t kt,
>>  					enum skb_tstamp_type tstamp_type)
>>  {
>>  	skb->tstamp = kt;
>> -	skb->tstamp_type = kt && tstamp_type;
>> +
>> +	if (skb->tstamp_type)
>> +		return;
>> +
> 
I can put a warn on here incase if both MONO and TAI are set. 
OR 
Rather make it simple as you have mentioned below. 
> Why bail if a type is already set? And what if
> skb->tstamp_type != tstamp_type? Should skb->tstamp then not be
> written to (i.e., the test moved up), and perhaps a rate limited
> warning.
> 
>> +	if (kt && tstamp_type == SKB_TSTAMP_TYPE_TX_MONO)
>> +		skb->tstamp_type = SKB_TSTAMP_TYPE_TX_MONO;
>> +
>> +	if (kt && tstamp_type == SKB_TSTAMP_TYPE_TX_USER)
>> +		skb->tstamp_type = SKB_TSTAMP_TYPE_TX_USER;
> 
> Simpler
> 
>     if (kt)
>         skb->tstamp_type = tstamp_type;


