Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52AD74E1C63
	for <lists+bpf@lfdr.de>; Sun, 20 Mar 2022 16:55:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242460AbiCTP4q (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 20 Mar 2022 11:56:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241132AbiCTP4p (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 20 Mar 2022 11:56:45 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E18A54188
        for <bpf@vger.kernel.org>; Sun, 20 Mar 2022 08:55:22 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id h5so10794740plf.7
        for <bpf@vger.kernel.org>; Sun, 20 Mar 2022 08:55:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dc0XA9cd0KjRJbm53uQjS1eODXyKwY8M2o8ADmLlRbQ=;
        b=YUrDqA+WgfKOlkX4QcSGLldGBHO0OaeppL3IEfDuAO1MX/9lxQ7O/R7QNf2DYi9H7K
         uj4TPZ1TKgRciN8MfhGZnF+1G+K8cQY0aA2/gI8l7v+pJ5FR/7Zinwdf3w4AinAN7U7D
         gC1e1Q7QuPx+dFlE4MCzyJ8/VoCpVlWQAgll1mmhcS3ilxIooL/WR9t62RDcGW6uuelk
         atJf5BL+K81mSUbhbY+gZFROcXfbNL6fnvSDQSNzka3MLiR81hIHy9mB1WCNmSgS+L2p
         Krx1dbqhujDT6+hXXWarV7Ste7QT183xCTP2w4h0886VOCyTX0/yOLr5nS4FLfgZN0pk
         os4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dc0XA9cd0KjRJbm53uQjS1eODXyKwY8M2o8ADmLlRbQ=;
        b=UocM76f6ovI6WEvdTRTV0RJYh2PesqOa8t8Wd/BWFvUTWbezCvVpo2mYn+9P1Vi0jS
         4AdGkIoWg9pnPttImT2AOGS4w+4mo91N0DRw7pp/WlzFEjY2UsCf6W13iL0WDLNepgL3
         +gFfhINspK18Vwc7RmaNBwxK0lKgJvSMOAlglXUDjYI75eGt1icNZyyff1uRbpbkS4WF
         VRrJDySkOH4thmgGIgBQqomnkM49q9xaeB9cC6Wy9uN9k+VcFU4LPQ+Ze5s0CQlsPLif
         nrf/f/wECP+cIFK7/yUYz6XNc3Ch1Fr7Ky0oh/aUlfQSe3eI15RQ/BhQMamsxLykM1+m
         rxRQ==
X-Gm-Message-State: AOAM533uBH2VmuY6/er/9A4ZkTwfLnd+LJ+p/PT33lFOcYsar2Y5pyB2
        VgNjVLPY9aUlcF+bD4ZFHWRIEA9dt5M=
X-Google-Smtp-Source: ABdhPJwCZ1g406KzDogl56XmSUR4buLEwvnAVXu9mf9gRDMgVqZTJCxH+fDklvV0UmblJMAHRz5rwg==
X-Received: by 2002:a17:90a:aa8c:b0:1bf:5273:ba28 with SMTP id l12-20020a17090aaa8c00b001bf5273ba28mr21724366pjq.226.1647791721564;
        Sun, 20 Mar 2022 08:55:21 -0700 (PDT)
Received: from localhost ([14.139.187.71])
        by smtp.gmail.com with ESMTPSA id f16-20020a056a00239000b004fa7103e13csm8870647pfc.41.2022.03.20.08.55.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Mar 2022 08:55:21 -0700 (PDT)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>
Subject: [PATCH bpf-next v3 02/13] bpf: Move check_ptr_off_reg before check_map_access
Date:   Sun, 20 Mar 2022 21:24:59 +0530
Message-Id: <20220320155510.671497-3-memxor@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220320155510.671497-1-memxor@gmail.com>
References: <20220320155510.671497-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3314; h=from:subject; bh=QbQlORCSFeRYUc5m/Gowp55NAeCIJOQQJnuoZODwvvU=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBiN00xtP4ESyYu1uhjwOS+LsewrKAjJPu3OEtIjf7S os4g65WJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCYjdNMQAKCRBM4MiGSL8Ryo1/D/ 96QrwEQTQSiTi/FE9FLmDcrXdwA/MMDLWBLWEB85NX4Z4NFMI1BI0qEM6Av7emxCnIjI1SkFkS45qx rU6M9TGDAZAij5SBbcrSQ8p1OSkOli/RZwgUPgsvIdUKtHOOguKVIXh06xBM1LOJUwAypYwv5teL+R I1kqjhlu5KUdg+geMsFdS+PF4NdWWAZlZRBID1i02Jm35oWsZwwnP4mOnAMI5TM39GoEf3Q/usC08g o/0CLVWKLale76+lYfk19a/6IRtuvlF+5UqV6lhPaVS+D2COUIMWyRGw0E2fNXHPPq3pmBXq0v5sN9 52pAAx3G3SirXcebPHJo8pTAvBZKVLXDZ4txqVOnA9+AEJ0mAXlu1ibZBA+eO1mtUSGwib1DGddWAr r74e4fZwPYeto0mgWXRsgbtYt+PWBs1TC1QKOuRm0HMmjjBnTBVnt8/aR/mGBU1vmTkzX8N1fHQIuC kWyoYB96IlQcVNV/z+wbNX+OlGB9q8Fqrh2SadBnhl6KaMpM5WBtxRoj8uXgkhzM7m9K/69vYaD0Gf L5B76RKoNgwulS8dyvlDxUyB7FqDwRNLfYTWBE9IksJSs/hkh/gvoTfqX/uQi5sr/W5JDlDBPkmR4T MSMBU3VmCUKRVgnjClyHQ99FLxhiOy9ATE0SkwESFz9U5a6E/bAKprN2Iw6Q==
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

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/verifier.c | 76 +++++++++++++++++++++----------------------
 1 file changed, 38 insertions(+), 38 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 0287176bfe9a..4ce9a528fb63 100644
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

