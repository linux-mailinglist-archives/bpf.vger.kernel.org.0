Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40B0E626201
	for <lists+bpf@lfdr.de>; Fri, 11 Nov 2022 20:33:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233096AbiKKTdu (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 11 Nov 2022 14:33:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233878AbiKKTdt (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 11 Nov 2022 14:33:49 -0500
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EDCAFCD0
        for <bpf@vger.kernel.org>; Fri, 11 Nov 2022 11:33:48 -0800 (PST)
Received: by mail-pl1-x643.google.com with SMTP id p21so4969899plr.7
        for <bpf@vger.kernel.org>; Fri, 11 Nov 2022 11:33:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/EGc1pHleAs/SoS9r6ncZf8V6a43PizugzUT5QRzGdA=;
        b=M2fIwbt/z7fOdSEykeQXw9PwhD6zK0O884LGWvSR7l5Iry5XVljlQGV44Jag4tYE7o
         sOdKUTQ82ABXI9dBffRsUOgQhxg7DkL1avm8+oh8BSVddRr+rQP+8JfzBu1BzbaMVm0U
         NxKQhp0YMwafsrTgkXc/d293vKcXByfv1cLF91FdlCCUWStBGwHZE/287z+L82gDKDMz
         0z+AVBWXQBGCoTYM+c8/oc+unYA6wtD/7xefXU6wgPaXxSWIjx8zimZLl6ftuW6PSnbp
         OATu5nhE84Z/I++Sxr1RvjW38rQpbpeUfQCO2bxxbU8zfSuo71haO55efC5dbtqZChsD
         fy7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/EGc1pHleAs/SoS9r6ncZf8V6a43PizugzUT5QRzGdA=;
        b=QqNCAf0/SPNwBgVmtVtAtsqjIxd+kt8buh/8urFB2bDJp9Fa+gzZ5xt9xMmsInSUNd
         egUCL1+EjB/vUWoyarO8Mv8yvy12i3bpV5iL/Ilpd7ik4ombpfwC3IkGmOSpUxSRmD/8
         FhSvuqOVlozJD865gCpzS1/OMVdSnvyQ9CgTkZizoCdKujYMu/QdEbohJRhMrPTLEzXR
         LhQRsbnmFzLjMF9Icn8DmaaXd6dnDGpzc9PKlUwLOBYxdy5ETak3aShxaTZQVlmZM+JO
         whkEhh2/3P5jPFaBwaF4zGx7vp+KGeYOGscRWNKdpBeJXNu3wbz5T5RxW0OCU3c1PSEI
         lnDg==
X-Gm-Message-State: ANoB5plMehCSm1D41mUQsR4GXc2/lySft+FACOPj+pouRoC6maoXkCmt
        /PbhGeb9H/j26TNbDQ0SJ8fD9Ch3QA7e8g==
X-Google-Smtp-Source: AA0mqf63eyzXCOuAmemYVYy8DWm4rGxvTPgJfbBmpikLpA/N+HUqyJRCr/7n9tRhk0TUDgpOd4ghkQ==
X-Received: by 2002:a17:902:848f:b0:180:a0e6:f81b with SMTP id c15-20020a170902848f00b00180a0e6f81bmr3859855plo.78.1668195227762;
        Fri, 11 Nov 2022 11:33:47 -0800 (PST)
Received: from localhost ([14.96.13.220])
        by smtp.gmail.com with ESMTPSA id y18-20020a17090a8b1200b0020d39ffe987sm1932697pjn.50.2022.11.11.11.33.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Nov 2022 11:33:47 -0800 (PST)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Dave Marchevsky <davemarchevsky@meta.com>,
        Delyan Kratunov <delyank@meta.com>
Subject: [PATCH bpf-next v6 11/26] bpf: Allow locking bpf_spin_lock in allocated objects
Date:   Sat, 12 Nov 2022 01:02:09 +0530
Message-Id: <20221111193224.876706-12-memxor@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221111193224.876706-1-memxor@gmail.com>
References: <20221111193224.876706-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6759; i=memxor@gmail.com; h=from:subject; bh=D5yGHY+U0HGnEPj45nqZS0kfv31XewpVRUnqLpSLWo4=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBjbqIoJ78ZLBua/KMV37yLSTn7miT8kAC4xE+7NMeL jdtwOoCJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCY26iKAAKCRBM4MiGSL8RyoqpD/ 0Q/uS4HCksgGaJzHyC7+1znzKgFsSiD+RWYBylfCJqt1ThQuoPhESHVerW72Wm8OJaCMC31Lgk9apY 4escegc083IsBSg7Iu0z9tyQ1cAPPvlQMANtUl6fu/WjH0dmrZR+G3UGNuGTJdICklX1qHCehBSGdN Rzf7hlNQ5m85JQzU6OegzrHqGvxfdplnuAOMaYnfzdq481Lyt3j9dgJNGugTvEbErP+m3iadNYxpDk K2h8JhqmpxryWXRRdO3uQoZAtOUjejkiK7bRBTF9g15KCTdjsdjC3k0j5ZkT7YdklCze3MqrWYylBg BoAkVeETy1R6TVIu80yq9vUAi9EAyaBuN5aupBlPNluhuttfT53Dg/7T3Ae0dD8/hCf3gpQSAlfqpw eR1S09+OXPYzazOTTnrqV/hf2rnOH7n2gKwaJXh5g1xUA21G0tqJvm8qWlLWC+2QCzyO6KZDPltrZS Q2TH+IJTGNwpoD1+pwbWqkp343EZ/oVaqrwQlAM5Pi824SeGhJkLyEKLk18lEkCkUu1MN0lXNUFBJf mWYi4kYmd/+wE24/EDmbEXr9gPkekHymiIOwHmgg8hWHIZwBcpsCa6izNC1w/A/kbNvWm2n3gNWfz6 MRj0MHi5WB+HSzvxGh0ecpv2Nj2L7bjkTTGihX98eYJ+ICqQUwuRAz2Lfu3A==
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

Allow locking a bpf_spin_lock in an allocated object, in addition to
already support map value pointers. The handling is similar to that of
map values, by just preserving the reg->id of PTR_TO_BTF_ID | MEM_ALLOC
as well, and adjusting process_spin_lock to work with them  and remember
the id in verifier state.

Refactor the existing process_spin_lock to work with PTR_TO_BTF_ID |
MEM_ALLOC in addition to PTR_TO_MAP_VALUE. We need to update the
reg_may_point_to_spin_lock which is used in mark_ptr_or_null_reg to
preserve reg->id, that will be used in env->cur_state->active_spin_lock
to remember the currently held spin lock.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/helpers.c  |  2 ++
 kernel/bpf/verifier.c | 70 ++++++++++++++++++++++++++++++++-----------
 2 files changed, 55 insertions(+), 17 deletions(-)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 7bc71995f17c..5bc0b9f0f306 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -336,6 +336,7 @@ const struct bpf_func_proto bpf_spin_lock_proto = {
 	.gpl_only	= false,
 	.ret_type	= RET_VOID,
 	.arg1_type	= ARG_PTR_TO_SPIN_LOCK,
+	.arg1_btf_id    = BPF_PTR_POISON,
 };
 
 static inline void __bpf_spin_unlock_irqrestore(struct bpf_spin_lock *lock)
@@ -358,6 +359,7 @@ const struct bpf_func_proto bpf_spin_unlock_proto = {
 	.gpl_only	= false,
 	.ret_type	= RET_VOID,
 	.arg1_type	= ARG_PTR_TO_SPIN_LOCK,
+	.arg1_btf_id    = BPF_PTR_POISON,
 };
 
 void copy_map_value_locked(struct bpf_map *map, void *dst, void *src,
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 5cf14c1391a5..3831364af1ce 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -453,8 +453,16 @@ static bool reg_type_not_null(enum bpf_reg_type type)
 
 static bool reg_may_point_to_spin_lock(const struct bpf_reg_state *reg)
 {
-	return reg->type == PTR_TO_MAP_VALUE &&
-	       btf_record_has_field(reg->map_ptr->record, BPF_SPIN_LOCK);
+	struct btf_record *rec = NULL;
+
+	if (reg->type == PTR_TO_MAP_VALUE) {
+		rec = reg->map_ptr->record;
+	} else if (reg->type == (PTR_TO_BTF_ID | MEM_ALLOC)) {
+		struct btf_struct_meta *meta = btf_find_struct_meta(reg->btf, reg->btf_id);
+		if (meta)
+			rec = meta->record;
+	}
+	return btf_record_has_field(rec, BPF_SPIN_LOCK);
 }
 
 static bool type_is_rdonly_mem(u32 type)
@@ -5583,8 +5591,10 @@ static int process_spin_lock(struct bpf_verifier_env *env, int regno,
 	struct bpf_reg_state *regs = cur_regs(env), *reg = &regs[regno];
 	struct bpf_verifier_state *cur = env->cur_state;
 	bool is_const = tnum_is_const(reg->var_off);
-	struct bpf_map *map = reg->map_ptr;
 	u64 val = reg->var_off.value;
+	struct bpf_map *map = NULL;
+	struct btf_record *rec;
+	struct btf *btf = NULL;
 
 	if (!is_const) {
 		verbose(env,
@@ -5592,19 +5602,32 @@ static int process_spin_lock(struct bpf_verifier_env *env, int regno,
 			regno);
 		return -EINVAL;
 	}
-	if (!map->btf) {
-		verbose(env,
-			"map '%s' has to have BTF in order to use bpf_spin_lock\n",
-			map->name);
-		return -EINVAL;
+	if (reg->type == PTR_TO_MAP_VALUE) {
+		map = reg->map_ptr;
+		if (!map->btf) {
+			verbose(env,
+				"map '%s' has to have BTF in order to use bpf_spin_lock\n",
+				map->name);
+			return -EINVAL;
+		}
+		rec = map->record;
+	} else {
+		struct btf_struct_meta *meta;
+
+		btf = reg->btf;
+		meta = btf_find_struct_meta(reg->btf, reg->btf_id);
+		if (meta)
+			rec = meta->record;
 	}
-	if (!btf_record_has_field(map->record, BPF_SPIN_LOCK)) {
-		verbose(env, "map '%s' has no valid bpf_spin_lock\n", map->name);
+
+	if (!btf_record_has_field(rec, BPF_SPIN_LOCK)) {
+		verbose(env, "%s '%s' has no valid bpf_spin_lock\n", map ? "map" : "local",
+			map ? map->name : "kptr");
 		return -EINVAL;
 	}
-	if (map->record->spin_lock_off != val + reg->off) {
+	if (rec->spin_lock_off != val + reg->off) {
 		verbose(env, "off %lld doesn't point to 'struct bpf_spin_lock' that is at %d\n",
-			val + reg->off, map->record->spin_lock_off);
+			val + reg->off, rec->spin_lock_off);
 		return -EINVAL;
 	}
 	if (is_lock) {
@@ -5810,13 +5833,19 @@ static const struct bpf_reg_types int_ptr_types = {
 	},
 };
 
+static const struct bpf_reg_types spin_lock_types = {
+	.types = {
+		PTR_TO_MAP_VALUE,
+		PTR_TO_BTF_ID | MEM_ALLOC,
+	}
+};
+
 static const struct bpf_reg_types fullsock_types = { .types = { PTR_TO_SOCKET } };
 static const struct bpf_reg_types scalar_types = { .types = { SCALAR_VALUE } };
 static const struct bpf_reg_types context_types = { .types = { PTR_TO_CTX } };
 static const struct bpf_reg_types ringbuf_mem_types = { .types = { PTR_TO_MEM | MEM_RINGBUF } };
 static const struct bpf_reg_types const_map_ptr_types = { .types = { CONST_PTR_TO_MAP } };
 static const struct bpf_reg_types btf_ptr_types = { .types = { PTR_TO_BTF_ID } };
-static const struct bpf_reg_types spin_lock_types = { .types = { PTR_TO_MAP_VALUE } };
 static const struct bpf_reg_types percpu_btf_ptr_types = { .types = { PTR_TO_BTF_ID | MEM_PERCPU } };
 static const struct bpf_reg_types func_ptr_types = { .types = { PTR_TO_FUNC } };
 static const struct bpf_reg_types stack_ptr_types = { .types = { PTR_TO_STACK } };
@@ -5941,6 +5970,11 @@ static int check_reg_type(struct bpf_verifier_env *env, u32 regno,
 				return -EACCES;
 			}
 		}
+	} else if (type_is_alloc(reg->type)) {
+		if (meta->func_id != BPF_FUNC_spin_lock && meta->func_id != BPF_FUNC_spin_unlock) {
+			verbose(env, "verifier internal error: unimplemented handling of MEM_ALLOC\n");
+			return -EFAULT;
+		}
 	}
 
 	return 0;
@@ -6057,7 +6091,8 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 		goto skip_type_check;
 
 	/* arg_btf_id and arg_size are in a union. */
-	if (base_type(arg_type) == ARG_PTR_TO_BTF_ID)
+	if (base_type(arg_type) == ARG_PTR_TO_BTF_ID ||
+	    base_type(arg_type) == ARG_PTR_TO_SPIN_LOCK)
 		arg_btf_id = fn->arg_btf_id[arg];
 
 	err = check_reg_type(env, regno, arg_type, arg_btf_id, meta);
@@ -6675,9 +6710,10 @@ static bool check_btf_id_ok(const struct bpf_func_proto *fn)
 	int i;
 
 	for (i = 0; i < ARRAY_SIZE(fn->arg_type); i++) {
-		if (base_type(fn->arg_type[i]) == ARG_PTR_TO_BTF_ID && !fn->arg_btf_id[i])
-			return false;
-
+		if (base_type(fn->arg_type[i]) == ARG_PTR_TO_BTF_ID)
+			return !!fn->arg_btf_id[i];
+		if (base_type(fn->arg_type[i]) == ARG_PTR_TO_SPIN_LOCK)
+			return fn->arg_btf_id[i] == BPF_PTR_POISON;
 		if (base_type(fn->arg_type[i]) != ARG_PTR_TO_BTF_ID && fn->arg_btf_id[i] &&
 		    /* arg_btf_id and arg_size are in a union. */
 		    (base_type(fn->arg_type[i]) != ARG_PTR_TO_MEM ||
-- 
2.38.1

