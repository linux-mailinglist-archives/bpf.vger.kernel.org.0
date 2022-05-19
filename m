Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F26D152DF50
	for <lists+bpf@lfdr.de>; Thu, 19 May 2022 23:32:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234650AbiESVaZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 19 May 2022 17:30:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234614AbiESVaY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 19 May 2022 17:30:24 -0400
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 653D7A76C3
        for <bpf@vger.kernel.org>; Thu, 19 May 2022 14:30:23 -0700 (PDT)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout01.posteo.de (Postfix) with ESMTPS id 0B90E240029
        for <bpf@vger.kernel.org>; Thu, 19 May 2022 23:30:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
        t=1652995822; bh=b2UnSLOe6YnEphWwYCjWf7KXoRgx+UJLMgJ+5vNx88M=;
        h=From:To:Cc:Subject:Date:From;
        b=mpwEFnjw5bNe97BxMs1jaJdMjYaHTRcK+qSgqCMlvTASHqrxAaaFuS2ux13Mjq4be
         NYHkoQA5hOwXVPNum4bKiXtxt1bXzZ4yAMG+oBdtcwaz50GQIPyQ8rXtHJtX7lSTul
         qHbwmErCg17X7nL4EK0C97YkYvnsWrYT0j+bvmPHSMjFgqKGL47GyUBbsyilNFsR+k
         L7Z4x7YX8dUMPsnPdgD0Q7JRGG+cLikIT2S1eQob9AbFcHhhbyg6zb9NyKqXwoYIOn
         Cal8bszfJ8Kaiye3GnYKv+B5Q7l3w71G4IwcigsGJ+lylEp9JL+5gJ8JULvgcM2SES
         s0B3YNE5hkNOQ==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4L43191czhz6tmW;
        Thu, 19 May 2022 23:30:21 +0200 (CEST)
From:   =?UTF-8?q?Daniel=20M=C3=BCller?= <deso@posteo.net>
To:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, kernel-team@fb.com
Cc:     yhs@fb.com, quentin@isovalent.com
Subject: [PATCH bpf-next v3 08/12] selftests/bpf: Add test for libbpf_bpf_attach_type_str
Date:   Thu, 19 May 2022 21:29:57 +0000
Message-Id: <20220519213001.729261-9-deso@posteo.net>
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

This change adds a test for libbpf_bpf_attach_type_str. The test
retrieves all variants of the bpf_attach_type enumeration using BTF and
makes sure that the function under test works as expected for them.

Signed-off-by: Daniel Müller <deso@posteo.net>
---
 .../selftests/bpf/prog_tests/libbpf_str.c     | 48 +++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/libbpf_str.c b/tools/testing/selftests/bpf/prog_tests/libbpf_str.c
index 0f15aaa..f5fa09 100644
--- a/tools/testing/selftests/bpf/prog_tests/libbpf_str.c
+++ b/tools/testing/selftests/bpf/prog_tests/libbpf_str.c
@@ -14,6 +14,51 @@ static void uppercase(char *s)
 		*s = toupper(*s);
 }
 
+/**
+ * Test case to check that all bpf_attach_type variants are covered by
+ * libbpf_bpf_attach_type_str.
+ */
+static void test_libbpf_bpf_attach_type_str(void)
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
+	/* find enum bpf_attach_type and enumerate each value */
+	id = btf__find_by_name_kind(btf, "bpf_attach_type", BTF_KIND_ENUM);
+	if (!ASSERT_GT(id, 0, "bpf_attach_type_id"))
+		goto cleanup;
+	t = btf__type_by_id(btf, id);
+	e = btf_enum(t);
+	n = btf_vlen(t);
+	for (i = 0; i < n; e++, i++) {
+		enum bpf_attach_type attach_type = (enum bpf_attach_type)e->val;
+		const char *attach_type_name;
+		const char *attach_type_str;
+		char buf[256];
+
+		if (attach_type == __MAX_BPF_ATTACH_TYPE)
+			continue;
+
+		attach_type_name = btf__str_by_offset(btf, e->name_off);
+		attach_type_str = libbpf_bpf_attach_type_str(attach_type);
+		ASSERT_OK_PTR(attach_type_str, attach_type_name);
+
+		snprintf(buf, sizeof(buf), "BPF_%s", attach_type_str);
+		uppercase(buf);
+
+		ASSERT_STREQ(buf, attach_type_name, "exp_str_value");
+	}
+
+cleanup:
+	btf__free(btf);
+}
+
 /**
  * Test case to check that all bpf_map_type variants are covered by
  * libbpf_bpf_map_type_str.
@@ -103,6 +148,9 @@ static void test_libbpf_bpf_prog_type_str(void)
  */
 void test_libbpf_str(void)
 {
+	if (test__start_subtest("bpf_attach_type_str"))
+		test_libbpf_bpf_attach_type_str();
+
 	if (test__start_subtest("bpf_map_type_str"))
 		test_libbpf_bpf_map_type_str();
 
-- 
2.30.2

