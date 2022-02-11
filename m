Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 533104B2D49
	for <lists+bpf@lfdr.de>; Fri, 11 Feb 2022 20:09:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235772AbiBKTJo convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Fri, 11 Feb 2022 14:09:44 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234187AbiBKTJo (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 11 Feb 2022 14:09:44 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE6B9CC8
        for <bpf@vger.kernel.org>; Fri, 11 Feb 2022 11:09:42 -0800 (PST)
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 21BFDgMN001829
        for <bpf@vger.kernel.org>; Fri, 11 Feb 2022 11:09:42 -0800
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3e54v6a01v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 11 Feb 2022 11:09:42 -0800
Received: from twshared29821.14.frc2.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:11d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Fri, 11 Feb 2022 11:09:41 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 7A04910BA6BC7; Fri, 11 Feb 2022 11:09:27 -0800 (PST)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>
Subject: [PATCH bpf-next] selftests/bpf: fix GCC11 compiler warnings in -O2 mode
Date:   Fri, 11 Feb 2022 11:09:27 -0800
Message-ID: <20220211190927.1434329-1-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: Dj7L-5oNWuocRD4h2NArI8eOtqUxAkhQ
X-Proofpoint-GUID: Dj7L-5oNWuocRD4h2NArI8eOtqUxAkhQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-11_05,2022-02-11_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 mlxlogscore=879
 mlxscore=0 priorityscore=1501 malwarescore=0 spamscore=0 impostorscore=0
 lowpriorityscore=0 phishscore=0 clxscore=1015 adultscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202110102
X-FB-Internal: deliver
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

When compiling selftests in -O2 mode with GCC1, we get three new
compilations warnings about potentially uninitialized variables.

Compiler is wrong 2 out of 3 times, but this patch makes GCC11 happy
anyways, as it doesn't cost us anything and makes optimized selftests
build less annoying.

The amazing one is tc_redirect case of token that is malloc()'ed before
ASSERT_OK_PTR() check is done on it. Seems like GCC pessimistically
assumes that libbpf_get_error() will dereference the contents of the
pointer (no it won't), so the only way I found to shut GCC up was to do
zero-initializaing calloc(). This one was new to me.

For linfo case, GCC didn't realize that linfo_size will be initialized
by the function that is returning linfo_size as out parameter.

core_reloc.c case was a real bug, we can goto cleanup before initializing
obj. But we don't need to do any clean up, so just continue iteration
intstead.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/testing/selftests/bpf/prog_tests/btf.c         | 2 +-
 tools/testing/selftests/bpf/prog_tests/core_reloc.c  | 2 +-
 tools/testing/selftests/bpf/prog_tests/tc_redirect.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/btf.c b/tools/testing/selftests/bpf/prog_tests/btf.c
index 8b652f5ce423..ec823561b912 100644
--- a/tools/testing/selftests/bpf/prog_tests/btf.c
+++ b/tools/testing/selftests/bpf/prog_tests/btf.c
@@ -6556,7 +6556,7 @@ static int test_get_linfo(const struct prog_info_raw_test *test,
 static void do_test_info_raw(unsigned int test_num)
 {
 	const struct prog_info_raw_test *test = &info_raw_tests[test_num - 1];
-	unsigned int raw_btf_size, linfo_str_off, linfo_size;
+	unsigned int raw_btf_size, linfo_str_off, linfo_size = 0;
 	int btf_fd = -1, prog_fd = -1, err = 0;
 	void *raw_btf, *patched_linfo = NULL;
 	const char *ret_next_str;
diff --git a/tools/testing/selftests/bpf/prog_tests/core_reloc.c b/tools/testing/selftests/bpf/prog_tests/core_reloc.c
index b8bdd1c3efca..68e4c8dafa00 100644
--- a/tools/testing/selftests/bpf/prog_tests/core_reloc.c
+++ b/tools/testing/selftests/bpf/prog_tests/core_reloc.c
@@ -872,7 +872,7 @@ void test_core_reloc(void)
 		if (test_case->btf_src_file) {
 			err = access(test_case->btf_src_file, R_OK);
 			if (!ASSERT_OK(err, "btf_src_file"))
-				goto cleanup;
+				continue;
 		}
 
 		open_opts.btf_custom_path = test_case->btf_src_file;
diff --git a/tools/testing/selftests/bpf/prog_tests/tc_redirect.c b/tools/testing/selftests/bpf/prog_tests/tc_redirect.c
index c2426df58e17..647b0a833628 100644
--- a/tools/testing/selftests/bpf/prog_tests/tc_redirect.c
+++ b/tools/testing/selftests/bpf/prog_tests/tc_redirect.c
@@ -140,7 +140,7 @@ static struct nstoken *open_netns(const char *name)
 	int err;
 	struct nstoken *token;
 
-	token = malloc(sizeof(struct nstoken));
+	token = calloc(1, sizeof(struct nstoken));
 	if (!ASSERT_OK_PTR(token, "malloc token"))
 		return NULL;
 
-- 
2.30.2

