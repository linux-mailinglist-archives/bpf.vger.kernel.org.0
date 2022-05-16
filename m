Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B20B528C17
	for <lists+bpf@lfdr.de>; Mon, 16 May 2022 19:36:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344312AbiEPRg3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 16 May 2022 13:36:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344360AbiEPRgQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 16 May 2022 13:36:16 -0400
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF96936E3C
        for <bpf@vger.kernel.org>; Mon, 16 May 2022 10:36:11 -0700 (PDT)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout02.posteo.de (Postfix) with ESMTPS id 90981240108
        for <bpf@vger.kernel.org>; Mon, 16 May 2022 19:36:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
        t=1652722570; bh=vFwroQ+ZcFTzYzu6CcYEgLqnok5nhecsV5aUkDQole8=;
        h=From:To:Subject:Date:From;
        b=UdWvWWz4h0YiLfEM7ZzKL4SmPP0leSchFoQe3ii/5Wzlgb7VDOtHnptk22TeN5LlM
         P7Z9vO0y3dfEeFR/XY8pGVj03RZKevkTMk98XW+Db9H6Ifb7jwHMqJTZ2nrU2MRfop
         h5GUxtTbnv3ZOu1RV88boqEg0z+I1NoWgmxLHIyRjsDokwSdTwIMV6nv5ePnIKlFAf
         nlmOwYOISYny24XJNFcUPpxbQO2OnzxKB0WdwwreGhYt+CNO5tY4+uw006k2TRGIwv
         QXSQmq3+mWarS4UBOP26Hz950dyerOq0m83BRMerVuQY1Oy7UZ9Ss3ng0FA/uff951
         /+OfbIXUyTCQA==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4L25yK4cPPz9rxB;
        Mon, 16 May 2022 19:36:09 +0200 (CEST)
From:   =?UTF-8?q?Daniel=20M=C3=BCller?= <deso@posteo.net>
To:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, kernel-team@fb.com, quentin@isovalent.com
Subject: [PATCH bpf-next 11/12] selftests/bpf: Add test for libbpf_bpf_link_type_str
Date:   Mon, 16 May 2022 17:35:39 +0000
Message-Id: <20220516173540.3520665-12-deso@posteo.net>
In-Reply-To: <20220516173540.3520665-1-deso@posteo.net>
References: <20220516173540.3520665-1-deso@posteo.net>
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

This change adds a test for libbpf_bpf_link_type_str. The test retrieves
all variants of the bpf_link_type enumeration using BTF and makes sure
that the function under test works as expected for them.

Signed-off-by: Daniel Müller <deso@posteo.net>
---
 .../selftests/bpf/prog_tests/libbpf_str.c     | 48 +++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/libbpf_str.c b/tools/testing/selftests/bpf/prog_tests/libbpf_str.c
index f5fa09..1e45dd 100644
--- a/tools/testing/selftests/bpf/prog_tests/libbpf_str.c
+++ b/tools/testing/selftests/bpf/prog_tests/libbpf_str.c
@@ -59,6 +59,51 @@ static void test_libbpf_bpf_attach_type_str(void)
 	btf__free(btf);
 }
 
+/**
+ * Test case to check that all bpf_link_type variants are covered by
+ * libbpf_bpf_link_type_str.
+ */
+static void test_libbpf_bpf_link_type_str(void)
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
+	/* find enum bpf_link_type and enumerate each value */
+	id = btf__find_by_name_kind(btf, "bpf_link_type", BTF_KIND_ENUM);
+	if (!ASSERT_GT(id, 0, "bpf_link_type_id"))
+		goto cleanup;
+	t = btf__type_by_id(btf, id);
+	e = btf_enum(t);
+	n = btf_vlen(t);
+	for (i = 0; i < n; e++, i++) {
+		enum bpf_link_type link_type = (enum bpf_link_type)e->val;
+		const char *link_type_name;
+		const char *link_type_str;
+		char buf[256];
+
+		if (link_type == MAX_BPF_LINK_TYPE)
+			continue;
+
+		link_type_name = btf__str_by_offset(btf, e->name_off);
+		link_type_str = libbpf_bpf_link_type_str(link_type);
+		ASSERT_OK_PTR(link_type_str, link_type_name);
+
+		snprintf(buf, sizeof(buf), "BPF_LINK_TYPE_%s", link_type_str);
+		uppercase(buf);
+
+		ASSERT_STREQ(buf, link_type_name, "exp_str_value");
+	}
+
+cleanup:
+	btf__free(btf);
+}
+
 /**
  * Test case to check that all bpf_map_type variants are covered by
  * libbpf_bpf_map_type_str.
@@ -151,6 +196,9 @@ void test_libbpf_str(void)
 	if (test__start_subtest("bpf_attach_type_str"))
 		test_libbpf_bpf_attach_type_str();
 
+	if (test__start_subtest("bpf_link_type_str"))
+		test_libbpf_bpf_link_type_str();
+
 	if (test__start_subtest("bpf_map_type_str"))
 		test_libbpf_bpf_map_type_str();
 
-- 
2.30.2

