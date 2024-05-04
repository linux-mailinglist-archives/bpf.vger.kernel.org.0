Return-Path: <bpf+bounces-28566-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F8D98BB95B
	for <lists+bpf@lfdr.de>; Sat,  4 May 2024 05:14:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0865A1F24327
	for <lists+bpf@lfdr.de>; Sat,  4 May 2024 03:14:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABB351803D;
	Sat,  4 May 2024 03:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Esd4Lmj6"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 898A812E4A;
	Sat,  4 May 2024 03:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714792444; cv=none; b=gCOccgqs89jXIKiRErCslHCzMGlmxiSxGPxHlfb9Eqs/MDCssZQ+xrbXJlFK/83aSmBbhZG2dN04S63ZFDctjYD67t8Ss+7GiT8WTUzMXtPHyDD69a+YrdatEIDk9ro3lJIxHUQ2h2DafE82F66NpYM+H4JC8bfWb5lD5+u0W+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714792444; c=relaxed/simple;
	bh=1Aqsr1HPrV3RZBfxe0SikzA9mFAVA2DyR4aqiJRWi8I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=httsGWtV15IgcGuLX2WJp9lXCFADNfE6pr6KEjfgkip34ryyEmA6LwSb5AyxrnF7Vll/X9r1TUXJnhIcbmW9Vi0nNXdn6gO9/PXSiDJxeb+UIb10M2InStOd4BWoecVjRaYDDeyd+qwGJYSmpHWEEJSKnWxLoBt9cR1PHcVnxp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Esd4Lmj6; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4442tqE9024416;
	Sat, 4 May 2024 03:13:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=qcppdkim1; bh=htChg0K
	5rdxeVbHZey0l3VG121n/EYipgxtfPzAzc0M=; b=Esd4Lmj6cUigNBO8MJNwLbd
	XP1IbVsB5rKwc72gY8quo2wfyTAHPjL5ijBKvx6mVLkI34w479eCnu7fikwOeBgp
	aYxmzUxrConkb87KkfTrq4BbPmguveexZxunevULdKzAdZ8YddCGY3omKyiXYbPB
	Ll1KUnT6OtXcrnNBw91xN7P+SpYwBdwzMuzSHHHhKkiWJO9GCPqOfvkkbZQFqv4v
	niLmYDFyqqcSrU9hFgb7wFBv18fE288Mai5a84/csqgp3ymZ7HY8ZH6X3+PnXbYs
	DCeSmOw90tQ/dqO093zb0rzaWGqcBBA94ASSD8Rw+nGeTZY4QeBtl/9YwUmKVBA=
	=
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xwc1c01kw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 04 May 2024 03:13:34 +0000 (GMT)
Received: from pps.filterd (NALASPPMTA03.qualcomm.com [127.0.0.1])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 44438k5s011470;
	Sat, 4 May 2024 03:13:32 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by NALASPPMTA03.qualcomm.com (PPS) with ESMTPS id 3xvsvbfr7v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 04 May 2024 03:13:32 +0000
Received: from NALASPPMTA03.qualcomm.com (NALASPPMTA03.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 4443DWmP017750;
	Sat, 4 May 2024 03:13:32 GMT
Received: from hu-devc-lv-u20-a-new.qualcomm.com (hu-abchauha-lv.qualcomm.com [10.81.25.35])
	by NALASPPMTA03.qualcomm.com (PPS) with ESMTPS id 4443DWvl017748
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 04 May 2024 03:13:32 +0000
Received: by hu-devc-lv-u20-a-new.qualcomm.com (Postfix, from userid 214165)
	id A0A0623B74; Fri,  3 May 2024 20:13:31 -0700 (PDT)
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
Subject: [RFC PATCH bpf-next v6 3/3] selftests/bpf: Handle forwarding of UDP CLOCK_TAI packets
Date: Fri,  3 May 2024 20:13:31 -0700
Message-Id: <20240504031331.2737365-4-quic_abchauha@quicinc.com>
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
X-Proofpoint-GUID: VlyoWloeHAJxeRVzJ6gcjNaB-WocwAiZ
X-Proofpoint-ORIG-GUID: VlyoWloeHAJxeRVzJ6gcjNaB-WocwAiZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-03_17,2024-05-03_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 spamscore=0
 lowpriorityscore=0 phishscore=0 suspectscore=0 priorityscore=1501
 malwarescore=0 mlxlogscore=999 adultscore=0 bulkscore=0 impostorscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2405040022

With changes in the design to forward CLOCK_TAI in the skbuff
framework,  existing selftest framework needs modification
to handle forwarding of UDP packets with CLOCK_TAI as clockid.

Link: https://lore.kernel.org/netdev/bc037db4-58bb-4861-ac31-a361a93841d3@linux.dev/
Signed-off-by: Abhishek Chauhan <quic_abchauha@quicinc.com>
---
 tools/include/uapi/linux/bpf.h                | 15 ++++---
 .../selftests/bpf/prog_tests/ctx_rewrite.c    | 10 +++--
 .../selftests/bpf/prog_tests/tc_redirect.c    |  3 --
 .../selftests/bpf/progs/test_tc_dtime.c       | 39 +++++++++----------
 4 files changed, 34 insertions(+), 33 deletions(-)

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
diff --git a/tools/testing/selftests/bpf/prog_tests/tc_redirect.c b/tools/testing/selftests/bpf/prog_tests/tc_redirect.c
index b1073d36d77a..327d51f59142 100644
--- a/tools/testing/selftests/bpf/prog_tests/tc_redirect.c
+++ b/tools/testing/selftests/bpf/prog_tests/tc_redirect.c
@@ -890,9 +890,6 @@ static void test_udp_dtime(struct test_tc_dtime *skel, int family, bool bpf_fwd)
 
 	ASSERT_EQ(dtimes[INGRESS_FWDNS_P100], 0,
 		  dtime_cnt_str(t, INGRESS_FWDNS_P100));
-	/* non mono delivery time is not forwarded */
-	ASSERT_EQ(dtimes[INGRESS_FWDNS_P101], 0,
-		  dtime_cnt_str(t, INGRESS_FWDNS_P101));
 	for (i = EGRESS_FWDNS_P100; i < SET_DTIME; i++)
 		ASSERT_GT(dtimes[i], 0, dtime_cnt_str(t, i));
 
diff --git a/tools/testing/selftests/bpf/progs/test_tc_dtime.c b/tools/testing/selftests/bpf/progs/test_tc_dtime.c
index 74ec09f040b7..21f5be202e4b 100644
--- a/tools/testing/selftests/bpf/progs/test_tc_dtime.c
+++ b/tools/testing/selftests/bpf/progs/test_tc_dtime.c
@@ -222,13 +222,19 @@ int egress_host(struct __sk_buff *skb)
 		return TC_ACT_OK;
 
 	if (skb_proto(skb_type) == IPPROTO_TCP) {
-		if (skb->tstamp_type == BPF_SKB_TSTAMP_DELIVERY_MONO &&
+		if (skb->tstamp_type == BPF_SKB_CLOCK_MONOTONIC &&
+		    skb->tstamp)
+			inc_dtimes(EGRESS_ENDHOST);
+		else
+			inc_errs(EGRESS_ENDHOST);
+	} else if (skb_proto(skb_type) == IPPROTO_UDP) {
+		if (skb->tstamp_type == BPF_SKB_CLOCK_TAI &&
 		    skb->tstamp)
 			inc_dtimes(EGRESS_ENDHOST);
 		else
 			inc_errs(EGRESS_ENDHOST);
 	} else {
-		if (skb->tstamp_type == BPF_SKB_TSTAMP_UNSPEC &&
+		if (skb->tstamp_type == BPF_SKB_CLOCK_REALTIME &&
 		    skb->tstamp)
 			inc_dtimes(EGRESS_ENDHOST);
 		else
@@ -252,7 +258,7 @@ int ingress_host(struct __sk_buff *skb)
 	if (!skb_type)
 		return TC_ACT_OK;
 
-	if (skb->tstamp_type == BPF_SKB_TSTAMP_DELIVERY_MONO &&
+	if (skb->tstamp_type == BPF_SKB_CLOCK_MONOTONIC &&
 	    skb->tstamp == EGRESS_FWDNS_MAGIC)
 		inc_dtimes(INGRESS_ENDHOST);
 	else
@@ -315,7 +321,6 @@ int egress_fwdns_prio100(struct __sk_buff *skb)
 SEC("tc")
 int ingress_fwdns_prio101(struct __sk_buff *skb)
 {
-	__u64 expected_dtime = EGRESS_ENDHOST_MAGIC;
 	int skb_type;
 
 	skb_type = skb_get_type(skb);
@@ -323,29 +328,24 @@ int ingress_fwdns_prio101(struct __sk_buff *skb)
 		/* Should have handled in prio100 */
 		return TC_ACT_SHOT;
 
-	if (skb_proto(skb_type) == IPPROTO_UDP)
-		expected_dtime = 0;
-
 	if (skb->tstamp_type) {
 		if (fwdns_clear_dtime() ||
-		    skb->tstamp_type != BPF_SKB_TSTAMP_DELIVERY_MONO ||
-		    skb->tstamp != expected_dtime)
+		    (skb->tstamp_type != BPF_SKB_CLOCK_MONOTONIC &&
+		    skb->tstamp_type != BPF_SKB_CLOCK_TAI) ||
+		    skb->tstamp != EGRESS_ENDHOST_MAGIC)
 			inc_errs(INGRESS_FWDNS_P101);
 		else
 			inc_dtimes(INGRESS_FWDNS_P101);
 	} else {
-		if (!fwdns_clear_dtime() && expected_dtime)
+		if (!fwdns_clear_dtime())
 			inc_errs(INGRESS_FWDNS_P101);
 	}
 
-	if (skb->tstamp_type == BPF_SKB_TSTAMP_DELIVERY_MONO) {
+	if (skb->tstamp_type == BPF_SKB_CLOCK_MONOTONIC) {
 		skb->tstamp = INGRESS_FWDNS_MAGIC;
 	} else {
 		if (bpf_skb_set_tstamp(skb, INGRESS_FWDNS_MAGIC,
-				       BPF_SKB_TSTAMP_DELIVERY_MONO))
-			inc_errs(SET_DTIME);
-		if (!bpf_skb_set_tstamp(skb, INGRESS_FWDNS_MAGIC,
-					BPF_SKB_TSTAMP_UNSPEC))
+				       BPF_SKB_CLOCK_MONOTONIC))
 			inc_errs(SET_DTIME);
 	}
 
@@ -370,7 +370,7 @@ int egress_fwdns_prio101(struct __sk_buff *skb)
 
 	if (skb->tstamp_type) {
 		if (fwdns_clear_dtime() ||
-		    skb->tstamp_type != BPF_SKB_TSTAMP_DELIVERY_MONO ||
+		    skb->tstamp_type != BPF_SKB_CLOCK_MONOTONIC ||
 		    skb->tstamp != INGRESS_FWDNS_MAGIC)
 			inc_errs(EGRESS_FWDNS_P101);
 		else
@@ -380,14 +380,11 @@ int egress_fwdns_prio101(struct __sk_buff *skb)
 			inc_errs(EGRESS_FWDNS_P101);
 	}
 
-	if (skb->tstamp_type == BPF_SKB_TSTAMP_DELIVERY_MONO) {
+	if (skb->tstamp_type == BPF_SKB_CLOCK_MONOTONIC) {
 		skb->tstamp = EGRESS_FWDNS_MAGIC;
 	} else {
 		if (bpf_skb_set_tstamp(skb, EGRESS_FWDNS_MAGIC,
-				       BPF_SKB_TSTAMP_DELIVERY_MONO))
-			inc_errs(SET_DTIME);
-		if (!bpf_skb_set_tstamp(skb, INGRESS_FWDNS_MAGIC,
-					BPF_SKB_TSTAMP_UNSPEC))
+				       BPF_SKB_CLOCK_MONOTONIC))
 			inc_errs(SET_DTIME);
 	}
 
-- 
2.25.1


