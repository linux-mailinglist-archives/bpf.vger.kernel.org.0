Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73303619D6F
	for <lists+bpf@lfdr.de>; Fri,  4 Nov 2022 17:37:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231901AbiKDQh2 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Fri, 4 Nov 2022 12:37:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231814AbiKDQhV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 4 Nov 2022 12:37:21 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C0A4326F6
        for <bpf@vger.kernel.org>; Fri,  4 Nov 2022 09:37:19 -0700 (PDT)
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A4EqMvu012399
        for <bpf@vger.kernel.org>; Fri, 4 Nov 2022 09:37:19 -0700
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3kmpg6y3x9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 04 Nov 2022 09:37:18 -0700
Received: from twshared25017.14.frc2.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c085:21d::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 4 Nov 2022 09:37:18 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 842B72117FEEB; Fri,  4 Nov 2022 09:37:06 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>
Subject: [PATCH v2 bpf-next 6/6] selftests/bpf: make test_align selftest more robust
Date:   Fri, 4 Nov 2022 09:36:49 -0700
Message-ID: <20221104163649.121784-7-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221104163649.121784-1-andrii@kernel.org>
References: <20221104163649.121784-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: YXZ9n2jhL3xmwLHyLjBrjZZHKWxpLOKQ
X-Proofpoint-GUID: YXZ9n2jhL3xmwLHyLjBrjZZHKWxpLOKQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-04_11,2022-11-03_01,2022-06-22_01
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

test_align selftest relies on BPF verifier log emitting register states
for specific instructions in expected format. Unfortunately, BPF
verifier precision backtracking log interferes with such expectations.
And instruction on which precision propagation happens sometimes don't
output full expected register states. This does indeed look like
something to be improved in BPF verifier, but is beyond the scope of
this patch set.

So to make test_align a bit more robust, inject few dummy R4 = R5
instructions which capture desired state of R5 and won't have precision
tracking logs on them. This fixes tests until we can improve BPF
verifier output in the presence of precision tracking.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 .../testing/selftests/bpf/prog_tests/align.c  | 38 ++++++++++++-------
 1 file changed, 24 insertions(+), 14 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/align.c b/tools/testing/selftests/bpf/prog_tests/align.c
index 970f09156eb4..4666f88f2bb4 100644
--- a/tools/testing/selftests/bpf/prog_tests/align.c
+++ b/tools/testing/selftests/bpf/prog_tests/align.c
@@ -2,7 +2,7 @@
 #include <test_progs.h>
 
 #define MAX_INSNS	512
-#define MAX_MATCHES	16
+#define MAX_MATCHES	24
 
 struct bpf_reg_match {
 	unsigned int line;
@@ -267,6 +267,7 @@ static struct bpf_align_test tests[] = {
 			 */
 			BPF_MOV64_REG(BPF_REG_5, BPF_REG_2),
 			BPF_ALU64_REG(BPF_ADD, BPF_REG_5, BPF_REG_6),
+			BPF_MOV64_REG(BPF_REG_4, BPF_REG_5),
 			BPF_ALU64_IMM(BPF_ADD, BPF_REG_5, 14),
 			BPF_MOV64_REG(BPF_REG_4, BPF_REG_5),
 			BPF_ALU64_IMM(BPF_ADD, BPF_REG_4, 4),
@@ -280,6 +281,7 @@ static struct bpf_align_test tests[] = {
 			BPF_MOV64_REG(BPF_REG_5, BPF_REG_2),
 			BPF_ALU64_IMM(BPF_ADD, BPF_REG_5, 14),
 			BPF_ALU64_REG(BPF_ADD, BPF_REG_5, BPF_REG_6),
+			BPF_MOV64_REG(BPF_REG_4, BPF_REG_5),
 			BPF_ALU64_IMM(BPF_ADD, BPF_REG_5, 4),
 			BPF_ALU64_REG(BPF_ADD, BPF_REG_5, BPF_REG_6),
 			BPF_MOV64_REG(BPF_REG_4, BPF_REG_5),
@@ -311,44 +313,52 @@ static struct bpf_align_test tests[] = {
 			{15, "R4=pkt(id=1,off=18,r=18,umax=1020,var_off=(0x0; 0x3fc))"},
 			{15, "R5=pkt(id=1,off=14,r=18,umax=1020,var_off=(0x0; 0x3fc))"},
 			/* Variable offset is added to R5 packet pointer,
-			 * resulting in auxiliary alignment of 4.
+			 * resulting in auxiliary alignment of 4. To avoid BPF
+			 * verifier's precision backtracking logging
+			 * interfering we also have a no-op R4 = R5
+			 * instruction to validate R5 state. We also check
+			 * that R4 is what it should be in such case.
 			 */
-			{17, "R5_w=pkt(id=2,off=0,r=0,umax=1020,var_off=(0x0; 0x3fc))"},
+			{18, "R4_w=pkt(id=2,off=0,r=0,umax=1020,var_off=(0x0; 0x3fc))"},
+			{18, "R5_w=pkt(id=2,off=0,r=0,umax=1020,var_off=(0x0; 0x3fc))"},
 			/* Constant offset is added to R5, resulting in
 			 * reg->off of 14.
 			 */
-			{18, "R5_w=pkt(id=2,off=14,r=0,umax=1020,var_off=(0x0; 0x3fc))"},
+			{19, "R5_w=pkt(id=2,off=14,r=0,umax=1020,var_off=(0x0; 0x3fc))"},
 			/* At the time the word size load is performed from R5,
 			 * its total fixed offset is NET_IP_ALIGN + reg->off
 			 * (14) which is 16.  Then the variable offset is 4-byte
 			 * aligned, so the total offset is 4-byte aligned and
 			 * meets the load's requirements.
 			 */
-			{23, "R4=pkt(id=2,off=18,r=18,umax=1020,var_off=(0x0; 0x3fc))"},
-			{23, "R5=pkt(id=2,off=14,r=18,umax=1020,var_off=(0x0; 0x3fc))"},
+			{24, "R4=pkt(id=2,off=18,r=18,umax=1020,var_off=(0x0; 0x3fc))"},
+			{24, "R5=pkt(id=2,off=14,r=18,umax=1020,var_off=(0x0; 0x3fc))"},
 			/* Constant offset is added to R5 packet pointer,
 			 * resulting in reg->off value of 14.
 			 */
-			{25, "R5_w=pkt(off=14,r=8"},
+			{26, "R5_w=pkt(off=14,r=8"},
 			/* Variable offset is added to R5, resulting in a
-			 * variable offset of (4n).
+			 * variable offset of (4n). See comment for insn #18
+			 * for R4 = R5 trick.
 			 */
-			{26, "R5_w=pkt(id=3,off=14,r=0,umax=1020,var_off=(0x0; 0x3fc))"},
+			{28, "R4_w=pkt(id=3,off=14,r=0,umax=1020,var_off=(0x0; 0x3fc))"},
+			{28, "R5_w=pkt(id=3,off=14,r=0,umax=1020,var_off=(0x0; 0x3fc))"},
 			/* Constant is added to R5 again, setting reg->off to 18. */
-			{27, "R5_w=pkt(id=3,off=18,r=0,umax=1020,var_off=(0x0; 0x3fc))"},
+			{29, "R5_w=pkt(id=3,off=18,r=0,umax=1020,var_off=(0x0; 0x3fc))"},
 			/* And once more we add a variable; resulting var_off
 			 * is still (4n), fixed offset is not changed.
 			 * Also, we create a new reg->id.
 			 */
-			{28, "R5_w=pkt(id=4,off=18,r=0,umax=2040,var_off=(0x0; 0x7fc)"},
+			{31, "R4_w=pkt(id=4,off=18,r=0,umax=2040,var_off=(0x0; 0x7fc)"},
+			{31, "R5_w=pkt(id=4,off=18,r=0,umax=2040,var_off=(0x0; 0x7fc)"},
 			/* At the time the word size load is performed from R5,
 			 * its total fixed offset is NET_IP_ALIGN + reg->off (18)
 			 * which is 20.  Then the variable offset is (4n), so
 			 * the total offset is 4-byte aligned and meets the
 			 * load's requirements.
 			 */
-			{33, "R4=pkt(id=4,off=22,r=22,umax=2040,var_off=(0x0; 0x7fc)"},
-			{33, "R5=pkt(id=4,off=18,r=22,umax=2040,var_off=(0x0; 0x7fc)"},
+			{35, "R4=pkt(id=4,off=22,r=22,umax=2040,var_off=(0x0; 0x7fc)"},
+			{35, "R5=pkt(id=4,off=18,r=22,umax=2040,var_off=(0x0; 0x7fc)"},
 		},
 	},
 	{
@@ -681,6 +691,6 @@ void test_align(void)
 		if (!test__start_subtest(test->descr))
 			continue;
 
-		CHECK_FAIL(do_test_single(test));
+		ASSERT_OK(do_test_single(test), test->descr);
 	}
 }
-- 
2.30.2

