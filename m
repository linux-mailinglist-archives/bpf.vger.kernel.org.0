Return-Path: <bpf+bounces-51011-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FCE4A2F586
	for <lists+bpf@lfdr.de>; Mon, 10 Feb 2025 18:44:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 903151883F98
	for <lists+bpf@lfdr.de>; Mon, 10 Feb 2025 17:44:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBA86257427;
	Mon, 10 Feb 2025 17:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DI7kF90t"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4CD02566D9;
	Mon, 10 Feb 2025 17:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739209433; cv=none; b=CLX+UR/VYlGju8Rp7ul3qSFjYwknLgR6zvsMYO4h36sxrTGUZXvgWfq7ydFT0MDFAGRC1xAwllpZwZ7Nj9o/aUZ+IBqBNaVRcbx1quOaDsuXnvgV9AVO9ad05UzOMh9tYAnx6pKZKA0YB1Fgr1y0iPaheWvlpKYKuDRFEygYPIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739209433; c=relaxed/simple;
	bh=jwCq0P0Vuds6Ocs62YCkiXqCDb3BXNojP44mv3vZHMM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n4LAQo/rlAG+Q+nzMhLo9Bj9wy4A+wPGMxN3B3dXBy+XWMZ+jGRERvQaldkEGBYXfojMTl6vb2W6F8Q9E2BpE7pBJcUeQhL4GaYq+aubzEzkkbPqbMLMHa6kZaQJT/g4rlDN8n3ddWnrU7j+3+x6HyD/RZ+R+s8xuHRydYIG0qI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DI7kF90t; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2fa488351ffso3128745a91.3;
        Mon, 10 Feb 2025 09:43:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739209431; x=1739814231; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j4LOyoAFByV1hms7BAn0ouvPEgqOVY36PJCCwBmaLhY=;
        b=DI7kF90tJXzm4LuHhLxH0UpOCL/hMpXIBmmpyPdHKb7zoKZSxMcMR7aWJE78bDlpGj
         vRXQkF8VsDxCeEqeNcJRpMFB+Qe8iSR5cpwGcfNijcjRnGI11Y84SN4F9tlDQOSlWRWD
         JhxeTg/Z/sjv9qMK3M3fw90tPT8CH4bw5m9nt29oz0uWr4RO0p5IB2fFMmVAhabaci3d
         6OddO+cWvLalKXwE6qYmUpdvhF2lxltlauW0Jmu8MPdZnO5AV+HsU0ix9sm14aqD6X+D
         Ps56B0vTG6sclM82HC57nZ/D3wIVWcA+U5XhM8c53ckM9rwA8Jod1ysK3kDBMJaeVt2r
         m5cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739209431; x=1739814231;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j4LOyoAFByV1hms7BAn0ouvPEgqOVY36PJCCwBmaLhY=;
        b=Dg5j6nTxhuZRLu1CpGDt99+0MyPPwZXVs3AjmpBpujO6ssttxf8xybUDnREkNkJ+em
         VFeMa6/+p72V01yvInoRacVw+QBX5XnsKUC7hi9NZSJ2K1yk5SosAoH3gAPyAl0b+0Wh
         aBCRqoKJZA/pQIEcArxl81x6i7/Ay/PoKcelj8Z/gd8O8FEvTH3nZlLgirVW6hFcxyMr
         RVsCQ+/BJIVLUhnTGhDwOLTWoQ3Ix+rtsAx0ePTS17U3gCgSg601tLnAOxNmkhjqGcCV
         UJJEeQn9vR6Mbj4JAQLVmkFHoWgzTRoMVUuFgu2rYlhEAPbrvwDQ9+/k2SYKLO9EUoVU
         6hnw==
X-Gm-Message-State: AOJu0YwMZgkkAJvy46eU3oIyrl7X4wnjjgOWGpaVjOQcn+8UW3q/a7f5
	UtOSheDVD8bg1S6F9cN8u5BCJQupF5khUvC6SEwWtRIk8yuMFB/st7Lk7/Pj
X-Gm-Gg: ASbGncsTt/pi5H3ubewZMSNQcdXT10LRPhsRvIVZdbGUJotxt2d29+PEeE1EvPlAur3
	voUmXhhV9PPWAwj5y64C86rk6x1fiyKqqmKwLZ6Ihx3alc1wK1VtGqtheh2aBXxDgwEvHMJzOw9
	6SZM/MA4fk+RfQU5sWwkxoKcDyS5Ewii5Q9BD/zHvGYucCFNwJfYw9QdLHiXtzaPvzUMFvDRiZ8
	yMK3tpsp503mL+VMfOfwxIBk0eK4GUO80GAjhU92HJtPzw9SsF5v2mkjV43twI3fvXve6y4XY/p
	gytdS8t0oD27vD3FbwBKL1Nh/BIYW1U10Eu+cL3cLsiXafd8ZJpvWBk6AJ9vFSV7LQ==
X-Google-Smtp-Source: AGHT+IEECGJ+K4Gg6yu4G/m5LgktDngJxq/9vNOgFd9TN9oFeKhAD8AO8p4kEdQCU7tsdvoiZpevmA==
X-Received: by 2002:a17:90b:3fc3:b0:2fa:2217:531b with SMTP id 98e67ed59e1d1-2fa2417827dmr20510777a91.21.1739209430787;
        Mon, 10 Feb 2025 09:43:50 -0800 (PST)
Received: from localhost.localdomain (c-76-146-13-146.hsd1.wa.comcast.net. [76.146.13.146])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fa3fb55dcasm5554961a91.4.2025.02.10.09.43.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 09:43:50 -0800 (PST)
From: Amery Hung <ameryhung@gmail.com>
To: netdev@vger.kernel.org
Cc: bpf@vger.kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	alexei.starovoitov@gmail.com,
	martin.lau@kernel.org,
	kuba@kernel.org,
	edumazet@google.com,
	xiyou.wangcong@gmail.com,
	cong.wang@bytedance.com,
	jhs@mojatatu.com,
	sinquersw@gmail.com,
	toke@redhat.com,
	jiri@resnulli.us,
	stfomichev@gmail.com,
	ekarani.silvestre@ccc.ufcg.edu.br,
	yangpeihao@sjtu.edu.cn,
	yepeilin.cs@gmail.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v4 04/19] bpf: Allow struct_ops prog to return referenced kptr
Date: Mon, 10 Feb 2025 09:43:18 -0800
Message-ID: <20250210174336.2024258-5-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250210174336.2024258-1-ameryhung@gmail.com>
References: <20250210174336.2024258-1-ameryhung@gmail.com>
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


