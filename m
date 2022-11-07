Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8938B62035B
	for <lists+bpf@lfdr.de>; Tue,  8 Nov 2022 00:10:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232484AbiKGXKU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 7 Nov 2022 18:10:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232448AbiKGXKS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 7 Nov 2022 18:10:18 -0500
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACD4823164
        for <bpf@vger.kernel.org>; Mon,  7 Nov 2022 15:10:16 -0800 (PST)
Received: by mail-pj1-x1042.google.com with SMTP id d13-20020a17090a3b0d00b00213519dfe4aso11802042pjc.2
        for <bpf@vger.kernel.org>; Mon, 07 Nov 2022 15:10:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ye/v2RFv95ygSo6ebZbkDhxhdMhepOxDfkIMAVMhXHE=;
        b=VtYaM2h/6ucNK5VNMwstE25MpF1heWTtwhTJA0TjFPW2VzCqznaorQjdA0qtcSMx6q
         wYTMallvDEXQnZaqmX2mU7NqgwpukD/qYnECVPb6X8fR9LVZuKYji873MV4ZNUGY00mr
         tl1mQOkdHd+x8kndP3kwMg30qANA6gPD7DKM+WDR3n91J0hMj2hDIUwQaTli72DxiR2L
         dWpxpmx9TWKqGyrQJs7miyjMygIgLY37rkVd5a1nwoOqKqAFCfE4XA+DT3rcWhQXF4ck
         LMyOW2zaNQLu21eph/ldcaa6MVMCcrNT9eYrWLfFkU9iUceLozOE2iyxzpy/LvZSwBYd
         i44A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ye/v2RFv95ygSo6ebZbkDhxhdMhepOxDfkIMAVMhXHE=;
        b=UkwIP8jWV1Bp1kYMJxbyRnDfBZjzKKAHvhvxfhV+A0a6K/CVSKf6QRhpQh+AOViYcj
         j0mm7r/S24e5s+6x6mdMo+6KV1+oPlCte9CsI0lY0rWEUvmQA9yCk737TWfsMPFfHHIn
         Sxpf1FvQ0/ZDdTcP7KbUgWqTR8p1YutXUiNyvw4L9U3wfnE47C6ftiN018JS0jaHTKkH
         e26k05yRA6zYfR7BMppxSO3YlI8X4cNC/CqQYccywaloGGZ4UJfOB0vQqDiGj8WWuMPc
         PBSAqD9Mj0WkCQ3A7yhWhUbw6rGHBedoFtR9ZPO9H+NkvLfrWiAS9zIPqkwe9KgS7tM7
         OiWw==
X-Gm-Message-State: ACrzQf16mZhWsVvOKoaK1ErCzmBP3pYCrPVqW5ZHI7Hz1fuiT4CZPZ29
        eOrUNWmjTU9G6nM2GdTaXu/WyrPv2y+uog==
X-Google-Smtp-Source: AMsMyM6w1TGQ55enXMY3NyiaYB6PTgiRegfCaxf8odqKykQJEREDSYHFeOICMILaUIfcQROoG1uhQg==
X-Received: by 2002:a17:903:11c7:b0:178:af17:e93e with SMTP id q7-20020a17090311c700b00178af17e93emr52470650plh.78.1667862615843;
        Mon, 07 Nov 2022 15:10:15 -0800 (PST)
Received: from localhost ([14.96.13.220])
        by smtp.gmail.com with ESMTPSA id t11-20020a170902b20b00b0018703bf42desm5515223plr.159.2022.11.07.15.10.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 15:10:15 -0800 (PST)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Dave Marchevsky <davemarchevsky@meta.com>,
        Delyan Kratunov <delyank@meta.com>
Subject: [PATCH bpf-next v5 06/25] bpf: Introduce local kptrs
Date:   Tue,  8 Nov 2022 04:39:31 +0530
Message-Id: <20221107230950.7117-7-memxor@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221107230950.7117-1-memxor@gmail.com>
References: <20221107230950.7117-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=16362; i=memxor@gmail.com; h=from:subject; bh=Dja4sjb7SgEYFlHvZ5lFyq1ddKX2AatjroTIv5xwmOs=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBjaY+2EFhi7MtRk0H1+8OSskhXalY+kkbrRPVg9KSO 2uC+qEiJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCY2mPtgAKCRBM4MiGSL8RyofvEA CoZIpUOspkixl5GNtdI9agEEsQHXboq2tRs0JO+qCWdfWWFMBdtgV5A/jEOqAUorJqLSRRsUk7qFtU Bw5e2K9UR8Dfs2AwlPQGqOaEnBl8wJpuhqpXwBVbVipJInEOvdFYLE1Httag2kcBJ3H/ECGEC1shpP 6YMtvFmS1i2FWoZ/y/Cu1WXv64pqtT3SImSmxQrlUQCX9P5i5swh6Le6FpfnsJbg37PKKHLv/uqlXx rd4t96KX0fxsC77mgvIpXrahxB0TIucPco0KT59Cy4tixWcTUjfseekUNrth8o7eGpHd642z19fiEU lICWzYNU3NBlAs2ivSaNUkRdzV6QXnibS2+j5Ritu8ZD5wnf8HHcyhEKQHQ4CHd+8+4xJBNXUsG+5Y QZm8oqv72y17S8rGgt1D2jMBA60F2bw8kZ6dDG/2CdCziewRljrmyLq5fxqlj+xQ7KbV1UpNyhF6od s7hLtzU1vxpATMhTrnfM/jPoebFky5f2UxeLuLGqGEjHHd0gtNPoDg0Z/9kPHsRS7YQqMs8bShEF2/ C7N0I3noI18cgwX2ayNyKrLdMgBEztVmDMGPW9vtCH7UrxE+ghq6qbpmv4LT3q3JeuNzB9L+O5QRrR rCbGhQaQXiSXAHinuwRrX8qZ2fBBko/I4cdkAPxSgnQGHhGbyi4n2ge2OZnw==
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

Introduce local kptrs, i.e. PTR_TO_BTF_ID that point to a type in
program BTF. This is indicated by the presence of MEM_ALLOC type flag in
reg->type to avoid having to check btf_is_kernel when trying to match
argument types in helpers.

Refactor btf_struct_access callback to just take bpf_reg_state instead
of btf and btf_type paramters. Note that the call site in
check_map_access now simulates access to a PTR_TO_BTF_ID by creating a
dummy reg on stack. Since only the type, btf, and btf_id of the register
matter for the checks, it can be done so without complicating the usual
cases elsewhere in the verifier where reg->btf and reg->btf_id is used
verbatim.

Whenever walking such types, any pointers being walked will always yield
a SCALAR instead of pointer. In the future we might permit kptr inside
local kptr (either kernel or local), and it would be permitted only in
that case.

For now, these local kptrs will always be referenced in verifier
context, hence ref_obj_id == 0 for them is a bug. It is allowed to write
to such objects, as long fields that are special are not touched
(support for which will be added in subsequent patches). Note that once
such a local kptr is marked PTR_UNTRUSTED, it is no longer allowed to
write to it.

No PROBE_MEM handling is therefore done for loads into this type unless
PTR_UNTRUSTED is part of the register type, since they can never be in
an undefined state, and their lifetime will always be valid.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 include/linux/bpf.h              | 28 ++++++++++++++++--------
 include/linux/filter.h           |  8 +++----
 kernel/bpf/btf.c                 | 16 ++++++++++----
 kernel/bpf/verifier.c            | 37 ++++++++++++++++++++++++++------
 net/bpf/bpf_dummy_struct_ops.c   | 14 ++++++------
 net/core/filter.c                | 34 ++++++++++++-----------------
 net/ipv4/bpf_tcp_ca.c            | 13 ++++++-----
 net/netfilter/nf_conntrack_bpf.c | 17 ++++++---------
 8 files changed, 99 insertions(+), 68 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index afc1c51b59ff..75dbd2ecf80a 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -524,6 +524,11 @@ enum bpf_type_flag {
 	/* Size is known at compile time. */
 	MEM_FIXED_SIZE		= BIT(10 + BPF_BASE_TYPE_BITS),
 
+	/* MEM is of a type from program BTF, not kernel BTF. This is used to
+	 * tag PTR_TO_BTF_ID allocated using bpf_obj_new.
+	 */
+	MEM_ALLOC		= BIT(11 + BPF_BASE_TYPE_BITS),
+
 	__BPF_TYPE_FLAG_MAX,
 	__BPF_TYPE_LAST_FLAG	= __BPF_TYPE_FLAG_MAX - 1,
 };
@@ -771,6 +776,7 @@ struct bpf_prog_ops {
 			union bpf_attr __user *uattr);
 };
 
+struct bpf_reg_state;
 struct bpf_verifier_ops {
 	/* return eBPF function prototype for verification */
 	const struct bpf_func_proto *
@@ -792,9 +798,8 @@ struct bpf_verifier_ops {
 				  struct bpf_insn *dst,
 				  struct bpf_prog *prog, u32 *target_size);
 	int (*btf_struct_access)(struct bpf_verifier_log *log,
-				 const struct btf *btf,
-				 const struct btf_type *t, int off, int size,
-				 enum bpf_access_type atype,
+				 const struct bpf_reg_state *reg,
+				 int off, int size, enum bpf_access_type atype,
 				 u32 *next_btf_id, enum bpf_type_flag *flag);
 };
 
@@ -2080,9 +2085,9 @@ static inline bool bpf_tracing_btf_ctx_access(int off, int size,
 	return btf_ctx_access(off, size, type, prog, info);
 }
 
-int btf_struct_access(struct bpf_verifier_log *log, const struct btf *btf,
-		      const struct btf_type *t, int off, int size,
-		      enum bpf_access_type atype,
+int btf_struct_access(struct bpf_verifier_log *log,
+		      const struct bpf_reg_state *reg,
+		      int off, int size, enum bpf_access_type atype,
 		      u32 *next_btf_id, enum bpf_type_flag *flag);
 bool btf_struct_ids_match(struct bpf_verifier_log *log,
 			  const struct btf *btf, u32 id, int off,
@@ -2333,9 +2338,8 @@ static inline struct bpf_prog *bpf_prog_by_id(u32 id)
 }
 
 static inline int btf_struct_access(struct bpf_verifier_log *log,
-				    const struct btf *btf,
-				    const struct btf_type *t, int off, int size,
-				    enum bpf_access_type atype,
+				    const struct bpf_reg_state *reg,
+				    int off, int size, enum bpf_access_type atype,
 				    u32 *next_btf_id, enum bpf_type_flag *flag)
 {
 	return -EACCES;
@@ -2792,4 +2796,10 @@ struct bpf_key {
 	bool has_ref;
 };
 #endif /* CONFIG_KEYS */
+
+static inline bool type_is_local_kptr(u32 type)
+{
+	return type & MEM_ALLOC;
+}
+
 #endif /* _LINUX_BPF_H */
diff --git a/include/linux/filter.h b/include/linux/filter.h
index efc42a6e3aed..787d35dbf5b0 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -568,10 +568,10 @@ struct sk_filter {
 DECLARE_STATIC_KEY_FALSE(bpf_stats_enabled_key);
 
 extern struct mutex nf_conn_btf_access_lock;
-extern int (*nfct_btf_struct_access)(struct bpf_verifier_log *log, const struct btf *btf,
-				     const struct btf_type *t, int off, int size,
-				     enum bpf_access_type atype, u32 *next_btf_id,
-				     enum bpf_type_flag *flag);
+extern int (*nfct_btf_struct_access)(struct bpf_verifier_log *log,
+				     const struct bpf_reg_state *reg,
+				     int off, int size, enum bpf_access_type atype,
+				     u32 *next_btf_id, enum bpf_type_flag *flag);
 
 typedef unsigned int (*bpf_dispatcher_fn)(const void *ctx,
 					  const struct bpf_insn *insnsi,
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index d8f083b09e5e..4d6c8577bf17 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -6015,20 +6015,28 @@ static int btf_struct_walk(struct bpf_verifier_log *log, const struct btf *btf,
 	return -EINVAL;
 }
 
-int btf_struct_access(struct bpf_verifier_log *log, const struct btf *btf,
-		      const struct btf_type *t, int off, int size,
-		      enum bpf_access_type atype __maybe_unused,
+int btf_struct_access(struct bpf_verifier_log *log,
+		      const struct bpf_reg_state *reg,
+		      int off, int size, enum bpf_access_type atype __maybe_unused,
 		      u32 *next_btf_id, enum bpf_type_flag *flag)
 {
+	const struct btf *btf = reg->btf;
 	enum bpf_type_flag tmp_flag = 0;
+	const struct btf_type *t;
+	u32 id = reg->btf_id;
 	int err;
-	u32 id;
 
+	t = btf_type_by_id(btf, id);
 	do {
 		err = btf_struct_walk(log, btf, t, off, size, &id, &tmp_flag);
 
 		switch (err) {
 		case WALK_PTR:
+			/* For local types, the destination register cannot
+			 * become a pointer again.
+			 */
+			if (type_is_local_kptr(reg->type))
+				return SCALAR_VALUE;
 			/* If we found the pointer or scalar on t+off,
 			 * we're done.
 			 */
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 5fca156eca43..7dcb4629f764 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -4682,17 +4682,28 @@ static int check_ptr_to_btf_access(struct bpf_verifier_env *env,
 		return -EACCES;
 	}
 
-	if (env->ops->btf_struct_access) {
-		ret = env->ops->btf_struct_access(&env->log, reg->btf, t,
-						  off, size, atype, &btf_id, &flag);
+	if (env->ops->btf_struct_access && !type_is_local_kptr(reg->type)) {
+		if (!btf_is_kernel(reg->btf)) {
+			verbose(env, "verifier internal error: reg->btf must be kernel btf\n");
+			return -EFAULT;
+		}
+		ret = env->ops->btf_struct_access(&env->log, reg, off, size, atype, &btf_id, &flag);
 	} else {
-		if (atype != BPF_READ) {
+		/* Writes are permitted with default btf_struct_access for local
+		 * kptrs (which always have ref_obj_id > 0), but not for
+		 * _untrusted_ local kptrs.
+		 */
+		if (atype != BPF_READ && reg->type != (PTR_TO_BTF_ID | MEM_ALLOC)) {
 			verbose(env, "only read is supported\n");
 			return -EACCES;
 		}
 
-		ret = btf_struct_access(&env->log, reg->btf, t, off, size,
-					atype, &btf_id, &flag);
+		if (type_is_local_kptr(reg->type) && !reg->ref_obj_id) {
+			verbose(env, "verifier internal error: ref_obj_id for local kptr must be non-zero\n");
+			return -EFAULT;
+		}
+
+		ret = btf_struct_access(&env->log, reg, off, size, atype, &btf_id, &flag);
 	}
 
 	if (ret < 0)
@@ -4718,6 +4729,7 @@ static int check_ptr_to_map_access(struct bpf_verifier_env *env,
 {
 	struct bpf_reg_state *reg = regs + regno;
 	struct bpf_map *map = reg->map_ptr;
+	struct bpf_reg_state map_reg;
 	enum bpf_type_flag flag = 0;
 	const struct btf_type *t;
 	const char *tname;
@@ -4756,7 +4768,10 @@ static int check_ptr_to_map_access(struct bpf_verifier_env *env,
 		return -EACCES;
 	}
 
-	ret = btf_struct_access(&env->log, btf_vmlinux, t, off, size, atype, &btf_id, &flag);
+	/* Simulate access to a PTR_TO_BTF_ID */
+	memset(&map_reg, 0, sizeof(map_reg));
+	mark_btf_ld_reg(env, &map_reg, 0, PTR_TO_BTF_ID, btf_vmlinux, *map->ops->map_btf_id, 0);
+	ret = btf_struct_access(&env->log, &map_reg, off, size, atype, &btf_id, &flag);
 	if (ret < 0)
 		return ret;
 
@@ -5966,6 +5981,7 @@ int check_func_arg_reg_off(struct bpf_verifier_env *env,
 	 * fixed offset.
 	 */
 	case PTR_TO_BTF_ID:
+	case PTR_TO_BTF_ID | MEM_ALLOC:
 		/* When referenced PTR_TO_BTF_ID is passed to release function,
 		 * it's fixed offset must be 0.	In the other cases, fixed offset
 		 * can be non-zero.
@@ -13648,6 +13664,13 @@ static int convert_ctx_accesses(struct bpf_verifier_env *env)
 			break;
 		case PTR_TO_BTF_ID:
 		case PTR_TO_BTF_ID | PTR_UNTRUSTED:
+		/* PTR_TO_BTF_ID | MEM_ALLOC always has a valid lifetime, unlike
+		 * PTR_TO_BTF_ID, and an active ref_obj_id, but the same cannot
+		 * be said once it is marked PTR_UNTRUSTED, hence we must handle
+		 * any faults for loads into such types. BPF_WRITE is disallowed
+		 * for this case.
+		 */
+		case PTR_TO_BTF_ID | MEM_ALLOC | PTR_UNTRUSTED:
 			if (type == BPF_READ) {
 				insn->code = BPF_LDX | BPF_PROBE_MEM |
 					BPF_SIZE((insn)->code);
diff --git a/net/bpf/bpf_dummy_struct_ops.c b/net/bpf/bpf_dummy_struct_ops.c
index e78dadfc5829..2d434c1f4617 100644
--- a/net/bpf/bpf_dummy_struct_ops.c
+++ b/net/bpf/bpf_dummy_struct_ops.c
@@ -156,29 +156,29 @@ static bool bpf_dummy_ops_is_valid_access(int off, int size,
 }
 
 static int bpf_dummy_ops_btf_struct_access(struct bpf_verifier_log *log,
-					   const struct btf *btf,
-					   const struct btf_type *t, int off,
-					   int size, enum bpf_access_type atype,
+					   const struct bpf_reg_state *reg,
+					   int off, int size, enum bpf_access_type atype,
 					   u32 *next_btf_id,
 					   enum bpf_type_flag *flag)
 {
 	const struct btf_type *state;
+	const struct btf_type *t;
 	s32 type_id;
 	int err;
 
-	type_id = btf_find_by_name_kind(btf, "bpf_dummy_ops_state",
+	type_id = btf_find_by_name_kind(reg->btf, "bpf_dummy_ops_state",
 					BTF_KIND_STRUCT);
 	if (type_id < 0)
 		return -EINVAL;
 
-	state = btf_type_by_id(btf, type_id);
+	t = btf_type_by_id(reg->btf, reg->btf_id);
+	state = btf_type_by_id(reg->btf, type_id);
 	if (t != state) {
 		bpf_log(log, "only access to bpf_dummy_ops_state is supported\n");
 		return -EACCES;
 	}
 
-	err = btf_struct_access(log, btf, t, off, size, atype, next_btf_id,
-				flag);
+	err = btf_struct_access(log, reg, off, size, atype, next_btf_id, flag);
 	if (err < 0)
 		return err;
 
diff --git a/net/core/filter.c b/net/core/filter.c
index cb3b635e35be..199632e6a7cb 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -8651,28 +8651,25 @@ static bool tc_cls_act_is_valid_access(int off, int size,
 DEFINE_MUTEX(nf_conn_btf_access_lock);
 EXPORT_SYMBOL_GPL(nf_conn_btf_access_lock);
 
-int (*nfct_btf_struct_access)(struct bpf_verifier_log *log, const struct btf *btf,
-			      const struct btf_type *t, int off, int size,
-			      enum bpf_access_type atype, u32 *next_btf_id,
-			      enum bpf_type_flag *flag);
+int (*nfct_btf_struct_access)(struct bpf_verifier_log *log,
+			      const struct bpf_reg_state *reg,
+			      int off, int size, enum bpf_access_type atype,
+			      u32 *next_btf_id, enum bpf_type_flag *flag);
 EXPORT_SYMBOL_GPL(nfct_btf_struct_access);
 
 static int tc_cls_act_btf_struct_access(struct bpf_verifier_log *log,
-					const struct btf *btf,
-					const struct btf_type *t, int off,
-					int size, enum bpf_access_type atype,
-					u32 *next_btf_id,
-					enum bpf_type_flag *flag)
+					const struct bpf_reg_state *reg,
+					int off, int size, enum bpf_access_type atype,
+					u32 *next_btf_id, enum bpf_type_flag *flag)
 {
 	int ret = -EACCES;
 
 	if (atype == BPF_READ)
-		return btf_struct_access(log, btf, t, off, size, atype, next_btf_id,
-					 flag);
+		return btf_struct_access(log, reg, off, size, atype, next_btf_id, flag);
 
 	mutex_lock(&nf_conn_btf_access_lock);
 	if (nfct_btf_struct_access)
-		ret = nfct_btf_struct_access(log, btf, t, off, size, atype, next_btf_id, flag);
+		ret = nfct_btf_struct_access(log, reg, off, size, atype, next_btf_id, flag);
 	mutex_unlock(&nf_conn_btf_access_lock);
 
 	return ret;
@@ -8738,21 +8735,18 @@ void bpf_warn_invalid_xdp_action(struct net_device *dev, struct bpf_prog *prog,
 EXPORT_SYMBOL_GPL(bpf_warn_invalid_xdp_action);
 
 static int xdp_btf_struct_access(struct bpf_verifier_log *log,
-				 const struct btf *btf,
-				 const struct btf_type *t, int off,
-				 int size, enum bpf_access_type atype,
-				 u32 *next_btf_id,
-				 enum bpf_type_flag *flag)
+				 const struct bpf_reg_state *reg,
+				 int off, int size, enum bpf_access_type atype,
+				 u32 *next_btf_id, enum bpf_type_flag *flag)
 {
 	int ret = -EACCES;
 
 	if (atype == BPF_READ)
-		return btf_struct_access(log, btf, t, off, size, atype, next_btf_id,
-					 flag);
+		return btf_struct_access(log, reg, off, size, atype, next_btf_id, flag);
 
 	mutex_lock(&nf_conn_btf_access_lock);
 	if (nfct_btf_struct_access)
-		ret = nfct_btf_struct_access(log, btf, t, off, size, atype, next_btf_id, flag);
+		ret = nfct_btf_struct_access(log, reg, off, size, atype, next_btf_id, flag);
 	mutex_unlock(&nf_conn_btf_access_lock);
 
 	return ret;
diff --git a/net/ipv4/bpf_tcp_ca.c b/net/ipv4/bpf_tcp_ca.c
index 6da16ae6a962..d15c91de995f 100644
--- a/net/ipv4/bpf_tcp_ca.c
+++ b/net/ipv4/bpf_tcp_ca.c
@@ -69,18 +69,17 @@ static bool bpf_tcp_ca_is_valid_access(int off, int size,
 }
 
 static int bpf_tcp_ca_btf_struct_access(struct bpf_verifier_log *log,
-					const struct btf *btf,
-					const struct btf_type *t, int off,
-					int size, enum bpf_access_type atype,
-					u32 *next_btf_id,
-					enum bpf_type_flag *flag)
+					const struct bpf_reg_state *reg,
+					int off, int size, enum bpf_access_type atype,
+					u32 *next_btf_id, enum bpf_type_flag *flag)
 {
+	const struct btf_type *t;
 	size_t end;
 
 	if (atype == BPF_READ)
-		return btf_struct_access(log, btf, t, off, size, atype, next_btf_id,
-					 flag);
+		return btf_struct_access(log, reg, off, size, atype, next_btf_id, flag);
 
+	t = btf_type_by_id(reg->btf, reg->btf_id);
 	if (t != tcp_sock_type) {
 		bpf_log(log, "only read is supported\n");
 		return -EACCES;
diff --git a/net/netfilter/nf_conntrack_bpf.c b/net/netfilter/nf_conntrack_bpf.c
index 8639e7efd0e2..24002bc61e07 100644
--- a/net/netfilter/nf_conntrack_bpf.c
+++ b/net/netfilter/nf_conntrack_bpf.c
@@ -191,19 +191,16 @@ BTF_ID(struct, nf_conn___init)
 
 /* Check writes into `struct nf_conn` */
 static int _nf_conntrack_btf_struct_access(struct bpf_verifier_log *log,
-					   const struct btf *btf,
-					   const struct btf_type *t, int off,
-					   int size, enum bpf_access_type atype,
-					   u32 *next_btf_id,
-					   enum bpf_type_flag *flag)
+					   const struct bpf_reg_state *reg,
+					   int off, int size, enum bpf_access_type atype,
+					   u32 *next_btf_id, enum bpf_type_flag *flag)
 {
-	const struct btf_type *ncit;
-	const struct btf_type *nct;
+	const struct btf_type *ncit, *nct, *t;
 	size_t end;
 
-	ncit = btf_type_by_id(btf, btf_nf_conn_ids[1]);
-	nct = btf_type_by_id(btf, btf_nf_conn_ids[0]);
-
+	ncit = btf_type_by_id(reg->btf, btf_nf_conn_ids[1]);
+	nct = btf_type_by_id(reg->btf, btf_nf_conn_ids[0]);
+	t = btf_type_by_id(reg->btf, reg->btf_id);
 	if (t != nct && t != ncit) {
 		bpf_log(log, "only read is supported\n");
 		return -EACCES;
-- 
2.38.1

