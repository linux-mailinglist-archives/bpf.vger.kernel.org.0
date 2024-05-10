Return-Path: <bpf+bounces-29522-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F09DC8C2A7B
	for <lists+bpf@lfdr.de>; Fri, 10 May 2024 21:24:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2E590B2164C
	for <lists+bpf@lfdr.de>; Fri, 10 May 2024 19:24:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8875D4D9FE;
	Fri, 10 May 2024 19:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EojEOA3+"
X-Original-To: bpf@vger.kernel.org
Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com [209.85.217.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A38C47F6F;
	Fri, 10 May 2024 19:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715369058; cv=none; b=M77wspXhm3yTs+MV+erV2n4NEUa2TpuL/I68+0bt+TCZWvGycARTj+drMrYzy57uxQpXHaT+V5RRKO2L3VQ+fGblJxvQGqizZP7gEKyLUN7HU5UtzO4hpCHTSZwcTf3gIhQfxrxOOiluhZAGsEbreyPtfK6E1BMomUYM50+xfKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715369058; c=relaxed/simple;
	bh=qELuF+Cc4ONyICP3ZRDho6bvZLqdh+8lLbRzBJ/sj9c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CJZIUEkILWz9jOVeFyeXGVGbjNZ49siIfhcbmveisdoOFuBF6y4BzQNNO7HjA9DTZTZPcceuZfsP10YcQv154eLsIAe6AOaAKnlwvnE19fd9IPOahL/+T7g3cwic3VQNCal3+/RDtSZwyFOD/IEDQdjVzqk5iqzh2qmV2bH3w6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EojEOA3+; arc=none smtp.client-ip=209.85.217.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f50.google.com with SMTP id ada2fe7eead31-47eff9b3c23so836589137.0;
        Fri, 10 May 2024 12:24:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715369055; x=1715973855; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nq6AEd1+I0lBJLo+1769o4RMbb/mkQ7MLhlZLDxNmmo=;
        b=EojEOA3+FJiThYVa80mFOvkDyTnxQ3PEdDuma+0KtSMoj5/p1wrU5xBJjDCHgva0hq
         lhZGf7XHZ/XVgMaHXLfsBft5oR1wJ9JU4CDSH4Oxc5+PlRkqq1/xwMM3pfP8OlywwvjV
         0DpyhTdpHCjEFRO3ABwEFXFhUzB2J1elhl+gdMDtnYBKjU+8AqEhOT8Komh2O5vSv+mL
         1IG4IJoWmB/SJzPiDab4zZdq3N2DAH4XR7YS1qFa4KGy57nKUvLkU1yZa9SRFf/k7fEN
         6eROQHSDz54G68SQ8bgOT69MCYSOxSf1DgdnoTuU3c8qC5rv6lClep+WuUYirBPZdhZO
         QOWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715369055; x=1715973855;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Nq6AEd1+I0lBJLo+1769o4RMbb/mkQ7MLhlZLDxNmmo=;
        b=TnFdQB5gpWEL+nXhqtEwv+kC1A8oFJsvbjdRk1U+QK3vm3IjWlZtMfkkEcfpu3nRD6
         Bel7U9tynSYVEpQPcO0Tz1UeUNyuIWzMD1GCtSqNmXxxj4N/mNfAmR319BVjDnRCFblO
         69Iw7zONg66UswwyQGTN4toWDgvn+BrEThg5gZpm3jouJ4MqNEhEoF5bSfUGGe+unfUl
         iO5JLaWEVXDecXfQsAE/9vVU8J5kQyWmcvauCzsP+gU6DKKhbPokJVc9ueGcRlCag2ej
         hS/YuyXSUI/y2JVk+B3sK+WKUTiN8/QONP8Jda5vrR8+ebj9qp//35QtESW2st0Z0x9b
         Mw4g==
X-Gm-Message-State: AOJu0YxPu6ZUBMqFfHt8c0cvumv+B6olOLY1a/sWQrqFNoLSGkoc6XtQ
	kNkzW4X3c570+gZNnb1DiEHWHsylTsSBebpwS7y4y+a9sLJ5CCdoUV1Y5A==
X-Google-Smtp-Source: AGHT+IHRF5IxuTAH4l9jI1XQUNvEAGaE6FUQ5jYxTkr4aGznhrErLlQLLIWs1nHgP530/LEAHdKAhQ==
X-Received: by 2002:a05:6102:3a11:b0:47b:f5ce:569d with SMTP id ada2fe7eead31-48077dcd8f2mr4229851137.3.1715369055246;
        Fri, 10 May 2024 12:24:15 -0700 (PDT)
Received: from n36-183-057.byted.org ([147.160.184.83])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-43df5b46a26sm23863251cf.80.2024.05.10.12.24.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 May 2024 12:24:14 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
X-Google-Original-From: Amery Hung <amery.hung@bytedance.com>
To: netdev@vger.kernel.org
Cc: bpf@vger.kernel.org,
	yangpeihao@sjtu.edu.cn,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@kernel.org,
	sinquersw@gmail.com,
	toke@redhat.com,
	jhs@mojatatu.com,
	jiri@resnulli.us,
	sdf@google.com,
	xiyou.wangcong@gmail.com,
	yepeilin.cs@gmail.com,
	ameryhung@gmail.com
Subject: [RFC PATCH v8 03/20] bpf: Allow struct_ops prog to return referenced kptr
Date: Fri, 10 May 2024 19:23:55 +0000
Message-Id: <20240510192412.3297104-4-amery.hung@bytedance.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20240510192412.3297104-1-amery.hung@bytedance.com>
References: <20240510192412.3297104-1-amery.hung@bytedance.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch allows a struct_ops program to return a referenced kptr
if the struct_ops member has a pointer return type. To make sure the
pointer returned to kernel is valid, it needs to be referenced and
originally comes from the kernel. That is, it should be acquired
through kfuncs or struct_ops "ref_acquried" arguments, but not allocated
locally. Besides, null pointer is allowed. Therefore, kernel caller
of the struct_ops function consuming the pointer needs to take care of
the potential null pointer.

The first use case will be Qdisc_ops::dequeue, where a qdisc returns a
pointer to the skb to be dequeued.

To achieve this, we first allow a reference object to leak through return
if it is in the return register and the type matches the return type of the
function. Then, we check whether the pointer to-be-returned is valid in
check_return_code().

Signed-off-by: Amery Hung <amery.hung@bytedance.com>
---
 kernel/bpf/verifier.c | 50 +++++++++++++++++++++++++++++++++++++++----
 1 file changed, 46 insertions(+), 4 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 06a6edd306fd..2d4a55ead85b 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -10081,16 +10081,36 @@ record_func_key(struct bpf_verifier_env *env, struct bpf_call_arg_meta *meta,
 
 static int check_reference_leak(struct bpf_verifier_env *env, bool exception_exit)
 {
+	enum bpf_prog_type type = resolve_prog_type(env->prog);
+	u32 regno = exception_exit? BPF_REG_1 : BPF_REG_0;
+	struct bpf_reg_state *reg = reg_state(env, regno);
 	struct bpf_func_state *state = cur_func(env);
+	const struct bpf_prog *prog = env->prog;
+	const struct btf_type *ret_type = NULL;
 	bool refs_lingering = false;
+	struct btf *btf;
 	int i;
 
 	if (!exception_exit && state->frameno && !state->in_callback_fn)
 		return 0;
 
+	if (type == BPF_PROG_TYPE_STRUCT_OPS &&
+	    reg->type & PTR_TO_BTF_ID && reg->ref_obj_id) {
+		btf = bpf_prog_get_target_btf(prog);
+		ret_type = btf_type_by_id(btf, prog->aux->attach_func_proto->type);
+		if (reg->btf_id != ret_type->type) {
+			verbose(env, "Return kptr type, struct %s, doesn't match function prototype, struct %s\n",
+				btf_type_name(reg->btf, reg->btf_id),
+				btf_type_name(btf, ret_type->type));
+			return -EINVAL;
+		}
+	}
+
 	for (i = 0; i < state->acquired_refs; i++) {
 		if (!exception_exit && state->in_callback_fn && state->refs[i].callback_ref != state->frameno)
 			continue;
+		if (ret_type && reg->ref_obj_id == state->refs[i].id)
+			continue;
 		verbose(env, "Unreleased reference id=%d alloc_insn=%d\n",
 			state->refs[i].id, state->refs[i].insn_idx);
 		refs_lingering = true;
@@ -15395,12 +15415,15 @@ static int check_return_code(struct bpf_verifier_env *env, int regno, const char
 	const char *exit_ctx = "At program exit";
 	struct tnum enforce_attach_type_range = tnum_unknown;
 	const struct bpf_prog *prog = env->prog;
-	struct bpf_reg_state *reg;
+	struct bpf_reg_state *reg = reg_state(env, regno);
 	struct bpf_retval_range range = retval_range(0, 1);
 	enum bpf_prog_type prog_type = resolve_prog_type(env->prog);
 	int err;
 	struct bpf_func_state *frame = env->cur_state->frame[0];
 	const bool is_subprog = frame->subprogno;
+	struct btf *btf = bpf_prog_get_target_btf(prog);
+	bool st_ops_ret_is_kptr = false;
+	const struct btf_type *t;
 
 	/* LSM and struct_ops func-ptr's return type could be "void" */
 	if (!is_subprog || frame->in_exception_callback_fn) {
@@ -15409,10 +15432,26 @@ static int check_return_code(struct bpf_verifier_env *env, int regno, const char
 			if (prog->expected_attach_type == BPF_LSM_CGROUP)
 				/* See below, can be 0 or 0-1 depending on hook. */
 				break;
-			fallthrough;
+			if (!prog->aux->attach_func_proto->type)
+				return 0;
+			break;
 		case BPF_PROG_TYPE_STRUCT_OPS:
 			if (!prog->aux->attach_func_proto->type)
 				return 0;
+
+			t = btf_type_by_id(btf, prog->aux->attach_func_proto->type);
+			if (btf_type_is_ptr(t)) {
+				/* Allow struct_ops programs to return kptr or null if
+				 * the return type is a pointer type.
+				 * check_reference_leak has ensured the returning kptr
+				 * matches the type of the function prototype and is
+				 * the only leaking reference. Thus, we can safely return
+				 * if the pointer is in its unmodified form
+				 */
+				if (reg->type & PTR_TO_BTF_ID)
+					return __check_ptr_off_reg(env, reg, regno, false);
+				st_ops_ret_is_kptr = true;
+			}
 			break;
 		default:
 			break;
@@ -15434,8 +15473,6 @@ static int check_return_code(struct bpf_verifier_env *env, int regno, const char
 		return -EACCES;
 	}
 
-	reg = cur_regs(env) + regno;
-
 	if (frame->in_async_callback_fn) {
 		/* enforce return zero from async callbacks like timer */
 		exit_ctx = "At async callback return";
@@ -15522,6 +15559,11 @@ static int check_return_code(struct bpf_verifier_env *env, int regno, const char
 	case BPF_PROG_TYPE_NETFILTER:
 		range = retval_range(NF_DROP, NF_ACCEPT);
 		break;
+	case BPF_PROG_TYPE_STRUCT_OPS:
+		if (!st_ops_ret_is_kptr)
+			return 0;
+		range = retval_range(0, 0);
+		break;
 	case BPF_PROG_TYPE_EXT:
 		/* freplace program can return anything as its return value
 		 * depends on the to-be-replaced kernel func or bpf program.
-- 
2.20.1


