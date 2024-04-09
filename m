Return-Path: <bpf+bounces-26323-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5A6B89E4C2
	for <lists+bpf@lfdr.de>; Tue,  9 Apr 2024 23:06:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 04DA0B21F4C
	for <lists+bpf@lfdr.de>; Tue,  9 Apr 2024 21:06:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A1DF158A32;
	Tue,  9 Apr 2024 21:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="AaHiQ+/N"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF7BD8562A;
	Tue,  9 Apr 2024 21:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712696773; cv=none; b=H3f5/WBlSTmz/AtRe4HmcSDDwqrr8R3l/v6TmdDA0GFMTIb5zW4vFCHZPXcmOVFKECfgfvqjyI2fh3Kz7RSuzSH+YHPd70UkZ7f3Bc9djix/WH6pxVlv1w2YM6B9fGxTJ8GVyQgZqc0M/pWVl88XV3yIbFSEXzD1tuJdW9WE7Uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712696773; c=relaxed/simple;
	bh=Zs61D8klnaksJkO+RXfsCjKfhcByQNHAkzLwDigG70A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QuwBP1d+quht9VlMl2bfRj+OUrSnfyGi9TjAuEIirdBoKqotUcJZ8FJzW/FbG4BWrFNlktd2UYPmGc+f/Dnb784UA+N5+ek59UEZ31BUc8VRyo5/L2GzHmq/BpZl/idzFQnroFXm0Gs8/MQz1hwHh34K48Mcf2QgMvr8Zurj6Dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=AaHiQ+/N; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 439KwY62003494;
	Tue, 9 Apr 2024 21:05:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=qcppdkim1; bh=z9ZbtdF
	yPYI+LMQA/vOH1sFmLCrcsdeNL6PUWHukUIQ=; b=AaHiQ+/Njfj8fFOGednUk1B
	U6NEm4NCFAivGnyLZbZFHqgwI8B4AYU1IP5SQnbqEMdIHVX/2SLO9KMBb/mEPSiA
	wV6KAzC+u+Ax00VJCPQ+eGrLO0WeU8STdmqgDLuBhssFPhH7Cxvj21lcyRVwy6h3
	iNWVxsn/VrV9sPGWntDVwGMHtp6rODoxhW0oHFm2/qrjCOHWXtg26PTEDkf6/4qK
	epVeGEKGYb4mKNh7pZg3J2bSGS9H+iS4OWCD6wLvoGD02nJ8Ign5yAbHV8pa9LIo
	K4nuo/GLsPEO0bAnJKijfpP93YglcioiDsus+TGOpmm9hUMRYf5SWC/eVRfoVyg=
	=
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xd3bshfpq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Apr 2024 21:05:49 +0000 (GMT)
Received: from pps.filterd (NALASPPMTA05.qualcomm.com [127.0.0.1])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 439L4Vnf009925;
	Tue, 9 Apr 2024 21:05:48 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by NALASPPMTA05.qualcomm.com (PPS) with ESMTPS id 3xayfmb91f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Apr 2024 21:05:48 +0000
Received: from NALASPPMTA05.qualcomm.com (NALASPPMTA05.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 439L5lAe011048;
	Tue, 9 Apr 2024 21:05:47 GMT
Received: from hu-devc-lv-u20-a-new.qualcomm.com (hu-abchauha-lv.qualcomm.com [10.81.25.35])
	by NALASPPMTA05.qualcomm.com (PPS) with ESMTPS id 439L5ltb011045
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Apr 2024 21:05:47 +0000
Received: by hu-devc-lv-u20-a-new.qualcomm.com (Postfix, from userid 214165)
	id 53E50232DB; Tue,  9 Apr 2024 14:05:47 -0700 (PDT)
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
Subject: [RFC PATCH bpf-next v1 2/3] net: assign enum to skb->tstamp_type to distinguish between tstamp
Date: Tue,  9 Apr 2024 14:05:46 -0700
Message-Id: <20240409210547.3815806-3-quic_abchauha@quicinc.com>
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
X-Proofpoint-GUID: zrqWdhbS-HnMW_KMn9FSWdDv-rXv0NJV
X-Proofpoint-ORIG-GUID: zrqWdhbS-HnMW_KMn9FSWdDv-rXv0NJV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-09_12,2024-04-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 impostorscore=0 suspectscore=0 phishscore=0 priorityscore=1501
 lowpriorityscore=0 mlxlogscore=999 clxscore=1015 adultscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404090142

As we are renaming the mono_delivery_time to tstamp_type, it makes
sense to start assigning tstamp_type based out if enum defined as
part of this commit

Earlier we used bool arg flag to check if the tstamp is mono in
function skb_set_delivery_time, Now the signature of the functions
accepts enum to distinguish between mono and real time.

Link: https://lore.kernel.org/netdev/bc037db4-58bb-4861-ac31-a361a93841d3@linux.dev/
Signed-off-by: Abhishek Chauhan <quic_abchauha@quicinc.com>
---
 include/linux/skbuff.h                     | 13 +++++++++----
 net/bridge/netfilter/nf_conntrack_bridge.c |  2 +-
 net/core/dev.c                             |  2 +-
 net/core/filter.c                          |  4 ++--
 net/ipv4/ip_output.c                       |  2 +-
 net/ipv4/tcp_output.c                      | 14 +++++++-------
 net/ipv6/ip6_output.c                      |  2 +-
 net/ipv6/tcp_ipv6.c                        |  2 +-
 net/sched/act_bpf.c                        |  2 +-
 net/sched/cls_bpf.c                        |  2 +-
 10 files changed, 25 insertions(+), 20 deletions(-)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 8210d699d8e9..6160185f0fe0 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -701,6 +701,11 @@ typedef unsigned int sk_buff_data_t;
 #else
 typedef unsigned char *sk_buff_data_t;
 #endif
+


+enum skb_tstamp_type {
+	SKB_TSTAMP_TYPE_RX_REAL = 0,    /* A RX (receive) time in real */
+	SKB_TSTAMP_TYPE_TX_MONO = 1,    /* A TX (delivery) time in mono */
+};
 
 /**
  * DOC: Basic sk_buff geometry
@@ -4257,7 +4262,7 @@ static inline void skb_get_new_timestampns(const struct sk_buff *skb,
 static inline void __net_timestamp(struct sk_buff *skb)
 {
 	skb->tstamp = ktime_get_real();
-	skb->tstamp_type = 0;
+	skb->tstamp_type = SKB_TSTAMP_TYPE_RX_REAL;
 }
 
 static inline ktime_t net_timedelta(ktime_t t)
@@ -4266,10 +4271,10 @@ static inline ktime_t net_timedelta(ktime_t t)
 }
 
 static inline void skb_set_delivery_time(struct sk_buff *skb, ktime_t kt,
-					 bool mono)
+					enum skb_tstamp_type tstamp_type)
 {
 	skb->tstamp = kt;
-	skb->tstamp_type = kt && mono;
+	skb->tstamp_type = kt && tstamp_type;
 }
 
 DECLARE_STATIC_KEY_FALSE(netstamp_needed_key);
@@ -4280,7 +4285,7 @@ DECLARE_STATIC_KEY_FALSE(netstamp_needed_key);
 static inline void skb_clear_delivery_time(struct sk_buff *skb)
 {
 	if (skb->tstamp_type) {
-		skb->tstamp_type = 0;
+		skb->tstamp_type = SKB_TSTAMP_TYPE_RX_REAL;
 		if (static_branch_unlikely(&netstamp_needed_key))
 			skb->tstamp = ktime_get_real();
 		else
diff --git a/net/bridge/netfilter/nf_conntrack_bridge.c b/net/bridge/netfilter/nf_conntrack_bridge.c
index 989435bd1690..b970ab2279cf 100644
--- a/net/bridge/netfilter/nf_conntrack_bridge.c
+++ b/net/bridge/netfilter/nf_conntrack_bridge.c
@@ -32,7 +32,7 @@ static int nf_br_ip_fragment(struct net *net, struct sock *sk,
 					   struct sk_buff *))
 {
 	int frag_max_size = BR_INPUT_SKB_CB(skb)->frag_max_size;
-	bool tstamp_type = skb->tstamp_type;
+	u8 tstamp_type = skb->tstamp_type;
 	unsigned int hlen, ll_rs, mtu;
 	ktime_t tstamp = skb->tstamp;
 	struct ip_frag_state state;
diff --git a/net/core/dev.c b/net/core/dev.c
index 8b88f8118052..9a84156fab3c 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -2113,7 +2113,7 @@ EXPORT_SYMBOL(net_disable_timestamp);
 static inline void net_timestamp_set(struct sk_buff *skb)
 {
 	skb->tstamp = 0;
-	skb->tstamp_type = 0;
+	skb->tstamp_type = SKB_TSTAMP_TYPE_RX_REAL;
 	if (static_branch_unlikely(&netstamp_needed_key))
 		skb->tstamp = ktime_get_real();
 }
diff --git a/net/core/filter.c b/net/core/filter.c
index 0f535defdd2c..1c943a165c30 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -7698,13 +7698,13 @@ BPF_CALL_3(bpf_skb_set_tstamp, struct sk_buff *, skb,
 		if (!tstamp)
 			return -EINVAL;
 		skb->tstamp = tstamp;
-		skb->tstamp_type = 1;
+		skb->tstamp_type = SKB_TSTAMP_TYPE_TX_MONO;
 		break;
 	case BPF_SKB_TSTAMP_UNSPEC:
 		if (tstamp)
 			return -EINVAL;
 		skb->tstamp = 0;
-		skb->tstamp_type = 0;
+		skb->tstamp_type = SKB_TSTAMP_TYPE_RX_REAL;
 		break;
 	default:
 		return -EINVAL;
diff --git a/net/ipv4/ip_output.c b/net/ipv4/ip_output.c
index e8ec7e8ae2e0..62e457f7c02c 100644
--- a/net/ipv4/ip_output.c
+++ b/net/ipv4/ip_output.c
@@ -764,7 +764,7 @@ int ip_do_fragment(struct net *net, struct sock *sk, struct sk_buff *skb,
 {
 	struct iphdr *iph;
 	struct sk_buff *skb2;
-	bool tstamp_type = skb->tstamp_type;
+	u8 tstamp_type = skb->tstamp_type;
 	struct rtable *rt = skb_rtable(skb);
 	unsigned int mtu, hlen, ll_rs;
 	struct ip_fraglist_iter iter;
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index e3167ad96567..071fe377747a 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -1297,7 +1297,7 @@ static int __tcp_transmit_skb(struct sock *sk, struct sk_buff *skb,
 	tp = tcp_sk(sk);
 	prior_wstamp = tp->tcp_wstamp_ns;
 	tp->tcp_wstamp_ns = max(tp->tcp_wstamp_ns, tp->tcp_clock_cache);
-	skb_set_delivery_time(skb, tp->tcp_wstamp_ns, true);
+	skb_set_delivery_time(skb, tp->tcp_wstamp_ns, SKB_TSTAMP_TYPE_TX_MONO);
 	if (clone_it) {
 		oskb = skb;
 
@@ -1647,7 +1647,7 @@ int tcp_fragment(struct sock *sk, enum tcp_queue tcp_queue,
 
 	skb_split(skb, buff, len);
 
-	skb_set_delivery_time(buff, skb->tstamp, true);
+	skb_set_delivery_time(buff, skb->tstamp, SKB_TSTAMP_TYPE_TX_MONO);
 	tcp_fragment_tstamp(skb, buff);
 
 	old_factor = tcp_skb_pcount(skb);
@@ -2728,7 +2728,7 @@ static bool tcp_write_xmit(struct sock *sk, unsigned int mss_now, int nonagle,
 		if (unlikely(tp->repair) && tp->repair_queue == TCP_SEND_QUEUE) {
 			/* "skb_mstamp_ns" is used as a start point for the retransmit timer */
 			tp->tcp_wstamp_ns = tp->tcp_clock_cache;
-			skb_set_delivery_time(skb, tp->tcp_wstamp_ns, true);
+			skb_set_delivery_time(skb, tp->tcp_wstamp_ns, SKB_TSTAMP_TYPE_TX_MONO);
 			list_move_tail(&skb->tcp_tsorted_anchor, &tp->tsorted_sent_queue);
 			tcp_init_tso_segs(skb, mss_now);
 			goto repair; /* Skip network transmission */
@@ -3711,11 +3711,11 @@ struct sk_buff *tcp_make_synack(const struct sock *sk, struct dst_entry *dst,
 #ifdef CONFIG_SYN_COOKIES
 	if (unlikely(synack_type == TCP_SYNACK_COOKIE && ireq->tstamp_ok))
 		skb_set_delivery_time(skb, cookie_init_timestamp(req, now),
-				      true);
+				      SKB_TSTAMP_TYPE_TX_MONO);
 	else
 #endif
 	{
-		skb_set_delivery_time(skb, now, true);
+		skb_set_delivery_time(skb, now, SKB_TSTAMP_TYPE_TX_MONO);
 		if (!tcp_rsk(req)->snt_synack) /* Timestamp first SYNACK */
 			tcp_rsk(req)->snt_synack = tcp_skb_timestamp_us(skb);
 	}
@@ -3802,7 +3802,7 @@ struct sk_buff *tcp_make_synack(const struct sock *sk, struct dst_entry *dst,
 	bpf_skops_write_hdr_opt((struct sock *)sk, skb, req, syn_skb,
 				synack_type, &opts);
 
-	skb_set_delivery_time(skb, now, true);
+	skb_set_delivery_time(skb, now, SKB_TSTAMP_TYPE_TX_MONO);
 	tcp_add_tx_delay(skb, tp);
 
 	return skb;
@@ -3986,7 +3986,7 @@ static int tcp_send_syn_data(struct sock *sk, struct sk_buff *syn)
 
 	err = tcp_transmit_skb(sk, syn_data, 1, sk->sk_allocation);
 
-	skb_set_delivery_time(syn, syn_data->skb_mstamp_ns, true);
+	skb_set_delivery_time(syn, syn_data->skb_mstamp_ns, SKB_TSTAMP_TYPE_TX_MONO);
 
 	/* Now full SYN+DATA was cloned and sent (or not),
 	 * remove the SYN from the original skb (syn_data)
diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
index 61ddc9549160..a9e819115622 100644
--- a/net/ipv6/ip6_output.c
+++ b/net/ipv6/ip6_output.c
@@ -859,7 +859,7 @@ int ip6_fragment(struct net *net, struct sock *sk, struct sk_buff *skb,
 	struct rt6_info *rt = (struct rt6_info *)skb_dst(skb);
 	struct ipv6_pinfo *np = skb->sk && !dev_recursion_level() ?
 				inet6_sk(skb->sk) : NULL;
-	bool tstamp_type = skb->tstamp_type;
+	u8 tstamp_type = skb->tstamp_type;
 	struct ip6_frag_state state;
 	unsigned int mtu, hlen, nexthdr_offset;
 	ktime_t tstamp = skb->tstamp;
diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index 3f4cba49e9ee..a9bf9c630582 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -973,7 +973,7 @@ static void tcp_v6_send_response(const struct sock *sk, struct sk_buff *skb, u32
 			mark = inet_twsk(sk)->tw_mark;
 		else
 			mark = READ_ONCE(sk->sk_mark);
-		skb_set_delivery_time(buff, tcp_transmit_time(sk), true);
+		skb_set_delivery_time(buff, tcp_transmit_time(sk), SKB_TSTAMP_TYPE_TX_MONO);
 	}
 	if (txhash) {
 		/* autoflowlabel/skb_get_hash_flowi6 rely on buff->hash */
diff --git a/net/sched/act_bpf.c b/net/sched/act_bpf.c
index d62edd36b455..6f64e867a5e9 100644
--- a/net/sched/act_bpf.c
+++ b/net/sched/act_bpf.c
@@ -55,7 +55,7 @@ TC_INDIRECT_SCOPE int tcf_bpf_act(struct sk_buff *skb,
 		filter_res = bpf_prog_run(filter, skb);
 	}
 	if (unlikely(!skb->tstamp && skb->tstamp_type))
-		skb->tstamp_type = 0;
+		skb->tstamp_type = SKB_TSTAMP_TYPE_RX_REAL;
 	if (skb_sk_is_prefetched(skb) && filter_res != TC_ACT_OK)
 		skb_orphan(skb);
 
diff --git a/net/sched/cls_bpf.c b/net/sched/cls_bpf.c
index f9cb4378c754..7ee73618c438 100644
--- a/net/sched/cls_bpf.c
+++ b/net/sched/cls_bpf.c
@@ -105,7 +105,7 @@ TC_INDIRECT_SCOPE int cls_bpf_classify(struct sk_buff *skb,
 			filter_res = bpf_prog_run(prog->filter, skb);
 		}
 		if (unlikely(!skb->tstamp && skb->tstamp_type))
-			skb->tstamp_type = 0;
+			skb->tstamp_type = SKB_TSTAMP_TYPE_RX_REAL;

 		if (prog->exts_integrated) {
 			res->class   = 0;
-- 
2.25.1


