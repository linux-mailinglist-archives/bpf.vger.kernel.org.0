Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CA904C8469
	for <lists+bpf@lfdr.de>; Tue,  1 Mar 2022 07:57:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232732AbiCAG6c (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 1 Mar 2022 01:58:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229814AbiCAG6c (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 1 Mar 2022 01:58:32 -0500
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC95A4D9CB
        for <bpf@vger.kernel.org>; Mon, 28 Feb 2022 22:57:51 -0800 (PST)
Received: by mail-pj1-x1042.google.com with SMTP id gl14-20020a17090b120e00b001bc2182c3d5so1125786pjb.1
        for <bpf@vger.kernel.org>; Mon, 28 Feb 2022 22:57:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BHQGsqfk9ce2Fd71+imZG3Hp77zEnYLDQ7F2BgQmyjE=;
        b=H0P5FCAezNSUh+oFrHZiwh7uZ1ejN+gbllORNYBcYqhs1axayvnDdoTjsx2PgSuup1
         IMBZAfd2V/7LPe1hIqd9eB0t1s1SCmQE4bAWG/i/PRI/5ASUQWCh5gaLoSIFPmsw22h3
         X34BwTI68VyLTsf+TUOadRRoVd9A5vZ9CWGBP3+FYiUkCTddijtfTmCfvM1rj4xQkXL+
         zdK5oyz/negijovfU7gY6jow0QJz0hfl9XLxRT3SahYoJ7WmX/0wJMD0zq4XzvZmypk1
         UyihVqH54HfjtDG31pBB5gk6a+ZawPws0WD6VkNSMx1qLBH3b+8Mo2zrVvG954rb/9PG
         05Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BHQGsqfk9ce2Fd71+imZG3Hp77zEnYLDQ7F2BgQmyjE=;
        b=7681114wU8n3dF2Q2+rqY7aGMw1r4BEDRlEem4fIrRE6Ex3hJyiFxTHnAT8behCnIg
         eOPruxGvbK0HiO/B7OdfIwv5zN4iixrn3xyy7mJwgOZeqTAFvjsffaSZivwsFyurK3Q2
         CEL6d4lk7d2Fc6+k/sLU2chj3/DBlZsR2a5pI4FZJ2rSc59S3DHxKT/DjNNmgvLNOO/z
         /rJ/RFMDR4SGVHek9lWbNpe5YJjqIFYEMze05H8KdBHWI4k/apG2pajtPTSuj3bcb0yU
         8DH8wJA4XNuQ5SKVEgC3hUo4VMEAjKMa6p6okfxjXn6PUI8Krk1MLU8FyuplujTnRHc7
         sLIQ==
X-Gm-Message-State: AOAM530FGPQqzsFINi5KZkNHi/ihzDUKkOMm5Kz6fMSfOi3SWGb5ax1o
        S9Oyu8sMliosY5Xed/4dpCfFaIdOISA=
X-Google-Smtp-Source: ABdhPJxpIUulVJofFR77gzryBsZbUYOX49NXt4SnnNz3cHLrgkRUk8f9kPbz1NZox9dFektxb1bFNw==
X-Received: by 2002:a17:90a:8e85:b0:1bc:429b:513d with SMTP id f5-20020a17090a8e8500b001bc429b513dmr20446287pjo.11.1646117870969;
        Mon, 28 Feb 2022 22:57:50 -0800 (PST)
Received: from localhost ([2405:201:6014:d0c0:6243:316e:a9e1:adda])
        by smtp.gmail.com with ESMTPSA id pf15-20020a17090b1d8f00b001bc9d6a0f15sm1239091pjb.36.2022.02.28.22.57.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Feb 2022 22:57:50 -0800 (PST)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH bpf-next v1 1/6] bpf: Add check_func_arg_reg_off function
Date:   Tue,  1 Mar 2022 12:27:40 +0530
Message-Id: <20220301065745.1634848-2-memxor@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220301065745.1634848-1-memxor@gmail.com>
References: <20220301065745.1634848-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3749; h=from:subject; bh=AuPmNJhouwzh6Sta7OPyDnqz8MexFVRs/kn8kxlUt08=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBiHcO1/XrnpuQgZQxY50cgjdBkjGrKItaOKj68c7Gx 9UVvY2eJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCYh3DtQAKCRBM4MiGSL8RykjPD/ 4y8+t7S2qZek6BEuw+BBhxi4ZeMti1f9nWCvYyu6deO5mR/Uv3FyL7ZWZ9PNj1oTwk6zNjc3+HGMMU 0WaCPLKWl3iSp5GJ7j+ZdfoO2N05QmaxnoPq7NxVup5mGgDpY0rlEfDBf6hfKqbBJ2IB8Djq2URik2 CWoU1fyFa+RNXIWabncgvsB6a3iddMdN0UKOclUNk6R7Px3p3uFkMuPTd580fe80BYVY6hwfpJXQXK LVFW8MTyu9XLQ/+EOrund/GXWfTdclvnrmlmQPG3Tfd9Kv1G8BRCtGLQcsVEypokPejctO77dO+xCx wklM6X5dBx3cAzMcjJ/A1EkF8kUTEz6skMQSF3V//I8mih3fSNNAss1HGrd7oQaYXZiJaYXugJ8K98 tPNbGni+8vQqnpnZmtlDmy4iLSVav6LPb6dGBqP16A+MIB/PlXt3bRuVDUddIw3sNGqa/QhkiGfmZJ vMj9AeAC0xkE3fQ3Ba333r7hDuUUs2Tkooux2kO22Lr/NDERkkyB6ZqkroG6oToMTWmgZiPI2P90pA L4WloShFPfvOpcWMRkF/pkF4D9PZ19nC4XNcq9sTMO2tbddgiRSkBX9ffDtW96/C0/fDP1WZzPILAm bjcp5k/xTc4/zFW7rON/4x2UTf6aByS4aoqzz+78184euyPPJWFfXGqhG9/Q==
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

Lift the list of register types allowed for having fixed and variable
offsets when passed as helper function arguments into a common helper,
so that they can be reused for kfunc checks in later commits. Keeping a
common helper aids maintainability and allows us to follow the same
consistent rules across helpers and kfuncs. Also, convert check_func_arg
to use this function.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 include/linux/bpf_verifier.h |  3 ++
 kernel/bpf/verifier.c        | 69 +++++++++++++++++++++---------------
 2 files changed, 44 insertions(+), 28 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 7a7be8c057f2..38b24ee8d8c2 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -521,6 +521,9 @@ bpf_prog_offload_remove_insns(struct bpf_verifier_env *env, u32 off, u32 cnt);
 
 int check_ptr_off_reg(struct bpf_verifier_env *env,
 		      const struct bpf_reg_state *reg, int regno);
+int check_func_arg_reg_off(struct bpf_verifier_env *env,
+			   const struct bpf_reg_state *reg, int regno,
+			   enum bpf_arg_type arg_type);
 int check_kfunc_mem_size_reg(struct bpf_verifier_env *env, struct bpf_reg_state *reg,
 			     u32 regno);
 int check_mem_reg(struct bpf_verifier_env *env, struct bpf_reg_state *reg,
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index d7473fee247c..a641e61767b4 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -5353,6 +5353,44 @@ static int check_reg_type(struct bpf_verifier_env *env, u32 regno,
 	return 0;
 }
 
+int check_func_arg_reg_off(struct bpf_verifier_env *env,
+			   const struct bpf_reg_state *reg, int regno,
+			   enum bpf_arg_type arg_type)
+{
+	enum bpf_reg_type type = reg->type;
+	int err;
+
+	switch ((u32)type) {
+	case SCALAR_VALUE:
+	/* Pointer types where reg offset is explicitly allowed: */
+	case PTR_TO_PACKET:
+	case PTR_TO_PACKET_META:
+	case PTR_TO_MAP_KEY:
+	case PTR_TO_MAP_VALUE:
+	case PTR_TO_MEM:
+	case PTR_TO_MEM | MEM_RDONLY:
+	case PTR_TO_MEM | MEM_ALLOC:
+	case PTR_TO_BUF:
+	case PTR_TO_BUF | MEM_RDONLY:
+	case PTR_TO_STACK:
+		/* Some of the argument types nevertheless require a
+		 * zero register offset.
+		 */
+		if (arg_type == ARG_PTR_TO_ALLOC_MEM)
+			goto force_off_check;
+		break;
+	/* All the rest must be rejected: */
+	default:
+force_off_check:
+		err = __check_ptr_off_reg(env, reg, regno,
+					  type == PTR_TO_BTF_ID);
+		if (err < 0)
+			return err;
+		break;
+	}
+	return 0;
+}
+
 static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 			  struct bpf_call_arg_meta *meta,
 			  const struct bpf_func_proto *fn)
@@ -5402,34 +5440,9 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 	if (err)
 		return err;
 
-	switch ((u32)type) {
-	case SCALAR_VALUE:
-	/* Pointer types where reg offset is explicitly allowed: */
-	case PTR_TO_PACKET:
-	case PTR_TO_PACKET_META:
-	case PTR_TO_MAP_KEY:
-	case PTR_TO_MAP_VALUE:
-	case PTR_TO_MEM:
-	case PTR_TO_MEM | MEM_RDONLY:
-	case PTR_TO_MEM | MEM_ALLOC:
-	case PTR_TO_BUF:
-	case PTR_TO_BUF | MEM_RDONLY:
-	case PTR_TO_STACK:
-		/* Some of the argument types nevertheless require a
-		 * zero register offset.
-		 */
-		if (arg_type == ARG_PTR_TO_ALLOC_MEM)
-			goto force_off_check;
-		break;
-	/* All the rest must be rejected: */
-	default:
-force_off_check:
-		err = __check_ptr_off_reg(env, reg, regno,
-					  type == PTR_TO_BTF_ID);
-		if (err < 0)
-			return err;
-		break;
-	}
+	err = check_func_arg_reg_off(env, reg, regno, arg_type);
+	if (err)
+		return err;
 
 skip_type_check:
 	if (reg->ref_obj_id) {
-- 
2.35.1

