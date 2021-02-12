Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69BC831A659
	for <lists+bpf@lfdr.de>; Fri, 12 Feb 2021 21:58:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231771AbhBLU54 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 12 Feb 2021 15:57:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231829AbhBLU5q (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 12 Feb 2021 15:57:46 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCA7BC061788
        for <bpf@vger.kernel.org>; Fri, 12 Feb 2021 12:57:05 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id r21so792625wrr.9
        for <bpf@vger.kernel.org>; Fri, 12 Feb 2021 12:57:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ubique-spb-ru.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=C+XMdAbQ9Z+o/WoP/fR1Y6c8Lee0ME0HFsCR6UPwRjg=;
        b=s7C5L7fp1IuodHEeT0oxH+ksDd3bzriQQC+SxlO5hJ8+biF3sfI6ykSA+EIdxFtsmf
         DLxPjBgvVZQCXFeFGFzKwpyi9NeWwzMs70JLTuCp2Hc+wLq+DXI55Y6TLnYHQJx/hmKB
         cgrtjmKGcGSUT+AjMsfOKiBy8qODmACB5rQ4UvWKFWcyh60SZlXbRPXMOFra0F3t9n8w
         UvwtEr2Fpj2qo+8giK4/JQ/tDdakwz4u6ZX87ff6Q1k/lZMfGN23gM5EEv3M1a8an1Mi
         Hj8KhMW71j1eL/IEgb0Z46bWAcYnZ+wZPUkY2C/smFUxn/yoo0Qc42Xxy0JwBtIizbuj
         efzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=C+XMdAbQ9Z+o/WoP/fR1Y6c8Lee0ME0HFsCR6UPwRjg=;
        b=QM/glOuSFz724EkIrMbgy55io2BzRZ6LTWqN3QD3yxs86RQzfZD1l6tR4eEb2WsOEJ
         q5Z8PZFd+H0hNw/mNNuABEQ7EbGLYIwyXKbTM0tjCR4bTNtjM/WuG9hSg9aht7TvDWF8
         FZDIGvIf9+j77DXrx3XOPAUxQuInipHP85vAkV5m5/KLeDkvVv6dX7fVWSmm+WZcr65V
         acOLx9PNdypU9U+UFvexDYtLPxU+dscrJ3JzPMhwdksmavPAFLA7NeEDZ981l8uBeyEw
         pI56TntuRSKN0qJV2aHt9L4nY9YmaPQ5ziByqOsdq74Xs4YlmpWO7F7rUEqIv2HMnStD
         llfw==
X-Gm-Message-State: AOAM5316+HEL9gzySWdjCHsSwPobFcQXioDdzcwnOzXNbacVTqu9X5v+
        U6D08Brsw1df64KWrF5c7KLmwi5xDb8u/QC8qSg=
X-Google-Smtp-Source: ABdhPJxq6RAyfZleZbXsPi9duciMd5so6+l3caFswA6Umb4s6WCVN0r39JBUt95FmNAMkB6HO8Rmng==
X-Received: by 2002:a5d:43c2:: with SMTP id v2mr5408668wrr.81.1613163424352;
        Fri, 12 Feb 2021 12:57:04 -0800 (PST)
Received: from localhost ([91.73.148.48])
        by smtp.gmail.com with ESMTPSA id v1sm15772928wmj.31.2021.02.12.12.57.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Feb 2021 12:57:04 -0800 (PST)
From:   Dmitrii Banshchikov <me@ubique.spb.ru>
To:     bpf@vger.kernel.org
Cc:     Dmitrii Banshchikov <me@ubique.spb.ru>, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, kafai@fb.com,
        songliubraving@fb.com, yhs@fb.com, john.fastabend@gmail.com,
        kpsingh@chromium.org, rdna@fb.com
Subject: [PATCH v3 bpf-next 3/4] bpf: Support pointers in global func args
Date:   Sat, 13 Feb 2021 00:56:41 +0400
Message-Id: <20210212205642.620788-4-me@ubique.spb.ru>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210212205642.620788-1-me@ubique.spb.ru>
References: <20210212205642.620788-1-me@ubique.spb.ru>
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

Only global functions are supported because allowance of pointers for
static functions might break validation. Consider the following
scenario. A static function has a pointer argument. A caller passes
pointer to its stack memory. Because the callee can change referenced
memory verifier cannot longer assume any particular slot type of the
caller's stack memory hence the slot type is changed to SLOT_MISC.  If
there is an operation that relies on slot type other than SLOT_MISC then
verifier won't be able to infer safety of the operation.

When verifier sees a static function that has a pointer argument
different from PTR_TO_CTX then it skips arguments check and continues
with "inline" validation with more information available. The operation
that relies on the particular slot type now succeeds.

Because global functions were not allowed to have pointer arguments
different from PTR_TO_CTX it's not possible to break existing and valid
code.

Signed-off-by: Dmitrii Banshchikov <me@ubique.spb.ru>
---
 include/linux/bpf_verifier.h |  2 ++
 kernel/bpf/btf.c             | 55 +++++++++++++++++++++++++++++-------
 kernel/bpf/verifier.c        | 30 ++++++++++++++++++++
 3 files changed, 77 insertions(+), 10 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 532c97836d0d..971b33aca13d 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -471,6 +471,8 @@ bpf_prog_offload_remove_insns(struct bpf_verifier_env *env, u32 off, u32 cnt);
 
 int check_ctx_reg(struct bpf_verifier_env *env,
 		  const struct bpf_reg_state *reg, int regno);
+int check_mem_reg(struct bpf_verifier_env *env, struct bpf_reg_state *reg,
+		   u32 regno, u32 mem_size);
 
 /* this lives here instead of in bpf.h because it needs to dereference tgt_prog */
 static inline u64 bpf_trampoline_compute_key(const struct bpf_prog *tgt_prog,
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index bd5d2c563693..2efeb5f4b343 100644
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
+			reg->id = ++env->id_gen;
+
 			continue;
 		}
 		bpf_log(log, "Arg#%d type %s in %s() is not supported yet.\n",
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index e391ed325249..ed04999ae247 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -4272,6 +4272,29 @@ static int check_helper_mem_access(struct bpf_verifier_env *env, int regno,
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
+		 * access is safe. Temporarily save and restore the register's state as
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
@@ -11941,6 +11964,13 @@ static int do_check_common(struct bpf_verifier_env *env, int subprog)
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

