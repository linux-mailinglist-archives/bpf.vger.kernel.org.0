Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7620B677E6A
	for <lists+bpf@lfdr.de>; Mon, 23 Jan 2023 15:52:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231983AbjAWOwP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 23 Jan 2023 09:52:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231981AbjAWOwO (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 23 Jan 2023 09:52:14 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6C471DB8F
        for <bpf@vger.kernel.org>; Mon, 23 Jan 2023 06:52:12 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id e19-20020a05600c439300b003db1cac0c1fso9297338wmn.5
        for <bpf@vger.kernel.org>; Mon, 23 Jan 2023 06:52:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VZtwewBw0jZc1V/EXdclfT0bgMz05ZvL7GcUmamn1B8=;
        b=paXOBuUfqUX+uJLiw30B6kLCUPM4yxm9yuqI8+i4WoC1E6QaR5eyvPFInuLYveT4cm
         WXmDvYmzuRZ13R3XU7VpZTbB+Wun2CIS0hKCLepIhE3e0WPwNDMa2GPOts8pRI54GRdB
         vIBp470yrkq+JK3etgUlYYAw6IKsVdfSRG5q9jttLqpEYFqtLaELX3NuFETeQivlJZA0
         OxRT5pAGL7tZjNyY4ZqyOkRkzMAiZUL5FzMmWR81SxKOsD1jai37mYP2UhBQSqX7W6Dh
         3vYRIUhn6gv+S0H9y6t99pqP/Hyg8rCBQVXc1QrQ69SOoSulgYNLMG6ox0R0AViBjPkg
         qVXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VZtwewBw0jZc1V/EXdclfT0bgMz05ZvL7GcUmamn1B8=;
        b=HmqGyqnjse1M/jmn62DI8FtlxS4o1AFYFXbzqB4HqtgMzes19EfLg7aedR+1DsglAD
         cb5vkzba/r+Kb/q30Uh9TcdchqrxcOTOJWP6HPgh7ZWphtv9xVLMq+yocqz1+EDIIzZF
         HLNO9O/Bv8u7qYGv24CFxmNNpGgP4+M63VHE/+fuabB8T4/4FTVb7UQKTK1NKfWdj1qD
         aOCn3pvKvz106VjVxZHcGC9kEEZcnPYCNAOkbB6NvByGe7HsLKOCzR7BenZKzAyv/prT
         Gv1EpUjlpCxP8zk9zOZoDpAzldgZ62I0gc9fJCcdz0WicH1tgkP9lNnjMZdrk9Rtlueu
         8Rsw==
X-Gm-Message-State: AFqh2kq4VxA43MVqLETu2/vUS91iZPXyNKSLKbGxixyqT8IKVtICooxt
        K8fk/sikNqmhIRKqrckY5gKBJ9qq8M0=
X-Google-Smtp-Source: AMrXdXusBEDuNpkjzH4RnXfbGI4FuR4lnpdTqHnp+W4YaQq7EOjj2AoCbv/tqbNyX+T+lpcS/V+BXw==
X-Received: by 2002:a05:600c:34ce:b0:3db:25f:be9e with SMTP id d14-20020a05600c34ce00b003db025fbe9emr24388099wmq.33.1674485531027;
        Mon, 23 Jan 2023 06:52:11 -0800 (PST)
Received: from pluto.. (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id c7-20020a05600c0a4700b003d1e1f421bfsm11999649wmq.10.2023.01.23.06.52.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jan 2023 06:52:10 -0800 (PST)
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     bpf@vger.kernel.org, ast@kernel.org
Cc:     andrii@kernel.org, daniel@iogearbox.net, kernel-team@fb.com,
        yhs@fb.com, Eduard Zingerman <eddyz87@gmail.com>
Subject: [RFC bpf-next 1/5] selftests/bpf: support custom per-test flags and multiple expected messages
Date:   Mon, 23 Jan 2023 16:51:44 +0200
Message-Id: <20230123145148.2791939-2-eddyz87@gmail.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230123145148.2791939-1-eddyz87@gmail.com>
References: <20230123145148.2791939-1-eddyz87@gmail.com>
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
[ Eduard: added commit message, formatting ]
Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 tools/testing/selftests/bpf/test_loader.c | 69 ++++++++++++++++++++---
 tools/testing/selftests/bpf/test_progs.h  |  1 +
 2 files changed, 61 insertions(+), 9 deletions(-)

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
index 3f058dfadbaf..9af80704f20a 100644
--- a/tools/testing/selftests/bpf/test_progs.h
+++ b/tools/testing/selftests/bpf/test_progs.h
@@ -410,6 +410,7 @@ int write_sysctl(const char *sysctl, const char *value);
 struct test_loader {
 	char *log_buf;
 	size_t log_buf_sz;
+	size_t next_match_pos;
 
 	struct bpf_object *obj;
 };
-- 
2.39.0

