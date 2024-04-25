Return-Path: <bpf+bounces-27851-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DEAD18B28D7
	for <lists+bpf@lfdr.de>; Thu, 25 Apr 2024 21:13:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96D14284F4F
	for <lists+bpf@lfdr.de>; Thu, 25 Apr 2024 19:13:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 970F11514FF;
	Thu, 25 Apr 2024 19:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="klBBUnKM"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A53D1149E0A;
	Thu, 25 Apr 2024 19:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714072405; cv=none; b=OH4itRXSKdO5kTgXj8tnCQfFUO41UNrNAqsF+t2W/6bDdwNTm30hQRKxohn6oFFFl7z591vFPwM7Rym4ZfLVHQCinAbGgmR8vYhNKTyQQ6gmX4XMWz1Lr6R9H3Sd4diUgjLjb3S0yaohxA6Y2DqJ8Ep/cw/3XK2Tq7a/k1QFSPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714072405; c=relaxed/simple;
	bh=ZfmeYQkdz4pqX40RCWQIxQEoJzdI8OcUQe8qNHlrkrQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=UJWErnSReyBfb/48pYwQE6uy8P346bHI4zF2wY+ALG/C3CUCrIB5lys6/l5rBZYJPow9NpIqVWo31MMjzkbtcwfT7kukGSPI9tJ4fmSMfO9gjBa8YzELyg6PiM9hfTeD6xcRwIA3NMe0nFnNWZ1nV3huLSyIOvCK6TlTXZDdIO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=klBBUnKM; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43PEPg6H014184;
	Thu, 25 Apr 2024 19:12:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=RYsoHTH1ui6IQhPYrmkWf3V3oM1DczC+i9q4NrDz1dE=; b=kl
	BBUnKMyVxlmRxyJ3k/ohDJIq3V1e0IJ8OXpDkllIdrhNrj3TiSRBdhHHBqGHYBCE
	BbIMJwszn1mn75xHsu5gmKIZrd5UdX+yGm0X1a+0I2d7V5z77AltsskWwGrix2di
	vSuq+PebEkf9Kd1uUkc5xsUDD6GBqy1cZvG090IidK9SBNZfWT00PeiHy9keU2Lq
	u+mvnL0lR+4BUvfy4ntfEzqQvw3bdeCRwH1lYWMxi/mmkbBr5sMYfo9NaAS5Y/C8
	rqPvaUSAQxDypS/gTG8rsxDRd49yTHm3pi2mCUpQwuQ6sCP3R28nUPeOxJft2eab
	0bV4FmLQDpz1rz1OoN1A==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xqrwwrpdp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Apr 2024 19:12:58 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43PJCv3N016396
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Apr 2024 19:12:57 GMT
Received: from [10.46.19.239] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 25 Apr
 2024 12:12:53 -0700
Message-ID: <76cc402a-9513-433f-b40b-f3ae93c6d65f@quicinc.com>
Date: Thu, 25 Apr 2024 12:12:52 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH bpf-next v5 2/2] net: Add additional bit to support
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
References: <20240424222028.1080134-1-quic_abchauha@quicinc.com>
 <20240424222028.1080134-3-quic_abchauha@quicinc.com>
 <662a6be8aed1a_1de39b2946c@willemb.c.googlers.com.notmuch>
From: "Abhishek Chauhan (ABC)" <quic_abchauha@quicinc.com>
In-Reply-To: <662a6be8aed1a_1de39b2946c@willemb.c.googlers.com.notmuch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: ZmBQSq31OOhXWknDvtwH9ICT9aW7HGJ8
X-Proofpoint-ORIG-GUID: ZmBQSq31OOhXWknDvtwH9ICT9aW7HGJ8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-25_19,2024-04-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1015
 mlxscore=0 impostorscore=0 lowpriorityscore=0 malwarescore=0
 suspectscore=0 adultscore=0 priorityscore=1501 phishscore=0
 mlxlogscore=999 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2404010003 definitions=main-2404250138



On 4/25/2024 7:42 AM, Willem de Bruijn wrote:
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
>> ---
> 
>> diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
>> index e464d0ebc9c1..3ad0de07d261 100644
>> --- a/include/linux/skbuff.h
>> +++ b/include/linux/skbuff.h
>> @@ -711,6 +711,8 @@ typedef unsigned char *sk_buff_data_t;
>>  enum skb_tstamp_type {
>>  	SKB_CLOCK_REALTIME,
>>  	SKB_CLOCK_MONOTONIC,
>> +	SKB_CLOCK_TAI,
>> +	__SKB_CLOCK_MAX = SKB_CLOCK_TAI,
>>  };
>>  
>>  /**
>> @@ -831,8 +833,8 @@ enum skb_tstamp_type {
>>   *	@decrypted: Decrypted SKB
>>   *	@slow_gro: state present at GRO time, slower prepare step required
>>   *	@tstamp_type: When set, skb->tstamp has the
>> - *		delivery_time in mono clock base Otherwise, the
>> - *		timestamp is considered real clock base.
>> + *		delivery_time in mono clock base or clock base of skb->tstamp.
> 
> drop "in mono clock base or "
> 
Noted 
>> + *		Otherwise, the timestamp is considered real clock base
> 
Noted 
> drop this: whenever in realtime clock base, tstamp_type is zero, so
> the above shorter statement always holds.
> 
>>   *	@napi_id: id of the NAPI struct this skb came from
>>   *	@sender_cpu: (aka @napi_id) source CPU in XPS
>>   *	@alloc_cpu: CPU which did the skb allocation.
>> @@ -960,7 +962,7 @@ struct sk_buff {
>>  	/* private: */
>>  	__u8			__mono_tc_offset[0];
>>  	/* public: */
>> -	__u8			tstamp_type:1;	/* See skb_tstamp_type */
>> +	__u8			tstamp_type:2;	/* See skb_tstamp_type */
>>  #ifdef CONFIG_NET_XGRESS
>>  	__u8			tc_at_ingress:1;	/* See TC_AT_INGRESS_MASK */
>>  	__u8			tc_skip_classify:1;
>> @@ -1090,15 +1092,17 @@ struct sk_buff {
>>  #endif
>>  #define PKT_TYPE_OFFSET		offsetof(struct sk_buff, __pkt_type_offset)
>>  
>> -/* if you move tc_at_ingress or mono_delivery_time
>> +/* if you move tc_at_ingress or tstamp_type:2
>>   * around, you also must adapt these constants.
>>   */
>>  #ifdef __BIG_ENDIAN_BITFIELD
>> -#define SKB_MONO_DELIVERY_TIME_MASK	(1 << 7)
>> -#define TC_AT_INGRESS_MASK		(1 << 6)
>> +#define SKB_TSTAMP_TYPE_MASK		(3 << 6)
>> +#define SKB_TSTAMP_TYPE_RSH		(6)
>> +#define TC_AT_INGRESS_RSH		(5)
> 
> I had to find BPF_RSH to understand this abbreviation.
> 
> use SHIFT instead of RSH, as that is so domain specific?
> 
Noted! I will use complete words instead of abbreviations
>> +#define TC_AT_INGRESS_MASK		(1 << 5)
>>  #else
>> -#define SKB_MONO_DELIVERY_TIME_MASK	(1 << 0)
>> -#define TC_AT_INGRESS_MASK		(1 << 1)
>> +#define SKB_TSTAMP_TYPE_MASK		(3)
>> +#define TC_AT_INGRESS_MASK		(1 << 2)
>>  #endif
>>  #define SKB_BF_MONO_TC_OFFSET		offsetof(struct sk_buff, __mono_tc_offset)
>>  
> 
>> -	if (skb->tstamp_type == BPF_SKB_TSTAMP_DELIVERY_MONO) {
>> +	if (skb->tstamp_type == BPF_SKB_TSTAMP_DELIVERY_MONO ||
>> +		  skb->tstamp_type == BPF_SKB_TSTAMP_DELIVERY_TAI) {
> 
> Peculiar indentation?
> 
Let me check why the indentation here is messed up. Ideally i run checkpatch(shows 0 errors or warnings)
 and also check before raising a patch. Internally it looks good but on the patch it shows differently. 

> Just FYI that I'm not the best person to review the BPF part.
> Thankfully Martin is helping you with that.
> 
I will wait for comments from Martin as well. 
> 
> 

