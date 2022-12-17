Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E1DD64F6FB
	for <lists+bpf@lfdr.de>; Sat, 17 Dec 2022 03:17:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229480AbiLQCRj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 16 Dec 2022 21:17:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229863AbiLQCRj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 16 Dec 2022 21:17:39 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04F5A1D66D
        for <bpf@vger.kernel.org>; Fri, 16 Dec 2022 18:17:38 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id b3so6194625lfv.2
        for <bpf@vger.kernel.org>; Fri, 16 Dec 2022 18:17:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DpupkJuI5FIN3TNhUVFB5v0m8IeiP3Gu9XxCeng6P8w=;
        b=BGXMw3uHw1+c+jKGwXPvPVwCIisvPbJS7WssbtLhbOTqTGnYY+OBxYOiyDPsaMyxIa
         gF+M5Kesu9iRPlJtBHUZWcCc3irdcxukTwCLH02y4jUZPTLXfoZsqWTLgn8eNoH86Yxr
         ns03xUBX2ZIRiX8Tp0Kx9GR4QDZfuf9tc8U85SaXzBjklsa76x2ux3L9NyZLrH3jdxvm
         uKMqxXSnYPKIgUi0JqPc0hNq54fUubcJE7iD5IcKvLiMDSJw2re9jzjSMYJ8sjnSeT+z
         Fj+0JPQRj4u8WRF1siN220lu46UbcSG1/OmtjJAqgQPiKYmDfYGMag5/wsNZFX3zCger
         4qgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DpupkJuI5FIN3TNhUVFB5v0m8IeiP3Gu9XxCeng6P8w=;
        b=Eb1ZE/WyFuETPeALqh8/zWKJVMVHWe9pI1xH5FgFgHogWEUc4ibLAR8Xfrv1ZmHv5o
         Cs13Dd5F8npRaNOlPLUo48p2pNXAVc1Op7tsnvHuG+GeSee9Mpv3vD2TpSfsB1GUdVMt
         ul9zikz/CfDwdTDPsv2zUNsd2f+GYTmwZcRaCt2SMDiveIVYYFGX6XT2wCWdhDBqAxG/
         zxHRzU8tvMf8L7soJogKyqOm5dQeLn6brPlWZV8dlqD9Opqz55rYPxsSCJvnpg3aRVLC
         1icisHPV+YZCU9lVLBYwyrjmvYc7xdWs+BqqUwHb+eNxp6MEaHw+giheiF3srcPw+Cjb
         qjYQ==
X-Gm-Message-State: ANoB5plUYKGXhJ8CiWCZNExHwQlZyCnM3oGfPB0vsBxnIgN+uxWOX7kM
        uWt1UHvsTzUsox4/Vk4GuiE3FXhgNQc=
X-Google-Smtp-Source: AA0mqf5cEztS6j6KOs7GxJ5Ws5ZX+nPHg82uyNmuwRGlfa1rTVYi8kNcirkXrSR2OLuW/wiBIUWceA==
X-Received: by 2002:ac2:4bd5:0:b0:4b4:a460:c995 with SMTP id o21-20020ac24bd5000000b004b4a460c995mr17015430lfq.5.1671243456044;
        Fri, 16 Dec 2022 18:17:36 -0800 (PST)
Received: from pluto.. (boundsly.muster.volia.net. [93.72.16.93])
        by smtp.gmail.com with ESMTPSA id x17-20020ac259d1000000b0049e9122bd0esm370850lfn.114.2022.12.16.18.17.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Dec 2022 18:17:35 -0800 (PST)
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     bpf@vger.kernel.org, ast@kernel.org
Cc:     andrii@kernel.org, daniel@iogearbox.net, kernel-team@fb.com,
        yhs@fb.com, Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next 1/4] selftests/bpf: support for BPF_F_TEST_STATE_FREQ in test_loader
Date:   Sat, 17 Dec 2022 04:17:08 +0200
Message-Id: <20221217021711.172247-2-eddyz87@gmail.com>
X-Mailer: git-send-email 2.38.2
In-Reply-To: <20221217021711.172247-1-eddyz87@gmail.com>
References: <20221217021711.172247-1-eddyz87@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Adds a macro __test_state_freq, the macro expands as a btf_decl_tag of a
special form that instructs test_loader that the flag BPF_F_TEST_STATE_FREQ
has to be passed to BPF verifier when program is loaded.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 tools/testing/selftests/bpf/progs/bpf_misc.h |  1 +
 tools/testing/selftests/bpf/test_loader.c    | 10 ++++++++++
 2 files changed, 11 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/bpf_misc.h b/tools/testing/selftests/bpf/progs/bpf_misc.h
index 4a01ea9113bf..a42363a3fef1 100644
--- a/tools/testing/selftests/bpf/progs/bpf_misc.h
+++ b/tools/testing/selftests/bpf/progs/bpf_misc.h
@@ -6,6 +6,7 @@
 #define __failure		__attribute__((btf_decl_tag("comment:test_expect_failure")))
 #define __success		__attribute__((btf_decl_tag("comment:test_expect_success")))
 #define __log_level(lvl)	__attribute__((btf_decl_tag("comment:test_log_level="#lvl)))
+#define __test_state_freq	__attribute__((btf_decl_tag("comment:test_state_freq")))
 
 #if defined(__TARGET_ARCH_x86)
 #define SYSCALL_WRAPPER 1
diff --git a/tools/testing/selftests/bpf/test_loader.c b/tools/testing/selftests/bpf/test_loader.c
index 679efb3aa785..ac8517a77161 100644
--- a/tools/testing/selftests/bpf/test_loader.c
+++ b/tools/testing/selftests/bpf/test_loader.c
@@ -11,6 +11,7 @@
 
 #define TEST_TAG_EXPECT_FAILURE "comment:test_expect_failure"
 #define TEST_TAG_EXPECT_SUCCESS "comment:test_expect_success"
+#define TEST_TAG_TEST_STATE_FREQ "comment:test_state_freq"
 #define TEST_TAG_EXPECT_MSG_PFX "comment:test_expect_msg="
 #define TEST_TAG_LOG_LEVEL_PFX "comment:test_log_level="
 
@@ -19,6 +20,7 @@ struct test_spec {
 	bool expect_failure;
 	const char *expect_msg;
 	int log_level;
+	bool test_state_freq;
 };
 
 static int tester_init(struct test_loader *tester)
@@ -81,6 +83,8 @@ static int parse_test_spec(struct test_loader *tester,
 			spec->expect_failure = true;
 		} else if (strcmp(s, TEST_TAG_EXPECT_SUCCESS) == 0) {
 			spec->expect_failure = false;
+		} else if (strcmp(s, TEST_TAG_TEST_STATE_FREQ) == 0) {
+			spec->test_state_freq = true;
 		} else if (str_has_pfx(s, TEST_TAG_EXPECT_MSG_PFX)) {
 			spec->expect_msg = s + sizeof(TEST_TAG_EXPECT_MSG_PFX) - 1;
 		} else if (str_has_pfx(s, TEST_TAG_LOG_LEVEL_PFX)) {
@@ -102,6 +106,7 @@ static void prepare_case(struct test_loader *tester,
 			 struct bpf_program *prog)
 {
 	int min_log_level = 0;
+	__u32 flags = 0;
 
 	if (env.verbosity > VERBOSE_NONE)
 		min_log_level = 1;
@@ -120,6 +125,11 @@ static void prepare_case(struct test_loader *tester,
 		bpf_program__set_log_level(prog, spec->log_level);
 
 	tester->log_buf[0] = '\0';
+
+	if (spec->test_state_freq)
+		flags |= BPF_F_TEST_STATE_FREQ;
+
+	bpf_program__set_flags(prog, flags);
 }
 
 static void emit_verifier_log(const char *log_buf, bool force)
-- 
2.38.2

