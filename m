Return-Path: <bpf+bounces-51774-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B236AA38BF6
	for <lists+bpf@lfdr.de>; Mon, 17 Feb 2025 20:07:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 08BB11893872
	for <lists+bpf@lfdr.de>; Mon, 17 Feb 2025 19:07:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0FAE23716C;
	Mon, 17 Feb 2025 19:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PcOpMKht"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC227236A8E
	for <bpf@vger.kernel.org>; Mon, 17 Feb 2025 19:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739819217; cv=none; b=HpL6qd+Dj8LNv9GnPp4/Y9TFzuSgkewpvA/YCcVxq2lNakwjdKBDTWbVDnZCObDSWOlkSgXyxXK8YlD2GZGmHX+4bZTPCN7TKZ4Xpjj6FwxIV/ia+RPJhqdB3yHja5A9vUJcF+Xmpb7NbWuVglXwxYQJS3ICQtnr4qo9xK2Tnk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739819217; c=relaxed/simple;
	bh=VrWOKItKi+aqzwqEqfr4PnvrNE6rtrZzlTL0R/ftliM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P7Y5b4awZfn3nytRqwv/+M1Vs2raedUR3mL1bW/CxbV/4nJpV0E5udPylLAPPyby7Suhi83uCdBRr2DnteOIjvkIUvp8UFSBqfwkwphp+/XQGo/aGZiJdV5HRBgTsJ5oAK7yQLwwh9fV8iBaVU1bjNAZdma970r+H1rypOeSqFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PcOpMKht; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-220ca204d04so61311065ad.0
        for <bpf@vger.kernel.org>; Mon, 17 Feb 2025 11:06:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739819215; x=1740424015; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iyMP7bE3blZYE++KC95HR+8OMpqx5REI9QqW+ysp1Is=;
        b=PcOpMKhthL596lbI84rdgUgvNPXqU/Ycf9AopBdFSG2nfal3gPhVlMCxqsjt9TaT/j
         qgtJT5k0lkXPHaH9yX9V9AMT37B+v90FW+SX54U+rLey+mUk8T4JLJp6n9vp7Z2XFuXV
         8yNV1nPB/T+T/jrP3d1UkqU2rnSFIMnIEUi4fUrHflNbPVbxFz6rV6x7qSNdJlChbaY5
         fPuaGimtmb25EjFfoPP9z6PTUhQgD/wv1os/vf7/1PHVjXN+UTBGhmihvXMi0spnuvyo
         kx+lpOxzv2Cg7t9EQaUPT7rzsVem0jLWfo7odIr2uQ9YV1QEDPeKFNlVNTQYY9VGEK3e
         faug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739819215; x=1740424015;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iyMP7bE3blZYE++KC95HR+8OMpqx5REI9QqW+ysp1Is=;
        b=izRHP5WCbsPVkyvvX6xgq6NwmomkjJ+hJjsTUYWDfx7Kw0Im815tv4LoNlQMgTAk9a
         k8gadPQtmidnYUj+ZYdo/aIx1pRadt7BxNuP8myuO7JTwmgHpV9ALbS0O1u70MYHRpWB
         5/fRCoUvteDdGfjHofZzk+pF1rjsEWEUerfoeWkMtoybfwAq4Uho4klRYGIXOJ253VMS
         1fsfU5gBdgZkQPgEbFZpnMvBgZTeeNNMezowj0uRii46eB5FfagbeX8kyBsZS9kax0kx
         ArNQ3kpTgLyx/C5uE/AxFTsaTerKEXeyriuNajIezVjk3lF411NJX9J9SWMZGiEj+u3s
         Eqhw==
X-Gm-Message-State: AOJu0YzkphgvDQIgdwGUNwJO/C3aeL3oY8VKy1avnW6TaEyA4Al/Uwqm
	hTLhgf32PZFAsHZTbB0N+VzhaNNO3kF9KUUqT5TbNM7xWJTYWmeFwdsGDQ==
X-Gm-Gg: ASbGnctbBQDuZthBHKWc7mHRNWn2YDoW00i/kno0DHar3qKUvzVqhuig175q0xH2sO9
	9jY2cFi+3Z3JYi93efjI1p7g7cEFj0Zes45Nh1w14vjO7/Ad+TDtsA5zfI4Jhe9zMvCB4w4jEBH
	cUyFhOrEg/HfxLLj66bjl58EJIuoui7Xt9xyZuZmpNpQ7f/ky0Knt8UQRN488HpPAFvfRKx1vGu
	0DzQjuwmIeF2e8AUwRNq9XmVnj7bJTlM2pRLG4e3jRcQpjGHXwGty3oB8MZp1XjZrG0b4ly4bl1
	02/8D5DIvl2XuX42onCDCqU5POWGEPz2P5qy7ZQLZlhYAo0u2OX7MayOg3GAjmyu1g==
X-Google-Smtp-Source: AGHT+IEU8wqFpgbyzh6M3D2eEQIdC4tVMyRrNZrodPHnIguvw8QQkm5PL4PAiZeCV0XlUNK2kBi0jw==
X-Received: by 2002:a05:6a00:2d9d:b0:730:f1b7:9bc4 with SMTP id d2e1a72fcca58-73261779914mr17864707b3a.4.1739819214655;
        Mon, 17 Feb 2025 11:06:54 -0800 (PST)
Received: from localhost.localdomain (c-76-146-13-146.hsd1.wa.comcast.net. [76.146.13.146])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73265f98e18sm5039118b3a.106.2025.02.17.11.06.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 11:06:53 -0800 (PST)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	alexei.starovoitov@gmail.com,
	martin.lau@kernel.org,
	eddyz87@gmail.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v2 4/5] bpf: Allow struct_ops prog to return referenced kptr
Date: Mon, 17 Feb 2025 11:06:39 -0800
Message-ID: <20250217190640.1748177-5-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250217190640.1748177-1-ameryhung@gmail.com>
References: <20250217190640.1748177-1-ameryhung@gmail.com>
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
Acked-by: Martin KaFai Lau <martin.lau@kernel.org>
---
 kernel/bpf/bpf_struct_ops.c | 12 +++++++++++-
 kernel/bpf/verifier.c       | 36 ++++++++++++++++++++++++++++++++----
 2 files changed, 43 insertions(+), 5 deletions(-)

diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
index 0ef00f7f64c9..db13ee70d94d 100644
--- a/kernel/bpf/bpf_struct_ops.c
+++ b/kernel/bpf/bpf_struct_ops.c
@@ -390,7 +390,7 @@ int bpf_struct_ops_desc_init(struct bpf_struct_ops_desc *st_ops_desc,
 	st_ops_desc->value_type = btf_type_by_id(btf, value_id);
 
 	for_each_member(i, t, member) {
-		const struct btf_type *func_proto;
+		const struct btf_type *func_proto, *ret_type;
 		void **stub_func_addr;
 		u32 moff;
 
@@ -427,6 +427,16 @@ int bpf_struct_ops_desc_init(struct bpf_struct_ops_desc *st_ops_desc,
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
index 9941ce754134..85b2d4e65834 100644
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


