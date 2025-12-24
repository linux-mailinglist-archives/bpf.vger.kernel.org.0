Return-Path: <bpf+bounces-77411-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CF93CDC570
	for <lists+bpf@lfdr.de>; Wed, 24 Dec 2025 14:17:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CF41D302DA74
	for <lists+bpf@lfdr.de>; Wed, 24 Dec 2025 13:16:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EE7F33E34D;
	Wed, 24 Dec 2025 13:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mRSfmIlW"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f196.google.com (mail-pf1-f196.google.com [209.85.210.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0460633D6C0
	for <bpf@vger.kernel.org>; Wed, 24 Dec 2025 13:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766581730; cv=none; b=ll0Uodu+ABzcoT+2Z4GCJaQ9UAAcAMQBt+JXEKuP7PuQkCh4z7er9m/lla1jp2+qQG/IHTayrU1bQ6XS3UycmO9zWYp17prCNTdqOyxiyGDHEvrHn1OSPj/JK+4uD+lnQlL5ZmWe25Fw3qYejolL/FQgmJXHv4oELq04hwC+H28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766581730; c=relaxed/simple;
	bh=AwalfVv6m0dQt+f9r7kLNSHNISYXkJr76Q3fUrZMrgQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PdhxDgaJWVqPAaMgljXQfTym95zC2QCjEMdxrUMX/EbSev+dSjYBwIxvpBz6CLDShPXZEJf99mKLj+n8wB36uYdYryLOUxBPo93zpa5hDHZ0cz8jErwlUAhxh4OtC7wOqh42NMq8lAUmci+4+O2VEppIjtMLk307kqsk/mmGX6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mRSfmIlW; arc=none smtp.client-ip=209.85.210.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f196.google.com with SMTP id d2e1a72fcca58-7b9215e55e6so3801446b3a.2
        for <bpf@vger.kernel.org>; Wed, 24 Dec 2025 05:08:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766581727; x=1767186527; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o0tuqo4muaPkDdS8W/BNaU8fWSvfbpQMCrEFv+IUd5c=;
        b=mRSfmIlWRmlVrdDBF5OJ/N0E/+N07MyTAE+gxoSudWX+Rto5B+ehyVDKvGV3TCur1s
         R8LMwQHRkxi5BjJE49DUbC/uTepzIsSzUIjrAiKLvQQJmnkqZcG5FppW9WJHpZ+yjuwf
         MLofoo4i3XDzPaHj+l0u8JbVFU2FLqGaQowtTV58dl0DbztdoAHDeqA5pmsX8Juz4scA
         4H1ZAtRGelnTNBy2hTxtRmpZQgasgJ3AtPRScCzWsxku7LIv/Vu/DCKTj6P65+5brUMp
         z+LJu9r1Rkp1T8CxqMhkOPbqUGYRJF1MpUPbcNx9Rk7M60+f6JTE8rqj2Q8jQdRb0SGU
         UWPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766581727; x=1767186527;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=o0tuqo4muaPkDdS8W/BNaU8fWSvfbpQMCrEFv+IUd5c=;
        b=Dm/NlevLrwCMq6e9l2qnz08Jy1ZRgnhFudwZphdFHGGywSO8yqX3ee7R4jc80T5MT8
         /4aSxjJBsEuf44wvj6ZgoMjxfU30z80XUhVApSmoqPOU9ZQQoznNQFxBcVla5RUvOrw+
         r1iuA4gbyYcskJu0Y1HqlEtVWPE78aZvSki7oogbhUesVm1za/CyRuU52MJve0wVyTIg
         BYq3mqy3xtSwQBcguUBf11YliXxo1xMWW8SK9K/fTxq+IFYVmIyBXgbU5zW3sANkn/Fr
         S8Nd6szzzErWv3gWH+jaYJUNuKdqxbeoBEQM877WGjLOB13r/Af5IL0c7QCHxq0QuqSA
         NvCA==
X-Forwarded-Encrypted: i=1; AJvYcCUU0QIwkM5LJfr3/4+dionzmACmX+FqZYJLePJDDdJHkFFJdA1YaTsqDpazkWV469YChAE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9sZ5BWXFrYaE3c8ZXKGwvcqaC4G4lOgfJ3hJodoSlGi/vgm8M
	dN0A/LoOdrTtZj4OwA60YY/wmCDrpNoqj7MjDiCxYTnbOrO4UZlvximk
X-Gm-Gg: AY/fxX4FFOlZPZ8qB727Wx3qQAhewmlZZTzEySCLGsFc1i9Qw4N47oGNX8lNG7PI5jS
	6L0pinTOvlesgc5Swswrd6yCGB5y7gWzjHHGdeKaLRcX13IMg7lgDgepTAjD/BOjkUGMcJtvKAE
	pVRSqANC1DUCX1duBY++hc+NbpI9WmCM2yEcdhVwouCRRDRlJC5BTJ4drvIZ5LkQCKnyDcn+lkZ
	I0UKlBpSpdyV/KJkNLR++5hOgQ1SLqfzkl5PjpClxR4hADkdoaGgDH1kzwUFGQ2uiGB+VBLDCDN
	U/MPPFos5yNn0Kb9BOd6pnLAlgpULjWeHlgtB6/ujQsqMUMh5NgFSrFF/R3pSQBJhxjAO6D++p1
	1BYU+N26PlpBdWMDnZmjWw2FJHYzdiXyeMthlfW5wQpbb1h7lfaK2nFnxQKykAY8WgrbODKYAc+
	W6uN/h/DJOpGmvO+WHpg==
X-Google-Smtp-Source: AGHT+IGloR8ssu486avHCKEdAqC0Ix5YfcJO8N9W563abq1gR5GklfLvtmD3nhTAWb70QG6dAC43rw==
X-Received: by 2002:a05:6a00:3395:b0:7e8:4587:e8ca with SMTP id d2e1a72fcca58-7ff66a6c4eamr15790814b3a.61.1766581727172;
        Wed, 24 Dec 2025 05:08:47 -0800 (PST)
Received: from 7950hx ([160.187.0.149])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7ff7dfac28fsm16841173b3a.32.2025.12.24.05.08.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Dec 2025 05:08:46 -0800 (PST)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: ast@kernel.org,
	andrii@kernel.org
Cc: daniel@iogearbox.net,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	davem@davemloft.net,
	dsahern@kernel.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	jiang.biao@linux.dev,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v5 04/10] bpf: add the kfunc bpf_fsession_cookie
Date: Wed, 24 Dec 2025 21:07:29 +0800
Message-ID: <20251224130735.201422-5-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251224130735.201422-1-dongml2@chinatelecom.cn>
References: <20251224130735.201422-1-dongml2@chinatelecom.cn>
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
  ip (optional)	-> 8 bytes
  cookie2	-> 8 bytes
  cookie1	-> 8 bytes

Inline the bpf_fsession_cookie() in the verifier too.

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
v5:
- remove "cookie_cnt" in struct bpf_trampoline

v4:
- limit the maximum of the cookie count to 4
- store the session cookies before nr_regs in stack
---
 include/linux/bpf.h      | 15 +++++++++++++++
 kernel/bpf/trampoline.c  | 13 +++++++++++--
 kernel/bpf/verifier.c    | 20 ++++++++++++++++++--
 kernel/trace/bpf_trace.c |  9 +++++++++
 4 files changed, 53 insertions(+), 4 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index dc6b4109f0bf..4095f4c2f833 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1215,6 +1215,7 @@ enum {
 
 #define BPF_TRAMP_M_NR_ARGS	0
 #define BPF_TRAMP_M_IS_RETURN	8
+#define BPF_TRAMP_M_COOKIE	9
 
 struct bpf_tramp_links {
 	struct bpf_tramp_link *links[BPF_MAX_TRAMP_LINKS];
@@ -1762,6 +1763,7 @@ struct bpf_prog {
 				enforce_expected_attach_type:1, /* Enforce expected_attach_type checking at attach time */
 				call_get_stack:1, /* Do we call bpf_get_stack() or bpf_get_stackid() */
 				call_get_func_ip:1, /* Do we call get_func_ip() */
+				call_session_cookie:1, /* Do we call bpf_fsession_cookie() */
 				tstamp_type_access:1, /* Accessed __sk_buff->tstamp_type */
 				sleepable:1;	/* BPF program is sleepable */
 	enum bpf_prog_type	type;		/* Type of BPF program */
@@ -2137,6 +2139,19 @@ static inline int bpf_fsession_cnt(struct bpf_tramp_links *links)
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
index 77d474fc973a..347e92e7c54e 100644
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
@@ -600,7 +602,7 @@ static int __bpf_trampoline_link_prog(struct bpf_tramp_link *link,
 	struct bpf_tramp_link *link_exiting;
 	struct bpf_fsession_link *fslink;
 	struct hlist_head *prog_list;
-	int err = 0;
+	int err = 0, cookie_cnt = 0;
 	int cnt = 0, i;
 
 	kind = bpf_attach_type_to_tramp(link->link.prog);
@@ -637,11 +639,18 @@ static int __bpf_trampoline_link_prog(struct bpf_tramp_link *link,
 		/* prog already linked */
 		return -EBUSY;
 	hlist_for_each_entry(link_exiting, prog_list, tramp_hlist) {
-		if (link_exiting->link.prog != link->link.prog)
+		if (link_exiting->link.prog != link->link.prog) {
+			if (kind == BPF_TRAMP_FSESSION &&
+			    link_exiting->link.prog->call_session_cookie)
+				cookie_cnt++;
 			continue;
+		}
 		/* prog already linked */
 		return -EBUSY;
 	}
+	if (link->link.prog->call_session_cookie &&
+	    cookie_cnt >= BPF_TRAMP_MAX_COOKIES)
+		return -E2BIG;
 
 	hlist_add_head(&link->tramp_hlist, prog_list);
 	if (kind == BPF_TRAMP_FSESSION) {
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 8a5787e6ab0b..8928ce5bbeb1 100644
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
index 8a94a507bd51..67f673c41d50 100644
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


