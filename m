Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E6EF618853
	for <lists+bpf@lfdr.de>; Thu,  3 Nov 2022 20:11:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230294AbiKCTLn (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 3 Nov 2022 15:11:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231160AbiKCTLi (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 3 Nov 2022 15:11:38 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9294E1D673
        for <bpf@vger.kernel.org>; Thu,  3 Nov 2022 12:11:37 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id b5so2495944pgb.6
        for <bpf@vger.kernel.org>; Thu, 03 Nov 2022 12:11:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mxG10SHL1mgHi1jo8YqdIZ6SjwklzrMqVuBzZ4zsgfc=;
        b=HcjFsZ1dhY7WPV1a6HwxFeHCv6sJWsx6TqOJqILAFq6YtMkxLJRsCrE2yX4eIhEYWo
         jqBS9HC6GiqoARDvgTnDeuRab1NClN2UIoApF/iSKgoUrGmD/2YP9M7VmAzR17dOqTxe
         SVUCEzLthml5Z3d6T2EZjm6W2GH1JUD7dEIybApOxr1e+LL0Yr4jRuSalXarQmI6idG9
         bEw7jVMwUpPu3TPg6niAf3FnAUEnNdvwYXL4o51i4XkCg3mDUx9rBVlYQ47hReswnqLJ
         EfYPIDp+Oxakw7vieLeQqHjeY9+OpT2D3ZfARH9CNDxhgyS2vm/eq7FHU/phka24ir34
         WQfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mxG10SHL1mgHi1jo8YqdIZ6SjwklzrMqVuBzZ4zsgfc=;
        b=LU4ow9XzEEAp8Kqu8OMt3/trht6H3RqOtLCtrHOSd/UoRVsEcVW7jcRRAV1DUIDsNz
         MM25z1ylePiO8+D48pxByfnQTRHcBb+Xbn7Wv4h68inNX8rpgncTt6dcCX53NTwDYiJo
         jQq+VUxYPNPx7WMgqZr3p9COWyo588hxLbX3JnXEWnHHJXzve+QK159zDsNdhZkUQYDS
         WrJm45BL05xfx1AkumMkaEd/yoy75sceN8szncQn4wOsdYWTiZMRln0JQQ/4qGz8vrI0
         j6EOVq0BQ+R4Y4nib9PqNCv1jIFTQz7yjhXG0EBVzbppZVaNJS/LjfM6pwRyiQqsB+hp
         12oQ==
X-Gm-Message-State: ACrzQf1FDe1bdUkud9xUuFG9NuN80Ij3hfLXRB3Cn93xNPV4kN4ZMITA
        Ru+V2Z1aJdrLKhlHg0qA50Z9T5BwKy87Jw==
X-Google-Smtp-Source: AMsMyM6+qnoJv5XEdTb38um+SU/a1WmL5nC0akq1EwaSmNVIKU7BeUoQdNt334oQXUimvrk9IOxdYA==
X-Received: by 2002:a62:6544:0:b0:561:7446:fdf4 with SMTP id z65-20020a626544000000b005617446fdf4mr32592570pfb.41.1667502696747;
        Thu, 03 Nov 2022 12:11:36 -0700 (PDT)
Received: from localhost ([103.4.222.252])
        by smtp.gmail.com with ESMTPSA id c5-20020a056a00008500b005629b6a8b53sm1169072pfj.15.2022.11.03.12.11.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 12:11:36 -0700 (PDT)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Dave Marchevsky <davemarchevsky@meta.com>,
        Delyan Kratunov <delyank@meta.com>
Subject: [PATCH bpf-next v4 19/24] bpf: Introduce bpf_obj_new
Date:   Fri,  4 Nov 2022 00:40:08 +0530
Message-Id: <20221103191013.1236066-20-memxor@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221103191013.1236066-1-memxor@gmail.com>
References: <20221103191013.1236066-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=14749; i=memxor@gmail.com; h=from:subject; bh=EolbvCurhZY+ps3NoDwhU+5viYDibsvP6YEC6v9+HnY=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBjZBIBcMbHzaNYNs114rSskNJ6/wt5WMOZlOQVTBD8 2WiVbBCJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCY2QSAQAKCRBM4MiGSL8RytXREA CWt9CLZNGv8nDt4k9R8LcUHJPFbqhf29VR5uiQATB1Jd3lJbaO2DZcGZ+4Hzp9Pwx15iUMVbYhdtFK mphR9aLCQA3vCqfTWG49qf1ouYXiFnL43UvG96YSIJgmVkZozOkoxl+9BY5s0R6HmZsQtBYa1OWYa9 d7R54XJzvKWLFrcIUTjNkD64u63QP7Mg+MwDHfp1sNKiiVhUB1DH3cPoLhQaFFdYuz3LmGtw45rGKA 6CRtFdKpgKj1iuw+9Cpx+sO+Nj8bL6uDbIvWePFaCEI7I+hAgrS6aLKE3EAAbRTIiz8hEnZeqtq8aW a8vBF1bXoAu5VwgJUd5TkkLHCduwQBcsFI2bGs+ID+0iEtc+AF8rFW+0lB5wtlc3oa5T0L9tv5K/Ag B1tOqJrZ7ZufP6Vzv3vJ64vLlkV8RmExlaRe//ul1ob3GjN552TME5hFGkTgyTI5oQitFonNIBgo8T yGJQhACCd91VemWuxVqSpgfOjD4zjns4zM2LAK4z2HZIUbrdkHkJ0uQb+lgzFu3ctczvPAwLYo1Uhq Tp4TTXNql6VhrIMHEonn8TWOwaWZl0v5sHOi3t1EhnqRh6k+y3PO5ehCZKkbXM8P25pgXSWLfIGYyt qHl/shpAkI5vpz0TSo3SWJl4/tchQA+rsF3xT/AMpDquQrBkW30isKrv+aiQ==
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

Introduce type safe memory allocator bpf_obj_new for BPF programs. The
kernel side kfunc is named bpf_obj_new_impl, as passing hidden arguments
to kfuncs still requires having them in prototype, unlike BPF helpers
which always take 5 arguments and have them checked using bpf_func_proto
in verifier, ignoring unset argument types.

Introduce __ign suffix to ignore a specific kfunc argument during type
checks, then use this to introduce support for passing type metadata to
the bpf_obj_new_impl kfunc.

The user passes BTF ID of the type it wants to allocates in program BTF,
the verifier then rewrites the first argument as the size of this type,
after performing some sanity checks (to ensure it exists and it is a
struct type).

The second argument is also fixed up and passed by the verifier. This is
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

	f = bpf_obj_new(typeof(*f));
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
 kernel/bpf/core.c                             |  16 +++
 kernel/bpf/helpers.c                          |  41 +++++--
 kernel/bpf/verifier.c                         | 107 ++++++++++++++++--
 .../testing/selftests/bpf/bpf_experimental.h  |  20 ++++
 6 files changed, 184 insertions(+), 23 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/bpf_experimental.h

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 5d9a786e0cef..efce66b2e220 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -54,6 +54,8 @@ struct cgroup;
 extern struct idr btf_idr;
 extern spinlock_t btf_idr_lock;
 extern struct kobject *btf_kobj;
+extern struct bpf_mem_alloc bpf_global_ma;
+extern bool bpf_global_ma_set;
 
 typedef u64 (*bpf_callback_t)(u64, u64, u64, u64, u64);
 typedef int (*bpf_iter_init_seq_priv_t)(void *private_data,
@@ -334,16 +336,19 @@ static inline bool btf_record_has_field(const struct btf_record *rec, enum btf_f
 	return rec->field_mask & type;
 }
 
-static inline void check_and_init_map_value(struct bpf_map *map, void *dst)
+static inline void bpf_obj_init(const struct btf_field_offs *foffs, void *obj)
 {
-	if (!IS_ERR_OR_NULL(map->record)) {
-		struct btf_field *fields = map->record->fields;
-		u32 cnt = map->record->cnt;
-		int i;
+	int i;
 
-		for (i = 0; i < cnt; i++)
-			memset(dst + fields[i].offset, 0, btf_field_type_size(fields[i].type));
-	}
+	if (!foffs)
+		return;
+	for (i = 0; i < foffs->cnt; i++)
+		memset(obj + foffs->field_off[i], 0, foffs->field_sz[i]);
+}
+
+static inline void check_and_init_map_value(struct bpf_map *map, void *dst)
+{
+	bpf_obj_init(map->field_offs, dst);
 }
 
 /* memcpy that is used with 8-byte aligned pointers, power-of-8 size and
diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 2614892ca063..1e9c782e0974 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -426,6 +426,8 @@ struct bpf_insn_aux_data {
 		 */
 		struct bpf_loop_inline_state loop_inline_state;
 	};
+	u64 obj_new_size; /* remember the size of type passed to bpf_obj_new to rewrite R1 */
+	struct btf_struct_meta *kptr_struct_meta;
 	u64 map_key_state; /* constant (32 bit) key tracking for maps */
 	int ctx_field_size; /* the ctx field size for load insn, maybe 0 */
 	u32 seen; /* this insn was processed by the verifier at env->pass_cnt */
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 9c16338bcbe8..2e57fc839a5c 100644
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
@@ -2746,6 +2750,18 @@ int __weak bpf_arch_text_invalidate(void *dst, size_t len)
 	return -ENOTSUPP;
 }
 
+#ifdef CONFIG_BPF_SYSCALL
+static int __init bpf_global_ma_init(void)
+{
+	int ret;
+
+	ret = bpf_mem_alloc_init(&bpf_global_ma, 0, false);
+	bpf_global_ma_set = !ret;
+	return ret;
+}
+late_initcall(bpf_global_ma_init);
+#endif
+
 DEFINE_STATIC_KEY_FALSE(bpf_stats_enabled_key);
 EXPORT_SYMBOL(bpf_stats_enabled_key);
 
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 207f622ec70d..e10245e054e4 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -19,6 +19,7 @@
 #include <linux/proc_ns.h>
 #include <linux/security.h>
 #include <linux/btf_ids.h>
+#include <linux/bpf_mem_alloc.h>
 
 #include "../../lib/kstrtox.h"
 
@@ -1731,8 +1732,11 @@ void bpf_list_head_free(const struct btf_field *field, void *list_head,
 
 		obj -= field->list_head.node_offset;
 		head = head->next;
-		/* TODO: Rework later */
-		kfree(obj);
+		/* The contained type can also have resources, including a
+		 * bpf_list_head which needs to be freed.
+		 */
+		bpf_obj_free_fields(field->list_head.value_rec, obj);
+		bpf_mem_free(&bpf_global_ma, obj);
 	}
 unlock:
 	INIT_LIST_HEAD(head);
@@ -1740,20 +1744,43 @@ void bpf_list_head_free(const struct btf_field *field, void *list_head,
 	local_irq_restore(flags);
 }
 
-BTF_SET8_START(tracing_btf_ids)
+__diag_push();
+__diag_ignore_all("-Wmissing-prototypes",
+		  "Global functions as their definitions will be in vmlinux BTF");
+
+void *bpf_obj_new_impl(u64 local_type_id__k, void *meta__ign)
+{
+	struct btf_struct_meta *meta = meta__ign;
+	u64 size = local_type_id__k;
+	void *p;
+
+	if (unlikely(!bpf_global_ma_set))
+		return NULL;
+	p = bpf_mem_alloc(&bpf_global_ma, size);
+	if (!p)
+		return NULL;
+	if (meta)
+		bpf_obj_init(meta->field_offs, p);
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
+BTF_ID_FLAGS(func, bpf_obj_new_impl, KF_ACQUIRE | KF_RET_NULL)
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
index abb2df954f3f..c573282338e1 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -7777,6 +7777,11 @@ static bool is_kfunc_arg_sfx_constant(const struct btf *btf, const struct btf_pa
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
@@ -8045,6 +8050,10 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
 		int kf_arg_type;
 
 		t = btf_type_skip_modifiers(btf, args[i].type, NULL);
+
+		if (is_kfunc_arg_sfx_ignore(btf, &args[i]))
+			continue;
+
 		if (btf_type_is_scalar(t)) {
 			if (reg->type != SCALAR_VALUE) {
 				verbose(env, "R%d is not a scalar\n", regno);
@@ -8222,6 +8231,17 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
 	return 0;
 }
 
+enum special_kfunc_type {
+	KF_bpf_obj_new_impl,
+};
+
+BTF_SET_START(special_kfunc_set)
+BTF_ID(func, bpf_obj_new_impl)
+BTF_SET_END(special_kfunc_set)
+
+BTF_ID_LIST(special_kfunc_list)
+BTF_ID(func, bpf_obj_new_impl)
+
 static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 			    int *insn_idx_p)
 {
@@ -8296,17 +8316,64 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 	t = btf_type_skip_modifiers(desc_btf, func_proto->type, NULL);
 
 	if (is_kfunc_acquire(&meta) && !btf_type_is_struct_ptr(meta.btf, t)) {
-		verbose(env, "acquire kernel function does not return PTR_TO_BTF_ID\n");
-		return -EINVAL;
+		/* Only exception is bpf_obj_new_impl */
+		if (meta.btf != btf_vmlinux || meta.func_id != special_kfunc_list[KF_bpf_obj_new_impl]) {
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
+			if (meta.func_id == special_kfunc_list[KF_bpf_obj_new_impl]) {
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
+					verbose(env, "bpf_obj_new requires prog BTF\n");
+					return -EINVAL;
+				}
+
+				ret_t = btf_type_by_id(ret_btf, ret_btf_id);
+				if (!ret_t || !__btf_type_is_struct(ret_t)) {
+					verbose(env, "bpf_obj_new type ID argument must be of a struct\n");
+					return -EINVAL;
+				}
+
+				mark_reg_known_zero(env, regs, BPF_REG_0);
+				regs[BPF_REG_0].type = PTR_TO_BTF_ID | MEM_TYPE_LOCAL;
+				regs[BPF_REG_0].btf = ret_btf;
+				regs[BPF_REG_0].btf_id = ret_btf_id;
+
+				env->insn_aux_data[insn_idx].obj_new_size = ret_t->size;
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
@@ -8334,6 +8401,7 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 			regs[BPF_REG_0].type = PTR_TO_BTF_ID;
 			regs[BPF_REG_0].btf_id = ptr_type_id;
 		}
+
 		if (is_kfunc_ret_null(&meta)) {
 			regs[BPF_REG_0].type |= PTR_MAYBE_NULL;
 			/* For mark_ptr_or_null_reg, see 93c230e3f5bd6 */
@@ -14472,8 +14540,8 @@ static int fixup_call_args(struct bpf_verifier_env *env)
 	return err;
 }
 
-static int fixup_kfunc_call(struct bpf_verifier_env *env,
-			    struct bpf_insn *insn)
+static int fixup_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
+			    struct bpf_insn *insn_buf, int insn_idx, int *cnt)
 {
 	const struct bpf_kfunc_desc *desc;
 
@@ -14492,8 +14560,21 @@ static int fixup_kfunc_call(struct bpf_verifier_env *env,
 		return -EFAULT;
 	}
 
+	*cnt = 0;
 	insn->imm = desc->imm;
+	if (insn->off)
+		return 0;
+	if (desc->func_id == special_kfunc_list[KF_bpf_obj_new_impl]) {
+		struct btf_struct_meta *kptr_struct_meta = env->insn_aux_data[insn_idx].kptr_struct_meta;
+		struct bpf_insn addr[2] = { BPF_LD_IMM64(BPF_REG_2, (long)kptr_struct_meta) };
+		u64 obj_new_size = env->insn_aux_data[insn_idx].obj_new_size;
 
+		insn_buf[0] = BPF_MOV64_IMM(BPF_REG_1, obj_new_size);
+		insn_buf[1] = addr[0];
+		insn_buf[2] = addr[1];
+		insn_buf[3] = *insn;
+		*cnt = 4;
+	}
 	return 0;
 }
 
@@ -14635,9 +14716,19 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
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
new file mode 100644
index 000000000000..1d3451084a68
--- /dev/null
+++ b/tools/testing/selftests/bpf/bpf_experimental.h
@@ -0,0 +1,20 @@
+#include <vmlinux.h>
+#include <bpf/bpf_tracing.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_core_read.h>
+
+/* Description
+ *	Allocates a local kptr of type represented by 'local_type_id' in program
+ *	BTF. User may use the bpf_core_type_id_local macro to pass the type ID
+ *	of a struct in program BTF.
+ *
+ *	The 'local_type_id' parameter must be a known constant.
+ *	The 'meta' parameter is a hidden argument that is ignored.
+ * Returns
+ *	A local kptr corresponding to passed in 'local_type_id', or NULL on
+ *	failure.
+ */
+extern void *bpf_obj_new_impl(__u64 local_type_id, void *meta) __ksym;
+
+/* Convenience macro to wrap over bpf_obj_new_impl */
+#define bpf_obj_new(type) bpf_obj_new_impl(bpf_core_type_id_local(type), NULL)
-- 
2.38.1

