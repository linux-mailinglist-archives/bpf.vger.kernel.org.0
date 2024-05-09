Return-Path: <bpf+bounces-29190-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C6468C11A4
	for <lists+bpf@lfdr.de>; Thu,  9 May 2024 17:06:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF8431F21EF3
	for <lists+bpf@lfdr.de>; Thu,  9 May 2024 15:06:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D26E1581E1;
	Thu,  9 May 2024 15:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eP6vhRxU"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54DC615279B
	for <bpf@vger.kernel.org>; Thu,  9 May 2024 15:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715267163; cv=none; b=c2+SXJapYUJWWF86rVDJ56EtVRA6vjBDZnPseQK+oBqEAyySUWmn0+Lm0w7xmPS8X/JKwa88rj0X7w9ujRZwS4pSEAhJn9Imtb0pzhFef08SiqJaNPEKa34pQ+UE8uzN5UACtckPFDjZlrBHySAFGyeDvJ9N8UBfzKhyGLVeTwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715267163; c=relaxed/simple;
	bh=lxH2QcRVmvku10WVdFnHvggLH3ZyeUJah1rWygbm1nw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eDMLvqj+OmZ+ZWHNkTG7OWLJA23eUF5oDN2OekA6iLxaF8vmLXL/3N9XwdcTQabIo0iOVzM9Di5uF2iieMpCX1LBPox5rB5FA2WeClXFirgJ1NWcBqZCvFRdDpIgjw7FtvO7HTGkcgf41qT6KHJh9QbAUEAfproMhjDyo3e8DQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eP6vhRxU; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1ec4dc64c6cso6347085ad.0
        for <bpf@vger.kernel.org>; Thu, 09 May 2024 08:06:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715267161; x=1715871961; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MH5/zpAgqORukjDgFwj7zMfc/WIPDkxbhHyvfRFapGI=;
        b=eP6vhRxUTrW6JBtXdda2f4c2Z2h36ShfzzqF5f8zUTWrc9tyyzhy9uFW0eYZtafya1
         h8Z6QQGsaHr4Zyof67VuUxAbHvi7I6q5pGFnxP1Q4HugNWyMyatk6M6yW9PnFFQFNzY1
         gC4qk5AxpNBSlRIbFb5MZi9xyyhKGwMkkCmN+U+GLCntgpM7rCV8ynQLOxxDpZkGIF2H
         EC3xYPALNCNWJdgsYk6H3GiXtHuLZqVdR69LS58H46q8TPA6QtS5HOUTeQzXJf2bi2YY
         xi2LBS1KflS7Zpo3vyOZZkHs5v1CBoI646bAOiC4afoc4MB9k2DW/rMrUxSrtcIYWgX4
         tSfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715267161; x=1715871961;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MH5/zpAgqORukjDgFwj7zMfc/WIPDkxbhHyvfRFapGI=;
        b=iSS5iYVvN8a4yHABpRmBcjFJTulxlPeRTD3fKY8OebRM929UuxSA8Rx2oVv3fhH8/h
         rGQ73SU++V1NZ8cHq6DXef0bRE3vRxs7H2bJPXZYRoecF8iNzpCJx7If2SQTvHc0iGtj
         cDHipjpx4cqYt87zKArN0XzwQWfw4wIh6fd96rrXVqZjeOeuPLgfKhhkOEaLndZKeRVc
         z97osZ99znVm0G6V7ofOP0QUwhsO73WGjxe5CJTYxGEXjYoZW+UdyHXFbUVez4KwAQ04
         zd82PwpCwc/7mq6GJW/kkVkL8HXE6mukwIPmLXnJ6Xs1zq2bxPbtzGlDHrizOHZuyARX
         Aunw==
X-Gm-Message-State: AOJu0YxiCUSzsCRQnfQYDmgRZD0KgwAzD8apxsZEoC9Jc8eRn+d1JueP
	ozx8Bwsgi8KH/yNsmFnJAgPMSuWax6brVDPbuQzC2OTdL6yuWi0ywZK7UA==
X-Google-Smtp-Source: AGHT+IFFbBeL+Wicsv2wY5Urm3R1/vvxxSdb6BGrARB+gY8RJtPHEDwRIDlJe1m248uvlKFC9vZMZQ==
X-Received: by 2002:a17:902:8b88:b0:1e2:be4b:dd9f with SMTP id d9443c01a7336-1eeb029e5e9mr50423395ad.15.1715267160994;
        Thu, 09 May 2024 08:06:00 -0700 (PDT)
Received: from localhost.localdomain (bb116-14-181-187.singnet.com.sg. [116.14.181.187])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0b9d1642sm15376135ad.31.2024.05.09.08.05.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 May 2024 08:06:00 -0700 (PDT)
From: Leon Hwang <hffilwlqm@gmail.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	maciej.fijalkowski@intel.com,
	jakub@cloudflare.com,
	pulehui@huawei.com,
	hffilwlqm@gmail.com,
	kernel-patches-bot@fb.com
Subject: [PATCH bpf-next v4 2/5] bpf: Introduce bpf_jit_supports_tail_call_cnt_ptr()
Date: Thu,  9 May 2024 23:05:38 +0800
Message-ID: <20240509150541.81799-3-hffilwlqm@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240509150541.81799-1-hffilwlqm@gmail.com>
References: <20240509150541.81799-1-hffilwlqm@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In order to store tail_call_cnt on the stack of bpf prog's caller,
introduce bpf_tail_call_run_ctx as a new ctx for bpf prog, which
wraps the original ctx and tail_call_cnt pointer.

To avoid breaking run time, introduce use_tail_call_run_ctx in
prog->aux in order to determine whether to use bpf_tail_call_run_ctx
before calling bpf prog. This flag will be set when
prog->aux->tail_call_reachable and the prog is jited and the arch
supports bpf_jit_supports_tail_call_cnt_ptr() at load time. Thereafter,
the prog's prologue has to cache tail_call_cnt_ptr, and retore the
original ctx meanwhile.

Signed-off-by: Leon Hwang <hffilwlqm@gmail.com>
---
 include/linux/bpf.h    |  6 ++++++
 include/linux/filter.h | 13 ++++++++++---
 kernel/bpf/core.c      | 19 +++++++++++++++++++
 3 files changed, 35 insertions(+), 3 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 90094400cc63d..95888700966f7 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1466,6 +1466,7 @@ struct bpf_prog_aux {
 	bool attach_tracing_prog; /* true if tracing another tracing program */
 	bool func_proto_unreliable;
 	bool tail_call_reachable;
+	bool use_tail_call_run_ctx;
 	bool xdp_has_frags;
 	bool exception_cb;
 	bool exception_boundary;
@@ -2047,6 +2048,11 @@ struct bpf_trace_run_ctx {
 	bool is_uprobe;
 };
 
+struct bpf_tail_call_run_ctx {
+	const void *ctx;
+	u32 *tail_call_cnt_ptr;
+};
+
 struct bpf_tramp_run_ctx {
 	struct bpf_run_ctx run_ctx;
 	u64 bpf_cookie;
diff --git a/include/linux/filter.h b/include/linux/filter.h
index 7a27f19bf44d0..f8e9d5e3da11f 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -671,7 +671,13 @@ static __always_inline u32 __bpf_prog_run(const struct bpf_prog *prog,
 					  const void *ctx,
 					  bpf_dispatcher_fn dfunc)
 {
-	u32 ret;
+	struct bpf_tail_call_run_ctx tail_call_run_ctx = {};
+	u32 ret, tail_call_cnt = 0;
+	const void *run_ctx;
+
+	tail_call_run_ctx.ctx = ctx;
+	tail_call_run_ctx.tail_call_cnt_ptr = &tail_call_cnt;
+	run_ctx = prog->aux->use_tail_call_run_ctx ? &tail_call_run_ctx : ctx;
 
 	cant_migrate();
 	if (static_branch_unlikely(&bpf_stats_enabled_key)) {
@@ -679,7 +685,7 @@ static __always_inline u32 __bpf_prog_run(const struct bpf_prog *prog,
 		u64 duration, start = sched_clock();
 		unsigned long flags;
 
-		ret = dfunc(ctx, prog->insnsi, prog->bpf_func);
+		ret = dfunc(run_ctx, prog->insnsi, prog->bpf_func);
 
 		duration = sched_clock() - start;
 		stats = this_cpu_ptr(prog->stats);
@@ -688,7 +694,7 @@ static __always_inline u32 __bpf_prog_run(const struct bpf_prog *prog,
 		u64_stats_add(&stats->nsecs, duration);
 		u64_stats_update_end_irqrestore(&stats->syncp, flags);
 	} else {
-		ret = dfunc(ctx, prog->insnsi, prog->bpf_func);
+		ret = dfunc(run_ctx, prog->insnsi, prog->bpf_func);
 	}
 	return ret;
 }
@@ -994,6 +1000,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog);
 void bpf_jit_compile(struct bpf_prog *prog);
 bool bpf_jit_needs_zext(void);
 bool bpf_jit_supports_subprog_tailcalls(void);
+bool bpf_jit_supports_tail_call_cnt_ptr(void);
 bool bpf_jit_supports_percpu_insn(void);
 bool bpf_jit_supports_kfunc_call(void);
 bool bpf_jit_supports_far_kfunc_call(void);
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 99b8b1c9a248c..3fad4d973b820 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -2358,6 +2358,13 @@ static int bpf_check_tail_call(const struct bpf_prog *fp)
 	return ret;
 }
 
+static void bpf_check_tail_call_run_ctx(struct bpf_prog *fp)
+{
+	if (fp->aux->tail_call_reachable && fp->jited &&
+	    bpf_jit_supports_tail_call_cnt_ptr())
+		fp->aux->use_tail_call_run_ctx = true;
+}
+
 static void bpf_prog_select_func(struct bpf_prog *fp)
 {
 #ifndef CONFIG_BPF_JIT_ALWAYS_ON
@@ -2430,6 +2437,10 @@ struct bpf_prog *bpf_prog_select_runtime(struct bpf_prog *fp, int *err)
 	 * all eBPF JITs might immediately support all features.
 	 */
 	*err = bpf_check_tail_call(fp);
+	if (*err)
+		return fp;
+
+	bpf_check_tail_call_run_ctx(fp);
 
 	return fp;
 }
@@ -2941,6 +2952,14 @@ bool __weak bpf_jit_needs_zext(void)
 	return false;
 }
 
+/* Return TRUE if the JIT backend supports tail call count pointer in tailcall
+ * context.
+ */
+bool __weak bpf_jit_supports_tail_call_cnt_ptr(void)
+{
+	return false;
+}
+
 /* Return TRUE if the JIT backend supports mixing bpf2bpf and tailcalls. */
 bool __weak bpf_jit_supports_subprog_tailcalls(void)
 {
-- 
2.44.0


