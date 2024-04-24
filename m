Return-Path: <bpf+bounces-27744-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 842B88B1616
	for <lists+bpf@lfdr.de>; Thu, 25 Apr 2024 00:21:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7D6CFB21D9B
	for <lists+bpf@lfdr.de>; Wed, 24 Apr 2024 22:21:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9972716D9DB;
	Wed, 24 Apr 2024 22:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="dcCMI3GN"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB03315697B;
	Wed, 24 Apr 2024 22:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713997255; cv=none; b=oF9wGPTXBSl4cfjYsT5QH6almB/IvsOMtVtTPKtt2K8DKzyznHPD6s+rFWda3QRS8lq+LqNBUBkOB53Cq6sI0YgSJh/3YPtP27iJguuESz4bskQIgfzCG5QLD8JAgx4jw1ERqomUA2mIkw6bDwd1ichoRheBg+Q5sreFOf7aeVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713997255; c=relaxed/simple;
	bh=nivJF/+8n5KRWbNiO18Uqejm9aTHBxwRqeq2AvEjfG4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TZeoLy+RZstczseFZ731zaTY6RY2PC4drjqyfyqVqOsYjPVeMM2mdffJpFvldz29ItorG8/w1/YZPDGai+LdBAzhBpcjnyZmJdU+bqBFvqj5q0KYi3N0pMkhuaEf//JWLwEM7fpeSmcBqMuVKwVJgnDZ0eWJ/FWjUwRuWylcLws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=dcCMI3GN; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43OKnM4M032005;
	Wed, 24 Apr 2024 22:20:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=qcppdkim1; bh=Tse8HeM
	7VdFfUGq/8e+tGZVtyEzF3EOrqpcbzqKJQ+4=; b=dcCMI3GNLJ2ntsW9+I5fj5/
	1AuyVq1d6hRGXosRWkr5gTGFeEc8QIDQZPSoTgShTIsLjw812fJUjSkMTM9zOp/W
	+9dIZSJbAHZ3pQsc+KSBVnqt4gF9c25pZelEXUMBwby2muDwteOZHkUWaQOwh5lw
	EOHr3jDZtEC1kF/Im8H3yCG3FU1KHBBvvOZBlWBrUqV2KdYYT6IkFXYFRAyaVocB
	mOvbd+Td4EYDAnvMP52PTK/z0/m0+jYZJzfTqcOOqnmG8tvg+ApzPC2jzXmzQHOe
	R4sdCyUp/O2AEJ3aoLs2UY4u/6yk8wjamqwZVzWAEQDVFsH959YUjf9vBKe1IRw=
	=
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xpv9dj9fx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Apr 2024 22:20:30 +0000 (GMT)
Received: from pps.filterd (NALASPPMTA02.qualcomm.com [127.0.0.1])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 43OMIBQL017346;
	Wed, 24 Apr 2024 22:20:29 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by NALASPPMTA02.qualcomm.com (PPS) with ESMTPS id 3xp4jb1777-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Apr 2024 22:20:29 +0000
Received: from NALASPPMTA02.qualcomm.com (NALASPPMTA02.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 43OMKTAr019381;
	Wed, 24 Apr 2024 22:20:29 GMT
Received: from hu-devc-lv-u20-a-new.qualcomm.com (hu-abchauha-lv.qualcomm.com [10.81.25.35])
	by NALASPPMTA02.qualcomm.com (PPS) with ESMTPS id 43OMKT4k019375
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Apr 2024 22:20:29 +0000
Received: by hu-devc-lv-u20-a-new.qualcomm.com (Postfix, from userid 214165)
	id 56828220A6; Wed, 24 Apr 2024 15:20:28 -0700 (PDT)
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
Subject: [RFC PATCH bpf-next v5 1/2] net: Rename mono_delivery_time to tstamp_type for scalabilty
Date: Wed, 24 Apr 2024 15:20:27 -0700
Message-Id: <20240424222028.1080134-2-quic_abchauha@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240424222028.1080134-1-quic_abchauha@quicinc.com>
References: <20240424222028.1080134-1-quic_abchauha@quicinc.com>
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
X-Proofpoint-GUID: 4PlKGJK3jb1VwaA01iarKLLS3-Y2jgzW
X-Proofpoint-ORIG-GUID: 4PlKGJK3jb1VwaA01iarKLLS3-Y2jgzW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-24_19,2024-04-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 priorityscore=1501 mlxscore=0 malwarescore=0 suspectscore=0
 impostorscore=0 mlxlogscore=999 bulkscore=0 clxscore=1015 phishscore=0
 adultscore=0 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2404010003 definitions=main-2404240115

mono_delivery_time was added to check if skb->tstamp has delivery
time in mono clock base (i.e. EDT) otherwise skb->tstamp has
timestamp in ingress and delivery_time at egress.

Renaming the bitfield from mono_delivery_time to tstamp_type is for
extensibilty for other timestamps such as userspace timestamp
(i.e. SO_TXTIME) set via sock opts.

As we are renaming the mono_delivery_time to tstamp_type, it makes
sense to start assigning tstamp_type based on enum defined
in this commit.

Earlier we used bool arg flag to check if the tstamp is mono in
function skb_set_delivery_time, Now the signature of the functions
accepts tstamp_type to distinguish between mono and real time.

Introduce a new function to set tstamp_type based on clockid. 

In future tstamp_type:1 can be extended to support userspace timestamp
by increasing the bitfield.

Link: https://lore.kernel.org/netdev/bc037db4-58bb-4861-ac31-a361a93841d3@linux.dev/
Signed-off-by: Abhishek Chauhan <quic_abchauha@quicinc.com>
---
Changes since v4
- Introduce new function to directly delivery_time and
  another to set tstamp_type based on clockid. 
- Removed un-necessary comments in skbuff.h as 
  enums were obvious and understood.

Changes since v3
- Fixed inconsistent capitalization in skbuff.h
- remove reference to MONO_DELIVERY_TIME_MASK in skbuff.h
  and point it to skb_tstamp_type now.
- Explicitely setting SKB_CLOCK_MONO if valid transmit_time
  ip_send_unicast_reply 
- Keeping skb_tstamp inline with skb_clear_tstamp. 
- skb_set_delivery_time checks if timstamp is 0 and 
  sets the tstamp_type to SKB_CLOCK_REAL.
- Above comments are given by Willem 
- Found out that skbuff.h has access to uapi/linux/time.h
  So now instead of using  CLOCK_REAL/CLOCK_MONO 
  i am checking actual clockid_t directly to set tstamp_type 
  example:- CLOCK_REALTIME/CLOCK_MONOTONIC 
- Compilation error fixed in 
  net/ieee802154/6lowpan/reassembly.c

Changes since v2
- Minor changes to commit subject

Changes since v1
- Squashed the two commits into one as mentioned by Willem.
- Introduced switch in skb_set_delivery_time.
- Renamed and removed directionality aspects w.r.t tstamp_type 
  as mentioned by Willem.

 include/linux/skbuff.h                     | 54 ++++++++++++++++------
 include/net/inet_frag.h                    |  4 +-
 net/bridge/netfilter/nf_conntrack_bridge.c |  6 +--
 net/core/dev.c                             |  2 +-
 net/core/filter.c                          | 10 ++--
 net/ieee802154/6lowpan/reassembly.c        |  2 +-
 net/ipv4/inet_fragment.c                   |  2 +-
 net/ipv4/ip_fragment.c                     |  2 +-
 net/ipv4/ip_output.c                       |  9 ++--
 net/ipv4/tcp_output.c                      | 16 +++----
 net/ipv6/ip6_output.c                      |  6 +--
 net/ipv6/netfilter.c                       |  6 +--
 net/ipv6/netfilter/nf_conntrack_reasm.c    |  2 +-
 net/ipv6/reassembly.c                      |  2 +-
 net/ipv6/tcp_ipv6.c                        |  2 +-
 net/sched/act_bpf.c                        |  4 +-
 net/sched/cls_bpf.c                        |  4 +-
 17 files changed, 81 insertions(+), 52 deletions(-)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 238e292696e6..e464d0ebc9c1 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -708,6 +708,11 @@ typedef unsigned int sk_buff_data_t;
 typedef unsigned char *sk_buff_data_t;
 #endif
 
+enum skb_tstamp_type {
+	SKB_CLOCK_REALTIME,
+	SKB_CLOCK_MONOTONIC,
+};
+
 /**
  * DOC: Basic sk_buff geometry
  *
@@ -825,10 +830,9 @@ typedef unsigned char *sk_buff_data_t;
  *	@dst_pending_confirm: need to confirm neighbour
  *	@decrypted: Decrypted SKB
  *	@slow_gro: state present at GRO time, slower prepare step required
- *	@mono_delivery_time: When set, skb->tstamp has the
- *		delivery_time in mono clock base (i.e. EDT).  Otherwise, the
- *		skb->tstamp has the (rcv) timestamp at ingress and
- *		delivery_time at egress.
+ *	@tstamp_type: When set, skb->tstamp has the
+ *		delivery_time in mono clock base Otherwise, the
+ *		timestamp is considered real clock base.
  *	@napi_id: id of the NAPI struct this skb came from
  *	@sender_cpu: (aka @napi_id) source CPU in XPS
  *	@alloc_cpu: CPU which did the skb allocation.
@@ -956,7 +960,7 @@ struct sk_buff {
 	/* private: */
 	__u8			__mono_tc_offset[0];
 	/* public: */
-	__u8			mono_delivery_time:1;	/* See SKB_MONO_DELIVERY_TIME_MASK */
+	__u8			tstamp_type:1;	/* See skb_tstamp_type */
 #ifdef CONFIG_NET_XGRESS
 	__u8			tc_at_ingress:1;	/* See TC_AT_INGRESS_MASK */
 	__u8			tc_skip_classify:1;
@@ -4175,7 +4179,7 @@ static inline void skb_get_new_timestampns(const struct sk_buff *skb,
 static inline void __net_timestamp(struct sk_buff *skb)
 {
 	skb->tstamp = ktime_get_real();
-	skb->mono_delivery_time = 0;
+	skb->tstamp_type = SKB_CLOCK_REALTIME;
 }
 
 static inline ktime_t net_timedelta(ktime_t t)
@@ -4183,11 +4187,35 @@ static inline ktime_t net_timedelta(ktime_t t)
 	return ktime_sub(ktime_get_real(), t);
 }
 
+static inline void skb_set_tstamp_type_frm_clkid(struct sk_buff *skb,
+						  ktime_t kt, clockid_t clockid)
+{
+	skb->tstamp = kt;
+
+	if (!kt) {
+		skb->tstamp_type = SKB_CLOCK_REALTIME;
+		return;
+	}
+
+	switch (clockid) {
+	case CLOCK_REALTIME:
+		skb->tstamp_type = SKB_CLOCK_REALTIME;
+		break;
+	case CLOCK_MONOTONIC:
+		skb->tstamp_type = SKB_CLOCK_MONOTONIC;
+		break;
+	}
+}
+
 static inline void skb_set_delivery_time(struct sk_buff *skb, ktime_t kt,
-					 bool mono)
+					  u8 tstamp_type)
 {
 	skb->tstamp = kt;
-	skb->mono_delivery_time = kt && mono;
+
+	if (kt)
+		skb->tstamp_type = tstamp_type;
+	else
+		skb->tstamp_type = SKB_CLOCK_REALTIME;
 }
 
 DECLARE_STATIC_KEY_FALSE(netstamp_needed_key);
@@ -4197,8 +4225,8 @@ DECLARE_STATIC_KEY_FALSE(netstamp_needed_key);
  */
 static inline void skb_clear_delivery_time(struct sk_buff *skb)
 {
-	if (skb->mono_delivery_time) {
-		skb->mono_delivery_time = 0;
+	if (skb->tstamp_type) {
+		skb->tstamp_type = SKB_CLOCK_REALTIME;
 		if (static_branch_unlikely(&netstamp_needed_key))
 			skb->tstamp = ktime_get_real();
 		else
@@ -4208,7 +4236,7 @@ static inline void skb_clear_delivery_time(struct sk_buff *skb)
 
 static inline void skb_clear_tstamp(struct sk_buff *skb)
 {
-	if (skb->mono_delivery_time)
+	if (skb->tstamp_type)
 		return;
 
 	skb->tstamp = 0;
@@ -4216,7 +4244,7 @@ static inline void skb_clear_tstamp(struct sk_buff *skb)
 
 static inline ktime_t skb_tstamp(const struct sk_buff *skb)
 {
-	if (skb->mono_delivery_time)
+	if (skb->tstamp_type)
 		return 0;
 
 	return skb->tstamp;
@@ -4224,7 +4252,7 @@ static inline ktime_t skb_tstamp(const struct sk_buff *skb)
 
 static inline ktime_t skb_tstamp_cond(const struct sk_buff *skb, bool cond)
 {
-	if (!skb->mono_delivery_time && skb->tstamp)
+	if (skb->tstamp_type != SKB_CLOCK_MONOTONIC && skb->tstamp)
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
index 8bdc59074b29..df352e952fc5 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -2146,7 +2146,7 @@ EXPORT_SYMBOL(net_disable_timestamp);
 static inline void net_timestamp_set(struct sk_buff *skb)
 {
 	skb->tstamp = 0;
-	skb->mono_delivery_time = 0;
+	skb->tstamp_type = SKB_CLOCK_REALTIME;
 	if (static_branch_unlikely(&netstamp_needed_key))
 		skb->tstamp = ktime_get_real();
 }
diff --git a/net/core/filter.c b/net/core/filter.c
index 94d403f925c4..957c2fc724eb 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -7731,13 +7731,13 @@ BPF_CALL_3(bpf_skb_set_tstamp, struct sk_buff *, skb,
 		if (!tstamp)
 			return -EINVAL;
 		skb->tstamp = tstamp;
-		skb->mono_delivery_time = 1;
+		skb->tstamp_type = SKB_CLOCK_MONOTONIC;
 		break;
 	case BPF_SKB_TSTAMP_UNSPEC:
 		if (tstamp)
 			return -EINVAL;
 		skb->tstamp = 0;
-		skb->mono_delivery_time = 0;
+		skb->tstamp_type = SKB_CLOCK_REALTIME;
 		break;
 	default:
 		return -EINVAL;
@@ -9444,7 +9444,7 @@ static struct bpf_insn *bpf_convert_tstamp_read(const struct bpf_prog *prog,
 					TC_AT_INGRESS_MASK | SKB_MONO_DELIVERY_TIME_MASK);
 		*insn++ = BPF_JMP32_IMM(BPF_JNE, tmp_reg,
 					TC_AT_INGRESS_MASK | SKB_MONO_DELIVERY_TIME_MASK, 2);
-		/* skb->tc_at_ingress && skb->mono_delivery_time,
+		/* skb->tc_at_ingress && skb->tstamp_type:1,
 		 * read 0 as the (rcv) timestamp.
 		 */
 		*insn++ = BPF_MOV64_IMM(value_reg, 0);
@@ -9469,7 +9469,7 @@ static struct bpf_insn *bpf_convert_tstamp_write(const struct bpf_prog *prog,
 	 * the bpf prog is aware the tstamp could have delivery time.
 	 * Thus, write skb->tstamp as is if tstamp_type_access is true.
 	 * Otherwise, writing at ingress will have to clear the
-	 * mono_delivery_time bit also.
+	 * mono_delivery_time (skb->tstamp_type:1)bit also.
 	 */
 	if (!prog->tstamp_type_access) {
 		__u8 tmp_reg = BPF_REG_AX;
@@ -9479,7 +9479,7 @@ static struct bpf_insn *bpf_convert_tstamp_write(const struct bpf_prog *prog,
 		*insn++ = BPF_JMP32_IMM(BPF_JSET, tmp_reg, TC_AT_INGRESS_MASK, 1);
 		/* goto <store> */
 		*insn++ = BPF_JMP_A(2);
-		/* <clear>: mono_delivery_time */
+		/* <clear>: mono_delivery_time or (skb->tstamp_type:1) */
 		*insn++ = BPF_ALU32_IMM(BPF_AND, tmp_reg, ~SKB_MONO_DELIVERY_TIME_MASK);
 		*insn++ = BPF_STX_MEM(BPF_B, skb_reg, tmp_reg, SKB_BF_MONO_TC_OFFSET);
 	}
diff --git a/net/ieee802154/6lowpan/reassembly.c b/net/ieee802154/6lowpan/reassembly.c
index 2a983cf450da..26506dd4b357 100644
--- a/net/ieee802154/6lowpan/reassembly.c
+++ b/net/ieee802154/6lowpan/reassembly.c
@@ -130,7 +130,7 @@ static int lowpan_frag_queue(struct lowpan_frag_queue *fq,
 		goto err;
 
 	fq->q.stamp = skb->tstamp;
-	fq->q.mono_delivery_time = skb->mono_delivery_time;
+	fq->q.tstamp_type = skb->tstamp_type;
 	if (frag_type == LOWPAN_DISPATCH_FRAG1)
 		fq->q.flags |= INET_FRAG_FIRST_IN;
 
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
index 534b98a0744a..c101bb1b9d3c 100644
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
index 1fe794967211..591226dcde26 100644
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
@@ -1649,7 +1649,8 @@ void ip_send_unicast_reply(struct sock *sk, struct sk_buff *skb,
 			  arg->csumoffset) = csum_fold(csum_add(nskb->csum,
 								arg->csum));
 		nskb->ip_summed = CHECKSUM_NONE;
-		nskb->mono_delivery_time = !!transmit_time;
+		if (transmit_time)
+			nskb->tstamp_type = SKB_CLOCK_MONOTONIC;
 		if (txhash)
 			skb_set_hash(nskb, txhash, PKT_HASH_TYPE_L4);
 		ip_push_pending_frames(sk, &fl4);
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index 99a1d88f7f47..51c7399738c0 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -1300,7 +1300,7 @@ static int __tcp_transmit_skb(struct sock *sk, struct sk_buff *skb,
 	tp = tcp_sk(sk);
 	prior_wstamp = tp->tcp_wstamp_ns;
 	tp->tcp_wstamp_ns = max(tp->tcp_wstamp_ns, tp->tcp_clock_cache);
-	skb_set_delivery_time(skb, tp->tcp_wstamp_ns, true);
+	skb_set_tstamp_type_frm_clkid(skb, tp->tcp_wstamp_ns, CLOCK_MONOTONIC);
 	if (clone_it) {
 		oskb = skb;
 
@@ -1654,7 +1654,7 @@ int tcp_fragment(struct sock *sk, enum tcp_queue tcp_queue,
 
 	skb_split(skb, buff, len);
 
-	skb_set_delivery_time(buff, skb->tstamp, true);
+	skb_set_tstamp_type_frm_clkid(buff, skb->tstamp, CLOCK_MONOTONIC);
 	tcp_fragment_tstamp(skb, buff);
 
 	old_factor = tcp_skb_pcount(skb);
@@ -2758,7 +2758,7 @@ static bool tcp_write_xmit(struct sock *sk, unsigned int mss_now, int nonagle,
 		if (unlikely(tp->repair) && tp->repair_queue == TCP_SEND_QUEUE) {
 			/* "skb_mstamp_ns" is used as a start point for the retransmit timer */
 			tp->tcp_wstamp_ns = tp->tcp_clock_cache;
-			skb_set_delivery_time(skb, tp->tcp_wstamp_ns, true);
+			skb_set_tstamp_type_frm_clkid(skb, tp->tcp_wstamp_ns, CLOCK_MONOTONIC);
 			list_move_tail(&skb->tcp_tsorted_anchor, &tp->tsorted_sent_queue);
 			tcp_init_tso_segs(skb, mss_now);
 			goto repair; /* Skip network transmission */
@@ -3741,12 +3741,12 @@ struct sk_buff *tcp_make_synack(const struct sock *sk, struct dst_entry *dst,
 	now = tcp_clock_ns();
 #ifdef CONFIG_SYN_COOKIES
 	if (unlikely(synack_type == TCP_SYNACK_COOKIE && ireq->tstamp_ok))
-		skb_set_delivery_time(skb, cookie_init_timestamp(req, now),
-				      true);
+		skb_set_tstamp_type_frm_clkid(skb, cookie_init_timestamp(req, now),
+					      CLOCK_MONOTONIC);
 	else
 #endif
 	{
-		skb_set_delivery_time(skb, now, true);
+		skb_set_tstamp_type_frm_clkid(skb, now, CLOCK_MONOTONIC);
 		if (!tcp_rsk(req)->snt_synack) /* Timestamp first SYNACK */
 			tcp_rsk(req)->snt_synack = tcp_skb_timestamp_us(skb);
 	}
@@ -3833,7 +3833,7 @@ struct sk_buff *tcp_make_synack(const struct sock *sk, struct dst_entry *dst,
 	bpf_skops_write_hdr_opt((struct sock *)sk, skb, req, syn_skb,
 				synack_type, &opts);
 
-	skb_set_delivery_time(skb, now, true);
+	skb_set_tstamp_type_frm_clkid(skb, now, CLOCK_MONOTONIC);
 	tcp_add_tx_delay(skb, tp);
 
 	return skb;
@@ -4017,7 +4017,7 @@ static int tcp_send_syn_data(struct sock *sk, struct sk_buff *syn)
 
 	err = tcp_transmit_skb(sk, syn_data, 1, sk->sk_allocation);
 
-	skb_set_delivery_time(syn, syn_data->skb_mstamp_ns, true);
+	skb_set_tstamp_type_frm_clkid(syn, syn_data->skb_mstamp_ns, CLOCK_MONOTONIC);
 
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
index ce8c14d8aff5..1e0cdad52207 100644
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
index ee95cdcc8747..fe7a337b6bc7 100644
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
index bb7c3caf4f85..b9eafd771aa9 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -975,7 +975,7 @@ static void tcp_v6_send_response(const struct sock *sk, struct sk_buff *skb, u32
 			mark = inet_twsk(sk)->tw_mark;
 		else
 			mark = READ_ONCE(sk->sk_mark);
-		skb_set_delivery_time(buff, tcp_transmit_time(sk), true);
+		skb_set_tstamp_type_frm_clkid(buff, tcp_transmit_time(sk), CLOCK_MONOTONIC);
 	}
 	if (txhash) {
 		/* autoflowlabel/skb_get_hash_flowi6 rely on buff->hash */
diff --git a/net/sched/act_bpf.c b/net/sched/act_bpf.c
index 0e3cf11ae5fc..396b576390d0 100644
--- a/net/sched/act_bpf.c
+++ b/net/sched/act_bpf.c
@@ -54,8 +54,8 @@ TC_INDIRECT_SCOPE int tcf_bpf_act(struct sk_buff *skb,
 		bpf_compute_data_pointers(skb);
 		filter_res = bpf_prog_run(filter, skb);
 	}
-	if (unlikely(!skb->tstamp && skb->mono_delivery_time))
-		skb->mono_delivery_time = 0;
+	if (unlikely(!skb->tstamp && skb->tstamp_type))
+		skb->tstamp_type = SKB_CLOCK_REALTIME;
 	if (skb_sk_is_prefetched(skb) && filter_res != TC_ACT_OK)
 		skb_orphan(skb);
 
diff --git a/net/sched/cls_bpf.c b/net/sched/cls_bpf.c
index 5e83e890f6a4..1941ebec23ff 100644
--- a/net/sched/cls_bpf.c
+++ b/net/sched/cls_bpf.c
@@ -104,8 +104,8 @@ TC_INDIRECT_SCOPE int cls_bpf_classify(struct sk_buff *skb,
 			bpf_compute_data_pointers(skb);
 			filter_res = bpf_prog_run(prog->filter, skb);
 		}
-		if (unlikely(!skb->tstamp && skb->mono_delivery_time))
-			skb->mono_delivery_time = 0;
+		if (unlikely(!skb->tstamp && skb->tstamp_type))
+			skb->tstamp_type = SKB_CLOCK_REALTIME;
 
 		if (prog->exts_integrated) {
 			res->class   = 0;
-- 
2.25.1


