Return-Path: <bpf+bounces-78242-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 49ADBD05319
	for <lists+bpf@lfdr.de>; Thu, 08 Jan 2026 18:51:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C30B53006597
	for <lists+bpf@lfdr.de>; Thu,  8 Jan 2026 17:51:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8A882E336F;
	Thu,  8 Jan 2026 17:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="azrm3c+s"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B26C52DB78E
	for <bpf@vger.kernel.org>; Thu,  8 Jan 2026 17:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767894688; cv=none; b=kQsTcP/EW0E2RZ12WrY4xAFOBUeR5NGkPYLJJyZ2mv35J/kPfj/aeJGdar39OOqS1MByJ/1WWkeBLU2gw4JUQEBk0mIVHYd1DAIDURbGOAQ7GWhWdKJRJyhxclwAzw9KaBshYIOgi0CJbxipKdn4R7tyL/hj9uhWeniVf19oGKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767894688; c=relaxed/simple;
	bh=8eUkeKcbqlA62eK4ljIgzKskdgcsoEwRT9kTQdJ21wQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lNYLq9z3jRfQTglAak//SDkLAhJ8NtkGGeGUiREks4j1yWag5XudEq5KuRUc+ZkzGaJBNPlbSBbJ6xhWT7XwaJ2gqLYisGW/3G/RhX6m0XNYbzU6MV45YagJrn0CCIxTML8FoikVBM+gaDQjBrjAqufRkx++PuL+7bOYa/yJsZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=azrm3c+s; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-47d3ffa6720so35965075e9.0
        for <bpf@vger.kernel.org>; Thu, 08 Jan 2026 09:51:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767894685; x=1768499485; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7zlgTv3q6YsIZUQwbTwrqz7rIENxWeFaFuMVOVwpV2I=;
        b=azrm3c+sKfe87KpCU4g82nG8aSmYIcf07Lr5bb9XBhxwT8dmaP2kQpNY2AGNDd3ExB
         d+RVPOhsIYL1PPD2pRRyrmKVwvcD8gkxTM33mKXzGnXy+LhAumoFl4yP5Z0coHlAwsVz
         1LP8HAhhiYjJ6SvN83RlqvLgc6L14AtdcfliOFE70ChOPMlTAUScvoaW4WpQiKo3RkgV
         VKJuvzTtuwgj7Bqv5y3z+hyMbTcEllYOc/Fj9TMMANi2p1FxQ+q8FRUbD0hvLfDmWcu1
         w0P/ZRvuwSc3f4sRkM7OU6lZneV8u91qS0bMvB045aM7a4jF3xVvbBMIdrxdcK4q2Ads
         N1HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767894685; x=1768499485;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7zlgTv3q6YsIZUQwbTwrqz7rIENxWeFaFuMVOVwpV2I=;
        b=eHxogWMlMLxgB4VN7+W2avSxR5zoCQmQYBEUxkI3A1gcC8E180TtA4zEsg6x+qu2GD
         goCr8DLr1ARaBffmDW+PZWidS7MHT/74XtjbqQEP9bIu4jIlu4GNd3hNcwKlDv6R184b
         6Q7d3K1hLYRKM63scEqTD3wBiJK4HnhykJozCvK+F/001VNQrsW0XarSykmlKUw57IOV
         79OZ7bz5/RvHwqzpkeQLT5QJJOi12qSAK/KsrsO/DqOR/y6frXIjKvnDdI2yVMZ8bI8H
         SAdHmq03T38pQLPvUyK+WAoZ1sdxQTeJDCnmEzAF9tAV+RKnmE1foTbD7rWhUKTXmlNc
         rKjw==
X-Gm-Message-State: AOJu0Yx7zKFRuGEBSNmrFUm1VCtp9RBmn5al0LiFRg0CLhaUAChnUHAd
	B09OinHRqIt18Y7dhUtXEhpixxQYwZbqmERHDkYDSAaVIvp6hbOILMckgZSi3Q==
X-Gm-Gg: AY/fxX7H24gACln/+sQS6/KawsYHDkwlYrYjPAlwGWK96SDZfpkADipviFm2PHD34mB
	ESJc3g4CmKTh+nsYAPtEkBFMr6DTsOZiQN0/HsZQJv/VbAF3vlCo29nNBEPXI0zbVnpfjbDYPmU
	AOIQJ6MkX/coNQN8j5rNS4FaWkMSpyqXZ7w2ZwQDE/8nCYxNQIfpBTJWSzAPQHwCLI5Ub21bXYv
	wigiFgIRuBiTcwkPaGVVd9ZaVg+ps8w21n7XWlooH7whd+jOZBf08lRdZ2h70R27gV2L4J75oAi
	cDSKqtgyive1jP5GTDS9ydhUko3yKTpC0BhvY2YobTS2QPlI5t8OnfI1//olSJJiJIXH7IJkw02
	0YTtyboZpvOPihsYjo8U5hrvqrjOwPfCIzsmm4wycibD4c+iTKhxC4XvgjsVxHgTNLvc=
X-Google-Smtp-Source: AGHT+IHCKL8eU61+1rIyfbZzRyWF6PO3qkWJmzgqr9jbvtAVWmpxFW2wR6g+/YRfVRhFPN2IhdwDUA==
X-Received: by 2002:a05:600c:3b28:b0:477:9b4a:a82 with SMTP id 5b1f17b1804b1-47d84b41152mr81535425e9.35.1767894684801;
        Thu, 08 Jan 2026 09:51:24 -0800 (PST)
Received: from localhost ([2620:10d:c092:500::5:db08])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d7f70bc4fsm159406525e9.15.2026.01.08.09.51.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jan 2026 09:51:24 -0800 (PST)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	kafai@meta.com,
	kernel-team@meta.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
Subject: [PATCH bpf-next v1] bpf: Use reg_state() for register access in verifier
Date: Thu,  8 Jan 2026 17:51:06 +0000
Message-ID: <20260108175106.2731796-1-mykyta.yatsenko5@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mykyta Yatsenko <yatsenko@meta.com>

Replace the pattern of declaring a local regs array from cur_regs()
and then indexing into it with the more concise reg_state() helper.
This simplifies the code by eliminating intermediate variables and
makes register access more consistent throughout the verifier.

Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
---
 kernel/bpf/verifier.c | 41 ++++++++++++++++++-----------------------
 1 file changed, 18 insertions(+), 23 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 53635ea2e41b..9721f18cc34c 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -5654,8 +5654,7 @@ static int check_stack_write(struct bpf_verifier_env *env,
 static int check_map_access_type(struct bpf_verifier_env *env, u32 regno,
 				 int off, int size, enum bpf_access_type type)
 {
-	struct bpf_reg_state *regs = cur_regs(env);
-	struct bpf_map *map = regs[regno].map_ptr;
+	struct bpf_map *map = reg_state(env, regno)->map_ptr;
 	u32 cap = bpf_map_flags_to_cap(map);
 
 	if (type == BPF_WRITE && !(cap & BPF_MAP_CAN_WRITE)) {
@@ -6168,8 +6167,7 @@ static bool may_access_direct_pkt_data(struct bpf_verifier_env *env,
 static int check_packet_access(struct bpf_verifier_env *env, u32 regno, int off,
 			       int size, bool zero_size_allowed)
 {
-	struct bpf_reg_state *regs = cur_regs(env);
-	struct bpf_reg_state *reg = &regs[regno];
+	struct bpf_reg_state *reg = reg_state(env, regno);
 	int err;
 
 	/* We may have added a variable offset to the packet pointer; but any
@@ -6256,8 +6254,7 @@ static int check_sock_access(struct bpf_verifier_env *env, int insn_idx,
 			     u32 regno, int off, int size,
 			     enum bpf_access_type t)
 {
-	struct bpf_reg_state *regs = cur_regs(env);
-	struct bpf_reg_state *reg = &regs[regno];
+	struct bpf_reg_state *reg = reg_state(env, regno);
 	struct bpf_insn_access_aux info = {};
 	bool valid;
 
@@ -7453,8 +7450,7 @@ static int check_stack_access_within_bounds(
 		int regno, int off, int access_size,
 		enum bpf_access_type type)
 {
-	struct bpf_reg_state *regs = cur_regs(env);
-	struct bpf_reg_state *reg = regs + regno;
+	struct bpf_reg_state *reg = reg_state(env, regno);
 	struct bpf_func_state *state = func(env, reg);
 	s64 min_off, max_off;
 	int err;
@@ -8408,7 +8404,7 @@ static int process_spin_lock(struct bpf_verifier_env *env, int regno, int flags)
 {
 	bool is_lock = flags & PROCESS_SPIN_LOCK, is_res_lock = flags & PROCESS_RES_LOCK;
 	const char *lock_str = is_res_lock ? "bpf_res_spin" : "bpf_spin";
-	struct bpf_reg_state *regs = cur_regs(env), *reg = &regs[regno];
+	struct bpf_reg_state *reg = reg_state(env, regno);
 	struct bpf_verifier_state *cur = env->cur_state;
 	bool is_const = tnum_is_const(reg->var_off);
 	bool is_irq = flags & PROCESS_LOCK_IRQ;
@@ -8524,7 +8520,7 @@ static int process_spin_lock(struct bpf_verifier_env *env, int regno, int flags)
 static int check_map_field_pointer(struct bpf_verifier_env *env, u32 regno,
 				   enum btf_field_type field_type)
 {
-	struct bpf_reg_state *regs = cur_regs(env), *reg = &regs[regno];
+	struct bpf_reg_state *reg = reg_state(env, regno);
 	bool is_const = tnum_is_const(reg->var_off);
 	struct bpf_map *map = reg->map_ptr;
 	u64 val = reg->var_off.value;
@@ -8571,7 +8567,7 @@ static int check_map_field_pointer(struct bpf_verifier_env *env, u32 regno,
 static int process_timer_func(struct bpf_verifier_env *env, int regno,
 			      struct bpf_call_arg_meta *meta)
 {
-	struct bpf_reg_state *regs = cur_regs(env), *reg = &regs[regno];
+	struct bpf_reg_state *reg = reg_state(env, regno);
 	struct bpf_map *map = reg->map_ptr;
 	int err;
 
@@ -8595,7 +8591,7 @@ static int process_timer_func(struct bpf_verifier_env *env, int regno,
 static int process_wq_func(struct bpf_verifier_env *env, int regno,
 			   struct bpf_kfunc_call_arg_meta *meta)
 {
-	struct bpf_reg_state *regs = cur_regs(env), *reg = &regs[regno];
+	struct bpf_reg_state *reg = reg_state(env, regno);
 	struct bpf_map *map = reg->map_ptr;
 	int err;
 
@@ -8616,7 +8612,7 @@ static int process_wq_func(struct bpf_verifier_env *env, int regno,
 static int process_task_work_func(struct bpf_verifier_env *env, int regno,
 				  struct bpf_kfunc_call_arg_meta *meta)
 {
-	struct bpf_reg_state *regs = cur_regs(env), *reg = &regs[regno];
+	struct bpf_reg_state *reg = reg_state(env, regno);
 	struct bpf_map *map = reg->map_ptr;
 	int err;
 
@@ -8636,7 +8632,7 @@ static int process_task_work_func(struct bpf_verifier_env *env, int regno,
 static int process_kptr_func(struct bpf_verifier_env *env, int regno,
 			     struct bpf_call_arg_meta *meta)
 {
-	struct bpf_reg_state *regs = cur_regs(env), *reg = &regs[regno];
+	struct bpf_reg_state *reg = reg_state(env, regno);
 	struct btf_field *kptr_field;
 	struct bpf_map *map_ptr;
 	struct btf_record *rec;
@@ -8709,7 +8705,7 @@ static int process_kptr_func(struct bpf_verifier_env *env, int regno,
 static int process_dynptr_func(struct bpf_verifier_env *env, int regno, int insn_idx,
 			       enum bpf_arg_type arg_type, int clone_ref_obj_id)
 {
-	struct bpf_reg_state *regs = cur_regs(env), *reg = &regs[regno];
+	struct bpf_reg_state *reg = reg_state(env, regno);
 	int err;
 
 	if (reg->type != PTR_TO_STACK && reg->type != CONST_PTR_TO_DYNPTR) {
@@ -8829,7 +8825,7 @@ static bool is_kfunc_arg_iter(struct bpf_kfunc_call_arg_meta *meta, int arg_idx,
 static int process_iter_arg(struct bpf_verifier_env *env, int regno, int insn_idx,
 			    struct bpf_kfunc_call_arg_meta *meta)
 {
-	struct bpf_reg_state *regs = cur_regs(env), *reg = &regs[regno];
+	struct bpf_reg_state *reg = reg_state(env, regno);
 	const struct btf_type *t;
 	int spi, err, i, nr_slots, btf_id;
 
@@ -9301,7 +9297,7 @@ static int check_reg_type(struct bpf_verifier_env *env, u32 regno,
 			  const u32 *arg_btf_id,
 			  struct bpf_call_arg_meta *meta)
 {
-	struct bpf_reg_state *regs = cur_regs(env), *reg = &regs[regno];
+	struct bpf_reg_state *reg = reg_state(env, regno);
 	enum bpf_reg_type expected, type = reg->type;
 	const struct bpf_reg_types *compatible;
 	int i, j;
@@ -9714,7 +9710,7 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 			  int insn_idx)
 {
 	u32 regno = BPF_REG_1 + arg;
-	struct bpf_reg_state *regs = cur_regs(env), *reg = &regs[regno];
+	struct bpf_reg_state *reg = reg_state(env, regno);
 	enum bpf_arg_type arg_type = fn->arg_type[arg];
 	enum bpf_reg_type type = reg->type;
 	u32 *arg_btf_id = NULL;
@@ -11247,7 +11243,7 @@ record_func_key(struct bpf_verifier_env *env, struct bpf_call_arg_meta *meta,
 		int func_id, int insn_idx)
 {
 	struct bpf_insn_aux_data *aux = &env->insn_aux_data[insn_idx];
-	struct bpf_reg_state *regs = cur_regs(env), *reg;
+	struct bpf_reg_state *reg;
 	struct bpf_map *map = meta->map_ptr;
 	u64 val, max;
 	int err;
@@ -11259,7 +11255,7 @@ record_func_key(struct bpf_verifier_env *env, struct bpf_call_arg_meta *meta,
 		return -EINVAL;
 	}
 
-	reg = &regs[BPF_REG_3];
+	reg = reg_state(env, BPF_REG_3);
 	val = reg->var_off.value;
 	max = map->max_entries;
 
@@ -11405,8 +11401,7 @@ static struct bpf_insn_aux_data *cur_aux(const struct bpf_verifier_env *env)
 
 static bool loop_flag_is_zero(struct bpf_verifier_env *env)
 {
-	struct bpf_reg_state *regs = cur_regs(env);
-	struct bpf_reg_state *reg = &regs[BPF_REG_4];
+	struct bpf_reg_state *reg = reg_state(env, BPF_REG_4);
 	bool reg_is_null = register_is_null(reg);
 
 	if (reg_is_null)
@@ -12668,7 +12663,7 @@ static int process_kf_arg_ptr_to_btf_id(struct bpf_verifier_env *env,
 static int process_irq_flag(struct bpf_verifier_env *env, int regno,
 			     struct bpf_kfunc_call_arg_meta *meta)
 {
-	struct bpf_reg_state *regs = cur_regs(env), *reg = &regs[regno];
+	struct bpf_reg_state *reg = reg_state(env, regno);
 	int err, kfunc_class = IRQ_NATIVE_KFUNC;
 	bool irq_save;
 
-- 
2.52.0


