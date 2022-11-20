Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 064CF631289
	for <lists+bpf@lfdr.de>; Sun, 20 Nov 2022 06:10:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229453AbiKTFKS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 20 Nov 2022 00:10:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiKTFKJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 20 Nov 2022 00:10:09 -0500
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA39075DBC;
        Sat, 19 Nov 2022 21:10:04 -0800 (PST)
Received: by mail-qv1-f48.google.com with SMTP id k2so4903729qvo.1;
        Sat, 19 Nov 2022 21:10:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8QmuTRbrgN9aINKumYSQ7rwD0MdS/VhvdHsB/SSqHsw=;
        b=WOA+QC1wptf+2JizFUe88kmHH7NvkPcLPgf+7Iz+A3jS+Mof+cNQk4/j3nSsRQInU/
         ld2zTKK+wyzxqUURntSmuQNR10pseK8/zx4CKN3G2clXoBv0Y1i/fSl8W0y/xkiDOVFq
         pe2Symqkx9lWTv1m0YyKIx1vSJNTtXRvTgpTM3y2kVuDg25vCF963cp11TFXMWGoahZ4
         2Hw9gJ8sOYNjjni/9t3Giszfkra8aDPWx/3nsvLe07oVJJywRhI03hCoVnExnOwr3i/n
         bPUBn/j1fpSFMJllzxm0v2fgcTzyLBLn4NjxGmct8//U/hwK0fCGdgyTdsWwhRW1ITQe
         SNBQ==
X-Gm-Message-State: ANoB5pnH9Hdy5v23hN/ASFig8dROt8NGJqcYiQFFaySoj8Yc9oW3jT00
        +aSDmMCZUa5iThqgj5aoLII=
X-Google-Smtp-Source: AA0mqf4A//IDRSw7tSIYXVIERsu4aqn3o7Gtdp2KN5WaehTmbhjO1nOxEr7Z+fRe9GpAGg9EPihevw==
X-Received: by 2002:a0c:8091:0:b0:4bb:b8ec:2bc7 with SMTP id 17-20020a0c8091000000b004bbb8ec2bc7mr12708643qvb.20.1668921003768;
        Sat, 19 Nov 2022 21:10:03 -0800 (PST)
Received: from localhost ([2620:10d:c091:480::1:6319])
        by smtp.gmail.com with ESMTPSA id u12-20020a37ab0c000000b006bb29d932e1sm5619405qke.105.2022.11.19.21.10.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Nov 2022 21:10:03 -0800 (PST)
From:   David Vernet <void@manifault.com>
To:     ast@kernel.org
Cc:     andrii@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
        yhs@fb.com, song@kernel.org, sdf@google.com,
        john.fastabend@gmail.com, haoluo@google.com, jolsa@kernel.org,
        kpsingh@kernel.org, memxor@gmail.com, tj@kernel.org,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH bpf-next v9 1/4] bpf: Allow multiple modifiers in reg_type_str() prefix
Date:   Sat, 19 Nov 2022 23:10:01 -0600
Message-Id: <20221120051004.3605026-2-void@manifault.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221120051004.3605026-1-void@manifault.com>
References: <20221120051004.3605026-1-void@manifault.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

reg_type_str() in the verifier currently only allows a single register
type modifier to be present in the 'prefix' string which is eventually
stored in the env type_str_buf. This currently works fine because there
are no overlapping type modifiers, but once PTR_TRUSTED is added, that
will no longer be the case. This patch updates reg_type_str() to support
having multiple modifiers in the prefix string, and updates the size of
type_str_buf to be 128 bytes.

Signed-off-by: David Vernet <void@manifault.com>
---
 include/linux/bpf_verifier.h |  2 +-
 kernel/bpf/verifier.c        | 19 ++++++++-----------
 2 files changed, 9 insertions(+), 12 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 23f30c685f28..608dde740fef 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -19,7 +19,7 @@
  */
 #define BPF_MAX_VAR_SIZ	(1 << 29)
 /* size of type_str_buf in bpf_verifier. */
-#define TYPE_STR_BUF_LEN 64
+#define TYPE_STR_BUF_LEN 128
 
 /* Liveness marks, used for registers and spilled-regs (in stack slots).
  * Read marks propagate upwards until they find a write mark; they record that
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 195d24316750..67a6f11d953c 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -557,7 +557,7 @@ static bool is_cmpxchg_insn(const struct bpf_insn *insn)
 static const char *reg_type_str(struct bpf_verifier_env *env,
 				enum bpf_reg_type type)
 {
-	char postfix[16] = {0}, prefix[32] = {0};
+	char postfix[16] = {0}, prefix[64] = {0};
 	static const char * const str[] = {
 		[NOT_INIT]		= "?",
 		[SCALAR_VALUE]		= "scalar",
@@ -589,16 +589,13 @@ static const char *reg_type_str(struct bpf_verifier_env *env,
 			strncpy(postfix, "_or_null", 16);
 	}
 
-	if (type & MEM_RDONLY)
-		strncpy(prefix, "rdonly_", 32);
-	if (type & MEM_RINGBUF)
-		strncpy(prefix, "ringbuf_", 32);
-	if (type & MEM_USER)
-		strncpy(prefix, "user_", 32);
-	if (type & MEM_PERCPU)
-		strncpy(prefix, "percpu_", 32);
-	if (type & PTR_UNTRUSTED)
-		strncpy(prefix, "untrusted_", 32);
+	snprintf(prefix, sizeof(prefix), "%s%s%s%s%s",
+		 type & MEM_RDONLY ? "rdonly_" : "",
+		 type & MEM_RINGBUF ? "ringbuf_" : "",
+		 type & MEM_USER ? "user_" : "",
+		 type & MEM_PERCPU ? "percpu_" : "",
+		 type & PTR_UNTRUSTED ? "untrusted_" : ""
+	);
 
 	snprintf(env->type_str_buf, TYPE_STR_BUF_LEN, "%s%s%s",
 		 prefix, str[base_type(type)], postfix);
-- 
2.38.1

