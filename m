Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 449F86E363E
	for <lists+bpf@lfdr.de>; Sun, 16 Apr 2023 10:49:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230330AbjDPItm (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 16 Apr 2023 04:49:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjDPItl (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 16 Apr 2023 04:49:41 -0400
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B633512E;
        Sun, 16 Apr 2023 01:49:39 -0700 (PDT)
Received: by mail-qt1-f173.google.com with SMTP id w38so8246425qtc.11;
        Sun, 16 Apr 2023 01:49:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681634978; x=1684226978;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DgspQl77tIJVbZbds2zeiklP4+aLtGFJe6XKlpY7kxM=;
        b=ay508hgeFX6cnUh79+fqVSk39BEAFetI4Zyf5EIgOJbHUzCXtKe8IjgPykosgV3u+n
         ph/yydC/eCPCS8344bN99oE3cjLFBqvPg7fjv/fzQGfQbhFQZFGNk3Dz9nRy9ERcYfld
         od3U3snRcn4X0RN0Y0kx2AWe/CA1M6SnX1uRlqjZHAVPreJKURUhIAnHMYtQXe51QO4K
         y+va4wTuQLzm2/+GQn/2QVIUd5rdjwBY9vKV1YBJAzr5LBmMFL1M6okhXKQfSFOoUMDY
         Q7+tDWi6IR4hPpuYZLurtVDljNRl7hKV+DDHEUIyGHUJEs4gkzcIkiZUcMfUYG0tr95P
         0+2w==
X-Gm-Message-State: AAQBX9dEUgclLWVaG7QgQS3cfBT+fo+lPKN/hSaNgStzuK99RpU+nINX
        Pbn0IS+hmD4baGpSisYPRmr51/yULbkCcKgiDNiS1Q==
X-Google-Smtp-Source: AKy350ZRrp/1V4kI//p1pQdxXzpikazV88DthTmLzh6BjAnIc7GMogVhuveQufQ7QYJyD1KZmNx2/g==
X-Received: by 2002:ac8:59d5:0:b0:3e3:902a:a084 with SMTP id f21-20020ac859d5000000b003e3902aa084mr18355105qtf.6.1681634978356;
        Sun, 16 Apr 2023 01:49:38 -0700 (PDT)
Received: from localhost ([24.1.27.177])
        by smtp.gmail.com with ESMTPSA id pr11-20020a05620a86cb00b0074acdb873a7sm2403006qkn.86.2023.04.16.01.49.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Apr 2023 01:49:37 -0700 (PDT)
From:   David Vernet <void@manifault.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com, memxor@gmail.com
Subject: [PATCH bpf-next v2 2/3] bpf: Remove KF_KPTR_GET kfunc flag
Date:   Sun, 16 Apr 2023 03:49:27 -0500
Message-Id: <20230416084928.326135-3-void@manifault.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230416084928.326135-1-void@manifault.com>
References: <20230416084928.326135-1-void@manifault.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

We've managed to improve the UX for kptrs significantly over the last 9
months. All of the existing use cases which previously had KF_KPTR_GET
kfuncs (struct bpf_cpumask *, struct task_struct *, and struct cgroup *)
have all been updated to be synchronized using RCU. In other words,
their KF_KPTR_GET kfuncs have been removed in favor of KF_RCU |
KF_ACQUIRE kfuncs, with the pointers themselves also being readable from
maps in an RCU read region thanks to the types being RCU safe.

While KF_KPTR_GET was a logical starting point for kptrs, it's become
clear that they're not the correct abstraction. KF_KPTR_GET is a flag
that essentially does nothing other than enforcing that the argument to
a function is a pointer to a referenced kptr map value. At first glance,
that's a useful thing to guarantee to a kfunc. It gives kfuncs the
ability to try and acquire a reference on that kptr without requiring
the BPF prog to do something like this:

struct kptr_type *in_map, *new = NULL;

in_map = bpf_kptr_xchg(&map->value, NULL);
if (in_map) {
        new = bpf_kptr_type_acquire(in_map);
        in_map = bpf_kptr_xchg(&map->value, in_map);
        if (in_map)
                bpf_kptr_type_release(in_map);
}

That's clearly a pretty ugly (and racy) UX, and if using KF_KPTR_GET is
the only alternative, it's better than nothing. However, the problem
with any KF_KPTR_GET kfunc lies in the fact that it always requires some
kind of synchronization in order to safely do an opportunistic acquire
of the kptr in the map. This is because a BPF program running on another
CPU could do a bpf_kptr_xchg() on that map value, and free the kptr
after it's been read by the KF_KPTR_GET kfunc. For example, the
now-removed bpf_task_kptr_get() kfunc did the following:

struct task_struct *bpf_task_kptr_get(struct task_struct **pp)
{
            struct task_struct *p;

        rcu_read_lock();
        p = READ_ONCE(*pp);
        /* If p is non-NULL, it could still be freed by another CPU,
         * so we have to do an opportunistic refcount_inc_not_zero()
         * and return NULL if the task will be freed after the
         * current RCU read region.
         */
        |f (p && !refcount_inc_not_zero(&p->rcu_users))
                p = NULL;
        rcu_read_unlock();

        return p;
}

In other words, the kfunc uses RCU to ensure that the task remains valid
after it's been peeked from the map. However, this is completely
redundant with just defining a KF_RCU kfunc that itself does a
refcount_inc_not_zero(), which is exactly what bpf_task_acquire() now
does.

So, the question of whether KF_KPTR_GET is useful is actually, "Are
there any synchronization mechanisms / safety flags that are required by
certain kptrs, but which are not provided by the verifier to kfuncs?"
The answer to that question today is "No", because every kptr we
currently care about is RCU protected.

Even if the answer ever became "yes", the proper way to support that
referenced kptr type would be to add support for whatever
synchronization mechanism it requires in the verifier, rather than
giving kfuncs a flag that says, "Here's a pointer to a referenced kptr
in a map, do whatever you need to do."

With all that said -- so as to allow us to consolidate the kfunc API,
and simplify the verifier a bit, this patch removes KF_KPTR_GET, and all
relevant logic from the verifier.

Signed-off-by: David Vernet <void@manifault.com>
---
 include/linux/btf.h   |  1 -
 kernel/bpf/verifier.c | 65 -------------------------------------------
 2 files changed, 66 deletions(-)

diff --git a/include/linux/btf.h b/include/linux/btf.h
index 813227bff58a..508199e38415 100644
--- a/include/linux/btf.h
+++ b/include/linux/btf.h
@@ -18,7 +18,6 @@
 #define KF_ACQUIRE	(1 << 0) /* kfunc is an acquire function */
 #define KF_RELEASE	(1 << 1) /* kfunc is a release function */
 #define KF_RET_NULL	(1 << 2) /* kfunc returns a pointer that may be NULL */
-#define KF_KPTR_GET	(1 << 3) /* kfunc returns reference to a kptr */
 /* Trusted arguments are those which are guaranteed to be valid when passed to
  * the kfunc. It is used to enforce that pointers obtained from either acquire
  * kfuncs, or from the main kernel on a tracepoint or struct_ops callback
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 6a41b69a424e..5dae11ee01c3 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -9339,11 +9339,6 @@ static bool is_kfunc_rcu(struct bpf_kfunc_call_arg_meta *meta)
 	return meta->kfunc_flags & KF_RCU;
 }
 
-static bool is_kfunc_arg_kptr_get(struct bpf_kfunc_call_arg_meta *meta, int arg)
-{
-	return arg == 0 && (meta->kfunc_flags & KF_KPTR_GET);
-}
-
 static bool __kfunc_param_match_suffix(const struct btf *btf,
 				       const struct btf_param *arg,
 				       const char *suffix)
@@ -9554,7 +9549,6 @@ enum kfunc_ptr_arg_type {
 	KF_ARG_PTR_TO_CTX,
 	KF_ARG_PTR_TO_ALLOC_BTF_ID,    /* Allocated object */
 	KF_ARG_PTR_TO_REFCOUNTED_KPTR, /* Refcounted local kptr */
-	KF_ARG_PTR_TO_KPTR,	       /* PTR_TO_KPTR but type specific */
 	KF_ARG_PTR_TO_DYNPTR,
 	KF_ARG_PTR_TO_ITER,
 	KF_ARG_PTR_TO_LIST_HEAD,
@@ -9666,21 +9660,6 @@ get_kfunc_ptr_arg_type(struct bpf_verifier_env *env,
 	if (is_kfunc_arg_refcounted_kptr(meta->btf, &args[argno]))
 		return KF_ARG_PTR_TO_REFCOUNTED_KPTR;
 
-	if (is_kfunc_arg_kptr_get(meta, argno)) {
-		if (!btf_type_is_ptr(ref_t)) {
-			verbose(env, "arg#0 BTF type must be a double pointer for kptr_get kfunc\n");
-			return -EINVAL;
-		}
-		ref_t = btf_type_by_id(meta->btf, ref_t->type);
-		ref_tname = btf_name_by_offset(meta->btf, ref_t->name_off);
-		if (!btf_type_is_struct(ref_t)) {
-			verbose(env, "kernel function %s args#0 pointer type %s %s is not supported\n",
-				meta->func_name, btf_type_str(ref_t), ref_tname);
-			return -EINVAL;
-		}
-		return KF_ARG_PTR_TO_KPTR;
-	}
-
 	if (is_kfunc_arg_dynptr(meta->btf, &args[argno]))
 		return KF_ARG_PTR_TO_DYNPTR;
 
@@ -9794,40 +9773,6 @@ static int process_kf_arg_ptr_to_btf_id(struct bpf_verifier_env *env,
 	return 0;
 }
 
-static int process_kf_arg_ptr_to_kptr(struct bpf_verifier_env *env,
-				      struct bpf_reg_state *reg,
-				      const struct btf_type *ref_t,
-				      const char *ref_tname,
-				      struct bpf_kfunc_call_arg_meta *meta,
-				      int argno)
-{
-	struct btf_field *kptr_field;
-
-	/* check_func_arg_reg_off allows var_off for
-	 * PTR_TO_MAP_VALUE, but we need fixed offset to find
-	 * off_desc.
-	 */
-	if (!tnum_is_const(reg->var_off)) {
-		verbose(env, "arg#0 must have constant offset\n");
-		return -EINVAL;
-	}
-
-	kptr_field = btf_record_find(reg->map_ptr->record, reg->off + reg->var_off.value, BPF_KPTR);
-	if (!kptr_field || kptr_field->type != BPF_KPTR_REF) {
-		verbose(env, "arg#0 no referenced kptr at map value offset=%llu\n",
-			reg->off + reg->var_off.value);
-		return -EINVAL;
-	}
-
-	if (!btf_struct_ids_match(&env->log, meta->btf, ref_t->type, 0, kptr_field->kptr.btf,
-				  kptr_field->kptr.btf_id, true)) {
-		verbose(env, "kernel function %s args#%d expected pointer to %s %s\n",
-			meta->func_name, argno, btf_type_str(ref_t), ref_tname);
-		return -EINVAL;
-	}
-	return 0;
-}
-
 static int ref_set_non_owning(struct bpf_verifier_env *env, struct bpf_reg_state *reg)
 {
 	struct bpf_verifier_state *state = env->cur_state;
@@ -10315,7 +10260,6 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
 			/* Trusted arguments have the same offset checks as release arguments */
 			arg_type |= OBJ_RELEASE;
 			break;
-		case KF_ARG_PTR_TO_KPTR:
 		case KF_ARG_PTR_TO_DYNPTR:
 		case KF_ARG_PTR_TO_ITER:
 		case KF_ARG_PTR_TO_LIST_HEAD:
@@ -10368,15 +10312,6 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
 				meta->arg_obj_drop.btf_id = reg->btf_id;
 			}
 			break;
-		case KF_ARG_PTR_TO_KPTR:
-			if (reg->type != PTR_TO_MAP_VALUE) {
-				verbose(env, "arg#0 expected pointer to map value\n");
-				return -EINVAL;
-			}
-			ret = process_kf_arg_ptr_to_kptr(env, reg, ref_t, ref_tname, meta, i);
-			if (ret < 0)
-				return ret;
-			break;
 		case KF_ARG_PTR_TO_DYNPTR:
 		{
 			enum bpf_arg_type dynptr_arg_type = ARG_PTR_TO_DYNPTR;
-- 
2.40.0

