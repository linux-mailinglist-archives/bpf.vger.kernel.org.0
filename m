Return-Path: <bpf+bounces-34781-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 76F63930B12
	for <lists+bpf@lfdr.de>; Sun, 14 Jul 2024 19:52:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C3205B21081
	for <lists+bpf@lfdr.de>; Sun, 14 Jul 2024 17:52:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A32B413D51C;
	Sun, 14 Jul 2024 17:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E1IqyncI"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81A7E61FDA;
	Sun, 14 Jul 2024 17:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720979496; cv=none; b=ssByENXWjwgA0I1K5Qnb9LytQViw8SfSxfJjMbTn0JhMDtiMQs36j+jSwGsmHiJvLE3FAnx3VcEmH0mFXu/f5Zth41QMyTWEbpl7eV8HzfR1JVXNIwyil1v/aCIjHtD4fBaBCSaNlpFWSprdZ2chFdZ0Ee42OHQtwdtKbeAzwyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720979496; c=relaxed/simple;
	bh=4wSMpS650Z0R5dTq+hmz3Lcq6aMZ1mEwjPPMYWEwl+E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XWFyqJfN7EIlDnXXa8JDCa3w4FyCQCj2sd/xzIYDOtHA2M04PUQ04aA2tpX8yrYMtgjndcEBEYgqF1A88wcPpJDAgQY0dT0vquwj75vxdIs+SgEK5dw8ZifDRfe/m52tO3ucG7g8xCfl59xdzKi76HGxfa/u2u7rzmuwi5xxjM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E1IqyncI; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-449f23df593so20850911cf.1;
        Sun, 14 Jul 2024 10:51:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720979493; x=1721584293; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=euRRISVXP1oX1vY6QcOXzEe2K8on6qhG38wctYyGy5g=;
        b=E1IqyncIexJrVhciSXA8gtilvgjTYhVo82rUAIm7Q53eQijUWKGXmaPK/zfyDYKRb2
         Q7Npd5rsVUWxqJWuh6FYS9J59aelLb9RS6rKRKk26ipMe3aGA+FvIeP8cV4v6oK7HELG
         vzDzLySlsNV1dWZrV2RDPf4/5MO2ED7ol0jr2Rtd1NWMu7lm3KLbzpGLlWEHWc2CSjD2
         Im+xW76/zw755Jujvn5NyYY02YhmHobY5Sz6xAaiDhBt4Z0HMUDrGYYKyuVdP2TQZF1r
         29JgqUOyBM+YTMIto55XB7LFyamuwujZfq1jh2iknrv+7RKPanUBdbH//No6WLXbU4jc
         Z/vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720979493; x=1721584293;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=euRRISVXP1oX1vY6QcOXzEe2K8on6qhG38wctYyGy5g=;
        b=nOjvy/yIhkY4N6dXxfQm+WhomfQSt7OfH/Coa78XqeXkx+mEBGLGD0tDYxg2afnHIv
         Ef1DL4VxdcKnuBhOcx+RG16Fzrbgz+BWBu1Zjvw2JUpCvrd8u2BmISS0m5xjI91tqnmo
         ycKzO4EGD703crg9KnwV5QY4NqtTqo41aUdbrz464gKDk5W7VguWwcpEg5X0wn93utPn
         PFMCQr442pun+hKPO2VbG85N90sV3P8mpmypYj+X6ADIkH2f7ShtNzDQOoJlcYbjkarB
         eGjF7kV4i6IPp3aGZNjOD0m8/5rUXDefPerrWTGeTCfr93G5hZktYIlGzYdSJRVyNFSj
         7z3g==
X-Gm-Message-State: AOJu0Yy4btcv3teAFj/X8kwY3Xs8oOtfElNZAIO+nfTJCdhUvB9oaJtp
	G0YdJAAseMfgORuLQO76cKve9Zb3MKMv48p43eyY5+rg1Kaiel0PnU7ixA==
X-Google-Smtp-Source: AGHT+IEaiCb6NljzvFtaq7tAaLkOV0YbEH+9z/wA3TK2956Ttm8m6GZBHhos1mwSSsABfagB9TPb4Q==
X-Received: by 2002:a05:622a:1a17:b0:447:f922:64fd with SMTP id d75a77b69052e-447fa9282edmr204583731cf.35.1720979493208;
        Sun, 14 Jul 2024 10:51:33 -0700 (PDT)
Received: from n36-183-057.byted.org ([147.160.184.91])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-44f5b7e1e38sm17010481cf.25.2024.07.14.10.51.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jul 2024 10:51:32 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
X-Google-Original-From: Amery Hung <amery.hung@bytedance.com>
To: netdev@vger.kernel.org
Cc: bpf@vger.kernel.org,
	yangpeihao@sjtu.edu.cn,
	daniel@iogearbox.net,
	andrii@kernel.org,
	alexei.starovoitov@gmail.com,
	martin.lau@kernel.org,
	sinquersw@gmail.com,
	toke@redhat.com,
	jhs@mojatatu.com,
	jiri@resnulli.us,
	sdf@google.com,
	xiyou.wangcong@gmail.com,
	yepeilin.cs@gmail.com,
	ameryhung@gmail.com
Subject: [RFC PATCH v9 03/11] bpf: Allow struct_ops prog to return referenced kptr
Date: Sun, 14 Jul 2024 17:51:22 +0000
Message-Id: <20240714175130.4051012-4-amery.hung@bytedance.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20240714175130.4051012-1-amery.hung@bytedance.com>
References: <20240714175130.4051012-1-amery.hung@bytedance.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Allow a struct_ops program to return a referenced kptr if the struct_ops
operator has pointer to struct as the return type. To make sure the
returned pointer continues to be valid in the kernel, several
constraints are required:

1) The type of the pointer must matches the return type
2) The pointer originally comes from the kernel (not locally allocated)
3) The pointer is in its unmodified form

In addition, since the first user, Qdisc_ops::dequeue, allows a NULL
pointer to be returned when there is no skb to be dequeued, we will allow
a scalar value with value equals to NULL to be returned.

In the future when there is a struct_ops user that always expects a valid
pointer to be returned from an operator, we may extend tagging to the
return value. We can tell the verifier to only allow NULL pointer return
if the return value is tagged with MAY_BE_NULL.

The check is split into two parts since check_reference_leak() happens
before check_return_code(). We first allow a reference object to leak
through return if it is in the return register and the type matches the
return type. Then, we check whether the pointer to-be-returned is valid in
check_return_code().

Signed-off-by: Amery Hung <amery.hung@bytedance.com>
---
 kernel/bpf/verifier.c | 50 +++++++++++++++++++++++++++++++++++++++----
 1 file changed, 46 insertions(+), 4 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index f614ab283c37..e7f356098902 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -10188,16 +10188,36 @@ record_func_key(struct bpf_verifier_env *env, struct bpf_call_arg_meta *meta,
 
 static int check_reference_leak(struct bpf_verifier_env *env, bool exception_exit)
 {
+	enum bpf_prog_type type = resolve_prog_type(env->prog);
+	u32 regno = exception_exit ? BPF_REG_1 : BPF_REG_0;
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
@@ -15677,12 +15697,15 @@ static int check_return_code(struct bpf_verifier_env *env, int regno, const char
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
@@ -15691,10 +15714,26 @@ static int check_return_code(struct bpf_verifier_env *env, int regno, const char
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
@@ -15716,8 +15755,6 @@ static int check_return_code(struct bpf_verifier_env *env, int regno, const char
 		return -EACCES;
 	}
 
-	reg = cur_regs(env) + regno;
-
 	if (frame->in_async_callback_fn) {
 		/* enforce return zero from async callbacks like timer */
 		exit_ctx = "At async callback return";
@@ -15804,6 +15841,11 @@ static int check_return_code(struct bpf_verifier_env *env, int regno, const char
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


