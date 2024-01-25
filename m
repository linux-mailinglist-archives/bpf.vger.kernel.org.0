Return-Path: <bpf+bounces-20344-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E96983CDDB
	for <lists+bpf@lfdr.de>; Thu, 25 Jan 2024 21:55:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 96490B249A1
	for <lists+bpf@lfdr.de>; Thu, 25 Jan 2024 20:55:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B9231386B9;
	Thu, 25 Jan 2024 20:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KzNEdxy7"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E90921386AE
	for <bpf@vger.kernel.org>; Thu, 25 Jan 2024 20:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706216119; cv=none; b=YQLL1zIN9VOK827ZoJ1D/L0KU12MYnE1OWfZh4CjLvHBESN/jkc8JQvnV2FMipi1kq4VCmfTNwCRTt2Lt2N9kJ+ThukCUoo3iMzce/4dkwktJTOP6ihCjOVePVaOYAQvcKkTvGNXWl/hYp/RQ+qKJZ87UgU2m9EPXKjXDS8HSOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706216119; c=relaxed/simple;
	bh=kuGGSunZfxT48sR2grhWCpq5weuMKAoE2+yTmvT8KGc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TQvpu0lIMpdkyym8rgiY0cbx73ofLMLvx4LDykrcaNqJUe6goVDHm2xB0g1N4rnQ/ZRrIzU8k4VZV01pQs+CA6lCR6FbiQS+Nz0io7ixXKdmNU/X9FWac3UZ/9NSnqO5FFXCS40Jc0FgQ+WhmBtwGpjfzIiRFc6hqVFRtvq0u1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KzNEdxy7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96DC6C433F1;
	Thu, 25 Jan 2024 20:55:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706216118;
	bh=kuGGSunZfxT48sR2grhWCpq5weuMKAoE2+yTmvT8KGc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KzNEdxy7prooCaa0ZsS7ETKAs6hg4AkLjHSLTE4BQDQvX6MExXl3AcOw8kIURh1JU
	 R0o+wYpuIczsubuNs5sJAcq3OD3bHUbeHsggB3rBXhL3xpTyqua37nzNNlle0JoPCZ
	 8jDat3G0Flb45ra3bk5odelt1+QF+ueRIgwXPYSz6GeT+wPxEJ+xo+KUmb278CgK2u
	 MMstY9FzIBuw5RNTDzGUpxnfUODnbLd8ELV8bUePlLQpiy2NeDlwCqFIE8+eM/9v5C
	 gcQFr23/qfl4dH67d3dS2mzKpSyVg5DmeG69s/rOW8YB4j2f1yuW9MxzSYq5UDZio8
	 gQSwvIq8aKwKQ==
From: Andrii Nakryiko <andrii@kernel.org>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@kernel.org
Cc: andrii@kernel.org,
	kernel-team@meta.com
Subject: [PATCH v2 bpf-next 2/7] libbpf: fix __arg_ctx type enforcement for perf_event programs
Date: Thu, 25 Jan 2024 12:55:05 -0800
Message-Id: <20240125205510.3642094-3-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240125205510.3642094-1-andrii@kernel.org>
References: <20240125205510.3642094-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adjust PERF_EVENT type enforcement around __arg_ctx to match exactly
what kernel is doing.

Fixes: 76ec90a996e3 ("libbpf: warn on unexpected __arg_ctx type when rewriting BTF")
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/libbpf.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 41ab7a21f868..db65ea59a05a 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -33,6 +33,7 @@
 #include <linux/filter.h>
 #include <linux/limits.h>
 #include <linux/perf_event.h>
+#include <linux/bpf_perf_event.h>
 #include <linux/ring_buffer.h>
 #include <sys/epoll.h>
 #include <sys/ioctl.h>
@@ -6339,6 +6340,14 @@ static struct {
 	/* all other program types don't have "named" context structs */
 };
 
+/* forward declarations for arch-specific underlying types of bpf_user_pt_regs_t typedef,
+ * for below __builtin_types_compatible_p() checks;
+ * with this approach we don't need any extra arch-specific #ifdef guards
+ */
+struct pt_regs;
+struct user_pt_regs;
+struct user_regs_struct;
+
 static bool need_func_arg_type_fixup(const struct btf *btf, const struct bpf_program *prog,
 				     const char *subprog_name, int arg_idx,
 				     int arg_type_id, const char *ctx_name)
@@ -6379,11 +6388,21 @@ static bool need_func_arg_type_fixup(const struct btf *btf, const struct bpf_pro
 	/* special cases */
 	switch (prog->type) {
 	case BPF_PROG_TYPE_KPROBE:
-	case BPF_PROG_TYPE_PERF_EVENT:
 		/* `struct pt_regs *` is expected, but we need to fix up */
 		if (btf_is_struct(t) && strcmp(tname, "pt_regs") == 0)
 			return true;
 		break;
+	case BPF_PROG_TYPE_PERF_EVENT:
+		if (__builtin_types_compatible_p(bpf_user_pt_regs_t, struct pt_regs) &&
+		    btf_is_struct(t) && strcmp(tname, "pt_regs") == 0)
+			return 0;
+		if (__builtin_types_compatible_p(bpf_user_pt_regs_t, struct user_pt_regs) &&
+		    btf_is_struct(t) && strcmp(tname, "user_pt_regs") == 0)
+			return 0;
+		if (__builtin_types_compatible_p(bpf_user_pt_regs_t, struct user_regs_struct) &&
+		    btf_is_struct(t) && strcmp(tname, "user_regs_struct") == 0)
+			return 0;
+		break;
 	case BPF_PROG_TYPE_RAW_TRACEPOINT:
 	case BPF_PROG_TYPE_RAW_TRACEPOINT_WRITABLE:
 		/* allow u64* as ctx */
-- 
2.34.1


