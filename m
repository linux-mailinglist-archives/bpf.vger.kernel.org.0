Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DA71531F15
	for <lists+bpf@lfdr.de>; Tue, 24 May 2022 01:05:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231288AbiEWXE6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 23 May 2022 19:04:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231437AbiEWXE5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 23 May 2022 19:04:57 -0400
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF0AFAF1E7
        for <bpf@vger.kernel.org>; Mon, 23 May 2022 16:04:56 -0700 (PDT)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout02.posteo.de (Postfix) with ESMTPS id 812DE240107
        for <bpf@vger.kernel.org>; Tue, 24 May 2022 01:04:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
        t=1653347095; bh=JC9GdLQk7vQr50oSUZjyG9qAlOkMnJHQCE8OaLOiKhA=;
        h=From:To:Cc:Subject:Date:From;
        b=HpJrKrQIsHZQyIVGOsg7VghQpKdVU5QZyBIl6t23W9ENH0Tgt+8qynltGbAfDdEUy
         7augGgCYcQFVtxHGBMddJ/u7WeVgrP9V29ORVnrTU7C6a975s2eCN6UC6emvx9bfdu
         UIHp63nMgfXWD1RqwNq0Rs9itT9Gii1T2t2qhFBbkj44odEBbbMQehnjt1YYir3ry/
         ggIZ80j8p9/dtZ6q+RQrEVqTbgcaT2mA/vd+SuloEzxAxMS9dI/wzYBJgfvoOJwA7F
         DpRr/DgQTWO048TrkG68Hv7p8iKIjJLYUqRhchUUQyjDvXMy0wo6ErhpgAimkDNhqG
         mmxwKaGYINlbQ==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4L6XwQ5ghfz6tmG;
        Tue, 24 May 2022 01:04:54 +0200 (CEST)
From:   =?UTF-8?q?Daniel=20M=C3=BCller?= <deso@posteo.net>
To:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, kernel-team@fb.com
Cc:     yhs@fb.com, quentin@isovalent.com
Subject: [PATCH bpf-next v4 11/12] selftests/bpf: Add test for libbpf_bpf_link_type_str
Date:   Mon, 23 May 2022 23:04:27 +0000
Message-Id: <20220523230428.3077108-12-deso@posteo.net>
In-Reply-To: <20220523230428.3077108-1-deso@posteo.net>
References: <20220523230428.3077108-1-deso@posteo.net>
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
Acked-by: Quentin Monnet <quentin@isovalent.com>
Acked-by: Yonghong Song <yhs@fb.com>
---
 .../selftests/bpf/prog_tests/libbpf_str.c     | 48 +++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/libbpf_str.c b/tools/testing/selftests/bpf/prog_tests/libbpf_str.c
index c88df9..93e9cdd 100644
--- a/tools/testing/selftests/bpf/prog_tests/libbpf_str.c
+++ b/tools/testing/selftests/bpf/prog_tests/libbpf_str.c
@@ -59,6 +59,51 @@ static void test_libbpf_bpf_attach_type_str(void)
 	btf__free(btf);
 }
 
+/*
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
 /*
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

