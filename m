Return-Path: <bpf+bounces-27503-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BDA68ADD6D
	for <lists+bpf@lfdr.de>; Tue, 23 Apr 2024 08:19:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F2ED1C217C8
	for <lists+bpf@lfdr.de>; Tue, 23 Apr 2024 06:19:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2FF025634;
	Tue, 23 Apr 2024 06:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FCCg+Pqb"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lj1-f194.google.com (mail-lj1-f194.google.com [209.85.208.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DF2F23769
	for <bpf@vger.kernel.org>; Tue, 23 Apr 2024 06:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713853169; cv=none; b=fQTMq9nBfsRqdsI06cycoWyAl/qTRmmjQ58H9VB7FNjpEbNswJr5v29j/dYNPE/7bfgHrDjmCbi46pvHuxVR6yCMHv0aNRxOltmGBLwdV69F2XE3LXUBpLF8lUe01si/22InIPQxIluUnBdWbkIclQqwBZpCvbL5J352VQQbk8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713853169; c=relaxed/simple;
	bh=3LIB9WOE5L0VMZW2dHUZUd7tUlishbXwZw12MNH3lMg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=laskpOTSScSJW4uZ3BqHSlc2iMAPOHLWskFAEYND14CVyWUFi2gEp7sZg3Vs5jghvLJG7UqUQN3Db1Np1HosfxGXq0LP0OLzDAgzgXlauaiKda9UMXr3LunrhiA33ki1Qr5X02U3LZ18zTmI2U4g2XoyayIvtCAcjlmENRG/LFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FCCg+Pqb; arc=none smtp.client-ip=209.85.208.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f194.google.com with SMTP id 38308e7fff4ca-2db101c11beso60986801fa.0
        for <bpf@vger.kernel.org>; Mon, 22 Apr 2024 23:19:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713853165; x=1714457965; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PDn9KBB+qG/RKC/DeeM7PgJFU648PGUeqsn6sUHmEXE=;
        b=FCCg+PqbaielfaMqxDns3pBqNcUwpl59KAUO/bXaDwwC6rSz4TH5y5yyvSfsLYi0LR
         mAxcpJPYvhMXx2J1PMd5rpdFO//ORI2XxPqqjIXNaqhubDchaFzomN4h2FhmQ9mv2nFI
         Hwvdf9lv2hW+CQrhXod/gV/kyIxh3LkW4jNVr3OijXhsG8HgH00ZgHlPDS5dwsfd4epX
         RTPhX9OoK27MZkbhBQ4mp0XJFpdZiNzMkCp5yFT75L9JveCybaYkwdSGxfBneuCw2toM
         jbfaRGJRlMkgTbVn4TIAM/LmgLbriQ3lWznmYfkuqxEdjNqOBVZg24NtGetlgDtZ1V05
         ujCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713853165; x=1714457965;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PDn9KBB+qG/RKC/DeeM7PgJFU648PGUeqsn6sUHmEXE=;
        b=gBmr6pmEdAf7/mEiYtad0Sg7wxHXYr0GdRsMqI7JCXkWjkdPeky8sPfbOpUXT8C4H8
         Ev9gbm4YX4RL3Tw17evhYAc9uzJmJU0khTjm/ZQV+rUKxXnvar1bL1pESfuE3YVtmb8A
         iOZDWZECNTtqJWAvgNnE65gZFhB16JcQeYQt2SQGz3nniOjm7teg2QfZoi9XmCjpCn81
         J0ZgXSbp1NfWESumzTzVCNUMedXk3R+oaqZUP2sP2p6yVhXolmkaoOFAij20vTNAtXLo
         ZOoRFfeEsN5BmmMtg64BRDnYuQDMz21A7HbIoJNd73+z3siB+eGyhps8/NboX5H2ojo3
         ltjA==
X-Gm-Message-State: AOJu0Yw+jtbOJ/PDFvM8E09nzue2vqg53pmuDd+19GaYlUzXK6u+KrMK
	QEFknrVCB+94RZIauOyMMwuv5DkXmc7XSJjvsGiKoLnVJUnapDFNQPft1K4W
X-Google-Smtp-Source: AGHT+IEjhTGVJgV7AV1GJ+1jim16FmiN5kKGo0S96gzfBgWXe8UDwXX/RJk3HClHltrmgNqonxc4RQ==
X-Received: by 2002:a2e:9ac4:0:b0:2dd:aa55:bc1c with SMTP id p4-20020a2e9ac4000000b002ddaa55bc1cmr2829363ljj.28.1713853165167;
        Mon, 22 Apr 2024 23:19:25 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id b18-20020a0564021f1200b00572066c5d66sm2153580edb.81.2024.04.22.23.19.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Apr 2024 23:19:24 -0700 (PDT)
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
Subject: [PATCH bpf-next v1 1/2] bpf: Introduce bpf_preempt_[disable,enable] kfuncs
Date: Tue, 23 Apr 2024 06:19:21 +0000
Message-ID: <20240423061922.2295517-2-memxor@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240423061922.2295517-1-memxor@gmail.com>
References: <20240423061922.2295517-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=8892; i=memxor@gmail.com; h=from:subject; bh=3LIB9WOE5L0VMZW2dHUZUd7tUlishbXwZw12MNH3lMg=; b=owEBbQKS/ZANAwAKAUzgyIZIvxHKAcsmYgBmJ1KgU5AmDxuUjKzdptcPRNA9VXhuVmIMeqwpG Zts7A55ZpqJAjMEAAEKAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZidSoAAKCRBM4MiGSL8R yinsD/95FlXA8VxyEf4a19OQHoBpwjMHy6kHt/dvW94YVa3h7dOcDsL75kC0wNCuTVel7wbyyaP Su05MdWAZrkayi22nMGQ2SCHRVAaKb/6RNA1Vw7okj/RDJKLVW0Hdi1DLGj2uuo5ExrL1aEv7Ty pZl1VivsjZYVPlIhnjxrxUmiZYbA4cN2vz0DZqNDfAE/cpnaCv2h/d5hOc8M8JSrlBLDAy3Eihc bQweHygtJLtajjuVkGQN+tYmYE3ThPSLCUkfaS/WLC117c2yzt6+mDDz45Jd1v3GfFsnYpZif6v /+8W37Sz4+/Q5VSbX9Mkn3YApTTp6MOZc+H9JP+qfGWt3AcvHpTNCtoFCT4cVW+EtBiSfDyu+n3 ESP2U4VDC5T+tmsVee9fcrohABp+8lvnDG8nRybx1NlCEIEr7cZq9ayrocO3pQHeJ7oF+AxTEXT nFB/gEmjelTNUonbUMAKZrsx9lrAVoLjh7QWkXo6oqNzakJG+bevw4FxYn7oeBcyE9vQ/fba8ze kDvm0KJBQWmASbQnPca+Es9XGqZMnMxpXazapo3p9KIC8VxAGdUV3xG9hZjM77nh7xUBakUkEyX ihpsq7K02TNHEP5S5mRFGNk9Np50h8rODkEZHFN7ZX84/1x5q1Aw/e6JIposx2KaJqmBbVeLdDQ oi69nJEJTQwYKRg==
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
 kernel/bpf/verifier.c        | 72 +++++++++++++++++++++++++++++++++++-
 3 files changed, 83 insertions(+), 2 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 36d19cd32eb5..25451d8a0063 100644
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
index 61126180d398..c8e4be4c0d88 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -2549,6 +2549,16 @@ __bpf_kfunc void bpf_throw(u64 cookie)
 	WARN(1, "A call to BPF exception callback should never return\n");
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
@@ -2626,6 +2636,8 @@ BTF_ID_FLAGS(func, bpf_dynptr_is_rdonly)
 BTF_ID_FLAGS(func, bpf_dynptr_size)
 BTF_ID_FLAGS(func, bpf_dynptr_clone)
 BTF_ID_FLAGS(func, bpf_modify_return_test_tp)
+BTF_ID_FLAGS(func, bpf_preempt_disable)
+BTF_ID_FLAGS(func, bpf_preempt_enable)
 BTF_KFUNCS_END(common_btf_ids)
 
 static const struct btf_kfunc_id_set common_kfunc_set = {
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 5a7e34e83a5b..961f8c007cbc 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -1425,6 +1425,7 @@ static int copy_verifier_state(struct bpf_verifier_state *dst_state,
 	}
 	dst_state->speculative = src->speculative;
 	dst_state->active_rcu_lock = src->active_rcu_lock;
+	dst_state->active_preempt_lock = src->active_preempt_lock;
 	dst_state->curframe = src->curframe;
 	dst_state->active_lock.ptr = src->active_lock.ptr;
 	dst_state->active_lock.id = src->active_lock.id;
@@ -9567,6 +9568,13 @@ static int check_func_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
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
@@ -10253,6 +10261,17 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
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
@@ -10987,6 +11006,8 @@ enum special_kfunc_type {
 	KF_bpf_percpu_obj_drop_impl,
 	KF_bpf_throw,
 	KF_bpf_iter_css_task_new,
+	KF_bpf_preempt_disable,
+	KF_bpf_preempt_enable,
 };
 
 BTF_SET_START(special_kfunc_set)
@@ -11043,6 +11064,8 @@ BTF_ID(func, bpf_iter_css_task_new)
 #else
 BTF_ID_UNUSED
 #endif
+BTF_ID(func, bpf_preempt_disable)
+BTF_ID(func, bpf_preempt_enable)
 
 static bool is_kfunc_ret_null(struct bpf_kfunc_call_arg_meta *meta)
 {
@@ -11064,6 +11087,16 @@ static bool is_kfunc_bpf_rcu_read_unlock(struct bpf_kfunc_call_arg_meta *meta)
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
@@ -12095,11 +12128,11 @@ static int check_return_code(struct bpf_verifier_env *env, int regno, const char
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
@@ -12150,6 +12183,9 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 	rcu_lock = is_kfunc_bpf_rcu_read_lock(&meta);
 	rcu_unlock = is_kfunc_bpf_rcu_read_unlock(&meta);
 
+	preempt_disable = is_kfunc_bpf_preempt_disable(&meta);
+	preempt_enable = is_kfunc_bpf_preempt_enable(&meta);
+
 	if (env->cur_state->active_rcu_lock) {
 		struct bpf_func_state *state;
 		struct bpf_reg_state *reg;
@@ -12182,6 +12218,22 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
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
@@ -15329,6 +15381,11 @@ static int check_ld_abs(struct bpf_verifier_env *env, struct bpf_insn *insn)
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
@@ -16896,6 +16953,9 @@ static bool states_equal(struct bpf_verifier_env *env,
 	if (old->active_rcu_lock != cur->active_rcu_lock)
 		return false;
 
+	if (old->active_preempt_lock != cur->active_preempt_lock)
+		return false;
+
 	/* for states to be equal callsites have to be the same
 	 * and all frame states need to be equivalent
 	 */
@@ -17793,6 +17853,7 @@ static int do_check(struct bpf_verifier_env *env)
 						return -EINVAL;
 					}
 				}
+
 				if (insn->src_reg == BPF_PSEUDO_CALL) {
 					err = check_func_call(env, insn, &env->insn_idx);
 				} else if (insn->src_reg == BPF_PSEUDO_KFUNC_CALL) {
@@ -17844,6 +17905,13 @@ static int do_check(struct bpf_verifier_env *env)
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


