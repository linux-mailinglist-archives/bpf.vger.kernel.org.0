Return-Path: <bpf+bounces-28564-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C378D8BB956
	for <lists+bpf@lfdr.de>; Sat,  4 May 2024 05:14:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3FDA9281E28
	for <lists+bpf@lfdr.de>; Sat,  4 May 2024 03:14:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81A45107B3;
	Sat,  4 May 2024 03:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="NF/Umwb+"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0365AD59;
	Sat,  4 May 2024 03:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714792439; cv=none; b=qjbrhGzWSSabWlrtJH32MiXpe/g47rCFs0Qs1p8IHC1h0Y7yY3fE5Q9UxxXBcFx5/4G9zfkoSJtbTU46Dndi7PCUlJ84YAwZNy7Y/aEF7JLMEr7aAcp1/3CKH4B5JqJNyN6tZWyp40mSL8hdkEWl7/JeVjjjdNr/eNiyUjLf+Ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714792439; c=relaxed/simple;
	bh=uM+/RyG7VN48chvyFtw3Ujo+yjfMGtKBzvBfzI+Nt1s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tENINRSq4fUf/PIEoToONTek1GjhjTmfv2fYjx894sqfU8C2xgmPkw62CV9206eZI8ikT1XPvvebn5GQsWKOt+wVO7P8VEIbuakaD5piL39vWZEtCgJj/R3YMYx3JqX+PuJizlpD+9naCXy8170Lh2kQQYigFxmServs5VA/GLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=NF/Umwb+; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4443DZ4K030444;
	Sat, 4 May 2024 03:13:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=qcppdkim1; bh=h2+QXXv
	wcRLj9VoXIG2m8z7Bf5HOm1nKXXwdbAMtCeo=; b=NF/Umwb+6Lpn2NnAB1VNXDV
	ESwB/LoRL/WSmDax/W5MDBbibSzlsRjOPfzGYstGS8VAUI+xw13uQ13Xbi0WCAhV
	nKjf8gCgMfa7Jv/GrRcbVGTEfpV8esLETJNdU0PghfNe1kULa9dBKNglu7RuL/tc
	oOrJXUxs9CIu78W4qLPbNG498irhrvEJnXfurWWGM3FMVQCwbuEIsk+KlQC0s6Vr
	oCC9SNPho9KodHbQM+5GOzpOXcIXCJDVm5CNvVT9P/wmBzI7CCGBs2OEWJJc4oZz
	zufsDwAn3PS5mNe6L2/9KNEOldkzZ6p7eNEhzgTQyAb5E0YflMzZBmtQf93v6JA=
	=
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xv8vscb91-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 04 May 2024 03:13:35 +0000 (GMT)
Received: from pps.filterd (NALASPPMTA02.qualcomm.com [127.0.0.1])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 44433v0W027713;
	Sat, 4 May 2024 03:13:33 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by NALASPPMTA02.qualcomm.com (PPS) with ESMTPS id 3xvjwwju2u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 04 May 2024 03:13:33 +0000
Received: from NALASPPMTA02.qualcomm.com (NALASPPMTA02.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 4443DXG8005852;
	Sat, 4 May 2024 03:13:33 GMT
Received: from hu-devc-lv-u20-a-new.qualcomm.com (hu-abchauha-lv.qualcomm.com [10.81.25.35])
	by NALASPPMTA02.qualcomm.com (PPS) with ESMTPS id 4443DXJA005841
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 04 May 2024 03:13:33 +0000
Received: by hu-devc-lv-u20-a-new.qualcomm.com (Postfix, from userid 214165)
	id 9DA8223B02; Fri,  3 May 2024 20:13:31 -0700 (PDT)
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
Subject: [RFC PATCH bpf-next v6 2/3] net: Add additional bit to support clockid_t timestamp type
Date: Fri,  3 May 2024 20:13:30 -0700
Message-Id: <20240504031331.2737365-3-quic_abchauha@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240504031331.2737365-1-quic_abchauha@quicinc.com>
References: <20240504031331.2737365-1-quic_abchauha@quicinc.com>
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
X-Proofpoint-ORIG-GUID: _RU-2WP65qBAQh_hFsUP-SbH1dAubT55
X-Proofpoint-GUID: _RU-2WP65qBAQh_hFsUP-SbH1dAubT55
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-03_17,2024-05-03_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 suspectscore=0 priorityscore=1501 mlxscore=0 spamscore=0 adultscore=0
 impostorscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0 phishscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2405040022

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


 include/linux/skbuff.h   | 21 +++++++++++--------
 include/uapi/linux/bpf.h | 15 +++++++++-----
 net/core/filter.c        | 44 +++++++++++++++++++++++-----------------
 net/ipv4/ip_output.c     |  5 ++++-
 net/ipv4/raw.c           |  2 +-
 net/ipv6/ip6_output.c    |  5 ++++-
 net/ipv6/raw.c           |  2 +-
 net/packet/af_packet.c   |  7 +++----
 8 files changed, 61 insertions(+), 40 deletions(-)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index de3915e2bfdb..fe7d8dbef77e 100644
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
@@ -829,8 +831,7 @@ enum skb_tstamp_type {
  *	@decrypted: Decrypted SKB
  *	@slow_gro: state present at GRO time, slower prepare step required
  *	@tstamp_type: When set, skb->tstamp has the
- *		delivery_time in mono clock base Otherwise, the
- *		timestamp is considered real clock base.
+ *		delivery_time clock base of skb->tstamp.
  *	@napi_id: id of the NAPI struct this skb came from
  *	@sender_cpu: (aka @napi_id) source CPU in XPS
  *	@alloc_cpu: CPU which did the skb allocation.
@@ -958,7 +959,7 @@ struct sk_buff {
 	/* private: */
 	__u8			__mono_tc_offset[0];
 	/* public: */
-	__u8			tstamp_type:1;	/* See skb_tstamp_type */
+	__u8			tstamp_type:2;	/* See skb_tstamp_type */
 #ifdef CONFIG_NET_XGRESS
 	__u8			tc_at_ingress:1;	/* See TC_AT_INGRESS_MASK */
 	__u8			tc_skip_classify:1;
@@ -1088,15 +1089,16 @@ struct sk_buff {
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
 
@@ -4213,6 +4215,9 @@ static inline void skb_set_delivery_type_by_clockid(struct sk_buff *skb,
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
index a3781a796da4..9f3df4a0d1ee 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -7726,16 +7726,20 @@ BPF_CALL_3(bpf_skb_set_tstamp, struct sk_buff *, skb,
 		return -EOPNOTSUPP;
 
 	switch (tstamp_type) {
-	case BPF_SKB_TSTAMP_DELIVERY_MONO:
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
+		skb->tstamp = tstamp;
+		skb->tstamp_type = SKB_CLOCK_TAI;
+		break;
+	case BPF_SKB_CLOCK_REALTIME:
+		skb->tstamp = tstamp;
 		skb->tstamp_type = SKB_CLOCK_REALTIME;
 		break;
 	default:
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
index fe86cadfa85b..c3d852eecb01 100644
--- a/net/ipv4/ip_output.c
+++ b/net/ipv4/ip_output.c
@@ -1457,7 +1457,10 @@ struct sk_buff *__ip_make_skb(struct sock *sk,
 
 	skb->priority = (cork->tos != -1) ? cork->priority: READ_ONCE(sk->sk_priority);
 	skb->mark = cork->mark;
-	skb->tstamp = cork->transmit_time;
+	if (sk_is_tcp(sk))
+		skb_set_delivery_type_by_clockid(skb, cork->transmit_time, CLOCK_MONOTONIC);
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
 
diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
index 05067bd44775..797a9764e8fe 100644
--- a/net/ipv6/ip6_output.c
+++ b/net/ipv6/ip6_output.c
@@ -1924,7 +1924,10 @@ struct sk_buff *__ip6_make_skb(struct sock *sk,
 
 	skb->priority = READ_ONCE(sk->sk_priority);
 	skb->mark = cork->base.mark;
-	skb->tstamp = cork->base.transmit_time;
+	if (sk_is_tcp(sk))
+		skb_set_delivery_type_by_clockid(skb, cork->base.transmit_time, CLOCK_MONOTONIC);
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
-- 
2.25.1


