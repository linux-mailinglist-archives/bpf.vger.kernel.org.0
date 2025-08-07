Return-Path: <bpf+bounces-65192-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EA1BFB1D6E6
	for <lists+bpf@lfdr.de>; Thu,  7 Aug 2025 13:47:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B47E7189DD56
	for <lists+bpf@lfdr.de>; Thu,  7 Aug 2025 11:48:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 122F820B7F9;
	Thu,  7 Aug 2025 11:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O3ujYtb2"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36474196C7C
	for <bpf@vger.kernel.org>; Thu,  7 Aug 2025 11:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754567268; cv=none; b=tzAjHvavTAeoSCCKapOJKijD+Ms6WtCOvX4F4Iyt/SHzD0qS8VldzIkFaxgI3vNI1asCkuW6wDZf9PXlVVuQduA0eLpbWqmHsuI8Mq+EQHU541whCkOVgOS0aSYELegmhE9qg5cmWodl/PlRuBujje4tT3UTtCf+fZF43m2/04s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754567268; c=relaxed/simple;
	bh=FbM8e55i/TVMuFbLX+36UV14JKryKqxj2cObTjh2clo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UAmIsit1da+SoDNh8vaLtQSk8VG2PDbNHmn+zbjFIzrKyNHlbo0nZkqqWwKkvc+Xmb0L+d4PIGTkUmHxqumPYt49/y5NB3Oz/HhbgI0I0RYoWgO/aNJf8OJtaIVqlkWp8tqmyTuJXSSGbvtOwWsJ+AZ2rTfkAVxY6hJg8N7hpjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O3ujYtb2; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-b4245235a77so690428a12.1
        for <bpf@vger.kernel.org>; Thu, 07 Aug 2025 04:47:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754567266; x=1755172066; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pzqFBGfMoIUPnqGeLoHxxzDih+VSXkXEyY0DPj0l7Lw=;
        b=O3ujYtb26kwdvwBjzlfLMsJF8pYrn8QAxjKWXBnGFYyvd1wYDS+2UazsAjAMI5ZVwk
         D96Mvs5vpKP+ufuF2mkTatlYK088ldBV58GtCNxS2eRyjixw29lTRw90NzpVGVZk9qNC
         EV+UdQ5VGkb5wvwn/Qu85ejqoFPaOoq5nqYq1OkjTIKcO8TH1r/GNsxfNN6siWihBHfz
         w8tc2EepgofsBHouMvYsUgw40OVPFMzNSdDSB9D/otWOkYxQ2UkXWf3KiLDVYUtGqrYX
         zC5oDSlB/10HrkNtEf1b1Q7bhMXVoxyM66J2MahZ8OQOrjOgfHcF5GZGshSgyx0Tn9rj
         ju7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754567266; x=1755172066;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pzqFBGfMoIUPnqGeLoHxxzDih+VSXkXEyY0DPj0l7Lw=;
        b=iAyeKI8ByZFcvx6J8kQ9UciOFgTFtR/DRrhiVPcd0ksNLLp5sl6aXzUgWhNuo/H0Tq
         S2+Hv0t/lN9yEJ4CtwPo1Rr0j2BqsksbMIIR1z1bosYMP40MvEMx+6lznNVJIMlsodvr
         +wMfEwCdVGrTKVXyxqgDTo53TfGwTYulgdQvQRpfFjhxAhTHRtT3PPVtCe27zjDkyQxa
         +VwUuiu7k7x32DXM+p5yXUA9nCol5h1LFLU+I4fI3I8D50/ZXSrlw/P7g9x1ZEpQHTSZ
         cSXQmbRNreSTJzX2b0fgBSxw2kHnNCImk2n7Mpp+YGYj+ttZRZe71ALiTRxVdJ0LPJlz
         b/BQ==
X-Gm-Message-State: AOJu0YyevDhE1MUt2oErSCvicO5Lv0LNmfGoupjcDmwJmw3lXmxsincZ
	Llcb9MXpFdZAcVSFNKD9e7PwKqxudVQ7KELtbZNYL3YRaPvtPfWfGBQ5/DM0OVD8J1Q=
X-Gm-Gg: ASbGncsu2xZ6QcK6SjeKuXppLTF30N2IkJhMWk4pkMcxuMGhp9DddNs+lP4GWMSfG7j
	QV5Ggl03mHYfIGhgUkG+xtEKB8t8ai5hsW/Ql5aOm0wD9G10NeC2ImsIj4xRV93usgU1rI5U31J
	Pb+x56YPbNMbkqoCGhPp2tN2EUSu5Ww/AsRP69NRK+CA4qDQUXsCuTInb4ycMA0+PpAQvFvLVJU
	Li44j23eGOWUIuJu9cfv9ttCFOH2xTHIaODCJfljb4Ld8DW0F75itwKgPaKRriTkS31qp1ZJEhf
	0y1CG3pOhlWTLU4fh/r5xoa1v0dTsgqI9VKg1rW6Z3oEZ4Qu1FGISJjNUxZqy3iCc2XnRXPCb2r
	jNKvsqfDR3kd0+hpJAuOQBkMX3SmuSJ407SVCnZKyF85U5W8ufCD0Rol6LDyr4KAHyh/f
X-Google-Smtp-Source: AGHT+IFPfcJeTYRTiS4Am1e3ICIAMA0s+W2mDhKAXeJBrGp61Wxuh8erinyX2UOIvSN+8LuPNZHGAw==
X-Received: by 2002:a17:903:1ac3:b0:242:29e1:38f0 with SMTP id d9443c01a7336-242a0ae634fmr90802905ad.24.1754567266095;
        Thu, 07 Aug 2025 04:47:46 -0700 (PDT)
Received: from localhost.localdomain ([14.22.11.162])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-b422bae2fe7sm15803335a12.44.2025.08.07.04.47.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Aug 2025 04:47:45 -0700 (PDT)
From: Hengqi Chen <hengqi.chen@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev
Cc: hengqi.chen@gmail.com
Subject: [PATCH] selftests/bpf: Use vmlinux.h for BPF programs
Date: Thu,  7 Aug 2025 11:47:32 +0000
Message-ID: <20250807114732.410177-1-hengqi.chen@gmail.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some of the bpf test progs still use linux/libc headers.
Let's use vmlinux.h instead like the rest of test progs.
This will also ease cross compiling.

No functional changes intended.

Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>
---
 tools/testing/selftests/bpf/progs/loop1.c         |  7 +------
 tools/testing/selftests/bpf/progs/loop2.c         |  7 +------
 tools/testing/selftests/bpf/progs/loop3.c         |  7 +------
 tools/testing/selftests/bpf/progs/loop6.c         | 10 +---------
 tools/testing/selftests/bpf/progs/test_overhead.c |  5 +----
 5 files changed, 5 insertions(+), 31 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/loop1.c b/tools/testing/selftests/bpf/progs/loop1.c
index 50e66772c046..b0fa26fb4760 100644
--- a/tools/testing/selftests/bpf/progs/loop1.c
+++ b/tools/testing/selftests/bpf/progs/loop1.c
@@ -1,11 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 // Copyright (c) 2019 Facebook
-#include <linux/sched.h>
-#include <linux/ptrace.h>
-#include <stdint.h>
-#include <stddef.h>
-#include <stdbool.h>
-#include <linux/bpf.h>
+#include "vmlinux.h"
 #include <bpf/bpf_helpers.h>
 #include <bpf/bpf_tracing.h>
 
diff --git a/tools/testing/selftests/bpf/progs/loop2.c b/tools/testing/selftests/bpf/progs/loop2.c
index 947bb7e988c2..0227409d4b0e 100644
--- a/tools/testing/selftests/bpf/progs/loop2.c
+++ b/tools/testing/selftests/bpf/progs/loop2.c
@@ -1,11 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 // Copyright (c) 2019 Facebook
-#include <linux/sched.h>
-#include <linux/ptrace.h>
-#include <stdint.h>
-#include <stddef.h>
-#include <stdbool.h>
-#include <linux/bpf.h>
+#include "vmlinux.h"
 #include <bpf/bpf_helpers.h>
 #include <bpf/bpf_tracing.h>
 
diff --git a/tools/testing/selftests/bpf/progs/loop3.c b/tools/testing/selftests/bpf/progs/loop3.c
index 717dab14322b..5d1c9a775e6b 100644
--- a/tools/testing/selftests/bpf/progs/loop3.c
+++ b/tools/testing/selftests/bpf/progs/loop3.c
@@ -1,11 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 // Copyright (c) 2019 Facebook
-#include <linux/sched.h>
-#include <linux/ptrace.h>
-#include <stdint.h>
-#include <stddef.h>
-#include <stdbool.h>
-#include <linux/bpf.h>
+#include "vmlinux.h"
 #include <bpf/bpf_helpers.h>
 #include <bpf/bpf_tracing.h>
 
diff --git a/tools/testing/selftests/bpf/progs/loop6.c b/tools/testing/selftests/bpf/progs/loop6.c
index e4ff97fbcce1..f8e2628c1083 100644
--- a/tools/testing/selftests/bpf/progs/loop6.c
+++ b/tools/testing/selftests/bpf/progs/loop6.c
@@ -1,8 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 
-#include <linux/ptrace.h>
-#include <stddef.h>
-#include <linux/bpf.h>
+#include "vmlinux.h"
 #include <bpf/bpf_helpers.h>
 #include <bpf/bpf_tracing.h>
 #include "bpf_misc.h"
@@ -26,12 +24,6 @@ char _license[] SEC("license") = "GPL";
 #define SG_CHAIN	0x01UL
 #define SG_END		0x02UL
 
-struct scatterlist {
-	unsigned long   page_link;
-	unsigned int    offset;
-	unsigned int    length;
-};
-
 #define sg_is_chain(sg)		((sg)->page_link & SG_CHAIN)
 #define sg_is_last(sg)		((sg)->page_link & SG_END)
 #define sg_chain_ptr(sg)	\
diff --git a/tools/testing/selftests/bpf/progs/test_overhead.c b/tools/testing/selftests/bpf/progs/test_overhead.c
index abb7344b531f..5edf3cdc213d 100644
--- a/tools/testing/selftests/bpf/progs/test_overhead.c
+++ b/tools/testing/selftests/bpf/progs/test_overhead.c
@@ -1,9 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright (c) 2019 Facebook */
-#include <stdbool.h>
-#include <stddef.h>
-#include <linux/bpf.h>
-#include <linux/ptrace.h>
+#include "vmlinux.h"
 #include <bpf/bpf_helpers.h>
 #include <bpf/bpf_tracing.h>
 
-- 
2.43.5


