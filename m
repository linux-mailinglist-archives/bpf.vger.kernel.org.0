Return-Path: <bpf+bounces-28716-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 796378BD5F6
	for <lists+bpf@lfdr.de>; Mon,  6 May 2024 21:59:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0649E1F21EE0
	for <lists+bpf@lfdr.de>; Mon,  6 May 2024 19:59:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76D1915B151;
	Mon,  6 May 2024 19:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Bu18RpRU"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4817415B0F6;
	Mon,  6 May 2024 19:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715025509; cv=none; b=snuVwUYFzSFYQU86jxBqB3UFjKYGUhtw8Pi2RGvhlnuFx3rxdOG82IiqZFb9HjBVfjHqBPyDppc70pCXSkwykCsSWm1PI60tZXQ6Ok/wEaArnIMhwnTSOC/5J62pGkKWG4phgqPSdd05zwhIxkOO6MPvOy3627sD42FNpzHzmO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715025509; c=relaxed/simple;
	bh=gklR9i8Ru44/X+YY33kbZpwqqUb+llsiRtbGraKrs2M=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ZCLZ8o89ioMv+YS32HpFN8PvnQ+yR5Z4WNids/M4d968ZQ8CjHpvCH3FiIYLLynVUoNDBf/gAkesAi6W+79lygT2HcLa1wi1I4B0Kt3Vkh24/i1OEHD9mLpb4mQz6+cbexxTE10jl7vYg4E0iT+OpN9n8TW3bWGNgAD11G0o0nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Bu18RpRU; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 446JY3N4025470;
	Mon, 6 May 2024 19:57:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=E9NImimN24X4apS9VOyOvstl9oNziZZN4QvXgiEmHiw=; b=Bu
	18RpRUZmmPkCIxON1/4rSIh/l3ih3Mygw0lxiCFxck/9uaGxcH30C5SONEg4Yan8
	V9oqpcjmu24q0jOURWre0uQczvnJj23TA0XpyR1NOJfyOX+buAMpAoWKvIoM18Dp
	MpOasi1h9XdCb73UT48zuK4aCEf4PxUcsw3slfZ+0nkWoCQZcoev6k2Bt2fhUIlY
	PEbTeGQnjJCXgAZK0aT//NbzAxKXtEL2vMeGYQwCOgQqq9S3U4imDEHzFfD0KMC3
	NAdVtBV5bio1JXpGd4Xvn1z1MzvVVD1paniOizsU8tQQYxLg1Jmsg2rNU+GYUPxZ
	WCx+QJwNDsY3o0RuNO8g==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xxw9a96ys-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 May 2024 19:57:59 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 446Jvwuf003904
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 6 May 2024 19:57:58 GMT
Received: from [10.46.19.239] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 6 May 2024
 12:57:54 -0700
Message-ID: <da408a2f-270d-4c2d-b61c-7106170dbfe0@quicinc.com>
Date: Mon, 6 May 2024 12:57:54 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH bpf-next v6 2/3] net: Add additional bit to support
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
References: <20240504031331.2737365-1-quic_abchauha@quicinc.com>
 <20240504031331.2737365-3-quic_abchauha@quicinc.com>
 <663928ba373e3_516de294d5@willemb.c.googlers.com.notmuch>
From: "Abhishek Chauhan (ABC)" <quic_abchauha@quicinc.com>
In-Reply-To: <663928ba373e3_516de294d5@willemb.c.googlers.com.notmuch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: DK0BvuzNS1OTu5kWun-fBUPNgyne4Tfg
X-Proofpoint-ORIG-GUID: DK0BvuzNS1OTu5kWun-fBUPNgyne4Tfg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-06_14,2024-05-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 lowpriorityscore=0 phishscore=0 mlxscore=0 suspectscore=0 impostorscore=0
 priorityscore=1501 bulkscore=0 mlxlogscore=999 spamscore=0 adultscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2405060144



On 5/6/2024 12:00 PM, Willem de Bruijn wrote:
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
>> Changes since v5
>> - Took care of documentation comments of tstamp_type 
>>   in skbuff.h as mentioned by Willem.
>> - Use of complete words instead of abbrevation in 
>>   macro definitions as mentioned by Willem.
>> - Fixed indentation problems 
>> - Removed BPF_SKB_TSTAMP_UNSPEC and marked it 
>>   Deprecated as documentation, and introduced 
>>   BPF_SKB_CLOCK_REALTIME instead. 
>> - BUILD_BUG_ON for additional enums introduced.
>> - __ip_make_skb and ip6_make_skb now has 
>>   tcp checks to mark tcp packet as mono tstamp base. 
>> - separated the selftests/bpf changes into another patch.
>> - Made changes as per Martin in selftest bpf code and 
>>   tool/include/uapi/linux/bpf.h 
>>
>> Changes since v4
>> - Made changes to BPF code in filter.c as per 
>>   Martin's comments
>> - Minor fixes on comments given on documentation
>>   from Willem in skbuff.h (removed obvious ones)
>> - Made changes to ctx_rewrite.c and test_tc_dtime.c
>> - test_tc_dtime.c i am not really sure if i took care 
>>   of all the changes as i am not too familiar with 
>>   the framework.
>> - Introduce common mask SKB_TSTAMP_TYPE_MASK instead
>>   of multiple SKB mask.
>> - Optimisation on BPF code as suggested by Martin.
>> - Set default case to SKB_CLOCK_REALTME.  
>>
>> Changes since v3
>> - Carefully reviewed BPF APIs and made changes in 
>>   BPF code as well. 
>> - Re-used actual clockid_t values since skbuff.h 
>>   indirectly includes uapi/linux/time.h
>> - Added CLOCK_TAI as part of the skb_set_delivery_time
>>   handling instead of CLOCK_USER
>> - Added default in switch for unsupported and invalid 
>>   timestamp with an WARN_ONCE
>> - All of the above comments were given by Willem  
>> - Made changes in filter.c as per Martin's comments
>>   to handle invalid cases in bpf code with addition of
>>   SKB_TAI_DELIVERY_TIME_MASK
>>
>> Changes since v2
>> - Minor changes to commit subject
>>
>> Changes since v1 
>> - identified additional changes in BPF framework.
>> - Bit shift in SKB_MONO_DELIVERY_TIME_MASK and TC_AT_INGRESS_MASK.
>> - Made changes in skb_set_delivery_time to keep changes similar to 
>>   previous code for mono_delivery_time and just setting tstamp_type
>>   bit 1 for userspace timestamp.
>>
>>
>>  include/linux/skbuff.h   | 21 +++++++++++--------
>>  include/uapi/linux/bpf.h | 15 +++++++++-----
>>  net/core/filter.c        | 44 +++++++++++++++++++++++-----------------
>>  net/ipv4/ip_output.c     |  5 ++++-
>>  net/ipv4/raw.c           |  2 +-
>>  net/ipv6/ip6_output.c    |  5 ++++-
>>  net/ipv6/raw.c           |  2 +-
>>  net/packet/af_packet.c   |  7 +++----
>>  8 files changed, 61 insertions(+), 40 deletions(-)
>>
>> diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
>> index de3915e2bfdb..fe7d8dbef77e 100644
>> --- a/include/linux/skbuff.h
>> +++ b/include/linux/skbuff.h
>> @@ -709,6 +709,8 @@ typedef unsigned char *sk_buff_data_t;
>>  enum skb_tstamp_type {
>>  	SKB_CLOCK_REALTIME,
>>  	SKB_CLOCK_MONOTONIC,
>> +	SKB_CLOCK_TAI,
>> +	__SKB_CLOCK_MAX = SKB_CLOCK_TAI,
>>  };
>>  
>>  /**
>> @@ -829,8 +831,7 @@ enum skb_tstamp_type {
>>   *	@decrypted: Decrypted SKB
>>   *	@slow_gro: state present at GRO time, slower prepare step required
>>   *	@tstamp_type: When set, skb->tstamp has the
>> - *		delivery_time in mono clock base Otherwise, the
>> - *		timestamp is considered real clock base.
>> + *		delivery_time clock base of skb->tstamp.
>>   *	@napi_id: id of the NAPI struct this skb came from
>>   *	@sender_cpu: (aka @napi_id) source CPU in XPS
>>   *	@alloc_cpu: CPU which did the skb allocation.
>> @@ -958,7 +959,7 @@ struct sk_buff {
>>  	/* private: */
>>  	__u8			__mono_tc_offset[0];
>>  	/* public: */
>> -	__u8			tstamp_type:1;	/* See skb_tstamp_type */
>> +	__u8			tstamp_type:2;	/* See skb_tstamp_type */
>>  #ifdef CONFIG_NET_XGRESS
>>  	__u8			tc_at_ingress:1;	/* See TC_AT_INGRESS_MASK */
>>  	__u8			tc_skip_classify:1;
>> @@ -1088,15 +1089,16 @@ struct sk_buff {
>>  #endif
>>  #define PKT_TYPE_OFFSET		offsetof(struct sk_buff, __pkt_type_offset)
>>  
>> -/* if you move tc_at_ingress or mono_delivery_time
>> +/* if you move tc_at_ingress or tstamp_type
>>   * around, you also must adapt these constants.
>>   */
>>  #ifdef __BIG_ENDIAN_BITFIELD
>> -#define SKB_MONO_DELIVERY_TIME_MASK	(1 << 7)
>> -#define TC_AT_INGRESS_MASK		(1 << 6)
>> +#define SKB_TSTAMP_TYPE_MASK		(3 << 6)
>> +#define SKB_TSTAMP_TYPE_RSHIFT		(6)
>> +#define TC_AT_INGRESS_MASK		(1 << 5)
>>  #else
>> -#define SKB_MONO_DELIVERY_TIME_MASK	(1 << 0)
>> -#define TC_AT_INGRESS_MASK		(1 << 1)
>> +#define SKB_TSTAMP_TYPE_MASK		(3)
>> +#define TC_AT_INGRESS_MASK		(1 << 2)
>>  #endif
>>  #define SKB_BF_MONO_TC_OFFSET		offsetof(struct sk_buff, __mono_tc_offset)
>>  
>> @@ -4213,6 +4215,9 @@ static inline void skb_set_delivery_type_by_clockid(struct sk_buff *skb,
>>  	case CLOCK_MONOTONIC:
>>  		tstamp_type = SKB_CLOCK_MONOTONIC;
>>  		break;
>> +	case CLOCK_TAI:
>> +		tstamp_type = SKB_CLOCK_TAI;
>> +		break;
>>  	default:
>>  		WARN_ON_ONCE(1);
>>  		kt = 0;
>> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
>> index 90706a47f6ff..25ea393cf084 100644
>> --- a/include/uapi/linux/bpf.h
>> +++ b/include/uapi/linux/bpf.h
>> @@ -6207,12 +6207,17 @@ union {					\
>>  	__u64 :64;			\
>>  } __attribute__((aligned(8)))
>>  
>> +/* The enum used in skb->tstamp_type. It specifies the clock type
>> + * of the time stored in the skb->tstamp.
>> + */
>>  enum {
>> -	BPF_SKB_TSTAMP_UNSPEC,
>> -	BPF_SKB_TSTAMP_DELIVERY_MONO,	/* tstamp has mono delivery time */
>> -	/* For any BPF_SKB_TSTAMP_* that the bpf prog cannot handle,
>> -	 * the bpf prog should handle it like BPF_SKB_TSTAMP_UNSPEC
>> -	 * and try to deduce it by ingress, egress or skb->sk->sk_clockid.
>> +	BPF_SKB_TSTAMP_UNSPEC = 0,		/* DEPRECATED */
>> +	BPF_SKB_TSTAMP_DELIVERY_MONO = 1,	/* DEPRECATED */
>> +	BPF_SKB_CLOCK_REALTIME = 0,
>> +	BPF_SKB_CLOCK_MONOTONIC = 1,
>> +	BPF_SKB_CLOCK_TAI = 2,
>> +	/* For any future BPF_SKB_CLOCK_* that the bpf prog cannot handle,
>> +	 * the bpf prog can try to deduce it by ingress/egress/skb->sk->sk_clockid.
>>  	 */
>>  };
>>  
>> diff --git a/net/core/filter.c b/net/core/filter.c
>> index a3781a796da4..9f3df4a0d1ee 100644
>> --- a/net/core/filter.c
>> +++ b/net/core/filter.c
>> @@ -7726,16 +7726,20 @@ BPF_CALL_3(bpf_skb_set_tstamp, struct sk_buff *, skb,
>>  		return -EOPNOTSUPP;
>>  
>>  	switch (tstamp_type) {
>> -	case BPF_SKB_TSTAMP_DELIVERY_MONO:
>> +	case BPF_SKB_CLOCK_MONOTONIC:
>>  		if (!tstamp)
>>  			return -EINVAL;
>>  		skb->tstamp = tstamp;
>>  		skb->tstamp_type = SKB_CLOCK_MONOTONIC;
>>  		break;
>> -	case BPF_SKB_TSTAMP_UNSPEC:
>> -		if (tstamp)
>> +	case BPF_SKB_CLOCK_TAI:
>> +		if (!tstamp)
>>  			return -EINVAL;
>> -		skb->tstamp = 0;
>> +		skb->tstamp = tstamp;
>> +		skb->tstamp_type = SKB_CLOCK_TAI;
>> +		break;
>> +	case BPF_SKB_CLOCK_REALTIME:
>> +		skb->tstamp = tstamp;
>>  		skb->tstamp_type = SKB_CLOCK_REALTIME;
> 
> Only since there is another reason to respin.
> 
> The previous code did not do this, but let's order cases by their enum
> value, starting with realtime.
> 
> Also in anticipation with possible future expansions.
> 
Noted I will take care of this. 

> 

