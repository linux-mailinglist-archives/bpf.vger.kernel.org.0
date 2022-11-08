Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7152A621850
	for <lists+bpf@lfdr.de>; Tue,  8 Nov 2022 16:32:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233751AbiKHPcH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 8 Nov 2022 10:32:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232923AbiKHPcG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 8 Nov 2022 10:32:06 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 871ABDF4E
        for <bpf@vger.kernel.org>; Tue,  8 Nov 2022 07:32:04 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id o4so21574239wrq.6
        for <bpf@vger.kernel.org>; Tue, 08 Nov 2022 07:32:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jSq5pSSmv6HFFK0BYaZp6IdaOMj0pgqR16ivoycbc3k=;
        b=VSJwvKdpk23iPCF9Vg14U3cLvNDLjEvwWOtE/YQm1cgN5uxoCyVd2f70llQKApvM+W
         cPW/RjfIauBc1mBvCxu4Yzqsz7wKm6CKPWw+620To7kj922ztBOehx/p5jklRIxx8WcU
         UrUYL0q1WupGooZ9Y923T3eOmKE//nvVkTTC5H4zib9d8uvyl2eRsAXhQtNA+Ziur552
         Zd5T7FILyjoDLpiPjZn3OflvBQUWDixd9EzPRLIY329glXBRc922kCs1Lqi0CU2F2C9a
         7vRZc8Q1dPBDMjpnlCvnzYJGaccwcG89NIRlSmh5TDCJQilXiRIYeRmtjjxL4FceEAW5
         cUyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jSq5pSSmv6HFFK0BYaZp6IdaOMj0pgqR16ivoycbc3k=;
        b=JjvQ7sZr6yGwpAQXjBvHV6QeUfzU1V9XiFX4W1Je29UNLDRVTDXrus/Jy5QL46H9Y7
         zpdF2mUAzEfqinI/yJUFgKR5ZF95eJGxHyZevD4d3h5As1tw51OKpCPIH/UK4PpBFlhS
         p2nTgWZyfEBNhuYzd/nHd8pDef6s/j8N7KaZNiTWdu/ZlgugMpWpUifkT7+cn0mwWDks
         LBbNbTBlv3KREYyT8A5AHVLD3/bJB28CAslYboWnNHfBPMwYBdR0AiYw7bJbJNGphv0Q
         5+uMtHaqK+NN1vmQjAcVxkee4pfvUf2Kqhs8bQTbQg7tEtz1/eMgyZb2rs+OrK1lUmgS
         5oew==
X-Gm-Message-State: ACrzQf2klEu3hdK/4X6cpyjjg1DS0qBxJGIEdZW1+crXpO3Km6hHLQM9
        pJq0gTXeceAi6B3FF6fOSCRlfBHB0tuDyj7u
X-Google-Smtp-Source: AMsMyM7QP19NbDA8rZqeNXvCnYXJKt6za38x+cwWOeA3g+rXjgRVb1qau+ID1Re7DNtXUDRYME2PPg==
X-Received: by 2002:a05:6000:144d:b0:236:f53e:363d with SMTP id v13-20020a056000144d00b00236f53e363dmr21253685wrx.422.1667921522793;
        Tue, 08 Nov 2022 07:32:02 -0800 (PST)
Received: from pluto.. (boundsly.muster.volia.net. [93.72.16.93])
        by smtp.gmail.com with ESMTPSA id e5-20020adfef05000000b00225307f43fbsm10666822wro.44.2022.11.08.07.32.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Nov 2022 07:32:02 -0800 (PST)
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     bpf@vger.kernel.org, ast@kernel.org
Cc:     andrii@kernel.org, daniel@iogearbox.net, kernel-team@fb.com,
        yhs@fb.com, Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v2 3/3] selftests/bpf: Tests for BTF_KIND_DECL_TAG dump in C format
Date:   Tue,  8 Nov 2022 17:31:35 +0200
Message-Id: <20221108153135.491383-4-eddyz87@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221108153135.491383-1-eddyz87@gmail.com>
References: <20221108153135.491383-1-eddyz87@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Covers the following cases:
- `__atribute__((btf_decl_tag("...")))` could be applied to structs
  and unions;
- decl tag applied to an empty struct is printed on a single line;
- decl tags with the same name could be applied to several structs;
- several decl tags could be applied to the same struct;
- attribute `packed` works fine with decl tags (it is a separate
  branch in `tools/lib/bpf/btf_dump.c:btf_dump_emit_attributes`;
- decl tag could be attached to typedef;
- decl tag could be attached to a struct field;
- decl tag could be attached to a struct field and a struct itself
  simultaneously;
- decl tag could be attached to a global variable;
- decl tag could be attached to a func proto parameter;
- btf__add_decl_tag could be interleaved with btf_dump__dump_type calls.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 .../selftests/bpf/prog_tests/btf_dump.c       | 80 +++++++++++++++++++
 .../bpf/progs/btf_dump_test_case_decl_tag.c   | 65 +++++++++++++++
 2 files changed, 145 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/btf_dump_test_case_decl_tag.c

diff --git a/tools/testing/selftests/bpf/prog_tests/btf_dump.c b/tools/testing/selftests/bpf/prog_tests/btf_dump.c
index a0bdfc45660d..0d428c559ad9 100644
--- a/tools/testing/selftests/bpf/prog_tests/btf_dump.c
+++ b/tools/testing/selftests/bpf/prog_tests/btf_dump.c
@@ -23,6 +23,7 @@ static struct btf_dump_test_case {
 	{"btf_dump: bitfields", "btf_dump_test_case_bitfields", true},
 	{"btf_dump: multidim", "btf_dump_test_case_multidim", false},
 	{"btf_dump: namespacing", "btf_dump_test_case_namespacing", false},
+	{"btf_dump: decl_tag", "btf_dump_test_case_decl_tag", true},
 };
 
 static int btf_dump_all_types(const struct btf *btf, struct btf_dump *d)
@@ -345,6 +346,82 @@ static void test_btf_dump_incremental(void)
 	btf__free(btf);
 }
 
+static void test_btf_dump_func_proto_decl_tag(void)
+{
+	struct btf *btf = NULL;
+	struct btf_dump *d = NULL;
+	int id, err;
+
+	dump_buf_file = open_memstream(&dump_buf, &dump_buf_sz);
+	if (!ASSERT_OK_PTR(dump_buf_file, "dump_memstream"))
+		return;
+	btf = btf__new_empty();
+	if (!ASSERT_OK_PTR(btf, "new_empty"))
+		goto err_out;
+	d = btf_dump__new(btf, btf_dump_printf, dump_buf_file, NULL);
+	if (!ASSERT_OK(libbpf_get_error(d), "btf_dump__new"))
+		goto err_out;
+
+	/* First, BTF corresponding to the following C code:
+	 *
+	 * typedef void (*fn)(int a __btf_decl_tag("a_tag"));
+	 *
+	 */
+	id = btf__add_int(btf, "int", 4, BTF_INT_SIGNED);
+	ASSERT_EQ(id, 1, "int_id");
+	id = btf__add_func_proto(btf, 0);
+	ASSERT_EQ(id, 2, "func_proto_id");
+	err = btf__add_func_param(btf, "a", 1);
+	ASSERT_OK(err, "func_param_ok");
+	id = btf__add_decl_tag(btf, "a_tag", 2, 0);
+	ASSERT_EQ(id, 3, "decl_tag_a");
+	id = btf__add_ptr(btf, 2);
+	ASSERT_EQ(id, 4, "proto_ptr");
+	id = btf__add_typedef(btf, "fn", 4);
+	ASSERT_EQ(id, 5, "typedef");
+
+	err = btf_dump_all_types(btf, d);
+	ASSERT_OK(err, "btf_dump_all_types #1");
+	fflush(dump_buf_file);
+	dump_buf[dump_buf_sz] = 0; /* some libc implementations don't do this */
+
+	ASSERT_STREQ(dump_buf,
+		     "#if __has_attribute(btf_decl_tag)\n"
+		     "#define __btf_decl_tag(x) __attribute__((btf_decl_tag(x)))\n"
+		     "#else\n"
+		     "#define __btf_decl_tag(x)\n"
+		     "#endif\n"
+		     "\n"
+		     "typedef void (*fn)(int a __btf_decl_tag(\"a_tag\"));\n\n",
+		     "decl tags for fn");
+
+	/* Next, add BTF corresponding to the following C code:
+	 *
+	 * typedef int foo __btf_decl_tag("foo_tag");
+	 *
+	 * To verify that decl_tag's table is updated incrementally.
+	 */
+	id = btf__add_typedef(btf, "foo", 1);
+	ASSERT_EQ(id, 6, "typedef");
+	id = btf__add_decl_tag(btf, "foo_tag", 6, -1);
+	ASSERT_EQ(id, 7, "decl_tag_foo");
+
+	fseek(dump_buf_file, 0, SEEK_SET);
+	err = btf_dump_all_types(btf, d);
+	ASSERT_OK(err, "btf_dump_all_types #2");
+	fflush(dump_buf_file);
+	dump_buf[dump_buf_sz] = 0; /* some libc implementations don't do this */
+
+	ASSERT_STREQ(dump_buf,
+		     "typedef int foo __btf_decl_tag(\"foo_tag\");\n\n",
+		     "decl tags for foo");
+err_out:
+	fclose(dump_buf_file);
+	free(dump_buf);
+	btf_dump__free(d);
+	btf__free(btf);
+}
+
 #define STRSIZE				4096
 
 static void btf_dump_snprintf(void *ctx, const char *fmt, va_list args)
@@ -964,6 +1041,9 @@ void test_btf_dump() {
 	if (test__start_subtest("btf_dump: incremental"))
 		test_btf_dump_incremental();
 
+	if (test__start_subtest("btf_dump: func arg decl_tag"))
+		test_btf_dump_func_proto_decl_tag();
+
 	btf = libbpf_find_kernel_btf();
 	if (!ASSERT_OK_PTR(btf, "no kernel BTF found"))
 		return;
diff --git a/tools/testing/selftests/bpf/progs/btf_dump_test_case_decl_tag.c b/tools/testing/selftests/bpf/progs/btf_dump_test_case_decl_tag.c
new file mode 100644
index 000000000000..1205351e9a68
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/btf_dump_test_case_decl_tag.c
@@ -0,0 +1,65 @@
+// SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
+
+/*
+ * BTF-to-C dumper test for __atribute__((btf_decl_tag("..."))).
+ */
+
+#define SEC(x) __attribute__((section(x)))
+
+/* ----- START-EXPECTED-OUTPUT ----- */
+#if __has_attribute(btf_decl_tag)
+#define __btf_decl_tag(x) __attribute__((btf_decl_tag(x)))
+#else
+#define __btf_decl_tag(x)
+#endif
+
+struct empty_with_tag {} __btf_decl_tag("a");
+
+struct one_tag {
+	int x;
+} __btf_decl_tag("b");
+
+struct same_tag {
+	int x;
+} __btf_decl_tag("b");
+
+struct two_tags {
+	int x;
+} __btf_decl_tag("a") __btf_decl_tag("b");
+
+struct packed {
+	int x;
+	short y;
+} __attribute__((packed)) __btf_decl_tag("another_name");
+
+typedef int td_with_tag __btf_decl_tag("td");
+
+struct tags_on_fields {
+	int x __btf_decl_tag("t1");
+	int y;
+	int z __btf_decl_tag("t2") __btf_decl_tag("t3");
+};
+
+struct tag_on_field_and_struct {
+	int x __btf_decl_tag("t1");
+} __btf_decl_tag("t2");
+
+struct root_struct {
+	struct empty_with_tag a;
+	struct one_tag b;
+	struct same_tag c;
+	struct two_tags d;
+	struct packed e;
+	td_with_tag f;
+	struct tags_on_fields g;
+	struct tag_on_field_and_struct h;
+};
+
+SEC(".data") int global_var __btf_decl_tag("var_tag") = (int)777;
+
+/* ------ END-EXPECTED-OUTPUT ------ */
+
+int f(struct root_struct *s)
+{
+	return 0;
+}
-- 
2.34.1

