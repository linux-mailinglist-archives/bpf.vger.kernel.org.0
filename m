Return-Path: <bpf+bounces-26873-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05E238A5CA0
	for <lists+bpf@lfdr.de>; Mon, 15 Apr 2024 23:07:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1F25282E4C
	for <lists+bpf@lfdr.de>; Mon, 15 Apr 2024 21:07:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E365156C49;
	Mon, 15 Apr 2024 21:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="IsDukFQz"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D86B15696C;
	Mon, 15 Apr 2024 21:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713215235; cv=none; b=Ay2nmwFxW6WGLpwcd8WFUbYjS7bnmQnDrJQb5JvYyzjxqeB877W8naG3veYnrd8zqC6t0nqca86h5aXCv+vHfWe/sY9D70OtadmiZGgWjUR3QlxUOYWk8QOtasXJDteFygc3L6InI0IfScz1JzcV/ikNYVZg+GAnMx2rNpBbsoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713215235; c=relaxed/simple;
	bh=s3a6f3qIEir1cn382iZdpn0h+TD4VlW9wB1BAF+rIPI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=XYyXemfeKDGTAKIwgscgqKpeOAhrBTNckV8kdXPiQln0br21yMgvoxp5szd7LuxnnuVi3yDK45lIKDcTmEwCPj4K4eNM/qraQuYAEyc7KNXNQjPj6trjP5+g6g09PBQV1IorBIWYLPLcv/5zcvO/7dWisTTP2clhX9qViPI14OA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=IsDukFQz; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43FKM18r027957;
	Mon, 15 Apr 2024 21:06:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=dM7YEgGtEvkGNcXL28WlEtqI7x0iAtZXRj4lh2wqttE=; b=Is
	DukFQzYn4BVj7GMn2EGYIKKT2nUuOpyFQi3fJV/24NcU5uLIl/Afe2yWgS2Sb/i7
	V9n4NoM23y+MJ8uWuhT4xdgweqSsLHBE+bQ4foJ0C/yDEGBUtwAGt2xKMedJpBN4
	TsqCnkC0n7PV8zZfHRk4pPJlb5PmgHVYh2X4eGwsnlSMm9rEcSliHv03zDChfzRy
	NmOlOf9HJidkRDi+DJVsg50N22bNzyvWl8D5NJcKxapuRD/rI0QLqoUz+trcudG8
	rAKsTwa4d3DSmvfMPz1hWd9OEm+FKY/sXsHAgpN2QGJohdcxLs6Tycr/mcNeHDEf
	bNActr0rSgt6bA8uvSwA==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xh5bsryhs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Apr 2024 21:06:51 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43FL6oGS030004
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Apr 2024 21:06:50 GMT
Received: from [10.46.19.239] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 15 Apr
 2024 14:06:46 -0700
Message-ID: <6bfee126-36f4-4595-950e-058d93303362@quicinc.com>
Date: Mon, 15 Apr 2024 14:06:45 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH bpf-next v3 1/2] net: Rename mono_delivery_time to
 tstamp_type for scalabilty
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
References: <20240412210125.1780574-1-quic_abchauha@quicinc.com>
 <20240412210125.1780574-2-quic_abchauha@quicinc.com>
 <661ad4f0e3766_3be9a7294a1@willemb.c.googlers.com.notmuch>
 <c992e03b-eee5-471a-9002-f35bdfa1be2d@quicinc.com>
 <661d92391de45_30101294f2@willemb.c.googlers.com.notmuch>
From: "Abhishek Chauhan (ABC)" <quic_abchauha@quicinc.com>
In-Reply-To: <661d92391de45_30101294f2@willemb.c.googlers.com.notmuch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 3J71bhrZDOueEiCvewYfdeBtlSUBMPju
X-Proofpoint-GUID: 3J71bhrZDOueEiCvewYfdeBtlSUBMPju
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-15_18,2024-04-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 mlxlogscore=999
 priorityscore=1501 spamscore=0 clxscore=1015 malwarescore=0 adultscore=0
 phishscore=0 bulkscore=0 suspectscore=0 impostorscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2404010003
 definitions=main-2404150139



On 4/15/2024 1:46 PM, Willem de Bruijn wrote:
> Abhishek Chauhan (ABC) wrote:
>>
>>
>> On 4/13/2024 11:54 AM, Willem de Bruijn wrote:
>>> Abhishek Chauhan wrote:
>>>> mono_delivery_time was added to check if skb->tstamp has delivery
>>>> time in mono clock base (i.e. EDT) otherwise skb->tstamp has
>>>> timestamp in ingress and delivery_time at egress.
>>>>
>>>> Renaming the bitfield from mono_delivery_time to tstamp_type is for
>>>> extensibilty for other timestamps such as userspace timestamp
>>>> (i.e. SO_TXTIME) set via sock opts.
>>>>
>>>> As we are renaming the mono_delivery_time to tstamp_type, it makes
>>>> sense to start assigning tstamp_type based out if enum defined as
>>>> part of this commit
>>>>
>>>> Earlier we used bool arg flag to check if the tstamp is mono in
>>>> function skb_set_delivery_time, Now the signature of the functions
>>>> accepts enum to distinguish between mono and real time
>>>>
>>>> Bridge driver today has no support to forward the userspace timestamp
>>>> packets and ends up resetting the timestamp. ETF qdisc checks the
>>>> packet coming from userspace and encounters to be 0 thereby dropping
>>>> time sensitive packets. These changes will allow userspace timestamps
>>>> packets to be forwarded from the bridge to NIC drivers.
>>>>
>>>> In future tstamp_type:1 can be extended to support userspace timestamp
>>>> by increasing the bitfield.
>>>>
>>>> Link: https://lore.kernel.org/netdev/bc037db4-58bb-4861-ac31-a361a93841d3@linux.dev/
>>>> Signed-off-by: Abhishek Chauhan <quic_abchauha@quicinc.com>
>>>> ---
>>>> Changes since v2
>>>> - Minor changes to commit subject
>>>>
>>>> Changes since v1
>>>> - Squashed the two commits into one as mentioned by Willem.
>>>> - Introduced switch in skb_set_delivery_time.
>>>> - Renamed and removed directionality aspects w.r.t tstamp_type 
>>>>   as mentioned by Willem.
>>>>
>>>>  include/linux/skbuff.h                     | 33 +++++++++++++++-------
>>>>  include/net/inet_frag.h                    |  4 +--
>>>>  net/bridge/netfilter/nf_conntrack_bridge.c |  6 ++--
>>>>  net/core/dev.c                             |  2 +-
>>>>  net/core/filter.c                          |  8 +++---
>>>>  net/ipv4/inet_fragment.c                   |  2 +-
>>>>  net/ipv4/ip_fragment.c                     |  2 +-
>>>>  net/ipv4/ip_output.c                       |  8 +++---
>>>>  net/ipv4/tcp_output.c                      | 14 ++++-----
>>>>  net/ipv6/ip6_output.c                      |  6 ++--
>>>>  net/ipv6/netfilter.c                       |  6 ++--
>>>>  net/ipv6/netfilter/nf_conntrack_reasm.c    |  2 +-
>>>>  net/ipv6/reassembly.c                      |  2 +-
>>>>  net/ipv6/tcp_ipv6.c                        |  2 +-
>>>>  net/sched/act_bpf.c                        |  4 +--
>>>>  net/sched/cls_bpf.c                        |  4 +--
>>>>  16 files changed, 59 insertions(+), 46 deletions(-)
>>>>
>>>> diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
>>>> index 7135a3e94afd..a83a2120b57f 100644
>>>> --- a/include/linux/skbuff.h
>>>> +++ b/include/linux/skbuff.h
>>>> @@ -702,6 +702,11 @@ typedef unsigned int sk_buff_data_t;
>>>>  typedef unsigned char *sk_buff_data_t;
>>>>  #endif
>>>>  
>>>> +enum skb_tstamp_type {
>>>> +	CLOCK_REAL = 0, /* Time base is realtime */
>>>> +	CLOCK_MONO = 1, /* Time base is Monotonic */
>>>> +};
>>>
>>> Minor: inconsistent capitalization
>>>
>> I will fix this. 
>>
>>>> +
>>>>  /**
>>>>   * DOC: Basic sk_buff geometry
>>>>   *
>>>> @@ -819,7 +824,7 @@ typedef unsigned char *sk_buff_data_t;
>>>>   *	@dst_pending_confirm: need to confirm neighbour
>>>>   *	@decrypted: Decrypted SKB
>>>>   *	@slow_gro: state present at GRO time, slower prepare step required
>>>> - *	@mono_delivery_time: When set, skb->tstamp has the
>>>> + *	@tstamp_type: When set, skb->tstamp has the
>>>>   *		delivery_time in mono clock base (i.e. EDT).  Otherwise, the
>>>>   *		skb->tstamp has the (rcv) timestamp at ingress and
>>>>   *		delivery_time at egress.
>>>> @@ -950,7 +955,7 @@ struct sk_buff {
>>>>  	/* private: */
>>>>  	__u8			__mono_tc_offset[0];
>>>>  	/* public: */
>>>> -	__u8			mono_delivery_time:1;	/* See SKB_MONO_DELIVERY_TIME_MASK */
>>>> +	__u8			tstamp_type:1;	/* See SKB_MONO_DELIVERY_TIME_MASK */
>>>
>>> Also remove reference to MONO_DELIVERY_TIME_MASK, or instead refer to
>>> skb_tstamp_type.
>>>
>>>>  #ifdef CONFIG_NET_XGRESS
>>>>  	__u8			tc_at_ingress:1;	/* See TC_AT_INGRESS_MASK */
>>>>  	__u8			tc_skip_classify:1;
>>>> @@ -4237,7 +4242,7 @@ static inline void skb_get_new_timestampns(const struct sk_buff *skb,
>>>>  static inline void __net_timestamp(struct sk_buff *skb)
>>>>  {
>>>>  	skb->tstamp = ktime_get_real();
>>>> -	skb->mono_delivery_time = 0;
>>>> +	skb->tstamp_type = CLOCK_REAL;
>>>>  }
>>>>  
>>>>  static inline ktime_t net_timedelta(ktime_t t)
>>>> @@ -4246,10 +4251,18 @@ static inline ktime_t net_timedelta(ktime_t t)
>>>>  }
>>>>  
>>>>  static inline void skb_set_delivery_time(struct sk_buff *skb, ktime_t kt,
>>>> -					 bool mono)
>>>> +					  u8 tstamp_type)
>>>>  {
>>>>  	skb->tstamp = kt;
>>>> -	skb->mono_delivery_time = kt && mono;
>>>> +
>>>> +	switch (tstamp_type) {
>>>> +	case CLOCK_REAL:
>>>> +		skb->tstamp_type = CLOCK_REAL;
>>>> +		break;
>>>> +	case CLOCK_MONO:
>>>> +		skb->tstamp_type = kt && tstamp_type;
>>>> +		break;
>>>> +	}
>>>
>>> Technically this leaves the tstamp_type undefined if (skb, 0, CLOCK_REAL)
>> Do you think i should be checking for valid value of tstamp before setting the tstamp_type ? Only then set it. 
> 
> A kt of 0 is interpreted as resetting the type. That should probably
> be maintained.
> 
> For SO_TIMESTAMPING, a mono delivery time of 0 does have some meaning.
> In __sock_recv_timestamp:
> 
>         /* Race occurred between timestamp enabling and packet
>            receiving.  Fill in the current time for now. */
>         if (need_software_tstamp && skb->tstamp == 0) {
>                 __net_timestamp(skb);
>                 false_tstamp = 1;
>         }

Well in that case the above logic still resets the tstamp and sets the tstamp_type to CLOCK_REAL(value 0). 
Anyway the tstamp_type will be 0 to begin with. 
The logic is still inline with previous implementation, because previously if kt was 0 then kt && mono sets the tstamp_type (previously called as mono_delivery_time) to 0 (i.e SKB_CLOCK_REAL). 



