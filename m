Return-Path: <bpf+bounces-21661-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 78DA585009A
	for <lists+bpf@lfdr.de>; Sat, 10 Feb 2024 00:09:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3B0A1B20AB7
	for <lists+bpf@lfdr.de>; Fri,  9 Feb 2024 23:09:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90B5A374C1;
	Fri,  9 Feb 2024 23:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Go+54p0M"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1657D1E4AD
	for <bpf@vger.kernel.org>; Fri,  9 Feb 2024 23:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707520156; cv=none; b=IgyTc+b9t0aGDHTaAravFWSVjOhpdJjUJGPZJ4W5BzdqJu84m7xpZUtMmt2Rf6uO4jHwkDDMaKBIkxu7+t4fboKWXB6DjmDvq3ZSt6deSiFvSPJfu7m5pyBAJx6t1+/55u5oix8Kp3+LG0HdUsdF2Aj3C61atiVHyNYU8iMUIj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707520156; c=relaxed/simple;
	bh=pQ43CjuavD2cJf3e3059LzfMFrFofhdI3oUP5Lw5Fjk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UfGwVc1BJdd8BXBnwvWv0X1ydfHZl7VLzshjb+azEZzyw6YcW3DYDadGZksqs/URcc+U6hsTFZuh4oJz+rYBGjROxD9YTPac5xEJRgU+wsni3bEBs+e6oYvz/I03eHX1/vgITaQO/qVAWxqCLSoIIWiy2D9mPpISGE3A23wGRCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Go+54p0M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54866C433F1;
	Fri,  9 Feb 2024 23:09:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707520155;
	bh=pQ43CjuavD2cJf3e3059LzfMFrFofhdI3oUP5Lw5Fjk=;
	h=From:To:Cc:Subject:Date:From;
	b=Go+54p0Mhnp93tbYSdGPSIa6Zy/uy619cP2XOsLKgDvhgrfqZqGcxL6L/7UMqf+lh
	 zMVKX0OLIgFZ8NCFD2C0Znqn8HyD4Xqi2XLYJjjV0V37OM9SrMJtSVpyyFpL9JYEXi
	 2dk0rXIp+qXRCEKJN/TWJbX+5y/0DttoPK9s8rgcxWBehrfcEkmrTmNulKPu1Sp9v8
	 QpNfe/+C/abW2V/kyyDRhHSGecip4cEB7bWnLI71B36V7/5qE7iGQ66asBSVpvxtoP
	 Hla901US9AHgPqvmiNUt1g+YkCAxFN8ljqFmMxrOSb2BOLgftTG+058WyGKd/EWexb
	 vjpzxTWIAPSAw==
From: Andrii Nakryiko <andrii@kernel.org>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@kernel.org
Cc: andrii@kernel.org,
	kernel-team@meta.com
Subject: [PATCH bpf-next 1/2] bpf: don't infer PTR_TO_CTX for programs with unnamed context type
Date: Fri,  9 Feb 2024 15:09:07 -0800
Message-Id: <20240209230908.2380782-1-andrii@kernel.org>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For program types that don't have named context type name (e.g., BPF
iterator programs or tracepoint programs), ctx_tname will be a non-NULL
empty string. For such programs it shouldn't be possible to have
PTR_TO_CTX argument for global subprogs based on type name alone.
arg:ctx tag is the only way to have PTR_TO_CTX passed into global
subprog for such program types.

Fix this loop hole, which currently would assume PTR_TO_CTX whenever
user uses a pointer to anonymous struct as an argument to their global
subprogs. This happens in practice with the following (quite common, in
practice) approach:

typedef struct { /* anonymous */
    int x;
} my_type_t;

int my_subprog(my_type_t *arg) { ... }

User's intent is to have PTR_TO_MEM argument for `arg`, but verifier
will complain about expecting PTR_TO_CTX.

Fixes: 91cc1a99740e ("bpf: Annotate context types")
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 kernel/bpf/btf.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 8e06d29961f1..d6021290caba 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -5725,6 +5725,9 @@ btf_get_prog_ctx_type(struct bpf_verifier_log *log, const struct btf *btf,
 		bpf_log(log, "Please fix kernel include/linux/bpf_types.h\n");
 		return NULL;
 	}
+	/* program types without named context types work only with arg:ctx tag */
+	if (ctx_tname[0] == '\0')
+		return NULL;
 	/* only compare that prog's ctx type name is the same as
 	 * kernel expects. No need to compare field by field.
 	 * It's ok for bpf prog to do:
-- 
2.39.3


