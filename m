Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1892B61884D
	for <lists+bpf@lfdr.de>; Thu,  3 Nov 2022 20:11:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231355AbiKCTLR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 3 Nov 2022 15:11:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231339AbiKCTLQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 3 Nov 2022 15:11:16 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9E391D674
        for <bpf@vger.kernel.org>; Thu,  3 Nov 2022 12:11:15 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id 78so2472541pgb.13
        for <bpf@vger.kernel.org>; Thu, 03 Nov 2022 12:11:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m2j5SVxRaqjpNKkttqB+k1TA+7fy+fEVI29qI5hXzm4=;
        b=CULOkYcNGIgqZbtNDm3Q+iZuWUd2pLmEEKklE7GxUDAqNFueWw6H9Cg38FqVBJzPk6
         xyYpy2gnur0nJTduSTcXfOpeQZ0NRmxebDxltDPonBREkt7TSR3yS7gxwLXcnSGwTjuu
         3w6xoYH0a/1TlWuzqovFinnq6Q9/DEEn581v4xAN2KlJSKvgI94ceZSuAK8tu2Gc96SB
         wvEqQfCXcPsNxFOf4VpQG2VG6EnftdprA3zLHDFpu1HzbxEXAaSFxzKpxfVe/jmRoxBi
         srswj891mck5xGTJxyHTBGbCUusxydA0CCOQ6oMHXDFgiB8/y1PyRdlbXwos9v6RBGrz
         sXDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m2j5SVxRaqjpNKkttqB+k1TA+7fy+fEVI29qI5hXzm4=;
        b=7ykKjulDg8dSVcqks2uFMMp3SsAA2jGtbJeUnRz69JKpu2j/0k5cq8UfZt7FBKq6Sp
         l3FbKQaywSmAMB8IAZjTzyUV5I0dC77B/hliNhG2vUb9j/hNfXzEAgcXHRQsa2yHSea7
         opi5l0Lh3LIx3x/lNZNeoI2QMRopIKz+Jl693UBa9xN7gzaYTtpi5fJQiBm9foFY1M87
         1Q7eoRRoSu2XYpmZE85T64CASL3CcDcFYA9iD+GiCWxy/xZtFnDFRp0WqibACMi3kqmo
         d3AGj9+jXvlxMHJYnz4U7kY8yYE8PpOomCxfsqTGRiDlhd/60jjihw7xgpKhupMuuOPZ
         xy7w==
X-Gm-Message-State: ACrzQf0AKZx/5iwDP4SUlWNyjwegMo50YaAnSai1GMoFYADVqDkHsyGo
        tt0FRvWzSWlMAcCRm6OYDRxC3SzEk7yePg==
X-Google-Smtp-Source: AMsMyM70xjEs4R3yjzdc6nLrklbXQGaVl4G3NqFZDgRaFlZ+5dOv3Fx03YnD2J3IhB8tw9y/lE3AIA==
X-Received: by 2002:a05:6a00:88f:b0:558:8186:3ec3 with SMTP id q15-20020a056a00088f00b0055881863ec3mr31258273pfj.83.1667502674989;
        Thu, 03 Nov 2022 12:11:14 -0700 (PDT)
Received: from localhost ([103.4.222.252])
        by smtp.gmail.com with ESMTPSA id ix20-20020a170902f81400b00181f8523f60sm973382plb.225.2022.11.03.12.11.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 12:11:14 -0700 (PDT)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Dave Marchevsky <davemarchevsky@meta.com>,
        Delyan Kratunov <delyank@meta.com>
Subject: [PATCH bpf-next v4 13/24] bpf: Support locking bpf_spin_lock in local kptr
Date:   Fri,  4 Nov 2022 00:40:02 +0530
Message-Id: <20221103191013.1236066-14-memxor@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221103191013.1236066-1-memxor@gmail.com>
References: <20221103191013.1236066-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6465; i=memxor@gmail.com; h=from:subject; bh=lKKP2nMUqCOuDchEBIlYCb6PpFP48R7dteaXbTIU/t4=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBjZBIByDA5xgaUSJ80ZK541TqBzs9C8Z9diRJZgygN sXHgte+JAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCY2QSAQAKCRBM4MiGSL8RynYrEA DDlHyMjMdcLc/01CTV5vYphACEsgU4wTCouk1b/QHov4SzjBulGsuDXPaUA07MoPxZBXIiI9/j/1hC sYRRHjHWtR+VHuFDfLKtOdzzzjThCKVRkPO9JJbQSLWjKvQwlRrmn2/fJ/0hAHRRmp38vpSd3O5nfY YfcIAqF1Hool5qHG1AmOJzhgjlbvKsxUCurn9wKQlnh/phKine0tt2pIj7m2pDnHZRQ7EZ49K/e9cA +rOja2IrPWXFI8Diha59k31sYz45DOVIJZbNI9k3Hy+6uQnHmkUht/eihMwFRMYhZ4jYGf3Jszg8RT M4ui6TEHkAcs6QfuCOfWra9R/IjL4Q5zHPOeEBUQ9slSjQc6R7uA4AFESlw8zceBGBh8bCQpvIqiGP 9yKJnjUTqfjMSts6kXjvpbrSlbOW+/JM6Ky3UuOzpKSQJwsNRpkzE6t42wwCW6Z9UJyip7Bon2ImWF 3KwOmpVyp5xLp90kQVI74zWwM82tGZJKnd0SxK1qqJOiWPfZ80uYDN/Maymp6Mtb0I7pD772qiIjiN IoNYXXUHq82dmPjlsL+zn8OMR95YgKsSTMpFZ0BHIqhVlLM+XCNP2W33lNoJrhq2B0pM9/b0nLAKb3 XCRO+m3N67vGGfExulfRHivq3P4LoAeCDr66uehSDi/eS+GeO127sqbQBTzQ==
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
index 339cce94b408..207f622ec70d 100644
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
index 4de72a4a39bb..c31f20aed30c 100644
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

