Return-Path: <bpf+bounces-71685-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3824ABFAC21
	for <lists+bpf@lfdr.de>; Wed, 22 Oct 2025 10:03:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8B90D4F8A4C
	for <lists+bpf@lfdr.de>; Wed, 22 Oct 2025 08:03:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 169F13009EE;
	Wed, 22 Oct 2025 08:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XTs6Qcba"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f195.google.com (mail-pl1-f195.google.com [209.85.214.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4C17285CB3
	for <bpf@vger.kernel.org>; Wed, 22 Oct 2025 08:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761120144; cv=none; b=AAui5SC3KmXP6dMzbD6eDNk9Z3vcYmHpqRZlpL1pYglPsNeNdzDMMPaBr3PNDE7QabikZv9AtPTUEa303r2oaAV+kW2DCwiy4zCXltsomEW863Gm7vcd0OKny7HdkvzIE58reiuDkGWmFvTgROz6j/BLWif+U8oIAzGkTKLW2+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761120144; c=relaxed/simple;
	bh=MEFs+beI5cBBgDKfKyHyJzvZIINf6BRa4OCOzMkRRmc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TdybIxbkWUEq5x1D4PrYO4RNUUv4lGmqr5pwblQyA2JmhEH3qZy9D71XYUbo+QKhWF2bA9WthkQGiLdO8ko6ZLjEU2qchQdLzUP894tWiViiYiv5P5Pwx2XYiFc1aEy6/p3q9msTHQOIDHR4eEB8StmAzh7BOJ3Rr/EPVdB0mhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XTs6Qcba; arc=none smtp.client-ip=209.85.214.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f195.google.com with SMTP id d9443c01a7336-290ac2ef203so65389275ad.1
        for <bpf@vger.kernel.org>; Wed, 22 Oct 2025 01:02:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761120140; x=1761724940; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U0dIN4en5Nbyg37fgM4seNbI3NZS7JVL5G+Wmq/ATFM=;
        b=XTs6QcbaK1kyOTlGaNkKCHhCLwHvxno2yaCUVsidcyaX2a5yn/keuaeYN+EG1R3l6d
         fIhQfITJomjxWZq2cW2ZPcDFO4fT+w1qCM4cfU/DaXFP2/JOThHX71tdhG59CCf+URLv
         0/TuEyCVvdbCz35DfpesngUL5slei2CSMBANj/RwXfuDCig+cra9Sk0iE9e6NlcHctZS
         WHFOTpmu3Kau8vBvqha/EicmdnyzhjD8FdFRCyuGPzhgtHJrQOBVPWdoor68QutiBef6
         hPlUKxw9bS+MU/xeuYdS5JtrjJ+VN42MtOUTFojOwhVGfUkgWWbCaBF5tzLX456uPmJS
         l6Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761120140; x=1761724940;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U0dIN4en5Nbyg37fgM4seNbI3NZS7JVL5G+Wmq/ATFM=;
        b=fGRr8QGShQcCB3bWqqbBOEGkVRf6wJyJ9YI0pmzlDy556o2VB4GmXwC1VSEnTRanN7
         02jKMXhXhC6tXuzE9uzWvVGwNyu0XgzWfyve000/ur8Wgja0wLCDj6yoMZIvt6eiggKZ
         XJDp3dXKT50bFikqCT0LZxPVPuxEzEpREd2wT6Wx8Yz/XiG3tEnmxJVdpZLrTZVf5IJh
         /ezTVTI3+VuXCsKqxvPga3G81r4bZzna1diNeCSmFQRYGTzHd2J200NFU6qpthwG2Y+T
         bWDothQgzv1smD+0t1iQz2LN/cTfUw8H+eaUN986LUHU2Xzoq5Zia0AZdl/zQ2VmAWsO
         l8Iw==
X-Forwarded-Encrypted: i=1; AJvYcCUTU0CGePfrBX5WyAxL0UmaTtJ1vApf/HGC6AJPRbCT2aCh3ITvL/YfZVbkIRKVzUB7ipM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwqiKyZFna/p4plZg8Q4Nqv0gbw6C9RHPFJVm1a+xOkVRBTWqo
	Zx5ZoV7DCZtfxL6ZyqPsxq0OiPfbKuvloz+TsH1sH53eaCph5Ol5pFlp
X-Gm-Gg: ASbGncvpk7mwfAqGQ+cOEIEkxPMuyD4DSP8VWnLdQVJz8jGzAy6q+sbL5rZ+bZVNDSY
	M8Tx/rpIkcPOF7ysciS92Vsds/EdLwQSGeImTtUPO432+eCrUBFJgo13gMpgNsgnsmDNFdGVmNW
	+7ODre4bkQaJ80gvRRVFlMVyXVROCxwWxP5tFVOxmPV+nC8ZbgfkidGQVTGXcOPTCTAkqG7gX9+
	0C1ZXnBL08sxxaz3cobAeo1I6avxdH9d0iFSYE+Uf/94UEFNQcCGuskA0PqwlcL6+2UCUQNU6wa
	jBVpHCtQ1g6W2geIMxrXuTjYNLtO7vzorfEklAHxO0X7521V/feTQAgU9zc4t1G7Sl1YubyKs75
	ELqzbnaZBlhw+eMH+rFXPcD+hZm8DLOO43VfcTzb/2tItI+znry1oDk7jHmZp9EtdN5Nz/iS2
X-Google-Smtp-Source: AGHT+IGIv/kxjl/Cr8AVdluhKxdEQMlUC/jiC9m9GjymD3dSUhssWXA9pvsnYvEYqz6+fWunATRtxw==
X-Received: by 2002:a17:902:e88e:b0:24b:270e:56cb with SMTP id d9443c01a7336-290c9ce6427mr247961835ad.27.1761120140275;
        Wed, 22 Oct 2025 01:02:20 -0700 (PDT)
Received: from 7950hx ([43.129.244.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-292471d7e41sm131947785ad.57.2025.10.22.01.02.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 01:02:19 -0700 (PDT)
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
	mathieu.desnoyers@efficios.com,
	leon.hwang@linux.dev,
	jiang.biao@linux.dev,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH bpf-next v2 02/10] bpf: add kfunc bpf_tracing_is_exit for TRACE_SESSION
Date: Wed, 22 Oct 2025 16:01:51 +0800
Message-ID: <20251022080159.553805-3-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.51.1.dirty
In-Reply-To: <20251022080159.553805-1-dongml2@chinatelecom.cn>
References: <20251022080159.553805-1-dongml2@chinatelecom.cn>
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

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
Co-developed-by: Leon Hwang <leon.hwang@linux.dev>
Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
v2:
- store the session flags after return value, instead of before nr_args
- inline the bpf_tracing_is_exit, as Jiri suggested
---
 kernel/bpf/verifier.c    | 15 +++++++++++-
 kernel/trace/bpf_trace.c | 49 +++++++++++++++++++++++++++++++++++++---
 2 files changed, 60 insertions(+), 4 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 3ffdf2143f16..a4d0dd4440fd 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -12293,6 +12293,7 @@ enum special_kfunc_type {
 	KF___bpf_trap,
 	KF_bpf_task_work_schedule_signal,
 	KF_bpf_task_work_schedule_resume,
+	KF_bpf_tracing_is_exit,
 };
 
 BTF_ID_LIST(special_kfunc_list)
@@ -12365,6 +12366,7 @@ BTF_ID(func, bpf_res_spin_unlock_irqrestore)
 BTF_ID(func, __bpf_trap)
 BTF_ID(func, bpf_task_work_schedule_signal)
 BTF_ID(func, bpf_task_work_schedule_resume)
+BTF_ID(func, bpf_tracing_is_exit)
 
 static bool is_task_work_add_kfunc(u32 func_id)
 {
@@ -12419,7 +12421,8 @@ get_kfunc_ptr_arg_type(struct bpf_verifier_env *env,
 	struct bpf_reg_state *reg = &regs[regno];
 	bool arg_mem_size = false;
 
-	if (meta->func_id == special_kfunc_list[KF_bpf_cast_to_kern_ctx])
+	if (meta->func_id == special_kfunc_list[KF_bpf_cast_to_kern_ctx] ||
+	    meta->func_id == special_kfunc_list[KF_bpf_tracing_is_exit])
 		return KF_ARG_PTR_TO_CTX;
 
 	/* In this function, we verify the kfunc's BTF as per the argument type,
@@ -21994,6 +21997,16 @@ static int fixup_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
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
 	}
 
 	if (env->insn_aux_data[insn_idx].arg_prog) {
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 4f87c16d915a..d0720d850621 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -3356,12 +3356,55 @@ static const struct btf_kfunc_id_set bpf_kprobe_multi_kfunc_set = {
 	.filter = bpf_kprobe_multi_filter,
 };
 
-static int __init bpf_kprobe_multi_kfuncs_init(void)
+__bpf_kfunc_start_defs();
+
+__bpf_kfunc bool bpf_tracing_is_exit(void *ctx)
+{
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
+__bpf_kfunc_end_defs();
+
+BTF_KFUNCS_START(tracing_kfunc_set_ids)
+BTF_ID_FLAGS(func, bpf_tracing_is_exit, KF_FASTCALL)
+BTF_KFUNCS_END(tracing_kfunc_set_ids)
+
+static int bpf_tracing_filter(const struct bpf_prog *prog, u32 kfunc_id)
 {
-	return register_btf_kfunc_id_set(BPF_PROG_TYPE_KPROBE, &bpf_kprobe_multi_kfunc_set);
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
2.51.1.dirty


