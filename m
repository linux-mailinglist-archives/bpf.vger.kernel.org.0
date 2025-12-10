Return-Path: <bpf+bounces-76403-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E5F10CB27D7
	for <lists+bpf@lfdr.de>; Wed, 10 Dec 2025 10:07:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 29FD03009F03
	for <lists+bpf@lfdr.de>; Wed, 10 Dec 2025 09:07:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39AFF302167;
	Wed, 10 Dec 2025 09:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Fuf0Hdg4"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f74.google.com (mail-ed1-f74.google.com [209.85.208.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBDF3288C2B
	for <bpf@vger.kernel.org>; Wed, 10 Dec 2025 09:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765357628; cv=none; b=u4oPM46LwUELwcawRK9rnzYotDtds+A7bCc15kkbyyeCv05oVKLXKWX9GI/T3esCI6stDAlOEhS/uJqbsBmKgD5VWyr1mzXPnRZHxbKlS+avwgT6j7ACFflz6O5L7QMHRU82hgLRcR25zYraac1cUQlq1UN0r2rMmTJ8DdOXK/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765357628; c=relaxed/simple;
	bh=Kv9khK2xuj9jS+hu0beev/cb61+pViXszvwps5W/GJE=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=PW1+5Tq1c2pBSGb4w14eMkFZlnyM4Hbn8CCIwaAzJXY2soZjaB7QnKprs/bzBO+gdzS1yg5qjirZwaMEf+nRik5RzP/MSNJ8mqLOHhtJtLws6/gVTjaZ5NlCVj1ngdwwQeNBrJGLbkHhqPZJVZ62L5GvOVRT745mpN7MfVKtll8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mattbobrowski.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Fuf0Hdg4; arc=none smtp.client-ip=209.85.208.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mattbobrowski.bounces.google.com
Received: by mail-ed1-f74.google.com with SMTP id 4fb4d7f45d1cf-64161017e34so6788319a12.1
        for <bpf@vger.kernel.org>; Wed, 10 Dec 2025 01:07:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1765357625; x=1765962425; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=yQ8jlIjYjc3wMQ83wOEXwb8O9llEAL16SWDcjk+ARAM=;
        b=Fuf0Hdg4G8BWnP1dunHd/ohQlEVnBAz1CNQBVmKBeAcmynOVHuQP7znTDVxaq6MTyj
         CS1am8Du5sj2RcCgwezPLYQtVFKUkRt82K38zpOmun86Q+DJ1H1TcegW89T0U/0wcDXa
         W/Z0Oq3AZbhwBMKgAPurFHw3Yd6SEOaLB/PlwqA7xX8Y6zLZgIK663ubco3tCLklFMgq
         XgZOmxYSNK1WwpMkRdSpoCMlvGLRJJQlfWfLaH9g5Ce9jv1UfHlweNw9ZE/Qy+jQbSz/
         HHkC3LpXAqVmvXSKk0MszJX4EopAXz42Cf0i08ORNiyx7iDuObaln2dV05nMIPKQrfhA
         2HjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765357625; x=1765962425;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yQ8jlIjYjc3wMQ83wOEXwb8O9llEAL16SWDcjk+ARAM=;
        b=QOSUy/TkDJP6swkXtiAoG4Np/bWhJCB/43gjppG/9ytxd/j0/XWjo45z6S2w5iJnWq
         mteFqPTCoIOABm84ijKkSwniDzYq1Pm901C5HhrdH1egGoosolBudZht6cwHEzkjTiMV
         55yZTr/AfCx/CpiEzdhqnUzrVsBhreVUKt8E51LJRtrgkfei8znP89l0Jd3/Sx6cVdZu
         2ecqxLM3ML9NbHauGy5gm3W1Qm7MFuv8yOIy4shmxYa1rOMBji+c1Gv4wZMhKuQMraSC
         /z73DDCLBGzxYsj3vaR7Ue0mlCzgMIPl97ZrNwZmDxt3gm57ATCiOB+Ll1dJpeQLseHQ
         Q0kw==
X-Gm-Message-State: AOJu0Yy6gYzRHMREP0OUYe9CzlX4pIuOJ8XxJudIrjLLFsaEXCa2RCNA
	r91yUcBU2XJvLLPIZlf9RnNYAaNHkHTto/mD/RafTT6eWTFYrOFKdFJOXyk0QtgRlokhkh2aXv1
	6WpRE5gZ3sRXj3BryGEybCvGoWIydk7VbdR66PhV6IZgUGI2v2WY9Tqiu5+ou/NMDofXfrcBjZC
	SISdwRVfTBlCS5afXGAIvzxK0s1YSgscsUNLdNtl7MKfOEhXBxBMtpEEq3BVpFbK7DlZtdbQ==
X-Google-Smtp-Source: AGHT+IEQfdC7T4PkbFtu4STHWAN89Du6VvFPiItH2aZlOgm+qyQiBG4iGqRn0OPaJ1B5fud4j7c4vwmCRX61Asb339o4
X-Received: from edf28.prod.google.com ([2002:a05:6402:21dc:b0:645:1179:b3ae])
 (user=mattbobrowski job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6402:2345:b0:643:4e9c:d16d with SMTP id 4fb4d7f45d1cf-6496cbbbee2mr1663868a12.21.1765357625050;
 Wed, 10 Dec 2025 01:07:05 -0800 (PST)
Date: Wed, 10 Dec 2025 09:07:00 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.52.0.223.gf5cc29aaa4-goog
Message-ID: <20251210090701.2753545-1-mattbobrowski@google.com>
Subject: [PATCH bpf-next 1/2] bpf: annotate file argument as __nullable in bpf_lsm_mmap_file
From: Matt Bobrowski <mattbobrowski@google.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, ohn Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Josh Don <joshdon@google.com>, 
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
 MAINTAINERS                |  1 +
 kernel/bpf/Makefile        | 12 +++++++++++-
 kernel/bpf/bpf_lsm.c       |  5 +++--
 kernel/bpf/bpf_lsm_proto.c | 20 ++++++++++++++++++++
 4 files changed, 35 insertions(+), 3 deletions(-)
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
index 000000000000..273bc7ddad64
--- /dev/null
+++ b/kernel/bpf/bpf_lsm_proto.c
@@ -0,0 +1,20 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright 2025 Google LLC.
+ */
+
+#include <linux/fs.h>
+#include <linux/bpf_lsm.h>
+
+/*
+ * A strong definition for BPF LSM hook mmap_file(). Differs from its weak
+ * definition counterpart only through its of the __nullable suffix on its
+ * struct file pointer parameter. Annotating with a __nullable suffix allows the
+ * BPF verifier to enforce stricter NULL pointer checking in cases where a BPF
+ * program is attempting to access the BPF program context.
+ */
+int bpf_lsm_mmap_file(struct file *file__nullable, unsigned long reqprot,
+		      unsigned long prot, unsigned long flags)
+{
+	return 0;
+}
-- 
2.52.0.223.gf5cc29aaa4-goog


