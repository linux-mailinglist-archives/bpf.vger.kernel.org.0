Return-Path: <bpf+bounces-72206-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 868FBC0A1FF
	for <lists+bpf@lfdr.de>; Sun, 26 Oct 2025 04:03:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7BEE84E257F
	for <lists+bpf@lfdr.de>; Sun, 26 Oct 2025 03:02:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C57D23908B;
	Sun, 26 Oct 2025 03:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B0s9p8z2"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f196.google.com (mail-pg1-f196.google.com [209.85.215.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8AF22405F8
	for <bpf@vger.kernel.org>; Sun, 26 Oct 2025 03:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761447725; cv=none; b=iCTv7bTZuT1OrJYK4jTbKcRBOL+RG4B2DUKfLionlghIVwF9450Qe7cyrUzaUIzZF8RdTs4hmPcTxIZj6jtlbL9Gpyot9BwEjoBJCQG1D/w16TH3TFXi8kpVX+5659oTmm/tQNtnUniSNTFN87VM/GKh1OdApcuzR+ZzV0uQDp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761447725; c=relaxed/simple;
	bh=vK0EtXyF0TAv0W+LwES+hsw/IVhCieW5oKRtWSpXi08=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lO9yZ/T2wN0n7y4TgxcWorUbVNr0sxAump76txty9853PvKMPtNHOUtHa1K79tl6SVx0Ibt6eLCW/ml85S5yOaH+a7kPot5RIvTh6r426X6/qEjPi2BxadQrTFPZF+vkgvsdk97ozrqGSd35U6ztrfPTgSZDBQGIBewuwi26vS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B0s9p8z2; arc=none smtp.client-ip=209.85.215.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f196.google.com with SMTP id 41be03b00d2f7-b6cfffbb1e3so2271546a12.3
        for <bpf@vger.kernel.org>; Sat, 25 Oct 2025 20:02:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761447723; x=1762052523; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oa5InkxvVUN642DJUe0KYXiTiyc8NAW7OtkrLGo/nXg=;
        b=B0s9p8z2rqLzmu0ZCL5H24uT5TNaB6J5AVngfJezN2R9593CoXQ0znRk25WKqdBy/1
         q2OqwKAATNzs5pKGi8hSc6vAjOUspSZ2q7WcujoW9AGPtdsyhQg5McPpDcIZIaw5za7z
         r7bt3Nibu3JqXdbxTDyvCYnt/2r+yEwdg6CjuRM4LeC27v93YqI582TL6oMSGacEtmeY
         6WmZSGQXw5RJIz2yrqV5podl0rfuRqYFMurAtTl33SDHs3jp/5//fyJuVCww/mrHeKjj
         O4vrn5J2cUqHlzwwqdKVCY1J/mE0tq6dzp0m+SzIZnpXfkqgtTyWd7r01SbdwgBTANZw
         nBiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761447723; x=1762052523;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oa5InkxvVUN642DJUe0KYXiTiyc8NAW7OtkrLGo/nXg=;
        b=moYTdwBc6OLmv39mBQlS4aSP3Hg0iIXwCq6A4VMaebwG16jsp4LLUHLds+mAl4yNSl
         XkhuEUfPK+EFESaPzK3Jz1ueR9JHODSC3oqtf34o5D3P3c1AexypHkB5y78tEFz4mnVw
         wo3qOzUWTg4pVjHjBCNarOopRD+6g5sY9QG6HPbiDz1X7uAl04SeD/PdpX3l48mu9WXg
         qOdqxkkR8B4W7KUed5EHM2U+rnwXadqYkg05dsx1eRrjjbGTXeOVSz6HNHP/Hhktewdd
         fp2GrntfI73ZIsBQz11/PG49slMF/3KMP+rY7qdg2mgcE8j0JELKa7M+l4u+fpqkRIcC
         /77A==
X-Forwarded-Encrypted: i=1; AJvYcCUtg1lPRUCctZXiMOz4z7o3Gor/caDUY9iJt3V0XLm9cN67gkugOb9WvB10irSr3XWbGNo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCDqiKKPqDMJo4QF4Ao7Jbczy9xDxBmi79NlUXeeqA1a8FrEgS
	i61z73aBCw9d10pMfIcoqf9OeCN/6LFICNwbxgT+qldjk8qB8IO/0kV/
X-Gm-Gg: ASbGnctVG1zZvMK8ZWs5p0yFjhwE8jWDtRwrq72Ry0VBXHzdsSp1MenpIJLh6m73f/F
	sBpQ2KY5SD10DSTi89ndfzudJmQTq4oVazob4nCv2vU1eTcjcdmNTJCkUYAKdxpUskvjxfjWGaa
	RlWeSA2nh8wakFzhTYU0VW2LpberrHO2wSZyEXvNY2ZA7+9KawXNc/RkZrsF6XI/w6BkAwoxP+r
	0qnhnp+bdnZQC4y89wHGChWOYy8BWm+dZ8Pp8+iPelg0EG30QKRPmEZJbhKke2tEYJw7E6lte7n
	5CPtb5Dc0fQD7JALoib1EmOgx6TfE2EHFEVm7ac+OeyZR7jaPcfAqQdqK0IWGBQwnDCsQJjWc3b
	XjSWw4kzQ8eg3jNFdMsS64r16vOrDDX539HOAqLR1GIGobgreow7N6x3IZQz1os6A3CrFWPVkR/
	0EFkWjs0YuWC4=
X-Google-Smtp-Source: AGHT+IFxWgkIq1VivRbF+1Yvqo5Ua7kf/vo2jP2bHKSgdoIAHVPL9mtpbM8fwrjkk+f/fOyMBUBZsQ==
X-Received: by 2002:a17:902:e88e:b0:27e:f018:d312 with SMTP id d9443c01a7336-290c9cf350amr421236215ad.1.1761447722885;
        Sat, 25 Oct 2025 20:02:02 -0700 (PDT)
Received: from 7950hx ([43.129.244.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498d40b1esm38100645ad.73.2025.10.25.20.01.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Oct 2025 20:02:02 -0700 (PDT)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: ast@kernel.org,
	jolsa@kernel.org
Cc: daniel@iogearbox.net,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	mattbobrowski@google.com,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	leon.hwang@linux.dev,
	jiang.biao@linux.dev,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH bpf-next v3 2/7] bpf: add two kfunc for TRACE_SESSION
Date: Sun, 26 Oct 2025 11:01:38 +0800
Message-ID: <20251026030143.23807-3-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251026030143.23807-1-dongml2@chinatelecom.cn>
References: <20251026030143.23807-1-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If TRACE_SESSION exists, we will use extra 8-bytes in the stack of the
trampoline to store the flags that we needed, and the 8-bytes lie after
the return value, which means ctx[nr_args + 1]. And we will store the
flag "is_exit" to the first bit of it.

Introduce the kfunc bpf_tracing_is_exit(), which is used to tell if it
is fexit currently. Meanwhile, inline it in the verifier.

Add the kfunc bpf_fsession_cookie(), which is similar to
bpf_session_cookie() and return the address of the session cookie. The
address of the session cookie is stored after session flags, which means
ctx[nr_args + 2]. Inline this kfunc in the verifier too.

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
Co-developed-by: Leon Hwang <leon.hwang@linux.dev>
Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
v3:
- merge the bpf_tracing_is_exit and bpf_fsession_cookie into a single
  patch

v2:
- store the session flags after return value, instead of before nr_args
- inline the bpf_tracing_is_exit, as Jiri suggested
---
 include/linux/bpf.h      |  1 +
 kernel/bpf/verifier.c    | 33 ++++++++++++++++++++--
 kernel/trace/bpf_trace.c | 59 ++++++++++++++++++++++++++++++++++++++--
 3 files changed, 88 insertions(+), 5 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 6b5855c80fa6..ce55d3881c0d 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1736,6 +1736,7 @@ struct bpf_prog {
 				enforce_expected_attach_type:1, /* Enforce expected_attach_type checking at attach time */
 				call_get_stack:1, /* Do we call bpf_get_stack() or bpf_get_stackid() */
 				call_get_func_ip:1, /* Do we call get_func_ip() */
+				call_session_cookie:1, /* Do we call bpf_fsession_cookie() */
 				tstamp_type_access:1, /* Accessed __sk_buff->tstamp_type */
 				sleepable:1;	/* BPF program is sleepable */
 	enum bpf_prog_type	type;		/* Type of BPF program */
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 818deb6a06e4..6f8aa4718d6f 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -12293,6 +12293,8 @@ enum special_kfunc_type {
 	KF___bpf_trap,
 	KF_bpf_task_work_schedule_signal,
 	KF_bpf_task_work_schedule_resume,
+	KF_bpf_tracing_is_exit,
+	KF_bpf_fsession_cookie,
 };
 
 BTF_ID_LIST(special_kfunc_list)
@@ -12365,6 +12367,8 @@ BTF_ID(func, bpf_res_spin_unlock_irqrestore)
 BTF_ID(func, __bpf_trap)
 BTF_ID(func, bpf_task_work_schedule_signal)
 BTF_ID(func, bpf_task_work_schedule_resume)
+BTF_ID(func, bpf_tracing_is_exit)
+BTF_ID(func, bpf_fsession_cookie)
 
 static bool is_task_work_add_kfunc(u32 func_id)
 {
@@ -12419,7 +12423,9 @@ get_kfunc_ptr_arg_type(struct bpf_verifier_env *env,
 	struct bpf_reg_state *reg = &regs[regno];
 	bool arg_mem_size = false;
 
-	if (meta->func_id == special_kfunc_list[KF_bpf_cast_to_kern_ctx])
+	if (meta->func_id == special_kfunc_list[KF_bpf_cast_to_kern_ctx] ||
+	    meta->func_id == special_kfunc_list[KF_bpf_tracing_is_exit] ||
+	    meta->func_id == special_kfunc_list[KF_bpf_fsession_cookie])
 		return KF_ARG_PTR_TO_CTX;
 
 	/* In this function, we verify the kfunc's BTF as per the argument type,
@@ -13912,7 +13918,8 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 		}
 	}
 
-	if (meta.func_id == special_kfunc_list[KF_bpf_session_cookie]) {
+	if (meta.func_id == special_kfunc_list[KF_bpf_session_cookie] ||
+	    meta.func_id == special_kfunc_list[KF_bpf_fsession_cookie]) {
 		meta.r0_size = sizeof(u64);
 		meta.r0_rdonly = false;
 	}
@@ -14193,6 +14200,9 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 			return err;
 	}
 
+	if (meta.func_id == special_kfunc_list[KF_bpf_fsession_cookie])
+		env->prog->call_session_cookie = true;
+
 	return 0;
 }
 
@@ -22012,6 +22022,25 @@ static int fixup_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 		   desc->func_id == special_kfunc_list[KF_bpf_rdonly_cast]) {
 		insn_buf[0] = BPF_MOV64_REG(BPF_REG_0, BPF_REG_1);
 		*cnt = 1;
+	} else if (desc->func_id == special_kfunc_list[KF_bpf_tracing_is_exit]) {
+		/* Load nr_args from ctx - 8 */
+		insn_buf[0] = BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_1, -8);
+		/* add rax, 1 */
+		insn_buf[1] = BPF_ALU64_IMM(BPF_ADD, BPF_REG_0, 1);
+		insn_buf[2] = BPF_ALU64_IMM(BPF_LSH, BPF_REG_0, 3);
+		insn_buf[3] = BPF_ALU64_REG(BPF_ADD, BPF_REG_0, BPF_REG_1);
+		insn_buf[4] = BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_0, 0);
+		insn_buf[5] = BPF_ALU64_IMM(BPF_AND, BPF_REG_0, 1);
+		*cnt = 6;
+	} else if (desc->func_id == special_kfunc_list[KF_bpf_fsession_cookie]) {
+		/* Load nr_args from ctx - 8 */
+		insn_buf[0] = BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_1, -8);
+		/* add rax, 2 */
+		insn_buf[1] = BPF_ALU64_IMM(BPF_ADD, BPF_REG_0, 2);
+		insn_buf[2] = BPF_ALU64_IMM(BPF_LSH, BPF_REG_0, 3);
+		insn_buf[3] = BPF_ALU64_REG(BPF_ADD, BPF_REG_0, BPF_REG_1);
+		insn_buf[4] = BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_0, 0);
+		*cnt = 5;
 	}
 
 	if (env->insn_aux_data[insn_idx].arg_prog) {
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 4f87c16d915a..4a8568bd654d 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -3356,12 +3356,65 @@ static const struct btf_kfunc_id_set bpf_kprobe_multi_kfunc_set = {
 	.filter = bpf_kprobe_multi_filter,
 };
 
-static int __init bpf_kprobe_multi_kfuncs_init(void)
+__bpf_kfunc_start_defs();
+
+__bpf_kfunc bool bpf_tracing_is_exit(void *ctx)
 {
-	return register_btf_kfunc_id_set(BPF_PROG_TYPE_KPROBE, &bpf_kprobe_multi_kfunc_set);
+	/* This helper call is inlined by verifier. */
+	u64 nr_args = ((u64 *)ctx)[-1];
+
+	/*
+	 * ctx[nr_args + 1] is the session flags, and the last bit is
+	 * is_exit.
+	 */
+	return ((u64 *)ctx)[nr_args + 1] & 1;
+}
+
+__bpf_kfunc u64 *bpf_fsession_cookie(void *ctx)
+{
+	/* This helper call is inlined by verifier. */
+	u64 nr_args = ((u64 *)ctx)[-1];
+
+	/* ctx[nr_args + 2] is the session cookie address */
+	return (u64 *)((u64 *)ctx)[nr_args + 2];
+}
+
+__bpf_kfunc_end_defs();
+
+BTF_KFUNCS_START(tracing_kfunc_set_ids)
+BTF_ID_FLAGS(func, bpf_tracing_is_exit, KF_FASTCALL)
+BTF_ID_FLAGS(func, bpf_fsession_cookie, KF_FASTCALL)
+BTF_KFUNCS_END(tracing_kfunc_set_ids)
+
+static int bpf_tracing_filter(const struct bpf_prog *prog, u32 kfunc_id)
+{
+	if (!btf_id_set8_contains(&tracing_kfunc_set_ids, kfunc_id))
+		return 0;
+
+	if (prog->type != BPF_PROG_TYPE_TRACING ||
+	    prog->expected_attach_type != BPF_TRACE_SESSION)
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
2.51.1


