Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0AC74CB5FF
	for <lists+bpf@lfdr.de>; Thu,  3 Mar 2022 05:51:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229607AbiCCEvh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 2 Mar 2022 23:51:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229654AbiCCEvf (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 2 Mar 2022 23:51:35 -0500
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BA8014561D
        for <bpf@vger.kernel.org>; Wed,  2 Mar 2022 20:50:50 -0800 (PST)
Received: by mail-io1-xd42.google.com with SMTP id d62so4372988iog.13
        for <bpf@vger.kernel.org>; Wed, 02 Mar 2022 20:50:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0yXxgLb0KNxAW6ky5E8pCvFSOKQKj/VQX4F8piM+KnU=;
        b=aBJLntlfqNyPvJw++fhsdpsguqmvNGjFeLMgkXYGCg3+f7PQsqaLmRXcurM9fEGwl+
         qDX1D0u4jw7Ilop35Q2Hbh4J1Z2hSUikQPjlUNd3AA0OL5QTToXMvJBX8t/yeVXNJXwy
         67HBxQdPDwIBOI32IDhROlbUY89xDMWy8ucsQ3ZRpyQTFY7zDTuvXUKjeeMEupe7tfz1
         1hd1+hFFylVFmxIE5Dm+R1nLvfpcrKvPdwegz4DgpMXMFiVnpp37Lxqs8PBC85yURmRZ
         /4TNdsOAtBY/SyAYLdju59vWqVK0A5GzD/ny3cmNhhjVD85Is7ZYW6ssgf54SxLVG9bB
         K7TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0yXxgLb0KNxAW6ky5E8pCvFSOKQKj/VQX4F8piM+KnU=;
        b=Zz9NIBqs/47Fu6wvAmAMHB4ZidhGHv+S3Ff7UW07OQLeojgAmktjiA8uHTL0tfIxNV
         0zPuUsGY4Pnpt/7xABLn8oNu7DNufIeF4IOdW16vmsyxT/84bR8zLCZVCfQAyJiK6YlT
         Gr5UbElEBeBHSvR6MrVIvtnYV4FGln1rp4bL9QBcK3q4vhGES51OI/pvPsOBPm8u5btF
         geLgiK4Pk675w3q2Y4ABJXQwbc4gUYn2s3eJyqCaMNcpOG1CCNAfI81yWynfiZkJyNXz
         n2m5Qxd+uWoowcu5nVspWJTxgo3Vq1fQt4W1eDd6bL65mmwJvFWxz/+bRl9lRqHS0OeK
         wplg==
X-Gm-Message-State: AOAM533firqzrv/wKO9hd2jEPqxX51i2dIdcHMGJHvC7ikiN1ZN+tJxQ
        6zGZl8yBhP6BPI3OHywfejzWImzdwTw=
X-Google-Smtp-Source: ABdhPJxddGymnUoFv/V0mruTz36TEJB6j13Clgb3cm3urKYsSRG4jL4KvC2dEJjEGrgmmdQ2SwShdQ==
X-Received: by 2002:a05:6638:418e:b0:314:656c:101a with SMTP id az14-20020a056638418e00b00314656c101amr26900966jab.235.1646283049405;
        Wed, 02 Mar 2022 20:50:49 -0800 (PST)
Received: from localhost ([2405:201:6014:d0c0:6243:316e:a9e1:adda])
        by smtp.gmail.com with ESMTPSA id w19-20020a056602035300b006390eea5d28sm705301iou.42.2022.03.02.20.50.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Mar 2022 20:50:49 -0800 (PST)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH bpf-next v2 4/8] bpf: Harden register offset checks for release helpers and kfuncs
Date:   Thu,  3 Mar 2022 10:20:25 +0530
Message-Id: <20220303045029.2645297-5-memxor@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220303045029.2645297-1-memxor@gmail.com>
References: <20220303045029.2645297-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6181; h=from:subject; bh=dEcVZ/eTMN5VONLNYe4d42vegMJ4xhfassRljRWf8LA=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBiIEj/6TUq8H2bwh4SesvvcHL2m4uy4wx0bwPojSqp YO29b+eJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCYiBI/wAKCRBM4MiGSL8RynaUD/ 477wo3QI5lGJ4jcL0YqE8SlcMsbTU31X27qibtjfDQqBH48zS0h5EN9Um6dO2p37IDWTyZvewCbSzV Eds8GFVN9q2kTa7lSTtd/EjsK2beirbf8s2UlIRAOY1niLvu2XSKhl1QTiOE5asM8SgUEKUeaQUPUe nAtRLRYhSne+ReW+SYus1zdbW3Ci5MjVUD2CtMlHRnOU/lUIeqILkwzhbf+RcfuKHeZKk47dHYJNHK 7S7x2YFgNc9Le2/nFa1pw2JObRBqJqas71oW8UTRUe2Nxe9ZGWNBatj0+RP1luTz/sSE5ie9eBj4Vm iBEnZvOTTWv8JD8nXW/YtOCpsRodHW/bcGfecKxdxhH997KcA1lHOhsXIUTRc62Hz+9Q7cFeJUXDct 43J5m28nhtGAvA5JHUSSnXhL+pLd5OuNsnRLsuPJ54MoNIpEU7fCTzPdUnlOxWOFm7QghJStSpB2jr 63cChYvklfuQuOYCdxWcuUipv4DvFkTWHWYB4DgX7KD2vu9wAfZgpFUIjC2JQhFZMTFRe/Pg0U5fHY BsXMUOHehpe3uXcdHY6zhsO+edtumYBMawDWqOi/sRor4OWL30UsTMR+F9kXh8BAPCG2UiwwK9fB/x ehnVmHr1GZyru+Oq5qRav6LLEh/zJMHBuWaGbEHejHPEH2WWMZmlGepQwT6w==
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
index 9f12a343bb6e..1cf18061f402 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -5361,11 +5361,28 @@ static int check_reg_type(struct bpf_verifier_env *env, u32 regno,
 
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
@@ -5388,8 +5405,7 @@ int check_func_arg_reg_off(struct bpf_verifier_env *env,
 	/* All the rest must be rejected: */
 	default:
 force_off_check:
-		err = __check_ptr_off_reg(env, reg, regno,
-					  type == PTR_TO_BTF_ID);
+		err = __check_ptr_off_reg(env, reg, regno, fixed_off_ok);
 		if (err < 0)
 			return err;
 		break;
@@ -5446,11 +5462,14 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
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

