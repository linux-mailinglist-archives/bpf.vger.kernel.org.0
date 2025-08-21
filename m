Return-Path: <bpf+bounces-66168-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 49F09B2F424
	for <lists+bpf@lfdr.de>; Thu, 21 Aug 2025 11:39:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 911AE1C859F6
	for <lists+bpf@lfdr.de>; Thu, 21 Aug 2025 09:39:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E36B12F1FCD;
	Thu, 21 Aug 2025 09:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BGeURLtZ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f195.google.com (mail-pg1-f195.google.com [209.85.215.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 969932F0685;
	Thu, 21 Aug 2025 09:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755769104; cv=none; b=cR4xQAPgP5J7riJDRuapnTKLHPTqDZ60s683pgNyCQQACztEHS6JNs0R+ehkPOwHQ8Mo20Ug6QmaDrB7CFseGVgSVOn3NVRfvQEnt59CHDDK6Nb1lL4s+4eoX5kD0dMadVyEmmNoouiRv+Q++14bSTYSqHvjyAofJmVwoVkoPaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755769104; c=relaxed/simple;
	bh=H3nbbMh6DFmUXspQhhndw/hL2Ne9GOlz0qBRkIv+PXk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V9nt9jPuleFDXWf8UlU1xJaxi2gz53PTK9/BJGOnAECc3D1IQRIE20+f/U+4wOQQUfVEqNbF98lwBtxvaTkuBaXh3gAiRA+mISyic4s6zrKy9p5tFVJRu8zEseVZOCtAbRVLCHw2Ke4+Bw2N4vv/Mdti/qUIwEbdI8AgDmNPPiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BGeURLtZ; arc=none smtp.client-ip=209.85.215.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f195.google.com with SMTP id 41be03b00d2f7-b471738daabso675701a12.1;
        Thu, 21 Aug 2025 02:38:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755769102; x=1756373902; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yWBLnMnjRe/tJ9Xuvh/nd9/uV5uIZZike6HE1ZIhSY0=;
        b=BGeURLtZyuBPwy2hH8cDqDAlIQQXcqHTN//hhGs6JwOCU0dOrhJS9GQLlhXjr+fo7d
         Di5VBhSxzPAcm7MSRbmrHMoFaXzSw0A9fXdj54ow5QXUX/Vsyj85heJtQ4AUtdHlmYJx
         vuz4YXV/fhf/1tYg58LrNT2jTFwFKyqt+2C7ga17i4vv9A1JMqvB+rXs4WqaFwqUWBx6
         DA2Wp2GiBD+glCwz8Yx/j0BNhVEo1lKXXhIlyO7TrbxmSKeoi2iUAOzQcwKDqvVUkG0M
         awYT9ny2T+q5Frxwuol4NtbpB+LIBusqFy4Uu3SyQp76+Uem+LRD00a/6gJGEqCidhts
         afng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755769102; x=1756373902;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yWBLnMnjRe/tJ9Xuvh/nd9/uV5uIZZike6HE1ZIhSY0=;
        b=kAFCkXvwG2yvaz2INQMt5MVSs00NYlqQEre79xP9LocTyU1EU7+yWJZ+MKGwLLejsi
         AyaW/4oGddK8McPkLTCguRcX05LNKJljvQeAe69kFxqNDVSMDzhjHGnrhg0Mb1UP5Sg/
         /VkIWxQLSqM9DWtCAjUmkai4Xj0KQavBtODGuCfWr9nMRSymUu/R8sqjvSIZe7ikP/LK
         iDlZ7acCfa9C5o5EXQgMirTc6ktnF1W8RE4LlSx9qZyImzTZEr3wDDVLXMr8RMJcx2OC
         ARN8OU8NfhyhWZ4xv/LJk2Y6FdxRnii/+3wzluTuCZP9Nh304WUZnCVmU3hMLUeOKBBt
         0o4Q==
X-Forwarded-Encrypted: i=1; AJvYcCUAYZjPh9k4dssET7NeX1McNtB/aK0AUXW8byOzdryAUihxhg2ugDWaJlG4dbXTVbiXA76NXJXIsDCu/3nV@vger.kernel.org, AJvYcCUHW/hbkrD/pX61UxKxxd7kzxiBOMpZtvYnneXhfzxaRQ4bEmjZhCDTCgv9mhsIx07LTHU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsMkQMOY64iViYhN+Z6QewWiBmdfkOlrIMZ1gnPAn7H2ChTVGy
	LdunUFBASTqvGxFYM61hGoY+l1cEGWAuIvD6k6i94tuqtCI8+xmPmPwy
X-Gm-Gg: ASbGncuA7qs6W8fzpD3fCymdHZcAgjbfI7lAhkisO9epO1or3bi9/W3ZGhJ75mNKkIB
	YpSbLcedUTG8POwufKpCNiZyINOknF+I4u/YHezGwWZ1baakQhvM283VP1+wdRPi6A3vlH99oBj
	Dkxgpxt5FP+697sjZKxkGXyvsj52u8pRrMIdJg36FzwQ1TzH2j2pU07CyuDYPOBeZXHBjh4t4sm
	0Tl724EHrrvTujYIwIlI9UDclag0rsDcoUD3OH2npaiBdmdwaI5znxNZkQYxS28YhiSdtZva2c6
	61xqEK9prje3MogIkmTR5qm0oFXcqYMvwAA4yXbEGlBW3kNu55x7ecxiNMDwtV/ZcnocwpHrBiK
	V8TPoiHvVCtR9KkJTtRFKEBY8ujU6965TaQ==
X-Google-Smtp-Source: AGHT+IFDhZ+fp3uwzS50g/aI7i9nB/QIv2irpccgJ204DPlbXL7yPv538SW+ob5fmOqxEDHqkgAGQA==
X-Received: by 2002:a17:902:e88a:b0:246:1f24:5f56 with SMTP id d9443c01a7336-2461f248979mr1309275ad.7.1755769101843;
        Thu, 21 Aug 2025 02:38:21 -0700 (PDT)
Received: from 7940hx ([43.129.244.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-245ed540040sm49652085ad.163.2025.08.21.02.38.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 02:38:21 -0700 (PDT)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: peterz@infradead.org
Cc: mingo@redhat.com,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com,
	ast@kernel.org,
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
Subject: [PATCH v3 1/3] arch: add the macro COMPILE_OFFSETS to all the asm-offsets.c
Date: Thu, 21 Aug 2025 17:38:05 +0800
Message-ID: <20250821093807.49750-2-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250821093807.49750-1-dongml2@chinatelecom.cn>
References: <20250821093807.49750-1-dongml2@chinatelecom.cn>
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
2.50.1


