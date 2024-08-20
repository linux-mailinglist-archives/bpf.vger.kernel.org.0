Return-Path: <bpf+bounces-37619-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A1A4B95845C
	for <lists+bpf@lfdr.de>; Tue, 20 Aug 2024 12:26:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5ECA1C24D2F
	for <lists+bpf@lfdr.de>; Tue, 20 Aug 2024 10:26:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D422718E77E;
	Tue, 20 Aug 2024 10:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H4T7c9t3"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2C3B18E777
	for <bpf@vger.kernel.org>; Tue, 20 Aug 2024 10:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724149457; cv=none; b=kTcydzHzh43LCoRzJnEfjumqlWEz/xgedM/frTtlTtno4vOvm3N7Fd3XU6ontJWfHTaxfKTZ3E4rUYSW2PQJpXylVFggBXXfDhOpRrEkskxDwKJKQeeG3ZLqDEfZLDAdj32eXHYannkK2zyhEu196zPKBqXz+DzTUdCQ5LhGl/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724149457; c=relaxed/simple;
	bh=CP3j8P9oCjLejwVeg3t9skFTS9910f9FzEPrtMdaJRc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pcFQAsFe4Yiwk3BM43GapPGm/kTIxv8m0tQlRGUJ/hBrszUWxG/RPvrpBAInbFKd6588TGZd657WA7k0WcYw4IWxGIPDaS026ADvGVHeLtdEemoAjxey8jCS6fJgOq19aCp6WGWBxHtui13BtwJi6t5FQz/QDKPeKM6QfZZuSxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H4T7c9t3; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-7afd1aeac83so4181666a12.0
        for <bpf@vger.kernel.org>; Tue, 20 Aug 2024 03:24:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724149455; x=1724754255; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=++j0dC+7bK15CEdljY1lUn2fuean9+wtaZWzhBX4JRU=;
        b=H4T7c9t3Z5tpXOfcc90DJPw32/SNg3Ij2sKYRQwNKbYCVVx5Il5CuQMtMfT7db6Kzc
         bpp7m116QLW9+8Upm01K0K/Ma1IyWDPnbN5z3WjJLT08yyavaMj9e4uvm3xVQ1Ay5+WX
         mJ5esRzWHTRUTbJP6WT5tWkXOThDEndlWB1nkd1j34ebyLXBqkdNcWSaFMrbKR99aC50
         gY0oJ14DffINIKBYIKo9Ydospbq15fZynHnTDZri4EZ47WSnZoOmM3YqzO7JfJR+hr/z
         OvzaXQyltvi+TFVj4/NyiZ7pqj0eoOgAPgcJ5eSkzxD9OPoD2ZPv72pSpAmKaz1gNS/u
         tP9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724149455; x=1724754255;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=++j0dC+7bK15CEdljY1lUn2fuean9+wtaZWzhBX4JRU=;
        b=YCiHpHSVALrzkfk1Olt+YdR478m6egyPiycPet1E2YlghHvFvMCnkXmmvx+9zM6gt6
         i4zRGFcOHp6/RvFi8DXaHJRuV4qGwoDAZ2mVbjEIEngIzZ3+WfwzhD3R6wEDvthk0f/j
         P2Sfxszy0ZkfkYY57//kEiQHOtbH3ywkjyu5G3BFZxfGVjvSxvrJngAO75fGOqWwzGQk
         4tNpW1xq+oPGGlVIPH+V904Jbe2sqg09wb9GHn7lW8qpEVtEL07DW0Uvs9yOPeZnz9A/
         4MnH8VJionFVuAxYCqvglc1XIsMQLgXbjg0jGWMXX9jDWMDu/I7+fS0mPk+8VwE4Xc9r
         qrrA==
X-Gm-Message-State: AOJu0Yy5iAQ679zO4RBEjDxm2ByzECVn4+65NYgW7bru+Ck5B7eut/13
	16JxZG49MlIhRuimWs0Z9OV3S31/0lcQIeK5j34WfTBS/CrbulaWpxYHdcAd
X-Google-Smtp-Source: AGHT+IHoSfe/yKfffQNYGVBt5nIrfdJi11rhUTSSFSIuhwc4qPvj51WJpCeqeb1gG1ZAiJAU4LE2SA==
X-Received: by 2002:a17:90b:1e12:b0:2c9:75a7:5c25 with SMTP id 98e67ed59e1d1-2d4733ff749mr3727785a91.15.1724149454872;
        Tue, 20 Aug 2024 03:24:14 -0700 (PDT)
Received: from honey-badger.. ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d3e3174bfdsm8976166a91.27.2024.08.20.03.24.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2024 03:24:14 -0700 (PDT)
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
Subject: [PATCH bpf-next v3 3/8] selftests/bpf: fix to avoid __msg tag de-duplication by clang
Date: Tue, 20 Aug 2024 03:23:51 -0700
Message-ID: <20240820102357.3372779-4-eddyz87@gmail.com>
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

__msg, __regex and __xlated tags are based on
__attribute__((btf_decl_tag("..."))) annotations.

Clang de-duplicates such annotations, e.g. the following
two sequences of tags are identical in final BTF:

    /* seq A */            /* seq B */
    __tag("foo")           __tag("foo")
    __tag("bar")           __tag("bar")
    __tag("foo")

Fix this by adding a unique suffix for each tag using __COUNTER__
pre-processor macro. E.g. here is a new definition for __msg:

    #define __msg(msg) \
      __attribute__((btf_decl_tag("comment:test_expect_msg=" XSTR(__COUNTER__) "=" msg)))

Using this definition the "seq A" from example above is translated to
BTF as follows:

    [..] DECL_TAG 'comment:test_expect_msg=0=foo' type_id=X component_idx=-1
    [..] DECL_TAG 'comment:test_expect_msg=1=bar' type_id=X component_idx=-1
    [..] DECL_TAG 'comment:test_expect_msg=2=foo' type_id=X component_idx=-1

Surprisingly, this bug affects a single existing test:
verifier_spill_fill/old_stack_misc_vs_cur_ctx_ptr,
where sequence of identical messages was expected in the log.

Fixes: 537c3f66eac1 ("selftests/bpf: add generic BPF program tester-loader")
Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 tools/testing/selftests/bpf/progs/bpf_misc.h  | 15 +++---
 .../selftests/bpf/progs/verifier_spill_fill.c |  8 ++--
 tools/testing/selftests/bpf/test_loader.c     | 47 ++++++++++++++-----
 3 files changed, 48 insertions(+), 22 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/bpf_misc.h b/tools/testing/selftests/bpf/progs/bpf_misc.h
index a225cd87897c..4f1029743734 100644
--- a/tools/testing/selftests/bpf/progs/bpf_misc.h
+++ b/tools/testing/selftests/bpf/progs/bpf_misc.h
@@ -2,6 +2,9 @@
 #ifndef __BPF_MISC_H__
 #define __BPF_MISC_H__
 
+#define XSTR(s) STR(s)
+#define STR(s) #s
+
 /* This set of attributes controls behavior of the
  * test_loader.c:test_loader__run_subtests().
  *
@@ -68,15 +71,15 @@
  *                   Several __arch_* annotations could be specified at once.
  *                   When test case is not run on current arch it is marked as skipped.
  */
-#define __msg(msg)		__attribute__((btf_decl_tag("comment:test_expect_msg=" msg)))
-#define __regex(regex)		__attribute__((btf_decl_tag("comment:test_expect_regex=" regex)))
-#define __xlated(msg)		__attribute__((btf_decl_tag("comment:test_expect_xlated=" msg)))
+#define __msg(msg)		__attribute__((btf_decl_tag("comment:test_expect_msg=" XSTR(__COUNTER__) "=" msg)))
+#define __regex(regex)		__attribute__((btf_decl_tag("comment:test_expect_regex=" XSTR(__COUNTER__) "=" regex)))
+#define __xlated(msg)		__attribute__((btf_decl_tag("comment:test_expect_xlated=" XSTR(__COUNTER__) "=" msg)))
 #define __failure		__attribute__((btf_decl_tag("comment:test_expect_failure")))
 #define __success		__attribute__((btf_decl_tag("comment:test_expect_success")))
 #define __description(desc)	__attribute__((btf_decl_tag("comment:test_description=" desc)))
-#define __msg_unpriv(msg)	__attribute__((btf_decl_tag("comment:test_expect_msg_unpriv=" msg)))
-#define __regex_unpriv(regex)	__attribute__((btf_decl_tag("comment:test_expect_regex_unpriv=" regex)))
-#define __xlated_unpriv(msg)	__attribute__((btf_decl_tag("comment:test_expect_xlated_unpriv=" msg)))
+#define __msg_unpriv(msg)	__attribute__((btf_decl_tag("comment:test_expect_msg_unpriv=" XSTR(__COUNTER__) "=" msg)))
+#define __regex_unpriv(regex)	__attribute__((btf_decl_tag("comment:test_expect_regex_unpriv=" XSTR(__COUNTER__) "=" regex)))
+#define __xlated_unpriv(msg)	__attribute__((btf_decl_tag("comment:test_expect_xlated_unpriv=" XSTR(__COUNTER__) "=" msg)))
 #define __failure_unpriv	__attribute__((btf_decl_tag("comment:test_expect_failure_unpriv")))
 #define __success_unpriv	__attribute__((btf_decl_tag("comment:test_expect_success_unpriv")))
 #define __log_level(lvl)	__attribute__((btf_decl_tag("comment:test_log_level="#lvl)))
diff --git a/tools/testing/selftests/bpf/progs/verifier_spill_fill.c b/tools/testing/selftests/bpf/progs/verifier_spill_fill.c
index 9d288ec7a168..671d9f415dbf 100644
--- a/tools/testing/selftests/bpf/progs/verifier_spill_fill.c
+++ b/tools/testing/selftests/bpf/progs/verifier_spill_fill.c
@@ -1213,10 +1213,10 @@ __success  __log_level(2)
  * - once for path entry - label 2;
  * - once for path entry - label 1 - label 2.
  */
-__msg("r1 = *(u64 *)(r10 -8)")
-__msg("exit")
-__msg("r1 = *(u64 *)(r10 -8)")
-__msg("exit")
+__msg("8: (79) r1 = *(u64 *)(r10 -8)")
+__msg("9: (95) exit")
+__msg("from 2 to 7")
+__msg("8: safe")
 __msg("processed 11 insns")
 __flag(BPF_F_TEST_STATE_FREQ)
 __naked void old_stack_misc_vs_cur_ctx_ptr(void)
diff --git a/tools/testing/selftests/bpf/test_loader.c b/tools/testing/selftests/bpf/test_loader.c
index f5f5d16ac550..c604a82e03c4 100644
--- a/tools/testing/selftests/bpf/test_loader.c
+++ b/tools/testing/selftests/bpf/test_loader.c
@@ -215,6 +215,35 @@ static void update_flags(int *flags, int flag, bool clear)
 		*flags |= flag;
 }
 
+/* Matches a string of form '<pfx>[^=]=.*' and returns it's suffix.
+ * Used to parse btf_decl_tag values.
+ * Such values require unique prefix because compiler does not add
+ * same __attribute__((btf_decl_tag(...))) twice.
+ * Test suite uses two-component tags for such cases:
+ *
+ *   <pfx> __COUNTER__ '='
+ *
+ * For example, two consecutive __msg tags '__msg("foo") __msg("foo")'
+ * would be encoded as:
+ *
+ *   [18] DECL_TAG 'comment:test_expect_msg=0=foo' type_id=15 component_idx=-1
+ *   [19] DECL_TAG 'comment:test_expect_msg=1=foo' type_id=15 component_idx=-1
+ *
+ * And the purpose of this function is to extract 'foo' from the above.
+ */
+static const char *skip_dynamic_pfx(const char *s, const char *pfx)
+{
+	const char *msg;
+
+	if (strncmp(s, pfx, strlen(pfx)) != 0)
+		return NULL;
+	msg = s + strlen(pfx);
+	msg = strchr(msg, '=');
+	if (!msg)
+		return NULL;
+	return msg + 1;
+}
+
 enum arch {
 	ARCH_X86_64	= 0x1,
 	ARCH_ARM64	= 0x2,
@@ -290,38 +319,32 @@ static int parse_test_spec(struct test_loader *tester,
 		} else if (strcmp(s, TEST_TAG_AUXILIARY_UNPRIV) == 0) {
 			spec->auxiliary = true;
 			spec->mode_mask |= UNPRIV;
-		} else if (str_has_pfx(s, TEST_TAG_EXPECT_MSG_PFX)) {
-			msg = s + sizeof(TEST_TAG_EXPECT_MSG_PFX) - 1;
+		} else if ((msg = skip_dynamic_pfx(s, TEST_TAG_EXPECT_MSG_PFX))) {
 			err = push_msg(msg, NULL, &spec->priv.expect_msgs);
 			if (err)
 				goto cleanup;
 			spec->mode_mask |= PRIV;
-		} else if (str_has_pfx(s, TEST_TAG_EXPECT_MSG_PFX_UNPRIV)) {
-			msg = s + sizeof(TEST_TAG_EXPECT_MSG_PFX_UNPRIV) - 1;
+		} else if ((msg = skip_dynamic_pfx(s, TEST_TAG_EXPECT_MSG_PFX_UNPRIV))) {
 			err = push_msg(msg, NULL, &spec->unpriv.expect_msgs);
 			if (err)
 				goto cleanup;
 			spec->mode_mask |= UNPRIV;
-		} else if (str_has_pfx(s, TEST_TAG_EXPECT_REGEX_PFX)) {
-			msg = s + sizeof(TEST_TAG_EXPECT_REGEX_PFX) - 1;
+		} else if ((msg = skip_dynamic_pfx(s, TEST_TAG_EXPECT_REGEX_PFX))) {
 			err = push_msg(NULL, msg, &spec->priv.expect_msgs);
 			if (err)
 				goto cleanup;
 			spec->mode_mask |= PRIV;
-		} else if (str_has_pfx(s, TEST_TAG_EXPECT_REGEX_PFX_UNPRIV)) {
-			msg = s + sizeof(TEST_TAG_EXPECT_REGEX_PFX_UNPRIV) - 1;
+		} else if ((msg = skip_dynamic_pfx(s, TEST_TAG_EXPECT_REGEX_PFX_UNPRIV))) {
 			err = push_msg(NULL, msg, &spec->unpriv.expect_msgs);
 			if (err)
 				goto cleanup;
 			spec->mode_mask |= UNPRIV;
-		} else if (str_has_pfx(s, TEST_TAG_EXPECT_XLATED_PFX)) {
-			msg = s + sizeof(TEST_TAG_EXPECT_XLATED_PFX) - 1;
+		} else if ((msg = skip_dynamic_pfx(s, TEST_TAG_EXPECT_XLATED_PFX))) {
 			err = push_msg(msg, NULL, &spec->priv.expect_xlated);
 			if (err)
 				goto cleanup;
 			spec->mode_mask |= PRIV;
-		} else if (str_has_pfx(s, TEST_TAG_EXPECT_XLATED_PFX_UNPRIV)) {
-			msg = s + sizeof(TEST_TAG_EXPECT_XLATED_PFX_UNPRIV) - 1;
+		} else if ((msg = skip_dynamic_pfx(s, TEST_TAG_EXPECT_XLATED_PFX_UNPRIV))) {
 			err = push_msg(msg, NULL, &spec->unpriv.expect_xlated);
 			if (err)
 				goto cleanup;
-- 
2.45.2


