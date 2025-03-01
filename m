Return-Path: <bpf+bounces-52959-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AF7F5A4A837
	for <lists+bpf@lfdr.de>; Sat,  1 Mar 2025 04:02:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A0F73189815C
	for <lists+bpf@lfdr.de>; Sat,  1 Mar 2025 03:02:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 387301ADC69;
	Sat,  1 Mar 2025 03:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FgwgqRr8"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com [209.85.128.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4FE11CA84
	for <bpf@vger.kernel.org>; Sat,  1 Mar 2025 03:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740798139; cv=none; b=c5ybrmYHaOte7yFSSob40EXa06KRom7AEH8/0K3cRUDQiJ4Z/Rom9sAHlFm2WPGDopVfz1GVcBPuna6Apf5GBPI1K+WrIGS5e/Y5NcHRl1Czl9nhnqmWNrE58xLV8MK2+GQhIFtKS2eJfOs1qCW5ohHwuZ6uutXbcgrwPr1o4qE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740798139; c=relaxed/simple;
	bh=xtnwzGz8N+rP2QXagom8tXWjNGA2I4BEXiqL+8BnRFo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ileXDe7Ig9bBiP3IZHPm0f4jEDD3obtpEkWNZjv5KaN/+O82DWvja83DxW19N03M7PHeMqMhyCtn+7b50/kAl65GpVu0zW8MUyOXiYV2c+hClt0+W0UDxJnsNiSS+irV5kSZddtyOIwG2FhJGmTuYNA/+E0CScSBr6sTadLt5xM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FgwgqRr8; arc=none smtp.client-ip=209.85.128.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f65.google.com with SMTP id 5b1f17b1804b1-43aac0390e8so17717725e9.2
        for <bpf@vger.kernel.org>; Fri, 28 Feb 2025 19:02:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740798134; x=1741402934; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GYBIgSDdjCsi6kW+edufKKreTkO/TuPvwk2aqVo4MjQ=;
        b=FgwgqRr8s+rTSnSjMborEHGTV8lPU4knORv9vfU1Y0TzWZ4TvbO2pvBSoQ2IMuA7sT
         Ec1xifsyyR0C9KNFmwoHnwgdbdzAnfrYka6Tjo6aLyW4W3BI7xdwM2Kmrw9ttxymCTWk
         QuTZSWBChuwEhCs8BGgbPruXPTqufT2a5URtM96F7NqgWJCmQS75ao5g3UQM+a8r4aBE
         WtbrKo5TkISpOGGOTI+9UXukEqM5YhqJfxGXNY6roDZcXbIqqKeqMrBo5vKJzuVqNCE9
         KTA/QxVW178szvLuREoorlrIskfpFAKubnLntW9n2TWVsLXQjLyJko6VDqjgwrBzirI6
         42eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740798134; x=1741402934;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GYBIgSDdjCsi6kW+edufKKreTkO/TuPvwk2aqVo4MjQ=;
        b=VbCH6qZAc6EQNeGRfzBmoMOC3CpS3avlFTszqTI+KvfxV874ta6zojAhx1vk/Z6dTs
         5NEZ/hlpAB7RAoS59drnN0JrIFpEluOUSVU+wGFlOx5heIDzjTG8Qp6WFABSQC1DBEYg
         43Nu17MGNYWGDwHNiRkocF3JxTC98fLtkCOGEGn3fMlepEfTRgPSWRAGvLx0nZEtx7DF
         m235qoLOFmaYXk8tm/iCC85GPUswos6dl+fbqtrNLq/nODmF7ZQV1M/a2V2Q0rr8ZN+/
         D/c+yEEuog2Dst6Nl2IodfmPELXvpKd4vezGDJsM4vPx44eaE5NBPb4XYIWbMqlsd0b5
         133g==
X-Gm-Message-State: AOJu0Ywbhrc9+QyRWQxWbF/BRqEvvHXK1fnZ7aF/EITCSdlspWpZAuXU
	/dpXm89Xw+tdZThrzZybIUoulOrugRd4SSS02hzorj66xx1gAO7i3avM4Vdq9MI=
X-Gm-Gg: ASbGnctzgb+QCp1veDJmrFFMqKRHBOunYVaoVrU45/nzyqU5qiy4N+QH+l5DrXNvEHF
	2HxZkRvevxmyZS8V1M1VpxFM8crMJamk0ZNVsGBZJIQWpD86NxWQeucfgfTaeWXzupk5d1GqfpP
	AaEJ+0IySkfRm/AhIEse4xgFByiYVzSBOMayWPE5dlb5MNDq3KyDoPZoWq9F6UtHZN0ve0qEHKV
	ZmVwefXAOIhIE51Crcl580/IQdFRTdGBVMTUxOyW3oxeF9hp4oswax/9EivMV5/uetsCaNeu6VG
	Q+4gK/KmnQbTa+blWjo/tkk+7eGYf00lDKI=
X-Google-Smtp-Source: AGHT+IG5tIhlmlslQzYMLDIc/YD/Qmpsyy2XZDtsQl3bPGCXGdJLQ7LFB//gM50MxByK5wv1ap9Hng==
X-Received: by 2002:a05:6000:1447:b0:38f:2350:7f70 with SMTP id ffacd0b85a97d-390ec7d25ddmr4858726f8f.24.1740798134401;
        Fri, 28 Feb 2025 19:02:14 -0800 (PST)
Received: from localhost ([2a03:2880:31ff:71::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e47a72d5sm7065918f8f.31.2025.02.28.19.02.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 19:02:13 -0800 (PST)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v2 3/3] selftests/bpf: Add tests for extending sleepable global subprogs
Date: Fri, 28 Feb 2025 19:02:05 -0800
Message-ID: <20250301030205.1221223-4-memxor@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250301030205.1221223-1-memxor@gmail.com>
References: <20250301030205.1221223-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=12699; h=from:subject; bh=xtnwzGz8N+rP2QXagom8tXWjNGA2I4BEXiqL+8BnRFo=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBnwnVAuehVdKdpJEWaFWhD6N7FL970EGk/Zj3QbKyF l76FmliJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZ8J1QAAKCRBM4MiGSL8RyoUfD/ 4unS4dt4IC8AD5CrhI+3lRAKVywZRL2Rl396JgypEz0oJVXFhG31z3OX4Qc8ZEjkI61fUUjfO1Qvxt X+kcHGaqwfwsXbQMAG/0RsGQKY0wosghffVDEFRdLp+EiQVo/m5rhMOERjItKJlAtLzyeUD3nMaoNd /UzUSDVh9Uw2uEwqBkB2TzVp1V/+CxZ5pOhosCWmxWmh62lZAU7Gs7G3IMi0pk8bjgfOjLDV6R1k4a hzzCwcwWguL9M+GZPZxOlmP7EyCiz3H+s3u5NXAiTqoRBOg84lY00G5XqlFB8gjtGQOGT3yFNL+AgR 6EPP0VMZxbSib5FahcD1TbGkijWvtBeHOIg7PrzsQUQxCxtjCIN+WePYrPCMNzjHVmgbwGpqUKDFwf gGsuBV1AL0Ldj5ziJ4Jvq3iGwdJw4oS0H7ZeJ2vjE4lRC+DAaT79Niz86arM2acapob9H7GBmIJ8l4 +atm7XHjX80vJJJZeLEXsp/yofDrP04tMLVjt67+TndZ3FqZKhYYpOPopeiU7H72dSwZm3PTGRBTjC FbZlFonQG7ZqLRCc247cpSN0abK+JaBoyYF4rNvcaKQh+mvfebXIxB9jF9mNQnclp0iOVAIA+046Dg Lnhh1uDQe4NKtSy0EfXzXVSWo1yKGOZpH/omYDlB6iqJ/QuM0J5vEg6xOd0w==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

Add tests for freplace behavior with the combination of sleepable
and non-sleepable global subprogs. The changes_pkt_data selftest
did all the hardwork, so simply rename it and include new support
for more summarization tests for might_sleep bit.

Sleepable extensions don't work yet, so add support but disable it for
now, allow support to be tested once it's enabled (and ensure we will
complain then).

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 .../bpf/prog_tests/changes_pkt_data.c         | 107 -------------
 .../selftests/bpf/prog_tests/summarization.c  | 143 ++++++++++++++++++
 .../{changes_pkt_data.c => summarization.c}   |  38 ++++-
 ...ta_freplace.c => summarization_freplace.c} |  13 ++
 4 files changed, 193 insertions(+), 108 deletions(-)
 delete mode 100644 tools/testing/selftests/bpf/prog_tests/changes_pkt_data.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/summarization.c
 rename tools/testing/selftests/bpf/progs/{changes_pkt_data.c => summarization.c} (52%)
 rename tools/testing/selftests/bpf/progs/{changes_pkt_data_freplace.c => summarization_freplace.c} (66%)

diff --git a/tools/testing/selftests/bpf/prog_tests/changes_pkt_data.c b/tools/testing/selftests/bpf/prog_tests/changes_pkt_data.c
deleted file mode 100644
index 7526de379081..000000000000
--- a/tools/testing/selftests/bpf/prog_tests/changes_pkt_data.c
+++ /dev/null
@@ -1,107 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-#include "bpf/libbpf.h"
-#include "changes_pkt_data_freplace.skel.h"
-#include "changes_pkt_data.skel.h"
-#include <test_progs.h>
-
-static void print_verifier_log(const char *log)
-{
-	if (env.verbosity >= VERBOSE_VERY)
-		fprintf(stdout, "VERIFIER LOG:\n=============\n%s=============\n", log);
-}
-
-static void test_aux(const char *main_prog_name,
-		     const char *to_be_replaced,
-		     const char *replacement,
-		     bool expect_load)
-{
-	struct changes_pkt_data_freplace *freplace = NULL;
-	struct bpf_program *freplace_prog = NULL;
-	struct bpf_program *main_prog = NULL;
-	LIBBPF_OPTS(bpf_object_open_opts, opts);
-	struct changes_pkt_data *main = NULL;
-	char log[16*1024];
-	int err;
-
-	opts.kernel_log_buf = log;
-	opts.kernel_log_size = sizeof(log);
-	if (env.verbosity >= VERBOSE_SUPER)
-		opts.kernel_log_level = 1 | 2 | 4;
-	main = changes_pkt_data__open_opts(&opts);
-	if (!ASSERT_OK_PTR(main, "changes_pkt_data__open"))
-		goto out;
-	main_prog = bpf_object__find_program_by_name(main->obj, main_prog_name);
-	if (!ASSERT_OK_PTR(main_prog, "main_prog"))
-		goto out;
-	bpf_program__set_autoload(main_prog, true);
-	err = changes_pkt_data__load(main);
-	print_verifier_log(log);
-	if (!ASSERT_OK(err, "changes_pkt_data__load"))
-		goto out;
-	freplace = changes_pkt_data_freplace__open_opts(&opts);
-	if (!ASSERT_OK_PTR(freplace, "changes_pkt_data_freplace__open"))
-		goto out;
-	freplace_prog = bpf_object__find_program_by_name(freplace->obj, replacement);
-	if (!ASSERT_OK_PTR(freplace_prog, "freplace_prog"))
-		goto out;
-	bpf_program__set_autoload(freplace_prog, true);
-	bpf_program__set_autoattach(freplace_prog, true);
-	bpf_program__set_attach_target(freplace_prog,
-				       bpf_program__fd(main_prog),
-				       to_be_replaced);
-	err = changes_pkt_data_freplace__load(freplace);
-	print_verifier_log(log);
-	if (expect_load) {
-		ASSERT_OK(err, "changes_pkt_data_freplace__load");
-	} else {
-		ASSERT_ERR(err, "changes_pkt_data_freplace__load");
-		ASSERT_HAS_SUBSTR(log, "Extension program changes packet data", "error log");
-	}
-
-out:
-	changes_pkt_data_freplace__destroy(freplace);
-	changes_pkt_data__destroy(main);
-}
-
-/* There are two global subprograms in both changes_pkt_data.skel.h:
- * - one changes packet data;
- * - another does not.
- * It is ok to freplace subprograms that change packet data with those
- * that either do or do not. It is only ok to freplace subprograms
- * that do not change packet data with those that do not as well.
- * The below tests check outcomes for each combination of such freplace.
- * Also test a case when main subprogram itself is replaced and is a single
- * subprogram in a program.
- */
-void test_changes_pkt_data_freplace(void)
-{
-	struct {
-		const char *main;
-		const char *to_be_replaced;
-		bool changes;
-	} mains[] = {
-		{ "main_with_subprogs",   "changes_pkt_data",         true },
-		{ "main_with_subprogs",   "does_not_change_pkt_data", false },
-		{ "main_changes",         "main_changes",             true },
-		{ "main_does_not_change", "main_does_not_change",     false },
-	};
-	struct {
-		const char *func;
-		bool changes;
-	} replacements[] = {
-		{ "changes_pkt_data",         true },
-		{ "does_not_change_pkt_data", false }
-	};
-	char buf[64];
-
-	for (int i = 0; i < ARRAY_SIZE(mains); ++i) {
-		for (int j = 0; j < ARRAY_SIZE(replacements); ++j) {
-			snprintf(buf, sizeof(buf), "%s_with_%s",
-				 mains[i].to_be_replaced, replacements[j].func);
-			if (!test__start_subtest(buf))
-				continue;
-			test_aux(mains[i].main, mains[i].to_be_replaced, replacements[j].func,
-				 mains[i].changes || !replacements[j].changes);
-		}
-	}
-}
diff --git a/tools/testing/selftests/bpf/prog_tests/summarization.c b/tools/testing/selftests/bpf/prog_tests/summarization.c
new file mode 100644
index 000000000000..ee7517b2a606
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/summarization.c
@@ -0,0 +1,143 @@
+// SPDX-License-Identifier: GPL-2.0
+#include "bpf/libbpf.h"
+#include "summarization_freplace.skel.h"
+#include "summarization.skel.h"
+#include <test_progs.h>
+
+static void print_verifier_log(const char *log)
+{
+	if (env.verbosity >= VERBOSE_VERY)
+		fprintf(stdout, "VERIFIER LOG:\n=============\n%s=============\n", log);
+}
+
+static void test_aux(const char *main_prog_name,
+		     const char *to_be_replaced,
+		     const char *replacement,
+		     bool expect_load,
+		     const char *err_msg)
+{
+	struct summarization_freplace *freplace = NULL;
+	struct bpf_program *freplace_prog = NULL;
+	struct bpf_program *main_prog = NULL;
+	LIBBPF_OPTS(bpf_object_open_opts, opts);
+	struct summarization *main = NULL;
+	char log[16*1024];
+	int err;
+
+	opts.kernel_log_buf = log;
+	opts.kernel_log_size = sizeof(log);
+	if (env.verbosity >= VERBOSE_SUPER)
+		opts.kernel_log_level = 1 | 2 | 4;
+	main = summarization__open_opts(&opts);
+	if (!ASSERT_OK_PTR(main, "summarization__open"))
+		goto out;
+	main_prog = bpf_object__find_program_by_name(main->obj, main_prog_name);
+	if (!ASSERT_OK_PTR(main_prog, "main_prog"))
+		goto out;
+	bpf_program__set_autoload(main_prog, true);
+	err = summarization__load(main);
+	print_verifier_log(log);
+	if (!ASSERT_OK(err, "summarization__load"))
+		goto out;
+	freplace = summarization_freplace__open_opts(&opts);
+	if (!ASSERT_OK_PTR(freplace, "summarization_freplace__open"))
+		goto out;
+	freplace_prog = bpf_object__find_program_by_name(freplace->obj, replacement);
+	if (!ASSERT_OK_PTR(freplace_prog, "freplace_prog"))
+		goto out;
+	bpf_program__set_autoload(freplace_prog, true);
+	bpf_program__set_autoattach(freplace_prog, true);
+	bpf_program__set_attach_target(freplace_prog,
+				       bpf_program__fd(main_prog),
+				       to_be_replaced);
+	err = summarization_freplace__load(freplace);
+	print_verifier_log(log);
+
+	/* Sleepable extension prog doesn't work yet, but make sure we catch
+	 * this condition and activate the error below in case it becomes
+	 * supported, as we would need to test this condition then.
+	 */
+	if (!strcmp("might_sleep", replacement)) {
+		ASSERT_EQ(err, -EINVAL, "might_sleep load must fail");
+		test__skip();
+		goto out;
+	}
+
+	if (expect_load) {
+		ASSERT_OK(err, "summarization_freplace__load");
+	} else {
+		ASSERT_ERR(err, "summarization_freplace__load");
+		ASSERT_HAS_SUBSTR(log, err_msg, "error log");
+	}
+
+out:
+	summarization_freplace__destroy(freplace);
+	summarization__destroy(main);
+}
+
+/* There are two global subprograms in both summarization.skel.h:
+ * - one changes packet data;
+ * - another does not.
+ * It is ok to freplace subprograms that change packet data with those
+ * that either do or do not. It is only ok to freplace subprograms
+ * that do not change packet data with those that do not as well.
+ * The below tests check outcomes for each combination of such freplace.
+ * Also test a case when main subprogram itself is replaced and is a single
+ * subprogram in a program.
+ *
+ * This holds for might_sleep programs. It is ok to replace might_sleep with
+ * might_sleep and with does_not_sleep, but does_not_sleep cannot be replaced
+ * with might_sleep.
+ */
+void test_summarization_freplace(void)
+{
+	struct {
+		const char *main;
+		const char *to_be_replaced;
+		bool has_side_effect;
+	} mains[2][4] = {
+		{
+			{ "main_changes_with_subprogs",		"changes_pkt_data",	    true },
+			{ "main_changes_with_subprogs",		"does_not_change_pkt_data", false },
+			{ "main_changes",			"main_changes",             true },
+			{ "main_does_not_change",		"main_does_not_change",     false },
+		},
+		{
+			{ "main_might_sleep_with_subprogs",	"might_sleep",		    true },
+			{ "main_might_sleep_with_subprogs",	"does_not_sleep",	    false },
+			{ "main_might_sleep",			"might_sleep",		    true },
+			{ "main_does_not_sleep",		"does_not_sleep",	    false },
+		},
+	};
+	const char *pkt_err = "Extension program changes packet data";
+	const char *slp_err = "Extension program may sleep";
+	struct {
+		const char *func;
+		bool has_side_effect;
+		const char *err_msg;
+	} replacements[2][2] = {
+		{
+			{ "changes_pkt_data",	      true,	pkt_err },
+			{ "does_not_change_pkt_data", false,	pkt_err },
+		},
+		{
+			{ "might_sleep",	      true,	slp_err },
+			{ "does_not_sleep",	      false,	slp_err },
+		},
+	};
+	char buf[64];
+
+	for (int t = 0; t < 2; t++) {
+		for (int i = 0; i < ARRAY_SIZE(mains); ++i) {
+			for (int j = 0; j < ARRAY_SIZE(replacements); ++j) {
+				snprintf(buf, sizeof(buf), "%s_with_%s",
+					 mains[t][i].to_be_replaced, replacements[t][j].func);
+				if (!test__start_subtest(buf))
+					continue;
+				test_aux(mains[t][i].main, mains[t][i].to_be_replaced, replacements[t][j].func,
+					 mains[t][i].has_side_effect || !replacements[t][j].has_side_effect,
+					 replacements[t][j].err_msg);
+			}
+		}
+	}
+}
diff --git a/tools/testing/selftests/bpf/progs/changes_pkt_data.c b/tools/testing/selftests/bpf/progs/summarization.c
similarity index 52%
rename from tools/testing/selftests/bpf/progs/changes_pkt_data.c
rename to tools/testing/selftests/bpf/progs/summarization.c
index 43cada48b28a..730342f7b37c 100644
--- a/tools/testing/selftests/bpf/progs/changes_pkt_data.c
+++ b/tools/testing/selftests/bpf/progs/summarization.c
@@ -16,7 +16,7 @@ long does_not_change_pkt_data(struct __sk_buff *sk)
 }
 
 SEC("?tc")
-int main_with_subprogs(struct __sk_buff *sk)
+int main_changes_with_subprogs(struct __sk_buff *sk)
 {
 	changes_pkt_data(sk);
 	does_not_change_pkt_data(sk);
@@ -36,4 +36,40 @@ int main_does_not_change(struct __sk_buff *sk)
 	return 0;
 }
 
+__noinline
+long might_sleep(int i)
+{
+	bpf_copy_from_user(&i, sizeof(i), NULL);
+	return i;
+}
+
+__noinline __weak
+long does_not_sleep(int i)
+{
+	return 0;
+}
+
+SEC("?syscall")
+int main_might_sleep_with_subprogs(void *ctx)
+{
+	might_sleep(0);
+	does_not_sleep(0);
+	return 0;
+}
+
+SEC("?syscall")
+int main_might_sleep(void *ctx)
+{
+	int i;
+
+	bpf_copy_from_user(&i, sizeof(i), NULL);
+	return i;
+}
+
+SEC("?syscall")
+int main_does_not_sleep(void *sk)
+{
+	return 0;
+}
+
 char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/progs/changes_pkt_data_freplace.c b/tools/testing/selftests/bpf/progs/summarization_freplace.c
similarity index 66%
rename from tools/testing/selftests/bpf/progs/changes_pkt_data_freplace.c
rename to tools/testing/selftests/bpf/progs/summarization_freplace.c
index f9a622705f1b..c813b1278138 100644
--- a/tools/testing/selftests/bpf/progs/changes_pkt_data_freplace.c
+++ b/tools/testing/selftests/bpf/progs/summarization_freplace.c
@@ -15,4 +15,17 @@ long does_not_change_pkt_data(struct __sk_buff *sk)
 	return 0;
 }
 
+SEC("?freplace")
+long might_sleep(int i)
+{
+	bpf_copy_from_user(&i, sizeof(i), NULL);
+	return i;
+}
+
+SEC("?freplace")
+long does_not_sleep(int i)
+{
+	return 0;
+}
+
 char _license[] SEC("license") = "GPL";
-- 
2.43.5


