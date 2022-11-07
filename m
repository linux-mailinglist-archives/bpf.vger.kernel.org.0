Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E06262035F
	for <lists+bpf@lfdr.de>; Tue,  8 Nov 2022 00:10:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232740AbiKGXK3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 7 Nov 2022 18:10:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232539AbiKGXK1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 7 Nov 2022 18:10:27 -0500
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 785262018E
        for <bpf@vger.kernel.org>; Mon,  7 Nov 2022 15:10:26 -0800 (PST)
Received: by mail-pg1-x542.google.com with SMTP id s196so11869400pgs.3
        for <bpf@vger.kernel.org>; Mon, 07 Nov 2022 15:10:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oQF9hfPM6rxjnO+dc+1qEodgsXV3OQMlHxdznDYwqLY=;
        b=UMOlLqp5VWS45L/6NLvW0sA7a3rC3EvYkqIcDMhJFtPVdNgI2eAQPrnzfmevHL63+n
         OWhCZT+LQWH2BEd4P/Wm9B9fj9GbxLuYHkRn16drkvIZU/79xDcDNCCIR3elW5uEDZvN
         f3CKOEy6CH27OIUnmEQVjYNfMCyg+m3DDVodWEMBIYYk22oq6cPWVyqoOvv595Oa7N5U
         5Y+xibOuDBXDwVMRsd3G7yUng6sD2bQC/K1xCAYcjfK2su7rVBBK3nOpHcBAp540cQfj
         t9rQqCVVRwTf2IoZEEwnvoDrI+fNsoDpSaRD5hJ9SmINL8AdCkceqGCPSsrwIBGEqwWw
         LgYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oQF9hfPM6rxjnO+dc+1qEodgsXV3OQMlHxdznDYwqLY=;
        b=rwUzeeACWYXRFcHxjdL2e+LQ7OGMjtm3DrZOVpC+iHS2z6X5UGwl68VTwYzk4miZ0A
         G51GsQ81QjPyQC9ceEUawaAgY4N5T5nZJE9+cTcoxCB9Z38u7xULFivZD+t0oVt/gNdr
         RZGO/1U6pfLl/sopNICATxm2aAhWO4aKN/Z+LR2uvLB+pDNfid8pv9hFARngPvVF77oh
         V4FKVzi0mcj5B/npFRrXttxRuOEpN3A0uXJwG1jhAl38J2CDhnG1Uq/LmMclG0WJqoS7
         T05QhPhEN1z/STVMtt2EkHG9M727NwQSYIL4/+q4CMJGCPDq06ha1b9UNesM+yzb8UpK
         Rg0w==
X-Gm-Message-State: ACrzQf2/2SYEptU82MULVQ/ri1kp5t2GyTM4pZBSUWdYU+mQ/NWjlMm1
        e5IxWnSrPcF19sBEJtqU/kdt3Dc653ePgw==
X-Google-Smtp-Source: AMsMyM5aTHtcEzH+jkky/+oLh9a4mbt/CW1xngdhedJNsseNEUWGV+lt78W/w/nT1HnM/vZdBtGOqQ==
X-Received: by 2002:a65:5386:0:b0:46e:dbd3:413 with SMTP id x6-20020a655386000000b0046edbd30413mr44058866pgq.240.1667862625740;
        Mon, 07 Nov 2022 15:10:25 -0800 (PST)
Received: from localhost ([14.96.13.220])
        by smtp.gmail.com with ESMTPSA id h11-20020a170902f70b00b00182a9c27acfsm5463171plo.227.2022.11.07.15.10.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 15:10:25 -0800 (PST)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Dave Marchevsky <davemarchevsky@meta.com>,
        Delyan Kratunov <delyank@meta.com>
Subject: [PATCH bpf-next v5 09/25] bpf: Allow locking bpf_spin_lock in local kptr
Date:   Tue,  8 Nov 2022 04:39:34 +0530
Message-Id: <20221107230950.7117-10-memxor@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221107230950.7117-1-memxor@gmail.com>
References: <20221107230950.7117-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6766; i=memxor@gmail.com; h=from:subject; bh=MVQAS2kfnE7vi+V2YwtVErsQEqRsBY+jluWi6u8U8YI=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBjaY+2H8ILifZnISrzCP3Ph14a4AqtzweF6qpXkAOp 1quM72qJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCY2mPtgAKCRBM4MiGSL8RynCHD/ 9td926X5UvGy4dyKVQDCS8A/XF//m9/mVx1BozmK90YPjgXC3s6ZbxKjoiZE7JGcHsnKVMDDOGl3A0 h/ATq8fJaPL2yreUcuB0VjPJXWaQ/0XzDr2JcBJ88V6ek6UOM/XauTFEQC2WsAoG15k7NxXaz/RThN sIZuARE9SKDF1CC9Z5D04SnhDa2t4uO5YK6/RdcueUI6dO8yHsXfEDz3xfWMKPS8TXPuknOpLGHpS6 Zua+jmOm/bTirkYABSoVDdh62kql9ttGRANvbHcefWJ+fKHBcE3IRac3T3jXZd9YpU9xB2IAlhRcnV /Qgleal06P3mO4xpNhREIOxNBqQHmpp2MWLXL02z26F2utDETp/frloQLy3X532R0LfYSCXAj/OBmX zOqGl0f6jOz/5XA2uG9y4c1hYYv1ihHzy4myQ//4zRExv3hJKP2xf6jrqzksK1shR3jKrzvPr77fvp g/zM5WpoWi01oZ762aImbi3+8udsOobjQ0iIZR9Kkch8RComttLSJqQJ6ZIr8UBuiVwc62TuQL7+wn O+GwTf7sGE65opYMq4Vir1akGZSYN0HR20G1BYXtRYgXDXkbe/2gvzaYX/JkcvDbe4f7tR+kUwCstW z/jssnK+WQnev+KJpS//pkYyzBgRE6CN1igQD8/VUuIM1SY5vBnTEQtOQPGg==
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
index 7dcb4629f764..f1170e9db699 100644
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
+	} else if (type_is_local_kptr(reg->type)) {
+		if (meta->func_id != BPF_FUNC_spin_lock && meta->func_id != BPF_FUNC_spin_unlock) {
+			verbose(env, "verifier internal error: unimplemented handling of local kptr\n");
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

