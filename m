Return-Path: <bpf+bounces-26657-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 97F7A8A377C
	for <lists+bpf@lfdr.de>; Fri, 12 Apr 2024 23:02:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F08E4B238A0
	for <lists+bpf@lfdr.de>; Fri, 12 Apr 2024 21:02:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6224315216A;
	Fri, 12 Apr 2024 21:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="kvl7KhMo"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9F5F81AB7;
	Fri, 12 Apr 2024 21:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712955722; cv=none; b=eR+H7GhbassgYjIGklR3En3UQNvrwS0awSAk6HKVSKgF2jnlva2X7nvcDv7Xi4YC2HVyQ4COJdngoSftDF4dyCC47tDTWv5j6yy37LcS+foeNFCbRxgRBG4ejCIhKCOSfcLs1yopdrcmk38xUrlxtILxsuuCsioLQj30o6KDv+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712955722; c=relaxed/simple;
	bh=Ts3BJ8BUsjKOvoNgGaCFa71GPLcDBQVQ4kwJgh9QHMw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rZDnpSk+Xfuc5UTi+MzRktDRy3BfMh4p8rvJBbq/ciysB9KtJIw8qsMC3xSTUecQ0Mk4g2qlTq11bQJl3dIZ0KLeHXGHzReefpzljzXtb3rDhzFp+3WujendIxp1TqGc7ks+LiL4R6JBwwoiRPw5JqqlsoEPAK1/ESVjmxQzphs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=kvl7KhMo; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43CKjJnv027677;
	Fri, 12 Apr 2024 21:01:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=qcppdkim1; bh=xAadQe9
	dzpeublOcD6qO8RIkdRnF+QbP6WDZ81hbrP0=; b=kvl7KhMo+yIMg2WcTH2LJoJ
	An6HrNLijOK1p+xLrpyPIK8AZAo34wUxgU94GYqVO7M272Knl0P0sRoIaaY7psRd
	XERoVLPJJzpyvBPnBdkAOmNjsFoHiaZGUxlQgHU97yLMNl69/A4QZX3QoeTfOlXC
	a4+t+Jqc4s9Ny/v1wJckGBg4Orh5gVqrxFINeFDYt+pvVKh3sk2unUPtP5Tm/4YM
	zpbSYjxPj4Z9cL4RVIyeBu439/L2tfapFJlg3+p058b859dcf42elkOkDEU09Eff
	zUILiSQ706WspUhjqvse5c4sFJR9BQ7yQ4wicGxbWUTUfkXI3KufIQJFWTxbYqQ=
	=
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xfbbdr3sr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Apr 2024 21:01:27 +0000 (GMT)
Received: from pps.filterd (NALASPPMTA05.qualcomm.com [127.0.0.1])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 43CL0kkk025720;
	Fri, 12 Apr 2024 21:01:26 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by NALASPPMTA05.qualcomm.com (PPS) with ESMTPS id 3xf5qntx8y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Apr 2024 21:01:26 +0000
Received: from NALASPPMTA05.qualcomm.com (NALASPPMTA05.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 43CL1QlD027057;
	Fri, 12 Apr 2024 21:01:26 GMT
Received: from hu-devc-lv-u20-a-new.qualcomm.com (hu-abchauha-lv.qualcomm.com [10.81.25.35])
	by NALASPPMTA05.qualcomm.com (PPS) with ESMTPS id 43CL1QJB027054
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Apr 2024 21:01:26 +0000
Received: by hu-devc-lv-u20-a-new.qualcomm.com (Postfix, from userid 214165)
	id 2E9EF21FF1; Fri, 12 Apr 2024 14:01:25 -0700 (PDT)
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
Subject: [RFC PATCH bpf-next v3 1/2] net: Rename mono_delivery_time to tstamp_type for scalabilty
Date: Fri, 12 Apr 2024 14:01:24 -0700
Message-Id: <20240412210125.1780574-2-quic_abchauha@quicinc.com>
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
X-Proofpoint-GUID: ESLiE1a06RLbenqW0_r4kbyV64eRHHrA
X-Proofpoint-ORIG-GUID: ESLiE1a06RLbenqW0_r4kbyV64eRHHrA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-12_17,2024-04-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 clxscore=1015 malwarescore=0 mlxlogscore=999 adultscore=0 impostorscore=0
 bulkscore=0 phishscore=0 suspectscore=0 lowpriorityscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404120151

mono_delivery_time was added to check if skb->tstamp has delivery
time in mono clock base (i.e. EDT) otherwise skb->tstamp has
timestamp in ingress and delivery_time at egress.

Renaming the bitfield from mono_delivery_time to tstamp_type is for
extensibilty for other timestamps such as userspace timestamp
(i.e. SO_TXTIME) set via sock opts.

As we are renaming the mono_delivery_time to tstamp_type, it makes
sense to start assigning tstamp_type based out if enum defined as
part of this commit

Earlier we used bool arg flag to check if the tstamp is mono in
function skb_set_delivery_time, Now the signature of the functions
accepts enum to distinguish between mono and real time

Bridge driver today has no support to forward the userspace timestamp
packets and ends up resetting the timestamp. ETF qdisc checks the
packet coming from userspace and encounters to be 0 thereby dropping
time sensitive packets. These changes will allow userspace timestamps
packets to be forwarded from the bridge to NIC drivers.

In future tstamp_type:1 can be extended to support userspace timestamp
by increasing the bitfield.

Link: https://lore.kernel.org/netdev/bc037db4-58bb-4861-ac31-a361a93841d3@linux.dev/
Signed-off-by: Abhishek Chauhan <quic_abchauha@quicinc.com>
---
Changes since v2
- Minor changes to commit subject

Changes since v1
- Squashed the two commits into one as mentioned by Willem.
- Introduced switch in skb_set_delivery_time.
- Renamed and removed directionality aspects w.r.t tstamp_type 
  as mentioned by Willem.

 include/linux/skbuff.h                     | 33 +++++++++++++++-------
 include/net/inet_frag.h                    |  4 +--
 net/bridge/netfilter/nf_conntrack_bridge.c |  6 ++--
 net/core/dev.c                             |  2 +-
 net/core/filter.c                          |  8 +++---
 net/ipv4/inet_fragment.c                   |  2 +-
 net/ipv4/ip_fragment.c                     |  2 +-
 net/ipv4/ip_output.c                       |  8 +++---
 net/ipv4/tcp_output.c                      | 14 ++++-----
 net/ipv6/ip6_output.c                      |  6 ++--
 net/ipv6/netfilter.c                       |  6 ++--
 net/ipv6/netfilter/nf_conntrack_reasm.c    |  2 +-
 net/ipv6/reassembly.c                      |  2 +-
 net/ipv6/tcp_ipv6.c                        |  2 +-
 net/sched/act_bpf.c                        |  4 +--
 net/sched/cls_bpf.c                        |  4 +--
 16 files changed, 59 insertions(+), 46 deletions(-)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 7135a3e94afd..a83a2120b57f 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -702,6 +702,11 @@ typedef unsigned int sk_buff_data_t;
 typedef unsigned char *sk_buff_data_t;
 #endif
 
+enum skb_tstamp_type {
+	CLOCK_REAL = 0, /* Time base is realtime */
+	CLOCK_MONO = 1, /* Time base is Monotonic */
+};
+
 /**
  * DOC: Basic sk_buff geometry
  *
@@ -819,7 +824,7 @@ typedef unsigned char *sk_buff_data_t;
  *	@dst_pending_confirm: need to confirm neighbour
  *	@decrypted: Decrypted SKB
  *	@slow_gro: state present at GRO time, slower prepare step required
- *	@mono_delivery_time: When set, skb->tstamp has the
+ *	@tstamp_type: When set, skb->tstamp has the
  *		delivery_time in mono clock base (i.e. EDT).  Otherwise, the
  *		skb->tstamp has the (rcv) timestamp at ingress and
  *		delivery_time at egress.
@@ -950,7 +955,7 @@ struct sk_buff {
 	/* private: */
 	__u8			__mono_tc_offset[0];
 	/* public: */
-	__u8			mono_delivery_time:1;	/* See SKB_MONO_DELIVERY_TIME_MASK */
+	__u8			tstamp_type:1;	/* See SKB_MONO_DELIVERY_TIME_MASK */
 #ifdef CONFIG_NET_XGRESS
 	__u8			tc_at_ingress:1;	/* See TC_AT_INGRESS_MASK */
 	__u8			tc_skip_classify:1;
@@ -4237,7 +4242,7 @@ static inline void skb_get_new_timestampns(const struct sk_buff *skb,
 static inline void __net_timestamp(struct sk_buff *skb)
 {
 	skb->tstamp = ktime_get_real();
-	skb->mono_delivery_time = 0;
+	skb->tstamp_type = CLOCK_REAL;
 }
 
 static inline ktime_t net_timedelta(ktime_t t)
@@ -4246,10 +4251,18 @@ static inline ktime_t net_timedelta(ktime_t t)
 }
 
 static inline void skb_set_delivery_time(struct sk_buff *skb, ktime_t kt,
-					 bool mono)
+					  u8 tstamp_type)
 {
 	skb->tstamp = kt;
-	skb->mono_delivery_time = kt && mono;
+
+	switch (tstamp_type) {
+	case CLOCK_REAL:
+		skb->tstamp_type = CLOCK_REAL;
+		break;
+	case CLOCK_MONO:
+		skb->tstamp_type = kt && tstamp_type;
+		break;
+	}
 }
 
 DECLARE_STATIC_KEY_FALSE(netstamp_needed_key);
@@ -4259,8 +4272,8 @@ DECLARE_STATIC_KEY_FALSE(netstamp_needed_key);
  */
 static inline void skb_clear_delivery_time(struct sk_buff *skb)
 {
-	if (skb->mono_delivery_time) {
-		skb->mono_delivery_time = 0;
+	if (skb->tstamp_type) {
+		skb->tstamp_type = CLOCK_REAL;
 		if (static_branch_unlikely(&netstamp_needed_key))
 			skb->tstamp = ktime_get_real();
 		else
@@ -4270,7 +4283,7 @@ static inline void skb_clear_delivery_time(struct sk_buff *skb)
 
 static inline void skb_clear_tstamp(struct sk_buff *skb)
 {
-	if (skb->mono_delivery_time)
+	if (skb->tstamp_type)
 		return;
 
 	skb->tstamp = 0;
@@ -4278,7 +4291,7 @@ static inline void skb_clear_tstamp(struct sk_buff *skb)
 
 static inline ktime_t skb_tstamp(const struct sk_buff *skb)
 {
-	if (skb->mono_delivery_time)
+	if (skb->tstamp_type == CLOCK_MONO)
 		return 0;
 
 	return skb->tstamp;
@@ -4286,7 +4299,7 @@ static inline ktime_t skb_tstamp(const struct sk_buff *skb)
 
 static inline ktime_t skb_tstamp_cond(const struct sk_buff *skb, bool cond)
 {
-	if (!skb->mono_delivery_time && skb->tstamp)
+	if (skb->tstamp_type != CLOCK_MONO && skb->tstamp)
 		return skb->tstamp;
 
 	if (static_branch_unlikely(&netstamp_needed_key) || cond)
diff --git a/include/net/inet_frag.h b/include/net/inet_frag.h
index 153960663ce4..5af6eb14c5db 100644
--- a/include/net/inet_frag.h
+++ b/include/net/inet_frag.h
@@ -76,7 +76,7 @@ struct frag_v6_compare_key {
  * @stamp: timestamp of the last received fragment
  * @len: total length of the original datagram
  * @meat: length of received fragments so far
- * @mono_delivery_time: stamp has a mono delivery time (EDT)
+ * @tstamp_type: stamp has a mono delivery time (EDT)
  * @flags: fragment queue flags
  * @max_size: maximum received fragment size
  * @fqdir: pointer to struct fqdir
@@ -97,7 +97,7 @@ struct inet_frag_queue {
 	ktime_t			stamp;
 	int			len;
 	int			meat;
-	u8			mono_delivery_time;
+	u8			tstamp_type;
 	__u8			flags;
 	u16			max_size;
 	struct fqdir		*fqdir;
diff --git a/net/bridge/netfilter/nf_conntrack_bridge.c b/net/bridge/netfilter/nf_conntrack_bridge.c
index c3c51b9a6826..816bb0fde718 100644
--- a/net/bridge/netfilter/nf_conntrack_bridge.c
+++ b/net/bridge/netfilter/nf_conntrack_bridge.c
@@ -32,7 +32,7 @@ static int nf_br_ip_fragment(struct net *net, struct sock *sk,
 					   struct sk_buff *))
 {
 	int frag_max_size = BR_INPUT_SKB_CB(skb)->frag_max_size;
-	bool mono_delivery_time = skb->mono_delivery_time;
+	u8 tstamp_type = skb->tstamp_type;
 	unsigned int hlen, ll_rs, mtu;
 	ktime_t tstamp = skb->tstamp;
 	struct ip_frag_state state;
@@ -82,7 +82,7 @@ static int nf_br_ip_fragment(struct net *net, struct sock *sk,
 			if (iter.frag)
 				ip_fraglist_prepare(skb, &iter);
 
-			skb_set_delivery_time(skb, tstamp, mono_delivery_time);
+			skb_set_delivery_time(skb, tstamp, tstamp_type);
 			err = output(net, sk, data, skb);
 			if (err || !iter.frag)
 				break;
@@ -113,7 +113,7 @@ static int nf_br_ip_fragment(struct net *net, struct sock *sk,
 			goto blackhole;
 		}
 
-		skb_set_delivery_time(skb2, tstamp, mono_delivery_time);
+		skb_set_delivery_time(skb2, tstamp, tstamp_type);
 		err = output(net, sk, data, skb2);
 		if (err)
 			goto blackhole;
diff --git a/net/core/dev.c b/net/core/dev.c
index 854a3a28a8d8..77a43c05dfe3 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -2146,7 +2146,7 @@ EXPORT_SYMBOL(net_disable_timestamp);
 static inline void net_timestamp_set(struct sk_buff *skb)
 {
 	skb->tstamp = 0;
-	skb->mono_delivery_time = 0;
+	skb->tstamp_type = CLOCK_REAL;
 	if (static_branch_unlikely(&netstamp_needed_key))
 		skb->tstamp = ktime_get_real();
 }
diff --git a/net/core/filter.c b/net/core/filter.c
index 8d185d99a643..8bb45423df52 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -7709,13 +7709,13 @@ BPF_CALL_3(bpf_skb_set_tstamp, struct sk_buff *, skb,
 		if (!tstamp)
 			return -EINVAL;
 		skb->tstamp = tstamp;
-		skb->mono_delivery_time = 1;
+		skb->tstamp_type = CLOCK_MONO;
 		break;
 	case BPF_SKB_TSTAMP_UNSPEC:
 		if (tstamp)
 			return -EINVAL;
 		skb->tstamp = 0;
-		skb->mono_delivery_time = 0;
+		skb->tstamp_type = CLOCK_REAL;
 		break;
 	default:
 		return -EINVAL;
@@ -9422,7 +9422,7 @@ static struct bpf_insn *bpf_convert_tstamp_read(const struct bpf_prog *prog,
 					TC_AT_INGRESS_MASK | SKB_MONO_DELIVERY_TIME_MASK);
 		*insn++ = BPF_JMP32_IMM(BPF_JNE, tmp_reg,
 					TC_AT_INGRESS_MASK | SKB_MONO_DELIVERY_TIME_MASK, 2);
-		/* skb->tc_at_ingress && skb->mono_delivery_time,
+		/* skb->tc_at_ingress && skb->tstamp_type:1,
 		 * read 0 as the (rcv) timestamp.
 		 */
 		*insn++ = BPF_MOV64_IMM(value_reg, 0);
@@ -9447,7 +9447,7 @@ static struct bpf_insn *bpf_convert_tstamp_write(const struct bpf_prog *prog,
 	 * the bpf prog is aware the tstamp could have delivery time.
 	 * Thus, write skb->tstamp as is if tstamp_type_access is true.
 	 * Otherwise, writing at ingress will have to clear the
-	 * mono_delivery_time bit also.
+	 * mono_delivery_time (skb->tstamp_type:1)bit also.
 	 */
 	if (!prog->tstamp_type_access) {
 		__u8 tmp_reg = BPF_REG_AX;
diff --git a/net/ipv4/inet_fragment.c b/net/ipv4/inet_fragment.c
index faaec92a46ac..d179a2c84222 100644
--- a/net/ipv4/inet_fragment.c
+++ b/net/ipv4/inet_fragment.c
@@ -619,7 +619,7 @@ void inet_frag_reasm_finish(struct inet_frag_queue *q, struct sk_buff *head,
 	skb_mark_not_on_list(head);
 	head->prev = NULL;
 	head->tstamp = q->stamp;
-	head->mono_delivery_time = q->mono_delivery_time;
+	head->tstamp_type = q->tstamp_type;
 
 	if (sk)
 		refcount_add(sum_truesize - head_truesize, &sk->sk_wmem_alloc);
diff --git a/net/ipv4/ip_fragment.c b/net/ipv4/ip_fragment.c
index fb947d1613fe..787aa86800f5 100644
--- a/net/ipv4/ip_fragment.c
+++ b/net/ipv4/ip_fragment.c
@@ -355,7 +355,7 @@ static int ip_frag_queue(struct ipq *qp, struct sk_buff *skb)
 		qp->iif = dev->ifindex;
 
 	qp->q.stamp = skb->tstamp;
-	qp->q.mono_delivery_time = skb->mono_delivery_time;
+	qp->q.tstamp_type = skb->tstamp_type;
 	qp->q.meat += skb->len;
 	qp->ecn |= ecn;
 	add_frag_mem_limit(qp->q.fqdir, skb->truesize);
diff --git a/net/ipv4/ip_output.c b/net/ipv4/ip_output.c
index 1fe794967211..62e457f7c02c 100644
--- a/net/ipv4/ip_output.c
+++ b/net/ipv4/ip_output.c
@@ -764,7 +764,7 @@ int ip_do_fragment(struct net *net, struct sock *sk, struct sk_buff *skb,
 {
 	struct iphdr *iph;
 	struct sk_buff *skb2;
-	bool mono_delivery_time = skb->mono_delivery_time;
+	u8 tstamp_type = skb->tstamp_type;
 	struct rtable *rt = skb_rtable(skb);
 	unsigned int mtu, hlen, ll_rs;
 	struct ip_fraglist_iter iter;
@@ -856,7 +856,7 @@ int ip_do_fragment(struct net *net, struct sock *sk, struct sk_buff *skb,
 				}
 			}
 
-			skb_set_delivery_time(skb, tstamp, mono_delivery_time);
+			skb_set_delivery_time(skb, tstamp, tstamp_type);
 			err = output(net, sk, skb);
 
 			if (!err)
@@ -912,7 +912,7 @@ int ip_do_fragment(struct net *net, struct sock *sk, struct sk_buff *skb,
 		/*
 		 *	Put this fragment into the sending queue.
 		 */
-		skb_set_delivery_time(skb2, tstamp, mono_delivery_time);
+		skb_set_delivery_time(skb2, tstamp, tstamp_type);
 		err = output(net, sk, skb2);
 		if (err)
 			goto fail;
@@ -1649,7 +1649,7 @@ void ip_send_unicast_reply(struct sock *sk, struct sk_buff *skb,
 			  arg->csumoffset) = csum_fold(csum_add(nskb->csum,
 								arg->csum));
 		nskb->ip_summed = CHECKSUM_NONE;
-		nskb->mono_delivery_time = !!transmit_time;
+		nskb->tstamp_type = !!transmit_time;
 		if (txhash)
 			skb_set_hash(nskb, txhash, PKT_HASH_TYPE_L4);
 		ip_push_pending_frames(sk, &fl4);
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index 9282fafc0e61..42e6ed1decf4 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -1299,7 +1299,7 @@ static int __tcp_transmit_skb(struct sock *sk, struct sk_buff *skb,
 	tp = tcp_sk(sk);
 	prior_wstamp = tp->tcp_wstamp_ns;
 	tp->tcp_wstamp_ns = max(tp->tcp_wstamp_ns, tp->tcp_clock_cache);
-	skb_set_delivery_time(skb, tp->tcp_wstamp_ns, true);
+	skb_set_delivery_time(skb, tp->tcp_wstamp_ns, CLOCK_MONO);
 	if (clone_it) {
 		oskb = skb;
 
@@ -1649,7 +1649,7 @@ int tcp_fragment(struct sock *sk, enum tcp_queue tcp_queue,
 
 	skb_split(skb, buff, len);
 
-	skb_set_delivery_time(buff, skb->tstamp, true);
+	skb_set_delivery_time(buff, skb->tstamp, CLOCK_MONO);
 	tcp_fragment_tstamp(skb, buff);
 
 	old_factor = tcp_skb_pcount(skb);
@@ -2730,7 +2730,7 @@ static bool tcp_write_xmit(struct sock *sk, unsigned int mss_now, int nonagle,
 		if (unlikely(tp->repair) && tp->repair_queue == TCP_SEND_QUEUE) {
 			/* "skb_mstamp_ns" is used as a start point for the retransmit timer */
 			tp->tcp_wstamp_ns = tp->tcp_clock_cache;
-			skb_set_delivery_time(skb, tp->tcp_wstamp_ns, true);
+			skb_set_delivery_time(skb, tp->tcp_wstamp_ns, CLOCK_MONO);
 			list_move_tail(&skb->tcp_tsorted_anchor, &tp->tsorted_sent_queue);
 			tcp_init_tso_segs(skb, mss_now);
 			goto repair; /* Skip network transmission */
@@ -3713,11 +3713,11 @@ struct sk_buff *tcp_make_synack(const struct sock *sk, struct dst_entry *dst,
 #ifdef CONFIG_SYN_COOKIES
 	if (unlikely(synack_type == TCP_SYNACK_COOKIE && ireq->tstamp_ok))
 		skb_set_delivery_time(skb, cookie_init_timestamp(req, now),
-				      true);
+				      CLOCK_MONO);
 	else
 #endif
 	{
-		skb_set_delivery_time(skb, now, true);
+		skb_set_delivery_time(skb, now, CLOCK_MONO);
 		if (!tcp_rsk(req)->snt_synack) /* Timestamp first SYNACK */
 			tcp_rsk(req)->snt_synack = tcp_skb_timestamp_us(skb);
 	}
@@ -3804,7 +3804,7 @@ struct sk_buff *tcp_make_synack(const struct sock *sk, struct dst_entry *dst,
 	bpf_skops_write_hdr_opt((struct sock *)sk, skb, req, syn_skb,
 				synack_type, &opts);
 
-	skb_set_delivery_time(skb, now, true);
+	skb_set_delivery_time(skb, now, CLOCK_MONO);
 	tcp_add_tx_delay(skb, tp);
 
 	return skb;
@@ -3988,7 +3988,7 @@ static int tcp_send_syn_data(struct sock *sk, struct sk_buff *syn)
 
 	err = tcp_transmit_skb(sk, syn_data, 1, sk->sk_allocation);
 
-	skb_set_delivery_time(syn, syn_data->skb_mstamp_ns, true);
+	skb_set_delivery_time(syn, syn_data->skb_mstamp_ns, CLOCK_MONO);
 
 	/* Now full SYN+DATA was cloned and sent (or not),
 	 * remove the SYN from the original skb (syn_data)
diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
index b9dd3a66e423..a9e819115622 100644
--- a/net/ipv6/ip6_output.c
+++ b/net/ipv6/ip6_output.c
@@ -859,7 +859,7 @@ int ip6_fragment(struct net *net, struct sock *sk, struct sk_buff *skb,
 	struct rt6_info *rt = (struct rt6_info *)skb_dst(skb);
 	struct ipv6_pinfo *np = skb->sk && !dev_recursion_level() ?
 				inet6_sk(skb->sk) : NULL;
-	bool mono_delivery_time = skb->mono_delivery_time;
+	u8 tstamp_type = skb->tstamp_type;
 	struct ip6_frag_state state;
 	unsigned int mtu, hlen, nexthdr_offset;
 	ktime_t tstamp = skb->tstamp;
@@ -955,7 +955,7 @@ int ip6_fragment(struct net *net, struct sock *sk, struct sk_buff *skb,
 			if (iter.frag)
 				ip6_fraglist_prepare(skb, &iter);
 
-			skb_set_delivery_time(skb, tstamp, mono_delivery_time);
+			skb_set_delivery_time(skb, tstamp, tstamp_type);
 			err = output(net, sk, skb);
 			if (!err)
 				IP6_INC_STATS(net, ip6_dst_idev(&rt->dst),
@@ -1016,7 +1016,7 @@ int ip6_fragment(struct net *net, struct sock *sk, struct sk_buff *skb,
 		/*
 		 *	Put this fragment into the sending queue.
 		 */
-		skb_set_delivery_time(frag, tstamp, mono_delivery_time);
+		skb_set_delivery_time(frag, tstamp, tstamp_type);
 		err = output(net, sk, frag);
 		if (err)
 			goto fail;
diff --git a/net/ipv6/netfilter.c b/net/ipv6/netfilter.c
index 53d255838e6a..e0c2347b4dc6 100644
--- a/net/ipv6/netfilter.c
+++ b/net/ipv6/netfilter.c
@@ -126,7 +126,7 @@ int br_ip6_fragment(struct net *net, struct sock *sk, struct sk_buff *skb,
 				  struct sk_buff *))
 {
 	int frag_max_size = BR_INPUT_SKB_CB(skb)->frag_max_size;
-	bool mono_delivery_time = skb->mono_delivery_time;
+	u8 tstamp_type = skb->tstamp_type;
 	ktime_t tstamp = skb->tstamp;
 	struct ip6_frag_state state;
 	u8 *prevhdr, nexthdr = 0;
@@ -192,7 +192,7 @@ int br_ip6_fragment(struct net *net, struct sock *sk, struct sk_buff *skb,
 			if (iter.frag)
 				ip6_fraglist_prepare(skb, &iter);
 
-			skb_set_delivery_time(skb, tstamp, mono_delivery_time);
+			skb_set_delivery_time(skb, tstamp, tstamp_type);
 			err = output(net, sk, data, skb);
 			if (err || !iter.frag)
 				break;
@@ -225,7 +225,7 @@ int br_ip6_fragment(struct net *net, struct sock *sk, struct sk_buff *skb,
 			goto blackhole;
 		}
 
-		skb_set_delivery_time(skb2, tstamp, mono_delivery_time);
+		skb_set_delivery_time(skb2, tstamp, tstamp_type);
 		err = output(net, sk, data, skb2);
 		if (err)
 			goto blackhole;
diff --git a/net/ipv6/netfilter/nf_conntrack_reasm.c b/net/ipv6/netfilter/nf_conntrack_reasm.c
index d0dcbaca1994..5cc5d823d33f 100644
--- a/net/ipv6/netfilter/nf_conntrack_reasm.c
+++ b/net/ipv6/netfilter/nf_conntrack_reasm.c
@@ -264,7 +264,7 @@ static int nf_ct_frag6_queue(struct frag_queue *fq, struct sk_buff *skb,
 		fq->iif = dev->ifindex;
 
 	fq->q.stamp = skb->tstamp;
-	fq->q.mono_delivery_time = skb->mono_delivery_time;
+	fq->q.tstamp_type = skb->tstamp_type;
 	fq->q.meat += skb->len;
 	fq->ecn |= ecn;
 	if (payload_len > fq->q.max_size)
diff --git a/net/ipv6/reassembly.c b/net/ipv6/reassembly.c
index acb4f119e11f..ea724ff558b4 100644
--- a/net/ipv6/reassembly.c
+++ b/net/ipv6/reassembly.c
@@ -198,7 +198,7 @@ static int ip6_frag_queue(struct frag_queue *fq, struct sk_buff *skb,
 		fq->iif = dev->ifindex;
 
 	fq->q.stamp = skb->tstamp;
-	fq->q.mono_delivery_time = skb->mono_delivery_time;
+	fq->q.tstamp_type = skb->tstamp_type;
 	fq->q.meat += skb->len;
 	fq->ecn |= ecn;
 	add_frag_mem_limit(fq->q.fqdir, skb->truesize);
diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index 3aa9da5c9a66..b60196061489 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -975,7 +975,7 @@ static void tcp_v6_send_response(const struct sock *sk, struct sk_buff *skb, u32
 			mark = inet_twsk(sk)->tw_mark;
 		else
 			mark = READ_ONCE(sk->sk_mark);
-		skb_set_delivery_time(buff, tcp_transmit_time(sk), true);
+		skb_set_delivery_time(buff, tcp_transmit_time(sk), CLOCK_MONO);
 	}
 	if (txhash) {
 		/* autoflowlabel/skb_get_hash_flowi6 rely on buff->hash */
diff --git a/net/sched/act_bpf.c b/net/sched/act_bpf.c
index 0e3cf11ae5fc..1f8b5a3f065e 100644
--- a/net/sched/act_bpf.c
+++ b/net/sched/act_bpf.c
@@ -54,8 +54,8 @@ TC_INDIRECT_SCOPE int tcf_bpf_act(struct sk_buff *skb,
 		bpf_compute_data_pointers(skb);
 		filter_res = bpf_prog_run(filter, skb);
 	}
-	if (unlikely(!skb->tstamp && skb->mono_delivery_time))
-		skb->mono_delivery_time = 0;
+	if (unlikely(!skb->tstamp && skb->tstamp_type))
+		skb->tstamp_type = CLOCK_REAL;
 	if (skb_sk_is_prefetched(skb) && filter_res != TC_ACT_OK)
 		skb_orphan(skb);
 
diff --git a/net/sched/cls_bpf.c b/net/sched/cls_bpf.c
index 5e83e890f6a4..3f843e0eea3c 100644
--- a/net/sched/cls_bpf.c
+++ b/net/sched/cls_bpf.c
@@ -104,8 +104,8 @@ TC_INDIRECT_SCOPE int cls_bpf_classify(struct sk_buff *skb,
 			bpf_compute_data_pointers(skb);
 			filter_res = bpf_prog_run(prog->filter, skb);
 		}
-		if (unlikely(!skb->tstamp && skb->mono_delivery_time))
-			skb->mono_delivery_time = 0;
+		if (unlikely(!skb->tstamp && skb->tstamp_type))
+			skb->tstamp_type = CLOCK_REAL;
 
 		if (prog->exts_integrated) {
 			res->class   = 0;
-- 
2.25.1


