Return-Path: <bpf+bounces-49906-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B2BDA201CB
	for <lists+bpf@lfdr.de>; Tue, 28 Jan 2025 00:40:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD1281885B16
	for <lists+bpf@lfdr.de>; Mon, 27 Jan 2025 23:40:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C97C11DE2B6;
	Mon, 27 Jan 2025 23:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="a+9r9Fl0"
X-Original-To: bpf@vger.kernel.org
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1451F1DE2A0
	for <bpf@vger.kernel.org>; Mon, 27 Jan 2025 23:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738021214; cv=none; b=I2R02DzPoG2TeZDfqRQnIx67+wFNS6SBpAktHj/k5PVR6chUlM42A9e8zvV6z3ch9NnmxvXD0QiXOgRQ0yi8BVCKYDXEsJV/5MRKEfL0PjKuIbKbJbnLv9FuP03ZcNZf/92qa9B2peCpho03+hBGuX//vrdHcdsBHN1F8E4LYZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738021214; c=relaxed/simple;
	bh=zo98IgL3cy95gvAzq1lWy2F83iimb5lczNHVBMLc4V0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HZ67WdgONOMaRkpLU7vahr+dsw8hNYYpKjM6eGXsdKDMGvFGesDkoqdB+6xoOYWXSFs+PNJHWxxnDyWm1MHttqIUnrKHdusw8Szq64rHqFMjonC4M0ClFLG71XIlJQ3HELdImpuwQAfTd4BGn7U6PBiZW8RGoFnqOQgXLFq1sSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=a+9r9Fl0; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1738021209;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WLo2SMSF7WbHZA/gHLajoQxi/lzquozNwzWWOGRJta8=;
	b=a+9r9Fl03BRj1SZPZY9R4QUM2jA44N1qr+2JzOm9HDRmDSE4qZl7MHt1Suho45V0nf0DJ3
	QdChigWiUlYMVEnNBUYO/UIzA45YMnKrV+O26RhiNF/Q2w77F1mHOlVEORrvrCM+kjSEl/
	Wns42jjBnIm/wJeqGJW+wFz3CJkXKzQ=
From: Ihor Solodrai <ihor.solodrai@linux.dev>
To: bpf@vger.kernel.org
Cc: andrii@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	mykolal@fb.com,
	jose.marchesi@oracle.com
Subject: [PATCH bpf-next v2 4/6] selftests/bpf: add a btf_dump test for type_tags
Date: Mon, 27 Jan 2025 15:39:53 -0800
Message-ID: <20250127233955.2275804-5-ihor.solodrai@linux.dev>
In-Reply-To: <20250127233955.2275804-1-ihor.solodrai@linux.dev>
References: <20250127233955.2275804-1-ihor.solodrai@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Factor out common routines handling custom BTF from
test_btf_dump_incremental. Then use them in the
test_btf_dump_type_tags.

test_btf_dump_type_tags verifies that a type tag is dumped correctly
with respect to its kflag.

Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
Acked-by: Eduard Zingerman <eddyz87@gmail.com>
---
 .../selftests/bpf/prog_tests/btf_dump.c       | 147 +++++++++++++-----
 1 file changed, 110 insertions(+), 37 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/btf_dump.c b/tools/testing/selftests/bpf/prog_tests/btf_dump.c
index b293b8501fd6..c0a776feec23 100644
--- a/tools/testing/selftests/bpf/prog_tests/btf_dump.c
+++ b/tools/testing/selftests/bpf/prog_tests/btf_dump.c
@@ -126,26 +126,69 @@ static int test_btf_dump_case(int n, struct btf_dump_test_case *t)
 	return err;
 }
 
-static char *dump_buf;
-static size_t dump_buf_sz;
-static FILE *dump_buf_file;
+struct test_ctx {
+	struct btf *btf;
+	struct btf_dump *d;
+	char *dump_buf;
+	size_t dump_buf_sz;
+	FILE *dump_buf_file;
+};
 
-static void test_btf_dump_incremental(void)
+static void test_ctx__free(struct test_ctx *t)
 {
-	struct btf *btf = NULL;
-	struct btf_dump *d = NULL;
-	int id, err, i;
+	fclose(t->dump_buf_file);
+	free(t->dump_buf);
+	btf_dump__free(t->d);
+	btf__free(t->btf);
+}
 
-	dump_buf_file = open_memstream(&dump_buf, &dump_buf_sz);
-	if (!ASSERT_OK_PTR(dump_buf_file, "dump_memstream"))
-		return;
-	btf = btf__new_empty();
-	if (!ASSERT_OK_PTR(btf, "new_empty"))
+static int test_ctx__init(struct test_ctx *t)
+{
+	t->dump_buf_file = open_memstream(&t->dump_buf, &t->dump_buf_sz);
+	if (!ASSERT_OK_PTR(t->dump_buf_file, "dump_memstream"))
+		return -1;
+	t->btf = btf__new_empty();
+	if (!ASSERT_OK_PTR(t->btf, "new_empty"))
 		goto err_out;
-	d = btf_dump__new(btf, btf_dump_printf, dump_buf_file, NULL);
-	if (!ASSERT_OK(libbpf_get_error(d), "btf_dump__new"))
+	t->d = btf_dump__new(t->btf, btf_dump_printf, t->dump_buf_file, NULL);
+	if (!ASSERT_OK(libbpf_get_error(t->d), "btf_dump__new"))
 		goto err_out;
 
+	return 0;
+
+err_out:
+	test_ctx__free(t);
+	return -1;
+}
+
+static void test_ctx__dump_and_compare(struct test_ctx *t,
+				       const char *expected_output,
+				       const char *message)
+{
+	int i, err;
+
+	for (i = 1; i < btf__type_cnt(t->btf); i++) {
+		err = btf_dump__dump_type(t->d, i);
+		ASSERT_OK(err, "dump_type_ok");
+	}
+
+	fflush(t->dump_buf_file);
+	t->dump_buf[t->dump_buf_sz] = 0; /* some libc implementations don't do this */
+
+	ASSERT_STREQ(t->dump_buf, expected_output, message);
+}
+
+static void test_btf_dump_incremental(void)
+{
+	struct test_ctx t = {};
+	struct btf *btf;
+	int id, err;
+
+	if (test_ctx__init(&t))
+		return;
+
+	btf = t.btf;
+
 	/* First, generate BTF corresponding to the following C code:
 	 *
 	 * enum x;
@@ -182,15 +225,7 @@ static void test_btf_dump_incremental(void)
 	err = btf__add_field(btf, "x", 4, 0, 0);
 	ASSERT_OK(err, "field_ok");
 
-	for (i = 1; i < btf__type_cnt(btf); i++) {
-		err = btf_dump__dump_type(d, i);
-		ASSERT_OK(err, "dump_type_ok");
-	}
-
-	fflush(dump_buf_file);
-	dump_buf[dump_buf_sz] = 0; /* some libc implementations don't do this */
-
-	ASSERT_STREQ(dump_buf,
+	test_ctx__dump_and_compare(&t,
 "enum x;\n"
 "\n"
 "enum x {\n"
@@ -221,7 +256,7 @@ static void test_btf_dump_incremental(void)
 	 * enum values don't conflict;
 	 *
 	 */
-	fseek(dump_buf_file, 0, SEEK_SET);
+	fseek(t.dump_buf_file, 0, SEEK_SET);
 
 	id = btf__add_struct(btf, "s", 4);
 	ASSERT_EQ(id, 7, "struct_id");
@@ -232,14 +267,7 @@ static void test_btf_dump_incremental(void)
 	err = btf__add_field(btf, "s", 6, 64, 0);
 	ASSERT_OK(err, "field_ok");
 
-	for (i = 1; i < btf__type_cnt(btf); i++) {
-		err = btf_dump__dump_type(d, i);
-		ASSERT_OK(err, "dump_type_ok");
-	}
-
-	fflush(dump_buf_file);
-	dump_buf[dump_buf_sz] = 0; /* some libc implementations don't do this */
-	ASSERT_STREQ(dump_buf,
+	test_ctx__dump_and_compare(&t,
 "struct s___2 {\n"
 "	enum x x;\n"
 "	enum {\n"
@@ -248,11 +276,53 @@ static void test_btf_dump_incremental(void)
 "	struct s s;\n"
 "};\n\n" , "c_dump1");
 
-err_out:
-	fclose(dump_buf_file);
-	free(dump_buf);
-	btf_dump__free(d);
-	btf__free(btf);
+	test_ctx__free(&t);
+}
+
+static void test_btf_dump_type_tags(void)
+{
+	struct test_ctx t = {};
+	struct btf *btf;
+	int id, err;
+
+	if (test_ctx__init(&t))
+		return;
+
+	btf = t.btf;
+
+	/* Generate BTF corresponding to the following C code:
+	 *
+	 * struct s {
+	 *   void __attribute__((btf_type_tag(\"void_tag\"))) *p1;
+	 *   void __attribute__((void_attr)) *p2;
+	 * };
+	 *
+	 */
+
+	id = btf__add_type_tag(btf, "void_tag", 0);
+	ASSERT_EQ(id, 1, "type_tag_id");
+	id = btf__add_ptr(btf, id);
+	ASSERT_EQ(id, 2, "void_ptr_id1");
+
+	id = btf__add_type_attr(btf, "void_attr", 0);
+	ASSERT_EQ(id, 3, "type_attr_id");
+	id = btf__add_ptr(btf, id);
+	ASSERT_EQ(id, 4, "void_ptr_id2");
+
+	id = btf__add_struct(btf, "s", 8);
+	ASSERT_EQ(id, 5, "struct_id");
+	err = btf__add_field(btf, "p1", 2, 0, 0);
+	ASSERT_OK(err, "field_ok1");
+	err = btf__add_field(btf, "p2", 4, 0, 0);
+	ASSERT_OK(err, "field_ok2");
+
+	test_ctx__dump_and_compare(&t,
+"struct s {\n"
+"	void __attribute__((btf_type_tag(\"void_tag\"))) *p1;\n"
+"	void __attribute__((void_attr)) *p2;\n"
+"};\n\n", "dump_and_compare");
+
+	test_ctx__free(&t);
 }
 
 #define STRSIZE				4096
@@ -874,6 +944,9 @@ void test_btf_dump() {
 	if (test__start_subtest("btf_dump: incremental"))
 		test_btf_dump_incremental();
 
+	if (test__start_subtest("btf_dump: type_tags"))
+		test_btf_dump_type_tags();
+
 	btf = libbpf_find_kernel_btf();
 	if (!ASSERT_OK_PTR(btf, "no kernel BTF found"))
 		return;
-- 
2.48.1


