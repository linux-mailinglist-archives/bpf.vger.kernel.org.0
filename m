Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 132CA6A8D43
	for <lists+bpf@lfdr.de>; Fri,  3 Mar 2023 00:50:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229996AbjCBXui convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Thu, 2 Mar 2023 18:50:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230136AbjCBXug (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 2 Mar 2023 18:50:36 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3CE234007
        for <bpf@vger.kernel.org>; Thu,  2 Mar 2023 15:50:31 -0800 (PST)
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 322L51sA030901
        for <bpf@vger.kernel.org>; Thu, 2 Mar 2023 15:50:31 -0800
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3p33d08wpf-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 02 Mar 2023 15:50:31 -0800
Received: from ash-exhub204.TheFacebook.com (2620:10d:c0a8:83::4) by
 ash-exhub203.TheFacebook.com (2620:10d:c0a8:83::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Thu, 2 Mar 2023 15:50:29 -0800
Received: from twshared33736.38.frc1.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Thu, 2 Mar 2023 15:50:29 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 8A280291B7EA8; Thu,  2 Mar 2023 15:50:24 -0800 (PST)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>,
        Tejun Heo <tj@kernel.org>
Subject: [PATCH bpf-next 03/17] selftests/bpf: enhance align selftest's expected log matching
Date:   Thu, 2 Mar 2023 15:50:01 -0800
Message-ID: <20230302235015.2044271-4-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230302235015.2044271-1-andrii@kernel.org>
References: <20230302235015.2044271-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: ZdYNXCMHHt_Fpf7fPanOisvhLPSHqaWY
X-Proofpoint-GUID: ZdYNXCMHHt_Fpf7fPanOisvhLPSHqaWY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-02_15,2023-03-02_02,2023-02-09_01
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Allow to search for expected register state in all the verifier log
output that's related to specified instruction number.

See added comment for an example of possible situation that is happening
due to a simple enhancement done in the next patch, which fixes handling
of env->test_state_freq flag in state checkpointing logic.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/testing/selftests/bpf/prog_tests/align.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/align.c b/tools/testing/selftests/bpf/prog_tests/align.c
index 4666f88f2bb4..c94fa8d6c4f6 100644
--- a/tools/testing/selftests/bpf/prog_tests/align.c
+++ b/tools/testing/selftests/bpf/prog_tests/align.c
@@ -660,16 +660,22 @@ static int do_test_single(struct bpf_align_test *test)
 			 * func#0 @0
 			 * 0: R1=ctx(off=0,imm=0) R10=fp0
 			 * 0: (b7) r3 = 2                 ; R3_w=2
+			 *
+			 * Sometimes it's actually two lines below, e.g. when
+			 * searching for "6: R3_w=scalar(umax=255,var_off=(0x0; 0xff))":
+			 *   from 4 to 6: R0_w=pkt(off=8,r=8,imm=0) R1=ctx(off=0,imm=0) R2_w=pkt(off=0,r=8,imm=0) R3_w=pkt_end(off=0,imm=0) R10=fp0
+			 *   6: R0_w=pkt(off=8,r=8,imm=0) R1=ctx(off=0,imm=0) R2_w=pkt(off=0,r=8,imm=0) R3_w=pkt_end(off=0,imm=0) R10=fp0
+			 *   6: (71) r3 = *(u8 *)(r2 +0)           ; R2_w=pkt(off=0,r=8,imm=0) R3_w=scalar(umax=255,var_off=(0x0; 0xff))
 			 */
-			if (!strstr(line_ptr, m.match)) {
+			while (!strstr(line_ptr, m.match)) {
 				cur_line = -1;
 				line_ptr = strtok(NULL, "\n");
-				sscanf(line_ptr, "%u: ", &cur_line);
+				sscanf(line_ptr ?: "", "%u: ", &cur_line);
+				if (!line_ptr || cur_line != m.line)
+					break;
 			}
-			if (cur_line != m.line || !line_ptr ||
-			    !strstr(line_ptr, m.match)) {
-				printf("Failed to find match %u: %s\n",
-				       m.line, m.match);
+			if (cur_line != m.line || !line_ptr || !strstr(line_ptr, m.match)) {
+				printf("Failed to find match %u: %s\n", m.line, m.match);
 				ret = 1;
 				printf("%s", bpf_vlog);
 				break;
-- 
2.30.2

