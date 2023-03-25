Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8AE66C8A60
	for <lists+bpf@lfdr.de>; Sat, 25 Mar 2023 03:56:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231717AbjCYC4G (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 24 Mar 2023 22:56:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231834AbjCYC4D (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 24 Mar 2023 22:56:03 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD1BE1ADEF
        for <bpf@vger.kernel.org>; Fri, 24 Mar 2023 19:55:58 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id p12-20020a05600c468c00b003ef5e6c39cdso995092wmo.3
        for <bpf@vger.kernel.org>; Fri, 24 Mar 2023 19:55:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679712957;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=no5tiMe8RAiGLrqrFISZcfJL1379vMIu+Wm4qWhrt0E=;
        b=QpSMvl1COj3dBh8rLalDP9enUJvsWU8BvmGcpk2dtruidqvuqGBqtsE/1fhvsO+I+t
         0z8P6zNrCPIk7xdAsiFmRUyigoPabcp9UiUYOPrgnjJXY6e9TtL099jmBZGPb3SFLIu7
         p8PIq0dC0rCIc6s8nyhiK8NQD9FG1mQ8jw1tcQe2yxNJLB1sbyS4SUV53F8aV2gUIBMN
         M1lCuRMCzZYLKLjplfq1pmFFNS/pp21U2rC87s9uC/tyfsixpiDYCQZWaHlK2cwf5FLj
         YhB2CJmu5oHPcbUWMRlzyUDhKp5Rpjr7cisVCF6X1gu7yi9EYoOtirNisLbTk52Oml8U
         CLdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679712957;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=no5tiMe8RAiGLrqrFISZcfJL1379vMIu+Wm4qWhrt0E=;
        b=FmCN7SmPSTD0F1B3jOmHtLSRnTILWDChemvPIKP0a3RW3PKlq9/2bu9xG+4JwRtSZf
         FeHBbEUgdsgTxzy4GirwLDndezJeblsz4ULmlpbLCyAauaZSPjhdQH3cJG/HEw37lMNM
         4fRPe72CHTVzu7H2/HVyxbnN7jJWYMv03qRouwsP+XmMWv9EWPDLjRERlehL02K8jtTi
         975asFnErwPTzDnV8wRLC3tURsvtsfE9Ry4wuEUO7N5SNFhcA7cmfVh+f0S6dwQQ7WBD
         v9ja72r2GPQ5nijhjzc6JjChl6HLXFjJ9v4v+l3PP+jMfq6Di8V8pQjFsFt3sV+R3b5u
         bqWw==
X-Gm-Message-State: AO0yUKW/DKRIUQoDRDd6l4cj2JBRM9KYneCBt19j+bn7eoZPlCWYdlUP
        vsZx/TcHh+XzJz6btZ7Vm7e2HiCX8m4=
X-Google-Smtp-Source: AK7set9+LbReAj5AJ/yeyhBxDg4UvhpCthdxqSROPFIjrZ9Yz4GV1sFDN8FFw9vQfjRgJyyGrha3zw==
X-Received: by 2002:a05:600c:280e:b0:3ee:1a8f:8098 with SMTP id m14-20020a05600c280e00b003ee1a8f8098mr3816526wmb.9.1679712956718;
        Fri, 24 Mar 2023 19:55:56 -0700 (PDT)
Received: from bigfoot.. (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id m1-20020a05600c4f4100b003ee1e07a14asm1428724wmq.45.2023.03.24.19.55.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Mar 2023 19:55:55 -0700 (PDT)
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     bpf@vger.kernel.org, ast@kernel.org
Cc:     andrii@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
        kernel-team@fb.com, yhs@fb.com,
        Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next 03/43] selftests/bpf: Unprivileged tests for test_loader.c
Date:   Sat, 25 Mar 2023 04:54:44 +0200
Message-Id: <20230325025524.144043-4-eddyz87@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230325025524.144043-1-eddyz87@gmail.com>
References: <20230325025524.144043-1-eddyz87@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
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
 tools/testing/selftests/bpf/Makefile          |  10 +-
 tools/testing/selftests/bpf/autoconf_helper.h |   9 +
 tools/testing/selftests/bpf/progs/bpf_misc.h  |  25 ++
 tools/testing/selftests/bpf/test_loader.c     | 394 ++++++++++++++----
 tools/testing/selftests/bpf/test_verifier.c   |  25 +-
 tools/testing/selftests/bpf/unpriv_helpers.c  |  26 ++
 tools/testing/selftests/bpf/unpriv_helpers.h  |   7 +
 7 files changed, 395 insertions(+), 101 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/autoconf_helper.h
 create mode 100644 tools/testing/selftests/bpf/unpriv_helpers.c
 create mode 100644 tools/testing/selftests/bpf/unpriv_helpers.h

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index fc092582d16d..4a8ef118fd9d 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -231,8 +231,9 @@ TEST_GEN_PROGS_EXTENDED += $(TRUNNER_BPFTOOL)
 
 $(TEST_GEN_PROGS) $(TEST_GEN_PROGS_EXTENDED): $(BPFOBJ)
 
-CGROUP_HELPERS	:= $(OUTPUT)/cgroup_helpers.o
 TESTING_HELPERS	:= $(OUTPUT)/testing_helpers.o
+CGROUP_HELPERS	:= $(OUTPUT)/cgroup_helpers.o
+UNPRIV_HELPERS  := $(OUTPUT)/unpriv_helpers.o
 TRACE_HELPERS	:= $(OUTPUT)/trace_helpers.o
 JSON_WRITER		:= $(OUTPUT)/json_writer.o
 CAP_HELPERS	:= $(OUTPUT)/cap_helpers.o
@@ -252,7 +253,7 @@ $(OUTPUT)/test_lirc_mode2_user: $(TESTING_HELPERS)
 $(OUTPUT)/xdping: $(TESTING_HELPERS)
 $(OUTPUT)/flow_dissector_load: $(TESTING_HELPERS)
 $(OUTPUT)/test_maps: $(TESTING_HELPERS)
-$(OUTPUT)/test_verifier: $(TESTING_HELPERS) $(CAP_HELPERS)
+$(OUTPUT)/test_verifier: $(TESTING_HELPERS) $(CAP_HELPERS) $(UNPRIV_HELPERS)
 $(OUTPUT)/xsk.o: $(BPFOBJ)
 
 BPFTOOL ?= $(DEFAULT_BPFTOOL)
@@ -560,8 +561,9 @@ TRUNNER_BPF_PROGS_DIR := progs
 TRUNNER_EXTRA_SOURCES := test_progs.c cgroup_helpers.c trace_helpers.c	\
 			 network_helpers.c testing_helpers.c		\
 			 btf_helpers.c flow_dissector_load.h		\
-			 cap_helpers.c test_loader.c xsk.c disasm.c \
-			 json_writer.c
+			 cap_helpers.c test_loader.c xsk.c disasm.c	\
+			 json_writer.c unpriv_helpers.c
+
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
index 8b4681a96f89..9defc217a5bd 100644
--- a/tools/testing/selftests/bpf/progs/bpf_misc.h
+++ b/tools/testing/selftests/bpf/progs/bpf_misc.h
@@ -5,12 +5,33 @@
 /* This set of attributes controls behavior of the
  * test_loader.c:test_loader__run_subtests().
  *
+ * The test_loader sequentially loads each program in a skeleton.
+ * Programs could be loaded in privileged and unprivileged modes.
+ * - __success, __failure, __msg imply privileged mode;
+ * - __success_unpriv, __failure_unpriv, __msg_unpriv imply
+ *   unprivileged mode.
+ * If combination of privileged and unprivileged attributes is present
+ * both modes are used. If none are present privileged mode is implied.
+ *
+ * See test_loader.c:drop_capabilities() for exact set of capabilities
+ * that differ between privileged and unprivileged modes.
+ *
+ * For test filtering purposes the name of the program loaded in
+ * unprivileged mode is derived from the usual program name by adding
+ * `@unpriv' suffix.
+ *
  * __msg             Message expected to be found in the verifier log.
  *                   Multiple __msg attributes could be specified.
+ * __msg_unpriv      Same as __msg but for unprivileged mode.
  *
  * __success         Expect program load success in privileged mode.
+ * __success_unpriv  Expect program load success in unprivileged mode.
  *
  * __failure         Expect program load failure in privileged mode.
+ * __failure_unpriv  Expect program load failure in unprivileged mode.
+ *
+ * __description     Text to be used instead of a program name for display
+ *                   and filtering purposes.
  *
  * __log_level       Log level to use for the program, numeric value expected.
  *
@@ -27,6 +48,10 @@
 #define __msg(msg)		__attribute__((btf_decl_tag("comment:test_expect_msg=" msg)))
 #define __failure		__attribute__((btf_decl_tag("comment:test_expect_failure")))
 #define __success		__attribute__((btf_decl_tag("comment:test_expect_success")))
+#define __description(desc)	__attribute__((btf_decl_tag("comment:test_description=" desc)))
+#define __msg_unpriv(msg)	__attribute__((btf_decl_tag("comment:test_expect_msg_unpriv=" msg)))
+#define __failure_unpriv	__attribute__((btf_decl_tag("comment:test_expect_failure_unpriv")))
+#define __success_unpriv	__attribute__((btf_decl_tag("comment:test_expect_success_unpriv")))
 #define __log_level(lvl)	__attribute__((btf_decl_tag("comment:test_log_level="#lvl)))
 #define __flag(flag)		__attribute__((btf_decl_tag("comment:test_prog_flags="#flag)))
 
diff --git a/tools/testing/selftests/bpf/test_loader.c b/tools/testing/selftests/bpf/test_loader.c
index 8ca5121b5329..41cddb303885 100644
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
 
@@ -12,16 +17,40 @@
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
+#ifdef CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS
+#define EFFICIENT_UNALIGNED_ACCESS 1
+#else
+#define EFFICIENT_UNALIGNED_ACCESS 0
+#endif
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
@@ -44,17 +73,46 @@ void test_loader_fini(struct test_loader *tester)
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
@@ -62,15 +120,15 @@ static int parse_test_spec(struct test_loader *tester,
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
@@ -81,30 +139,42 @@ static int parse_test_spec(struct test_loader *tester,
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
@@ -124,14 +194,70 @@ static int parse_test_spec(struct test_loader *tester,
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
@@ -148,7 +274,7 @@ static void prepare_case(struct test_loader *tester,
 
 	bpf_program__set_log_buf(prog, tester->log_buf, tester->log_buf_sz);
 
-	/* Make sure we set at least minimal log level, unless test requirest
+	/* Make sure we set at least minimal log level, unless test requires
 	 * even higher level already. Make sure to preserve independent log
 	 * level 4 (verifier stats), though.
 	 */
@@ -172,18 +298,18 @@ static void emit_verifier_log(const char *log_buf, bool force)
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
@@ -191,7 +317,8 @@ static void validate_case(struct test_loader *tester,
 			if (env.verbosity == VERBOSE_NONE)
 				emit_verifier_log(tester->log_buf, true /*force*/);
 			for (j = 0; j < i; j++)
-				fprintf(stderr, "MATCHED  MSG: '%s'\n", spec->expect_msgs[j]);
+				fprintf(stderr,
+					"MATCHED  MSG: '%s'\n", subspec->expect_msgs[j]);
 			fprintf(stderr, "EXPECTED MSG: '%s'\n", expect_msg);
 			return;
 		}
@@ -200,17 +327,169 @@ static void validate_case(struct test_loader *tester,
 	}
 }
 
+struct cap_state {
+	__u64 old_caps;
+	bool initialized;
+};
+
+static int drop_capabilities(struct cap_state *caps)
+{
+	const __u64 caps_to_drop = (1ULL << CAP_SYS_ADMIN | 1ULL << CAP_NET_ADMIN |
+				    1ULL << CAP_PERFMON   | 1ULL << CAP_BPF);
+	int err;
+
+	err = cap_disable_effective(caps_to_drop, &caps->old_caps);
+	if (err) {
+		PRINT_FAIL("failed to drop capabilities: %i, %s\n", err, strerror(err));
+		return err;
+	}
+
+	caps->initialized = true;
+	return 0;
+}
+
+static int restore_capabilities(struct cap_state *caps)
+{
+	int err;
+
+	if (!caps->initialized)
+		return 0;
+
+	err = cap_enable_effective(caps->old_caps, NULL);
+	if (err)
+		PRINT_FAIL("failed to restore capabilities: %i, %s\n", err, strerror(err));
+	caps->initialized = false;
+	return err;
+}
+
+static bool can_execute_unpriv(struct test_loader *tester, struct test_spec *spec)
+{
+	if (sysctl_unpriv_disabled < 0)
+		sysctl_unpriv_disabled = get_unpriv_disabled() ? 1 : 0;
+	if (sysctl_unpriv_disabled)
+		return false;
+	if ((spec->prog_flags & BPF_F_ANY_ALIGNMENT) && !EFFICIENT_UNALIGNED_ACCESS)
+		return false;
+	return true;
+}
+
+static bool is_unpriv_capable_map(struct bpf_map *map)
+{
+	enum bpf_map_type type;
+	__u32 flags;
+
+	type = bpf_map__type(map);
+
+	switch (type) {
+	case BPF_MAP_TYPE_HASH:
+	case BPF_MAP_TYPE_PERCPU_HASH:
+	case BPF_MAP_TYPE_HASH_OF_MAPS:
+		flags = bpf_map__map_flags(map);
+		return !(flags & BPF_F_ZERO_SEED);
+	case BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE:
+	case BPF_MAP_TYPE_ARRAY:
+	case BPF_MAP_TYPE_RINGBUF:
+	case BPF_MAP_TYPE_PROG_ARRAY:
+	case BPF_MAP_TYPE_CGROUP_ARRAY:
+	case BPF_MAP_TYPE_PERCPU_ARRAY:
+	case BPF_MAP_TYPE_USER_RINGBUF:
+	case BPF_MAP_TYPE_ARRAY_OF_MAPS:
+	case BPF_MAP_TYPE_CGROUP_STORAGE:
+	case BPF_MAP_TYPE_PERF_EVENT_ARRAY:
+		return true;
+	default:
+		return false;
+	}
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
+	struct cap_state caps = {};
+	struct bpf_program *tprog;
+	struct bpf_object *tobj;
+	struct bpf_map *map;
+	int err;
+
+	if (!test__start_subtest(subspec->name))
+		return;
+
+	if (unpriv) {
+		if (!can_execute_unpriv(tester, spec)) {
+			test__skip();
+			test__end_subtest();
+			return;
+		}
+		if (drop_capabilities(&caps)) {
+			test__end_subtest();
+			return;
+		}
+	}
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
+	/* By default bpf_object__load() automatically creates all
+	 * maps declared in the skeleton. Some map types are only
+	 * allowed in priv mode. Disable autoload for such maps in
+	 * unpriv mode.
+	 */
+	bpf_object__for_each_map(map, tobj)
+		bpf_map__set_autocreate(map, !unpriv || is_unpriv_capable_map(map));
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
+	restore_capabilities(&caps);
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
@@ -224,12 +503,8 @@ void run_subtest(struct test_loader *tester,
 		return;
 
 	bpf_object__for_each_program(prog, obj) {
-		const char *prog_name = bpf_program__name(prog);
 		struct test_spec spec;
 
-		if (!test__start_subtest(prog_name))
-			continue;
-
 		/* if we can't derive test specification, go to the next test */
 		err = parse_test_spec(tester, obj, prog, &spec);
 		if (err) {
@@ -238,41 +513,12 @@ void run_subtest(struct test_loader *tester,
 			continue;
 		}
 
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
@@ -283,5 +529,5 @@ void test_loader__run_subtests(struct test_loader *tester,
 			       skel_elf_bytes_fn elf_bytes_factory)
 {
 	/* see comment in run_subtest() for why we do this function nesting */
-	run_subtest(tester, skel_name, elf_bytes_factory);
+	process_subtest(tester, skel_name, elf_bytes_factory);
 }
diff --git a/tools/testing/selftests/bpf/test_verifier.c b/tools/testing/selftests/bpf/test_verifier.c
index 49a70d9beb0b..5b90eef09ade 100644
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
index 000000000000..2a6efbd0401e
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
+	fd = fopen("/proc/sys/" UNPRIV_SYSCTL, "r");
+	if (fd) {
+		disabled = (fgets(buf, 2, fd) == buf && atoi(buf));
+		fclose(fd);
+	} else {
+		perror("fopen /proc/sys/" UNPRIV_SYSCTL);
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
2.40.0

