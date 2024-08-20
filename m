Return-Path: <bpf+bounces-37620-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B505395845E
	for <lists+bpf@lfdr.de>; Tue, 20 Aug 2024 12:26:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D8F2B1C24D67
	for <lists+bpf@lfdr.de>; Tue, 20 Aug 2024 10:26:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB58B18FC6F;
	Tue, 20 Aug 2024 10:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TKYuLWnr"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7502F18DF6A
	for <bpf@vger.kernel.org>; Tue, 20 Aug 2024 10:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724149459; cv=none; b=F3y2zLJ8ZKRaSfgeGQTdsHGebyEBLoD2DpIyfFFGE5DRVBKSvFbgimIUXnrJ+kjkMMGqxg2ZenK2QdVsnI6O4XQhgfaJ+Wv3tspMGzNiV4I4zJ6Ha20We2liyzA/XKlu6peOlJDyHW/7sxoC8gYVPOVWi3pk9aAfpSGtlUnLJ40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724149459; c=relaxed/simple;
	bh=yl7NGAqy6seSPAqTOYSyg5/ksswDtqTU7hTfLXM+7z0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fzD2crQbVKrtFoX+ZIHnBVqbCwDOeRx5dZyxcAm8gVwH31NG2vQIKSRlugV4KBkf6bhhL16eAWfbi517fIi0HNSvi593e9S6t8RBtFitXvooZ0dRoLQrw8zmEamyDfgke6NefjHOk6Trp8RDPTSVU9moZ1BMlhSxhlOw6dyn5aA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TKYuLWnr; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-70d1c655141so3394503b3a.1
        for <bpf@vger.kernel.org>; Tue, 20 Aug 2024 03:24:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724149456; x=1724754256; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OTVbxIR/I2bJtJ0sOwaKg/sfadnkaNcta9pDs+5+wMU=;
        b=TKYuLWnrrDCQVm+Y8iE2RTPsJ9nENoepdrr8HxxBcEZLYnqLACPiZOaZQq1whHWF4U
         nD806/gccCD13qAbKv+ooCzrtJOvIeeSqGnwSYh8Lc6S++hc0M5bfvV8atq9g2iJDiZV
         qq7Anz71L4XOT6b7/OpD29bTaXv41on0pQmrImNXJARamZww6nQp/Lg+fFNX/GbJafw2
         NfsjBf6MgupxHVBJhAjZv6OJLHUWXl2T/QrM00eulCYmjC+wqn1qO4wsc7wsZFTr8EW9
         1X/zd2ZuEo6R0WRFv7L6//dRCOOfyWkb8lUda/NIG7hAhih8oz7WKPGbc6LrkTkDG52e
         Qp9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724149456; x=1724754256;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OTVbxIR/I2bJtJ0sOwaKg/sfadnkaNcta9pDs+5+wMU=;
        b=WJuQInNdMKgbT4OF8eNwHoMM8N+07db7pLsPqzMcXREKa0GWGpve7b4YywE/pf7UXG
         Y1oQRIzHcSc07dL6VQxp0oFLjHt1tcc5c7eThpF6jHSZ7CHDPe9Hycy19KKEWL5nEbCi
         0rVEzq8V25jZtz5fR5ge37es4SOLCzbcTn0eblCBBOfnDHuwnZceXsHLRWH6rLS7ZW8h
         uWjMPiUKcmuYOGJHmjo7cpAgJKQvn9WZGpsj4UftZWMZ3OsYk8SkhM8skIX1WQDmm6SG
         gPjLE/S/Su1oz2Kyipi3CUD1GXNNTihTfxgNTzYWAJhsxavjMes59ttdFDWZAgP9oTAu
         XplQ==
X-Gm-Message-State: AOJu0YwqKnM8s8BUHxrrO6cj961jgjd3Qr1yBXKxG5KXET2FFpaAohlV
	3a+n5MtEorHQloELhXwMIzL+3Kyoiuh++BtRoD8Bq+J7bv/LYkzI2yKLLLWs
X-Google-Smtp-Source: AGHT+IEsMRtf/4BW1lCZKEizOOoV1I5Unz93zU9J8Kidgq8SGGyeYfIVGT9bNo4TGuavJIjH3pKi4A==
X-Received: by 2002:a05:6a20:d490:b0:1c2:8dd5:71d9 with SMTP id adf61e73a8af0-1c904f6bab9mr12854933637.4.1724149455928;
        Tue, 20 Aug 2024 03:24:15 -0700 (PDT)
Received: from honey-badger.. ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d3e3174bfdsm8976166a91.27.2024.08.20.03.24.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2024 03:24:15 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	hffilwlqm@gmail.com,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v3 4/8] selftests/bpf: replace __regex macro with "{{...}}" patterns
Date: Tue, 20 Aug 2024 03:23:52 -0700
Message-ID: <20240820102357.3372779-5-eddyz87@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240820102357.3372779-1-eddyz87@gmail.com>
References: <20240820102357.3372779-1-eddyz87@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Upcoming changes require a notation to specify regular expression
matches for regular verifier log messages, disassembly of BPF
instructions, disassembly of jited instructions.

Neither basic nor extended POSIX regular expressions w/o additional
escaping are good for this role because of wide use of special
characters in disassembly, for example:

    movq -0x10(%rbp), %rax  ;; () are special characters
    cmpq $0x21, %rax        ;; $ is a special character

    *(u64 *)(r10 -16) = r1  ;; * and () are special characters

This commit borrows syntax from LLVM's FileCheck utility.
It replaces __regex macro with ability to embed regular expressions
in __msg patters using "{{" "}}" pairs for escaping.
Syntax for __msg patterns:

    pattern := (<verbatim text> | regex)*
    regex := "{{" <posix extended regular expression> "}}"

For example, pattern "foo{{[0-9]+}}" matches strings like
"foo0", "foo007", etc.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 tools/testing/selftests/bpf/progs/bpf_misc.h  |   9 +-
 .../testing/selftests/bpf/progs/dynptr_fail.c |   6 +-
 .../testing/selftests/bpf/progs/rbtree_fail.c |   2 +-
 .../bpf/progs/refcounted_kptr_fail.c          |   4 +-
 tools/testing/selftests/bpf/test_loader.c     | 164 +++++++++++-------
 5 files changed, 115 insertions(+), 70 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/bpf_misc.h b/tools/testing/selftests/bpf/progs/bpf_misc.h
index 4f1029743734..cc3ef20a6490 100644
--- a/tools/testing/selftests/bpf/progs/bpf_misc.h
+++ b/tools/testing/selftests/bpf/progs/bpf_misc.h
@@ -25,12 +25,15 @@
  *
  * __msg             Message expected to be found in the verifier log.
  *                   Multiple __msg attributes could be specified.
+ *                   To match a regular expression use "{{" "}}" brackets,
+ *                   e.g. "foo{{[0-9]+}}"  matches strings like "foo007".
+ *                   Extended POSIX regular expression syntax is allowed
+ *                   inside the brackets.
  * __msg_unpriv      Same as __msg but for unprivileged mode.
  *
- * __regex           Same as __msg, but using a regular expression.
- * __regex_unpriv    Same as __msg_unpriv but using a regular expression.
  * __xlated          Expect a line in a disassembly log after verifier applies rewrites.
  *                   Multiple __xlated attributes could be specified.
+ *                   Regular expressions could be specified same way as in __msg.
  * __xlated_unpriv   Same as __xlated but for unprivileged mode.
  *
  * __success         Expect program load success in privileged mode.
@@ -72,13 +75,11 @@
  *                   When test case is not run on current arch it is marked as skipped.
  */
 #define __msg(msg)		__attribute__((btf_decl_tag("comment:test_expect_msg=" XSTR(__COUNTER__) "=" msg)))
-#define __regex(regex)		__attribute__((btf_decl_tag("comment:test_expect_regex=" XSTR(__COUNTER__) "=" regex)))
 #define __xlated(msg)		__attribute__((btf_decl_tag("comment:test_expect_xlated=" XSTR(__COUNTER__) "=" msg)))
 #define __failure		__attribute__((btf_decl_tag("comment:test_expect_failure")))
 #define __success		__attribute__((btf_decl_tag("comment:test_expect_success")))
 #define __description(desc)	__attribute__((btf_decl_tag("comment:test_description=" desc)))
 #define __msg_unpriv(msg)	__attribute__((btf_decl_tag("comment:test_expect_msg_unpriv=" XSTR(__COUNTER__) "=" msg)))
-#define __regex_unpriv(regex)	__attribute__((btf_decl_tag("comment:test_expect_regex_unpriv=" XSTR(__COUNTER__) "=" regex)))
 #define __xlated_unpriv(msg)	__attribute__((btf_decl_tag("comment:test_expect_xlated_unpriv=" XSTR(__COUNTER__) "=" msg)))
 #define __failure_unpriv	__attribute__((btf_decl_tag("comment:test_expect_failure_unpriv")))
 #define __success_unpriv	__attribute__((btf_decl_tag("comment:test_expect_success_unpriv")))
diff --git a/tools/testing/selftests/bpf/progs/dynptr_fail.c b/tools/testing/selftests/bpf/progs/dynptr_fail.c
index e35bc1eac52a..68b8c6eca508 100644
--- a/tools/testing/selftests/bpf/progs/dynptr_fail.c
+++ b/tools/testing/selftests/bpf/progs/dynptr_fail.c
@@ -964,7 +964,7 @@ int dynptr_invalidate_slice_reinit(void *ctx)
  * mem_or_null pointers.
  */
 SEC("?raw_tp")
-__failure __regex("R[0-9]+ type=scalar expected=percpu_ptr_")
+__failure __msg("R{{[0-9]+}} type=scalar expected=percpu_ptr_")
 int dynptr_invalidate_slice_or_null(void *ctx)
 {
 	struct bpf_dynptr ptr;
@@ -982,7 +982,7 @@ int dynptr_invalidate_slice_or_null(void *ctx)
 
 /* Destruction of dynptr should also any slices obtained from it */
 SEC("?raw_tp")
-__failure __regex("R[0-9]+ invalid mem access 'scalar'")
+__failure __msg("R{{[0-9]+}} invalid mem access 'scalar'")
 int dynptr_invalidate_slice_failure(void *ctx)
 {
 	struct bpf_dynptr ptr1;
@@ -1069,7 +1069,7 @@ int dynptr_read_into_slot(void *ctx)
 
 /* bpf_dynptr_slice()s are read-only and cannot be written to */
 SEC("?tc")
-__failure __regex("R[0-9]+ cannot write into rdonly_mem")
+__failure __msg("R{{[0-9]+}} cannot write into rdonly_mem")
 int skb_invalid_slice_write(struct __sk_buff *skb)
 {
 	struct bpf_dynptr ptr;
diff --git a/tools/testing/selftests/bpf/progs/rbtree_fail.c b/tools/testing/selftests/bpf/progs/rbtree_fail.c
index b722a1e1ddef..dbd5eee8e25e 100644
--- a/tools/testing/selftests/bpf/progs/rbtree_fail.c
+++ b/tools/testing/selftests/bpf/progs/rbtree_fail.c
@@ -105,7 +105,7 @@ long rbtree_api_remove_unadded_node(void *ctx)
 }
 
 SEC("?tc")
-__failure __regex("Unreleased reference id=3 alloc_insn=[0-9]+")
+__failure __msg("Unreleased reference id=3 alloc_insn={{[0-9]+}}")
 long rbtree_api_remove_no_drop(void *ctx)
 {
 	struct bpf_rb_node *res;
diff --git a/tools/testing/selftests/bpf/progs/refcounted_kptr_fail.c b/tools/testing/selftests/bpf/progs/refcounted_kptr_fail.c
index f8d4b7cfcd68..836c8ab7b908 100644
--- a/tools/testing/selftests/bpf/progs/refcounted_kptr_fail.c
+++ b/tools/testing/selftests/bpf/progs/refcounted_kptr_fail.c
@@ -32,7 +32,7 @@ static bool less(struct bpf_rb_node *a, const struct bpf_rb_node *b)
 }
 
 SEC("?tc")
-__failure __regex("Unreleased reference id=4 alloc_insn=[0-9]+")
+__failure __msg("Unreleased reference id=4 alloc_insn={{[0-9]+}}")
 long rbtree_refcounted_node_ref_escapes(void *ctx)
 {
 	struct node_acquire *n, *m;
@@ -73,7 +73,7 @@ long refcount_acquire_maybe_null(void *ctx)
 }
 
 SEC("?tc")
-__failure __regex("Unreleased reference id=3 alloc_insn=[0-9]+")
+__failure __msg("Unreleased reference id=3 alloc_insn={{[0-9]+}}")
 long rbtree_refcounted_node_ref_escapes_owning_input(void *ctx)
 {
 	struct node_acquire *n, *m;
diff --git a/tools/testing/selftests/bpf/test_loader.c b/tools/testing/selftests/bpf/test_loader.c
index c604a82e03c4..b0d7158e00c1 100644
--- a/tools/testing/selftests/bpf/test_loader.c
+++ b/tools/testing/selftests/bpf/test_loader.c
@@ -19,12 +19,10 @@
 #define TEST_TAG_EXPECT_FAILURE "comment:test_expect_failure"
 #define TEST_TAG_EXPECT_SUCCESS "comment:test_expect_success"
 #define TEST_TAG_EXPECT_MSG_PFX "comment:test_expect_msg="
-#define TEST_TAG_EXPECT_REGEX_PFX "comment:test_expect_regex="
 #define TEST_TAG_EXPECT_XLATED_PFX "comment:test_expect_xlated="
 #define TEST_TAG_EXPECT_FAILURE_UNPRIV "comment:test_expect_failure_unpriv"
 #define TEST_TAG_EXPECT_SUCCESS_UNPRIV "comment:test_expect_success_unpriv"
 #define TEST_TAG_EXPECT_MSG_PFX_UNPRIV "comment:test_expect_msg_unpriv="
-#define TEST_TAG_EXPECT_REGEX_PFX_UNPRIV "comment:test_expect_regex_unpriv="
 #define TEST_TAG_EXPECT_XLATED_PFX_UNPRIV "comment:test_expect_xlated_unpriv="
 #define TEST_TAG_LOG_LEVEL_PFX "comment:test_log_level="
 #define TEST_TAG_PROG_FLAGS_PFX "comment:test_prog_flags="
@@ -55,8 +53,9 @@ enum mode {
 
 struct expect_msg {
 	const char *substr; /* substring match */
-	const char *regex_str; /* regex-based match */
 	regex_t regex;
+	bool is_regex;
+	bool on_next_line;
 };
 
 struct expected_msgs {
@@ -111,7 +110,7 @@ static void free_msgs(struct expected_msgs *msgs)
 	int i;
 
 	for (i = 0; i < msgs->cnt; i++)
-		if (msgs->patterns[i].regex_str)
+		if (msgs->patterns[i].is_regex)
 			regfree(&msgs->patterns[i].regex);
 	free(msgs->patterns);
 	msgs->patterns = NULL;
@@ -132,12 +131,71 @@ static void free_test_spec(struct test_spec *spec)
 	spec->unpriv.name = NULL;
 }
 
-static int push_msg(const char *substr, const char *regex_str, struct expected_msgs *msgs)
+/* Compiles regular expression matching pattern.
+ * Pattern has a special syntax:
+ *
+ *   pattern := (<verbatim text> | regex)*
+ *   regex := "{{" <posix extended regular expression> "}}"
+ *
+ * In other words, pattern is a verbatim text with inclusion
+ * of regular expressions enclosed in "{{" "}}" pairs.
+ * For example, pattern "foo{{[0-9]+}}" matches strings like
+ * "foo0", "foo007", etc.
+ */
+static int compile_regex(const char *pattern, regex_t *regex)
+{
+	char err_buf[256], buf[256] = {}, *ptr, *buf_end;
+	const char *original_pattern = pattern;
+	bool in_regex = false;
+	int err;
+
+	buf_end = buf + sizeof(buf);
+	ptr = buf;
+	while (*pattern && ptr < buf_end - 2) {
+		if (!in_regex && str_has_pfx(pattern, "{{")) {
+			in_regex = true;
+			pattern += 2;
+			continue;
+		}
+		if (in_regex && str_has_pfx(pattern, "}}")) {
+			in_regex = false;
+			pattern += 2;
+			continue;
+		}
+		if (in_regex) {
+			*ptr++ = *pattern++;
+			continue;
+		}
+		/* list of characters that need escaping for extended posix regex */
+		if (strchr(".[]\\()*+?{}|^$", *pattern)) {
+			*ptr++ = '\\';
+			*ptr++ = *pattern++;
+			continue;
+		}
+		*ptr++ = *pattern++;
+	}
+	if (*pattern) {
+		PRINT_FAIL("Regexp too long: '%s'\n", original_pattern);
+		return -EINVAL;
+	}
+	if (in_regex) {
+		PRINT_FAIL("Regexp has open '{{' but no closing '}}': '%s'\n", original_pattern);
+		return -EINVAL;
+	}
+	err = regcomp(regex, buf, REG_EXTENDED | REG_NEWLINE);
+	if (err != 0) {
+		regerror(err, regex, err_buf, sizeof(err_buf));
+		PRINT_FAIL("Regexp compilation error in '%s': '%s'\n", buf, err_buf);
+		return -EINVAL;
+	}
+	return 0;
+}
+
+static int __push_msg(const char *pattern, bool on_next_line, struct expected_msgs *msgs)
 {
-	void *tmp;
-	int regcomp_res;
-	char error_msg[100];
 	struct expect_msg *msg;
+	void *tmp;
+	int err;
 
 	tmp = realloc(msgs->patterns,
 		      (1 + msgs->cnt) * sizeof(struct expect_msg));
@@ -147,26 +205,38 @@ static int push_msg(const char *substr, const char *regex_str, struct expected_m
 	}
 	msgs->patterns = tmp;
 	msg = &msgs->patterns[msgs->cnt];
-
-	if (substr) {
-		msg->substr = substr;
-		msg->regex_str = NULL;
-	} else {
-		msg->regex_str = regex_str;
-		msg->substr = NULL;
-		regcomp_res = regcomp(&msg->regex, regex_str, REG_EXTENDED|REG_NEWLINE);
-		if (regcomp_res != 0) {
-			regerror(regcomp_res, &msg->regex, error_msg, sizeof(error_msg));
-			PRINT_FAIL("Regexp compilation error in '%s': '%s'\n",
-				   regex_str, error_msg);
-			return -EINVAL;
-		}
+	msg->on_next_line = on_next_line;
+	msg->substr = pattern;
+	msg->is_regex = false;
+	if (strstr(pattern, "{{")) {
+		err = compile_regex(pattern, &msg->regex);
+		if (err)
+			return err;
+		msg->is_regex = true;
 	}
-
 	msgs->cnt += 1;
 	return 0;
 }
 
+static int clone_msgs(struct expected_msgs *from, struct expected_msgs *to)
+{
+	struct expect_msg *msg;
+	int i, err;
+
+	for (i = 0; i < from->cnt; i++) {
+		msg = &from->patterns[i];
+		err = __push_msg(msg->substr, msg->on_next_line, to);
+		if (err)
+			return err;
+	}
+	return 0;
+}
+
+static int push_msg(const char *substr, struct expected_msgs *msgs)
+{
+	return __push_msg(substr, false, msgs);
+}
+
 static int parse_int(const char *str, int *val, const char *name)
 {
 	char *end;
@@ -320,32 +390,22 @@ static int parse_test_spec(struct test_loader *tester,
 			spec->auxiliary = true;
 			spec->mode_mask |= UNPRIV;
 		} else if ((msg = skip_dynamic_pfx(s, TEST_TAG_EXPECT_MSG_PFX))) {
-			err = push_msg(msg, NULL, &spec->priv.expect_msgs);
+			err = push_msg(msg, &spec->priv.expect_msgs);
 			if (err)
 				goto cleanup;
 			spec->mode_mask |= PRIV;
 		} else if ((msg = skip_dynamic_pfx(s, TEST_TAG_EXPECT_MSG_PFX_UNPRIV))) {
-			err = push_msg(msg, NULL, &spec->unpriv.expect_msgs);
-			if (err)
-				goto cleanup;
-			spec->mode_mask |= UNPRIV;
-		} else if ((msg = skip_dynamic_pfx(s, TEST_TAG_EXPECT_REGEX_PFX))) {
-			err = push_msg(NULL, msg, &spec->priv.expect_msgs);
-			if (err)
-				goto cleanup;
-			spec->mode_mask |= PRIV;
-		} else if ((msg = skip_dynamic_pfx(s, TEST_TAG_EXPECT_REGEX_PFX_UNPRIV))) {
-			err = push_msg(NULL, msg, &spec->unpriv.expect_msgs);
+			err = push_msg(msg, &spec->unpriv.expect_msgs);
 			if (err)
 				goto cleanup;
 			spec->mode_mask |= UNPRIV;
 		} else if ((msg = skip_dynamic_pfx(s, TEST_TAG_EXPECT_XLATED_PFX))) {
-			err = push_msg(msg, NULL, &spec->priv.expect_xlated);
+			err = push_msg(msg, &spec->priv.expect_xlated);
 			if (err)
 				goto cleanup;
 			spec->mode_mask |= PRIV;
 		} else if ((msg = skip_dynamic_pfx(s, TEST_TAG_EXPECT_XLATED_PFX_UNPRIV))) {
-			err = push_msg(msg, NULL, &spec->unpriv.expect_xlated);
+			err = push_msg(msg, &spec->unpriv.expect_xlated);
 			if (err)
 				goto cleanup;
 			spec->mode_mask |= UNPRIV;
@@ -457,26 +517,10 @@ static int parse_test_spec(struct test_loader *tester,
 			spec->unpriv.execute = spec->priv.execute;
 		}
 
-		if (spec->unpriv.expect_msgs.cnt == 0) {
-			for (i = 0; i < spec->priv.expect_msgs.cnt; i++) {
-				struct expect_msg *msg = &spec->priv.expect_msgs.patterns[i];
-
-				err = push_msg(msg->substr, msg->regex_str,
-					       &spec->unpriv.expect_msgs);
-				if (err)
-					goto cleanup;
-			}
-		}
-		if (spec->unpriv.expect_xlated.cnt == 0) {
-			for (i = 0; i < spec->priv.expect_xlated.cnt; i++) {
-				struct expect_msg *msg = &spec->priv.expect_xlated.patterns[i];
-
-				err = push_msg(msg->substr, msg->regex_str,
-					       &spec->unpriv.expect_xlated);
-				if (err)
-					goto cleanup;
-			}
-		}
+		if (spec->unpriv.expect_msgs.cnt == 0)
+			clone_msgs(&spec->priv.expect_msgs, &spec->unpriv.expect_msgs);
+		if (spec->unpriv.expect_xlated.cnt == 0)
+			clone_msgs(&spec->priv.expect_xlated, &spec->unpriv.expect_xlated);
 	}
 
 	spec->valid = true;
@@ -542,7 +586,7 @@ static void validate_msgs(char *log_buf, struct expected_msgs *msgs,
 		struct expect_msg *msg = &msgs->patterns[i];
 		const char *match = NULL;
 
-		if (msg->substr) {
+		if (!msg->is_regex) {
 			match = strstr(log, msg->substr);
 			if (match)
 				log = match + strlen(msg->substr);
@@ -562,8 +606,8 @@ static void validate_msgs(char *log_buf, struct expected_msgs *msgs,
 				msg = &msgs->patterns[j];
 				fprintf(stderr, "%s %s: '%s'\n",
 					j < i ? "MATCHED " : "EXPECTED",
-					msg->substr ? "SUBSTR" : " REGEX",
-					msg->substr ?: msg->regex_str);
+					msg->is_regex ? " REGEX" : "SUBSTR",
+					msg->substr);
 			}
 			return;
 		}
-- 
2.45.2


