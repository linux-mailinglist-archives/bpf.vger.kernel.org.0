Return-Path: <bpf+bounces-76848-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B49F8CC6E74
	for <lists+bpf@lfdr.de>; Wed, 17 Dec 2025 10:56:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5D4DF3058C28
	for <lists+bpf@lfdr.de>; Wed, 17 Dec 2025 09:55:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B443A314D34;
	Wed, 17 Dec 2025 09:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WPrvMR0I"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f193.google.com (mail-pl1-f193.google.com [209.85.214.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F27723164D6
	for <bpf@vger.kernel.org>; Wed, 17 Dec 2025 09:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765965316; cv=none; b=MMu3NArPEFGjWRAKZFTrnQQPiY8Q2ScIh1zreayqE/Yv7JnjrnWNt/wQH5ER7aCVfk0j3KpkjM5qj6XaYGJ7fVQRtsS8s5LqvhzmxeoehXwZne1gS5uVyBWtsoaSR1gJODykC1m/1lTbUWHgvXW2SSsXpL2bfV1W8/qpKUVcMp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765965316; c=relaxed/simple;
	bh=tymsptnwVqCK+EBcdpyIreeoqu6nppQzBwVci64fanM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qBKQKn+pAmdMBShcAm9Kd6iU5YH0lzr8h/md6pVQu1pVcM45UYBuhN/WpFlda2wI2iiG/a7zq1ROBvlfyIpIf8zz+4GTsBgYNOIxcVo1O6cHy6eiZjeW+DWt5cl4mHoIQAVe2PZI3PAJH8vVhHgFsdnnCpqhn43MjHeFhnnx0hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WPrvMR0I; arc=none smtp.client-ip=209.85.214.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f193.google.com with SMTP id d9443c01a7336-2a0f3f74587so38538495ad.2
        for <bpf@vger.kernel.org>; Wed, 17 Dec 2025 01:55:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765965314; x=1766570114; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t1qS6JRi8qK9u0+Jx90T9d6NveMH/Z/F2BRN/sKRPm4=;
        b=WPrvMR0I68AEa51oy93aa2+sPcido7jFbtaW2cqw4E/iI8fO994r61dRKuNQb6ACJY
         Os0SsHO+NtT1/w6RQggCcTpICkIyGXpwCx5LLjruEk/phWyi0J0goNIq+38Fs6XYnIkB
         SaWg6JMMGi5/fQCu3JwleGVU5FY4AhZAmdS6WsEYk2hbnIM17U4nBMKZGaaRGOof2aJw
         3zQKFaZvSo/1LFXGe9vit5i/RheUV31zU4663TVfP9CyivXyCvaGJ+hUYXVIDJ/m8ct9
         nWe7xpdFmARaMKzCtPwNj7Bdsp07hEDIkPtwAroUGVai6Ag1poNTHykp9EQ85eV4YTG0
         gH0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765965314; x=1766570114;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=t1qS6JRi8qK9u0+Jx90T9d6NveMH/Z/F2BRN/sKRPm4=;
        b=lt47JLfujENqS4rCjdQHAvzAY7ghM/PYXvJSg9AJeflJ0UW1+dbRYKuGTD5PxjGeHE
         kcnWnd3yA4r0nDIyrpHaXRy0QNbT+brDWkPaPAa7RKZSXnnWuJwafa0rbWypqXHTNGBZ
         eidlwaJIpFynGiCPzrEosAsSEInlhAHnIr4kAKzm+PMVAC3CNcvl4bz1QWbi4RQoP1EJ
         lryPoKqJSciBGQGENCp1k+f+P1oI9fpyQJO5XfrhLghPm1kU6UUQ8Qv01Kbl9XhcyoK6
         QtXMLXljAvmXVYu4Yqk6otNtJRb4bQ8WlF5MFjKQMQhlyGYj/ds/yw9SZBt54Hl81lga
         2B5A==
X-Forwarded-Encrypted: i=1; AJvYcCUncoNkoR1HPTYO6wqeyDPu1RPvLb0nytpdSyODfiIiEObcYj2M72H0+ASRT9vMGYgzxEI=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywb1qAuSxCxu/RnsBSSdpcfVWuAuW68nwEsOT1j2gbT1Vqjm4Vf
	sdI0K/9r67H48nwO7KFDY3xy5QKTZz/J/tImJ5n32AgKp4nCNdyD5N+v
X-Gm-Gg: AY/fxX5hokEJzIERtl7BBM+zw/ioHn4WPeG2K5Et3bly4ZfcIUr+2CkB9CVeWtqtJn9
	sHIk6WeUbqdROmPeYav/3ETErAiwdBYTwEl7WXN0SrENCB6Olhmf6gtSxnOglfTPJ5IYC5WDZxH
	0sTekApczMS2Or1AQEegwe49fDMXI/ZE5Vdv91a318v9nJ/aSv0uQGE3nyJLmt6zSlGWe704uGC
	lPUK8Dq0I7scUARM6YywSG1PGV5ACi2F5RWTwxMNY0GrUlvdpkE6NK/3Sn92+ez1u091uf3UE8z
	rSZ34hgdgN1t+encocmDIraNGRHIi7Qa+rsQ8kvBugAg4c7wLsyg57eYpEl/FBoVkGP3mcU7+5v
	C3xQiCjBNq4Jg8fNmJcBJS70H4Xr9F9yxM2SBTxdPHRF8hLd377XFWPwq63TZyDKbIv8aAnSk0D
	OfhkdPmJ4=
X-Google-Smtp-Source: AGHT+IEQq8TrbeOE2cQX+Q7hC7HE5fCgUKQ6Wa4zFxEAUFXrwzzRHEwSxyNL7jLjUfh2XRbWv8c0bw==
X-Received: by 2002:a17:902:e750:b0:2a0:f488:253 with SMTP id d9443c01a7336-2a0f4880376mr115598385ad.52.1765965314206;
        Wed, 17 Dec 2025 01:55:14 -0800 (PST)
Received: from 7940hx ([43.129.244.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a07fa0b1aasm140715945ad.3.2025.12.17.01.55.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Dec 2025 01:55:13 -0800 (PST)
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
Subject: [PATCH bpf-next v4 3/9] bpf: add the kfunc bpf_fsession_is_return
Date: Wed, 17 Dec 2025 17:54:39 +0800
Message-ID: <20251217095445.218428-4-dongml2@chinatelecom.cn>
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

If TRACE_SESSION exists, we will use the bit (1 << BPF_TRAMP_M_IS_RETURN)
in ctx[-1] to store the "is_return" flag.

Introduce the kfunc bpf_fsession_is_return(), which is used to tell if it
is fexit currently. Meanwhile, inline it in the verifier.

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
Co-developed-by: Leon Hwang <leon.hwang@linux.dev>
Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
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
 kernel/bpf/verifier.c    | 11 +++++++++-
 kernel/trace/bpf_trace.c | 43 +++++++++++++++++++++++++++++++++++++---
 3 files changed, 53 insertions(+), 4 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 3b2273b110b8..d165ace5cc9b 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1213,6 +1213,9 @@ enum {
 #endif
 };
 
+#define BPF_TRAMP_M_NR_ARGS	0
+#define BPF_TRAMP_M_IS_RETURN	8
+
 struct bpf_tramp_links {
 	struct bpf_tramp_link *links[BPF_MAX_TRAMP_LINKS];
 	int nr_links;
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 96753833c090..b0dcd715150f 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -12380,6 +12380,7 @@ enum special_kfunc_type {
 	KF___bpf_trap,
 	KF_bpf_task_work_schedule_signal_impl,
 	KF_bpf_task_work_schedule_resume_impl,
+	KF_bpf_fsession_is_return,
 };
 
 BTF_ID_LIST(special_kfunc_list)
@@ -12454,6 +12455,7 @@ BTF_ID(func, bpf_dynptr_file_discard)
 BTF_ID(func, __bpf_trap)
 BTF_ID(func, bpf_task_work_schedule_signal_impl)
 BTF_ID(func, bpf_task_work_schedule_resume_impl)
+BTF_ID(func, bpf_fsession_is_return)
 
 static bool is_task_work_add_kfunc(u32 func_id)
 {
@@ -12508,7 +12510,8 @@ get_kfunc_ptr_arg_type(struct bpf_verifier_env *env,
 	struct bpf_reg_state *reg = &regs[regno];
 	bool arg_mem_size = false;
 
-	if (meta->func_id == special_kfunc_list[KF_bpf_cast_to_kern_ctx])
+	if (meta->func_id == special_kfunc_list[KF_bpf_cast_to_kern_ctx] ||
+	    meta->func_id == special_kfunc_list[KF_bpf_fsession_is_return])
 		return KF_ARG_PTR_TO_CTX;
 
 	/* In this function, we verify the kfunc's BTF as per the argument type,
@@ -22556,6 +22559,12 @@ static int fixup_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
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
index 10c9992d2745..0857d77eb34c 100644
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
2.52.0


