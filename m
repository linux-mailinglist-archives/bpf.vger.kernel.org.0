Return-Path: <bpf+bounces-44282-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A1B869C0D4B
	for <lists+bpf@lfdr.de>; Thu,  7 Nov 2024 18:51:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31F6A1F233BB
	for <lists+bpf@lfdr.de>; Thu,  7 Nov 2024 17:51:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13A0521747B;
	Thu,  7 Nov 2024 17:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S7BO/Zl+"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25443217454
	for <bpf@vger.kernel.org>; Thu,  7 Nov 2024 17:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731001883; cv=none; b=Fq2nJZeKKGG+AbBvvPinbsmXZyB96vOtIsRy/xPwecepfqI7ZznP2bwvor/b3oxlXxvwN4PdhhsOuCvbRIZxods6qjT/gT/aDz1k4wHHNCxbiyvFykNimAOy3bC2KsjtnmPF3DGxGwoTHlZ/Q19b0aWRSehIZLV7xnK6S72KLoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731001883; c=relaxed/simple;
	bh=LRqw+NQ66QIIt1voN593Ik8O7jV5Hw02rTjE0CkjXOI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PzcpTm8KrP1x5gIPTC96GnHsXbXxF/wzWDSm+tDFf6VueZsmYZBJWJ+khGjICiP5Q5Sszc7C/AmrRDflSApVGLu5F0DIpgg6be1b2zVIgFHq+KvTYc9dA/tAXX/vxWiiWMqQEqj7+BxqsJll5vrPzXcsMulxXU4gGgGrYZZzI4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S7BO/Zl+; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2e2fb304e7dso1019830a91.1
        for <bpf@vger.kernel.org>; Thu, 07 Nov 2024 09:51:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731001881; x=1731606681; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L7f9kDUL1x4G1ehfj2VhBkZhEUWQN5zhRe5AFNh2N2o=;
        b=S7BO/Zl+/njKRreXm7iCySA48tu4mK2wyD+oFDImVXtl/Uw7j4jrlXZXGZgwBOZM/8
         VdQ4Pg59x8oJhwA+gHb7tLe3bmY9Tcjsn2Jw0UjkaLwsZ4TFcx8n3ORBCCg19m9IADnr
         AQ6KoWg5ybwxoeW+tM5dkwuvBNEK0EJZjsXRbFKekKc90O0OJzaPosyBGuywLMdGm7lz
         0ynIf16xDX5fnMkjo+G+qOXgOMV9Tr2F2KFz6bqzlCCQuqLdZJWEF/o6SCg9IJKsJjqp
         gNt/x3FqHCjztjyIE4S7/e+VwO//Ydf+KySbBQcMZFmvjkUBxwxuuc47pbakdEIngptC
         gy5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731001881; x=1731606681;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L7f9kDUL1x4G1ehfj2VhBkZhEUWQN5zhRe5AFNh2N2o=;
        b=sqZEmWi8+jQ/87DrAEFx9114cUEFGdxD0KPupzcA0vIHw0jO1/Y6ZaV5QZZSFATejN
         rQeDdD95kto8jyqfZhsuNFy6GP4WD8gsIghZ+Ou9jc1ICbryTa++29tXED69dHVHvV3F
         8PVrB8ir6rL9rK6Cv7KhXNbgF7/h1yjRErsAFQQs2T0+UVPe3pbMHa+jX3YVTQ/kQi3n
         4NVVMfL3u5LwcKb2+ba9/7G6fUypob+ZL1HUsK20cbaK/fAgU+ke1IQ/r6fFx/5jlNVU
         N+/bO3vwYcRZixme9dPkcbvl/8DnfJBygFKNoSTtNMwf68v9sQ3ixv/OXubmm4t1fI1k
         qzWQ==
X-Gm-Message-State: AOJu0Yz9Vi4IiX/CuYcqvqBWvI8K237yWZMBbZVlZfRpqvPP6qAn9Z8X
	FSqV9SlsXNGzX5IYXdBqkdza7KCHVnzfMGoG0rq0PkLIW/SGP+/PycoZ2Atd
X-Google-Smtp-Source: AGHT+IHXvnHwENioA1PEqyanU2Yh/qvrC9+s7T5NBFza2UoOXRtshcQWVALBeEfUw8HrYCmbC9Zlvg==
X-Received: by 2002:a17:90b:3c84:b0:2e2:c69b:669 with SMTP id 98e67ed59e1d1-2e9b177d6cbmr24701a91.27.1731001881232;
        Thu, 07 Nov 2024 09:51:21 -0800 (PST)
Received: from honey-badger.. ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e9a5f52b32sm1730686a91.5.2024.11.07.09.51.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2024 09:51:20 -0800 (PST)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	memxor@gmail.com,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [RFC bpf-next 08/11] bpf: special rules for kernel function calls inside inlinable kfuncs
Date: Thu,  7 Nov 2024 09:50:37 -0800
Message-ID: <20241107175040.1659341-9-eddyz87@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241107175040.1659341-1-eddyz87@gmail.com>
References: <20241107175040.1659341-1-eddyz87@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Inlinable kfuncs can call arbitrary kernel functions,
there is no need to check if these functions conform to kfunc or
helper usage rules. Upon seeing such calls:
- mark registers R0-R5 as KERNEL_VALUEs after the call;
- if there are any PTR_TO_STACK parameters, mark all
  allocated stack slots as KERNEL_VALUEs.

The assumption is that KERNEL_VALUE marks should never escape form
kfunc instance body: at the call site R0 is set in accordance to kfunc
processing rules, PTR_TO_STACK parameters are never passed from bpf
program to inlinable kfunc.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 kernel/bpf/verifier.c | 67 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 66 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 87b6cc8c94f8..5b109139f356 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -13209,6 +13209,67 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 	return 0;
 }
 
+static int mark_stack_as_kernel_values(struct bpf_verifier_env *env, struct bpf_func_state *func)
+{
+	struct bpf_stack_state *slot;
+	struct bpf_reg_state *spill;
+	int spi, i;
+
+	if (!inside_inlinable_kfunc(env, func->callsite)) {
+		verbose(env, "verifier bug: shouldn't mark frame#%d as kernel values\n",
+			func->frameno);
+		return -EFAULT;
+	}
+
+	for (spi = 0; spi < func->allocated_stack / BPF_REG_SIZE; spi++) {
+		slot = &func->stack[spi];
+		spill = &slot->spilled_ptr;
+		mark_reg_kernel_value(spill);
+		spill->live |= REG_LIVE_WRITTEN;
+		for (i = 0; i < BPF_REG_SIZE; i++)
+			slot->slot_type[i] = STACK_SPILL;
+		mark_stack_slot_scratched(env, spi);
+	}
+
+	return 0;
+}
+
+static int check_internal_call(struct bpf_verifier_env *env, struct bpf_insn *insn)
+{
+	struct bpf_reg_state *reg, *regs = cur_regs(env);
+	struct bpf_kfunc_call_arg_meta meta;
+	int err, i, nargs;
+
+	err = fetch_kfunc_meta(env, insn, &meta, NULL);
+	if (err < 0)
+		return -EFAULT;
+
+	nargs = btf_type_vlen(meta.func_proto);
+	for (i = 0; i < nargs; i++) {
+		reg = &regs[BPF_REG_1 + i];
+		switch (reg->type) {
+		case SCALAR_VALUE:
+		case KERNEL_VALUE:
+			break;
+		case PTR_TO_STACK:
+			err = mark_stack_as_kernel_values(env, func(env, reg));
+			if (err)
+				return err;
+			break;
+		default:
+			verbose(env, "verifier bug: arg#%i unexpected register type %s\n",
+				i, reg_type_str(env, reg->type));
+			return -EFAULT;
+		}
+	}
+	for (i = 0; i < CALLER_SAVED_REGS; i++) {
+		mark_reg_not_init(env, regs, caller_saved[i]);
+		check_reg_arg(env, caller_saved[i], DST_OP_NO_MARK);
+	}
+	mark_reg_kernel_value(&regs[BPF_REG_0]);
+	return 0;
+}
+
 static bool check_reg_sane_offset(struct bpf_verifier_env *env,
 				  const struct bpf_reg_state *reg,
 				  enum bpf_reg_type type)
@@ -18828,7 +18889,8 @@ static int do_check(struct bpf_verifier_env *env)
 					return -EINVAL;
 				}
 
-				if (env->cur_state->active_lock.ptr) {
+				if (env->cur_state->active_lock.ptr &&
+				    !inside_inlinable_kfunc(env, env->insn_idx)) {
 					if ((insn->src_reg == BPF_REG_0 && insn->imm != BPF_FUNC_spin_unlock) ||
 					    (insn->src_reg == BPF_PSEUDO_KFUNC_CALL &&
 					     (insn->off != 0 || !is_bpf_graph_api_kfunc(insn->imm)))) {
@@ -18838,6 +18900,9 @@ static int do_check(struct bpf_verifier_env *env)
 				}
 				if (insn->src_reg == BPF_PSEUDO_CALL) {
 					err = check_func_call(env, insn, &env->insn_idx);
+				} else if (insn->src_reg == BPF_PSEUDO_KFUNC_CALL &&
+					   inside_inlinable_kfunc(env, env->insn_idx)) {
+					err = check_internal_call(env, insn);
 				} else if (insn->src_reg == BPF_PSEUDO_KFUNC_CALL) {
 					err = check_kfunc_call(env, insn, &env->insn_idx);
 					if (!err && is_bpf_throw_kfunc(insn)) {
-- 
2.47.0


