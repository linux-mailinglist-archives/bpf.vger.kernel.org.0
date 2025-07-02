Return-Path: <bpf+bounces-62042-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 94C33AF091F
	for <lists+bpf@lfdr.de>; Wed,  2 Jul 2025 05:18:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 895784230A4
	for <lists+bpf@lfdr.de>; Wed,  2 Jul 2025 03:17:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C22A71DD0C7;
	Wed,  2 Jul 2025 03:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hIcEyOk8"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f65.google.com (mail-ej1-f65.google.com [209.85.218.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96B9E1D90A5
	for <bpf@vger.kernel.org>; Wed,  2 Jul 2025 03:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751426275; cv=none; b=t67P1Dh5huiqRKetoF4/sUjPfz4bWIn7UTV8kvNzSAeJUUs0p8TLEr7Jb8eCuhYuG31f/i1nzNhdRtMwZ70Z85b57IAPjXP6KIZ6ZmYBgj6PYAIXaCt+BKRcxxsrSxOka0K/75367cFU4ZSTR61QK4ng8bc+lSKFtQvEQGVqizk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751426275; c=relaxed/simple;
	bh=pCj7+EgZq+urvQGd4KHjq7pmg9pKzGzQ8feB6n0y+SQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k2BLWIMt4opefLXzWyVYQPrm8DbbLF1JRscCmu+7ospSjucoe1Y7ELnxtE/j0DDfZtW1ul+BmTMAXNLK8RJXxMupX4UxnbwRPQOTkhVKyIVQnuLb0ewmZgR1or20tK8BpkC+ohcBzIOZ8eD4meje4OYlWOWhwPY1LU+9ht5ZwNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hIcEyOk8; arc=none smtp.client-ip=209.85.218.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f65.google.com with SMTP id a640c23a62f3a-acb5ec407b1so701565066b.1
        for <bpf@vger.kernel.org>; Tue, 01 Jul 2025 20:17:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751426271; x=1752031071; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ejgfyiQEaUesnbXcqx1BhRquYvGP5IG0AHfVZLv9BGM=;
        b=hIcEyOk8+nJ2AdO3XGqiiCAwfGHoAPrao9sS8UdAgH1fQscW8knQ7M2P8GEsp6Gnq3
         ogiOyJheguH/odnfZuT5P41d7qnnKOimQVNU3j1NVknvxgaHwv2GzOLj8l9p4JRQdAJj
         LNw3v7C3O6VAteT5Nu8qTgaMogqPAF4LcSX/lJzqHyzulyE2L1eLVmDUEBvrxSX5SyFv
         86fMVbZHoWO9JwCGuH5ydpx4GIJBfcc/3g/12DoRIIaAzV6Evjs6++YNIonwHxBmqDZL
         nS0pWdpw5GUqytYVQdhwSIhXw/0y9t0+bMryJIOqMz/oxrSbFV5XKZr++CwnLgHgnrxl
         vaMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751426271; x=1752031071;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ejgfyiQEaUesnbXcqx1BhRquYvGP5IG0AHfVZLv9BGM=;
        b=sw7vNeT9jl1UOhaF2p+fC4sGk/X3sSi/Y7IVtyNhVBXDTIvvLyoCPoT6icWh3HCxB9
         8LAPUrwqBxBWsSDXseBXeoI2Inu2VceaSeRH57cZ1xfXr6sobxbFGASQGvb+x4+lyiG5
         eBZvs9vlroB2LRu1aKayGCAlC6hW+DMjAsyjXXZhxF21yHpMVuuIiqeHlDsiB0F5Re8V
         zIn7c1BCyYif1xs4SVh9C9nYqeKV48DtR6B8cp//mQd4Fk0QcisZBzhnjUPzYM++qE/Y
         ULifSTlJhDd1+1xV8WJ9FHnHO+No/uVXwfxod+G6FlfLPXC0XpVyCpYkJ4EhX3ljyxOR
         gjMw==
X-Gm-Message-State: AOJu0Yx3HaWvM2FJB0p70DzLDwoIOWbwqbncpFma3f3tQzXxjREq+PVV
	rbUf/Tz5ndN0x9R6hzc99IHGq93Lh2VVGj4Ul7hzgeu4mMxzuh2M75fmIzI00rEe1qU=
X-Gm-Gg: ASbGncvbkKfuOLwrRC21P4p29S36DJun0IIq11tKMXaMmPEDL9TvCwzl938SGx1k66E
	Z3/fBsKtCXWU0iyFHloj9xu75iyyTCTpv2kUk7oHz2t8QW43xpvPUinYCTptS7Jp/n1A3w+w9rU
	jGUqF1IVvVLD901Qrag+ZhDQRTKrJ7EpOTTPLrpUy62XlWsmbM6UxUwwrH3R7jvLjKk1qijYl6D
	ptxlFRcMe3JPaBWcz63b1rYLhqLy51eBwW4xOPA29SgGbR+YiesmYGYdUR3Em7pJNfirKWL4yTE
	4xX4/e2E43t1trkrzFOrd+0CynEHWiGyICgJSZ3zxZWib1Sb
X-Google-Smtp-Source: AGHT+IE1g1HUsqrKwO60/3QGZ3mrln42tC3gLYls24Jsk7L90DZkQ0kuBD7nUiFnw0/kcUvluJXYig==
X-Received: by 2002:a17:907:2d94:b0:ae0:bff9:98de with SMTP id a640c23a62f3a-ae3c2da5d5dmr110758466b.40.1751426271467;
        Tue, 01 Jul 2025 20:17:51 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae360e6ce54sm937758866b.37.2025.07.01.20.17.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jul 2025 20:17:50 -0700 (PDT)
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
Subject: [PATCH bpf-next v4 06/12] bpf: Add dump_stack() analogue to print to BPF stderr
Date: Tue,  1 Jul 2025 20:17:31 -0700
Message-ID: <20250702031737.407548-7-memxor@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250702031737.407548-1-memxor@gmail.com>
References: <20250702031737.407548-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3210; h=from:subject; bh=pCj7+EgZq+urvQGd4KHjq7pmg9pKzGzQ8feB6n0y+SQ=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBoZKFR/ZK0e2Kss2ErvHFXKUXJFvRpqDu8CM2wcNqH JQl44xyJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCaGShUQAKCRBM4MiGSL8RymiOEA Cj8K0WV5/NfdIY92JPTSKwV6rcTRVuh9Nyt5mFStS8Jzw44TmV56Rk0SWV2/yjgvOS7KPkfgnxucX2 agsTzbUnODtACoE0NmQK4vKkQzkIDesHQOQ/guw6z4Z0pbrpOAhv9b6xtVDVC2WuFGvP9KA0GU/dVq w4VjqT4/aZjewL16c6qN9i6lu44RJweuJwIpSN5Dxx99W9MORG2VVcxay45n2Cw9o+CklNrjOrIrtt S8Ng7w1P+D9hfHTZa+Aj3eBuhLYOhAuMd8LL7j9hX6LXMxOO0eXuY6ZKWYSNT+tqVZq65rwbOg9OEA GMcF5VBDM0KJhaDkzY+Sb8phftJx+pojBEg0zsnnOb9czthbGuQmPE0duXEC3EE5pERF7VIlhB6Llr e3c9DyVu4EDSEdtqCzrmfjh3DiQ2bvL979TX0DI5+bJ2388fnAtIEeF19p5jv92r1KsXYTIdIi2kzD 1XVTTdfbyROHc1077cL3HxJFOoUUOv53vjCojmKuSG9/R8sc7uCW2RShG2DXaaRYWAAj7n8pSsNmB7 DdfvaneJ7d1g40JwCJYvk10I9h0SvH2NMmLk+vj6MuVpIpRi7NBnGAux30pkhNqvIwibBG/yHfzH2D 5jo7lKSNSVWbaY7JnDnMl86VzJgxPm38L0umaUoGI1Ui+xvAX0ZdrFlM2kmw==
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
index c4925f8d275f..370eae669300 100644
--- a/kernel/bpf/stream.c
+++ b/kernel/bpf/stream.c
@@ -2,6 +2,7 @@
 /* Copyright (c) 2025 Meta Platforms, Inc. and affiliates. */
 
 #include <linux/bpf.h>
+#include <linux/filter.h>
 #include <linux/bpf_mem_alloc.h>
 #include <linux/percpu.h>
 #include <linux/refcount.h>
@@ -476,3 +477,46 @@ int bpf_stream_stage_commit(struct bpf_stream_stage *ss, struct bpf_prog *prog,
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
+	ret = ret ?: bpf_stream_stage_printk(ss, "Call trace:\n");
+	if (!ret)
+		arch_bpf_stack_walk(dump_stack_cb, &ctx);
+	ret = ret ?: ctx.err;
+	return ret ?: bpf_stream_stage_printk(ss, "\n");
+}
-- 
2.47.1


