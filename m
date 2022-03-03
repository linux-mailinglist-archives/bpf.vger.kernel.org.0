Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D74C4CB5F4
	for <lists+bpf@lfdr.de>; Thu,  3 Mar 2022 05:50:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229588AbiCCEvZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 2 Mar 2022 23:51:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiCCEvY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 2 Mar 2022 23:51:24 -0500
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF3D611B5D0
        for <bpf@vger.kernel.org>; Wed,  2 Mar 2022 20:50:39 -0800 (PST)
Received: by mail-il1-x142.google.com with SMTP id d3so3110464ilr.10
        for <bpf@vger.kernel.org>; Wed, 02 Mar 2022 20:50:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BHQGsqfk9ce2Fd71+imZG3Hp77zEnYLDQ7F2BgQmyjE=;
        b=UREN5gTdCZi2COO+NS0vNuP+jOykNzY5IL1dduoihvYlSXpIRmfYeJgVzUDGu/FkB/
         aJJAef0mMAD3POx3xTVih+Dbl2AxSsv2Yqjdk1d9uQ+Y4NUZW5Kh6r6OxETlcgGb1TrA
         Uwo+FiDKr1QOb7V03hKYdW+/WUG/O9Y8vYAZPzGFzVe2pTtZxxlJ1l0IMqHqGldWLERD
         AtRwhLHpheBQDE7dg9Sms5O0MXsDsH54equ0iGEFXyWV44wk9iL3BwYN7WP1OrQP+1XP
         2+KGxxcHFRB3p4eYcpd0rEw+IMqy2R6CdnoBUNmVJQ5h+zmzAAY2wWE7SIJ/tzFo+wP4
         i/Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BHQGsqfk9ce2Fd71+imZG3Hp77zEnYLDQ7F2BgQmyjE=;
        b=aIO5LTYNcnNJ9q1e7M8oUlssngLunYwfIYhPeqKAQD5GW0S2jzIW4/Owv1P5NbpTAA
         v2xyIEatGPYfpEGVX9wBy88r5FHLHXvTwEu1N2yHpfP+R3V2FocZiA8L4+3dLkTlfSqR
         sKxC6HwJTFqCKiwcGqSWOt5kXyDkQ07QDp8xtnan0PhA5xpIdeQ8T2jWxrkvplrr4evq
         hO4dJzp9BsQtI7ODgFDG76Gkb7E7dshuyKlZCszSGl3RM56yGhkGSV7RYi7++NSIZMgk
         ZG8QmhtsATYcKPHkHsGCVC8bX9IvhrQt8yadTfCDkV91YdXmC2T65OxCxhXtEnoKGBla
         ZLkw==
X-Gm-Message-State: AOAM533tLo8v6q3q4B5WEQSJ1KCAxCjbewnn7JJCjhHCGuw5s+Ry6gxf
        Vq1iBOrbKfEFRf8yaUvyjHh+5jSb8Ow=
X-Google-Smtp-Source: ABdhPJytf6Jw4hzhUPj03y8PETZznGmD7VVkavBVptwx5r/3MVox85oM4Sktscm31ghzG4VyKBb7IQ==
X-Received: by 2002:a92:c5c1:0:b0:2c2:8aeb:6570 with SMTP id s1-20020a92c5c1000000b002c28aeb6570mr29618549ilt.162.1646283039033;
        Wed, 02 Mar 2022 20:50:39 -0800 (PST)
Received: from localhost ([2405:201:6014:d0c0:6243:316e:a9e1:adda])
        by smtp.gmail.com with ESMTPSA id d15-20020a056e02214f00b002bc80da7cc6sm779624ilv.72.2022.03.02.20.50.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Mar 2022 20:50:38 -0800 (PST)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH bpf-next v2 1/8] bpf: Add check_func_arg_reg_off function
Date:   Thu,  3 Mar 2022 10:20:22 +0530
Message-Id: <20220303045029.2645297-2-memxor@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220303045029.2645297-1-memxor@gmail.com>
References: <20220303045029.2645297-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3749; h=from:subject; bh=AuPmNJhouwzh6Sta7OPyDnqz8MexFVRs/kn8kxlUt08=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBiIEj//XrnpuQgZQxY50cgjdBkjGrKItaOKj68c7Gx 9UVvY2eJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCYiBI/wAKCRBM4MiGSL8Ryv89D/ 9OW7sVUdNR/wGQGDndQbVahKNtP/D/Ht90Guct+LNcIuhGZxXrOct+pezzM4pEVFn9KwFKilZK45Hv NuNSOgTQTNhBnpDvedizoYB3mW1Od8WPmEQdQJmQ7xnGZrwVLWORucqJjif4FxiLFQEZG9mzfolPbf N6xwyo3Puuntk9ny1AFMJZE6R0LFWPWk9Wo+P4HvyPXn5zRXV7/NwFY8sFzIaeOQ3N09dNRod5ROsA S0YS/pSDhEU2aMNOqoc9MdQUU3MOlGqeP6gVt/nKeOhR/WRk7JlSAxm44mC9DZu8xJFnc2tFLTcZS/ lQ9gTtg6VWLc1fRePtz6DZwlyiayKVISopBQUXbc6QxIiuKJEvVotTP7wWAaBbSPpB1moH3Wc22fbB J5DL8MQY9vAynZl35OQfiw9WU1ddAI6r8QQO2cqeb4eBRPPdUv9bGeCyIskCVNnYkya/crZQtoRYmu giMkDn85wBRn0M0G/WaAtnpOzE/+3rnBfgbhwif/JUGyhpw+u1JG3oNzDmeWPdxZJ2iIJDjHFdkyx4 IiEMOexw+adFYRc9sWY9gee2myPEn6MXspTDNP4qbS4hWt1QGwK5fzk3mZHXpUCsQ9I4cm6uonuIM6 9vV0lkgYETwSXhONhW/hCwToiY2jopW5i3MqZkqTO24KKwqpsK0pZ9jNM66g==
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

