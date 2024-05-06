Return-Path: <bpf+bounces-28714-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A8A608BD5F0
	for <lists+bpf@lfdr.de>; Mon,  6 May 2024 21:56:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C81671C2165A
	for <lists+bpf@lfdr.de>; Mon,  6 May 2024 19:56:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 624F215B0EE;
	Mon,  6 May 2024 19:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="nXZND1E1"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E3A9158873;
	Mon,  6 May 2024 19:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715025393; cv=none; b=fDtYH4dkFXckCk8OjlQB4ijuvtx312bZ62hiioL7oRXrhZTiWWDWlsicUqes+CeUjYk1ameY/DtygGPhDb+6xR99sa4g1iT29pfjt73/OHk+NcCF/1bgN8J0gWQl/r+sPJCP+Y/D1RqYIxmaJqDRMy/oOuiMoMF8Bj/O1D+UCWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715025393; c=relaxed/simple;
	bh=JFhvJgEX2i86F9mm/PhpoYzNtPw9miqAvLnpiFJ/Ae4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=QiURIamweXnTRloLC8/SJgSdvDnyCyJUDm5OVsHlwMFl5mpRRZmYe0xuHt4eFGC+Yttu0T/B+hoxSUppq1Cjj9uhgvAKsVi90o3RX/Y6BUbMAPD+pfre1six+oY+kc1Ix41s8KPP+m7v1m3FXBVx3mm/CFAU8WKAtauTMhDng6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=nXZND1E1; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 446JfdtZ014055;
	Mon, 6 May 2024 19:56:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=m0x8o1Z1zFc2e5jGX7V+1daAoIFnCubcmid7eQgSUvQ=; b=nX
	ZND1E19s/nqf2F4CJDyRUVEqupKGxoWbxpgpNdFbVXcPljaX1sXGsrtM2SOBXMXm
	/eEUrA05l5JnFaGAcrFvHVeg7LZxlRSE3Zlnwl/Q249iuWI2FLTq84GzpM4jv/Wu
	gfDQP2u6jn2vhwuXM0oHmas92mBAirk3b/CyceP2jye2tgol0VU2qahEqeFzyxqg
	J1FgnXIy43f3m74psW19mWf5+vmQ9xAiLp0jtBjFt69hWkb3AaYsScl2bnr/vB5G
	VbEPuBFNKUFp+xXnSWy86SOQHdSZAuCzhsMeOW2EMYTjNtDv331/UqLuqTW9GxE/
	cJp7QhK+o1zqjtbDuULg==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xxxj1h03t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 May 2024 19:56:02 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 446Ju1cu002114
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 6 May 2024 19:56:01 GMT
Received: from [10.46.19.239] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 6 May 2024
 12:55:57 -0700
Message-ID: <36d9ffdf-5715-4814-97db-bbf669294b5f@quicinc.com>
Date: Mon, 6 May 2024 12:55:57 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH bpf-next v6 1/3] net: Rename mono_delivery_time to
 tstamp_type for scalabilty
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
 <20240504031331.2737365-2-quic_abchauha@quicinc.com>
 <663926b74cbbd_516de29466@willemb.c.googlers.com.notmuch>
Content-Language: en-US
From: "Abhishek Chauhan (ABC)" <quic_abchauha@quicinc.com>
In-Reply-To: <663926b74cbbd_516de29466@willemb.c.googlers.com.notmuch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 3rEz_4f-I4u0aBYYCDwAaa-kzSGcQU0u
X-Proofpoint-ORIG-GUID: 3rEz_4f-I4u0aBYYCDwAaa-kzSGcQU0u
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-06_14,2024-05-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 phishscore=0 malwarescore=0 clxscore=1015 adultscore=0 mlxlogscore=999
 impostorscore=0 mlxscore=0 lowpriorityscore=0 suspectscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2405060144



On 5/6/2024 11:51 AM, Willem de Bruijn wrote:
> Abhishek Chauhan wrote:
>> mono_delivery_time was added to check if skb->tstamp has delivery
>> time in mono clock base (i.e. EDT) otherwise skb->tstamp has
>> timestamp in ingress and delivery_time at egress.
>>
>> Renaming the bitfield from mono_delivery_time to tstamp_type is for
>> extensibilty for other timestamps such as userspace timestamp
>> (i.e. SO_TXTIME) set via sock opts.
>>
>> As we are renaming the mono_delivery_time to tstamp_type, it makes
>> sense to start assigning tstamp_type based on enum defined
>> in this commit.
>>
>> Earlier we used bool arg flag to check if the tstamp is mono in
>> function skb_set_delivery_time, Now the signature of the functions
>> accepts tstamp_type to distinguish between mono and real time.
>>
>> Also skb_set_delivery_type_by_clockid is a new function which accepts
>> clockid to determine the tstamp_type.
>>
>> In future tstamp_type:1 can be extended to support userspace timestamp
>> by increasing the bitfield.
>>
>> Link: https://lore.kernel.org/netdev/bc037db4-58bb-4861-ac31-a361a93841d3@linux.dev/
>> Signed-off-by: Abhishek Chauhan <quic_abchauha@quicinc.com>
>> ---
>> Changes since v5
>> - Avoided using garble function names as mentioned by
>>   Willem.
>> - Implemented a conversion function stead of duplicating 
>>   the same logic as mentioned by Willem.
>> - Fixed indentation problems and minor documentation issues
>>   which mentions tstamp_type as a whole instead of bitfield
>>   notations. (Mentioned both by Willem and Martin)
>>   
>> Changes since v4
>> - Introduce new function to directly delivery_time and
>>   another to set tstamp_type based on clockid. 
>> - Removed un-necessary comments in skbuff.h as 
>>   enums were obvious and understood.
>>
>> Changes since v3
>> - Fixed inconsistent capitalization in skbuff.h
>> - remove reference to MONO_DELIVERY_TIME_MASK in skbuff.h
>>   and point it to skb_tstamp_type now.
>> - Explicitely setting SKB_CLOCK_MONO if valid transmit_time
>>   ip_send_unicast_reply 
>> - Keeping skb_tstamp inline with skb_clear_tstamp. 
>> - skb_set_delivery_time checks if timstamp is 0 and 
>>   sets the tstamp_type to SKB_CLOCK_REAL.
>> - Above comments are given by Willem 
>> - Found out that skbuff.h has access to uapi/linux/time.h
>>   So now instead of using  CLOCK_REAL/CLOCK_MONO 
>>   i am checking actual clockid_t directly to set tstamp_type 
>>   example:- CLOCK_REALTIME/CLOCK_MONOTONIC 
>> - Compilation error fixed in 
>>   net/ieee802154/6lowpan/reassembly.c
>>
>> Changes since v2
>> - Minor changes to commit subject
>>
>> Changes since v1
>> - Squashed the two commits into one as mentioned by Willem.
>> - Introduced switch in skb_set_delivery_time.
>> - Renamed and removed directionality aspects w.r.t tstamp_type 
>>   as mentioned by Willem.
>>
>>  include/linux/skbuff.h                     | 53 ++++++++++++++++------
>>  include/net/inet_frag.h                    |  4 +-
>>  net/bridge/netfilter/nf_conntrack_bridge.c |  6 +--
>>  net/core/dev.c                             |  2 +-
>>  net/core/filter.c                          | 10 ++--
>>  net/ieee802154/6lowpan/reassembly.c        |  2 +-
>>  net/ipv4/inet_fragment.c                   |  2 +-
>>  net/ipv4/ip_fragment.c                     |  2 +-
>>  net/ipv4/ip_output.c                       |  9 ++--
>>  net/ipv4/tcp_output.c                      | 16 +++----
>>  net/ipv6/ip6_output.c                      |  6 +--
>>  net/ipv6/netfilter.c                       |  6 +--
>>  net/ipv6/netfilter/nf_conntrack_reasm.c    |  2 +-
>>  net/ipv6/reassembly.c                      |  2 +-
>>  net/ipv6/tcp_ipv6.c                        |  2 +-
>>  net/sched/act_bpf.c                        |  4 +-
>>  net/sched/cls_bpf.c                        |  4 +-
>>  17 files changed, 80 insertions(+), 52 deletions(-)
>>
>> diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
>> index 1c2902eaebd3..de3915e2bfdb 100644
>> --- a/include/linux/skbuff.h
>> +++ b/include/linux/skbuff.h
>> @@ -706,6 +706,11 @@ typedef unsigned int sk_buff_data_t;
>>  typedef unsigned char *sk_buff_data_t;
>>  #endif
>>  
>> +enum skb_tstamp_type {
>> +	SKB_CLOCK_REALTIME,
>> +	SKB_CLOCK_MONOTONIC,
>> +};
>> +
>>  /**
>>   * DOC: Basic sk_buff geometry
>>   *
>> @@ -823,10 +828,9 @@ typedef unsigned char *sk_buff_data_t;
>>   *	@dst_pending_confirm: need to confirm neighbour
>>   *	@decrypted: Decrypted SKB
>>   *	@slow_gro: state present at GRO time, slower prepare step required
>> - *	@mono_delivery_time: When set, skb->tstamp has the
>> - *		delivery_time in mono clock base (i.e. EDT).  Otherwise, the
>> - *		skb->tstamp has the (rcv) timestamp at ingress and
>> - *		delivery_time at egress.
>> + *	@tstamp_type: When set, skb->tstamp has the
>> + *		delivery_time in mono clock base Otherwise, the
>> + *		timestamp is considered real clock base.
> 
> Missing period. More importantly, no longer conditional. It always
> captures the type of skb->tstamp.
> 
I think i should move the patchset 2 documentation to this patch itself. 

@tstamp_type: When set, skb->tstamp has the
+ *		delivery_time clock base of skb->tstamp.
>> --- a/net/ipv4/tcp_output.c
>> +++ b/net/ipv4/tcp_output.c
>> @@ -1301,7 +1301,7 @@ static int __tcp_transmit_skb(struct sock *sk, struct sk_buff *skb,
>>  	tp = tcp_sk(sk);
>>  	prior_wstamp = tp->tcp_wstamp_ns;
>>  	tp->tcp_wstamp_ns = max(tp->tcp_wstamp_ns, tp->tcp_clock_cache);
>> -	skb_set_delivery_time(skb, tp->tcp_wstamp_ns, true);
>> +	skb_set_delivery_type_by_clockid(skb, tp->tcp_wstamp_ns, CLOCK_MONOTONIC);
>>  	if (clone_it) {
>>  		oskb = skb;
>>  
>> @@ -1655,7 +1655,7 @@ int tcp_fragment(struct sock *sk, enum tcp_queue tcp_queue,
>>  
>>  	skb_split(skb, buff, len);
>>  
>> -	skb_set_delivery_time(buff, skb->tstamp, true);
>> +	skb_set_delivery_type_by_clockid(buff, skb->tstamp, CLOCK_MONOTONIC);
>>  	tcp_fragment_tstamp(skb, buff);
> 
> All these hardcoded monotonic calls in TCP can be the shorter version
> 
>     skb_set_delivery_type(.., SKB_CLOCK_MONOTONIC);
I think i should directly call skb_set_delivery_time if i know that TCP always uses Monotonic clock base, 
rather than calling the wrapper api which does nothing but switch and then calls skb_set_delivery_Time. 

Makes sense. I will make the changes in v7 . 
>   

