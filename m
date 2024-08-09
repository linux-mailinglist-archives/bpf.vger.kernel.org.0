Return-Path: <bpf+bounces-36748-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA6FC94C7E2
	for <lists+bpf@lfdr.de>; Fri,  9 Aug 2024 03:06:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E7C7BB21590
	for <lists+bpf@lfdr.de>; Fri,  9 Aug 2024 01:06:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9347A9463;
	Fri,  9 Aug 2024 01:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P/FCxWKY"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59D4C8BFC
	for <bpf@vger.kernel.org>; Fri,  9 Aug 2024 01:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723165555; cv=none; b=nr70BPlFDP1kJTUpWdhXPXoiUz8eNdB4kcdtabqfSz7CRfahYwsMnAAT0O1+rx/OR2Q4XgMLyPvmdXP+00i+9hj5QHeBIQokBo6H1+csO00OP4sk8ZMZxRzaLqSWyhI6gUN9iWMafdjwnrKn9DTRiOkuuIdf/XX8nHXw3Y8IESg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723165555; c=relaxed/simple;
	bh=+bEcgy+Knm2fOzHL2BXU+qhDmeMeYb994e1Jn1xripI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ptnhVUl+s93PBSORSxpKVE4o6tF7cNs0HiX6wYCaWvdxExF0d0UMO30MqbTUI4CMU/d1/YaHJSjpYTUZzZATs2XmIK0udyvGa+rkK3aAdu0YC6vTSOUGV/d1sPGk8FjLmLqBqKliepEygN9OY8kf+CIT0UmWUkCXxwP6Zi1V38Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P/FCxWKY; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-70eaf5874ddso1306260b3a.3
        for <bpf@vger.kernel.org>; Thu, 08 Aug 2024 18:05:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723165552; x=1723770352; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B2Da15pCeD9ruYHPrpQ4Yz/TpNZJwB5SHIMUzfSkr18=;
        b=P/FCxWKYQ9YDWtAdtpga7NhIEtEZQ/T62zdEI3TXj7FOgFrp8iVFsp/HE1kXWcm7pm
         GdJJsaRa6QRs5lMRAEESGTSWdBxVRjUnUkrdiwL3aM7XGsLjckTff7v6JalMkV98zPRL
         s4rdXjpZgZkbr+NqdeKb/LtUD4bRhYJoiJ4aNbK3BAc8xQHDht0JGwrWfuCXqgZqM9of
         Z3kF+rXZNXLhS5eMFM96jRZPdRTYCT78X71hXewpk1k35Dbzp+D36rL2+L34u+Yq53qm
         bpv+//fzQloJy7A8zCixsE4sHhuhDxAvxg+li5NFx017NQTsgEW+l3mNUPdt4dlfBMfj
         vdDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723165552; x=1723770352;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B2Da15pCeD9ruYHPrpQ4Yz/TpNZJwB5SHIMUzfSkr18=;
        b=v7jUTEC7oT9bnPNXVau9aVuX7fk2QqRg5pnR2LaJDt0Z5P3ENnnYvuNH4WJRHuWasq
         qgxRt8V/KFRLYi5VR/NAxZjmlrtFV84laYrJP45EOqVUJLMdHMvhiZGKByc2TYYfqRqK
         rdK2VjuWxJtvphPWvfV95ZhsshaMonW8smxxq4BNmvHLWqMKQNMdDE9T+zcE+Lidc773
         wmSeU0T2BrJ1Gb6CEFB6vODitae4IwtkTzfKSdoFKbFrqzalrFZWc/pFtqLhLpcxpqtM
         dgRKLnFE0ZypuyL9JY8EHroSo/NCc5B1ECmLXbL5SIJaPWPDpYneWYp+8qfejbOMqyQL
         epZw==
X-Gm-Message-State: AOJu0Yxi9MOT77J/1slVcU4mbHq9x6+R+6pLzfDp6VymryYku5xDFuOQ
	5uNfsccVnDR/qUMirPOH6loRjFaqy747LxjEJ0TsdpKcTRA5jx5TToLCVBSk/Ls=
X-Google-Smtp-Source: AGHT+IFwV71jrC4Qf5COpBCoNlV41zchqxRvBUXZpPUyWf2hb0V+9qF6XxdFCjn+V2RKUMS8Ldip6Q==
X-Received: by 2002:a05:6a21:78d:b0:1c3:b2da:7e27 with SMTP id adf61e73a8af0-1c89feb1639mr123942637.14.1723165552110;
        Thu, 08 Aug 2024 18:05:52 -0700 (PDT)
Received: from honey-badger.. ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-710cb2fc0d8sm1678626b3a.205.2024.08.08.18.05.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Aug 2024 18:05:51 -0700 (PDT)
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
Subject: [PATCH bpf-next 3/4] selftests/bpf: __jited_x86 test tag to check x86 assembly after jit
Date: Thu,  8 Aug 2024 18:05:17 -0700
Message-ID: <20240809010518.1137758-4-eddyz87@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240809010518.1137758-1-eddyz87@gmail.com>
References: <20240809010518.1137758-1-eddyz87@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Allow to verify jit behaviour by writing tests as below:

    SEC("tp")
    __jit_x86("endbr64")
    __jit_x86("movabs $0x.*,%r9")
    __jit_x86("add    %gs:0x.*,%r9")
    __jit_x86("mov    $0x1,%edi")
    __jit_x86("mov    %rdi,-0x8(%r9)")
    __jit_x86("mov    -0x8(%r9),%rdi")
    __jit_x86("xor    %eax,%eax")
    __jit_x86("lock xchg %rax,-0x8(%r9)")
    __jit_x86("lock xadd %rax,-0x8(%r9)")
    __naked void stack_access_insns(void)
    {
    	asm volatile (... ::: __clobber_all);
    }

Use regular expressions by default, use basic regular expressions
class in order to avoid escaping symbols like $(), often used in AT&T
disassembly syntax.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 tools/testing/selftests/bpf/progs/bpf_misc.h |   2 +
 tools/testing/selftests/bpf/test_loader.c    | 156 +++++++++++++------
 2 files changed, 112 insertions(+), 46 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/bpf_misc.h b/tools/testing/selftests/bpf/progs/bpf_misc.h
index a225cd87897c..06e353a0a5b1 100644
--- a/tools/testing/selftests/bpf/progs/bpf_misc.h
+++ b/tools/testing/selftests/bpf/progs/bpf_misc.h
@@ -90,6 +90,8 @@
 #define __arch_x86_64		__arch("X86_64")
 #define __arch_arm64		__arch("ARM64")
 #define __arch_riscv64		__arch("RISCV64")
+#define __jit_x86(basic_regex)	__attribute__((btf_decl_tag("comment:test_jit_x86=" basic_regex)))
+#define __jit_x86_unpriv(basic_regex)	__attribute__((btf_decl_tag("comment:test_jit_x86_unpriv=" basic_regex)))
 
 /* Convenience macro for use with 'asm volatile' blocks */
 #define __naked __attribute__((naked))
diff --git a/tools/testing/selftests/bpf/test_loader.c b/tools/testing/selftests/bpf/test_loader.c
index 1b1290e090e7..7d8a0cf9904a 100644
--- a/tools/testing/selftests/bpf/test_loader.c
+++ b/tools/testing/selftests/bpf/test_loader.c
@@ -10,6 +10,7 @@
 #include "disasm_helpers.h"
 #include "unpriv_helpers.h"
 #include "cap_helpers.h"
+#include "jit_disasm_helpers.h"
 
 #define str_has_pfx(str, pfx) \
 	(strncmp(str, pfx, __builtin_constant_p(pfx) ? sizeof(pfx) - 1 : strlen(pfx)) == 0)
@@ -35,6 +36,8 @@
 #define TEST_TAG_AUXILIARY_UNPRIV "comment:test_auxiliary_unpriv"
 #define TEST_BTF_PATH "comment:test_btf_path="
 #define TEST_TAG_ARCH "comment:test_arch="
+#define TEST_TAG_JIT_X86_PFX "comment:test_jit_x86="
+#define TEST_TAG_JIT_X86_PFX_UNPRIV "comment:test_jit_x86_unpriv="
 
 /* Warning: duplicated in bpf_misc.h */
 #define POINTER_VALUE	0xcafe4all
@@ -53,10 +56,18 @@ enum mode {
 	UNPRIV = 2
 };
 
+enum arch {
+	ARCH_X86_64	= 1,
+	ARCH_ARM64	= 2,
+	ARCH_RISCV64	= 3,
+	ARCH_MAX
+};
+
 struct expect_msg {
 	const char *substr; /* substring match */
 	const char *regex_str; /* regex-based match */
 	regex_t regex;
+	int regex_flags;
 };
 
 struct expected_msgs {
@@ -69,6 +80,7 @@ struct test_subspec {
 	bool expect_failure;
 	struct expected_msgs expect_msgs;
 	struct expected_msgs expect_xlated;
+	struct expected_msgs jited[ARCH_MAX];
 	int retval;
 	bool execute;
 };
@@ -120,11 +132,17 @@ static void free_msgs(struct expected_msgs *msgs)
 
 static void free_test_spec(struct test_spec *spec)
 {
+	int i;
+
 	/* Deallocate expect_msgs arrays. */
 	free_msgs(&spec->priv.expect_msgs);
 	free_msgs(&spec->unpriv.expect_msgs);
 	free_msgs(&spec->priv.expect_xlated);
 	free_msgs(&spec->unpriv.expect_xlated);
+	for (i = 0; i < ARCH_MAX; ++i) {
+		free_msgs(&spec->priv.jited[i]);
+		free_msgs(&spec->unpriv.jited[i]);
+	}
 
 	free(spec->priv.name);
 	free(spec->unpriv.name);
@@ -132,7 +150,8 @@ static void free_test_spec(struct test_spec *spec)
 	spec->unpriv.name = NULL;
 }
 
-static int push_msg(const char *substr, const char *regex_str, struct expected_msgs *msgs)
+static int __push_msg(const char *substr, const char *regex_str, int regex_flags,
+		      struct expected_msgs *msgs)
 {
 	void *tmp;
 	int regcomp_res;
@@ -151,10 +170,12 @@ static int push_msg(const char *substr, const char *regex_str, struct expected_m
 	if (substr) {
 		msg->substr = substr;
 		msg->regex_str = NULL;
+		msg->regex_flags = 0;
 	} else {
 		msg->regex_str = regex_str;
 		msg->substr = NULL;
-		regcomp_res = regcomp(&msg->regex, regex_str, REG_EXTENDED|REG_NEWLINE);
+		msg->regex_flags = regex_flags;
+		regcomp_res = regcomp(&msg->regex, regex_str, regex_flags|REG_NEWLINE);
 		if (regcomp_res != 0) {
 			regerror(regcomp_res, &msg->regex, error_msg, sizeof(error_msg));
 			PRINT_FAIL("Regexp compilation error in '%s': '%s'\n",
@@ -167,6 +188,35 @@ static int push_msg(const char *substr, const char *regex_str, struct expected_m
 	return 0;
 }
 
+static int clone_msgs(struct expected_msgs *from, struct expected_msgs *to)
+{
+	struct expect_msg *msg;
+	int i, err;
+
+	for (i = 0; i < from->cnt; i++) {
+		msg = &from->patterns[i];
+		err = __push_msg(msg->substr, msg->regex_str, msg->regex_flags, to);
+		if (err)
+			return err;
+	}
+	return 0;
+}
+
+static int push_msg(const char *substr, struct expected_msgs *msgs)
+{
+	return __push_msg(substr, NULL, 0, msgs);
+}
+
+static int push_extended_regex(const char *regex_str, struct expected_msgs *msgs)
+{
+	return __push_msg(NULL, regex_str, REG_EXTENDED, msgs);
+}
+
+static int push_basic_regex(const char *regex_str, struct expected_msgs *msgs)
+{
+	return __push_msg(NULL, regex_str, 0, msgs);
+}
+
 static int parse_int(const char *str, int *val, const char *name)
 {
 	char *end;
@@ -215,12 +265,6 @@ static void update_flags(int *flags, int flag, bool clear)
 		*flags |= flag;
 }
 
-enum arch {
-	ARCH_X86_64	= 0x1,
-	ARCH_ARM64	= 0x2,
-	ARCH_RISCV64	= 0x4,
-};
-
 /* Uses btf_decl_tag attributes to describe the expected test
  * behavior, see bpf_misc.h for detailed description of each attribute
  * and attribute combinations.
@@ -292,37 +336,49 @@ static int parse_test_spec(struct test_loader *tester,
 			spec->mode_mask |= UNPRIV;
 		} else if (str_has_pfx(s, TEST_TAG_EXPECT_MSG_PFX)) {
 			msg = s + sizeof(TEST_TAG_EXPECT_MSG_PFX) - 1;
-			err = push_msg(msg, NULL, &spec->priv.expect_msgs);
+			err = push_msg(msg, &spec->priv.expect_msgs);
 			if (err)
 				goto cleanup;
 			spec->mode_mask |= PRIV;
 		} else if (str_has_pfx(s, TEST_TAG_EXPECT_MSG_PFX_UNPRIV)) {
 			msg = s + sizeof(TEST_TAG_EXPECT_MSG_PFX_UNPRIV) - 1;
-			err = push_msg(msg, NULL, &spec->unpriv.expect_msgs);
+			err = push_msg(msg, &spec->unpriv.expect_msgs);
 			if (err)
 				goto cleanup;
 			spec->mode_mask |= UNPRIV;
 		} else if (str_has_pfx(s, TEST_TAG_EXPECT_REGEX_PFX)) {
 			msg = s + sizeof(TEST_TAG_EXPECT_REGEX_PFX) - 1;
-			err = push_msg(NULL, msg, &spec->priv.expect_msgs);
+			err = push_extended_regex(msg, &spec->priv.expect_msgs);
 			if (err)
 				goto cleanup;
 			spec->mode_mask |= PRIV;
 		} else if (str_has_pfx(s, TEST_TAG_EXPECT_REGEX_PFX_UNPRIV)) {
 			msg = s + sizeof(TEST_TAG_EXPECT_REGEX_PFX_UNPRIV) - 1;
-			err = push_msg(NULL, msg, &spec->unpriv.expect_msgs);
+			err = push_extended_regex(msg, &spec->unpriv.expect_msgs);
+			if (err)
+				goto cleanup;
+			spec->mode_mask |= UNPRIV;
+		} else if (str_has_pfx(s, TEST_TAG_JIT_X86_PFX)) {
+			msg = s + sizeof(TEST_TAG_JIT_X86_PFX) - 1;
+			err = push_basic_regex(msg, &spec->priv.jited[ARCH_X86_64]);
+			if (err)
+				goto cleanup;
+			spec->mode_mask |= PRIV;
+		} else if (str_has_pfx(s, TEST_TAG_JIT_X86_PFX_UNPRIV)) {
+			msg = s + sizeof(TEST_TAG_JIT_X86_PFX_UNPRIV) - 1;
+			err = push_basic_regex(msg, &spec->unpriv.jited[ARCH_X86_64]);
 			if (err)
 				goto cleanup;
 			spec->mode_mask |= UNPRIV;
 		} else if (str_has_pfx(s, TEST_TAG_EXPECT_XLATED_PFX)) {
 			msg = s + sizeof(TEST_TAG_EXPECT_XLATED_PFX) - 1;
-			err = push_msg(msg, NULL, &spec->priv.expect_xlated);
+			err = push_msg(msg, &spec->priv.expect_xlated);
 			if (err)
 				goto cleanup;
 			spec->mode_mask |= PRIV;
 		} else if (str_has_pfx(s, TEST_TAG_EXPECT_XLATED_PFX_UNPRIV)) {
 			msg = s + sizeof(TEST_TAG_EXPECT_XLATED_PFX_UNPRIV) - 1;
-			err = push_msg(msg, NULL, &spec->unpriv.expect_xlated);
+			err = push_msg(msg, &spec->unpriv.expect_xlated);
 			if (err)
 				goto cleanup;
 			spec->mode_mask |= UNPRIV;
@@ -376,11 +432,11 @@ static int parse_test_spec(struct test_loader *tester,
 		} else if (str_has_pfx(s, TEST_TAG_ARCH)) {
 			val = s + sizeof(TEST_TAG_ARCH) - 1;
 			if (strcmp(val, "X86_64") == 0) {
-				arch_mask |= ARCH_X86_64;
+				arch_mask |= 1u << ARCH_X86_64;
 			} else if (strcmp(val, "ARM64") == 0) {
-				arch_mask |= ARCH_ARM64;
+				arch_mask |= 1u << ARCH_ARM64;
 			} else if (strcmp(val, "RISCV64") == 0) {
-				arch_mask |= ARCH_RISCV64;
+				arch_mask |= 1u << ARCH_RISCV64;
 			} else {
 				PRINT_FAIL("bad arch spec: '%s'", val);
 				err = -EINVAL;
@@ -434,26 +490,13 @@ static int parse_test_spec(struct test_loader *tester,
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
+		for (i = 0; i < ARCH_MAX; ++i)
+			if (spec->unpriv.jited[i].cnt == 0)
+				clone_msgs(&spec->priv.jited[i], &spec->unpriv.jited[i]);
 	}
 
 	spec->valid = true;
@@ -508,6 +551,13 @@ static void emit_xlated(const char *xlated, bool force)
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
@@ -702,18 +752,16 @@ static int get_xlated_program_text(int prog_fd, char *text, size_t text_sz)
 	return err;
 }
 
-static bool run_on_current_arch(int arch_mask)
+static int get_current_arch(void)
 {
-	if (arch_mask == 0)
-		return true;
 #if defined(__x86_64__)
-	return arch_mask & ARCH_X86_64;
+	return ARCH_X86_64;
 #elif defined(__aarch64__)
-	return arch_mask & ARCH_ARM64;
+	return ARCH_ARM64;
 #elif defined(__riscv) && __riscv_xlen == 64
-	return arch_mask & ARCH_RISCV64;
+	return ARCH_RISCV64;
 #endif
-	return false;
+	return -1;
 }
 
 /* this function is forced noinline and has short generic name to look better
@@ -732,15 +780,16 @@ void run_subtest(struct test_loader *tester,
 	struct bpf_program *tprog = NULL, *tprog_iter;
 	struct test_spec *spec_iter;
 	struct cap_state caps = {};
+	int retval, err, i, arch;
 	struct bpf_object *tobj;
 	struct bpf_map *map;
-	int retval, err, i;
 	bool should_load;
 
 	if (!test__start_subtest(subspec->name))
 		return;
 
-	if (!run_on_current_arch(spec->arch_mask)) {
+	arch = get_current_arch();
+	if (spec->arch_mask && (arch < 0 || (spec->arch_mask & (1u << arch)) == 0)) {
 		test__skip();
 		return;
 	}
@@ -817,6 +866,21 @@ void run_subtest(struct test_loader *tester,
 		validate_msgs(tester->log_buf, &subspec->expect_xlated, emit_xlated);
 	}
 
+	if (arch > 0 && subspec->jited[arch].cnt) {
+		err = get_jited_program_text(bpf_program__fd(tprog),
+					     tester->log_buf, tester->log_buf_sz);
+		if (err == -ENOTSUP) {
+			printf("%s:SKIP: jited programs disassembly is not supported,\n", __func__);
+			printf("%s:SKIP: tests are built w/o LLVM development libs\n", __func__);
+			test__skip();
+			goto tobj_cleanup;
+		}
+		if (!ASSERT_EQ(err, 0, "get_jited_program_text"))
+			goto tobj_cleanup;
+		emit_jited(tester->log_buf, false /*force*/);
+		validate_msgs(tester->log_buf, &subspec->jited[arch], emit_jited);
+	}
+
 	if (should_do_test_run(spec, subspec)) {
 		/* For some reason test_verifier executes programs
 		 * with all capabilities restored. Do the same here.
-- 
2.45.2


