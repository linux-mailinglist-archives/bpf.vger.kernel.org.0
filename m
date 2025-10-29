Return-Path: <bpf+bounces-72862-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CF5EFC1CDF7
	for <lists+bpf@lfdr.de>; Wed, 29 Oct 2025 20:04:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E6D47189F749
	for <lists+bpf@lfdr.de>; Wed, 29 Oct 2025 19:02:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC830305E37;
	Wed, 29 Oct 2025 19:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="WEXXhs2N"
X-Original-To: bpf@vger.kernel.org
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D45730ACEE
	for <bpf@vger.kernel.org>; Wed, 29 Oct 2025 19:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761764527; cv=none; b=ZFjwi9L/Sx7JeGRaXpHvoizy30rxd+uoFWp2L0wEf16MIhVjqRagje/gD7Ix52UHuBarGdOz42WwrsGyOccehjhhtmWJffXscEe8/0Z3xNBGQ+ewEdzfBMVlm/4Hsl46HFuZrM8j5zvY4OlkOJHlUeUXE1vKV5IIwxxmbMxBdws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761764527; c=relaxed/simple;
	bh=+cfF8XX/bxfL82Vlx4/ROctJ0dx8I0zMgw0B7/LyM+U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XaB7xlu8h26rqwfmxQOxNjqkgjZ4biwklYnwICU59Kc1ikDGkzs5W66XNB4TVV0XSu50M8j2UjU0HQeAxeJmTkTQpeEKLqYRhGx24HABtWyzFnwTiTJmW+fuySel9qv2AaAkxn6y9iJDP8GDB3IRqT1DNZrLisqO/A4eB+75tS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=WEXXhs2N; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761764523;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rXgVH6QjgXn26652DuWFdukY1DvvPqCqcY1iYEv50I4=;
	b=WEXXhs2NG7TDDyB4/34kKprzALLV60InYoA70TucUIpPcNgUXMQrD/Y5K/735MAPHKARtc
	2EPuq5SQH0iMHkMWgpa7iYDi3ttoypwZAyr+68K/Kt7tGcCHUNtD3RmH2o/2HwGtz+al4D
	ihNmDn/xFWWKUQarlV6lPVvxDhknAlA=
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
Subject: [PATCH bpf-next v1 8/8] bpf: Re-define bpf_stream_vprintk as a magic kfunc
Date: Wed, 29 Oct 2025 12:01:13 -0700
Message-ID: <20251029190113.3323406-9-ihor.solodrai@linux.dev>
In-Reply-To: <20251029190113.3323406-1-ihor.solodrai@linux.dev>
References: <20251029190113.3323406-1-ihor.solodrai@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

* void *aux__prog => struct bpf_prog_aux *aux__magic
* Set KF_MAGIC_ARGS flag
* Add relevant symbols to magic_kfuncs list
* Update selftests to use the new signature

bpf_stream_vprintk macro is changed to use bpf_stream_vprintk_impl,
and the extern definition of bpf_stream_vprintk is replaced with _impl
version in bpf_helpers.h

This should help with backwards compatibility, as the API of
bpf_stream_vprintk macro hasn't changed.

Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
---
 kernel/bpf/helpers.c                            | 2 +-
 kernel/bpf/stream.c                             | 9 ++++++---
 kernel/bpf/verifier.c                           | 2 ++
 tools/lib/bpf/bpf_helpers.h                     | 7 ++++---
 tools/testing/selftests/bpf/progs/stream_fail.c | 6 +++---
 5 files changed, 16 insertions(+), 10 deletions(-)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 6a095796433a..418c6b31ccc6 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -4528,7 +4528,7 @@ BTF_ID_FLAGS(func, bpf_strncasestr);
 #if defined(CONFIG_BPF_LSM) && defined(CONFIG_CGROUPS)
 BTF_ID_FLAGS(func, bpf_cgroup_read_xattr, KF_RCU)
 #endif
-BTF_ID_FLAGS(func, bpf_stream_vprintk, KF_TRUSTED_ARGS)
+BTF_ID_FLAGS(func, bpf_stream_vprintk, KF_MAGIC_ARGS | KF_TRUSTED_ARGS)
 BTF_ID_FLAGS(func, bpf_task_work_schedule_signal, KF_MAGIC_ARGS | KF_TRUSTED_ARGS)
 BTF_ID_FLAGS(func, bpf_task_work_schedule_resume, KF_MAGIC_ARGS | KF_TRUSTED_ARGS)
 BTF_ID_FLAGS(func, bpf_dynptr_from_file, KF_TRUSTED_ARGS)
diff --git a/kernel/bpf/stream.c b/kernel/bpf/stream.c
index eb6c5a21c2ef..1a129fff765e 100644
--- a/kernel/bpf/stream.c
+++ b/kernel/bpf/stream.c
@@ -355,19 +355,22 @@ __bpf_kfunc_start_defs();
  * Avoid using enum bpf_stream_id so that kfunc users don't have to pull in the
  * enum in headers.
  */
-__bpf_kfunc int bpf_stream_vprintk(int stream_id, const char *fmt__str, const void *args, u32 len__sz, void *aux__prog)
+__bpf_kfunc int bpf_stream_vprintk(int stream_id,
+				   const char *fmt__str,
+				   const void *args,
+				   u32 len__sz,
+				   struct bpf_prog_aux *aux__magic)
 {
 	struct bpf_bprintf_data data = {
 		.get_bin_args	= true,
 		.get_buf	= true,
 	};
-	struct bpf_prog_aux *aux = aux__prog;
 	u32 fmt_size = strlen(fmt__str) + 1;
 	struct bpf_stream *stream;
 	u32 data_len = len__sz;
 	int ret, num_args;
 
-	stream = bpf_stream_get(stream_id, aux);
+	stream = bpf_stream_get(stream_id, aux__magic);
 	if (!stream)
 		return -ENOENT;
 
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index ad4af5ddb523..9e38fbee9219 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -3273,6 +3273,8 @@ BTF_ID(func, bpf_task_work_schedule_signal)
 BTF_ID(func, bpf_task_work_schedule_signal_impl)
 BTF_ID(func, bpf_task_work_schedule_resume)
 BTF_ID(func, bpf_task_work_schedule_resume_impl)
+BTF_ID(func, bpf_stream_vprintk)
+BTF_ID(func, bpf_stream_vprintk_impl)
 BTF_ID_LIST_END(magic_kfuncs)
 
 static s32 magic_kfunc_by_impl(s32 impl_func_id)
diff --git a/tools/lib/bpf/bpf_helpers.h b/tools/lib/bpf/bpf_helpers.h
index 80c028540656..f41ca993c6d2 100644
--- a/tools/lib/bpf/bpf_helpers.h
+++ b/tools/lib/bpf/bpf_helpers.h
@@ -315,8 +315,9 @@ enum libbpf_tristate {
 			  ___param, sizeof(___param));		\
 })
 
-extern int bpf_stream_vprintk(int stream_id, const char *fmt__str, const void *args,
-			      __u32 len__sz, void *aux__prog) __weak __ksym;
+struct bpf_prog_aux;
+extern int bpf_stream_vprintk_impl(int stream_id, const char *fmt__str, const void *args,
+				   __u32 len__sz, struct bpf_prog_aux *aux__magic) __weak __ksym;
 
 #define bpf_stream_printk(stream_id, fmt, args...)				\
 ({										\
@@ -328,7 +329,7 @@ extern int bpf_stream_vprintk(int stream_id, const char *fmt__str, const void *a
 	___bpf_fill(___param, args);						\
 	_Pragma("GCC diagnostic pop")						\
 										\
-	bpf_stream_vprintk(stream_id, ___fmt, ___param, sizeof(___param), NULL);\
+	bpf_stream_vprintk_impl(stream_id, ___fmt, ___param, sizeof(___param), NULL);\
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
2.51.1


