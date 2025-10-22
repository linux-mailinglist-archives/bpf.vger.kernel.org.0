Return-Path: <bpf+bounces-71686-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DF24BFAC27
	for <lists+bpf@lfdr.de>; Wed, 22 Oct 2025 10:04:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4368A5069AB
	for <lists+bpf@lfdr.de>; Wed, 22 Oct 2025 08:03:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AE6D30102A;
	Wed, 22 Oct 2025 08:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zt08qrWC"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f195.google.com (mail-pl1-f195.google.com [209.85.214.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ACEC301027
	for <bpf@vger.kernel.org>; Wed, 22 Oct 2025 08:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761120150; cv=none; b=HFts8qLtnwGgFwa2Kq9/B8n4K2r1ByYhDghDXYW0yBTLAhQ6gcZJSdF/PuyEmoUIex/ESHFLgxKvF1NiyYJ5XCV/BBH+aDpYiPyIQTLXEYf3m5BoXpCpj3hLGqY/Yjb7QqxRg4nCROjjqHKRNRTf+9AqsUthoijMRzFcbkTRpOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761120150; c=relaxed/simple;
	bh=E3vAsVhEKLpEuWi7Z5YqNSEtnj0vJWvd3Pb3WZ9xabM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NiLdAUdn0SsgwovnzmMtqb9cGI0BREt5q5T7/oeQ5svRjHaO4XBuXoIT20IbTloctsSwzSREhaCNo1DgQJeABK1qqpVAACN/1k5wdiN0GC9hOZMlFZvSlbM1BUBdkh0k6AEhe8+fUQc4JrN91jGMmq7WfXvpDWgqtmSZveDO15s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zt08qrWC; arc=none smtp.client-ip=209.85.214.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f195.google.com with SMTP id d9443c01a7336-28e7cd6dbc0so82697305ad.0
        for <bpf@vger.kernel.org>; Wed, 22 Oct 2025 01:02:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761120146; x=1761724946; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ylOZLeoyykhuoaz4lbTwEjPsmcSXlb4GkDnmde4T+hQ=;
        b=Zt08qrWCatcHaC9a5Bj26UDTgjcTHU0Rh/n4rmrjCkYK7ps6oBB25BHd2rrBT6KAIF
         QiaoRiCc3+ofgkIVcS7HaCTPGmwI2iMtDFwyK08eWe4s7bMq39x52+qafApj/iRP+93R
         h76W64bXTKptvv6tvpCV+msjPbXHppnoCKNanpx2mkN77CSnu5ufaz4O2uE0rayIMhYj
         N0UZDneEdxBReI1QjPvMgep0k2MSOp0EbfKwbLI+8nvwCuBuh49eiCw0RsDePphLifrq
         WUpeKRhKHf1nFBAFQDlElDeyeCaPZCVAdBVkyS41fg6pEQEaavyprJZcUl9mXkE2UKnv
         naJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761120146; x=1761724946;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ylOZLeoyykhuoaz4lbTwEjPsmcSXlb4GkDnmde4T+hQ=;
        b=UAjevVnw+3dgZ8rXw+enzB/3H1/sDiDXh0k/sKJQ24qTBBhFE/7ti59onSaddfpBjs
         0RkHR84aIjTpVXYfB2sPxD8Djy+A8cJ4BJ3WHlW52lNAWnViNQKmMqAl53tmdVxS6Q/a
         zLUsRo8vHJ2CSHJZs3RM6L0Q5gKK/rCOS70MwEt3rPg17WGGNdSDZWuwq+b6OaRE07MO
         4ydjRAJPV5lCZDvhb7G3Wwg0XsDDWvBi8ilwPyREsVL11bdWQTOLRe6tJA0nHXG4vYR7
         8pAs37zYUxSMZqrh0+EXUymTGzlQPaSTfkWku1YWQxJW+r4XfPlGOd9/QSc8TziS1+sx
         E2vA==
X-Forwarded-Encrypted: i=1; AJvYcCV+P7bNOyIs3zkIj047/6Vo89sxbV7ndXWJqQhscFYYjHWd/rUQnQJMVsg82fjHScjwk8g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTGSh/7Bu/KQPoYadphJ3oGM8nA4+nEM9+Gn+UxEU8k4KxJ1gq
	U8r75kXWA9E6Bep8u4fRtG8IuwxIDsYjzwAi60UJ6vgkzKY2Ao7aANxj
X-Gm-Gg: ASbGncu/fWKAa/IFRVpXqLjMSgvVlv2Ozgso183FwWycZDhffI8tSigM9CWxedieD98
	x8fK6A5Zldap6AEdfOc/x841oV7MGTRj+THpcANaRR2t2xNqx8QlSJFdr8VUWUXvSaiuSW49aNO
	e9tQeBMeSKENMN0ppfzRN09fRPpLrd7Cyo/TxrqfEg3rfNVsxMdt3VoF5mSffGlT9YnzEBSObTS
	teqZS/GHFiGbcsjHZrCHFNYry1fkzNgVi4nh2LINczShu/4ePjqe9PbYk+5gKl1WAgqwAZ8cEO2
	R5qqJIyWwBOdWI/MDc5jpf06kbUThgAKpIxUfOD+X+ZvNPGoBSGMZe3senWHWM0VSvHh0CNntpO
	+buz4M4kZQQkPFCW6S3hy1hiTDdAWQieWdx7mbIRdWOWmIemKSrjzHbL0IajyrVTa+x5v0Cious
	kGOrLXk20=
X-Google-Smtp-Source: AGHT+IElFYc85CKhS9KfCJHXRWtMMxrtc4wlc15KexTf7Z4eltq5dEOMAG1bp2AuYLzlNwgLZOKhew==
X-Received: by 2002:a17:902:ef4f:b0:275:b1cf:6ddc with SMTP id d9443c01a7336-290c9cf8f20mr260206065ad.5.1761120145882;
        Wed, 22 Oct 2025 01:02:25 -0700 (PDT)
Received: from 7950hx ([43.129.244.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-292471d7e41sm131947785ad.57.2025.10.22.01.02.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 01:02:25 -0700 (PDT)
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
Subject: [PATCH bpf-next v2 03/10] bpf: add kfunc bpf_fsession_cookie for TRACING SESSION
Date: Wed, 22 Oct 2025 16:01:52 +0800
Message-ID: <20251022080159.553805-4-dongml2@chinatelecom.cn>
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

Add the kfunc bpf_fsession_cookie(), which is similar to
bpf_session_cookie() and return the address of the session cookie. The
address of the session cookie is stored after session flags, which means
ctx[nr_args + 2].

Inline this kfunc in the verifier too.

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
 include/linux/bpf.h      |  1 +
 kernel/bpf/verifier.c    | 20 ++++++++++++++++++--
 kernel/trace/bpf_trace.c | 10 ++++++++++
 3 files changed, 29 insertions(+), 2 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 3f6cad5df2db..83d5d4d3120d 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1735,6 +1735,7 @@ struct bpf_prog {
 				enforce_expected_attach_type:1, /* Enforce expected_attach_type checking at attach time */
 				call_get_stack:1, /* Do we call bpf_get_stack() or bpf_get_stackid() */
 				call_get_func_ip:1, /* Do we call get_func_ip() */
+				call_session_cookie:1, /* Do we call bpf_fsession_cookie() */
 				tstamp_type_access:1, /* Accessed __sk_buff->tstamp_type */
 				sleepable:1;	/* BPF program is sleepable */
 	enum bpf_prog_type	type;		/* Type of BPF program */
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index a4d0dd4440fd..ab46e5fbc7a6 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -12294,6 +12294,7 @@ enum special_kfunc_type {
 	KF_bpf_task_work_schedule_signal,
 	KF_bpf_task_work_schedule_resume,
 	KF_bpf_tracing_is_exit,
+	KF_bpf_fsession_cookie,
 };
 
 BTF_ID_LIST(special_kfunc_list)
@@ -12367,6 +12368,7 @@ BTF_ID(func, __bpf_trap)
 BTF_ID(func, bpf_task_work_schedule_signal)
 BTF_ID(func, bpf_task_work_schedule_resume)
 BTF_ID(func, bpf_tracing_is_exit)
+BTF_ID(func, bpf_fsession_cookie)
 
 static bool is_task_work_add_kfunc(u32 func_id)
 {
@@ -12422,7 +12424,8 @@ get_kfunc_ptr_arg_type(struct bpf_verifier_env *env,
 	bool arg_mem_size = false;
 
 	if (meta->func_id == special_kfunc_list[KF_bpf_cast_to_kern_ctx] ||
-	    meta->func_id == special_kfunc_list[KF_bpf_tracing_is_exit])
+	    meta->func_id == special_kfunc_list[KF_bpf_tracing_is_exit] ||
+	    meta->func_id == special_kfunc_list[KF_bpf_fsession_cookie])
 		return KF_ARG_PTR_TO_CTX;
 
 	/* In this function, we verify the kfunc's BTF as per the argument type,
@@ -13915,7 +13918,8 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 		}
 	}
 
-	if (meta.func_id == special_kfunc_list[KF_bpf_session_cookie]) {
+	if (meta.func_id == special_kfunc_list[KF_bpf_session_cookie] ||
+	    meta.func_id == special_kfunc_list[KF_bpf_fsession_cookie]) {
 		meta.r0_size = sizeof(u64);
 		meta.r0_rdonly = false;
 	}
@@ -14196,6 +14200,9 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 			return err;
 	}
 
+	if (meta.func_id == special_kfunc_list[KF_bpf_fsession_cookie])
+		env->prog->call_session_cookie = true;
+
 	return 0;
 }
 
@@ -22007,6 +22014,15 @@ static int fixup_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 		insn_buf[4] = BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_0, 0);
 		insn_buf[5] = BPF_ALU64_IMM(BPF_AND, BPF_REG_0, 1);
 		*cnt = 6;
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
index d0720d850621..4a8568bd654d 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -3370,10 +3370,20 @@ __bpf_kfunc bool bpf_tracing_is_exit(void *ctx)
 	return ((u64 *)ctx)[nr_args + 1] & 1;
 }
 
+__bpf_kfunc u64 *bpf_fsession_cookie(void *ctx)
+{
+	/* This helper call is inlined by verifier. */
+	u64 nr_args = ((u64 *)ctx)[-1];
+
+	/* ctx[nr_args + 2] is the session cookie address */
+	return (u64 *)((u64 *)ctx)[nr_args + 2];
+}
+
 __bpf_kfunc_end_defs();
 
 BTF_KFUNCS_START(tracing_kfunc_set_ids)
 BTF_ID_FLAGS(func, bpf_tracing_is_exit, KF_FASTCALL)
+BTF_ID_FLAGS(func, bpf_fsession_cookie, KF_FASTCALL)
 BTF_KFUNCS_END(tracing_kfunc_set_ids)
 
 static int bpf_tracing_filter(const struct bpf_prog *prog, u32 kfunc_id)
-- 
2.51.1.dirty


