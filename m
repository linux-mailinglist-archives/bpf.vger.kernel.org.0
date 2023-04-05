Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C01D16D7193
	for <lists+bpf@lfdr.de>; Wed,  5 Apr 2023 02:43:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236694AbjDEAnB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 4 Apr 2023 20:43:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236696AbjDEAnA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 4 Apr 2023 20:43:00 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C336469C
        for <bpf@vger.kernel.org>; Tue,  4 Apr 2023 17:42:49 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id v1so34546091wrv.1
        for <bpf@vger.kernel.org>; Tue, 04 Apr 2023 17:42:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680655368;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hIwcmJJLvUHzc+15u9i6IUYiBurkRNKHwn7vcP2ZAhg=;
        b=jd4dqrPHGCnWE1QV6dGG5ZP+QM6RWao1OKXqnmzKMn0UrUA29jkP5/9jI1jChMkeGE
         BvHsZJqwb5yZyBQac7F80WpUBvFEKm5putdRZIlQDQ7OJirDS7lVL13fq8KyLfBA1ALM
         x4Ra+CrhNEXVgFroeg8AYRfxU+az9MwCKpNmZPOmrRNd+Y7HdOFLpCJFlc5nsNJwKh2Z
         M4he2nZwDWoau4xe9sUjGO+K4lPZ3P9uD+nLFHJYF0MKy1fGhlbXW/Sd8z1+JeQyaanR
         3r5Nq+RGiuSNsMX08aISeISQvYIwv9cH6VLqBAi3PRjjjGRcILP/mRDD39ebaJocOaw9
         X8hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680655368;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hIwcmJJLvUHzc+15u9i6IUYiBurkRNKHwn7vcP2ZAhg=;
        b=pZMbwq2JQa19hXVrvGFggGzaUOwhCBUZR4LDgqWI16y8HAI3eLw3r1MPz/P26sNPs5
         sHUtruuofoD3cJz+fjLnakH3zwPz/y2GKAFZUzkzFGvqxeOaG1PhXb7NOiEhJ8oKTNzh
         5vYqwktJRLPQD2aD3x4SXEELugcCZNwWEDN4/KN+PzOp+VbWsc83KYii0hCyJx+8UbDW
         MQ6DBL94ExritH3UGWHTFrtQSOUeOO0g94NQTFX0IeoSv4VdXLs/4mbhXLqxZUXWIGvQ
         EIqfh4fcrKJP1ao62CwDurruPIhZZHTMytbdNC6oBG4yGhG990NJpNGlcbbpT649Qu+2
         cWwA==
X-Gm-Message-State: AAQBX9f7FaHNzwo470ie8dJF5SrFKEpe9w1syo5eO5egOXX8+6xAWL8m
        /crhtEtMlBqxscR8AGjJmG7SY+j5IsVetg==
X-Google-Smtp-Source: AKy350YIuzZIl4hvelnFAQ4g1EtjDHc8yRW4b8dJDVDmqXaxyRpm3KA+ssD2fiQil/ACDxOFRMYkoA==
X-Received: by 2002:a5d:58c9:0:b0:2e8:9db2:d294 with SMTP id o9-20020a5d58c9000000b002e89db2d294mr556044wrf.26.1680655367656;
        Tue, 04 Apr 2023 17:42:47 -0700 (PDT)
Received: from localhost ([2a02:1210:74a0:3200:2fc:d4f0:c121:5e8b])
        by smtp.gmail.com with ESMTPSA id t17-20020adff611000000b002c5a790e959sm13505812wrp.19.2023.04.04.17.42.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Apr 2023 17:42:47 -0700 (PDT)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        David Vernet <void@manifault.com>
Subject: [PATCH RFC bpf-next v1 4/9] bpf: Handle throwing BPF callbacks in helpers and kfuncs
Date:   Wed,  5 Apr 2023 02:42:34 +0200
Message-Id: <20230405004239.1375399-5-memxor@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230405004239.1375399-1-memxor@gmail.com>
References: <20230405004239.1375399-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=13063; i=memxor@gmail.com; h=from:subject; bh=SJU/B5euGdj1/qxvpdL4muFNBUIxeOuvS82h9ya+ZSM=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBkLMPvRJ0hp8F8rvYuW3hVPrh/+x63Ayh933qDl /m7Mktk1eCJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZCzD7wAKCRBM4MiGSL8R ynMdD/9Ib9h8rEpR24lr9oOBQ97PcjyFuD1mHAE3KoV0rT6y2rl+plI/G8kZ6/ksjQmkhpgPspe EFcsjvXEV5GG9dV7TXo4BpLaR5FQkax/OzPcRULHIrMJatuWy6T3y/ehAiD7lS7NUXnYbhMynEd h2tQpMpGeaMV3scfkbRCHIDmL3OoTOPH1A8jngR9ntEOsLPPBAHC/4m7kqJSw+vIqd5YJdDECHD 1fta99AXjBPK6PjcQ9QnUEp1K2ZHA1OFZXjm5qzYUWs+J1SWjUR6a4f+2Ia30fELBl4anG2eqgq D3AwKerX8Wn52LHHhk/R5izGy5awOhNDN7IBGJUPusQKY1dT92rol4OVhXxBhb90yz9/Tp03O5x mjO/H38U5oPm7YPagKib68/53eXcIzTJumqeS9TqGCC4Dx5zHVh0mEeg1Ue6kLW6xxtScboQhP1 xXRRrChtts5R/Oey6jp4y1HSxTogzc84hmI5UaypBYxg876joD4mEsbTWvK1yQhRe7zqa8YGW7A iBZaPeNu8VCPztS1QrsgxSn8Hwfd4HzUgrDTLVaOOvfHRQZ3wuL1s6jWpS6ZfEk2nzIFTXxLdzu vp+nW0cjGfqzHnRp/bW7qwDaY9zgJiSf5OQ9+bsnUGKxQrN9XbrHnCeVCkvqSq+pECpA22SbV1h X6OXsokg0ihZD3Q==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Enable handling of callbacks that throw within helpers and kfuncs taking
them. The problem with helpers is that exception state can be
manipulated by a tracing program which is invoked between the checking
of exception after calling callback and returning back to the program.
Hence, helpers always return -EJUKEBOX whenever they detect an
exception. Only 1 kfunc takes a callback (bpf_rbtree_add), so it is
updated to be notrace to avoid this pitfall.

This allows us to use bpf_get_exception to detect the thrown case, and
in case we miss exception event we use return code to unwind.

TODO: It might be possible to simply check return code in case of
helpers or kfuncs taking callbacks and check_helper_ret_code = true, and
not bother with exception state. This should lead to less code being
generated per-callsite. For all other cases, we can rely on
bpf_get_exception, and ensure that helper/kfunc uses notrace to avoid
invocation of tracing programs that clobber exception state on return
path. But make this change in v2 after ensuring current->bpf_exception_thrown
approach is acceptable.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 include/linux/bpf_verifier.h |   1 +
 kernel/bpf/arraymap.c        |   4 +-
 kernel/bpf/bpf_iter.c        |   2 +
 kernel/bpf/hashtab.c         |   4 +-
 kernel/bpf/helpers.c         |  18 +++--
 kernel/bpf/ringbuf.c         |   4 ++
 kernel/bpf/task_iter.c       |   2 +
 kernel/bpf/verifier.c        | 129 +++++++++++++++++++++++++++++++++++
 8 files changed, 156 insertions(+), 8 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index bc067223d3ee..a5346a2b7e68 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -485,6 +485,7 @@ struct bpf_insn_aux_data {
 	bool zext_dst; /* this insn zero extends dst reg */
 	bool storage_get_func_atomic; /* bpf_*_storage_get() with atomic memory alloc */
 	bool is_iter_next; /* bpf_iter_<type>_next() kfunc call */
+	bool skip_patch_call_imm; /* Skip patch_call_imm phase in do_misc_fixups */
 	u8 alu_state; /* used in combination with alu_limit */
 
 	/* below fields are initialized once */
diff --git a/kernel/bpf/arraymap.c b/kernel/bpf/arraymap.c
index de0eadf8706f..6c0c5e726ebf 100644
--- a/kernel/bpf/arraymap.c
+++ b/kernel/bpf/arraymap.c
@@ -711,6 +711,8 @@ static long bpf_for_each_array_elem(struct bpf_map *map, bpf_callback_t callback
 		key = i;
 		ret = callback_fn((u64)(long)map, (u64)(long)&key,
 				  (u64)(long)val, (u64)(long)callback_ctx, 0);
+		if (bpf_get_exception())
+			ret = -EJUKEBOX;
 		/* return value: 0 - continue, 1 - stop and return */
 		if (ret)
 			break;
@@ -718,7 +720,7 @@ static long bpf_for_each_array_elem(struct bpf_map *map, bpf_callback_t callback
 
 	if (is_percpu)
 		migrate_enable();
-	return num_elems;
+	return ret == -EJUKEBOX ? ret : num_elems;
 }
 
 static u64 array_map_mem_usage(const struct bpf_map *map)
diff --git a/kernel/bpf/bpf_iter.c b/kernel/bpf/bpf_iter.c
index 96856f130cbf..6e4e4b6213f8 100644
--- a/kernel/bpf/bpf_iter.c
+++ b/kernel/bpf/bpf_iter.c
@@ -759,6 +759,8 @@ BPF_CALL_4(bpf_loop, u32, nr_loops, void *, callback_fn, void *, callback_ctx,
 
 	for (i = 0; i < nr_loops; i++) {
 		ret = callback((u64)i, (u64)(long)callback_ctx, 0, 0, 0);
+		if (bpf_get_exception())
+			return -EJUKEBOX;
 		/* return value: 0 - continue, 1 - stop and return */
 		if (ret)
 			return i + 1;
diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
index 00c253b84bf5..5e70151e0414 100644
--- a/kernel/bpf/hashtab.c
+++ b/kernel/bpf/hashtab.c
@@ -2178,6 +2178,8 @@ static long bpf_for_each_hash_elem(struct bpf_map *map, bpf_callback_t callback_
 			num_elems++;
 			ret = callback_fn((u64)(long)map, (u64)(long)key,
 					  (u64)(long)val, (u64)(long)callback_ctx, 0);
+			if (bpf_get_exception())
+				ret = -EJUKEBOX;
 			/* return value: 0 - continue, 1 - stop and return */
 			if (ret) {
 				rcu_read_unlock();
@@ -2189,7 +2191,7 @@ static long bpf_for_each_hash_elem(struct bpf_map *map, bpf_callback_t callback_
 out:
 	if (is_percpu)
 		migrate_enable();
-	return num_elems;
+	return ret == -EJUKEBOX ? ret : num_elems;
 }
 
 static u64 htab_map_mem_usage(const struct bpf_map *map)
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 89e70907257c..82db3a64fa3f 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -1982,10 +1982,11 @@ __bpf_kfunc struct bpf_rb_node *bpf_rbtree_remove(struct bpf_rb_root *root,
 }
 
 /* Need to copy rbtree_add_cached's logic here because our 'less' is a BPF
- * program
+ * program.
+ * Marked notrace to avoid clobbering of exception state in current by BPF
+ * programs.
  */
-static void __bpf_rbtree_add(struct bpf_rb_root *root, struct bpf_rb_node *node,
-			     void *less)
+static notrace void __bpf_rbtree_add(struct bpf_rb_root *root, struct bpf_rb_node *node, void *less)
 {
 	struct rb_node **link = &((struct rb_root_cached *)root)->rb_root.rb_node;
 	bpf_callback_t cb = (bpf_callback_t)less;
@@ -1993,8 +1994,13 @@ static void __bpf_rbtree_add(struct bpf_rb_root *root, struct bpf_rb_node *node,
 	bool leftmost = true;
 
 	while (*link) {
+		u64 cb_res;
+
 		parent = *link;
-		if (cb((uintptr_t)node, (uintptr_t)parent, 0, 0, 0)) {
+		cb_res = cb((uintptr_t)node, (uintptr_t)parent, 0, 0, 0);
+		if (bpf_get_exception())
+			return;
+		if (cb_res) {
 			link = &parent->rb_left;
 		} else {
 			link = &parent->rb_right;
@@ -2007,8 +2013,8 @@ static void __bpf_rbtree_add(struct bpf_rb_root *root, struct bpf_rb_node *node,
 			       (struct rb_root_cached *)root, leftmost);
 }
 
-__bpf_kfunc void bpf_rbtree_add(struct bpf_rb_root *root, struct bpf_rb_node *node,
-				bool (less)(struct bpf_rb_node *a, const struct bpf_rb_node *b))
+__bpf_kfunc notrace void bpf_rbtree_add(struct bpf_rb_root *root, struct bpf_rb_node *node,
+					bool (less)(struct bpf_rb_node *a, const struct bpf_rb_node *b))
 {
 	__bpf_rbtree_add(root, node, (void *)less);
 }
diff --git a/kernel/bpf/ringbuf.c b/kernel/bpf/ringbuf.c
index 875ac9b698d9..7f6764ae4fff 100644
--- a/kernel/bpf/ringbuf.c
+++ b/kernel/bpf/ringbuf.c
@@ -766,6 +766,10 @@ BPF_CALL_4(bpf_user_ringbuf_drain, struct bpf_map *, map,
 
 		bpf_dynptr_init(&dynptr, sample, BPF_DYNPTR_TYPE_LOCAL, 0, size);
 		ret = callback((uintptr_t)&dynptr, (uintptr_t)callback_ctx, 0, 0, 0);
+		if (bpf_get_exception()) {
+			ret = -EJUKEBOX;
+			goto schedule_work_return;
+		}
 		__bpf_user_ringbuf_sample_release(rb, size, flags);
 	}
 	ret = samples - discarded_samples;
diff --git a/kernel/bpf/task_iter.c b/kernel/bpf/task_iter.c
index c4ab9d6cdbe9..6e8667f03784 100644
--- a/kernel/bpf/task_iter.c
+++ b/kernel/bpf/task_iter.c
@@ -807,6 +807,8 @@ BPF_CALL_5(bpf_find_vma, struct task_struct *, task, u64, start,
 		callback_fn((u64)(long)task, (u64)(long)vma,
 			    (u64)(long)callback_ctx, 0, 0);
 		ret = 0;
+		if (bpf_get_exception())
+			ret = -EJUKEBOX;
 	}
 	bpf_mmap_unlock_mm(work, mm);
 	return ret;
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 6981d8817c71..07d808b05044 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -9053,6 +9053,24 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
 		}
 	}
 
+	/* For each helper call which invokes a callback which may throw, it
+	 * will propagate the thrown exception to us. For helpers, we check the
+	 * return code in addition to exception state, as it may be reset
+	 * between detection and return within kernel. Note that we don't
+	 * include async callbacks (passed to bpf_timer_set_callback) because
+	 * exceptions won't be propagated.
+	 */
+	if (is_callback_calling_function(meta.func_id) &&
+	    meta.func_id != BPF_FUNC_timer_set_callback) {
+		struct bpf_throw_state *ts = &env->insn_aux_data[insn_idx].throw_state;
+		/* Check for -EJUKEBOX in case exception state is clobbered by
+		 * some other program executing between bpf_get_exception and
+		 * return from helper.
+		 */
+		if (base_type(fn->ret_type) == RET_INTEGER)
+			ts->check_helper_ret_code = true;
+	}
+
 	switch (func_id) {
 	case BPF_FUNC_tail_call:
 		err = check_reference_leak(env, false);
@@ -17691,6 +17709,9 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
 			continue;
 		}
 
+		if (env->insn_aux_data[i + delta].skip_patch_call_imm)
+			continue;
+
 		if (insn->imm == BPF_FUNC_get_route_realm)
 			prog->dst_needed = 1;
 		if (insn->imm == BPF_FUNC_get_prandom_u32)
@@ -18177,6 +18198,94 @@ static bool is_bpf_throw_call(struct bpf_insn *insn)
 	       insn->off == 0 && insn->imm == special_kfunc_list[KF_bpf_throw];
 }
 
+static struct bpf_prog *rewrite_bpf_call(struct bpf_verifier_env *env,
+					 int position,
+					 s32 stack_base,
+					 struct bpf_throw_state *tstate,
+					 u32 *cnt)
+{
+	s32 r0_offset = stack_base + 0 * BPF_REG_SIZE;
+	struct bpf_insn_aux_data *aux_data;
+	struct bpf_insn insn_buf[] = {
+		env->prog->insnsi[position],
+		BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_0, r0_offset),
+		BPF_EMIT_CALL(bpf_get_exception),
+		BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 3),
+		BPF_MOV64_IMM(BPF_REG_0, 0),
+		BPF_MOV64_IMM(BPF_REG_0, 0),
+		BPF_EXIT_INSN(),
+		BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_10, r0_offset),
+		BPF_JMP32_IMM(BPF_JNE, BPF_REG_0, -EJUKEBOX, 3),
+		BPF_MOV64_IMM(BPF_REG_0, 0),
+		BPF_MOV64_IMM(BPF_REG_0, 0),
+		BPF_EXIT_INSN(),
+	};
+	struct bpf_prog *new_prog;
+	int type, tsubprog = -1;
+	u32 callback_start;
+	u32 call_insn_offset;
+	s32 callback_offset;
+	bool ret_code;
+
+	type = tstate->type;
+	ret_code = tstate->check_helper_ret_code;
+	if (type == BPF_THROW_OUTER)
+		insn_buf[4] = insn_buf[9] = BPF_EMIT_CALL(bpf_reset_exception);
+	if (type == BPF_THROW_INNER)
+		insn_buf[9] = BPF_EMIT_CALL(bpf_throw);
+
+	/* We need to fix offset of the pseudo call after patching.
+	 * Note: The actual call instruction is at insn_buf[0]
+	 */
+	if (bpf_pseudo_call(&insn_buf[0])) {
+		tsubprog = find_subprog(env, position + insn_buf[0].imm + 1);
+		if (WARN_ON_ONCE(tsubprog < 0))
+			return NULL;
+	}
+	/* For helpers, the code path between checking bpf_get_exception and
+	 * returning may involve invocation of tracing progs which reset
+	 * exception state, so also use the return value to invoke exception
+	 * path. Otherwise, exception event from callback is lost.
+	 */
+	if (ret_code)
+		*cnt = ARRAY_SIZE(insn_buf);
+	else
+		*cnt = ARRAY_SIZE(insn_buf) - 4;
+	new_prog = bpf_patch_insn_data(env, position, insn_buf, *cnt);
+	if (!new_prog)
+		return new_prog;
+
+	/* Note: The actual call instruction is at insn_buf[0] */
+	if (bpf_pseudo_call(&insn_buf[0])) {
+		callback_start = env->subprog_info[tsubprog].start;
+		call_insn_offset = position + 0;
+		callback_offset = callback_start - call_insn_offset - 1;
+		new_prog->insnsi[call_insn_offset].imm = callback_offset;
+	}
+
+	aux_data = env->insn_aux_data;
+	/* Note: We already patched in call at insn_buf[2], insn_buf[9]. */
+	aux_data[position + 2].skip_patch_call_imm = true;
+	if (ret_code)
+		aux_data[position + 9].skip_patch_call_imm = true;
+	/* Note: For BPF_THROW_OUTER, we already patched in call at insn_buf[4] */
+	if (type == BPF_THROW_OUTER)
+		aux_data[position + 4].skip_patch_call_imm = true;
+	return new_prog;
+}
+
+static bool is_throwing_bpf_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
+				 struct bpf_insn_aux_data *insn_aux)
+{
+	if (insn->code != (BPF_JMP | BPF_CALL))
+		return false;
+	if (insn->src_reg == BPF_PSEUDO_CALL ||
+	    insn->src_reg == BPF_PSEUDO_KFUNC_CALL ||
+	    insn->src_reg == 0)
+		return insn_aux->throw_state.type != BPF_THROW_NONE;
+	return false;
+}
+
 /* For all sub-programs in the program (including main) check
  * insn_aux_data to see if there are any instructions that need to be
  * transformed into an instruction sequence. E.g. bpf_loop calls that
@@ -18228,6 +18337,26 @@ static int do_misc_rewrites(struct bpf_verifier_env *env)
 			new_prog = rewrite_bpf_throw_call(env, i + delta, throw_state, &cnt);
 			if (!new_prog)
 				return -ENOMEM;
+		} else if (is_throwing_bpf_call(env, insn, insn_aux)) {
+			struct bpf_throw_state *throw_state = &insn_aux->throw_state;
+
+			stack_depth_extra = max_t(u16, stack_depth_extra,
+						  BPF_REG_SIZE * 1 + stack_depth_roundup);
+
+			/* The verifier was able to prove that the throwing call
+			 * was unreachable, hence it must have not been seen and
+			 * will be removed by opt_remove_dead_code.
+			 */
+			if (throw_state->type == BPF_THROW_NONE) {
+				WARN_ON_ONCE(insn_aux->seen);
+				goto skip;
+			}
+
+			new_prog = rewrite_bpf_call(env, i + delta,
+						    -(stack_depth + stack_depth_extra),
+						    throw_state, &cnt);
+			if (!new_prog)
+				return -ENOMEM;
 		}
 
 skip:
-- 
2.40.0

