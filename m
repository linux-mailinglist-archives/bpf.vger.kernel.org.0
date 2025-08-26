Return-Path: <bpf+bounces-66518-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 690A7B35580
	for <lists+bpf@lfdr.de>; Tue, 26 Aug 2025 09:24:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F88417A065
	for <lists+bpf@lfdr.de>; Tue, 26 Aug 2025 07:24:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 526E923D2BF;
	Tue, 26 Aug 2025 07:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YGYw1Jcd"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 381F627F011;
	Tue, 26 Aug 2025 07:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756192900; cv=none; b=a6jQ6aj1AabuRDpwvW2bkMW4TEbGMkeqdHmZ/9hUMOlz+KCBUmQ5CdtEacGU4aeAkMlOdmOTOPX2qI1O6r5rC5tZ30qMHM5nfaLlENLj2iDsWTNGwvVmk1kiozgbjOVDzbCRkZJKjprvLZuwFOuUTLOAZA/0ncFwQa+MtYUkVfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756192900; c=relaxed/simple;
	bh=e9ucZJWwjfk4utxd3K4/ijLy5PQrcpiul2JEloToIFA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ggX+guyOWuGZGe3nrT/qSU1GSsZlnUtUVrE0EGWnPSTe01jALl2C0YtpKJyw2IAQxv3jC8nWEC6J7PTbp15mYqSkERbA1geaEgh89HJFxMzsWV03289kGEaN0USKnY4SToCh/0ho3P9nvILKKb8P7ZYT0uR2KmbSoBPHiNtU7iI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YGYw1Jcd; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-77057c4d88bso1743408b3a.2;
        Tue, 26 Aug 2025 00:21:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756192898; x=1756797698; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bz96bAWfKvUeaQwW9qQof1i2mU24aQ5U0XcdPEkrqrU=;
        b=YGYw1JcdMgp4RuQkO2NzR9MHGHiKLoR9wD1pr58mJXgv/3/3t1uZrS1iWTmSM4jJPM
         smhTcLgjKaQcIFhRxyKsDZk1D2XGMZVN/uIEkeb9QWiii2Vwbz4KvSSutWK2fP97vwXF
         ib8qB3JMbbveRKiDe1BRVmA1I99mcgW+00kqExUVcWTKbO4U1adJrL6Z10ngG4qRIki1
         c9ejZjNCdajMNlwBHFRiIzbNojy/MucNmMLyOd8P7rx8aeXoymIkgm00spwFAW61cWb+
         WdMx8p9nDqFIjSuHE1cszVCGR9MJv3VZERKauUbXCo07SD+CqfreviJRSjRFFmZEEtGn
         qibw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756192898; x=1756797698;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bz96bAWfKvUeaQwW9qQof1i2mU24aQ5U0XcdPEkrqrU=;
        b=c4aw/p5Rg96Ur/Z4mkuj4QdVJEJyKToVeoH7qndUfY5kCxTGzDF4tB6uA2HTnGgZrQ
         0MqbPjDxtZ2R/vjipkWXTHltcJmRuYsfmRBaNGAX96Mzsu5+17/ToMalDcbamdcgOWj5
         FLfpc9Nhwk2Q1bpUUGxGwQ5FdIMlnls/GoYnZawyC7J7cS+1LItOVQE+0G5tG1wWY0HJ
         WdxH5MyQI+CfMubJ3oRQr6+FV7C4ofkEabyocLWjUUAVtZ7hEPq+myVeEbCEPRwL1mSC
         fojV8CpMMN4gIBYJTsfxZPuR9Xe75hDAuHgRefA+4SfcWO8gvAZuoHyI+ezzD5RbQkCg
         zcjA==
X-Forwarded-Encrypted: i=1; AJvYcCU0lTUL5P5sJ48coE6OzizBqYMJeHfixOYEB1UJcP4aebB+K66qG7LigXQ0wBr+pFV2NxQbaMUqegk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzC/lYHTWlUHig6dRB9CAwN99vjaLjcndL4Wg8jq8FPPZHf+5mZ
	XViP1Q26lwECJHrNZLIcvk93y3ZvgZ253oVlda7Hjf2MnuhC8bZpZYV6
X-Gm-Gg: ASbGncsbXgjKSA/emMW2De00EFvKOPylbAq1M2rOOwZ4p44QMxfz2poFbSix9a13AXH
	hiFFRklqZKIclJ0jx4HvVtpyX8+3zZzoGAFR5e6k0+32pRBpE7kCS3hbWPyHQvOTEG2ANQ7dCPT
	tCHSMqEpwnD9uxktjGAGvwW+GZfspm2MlbN/QHSGzls/39PY0+vYc6zPZgq99lbSSaUWqse7+eS
	oRRTCMJSyUC+sduN8zJ/sJFyabJj+h3ybBa+9uXAEiJVhlcN1iFi3eoIErLwMV6oVYNPqSAkiQ5
	lj1PEiwTcFn4T0QvhKeRo7MeuzRF2IqmqLE6eLbpMyIhHcQM2EJcWlQ5+bfTwIl+qE8bkh//o8X
	sEjM/BokvplplA3MDAHA+CLeTUJyIF07QzCAE4zDJe3wcp2kG3xqkJe5JkhHyTIKmVlz0ovWKMz
	Qvagjncpb4uQ++FQ==
X-Google-Smtp-Source: AGHT+IHYvLUPX3UVhLFe8oerWPn+sp10WcjZPcf8Lvgh+d7IM89u6xbawEntdDvzZ3ZPexMDp+HCUw==
X-Received: by 2002:a05:6a00:4189:b0:771:e2f7:5a12 with SMTP id d2e1a72fcca58-771e2f75d15mr9184474b3a.6.1756192898165;
        Tue, 26 Aug 2025 00:21:38 -0700 (PDT)
Received: from localhost.localdomain ([101.82.213.56])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-770401ecc51sm9686052b3a.75.2025.08.26.00.21.26
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 26 Aug 2025 00:21:37 -0700 (PDT)
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
	corbet@lwn.net
Cc: bpf@vger.kernel.org,
	linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH v6 mm-new 08/10] selftests/bpf: add test cases for invalid thp_adjust usage
Date: Tue, 26 Aug 2025 15:19:46 +0800
Message-Id: <20250826071948.2618-9-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
In-Reply-To: <20250826071948.2618-1-laoar.shao@gmail.com>
References: <20250826071948.2618-1-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

1. The trusted VMA pointer can be null and must be checked before
   dereferencing.
2. Resources acquired via bpf_mm_get_task() must be released with
   bpf_task_release().
3. Memory groups obtained through bpf_mm_get_mem_cgroup() must be released
   using bpf_put_mem_cgroup().

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 .../selftests/bpf/prog_tests/thp_adjust.c     |  7 +++++
 .../bpf/progs/test_thp_adjust_trusted_vma.c   | 27 +++++++++++++++++++
 .../progs/test_thp_adjust_unreleased_memcg.c  | 24 +++++++++++++++++
 .../progs/test_thp_adjust_unreleased_task.c   | 25 +++++++++++++++++
 4 files changed, 83 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/test_thp_adjust_trusted_vma.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_thp_adjust_unreleased_memcg.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_thp_adjust_unreleased_task.c

diff --git a/tools/testing/selftests/bpf/prog_tests/thp_adjust.c b/tools/testing/selftests/bpf/prog_tests/thp_adjust.c
index 6e65d7b0eb80..846679acaff2 100644
--- a/tools/testing/selftests/bpf/prog_tests/thp_adjust.c
+++ b/tools/testing/selftests/bpf/prog_tests/thp_adjust.c
@@ -11,6 +11,9 @@
 #include <test_progs.h>
 #include "cgroup_helpers.h"
 #include "test_thp_adjust.skel.h"
+#include "test_thp_adjust_trusted_vma.skel.h"
+#include "test_thp_adjust_unreleased_task.skel.h"
+#include "test_thp_adjust_unreleased_memcg.skel.h"
 
 #define LEN (16 * 1024 * 1024) /* 16MB */
 #define THP_ENABLED_FILE "/sys/kernel/mm/transparent_hugepage/enabled"
@@ -333,4 +336,8 @@ void test_thp_adjust(void)
 		subtest_thp_policy_update();
 
 	thp_adjust_destroy();
+
+	RUN_TESTS(test_thp_adjust_trusted_vma);
+	RUN_TESTS(test_thp_adjust_unreleased_task);
+	RUN_TESTS(test_thp_adjust_unreleased_memcg);
 }
diff --git a/tools/testing/selftests/bpf/progs/test_thp_adjust_trusted_vma.c b/tools/testing/selftests/bpf/progs/test_thp_adjust_trusted_vma.c
new file mode 100644
index 000000000000..caa73bebefcf
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
+SEC("struct_ops/get_suggested_order")
+__failure __msg("R1 invalid mem access 'trusted_ptr_or_null_'")
+int BPF_PROG(thp_trusted_vma, struct mm_struct *mm, struct vm_area_struct *vma__nullable,
+	     u64 vma_flags, u64 tva_flags, int orders)
+{
+	struct mem_cgroup *memcg = bpf_mm_get_mem_cgroup(vma__nullable->vm_mm);
+
+	if (!memcg)
+		return 0;
+
+	bpf_put_mem_cgroup(memcg);
+	return 1;
+}
+SEC(".struct_ops.link")
+struct bpf_thp_ops thp_memcg_ops = {
+	.get_suggested_order = (void *)thp_trusted_vma,
+};
diff --git a/tools/testing/selftests/bpf/progs/test_thp_adjust_unreleased_memcg.c b/tools/testing/selftests/bpf/progs/test_thp_adjust_unreleased_memcg.c
new file mode 100644
index 000000000000..467befebb35f
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_thp_adjust_unreleased_memcg.c
@@ -0,0 +1,24 @@
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
+SEC("struct_ops/get_suggested_order")
+__failure __msg("Unreleased reference")
+int BPF_PROG(thp_unreleased_memcg, struct mm_struct *mm, struct vm_area_struct *vma__nullable,
+	     u64 vma_flags, u64 tva_flags, int orders)
+{
+	struct mem_cgroup *memcg = bpf_mm_get_mem_cgroup(mm);
+
+	/* The memcg should be released with bpf_put_mem_cgroup() */
+	return memcg ? 0 : 1;
+}
+SEC(".struct_ops.link")
+struct bpf_thp_ops thp_memcg_ops = {
+	.get_suggested_order = (void *)thp_unreleased_memcg,
+};
diff --git a/tools/testing/selftests/bpf/progs/test_thp_adjust_unreleased_task.c b/tools/testing/selftests/bpf/progs/test_thp_adjust_unreleased_task.c
new file mode 100644
index 000000000000..50d756810412
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_thp_adjust_unreleased_task.c
@@ -0,0 +1,25 @@
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
+SEC("struct_ops/get_suggested_order")
+__failure __msg("Unreleased reference")
+int BPF_PROG(thp_unreleased_task, struct mm_struct *mm, struct vm_area_struct *vma__nullable,
+	     u64 vma_flags, u64 tva_flags, int orders)
+{
+	struct task_struct *p = bpf_mm_get_task(mm);
+
+	/* The task should be released with bpf_task_release() */
+	return p ? 0 : 1;
+}
+
+SEC(".struct_ops.link")
+struct bpf_thp_ops thp_task_ops = {
+	.get_suggested_order = (void *)thp_unreleased_task,
+};
-- 
2.47.3


