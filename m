Return-Path: <bpf+bounces-77771-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E4A1CF0EC3
	for <lists+bpf@lfdr.de>; Sun, 04 Jan 2026 13:31:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 09384304C29C
	for <lists+bpf@lfdr.de>; Sun,  4 Jan 2026 12:29:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 590B72C234A;
	Sun,  4 Jan 2026 12:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fv0c9l1n"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f194.google.com (mail-yw1-f194.google.com [209.85.128.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A063028468E
	for <bpf@vger.kernel.org>; Sun,  4 Jan 2026 12:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767529752; cv=none; b=TxYZ7bVVdclF3XgBhguAUfM659j/gBT3A7Bb0REIY88Zo0DR54UQq/RCqM42sb+3TCSBuKsY0h7cIENuhxuUgP5kg4yg/wDydpLkOZLDt+E3/qsA1aYr+hnZeaLBCXo7wFzyd6C4q0A9jXzu5DBUcjUdUjjfKWrXTZsTljO1CBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767529752; c=relaxed/simple;
	bh=e9VHlm6n7hVwJkXAyd+w0i3/OabKQu+CT+qxcSN8VMk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=acld4pGFlHNF6QMlh/AV/meeMCswIJ0O/oH9a+VokIM7utNG9xtCnWIKxs5FN+497J4SOlbgUGtDo/h665JRnOPogsuIKxWimHauICxUuWreL/nqYPgEOD1j9zXlqATXvXl1RLw8NCL86YGahbuOXJSnKV9vTY3CbE08aIol1z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fv0c9l1n; arc=none smtp.client-ip=209.85.128.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f194.google.com with SMTP id 00721157ae682-78d6a3c3b77so10706087b3.0
        for <bpf@vger.kernel.org>; Sun, 04 Jan 2026 04:29:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767529750; x=1768134550; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jeLX9Qb7FxErvthvcRCs2SbJfJEM0Z2UtyZWl6yDR8g=;
        b=fv0c9l1ndXBM+oIbu73oRmhdnsBPPKKh+s66CwAB+uaPCs67LTa9gvHT542iDbs2iv
         SqsWZ7DVaBvw5C6Mbh0WfpPyMuI7ONMDKvVO/v38HFj63nNvp4W+0j/4fIaA6nqBsKFW
         DLy2gql80PQwyhW2wA7hkqresBuKWG4AJle+1gRautl0F7nY9Eq1p3DMW+zWNUc5o5Tc
         u8ek0KIYSXmg/sL0GDrTXQ/LE4zUCpad6a0afeZF74proLyz2mWpLj6n23ABr7XyiaGR
         FcyAFWzKztvP6q3+RGbNvVP9cBi+YvO5wX8LdYgB+6DBdAFcUI+w+HQ0uzskkAvoLSr6
         XtLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767529750; x=1768134550;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jeLX9Qb7FxErvthvcRCs2SbJfJEM0Z2UtyZWl6yDR8g=;
        b=ZcyMJsAKNWjOz5x4QEMpFtW3fU3eubBBaU0/wb1YU7h1F6e9bBAZBhgQdUUq9ESFXo
         tnJ+Bspu7RHEfLw7A2ChIUWCWXkEbrImASYfb3THWvsoNAlOUZLwI1MC87KnUO5a48bm
         XbzrAUGqnkdh0LtHFJdGt6qzYbtErqjeISib8iSwu2AzVUnUd7pr46TE9/R0XJQwFr11
         yB7i2BskJmY1rHW/SszXR63YiYG2CZMoXgpHuSydr99QC4W+a/ePuulzmgIXgi+ZnZ+T
         jIIPWZPI7rZnSUOjCjsq2eCp99Wae2lAR+h+fezRtwg37enwOBFh1wWSSuDnl0NhUxHW
         6OXA==
X-Forwarded-Encrypted: i=1; AJvYcCUn4cih/ELHjHCEQ+fiyAyr5lplo5RXg3PXQGvp+4YRHtQ7MGWdA88QEBvYv9PUlJoTP8c=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMHiMC7/dbQL6cJMy1meCsHo8I3lMLrt3xHzMdc3VfpEEUUkry
	LHsS8h9Rj9LqCoU9RRbA12pM+JfHkE1OJ13ymxvymTGaNin2wOylOQ2g
X-Gm-Gg: AY/fxX5FvhtBYfHe9pgQRWdhs2GF6IHHzPYxeNBSUI2r4ViMxu/CzIAXFhefKu8lrSM
	xA13kHisJVPTK5xO14G4555bmDCL2JIyrTW2HuFdIVbP2jZZstppODMjL2GCa6Jaqo0AEekLTaA
	rFbneAIhji8wpKJVX2T6zImhyE9iASM64HxD1I6hRTltKmWAF2oyssUCKFvxw2pSMPCORXtdEOr
	zxgF9Q8xRggLHtCB6GVyYUo23mEaUJ9wQeTdw4BlkP6Frow4FlM9SYn9iQMiC423JeZ7/OKlubx
	Z0BoID2STRNTS3HlMaDqm0NIFkjNbyu8jRtl+FYcLqO7wGWEcK+cnyc85L4Rq6Bi3olGbktrWpL
	6oBmJHBsPm1LHQ15b9vOLvvaeXRN/CpHVftIQn5qfKwnjU2+ligkvkDY94mG4WTFRBL51r2NTVQ
	Jk8532DPwxTjiUyffMyQ==
X-Google-Smtp-Source: AGHT+IGkUlFO4z0/g19cOG2YiYyn/dQtce3ZzXHBdsMotbF8XUgoRS6HZP38KUsbyHhpRIIGLJ8tYA==
X-Received: by 2002:a05:690e:169c:b0:644:44d2:a9cc with SMTP id 956f58d0204a3-646e33312abmr3461150d50.7.1767529749663;
        Sun, 04 Jan 2026 04:29:09 -0800 (PST)
Received: from 7940hx ([23.94.188.235])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-78fb4378372sm175449427b3.12.2026.01.04.04.29.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Jan 2026 04:29:09 -0800 (PST)
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
Subject: [PATCH bpf-next v6 03/10] bpf: add the kfunc bpf_fsession_is_return
Date: Sun,  4 Jan 2026 20:28:07 +0800
Message-ID: <20260104122814.183732-4-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260104122814.183732-1-dongml2@chinatelecom.cn>
References: <20260104122814.183732-1-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If fsession exists, we will use the bit (1 << BPF_TRAMP_M_IS_RETURN) in
ctx[-1] to store the "is_return" flag.

Introduce the kfunc bpf_fsession_is_return(), which is used to tell if it
is fexit currently. Meanwhile, inline it in the verifier.

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
Co-developed-by: Leon Hwang <leon.hwang@linux.dev>
Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 include/linux/bpf.h      |  3 +++
 kernel/bpf/verifier.c    | 11 +++++++++-
 kernel/trace/bpf_trace.c | 43 +++++++++++++++++++++++++++++++++++++---
 3 files changed, 53 insertions(+), 4 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 565ca7052518..de6f86a56673 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1229,6 +1229,9 @@ enum {
 #endif
 };
 
+#define BPF_TRAMP_M_NR_ARGS	0
+#define BPF_TRAMP_M_IS_RETURN	8
+
 struct bpf_tramp_links {
 	struct bpf_tramp_link *links[BPF_MAX_TRAMP_LINKS];
 	int nr_links;
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 9e7dd2f0296f..0a771be6cb73 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -12372,6 +12372,7 @@ enum special_kfunc_type {
 	KF_bpf_task_work_schedule_resume_impl,
 	KF_bpf_arena_alloc_pages,
 	KF_bpf_arena_free_pages,
+	KF_bpf_fsession_is_return,
 };
 
 BTF_ID_LIST(special_kfunc_list)
@@ -12448,6 +12449,7 @@ BTF_ID(func, bpf_task_work_schedule_signal_impl)
 BTF_ID(func, bpf_task_work_schedule_resume_impl)
 BTF_ID(func, bpf_arena_alloc_pages)
 BTF_ID(func, bpf_arena_free_pages)
+BTF_ID(func, bpf_fsession_is_return)
 
 static bool is_task_work_add_kfunc(u32 func_id)
 {
@@ -12502,7 +12504,8 @@ get_kfunc_ptr_arg_type(struct bpf_verifier_env *env,
 	struct bpf_reg_state *reg = &regs[regno];
 	bool arg_mem_size = false;
 
-	if (meta->func_id == special_kfunc_list[KF_bpf_cast_to_kern_ctx])
+	if (meta->func_id == special_kfunc_list[KF_bpf_cast_to_kern_ctx] ||
+	    meta->func_id == special_kfunc_list[KF_bpf_fsession_is_return])
 		return KF_ARG_PTR_TO_CTX;
 
 	if (argno + 1 < nargs &&
@@ -22548,6 +22551,12 @@ static int fixup_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 		   desc->func_id == special_kfunc_list[KF_bpf_rdonly_cast]) {
 		insn_buf[0] = BPF_MOV64_REG(BPF_REG_0, BPF_REG_1);
 		*cnt = 1;
+	} else if (desc->func_id == special_kfunc_list[KF_bpf_fsession_is_return]) {
+		/* Load nr_args from ctx - 8 */
+		insn_buf[0] = BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_1, -8);
+		insn_buf[1] = BPF_ALU64_IMM(BPF_RSH, BPF_REG_0, BPF_TRAMP_M_IS_RETURN);
+		insn_buf[2] = BPF_ALU64_IMM(BPF_AND, BPF_REG_0, 1);
+		*cnt = 3;
 	}
 
 	if (env->insn_aux_data[insn_idx].arg_prog) {
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 6b58f9a4dc92..d6f0d5a97c4d 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -3356,12 +3356,49 @@ static const struct btf_kfunc_id_set bpf_kprobe_multi_kfunc_set = {
 	.filter = bpf_kprobe_multi_filter,
 };
 
-static int __init bpf_kprobe_multi_kfuncs_init(void)
+__bpf_kfunc_start_defs();
+
+__bpf_kfunc bool bpf_fsession_is_return(void *ctx)
+{
+	/* This helper call is inlined by verifier. */
+	return !!(((u64 *)ctx)[-1] & (1 << BPF_TRAMP_M_IS_RETURN));
+}
+
+__bpf_kfunc_end_defs();
+
+BTF_KFUNCS_START(tracing_kfunc_set_ids)
+BTF_ID_FLAGS(func, bpf_fsession_is_return, KF_FASTCALL)
+BTF_KFUNCS_END(tracing_kfunc_set_ids)
+
+static int bpf_tracing_filter(const struct bpf_prog *prog, u32 kfunc_id)
 {
-	return register_btf_kfunc_id_set(BPF_PROG_TYPE_KPROBE, &bpf_kprobe_multi_kfunc_set);
+	if (!btf_id_set8_contains(&tracing_kfunc_set_ids, kfunc_id))
+		return 0;
+
+	if (prog->type != BPF_PROG_TYPE_TRACING ||
+	    prog->expected_attach_type != BPF_TRACE_FSESSION)
+		return -EINVAL;
+
+	return 0;
+}
+
+static const struct btf_kfunc_id_set bpf_tracing_kfunc_set = {
+	.owner = THIS_MODULE,
+	.set = &tracing_kfunc_set_ids,
+	.filter = bpf_tracing_filter,
+};
+
+static int __init bpf_trace_kfuncs_init(void)
+{
+	int err = 0;
+
+	err = err ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_KPROBE, &bpf_kprobe_multi_kfunc_set);
+	err = err ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_TRACING, &bpf_tracing_kfunc_set);
+
+	return err;
 }
 
-late_initcall(bpf_kprobe_multi_kfuncs_init);
+late_initcall(bpf_trace_kfuncs_init);
 
 typedef int (*copy_fn_t)(void *dst, const void *src, u32 size, struct task_struct *tsk);
 
-- 
2.52.0


