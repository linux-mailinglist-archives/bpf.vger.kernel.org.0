Return-Path: <bpf+bounces-70547-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 39F19BC2D07
	for <lists+bpf@lfdr.de>; Wed, 08 Oct 2025 00:04:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9163C189B77C
	for <lists+bpf@lfdr.de>; Tue,  7 Oct 2025 22:04:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9555258ED7;
	Tue,  7 Oct 2025 22:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NUi8kuy/"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com [209.85.128.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD3EA254B03
	for <bpf@vger.kernel.org>; Tue,  7 Oct 2025 22:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759874638; cv=none; b=Aw/jbaZMWVtvLlHzoK5uQDExya+DKR3LJ+dJulnYrSNDdgwqGViB5vb9aUZEvAETviHiVnzEAYQrJwHADF4i/WZPzwAJN1Zhow1TUeFTX1+ByOkuLa5zs90tlyPJIQg85XmABGkVPMhMNANLoGkee05CxqoOz7hCDoCdJaWDFZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759874638; c=relaxed/simple;
	bh=r+N5gxeQtxOP328UZiDiTNVVDqx08obi9yOnYmSHs38=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LfWYVN9CRNPnM/XvVIrgwkTmhvzBDE4jtM5E2WKfsyai/AmLd+MDfmvdikx4R3eZ7g+rwnD/P34stBUFt8j8aQRGgZ0/G/qqPTIe6Me9Hw0NhdgYjWO9L6n8vFzQJWoOd598fq8EjS8Ti5TSn4loTgk6cbvFQbAkpcsFvwIMlwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NUi8kuy/; arc=none smtp.client-ip=209.85.128.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f65.google.com with SMTP id 5b1f17b1804b1-46e29d65728so38528325e9.3
        for <bpf@vger.kernel.org>; Tue, 07 Oct 2025 15:03:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759874635; x=1760479435; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JermjkTxnS/UY63q+ZXSZ0n+qPCwkYvMBCS3IYyVVvk=;
        b=NUi8kuy/BTYaTWsSp3aeK+CWy+MPpbGY6Zf3h42KgH1zHl69MOj+xenqRDmuCjBfkN
         UTSS7mzGrsnTZDvJFlOKGR5PFYegxdHvvO29wPm3V1RMWWWwiiiyxIbhTKZTc52FElV2
         tM0GNGUbe9vIFwG36wUCRRnrRdYzvDGSC6cYPU2pk57TPXtXu3ZSOC9mvyQtDmGr34q0
         XBZwmQK6Fh3ZW5xxA5O1VH2VXx1w9eu/5aZqPVuY3yHODDEogUj6B5wjA/SSgaUJP2nX
         T7X0xmP6sW1sgeVC88g+YpEgwDG/6QKw+mIwCZNviH5/LPtUcjgDaeClTtcvkg3nE6cb
         Uv7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759874635; x=1760479435;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JermjkTxnS/UY63q+ZXSZ0n+qPCwkYvMBCS3IYyVVvk=;
        b=guykTuClIOOkKkd4/QvRfo+5pde7sHtsmjCMr0zg4QCK/t5IA6k4IJY949r9XuOaF9
         LH7sebVttdljOk7wWTD9TJrciZmujN//Oz7ZANNoGfd6BeyFZnyzQrWfAOD2Cb+/KdWv
         DdOiBEuZ3+sSfuUGWkdsGNZ2LeQd2msc4vTSeKZD3vaMy+Ms1h1e++wHTDJkiAdl6DXB
         A2gmzoUoHtkUbPqUoZcAVdHXFsjtlTuXuMkSTmeI7KZOS5McZCOnmLLZLWnYjUdvroap
         RcWnMnIDhpllDQRiorE/lhHMVhQ5Iz+E1Kt5xoI3WYiR9K8oh6jfje6JCpWH+DkALEnD
         bO8Q==
X-Gm-Message-State: AOJu0Yxff6eb9J+6TyWj+TUKygwPS8JnDLN7JF79kHvac44Jc2EY3tax
	XzjTxH3lwtODhpWmlicWhPlcjbrTYyXK3fLkTJL6Yf+ilwEI7U04gn/AR1MdHCVx
X-Gm-Gg: ASbGncvi9dJ3qKYIp8CJnyp9Zs814/Ij0fv8N3VoTg7Vx6IROONAyLdueWd/EHI0Uo5
	OHZAvr0+cD3pklO3rPlJobnRkJ57JBe8JrkUoRv794aYXXsfGDeZXe5NpMgJDAZdxxY3dE39ptA
	sNIX80UF56gIIq24OWaZS5kLLtYBCg3Ek7PB02hmpHjfw8xQFmtWBlKLU1vxR/frYSrDewkBWGn
	AUfKR5SSz6711mJVDtA8U5pFo+78fHB/GxdHj7FWU/r5SfqAN1MbNPp43DYeAwT4Iz796z7okBI
	c0HvSxMEtY3QbrBCLcoHOxnFVoc8W2WA9BbzU+rfZGGTjg8gUJxWkB+Nk+cFhDdWMkpnASFXDeA
	JCzo1vjM2CWxUDZI7hNnjv+uNhYT3uk0SJmAIFJVpspxyBKlKAenrbFZCU0sQzM1py69MI/GPNQ
	JTZr5eD35OFWAJ8xwbY2x7JUgA
X-Google-Smtp-Source: AGHT+IEltavuWfbCTHsY6S546QpIBaKfLNBlpV0hNqKdLitdB1IYZTBq3sctqYmL7JTUi2T0aMKxWA==
X-Received: by 2002:a05:600c:19ce:b0:459:db7b:988e with SMTP id 5b1f17b1804b1-46fa9a96a48mr7715555e9.13.1759874634639;
        Tue, 07 Oct 2025 15:03:54 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-46fa9c07cbasm10122705e9.7.2025.10.07.15.03.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Oct 2025 15:03:54 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Eduard Zingerman <eddyz87@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v2 3/3] selftests/bpf: Add tests for async cb context
Date: Tue,  7 Oct 2025 22:03:49 +0000
Message-ID: <20251007220349.3852807-4-memxor@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251007220349.3852807-1-memxor@gmail.com>
References: <20251007220349.3852807-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6602; i=memxor@gmail.com; h=from:subject; bh=r+N5gxeQtxOP328UZiDiTNVVDqx08obi9yOnYmSHs38=; b=owEBbQKS/ZANAwAKAUzgyIZIvxHKAcsmYgBo5Ym4xl6hXMRw4KMsMizIYhK4QxFvA1O0oEAhW SLv30wZBQSJAjMEAAEKAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCaOWJuAAKCRBM4MiGSL8R yv5VEACLN/JzZh1PBt9FT3m1OOUM5a+cifABjL7rT+gn0u9L98muaBMuiAAtPLE3ndXcS75NRwj /WResqmtjEpqlqAb0LRNTGjFo4R8MIUvQgo+Uuof0Ewvwhz0C32mOEFrM/RBw43i0oITYeRfIHd Em+EipEXf+Jvq/U429FZgSq3mUFn/98vKu/zIq8WOyPxeLO6mPggvj66kgxSxuFv+flCQMxduu4 qLfqi78OIPp+u0vytIFaKe6XpGyNoA9F1G580olACNY9y8iqD7ZwSqstMzqZOHT2/YuBFMjJuZ/ Jsf5QpK0YSkjl6b7T7cmQvOmbQMHc1GDlmiQOYL5zUXtQ2qP8RYLrO0kq7VVW8p5Wf330yWdR6X +4VPdszr4AKTzX7EEa0UIJqkS+Jcm9CvuT61nKzNcxdVdBYYUZXRQRjdpKXugmtpt8HfMsngBFm /C3Z8ByyP/V/madwNKTMft0AA4oa5fyS42fzMPV1mukp9gP03g9VPz26T9eqWDfyfSalv0Qe0TW Z4urqgrSCg6gE1+ICfjQ3ZZMv+j116yTddbRuuA2Rx6ZO2qFog0ECKD278AIlbbaOZIY+poq24J wS7Uuk0mnClXiv2CV8lUV7x2td4JF0WF9G9Q1M70gbmI//BV5h6sgIqqLLdamwdsiGHlHew4uJ2 33S1y7mUitKTEWg==
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

Acked-by: Eduard Zingerman <eddyz87@gmail.com>
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


