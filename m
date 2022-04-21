Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCCD350A1B3
	for <lists+bpf@lfdr.de>; Thu, 21 Apr 2022 16:11:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1388919AbiDUOKr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 21 Apr 2022 10:10:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1388836AbiDUOKq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 21 Apr 2022 10:10:46 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 42FE8CEC
        for <bpf@vger.kernel.org>; Thu, 21 Apr 2022 07:07:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650550075;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JIjr0urOagl6nMCKhpT15LSSd3dxsS8pMPdmUwlLi7c=;
        b=MTp6eFOzFQxUL10bPPc1Om7l1dACLuS0n3pvb9zPkG4wGZu+YMHfcH4mphT+QFCIe5DRT7
        uLXaI7RrQ2PCguqYFcJUyzWAwoGAP7yQvUuqhV3DQz+AWHzT3OL4jd+l/7VZuLsCfDLUhk
        fN2BFExz57B3Mo4ycpls/KGZ4JrBk8s=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-362-L-PgWhWNP9aLrd3V_GHjFw-1; Thu, 21 Apr 2022 10:07:51 -0400
X-MC-Unique: L-PgWhWNP9aLrd3V_GHjFw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 602EF800B28;
        Thu, 21 Apr 2022 14:07:50 +0000 (UTC)
Received: from plouf.redhat.com (unknown [10.39.194.205])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 519FF40EC002;
        Thu, 21 Apr 2022 14:07:48 +0000 (UTC)
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
To:     Greg KH <gregkh@linuxfoundation.org>,
        Jiri Kosina <jikos@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>
Cc:     Tero Kristo <tero.kristo@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        bpf@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [RFC bpf-next v4 2/7] bpf/verifier: allow kfunc to return an allocated mem
Date:   Thu, 21 Apr 2022 16:07:35 +0200
Message-Id: <20220421140740.459558-3-benjamin.tissoires@redhat.com>
In-Reply-To: <20220421140740.459558-1-benjamin.tissoires@redhat.com>
References: <20220421140740.459558-1-benjamin.tissoires@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.2
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

When a kfunc is not returning a pointer to a struct but to a plain type,
check if one of the arguments is called __sz and is a const from the
caller, and use this as the size of the allocated memory.

For tracing programs, we consider the provided memory to be read only
unless the program is BPF_MODIFY_RETURN.

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

---

new in v4
---
 include/linux/btf.h   |  6 ++++
 kernel/bpf/btf.c      | 31 ++++++++++++++++----
 kernel/bpf/verifier.c | 66 +++++++++++++++++++++++++++++++++----------
 3 files changed, 83 insertions(+), 20 deletions(-)

diff --git a/include/linux/btf.h b/include/linux/btf.h
index 36bc09b8e890..76a3ff48ae2a 100644
--- a/include/linux/btf.h
+++ b/include/linux/btf.h
@@ -332,6 +332,12 @@ static inline struct btf_param *btf_params(const struct btf_type *t)
 	return (struct btf_param *)(t + 1);
 }
 
+struct bpf_reg_state;
+
+bool btf_is_kfunc_arg_mem_size(const struct btf *btf,
+			       const struct btf_param *arg,
+			       const struct bpf_reg_state *reg);
+
 #ifdef CONFIG_BPF_SYSCALL
 struct bpf_prog;
 
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 76318a4c2d0e..22e6e3cdc7ee 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -5851,9 +5851,9 @@ static bool __btf_type_is_scalar_struct(struct bpf_verifier_log *log,
 	return true;
 }
 
-static bool is_kfunc_arg_mem_size(const struct btf *btf,
-				  const struct btf_param *arg,
-				  const struct bpf_reg_state *reg)
+bool btf_is_kfunc_arg_mem_size(const struct btf *btf,
+			       const struct btf_param *arg,
+			       const struct bpf_reg_state *reg)
 {
 	int len, sfx_len = sizeof("__sz") - 1;
 	const struct btf_type *t;
@@ -5976,7 +5976,7 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env,
 				reg_btf = reg->btf;
 				reg_ref_id = reg->btf_id;
 				/* Ensure only one argument is referenced
-				 * PTR_TO_BTF_ID, check_func_arg_reg_off relies
+				 * PTR_TO_BTF_ID or PTR_TO_MEM, check_func_arg_reg_off relies
 				 * on only one referenced register being allowed
 				 * for kfuncs.
 				 */
@@ -6012,7 +6012,10 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env,
 			u32 type_size;
 
 			if (is_kfunc) {
-				bool arg_mem_size = i + 1 < nargs && is_kfunc_arg_mem_size(btf, &args[i + 1], &regs[regno + 1]);
+				bool arg_mem_size = i + 1 < nargs &&
+						    btf_is_kfunc_arg_mem_size(btf,
+									      &args[i + 1],
+									      &regs[regno + 1]);
 
 				/* Permit pointer to mem, but only when argument
 				 * type is pointer to scalar, or struct composed
@@ -6039,6 +6042,24 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env,
 					i++;
 					continue;
 				}
+
+				if (rel && reg->ref_obj_id) {
+					/* Ensure only one argument is referenced
+					 * PTR_TO_BTF_ID or PTR_TO_MEM, check_func_arg_reg_off
+					 * relies on only one referenced register being allowed
+					 * for kfuncs.
+					 */
+					if (ref_obj_id) {
+						bpf_log(log,
+							"verifier internal error: more than one arg with ref_obj_id R%d %u %u\n",
+							regno,
+							reg->ref_obj_id,
+							ref_obj_id);
+						return -EFAULT;
+					}
+					ref_regno = regno;
+					ref_obj_id = reg->ref_obj_id;
+				}
 			}
 
 			resolve_ret = btf_resolve_size(btf, ref_t, &type_size);
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 71827d14724a..0f339f9058f3 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -6974,7 +6974,9 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 	int err, insn_idx = *insn_idx_p;
 	const struct btf_param *args;
 	struct btf *desc_btf;
+	enum bpf_prog_type prog_type = resolve_prog_type(env->prog);
 	bool acq;
+	size_t reg_size = 0;
 
 	/* skip for now, but return error when we find this in fixup_kfunc_call */
 	if (!insn->imm)
@@ -7015,8 +7017,8 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 		}
 	}
 
-	for (i = 0; i < CALLER_SAVED_REGS; i++)
-		mark_reg_not_init(env, regs, caller_saved[i]);
+	/* reset REG_0 */
+	mark_reg_not_init(env, regs, BPF_REG_0);
 
 	/* Check return type */
 	t = btf_type_skip_modifiers(desc_btf, func_proto->type, NULL);
@@ -7026,6 +7028,9 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 		return -EINVAL;
 	}
 
+	nargs = btf_type_vlen(func_proto);
+	args = btf_params(func_proto);
+
 	if (btf_type_is_scalar(t)) {
 		mark_reg_unknown(env, regs, BPF_REG_0);
 		mark_btf_func_reg_size(env, BPF_REG_0, t->size);
@@ -7033,24 +7038,54 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 		ptr_type = btf_type_skip_modifiers(desc_btf, t->type,
 						   &ptr_type_id);
 		if (!btf_type_is_struct(ptr_type)) {
-			ptr_type_name = btf_name_by_offset(desc_btf,
-							   ptr_type->name_off);
-			verbose(env, "kernel function %s returns pointer type %s %s is not supported\n",
-				func_name, btf_type_str(ptr_type),
-				ptr_type_name);
-			return -EINVAL;
+			/* if we have an array, we must have a const argument named "__sz" */
+			for (i = 0; i < nargs; i++) {
+				u32 regno = i + BPF_REG_1;
+				struct bpf_reg_state *reg = &regs[regno];
+
+				/* look for any const scalar parameter of name "__sz" */
+				if (!check_reg_arg(env, regno, SRC_OP) &&
+				    tnum_is_const(regs[regno].var_off) &&
+				    btf_is_kfunc_arg_mem_size(desc_btf, &args[i], reg))
+					reg_size = regs[regno].var_off.value;
+			}
+
+			if (!reg_size) {
+				ptr_type_name = btf_name_by_offset(desc_btf,
+								   ptr_type->name_off);
+				verbose(env,
+					"kernel function %s returns pointer type %s %s is not supported\n",
+					func_name,
+					btf_type_str(ptr_type),
+					ptr_type_name);
+				return -EINVAL;
+			}
+
+			mark_reg_known_zero(env, regs, BPF_REG_0);
+			regs[BPF_REG_0].type = PTR_TO_MEM;
+			regs[BPF_REG_0].mem_size = reg_size;
+
+			/* in case of tracing, only allow write access to
+			 * BPF_MODIFY_RETURN programs
+			 */
+			if (prog_type == BPF_PROG_TYPE_TRACING &&
+			    env->prog->expected_attach_type != BPF_MODIFY_RETURN)
+				regs[BPF_REG_0].type |= MEM_RDONLY;
+		} else {
+			mark_reg_known_zero(env, regs, BPF_REG_0);
+			regs[BPF_REG_0].type = PTR_TO_BTF_ID;
+			regs[BPF_REG_0].btf = desc_btf;
+			regs[BPF_REG_0].btf_id = ptr_type_id;
+			mark_btf_func_reg_size(env, BPF_REG_0, sizeof(void *));
 		}
-		mark_reg_known_zero(env, regs, BPF_REG_0);
-		regs[BPF_REG_0].btf = desc_btf;
-		regs[BPF_REG_0].type = PTR_TO_BTF_ID;
-		regs[BPF_REG_0].btf_id = ptr_type_id;
+
 		if (btf_kfunc_id_set_contains(desc_btf, resolve_prog_type(env->prog),
 					      BTF_KFUNC_TYPE_RET_NULL, func_id)) {
 			regs[BPF_REG_0].type |= PTR_MAYBE_NULL;
 			/* For mark_ptr_or_null_reg, see 93c230e3f5bd6 */
 			regs[BPF_REG_0].id = ++env->id_gen;
 		}
-		mark_btf_func_reg_size(env, BPF_REG_0, sizeof(void *));
+
 		if (acq) {
 			int id = acquire_reference_state(env, insn_idx);
 
@@ -7061,8 +7096,9 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 		}
 	} /* else { add_kfunc_call() ensures it is btf_type_is_void(t) } */
 
-	nargs = btf_type_vlen(func_proto);
-	args = (const struct btf_param *)(func_proto + 1);
+	for (i = 1 ; i < CALLER_SAVED_REGS; i++)
+		mark_reg_not_init(env, regs, caller_saved[i]);
+
 	for (i = 0; i < nargs; i++) {
 		u32 regno = i + 1;
 
-- 
2.35.1

