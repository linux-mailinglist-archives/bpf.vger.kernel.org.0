Return-Path: <bpf+bounces-51578-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CC857A36369
	for <lists+bpf@lfdr.de>; Fri, 14 Feb 2025 17:46:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B32A170E57
	for <lists+bpf@lfdr.de>; Fri, 14 Feb 2025 16:45:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DCDF267723;
	Fri, 14 Feb 2025 16:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hI+zsfNy"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AAD4264FA9
	for <bpf@vger.kernel.org>; Fri, 14 Feb 2025 16:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739551536; cv=none; b=kAzLH/FcDZX10LvfCgoiBvAPrAAryJ+zojLvXBw981aRJ3WsLIWk2xdGwZe8N2Eux4svnJqRaFiwlBg1l2AFRQ35F7fFqvBwSAlWd9TVSD5AIdb0ZNh7g+EcCi9oMceTADZ7vbEpMa5v0Pq9proWDsTRyL5Ok5ljk3q6rmCleb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739551536; c=relaxed/simple;
	bh=jwCq0P0Vuds6Ocs62YCkiXqCDb3BXNojP44mv3vZHMM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bnoZOIAEPUCyQH2bFA+bVcme4HWsSRy2agfRkWjnuuOmSZ6MocavwXaUkyGB8gAlVGy2OpXw9f4BJYJmrQR2HyiToeg7GmMgBUdiQynDXFxZOXeEDHZO56vL4jjDfhPKzTKvZZ+4AZlmq5kIvyT0ulmg9eGHjx1JJHicRAVqG+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hI+zsfNy; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-21f6a47d617so40449905ad.2
        for <bpf@vger.kernel.org>; Fri, 14 Feb 2025 08:45:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739551533; x=1740156333; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j4LOyoAFByV1hms7BAn0ouvPEgqOVY36PJCCwBmaLhY=;
        b=hI+zsfNy+EQXalZklIlCsOM1Ad/jJPUAem9wQ/u/SGfqwEe2Aobx2i1/FZUXHREZQF
         OA04poxEOOtuwF4puY1SPbzRc7mHXpiiL0X7kWdhBBPbePxNIRhgbge/RsrkuMaUE/f8
         RmwZoIilrxklXgOAzGVyCj9YE8yiRuWZdEXyQbzAQ8amHHahKmtpNiqFvhAIWW4YyF8l
         4jMTbLr/qsqqzTSeciTi2tAnepxSGfWc86hHy8evR/5TBX5A/qn+tqS7NeYrqgaKOo5R
         g0nDLCqhundj6j57nwecD++32kCV/2Q6D8QAw+U2hipea/shKT9dJ/V2OV3R7VOuNEDh
         qITA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739551533; x=1740156333;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j4LOyoAFByV1hms7BAn0ouvPEgqOVY36PJCCwBmaLhY=;
        b=Q+4BV3TgAHIn8X4L5lnAsyZLm9wWyyjSaCqVPTtG8/pYUEgLmYXq2BBTy3YUYyLnmd
         FvgiKXHbDh9u+0MbTuvxQwrkXYAvvXrDRxANlNBgfAnYwlVkT0YtFTixLV2G19kV3iOO
         7aVvbGEw1shX5ChlfH6lJG8pB/ujC9zYQ4wc2H0vljxqPTMQZHTn3/EYVFnFUtIeZwB+
         BH3WViUmE0Kcda1+8VgZj4IH0N9Jqfw3oZPwUvnSWh4Ps8WgEOZvNTHvVpYEo+doO4rN
         ya5VnccfCqAoCQi7YpdE142hM666VaTR7M8OZ3t93OzFBZWS2Ih9QYk6XQRzJXGvqRo6
         wuag==
X-Gm-Message-State: AOJu0YxZ171IviBy/iuYUKq5hkEvFSQUQfCCFVw9hWVTqnreutO+IgTm
	hEaQ4cWT80KKL21wYlLJVuRyaP83K7qjpR/9NF+0w/ud11Yerr2muJjSfA==
X-Gm-Gg: ASbGncsSYyZrJHMmaWgGyhcHquoLwcDDpGL8FnUzpbIGq2zeZCgrrpjM7SzumLMWov6
	/pilJJ6MACDQnOQaumMRnmhW76b0F2twquG7rsAYinJ7CrxIIKN4r2xgTCEfm+6lXpJGHbhM6rP
	f4cBGy3AhwQ6HkFwIFIfqJ4WabTMMgUDkAO+Fe5oTiiJwqKQnG/U4BnIW2R6foIfiZxN54njuqo
	+ENj877DkvQGlFq1fKvmLhYtY+KY7pzdD7RFD4PuBH/g2OF58ot71HRGYYO80+QWU/YOxWvlvGX
	xAwfuL/wfYB76PGjN1hyDt1pvWgweztyfV+MK7Dj6y19li2Jnp3vVNAJUADWXmSs0w==
X-Google-Smtp-Source: AGHT+IG1I0MAJ6fdW3Zvj7g9gZGGyQhTKYUsT3/7NDzxCGmaH7Eu9W1xDX8AtGQ/ahBCWj2z4RegWg==
X-Received: by 2002:a05:6a21:b97:b0:1ee:7483:8377 with SMTP id adf61e73a8af0-1ee8cad309cmr297586637.14.1739551533385;
        Fri, 14 Feb 2025 08:45:33 -0800 (PST)
Received: from localhost.localdomain (c-76-146-13-146.hsd1.wa.comcast.net. [76.146.13.146])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-adbf21517eesm2223346a12.13.2025.02.14.08.45.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 08:45:33 -0800 (PST)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	alexei.starovoitov@gmail.com,
	martin.lau@kernel.org,
	eddyz87@gmail.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 4/5] bpf: Allow struct_ops prog to return referenced kptr
Date: Fri, 14 Feb 2025 08:45:19 -0800
Message-ID: <20250214164520.1001211-5-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250214164520.1001211-1-ameryhung@gmail.com>
References: <20250214164520.1001211-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Amery Hung <amery.hung@bytedance.com>

Allow a struct_ops program to return a referenced kptr if the struct_ops
operator's return type is a struct pointer. To make sure the returned
pointer continues to be valid in the kernel, several constraints are
required:

1) The type of the pointer must matches the return type
2) The pointer originally comes from the kernel (not locally allocated)
3) The pointer is in its unmodified form

Implementation wise, a referenced kptr first needs to be allowed to _leak_
in check_reference_leak() if it is in the return register. Then, in
check_return_code(), constraints 1-3 are checked. During struct_ops
registration, a check is also added to warn about operators with
non-struct pointer return.

In addition, since the first user, Qdisc_ops::dequeue, allows a NULL
pointer to be returned when there is no skb to be dequeued, we will allow
a scalar value with value equals to NULL to be returned.

In the future when there is a struct_ops user that always expects a valid
pointer to be returned from an operator, we may extend tagging to the
return value. We can tell the verifier to only allow NULL pointer return
if the return value is tagged with MAY_BE_NULL.

Signed-off-by: Amery Hung <amery.hung@bytedance.com>
Acked-by: Eduard Zingerman <eddyz87@gmail.com>
---
 kernel/bpf/bpf_struct_ops.c | 12 +++++++++++-
 kernel/bpf/verifier.c       | 36 ++++++++++++++++++++++++++++++++----
 2 files changed, 43 insertions(+), 5 deletions(-)

diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
index 68df8d8b6db3..8df5e8045d07 100644
--- a/kernel/bpf/bpf_struct_ops.c
+++ b/kernel/bpf/bpf_struct_ops.c
@@ -389,7 +389,7 @@ int bpf_struct_ops_desc_init(struct bpf_struct_ops_desc *st_ops_desc,
 	st_ops_desc->value_type = btf_type_by_id(btf, value_id);
 
 	for_each_member(i, t, member) {
-		const struct btf_type *func_proto;
+		const struct btf_type *func_proto, *ret_type;
 		void **stub_func_addr;
 		u32 moff;
 
@@ -426,6 +426,16 @@ int bpf_struct_ops_desc_init(struct bpf_struct_ops_desc *st_ops_desc,
 		if (!func_proto || bpf_struct_ops_supported(st_ops, moff))
 			continue;
 
+		if (func_proto->type) {
+			ret_type = btf_type_resolve_ptr(btf, func_proto->type, NULL);
+			if (ret_type && !__btf_type_is_struct(ret_type)) {
+				pr_warn("func ptr %s in struct %s returns non-struct pointer, which is not supported\n",
+					mname, st_ops->name);
+				err = -EOPNOTSUPP;
+				goto errout;
+			}
+		}
+
 		if (btf_distill_func_proto(log, btf,
 					   func_proto, mname,
 					   &st_ops->func_models[i])) {
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index a0f51903e977..5bcf095e8d0c 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -10758,6 +10758,8 @@ record_func_key(struct bpf_verifier_env *env, struct bpf_call_arg_meta *meta,
 static int check_reference_leak(struct bpf_verifier_env *env, bool exception_exit)
 {
 	struct bpf_verifier_state *state = env->cur_state;
+	enum bpf_prog_type type = resolve_prog_type(env->prog);
+	struct bpf_reg_state *reg = reg_state(env, BPF_REG_0);
 	bool refs_lingering = false;
 	int i;
 
@@ -10767,6 +10769,12 @@ static int check_reference_leak(struct bpf_verifier_env *env, bool exception_exi
 	for (i = 0; i < state->acquired_refs; i++) {
 		if (state->refs[i].type != REF_TYPE_PTR)
 			continue;
+		/* Allow struct_ops programs to return a referenced kptr back to
+		 * kernel. Type checks are performed later in check_return_code.
+		 */
+		if (type == BPF_PROG_TYPE_STRUCT_OPS && !exception_exit &&
+		    reg->ref_obj_id == state->refs[i].id)
+			continue;
 		verbose(env, "Unreleased reference id=%d alloc_insn=%d\n",
 			state->refs[i].id, state->refs[i].insn_idx);
 		refs_lingering = true;
@@ -16405,13 +16413,14 @@ static int check_return_code(struct bpf_verifier_env *env, int regno, const char
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
 	bool return_32bit = false;
+	const struct btf_type *reg_type, *ret_type = NULL;
 
 	/* LSM and struct_ops func-ptr's return type could be "void" */
 	if (!is_subprog || frame->in_exception_callback_fn) {
@@ -16420,10 +16429,26 @@ static int check_return_code(struct bpf_verifier_env *env, int regno, const char
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
+			if (frame->in_exception_callback_fn)
+				break;
+
+			/* Allow a struct_ops program to return a referenced kptr if it
+			 * matches the operator's return type and is in its unmodified
+			 * form. A scalar zero (i.e., a null pointer) is also allowed.
+			 */
+			reg_type = reg->btf ? btf_type_by_id(reg->btf, reg->btf_id) : NULL;
+			ret_type = btf_type_resolve_ptr(prog->aux->attach_btf,
+							prog->aux->attach_func_proto->type,
+							NULL);
+			if (ret_type && ret_type == reg_type && reg->ref_obj_id)
+				return __check_ptr_off_reg(env, reg, regno, false);
 			break;
 		default:
 			break;
@@ -16445,8 +16470,6 @@ static int check_return_code(struct bpf_verifier_env *env, int regno, const char
 		return -EACCES;
 	}
 
-	reg = cur_regs(env) + regno;
-
 	if (frame->in_async_callback_fn) {
 		/* enforce return zero from async callbacks like timer */
 		exit_ctx = "At async callback return";
@@ -16545,6 +16568,11 @@ static int check_return_code(struct bpf_verifier_env *env, int regno, const char
 	case BPF_PROG_TYPE_NETFILTER:
 		range = retval_range(NF_DROP, NF_ACCEPT);
 		break;
+	case BPF_PROG_TYPE_STRUCT_OPS:
+		if (!ret_type)
+			return 0;
+		range = retval_range(0, 0);
+		break;
 	case BPF_PROG_TYPE_EXT:
 		/* freplace program can return anything as its return value
 		 * depends on the to-be-replaced kernel func or bpf program.
-- 
2.47.1


