Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26B60616EB0
	for <lists+bpf@lfdr.de>; Wed,  2 Nov 2022 21:28:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231209AbiKBU2J (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 2 Nov 2022 16:28:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231295AbiKBU1y (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 2 Nov 2022 16:27:54 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B323B642C
        for <bpf@vger.kernel.org>; Wed,  2 Nov 2022 13:27:51 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id h193so8521525pgc.10
        for <bpf@vger.kernel.org>; Wed, 02 Nov 2022 13:27:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RZOwoElkaEnH+JROeccWv9kfqt1NBL8RkmPgwBuSXis=;
        b=kf/MZCH4LiNiN9FU7f/hMvP1F5ynRPMdm3pnGLl2QpxLKA8dl3EVRNsPDKoefMbE6u
         S59lq2f8l1y4f7d1JaRR+RL/Gg1oaPmeEiuO0axjiC06Eo6W+rZp6pksast8dAPVSFnZ
         BLdvopQW3cAL4Q8khxRbFeUkYXgbq4O7mfu+BHh5WqrClt8zKMKvUyQNOcbq4v2xTN5+
         pIZ8DPm7ibjuboR5Cp0VU3l8LV6q1cVxb8K/m7iixYgI+HTU7oNL5i/TnzK02/GT4Sru
         olc2wovSRz6ZCTb2XTSds3phM+qwfAhvJFC+Jmn2gyl8SQfTH4DsKJP39/dI5XOLFoPA
         ac5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RZOwoElkaEnH+JROeccWv9kfqt1NBL8RkmPgwBuSXis=;
        b=4iOlIBPlidjGidMUdHj6QC07AcvKEIa/F+kEbmya2QNEaGI7R0tr6gEtDeZ+/teecb
         6lg+Sicqrm5SqZRq0o9vPTj3Lt1ic/cCxThEKlBoqitvbs5W4OBO/9qzxhIFeMIu28eo
         qUnhJy595nTkTW5K7SHFce4hqea1dgmDXAhEykDh/nUnP4tjX4vFsVbftx8spuFf6RKL
         gRI/s5YQBtLYuLpwYC+JSRC6EdZFviF1mNxcOk/T9yAsgPqFKPgWv0FA5obO4K9lvyuz
         BZx/lvlWsz8aIFBEpVma7oD2qjxoouuaA2SOwWVy1A8iNJZ1CpQpZI/K/1lMD/YOwHL3
         nqBw==
X-Gm-Message-State: ACrzQf3qO5XQUrPdfSMcZYt2PJnk+MW7g5OQk6Oi9uzBAwuP4rdSlFDt
        YQOTM05u1bxoChzsYMMhVvkfpu6qS5MnCQ==
X-Google-Smtp-Source: AMsMyM7IvsSiy2lhjbPqqjmPx5ZJyfl8zw5C2AEZJN/K0kpP3+BLRcVMwVjT5+1xzo8M9x+aOxhudA==
X-Received: by 2002:a62:a102:0:b0:56d:5de0:1017 with SMTP id b2-20020a62a102000000b0056d5de01017mr19734667pff.10.1667420870945;
        Wed, 02 Nov 2022 13:27:50 -0700 (PDT)
Received: from localhost ([59.152.80.69])
        by smtp.gmail.com with ESMTPSA id k18-20020aa79d12000000b0056bbebbcafbsm8843676pfp.100.2022.11.02.13.27.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 13:27:50 -0700 (PDT)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Dave Marchevsky <davemarchevsky@meta.com>,
        Delyan Kratunov <delyank@meta.com>
Subject: [PATCH bpf-next v3 13/24] bpf: Support locking bpf_spin_lock in local kptr
Date:   Thu,  3 Nov 2022 01:56:47 +0530
Message-Id: <20221102202658.963008-14-memxor@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221102202658.963008-1-memxor@gmail.com>
References: <20221102202658.963008-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6465; i=memxor@gmail.com; h=from:subject; bh=ffZVVYgSL7s8Uj7eLRarZBe1ZjcUbMsSF42058To9y0=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBjYtIDp3OXXdo0T/IDXUQYqWHE3HW0SVv1FTAVWwvD LCFcYISJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCY2LSAwAKCRBM4MiGSL8RysG2EA CnshYOmOROSEwle5UKma8zHqrpT718WQp+pFVFCwryjdkqsIE9ZEkC56+9WSP6gt/s7QhviK2lAftK 8T9corFReRnP/Nr9VxUCBMsHJiaOVVd1MbeC7yE+xo+PUQgUlVDadcQ5w6Lp5Qif31nvMLwHW5FTQC qbQ3/P3ZkxufqeHwCvwKSSEH/awtsVcxILB8L4RVsj9MnZR8TmCpiLNsXLDPTllGAEoCSaLhwT5qZJ 3Zfm+sVSIJbICZ17dKYeKnKG0E1u5eB3FCnQu/pvMDwDnaPCkDybUdSz6Eo1XiZPTpPtYa7XFqWcqG CqUen+CXpE0nnugfnQtFNbz1xq1Pz2Jq1lVwgM6XFc63RQ38ZlNOZFj5ubzf73qNLwnv//iwc37mJW EpqmQNeeroQlfyfn72a8sFpJtuyLbYKKm1K7+IJUzRDSIlJo1o6ZeZM8PyJSmTNMqUWwdps7SBQQ3l LkVJGczHFwF6nzZGV5tEHqs43T/HbE7o9l1Ed0Ee0mFuYUN2RopPg7kIwzOBjDgAUMRJ5V+U/NbPVL AET4gzMZvsxOJPD/fgHojQlpZyz1s/R3n/uNAW6yCQLT5dpV8t7Svmc2Z9XqcBGzzDDsInoXNPsXDa c7jz5Rf42XpALa0PgBO4b2M3KUCQ1a7M2GBTqKCZoFyAGG41ENbtEsyCvu9w==
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

Allow locking a bpf_spin_lock embedded in local kptr, in addition to
already support map value pointers. The handling is similar to that of
map values, by just preserving the reg->id of local kptrs as well, and
adjusting process_spin_lock to work with non-PTR_TO_MAP_VALUE and
remember the id in verifier state.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/helpers.c  |  2 ++
 kernel/bpf/verifier.c | 70 ++++++++++++++++++++++++++++++++-----------
 2 files changed, 55 insertions(+), 17 deletions(-)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index b1ee50953efc..e2441b70d3ed 100644
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
index e56b960546f0..bbb5449630a1 100644
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
+	} else if (reg->type == (PTR_TO_BTF_ID | MEM_TYPE_LOCAL)) {
+		struct btf_struct_meta *meta = btf_find_struct_meta(reg->btf, reg->btf_id);
+		if (meta)
+			rec = meta->record;
+	}
+	return btf_record_has_field(rec, BPF_SPIN_LOCK);
 }
 
 static bool type_is_rdonly_mem(u32 type)
@@ -5422,8 +5430,10 @@ static int process_spin_lock(struct bpf_verifier_env *env, int regno,
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
@@ -5431,19 +5441,32 @@ static int process_spin_lock(struct bpf_verifier_env *env, int regno,
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
@@ -5649,13 +5672,19 @@ static const struct bpf_reg_types int_ptr_types = {
 	},
 };
 
+static const struct bpf_reg_types spin_lock_types = {
+	.types = {
+		PTR_TO_MAP_VALUE,
+		PTR_TO_BTF_ID | MEM_TYPE_LOCAL,
+	}
+};
+
 static const struct bpf_reg_types fullsock_types = { .types = { PTR_TO_SOCKET } };
 static const struct bpf_reg_types scalar_types = { .types = { SCALAR_VALUE } };
 static const struct bpf_reg_types context_types = { .types = { PTR_TO_CTX } };
 static const struct bpf_reg_types alloc_mem_types = { .types = { PTR_TO_MEM | MEM_ALLOC } };
 static const struct bpf_reg_types const_map_ptr_types = { .types = { CONST_PTR_TO_MAP } };
 static const struct bpf_reg_types btf_ptr_types = { .types = { PTR_TO_BTF_ID } };
-static const struct bpf_reg_types spin_lock_types = { .types = { PTR_TO_MAP_VALUE } };
 static const struct bpf_reg_types percpu_btf_ptr_types = { .types = { PTR_TO_BTF_ID | MEM_PERCPU } };
 static const struct bpf_reg_types func_ptr_types = { .types = { PTR_TO_FUNC } };
 static const struct bpf_reg_types stack_ptr_types = { .types = { PTR_TO_STACK } };
@@ -5780,6 +5809,11 @@ static int check_reg_type(struct bpf_verifier_env *env, u32 regno,
 				return -EACCES;
 			}
 		}
+	} else if (reg->type == (PTR_TO_BTF_ID | MEM_TYPE_LOCAL)) {
+		if (meta->func_id != BPF_FUNC_spin_lock && meta->func_id != BPF_FUNC_spin_unlock) {
+			verbose(env, "verifier internal error: unimplemented handling of local kptr\n");
+			return -EFAULT;
+		}
 	}
 
 	return 0;
@@ -5896,7 +5930,8 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 		goto skip_type_check;
 
 	/* arg_btf_id and arg_size are in a union. */
-	if (base_type(arg_type) == ARG_PTR_TO_BTF_ID)
+	if (base_type(arg_type) == ARG_PTR_TO_BTF_ID ||
+	    base_type(arg_type) == ARG_PTR_TO_SPIN_LOCK)
 		arg_btf_id = fn->arg_btf_id[arg];
 
 	err = check_reg_type(env, regno, arg_type, arg_btf_id, meta);
@@ -6514,9 +6549,10 @@ static bool check_btf_id_ok(const struct bpf_func_proto *fn)
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

