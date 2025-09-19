Return-Path: <bpf+bounces-68896-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7769B87B68
	for <lists+bpf@lfdr.de>; Fri, 19 Sep 2025 04:20:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E1E72A86C5
	for <lists+bpf@lfdr.de>; Fri, 19 Sep 2025 02:20:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD287274B2A;
	Fri, 19 Sep 2025 02:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JINZQNjL"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44BCE25CC40
	for <bpf@vger.kernel.org>; Fri, 19 Sep 2025 02:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758248353; cv=none; b=jcy5aNsqCjSiNqDXno4HIzW2/1GlEx2yRX+VT1znBwsPJpU4NoOZecoDxgFSwF26uMj/9lmuU3eGVDFCU8XphL5nWEN94VfF+/ISFZRkV+/krwmY7pNhuTd7tN4T4Tx0pUbh2ULXTCk1xl9aoyc5Ok/dHF6+538N1U2fdDMu+FY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758248353; c=relaxed/simple;
	bh=IuQDwpRG/HeqS1XPefjBst803iva7VzzGUolWR3RMs8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LRiYCob5jpk2q598dvEQq/2vb9p5mSov+9VewinEQzqKD+O2XKvgjn+JStt13FylfogbFNj2nBEiTv69LWe15r/Dl1+/nudAT+r+8KmkFTYwUyVNAx6uZI8vf/BZACmfeWkVGhhaVGiUlk4SO7qK69jx9y04mvs8przcwCkQ4o4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JINZQNjL; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-266fa7a0552so16298805ad.3
        for <bpf@vger.kernel.org>; Thu, 18 Sep 2025 19:19:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758248350; x=1758853150; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JlcqBH2IMMJBetprpOy8S2wl8fsfCYxmkhjI8ml1Ra8=;
        b=JINZQNjL5fbSFT1qXRi5Xr4fRcQp9asLMQl8Gcph8A7xCzFIuSsCOqIjFsJnF/Fd45
         ChFJFYcdaDr8vgTpkpPqu4/feYlJ4UH22B+/5IO4VBdF3HUUisP1xT5qe4oSXT9Nrdy6
         /6Ri5TVNndMbAFFKBksvMnhaAXTWDYz50NBUm3sQsM41g+bckbnF3G7nnq0U7Q9GNCaU
         OPDmbcPkhvqZMayhBdCL9fQKE6/BG5ypdZxm99RQpZsG2EXJmeXnPl21vUxRV/EtLrug
         S/gR+x2vmGisL5R/5bhu164hwYN3IKMheFI/8dSlBRKpAkAABsThbiscRsY+bomzPZd6
         lQAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758248350; x=1758853150;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JlcqBH2IMMJBetprpOy8S2wl8fsfCYxmkhjI8ml1Ra8=;
        b=Bwb0/KumtV0kJncQpst+LFFN1cM4aCytkCSnz7l2+sF3tqV6oxAc6qmOw1FjThWqYm
         zSRYzEDGNTO9RU1kr+mtbbuZ0eoh8dw5hA5iHFXmZP1sOu2fnuwZwu8tFGA6lL4ll49c
         90+DvLmAvZJfjphOOCEkkbUG0Tw6rEkseOeFkMxfKNnL3/9CFbyoRivRCiLbhtE53IM4
         OrvxNxsnBTG/SK0apqslSbxCnrCecPo/BjZPoxVhM21FCo1teD/TITItB8gj+/GF+xtZ
         1RZ42rq2i57ppg9WXemYWq96f4IlDEN62Dwh3D2VtXf8Mm1FiVLTzuZZbHB6lQXDcewf
         rrjw==
X-Gm-Message-State: AOJu0Ywn5be1huTnIrursbTstLAf8mSN9cOQiWm3dL2ooYns5hrRQFcT
	642edk+UbyGOgDdEoJqw44Y1NDJKJMIrwSTLTIaSV9S7ziJRuL3Z1nB5G+iWMQ==
X-Gm-Gg: ASbGnctlkwKsFeXpyQ2cSenffJP5CWOyPz5qXphMch93ezR25BQydPfoAo69GwRs8L0
	01isDJ6wFDVhlVC5NdhPa4k2PoQepAgF3crwQR3hYJLNYS+pd9Avpv8uJ68+AaLnpYU+tySSLb6
	N/wImXxQA251A+Su393BaPrLC7+77yxYAYfCNL/9SXFyJB+BS5bAMjC2G23zO2q59FARIzY2BxG
	RwzjSzl548HrLD9sSzo71EnuTu1gG6uuxSgzsgcFHGfaKaZQ8Df1BKQquVvX8a8CLu1zQOF1jxI
	mg56Wd7Wbn4NhO82sUFozDtHDeat7ktpK79zHoiu8PKP+AwQMzZpq0wEjzBPQzJoTqEuNmlJ6vU
	vLErXlgKDl8VwZx9E
X-Google-Smtp-Source: AGHT+IEfZUW6nxF0gfqB9G6sri0azaktqyypAtf4anQMhIvGCXH0A34qT9tOipkT13BkbhwETlFq3Q==
X-Received: by 2002:a17:903:1ab0:b0:24c:e6fa:2a38 with SMTP id d9443c01a7336-269ba462381mr21942195ad.25.1758248350334;
        Thu, 18 Sep 2025 19:19:10 -0700 (PDT)
Received: from honey-badger ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2698033a3e5sm39186235ad.126.2025.09.18.19.19.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 19:19:10 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v3 11/12] selftests/bpf: __not_msg() tag for test_loader framework
Date: Thu, 18 Sep 2025 19:18:44 -0700
Message-ID: <20250918-callchain-sensitive-liveness-v3-11-c3cd27bacc60@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250918-callchain-sensitive-liveness-v3-0-c3cd27bacc60@gmail.com>
References: <20250918-callchain-sensitive-liveness-v3-0-c3cd27bacc60@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

This patch adds tags __not_msg(<msg>) and __not_msg_unpriv(<msg>).
Test fails if <msg> is found in verifier log.

If __msg_not() is situated between __msg() tags framework matches
__msg() tags first, and then checks that <msg> is not present in a
portion of a log between bracketing __msg() tags.
__msg_not() tags bracketed by a same __msg() group are effectively
unordered.

The idea is borrowed from LLVM's CheckFile with its CHECK-NOT syntax.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 .../bpf/prog_tests/prog_tests_framework.c          | 125 +++++++++++++
 tools/testing/selftests/bpf/progs/bpf_misc.h       |   9 +
 tools/testing/selftests/bpf/test_loader.c          | 201 ++++++++++++++++-----
 tools/testing/selftests/bpf/test_progs.h           |  17 ++
 4 files changed, 302 insertions(+), 50 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/prog_tests_framework.c b/tools/testing/selftests/bpf/prog_tests/prog_tests_framework.c
index 14f2796076e0c2bd056138ee1433a937305b1708..7607cfc2408c2d49a051fd195666a653afb6c6f0 100644
--- a/tools/testing/selftests/bpf/prog_tests/prog_tests_framework.c
+++ b/tools/testing/selftests/bpf/prog_tests/prog_tests_framework.c
@@ -54,3 +54,128 @@ void test_prog_tests_framework(void)
 		return;
 	clear_test_state(state);
 }
+
+static void dummy_emit(const char *buf, bool force) {}
+
+void test_prog_tests_framework_expected_msgs(void)
+{
+	struct expected_msgs msgs;
+	int i, j, error_cnt;
+	const struct {
+		const char *name;
+		const char *log;
+		const char *expected;
+		struct expect_msg *pats;
+	} cases[] = {
+		{
+			.name = "simple-ok",
+			.log = "aaabbbccc",
+			.pats = (struct expect_msg[]) {
+				{ .substr = "aaa" },
+				{ .substr = "ccc" },
+				{}
+			}
+		},
+		{
+			.name = "simple-fail",
+			.log = "aaabbbddd",
+			.expected = "MATCHED    SUBSTR: 'aaa'\n"
+				    "EXPECTED   SUBSTR: 'ccc'\n",
+			.pats = (struct expect_msg[]) {
+				{ .substr = "aaa" },
+				{ .substr = "ccc" },
+				{}
+			}
+		},
+		{
+			.name = "negative-ok-mid",
+			.log = "aaabbbccc",
+			.pats = (struct expect_msg[]) {
+				{ .substr = "aaa" },
+				{ .substr = "foo", .negative = true },
+				{ .substr = "bar", .negative = true },
+				{ .substr = "ccc" },
+				{}
+			}
+		},
+		{
+			.name = "negative-ok-tail",
+			.log = "aaabbbccc",
+			.pats = (struct expect_msg[]) {
+				{ .substr = "aaa" },
+				{ .substr = "foo", .negative = true },
+				{}
+			}
+		},
+		{
+			.name = "negative-ok-head",
+			.log = "aaabbbccc",
+			.pats = (struct expect_msg[]) {
+				{ .substr = "foo", .negative = true },
+				{ .substr = "ccc" },
+				{}
+			}
+		},
+		{
+			.name = "negative-fail-head",
+			.log = "aaabbbccc",
+			.expected = "UNEXPECTED SUBSTR: 'aaa'\n",
+			.pats = (struct expect_msg[]) {
+				{ .substr = "aaa", .negative = true },
+				{ .substr = "bbb" },
+				{}
+			}
+		},
+		{
+			.name = "negative-fail-tail",
+			.log = "aaabbbccc",
+			.expected = "UNEXPECTED SUBSTR: 'ccc'\n",
+			.pats = (struct expect_msg[]) {
+				{ .substr = "bbb" },
+				{ .substr = "ccc", .negative = true },
+				{}
+			}
+		},
+		{
+			.name = "negative-fail-mid-1",
+			.log = "aaabbbccc",
+			.expected = "UNEXPECTED SUBSTR: 'bbb'\n",
+			.pats = (struct expect_msg[]) {
+				{ .substr = "aaa" },
+				{ .substr = "bbb", .negative = true },
+				{ .substr = "ccc" },
+				{}
+			}
+		},
+		{
+			.name = "negative-fail-mid-2",
+			.log = "aaabbb222ccc",
+			.expected = "UNEXPECTED SUBSTR: '222'\n",
+			.pats = (struct expect_msg[]) {
+				{ .substr = "aaa" },
+				{ .substr = "222", .negative = true },
+				{ .substr = "bbb", .negative = true },
+				{ .substr = "ccc" },
+				{}
+			}
+		}
+	};
+
+	for (i = 0; i < ARRAY_SIZE(cases); i++) {
+		if (test__start_subtest(cases[i].name)) {
+			error_cnt = env.subtest_state->error_cnt;
+			msgs.patterns = cases[i].pats;
+			msgs.cnt = 0;
+			for (j = 0; cases[i].pats[j].substr; j++)
+				msgs.cnt++;
+			validate_msgs(cases[i].log, &msgs, dummy_emit);
+			fflush(stderr);
+			env.subtest_state->error_cnt = error_cnt;
+			if (cases[i].expected)
+				ASSERT_HAS_SUBSTR(env.subtest_state->log_buf, cases[i].expected, "expected output");
+			else
+				ASSERT_STREQ(env.subtest_state->log_buf, "", "expected no output");
+			test__end_subtest();
+		}
+	}
+}
diff --git a/tools/testing/selftests/bpf/progs/bpf_misc.h b/tools/testing/selftests/bpf/progs/bpf_misc.h
index 1004c4a64aafb9c6d886e25b110139eba688f5f4..a7a1a684eed116e304028b3ff0f32c3de4900dcf 100644
--- a/tools/testing/selftests/bpf/progs/bpf_misc.h
+++ b/tools/testing/selftests/bpf/progs/bpf_misc.h
@@ -33,7 +33,14 @@
  *                   e.g. "foo{{[0-9]+}}"  matches strings like "foo007".
  *                   Extended POSIX regular expression syntax is allowed
  *                   inside the brackets.
+ * __not_msg         Message not expected to be found in verifier log.
+ *                   If __msg_not is situated between __msg tags
+ *                   framework matches __msg tags first, and then
+ *                   checks that __msg_not is not present in a portion of
+ *                   a log between bracketing __msg tags.
+ *                   Same regex syntax as for __msg is supported.
  * __msg_unpriv      Same as __msg but for unprivileged mode.
+ * __not_msg_unpriv  Same as __not_msg but for unprivileged mode.
  *
  * __stderr          Message expected to be found in bpf stderr stream. The
  *                   same regex rules apply like __msg.
@@ -121,12 +128,14 @@
  * __caps_unpriv     Specify the capabilities that should be set when running the test.
  */
 #define __msg(msg)		__attribute__((btf_decl_tag("comment:test_expect_msg=" XSTR(__COUNTER__) "=" msg)))
+#define __not_msg(msg)		__attribute__((btf_decl_tag("comment:test_expect_not_msg=" XSTR(__COUNTER__) "=" msg)))
 #define __xlated(msg)		__attribute__((btf_decl_tag("comment:test_expect_xlated=" XSTR(__COUNTER__) "=" msg)))
 #define __jited(msg)		__attribute__((btf_decl_tag("comment:test_jited=" XSTR(__COUNTER__) "=" msg)))
 #define __failure		__attribute__((btf_decl_tag("comment:test_expect_failure")))
 #define __success		__attribute__((btf_decl_tag("comment:test_expect_success")))
 #define __description(desc)	__attribute__((btf_decl_tag("comment:test_description=" desc)))
 #define __msg_unpriv(msg)	__attribute__((btf_decl_tag("comment:test_expect_msg_unpriv=" XSTR(__COUNTER__) "=" msg)))
+#define __not_msg_unpriv(msg)	__attribute__((btf_decl_tag("comment:test_expect_not_msg_unpriv=" XSTR(__COUNTER__) "=" msg)))
 #define __xlated_unpriv(msg)	__attribute__((btf_decl_tag("comment:test_expect_xlated_unpriv=" XSTR(__COUNTER__) "=" msg)))
 #define __jited_unpriv(msg)	__attribute__((btf_decl_tag("comment:test_jited=" XSTR(__COUNTER__) "=" msg)))
 #define __failure_unpriv	__attribute__((btf_decl_tag("comment:test_expect_failure_unpriv")))
diff --git a/tools/testing/selftests/bpf/test_loader.c b/tools/testing/selftests/bpf/test_loader.c
index e065b467d5090e89c22c5e7a6dba0138a8ebecaf..74ecc281bb8c12435318a06919f4cf6192faa4cd 100644
--- a/tools/testing/selftests/bpf/test_loader.c
+++ b/tools/testing/selftests/bpf/test_loader.c
@@ -2,7 +2,6 @@
 /* Copyright (c) 2022 Meta Platforms, Inc. and affiliates. */
 #include <linux/capability.h>
 #include <stdlib.h>
-#include <regex.h>
 #include <test_progs.h>
 #include <bpf/btf.h>
 
@@ -20,10 +19,12 @@
 #define TEST_TAG_EXPECT_FAILURE "comment:test_expect_failure"
 #define TEST_TAG_EXPECT_SUCCESS "comment:test_expect_success"
 #define TEST_TAG_EXPECT_MSG_PFX "comment:test_expect_msg="
+#define TEST_TAG_EXPECT_NOT_MSG_PFX "comment:test_expect_not_msg="
 #define TEST_TAG_EXPECT_XLATED_PFX "comment:test_expect_xlated="
 #define TEST_TAG_EXPECT_FAILURE_UNPRIV "comment:test_expect_failure_unpriv"
 #define TEST_TAG_EXPECT_SUCCESS_UNPRIV "comment:test_expect_success_unpriv"
 #define TEST_TAG_EXPECT_MSG_PFX_UNPRIV "comment:test_expect_msg_unpriv="
+#define TEST_TAG_EXPECT_NOT_MSG_PFX_UNPRIV "comment:test_expect_not_msg_unpriv="
 #define TEST_TAG_EXPECT_XLATED_PFX_UNPRIV "comment:test_expect_xlated_unpriv="
 #define TEST_TAG_LOG_LEVEL_PFX "comment:test_log_level="
 #define TEST_TAG_PROG_FLAGS_PFX "comment:test_prog_flags="
@@ -65,18 +66,6 @@ enum load_mode {
 	NO_JITED	= 1 << 1,
 };
 
-struct expect_msg {
-	const char *substr; /* substring match */
-	regex_t regex;
-	bool is_regex;
-	bool on_next_line;
-};
-
-struct expected_msgs {
-	struct expect_msg *patterns;
-	size_t cnt;
-};
-
 struct test_subspec {
 	char *name;
 	bool expect_failure;
@@ -216,7 +205,8 @@ static int compile_regex(const char *pattern, regex_t *regex)
 	return 0;
 }
 
-static int __push_msg(const char *pattern, bool on_next_line, struct expected_msgs *msgs)
+static int __push_msg(const char *pattern, bool on_next_line, bool negative,
+		      struct expected_msgs *msgs)
 {
 	struct expect_msg *msg;
 	void *tmp;
@@ -232,6 +222,7 @@ static int __push_msg(const char *pattern, bool on_next_line, struct expected_ms
 	msg = &msgs->patterns[msgs->cnt];
 	msg->on_next_line = on_next_line;
 	msg->substr = pattern;
+	msg->negative = negative;
 	msg->is_regex = false;
 	if (strstr(pattern, "{{")) {
 		err = compile_regex(pattern, &msg->regex);
@@ -250,16 +241,16 @@ static int clone_msgs(struct expected_msgs *from, struct expected_msgs *to)
 
 	for (i = 0; i < from->cnt; i++) {
 		msg = &from->patterns[i];
-		err = __push_msg(msg->substr, msg->on_next_line, to);
+		err = __push_msg(msg->substr, msg->on_next_line, msg->negative, to);
 		if (err)
 			return err;
 	}
 	return 0;
 }
 
-static int push_msg(const char *substr, struct expected_msgs *msgs)
+static int push_msg(const char *substr, bool negative, struct expected_msgs *msgs)
 {
-	return __push_msg(substr, false, msgs);
+	return __push_msg(substr, false, negative, msgs);
 }
 
 static int push_disasm_msg(const char *regex_str, bool *on_next_line, struct expected_msgs *msgs)
@@ -270,7 +261,7 @@ static int push_disasm_msg(const char *regex_str, bool *on_next_line, struct exp
 		*on_next_line = false;
 		return 0;
 	}
-	err = __push_msg(regex_str, *on_next_line, msgs);
+	err = __push_msg(regex_str, *on_next_line, false, msgs);
 	if (err)
 		return err;
 	*on_next_line = true;
@@ -482,12 +473,22 @@ static int parse_test_spec(struct test_loader *tester,
 			spec->auxiliary = true;
 			spec->mode_mask |= UNPRIV;
 		} else if ((msg = skip_dynamic_pfx(s, TEST_TAG_EXPECT_MSG_PFX))) {
-			err = push_msg(msg, &spec->priv.expect_msgs);
+			err = push_msg(msg, false, &spec->priv.expect_msgs);
+			if (err)
+				goto cleanup;
+			spec->mode_mask |= PRIV;
+		} else if ((msg = skip_dynamic_pfx(s, TEST_TAG_EXPECT_NOT_MSG_PFX))) {
+			err = push_msg(msg, true, &spec->priv.expect_msgs);
 			if (err)
 				goto cleanup;
 			spec->mode_mask |= PRIV;
 		} else if ((msg = skip_dynamic_pfx(s, TEST_TAG_EXPECT_MSG_PFX_UNPRIV))) {
-			err = push_msg(msg, &spec->unpriv.expect_msgs);
+			err = push_msg(msg, false, &spec->unpriv.expect_msgs);
+			if (err)
+				goto cleanup;
+			spec->mode_mask |= UNPRIV;
+		} else if ((msg = skip_dynamic_pfx(s, TEST_TAG_EXPECT_NOT_MSG_PFX_UNPRIV))) {
+			err = push_msg(msg, true, &spec->unpriv.expect_msgs);
 			if (err)
 				goto cleanup;
 			spec->mode_mask |= UNPRIV;
@@ -764,44 +765,141 @@ static void emit_stdout(const char *bpf_stdout, bool force)
 	fprintf(stdout, "STDOUT:\n=============\n%s=============\n", bpf_stdout);
 }
 
-static void validate_msgs(char *log_buf, struct expected_msgs *msgs,
-			  void (*emit_fn)(const char *buf, bool force))
+static const char *match_msg(struct expect_msg *msg, const char **log)
 {
-	const char *log = log_buf, *prev_match;
+	const char *match = NULL;
 	regmatch_t reg_match[1];
-	int prev_match_line;
-	int match_line;
-	int i, j, err;
+	int err;
+
+	if (!msg->is_regex) {
+		match = strstr(*log, msg->substr);
+		if (match)
+			*log = match + strlen(msg->substr);
+	} else {
+		err = regexec(&msg->regex, *log, 1, reg_match, 0);
+		if (err == 0) {
+			match = *log + reg_match[0].rm_so;
+			*log += reg_match[0].rm_eo;
+		}
+	}
+	return match;
+}
+
+static int count_lines(const char *start, const char *end)
+{
+	const char *tmp;
+	int n = 0;
+
+	for (tmp = start; tmp < end; ++tmp)
+		if (*tmp == '\n')
+			n++;
+	return n;
+}
+
+struct match {
+	const char *start;
+	const char *end;
+	int line;
+};
+
+/*
+ * Positive messages are matched sequentially, each next message
+ * is looked for starting from the end of a previous matched one.
+ */
+static void match_positive_msgs(const char *log, struct expected_msgs *msgs, struct match *matches)
+{
+	const char *prev_match;
+	int i, line;
 
-	prev_match_line = -1;
-	match_line = 0;
 	prev_match = log;
+	line = 0;
+	for (i = 0; i < msgs->cnt; i++) {
+		struct expect_msg *msg = &msgs->patterns[i];
+		const char *match = NULL;
+
+		if (msg->negative)
+			continue;
+
+		match = match_msg(msg, &log);
+		if (match) {
+			line += count_lines(prev_match, match);
+			matches[i].start = match;
+			matches[i].end   = log;
+			matches[i].line  = line;
+			prev_match = match;
+		}
+	}
+}
+
+/*
+ * Each negative messages N located between positive messages P1 and P2
+ * is matched in the span P1.end .. P2.start. Consequently, negative messages
+ * are unordered within the span.
+ */
+static void match_negative_msgs(const char *log, struct expected_msgs *msgs, struct match *matches)
+{
+	const char *start = log, *end, *next, *match;
+	const char *log_end = log + strlen(log);
+	int i, j, next_positive;
+
 	for (i = 0; i < msgs->cnt; i++) {
 		struct expect_msg *msg = &msgs->patterns[i];
-		const char *match = NULL, *pat_status;
-		bool wrong_line = false;
-
-		if (!msg->is_regex) {
-			match = strstr(log, msg->substr);
-			if (match)
-				log = match + strlen(msg->substr);
-		} else {
-			err = regexec(&msg->regex, log, 1, reg_match, 0);
-			if (err == 0) {
-				match = log + reg_match[0].rm_so;
-				log += reg_match[0].rm_eo;
+
+		/* positive message bumps span start */
+		if (!msg->negative) {
+			start = matches[i].end ?: start;
+			continue;
+		}
+
+		/* count stride of negative patterns and adjust span end */
+		end = log_end;
+		for (next_positive = i + 1; next_positive < msgs->cnt; next_positive++) {
+			if (!msgs->patterns[next_positive].negative) {
+				end = matches[next_positive].start;
+				break;
 			}
 		}
 
-		if (match) {
-			for (; prev_match < match; ++prev_match)
-				if (*prev_match == '\n')
-					++match_line;
-			wrong_line = msg->on_next_line && prev_match_line >= 0 &&
-				     prev_match_line + 1 != match_line;
+		/* try matching negative messages within identified span */
+		for (j = i; j < next_positive; j++) {
+			next = start;
+			match = match_msg(msg, &next);
+			if (match && next <= end) {
+				matches[j].start = match;
+				matches[j].end = next;
+			}
 		}
 
-		if (!match || wrong_line) {
+		/* -1 to account for i++ */
+		i = next_positive - 1;
+	}
+}
+
+void validate_msgs(const char *log_buf, struct expected_msgs *msgs,
+		   void (*emit_fn)(const char *buf, bool force))
+{
+	struct match matches[msgs->cnt];
+	struct match *prev_match = NULL;
+	int i, j;
+
+	memset(matches, 0, sizeof(*matches) * msgs->cnt);
+	match_positive_msgs(log_buf, msgs, matches);
+	match_negative_msgs(log_buf, msgs, matches);
+
+	for (i = 0; i < msgs->cnt; i++) {
+		struct expect_msg *msg = &msgs->patterns[i];
+		struct match *match = &matches[i];
+		const char *pat_status;
+		bool unexpected;
+		bool wrong_line;
+		bool no_match;
+
+		no_match   = !msg->negative && !match->start;
+		wrong_line = !msg->negative &&
+			     msg->on_next_line &&
+			     prev_match && prev_match->line + 1 != match->line;
+		unexpected = msg->negative && match->start;
+		if (no_match || wrong_line || unexpected) {
 			PRINT_FAIL("expect_msg\n");
 			if (env.verbosity == VERBOSE_NONE)
 				emit_fn(log_buf, true /*force*/);
@@ -811,8 +909,10 @@ static void validate_msgs(char *log_buf, struct expected_msgs *msgs,
 					pat_status = "MATCHED   ";
 				else if (wrong_line)
 					pat_status = "WRONG LINE";
-				else
+				else if (no_match)
 					pat_status = "EXPECTED  ";
+				else
+					pat_status = "UNEXPECTED";
 				msg = &msgs->patterns[j];
 				fprintf(stderr, "%s %s: '%s'\n",
 					pat_status,
@@ -822,12 +922,13 @@ static void validate_msgs(char *log_buf, struct expected_msgs *msgs,
 			if (wrong_line) {
 				fprintf(stderr,
 					"expecting match at line %d, actual match is at line %d\n",
-					prev_match_line + 1, match_line);
+					prev_match->line + 1, match->line);
 			}
 			break;
 		}
 
-		prev_match_line = match_line;
+		if (!msg->negative)
+			prev_match = match;
 	}
 }
 
diff --git a/tools/testing/selftests/bpf/test_progs.h b/tools/testing/selftests/bpf/test_progs.h
index df2222a1806fd1604fc55ce50038548cd13304de..eebfc18cdcd21d2641bd42870a3364065ab290b5 100644
--- a/tools/testing/selftests/bpf/test_progs.h
+++ b/tools/testing/selftests/bpf/test_progs.h
@@ -7,6 +7,7 @@
 #include <errno.h>
 #include <string.h>
 #include <assert.h>
+#include <regex.h>
 #include <stdlib.h>
 #include <stdarg.h>
 #include <time.h>
@@ -546,4 +547,20 @@ extern void test_loader_fini(struct test_loader *tester);
 	test_loader_fini(&tester);					       \
 })
 
+struct expect_msg {
+	const char *substr; /* substring match */
+	regex_t regex;
+	bool is_regex;
+	bool on_next_line;
+	bool negative;
+};
+
+struct expected_msgs {
+	struct expect_msg *patterns;
+	size_t cnt;
+};
+
+void validate_msgs(const char *log_buf, struct expected_msgs *msgs,
+		   void (*emit_fn)(const char *buf, bool force));
+
 #endif /* __TEST_PROGS_H */

-- 
2.51.0

