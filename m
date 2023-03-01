Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E56A76A7264
	for <lists+bpf@lfdr.de>; Wed,  1 Mar 2023 18:54:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229510AbjCARyj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 1 Mar 2023 12:54:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbjCARyj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 1 Mar 2023 12:54:39 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C7D32D48
        for <bpf@vger.kernel.org>; Wed,  1 Mar 2023 09:54:37 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id ck15so57481549edb.0
        for <bpf@vger.kernel.org>; Wed, 01 Mar 2023 09:54:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677693275;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T7mgKkRg7HOgOCd2avAX4cZqmG93KKpjGb3rPXCTjU8=;
        b=qrXrkGjHn5wdHUk1y97g9y0d4/Qc3zfVYk4NbNwaERSz1AUnG/qvOhxRKOPBZzPuTQ
         8ZXd0ViKSfKC3tTJa/1n7wrHAFdRBLbtfJsgJg0tEXtPJVgGWGh+rJUuSn0NupSh9cJB
         +Q3hY3hRCB8igg1Bt87+Nf0lPmqmfrtU/fWHUyHxbAtglgajV8DlaOUzuWj0JhPrddM0
         INrUNMrWUnSLmDUDhBOwt69HAyQTbI08B4uRzWQw/+71ZMSeRJEg4l/kzxhVNn9Rqmeo
         tjUglVhc0+H3/+EjiUNNM7lU/SlR3FHEels22W2Ywd4kRRWAY3clSjvbwX310XZMgiVi
         dmJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677693275;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T7mgKkRg7HOgOCd2avAX4cZqmG93KKpjGb3rPXCTjU8=;
        b=PcIDYKZZwQyv+3TsSXvvKAyhe7JSk3wiO3voQ3AdjK96DsP2phKNUCqnkZ6lT2eFuP
         No1ILmbUXQF03DNG2krwhs6lVh6neQ00izWNtchRT5iQuXl/SSrn0mAlAbffl7AYkUPw
         ulif9dLT1riHUIoBMVZdVKBVGIi6agczm0oFqEMnDMyt2TdLx6EiULAoIX5/jI1goB5g
         DIVh78fIMoDaxVkpH9nWbaFjGtxC07kOdHBmGhT3AjgU5BD0ApmgTgFIvIkkefNCVr2Y
         46sBq8tdbPpRxT+PnhMnvn6PHfGDcpNduTwIygCtB3y+hGkE0h6X4V7xUpzP9RM3DoFG
         Ff0w==
X-Gm-Message-State: AO0yUKUJj2iUiIamw3fKCKl40cQ3McOqLGQ6NT1iUF5phEAPcu6P7Xed
        hQRccmGVMl3BLJararGZ7ULkw0gLAYkBqQ==
X-Google-Smtp-Source: AK7set/hE25WZmzMfFL+yxBByFdppBx1Eks4aE2PkCUrS4lfQd8YU7mdMMErwRUHl4M46lydYLz0eg==
X-Received: by 2002:a17:907:a07:b0:878:711d:9310 with SMTP id bb7-20020a1709070a0700b00878711d9310mr9456111ejc.1.1677693275324;
        Wed, 01 Mar 2023 09:54:35 -0800 (PST)
Received: from bigfoot.. (boundsly.muster.volia.net. [93.72.16.93])
        by smtp.gmail.com with ESMTPSA id 26-20020a50875a000000b004a21c9facd5sm5909812edv.67.2023.03.01.09.54.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Mar 2023 09:54:35 -0800 (PST)
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     bpf@vger.kernel.org, ast@kernel.org
Cc:     andrii@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
        kernel-team@fb.com, yhs@fb.com,
        Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next 1/1] selftests/bpf: support custom per-test flags and multiple expected messages
Date:   Wed,  1 Mar 2023 19:54:17 +0200
Message-Id: <20230301175417.3146070-2-eddyz87@gmail.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230301175417.3146070-1-eddyz87@gmail.com>
References: <20230301175417.3146070-1-eddyz87@gmail.com>
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

From: Andrii Nakryiko <andrii@kernel.org>

Extend __flag attribute by allowing to specify one of the following:
 * BPF_F_STRICT_ALIGNMENT
 * BPF_F_ANY_ALIGNMENT
 * BPF_F_TEST_RND_HI32
 * BPF_F_TEST_STATE_FREQ
 * BPF_F_SLEEPABLE
 * BPF_F_XDP_HAS_FRAGS
 * Some numeric value

Extend __msg attribute by allowing to specify multiple exepcted messages.
All messages are expected to be present in the verifier log in the
order of application.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
[ Eduard: added commit message, formatting, comments ]
Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 tools/testing/selftests/bpf/progs/bpf_misc.h | 23 +++++++
 tools/testing/selftests/bpf/test_loader.c    | 69 +++++++++++++++++---
 tools/testing/selftests/bpf/test_progs.h     |  1 +
 3 files changed, 84 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/bpf_misc.h b/tools/testing/selftests/bpf/progs/bpf_misc.h
index 14e28f991451..f704885aa534 100644
--- a/tools/testing/selftests/bpf/progs/bpf_misc.h
+++ b/tools/testing/selftests/bpf/progs/bpf_misc.h
@@ -2,10 +2,33 @@
 #ifndef __BPF_MISC_H__
 #define __BPF_MISC_H__
 
+/* This set of attributes controls behavior of the
+ * test_loader.c:test_loader__run_subtests().
+ *
+ * __msg             Message expected to be found in the verifier log.
+ *                   Multiple __msg attributes could be specified.
+ *
+ * __success         Expect program load success in privileged mode.
+ *
+ * __failure         Expect program load failure in privileged mode.
+ *
+ * __log_level       Log level to use for the program, numeric value expected.
+ *
+ * __flag            Adds one flag use for the program, the following values are valid:
+ *                   - BPF_F_STRICT_ALIGNMENT;
+ *                   - BPF_F_TEST_RND_HI32;
+ *                   - BPF_F_TEST_STATE_FREQ;
+ *                   - BPF_F_SLEEPABLE;
+ *                   - BPF_F_XDP_HAS_FRAGS;
+ *                   - A numeric value.
+ *                   Multiple __flag attributes could be specified, the final flags
+ *                   value is derived by applying binary "or" to all specified values.
+ */
 #define __msg(msg)		__attribute__((btf_decl_tag("comment:test_expect_msg=" msg)))
 #define __failure		__attribute__((btf_decl_tag("comment:test_expect_failure")))
 #define __success		__attribute__((btf_decl_tag("comment:test_expect_success")))
 #define __log_level(lvl)	__attribute__((btf_decl_tag("comment:test_log_level="#lvl)))
+#define __flag(flag)		__attribute__((btf_decl_tag("comment:test_prog_flags="#flag)))
 
 /* Convenience macro for use with 'asm volatile' blocks */
 #define __naked __attribute__((naked))
diff --git a/tools/testing/selftests/bpf/test_loader.c b/tools/testing/selftests/bpf/test_loader.c
index 679efb3aa785..bf41390157bf 100644
--- a/tools/testing/selftests/bpf/test_loader.c
+++ b/tools/testing/selftests/bpf/test_loader.c
@@ -13,12 +13,15 @@
 #define TEST_TAG_EXPECT_SUCCESS "comment:test_expect_success"
 #define TEST_TAG_EXPECT_MSG_PFX "comment:test_expect_msg="
 #define TEST_TAG_LOG_LEVEL_PFX "comment:test_log_level="
+#define TEST_TAG_PROG_FLAGS_PFX "comment:test_prog_flags="
 
 struct test_spec {
 	const char *name;
 	bool expect_failure;
-	const char *expect_msg;
+	const char **expect_msgs;
+	size_t expect_msg_cnt;
 	int log_level;
+	int prog_flags;
 };
 
 static int tester_init(struct test_loader *tester)
@@ -67,7 +70,8 @@ static int parse_test_spec(struct test_loader *tester,
 
 	for (i = 1; i < btf__type_cnt(btf); i++) {
 		const struct btf_type *t;
-		const char *s;
+		const char *s, *val;
+		char *e;
 
 		t = btf__type_by_id(btf, i);
 		if (!btf_is_decl_tag(t))
@@ -82,14 +86,48 @@ static int parse_test_spec(struct test_loader *tester,
 		} else if (strcmp(s, TEST_TAG_EXPECT_SUCCESS) == 0) {
 			spec->expect_failure = false;
 		} else if (str_has_pfx(s, TEST_TAG_EXPECT_MSG_PFX)) {
-			spec->expect_msg = s + sizeof(TEST_TAG_EXPECT_MSG_PFX) - 1;
+			void *tmp;
+			const char **msg;
+
+			tmp = realloc(spec->expect_msgs,
+				      (1 + spec->expect_msg_cnt) * sizeof(void *));
+			if (!tmp) {
+				ASSERT_FAIL("failed to realloc memory for messages\n");
+				return -ENOMEM;
+			}
+			spec->expect_msgs = tmp;
+			msg = &spec->expect_msgs[spec->expect_msg_cnt++];
+			*msg = s + sizeof(TEST_TAG_EXPECT_MSG_PFX) - 1;
 		} else if (str_has_pfx(s, TEST_TAG_LOG_LEVEL_PFX)) {
+			val = s + sizeof(TEST_TAG_LOG_LEVEL_PFX) - 1;
 			errno = 0;
-			spec->log_level = strtol(s + sizeof(TEST_TAG_LOG_LEVEL_PFX) - 1, NULL, 0);
-			if (errno) {
+			spec->log_level = strtol(val, &e, 0);
+			if (errno || e[0] != '\0') {
 				ASSERT_FAIL("failed to parse test log level from '%s'", s);
 				return -EINVAL;
 			}
+		} else if (str_has_pfx(s, TEST_TAG_PROG_FLAGS_PFX)) {
+			val = s + sizeof(TEST_TAG_PROG_FLAGS_PFX) - 1;
+			if (strcmp(val, "BPF_F_STRICT_ALIGNMENT") == 0) {
+				spec->prog_flags |= BPF_F_STRICT_ALIGNMENT;
+			} else if (strcmp(val, "BPF_F_ANY_ALIGNMENT") == 0) {
+				spec->prog_flags |= BPF_F_ANY_ALIGNMENT;
+			} else if (strcmp(val, "BPF_F_TEST_RND_HI32") == 0) {
+				spec->prog_flags |= BPF_F_TEST_RND_HI32;
+			} else if (strcmp(val, "BPF_F_TEST_STATE_FREQ") == 0) {
+				spec->prog_flags |= BPF_F_TEST_STATE_FREQ;
+			} else if (strcmp(val, "BPF_F_SLEEPABLE") == 0) {
+				spec->prog_flags |= BPF_F_SLEEPABLE;
+			} else if (strcmp(val, "BPF_F_XDP_HAS_FRAGS") == 0) {
+				spec->prog_flags |= BPF_F_XDP_HAS_FRAGS;
+			} else /* assume numeric value */ {
+				errno = 0;
+				spec->prog_flags |= strtol(val, &e, 0);
+				if (errno || e[0] != '\0') {
+					ASSERT_FAIL("failed to parse test prog flags from '%s'", s);
+					return -EINVAL;
+				}
+			}
 		}
 	}
 
@@ -101,7 +139,7 @@ static void prepare_case(struct test_loader *tester,
 			 struct bpf_object *obj,
 			 struct bpf_program *prog)
 {
-	int min_log_level = 0;
+	int min_log_level = 0, prog_flags;
 
 	if (env.verbosity > VERBOSE_NONE)
 		min_log_level = 1;
@@ -119,7 +157,11 @@ static void prepare_case(struct test_loader *tester,
 	else
 		bpf_program__set_log_level(prog, spec->log_level);
 
+	prog_flags = bpf_program__flags(prog);
+	bpf_program__set_flags(prog, prog_flags | spec->prog_flags);
+
 	tester->log_buf[0] = '\0';
+	tester->next_match_pos = 0;
 }
 
 static void emit_verifier_log(const char *log_buf, bool force)
@@ -135,17 +177,26 @@ static void validate_case(struct test_loader *tester,
 			  struct bpf_program *prog,
 			  int load_err)
 {
-	if (spec->expect_msg) {
+	int i, j;
+
+	for (i = 0; i < spec->expect_msg_cnt; i++) {
 		char *match;
+		const char *expect_msg;
+
+		expect_msg = spec->expect_msgs[i];
 
-		match = strstr(tester->log_buf, spec->expect_msg);
+		match = strstr(tester->log_buf + tester->next_match_pos, expect_msg);
 		if (!ASSERT_OK_PTR(match, "expect_msg")) {
 			/* if we are in verbose mode, we've already emitted log */
 			if (env.verbosity == VERBOSE_NONE)
 				emit_verifier_log(tester->log_buf, true /*force*/);
-			fprintf(stderr, "EXPECTED MSG: '%s'\n", spec->expect_msg);
+			for (j = 0; j < i; j++)
+				fprintf(stderr, "MATCHED  MSG: '%s'\n", spec->expect_msgs[j]);
+			fprintf(stderr, "EXPECTED MSG: '%s'\n", expect_msg);
 			return;
 		}
+
+		tester->next_match_pos = match - tester->log_buf + strlen(expect_msg);
 	}
 }
 
diff --git a/tools/testing/selftests/bpf/test_progs.h b/tools/testing/selftests/bpf/test_progs.h
index 9fbdc57c5b57..3cbf005747ed 100644
--- a/tools/testing/selftests/bpf/test_progs.h
+++ b/tools/testing/selftests/bpf/test_progs.h
@@ -427,6 +427,7 @@ int get_bpf_max_tramp_links(void);
 struct test_loader {
 	char *log_buf;
 	size_t log_buf_sz;
+	size_t next_match_pos;
 
 	struct bpf_object *obj;
 };
-- 
2.39.1

