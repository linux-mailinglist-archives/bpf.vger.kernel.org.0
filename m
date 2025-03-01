Return-Path: <bpf+bounces-52985-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B9EF5A4AC8A
	for <lists+bpf@lfdr.de>; Sat,  1 Mar 2025 16:19:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E7A721881B16
	for <lists+bpf@lfdr.de>; Sat,  1 Mar 2025 15:19:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B15201E3DC4;
	Sat,  1 Mar 2025 15:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IIL6keXk"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com [209.85.128.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2040D1E2616
	for <bpf@vger.kernel.org>; Sat,  1 Mar 2025 15:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740842336; cv=none; b=nM6D5o3ubHgJN8h/YASIv9VfEk9KiCZI77gDnzfP3OiKVpfMzXX0AyPCIYa1SUZPWoKwgJ3aokdybeEl3DmKkHvwSoJfDfVQnfHZGfSLafenkAO9V0JMjqSffA4F0GdF/V4VGOeukHGF6RsF+qRkK90ssUw0IVSUgOLQD3Sx3g4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740842336; c=relaxed/simple;
	bh=qaoLNXP6CZG1utXmYVbNKhcwzeDlyzLGDt8XEsfefHc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d9ZJfo5pgto+9YhB5fybwJZtNXB0FPgrHQYQ+BjBkLru7fstiIxLZmXyZ5BUqBuZjICuBxUiWEyXoyX9gjyhSB+lAkAyGwmeW5TNi2B3bUt/O/IDTaMbbnTK+s+hthJXWktNUIvR/QawY7P5KoHg7ZNu5SilDRjcVIS93aYu2CA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IIL6keXk; arc=none smtp.client-ip=209.85.128.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f66.google.com with SMTP id 5b1f17b1804b1-43bb25a8666so3026735e9.1
        for <bpf@vger.kernel.org>; Sat, 01 Mar 2025 07:18:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740842332; x=1741447132; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uBCwFsTus+NV0qABJix3eMvo+FnTv/NKxMV1SZkgWAw=;
        b=IIL6keXk+rZkFHsk9HYfLxd1t7EG/lC29xw0Kz418eq0Lm29c516GAsJp6sz7zmEmz
         qWDTxEp15hV3/HEv8zwPfXMjP3b3jSbL1+Hp+YLDk1oKusTWwWM6+NHkdjUve10MWNJW
         Ez7LFudMbv1qRcjhMuZPtxjqT2t9ghRipvHTdNxGalhae9F6X1xoWIPhj4WKozXcK+ua
         65VyVCkuG/zgwZQjjMQHWeHnq9trDC7A1I1CLyIOCzGeUbJYcEAylK0Cbb6ix2KXw6AS
         Q9nw2f6LsYA4rZuQ14TrBj7MTGRKQLEnEpRpozjpHaTDFWqVqAWgIVLYnROej6MMlhWl
         FFbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740842332; x=1741447132;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uBCwFsTus+NV0qABJix3eMvo+FnTv/NKxMV1SZkgWAw=;
        b=OsUDO+ahEQxBsVrGYLEPSriR1wBmHHTlUSukXeEPYPxb6u3ZD850CtvjgVpgi3MlNl
         tXJulLmQ+y/uWx4otY/WPoKbkAlHyR1FRjUvBLPwtGBnc4uyrWsnfP01FlwqOLzU5lpF
         DnY7UJoKDaBmQalrY39L2NxsbG81Lfp/cGG0AEiO5UEF2XDwD+RtB4PGLPKiSSWyOSOm
         +lQjjlV9IrB727Mbkx4/Xyk1IHjU7hL9iO0AonLCH6xOJ61sJYxVfl2SCpon/D61aeZU
         HZgi+2wc2JuM/3s+TFLjrbgiAmosMjhZSTQmlEEj9frVaEXnSBhIWnP1c7VyeyoXTzjT
         MDWA==
X-Gm-Message-State: AOJu0Yw6XqPNkj92GGN6+Wy3Ep4JwcEaLFtskEG+3ueICf8MgngITn/7
	qu3f4bwjNk6inD71kEs7ZA4BtP9U5WZi5p1bHNXKwqe4kodsjvn1Q0H1zVTX/io=
X-Gm-Gg: ASbGncvBpfLGCBcSOofmABm/RcDdgZKYLRDxoIbbNIG/XEAIXaWAfXTKFVvFeVWLxpH
	6IcNYphqW0f9eIDIFhqjhkBzfmRMjTYhiSgzOi4d983ea+xqZssfEAx6Gk++MauTsdshHK5eCpF
	qIWkFUY4kmICV4v+Ate0mVDx6TZfYssavh6iwaYxM2rW91y4RK21KzqJ1WdZlj+GtRG8GTcxs2V
	uim/gDdoN6w3no59+avfwymJzZhSZJyeRT0iqFp8erhE7LVfyyxCB1oB8qMpEQUqDBF22rA4xxu
	8L+cXKT4FDp+LdNnRx74SIw/UbKdOeYQzQ==
X-Google-Smtp-Source: AGHT+IGn+Z43gzovofPRnbDsVUZDkTV9ziD8KJ/TUJ4K8+MooouTpDTvQ1iYYQu7+dT45omyk9kEcQ==
X-Received: by 2002:a05:600c:1d14:b0:439:9ee2:5534 with SMTP id 5b1f17b1804b1-43ba66f9f05mr62707355e9.12.1740842331943;
        Sat, 01 Mar 2025 07:18:51 -0800 (PST)
Received: from localhost ([2a03:2880:31ff:6::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43b7a27aa69sm91478185e9.29.2025.03.01.07.18.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Mar 2025 07:18:51 -0800 (PST)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v3 3/3] selftests/bpf: Add tests for extending sleepable global subprogs
Date: Sat,  1 Mar 2025 07:18:46 -0800
Message-ID: <20250301151846.1552362-4-memxor@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250301151846.1552362-1-memxor@gmail.com>
References: <20250301151846.1552362-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=14160; h=from:subject; bh=qaoLNXP6CZG1utXmYVbNKhcwzeDlyzLGDt8XEsfefHc=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBnwyScV8xFVVD30RaeUhGF9qf4uXKN4iqRsFIjIXxU HWQNACqJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZ8MknAAKCRBM4MiGSL8Ryu2KEA CYd3sG+/K9JKPbfrV+RdmOwqsJl3pJvW6eD5dkZ0NY/0PwX65hp5A5HjGqUCMAPuxRccHFBGBd12Oq Lw+sTUvNsIjsj5G0ZAfRZYC0tKve8XveCyO00OP8FvDJC2TCIW4HVCu7qNXFwWnDeadJOJaTzPgych 62t8aBcSJqM/LS+rA/8b6h0viR23WaJg0smzuVWwd4xmNdq+TIIelMXk73eG0QBu1b58ESHJFLRoVK nqAYUepWrwM3tQTOOBALFiwr0Fr2IStL4MI+1zTIUMOlVb0IWgrNrirNm6O8gj0HNg7WQ56wm/Gt4b csxgSb9PPt06aSPA41NUVxsLmRkQwlPBZnYmuax5RERbpbqJEP4rUqyJLGtv5P+buPQIfWg+bYxdt4 M/6G59zFZpTHjBM4sc31Le8/N41NTY+JCh899FkL0sVI1sQQEGwXnZ4B2CZbmAS7b00ZfAlaiVdAk5 QWg6VoWmNucGdi855dAZDIh3u/Odsu/ywKZH1bRut6PaOAu5VjQxCw1yCxJY2IuAd08XbHXD99Tt9e 3Pko1rPkIa930IINUkwMslruAJefuzhwQBPZMsRFC6XRQxc9nT9DiZCSGQ3A2HO85fubTKvnpDkG3L 7Bml4FBDAr9WjL6l0ocOYtiIUTthkVRttNyz2Yf5pMr9UK/jA9DQJFud9dEQ==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

Add tests for freplace behavior with the combination of sleepable
and non-sleepable global subprogs. The changes_pkt_data selftest
did all the hardwork, so simply rename it and include new support
for more summarization tests for might_sleep bit.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 .../bpf/prog_tests/changes_pkt_data.c         | 107 -------------
 .../selftests/bpf/prog_tests/summarization.c  | 144 ++++++++++++++++++
 .../selftests/bpf/progs/changes_pkt_data.c    |  39 -----
 .../selftests/bpf/progs/summarization.c       |  78 ++++++++++
 ...ta_freplace.c => summarization_freplace.c} |  17 ++-
 5 files changed, 238 insertions(+), 147 deletions(-)
 delete mode 100644 tools/testing/selftests/bpf/prog_tests/changes_pkt_data.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/summarization.c
 delete mode 100644 tools/testing/selftests/bpf/progs/changes_pkt_data.c
 create mode 100644 tools/testing/selftests/bpf/progs/summarization.c
 rename tools/testing/selftests/bpf/progs/{changes_pkt_data_freplace.c => summarization_freplace.c} (57%)

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
index 000000000000..5dd6c120a838
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/summarization.c
@@ -0,0 +1,144 @@
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
+	/* The might_sleep extension doesn't work yet as sleepable calls are not
+	 * allowed, but preserve the check in case it's supported later and then
+	 * this particular combination can be enabled.
+	 */
+	if (!strcmp("might_sleep", replacement) && err) {
+		ASSERT_HAS_SUBSTR(log, "helper call might sleep in a non-sleepable prog", "error log");
+		ASSERT_EQ(err, -EINVAL, "err");
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
+			{ "main_might_sleep",			"main_might_sleep",	    true },
+			{ "main_does_not_sleep",		"main_does_not_sleep",	    false },
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
diff --git a/tools/testing/selftests/bpf/progs/changes_pkt_data.c b/tools/testing/selftests/bpf/progs/changes_pkt_data.c
deleted file mode 100644
index 43cada48b28a..000000000000
--- a/tools/testing/selftests/bpf/progs/changes_pkt_data.c
+++ /dev/null
@@ -1,39 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-
-#include <linux/bpf.h>
-#include <bpf/bpf_helpers.h>
-
-__noinline
-long changes_pkt_data(struct __sk_buff *sk)
-{
-	return bpf_skb_pull_data(sk, 0);
-}
-
-__noinline __weak
-long does_not_change_pkt_data(struct __sk_buff *sk)
-{
-	return 0;
-}
-
-SEC("?tc")
-int main_with_subprogs(struct __sk_buff *sk)
-{
-	changes_pkt_data(sk);
-	does_not_change_pkt_data(sk);
-	return 0;
-}
-
-SEC("?tc")
-int main_changes(struct __sk_buff *sk)
-{
-	bpf_skb_pull_data(sk, 0);
-	return 0;
-}
-
-SEC("?tc")
-int main_does_not_change(struct __sk_buff *sk)
-{
-	return 0;
-}
-
-char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/progs/summarization.c b/tools/testing/selftests/bpf/progs/summarization.c
new file mode 100644
index 000000000000..f89effe82c9e
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/summarization.c
@@ -0,0 +1,78 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <vmlinux.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
+
+__noinline
+long changes_pkt_data(struct __sk_buff *sk)
+{
+	return bpf_skb_pull_data(sk, 0);
+}
+
+__noinline __weak
+long does_not_change_pkt_data(struct __sk_buff *sk)
+{
+	return 0;
+}
+
+SEC("?tc")
+int main_changes_with_subprogs(struct __sk_buff *sk)
+{
+	changes_pkt_data(sk);
+	does_not_change_pkt_data(sk);
+	return 0;
+}
+
+SEC("?tc")
+int main_changes(struct __sk_buff *sk)
+{
+	bpf_skb_pull_data(sk, 0);
+	return 0;
+}
+
+SEC("?tc")
+int main_does_not_change(struct __sk_buff *sk)
+{
+	return 0;
+}
+
+__noinline
+long might_sleep(struct pt_regs *ctx __arg_ctx)
+{
+	int i;
+
+	bpf_copy_from_user(&i, sizeof(i), NULL);
+	return i;
+}
+
+__noinline __weak
+long does_not_sleep(struct pt_regs *ctx __arg_ctx)
+{
+	return 0;
+}
+
+SEC("?uprobe.s")
+int main_might_sleep_with_subprogs(struct pt_regs *ctx)
+{
+	might_sleep(ctx);
+	does_not_sleep(ctx);
+	return 0;
+}
+
+SEC("?uprobe.s")
+int main_might_sleep(struct pt_regs *ctx)
+{
+	int i;
+
+	bpf_copy_from_user(&i, sizeof(i), NULL);
+	return i;
+}
+
+SEC("?uprobe.s")
+int main_does_not_sleep(struct pt_regs *ctx)
+{
+	return 0;
+}
+
+char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/progs/changes_pkt_data_freplace.c b/tools/testing/selftests/bpf/progs/summarization_freplace.c
similarity index 57%
rename from tools/testing/selftests/bpf/progs/changes_pkt_data_freplace.c
rename to tools/testing/selftests/bpf/progs/summarization_freplace.c
index f9a622705f1b..935f00e0e9ea 100644
--- a/tools/testing/selftests/bpf/progs/changes_pkt_data_freplace.c
+++ b/tools/testing/selftests/bpf/progs/summarization_freplace.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 
-#include <linux/bpf.h>
+#include <vmlinux.h>
 #include <bpf/bpf_helpers.h>
 
 SEC("?freplace")
@@ -15,4 +15,19 @@ long does_not_change_pkt_data(struct __sk_buff *sk)
 	return 0;
 }
 
+SEC("?freplace")
+long might_sleep(struct pt_regs *ctx)
+{
+	int i;
+
+	bpf_copy_from_user(&i, sizeof(i), NULL);
+	return i;
+}
+
+SEC("?freplace")
+long does_not_sleep(struct pt_regs *ctx)
+{
+	return 0;
+}
+
 char _license[] SEC("license") = "GPL";
-- 
2.43.5


