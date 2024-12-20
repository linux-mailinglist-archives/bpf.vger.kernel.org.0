Return-Path: <bpf+bounces-47471-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CCA4F9F9AC9
	for <lists+bpf@lfdr.de>; Fri, 20 Dec 2024 20:57:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC5CF1898046
	for <lists+bpf@lfdr.de>; Fri, 20 Dec 2024 19:57:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D5C322653D;
	Fri, 20 Dec 2024 19:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J0PR1dKb"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 596CF22578C;
	Fri, 20 Dec 2024 19:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734724593; cv=none; b=eM7AT0Vqv87XuFATvR5LxN9yRL9A0tuMLIVbHAH0G8AT7VYkA0JH7i1S7Rv+bgWKbVtmYCFeAa02ogJJlwE8vjUhvSoCXI1GTySN39sh63ytwkValyXt5UUlMYgIYFDFw9oxxMMnwkaX8RaTzirFJo0kI8ZldBECM8d8gMt1NCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734724593; c=relaxed/simple;
	bh=B+z9xMRiPY9EiUasYh3moVq2Fpc288hu7WmpykEoyC4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fPUGldJWKUS7Gx/OaThE/ifMsg7TmXuBhFPnb9MvCmbhxiuPYiNtL0JwkxgQ2yr34IXYjLREIC7kN0Pk4p2ib0tfRvlN3CaxMc9E+RATlJWRm0qE2BgtTC2UladPj3uUgJ5YYxkLosHyWwH3bdJmh7HcnbP+xx1665q5RIsPICs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J0PR1dKb; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-728eccf836bso2126114b3a.1;
        Fri, 20 Dec 2024 11:56:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734724591; x=1735329391; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GitseSJSjhLenlqje92uM6fqlUgeGQl14yY2w8l3Gtk=;
        b=J0PR1dKb23e6FSheRdK8oc1hw+/JdTYDAtg+ENMJ6+IeBsO87rWmPc0Nxin2Ggkf5/
         oD3jj/c4l7Y3FGjACv5pcbyyZzG0pkkumZfSRVzxiLfgoAvJtDwAcIVtlnjeK3bDSOY3
         ewMriDRFvmkofaed0eEppuQVvBdbcTtCqdhsNcg/v9RUfJXU5m59dweyean52YVinF2e
         jSArKOABZ0aJ3RTLIq8cbonziiKbWEwEKJqCf9urDg6yIgzxw5EXgxm9VQWeGO5jZjmW
         7sUVfZptsZzhD9ccV8Ax0F5/udBevek5q+8bYxfRZidaE92nEetNhfBNey4Ae/US06AH
         XWJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734724591; x=1735329391;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GitseSJSjhLenlqje92uM6fqlUgeGQl14yY2w8l3Gtk=;
        b=V0iMODmMyzA4aH65HK5MqPqC268k9Vn6MAke/PmMNfF/Q+awg+gaD64c3BcoJCQR12
         J1IoIHO+lqRv9RNb0+X8LXwPZvWybsaRR1CL/jXX9QYkBettnqp3iETwoY5X+V1CgR9w
         AVNrnYYc7EXNU025o7rHB008IjiwcNM+EQQDHxedmrtkE/QBdHVAZKFUzWtyyDTI2pfr
         n3eydJK0CfP4hoUXa2IZt0jg7LHXy0UQh6J4dzWFBFbNfXih+Q9F6CGK+iDTVB49RZXh
         bqD0C0apKqeqgyhYw4oo2tp/oqzjkfe+YYTlh7M53BfZih8fnLInWMEtHCYnRAVjELO9
         zSfg==
X-Gm-Message-State: AOJu0YxD2ubu5LtmIUQdLmaP040Qv8JhfmiHXcttM4S5Xl4r6mhARtqs
	aKwEB4i5z6NKtWK+GTxAWmMeH1Tm3fTC8tIZLDQ08c10euxdioK3EYHbEQ==
X-Gm-Gg: ASbGncuoMBBEWL+i/UG9ktOJf26YcRBdp43Bu91AYIFo25i3XxzaFmAjBQplQdDruGj
	Omo1TUGNGJOiCOxT6loyiLXRgzp+hlfpgGuqOCtwTzzFIfkK3ei6OaaOXwkr3umY+yIn33VWlen
	FnCj/+BbYtxDQBowXPsrdCftilGmX6t/xYwYcyQMDnt0bWtFeoB8fPzugW/SEJ1MZDklqJFa26r
	vj50VMYlV91AHMSvCgGqAo365w5+iwVtV4iXrQj4eiorh7jzEocwUsPfxiQRtUTjqL1NstmLga6
	aVi0v1l+lKBp1cKJsdaVgRRhz+Nm9WeF
X-Google-Smtp-Source: AGHT+IE2sAcNr1U4SXIM/YbR3wMtq3g82wHv7+hWZ565zph06itOHS3uOs7e8O7QEGXymIH1UW+yuQ==
X-Received: by 2002:a05:6a20:db0a:b0:1e1:ae4a:1d50 with SMTP id adf61e73a8af0-1e5e049f545mr8192112637.25.1734724591543;
        Fri, 20 Dec 2024 11:56:31 -0800 (PST)
Received: from localhost.localdomain (c-76-146-13-146.hsd1.wa.comcast.net. [76.146.13.146])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-842b17273dasm3240342a12.19.2024.12.20.11.56.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Dec 2024 11:56:31 -0800 (PST)
From: Amery Hung <ameryhung@gmail.com>
X-Google-Original-From: Amery Hung <amery.hung@gmail.com>
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
	ameryhung@gmail.com,
	amery.hung@bytedance.com
Subject: [PATCH bpf-next v2 03/14] bpf: Allow struct_ops prog to return referenced kptr
Date: Fri, 20 Dec 2024 11:55:29 -0800
Message-ID: <20241220195619.2022866-4-amery.hung@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241220195619.2022866-1-amery.hung@gmail.com>
References: <20241220195619.2022866-1-amery.hung@gmail.com>
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
index d9e0af00580b..27d4a170df84 100644
--- a/kernel/bpf/bpf_struct_ops.c
+++ b/kernel/bpf/bpf_struct_ops.c
@@ -386,7 +386,7 @@ int bpf_struct_ops_desc_init(struct bpf_struct_ops_desc *st_ops_desc,
 	st_ops_desc->value_type = btf_type_by_id(btf, value_id);
 
 	for_each_member(i, t, member) {
-		const struct btf_type *func_proto;
+		const struct btf_type *func_proto, *ret_type;
 
 		mname = btf_name_by_offset(btf, member->name_off);
 		if (!*mname) {
@@ -409,6 +409,16 @@ int bpf_struct_ops_desc_init(struct bpf_struct_ops_desc *st_ops_desc,
 		if (!func_proto)
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
index 26305571e377..0e6a3c4daa7d 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -10707,6 +10707,8 @@ record_func_key(struct bpf_verifier_env *env, struct bpf_call_arg_meta *meta,
 static int check_reference_leak(struct bpf_verifier_env *env, bool exception_exit)
 {
 	struct bpf_verifier_state *state = env->cur_state;
+	enum bpf_prog_type type = resolve_prog_type(env->prog);
+	struct bpf_reg_state *reg = reg_state(env, BPF_REG_0);
 	bool refs_lingering = false;
 	int i;
 
@@ -10716,6 +10718,12 @@ static int check_reference_leak(struct bpf_verifier_env *env, bool exception_exi
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
@@ -16320,13 +16328,14 @@ static int check_return_code(struct bpf_verifier_env *env, int regno, const char
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
@@ -16335,10 +16344,26 @@ static int check_return_code(struct bpf_verifier_env *env, int regno, const char
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
@@ -16360,8 +16385,6 @@ static int check_return_code(struct bpf_verifier_env *env, int regno, const char
 		return -EACCES;
 	}
 
-	reg = cur_regs(env) + regno;
-
 	if (frame->in_async_callback_fn) {
 		/* enforce return zero from async callbacks like timer */
 		exit_ctx = "At async callback return";
@@ -16460,6 +16483,11 @@ static int check_return_code(struct bpf_verifier_env *env, int regno, const char
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
2.47.0


