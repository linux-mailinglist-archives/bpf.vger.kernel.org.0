Return-Path: <bpf+bounces-29316-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EBF9F8C1839
	for <lists+bpf@lfdr.de>; Thu,  9 May 2024 23:19:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F3D921C20CF3
	for <lists+bpf@lfdr.de>; Thu,  9 May 2024 21:19:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E63D7127E25;
	Thu,  9 May 2024 21:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="FNULpKpG"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C71684E05;
	Thu,  9 May 2024 21:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715289544; cv=none; b=TLPn1NcWTOAOZ/2QhYBv/Z7esn3qlkfbo3unLQxUGjzCQ9Rr6N649w95USSsi5A5VGI+YEp2fKO4Nuo9YtOj3RTFdjXRU7atfd75WNg5ip0yZYCyeiS4o2qKeh4xmtEPIpu15ehiGuHM9AsCD+nqiRXkFGJEj9429dD4yvi70fQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715289544; c=relaxed/simple;
	bh=+3IL8mmWgPq6/LKtSawsB7OAAuLiwI+66mqqvtZgYb4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tUu3iJ1rmmhSI6XvhuWgsF4oQLAgttKMndSPgI2lHHxJwSUdSjdS6hdHnofRgQy6SPSeXnXBOUp9VfnpLvxn9xRdaMPIjW25iOfH9Skf6WZSJ3m2XtRF9b7saFw+Qb18cv65+VFmOKR+Xp2OqcOKY9A62a6HHJIbiVL/HjaKeHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=FNULpKpG; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 449KtJK6013729;
	Thu, 9 May 2024 21:18:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=qcppdkim1; bh=bbOwkZd
	/W35BwNHHq+9LVYNrGHQUSeou4ZSm3Pnduso=; b=FNULpKpGFBPW50DUJwUabW5
	G+0WnOP8EaOMjMyrIVZSt2oh2UTAfV45Uk3wKZA3wd1/PiC8mYHlYWlCVnsuYKY8
	jx808Bing76jh9E8txUCswByvzwtCRH3oNpHwxgeJeQavH7nvPDL27A94AL9p/Xf
	5/LcgbryINQ3xwyqMfaXZEaQ5dGRGE/8TrPVmOeRgIYN342Ud96sF6onPuN3YeTA
	X1qckK4X8wGMQilXLeeIwSYLmLZhtvErr57ZJQHpkSwVUEWNpGBJjiRrriSS/lVI
	SqqJyY68DotG8J7evZiPJFw756lPJv7dIQOLJqYDkXnhRgyo+TWh+Kt2jPgDQZA=
	=
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3y07wfuwng-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 09 May 2024 21:18:36 +0000 (GMT)
Received: from pps.filterd (NALASPPMTA02.qualcomm.com [127.0.0.1])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 449LIZLF026940;
	Thu, 9 May 2024 21:18:35 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by NALASPPMTA02.qualcomm.com (PPS) with ESMTPS id 3y0813wy3b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 09 May 2024 21:18:35 +0000
Received: from NALASPPMTA02.qualcomm.com (NALASPPMTA02.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 449LIZu6026931;
	Thu, 9 May 2024 21:18:35 GMT
Received: from hu-devc-lv-u20-a-new.qualcomm.com (hu-abchauha-lv.qualcomm.com [10.81.25.35])
	by NALASPPMTA02.qualcomm.com (PPS) with ESMTPS id 449LIYPR026929
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 09 May 2024 21:18:35 +0000
Received: by hu-devc-lv-u20-a-new.qualcomm.com (Postfix, from userid 214165)
	id 569A723B2A; Thu,  9 May 2024 14:18:34 -0700 (PDT)
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
Subject: [PATCH bpf-next v8 3/3] selftests/bpf: Handle forwarding of UDP CLOCK_TAI packets
Date: Thu,  9 May 2024 14:18:34 -0700
Message-Id: <20240509211834.3235191-4-quic_abchauha@quicinc.com>
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
X-Proofpoint-GUID: 6FOefXc4WtoiStSfanms9TGEBnHiIney
X-Proofpoint-ORIG-GUID: 6FOefXc4WtoiStSfanms9TGEBnHiIney
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-09_12,2024-05-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 adultscore=0
 spamscore=0 priorityscore=1501 suspectscore=0 bulkscore=0 phishscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2405010000
 definitions=main-2405090150

With changes in the design to forward CLOCK_TAI in the skbuff
framework,  existing selftest framework needs modification
to handle forwarding of UDP packets with CLOCK_TAI as clockid.

Link: https://lore.kernel.org/netdev/bc037db4-58bb-4861-ac31-a361a93841d3@linux.dev/
Signed-off-by: Abhishek Chauhan <quic_abchauha@quicinc.com>
Reviewed-by: Martin KaFai Lau <martin.lau@kernel.org>
---
Changes since v7
- Added reviewed by tags and removed RFC 
- Moved tools/include/uapi/linux/bpf.h from this 
  patch to patch 2
- Added detecting of non-zero REALTIME skb->tstamp 
  since it should not happen at egress as suggested 
  by Martin.

Changes since v6
- Fixed  issues in the ctx_rewrite.c
  with respect to dissembly in both
  .read and .write  

Changes since v5
- Moved all the selftest to another patch

Changes since v1 - v4
- Patch was not present

 .../selftests/bpf/prog_tests/ctx_rewrite.c    | 10 +++--
 .../selftests/bpf/prog_tests/tc_redirect.c    |  3 --
 .../selftests/bpf/progs/test_tc_dtime.c       | 39 ++++++++-----------
 3 files changed, 23 insertions(+), 29 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/ctx_rewrite.c b/tools/testing/selftests/bpf/prog_tests/ctx_rewrite.c
index 3b7c57fe55a5..08b6391f2f56 100644
--- a/tools/testing/selftests/bpf/prog_tests/ctx_rewrite.c
+++ b/tools/testing/selftests/bpf/prog_tests/ctx_rewrite.c
@@ -69,15 +69,17 @@ static struct test_case test_cases[] = {
 	{
 		N(SCHED_CLS, struct __sk_buff, tstamp),
 		.read  = "r11 = *(u8 *)($ctx + sk_buff::__mono_tc_offset);"
-			 "w11 &= 3;"
-			 "if w11 != 0x3 goto pc+2;"
+			 "if w11 & 0x4 goto pc+1;"
+			 "goto pc+4;"
+			 "if w11 & 0x3 goto pc+1;"
+			 "goto pc+2;"
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
index 74ec09f040b7..ca8e8734d901 100644
--- a/tools/testing/selftests/bpf/progs/test_tc_dtime.c
+++ b/tools/testing/selftests/bpf/progs/test_tc_dtime.c
@@ -222,17 +222,21 @@ int egress_host(struct __sk_buff *skb)
 		return TC_ACT_OK;
 
 	if (skb_proto(skb_type) == IPPROTO_TCP) {
-		if (skb->tstamp_type == BPF_SKB_TSTAMP_DELIVERY_MONO &&
+		if (skb->tstamp_type == BPF_SKB_CLOCK_MONOTONIC &&
 		    skb->tstamp)
 			inc_dtimes(EGRESS_ENDHOST);
 		else
 			inc_errs(EGRESS_ENDHOST);
-	} else {
-		if (skb->tstamp_type == BPF_SKB_TSTAMP_UNSPEC &&
+	} else if (skb_proto(skb_type) == IPPROTO_UDP) {
+		if (skb->tstamp_type == BPF_SKB_CLOCK_TAI &&
 		    skb->tstamp)
 			inc_dtimes(EGRESS_ENDHOST);
 		else
 			inc_errs(EGRESS_ENDHOST);
+	} else {
+		if (skb->tstamp_type == BPF_SKB_CLOCK_REALTIME &&
+		    skb->tstamp)
+			inc_errs(EGRESS_ENDHOST);
 	}
 
 	skb->tstamp = EGRESS_ENDHOST_MAGIC;
@@ -252,7 +256,7 @@ int ingress_host(struct __sk_buff *skb)
 	if (!skb_type)
 		return TC_ACT_OK;
 
-	if (skb->tstamp_type == BPF_SKB_TSTAMP_DELIVERY_MONO &&
+	if (skb->tstamp_type == BPF_SKB_CLOCK_MONOTONIC &&
 	    skb->tstamp == EGRESS_FWDNS_MAGIC)
 		inc_dtimes(INGRESS_ENDHOST);
 	else
@@ -315,7 +319,6 @@ int egress_fwdns_prio100(struct __sk_buff *skb)
 SEC("tc")
 int ingress_fwdns_prio101(struct __sk_buff *skb)
 {
-	__u64 expected_dtime = EGRESS_ENDHOST_MAGIC;
 	int skb_type;
 
 	skb_type = skb_get_type(skb);
@@ -323,29 +326,24 @@ int ingress_fwdns_prio101(struct __sk_buff *skb)
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
 
@@ -370,7 +368,7 @@ int egress_fwdns_prio101(struct __sk_buff *skb)
 
 	if (skb->tstamp_type) {
 		if (fwdns_clear_dtime() ||
-		    skb->tstamp_type != BPF_SKB_TSTAMP_DELIVERY_MONO ||
+		    skb->tstamp_type != BPF_SKB_CLOCK_MONOTONIC ||
 		    skb->tstamp != INGRESS_FWDNS_MAGIC)
 			inc_errs(EGRESS_FWDNS_P101);
 		else
@@ -380,14 +378,11 @@ int egress_fwdns_prio101(struct __sk_buff *skb)
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


