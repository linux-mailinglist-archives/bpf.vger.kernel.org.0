Return-Path: <bpf+bounces-35287-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5483939710
	for <lists+bpf@lfdr.de>; Tue, 23 Jul 2024 01:39:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 10B43B219C1
	for <lists+bpf@lfdr.de>; Mon, 22 Jul 2024 23:39:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDB3F73456;
	Mon, 22 Jul 2024 23:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FjJ2BsqQ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0C3C6F308
	for <bpf@vger.kernel.org>; Mon, 22 Jul 2024 23:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721691557; cv=none; b=pEhC5BdN99lOY8qj8dhByrPxu3bAsNBIBLEE+O/TUVZEVB7mPoscYOGOB5MGv2EzNdh2ZV8owejzCuSDjK+Ox+PBWIC6MECyVoZOtxA92GgVWy+nQkAb3dLLvG4V0MW8rNKqzUWzhGrf94AW5r6cQZ2C6LY46iV/wH+dZe2ZtV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721691557; c=relaxed/simple;
	bh=nSRQgVwzqE9EibMQ+6b2kM1It2Gm6S06QoRB9b5WnkU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YAlLop6tQPBzkj4Ta4WkS68fmyCb72ebfuDuCEIwi8oFq0/fCGJFL69P8IhJZwdVfiOTrOjgPKh/cokSm+K/TC/1WJokpDV8IidT8sQxQ7v2imIFH9P8s1LGXZgrO4JTdgTHDaKPgj36DfJjJdpWJDIvDH9ymVlHn9DoTxUGfPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FjJ2BsqQ; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-3d9e13ef8edso3055330b6e.2
        for <bpf@vger.kernel.org>; Mon, 22 Jul 2024 16:39:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721691555; x=1722296355; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zEEKOl8JhrhEjS/sgijGjfbzU9z19n/Dr0hU6V4VsDA=;
        b=FjJ2BsqQDehV1lIYrpe+frIGECr3H98bNz5yOV4pfsNeBdNV6TtPlz0mU4ipj3Xn2t
         1xooWkrMw1Rn7qb2rPSWpz/T0AqB8ViFyuBtWg9itJbVZUvbhKJ75kIPnuz3CxvUU5/m
         nZqI871WBHHUttzkc2ibAPvSfbvsJ0Rocd9nN+OOXlkNvVx6QDHfI5rgaedFMxBZtprJ
         C++6dsbmLZK4I6yO3AmD+AjEEXpleJ8ADxL6NDpf/W9WSZi7Xzcctr+j72EgYfMnw/hE
         Gw2632ZYahfUhyvpIJEUzN8DjvITvB9YfBHGG+1a/j/vlMPkrewHDex8FbE58xAgm2Or
         T8bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721691555; x=1722296355;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zEEKOl8JhrhEjS/sgijGjfbzU9z19n/Dr0hU6V4VsDA=;
        b=bimOC6ArnLvll9rfCy0vG2mK7MG5bSJG2719Ftq6KQ1K6EniBlFOavuJ73UQ0wybrR
         y/7lRw1jd+odbI8oy11doltoCJM/bwqoAPTqr8E8E73cPguykXyrUqrza1Gm5IBpqCxa
         BgDg3eiWg6e4BQN4NzHq64E24VZIpXI+oH7W49kQ1vgi56HldyDJFQmzfpjh2V4ggOMg
         HXiYK5g4NWeCr7BhzBjsVMmuzh5y7GVGhuIO9sVXk7YD3xmXeUK0Mk5Dgodkq4uZzJnx
         uZ8Yakk4Ke5Jl3QThQM4Wfl6kaQwEOsea+4Mrfb2aysFrtydZh5JVL4R/8yHFJNtv3Hs
         SFwA==
X-Gm-Message-State: AOJu0YwUUw2IBwHSOuGZRV0LTsDbtXYGaShsP2y6RqEb64vviZdMmBWy
	AfpKgj2TBavc3KQ56ODIxRzSPCM2F0PclmjwVx1ybtwLHiDxZwe2mT7wFHwPJvo=
X-Google-Smtp-Source: AGHT+IFPpTmolndbCvmN53q5LM06/as8p6zV/mUwy+cWFvH5iluwYp0C9d9u41i8rrTGbpog/fau9g==
X-Received: by 2002:a05:6808:2106:b0:3d9:dabc:7b76 with SMTP id 5614622812f47-3dae62e8483mr12701813b6e.23.1721691554880;
        Mon, 22 Jul 2024 16:39:14 -0700 (PDT)
Received: from honey-badger.. ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70d2707fe14sm2479500b3a.163.2024.07.22.16.39.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jul 2024 16:39:14 -0700 (PDT)
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
Subject: [PATCH bpf-next v4 09/10] selftests/bpf: __arch_* macro to limit test cases to specific archs
Date: Mon, 22 Jul 2024 16:38:43 -0700
Message-ID: <20240722233844.1406874-10-eddyz87@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240722233844.1406874-1-eddyz87@gmail.com>
References: <20240722233844.1406874-1-eddyz87@gmail.com>
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


