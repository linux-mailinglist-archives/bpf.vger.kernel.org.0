Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CA19439748
	for <lists+bpf@lfdr.de>; Mon, 25 Oct 2021 15:13:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233371AbhJYNPV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 25 Oct 2021 09:15:21 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:2757 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S233310AbhJYNPU (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 25 Oct 2021 09:15:20 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19PCM4Kj028618;
        Mon, 25 Oct 2021 13:12:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=1D0eH0k1kzCRsdmF4oWLKgvrwCrRPwHfE1C8od9oz1M=;
 b=OVoBSBnVEiUnQocBjSDdaERWldWe9XHIq4R1uqxwyHhm262Xm/ZOUYwrRN3u9oDgGX8H
 XYbwJJXne6X/uE+zQiPh7Z1B7H8x+7W3Yj4Z++zddrNyOOkel+3jm1Rs56GM0TKwReY5
 DIfuhV7OPSPFNmcVZyStQwkbtR2Tn/JoRtDCkTYl2wauPjWeriG2mEzZe4KoT5JZgLD3
 VezrD6ZT7tgGyHcEWuDJbJZ1GUIPIVpwSlkcb2S4ZkvzJ9h63gpBVp+MQTdUH8i0NG3I
 UNtd5t2XZsnZSZxEo9L1FATJRBU5qMtBf4UQgBMNBxTYfASZTigUoXuW0holtR1hecn8 Bg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3bwt0twf39-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 25 Oct 2021 13:12:45 +0000
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 19PCbWJk029050;
        Mon, 25 Oct 2021 13:12:45 GMT
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3bwt0twf2j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 25 Oct 2021 13:12:44 +0000
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 19PD984T013942;
        Mon, 25 Oct 2021 13:12:43 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma04fra.de.ibm.com with ESMTP id 3bva1a5bfw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 25 Oct 2021 13:12:38 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 19PDCHYX64684500
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 25 Oct 2021 13:12:18 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C9885A4076;
        Mon, 25 Oct 2021 13:12:17 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 74591A405F;
        Mon, 25 Oct 2021 13:12:17 +0000 (GMT)
Received: from vm.lan (unknown [9.145.12.156])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 25 Oct 2021 13:12:17 +0000 (GMT)
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH bpf-next v2 2/5] selftests/bpf: Use __BYTE_ORDER__
Date:   Mon, 25 Oct 2021 15:12:11 +0200
Message-Id: <20211025131214.731972-3-iii@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211025131214.731972-1-iii@linux.ibm.com>
References: <20211025131214.731972-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 3p0HX2c3mpJcNzleFbXZY-CTGOPKgSOU
X-Proofpoint-GUID: w7_aI38o7lLpCy3Y6Qv96HgsRt3Hbz6K
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-25_05,2021-10-25_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 spamscore=0
 mlxscore=0 bulkscore=0 priorityscore=1501 phishscore=0 adultscore=0
 mlxlogscore=999 lowpriorityscore=0 clxscore=1015 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110250081
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Use the compiler-defined __BYTE_ORDER__ instead of the libc-defined
__BYTE_ORDER for consistency.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 .../testing/selftests/bpf/prog_tests/btf_endian.c  |  6 +++---
 tools/testing/selftests/bpf/test_sysctl.c          |  4 ++--
 tools/testing/selftests/bpf/verifier/ctx_skb.c     | 14 +++++++-------
 tools/testing/selftests/bpf/verifier/lwt.c         |  2 +-
 .../bpf/verifier/perf_event_sample_period.c        |  6 +++---
 5 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/btf_endian.c b/tools/testing/selftests/bpf/prog_tests/btf_endian.c
index 2653cc482df4..8afbf3d0b89a 100644
--- a/tools/testing/selftests/bpf/prog_tests/btf_endian.c
+++ b/tools/testing/selftests/bpf/prog_tests/btf_endian.c
@@ -7,12 +7,12 @@
 #include <bpf/btf.h>
 
 void test_btf_endian() {
-#if __BYTE_ORDER == __LITTLE_ENDIAN
+#if __BYTE_ORDER__ == __ORDER_LITTLE_ENDIAN__
 	enum btf_endianness endian = BTF_LITTLE_ENDIAN;
-#elif __BYTE_ORDER == __BIG_ENDIAN
+#elif __BYTE_ORDER__ == __ORDER_BIG_ENDIAN__
 	enum btf_endianness endian = BTF_BIG_ENDIAN;
 #else
-#error "Unrecognized __BYTE_ORDER"
+#error "Unrecognized __BYTE_ORDER__"
 #endif
 	enum btf_endianness swap_endian = 1 - endian;
 	struct btf *btf = NULL, *swap_btf = NULL;
diff --git a/tools/testing/selftests/bpf/test_sysctl.c b/tools/testing/selftests/bpf/test_sysctl.c
index a20a919244c0..a3bb6d399daa 100644
--- a/tools/testing/selftests/bpf/test_sysctl.c
+++ b/tools/testing/selftests/bpf/test_sysctl.c
@@ -124,7 +124,7 @@ static struct sysctl_test tests[] = {
 		.descr = "ctx:write sysctl:write read ok narrow",
 		.insns = {
 			/* u64 w = (u16)write & 1; */
-#if __BYTE_ORDER == __LITTLE_ENDIAN
+#if __BYTE_ORDER__ == __ORDER_LITTLE_ENDIAN__
 			BPF_LDX_MEM(BPF_H, BPF_REG_7, BPF_REG_1,
 				    offsetof(struct bpf_sysctl, write)),
 #else
@@ -184,7 +184,7 @@ static struct sysctl_test tests[] = {
 		.descr = "ctx:file_pos sysctl:read read ok narrow",
 		.insns = {
 			/* If (file_pos == X) */
-#if __BYTE_ORDER == __LITTLE_ENDIAN
+#if __BYTE_ORDER__ == __ORDER_LITTLE_ENDIAN__
 			BPF_LDX_MEM(BPF_B, BPF_REG_7, BPF_REG_1,
 				    offsetof(struct bpf_sysctl, file_pos)),
 #else
diff --git a/tools/testing/selftests/bpf/verifier/ctx_skb.c b/tools/testing/selftests/bpf/verifier/ctx_skb.c
index 9e1a30b94197..83cecfbd6739 100644
--- a/tools/testing/selftests/bpf/verifier/ctx_skb.c
+++ b/tools/testing/selftests/bpf/verifier/ctx_skb.c
@@ -502,7 +502,7 @@
 	"check skb->hash byte load permitted",
 	.insns = {
 	BPF_MOV64_IMM(BPF_REG_0, 0),
-#if __BYTE_ORDER == __LITTLE_ENDIAN
+#if __BYTE_ORDER__ == __ORDER_LITTLE_ENDIAN__
 	BPF_LDX_MEM(BPF_B, BPF_REG_0, BPF_REG_1,
 		    offsetof(struct __sk_buff, hash)),
 #else
@@ -537,7 +537,7 @@
 	"check skb->hash byte load permitted 3",
 	.insns = {
 	BPF_MOV64_IMM(BPF_REG_0, 0),
-#if __BYTE_ORDER == __LITTLE_ENDIAN
+#if __BYTE_ORDER__ == __ORDER_LITTLE_ENDIAN__
 	BPF_LDX_MEM(BPF_B, BPF_REG_0, BPF_REG_1,
 		    offsetof(struct __sk_buff, hash) + 3),
 #else
@@ -646,7 +646,7 @@
 	"check skb->hash half load permitted",
 	.insns = {
 	BPF_MOV64_IMM(BPF_REG_0, 0),
-#if __BYTE_ORDER == __LITTLE_ENDIAN
+#if __BYTE_ORDER__ == __ORDER_LITTLE_ENDIAN__
 	BPF_LDX_MEM(BPF_H, BPF_REG_0, BPF_REG_1,
 		    offsetof(struct __sk_buff, hash)),
 #else
@@ -661,7 +661,7 @@
 	"check skb->hash half load permitted 2",
 	.insns = {
 	BPF_MOV64_IMM(BPF_REG_0, 0),
-#if __BYTE_ORDER == __LITTLE_ENDIAN
+#if __BYTE_ORDER__ == __ORDER_LITTLE_ENDIAN__
 	BPF_LDX_MEM(BPF_H, BPF_REG_0, BPF_REG_1,
 		    offsetof(struct __sk_buff, hash) + 2),
 #else
@@ -676,7 +676,7 @@
 	"check skb->hash half load not permitted, unaligned 1",
 	.insns = {
 	BPF_MOV64_IMM(BPF_REG_0, 0),
-#if __BYTE_ORDER == __LITTLE_ENDIAN
+#if __BYTE_ORDER__ == __ORDER_LITTLE_ENDIAN__
 	BPF_LDX_MEM(BPF_H, BPF_REG_0, BPF_REG_1,
 		    offsetof(struct __sk_buff, hash) + 1),
 #else
@@ -693,7 +693,7 @@
 	"check skb->hash half load not permitted, unaligned 3",
 	.insns = {
 	BPF_MOV64_IMM(BPF_REG_0, 0),
-#if __BYTE_ORDER == __LITTLE_ENDIAN
+#if __BYTE_ORDER__ == __ORDER_LITTLE_ENDIAN__
 	BPF_LDX_MEM(BPF_H, BPF_REG_0, BPF_REG_1,
 		    offsetof(struct __sk_buff, hash) + 3),
 #else
@@ -951,7 +951,7 @@
 	"check skb->data half load not permitted",
 	.insns = {
 	BPF_MOV64_IMM(BPF_REG_0, 0),
-#if __BYTE_ORDER == __LITTLE_ENDIAN
+#if __BYTE_ORDER__ == __ORDER_LITTLE_ENDIAN__
 	BPF_LDX_MEM(BPF_H, BPF_REG_0, BPF_REG_1,
 		    offsetof(struct __sk_buff, data)),
 #else
diff --git a/tools/testing/selftests/bpf/verifier/lwt.c b/tools/testing/selftests/bpf/verifier/lwt.c
index 2cab6a3966bb..5c8944d0b091 100644
--- a/tools/testing/selftests/bpf/verifier/lwt.c
+++ b/tools/testing/selftests/bpf/verifier/lwt.c
@@ -174,7 +174,7 @@
 	"check skb->tc_classid half load not permitted for lwt prog",
 	.insns = {
 	BPF_MOV64_IMM(BPF_REG_0, 0),
-#if __BYTE_ORDER == __LITTLE_ENDIAN
+#if __BYTE_ORDER__ == __ORDER_LITTLE_ENDIAN__
 	BPF_LDX_MEM(BPF_H, BPF_REG_0, BPF_REG_1,
 		    offsetof(struct __sk_buff, tc_classid)),
 #else
diff --git a/tools/testing/selftests/bpf/verifier/perf_event_sample_period.c b/tools/testing/selftests/bpf/verifier/perf_event_sample_period.c
index 471c1a5950d8..d8a9b1a1f9a2 100644
--- a/tools/testing/selftests/bpf/verifier/perf_event_sample_period.c
+++ b/tools/testing/selftests/bpf/verifier/perf_event_sample_period.c
@@ -2,7 +2,7 @@
 	"check bpf_perf_event_data->sample_period byte load permitted",
 	.insns = {
 	BPF_MOV64_IMM(BPF_REG_0, 0),
-#if __BYTE_ORDER == __LITTLE_ENDIAN
+#if __BYTE_ORDER__ == __ORDER_LITTLE_ENDIAN__
 	BPF_LDX_MEM(BPF_B, BPF_REG_0, BPF_REG_1,
 		    offsetof(struct bpf_perf_event_data, sample_period)),
 #else
@@ -18,7 +18,7 @@
 	"check bpf_perf_event_data->sample_period half load permitted",
 	.insns = {
 	BPF_MOV64_IMM(BPF_REG_0, 0),
-#if __BYTE_ORDER == __LITTLE_ENDIAN
+#if __BYTE_ORDER__ == __ORDER_LITTLE_ENDIAN__
 	BPF_LDX_MEM(BPF_H, BPF_REG_0, BPF_REG_1,
 		    offsetof(struct bpf_perf_event_data, sample_period)),
 #else
@@ -34,7 +34,7 @@
 	"check bpf_perf_event_data->sample_period word load permitted",
 	.insns = {
 	BPF_MOV64_IMM(BPF_REG_0, 0),
-#if __BYTE_ORDER == __LITTLE_ENDIAN
+#if __BYTE_ORDER__ == __ORDER_LITTLE_ENDIAN__
 	BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_1,
 		    offsetof(struct bpf_perf_event_data, sample_period)),
 #else
-- 
2.31.1

