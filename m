Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F3EA25D74E
	for <lists+bpf@lfdr.de>; Fri,  4 Sep 2020 13:30:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728588AbgIDLaJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 4 Sep 2020 07:30:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730192AbgIDL0C (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 4 Sep 2020 07:26:02 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C86AEC0619C3
        for <bpf@vger.kernel.org>; Fri,  4 Sep 2020 04:24:19 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id a17so6355604wrn.6
        for <bpf@vger.kernel.org>; Fri, 04 Sep 2020 04:24:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Kiip+FIZjsqE39hHxIETodeCupWy6+FqJRJO6QdJavQ=;
        b=m5pEEfuWK/i47r8GC4HjH69neelLfHx4D/S3p2S55G4gj3Jh0QRy9y0/1PQYV9eYyB
         aKRZmwYL2MNVO5pFqavcd1i+O56O+IobqftICmfqVxftEtNYXtuGxHXF2aNmGVxgGuC0
         iPTAiqc8i0F7TR7g0Qo2/4U/s0uwX+EJ8yZLU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Kiip+FIZjsqE39hHxIETodeCupWy6+FqJRJO6QdJavQ=;
        b=RKBk4PH4yfC+UMeDgi1YhhEvJnQSkuHejJIabSLg/hACdvomWYHwT8+dbut6O+2OuX
         uz8Oe6K7yMkufPMx9mn+KQDwoX3+sUaN+6wsuMrWEfvu9RSSd7ZJPIRnncB+uU6OCX5c
         572RMnINhFLFG/bA74pNi6VoAcegwVhRqnkhCyb//dcOXZ+z78swo31UjYMuc/sSdsbg
         Qd4xf2/i78OYq75te/90fycloHzDT6T5YVhAYzoAt5fq+8C6/83KFpgHPg2clj1C90iL
         14i+jw1I/rK6CwG2sjEn1FnLDukQTsJ1+f4cmNyJvPIQuikoFcILNpB7byMFrCktviCC
         Rp2g==
X-Gm-Message-State: AOAM531znDEKOSH5+mayrQbzBdw0jYb0twSUPAaQGLHLVF7XBJSoe4Hx
        PjIuok9Xkz2R8lRm00elFwUph827elJj7w==
X-Google-Smtp-Source: ABdhPJx2nrFAqKs27I/atwrEekRj1bPdRdNV2WyFT1kf0kphK6Nbi55B5xlNjNzhdmivpETB7TNYbg==
X-Received: by 2002:adf:c981:: with SMTP id f1mr7137718wrh.14.1599218658373;
        Fri, 04 Sep 2020 04:24:18 -0700 (PDT)
Received: from antares.lan (111.253.187.81.in-addr.arpa. [81.187.253.111])
        by smtp.gmail.com with ESMTPSA id v2sm9104408wrm.16.2020.09.04.04.24.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2020 04:24:17 -0700 (PDT)
From:   Lorenz Bauer <lmb@cloudflare.com>
To:     ast@kernel.org, yhs@fb.com, daniel@iogearbox.net, kafai@fb.com
Cc:     bpf@vger.kernel.org, kernel-team@cloudflare.com,
        Lorenz Bauer <lmb@cloudflare.com>
Subject: [PATCH bpf-next 05/11] bpf: allow specifying a set of BTF IDs for helper arguments
Date:   Fri,  4 Sep 2020 12:23:55 +0100
Message-Id: <20200904112401.667645-6-lmb@cloudflare.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200904112401.667645-1-lmb@cloudflare.com>
References: <20200904112401.667645-1-lmb@cloudflare.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Function prototypes using ARG_PTR_TO_BTF_ID currently use two ways to signal
which BTF IDs are acceptable. First, bpf_func_proto.btf_id is an array of
IDs, one for each argument. This array is only accessed up to the highest
numbered argument that uses ARG_PTR_TO_BTF_ID and may therefore be less than
five arguments long. It usually points at a BTF_ID_LIST. Second, check_btf_id
is a function pointer that is called by the verifier if present. It gets the
actual BTF ID of the register, and the argument number we're currently checking.
It turns out that the only user check_arg_btf_id ignores the argument, and is
simply used to check whether the BTF ID matches one of the socket types.

Replace both of these mechanisms with explicit btf_id_sets for each argument
in a function proto. The verifier can now check that a PTR_TO_BTF_ID is one
of several IDs, and the code that does the type checking becomes simpler.

Add a small optimisation to btf_set_contains for the common case of a set with
a single entry.

Signed-off-by: Lorenz Bauer <lmb@cloudflare.com>
---
 include/linux/bpf.h            | 22 ++++++++++---------
 kernel/bpf/bpf_inode_storage.c |  8 +++----
 kernel/bpf/btf.c               | 22 ++++++-------------
 kernel/bpf/stackmap.c          |  5 +++--
 kernel/bpf/verifier.c          | 39 +++++++++++++---------------------
 kernel/trace/bpf_trace.c       | 15 +++++++------
 net/core/bpf_sk_storage.c      | 10 +++++----
 net/core/filter.c              | 31 ++++++++++-----------------
 net/ipv4/bpf_tcp_ca.c          | 24 +++++++++------------
 9 files changed, 76 insertions(+), 100 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 6b72cdf52ebc..36276e78dc75 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -31,6 +31,7 @@ struct sock;
 struct seq_file;
 struct btf;
 struct btf_type;
+struct btf_id_set;
 struct exception_table_entry;
 struct seq_operations;
 struct bpf_iter_aux_info;
@@ -326,12 +327,16 @@ struct bpf_func_proto {
 		};
 		enum bpf_arg_type arg_type[5];
 	};
-	int *btf_id; /* BTF ids of arguments */
-	bool (*check_btf_id)(u32 btf_id, u32 arg); /* if the argument btf_id is
-						    * valid. Often used if more
-						    * than one btf id is permitted
-						    * for this argument.
-						    */
+	union {
+		struct {
+			struct btf_id_set *arg1_btf_ids;
+			struct btf_id_set *arg2_btf_ids;
+			struct btf_id_set *arg3_btf_ids;
+			struct btf_id_set *arg4_btf_ids;
+			struct btf_id_set *arg5_btf_ids;
+		};
+		struct btf_id_set *arg_btf_ids[5];
+	};
 	int *ret_btf_id; /* return value btf_id */
 	bool (*allowed)(const struct bpf_prog *prog);
 };
@@ -1379,9 +1384,7 @@ int btf_struct_access(struct bpf_verifier_log *log,
 		      enum bpf_access_type atype,
 		      u32 *next_btf_id);
 bool btf_struct_ids_match(struct bpf_verifier_log *log,
-			  int off, u32 id, u32 need_type_id);
-int btf_resolve_helper_id(struct bpf_verifier_log *log,
-			  const struct bpf_func_proto *fn, int);
+			  int off, u32 id, const struct btf_id_set *needed);
 
 int btf_distill_func_proto(struct bpf_verifier_log *log,
 			   struct btf *btf,
@@ -1899,7 +1902,6 @@ enum bpf_text_poke_type {
 int bpf_arch_text_poke(void *ip, enum bpf_text_poke_type t,
 		       void *addr1, void *addr2);
 
-struct btf_id_set;
 bool btf_id_set_contains(const struct btf_id_set *set, u32 id);
 
 #endif /* _LINUX_BPF_H */
diff --git a/kernel/bpf/bpf_inode_storage.c b/kernel/bpf/bpf_inode_storage.c
index 75be02799c0f..d447d2655cce 100644
--- a/kernel/bpf/bpf_inode_storage.c
+++ b/kernel/bpf/bpf_inode_storage.c
@@ -249,9 +249,9 @@ const struct bpf_map_ops inode_storage_map_ops = {
 	.map_owner_storage_ptr = inode_storage_ptr,
 };
 
-BTF_ID_LIST(bpf_inode_storage_btf_ids)
-BTF_ID_UNUSED
+BTF_SET_START(bpf_inode_storage_btf_ids)
 BTF_ID(struct, inode)
+BTF_SET_END(bpf_inode_storage_btf_ids)
 
 const struct bpf_func_proto bpf_inode_storage_get_proto = {
 	.func		= bpf_inode_storage_get,
@@ -259,9 +259,9 @@ const struct bpf_func_proto bpf_inode_storage_get_proto = {
 	.ret_type	= RET_PTR_TO_MAP_VALUE_OR_NULL,
 	.arg1_type	= ARG_CONST_MAP_PTR,
 	.arg2_type	= ARG_PTR_TO_BTF_ID,
+	.arg2_btf_ids	= &bpf_inode_storage_btf_ids,
 	.arg3_type	= ARG_PTR_TO_MAP_VALUE_OR_NULL,
 	.arg4_type	= ARG_ANYTHING,
-	.btf_id		= bpf_inode_storage_btf_ids,
 };
 
 const struct bpf_func_proto bpf_inode_storage_delete_proto = {
@@ -270,5 +270,5 @@ const struct bpf_func_proto bpf_inode_storage_delete_proto = {
 	.ret_type	= RET_INTEGER,
 	.arg1_type	= ARG_CONST_MAP_PTR,
 	.arg2_type	= ARG_PTR_TO_BTF_ID,
-	.btf_id		= bpf_inode_storage_btf_ids,
+	.arg2_btf_ids	= &bpf_inode_storage_btf_ids,
 };
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index a2330f6fe2e6..dec7f03b9229 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -4163,13 +4163,13 @@ int btf_struct_access(struct bpf_verifier_log *log,
 }
 
 bool btf_struct_ids_match(struct bpf_verifier_log *log,
-			  int off, u32 id, u32 need_type_id)
+			  int off, u32 id, const struct btf_id_set *needed)
 {
 	const struct btf_type *type;
 	int err;
 
 	/* Are we already done? */
-	if (need_type_id == id && off == 0)
+	if (off == 0 && btf_id_set_contains(needed, id))
 		return true;
 
 again:
@@ -4185,7 +4185,7 @@ bool btf_struct_ids_match(struct bpf_verifier_log *log,
 	 * continue the search with offset 0 in the new
 	 * type.
 	 */
-	if (need_type_id != id) {
+	if (!btf_id_set_contains(needed, id)) {
 		off = 0;
 		goto again;
 	}
@@ -4193,19 +4193,6 @@ bool btf_struct_ids_match(struct bpf_verifier_log *log,
 	return true;
 }
 
-int btf_resolve_helper_id(struct bpf_verifier_log *log,
-			  const struct bpf_func_proto *fn, int arg)
-{
-	int id;
-
-	if (fn->arg_type[arg] != ARG_PTR_TO_BTF_ID || !btf_vmlinux)
-		return -EINVAL;
-	id = fn->btf_id[arg];
-	if (!id || id > btf_vmlinux->nr_types)
-		return -EINVAL;
-	return id;
-}
-
 static int __get_type_size(struct btf *btf, u32 btf_id,
 			   const struct btf_type **bad_type)
 {
@@ -4774,5 +4761,8 @@ static int btf_id_cmp_func(const void *a, const void *b)
 
 bool btf_id_set_contains(const struct btf_id_set *set, u32 id)
 {
+	if (set->cnt == 1)
+		return set->ids[0] == id;
+
 	return bsearch(&id, set->ids, set->cnt, sizeof(u32), btf_id_cmp_func) != NULL;
 }
diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
index a2fa006f430e..3142e8aab4ed 100644
--- a/kernel/bpf/stackmap.c
+++ b/kernel/bpf/stackmap.c
@@ -665,18 +665,19 @@ BPF_CALL_4(bpf_get_task_stack, struct task_struct *, task, void *, buf,
 	return __bpf_get_stack(regs, task, NULL, buf, size, flags);
 }
 
-BTF_ID_LIST(bpf_get_task_stack_btf_ids)
+BTF_SET_START(bpf_get_task_stack_btf_ids)
 BTF_ID(struct, task_struct)
+BTF_SET_END(bpf_get_task_stack_btf_ids)
 
 const struct bpf_func_proto bpf_get_task_stack_proto = {
 	.func		= bpf_get_task_stack,
 	.gpl_only	= false,
 	.ret_type	= RET_INTEGER,
 	.arg1_type	= ARG_PTR_TO_BTF_ID,
+	.arg1_btf_ids	= &bpf_get_task_stack_btf_ids,
 	.arg2_type	= ARG_PTR_TO_UNINIT_MEM,
 	.arg3_type	= ARG_CONST_SIZE_OR_ZERO,
 	.arg4_type	= ARG_ANYTHING,
-	.btf_id		= bpf_get_task_stack_btf_ids,
 };
 
 BPF_CALL_4(bpf_get_stack_pe, struct bpf_perf_event_data_kern *, ctx,
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 649bcfb4535e..45759638e1b8 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -238,7 +238,6 @@ struct bpf_call_arg_meta {
 	u64 msize_max_value;
 	int ref_obj_id;
 	int func_id;
-	u32 btf_id;
 };
 
 struct btf *btf_vmlinux;
@@ -3906,8 +3905,9 @@ static int resolve_map_arg_type(struct bpf_verifier_env *env,
 	return 0;
 }
 
-BTF_ID_LIST(btf_fullsock_ids)
+BTF_SET_START(btf_fullsock_ids)
 BTF_ID(struct, sock)
+BTF_SET_END(btf_fullsock_ids)
 
 static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 			  struct bpf_call_arg_meta *meta,
@@ -3917,6 +3917,7 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 	struct bpf_reg_state *regs = cur_regs(env), *reg = &regs[regno];
 	enum bpf_reg_type expected_type, type = reg->type;
 	enum bpf_arg_type arg_type = fn->arg_type[arg];
+	const struct btf_id_set *btf_ids = NULL;
 	int err = 0;
 
 	if (arg_type == ARG_DONTCARE)
@@ -4005,7 +4006,7 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 			    type != PTR_TO_BTF_ID)
 				goto err_type;
 		}
-		meta->btf_id = btf_fullsock_ids[0];
+		btf_ids = &btf_fullsock_ids;
 	} else if (arg_type == ARG_PTR_TO_BTF_ID) {
 		expected_type = PTR_TO_BTF_ID;
 		if (type != expected_type)
@@ -4065,26 +4066,21 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 	}
 
 	if (type == PTR_TO_BTF_ID) {
-		bool ids_match = false;
+		if (fn->arg_btf_ids[arg])
+			btf_ids = fn->arg_btf_ids[arg];
 
-		if (!fn->check_btf_id) {
-			if (reg->btf_id != meta->btf_id) {
-				ids_match = btf_struct_ids_match(&env->log, reg->off, reg->btf_id,
-								 meta->btf_id);
-				if (!ids_match) {
-					verbose(env, "Helper has type %s got %s in R%d\n",
-						kernel_type_name(meta->btf_id),
-						kernel_type_name(reg->btf_id), regno);
-					return -EACCES;
-				}
-			}
-		} else if (!fn->check_btf_id(reg->btf_id, arg)) {
-			verbose(env, "Helper does not support %s in R%d\n",
-				kernel_type_name(reg->btf_id), regno);
+		if (!btf_ids) {
+			verbose(env, "verifier internal error: missing BTF IDs\n");
+			return -EFAULT;
+		}
 
+		if (!btf_struct_ids_match(&env->log, reg->off, reg->btf_id,
+					  btf_ids)) {
+			verbose(env, "R%d has incompatible type %s\n", regno,
+				kernel_type_name(reg->btf_id));
 			return -EACCES;
 		}
-		if ((reg->off && !ids_match) || !tnum_is_const(reg->var_off) || reg->var_off.value) {
+		if (!tnum_is_const(reg->var_off) || reg->var_off.value) {
 			verbose(env, "R%d is a pointer to in-kernel struct with non-zero offset\n",
 				regno);
 			return -EACCES;
@@ -4903,11 +4899,6 @@ static int check_helper_call(struct bpf_verifier_env *env, int func_id, int insn
 	meta.func_id = func_id;
 	/* check args */
 	for (i = 0; i < 5; i++) {
-		if (!fn->check_btf_id) {
-			err = btf_resolve_helper_id(&env->log, fn, i);
-			if (err > 0)
-				meta.btf_id = err;
-		}
 		err = check_func_arg(env, i, &meta, fn);
 		if (err)
 			return err;
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index b2a5380eb187..92b3e50ad516 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -743,19 +743,20 @@ BPF_CALL_5(bpf_seq_printf, struct seq_file *, m, char *, fmt, u32, fmt_size,
 	return err;
 }
 
-BTF_ID_LIST(bpf_seq_printf_btf_ids)
+BTF_SET_START(bpf_seq_printf_btf_ids)
 BTF_ID(struct, seq_file)
+BTF_SET_END(bpf_seq_printf_btf_ids)
 
 static const struct bpf_func_proto bpf_seq_printf_proto = {
 	.func		= bpf_seq_printf,
 	.gpl_only	= true,
 	.ret_type	= RET_INTEGER,
 	.arg1_type	= ARG_PTR_TO_BTF_ID,
+	.arg1_btf_ids	= &bpf_seq_printf_btf_ids,
 	.arg2_type	= ARG_PTR_TO_MEM,
 	.arg3_type	= ARG_CONST_SIZE,
 	.arg4_type      = ARG_PTR_TO_MEM_OR_NULL,
 	.arg5_type      = ARG_CONST_SIZE_OR_ZERO,
-	.btf_id		= bpf_seq_printf_btf_ids,
 };
 
 BPF_CALL_3(bpf_seq_write, struct seq_file *, m, const void *, data, u32, len)
@@ -763,17 +764,18 @@ BPF_CALL_3(bpf_seq_write, struct seq_file *, m, const void *, data, u32, len)
 	return seq_write(m, data, len) ? -EOVERFLOW : 0;
 }
 
-BTF_ID_LIST(bpf_seq_write_btf_ids)
+BTF_SET_START(bpf_seq_write_btf_ids)
 BTF_ID(struct, seq_file)
+BTF_SET_END(bpf_seq_write_btf_ids)
 
 static const struct bpf_func_proto bpf_seq_write_proto = {
 	.func		= bpf_seq_write,
 	.gpl_only	= true,
 	.ret_type	= RET_INTEGER,
 	.arg1_type	= ARG_PTR_TO_BTF_ID,
+	.arg1_btf_ids	= &bpf_seq_write_btf_ids,
 	.arg2_type	= ARG_PTR_TO_MEM,
 	.arg3_type	= ARG_CONST_SIZE_OR_ZERO,
-	.btf_id		= bpf_seq_write_btf_ids,
 };
 
 static __always_inline int
@@ -1130,17 +1132,18 @@ static bool bpf_d_path_allowed(const struct bpf_prog *prog)
 	return btf_id_set_contains(&btf_allowlist_d_path, prog->aux->attach_btf_id);
 }
 
-BTF_ID_LIST(bpf_d_path_btf_ids)
+BTF_SET_START(bpf_d_path_btf_ids)
 BTF_ID(struct, path)
+BTF_SET_END(bpf_d_path_btf_ids)
 
 static const struct bpf_func_proto bpf_d_path_proto = {
 	.func		= bpf_d_path,
 	.gpl_only	= false,
 	.ret_type	= RET_INTEGER,
 	.arg1_type	= ARG_PTR_TO_BTF_ID,
+	.arg1_btf_ids	= &bpf_d_path_btf_ids,
 	.arg2_type	= ARG_PTR_TO_MEM,
 	.arg3_type	= ARG_CONST_SIZE_OR_ZERO,
-	.btf_id		= bpf_d_path_btf_ids,
 	.allowed	= bpf_d_path_allowed,
 };
 
diff --git a/net/core/bpf_sk_storage.c b/net/core/bpf_sk_storage.c
index a0d1a3265b71..cfd3b81366f4 100644
--- a/net/core/bpf_sk_storage.c
+++ b/net/core/bpf_sk_storage.c
@@ -357,6 +357,7 @@ const struct bpf_func_proto bpf_sk_storage_get_proto = {
 	.ret_type	= RET_PTR_TO_MAP_VALUE_OR_NULL,
 	.arg1_type	= ARG_CONST_MAP_PTR,
 	.arg2_type	= ARG_PTR_TO_SOCKET,
+	.arg2_btf_ids	= &btf_sock_ids_set,
 	.arg3_type	= ARG_PTR_TO_MAP_VALUE_OR_NULL,
 	.arg4_type	= ARG_ANYTHING,
 };
@@ -377,11 +378,12 @@ const struct bpf_func_proto bpf_sk_storage_delete_proto = {
 	.ret_type	= RET_INTEGER,
 	.arg1_type	= ARG_CONST_MAP_PTR,
 	.arg2_type	= ARG_PTR_TO_SOCKET,
+	.arg2_btf_ids	= &btf_sock_ids_set,
 };
 
-BTF_ID_LIST(sk_storage_btf_ids)
-BTF_ID_UNUSED
+BTF_SET_START(sk_storage_btf_ids)
 BTF_ID(struct, sock)
+BTF_SET_END(sk_storage_btf_ids)
 
 const struct bpf_func_proto sk_storage_get_btf_proto = {
 	.func		= bpf_sk_storage_get,
@@ -389,9 +391,9 @@ const struct bpf_func_proto sk_storage_get_btf_proto = {
 	.ret_type	= RET_PTR_TO_MAP_VALUE_OR_NULL,
 	.arg1_type	= ARG_CONST_MAP_PTR,
 	.arg2_type	= ARG_PTR_TO_BTF_ID,
+	.arg2_btf_ids	= &sk_storage_btf_ids,
 	.arg3_type	= ARG_PTR_TO_MAP_VALUE_OR_NULL,
 	.arg4_type	= ARG_ANYTHING,
-	.btf_id		= sk_storage_btf_ids,
 };
 
 const struct bpf_func_proto sk_storage_delete_btf_proto = {
@@ -400,7 +402,7 @@ const struct bpf_func_proto sk_storage_delete_btf_proto = {
 	.ret_type	= RET_INTEGER,
 	.arg1_type	= ARG_CONST_MAP_PTR,
 	.arg2_type	= ARG_PTR_TO_BTF_ID,
-	.btf_id		= sk_storage_btf_ids,
+	.arg2_btf_ids	= &sk_storage_btf_ids,
 };
 
 struct bpf_sk_storage_diag {
diff --git a/net/core/filter.c b/net/core/filter.c
index c7f96cfea1b0..0f25ce7485db 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -3803,19 +3803,20 @@ static const struct bpf_func_proto bpf_skb_event_output_proto = {
 	.arg5_type	= ARG_CONST_SIZE_OR_ZERO,
 };
 
-BTF_ID_LIST(bpf_skb_output_btf_ids)
+BTF_SET_START(bpf_skb_output_btf_ids)
 BTF_ID(struct, sk_buff)
+BTF_SET_END(bpf_skb_output_btf_ids)
 
 const struct bpf_func_proto bpf_skb_output_proto = {
 	.func		= bpf_skb_event_output,
 	.gpl_only	= true,
 	.ret_type	= RET_INTEGER,
 	.arg1_type	= ARG_PTR_TO_BTF_ID,
+	.arg1_btf_ids	= &bpf_skb_output_btf_ids,
 	.arg2_type	= ARG_CONST_MAP_PTR,
 	.arg3_type	= ARG_ANYTHING,
 	.arg4_type	= ARG_PTR_TO_MEM,
 	.arg5_type	= ARG_CONST_SIZE_OR_ZERO,
-	.btf_id		= bpf_skb_output_btf_ids,
 };
 
 static unsigned short bpf_tunnel_key_af(u64 flags)
@@ -4199,19 +4200,20 @@ static const struct bpf_func_proto bpf_xdp_event_output_proto = {
 	.arg5_type	= ARG_CONST_SIZE_OR_ZERO,
 };
 
-BTF_ID_LIST(bpf_xdp_output_btf_ids)
+BTF_SET_START(bpf_xdp_output_btf_ids)
 BTF_ID(struct, xdp_buff)
+BTF_SET_END(bpf_xdp_output_btf_ids)
 
 const struct bpf_func_proto bpf_xdp_output_proto = {
 	.func		= bpf_xdp_event_output,
 	.gpl_only	= true,
 	.ret_type	= RET_INTEGER,
 	.arg1_type	= ARG_PTR_TO_BTF_ID,
+	.arg1_btf_ids	= &bpf_xdp_output_btf_ids,
 	.arg2_type	= ARG_CONST_MAP_PTR,
 	.arg3_type	= ARG_ANYTHING,
 	.arg4_type	= ARG_PTR_TO_MEM,
 	.arg5_type	= ARG_CONST_SIZE_OR_ZERO,
-	.btf_id		= bpf_xdp_output_btf_ids,
 };
 
 BPF_CALL_1(bpf_get_socket_cookie, struct sk_buff *, skb)
@@ -9914,17 +9916,6 @@ u32 btf_sock_ids[MAX_BTF_SOCK_TYPE];
 struct btf_id_set btf_sock_ids_set;
 #endif
 
-static bool check_arg_btf_id(u32 btf_id, u32 arg)
-{
-	int i;
-
-	/* only one argument, no need to check arg */
-	for (i = 0; i < MAX_BTF_SOCK_TYPE; i++)
-		if (btf_sock_ids[i] == btf_id)
-			return true;
-	return false;
-}
-
 BPF_CALL_1(bpf_skc_to_tcp6_sock, struct sock *, sk)
 {
 	/* tcp6_sock type is not generated in dwarf and hence btf,
@@ -9943,7 +9934,7 @@ const struct bpf_func_proto bpf_skc_to_tcp6_sock_proto = {
 	.gpl_only		= false,
 	.ret_type		= RET_PTR_TO_BTF_ID_OR_NULL,
 	.arg1_type		= ARG_PTR_TO_BTF_ID,
-	.check_btf_id		= check_arg_btf_id,
+	.arg1_btf_ids		= &btf_sock_ids_set,
 	.ret_btf_id		= &btf_sock_ids[BTF_SOCK_TYPE_TCP6],
 };
 
@@ -9960,7 +9951,7 @@ const struct bpf_func_proto bpf_skc_to_tcp_sock_proto = {
 	.gpl_only		= false,
 	.ret_type		= RET_PTR_TO_BTF_ID_OR_NULL,
 	.arg1_type		= ARG_PTR_TO_BTF_ID,
-	.check_btf_id		= check_arg_btf_id,
+	.arg1_btf_ids		= &btf_sock_ids_set,
 	.ret_btf_id		= &btf_sock_ids[BTF_SOCK_TYPE_TCP],
 };
 
@@ -9984,7 +9975,7 @@ const struct bpf_func_proto bpf_skc_to_tcp_timewait_sock_proto = {
 	.gpl_only		= false,
 	.ret_type		= RET_PTR_TO_BTF_ID_OR_NULL,
 	.arg1_type		= ARG_PTR_TO_BTF_ID,
-	.check_btf_id		= check_arg_btf_id,
+	.arg1_btf_ids		= &btf_sock_ids_set,
 	.ret_btf_id		= &btf_sock_ids[BTF_SOCK_TYPE_TCP_TW],
 };
 
@@ -10008,7 +9999,7 @@ const struct bpf_func_proto bpf_skc_to_tcp_request_sock_proto = {
 	.gpl_only		= false,
 	.ret_type		= RET_PTR_TO_BTF_ID_OR_NULL,
 	.arg1_type		= ARG_PTR_TO_BTF_ID,
-	.check_btf_id		= check_arg_btf_id,
+	.arg1_btf_ids		= &btf_sock_ids_set,
 	.ret_btf_id		= &btf_sock_ids[BTF_SOCK_TYPE_TCP_REQ],
 };
 
@@ -10030,6 +10021,6 @@ const struct bpf_func_proto bpf_skc_to_udp6_sock_proto = {
 	.gpl_only		= false,
 	.ret_type		= RET_PTR_TO_BTF_ID_OR_NULL,
 	.arg1_type		= ARG_PTR_TO_BTF_ID,
-	.check_btf_id		= check_arg_btf_id,
+	.arg1_btf_ids		= &btf_sock_ids_set,
 	.ret_btf_id		= &btf_sock_ids[BTF_SOCK_TYPE_UDP6],
 };
diff --git a/net/ipv4/bpf_tcp_ca.c b/net/ipv4/bpf_tcp_ca.c
index e3939f76b024..37a890440f46 100644
--- a/net/ipv4/bpf_tcp_ca.c
+++ b/net/ipv4/bpf_tcp_ca.c
@@ -5,6 +5,7 @@
 #include <linux/bpf_verifier.h>
 #include <linux/bpf.h>
 #include <linux/btf.h>
+#include <linux/btf_ids.h>
 #include <linux/filter.h>
 #include <net/tcp.h>
 #include <net/bpf_sk_storage.h>
@@ -28,23 +29,22 @@ static u32 unsupported_ops[] = {
 static const struct btf_type *tcp_sock_type;
 static u32 tcp_sock_id, sock_id;
 
-static int btf_sk_storage_get_ids[5];
+BTF_SET_START(btf_tcp_sock_ids)
+BTF_ID(struct, tcp_sock)
+BTF_SET_END(btf_tcp_sock_ids)
+
 static struct bpf_func_proto btf_sk_storage_get_proto __read_mostly;
-
-static int btf_sk_storage_delete_ids[5];
 static struct bpf_func_proto btf_sk_storage_delete_proto __read_mostly;
 
-static void convert_sk_func_proto(struct bpf_func_proto *to, int *to_btf_ids,
-				  const struct bpf_func_proto *from)
+static void convert_sk_func_proto(struct bpf_func_proto *to, const struct bpf_func_proto *from)
 {
 	int i;
 
 	*to = *from;
-	to->btf_id = to_btf_ids;
 	for (i = 0; i < ARRAY_SIZE(to->arg_type); i++) {
 		if (to->arg_type[i] == ARG_PTR_TO_SOCKET) {
 			to->arg_type[i] = ARG_PTR_TO_BTF_ID;
-			to->btf_id[i] = tcp_sock_id;
+			to->arg_btf_ids[i] = &btf_tcp_sock_ids;
 		}
 	}
 }
@@ -64,12 +64,8 @@ static int bpf_tcp_ca_init(struct btf *btf)
 	tcp_sock_id = type_id;
 	tcp_sock_type = btf_type_by_id(btf, tcp_sock_id);
 
-	convert_sk_func_proto(&btf_sk_storage_get_proto,
-			      btf_sk_storage_get_ids,
-			      &bpf_sk_storage_get_proto);
-	convert_sk_func_proto(&btf_sk_storage_delete_proto,
-			      btf_sk_storage_delete_ids,
-			      &bpf_sk_storage_delete_proto);
+	convert_sk_func_proto(&btf_sk_storage_get_proto, &bpf_sk_storage_get_proto);
+	convert_sk_func_proto(&btf_sk_storage_delete_proto, &bpf_sk_storage_delete_proto);
 
 	return 0;
 }
@@ -185,8 +181,8 @@ static const struct bpf_func_proto bpf_tcp_send_ack_proto = {
 	/* In case we want to report error later */
 	.ret_type	= RET_INTEGER,
 	.arg1_type	= ARG_PTR_TO_BTF_ID,
+	.arg1_btf_ids	= &btf_tcp_sock_ids,
 	.arg2_type	= ARG_ANYTHING,
-	.btf_id		= &tcp_sock_id,
 };
 
 static const struct bpf_func_proto *
-- 
2.25.1

