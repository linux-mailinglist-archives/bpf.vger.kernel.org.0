Return-Path: <bpf+bounces-26592-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69AC68A228F
	for <lists+bpf@lfdr.de>; Fri, 12 Apr 2024 01:46:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2077C2844CE
	for <lists+bpf@lfdr.de>; Thu, 11 Apr 2024 23:46:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAB674AEDA;
	Thu, 11 Apr 2024 23:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="MP9fbSB8"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C2DB482ED;
	Thu, 11 Apr 2024 23:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712879189; cv=none; b=d495QHkq5ya5UJm2BObOCCZiLoj0FlEA/5WCJELDU04UW0kkzDH2BLjTz5+fnC0ocd4YwOyYODXoht1O6h+WmV9vrUD5BPUWPBn2VXZe0rMz8fw+KbEPSpPjW1O5BtO2jH8ZdlZKrIqOcyT/mj+depCbBmpsMMG9BiDmLOQFLw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712879189; c=relaxed/simple;
	bh=CdZlQMBL8CElzIpbIGctu2GE65sJ1vpzse3EqiuFQAU=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:CC:References:
	 In-Reply-To:Content-Type; b=Ap32u9UXjBMGpTW8Ak6dHrpeOfUaFRsAkbiIQ8qyFxLe0/FXGSpqpsmZ4d6qejJjU5i28mvqcIqMG0T+aqAB7HqpgRHCCmerTlDYLh150HEAm70ndr9Q+sItoWDpSgVKyDGvIQn8gO7r0at+l8f5jlQArw60Mta90XAzURYbfLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=MP9fbSB8; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43BNZKbG005412;
	Thu, 11 Apr 2024 23:46:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:from:to:cc:references
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=eL+Xb9fgVTawqraT9lVFOWPeCq+FIA0dJKmE+j9A+v4=; b=MP
	9fbSB8Ih6tLhB0Rt+ctn1GQsPKfuzP8jJhESs6iBVA7WQ1sg1JpJC4wxQeNlZyvu
	706X4WYWl++A/h1eZaHi4VQ3Kv9ORo1IA22nGbWvJ4VGVCw80vQ5u0LinvCfcnru
	txzSQA39gMjd/s8EjAnB3/fQ36Z0eT53QTXn3lxV81mTUPXV8kRSbf29YNjsbquJ
	HKPY4OjPNJiZ8fwUVFVFKv2FKuFOwlS6d1OxAFi5GPOhlxw7ZAtEoJpPAqWYo60u
	afHSyIyEDIbcS6rLdIM+tkSmJp+8LSay6merRqAoZLpuxPMuT5r7jC8ckuY2wodh
	8F3eYlRszD88QPyaU4ag==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xer1tr5c9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Apr 2024 23:46:03 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43BNk2ri003740
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Apr 2024 23:46:02 GMT
Received: from [10.46.19.239] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 11 Apr
 2024 16:45:58 -0700
Message-ID: <f2ff9603-6e04-480a-8c1b-683075017ade@quicinc.com>
Date: Thu, 11 Apr 2024 16:45:57 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH bpf-next v2] net: Add additional bit to support
 userspace timestamp type
Content-Language: en-US
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
CC: <kernel@quicinc.com>
References: <20240411230506.1115174-1-quic_abchauha@quicinc.com>
 <20240411230506.1115174-3-quic_abchauha@quicinc.com>
In-Reply-To: <20240411230506.1115174-3-quic_abchauha@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: VA-OEImqmx2LdQU9INnU8OVSVqohBi6Z
X-Proofpoint-GUID: VA-OEImqmx2LdQU9INnU8OVSVqohBi6Z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-11_12,2024-04-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=999 malwarescore=0 adultscore=0 suspectscore=0
 lowpriorityscore=0 spamscore=0 bulkscore=0 impostorscore=0 clxscore=1015
 mlxscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404110170


I see one problem which i will fix it as part of next patch (considering 24h to upload next patch) 
is the subject does not show  [RFC PATCH bpf-next v2 (2/2)<== this is missing] 

On 4/11/2024 4:05 PM, Abhishek Chauhan wrote:
> tstamp_type can be real, mono or userspace timestamp.
> 
> This commit adds userspace timestamp and sets it if there is
> valid transmit_time available in socket coming from userspace.
> 
> To make the design scalable for future needs this commit bring in
> the change to extend the tstamp_type:1 to tstamp_type:2 to support
> userspace timestamp.
> 
> Link: https://lore.kernel.org/netdev/bc037db4-58bb-4861-ac31-a361a93841d3@linux.dev/
> Signed-off-by: Abhishek Chauhan <quic_abchauha@quicinc.com>
> ---
> Changes since v1 
> - identified additional changes in BPF framework.
> - Bit shift in SKB_MONO_DELIVERY_TIME_MASK and TC_AT_INGRESS_MASK.
> - Made changes in skb_set_delivery_time to keep changes similar to 
>   previous code for mono_delivery_time and just setting tstamp_type
>   bit 1 for userspace timestamp.
> 
>  include/linux/skbuff.h                        | 19 +++++++++++++++----
>  net/ipv4/ip_output.c                          |  2 +-
>  net/ipv4/raw.c                                |  2 +-
>  net/ipv6/ip6_output.c                         |  2 +-
>  net/ipv6/raw.c                                |  2 +-
>  net/packet/af_packet.c                        |  7 +++----
>  .../selftests/bpf/prog_tests/ctx_rewrite.c    |  8 ++++----
>  7 files changed, 26 insertions(+), 16 deletions(-)
> 
> diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
> index a83a2120b57f..b6346c21c3d4 100644
> --- a/include/linux/skbuff.h
> +++ b/include/linux/skbuff.h
> @@ -827,7 +827,8 @@ enum skb_tstamp_type {
>   *	@tstamp_type: When set, skb->tstamp has the
>   *		delivery_time in mono clock base (i.e. EDT).  Otherwise, the
>   *		skb->tstamp has the (rcv) timestamp at ingress and
> - *		delivery_time at egress.
> + *		delivery_time at egress or skb->tstamp defined by skb->sk->sk_clockid
> + *		coming from userspace
>   *	@napi_id: id of the NAPI struct this skb came from
>   *	@sender_cpu: (aka @napi_id) source CPU in XPS
>   *	@alloc_cpu: CPU which did the skb allocation.
> @@ -955,7 +956,7 @@ struct sk_buff {
>  	/* private: */
>  	__u8			__mono_tc_offset[0];
>  	/* public: */
> -	__u8			tstamp_type:1;	/* See SKB_MONO_DELIVERY_TIME_MASK */
> +	__u8			tstamp_type:2;	/* See SKB_MONO_DELIVERY_TIME_MASK */
>  #ifdef CONFIG_NET_XGRESS
>  	__u8			tc_at_ingress:1;	/* See TC_AT_INGRESS_MASK */
>  	__u8			tc_skip_classify:1;
> @@ -1090,10 +1091,10 @@ struct sk_buff {
>   */
>  #ifdef __BIG_ENDIAN_BITFIELD
>  #define SKB_MONO_DELIVERY_TIME_MASK	(1 << 7)
> -#define TC_AT_INGRESS_MASK		(1 << 6)
> +#define TC_AT_INGRESS_MASK		(1 << 5)
>  #else
>  #define SKB_MONO_DELIVERY_TIME_MASK	(1 << 0)
> -#define TC_AT_INGRESS_MASK		(1 << 1)
> +#define TC_AT_INGRESS_MASK		(1 << 2)
>  #endif
>  #define SKB_BF_MONO_TC_OFFSET		offsetof(struct sk_buff, __mono_tc_offset)
>  
> @@ -4262,6 +4263,16 @@ static inline void skb_set_delivery_time(struct sk_buff *skb, ktime_t kt,
>  	case CLOCK_MONO:
>  		skb->tstamp_type = kt && tstamp_type;
>  		break;
> +	/* if any other time base, must be from userspace
> +	 * so set userspace tstamp_type bit
> +	 * See skbuff tstamp_type:2
> +	 * 0x0 => real timestamp_type
> +	 * 0x1 => mono timestamp_type
> +	 * 0x2 => timestamp_type set from userspace
> +	 */
> +	default:
> +		if (kt && tstamp_type)
> +			skb->tstamp_type = 0x2;
>  	}
>  }
>  
> diff --git a/net/ipv4/ip_output.c b/net/ipv4/ip_output.c
> index 62e457f7c02c..c9317d4addce 100644
> --- a/net/ipv4/ip_output.c
> +++ b/net/ipv4/ip_output.c
> @@ -1457,7 +1457,7 @@ struct sk_buff *__ip_make_skb(struct sock *sk,
>  
>  	skb->priority = (cork->tos != -1) ? cork->priority: READ_ONCE(sk->sk_priority);
>  	skb->mark = cork->mark;
> -	skb->tstamp = cork->transmit_time;
> +	skb_set_delivery_time(skb, cork->transmit_time, sk->sk_clockid);
>  	/*
>  	 * Steal rt from cork.dst to avoid a pair of atomic_inc/atomic_dec
>  	 * on dst refcount
> diff --git a/net/ipv4/raw.c b/net/ipv4/raw.c
> index dcb11f22cbf2..a7d84fc0e530 100644
> --- a/net/ipv4/raw.c
> +++ b/net/ipv4/raw.c
> @@ -360,7 +360,7 @@ static int raw_send_hdrinc(struct sock *sk, struct flowi4 *fl4,
>  	skb->protocol = htons(ETH_P_IP);
>  	skb->priority = READ_ONCE(sk->sk_priority);
>  	skb->mark = sockc->mark;
> -	skb->tstamp = sockc->transmit_time;
> +	skb_set_delivery_time(skb, sockc->transmit_time, sk->sk_clockid);
>  	skb_dst_set(skb, &rt->dst);
>  	*rtp = NULL;
>  
> diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
> index a9e819115622..0b8193bdd98f 100644
> --- a/net/ipv6/ip6_output.c
> +++ b/net/ipv6/ip6_output.c
> @@ -1924,7 +1924,7 @@ struct sk_buff *__ip6_make_skb(struct sock *sk,
>  
>  	skb->priority = READ_ONCE(sk->sk_priority);
>  	skb->mark = cork->base.mark;
> -	skb->tstamp = cork->base.transmit_time;
> +	skb_set_delivery_time(skb, cork->base.transmit_time, sk->sk_clockid);
>  
>  	ip6_cork_steal_dst(skb, cork);
>  	IP6_INC_STATS(net, rt->rt6i_idev, IPSTATS_MIB_OUTREQUESTS);
> diff --git a/net/ipv6/raw.c b/net/ipv6/raw.c
> index 0d896ca7b589..625f3a917e50 100644
> --- a/net/ipv6/raw.c
> +++ b/net/ipv6/raw.c
> @@ -621,7 +621,7 @@ static int rawv6_send_hdrinc(struct sock *sk, struct msghdr *msg, int length,
>  	skb->protocol = htons(ETH_P_IPV6);
>  	skb->priority = READ_ONCE(sk->sk_priority);
>  	skb->mark = sockc->mark;
> -	skb->tstamp = sockc->transmit_time;
> +	skb_set_delivery_time(skb, sockc->transmit_time, sk->sk_clockid);
>  
>  	skb_put(skb, length);
>  	skb_reset_network_header(skb);
> diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
> index 8c6d3fbb4ed8..356c96f23370 100644
> --- a/net/packet/af_packet.c
> +++ b/net/packet/af_packet.c
> @@ -2056,8 +2056,7 @@ static int packet_sendmsg_spkt(struct socket *sock, struct msghdr *msg,
>  	skb->dev = dev;
>  	skb->priority = READ_ONCE(sk->sk_priority);
>  	skb->mark = READ_ONCE(sk->sk_mark);
> -	skb->tstamp = sockc.transmit_time;
> -
> +	skb_set_delivery_time(skb, sockc.transmit_time, sk->sk_clockid);
>  	skb_setup_tx_timestamp(skb, sockc.tsflags);
>  
>  	if (unlikely(extra_len == 4))
> @@ -2585,7 +2584,7 @@ static int tpacket_fill_skb(struct packet_sock *po, struct sk_buff *skb,
>  	skb->dev = dev;
>  	skb->priority = READ_ONCE(po->sk.sk_priority);
>  	skb->mark = READ_ONCE(po->sk.sk_mark);
> -	skb->tstamp = sockc->transmit_time;
> +	skb_set_delivery_time(skb, sockc->transmit_time, po->sk.sk_clockid);
>  	skb_setup_tx_timestamp(skb, sockc->tsflags);
>  	skb_zcopy_set_nouarg(skb, ph.raw);
>  
> @@ -3063,7 +3062,7 @@ static int packet_snd(struct socket *sock, struct msghdr *msg, size_t len)
>  	skb->dev = dev;
>  	skb->priority = READ_ONCE(sk->sk_priority);
>  	skb->mark = sockc.mark;
> -	skb->tstamp = sockc.transmit_time;
> +	skb_set_delivery_time(skb, sockc.transmit_time, sk->sk_clockid);
>  
>  	if (unlikely(extra_len == 4))
>  		skb->no_fcs = 1;
> diff --git a/tools/testing/selftests/bpf/prog_tests/ctx_rewrite.c b/tools/testing/selftests/bpf/prog_tests/ctx_rewrite.c
> index 3b7c57fe55a5..d7f58d9671f7 100644
> --- a/tools/testing/selftests/bpf/prog_tests/ctx_rewrite.c
> +++ b/tools/testing/selftests/bpf/prog_tests/ctx_rewrite.c
> @@ -69,15 +69,15 @@ static struct test_case test_cases[] = {
>  	{
>  		N(SCHED_CLS, struct __sk_buff, tstamp),
>  		.read  = "r11 = *(u8 *)($ctx + sk_buff::__mono_tc_offset);"
> -			 "w11 &= 3;"
> -			 "if w11 != 0x3 goto pc+2;"
> +			 "w11 &= 5;"
> +			 "if w11 != 0x5 goto pc+2;"
>  			 "$dst = 0;"
>  			 "goto pc+1;"
>  			 "$dst = *(u64 *)($ctx + sk_buff::tstamp);",
>  		.write = "r11 = *(u8 *)($ctx + sk_buff::__mono_tc_offset);"
> -			 "if w11 & 0x2 goto pc+1;"
> +			 "if w11 & 0x4 goto pc+1;"
>  			 "goto pc+2;"
> -			 "w11 &= -2;"
> +			 "w11 &= -4;"
>  			 "*(u8 *)($ctx + sk_buff::__mono_tc_offset) = r11;"
>  			 "*(u64 *)($ctx + sk_buff::tstamp) = $src;",
>  	},

