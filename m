Return-Path: <bpf+bounces-33883-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A10E9273F7
	for <lists+bpf@lfdr.de>; Thu,  4 Jul 2024 12:24:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 24FA11F24CFA
	for <lists+bpf@lfdr.de>; Thu,  4 Jul 2024 10:24:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B1FD1ABC2D;
	Thu,  4 Jul 2024 10:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BvV7ElA6"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DFE71ABC3A
	for <bpf@vger.kernel.org>; Thu,  4 Jul 2024 10:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720088671; cv=none; b=sOqumF1Bw4Hvd+J/0/v/n/Euu9eYJd0fV0Wj2rP4vZ5Mw0mkMsCKrx6pPVD9MGywradRczdDrCRFtcW84bKqGI3hbEAwEyYNLOYhd7z/HLvUedMrNdUB2saKVIqzLvo0dbLnWg0MuQKpr9EWhB9lZkyl9+kYwlrPQWEB/2j8FGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720088671; c=relaxed/simple;
	bh=29n5vYJZ345T7Xft7dsQOYRPruneZOXPB+glXq8Z0yI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f4N5hWsH9iHtLgm4YCBwpGYSg6qPG0pO3O/Wt3uhngmaboHhvPl9mY9waJiDkL37zt8WUb7+v2I5RZAvs24wxfiZ56jYl9VlmsXAP19V4mxuDwwoi+4ofcxLaB7wnjTsu3tEiGrcY6cxncm1Ctkztx4vHImTdbqkD/wK1kp43VU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BvV7ElA6; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2c80637d8adso369699a91.0
        for <bpf@vger.kernel.org>; Thu, 04 Jul 2024 03:24:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720088669; x=1720693469; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dciH7Y+cZMAD4kcbt2ByOnD1Rh13u7692d9hN4gvL/4=;
        b=BvV7ElA6tzL7jUfCIL299jb2cvbZC2DwWOxBB/dcNUTF5R+qhp+thQG8BKgIzT0Faw
         IHzEI7UtTnrjMhFw98Aue5qk7kOAtLgtObUlmOprLZ+Z7lu37EYKY8MHpYoYaqJ14zHo
         vrO+Jw0I2j69jPgA+swWRbzWfNYW0cmA5BcVDv67r2LLl9Toy+qx/h3Mz4pqPKFgzmr5
         cmcLkzNa9NiX8eytL22q2IJJwqom8fJNm+/ur40GJcU3fZiPT8BKYUeHiH1uRoJYkMmi
         9D3wBIEcSWu5k+rlhMhBP9RfimNrpywWYcEmxnAtV0VoHd41O1at5E/3hzACzDf6CgeJ
         FXiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720088669; x=1720693469;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dciH7Y+cZMAD4kcbt2ByOnD1Rh13u7692d9hN4gvL/4=;
        b=om/9Eut7QW03znfbcnUYMIhxLDGrSAXfwVjpimKf8V1strvCqVuTgWUYqdmw1RrAwV
         af9uZ92bTUnXlLfCIx6/F8KiJrs0He0HWC5O3h2m3cx6V+ltkrm304KLE7WMpQ7iuSn3
         1zWvuRYZqvazpYxcQfnj/mGMfk9YhIlg9FF+24EHvsRi/U9Cm0GH2wRH8fh0/u85zYAV
         t2eT5W0jRNdDlPmnCWzE/XILft8lJq3TSmzsnkcCJg6o0VhoDx/KfqNEmN2zuNRCV0Sk
         gPDVx46cW34q37SjXeZ/Hr1zDaEuB9WFh4mrlilD5zq8qawp7aHMyPjTcrsDrxTIgHt/
         +pNA==
X-Gm-Message-State: AOJu0Ywob3v2+I44//8odZcTRQbbuU3QIVAA8AIxcSz9Hk/uV8c3Va7w
	tFQSmWuQaLtl9y+B0ltkhpoU3E6ulcRZMkQu4ZuUkybZ35CS/vFORYuxjw==
X-Google-Smtp-Source: AGHT+IGrpgh9j1u4gaM9sZDQggTGM8XKKMRNo/BWsFl+H8Mqqpc9HnzsTjHSH5MP4pi+JWtws2/hgw==
X-Received: by 2002:a17:90b:314b:b0:2c9:5fae:4f7e with SMTP id 98e67ed59e1d1-2c99c55084bmr902851a91.16.1720088668156;
        Thu, 04 Jul 2024 03:24:28 -0700 (PDT)
Received: from badger.. ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c9a4c0fe8dsm216693a91.0.2024.07.04.03.24.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jul 2024 03:24:27 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	puranjay@kernel.org,
	jose.marchesi@oracle.com,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [RFC bpf-next v2 8/9] selftests/bpf: __arch_* macro to limit test cases to specific archs
Date: Thu,  4 Jul 2024 03:24:00 -0700
Message-ID: <20240704102402.1644916-9-eddyz87@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240704102402.1644916-1-eddyz87@gmail.com>
References: <20240704102402.1644916-1-eddyz87@gmail.com>
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
index b44b6a2fc82c..97befd720541 100644
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
+	return !!(arch_mask & ARCH_X86_64);
+#elif defined(__aarch64__)
+	return !!(arch_mask & ARCH_ARM64);
+#elif defined(__riscv) && __riscv_xlen == 64
+	return !!(arch_mask & ARCH_RISCV64);
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


