Return-Path: <bpf+bounces-54905-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 239F3A75CAC
	for <lists+bpf@lfdr.de>; Sun, 30 Mar 2025 23:14:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2BC351886CC0
	for <lists+bpf@lfdr.de>; Sun, 30 Mar 2025 21:14:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2004A1DE3D2;
	Sun, 30 Mar 2025 21:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MSrKarQ4"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 464E0185935
	for <bpf@vger.kernel.org>; Sun, 30 Mar 2025 21:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743369240; cv=none; b=bc9oqD05sEsU5WMuT0xXOYEUaVEFkx3hy1UNtkMjKXfPyzuHwpfqrQCLOLjoaffMkrGD+/mw1de5fVVA7C5BEfxVj17yYeeOHQJxWasidKIgXVMkBFwiUOnPp7KUxXZPE+ZmA3L7/fI1GGudMHs37kdTEREjm6f4MaxO6rge1qY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743369240; c=relaxed/simple;
	bh=tuY/QNQk/F9SugrUgSfFsgzuGaTIb2SuuPlR/76U+A8=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=LDs1MmAAwqOwD0A27gyuPcS9RlnJpP/JBgWQPj0OSiKerVm0tfAZG7gLJduJrQaUn5Mc643notnphsbFrauJ0euCy7BzLSQBbY//dqSXkGIzZUMd2K7jXt7dnAATiF0nPW4lrWw/lcxRf4D0UdcKVdBk7AN8kBYJJgy/DJdXGU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MSrKarQ4; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-30364fc706fso6202008a91.3
        for <bpf@vger.kernel.org>; Sun, 30 Mar 2025 14:13:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743369238; x=1743974038; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=61IYoBnyZqJEMEpkuy3cn0SZfZ0XGPVC6El2dNeevTQ=;
        b=MSrKarQ4eiBdkKzw55QshBdp7cp8chyr4CABIpQ4u8jkYg/AYGqv/qvkMbcMAhYnK+
         5eIlc/xEQRM79Wf/iar2zzrRSGcrIlTboJyPb68MXKsfMYJtYBIWRpTayM61I68nFpq5
         gzg2iscxRhIB6Hu6L2Z+NMO75PYGNxef3swBxsiQY1A24JiDtRe+kQa3bHprCSmini/9
         Z2/7Hcx2dnI1VUeoCT55C+uo6KzfytYHEje+sw+1XGk1Jb4eRZhg5zw2Q2O7UymazgkJ
         s5kvnePPhFz5bXqsfDIx8anFlHggHgcL+OUIaHiR3GQ1f+JZskzyqVWHm7hdkZEr0a+O
         +iXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743369238; x=1743974038;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=61IYoBnyZqJEMEpkuy3cn0SZfZ0XGPVC6El2dNeevTQ=;
        b=qrLYVTlKWunrnoEx53fns7XvzpK2jxzG2Ew82rKmhawfuOV7zFCAZuSD2SbO+0VVFV
         wAz68CZ1lTHIt8nf1X5hws/w1SwX9P46JPtAUw7U3YEy+uDgkaX7kBOsIJf25KZU/S2I
         LyW2P3P1O7sGhDgTp38ukr8VFo37CyCR7VfU2I4sHZ3+AZHnCb3tDPmPwNW0VTX3CEB3
         P9M3WUS6Gl2JkaA6YFPScrUHLAIveFgVmI1Cn/hOG6A6WF1xMsSjOu4xnrz6v2uHcqFh
         i9EovE3MXbA7EaqXSLf2TJZDITLHui+crhr5FUFNSVbUX55ziAxzgYc3XlQWlru3CsoF
         EIPw==
X-Gm-Message-State: AOJu0YwkolevtKdDzDVQWPLQoo/hHrifPelGjt6uiQ7+hWAm3jF/8Y31
	rVorVToKi8x/cDdtS+lpHmBMsH5hDjcMtoiGNOapQV/Iql86JX1NjldCc+sUJ0p5X+D/ps14G3M
	xiMjn8Mg29PENzcG8ZWQuhfKQXG/UmuRNqrTFJYT3F+XQYbKRRCzoMcFTvpSAYY4ELKSrrGC+63
	wlAyuOq/Kv4RDX+0QwoPeFEirie0mD4h2iNs4ijl4=
X-Google-Smtp-Source: AGHT+IExA/Qh/zET4rYRjfCGWnHQ2oDyUcaf7FrxoGsylJCTJr1cZxpuLWN9JGul9NvyF2ynMXNVsUSEXVUzfA==
X-Received: from pjbqn11.prod.google.com ([2002:a17:90b:3d4b:b0:2ea:29de:af10])
 (user=cmllamas job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:2e8d:b0:2fe:99cf:f579 with SMTP id 98e67ed59e1d1-30531f7c03bmr12282871a91.4.1743369238499;
 Sun, 30 Mar 2025 14:13:58 -0700 (PDT)
Date: Sun, 30 Mar 2025 21:13:23 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.472.ge94155a9ec-goog
Message-ID: <20250330211325.530677-1-cmllamas@google.com>
Subject: [PATCH bpf] libbpf: Fix implicit memfd_create() for bionic
From: Carlos Llamas <cmllamas@google.com>
To: bpf@vger.kernel.org, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Alastair Robertson <ajor@meta.com>
Cc: linux-kernel@vger.kernel.org, kernel-team@android.com, 
	Carlos Llamas <cmllamas@google.com>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Since memfd_create() is not consistently available across different
bionic libc implementations, using memfd_create() directly can break
some Android builds:

  tools/lib/bpf/linker.c:576:7: error: implicit declaration of function 'memfd_create' [-Werror,-Wimplicit-function-declaration]
    576 |         fd = memfd_create(filename, 0);
        |              ^

To fix this, relocate and inline the sys_memfd_create() helper so that
it can be used in "linker.c". Similar issues were previously fixed by
commit 9fa5e1a180aa ("libbpf: Call memfd_create() syscall directly").

Cc: Alastair Robertson <ajor@meta.com>
Cc: Andrii Nakryiko <andrii@kernel.org>
Fixes: 6d5e5e5d7ce1 ("libbpf: Extend linker API to support in-memory ELF files")
Signed-off-by: Carlos Llamas <cmllamas@google.com>
---
 tools/lib/bpf/libbpf.c          | 9 ---------
 tools/lib/bpf/libbpf_internal.h | 9 +++++++++
 tools/lib/bpf/linker.c          | 2 +-
 3 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 194809da5172..1f36e16461e1 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -1719,15 +1719,6 @@ static Elf64_Sym *find_elf_var_sym(const struct bpf_object *obj, const char *nam
 	return ERR_PTR(-ENOENT);
 }
 
-/* Some versions of Android don't provide memfd_create() in their libc
- * implementation, so avoid complications and just go straight to Linux
- * syscall.
- */
-static int sys_memfd_create(const char *name, unsigned flags)
-{
-	return syscall(__NR_memfd_create, name, flags);
-}
-
 #ifndef MFD_CLOEXEC
 #define MFD_CLOEXEC 0x0001U
 #endif
diff --git a/tools/lib/bpf/libbpf_internal.h b/tools/lib/bpf/libbpf_internal.h
index de498e2dd6b0..19770402807f 100644
--- a/tools/lib/bpf/libbpf_internal.h
+++ b/tools/lib/bpf/libbpf_internal.h
@@ -666,6 +666,15 @@ static inline int sys_dup3(int oldfd, int newfd, int flags)
 	return syscall(__NR_dup3, oldfd, newfd, flags);
 }
 
+/* Some versions of Android don't provide memfd_create() in their libc
+ * implementation, so avoid complications and just go straight to Linux
+ * syscall.
+ */
+static inline int sys_memfd_create(const char *name, unsigned flags)
+{
+	return syscall(__NR_memfd_create, name, flags);
+}
+
 /* Point *fixed_fd* to the same file that *tmp_fd* points to.
  * Regardless of success, *tmp_fd* is closed.
  * Whatever *fixed_fd* pointed to is closed silently.
diff --git a/tools/lib/bpf/linker.c b/tools/lib/bpf/linker.c
index b52f71c59616..077af6f8bebb 100644
--- a/tools/lib/bpf/linker.c
+++ b/tools/lib/bpf/linker.c
@@ -573,7 +573,7 @@ int bpf_linker__add_buf(struct bpf_linker *linker, void *buf, size_t buf_sz,
 
 	snprintf(filename, sizeof(filename), "mem:%p+%zu", buf, buf_sz);
 
-	fd = memfd_create(filename, 0);
+	fd = sys_memfd_create(filename, 0);
 	if (fd < 0) {
 		ret = -errno;
 		pr_warn("failed to create memfd '%s': %s\n", filename, errstr(ret));
-- 
2.49.0.472.ge94155a9ec-goog


