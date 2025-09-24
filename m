Return-Path: <bpf+bounces-69626-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DAB2B9C429
	for <lists+bpf@lfdr.de>; Wed, 24 Sep 2025 23:18:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3FA841BC36E7
	for <lists+bpf@lfdr.de>; Wed, 24 Sep 2025 21:18:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33936287269;
	Wed, 24 Sep 2025 21:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Ezy9HIA1"
X-Original-To: bpf@vger.kernel.org
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2F0F2853EE
	for <bpf@vger.kernel.org>; Wed, 24 Sep 2025 21:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758748674; cv=none; b=S1DhUZBW9KSW3HVJ7ZZyUoRfTNUSoIRJXYEsnrrk+90GjF31Rmi6vDAVOa0JRZu7AWHw9l5lH9A9GkK3bqVP23VcQctAt4j44xN/f6UCh/bnpQv4nXX7eonyKaxGWcEGDQTMXmdrIEIQcLbx6hKG4O3aSu/m+Gz3D/msBW3RMWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758748674; c=relaxed/simple;
	bh=noLGBk3BobGgXM+g4xcjyFpRhI9H1sdfcf5mxz8vs6M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A1hoJXcojp1q+FFl3nFZeuRXaZ7dgFwNAVtR4NDLqrfyu02hORtRKAls3dKJhVMXnvsgweKrxJ+yD/tR4f/g3EdndTPr+1iX6It/JBmvAHkZIzBjCttf641SY4Asr2OjRA0dN5Dq4+DqLxe6o5BzZIe7JkWFiG1XnXPK8aFjdwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Ezy9HIA1; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1758748671;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=s02gFHLfNdqb4+6D2XqszlhW7FFJXOgoVuG5bmEz1U8=;
	b=Ezy9HIA18WnvMBFjyL4Yyt1Econ6LJmEEawQv+G2nZstJTVNu4oK/Y5f4hGlGKVQoPp/5T
	lLAHqXidwlh0hCA336O25Y2yy/xYoo0cSNABs5cQYgnau3zZqw3HlOWkB5m6iYsmhnkO60
	O6z5pyvjcYezaAN2YVIophFdKeXiweM=
From: Ihor Solodrai <ihor.solodrai@linux.dev>
To: bpf@vger.kernel.org,
	andrii@kernel.org,
	ast@kernel.org
Cc: dwarves@vger.kernel.org,
	alan.maguire@oracle.com,
	acme@kernel.org,
	eddyz87@gmail.com,
	tj@kernel.org,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 5/6] bpf: mark bpf_stream_vprink kfunc with KF_IMPLICIT_PROG_AUX_ARG
Date: Wed, 24 Sep 2025 14:17:15 -0700
Message-ID: <20250924211716.1287715-6-ihor.solodrai@linux.dev>
In-Reply-To: <20250924211716.1287715-1-ihor.solodrai@linux.dev>
References: <20250924211716.1287715-1-ihor.solodrai@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Update bpf_stream_vprink macro in libbpf and fix call sites in
the relevant selftests.

Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
---
 kernel/bpf/helpers.c                            | 2 +-
 kernel/bpf/stream.c                             | 3 +--
 tools/lib/bpf/bpf_helpers.h                     | 4 ++--
 tools/testing/selftests/bpf/progs/stream_fail.c | 6 +++---
 4 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 6b46acfec790..875195a0ea72 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -4378,7 +4378,7 @@ BTF_ID_FLAGS(func, bpf_strnstr);
 #if defined(CONFIG_BPF_LSM) && defined(CONFIG_CGROUPS)
 BTF_ID_FLAGS(func, bpf_cgroup_read_xattr, KF_RCU)
 #endif
-BTF_ID_FLAGS(func, bpf_stream_vprintk, KF_TRUSTED_ARGS)
+BTF_ID_FLAGS(func, bpf_stream_vprintk, KF_TRUSTED_ARGS | KF_IMPLICIT_PROG_AUX_ARG)
 BTF_ID_FLAGS(func, bpf_task_work_schedule_signal, KF_TRUSTED_ARGS)
 BTF_ID_FLAGS(func, bpf_task_work_schedule_resume, KF_TRUSTED_ARGS)
 BTF_ID_FLAGS(func, bpf_wq_set_callback, KF_IMPLICIT_PROG_AUX_ARG)
diff --git a/kernel/bpf/stream.c b/kernel/bpf/stream.c
index ab592db4a4bf..0c75d0a8cea2 100644
--- a/kernel/bpf/stream.c
+++ b/kernel/bpf/stream.c
@@ -355,13 +355,12 @@ __bpf_kfunc_start_defs();
  * Avoid using enum bpf_stream_id so that kfunc users don't have to pull in the
  * enum in headers.
  */
-__bpf_kfunc int bpf_stream_vprintk(int stream_id, const char *fmt__str, const void *args, u32 len__sz, void *aux__prog)
+__bpf_kfunc int bpf_stream_vprintk(int stream_id, const char *fmt__str, const void *args, u32 len__sz, struct bpf_prog_aux *aux)
 {
 	struct bpf_bprintf_data data = {
 		.get_bin_args	= true,
 		.get_buf	= true,
 	};
-	struct bpf_prog_aux *aux = aux__prog;
 	u32 fmt_size = strlen(fmt__str) + 1;
 	struct bpf_stream *stream;
 	u32 data_len = len__sz;
diff --git a/tools/lib/bpf/bpf_helpers.h b/tools/lib/bpf/bpf_helpers.h
index 80c028540656..9a6d719315a3 100644
--- a/tools/lib/bpf/bpf_helpers.h
+++ b/tools/lib/bpf/bpf_helpers.h
@@ -316,7 +316,7 @@ enum libbpf_tristate {
 })
 
 extern int bpf_stream_vprintk(int stream_id, const char *fmt__str, const void *args,
-			      __u32 len__sz, void *aux__prog) __weak __ksym;
+			      __u32 len__sz) __weak __ksym;
 
 #define bpf_stream_printk(stream_id, fmt, args...)				\
 ({										\
@@ -328,7 +328,7 @@ extern int bpf_stream_vprintk(int stream_id, const char *fmt__str, const void *a
 	___bpf_fill(___param, args);						\
 	_Pragma("GCC diagnostic pop")						\
 										\
-	bpf_stream_vprintk(stream_id, ___fmt, ___param, sizeof(___param), NULL);\
+	bpf_stream_vprintk(stream_id, ___fmt, ___param, sizeof(___param));\
 })
 
 /* Use __bpf_printk when bpf_printk call has 3 or fewer fmt args
diff --git a/tools/testing/selftests/bpf/progs/stream_fail.c b/tools/testing/selftests/bpf/progs/stream_fail.c
index b4a0d0cc8ec8..8e8249f3521c 100644
--- a/tools/testing/selftests/bpf/progs/stream_fail.c
+++ b/tools/testing/selftests/bpf/progs/stream_fail.c
@@ -10,7 +10,7 @@ SEC("syscall")
 __failure __msg("Possibly NULL pointer passed")
 int stream_vprintk_null_arg(void *ctx)
 {
-	bpf_stream_vprintk(BPF_STDOUT, "", NULL, 0, NULL);
+	bpf_stream_vprintk(BPF_STDOUT, "", NULL, 0);
 	return 0;
 }
 
@@ -18,7 +18,7 @@ SEC("syscall")
 __failure __msg("R3 type=scalar expected=")
 int stream_vprintk_scalar_arg(void *ctx)
 {
-	bpf_stream_vprintk(BPF_STDOUT, "", (void *)46, 0, NULL);
+	bpf_stream_vprintk(BPF_STDOUT, "", (void *)46, 0);
 	return 0;
 }
 
@@ -26,7 +26,7 @@ SEC("syscall")
 __failure __msg("arg#1 doesn't point to a const string")
 int stream_vprintk_string_arg(void *ctx)
 {
-	bpf_stream_vprintk(BPF_STDOUT, ctx, NULL, 0, NULL);
+	bpf_stream_vprintk(BPF_STDOUT, ctx, NULL, 0);
 	return 0;
 }
 
-- 
2.51.0


