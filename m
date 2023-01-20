Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A3A7674A54
	for <lists+bpf@lfdr.de>; Fri, 20 Jan 2023 04:43:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229882AbjATDnm (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 19 Jan 2023 22:43:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229885AbjATDnl (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 19 Jan 2023 22:43:41 -0500
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B392BA2955
        for <bpf@vger.kernel.org>; Thu, 19 Jan 2023 19:43:40 -0800 (PST)
Received: by mail-pg1-x544.google.com with SMTP id e10so3170370pgc.9
        for <bpf@vger.kernel.org>; Thu, 19 Jan 2023 19:43:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tmo0le0cUJOBzWSdrlYEJJL3gLctaWM5TmJR0sXVqHw=;
        b=PkspaGLT1TLPJqEito8K0eXi00ctzrwHIrx1Pt9zWwdOacC0iN4H3GwSUicXWPTRrS
         5Sq81bWTWs+Zkz7+6z2Z3NJEWX0z2MR9lkqUN6TxZcA+mFy1MtSUlrWvOj/Uc7hYNoi8
         aspp241kNnLZWNiOCQg60vJDMdfmeXZkJY/XTHv/glZA1pJDKSvmyfRejrXphPUWIhKV
         9hBXvin0T7T8xxtyh47U/RNn/xnmufjgyjSvWPCqLtgzr2qTKHL4RI/N4BS8GF2TLK8S
         80rl0HolnzqJ4QM4e992AwrTrOIjVQtqn79t8hcc0/pfSSz2jdgf+4WS3qmAXP9FDa5l
         ARqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Tmo0le0cUJOBzWSdrlYEJJL3gLctaWM5TmJR0sXVqHw=;
        b=Ab66wjxO/SLRXxfquESGoCfJk1s3fBr22ap2OegbWCEWTDW9hcGfZshZRJL/kNejdq
         VKYFPhRdKkZUu89xUDtKm2uOGRxROWg8ia8wgCdxVVno1y7fQI9oaNd0iIaMTMWV9f+0
         axAnI6W850eqoxpBmbxXJvzfRRGmV0s0Sz4rqvZfZwknIxkhPoWZ22O+g3w3QKujmzCc
         Ps1qVRsZXK+8uNk2Pta/rARwMwWVqijx4Ak11Cox8BdR92o1ACHNU+D/9k/Gtz9uR7jC
         yQjUKsnJXgMy4ygfE66veMf+OcBuPMILNEddQWjvQYvseZG96JO+pVGM8hsHYlHJMC5c
         cJKg==
X-Gm-Message-State: AFqh2krFUvqW9QojxQUd4+Wtq7dtvKmXnXpNet07TTxieuGA7u0om4To
        QVERyNrEfcORa+Y/qgRTwvXTO4bs1FU=
X-Google-Smtp-Source: AMrXdXvxAJcBq86/kouxO1tFEr0/gZ7MhcLckXoHOUWs9tS9ICjAyS8bQSrkcfXgK/YsZuzXYDqTUQ==
X-Received: by 2002:aa7:946b:0:b0:58b:c873:54e1 with SMTP id t11-20020aa7946b000000b0058bc87354e1mr17197248pfq.24.1674186219894;
        Thu, 19 Jan 2023 19:43:39 -0800 (PST)
Received: from localhost ([2405:201:6014:dae3:7dbb:8857:7c39:bb2a])
        by smtp.gmail.com with ESMTPSA id q17-20020aa79611000000b00575b6d7c458sm13080373pfg.21.2023.01.19.19.43.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jan 2023 19:43:39 -0800 (PST)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Joanne Koong <joannelkoong@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        David Vernet <void@manifault.com>,
        Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v3 07/12] bpf: Avoid recomputing spi in process_dynptr_func
Date:   Fri, 20 Jan 2023 09:13:09 +0530
Message-Id: <20230120034314.1921848-8-memxor@gmail.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230120034314.1921848-1-memxor@gmail.com>
References: <20230120034314.1921848-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3698; i=memxor@gmail.com; h=from:subject; bh=n4U1dXvfeNH1zRNe/co4rVPmlxHdSUzypJJY0IRJzjw=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBjyg291RvlX6RfReOLAFbMWC9wK/gvWsxIfRy4IvoV dOq3G5OJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCY8oNvQAKCRBM4MiGSL8RyotlEA CuomRTTJmydbDJ4a0g85hfdH+bbBnk3if2iuJ/yJnoh4p1nvMM7dR3No13UDo87TIgItMOFq8lp+Hs wQWIwl9HMvT5zyeV/px9ezUbuTyHcRIXHFqeI/l6u/zx+cxdUrPaRz5t3vEJn9qRHCXdez5zpTYdrR EooWEr2nM1+4uUHhlZ9ZNSmVPcNx6wVSCak/usM6Sn0b7O9IOHL0oq2U/DJeLmiac6a0dmwsLdWPcu pyRdfNfQBwGEKnGGZfxiHyejIGrvdaVSWtcvS3NSVfmCzVwK4BBaU9ILsm29KvcOqY2g9fTIf72FE7 4I/dH4T/dq8Nh3i7v2kBQqdj67SnLCUv3r3h7G1tDfroSi4X9u3u3G9ZMcAuiUiD9W4DaBaq0eCgiU hI1R+xlEnQSBu6jY+np1GF+uxBXz6suDHca6jD5oeUVJczRsLgc6rbalguLC2sSQBfNY7lzylGnLPN +s47hlkUmssOTy31MnOyo1Z/jMHYB0vQdmK10Fzp0Fdcdvsd0QDL97XKUrZOEUNHCX056sDZ5p4rHD AYxz9mwPhfU00EdfKYM3LsT1GlMp96R07/3IwQ3ivS9HOhFKatbpQlgm3fI6LknZvOhiU3DKnWpdPs l2o3vWagu7TWO708yIOHJP/tkQzaB76H+JFFaM5zv0Vid9Vqivk6NqsqXN5A==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Currently, process_dynptr_func first calls dynptr_get_spi and then
is_dynptr_reg_valid_init and is_dynptr_reg_valid_uninit have to call it
again to obtain the spi value. Instead of doing this twice, reuse the
already obtained value (which is by default 0, and is only set for
PTR_TO_STACK, and only used in that case in aforementioned functions).
The input value for these two functions will either be -ERANGE or >= 1,
and can either be permitted or rejected based on the respective check.

Suggested-by: Joanne Koong <joannelkoong@gmail.com>
Acked-by: Joanne Koong <joannelkoong@gmail.com>
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/verifier.c | 24 +++++++++++-------------
 1 file changed, 11 insertions(+), 13 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 29cbb3ef35e2..ecf7fed7881c 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -946,14 +946,12 @@ static int destroy_if_dynptr_stack_slot(struct bpf_verifier_env *env,
 	return 0;
 }
 
-static bool is_dynptr_reg_valid_uninit(struct bpf_verifier_env *env, struct bpf_reg_state *reg)
+static bool is_dynptr_reg_valid_uninit(struct bpf_verifier_env *env, struct bpf_reg_state *reg,
+				       int spi)
 {
-	int spi;
-
 	if (reg->type == CONST_PTR_TO_DYNPTR)
 		return false;
 
-	spi = dynptr_get_spi(env, reg);
 	/* For -ERANGE (i.e. spi not falling into allocated stack slots), we
 	 * will do check_mem_access to check and update stack bounds later, so
 	 * return true for that case.
@@ -971,16 +969,16 @@ static bool is_dynptr_reg_valid_uninit(struct bpf_verifier_env *env, struct bpf_
 	return true;
 }
 
-static bool is_dynptr_reg_valid_init(struct bpf_verifier_env *env, struct bpf_reg_state *reg)
+static bool is_dynptr_reg_valid_init(struct bpf_verifier_env *env, struct bpf_reg_state *reg,
+				     int spi)
 {
 	struct bpf_func_state *state = func(env, reg);
-	int spi, i;
+	int i;
 
 	/* This already represents first slot of initialized bpf_dynptr */
 	if (reg->type == CONST_PTR_TO_DYNPTR)
 		return true;
 
-	spi = dynptr_get_spi(env, reg);
 	if (spi < 0)
 		return false;
 	if (!state->stack[spi].spilled_ptr.dynptr.first_slot)
@@ -6139,6 +6137,7 @@ int process_dynptr_func(struct bpf_verifier_env *env, int regno,
 			enum bpf_arg_type arg_type, struct bpf_call_arg_meta *meta)
 {
 	struct bpf_reg_state *regs = cur_regs(env), *reg = &regs[regno];
+	int spi = 0;
 
 	/* MEM_UNINIT and MEM_RDONLY are exclusive, when applied to an
 	 * ARG_PTR_TO_DYNPTR (or ARG_PTR_TO_DYNPTR | DYNPTR_TYPE_*):
@@ -6152,10 +6151,9 @@ int process_dynptr_func(struct bpf_verifier_env *env, int regno,
 	 * and its alignment for PTR_TO_STACK.
 	 */
 	if (reg->type == PTR_TO_STACK) {
-		int err = dynptr_get_spi(env, reg);
-
-		if (err < 0 && err != -ERANGE)
-			return err;
+		spi = dynptr_get_spi(env, reg);
+		if (spi < 0 && spi != -ERANGE)
+			return spi;
 	}
 
 	/*  MEM_UNINIT - Points to memory that is an appropriate candidate for
@@ -6174,7 +6172,7 @@ int process_dynptr_func(struct bpf_verifier_env *env, int regno,
 	 *		 to.
 	 */
 	if (arg_type & MEM_UNINIT) {
-		if (!is_dynptr_reg_valid_uninit(env, reg)) {
+		if (!is_dynptr_reg_valid_uninit(env, reg, spi)) {
 			verbose(env, "Dynptr has to be an uninitialized dynptr\n");
 			return -EINVAL;
 		}
@@ -6197,7 +6195,7 @@ int process_dynptr_func(struct bpf_verifier_env *env, int regno,
 			return -EINVAL;
 		}
 
-		if (!is_dynptr_reg_valid_init(env, reg)) {
+		if (!is_dynptr_reg_valid_init(env, reg, spi)) {
 			verbose(env,
 				"Expected an initialized dynptr as arg #%d\n",
 				regno);
-- 
2.39.1

