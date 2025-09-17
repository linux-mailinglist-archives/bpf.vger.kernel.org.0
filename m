Return-Path: <bpf+bounces-68627-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A0E6B7C87A
	for <lists+bpf@lfdr.de>; Wed, 17 Sep 2025 14:05:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E40A48227F
	for <lists+bpf@lfdr.de>; Wed, 17 Sep 2025 06:09:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBCAE2848AD;
	Wed, 17 Sep 2025 06:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="khs4ENA7"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f196.google.com (mail-pf1-f196.google.com [209.85.210.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 903902820DB
	for <bpf@vger.kernel.org>; Wed, 17 Sep 2025 06:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758089374; cv=none; b=R/nwd4y4WZWHdzq5FjWgbDIGLHjT5gk/Cwslj+3/p9Jq2dKLfi8AjlAEc3opsG6gwZ5GY08CdvG6zMk1KFFLD06mLeObV16D+MYIAhETCXmNf5e2L+blZDqLI7N+awVGqamOQYBg9i0MW7+vIBcL6tBklds2wPe3/dcsISRmgcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758089374; c=relaxed/simple;
	bh=51/7G50SDfjQX29eW9cyq2LILmEKrSJpjBavpe+mqxY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Aq9LSj8JAaXDt2Pvea7+y5NgjKfsvBg8SD72Y0BaK2RJE3//+d7hd6Cyi9pQyLtdMdFWWj2iNyg3+fvJIo+Bzt+aZ5T8nqthB6lTuV4zw7TuBPzXDThAGzZrjEzODMs42O6jPxefHPQx4Sowpdiuy0N0Do30qHDXAI2lTyKlAcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=khs4ENA7; arc=none smtp.client-ip=209.85.210.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f196.google.com with SMTP id d2e1a72fcca58-777ea9fa8fdso580284b3a.0
        for <bpf@vger.kernel.org>; Tue, 16 Sep 2025 23:09:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758089372; x=1758694172; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kyDiWMiReLjD3cuUzzqO54+mvDQQQch/ZsaFwMEEKa4=;
        b=khs4ENA70zTzSEeQwasRQbWFSLoI/ntuTiuVdQ66wl2gPuYgtQcPQY93c1agLZldxN
         BnJlAHkiN+hQOtZOIY0teHUXJEu84iWWGmzVdBLChT173A4x7/OAhhzkSiQ3sPrai6vB
         Ds+9DLL/skLgiXu2WYGcGPBzQ5AM2dIdMQ4g/l61U20l9tXkYdERAb+jzvIKRD+hIK27
         +CICl58b4PwOlbb7FcNQdbn9D5dlISP9vAZhI/DLRFtEFeky2wCeAhWE9/FvxDNR8IyJ
         QJqU9+5uzvcatoUqo7TOnTIwOS9iKFkxRCG9OZ9aj5wsIUqHS5XCS5jCwxp02eGG3Jsk
         8N8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758089372; x=1758694172;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kyDiWMiReLjD3cuUzzqO54+mvDQQQch/ZsaFwMEEKa4=;
        b=YggeA9rIraqWF3bPQ9XhsOUxzlYUBQsaY2ajrBYzUPzJcQwYXZCK7Iysfj5xLG+hoU
         qNE5aXiObkdNKPs6qq4+wHYWeOWNXPuXcC799skmaVOlrZYjFi2S3U01T+VTbAYl1huR
         cmavUTYaNaSOJVfOvA3zF3UOhr1AF7anZLPi0HpmasgkVQrTotdWrXvbPhWefXUmDvqA
         Dq5Te5fcCTkPCG4Shxf4WBh0lKmyIsy8JCOUwxkRQifymyRkj7BG4o/ILjrAzFF+ry6Y
         BlPioKe+wnNH37chjlGiy8pAeTJoYjK0vnzDQrM7k1aiGMT1Lm9Wxq/epnW4nRN/jUGA
         DkMA==
X-Forwarded-Encrypted: i=1; AJvYcCV/iw/2HD1EsiypSR2pll2XJwVbUU8hGGcU1CPAkUWSjADIb0FAgTQFsrFziESeA6asRUE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjhoweJ2cwnD3FYJi/JI/QX+XwBZEsPcr5Xl0nzv9kZxBCKiN5
	lqSkaog8QnO5vRSf3FXedq4e2aRUxezxna/BbBANa11ixC/cSJY9SHzA
X-Gm-Gg: ASbGncvdafrXQR10gRNnGeceny1X1FvAYEG4BTApecTg/PyPOaHgZ+fbLMXb0rrXlX9
	L1Sn5SLxghvVopTSVkAq2dcAsutxuz7YBDHiEbvMwzGEUuAUJx5vpWxvQJzNdbZ2lgkXYY0rg60
	r/sM9OOFoWETK5l0GzF5wkf6P7FY0JVuF3GHNZ9Gb/zgE/xDoh38LFhGE/9aUVXqO90rdHpN9Jf
	BcVutYBuCPSdsjm03B5O83MR3mIuPixPzCusXX7n29Jfz6xrq/qf+ALdSP291sNK5LqZT8MeryO
	FOGkAFRcuJglWmbXSSr6cFJggcrwlNvLRsZ7D7KEuLMsgD5SamfyXCxZ6Ow+W+/AvK7zyrtKAK4
	/BhUfj2axfe7XEv5Odag=
X-Google-Smtp-Source: AGHT+IFFEM1EIbQYe9i2D7pELi4P0NpqM3me2e+flUwl7koYdRajJgy/2tfq5WFDARxR7qM9PEZTOg==
X-Received: by 2002:a05:6a21:e083:b0:243:b965:1bb7 with SMTP id adf61e73a8af0-266f4bdfa13mr6737258637.19.1758089371671;
        Tue, 16 Sep 2025 23:09:31 -0700 (PDT)
Received: from 7940hx ([43.129.244.20])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b54a3aa1c54sm15845427a12.50.2025.09.16.23.09.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 23:09:31 -0700 (PDT)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: peterz@infradead.org,
	ast@kernel.org
Cc: mingo@redhat.com,
	paulmck@kernel.org,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	tzimmermann@suse.de,
	simona.vetter@ffwll.ch,
	jani.nikula@intel.com,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH v5 1/4] arch: add the macro COMPILE_OFFSETS to all the asm-offsets.c
Date: Wed, 17 Sep 2025 14:09:13 +0800
Message-ID: <20250917060916.462278-2-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250917060916.462278-1-dongml2@chinatelecom.cn>
References: <20250917060916.462278-1-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The include/generated/asm-offsets.h is generated in Kbuild during
compiling from arch/SRCARCH/kernel/asm-offsets.c. When we want to
generate another similar offset header file, circular dependency can
happen.

For example, we want to generate a offset file include/generated/test.h,
which is included in include/sched/sched.h. If we generate asm-offsets.h
first, it will fail, as include/sched/sched.h is included in asm-offsets.c
and include/generated/test.h doesn't exist; If we generate test.h first,
it can't success neither, as include/generated/asm-offsets.h is included
by it.

In x86_64, the macro COMPILE_OFFSETS is used to avoid such circular
dependency. We can generate asm-offsets.h first, and if the
COMPILE_OFFSETS is defined, we don't include the "generated/test.h".

And we define the macro COMPILE_OFFSETS for all the asm-offsets.c for this
purpose.

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
 arch/alpha/kernel/asm-offsets.c      | 1 +
 arch/arc/kernel/asm-offsets.c        | 1 +
 arch/arm/kernel/asm-offsets.c        | 2 ++
 arch/arm64/kernel/asm-offsets.c      | 1 +
 arch/csky/kernel/asm-offsets.c       | 1 +
 arch/hexagon/kernel/asm-offsets.c    | 1 +
 arch/loongarch/kernel/asm-offsets.c  | 2 ++
 arch/m68k/kernel/asm-offsets.c       | 1 +
 arch/microblaze/kernel/asm-offsets.c | 1 +
 arch/mips/kernel/asm-offsets.c       | 2 ++
 arch/nios2/kernel/asm-offsets.c      | 1 +
 arch/openrisc/kernel/asm-offsets.c   | 1 +
 arch/parisc/kernel/asm-offsets.c     | 1 +
 arch/powerpc/kernel/asm-offsets.c    | 1 +
 arch/riscv/kernel/asm-offsets.c      | 1 +
 arch/s390/kernel/asm-offsets.c       | 1 +
 arch/sh/kernel/asm-offsets.c         | 1 +
 arch/sparc/kernel/asm-offsets.c      | 1 +
 arch/um/kernel/asm-offsets.c         | 2 ++
 arch/xtensa/kernel/asm-offsets.c     | 1 +
 20 files changed, 24 insertions(+)

diff --git a/arch/alpha/kernel/asm-offsets.c b/arch/alpha/kernel/asm-offsets.c
index e9dad60b147f..1ebb05890499 100644
--- a/arch/alpha/kernel/asm-offsets.c
+++ b/arch/alpha/kernel/asm-offsets.c
@@ -4,6 +4,7 @@
  * This code generates raw asm output which is post-processed to extract
  * and format the required data.
  */
+#define COMPILE_OFFSETS
 
 #include <linux/types.h>
 #include <linux/stddef.h>
diff --git a/arch/arc/kernel/asm-offsets.c b/arch/arc/kernel/asm-offsets.c
index f77deb799175..2978da85fcb6 100644
--- a/arch/arc/kernel/asm-offsets.c
+++ b/arch/arc/kernel/asm-offsets.c
@@ -2,6 +2,7 @@
 /*
  * Copyright (C) 2004, 2007-2010, 2011-2012 Synopsys, Inc. (www.synopsys.com)
  */
+#define COMPILE_OFFSETS
 
 #include <linux/sched.h>
 #include <linux/mm.h>
diff --git a/arch/arm/kernel/asm-offsets.c b/arch/arm/kernel/asm-offsets.c
index 123f4a8ef446..2101938d27fc 100644
--- a/arch/arm/kernel/asm-offsets.c
+++ b/arch/arm/kernel/asm-offsets.c
@@ -7,6 +7,8 @@
  * This code generates raw asm output which is post-processed to extract
  * and format the required data.
  */
+#define COMPILE_OFFSETS
+
 #include <linux/compiler.h>
 #include <linux/sched.h>
 #include <linux/mm.h>
diff --git a/arch/arm64/kernel/asm-offsets.c b/arch/arm64/kernel/asm-offsets.c
index 30d4bbe68661..b6367ff3a49c 100644
--- a/arch/arm64/kernel/asm-offsets.c
+++ b/arch/arm64/kernel/asm-offsets.c
@@ -6,6 +6,7 @@
  *               2001-2002 Keith Owens
  * Copyright (C) 2012 ARM Ltd.
  */
+#define COMPILE_OFFSETS
 
 #include <linux/arm_sdei.h>
 #include <linux/sched.h>
diff --git a/arch/csky/kernel/asm-offsets.c b/arch/csky/kernel/asm-offsets.c
index d1e903579473..5525c8e7e1d9 100644
--- a/arch/csky/kernel/asm-offsets.c
+++ b/arch/csky/kernel/asm-offsets.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 // Copyright (C) 2018 Hangzhou C-SKY Microsystems co.,ltd.
+#define COMPILE_OFFSETS
 
 #include <linux/sched.h>
 #include <linux/kernel_stat.h>
diff --git a/arch/hexagon/kernel/asm-offsets.c b/arch/hexagon/kernel/asm-offsets.c
index 03a7063f9456..50eea9fa6f13 100644
--- a/arch/hexagon/kernel/asm-offsets.c
+++ b/arch/hexagon/kernel/asm-offsets.c
@@ -8,6 +8,7 @@
  *
  * Copyright (c) 2010-2012, The Linux Foundation. All rights reserved.
  */
+#define COMPILE_OFFSETS
 
 #include <linux/compat.h>
 #include <linux/types.h>
diff --git a/arch/loongarch/kernel/asm-offsets.c b/arch/loongarch/kernel/asm-offsets.c
index db1e4bb26b6a..3017c7157600 100644
--- a/arch/loongarch/kernel/asm-offsets.c
+++ b/arch/loongarch/kernel/asm-offsets.c
@@ -4,6 +4,8 @@
  *
  * Copyright (C) 2020-2022 Loongson Technology Corporation Limited
  */
+#define COMPILE_OFFSETS
+
 #include <linux/types.h>
 #include <linux/sched.h>
 #include <linux/mm.h>
diff --git a/arch/m68k/kernel/asm-offsets.c b/arch/m68k/kernel/asm-offsets.c
index 906d73230537..67a1990f9d74 100644
--- a/arch/m68k/kernel/asm-offsets.c
+++ b/arch/m68k/kernel/asm-offsets.c
@@ -9,6 +9,7 @@
  * #defines from the assembly-language output.
  */
 
+#define COMPILE_OFFSETS
 #define ASM_OFFSETS_C
 
 #include <linux/stddef.h>
diff --git a/arch/microblaze/kernel/asm-offsets.c b/arch/microblaze/kernel/asm-offsets.c
index 104c3ac5f30c..b4b67d58e7f6 100644
--- a/arch/microblaze/kernel/asm-offsets.c
+++ b/arch/microblaze/kernel/asm-offsets.c
@@ -7,6 +7,7 @@
  * License. See the file "COPYING" in the main directory of this archive
  * for more details.
  */
+#define COMPILE_OFFSETS
 
 #include <linux/init.h>
 #include <linux/stddef.h>
diff --git a/arch/mips/kernel/asm-offsets.c b/arch/mips/kernel/asm-offsets.c
index 1e29efcba46e..5debd9a3854a 100644
--- a/arch/mips/kernel/asm-offsets.c
+++ b/arch/mips/kernel/asm-offsets.c
@@ -9,6 +9,8 @@
  * Kevin Kissell, kevink@mips.com and Carsten Langgaard, carstenl@mips.com
  * Copyright (C) 2000 MIPS Technologies, Inc.
  */
+#define COMPILE_OFFSETS
+
 #include <linux/compat.h>
 #include <linux/types.h>
 #include <linux/sched.h>
diff --git a/arch/nios2/kernel/asm-offsets.c b/arch/nios2/kernel/asm-offsets.c
index e3d9b7b6fb48..88190b503ce5 100644
--- a/arch/nios2/kernel/asm-offsets.c
+++ b/arch/nios2/kernel/asm-offsets.c
@@ -2,6 +2,7 @@
 /*
  * Copyright (C) 2011 Tobias Klauser <tklauser@distanz.ch>
  */
+#define COMPILE_OFFSETS
 
 #include <linux/stddef.h>
 #include <linux/sched.h>
diff --git a/arch/openrisc/kernel/asm-offsets.c b/arch/openrisc/kernel/asm-offsets.c
index 710651d5aaae..3cc826f2216b 100644
--- a/arch/openrisc/kernel/asm-offsets.c
+++ b/arch/openrisc/kernel/asm-offsets.c
@@ -18,6 +18,7 @@
  * compile this file to assembler, and then extract the
  * #defines from the assembly-language output.
  */
+#define COMPILE_OFFSETS
 
 #include <linux/signal.h>
 #include <linux/sched.h>
diff --git a/arch/parisc/kernel/asm-offsets.c b/arch/parisc/kernel/asm-offsets.c
index 757816a7bd4b..9abfe65492c6 100644
--- a/arch/parisc/kernel/asm-offsets.c
+++ b/arch/parisc/kernel/asm-offsets.c
@@ -13,6 +13,7 @@
  *    Copyright (C) 2002 Randolph Chung <tausq with parisc-linux.org>
  *    Copyright (C) 2003 James Bottomley <jejb at parisc-linux.org>
  */
+#define COMPILE_OFFSETS
 
 #include <linux/types.h>
 #include <linux/sched.h>
diff --git a/arch/powerpc/kernel/asm-offsets.c b/arch/powerpc/kernel/asm-offsets.c
index b3048f6d3822..a4bc80b30410 100644
--- a/arch/powerpc/kernel/asm-offsets.c
+++ b/arch/powerpc/kernel/asm-offsets.c
@@ -8,6 +8,7 @@
  * compile this file to assembler, and then extract the
  * #defines from the assembly-language output.
  */
+#define COMPILE_OFFSETS
 
 #include <linux/compat.h>
 #include <linux/signal.h>
diff --git a/arch/riscv/kernel/asm-offsets.c b/arch/riscv/kernel/asm-offsets.c
index 6e8c0d6feae9..7d42d3b8a32a 100644
--- a/arch/riscv/kernel/asm-offsets.c
+++ b/arch/riscv/kernel/asm-offsets.c
@@ -3,6 +3,7 @@
  * Copyright (C) 2012 Regents of the University of California
  * Copyright (C) 2017 SiFive
  */
+#define COMPILE_OFFSETS
 
 #include <linux/kbuild.h>
 #include <linux/mm.h>
diff --git a/arch/s390/kernel/asm-offsets.c b/arch/s390/kernel/asm-offsets.c
index 95ecad9c7d7d..a8915663e917 100644
--- a/arch/s390/kernel/asm-offsets.c
+++ b/arch/s390/kernel/asm-offsets.c
@@ -4,6 +4,7 @@
  * This code generates raw asm output which is post-processed to extract
  * and format the required data.
  */
+#define COMPILE_OFFSETS
 
 #include <linux/kbuild.h>
 #include <linux/sched.h>
diff --git a/arch/sh/kernel/asm-offsets.c b/arch/sh/kernel/asm-offsets.c
index a0322e832845..429b6a763146 100644
--- a/arch/sh/kernel/asm-offsets.c
+++ b/arch/sh/kernel/asm-offsets.c
@@ -8,6 +8,7 @@
  * compile this file to assembler, and then extract the
  * #defines from the assembly-language output.
  */
+#define COMPILE_OFFSETS
 
 #include <linux/stddef.h>
 #include <linux/types.h>
diff --git a/arch/sparc/kernel/asm-offsets.c b/arch/sparc/kernel/asm-offsets.c
index 3d9b9855dce9..6e660bde48dd 100644
--- a/arch/sparc/kernel/asm-offsets.c
+++ b/arch/sparc/kernel/asm-offsets.c
@@ -10,6 +10,7 @@
  *
  * On sparc, thread_info data is static and TI_XXX offsets are computed by hand.
  */
+#define COMPILE_OFFSETS
 
 #include <linux/sched.h>
 #include <linux/mm_types.h>
diff --git a/arch/um/kernel/asm-offsets.c b/arch/um/kernel/asm-offsets.c
index 1fb12235ab9c..a69873aa697f 100644
--- a/arch/um/kernel/asm-offsets.c
+++ b/arch/um/kernel/asm-offsets.c
@@ -1 +1,3 @@
+#define COMPILE_OFFSETS
+
 #include <sysdep/kernel-offsets.h>
diff --git a/arch/xtensa/kernel/asm-offsets.c b/arch/xtensa/kernel/asm-offsets.c
index da38de20ae59..cfbced95e944 100644
--- a/arch/xtensa/kernel/asm-offsets.c
+++ b/arch/xtensa/kernel/asm-offsets.c
@@ -11,6 +11,7 @@
  *
  * Chris Zankel <chris@zankel.net>
  */
+#define COMPILE_OFFSETS
 
 #include <asm/processor.h>
 #include <asm/coprocessor.h>
-- 
2.51.0


