Return-Path: <bpf+bounces-34860-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E07A931D72
	for <lists+bpf@lfdr.de>; Tue, 16 Jul 2024 01:03:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A31791F224AD
	for <lists+bpf@lfdr.de>; Mon, 15 Jul 2024 23:03:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AADAC1448DF;
	Mon, 15 Jul 2024 23:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ECm6nONU"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0F3E1448C7
	for <bpf@vger.kernel.org>; Mon, 15 Jul 2024 23:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721084559; cv=none; b=IdqkIg7G+DbVvkISQdlRiOvHV9Uyex37Rhd5w0HcTHm7eAv8cpRc7mIyQUVp8JV0yfBuruqGJeBDxjXewYflgXhSjicgSqjCixUnZE4gyrFqJ0KbknJT6EyP1y0c8QiDnz/PJyKABWr76qwhfzOiVpigcUtkhmT2p+ft1BHGZ04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721084559; c=relaxed/simple;
	bh=nSRQgVwzqE9EibMQ+6b2kM1It2Gm6S06QoRB9b5WnkU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Bme/A28dnRZIISHG0ChbxGQR/p9ozft70lEiI404k+2m67700SaSMDAtJ62NoAl7zY6lWPVggXDZkTOqMPVsQRWO5qJKmh/0x8wR6Ja3azU0I6a9u3ZUtJWl9MyMb1bN5cSsmlbOUokoT7YmSLq2/C1NfPfPWaMVi+XcPnjRZMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ECm6nONU; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-250ca14422aso2725303fac.0
        for <bpf@vger.kernel.org>; Mon, 15 Jul 2024 16:02:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721084556; x=1721689356; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zEEKOl8JhrhEjS/sgijGjfbzU9z19n/Dr0hU6V4VsDA=;
        b=ECm6nONUg60EuQ3cvTYqcMH/I1sl7Zr0ck+592X9KFxjbspzsvex0e+9o/QHBTfkFh
         vFitO42NukhrmXoRJpVUoJo8gUZCz4Cxms2h4wRjnMC3krTjcuwNJ/xvynhbDXEEfqHX
         pcm/H1XXkcNpwUN2SEtFuz95JJ6Lw7Y1mlKpThW/FzF0trG5lR2GXoCjIpUD+4gc5JTU
         KUofy34s5ZPLhE0DZEUUD+/maFFm4ykc7Fznzt//mga9FIZACfIYMC7E9MIdODolEK+M
         2JUmObltHpXfuSL5x8DzxEbsM+7W4lWeSBdj9o94UaxhnKYJL9e59JAVBIerpDtZvLvN
         zzWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721084556; x=1721689356;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zEEKOl8JhrhEjS/sgijGjfbzU9z19n/Dr0hU6V4VsDA=;
        b=AKieLSyu3ApdZeAf2eWigR2kNSai3A4ia+9BcIgfSFE328A4KvjmAOsqzM4lhOTJ+N
         pSKROjd4PWAfpj5Ha0OJ/d/U2kn+KWpcEtt+qLBPNWFuTT21QnW3eQg3EBnXuU5t6RMj
         rhoM3X5X19p/LLjmZnOTNkKpbpIZOmjNFf6v0qxj/w1bb+zQLqbQ53VU6Q7GQeR+EGu2
         Ma7tZwREgHLxHhSiPguN4EH03wQ9pCpPOJxjh6qqklDxkZaAJLt0n6q4B1+JVr8k3aZs
         bbFRGhGwTzWalBsdgs5xseHMMW5JFx7rbvdwBlVsaBvlVmCKSERtPkwd+fRo/S7OkVCt
         wuFQ==
X-Gm-Message-State: AOJu0Yz6zBFPfEUTAkLrbrrg3+6QVEQkCs7n2QxZhMMqZE2zT+Ifn2jF
	7eLtTgfUDx5d2WcolTXQhhstzuexLvdueD6pDqogCQ2zJqrLEZbq5xsZrA==
X-Google-Smtp-Source: AGHT+IF0BpfRmdLoZlEPYSc6mDHHRhL7/Ozz0nAINmHk88sv++YJRe0uyXwFXi+/2VnQ8qJwK7n1xQ==
X-Received: by 2002:a05:6870:d614:b0:254:963e:cc3f with SMTP id 586e51a60fabf-260bd51fd74mr262006fac.1.1721084556366;
        Mon, 15 Jul 2024 16:02:36 -0700 (PDT)
Received: from badger.. ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70b7ecc9d36sm4915344b3a.205.2024.07.15.16.02.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jul 2024 16:02:35 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	jose.marchesi@oracle.com,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [bpf-next v3 09/12] selftests/bpf: __arch_* macro to limit test cases to specific archs
Date: Mon, 15 Jul 2024 16:01:58 -0700
Message-ID: <20240715230201.3901423-10-eddyz87@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240715230201.3901423-1-eddyz87@gmail.com>
References: <20240715230201.3901423-1-eddyz87@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add annotations __arch_x86_64, __arch_arm64, __arch_riscv64
to specify on which architecture the test case should be tested.
Several __arch_* annotations could be specified at once.
When test case is not run on current arch it is marked as skipped.

For example, the following would be tested only on arm64 and riscv64:

  SEC("raw_tp")
  __arch_arm64
  __arch_riscv64
  __xlated("1: *(u64 *)(r10 - 16) = r1")
  __xlated("2: call")
  __xlated("3: r1 = *(u64 *)(r10 - 16);")
  __success
  __naked void canary_arm64_riscv64(void)
  {
  	asm volatile (
  	"r1 = 1;"
  	"*(u64 *)(r10 - 16) = r1;"
  	"call %[bpf_get_smp_processor_id];"
  	"r1 = *(u64 *)(r10 - 16);"
  	"exit;"
  	:
  	: __imm(bpf_get_smp_processor_id)
  	: __clobber_all);
  }

On x86 it would be skipped:

  #467/2   verifier_nocsr/canary_arm64_riscv64:SKIP

Acked-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 tools/testing/selftests/bpf/progs/bpf_misc.h |  8 ++++
 tools/testing/selftests/bpf/test_loader.c    | 43 ++++++++++++++++++++
 2 files changed, 51 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/bpf_misc.h b/tools/testing/selftests/bpf/progs/bpf_misc.h
index a70939c7bc26..a225cd87897c 100644
--- a/tools/testing/selftests/bpf/progs/bpf_misc.h
+++ b/tools/testing/selftests/bpf/progs/bpf_misc.h
@@ -63,6 +63,10 @@
  * __auxiliary         Annotated program is not a separate test, but used as auxiliary
  *                     for some other test cases and should always be loaded.
  * __auxiliary_unpriv  Same, but load program in unprivileged mode.
+ *
+ * __arch_*          Specify on which architecture the test case should be tested.
+ *                   Several __arch_* annotations could be specified at once.
+ *                   When test case is not run on current arch it is marked as skipped.
  */
 #define __msg(msg)		__attribute__((btf_decl_tag("comment:test_expect_msg=" msg)))
 #define __regex(regex)		__attribute__((btf_decl_tag("comment:test_expect_regex=" regex)))
@@ -82,6 +86,10 @@
 #define __auxiliary		__attribute__((btf_decl_tag("comment:test_auxiliary")))
 #define __auxiliary_unpriv	__attribute__((btf_decl_tag("comment:test_auxiliary_unpriv")))
 #define __btf_path(path)	__attribute__((btf_decl_tag("comment:test_btf_path=" path)))
+#define __arch(arch)		__attribute__((btf_decl_tag("comment:test_arch=" arch)))
+#define __arch_x86_64		__arch("X86_64")
+#define __arch_arm64		__arch("ARM64")
+#define __arch_riscv64		__arch("RISCV64")
 
 /* Convenience macro for use with 'asm volatile' blocks */
 #define __naked __attribute__((naked))
diff --git a/tools/testing/selftests/bpf/test_loader.c b/tools/testing/selftests/bpf/test_loader.c
index b44b6a2fc82c..12b0c41e8d64 100644
--- a/tools/testing/selftests/bpf/test_loader.c
+++ b/tools/testing/selftests/bpf/test_loader.c
@@ -34,6 +34,7 @@
 #define TEST_TAG_AUXILIARY "comment:test_auxiliary"
 #define TEST_TAG_AUXILIARY_UNPRIV "comment:test_auxiliary_unpriv"
 #define TEST_BTF_PATH "comment:test_btf_path="
+#define TEST_TAG_ARCH "comment:test_arch="
 
 /* Warning: duplicated in bpf_misc.h */
 #define POINTER_VALUE	0xcafe4all
@@ -80,6 +81,7 @@ struct test_spec {
 	int log_level;
 	int prog_flags;
 	int mode_mask;
+	int arch_mask;
 	bool auxiliary;
 	bool valid;
 };
@@ -213,6 +215,12 @@ static void update_flags(int *flags, int flag, bool clear)
 		*flags |= flag;
 }
 
+enum arch {
+	ARCH_X86_64	= 0x1,
+	ARCH_ARM64	= 0x2,
+	ARCH_RISCV64	= 0x4,
+};
+
 /* Uses btf_decl_tag attributes to describe the expected test
  * behavior, see bpf_misc.h for detailed description of each attribute
  * and attribute combinations.
@@ -226,6 +234,7 @@ static int parse_test_spec(struct test_loader *tester,
 	bool has_unpriv_result = false;
 	bool has_unpriv_retval = false;
 	int func_id, i, err = 0;
+	u32 arch_mask = 0;
 	struct btf *btf;
 
 	memset(spec, 0, sizeof(*spec));
@@ -364,11 +373,26 @@ static int parse_test_spec(struct test_loader *tester,
 					goto cleanup;
 				update_flags(&spec->prog_flags, flags, clear);
 			}
+		} else if (str_has_pfx(s, TEST_TAG_ARCH)) {
+			val = s + sizeof(TEST_TAG_ARCH) - 1;
+			if (strcmp(val, "X86_64") == 0) {
+				arch_mask |= ARCH_X86_64;
+			} else if (strcmp(val, "ARM64") == 0) {
+				arch_mask |= ARCH_ARM64;
+			} else if (strcmp(val, "RISCV64") == 0) {
+				arch_mask |= ARCH_RISCV64;
+			} else {
+				PRINT_FAIL("bad arch spec: '%s'", val);
+				err = -EINVAL;
+				goto cleanup;
+			}
 		} else if (str_has_pfx(s, TEST_BTF_PATH)) {
 			spec->btf_custom_path = s + sizeof(TEST_BTF_PATH) - 1;
 		}
 	}
 
+	spec->arch_mask = arch_mask;
+
 	if (spec->mode_mask == 0)
 		spec->mode_mask = PRIV;
 
@@ -677,6 +701,20 @@ static int get_xlated_program_text(int prog_fd, char *text, size_t text_sz)
 	return err;
 }
 
+static bool run_on_current_arch(int arch_mask)
+{
+	if (arch_mask == 0)
+		return true;
+#if defined(__x86_64__)
+	return arch_mask & ARCH_X86_64;
+#elif defined(__aarch64__)
+	return arch_mask & ARCH_ARM64;
+#elif defined(__riscv) && __riscv_xlen == 64
+	return arch_mask & ARCH_RISCV64;
+#endif
+	return false;
+}
+
 /* this function is forced noinline and has short generic name to look better
  * in test_progs output (in case of a failure)
  */
@@ -701,6 +739,11 @@ void run_subtest(struct test_loader *tester,
 	if (!test__start_subtest(subspec->name))
 		return;
 
+	if (!run_on_current_arch(spec->arch_mask)) {
+		test__skip();
+		return;
+	}
+
 	if (unpriv) {
 		if (!can_execute_unpriv(tester, spec)) {
 			test__skip();
-- 
2.45.2


