Return-Path: <bpf+bounces-62336-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 487EFAF821B
	for <lists+bpf@lfdr.de>; Thu,  3 Jul 2025 22:49:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7290C7A7810
	for <lists+bpf@lfdr.de>; Thu,  3 Jul 2025 20:47:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC7E92BE7A0;
	Thu,  3 Jul 2025 20:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c1ba79kh"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f68.google.com (mail-ej1-f68.google.com [209.85.218.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80BDA258CDC
	for <bpf@vger.kernel.org>; Thu,  3 Jul 2025 20:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751575716; cv=none; b=aqJYnV+aXHv+KkzKewLHyQXBJbsYeh3zamBUYdAcJpoQLbMOzZerfDkWoucAMOFPwV+CMMl55+RwcEmuFMwHUepMX+/6790Mwawndf18wDbqHeBieKeVSzu4Ovk4GDMON3e6HjDSKWAJhTKA/+LUSBuyYiHSlS0XJ7ENLtSQB7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751575716; c=relaxed/simple;
	bh=tuVtsj2FUEct5UJVVukX+Tqd/uBARO8xoco6XX3JQWI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fNdTpILYQBhLW9Tul5t8zdKD4D722r0alElJmQm+Sk+iqoYYRSIk3YC5RCd3sq/z8F/a2kZRz1VW6wRCeFIiqP0QfNFMb5YSKtg+rrf3GrColdtBm1qvNMEiDdsqA2bdBT/K+3rJfz9kiB3fAROKvvune2q/82sghvaxfwNyQSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c1ba79kh; arc=none smtp.client-ip=209.85.218.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f68.google.com with SMTP id a640c23a62f3a-ae3703c2a8bso55253566b.0
        for <bpf@vger.kernel.org>; Thu, 03 Jul 2025 13:48:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751575712; x=1752180512; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wwhuL2SqzYLu1cEMBHmhpdIBQEY94uZH50R611mz8bw=;
        b=c1ba79khLz+dwBaFtPFiYiXbLT0GcUBFAHshDj71JUhPRekMFIx2LZKLsN6pR41LsX
         J1Q2KHkViG6hbmhssDCdO+N+LX3NBCSmIZe9JgorOvnkn9cRZEDxkL0vjVn4UFXJBcQH
         qq+AJEyBUA4z3qC5gpmmOseAsu6S4OO6I2fH1+utOP39Ir1FG9jIfERH6lkI6RvwhxiX
         H7xo8Urg32z/C3oodIH/HvjdfgTiJXH2aFL5CBW9p8D6GxqsoRJGrfaJe7yFmoulZ7y8
         psrlnUIrTcIhElDgZloKXxGDk0ttMAm9Z4o8Y0vaftHf8JPnhv9WSgOQhE/7fjWGl4Tl
         wpCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751575712; x=1752180512;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wwhuL2SqzYLu1cEMBHmhpdIBQEY94uZH50R611mz8bw=;
        b=l4+wFelzAVggT5/YEndEdGCVczqcB3JjpZtkUVRMa1u1JLc0b7QDjUDhHWjDwbKWJc
         gXEhd3ZGDJM2HHJKH/UGWbKXEgMyZnR/fg94sxsvQwkPQLaITxpvhUVVP/kTA7uoFmtd
         ibJfSos1Gq+mfl4IYcDaSKyJgsNrEVEn0rnAP0T6jWws9xhK5rhlz6D42vwgyQ1+Hfmu
         TsF40FyX4boaKCBuIfgKsrEwl1dLj9z5py27TMH6IYX+0LjDi6BNMwh4kBb778TTlgD6
         pRBLJIRhMwPxB4+Bw1FIovY76BIBJNwKX8Sq2pHirjMAAfqPr6KLpFsB2VFLSPqz6yTn
         Or9g==
X-Gm-Message-State: AOJu0YwX4Sx6olsIWkZ2kaZpez6m9EGaShf9ZtM2ABSRxR3EedSgjmcI
	hXeb8eSQd2hp0aOoUAAKuK6/yvbYZ33LeLkTrm3SjFTHOAVLxzJm8xyPuaZ77LOluMo=
X-Gm-Gg: ASbGncutapb/vpYhA03NLRBZaFotJzjir3Y8ykk08F8yF0R1Osy3A6TrpNYJvbRCSeE
	fkIGsv/fkN6VXcnmk/HZGO6b+vTetudD+vrAFcbl4R26HK4mB61P7w5CGuRiJCOs9JZwUg5Hh3m
	YDJOFs+z/a+p00JtjbR4ZkJfSk1S8DhBcaBSYZyhcJUzO5SaFIpbPAG5w7aplxvLHd5GVdV928C
	Vf2IuBwx4Umk5gEEUHviKf8/aaQwaZKmsjvHrItpsEJSbZ5Nz/bPjMxnzsizczdHjCO5PpBLgnn
	LUxJwdw3qLPAaqM/Bswf91folF34FN5q40ysWGP0CRCaS0s/fmI=
X-Google-Smtp-Source: AGHT+IGvykxHfgnM31GGE9KPjBSVcUKqmpB8WHw1IQ5JRgQHNiahWvC1nlwK2adpY4gMHI2HLt4SRQ==
X-Received: by 2002:a17:907:9693:b0:ad5:4806:4f07 with SMTP id a640c23a62f3a-ae3d83c0681mr451036566b.2.1751575712271;
        Thu, 03 Jul 2025 13:48:32 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:2::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae3f6b02a2esm37279366b.119.2025.07.03.13.48.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jul 2025 13:48:31 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Emil Tsalapatis <emil@etsalapatis.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Barret Rhoden <brho@google.com>,
	Matt Bobrowski <mattbobrowski@google.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v5 06/12] bpf: Add dump_stack() analogue to print to BPF stderr
Date: Thu,  3 Jul 2025 13:48:12 -0700
Message-ID: <20250703204818.925464-7-memxor@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250703204818.925464-1-memxor@gmail.com>
References: <20250703204818.925464-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3303; h=from:subject; bh=tuVtsj2FUEct5UJVVukX+Tqd/uBARO8xoco6XX3JQWI=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBoZudL/CgyZ+Rp6BiyHnQk+ncb5eof1NEoUaolXV8r slsxFUqJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCaGbnSwAKCRBM4MiGSL8Ryux6EA CMvSOfSDgPWgv94KgLukX4qrleotKRRLYsNrWEbs1+BV6AjLKYUtyiLYVrALqXkatOvh8NfLOkQ8qS uSdSNt7CtNwU+XpcGuCbMRuGDbrO78qxImObV6/xl9M24WiXxlicCYzCbyxvGoexsHOkOGzyRUtVOz sK2Nim6BBxVLqgscnAiDeehrV2+MiCcI9Hcrx9dDGCJ0n/xCsHbYNrE2yJeSjyOB1F/18BMn9hoWc3 /MQIqcJlruyI3Td8A8ON3FVlaRXKjL4sQN3GUyrxZY1RCEQddYQJjmXhFoUFIH/TrQfV7/cPQ0omsM enQkHNJ4nDSWz1OAdDPYpI4U0HmVlkAkNpFvf7XEHuzdbXGBtA6kPSxD1gHdgyuRf3JJh+wFpyo6JT xRiyl/A5+FPO7z34vd5CqRGc4BjzqMRJjdaRd5bpCOzTR2oEMOq+6k+/7Ot+0mLXy8bDAVhEckMTYt VvDjIg27i/5CnHWw5CnCWoTrGzpq3gOz76LH/U2eU/0RrNc/EVXDtuEZKsONnU8I8rUz3bb5GU/jRO hmnxU3iUSOV8UmBWpMAfiOZ1S5NS1L4UR2IAbcDscgphrcOnWOD11t8XYv6yIrzSLsKUBmqKaLdNYG o32rsazVkRbnjK+XvN1vIpb5k/QxPxqmTnh7MbH+Heb0GkoPbbr5nUPEEChQ==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

Introduce a kernel function which is the analogue of dump_stack()
printing some useful information and the stack trace. This is not
exposed to BPF programs yet, but can be made available in the future.

When we have a program counter for a BPF program in the stack trace,
also additionally output the filename and line number to make the trace
helpful. The rest of the trace can be passed into ./decode_stacktrace.sh
to obtain the line numbers for kernel symbols.

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 include/linux/bpf.h |  2 ++
 kernel/bpf/stream.c | 48 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 50 insertions(+)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 4d577352f3e6..18f8e4066e20 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -3615,8 +3615,10 @@ __printf(2, 3)
 int bpf_stream_stage_printk(struct bpf_stream_stage *ss, const char *fmt, ...);
 int bpf_stream_stage_commit(struct bpf_stream_stage *ss, struct bpf_prog *prog,
 			    enum bpf_stream_id stream_id);
+int bpf_stream_stage_dump_stack(struct bpf_stream_stage *ss);
 
 #define bpf_stream_printk(ss, ...) bpf_stream_stage_printk(&ss, __VA_ARGS__)
+#define bpf_stream_dump_stack(ss) bpf_stream_stage_dump_stack(&ss)
 
 #define bpf_stream_stage(ss, prog, stream_id, expr)            \
 	({                                                     \
diff --git a/kernel/bpf/stream.c b/kernel/bpf/stream.c
index e434541358db..8c842f845245 100644
--- a/kernel/bpf/stream.c
+++ b/kernel/bpf/stream.c
@@ -2,6 +2,7 @@
 /* Copyright (c) 2025 Meta Platforms, Inc. and affiliates. */
 
 #include <linux/bpf.h>
+#include <linux/filter.h>
 #include <linux/bpf_mem_alloc.h>
 #include <linux/percpu.h>
 #include <linux/refcount.h>
@@ -476,3 +477,50 @@ int bpf_stream_stage_commit(struct bpf_stream_stage *ss, struct bpf_prog *prog,
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
+	int num, ret;
+
+	rcu_read_lock();
+	prog = bpf_prog_ksym_find(ip);
+	rcu_read_unlock();
+	if (prog) {
+		ret = bpf_prog_get_file_line(prog, ip, &file, &line, &num);
+		if (ret < 0)
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
+	if (ret)
+		return ret;
+	ret = bpf_stream_stage_printk(ss, "Call trace:\n");
+	if (ret)
+		return ret;
+	arch_bpf_stack_walk(dump_stack_cb, &ctx);
+	if (ctx.err)
+		return ctx.err;
+	return bpf_stream_stage_printk(ss, "\n");
+}
-- 
2.47.1


