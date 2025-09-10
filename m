Return-Path: <bpf+bounces-67981-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 08D8EB50BC0
	for <lists+bpf@lfdr.de>; Wed, 10 Sep 2025 04:50:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 149BE1C6449F
	for <lists+bpf@lfdr.de>; Wed, 10 Sep 2025 02:50:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D8C12472A5;
	Wed, 10 Sep 2025 02:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I502TdOZ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 431E9238C04
	for <bpf@vger.kernel.org>; Wed, 10 Sep 2025 02:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757472397; cv=none; b=X4PIq7hMMDN+Vyvk8aXJFRnChQ+osf+x0CpiwtVgtqENYUttkAjnmLI/Lm/Q8q0yPpAGJWOegoBB1+kLNRgErwr8RtjtzlxdE1GdRW62L5/i1gkSU8bgkgbxDneXKLXVk6Zxnci9xaB2es1jtQUf7VYxpnAtAARzBHi0F23R7lA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757472397; c=relaxed/simple;
	bh=4UayknTSk5EYPF15HRbCQ2hIYehol6ma4ylh+mFqd/A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eIPEwqSY7k+HA3cO71X2BWQ3ppcvpyitrgEvQoth+iYCfNAwpszA38y1cSUm7sB4mRVMpJNVQTT0t0qDlYnuxFlQK5nnvo9LGNJbUeNAZjko4cgt2od9It53pYWGM1OjOni/fYN5YcgcdRljdYMEfMrmgA2jrt9WrLzGVsA2XEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I502TdOZ; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-32b863ed6b6so5172345a91.2
        for <bpf@vger.kernel.org>; Tue, 09 Sep 2025 19:46:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757472395; x=1758077195; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+2gv1wJrgJWMZIsaNiF6AyZaglC2W+vNxpLY5k+pOlY=;
        b=I502TdOZjb1jbZP4ONtFQeLwV+IA5D+8xK2ZjQpJ7mkW1Ep7qvePcIsiHcDylCOFtw
         aui2onwuvyYF8Slz2GDkY+AvbYBW56Lf9Dp+953Tl4hbcfH6trTkL+UXKDqW+Mf40NPe
         0+cOP/+eStGO1gAs1VSODT9ARF/tg6uMBNdqUeVUyMyI3dzFsmWSUcyi4BqCGsMP46zX
         wlIAsDbNLluppgre0HXYwgi9fnY6ujiclCLqe820hIzvJfYgyeZOEOVi9B37WkfX0zWr
         +k6tGCl0fRoXYk39EBKTikL4dbX0QpSLw9WMxqd4BrIRxJm6SdGgiEztaR6T+OfUGRVL
         Lr1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757472395; x=1758077195;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+2gv1wJrgJWMZIsaNiF6AyZaglC2W+vNxpLY5k+pOlY=;
        b=oqiM9XrxCLKdzvPjI4YghEE9nHKygqtsM+Tx3fu6yz2z91CeSzkeQMy569tooZb7WY
         QVD42B/jihA7Haq/IFiPAMYn6CLEMr/Rx9e+q4/TeqfjPy0/3/PuOgsiBKdJA5fdNXi/
         tcGUgCHKhSax2a4jDIxEF5NV3F6/NDoexfFG38L5m7FKGNdb8MSzQnwTLG0l8c1KdMrX
         rCHgbAkI1VbZkQ1sVbiRgrxrTCLsGZ/smwZ9weZQLzG6X5o4rPvW066eIoPPtXboL9+W
         Qf3dGR0vuwG1hyzOhphbath2wuP7N8HDnfC0B/rhHe5IJyTfXheR1H9lvRXWVpdAM9kW
         CVnQ==
X-Gm-Message-State: AOJu0Yzg/zXUf6CdP4yKs3J4TsED2guwbbg7DWNhSWtOCBIlKX8+jWXy
	J3LflFmDJnFoqjTU4O5AR8Fd45S6pOrpV56eBpYfp62NP3V6pi6WRscw
X-Gm-Gg: ASbGnctrYVF5l8x4LZEnhIJCR1HavIKtZuKFW0fO7RzWz/DWIlIpS+poKE1VOG1DYYo
	PJuCzi53EYdkbQC4vVICW7AhN9sFUsT8fGxUlrzyzDIq+M27B5I4/QNDm3ebO5aZgOfkfhjghlM
	E6UbN3CdycoLTOtHmBDKPBimzGKthaOCuU7TTx0MPYi6X/JGdpgq6DcDP9t/a73WqePS1/Csm5I
	C8lfx6wZffypHIBrpIElr3IlCBSD6yROtUOTnJaj7olIgZxcd8NpTv9FXE3TdhbSDlMnkzPCFXR
	QvdX+uPL7YDr0V7VOhTGaCImFhs3BOe1J1SgRNbNihV1pAxkWw5a1HdqXUBj4Oovu9UGojUbI6+
	8h2M6SV0/ev73H3N1XYAgvee4afnmzQIt1uNxHUW/90yisc2L7eUGgVs/2i682iKM6V3WnvB6An
	nUCRc=
X-Google-Smtp-Source: AGHT+IF7HoYJibvAsuo8aUN7uLmw94uj7XXz4N/ZsFYwAn1QFmBP+rxV+edO5IwAqpFP8zthp2dBaw==
X-Received: by 2002:a17:90a:e7c1:b0:32b:5f76:9e29 with SMTP id 98e67ed59e1d1-32d43f9a56dmr17489450a91.32.1757472395440;
        Tue, 09 Sep 2025 19:46:35 -0700 (PDT)
Received: from localhost.localdomain ([101.82.183.17])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32dbb314bcesm635831a91.12.2025.09.09.19.46.26
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 09 Sep 2025 19:46:34 -0700 (PDT)
From: Yafang Shao <laoar.shao@gmail.com>
To: akpm@linux-foundation.org,
	david@redhat.com,
	ziy@nvidia.com,
	baolin.wang@linux.alibaba.com,
	lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com,
	npache@redhat.com,
	ryan.roberts@arm.com,
	dev.jain@arm.com,
	hannes@cmpxchg.org,
	usamaarif642@gmail.com,
	gutierrez.asier@huawei-partners.com,
	willy@infradead.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	ameryhung@gmail.com,
	rientjes@google.com,
	corbet@lwn.net,
	21cnbao@gmail.com,
	shakeel.butt@linux.dev
Cc: bpf@vger.kernel.org,
	linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH v7 mm-new 09/10] selftests/bpf: add test cases for invalid thp_adjust usage
Date: Wed, 10 Sep 2025 10:44:46 +0800
Message-Id: <20250910024447.64788-10-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
In-Reply-To: <20250910024447.64788-1-laoar.shao@gmail.com>
References: <20250910024447.64788-1-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

1. The trusted vma->vm_mm pointer can be null and must be checked before
   dereferencing.
2. The trusted mm->owner pointer can be null and must be checked before
   dereferencing.
3. Sleepable programs are prohibited because the call site operates under
   RCU protection.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 .../selftests/bpf/prog_tests/thp_adjust.c     |  7 +++++
 .../bpf/progs/test_thp_adjust_sleepable.c     | 22 ++++++++++++++
 .../bpf/progs/test_thp_adjust_trusted_owner.c | 30 +++++++++++++++++++
 .../bpf/progs/test_thp_adjust_trusted_vma.c   | 27 +++++++++++++++++
 4 files changed, 86 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/test_thp_adjust_sleepable.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_thp_adjust_trusted_owner.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_thp_adjust_trusted_vma.c

diff --git a/tools/testing/selftests/bpf/prog_tests/thp_adjust.c b/tools/testing/selftests/bpf/prog_tests/thp_adjust.c
index 30172f2ee5d5..bbe1a82345ef 100644
--- a/tools/testing/selftests/bpf/prog_tests/thp_adjust.c
+++ b/tools/testing/selftests/bpf/prog_tests/thp_adjust.c
@@ -5,6 +5,9 @@
 #include <test_progs.h>
 #include "cgroup_helpers.h"
 #include "test_thp_adjust.skel.h"
+#include "test_thp_adjust_sleepable.skel.h"
+#include "test_thp_adjust_trusted_vma.skel.h"
+#include "test_thp_adjust_trusted_owner.skel.h"
 
 #define LEN (16 * 1024 * 1024) /* 16MB */
 #define THP_ENABLED_FILE "/sys/kernel/mm/transparent_hugepage/enabled"
@@ -274,4 +277,8 @@ void test_thp_adjust(void)
 		subtest_thp_policy_update();
 
 	thp_adjust_destroy();
+
+	RUN_TESTS(test_thp_adjust_trusted_vma);
+	RUN_TESTS(test_thp_adjust_trusted_owner);
+	RUN_TESTS(test_thp_adjust_sleepable);
 }
diff --git a/tools/testing/selftests/bpf/progs/test_thp_adjust_sleepable.c b/tools/testing/selftests/bpf/progs/test_thp_adjust_sleepable.c
new file mode 100644
index 000000000000..9b92359f9789
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_thp_adjust_sleepable.c
@@ -0,0 +1,22 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+#include "bpf_misc.h"
+
+char _license[] SEC("license") = "GPL";
+
+SEC("struct_ops.s/thp_get_order")
+__failure __msg("attach to unsupported member thp_get_order of struct bpf_thp_ops")
+int BPF_PROG(thp_sleepable, struct vm_area_struct *vma, enum bpf_thp_vma_type vma_type,
+	     enum tva_type tva_type, unsigned long orders)
+{
+	return -1;
+}
+
+SEC(".struct_ops.link")
+struct bpf_thp_ops vma_ops = {
+	.thp_get_order = (void *)thp_sleepable,
+};
diff --git a/tools/testing/selftests/bpf/progs/test_thp_adjust_trusted_owner.c b/tools/testing/selftests/bpf/progs/test_thp_adjust_trusted_owner.c
new file mode 100644
index 000000000000..b3f98c2a9b43
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_thp_adjust_trusted_owner.c
@@ -0,0 +1,30 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+#include "bpf_misc.h"
+
+char _license[] SEC("license") = "GPL";
+
+SEC("struct_ops/thp_get_order")
+__failure __msg("R3 pointer arithmetic on rcu_ptr_or_null_ prohibited, null-check it first")
+int BPF_PROG(thp_trusted_owner, struct vm_area_struct *vma, enum bpf_thp_vma_type vma_type,
+	     enum tva_type tva_type, unsigned long orders)
+{
+	struct mm_struct *mm = vma->vm_mm;
+	struct task_struct *p;
+
+	if (!mm)
+		return 0;
+
+	p = mm->owner;
+	bpf_printk("The task name is %s\n", p->comm);
+	return -1;
+}
+
+SEC(".struct_ops.link")
+struct bpf_thp_ops vma_ops = {
+	.thp_get_order = (void *)thp_trusted_owner,
+};
diff --git a/tools/testing/selftests/bpf/progs/test_thp_adjust_trusted_vma.c b/tools/testing/selftests/bpf/progs/test_thp_adjust_trusted_vma.c
new file mode 100644
index 000000000000..5ce100348714
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_thp_adjust_trusted_vma.c
@@ -0,0 +1,27 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+#include "bpf_misc.h"
+
+char _license[] SEC("license") = "GPL";
+
+SEC("struct_ops/thp_get_order")
+__failure __msg("R1 invalid mem access 'trusted_ptr_or_null_'")
+int BPF_PROG(thp_trusted_vma, struct vm_area_struct *vma, enum bpf_thp_vma_type vma_type,
+	     enum tva_type tva_type, unsigned long orders)
+{
+	struct mm_struct *mm = vma->vm_mm;
+	struct task_struct *p = mm->owner;
+
+	if (!p)
+		return 0;
+	return -1;
+}
+
+SEC(".struct_ops.link")
+struct bpf_thp_ops vma_ops = {
+	.thp_get_order = (void *)thp_trusted_vma,
+};
-- 
2.47.3


