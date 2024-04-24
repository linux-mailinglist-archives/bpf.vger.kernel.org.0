Return-Path: <bpf+bounces-27745-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DEE008B1619
	for <lists+bpf@lfdr.de>; Thu, 25 Apr 2024 00:21:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95BAE2854B4
	for <lists+bpf@lfdr.de>; Wed, 24 Apr 2024 22:21:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 757F016DEDC;
	Wed, 24 Apr 2024 22:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Hs6X4zx6"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEEEE16D4F4;
	Wed, 24 Apr 2024 22:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713997257; cv=none; b=WoFWjfVNTdgiW/OyArUFE1wutIuI48ylWGFKLY04Tgtwf/rXUXtiOCSOnMtLaSVXT9eJi1gCW4OTmsqYkmZ685M7zfOhKByzy/LMou36yXMrYh/qsz5oPEO4QQyWuv+6RUzGliI17lrH5Vq+Jp3RR2gbobeR3oInJGvquOClB6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713997257; c=relaxed/simple;
	bh=qgE2cJvnIVMINfQcSkOmaNFhoXDsV1zwnvKrXNoJ0Cg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Utbg181RQCy4/vRQtgMHcg1wd3V+oCLWaS2IYXhA70GLLyRVQsahMyPoBEXvZxYG0eycn/L+CkgTrgpdb/0D+6enCHel5m8YF5mNhMXp2SzxHc6Q3/C6CS5/ysW+MvAc2FE6AhRHfGxM2qm0RoTUqAvWQRzJNEwFxSD/+36TOyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Hs6X4zx6; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43OLoLlB013077;
	Wed, 24 Apr 2024 22:20:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=qcppdkim1; bh=tRnihiA
	uL2nafL4tSrdmhFMtWM6vRQGYpfHOpO2aCao=; b=Hs6X4zx6+KtAsYr5N6KCubk
	Y5QQCFeIhNlzUI9hDhnR4toQGVTCecBEAUxBLUCiAQQQKIQRBMtAZI7QEwF/ZuCz
	qBER+++k3pGMmvm0UxLZCJNTzhNMPlMeuWXvBOewdZIAcs9x2HZXAi1mJ+f76ryM
	MyAqXRqm88I6paCIEL6nfMhnLIUVhMG3DO7sFbuqGIOpR4qGfWZEckHobqVt/GQX
	1ScuBea02tgnTexD1jrau+oDoRlaL2xBAU7UfL2o0sQRLzLR7CNfpCpGmhI0Zl59
	rf4Q+hazuUIwtJVm8EN6IELN6Vn87sJx0yj0rd1iwd3tFbb+Ov0Qp0IJ/uFTmPQ=
	=
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xpv9e29ht-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Apr 2024 22:20:32 +0000 (GMT)
Received: from pps.filterd (NALASPPMTA01.qualcomm.com [127.0.0.1])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 43OMKT57015896;
	Wed, 24 Apr 2024 22:20:29 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by NALASPPMTA01.qualcomm.com (PPS) with ESMTPS id 3xq25e3n3p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Apr 2024 22:20:29 +0000
Received: from NALASPPMTA01.qualcomm.com (NALASPPMTA01.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 43OMKTpi015886;
	Wed, 24 Apr 2024 22:20:29 GMT
Received: from hu-devc-lv-u20-a-new.qualcomm.com (hu-abchauha-lv.qualcomm.com [10.81.25.35])
	by NALASPPMTA01.qualcomm.com (PPS) with ESMTPS id 43OMKT0I015882
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Apr 2024 22:20:29 +0000
Received: by hu-devc-lv-u20-a-new.qualcomm.com (Postfix, from userid 214165)
	id 5937522133; Wed, 24 Apr 2024 15:20:28 -0700 (PDT)
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
Subject: [RFC PATCH bpf-next v5 2/2] net: Add additional bit to support clockid_t timestamp type
Date: Wed, 24 Apr 2024 15:20:28 -0700
Message-Id: <20240424222028.1080134-3-quic_abchauha@quicinc.com>
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
X-Proofpoint-GUID: vuotoRSdXzxjAtKrmMJKIslitKf74QHz
X-Proofpoint-ORIG-GUID: vuotoRSdXzxjAtKrmMJKIslitKf74QHz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-24_19,2024-04-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 bulkscore=0
 priorityscore=1501 malwarescore=0 mlxscore=0 phishscore=0 mlxlogscore=999
 clxscore=1015 spamscore=0 adultscore=0 lowpriorityscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2404010003
 definitions=main-2404240115

tstamp_type is now set based on actual clockid_t compressed
into 2 bits.

To make the design scalable for future needs this commit bring in
the change to extend the tstamp_type:1 to tstamp_type:2 to support
other clockid_t timestamp.

We now support CLOCK_TAI as part of tstamp_type as part of this
commit with exisiting support CLOCK_MONOTONIC and CLOCK_REALTIME.

Link: https://lore.kernel.org/netdev/bc037db4-58bb-4861-ac31-a361a93841d3@linux.dev/
Signed-off-by: Abhishek Chauhan <quic_abchauha@quicinc.com>
---
Changes since v4
- Made changes to BPF code in filter.c as per 
  Martin's comments
- Minor fixes on comments given on documentation
  from Willem in skbuff.h (removed obvious ones)
- Made changes to ctx_rewrite.c and test_tc_dtime.c
- test_tc_dtime.c i am not really sure if i took care 
  of all the changes as i am not too familiar with 
  the framework.
- Introduce common mask SKB_TSTAMP_TYPE_MASK instead
  of multiple SKB mask.
- Optimisation on BPF code as suggested by Martin.
- Set default case to SKB_CLOCK_REALTME.  

Changes since v3
- Carefully reviewed BPF APIs and made changes in 
  BPF code as well. 
- Re-used actual clockid_t values since skbuff.h 
  indirectly includes uapi/linux/time.h
- Added CLOCK_TAI as part of the skb_set_delivery_time
  handling instead of CLOCK_USER
- Added default in switch for unsupported and invalid 
  timestamp with an WARN_ONCE
- All of the above comments were given by Willem  
- Made changes in filter.c as per Martin's comments
  to handle invalid cases in bpf code with addition of
  SKB_TAI_DELIVERY_TIME_MASK

Changes since v2
- Minor changes to commit subject

Changes since v1 
- identified additional changes in BPF framework.
- Bit shift in SKB_MONO_DELIVERY_TIME_MASK and TC_AT_INGRESS_MASK.
- Made changes in skb_set_delivery_time to keep changes similar to 
  previous code for mono_delivery_time and just setting tstamp_type
  bit 1 for userspace timestamp.

 include/linux/skbuff.h                        | 26 +++++++----
 include/uapi/linux/bpf.h                      |  1 +
 net/core/filter.c                             | 46 +++++++++++--------
 net/ipv4/ip_output.c                          |  2 +-
 net/ipv4/raw.c                                |  2 +-
 net/ipv6/ip6_output.c                         |  6 +--
 net/ipv6/raw.c                                |  2 +-
 net/packet/af_packet.c                        |  7 ++-
 .../selftests/bpf/prog_tests/ctx_rewrite.c    | 10 ++--
 .../selftests/bpf/progs/test_tc_dtime.c       | 24 ++++++++--
 10 files changed, 80 insertions(+), 46 deletions(-)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index e464d0ebc9c1..3ad0de07d261 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -711,6 +711,8 @@ typedef unsigned char *sk_buff_data_t;
 enum skb_tstamp_type {
 	SKB_CLOCK_REALTIME,
 	SKB_CLOCK_MONOTONIC,
+	SKB_CLOCK_TAI,
+	__SKB_CLOCK_MAX = SKB_CLOCK_TAI,
 };
 
 /**
@@ -831,8 +833,8 @@ enum skb_tstamp_type {
  *	@decrypted: Decrypted SKB
  *	@slow_gro: state present at GRO time, slower prepare step required
  *	@tstamp_type: When set, skb->tstamp has the
- *		delivery_time in mono clock base Otherwise, the
- *		timestamp is considered real clock base.
+ *		delivery_time in mono clock base or clock base of skb->tstamp.
+ *		Otherwise, the timestamp is considered real clock base
  *	@napi_id: id of the NAPI struct this skb came from
  *	@sender_cpu: (aka @napi_id) source CPU in XPS
  *	@alloc_cpu: CPU which did the skb allocation.
@@ -960,7 +962,7 @@ struct sk_buff {
 	/* private: */
 	__u8			__mono_tc_offset[0];
 	/* public: */
-	__u8			tstamp_type:1;	/* See skb_tstamp_type */
+	__u8			tstamp_type:2;	/* See skb_tstamp_type */
 #ifdef CONFIG_NET_XGRESS
 	__u8			tc_at_ingress:1;	/* See TC_AT_INGRESS_MASK */
 	__u8			tc_skip_classify:1;
@@ -1090,15 +1092,17 @@ struct sk_buff {
 #endif
 #define PKT_TYPE_OFFSET		offsetof(struct sk_buff, __pkt_type_offset)
 
-/* if you move tc_at_ingress or mono_delivery_time
+/* if you move tc_at_ingress or tstamp_type:2
  * around, you also must adapt these constants.
  */
 #ifdef __BIG_ENDIAN_BITFIELD
-#define SKB_MONO_DELIVERY_TIME_MASK	(1 << 7)
-#define TC_AT_INGRESS_MASK		(1 << 6)
+#define SKB_TSTAMP_TYPE_MASK		(3 << 6)
+#define SKB_TSTAMP_TYPE_RSH		(6)
+#define TC_AT_INGRESS_RSH		(5)
+#define TC_AT_INGRESS_MASK		(1 << 5)
 #else
-#define SKB_MONO_DELIVERY_TIME_MASK	(1 << 0)
-#define TC_AT_INGRESS_MASK		(1 << 1)
+#define SKB_TSTAMP_TYPE_MASK		(3)
+#define TC_AT_INGRESS_MASK		(1 << 2)
 #endif
 #define SKB_BF_MONO_TC_OFFSET		offsetof(struct sk_buff, __mono_tc_offset)
 
@@ -4204,6 +4208,12 @@ static inline void skb_set_tstamp_type_frm_clkid(struct sk_buff *skb,
 	case CLOCK_MONOTONIC:
 		skb->tstamp_type = SKB_CLOCK_MONOTONIC;
 		break;
+	case CLOCK_TAI:
+		skb->tstamp_type = SKB_CLOCK_TAI;
+		break;
+	default:
+		WARN_ONCE(true, "clockid %d not supported", clockid);
+		skb->tstamp_type = SKB_CLOCK_REALTIME;
 	}
 }
 
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index cee0a7915c08..1376ed5ece10 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -6209,6 +6209,7 @@ union {					\
 enum {
 	BPF_SKB_TSTAMP_UNSPEC,
 	BPF_SKB_TSTAMP_DELIVERY_MONO,	/* tstamp has mono delivery time */
+	BPF_SKB_TSTAMP_DELIVERY_TAI,	/* tstamp has tai delivery time */
 	/* For any BPF_SKB_TSTAMP_* that the bpf prog cannot handle,
 	 * the bpf prog should handle it like BPF_SKB_TSTAMP_UNSPEC
 	 * and try to deduce it by ingress, egress or skb->sk->sk_clockid.
diff --git a/net/core/filter.c b/net/core/filter.c
index 957c2fc724eb..c67622f4fe98 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -7733,6 +7733,12 @@ BPF_CALL_3(bpf_skb_set_tstamp, struct sk_buff *, skb,
 		skb->tstamp = tstamp;
 		skb->tstamp_type = SKB_CLOCK_MONOTONIC;
 		break;
+	case BPF_SKB_TSTAMP_DELIVERY_TAI:
+		if (!tstamp)
+			return -EINVAL;
+		skb->tstamp = tstamp;
+		skb->tstamp_type = SKB_CLOCK_TAI;
+		break;
 	case BPF_SKB_TSTAMP_UNSPEC:
 		if (tstamp)
 			return -EINVAL;
@@ -9388,17 +9394,17 @@ static struct bpf_insn *bpf_convert_tstamp_type_read(const struct bpf_insn *si,
 {
 	__u8 value_reg = si->dst_reg;
 	__u8 skb_reg = si->src_reg;
-	/* AX is needed because src_reg and dst_reg could be the same */
-	__u8 tmp_reg = BPF_REG_AX;
-
-	*insn++ = BPF_LDX_MEM(BPF_B, tmp_reg, skb_reg,
-			      SKB_BF_MONO_TC_OFFSET);
-	*insn++ = BPF_JMP32_IMM(BPF_JSET, tmp_reg,
-				SKB_MONO_DELIVERY_TIME_MASK, 2);
-	*insn++ = BPF_MOV32_IMM(value_reg, BPF_SKB_TSTAMP_UNSPEC);
-	*insn++ = BPF_JMP_A(1);
-	*insn++ = BPF_MOV32_IMM(value_reg, BPF_SKB_TSTAMP_DELIVERY_MONO);
-
+	BUILD_BUG_ON(__SKB_CLOCK_MAX != BPF_SKB_TSTAMP_DELIVERY_TAI);
+	*insn++ = BPF_LDX_MEM(BPF_B, value_reg, skb_reg, SKB_BF_MONO_TC_OFFSET);
+	*insn++ = BPF_ALU32_IMM(BPF_AND, value_reg, SKB_TSTAMP_TYPE_MASK);
+#ifdef __BIG_ENDIAN_BITFIELD
+	*insn++ = BPF_ALU32_IMM(BPF_RSH, value_reg, SKB_TSTAMP_TYPE_RSH);
+#else
+	BUILD_BUG_ON(!(SKB_TSTAMP_TYPE_MASK & 0x1));
+#endif
+	*insn++ = BPF_JMP32_IMM(BPF_JNE, value_reg, SKB_TSTAMP_TYPE_MASK, 1);
+	/* Both the bits set then mark it BPF_SKB_TSTAMP_UNSPEC */
+	*insn++ = BPF_MOV64_IMM(value_reg, BPF_SKB_TSTAMP_UNSPEC);
 	return insn;
 }
 
@@ -9430,6 +9436,7 @@ static struct bpf_insn *bpf_convert_tstamp_read(const struct bpf_prog *prog,
 	__u8 value_reg = si->dst_reg;
 	__u8 skb_reg = si->src_reg;
 
+BUILD_BUG_ON(__SKB_CLOCK_MAX != BPF_SKB_TSTAMP_DELIVERY_TAI);
 #ifdef CONFIG_NET_XGRESS
 	/* If the tstamp_type is read,
 	 * the bpf prog is aware the tstamp could have delivery time.
@@ -9440,11 +9447,12 @@ static struct bpf_insn *bpf_convert_tstamp_read(const struct bpf_prog *prog,
 		__u8 tmp_reg = BPF_REG_AX;
 
 		*insn++ = BPF_LDX_MEM(BPF_B, tmp_reg, skb_reg, SKB_BF_MONO_TC_OFFSET);
-		*insn++ = BPF_ALU32_IMM(BPF_AND, tmp_reg,
-					TC_AT_INGRESS_MASK | SKB_MONO_DELIVERY_TIME_MASK);
-		*insn++ = BPF_JMP32_IMM(BPF_JNE, tmp_reg,
-					TC_AT_INGRESS_MASK | SKB_MONO_DELIVERY_TIME_MASK, 2);
-		/* skb->tc_at_ingress && skb->tstamp_type:1,
+		/* check if ingress mask bits is set */
+		*insn++ = BPF_JMP32_IMM(BPF_JSET, tmp_reg, TC_AT_INGRESS_MASK, 1);
+		*insn++ = BPF_JMP_A(4);
+		*insn++ = BPF_JMP32_IMM(BPF_JSET, tmp_reg, SKB_TSTAMP_TYPE_MASK, 1);
+		*insn++ = BPF_JMP_A(2);
+		/* skb->tc_at_ingress && skb->tstamp_type:2,
 		 * read 0 as the (rcv) timestamp.
 		 */
 		*insn++ = BPF_MOV64_IMM(value_reg, 0);
@@ -9469,7 +9477,7 @@ static struct bpf_insn *bpf_convert_tstamp_write(const struct bpf_prog *prog,
 	 * the bpf prog is aware the tstamp could have delivery time.
 	 * Thus, write skb->tstamp as is if tstamp_type_access is true.
 	 * Otherwise, writing at ingress will have to clear the
-	 * mono_delivery_time (skb->tstamp_type:1)bit also.
+	 * mono_delivery_time (skb->tstamp_type:2)bit also.
 	 */
 	if (!prog->tstamp_type_access) {
 		__u8 tmp_reg = BPF_REG_AX;
@@ -9479,8 +9487,8 @@ static struct bpf_insn *bpf_convert_tstamp_write(const struct bpf_prog *prog,
 		*insn++ = BPF_JMP32_IMM(BPF_JSET, tmp_reg, TC_AT_INGRESS_MASK, 1);
 		/* goto <store> */
 		*insn++ = BPF_JMP_A(2);
-		/* <clear>: mono_delivery_time or (skb->tstamp_type:1) */
-		*insn++ = BPF_ALU32_IMM(BPF_AND, tmp_reg, ~SKB_MONO_DELIVERY_TIME_MASK);
+		/* <clear>: skb->tstamp_type:2 */
+		*insn++ = BPF_ALU32_IMM(BPF_AND, tmp_reg, ~SKB_TSTAMP_TYPE_MASK);
 		*insn++ = BPF_STX_MEM(BPF_B, skb_reg, tmp_reg, SKB_BF_MONO_TC_OFFSET);
 	}
 #endif
diff --git a/net/ipv4/ip_output.c b/net/ipv4/ip_output.c
index 591226dcde26..f195b31d6e75 100644
--- a/net/ipv4/ip_output.c
+++ b/net/ipv4/ip_output.c
@@ -1457,7 +1457,7 @@ struct sk_buff *__ip_make_skb(struct sock *sk,
 
 	skb->priority = (cork->tos != -1) ? cork->priority: READ_ONCE(sk->sk_priority);
 	skb->mark = cork->mark;
-	skb->tstamp = cork->transmit_time;
+	skb_set_tstamp_type_frm_clkid(skb, cork->transmit_time, sk->sk_clockid);
 	/*
 	 * Steal rt from cork.dst to avoid a pair of atomic_inc/atomic_dec
 	 * on dst refcount
diff --git a/net/ipv4/raw.c b/net/ipv4/raw.c
index dcb11f22cbf2..8b370369cdd8 100644
--- a/net/ipv4/raw.c
+++ b/net/ipv4/raw.c
@@ -360,7 +360,7 @@ static int raw_send_hdrinc(struct sock *sk, struct flowi4 *fl4,
 	skb->protocol = htons(ETH_P_IP);
 	skb->priority = READ_ONCE(sk->sk_priority);
 	skb->mark = sockc->mark;
-	skb->tstamp = sockc->transmit_time;
+	skb_set_tstamp_type_frm_clkid(skb, sockc->transmit_time, sk->sk_clockid);
 	skb_dst_set(skb, &rt->dst);
 	*rtp = NULL;
 
diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
index a9e819115622..63e4cc30d18d 100644
--- a/net/ipv6/ip6_output.c
+++ b/net/ipv6/ip6_output.c
@@ -955,7 +955,7 @@ int ip6_fragment(struct net *net, struct sock *sk, struct sk_buff *skb,
 			if (iter.frag)
 				ip6_fraglist_prepare(skb, &iter);
 
-			skb_set_delivery_time(skb, tstamp, tstamp_type);
+			skb_set_tstamp_type_frm_clkid(skb, tstamp, tstamp_type);
 			err = output(net, sk, skb);
 			if (!err)
 				IP6_INC_STATS(net, ip6_dst_idev(&rt->dst),
@@ -1016,7 +1016,7 @@ int ip6_fragment(struct net *net, struct sock *sk, struct sk_buff *skb,
 		/*
 		 *	Put this fragment into the sending queue.
 		 */
-		skb_set_delivery_time(frag, tstamp, tstamp_type);
+		skb_set_tstamp_type_frm_clkid(frag, tstamp, tstamp_type);
 		err = output(net, sk, frag);
 		if (err)
 			goto fail;
@@ -1924,7 +1924,7 @@ struct sk_buff *__ip6_make_skb(struct sock *sk,
 
 	skb->priority = READ_ONCE(sk->sk_priority);
 	skb->mark = cork->base.mark;
-	skb->tstamp = cork->base.transmit_time;
+	skb_set_tstamp_type_frm_clkid(skb, cork->base.transmit_time, sk->sk_clockid);
 
 	ip6_cork_steal_dst(skb, cork);
 	IP6_INC_STATS(net, rt->rt6i_idev, IPSTATS_MIB_OUTREQUESTS);
diff --git a/net/ipv6/raw.c b/net/ipv6/raw.c
index 0d896ca7b589..5649362577ab 100644
--- a/net/ipv6/raw.c
+++ b/net/ipv6/raw.c
@@ -621,7 +621,7 @@ static int rawv6_send_hdrinc(struct sock *sk, struct msghdr *msg, int length,
 	skb->protocol = htons(ETH_P_IPV6);
 	skb->priority = READ_ONCE(sk->sk_priority);
 	skb->mark = sockc->mark;
-	skb->tstamp = sockc->transmit_time;
+	skb_set_tstamp_type_frm_clkid(skb, sockc->transmit_time, sk->sk_clockid);
 
 	skb_put(skb, length);
 	skb_reset_network_header(skb);
diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
index 8c6d3fbb4ed8..6a4a86c26d2a 100644
--- a/net/packet/af_packet.c
+++ b/net/packet/af_packet.c
@@ -2056,8 +2056,7 @@ static int packet_sendmsg_spkt(struct socket *sock, struct msghdr *msg,
 	skb->dev = dev;
 	skb->priority = READ_ONCE(sk->sk_priority);
 	skb->mark = READ_ONCE(sk->sk_mark);
-	skb->tstamp = sockc.transmit_time;
-
+	skb_set_tstamp_type_frm_clkid(skb, sockc.transmit_time, sk->sk_clockid);
 	skb_setup_tx_timestamp(skb, sockc.tsflags);
 
 	if (unlikely(extra_len == 4))
@@ -2585,7 +2584,7 @@ static int tpacket_fill_skb(struct packet_sock *po, struct sk_buff *skb,
 	skb->dev = dev;
 	skb->priority = READ_ONCE(po->sk.sk_priority);
 	skb->mark = READ_ONCE(po->sk.sk_mark);
-	skb->tstamp = sockc->transmit_time;
+	skb_set_tstamp_type_frm_clkid(skb, sockc->transmit_time, po->sk.sk_clockid);
 	skb_setup_tx_timestamp(skb, sockc->tsflags);
 	skb_zcopy_set_nouarg(skb, ph.raw);
 
@@ -3063,7 +3062,7 @@ static int packet_snd(struct socket *sock, struct msghdr *msg, size_t len)
 	skb->dev = dev;
 	skb->priority = READ_ONCE(sk->sk_priority);
 	skb->mark = sockc.mark;
-	skb->tstamp = sockc.transmit_time;
+	skb_set_tstamp_type_frm_clkid(skb, sockc.transmit_time, sk->sk_clockid);
 
 	if (unlikely(extra_len == 4))
 		skb->no_fcs = 1;
diff --git a/tools/testing/selftests/bpf/prog_tests/ctx_rewrite.c b/tools/testing/selftests/bpf/prog_tests/ctx_rewrite.c
index 3b7c57fe55a5..71940f4ef0fb 100644
--- a/tools/testing/selftests/bpf/prog_tests/ctx_rewrite.c
+++ b/tools/testing/selftests/bpf/prog_tests/ctx_rewrite.c
@@ -69,15 +69,17 @@ static struct test_case test_cases[] = {
 	{
 		N(SCHED_CLS, struct __sk_buff, tstamp),
 		.read  = "r11 = *(u8 *)($ctx + sk_buff::__mono_tc_offset);"
-			 "w11 &= 3;"
-			 "if w11 != 0x3 goto pc+2;"
+			 "if w11 == 0x4 goto pc+1;"
+			 "goto pc+4;"
+			 "if w11 == 0x3 goto pc+1;"
+			 "goto pc+2;"
 			 "$dst = 0;"
 			 "goto pc+1;"
 			 "$dst = *(u64 *)($ctx + sk_buff::tstamp);",
 		.write = "r11 = *(u8 *)($ctx + sk_buff::__mono_tc_offset);"
-			 "if w11 & 0x2 goto pc+1;"
+			 "if w11 & 0x4 goto pc+1;"
 			 "goto pc+2;"
-			 "w11 &= -2;"
+			 "w11 &= -3;"
 			 "*(u8 *)($ctx + sk_buff::__mono_tc_offset) = r11;"
 			 "*(u64 *)($ctx + sk_buff::tstamp) = $src;",
 	},
diff --git a/tools/testing/selftests/bpf/progs/test_tc_dtime.c b/tools/testing/selftests/bpf/progs/test_tc_dtime.c
index 74ec09f040b7..19dba6d88265 100644
--- a/tools/testing/selftests/bpf/progs/test_tc_dtime.c
+++ b/tools/testing/selftests/bpf/progs/test_tc_dtime.c
@@ -227,6 +227,12 @@ int egress_host(struct __sk_buff *skb)
 			inc_dtimes(EGRESS_ENDHOST);
 		else
 			inc_errs(EGRESS_ENDHOST);
+	} else if (skb_proto(skb_type) == IPPROTO_UDP) {
+		if (skb->tstamp_type == BPF_SKB_TSTAMP_DELIVERY_TAI &&
+		    skb->tstamp)
+			inc_dtimes(EGRESS_ENDHOST);
+		else
+			inc_errs(EGRESS_ENDHOST);
 	} else {
 		if (skb->tstamp_type == BPF_SKB_TSTAMP_UNSPEC &&
 		    skb->tstamp)
@@ -255,6 +261,9 @@ int ingress_host(struct __sk_buff *skb)
 	if (skb->tstamp_type == BPF_SKB_TSTAMP_DELIVERY_MONO &&
 	    skb->tstamp == EGRESS_FWDNS_MAGIC)
 		inc_dtimes(INGRESS_ENDHOST);
+	else if (skb->tstamp_type == BPF_SKB_TSTAMP_DELIVERY_TAI &&
+		       skb->tstamp == EGRESS_FWDNS_MAGIC)
+		inc_dtimes(INGRESS_ENDHOST);
 	else
 		inc_errs(INGRESS_ENDHOST);
 
@@ -323,12 +332,14 @@ int ingress_fwdns_prio101(struct __sk_buff *skb)
 		/* Should have handled in prio100 */
 		return TC_ACT_SHOT;
 
-	if (skb_proto(skb_type) == IPPROTO_UDP)
+	if (skb_proto(skb_type) == IPPROTO_UDP &&
+		  skb->tstamp_type != BPF_SKB_TSTAMP_DELIVERY_TAI)
 		expected_dtime = 0;
 
 	if (skb->tstamp_type) {
 		if (fwdns_clear_dtime() ||
-		    skb->tstamp_type != BPF_SKB_TSTAMP_DELIVERY_MONO ||
+		    (skb->tstamp_type != BPF_SKB_TSTAMP_DELIVERY_MONO &&
+		    skb->tstamp_type != BPF_SKB_TSTAMP_DELIVERY_TAI) ||
 		    skb->tstamp != expected_dtime)
 			inc_errs(INGRESS_FWDNS_P101);
 		else
@@ -338,7 +349,8 @@ int ingress_fwdns_prio101(struct __sk_buff *skb)
 			inc_errs(INGRESS_FWDNS_P101);
 	}
 
-	if (skb->tstamp_type == BPF_SKB_TSTAMP_DELIVERY_MONO) {
+	if (skb->tstamp_type == BPF_SKB_TSTAMP_DELIVERY_MONO ||
+		  skb->tstamp_type == BPF_SKB_TSTAMP_DELIVERY_TAI) {
 		skb->tstamp = INGRESS_FWDNS_MAGIC;
 	} else {
 		if (bpf_skb_set_tstamp(skb, INGRESS_FWDNS_MAGIC,
@@ -370,7 +382,8 @@ int egress_fwdns_prio101(struct __sk_buff *skb)
 
 	if (skb->tstamp_type) {
 		if (fwdns_clear_dtime() ||
-		    skb->tstamp_type != BPF_SKB_TSTAMP_DELIVERY_MONO ||
+		    (skb->tstamp_type != BPF_SKB_TSTAMP_DELIVERY_MONO &&
+		     skb->tstamp_type != BPF_SKB_TSTAMP_DELIVERY_TAI) ||
 		    skb->tstamp != INGRESS_FWDNS_MAGIC)
 			inc_errs(EGRESS_FWDNS_P101);
 		else
@@ -380,7 +393,8 @@ int egress_fwdns_prio101(struct __sk_buff *skb)
 			inc_errs(EGRESS_FWDNS_P101);
 	}
 
-	if (skb->tstamp_type == BPF_SKB_TSTAMP_DELIVERY_MONO) {
+	if (skb->tstamp_type == BPF_SKB_TSTAMP_DELIVERY_MONO ||
+		  skb->tstamp_type == BPF_SKB_TSTAMP_DELIVERY_TAI) {
 		skb->tstamp = EGRESS_FWDNS_MAGIC;
 	} else {
 		if (bpf_skb_set_tstamp(skb, EGRESS_FWDNS_MAGIC,
-- 
2.25.1


