Return-Path: <bpf+bounces-41910-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 90FBD99DADB
	for <lists+bpf@lfdr.de>; Tue, 15 Oct 2024 02:50:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56E1B282F93
	for <lists+bpf@lfdr.de>; Tue, 15 Oct 2024 00:50:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4561B4B5C1;
	Tue, 15 Oct 2024 00:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="L84N4x2l"
X-Original-To: bpf@vger.kernel.org
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38EF83DBB6
	for <bpf@vger.kernel.org>; Tue, 15 Oct 2024 00:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728953448; cv=none; b=DHAQ01GZoa647J5yfOfaMUKCyKXkfcwMMH2rtiwCoUy//tKXhWcy4RJLTEvULzuRdhO52xVisfkRnU3UgwXQe393DUtxqYrb2b+mfQLp50g+p0Wike55NN8pVg4gcucAYi8B7RKHRbAw5GUVZuvBpXtKNdnriprVpXGBNVdNzaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728953448; c=relaxed/simple;
	bh=uclqs8seZwV0E0uCZoN5FbeeH2dyuIw5/J4tU5EjYvY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Jb9VktLCqamrgL5osZ2Tehmkwd7bl1rNSi54HkL7rmKSlbExn10Asnyy99+D15IMd2bdiuS3auIVMzklBRpRnfwJBZYJEXGbTLeBlsS0vyUS+mLeFHvIbgHQA+93ztINajdlBLCNyyXssvOzX7ocke5Qzn1Iq7vGL02rcLnPXJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=L84N4x2l; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1728953445;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8B2iH2nbqDUZ0YCT+c3Jyxa9bvxK6PhoXqTLFm/tZgI=;
	b=L84N4x2lgICg2V+djw32/n1oprSsXK49cAI4ZGr/bZQcMQ8QQfBpMy9gHlUa1IlMoZiawh
	14MQBqaA5O1Gsg1NJMvjmaSgncClyvzl0DY7KXCP1l5RFCM1U8tXbJtS9JBoqXrk2f3Un1
	18BFeNgHc19RJEn/2k6kEEvN2tCX6fM=
From: Martin KaFai Lau <martin.lau@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Kui-Feng Lee <thinker.li@gmail.com>,
	kernel-team@meta.com
Subject: [PATCH v5 bpf-next 11/12] selftests/bpf: Add uptr failure verifier tests
Date: Mon, 14 Oct 2024 17:50:01 -0700
Message-ID: <20241015005008.767267-12-martin.lau@linux.dev>
In-Reply-To: <20241015005008.767267-1-martin.lau@linux.dev>
References: <20241015005008.767267-1-martin.lau@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Martin KaFai Lau <martin.lau@kernel.org>

Add verifier tests to ensure invalid uptr usages are rejected.

Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
---
 .../bpf/prog_tests/task_local_storage.c       |   2 +
 .../selftests/bpf/progs/uptr_failure.c        | 121 ++++++++++++++++++
 2 files changed, 123 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/uptr_failure.c

diff --git a/tools/testing/selftests/bpf/prog_tests/task_local_storage.c b/tools/testing/selftests/bpf/prog_tests/task_local_storage.c
index 4abe1621c5c0..55e36956bf52 100644
--- a/tools/testing/selftests/bpf/prog_tests/task_local_storage.c
+++ b/tools/testing/selftests/bpf/prog_tests/task_local_storage.c
@@ -18,6 +18,7 @@
 #include "uptr_test_common.h"
 #include "task_ls_uptr.skel.h"
 #include "uptr_update_failure.skel.h"
+#include "uptr_failure.skel.h"
 
 static void test_sys_enter_exit(void)
 {
@@ -463,4 +464,5 @@ void test_task_local_storage(void)
 		test_uptr_across_pages();
 	if (test__start_subtest("uptr_update_failure"))
 		test_uptr_update_failure();
+	RUN_TESTS(uptr_failure);
 }
diff --git a/tools/testing/selftests/bpf/progs/uptr_failure.c b/tools/testing/selftests/bpf/progs/uptr_failure.c
new file mode 100644
index 000000000000..e035130c2959
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/uptr_failure.c
@@ -0,0 +1,121 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2024 Meta Platforms, Inc. and affiliates. */
+
+#include <vmlinux.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_experimental.h"
+#include "bpf_misc.h"
+#include "uptr_test_common.h"
+
+void bpf_cgroup_release(struct cgroup *cgrp) __ksym;
+
+struct {
+	__uint(type, BPF_MAP_TYPE_TASK_STORAGE);
+	__uint(map_flags, BPF_F_NO_PREALLOC);
+	__type(key, int);
+	__type(value, struct value_type);
+} datamap SEC(".maps");
+
+/* Avoid fwd user_data type in btf */
+struct user_data __dummy;
+
+SEC("?syscall")
+__failure __msg("store to uptr disallowed")
+int uptr_write(const void *ctx)
+{
+	struct task_struct *task;
+	struct value_type *v;
+
+	task = bpf_get_current_task_btf();
+	v = bpf_task_storage_get(&datamap, task, 0,
+				 BPF_LOCAL_STORAGE_GET_F_CREATE);
+	if (!v)
+		return 0;
+
+	v->udata = NULL;
+	return 0;
+}
+
+SEC("?syscall")
+__failure __msg("store to uptr disallowed")
+int uptr_write_nested(const void *ctx)
+{
+	struct task_struct *task;
+	struct value_type *v;
+
+	task = bpf_get_current_task_btf();
+	v = bpf_task_storage_get(&datamap, task, 0,
+				 BPF_LOCAL_STORAGE_GET_F_CREATE);
+	if (!v)
+		return 0;
+
+	v->nested.udata = NULL;
+	return 0;
+}
+
+SEC("?syscall")
+__failure __msg("R1 invalid mem access 'mem_or_null'")
+int uptr_no_null_check(const void *ctx)
+{
+	struct task_struct *task;
+	struct value_type *v;
+
+	task = bpf_get_current_task_btf();
+	v = bpf_task_storage_get(&datamap, task, 0,
+				 BPF_LOCAL_STORAGE_GET_F_CREATE);
+	if (!v)
+		return 0;
+
+	v->udata->result = 0;
+
+	return 0;
+}
+
+SEC("?syscall")
+__failure __msg("doesn't point to kptr")
+int uptr_kptr_xchg(const void *ctx)
+{
+	struct task_struct *task;
+	struct value_type *v;
+
+	task = bpf_get_current_task_btf();
+	v = bpf_task_storage_get(&datamap, task, 0,
+				 BPF_LOCAL_STORAGE_GET_F_CREATE);
+	if (!v)
+		return 0;
+
+	bpf_kptr_xchg(&v->udata, NULL);
+
+	return 0;
+}
+
+SEC("?syscall")
+__failure __msg("invalid mem access 'scalar'")
+int uptr_obj_new(const void *ctx)
+{
+	struct value_type *v;
+	struct cgroup *cgrp;
+
+	v = bpf_obj_new(typeof(*v));
+	if (!v)
+		return 0;
+
+	cgrp = bpf_kptr_xchg(&v->cgrp, NULL);
+	if (cgrp) {
+		/* Avoid fwd cgroup type in btf */
+		int lvl = cgrp->level;
+
+		bpf_cgroup_release(cgrp);
+		bpf_obj_drop(v);
+		return lvl;
+	}
+
+	if (v->udata)
+		v->udata->result = 0;
+
+	bpf_obj_drop(v);
+
+	return 0;
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.43.5


