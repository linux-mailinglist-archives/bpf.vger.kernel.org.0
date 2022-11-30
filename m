Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E25B063E114
	for <lists+bpf@lfdr.de>; Wed, 30 Nov 2022 21:00:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229513AbiK3UAX convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Wed, 30 Nov 2022 15:00:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbiK3UAX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 30 Nov 2022 15:00:23 -0500
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 301458C6B0
        for <bpf@vger.kernel.org>; Wed, 30 Nov 2022 12:00:22 -0800 (PST)
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AUJWFGu009806
        for <bpf@vger.kernel.org>; Wed, 30 Nov 2022 12:00:21 -0800
Received: from maileast.thefacebook.com ([163.114.130.8])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3m5w6agx75-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 30 Nov 2022 12:00:21 -0800
Received: from twshared21592.39.frc1.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::d) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 30 Nov 2022 12:00:19 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 0AA9222AFC7FA; Wed, 30 Nov 2022 12:00:17 -0800 (PST)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>
Subject: [PATCH bpf-next 2/2] selftests/bpf: make sure enum-less bpf_enable_stats() API works in C++ mode
Date:   Wed, 30 Nov 2022 12:00:13 -0800
Message-ID: <20221130200013.2997831-2-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221130200013.2997831-1-andrii@kernel.org>
References: <20221130200013.2997831-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: GMd6cQX9RCZNouo-ZUR2pTDy_lT_CC6X
X-Proofpoint-GUID: GMd6cQX9RCZNouo-ZUR2pTDy_lT_CC6X
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-30_04,2022-11-30_02,2022-06-22_01
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Just a simple test to make sure we don't introduce unwanted compiler
warnings and API still supports passing enums as input argument.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/testing/selftests/bpf/test_cpp.cpp | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/bpf/test_cpp.cpp b/tools/testing/selftests/bpf/test_cpp.cpp
index 19ad172036da..0bd9990e83fa 100644
--- a/tools/testing/selftests/bpf/test_cpp.cpp
+++ b/tools/testing/selftests/bpf/test_cpp.cpp
@@ -1,9 +1,9 @@
 /* SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause) */
 #include <iostream>
-#pragma GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wdeprecated-declarations"
+#include <unistd.h>
+#include <linux/bpf.h>
+#include <linux/btf.h>
 #include <bpf/libbpf.h>
-#pragma GCC diagnostic pop
 #include <bpf/bpf.h>
 #include <bpf/btf.h>
 #include "test_core_extern.skel.h"
@@ -99,6 +99,7 @@ int main(int argc, char *argv[])
 	struct btf_dump_opts opts = { };
 	struct test_core_extern *skel;
 	struct btf *btf;
+	int fd;
 
 	try_skeleton_template();
 
@@ -117,6 +118,12 @@ int main(int argc, char *argv[])
 	skel = test_core_extern__open_and_load();
 	test_core_extern__destroy(skel);
 
+	fd = bpf_enable_stats(BPF_STATS_RUN_TIME);
+	if (fd < 0)
+		std::cout << "FAILED to enable stats: " << fd << std::endl;
+	else
+		::close(fd);
+
 	std::cout << "DONE!" << std::endl;
 
 	return 0;
-- 
2.30.2

