Return-Path: <bpf+bounces-57678-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 563E8AAE795
	for <lists+bpf@lfdr.de>; Wed,  7 May 2025 19:17:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 483703ADACE
	for <lists+bpf@lfdr.de>; Wed,  7 May 2025 17:17:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 000E028C5D1;
	Wed,  7 May 2025 17:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A4qjuhUc"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com [209.85.221.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B651028C5C0
	for <bpf@vger.kernel.org>; Wed,  7 May 2025 17:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746638254; cv=none; b=qty+B/QdQg9c3qP7hJN7pd9CYCMfiq4irG0F0ljIsIuIzojU//Fn5w49yJh+qn6vtmdOgIVZ7oyHzH0gk+iWJf3r3Cbdz5LrNGZ5Gic4uZ+0Xh9/dkwddHjZc8XtNfKxmx34GzuXJdl3rlMsvRnMufD5kzKmF2R1Io/+6bjY6I8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746638254; c=relaxed/simple;
	bh=dn8iSnhuMUC0jQICfSTbBLfwxRKe8jf2kccQZiCBZnU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fhawfmfQz3ucQcL9rCehXsAKCK7oW5K22bmlphqA9RLdip+lMu9G4fh6JRSyf+4j7epEFi0PTKqQSK8MVceUYMAFs6SyyOK4Z5gOwhbBWJs2alkT2LVQn33/4LkIgFHeg01698Nx7w2JqUasZt9EnEOHlRnNjomjww5B0H+WwdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A4qjuhUc; arc=none smtp.client-ip=209.85.221.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f67.google.com with SMTP id ffacd0b85a97d-39c266c1389so77417f8f.1
        for <bpf@vger.kernel.org>; Wed, 07 May 2025 10:17:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746638249; x=1747243049; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gI4QKXUUocncAo9i7q/ORGKfmfoKemGxoAEm5JcoIpM=;
        b=A4qjuhUcD3xQXDjfk6r1+6V7mgzhzqpi9ty6u91mp9HOd8pgSmmn3aXU1B7X8J9+2e
         4DLpSm+RkBnHCZYBZFAxM9OsmMKqU62a+jcuqdUuN0m0nfcZibGWow0Cnh/yQyVBh8jh
         SXyHyDouycnqxAMx1ks6V4mcJorC+s34Ll0EHZxQgzn/eOcg8fXpMf+kZ0iK+nwEOVk5
         K/J7R5aEZKHATTA/DcEmA6kqZOD/SS/jucX63FW5ijghtwoieLFdiUbgquXFqKhdWR4o
         ik1rI643xAhZ/W+Hmoe6prKYyalpCgBxdGylaXqJtC4O5i756Q6+FAfmGHYI74K1X9ds
         Urlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746638249; x=1747243049;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gI4QKXUUocncAo9i7q/ORGKfmfoKemGxoAEm5JcoIpM=;
        b=CDDgKke9ucx3OYLloq2vBkUgQbmDwgo9Vua5TLcwolyle+yjHqGPaOc/1BshIXx00z
         2EymL6il9NIuMmHE4/3XdYhZYlXSxvb7rLOeTcmav6LsBaVkQAIIkEwX4dlHQ5yXYAfl
         nr30s81QTYGzP/yrUk299h5y/wa50anBaPT11rwAosOw4ICEe10YW3bZcHAPhGPbs+69
         C96tkkuUkT3rqvU2of0qd7JskZWCluTJO+5Eg4t9LnbjD8P45CgGJJqIu7666t7IWyTX
         RxSbFYP9os0BeFzcGHIcMLEex3gjqpcZYrq2JIcmMu8mAJeEsfbfNp8Eq4pvePXfxOb4
         5ShQ==
X-Gm-Message-State: AOJu0YwBmAHDmzGZIjwjfg4rbrY49ROGZhSluhqDRDAsRnUXMEVEG270
	w2a2K8ZA+IurvbtSVOnJsk9SU6/eaYaakm4Qlq1yQdA87Lr/aP7Hq+DAYpEgcZE=
X-Gm-Gg: ASbGncs054+8EbazGtqnMV+vKMJ0I3Efr3wQ2iX/PtYhmjOwlYUB/k1aFy8mDvvX5wV
	XkqLgUt/cpdAKLgXjs2yga0ROM15h/Xf9tuM0P36EXAS18/dRAtdSASmW+jhWcph03k+Zv1wz4s
	V5TC4+hjm813cHmOPxtkQpgECIS/4T8iXGoTO3hjwsfVzHlXAX1PrZ1fNh2NKRefIWIiBkllAi4
	6v97Ua7FJPTiMbzsCGWFDvs7x2bcf/5CYbEVu6WMTll3HROJnBgqMxIg6Vl9mOen/W930GpFvIx
	tgMCOF2lIDiI19XGThgzQoILJzgxHkw=
X-Google-Smtp-Source: AGHT+IEfqTMX6dcKcZMLI6OCgjgv1qp4cre1IZ+tgMiFhCPQyHAEOZqoR4XJ9F3TzWIkFp+kKytxaA==
X-Received: by 2002:a05:6000:1a8b:b0:391:23de:b19a with SMTP id ffacd0b85a97d-3a0b49d7260mr4196343f8f.31.1746638249029;
        Wed, 07 May 2025 10:17:29 -0700 (PDT)
Received: from localhost ([2a03:2880:31ff:73::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a0b1f2ca58sm5154515f8f.75.2025.05.07.10.17.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 May 2025 10:17:28 -0700 (PDT)
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
Subject: [PATCH bpf-next v1 05/11] bpf: Add dump_stack() analogue to print to BPF stderr
Date: Wed,  7 May 2025 10:17:14 -0700
Message-ID: <20250507171720.1958296-6-memxor@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250507171720.1958296-1-memxor@gmail.com>
References: <20250507171720.1958296-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3179; h=from:subject; bh=dn8iSnhuMUC0jQICfSTbBLfwxRKe8jf2kccQZiCBZnU=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBoG5WJIodMWHpc8GumqVhDpW72JlOkSNDibykGPoY4 AHYGdOqJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCaBuViQAKCRBM4MiGSL8RygjsD/ 9gIITfxYNYJ5sq8LGcvwrpxb6pDHr7lDkx8Do7oYZQwAzd9wT5p75nShhhOmfWy2/BNkE7/ujlwCVo n6n+fz9H9DSghKWp4SC0D3CwzqO4v63gT7CrHZu4xByLUCTVMmjaLsYNTdYAQEpS4vaBgCSSlYySzZ +caKrTe0t2dC9/XpYnZKYIDiijsig1UWEdu4my5lCo+vKESDRYmiHLp1c4aV/hP9My5+7cOzKdJVpb 1AiJqTE80bJbX8n0QLZfj1MIBNsFi/TBT1FOTFUhFAFIugnOyhSpYS+JHHNx8auEL8Mb7EHx0Hk1yD 7GDgzHtTOgYMHa4lUKlwPQpflo1gCke7uO2c6RzKDeQFK6fasyyxoAl7EbzvCbSgbbHzlqyv9XxKk0 KoYRZmTP3itIHhlPLGVxJ54cYD+DD+PLx4+cne0wfkwgSyHrwPaqjogN/xQSEz0AqPw6vOmmOjHrZr lao/jPHUc6R5A7yyMCUmWhUMxXBZ/4HfVUNWZtqjUvHObBxlt+pwtuHbdumo3/oxNnHRzRIQ2p9wSe 9qHdVEvHRFEvvHh/qB1Z8ZARdL5BFrzI0csYaN4Xyx8cGtsKVfHxxfTGrISriV1Hb70bJ7Aii4VPCO KFGqWlx1KiJCbF93h2NrXxJ//0Ou5x4bx4o3mx2JaVYr4FcxWjT567uMt84w==
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
index b57d8a1a7758..46ce05aad0ed 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -3598,8 +3598,10 @@ __printf(2, 3)
 int bpf_stream_stage_printk(struct bpf_stream_stage *ss, const char *fmt, ...);
 int bpf_stream_stage_commit(struct bpf_stream_stage *ss, struct bpf_prog *prog,
 			    enum bpf_stream_id stream_id);
+int bpf_stream_stage_dump_stack(struct bpf_stream_stage *ss);
 
 #define bpf_stream_printk(...) bpf_stream_stage_printk(&__ss, __VA_ARGS__)
+#define bpf_stream_dump_stack() bpf_stream_stage_dump_stack(&__ss)
 
 #define bpf_stream_stage(prog, stream_id, expr)                  \
 	({                                                       \
diff --git a/kernel/bpf/stream.c b/kernel/bpf/stream.c
index a9151a8575ec..a921fb1de319 100644
--- a/kernel/bpf/stream.c
+++ b/kernel/bpf/stream.c
@@ -2,6 +2,7 @@
 /* Copyright (c) 2025 Meta Platforms, Inc. and affiliates. */
 
 #include <linux/bpf.h>
+#include <linux/filter.h>
 #include <linux/bpf_mem_alloc.h>
 #include <linux/percpu.h>
 #include <linux/refcount.h>
@@ -497,3 +498,44 @@ int bpf_stream_stage_commit(struct bpf_stream_stage *ss, struct bpf_prog *prog,
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
+		if (num == -1)
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


