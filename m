Return-Path: <bpf+bounces-37298-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 34EBD953C38
	for <lists+bpf@lfdr.de>; Thu, 15 Aug 2024 22:56:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B73651F22154
	for <lists+bpf@lfdr.de>; Thu, 15 Aug 2024 20:56:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F098638DC7;
	Thu, 15 Aug 2024 20:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AQ2Gvkv5"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D11BF14AD20
	for <bpf@vger.kernel.org>; Thu, 15 Aug 2024 20:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723755396; cv=none; b=BOENVqv0KnQhUkuFc1g8PTWXYyroOLeY2NJvAFxnQGLFBf4mBAIM2IyiSdLL0I6Yr0JFT7TekOJxqeElbI3LLq824Tp+3v1a56xMUGnLGwrNsCqoBEWzsV5e2Duyh+o704Nj554J7htPcNc9ncEY5SEwGGWbM2djJ5sSLXfkvH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723755396; c=relaxed/simple;
	bh=+bEcgy+Knm2fOzHL2BXU+qhDmeMeYb994e1Jn1xripI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GVzQEE4bM5J4ueNB0p2EGl2940Op36b37V4+qAT6d/MXBX4GquqAUCDRlIM7L4WCxbe30tkzob83shHoObICWwyzDUlY5tbu3zbeuzmySNGhmmROIiDSn30mNp1RlGJEl2UjsG8UIuWVUjAkXC7zZ54uYEew9hpL6CBcOGN7moo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AQ2Gvkv5; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-7a103ac7be3so1022746a12.3
        for <bpf@vger.kernel.org>; Thu, 15 Aug 2024 13:56:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723755394; x=1724360194; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B2Da15pCeD9ruYHPrpQ4Yz/TpNZJwB5SHIMUzfSkr18=;
        b=AQ2Gvkv5/Oy3btx0JOeZYkAvdRmhoYhM5SfOWGD5jZZ4pJpJMlR4y4l01YX/93F4Ud
         sHvOw5CCCJk4GGhXydmvJXgeQkCEekXVNyjEbOWFTVD5tzdFZ8PdnyHQ5zGkAS25NQN/
         b1ZSpc3eiI0UY6fw82hUIgRSaNeXU/nZDRIwbGctIi5bkuSIA/G2hATvzUkuHtupc0hX
         8qVb/dZCKWzHrD8SGtrcGucOduPaBBfCDZvyCeSXDfpmlbVBg/zLe4Krfi6+NTtiIThM
         cBmbXZCf11VY5EkesFzcuOJATzNaWWE1tIqphMbDIo3enyJkHW8RU+xS75/R06ssuF3D
         UfHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723755394; x=1724360194;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B2Da15pCeD9ruYHPrpQ4Yz/TpNZJwB5SHIMUzfSkr18=;
        b=dbsq6XSZeK9H3+4jwxVQZo9Ex4h7/ufJd/jHOA/Ed4kGmTSVJp2uBseLi3zjW0TJTg
         fawEyByqtee4uUYGNmyx5rMpXc8VoZxNoBYipjh3RBT2HGO6zAxTaa/XC7aNkYDyUY6H
         v5/AjRMgOr9ypYcGme6hly9C0AAabxpO2rTdTZfgzwRbaxi5I9BfdFLfn5NIXc5jtbMO
         noFcFqlvqiIr+bcYnqHlcEtw5+8W8ew3wbpED57rKFFeljTQwkC2aqF8o86Ndkabd+i5
         MChc/0UltwMU5dhsCKLFsIo0qu2ZAk7DZYJ1ckE1uwX8reWQUfisZ0PW1DQO9Z2H7aGj
         +JoQ==
X-Gm-Message-State: AOJu0YyDbydKdTAZvfSCqqj/KhAVyd/AsNh9JcwaAzhTHTrsVjh3cZ2A
	gBmt8qfiqkILZOfBATOrmvjxlJrs4dRbkDEhysdXp3Gl7Vjn+sVLPetC6Hc+QXg=
X-Google-Smtp-Source: AGHT+IH7l+8OQsRDUeOfGKmgaWr4dwY06sfIWBMyKyuGz0OEvH2z/c8PEUHXYuTQ38PNVMif/Q6btA==
X-Received: by 2002:a17:90a:34cc:b0:2c9:6278:27c9 with SMTP id 98e67ed59e1d1-2d3e0409761mr985422a91.38.1723755393779;
        Thu, 15 Aug 2024 13:56:33 -0700 (PDT)
Received: from honey-badger.. ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d3ac7f2eb2sm4024364a91.26.2024.08.15.13.56.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 13:56:33 -0700 (PDT)
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
Subject: [PATCH bpf-next v2 3/4] selftests/bpf: __jited_x86 test tag to check x86 assembly after jit
Date: Thu, 15 Aug 2024 13:54:48 -0700
Message-ID: <20240815205449.242556-4-eddyz87@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240815205449.242556-1-eddyz87@gmail.com>
References: <20240815205449.242556-1-eddyz87@gmail.com>
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


