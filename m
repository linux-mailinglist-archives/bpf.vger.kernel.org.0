Return-Path: <bpf+bounces-26325-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D31489E4C7
	for <lists+bpf@lfdr.de>; Tue,  9 Apr 2024 23:07:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60CFE1C218A7
	for <lists+bpf@lfdr.de>; Tue,  9 Apr 2024 21:07:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B64A158867;
	Tue,  9 Apr 2024 21:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="h9jSXXOx"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51122158A0A;
	Tue,  9 Apr 2024 21:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712696775; cv=none; b=jfKP7ktnqMbwa1JzfHfJsfgA9u8F3apT3zJALPWWRhPEgDVC0S6BdGDGF+fV3EEmtfRKi+kzDio8fS1oP26AG/j9iocLwwFv7l6CasNZr4rMgvpwmWSWZF8T3ojj/tvcboGQJZg8GZTGMeG6dnWTLgt4Ch3qTcN8LPK7pKvyc3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712696775; c=relaxed/simple;
	bh=IXZ3wehDL47oIrDVEqc1to7GI/Ih+JeeuxlsU4odIjQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tVO3xWq+BeXvmmxRyhOazq59Aj4bDrD/4t1zKazXpd+1xCkywH6hIz+0dEjSZ+Ui486xSYwtQ0WaPYR9a+5rK521fLr3ugfCAIY6m1TyZYf52ifzOU5S0jpUM58OPweqM9ulhML3F2tgC3RE4R4yanm/hy297Z1/kp2kM8pxO+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=h9jSXXOx; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 439L09BY004107;
	Tue, 9 Apr 2024 21:05:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=qcppdkim1; bh=nGD4Cy8
	CEtmS0/ua8iwCgBBYBbeQ8uQnKTFsG8Fp0PU=; b=h9jSXXOxYB6OUqDO3t29tGn
	iPUd1zCvK1mJR147XkVA4/KT9FdsvYwIVhMmFfruIwN8iCES66rT4lh1LpYA2On1
	ZdG0IF1WCBN0+/+/N7nhPXtJsfcloZ1r8ptyvzySWkswmswebf6eMRKLK/XQxcKF
	s8LjcgqaigyhYJv8N9Bh5twr//dcw78+y3Q503Eb1pGVjgvnWk40lrVBBpyW8WPB
	iJ6GUQcims4r2HK1Ayf5gZ6JEelWh4EN+LPJbfAXT74O1GL/2M3IjF+nZISUo/OJ
	PR8n77ONVa9xlZq2LxqesvZSFAlZL9hQ6oPpGft3kBWC9vHfuY+xqzJUELvpRow=
	=
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xd3dy9f7t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Apr 2024 21:05:49 +0000 (GMT)
Received: from pps.filterd (NALASPPMTA03.qualcomm.com [127.0.0.1])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 439L5lFe011042;
	Tue, 9 Apr 2024 21:05:47 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by NALASPPMTA03.qualcomm.com (PPS) with ESMTPS id 3xayfmu59f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Apr 2024 21:05:47 +0000
Received: from NALASPPMTA03.qualcomm.com (NALASPPMTA03.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 439L5liw011037;
	Tue, 9 Apr 2024 21:05:47 GMT
Received: from hu-devc-lv-u20-a-new.qualcomm.com (hu-abchauha-lv.qualcomm.com [10.81.25.35])
	by NALASPPMTA03.qualcomm.com (PPS) with ESMTPS id 439L5lRv011034
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Apr 2024 21:05:47 +0000
Received: by hu-devc-lv-u20-a-new.qualcomm.com (Postfix, from userid 214165)
	id 56B8623333; Tue,  9 Apr 2024 14:05:47 -0700 (PDT)
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
Subject: [RFC PATCH bpf-next v1 3/3] net: Add additional bit to support userspace timestamp type
Date: Tue,  9 Apr 2024 14:05:47 -0700
Message-Id: <20240409210547.3815806-4-quic_abchauha@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240409210547.3815806-1-quic_abchauha@quicinc.com>
References: <20240409210547.3815806-1-quic_abchauha@quicinc.com>
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
X-Proofpoint-GUID: -EKcwDbQRFfTQzYiGhKFhhFFgCttyLFq
X-Proofpoint-ORIG-GUID: -EKcwDbQRFfTQzYiGhKFhhFFgCttyLFq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-09_12,2024-04-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 malwarescore=0 impostorscore=0 phishscore=0 bulkscore=0 clxscore=1015
 adultscore=0 spamscore=0 lowpriorityscore=0 suspectscore=0
 priorityscore=1501 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2404010003 definitions=main-2404090142

tstamp_type can be real, mono or userspace timestamp.

This commit adds userspace timestamp and sets it if there is
valid transmit_time available in socket coming from userspace.

To make the design scalable for future needs this commit bring in
the change to extend the tstamp_type:1 to tstamp_type:2 to support
userspace timestamp.

Link: https://lore.kernel.org/netdev/bc037db4-58bb-4861-ac31-a361a93841d3@linux.dev/
Signed-off-by: Abhishek Chauhan <quic_abchauha@quicinc.com>
---
 include/linux/skbuff.h | 19 +++++++++++++++++--
 net/ipv4/ip_output.c   |  2 +-
 net/ipv4/raw.c         |  2 +-
 net/ipv6/ip6_output.c  |  2 +-
 net/ipv6/raw.c         |  2 +-
 net/packet/af_packet.c |  6 +++---
 6 files changed, 24 insertions(+), 9 deletions(-)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 6160185f0fe0..2f91a8a2157a 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -705,6 +705,9 @@ typedef unsigned char *sk_buff_data_t;
 enum skb_tstamp_type {
 	SKB_TSTAMP_TYPE_RX_REAL = 0,    /* A RX (receive) time in real */
 	SKB_TSTAMP_TYPE_TX_MONO = 1,    /* A TX (delivery) time in mono */
+	SKB_TSTAMP_TYPE_TX_USER = 2,    /* A TX (delivery) time and its clock
+									 * is in skb->sk->sk_clockid.
+									 */
 };
 
 /**
@@ -830,6 +833,9 @@ enum skb_tstamp_type {
  *		delivery_time in mono clock base (i.e. EDT).  Otherwise, the
  *		skb->tstamp has the (rcv) timestamp at ingress and
  *		delivery_time at egress.
+ *		delivery_time in mono clock base (i.e., EDT) or a clock base chosen
+ *		by SO_TXTIME. If zero, skb->tstamp has the (rcv) timestamp at
+ *		ingress.
  *	@napi_id: id of the NAPI struct this skb came from
  *	@sender_cpu: (aka @napi_id) source CPU in XPS
  *	@alloc_cpu: CPU which did the skb allocation.
@@ -960,7 +966,7 @@ struct sk_buff {
 	/* private: */
 	__u8			__mono_tc_offset[0];
 	/* public: */
-	__u8			tstamp_type:1;	/* See SKB_MONO_DELIVERY_TIME_MASK */
+	__u8			tstamp_type:2;	/* See SKB_MONO_DELIVERY_TIME_MASK */
 #ifdef CONFIG_NET_XGRESS
 	__u8			tc_at_ingress:1;	/* See TC_AT_INGRESS_MASK */
 	__u8			tc_skip_classify:1;
@@ -4274,7 +4280,16 @@ static inline void skb_set_delivery_time(struct sk_buff *skb, ktime_t kt,
 					enum skb_tstamp_type tstamp_type)
 {
 	skb->tstamp = kt;
-	skb->tstamp_type = kt && tstamp_type;
+
+	if (skb->tstamp_type)
+		return;
+
+	if (kt && tstamp_type == SKB_TSTAMP_TYPE_TX_MONO)
+		skb->tstamp_type = SKB_TSTAMP_TYPE_TX_MONO;
+
+	if (kt && tstamp_type == SKB_TSTAMP_TYPE_TX_USER)
+		skb->tstamp_type = SKB_TSTAMP_TYPE_TX_USER;
+
 }
 
 DECLARE_STATIC_KEY_FALSE(netstamp_needed_key);
diff --git a/net/ipv4/ip_output.c b/net/ipv4/ip_output.c
index 62e457f7c02c..9aea6e810f52 100644
--- a/net/ipv4/ip_output.c
+++ b/net/ipv4/ip_output.c
@@ -1457,7 +1457,7 @@ struct sk_buff *__ip_make_skb(struct sock *sk,
 
 	skb->priority = (cork->tos != -1) ? cork->priority: READ_ONCE(sk->sk_priority);
 	skb->mark = cork->mark;
-	skb->tstamp = cork->transmit_time;
+	skb_set_delivery_time(skb, cork->transmit_time, SKB_TSTAMP_TYPE_TX_USER);
 	/*
 	 * Steal rt from cork.dst to avoid a pair of atomic_inc/atomic_dec
 	 * on dst refcount
diff --git a/net/ipv4/raw.c b/net/ipv4/raw.c
index dcb11f22cbf2..d8f52bc06ed3 100644
--- a/net/ipv4/raw.c
+++ b/net/ipv4/raw.c
@@ -360,7 +360,7 @@ static int raw_send_hdrinc(struct sock *sk, struct flowi4 *fl4,
 	skb->protocol = htons(ETH_P_IP);
 	skb->priority = READ_ONCE(sk->sk_priority);
 	skb->mark = sockc->mark;
-	skb->tstamp = sockc->transmit_time;
+	skb_set_delivery_time(skb, sockc->transmit_time, SKB_TSTAMP_TYPE_TX_USER);
 	skb_dst_set(skb, &rt->dst);
 	*rtp = NULL;
 
diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
index a9e819115622..2beb9fc8c0b1 100644
--- a/net/ipv6/ip6_output.c
+++ b/net/ipv6/ip6_output.c
@@ -1924,7 +1924,7 @@ struct sk_buff *__ip6_make_skb(struct sock *sk,
 
 	skb->priority = READ_ONCE(sk->sk_priority);
 	skb->mark = cork->base.mark;
-	skb->tstamp = cork->base.transmit_time;
+	skb_set_delivery_time(skb, cork->base.transmit_time, SKB_TSTAMP_TYPE_TX_USER);
 
 	ip6_cork_steal_dst(skb, cork);
 	IP6_INC_STATS(net, rt->rt6i_idev, IPSTATS_MIB_OUTREQUESTS);
diff --git a/net/ipv6/raw.c b/net/ipv6/raw.c
index 0d896ca7b589..3a68ca80bf83 100644
--- a/net/ipv6/raw.c
+++ b/net/ipv6/raw.c
@@ -621,7 +621,7 @@ static int rawv6_send_hdrinc(struct sock *sk, struct msghdr *msg, int length,
 	skb->protocol = htons(ETH_P_IPV6);
 	skb->priority = READ_ONCE(sk->sk_priority);
 	skb->mark = sockc->mark;
-	skb->tstamp = sockc->transmit_time;
+	skb_set_delivery_time(skb, sockc->transmit_time, SKB_TSTAMP_TYPE_TX_USER);
 
 	skb_put(skb, length);
 	skb_reset_network_header(skb);
diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
index 18f616f487ea..27ea972dfc56 100644
--- a/net/packet/af_packet.c
+++ b/net/packet/af_packet.c
@@ -2056,7 +2056,7 @@ static int packet_sendmsg_spkt(struct socket *sock, struct msghdr *msg,
 	skb->dev = dev;
 	skb->priority = READ_ONCE(sk->sk_priority);
 	skb->mark = READ_ONCE(sk->sk_mark);
-	skb->tstamp = sockc.transmit_time;
+	skb_set_delivery_time(skb, sockc.transmit_time, SKB_TSTAMP_TYPE_TX_USER);
 
 	skb_setup_tx_timestamp(skb, sockc.tsflags);
 
@@ -2585,7 +2585,7 @@ static int tpacket_fill_skb(struct packet_sock *po, struct sk_buff *skb,
 	skb->dev = dev;
 	skb->priority = READ_ONCE(po->sk.sk_priority);
 	skb->mark = READ_ONCE(po->sk.sk_mark);
-	skb->tstamp = sockc->transmit_time;
+	skb_set_delivery_time(skb, sockc->transmit_time, SKB_TSTAMP_TYPE_TX_USER);
 	skb_setup_tx_timestamp(skb, sockc->tsflags);
 	skb_zcopy_set_nouarg(skb, ph.raw);
 
@@ -3063,7 +3063,7 @@ static int packet_snd(struct socket *sock, struct msghdr *msg, size_t len)
 	skb->dev = dev;
 	skb->priority = READ_ONCE(sk->sk_priority);
 	skb->mark = sockc.mark;
-	skb->tstamp = sockc.transmit_time;
+	skb_set_delivery_time(skb, sockc.transmit_time, SKB_TSTAMP_TYPE_TX_USER);
 
 	if (unlikely(extra_len == 4))
 		skb->no_fcs = 1;
-- 
2.25.1


