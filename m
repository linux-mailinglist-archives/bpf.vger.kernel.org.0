Return-Path: <bpf+bounces-75989-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C4C6CA1807
	for <lists+bpf@lfdr.de>; Wed, 03 Dec 2025 20:56:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5DCB0302C20B
	for <lists+bpf@lfdr.de>; Wed,  3 Dec 2025 19:50:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DC09238C1B;
	Wed,  3 Dec 2025 19:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U3LhG1Dh"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92889264A97
	for <bpf@vger.kernel.org>; Wed,  3 Dec 2025 19:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764791455; cv=none; b=niOs/GjtKpYtRc1sr80QpqkayOQpdrGmNbAeVlE35km/cccXnAe9ctOxPSG/e5IWCNONMDsKOpwlUMPEf7CuTr5rNbZm2TatU732Zk7zw0wIyWvxDLNNuJiPQrNtLR5XVZNP0wJbdAzAXgC7Lp5oSPbIX9MDK3c4n1+2EHxT16s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764791455; c=relaxed/simple;
	bh=TO7n2Xge9oO7TZFk4gJz2+SECUapOyqn75Bqr+qXnNM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xj55pJum2Yc/c7+fsYGkHVq4hBlQFUROdf4yfC18AUBN01UpoIK6e7XkbQD4jgEbilmStcIP08Ev4WGHVnRS2S2zqQeMeLs21p4ho9rScGSsPY3ZcYkpMNKaaQp1WSEgvggTBLFOlLlIKPB3+S69btA+1OICXIcsL2H+WbkocW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U3LhG1Dh; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2958db8ae4fso1623485ad.2
        for <bpf@vger.kernel.org>; Wed, 03 Dec 2025 11:50:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764791453; x=1765396253; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XgOttIWXfJgjczBPR9xZTna+eMm29/vqg3UHRM0Hxnw=;
        b=U3LhG1DhsOmanIh9i8eK4vODbcQGB7aACOZAx1H/+vVIbMuupf7oueSbwTSMf8jg0t
         MqbOdgVGW/XhAzMEJI0AtvpoGDiHVoYfsbF9rknKz68nO1r0TGP3DrOq30+hndc5gSji
         KuRchLH1wRwoCbhTLGC6L3C+1ae76bhXqnQeU/mKytsBPCFQex34Flh5xiIih7ShLWUg
         sPApCrHHG6HR/SDZgluvLbs76f1nGrYVHIuSuN4/s8HPnax8Lverjup1EL57yyM/orsl
         s5k3bm+R9kSvTizElnfzgom970ucC30TAbWpykAd5MPGR+zMtqgsboBkUUCY+Otm2Ei9
         mXvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764791453; x=1765396253;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XgOttIWXfJgjczBPR9xZTna+eMm29/vqg3UHRM0Hxnw=;
        b=olWD66/qEGdm11KNSPpL1I4VcfeoOSlolx2MPEM16+N+eKcf1sWi1AeTibVO4wp05Q
         ixZf2mZ1iZGHSrrJjiN9qVaM6XN8svzxeMyll+21rG0+Pwtx0JMxgMBUJeImDdVOip0n
         KDCxWGPu7Jngj3ltn8Nn8hpp5UMQOzZMcM1jBPqx/0HK7n3bNKjMB/SPv8V5LI+qX452
         PWViFoI5X1BM7A6hBflkkWbdv5f2TIZP67VssAtlNtGVsbwTcOemdA1ycKyNpo4eqd22
         NwcMd2s5DU2M9unPkF3UOAZa+2mO4KwitRtzFLD1DabXYFxfX7pvbqZiXRaGCfdZhqBg
         fxwA==
X-Gm-Message-State: AOJu0YwyobvFwlaGUDK9lPXncOfsrdKHs+7CXNljsORzdqYTT6nOOEM/
	rP/POp+0b61kAPYkdsgaCVxfGYe4/oTUt+uKc3vO7wQjJgvuU/VWYz7wcbH3Bw==
X-Gm-Gg: ASbGncugrFVCEzLLpXv5Ai6VYbeA0eK1127rjPoOXv85lxqwgerLN4JjppXjy6hibJ9
	89cXb3r4QiPuNnFZyR2+M6ZdSxrmtMExn29Dr1AkNq50iGlMr8TNBzaQdVieeuXD73Qh87DZbiB
	+k0ZHD/g4lnBGE5g5FvsS0BsG/n8toaQUMdpTZnzqVYDLlfOyF8AD3wxmu+jVjO1kxVxgVqq8UK
	f5/8FY6bIFkUR+Dd9U3YxvJSSr81QTis/zrPSpWGIn7rxEQUqxG1NYF4UZiIr/XDE65mLs2Xr1Z
	VcARMtr7+JNGTNm0ltZ3SqEoweW8Fzs2IqscbjEuuEUm0YkdPHDKnbZAWfZ4gs2eM1WkN5a+veG
	n6PkY7j9LhG5JLS6bJrrbXr4Bzo4156n0G4c+N0WwPLvDDQEnpSvvFA0pCuRiG0iOzFmdgAyNE5
	2mBH31eHc5GXEqyg==
X-Google-Smtp-Source: AGHT+IHgm4TSB6LgIDVBXKQE+ZZOWSDfRVI9lTM43Fzl56goetJfekyKD5PJeeran8lm0xJLI3U3eg==
X-Received: by 2002:a17:903:245:b0:295:6c26:933b with SMTP id d9443c01a7336-29d682be6a7mr44294705ad.1.1764791452469;
        Wed, 03 Dec 2025 11:50:52 -0800 (PST)
Received: from localhost ([2a03:2880:ff:71::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29bce40ac99sm192171115ad.7.2025.12.03.11.50.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Dec 2025 11:50:52 -0800 (PST)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@kernel.org,
	eddyz87@gmail.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf v3 2/2] selftests/bpf: Test tail call when cgroup storage is used
Date: Wed,  3 Dec 2025 11:50:50 -0800
Message-ID: <20251203195050.3215728-2-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251203195050.3215728-1-ameryhung@gmail.com>
References: <20251203195050.3215728-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make sure that if the owner of a program array map uses cgroup storage,
(1) all callers must use cgroup storage and (2) the cgroup storage map
used by all callers and callees must be the owner's cgroup storage map.

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 .../selftests/bpf/prog_tests/tailcalls.c      | 119 ++++++++++++++++++
 .../bpf/progs/tailcall_cgrp_storage.c         |  45 +++++++
 .../progs/tailcall_cgrp_storage_no_storage.c  |  21 ++++
 .../bpf/progs/tailcall_cgrp_storage_owner.c   |  33 +++++
 4 files changed, 218 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/tailcall_cgrp_storage.c
 create mode 100644 tools/testing/selftests/bpf/progs/tailcall_cgrp_storage_no_storage.c
 create mode 100644 tools/testing/selftests/bpf/progs/tailcall_cgrp_storage_owner.c

diff --git a/tools/testing/selftests/bpf/prog_tests/tailcalls.c b/tools/testing/selftests/bpf/prog_tests/tailcalls.c
index 0ab36503c3b2..8ae4d101ed66 100644
--- a/tools/testing/selftests/bpf/prog_tests/tailcalls.c
+++ b/tools/testing/selftests/bpf/prog_tests/tailcalls.c
@@ -8,6 +8,9 @@
 #include "tailcall_freplace.skel.h"
 #include "tc_bpf2bpf.skel.h"
 #include "tailcall_fail.skel.h"
+#include "tailcall_cgrp_storage_owner.skel.h"
+#include "tailcall_cgrp_storage_no_storage.skel.h"
+#include "tailcall_cgrp_storage.skel.h"
 
 /* test_tailcall_1 checks basic functionality by patching multiple locations
  * in a single program for a single tail call slot with nop->jmp, jmp->nop
@@ -1648,6 +1651,116 @@ static void test_tailcall_bpf2bpf_freplace(void)
 	tc_bpf2bpf__destroy(tc_skel);
 }
 
+/*
+ * test_tail_call_cgrp_storage checks that if the owner program of a program
+ * array uses cgroup storage, other callers and callees must also use the
+ * exact same cgroup storage.
+ */
+static void test_tailcall_cgrp_storage(void)
+{
+	int err, prog_fd, prog_array_fd, storage_map_fd, key = 0;
+	struct tailcall_cgrp_storage_owner *owner_skel;
+	struct tailcall_cgrp_storage *skel;
+
+	/* Load owner_skel first to make sure it becomes the owner of prog_array */
+	owner_skel = tailcall_cgrp_storage_owner__open_and_load();
+	if (!ASSERT_OK_PTR(owner_skel, "tailcall_cgrp_storage_owner__open_and_load"))
+		return;
+
+	prog_array_fd = bpf_map__fd(owner_skel->maps.prog_array);
+	storage_map_fd = bpf_map__fd(owner_skel->maps.storage_map);
+
+	skel = tailcall_cgrp_storage__open();
+	if (!ASSERT_OK_PTR(skel, "tailcall_cgrp_storage__open")) {
+		tailcall_cgrp_storage_owner__destroy(owner_skel);
+		return;
+	}
+
+	err = bpf_map__reuse_fd(skel->maps.prog_array, prog_array_fd);
+	ASSERT_OK(err, "bpf_map__reuse_fd(prog_array)");
+
+	err = bpf_map__reuse_fd(skel->maps.storage_map, storage_map_fd);
+	ASSERT_OK(err, "bpf_map__reuse_fd(storage_map)");
+
+	err = bpf_object__load(skel->obj);
+	ASSERT_OK(err, "bpf_object__load");
+
+	prog_fd = bpf_program__fd(skel->progs.callee_prog);
+
+	err = bpf_map_update_elem(prog_array_fd, &key, &prog_fd, BPF_ANY);
+	ASSERT_OK(err, "bpf_map_update_elem(prog_array)");
+
+	tailcall_cgrp_storage__destroy(skel);
+	tailcall_cgrp_storage_owner__destroy(owner_skel);
+}
+
+/*
+ * test_tail_call_cgrp_storage_diff_storage checks that a program using tail call
+ * is rejected if it uses a cgroup storage different from the owner's.
+ */
+static void test_tailcall_cgrp_storage_diff_storage(void)
+{
+	struct tailcall_cgrp_storage_owner *owner_skel;
+	struct tailcall_cgrp_storage *skel;
+	int err, prog_array_fd;
+
+	/* Load owner_skel first to make sure it becomes the owner of prog_array */
+	owner_skel = tailcall_cgrp_storage_owner__open_and_load();
+	if (!ASSERT_OK_PTR(owner_skel, "tailcall_cgrp_storage_owner__open_and_load"))
+		return;
+
+	prog_array_fd = bpf_map__fd(owner_skel->maps.prog_array);
+
+	skel = tailcall_cgrp_storage__open();
+	if (!ASSERT_OK_PTR(skel, "tailcall_cgrp_storage__open")) {
+		tailcall_cgrp_storage_owner__destroy(owner_skel);
+		return;
+	}
+
+	err = bpf_map__reuse_fd(skel->maps.prog_array, prog_array_fd);
+	ASSERT_OK(err, "bpf_map__reuse_fd(prog_array)");
+
+	err = bpf_object__load(skel->obj);
+	ASSERT_ERR(err, "bpf_object__load");
+
+	tailcall_cgrp_storage__destroy(skel);
+	tailcall_cgrp_storage_owner__destroy(owner_skel);
+}
+
+/*
+ * test_tail_call_cgrp_storage_no_storage checks that a program using tail call
+ * is rejected if it does not use cgroup storage while the owner does.
+ */
+static void test_tailcall_cgrp_storage_no_storage(void)
+{
+	struct tailcall_cgrp_storage_owner *owner_skel;
+	struct tailcall_cgrp_storage_no_storage *skel;
+	int err, prog_array_fd, storage_map_fd;
+
+	/* Load owner_skel first to make sure it becomes the owner of prog_array */
+	owner_skel = tailcall_cgrp_storage_owner__open_and_load();
+	if (!ASSERT_OK_PTR(owner_skel, "tailcall_cgrp_storage_owner__open_and_load"))
+		return;
+
+	prog_array_fd = bpf_map__fd(owner_skel->maps.prog_array);
+	storage_map_fd = bpf_map__fd(owner_skel->maps.storage_map);
+
+	skel = tailcall_cgrp_storage_no_storage__open();
+	if (!ASSERT_OK_PTR(skel, "tailcall_cgrp_storage_no_storage__open")) {
+		tailcall_cgrp_storage_owner__destroy(owner_skel);
+		return;
+	}
+
+	err = bpf_map__reuse_fd(skel->maps.prog_array, prog_array_fd);
+	ASSERT_OK(err, "bpf_map__reuse_fd(prog_array)");
+
+	err = bpf_object__load(skel->obj);
+	ASSERT_ERR(err, "bpf_object__load");
+
+	tailcall_cgrp_storage_no_storage__destroy(skel);
+	tailcall_cgrp_storage_owner__destroy(owner_skel);
+}
+
 static void test_tailcall_failure()
 {
 	RUN_TESTS(tailcall_fail);
@@ -1705,6 +1818,12 @@ void test_tailcalls(void)
 		test_tailcall_freplace();
 	if (test__start_subtest("tailcall_bpf2bpf_freplace"))
 		test_tailcall_bpf2bpf_freplace();
+	if (test__start_subtest("tailcall_cgrp_storage"))
+		test_tailcall_cgrp_storage();
+	if (test__start_subtest("tailcall_cgrp_storage_diff_storage"))
+		test_tailcall_cgrp_storage_diff_storage();
+	if (test__start_subtest("tailcall_cgrp_storage_no_storage"))
+		test_tailcall_cgrp_storage_no_storage();
 	if (test__start_subtest("tailcall_failure"))
 		test_tailcall_failure();
 }
diff --git a/tools/testing/selftests/bpf/progs/tailcall_cgrp_storage.c b/tools/testing/selftests/bpf/progs/tailcall_cgrp_storage.c
new file mode 100644
index 000000000000..e8356f95fb0a
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/tailcall_cgrp_storage.c
@@ -0,0 +1,45 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <vmlinux.h>
+#include <bpf/bpf_helpers.h>
+
+struct {
+	__uint(type, BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE);
+	__type(key, struct bpf_cgroup_storage_key);
+	__type(value, __u64);
+} storage_map SEC(".maps");
+
+struct {
+	__uint(type, BPF_MAP_TYPE_PROG_ARRAY);
+	__uint(max_entries, 1);
+	__uint(key_size, sizeof(__u32));
+	__uint(value_size, sizeof(__u32));
+} prog_array SEC(".maps");
+
+SEC("cgroup_skb/egress")
+int caller_prog(struct __sk_buff *skb)
+{
+	__u64 *storage;
+
+	storage = bpf_get_local_storage(&storage_map, 0);
+	if (storage)
+		*storage = 1;
+
+	bpf_tail_call(skb, &prog_array, 0);
+
+	return 1;
+}
+
+SEC("cgroup_skb/egress")
+int callee_prog(struct __sk_buff *skb)
+{
+	__u64 *storage;
+
+	storage = bpf_get_local_storage(&storage_map, 0);
+	if (storage)
+		*storage = 1;
+
+	return 1;
+}
+
+char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/progs/tailcall_cgrp_storage_no_storage.c b/tools/testing/selftests/bpf/progs/tailcall_cgrp_storage_no_storage.c
new file mode 100644
index 000000000000..2f295e66d488
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/tailcall_cgrp_storage_no_storage.c
@@ -0,0 +1,21 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <vmlinux.h>
+#include <bpf/bpf_helpers.h>
+
+struct {
+	__uint(type, BPF_MAP_TYPE_PROG_ARRAY);
+	__uint(max_entries, 1);
+	__uint(key_size, sizeof(__u32));
+	__uint(value_size, sizeof(__u32));
+} prog_array SEC(".maps");
+
+SEC("cgroup_skb/egress")
+int caller_prog(struct __sk_buff *skb)
+{
+	bpf_tail_call(skb, &prog_array, 0);
+
+	return 1;
+}
+
+char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/progs/tailcall_cgrp_storage_owner.c b/tools/testing/selftests/bpf/progs/tailcall_cgrp_storage_owner.c
new file mode 100644
index 000000000000..6ac195b800cf
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/tailcall_cgrp_storage_owner.c
@@ -0,0 +1,33 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+
+struct {
+	__uint(type, BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE);
+	__type(key, struct bpf_cgroup_storage_key);
+	__type(value, __u64);
+} storage_map SEC(".maps");
+
+struct {
+	__uint(type, BPF_MAP_TYPE_PROG_ARRAY);
+	__uint(max_entries, 1);
+	__uint(key_size, sizeof(__u32));
+	__uint(value_size, sizeof(__u32));
+} prog_array SEC(".maps");
+
+SEC("cgroup_skb/egress")
+int prog_array_owner(struct __sk_buff *skb)
+{
+	__u64 *storage;
+
+	storage = bpf_get_local_storage(&storage_map, 0);
+	if (storage)
+		*storage = 1;
+
+	bpf_tail_call(skb, &prog_array, 0);
+
+	return 1;
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.47.3


