Return-Path: <bpf+bounces-43796-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 67FD39B9B54
	for <lists+bpf@lfdr.de>; Sat,  2 Nov 2024 00:55:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E04FA1F221E5
	for <lists+bpf@lfdr.de>; Fri,  1 Nov 2024 23:55:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A01991E5727;
	Fri,  1 Nov 2024 23:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DDiKusF9"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7CC719ABC5
	for <bpf@vger.kernel.org>; Fri,  1 Nov 2024 23:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730505305; cv=none; b=naqgvCUM5UFwPk69BwUDxQsaZDw9xFEYdmc030dayREbuoGNIYMWXqmuwKLA37HnczNOB4xSSgUfMSZfwmZaoZ2ztZKEZ95uE/ZjG0/k2OJVPOctASjYGEtQgV/0/BNqUL/hY1TQTDVzwv0VlPt2Cau+7RmPKl0m7MyWyUvdCVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730505305; c=relaxed/simple;
	bh=NDHW933J+2stKvzVoXWF6pWpnodkTztPllsxoCnKrKQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TlGVNuB4EIiPqEDl7AY6BxORfgHwp3H4OubOA1y+29YmGUKPXAIxTADLfHpFXhQS4/cOuU3av03NagW9oePCK4eCq0AX8f7p8K/Y/g0I3pUJoyp+MPSg7mWn/jCtfbuzX3FHCDuSl6eQXxug8Gq5xHX30xnb4EnV7DxNFIOTANk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DDiKusF9; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2e2e87153a3so1771372a91.3
        for <bpf@vger.kernel.org>; Fri, 01 Nov 2024 16:55:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730505302; x=1731110102; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pFYJ0AhPl1N4NP0iPMsWYrMdbq4jJzXJRf7VdTFBNJA=;
        b=DDiKusF9uQj4HiDE/SJm6hl/M5APa+G03aKc1m8SmYxUpG/QsNRoq9hejSuFzGQ0lQ
         fBTfdjWCh9of0U6YRaxIlS5nzEBaH+8cQo5iqtfQ/AcVi2xUN5KJ0NLJR74i5UFg/5Bj
         S3JIgdxO0MDp7DpJB5OsQr2bXmk+9oCwJCjifmJ/z1NisI6NvLQzk/nSWe7ZDTxYx8+N
         +QGdw8wApaILvRqVt763dKX4yn6RtOflOinSoKtdTipTCqn3ZKeu2Z3jGfzML8262zss
         JO5lKeDnYAv7VSFcPrditjVzovVaZNnMY88oNnG1MyiPZopy2VA4HjsAWmEvQL8If1kM
         coiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730505302; x=1731110102;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pFYJ0AhPl1N4NP0iPMsWYrMdbq4jJzXJRf7VdTFBNJA=;
        b=qnw2UzMELM0DmCOQHIYvrhL7SJpEedu7TPeG+xd+JQxATGdUPc/4Z6m0U7a/iOc6ri
         BPhMawfMbFPGzQiYrBYV7Uf00kF3gwF3NmTLD3ZcTDJ2mqnkq3kc7l896TeqvsiNJa7a
         6C20HjMLN51YDIO0fim2AZEO6XL46UkpTD0VuNFIySzVnBQ7CVsEXgh2tzqfYvKkfkYf
         fTl7IZ8tqHibUk3EjJyZ6f0ZR70kr+9E+TygZFNYFNAFMdSxf8KrvL29p5L+34eCvaZq
         FXkLH7rvhVNnsmUneaU7dyVl4qTDmfkE/XmBBBuU9AlEPeowJKfpUYNORaawFvpS8a1V
         4wzw==
X-Gm-Message-State: AOJu0YzSCu74rpXTIUqZglAvTURMDgovMiBYq8NiGyda3TtZxjwq9Zy6
	e5EJa9+tacnTal2Jv1hqd7naTLYWVVyPoNmhvFomTbC1v7WzZ8NvQbFglg==
X-Google-Smtp-Source: AGHT+IHq4pMWQt099G0CmCL+1dwO0P4OdiFXp6Fuhl8/RTIQyn1uVD9xh+Dk1RdVhu85RpnD+Z5asw==
X-Received: by 2002:a17:90a:e7c4:b0:2e2:d3ab:2d77 with SMTP id 98e67ed59e1d1-2e94c52ad6emr7099575a91.39.1730505302565;
        Fri, 01 Nov 2024 16:55:02 -0700 (PDT)
Received: from tungpham-mbp.DHCP.thefacebook.com ([2620:10d:c090:400::5:7de5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e93daad721sm3341706a91.13.2024.11.01.16.55.00
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 01 Nov 2024 16:55:02 -0700 (PDT)
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
Subject: [PATCH bpf-next 1/2] drm, bpf: Move drm_mm.c to lib to be used by bpf arena
Date: Fri,  1 Nov 2024 16:54:52 -0700
Message-Id: <20241101235453.63380-2-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20241101235453.63380-1-alexei.starovoitov@gmail.com>
References: <20241101235453.63380-1-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

Move drm_mm.c to lib. The next commit will use drm_mm to manage
memory regions in bpf arena. Move drm_mm_print to
drivers/gpu/drm/drm_print.c, since it's not a core functionality
of drm_mm and it depeneds on drm_printer while drm_mm is
generic and usuable as-is by other subsystems.
Also add __maybe_unused to suppress compiler warnings.
Update MAINTAINERS file as well.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 MAINTAINERS                       |  1 +
 drivers/gpu/drm/Makefile          |  1 -
 drivers/gpu/drm/drm_print.c       | 39 ++++++++++++++++++++++++++++++
 lib/Makefile                      |  1 +
 {drivers/gpu/drm => lib}/drm_mm.c | 40 +------------------------------
 5 files changed, 42 insertions(+), 40 deletions(-)
 rename {drivers/gpu/drm => lib}/drm_mm.c (96%)

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
index 773adf88af41..605aa25b71ab 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -58,6 +58,7 @@ obj-$(CONFIG_TEST_HEXDUMP) += test_hexdump.o
 obj-y += kstrtox.o
 obj-$(CONFIG_FIND_BIT_BENCHMARK) += find_bit_benchmark.o
 obj-$(CONFIG_TEST_BPF) += test_bpf.o
+obj-$(CONFIG_DRM) += drm_mm.o
 test_dhry-objs := dhry_1.o dhry_2.o dhry_run.o
 obj-$(CONFIG_TEST_DHRY) += test_dhry.o
 obj-$(CONFIG_TEST_FIRMWARE) += test_firmware.o
diff --git a/drivers/gpu/drm/drm_mm.c b/lib/drm_mm.c
similarity index 96%
rename from drivers/gpu/drm/drm_mm.c
rename to lib/drm_mm.c
index 5ace481c1901..45ea9864ed2e 100644
--- a/drivers/gpu/drm/drm_mm.c
+++ b/lib/drm_mm.c
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


