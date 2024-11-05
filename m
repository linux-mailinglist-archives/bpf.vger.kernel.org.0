Return-Path: <bpf+bounces-44072-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 10BF19BD787
	for <lists+bpf@lfdr.de>; Tue,  5 Nov 2024 22:20:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9646B1F24153
	for <lists+bpf@lfdr.de>; Tue,  5 Nov 2024 21:20:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D83E215F56;
	Tue,  5 Nov 2024 21:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mNIAQTkA"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23F23215C5D
	for <bpf@vger.kernel.org>; Tue,  5 Nov 2024 21:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730841609; cv=none; b=BrIbyNKjPXUmHRaeCMB+knHUILmhrwd6n4zUzUry7H+JebaAOpjh+yArxxER0Nt0kcK0Ap5Euo6EURqeqoqcJX6NzMaWApB1vitXyoNx1Gpg1+7C2FFvrFq1u0ZkM6w3RNTGdgGbKFI1HEGdvUgFU7GwuyrcCLwZvnG6mjRyaA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730841609; c=relaxed/simple;
	bh=tdEQWTXXNIDb3SwcEQjUY6rD/OolTRDXOtRdNj9lIfE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iZBcBkN3lcRVHd8kyl7njeiYPsrc97/KHe/+gtRJdj31fPYaYayTLeIp3IFviMbHaiNspPPCBBbRFZlWsqez5uiO8wKHfQDEqKXg9HrmtPtkTe1lZTQPVqQ/pXrHFxWRyhE/geMR+/abprQUQ44rzeMvqZ3rFY+xC1sMwoxXjKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mNIAQTkA; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2e2bd0e2c4fso4882365a91.3
        for <bpf@vger.kernel.org>; Tue, 05 Nov 2024 13:20:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730841607; x=1731446407; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IEhRVqKt8aAn71kWNEm4Goprl9mZ5SpKxN7w/dPJobw=;
        b=mNIAQTkAlAHUnpdHhIMpd1DCtCFnW2Wl5lnuEsr799qzj3uqNCCiNpEGek6U076PPN
         VKZuRjTuxRqC4m+W5QFF5Qu5tmuY42tNeChj7j5QLMgwoc/kSDVBpJidowVxSlQcAyG5
         gVVdyS12OjBgEtbpClGWoSBYYfdub0LZ1pcUHL55emc+ugPsBRLJrrEAGOYhLKOxjaIY
         FpTC+Nk9C6lm4cpqkUJlhgwIb6eTnQt8Azmmlju9Q24IktYqG66uQztwiLUkJ8Phk/p/
         H7yhMUEuFehJ/SWUvfUnm3+nsn61hoXXtG10ciCNDS5tt0gZBK8cSOm0bYeK3CTtAH5m
         ASJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730841607; x=1731446407;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IEhRVqKt8aAn71kWNEm4Goprl9mZ5SpKxN7w/dPJobw=;
        b=YYbHo0xwyE8RECnBf2rPb944UOPz9gtreVIUfQZs88XFjqySGceLzvqu9CoH5aiUql
         1TTclS88rQpStFRz2GMtnwxAJS0Jex/Q2O9rWesSZRISOevAAuPZR7WeZJoQpbxO/t0R
         zBalKcedC0Nt6oUwvNySZbucOBA6BkArUYVqAgtNZ7Ara2S3uh+ieKeATeovFHuztzB1
         M5LbQhy/Bf2EoBkzgYy39RvAnQE/kia3xV6qdGGA5+oaPxndfRP8NUm3y1NotdscX+Jl
         hWKOfchd1Vvljdx0PeZD6w/EwiTfDWeG5jOc7nItuJ4xd5JxOv2/HqpWR918Ab875KJk
         ghHQ==
X-Gm-Message-State: AOJu0Yz+1y54k9OYVgJhmwrD+jdh1Uh8AY8kO1hm9RGKBe1MolFIz5xA
	m1IDL89La5p4xhQk2tD5mlnU30TprHz0f3jCuqrPkwSIYpDBV96e30vFrA==
X-Google-Smtp-Source: AGHT+IG/DL+J+7D6AHe5u2yZUqv2EO+WRq77wuingKIVhLIQI6+YK9SM16BZu9BYCIwvBvju5rtqEA==
X-Received: by 2002:a17:90b:2b50:b0:2e2:9a48:dbb7 with SMTP id 98e67ed59e1d1-2e93c1e7db6mr28637017a91.29.1730841607114;
        Tue, 05 Nov 2024 13:20:07 -0800 (PST)
Received: from macbook-pro-49.lan ([2603:3023:16e:5000:1863:9460:a110:750b])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e92fa24ad2sm12733983a91.14.2024.11.05.13.20.05
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 05 Nov 2024 13:20:06 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	memxor@gmail.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch,
	dri-devel@lists.freedesktop.org,
	kernel-team@fb.com
Subject: [PATCH v2 bpf-next 1/2] drm, bpf: Move drm_mm.c to lib to be used by bpf arena
Date: Tue,  5 Nov 2024 13:20:00 -0800
Message-Id: <20241105212001.38980-2-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20241105212001.38980-1-alexei.starovoitov@gmail.com>
References: <20241105212001.38980-1-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

Move drm_mm.c to lib:
- The next commit will use drm_mm to manage memory regions
  in bpf arena.
- Move drm_mm_print to drivers/gpu/drm/drm_print.c, since
  it's not a core functionality of drm_mm and it depeneds
  on drm_printer while drm_mm is generic and usuable as-is
  by other subsystems.
- Replace DRM_ERROR with pr_err to fix build.
  DRM_ERROR is deprecated in favor of pr_err anyway.
- Also add __maybe_unused to suppress compiler warnings.
- Update MAINTAINERS file as well.

Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 MAINTAINERS                       |  1 +
 drivers/gpu/drm/Makefile          |  1 -
 drivers/gpu/drm/drm_print.c       | 39 +++++++++++++++++++++++++
 lib/Makefile                      |  1 +
 {drivers/gpu/drm => lib}/drm_mm.c | 48 ++++---------------------------
 5 files changed, 46 insertions(+), 44 deletions(-)
 rename {drivers/gpu/drm => lib}/drm_mm.c (95%)

diff --git a/MAINTAINERS b/MAINTAINERS
index 6880a8fac74c..1bfaa335fae7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7504,6 +7504,7 @@ F:	drivers/gpu/vga/
 F:	include/drm/drm
 F:	include/linux/vga*
 F:	include/uapi/drm/
+F:	lib/drm_mm.c
 X:	drivers/gpu/drm/amd/
 X:	drivers/gpu/drm/armada/
 X:	drivers/gpu/drm/etnaviv/
diff --git a/drivers/gpu/drm/Makefile b/drivers/gpu/drm/Makefile
index 784229d4504d..e35d5de2b9f0 100644
--- a/drivers/gpu/drm/Makefile
+++ b/drivers/gpu/drm/Makefile
@@ -59,7 +59,6 @@ drm-y := \
 	drm_ioctl.o \
 	drm_lease.o \
 	drm_managed.o \
-	drm_mm.o \
 	drm_mode_config.o \
 	drm_mode_object.o \
 	drm_modes.o \
diff --git a/drivers/gpu/drm/drm_print.c b/drivers/gpu/drm/drm_print.c
index 0081190201a7..2a8a5e0d691e 100644
--- a/drivers/gpu/drm/drm_print.c
+++ b/drivers/gpu/drm/drm_print.c
@@ -34,6 +34,7 @@
 #include <drm/drm.h>
 #include <drm/drm_drv.h>
 #include <drm/drm_print.h>
+#include <drm/drm_mm.h>
 
 /*
  * __drm_debug: Enable debug output.
@@ -267,6 +268,44 @@ void drm_printf(struct drm_printer *p, const char *f, ...)
 }
 EXPORT_SYMBOL(drm_printf);
 
+static u64 drm_mm_dump_hole(struct drm_printer *p, const struct drm_mm_node *entry)
+{
+	u64 start, size;
+
+	size = entry->hole_size;
+	if (size) {
+		start = drm_mm_hole_node_start(entry);
+		drm_printf(p, "%#018llx-%#018llx: %llu: free\n",
+			   start, start + size, size);
+	}
+
+	return size;
+}
+/**
+ * drm_mm_print - print allocator state
+ * @mm: drm_mm allocator to print
+ * @p: DRM printer to use
+ */
+void drm_mm_print(const struct drm_mm *mm, struct drm_printer *p)
+{
+	const struct drm_mm_node *entry;
+	u64 total_used = 0, total_free = 0, total = 0;
+
+	total_free += drm_mm_dump_hole(p, &mm->head_node);
+
+	drm_mm_for_each_node(entry, mm) {
+		drm_printf(p, "%#018llx-%#018llx: %llu: used\n", entry->start,
+			   entry->start + entry->size, entry->size);
+		total_used += entry->size;
+		total_free += drm_mm_dump_hole(p, entry);
+	}
+	total = total_free + total_used;
+
+	drm_printf(p, "total: %llu, used %llu free %llu\n", total,
+		   total_used, total_free);
+}
+EXPORT_SYMBOL(drm_mm_print);
+
 /**
  * drm_print_bits - print bits to a &drm_printer stream
  *
diff --git a/lib/Makefile b/lib/Makefile
index 773adf88af41..320ae0ac227c 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -58,6 +58,7 @@ obj-$(CONFIG_TEST_HEXDUMP) += test_hexdump.o
 obj-y += kstrtox.o
 obj-$(CONFIG_FIND_BIT_BENCHMARK) += find_bit_benchmark.o
 obj-$(CONFIG_TEST_BPF) += test_bpf.o
+lib-$(CONFIG_DRM) += drm_mm.o
 test_dhry-objs := dhry_1.o dhry_2.o dhry_run.o
 obj-$(CONFIG_TEST_DHRY) += test_dhry.o
 obj-$(CONFIG_TEST_FIRMWARE) += test_firmware.o
diff --git a/drivers/gpu/drm/drm_mm.c b/lib/drm_mm.c
similarity index 95%
rename from drivers/gpu/drm/drm_mm.c
rename to lib/drm_mm.c
index 5ace481c1901..c6feaf325fac 100644
--- a/drivers/gpu/drm/drm_mm.c
+++ b/lib/drm_mm.c
@@ -126,14 +126,14 @@ static void show_leaks(struct drm_mm *mm)
 
 	list_for_each_entry(node, drm_mm_nodes(mm), node_list) {
 		if (!node->stack) {
-			DRM_ERROR("node [%08llx + %08llx]: unknown owner\n",
-				  node->start, node->size);
+			pr_err("node [%08llx + %08llx]: unknown owner\n",
+			       node->start, node->size);
 			continue;
 		}
 
 		stack_depot_snprint(node->stack, buf, BUFSZ, 0);
-		DRM_ERROR("node [%08llx + %08llx]: inserted at\n%s",
-			  node->start, node->size, buf);
+		pr_err("node [%08llx + %08llx]: inserted at\n%s",
+		       node->start, node->size, buf);
 	}
 
 	kfree(buf);
@@ -151,7 +151,7 @@ static void show_leaks(struct drm_mm *mm) { }
 
 INTERVAL_TREE_DEFINE(struct drm_mm_node, rb,
 		     u64, __subtree_last,
-		     START, LAST, static inline, drm_mm_interval_tree)
+		     START, LAST, static inline __maybe_unused, drm_mm_interval_tree)
 
 struct drm_mm_node *
 __drm_mm_interval_first(const struct drm_mm *mm, u64 start, u64 last)
@@ -966,41 +966,3 @@ void drm_mm_takedown(struct drm_mm *mm)
 		show_leaks(mm);
 }
 EXPORT_SYMBOL(drm_mm_takedown);
-
-static u64 drm_mm_dump_hole(struct drm_printer *p, const struct drm_mm_node *entry)
-{
-	u64 start, size;
-
-	size = entry->hole_size;
-	if (size) {
-		start = drm_mm_hole_node_start(entry);
-		drm_printf(p, "%#018llx-%#018llx: %llu: free\n",
-			   start, start + size, size);
-	}
-
-	return size;
-}
-/**
- * drm_mm_print - print allocator state
- * @mm: drm_mm allocator to print
- * @p: DRM printer to use
- */
-void drm_mm_print(const struct drm_mm *mm, struct drm_printer *p)
-{
-	const struct drm_mm_node *entry;
-	u64 total_used = 0, total_free = 0, total = 0;
-
-	total_free += drm_mm_dump_hole(p, &mm->head_node);
-
-	drm_mm_for_each_node(entry, mm) {
-		drm_printf(p, "%#018llx-%#018llx: %llu: used\n", entry->start,
-			   entry->start + entry->size, entry->size);
-		total_used += entry->size;
-		total_free += drm_mm_dump_hole(p, entry);
-	}
-	total = total_free + total_used;
-
-	drm_printf(p, "total: %llu, used %llu free %llu\n", total,
-		   total_used, total_free);
-}
-EXPORT_SYMBOL(drm_mm_print);
-- 
2.43.5


