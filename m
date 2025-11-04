Return-Path: <bpf+bounces-73452-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 67C2FC31D7B
	for <lists+bpf@lfdr.de>; Tue, 04 Nov 2025 16:31:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 986833ACB79
	for <lists+bpf@lfdr.de>; Tue,  4 Nov 2025 15:30:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18B6D258ED5;
	Tue,  4 Nov 2025 15:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XnxP5UMT"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B201926E6FA
	for <bpf@vger.kernel.org>; Tue,  4 Nov 2025 15:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762270217; cv=none; b=ngUAqpNm3EHJMHgH5Tryg6LCtlq+Rq2P/2QLYRtvUnDRB75/UzZosMG5/+29F6T8dHfs8RaBNVn4KeXqtSWTxmQZDn+uF2sm6BeoyqB+7xDwnw5u1zvHKPyU2q90xBWcBsGEMDMlgFM0/84tzE1TpXoMOFeXn22jI5tM/LlQbk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762270217; c=relaxed/simple;
	bh=WF1RFIhtNoHilbEWo/rc0R4yVBMckyxMf5FdwL0EnrE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lcXpjlSvXfXTkP7BHtpUXmkh7NKbaN3Igii3G0yoFtr3MIuc/CoT+dEnWxU0Yob43d+3tNZu16u3os8ijprNxEpDr6D5JZCb2g7yta4Bsu7w1JpAnZ8QR7AXnwCnwYSH7O3NoVH8/7JX8xW8IOyoXaxViSbA9axNbMX3qUKG7FI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XnxP5UMT; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-4283be7df63so3129038f8f.1
        for <bpf@vger.kernel.org>; Tue, 04 Nov 2025 07:30:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762270214; x=1762875014; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pp/qoAVAfkkRFbhiKysqdUXCxMeggvIP1jgj0CwdLH0=;
        b=XnxP5UMT30myqXHJOnMf0mhqvGiVPRs5rILopfqwGvUdGfOsYWmeKhfzUtaHsHL1xn
         4vF1s5/E+AftXturZnHS3GsvULF23k4FexaWO5arhraU+HRRcZwwbH3+dq1ShqMAHgJz
         ZZO/4kRKIknr9bgWuxYdez9nR+SPTi3EDxSkgMqcs6wF/G44A4L7J0EEMdi3DXqXj2O3
         bgnQCj9Zgg2EF0iEK/EFAYQsyczDfCXSwkxb9kX23eFdFS9bYxEmKfIwH47bCrZLwImn
         yhpuRfzsxMqq3cDYGjSFgkd86f4MGrFByCxUF4ld9yLOAFpHnlFpzfs9mmae/eRyxGul
         wnrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762270214; x=1762875014;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pp/qoAVAfkkRFbhiKysqdUXCxMeggvIP1jgj0CwdLH0=;
        b=r5dcJdAeSGL71t+z6fxked2qYwexJIqJ+h9beGwGu+16OIsd8mxBuw4gEz1J9IpsXX
         ZMp2SOD01E1jp284ZH6l++4yfMa7fP8HpCl8evAFaJw+ytF+DyqcDUWNFGdcj8kNHTmW
         fcudkoIxr7iWzzFImxH/83n7Z+9cnDtfDJ0iJfR15IQAddAzHUAK6zbC7kAyVcHdz2fV
         +EBlPDAULa7J3s/frw2HGs9dIRHT2QJx/DAoUQdyQzB5JFzl2UN0sg+fGXGcWcEPLNjN
         SStG9FYKW+qt0n5mo2Rho3ZabuQJqXONgUXqQZkDi4XmM+cU03cNS0wrMdjCTgZrjq/7
         DLrQ==
X-Gm-Message-State: AOJu0Yzs7AGn/cL7UNAZ/euXDZtZpn4LWt+f63i61gHsycdB6BPKwGTT
	YLRf2C6UR+YIpCA1CzuM8IGRQ7lTpeLNy/PWWr1yvVCrd8NZtniMVShE
X-Gm-Gg: ASbGncsRcgz2z8vatMvPULpdoE829CQjePwjSZQKm7Ttt46IDULOhwze0e57EgDdXE+
	cumld5eQ2PidcSYkP6vl84ezXR8gAfd1U6LmQGnkxnjBk+CN7p+iT6s48g/Cicp7/gwaFf7HqAn
	JLUXu0FX431orfrgdO4D1yDUCypTtr+HG6Wx2YmQvMVJhg4Uf2aLaxgQQV5V7cZ3XwXRz2hBk0F
	4Q+bcH80uqQHhhNKKfSSLattsG31DzeUsJfP+Jym5lTFcDkz9WDUboJdddaSAuerPU3G9K4wXIy
	5b+FmDg1mw2ZauicJCUKFCBCIDfIGiAxY9jgMxZg1dZLoUyaHpavjgsqESFKF3dWmfis34kiZMU
	TxjhNRjksngGHuht2dbwtspj1eO9FkTP1M7HmDkHmk63KdXivuj0pPrsgqWJh
X-Google-Smtp-Source: AGHT+IHsnCFmXWphiCmFXnqygZatC+v/VE4k7HEgnqmemTRZRy1gyutACCJVxFF2RCfBTgY9ALlisA==
X-Received: by 2002:a5d:5d02:0:b0:427:9d7:86f9 with SMTP id ffacd0b85a97d-429bd6a8f88mr14205588f8f.47.1762270213890;
        Tue, 04 Nov 2025 07:30:13 -0800 (PST)
Received: from localhost ([2620:10d:c092:500::6:9cb5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4773c55dc6fsm219996685e9.14.2025.11.04.07.30.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 07:30:13 -0800 (PST)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Date: Tue, 04 Nov 2025 15:29:55 +0000
Subject: [PATCH bpf v2 2/2] bpf:add _impl suffix for bpf_stream_vprintk()
 kfunc
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251104-implv2-v2-2-6dbc35f39f28@meta.com>
References: <20251104-implv2-v2-0-6dbc35f39f28@meta.com>
In-Reply-To: <20251104-implv2-v2-0-6dbc35f39f28@meta.com>
To: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762270210; l=5673;
 i=yatsenko@meta.com; s=20251031; h=from:subject:message-id;
 bh=YxSyVqAMCoRp63zoLL35W/jxfkSXneTE7I6UNA2wgsY=;
 b=Xh2FNt6OZTh8WVWSBsV1R4BwkgRQKeXQVaco7xASm8uW8LTNlv2NMP/17+UaEOKDEi2MC9IMg
 /ReL6jh7r/HAqDXPy3ZJClZvjUJp24m7rpk0tRSKbPnKo6HqiTnQ+YM
X-Developer-Key: i=yatsenko@meta.com; a=ed25519;
 pk=TFoLStOoH/++W4HJHRgNr8zj8vPFB1W+/QECPcQygzo=

From: Mykyta Yatsenko <yatsenko@meta.com>

Rename bpf_stream_vprintk() to bpf_stream_vprintk_impl().

This aligns this recently added kfunc with the naming scheme required
by the implicit-argument feature.
In future BTF type for bpf_stream_vprintk() will be generated and
aux__prog argument filled by the valid struct implicitly.

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


