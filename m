Return-Path: <bpf+bounces-29314-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A25008C1835
	for <lists+bpf@lfdr.de>; Thu,  9 May 2024 23:19:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B85D1F22213
	for <lists+bpf@lfdr.de>; Thu,  9 May 2024 21:19:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BC9B8615E;
	Thu,  9 May 2024 21:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="W0V9pEU6"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE84C84FD2;
	Thu,  9 May 2024 21:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715289542; cv=none; b=hk77wtkwNWzDq8ViNSakTgY3fX6g16JodF+UTNgNaaonNo/29igfLY4zo8hk0EaKcL2d5EgCU8dBJtyzLvxknI4jJieUh2Ch4WZiGJXV5RiPCReS6YiVU9+3OK7alP8v5FqP8/cCNdNMqPkxoU5gCNhGaMPtrXuw/IG/iVKi8ME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715289542; c=relaxed/simple;
	bh=5DXi8BED8QS/GOyDmP1kRO4F2ptVb+lejPIHKj3b1cU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=osd+yZF4atsFgu4SzWgtC0sys5g7ugCZkET1e+e4C6+KxWMhEOpL4tamN/XwqK7vxL0s+k8wGxOJxn3IKbbiYe4/VcR19qzyRTbdimNRBieKjGn6JovtNRVHK8i6yfJl1/DjdT1Rc0PStjNfob8RWWQZ8zIgcXbB+6iHayEe1Qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=W0V9pEU6; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 449KtF0h000795;
	Thu, 9 May 2024 21:18:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=qcppdkim1; bh=goXAT7X
	/uaFuT2iyrv3ze/cTZ55McQu8t2zglXtTUJY=; b=W0V9pEU6UknqDDzSUO4aBDO
	vBfPdNWHI9EsyYArBU7NVf4aJMxua6LTcGr+2uqNyTf3lDFh/icM1Bm8pasJDSM6
	LixmE6q9jIGONiH41W9jU7IPx9hdGaCiEqpmKqshl9qu7atKFa75HALnIAC7DXou
	yY02R79scosWMigJdWzOtZhMK5qa8V/0iIQ68icxqCNSQGoV0cmTNy2rOZI07iKu
	hndLUOKiuNrj6pa8og4gsUeA6ji/xVMHzzPqno+55v+EhkZFqT+dIsFPw5Vwaoj2
	R+2NKcb1hhMAnCxdhop77CYSnqL84DwL9DDmJqJt0loIeetOoe+E2k5mIheKn1w=
	=
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3y09gekmrx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 09 May 2024 21:18:36 +0000 (GMT)
Received: from pps.filterd (NALASPPMTA01.qualcomm.com [127.0.0.1])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 449LIZ2x026852;
	Thu, 9 May 2024 21:18:35 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by NALASPPMTA01.qualcomm.com (PPS) with ESMTPS id 3y0njgg084-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 09 May 2024 21:18:35 +0000
Received: from NALASPPMTA01.qualcomm.com (NALASPPMTA01.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 449LIZAm026589;
	Thu, 9 May 2024 21:18:35 GMT
Received: from hu-devc-lv-u20-a-new.qualcomm.com (hu-abchauha-lv.qualcomm.com [10.81.25.35])
	by NALASPPMTA01.qualcomm.com (PPS) with ESMTPS id 449LIYMr026440
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 09 May 2024 21:18:35 +0000
Received: by hu-devc-lv-u20-a-new.qualcomm.com (Postfix, from userid 214165)
	id 5396523B02; Thu,  9 May 2024 14:18:34 -0700 (PDT)
From: Abhishek Chauhan <quic_abchauha@quicinc.com>
To: "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Andrew Halaney <ahalaney@redhat.com>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Daniel Borkmann <daniel@iogearbox.net>, bpf <bpf@vger.kernel.org>
Cc: kernel@quicinc.com, Willem de Bruijn <willemb@google.com>
Subject: [PATCH bpf-next v8 2/3] net: Add additional bit to support clockid_t timestamp type
Date: Thu,  9 May 2024 14:18:33 -0700
Message-Id: <20240509211834.3235191-3-quic_abchauha@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240509211834.3235191-1-quic_abchauha@quicinc.com>
References: <20240509211834.3235191-1-quic_abchauha@quicinc.com>
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
X-Proofpoint-GUID: NZGkcoCNf7J-7zXOHOnCauuCgeuC-XZy
X-Proofpoint-ORIG-GUID: NZGkcoCNf7J-7zXOHOnCauuCgeuC-XZy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-09_12,2024-05-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 suspectscore=0 phishscore=0 malwarescore=0
 mlxlogscore=999 impostorscore=0 clxscore=1015 adultscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405010000 definitions=main-2405090149

tstamp_type is now set based on actual clockid_t compressed
into 2 bits.

To make the design scalable for future needs this commit bring in
the change to extend the tstamp_type:1 to tstamp_type:2 to support
other clockid_t timestamp.

We now support CLOCK_TAI as part of tstamp_type as part of this
commit with existing support CLOCK_MONOTONIC and CLOCK_REALTIME.

Link: https://lore.kernel.org/netdev/bc037db4-58bb-4861-ac31-a361a93841d3@linux.dev/
Signed-off-by: Abhishek Chauhan <quic_abchauha@quicinc.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
Reviewed-by: Martin KaFai Lau <martin.lau@kernel.org>
---
Changes since v7
- Added reviewed by tags and removed RFC. 
- Moved tools/include/uapi/linux/bpf.h to this
  patch from patch 3.
- Fixed mis-spelled word exisiting to existing 
  in commit text.

Changes since v6
- bpf_skb_set_tstamp now order cases by their enum
  value, starting with realtime.
- custom socket now initialize the sk_clockid in files
  tcp_ipv4.c and tcp_ipv6.c

Changes since v5
- Took care of documentation comments of tstamp_type 
  in skbuff.h as mentioned by Willem.
- Use of complete words instead of abbrevation in 
  macro definitions as mentioned by Willem.
- Fixed indentation problems 
- Removed BPF_SKB_TSTAMP_UNSPEC and marked it 
  Deprecated as documentation, and introduced 
  BPF_SKB_CLOCK_REALTIME instead. 
- BUILD_BUG_ON for additional enums introduced.
- __ip_make_skb and ip6_make_skb now has 
  tcp checks to mark tcp packet as mono tstamp base. 
- separated the selftests/bpf changes into another patch.
- Made changes as per Martin in selftest bpf code and 
  tool/include/uapi/linux/bpf.h 

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


 include/linux/skbuff.h         | 18 ++++++++-----
 include/uapi/linux/bpf.h       | 15 +++++++----
 net/core/filter.c              | 46 +++++++++++++++++++---------------
 net/ipv4/ip_output.c           |  5 +++-
 net/ipv4/raw.c                 |  2 +-
 net/ipv4/tcp_ipv4.c            |  2 ++
 net/ipv6/ip6_output.c          |  5 +++-
 net/ipv6/raw.c                 |  2 +-
 net/ipv6/tcp_ipv6.c            | 10 ++++++--
 net/packet/af_packet.c         |  7 +++---
 tools/include/uapi/linux/bpf.h | 15 +++++++----
 11 files changed, 81 insertions(+), 46 deletions(-)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 05aec712d16d..fe7d8dbef77e 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -709,6 +709,8 @@ typedef unsigned char *sk_buff_data_t;
 enum skb_tstamp_type {
 	SKB_CLOCK_REALTIME,
 	SKB_CLOCK_MONOTONIC,
+	SKB_CLOCK_TAI,
+	__SKB_CLOCK_MAX = SKB_CLOCK_TAI,
 };
 
 /**
@@ -957,7 +959,7 @@ struct sk_buff {
 	/* private: */
 	__u8			__mono_tc_offset[0];
 	/* public: */
-	__u8			tstamp_type:1;	/* See skb_tstamp_type */
+	__u8			tstamp_type:2;	/* See skb_tstamp_type */
 #ifdef CONFIG_NET_XGRESS
 	__u8			tc_at_ingress:1;	/* See TC_AT_INGRESS_MASK */
 	__u8			tc_skip_classify:1;
@@ -1087,15 +1089,16 @@ struct sk_buff {
 #endif
 #define PKT_TYPE_OFFSET		offsetof(struct sk_buff, __pkt_type_offset)
 
-/* if you move tc_at_ingress or mono_delivery_time
+/* if you move tc_at_ingress or tstamp_type
  * around, you also must adapt these constants.
  */
 #ifdef __BIG_ENDIAN_BITFIELD
-#define SKB_MONO_DELIVERY_TIME_MASK	(1 << 7)
-#define TC_AT_INGRESS_MASK		(1 << 6)
+#define SKB_TSTAMP_TYPE_MASK		(3 << 6)
+#define SKB_TSTAMP_TYPE_RSHIFT		(6)
+#define TC_AT_INGRESS_MASK		(1 << 5)
 #else
-#define SKB_MONO_DELIVERY_TIME_MASK	(1 << 0)
-#define TC_AT_INGRESS_MASK		(1 << 1)
+#define SKB_TSTAMP_TYPE_MASK		(3)
+#define TC_AT_INGRESS_MASK		(1 << 2)
 #endif
 #define SKB_BF_MONO_TC_OFFSET		offsetof(struct sk_buff, __mono_tc_offset)
 
@@ -4212,6 +4215,9 @@ static inline void skb_set_delivery_type_by_clockid(struct sk_buff *skb,
 	case CLOCK_MONOTONIC:
 		tstamp_type = SKB_CLOCK_MONOTONIC;
 		break;
+	case CLOCK_TAI:
+		tstamp_type = SKB_CLOCK_TAI;
+		break;
 	default:
 		WARN_ON_ONCE(1);
 		kt = 0;
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 90706a47f6ff..25ea393cf084 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -6207,12 +6207,17 @@ union {					\
 	__u64 :64;			\
 } __attribute__((aligned(8)))
 
+/* The enum used in skb->tstamp_type. It specifies the clock type
+ * of the time stored in the skb->tstamp.
+ */
 enum {
-	BPF_SKB_TSTAMP_UNSPEC,
-	BPF_SKB_TSTAMP_DELIVERY_MONO,	/* tstamp has mono delivery time */
-	/* For any BPF_SKB_TSTAMP_* that the bpf prog cannot handle,
-	 * the bpf prog should handle it like BPF_SKB_TSTAMP_UNSPEC
-	 * and try to deduce it by ingress, egress or skb->sk->sk_clockid.
+	BPF_SKB_TSTAMP_UNSPEC = 0,		/* DEPRECATED */
+	BPF_SKB_TSTAMP_DELIVERY_MONO = 1,	/* DEPRECATED */
+	BPF_SKB_CLOCK_REALTIME = 0,
+	BPF_SKB_CLOCK_MONOTONIC = 1,
+	BPF_SKB_CLOCK_TAI = 2,
+	/* For any future BPF_SKB_CLOCK_* that the bpf prog cannot handle,
+	 * the bpf prog can try to deduce it by ingress/egress/skb->sk->sk_clockid.
 	 */
 };
 
diff --git a/net/core/filter.c b/net/core/filter.c
index a3781a796da4..c6edfe9f41bc 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -7726,17 +7726,21 @@ BPF_CALL_3(bpf_skb_set_tstamp, struct sk_buff *, skb,
 		return -EOPNOTSUPP;
 
 	switch (tstamp_type) {
-	case BPF_SKB_TSTAMP_DELIVERY_MONO:
+	case BPF_SKB_CLOCK_REALTIME:
+		skb->tstamp = tstamp;
+		skb->tstamp_type = SKB_CLOCK_REALTIME;
+		break;
+	case BPF_SKB_CLOCK_MONOTONIC:
 		if (!tstamp)
 			return -EINVAL;
 		skb->tstamp = tstamp;
 		skb->tstamp_type = SKB_CLOCK_MONOTONIC;
 		break;
-	case BPF_SKB_TSTAMP_UNSPEC:
-		if (tstamp)
+	case BPF_SKB_CLOCK_TAI:
+		if (!tstamp)
 			return -EINVAL;
-		skb->tstamp = 0;
-		skb->tstamp_type = SKB_CLOCK_REALTIME;
+		skb->tstamp = tstamp;
+		skb->tstamp_type = SKB_CLOCK_TAI;
 		break;
 	default:
 		return -EINVAL;
@@ -9387,16 +9391,17 @@ static struct bpf_insn *bpf_convert_tstamp_type_read(const struct bpf_insn *si,
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
+	BUILD_BUG_ON(__SKB_CLOCK_MAX != (int)BPF_SKB_CLOCK_TAI);
+	BUILD_BUG_ON(SKB_CLOCK_REALTIME != (int)BPF_SKB_CLOCK_REALTIME);
+	BUILD_BUG_ON(SKB_CLOCK_MONOTONIC != (int)BPF_SKB_CLOCK_MONOTONIC);
+	BUILD_BUG_ON(SKB_CLOCK_TAI != (int)BPF_SKB_CLOCK_TAI);
+	*insn++ = BPF_LDX_MEM(BPF_B, value_reg, skb_reg, SKB_BF_MONO_TC_OFFSET);
+	*insn++ = BPF_ALU32_IMM(BPF_AND, value_reg, SKB_TSTAMP_TYPE_MASK);
+#ifdef __BIG_ENDIAN_BITFIELD
+	*insn++ = BPF_ALU32_IMM(BPF_RSH, value_reg, SKB_TSTAMP_TYPE_RSHIFT);
+#else
+	BUILD_BUG_ON(!(SKB_TSTAMP_TYPE_MASK & 0x1));
+#endif
 
 	return insn;
 }
@@ -9439,10 +9444,11 @@ static struct bpf_insn *bpf_convert_tstamp_read(const struct bpf_prog *prog,
 		__u8 tmp_reg = BPF_REG_AX;
 
 		*insn++ = BPF_LDX_MEM(BPF_B, tmp_reg, skb_reg, SKB_BF_MONO_TC_OFFSET);
-		*insn++ = BPF_ALU32_IMM(BPF_AND, tmp_reg,
-					TC_AT_INGRESS_MASK | SKB_MONO_DELIVERY_TIME_MASK);
-		*insn++ = BPF_JMP32_IMM(BPF_JNE, tmp_reg,
-					TC_AT_INGRESS_MASK | SKB_MONO_DELIVERY_TIME_MASK, 2);
+		/* check if ingress mask bits is set */
+		*insn++ = BPF_JMP32_IMM(BPF_JSET, tmp_reg, TC_AT_INGRESS_MASK, 1);
+		*insn++ = BPF_JMP_A(4);
+		*insn++ = BPF_JMP32_IMM(BPF_JSET, tmp_reg, SKB_TSTAMP_TYPE_MASK, 1);
+		*insn++ = BPF_JMP_A(2);
 		/* skb->tc_at_ingress && skb->tstamp_type,
 		 * read 0 as the (rcv) timestamp.
 		 */
@@ -9479,7 +9485,7 @@ static struct bpf_insn *bpf_convert_tstamp_write(const struct bpf_prog *prog,
 		/* goto <store> */
 		*insn++ = BPF_JMP_A(2);
 		/* <clear>: skb->tstamp_type */
-		*insn++ = BPF_ALU32_IMM(BPF_AND, tmp_reg, ~SKB_MONO_DELIVERY_TIME_MASK);
+		*insn++ = BPF_ALU32_IMM(BPF_AND, tmp_reg, ~SKB_TSTAMP_TYPE_MASK);
 		*insn++ = BPF_STX_MEM(BPF_B, skb_reg, tmp_reg, SKB_BF_MONO_TC_OFFSET);
 	}
 #endif
diff --git a/net/ipv4/ip_output.c b/net/ipv4/ip_output.c
index fe86cadfa85b..b90d0f78ac80 100644
--- a/net/ipv4/ip_output.c
+++ b/net/ipv4/ip_output.c
@@ -1457,7 +1457,10 @@ struct sk_buff *__ip_make_skb(struct sock *sk,
 
 	skb->priority = (cork->tos != -1) ? cork->priority: READ_ONCE(sk->sk_priority);
 	skb->mark = cork->mark;
-	skb->tstamp = cork->transmit_time;
+	if (sk_is_tcp(sk))
+		skb_set_delivery_time(skb, cork->transmit_time, SKB_CLOCK_MONOTONIC);
+	else
+		skb_set_delivery_type_by_clockid(skb, cork->transmit_time, sk->sk_clockid);
 	/*
 	 * Steal rt from cork.dst to avoid a pair of atomic_inc/atomic_dec
 	 * on dst refcount
diff --git a/net/ipv4/raw.c b/net/ipv4/raw.c
index 4cb43401e0e0..1a0953650356 100644
--- a/net/ipv4/raw.c
+++ b/net/ipv4/raw.c
@@ -360,7 +360,7 @@ static int raw_send_hdrinc(struct sock *sk, struct flowi4 *fl4,
 	skb->protocol = htons(ETH_P_IP);
 	skb->priority = READ_ONCE(sk->sk_priority);
 	skb->mark = sockc->mark;
-	skb->tstamp = sockc->transmit_time;
+	skb_set_delivery_type_by_clockid(skb, sockc->transmit_time, sk->sk_clockid);
 	skb_dst_set(skb, &rt->dst);
 	*rtp = NULL;
 
diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index 95e3d28b83b8..46a8f1c11a91 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -3626,6 +3626,8 @@ void __init tcp_v4_init(void)
 		 */
 		inet_sk(sk)->pmtudisc = IP_PMTUDISC_DO;
 
+		sk->sk_clockid = CLOCK_MONOTONIC;
+
 		per_cpu(ipv4_tcp_sk, cpu) = sk;
 	}
 	if (register_pernet_subsys(&tcp_sk_ops))
diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
index 8fd5bf85c657..1985fbcf9b76 100644
--- a/net/ipv6/ip6_output.c
+++ b/net/ipv6/ip6_output.c
@@ -1924,7 +1924,10 @@ struct sk_buff *__ip6_make_skb(struct sock *sk,
 
 	skb->priority = READ_ONCE(sk->sk_priority);
 	skb->mark = cork->base.mark;
-	skb->tstamp = cork->base.transmit_time;
+	if (sk_is_tcp(sk))
+		skb_set_delivery_time(skb, cork->base.transmit_time, SKB_CLOCK_MONOTONIC);
+	else
+		skb_set_delivery_type_by_clockid(skb, cork->base.transmit_time, sk->sk_clockid);
 
 	ip6_cork_steal_dst(skb, cork);
 	IP6_INC_STATS(net, rt->rt6i_idev, IPSTATS_MIB_OUTREQUESTS);
diff --git a/net/ipv6/raw.c b/net/ipv6/raw.c
index 2eedf255600b..f838366e8256 100644
--- a/net/ipv6/raw.c
+++ b/net/ipv6/raw.c
@@ -621,7 +621,7 @@ static int rawv6_send_hdrinc(struct sock *sk, struct msghdr *msg, int length,
 	skb->protocol = htons(ETH_P_IPV6);
 	skb->priority = READ_ONCE(sk->sk_priority);
 	skb->mark = sockc->mark;
-	skb->tstamp = sockc->transmit_time;
+	skb_set_delivery_type_by_clockid(skb, sockc->transmit_time, sk->sk_clockid);
 
 	skb_put(skb, length);
 	skb_reset_network_header(skb);
diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index 16c545f0d064..fa3f8e43c7e6 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -2388,8 +2388,14 @@ static struct inet_protosw tcpv6_protosw = {
 
 static int __net_init tcpv6_net_init(struct net *net)
 {
-	return inet_ctl_sock_create(&net->ipv6.tcp_sk, PF_INET6,
-				    SOCK_RAW, IPPROTO_TCP, net);
+	int res;
+
+	res = inet_ctl_sock_create(&net->ipv6.tcp_sk, PF_INET6,
+				   SOCK_RAW, IPPROTO_TCP, net);
+	if (!res)
+		net->ipv6.tcp_sk->sk_clockid = CLOCK_MONOTONIC;
+
+	return res;
 }
 
 static void __net_exit tcpv6_net_exit(struct net *net)
diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
index 8c6d3fbb4ed8..89b54021d196 100644
--- a/net/packet/af_packet.c
+++ b/net/packet/af_packet.c
@@ -2056,8 +2056,7 @@ static int packet_sendmsg_spkt(struct socket *sock, struct msghdr *msg,
 	skb->dev = dev;
 	skb->priority = READ_ONCE(sk->sk_priority);
 	skb->mark = READ_ONCE(sk->sk_mark);
-	skb->tstamp = sockc.transmit_time;
-
+	skb_set_delivery_type_by_clockid(skb, sockc.transmit_time, sk->sk_clockid);
 	skb_setup_tx_timestamp(skb, sockc.tsflags);
 
 	if (unlikely(extra_len == 4))
@@ -2585,7 +2584,7 @@ static int tpacket_fill_skb(struct packet_sock *po, struct sk_buff *skb,
 	skb->dev = dev;
 	skb->priority = READ_ONCE(po->sk.sk_priority);
 	skb->mark = READ_ONCE(po->sk.sk_mark);
-	skb->tstamp = sockc->transmit_time;
+	skb_set_delivery_type_by_clockid(skb, sockc->transmit_time, po->sk.sk_clockid);
 	skb_setup_tx_timestamp(skb, sockc->tsflags);
 	skb_zcopy_set_nouarg(skb, ph.raw);
 
@@ -3063,7 +3062,7 @@ static int packet_snd(struct socket *sock, struct msghdr *msg, size_t len)
 	skb->dev = dev;
 	skb->priority = READ_ONCE(sk->sk_priority);
 	skb->mark = sockc.mark;
-	skb->tstamp = sockc.transmit_time;
+	skb_set_delivery_type_by_clockid(skb, sockc.transmit_time, sk->sk_clockid);
 
 	if (unlikely(extra_len == 4))
 		skb->no_fcs = 1;
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 90706a47f6ff..25ea393cf084 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -6207,12 +6207,17 @@ union {					\
 	__u64 :64;			\
 } __attribute__((aligned(8)))
 
+/* The enum used in skb->tstamp_type. It specifies the clock type
+ * of the time stored in the skb->tstamp.
+ */
 enum {
-	BPF_SKB_TSTAMP_UNSPEC,
-	BPF_SKB_TSTAMP_DELIVERY_MONO,	/* tstamp has mono delivery time */
-	/* For any BPF_SKB_TSTAMP_* that the bpf prog cannot handle,
-	 * the bpf prog should handle it like BPF_SKB_TSTAMP_UNSPEC
-	 * and try to deduce it by ingress, egress or skb->sk->sk_clockid.
+	BPF_SKB_TSTAMP_UNSPEC = 0,		/* DEPRECATED */
+	BPF_SKB_TSTAMP_DELIVERY_MONO = 1,	/* DEPRECATED */
+	BPF_SKB_CLOCK_REALTIME = 0,
+	BPF_SKB_CLOCK_MONOTONIC = 1,
+	BPF_SKB_CLOCK_TAI = 2,
+	/* For any future BPF_SKB_CLOCK_* that the bpf prog cannot handle,
+	 * the bpf prog can try to deduce it by ingress/egress/skb->sk->sk_clockid.
 	 */
 };
 
-- 
2.25.1


