Return-Path: <bpf+bounces-70546-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2988FBC2D04
	for <lists+bpf@lfdr.de>; Wed, 08 Oct 2025 00:04:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C3063C6118
	for <lists+bpf@lfdr.de>; Tue,  7 Oct 2025 22:04:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9152258CE1;
	Tue,  7 Oct 2025 22:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d72t7Jho"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com [209.85.221.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A06CA257843
	for <bpf@vger.kernel.org>; Tue,  7 Oct 2025 22:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759874637; cv=none; b=r++1X2gUU33MLOb1hWpoYy7ym+RIhhI3HTB93N+qZ2Pady2MQRthbQFblSKFPNpmgtRyOLpIF2vh7wmuk+6zRwCCA/ZcH7MBv1HhxXxIyg/hAsq9K47rJBjLzMrBC8J6HX1z0oGnyVjG5jR3MeKC37hDBTW4ngkXZQlaJ1mv23Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759874637; c=relaxed/simple;
	bh=iPp0WPtTw7DLD5DcqnADcmc/bVYmHRcHB/HOwWOURxk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KtTalIIMj5AshmKqBFEouj1OFoafJr7X3/GBev3cYWBAw5Fl11QB3Pqra/bPTjrp022ZKkp0m5zJ9Mk+zb0G8s09mK/Ztt6kXwWv4Lml5LvuwCg96yX/gtwW3H6L+MgGbxy9yu/2PCi9U+7FOGFzS5HoM8aLP3xKBHYQPH8Cric=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d72t7Jho; arc=none smtp.client-ip=209.85.221.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f66.google.com with SMTP id ffacd0b85a97d-42568669606so3681106f8f.2
        for <bpf@vger.kernel.org>; Tue, 07 Oct 2025 15:03:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759874634; x=1760479434; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3jf0JnG4FE7vMhe7Q9Ne/9SmwsaSYNItyPVWHMF78aI=;
        b=d72t7JhoBP8VSynqsMeLb4BYsQ3ypoDG8TiL24bzOx/mw1x8PUnLn429CrpZa/jF76
         1Z8j/UbM4xz2eIageRw8qs5vQNuLcLTkxhIW59AoiwndLB+OXCPaqjswHOnb+aYqbQ04
         NRakcUpJs69TXZUznZ9zxHhzH7qA0KTFg96x+Z2rH/RlerMfcODI+U4dQ8U35S+AiD9q
         KD+dbtzU001J5KUPMuLYEhkeQyOI4/OW8CYWjvrMyg/M5+/s3RsJ3ircdJJFErDcZqKI
         b+bGvL1DNB3mA8uVIrMOQpUGuZJ7XJoWmKYOpBaDFGRPT0Sze1d+ccNNcX9EgfGCbIfQ
         kg6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759874634; x=1760479434;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3jf0JnG4FE7vMhe7Q9Ne/9SmwsaSYNItyPVWHMF78aI=;
        b=vnkjLn/JjWc/IshTxxfq8BoA9RsY1wOsM0ijqttTVThUhjXaiUN4By2FJqFpQ/G7rd
         Deoe5r5d9ySj9WipzbqoxtEl8Mj6SKA4IsWquNs1UBZPD7ssXnXYedrHu4rT4OAmqgYw
         bFdxBCf5QC60ofeTQHKemAr8Hw8IbqbqOvPu1M0v0loHH3VLsIHMFb+A7qyRHfEtW1oe
         wOuxfOJLAGye9iBbp0h0KMvTEwx5nIdpzK6jjWkDQJfdDLeNz1xLzI3EwcisMOXLBLmj
         WByCpjysQQT7V/jpd514cAbm0b9fV/9kvqmdyyMwcXcR59tL+E+QB4r9kZoOt5k2OgVr
         ZNLA==
X-Gm-Message-State: AOJu0YyaGowveIr4ugmL1i1RxzjC6ux8yttGEkbh5Riz7U0HWN8PJNLL
	0Qn/BwwFfIb6mWWCNseUaw+PZy1e/B34VXZ0RNkIbC1uhAUcNUoUgEEQFl3azS1z
X-Gm-Gg: ASbGncszRu6/cVka4AIiIaCnBcL54GmiRWo3CwXgq278EgL4mZEaMcRcQlQgULx2D8P
	zZxyyu0Ug3ex2NerxiBhobXEDwre9zwqTIE5hCHxHrfrqerW6hewyH8QZMoYaXtM3WY9oO+nd+g
	iJD802ABRTG2Cj2HKU5E7NS6ZAjGnhoe2O5kVsxSl2GRkg5WLlAVwhYKiQ4ncLtkOL/+JBNNi7B
	PSNhbJgsNBaeycJYhY15rxqMjDXpTw+bJ2qtQdOfV4hBxgvEtIfvgjMBxT+iIiSuXEkF6xDvi/Q
	kmUUWEU+CUhc6IEYTE6Za3kNH0F6FAOEsXPASEE82F3+/fl+ZHgUpOhpY0DOlAlHD6eBjUwVlEP
	SLJMW7e+vVhB6UHrwkk4itIhL5vaUpoVdNb3aZxDrxiGPlvgpEWPbcgXUG9uMHaUjCYVamlJP5M
	jhbY7oi0RTjXCFj+CmRS1NmE0G
X-Google-Smtp-Source: AGHT+IHWqgDkQR0rhuckyO83LRh68iaQmjqbVmItKMjxN/ZRs8nwD8Jx+GragfNRJ3Jg/8xa7F524A==
X-Received: by 2002:a05:6000:2586:b0:425:86ca:98c with SMTP id ffacd0b85a97d-4266e7c4adamr471142f8f.28.1759874633286;
        Tue, 07 Oct 2025 15:03:53 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-46fa9c07992sm11631275e9.5.2025.10.07.15.03.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Oct 2025 15:03:52 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Mykyta Yatsenko <yatsenko@meta.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v2 2/3] bpf: Refactor storage_get_func_atomic to generic non_sleepable flag
Date: Tue,  7 Oct 2025 22:03:48 +0000
Message-ID: <20251007220349.3852807-3-memxor@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251007220349.3852807-1-memxor@gmail.com>
References: <20251007220349.3852807-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5054; i=memxor@gmail.com; h=from:subject; bh=iPp0WPtTw7DLD5DcqnADcmc/bVYmHRcHB/HOwWOURxk=; b=owEBbQKS/ZANAwAKAUzgyIZIvxHKAcsmYgBo5Ym44HTh0usfLD9Dmx7rcgiR/UR+ZJ/G92uGl rK/Dij3u1mJAjMEAAEKAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCaOWJuAAKCRBM4MiGSL8R ypBjD/0V+wk9jGRD1L/iGLE8KPCsTqgEHQ90sTOA2bNX1CchoAG7giQ1Tplwur2VFzcanwa+V1L 7nYYWv5KWtwmEpYDV01t8CHiOcjFDsJWeVTpnPXv4rJvNwW2Ek1a2n7y/UyicNINw0dVb4fQgL0 10cKLRfQ25ZwICfOQGDSb3Q8yTsDWY3w1PsPuQ+5c+gLGjOIIZCOjcjYa0dfjmbIhc/G5E846cv qVNqepEnW8s3vpYGeRaSYgUux0MzBidNV6yIRznHRcmsiY08374YoGCVHrUKDnBPsA5EjJ3BM4I LgI7jIRvI54ABUvuQatUmIG5Vs5Fw1t26t8/oM0zNgkYj42IgDt4obCiicLJkLtJdkw18CU2iJr OohQ7btr6R8I3yHUkJEV3JXcnsnGqXhdTgMp5jhsnxjawjSd2o2THOFwHQuYHmF7D74mOySv9ZB QIfF5tfRvloCjAv+eRLOBdEGenY/WS/7KDlNdaePcVAmsVCTTQAEcHUaQowziIKb+EFbgDFfPEn 0OlUsIk0viZ00PpC+XMHZivOiX45eQ38ic7TL+0QUq1/MI2Zp1vOANMVBzZ83icUTr0LnaoaSO9 sEKG9YU+Zo6y1rVGSP/JCnMo/CrhjMz8OaNJgjqhv9MiyRste513QNQ64YZhqatr4q2QtSM2I0Y yacJPvyr8YCtl7w==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

Rename the storage_get_func_atomic flag to a more generic non_sleepable
flag that tracks whether a helper or kfunc may be called from a
non-sleepable context. This makes the flag more broadly applicable
beyond just storage_get helpers. See [0] for more context.

The flag is now set unconditionally for all helpers and kfuncs when:
- RCU critical section is active.
- Preemption is disabled.
- IRQs are disabled.
- In a non-sleepable context within a sleepable program (e.g., timer
  callbacks), which is indicated by !in_sleepable().

Previously, the flag was only set for storage_get helpers in these
contexts. With this change, it can be used by any code that needs to
differentiate between sleepable and non-sleepable contexts at the
per-instruction level.

The existing usage in do_misc_fixups() for storage_get helpers is
preserved by checking is_storage_get_function() before using the flag.

  [0]: https://lore.kernel.org/bpf/CAP01T76cbaNi4p-y8E0sjE2NXSra2S=Uja8G4hSQDu_SbXxREQ@mail.gmail.com

Cc: Mykyta Yatsenko <yatsenko@meta.com>
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 include/linux/bpf_verifier.h |  2 +-
 kernel/bpf/verifier.c        | 33 +++++++++++++++++----------------
 2 files changed, 18 insertions(+), 17 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 4c497e839526..b57222a25a4a 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -548,7 +548,7 @@ struct bpf_insn_aux_data {
 	bool nospec_result; /* result is unsafe under speculation, nospec must follow */
 	bool zext_dst; /* this insn zero extends dst reg */
 	bool needs_zext; /* alu op needs to clear upper bits */
-	bool storage_get_func_atomic; /* bpf_*_storage_get() with atomic memory alloc */
+	bool non_sleepable; /* helper/kfunc may be called from non-sleepable context */
 	bool is_iter_next; /* bpf_iter_<type>_next() kfunc call */
 	bool call_with_percpu_alloc_ptr; /* {this,per}_cpu_ptr() with prog percpu alloc */
 	u8 alu_state; /* used in combination with alu_limit */
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 32123c4b041a..85a953124412 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -11371,6 +11371,15 @@ static int get_helper_proto(struct bpf_verifier_env *env, int func_id,
 	return *ptr && (*ptr)->func ? 0 : -EINVAL;
 }
 
+/* Check if we're in a sleepable context. */
+static inline bool in_sleepable_context(struct bpf_verifier_env *env)
+{
+	return !env->cur_state->active_rcu_lock &&
+	       !env->cur_state->active_preempt_locks &&
+	       !env->cur_state->active_irq_id &&
+	       in_sleepable(env);
+}
+
 static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 			     int *insn_idx_p)
 {
@@ -11437,9 +11446,6 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
 				func_id_name(func_id), func_id);
 			return -EINVAL;
 		}
-
-		if (is_storage_get_function(func_id))
-			env->insn_aux_data[insn_idx].storage_get_func_atomic = true;
 	}
 
 	if (env->cur_state->active_preempt_locks) {
@@ -11448,9 +11454,6 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
 				func_id_name(func_id), func_id);
 			return -EINVAL;
 		}
-
-		if (is_storage_get_function(func_id))
-			env->insn_aux_data[insn_idx].storage_get_func_atomic = true;
 	}
 
 	if (env->cur_state->active_irq_id) {
@@ -11459,17 +11462,11 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
 				func_id_name(func_id), func_id);
 			return -EINVAL;
 		}
-
-		if (is_storage_get_function(func_id))
-			env->insn_aux_data[insn_idx].storage_get_func_atomic = true;
 	}
 
-	/*
-	 * Non-sleepable contexts in sleepable programs (e.g., timer callbacks)
-	 * are atomic and must use GFP_ATOMIC for storage_get helpers.
-	 */
-	if (!in_sleepable(env) && is_storage_get_function(func_id))
-		env->insn_aux_data[insn_idx].storage_get_func_atomic = true;
+	/* Track non-sleepable context for helpers. */
+	if (!in_sleepable_context(env))
+		env->insn_aux_data[insn_idx].non_sleepable = true;
 
 	meta.func_id = func_id;
 	/* check args */
@@ -13880,6 +13877,10 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 		return -EACCES;
 	}
 
+	/* Track non-sleepable context for kfuncs, same as for helpers. */
+	if (!in_sleepable_context(env))
+		insn_aux->non_sleepable = true;
+
 	/* Check the arguments */
 	err = check_kfunc_args(env, &meta, insn_idx);
 	if (err < 0)
@@ -22502,7 +22503,7 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
 		}
 
 		if (is_storage_get_function(insn->imm)) {
-			if (env->insn_aux_data[i + delta].storage_get_func_atomic)
+			if (env->insn_aux_data[i + delta].non_sleepable)
 				insn_buf[0] = BPF_MOV64_IMM(BPF_REG_5, (__force __s32)GFP_ATOMIC);
 			else
 				insn_buf[0] = BPF_MOV64_IMM(BPF_REG_5, (__force __s32)GFP_KERNEL);
-- 
2.51.0


