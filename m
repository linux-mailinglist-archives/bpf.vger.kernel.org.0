Return-Path: <bpf+bounces-78718-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C6671D192C0
	for <lists+bpf@lfdr.de>; Tue, 13 Jan 2026 14:52:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7996E3026565
	for <lists+bpf@lfdr.de>; Tue, 13 Jan 2026 13:49:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14A5A392806;
	Tue, 13 Jan 2026 13:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YYRQbhtJ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BFCB3904F0
	for <bpf@vger.kernel.org>; Tue, 13 Jan 2026 13:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768312126; cv=none; b=a9t0+eWwWlYU45J6Uclws81xI+BDr49H6r7J/WDjo2wIZaimb+hmzrgzN3m7H4Qez5GeI1jWIDrr3XHpviIN9R7VbPPxpd4u6qClzpmEyZEICfGPCW+eGQ2OAihCuP1pp5Pyg+2QtlmKFumdhr9Ttfz2fylRq9RD4jB9kvKrD9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768312126; c=relaxed/simple;
	bh=y9TmmQovgqXD7u3kJ2cG43H+1PrMdSWU3Es4eQe7+XM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=f35ozeyduwyz7te+vmOgSqo0e1L16Ld/OriBMvcRttqIVIUK5OG+0NrFiBXzsAe6j0pQ8Of1PHvcfgPl6MwFJbtQNwozx3W68DcJQdEEK0mimO89AB+Q8ynAx9xHD/vxb4YCmt+wPTeJ2/c+04mLHmzgaffL1+dtlWVlhJ1AmCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YYRQbhtJ; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-42fb2314eb0so6380848f8f.2
        for <bpf@vger.kernel.org>; Tue, 13 Jan 2026 05:48:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768312123; x=1768916923; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Y0YXgeg+ytlizlmEFEztYXMfGNyjkojjikqIINZXcD8=;
        b=YYRQbhtJ2b0r6rEEHuqqIOK+uQBMCyMmcEyqnpYb1Wf9gh71DbgO/wj2vZ4n4Qt10z
         4h25BIoalqbvwzORztLpkH86hQYZSOjNOeueBgmBn2ez0YIkWj1sRLaanBrXOuJnKk+y
         C8EGrjgCJ+Hg5KcHEoic8TxFc+HQf5FzZPS6fZL2HHQFVlSpur3ijVQcNtFfwVnjzr/6
         3hqXvY363sikrC7DICIaJoEnSHMaTEiujXtyhaoZadfDi1d0W4Lr1ykvGRa+5IbeD1Hk
         XkFXGqX74/4L/zUucq3t4xz1ZNzxoFM5B77pny4OVr4ILPisNeKJJ+PHMeLvNoqY9Onu
         B0IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768312123; x=1768916923;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y0YXgeg+ytlizlmEFEztYXMfGNyjkojjikqIINZXcD8=;
        b=erXXmn6RLZ4xSANoML7VKYg3TpC1nxQpRP8RhOGUU6UXIkClduSnCiicw8crJS+coa
         pORZWWnOQlRNTWiNxhabNr04Qb/24fhr675HGkkDeCzdCWHo/iCsNef5WjbTchLhih3V
         oxKGD8wmVb8+5HONSpn5qfngTUZJxN12BXPz65j5fg5xm9Z5STUGDplVGPDMNG8LX2hF
         Yxf8b4F98oAFu7oOP3tBt4TBF46IJSrpQvgs+aGE4rifVh2bWntDvJhPmZtxwkuEmLZw
         LheQgbQOzA0XVFm8XMNiezY1zpK3d+SJ7ijR1Nrzp3n9T1O5eLu8m59SnIvAhy8s1QRU
         fcMA==
X-Gm-Message-State: AOJu0YzkXB5gCDwd2RrX2kTohQvAjdcRO2PM2p0Y7TqF5Gqa6Cpo/Cmi
	6VXHyVkY+nLIjCiAiIRUXQu44uDnDapgTJM3GG0ONZ+xCYtqUP/mymNEeE/Vaw==
X-Gm-Gg: AY/fxX6r1gWPxHUiGbt9tOZSRgu1ObK70Vi6c7lcBkuhrwhPH87P4NFi/0C4ms9NjZz
	FDD0fj6dHpLgIV8MaUWkwYi5RUz6zAJRBWRRBWcDO49WjH2Dsn/OB/NbfKQiq34dimIN7yQIatr
	JdkDuRmN1Ir33qQZ3jCSdNzOfC/41zk+pukx0qqXQ8w0vqIkr9ToAqHUrsKzCyJIYgaV9Onvx3O
	mOBXwX0/8ApRpWs5WBrc0Xn8RZ7iAwRfAi9oP29gLohQ3jpS3JB9+8LEtjwix6yH2QRUZ1v+v/c
	DBscbItMois7KQ7YBkL2cmVSZZnq2M0/94XCG0mp7zpUVPOGil83Xb8h4LdMBtIJH/9BZq+MA5+
	GKxTinDoMRKBkLRo29wueHIa7OKrZ+uHUJz82s2KNVW54IGGuosnseQvNWafqCDxkrA==
X-Google-Smtp-Source: AGHT+IHbQOO0uveItRoe8yAZPkZKsuNR0NaoRwUB3BISyycdwi1BOhiZVCiY1YgtdXCahKq1xSRXtQ==
X-Received: by 2002:a05:6000:607:b0:432:b956:663e with SMTP id ffacd0b85a97d-432c37d2eb4mr31176367f8f.52.1768312123199;
        Tue, 13 Jan 2026 05:48:43 -0800 (PST)
Received: from localhost ([2620:10d:c092:400::5:51be])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432bd0e17aasm44874850f8f.15.2026.01.13.05.48.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jan 2026 05:48:42 -0800 (PST)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	kafai@meta.com,
	kernel-team@meta.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
Subject: [PATCH bpf-next v2] bpf: Use reg_state() for register access in verifier
Date: Tue, 13 Jan 2026 13:48:26 +0000
Message-ID: <20260113134826.2214860-1-mykyta.yatsenko5@gmail.com>
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
Acked-by: Andrii Nakryiko <andrii@kernel.org>
---
 kernel/bpf/verifier.c | 42 +++++++++++++++++++-----------------------
 1 file changed, 19 insertions(+), 23 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 53635ea2e41b..02a43cafbb25 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -5654,8 +5654,8 @@ static int check_stack_write(struct bpf_verifier_env *env,
 static int check_map_access_type(struct bpf_verifier_env *env, u32 regno,
 				 int off, int size, enum bpf_access_type type)
 {
-	struct bpf_reg_state *regs = cur_regs(env);
-	struct bpf_map *map = regs[regno].map_ptr;
+	struct bpf_reg_state *reg = reg_state(env, regno);
+	struct bpf_map *map = reg->map_ptr;
 	u32 cap = bpf_map_flags_to_cap(map);
 
 	if (type == BPF_WRITE && !(cap & BPF_MAP_CAN_WRITE)) {
@@ -6168,8 +6168,7 @@ static bool may_access_direct_pkt_data(struct bpf_verifier_env *env,
 static int check_packet_access(struct bpf_verifier_env *env, u32 regno, int off,
 			       int size, bool zero_size_allowed)
 {
-	struct bpf_reg_state *regs = cur_regs(env);
-	struct bpf_reg_state *reg = &regs[regno];
+	struct bpf_reg_state *reg = reg_state(env, regno);
 	int err;
 
 	/* We may have added a variable offset to the packet pointer; but any
@@ -6256,8 +6255,7 @@ static int check_sock_access(struct bpf_verifier_env *env, int insn_idx,
 			     u32 regno, int off, int size,
 			     enum bpf_access_type t)
 {
-	struct bpf_reg_state *regs = cur_regs(env);
-	struct bpf_reg_state *reg = &regs[regno];
+	struct bpf_reg_state *reg = reg_state(env, regno);
 	struct bpf_insn_access_aux info = {};
 	bool valid;
 
@@ -7453,8 +7451,7 @@ static int check_stack_access_within_bounds(
 		int regno, int off, int access_size,
 		enum bpf_access_type type)
 {
-	struct bpf_reg_state *regs = cur_regs(env);
-	struct bpf_reg_state *reg = regs + regno;
+	struct bpf_reg_state *reg = reg_state(env, regno);
 	struct bpf_func_state *state = func(env, reg);
 	s64 min_off, max_off;
 	int err;
@@ -8408,7 +8405,7 @@ static int process_spin_lock(struct bpf_verifier_env *env, int regno, int flags)
 {
 	bool is_lock = flags & PROCESS_SPIN_LOCK, is_res_lock = flags & PROCESS_RES_LOCK;
 	const char *lock_str = is_res_lock ? "bpf_res_spin" : "bpf_spin";
-	struct bpf_reg_state *regs = cur_regs(env), *reg = &regs[regno];
+	struct bpf_reg_state *reg = reg_state(env, regno);
 	struct bpf_verifier_state *cur = env->cur_state;
 	bool is_const = tnum_is_const(reg->var_off);
 	bool is_irq = flags & PROCESS_LOCK_IRQ;
@@ -8524,7 +8521,7 @@ static int process_spin_lock(struct bpf_verifier_env *env, int regno, int flags)
 static int check_map_field_pointer(struct bpf_verifier_env *env, u32 regno,
 				   enum btf_field_type field_type)
 {
-	struct bpf_reg_state *regs = cur_regs(env), *reg = &regs[regno];
+	struct bpf_reg_state *reg = reg_state(env, regno);
 	bool is_const = tnum_is_const(reg->var_off);
 	struct bpf_map *map = reg->map_ptr;
 	u64 val = reg->var_off.value;
@@ -8571,7 +8568,7 @@ static int check_map_field_pointer(struct bpf_verifier_env *env, u32 regno,
 static int process_timer_func(struct bpf_verifier_env *env, int regno,
 			      struct bpf_call_arg_meta *meta)
 {
-	struct bpf_reg_state *regs = cur_regs(env), *reg = &regs[regno];
+	struct bpf_reg_state *reg = reg_state(env, regno);
 	struct bpf_map *map = reg->map_ptr;
 	int err;
 
@@ -8595,7 +8592,7 @@ static int process_timer_func(struct bpf_verifier_env *env, int regno,
 static int process_wq_func(struct bpf_verifier_env *env, int regno,
 			   struct bpf_kfunc_call_arg_meta *meta)
 {
-	struct bpf_reg_state *regs = cur_regs(env), *reg = &regs[regno];
+	struct bpf_reg_state *reg = reg_state(env, regno);
 	struct bpf_map *map = reg->map_ptr;
 	int err;
 
@@ -8616,7 +8613,7 @@ static int process_wq_func(struct bpf_verifier_env *env, int regno,
 static int process_task_work_func(struct bpf_verifier_env *env, int regno,
 				  struct bpf_kfunc_call_arg_meta *meta)
 {
-	struct bpf_reg_state *regs = cur_regs(env), *reg = &regs[regno];
+	struct bpf_reg_state *reg = reg_state(env, regno);
 	struct bpf_map *map = reg->map_ptr;
 	int err;
 
@@ -8636,7 +8633,7 @@ static int process_task_work_func(struct bpf_verifier_env *env, int regno,
 static int process_kptr_func(struct bpf_verifier_env *env, int regno,
 			     struct bpf_call_arg_meta *meta)
 {
-	struct bpf_reg_state *regs = cur_regs(env), *reg = &regs[regno];
+	struct bpf_reg_state *reg = reg_state(env, regno);
 	struct btf_field *kptr_field;
 	struct bpf_map *map_ptr;
 	struct btf_record *rec;
@@ -8709,7 +8706,7 @@ static int process_kptr_func(struct bpf_verifier_env *env, int regno,
 static int process_dynptr_func(struct bpf_verifier_env *env, int regno, int insn_idx,
 			       enum bpf_arg_type arg_type, int clone_ref_obj_id)
 {
-	struct bpf_reg_state *regs = cur_regs(env), *reg = &regs[regno];
+	struct bpf_reg_state *reg = reg_state(env, regno);
 	int err;
 
 	if (reg->type != PTR_TO_STACK && reg->type != CONST_PTR_TO_DYNPTR) {
@@ -8829,7 +8826,7 @@ static bool is_kfunc_arg_iter(struct bpf_kfunc_call_arg_meta *meta, int arg_idx,
 static int process_iter_arg(struct bpf_verifier_env *env, int regno, int insn_idx,
 			    struct bpf_kfunc_call_arg_meta *meta)
 {
-	struct bpf_reg_state *regs = cur_regs(env), *reg = &regs[regno];
+	struct bpf_reg_state *reg = reg_state(env, regno);
 	const struct btf_type *t;
 	int spi, err, i, nr_slots, btf_id;
 
@@ -9301,7 +9298,7 @@ static int check_reg_type(struct bpf_verifier_env *env, u32 regno,
 			  const u32 *arg_btf_id,
 			  struct bpf_call_arg_meta *meta)
 {
-	struct bpf_reg_state *regs = cur_regs(env), *reg = &regs[regno];
+	struct bpf_reg_state *reg = reg_state(env, regno);
 	enum bpf_reg_type expected, type = reg->type;
 	const struct bpf_reg_types *compatible;
 	int i, j;
@@ -9714,7 +9711,7 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 			  int insn_idx)
 {
 	u32 regno = BPF_REG_1 + arg;
-	struct bpf_reg_state *regs = cur_regs(env), *reg = &regs[regno];
+	struct bpf_reg_state *reg = reg_state(env, regno);
 	enum bpf_arg_type arg_type = fn->arg_type[arg];
 	enum bpf_reg_type type = reg->type;
 	u32 *arg_btf_id = NULL;
@@ -11247,7 +11244,7 @@ record_func_key(struct bpf_verifier_env *env, struct bpf_call_arg_meta *meta,
 		int func_id, int insn_idx)
 {
 	struct bpf_insn_aux_data *aux = &env->insn_aux_data[insn_idx];
-	struct bpf_reg_state *regs = cur_regs(env), *reg;
+	struct bpf_reg_state *reg;
 	struct bpf_map *map = meta->map_ptr;
 	u64 val, max;
 	int err;
@@ -11259,7 +11256,7 @@ record_func_key(struct bpf_verifier_env *env, struct bpf_call_arg_meta *meta,
 		return -EINVAL;
 	}
 
-	reg = &regs[BPF_REG_3];
+	reg = reg_state(env, BPF_REG_3);
 	val = reg->var_off.value;
 	max = map->max_entries;
 
@@ -11405,8 +11402,7 @@ static struct bpf_insn_aux_data *cur_aux(const struct bpf_verifier_env *env)
 
 static bool loop_flag_is_zero(struct bpf_verifier_env *env)
 {
-	struct bpf_reg_state *regs = cur_regs(env);
-	struct bpf_reg_state *reg = &regs[BPF_REG_4];
+	struct bpf_reg_state *reg = reg_state(env, BPF_REG_4);
 	bool reg_is_null = register_is_null(reg);
 
 	if (reg_is_null)
@@ -12668,7 +12664,7 @@ static int process_kf_arg_ptr_to_btf_id(struct bpf_verifier_env *env,
 static int process_irq_flag(struct bpf_verifier_env *env, int regno,
 			     struct bpf_kfunc_call_arg_meta *meta)
 {
-	struct bpf_reg_state *regs = cur_regs(env), *reg = &regs[regno];
+	struct bpf_reg_state *reg = reg_state(env, regno);
 	int err, kfunc_class = IRQ_NATIVE_KFUNC;
 	bool irq_save;
 
-- 
2.52.0


