Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A5C4314912
	for <lists+bpf@lfdr.de>; Tue,  9 Feb 2021 07:45:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229517AbhBIGpd (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 9 Feb 2021 01:45:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229683AbhBIGpc (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 9 Feb 2021 01:45:32 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA816C06178B
        for <bpf@vger.kernel.org>; Mon,  8 Feb 2021 22:44:51 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id i5so1987020wmq.2
        for <bpf@vger.kernel.org>; Mon, 08 Feb 2021 22:44:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ubique-spb-ru.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qHHqJTCQk0vot1776iCz5J84ny+B8v+57IpvwZ7mfKE=;
        b=pIrDpSB1Ux1Q9q0ZzgRMpGwmsO0EC6I6uxzD5XlnhlzMBMTNhFahMYlDqq/QAj48aY
         2jtaYWy6tvxaqZGueewk9xFJipfFTbetrdS7Y99hqH0xo4UCmisZXHIOH9z5y8FWPHYb
         +V9i2f1j1bXBxWPxL5nFrSu1A1Stak8XTwa9MqhpcVzsCO8IIzrMC6vW5CN1fUuPiHxy
         k4oKRJbwjNCP+uqfOzl2kWlIND1m7wEE30TkH9andbadUAuQB8LeuY4HPll7/tINfyIM
         D9IcQFy9zbI1Ik+Yp5UCO8Z8x/zsjrilfC7C61aUFhBWh3sEYtFtpZuKJsHbYcwfwEiY
         8IaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qHHqJTCQk0vot1776iCz5J84ny+B8v+57IpvwZ7mfKE=;
        b=dW+CEba/nsw6hIWywm6MW0yY2qMIOid46DvuRHjKSz19gFjtIVtSZZJCamnku0FOnT
         kulpyQW/+lurujxgs4CFzAXHKLn1ByQZK1ZN3duOCpZD/3SnLhH5II3joncfUy79QiaS
         RvDeKhZaB+kFZ98+jshFP2F4+JJT6H/k3TFPRWtjXFCzeNIIYFk4kQBuh9QMnurJ/b34
         HT8a4ba19bv0CDiALIDpsjtTSqxY06UYdQUvjBEsDBPsuu4TLRaQVKzpEF+lW5QDF/Mh
         fqzIzZmlqDlG8B0KsGDmjbN92f4MNgfG7dVvJ152t8QHu/OAAXc81e3yxbyWptZb/NgD
         JxYg==
X-Gm-Message-State: AOAM533szEaSBWYVGxwrO0AtVfRtUOjkVnzf5OYoneoSPZaX4Ybgpi64
        Dki1LjqWcXeVss7VxafGz871LBrxInae8yL3ouw=
X-Google-Smtp-Source: ABdhPJzZl5Z606qj1Qx1+Vac6IMJ4kD1EdcU7EFrmcf7cPTIjzSaZQLTPnSKbU1xVcGrusCCKPht9g==
X-Received: by 2002:a1c:7507:: with SMTP id o7mr1890428wmc.165.1612853090018;
        Mon, 08 Feb 2021 22:44:50 -0800 (PST)
Received: from localhost ([154.21.15.43])
        by smtp.gmail.com with ESMTPSA id x9sm3016817wmb.14.2021.02.08.22.44.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Feb 2021 22:44:49 -0800 (PST)
From:   Dmitrii Banshchikov <me@ubique.spb.ru>
To:     bpf@vger.kernel.org
Cc:     Dmitrii Banshchikov <me@ubique.spb.ru>, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, kafai@fb.com,
        songliubraving@fb.com, yhs@fb.com, john.fastabend@gmail.com,
        kpsingh@chromium.org, rdna@fb.com
Subject: [PATCH v2 bpf-next 3/4] bpf: Support pointers in global func args
Date:   Tue,  9 Feb 2021 10:44:20 +0400
Message-Id: <20210209064421.15222-4-me@ubique.spb.ru>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210209064421.15222-1-me@ubique.spb.ru>
References: <20210209064421.15222-1-me@ubique.spb.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add an ability to pass a pointer to a type with known size in arguments
of a global function. Such pointers may be used to overcome the limit on
the maximum number of arguments, avoid expensive and tricky workarounds
and to have multiple output arguments.

A referenced type may contain pointers but indirect access through them
isn't supported.

The implementation consists of two parts.  If a global function has an
argument that is a pointer to a type with known size then:

  1) In btf_check_func_arg_match(): check that the corresponding
register points to NULL or to a valid memory region that is large enough
to contain the expected argument's type.

  2) In btf_prepare_func_args(): set the corresponding register type to
PTR_TO_MEM_OR_NULL and its size to the size of the expected type.

A call to a global function may change stack's memory slot type(via
check_helper_mem_access) similar to a helper function. That is why new
pointer arguments are allowed only for functions with global linkage.
Consider a case: stack's memory slot type is changed to STACK_MISC from
spilled PTR_TO_PACKET(btf_check_func_arg_match() -> check_mem_reg() ->
check_helper_mem_access() -> check_stack_boundary()) after a call to a
static function and later verifier cannot infer safety of indirect
accesses through the stack memory(check_stack_read() ->
__mark_reg_unknown ()). This will break existing code.

Signed-off-by: Dmitrii Banshchikov <me@ubique.spb.ru>
---
v1 -> v2:
 - Allow pointers only for global functions
 - Add support of any type with known size
 - Use conventional way to generate reg id
 - Use boolean true/false instead of int 1/0
 - Fix formatting

 include/linux/bpf_verifier.h |  2 ++
 kernel/bpf/btf.c             | 55 +++++++++++++++++++++++++++++-------
 kernel/bpf/verifier.c        | 30 ++++++++++++++++++++
 3 files changed, 77 insertions(+), 10 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index dfe6f85d97dd..ce91c8651ad9 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -470,6 +470,8 @@ bpf_prog_offload_remove_insns(struct bpf_verifier_env *env, u32 off, u32 cnt);
 
 int check_ctx_reg(struct bpf_verifier_env *env,
 		  const struct bpf_reg_state *reg, int regno);
+int check_mem_reg(struct bpf_verifier_env *env, struct bpf_reg_state *reg,
+		   u32 regno, u32 mem_size);
 
 /* this lives here instead of in bpf.h because it needs to dereference tgt_prog */
 static inline u64 bpf_trampoline_compute_key(const struct bpf_prog *tgt_prog,
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index bd5d2c563693..90019f92deec 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -5297,9 +5297,10 @@ int btf_check_func_arg_match(struct bpf_verifier_env *env, int subprog,
 	struct bpf_prog *prog = env->prog;
 	struct btf *btf = prog->aux->btf;
 	const struct btf_param *args;
-	const struct btf_type *t;
-	u32 i, nargs, btf_id;
+	const struct btf_type *t, *ref_t;
+	u32 i, nargs, btf_id, type_size;
 	const char *tname;
+	bool is_global;
 
 	if (!prog->aux->func_info)
 		return -EINVAL;
@@ -5333,6 +5334,8 @@ int btf_check_func_arg_match(struct bpf_verifier_env *env, int subprog,
 		bpf_log(log, "Function %s has %d > 5 args\n", tname, nargs);
 		goto out;
 	}
+
+	is_global = prog->aux->func_info_aux[subprog].linkage == BTF_FUNC_GLOBAL;
 	/* check that BTF function arguments match actual types that the
 	 * verifier sees.
 	 */
@@ -5349,10 +5352,6 @@ int btf_check_func_arg_match(struct bpf_verifier_env *env, int subprog,
 			goto out;
 		}
 		if (btf_type_is_ptr(t)) {
-			if (reg->type == SCALAR_VALUE) {
-				bpf_log(log, "R%d is not a pointer\n", i + 1);
-				goto out;
-			}
 			/* If function expects ctx type in BTF check that caller
 			 * is passing PTR_TO_CTX.
 			 */
@@ -5367,6 +5366,25 @@ int btf_check_func_arg_match(struct bpf_verifier_env *env, int subprog,
 					goto out;
 				continue;
 			}
+
+			if (!is_global)
+				goto out;
+
+			t = btf_type_skip_modifiers(btf, t->type, NULL);
+
+			ref_t = btf_resolve_size(btf, t, &type_size);
+			if (IS_ERR(ref_t)) {
+				bpf_log(log,
+				    "arg#%d reference type('%s %s') size cannot be determined: %ld\n",
+				    i, btf_type_str(t), btf_name_by_offset(btf, t->name_off),
+					PTR_ERR(ref_t));
+				goto out;
+			}
+
+			if (check_mem_reg(env, reg, i + 1, type_size))
+				goto out;
+
+			continue;
 		}
 		bpf_log(log, "Unrecognized arg#%d type %s\n",
 			i, btf_kind_str[BTF_INFO_KIND(t->info)]);
@@ -5397,7 +5415,7 @@ int btf_prepare_func_args(struct bpf_verifier_env *env, int subprog,
 	enum bpf_prog_type prog_type = prog->type;
 	struct btf *btf = prog->aux->btf;
 	const struct btf_param *args;
-	const struct btf_type *t;
+	const struct btf_type *t, *ref_t;
 	u32 i, nargs, btf_id;
 	const char *tname;
 
@@ -5470,9 +5488,26 @@ int btf_prepare_func_args(struct bpf_verifier_env *env, int subprog,
 			reg->type = SCALAR_VALUE;
 			continue;
 		}
-		if (btf_type_is_ptr(t) &&
-		    btf_get_prog_ctx_type(log, btf, t, prog_type, i)) {
-			reg->type = PTR_TO_CTX;
+		if (btf_type_is_ptr(t)) {
+			if (btf_get_prog_ctx_type(log, btf, t, prog_type, i)) {
+				reg->type = PTR_TO_CTX;
+				continue;
+			}
+
+			t = btf_type_skip_modifiers(btf, t->type, NULL);
+
+			ref_t = btf_resolve_size(btf, t, &reg->mem_size);
+			if (IS_ERR(ref_t)) {
+				bpf_log(log,
+				    "arg#%d reference type('%s %s') size cannot be determined: %ld\n",
+				    i, btf_type_str(t), btf_name_by_offset(btf, t->name_off),
+					PTR_ERR(ref_t));
+				return -EINVAL;
+			}
+
+			reg->type = PTR_TO_MEM_OR_NULL;
+			reg->id = i + 1;
+
 			continue;
 		}
 		bpf_log(log, "Arg#%d type %s in %s() is not supported yet.\n",
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index d68ea6eb4f9b..fd423af1cc57 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -3942,6 +3942,29 @@ static int check_helper_mem_access(struct bpf_verifier_env *env, int regno,
 	}
 }
 
+int check_mem_reg(struct bpf_verifier_env *env, struct bpf_reg_state *reg,
+		   u32 regno, u32 mem_size)
+{
+	if (register_is_null(reg))
+		return 0;
+
+	if (reg_type_may_be_null(reg->type)) {
+		/* Assuming that the register contains a value check if the memory
+		 * access is safe. Temorarily save and restore the register's state as
+		 * the conversion shouldn't be visible to a caller.
+		 */
+		const struct bpf_reg_state saved_reg = *reg;
+		int rv;
+
+		mark_ptr_not_null_reg(reg);
+		rv = check_helper_mem_access(env, regno, mem_size, true, NULL);
+		*reg = saved_reg;
+		return rv;
+	}
+
+	return check_helper_mem_access(env, regno, mem_size, true, NULL);
+}
+
 /* Implementation details:
  * bpf_map_lookup returns PTR_TO_MAP_VALUE_OR_NULL
  * Two bpf_map_lookups (even with the same key) will have different reg->id.
@@ -11572,6 +11595,13 @@ static int do_check_common(struct bpf_verifier_env *env, int subprog)
 				mark_reg_known_zero(env, regs, i);
 			else if (regs[i].type == SCALAR_VALUE)
 				mark_reg_unknown(env, regs, i);
+			else if (regs[i].type == PTR_TO_MEM_OR_NULL) {
+				const u32 mem_size = regs[i].mem_size;
+
+				mark_reg_known_zero(env, regs, i);
+				regs[i].mem_size = mem_size;
+				regs[i].id = ++env->id_gen;
+			}
 		}
 	} else {
 		/* 1st arg to a function */
-- 
2.25.1

