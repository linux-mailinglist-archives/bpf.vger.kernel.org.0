Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AB986D7190
	for <lists+bpf@lfdr.de>; Wed,  5 Apr 2023 02:42:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236688AbjDEAm5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 4 Apr 2023 20:42:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236686AbjDEAm4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 4 Apr 2023 20:42:56 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35FC03C19
        for <bpf@vger.kernel.org>; Tue,  4 Apr 2023 17:42:48 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id v14-20020a05600c470e00b003f06520825fso116292wmo.0
        for <bpf@vger.kernel.org>; Tue, 04 Apr 2023 17:42:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680655366;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=teGUJf4XiPYWvFzv+TLHkUZ2Ii4ceIWfrI+kO8mPC0Y=;
        b=XmlB5C5uZ0RlC3WKYVsCWqatA0yLF+kSrhuoX+YyWKFN28KNGhkxs/zGhXPvgKR/m1
         EfPFkvzGIEjMC6xFJQdtMdVmUeLSzgS7b35Lmz6lMH4CkO4qZt/UmmR4YYWpklOjPScH
         sIVjrw0Dk+3hZd6Z2+uFNxG+sk802JeRuJBoiv8Iso+Q8rbKeTfzix/zamFNt4FZ4FQw
         I59FjtftIKxJJh66AAReClP/b5mAiwgJNpMEYwnrU7lQ5X/voD3R7UN6c08jADPKx4Wc
         c9LfgUHMOZ3peb+/s+y7ICSPpErKtrAighRPkhQFEwqSnnUSDW6gO8geEi31/7bcBT9C
         KeUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680655366;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=teGUJf4XiPYWvFzv+TLHkUZ2Ii4ceIWfrI+kO8mPC0Y=;
        b=MvwGlqckWN3zYjMRlqYKV8P0HITbTqtW1tARzs3ShSY2OI1hPDWjfcASlsD4ifbdNx
         JhZgc/97Q91+bNJ2N62bLTlRwkUwD9W9iuaIz+CY75sdRSua6mYWM98R4DFYkmpI7Uns
         FQw7a3u5LP1Jr3NsmV7jc8VS/q/9y7xZKb5AmuEieHkp/zw7Y2c9kVXk2T5+oeLUCioG
         ki1WjmfJYwxOVWUEP4hcaATTtMwsiV5RmWGCiDGDI3eCZ/EAGiFomyI6IhvS4S85+lxd
         nLMgV3R+ujOgjExczp71kp3YDixnOK75dKUXodhzExYyspAD3JH9Qxd38QJpZg/VlHoZ
         Tnrw==
X-Gm-Message-State: AAQBX9fpT5zifmhrtad3ytn41X5PQs4L3lg9bwjiSv+w6ZKYdCA7qJdX
        EiqO9yv1P+RlsXO1Z2CGCCQeamwn6x1LIg==
X-Google-Smtp-Source: AKy350a3CJ+urjRn8BWXkUOvnHOeR5w8xHHhzSFn3tIXFNWHj/QLlgOnlJMdubhPW4oWBE6I6DXFxQ==
X-Received: by 2002:a7b:c415:0:b0:3ed:c84c:7efe with SMTP id k21-20020a7bc415000000b003edc84c7efemr595650wmi.7.1680655365941;
        Tue, 04 Apr 2023 17:42:45 -0700 (PDT)
Received: from localhost ([2a02:1210:74a0:3200:2fc:d4f0:c121:5e8b])
        by smtp.gmail.com with ESMTPSA id m30-20020a05600c3b1e00b003ef5deb4188sm439927wms.17.2023.04.04.17.42.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Apr 2023 17:42:45 -0700 (PDT)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        David Vernet <void@manifault.com>
Subject: [PATCH RFC bpf-next v1 3/9] bpf: Implement bpf_throw kfunc
Date:   Wed,  5 Apr 2023 02:42:33 +0200
Message-Id: <20230405004239.1375399-4-memxor@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230405004239.1375399-1-memxor@gmail.com>
References: <20230405004239.1375399-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=27567; i=memxor@gmail.com; h=from:subject; bh=StpVKABle4Ovro+eQlE8xC6lViXNR11jiYWOx1VBboA=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBkLMPveF8p06L8Rt/BKCFa2mQY/0oz3iiiI7r94 iMF/7GERzOJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZCzD7wAKCRBM4MiGSL8R ypr5D/0fHpNjYDit+z3oBp+IaXG9QjVwjfKWHoraq6DfdJyJofGfjedNB/LDVwUTdLQg2tM3Y6m 4polZTeE+gHUsMO5ZBgT07UGUbTlsGaBFzkaNcpmOKXVJ2evhc1En0a1VLrQ0TazLu9NJnieSov uq3ynG1Wi8XkfBUZo2yQMAxAys8r/9WdMKJwZLQEMkeDXUs077CVTi4NfqVmzXLJMtUXwq0O7Sw Ax7Tf8eURFUL7dshlmsmL4XCCn2924vPL32tIMrEh5VZn+R6qFrk7pw+HuS+1qCBcNOPAd2fYHs goILsZfzZ4DYvU8TWc9g2LnMhgW2+Uae/qkfBh2n2rNMeLWX0NBcGWtpSt81O2Dpch1C8pXtbB+ v3lvtLLf1aa97p7bWqc32BE+nNrwqPNqtzRzSRT7qHgpZnbpM4Zsc+lhe2BS2X6PAYMbgYni8gy PqtoclqBzMLIprljP7bWkzvlaKtKAMDfQmnPBYqmJGL9EXw/5OB4oc/e6yJrDpZiBD+kQfCYRhh 6iV3uI2mcOcozxQymigk4JGYGRuoAsj1mhHiPNtviNQ1f+iKYz1QNc5avS5SvdewnVMlObYvDpo 9M50KkOdzgB7L7hRzOUwcvhiuCEJF9mrKLYfjbz0ZGGWkJk6rUyTmdGH43S86b8rrZTIjYj+XEO u4K6m3WJHkBYFyw==
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

Introduce the support for exceptions in BPF runtime. The bpf_throw kfunc
is the main helper to be used by programs to throw an exception. In the
verifier domain, it will be processed as an immediate main exit for the
program, ending exploration of that path.

This proves to be a powerful property: a program can perform a condition
check and call bpf_throw for the case that will never occur at runtime,
but it's still something it needs to prove to the verifier. The
unwinding of the program stack and any resources will automatically be
performed by the BPF runtime.

For now, we fail if we see lingering references, locks, etc., but a
future patch will extend the current infrastructure to generate the
cleanup code for those too.

Programs that do not use exceptions today have no change in their .text
and performance, as all extra code generated to throw, propagate, unwind
the stack, etc. only applies to programs that use this new facility.

- The exception state is represented using four booleans in the
  task_struct of current task. Each boolean corresponds to the exception
  state for each kernel context. This allows BPF programs to be
  interrupted and still not clobber the other's exception state.
- The other vexing case is of recursion. If a program calls into another
  program (e.g. call into helper which invokes tracing program
  eventually), it may throw and clobber the current exception state. To
  avoid this, an invariant is maintained across the implementation:
	Exception state is always cleared on entry and exit of the main
	BPF program.
  This implies that if recursion occurs, the BPF program will clear the
  current exception state on entry and exit. However, callbacks do not
  do the same, because they are subprograms. The case for propagating
  exceptions of callbacks invoked by the kernel back to the BPF program
  is handled in the next commit. This is also the main reason to clear
  exception state on entry, asynchronous callbacks can clobber exception
  state even though we make sure it's always set to be 0 within the
  kernel.
  Anyhow, the only other thing to be kept in mind is to never allow a
  BPF program to execute when the program is being unwinded. This
  implies that every function involved in this path must be notrace,
  which is the case for bpf_throw, bpf_get_exception and
  bpf_reset_exception.
- Rewrites happen for bpf_throw and call instructions to subprogs.
  The instructions which are executed in the main frame of the main
  program (thus, not global functions and extension programs, which end
  up executing in frame > 0) need to be rewritten differently. This is
  tracked using BPF_THROW_OUTER vs BPF_THROW_INNER. If not done, a
  recursing tracing program may set exception state which the main
  program is instrumented to handle eventually, causing it to unwind
  when it shouldn't.
- Callsite specific marking is done. It is possible to reduce the
  instrumentation needed if we were marking callsites. Only all calls to
  global subprogs would need to be rewritten to handle thrown
  exceptions, otherwise for each callsite to static subprogs, the
  verifier's path awareness allows us to skip the handling if all
  passible paths taken using that callsite never throw. This propagates
  into all callers and prog may end up having throws_exception as false.
  Typically this reduces the amount of instrumentation when subprogs
  throwing are deeply nested and only throw under specific conditions.
- BPF_PROG_TYPE_EXT is special in that it replaces global functions in
  other BPF programs. A check is added after we know exception
  specification of a prog (throws_exception) to ensure we don't attach
  throwing extension to a program not instrumented to handle them, or
  to main subprog which has BPF_THROW_OUTER handling compared to
  extension prog's BPF_THROW_INNER handling.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 include/linux/bpf.h                           |   9 +-
 include/linux/bpf_verifier.h                  |  13 +
 include/linux/sched.h                         |   1 +
 kernel/bpf/arraymap.c                         |   9 +-
 kernel/bpf/helpers.c                          |  22 ++
 kernel/bpf/syscall.c                          |  10 +
 kernel/bpf/trampoline.c                       |   4 +-
 kernel/bpf/verifier.c                         | 241 ++++++++++++++++--
 .../testing/selftests/bpf/bpf_experimental.h  |   9 +
 9 files changed, 299 insertions(+), 19 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 002a811b6b90..04b81f5fe809 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1287,6 +1287,7 @@ static inline bool bpf_prog_has_trampoline(const struct bpf_prog *prog)
 struct bpf_func_info_aux {
 	u16 linkage;
 	bool unreliable;
+	bool throws_exception;
 };
 
 enum bpf_jit_poke_reason {
@@ -1430,7 +1431,8 @@ struct bpf_prog {
 				enforce_expected_attach_type:1, /* Enforce expected_attach_type checking at attach time */
 				call_get_stack:1, /* Do we call bpf_get_stack() or bpf_get_stackid() */
 				call_get_func_ip:1, /* Do we call get_func_ip() */
-				tstamp_type_access:1; /* Accessed __sk_buff->tstamp_type */
+				tstamp_type_access:1, /* Accessed __sk_buff->tstamp_type */
+				throws_exception:1; /* Does this program throw exceptions? */
 	enum bpf_prog_type	type;		/* Type of BPF program */
 	enum bpf_attach_type	expected_attach_type; /* For some prog types */
 	u32			len;		/* Number of filter blocks */
@@ -3035,4 +3037,9 @@ static inline gfp_t bpf_memcg_flags(gfp_t flags)
 	return flags;
 }
 
+/* BPF Exception helpers */
+void bpf_reset_exception(void);
+u64 bpf_get_exception(void);
+void bpf_throw(void);
+
 #endif /* _LINUX_BPF_H */
diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 81d525d057c7..bc067223d3ee 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -430,6 +430,17 @@ struct bpf_loop_inline_state {
 	u32 callback_subprogno; /* valid when fit_for_inline is true */
 };
 
+enum {
+	BPF_THROW_NONE,
+	BPF_THROW_OUTER,
+	BPF_THROW_INNER,
+};
+
+struct bpf_throw_state {
+	int type;
+	bool check_helper_ret_code;
+};
+
 /* Possible states for alu_state member. */
 #define BPF_ALU_SANITIZE_SRC		(1U << 0)
 #define BPF_ALU_SANITIZE_DST		(1U << 1)
@@ -464,6 +475,7 @@ struct bpf_insn_aux_data {
 		 */
 		struct bpf_loop_inline_state loop_inline_state;
 	};
+	struct bpf_throw_state throw_state;
 	u64 obj_new_size; /* remember the size of type passed to bpf_obj_new to rewrite R1 */
 	struct btf_struct_meta *kptr_struct_meta;
 	u64 map_key_state; /* constant (32 bit) key tracking for maps */
@@ -537,6 +549,7 @@ struct bpf_subprog_info {
 	bool tail_call_reachable;
 	bool has_ld_abs;
 	bool is_async_cb;
+	bool can_throw;
 };
 
 /* single container for all structs
diff --git a/include/linux/sched.h b/include/linux/sched.h
index b11b4517760f..a568245b59a2 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1480,6 +1480,7 @@ struct task_struct {
 	struct bpf_local_storage __rcu	*bpf_storage;
 	/* Used for BPF run context */
 	struct bpf_run_ctx		*bpf_ctx;
+	bool				bpf_exception_thrown[4];
 #endif
 
 #ifdef CONFIG_GCC_PLUGIN_STACKLEAK
diff --git a/kernel/bpf/arraymap.c b/kernel/bpf/arraymap.c
index 2058e89b5ddd..de0eadf8706f 100644
--- a/kernel/bpf/arraymap.c
+++ b/kernel/bpf/arraymap.c
@@ -905,7 +905,14 @@ static void *prog_fd_array_get_ptr(struct bpf_map *map,
 	if (IS_ERR(prog))
 		return prog;
 
-	if (!bpf_prog_map_compatible(map, prog)) {
+	/* Programs which throw exceptions are not allowed to be tail call
+	 * targets. This is because it forces us to be conservative for each
+	 * bpf_tail_call invocation and assume it may throw, since we do not
+	 * know what the target program may do, thus causing us to propagate the
+	 * exception and mark calling prog as potentially throwing. Just be
+	 * restrictive for now and disallow this.
+	 */
+	if (prog->throws_exception || !bpf_prog_map_compatible(map, prog)) {
 		bpf_prog_put(prog);
 		return ERR_PTR(-EINVAL);
 	}
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 6be16db9f188..89e70907257c 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -1879,6 +1879,20 @@ void bpf_rb_root_free(const struct btf_field *field, void *rb_root,
 	}
 }
 
+notrace void bpf_reset_exception(void)
+{
+	int i = interrupt_context_level();
+
+	current->bpf_exception_thrown[i] = false;
+}
+
+notrace u64 bpf_get_exception(void)
+{
+	int i = interrupt_context_level();
+
+	return current->bpf_exception_thrown[i];
+}
+
 __diag_push();
 __diag_ignore_all("-Wmissing-prototypes",
 		  "Global functions as their definitions will be in vmlinux BTF");
@@ -2295,6 +2309,13 @@ __bpf_kfunc void bpf_rcu_read_unlock(void)
 	rcu_read_unlock();
 }
 
+__bpf_kfunc notrace void bpf_throw(void)
+{
+	int i = interrupt_context_level();
+
+	current->bpf_exception_thrown[i] = true;
+}
+
 __diag_pop();
 
 BTF_SET8_START(generic_btf_ids)
@@ -2321,6 +2342,7 @@ BTF_ID_FLAGS(func, bpf_cgroup_ancestor, KF_ACQUIRE | KF_RCU | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_cgroup_from_id, KF_ACQUIRE | KF_RET_NULL)
 #endif
 BTF_ID_FLAGS(func, bpf_task_from_pid, KF_ACQUIRE | KF_RET_NULL)
+BTF_ID_FLAGS(func, bpf_throw)
 BTF_SET8_END(generic_btf_ids)
 
 static const struct btf_kfunc_id_set generic_kfunc_set = {
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index e18ac7fdc210..f82e7a174d6a 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -3144,6 +3144,16 @@ static int bpf_tracing_prog_attach(struct bpf_prog *prog,
 		tgt_prog = prog->aux->dst_prog;
 	}
 
+	/* Don't allow tracing programs to attach to fexit and clear exception
+	 * state when we are unwinding the program.
+	 */
+	if (prog->type == BPF_PROG_TYPE_TRACING &&
+	    (prog->expected_attach_type == BPF_TRACE_FEXIT) &&
+	    tgt_prog && tgt_prog->throws_exception && prog->throws_exception) {
+		err = -EINVAL;
+		goto out_unlock;
+	}
+
 	err = bpf_link_prime(&link->link.link, &link_primer);
 	if (err)
 		goto out_unlock;
diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
index f61d5138b12b..e9f9dd52f16c 100644
--- a/kernel/bpf/trampoline.c
+++ b/kernel/bpf/trampoline.c
@@ -514,7 +514,9 @@ static int __bpf_trampoline_link_prog(struct bpf_tramp_link *link, struct bpf_tr
 	kind = bpf_attach_type_to_tramp(link->link.prog);
 	if (tr->extension_prog)
 		/* cannot attach fentry/fexit if extension prog is attached.
-		 * cannot overwrite extension prog either.
+		 * cannot overwrite extension prog either. We rely on this to
+		 * not check extension prog's exception specification (since
+		 * throwing extension may not replace non-throwing).
 		 */
 		return -EBUSY;
 
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 8ecd5df73b07..6981d8817c71 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -2787,6 +2787,8 @@ static int add_subprog_and_kfunc(struct bpf_verifier_env *env)
 	return 0;
 }
 
+static bool is_bpf_throw_call(struct bpf_insn *insn);
+
 static int check_subprogs(struct bpf_verifier_env *env)
 {
 	int i, subprog_start, subprog_end, off, cur_subprog = 0;
@@ -2820,11 +2822,12 @@ static int check_subprogs(struct bpf_verifier_env *env)
 		if (i == subprog_end - 1) {
 			/* to avoid fall-through from one subprog into another
 			 * the last insn of the subprog should be either exit
-			 * or unconditional jump back
+			 * or unconditional jump back or bpf_throw call
 			 */
 			if (code != (BPF_JMP | BPF_EXIT) &&
-			    code != (BPF_JMP | BPF_JA)) {
-				verbose(env, "last insn is not an exit or jmp\n");
+			    code != (BPF_JMP | BPF_JA) &&
+			    !is_bpf_throw_call(insn + i)) {
+				verbose(env, "last insn is not an exit or jmp or bpf_throw call\n");
 				return -EINVAL;
 			}
 			subprog_start = subprog_end;
@@ -8200,6 +8203,7 @@ static int set_callee_state(struct bpf_verifier_env *env,
 			    struct bpf_func_state *callee, int insn_idx);
 
 static bool is_callback_calling_kfunc(u32 btf_id);
+static int mark_chain_throw(struct bpf_verifier_env *env, int insn_idx);
 
 static int __check_func_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 			     int *insn_idx, int subprog,
@@ -8247,6 +8251,12 @@ static int __check_func_call(struct bpf_verifier_env *env, struct bpf_insn *insn
 			caller->regs[BPF_REG_0].subreg_def = DEF_NOT_SUBREG;
 
 			/* continue with next insn after call */
+
+			/* We don't explore the global function, but if it
+			 * throws, mark the callchain as throwing.
+			 */
+			if (env->subprog_info[subprog].can_throw)
+				return mark_chain_throw(env, *insn_idx);
 			return 0;
 		}
 	}
@@ -8382,6 +8392,53 @@ static int set_callee_state(struct bpf_verifier_env *env,
 	return 0;
 }
 
+static int set_throw_state_type(struct bpf_verifier_env *env, int insn_idx,
+				int frame, int subprog)
+{
+	struct bpf_throw_state *ts = &env->insn_aux_data[insn_idx].throw_state;
+	int type;
+
+	if (!frame && !subprog && env->prog->type != BPF_PROG_TYPE_EXT)
+		type = BPF_THROW_OUTER;
+	else
+		type = BPF_THROW_INNER;
+	if (ts->type != BPF_THROW_NONE) {
+		if (ts->type != type) {
+			verbose(env,
+				"conflicting rewrite type for throwing call insn %d: %d and %d\n",
+				insn_idx, ts->type, type);
+			return -EINVAL;
+		}
+	}
+	ts->type = type;
+	return 0;
+}
+
+static int mark_chain_throw(struct bpf_verifier_env *env, int insn_idx) {
+	struct bpf_func_info_aux *func_info_aux = env->prog->aux->func_info_aux;
+	struct bpf_subprog_info *subprog = env->subprog_info;
+	struct bpf_verifier_state *state = env->cur_state;
+	struct bpf_func_state **frame = state->frame;
+	u32 cur_subprogno;
+	int ret;
+
+	/* Mark all callsites leading up to this throw and their corresponding
+	 * subprogs and update their func_info_aux table.
+	 */
+	for (int i = 1; i <= state->curframe; i++) {
+		u32 subprogno = frame[i - 1]->subprogno;
+
+		func_info_aux[subprogno].throws_exception = subprog[subprogno].can_throw = true;
+		ret = set_throw_state_type(env, frame[i]->callsite, i - 1, subprogno);
+		if (ret < 0)
+			return ret;
+	}
+	/* Now mark actual instruction which caused the throw */
+	cur_subprogno = frame[state->curframe]->subprogno;
+	func_info_aux[cur_subprogno].throws_exception = subprog[cur_subprogno].can_throw = true;
+	return set_throw_state_type(env, insn_idx, state->curframe, cur_subprogno);
+}
+
 static int check_func_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 			   int *insn_idx)
 {
@@ -8394,7 +8451,6 @@ static int check_func_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 			target_insn);
 		return -EFAULT;
 	}
-
 	return __check_func_call(env, insn, insn_idx, subprog, set_callee_state);
 }
 
@@ -8755,17 +8811,17 @@ record_func_key(struct bpf_verifier_env *env, struct bpf_call_arg_meta *meta,
 	return 0;
 }
 
-static int check_reference_leak(struct bpf_verifier_env *env)
+static int check_reference_leak(struct bpf_verifier_env *env, bool exception_exit)
 {
 	struct bpf_func_state *state = cur_func(env);
 	bool refs_lingering = false;
 	int i;
 
-	if (state->frameno && !state->in_callback_fn)
+	if (!exception_exit && state->frameno && !state->in_callback_fn)
 		return 0;
 
 	for (i = 0; i < state->acquired_refs; i++) {
-		if (state->in_callback_fn && state->refs[i].callback_ref != state->frameno)
+		if (!exception_exit && state->in_callback_fn && state->refs[i].callback_ref != state->frameno)
 			continue;
 		verbose(env, "Unreleased reference id=%d alloc_insn=%d\n",
 			state->refs[i].id, state->refs[i].insn_idx);
@@ -8999,7 +9055,7 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
 
 	switch (func_id) {
 	case BPF_FUNC_tail_call:
-		err = check_reference_leak(env);
+		err = check_reference_leak(env, false);
 		if (err) {
 			verbose(env, "tail_call would lead to reference leak\n");
 			return err;
@@ -9615,6 +9671,7 @@ enum special_kfunc_type {
 	KF_bpf_dynptr_from_xdp,
 	KF_bpf_dynptr_slice,
 	KF_bpf_dynptr_slice_rdwr,
+	KF_bpf_throw,
 };
 
 BTF_SET_START(special_kfunc_set)
@@ -9633,6 +9690,7 @@ BTF_ID(func, bpf_dynptr_from_skb)
 BTF_ID(func, bpf_dynptr_from_xdp)
 BTF_ID(func, bpf_dynptr_slice)
 BTF_ID(func, bpf_dynptr_slice_rdwr)
+BTF_ID(func, bpf_throw)
 BTF_SET_END(special_kfunc_set)
 
 BTF_ID_LIST(special_kfunc_list)
@@ -9653,6 +9711,7 @@ BTF_ID(func, bpf_dynptr_from_skb)
 BTF_ID(func, bpf_dynptr_from_xdp)
 BTF_ID(func, bpf_dynptr_slice)
 BTF_ID(func, bpf_dynptr_slice_rdwr)
+BTF_ID(func, bpf_throw)
 
 static bool is_kfunc_bpf_rcu_read_lock(struct bpf_kfunc_call_arg_meta *meta)
 {
@@ -10736,6 +10795,13 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 		}
 	}
 
+	if (meta.btf == btf_vmlinux && meta.func_id == special_kfunc_list[KF_bpf_throw]) {
+		err = mark_chain_throw(env, insn_idx);
+		if (err < 0)
+			return err;
+		return 1;
+	}
+
 	for (i = 0; i < CALLER_SAVED_REGS; i++)
 		mark_reg_not_init(env, regs, caller_saved[i]);
 
@@ -13670,7 +13736,7 @@ static int check_ld_abs(struct bpf_verifier_env *env, struct bpf_insn *insn)
 	 * gen_ld_abs() may terminate the program at runtime, leading to
 	 * reference leak.
 	 */
-	err = check_reference_leak(env);
+	err = check_reference_leak(env, false);
 	if (err) {
 		verbose(env, "BPF_LD_[ABS|IND] cannot be mixed with socket references\n");
 		return err;
@@ -14075,6 +14141,10 @@ static int visit_insn(int t, struct bpf_verifier_env *env)
 		if (insn->src_reg == BPF_PSEUDO_KFUNC_CALL) {
 			struct bpf_kfunc_call_arg_meta meta;
 
+			/* 'call bpf_throw' has no fallthrough edge, same as BPF_EXIT */
+			if (is_bpf_throw_call(insn))
+				return DONE_EXPLORING;
+
 			ret = fetch_kfunc_meta(env, insn, &meta, NULL);
 			if (ret == 0 && is_iter_next_kfunc(&meta)) {
 				mark_prune_point(env, t);
@@ -14738,7 +14808,7 @@ static bool regs_exact(const struct bpf_reg_state *rold,
 		       const struct bpf_reg_state *rcur,
 		       struct bpf_id_pair *idmap)
 {
-	return memcmp(rold, rcur, offsetof(struct bpf_reg_state, id)) == 0 && 
+	return memcmp(rold, rcur, offsetof(struct bpf_reg_state, id)) == 0 &&
 	       check_ids(rold->id, rcur->id, idmap) &&
 	       check_ids(rold->ref_obj_id, rcur->ref_obj_id, idmap);
 }
@@ -15617,6 +15687,7 @@ static int do_check(struct bpf_verifier_env *env)
 	int prev_insn_idx = -1;
 
 	for (;;) {
+		bool exception_exit = false;
 		struct bpf_insn *insn;
 		u8 class;
 		int err;
@@ -15830,12 +15901,18 @@ static int do_check(struct bpf_verifier_env *env)
 						return -EINVAL;
 					}
 				}
-				if (insn->src_reg == BPF_PSEUDO_CALL)
+				if (insn->src_reg == BPF_PSEUDO_CALL) {
 					err = check_func_call(env, insn, &env->insn_idx);
-				else if (insn->src_reg == BPF_PSEUDO_KFUNC_CALL)
+				} else if (insn->src_reg == BPF_PSEUDO_KFUNC_CALL) {
 					err = check_kfunc_call(env, insn, &env->insn_idx);
-				else
+					if (err == 1) {
+						err = 0;
+						exception_exit = true;
+						goto process_bpf_exit_full;
+					}
+				} else {
 					err = check_helper_call(env, insn, &env->insn_idx);
+				}
 				if (err)
 					return err;
 
@@ -15863,6 +15940,7 @@ static int do_check(struct bpf_verifier_env *env)
 					return -EINVAL;
 				}
 
+process_bpf_exit_full:
 				if (env->cur_state->active_lock.ptr &&
 				    !in_rbtree_lock_required_cb(env)) {
 					verbose(env, "bpf_spin_unlock is missing\n");
@@ -15880,10 +15958,23 @@ static int do_check(struct bpf_verifier_env *env)
 				 * function, for which reference_state must
 				 * match caller reference state when it exits.
 				 */
-				err = check_reference_leak(env);
+				err = check_reference_leak(env, exception_exit);
 				if (err)
 					return err;
 
+				/* The side effect of the prepare_func_exit
+				 * which is being skipped is that it frees
+				 * bpf_func_state. Typically, process_bpf_exit
+				 * will only be hit with outermost exit.
+				 * copy_verifier_state in pop_stack will handle
+				 * freeing of any extra bpf_func_state left over
+				 * from not processing all nested function
+				 * exits. We also skip return code checks as
+				 * they are not needed for exceptional exits.
+				 */
+				if (exception_exit)
+					goto process_bpf_exit;
+
 				if (state->curframe) {
 					/* exit from nested function */
 					err = prepare_func_exit(env, &env->insn_idx);
@@ -17438,6 +17529,33 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
 	int i, ret, cnt, delta = 0;
 
 	for (i = 0; i < insn_cnt; i++, insn++) {
+		/* Typically, exception state is always cleared on entry and we
+		 * ensure to clear it before exiting, but in some cases, our
+		 * invocation can occur after a BPF callback has been executed
+		 * asynchronously in the context of the current task, which may
+		 * clobber the state (think of BPF timer callbacks). Callbacks
+		 * never reset exception state (as they may be called from
+		 * within a program). Thus, if we rely on seeing the exception
+		 * state, always clear it on entry.
+		 */
+		if (i == 0 && prog->throws_exception) {
+			struct bpf_insn entry_insns[] = {
+				BPF_MOV64_REG(BPF_REG_6, BPF_REG_1),
+				BPF_EMIT_CALL(bpf_reset_exception),
+				BPF_MOV64_REG(BPF_REG_1, BPF_REG_6),
+				insn[i],
+			};
+
+			cnt = ARRAY_SIZE(entry_insns);
+			new_prog = bpf_patch_insn_data(env, i + delta, entry_insns, cnt);
+			if (!new_prog)
+				return -ENOMEM;
+
+			delta    += cnt - 1;
+			env->prog = new_prog;
+			insn      = new_prog->insnsi + i + delta;
+		}
+
 		/* Make divide-by-zero exceptions impossible. */
 		if (insn->code == (BPF_ALU64 | BPF_MOD | BPF_X) ||
 		    insn->code == (BPF_ALU64 | BPF_DIV | BPF_X) ||
@@ -18030,7 +18148,33 @@ static bool is_inlineable_bpf_loop_call(struct bpf_insn *insn,
 	return insn->code == (BPF_JMP | BPF_CALL) &&
 		insn->src_reg == 0 &&
 		insn->imm == BPF_FUNC_loop &&
-		aux->loop_inline_state.fit_for_inline;
+		aux->loop_inline_state.fit_for_inline &&
+		aux->throw_state.type == BPF_THROW_NONE;
+}
+
+static struct bpf_prog *rewrite_bpf_throw_call(struct bpf_verifier_env *env,
+					       int position,
+					       struct bpf_throw_state *tstate,
+					       u32 *cnt)
+{
+	struct bpf_insn insn_buf[] = {
+		env->prog->insnsi[position],
+		BPF_MOV64_IMM(BPF_REG_0, 0),
+		BPF_EXIT_INSN(),
+	};
+
+	*cnt = ARRAY_SIZE(insn_buf);
+	/* We don't need the call instruction for throws in frame 0 */
+	if (tstate->type == BPF_THROW_OUTER)
+		return bpf_patch_insn_data(env, position, insn_buf + 1, *cnt - 1);
+	return bpf_patch_insn_data(env, position, insn_buf, *cnt);
+}
+
+static bool is_bpf_throw_call(struct bpf_insn *insn)
+{
+	return insn->code == (BPF_JMP | BPF_CALL) &&
+	       insn->src_reg == BPF_PSEUDO_KFUNC_CALL &&
+	       insn->off == 0 && insn->imm == special_kfunc_list[KF_bpf_throw];
 }
 
 /* For all sub-programs in the program (including main) check
@@ -18069,8 +18213,24 @@ static int do_misc_rewrites(struct bpf_verifier_env *env)
 						   &cnt);
 			if (!new_prog)
 				return -ENOMEM;
+		} else if (is_bpf_throw_call(insn)) {
+			struct bpf_throw_state *throw_state = &insn_aux->throw_state;
+
+			/* The verifier was able to prove that the bpf_throw
+			 * call was unreachable, hence it must have not been
+			 * seen and will be removed by opt_remove_dead_code.
+			 */
+			if (throw_state->type == BPF_THROW_NONE) {
+				WARN_ON_ONCE(insn_aux->seen);
+				goto skip;
+			}
+
+			new_prog = rewrite_bpf_throw_call(env, i + delta, throw_state, &cnt);
+			if (!new_prog)
+				return -ENOMEM;
 		}
 
+skip:
 		if (new_prog) {
 			delta     += cnt - 1;
 			env->prog  = new_prog;
@@ -18240,6 +18400,12 @@ static int do_check_subprogs(struct bpf_verifier_env *env)
 				"Func#%d is safe for any args that match its prototype\n",
 				i);
 		}
+		/* Only reliable functions from BTF PoV can be extended, hence
+		 * remember their exception specification to check that we don't
+		 * replace non-throwing subprog with throwing subprog. The
+		 * opposite is fine though.
+		 */
+		aux->func_info_aux[i].throws_exception = env->subprog_info[i].can_throw;
 	}
 	return 0;
 }
@@ -18250,8 +18416,12 @@ static int do_check_main(struct bpf_verifier_env *env)
 
 	env->insn_idx = 0;
 	ret = do_check_common(env, 0);
-	if (!ret)
+	if (!ret) {
 		env->prog->aux->stack_depth = env->subprog_info[0].stack_depth;
+		env->prog->throws_exception = env->subprog_info[0].can_throw;
+		if (env->prog->aux->func_info)
+			env->prog->aux->func_info_aux[0].throws_exception = env->prog->throws_exception;
+	}
 	return ret;
 }
 
@@ -18753,6 +18923,42 @@ struct btf *bpf_get_btf_vmlinux(void)
 	return btf_vmlinux;
 }
 
+static int check_ext_prog(struct bpf_verifier_env *env)
+{
+	struct bpf_prog *tgt_prog = env->prog->aux->dst_prog;
+	u32 btf_id = env->prog->aux->attach_btf_id;
+	struct bpf_prog *prog = env->prog;
+	int subprog = -1;
+
+	if (prog->type != BPF_PROG_TYPE_EXT)
+		return 0;
+	for (int i = 0; i < tgt_prog->aux->func_info_cnt; i++) {
+		if (tgt_prog->aux->func_info[i].type_id == btf_id) {
+			subprog = i;
+			break;
+		}
+	}
+	if (subprog == -1) {
+		verbose(env, "verifier internal error: extension prog's subprog not found\n");
+		return -EFAULT;
+	}
+	/* BPF_THROW_OUTER rewrites won't match BPF_PROG_TYPE_EXT's
+	 * BPF_THROW_INNER rewrites.
+	 */
+	if (!subprog && prog->throws_exception) {
+		verbose(env, "Cannot attach throwing extension to main subprog\n");
+		return -EINVAL;
+	}
+	/* Overwriting extensions is not allowed, so we can simply check
+	 * the specification of the subprog we are replacing.
+	 */
+	if (!tgt_prog->aux->func_info_aux[subprog].throws_exception && prog->throws_exception) {
+		verbose(env, "Cannot attach throwing extension to non-throwing subprog\n");
+		return -EINVAL;
+	}
+	return 0;
+}
+
 int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr)
 {
 	u64 start_time = ktime_get_ns();
@@ -18871,6 +19077,9 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr)
 	ret = do_check_subprogs(env);
 	ret = ret ?: do_check_main(env);
 
+	ret = ret ?: check_ext_prog(env);
+
+
 	if (ret == 0 && bpf_prog_is_offloaded(env->prog->aux))
 		ret = bpf_prog_offload_finalize(env);
 
diff --git a/tools/testing/selftests/bpf/bpf_experimental.h b/tools/testing/selftests/bpf/bpf_experimental.h
index dbd2c729781a..d5de9251e775 100644
--- a/tools/testing/selftests/bpf/bpf_experimental.h
+++ b/tools/testing/selftests/bpf/bpf_experimental.h
@@ -89,4 +89,13 @@ extern void bpf_rbtree_add(struct bpf_rb_root *root, struct bpf_rb_node *node,
  */
 extern struct bpf_rb_node *bpf_rbtree_first(struct bpf_rb_root *root) __ksym;
 
+/* Description
+ *  Throw an exception, terminating the execution of the program immediately.
+ *  The eBPF runtime unwinds the stack automatically and exits the program with
+ *  the default return value of 0.
+ * Returns
+ *  This function never returns.
+ */
+extern void bpf_throw(void) __attribute__((noreturn)) __ksym;
+
 #endif
-- 
2.40.0

