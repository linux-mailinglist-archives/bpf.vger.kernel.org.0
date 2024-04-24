Return-Path: <bpf+bounces-27634-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF9D88AFF45
	for <lists+bpf@lfdr.de>; Wed, 24 Apr 2024 05:13:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67627281EF5
	for <lists+bpf@lfdr.de>; Wed, 24 Apr 2024 03:13:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5E251339BA;
	Wed, 24 Apr 2024 03:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RUFR1fgX"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-f65.google.com (mail-lf1-f65.google.com [209.85.167.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F29285925
	for <bpf@vger.kernel.org>; Wed, 24 Apr 2024 03:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713928402; cv=none; b=bIMuLC/MK6VDNFuv3NVAv6mrpj9DcH/x+2KyY0CrVpqUkPKoaB3rYOPLMArJFlDiNmIGlUFFqXtyk6Dahj4GMdvO+QH/UIR52IHazQTPGd9i082eV62U53rtSHW2/Dj79SdCl3obhXcITrMNZVDEALdCsPDExpqNDp7iApuj3gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713928402; c=relaxed/simple;
	bh=cW2rcmY3zHXBBcnTB+qAtAmNb+KyORamL1a4bdIw2Ec=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mobBWWpi6KhHIJBHYfMe1xt3wzPCITUD62gP6h0nhRmFuKrLZcHNSNzxHBJ3CdXgkt8EZz98za1n4FyCtJfK6MkQ8W0U3L4dyHLHqcnydCYnvKcBUiUbV2dJ478MlBFOEzkbCf2SbIpH0g2N4OJ8N8PzO/ZEPdQPWFb398KwvVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RUFR1fgX; arc=none smtp.client-ip=209.85.167.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f65.google.com with SMTP id 2adb3069b0e04-51ae315bb20so5148093e87.1
        for <bpf@vger.kernel.org>; Tue, 23 Apr 2024 20:13:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713928398; x=1714533198; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/DEXuC59eHgUCKKT2KZaEK+DHZwoAIjHsQYPAaORDgo=;
        b=RUFR1fgXmL9Lpz1u7y71CBytVvgsRRL1brDFi+8ZnOp4KDj38Ys/n1BuvzcOAexxPZ
         UheoZr2p6JBgQ8EDWQEF4/XH2M1jE4pVzSb7rCqBDVhuQd1PpiWcA9k/KrTP7eSJfKm+
         htAyb9zTbTbnHtwa8FxuBrA6ZI7A61cKkMV6StJi8j4TUu+w+f0DipEt5eyWa+7m6C1M
         Z1UybP2Xg4twfDjJNvvIadK+WTSsYPYLvF/wCuOm1dQsRHXAuClefskdLnliIxlbey2W
         v227HGGwxKucnnFpF6wjxxJjrCzwZxV0ggGs2/qApMzYl29EhJX7r0GzAsAYqUsoKCJD
         1rrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713928398; x=1714533198;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/DEXuC59eHgUCKKT2KZaEK+DHZwoAIjHsQYPAaORDgo=;
        b=bzatdiGsU8W/5nzI1pAfpyGkkAz3Pl1vFTA39gft4Eha9KegmZK24zuRyoqFp8SdBk
         BaC0St2taOIUtAPWYcQ49ZYEmsbhKRPNG7eTEG5p/JQx6khx73k1FH5wVznJDXAltKRO
         Tdgpb9F2yilGttfFt6ffF6W+E6EtyrVJlTywjHNzEVybGOXMy4arTfczK/ZeEJimoqIR
         PHoSq/iHnsi1ApRuNn24RjrQ5rFkDQqX9sddeb3tXRFY4kncBDoipBZmhz1/L5VmpTaA
         UGUi3Rd06Y2Trg5X5jx6PFCs4hl3nerh+Rm9HyKJ6DORsh/ZtCAcuPK4bWJThbAW1TeJ
         Eqvw==
X-Gm-Message-State: AOJu0YzfL+f8eCBHtj9VVg/iUIEiX87fhtEAjiOBDQj6/W/LtF7UEicQ
	vLqPfhPfkfpockt/rWZ33ckwcRdt+mJk9fulMA6pPMDpmtqOuDHJXNnCmcQr
X-Google-Smtp-Source: AGHT+IHYi6nTeo3ZKovFoSq1Jzjed1DQ/OuqzBpJrjWCDyzg3FvdqxRfSq4lf4DQk1kqQ31SjrMiCw==
X-Received: by 2002:a19:ac06:0:b0:51b:180a:7b7c with SMTP id g6-20020a19ac06000000b0051b180a7b7cmr776304lfc.3.1713928397977;
        Tue, 23 Apr 2024 20:13:17 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id g22-20020a056402091600b005721f9fbb60sm1407955edz.63.2024.04.23.20.13.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Apr 2024 20:13:17 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Barret Rhoden <brho@google.com>,
	David Vernet <void@manifault.com>,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH bpf-next v2 1/2] bpf: Introduce bpf_preempt_[disable,enable] kfuncs
Date: Wed, 24 Apr 2024 03:13:14 +0000
Message-ID: <20240424031315.2757363-2-memxor@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240424031315.2757363-1-memxor@gmail.com>
References: <20240424031315.2757363-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=8661; i=memxor@gmail.com; h=from:subject; bh=cW2rcmY3zHXBBcnTB+qAtAmNb+KyORamL1a4bdIw2Ec=; b=owEBbQKS/ZANAwAKAUzgyIZIvxHKAcsmYgBmKHiQuFhDmdLNsXyPACoB8AAWX8Zac3uFO40mw 50nzENIE/qJAjMEAAEKAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZih4kAAKCRBM4MiGSL8R yjS9D/9IAyCPIutgCj/v7oKRDe1n47dpeQIic8jjcGTIo2aMriufBCb+Czf15KpfOO7QJamBFK3 ExBREji9CaIuKToz3P2xi8lSWgLA1R5trKkZ0MoChxzm4GnkxJwQlvUU4crIpDXpJZIVrpbi4zy 1/xhNfktpFlB4GlBWblsvnnRVBKpQrnNoFUmSsBWEga6jrYsAio+JJiEyzBlduzfwYBsTvN8bvj yduSab2iBrLu4dGF3rgA3xksm5pWR044z0Nx5iL2tgcwuAsqWbbo1idBbYgpzbVJdVsnaQJKlo+ 3e+ZVSAviPq5uKCtgO9Cvpxtc90OdiQKqtYlsFW/r96VI8g95yyLruUQYcz+c4Z9FbY3raWHUEc TrnUMRtta4DKayD3G51EbgfFj8CF6rtI4pFjpIX29qaYbomVFHVHCQkXz3GxMdJgAvXlTOH+K2q ed5FEd2B7Npw/mSx451uarP63fmKWLYz+5ukcnXI5u5BF4Y9RpVuSWy9fKnqnm56DgzK5A23Qkm wSOrHJ/OKFu55zY4067YbJNo/R+xEQmhZ7N1Xcq35dNmLYc/Gl6IdMFoLaxJhmFSgewUF0zjXOm 1pxC/JpZOEZ/kIleFPAtVRFR1U9/PKu++BjmDZZXvM9BbK30MQ7I7NSlAoeWyD0MA/vA/XNyPtM NbQA47eGUzR24/g==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

Introduce two new BPF kfuncs, bpf_preempt_disable and
bpf_preempt_enable. These kfuncs allow disabling preemption in BPF
programs. Nesting is allowed, since the intended use cases includes
building native BPF spin locks without kernel helper involvement. Apart
from that, this can be used to per-CPU data structures for cases where
programs (or userspace) may preempt one or the other. Currently, while
per-CPU access is stable, whether it will be consistent is not
guaranteed, as only migration is disabled for BPF programs.

Global functions are disallowed from being called, but support for them
will be added as a follow up not just preempt kfuncs, but rcu_read_lock
kfuncs as well. Static subprog calls are permitted. Sleepable helpers
and kfuncs are disallowed in non-preemptible regions.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 include/linux/bpf_verifier.h |  1 +
 kernel/bpf/helpers.c         | 12 ++++++
 kernel/bpf/verifier.c        | 71 +++++++++++++++++++++++++++++++++++-
 3 files changed, 82 insertions(+), 2 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 9db35530c878..50aa87f8d77f 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -421,6 +421,7 @@ struct bpf_verifier_state {
 	struct bpf_active_lock active_lock;
 	bool speculative;
 	bool active_rcu_lock;
+	u32 active_preempt_lock;
 	/* If this state was ever pointed-to by other state's loop_entry field
 	 * this flag would be set to true. Used to avoid freeing such states
 	 * while they are still in use.
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 047a21b7e4ba..84997e95ab78 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -2742,6 +2742,16 @@ __bpf_kfunc int bpf_wq_set_callback_impl(struct bpf_wq *wq,
 	return __bpf_async_set_callback(async, callback_fn, aux, flags, BPF_ASYNC_TYPE_WQ);
 }
 
+__bpf_kfunc void bpf_preempt_disable(void)
+{
+	preempt_disable();
+}
+
+__bpf_kfunc void bpf_preempt_enable(void)
+{
+	preempt_enable();
+}
+
 __bpf_kfunc_end_defs();
 
 BTF_KFUNCS_START(generic_btf_ids)
@@ -2822,6 +2832,8 @@ BTF_ID_FLAGS(func, bpf_modify_return_test_tp)
 BTF_ID_FLAGS(func, bpf_wq_init)
 BTF_ID_FLAGS(func, bpf_wq_set_callback_impl)
 BTF_ID_FLAGS(func, bpf_wq_start)
+BTF_ID_FLAGS(func, bpf_preempt_disable)
+BTF_ID_FLAGS(func, bpf_preempt_enable)
 BTF_KFUNCS_END(common_btf_ids)
 
 static const struct btf_kfunc_id_set common_kfunc_set = {
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 9715c88cc025..8312c7a0ee19 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -1434,6 +1434,7 @@ static int copy_verifier_state(struct bpf_verifier_state *dst_state,
 	}
 	dst_state->speculative = src->speculative;
 	dst_state->active_rcu_lock = src->active_rcu_lock;
+	dst_state->active_preempt_lock = src->active_preempt_lock;
 	dst_state->in_sleepable = src->in_sleepable;
 	dst_state->curframe = src->curframe;
 	dst_state->active_lock.ptr = src->active_lock.ptr;
@@ -9599,6 +9600,13 @@ static int check_func_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 			return -EINVAL;
 		}
 
+		/* Only global subprogs cannot be called with preemption disabled. */
+		if (env->cur_state->active_preempt_lock) {
+			verbose(env, "global function calls are not allowed with preemption disabled,\n"
+				     "use static function instead\n");
+			return -EINVAL;
+		}
+
 		if (err) {
 			verbose(env, "Caller passes invalid args into func#%d ('%s')\n",
 				subprog, sub_name);
@@ -10285,6 +10293,17 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
 			env->insn_aux_data[insn_idx].storage_get_func_atomic = true;
 	}
 
+	if (env->cur_state->active_preempt_lock) {
+		if (fn->might_sleep) {
+			verbose(env, "sleepable helper %s#%d in non-preemptible region\n",
+				func_id_name(func_id), func_id);
+			return -EINVAL;
+		}
+
+		if (in_sleepable(env) && is_storage_get_function(func_id))
+			env->insn_aux_data[insn_idx].storage_get_func_atomic = true;
+	}
+
 	meta.func_id = func_id;
 	/* check args */
 	for (i = 0; i < MAX_BPF_FUNC_REG_ARGS; i++) {
@@ -11027,6 +11046,8 @@ enum special_kfunc_type {
 	KF_bpf_percpu_obj_drop_impl,
 	KF_bpf_throw,
 	KF_bpf_wq_set_callback_impl,
+	KF_bpf_preempt_disable,
+	KF_bpf_preempt_enable,
 	KF_bpf_iter_css_task_new,
 };
 
@@ -11081,6 +11102,8 @@ BTF_ID(func, bpf_percpu_obj_new_impl)
 BTF_ID(func, bpf_percpu_obj_drop_impl)
 BTF_ID(func, bpf_throw)
 BTF_ID(func, bpf_wq_set_callback_impl)
+BTF_ID(func, bpf_preempt_disable)
+BTF_ID(func, bpf_preempt_enable)
 #ifdef CONFIG_CGROUPS
 BTF_ID(func, bpf_iter_css_task_new)
 #else
@@ -11107,6 +11130,16 @@ static bool is_kfunc_bpf_rcu_read_unlock(struct bpf_kfunc_call_arg_meta *meta)
 	return meta->func_id == special_kfunc_list[KF_bpf_rcu_read_unlock];
 }
 
+static bool is_kfunc_bpf_preempt_disable(struct bpf_kfunc_call_arg_meta *meta)
+{
+	return meta->func_id == special_kfunc_list[KF_bpf_preempt_disable];
+}
+
+static bool is_kfunc_bpf_preempt_enable(struct bpf_kfunc_call_arg_meta *meta)
+{
+	return meta->func_id == special_kfunc_list[KF_bpf_preempt_enable];
+}
+
 static enum kfunc_ptr_arg_type
 get_kfunc_ptr_arg_type(struct bpf_verifier_env *env,
 		       struct bpf_kfunc_call_arg_meta *meta,
@@ -12195,11 +12228,11 @@ static int check_return_code(struct bpf_verifier_env *env, int regno, const char
 static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 			    int *insn_idx_p)
 {
-	const struct btf_type *t, *ptr_type;
+	bool sleepable, rcu_lock, rcu_unlock, preempt_disable, preempt_enable;
 	u32 i, nargs, ptr_type_id, release_ref_obj_id;
 	struct bpf_reg_state *regs = cur_regs(env);
 	const char *func_name, *ptr_type_name;
-	bool sleepable, rcu_lock, rcu_unlock;
+	const struct btf_type *t, *ptr_type;
 	struct bpf_kfunc_call_arg_meta meta;
 	struct bpf_insn_aux_data *insn_aux;
 	int err, insn_idx = *insn_idx_p;
@@ -12260,6 +12293,9 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 	rcu_lock = is_kfunc_bpf_rcu_read_lock(&meta);
 	rcu_unlock = is_kfunc_bpf_rcu_read_unlock(&meta);
 
+	preempt_disable = is_kfunc_bpf_preempt_disable(&meta);
+	preempt_enable = is_kfunc_bpf_preempt_enable(&meta);
+
 	if (env->cur_state->active_rcu_lock) {
 		struct bpf_func_state *state;
 		struct bpf_reg_state *reg;
@@ -12292,6 +12328,22 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 		return -EINVAL;
 	}
 
+	if (env->cur_state->active_preempt_lock) {
+		if (preempt_disable) {
+			env->cur_state->active_preempt_lock++;
+		} else if (preempt_enable) {
+			env->cur_state->active_preempt_lock--;
+		} else if (sleepable) {
+			verbose(env, "kernel func %s is sleepable within non-preemptible region\n", func_name);
+			return -EACCES;
+		}
+	} else if (preempt_disable) {
+		env->cur_state->active_preempt_lock++;
+	} else if (preempt_enable) {
+		verbose(env, "unmatched attempt to enable preemption (kernel function %s)\n", func_name);
+		return -EINVAL;
+	}
+
 	/* In case of release function, we get register number of refcounted
 	 * PTR_TO_BTF_ID in bpf_kfunc_arg_meta, do the release now.
 	 */
@@ -15439,6 +15491,11 @@ static int check_ld_abs(struct bpf_verifier_env *env, struct bpf_insn *insn)
 		return -EINVAL;
 	}
 
+	if (env->cur_state->active_preempt_lock) {
+		verbose(env, "BPF_LD_[ABS|IND] cannot be used inside bpf_preempt_disable-ed region\n");
+		return -EINVAL;
+	}
+
 	if (regs[ctx_reg].type != PTR_TO_CTX) {
 		verbose(env,
 			"at the time of BPF_LD_ABS|IND R6 != pointer to skb\n");
@@ -17006,6 +17063,9 @@ static bool states_equal(struct bpf_verifier_env *env,
 	if (old->active_rcu_lock != cur->active_rcu_lock)
 		return false;
 
+	if (old->active_preempt_lock != cur->active_preempt_lock)
+		return false;
+
 	if (old->in_sleepable != cur->in_sleepable)
 		return false;
 
@@ -17957,6 +18017,13 @@ static int do_check(struct bpf_verifier_env *env)
 					return -EINVAL;
 				}
 
+				if (env->cur_state->active_preempt_lock && !env->cur_state->curframe) {
+					verbose(env, "%d bpf_preempt_enable%s missing\n",
+						env->cur_state->active_preempt_lock,
+						env->cur_state->active_preempt_lock == 1 ? " is" : "(s) are");
+					return -EINVAL;
+				}
+
 				/* We must do check_reference_leak here before
 				 * prepare_func_exit to handle the case when
 				 * state->curframe > 0, it may be a callback
-- 
2.43.0


