Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 097774CCA6D
	for <lists+bpf@lfdr.de>; Fri,  4 Mar 2022 01:05:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231594AbiCDAGC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 3 Mar 2022 19:06:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232038AbiCDAGC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 3 Mar 2022 19:06:02 -0500
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7D05ED949
        for <bpf@vger.kernel.org>; Thu,  3 Mar 2022 16:05:15 -0800 (PST)
Received: by mail-pj1-x1043.google.com with SMTP id m22so6041055pja.0
        for <bpf@vger.kernel.org>; Thu, 03 Mar 2022 16:05:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=89RVgkyDXXb+2MTQvqztMaGkyK1APMHE6eqsIMvb3B8=;
        b=JFhj7WVSgsa+3/uFvqnhBlyXHIFbh3Tmai1PsKs4o+kItKTqgFFBTaLkLffegh1u67
         Elf2zi+X7N6yYHsFwp4PINhWtoyhMX98Ygqahbvx97NKCYe++MEh+jaJRzLnnuySRU/6
         yvEz32zbmvvidMqL1uVeIwjCyEFC9i93EAGOGWpEFMFl46+hx/3VQO30vwXXpC6Xddr8
         FfGw4Lx9dByWH5oVoMD+xWK2l/Ct4tLkr035OEMRocHP9Gq2P9dopWf4sdvIbPW4WGXN
         R+6fuqbDL/L1+P/8zgMeI1hkQmRbTIpZ6CWM5wVYrGafgdElWfFQYAEoEqxa5brk7fCT
         40KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=89RVgkyDXXb+2MTQvqztMaGkyK1APMHE6eqsIMvb3B8=;
        b=WGTzl6HjcXxDRyVvj9gdagMvea7vtfl260CMWkxg0o1AJgn4cdr7X2vWbc/sPFPdGO
         4rEfOUdej+aNh0zDIo/rZA0a8LJ5chnv5TouOtMjXfPMAq+x+iC9hIxZWlBVo1lXxI2W
         IV/t17+S3YYD5uEXJpPgfat+MNs4UuSX/2uYk1Yx4/mEFZY9ZpOrp/y0HoOP8oUc6WUn
         51xrOjO0BjQphxDTdy5tYI2OA2PLsU2C2dwrHpWW0bMqqePIb/jyq+Bm2rA/LHLe0uMR
         y8Lr29xaPkSAzKLldx2ggvsQ+rnDuddpqP+f9stNCCsMS84fSqgcnBck5MHKkDIwIqrM
         fTfQ==
X-Gm-Message-State: AOAM5312o8fAldMgy5DgDN31wm2/+wzRtSAHuM2jZV63HL2Ha37uP3cl
        uuKDKiLDjYOhGMO5c5I7/5ZwvCVceGI=
X-Google-Smtp-Source: ABdhPJwfugFaWrShhb63q3AUNyUnfNvKRNk0c5LP+JcI4i6jXGuOisxZSjyEA2GXHm8QIBsw1dq6cQ==
X-Received: by 2002:a17:90a:69e6:b0:1be:f28f:3bb6 with SMTP id s93-20020a17090a69e600b001bef28f3bb6mr7997149pjj.44.1646352315140;
        Thu, 03 Mar 2022 16:05:15 -0800 (PST)
Received: from localhost ([2405:201:6014:d0c0:6243:316e:a9e1:adda])
        by smtp.gmail.com with ESMTPSA id o6-20020a17090ad20600b001b8d01566ccsm9290320pju.8.2022.03.03.16.05.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Mar 2022 16:05:14 -0800 (PST)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH bpf-next v3 1/8] bpf: Add check_func_arg_reg_off function
Date:   Fri,  4 Mar 2022 05:35:01 +0530
Message-Id: <20220304000508.2904128-2-memxor@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220304000508.2904128-1-memxor@gmail.com>
References: <20220304000508.2904128-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3749; h=from:subject; bh=RVEiRbTogOcasEMWMlPiORs19jff6VaxKCgcQRqtQIA=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBiIVd/7NRVlEl6iUB6VfRwocxZzMXU0HXyp9SxOJlo uJ+vpruJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCYiFXfwAKCRBM4MiGSL8RypQJD/ 9psuEVjnuBs9ejob90J+bjugz8ZuLnLv8hYauhpne37H3t9J3UhArPIRqvzuT7UgznfNdqCA5MMkJO a2lKe/TBOqOpLgoM2CoSmQsQL0f1auObQ2EJ6iGy6glCyc1tosumsY7GxAwIFxqOFoGoyiauq4qqhF I8HiEcDumnp0hqFPr/eamqlA6P4GwYXKFAHftyPhExP3Ov3yWRUSH64G2d0sfw01QVE97NA+r0hcAH PTnVnu5MxZlGgGFPw9wDiCSv7b6SAm/U4jXix4eMh8eZR9OPdvWmwT59sjXBaUs3zh8pvNEzzqfgQg +42zqsNVb1SSz8dikkXMtY+F9nFvqoPgWk6b3aeKGl8VK2onXF28azJBsPMg2eB+Uvj/m32H+8uErM tJWvf5GmWGjgzCtf4vG2fQaCap88501o9Pz3RYF2NloG1ySsczbTPCz+aelwx+BH6Qmg9am3bb5TEu AtdeGOCm+6hd9ilBMFM2GfUtbBqUAEz8vIsJ5KSVVNzXZsMvGOeJO4qhDq7nRxOO26As0JUgKMNEXU 6qS9+hyd6kBQIKAK6wWo88ZofE/Buo8WAV7RjhM7IoVQxydFGObCw9AKmh7OIDzq1EOrUs3zbYHqO6 H93t34aBOia8cA5QSvBpbi3Z8qUYnTT14zxHtR+oJI97uCLRggI/eT2cYt/g==
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
index a57db4b2803c..c85f4b2458f4 100644
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

