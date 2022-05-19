Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99E9952DF5B
	for <lists+bpf@lfdr.de>; Thu, 19 May 2022 23:32:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234614AbiESVad (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 19 May 2022 17:30:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234567AbiESVac (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 19 May 2022 17:30:32 -0400
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8CCA6E8CD
        for <bpf@vger.kernel.org>; Thu, 19 May 2022 14:30:30 -0700 (PDT)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout01.posteo.de (Postfix) with ESMTPS id 9A5BF240028
        for <bpf@vger.kernel.org>; Thu, 19 May 2022 23:30:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
        t=1652995829; bh=vFwroQ+ZcFTzYzu6CcYEgLqnok5nhecsV5aUkDQole8=;
        h=From:To:Cc:Subject:Date:From;
        b=YMQMO/ZsmXvbO4Q89k/y2z6HsqsGth2CwFpWGqXQs7kTiGYWx/u2bbB2Pr7TfGYnU
         WNhpgevEYVDxl4x9muQqC4fVvC1ccLIlL56muOIVii1bJAvWs7OO8wzzAppHD7zYon
         xU36FcARQwCARwgZYag2S91O32vve6aURpFbTDACquway8TYUlrElEPhf6vsywgiOX
         nJ9hRWpPZ/GCjyRKNM281sjnU3TKGlhWs7LiNKVYQQySdFg7eCKYM2NFFC9UCdxpl3
         xwcyKYpKjBVT1ToBxmN4D2uo9kRvjavQGhuRh6YK9Y84lMD7oo9+oRQtj/qQ9Uirlt
         UXVTgD6lx0Nqg==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4L431H5FRFz6tss;
        Thu, 19 May 2022 23:30:27 +0200 (CEST)
From:   =?UTF-8?q?Daniel=20M=C3=BCller?= <deso@posteo.net>
To:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, kernel-team@fb.com
Cc:     yhs@fb.com, quentin@isovalent.com
Subject: [PATCH bpf-next v3 11/12] selftests/bpf: Add test for libbpf_bpf_link_type_str
Date:   Thu, 19 May 2022 21:30:00 +0000
Message-Id: <20220519213001.729261-12-deso@posteo.net>
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

