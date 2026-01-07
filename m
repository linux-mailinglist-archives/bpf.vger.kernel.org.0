Return-Path: <bpf+bounces-78052-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B9C74CFC38D
	for <lists+bpf@lfdr.de>; Wed, 07 Jan 2026 07:47:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D5EA430402F9
	for <lists+bpf@lfdr.de>; Wed,  7 Jan 2026 06:45:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04B3D27FB1F;
	Wed,  7 Jan 2026 06:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cCaSXTbi"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f196.google.com (mail-yw1-f196.google.com [209.85.128.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C268D2765F8
	for <bpf@vger.kernel.org>; Wed,  7 Jan 2026 06:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767768292; cv=none; b=ta+R94lQ+Ovt5ncWjCPs0znYFg2qHn/YrPk7MKlimHXRSVAsSLj67fJMSmQZ3ap6gXB05FqoOdVfUOSEE97H5249jl6ydq03WsqmjcCDgRNCzkRg+VbnKUepaZh2eIj4m9FrCGVb2LIyKQkCRiWTPxdTqBThr2pjFYC2ZBIvaew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767768292; c=relaxed/simple;
	bh=jqWo2iK6Bxy2tyLgV8IzI19MROh4tzgsyjro5ifP6hA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q2jw1Y7KpRvRXUVWnjz9zh4LAapJO68ut6o+aaPuzI7FxGfPQi3vVm+/O42hm+kkSDSKthoohWXthaNMvHClyDbjx8qCQQSwnJZ9V9PGX9DykPeukzLttz3yi2zHt4wetvglyVINiexQKg06oRBxouWMV189uqhYCTWF/J/8LLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cCaSXTbi; arc=none smtp.client-ip=209.85.128.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f196.google.com with SMTP id 00721157ae682-790b7b3e581so4090397b3.0
        for <bpf@vger.kernel.org>; Tue, 06 Jan 2026 22:44:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767768290; x=1768373090; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i2bmJ4tSsifyy+WKp7NzscgvS8nGcfZbaX18GsTRYNs=;
        b=cCaSXTbi0Y24ESkbvlGEmnCrs5VF19WE0BMDpI2Zvj2QSkMVDAufZ+1shW26ij/pko
         7aoeWArjnIoo0mvUQRj24RcYB4Aotw9KgzXb4MFtmAYnaGuOjEVAweQYoLaROErKmwJJ
         Czv3xFM4yyShhPQc/e0qv7BzsCHqjflN89pilplL7pBS2titd0CvhCV5PQWqAfeBFDsZ
         p/9yG67F0J0RLNHk7hnorsR5f8NC5rf3gwbE1x2qnEZYRGW3DxwnO6kT2eHdDEmAyUhR
         JiZhLqFtFlucy2U0Np57HQ+Z+m56N+dbmwo5+cOZv27/n4E2LMzDcWMBI5juea6zLNVL
         KohQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767768290; x=1768373090;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=i2bmJ4tSsifyy+WKp7NzscgvS8nGcfZbaX18GsTRYNs=;
        b=WW6WBAN9Hn+BRf2fbGWL6ajr8/+iXlKDEbD3jwg8ywpPPnRW/Sj7x4wmAERUxH/x/k
         p3OSCDfqaq8WsayufPs4OGVAFu9qti2vkXuZFBs8TwQmbmyPvS/Slm3V1IdCvpgPM8jO
         7A4g95Sa2afuuRq+gfmYZ7gPYMyuVGNOxKAhJGqZSYFn4KmlXkSRk99ATga6QJ40BNfs
         +tVVgi6vmsN/l7FOLoglRB1EwkWuvjxY2iWWxVMYrergUrQnnS0jsF5vk1g7GuRbHJrp
         BAHpn59yzcfwlOTuEr6wW1ZpGAQ0d1qP+DxYob0y+lxAncf3Z/mREV+lXB5xEyiP9ukR
         3ZHQ==
X-Forwarded-Encrypted: i=1; AJvYcCVk0IqCP6pq/BSLSmO0JmlNAEAeREvqMzm1Ryy/w6pJ4B7LU0Qp5ig3zeFa42gXoPqsIZU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwStXw5+5IO1GhNZYk+YdvnKjgknPFD8HnQj+MsHx2J68rumMTe
	87BxmG4CN1wseLHLEPk8WJxJJUrn4GP+CXYnb8V46xi3664PSJYPd0YY
X-Gm-Gg: AY/fxX4BOGTjDZIC5zFO3ckRgLjQ0ee3o9X3QKo8V2MCyH82YPsZHjfh5aRkfP87omy
	chA1UPoL9GYsITIyxZN1+pfvJpa/d6BhVkrPp58DblcGqwxDdcOVAuKvPwgj/gQasofoQknPP7N
	IFnhhcPQVoDw4HnlyFYYi7hfqgTxxEp8FKkZEecANAHzw7hsWensmSe/TB5VLdmLk+H01Fx5RTW
	nHxxqlr5Q+SCUh0DOfae/G6IiO5OBqrcbHSBz3Ft7eKa1tTe7+YX5RC6kCOVy9OVXGLguw42Cfo
	W5YLwbiU+iWG5C70fhX6Aiu9A7W57J9aczsYBUJBOuHAvuyvr+YOZLtKtR2iGVN5bFTylkYqthR
	7Cq2Ck9B4r1BvP1JEFiZ+naXbLmc/TQkucDJtYhDsGCpEyeogZHN5/Cw+tSSeiDr38SGB+H5G7b
	7kMGOQqIM=
X-Google-Smtp-Source: AGHT+IEddj/82P4jjOenNTBnyv2Kpfd/suxVKnzAfhNinhSbMX/D6nhziugwcjp5lpYhZqwvppV+9w==
X-Received: by 2002:a05:690c:c85:b0:786:87b1:9635 with SMTP id 00721157ae682-790b57588e4mr15407607b3.9.1767768289694;
        Tue, 06 Jan 2026 22:44:49 -0800 (PST)
Received: from 7940hx ([23.94.188.235])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-790b1be88dcsm9635047b3.47.2026.01.06.22.44.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jan 2026 22:44:49 -0800 (PST)
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
Subject: [PATCH bpf-next v7 04/11] bpf: support fsession for bpf_session_is_return
Date: Wed,  7 Jan 2026 14:43:45 +0800
Message-ID: <20260107064352.291069-5-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260107064352.291069-1-dongml2@chinatelecom.cn>
References: <20260107064352.291069-1-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If fsession exists, we will use the bit (1 << BPF_TRAMP_M_IS_RETURN) in
ctx[-1] to store the "is_return" flag.

Introduce the function bpf_fsession_is_return(), which is used to tell if
it is fexit currently. Meanwhile, inline it in the verifier. The calling
to bpf_session_is_return() will be changed to bpf_fsession_is_return() in
verifier for fsession.

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
Co-developed-by: Leon Hwang <leon.hwang@linux.dev>
Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
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
 include/linux/bpf.h      |  5 +++++
 kernel/bpf/verifier.c    | 15 ++++++++++++++-
 kernel/trace/bpf_trace.c | 34 +++++++++++++++++++++++-----------
 3 files changed, 42 insertions(+), 12 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 565ca7052518..d996dd390681 100644
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
@@ -3945,4 +3948,6 @@ static inline int bpf_map_check_op_flags(struct bpf_map *map, u64 flags, u64 all
 	return 0;
 }
 
+bool bpf_fsession_is_return(void *ctx);
+
 #endif /* _LINUX_BPF_H */
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index bfff3f84fd91..d3709edd0e51 100644
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
@@ -22440,6 +22443,9 @@ static int specialize_kfunc(struct bpf_verifier_env *env, struct bpf_kfunc_desc
 	} else if (func_id == special_kfunc_list[KF_bpf_arena_free_pages]) {
 		if (env->insn_aux_data[insn_idx].non_sleepable)
 			addr = (unsigned long)bpf_arena_free_pages_non_sleepable;
+	} else if (func_id == special_kfunc_list[KF_bpf_session_is_return]) {
+		if (prog->expected_attach_type == BPF_TRACE_FSESSION)
+			addr = (unsigned long)bpf_fsession_is_return;
 	}
 	desc->addr = addr;
 	return 0;
@@ -22558,6 +22564,13 @@ static int fixup_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 		   desc->func_id == special_kfunc_list[KF_bpf_rdonly_cast]) {
 		insn_buf[0] = BPF_MOV64_REG(BPF_REG_0, BPF_REG_1);
 		*cnt = 1;
+	} else if (desc->func_id == special_kfunc_list[KF_bpf_session_is_return] &&
+		   env->prog->expected_attach_type == BPF_TRACE_FSESSION) {
+		/* Load nr_args from ctx - 8 */
+		insn_buf[0] = BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_1, -8);
+		insn_buf[1] = BPF_ALU64_IMM(BPF_RSH, BPF_REG_0, BPF_TRAMP_M_IS_RETURN);
+		insn_buf[2] = BPF_ALU64_IMM(BPF_AND, BPF_REG_0, 1);
+		*cnt = 3;
 	}
 
 	if (env->insn_aux_data[insn_idx].arg_prog) {
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 736b32cf2195..9d3bf3bbe8f6 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -3314,6 +3314,12 @@ static u64 bpf_uprobe_multi_entry_ip(struct bpf_run_ctx *ctx)
 }
 #endif /* CONFIG_UPROBES */
 
+bool bpf_fsession_is_return(void *ctx)
+{
+	/* This helper call is inlined by verifier. */
+	return !!(((u64 *)ctx)[-1] & (1 << BPF_TRAMP_M_IS_RETURN));
+}
+
 __bpf_kfunc_start_defs();
 
 __bpf_kfunc bool bpf_session_is_return(void *ctx)
@@ -3334,34 +3340,40 @@ __bpf_kfunc __u64 *bpf_session_cookie(void *ctx)
 
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


