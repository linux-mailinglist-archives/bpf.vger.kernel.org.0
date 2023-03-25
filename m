Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C80D6C8A5F
	for <lists+bpf@lfdr.de>; Sat, 25 Mar 2023 03:56:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231636AbjCYC4F (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 24 Mar 2023 22:56:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231717AbjCYC4C (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 24 Mar 2023 22:56:02 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A332193F4
        for <bpf@vger.kernel.org>; Fri, 24 Mar 2023 19:56:00 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id y14so3511664wrq.4
        for <bpf@vger.kernel.org>; Fri, 24 Mar 2023 19:56:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679712958;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C5uip3DXOW8JXzmGHwX7jqqvDWoRtw0nEAMW1MtJlwI=;
        b=hVBC+CNomDV8t7RPaQEEgCpldOi1+aWzmh5fM4iIdhD6PpyQv3AkRtqLobiHDso86a
         PzDSNwEtYFwuBEBmi8r5LXH46swjtsuj01w5Z4dLJWw6epjnMm4Mc4Dhh6EpLvJTGlSB
         x1uiyTFV1GMinW/tTr/zXZhFa43lkks3fQ6uUU+rxT0j5CW4BQCh/Y80DqHvOkDabg97
         gwHe/owB9TvFTDLgx3Sy9W7lrpZDdiIrWcYkzr5bilWvfvcNS+MnBbl487mkY6MJD6y2
         xFzSNE5viyX+xnL1ZG/A00LVPN5xGrj0DU9KG14yy181NDLKMVnYLleA9k20O3lUiS+i
         SK5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679712958;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C5uip3DXOW8JXzmGHwX7jqqvDWoRtw0nEAMW1MtJlwI=;
        b=oJl3xCk1S2CtGZGbii4g14lOgHfFKjD25RDHz+QhPFtBXouWEYJTMOiHVN69P4nHpA
         Xad8I3Go+XSSgcpBow7s9wZI4zY1Y7zSdrjPuVl4KkElRPcH9BoU+Vm4Nu0RQpWH2l9A
         CzVAOjdoEKIdnwMbSfJJbw/SI5Gx5bmJxoyXtjwif/8SbeGAr6piTKW8B2Xssf0UEGuF
         iVbsP/k7eUbdQrpPby3nkj1Hqq7tiUrOdb+ERn/Tfa3dr8iNcw0K3gns5BUZNR5EWPVs
         CPyztYvSDKXnAKY4K8ZYeqn0pKI4duz7XIVAh0bOsNG/rgORqDpIP1AkcMLbSKvx5RmG
         qhHA==
X-Gm-Message-State: AAQBX9dQmIOiGQ8fT5KzAHbmjwhCOd1NSbCed5XNNR4YYOfkTGIGsTVA
        m6NcXLuIaqN+71fsGtCeUpo5v/jkrXE=
X-Google-Smtp-Source: AKy350YqEFoquA5YPmdk8J6JxYxvf09mZx5DnxPB7Kwi0wNYVtxkCBxkbiAShaFX2hbINi+zYZl4XA==
X-Received: by 2002:a5d:4a4d:0:b0:2d4:d74d:fc83 with SMTP id v13-20020a5d4a4d000000b002d4d74dfc83mr3709916wrs.25.1679712958478;
        Fri, 24 Mar 2023 19:55:58 -0700 (PDT)
Received: from bigfoot.. (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id m1-20020a05600c4f4100b003ee1e07a14asm1428724wmq.45.2023.03.24.19.55.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Mar 2023 19:55:57 -0700 (PDT)
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     bpf@vger.kernel.org, ast@kernel.org
Cc:     andrii@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
        kernel-team@fb.com, yhs@fb.com,
        Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next 04/43] selftests/bpf: Tests execution support for test_loader.c
Date:   Sat, 25 Mar 2023 04:54:45 +0200
Message-Id: <20230325025524.144043-5-eddyz87@gmail.com>
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
execute BPF_PROG_TEST_RUN bpf command for selected programs.
This is similar to functionality provided by test_verifier.

Adds the following new attributes controlling test_loader behavior:

  __retval(...)
  __retval_unpriv(...)

* If any of these attributes is present, the annotated program would
  be executed using libbpf's bpf_prog_test_run_opts() function.
* If __retval is present, the test run would be done for program
  loaded in privileged mode.
* If __retval_unpriv is present, the test run would be done for
  program loaded in unprivileged mode.
* To mimic test_verifier behavior, the actual run is initiated in
  privileged mode.
* The value returned by a test run is compared against retval
  parameter.

The retval attribute takes one of the following parameters:
- a decimal number
- a hexadecimal number (must start from '0x')
- any of a three special literals (provided for compatibility with
  test_verifier):
  - INT_MIN
  - POINTER_VALUE
  - TEST_DATA_LEN

An example of the attribute usage:

  SEC("socket")
  __description("return 42")
  __success __success_unpriv __retval(42)
  __naked void the_42_test(void)
  {
          asm volatile ("                                 \
          r0 = 42;                                        \
          exit;                                           \
  "       ::: __clobber_all);
  }

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 tools/testing/selftests/bpf/progs/bpf_misc.h |  15 ++
 tools/testing/selftests/bpf/test_loader.c    | 149 +++++++++++++++++--
 2 files changed, 150 insertions(+), 14 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/bpf_misc.h b/tools/testing/selftests/bpf/progs/bpf_misc.h
index 9defc217a5bd..6e3b4903c541 100644
--- a/tools/testing/selftests/bpf/progs/bpf_misc.h
+++ b/tools/testing/selftests/bpf/progs/bpf_misc.h
@@ -30,6 +30,15 @@
  * __failure         Expect program load failure in privileged mode.
  * __failure_unpriv  Expect program load failure in unprivileged mode.
  *
+ * __retval          Execute the program using BPF_PROG_TEST_RUN command,
+ *                   expect return value to match passed parameter:
+ *                   - a decimal number
+ *                   - a hexadecimal number, when starts from 0x
+ *                   - literal INT_MIN
+ *                   - literal POINTER_VALUE (see definition below)
+ *                   - literal TEST_DATA_LEN (see definition below)
+ * __retval_unpriv   Same, but load program in unprivileged mode.
+ *
  * __description     Text to be used instead of a program name for display
  *                   and filtering purposes.
  *
@@ -54,6 +63,8 @@
 #define __success_unpriv	__attribute__((btf_decl_tag("comment:test_expect_success_unpriv")))
 #define __log_level(lvl)	__attribute__((btf_decl_tag("comment:test_log_level="#lvl)))
 #define __flag(flag)		__attribute__((btf_decl_tag("comment:test_prog_flags="#flag)))
+#define __retval(val)		__attribute__((btf_decl_tag("comment:test_retval="#val)))
+#define __retval_unpriv(val)	__attribute__((btf_decl_tag("comment:test_retval_unpriv="#val)))
 
 /* Convenience macro for use with 'asm volatile' blocks */
 #define __naked __attribute__((naked))
@@ -65,6 +76,10 @@
 #define __imm_ptr(name) [name]"p"(&name)
 #define __imm_insn(name, expr) [name]"i"(*(long *)&(expr))
 
+/* Magic constants used with __retval() */
+#define POINTER_VALUE	0xcafe4all
+#define TEST_DATA_LEN	64
+
 #if defined(__TARGET_ARCH_x86)
 #define SYSCALL_WRAPPER 1
 #define SYS_PREFIX "__x64_"
diff --git a/tools/testing/selftests/bpf/test_loader.c b/tools/testing/selftests/bpf/test_loader.c
index 41cddb303885..47e9e076bc8f 100644
--- a/tools/testing/selftests/bpf/test_loader.c
+++ b/tools/testing/selftests/bpf/test_loader.c
@@ -23,6 +23,12 @@
 #define TEST_TAG_LOG_LEVEL_PFX "comment:test_log_level="
 #define TEST_TAG_PROG_FLAGS_PFX "comment:test_prog_flags="
 #define TEST_TAG_DESCRIPTION_PFX "comment:test_description="
+#define TEST_TAG_RETVAL_PFX "comment:test_retval="
+#define TEST_TAG_RETVAL_PFX_UNPRIV "comment:test_retval_unpriv="
+
+/* Warning: duplicated in bpf_misc.h */
+#define POINTER_VALUE	0xcafe4all
+#define TEST_DATA_LEN	64
 
 #ifdef CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS
 #define EFFICIENT_UNALIGNED_ACCESS 1
@@ -42,6 +48,8 @@ struct test_subspec {
 	bool expect_failure;
 	const char **expect_msgs;
 	size_t expect_msg_cnt;
+	int retval;
+	bool execute;
 };
 
 struct test_spec {
@@ -96,6 +104,46 @@ static int push_msg(const char *msg, struct test_subspec *subspec)
 	return 0;
 }
 
+static int parse_int(const char *str, int *val, const char *name)
+{
+	char *end;
+	long tmp;
+
+	errno = 0;
+	if (str_has_pfx(str, "0x"))
+		tmp = strtol(str + 2, &end, 16);
+	else
+		tmp = strtol(str, &end, 10);
+	if (errno || end[0] != '\0') {
+		PRINT_FAIL("failed to parse %s from '%s'\n", name, str);
+		return -EINVAL;
+	}
+	*val = tmp;
+	return 0;
+}
+
+static int parse_retval(const char *str, int *val, const char *name)
+{
+	struct {
+		char *name;
+		int val;
+	} named_values[] = {
+		{ "INT_MIN"      , INT_MIN },
+		{ "POINTER_VALUE", POINTER_VALUE },
+		{ "TEST_DATA_LEN", TEST_DATA_LEN },
+	};
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(named_values); ++i) {
+		if (strcmp(str, named_values[i].name) != 0)
+			continue;
+		*val = named_values[i].val;
+		return 0;
+	}
+
+	return parse_int(str, val, name);
+}
+
 /* Uses btf_decl_tag attributes to describe the expected test
  * behavior, see bpf_misc.h for detailed description of each attribute
  * and attribute combinations.
@@ -107,6 +155,7 @@ static int parse_test_spec(struct test_loader *tester,
 {
 	const char *description = NULL;
 	bool has_unpriv_result = false;
+	bool has_unpriv_retval = false;
 	int func_id, i, err = 0;
 	struct btf *btf;
 
@@ -129,7 +178,7 @@ static int parse_test_spec(struct test_loader *tester,
 	for (i = 1; i < btf__type_cnt(btf); i++) {
 		const char *s, *val, *msg;
 		const struct btf_type *t;
-		char *e;
+		int tmp;
 
 		t = btf__type_by_id(btf, i);
 		if (!btf_is_decl_tag(t))
@@ -167,15 +216,26 @@ static int parse_test_spec(struct test_loader *tester,
 			if (err)
 				goto cleanup;
 			spec->mode_mask |= UNPRIV;
+		} else if (str_has_pfx(s, TEST_TAG_RETVAL_PFX)) {
+			val = s + sizeof(TEST_TAG_RETVAL_PFX) - 1;
+			err = parse_retval(val, &spec->priv.retval, "__retval");
+			if (err)
+				goto cleanup;
+			spec->priv.execute = true;
+			spec->mode_mask |= PRIV;
+		} else if (str_has_pfx(s, TEST_TAG_RETVAL_PFX_UNPRIV)) {
+			val = s + sizeof(TEST_TAG_RETVAL_PFX_UNPRIV) - 1;
+			err = parse_retval(val, &spec->unpriv.retval, "__retval_unpriv");
+			if (err)
+				goto cleanup;
+			spec->mode_mask |= UNPRIV;
+			spec->unpriv.execute = true;
+			has_unpriv_retval = true;
 		} else if (str_has_pfx(s, TEST_TAG_LOG_LEVEL_PFX)) {
 			val = s + sizeof(TEST_TAG_LOG_LEVEL_PFX) - 1;
-			errno = 0;
-			spec->log_level = strtol(val, &e, 0);
-			if (errno || e[0] != '\0') {
-				PRINT_FAIL("failed to parse test log level from '%s'\n", s);
-				err = -EINVAL;
+			err = parse_int(val, &spec->log_level, "test log level");
+			if (err)
 				goto cleanup;
-			}
 		} else if (str_has_pfx(s, TEST_TAG_PROG_FLAGS_PFX)) {
 			val = s + sizeof(TEST_TAG_PROG_FLAGS_PFX) - 1;
 			if (strcmp(val, "BPF_F_STRICT_ALIGNMENT") == 0) {
@@ -191,14 +251,10 @@ static int parse_test_spec(struct test_loader *tester,
 			} else if (strcmp(val, "BPF_F_XDP_HAS_FRAGS") == 0) {
 				spec->prog_flags |= BPF_F_XDP_HAS_FRAGS;
 			} else /* assume numeric value */ {
-				errno = 0;
-				spec->prog_flags |= strtol(val, &e, 0);
-				if (errno || e[0] != '\0') {
-					PRINT_FAIL("failed to parse test prog flags from '%s'\n",
-						   val);
-					err = -EINVAL;
+				err = parse_int(val, &tmp, "test prog flags");
+				if (err)
 					goto cleanup;
-				}
+				spec->prog_flags |= tmp;
 			}
 		}
 	}
@@ -239,6 +295,11 @@ static int parse_test_spec(struct test_loader *tester,
 		if (!has_unpriv_result)
 			spec->unpriv.expect_failure = spec->priv.expect_failure;
 
+		if (!has_unpriv_retval) {
+			spec->unpriv.retval = spec->priv.retval;
+			spec->unpriv.execute = spec->priv.execute;
+		}
+
 		if (!spec->unpriv.expect_msgs) {
 			size_t sz = spec->priv.expect_msg_cnt * sizeof(void *);
 
@@ -402,6 +463,51 @@ static bool is_unpriv_capable_map(struct bpf_map *map)
 	}
 }
 
+static int do_prog_test_run(int fd_prog, int *retval)
+{
+	__u8 tmp_out[TEST_DATA_LEN << 2] = {};
+	__u8 tmp_in[TEST_DATA_LEN] = {};
+	int err, saved_errno;
+	LIBBPF_OPTS(bpf_test_run_opts, topts,
+		.data_in = tmp_in,
+		.data_size_in = sizeof(tmp_in),
+		.data_out = tmp_out,
+		.data_size_out = sizeof(tmp_out),
+		.repeat = 1,
+	);
+
+	err = bpf_prog_test_run_opts(fd_prog, &topts);
+	saved_errno = errno;
+
+	if (err) {
+		PRINT_FAIL("FAIL: Unexpected bpf_prog_test_run error: %d (%s) ",
+			   saved_errno, strerror(saved_errno));
+		return err;
+	}
+
+	ASSERT_OK(0, "bpf_prog_test_run");
+	*retval = topts.retval;
+
+	return 0;
+}
+
+static bool should_do_test_run(struct test_spec *spec, struct test_subspec *subspec)
+{
+	if (!subspec->execute)
+		return false;
+
+	if (subspec->expect_failure)
+		return false;
+
+	if ((spec->prog_flags & BPF_F_ANY_ALIGNMENT) && !EFFICIENT_UNALIGNED_ACCESS) {
+		if (env.verbosity != VERBOSE_NONE)
+			printf("alignment prevents execution\n");
+		return false;
+	}
+
+	return true;
+}
+
 /* this function is forced noinline and has short generic name to look better
  * in test_progs output (in case of a failure)
  */
@@ -418,6 +524,7 @@ void run_subtest(struct test_loader *tester,
 	struct bpf_program *tprog;
 	struct bpf_object *tobj;
 	struct bpf_map *map;
+	int retval;
 	int err;
 
 	if (!test__start_subtest(subspec->name))
@@ -476,6 +583,20 @@ void run_subtest(struct test_loader *tester,
 	emit_verifier_log(tester->log_buf, false /*force*/);
 	validate_case(tester, subspec, tobj, tprog, err);
 
+	if (should_do_test_run(spec, subspec)) {
+		/* For some reason test_verifier executes programs
+		 * with all capabilities restored. Do the same here.
+		 */
+		if (!restore_capabilities(&caps))
+			goto tobj_cleanup;
+
+		do_prog_test_run(bpf_program__fd(tprog), &retval);
+		if (retval != subspec->retval && subspec->retval != POINTER_VALUE) {
+			PRINT_FAIL("Unexpected retval: %d != %d\n", retval, subspec->retval);
+			goto tobj_cleanup;
+		}
+	}
+
 tobj_cleanup:
 	bpf_object__close(tobj);
 subtest_cleanup:
-- 
2.40.0

