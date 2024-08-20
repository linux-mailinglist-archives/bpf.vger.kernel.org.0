Return-Path: <bpf+bounces-37622-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B8D8958460
	for <lists+bpf@lfdr.de>; Tue, 20 Aug 2024 12:26:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9FD1D1C24D99
	for <lists+bpf@lfdr.de>; Tue, 20 Aug 2024 10:26:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A0E618FC78;
	Tue, 20 Aug 2024 10:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fydh+fmG"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4793E18E75A
	for <bpf@vger.kernel.org>; Tue, 20 Aug 2024 10:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724149461; cv=none; b=B3q48LL3gloB8ZvuesbHdA5WKD04LsIXPAfc3W9iWo6Uy+4z00Z/crK/rXq0GIqiFpARjNAQ6LDht/5XYQpxLr9ku9jHElMUBXzZwSfSrTgx6GxUOT3mBKuKJLo+9Z9QDacmQ3VvHSMS05KYCXMH72D1JkxyNqk7z2DBX8fkKlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724149461; c=relaxed/simple;
	bh=xZlgOuNnxg5f5PtTcqSql3S4mmieuH2eyfgKm9j6AuA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DfHngbOwhE6zSoIcDbqhXnjJ1811wFl8kPXspo3ru0NE/unmPkJqRMvLrmoI8o5yj7IJnrORWuN8y0NjAMF0YBOUAqfQ3+CfOeoN5cSdjaHIVpZO1GHHy9SInKdRjAp2mFtj8DBlf2MFUBfGo10lkWN9CwFijDg0+Ni9eUH/wFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fydh+fmG; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-6c5bcb8e8edso3862450a12.2
        for <bpf@vger.kernel.org>; Tue, 20 Aug 2024 03:24:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724149458; x=1724754258; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3I587T14MUg+cH3UjNZ+l/VjKeN+yqEGyZSe5s22Tik=;
        b=Fydh+fmG/XnMyr2WD0EFLV2C+CL+nJlVTYLoap9q5LxPE3fKE+f7eNrQ9/XmdrFb4b
         V9GSWYBTKP72dpklMhWuTvRrJxzJuxFwanmjbkZfOTduSNjF2Ioy550D2QFam8AxY0cH
         stJ/f9K7Lpx/8cijseNENkai4CJuPZAJJF66tjsT/V18LEP+KfMrFu0FvzsCN5x490f4
         b7Anq91xbZS82ySybJ/Q9MUkF3hWl4FRmjIXJv+bFHCd8tr0xW1j2Dj427gWWSZGpETR
         KFdHUImPdiSbXHkPHxYMoczbBiD04386HIFhZi+KbIP2cxRxEPVxQx0itRLAbA7fvPFW
         g0RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724149458; x=1724754258;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3I587T14MUg+cH3UjNZ+l/VjKeN+yqEGyZSe5s22Tik=;
        b=GzGL2fvCth7eyx2lkD+8bh2fRtdXamETt6WKcJT+7Z7+xyCRFZ0QbzqEizIzmcA+Zc
         4bkL9YmEFWpTsu9KkkDgJLtxJtdDTouZPFfapLVvk4XiPBPrbmI4qLcDBn5x4YL1cL8n
         /vPjOTIdJ9Sr8ND+r6ql2wSj3f8uy17+GNH2WHFgJRBucYiqQrpYFKq9Ip6VakuqOC/X
         keio+zjr3+3645TkFA+JF1N4dbxAQ/2qnI5IHsVMr3k8bapQxWoVfSt4IgUmmeJaOrls
         uWDi6IEQaLraczcOEmw3VkA4ICM6ifuAweyZrp4cMMa6BD9f9bzCmLua88XeNBfNS/16
         RLwA==
X-Gm-Message-State: AOJu0YxICnfwjnhCrdVi6JEybJsJjzrjdNFt9+ci/wiN0uIzsAI5ur4z
	kEaqeUWsFtQahjrjFzIN/1MxX91YsxqrU15kmGePIe3gdJzXAiDBIKRYVpI9
X-Google-Smtp-Source: AGHT+IHLV8xuQNstegMR9CbWuoz/Ptrg3wSz2umamZBbLQVBx7fd/OmIlEr6OBg+VSAjCCYiTKaL5A==
X-Received: by 2002:a17:90a:ca89:b0:2c9:754d:2cba with SMTP id 98e67ed59e1d1-2d3dfc2aa3amr15483959a91.3.1724149458170;
        Tue, 20 Aug 2024 03:24:18 -0700 (PDT)
Received: from honey-badger.. ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d3e3174bfdsm8976166a91.27.2024.08.20.03.24.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2024 03:24:17 -0700 (PDT)
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
Subject: [PATCH bpf-next v3 6/8] selftests/bpf: __jited test tag to check disassembly after jit
Date: Tue, 20 Aug 2024 03:23:54 -0700
Message-ID: <20240820102357.3372779-7-eddyz87@gmail.com>
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

Allow to verify jit behaviour by writing tests as below:

    SEC("tp")
    __arch_x86_64
    __jited("   endbr64")
    __jited("   nopl    (%rax,%rax)")
    __jited("   xorq    %rax, %rax")
    ...
    __naked void some_test(void)
    {
        asm volatile (... ::: __clobber_all);
    }

Allow regular expressions in patterns, same way as in __msg.
By default assume that each __jited pattern has to be matched on the
next consecutive line of the disassembly, e.g.:

    __jited("   endbr64")             # matched on line N
    __jited("   nopl    (%rax,%rax)") # matched on line N+1

If match occurs on a wrong line an error is reported.
To override this behaviour use __jited("..."), e.g.:

    __jited("   endbr64")             # matched on line N
    __jited("...")                    # not matched
    __jited("   nopl    (%rax,%rax)") # matched on any line >= N

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 tools/testing/selftests/bpf/progs/bpf_misc.h |  35 +++++
 tools/testing/selftests/bpf/test_loader.c    | 149 ++++++++++++++++---
 2 files changed, 161 insertions(+), 23 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/bpf_misc.h b/tools/testing/selftests/bpf/progs/bpf_misc.h
index cc3ef20a6490..eccaf955e394 100644
--- a/tools/testing/selftests/bpf/progs/bpf_misc.h
+++ b/tools/testing/selftests/bpf/progs/bpf_misc.h
@@ -36,6 +36,39 @@
  *                   Regular expressions could be specified same way as in __msg.
  * __xlated_unpriv   Same as __xlated but for unprivileged mode.
  *
+ * __jited           Match a line in a disassembly of the jited BPF program.
+ *                   Has to be used after __arch_* macro.
+ *                   For example:
+ *
+ *                       __arch_x86_64
+ *                       __jited("   endbr64")
+ *                       __jited("   nopl    (%rax,%rax)")
+ *                       __jited("   xorq    %rax, %rax")
+ *                       ...
+ *                       __naked void some_test(void)
+ *                       {
+ *                           asm volatile (... ::: __clobber_all);
+ *                       }
+ *
+ *                   Regular expressions could be included in patterns same way
+ *                   as in __msg.
+ *
+ *                   By default assume that each pattern has to be matched on the
+ *                   next consecutive line of disassembly, e.g.:
+ *
+ *                       __jited("   endbr64")             # matched on line N
+ *                       __jited("   nopl    (%rax,%rax)") # matched on line N+1
+ *
+ *                   If match occurs on a wrong line an error is reported.
+ *                   To override this behaviour use literal "...", e.g.:
+ *
+ *                       __jited("   endbr64")             # matched on line N
+ *                       __jited("...")                    # not matched
+ *                       __jited("   nopl    (%rax,%rax)") # matched on any line >= N
+ *
+ * __jited_unpriv    Same as __jited but for unprivileged mode.
+ *
+ *
  * __success         Expect program load success in privileged mode.
  * __success_unpriv  Expect program load success in unprivileged mode.
  *
@@ -76,11 +109,13 @@
  */
 #define __msg(msg)		__attribute__((btf_decl_tag("comment:test_expect_msg=" XSTR(__COUNTER__) "=" msg)))
 #define __xlated(msg)		__attribute__((btf_decl_tag("comment:test_expect_xlated=" XSTR(__COUNTER__) "=" msg)))
+#define __jited(msg)		__attribute__((btf_decl_tag("comment:test_jited=" XSTR(__COUNTER__) "=" msg)))
 #define __failure		__attribute__((btf_decl_tag("comment:test_expect_failure")))
 #define __success		__attribute__((btf_decl_tag("comment:test_expect_success")))
 #define __description(desc)	__attribute__((btf_decl_tag("comment:test_description=" desc)))
 #define __msg_unpriv(msg)	__attribute__((btf_decl_tag("comment:test_expect_msg_unpriv=" XSTR(__COUNTER__) "=" msg)))
 #define __xlated_unpriv(msg)	__attribute__((btf_decl_tag("comment:test_expect_xlated_unpriv=" XSTR(__COUNTER__) "=" msg)))
+#define __jited_unpriv(msg)	__attribute__((btf_decl_tag("comment:test_jited=" XSTR(__COUNTER__) "=" msg)))
 #define __failure_unpriv	__attribute__((btf_decl_tag("comment:test_expect_failure_unpriv")))
 #define __success_unpriv	__attribute__((btf_decl_tag("comment:test_expect_success_unpriv")))
 #define __log_level(lvl)	__attribute__((btf_decl_tag("comment:test_log_level="#lvl)))
diff --git a/tools/testing/selftests/bpf/test_loader.c b/tools/testing/selftests/bpf/test_loader.c
index b0d7158e00c1..d588c612ac03 100644
--- a/tools/testing/selftests/bpf/test_loader.c
+++ b/tools/testing/selftests/bpf/test_loader.c
@@ -10,6 +10,7 @@
 #include "disasm_helpers.h"
 #include "unpriv_helpers.h"
 #include "cap_helpers.h"
+#include "jit_disasm_helpers.h"
 
 #define str_has_pfx(str, pfx) \
 	(strncmp(str, pfx, __builtin_constant_p(pfx) ? sizeof(pfx) - 1 : strlen(pfx)) == 0)
@@ -33,6 +34,8 @@
 #define TEST_TAG_AUXILIARY_UNPRIV "comment:test_auxiliary_unpriv"
 #define TEST_BTF_PATH "comment:test_btf_path="
 #define TEST_TAG_ARCH "comment:test_arch="
+#define TEST_TAG_JITED_PFX "comment:test_jited="
+#define TEST_TAG_JITED_PFX_UNPRIV "comment:test_jited_unpriv="
 
 /* Warning: duplicated in bpf_misc.h */
 #define POINTER_VALUE	0xcafe4all
@@ -68,6 +71,7 @@ struct test_subspec {
 	bool expect_failure;
 	struct expected_msgs expect_msgs;
 	struct expected_msgs expect_xlated;
+	struct expected_msgs jited;
 	int retval;
 	bool execute;
 };
@@ -124,6 +128,8 @@ static void free_test_spec(struct test_spec *spec)
 	free_msgs(&spec->unpriv.expect_msgs);
 	free_msgs(&spec->priv.expect_xlated);
 	free_msgs(&spec->unpriv.expect_xlated);
+	free_msgs(&spec->priv.jited);
+	free_msgs(&spec->unpriv.jited);
 
 	free(spec->priv.name);
 	free(spec->unpriv.name);
@@ -237,6 +243,21 @@ static int push_msg(const char *substr, struct expected_msgs *msgs)
 	return __push_msg(substr, false, msgs);
 }
 
+static int push_disasm_msg(const char *regex_str, bool *on_next_line, struct expected_msgs *msgs)
+{
+	int err;
+
+	if (strcmp(regex_str, "...") == 0) {
+		*on_next_line = false;
+		return 0;
+	}
+	err = __push_msg(regex_str, *on_next_line, msgs);
+	if (err)
+		return err;
+	*on_next_line = true;
+	return 0;
+}
+
 static int parse_int(const char *str, int *val, const char *name)
 {
 	char *end;
@@ -320,6 +341,18 @@ enum arch {
 	ARCH_RISCV64	= 0x4,
 };
 
+static int get_current_arch(void)
+{
+#if defined(__x86_64__)
+	return ARCH_X86_64;
+#elif defined(__aarch64__)
+	return ARCH_ARM64;
+#elif defined(__riscv) && __riscv_xlen == 64
+	return ARCH_RISCV64;
+#endif
+	return 0;
+}
+
 /* Uses btf_decl_tag attributes to describe the expected test
  * behavior, see bpf_misc.h for detailed description of each attribute
  * and attribute combinations.
@@ -332,9 +365,13 @@ static int parse_test_spec(struct test_loader *tester,
 	const char *description = NULL;
 	bool has_unpriv_result = false;
 	bool has_unpriv_retval = false;
+	bool unpriv_jit_on_next_line;
+	bool jit_on_next_line;
+	bool collect_jit = false;
 	int func_id, i, err = 0;
 	u32 arch_mask = 0;
 	struct btf *btf;
+	enum arch arch;
 
 	memset(spec, 0, sizeof(*spec));
 
@@ -399,6 +436,30 @@ static int parse_test_spec(struct test_loader *tester,
 			if (err)
 				goto cleanup;
 			spec->mode_mask |= UNPRIV;
+		} else if ((msg = skip_dynamic_pfx(s, TEST_TAG_JITED_PFX))) {
+			if (arch_mask == 0) {
+				PRINT_FAIL("__jited used before __arch_*");
+				goto cleanup;
+			}
+			if (collect_jit) {
+				err = push_disasm_msg(msg, &jit_on_next_line,
+						      &spec->priv.jited);
+				if (err)
+					goto cleanup;
+				spec->mode_mask |= PRIV;
+			}
+		} else if ((msg = skip_dynamic_pfx(s, TEST_TAG_JITED_PFX_UNPRIV))) {
+			if (arch_mask == 0) {
+				PRINT_FAIL("__unpriv_jited used before __arch_*");
+				goto cleanup;
+			}
+			if (collect_jit) {
+				err = push_disasm_msg(msg, &unpriv_jit_on_next_line,
+						      &spec->unpriv.jited);
+				if (err)
+					goto cleanup;
+				spec->mode_mask |= UNPRIV;
+			}
 		} else if ((msg = skip_dynamic_pfx(s, TEST_TAG_EXPECT_XLATED_PFX))) {
 			err = push_msg(msg, &spec->priv.expect_xlated);
 			if (err)
@@ -459,16 +520,20 @@ static int parse_test_spec(struct test_loader *tester,
 		} else if (str_has_pfx(s, TEST_TAG_ARCH)) {
 			val = s + sizeof(TEST_TAG_ARCH) - 1;
 			if (strcmp(val, "X86_64") == 0) {
-				arch_mask |= ARCH_X86_64;
+				arch = ARCH_X86_64;
 			} else if (strcmp(val, "ARM64") == 0) {
-				arch_mask |= ARCH_ARM64;
+				arch = ARCH_ARM64;
 			} else if (strcmp(val, "RISCV64") == 0) {
-				arch_mask |= ARCH_RISCV64;
+				arch = ARCH_RISCV64;
 			} else {
 				PRINT_FAIL("bad arch spec: '%s'", val);
 				err = -EINVAL;
 				goto cleanup;
 			}
+			arch_mask |= arch;
+			collect_jit = get_current_arch() == arch;
+			unpriv_jit_on_next_line = true;
+			jit_on_next_line = true;
 		} else if (str_has_pfx(s, TEST_BTF_PATH)) {
 			spec->btf_custom_path = s + sizeof(TEST_BTF_PATH) - 1;
 		}
@@ -521,6 +586,8 @@ static int parse_test_spec(struct test_loader *tester,
 			clone_msgs(&spec->priv.expect_msgs, &spec->unpriv.expect_msgs);
 		if (spec->unpriv.expect_xlated.cnt == 0)
 			clone_msgs(&spec->priv.expect_xlated, &spec->unpriv.expect_xlated);
+		if (spec->unpriv.jited.cnt == 0)
+			clone_msgs(&spec->priv.jited, &spec->unpriv.jited);
 	}
 
 	spec->valid = true;
@@ -575,16 +642,29 @@ static void emit_xlated(const char *xlated, bool force)
 	fprintf(stdout, "XLATED:\n=============\n%s=============\n", xlated);
 }
 
+static void emit_jited(const char *jited, bool force)
+{
+	if (!force && env.verbosity == VERBOSE_NONE)
+		return;
+	fprintf(stdout, "JITED:\n=============\n%s=============\n", jited);
+}
+
 static void validate_msgs(char *log_buf, struct expected_msgs *msgs,
 			  void (*emit_fn)(const char *buf, bool force))
 {
+	const char *log = log_buf, *prev_match;
 	regmatch_t reg_match[1];
-	const char *log = log_buf;
+	int prev_match_line;
+	int match_line;
 	int i, j, err;
 
+	prev_match_line = -1;
+	match_line = 0;
+	prev_match = log;
 	for (i = 0; i < msgs->cnt; i++) {
 		struct expect_msg *msg = &msgs->patterns[i];
-		const char *match = NULL;
+		const char *match = NULL, *pat_status;
+		bool wrong_line = false;
 
 		if (!msg->is_regex) {
 			match = strstr(log, msg->substr);
@@ -598,19 +678,41 @@ static void validate_msgs(char *log_buf, struct expected_msgs *msgs,
 			}
 		}
 
-		if (!match) {
+		if (match) {
+			for (; prev_match < match; ++prev_match)
+				if (*prev_match == '\n')
+					++match_line;
+			wrong_line = msg->on_next_line && prev_match_line >= 0 &&
+				     prev_match_line + 1 != match_line;
+		}
+
+		if (!match || wrong_line) {
 			PRINT_FAIL("expect_msg\n");
 			if (env.verbosity == VERBOSE_NONE)
 				emit_fn(log_buf, true /*force*/);
 			for (j = 0; j <= i; j++) {
 				msg = &msgs->patterns[j];
+				if (j < i)
+					pat_status = "MATCHED   ";
+				else if (wrong_line)
+					pat_status = "WRONG LINE";
+				else
+					pat_status = "EXPECTED  ";
+				msg = &msgs->patterns[j];
 				fprintf(stderr, "%s %s: '%s'\n",
-					j < i ? "MATCHED " : "EXPECTED",
+					pat_status,
 					msg->is_regex ? " REGEX" : "SUBSTR",
 					msg->substr);
 			}
-			return;
+			if (wrong_line) {
+				fprintf(stderr,
+					"expecting match at line %d, actual match is at line %d\n",
+					prev_match_line + 1, match_line);
+			}
+			break;
 		}
+
+		prev_match_line = match_line;
 	}
 }
 
@@ -769,20 +871,6 @@ static int get_xlated_program_text(int prog_fd, char *text, size_t text_sz)
 	return err;
 }
 
-static bool run_on_current_arch(int arch_mask)
-{
-	if (arch_mask == 0)
-		return true;
-#if defined(__x86_64__)
-	return arch_mask & ARCH_X86_64;
-#elif defined(__aarch64__)
-	return arch_mask & ARCH_ARM64;
-#elif defined(__riscv) && __riscv_xlen == 64
-	return arch_mask & ARCH_RISCV64;
-#endif
-	return false;
-}
-
 /* this function is forced noinline and has short generic name to look better
  * in test_progs output (in case of a failure)
  */
@@ -807,7 +895,7 @@ void run_subtest(struct test_loader *tester,
 	if (!test__start_subtest(subspec->name))
 		return;
 
-	if (!run_on_current_arch(spec->arch_mask)) {
+	if ((get_current_arch() & spec->arch_mask) == 0) {
 		test__skip();
 		return;
 	}
@@ -884,6 +972,21 @@ void run_subtest(struct test_loader *tester,
 		validate_msgs(tester->log_buf, &subspec->expect_xlated, emit_xlated);
 	}
 
+	if (subspec->jited.cnt) {
+		err = get_jited_program_text(bpf_program__fd(tprog),
+					     tester->log_buf, tester->log_buf_sz);
+		if (err == -EOPNOTSUPP) {
+			printf("%s:SKIP: jited programs disassembly is not supported,\n", __func__);
+			printf("%s:SKIP: tests are built w/o LLVM development libs\n", __func__);
+			test__skip();
+			goto tobj_cleanup;
+		}
+		if (!ASSERT_EQ(err, 0, "get_jited_program_text"))
+			goto tobj_cleanup;
+		emit_jited(tester->log_buf, false /*force*/);
+		validate_msgs(tester->log_buf, &subspec->jited, emit_jited);
+	}
+
 	if (should_do_test_run(spec, subspec)) {
 		/* For some reason test_verifier executes programs
 		 * with all capabilities restored. Do the same here.
-- 
2.45.2


