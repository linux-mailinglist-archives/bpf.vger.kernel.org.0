Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA7B4626208
	for <lists+bpf@lfdr.de>; Fri, 11 Nov 2022 20:34:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234004AbiKKTeL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 11 Nov 2022 14:34:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234032AbiKKTeK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 11 Nov 2022 14:34:10 -0500
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7847268296
        for <bpf@vger.kernel.org>; Fri, 11 Nov 2022 11:34:09 -0800 (PST)
Received: by mail-pg1-x541.google.com with SMTP id q71so5123602pgq.8
        for <bpf@vger.kernel.org>; Fri, 11 Nov 2022 11:34:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zRayPDTMNDdwJIvMlrtwqNk1Jz4XpAmdb2FhOmDxB74=;
        b=YYOfC+xGPhBmwJwRjpThfc7KVxqXzSHQJRsT2RBoyx6k+/pCHYi9ODYLK3i4h193mH
         +wlPCNlm405uuCPNQCDq6Hxr9KxlX+zHWM4JvD42RpbdidUTJR1crEfTjaUd/rCh//Vo
         oAJkWU0n31Yo+4iOQtGNpE6ZrrF8+4nMJ+V8Al5NpuEhcO/uxRAQ/34jDe9LDJWBJ5Os
         dFuXK5VihtcI4MDPXTp4NBkHhtMgYAfysTRRIraAOp7kSeHQn1Q58ZTteUPbDfDzHpod
         TIlI74hHs3LkXAslKdenh30tTeUFIQ27gLHXpMSuzA79KjPAjT9LPm6nFCMsRcWEynem
         JdTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zRayPDTMNDdwJIvMlrtwqNk1Jz4XpAmdb2FhOmDxB74=;
        b=miZw7bN2bOKdIaf62lpzzg7xmgRGOAXi1CVRZfmqtIAxdHUT0k6gK5iMAMULuwv9ui
         yHt8n+y9WrwbLJ5qesVK3U0gVuqcYnJe3Ho7hF4cixvLnNSVGunOtrpofcBDpmUlP+lk
         Ui98cihhqV32cMwc+GGtf+BfMcGlvDs+hI0udNcuR7m5nCyg/jac1iEitVn1iVoTEMES
         K5GuA/KjpP9OBfW9Y6CWjcORqW6GWHdL6koS06BU6BYx+Feda9fEOhX5JVryMkcjmB75
         egWcC2ofWGY9ED+zO1V+NTP7Je6c1NcoDErnb8S5wpcWnyNrDpagXy0Ui4PoVz2hTp88
         g+FQ==
X-Gm-Message-State: ANoB5plU2Oz2G9XISjBeHYBUlWVfOIvWasBlAWo6JeKZCbiY7+8TMXTa
        Fexb3hiVja2wbiNwmLajFce3U5DG1BwyfA==
X-Google-Smtp-Source: AA0mqf6UG2jDO+eyxGWYOETs4OHb/ebzBy63HInxgWMPhMmimDiHP31pAUG4k98sNimI16lTznJCkg==
X-Received: by 2002:a63:1cf:0:b0:470:71df:a6c3 with SMTP id 198-20020a6301cf000000b0047071dfa6c3mr2890424pgb.447.1668195248721;
        Fri, 11 Nov 2022 11:34:08 -0800 (PST)
Received: from localhost ([14.96.13.220])
        by smtp.gmail.com with ESMTPSA id s18-20020a170903215200b00186a6b6350esm2028952ple.268.2022.11.11.11.34.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Nov 2022 11:34:08 -0800 (PST)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Dave Marchevsky <davemarchevsky@meta.com>,
        Delyan Kratunov <delyank@meta.com>
Subject: [PATCH bpf-next v6 16/26] bpf: Support constant scalar arguments for kfuncs
Date:   Sat, 12 Nov 2022 01:02:14 +0530
Message-Id: <20221111193224.876706-17-memxor@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221111193224.876706-1-memxor@gmail.com>
References: <20221111193224.876706-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5263; i=memxor@gmail.com; h=from:subject; bh=bHdnbGRPK80DCis6rQXFsz8HZ2Ly3kkCygOqxu0OP08=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBjbqIoc5QnrWiHuZEI2OBSPAwWl9WsOkhzTnjV5Up7 Z2rex4aJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCY26iKAAKCRBM4MiGSL8RygMND/ 4vr0kw1ctsotc1PBrAl/r10+oqF9VXgg1d7w/lMcRSAi+7mn7S6hy57RHVTN6FKCmEwGTKgvUEiEyh LzKPcLorRqlDJ1gATB461hIOKcE/tHAFjoZPuj0ZMFKeffVPe978GuSbL4NGpslBvH3VUu6yIGJk0k y5Hfi1zE/hEYqyhe40R8zRpcC6DZtYr3cafqVTq6Lm9s9raXol11wGfP6cQxyEBFv3VAadp2Cou+VZ /jWDg7/7KtR06yjBqz30YXE4fwSMxPbJvMz6X+nbd3yhxsd/H+PV6Wu/AJhnKX90njorJ/uYsSUxMg NR92R5PIqXfLqdLtfohBb9ZI4mk8SxeY6xjDqWsF8b4nAbalP/51lQgyTMS+g9Kops3TqQXv6rfj33 vloDHiE7BS3eRuHEXyGEW0XopN+H+nAMaxnTpTmlkk4nK5YGkZwQiC6kz6679D2oJNpwx6SBMn5Ud2 wLWy6FwgYwEDZg5zHlclsA6cjKqD+vGuSCwA+tDWfSSj0SRTqcXtoGbkdAT7P/MLq4WCK0Idx4V0T4 hfUWzVoOPkOVLWwY53MBDPRc74OmEXHp6FV4I1rwbu3Ft1q7qC+ZFyhBe87f+OA3Z6bCk4A31CiRGE j8cDs3WnjOxy2yWZ7tztHhXAQYau6VPT9E8sGMrsh1lyXchDv1pt+zIF7nvg==
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

Allow passing known constant scalars as arguments to kfuncs that do not
represent a size parameter. This makes the search pruning optimization
of verifier more conservative for such kfunc calls, and each
non-distinct argument is considered unequivalent.

We will use this support to then expose a bpf_obj_new function where it
takes the local type ID of a type in program BTF, and returns a
PTR_TO_BTF_ID | MEM_ALLOC to the local type, and allows programs to
allocate their own objects.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 Documentation/bpf/kfuncs.rst | 22 ++++++++++++++
 kernel/bpf/verifier.c        | 59 +++++++++++++++++++++++++++---------
 2 files changed, 67 insertions(+), 14 deletions(-)

diff --git a/Documentation/bpf/kfuncs.rst b/Documentation/bpf/kfuncs.rst
index 0f858156371d..8fa9c052417f 100644
--- a/Documentation/bpf/kfuncs.rst
+++ b/Documentation/bpf/kfuncs.rst
@@ -72,6 +72,28 @@ argument as its size. By default, without __sz annotation, the size of the type
 of the pointer is used. Without __sz annotation, a kfunc cannot accept a void
 pointer.
 
+2.2.1 __k Annotation
+--------------------
+
+This annotation is only understood for scalar arguments, where it indicates that
+the verifier must check the scalar argument to be a known constant, which does
+not indicate a size parameter.
+
+An example is given below::
+
+        void *bpf_obj_new(u32 local_type_id__k, ...)
+        {
+        ...
+        }
+
+Here, bpf_obj_new uses local_type_id argument to find out the size of that type
+ID in program's BTF and return a sized pointer to it. Each type ID will have a
+distinct size, hence it is crucial to treat each such call as distinct when
+values don't match.
+
+Hence, whenever a constant scalar argument is accepted by a kfunc which is not a
+size parameter, __k suffix should be used.
+
 .. _BPF_kfunc_nodef:
 
 2.3 Using an existing kernel function
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index dd0047ac53f9..ad6d7531322c 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -7862,6 +7862,10 @@ struct bpf_kfunc_call_arg_meta {
 	u8 release_regno;
 	bool r0_rdonly;
 	u64 r0_size;
+	struct {
+		u64 value;
+		bool found;
+	} arg_constant;
 };
 
 static bool is_kfunc_acquire(struct bpf_kfunc_call_arg_meta *meta)
@@ -7899,30 +7903,40 @@ static bool is_kfunc_arg_kptr_get(struct bpf_kfunc_call_arg_meta *meta, int arg)
 	return arg == 0 && (meta->kfunc_flags & KF_KPTR_GET);
 }
 
-static bool is_kfunc_arg_mem_size(const struct btf *btf,
-				  const struct btf_param *arg,
-				  const struct bpf_reg_state *reg)
+static bool __kfunc_param_match_suffix(const struct btf *btf,
+				       const struct btf_param *arg,
+				       const char *suffix)
 {
-	int len, sfx_len = sizeof("__sz") - 1;
-	const struct btf_type *t;
+	int suffix_len = strlen(suffix), len;
 	const char *param_name;
 
-	t = btf_type_skip_modifiers(btf, arg->type, NULL);
-	if (!btf_type_is_scalar(t) || reg->type != SCALAR_VALUE)
-		return false;
-
 	/* In the future, this can be ported to use BTF tagging */
 	param_name = btf_name_by_offset(btf, arg->name_off);
 	if (str_is_empty(param_name))
 		return false;
 	len = strlen(param_name);
-	if (len < sfx_len)
+	if (len < suffix_len)
 		return false;
-	param_name += len - sfx_len;
-	if (strncmp(param_name, "__sz", sfx_len))
+	param_name += len - suffix_len;
+	return !strncmp(param_name, suffix, suffix_len);
+}
+
+static bool is_kfunc_arg_mem_size(const struct btf *btf,
+				  const struct btf_param *arg,
+				  const struct bpf_reg_state *reg)
+{
+	const struct btf_type *t;
+
+	t = btf_type_skip_modifiers(btf, arg->type, NULL);
+	if (!btf_type_is_scalar(t) || reg->type != SCALAR_VALUE)
 		return false;
 
-	return true;
+	return __kfunc_param_match_suffix(btf, arg, "__sz");
+}
+
+static bool is_kfunc_arg_sfx_constant(const struct btf *btf, const struct btf_param *arg)
+{
+	return __kfunc_param_match_suffix(btf, arg, "__k");
 }
 
 static bool is_kfunc_arg_ret_buf_size(const struct btf *btf,
@@ -8198,7 +8212,24 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
 				verbose(env, "R%d is not a scalar\n", regno);
 				return -EINVAL;
 			}
-			if (is_kfunc_arg_ret_buf_size(btf, &args[i], reg, "rdonly_buf_size")) {
+			if (is_kfunc_arg_sfx_constant(meta->btf, &args[i])) {
+				/* kfunc is already bpf_capable() only, no need
+				 * to check it here.
+				 */
+				if (meta->arg_constant.found) {
+					verbose(env, "verifier internal error: only one constant argument permitted\n");
+					return -EFAULT;
+				}
+				if (!tnum_is_const(reg->var_off)) {
+					verbose(env, "R%d must be a known constant\n", regno);
+					return -EINVAL;
+				}
+				ret = mark_chain_precision(env, regno);
+				if (ret < 0)
+					return ret;
+				meta->arg_constant.found = true;
+				meta->arg_constant.value = reg->var_off.value;
+			} else if (is_kfunc_arg_ret_buf_size(btf, &args[i], reg, "rdonly_buf_size")) {
 					meta->r0_rdonly = true;
 					is_ret_buf_sz = true;
 			} else if (is_kfunc_arg_ret_buf_size(btf, &args[i], reg, "rdwr_buf_size")) {
-- 
2.38.1

