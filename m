Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C031B502D6C
	for <lists+bpf@lfdr.de>; Fri, 15 Apr 2022 18:04:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233397AbiDOQGd (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 15 Apr 2022 12:06:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344062AbiDOQGb (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 15 Apr 2022 12:06:31 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EB0A9D0F1
        for <bpf@vger.kernel.org>; Fri, 15 Apr 2022 09:04:03 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id d15so7416107pll.10
        for <bpf@vger.kernel.org>; Fri, 15 Apr 2022 09:04:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PXZGp4wLPPxEa/QIbUCpAhZMCytgJ5be1NDBMqwUFRE=;
        b=W001VX+ClTe+6lF2nIAZZpSFiV7OiTJ4lgFUm8D/6m15eL6JMWDaArnu9x8wub3DEN
         QcHp86OZJ/avhQKnnjZgpQlNloPRsqX6EKKz2IjAj3OH0n4rFz7PHXwgjo3BH8U4mMWJ
         XUpJDy/hOpJ88If47kJafWAWgmjaeemGmXpegl9uaYVLuQADcfpLjwpBvG3i9dFK824f
         THdsdIYp/xiMClJpkFC18/I00GItrhNchmXCOcyQT/7j3vUTDUksK9kwbH/tJARAI0Np
         dbjJFRuvFMS7QMMDUMvkBxQZCVOJGUbXSg+ji932BSbj0gO2c444fHtkgoqyzQcI5pGE
         ID4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PXZGp4wLPPxEa/QIbUCpAhZMCytgJ5be1NDBMqwUFRE=;
        b=EP20e9BKgzo9F4Jaf3qyymwXrGRDAYsql9eUiEolmq00tVjaz0rpoHEO00e7vWtEyl
         /RS6HSNQ9BQbNKVjDsNXJyKyDSQaEvPA/iVJ/oedYYoNS1FYL5Nq/+ccszsAN6EP9yCz
         RRnu19dtI4zrA/Mw0EsCX1LuHA1Smu6JCVnzQWZUzJfJaxuVAOihSUpccfqbY6Oi3s+G
         eFk1I9YxEOl5RC14bp8y/63oRCx6cDRcwjntBzaQxADfap/+zoTWd0Cj2gS/aLlvVVpF
         W+zttsNFcyPDY393bOeh19FRAsg2A+Bu3TVae43IEV1n+0RPydl6vt0gwvWsQJEo4mnW
         j4jA==
X-Gm-Message-State: AOAM531Fzu10NY34lBAdON5UcgKpIlcfCSmhLhWIUv0GjJU9OZuVae19
        MOgEKBk833Ap0CNT9XPAIMsW4lcltUU=
X-Google-Smtp-Source: ABdhPJzOFFRWo46PdSAyvNmrL8njrX2IrLqYCVGtszO4vC2B43obhXgCfvDzVi6vm2+C0W6J93kR5A==
X-Received: by 2002:a17:90a:f48b:b0:1cd:476c:ea5f with SMTP id bx11-20020a17090af48b00b001cd476cea5fmr4839753pjb.117.1650038643004;
        Fri, 15 Apr 2022 09:04:03 -0700 (PDT)
Received: from localhost ([112.79.166.196])
        by smtp.gmail.com with ESMTPSA id f14-20020a17090a4a8e00b001cea3feaf29sm3460566pjh.56.2022.04.15.09.04.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Apr 2022 09:04:02 -0700 (PDT)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Joanne Koong <joannelkoong@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>
Subject: [PATCH bpf-next v5 02/13] bpf: Move check_ptr_off_reg before check_map_access
Date:   Fri, 15 Apr 2022 21:33:43 +0530
Message-Id: <20220415160354.1050687-3-memxor@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220415160354.1050687-1-memxor@gmail.com>
References: <20220415160354.1050687-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3363; h=from:subject; bh=oJnqa1sNTcCNgcVsQrO+fwdIhveuNn88q30yztABTuA=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBiWZdBqLKWOKHWdInwppRJ8Mwwo39INqOXIdDVI8o0 qxRa+2GJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCYlmXQQAKCRBM4MiGSL8Ryk9pD/ 0TdOljFhMii5njwrUFpz8w58Fp1MKJcSEADkgs0/M2JUmha+d2wMmaaGUDKOE6a6Alx+yJdCQNZPLa HcIEE3xy/Vghk+K1EbjJHUMDirjYwFZZtR3BfXxQdfcUCWVJam9KYiWb4yN1aY0QapqsbNBFUFEA1y 5pK32t4rAjZ0kmvvLuX5jq+55Y/uTtWE2VwiIccyC4dTL6kG4audm/Jm8kXxXs8M0W/lQYhjjzWhrF ySEI+FSyUeW5Po9kCiH/FIAhEt2vfZF8TRHRz9thpg9AiPpIE08TYD/b65/votE21BEzEIZLgeSjfZ sXpb6gx22j0wSz92ZAjMxnqKzEHyypTDGe0S816EjA4qytyWY/RskD+gEJ8Q1eiL2O9RydDYqWM3yJ 2ufj957LpkUcvxUO41p9O3sxuN/+bvz916oriAKfJKJajLfrNIWcnT1GZ0/ALBHAWk7bEUPAYRb1OG wSJU8t3M6XjC+xJ9yJFlfapKE+jR8k4AY5ce05+42HJKxmacJJk8pI9LyqQUh4Cog1l+6wQduwAKou AWsMYlJFhr+wb4p6vx19QG8TH5k5uEiJkic1BUybMeqcAEPirTyQUaJsysXlQ69GUH5ZU4SDB5M3vN f5c8m7sTaHIzZx0ekDRnTDUx0cEyupZTUYi6eDanC0YUPOfodWg9b3yM0J/w==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Some functions in next patch want to use this function, and those
functions will be called by check_map_access, hence move it before
check_map_access.

Acked-by: Joanne Koong <joannelkoong@gmail.com>
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/verifier.c | 76 +++++++++++++++++++++----------------------
 1 file changed, 38 insertions(+), 38 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 9c1a02b82ecd..71827d14724a 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -3469,6 +3469,44 @@ static int check_mem_region_access(struct bpf_verifier_env *env, u32 regno,
 	return 0;
 }
 
+static int __check_ptr_off_reg(struct bpf_verifier_env *env,
+			       const struct bpf_reg_state *reg, int regno,
+			       bool fixed_off_ok)
+{
+	/* Access to this pointer-typed register or passing it to a helper
+	 * is only allowed in its original, unmodified form.
+	 */
+
+	if (reg->off < 0) {
+		verbose(env, "negative offset %s ptr R%d off=%d disallowed\n",
+			reg_type_str(env, reg->type), regno, reg->off);
+		return -EACCES;
+	}
+
+	if (!fixed_off_ok && reg->off) {
+		verbose(env, "dereference of modified %s ptr R%d off=%d disallowed\n",
+			reg_type_str(env, reg->type), regno, reg->off);
+		return -EACCES;
+	}
+
+	if (!tnum_is_const(reg->var_off) || reg->var_off.value) {
+		char tn_buf[48];
+
+		tnum_strn(tn_buf, sizeof(tn_buf), reg->var_off);
+		verbose(env, "variable %s access var_off=%s disallowed\n",
+			reg_type_str(env, reg->type), tn_buf);
+		return -EACCES;
+	}
+
+	return 0;
+}
+
+int check_ptr_off_reg(struct bpf_verifier_env *env,
+		      const struct bpf_reg_state *reg, int regno)
+{
+	return __check_ptr_off_reg(env, reg, regno, false);
+}
+
 /* check read/write into a map element with possible variable offset */
 static int check_map_access(struct bpf_verifier_env *env, u32 regno,
 			    int off, int size, bool zero_size_allowed)
@@ -3980,44 +4018,6 @@ static int get_callee_stack_depth(struct bpf_verifier_env *env,
 }
 #endif
 
-static int __check_ptr_off_reg(struct bpf_verifier_env *env,
-			       const struct bpf_reg_state *reg, int regno,
-			       bool fixed_off_ok)
-{
-	/* Access to this pointer-typed register or passing it to a helper
-	 * is only allowed in its original, unmodified form.
-	 */
-
-	if (reg->off < 0) {
-		verbose(env, "negative offset %s ptr R%d off=%d disallowed\n",
-			reg_type_str(env, reg->type), regno, reg->off);
-		return -EACCES;
-	}
-
-	if (!fixed_off_ok && reg->off) {
-		verbose(env, "dereference of modified %s ptr R%d off=%d disallowed\n",
-			reg_type_str(env, reg->type), regno, reg->off);
-		return -EACCES;
-	}
-
-	if (!tnum_is_const(reg->var_off) || reg->var_off.value) {
-		char tn_buf[48];
-
-		tnum_strn(tn_buf, sizeof(tn_buf), reg->var_off);
-		verbose(env, "variable %s access var_off=%s disallowed\n",
-			reg_type_str(env, reg->type), tn_buf);
-		return -EACCES;
-	}
-
-	return 0;
-}
-
-int check_ptr_off_reg(struct bpf_verifier_env *env,
-		      const struct bpf_reg_state *reg, int regno)
-{
-	return __check_ptr_off_reg(env, reg, regno, false);
-}
-
 static int __check_buffer_access(struct bpf_verifier_env *env,
 				 const char *buf_info,
 				 const struct bpf_reg_state *reg,
-- 
2.35.1

