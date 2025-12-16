Return-Path: <bpf+bounces-76713-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 08064CC3463
	for <lists+bpf@lfdr.de>; Tue, 16 Dec 2025 14:39:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F08D2305B914
	for <lists+bpf@lfdr.de>; Tue, 16 Dec 2025 13:38:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58D0F3845AC;
	Tue, 16 Dec 2025 13:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="37CCYGG/"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f73.google.com (mail-ed1-f73.google.com [209.85.208.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1861B382BED
	for <bpf@vger.kernel.org>; Tue, 16 Dec 2025 13:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765891808; cv=none; b=Q0ckK7gMgqW4K/hc0bU2+IuYbGMZisb9Yjeye6q+G5t81YiHypOwxkSqZb9v+NouRl42oc7ZRwKVBps8JFPjdJK/ovwABbBOZv32K/p4gfKLCpWD9BV8CTJSLVoMXU3SuMMDTFNfR3wWG3rXtqsfaKPmZAdB4Kf7tFMRyaQhWUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765891808; c=relaxed/simple;
	bh=RVVMHKsGN401IuhZlvbDGgkt4PjsAaO2dy3LOb7NH+s=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=tEFjaiHhGGi5d2bkBKG1ipDK8BwpCxZIfFMVJw+15/7ivr0/9SQGb/dkgkSVSOYsh16oBBF3YFQkapOYdPe0ZOtSsWGSgilCcy4erHEdDRSnyI9vJn7Z5EACLuMhDDW4ukpWwA32zoPCoRKEUXzbtgB9na7hYfJ9SyCLQaUMiKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mattbobrowski.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=37CCYGG/; arc=none smtp.client-ip=209.85.208.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mattbobrowski.bounces.google.com
Received: by mail-ed1-f73.google.com with SMTP id 4fb4d7f45d1cf-649850def48so7962334a12.1
        for <bpf@vger.kernel.org>; Tue, 16 Dec 2025 05:30:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1765891803; x=1766496603; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xR2sbNKCDnhjhOTBGWwqajeMq67L1FwTO9V4BG0MSp4=;
        b=37CCYGG/1d5554xwWI76Ktb4KP3F3uhcaw91cJtIpXe2aRtV1UTZAW0jyKSG5x5ycd
         tG9/OnAZVkLknuxzpG7+7efHPeEgblJDTrKkRdEF6yb9XJjidDkzs45ysbPIo9YkbzrD
         S352+94S8pbqJDpxLkkQ3bxGbrovfF73+JvPaPMr00Z2GwUx5H6DX10n0g5HA58zRThB
         qvxa3biZDhg42nrJtk84hX+Ez6XvuW0wUBb5Rst6/6Xc9iKFATe4BLSoM2OBTceZD4IL
         X9E/8jHi0dnt498Q7a5PsuV+zrGp6MFGVxW353p5rCpiN6LpZ16uqIuKm76KruFIFYnA
         0FPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765891803; x=1766496603;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xR2sbNKCDnhjhOTBGWwqajeMq67L1FwTO9V4BG0MSp4=;
        b=pX+FbBnkpfa4Kq2GYEJNT/qQrgu0urX59G7nYA5og/gOfOOt1VNOpnkA0YVc9fBkvu
         qY34fPreuEjJwfvJ4ao1Vttiq69FGP8W1eOb8UKMFeGRUatcMx9XN36iUcAh9kbN6XqJ
         OfgMMCQafEAHiVmfNa6QSWwNkzRHW5MTfSGpUtKLx1Ah4Omc2K7K4/fVcrlfSNsPl2GP
         b8cqzLn4uRpNGCmcRyPFLR60b3oMDgf5n4tcvUy8k94TqUmScaczvbhb1HtLhRMqSTZr
         UGM7LUrZ0unQ998NYD3WTACk7irb6kuo8olLC6veCBSpk303U0Rtbs6HAP5bhArXhxam
         6ayw==
X-Gm-Message-State: AOJu0YxvEDpAQONf1UqZ9h05Itv9aQ4IBRfsEbT0JyogHGQpac+9mMFz
	UxFZZuItdxsHFl+NqYJxc7MyRcl1nTyZoGGuoNXmJOtfQlukGE4Xm7q54oDsz0ajI3E+7U7iEyR
	83VNihDmV6YlzIOMtwNNVrf7HXYwjYGYHhuG+hWVMcPtBNHr2SvHRhSv7+flFEefT8IH9CHMJes
	V0i0PYrkwfgy6AG8MZRpeRi6n9LURmq4NUEM54/dSLu7ec+qPgUOn6Mvzy/i2Q3M0c8lxkjQ==
X-Google-Smtp-Source: AGHT+IG+8KN1AEfOlvQMMymJs6nHU9PHiBiJnDNOHEGd5N9JLFRUonbtvg6qYQ7jHf8lsPvzjwLHb3Jetu+TJAV9Nkpw
X-Received: from edtw3.prod.google.com ([2002:aa7:cb43:0:b0:64b:34e0:401])
 (user=mattbobrowski job=prod-delivery.src-stubby-dispatcher) by
 2002:aa7:c4c6:0:b0:645:d07:8924 with SMTP id 4fb4d7f45d1cf-6499afbbc62mr10345130a12.16.1765891803228;
 Tue, 16 Dec 2025 05:30:03 -0800 (PST)
Date: Tue, 16 Dec 2025 13:29:59 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.52.0.313.g674ac2bdf7-goog
Message-ID: <20251216133000.3690723-1-mattbobrowski@google.com>
Subject: [PATCH v2 bpf-next 1/2] bpf: annotate file argument as __nullable in bpf_lsm_mmap_file
From: Matt Bobrowski <mattbobrowski@google.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, ohn Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Kaiyan Mei <M202472210@hust.edu.cn>, 
	Yinhao Hu <dddddd@hust.edu.cn>, Dongliang Mu <dzm91@hust.edu.cn>, 
	Matt Bobrowski <mattbobrowski@google.com>
Content-Type: text/plain; charset="UTF-8"

As reported in [0], anonymous memory mappings are not backed by a
struct file instance. Consequently, the struct file pointer passed to
the security_mmap_file() LSM hook is NULL in such cases.

The BPF verifier is currently unaware of this, allowing BPF LSM
programs to dereference this struct file pointer without needing to
perform an explicit NULL check. This leads to potential NULL pointer
dereference and a kernel crash.

Add a strong override for bpf_lsm_mmap_file() which annotates the
struct file pointer parameter with the __nullable suffix. This
explicitly informs the BPF verifier that this pointer (PTR_MAYBE_NULL)
can be NULL, forcing BPF LSM programs to perform a check on it before
dereferencing it.

[0] https://lore.kernel.org/bpf/5e460d3c.4c3e9.19adde547d8.Coremail.kaiyanm@hust.edu.cn/

Reported-by: Kaiyan Mei <M202472210@hust.edu.cn>
Reported-by: Yinhao Hu <dddddd@hust.edu.cn>
Reviewed-by: Dongliang Mu <dzm91@hust.edu.cn>
Closes: https://lore.kernel.org/bpf/5e460d3c.4c3e9.19adde547d8.Coremail.kaiyanm@hust.edu.cn/
Signed-off-by: Matt Bobrowski <mattbobrowski@google.com>
---
v2:
 - Updated the comment against the new strong definition for
   bpf_lsm_mmap_file(), clarifying the need for using the __nullable
   suffix annotation against the struct file pointer parameter name.

 MAINTAINERS                |  1 +
 kernel/bpf/Makefile        | 12 +++++++++++-
 kernel/bpf/bpf_lsm.c       |  5 +++--
 kernel/bpf/bpf_lsm_proto.c | 19 +++++++++++++++++++
 4 files changed, 34 insertions(+), 3 deletions(-)
 create mode 100644 kernel/bpf/bpf_lsm_proto.c

diff --git a/MAINTAINERS b/MAINTAINERS
index e36689cd7cc7..c531fae0dc06 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4754,6 +4754,7 @@ S:	Maintained
 F:	Documentation/bpf/prog_lsm.rst
 F:	include/linux/bpf_lsm.h
 F:	kernel/bpf/bpf_lsm.c
+F:	kernel/bpf/bpf_lsm_proto.c
 F:	kernel/trace/bpf_trace.c
 F:	security/bpf/
 
diff --git a/kernel/bpf/Makefile b/kernel/bpf/Makefile
index 232cbc97434d..79cf22860a99 100644
--- a/kernel/bpf/Makefile
+++ b/kernel/bpf/Makefile
@@ -42,7 +42,17 @@ endif
 ifeq ($(CONFIG_BPF_JIT),y)
 obj-$(CONFIG_BPF_SYSCALL) += bpf_struct_ops.o
 obj-$(CONFIG_BPF_SYSCALL) += cpumask.o
-obj-${CONFIG_BPF_LSM} += bpf_lsm.o
+# bpf_lsm_proto.o must precede bpf_lsm.o. The current pahole logic
+# deduplicates function prototypes within
+# btf_encoder__add_saved_func() by keeping the first instance seen. We
+# need the function prototype(s) in bpf_lsm_proto.o to take precedence
+# over those within bpf_lsm.o. Having bpf_lsm_proto.o precede
+# bpf_lsm.o ensures its DWARF CU is processed early, forcing the
+# generated BTF to contain the overrides.
+#
+# Notably, this is a temporary workaround whilst the deduplication
+# semantics within pahole are revisited accordingly.
+obj-${CONFIG_BPF_LSM} += bpf_lsm_proto.o bpf_lsm.o
 endif
 ifneq ($(CONFIG_CRYPTO),)
 obj-$(CONFIG_BPF_SYSCALL) += crypto.o
diff --git a/kernel/bpf/bpf_lsm.c b/kernel/bpf/bpf_lsm.c
index 7cb6e8d4282c..0c4a0c8e6f70 100644
--- a/kernel/bpf/bpf_lsm.c
+++ b/kernel/bpf/bpf_lsm.c
@@ -18,10 +18,11 @@
 #include <linux/bpf-cgroup.h>
 
 /* For every LSM hook that allows attachment of BPF programs, declare a nop
- * function where a BPF program can be attached.
+ * function where a BPF program can be attached. Notably, we qualify each with
+ * weak linkage such that strong overrides can be implemented if need be.
  */
 #define LSM_HOOK(RET, DEFAULT, NAME, ...)	\
-noinline RET bpf_lsm_##NAME(__VA_ARGS__)	\
+__weak noinline RET bpf_lsm_##NAME(__VA_ARGS__)	\
 {						\
 	return DEFAULT;				\
 }
diff --git a/kernel/bpf/bpf_lsm_proto.c b/kernel/bpf/bpf_lsm_proto.c
new file mode 100644
index 000000000000..44a54fd8045e
--- /dev/null
+++ b/kernel/bpf/bpf_lsm_proto.c
@@ -0,0 +1,19 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright 2025 Google LLC.
+ */
+
+#include <linux/fs.h>
+#include <linux/bpf_lsm.h>
+
+/*
+ * Strong definition of the mmap_file() BPF LSM hook. The __nullable suffix on
+ * the struct file pointer parameter name marks it as PTR_MAYBE_NULL. This
+ * explicitly enforces that BPF LSM programs check for NULL before attempting to
+ * dereference it.
+ */
+int bpf_lsm_mmap_file(struct file *file__nullable, unsigned long reqprot,
+		      unsigned long prot, unsigned long flags)
+{
+	return 0;
+}
-- 
2.52.0.313.g674ac2bdf7-goog


