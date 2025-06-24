Return-Path: <bpf+bounces-61343-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EDE0AE5A66
	for <lists+bpf@lfdr.de>; Tue, 24 Jun 2025 05:13:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D91757B1DCD
	for <lists+bpf@lfdr.de>; Tue, 24 Jun 2025 03:11:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AAF920C004;
	Tue, 24 Jun 2025 03:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q+boGmbJ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f68.google.com (mail-ej1-f68.google.com [209.85.218.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFE0223774
	for <bpf@vger.kernel.org>; Tue, 24 Jun 2025 03:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750734786; cv=none; b=oJBr17wqGiSlTPT0dXfmGFuxldrTXRF5yNicmAgVbIty+0p83jcfxlM9t0cJtx1i+veHhBF6QpPve8G9OL/4lKKnI6KJxoKmMQSChbHjlG83Q43/01vRRlP4rZxngXuYiGc5pBVG/4zRKilPshSugI5xgu9+e20ZGmQR/lSNzyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750734786; c=relaxed/simple;
	bh=djjaoNoSa4qOpczSZYvSRFwORMbaw7YfdL10zhzggNU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Jhlbhsei+hyDmxlKQwHd1SQ+HxImc3uuTUoT2JlGeCG71Eb4TwJTVpwrWrcrZSMbpAym4ECiQfg7E7Wr6E1vLAFInc+crvPqmgJZ6j5aT+fLcOy9tM4GlJPJX894P4FQUfXgJcDhI9kP3j361OduFDqdGEbisIwtqT2h2sYe5F0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q+boGmbJ; arc=none smtp.client-ip=209.85.218.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f68.google.com with SMTP id a640c23a62f3a-addda47ebeaso1007639266b.1
        for <bpf@vger.kernel.org>; Mon, 23 Jun 2025 20:13:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750734782; x=1751339582; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FZSZY/Ur7JnOIHlz2qkXgUVStl84nDmxbqcTqnwcXGo=;
        b=Q+boGmbJ7wKDoW+4tMVNkLqV5eM2Jus5Rxb2HxsjenMkXDcKsOzDD74edJabQIHckj
         7eansZfrLKvpE5BhXt7uf0pUo/xuiX6z7+dK2W2Ks2VRiWXft4NFQn1WmgJiJHiJJV0J
         lheZqPaiXIY4nIhC1ZuX9Q9YdRyL74Ja+S07eoPiBpoomEzKOw3dNKx1EtRp6WALP4Os
         SwDII0Xwf0pDE6zeHXN1FE3WH8sgThdDjEHd/SpWRcAa/SgMxk36/LdxpCja+BTHtEYc
         PlZMktTxRTSLNCiXkSXk+Qmz8fZxQbqeV1BRgJSFHHA8sX6lMwIIE3xMPTpoCdG/QLEd
         GpLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750734782; x=1751339582;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FZSZY/Ur7JnOIHlz2qkXgUVStl84nDmxbqcTqnwcXGo=;
        b=toUn8CsT7gjh92GdKk5qha6qFLSaDT3bWl1tdblWm6Tg3AWHS2BiJIcT8QKsyhgGoG
         OMpUAUa0J+VlBIZU9vvz4WS4lu7sUymChZjBjWs8n9O+QP1dwjmaJ1SADqgsZWFCGUv3
         1l2zlEPi0x2sw0IAQ/AQEy7B+QHjagXrOAtrWFdk6IUbZnRJybj0PJ308YrOHJ98tqjj
         7E7wkVZBNpf/SaAGeiAnPmwvrP0hXxRYC3fGBdAGVL54Ga1IUcN3s1YDtDXDJZtJ/Xkn
         E+Jvicll2lHjgjCaFuXqbTxStXzFWUGF/Nt/qnKOBMP9TQ6ljig6ZPb7d1tdNua+u6Qs
         j/1Q==
X-Gm-Message-State: AOJu0YzzHUMD3FI8spZMJgnaMnQpez3uElqA6XktSqqv82zgI0lfTRh/
	j7cRmXpugCYTUapuMbC0MBjv8SlX9rrTAAXjUWZ2h80Om5FrSsiK2gVwlpMzUhvKN8w+0Q==
X-Gm-Gg: ASbGncu5d2mBWsLlBmt788M/9jYj06ls8Jcn9pnIWnJeoB1SaTlhRCykE2MaWCKhqOH
	48KUURKW7pa7J7KoF71COVNca5BLPpJ8wAGfau2ZGOceNVaxyQc8pzLQ09aL5zF7EMgp5dRTW6f
	DJrTaBf/UFis2NLAf3+UzPjfG+LGgvWH7Z5l3RM6Cg/V3XYx6Ise+9YG68LH9sRQmJgPgMdXpzK
	2l7lcb7jV2KoreHjiBuIKAsJT3fbHK+bZDTnbT+C/gcHXDwCo+ij0l/PrA6mTQBHbeP4jTpZwoc
	Ih2DQZGWG7miZ/kge/FwgfogV4K7CyoYO+WJXjtkT3KouugpRU0=
X-Google-Smtp-Source: AGHT+IHkWUY7KG9lgDgOoMK5G81hTq3I/8StLNPRB7Ley8K5hl6IcQ4Xz2FOv2IBuS3HP5Z+ipGa0w==
X-Received: by 2002:a17:907:72d5:b0:ad8:9e80:6bb8 with SMTP id a640c23a62f3a-ae0578d850bmr1399009666b.6.1750734781561;
        Mon, 23 Jun 2025 20:13:01 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:4::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae0a87e4dcdsm62097466b.10.2025.06.23.20.13.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jun 2025 20:13:01 -0700 (PDT)
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
Subject: [PATCH bpf-next v3 06/12] bpf: Add dump_stack() analogue to print to BPF stderr
Date: Mon, 23 Jun 2025 20:12:46 -0700
Message-ID: <20250624031252.2966759-7-memxor@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250624031252.2966759-1-memxor@gmail.com>
References: <20250624031252.2966759-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3326; h=from:subject; bh=djjaoNoSa4qOpczSZYvSRFwORMbaw7YfdL10zhzggNU=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBoWhWe5zS5Tex+hK4bmWNWUgGczhsfCk5PSpZdMkWh 4rkZUnWJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCaFoVngAKCRBM4MiGSL8RytR7EA CopFWfKstHWmzDBIqJgMIe40bGIUwYI189AuZFJ3WLEJvJC8+R8ZeOkoj+oDmIdDPflNF8TqGgeaBx 44hSwSr8Uig2gCfoTEuUXccPGY+WM7zrd9HCuv9UGgKE2ukuBQK49aPCbrdS4CPcPb2xBy+nNHRJj3 J9ZFdZ9FtMlvbnheLmV0PjWXaTD1pKKHWu0QQ0pwAs10CwC1J+SuKnMVi1hEq4vOC8bBmH6NTc8RrM JPg77I23xh2lv2axuldJfYJBz2onSh41Xkrg1YhwP/a/Upk9OQHEhyqMVXX8/iuq851cQZB4BVPZJD qgYJi35bI4YemVQg7XAdmj3Bmkgif55mjrmXxr2Yck9c9iDCs61QSJi2IXWe5GJXSKFRH9bSKGK3lr Id0jaHZrh20ncOYQkgAe0rVgv73qVmK/qgkIsInpFIjrjK6n8EXND/YViX7AmInm8PmO3t8Dxk8iXG EoSWNHEOJcMRBAYAgLvkJuOYlroEZ/lGkOBs2m8J4P8s4JY+iCpm2UEIfBPjseqziRqB4xfPM52INX UxDhlziB53I3iczkOQIIipTChaNa+U7UjWNfibEyt/UxEilgQ0+2a2Yj5No83TkPWGadE1+YYNnm0/ SOWLcNyi0cFn6ISrIc2G6VG7RkCamKj7tiGs+c1+pyn1wxk4iJeRkcF2tH3A==
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
 kernel/bpf/stream.c | 44 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 46 insertions(+)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index cc14ff8e0b88..bd3cde41795e 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -3618,10 +3618,12 @@ __printf(2, 3)
 int bpf_stream_stage_printk(struct bpf_stream_stage *ss, const char *fmt, ...);
 int bpf_stream_stage_commit(struct bpf_stream_stage *ss, struct bpf_prog *prog,
 			    enum bpf_stream_id stream_id);
+int bpf_stream_stage_dump_stack(struct bpf_stream_stage *ss);
 
 bool bpf_prog_stream_error_limit(struct bpf_prog *prog);
 
 #define bpf_stream_printk(ss, ...) bpf_stream_stage_printk(&ss, __VA_ARGS__)
+#define bpf_stream_dump_stack(ss) bpf_stream_stage_dump_stack(&ss)
 
 #define bpf_stream_stage(ss, prog, stream_id, expr)                      \
 	({                                                               \
diff --git a/kernel/bpf/stream.c b/kernel/bpf/stream.c
index 75ceb6379368..5fb11202ab9c 100644
--- a/kernel/bpf/stream.c
+++ b/kernel/bpf/stream.c
@@ -2,6 +2,7 @@
 /* Copyright (c) 2025 Meta Platforms, Inc. and affiliates. */
 
 #include <linux/bpf.h>
+#include <linux/filter.h>
 #include <linux/bpf_mem_alloc.h>
 #include <linux/percpu.h>
 #include <linux/refcount.h>
@@ -483,3 +484,46 @@ bool bpf_prog_stream_error_limit(struct bpf_prog *prog)
 {
 	return atomic_fetch_add(1, &prog->aux->stream_error_cnt) >= BPF_PROG_STREAM_ERROR_CNT;
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
+	if (is_bpf_text_address(ip)) {
+		rcu_read_lock();
+		prog = bpf_prog_ksym_find(ip);
+		rcu_read_unlock();
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
+	ret = ret ?: bpf_stream_stage_printk(ss, "Call trace:\n");
+	if (!ret)
+		arch_bpf_stack_walk(dump_stack_cb, &ctx);
+	ret = ret ?: ctx.err;
+	return ret ?: bpf_stream_stage_printk(ss, "\n");
+}
-- 
2.47.1


