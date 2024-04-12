Return-Path: <bpf+bounces-26656-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F5A08A3779
	for <lists+bpf@lfdr.de>; Fri, 12 Apr 2024 23:02:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0569C28193D
	for <lists+bpf@lfdr.de>; Fri, 12 Apr 2024 21:02:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D41AB1514EC;
	Fri, 12 Apr 2024 21:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="GjRf+3Ui"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9F1D5478B;
	Fri, 12 Apr 2024 21:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712955722; cv=none; b=IbeIwy9j6KYTVIqr8nVtWL4bHdudU1UXPPzuyGs43sEBNEdTtMr0smDeyCkmjBC8Ev5h6cF1gT/YS/p59yaWprZc6QsM2Bv9nle9vtfKGsbt/6q3Py66dWikvZ20nOhvQoaFSZSsofCiFOT4JyfnAsz4io6cN3bLTHW9eyd76wA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712955722; c=relaxed/simple;
	bh=0x/EoBjI9waZ/NUa9EZGkG+ngfzqx10K+RKaVm+5kXI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mM1FfXpsUHCfxk4t9uCMbM8rNAtegEU4XZK4r/DTpuX5JEnxfcEvTxQ/b9SI0ZE4KgPVsQDiT5B16A5wMSl4P7kgPFwgrjnkbgsZX4EZ6ANypRR5TaAvIjkvTTLs/0f9uCHDaFtJCUmIOeb9sNvc5LMZeysDLbubtgoRZiniXmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=GjRf+3Ui; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43CL1SYw027882;
	Fri, 12 Apr 2024 21:01:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=qcppdkim1; bh=gF+cHU0
	Fy6WCALimya0ZKPqqsLiCBe1XKopnHc2p9xY=; b=GjRf+3UiCco5XdZgUWshjk+
	2xBpUsOLavvp3SNA2JCbgxdnsFy6/YQIePLms27bF4ASCczioa7SNCZoqb0Yn43u
	XPRK6R0lM+0utY+guM6hUV5Ow5FBaN3x/AZvTsQ4aol/gU2TZmyeFmlCPqroyjXv
	RbSBhyfEHQT4swh0CBCjKHHnwSb4ZoNRCcXiHuLtSytp+Mhe3GkOGeOeBRm8zsfd
	XuozURTAg/7AqWmSkQl1TAU27U9ahWHwHSPQh9rXpu3VHCkm25ORLyRvSEWcFNX2
	mlrXl4i4JYYlkbmYssuLQMVsPhf1D6yrVNyDcnLky42Wr5PtgJLFYkieJIj4cDA=
	=
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xf865rxp6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Apr 2024 21:01:28 +0000 (GMT)
Received: from pps.filterd (NALASPPMTA01.qualcomm.com [127.0.0.1])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 43CL1Q4V032154;
	Fri, 12 Apr 2024 21:01:26 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by NALASPPMTA01.qualcomm.com (PPS) with ESMTPS id 3xdpryd24b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Apr 2024 21:01:26 +0000
Received: from NALASPPMTA01.qualcomm.com (NALASPPMTA01.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 43CL02xP030338;
	Fri, 12 Apr 2024 21:01:26 GMT
Received: from hu-devc-lv-u20-a-new.qualcomm.com (hu-abchauha-lv.qualcomm.com [10.81.25.35])
	by NALASPPMTA01.qualcomm.com (PPS) with ESMTPS id 43CL1QJf032146
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Apr 2024 21:01:26 +0000
Received: by hu-devc-lv-u20-a-new.qualcomm.com (Postfix, from userid 214165)
	id 337D9226F6; Fri, 12 Apr 2024 14:01:25 -0700 (PDT)
From: Abhishek Chauhan <quic_abchauha@quicinc.com>
To: "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Andrew Halaney <ahalaney@redhat.com>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Daniel Borkmann <daniel@iogearbox.net>, bpf <bpf@vger.kernel.org>
Cc: kernel@quicinc.com
Subject: [RFC PATCH bpf-next v3 2/2] net: Add additional bit to support userspace timestamp type
Date: Fri, 12 Apr 2024 14:01:25 -0700
Message-Id: <20240412210125.1780574-3-quic_abchauha@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240412210125.1780574-1-quic_abchauha@quicinc.com>
References: <20240412210125.1780574-1-quic_abchauha@quicinc.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: XHke7AOIrChdKlzfSTufgPfizLHtYJGn
X-Proofpoint-GUID: XHke7AOIrChdKlzfSTufgPfizLHtYJGn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-12_17,2024-04-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 adultscore=0
 impostorscore=0 suspectscore=0 bulkscore=0 priorityscore=1501
 malwarescore=0 mlxscore=0 lowpriorityscore=0 phishscore=0 clxscore=1015
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404120151

tstamp_type can be real, mono or userspace timestamp.

This commit adds userspace timestamp and sets it if there is
valid transmit_time available in socket coming from userspace.

To make the design scalable for future needs this commit bring in
the change to extend the tstamp_type:1 to tstamp_type:2 to support
userspace timestamp.

Link: https://lore.kernel.org/netdev/bc037db4-58bb-4861-ac31-a361a93841d3@linux.dev/
Signed-off-by: Abhishek Chauhan <quic_abchauha@quicinc.com>
---
Changes since v2
- Minor changes to commit subject

Changes since v1 
- identified additional changes in BPF framework.
- Bit shift in SKB_MONO_DELIVERY_TIME_MASK and TC_AT_INGRESS_MASK.
- Made changes in skb_set_delivery_time to keep changes similar to 
  previous code for mono_delivery_time and just setting tstamp_type
  bit 1 for userspace timestamp.


 include/linux/skbuff.h                        | 19 +++++++++++++++----
 net/ipv4/ip_output.c                          |  2 +-
 net/ipv4/raw.c                                |  2 +-
 net/ipv6/ip6_output.c                         |  2 +-
 net/ipv6/raw.c                                |  2 +-
 net/packet/af_packet.c                        |  7 +++----
 .../selftests/bpf/prog_tests/ctx_rewrite.c    |  8 ++++----
 7 files changed, 26 insertions(+), 16 deletions(-)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index a83a2120b57f..b6346c21c3d4 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -827,7 +827,8 @@ enum skb_tstamp_type {
  *	@tstamp_type: When set, skb->tstamp has the
  *		delivery_time in mono clock base (i.e. EDT).  Otherwise, the
  *		skb->tstamp has the (rcv) timestamp at ingress and
- *		delivery_time at egress.
+ *		delivery_time at egress or skb->tstamp defined by skb->sk->sk_clockid
+ *		coming from userspace
  *	@napi_id: id of the NAPI struct this skb came from
  *	@sender_cpu: (aka @napi_id) source CPU in XPS
  *	@alloc_cpu: CPU which did the skb allocation.
@@ -955,7 +956,7 @@ struct sk_buff {
 	/* private: */
 	__u8			__mono_tc_offset[0];
 	/* public: */
-	__u8			tstamp_type:1;	/* See SKB_MONO_DELIVERY_TIME_MASK */
+	__u8			tstamp_type:2;	/* See SKB_MONO_DELIVERY_TIME_MASK */
 #ifdef CONFIG_NET_XGRESS
 	__u8			tc_at_ingress:1;	/* See TC_AT_INGRESS_MASK */
 	__u8			tc_skip_classify:1;
@@ -1090,10 +1091,10 @@ struct sk_buff {
  */
 #ifdef __BIG_ENDIAN_BITFIELD
 #define SKB_MONO_DELIVERY_TIME_MASK	(1 << 7)
-#define TC_AT_INGRESS_MASK		(1 << 6)
+#define TC_AT_INGRESS_MASK		(1 << 5)
 #else
 #define SKB_MONO_DELIVERY_TIME_MASK	(1 << 0)
-#define TC_AT_INGRESS_MASK		(1 << 1)
+#define TC_AT_INGRESS_MASK		(1 << 2)
 #endif
 #define SKB_BF_MONO_TC_OFFSET		offsetof(struct sk_buff, __mono_tc_offset)
 
@@ -4262,6 +4263,16 @@ static inline void skb_set_delivery_time(struct sk_buff *skb, ktime_t kt,
 	case CLOCK_MONO:
 		skb->tstamp_type = kt && tstamp_type;
 		break;
+	/* if any other time base, must be from userspace
+	 * so set userspace tstamp_type bit
+	 * See skbuff tstamp_type:2
+	 * 0x0 => real timestamp_type
+	 * 0x1 => mono timestamp_type
+	 * 0x2 => timestamp_type set from userspace
+	 */
+	default:
+		if (kt && tstamp_type)
+			skb->tstamp_type = 0x2;
 	}
 }
 
diff --git a/net/ipv4/ip_output.c b/net/ipv4/ip_output.c
index 62e457f7c02c..c9317d4addce 100644
--- a/net/ipv4/ip_output.c
+++ b/net/ipv4/ip_output.c
@@ -1457,7 +1457,7 @@ struct sk_buff *__ip_make_skb(struct sock *sk,
 
 	skb->priority = (cork->tos != -1) ? cork->priority: READ_ONCE(sk->sk_priority);
 	skb->mark = cork->mark;
-	skb->tstamp = cork->transmit_time;
+	skb_set_delivery_time(skb, cork->transmit_time, sk->sk_clockid);
 	/*
 	 * Steal rt from cork.dst to avoid a pair of atomic_inc/atomic_dec
 	 * on dst refcount
diff --git a/net/ipv4/raw.c b/net/ipv4/raw.c
index dcb11f22cbf2..bbc46a40c8b6 100644
--- a/net/ipv4/raw.c
+++ b/net/ipv4/raw.c
@@ -360,7 +360,7 @@ static int raw_send_hdrinc(struct sock *sk, struct flowi4 *fl4,
 	skb->protocol = htons(ETH_P_IP);
 	skb->priority = READ_ONCE(sk->sk_priority);
 	skb->mark = sockc->mark;
-	skb->tstamp = sockc->transmit_time;
+	skb_set_delivery_time(skb, sockc->transmit_time, sk->sk_clockid);
 	skb_dst_set(skb, &rt->dst);
 	*rtp = NULL;
 
diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
index a9e819115622..0b8193bdd98f 100644
--- a/net/ipv6/ip6_output.c
+++ b/net/ipv6/ip6_output.c
@@ -1924,7 +1924,7 @@ struct sk_buff *__ip6_make_skb(struct sock *sk,
 
 	skb->priority = READ_ONCE(sk->sk_priority);
 	skb->mark = cork->base.mark;
-	skb->tstamp = cork->base.transmit_time;
+	skb_set_delivery_time(skb, cork->base.transmit_time, sk->sk_clockid);
 
 	ip6_cork_steal_dst(skb, cork);
 	IP6_INC_STATS(net, rt->rt6i_idev, IPSTATS_MIB_OUTREQUESTS);
diff --git a/net/ipv6/raw.c b/net/ipv6/raw.c
index 0d896ca7b589..625f3a917e50 100644
--- a/net/ipv6/raw.c
+++ b/net/ipv6/raw.c
@@ -621,7 +621,7 @@ static int rawv6_send_hdrinc(struct sock *sk, struct msghdr *msg, int length,
 	skb->protocol = htons(ETH_P_IPV6);
 	skb->priority = READ_ONCE(sk->sk_priority);
 	skb->mark = sockc->mark;
-	skb->tstamp = sockc->transmit_time;
+	skb_set_delivery_time(skb, sockc->transmit_time, sk->sk_clockid);
 
 	skb_put(skb, length);
 	skb_reset_network_header(skb);
diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
index 8c6d3fbb4ed8..356c96f23370 100644
--- a/net/packet/af_packet.c
+++ b/net/packet/af_packet.c
@@ -2056,8 +2056,7 @@ static int packet_sendmsg_spkt(struct socket *sock, struct msghdr *msg,
 	skb->dev = dev;
 	skb->priority = READ_ONCE(sk->sk_priority);
 	skb->mark = READ_ONCE(sk->sk_mark);
-	skb->tstamp = sockc.transmit_time;
-
+	skb_set_delivery_time(skb, sockc.transmit_time, sk->sk_clockid);
 	skb_setup_tx_timestamp(skb, sockc.tsflags);
 
 	if (unlikely(extra_len == 4))
@@ -2585,7 +2584,7 @@ static int tpacket_fill_skb(struct packet_sock *po, struct sk_buff *skb,
 	skb->dev = dev;
 	skb->priority = READ_ONCE(po->sk.sk_priority);
 	skb->mark = READ_ONCE(po->sk.sk_mark);
-	skb->tstamp = sockc->transmit_time;
+	skb_set_delivery_time(skb, sockc->transmit_time, po->sk.sk_clockid);
 	skb_setup_tx_timestamp(skb, sockc->tsflags);
 	skb_zcopy_set_nouarg(skb, ph.raw);
 
@@ -3063,7 +3062,7 @@ static int packet_snd(struct socket *sock, struct msghdr *msg, size_t len)
 	skb->dev = dev;
 	skb->priority = READ_ONCE(sk->sk_priority);
 	skb->mark = sockc.mark;
-	skb->tstamp = sockc.transmit_time;
+	skb_set_delivery_time(skb, sockc.transmit_time, sk->sk_clockid);
 
 	if (unlikely(extra_len == 4))
 		skb->no_fcs = 1;
diff --git a/tools/testing/selftests/bpf/prog_tests/ctx_rewrite.c b/tools/testing/selftests/bpf/prog_tests/ctx_rewrite.c
index 3b7c57fe55a5..d7f58d9671f7 100644
--- a/tools/testing/selftests/bpf/prog_tests/ctx_rewrite.c
+++ b/tools/testing/selftests/bpf/prog_tests/ctx_rewrite.c
@@ -69,15 +69,15 @@ static struct test_case test_cases[] = {
 	{
 		N(SCHED_CLS, struct __sk_buff, tstamp),
 		.read  = "r11 = *(u8 *)($ctx + sk_buff::__mono_tc_offset);"
-			 "w11 &= 3;"
-			 "if w11 != 0x3 goto pc+2;"
+			 "w11 &= 5;"
+			 "if w11 != 0x5 goto pc+2;"
 			 "$dst = 0;"
 			 "goto pc+1;"
 			 "$dst = *(u64 *)($ctx + sk_buff::tstamp);",
 		.write = "r11 = *(u8 *)($ctx + sk_buff::__mono_tc_offset);"
-			 "if w11 & 0x2 goto pc+1;"
+			 "if w11 & 0x4 goto pc+1;"
 			 "goto pc+2;"
-			 "w11 &= -2;"
+			 "w11 &= -4;"
 			 "*(u8 *)($ctx + sk_buff::__mono_tc_offset) = r11;"
 			 "*(u64 *)($ctx + sk_buff::tstamp) = $src;",
 	},
-- 
2.25.1


