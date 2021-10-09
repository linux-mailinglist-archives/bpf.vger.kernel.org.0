Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09912427B10
	for <lists+bpf@lfdr.de>; Sat,  9 Oct 2021 17:01:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234115AbhJIPDM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 9 Oct 2021 11:03:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233599AbhJIPDM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 9 Oct 2021 11:03:12 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90FC3C061570
        for <bpf@vger.kernel.org>; Sat,  9 Oct 2021 08:01:15 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id nn3-20020a17090b38c300b001a03bb6c4ebso7526802pjb.1
        for <bpf@vger.kernel.org>; Sat, 09 Oct 2021 08:01:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Or0xZPlURR0feHzdj4zYXkvkmkyi4TG44LhFEBcH8c8=;
        b=nK3FHtBRL5UxorefGDfb6v/1ifVPjIa+oLbBGSFyv7+SnS7P8TN0DN8c/JtC23xA31
         H+SFYb09W7MU4JgBxRRrWk9RDZC/wwusSuplZgshF8PCmekniSGta7XfdOh/elA6XeUl
         NA2ZTVv/4E3PRuLI4c5ynLVp1cccJ9x1SWZslgeO36ijGl5pnE6yE20OzMXKlPofTIJE
         bf+JEUHRl2JyQ6eQX2KEsDBoAOFCw+m6+N/lN8wvWVWrU60BGiVf9gkZnVMJQnusQ6Py
         mO4lqRZt4QzZQkrsnsvPcwhIIZ0na+PtHMYKZ2VEKoX9KsIXZjoQVuTGfRpNR9kK4iNF
         yg/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Or0xZPlURR0feHzdj4zYXkvkmkyi4TG44LhFEBcH8c8=;
        b=t6Ta+ItWpHfx4OLIa3Xmr5Uk6FBp7c9UOVauhAdi29+AhFjJCEeZgg5YlnU/8bo2ID
         C5slWbwsEbpX8uKtmpmDUhDmndpLurohofE192zhIy4oiRbgMiB6Xa+dhhSfj7kNl+H1
         aAxXXZ3W4MABhT010XO/Q+rZrH6oGGBBKm0zTC9AHzPTJ6s6iHYpP4uqDZZkR9UV8rRn
         0mn8lgmpw9ZfcRveb4maic4wZi6mZ63WtElrq6gJCQHMvh2ipn/CfuBR78zYY5vR8t18
         +InjpomjuZU8l+sYNhe0SedFCGZgmcAkx9NwOlJUZ8DmPRwRsd6vzj8BTpsb25jchFwg
         aQ9Q==
X-Gm-Message-State: AOAM532cU1PQ6qLAm7joo9S82MhT/ANzS3QQezFC20LMuQelPZhun39Z
        EHNQ60f1w4fWzBw8hn0JdndUiRy73R9W4plL
X-Google-Smtp-Source: ABdhPJzoBg4Nl21jsyILvGC0l8Rna1FAaKIYNx9r+D2icMh4A5LAg5T2CvvmIFPqV4+f3ZSXt1gdOA==
X-Received: by 2002:a17:90a:ec17:: with SMTP id l23mr6917783pjy.184.1633791674773;
        Sat, 09 Oct 2021 08:01:14 -0700 (PDT)
Received: from VM-32-4-ubuntu.. ([43.132.164.184])
        by smtp.gmail.com with ESMTPSA id w8sm2659331pfd.4.2021.10.09.08.01.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Oct 2021 08:01:14 -0700 (PDT)
From:   Hengqi Chen <hengqi.chen@gmail.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        yhs@fb.com, john.fastabend@gmail.com, kafai@fb.com,
        songliubraving@fb.com, hengqi.chen@gmail.com
Subject: [PATCH bpf-next 2/2] tools: Switch to new btf__type_cnt/btf__raw_data APIs
Date:   Sat,  9 Oct 2021 23:00:29 +0800
Message-Id: <20211009150029.1746383-3-hengqi.chen@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211009150029.1746383-1-hengqi.chen@gmail.com>
References: <20211009150029.1746383-1-hengqi.chen@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Replace the calls to btf__get_nr_types/btf__get_raw_data in tools
with new APIs btf__type_cnt/btf__raw_data. The old APIs will be
deprecated in recent release of libbpf.

Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>
---
 tools/bpf/bpftool/btf.c                              | 12 ++++++------
 tools/bpf/bpftool/gen.c                              |  4 ++--
 tools/bpf/resolve_btfids/main.c                      |  4 ++--
 tools/perf/util/bpf-event.c                          |  2 +-
 tools/testing/selftests/bpf/btf_helpers.c            |  4 ++--
 tools/testing/selftests/bpf/prog_tests/btf.c         | 10 +++++-----
 tools/testing/selftests/bpf/prog_tests/btf_dump.c    |  8 ++++----
 tools/testing/selftests/bpf/prog_tests/btf_endian.c  | 12 ++++++------
 tools/testing/selftests/bpf/prog_tests/btf_split.c   |  2 +-
 .../testing/selftests/bpf/prog_tests/core_autosize.c |  2 +-
 tools/testing/selftests/bpf/prog_tests/core_reloc.c  |  2 +-
 .../selftests/bpf/prog_tests/resolve_btfids.c        |  4 ++--
 12 files changed, 33 insertions(+), 33 deletions(-)

diff --git a/tools/bpf/bpftool/btf.c b/tools/bpf/bpftool/btf.c
index 49743ad96851..e5d22bef6d58 100644
--- a/tools/bpf/bpftool/btf.c
+++ b/tools/bpf/bpftool/btf.c
@@ -329,7 +329,7 @@ static int dump_btf_type(const struct btf *btf, __u32 id,
 				printf("\n\ttype_id=%u offset=%u size=%u",
 				       v->type, v->offset, v->size);
 
-				if (v->type <= btf__get_nr_types(btf)) {
+				if (v->type < btf__type_cnt(btf)) {
 					vt = btf__type_by_id(btf, v->type);
 					printf(" (%s '%s')",
 					       btf_kind_str[btf_kind_safe(btf_kind(vt))],
@@ -390,14 +390,14 @@ static int dump_btf_raw(const struct btf *btf,
 		}
 	} else {
 		const struct btf *base;
-		int cnt = btf__get_nr_types(btf);
+		int cnt = btf__type_cnt(btf);
 		int start_id = 1;
 
 		base = btf__base_btf(btf);
 		if (base)
-			start_id = btf__get_nr_types(base) + 1;
+			start_id = btf__type_cnt(base);
 
-		for (i = start_id; i <= cnt; i++) {
+		for (i = start_id; i < cnt; i++) {
 			t = btf__type_by_id(btf, i);
 			dump_btf_type(btf, i, t);
 		}
@@ -440,9 +440,9 @@ static int dump_btf_c(const struct btf *btf,
 				goto done;
 		}
 	} else {
-		int cnt = btf__get_nr_types(btf);
+		int cnt = btf__type_cnt(btf);
 
-		for (i = 1; i <= cnt; i++) {
+		for (i = 1; i < cnt; i++) {
 			err = btf_dump__dump_type(d, i);
 			if (err)
 				goto done;
diff --git a/tools/bpf/bpftool/gen.c b/tools/bpf/bpftool/gen.c
index b2ffc18eafc1..0f83088be3e4 100644
--- a/tools/bpf/bpftool/gen.c
+++ b/tools/bpf/bpftool/gen.c
@@ -192,7 +192,7 @@ static int codegen_datasec_def(struct bpf_object *obj,
 static int codegen_datasecs(struct bpf_object *obj, const char *obj_name)
 {
 	struct btf *btf = bpf_object__btf(obj);
-	int n = btf__get_nr_types(btf);
+	int n = btf__type_cnt(btf);
 	struct btf_dump *d;
 	int i, err = 0;
 
@@ -200,7 +200,7 @@ static int codegen_datasecs(struct bpf_object *obj, const char *obj_name)
 	if (IS_ERR(d))
 		return PTR_ERR(d);
 
-	for (i = 1; i <= n; i++) {
+	for (i = 1; i < n; i++) {
 		const struct btf_type *t = btf__type_by_id(btf, i);
 
 		if (!btf_is_datasec(t))
diff --git a/tools/bpf/resolve_btfids/main.c b/tools/bpf/resolve_btfids/main.c
index 716e6ad1864b..a59cb0ee609c 100644
--- a/tools/bpf/resolve_btfids/main.c
+++ b/tools/bpf/resolve_btfids/main.c
@@ -502,12 +502,12 @@ static int symbols_resolve(struct object *obj)
 	}
 
 	err = -1;
-	nr_types = btf__get_nr_types(btf);
+	nr_types = btf__type_cnt(btf);
 
 	/*
 	 * Iterate all the BTF types and search for collected symbol IDs.
 	 */
-	for (type_id = 1; type_id <= nr_types; type_id++) {
+	for (type_id = 1; type_id < nr_types; type_id++) {
 		const struct btf_type *type;
 		struct rb_root *root;
 		struct btf_id *id;
diff --git a/tools/perf/util/bpf-event.c b/tools/perf/util/bpf-event.c
index 1a7112a87736..388847bab6d9 100644
--- a/tools/perf/util/bpf-event.c
+++ b/tools/perf/util/bpf-event.c
@@ -110,7 +110,7 @@ static int perf_env__fetch_btf(struct perf_env *env,
 	u32 data_size;
 	const void *data;
 
-	data = btf__get_raw_data(btf, &data_size);
+	data = btf__raw_data(btf, &data_size);
 
 	node = malloc(data_size + sizeof(struct btf_node));
 	if (!node)
diff --git a/tools/testing/selftests/bpf/btf_helpers.c b/tools/testing/selftests/bpf/btf_helpers.c
index ce103fb0ad1b..7f1e3d9bdd76 100644
--- a/tools/testing/selftests/bpf/btf_helpers.c
+++ b/tools/testing/selftests/bpf/btf_helpers.c
@@ -215,7 +215,7 @@ int btf_validate_raw(struct btf *btf, int nr_types, const char *exp_types[])
 	int i;
 	bool ok = true;
 
-	ASSERT_EQ(btf__get_nr_types(btf), nr_types, "btf_nr_types");
+	ASSERT_EQ(btf__type_cnt(btf) - 1, nr_types, "btf_nr_types");
 
 	for (i = 1; i <= nr_types; i++) {
 		if (!ASSERT_STREQ(btf_type_raw_dump(btf, i), exp_types[i - 1], "raw_dump"))
@@ -254,7 +254,7 @@ const char *btf_type_c_dump(const struct btf *btf)
 		return NULL;
 	}
 
-	for (i = 1; i <= btf__get_nr_types(btf); i++) {
+	for (i = 1; i < btf__type_cnt(btf); i++) {
 		err = btf_dump__dump_type(d, i);
 		if (err) {
 			fprintf(stderr, "Failed to dump type [%d]: %d\n", i, err);
diff --git a/tools/testing/selftests/bpf/prog_tests/btf.c b/tools/testing/selftests/bpf/prog_tests/btf.c
index acd33d0cd5d9..7edf1452a510 100644
--- a/tools/testing/selftests/bpf/prog_tests/btf.c
+++ b/tools/testing/selftests/bpf/prog_tests/btf.c
@@ -7274,8 +7274,8 @@ static void do_test_dedup(unsigned int test_num)
 		goto done;
 	}
 
-	test_btf_data = btf__get_raw_data(test_btf, &test_btf_size);
-	expect_btf_data = btf__get_raw_data(expect_btf, &expect_btf_size);
+	test_btf_data = btf__raw_data(test_btf, &test_btf_size);
+	expect_btf_data = btf__raw_data(expect_btf, &expect_btf_size);
 	if (CHECK(test_btf_size != expect_btf_size,
 		  "test_btf_size:%u != expect_btf_size:%u",
 		  test_btf_size, expect_btf_size)) {
@@ -7329,8 +7329,8 @@ static void do_test_dedup(unsigned int test_num)
 		expect_str_cur += expect_len + 1;
 	}
 
-	test_nr_types = btf__get_nr_types(test_btf);
-	expect_nr_types = btf__get_nr_types(expect_btf);
+	test_nr_types = btf__type_cnt(test_btf);
+	expect_nr_types = btf__type_cnt(expect_btf);
 	if (CHECK(test_nr_types != expect_nr_types,
 		  "test_nr_types:%u != expect_nr_types:%u",
 		  test_nr_types, expect_nr_types)) {
@@ -7338,7 +7338,7 @@ static void do_test_dedup(unsigned int test_num)
 		goto done;
 	}
 
-	for (i = 1; i <= test_nr_types; i++) {
+	for (i = 1; i < test_nr_types; i++) {
 		const struct btf_type *test_type, *expect_type;
 		int test_size, expect_size;
 
diff --git a/tools/testing/selftests/bpf/prog_tests/btf_dump.c b/tools/testing/selftests/bpf/prog_tests/btf_dump.c
index 87f9df653e4e..08bcf693fef3 100644
--- a/tools/testing/selftests/bpf/prog_tests/btf_dump.c
+++ b/tools/testing/selftests/bpf/prog_tests/btf_dump.c
@@ -27,7 +27,7 @@ static struct btf_dump_test_case {
 static int btf_dump_all_types(const struct btf *btf,
 			      const struct btf_dump_opts *opts)
 {
-	size_t type_cnt = btf__get_nr_types(btf);
+	size_t type_cnt = btf__type_cnt(btf);
 	struct btf_dump *d;
 	int err = 0, id;
 
@@ -36,7 +36,7 @@ static int btf_dump_all_types(const struct btf *btf,
 	if (err)
 		return err;
 
-	for (id = 1; id <= type_cnt; id++) {
+	for (id = 1; id < type_cnt; id++) {
 		err = btf_dump__dump_type(d, id);
 		if (err)
 			goto done;
@@ -171,7 +171,7 @@ void test_btf_dump_incremental(void)
 	err = btf__add_field(btf, "x", 2, 0, 0);
 	ASSERT_OK(err, "field_ok");
 
-	for (i = 1; i <= btf__get_nr_types(btf); i++) {
+	for (i = 1; i < btf__type_cnt(btf); i++) {
 		err = btf_dump__dump_type(d, i);
 		ASSERT_OK(err, "dump_type_ok");
 	}
@@ -210,7 +210,7 @@ void test_btf_dump_incremental(void)
 	err = btf__add_field(btf, "s", 3, 32, 0);
 	ASSERT_OK(err, "field_ok");
 
-	for (i = 1; i <= btf__get_nr_types(btf); i++) {
+	for (i = 1; i < btf__type_cnt(btf); i++) {
 		err = btf_dump__dump_type(d, i);
 		ASSERT_OK(err, "dump_type_ok");
 	}
diff --git a/tools/testing/selftests/bpf/prog_tests/btf_endian.c b/tools/testing/selftests/bpf/prog_tests/btf_endian.c
index 8ab5d3e358dd..2653cc482df4 100644
--- a/tools/testing/selftests/bpf/prog_tests/btf_endian.c
+++ b/tools/testing/selftests/bpf/prog_tests/btf_endian.c
@@ -32,7 +32,7 @@ void test_btf_endian() {
 	ASSERT_EQ(btf__endianness(btf), swap_endian, "endian");
 
 	/* Get raw BTF data in non-native endianness... */
-	raw_data = btf__get_raw_data(btf, &raw_sz);
+	raw_data = btf__raw_data(btf, &raw_sz);
 	if (!ASSERT_OK_PTR(raw_data, "raw_data_inverted"))
 		goto err_out;
 
@@ -42,9 +42,9 @@ void test_btf_endian() {
 		goto err_out;
 
 	ASSERT_EQ(btf__endianness(swap_btf), swap_endian, "endian");
-	ASSERT_EQ(btf__get_nr_types(swap_btf), btf__get_nr_types(btf), "nr_types");
+	ASSERT_EQ(btf__type_cnt(swap_btf), btf__type_cnt(btf), "nr_types");
 
-	swap_raw_data = btf__get_raw_data(swap_btf, &swap_raw_sz);
+	swap_raw_data = btf__raw_data(swap_btf, &swap_raw_sz);
 	if (!ASSERT_OK_PTR(swap_raw_data, "swap_raw_data"))
 		goto err_out;
 
@@ -58,7 +58,7 @@ void test_btf_endian() {
 
 	/* swap it back to native endianness */
 	btf__set_endianness(swap_btf, endian);
-	swap_raw_data = btf__get_raw_data(swap_btf, &swap_raw_sz);
+	swap_raw_data = btf__raw_data(swap_btf, &swap_raw_sz);
 	if (!ASSERT_OK_PTR(swap_raw_data, "swap_raw_data"))
 		goto err_out;
 
@@ -75,7 +75,7 @@ void test_btf_endian() {
 	swap_btf = NULL;
 
 	btf__set_endianness(btf, swap_endian);
-	raw_data = btf__get_raw_data(btf, &raw_sz);
+	raw_data = btf__raw_data(btf, &raw_sz);
 	if (!ASSERT_OK_PTR(raw_data, "raw_data_inverted"))
 		goto err_out;
 
@@ -85,7 +85,7 @@ void test_btf_endian() {
 		goto err_out;
 
 	ASSERT_EQ(btf__endianness(swap_btf), swap_endian, "endian");
-	ASSERT_EQ(btf__get_nr_types(swap_btf), btf__get_nr_types(btf), "nr_types");
+	ASSERT_EQ(btf__type_cnt(swap_btf), btf__type_cnt(btf), "nr_types");
 
 	/* the type should appear as if it was stored in native endianness */
 	t = btf__type_by_id(swap_btf, var_id);
diff --git a/tools/testing/selftests/bpf/prog_tests/btf_split.c b/tools/testing/selftests/bpf/prog_tests/btf_split.c
index ca7c2a91610a..b1ffe61f2aa9 100644
--- a/tools/testing/selftests/bpf/prog_tests/btf_split.c
+++ b/tools/testing/selftests/bpf/prog_tests/btf_split.c
@@ -72,7 +72,7 @@ void test_btf_split() {
 	d = btf_dump__new(btf2, NULL, &opts, btf_dump_printf);
 	if (!ASSERT_OK_PTR(d, "btf_dump__new"))
 		goto cleanup;
-	for (i = 1; i <= btf__get_nr_types(btf2); i++) {
+	for (i = 1; i < btf__type_cnt(btf2); i++) {
 		err = btf_dump__dump_type(d, i);
 		ASSERT_OK(err, "dump_type_ok");
 	}
diff --git a/tools/testing/selftests/bpf/prog_tests/core_autosize.c b/tools/testing/selftests/bpf/prog_tests/core_autosize.c
index 3d4b2a358d47..2b63b90eee4a 100644
--- a/tools/testing/selftests/bpf/prog_tests/core_autosize.c
+++ b/tools/testing/selftests/bpf/prog_tests/core_autosize.c
@@ -112,7 +112,7 @@ void test_core_autosize(void)
 	if (!ASSERT_OK_PTR(f, "btf_fdopen"))
 		goto cleanup;
 
-	raw_data = btf__get_raw_data(btf, &raw_sz);
+	raw_data = btf__raw_data(btf, &raw_sz);
 	if (!ASSERT_OK_PTR(raw_data, "raw_data"))
 		goto cleanup;
 	written = fwrite(raw_data, 1, raw_sz, f);
diff --git a/tools/testing/selftests/bpf/prog_tests/core_reloc.c b/tools/testing/selftests/bpf/prog_tests/core_reloc.c
index 763302e63a29..9256c39042a5 100644
--- a/tools/testing/selftests/bpf/prog_tests/core_reloc.c
+++ b/tools/testing/selftests/bpf/prog_tests/core_reloc.c
@@ -381,7 +381,7 @@ static int setup_type_id_case_local(struct core_reloc_test_case *test)
 	exp->local_anon_void_ptr = -1;
 	exp->local_anon_arr = -1;
 
-	for (i = 1; i <= btf__get_nr_types(local_btf); i++)
+	for (i = 1; i < btf__type_cnt(local_btf); i++)
 	{
 		t = btf__type_by_id(local_btf, i);
 		/* we are interested only in anonymous types */
diff --git a/tools/testing/selftests/bpf/prog_tests/resolve_btfids.c b/tools/testing/selftests/bpf/prog_tests/resolve_btfids.c
index f62361306f6d..badda6309fd9 100644
--- a/tools/testing/selftests/bpf/prog_tests/resolve_btfids.c
+++ b/tools/testing/selftests/bpf/prog_tests/resolve_btfids.c
@@ -106,9 +106,9 @@ static int resolve_symbols(void)
 		  "Failed to load BTF from btf_data.o\n"))
 		return -1;
 
-	nr = btf__get_nr_types(btf);
+	nr = btf__type_cnt(btf);
 
-	for (type_id = 1; type_id <= nr; type_id++) {
+	for (type_id = 1; type_id < nr; type_id++) {
 		if (__resolve_symbol(btf, type_id))
 			break;
 	}
-- 
2.30.2

