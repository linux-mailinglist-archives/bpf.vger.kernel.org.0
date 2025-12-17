Return-Path: <bpf+bounces-76849-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CE390CC6E83
	for <lists+bpf@lfdr.de>; Wed, 17 Dec 2025 10:56:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4DDCD3061AA1
	for <lists+bpf@lfdr.de>; Wed, 17 Dec 2025 09:55:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87C1433B6EB;
	Wed, 17 Dec 2025 09:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A1aWS9pd"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com [209.85.214.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ABE3345CD2
	for <bpf@vger.kernel.org>; Wed, 17 Dec 2025 09:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765965323; cv=none; b=OOhwux5ywOJqrrGduSjt0waw8QVS5BIRQ6HKzd9VxWrX1D8ih6iUcwnSn1jEbGD2S18OcKc7kTEXW+Eo2vRu4p+gN7Y6PXnRJlzitg+SX47yfJxQNIq0M8aFmh69ouiQAH74n8lZIzCKE6nir91SfhY8egM6SNoEzhm5/OowNfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765965323; c=relaxed/simple;
	bh=r9OWKtTrZBvuK6cRz3Q7VLtGJ8ShWwZF5jF6bu5OQkg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HQw4fSQEgLT4zTLZfQdEsVtIm0p91VPOOwgVt3vL6yY/RQKsJJpqFQ7NIQB2FOlrXfR8edIgBSADQIt6bng9Yz8Jo9VR+Au1/SsZUjGUyRzLdeL1OYqdCv/VFL+hy1BE681Hfmrt6YPceNkrfgyzw6GyjjlIqnVWOnacuKBx+hI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A1aWS9pd; arc=none smtp.client-ip=209.85.214.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f196.google.com with SMTP id d9443c01a7336-2a102494058so2332685ad.0
        for <bpf@vger.kernel.org>; Wed, 17 Dec 2025 01:55:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765965321; x=1766570121; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SIUG0j0izpbuOIOjcj5qOjyjzCm2KAAyeIbCRoOd5tw=;
        b=A1aWS9pdQ/vK6LICRJXzaaVzr1ljldSqYScvdn7JJOAdQXQ0I9DdpCcKwS+qQuCsX/
         6XLyP6KFssmSdiJ7s0D14n92lRNaUB3WGy5cvCueqy700eUcpbU8uIZg14KakB5g4Sij
         98hbw/iwaToMxxiaYGXlxALIPmFn8Wzze/bQZiz+7HCLjEHMJcZplZjIKMBDWLjK0Njv
         CpLHfGTHVaKmBUORdvGtLQBVgWq5uVP0B172YHuQkY5BsTfzpSAECi+YTcn4BA13zxxb
         jQ3rT0dMCKKe6tyM6eWNLFwwZQS0IGvTAgyDLn7ttBRuvXZVWahgBz2afwr43XbFsI/c
         DyWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765965321; x=1766570121;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SIUG0j0izpbuOIOjcj5qOjyjzCm2KAAyeIbCRoOd5tw=;
        b=eBE8KLb070dGHstZlMN5TRTy8F3Rm2DVD035I+mLsiBCJXXKsKP4QJbjEReEY/rwAd
         L3D41vFUXw67RIvX0yq1lqlLcwasjeV9IzWF9wobEo9hyBOkEfxK+TFGfkCyfebYDh6N
         38ApPSqDDKmnfRG5VIQQcDdh8pDiI6r+QNQebbe1AIyYHtIlTwQIzo2lM4X+i2aLXT2M
         dx8QTyGni5C+ZCiAUnWcl0kOFGoy2ptln+wta0Udzy3HNDFJwBIk85ntkr6dL3sOAk4i
         /cQ07azXKk/uP4nkPB1rnYGyWNEPZBcNbMFJGH2HQkIKqCROR1iJHvud8Cb0q7prU4BR
         8jSQ==
X-Forwarded-Encrypted: i=1; AJvYcCUe/qg2M7xzZJdSvtHHSUupEiQZP4lB/u//QJfxLyP2vf+m0Eb8gEwJCQmEhE5sh9tORmA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXwZ6fiDdA0+MqQMX06qldrom5LGHaYDaZSs4CmKHqR+HBWC2d
	i4eSffnwpUlFsCSVAX3h17DparjkYQxszoMWVXyYVSHoITAvptZffOXP
X-Gm-Gg: AY/fxX5dzw1FcLbCZ1/CmDC4eXm1+zK7hNyYsSHzA0SPw58RcnBOoHMeEze1rQEUjKL
	lUI+51UfQOlZPbXQXnLX6d46RmA65+MNw/sKdgwO54cVm1nohbCTH3tzPtPvPtX2k/YY8naXp+L
	7SQMMv+pUyUWchLCgxkKeJzhFX6RiW384xinZiVIwuMninNhJe+u2h7wx6kMytuM+ld1dRvNwIe
	RIuYagZkx0BfUpsROs7pN2kGz3fOX+ZFL+6QLGkkn2Evk31NxrpRCri3HhVPismcMZ1cPr4B9D0
	AeCvXtqcxdDISmgQDx/9QXGmis/l1NoE4k1sSD8Q7q9Y2keSD4pvXuERJwKNoQBLTaQ+74IUOMf
	q5EE0W+B2b++HF5TfnUTD3Aud2mjWLlFUhXR1Lk/KZf84Xg9fv+b1yPyG5qVWY20HJ9HbCj3VJg
	ex2mOuuzw=
X-Google-Smtp-Source: AGHT+IEuEY2zhpSK6Ll67atcuqDpoLvacpwbYPpKQY7yzrvl2cfM1mMD3OtWBmpiEx+BAtxFOmfWOA==
X-Received: by 2002:a17:902:cf05:b0:2a0:e5c3:d149 with SMTP id d9443c01a7336-2a0e5c3d2c3mr108269105ad.23.1765965320723;
        Wed, 17 Dec 2025 01:55:20 -0800 (PST)
Received: from 7940hx ([43.129.244.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a07fa0b1aasm140715945ad.3.2025.12.17.01.55.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Dec 2025 01:55:20 -0800 (PST)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: ast@kernel.org,
	andrii@kernel.org
Cc: davem@davemloft.net,
	dsahern@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v4 4/9] bpf: add the kfunc bpf_fsession_cookie
Date: Wed, 17 Dec 2025 17:54:40 +0800
Message-ID: <20251217095445.218428-5-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251217095445.218428-1-dongml2@chinatelecom.cn>
References: <20251217095445.218428-1-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement session cookie for fsession. In order to limit the stack usage,
we make 4 as the maximum of the cookie count.

The offset of the current cookie is stored in the
"(ctx[-1] >> BPF_TRAMP_M_COOKIE) & 0xFF". Therefore, we can get the
session cookie with ctx[-offset].

The stack will look like this:

  return value	-> 8 bytes
  argN		-> 8 bytes
  ...
  arg1		-> 8 bytes
  nr_args	-> 8 bytes
  ip(optional)	-> 8 bytes
  cookie2	-> 8 bytes
  cookie1	-> 8 bytes

Inline the bpf_fsession_cookie() in the verifer too.

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
v4:
- limit the maximum of the cookie count to 4
- store the session cookies before nr_regs in stack
---
 include/linux/bpf.h      | 16 ++++++++++++++++
 kernel/bpf/trampoline.c  | 14 +++++++++++++-
 kernel/bpf/verifier.c    | 20 ++++++++++++++++++--
 kernel/trace/bpf_trace.c |  9 +++++++++
 4 files changed, 56 insertions(+), 3 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index d165ace5cc9b..0f35c6ab538c 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1215,6 +1215,7 @@ enum {
 
 #define BPF_TRAMP_M_NR_ARGS	0
 #define BPF_TRAMP_M_IS_RETURN	8
+#define BPF_TRAMP_M_COOKIE	9
 
 struct bpf_tramp_links {
 	struct bpf_tramp_link *links[BPF_MAX_TRAMP_LINKS];
@@ -1318,6 +1319,7 @@ struct bpf_trampoline {
 	struct mutex mutex;
 	refcount_t refcnt;
 	u32 flags;
+	int cookie_cnt;
 	u64 key;
 	struct {
 		struct btf_func_model model;
@@ -1762,6 +1764,7 @@ struct bpf_prog {
 				enforce_expected_attach_type:1, /* Enforce expected_attach_type checking at attach time */
 				call_get_stack:1, /* Do we call bpf_get_stack() or bpf_get_stackid() */
 				call_get_func_ip:1, /* Do we call get_func_ip() */
+				call_session_cookie:1, /* Do we call bpf_fsession_cookie() */
 				tstamp_type_access:1, /* Accessed __sk_buff->tstamp_type */
 				sleepable:1;	/* BPF program is sleepable */
 	enum bpf_prog_type	type;		/* Type of BPF program */
@@ -2137,6 +2140,19 @@ static inline int bpf_fsession_cnt(struct bpf_tramp_links *links)
 	return cnt;
 }
 
+static inline int bpf_fsession_cookie_cnt(struct bpf_tramp_links *links)
+{
+	struct bpf_tramp_links fentries = links[BPF_TRAMP_FENTRY];
+	int cnt = 0;
+
+	for (int i = 0; i < links[BPF_TRAMP_FENTRY].nr_links; i++) {
+		if (fentries.links[i]->link.prog->call_session_cookie)
+			cnt++;
+	}
+
+	return cnt;
+}
+
 int bpf_prog_ctx_arg_info_init(struct bpf_prog *prog,
 			       const struct bpf_ctx_arg_aux *info, u32 cnt);
 
diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
index 3b9fc99e1e89..68f3d73a94a9 100644
--- a/kernel/bpf/trampoline.c
+++ b/kernel/bpf/trampoline.c
@@ -592,6 +592,8 @@ static int bpf_freplace_check_tgt_prog(struct bpf_prog *tgt_prog)
 	return 0;
 }
 
+#define BPF_TRAMP_MAX_COOKIES 4
+
 static int __bpf_trampoline_link_prog(struct bpf_tramp_link *link,
 				      struct bpf_trampoline *tr,
 				      struct bpf_prog *tgt_prog)
@@ -599,7 +601,7 @@ static int __bpf_trampoline_link_prog(struct bpf_tramp_link *link,
 	enum bpf_tramp_prog_type kind, okind;
 	struct bpf_tramp_link *link_existing;
 	struct bpf_fsession_link *fslink;
-	int err = 0;
+	int err = 0, cookie_cnt;
 	int cnt = 0, i;
 
 	okind = kind = bpf_attach_type_to_tramp(link->link.prog);
@@ -640,6 +642,12 @@ static int __bpf_trampoline_link_prog(struct bpf_tramp_link *link,
 		/* prog already linked */
 		return -EBUSY;
 	}
+	cookie_cnt = tr->cookie_cnt;
+	if (link->link.prog->call_session_cookie) {
+		if (cookie_cnt >= BPF_TRAMP_MAX_COOKIES)
+			return -E2BIG;
+		cookie_cnt++;
+	}
 
 	hlist_add_head(&link->tramp_hlist, &tr->progs_hlist[kind]);
 	tr->progs_cnt[kind]++;
@@ -657,6 +665,8 @@ static int __bpf_trampoline_link_prog(struct bpf_tramp_link *link,
 		}
 		hlist_del_init(&link->tramp_hlist);
 		tr->progs_cnt[kind]--;
+	} else {
+		tr->cookie_cnt = cookie_cnt;
 	}
 	return err;
 }
@@ -696,6 +706,8 @@ static int __bpf_trampoline_unlink_prog(struct bpf_tramp_link *link,
 		hlist_del_init(&fslink->fexit.tramp_hlist);
 		tr->progs_cnt[BPF_TRAMP_FEXIT]--;
 		kind = BPF_TRAMP_FENTRY;
+		if (link->link.prog->call_session_cookie)
+			tr->cookie_cnt--;
 	}
 	hlist_del_init(&link->tramp_hlist);
 	tr->progs_cnt[kind]--;
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index b0dcd715150f..da8335cf7c46 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -12381,6 +12381,7 @@ enum special_kfunc_type {
 	KF_bpf_task_work_schedule_signal_impl,
 	KF_bpf_task_work_schedule_resume_impl,
 	KF_bpf_fsession_is_return,
+	KF_bpf_fsession_cookie,
 };
 
 BTF_ID_LIST(special_kfunc_list)
@@ -12456,6 +12457,7 @@ BTF_ID(func, __bpf_trap)
 BTF_ID(func, bpf_task_work_schedule_signal_impl)
 BTF_ID(func, bpf_task_work_schedule_resume_impl)
 BTF_ID(func, bpf_fsession_is_return)
+BTF_ID(func, bpf_fsession_cookie)
 
 static bool is_task_work_add_kfunc(u32 func_id)
 {
@@ -12511,7 +12513,8 @@ get_kfunc_ptr_arg_type(struct bpf_verifier_env *env,
 	bool arg_mem_size = false;
 
 	if (meta->func_id == special_kfunc_list[KF_bpf_cast_to_kern_ctx] ||
-	    meta->func_id == special_kfunc_list[KF_bpf_fsession_is_return])
+	    meta->func_id == special_kfunc_list[KF_bpf_fsession_is_return] ||
+	    meta->func_id == special_kfunc_list[KF_bpf_fsession_cookie])
 		return KF_ARG_PTR_TO_CTX;
 
 	/* In this function, we verify the kfunc's BTF as per the argument type,
@@ -14009,7 +14012,8 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 		}
 	}
 
-	if (meta.func_id == special_kfunc_list[KF_bpf_session_cookie]) {
+	if (meta.func_id == special_kfunc_list[KF_bpf_session_cookie] ||
+	    meta.func_id == special_kfunc_list[KF_bpf_fsession_cookie]) {
 		meta.r0_size = sizeof(u64);
 		meta.r0_rdonly = false;
 	}
@@ -14293,6 +14297,9 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 			return err;
 	}
 
+	if (meta.func_id == special_kfunc_list[KF_bpf_fsession_cookie])
+		env->prog->call_session_cookie = true;
+
 	return 0;
 }
 
@@ -22565,6 +22572,15 @@ static int fixup_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 		insn_buf[1] = BPF_ALU64_IMM(BPF_RSH, BPF_REG_0, BPF_TRAMP_M_IS_RETURN);
 		insn_buf[2] = BPF_ALU64_IMM(BPF_AND, BPF_REG_0, 1);
 		*cnt = 3;
+	} else if (desc->func_id == special_kfunc_list[KF_bpf_fsession_cookie]) {
+		/* Load nr_args from ctx - 8 */
+		insn_buf[0] = BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_1, -8);
+		insn_buf[1] = BPF_ALU64_IMM(BPF_RSH, BPF_REG_0, BPF_TRAMP_M_COOKIE);
+		insn_buf[2] = BPF_ALU64_IMM(BPF_AND, BPF_REG_0, 0xFF);
+		insn_buf[3] = BPF_ALU64_IMM(BPF_LSH, BPF_REG_0, 3);
+		insn_buf[4] = BPF_ALU64_REG(BPF_SUB, BPF_REG_0, BPF_REG_1);
+		insn_buf[5] = BPF_ALU64_IMM(BPF_NEG, BPF_REG_0, 0);
+		*cnt = 6;
 	}
 
 	if (env->insn_aux_data[insn_idx].arg_prog) {
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 0857d77eb34c..ae7866d8ea62 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -3364,10 +3364,19 @@ __bpf_kfunc bool bpf_fsession_is_return(void *ctx)
 	return !!(((u64 *)ctx)[-1] & (1 << BPF_TRAMP_M_IS_RETURN));
 }
 
+__bpf_kfunc u64 *bpf_fsession_cookie(void *ctx)
+{
+	/* This helper call is inlined by verifier. */
+	u64 off = (((u64 *)ctx)[-1] >> BPF_TRAMP_M_COOKIE) & 0xFF;
+
+	return &((u64 *)ctx)[-off];
+}
+
 __bpf_kfunc_end_defs();
 
 BTF_KFUNCS_START(tracing_kfunc_set_ids)
 BTF_ID_FLAGS(func, bpf_fsession_is_return, KF_FASTCALL)
+BTF_ID_FLAGS(func, bpf_fsession_cookie, KF_FASTCALL)
 BTF_KFUNCS_END(tracing_kfunc_set_ids)
 
 static int bpf_tracing_filter(const struct bpf_prog *prog, u32 kfunc_id)
-- 
2.52.0


