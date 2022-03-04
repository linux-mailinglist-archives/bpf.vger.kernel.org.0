Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 362344CCA75
	for <lists+bpf@lfdr.de>; Fri,  4 Mar 2022 01:05:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232135AbiCDAGR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 3 Mar 2022 19:06:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232097AbiCDAGP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 3 Mar 2022 19:06:15 -0500
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F84BED945
        for <bpf@vger.kernel.org>; Thu,  3 Mar 2022 16:05:25 -0800 (PST)
Received: by mail-pj1-x1043.google.com with SMTP id mg21-20020a17090b371500b001bef9e4657cso5850553pjb.0
        for <bpf@vger.kernel.org>; Thu, 03 Mar 2022 16:05:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UqMJZi3vYGPcd2FKMtztF5xPFFAFAlU2DVmxmfuXzpg=;
        b=bJwiBhlFUnrhZIQhnVdwwoN2V33HKorO0Vib8wD7ErW1EMKB4/xGNpV/5q97iAi1g+
         X9+4SURjLnlGnyAR43AtZL73EtXi0UIjbwyBI7SqHTFlyiPXaVY2LOFCfLAPSEPKxvTx
         BYpWRuyCLoxfVfDsfbLYu+5NUQYTEsXHqM+tTFd/d0CFD0WJPctOs92s2dhrUTH3th36
         vH8s49ppKLnBuIo6q1zLpclFHJRpGP2OGNzgmQKZr3Du9rxJLVvy1vTKwSBeDqAb4a7N
         vTERSgT031WibYyXG1FwhIdUxqXaPDC4QYNDMjROLwesk6oVB005D0GvUlCTAqInpNa1
         c7DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UqMJZi3vYGPcd2FKMtztF5xPFFAFAlU2DVmxmfuXzpg=;
        b=SPBwAu8sf8ayH7AofvGVfVEFSYjI3gwfI/ahsr4o9WinnBQdMtt07worf14Ovgyoi0
         xgogJPEb0S910c/wUmqJjVN0k+oUpEIKseuQSY1/n19fqynETyTLgAqQCOxf6l+7Kmiy
         6UiDXWzuznTcQLcrnqQG6wb4WYf6y6U6/4yP0d/VV5Z2XLcrxV/fLMzJctGr9mQtPp05
         187+QkFOIjJ67QbYNozm4/aKPFVD3gJEhROVjfuZdS5IiBHulyGIVZLQ5bXfJfBHbsr4
         TpafyKqh6nwQ6QUCuCtgM8laXUcUZsZQM5Djub+u4k54m6M2xNf2ztruFOPVZL8WVCLr
         4Dlg==
X-Gm-Message-State: AOAM531Qv/nLBgn+GsGD4qCC/f2OA60YceFbj1p324GxjO5OQ8yhkTdk
        OW4HqM8JKnfhBDIzfLfrkgLN3K4EKhE=
X-Google-Smtp-Source: ABdhPJwuWnPvlhYLmCH4DjSJF7zjtTzkATyKdsk7AMYNyv4lEPifzDSBpNtPoX7oCLpNgPAEHe2HIg==
X-Received: by 2002:a17:90a:5802:b0:1b8:b737:a62b with SMTP id h2-20020a17090a580200b001b8b737a62bmr7915053pji.123.1646352324454;
        Thu, 03 Mar 2022 16:05:24 -0800 (PST)
Received: from localhost ([2405:201:6014:d0c0:6243:316e:a9e1:adda])
        by smtp.gmail.com with ESMTPSA id u25-20020a62ed19000000b004f140515d56sm3663826pfh.46.2022.03.03.16.05.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Mar 2022 16:05:24 -0800 (PST)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH bpf-next v3 4/8] bpf: Harden register offset checks for release helpers and kfuncs
Date:   Fri,  4 Mar 2022 05:35:04 +0530
Message-Id: <20220304000508.2904128-5-memxor@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220304000508.2904128-1-memxor@gmail.com>
References: <20220304000508.2904128-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6181; h=from:subject; bh=xODYappNWP5xxVEdwcjYv8EyauTLYFS3XAFeIgCPmwA=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBiIVd/Ec/5bwXMYnG7RJ9CSOVJYbeZ/0TsKgj18AE6 TPSfx6KJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCYiFXfwAKCRBM4MiGSL8RysyJEA CjmsCUdT8SmgVDMwsMhTBsxYTpZR19XZborUWly6aTyghej0n5H7IBnSHz7X5tTJtOf4f/X/u9nxOQ XDRdt1XktxJZ5g4lO9mRrUK2Pii1sVOViiFipk+jhTeXvPjOn3lvg6ZgVoZ8rIFQ/uDVaWH4Fu/RBq 5XDt96tQHPfSt5Wd5ByOnBPypcglAPlmvQsy1aptDY8BcC3vvLMxfoqAG+FpjySJFhh92hketS0jQS CpH4Ta5PnG8IcyfTbicUqO97DEBWAMIak0TYNvJ8WAotTv4fYjsTCPtqFpcVrnkiT85cxoiSkBE3cs 4FDj0mGhTzp65ltKR1lHv2P7DSNcWn2EEIkS2VEgUM5lI1Axo6gVViTqaJxGItCdzvy1JbD/KCvXcg j9UBjKC8vzqXbzi6ThZOyoUd2Lh3EHDbS+deMN+5NRqTHF9aMRgcSSPmhritMPFCCluYHSoB3PMYlF 6Fg3alE+XCg0qikev+ztVRwbe3zrd1KMeRWdL3b5jqf3ktkAD+u9vy3ndFAGEIaJzS91ddo13Sit2R dA9Cf7zWF4V4JT5mRwqvFQyYcTaZMBlRLTAxrFpIHtbV8cA0vHJbfO40SS5n1PIf133Esqkccnxo5I HXx6cYggK5BAY1PDjTt9hDeABNB4nBiFObcGm8m/xOOqnMQvmlBDAao6RweQ==
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

Let's ensure that the PTR_TO_BTF_ID reg being passed in to release BPF
helpers and kfuncs always has its offset set to 0. While not a real
problem now, there's a very real possibility this will become a problem
when more and more kfuncs are exposed, and more BPF helpers are added
which can release PTR_TO_BTF_ID.

Previous commits already protected against non-zero var_off. One of the
case we are concerned about now is when we have a type that can be
returned by e.g. an acquire kfunc:

struct foo {
	int a;
	int b;
	struct bar b;
};

... and struct bar is also a type that can be returned by another
acquire kfunc.

Then, doing the following sequence:

	struct foo *f = bpf_get_foo(); // acquire kfunc
	if (!f)
		return 0;
	bpf_put_bar(&f->b); // release kfunc

... would work with the current code, since the btf_struct_ids_match
takes reg->off into account for matching pointer type with release kfunc
argument type, but would obviously be incorrect, and most likely lead to
a kernel crash. A test has been included later to prevent regressions in
this area.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 include/linux/bpf_verifier.h |  3 ++-
 kernel/bpf/btf.c             | 13 +++++++++----
 kernel/bpf/verifier.c        | 27 +++++++++++++++++++++++----
 3 files changed, 34 insertions(+), 9 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 38b24ee8d8c2..7a684050495a 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -523,7 +523,8 @@ int check_ptr_off_reg(struct bpf_verifier_env *env,
 		      const struct bpf_reg_state *reg, int regno);
 int check_func_arg_reg_off(struct bpf_verifier_env *env,
 			   const struct bpf_reg_state *reg, int regno,
-			   enum bpf_arg_type arg_type);
+			   enum bpf_arg_type arg_type,
+			   bool is_release_function);
 int check_kfunc_mem_size_reg(struct bpf_verifier_env *env, struct bpf_reg_state *reg,
 			     u32 regno);
 int check_mem_reg(struct bpf_verifier_env *env, struct bpf_reg_state *reg,
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 7f6a0ae5028b..c9a1019dc60d 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -5753,6 +5753,9 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env,
 		return -EINVAL;
 	}
 
+	if (is_kfunc)
+		rel = btf_kfunc_id_set_contains(btf, resolve_prog_type(env->prog),
+						BTF_KFUNC_TYPE_RELEASE, func_id);
 	/* check that BTF function arguments match actual types that the
 	 * verifier sees.
 	 */
@@ -5777,7 +5780,7 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env,
 		ref_t = btf_type_skip_modifiers(btf, t->type, &ref_id);
 		ref_tname = btf_name_by_offset(btf, ref_t->name_off);
 
-		ret = check_func_arg_reg_off(env, reg, regno, ARG_DONTCARE);
+		ret = check_func_arg_reg_off(env, reg, regno, ARG_DONTCARE, rel);
 		if (ret < 0)
 			return ret;
 
@@ -5809,7 +5812,11 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env,
 			if (reg->type == PTR_TO_BTF_ID) {
 				reg_btf = reg->btf;
 				reg_ref_id = reg->btf_id;
-				/* Ensure only one argument is referenced PTR_TO_BTF_ID */
+				/* Ensure only one argument is referenced
+				 * PTR_TO_BTF_ID, check_func_arg_reg_off relies
+				 * on only one referenced register being allowed
+				 * for kfuncs.
+				 */
 				if (reg->ref_obj_id) {
 					if (ref_obj_id) {
 						bpf_log(log, "verifier internal error: more than one arg with ref_obj_id R%d %u %u\n",
@@ -5892,8 +5899,6 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env,
 	/* Either both are set, or neither */
 	WARN_ON_ONCE((ref_obj_id && !ref_regno) || (!ref_obj_id && ref_regno));
 	if (is_kfunc) {
-		rel = btf_kfunc_id_set_contains(btf, resolve_prog_type(env->prog),
-						BTF_KFUNC_TYPE_RELEASE, func_id);
 		/* We already made sure ref_obj_id is set only for one argument */
 		if (rel && !ref_obj_id) {
 			bpf_log(log, "release kernel function %s expects refcounted PTR_TO_BTF_ID\n",
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index e55bfd23e81b..c31407d156e7 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -5367,11 +5367,28 @@ static int check_reg_type(struct bpf_verifier_env *env, u32 regno,
 
 int check_func_arg_reg_off(struct bpf_verifier_env *env,
 			   const struct bpf_reg_state *reg, int regno,
-			   enum bpf_arg_type arg_type)
+			   enum bpf_arg_type arg_type,
+			   bool is_release_func)
 {
 	enum bpf_reg_type type = reg->type;
+	bool fixed_off_ok = false;
 	int err;
 
+	/* When referenced PTR_TO_BTF_ID is passed to release function, it's
+	 * fixed offset must be 0. We rely on the property that only one
+	 * referenced register can be passed to BPF helpers and kfuncs.
+	 */
+	if (type == PTR_TO_BTF_ID) {
+		bool release_reg = is_release_func && reg->ref_obj_id;
+
+		if (release_reg && reg->off) {
+			verbose(env, "R%d must have zero offset when passed to release func\n",
+				regno);
+			return -EINVAL;
+		}
+		fixed_off_ok = release_reg ? false : true;
+	}
+
 	switch ((u32)type) {
 	case SCALAR_VALUE:
 	/* Pointer types where reg offset is explicitly allowed: */
@@ -5394,8 +5411,7 @@ int check_func_arg_reg_off(struct bpf_verifier_env *env,
 	/* All the rest must be rejected: */
 	default:
 force_off_check:
-		err = __check_ptr_off_reg(env, reg, regno,
-					  type == PTR_TO_BTF_ID);
+		err = __check_ptr_off_reg(env, reg, regno, fixed_off_ok);
 		if (err < 0)
 			return err;
 		break;
@@ -5452,11 +5468,14 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 	if (err)
 		return err;
 
-	err = check_func_arg_reg_off(env, reg, regno, arg_type);
+	err = check_func_arg_reg_off(env, reg, regno, arg_type, is_release_function(meta->func_id));
 	if (err)
 		return err;
 
 skip_type_check:
+	/* check_func_arg_reg_off relies on only one referenced register being
+	 * allowed for BPF helpers.
+	 */
 	if (reg->ref_obj_id) {
 		if (meta->ref_obj_id) {
 			verbose(env, "verifier internal error: more than one arg with ref_obj_id R%d %u %u\n",
-- 
2.35.1

