Return-Path: <bpf+bounces-71279-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D8B5BED13E
	for <lists+bpf@lfdr.de>; Sat, 18 Oct 2025 16:22:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A6A8719A3325
	for <lists+bpf@lfdr.de>; Sat, 18 Oct 2025 14:22:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BC222D8370;
	Sat, 18 Oct 2025 14:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hhk061bR"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f193.google.com (mail-pf1-f193.google.com [209.85.210.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6092C2D6E73
	for <bpf@vger.kernel.org>; Sat, 18 Oct 2025 14:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760797311; cv=none; b=bv7cHUTrX0AORuCoFmywY5PR71+u5GHKrG7quH53OrmT7MGIqKr42P52peJRnaGvnTMOq3bUc3zKPU+VjkA3FVUaDnDaxaft5v5phbMbMmGGuxlwZWKFAdvLidVFagvTMi5TrHTNHEiYcL0KNLHWeVjEw2oG1Rkoahu9aCDJW5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760797311; c=relaxed/simple;
	bh=c99jLCl4oK0lYbHL6l7ZVaK/eHqsZKgxrs6O+Xjt2Ro=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YIZVbffdCjnv/TIgTxjzJyvTwxnNB7c08GQogXKLCO4b1w4J2Jgb8NLjy8jqqcA1GTzvzTudF0FMMZIFtCnyN/rRaHau7Q66q3++09rG7qPazzv9d5MMuF74x709PR0KwXphhsW2nRr07c/qjALvimSq7ztdbsauvk+7RQ9maU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hhk061bR; arc=none smtp.client-ip=209.85.210.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f193.google.com with SMTP id d2e1a72fcca58-78af743c232so2503550b3a.1
        for <bpf@vger.kernel.org>; Sat, 18 Oct 2025 07:21:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760797310; x=1761402110; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NYwvvMkNsizkLkVR3lZyOmzWt267ljepeEAqISwgDss=;
        b=hhk061bR+uw2b/fjfGSSxs2NgEfBA3i/2BjMPWD4K4YGGrDtKRipuD+F2mS58iT5PO
         sufWTv1GBXwxjahpsL/1Ut3FsgiQ34iTfXQ3ZUaD8tbarSZ9j/wt3I18xA4VJ+OcFE3z
         woBY9UxLzJPQLp9vxh6oWS4YCZ4WG7eZTj93Cd/TiaaiY7BolYpBxliIXOP8shWny1yE
         wJwJVxxdIFV5+dSCK/YZAGZtUBTSluj89gW0u3qFTSF0goxkdrQzEctBFQ9k47zC7/E8
         E4I2esZ8dLyYtq9c9H8Q3qGmkfnMeJa2fMqz2vJl8TW5ek22Y9r/taZyrWrkQFRMgaJe
         4CQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760797310; x=1761402110;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NYwvvMkNsizkLkVR3lZyOmzWt267ljepeEAqISwgDss=;
        b=BOopo7rvTvNpgocj16d7Haivcu7ha5nr9FECbuGxnW9LZ603D5pH2gKjj+zUE9Ovrw
         X3kKHATSFUcYdvAIT1AFyx61VKikscMoATt/VROQJyVJT/Wpz1tMAf+KspOTU3ChRcCU
         IjFtJLaqeOgbF0HBphYvMhZojSYX72oN8gRFHgztP1P9EUiM/wx7mL5wD2fU/mG6MGDJ
         fc30pahECmVAtN3W8QUAkKUARiMO0i6mtGa1dKdyIK7zvnnBzwc8ZI9ZJRXCVHBcCxhD
         pAtMKmoXA0LkydRLjD4z3wziC+DKU2K0KeFji23Is3w9i1SlOEhwMH4FDMpW3vjBkVsx
         BMeQ==
X-Forwarded-Encrypted: i=1; AJvYcCWIQ8reDnL6l2NJcTPaPh02P5mx2TLV/MwDHXLpjX2hy6vMskcY1ADp2UWQ82/eWWGJzq8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmgfIKxwYKszDFAS/vRU1Xxd11RvuY7xYQiUL3+3MWRFyInrNV
	RRVUeTXC0g6ActoQG+kxUUVG1go3ZwELScpIyfnFprLECxCn1ErET8ts
X-Gm-Gg: ASbGncujf1ERhbXKvtUztyMRfV2vbf8nvilBl/ZAmTg9fvsHoVZ/BuHUAAT+YkqwkZV
	3sKkMz423Q5jI42x3yYDpIcYwg3XZoj1qhej3/3/jBeyUTCxo4au7oPQnbvhuVrvqveLzFjMRMN
	DWoaAoPRfhWRUS4AjM3y/vtU10cOwLzd0Jr2AxFAL0RHN7N+RZ9oYicK/RKWGTyaiozQCr3Jze9
	9bcUdsywtkNNUCkn7JBNYSIonYFq32EI4JKrrmKdXZqZ8kuSguEnIyPEQ7Y+qjr4MCun9Eitys9
	pMfFRBg2H/DluGysugJ5OPdOEu44LP+BUyzwCitOgBzFKnidErlv6hZBeixmEHOfe8o8/FyCg9N
	T2On9rolZKXCELPzAihnSqYDTv9rC6svY4xP/OaQcu9MB6TQ9357l0CjIvCCA8/BFTTubZs+5da
	DS+16y/ML5Epg=
X-Google-Smtp-Source: AGHT+IE88gDZ5ZuEI9rRpvXV/ekTZy+PSm2f/QXfC+JY64iWLG600+Hr2zdXGf21CmwOwy+JFCe24w==
X-Received: by 2002:a05:6a00:2e99:b0:781:c54:4d24 with SMTP id d2e1a72fcca58-7a220ab6c7bmr7997114b3a.21.1760797309777;
        Sat, 18 Oct 2025 07:21:49 -0700 (PDT)
Received: from 7950hx ([43.129.244.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a23010d818sm2913589b3a.53.2025.10.18.07.21.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Oct 2025 07:21:49 -0700 (PDT)
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
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH RFC bpf-next 2/5] bpf: add kfunc bpf_tracing_is_exit for TRACE_SESSION
Date: Sat, 18 Oct 2025 22:21:21 +0800
Message-ID: <20251018142124.783206-3-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251018142124.783206-1-dongml2@chinatelecom.cn>
References: <20251018142124.783206-1-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If TRACE_SESSION exists, we will use extra 8-bytes in the stack of the
trampoline to store the flags that we needed, and the 8-bytes lie before
the function argument count, which means ctx[-2]. And we will store the
flag "is_exit" to the first bit of it.

Introduce the kfunc bpf_tracing_is_exit(), which is used to tell if it
is fexit currently.

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
Co-developed-by: Leon Hwang <leon.hwang@linux.dev>
Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 kernel/bpf/verifier.c    |  5 ++++-
 kernel/trace/bpf_trace.c | 43 +++++++++++++++++++++++++++++++++++++---
 2 files changed, 44 insertions(+), 4 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 40e3274e8bc2..a1db11818d01 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -12284,6 +12284,7 @@ enum special_kfunc_type {
 	KF___bpf_trap,
 	KF_bpf_task_work_schedule_signal,
 	KF_bpf_task_work_schedule_resume,
+	KF_bpf_tracing_is_exit,
 };
 
 BTF_ID_LIST(special_kfunc_list)
@@ -12356,6 +12357,7 @@ BTF_ID(func, bpf_res_spin_unlock_irqrestore)
 BTF_ID(func, __bpf_trap)
 BTF_ID(func, bpf_task_work_schedule_signal)
 BTF_ID(func, bpf_task_work_schedule_resume)
+BTF_ID(func, bpf_tracing_is_exit)
 
 static bool is_task_work_add_kfunc(u32 func_id)
 {
@@ -12410,7 +12412,8 @@ get_kfunc_ptr_arg_type(struct bpf_verifier_env *env,
 	struct bpf_reg_state *reg = &regs[regno];
 	bool arg_mem_size = false;
 
-	if (meta->func_id == special_kfunc_list[KF_bpf_cast_to_kern_ctx])
+	if (meta->func_id == special_kfunc_list[KF_bpf_cast_to_kern_ctx] ||
+	    meta->func_id == special_kfunc_list[KF_bpf_tracing_is_exit])
 		return KF_ARG_PTR_TO_CTX;
 
 	/* In this function, we verify the kfunc's BTF as per the argument type,
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 4f87c16d915a..6dde48b9d27f 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -3356,12 +3356,49 @@ static const struct btf_kfunc_id_set bpf_kprobe_multi_kfunc_set = {
 	.filter = bpf_kprobe_multi_filter,
 };
 
-static int __init bpf_kprobe_multi_kfuncs_init(void)
+__bpf_kfunc_start_defs();
+
+__bpf_kfunc bool bpf_tracing_is_exit(void *ctx)
+{
+	/* ctx[-2] is the session flags, and the last bit is is_exit */
+	return ((u64 *)ctx)[-2] & 1;
+}
+
+__bpf_kfunc_end_defs();
+
+BTF_KFUNCS_START(tracing_kfunc_set_ids)
+BTF_ID_FLAGS(func, bpf_tracing_is_exit)
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
 {
-	return register_btf_kfunc_id_set(BPF_PROG_TYPE_KPROBE, &bpf_kprobe_multi_kfunc_set);
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
2.51.0


