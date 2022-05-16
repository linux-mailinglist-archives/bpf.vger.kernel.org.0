Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8B50528C0C
	for <lists+bpf@lfdr.de>; Mon, 16 May 2022 19:35:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235523AbiEPRfx (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 16 May 2022 13:35:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344322AbiEPRfu (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 16 May 2022 13:35:50 -0400
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E20B36E3E
        for <bpf@vger.kernel.org>; Mon, 16 May 2022 10:35:49 -0700 (PDT)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout01.posteo.de (Postfix) with ESMTPS id CC067240029
        for <bpf@vger.kernel.org>; Mon, 16 May 2022 19:35:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
        t=1652722547; bh=JKxU953oDp162p6Ydm5IYnqz22nVkzABsQ7Fc6fwFrM=;
        h=From:To:Subject:Date:From;
        b=JAPEyCDSk0u8LdLsy1sMD3T/2KRjQsvIJ0K42sjD7P+UWWu1ZpPeDFwsLRx0xIXwW
         PPNwS2gDJL6DIE/cuLhsoO1vSVlJFpjMJW7nOu+qGWgGieilPB13kXNnrXghb8f2rl
         Rhj9zxkTs8vrxW8gn41Lnp8SucgncklXKy67ssmhEn5DdpJ33tbJRDMCD7htWYP+P+
         xqxOPbsZqlO6s77d2YYE0rm/Z2PDcZ6HH8cSxXTUZcuBclzHC6xnZDB67tWPK1UHKf
         3lv5nVeC88E8O7nU+bgFgRy5R50YHQmXLGSMeJuakez/Ygm2rNyj6fgcuzT7HXXeWE
         MEQ8h2pmMak9g==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4L25xt6R51z9rxB;
        Mon, 16 May 2022 19:35:46 +0200 (CEST)
From:   =?UTF-8?q?Daniel=20M=C3=BCller?= <deso@posteo.net>
To:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, kernel-team@fb.com, quentin@isovalent.com
Subject: [PATCH bpf-next 02/12] selftests/bpf: Add test for libbpf_bpf_prog_type_str
Date:   Mon, 16 May 2022 17:35:30 +0000
Message-Id: <20220516173540.3520665-3-deso@posteo.net>
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

This change adds a test for libbpf_bpf_prog_type_str. The test retrieves
all variants of the bpf_prog_type enumeration using BTF and makes sure
that the function under test works as expected for them.

Signed-off-by: Daniel Müller <deso@posteo.net>
---
 .../selftests/bpf/prog_tests/libbpf_str.c     | 57 +++++++++++++++++++
 1 file changed, 57 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/libbpf_str.c

diff --git a/tools/testing/selftests/bpf/prog_tests/libbpf_str.c b/tools/testing/selftests/bpf/prog_tests/libbpf_str.c
new file mode 100644
index 0000000..3e7a14
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/libbpf_str.c
@@ -0,0 +1,57 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2022 Meta Platforms, Inc. and affiliates. */
+
+#include <ctype.h>
+#include <test_progs.h>
+#include <bpf/btf.h>
+
+/**
+ * Utility function uppercasing an entire string.
+ */
+static void uppercase(char *s)
+{
+	for (; *s != '\0'; s++)
+		*s = toupper(*s);
+}
+
+/**
+ * Test case to check that all bpf_prog_type variants are covered by
+ * libbpf_bpf_prog_type_str.
+ */
+void test_libbpf_bpf_prog_type_str(void)
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
+	/* find enum bpf_prog_type and enumerate each value */
+	id = btf__find_by_name_kind(btf, "bpf_prog_type", BTF_KIND_ENUM);
+	if (!ASSERT_GT(id, 0, "bpf_prog_type_id"))
+		goto cleanup;
+	t = btf__type_by_id(btf, id);
+	e = btf_enum(t);
+	n = btf_vlen(t);
+	for (i = 0; i < n; e++, i++) {
+		enum bpf_prog_type prog_type = (enum bpf_prog_type)e->val;
+		const char *prog_type_name;
+		const char *prog_type_str;
+		char buf[256];
+
+		prog_type_name = btf__str_by_offset(btf, e->name_off);
+		prog_type_str = libbpf_bpf_prog_type_str(prog_type);
+		ASSERT_OK_PTR(prog_type_str, prog_type_name);
+
+		snprintf(buf, sizeof(buf), "BPF_PROG_TYPE_%s", prog_type_str);
+		uppercase(buf);
+
+		ASSERT_STREQ(buf, prog_type_name, "exp_str_value");
+	}
+
+cleanup:
+	btf__free(btf);
+}
-- 
2.30.2

