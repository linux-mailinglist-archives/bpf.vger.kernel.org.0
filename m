Return-Path: <bpf+bounces-78466-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ADA6FD0D723
	for <lists+bpf@lfdr.de>; Sat, 10 Jan 2026 15:15:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 43B1E30550F6
	for <lists+bpf@lfdr.de>; Sat, 10 Jan 2026 14:12:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 669A93469FC;
	Sat, 10 Jan 2026 14:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EEPmuRAV"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f194.google.com (mail-pf1-f194.google.com [209.85.210.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF2D33446B9
	for <bpf@vger.kernel.org>; Sat, 10 Jan 2026 14:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768054335; cv=none; b=RBFGN76k0RY6dvVbVQV0qd6cm6N23Bi29XEV2FwJyK8AnsSR6ICazyNDM1aCkGgTmowpMUyPBaQ1ouXtBApl3b2T9Bn12DRRZyYF1Vkc1o+6fBjXl413gWAUx6IhQxsBsfUvmpWYDC1d4rDifOtKz4IHzHamwL/ewW/re5IUlFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768054335; c=relaxed/simple;
	bh=n/7k5mO/6SZ7HqVRB1N/I0OmYGbrp12aFWUTdPqo8s0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dQVphcYGkDklU/QHRM51zDb9yOB0r9RSNoI1O3nJ8sChy2kF6RUSePxjKhCXcFsHKWvkMLaTUlXWIluQzliZ6nnPf/6gm4shugQI2JIQuB9Llw8iNBajBYnmcmZY7w3PqqYUmxYYVHYtB+kXstM+fq1SJQPCDpITotG/VAFrYxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EEPmuRAV; arc=none smtp.client-ip=209.85.210.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f194.google.com with SMTP id d2e1a72fcca58-81e93c5961cso1071810b3a.0
        for <bpf@vger.kernel.org>; Sat, 10 Jan 2026 06:12:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768054333; x=1768659133; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+zpUBClHIGdPZIQ45WTEZS7Nhxwojh2mUAy6TAH9Jbw=;
        b=EEPmuRAVPBkkl34bfvurCb1Dfru1a8+WQsfpDTuoTxLwK9YhBkIKxGCq5KJ9iDPGyE
         f/diZaTZYPoQcF7l72iB0KWKfvk4w9XqWx0GOW+Bp+3E3vdDsWt1Pz8YYZuSgFCrorbT
         CeOJWWkCWfplsqzR7FpjbkJ7xozn/HgY6JzneeQaENbdp28TSetDw36u56jF7angTOop
         hiL0NcUPj9OmvoZyG6Ob7SEv+WPjXMKDTB3r+pVckzTkl1+5QqSlkjsXQCZ1HgTXwB+A
         Fx5UMmjbKUutaellgpOQKGDDTrvvdUQ4uaDhyZYEy7Cdzz0Ewrzkc7zBZcNBQhPZGoXh
         o6tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768054333; x=1768659133;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+zpUBClHIGdPZIQ45WTEZS7Nhxwojh2mUAy6TAH9Jbw=;
        b=em+Y++TX1iYdTLFeDVuJBMfEY/KA3mwl+aur8i7Ly63n471APYG+mAHpshJvs5irtA
         2qzWd9yJ25yw6ZNYcz1j/WfzqaR1iTbW58X6g4yDNSzLc2h0NYLWUfnqjfpDNauDC3K/
         1NstKpqiRR4ad6o1OvuUpPDL6uxabqX92OBU2siFrbXluKit6ikNExq4eYUUi43Cwzd5
         jevwZNpCkKAVf0uEwOFvP8TQTfp2bzBPw/Yrc3jz4sN+be47AP9iHVBXt4kj7/TPdJkX
         QS1ujPPq6s3q4Lrdm91ON/60ttrAN0Hc0mz0RsO9xiadbfDkELPhFnLmwsekGvmTihz0
         16mg==
X-Forwarded-Encrypted: i=1; AJvYcCUSpeGAdKgP8RL3bevhXrgu9UmfpAcfAgEL2Ratx/wNQ9pHLaTFfLPTbd8/WlG6zWhvLoM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLj4xMmwnfL2jIV3KIACTI/0dLvAMRBXEerCoZpv25x52m/Smc
	qHHalwC1NxoL1/A4uKIcsIR5Ph8CPwjjRNNRoDZS5q+SzCR9JqpN/3Qe
X-Gm-Gg: AY/fxX7B8doWit5bf98R14Rq5lKHRGQ++rit0z+r3TLcpRjcUGJIMdiuKKwqk+DDFy6
	1g7v40Srv6Vpn4gpoDVOa4TOJikvhmfQ8oxUMe89lO4X2Cn9i7BvprSMilfO7QyMObdFVZ2sp4c
	wVNHbC/Eh03nW04+AEQitaUesCZXm3919OSYnp9TEtzoZPxcHUmSbiRcFqye0oKfIgRq+4DYxag
	WCNVIfOZBFlRdAnEzz5o7oLsjmXJHodAT9dRtkQnG/baowBVatnCU3mtDrLliyWbyluH8o7EAbk
	cj1xVZnbSqrAnjouNpLGnJAQWDNhkR58qBW9D79t9v1UlTqIFf67zjP7Kg3+SzdncD+yh//rsLn
	uJ6j0/0a1XfrEgY63xw/fxLow8Eh4FtH/UmXGU0ABlLfAUgQx7KkiMRCoOJ7R/aWFBd1zvYcTCR
	i33yOQ5n4=
X-Google-Smtp-Source: AGHT+IG31oLOfstQo576BCLakdE0G7b1VJi9fSiQv5hvsVWJVmiQKV1SlMPR10Y/aPftZLJljsKelA==
X-Received: by 2002:a05:6a00:f94:b0:81e:f623:ba0c with SMTP id d2e1a72fcca58-81ef623bc8dmr3387614b3a.44.1768054333195;
        Sat, 10 Jan 2026 06:12:13 -0800 (PST)
Received: from 7950hx ([160.187.0.149])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-81f42658f03sm1481079b3a.20.2026.01.10.06.12.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Jan 2026 06:12:12 -0800 (PST)
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
Subject: [PATCH bpf-next v9 04/11] bpf: support fsession for bpf_session_is_return
Date: Sat, 10 Jan 2026 22:11:08 +0800
Message-ID: <20260110141115.537055-5-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260110141115.537055-1-dongml2@chinatelecom.cn>
References: <20260110141115.537055-1-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If fsession exists, we will use the bit (1 << BPF_TRAMP_M_IS_RETURN) in
ctx[-1] to store the "is_return" flag.

The logic of bpf_session_is_return() for fsession is implemented in the
verifier by inline following code:

  bool bpf_session_is_return(void *ctx)
  {
      return !!(((u64 *)ctx)[-1] & (1 << BPF_TRAMP_M_IS_RETURN));
  }

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
Co-developed-by: Leon Hwang <leon.hwang@linux.dev>
Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
v9:
- remove the definition of bpf_fsession_is_return()

v7:
- reuse the kfunc bpf_session_is_return() instead of introduce new kfunc

v4:
- split out the bpf_fsession_cookie() to another patch

v3:
- merge the bpf_tracing_is_exit and bpf_fsession_cookie into a single
  patch

v2:
- store the session flags after return value, instead of before nr_args
- inline the bpf_tracing_is_exit, as Jiri suggested
---
 include/linux/bpf.h      |  3 +++
 kernel/bpf/verifier.c    | 15 ++++++++++++++-
 kernel/trace/bpf_trace.c | 28 +++++++++++++++++-----------
 3 files changed, 34 insertions(+), 12 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 41228b0add52..2640ec2157e1 100644
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
index bfff3f84fd91..1b0292a03186 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -12374,6 +12374,7 @@ enum special_kfunc_type {
 	KF_bpf_arena_alloc_pages,
 	KF_bpf_arena_free_pages,
 	KF_bpf_arena_reserve_pages,
+	KF_bpf_session_is_return,
 };
 
 BTF_ID_LIST(special_kfunc_list)
@@ -12451,6 +12452,7 @@ BTF_ID(func, bpf_task_work_schedule_resume_impl)
 BTF_ID(func, bpf_arena_alloc_pages)
 BTF_ID(func, bpf_arena_free_pages)
 BTF_ID(func, bpf_arena_reserve_pages)
+BTF_ID(func, bpf_session_is_return)
 
 static bool is_task_work_add_kfunc(u32 func_id)
 {
@@ -12505,7 +12507,8 @@ get_kfunc_ptr_arg_type(struct bpf_verifier_env *env,
 	struct bpf_reg_state *reg = &regs[regno];
 	bool arg_mem_size = false;
 
-	if (meta->func_id == special_kfunc_list[KF_bpf_cast_to_kern_ctx])
+	if (meta->func_id == special_kfunc_list[KF_bpf_cast_to_kern_ctx] ||
+	    meta->func_id == special_kfunc_list[KF_bpf_session_is_return])
 		return KF_ARG_PTR_TO_CTX;
 
 	if (argno + 1 < nargs &&
@@ -22558,6 +22561,16 @@ static int fixup_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 		   desc->func_id == special_kfunc_list[KF_bpf_rdonly_cast]) {
 		insn_buf[0] = BPF_MOV64_REG(BPF_REG_0, BPF_REG_1);
 		*cnt = 1;
+	} else if (desc->func_id == special_kfunc_list[KF_bpf_session_is_return] &&
+		   env->prog->expected_attach_type == BPF_TRACE_FSESSION) {
+		/* implement and inline the bpf_session_is_return() for
+		 * fsession, and the logic is:
+		 *   return !!(((u64 *)ctx)[-1] & (1 << BPF_TRAMP_M_IS_RETURN))
+		 */
+		insn_buf[0] = BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_1, -8);
+		insn_buf[1] = BPF_ALU64_IMM(BPF_RSH, BPF_REG_0, BPF_TRAMP_M_IS_RETURN);
+		insn_buf[2] = BPF_ALU64_IMM(BPF_AND, BPF_REG_0, 1);
+		*cnt = 3;
 	}
 
 	if (env->insn_aux_data[insn_idx].arg_prog) {
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 297dcafb2c55..1fe508d451b7 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -3334,34 +3334,40 @@ __bpf_kfunc __u64 *bpf_session_cookie(void *ctx)
 
 __bpf_kfunc_end_defs();
 
-BTF_KFUNCS_START(kprobe_multi_kfunc_set_ids)
+BTF_KFUNCS_START(session_kfunc_set_ids)
 BTF_ID_FLAGS(func, bpf_session_is_return)
 BTF_ID_FLAGS(func, bpf_session_cookie)
-BTF_KFUNCS_END(kprobe_multi_kfunc_set_ids)
+BTF_KFUNCS_END(session_kfunc_set_ids)
 
-static int bpf_kprobe_multi_filter(const struct bpf_prog *prog, u32 kfunc_id)
+static int bpf_session_filter(const struct bpf_prog *prog, u32 kfunc_id)
 {
-	if (!btf_id_set8_contains(&kprobe_multi_kfunc_set_ids, kfunc_id))
+	if (!btf_id_set8_contains(&session_kfunc_set_ids, kfunc_id))
 		return 0;
 
-	if (!is_kprobe_session(prog) && !is_uprobe_session(prog))
+	if (!is_kprobe_session(prog) && !is_uprobe_session(prog) &&
+	    prog->expected_attach_type != BPF_TRACE_FSESSION)
 		return -EACCES;
 
 	return 0;
 }
 
-static const struct btf_kfunc_id_set bpf_kprobe_multi_kfunc_set = {
+static const struct btf_kfunc_id_set bpf_session_kfunc_set = {
 	.owner = THIS_MODULE,
-	.set = &kprobe_multi_kfunc_set_ids,
-	.filter = bpf_kprobe_multi_filter,
+	.set = &session_kfunc_set_ids,
+	.filter = bpf_session_filter,
 };
 
-static int __init bpf_kprobe_multi_kfuncs_init(void)
+static int __init bpf_trace_kfuncs_init(void)
 {
-	return register_btf_kfunc_id_set(BPF_PROG_TYPE_KPROBE, &bpf_kprobe_multi_kfunc_set);
+	int err = 0;
+
+	err = err ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_KPROBE, &bpf_session_kfunc_set);
+	err = err ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_TRACING, &bpf_session_kfunc_set);
+
+	return err;
 }
 
-late_initcall(bpf_kprobe_multi_kfuncs_init);
+late_initcall(bpf_trace_kfuncs_init);
 
 typedef int (*copy_fn_t)(void *dst, const void *src, u32 size, struct task_struct *tsk);
 
-- 
2.52.0


