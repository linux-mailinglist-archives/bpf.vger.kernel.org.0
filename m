Return-Path: <bpf+bounces-26453-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A4F88A0053
	for <lists+bpf@lfdr.de>; Wed, 10 Apr 2024 21:07:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C5421C23192
	for <lists+bpf@lfdr.de>; Wed, 10 Apr 2024 19:07:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 309CD180A8D;
	Wed, 10 Apr 2024 19:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="jCA39fUC"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CA2B7460;
	Wed, 10 Apr 2024 19:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712776066; cv=none; b=mxXBWdjsdeCZ2v8oFDzT5I6kZCCd0cjp7Il/2GrfSlTplErzlYK3AUZUlIoNB7k4CJnfEXny+88z/wzI5L2oDBKM00Onkq91pcS92Ko0mQCmZ2rsYUlk98Ul/ohMOMZVq7+L9LIqYIimx2qdBZj98uEVEQghU8d6B+llhR5cKr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712776066; c=relaxed/simple;
	bh=OVRSpBkIl1y9Opvj2OA7aXUnrKiMuWoC9L9r8cY7FaY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=otuDsTw3M2k1u7nuKImfN+Nc8Qa6bigeZCPVKlbj1/ETNdnHs19p+FsAeKpVP9JR3upVCK2Tsx4B1gFlBGaSamzyD2Ppo0nwsDLVklT8VCxVXxvve8h0xb2pcENS6A7Tc+nlLGNbzsEjfq3KD1fXvuExmjcfCKJP3X3IVu5XRZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=jCA39fUC; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43AJ0HM6001428;
	Wed, 10 Apr 2024 19:07:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=PZ/Jcg0UvM09pjZy5iffqsji//dpbDI69OcR0FigxVI=; b=jC
	A39fUCDyc/iEuKH41z3JNWgMoKptUxVGXoAwY0wCfIYsQ5T7zLgvlLAYrP8gptPh
	SG2GgBJ0qVeoKXZsbxxBWRuu2GPwV3c+amh+Ryc7oZpcHIz0wdEer8ABPQ1pMDj8
	gq2RDCQPMUl7ZvuNqDmh7FMnCWbYcRgfCX27+CAaK5o3PRnXJEVWLb0I9yMW5ble
	RjQ2x2T2vVIGyk+eUS/hs2vRTjcYGEptjX4nHMytDrFEKjp1+x4J/Rt5ln6cKL5o
	uIculxhEwjz7eVmi2PxYxj9vFpF2Z/1A5wBIQ5yZQ2Dun6gd5Xj2LujYAb9gK98Q
	OwCHuNlaiuCu5KEhR/YA==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xdpnfu0n1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Apr 2024 19:07:24 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43AJ7MOY020552
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Apr 2024 19:07:23 GMT
Received: from [10.46.19.239] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 10 Apr
 2024 12:07:19 -0700
Message-ID: <fb705c02-0f4b-4879-8ae8-69048e14072f@quicinc.com>
Date: Wed, 10 Apr 2024 12:07:18 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH bpf-next v1 2/3] net: assign enum to skb->tstamp_type
 to distinguish between tstamp
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
 <20240409210547.3815806-3-quic_abchauha@quicinc.com>
 <6616b1ceeecad_2a98a529472@willemb.c.googlers.com.notmuch>
From: "Abhishek Chauhan (ABC)" <quic_abchauha@quicinc.com>
In-Reply-To: <6616b1ceeecad_2a98a529472@willemb.c.googlers.com.notmuch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: ann3hOHn-a19bKj71aC3r0m1mYg9OdAd
X-Proofpoint-ORIG-GUID: ann3hOHn-a19bKj71aC3r0m1mYg9OdAd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-10_04,2024-04-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 mlxlogscore=999 malwarescore=0 clxscore=1015 spamscore=0 adultscore=0
 lowpriorityscore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404100140



On 4/10/2024 8:35 AM, Willem de Bruijn wrote:
> Abhishek Chauhan wrote:
>> As we are renaming the mono_delivery_time to tstamp_type, it makes
>> sense to start assigning tstamp_type based out if enum defined as
>> part of this commit
>>
>> Earlier we used bool arg flag to check if the tstamp is mono in
>> function skb_set_delivery_time, Now the signature of the functions
>> accepts enum to distinguish between mono and real time.
>>
>> Link: https://lore.kernel.org/netdev/bc037db4-58bb-4861-ac31-a361a93841d3@linux.dev/
>> Signed-off-by: Abhishek Chauhan <quic_abchauha@quicinc.com>
>> ---
>>  include/linux/skbuff.h                     | 13 +++++++++----
>>  net/bridge/netfilter/nf_conntrack_bridge.c |  2 +-
>>  net/core/dev.c                             |  2 +-
>>  net/core/filter.c                          |  4 ++--
>>  net/ipv4/ip_output.c                       |  2 +-
>>  net/ipv4/tcp_output.c                      | 14 +++++++-------
>>  net/ipv6/ip6_output.c                      |  2 +-
>>  net/ipv6/tcp_ipv6.c                        |  2 +-
>>  net/sched/act_bpf.c                        |  2 +-
>>  net/sched/cls_bpf.c                        |  2 +-
>>  10 files changed, 25 insertions(+), 20 deletions(-)
>>
>> diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
>> index 8210d699d8e9..6160185f0fe0 100644
>> --- a/include/linux/skbuff.h
>> +++ b/include/linux/skbuff.h
>> @@ -701,6 +701,11 @@ typedef unsigned int sk_buff_data_t;
>>  #else
>>  typedef unsigned char *sk_buff_data_t;
>>  #endif
>> +
>>
>>
>> +enum skb_tstamp_type {
>> +	SKB_TSTAMP_TYPE_RX_REAL = 0,    /* A RX (receive) time in real */
>> +	SKB_TSTAMP_TYPE_TX_MONO = 1,    /* A TX (delivery) time in mono */
>> +};
> 
> I'd drop the RX_/TX_. This is just a version of clockid_t, compressed
> to minimize space taken in sk_buff. Simpler to keep to the CLOCK_..
> types. Where a clock was set (TX vs RX) is not relevant to the code
> that later references skb->tstamp.
> 
Make sense. tstamp can be either mono, real , tai ... etc . Directionality doesnt matter
Let me check this and update. 

>>  static inline void skb_set_delivery_time(struct sk_buff *skb, ktime_t kt,
>> -					 bool mono)
>> +					enum skb_tstamp_type tstamp_type)
>>  {
>>  	skb->tstamp = kt;
>> -	skb->tstamp_type = kt && mono;
>> +	skb->tstamp_type = kt && tstamp_type;
> 
> Already introduce a switch here?
> 
I will introduce a switch here based on tstamp_type passed. 

> 

