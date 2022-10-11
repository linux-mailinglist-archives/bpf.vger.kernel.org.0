Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACA3E5FAA14
	for <lists+bpf@lfdr.de>; Tue, 11 Oct 2022 03:27:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230089AbiJKB1v (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 10 Oct 2022 21:27:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230084AbiJKB1t (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 10 Oct 2022 21:27:49 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E9EA11831
        for <bpf@vger.kernel.org>; Mon, 10 Oct 2022 18:27:48 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id c24so11825723pls.9
        for <bpf@vger.kernel.org>; Mon, 10 Oct 2022 18:27:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NH3fU9O4HGZpsTQRQ6maJct1SWkA8A4At17N3t0/mwU=;
        b=Aqjg/Q2VIe1r4VYGrFXqgWLAC0B6+G+jkaA4F0AjeczJc1J19+WcFeRCgvjv16jzSe
         Nz0mIuSUUjl6n81NQ3T+yUsOcBAiRQSMla2qWsw8pCts9zwvkVIyCumqV0uKDHjtVSZU
         sey7tBhmjq6NECuRZW5Fwmmd5pWgf/i5E7csgnmTCf5gFCfgaFUcMgMN2BLjI4sASbmn
         iddT+q29BofjELe35zhyLhTCFiOhs1Gl+yNhaVdEMimksAANkyACaPqoGZ6GORyN8pZm
         Mtq8bL1iSlxabyWR6dLKBToe7vMJgEJY12Sy+VgKEB3zJ9NoGJEjXEJ22DEapzqnehyz
         iSGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NH3fU9O4HGZpsTQRQ6maJct1SWkA8A4At17N3t0/mwU=;
        b=iuv2IomlTJ5yR6ScoaW0pVLfOG2RsKiPGh+/ayjEIvTKbqXkXorbkzA5iWCPRIKR8T
         Hsbxhx+vS82aOf94E0pRlY+hktdCpG9nzyBxp5ksMOGU8iqAGIoXi4HhyRXkQ7gkRxJ9
         /HPuY2lEcfwrntZ4QKHjjcku92A7tvs1iYQwsNUbP4cRdyHBEY8+kHN+ozirRqHeCjWa
         Uueb0zXH3xDUxehO7vEnR4YG4luS2voT/kitbyBMM/HcIR48dJcwHXEA5/7VpanWsdJk
         aELRR67sKwyO4muvfSHJ2mJb2NaqdrJLJOBPJpCcxccSWVT22OyaqgzGtQ3p8lAs61Ku
         6S3A==
X-Gm-Message-State: ACrzQf1tUO841U7VAIG2OnIaqLvmjOmRR86lsawdY+rnZVMvsWAue0/I
        Ln7Gd9T6GsYxWtw4mUvNitcL5HGeF0WzsA==
X-Google-Smtp-Source: AMsMyM6asxbtiecnXRQJKOscLdEsH3MHBT8WKAsVCV4J7qlVswhYR/1J5R0tjRcFrUt+G7Eey8ZQYA==
X-Received: by 2002:a17:902:ab89:b0:17a:67c:b9e9 with SMTP id f9-20020a170902ab8900b0017a067cb9e9mr21849820plr.55.1665451667566;
        Mon, 10 Oct 2022 18:27:47 -0700 (PDT)
Received: from localhost ([103.4.221.252])
        by smtp.gmail.com with ESMTPSA id w2-20020a1709026f0200b00179e1f08634sm701981plk.222.2022.10.10.18.27.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Oct 2022 18:27:47 -0700 (PDT)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Dave Marchevsky <davemarchevsky@fb.com>,
        Delyan Kratunov <delyank@fb.com>
Subject: [PATCH bpf-next v1 19/25] bpf: Introduce bpf_kptr_new
Date:   Tue, 11 Oct 2022 06:52:34 +0530
Message-Id: <20221011012240.3149-20-memxor@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221011012240.3149-1-memxor@gmail.com>
References: <20221011012240.3149-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=14681; i=memxor@gmail.com; h=from:subject; bh=DX9QxV2L1zHSogU3wLd8rQZSzJuY8b0j5czmmWnC4qg=; b=owEBbQKS/ZANAwAKAUzgyIZIvxHKAcsmYgBjRMUb5ZahsVki4cf0xituxBGWtXqpnCOw4PVm/4+B iaueWYqJAjMEAAEKAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCY0TFGwAKCRBM4MiGSL8RyqyKEA CHSeehhhTiAyH5BRyOWb1wsw12rZM9hDG5INNoPx3b1DrCePIiB4kzwx6KrB0HVXzV7qlJNV8wKlzf i/6BxqVEbOqtxq+jG6zhC1lUWRggSp/ut5Y672g5RCydHLizWYeWh35xWpRFzYLXUyNKT3pXHICnSG 49lKdmHfzLOUCQcVAaCnhFJjZEcrx1RXmUNBA0DdR8p0fkL38zMvXh/RnrIAuJKpic+Nn3KvExN2HB 28GbEwl0elOeAsyu7ShbgAA6tqW2u4qKheBHeMKQ5nJYGJHusBiGTsEczTpokN/+QPMUOxhqa1DA1A a9s3iiOAH9Ky9D7DeuY5tCcDam1++TU/IioO7+of2/7LMVI2Qf/GDNUea5qVTOKr0obUkoUNneRSXU M0T6GxU2RmH3U5TJcZcGt88NglG4advkUf71EymqCZmw4cCWtfkiW5ZJVUMrB00/1Rh9Ph8IT638Ss TktMiIlrHqIMgMzxWmSQeEAfD/1Ap9HdsjTugQ4zu5nC//bWOI7hDeAT89xGIAmHSd6CKwLTuqeIBy NWyWFlWruc98yiLmmCnFuS1wMnq8bu6Yoq5U3hGPNReIR8St5zrlWBuzsyPu+IJLEEvBL4q8L0CGHJ hJfkBVjcGOYDk/K9z3eVMlgUQIjBMZiJ3CLBijB4tAoj3doECb3VnoH9Xjqw==
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

Introduce type safe memory allocator bpf_kptr_new for BPF programs. The
kernel side kfunc is named bpf_kptr_new_impl, as passing hidden
arguments to kfuncs still requires having them in prototype, unlike BPF
helpers which always take 5 arguments and have them checked using
bpf_func_proto in verifier, ignoring unset argument types.

Introduce __ign suffix to ignore a specific kfunc argument during type
checks, then use this to introduce support for passing type metadata to
the bpf_kptr_new_impl kfunc.

The user passes BTF ID of the type it wants to allocates in program BTF,
the verifier then rewrites the first argument as the size of this type,
after performing some sanity checks (to ensure it exists and it is a
struct type).

The second argument flags is reserved to be 0 for now.

The third argument is also fixed up and passed by the verifier. This is
the btf_struct_meta for the type being allocated. It would be needed
mostly for the offset array which is required for zero initializing
special fields while leaving the rest of storage in unitialized state.

It would also be needed in the next patch to perform proper destruction
of the object's special fields.

A convenience macro is included in the bpf_experimental.h header to hide
over the ugly details of the implementation, leading to user code
looking similar to a language level extension which allocates and
constructs fields of a user type.

struct bar {
	struct bpf_list_node node;
};

struct foo {
	struct bpf_spin_lock lock;
	struct bpf_list_head head __contains(bar, node);
};

void prog(void) {
	struct foo *f;

	f = bpf_kptr_new(typeof(*f));
	if (!f)
		return;
	...
}

A key piece of this story is still missing, i.e. the free function,
which will come in the next patch.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 include/linux/bpf.h                           |  21 ++--
 include/linux/bpf_verifier.h                  |   2 +
 kernel/bpf/core.c                             |  14 +++
 kernel/bpf/helpers.c                          |  41 +++++--
 kernel/bpf/verifier.c                         | 107 ++++++++++++++++--
 .../testing/selftests/bpf/bpf_experimental.h  |  19 ++++
 6 files changed, 181 insertions(+), 23 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 7ffafa5bb866..29fccf7c8505 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -55,6 +55,8 @@ struct cgroup;
 extern struct idr btf_idr;
 extern spinlock_t btf_idr_lock;
 extern struct kobject *btf_kobj;
+extern struct bpf_mem_alloc bpf_global_ma;
+extern bool bpf_global_ma_set;
 
 typedef u64 (*bpf_callback_t)(u64, u64, u64, u64, u64);
 typedef int (*bpf_iter_init_seq_priv_t)(void *private_data,
@@ -335,16 +337,19 @@ static inline bool btf_type_fields_has_field(const struct btf_type_fields *tab,
 	return tab->field_mask & type;
 }
 
-static inline void check_and_init_map_value(struct bpf_map *map, void *dst)
+static inline void bpf_obj_init(const struct btf_type_fields_off *off_arr, void *obj)
 {
-	if (!IS_ERR_OR_NULL(map->fields_tab)) {
-		struct btf_field *fields = map->fields_tab->fields;
-		u32 cnt = map->fields_tab->cnt;
-		int i;
+	int i;
 
-		for (i = 0; i < cnt; i++)
-			memset(dst + fields[i].offset, 0, btf_field_type_size(fields[i].type));
-	}
+	if (!off_arr)
+		return;
+	for (i = 0; i < off_arr->cnt; i++)
+		memset(obj + off_arr->field_off[i], 0, off_arr->field_sz[i]);
+}
+
+static inline void check_and_init_map_value(struct bpf_map *map, void *dst)
+{
+	bpf_obj_init(map->off_arr, dst);
 }
 
 /* memcpy that is used with 8-byte aligned pointers, power-of-8 size and
diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 8b09c3f82071..0cc4679f3f42 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -426,6 +426,8 @@ struct bpf_insn_aux_data {
 		 */
 		struct bpf_loop_inline_state loop_inline_state;
 	};
+	u64 kptr_new_size; /* remember the size of type passed to bpf_kptr_new to rewrite R1 */
+	struct btf_struct_meta *kptr_struct_meta;
 	u64 map_key_state; /* constant (32 bit) key tracking for maps */
 	int ctx_field_size; /* the ctx field size for load insn, maybe 0 */
 	u32 seen; /* this insn was processed by the verifier at env->pass_cnt */
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 711fd293b6de..a8b3263a9a45 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -34,6 +34,7 @@
 #include <linux/log2.h>
 #include <linux/bpf_verifier.h>
 #include <linux/nodemask.h>
+#include <linux/bpf_mem_alloc.h>
 
 #include <asm/barrier.h>
 #include <asm/unaligned.h>
@@ -60,6 +61,9 @@
 #define CTX	regs[BPF_REG_CTX]
 #define IMM	insn->imm
 
+struct bpf_mem_alloc bpf_global_ma;
+bool bpf_global_ma_set;
+
 /* No hurry in this branch
  *
  * Exported for the bpf jit load helper.
@@ -2740,6 +2744,16 @@ int __weak bpf_arch_text_invalidate(void *dst, size_t len)
 	return -ENOTSUPP;
 }
 
+static int __init bpf_global_ma_init(void)
+{
+	int ret;
+
+	ret = bpf_mem_alloc_init(&bpf_global_ma, 0, false);
+	bpf_global_ma_set = !ret;
+	return ret;
+}
+late_initcall(bpf_global_ma_init);
+
 DEFINE_STATIC_KEY_FALSE(bpf_stats_enabled_key);
 EXPORT_SYMBOL(bpf_stats_enabled_key);
 
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 882cd0ebf117..c7c3c049e647 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -19,6 +19,7 @@
 #include <linux/proc_ns.h>
 #include <linux/security.h>
 #include <linux/btf_ids.h>
+#include <linux/bpf_mem_alloc.h>
 
 #include "../../lib/kstrtox.h"
 
@@ -1725,26 +1726,52 @@ void bpf_list_head_free(const struct btf_field *field, void *list_head,
 
 		obj -= field->list_head.node_offset;
 		head = head->next;
-		/* TODO: Rework later */
-		kfree(obj);
+		/* The contained type can also have resources, including a
+		 * bpf_list_head which needs to be freed.
+		 */
+		bpf_obj_free_fields(field->list_head.value_tab, obj);
+		bpf_mem_free(&bpf_global_ma, obj);
 	}
 	INIT_LIST_HEAD(orig_head);
 }
 
-BTF_SET8_START(tracing_btf_ids)
+__diag_push();
+__diag_ignore_all("-Wmissing-prototypes",
+		  "Global functions as their definitions will be in vmlinux BTF");
+
+void *bpf_kptr_new_impl(u64 local_type_id__k, u64 flags, void *meta__ign)
+{
+	struct btf_struct_meta *meta = meta__ign;
+	u64 size = local_type_id__k;
+	void *p;
+
+	if (unlikely(flags || !bpf_global_ma_set))
+		return NULL;
+	p = bpf_mem_alloc(&bpf_global_ma, size);
+	if (!p)
+		return NULL;
+	if (meta)
+		bpf_obj_init(meta->off_arr, p);
+	return p;
+}
+
+__diag_pop();
+
+BTF_SET8_START(generic_btf_ids)
 #ifdef CONFIG_KEXEC_CORE
 BTF_ID_FLAGS(func, crash_kexec, KF_DESTRUCTIVE)
 #endif
-BTF_SET8_END(tracing_btf_ids)
+BTF_ID_FLAGS(func, bpf_kptr_new_impl, KF_ACQUIRE | KF_RET_NULL)
+BTF_SET8_END(generic_btf_ids)
 
-static const struct btf_kfunc_id_set tracing_kfunc_set = {
+static const struct btf_kfunc_id_set generic_kfunc_set = {
 	.owner = THIS_MODULE,
-	.set   = &tracing_btf_ids,
+	.set   = &generic_btf_ids,
 };
 
 static int __init kfunc_init(void)
 {
-	return register_btf_kfunc_id_set(BPF_PROG_TYPE_TRACING, &tracing_kfunc_set);
+	return register_btf_kfunc_id_set(BPF_PROG_TYPE_TRACING, &generic_kfunc_set);
 }
 
 late_initcall(kfunc_init);
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 50928fe4348d..21d71db16699 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -7766,6 +7766,11 @@ static bool is_kfunc_arg_sfx_constant(const struct btf *btf, const struct btf_pa
 	return __kfunc_param_match_suffix(btf, arg, "__k");
 }
 
+static bool is_kfunc_arg_sfx_ignore(const struct btf *btf, const struct btf_param *arg)
+{
+	return __kfunc_param_match_suffix(btf, arg, "__ign");
+}
+
 static bool is_kfunc_arg_ret_buf_size(const struct btf *btf,
 				      const struct btf_param *arg,
 				      const struct bpf_reg_state *reg,
@@ -8035,6 +8040,10 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
 		int kf_arg_type;
 
 		t = btf_type_skip_modifiers(btf, args[i].type, NULL);
+
+		if (is_kfunc_arg_sfx_ignore(btf, &args[i]))
+			continue;
+
 		if (btf_type_is_scalar(t)) {
 			if (reg->type != SCALAR_VALUE) {
 				verbose(env, "R%d is not a scalar\n", regno);
@@ -8212,6 +8221,17 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
 	return 0;
 }
 
+enum special_kfunc_type {
+	KF_bpf_kptr_new_impl,
+};
+
+BTF_SET_START(special_kfunc_set)
+BTF_ID(func, bpf_kptr_new_impl)
+BTF_SET_END(special_kfunc_set)
+
+BTF_ID_LIST(special_kfunc_list)
+BTF_ID(func, bpf_kptr_new_impl)
+
 static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 			    int *insn_idx_p)
 {
@@ -8286,17 +8306,64 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 	t = btf_type_skip_modifiers(desc_btf, func_proto->type, NULL);
 
 	if (is_kfunc_acquire(&meta) && !btf_type_is_struct_ptr(meta.btf, t)) {
-		verbose(env, "acquire kernel function does not return PTR_TO_BTF_ID\n");
-		return -EINVAL;
+		/* Only exception is bpf_kptr_new_impl */
+		if (meta.btf != btf_vmlinux || meta.func_id != special_kfunc_list[KF_bpf_kptr_new_impl]) {
+			verbose(env, "acquire kernel function does not return PTR_TO_BTF_ID\n");
+			return -EINVAL;
+		}
 	}
 
 	if (btf_type_is_scalar(t)) {
 		mark_reg_unknown(env, regs, BPF_REG_0);
 		mark_btf_func_reg_size(env, BPF_REG_0, t->size);
 	} else if (btf_type_is_ptr(t)) {
-		ptr_type = btf_type_skip_modifiers(desc_btf, t->type,
-						   &ptr_type_id);
-		if (!btf_type_is_struct(ptr_type)) {
+		ptr_type = btf_type_skip_modifiers(desc_btf, t->type, &ptr_type_id);
+
+		if (meta.btf == btf_vmlinux && btf_id_set_contains(&special_kfunc_set, meta.func_id)) {
+			if (!btf_type_is_void(ptr_type)) {
+				verbose(env, "kernel function %s must have void * return type\n",
+					meta.func_name);
+				return -EINVAL;
+			}
+			if (meta.func_id == special_kfunc_list[KF_bpf_kptr_new_impl]) {
+				const struct btf_type *ret_t;
+				struct btf *ret_btf;
+				u32 ret_btf_id;
+
+				if (((u64)(u32)meta.arg_constant.value) != meta.arg_constant.value) {
+					verbose(env, "local type ID argument must be in range [0, U32_MAX]\n");
+					return -EINVAL;
+				}
+
+				ret_btf = env->prog->aux->btf;
+				ret_btf_id = meta.arg_constant.value;
+
+				/* This may be NULL due to user not supplying a BTF */
+				if (!ret_btf) {
+					verbose(env, "bpf_kptr_new requires prog BTF\n");
+					return -EINVAL;
+				}
+
+				mark_reg_known_zero(env, regs, BPF_REG_0);
+				regs[BPF_REG_0].type = PTR_TO_BTF_ID | MEM_TYPE_LOCAL;
+				regs[BPF_REG_0].btf = ret_btf;
+				regs[BPF_REG_0].btf_id = ret_btf_id;
+
+				ret_t = btf_type_by_id(ret_btf, ret_btf_id);
+				if (!ret_t || !__btf_type_is_struct(ret_t)) {
+					verbose(env, "bpf_kptr_new type ID argument must be of a struct\n");
+					return -EINVAL;
+				}
+
+				env->insn_aux_data[insn_idx].kptr_new_size = ret_t->size;
+				env->insn_aux_data[insn_idx].kptr_struct_meta =
+					btf_find_struct_meta(ret_btf, ret_btf_id);
+			} else {
+				verbose(env, "kernel function %s unhandled dynamic return type\n",
+					meta.func_name);
+				return -EFAULT;
+			}
+		} else if (!__btf_type_is_struct(ptr_type)) {
 			if (!meta.r0_size) {
 				ptr_type_name = btf_name_by_offset(desc_btf,
 								   ptr_type->name_off);
@@ -8324,6 +8391,7 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 			regs[BPF_REG_0].type = PTR_TO_BTF_ID;
 			regs[BPF_REG_0].btf_id = ptr_type_id;
 		}
+
 		if (is_kfunc_ret_null(&meta)) {
 			regs[BPF_REG_0].type |= PTR_MAYBE_NULL;
 			/* For mark_ptr_or_null_reg, see 93c230e3f5bd6 */
@@ -14455,8 +14523,8 @@ static int fixup_call_args(struct bpf_verifier_env *env)
 	return err;
 }
 
-static int fixup_kfunc_call(struct bpf_verifier_env *env,
-			    struct bpf_insn *insn)
+static int fixup_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
+			    struct bpf_insn *insn_buf, int insn_idx, int *cnt)
 {
 	const struct bpf_kfunc_desc *desc;
 
@@ -14475,8 +14543,21 @@ static int fixup_kfunc_call(struct bpf_verifier_env *env,
 		return -EFAULT;
 	}
 
+	*cnt = 0;
 	insn->imm = desc->imm;
+	if (insn->off)
+		return 0;
+	if (desc->func_id == special_kfunc_list[KF_bpf_kptr_new_impl]) {
+		struct btf_struct_meta *kptr_struct_meta = env->insn_aux_data[insn_idx].kptr_struct_meta;
+		struct bpf_insn addr[2] = { BPF_LD_IMM64(BPF_REG_3, (long)kptr_struct_meta) };
+		u64 kptr_new_size = env->insn_aux_data[insn_idx].kptr_new_size;
 
+		insn_buf[0] = BPF_MOV64_IMM(BPF_REG_1, kptr_new_size);
+		insn_buf[1] = addr[0];
+		insn_buf[2] = addr[1];
+		insn_buf[3] = *insn;
+		*cnt = 4;
+	}
 	return 0;
 }
 
@@ -14618,9 +14699,19 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
 		if (insn->src_reg == BPF_PSEUDO_CALL)
 			continue;
 		if (insn->src_reg == BPF_PSEUDO_KFUNC_CALL) {
-			ret = fixup_kfunc_call(env, insn);
+			ret = fixup_kfunc_call(env, insn, insn_buf, i + delta, &cnt);
 			if (ret)
 				return ret;
+			if (cnt == 0)
+				continue;
+
+			new_prog = bpf_patch_insn_data(env, i + delta, insn_buf, cnt);
+			if (!new_prog)
+				return -ENOMEM;
+
+			delta	 += cnt - 1;
+			env->prog = prog = new_prog;
+			insn	  = new_prog->insnsi + i + delta;
 			continue;
 		}
 
diff --git a/tools/testing/selftests/bpf/bpf_experimental.h b/tools/testing/selftests/bpf/bpf_experimental.h
index 4e31790e433d..9c7d0badb02e 100644
--- a/tools/testing/selftests/bpf/bpf_experimental.h
+++ b/tools/testing/selftests/bpf/bpf_experimental.h
@@ -20,4 +20,23 @@ struct bpf_list_node {
 #endif
 
 #ifndef __KERNEL__
+
+/* Description
+ *	Allocates a local kptr of type represented by 'local_type_id' in program
+ *	BTF. User may use the bpf_core_type_id_local macro to pass the type ID
+ *	of a struct in program BTF.
+ *
+ *	The 'local_type_id' parameter must be a known constant. The 'flags'
+ *	parameter must be 0.
+ *
+ *	The 'meta__ign' parameter is a hidden argument that is ignored.
+ * Returns
+ *	A local kptr corresponding to passed in 'local_type_id', or NULL on
+ *	failure.
+ */
+extern void *bpf_kptr_new_impl(__u64 local_type_id, __u64 flags, void *meta__ign) __ksym;
+
+/* Convenience macro to wrap over bpf_kptr_new_impl */
+#define bpf_kptr_new(type) bpf_kptr_new_impl(bpf_core_type_id_local(type), 0, NULL)
+
 #endif
-- 
2.34.1

