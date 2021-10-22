Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBB154377AF
	for <lists+bpf@lfdr.de>; Fri, 22 Oct 2021 15:07:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232292AbhJVNJ5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 22 Oct 2021 09:09:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232263AbhJVNJ5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 22 Oct 2021 09:09:57 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8FDCC061766
        for <bpf@vger.kernel.org>; Fri, 22 Oct 2021 06:07:39 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id nn3-20020a17090b38c300b001a03bb6c4ebso3029875pjb.1
        for <bpf@vger.kernel.org>; Fri, 22 Oct 2021 06:07:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PzBLrWpkv9VQKtTn4cIy0m/hfItA1TH02WM8/nI43mQ=;
        b=lMh1Uqq4O4A3T1SP7GRkr67kf52u7l8h7A8BCRXzRBsDhnN6n0wauF29WEbG7gVYCR
         qUYOlthpfyuBClbo8aTwe0vUvziBnPU6rYdByVENGgq6CPoyzWhrH9WrR9v4q3YUgwtr
         4KE4BSs/Lnw6cOy0iT/fWNeGa3giHFqDU8AwfucL6H1h/XS50XYjv00x/kimopFBFuj4
         0z1cpaweMtpCATMzlNMafWXeg0wzF1G6DVPJTVlwJHehES+tAReXTvayV/5aPwOZZPxE
         MVgv2ianSvRwkGr4kDrbB49C8O1x76AbZ4jYkyXBlAdJ6RyT7ztbiGnybJ84YNRLu4P+
         yulg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PzBLrWpkv9VQKtTn4cIy0m/hfItA1TH02WM8/nI43mQ=;
        b=LHaCtvK/A9L2Iz0z1w/XmO0138duC7Xa21mbDntmx1R2yd+dciRzwzT7At8M61rRNM
         g87qALu0x7V8+BMqlJ6yZr2l/nFW6Zn3hsG1pcU7xQ48uZRCYCI7h4oL9ekPDl3rHMw+
         Iq4V1U5KDRk0fO0poq9sqVPvoxBRTf23ByFcWGGnEzmLUey2BDqwlSFuT4fJVPQGiUWS
         YlT6RN6XVAVesAy3f9gB3Q3ZfqpO7RQCKoZ0mvnvRUbS0s5I0gt3/daGF1HSXId4eHoT
         9Du7ROG7QktyYnFXfeI5KJ1run6bSDs47EVHaSNEmSUuE+AtBuX7Aq6ujajwgr1FpBpZ
         OGpA==
X-Gm-Message-State: AOAM530/P4k0Fg52kmRTeqV5nBAZ9aL0ofBlAlVzcBRWJFx/eHTtAxkc
        ZSyxHP0bPMAq4kTkBAOMQPL9oDCz9FPv+w==
X-Google-Smtp-Source: ABdhPJwygzcsOqEozwx/OxsvBpyvMp/Bo1T+WS2I18aQxmq9Ja64plSSB45TzS50cU81onaQRqhYyw==
X-Received: by 2002:a17:90a:191c:: with SMTP id 28mr14417342pjg.121.1634908059043;
        Fri, 22 Oct 2021 06:07:39 -0700 (PDT)
Received: from VM-32-4-ubuntu.. ([43.132.164.184])
        by smtp.gmail.com with ESMTPSA id k22sm9632083pfi.149.2021.10.22.06.07.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Oct 2021 06:07:38 -0700 (PDT)
From:   Hengqi Chen <hengqi.chen@gmail.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        yhs@fb.com, john.fastabend@gmail.com, kafai@fb.com,
        songliubraving@fb.com, hengqi.chen@gmail.com
Subject: [PATCH bpf-next 5/5 v2] selftests/bpf: Switch to new btf__type_cnt/btf__raw_data APIs
Date:   Fri, 22 Oct 2021 21:06:23 +0800
Message-Id: <20211022130623.1548429-6-hengqi.chen@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211022130623.1548429-1-hengqi.chen@gmail.com>
References: <20211022130623.1548429-1-hengqi.chen@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Replace the calls to btf__get_nr_types/btf__get_raw_data in
selftests with new APIs btf__type_cnt/btf__raw_data. The old
APIs will be deprecated in libbpf v0.7+.

Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>
---
 tools/testing/selftests/bpf/btf_helpers.c            |  4 ++--
 tools/testing/selftests/bpf/prog_tests/btf.c         | 10 +++++-----
 tools/testing/selftests/bpf/prog_tests/btf_dump.c    |  8 ++++----
 tools/testing/selftests/bpf/prog_tests/btf_endian.c  | 12 ++++++------
 tools/testing/selftests/bpf/prog_tests/btf_split.c   |  2 +-
 .../testing/selftests/bpf/prog_tests/core_autosize.c |  2 +-
 tools/testing/selftests/bpf/prog_tests/core_reloc.c  |  2 +-
 .../selftests/bpf/prog_tests/resolve_btfids.c        |  4 ++--
 8 files changed, 22 insertions(+), 22 deletions(-)

diff --git a/tools/testing/selftests/bpf/btf_helpers.c b/tools/testing/selftests/bpf/btf_helpers.c
index 668cfa20bb1b..b5b6b013a245 100644
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
index fa67f25bbef5..557f948f9964 100644
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
index 12f457b6786d..3d837a7019fd 100644
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
index 2a0dac6394ef..1dfe14ff6aa4 100644
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
index cc50f8feeca3..55ec85ba7375 100644
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
