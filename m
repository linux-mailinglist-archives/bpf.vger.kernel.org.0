Return-Path: <bpf+bounces-27090-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5289A8A901B
	for <lists+bpf@lfdr.de>; Thu, 18 Apr 2024 02:43:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0790E282B06
	for <lists+bpf@lfdr.de>; Thu, 18 Apr 2024 00:43:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 083BA6116;
	Thu, 18 Apr 2024 00:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="O3x8Zr+q"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5E1E817;
	Thu, 18 Apr 2024 00:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713401014; cv=none; b=HkBbp2oEbmOFI19H9A7B0ozudfOf6ezFRw5hHE45HDZyNJzmNTcj3vrQkKmUrfCTBiRJD01P5njDzfyffBEZZAfPcqk2I06AgqJTXufzEOhVKBmL17U0ZTGIHdjdUop05PCxgVyER3vr4DKm3LSBFoitF+AwQBsYzBHWKmngWRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713401014; c=relaxed/simple;
	bh=K9IrT5hk5i1L5atc0AX3jnLghQtoms5HfxM8mxo6hSg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Fbr9cIvTusVDURWt2KgiFh2lNOtAQL3EF/zGqVB3wikLtUhelFNYEwPQ6p2/yGvskd9pYYuexXDQdxEnv5KFXfL+Hqhz8hmzbv6wi2j0kAg4rKysgeWeDaY1ac0ApFxD01uP+pj3EeGZojZnkHaU1AYVxqab/9byD2CPg8VHxAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=O3x8Zr+q; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43HNmbek015743;
	Thu, 18 Apr 2024 00:43:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=qcppdkim1; bh=H9rH3ft
	F5DX0Qysq72cAS8A5jzstsSbXbMANg6pF9sQ=; b=O3x8Zr+qybt7cq1Mvc69Dic
	cDEZkBxbtPu5NtxvTJTHNpzZuG+M3nJ9RH/Eoj/+vyn6jzrGSMYaf3/TXnYTBD44
	fqxBemlSM6pD25nV5NvnAs0Ibi50ZujrgkNqG+p4P9yWyCW/rpsZBTjupiQQ5wvu
	WVi17JU337DZMY4uZa8g5kXGT4kPVw7XqEvc8N+RezScd1Ea//9qpaenusqxRBQc
	cHJn3Rsk18XYC0CnTlFxCU3b/N+McGyUYaGWDhlUfLi7SLw9mevHZnWrVY0z4GUv
	A/4ozwCpwOzXx0R51Pcd427ImZxg8rvUOTpAQ1S76T7BpU7EtZLafxqNEPE1vZA=
	=
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xjrdbg3a8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Apr 2024 00:43:11 +0000 (GMT)
Received: from pps.filterd (NALASPPMTA04.qualcomm.com [127.0.0.1])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 43I0g5Hb023763;
	Thu, 18 Apr 2024 00:43:09 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by NALASPPMTA04.qualcomm.com (PPS) with ESMTPS id 3xj8myfdpj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Apr 2024 00:43:09 +0000
Received: from NALASPPMTA04.qualcomm.com (NALASPPMTA04.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 43I0f9Zk022970;
	Thu, 18 Apr 2024 00:43:09 GMT
Received: from hu-devc-lv-u20-a-new.qualcomm.com (hu-abchauha-lv.qualcomm.com [10.81.25.35])
	by NALASPPMTA04.qualcomm.com (PPS) with ESMTPS id 43I0h9II026807
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Apr 2024 00:43:09 +0000
Received: by hu-devc-lv-u20-a-new.qualcomm.com (Postfix, from userid 214165)
	id BAB5E23975; Wed, 17 Apr 2024 17:43:08 -0700 (PDT)
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
Subject: [RFC PATCH bpf-next v4 2/2] net: Add additional bit to support clockid_t timestamp type
Date: Wed, 17 Apr 2024 17:43:08 -0700
Message-Id: <20240418004308.1009262-3-quic_abchauha@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240418004308.1009262-1-quic_abchauha@quicinc.com>
References: <20240418004308.1009262-1-quic_abchauha@quicinc.com>
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
X-Proofpoint-GUID: 7SWxrjnE-QCXaILwEvxVq2JernteLvvB
X-Proofpoint-ORIG-GUID: 7SWxrjnE-QCXaILwEvxVq2JernteLvvB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-17_19,2024-04-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 impostorscore=0
 bulkscore=0 lowpriorityscore=0 clxscore=1015 adultscore=0 malwarescore=0
 spamscore=0 priorityscore=1501 suspectscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2404010003
 definitions=main-2404180001

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
Changes since v3
- Carefully reviewed BPF APIs and made changes in 
  BPF code as well. 
- Re-used actual clockid_t values since skbuff.h 
  indirectly includes uapi/linux/time.h
- Added CLOCK_TAI as part of the skb_set_delivery_time
  handling instead of CLOCK_USER
- Added default in switch for unsupported and invalid 
  timestamp with an WARN_ONCE.
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

 include/linux/skbuff.h                        | 21 +++++++---
 include/uapi/linux/bpf.h                      |  1 +
 net/core/filter.c                             | 40 ++++++++++++++++---
 net/ipv4/ip_output.c                          |  2 +-
 net/ipv4/raw.c                                |  2 +-
 net/ipv6/ip6_output.c                         |  2 +-
 net/ipv6/raw.c                                |  2 +-
 net/packet/af_packet.c                        |  7 ++--
 .../selftests/bpf/prog_tests/ctx_rewrite.c    | 13 ++++--
 9 files changed, 68 insertions(+), 22 deletions(-)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 2e7811c7e4db..647522ef41cd 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -703,14 +703,17 @@ typedef unsigned char *sk_buff_data_t;
 #endif
 
 /**
- * tstamp_type:1 can take 2 values each
+ * tstamp_type:2 can take 4 values each
  * represented by time base in skb
  * 0x0 => real timestamp_type
  * 0x1 => mono timestamp_type
+ * 0x2 => tai timestamp_type
+ * 0x3 => undefined timestamp_type
  */
 enum skb_tstamp_type {
 	SKB_CLOCK_REAL,	/* Time base is skb is REALTIME */
 	SKB_CLOCK_MONO,	/* Time base is skb is MONOTONIC */
+	SKB_CLOCK_TAI,	/* Time base in skb is TAI */
 };
 
 /**
@@ -833,7 +836,8 @@ enum skb_tstamp_type {
  *	@tstamp_type: When set, skb->tstamp has the
  *		delivery_time in mono clock base (i.e. EDT).  Otherwise, the
  *		skb->tstamp has the (rcv) timestamp at ingress and
- *		delivery_time at egress.
+ *		delivery_time at egress or skb->tstamp defined by skb->sk->sk_clockid
+ *		coming from userspace
  *	@napi_id: id of the NAPI struct this skb came from
  *	@sender_cpu: (aka @napi_id) source CPU in XPS
  *	@alloc_cpu: CPU which did the skb allocation.
@@ -961,7 +965,7 @@ struct sk_buff {
 	/* private: */
 	__u8			__mono_tc_offset[0];
 	/* public: */
-	__u8			tstamp_type:1;	/* See SKB_CLOCK_*_MASK */
+	__u8			tstamp_type:2;	/* See skb_tstamp_type enum */
 #ifdef CONFIG_NET_XGRESS
 	__u8			tc_at_ingress:1;	/* See TC_AT_INGRESS_MASK */
 	__u8			tc_skip_classify:1;
@@ -1096,10 +1100,12 @@ struct sk_buff {
  */
 #ifdef __BIG_ENDIAN_BITFIELD
 #define SKB_MONO_DELIVERY_TIME_MASK	(1 << 7)
-#define TC_AT_INGRESS_MASK		(1 << 6)
+#define SKB_TAI_DELIVERY_TIME_MASK	(1 << 6)
+#define TC_AT_INGRESS_MASK		(1 << 5)
 #else
 #define SKB_MONO_DELIVERY_TIME_MASK	(1 << 0)
-#define TC_AT_INGRESS_MASK		(1 << 1)
+#define SKB_TAI_DELIVERY_TIME_MASK	(1 << 1)
+#define TC_AT_INGRESS_MASK		(1 << 2)
 #endif
 #define SKB_BF_MONO_TC_OFFSET		offsetof(struct sk_buff, __mono_tc_offset)
 
@@ -4206,6 +4212,11 @@ static inline void skb_set_delivery_time(struct sk_buff *skb, ktime_t kt,
 	case CLOCK_MONOTONIC:
 		skb->tstamp_type = SKB_CLOCK_MONO;
 		break;
+	case CLOCK_TAI:
+		skb->tstamp_type = SKB_CLOCK_TAI;
+		break;
+	default:
+		WARN_ONCE(true, "clockid %d not supported", tstamp_type);
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
index b1192e672cbb..de86c42b5859 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -7711,6 +7711,12 @@ BPF_CALL_3(bpf_skb_set_tstamp, struct sk_buff *, skb,
 		skb->tstamp = tstamp;
 		skb->tstamp_type = SKB_CLOCK_MONO;
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
@@ -9372,10 +9378,16 @@ static struct bpf_insn *bpf_convert_tstamp_type_read(const struct bpf_insn *si,
 	*insn++ = BPF_LDX_MEM(BPF_B, tmp_reg, skb_reg,
 			      SKB_BF_MONO_TC_OFFSET);
 	*insn++ = BPF_JMP32_IMM(BPF_JSET, tmp_reg,
-				SKB_MONO_DELIVERY_TIME_MASK, 2);
+				SKB_MONO_DELIVERY_TIME_MASK | SKB_TAI_DELIVERY_TIME_MASK, 2);
+	*insn++ = BPF_JMP32_IMM(BPF_JSET, tmp_reg,
+				SKB_MONO_DELIVERY_TIME_MASK, 3);
+	*insn++ = BPF_JMP32_IMM(BPF_JSET, tmp_reg,
+				SKB_TAI_DELIVERY_TIME_MASK, 4);
 	*insn++ = BPF_MOV32_IMM(value_reg, BPF_SKB_TSTAMP_UNSPEC);
 	*insn++ = BPF_JMP_A(1);
 	*insn++ = BPF_MOV32_IMM(value_reg, BPF_SKB_TSTAMP_DELIVERY_MONO);
+	*insn++ = BPF_JMP_A(1);
+	*insn++ = BPF_MOV32_IMM(value_reg, BPF_SKB_TSTAMP_DELIVERY_TAI);
 
 	return insn;
 }
@@ -9418,10 +9430,26 @@ static struct bpf_insn *bpf_convert_tstamp_read(const struct bpf_prog *prog,
 		__u8 tmp_reg = BPF_REG_AX;
 
 		*insn++ = BPF_LDX_MEM(BPF_B, tmp_reg, skb_reg, SKB_BF_MONO_TC_OFFSET);
+		/*check if all three bits are set*/
 		*insn++ = BPF_ALU32_IMM(BPF_AND, tmp_reg,
-					TC_AT_INGRESS_MASK | SKB_MONO_DELIVERY_TIME_MASK);
-		*insn++ = BPF_JMP32_IMM(BPF_JNE, tmp_reg,
-					TC_AT_INGRESS_MASK | SKB_MONO_DELIVERY_TIME_MASK, 2);
+					TC_AT_INGRESS_MASK | SKB_MONO_DELIVERY_TIME_MASK |
+					SKB_TAI_DELIVERY_TIME_MASK);
+		/*if all 3 bits are set jump 3 instructions and clear the register */
+		*insn++ = BPF_JMP32_IMM(BPF_JEQ, tmp_reg,
+					TC_AT_INGRESS_MASK | SKB_MONO_DELIVERY_TIME_MASK |
+					SKB_TAI_DELIVERY_TIME_MASK, 4);
+		/*Now check Mono is set with ingress mask if so clear */
+		*insn++ = BPF_JMP32_IMM(BPF_JEQ, tmp_reg,
+					TC_AT_INGRESS_MASK | SKB_MONO_DELIVERY_TIME_MASK, 3);
+		/*Now Check tai is set with ingress mask if so clear */
+		*insn++ = BPF_JMP32_IMM(BPF_JEQ, tmp_reg,
+					TC_AT_INGRESS_MASK | SKB_TAI_DELIVERY_TIME_MASK, 2);
+		/*Now Check tai and mono are set if so clear */
+		*insn++ = BPF_JMP32_IMM(BPF_JEQ, tmp_reg,
+					SKB_MONO_DELIVERY_TIME_MASK |
+					SKB_TAI_DELIVERY_TIME_MASK, 1);
+		/* goto <store> */
+		*insn++ = BPF_JMP_A(2);
 		/* skb->tc_at_ingress && skb->tstamp_type:1,
 		 * read 0 as the (rcv) timestamp.
 		 */
@@ -9456,9 +9484,11 @@ static struct bpf_insn *bpf_convert_tstamp_write(const struct bpf_prog *prog,
 		/* Writing __sk_buff->tstamp as ingress, goto <clear> */
 		*insn++ = BPF_JMP32_IMM(BPF_JSET, tmp_reg, TC_AT_INGRESS_MASK, 1);
 		/* goto <store> */
-		*insn++ = BPF_JMP_A(2);
+		*insn++ = BPF_JMP_A(3);
 		/* <clear>: mono_delivery_time or (skb->tstamp_type:1) */
 		*insn++ = BPF_ALU32_IMM(BPF_AND, tmp_reg, ~SKB_MONO_DELIVERY_TIME_MASK);
+		/* <clear>: tai delivery_time or (skb->tstamp_type:2) */
+		*insn++ = BPF_ALU32_IMM(BPF_AND, tmp_reg, ~SKB_TAI_DELIVERY_TIME_MASK);
 		*insn++ = BPF_STX_MEM(BPF_B, skb_reg, tmp_reg, SKB_BF_MONO_TC_OFFSET);
 	}
 #endif
diff --git a/net/ipv4/ip_output.c b/net/ipv4/ip_output.c
index f29349151203..91e80a3d411f 100644
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
index 3b7c57fe55a5..9d0c33d7f52e 100644
--- a/tools/testing/selftests/bpf/prog_tests/ctx_rewrite.c
+++ b/tools/testing/selftests/bpf/prog_tests/ctx_rewrite.c
@@ -69,15 +69,20 @@ static struct test_case test_cases[] = {
 	{
 		N(SCHED_CLS, struct __sk_buff, tstamp),
 		.read  = "r11 = *(u8 *)($ctx + sk_buff::__mono_tc_offset);"
-			 "w11 &= 3;"
-			 "if w11 != 0x3 goto pc+2;"
+			 "w11 &= 7;"
+			 "if w11 == 0x7 goto pc+4;"
+			 "if w11 == 0x5 goto pc+3;"
+			 "if w11 == 0x6 goto pc+2;"
+			 "if w11 == 0x3 goto pc+1;"
+			 "goto pc+2"
 			 "$dst = 0;"
 			 "goto pc+1;"
 			 "$dst = *(u64 *)($ctx + sk_buff::tstamp);",
 		.write = "r11 = *(u8 *)($ctx + sk_buff::__mono_tc_offset);"
-			 "if w11 & 0x2 goto pc+1;"
-			 "goto pc+2;"
+			 "if w11 & 0x4 goto pc+1;"
+			 "goto pc+3;"
 			 "w11 &= -2;"
+			 "w11 &= -3;"
 			 "*(u8 *)($ctx + sk_buff::__mono_tc_offset) = r11;"
 			 "*(u64 *)($ctx + sk_buff::tstamp) = $src;",
 	},
-- 
2.25.1


