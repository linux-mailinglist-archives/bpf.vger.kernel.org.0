Return-Path: <bpf+bounces-58880-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 48575AC2CDB
	for <lists+bpf@lfdr.de>; Sat, 24 May 2025 03:19:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA54D542064
	for <lists+bpf@lfdr.de>; Sat, 24 May 2025 01:19:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73CC01C862D;
	Sat, 24 May 2025 01:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ni14NC+N"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com [209.85.128.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37B5B1C32
	for <bpf@vger.kernel.org>; Sat, 24 May 2025 01:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748049541; cv=none; b=GkmXnUChNmPhvTVBdHsNyBIrXV728TUmm7dYVlfvvu/sTGOBnoCN422DkdFbMx2+do0QL7tuk6oJ3+TfSbaa8UJGMCU7F/jH1PvSas/jVdrO/LGCZ5Ck7Bs1lfhQdrH5hUVBdE8u3tTx76CW8f/H9D/5CG89tdDY2L7OAvnRj9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748049541; c=relaxed/simple;
	bh=+kZ3CukKxTkWxCA8yCj1GM8l6h/MNIeTpysQ18iM1Wo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ms1SqJJLhG3Izpny3ZiM0hU4wP3mJ8E2B4yD2Kzmb56rorpEGX3I9p7Zt24OKHBCAYI4DaM4JuKZ6CIy/H46++05n67pckTpzh+YcDVWNXN+tqmdkZh/fnGfyJBlg/wjRAuMNFedRpkKwCUy1BMpKhirf2FS51p8a5IAFTZh5OI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ni14NC+N; arc=none smtp.client-ip=209.85.128.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f65.google.com with SMTP id 5b1f17b1804b1-44b1f5b917fso1829425e9.3
        for <bpf@vger.kernel.org>; Fri, 23 May 2025 18:18:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748049537; x=1748654337; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iXeZfL7XJFp2K5p0or8e82mNtwZhKFOvwN0pwXyo87U=;
        b=Ni14NC+NsXK+WcW0OwcS2exr05ThRPIOIL5Ba80kZzcwam5eDLrzvPmKQGwgiXuDLz
         ocGhAocWy4Yi4F4fk3hoLAuMqwK7QLu1zBLsVDZXYDu/TdP5tOXXLPqnEPU+UWeyp674
         j0K47jIQuke/lq725rrlN1lUz98KB8IxxLsYjFNkBkPbCl00yEvoaZiPLCE+XLrmZCG3
         abHXTlQMySJvCuEzWFKSmYbSoIVp/udVwjLxR4Z0/mtoJzj2NaAVza5f1BEBtCs3EBqn
         dfyA1YF5ny8/lP/LmDHo+X0/bJ6R6gDEyxO2RzDWoexvHZcdbKLomxg3/jWGiNSEwC/I
         ZmWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748049537; x=1748654337;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iXeZfL7XJFp2K5p0or8e82mNtwZhKFOvwN0pwXyo87U=;
        b=Q1jBkGO9Fr9fVT340AVdrJF1+ZYDgnP4Md94pyiB8BcXnkJaxyq3qOrdvU0sfq7M6h
         u0Iza4AZxqtzRPjhGSqsJ5qz8InkIY9LOHxkTnI5nCgGKreEejjmp2rXRwMymAe87RsA
         G5PU5UjsRZYGBC1S3Swck08mQpVbiiW7mg03eB3YZHNa7d7xDl8OR1At+PZFmPFtOvyL
         DGvp5VnMZUqCjX/vOAJfGE6CWRzgHFALsFC4kyosA19oA+4R0szeAzhXA6uFp1IE2/EA
         IEztDMFEYvhuysBc39Q4ri/O53tJszP66fWy1kKWmKqKvMumBsbXxkg09Te4BTiHO/Er
         QWQg==
X-Gm-Message-State: AOJu0YzpC7s9M710nWVSFzsqXWn418RZoN9hw5sQe7VTPt/30DHqzu+z
	Iv4vmIG3SNtLvgkACUFHsaYykUDvUpyvxw9/QcHrIfLA+ncsHEI9dkzwPL1QQ+qhPrw=
X-Gm-Gg: ASbGncuMqh8g5F46VAmhbVw0Cv8SlnKUAk6JziglG/xlpKlSd6WzZLtxLIc3fNZf4HI
	QQ4OqVyuNa1AVAHdb0xOcl9z3aalJLPeguokrvNxQJFkDLyKexCEwMC+vlAR6/6lqiAuH8D/o3a
	8wOK0fXQTALlXr5IJIKbSncZAloAjgG22viS55xtcHud39UrbIAuUSAyQeUubfqD/ZreM6yRaVi
	ENim1M5GA/33B00vj0L4TlDFBo7boEhAnUqtPCVqegu2Z7n3RxdAjx60KvJvi4fidstb7WZE3CU
	zKjiWTASCEQf8zri527epA6L71a3jXaBGiSWNzRE
X-Google-Smtp-Source: AGHT+IH/Z3gOclOSC2cYR3yjj3N7r4Wi6mdjoS5gs8wl3NaxV8kl2zrI/Ot+uUOpBlGFTIavY1Om8g==
X-Received: by 2002:a05:600c:512a:b0:44b:2f53:351c with SMTP id 5b1f17b1804b1-44c91dcb6e7mr9288425e9.18.1748049536911;
        Fri, 23 May 2025 18:18:56 -0700 (PDT)
Received: from localhost ([2a03:2880:31ff:2::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-447f1ef01besm158002195e9.10.2025.05.23.18.18.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 May 2025 18:18:56 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Barret Rhoden <brho@google.com>,
	Matt Bobrowski <mattbobrowski@google.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v2 05/11] bpf: Add dump_stack() analogue to print to BPF stderr
Date: Fri, 23 May 2025 18:18:43 -0700
Message-ID: <20250524011849.681425-6-memxor@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250524011849.681425-1-memxor@gmail.com>
References: <20250524011849.681425-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3177; h=from:subject; bh=+kZ3CukKxTkWxCA8yCj1GM8l6h/MNIeTpysQ18iM1Wo=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBoMR3P4U45YthzjcmE7ADmxv4UxLJnRktMDWjOJW+D nqyPyuiJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCaDEdzwAKCRBM4MiGSL8RylQiD/ 4mj9M/Z1/DuBXHOjW4l24GN8PlDyxOdQlvQvoitDSr8sjaMOLpHizDwJwyB54ZjsOF7SKxAuNnXj0C 7c6GCsJPcdEDC5r2SoZ4KqmHgH/Gvr4+Bakwg/PyHMGB4rX8SetkE0gxNSdw12imeG2FVatvcCRO5h n4eNLi1sagt6aTdcfMoZ9kErMQR5SIAKGygQk5WXjWTOXgtw8/3EfHt62ZdfArw0XcWRHVhAQWi2g7 ORFDKwOA/rRwwaId1KuNuqxMNXJ8Q7V6DHMri71qAN7rnQwLkryOVai2FYFHwH6TmKhRBmZBqS4ISe S6NO7LsoroFwMfRx7nHRFh0KiOGuH5bGCk+E52Sf5hCmkxkwyU/qMkMnkSyExL15z05VYyl2eN2wTX S3ITRnbdaMF55KnaGGgloipyIkFEprrDy6dGQVLNrc6HuHHbpviUuMNzm8Jc5N8N2jc6ypiCWqpK4p u6mDuDv4aUJkjEA4BBbhmkuMET6GjvxhaglLXc6Gp1hG/dsyKY/0AeZw+DufDCkTMj3vsaRQqVkmuI sLc92JIkfM4Ncg5z9heAV1D5ieb7DoHR1AJn07XA9O3ellBkTC2AqX/JI4lZsVhPNoeytg5V7k2QSh 7OEO8zWxPiLOK+OqZvtHba0ch1P3dD7ecTuOE8iFaDFUh7D4dlMdzxjgwyxQ==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

Introduce a kernel function which is the analogue of dump_stack()
printing some useful information and the stack trace. This is not
exposed to BPF programs yet, but can be made available in the future.

When we have a program counter for a BPF program in the stack trace,
also additionally output the filename and line number to make the trace
helpful. The rest of the trace can be passed into ./decode_stacktrace.sh
to obtain the line numbers for kernel symbols.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 include/linux/bpf.h |  2 ++
 kernel/bpf/stream.c | 42 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 44 insertions(+)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 6985e793e927..aab5ea17a329 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -3613,8 +3613,10 @@ __printf(2, 3)
 int bpf_stream_stage_printk(struct bpf_stream_stage *ss, const char *fmt, ...);
 int bpf_stream_stage_commit(struct bpf_stream_stage *ss, struct bpf_prog *prog,
 			    enum bpf_stream_id stream_id);
+int bpf_stream_stage_dump_stack(struct bpf_stream_stage *ss);
 
 #define bpf_stream_printk(...) bpf_stream_stage_printk(&__ss, __VA_ARGS__)
+#define bpf_stream_dump_stack() bpf_stream_stage_dump_stack(&__ss)
 
 #define bpf_stream_stage(prog, stream_id, expr)                  \
 	({                                                       \
diff --git a/kernel/bpf/stream.c b/kernel/bpf/stream.c
index b9e6f7a43b1b..cebd596671cd 100644
--- a/kernel/bpf/stream.c
+++ b/kernel/bpf/stream.c
@@ -2,6 +2,7 @@
 /* Copyright (c) 2025 Meta Platforms, Inc. and affiliates. */
 
 #include <linux/bpf.h>
+#include <linux/filter.h>
 #include <linux/bpf_mem_alloc.h>
 #include <linux/percpu.h>
 #include <linux/refcount.h>
@@ -495,3 +496,44 @@ int bpf_stream_stage_commit(struct bpf_stream_stage *ss, struct bpf_prog *prog,
 	llist_add_batch(head, tail, &stream->log);
 	return 0;
 }
+
+struct dump_stack_ctx {
+	struct bpf_stream_stage *ss;
+	int err;
+};
+
+static bool dump_stack_cb(void *cookie, u64 ip, u64 sp, u64 bp)
+{
+	struct dump_stack_ctx *ctxp = cookie;
+	const char *file = "", *line = "";
+	struct bpf_prog *prog;
+	int num;
+
+	if (is_bpf_text_address(ip)) {
+		prog = bpf_prog_ksym_find(ip);
+		num = bpf_prog_get_file_line(prog, ip, &file, &line);
+		if (num < 0)
+			goto end;
+		ctxp->err = bpf_stream_stage_printk(ctxp->ss, "%pS\n  %s @ %s:%d\n",
+						    (void *)ip, line, file, num);
+		return !ctxp->err;
+	}
+end:
+	ctxp->err = bpf_stream_stage_printk(ctxp->ss, "%pS\n", (void *)ip);
+	return !ctxp->err;
+}
+
+int bpf_stream_stage_dump_stack(struct bpf_stream_stage *ss)
+{
+	struct dump_stack_ctx ctx = { .ss = ss };
+	int ret;
+
+	ret = bpf_stream_stage_printk(ss, "CPU: %d UID: %d PID: %d Comm: %s\n",
+				      raw_smp_processor_id(), __kuid_val(current_real_cred()->euid),
+				      current->pid, current->comm);
+	ret = ret ?: bpf_stream_stage_printk(ss, "Call trace:\n");
+	if (!ret)
+		arch_bpf_stack_walk(dump_stack_cb, &ctx);
+	ret = ret ?: ctx.err;
+	return ret ?: bpf_stream_stage_printk(ss, "\n");
+}
-- 
2.47.1


