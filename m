Return-Path: <bpf+bounces-42979-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C96629AD8A4
	for <lists+bpf@lfdr.de>; Thu, 24 Oct 2024 01:49:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A7B51F22D78
	for <lists+bpf@lfdr.de>; Wed, 23 Oct 2024 23:49:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA57A1FF7B4;
	Wed, 23 Oct 2024 23:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ONHPPTPx"
X-Original-To: bpf@vger.kernel.org
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1731B1F9439
	for <bpf@vger.kernel.org>; Wed, 23 Oct 2024 23:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729727338; cv=none; b=lGzqQUtfZI8wNb2n22DrKI5lthQQ4yLy4I8b+Yktx8dEHe8CZydDYjy6GjM6A5T0Yu6uLRJWEFbpAEizodzpoT9gAQP4uZrk0zUNwvTANsNVwq7Lxi5I1dHxv3QceKzBPNVj0XxmGqZ/KaEdNpdDEGtTpIE9HuzZbAHIezgH5DM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729727338; c=relaxed/simple;
	bh=P2JrIXYOSvZoRxfQ2wo7qBuUzBD+vFVUQjSd156jrn8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gUrlO1HqrZxod1Hby8w4gBf4WW67IhYpiyjnkGQhqBcmUvomR5v4W34MHwSkRD8g8q/htziLJ2cx3zuxRLIeMhlakQovrojBRx0vg7oTe7sTiT/AtX8SEqhuTxQpT0Y36BM+YwcxU5llN+aIcPCr+XXobN8Z7NXlBH49NDx7qy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ONHPPTPx; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1729727334;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LfxAgjrA41ndbo/LgICCVE6xN9lYa416CQWA2xtXlqE=;
	b=ONHPPTPx+Wt5C5q4b6SIY9pQ/vcE1iDZCKuxSiTTDkJWZDvbGr0UQQgoJsk9tkvRpk9y8i
	JR+2RrqRJcZH25WzLRRrJCHXNRLaSCR1zmt58ecNkqjHvONg+9qDChXpqEP3IN/ABg1DgM
	K6MQL1+peODgViMlXON7lIl4Jfa1pL0=
From: Martin KaFai Lau <martin.lau@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Kui-Feng Lee <thinker.li@gmail.com>,
	kernel-team@meta.com
Subject: [PATCH v6 bpf-next 11/12] selftests/bpf: Add uptr failure verifier tests
Date: Wed, 23 Oct 2024 16:47:58 -0700
Message-ID: <20241023234759.860539-12-martin.lau@linux.dev>
In-Reply-To: <20241023234759.860539-1-martin.lau@linux.dev>
References: <20241023234759.860539-1-martin.lau@linux.dev>
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
 .../selftests/bpf/progs/uptr_failure.c        | 105 ++++++++++++++++++
 2 files changed, 107 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/uptr_failure.c

diff --git a/tools/testing/selftests/bpf/prog_tests/task_local_storage.c b/tools/testing/selftests/bpf/prog_tests/task_local_storage.c
index e985665efe7a..772ed7ce4feb 100644
--- a/tools/testing/selftests/bpf/prog_tests/task_local_storage.c
+++ b/tools/testing/selftests/bpf/prog_tests/task_local_storage.c
@@ -18,6 +18,7 @@
 #include "uptr_test_common.h"
 #include "task_ls_uptr.skel.h"
 #include "uptr_update_failure.skel.h"
+#include "uptr_failure.skel.h"
 
 static void test_sys_enter_exit(void)
 {
@@ -467,4 +468,5 @@ void test_task_local_storage(void)
 		test_uptr_across_pages();
 	if (test__start_subtest("uptr_update_failure"))
 		test_uptr_update_failure();
+	RUN_TESTS(uptr_failure);
 }
diff --git a/tools/testing/selftests/bpf/progs/uptr_failure.c b/tools/testing/selftests/bpf/progs/uptr_failure.c
new file mode 100644
index 000000000000..0cfa1fd61440
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/uptr_failure.c
@@ -0,0 +1,105 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2024 Meta Platforms, Inc. and affiliates. */
+
+#include <vmlinux.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_experimental.h"
+#include "bpf_misc.h"
+#include "uptr_test_common.h"
+
+struct {
+	__uint(type, BPF_MAP_TYPE_TASK_STORAGE);
+	__uint(map_flags, BPF_F_NO_PREALLOC);
+	__type(key, int);
+	__type(value, struct value_type);
+} datamap SEC(".maps");
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
+
+	v = bpf_obj_new(typeof(*v));
+	if (!v)
+		return 0;
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


