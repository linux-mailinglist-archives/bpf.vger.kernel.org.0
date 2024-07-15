Return-Path: <bpf+bounces-34861-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E50C5931D73
	for <lists+bpf@lfdr.de>; Tue, 16 Jul 2024 01:03:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 150CD1C21777
	for <lists+bpf@lfdr.de>; Mon, 15 Jul 2024 23:03:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01F041448E9;
	Mon, 15 Jul 2024 23:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GgcNwAbA"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9BD813FD66
	for <bpf@vger.kernel.org>; Mon, 15 Jul 2024 23:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721084559; cv=none; b=as8fb2lIt8PlGyztj+EB5Mb4Px8DNBFbwSLs2eAoOYo9eizNlLAkk5WA6/TDqsov/1PxoON3BsKJC8YsN1jJgOKGJ8AWQBjMQ0EuJPbv1SuRDjAwK7WKm23miLtAfNRae3kNgCkapiYUlNXRlzrB1xdjdavM+7V9fFJIdkZSDAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721084559; c=relaxed/simple;
	bh=NBnUPa5kXeybE0bH0innWyI3Q4aBa3Uz3jPNvmzZ6f0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H/k07MPvKxLs2GOK8Zb8H6I/UyOLwERVLFSPvgGyYbuOwgVYxcEg11/Ml/nWlQxEHCQk7WJGvJClZ/EvLn0sYkAPpcw8CcY+qb2Uh4R3loT4i3IFUg/FPgN4ljA26V1E4e1d4Yg/1EgF2eoL8SE/QMFwBn9AwLPqfjltLm06oOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GgcNwAbA; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-70b0e7f6f8bso4224717b3a.3
        for <bpf@vger.kernel.org>; Mon, 15 Jul 2024 16:02:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721084557; x=1721689357; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dhxKVSVlOw2OBGqZZRk30w4flqSDWzJlPRFfdg9zOrs=;
        b=GgcNwAbAXqgBsaz9iQmb9OT7PsFJxt+pOC4DS5j6uQnho8ZUSmnfuG0AtPdRNtTOmj
         VAmTeCVWOvEPU2Fb7RqTmjqXlls1r21fbDFDyPuU+PwqId/SqrukxMZ6PWns2SlS5AqO
         rYkW7obDblDcQBN89ZzFK+E0e7K1JPjpI4JEz6XkhuMGJ8m2XIZxWB7AV7pjlHsnLcOU
         Y1FY+jF3xbT/tr4dBi0j2A5L2TM2Dvbr/De1Cf6QN5LU1NB6ViT+rQ0oju3RFiLmrg2V
         M1teeVNS3XX6THyaIuMM8jpZgq8Va23ITiuBjFztdYC2W+BEU6iJj6KELMqHy6KMBZW0
         y8cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721084557; x=1721689357;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dhxKVSVlOw2OBGqZZRk30w4flqSDWzJlPRFfdg9zOrs=;
        b=BVaGJgqNu2cThiYIzbZ5gLxP2R8FmWgp18EqC/0W+hTt2+RxcsSXZfM5R9WPfeaiHF
         +C/RK19gxFQUOpSE85tGbSdgJW1XF/yaylmeV/uWkFEHpacPh3waIjueP7GH+DoyLz1K
         7QdDWB/h+1kxON7Ex87MbBNB5D7hwyE3UKZP3D23sS6fzujLT4QOrD/RtG4qIFpQzt3Z
         +KBl7QRvI58sG3MRrCP0AQYGoVdePZuD05LhQ5tyw1ualg92iAWqBi4Bf9bzHZyZMowe
         5AV9W9urup0HQrWrisYj4xtZP/4jjEIO4Tue60CE71F6hXoKUh9w38au8dTGn+xYieJV
         2JFw==
X-Gm-Message-State: AOJu0YxpbDT70h+K0yaSqP+FTzFL9HXaGROZGlLvLjZO0iPrg5WO41Nx
	vV8ae6Fu6ntwiL5c9lZLjjSSFKco6FgHHXkwV2MsR4fAPnBpAwfjp4Wceg==
X-Google-Smtp-Source: AGHT+IE/Bg5Eep+q4jkxG7yitzrE/1RWm8GqyfcFlA2JRr3mqGAjyIedxRgY1qRrP83wXShz+V23Tg==
X-Received: by 2002:a05:6a00:140d:b0:70b:5b21:6c2 with SMTP id d2e1a72fcca58-70c2ea11d0bmr602141b3a.31.1721084555410;
        Mon, 15 Jul 2024 16:02:35 -0700 (PDT)
Received: from badger.. ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70b7ecc9d36sm4915344b3a.205.2024.07.15.16.02.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jul 2024 16:02:34 -0700 (PDT)
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
Subject: [bpf-next v3 08/12] selftests/bpf: allow checking xlated programs in verifier_* tests
Date: Mon, 15 Jul 2024 16:01:57 -0700
Message-ID: <20240715230201.3901423-9-eddyz87@gmail.com>
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

Add a macro __xlated("...") for use with test_loader tests.

When such annotations are present for the test case:
- bpf_prog_get_info_by_fd() is used to get BPF program after all
  rewrites are applied by verifier.
- the program is disassembled and patterns specified in __xlated are
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

Acked-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 tools/testing/selftests/bpf/progs/bpf_misc.h |  5 ++
 tools/testing/selftests/bpf/test_loader.c    | 82 +++++++++++++++++++-
 2 files changed, 84 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/bpf_misc.h b/tools/testing/selftests/bpf/progs/bpf_misc.h
index 81097a3f15eb..a70939c7bc26 100644
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
@@ -63,11 +66,13 @@
  */
 #define __msg(msg)		__attribute__((btf_decl_tag("comment:test_expect_msg=" msg)))
 #define __regex(regex)		__attribute__((btf_decl_tag("comment:test_expect_regex=" regex)))
+#define __xlated(msg)		__attribute__((btf_decl_tag("comment:test_expect_xlated=" msg)))
 #define __failure		__attribute__((btf_decl_tag("comment:test_expect_failure")))
 #define __success		__attribute__((btf_decl_tag("comment:test_expect_success")))
 #define __description(desc)	__attribute__((btf_decl_tag("comment:test_description=" desc)))
 #define __msg_unpriv(msg)	__attribute__((btf_decl_tag("comment:test_expect_msg_unpriv=" msg)))
 #define __regex_unpriv(regex)	__attribute__((btf_decl_tag("comment:test_expect_regex_unpriv=" regex)))
+#define __xlated_unpriv(msg)	__attribute__((btf_decl_tag("comment:test_expect_xlated_unpriv=" msg)))
 #define __failure_unpriv	__attribute__((btf_decl_tag("comment:test_expect_failure_unpriv")))
 #define __success_unpriv	__attribute__((btf_decl_tag("comment:test_expect_success_unpriv")))
 #define __log_level(lvl)	__attribute__((btf_decl_tag("comment:test_log_level="#lvl)))
diff --git a/tools/testing/selftests/bpf/test_loader.c b/tools/testing/selftests/bpf/test_loader.c
index 3f84903558dd..b44b6a2fc82c 100644
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
 	struct expected_msgs expect_msgs;
+	struct expected_msgs expect_xlated;
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
 
-static void validate_msgs(char *log_buf, struct expected_msgs *msgs)
+static void emit_xlated(const char *xlated, bool force)
+{
+	if (!force && env.verbosity == VERBOSE_NONE)
+		return;
+	fprintf(stdout, "XLATED:\n=============\n%s=============\n", xlated);
+}
+
+static void validate_msgs(char *log_buf, struct expected_msgs *msgs,
+			  void (*emit_fn)(const char *buf, bool force))
 {
 	regmatch_t reg_match[1];
 	const char *log = log_buf;
@@ -473,7 +509,7 @@ static void validate_msgs(char *log_buf, struct expected_msgs *msgs)
 
 		if (!ASSERT_OK_PTR(match, "expect_msg")) {
 			if (env.verbosity == VERBOSE_NONE)
-				emit_verifier_log(log_buf, true /*force*/);
+				emit_fn(log_buf, true /*force*/);
 			for (j = 0; j <= i; j++) {
 				msg = &msgs->patterns[j];
 				fprintf(stderr, "%s %s: '%s'\n",
@@ -610,6 +646,37 @@ static bool should_do_test_run(struct test_spec *spec, struct test_subspec *subs
 	return true;
 }
 
+/* Get a disassembly of BPF program after verifier applies all rewrites */
+static int get_xlated_program_text(int prog_fd, char *text, size_t text_sz)
+{
+	struct bpf_insn *insn_start = NULL, *insn, *insn_end;
+	__u32 insns_cnt = 0, i;
+	char buf[64];
+	FILE *out = NULL;
+	int err;
+
+	err = get_xlated_program(prog_fd, &insn_start, &insns_cnt);
+	if (!ASSERT_OK(err, "get_xlated_program"))
+		goto out;
+	out = fmemopen(text, text_sz, "w");
+	if (!ASSERT_OK_PTR(out, "open_memstream"))
+		goto out;
+	insn_end = insn_start + insns_cnt;
+	insn = insn_start;
+	while (insn < insn_end) {
+		i = insn - insn_start;
+		insn = disasm_insn(insn, buf, sizeof(buf));
+		fprintf(out, "%d: %s\n", i, buf);
+	}
+	fflush(out);
+
+out:
+	free(insn_start);
+	if (out)
+		fclose(out);
+	return err;
+}
+
 /* this function is forced noinline and has short generic name to look better
  * in test_progs output (in case of a failure)
  */
@@ -695,7 +762,16 @@ void run_subtest(struct test_loader *tester,
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


