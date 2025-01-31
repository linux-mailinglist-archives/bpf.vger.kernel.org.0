Return-Path: <bpf+bounces-50225-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EDA4A24348
	for <lists+bpf@lfdr.de>; Fri, 31 Jan 2025 20:30:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFF0E167FBF
	for <lists+bpf@lfdr.de>; Fri, 31 Jan 2025 19:29:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E1191F2C4C;
	Fri, 31 Jan 2025 19:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UcEBfJPh"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E87EE1F37D5;
	Fri, 31 Jan 2025 19:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738351768; cv=none; b=A/CukftG+8BVoAeWg/f50rKXLB7rCGJ+PjU6VaAwlVN+5Cu2ba0lJalQ3/jeNmhehlp1jc6iGjxzNw95PQ5Jg3gq/7Djlgjknt2f0EJv1N+1dKYttrADfNZBCwOIzZsiELxSE0hLxd53aXpWce5vphjLD4HJwlex98LBgVjX2Yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738351768; c=relaxed/simple;
	bh=vqBnJCqLsHZMfRWS6PNQnHG80lG6jVLSKXQhR8oX1Pw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XtJLUgQdrl7/zRQBghjeSVTXrgvbwN4TfLFL1QxiVyDW0Km1FnqTqV7M09x6q+bAlxctPu0Kb+nZlN2rIba26UOoQr98Ckj2AQs9kVc56K0y9JqkPuM0iaFnM5HFEFgQbueJFkdR1I5OzRXcTMqWv/I+dNEYd+ad+yfQ3I4JFsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UcEBfJPh; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2ee786b3277so3197862a91.1;
        Fri, 31 Jan 2025 11:29:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738351766; x=1738956566; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SZH8+9xA7t+NvI67ZN2R2VonRxu9XPdlzrbFaeXMWx8=;
        b=UcEBfJPhra/92pSZBdtMCMfxnz32e3wrZlLm0n+INXiXyvGAQIplB7yANZH7XSBv06
         3KbihvG5ZjA874EpW230ZyCgrOhGM0QMzc1xKcPTtwWSnJo6aKb8TS+qwWVIufTmeFRg
         T5OLkjc/Ib9MLdr/lvA7GK/viMSYbFX82hR1G2YJzsANfZ2VMfFwEqX6h0nQKtB+OeGf
         1prRaCwideZ8n1t3t+oTqi5e01TOk6O2WEk/YH1fTM1pfzcLRSINJTLsqGPPPIouSZzF
         +RQH/JK0xVCBNkjBbBu9O3muaKV+u/c9yDOmY2H3F1rgBoncgYWGVnE9yKp1/zs+HLea
         owkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738351766; x=1738956566;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SZH8+9xA7t+NvI67ZN2R2VonRxu9XPdlzrbFaeXMWx8=;
        b=MlV8kh8IcoG6PYjQgszDaJN59qNrfotgsaGO4HRBpBPzMm36iiHz6NNHOyeL2NSKoC
         iwSqjbapfUzv1nstu7UkfjCgIOTYS96asEcplADIR31RAA0vpdlOSWZqeL9hbkHt0BHv
         wSAXLKbgDzMexaraUipRpt+XXqUvP66dB3y91Ri0NUL7J6RD5GbJJoXcGzRIpcRL8naH
         ccEco2HM44KJhCUmX3I3mINJG0H2Y2fj/VfLzu2hB4cPo3O0S9fbeXEbPS1TNADf7uhd
         bkW3Pu662hZde1WBhfqBAhdOhIQq6zMefIR+Lxtbc11kfvPACvCe3WZ4utxt+ALK1cWQ
         vvng==
X-Gm-Message-State: AOJu0YxSTCujHZxZn2kdGGHGrPlFvg5Fb3tlf1UxirevrQFVdTU+ZKPg
	/AEc9iHlydAvMqF03ECFSuBkDDUsKoRwtrTi3eZxo3gjmPbX14q77NDd53Ab39I=
X-Gm-Gg: ASbGnctMEQp2UfqBjfqdSAA9u/N35WQCDvzSDITKda7bWg77c1H0HhwvhvS1kNh6Wr6
	naHSZyor/vtO1Tmo6fAr+VO/3QQTdud+aM60tVyFfOlN6vEaAMHvwXuClZK5EMHNNDg5lTHncyW
	SjX7uVzdLm+3aDalX14Va90woRLq1o6vJu9saN1BD0MTFpIM9neLFl6POZimeqf8uQAbTCgJmes
	TTDUjkKpqalUlDRxp46AGpqQ6nlRUZynt+RYdIis4f26xHcOAVwJMnnarSDXMFoMdt/LUES4Ccj
	btBcOEFDZghnuAFWdS/OiyksxMq4WOYy65GKiA9zJk5TXR9ecTPJAYLAba0tiTtLaA==
X-Google-Smtp-Source: AGHT+IHo8X/v7PwhwXN4Mn6YUUFPQw54ECamlgVdmI1BeAMioMj/lvyh7I6iv1+6HPCjotXyPEOS7w==
X-Received: by 2002:a17:90b:5150:b0:2ee:c2b5:97a0 with SMTP id 98e67ed59e1d1-2f83ac72363mr17383985a91.25.1738351766066;
        Fri, 31 Jan 2025 11:29:26 -0800 (PST)
Received: from localhost.localdomain (c-76-146-13-146.hsd1.wa.comcast.net. [76.146.13.146])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f8489d3707sm4072471a91.23.2025.01.31.11.29.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jan 2025 11:29:25 -0800 (PST)
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
	ming.lei@redhat.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v3 04/18] bpf: Allow struct_ops prog to return referenced kptr
Date: Fri, 31 Jan 2025 11:28:43 -0800
Message-ID: <20250131192912.133796-5-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250131192912.133796-1-ameryhung@gmail.com>
References: <20250131192912.133796-1-ameryhung@gmail.com>
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


