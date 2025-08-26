Return-Path: <bpf+bounces-66516-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 63E20B3557C
	for <lists+bpf@lfdr.de>; Tue, 26 Aug 2025 09:24:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F1CC5E32E0
	for <lists+bpf@lfdr.de>; Tue, 26 Aug 2025 07:24:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 127162FE570;
	Tue, 26 Aug 2025 07:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MKlfDZIF"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB1402FF156;
	Tue, 26 Aug 2025 07:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756192882; cv=none; b=U4R3WLSnzdUNFurPzIbH/XIuYDID8d6V+MgC2bXSJxNtO5FqRpgR63xwercl0vcaD6kaV3jx9qItK1qTrNEKEAavw9X2veq+Czq64Bq7cfMY+T4Bn77fp/4x6jjiTtX487vIZQiqpUUMiCBX4ixMOtXvS1MMRenvilw0tWp12Bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756192882; c=relaxed/simple;
	bh=cdI17qZpik1k8f+s2oy2XAUBBWiRnvl3VmgbreY8Lhw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YpFjbkYplR3mwSHQOI9TPhdkmgmXio+i0Am+GDHQglh3s7wyNkQHjbFS0YQhafWRGRDg8lEUn295Qv2K9M+PHP1iQc4rfIvd4IIRrGnhCmUqMuo40Xcxolsc0Jd4GrVVgc8oee2Jc6EUmqgVV0FFFEro3fX+usWhJQdXKDJZoQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MKlfDZIF; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-76e2ea933b7so4624972b3a.1;
        Tue, 26 Aug 2025 00:21:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756192877; x=1756797677; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yNFSBCN6lqIthB1BT4X2pG6EGdMuodbSotRt2MhRMUc=;
        b=MKlfDZIFY/5RAwhQ7E/YEKEwi/ChL0YhZ7Iw6d/WejjWcwbvd5rolJA6uKzR/6ru57
         r561Q/wsaPGTCg+6VAehwnqG2FXhXKKcTnkse2l7ArkzUXNKlca7cXvKzE82SHQ8vxyP
         eIIStnaV88XCJgAy3nO70zCBN5LZfg8iej7zvC/USZehSKvRb1hEC3nAFjrRS9RNGGfa
         Nz/IKlOelezfAZ7rTyCtn9tDczl79rKtQoLJe5izcaPBZBa+Ecd91QC+hgx3RvdL64un
         Hl+2hAs++3s0/+vPvHpxm6DkCzlN6+Wn9hB72A2ShsBI6XobA8289NejDdlnea3OjhME
         BPeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756192877; x=1756797677;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yNFSBCN6lqIthB1BT4X2pG6EGdMuodbSotRt2MhRMUc=;
        b=hI/VEL1NVtvPVpm95iKr8ZMgPSucN8jIp8aV9M2/yZDoUez6Ow/OMxBAXYuFXSd/V9
         pAAHBP3wMFBK3GdmsCWpgHpm3NueiTcMsuS5BrX50DlO8w3L58rzJ8HD2t/JGZom/VXq
         VWTsXtRfy8E19SOyT5xoWDQ2owAdK6aqegKQqleh+pDE18VSuP7VefP2lweuN2wmy3eS
         OdAklHRVltRtSVIQF4kAH+dd8PRAHdTI2SzfaZ8die5irjrAdectSOfD2gT4FAyDMGuC
         IRoM3NBW4ZZlIl+6/zVZsSSa+/S4+/HtyI+0roymp8ZKlmrmp+EVV8rP/MITHlBlkFmm
         UtpQ==
X-Forwarded-Encrypted: i=1; AJvYcCVyHP47oFhDN6q4Tv7E0S2CK6f2Uhn+epYa5xe9Eo0Gx/RZx1jPQkWqvxcZeZ5gU22oA1lif6+RRO8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+9XzY2r4uFiMyodFTWx0LdOtzgqkVcOzGkmwqwVzV/Fw2qxwB
	ZPZCUduifnoZyqPlbOKUGVwk6QbVaS+EoxbYqxWWP1KlsLKCnKu7+qen
X-Gm-Gg: ASbGncvNBNIMcwRM5OsWUBaTLV7rFjFIBAX0NJc3+n3inTXxJF0VYfNbV9MYwu5rBYd
	a9hzci2Nw/4txSuwlR7eprqcHTs7PXLzN02QepWsxJff2GkHL2X/nsqcBxWi0A5mpvNSxbpEMeh
	CSkXEppmrYc4RstMIvLKh3JvoZeZnfr+MV85xfQsGiQVRuNUuQnQG176mCQFwzVIqKIuN0xRdp2
	jrf8RcL/kT+8jYePzmHSpB5Mjaoev7iHij0aFMfp9H4nokdaXhSPlrXDZkllxOl7mzd22Kh4guS
	z4fD3JZVNUf4gg/8tc+AuPg9QaDMY9AgFtfxFmg3JpPS86oHfsvycKPQe5Hw6I0hMkOMQQNq1dL
	/D3SjsKKCTAXANr0frp8Pd+2HzwcPM54/dwQCAA5AT34nw9/+rXA/4GKVEB8rIyV0Yp3QjVG/YE
	3FYGJ9vAff55QqCfV83G0w7vPu
X-Google-Smtp-Source: AGHT+IHAlItJ4D9z1T4pSNCT/Cf5usyVIQcZ0V+oVX5SZibP+hWnTdYG9tcFTQj+hZZZU5jqvd6JwQ==
X-Received: by 2002:a05:6a00:3392:b0:76e:277c:32f7 with SMTP id d2e1a72fcca58-771fc293b43mr688451b3a.9.1756192876804;
        Tue, 26 Aug 2025 00:21:16 -0700 (PDT)
Received: from localhost.localdomain ([101.82.213.56])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-770401ecc51sm9686052b3a.75.2025.08.26.00.21.07
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 26 Aug 2025 00:21:16 -0700 (PDT)
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
Subject: [PATCH v6 mm-new 06/10] selftests/bpf: add test case for khugepaged fork
Date: Tue, 26 Aug 2025 15:19:44 +0800
Message-Id: <20250826071948.2618-7-laoar.shao@gmail.com>
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

In this test case, the parent is allowed to alloc THP, but the child
forked by it can't alloc THP.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 .../selftests/bpf/prog_tests/thp_adjust.c     | 59 +++++++++++++++++++
 .../selftests/bpf/progs/test_thp_adjust.c     | 39 ++++++++++++
 2 files changed, 98 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/thp_adjust.c b/tools/testing/selftests/bpf/prog_tests/thp_adjust.c
index a4a34ee28301..bf367c6e6f52 100644
--- a/tools/testing/selftests/bpf/prog_tests/thp_adjust.c
+++ b/tools/testing/selftests/bpf/prog_tests/thp_adjust.c
@@ -1,5 +1,11 @@
 // SPDX-License-Identifier: GPL-2.0
 
+#define _GNU_SOURCE
+#include <sched.h>
+#include <sys/wait.h>
+#include <sys/syscall.h>
+#include <linux/sched.h>
+
 #include <math.h>
 #include <sys/mman.h>
 #include <test_progs.h>
@@ -170,6 +176,57 @@ static void subtest_thp_policy(void)
 	bpf_link__destroy(ops_link);
 }
 
+/*
+ * In this test case, we clone the child process directly into the root cgroup.
+ * Consequently, the child process is not permitted to alloc THP.
+ */
+static void subtest_thp_fork(void)
+{
+	struct clone_args args = {
+		.flags = CLONE_INTO_CGROUP,
+		.exit_signal = SIGCHLD,
+	};
+	struct bpf_link *ops_link;
+	int status, err;
+	pid_t pid;
+
+	skel->bss->ppid = getpid();
+	if (!ASSERT_GT(skel->bss->ppid, 0, "getpid"))
+		return;
+	args.cgroup = get_root_cgroup();
+	if (!ASSERT_GE(args.cgroup, 0, "get_root_cgrp_fd"))
+		return;
+
+	ops_link = bpf_map__attach_struct_ops(skel->maps.thp_fork_ops);
+	if (!ASSERT_OK_PTR(ops_link, "attach struct_ops"))
+		return;
+
+	pid = syscall(__NR_clone3, &args, sizeof(args));
+	if (!ASSERT_GE(pid, 0, "clone3"))
+		goto detach_ops;
+
+	if (pid == 0) {
+		/* child */
+		if (!ASSERT_NEQ(thp_alloc(), -1, "THP alloc"))
+			exit(EXIT_FAILURE);
+		thp_free();
+		exit(EXIT_SUCCESS);
+	}
+
+	err = waitpid(pid, &status, 0);
+	if (!ASSERT_EQ(err, pid, "waitpid"))
+		goto detach_ops;
+	ASSERT_EQ(skel->bss->fork_fail, 0, "fork_fail");
+	ASSERT_GT(skel->bss->fork_succeed, 0, "fork_succeed");
+
+	if (!ASSERT_NEQ(thp_alloc(), -1, "THP alloc"))
+		goto detach_ops;
+	thp_free();
+	ASSERT_GT(skel->bss->parent_succeed, 0, "parent_succeed");
+detach_ops:
+	bpf_link__destroy(ops_link);
+}
+
 static int thp_adjust_setup(void)
 {
 	int err, cgrp_fd, cgrp_id, pmd_order;
@@ -249,6 +306,8 @@ void test_thp_adjust(void)
 
 	if (test__start_subtest("alloc_in_khugepaged"))
 		subtest_thp_policy();
+	if (test__start_subtest("khugepaged_fork"))
+		subtest_thp_fork();
 
 	thp_adjust_destroy();
 }
diff --git a/tools/testing/selftests/bpf/progs/test_thp_adjust.c b/tools/testing/selftests/bpf/progs/test_thp_adjust.c
index 635915f31786..034086ce2f3d 100644
--- a/tools/testing/selftests/bpf/progs/test_thp_adjust.c
+++ b/tools/testing/selftests/bpf/progs/test_thp_adjust.c
@@ -6,6 +6,7 @@
 
 char _license[] SEC("license") = "GPL";
 
+int ppid, fork_fail, fork_succeed, parent_succeed;
 int pf_alloc, pf_disallow, khugepaged_disallow;
 struct mm_struct *target_mm;
 int pmd_order, cgrp_id;
@@ -74,3 +75,41 @@ SEC(".struct_ops.link")
 struct bpf_thp_ops khugepaged_ops = {
 	.get_suggested_order = (void *)alloc_in_khugepaged,
 };
+
+
+SEC("struct_ops/get_suggested_order")
+int BPF_PROG(thp_fork_test, struct mm_struct *mm, struct vm_area_struct *vma__nullable,
+	     u64 vma_flags, enum tva_type tva_flags, int orders)
+{
+	struct task_struct *p = bpf_get_current_task_btf();
+	struct mem_cgroup *memcg;
+	int suggested_orders = 0;
+
+	/* Only works when CONFIG_MEMCG is enabled. */
+	memcg = bpf_mm_get_mem_cgroup(mm);
+	if (!memcg)
+		return 0;
+
+	/* The tasks under this specific cgroup are allowed to alloc THP */
+	if (memcg->css.cgroup->kn->id == cgrp_id)
+		suggested_orders = orders;
+
+	if (p->parent->pid == ppid) {
+		/* The child is forked into root cgrp, so it can't alloc THP */
+		if (suggested_orders)
+			fork_fail++;
+		else
+			fork_succeed++;
+	} else if (p->pid == ppid) {
+		/* The parent can alloc THP */
+		if (suggested_orders)
+			parent_succeed++;
+	}
+	bpf_put_mem_cgroup(memcg);
+	return suggested_orders;
+}
+
+SEC(".struct_ops.link")
+struct bpf_thp_ops thp_fork_ops = {
+	.get_suggested_order = (void *)thp_fork_test,
+};
-- 
2.47.3


