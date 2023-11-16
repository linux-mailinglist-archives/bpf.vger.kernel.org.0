Return-Path: <bpf+bounces-15147-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 132197ED93B
	for <lists+bpf@lfdr.de>; Thu, 16 Nov 2023 03:19:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 924361F2334B
	for <lists+bpf@lfdr.de>; Thu, 16 Nov 2023 02:19:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ADF08F58;
	Thu, 16 Nov 2023 02:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EZRXrJwi"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAD09195
	for <bpf@vger.kernel.org>; Wed, 15 Nov 2023 18:18:45 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-9c3aec5f326so300715766b.1
        for <bpf@vger.kernel.org>; Wed, 15 Nov 2023 18:18:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700101124; x=1700705924; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RQu234yACJO1IDKnjKLTaJsjePtW5vPywi+FZQxD7xw=;
        b=EZRXrJwikfZV0/12Ym6oGMVlcbQ/P6Qsl7T5/oqziFogcMhzW0FIn5i4ty50HPqidn
         sfkPzV2Ic/DMwNrra6bNLcVdYk6lbx0yz48iVK2d9Zo9TSdq5DXqzXXkZrMxa1BugENE
         /m9fC1zp3uVJ+2fPSK3nEULGGle9lVlKQcpsK7kjYFFJqHtNqtJfPw/LNKJI0PW9oGZ1
         z1YhuYgCuoCWe2a7KFfNB7l6RQlp/VMA2K/UZ0q5fOjdx2EinK6pfYTjk/gaVCq2L1XZ
         66P37btmW0CoNh3L+4x0SS3wPgMUJ7hKBJaIBBp1OCRYaJz3NDyuVRwp4/xwNEvj6WZo
         MEhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700101124; x=1700705924;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RQu234yACJO1IDKnjKLTaJsjePtW5vPywi+FZQxD7xw=;
        b=Z1xX2E9znZTdw/AU1DLSYG0rJx3nANUHP/7SWXaEvPfH/tBlsb0KZy1nVQArC5GMsX
         +cdkaIZiI3rri4atvjxQ/KTWO4ILrrKAdTVRUBV684yXVVhZtfzSjv3PGluSnAM7hjYc
         No5SotwgNL8Je/M1KJad6zj+Pkx8Jv+IR6JWqxC8XZ+kdrxOF9r0iMKEtGrurINXOJxt
         q9BZySqtDphqZgl8h3nvqq38exugaKxty9Uk2dbkyNzvz8q5iExMCx2ulbKBH6kY0bqV
         6rGwQ8B04oVBgOR6UNpuVjhsfr//tn7/Dm7X2yi5+ZOZx9iXh4/90rueGWm7z5d0rgEj
         5Lkg==
X-Gm-Message-State: AOJu0Ywe+mYnNxi0YJXsHMslGOxv2E8jmqT65aLm8iitjOzv14mlInPW
	TVYleyHKez8+KrKBTQALg+RCJPuKbOfdwQ==
X-Google-Smtp-Source: AGHT+IGYCg8g84g3rVEqyVg3TWgjTQgoUWK+TUJ0napPsD/bQhajxRmaVPulhjsNHPzZM5kMlE5Ftw==
X-Received: by 2002:a17:906:e208:b0:9e5:2b00:506f with SMTP id gf8-20020a170906e20800b009e52b00506fmr283135ejb.15.1700101123925;
        Wed, 15 Nov 2023 18:18:43 -0800 (PST)
Received: from localhost.localdomain (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id ay1-20020a170906d28100b009dd606ce80fsm7774064ejb.31.2023.11.15.18.18.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Nov 2023 18:18:43 -0800 (PST)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	memxor@gmail.com,
	awerner32@gmail.com,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf 11/12] selftests/bpf: add __not_msg annotation for test_loader based tests
Date: Thu, 16 Nov 2023 04:18:02 +0200
Message-ID: <20231116021803.9982-12-eddyz87@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231116021803.9982-1-eddyz87@gmail.com>
References: <20231116021803.9982-1-eddyz87@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add an ability to specify messages that should not be found in the
test verifier log. Similar to LLVM's FileCheck tool for the following
test specification:

    __success
    __msg("a")
    __not_msg("b")
    __msg("c")
    void foo(...) { ... }

- message "a" is expected to be in the log;
- message "b" is not expected after message "a"
  (but could be present before "a");
- message "c" is expected to be in the log after message "a".

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 tools/testing/selftests/bpf/progs/bpf_misc.h |  9 +++
 tools/testing/selftests/bpf/test_loader.c    | 82 ++++++++++++++------
 2 files changed, 68 insertions(+), 23 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/bpf_misc.h b/tools/testing/selftests/bpf/progs/bpf_misc.h
index 799fff4995d8..f24fcda6fc0b 100644
--- a/tools/testing/selftests/bpf/progs/bpf_misc.h
+++ b/tools/testing/selftests/bpf/progs/bpf_misc.h
@@ -22,7 +22,13 @@
  *
  * __msg             Message expected to be found in the verifier log.
  *                   Multiple __msg attributes could be specified.
+ *                   When multiple messages are specified they are
+ *                   matched one after another.
+ * __not_msg	     Message not expected to be found in the verifier log.
+ *                   Matched from the end of the last checked __msg or
+ *                   from log start, if no __msg had been matched yet.
  * __msg_unpriv      Same as __msg but for unprivileged mode.
+ * __not_msg_unpriv  Same as __not_msg but for unprivileged mode.
  *
  * __success         Expect program load success in privileged mode.
  * __success_unpriv  Expect program load success in unprivileged mode.
@@ -59,10 +65,13 @@
  * __auxiliary_unpriv  Same, but load program in unprivileged mode.
  */
 #define __msg(msg)		__attribute__((btf_decl_tag("comment:test_expect_msg=" msg)))
+#define __not_msg(msg)		__attribute__((btf_decl_tag("comment:test_dont_expect_msg=" msg)))
 #define __failure		__attribute__((btf_decl_tag("comment:test_expect_failure")))
 #define __success		__attribute__((btf_decl_tag("comment:test_expect_success")))
 #define __description(desc)	__attribute__((btf_decl_tag("comment:test_description=" desc)))
 #define __msg_unpriv(msg)	__attribute__((btf_decl_tag("comment:test_expect_msg_unpriv=" msg)))
+#define __not_msg_unpriv(msg)						\
+	__attribute__((btf_decl_tag("comment:test_dont_expect_msg_unpriv=" msg)))
 #define __failure_unpriv	__attribute__((btf_decl_tag("comment:test_expect_failure_unpriv")))
 #define __success_unpriv	__attribute__((btf_decl_tag("comment:test_expect_success_unpriv")))
 #define __log_level(lvl)	__attribute__((btf_decl_tag("comment:test_log_level="#lvl)))
diff --git a/tools/testing/selftests/bpf/test_loader.c b/tools/testing/selftests/bpf/test_loader.c
index 37ffa57f28a1..def16d9aeae2 100644
--- a/tools/testing/selftests/bpf/test_loader.c
+++ b/tools/testing/selftests/bpf/test_loader.c
@@ -17,9 +17,11 @@
 #define TEST_TAG_EXPECT_FAILURE "comment:test_expect_failure"
 #define TEST_TAG_EXPECT_SUCCESS "comment:test_expect_success"
 #define TEST_TAG_EXPECT_MSG_PFX "comment:test_expect_msg="
+#define TEST_TAG_DONT_EXPECT_MSG_PFX "comment:test_dont_expect_msg="
 #define TEST_TAG_EXPECT_FAILURE_UNPRIV "comment:test_expect_failure_unpriv"
 #define TEST_TAG_EXPECT_SUCCESS_UNPRIV "comment:test_expect_success_unpriv"
 #define TEST_TAG_EXPECT_MSG_PFX_UNPRIV "comment:test_expect_msg_unpriv="
+#define TEST_TAG_DONT_EXPECT_MSG_PFX_UNPRIV "comment:test_dont_expect_msg_unpriv="
 #define TEST_TAG_LOG_LEVEL_PFX "comment:test_log_level="
 #define TEST_TAG_PROG_FLAGS_PFX "comment:test_prog_flags="
 #define TEST_TAG_DESCRIPTION_PFX "comment:test_description="
@@ -45,10 +47,15 @@ enum mode {
 	UNPRIV = 2
 };
 
+struct pattern {
+	const char *str;
+	bool expected;
+};
+
 struct test_subspec {
 	char *name;
 	bool expect_failure;
-	const char **expect_msgs;
+	struct pattern *expect_msgs;
 	size_t expect_msg_cnt;
 	int retval;
 	bool execute;
@@ -98,17 +105,21 @@ static void free_test_spec(struct test_spec *spec)
 	spec->unpriv.expect_msgs = NULL;
 }
 
-static int push_msg(const char *msg, struct test_subspec *subspec)
+static int push_msg(const char *msg, struct test_subspec *subspec, bool expected)
 {
+	size_t cnt = subspec->expect_msg_cnt;
 	void *tmp;
 
-	tmp = realloc(subspec->expect_msgs, (1 + subspec->expect_msg_cnt) * sizeof(void *));
+	tmp = realloc(subspec->expect_msgs,
+		      (1 + subspec->expect_msg_cnt) * sizeof(*subspec->expect_msgs));
 	if (!tmp) {
 		ASSERT_FAIL("failed to realloc memory for messages\n");
 		return -ENOMEM;
 	}
 	subspec->expect_msgs = tmp;
-	subspec->expect_msgs[subspec->expect_msg_cnt++] = msg;
+	subspec->expect_msgs[cnt].str = msg;
+	subspec->expect_msgs[cnt].expected = expected;
+	subspec->expect_msg_cnt++;
 
 	return 0;
 }
@@ -221,13 +232,25 @@ static int parse_test_spec(struct test_loader *tester,
 			spec->mode_mask |= UNPRIV;
 		} else if (str_has_pfx(s, TEST_TAG_EXPECT_MSG_PFX)) {
 			msg = s + sizeof(TEST_TAG_EXPECT_MSG_PFX) - 1;
-			err = push_msg(msg, &spec->priv);
+			err = push_msg(msg, &spec->priv, true);
 			if (err)
 				goto cleanup;
 			spec->mode_mask |= PRIV;
 		} else if (str_has_pfx(s, TEST_TAG_EXPECT_MSG_PFX_UNPRIV)) {
 			msg = s + sizeof(TEST_TAG_EXPECT_MSG_PFX_UNPRIV) - 1;
-			err = push_msg(msg, &spec->unpriv);
+			err = push_msg(msg, &spec->unpriv, true);
+			if (err)
+				goto cleanup;
+			spec->mode_mask |= UNPRIV;
+		} else if (str_has_pfx(s, TEST_TAG_DONT_EXPECT_MSG_PFX)) {
+			msg = s + sizeof(TEST_TAG_DONT_EXPECT_MSG_PFX) - 1;
+			err = push_msg(msg, &spec->priv, false);
+			if (err)
+				goto cleanup;
+			spec->mode_mask |= PRIV;
+		} else if (str_has_pfx(s, TEST_TAG_DONT_EXPECT_MSG_PFX_UNPRIV)) {
+			msg = s + sizeof(TEST_TAG_DONT_EXPECT_MSG_PFX_UNPRIV) - 1;
+			err = push_msg(msg, &spec->unpriv, false);
 			if (err)
 				goto cleanup;
 			spec->mode_mask |= UNPRIV;
@@ -316,7 +339,7 @@ static int parse_test_spec(struct test_loader *tester,
 		}
 
 		if (!spec->unpriv.expect_msgs) {
-			size_t sz = spec->priv.expect_msg_cnt * sizeof(void *);
+			size_t sz = spec->priv.expect_msg_cnt * sizeof(*spec->priv.expect_msgs);
 
 			spec->unpriv.expect_msgs = malloc(sz);
 			if (!spec->unpriv.expect_msgs) {
@@ -375,33 +398,46 @@ static void emit_verifier_log(const char *log_buf, bool force)
 	fprintf(stdout, "VERIFIER LOG:\n=============\n%s=============\n", log_buf);
 }
 
+static void show_log_and_msgs(struct test_loader *tester, struct test_subspec *subspec, int n)
+{
+	struct pattern *pat;
+	int i;
+
+	if (env.verbosity == VERBOSE_NONE)
+		emit_verifier_log(tester->log_buf, true /*force*/);
+	for (i = 0; i < n; i++) {
+		pat = &subspec->expect_msgs[i];
+		fprintf(stderr, "   MATCHED MSG: %s'%s'\n", pat->expected ? "" : "!", pat->str);
+	}
+}
+
 static void validate_case(struct test_loader *tester,
 			  struct test_subspec *subspec,
 			  struct bpf_object *obj,
 			  struct bpf_program *prog,
 			  int load_err)
 {
-	int i, j;
+	int i;
 
 	for (i = 0; i < subspec->expect_msg_cnt; i++) {
+		struct pattern *pat = &subspec->expect_msgs[i];
 		char *match;
-		const char *expect_msg;
-
-		expect_msg = subspec->expect_msgs[i];
-
-		match = strstr(tester->log_buf + tester->next_match_pos, expect_msg);
-		if (!ASSERT_OK_PTR(match, "expect_msg")) {
-			/* if we are in verbose mode, we've already emitted log */
-			if (env.verbosity == VERBOSE_NONE)
-				emit_verifier_log(tester->log_buf, true /*force*/);
-			for (j = 0; j < i; j++)
-				fprintf(stderr,
-					"MATCHED  MSG: '%s'\n", subspec->expect_msgs[j]);
-			fprintf(stderr, "EXPECTED MSG: '%s'\n", expect_msg);
+
+		match = strstr(tester->log_buf + tester->next_match_pos, pat->str);
+		if (pat->expected && !match) {
+			PRINT_FAIL("Expected log message not found\n");
+			show_log_and_msgs(tester, subspec, i);
+			fprintf(stderr, "  EXPECTED MSG: '%s'\n", pat->str);
 			return;
 		}
-
-		tester->next_match_pos = match - tester->log_buf + strlen(expect_msg);
+		if (!pat->expected && match) {
+			PRINT_FAIL("Unexpected log message found\n");
+			show_log_and_msgs(tester, subspec, i);
+			fprintf(stderr, "UNEXPECTED MSG: '%s'\n", pat->str);
+			return;
+		}
+		if (pat->expected)
+			tester->next_match_pos = match - tester->log_buf + strlen(pat->str);
 	}
 }
 
-- 
2.42.0


