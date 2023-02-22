Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3588169FEC1
	for <lists+bpf@lfdr.de>; Wed, 22 Feb 2023 23:53:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233079AbjBVWxS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 22 Feb 2023 17:53:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229869AbjBVWxN (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 22 Feb 2023 17:53:13 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A81483ABD
        for <bpf@vger.kernel.org>; Wed, 22 Feb 2023 14:53:11 -0800 (PST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31MJqY72001086;
        Wed, 22 Feb 2023 22:37:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=jBjuxR4867j2UzvHnpqNSxNHxF6k6Cy1HZYmmhMV0ck=;
 b=A01Xwf76RwN9WCzl80MpYI/9iiCRMW5Gcyc2ojMuHBePGze+OfAVGJ0C5E/Z8GH3EoKU
 ci+S3s7DYbEiY3hIZdioqAkhGc3HeHMn+u1fNxNA4FjAuRoZ9kO9/hsGPA4D8j6hUT7j
 H9lKK5jKX9NHe66PxOw6iuadDMbexfK+H1n59yIazLRJ1nBrgXk0mHuC7B3vPyri6yt1
 5joxhEGQTdi1pv1sjsghz4JnVu7kZQ/ps1k0d8gbPm29teHhkJOWdSKhT+/GTkE4iVcp
 78NyIYlGOfv8BzEg8VbFSR6qjP31hyODOAUrOufZtcBqxCOBcZAVW3EnQZnYGnrNK6ZG PQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nwsk93gy3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Feb 2023 22:37:27 +0000
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 31MMUamA007787;
        Wed, 22 Feb 2023 22:37:27 GMT
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nwsk93gxn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Feb 2023 22:37:27 +0000
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 31MAiB2f008532;
        Wed, 22 Feb 2023 22:37:25 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
        by ppma06fra.de.ibm.com (PPS) with ESMTPS id 3ntnxf4g5s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Feb 2023 22:37:24 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
        by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 31MMbLUN46989742
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 22 Feb 2023 22:37:21 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 56A652004B;
        Wed, 22 Feb 2023 22:37:21 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A74EC20040;
        Wed, 22 Feb 2023 22:37:20 +0000 (GMT)
Received: from heavy.boeblingen.de.ibm.com (unknown [9.171.50.17])
        by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Wed, 22 Feb 2023 22:37:20 +0000 (GMT)
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH bpf-next v3 02/12] selftests/bpf: Fix test_verifier on 32-bit systems
Date:   Wed, 22 Feb 2023 23:37:04 +0100
Message-Id: <20230222223714.80671-3-iii@linux.ibm.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230222223714.80671-1-iii@linux.ibm.com>
References: <20230222223714.80671-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: U7c8znUBAAH-fVIxUHq7Quik_7kOuG0T
X-Proofpoint-ORIG-GUID: PQZlvFzmxWXqlMLyR7wy5h8XF2e7YiWU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-22_10,2023-02-22_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 spamscore=0 impostorscore=0 suspectscore=0 bulkscore=0 phishscore=0
 clxscore=1015 lowpriorityscore=0 mlxlogscore=983 priorityscore=1501
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302220195
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

bpf_fentry_test_t.a, bpf_iter_meta.seq, bpf_map.ops and
prog_test_ref_kfunc.next are pointers, so access them using BPF_W on
32-bit systems.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 tools/testing/selftests/bpf/test_verifier.c             | 5 +++++
 tools/testing/selftests/bpf/verifier/atomic_fetch_add.c | 2 +-
 tools/testing/selftests/bpf/verifier/bpf_get_stack.c    | 2 +-
 tools/testing/selftests/bpf/verifier/calls.c            | 4 ++--
 tools/testing/selftests/bpf/verifier/map_kptr.c         | 2 +-
 tools/testing/selftests/bpf/verifier/map_ptr.c          | 2 +-
 6 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/bpf/test_verifier.c b/tools/testing/selftests/bpf/test_verifier.c
index 8b9949bb833d..81a8aef7362c 100644
--- a/tools/testing/selftests/bpf/test_verifier.c
+++ b/tools/testing/selftests/bpf/test_verifier.c
@@ -62,6 +62,11 @@
 #define MAX_FUNC_INFOS	8
 #define MAX_BTF_STRINGS	256
 #define MAX_BTF_TYPES	256
+#if BITS_PER_LONG == 32
+#define BPF_PTR BPF_W
+#else
+#define BPF_PTR BPF_DW
+#endif
 
 #define INSN_OFF_MASK	((__s16)0xFFFF)
 #define INSN_IMM_MASK	((__s32)0xFFFFFFFF)
diff --git a/tools/testing/selftests/bpf/verifier/atomic_fetch_add.c b/tools/testing/selftests/bpf/verifier/atomic_fetch_add.c
index a91de8cd9def..6ed98eb217b3 100644
--- a/tools/testing/selftests/bpf/verifier/atomic_fetch_add.c
+++ b/tools/testing/selftests/bpf/verifier/atomic_fetch_add.c
@@ -93,7 +93,7 @@
 		 * because it's kernel memory.
 		 */
 		BPF_MOV64_IMM(BPF_REG_3, 1),
-		BPF_ATOMIC_OP(BPF_DW, BPF_ADD | BPF_FETCH, BPF_REG_2, BPF_REG_3, 0),
+		BPF_ATOMIC_OP(BPF_PTR, BPF_ADD | BPF_FETCH, BPF_REG_2, BPF_REG_3, 0),
 		/* Done */
 		BPF_MOV64_IMM(BPF_REG_0, 0),
 		BPF_EXIT_INSN(),
diff --git a/tools/testing/selftests/bpf/verifier/bpf_get_stack.c b/tools/testing/selftests/bpf/verifier/bpf_get_stack.c
index 3e024c891178..e48b409d1759 100644
--- a/tools/testing/selftests/bpf/verifier/bpf_get_stack.c
+++ b/tools/testing/selftests/bpf/verifier/bpf_get_stack.c
@@ -46,7 +46,7 @@
 	"bpf_get_task_stack return R0 range is refined",
 	.insns = {
 	BPF_LDX_MEM(BPF_DW, BPF_REG_6, BPF_REG_1, 0),
-	BPF_LDX_MEM(BPF_DW, BPF_REG_6, BPF_REG_6, 0), // ctx->meta->seq
+	BPF_LDX_MEM(BPF_PTR, BPF_REG_6, BPF_REG_6, 0), // ctx->meta->seq
 	BPF_LDX_MEM(BPF_DW, BPF_REG_7, BPF_REG_1, 8), // ctx->task
 	BPF_LD_MAP_FD(BPF_REG_1, 0), // fixup_map_array_48b
 	BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, 0),
diff --git a/tools/testing/selftests/bpf/verifier/calls.c b/tools/testing/selftests/bpf/verifier/calls.c
index 9d993926bf0e..a59759db8c78 100644
--- a/tools/testing/selftests/bpf/verifier/calls.c
+++ b/tools/testing/selftests/bpf/verifier/calls.c
@@ -168,7 +168,7 @@
 	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),
 	BPF_EXIT_INSN(),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
-	BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_1, 16),
+	BPF_LDX_MEM(BPF_PTR, BPF_REG_1, BPF_REG_1, 16),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, -4),
 	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, BPF_PSEUDO_KFUNC_CALL, 0, 0),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
@@ -230,7 +230,7 @@
 	BPF_MOV64_REG(BPF_REG_6, BPF_REG_0),
 	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
 	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, BPF_PSEUDO_KFUNC_CALL, 0, 0),
-	BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_6, 16),
+	BPF_LDX_MEM(BPF_PTR, BPF_REG_1, BPF_REG_6, 16),
 	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, BPF_PSEUDO_KFUNC_CALL, 0, 0),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
diff --git a/tools/testing/selftests/bpf/verifier/map_kptr.c b/tools/testing/selftests/bpf/verifier/map_kptr.c
index 6914904344c0..b8ea6b0b536d 100644
--- a/tools/testing/selftests/bpf/verifier/map_kptr.c
+++ b/tools/testing/selftests/bpf/verifier/map_kptr.c
@@ -235,7 +235,7 @@
 	BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_0, 0),
 	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),
 	BPF_EXIT_INSN(),
-	BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_0, 16),
+	BPF_LDX_MEM(BPF_PTR, BPF_REG_1, BPF_REG_0, 16),
 	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_this_cpu_ptr),
 	BPF_EXIT_INSN(),
 	},
diff --git a/tools/testing/selftests/bpf/verifier/map_ptr.c b/tools/testing/selftests/bpf/verifier/map_ptr.c
index 17ee84dc7766..b8e308d678b7 100644
--- a/tools/testing/selftests/bpf/verifier/map_ptr.c
+++ b/tools/testing/selftests/bpf/verifier/map_ptr.c
@@ -51,7 +51,7 @@
 	.insns = {
 	BPF_MOV64_IMM(BPF_REG_6, 0),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_LDX_MEM(BPF_DW, BPF_REG_6, BPF_REG_1, 0),
+	BPF_LDX_MEM(BPF_PTR, BPF_REG_6, BPF_REG_1, 0),
 	BPF_MOV64_IMM(BPF_REG_0, 1),
 	BPF_EXIT_INSN(),
 	},
-- 
2.39.1

