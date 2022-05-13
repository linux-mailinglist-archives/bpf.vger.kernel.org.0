Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EECFA526895
	for <lists+bpf@lfdr.de>; Fri, 13 May 2022 19:39:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233707AbiEMRj7 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Fri, 13 May 2022 13:39:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379077AbiEMRj6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 13 May 2022 13:39:58 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E51035DF0
        for <bpf@vger.kernel.org>; Fri, 13 May 2022 10:39:58 -0700 (PDT)
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24DG3kNY009651
        for <bpf@vger.kernel.org>; Fri, 13 May 2022 10:39:57 -0700
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3g1cwxctk2-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 13 May 2022 10:39:57 -0700
Received: from twshared18443.03.prn6.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 13 May 2022 10:39:55 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 8BD7E19DD19E6; Fri, 13 May 2022 10:37:05 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>,
        Mykola Lysenko <mykolal@fb.com>
Subject: [PATCH bpf-next] selftests/bpf: fix usdt_400 test case
Date:   Fri, 13 May 2022 10:37:03 -0700
Message-ID: <20220513173703.89271-1-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: sqafkLpmpAv0uHgf2PheV0kpYbKBVfKq
X-Proofpoint-ORIG-GUID: sqafkLpmpAv0uHgf2PheV0kpYbKBVfKq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-13_09,2022-05-13_01,2022-02-23_01
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

usdt_400 test case relies on compiler using the same arg spec for
usdt_400 USDT. This assumption breaks with Clang (Clang generates
different arg specs with varying offsets relative to %rbp), so simplify
this further and hard-code the constant which will guarantee that arg
spec is the same across all 400 inlinings.

Fixes: 630301b0d59d ("selftests/bpf: Add basic USDT selftests")
Reported-by: Mykola Lysenko <mykolal@fb.com>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/testing/selftests/bpf/prog_tests/usdt.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/usdt.c b/tools/testing/selftests/bpf/prog_tests/usdt.c
index a71f51bdc08d..5f733d50b0d7 100644
--- a/tools/testing/selftests/bpf/prog_tests/usdt.c
+++ b/tools/testing/selftests/bpf/prog_tests/usdt.c
@@ -190,9 +190,7 @@ __weak void trigger_300_usdts(void)
 
 static void __always_inline f400(int x __attribute__((unused)))
 {
-	static int y;
-
-	STAP_PROBE1(test, usdt_400, y++);
+	STAP_PROBE1(test, usdt_400, 400);
 }
 
 /* this time we have 400 different USDT call sites, but they have uniform
@@ -299,7 +297,7 @@ static void subtest_multispec_usdt(void)
 	trigger_400_usdts();
 
 	ASSERT_EQ(bss->usdt_100_called, 400, "usdt_400_called");
-	ASSERT_EQ(bss->usdt_100_sum, 399 * 400 / 2, "usdt_400_sum");
+	ASSERT_EQ(bss->usdt_100_sum, 400 * 400, "usdt_400_sum");
 
 cleanup:
 	test_usdt__destroy(skel);
-- 
2.30.2

