Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FFE26A703A
	for <lists+bpf@lfdr.de>; Wed,  1 Mar 2023 16:51:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229557AbjCAPvM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 1 Mar 2023 10:51:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229879AbjCAPvK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 1 Mar 2023 10:51:10 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29AD843476;
        Wed,  1 Mar 2023 07:51:03 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id oj5so9815070pjb.5;
        Wed, 01 Mar 2023 07:51:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677685862;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yiBzhLzbQr9xtj01CzdjXMDh0hhAbysTY5uSxywJbNo=;
        b=WzeigffhExQd1H6VPBp1Z6Ms38esWmI24pwo0clFnkOgKGKqH00DwlD371A4PRjBR2
         Knu5Qz2CNkyrEKCpQvuRt/4gL6tzmj7qYsiqUuAhO4TqGLLQyKnTkvdP62pufu4ErTre
         xS2MQLAkqhufPfBAkBL2cDwK4e8ZIKlPIdd6TL7yap6gY7++4gAAHiYQi8NSY+DMfcLS
         qEQGHRIq6g1/U+2XNo1JbHXJWtCLCFBC4E2HGSXgDfyzzqwzGuklWg9HODPIMuE7oNR7
         l6IFXPhZszuG09dfVDt0WFDMNxiFnAfeDQS1LcjK8ZJ+7+AgIkbA5KgHBCXIwDgYAbdX
         C2jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677685862;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yiBzhLzbQr9xtj01CzdjXMDh0hhAbysTY5uSxywJbNo=;
        b=o56Gu+70NIXJcKSQ0nOkemuIJAsnh/xYqwMZQsIF4VG1LFUYmuIdSVeBW8zYbitYlt
         59T0503PzjUHS/dOf6QxRNinxlGEpddCWD14x1QTNdyhH0od3G6iENYrXy7PjPxaDM/J
         9cR5viqfvPsWQly9i78dZedMHJ8FfdPqcByqJ7fMKS527XMvfjCRe4Dlv46yxKssBoib
         un3gOfVrYIhYfRWQdwl8Perdb8kVYK7pIA5DeBQ/l2/GKTSlpHLT4HJmyImd+ehSI//h
         XPSxQ/0USiVeN/qgGlPlUGDGWyMiHDFknRpdBtAGxRzTWkhNjtXLMGYLGMD3d0EE9AXl
         lxsA==
X-Gm-Message-State: AO0yUKXh38xh+uX0qZk4JPCksAXAfkZAN+3kNN0CKi8ZJgEo7+hG7pnx
        QPcp/sIKJ/RRhONVeARBH2va4mY7y5Y=
X-Google-Smtp-Source: AK7set/Ma9BQU9m+/hLf2zoy5RqE3yu0QrMnU7V016PU9FJXk4KPDBR4hJ3MO8TX4xOP3nivklP1JA==
X-Received: by 2002:a17:90b:4d0b:b0:22b:efa5:d05 with SMTP id mw11-20020a17090b4d0b00b0022befa50d05mr7731973pjb.40.1677685862221;
        Wed, 01 Mar 2023 07:51:02 -0800 (PST)
Received: from gatsby.corp.tfbnw.net (75-172-126-232.tukw.qwest.net. [75.172.126.232])
        by smtp.gmail.com with ESMTPSA id c9-20020a637249000000b00502f20aa4desm7589490pgn.70.2023.03.01.07.51.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Mar 2023 07:51:01 -0800 (PST)
From:   Joanne Koong <joannelkoong@gmail.com>
To:     bpf@vger.kernel.org
Cc:     martin.lau@kernel.org, andrii@kernel.org, ast@kernel.org,
        memxor@gmail.com, daniel@iogearbox.net, netdev@vger.kernel.org,
        toke@kernel.org, Joanne Koong <joannelkoong@gmail.com>
Subject: [PATCH v13 bpf-next 03/10] bpf: Allow initializing dynptrs in kfuncs
Date:   Wed,  1 Mar 2023 07:49:46 -0800
Message-Id: <20230301154953.641654-4-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230301154953.641654-1-joannelkoong@gmail.com>
References: <20230301154953.641654-1-joannelkoong@gmail.com>
MIME-Version: 1.0
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

This change allows kfuncs to take in an uninitialized dynptr as a
parameter. Before this change, only helper functions could successfully
use uninitialized dynptrs. This change moves the memory access check
(including stack state growing and slot marking) into
process_dynptr_func(), which both helpers and kfuncs call into.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 kernel/bpf/verifier.c | 67 ++++++++++++++-----------------------------
 1 file changed, 22 insertions(+), 45 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index e0e00509846b..82e39fc5ed05 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -268,7 +268,6 @@ struct bpf_call_arg_meta {
 	u32 ret_btf_id;
 	u32 subprogno;
 	struct btf_field *kptr_field;
-	u8 uninit_dynptr_regno;
 };
 
 struct btf *btf_vmlinux;
@@ -6225,10 +6224,11 @@ static int process_kptr_func(struct bpf_verifier_env *env, int regno,
  * Helpers which do not mutate the bpf_dynptr set MEM_RDONLY in their argument
  * type, and declare it as 'const struct bpf_dynptr *' in their prototype.
  */
-static int process_dynptr_func(struct bpf_verifier_env *env, int regno,
-			       enum bpf_arg_type arg_type, struct bpf_call_arg_meta *meta)
+static int process_dynptr_func(struct bpf_verifier_env *env, int regno, int insn_idx,
+			       enum bpf_arg_type arg_type)
 {
 	struct bpf_reg_state *regs = cur_regs(env), *reg = &regs[regno];
+	int err;
 
 	/* MEM_UNINIT and MEM_RDONLY are exclusive, when applied to an
 	 * ARG_PTR_TO_DYNPTR (or ARG_PTR_TO_DYNPTR | DYNPTR_TYPE_*):
@@ -6254,23 +6254,23 @@ static int process_dynptr_func(struct bpf_verifier_env *env, int regno,
 	 *		 to.
 	 */
 	if (arg_type & MEM_UNINIT) {
+		int i;
+
 		if (!is_dynptr_reg_valid_uninit(env, reg)) {
 			verbose(env, "Dynptr has to be an uninitialized dynptr\n");
 			return -EINVAL;
 		}
 
-		/* We only support one dynptr being uninitialized at the moment,
-		 * which is sufficient for the helper functions we have right now.
-		 */
-		if (meta->uninit_dynptr_regno) {
-			verbose(env, "verifier internal error: multiple uninitialized dynptr args\n");
-			return -EFAULT;
+		/* we write BPF_DW bits (8 bytes) at a time */
+		for (i = 0; i < BPF_DYNPTR_SIZE; i += 8) {
+			err = check_mem_access(env, insn_idx, regno,
+					       i, BPF_DW, BPF_WRITE, -1, false);
+			if (err)
+				return err;
 		}
 
-		meta->uninit_dynptr_regno = regno;
+		err = mark_stack_slots_dynptr(env, reg, arg_type, insn_idx);
 	} else /* MEM_RDONLY and None case from above */ {
-		int err;
-
 		/* For the reg->type == PTR_TO_STACK case, bpf_dynptr is never const */
 		if (reg->type == CONST_PTR_TO_DYNPTR && !(arg_type & MEM_RDONLY)) {
 			verbose(env, "cannot pass pointer to const bpf_dynptr, the helper mutates it\n");
@@ -6306,10 +6306,8 @@ static int process_dynptr_func(struct bpf_verifier_env *env, int regno,
 		}
 
 		err = mark_dynptr_read(env, reg);
-		if (err)
-			return err;
 	}
-	return 0;
+	return err;
 }
 
 static bool arg_type_is_mem_size(enum bpf_arg_type type)
@@ -6719,7 +6717,8 @@ static int dynptr_ref_obj_id(struct bpf_verifier_env *env, struct bpf_reg_state
 
 static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 			  struct bpf_call_arg_meta *meta,
-			  const struct bpf_func_proto *fn)
+			  const struct bpf_func_proto *fn,
+			  int insn_idx)
 {
 	u32 regno = BPF_REG_1 + arg;
 	struct bpf_reg_state *regs = cur_regs(env), *reg = &regs[regno];
@@ -6932,7 +6931,7 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 		err = check_mem_size_reg(env, reg, regno, true, meta);
 		break;
 	case ARG_PTR_TO_DYNPTR:
-		err = process_dynptr_func(env, regno, arg_type, meta);
+		err = process_dynptr_func(env, regno, insn_idx, arg_type);
 		if (err)
 			return err;
 		break;
@@ -8218,7 +8217,7 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
 	meta.func_id = func_id;
 	/* check args */
 	for (i = 0; i < MAX_BPF_FUNC_REG_ARGS; i++) {
-		err = check_func_arg(env, i, &meta, fn);
+		err = check_func_arg(env, i, &meta, fn, insn_idx);
 		if (err)
 			return err;
 	}
@@ -8243,30 +8242,6 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
 
 	regs = cur_regs(env);
 
-	/* This can only be set for PTR_TO_STACK, as CONST_PTR_TO_DYNPTR cannot
-	 * be reinitialized by any dynptr helper. Hence, mark_stack_slots_dynptr
-	 * is safe to do directly.
-	 */
-	if (meta.uninit_dynptr_regno) {
-		if (regs[meta.uninit_dynptr_regno].type == CONST_PTR_TO_DYNPTR) {
-			verbose(env, "verifier internal error: CONST_PTR_TO_DYNPTR cannot be initialized\n");
-			return -EFAULT;
-		}
-		/* we write BPF_DW bits (8 bytes) at a time */
-		for (i = 0; i < BPF_DYNPTR_SIZE; i += 8) {
-			err = check_mem_access(env, insn_idx, meta.uninit_dynptr_regno,
-					       i, BPF_DW, BPF_WRITE, -1, false);
-			if (err)
-				return err;
-		}
-
-		err = mark_stack_slots_dynptr(env, &regs[meta.uninit_dynptr_regno],
-					      fn->arg_type[meta.uninit_dynptr_regno - BPF_REG_1],
-					      insn_idx);
-		if (err)
-			return err;
-	}
-
 	if (meta.release_regno) {
 		err = -EINVAL;
 		/* This can only be set for PTR_TO_STACK, as CONST_PTR_TO_DYNPTR cannot
@@ -9475,7 +9450,8 @@ static int process_kf_arg_ptr_to_rbtree_node(struct bpf_verifier_env *env,
 						  &meta->arg_rbtree_root.field);
 }
 
-static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_arg_meta *meta)
+static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_arg_meta *meta,
+			    int insn_idx)
 {
 	const char *func_name = meta->func_name, *ref_tname;
 	const struct btf *btf = meta->btf;
@@ -9672,7 +9648,8 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
 				return -EINVAL;
 			}
 
-			ret = process_dynptr_func(env, regno, ARG_PTR_TO_DYNPTR | MEM_RDONLY, NULL);
+			ret = process_dynptr_func(env, regno, insn_idx,
+						  ARG_PTR_TO_DYNPTR | MEM_RDONLY);
 			if (ret < 0)
 				return ret;
 			break;
@@ -9880,7 +9857,7 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 	}
 
 	/* Check the arguments */
-	err = check_kfunc_args(env, &meta);
+	err = check_kfunc_args(env, &meta, insn_idx);
 	if (err < 0)
 		return err;
 	/* In case of release function, we get register number of refcounted
-- 
2.34.1

