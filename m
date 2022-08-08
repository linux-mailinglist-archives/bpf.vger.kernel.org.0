Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 870E058CA1A
	for <lists+bpf@lfdr.de>; Mon,  8 Aug 2022 16:07:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242998AbiHHOHC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 8 Aug 2022 10:07:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239759AbiHHOHB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 8 Aug 2022 10:07:01 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61B3F2642
        for <bpf@vger.kernel.org>; Mon,  8 Aug 2022 07:06:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D64F4B80EB3
        for <bpf@vger.kernel.org>; Mon,  8 Aug 2022 14:06:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FBB0C433C1;
        Mon,  8 Aug 2022 14:06:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659967615;
        bh=cSfO4v2Sox9eJhNIOMkAE4BFje8u0zzDJzsPjE0zzgg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dR7m8buc8u0l5G0PFsLvqF8ZQGFQqOjUZ6bplfcRJ6GHlGjl6Zc4HKYLKY3IrtGua
         Yr6FqjyVFC4FJR6eQQy0OijELzpbXm7LaKHOG/z1ed3tRBickjqTL6vFioHh0K2HlS
         7W4PJGHtIkxrTrgzYC6K6UE4rq+gPIalOs4jmfe7ow+wxBOOG1OrndIwqMu0NRSfeM
         7zvxQyj85Z3KE4iTD22MoGgDZEy5WplJJ6qT0zBYYS/3lDuKzELDxnwEucVUnhAv1w
         C3M0tvH87MGqrm2QJ0URWALsy3yx/f7zYhxCwv+6466ea63CmGMtUanO/pMcB4iwKr
         HQjLz70MhtF9w==
From:   Jiri Olsa <jolsa@kernel.org>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>
Subject: [RFC PATCH bpf-next 02/17] bpf: Replace bpf_tramp_links with bpf_tramp_progs
Date:   Mon,  8 Aug 2022 16:06:11 +0200
Message-Id: <20220808140626.422731-3-jolsa@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220808140626.422731-1-jolsa@kernel.org>
References: <20220808140626.422731-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This is first part of replacing link based program storage
in trampoline with array of programs.

Changing bpf_trampoline_get_progs to return bpf_tramp_progs
instead of bpf_tramp_links and use this object all the way down
from bpf_trampoline_update to arch jit generation.

TODO now that we have ARM trampoline support we also need to
change that one the same way.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 arch/x86/net/bpf_jit_comp.c    | 38 +++++++++++++++---------------
 include/linux/bpf.h            | 16 +++++++++----
 kernel/bpf/bpf_struct_ops.c    | 18 +++++++--------
 kernel/bpf/trampoline.c        | 42 +++++++++++++++++++---------------
 net/bpf/bpf_dummy_struct_ops.c | 10 ++++----
 5 files changed, 67 insertions(+), 57 deletions(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index c1f6c1c51d99..05c01b007bae 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -1782,7 +1782,7 @@ static void restore_regs(const struct btf_func_model *m, u8 **prog, int nr_args,
 }
 
 static int invoke_bpf_prog(const struct btf_func_model *m, u8 **pprog,
-			   struct bpf_tramp_link *l, int stack_size,
+			   struct bpf_tramp_prog *tp, int stack_size,
 			   int run_ctx_off, bool save_ret)
 {
 	void (*exit)(struct bpf_prog *prog, u64 start,
@@ -1792,8 +1792,8 @@ static int invoke_bpf_prog(const struct btf_func_model *m, u8 **pprog,
 	u8 *prog = *pprog;
 	u8 *jmp_insn;
 	int ctx_cookie_off = offsetof(struct bpf_tramp_run_ctx, bpf_cookie);
-	struct bpf_prog *p = l->link.prog;
-	u64 cookie = l->cookie;
+	struct bpf_prog *p = tp->prog;
+	u64 cookie = tp->cookie;
 
 	/* mov rdi, cookie */
 	emit_mov_imm64(&prog, BPF_REG_1, (long) cookie >> 32, (u32) (long) cookie);
@@ -1899,14 +1899,14 @@ static int emit_cond_near_jump(u8 **pprog, void *func, void *ip, u8 jmp_cond)
 }
 
 static int invoke_bpf(const struct btf_func_model *m, u8 **pprog,
-		      struct bpf_tramp_links *tl, int stack_size,
+		      struct bpf_tramp_progs *tp, int stack_size,
 		      int run_ctx_off, bool save_ret)
 {
 	int i;
 	u8 *prog = *pprog;
 
-	for (i = 0; i < tl->nr_links; i++) {
-		if (invoke_bpf_prog(m, &prog, tl->links[i], stack_size,
+	for (i = 0; i < tp->nr_progs; i++) {
+		if (invoke_bpf_prog(m, &prog, &tp->progs[i], stack_size,
 				    run_ctx_off, save_ret))
 			return -EINVAL;
 	}
@@ -1915,7 +1915,7 @@ static int invoke_bpf(const struct btf_func_model *m, u8 **pprog,
 }
 
 static int invoke_bpf_mod_ret(const struct btf_func_model *m, u8 **pprog,
-			      struct bpf_tramp_links *tl, int stack_size,
+			      struct bpf_tramp_progs *tp, int stack_size,
 			      int run_ctx_off, u8 **branches)
 {
 	u8 *prog = *pprog;
@@ -1926,8 +1926,8 @@ static int invoke_bpf_mod_ret(const struct btf_func_model *m, u8 **pprog,
 	 */
 	emit_mov_imm32(&prog, false, BPF_REG_0, 0);
 	emit_stx(&prog, BPF_DW, BPF_REG_FP, BPF_REG_0, -8);
-	for (i = 0; i < tl->nr_links; i++) {
-		if (invoke_bpf_prog(m, &prog, tl->links[i], stack_size, run_ctx_off, true))
+	for (i = 0; i < tp->nr_progs; i++) {
+		if (invoke_bpf_prog(m, &prog, &tp->progs[i], stack_size, run_ctx_off, true))
 			return -EINVAL;
 
 		/* mod_ret prog stored return value into [rbp - 8]. Emit:
@@ -2012,14 +2012,14 @@ static int invoke_bpf_mod_ret(const struct btf_func_model *m, u8 **pprog,
  */
 int arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *image, void *image_end,
 				const struct btf_func_model *m, u32 flags,
-				struct bpf_tramp_links *tlinks,
+				struct bpf_tramp_progs *tprogs,
 				void *orig_call)
 {
 	int ret, i, nr_args = m->nr_args;
 	int regs_off, ip_off, args_off, stack_size = nr_args * 8, run_ctx_off;
-	struct bpf_tramp_links *fentry = &tlinks[BPF_TRAMP_FENTRY];
-	struct bpf_tramp_links *fexit = &tlinks[BPF_TRAMP_FEXIT];
-	struct bpf_tramp_links *fmod_ret = &tlinks[BPF_TRAMP_MODIFY_RETURN];
+	struct bpf_tramp_progs *fentry = &tprogs[BPF_TRAMP_FENTRY];
+	struct bpf_tramp_progs *fexit = &tprogs[BPF_TRAMP_FEXIT];
+	struct bpf_tramp_progs *fmod_ret = &tprogs[BPF_TRAMP_MODIFY_RETURN];
 	u8 **branches = NULL;
 	u8 *prog;
 	bool save_ret;
@@ -2112,13 +2112,13 @@ int arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *image, void *i
 		}
 	}
 
-	if (fentry->nr_links)
+	if (fentry->nr_progs)
 		if (invoke_bpf(m, &prog, fentry, regs_off, run_ctx_off,
 			       flags & BPF_TRAMP_F_RET_FENTRY_RET))
 			return -EINVAL;
 
-	if (fmod_ret->nr_links) {
-		branches = kcalloc(fmod_ret->nr_links, sizeof(u8 *),
+	if (fmod_ret->nr_progs) {
+		branches = kcalloc(fmod_ret->nr_progs, sizeof(u8 *),
 				   GFP_KERNEL);
 		if (!branches)
 			return -ENOMEM;
@@ -2150,7 +2150,7 @@ int arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *image, void *i
 		prog += X86_PATCH_SIZE;
 	}
 
-	if (fmod_ret->nr_links) {
+	if (fmod_ret->nr_progs) {
 		/* From Intel 64 and IA-32 Architectures Optimization
 		 * Reference Manual, 3.4.1.4 Code Alignment, Assembly/Compiler
 		 * Coding Rule 11: All branch targets should be 16-byte
@@ -2160,12 +2160,12 @@ int arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *image, void *i
 		/* Update the branches saved in invoke_bpf_mod_ret with the
 		 * aligned address of do_fexit.
 		 */
-		for (i = 0; i < fmod_ret->nr_links; i++)
+		for (i = 0; i < fmod_ret->nr_progs; i++)
 			emit_cond_near_jump(&branches[i], prog, branches[i],
 					    X86_JNE);
 	}
 
-	if (fexit->nr_links)
+	if (fexit->nr_progs)
 		if (invoke_bpf(m, &prog, fexit, regs_off, run_ctx_off, false)) {
 			ret = -EINVAL;
 			goto cleanup;
diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index ed2a921094bc..80b2c17da64d 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -767,9 +767,14 @@ struct btf_func_model {
  */
 #define BPF_MAX_TRAMP_LINKS 38
 
-struct bpf_tramp_links {
-	struct bpf_tramp_link *links[BPF_MAX_TRAMP_LINKS];
-	int nr_links;
+struct bpf_tramp_prog {
+	struct bpf_prog *prog;
+	u64 cookie;
+};
+
+struct bpf_tramp_progs {
+	struct bpf_tramp_prog progs[BPF_MAX_TRAMP_LINKS];
+	int nr_progs;
 };
 
 struct bpf_tramp_run_ctx;
@@ -797,7 +802,7 @@ struct bpf_tramp_run_ctx;
 struct bpf_tramp_image;
 int arch_prepare_bpf_trampoline(struct bpf_tramp_image *tr, void *image, void *image_end,
 				const struct btf_func_model *m, u32 flags,
-				struct bpf_tramp_links *tlinks,
+				struct bpf_tramp_progs *tprogs,
 				void *orig_call);
 /* these two functions are called from generated trampoline */
 u64 notrace __bpf_prog_enter(struct bpf_prog *prog, struct bpf_tramp_run_ctx *run_ctx);
@@ -907,6 +912,7 @@ static __always_inline __nocfi unsigned int bpf_dispatcher_nop_func(
 }
 
 #ifdef CONFIG_BPF_JIT
+struct bpf_tramp_link;
 int bpf_trampoline_link_prog(struct bpf_tramp_link *link, struct bpf_trampoline *tr);
 int bpf_trampoline_unlink_prog(struct bpf_tramp_link *link, struct bpf_trampoline *tr);
 struct bpf_trampoline *bpf_trampoline_get(u64 key,
@@ -1236,7 +1242,7 @@ bool bpf_struct_ops_get(const void *kdata);
 void bpf_struct_ops_put(const void *kdata);
 int bpf_struct_ops_map_sys_lookup_elem(struct bpf_map *map, void *key,
 				       void *value);
-int bpf_struct_ops_prepare_trampoline(struct bpf_tramp_links *tlinks,
+int bpf_struct_ops_prepare_trampoline(struct bpf_tramp_progs *tprogs,
 				      struct bpf_tramp_link *link,
 				      const struct btf_func_model *model,
 				      void *image, void *image_end);
diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
index 84b2d9dba79a..d51dced406eb 100644
--- a/kernel/bpf/bpf_struct_ops.c
+++ b/kernel/bpf/bpf_struct_ops.c
@@ -332,21 +332,21 @@ const struct bpf_link_ops bpf_struct_ops_link_lops = {
 	.dealloc = bpf_struct_ops_link_dealloc,
 };
 
-int bpf_struct_ops_prepare_trampoline(struct bpf_tramp_links *tlinks,
+int bpf_struct_ops_prepare_trampoline(struct bpf_tramp_progs *tprogs,
 				      struct bpf_tramp_link *link,
 				      const struct btf_func_model *model,
 				      void *image, void *image_end)
 {
 	u32 flags;
 
-	tlinks[BPF_TRAMP_FENTRY].links[0] = link;
-	tlinks[BPF_TRAMP_FENTRY].nr_links = 1;
+	tprogs[BPF_TRAMP_FENTRY].progs[0].prog = link->link.prog;
+	tprogs[BPF_TRAMP_FENTRY].nr_progs = 1;
 	/* BPF_TRAMP_F_RET_FENTRY_RET is only used by bpf_struct_ops,
 	 * and it must be used alone.
 	 */
 	flags = model->ret_size > 0 ? BPF_TRAMP_F_RET_FENTRY_RET : 0;
 	return arch_prepare_bpf_trampoline(NULL, image, image_end,
-					   model, flags, tlinks, NULL);
+					   model, flags, tprogs, NULL);
 }
 
 static int bpf_struct_ops_map_update_elem(struct bpf_map *map, void *key,
@@ -357,7 +357,7 @@ static int bpf_struct_ops_map_update_elem(struct bpf_map *map, void *key,
 	struct bpf_struct_ops_value *uvalue, *kvalue;
 	const struct btf_member *member;
 	const struct btf_type *t = st_ops->type;
-	struct bpf_tramp_links *tlinks = NULL;
+	struct bpf_tramp_progs *tprogs = NULL;
 	void *udata, *kdata;
 	int prog_fd, err = 0;
 	void *image, *image_end;
@@ -381,8 +381,8 @@ static int bpf_struct_ops_map_update_elem(struct bpf_map *map, void *key,
 	if (uvalue->state || refcount_read(&uvalue->refcnt))
 		return -EINVAL;
 
-	tlinks = kcalloc(BPF_TRAMP_MAX, sizeof(*tlinks), GFP_KERNEL);
-	if (!tlinks)
+	tprogs = kcalloc(BPF_TRAMP_MAX, sizeof(*tprogs), GFP_KERNEL);
+	if (!tprogs)
 		return -ENOMEM;
 
 	uvalue = (struct bpf_struct_ops_value *)st_map->uvalue;
@@ -478,7 +478,7 @@ static int bpf_struct_ops_map_update_elem(struct bpf_map *map, void *key,
 			      &bpf_struct_ops_link_lops, prog);
 		st_map->links[i] = &link->link;
 
-		err = bpf_struct_ops_prepare_trampoline(tlinks, link,
+		err = bpf_struct_ops_prepare_trampoline(tprogs, link,
 							&st_ops->func_models[i],
 							image, image_end);
 		if (err < 0)
@@ -520,7 +520,7 @@ static int bpf_struct_ops_map_update_elem(struct bpf_map *map, void *key,
 	memset(uvalue, 0, map->value_size);
 	memset(kvalue, 0, map->value_size);
 unlock:
-	kfree(tlinks);
+	kfree(tprogs);
 	mutex_unlock(&st_map->lock);
 	return err;
 }
diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
index 7a65d33cda60..f41fb1af9f0e 100644
--- a/kernel/bpf/trampoline.c
+++ b/kernel/bpf/trampoline.c
@@ -269,30 +269,34 @@ static int register_fentry(struct bpf_trampoline *tr, void *new_addr)
 	return ret;
 }
 
-static struct bpf_tramp_links *
+static struct bpf_tramp_progs *
 bpf_trampoline_get_progs(const struct bpf_trampoline *tr, int *total, bool *ip_arg)
 {
+	struct bpf_tramp_progs *tprogs;
 	struct bpf_tramp_link *link;
-	struct bpf_tramp_links *tlinks;
-	struct bpf_tramp_link **links;
+	struct bpf_tramp_prog *tp;
 	int kind;
 
 	*total = 0;
-	tlinks = kcalloc(BPF_TRAMP_MAX, sizeof(*tlinks), GFP_KERNEL);
-	if (!tlinks)
+	tprogs = kcalloc(BPF_TRAMP_MAX, sizeof(*tprogs), GFP_KERNEL);
+	if (!tprogs)
 		return ERR_PTR(-ENOMEM);
 
 	for (kind = 0; kind < BPF_TRAMP_MAX; kind++) {
-		tlinks[kind].nr_links = tr->progs_cnt[kind];
+		tprogs[kind].nr_progs = tr->progs_cnt[kind];
 		*total += tr->progs_cnt[kind];
-		links = tlinks[kind].links;
+		tp = &tprogs[kind].progs[0];
 
 		hlist_for_each_entry(link, &tr->progs_hlist[kind], tramp_hlist) {
-			*ip_arg |= link->link.prog->call_get_func_ip;
-			*links++ = link;
+			struct bpf_prog *prog = link->link.prog;
+
+			*ip_arg |= prog->call_get_func_ip;
+			tp->prog = prog;
+			tp->cookie = link->cookie;
+			tp++;
 		}
 	}
-	return tlinks;
+	return tprogs;
 }
 
 static void __bpf_tramp_image_put_deferred(struct work_struct *work)
@@ -431,14 +435,14 @@ static struct bpf_tramp_image *bpf_tramp_image_alloc(u64 key, u32 idx)
 static int bpf_trampoline_update(struct bpf_trampoline *tr, bool lock_direct_mutex)
 {
 	struct bpf_tramp_image *im;
-	struct bpf_tramp_links *tlinks;
+	struct bpf_tramp_progs *tprogs;
 	u32 orig_flags = tr->flags;
 	bool ip_arg = false;
 	int err, total;
 
-	tlinks = bpf_trampoline_get_progs(tr, &total, &ip_arg);
-	if (IS_ERR(tlinks))
-		return PTR_ERR(tlinks);
+	tprogs = bpf_trampoline_get_progs(tr, &total, &ip_arg);
+	if (IS_ERR(tprogs))
+		return PTR_ERR(tprogs);
 
 	if (total == 0) {
 		err = unregister_fentry(tr, tr->cur_image->image);
@@ -457,8 +461,8 @@ static int bpf_trampoline_update(struct bpf_trampoline *tr, bool lock_direct_mut
 	/* clear all bits except SHARE_IPMODIFY */
 	tr->flags &= BPF_TRAMP_F_SHARE_IPMODIFY;
 
-	if (tlinks[BPF_TRAMP_FEXIT].nr_links ||
-	    tlinks[BPF_TRAMP_MODIFY_RETURN].nr_links) {
+	if (tprogs[BPF_TRAMP_FEXIT].nr_progs ||
+	    tprogs[BPF_TRAMP_MODIFY_RETURN].nr_progs) {
 		/* NOTE: BPF_TRAMP_F_RESTORE_REGS and BPF_TRAMP_F_SKIP_FRAME
 		 * should not be set together.
 		 */
@@ -478,7 +482,7 @@ static int bpf_trampoline_update(struct bpf_trampoline *tr, bool lock_direct_mut
 #endif
 
 	err = arch_prepare_bpf_trampoline(im, im->image, im->image + PAGE_SIZE,
-					  &tr->func.model, tr->flags, tlinks,
+					  &tr->func.model, tr->flags, tprogs,
 					  tr->func.addr);
 	if (err < 0)
 		goto out;
@@ -515,7 +519,7 @@ static int bpf_trampoline_update(struct bpf_trampoline *tr, bool lock_direct_mut
 	/* If any error happens, restore previous flags */
 	if (err)
 		tr->flags = orig_flags;
-	kfree(tlinks);
+	kfree(tprogs);
 	return err;
 }
 
@@ -983,7 +987,7 @@ void notrace __bpf_tramp_exit(struct bpf_tramp_image *tr)
 int __weak
 arch_prepare_bpf_trampoline(struct bpf_tramp_image *tr, void *image, void *image_end,
 			    const struct btf_func_model *m, u32 flags,
-			    struct bpf_tramp_links *tlinks,
+			    struct bpf_tramp_progs *tprogs,
 			    void *orig_call)
 {
 	return -ENOTSUPP;
diff --git a/net/bpf/bpf_dummy_struct_ops.c b/net/bpf/bpf_dummy_struct_ops.c
index e78dadfc5829..17add0bdf323 100644
--- a/net/bpf/bpf_dummy_struct_ops.c
+++ b/net/bpf/bpf_dummy_struct_ops.c
@@ -80,7 +80,7 @@ int bpf_struct_ops_test_run(struct bpf_prog *prog, const union bpf_attr *kattr,
 	const struct bpf_struct_ops *st_ops = &bpf_bpf_dummy_ops;
 	const struct btf_type *func_proto;
 	struct bpf_dummy_ops_test_args *args;
-	struct bpf_tramp_links *tlinks;
+	struct bpf_tramp_progs *tprogs;
 	struct bpf_tramp_link *link = NULL;
 	void *image = NULL;
 	unsigned int op_idx;
@@ -95,8 +95,8 @@ int bpf_struct_ops_test_run(struct bpf_prog *prog, const union bpf_attr *kattr,
 	if (IS_ERR(args))
 		return PTR_ERR(args);
 
-	tlinks = kcalloc(BPF_TRAMP_MAX, sizeof(*tlinks), GFP_KERNEL);
-	if (!tlinks) {
+	tprogs = kcalloc(BPF_TRAMP_MAX, sizeof(*tprogs), GFP_KERNEL);
+	if (!tprogs) {
 		err = -ENOMEM;
 		goto out;
 	}
@@ -118,7 +118,7 @@ int bpf_struct_ops_test_run(struct bpf_prog *prog, const union bpf_attr *kattr,
 	bpf_link_init(&link->link, BPF_LINK_TYPE_STRUCT_OPS, &bpf_struct_ops_link_lops, prog);
 
 	op_idx = prog->expected_attach_type;
-	err = bpf_struct_ops_prepare_trampoline(tlinks, link,
+	err = bpf_struct_ops_prepare_trampoline(tprogs, link,
 						&st_ops->func_models[op_idx],
 						image, image + PAGE_SIZE);
 	if (err < 0)
@@ -138,7 +138,7 @@ int bpf_struct_ops_test_run(struct bpf_prog *prog, const union bpf_attr *kattr,
 	bpf_jit_free_exec(image);
 	if (link)
 		bpf_link_put(&link->link);
-	kfree(tlinks);
+	kfree(tprogs);
 	return err;
 }
 
-- 
2.37.1

