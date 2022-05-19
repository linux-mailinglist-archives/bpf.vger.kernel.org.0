Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A5F952DF4E
	for <lists+bpf@lfdr.de>; Thu, 19 May 2022 23:32:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234583AbiESVaS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 19 May 2022 17:30:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234542AbiESVaR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 19 May 2022 17:30:17 -0400
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C3B5A76C3
        for <bpf@vger.kernel.org>; Thu, 19 May 2022 14:30:17 -0700 (PDT)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout02.posteo.de (Postfix) with ESMTPS id B0774240109
        for <bpf@vger.kernel.org>; Thu, 19 May 2022 23:30:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
        t=1652995815; bh=vjKFQcygCT1Y4SNC69GT0iF0cDzTFXiedGe+w9bVimU=;
        h=From:To:Cc:Subject:Date:From;
        b=oG/SF/S/WNfUwloGbNtAJoSN7YOArSWIpKUHk3gES/lruw0eikAUM9ccSEqZpBSbG
         8nk1vPxYzSVaZA2xR8ALcRArkC/g8Zs4rq8q9KaZqcB5aZZxmJnCBPIQ5PHoEv3iw/
         WaNvnQl8sAtZt1fDRtHSUN0Zc8bb3BCUW6q8wXVbMSV+hPghRIb2GHduN7jZy1unS/
         fuVB5fUkkSY9nj4rBIU02G2Vj9awlQQMBuQ3cKERVjRAMflk4Jah9fgNMCq5EByZdN
         VVSsxYIr2ovEWCOA5k1BOvkLBqGJnXpDS1zFvEv2rr5SkjNbQMP9l6pJ8HUStBpjZf
         +CrrelLcsDzmA==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4L4312612Kz6tq0;
        Thu, 19 May 2022 23:30:14 +0200 (CEST)
From:   =?UTF-8?q?Daniel=20M=C3=BCller?= <deso@posteo.net>
To:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, kernel-team@fb.com
Cc:     yhs@fb.com, quentin@isovalent.com
Subject: [PATCH bpf-next v3 05/12] selftests/bpf: Add test for libbpf_bpf_map_type_str
Date:   Thu, 19 May 2022 21:29:54 +0000
Message-Id: <20220519213001.729261-6-deso@posteo.net>
In-Reply-To: <20220519213001.729261-1-deso@posteo.net>
References: <20220519213001.729261-1-deso@posteo.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This change adds a test for libbpf_bpf_map_type_str. The test retrieves
all variants of the bpf_map_type enumeration using BTF and makes sure
that the function under test works as expected for them.

Signed-off-by: Daniel Müller <deso@posteo.net>
---
 .../selftests/bpf/prog_tests/libbpf_str.c     | 56 ++++++++++++++++++-
 1 file changed, 55 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/libbpf_str.c b/tools/testing/selftests/bpf/prog_tests/libbpf_str.c
index 3e7a14..0f15aaa 100644
--- a/tools/testing/selftests/bpf/prog_tests/libbpf_str.c
+++ b/tools/testing/selftests/bpf/prog_tests/libbpf_str.c
@@ -14,11 +14,53 @@ static void uppercase(char *s)
 		*s = toupper(*s);
 }
 
+/**
+ * Test case to check that all bpf_map_type variants are covered by
+ * libbpf_bpf_map_type_str.
+ */
+static void test_libbpf_bpf_map_type_str(void)
+{
+	struct btf *btf;
+	const struct btf_type *t;
+	const struct btf_enum *e;
+	int i, n, id;
+
+	btf = btf__parse("/sys/kernel/btf/vmlinux", NULL);
+	if (!ASSERT_OK_PTR(btf, "btf_parse"))
+		return;
+
+	/* find enum bpf_map_type and enumerate each value */
+	id = btf__find_by_name_kind(btf, "bpf_map_type", BTF_KIND_ENUM);
+	if (!ASSERT_GT(id, 0, "bpf_map_type_id"))
+		goto cleanup;
+	t = btf__type_by_id(btf, id);
+	e = btf_enum(t);
+	n = btf_vlen(t);
+	for (i = 0; i < n; e++, i++) {
+		enum bpf_map_type map_type = (enum bpf_map_type)e->val;
+		const char *map_type_name;
+		const char *map_type_str;
+		char buf[256];
+
+		map_type_name = btf__str_by_offset(btf, e->name_off);
+		map_type_str = libbpf_bpf_map_type_str(map_type);
+		ASSERT_OK_PTR(map_type_str, map_type_name);
+
+		snprintf(buf, sizeof(buf), "BPF_MAP_TYPE_%s", map_type_str);
+		uppercase(buf);
+
+		ASSERT_STREQ(buf, map_type_name, "exp_str_value");
+	}
+
+cleanup:
+	btf__free(btf);
+}
+
 /**
  * Test case to check that all bpf_prog_type variants are covered by
  * libbpf_bpf_prog_type_str.
  */
-void test_libbpf_bpf_prog_type_str(void)
+static void test_libbpf_bpf_prog_type_str(void)
 {
 	struct btf *btf;
 	const struct btf_type *t;
@@ -55,3 +97,15 @@ void test_libbpf_bpf_prog_type_str(void)
 cleanup:
 	btf__free(btf);
 }
+
+/**
+ * Run all libbpf str conversion tests.
+ */
+void test_libbpf_str(void)
+{
+	if (test__start_subtest("bpf_map_type_str"))
+		test_libbpf_bpf_map_type_str();
+
+	if (test__start_subtest("bpf_prog_type_str"))
+		test_libbpf_bpf_prog_type_str();
+}
-- 
2.30.2

