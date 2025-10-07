Return-Path: <bpf+bounces-70481-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A9D51BBFFA4
	for <lists+bpf@lfdr.de>; Tue, 07 Oct 2025 03:43:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 00C044E4EF0
	for <lists+bpf@lfdr.de>; Tue,  7 Oct 2025 01:43:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97E6A1E633C;
	Tue,  7 Oct 2025 01:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D2GwKrAd"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f66.google.com (mail-ej1-f66.google.com [209.85.218.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 471637464
	for <bpf@vger.kernel.org>; Tue,  7 Oct 2025 01:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759801400; cv=none; b=myEscM975Sw7C+VMVOhyCUKldwBHLo1nMktn7+KFtpgRsN/c34VXF46nRf0QKykLbNtFSbssay4fkrOtIpBrfUGBnnoUt19iRZ1BWkZgszMl5jHHGC5fna7ENKDXCaJ1sCkbR1M2/6laH4FsYOf2+GwV8cmPePVvMs8kpeDwqLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759801400; c=relaxed/simple;
	bh=dh8E/pJwCGkY7zbK+MazOQJ5GQ7ervBilWw7WIAM1no=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WIBjBGH4scU13frlJvuczwPF+KOfPL42rnBWRnN3IjzinOivRIRpQv/3kKsr07WAhFmy/RsPWBxtjSSL7cZEyLvTFozOV1QOc0crmOW1Ox0Rv7MnKnjuDwFwu/WHoyL5oP5Nliv0yv6molJrP3KNH1BbeSOEnoQn8XABmQRnBsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D2GwKrAd; arc=none smtp.client-ip=209.85.218.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f66.google.com with SMTP id a640c23a62f3a-b3dbf11fa9eso1045035866b.0
        for <bpf@vger.kernel.org>; Mon, 06 Oct 2025 18:43:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759801396; x=1760406196; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z+pjqfXkxj7o8ooY6t+nm+P21ruAOWfl2bmfMkrQ2AM=;
        b=D2GwKrAdPMGgBBNQCYzC/ABJbxyKAqKvbPfiQSnEE0nVglmfOAOMbIbdyVcdMr8lwd
         5SxQ61Zi43G+k5V5E7Z0RHjQJW+oE8XQ/WVA67lQ4YDQpNThjbfIaAM3JO0QhG+08rH0
         Wcd+qAxhODlCAwPpiiPpbaGEe5yhIPVJhQ/gfnZAny2hofktROalWrHzETG7FY6wicTq
         DsW3CzWcT4JmqoWpXkH/xK+g9Gl+S77grsVTh3Jvp39TpmCtb+FgTJp/QOx929WyJqPt
         rlpVYhpatoqk8V2ZLBfSKm9328wvp62of4ygLynfDLHTAA0GQBfbkiOSBOt5AA/1E3bj
         vAzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759801396; x=1760406196;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z+pjqfXkxj7o8ooY6t+nm+P21ruAOWfl2bmfMkrQ2AM=;
        b=s+qHg+UfPyWRrPzrwHVtvayXODmZZIaCj68E9CBucCMgaqHOFNcMxOsM+bCUjxhKc1
         nzuhx4YVPvJqmjQTRH6HNMr0Fnod2BcVBRHHjagf+3iEertl6ZSdNueicOVtCsWME5x3
         Lhomw3bnpmrPtvAqwzuie4seVyKQIG6BSIgwat3FCKTHRXrSidCe6++wc2/O+rGqqc0n
         EDokXF1sgWvHBL8FzECZ7W7A2Dq1JKrqVmIjUat8tPSoj6cInax+61DXMJ3aTNLhiCUX
         YAlkvlr51cS6yRvmuGIHIDb/7DKIDXPv4o6JLxnvzG1+tDMoyCJZpujB1qBVPJjJQ6OP
         kzsw==
X-Gm-Message-State: AOJu0YxYf8T/FmzHi98432YRUmmKe5BZYL6Cn25JvfyyBW+rC/xw2lBk
	xTx4A1ALcR3yKEs3zZN7YMJg8x37Dv0zPl2/zY/lqu74J1Tjq1QnaTg2QulE5WvJ
X-Gm-Gg: ASbGncvTlGq88racXoJp4dnQ4t+gleqMVXinnFYuqB8WijfwBCofbjlraYEdYIUgIbu
	NCdMw8CVWgA5DIp9Oz39dGBkcC+aUwcbHXu16sVlypeEkYMju967M0UlJjZqaGSHSDoq8I3OZjf
	SyB6jxkKjW4e4IKIzG5mjyNKsq4pnVhMTvgh+c2NEmFXzBPUpNIEDWVtWm5zHhBQjPx2DIucv/W
	F8MjmDYUy10tJYCcgrfAehogLGiOFN69UZ5hUB2hYocChj8Gq7mNvetwmeSSfHYMWd7+K0uy4K1
	AS3EVPiuwnB9LAMZ/myiogMrWdXQm/551pQyMIfmeoggi7Bm8sM8mUoXJsCG6/cd9RSMIyZwCYd
	erDjbahrFWhKjz/aepYo+VKZf35jI163f8ct7iJUVdGe2BVYBa908e/5Hd1JToqj8LxtWqyLAAW
	Awh+5Rmy0G6MJLG3gwUgOK2Ay9
X-Google-Smtp-Source: AGHT+IHRwGelKVEvr28k7ObcOVBAAKZf9YEHvViknH5lqiAhUr5CvNFSASQwEqLWQEVkv9w2csRORg==
X-Received: by 2002:a17:907:9722:b0:b46:6718:3f20 with SMTP id a640c23a62f3a-b49c393a696mr1945083966b.48.1759801396214;
        Mon, 06 Oct 2025 18:43:16 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-b4865f741f1sm1266828566b.39.2025.10.06.18.43.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Oct 2025 18:43:15 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 3/3] selftests/bpf: Add tests for async cb context
Date: Tue,  7 Oct 2025 01:43:10 +0000
Message-ID: <20251007014310.2889183-4-memxor@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251007014310.2889183-1-memxor@gmail.com>
References: <20251007014310.2889183-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6554; i=memxor@gmail.com; h=from:subject; bh=dh8E/pJwCGkY7zbK+MazOQJ5GQ7ervBilWw7WIAM1no=; b=owEBbQKS/ZANAwAKAUzgyIZIvxHKAcsmYgBo5HAZ9P5O/0HN42z6R8EZuWS1YACH1/3248sDf ZkxCUctlqmJAjMEAAEKAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCaORwGQAKCRBM4MiGSL8R yit2D/9dIMp+33vadhf1BZj8PWpcjQWcdgsWak60Rd2jeOgjCxWeoI6qSkvcc41U5VzqqiqbPCX 5Q/RbSvVX66DVrws5Sz2WlO3+SabVIC7zvf5y5KyGd61McxZV99xySSFU1CcKdhSmYqeN90wbFv N2bVoOlhjsbGlCdjTWh6PY/9jSPsVlrxoyjUSHHHIfySAZOdyjvs6gGVRs4W9YUCqK295cjgdp1 rnM1n3KDwvuXCssn7D3uYiT593QxA+xnRAieKjouzyUrWmcmNFMdPh4TI+WtXKkGrWBH+ZX8np/ 1q/Tm9c2qBx1CCUYFes/diveond/UCJLCB03u7Doi9WiY3XuQ8ajIwyf5ZLkG1+bpSfSsDpDwkx dwbaKqhqxHn+skam8DaZ1UkTbYS9G+J32ZKH0jaaGoN3Uinys6ywflufVSJsSSgcSDqt6aIq6cy GzocYg6TRBMJ8Q5/yrwLae9cUWuYWE7VfgVLki1DWoMbq6L8ks3OGeLYASqZnVRDVbHy9EJ+ZcW 7CuoQPALKXjoSFGB5jDeF7Qs81DElSHyY6icq+qw0Bfl8tPSYbLmRkX1WZOKHLKIP4dUfyjGN8l 7fDLuVIhLYAP2WA8e13kFSZzWqwcB8umOuStO9eNMekvGLqtSaMj1otVWMXYUVEFHsuAvE+zf4N wg9Igu8VNBroFeg==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

Add tests to verify that async callback's sleepable attribute is
correctly determined by the callback type, not the arming program's
context, reflecting its true execution context.

Introduce verifier_async_cb_context.c with tests for all three async
callback primitives: bpf_timer, bpf_wq, and bpf_task_work. Each
primitive is tested when armed from both sleepable (lsm.s/file_open) and
non-sleepable (fentry) programs.

Test coverage:
- bpf_timer callbacks: Verify they are never sleepable, even when armed
  from sleepable programs. Both tests should fail when attempting to use
  sleepable helper bpf_copy_from_user() in the callback.

- bpf_wq callbacks: Verify they are always sleepable, even when armed
  from non-sleepable programs. Both tests should succeed when using
  sleepable helpers in the callback.

- bpf_task_work callbacks: Verify they are always sleepable, even when
  armed from non-sleepable programs. Both tests should succeed when
  using sleepable helpers in the callback.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 .../selftests/bpf/prog_tests/verifier.c       |   2 +
 .../bpf/progs/verifier_async_cb_context.c     | 181 ++++++++++++++++++
 2 files changed, 183 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_async_cb_context.c

diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/testing/selftests/bpf/prog_tests/verifier.c
index 28e81161e6fc..c0e8ffdaa484 100644
--- a/tools/testing/selftests/bpf/prog_tests/verifier.c
+++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
@@ -7,6 +7,7 @@
 #include "verifier_arena.skel.h"
 #include "verifier_arena_large.skel.h"
 #include "verifier_array_access.skel.h"
+#include "verifier_async_cb_context.skel.h"
 #include "verifier_basic_stack.skel.h"
 #include "verifier_bitfield_write.skel.h"
 #include "verifier_bounds.skel.h"
@@ -280,6 +281,7 @@ void test_verifier_array_access(void)
 		      verifier_array_access__elf_bytes,
 		      init_array_access_maps);
 }
+void test_verifier_async_cb_context(void)    { RUN(verifier_async_cb_context); }
 
 static int init_value_ptr_arith_maps(struct bpf_object *obj)
 {
diff --git a/tools/testing/selftests/bpf/progs/verifier_async_cb_context.c b/tools/testing/selftests/bpf/progs/verifier_async_cb_context.c
new file mode 100644
index 000000000000..96ff6749168b
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/verifier_async_cb_context.c
@@ -0,0 +1,181 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2025 Meta Platforms, Inc. and affiliates. */
+
+#include <vmlinux.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+#include "bpf_misc.h"
+#include "bpf_experimental.h"
+
+char _license[] SEC("license") = "GPL";
+
+/* Timer tests */
+
+struct timer_elem {
+	struct bpf_timer t;
+};
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__uint(max_entries, 1);
+	__type(key, int);
+	__type(value, struct timer_elem);
+} timer_map SEC(".maps");
+
+static int timer_cb(void *map, int *key, struct bpf_timer *timer)
+{
+	u32 data;
+	/* Timer callbacks are never sleepable, even from non-sleepable programs */
+	bpf_copy_from_user(&data, sizeof(data), NULL);
+	return 0;
+}
+
+SEC("fentry/bpf_fentry_test1")
+__failure __msg("helper call might sleep in a non-sleepable prog")
+int timer_non_sleepable_prog(void *ctx)
+{
+	struct timer_elem *val;
+	int key = 0;
+
+	val = bpf_map_lookup_elem(&timer_map, &key);
+	if (!val)
+		return 0;
+
+	bpf_timer_init(&val->t, &timer_map, 0);
+	bpf_timer_set_callback(&val->t, timer_cb);
+	return 0;
+}
+
+SEC("lsm.s/file_open")
+__failure __msg("helper call might sleep in a non-sleepable prog")
+int timer_sleepable_prog(void *ctx)
+{
+	struct timer_elem *val;
+	int key = 0;
+
+	val = bpf_map_lookup_elem(&timer_map, &key);
+	if (!val)
+		return 0;
+
+	bpf_timer_init(&val->t, &timer_map, 0);
+	bpf_timer_set_callback(&val->t, timer_cb);
+	return 0;
+}
+
+/* Workqueue tests */
+
+struct wq_elem {
+	struct bpf_wq w;
+};
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__uint(max_entries, 1);
+	__type(key, int);
+	__type(value, struct wq_elem);
+} wq_map SEC(".maps");
+
+static int wq_cb(void *map, int *key, void *value)
+{
+	u32 data;
+	/* Workqueue callbacks are always sleepable, even from non-sleepable programs */
+	bpf_copy_from_user(&data, sizeof(data), NULL);
+	return 0;
+}
+
+SEC("fentry/bpf_fentry_test1")
+__success
+int wq_non_sleepable_prog(void *ctx)
+{
+	struct wq_elem *val;
+	int key = 0;
+
+	val = bpf_map_lookup_elem(&wq_map, &key);
+	if (!val)
+		return 0;
+
+	if (bpf_wq_init(&val->w, &wq_map, 0) != 0)
+		return 0;
+	if (bpf_wq_set_callback_impl(&val->w, wq_cb, 0, NULL) != 0)
+		return 0;
+	return 0;
+}
+
+SEC("lsm.s/file_open")
+__success
+int wq_sleepable_prog(void *ctx)
+{
+	struct wq_elem *val;
+	int key = 0;
+
+	val = bpf_map_lookup_elem(&wq_map, &key);
+	if (!val)
+		return 0;
+
+	if (bpf_wq_init(&val->w, &wq_map, 0) != 0)
+		return 0;
+	if (bpf_wq_set_callback_impl(&val->w, wq_cb, 0, NULL) != 0)
+		return 0;
+	return 0;
+}
+
+/* Task work tests */
+
+struct task_work_elem {
+	struct bpf_task_work tw;
+};
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__uint(max_entries, 1);
+	__type(key, int);
+	__type(value, struct task_work_elem);
+} task_work_map SEC(".maps");
+
+static int task_work_cb(struct bpf_map *map, void *key, void *value)
+{
+	u32 data;
+	/* Task work callbacks are always sleepable, even from non-sleepable programs */
+	bpf_copy_from_user(&data, sizeof(data), NULL);
+	return 0;
+}
+
+SEC("fentry/bpf_fentry_test1")
+__success
+int task_work_non_sleepable_prog(void *ctx)
+{
+	struct task_work_elem *val;
+	struct task_struct *task;
+	int key = 0;
+
+	val = bpf_map_lookup_elem(&task_work_map, &key);
+	if (!val)
+		return 0;
+
+	task = bpf_get_current_task_btf();
+	if (!task)
+		return 0;
+
+	bpf_task_work_schedule_resume(task, &val->tw, &task_work_map, task_work_cb, NULL);
+	return 0;
+}
+
+SEC("lsm.s/file_open")
+__success
+int task_work_sleepable_prog(void *ctx)
+{
+	struct task_work_elem *val;
+	struct task_struct *task;
+	int key = 0;
+
+	val = bpf_map_lookup_elem(&task_work_map, &key);
+	if (!val)
+		return 0;
+
+	task = bpf_get_current_task_btf();
+	if (!task)
+		return 0;
+
+	bpf_task_work_schedule_resume(task, &val->tw, &task_work_map, task_work_cb, NULL);
+	return 0;
+}
-- 
2.51.0


