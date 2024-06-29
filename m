Return-Path: <bpf+bounces-33422-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DBF391CBF4
	for <lists+bpf@lfdr.de>; Sat, 29 Jun 2024 11:48:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E4BE0B21CD2
	for <lists+bpf@lfdr.de>; Sat, 29 Jun 2024 09:48:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDF7342078;
	Sat, 29 Jun 2024 09:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iZNbZhcI"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB4C940858
	for <bpf@vger.kernel.org>; Sat, 29 Jun 2024 09:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719654495; cv=none; b=jTgGc3KVQvjHwTpjykTmnmPscPto/+V3zBP59ZGg1WEwoqP9GH88mtwlcAdWvEsjbD/QbqctddX2aZi9INyV0/CEN5f+KKgdvf0O8DBaDi3gE7kqFnkk2nWY0RjTAJHGev6bL6ezCUu/ryfaiCdqIrGvq7v+O2wBX1od98K7ED8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719654495; c=relaxed/simple;
	bh=dUme/273h2bYDL94/PNwDiEcNu1qMYHju32TPFHb0jI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e3+xQs05iBTyOgmKoSh8/sh3sOV0a2eFKSqPMhW5WqFWKI29/DVJVeM2G7hNXeAE94R/qOlqLwxb0hx5pTPFA5DrNB+FS/axZpwLGMEf4KegEf1yh+jTs7LyMs1ovJBLmzl29cvrmeD4gxV1wPCkQ3+yTp7nV9mrvHE7JxGocHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iZNbZhcI; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-3d566d5eda9so730995b6e.0
        for <bpf@vger.kernel.org>; Sat, 29 Jun 2024 02:48:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719654493; x=1720259293; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QHAnBbmnrS9ddngMLWtcJO0VwQYCAVjSLoLQMRLwmMU=;
        b=iZNbZhcI6dlU6WZAx9xBsusnpdcPpHmePIW8uSDZEc3vNhLC7pWbTJOXDAid0HrKCY
         cPo0KwIhTnI/y8Cnu6Js6hqSu994OWMeX7klKIZxvZ032C+iT/SzVbBIa/ldgcd7h06C
         mBv7YbAhhbYYdeUdWuaZIEV+im5iZtY/4lvbEo1/w84aLYdC1f4u0ZawmFNduQeuPme8
         Cjn5jfbLl5RmQg5KhiL3phlVhF9uGSxiS4MUDKPVqniXKZFZQkQoDhbdMXozxCq1kdUq
         /k0PEO5Bk71ulo3oYX35dInqOuMH/JlERdxpseIf9FecjHRNS6UnKs+Pb7/QYAa6nl7a
         4Pvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719654493; x=1720259293;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QHAnBbmnrS9ddngMLWtcJO0VwQYCAVjSLoLQMRLwmMU=;
        b=md+lE6T4efuZLdpm9V9vGwXXBtWF/+KNPNeJz45zW125HqDvW62jLQ4MHsci77PADl
         5AZSt0AY++M01uL8BHMSrH/uCBAbOtjR8iYluuwzNOcHQHtNPBk3rHMKO6h1UCNy7nwt
         82ufeolmFogrmdaMMGwslDfgBIRQlj86ymrk5Gd/YYAdWEohMYVvG5XebfP7Lrm7XoCN
         xKhKfeSTWPEeB/ohby2ilnmUVJKz/GHsCSqrjwn4HVB+4BpkJb1zKGj7YEfUI9pF6006
         s70J2oHAJVPXwO2kx5SA6g98XCpH0CCdfvSFVznfk+Ho9apw5+7YMnoHCTb8w9Yh2mTt
         cu/g==
X-Gm-Message-State: AOJu0Yxt3mCpk4EDVMgWw17aBTD1HbPQXrVREy5BwKqmFYFz3ICKurmo
	Mb3Z0x2ICv3HzlIJ2EpvwxqePV2J6jrHUU+/C0HJJLWqPNP8znqrRmKrTA==
X-Google-Smtp-Source: AGHT+IFWEvIbklmFpsgiiqn6NU2EMaVSSexmVByBVUiymf+dAgpKmBOTWFwUHKzahSlzO2z1Vkb4ig==
X-Received: by 2002:a05:6808:1789:b0:3d5:670f:baa5 with SMTP id 5614622812f47-3d6b4de2d0amr730205b6e.44.1719654492558;
        Sat, 29 Jun 2024 02:48:12 -0700 (PDT)
Received: from badger.. ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70804989f5asm2948932b3a.195.2024.06.29.02.48.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Jun 2024 02:48:12 -0700 (PDT)
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
Subject: [RFC bpf-next v1 7/8] selftests/bpf: allow checking xlated programs in verifier_* tests
Date: Sat, 29 Jun 2024 02:47:32 -0700
Message-ID: <20240629094733.3863850-8-eddyz87@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240629094733.3863850-1-eddyz87@gmail.com>
References: <20240629094733.3863850-1-eddyz87@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a macro __xlated("...") for use with test_loader tests.

When such annotations are present for the test case:
- bpf_prog_get_info_by_fd() is used to get BPF program after all
  rewrites are applied by verifier.
- the program is diassembled and patterns specified in __xlated are
  searched for in the disassembly text.

__xlated matching follows the same mechanics as __msg:
each subsequent pattern is matched from the point where
previous pattern ended.

This allows to write tests like below, where the goal is to verify the
behavior of one of the of the transformations applied by verifier:

    SEC("raw_tp")
    __xlated("1: w0 = ")
    __xlated("2: r0 = &(void __percpu *)(r0)")
    __xlated("3: r0 = *(u32 *)(r0 +0)")
    __xlated("4: exit")
    __success __naked void simple(void)
    {
            asm volatile (
            "call %[bpf_get_smp_processor_id];"
            "exit;"
            :
            : __imm(bpf_get_smp_processor_id)
            : __clobber_all);
    }

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 tools/testing/selftests/bpf/progs/bpf_misc.h |  6 ++
 tools/testing/selftests/bpf/test_loader.c    | 80 +++++++++++++++++++-
 2 files changed, 83 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/bpf_misc.h b/tools/testing/selftests/bpf/progs/bpf_misc.h
index 81097a3f15eb..fac131a23578 100644
--- a/tools/testing/selftests/bpf/progs/bpf_misc.h
+++ b/tools/testing/selftests/bpf/progs/bpf_misc.h
@@ -26,6 +26,9 @@
  *
  * __regex           Same as __msg, but using a regular expression.
  * __regex_unpriv    Same as __msg_unpriv but using a regular expression.
+ * __xlated          Expect a line in a disassembly log after verifier applies rewrites.
+ *                   Multiple __xlated attributes could be specified.
+ * __xlated_unpriv   Same as __xlated but for unprivileged mode.
  *
  * __success         Expect program load success in privileged mode.
  * __success_unpriv  Expect program load success in unprivileged mode.
@@ -63,11 +66,14 @@
  */
 #define __msg(msg)		__attribute__((btf_decl_tag("comment:test_expect_msg=" msg)))
 #define __regex(regex)		__attribute__((btf_decl_tag("comment:test_expect_regex=" regex)))
+#define __xlated(msg)		__attribute__((btf_decl_tag("comment:test_expect_xlated=" msg)))
 #define __failure		__attribute__((btf_decl_tag("comment:test_expect_failure")))
 #define __success		__attribute__((btf_decl_tag("comment:test_expect_success")))
 #define __description(desc)	__attribute__((btf_decl_tag("comment:test_description=" desc)))
 #define __msg_unpriv(msg)	__attribute__((btf_decl_tag("comment:test_expect_msg_unpriv=" msg)))
 #define __regex_unpriv(regex)	__attribute__((btf_decl_tag("comment:test_expect_regex_unpriv=" regex)))
+#define __xlated_unpriv(msg)	\
+	__attribute__((btf_decl_tag("comment:test_expect_xlated_unpriv=" msg)))
 #define __failure_unpriv	__attribute__((btf_decl_tag("comment:test_expect_failure_unpriv")))
 #define __success_unpriv	__attribute__((btf_decl_tag("comment:test_expect_success_unpriv")))
 #define __log_level(lvl)	__attribute__((btf_decl_tag("comment:test_log_level="#lvl)))
diff --git a/tools/testing/selftests/bpf/test_loader.c b/tools/testing/selftests/bpf/test_loader.c
index d4bb68685ba5..8e5f051801db 100644
--- a/tools/testing/selftests/bpf/test_loader.c
+++ b/tools/testing/selftests/bpf/test_loader.c
@@ -7,6 +7,7 @@
 #include <bpf/btf.h>
 
 #include "autoconf_helper.h"
+#include "disasm_helpers.h"
 #include "unpriv_helpers.h"
 #include "cap_helpers.h"
 
@@ -19,10 +20,12 @@
 #define TEST_TAG_EXPECT_SUCCESS "comment:test_expect_success"
 #define TEST_TAG_EXPECT_MSG_PFX "comment:test_expect_msg="
 #define TEST_TAG_EXPECT_REGEX_PFX "comment:test_expect_regex="
+#define TEST_TAG_EXPECT_XLATED_PFX "comment:test_expect_xlated="
 #define TEST_TAG_EXPECT_FAILURE_UNPRIV "comment:test_expect_failure_unpriv"
 #define TEST_TAG_EXPECT_SUCCESS_UNPRIV "comment:test_expect_success_unpriv"
 #define TEST_TAG_EXPECT_MSG_PFX_UNPRIV "comment:test_expect_msg_unpriv="
 #define TEST_TAG_EXPECT_REGEX_PFX_UNPRIV "comment:test_expect_regex_unpriv="
+#define TEST_TAG_EXPECT_XLATED_PFX_UNPRIV "comment:test_expect_xlated_unpriv="
 #define TEST_TAG_LOG_LEVEL_PFX "comment:test_log_level="
 #define TEST_TAG_PROG_FLAGS_PFX "comment:test_prog_flags="
 #define TEST_TAG_DESCRIPTION_PFX "comment:test_description="
@@ -64,6 +67,7 @@ struct test_subspec {
 	char *name;
 	bool expect_failure;
 	struct msgs expect_msgs;
+	struct msgs expect_xlated;
 	int retval;
 	bool execute;
 };
@@ -117,6 +121,8 @@ static void free_test_spec(struct test_spec *spec)
 	/* Deallocate expect_msgs arrays. */
 	free_msgs(&spec->priv.expect_msgs);
 	free_msgs(&spec->unpriv.expect_msgs);
+	free_msgs(&spec->priv.expect_xlated);
+	free_msgs(&spec->unpriv.expect_xlated);
 
 	free(spec->priv.name);
 	free(spec->unpriv.name);
@@ -299,6 +305,18 @@ static int parse_test_spec(struct test_loader *tester,
 			if (err)
 				goto cleanup;
 			spec->mode_mask |= UNPRIV;
+		} else if (str_has_pfx(s, TEST_TAG_EXPECT_XLATED_PFX)) {
+			msg = s + sizeof(TEST_TAG_EXPECT_XLATED_PFX) - 1;
+			err = push_msg(msg, NULL, &spec->priv.expect_xlated);
+			if (err)
+				goto cleanup;
+			spec->mode_mask |= PRIV;
+		} else if (str_has_pfx(s, TEST_TAG_EXPECT_XLATED_PFX_UNPRIV)) {
+			msg = s + sizeof(TEST_TAG_EXPECT_XLATED_PFX_UNPRIV) - 1;
+			err = push_msg(msg, NULL, &spec->unpriv.expect_xlated);
+			if (err)
+				goto cleanup;
+			spec->mode_mask |= UNPRIV;
 		} else if (str_has_pfx(s, TEST_TAG_RETVAL_PFX)) {
 			val = s + sizeof(TEST_TAG_RETVAL_PFX) - 1;
 			err = parse_retval(val, &spec->priv.retval, "__retval");
@@ -402,6 +420,16 @@ static int parse_test_spec(struct test_loader *tester,
 					goto cleanup;
 			}
 		}
+		if (spec->unpriv.expect_xlated.cnt == 0) {
+			for (i = 0; i < spec->priv.expect_xlated.cnt; i++) {
+				struct expect_msg *msg = &spec->priv.expect_xlated.patterns[i];
+
+				err = push_msg(msg->substr, msg->regex_str,
+					       &spec->unpriv.expect_xlated);
+				if (err)
+					goto cleanup;
+			}
+		}
 	}
 
 	spec->valid = true;
@@ -449,7 +477,15 @@ static void emit_verifier_log(const char *log_buf, bool force)
 	fprintf(stdout, "VERIFIER LOG:\n=============\n%s=============\n", log_buf);
 }
 
-static void validate_msgs(char *log_buf, struct msgs *msgs)
+static void emit_xlated(const char *xlated, bool force)
+{
+	if (!force && env.verbosity == VERBOSE_NONE)
+		return;
+	fprintf(stdout, "XLATED:\n=============\n%s=============\n", xlated);
+}
+
+static void validate_msgs(char *log_buf, struct msgs *msgs,
+			  void (*emit_fn)(const char *buf, bool force))
 {
 	regmatch_t reg_match[1];
 	const char *match;
@@ -475,7 +511,7 @@ static void validate_msgs(char *log_buf, struct msgs *msgs)
 
 		if (!ASSERT_OK_PTR(match, "expect_msg")) {
 			if (env.verbosity == VERBOSE_NONE)
-				emit_verifier_log(log_buf, true /*force*/);
+				emit_fn(log_buf, true /*force*/);
 			for (j = 0; j <= i; j++) {
 				msg = &msgs->patterns[j];
 				fprintf(stderr, "%s %s: '%s'\n",
@@ -612,6 +648,35 @@ static bool should_do_test_run(struct test_spec *spec, struct test_subspec *subs
 	return true;
 }
 
+/* Get a disassembly of BPF program after verifier applies all rewrites */
+static int get_xlated_program_text(int prog_fd, char *text, size_t text_sz)
+{
+	__u32 insns_cnt = 0, i, insn_sz;
+	struct bpf_insn *insns = NULL;
+	char buf[64];
+	FILE *out = NULL;
+	int err;
+
+	err = get_xlated_program(prog_fd, &insns, &insns_cnt);
+	if (!ASSERT_OK(err, "get_xlated_program"))
+		goto out;
+	out = fmemopen(text, text_sz, "w");
+	if (!ASSERT_OK_PTR(out, "open_memstream"))
+		goto out;
+	for (i = 0; i < insns_cnt;) {
+		insn_sz = disasm_insn(insns + i, buf, sizeof(buf));
+		fprintf(out, "%d: %s\n", i, buf);
+		i += insn_sz;
+	}
+	fflush(out);
+
+out:
+	free(insns);
+	if (out)
+		fclose(out);
+	return err;
+}
+
 /* this function is forced noinline and has short generic name to look better
  * in test_progs output (in case of a failure)
  */
@@ -697,7 +762,16 @@ void run_subtest(struct test_loader *tester,
 		}
 	}
 	emit_verifier_log(tester->log_buf, false /*force*/);
-	validate_msgs(tester->log_buf, &subspec->expect_msgs);
+	validate_msgs(tester->log_buf, &subspec->expect_msgs, emit_verifier_log);
+
+	if (subspec->expect_xlated.cnt) {
+		err = get_xlated_program_text(bpf_program__fd(tprog),
+					      tester->log_buf, tester->log_buf_sz);
+		if (err)
+			goto tobj_cleanup;
+		emit_xlated(tester->log_buf, false /*force*/);
+		validate_msgs(tester->log_buf, &subspec->expect_xlated, emit_xlated);
+	}
 
 	if (should_do_test_run(spec, subspec)) {
 		/* For some reason test_verifier executes programs
-- 
2.45.2


