Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B5641A030F
	for <lists+bpf@lfdr.de>; Wed, 28 Aug 2019 15:22:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726410AbfH1NWj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 28 Aug 2019 09:22:39 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:53590 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726394AbfH1NWj (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 28 Aug 2019 09:22:39 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7SDJBCb047960
        for <bpf@vger.kernel.org>; Wed, 28 Aug 2019 09:22:35 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2unsqg2744-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 28 Aug 2019 09:22:35 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <bpf@vger.kernel.org> from <iii@linux.ibm.com>;
        Wed, 28 Aug 2019 14:22:33 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 28 Aug 2019 14:22:29 +0100
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x7SDMSCl20906080
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Aug 2019 13:22:28 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0309DA4067;
        Wed, 28 Aug 2019 13:22:28 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9D495A4065;
        Wed, 28 Aug 2019 13:22:27 +0000 (GMT)
Received: from white.boeblingen.de.ibm.com (unknown [9.152.98.121])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 28 Aug 2019 13:22:27 +0000 (GMT)
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>
Cc:     bpf@vger.kernel.org, Yonghong Song <yhs@fb.com>,
        Andrey Ignatov <rdna@fb.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH bpf v3 2/2] selftests/bpf: fix endianness issues in test_sysctl
Date:   Wed, 28 Aug 2019 15:22:14 +0200
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190828132214.68828-1-iii@linux.ibm.com>
References: <20190828132214.68828-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19082813-0028-0000-0000-00000394E871
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19082813-0029-0000-0000-000024572515
Message-Id: <20190828132214.68828-3-iii@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-28_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=763 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908280143
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

A lot of test_sysctl sub-tests fail due to handling strings as a bunch
of immediate values in a little-endian-specific manner.

Fix by wrapping all immediates in bpf_ntohl and the new bpf_be64_to_cpu.

Also, sometimes tests fail because sysctl() unexpectedly succeeds with
an inappropriate "Unexpected failure" message and a random errno. Zero
out errno before calling sysctl() and replace the message with
"Unexpected success".

Fixes: 1f5fa9ab6e2e ("selftests/bpf: Test BPF_CGROUP_SYSCTL")
Fixes: 9a1027e52535 ("selftests/bpf: Test file_pos field in bpf_sysctl ctx")
Fixes: 6041c67f28d8 ("selftests/bpf: Test bpf_sysctl_get_name helper")
Fixes: 11ff34f74e32 ("selftests/bpf: Test sysctl_get_current_value helper")
Fixes: 786047dd08de ("selftests/bpf: Test bpf_sysctl_{get,set}_new_value helpers")
Fixes: 8549ddc832d6 ("selftests/bpf: Test bpf_strtol and bpf_strtoul helpers")
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 tools/testing/selftests/bpf/test_sysctl.c | 130 ++++++++++++++--------
 1 file changed, 85 insertions(+), 45 deletions(-)

diff --git a/tools/testing/selftests/bpf/test_sysctl.c b/tools/testing/selftests/bpf/test_sysctl.c
index a3bebd7c68dd..b8c6e31645cb 100644
--- a/tools/testing/selftests/bpf/test_sysctl.c
+++ b/tools/testing/selftests/bpf/test_sysctl.c
@@ -13,6 +13,7 @@
 #include <bpf/bpf.h>
 #include <bpf/libbpf.h>
 
+#include "bpf_endian.h"
 #include "bpf_rlimit.h"
 #include "bpf_util.h"
 #include "cgroup_helpers.h"
@@ -100,7 +101,7 @@ static struct sysctl_test tests[] = {
 		.descr = "ctx:write sysctl:write read ok",
 		.insns = {
 			/* If (write) */
-			BPF_LDX_MEM(BPF_B, BPF_REG_7, BPF_REG_1,
+			BPF_LDX_MEM(BPF_W, BPF_REG_7, BPF_REG_1,
 				    offsetof(struct bpf_sysctl, write)),
 			BPF_JMP_IMM(BPF_JNE, BPF_REG_7, 1, 2),
 
@@ -214,7 +215,8 @@ static struct sysctl_test tests[] = {
 			/* if (ret == expected && */
 			BPF_JMP_IMM(BPF_JNE, BPF_REG_0, sizeof("tcp_mem") - 1, 6),
 			/*     buf == "tcp_mem\0") */
-			BPF_LD_IMM64(BPF_REG_8, 0x006d656d5f706374ULL),
+			BPF_LD_IMM64(BPF_REG_8, bpf_be64_to_cpu(
+				0x7463705f6d656d00ULL)),
 			BPF_LDX_MEM(BPF_DW, BPF_REG_9, BPF_REG_7, 0),
 			BPF_JMP_REG(BPF_JNE, BPF_REG_8, BPF_REG_9, 2),
 
@@ -255,7 +257,8 @@ static struct sysctl_test tests[] = {
 			BPF_JMP_IMM(BPF_JNE, BPF_REG_0, -E2BIG, 6),
 
 			/*     buf[0:7] == "tcp_me\0") */
-			BPF_LD_IMM64(BPF_REG_8, 0x00656d5f706374ULL),
+			BPF_LD_IMM64(BPF_REG_8, bpf_be64_to_cpu(
+				0x7463705f6d650000ULL)),
 			BPF_LDX_MEM(BPF_DW, BPF_REG_9, BPF_REG_7, 0),
 			BPF_JMP_REG(BPF_JNE, BPF_REG_8, BPF_REG_9, 2),
 
@@ -298,12 +301,14 @@ static struct sysctl_test tests[] = {
 			BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 16, 14),
 
 			/*     buf[0:8] == "net/ipv4" && */
-			BPF_LD_IMM64(BPF_REG_8, 0x347670692f74656eULL),
+			BPF_LD_IMM64(BPF_REG_8, bpf_be64_to_cpu(
+				0x6e65742f69707634ULL)),
 			BPF_LDX_MEM(BPF_DW, BPF_REG_9, BPF_REG_7, 0),
 			BPF_JMP_REG(BPF_JNE, BPF_REG_8, BPF_REG_9, 10),
 
 			/*     buf[8:16] == "/tcp_mem" && */
-			BPF_LD_IMM64(BPF_REG_8, 0x6d656d5f7063742fULL),
+			BPF_LD_IMM64(BPF_REG_8, bpf_be64_to_cpu(
+				0x2f7463705f6d656dULL)),
 			BPF_LDX_MEM(BPF_DW, BPF_REG_9, BPF_REG_7, 8),
 			BPF_JMP_REG(BPF_JNE, BPF_REG_8, BPF_REG_9, 6),
 
@@ -350,12 +355,14 @@ static struct sysctl_test tests[] = {
 			BPF_JMP_IMM(BPF_JNE, BPF_REG_0, -E2BIG, 10),
 
 			/*     buf[0:8] == "net/ipv4" && */
-			BPF_LD_IMM64(BPF_REG_8, 0x347670692f74656eULL),
+			BPF_LD_IMM64(BPF_REG_8, bpf_be64_to_cpu(
+				0x6e65742f69707634ULL)),
 			BPF_LDX_MEM(BPF_DW, BPF_REG_9, BPF_REG_7, 0),
 			BPF_JMP_REG(BPF_JNE, BPF_REG_8, BPF_REG_9, 6),
 
 			/*     buf[8:16] == "/tcp_me\0") */
-			BPF_LD_IMM64(BPF_REG_8, 0x00656d5f7063742fULL),
+			BPF_LD_IMM64(BPF_REG_8, bpf_be64_to_cpu(
+				0x2f7463705f6d6500ULL)),
 			BPF_LDX_MEM(BPF_DW, BPF_REG_9, BPF_REG_7, 8),
 			BPF_JMP_REG(BPF_JNE, BPF_REG_8, BPF_REG_9, 2),
 
@@ -396,7 +403,8 @@ static struct sysctl_test tests[] = {
 			BPF_JMP_IMM(BPF_JNE, BPF_REG_0, -E2BIG, 6),
 
 			/*     buf[0:8] == "net/ip\0") */
-			BPF_LD_IMM64(BPF_REG_8, 0x000070692f74656eULL),
+			BPF_LD_IMM64(BPF_REG_8, bpf_be64_to_cpu(
+				0x6e65742f69700000ULL)),
 			BPF_LDX_MEM(BPF_DW, BPF_REG_9, BPF_REG_7, 0),
 			BPF_JMP_REG(BPF_JNE, BPF_REG_8, BPF_REG_9, 2),
 
@@ -431,7 +439,8 @@ static struct sysctl_test tests[] = {
 			BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 6, 6),
 
 			/*     buf[0:6] == "Linux\n\0") */
-			BPF_LD_IMM64(BPF_REG_8, 0x000a78756e694cULL),
+			BPF_LD_IMM64(BPF_REG_8, bpf_be64_to_cpu(
+				0x4c696e75780a0000ULL)),
 			BPF_LDX_MEM(BPF_DW, BPF_REG_9, BPF_REG_7, 0),
 			BPF_JMP_REG(BPF_JNE, BPF_REG_8, BPF_REG_9, 2),
 
@@ -469,7 +478,8 @@ static struct sysctl_test tests[] = {
 			BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 6, 6),
 
 			/*     buf[0:6] == "Linux\n\0") */
-			BPF_LD_IMM64(BPF_REG_8, 0x000a78756e694cULL),
+			BPF_LD_IMM64(BPF_REG_8, bpf_be64_to_cpu(
+				0x4c696e75780a0000ULL)),
 			BPF_LDX_MEM(BPF_DW, BPF_REG_9, BPF_REG_7, 0),
 			BPF_JMP_REG(BPF_JNE, BPF_REG_8, BPF_REG_9, 2),
 
@@ -507,7 +517,8 @@ static struct sysctl_test tests[] = {
 			BPF_JMP_IMM(BPF_JNE, BPF_REG_0, -E2BIG, 6),
 
 			/*     buf[0:6] == "Linux\0") */
-			BPF_LD_IMM64(BPF_REG_8, 0x000078756e694cULL),
+			BPF_LD_IMM64(BPF_REG_8, bpf_be64_to_cpu(
+				0x4c696e7578000000ULL)),
 			BPF_LDX_MEM(BPF_DW, BPF_REG_9, BPF_REG_7, 0),
 			BPF_JMP_REG(BPF_JNE, BPF_REG_8, BPF_REG_9, 2),
 
@@ -650,7 +661,8 @@ static struct sysctl_test tests[] = {
 
 			/*     buf[0:4] == "606\0") */
 			BPF_LDX_MEM(BPF_W, BPF_REG_9, BPF_REG_7, 0),
-			BPF_JMP_IMM(BPF_JNE, BPF_REG_9, 0x00363036, 2),
+			BPF_JMP_IMM(BPF_JNE, BPF_REG_9,
+				    bpf_ntohl(0x36303600), 2),
 
 			/* return DENY; */
 			BPF_MOV64_IMM(BPF_REG_0, 0),
@@ -685,17 +697,20 @@ static struct sysctl_test tests[] = {
 			BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 23, 14),
 
 			/*     buf[0:8] == "3000000 " && */
-			BPF_LD_IMM64(BPF_REG_8, 0x2030303030303033ULL),
+			BPF_LD_IMM64(BPF_REG_8, bpf_be64_to_cpu(
+				0x3330303030303020ULL)),
 			BPF_LDX_MEM(BPF_DW, BPF_REG_9, BPF_REG_7, 0),
 			BPF_JMP_REG(BPF_JNE, BPF_REG_8, BPF_REG_9, 10),
 
 			/*     buf[8:16] == "4000000 " && */
-			BPF_LD_IMM64(BPF_REG_8, 0x2030303030303034ULL),
+			BPF_LD_IMM64(BPF_REG_8, bpf_be64_to_cpu(
+				0x3430303030303020ULL)),
 			BPF_LDX_MEM(BPF_DW, BPF_REG_9, BPF_REG_7, 8),
 			BPF_JMP_REG(BPF_JNE, BPF_REG_8, BPF_REG_9, 6),
 
 			/*     buf[16:24] == "6000000\0") */
-			BPF_LD_IMM64(BPF_REG_8, 0x0030303030303036ULL),
+			BPF_LD_IMM64(BPF_REG_8, bpf_be64_to_cpu(
+				0x3630303030303000ULL)),
 			BPF_LDX_MEM(BPF_DW, BPF_REG_9, BPF_REG_7, 16),
 			BPF_JMP_REG(BPF_JNE, BPF_REG_8, BPF_REG_9, 2),
 
@@ -735,7 +750,8 @@ static struct sysctl_test tests[] = {
 
 			/*     buf[0:3] == "60\0") */
 			BPF_LDX_MEM(BPF_W, BPF_REG_9, BPF_REG_7, 0),
-			BPF_JMP_IMM(BPF_JNE, BPF_REG_9, 0x003036, 2),
+			BPF_JMP_IMM(BPF_JNE, BPF_REG_9,
+				    bpf_ntohl(0x36300000), 2),
 
 			/* return DENY; */
 			BPF_MOV64_IMM(BPF_REG_0, 0),
@@ -757,7 +773,8 @@ static struct sysctl_test tests[] = {
 			/* sysctl_set_new_value arg2 (buf) */
 			BPF_MOV64_REG(BPF_REG_7, BPF_REG_10),
 			BPF_ALU64_IMM(BPF_ADD, BPF_REG_7, -8),
-			BPF_MOV64_IMM(BPF_REG_0, 0x00303036),
+			BPF_MOV64_IMM(BPF_REG_0,
+				      bpf_ntohl(0x36303000)),
 			BPF_STX_MEM(BPF_DW, BPF_REG_7, BPF_REG_0, 0),
 
 			BPF_MOV64_REG(BPF_REG_2, BPF_REG_7),
@@ -791,7 +808,7 @@ static struct sysctl_test tests[] = {
 			/* sysctl_set_new_value arg2 (buf) */
 			BPF_MOV64_REG(BPF_REG_7, BPF_REG_10),
 			BPF_ALU64_IMM(BPF_ADD, BPF_REG_7, -8),
-			BPF_MOV64_IMM(BPF_REG_0, FIXUP_SYSCTL_VALUE),
+			BPF_LD_IMM64(BPF_REG_0, FIXUP_SYSCTL_VALUE),
 			BPF_STX_MEM(BPF_DW, BPF_REG_7, BPF_REG_0, 0),
 
 			BPF_MOV64_REG(BPF_REG_2, BPF_REG_7),
@@ -825,8 +842,9 @@ static struct sysctl_test tests[] = {
 			/* arg1 (buf) */
 			BPF_MOV64_REG(BPF_REG_7, BPF_REG_10),
 			BPF_ALU64_IMM(BPF_ADD, BPF_REG_7, -8),
-			BPF_MOV64_IMM(BPF_REG_0, 0x00303036),
-			BPF_STX_MEM(BPF_DW, BPF_REG_7, BPF_REG_0, 0),
+			BPF_MOV64_IMM(BPF_REG_0,
+				      bpf_ntohl(0x36303000)),
+			BPF_STX_MEM(BPF_W, BPF_REG_7, BPF_REG_0, 0),
 
 			BPF_MOV64_REG(BPF_REG_1, BPF_REG_7),
 
@@ -869,7 +887,8 @@ static struct sysctl_test tests[] = {
 			BPF_MOV64_REG(BPF_REG_7, BPF_REG_10),
 			BPF_ALU64_IMM(BPF_ADD, BPF_REG_7, -8),
 			/* "600 602\0" */
-			BPF_LD_IMM64(BPF_REG_0, 0x0032303620303036ULL),
+			BPF_LD_IMM64(BPF_REG_0, bpf_be64_to_cpu(
+				0x3630302036303200ULL)),
 			BPF_STX_MEM(BPF_DW, BPF_REG_7, BPF_REG_0, 0),
 			BPF_MOV64_REG(BPF_REG_1, BPF_REG_7),
 
@@ -937,7 +956,8 @@ static struct sysctl_test tests[] = {
 			/* arg1 (buf) */
 			BPF_MOV64_REG(BPF_REG_7, BPF_REG_10),
 			BPF_ALU64_IMM(BPF_ADD, BPF_REG_7, -8),
-			BPF_MOV64_IMM(BPF_REG_0, 0x00303036),
+			BPF_MOV64_IMM(BPF_REG_0,
+				      bpf_ntohl(0x36303000)),
 			BPF_STX_MEM(BPF_DW, BPF_REG_7, BPF_REG_0, 0),
 
 			BPF_MOV64_REG(BPF_REG_1, BPF_REG_7),
@@ -969,8 +989,9 @@ static struct sysctl_test tests[] = {
 			/* arg1 (buf) */
 			BPF_MOV64_REG(BPF_REG_7, BPF_REG_10),
 			BPF_ALU64_IMM(BPF_ADD, BPF_REG_7, -8),
-			BPF_MOV64_IMM(BPF_REG_0, 0x00373730),
-			BPF_STX_MEM(BPF_DW, BPF_REG_7, BPF_REG_0, 0),
+			BPF_MOV64_IMM(BPF_REG_0,
+				      bpf_ntohl(0x30373700)),
+			BPF_STX_MEM(BPF_W, BPF_REG_7, BPF_REG_0, 0),
 
 			BPF_MOV64_REG(BPF_REG_1, BPF_REG_7),
 
@@ -1012,7 +1033,8 @@ static struct sysctl_test tests[] = {
 			/* arg1 (buf) */
 			BPF_MOV64_REG(BPF_REG_7, BPF_REG_10),
 			BPF_ALU64_IMM(BPF_ADD, BPF_REG_7, -8),
-			BPF_MOV64_IMM(BPF_REG_0, 0x00303036),
+			BPF_MOV64_IMM(BPF_REG_0,
+				      bpf_ntohl(0x36303000)),
 			BPF_STX_MEM(BPF_DW, BPF_REG_7, BPF_REG_0, 0),
 
 			BPF_MOV64_REG(BPF_REG_1, BPF_REG_7),
@@ -1052,7 +1074,8 @@ static struct sysctl_test tests[] = {
 			/* arg1 (buf) */
 			BPF_MOV64_REG(BPF_REG_7, BPF_REG_10),
 			BPF_ALU64_IMM(BPF_ADD, BPF_REG_7, -8),
-			BPF_MOV64_IMM(BPF_REG_0, 0x090a0c0d),
+			BPF_MOV64_IMM(BPF_REG_0,
+				      bpf_ntohl(0x0d0c0a09)),
 			BPF_STX_MEM(BPF_DW, BPF_REG_7, BPF_REG_0, 0),
 
 			BPF_MOV64_REG(BPF_REG_1, BPF_REG_7),
@@ -1092,7 +1115,9 @@ static struct sysctl_test tests[] = {
 			/* arg1 (buf) */
 			BPF_MOV64_REG(BPF_REG_7, BPF_REG_10),
 			BPF_ALU64_IMM(BPF_ADD, BPF_REG_7, -8),
-			BPF_MOV64_IMM(BPF_REG_0, 0x00362d0a), /* " -6\0" */
+			/* " -6\0" */
+			BPF_MOV64_IMM(BPF_REG_0,
+				      bpf_ntohl(0x0a2d3600)),
 			BPF_STX_MEM(BPF_DW, BPF_REG_7, BPF_REG_0, 0),
 
 			BPF_MOV64_REG(BPF_REG_1, BPF_REG_7),
@@ -1132,8 +1157,10 @@ static struct sysctl_test tests[] = {
 			/* arg1 (buf) */
 			BPF_MOV64_REG(BPF_REG_7, BPF_REG_10),
 			BPF_ALU64_IMM(BPF_ADD, BPF_REG_7, -8),
-			BPF_MOV64_IMM(BPF_REG_0, 0x00362d0a), /* " -6\0" */
-			BPF_STX_MEM(BPF_DW, BPF_REG_7, BPF_REG_0, 0),
+			/* " -6\0" */
+			BPF_MOV64_IMM(BPF_REG_0,
+				      bpf_ntohl(0x0a2d3600)),
+			BPF_STX_MEM(BPF_W, BPF_REG_7, BPF_REG_0, 0),
 
 			BPF_MOV64_REG(BPF_REG_1, BPF_REG_7),
 
@@ -1175,8 +1202,10 @@ static struct sysctl_test tests[] = {
 			/* arg1 (buf) */
 			BPF_MOV64_REG(BPF_REG_7, BPF_REG_10),
 			BPF_ALU64_IMM(BPF_ADD, BPF_REG_7, -8),
-			BPF_MOV64_IMM(BPF_REG_0, 0x65667830), /* "0xfe" */
-			BPF_STX_MEM(BPF_DW, BPF_REG_7, BPF_REG_0, 0),
+			/* "0xfe" */
+			BPF_MOV64_IMM(BPF_REG_0,
+				      bpf_ntohl(0x30786665)),
+			BPF_STX_MEM(BPF_W, BPF_REG_7, BPF_REG_0, 0),
 
 			BPF_MOV64_REG(BPF_REG_1, BPF_REG_7),
 
@@ -1218,11 +1247,14 @@ static struct sysctl_test tests[] = {
 			/* arg1 (buf) 9223372036854775807 */
 			BPF_MOV64_REG(BPF_REG_7, BPF_REG_10),
 			BPF_ALU64_IMM(BPF_ADD, BPF_REG_7, -24),
-			BPF_LD_IMM64(BPF_REG_0, 0x3032373333323239ULL),
+			BPF_LD_IMM64(BPF_REG_0, bpf_be64_to_cpu(
+				0x3932323333373230ULL)),
 			BPF_STX_MEM(BPF_DW, BPF_REG_7, BPF_REG_0, 0),
-			BPF_LD_IMM64(BPF_REG_0, 0x3537373435383633ULL),
+			BPF_LD_IMM64(BPF_REG_0, bpf_be64_to_cpu(
+				0x3336383534373735ULL)),
 			BPF_STX_MEM(BPF_DW, BPF_REG_7, BPF_REG_0, 8),
-			BPF_LD_IMM64(BPF_REG_0, 0x0000000000373038ULL),
+			BPF_LD_IMM64(BPF_REG_0, bpf_be64_to_cpu(
+				0x3830370000000000ULL)),
 			BPF_STX_MEM(BPF_DW, BPF_REG_7, BPF_REG_0, 16),
 
 			BPF_MOV64_REG(BPF_REG_1, BPF_REG_7),
@@ -1266,11 +1298,14 @@ static struct sysctl_test tests[] = {
 			/* arg1 (buf) 9223372036854775808 */
 			BPF_MOV64_REG(BPF_REG_7, BPF_REG_10),
 			BPF_ALU64_IMM(BPF_ADD, BPF_REG_7, -24),
-			BPF_LD_IMM64(BPF_REG_0, 0x3032373333323239ULL),
+			BPF_LD_IMM64(BPF_REG_0, bpf_be64_to_cpu(
+				0x3932323333373230ULL)),
 			BPF_STX_MEM(BPF_DW, BPF_REG_7, BPF_REG_0, 0),
-			BPF_LD_IMM64(BPF_REG_0, 0x3537373435383633ULL),
+			BPF_LD_IMM64(BPF_REG_0, bpf_be64_to_cpu(
+				0x3336383534373735ULL)),
 			BPF_STX_MEM(BPF_DW, BPF_REG_7, BPF_REG_0, 8),
-			BPF_LD_IMM64(BPF_REG_0, 0x0000000000383038ULL),
+			BPF_LD_IMM64(BPF_REG_0, bpf_be64_to_cpu(
+				0x3830380000000000ULL)),
 			BPF_STX_MEM(BPF_DW, BPF_REG_7, BPF_REG_0, 16),
 
 			BPF_MOV64_REG(BPF_REG_1, BPF_REG_7),
@@ -1344,20 +1379,24 @@ static size_t probe_prog_length(const struct bpf_insn *fp)
 static int fixup_sysctl_value(const char *buf, size_t buf_len,
 			      struct bpf_insn *prog, size_t insn_num)
 {
-	uint32_t value_num = 0;
+	union {
+		uint8_t raw[sizeof(uint64_t)];
+		uint64_t num;
+	} value = {};
 	uint8_t c, i;
 
-	if (buf_len > sizeof(value_num)) {
+	if (buf_len > sizeof(value)) {
 		log_err("Value is too big (%zd) to use in fixup", buf_len);
 		return -1;
 	}
-
-	for (i = 0; i < buf_len; ++i) {
-		c = buf[i];
-		value_num |= (c << i * 8);
+	if (prog[insn_num].code != (BPF_LD | BPF_DW | BPF_IMM)) {
+		log_err("Can fixup only BPF_LD_IMM64 insns");
+		return -1;
 	}
 
-	prog[insn_num].imm = value_num;
+	memcpy(value.raw, buf, buf_len);
+	prog[insn_num].imm = (uint32_t)value.num;
+	prog[insn_num + 1].imm = (uint32_t)(value.num >> 32);
 
 	return 0;
 }
@@ -1499,6 +1538,7 @@ static int run_test_case(int cgfd, struct sysctl_test *test)
 			goto err;
 	}
 
+	errno = 0;
 	if (access_sysctl(sysctl_path, test) == -1) {
 		if (test->result == OP_EPERM && errno == EPERM)
 			goto out;
@@ -1507,7 +1547,7 @@ static int run_test_case(int cgfd, struct sysctl_test *test)
 	}
 
 	if (test->result != SUCCESS) {
-		log_err("Unexpected failure");
+		log_err("Unexpected success");
 		goto err;
 	}
 
-- 
2.21.0

