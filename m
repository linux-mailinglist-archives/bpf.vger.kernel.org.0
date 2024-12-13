Return-Path: <bpf+bounces-46948-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 036C19F19F9
	for <lists+bpf@lfdr.de>; Sat, 14 Dec 2024 00:31:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 507A57A0489
	for <lists+bpf@lfdr.de>; Fri, 13 Dec 2024 23:31:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53CAE1F2375;
	Fri, 13 Dec 2024 23:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="PqR9jZC0"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5AB81EF0AA
	for <bpf@vger.kernel.org>; Fri, 13 Dec 2024 23:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734132607; cv=none; b=UJrcQrke9eQkeSwZOVDzUF1Di4saRKTEmeY0mExh7jhyC25BMYx1CTIjXsB298mzIGd/3Onyms0QmcbqeoBnjCx7XbfhVHKY5FbCdQKterk4v1SDson9fG/56TyuYlbP6rsPmhoCeO0R0HGqeQwEY2sgI9N7RTPOnsQp4CmtIzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734132607; c=relaxed/simple;
	bh=rO2nseOhkawG+8YRK6fu8d6yVEe8z8rn5Ny5rTBCLAM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QP1oLLVzyVUNLvtiv4p6w1hXIhyrs7B7LTvRUO4+JLRkebiQPIk7ysMO0vBslhOxqwEB2mARVU9d4h8isfaSKHF9J6kJIzgDQmJyRA1NIl6Nrg/AOCzzpWyNG9SHqTbYagJ0KZBrxQbDPr+3ZZh6MB+mh32zFUYP8fILJJcrgmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=PqR9jZC0; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-46677ef6910so24385881cf.2
        for <bpf@vger.kernel.org>; Fri, 13 Dec 2024 15:30:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1734132603; x=1734737403; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KzGU7EA7+CxZZl0ZD9zaKpznoSGHASSKNfn0psVXEmc=;
        b=PqR9jZC0t9BYU8X0ngkMaFm1bUHoDJ7aQGFC4gJkdRz2e/n3NYAsbL5gzwlOT6AkwB
         Rp4v8H15HOwY8GXXeRLB0CEPNYOrHtQTSR3ZM8vIy9BGarMDk9GSD3RmV4hpLZisaQBU
         g8ka3BzC1aG016WUmP2keXrstmm931BupWXD50ahBX2XgJVRvafX49CNhoAcPQYy62bk
         XYPiNrNi/KK/b0MNDVOsWjchzVefDWFhk8SDo9f04E0QiZmNkUS23paZa3XrVBTqjSjO
         a4GU23TL15JbtXONRdcYt5IXwMWMzyCTcKWjRPIYN5KSJY9BiVUoNhsjepeWvTub3T0z
         hEMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734132603; x=1734737403;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KzGU7EA7+CxZZl0ZD9zaKpznoSGHASSKNfn0psVXEmc=;
        b=r0V3pxZ10SZILVHcSeEMBOfo22NU7aLdKplke+74ANkLnlZopq8+iawctkLCXp05Ef
         c+3aGkSU5DiPg1KZ05faWp1HpbyVP5lQ9aV6mvk0K9vygEkwtgd8KxxZfLQABfYslfmu
         Cqhtt5nBFK8b1p6bPYt2ln7Y9T8dqkga1us6kf5XxLbvkmSKDfLbvDM2X8vzsKvUqWqt
         6Hlb4PR3sg66Rtw6Fn5G7KDbXXg/erBjYgk+OSLV2Uzoi7I0IaxK3jXPp299uMlwuWZS
         SzpF4ZAe7dAxLiNj4g2EBaG+FXUHyPzQ8p/fTo/EcIeHw8Z5/QhibAUh9pgJDmYupjCc
         gD7g==
X-Gm-Message-State: AOJu0YzIXpS/XNOJNB0q9EQ/W6+X/9DPl8Z/A2AY+8b8rRQovg5y+2ej
	kRE2iV2WvxXyUFe3ygPmrA5j5pMrMgXoD0HVerVAG8qWAxdvRpcuHmIsTTON+gs=
X-Gm-Gg: ASbGncvJo6BqMHEGshSavP8r98HtCTaqXB7v6kXB0/9nlYk6P2K0DaHVKuEWwusdkT/
	W7RNhcXhf3vDaHA7QAIDRVwfusQjtzhrVkkZU2+VpxIC1yrjhmJlgHf5Y/tgeojDw74rCyrkQ5R
	HoiBWBB5oY17dEqrHKgWqLb2z+RCcl9fbX4FExPRziqi81WwUSOTlKZV81fvLIlnVpKlNsxHVGg
	6YXcIM2v6RUmpe3HMBs9BH5UCYD9DH5MfppwTWGvpz7hk1Fvvh/PxL41+EjGrbQnr+fCeQjuIgB
X-Google-Smtp-Source: AGHT+IFOEyawTuzhelkkZ5YhLC25ny1ozPpE10IusXh4SvjdnogSFTsDawNErpwZUT+xA6XS+MMaxg==
X-Received: by 2002:a05:622a:1990:b0:467:5375:5804 with SMTP id d75a77b69052e-467a58296bemr87127611cf.38.1734132603562;
        Fri, 13 Dec 2024 15:30:03 -0800 (PST)
Received: from n36-183-057.byted.org ([130.44.215.64])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b7047d4a20sm25805085a.39.2024.12.13.15.30.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2024 15:30:03 -0800 (PST)
From: Amery Hung <amery.hung@bytedance.com>
To: netdev@vger.kernel.org
Cc: bpf@vger.kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	alexei.starovoitov@gmail.com,
	martin.lau@kernel.org,
	sinquersw@gmail.com,
	toke@redhat.com,
	jhs@mojatatu.com,
	jiri@resnulli.us,
	stfomichev@gmail.com,
	ekarani.silvestre@ccc.ufcg.edu.br,
	yangpeihao@sjtu.edu.cn,
	xiyou.wangcong@gmail.com,
	yepeilin.cs@gmail.com,
	ameryhung@gmail.com
Subject: [PATCH bpf-next v1 03/13] bpf: Allow struct_ops prog to return referenced kptr
Date: Fri, 13 Dec 2024 23:29:48 +0000
Message-Id: <20241213232958.2388301-4-amery.hung@bytedance.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20241213232958.2388301-1-amery.hung@bytedance.com>
References: <20241213232958.2388301-1-amery.hung@bytedance.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Allow a struct_ops program to return a referenced kptr if the struct_ops
operator's return type is a struct pointer. To make sure the returned
pointer continues to be valid in the kernel, several constraints are
required:

1) The type of the pointer must matches the return type
2) The pointer originally comes from the kernel (not locally allocated)
3) The pointer is in its unmodified form

Implementation wise, a referenced kptr first needs to be allowed to leak
in check_reference_leak() if it is in the return register. Then, in
check_return_code(), constraints 1-3 are checked.

In addition, since the first user, Qdisc_ops::dequeue, allows a NULL
pointer to be returned when there is no skb to be dequeued, we will allow
a scalar value with value equals to NULL to be returned.

In the future when there is a struct_ops user that always expects a valid
pointer to be returned from an operator, we may extend tagging to the
return value. We can tell the verifier to only allow NULL pointer return
if the return value is tagged with MAY_BE_NULL.

Signed-off-by: Amery Hung <amery.hung@bytedance.com>
---
 kernel/bpf/verifier.c | 42 ++++++++++++++++++++++++++++++++++++++----
 1 file changed, 38 insertions(+), 4 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 69753096075f..c04028106710 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -10453,6 +10453,8 @@ record_func_key(struct bpf_verifier_env *env, struct bpf_call_arg_meta *meta,
 
 static int check_reference_leak(struct bpf_verifier_env *env, bool exception_exit)
 {
+	enum bpf_prog_type type = resolve_prog_type(env->prog);
+	struct bpf_reg_state *reg = reg_state(env, BPF_REG_0);
 	struct bpf_func_state *state = cur_func(env);
 	bool refs_lingering = false;
 	int i;
@@ -10463,6 +10465,12 @@ static int check_reference_leak(struct bpf_verifier_env *env, bool exception_exi
 	for (i = 0; i < state->acquired_refs; i++) {
 		if (state->refs[i].type != REF_TYPE_PTR)
 			continue;
+		/* Allow struct_ops programs to leak referenced kptr through return value.
+		 * Type checks are performed later in check_return_code.
+		 */
+		if (type == BPF_PROG_TYPE_STRUCT_OPS && !exception_exit &&
+		    reg->ref_obj_id == state->refs[i].id)
+			continue;
 		verbose(env, "Unreleased reference id=%d alloc_insn=%d\n",
 			state->refs[i].id, state->refs[i].insn_idx);
 		refs_lingering = true;
@@ -15993,13 +16001,15 @@ static int check_return_code(struct bpf_verifier_env *env, int regno, const char
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
+	struct btf *btf = bpf_prog_get_target_btf(prog);
+	const struct btf_type *ret_type = NULL;
 
 	/* LSM and struct_ops func-ptr's return type could be "void" */
 	if (!is_subprog || frame->in_exception_callback_fn) {
@@ -16008,10 +16018,31 @@ static int check_return_code(struct bpf_verifier_env *env, int regno, const char
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
+			ret_type = btf_type_by_id(btf, prog->aux->attach_func_proto->type);
+			if (btf_type_is_ptr(ret_type) && reg->type & PTR_TO_BTF_ID &&
+			    reg->ref_obj_id) {
+				if (reg->btf_id != ret_type->type) {
+					verbose(env, "Return kptr type, struct %s, doesn't match function prototype, struct %s\n",
+						btf_type_name(reg->btf, reg->btf_id),
+						btf_type_name(btf, ret_type->type));
+					return -EINVAL;
+				}
+				return __check_ptr_off_reg(env, reg, regno, false);
+			}
 			break;
 		default:
 			break;
@@ -16033,8 +16064,6 @@ static int check_return_code(struct bpf_verifier_env *env, int regno, const char
 		return -EACCES;
 	}
 
-	reg = cur_regs(env) + regno;
-
 	if (frame->in_async_callback_fn) {
 		/* enforce return zero from async callbacks like timer */
 		exit_ctx = "At async callback return";
@@ -16133,6 +16162,11 @@ static int check_return_code(struct bpf_verifier_env *env, int regno, const char
 	case BPF_PROG_TYPE_NETFILTER:
 		range = retval_range(NF_DROP, NF_ACCEPT);
 		break;
+	case BPF_PROG_TYPE_STRUCT_OPS:
+		if (!ret_type || !btf_type_is_ptr(ret_type))
+			return 0;
+		range = retval_range(0, 0);
+		break;
 	case BPF_PROG_TYPE_EXT:
 		/* freplace program can return anything as its return value
 		 * depends on the to-be-replaced kernel func or bpf program.
-- 
2.20.1


