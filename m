Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08DE84CE060
	for <lists+bpf@lfdr.de>; Fri,  4 Mar 2022 23:46:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230040AbiCDWrm (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 4 Mar 2022 17:47:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbiCDWrl (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 4 Mar 2022 17:47:41 -0500
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94BEA5FF35
        for <bpf@vger.kernel.org>; Fri,  4 Mar 2022 14:46:52 -0800 (PST)
Received: by mail-pj1-x1042.google.com with SMTP id cx5so8498426pjb.1
        for <bpf@vger.kernel.org>; Fri, 04 Mar 2022 14:46:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fuhtxbd6qplhvsoEWtRGbE1XBkjpmIPLEyl/Yh0auqA=;
        b=JctYWYBIIqpGv8/i/kGUrcgOP76TkuvBtdGq+pmF8NNlaHstt//2wTpYPUvjKMH1UM
         kW+AX6tegasUbmAz7a4UR7M8xgW+l6LzTm8jQ2mrOIeaNWCXEXULSE18FNVqEoBHfoKC
         8gw0EEqSlAkAs4/dgVJokFJOdIobzem7FaAecMsfEoK9rZltYB8zohYqx0Y8Fp1uNbn0
         zfpZz1mwlzQ/QHu3Nk5+ukgVM4UTCmNvtzLVuV6OZ7opBLo9jokTqf7tN4dZSkv62UYN
         32/Z7qh44TQIQVA/JkSUtkpH5Qkpy9PHMIQUtDZZJvmlha+fW+4k9uW33J3Hbknkmyhh
         4cyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fuhtxbd6qplhvsoEWtRGbE1XBkjpmIPLEyl/Yh0auqA=;
        b=mN8yfj57nTQsnPqVIPleZ7b1CkjA7cTFXvW51I/uVA9OU96mKHjE4a1FMbgd6lqbiX
         HKtMLTC48KB6mKwWT1hRw5K5JyXXeuDSC8WYXbDxwiUIm616/nPyOTmsifDOsIksLPt2
         4Po8lPvs1yme+Kn6r61iOgQi0uWbTEXEtNVnWFFtTh2jOVF0nKtEl/CYOUmFfI1Gl71e
         1rsE6/3aEt83SUBRQRzvz1livB4mXpXUMuyzH7lG6ZZUD2ff5dKIfv9l2gUEzVDNBf/S
         apsjvUueZHYuwcHtVCjDcE4nksmzwtbYNOquEiJ5d4uZSsXti2ggy1MqkgGWaWpaPBEc
         ijGA==
X-Gm-Message-State: AOAM533jJ8hX9x2Idk97b3dgmS241Z1maKzy2/eqVCSm9B8SpNC0RxoQ
        WgeTK+HrX4xgT4AnuExHWivFpaznTGo=
X-Google-Smtp-Source: ABdhPJworUO7z5Zxd3Zixf1GoljjnDCLA7K4NlTTE4gf6uyw98BEMhSzI6wKXI8VySlPPrFrskONjw==
X-Received: by 2002:a17:903:230e:b0:151:cf0d:a959 with SMTP id d14-20020a170903230e00b00151cf0da959mr249622plh.139.1646434011941;
        Fri, 04 Mar 2022 14:46:51 -0800 (PST)
Received: from localhost ([2405:201:6014:d0c0:6243:316e:a9e1:adda])
        by smtp.gmail.com with ESMTPSA id k12-20020a635a4c000000b0037852b86236sm5224453pgm.75.2022.03.04.14.46.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Mar 2022 14:46:51 -0800 (PST)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>
Subject: [PATCH bpf-next v4 1/8] bpf: Add check_func_arg_reg_off function
Date:   Sat,  5 Mar 2022 04:16:38 +0530
Message-Id: <20220304224645.3677453-2-memxor@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220304224645.3677453-1-memxor@gmail.com>
References: <20220304224645.3677453-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3788; h=from:subject; bh=LOHvAtVPEoEg5hYwocIYDuuQfOkN+wepUOXlJyzeQUA=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBiIpasZ7Fmns/+T8RGgAnvKVvOxaQ2peEd7EQFea6O SROPgF6JAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCYiKWrAAKCRBM4MiGSL8RyqHED/ 9xrRjKA78ReRF1bvDsSP5U+4mUBPvXI+vkP/lMKoHa8ANtBoBmCJpTbyYG1GmNsha3hB4sy0J97ZAd xEW5pCvqaJEBraw3P78j1nSQZ1BDGF5agKogVjOq6vC9sC+VsaGqtlEuw/7BnV+OgCGwGN4vFSylBO ndi7rnswL/8SjNp0RppthCN/zDuEELugNn2Lzc39i/H7cS8f0bftFe8AMwfwmbreJbw1FNYSboEuL9 Bv5x8Z08Ulc/RGN4g/ouY+QikHZ8M7UxY7YeelN9nIzBS+jNw0GM3NgAr0IdbR/3M2+SpgyJ98L9ly u9tMwQ5GcbScF11NDJk2Epk4DmwVezgkaw+Y7ZqDpNwEwmE1LU3uWvW803yQ3BpJ1CulskOewHgK8s DeAKYVp8fTLVDQRyHiX/KtqGgT0JmmkhoXoPnJIwZw/+dA3HnBglei9eFzzMfppn2TaKqRkC663fSg OeZiBI9ufsdtBcD2kQKbSiFRTsfv3jXXXCrX57QyhgvpW3pf8V0XjwiYL1n0o3oVVkvPeBza1wbSH8 JIr8n7PlGqy36ydQ9CVa1GMvfAkQ6Ywk7K3FM6PJpelA9z09b2QY4fO6FmKSJAbdBTmY+ie5w0YHet nJhXL/OaA5lfP1+HK2QfLQiUWi5o/BzM0wvXsUWVmPqWZXoRr4lySwLhd+Dw==
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
index a57db4b2803c..e37eb6020253 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -5359,6 +5359,44 @@ static int check_reg_type(struct bpf_verifier_env *env, u32 regno,
 	return 0;
 }
 
+int check_func_arg_reg_off(struct bpf_verifier_env *env,
+			   const struct bpf_reg_state *reg, int regno,
+			   enum bpf_arg_type arg_type)
+{
+	enum bpf_reg_type type = reg->type;
+	bool fixed_off_ok = false;
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
+		if (arg_type != ARG_PTR_TO_ALLOC_MEM)
+			return 0;
+		break;
+	/* All the rest must be rejected, except PTR_TO_BTF_ID which allows
+	 * fixed offset.
+	 */
+	case PTR_TO_BTF_ID:
+		fixed_off_ok = true;
+		break;
+	default:
+		break;
+	}
+	return __check_ptr_off_reg(env, reg, regno, fixed_off_ok);
+}
+
 static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 			  struct bpf_call_arg_meta *meta,
 			  const struct bpf_func_proto *fn)
@@ -5408,34 +5446,9 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
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

