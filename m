Return-Path: <bpf+bounces-79334-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 164E3D38758
	for <lists+bpf@lfdr.de>; Fri, 16 Jan 2026 21:23:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6FFEE302519F
	for <lists+bpf@lfdr.de>; Fri, 16 Jan 2026 20:19:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3F763A4F22;
	Fri, 16 Jan 2026 20:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ZwkMpbBn"
X-Original-To: bpf@vger.kernel.org
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 622C43A7DF6
	for <bpf@vger.kernel.org>; Fri, 16 Jan 2026 20:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768594696; cv=none; b=M4Bb41Fc53cHLa8nW8PVG95F6BgbMT6velQ08Wyi5kjFYqMzX5zwmPwksiQc/CDnuZBXyyXehaK0X2MYogYt2l1qR1k/FzEksq99Lbadbh9axW7PZrrgU2RF68LmerWLUVsuccIebNOUjyBUjeuCl9Yol0xrpZnwRCbRdfDBT+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768594696; c=relaxed/simple;
	bh=SOOi4rOIWX7qVSczijt4jM7tUhPVgb2G3KcVk24vLOI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WAwTxZPhebv7CGAPvXFqxoGtY7p/MxYQBJZ/3PNL5Vn52ADj//8xTGVOTr37i4FsMmSL4aYypOmpSEu+4bW2pCiElKSvCsMINlL25TBMulG3/z3cQndlcW2VwP9dz9HxPqKpEF96a59UHryLZRH6QdTSigWhgHLs1czviGWBER0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ZwkMpbBn; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1768594690;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sHo+aZoQ4zp2IRNGFxshxVMXOU+lbImEhL/LWgCBgH4=;
	b=ZwkMpbBnal/zOGsfhex4Vd4jLUBoHQ0avYQT5n+Yr/LO/Awb+dRctlOQHikjJq0KO9tWjA
	FlIrCM1SSRWDyKn9dCWSc3DpRULP+TwiBq7eTyhGPXkzadJY+wa9G7cMVH0hBBfbaj9761
	57nmcEVNtAKdBQbqcQMb0pO3zD0rbKI=
From: Ihor Solodrai <ihor.solodrai@linux.dev>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>
Cc: Mykyta Yatsenko <yatsenko@meta.com>,
	Tejun Heo <tj@kernel.org>,
	Alan Maguire <alan.maguire@oracle.com>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Jiri Kosina <jikos@kernel.org>,
	Amery Hung <ameryhung@gmail.com>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-input@vger.kernel.org,
	sched-ext@lists.linux.dev
Subject: [PATCH bpf-next v2 10/13] bpf: Migrate bpf_stream_vprintk() to KF_IMPLICIT_ARGS
Date: Fri, 16 Jan 2026 12:16:57 -0800
Message-ID: <20260116201700.864797-11-ihor.solodrai@linux.dev>
In-Reply-To: <20260116201700.864797-1-ihor.solodrai@linux.dev>
References: <20260116201700.864797-1-ihor.solodrai@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Implement bpf_stream_vprintk with an implicit bpf_prog_aux argument,
and remote bpf_stream_vprintk_impl from the kernel.

Update the selftests to use the new API with implicit argument.

bpf_stream_vprintk macro is changed to use the new bpf_stream_vprintk
kfunc, and the extern definition of bpf_stream_vprintk_impl is
replaced accordingly.

Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
---
 kernel/bpf/helpers.c                            | 2 +-
 kernel/bpf/stream.c                             | 5 ++---
 tools/lib/bpf/bpf_helpers.h                     | 6 +++---
 tools/testing/selftests/bpf/progs/stream_fail.c | 6 +++---
 4 files changed, 9 insertions(+), 10 deletions(-)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index f2f974b5fb3b..f8aa1320e2f7 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -4533,7 +4533,7 @@ BTF_ID_FLAGS(func, bpf_strncasestr);
 #if defined(CONFIG_BPF_LSM) && defined(CONFIG_CGROUPS)
 BTF_ID_FLAGS(func, bpf_cgroup_read_xattr, KF_RCU)
 #endif
-BTF_ID_FLAGS(func, bpf_stream_vprintk_impl)
+BTF_ID_FLAGS(func, bpf_stream_vprintk, KF_IMPLICIT_ARGS)
 BTF_ID_FLAGS(func, bpf_task_work_schedule_signal, KF_IMPLICIT_ARGS)
 BTF_ID_FLAGS(func, bpf_task_work_schedule_resume, KF_IMPLICIT_ARGS)
 BTF_ID_FLAGS(func, bpf_dynptr_from_file)
diff --git a/kernel/bpf/stream.c b/kernel/bpf/stream.c
index 0b6bc3f30335..24730df55e69 100644
--- a/kernel/bpf/stream.c
+++ b/kernel/bpf/stream.c
@@ -212,14 +212,13 @@ __bpf_kfunc_start_defs();
  * Avoid using enum bpf_stream_id so that kfunc users don't have to pull in the
  * enum in headers.
  */
-__bpf_kfunc int bpf_stream_vprintk_impl(int stream_id, const char *fmt__str, const void *args,
-					u32 len__sz, void *aux__prog)
+__bpf_kfunc int bpf_stream_vprintk(int stream_id, const char *fmt__str, const void *args,
+				   u32 len__sz, struct bpf_prog_aux *aux)
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
index d4e4e388e625..c145da05a67c 100644
--- a/tools/lib/bpf/bpf_helpers.h
+++ b/tools/lib/bpf/bpf_helpers.h
@@ -315,8 +315,8 @@ enum libbpf_tristate {
 			  ___param, sizeof(___param));		\
 })
 
-extern int bpf_stream_vprintk_impl(int stream_id, const char *fmt__str, const void *args,
-				   __u32 len__sz, void *aux__prog) __weak __ksym;
+extern int bpf_stream_vprintk(int stream_id, const char *fmt__str, const void *args,
+			      __u32 len__sz) __weak __ksym;
 
 #define bpf_stream_printk(stream_id, fmt, args...)					\
 ({											\
@@ -328,7 +328,7 @@ extern int bpf_stream_vprintk_impl(int stream_id, const char *fmt__str, const vo
 	___bpf_fill(___param, args);							\
 	_Pragma("GCC diagnostic pop")							\
 											\
-	bpf_stream_vprintk_impl(stream_id, ___fmt, ___param, sizeof(___param), NULL);	\
+	bpf_stream_vprintk(stream_id, ___fmt, ___param, sizeof(___param));		\
 })
 
 /* Use __bpf_printk when bpf_printk call has 3 or fewer fmt args
diff --git a/tools/testing/selftests/bpf/progs/stream_fail.c b/tools/testing/selftests/bpf/progs/stream_fail.c
index 3662515f0107..8e8249f3521c 100644
--- a/tools/testing/selftests/bpf/progs/stream_fail.c
+++ b/tools/testing/selftests/bpf/progs/stream_fail.c
@@ -10,7 +10,7 @@ SEC("syscall")
 __failure __msg("Possibly NULL pointer passed")
 int stream_vprintk_null_arg(void *ctx)
 {
-	bpf_stream_vprintk_impl(BPF_STDOUT, "", NULL, 0, NULL);
+	bpf_stream_vprintk(BPF_STDOUT, "", NULL, 0);
 	return 0;
 }
 
@@ -18,7 +18,7 @@ SEC("syscall")
 __failure __msg("R3 type=scalar expected=")
 int stream_vprintk_scalar_arg(void *ctx)
 {
-	bpf_stream_vprintk_impl(BPF_STDOUT, "", (void *)46, 0, NULL);
+	bpf_stream_vprintk(BPF_STDOUT, "", (void *)46, 0);
 	return 0;
 }
 
@@ -26,7 +26,7 @@ SEC("syscall")
 __failure __msg("arg#1 doesn't point to a const string")
 int stream_vprintk_string_arg(void *ctx)
 {
-	bpf_stream_vprintk_impl(BPF_STDOUT, ctx, NULL, 0, NULL);
+	bpf_stream_vprintk(BPF_STDOUT, ctx, NULL, 0);
 	return 0;
 }
 
-- 
2.52.0


