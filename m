Return-Path: <bpf+bounces-73518-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A9EC3C334E7
	for <lists+bpf@lfdr.de>; Tue, 04 Nov 2025 23:54:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68DD24260F3
	for <lists+bpf@lfdr.de>; Tue,  4 Nov 2025 22:54:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 552D532D7F7;
	Tue,  4 Nov 2025 22:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VgjHD6QW"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FF3F30CDB5
	for <bpf@vger.kernel.org>; Tue,  4 Nov 2025 22:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762296882; cv=none; b=ukQl24Q458APGVecCVh5ngDP0pHdxKQeDsyzhvvH+qbxESx+VM8rm1jCdZ3CVHL91o5PWuw/CldpM73WesXXzn80fv3a1gvfWOT83fdo5/mUU2wrCd5UoKd4AdS4ZTZfnqXHA7ZFaBn/0Vw2C+wRGQKn34BXSyNv0ihKjLnX+Ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762296882; c=relaxed/simple;
	bh=qMgWG4GCuNmd+1WsKnaJE0uVOYmSrDpiir+h2A6l3Mw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=c8UlHun9ucHGM8Nx4OXRnulO/fKZFOgMuNdAzX70BSbBR5CIsSZUw7CAWnqHGuQip34Tg4QU0icJ4j/JUB+PCchk9ru1OTGiRq/RV34Ge/cayRqkohlVT4XcUr1NTxAph0CdZ15d0vdyUOY2EEuhR/qIPSz4OERsbTYHBCZr880=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VgjHD6QW; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4710665e7deso28584525e9.1
        for <bpf@vger.kernel.org>; Tue, 04 Nov 2025 14:54:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762296879; x=1762901679; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3kmbeH2RZwbtaEa8nUuOBXSbfgM04NJ5gv0IsGeksgc=;
        b=VgjHD6QW6XiYUDD+OHtQ/VipBy3MJGebRfJQw/SpMI/9CuWHDysYkVfmwTur+r2/qq
         XAlxQHSzmCQkgLtLFq/V99r2Cx8zMdIniCZVJteN4a/fpdC1c4LYzW6Ho7DHCzBXkTmo
         joiSoD5XGqT9OhRA21aymHqIqFv/WoCnxTuiREAsmh2rTjaV6MSwRM8Qo47MeJ8R0qkF
         rMdTljS1acObu0xZV5qf7EDEAtGKlcyn88enBqnp781+EUOyzIpHtP6PgnUCp9Va6muH
         XKZTnfi5qJrkh/oFrwji5HKmBRhwoTrcS/xfOz8tbsUmIs96zUlW0kUcpw5bz5g3rxTo
         iOfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762296879; x=1762901679;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3kmbeH2RZwbtaEa8nUuOBXSbfgM04NJ5gv0IsGeksgc=;
        b=Oh/GGeHyb6TQKAQQmySP5As0l+0dKassJmvt3eEw4eHujn2OkOGIanzAw7rEgDZaUY
         vjWb4srqXrqVWH8iWNhErvsAjo+OkR1ui9PuS+tU8r4u4AKUHgiXqCZzOtnKlttLPBR0
         x7yQotcMW9qphCfWXTdHorjQwkRphM7cq//McxdEGvQPh0muLwmlRgvxfHdI9olNyxjv
         7eRetgU9ctz7CU/+mOnnCCftZdkonHvTAGzRVJCa0n0klAJr4kKiuZ7sci2cp9cS63Fv
         fkSZ9M49Nv13udI78fJNqkWcfuZnGopvNDwU2fknv0Ov0PQAMPTbn9skkAYij9lD1bLv
         hl3Q==
X-Gm-Message-State: AOJu0YwZW0nretjQEFvYsSTOPmdxJuverJC9fD7mwH3Dtt7l2xWwKdoK
	Ywn3Fc4cw/1/zMVF9ZY+cOyRGjyiaa5VNwT52Rhu1Gwh1BUnLIs3pLUg
X-Gm-Gg: ASbGncvlFMrEvEnYPtG0CsX3r48UESYx/6rVUDxm1LA5JtM1sIhR1mBJ8fil4VfOrvH
	vUv4jXlK9aSH8apuPEwrLGh8agtkpuPSUcVu3qujUMX9QDoqbfDff1Jf7nJrQEM2LhPufS+BLIm
	+3xhGuSfoTx4lG3R1mnWKr9VwGr1dnHX7BS6vQcspyOYhzxCPji8Dry+7/EwqqVKSAOA1XP3Sah
	rQctkt2AWb5GpRwh8X/J964K3UCfYmRmUxp/FPuS1OLn2QwyJ5Mf5dsPtfBPkPt4Z7GNEW72H3i
	ndSGcGfhMdhVSMMC/LcYbohd0J/9mMVjFHKr1Rh7wYArmcxmhRJp/u6xrb9U5RmYo0EFz+9tix6
	RqOc7/2SJsTh04yNPjUnVC+9ux2WSvAmuK7B9ARuxFvj6i7yl97Vxazz67/bWI7Tn9Vl2ALT1Yh
	OzWquii1AW1axMGw==
X-Google-Smtp-Source: AGHT+IGvGG+WAGbdyGzGy/Gsn7Cfg83myyNRn/0qbi7dYWHLZc1//VUdploP01ssMhR8YfF7N3oFPQ==
X-Received: by 2002:a05:600c:4444:b0:46e:477a:f3dd with SMTP id 5b1f17b1804b1-4775ce2878cmr9076305e9.36.1762296879161;
        Tue, 04 Nov 2025 14:54:39 -0800 (PST)
Received: from localhost ([2a01:4b00:bd1f:f500:e85d:a828:282d:d5c7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4775ce20ee3sm12500095e9.9.2025.11.04.14.54.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 14:54:38 -0800 (PST)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Date: Tue, 04 Nov 2025 22:54:26 +0000
Subject: [PATCH bpf v3 2/2] bpf: add _impl suffix for bpf_stream_vprintk()
 kfunc
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251104-implv2-v3-2-4772b9ae0e06@meta.com>
References: <20251104-implv2-v3-0-4772b9ae0e06@meta.com>
In-Reply-To: <20251104-implv2-v3-0-4772b9ae0e06@meta.com>
To: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762296873; l=5813;
 i=yatsenko@meta.com; s=20251031; h=from:subject:message-id;
 bh=1bmimyNlzQyBSfblqLVJZz5K7LJ+u8vyCiLurPkNjtQ=;
 b=P31MkPnzFOMQsTwvXhdan8oEgQDCWphfbqCm9Zy4qAvkX+upBbRoOU9S32w9KIXntclzL0IyM
 WrIMa+YG27xDobpxTwe7mqMIWFwIEr/Ha6AWRUVLWIPyZf76NfPW8/y
X-Developer-Key: i=yatsenko@meta.com; a=ed25519;
 pk=TFoLStOoH/++W4HJHRgNr8zj8vPFB1W+/QECPcQygzo=

From: Mykyta Yatsenko <yatsenko@meta.com>

Rename bpf_stream_vprintk() to bpf_stream_vprintk_impl().

This makes bpf_stream_vprintk() follow the already established "_impl"
suffix-based naming convention for kfuncs with the bpf_prog_aux
argument provided by the verifier implicitly. This convention will be
taken advantage of with the upcoming KF_IMPLICIT_ARGS feature to
preserve backwards compatibility to BPF programs.

Acked-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
---
 kernel/bpf/helpers.c                             |  2 +-
 kernel/bpf/stream.c                              |  3 ++-
 tools/bpf/bpftool/Documentation/bpftool-prog.rst |  2 +-
 tools/lib/bpf/bpf_helpers.h                      | 28 ++++++++++++------------
 tools/testing/selftests/bpf/progs/stream_fail.c  |  6 ++---
 5 files changed, 21 insertions(+), 20 deletions(-)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 33173b027ccf8893ce18aad474b88f8544f7b344..e4007fea49091c01c1d23af55a25f5567417e978 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -4380,7 +4380,7 @@ BTF_ID_FLAGS(func, bpf_strnstr);
 #if defined(CONFIG_BPF_LSM) && defined(CONFIG_CGROUPS)
 BTF_ID_FLAGS(func, bpf_cgroup_read_xattr, KF_RCU)
 #endif
-BTF_ID_FLAGS(func, bpf_stream_vprintk, KF_TRUSTED_ARGS)
+BTF_ID_FLAGS(func, bpf_stream_vprintk_impl, KF_TRUSTED_ARGS)
 BTF_ID_FLAGS(func, bpf_task_work_schedule_signal_impl, KF_TRUSTED_ARGS)
 BTF_ID_FLAGS(func, bpf_task_work_schedule_resume_impl, KF_TRUSTED_ARGS)
 BTF_KFUNCS_END(common_btf_ids)
diff --git a/kernel/bpf/stream.c b/kernel/bpf/stream.c
index eb6c5a21c2efee96c41f4c5e43d54062694a4859..ff16c631951bb685e8ecf1707206dad603121a65 100644
--- a/kernel/bpf/stream.c
+++ b/kernel/bpf/stream.c
@@ -355,7 +355,8 @@ __bpf_kfunc_start_defs();
  * Avoid using enum bpf_stream_id so that kfunc users don't have to pull in the
  * enum in headers.
  */
-__bpf_kfunc int bpf_stream_vprintk(int stream_id, const char *fmt__str, const void *args, u32 len__sz, void *aux__prog)
+__bpf_kfunc int bpf_stream_vprintk_impl(int stream_id, const char *fmt__str, const void *args,
+					u32 len__sz, void *aux__prog)
 {
 	struct bpf_bprintf_data data = {
 		.get_bin_args	= true,
diff --git a/tools/bpf/bpftool/Documentation/bpftool-prog.rst b/tools/bpf/bpftool/Documentation/bpftool-prog.rst
index 009633294b0934ac282601cf21a0fd03c388de2c..35aeeaf5f71166f0e1e8759da8639c2533d47482 100644
--- a/tools/bpf/bpftool/Documentation/bpftool-prog.rst
+++ b/tools/bpf/bpftool/Documentation/bpftool-prog.rst
@@ -182,7 +182,7 @@ bpftool prog tracelog
 
 bpftool prog tracelog { stdout | stderr } *PROG*
     Dump the BPF stream of the program. BPF programs can write to these streams
-    at runtime with the **bpf_stream_vprintk**\ () kfunc. The kernel may write
+    at runtime with the **bpf_stream_vprintk_impl**\ () kfunc. The kernel may write
     error messages to the standard error stream. This facility should be used
     only for debugging purposes.
 
diff --git a/tools/lib/bpf/bpf_helpers.h b/tools/lib/bpf/bpf_helpers.h
index 80c028540656176376909cb796e56de433ef3aab..d4e4e388e625894f8ec27b5a6278dbb46e658720 100644
--- a/tools/lib/bpf/bpf_helpers.h
+++ b/tools/lib/bpf/bpf_helpers.h
@@ -315,20 +315,20 @@ enum libbpf_tristate {
 			  ___param, sizeof(___param));		\
 })
 
-extern int bpf_stream_vprintk(int stream_id, const char *fmt__str, const void *args,
-			      __u32 len__sz, void *aux__prog) __weak __ksym;
-
-#define bpf_stream_printk(stream_id, fmt, args...)				\
-({										\
-	static const char ___fmt[] = fmt;					\
-	unsigned long long ___param[___bpf_narg(args)];				\
-										\
-	_Pragma("GCC diagnostic push")						\
-	_Pragma("GCC diagnostic ignored \"-Wint-conversion\"")			\
-	___bpf_fill(___param, args);						\
-	_Pragma("GCC diagnostic pop")						\
-										\
-	bpf_stream_vprintk(stream_id, ___fmt, ___param, sizeof(___param), NULL);\
+extern int bpf_stream_vprintk_impl(int stream_id, const char *fmt__str, const void *args,
+				   __u32 len__sz, void *aux__prog) __weak __ksym;
+
+#define bpf_stream_printk(stream_id, fmt, args...)					\
+({											\
+	static const char ___fmt[] = fmt;						\
+	unsigned long long ___param[___bpf_narg(args)];					\
+											\
+	_Pragma("GCC diagnostic push")							\
+	_Pragma("GCC diagnostic ignored \"-Wint-conversion\"")				\
+	___bpf_fill(___param, args);							\
+	_Pragma("GCC diagnostic pop")							\
+											\
+	bpf_stream_vprintk_impl(stream_id, ___fmt, ___param, sizeof(___param), NULL);	\
 })
 
 /* Use __bpf_printk when bpf_printk call has 3 or fewer fmt args
diff --git a/tools/testing/selftests/bpf/progs/stream_fail.c b/tools/testing/selftests/bpf/progs/stream_fail.c
index b4a0d0cc8ec8a9483b5967745cd35f8bd940460e..3662515f0107740c147f5a9296b4da06fa508364 100644
--- a/tools/testing/selftests/bpf/progs/stream_fail.c
+++ b/tools/testing/selftests/bpf/progs/stream_fail.c
@@ -10,7 +10,7 @@ SEC("syscall")
 __failure __msg("Possibly NULL pointer passed")
 int stream_vprintk_null_arg(void *ctx)
 {
-	bpf_stream_vprintk(BPF_STDOUT, "", NULL, 0, NULL);
+	bpf_stream_vprintk_impl(BPF_STDOUT, "", NULL, 0, NULL);
 	return 0;
 }
 
@@ -18,7 +18,7 @@ SEC("syscall")
 __failure __msg("R3 type=scalar expected=")
 int stream_vprintk_scalar_arg(void *ctx)
 {
-	bpf_stream_vprintk(BPF_STDOUT, "", (void *)46, 0, NULL);
+	bpf_stream_vprintk_impl(BPF_STDOUT, "", (void *)46, 0, NULL);
 	return 0;
 }
 
@@ -26,7 +26,7 @@ SEC("syscall")
 __failure __msg("arg#1 doesn't point to a const string")
 int stream_vprintk_string_arg(void *ctx)
 {
-	bpf_stream_vprintk(BPF_STDOUT, ctx, NULL, 0, NULL);
+	bpf_stream_vprintk_impl(BPF_STDOUT, ctx, NULL, 0, NULL);
 	return 0;
 }
 

-- 
2.51.1


