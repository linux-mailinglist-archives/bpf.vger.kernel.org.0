Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB6F44CE063
	for <lists+bpf@lfdr.de>; Fri,  4 Mar 2022 23:47:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229605AbiCDWrv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 4 Mar 2022 17:47:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230049AbiCDWru (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 4 Mar 2022 17:47:50 -0500
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4D0D5FF35
        for <bpf@vger.kernel.org>; Fri,  4 Mar 2022 14:47:01 -0800 (PST)
Received: by mail-pg1-x542.google.com with SMTP id o26so8638089pgb.8
        for <bpf@vger.kernel.org>; Fri, 04 Mar 2022 14:47:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7nVkXi+Hc4/n+jUguLjEnwbGn98uvNL/9GURp1Q4at4=;
        b=Ymfz6tVlH+Q8BWRtJFAfNo7lUX5jyRCcT2e25qTltYiht3XvMx6/+MhsTDhDNAojEZ
         +WhJWLoCfH7ztsA5yx4gA24+mfX3cBaVwn3/FiQzcotHzeOjFFSHvSYnS/44xtrw0RMu
         vgjxuQubxOjEbOhTQYQJRrTbor6POJ4lv01KZm+SmIqSLnrj5OzsyjdaTEj82hQiQQ1M
         GHAWDtGGmoCTXAwIlQHdyol3oxdcgwBk1k64GB5WzgJstttKFyPrrLPH/myLbIhJue2L
         TlRkbSzEtJ+6mVRBchbFcLG4n6N73X+T97g59Bbyi4AQVPPuHWsJRj7UTx6sPQWZ2UWS
         v16A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7nVkXi+Hc4/n+jUguLjEnwbGn98uvNL/9GURp1Q4at4=;
        b=U7GjLLveXHWa1a2xOeGBPBqfc6fh2emLfLKUcmLzNViEqcoxHEHSStyUJCMifiKHVp
         U8P0gmhan4v5+i34xmFLFu+rC7pKVT+ewawSQPKXBJyvbD/cShrIAnKSlOkod/PNCVSC
         /E3hafU9KO9qVqJ1XZtoC8oRbVZsRw5fM5mImmzQoK8D1mSrLsBRCOzeKRf/1Gj5xwHP
         VGtc68Ji6O7aDfFvgPZyLja5KO/vh8w3GoEUZZosUEw4rW8vzJWe+Pi7w8RehpJ4W8SH
         M/QuhRslq6WWDdBba3ODypS+DYn//VkIG23eD7Pyp5CMoK6PmAd0f1Uv0fiLcJwgbecG
         DscQ==
X-Gm-Message-State: AOAM530xtuiAO5KkFhyVyBPeDO+FlIOOnYgnxCQXZOS/VpaHih0PIuqY
        oxe6sPqTcwZk5YpLh5UscKYUJoUp+NQ=
X-Google-Smtp-Source: ABdhPJzp9ppVqDy8JL8lQIezzEwwjBxlJK3AldxWmNJYuinKXnElfVcA/AZg3z/hhyXWxKuVRGc0uA==
X-Received: by 2002:a63:920f:0:b0:378:9ef8:7978 with SMTP id o15-20020a63920f000000b003789ef87978mr464155pgd.587.1646434021113;
        Fri, 04 Mar 2022 14:47:01 -0800 (PST)
Received: from localhost ([2405:201:6014:d0c0:6243:316e:a9e1:adda])
        by smtp.gmail.com with ESMTPSA id a16-20020a056a000c9000b004f0f8babedfsm6899322pfv.29.2022.03.04.14.47.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Mar 2022 14:47:00 -0800 (PST)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>
Subject: [PATCH bpf-next v4 4/8] bpf: Harden register offset checks for release helpers and kfuncs
Date:   Sat,  5 Mar 2022 04:16:41 +0530
Message-Id: <20220304224645.3677453-5-memxor@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220304224645.3677453-1-memxor@gmail.com>
References: <20220304224645.3677453-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6888; h=from:subject; bh=EodbOtUKVBJMJgq/R+YBWbMEZxAWkOP3M0X2LHigkRg=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBiIpas5x+M11O98kgpo4F8kyUF1u6q/venEdQH4bUJ 2LVx1myJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCYiKWrAAKCRBM4MiGSL8RypCRD/ 9lTjBPjxw/oyRHUVFeAw1zosOfKVBQYBd1x0HicMCGEg9BIOHfSRHUTEAapl6k73c/vi8euwk/+coV oZj3C8VP8ivAFEHKr2A3KviSgpsYlumE97KXPOHamvBT+QPJOz8KqX9IpA6Bvp7GXp0BaXhde9APgH cBl18dTmykkZ1fzpClmZhs8VX+6cgFJ4chXzUW/6hqOZF4TQLyp/OIPi1wifN/O1F5VysNFse8jH3Z bDhWI96qcnk2mYGqRBOFt+TnXgaQvJ6cExD5lmx594jC+z9igTSJR2UhJTdbprEn2j/b+cVB6hO5a0 S6SuiodPJ5gz3GoDH6pjUZWd5HacrqLv49JjMMcvYD4YdrizpJgZfEyHPCnk11/HAaA8sJtXAUu/3E azYSs8ZgJ4yUEmuWrGVpuqX0UZ+kEEkWwlEuT8jvPpcGvcOuBKw/NOv3DmOCJZIRu2UPepQYxJDP0Q +pPLF2aVHvnuhRTGIthJZ9PdP++ntlM3H84ESoXImmRNu3saAJDfSMcVEX0+TKa566HhfQyr7hnuHi uVf14HiwFkryn1ZIq8GCSveUtlPixt9DhWFlIIOYBVHhWBEkalUb+bq5iNULAGjUYUhk7Vg+oDRPHm Kp8ylPI9CF6Xto+p8wu+PMsJwHR/0+7mPhKJPigl4v4171ZtoPbPf3mu+nLA==
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
 kernel/bpf/btf.c             | 33 +++++++++++++++++++--------------
 kernel/bpf/verifier.c        | 25 ++++++++++++++++++++++---
 3 files changed, 43 insertions(+), 18 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 38b24ee8d8c2..c1fc4af47f69 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -523,7 +523,8 @@ int check_ptr_off_reg(struct bpf_verifier_env *env,
 		      const struct bpf_reg_state *reg, int regno);
 int check_func_arg_reg_off(struct bpf_verifier_env *env,
 			   const struct bpf_reg_state *reg, int regno,
-			   enum bpf_arg_type arg_type);
+			   enum bpf_arg_type arg_type,
+			   bool is_release_func);
 int check_kfunc_mem_size_reg(struct bpf_verifier_env *env, struct bpf_reg_state *reg,
 			     u32 regno);
 int check_mem_reg(struct bpf_verifier_env *env, struct bpf_reg_state *reg,
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 7f6a0ae5028b..162807e3b4a5 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -5753,6 +5753,10 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env,
 		return -EINVAL;
 	}
 
+	/* Only kfunc can be release func */
+	if (is_kfunc)
+		rel = btf_kfunc_id_set_contains(btf, resolve_prog_type(env->prog),
+						BTF_KFUNC_TYPE_RELEASE, func_id);
 	/* check that BTF function arguments match actual types that the
 	 * verifier sees.
 	 */
@@ -5777,7 +5781,7 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env,
 		ref_t = btf_type_skip_modifiers(btf, t->type, &ref_id);
 		ref_tname = btf_name_by_offset(btf, ref_t->name_off);
 
-		ret = check_func_arg_reg_off(env, reg, regno, ARG_DONTCARE);
+		ret = check_func_arg_reg_off(env, reg, regno, ARG_DONTCARE, rel);
 		if (ret < 0)
 			return ret;
 
@@ -5809,7 +5813,11 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env,
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
@@ -5891,18 +5899,15 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env,
 
 	/* Either both are set, or neither */
 	WARN_ON_ONCE((ref_obj_id && !ref_regno) || (!ref_obj_id && ref_regno));
-	if (is_kfunc) {
-		rel = btf_kfunc_id_set_contains(btf, resolve_prog_type(env->prog),
-						BTF_KFUNC_TYPE_RELEASE, func_id);
-		/* We already made sure ref_obj_id is set only for one argument */
-		if (rel && !ref_obj_id) {
-			bpf_log(log, "release kernel function %s expects refcounted PTR_TO_BTF_ID\n",
-				func_name);
-			return -EINVAL;
-		}
-		/* Allow (!rel && ref_obj_id), so that passing such referenced PTR_TO_BTF_ID to
-		 * other kfuncs works
-		 */
+	/* We already made sure ref_obj_id is set only for one argument. We do
+	 * allow (!rel && ref_obj_id), so that passing such referenced
+	 * PTR_TO_BTF_ID to other kfuncs works. Note that rel is only true when
+	 * is_kfunc is true.
+	 */
+	if (rel && !ref_obj_id) {
+		bpf_log(log, "release kernel function %s expects refcounted PTR_TO_BTF_ID\n",
+			func_name);
+		return -EINVAL;
 	}
 	/* returns argument register number > 0 in case of reference release kfunc */
 	return rel ? ref_regno : 0;
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 455b4ab69e47..fe9a513e2314 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -5367,10 +5367,11 @@ static int check_reg_type(struct bpf_verifier_env *env, u32 regno,
 
 int check_func_arg_reg_off(struct bpf_verifier_env *env,
 			   const struct bpf_reg_state *reg, int regno,
-			   enum bpf_arg_type arg_type)
+			   enum bpf_arg_type arg_type,
+			   bool is_release_func)
 {
+	bool fixed_off_ok = false, release_reg;
 	enum bpf_reg_type type = reg->type;
-	bool fixed_off_ok = false;
 
 	switch ((u32)type) {
 	case SCALAR_VALUE:
@@ -5395,6 +5396,21 @@ int check_func_arg_reg_off(struct bpf_verifier_env *env,
 	 * fixed offset.
 	 */
 	case PTR_TO_BTF_ID:
+		/* When referenced PTR_TO_BTF_ID is passed to release function,
+		 * it's fixed offset must be 0. We rely on the property that
+		 * only one referenced register can be passed to BPF helpers and
+		 * kfuncs. In the other cases, fixed offset can be non-zero.
+		 */
+		release_reg = is_release_func && reg->ref_obj_id;
+		if (release_reg && reg->off) {
+			verbose(env, "R%d must have zero offset when passed to release func\n",
+				regno);
+			return -EINVAL;
+		}
+		/* For release_reg == true, fixed_off_ok must be false, but we
+		 * already checked and rejected reg->off != 0 above, so set to
+		 * true to allow fixed offset for all other cases.
+		 */
 		fixed_off_ok = true;
 		break;
 	default:
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

