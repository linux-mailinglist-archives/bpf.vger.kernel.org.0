Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 288FA677E6D
	for <lists+bpf@lfdr.de>; Mon, 23 Jan 2023 15:52:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231775AbjAWOwS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 23 Jan 2023 09:52:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231993AbjAWOwR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 23 Jan 2023 09:52:17 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 075E61D93F
        for <bpf@vger.kernel.org>; Mon, 23 Jan 2023 06:52:14 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id l8so9216039wms.3
        for <bpf@vger.kernel.org>; Mon, 23 Jan 2023 06:52:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jUK3JZVXp/bGX6GLm1XhNtLpF9tSREAfs4JtN+SxyP4=;
        b=CyoPE29l2nRIAD/WC1LGqnFDg5Dh2aNK2cDL7jh8xHhJOlYEXG1TL53XOYKhBxSlbG
         ekG7dGI7+7MG86U983HfPxNngtMGwlnnjc52zWSw0Zycn5WFYTD9hFlB27Db4q4vUKkT
         Exdt4tjyi108G3ipv6+iOi3Hv69zBbPGKiboseDfMk9EAbl2wo7RbmsB2wqJiu2yuhcR
         WNLdXBM7ouh8ci8FelO6tJaVMNC5NWHvljdOLDOR9J1xii3SKAdcbHfbFqDNPrBS1vhN
         lYaYoBmH6QR1MjvI3K+JznzRQ4rc4t7OgtgNXgqbCg7+Fxs68CX4v73MSBrG6W5PinBr
         jA9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jUK3JZVXp/bGX6GLm1XhNtLpF9tSREAfs4JtN+SxyP4=;
        b=qSld5iDADntBtc0QeVTU4Qi6uOwj1pzrEYKGMdwfEpYDLY59gyKdU8BaMNCUUxdMbT
         TyMYkiQ58sxXpCI43GAfekx0fCwq1GTywUp+Dk6s2x6GBaS0wlW9Ik7OK7XNZGbQ6yF7
         f87SEwgxZacfNUSVmvx/VoBUEd3vRTGP5jm1AH0pSitI3Na2AMxkjdQQnXGSY0N3PlQR
         ZqBtgY+itigu0jK5jrawQ859WzhrnDpkMMX9a3ZLmBblZdye21xCek+QVg9Gd26FAEo9
         PUQcjYBVIZwEM8SQ1R9epVRBRw+koiBQy4TgpsyxoffseuMEvGLZQEVrKLgSHXC6kuU4
         aADQ==
X-Gm-Message-State: AFqh2kpbLwMjW4iT4zZMoOHgjjpKl3ZffqxOtDVDvopajaTaXEi1UqwZ
        x7qimtGD6fAl38Bsq19ztUeYE9RTu6M=
X-Google-Smtp-Source: AMrXdXvBZBlPS3XUM1wBK9MqkNaOwoBMe7oun3n/Dj8c2Fmmn6hz3sQ/NTV8oP2m8l/qY/TpX4rh2Q==
X-Received: by 2002:a05:600c:1c8b:b0:3db:fe:f84e with SMTP id k11-20020a05600c1c8b00b003db00fef84emr23192896wms.1.1674485531953;
        Mon, 23 Jan 2023 06:52:11 -0800 (PST)
Received: from pluto.. (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id c7-20020a05600c0a4700b003d1e1f421bfsm11999649wmq.10.2023.01.23.06.52.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jan 2023 06:52:11 -0800 (PST)
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     bpf@vger.kernel.org, ast@kernel.org
Cc:     andrii@kernel.org, daniel@iogearbox.net, kernel-team@fb.com,
        yhs@fb.com, Eduard Zingerman <eddyz87@gmail.com>
Subject: [RFC bpf-next 2/5] selftests/bpf: unprivileged tests for test_loader.c
Date:   Mon, 23 Jan 2023 16:51:45 +0200
Message-Id: <20230123145148.2791939-3-eddyz87@gmail.com>
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

Extends test_loader.c:test_loader__run_subtests() by allowing to
execute tests in unprivileged mode, similar to test_verifier.c.

Adds the following new attributes controlling test_loader behavior:

  __msg_unpriv
  __success_unpriv
  __failure_unpriv

* If any of these attributes is present the test would be loaded in
  unprivileged mode.
* If only "privileged" attributes are present the test would be loaded
  only in privileged mode.
* If both "privileged" and "unprivileged" attributes are present the
  test would be loaded in both modes.
* If test has to be executed in both modes, __msg(text) is specified
  and __msg_unpriv is not specified the behavior is the same as if
  __msg_unpriv(text) is specified.
* For test filtering purposes the name of the program loaded in
  unprivileged mode is derived from the usual program name by adding
  `@unpriv' suffix.

Also adds attribute '__description'. This attribute specifies text to
be used instead of a program name for display and filtering purposes.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 tools/testing/selftests/bpf/Makefile          |   7 +-
 tools/testing/selftests/bpf/autoconf_helper.h |   9 +
 tools/testing/selftests/bpf/progs/bpf_misc.h  |  48 +++
 tools/testing/selftests/bpf/test_loader.c     | 337 ++++++++++++++----
 tools/testing/selftests/bpf/test_verifier.c   |  25 +-
 tools/testing/selftests/bpf/unpriv_helpers.c  |  26 ++
 tools/testing/selftests/bpf/unpriv_helpers.h  |   7 +
 7 files changed, 359 insertions(+), 100 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/autoconf_helper.h
 create mode 100644 tools/testing/selftests/bpf/unpriv_helpers.c
 create mode 100644 tools/testing/selftests/bpf/unpriv_helpers.h

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 22533a18705e..26e66f9a0977 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -218,8 +218,9 @@ TEST_GEN_PROGS_EXTENDED += $(DEFAULT_BPFTOOL)
 
 $(TEST_GEN_PROGS) $(TEST_GEN_PROGS_EXTENDED): $(BPFOBJ)
 
-CGROUP_HELPERS	:= $(OUTPUT)/cgroup_helpers.o
 TESTING_HELPERS	:= $(OUTPUT)/testing_helpers.o
+CGROUP_HELPERS	:= $(OUTPUT)/cgroup_helpers.o
+UNPRIV_HELPERS  := $(OUTPUT)/unpriv_helpers.o
 TRACE_HELPERS	:= $(OUTPUT)/trace_helpers.o
 CAP_HELPERS	:= $(OUTPUT)/cap_helpers.o
 
@@ -238,7 +239,7 @@ $(OUTPUT)/test_lirc_mode2_user: $(TESTING_HELPERS)
 $(OUTPUT)/xdping: $(TESTING_HELPERS)
 $(OUTPUT)/flow_dissector_load: $(TESTING_HELPERS)
 $(OUTPUT)/test_maps: $(TESTING_HELPERS)
-$(OUTPUT)/test_verifier: $(TESTING_HELPERS) $(CAP_HELPERS)
+$(OUTPUT)/test_verifier: $(TESTING_HELPERS) $(CAP_HELPERS) $(UNPRIV_HELPERS)
 $(OUTPUT)/xsk.o: $(BPFOBJ)
 
 BPFTOOL ?= $(DEFAULT_BPFTOOL)
@@ -527,7 +528,7 @@ TRUNNER_BPF_PROGS_DIR := progs
 TRUNNER_EXTRA_SOURCES := test_progs.c cgroup_helpers.c trace_helpers.c	\
 			 network_helpers.c testing_helpers.c		\
 			 btf_helpers.c flow_dissector_load.h		\
-			 cap_helpers.c test_loader.c
+			 cap_helpers.c test_loader.c unpriv_helpers.c
 TRUNNER_EXTRA_FILES := $(OUTPUT)/urandom_read $(OUTPUT)/bpf_testmod.ko	\
 		       $(OUTPUT)/liburandom_read.so			\
 		       $(OUTPUT)/xdp_synproxy				\
diff --git a/tools/testing/selftests/bpf/autoconf_helper.h b/tools/testing/selftests/bpf/autoconf_helper.h
new file mode 100644
index 000000000000..5b243b9cdf8c
--- /dev/null
+++ b/tools/testing/selftests/bpf/autoconf_helper.h
@@ -0,0 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#ifdef HAVE_GENHDR
+# include "autoconf.h"
+#else
+# if defined(__i386) || defined(__x86_64) || defined(__s390x__) || defined(__aarch64__)
+#  define CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS 1
+# endif
+#endif
diff --git a/tools/testing/selftests/bpf/progs/bpf_misc.h b/tools/testing/selftests/bpf/progs/bpf_misc.h
index 2d7b89b447b2..e742a935de98 100644
--- a/tools/testing/selftests/bpf/progs/bpf_misc.h
+++ b/tools/testing/selftests/bpf/progs/bpf_misc.h
@@ -2,10 +2,58 @@
 #ifndef __BPF_MISC_H__
 #define __BPF_MISC_H__
 
+/* This set of attributes controls behavior of the
+ * test_loader.c:test_loader__run_subtests().
+ *
+ * The test_loader sequentially loads each program in a skeleton.
+ * Programs could be loaded in privileged and unprivileged modes.
+ * - __success, __failure, __msg imply privileged mode;
+ * - __success_unpriv, __failure_unpriv, __msg_unpriv imply
+ *   unprivileged mode.
+ * If combination of privileged and unprivileged attributes is present
+ * both modes are used. If none are present privileged mode is implied.
+ *
+ * See test_loader.c:set_admin() for exact set of capabilities that
+ * differ between privileged and unprivileged modes.
+ *
+ * For test filtering purposes the name of the program loaded in
+ * unprivileged mode is derived from the usual program name by adding
+ * `@unpriv' suffix.
+ *
+ * __msg             Message expected to be found in the verifier log.
+ *                   Multiple __msg attributes could be specified.
+ * __msg_unpriv      Same as __msg but for unprivileged mode.
+ *
+ * __success         Expect program load success in privileged mode.
+ * __success_unpriv  Expect program load success in unprivileged mode.
+ *
+ * __failure         Expect program load failure in privileged mode.
+ * __failure_unpriv  Expect program load failure in unprivileged mode.
+ *
+ * __description     Text to be used instead of a program name for display
+ *                   and filtering purposes.
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
+#define __description(desc)	__attribute__((btf_decl_tag("comment:test_description=" desc)))
+#define __msg_unpriv(msg)	__attribute__((btf_decl_tag("comment:test_expect_msg_unpriv=" msg)))
+#define __failure_unpriv	__attribute__((btf_decl_tag("comment:test_expect_failure_unpriv")))
+#define __success_unpriv	__attribute__((btf_decl_tag("comment:test_expect_success_unpriv")))
 #define __log_level(lvl)	__attribute__((btf_decl_tag("comment:test_log_level="#lvl)))
+#define __flag(flag)		__attribute__((btf_decl_tag("comment:test_prog_flags="#flag)))
 
 /* Convenience macro for use with 'asm volatile' blocks */
 #define __naked __attribute__((naked))
diff --git a/tools/testing/selftests/bpf/test_loader.c b/tools/testing/selftests/bpf/test_loader.c
index bf41390157bf..f035f08c413c 100644
--- a/tools/testing/selftests/bpf/test_loader.c
+++ b/tools/testing/selftests/bpf/test_loader.c
@@ -1,9 +1,14 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /* Copyright (c) 2022 Meta Platforms, Inc. and affiliates. */
+#include <linux/capability.h>
 #include <stdlib.h>
 #include <test_progs.h>
 #include <bpf/btf.h>
 
+#include "autoconf_helper.h"
+#include "unpriv_helpers.h"
+#include "cap_helpers.h"
+
 #define str_has_pfx(str, pfx) \
 	(strncmp(str, pfx, __builtin_constant_p(pfx) ? sizeof(pfx) - 1 : strlen(pfx)) == 0)
 
@@ -12,16 +17,38 @@
 #define TEST_TAG_EXPECT_FAILURE "comment:test_expect_failure"
 #define TEST_TAG_EXPECT_SUCCESS "comment:test_expect_success"
 #define TEST_TAG_EXPECT_MSG_PFX "comment:test_expect_msg="
+#define TEST_TAG_EXPECT_FAILURE_UNPRIV "comment:test_expect_failure_unpriv"
+#define TEST_TAG_EXPECT_SUCCESS_UNPRIV "comment:test_expect_success_unpriv"
+#define TEST_TAG_EXPECT_MSG_PFX_UNPRIV "comment:test_expect_msg_unpriv="
 #define TEST_TAG_LOG_LEVEL_PFX "comment:test_log_level="
 #define TEST_TAG_PROG_FLAGS_PFX "comment:test_prog_flags="
+#define TEST_TAG_DESCRIPTION_PFX "comment:test_description="
 
-struct test_spec {
-	const char *name;
+#define ADMIN_CAPS (1ULL << CAP_SYS_ADMIN |	\
+		    1ULL << CAP_PERFMON |	\
+		    1ULL << CAP_BPF)
+
+static int sysctl_unpriv_disabled = -1;
+
+enum mode {
+	PRIV = 1,
+	UNPRIV = 2
+};
+
+struct test_subspec {
+	char *name;
 	bool expect_failure;
 	const char **expect_msgs;
 	size_t expect_msg_cnt;
+};
+
+struct test_spec {
+	const char *prog_name;
+	struct test_subspec priv;
+	struct test_subspec unpriv;
 	int log_level;
 	int prog_flags;
+	int mode_mask;
 };
 
 static int tester_init(struct test_loader *tester)
@@ -44,17 +71,46 @@ void test_loader_fini(struct test_loader *tester)
 	free(tester->log_buf);
 }
 
+static void free_test_spec(struct test_spec *spec)
+{
+	free(spec->priv.name);
+	free(spec->unpriv.name);
+	free(spec->priv.expect_msgs);
+	free(spec->unpriv.expect_msgs);
+}
+
+static int push_msg(const char *msg, struct test_subspec *subspec)
+{
+	void *tmp;
+
+	tmp = realloc(subspec->expect_msgs, (1 + subspec->expect_msg_cnt) * sizeof(void *));
+	if (!tmp) {
+		ASSERT_FAIL("failed to realloc memory for messages\n");
+		return -ENOMEM;
+	}
+	subspec->expect_msgs = tmp;
+	subspec->expect_msgs[subspec->expect_msg_cnt++] = msg;
+
+	return 0;
+}
+
+/* Uses btf_decl_tag attributes to describe the expected test
+ * behavior, see bpf_misc.h for detailed description of each attribute
+ * and attribute combinations.
+ */
 static int parse_test_spec(struct test_loader *tester,
 			   struct bpf_object *obj,
 			   struct bpf_program *prog,
 			   struct test_spec *spec)
 {
+	const char *description = NULL;
+	bool has_unpriv_result = false;
+	int func_id, i, err = 0;
 	struct btf *btf;
-	int func_id, i;
 
 	memset(spec, 0, sizeof(*spec));
 
-	spec->name = bpf_program__name(prog);
+	spec->prog_name = bpf_program__name(prog);
 
 	btf = bpf_object__btf(obj);
 	if (!btf) {
@@ -62,15 +118,15 @@ static int parse_test_spec(struct test_loader *tester,
 		return -EINVAL;
 	}
 
-	func_id = btf__find_by_name_kind(btf, spec->name, BTF_KIND_FUNC);
+	func_id = btf__find_by_name_kind(btf, spec->prog_name, BTF_KIND_FUNC);
 	if (func_id < 0) {
-		ASSERT_FAIL("failed to find FUNC BTF type for '%s'", spec->name);
+		ASSERT_FAIL("failed to find FUNC BTF type for '%s'", spec->prog_name);
 		return -EINVAL;
 	}
 
 	for (i = 1; i < btf__type_cnt(btf); i++) {
+		const char *s, *val, *msg;
 		const struct btf_type *t;
-		const char *s, *val;
 		char *e;
 
 		t = btf__type_by_id(btf, i);
@@ -81,30 +137,42 @@ static int parse_test_spec(struct test_loader *tester,
 			continue;
 
 		s = btf__str_by_offset(btf, t->name_off);
-		if (strcmp(s, TEST_TAG_EXPECT_FAILURE) == 0) {
-			spec->expect_failure = true;
+		if (str_has_pfx(s, TEST_TAG_DESCRIPTION_PFX)) {
+			description = s + sizeof(TEST_TAG_DESCRIPTION_PFX) - 1;
+		} else if (strcmp(s, TEST_TAG_EXPECT_FAILURE) == 0) {
+			spec->priv.expect_failure = true;
+			spec->mode_mask |= PRIV;
 		} else if (strcmp(s, TEST_TAG_EXPECT_SUCCESS) == 0) {
-			spec->expect_failure = false;
+			spec->priv.expect_failure = false;
+			spec->mode_mask |= PRIV;
+		} else if (strcmp(s, TEST_TAG_EXPECT_FAILURE_UNPRIV) == 0) {
+			spec->unpriv.expect_failure = true;
+			spec->mode_mask |= UNPRIV;
+			has_unpriv_result = true;
+		} else if (strcmp(s, TEST_TAG_EXPECT_SUCCESS_UNPRIV) == 0) {
+			spec->unpriv.expect_failure = false;
+			spec->mode_mask |= UNPRIV;
+			has_unpriv_result = true;
 		} else if (str_has_pfx(s, TEST_TAG_EXPECT_MSG_PFX)) {
-			void *tmp;
-			const char **msg;
-
-			tmp = realloc(spec->expect_msgs,
-				      (1 + spec->expect_msg_cnt) * sizeof(void *));
-			if (!tmp) {
-				ASSERT_FAIL("failed to realloc memory for messages\n");
-				return -ENOMEM;
-			}
-			spec->expect_msgs = tmp;
-			msg = &spec->expect_msgs[spec->expect_msg_cnt++];
-			*msg = s + sizeof(TEST_TAG_EXPECT_MSG_PFX) - 1;
+			msg = s + sizeof(TEST_TAG_EXPECT_MSG_PFX) - 1;
+			err = push_msg(msg, &spec->priv);
+			if (err)
+				goto cleanup;
+			spec->mode_mask |= PRIV;
+		} else if (str_has_pfx(s, TEST_TAG_EXPECT_MSG_PFX_UNPRIV)) {
+			msg = s + sizeof(TEST_TAG_EXPECT_MSG_PFX_UNPRIV) - 1;
+			err = push_msg(msg, &spec->unpriv);
+			if (err)
+				goto cleanup;
+			spec->mode_mask |= UNPRIV;
 		} else if (str_has_pfx(s, TEST_TAG_LOG_LEVEL_PFX)) {
 			val = s + sizeof(TEST_TAG_LOG_LEVEL_PFX) - 1;
 			errno = 0;
 			spec->log_level = strtol(val, &e, 0);
 			if (errno || e[0] != '\0') {
-				ASSERT_FAIL("failed to parse test log level from '%s'", s);
-				return -EINVAL;
+				PRINT_FAIL("failed to parse test log level from '%s'\n", s);
+				err = -EINVAL;
+				goto cleanup;
 			}
 		} else if (str_has_pfx(s, TEST_TAG_PROG_FLAGS_PFX)) {
 			val = s + sizeof(TEST_TAG_PROG_FLAGS_PFX) - 1;
@@ -124,14 +192,70 @@ static int parse_test_spec(struct test_loader *tester,
 				errno = 0;
 				spec->prog_flags |= strtol(val, &e, 0);
 				if (errno || e[0] != '\0') {
-					ASSERT_FAIL("failed to parse test prog flags from '%s'", s);
-					return -EINVAL;
+					PRINT_FAIL("failed to parse test prog flags from '%s'\n",
+						   val);
+					err = -EINVAL;
+					goto cleanup;
 				}
 			}
 		}
 	}
 
+	if (spec->mode_mask == 0)
+		spec->mode_mask = PRIV;
+
+	if (!description)
+		description = spec->prog_name;
+
+	if (spec->mode_mask & PRIV) {
+		spec->priv.name = strdup(description);
+		if (!spec->priv.name) {
+			PRINT_FAIL("failed to allocate memory for priv.name\n");
+			err = -ENOMEM;
+			goto cleanup;
+		}
+	}
+
+	if (spec->mode_mask & UNPRIV) {
+		int descr_len = strlen(description);
+		const char *suffix = " @unpriv";
+		char *name;
+
+		name = malloc(descr_len + strlen(suffix) + 1);
+		if (!name) {
+			PRINT_FAIL("failed to allocate memory for unpriv.name\n");
+			err = -ENOMEM;
+			goto cleanup;
+		}
+
+		strcpy(name, description);
+		strcpy(&name[descr_len], suffix);
+		spec->unpriv.name = name;
+	}
+
+	if (spec->mode_mask & (PRIV | UNPRIV)) {
+		if (!has_unpriv_result)
+			spec->unpriv.expect_failure = spec->priv.expect_failure;
+
+		if (!spec->unpriv.expect_msgs) {
+			size_t sz = spec->priv.expect_msg_cnt * sizeof(void *);
+
+			spec->unpriv.expect_msgs = malloc(sz);
+			if (!spec->unpriv.expect_msgs) {
+				PRINT_FAIL("failed to allocate memory for unpriv.expect_msgs\n");
+				err = -ENOMEM;
+				goto cleanup;
+			}
+			memcpy(spec->unpriv.expect_msgs, spec->priv.expect_msgs, sz);
+			spec->unpriv.expect_msg_cnt = spec->priv.expect_msg_cnt;
+		}
+	}
+
 	return 0;
+
+cleanup:
+	free_test_spec(spec);
+	return err;
 }
 
 static void prepare_case(struct test_loader *tester,
@@ -148,7 +272,7 @@ static void prepare_case(struct test_loader *tester,
 
 	bpf_program__set_log_buf(prog, tester->log_buf, tester->log_buf_sz);
 
-	/* Make sure we set at least minimal log level, unless test requirest
+	/* Make sure we set at least minimal log level, unless test requires
 	 * even higher level already. Make sure to preserve independent log
 	 * level 4 (verifier stats), though.
 	 */
@@ -172,18 +296,18 @@ static void emit_verifier_log(const char *log_buf, bool force)
 }
 
 static void validate_case(struct test_loader *tester,
-			  struct test_spec *spec,
+			  struct test_subspec *subspec,
 			  struct bpf_object *obj,
 			  struct bpf_program *prog,
 			  int load_err)
 {
 	int i, j;
 
-	for (i = 0; i < spec->expect_msg_cnt; i++) {
+	for (i = 0; i < subspec->expect_msg_cnt; i++) {
 		char *match;
 		const char *expect_msg;
 
-		expect_msg = spec->expect_msgs[i];
+		expect_msg = subspec->expect_msgs[i];
 
 		match = strstr(tester->log_buf + tester->next_match_pos, expect_msg);
 		if (!ASSERT_OK_PTR(match, "expect_msg")) {
@@ -191,7 +315,8 @@ static void validate_case(struct test_loader *tester,
 			if (env.verbosity == VERBOSE_NONE)
 				emit_verifier_log(tester->log_buf, true /*force*/);
 			for (j = 0; j < i; j++)
-				fprintf(stderr, "MATCHED  MSG: '%s'\n", spec->expect_msgs[j]);
+				fprintf(stderr,
+					"MATCHED  MSG: '%s'\n", subspec->expect_msgs[j]);
 			fprintf(stderr, "EXPECTED MSG: '%s'\n", expect_msg);
 			return;
 		}
@@ -200,17 +325,114 @@ static void validate_case(struct test_loader *tester,
 	}
 }
 
+static int set_admin(bool admin)
+{
+	int err;
+
+	if (admin)
+		err = cap_enable_effective(ADMIN_CAPS, NULL);
+	else
+		err = cap_disable_effective(ADMIN_CAPS, NULL);
+
+	if (err)
+		PRINT_FAIL("%s admin privs failed: %i, %s\n",
+			   admin ? "gain" : "drop", err, strerror(err));
+
+	return err;
+}
+
+static bool can_execute_unpriv(struct test_loader *tester, struct test_spec *spec)
+{
+#ifdef CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS
+	bool efficient_unaligned_access = true;
+#else
+	bool efficient_unaligned_access = false;
+#endif
+	if (sysctl_unpriv_disabled < 0)
+		sysctl_unpriv_disabled = get_unpriv_disabled() ? 1 : 0;
+	if (sysctl_unpriv_disabled)
+		return false;
+	if ((spec->prog_flags & BPF_F_ANY_ALIGNMENT) && !efficient_unaligned_access)
+		return false;
+	return true;
+}
+
 /* this function is forced noinline and has short generic name to look better
  * in test_progs output (in case of a failure)
  */
 static noinline
 void run_subtest(struct test_loader *tester,
-		 const char *skel_name,
-		 skel_elf_bytes_fn elf_bytes_factory)
+		 struct bpf_object_open_opts *open_opts,
+		 const void *obj_bytes,
+		 size_t obj_byte_cnt,
+		 struct test_spec *spec,
+		 bool unpriv)
+{
+	struct test_subspec *subspec = unpriv ? &spec->unpriv : &spec->priv;
+	struct bpf_program *tprog;
+	struct bpf_object *tobj;
+	int err;
+
+	if (!test__start_subtest(subspec->name))
+		return;
+
+	if (unpriv && !can_execute_unpriv(tester, spec)) {
+		test__skip();
+		test__end_subtest();
+		return;
+	}
+
+	if (unpriv)
+		set_admin(false);
+
+	tobj = bpf_object__open_mem(obj_bytes, obj_byte_cnt, open_opts);
+	if (!ASSERT_OK_PTR(tobj, "obj_open_mem")) /* shouldn't happen */
+		goto subtest_cleanup;
+
+	bpf_object__for_each_program(tprog, tobj)
+		bpf_program__set_autoload(tprog, false);
+
+	bpf_object__for_each_program(tprog, tobj) {
+		/* only load specified program */
+		if (strcmp(bpf_program__name(tprog), spec->prog_name) == 0) {
+			bpf_program__set_autoload(tprog, true);
+			break;
+		}
+	}
+
+	prepare_case(tester, spec, tobj, tprog);
+
+	err = bpf_object__load(tobj);
+	if (subspec->expect_failure) {
+		if (!ASSERT_ERR(err, "unexpected_load_success")) {
+			emit_verifier_log(tester->log_buf, false /*force*/);
+			goto tobj_cleanup;
+		}
+	} else {
+		if (!ASSERT_OK(err, "unexpected_load_failure")) {
+			emit_verifier_log(tester->log_buf, true /*force*/);
+			goto tobj_cleanup;
+		}
+	}
+
+	emit_verifier_log(tester->log_buf, false /*force*/);
+	validate_case(tester, subspec, tobj, tprog, err);
+
+tobj_cleanup:
+	bpf_object__close(tobj);
+subtest_cleanup:
+	test__end_subtest();
+	if (unpriv)
+		set_admin(true);
+}
+
+static void process_subtest(struct test_loader *tester,
+			    const char *skel_name,
+			    skel_elf_bytes_fn elf_bytes_factory)
 {
 	LIBBPF_OPTS(bpf_object_open_opts, open_opts, .object_name = skel_name);
-	struct bpf_object *obj = NULL, *tobj;
-	struct bpf_program *prog, *tprog;
+	struct bpf_object *obj = NULL;
+	struct bpf_program *prog;
 	const void *obj_bytes;
 	size_t obj_byte_cnt;
 	int err;
@@ -224,52 +446,19 @@ void run_subtest(struct test_loader *tester,
 		return;
 
 	bpf_object__for_each_program(prog, obj) {
-		const char *prog_name = bpf_program__name(prog);
 		struct test_spec spec;
 
-		if (!test__start_subtest(prog_name))
-			continue;
-
 		/* if we can't derive test specification, go to the next test */
 		err = parse_test_spec(tester, obj, prog, &spec);
 		if (!ASSERT_OK(err, "parse_test_spec"))
 			continue;
 
-		tobj = bpf_object__open_mem(obj_bytes, obj_byte_cnt, &open_opts);
-		if (!ASSERT_OK_PTR(tobj, "obj_open_mem")) /* shouldn't happen */
-			continue;
+		if (spec.mode_mask & PRIV)
+			run_subtest(tester, &open_opts, obj_bytes, obj_byte_cnt, &spec, false);
+		if (spec.mode_mask & UNPRIV)
+			run_subtest(tester, &open_opts, obj_bytes, obj_byte_cnt, &spec, true);
 
-		bpf_object__for_each_program(tprog, tobj)
-			bpf_program__set_autoload(tprog, false);
-
-		bpf_object__for_each_program(tprog, tobj) {
-			/* only load specified program */
-			if (strcmp(bpf_program__name(tprog), prog_name) == 0) {
-				bpf_program__set_autoload(tprog, true);
-				break;
-			}
-		}
-
-		prepare_case(tester, &spec, tobj, tprog);
-
-		err = bpf_object__load(tobj);
-		if (spec.expect_failure) {
-			if (!ASSERT_ERR(err, "unexpected_load_success")) {
-				emit_verifier_log(tester->log_buf, false /*force*/);
-				goto tobj_cleanup;
-			}
-		} else {
-			if (!ASSERT_OK(err, "unexpected_load_failure")) {
-				emit_verifier_log(tester->log_buf, true /*force*/);
-				goto tobj_cleanup;
-			}
-		}
-
-		emit_verifier_log(tester->log_buf, false /*force*/);
-		validate_case(tester, &spec, tobj, tprog, err);
-
-tobj_cleanup:
-		bpf_object__close(tobj);
+		free_test_spec(&spec);
 	}
 
 	bpf_object__close(obj);
@@ -280,5 +469,5 @@ void test_loader__run_subtests(struct test_loader *tester,
 			       skel_elf_bytes_fn elf_bytes_factory)
 {
 	/* see comment in run_subtest() for why we do this function nesting */
-	run_subtest(tester, skel_name, elf_bytes_factory);
+	process_subtest(tester, skel_name, elf_bytes_factory);
 }
diff --git a/tools/testing/selftests/bpf/test_verifier.c b/tools/testing/selftests/bpf/test_verifier.c
index 8c808551dfd7..6071dff9c8a1 100644
--- a/tools/testing/selftests/bpf/test_verifier.c
+++ b/tools/testing/selftests/bpf/test_verifier.c
@@ -33,13 +33,8 @@
 #include <bpf/bpf.h>
 #include <bpf/libbpf.h>
 
-#ifdef HAVE_GENHDR
-# include "autoconf.h"
-#else
-# if defined(__i386) || defined(__x86_64) || defined(__s390x__) || defined(__aarch64__)
-#  define CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS 1
-# endif
-#endif
+#include "autoconf_helper.h"
+#include "unpriv_helpers.h"
 #include "cap_helpers.h"
 #include "bpf_rand.h"
 #include "bpf_util.h"
@@ -1665,22 +1660,6 @@ static bool is_admin(void)
 	return (caps & ADMIN_CAPS) == ADMIN_CAPS;
 }
 
-static void get_unpriv_disabled()
-{
-	char buf[2];
-	FILE *fd;
-
-	fd = fopen("/proc/sys/"UNPRIV_SYSCTL, "r");
-	if (!fd) {
-		perror("fopen /proc/sys/"UNPRIV_SYSCTL);
-		unpriv_disabled = true;
-		return;
-	}
-	if (fgets(buf, 2, fd) == buf && atoi(buf))
-		unpriv_disabled = true;
-	fclose(fd);
-}
-
 static bool test_as_unpriv(struct bpf_test *test)
 {
 #ifndef CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS
diff --git a/tools/testing/selftests/bpf/unpriv_helpers.c b/tools/testing/selftests/bpf/unpriv_helpers.c
new file mode 100644
index 000000000000..488371edb3e4
--- /dev/null
+++ b/tools/testing/selftests/bpf/unpriv_helpers.c
@@ -0,0 +1,26 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <stdbool.h>
+#include <stdlib.h>
+#include <error.h>
+#include <stdio.h>
+
+#include "unpriv_helpers.h"
+
+bool get_unpriv_disabled(void)
+{
+	bool disabled;
+	char buf[2];
+	FILE *fd;
+
+	fd = fopen("/proc/sys/"UNPRIV_SYSCTL, "r");
+	if (fd) {
+		disabled = (fgets(buf, 2, fd) == buf && atoi(buf));
+		fclose(fd);
+	} else {
+		perror("fopen /proc/sys/"UNPRIV_SYSCTL);
+		disabled = true;
+	}
+
+	return disabled;
+}
diff --git a/tools/testing/selftests/bpf/unpriv_helpers.h b/tools/testing/selftests/bpf/unpriv_helpers.h
new file mode 100644
index 000000000000..151f67329665
--- /dev/null
+++ b/tools/testing/selftests/bpf/unpriv_helpers.h
@@ -0,0 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <stdbool.h>
+
+#define UNPRIV_SYSCTL "kernel/unprivileged_bpf_disabled"
+
+bool get_unpriv_disabled(void);
-- 
2.39.0

