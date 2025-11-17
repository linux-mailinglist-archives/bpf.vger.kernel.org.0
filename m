Return-Path: <bpf+bounces-74709-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FB16C62E9C
	for <lists+bpf@lfdr.de>; Mon, 17 Nov 2025 09:36:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5DAB5358A54
	for <lists+bpf@lfdr.de>; Mon, 17 Nov 2025 08:36:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA8D331D725;
	Mon, 17 Nov 2025 08:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nvSC6QfS"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E24D315761;
	Mon, 17 Nov 2025 08:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763368584; cv=none; b=NjyTdD1cGADdfmAhCozVfNmYnxZHQCSsGeu0oz3IYxReLtyoBespN3VKSImhnp3hajK8X4fznAC3DScEcuQGp+hwRcRUJkCKgie4Wc2EcILF/l/iZd2rrp8vvxG3zht9Dep6Nu5F0pCHk5i9yZ0N+j6xyWjyo5MgeFcwlnD7Nko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763368584; c=relaxed/simple;
	bh=/fW2VI+Q5ELsqdimh9dIHYOc08DlUTJ3WRXxBXp4IOo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bYFxsizrDbgxoIJqmhJYp7OTNjf3EQDl6wUDFj0lrtTdGurScLQLtremBHV2WaM2zgwu4Y8QnNCD2yRV7GgFdXrOBJEXqQwcq6c3zXtMRnCGI6nTFMUJDxSNsN8M8j9ADg2T5jdCtb2kGdZVizpXWX0EkyEcSscGX/7Td8uWQS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nvSC6QfS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8C6FC4CEFB;
	Mon, 17 Nov 2025 08:36:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763368584;
	bh=/fW2VI+Q5ELsqdimh9dIHYOc08DlUTJ3WRXxBXp4IOo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nvSC6QfSCfk9EhDMX58bXrXe6cIOzIwC+5ka8HZ1w5++O3ekluAQsKV2ynU3diMmC
	 Ru/EJlm9C8t7A41gv4fOAbAM9KA8FhlsnB0EXMvHjeoeZx/ln1s8ha6JCoGtDamS1x
	 ztB9/lYPbE3eJfx67YNdRXhXQMvOzNP9rbLdFDW4Qw+pZEKr2mauzFVWGNtSWt/xtM
	 J2ya2yj6rjsdT6WNimKvj6cx2GdkB6i9zH3P1gD7v7SP7FGAv0Dogu68eCii0FkiSq
	 OnkoRd8H51REMxZO2E3Nu8HM1UIHq+7mqWvM3YqzJsxkzyYwegANyTs5YGgMaPVE/7
	 IScgVJDLSz+mg==
From: Jiri Olsa <jolsa@kernel.org>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>
Subject: [PATCH bpf-next 2/4] libbpf: Add uprobe syscall feature detection
Date: Mon, 17 Nov 2025 09:35:49 +0100
Message-ID: <20251117083551.517393-3-jolsa@kernel.org>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251117083551.517393-1-jolsa@kernel.org>
References: <20251117083551.517393-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adding uprobe syscall feature detection that will be used
in following changes.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/lib/bpf/features.c        | 22 ++++++++++++++++++++++
 tools/lib/bpf/libbpf_internal.h |  2 ++
 2 files changed, 24 insertions(+)

diff --git a/tools/lib/bpf/features.c b/tools/lib/bpf/features.c
index b842b83e2480..587571c21d2d 100644
--- a/tools/lib/bpf/features.c
+++ b/tools/lib/bpf/features.c
@@ -506,6 +506,25 @@ static int probe_kern_arg_ctx_tag(int token_fd)
 	return probe_fd(prog_fd);
 }
 
+#ifdef __x86_64__
+#ifndef __NR_uprobe
+#define __NR_uprobe 336
+#endif
+static int probe_uprobe_syscall(int token_fd)
+{
+	/*
+	 * When not executed from executed kernel provided trampoline,
+	 * the uprobe syscall returns ENXIO error.
+	 */
+	return syscall(__NR_uprobe) == -1 && errno == ENXIO;
+}
+#else
+static int probe_uprobe_syscall(int token_fd)
+{
+	return 0;
+}
+#endif
+
 typedef int (*feature_probe_fn)(int /* token_fd */);
 
 static struct kern_feature_cache feature_cache;
@@ -581,6 +600,9 @@ static struct kern_feature_desc {
 	[FEAT_BTF_QMARK_DATASEC] = {
 		"BTF DATASEC names starting from '?'", probe_kern_btf_qmark_datasec,
 	},
+	[FEAT_UPROBE_SYSCALL] = {
+		"Kernel supports uprobe syscall", probe_uprobe_syscall,
+	},
 };
 
 bool feat_supported(struct kern_feature_cache *cache, enum kern_feature_id feat_id)
diff --git a/tools/lib/bpf/libbpf_internal.h b/tools/lib/bpf/libbpf_internal.h
index fc59b21b51b5..69aa61c038a9 100644
--- a/tools/lib/bpf/libbpf_internal.h
+++ b/tools/lib/bpf/libbpf_internal.h
@@ -392,6 +392,8 @@ enum kern_feature_id {
 	FEAT_ARG_CTX_TAG,
 	/* Kernel supports '?' at the front of datasec names */
 	FEAT_BTF_QMARK_DATASEC,
+	/* Kernel supports uprobe syscall */
+	FEAT_UPROBE_SYSCALL,
 	__FEAT_CNT,
 };
 
-- 
2.51.1


