Return-Path: <bpf+bounces-30751-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E2678D2084
	for <lists+bpf@lfdr.de>; Tue, 28 May 2024 17:35:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DFC8F1F2390F
	for <lists+bpf@lfdr.de>; Tue, 28 May 2024 15:35:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3738D171641;
	Tue, 28 May 2024 15:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="mTImcsC8"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED7FB16F831;
	Tue, 28 May 2024 15:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716910533; cv=none; b=U6ujNMsgMd64og/QQNL3NPEU52FYf1wso3TyV/3WKriYjyiD1tSRWGtiacyXaRaYqlDhV/pFtRhjktemJNVB5fJQ7jQY0I5GBHiPcpp/ncSYn6XUMLaW5TWbuhx1KqbbRKHnGJ3pqQFkCsTyS+IYaTOSQXJnidKbhglOZYldQPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716910533; c=relaxed/simple;
	bh=ISzWTHgDdPN7pn8VZllpQwDMfA1a1MvvfCvh++/n8dg=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:CC:References:
	 In-Reply-To:Content-Type; b=Wajh3AsFIzYC00yE3FBQIUCCIjFwiuAQEp9PNZB5E/k3lNwTcDiFM6WpLurXnV+rguV6MfsGpkwyBxPxtV5Iio4B4le+1+rvcpQn6M3wuq+fKe0nzd2K7eB4r0a4+98UtTtJ9atFcbGb8qH5pjGwnxSk9PNkcHmz60CcyBazJZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=mTImcsC8; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44SARTND001482;
	Tue, 28 May 2024 15:35:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	cPcwjG6p8MDcwmfMaotLnf03+OVSfE6ywTXTujEm7sE=; b=mTImcsC8cEPGAbcw
	0fUHQ/aso1AtfxehfvHZmlJYvR2tHrhTz8TNDH9noYHLZvoNzLSf1e4A33gQByqj
	ntO5fNW4rzmBhxjt9XeM+oI+viOEhX+tjIvwF9xMfnNuldfnGgreb4iXALGcy73N
	+KPMPAKSGfVDbZQqpAUDp9OX1JTZwl5s4IgUYaYaUwHneKnHn0XOZyLJKb0Dwm3/
	d5ohuIt+QoOhVLYBacn6fRStQpGtmNn32/zART5H2UkitQiY/cDFFCY7VB/K4k5s
	hj3U0iWB3/sCsWpPk2s88sVxJvfaGrFuS+IxwH1Cb2bp0qc4BCnTW6mHMOQDLJ/L
	Z8tlMw==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yba1k6h6m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 May 2024 15:35:06 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 44SFZ5Wn005500
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 May 2024 15:35:05 GMT
Received: from [10.110.47.143] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 28 May
 2024 08:35:01 -0700
Message-ID: <6bdba7b6-fd22-4ea5-a356-12268674def1@quicinc.com>
Date: Tue, 28 May 2024 08:35:00 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v8 1/3] net: Rename mono_delivery_time to
 tstamp_type for scalabilty
From: "Abhishek Chauhan (ABC)" <quic_abchauha@quicinc.com>
To: "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Andrew Halaney <ahalaney@redhat.com>,
        "Willem
 de Bruijn" <willemdebruijn.kernel@gmail.com>,
        Martin KaFai Lau
	<martin.lau@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        "Daniel
 Borkmann" <daniel@iogearbox.net>, bpf <bpf@vger.kernel.org>
CC: <kernel@quicinc.com>, Willem de Bruijn <willemb@google.com>
References: <20240509211834.3235191-1-quic_abchauha@quicinc.com>
 <20240509211834.3235191-2-quic_abchauha@quicinc.com>
Content-Language: en-US
In-Reply-To: <20240509211834.3235191-2-quic_abchauha@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 9D51rKtRR599XHQz8b6rU9KfPrFOeqL5
X-Proofpoint-GUID: 9D51rKtRR599XHQz8b6rU9KfPrFOeqL5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-28_11,2024-05-28_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 impostorscore=0
 suspectscore=0 phishscore=0 clxscore=1011 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 spamscore=0 adultscore=0 malwarescore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2405280116



On 5/9/2024 2:18 PM, Abhishek Chauhan wrote:
> mono_delivery_time was added to check if skb->tstamp has delivery
> time in mono clock base (i.e. EDT) otherwise skb->tstamp has
> timestamp in ingress and delivery_time at egress.
> 
> Renaming the bitfield from mono_delivery_time to tstamp_type is for
> extensibilty for other timestamps such as userspace timestamp
> (i.e. SO_TXTIME) set via sock opts.
> 
> As we are renaming the mono_delivery_time to tstamp_type, it makes
> sense to start assigning tstamp_type based on enum defined
> in this commit.
> 
> Earlier we used bool arg flag to check if the tstamp is mono in
> function skb_set_delivery_time, Now the signature of the functions
> accepts tstamp_type to distinguish between mono and real time.
> 
> Also skb_set_delivery_type_by_clockid is a new function which accepts
> clockid to determine the tstamp_type.
> 
> In future tstamp_type:1 can be extended to support userspace timestamp
> by increasing the bitfield.
> 
> Link: https://lore.kernel.org/netdev/bc037db4-58bb-4861-ac31-a361a93841d3@linux.dev/
> Signed-off-by: Abhishek Chauhan <quic_abchauha@quicinc.com>
> Reviewed-by: Willem de Bruijn <willemb@google.com>
> Reviewed-by: Martin KaFai Lau <martin.lau@kernel.org>
> ---
> Changes since v7
> - Added reviewed by tags and removed RFC 
> 
> Changes since v6
> - Moved documentation comment from patch 2 to patch 1 (Minor)
> - Instead of calling the wrapper api to set tstamp_type
>   for tcp, directly call main api to set the tstamp_type
>   as suggested by Willem
> 
> Changes since v5
> - Avoided using garble function names as mentioned by
>   Willem.
> - Implemented a conversion function stead of duplicating 
>   the same logic as mentioned by Willem.
> - Fixed indentation problems and minor documentation issues
>   which mentions tstamp_type as a whole instead of bitfield
>   notations. (Mentioned both by Willem and Martin)
>   
> Changes since v4
> - Introduce new function to directly delivery_time and
>   another to set tstamp_type based on clockid. 
> - Removed un-necessary comments in skbuff.h as 
>   enums were obvious and understood.
> 
> Changes since v3
> - Fixed inconsistent capitalization in skbuff.h
> - remove reference to MONO_DELIVERY_TIME_MASK in skbuff.h
>   and point it to skb_tstamp_type now.
> - Explicitely setting SKB_CLOCK_MONO if valid transmit_time
>   ip_send_unicast_reply 
> - Keeping skb_tstamp inline with skb_clear_tstamp. 
> - skb_set_delivery_time checks if timstamp is 0 and 
>   sets the tstamp_type to SKB_CLOCK_REAL.
> - Above comments are given by Willem 
> - Found out that skbuff.h has access to uapi/linux/time.h
>   So now instead of using  CLOCK_REAL/CLOCK_MONO 
>   i am checking actual clockid_t directly to set tstamp_type 
>   example:- CLOCK_REALTIME/CLOCK_MONOTONIC 
> - Compilation error fixed in 
>   net/ieee802154/6lowpan/reassembly.c
> 
> Changes since v2
> - Minor changes to commit subject
> 
> Changes since v1
> - Squashed the two commits into one as mentioned by Willem.
> - Introduced switch in skb_set_delivery_time.
> - Renamed and removed directionality aspects w.r.t tstamp_type 
>   as mentioned by Willem.
> 
> 
>  include/linux/skbuff.h                     | 52 ++++++++++++++++------
>  include/net/inet_frag.h                    |  4 +-
>  net/bridge/netfilter/nf_conntrack_bridge.c |  6 +--
>  net/core/dev.c                             |  2 +-
>  net/core/filter.c                          | 10 ++---
>  net/ieee802154/6lowpan/reassembly.c        |  2 +-
>  net/ipv4/inet_fragment.c                   |  2 +-
>  net/ipv4/ip_fragment.c                     |  2 +-
>  net/ipv4/ip_output.c                       |  9 ++--
>  net/ipv4/tcp_output.c                      | 14 +++---
>  net/ipv6/ip6_output.c                      |  6 +--
>  net/ipv6/netfilter.c                       |  6 +--
>  net/ipv6/netfilter/nf_conntrack_reasm.c    |  2 +-
>  net/ipv6/reassembly.c                      |  2 +-
>  net/ipv6/tcp_ipv6.c                        |  2 +-
>  net/sched/act_bpf.c                        |  4 +-
>  net/sched/cls_bpf.c                        |  4 +-
>  17 files changed, 78 insertions(+), 51 deletions(-)
> 
> diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
> index 1c2902eaebd3..05aec712d16d 100644
> --- a/include/linux/skbuff.h
> +++ b/include/linux/skbuff.h
> @@ -706,6 +706,11 @@ typedef unsigned int sk_buff_data_t;
>  typedef unsigned char *sk_buff_data_t;
>  #endif
>  
> +enum skb_tstamp_type {
> +	SKB_CLOCK_REALTIME,
> +	SKB_CLOCK_MONOTONIC,
> +};
> +
>  /**
>   * DOC: Basic sk_buff geometry
>   *
> @@ -823,10 +828,8 @@ typedef unsigned char *sk_buff_data_t;
>   *	@dst_pending_confirm: need to confirm neighbour
>   *	@decrypted: Decrypted SKB
>   *	@slow_gro: state present at GRO time, slower prepare step required
> - *	@mono_delivery_time: When set, skb->tstamp has the
> - *		delivery_time in mono clock base (i.e. EDT).  Otherwise, the
> - *		skb->tstamp has the (rcv) timestamp at ingress and
> - *		delivery_time at egress.
> + *	@tstamp_type: When set, skb->tstamp has the
> + *		delivery_time clock base of skb->tstamp.
>   *	@napi_id: id of the NAPI struct this skb came from
>   *	@sender_cpu: (aka @napi_id) source CPU in XPS
>   *	@alloc_cpu: CPU which did the skb allocation.
> @@ -954,7 +957,7 @@ struct sk_buff {
>  	/* private: */
>  	__u8			__mono_tc_offset[0];
>  	/* public: */
> -	__u8			mono_delivery_time:1;	/* See SKB_MONO_DELIVERY_TIME_MASK */
> +	__u8			tstamp_type:1;	/* See skb_tstamp_type */
>  #ifdef CONFIG_NET_XGRESS
>  	__u8			tc_at_ingress:1;	/* See TC_AT_INGRESS_MASK */
>  	__u8			tc_skip_classify:1;
> @@ -4179,7 +4182,7 @@ static inline void skb_get_new_timestampns(const struct sk_buff *skb,
>  static inline void __net_timestamp(struct sk_buff *skb)
>  {
>  	skb->tstamp = ktime_get_real();
> -	skb->mono_delivery_time = 0;
> +	skb->tstamp_type = SKB_CLOCK_REALTIME;
>  }
>  
>  static inline ktime_t net_timedelta(ktime_t t)
> @@ -4188,10 +4191,33 @@ static inline ktime_t net_timedelta(ktime_t t)
>  }
>  
>  static inline void skb_set_delivery_time(struct sk_buff *skb, ktime_t kt,
> -					 bool mono)
> +					 u8 tstamp_type)
>  {
>  	skb->tstamp = kt;
> -	skb->mono_delivery_time = kt && mono;
> +
> +	if (kt)
> +		skb->tstamp_type = tstamp_type;
> +	else
> +		skb->tstamp_type = SKB_CLOCK_REALTIME;
> +}
> +
> +static inline void skb_set_delivery_type_by_clockid(struct sk_buff *skb,
> +						    ktime_t kt, clockid_t clockid)
> +{
> +	u8 tstamp_type = SKB_CLOCK_REALTIME;
> +
> +	switch (clockid) {
> +	case CLOCK_REALTIME:
> +		break;
> +	case CLOCK_MONOTONIC:
> +		tstamp_type = SKB_CLOCK_MONOTONIC;
> +		break;
> +	default:

Willem and Martin, I was thinking we should remove this warn_on_once from below line. Some systems also use panic on warn. 
So i think this might result in unnecessary crashes. 

Let me know what you think. 

Logs which are complaining. 
https://syzkaller.appspot.com/x/log.txt?x=118c3ae8980000

> +		WARN_ON_ONCE(1);
> +		kt = 0;
> +	}
> +
> +	skb_set_delivery_time(skb, kt, tstamp_type);
>  }
>  

