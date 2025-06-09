Return-Path: <bpf+bounces-60115-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C79FAD2A83
	for <lists+bpf@lfdr.de>; Tue, 10 Jun 2025 01:28:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 93C691891906
	for <lists+bpf@lfdr.de>; Mon,  9 Jun 2025 23:28:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 430A722B8DB;
	Mon,  9 Jun 2025 23:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SeValOJD"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5597022B8B2
	for <bpf@vger.kernel.org>; Mon,  9 Jun 2025 23:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749511674; cv=none; b=o+DU5OjeEdjgWnSARkIUPVgC4CuLx9FP024azjxT6XBOjEeRKcNEpKbxTivC65Eg9jVM7W1AV870Et3BM2w7y331wSSAF9gZeQ6E1lhCzpneW8DWxaDozLr+wryA5cgV4UHjH0ZFN0c8HjniKE3RvkO6AM94ZrRQ50JErl0mSC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749511674; c=relaxed/simple;
	bh=VRAtFsN7Q4t0rW8eGfLclxEU7NKS6Z11aMnoNbKOND0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eVAAl6uZSM5jiCz+LF8p/YZK4XN2bqEH5/GMa6z1T6FCi/9z38ftONEljkn6E9bLVXF/En/TmC4+vErvXijav6PVHpNrRILcBdmqGdXcmzCBuzc4ZzKKeLohZpq3v02XBVbheGYJ8GOsQbyj6NbN9PvSOebWpMp6nykj815pK3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SeValOJD; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-879d2e419b9so4162555a12.2
        for <bpf@vger.kernel.org>; Mon, 09 Jun 2025 16:27:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749511672; x=1750116472; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7xX97UE6T9Wo5Mrj/u7iyawLFNM53yin8vdiop8WQKI=;
        b=SeValOJDldBPMeqBGtIWQB8q1UgqkbkOKZqU8uQIJBYRnRboFLcpVieiV3f1PVppcU
         YbwZ1482VjJr2xAPggZ+M3P1KXFFcwAjLhRv5YD8GzwLQn1PpHVyhoBkPEj2QRifxBJS
         fa+pcs0eD5DmPvRtFumD7vyeAMY+xYMu1db9tizRb5Klh7NyGcI8+FfCDthODJEC0Gcc
         7uyby7qCm/4eVgrdCXWMIIsq9XTfDXylAff4v1dVoJwOIomCj7T6BNqY1s4VwfH0+FeR
         FfTFJWZM9P6FQMu4LQMjxzRPsYW6Nj4WmB0vgERXyrraf3l3a5i2bl7IpIzMoraBqkxJ
         6CTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749511672; x=1750116472;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7xX97UE6T9Wo5Mrj/u7iyawLFNM53yin8vdiop8WQKI=;
        b=nxhiIBjOUj40kG8daflyXxLebb1EwM2X+1s8XKeOuoUVh+lMCYx9weTAIqjxYOgw+a
         4+wm5JdfDLGXSrVSRgTmgyhF9WNQwXxzCX9vZMbJzEfmOSE6MpbdMq0uoKKtKWwhBM9M
         0LhHZQvnSLcBvuJsvom2Mq/MB5WWh37tiLcr+l49SpfG3tsTd891F/icBdKM/Auf1wkL
         mXkDKVa2Pc05v+G4HxkbplviiMo5gRJHy03jls7Yxt1albIi6ZfXv2fgx3oeibke/qII
         cCTgcPRKqCH8YkghvK2Z8Qguk5JGkqOI63IX0SzqUA9LoQATwRbeTJYzYKzVfxLzTpU/
         kN+g==
X-Gm-Message-State: AOJu0Yw68yTrbDnr5MbVY15IOTEsiR5D/75yRqsal8T4MGS9pIrRHGFr
	5iW4pKs7wAC3NtBpcWX5xMS5ymMY1FvQ0res2TfVsW4dcZu3T8D/MU42b7iUvw==
X-Gm-Gg: ASbGncsfxSw2f2j1Eds1u+vDtggazrkQI4kSTI/01G1Qv7fyITNzj6xvC9e2uIbYuW+
	/RXNHaYI93nk7rPPGZsz1y9fHzXH3NapiwVsFvfBX7q5ivivmQz49qbLTfrTY38gPnGtAaeyUFS
	AixjRo+J55Wu66hFKv77n45kHgEKI5eAjZrDU1h1LPFx91A6IYHrW/uOXFMBRW5B4/ZInFFWKhr
	ZfQjRhLx1A0v3oRH16jNyJJ3tRPwzJIrEvtg5SmQga9HV8lkTfdW0VIn0D8GZgDa9HKzZma44Tu
	3ld5ww1s9KqFT6/zSImxzhFy+n/7peScAhe9kx4Fqc8ru8VRII03
X-Google-Smtp-Source: AGHT+IHUuIdB5adgiwFGgMMAefDKnPmBR7Gf6PpRA5B9HT6Q/EpDfsDkXDXt1CLKY1VW3SlYOw3Wgg==
X-Received: by 2002:a17:90b:4ac4:b0:313:28e7:af12 with SMTP id 98e67ed59e1d1-313a16fcc47mr416145a91.35.1749511672574;
        Mon, 09 Jun 2025 16:27:52 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:2::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23603506d58sm59562515ad.227.2025.06.09.16.27.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jun 2025 16:27:52 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	tj@kernel.org,
	martin.lau@kernel.org,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 4/4] selftests/bpf: Test accessing struct_ops this pointer in timer callback
Date: Mon,  9 Jun 2025 16:27:46 -0700
Message-ID: <20250609232746.1030044-4-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250609232746.1030044-1-ameryhung@gmail.com>
References: <20250609232746.1030044-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Check accessing aux->this_st_ops in timer callback. Make sure a kfunc in
a timer callback can get a correct this pointer when a struct_ops map is
attached, and NULL after the map is detached.

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 .../bpf/prog_tests/test_struct_ops_this_ptr.c | 51 ++++++++++++++++
 .../bpf/progs/struct_ops_this_ptr_in_timer.c  | 60 +++++++++++++++++++
 .../selftests/bpf/test_kmods/bpf_testmod.c    |  1 +
 3 files changed, 112 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_this_ptr_in_timer.c

diff --git a/tools/testing/selftests/bpf/prog_tests/test_struct_ops_this_ptr.c b/tools/testing/selftests/bpf/prog_tests/test_struct_ops_this_ptr.c
index 6ef238a2050a..933f9310f462 100644
--- a/tools/testing/selftests/bpf/prog_tests/test_struct_ops_this_ptr.c
+++ b/tools/testing/selftests/bpf/prog_tests/test_struct_ops_this_ptr.c
@@ -3,8 +3,59 @@
 #include <test_progs.h>
 
 #include "struct_ops_this_ptr.skel.h"
+#include "struct_ops_this_ptr_in_timer.skel.h"
+
+static void test_struct_ops_this_ptr_in_timer_common(int timer_nsec, int expected_data)
+{
+	struct struct_ops_this_ptr_in_timer *skel;
+	LIBBPF_OPTS(bpf_test_run_opts, topts);
+	struct bpf_link *link;
+	int err, prog_fd;
+
+	skel = struct_ops_this_ptr_in_timer__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "skel_open_and_load"))
+		return;
+
+	skel->bss->timer_nsec = timer_nsec;
+
+	link = bpf_map__attach_struct_ops(skel->maps.testmod_this_ptr);
+	if (!ASSERT_OK_PTR(link, "bpf_map__attach_struct_ops"))
+		goto out;
+
+	prog_fd = bpf_program__fd(skel->progs.syscall_this_ptr_in_timer);
+	err = bpf_prog_test_run_opts(prog_fd, &topts);
+	ASSERT_OK(err, "bpf_prog_test_run_opts");
+
+	bpf_link__destroy(link);
+
+	/* Check st_ops3_data after timer_cb runs */
+	while (!READ_ONCE(skel->bss->st_ops3_data))
+		sched_yield();
+	ASSERT_EQ(skel->bss->st_ops3_data, expected_data, "st_ops->data");
+out:
+	struct_ops_this_ptr_in_timer__destroy(skel);
+}
+
+static void test_struct_ops_this_ptr_in_timer(void)
+{
+	/* Run timer callback immediately */
+	test_struct_ops_this_ptr_in_timer_common(0, 1234);
+}
+
+static void test_struct_ops_this_ptr_in_timer_after_detach(void)
+{
+	/*
+	 * Run timer callback 0.1s after test run. By then the struct_ops map
+	 * should have been detached.
+	 */
+	test_struct_ops_this_ptr_in_timer_common(100000000, -1);
+}
 
 void serial_test_struct_ops_this_ptr(void)
 {
 	RUN_TESTS(struct_ops_this_ptr);
+	if (test__start_subtest("struct_ops_this_ptr_in_timer"))
+		test_struct_ops_this_ptr_in_timer();
+	if (test__start_subtest("struct_ops_this_ptr_in_timer_after_detach"))
+		test_struct_ops_this_ptr_in_timer_after_detach();
 }
diff --git a/tools/testing/selftests/bpf/progs/struct_ops_this_ptr_in_timer.c b/tools/testing/selftests/bpf/progs/struct_ops_this_ptr_in_timer.c
new file mode 100644
index 000000000000..e5f76945e967
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/struct_ops_this_ptr_in_timer.c
@@ -0,0 +1,60 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <vmlinux.h>
+#include <bpf/bpf_tracing.h>
+#include "../test_kmods/bpf_testmod.h"
+#include "../test_kmods/bpf_testmod_kfunc.h"
+#include "bpf_misc.h"
+
+char _license[] SEC("license") = "GPL";
+
+struct elem {
+	struct bpf_timer timer;
+};
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__uint(max_entries, 1);
+	__type(key, int);
+	__type(value, struct elem);
+} array_map SEC(".maps");
+
+int st_ops3_data;
+int timer_nsec;
+
+__noinline static int timer_cb(void *map, int *key, struct bpf_timer *timer)
+{
+	st_ops3_data = bpf_kfunc_st_ops_test_this_ptr_impl(NULL);
+	return 0;
+}
+
+SEC("struct_ops")
+int BPF_PROG(test1)
+{
+	struct bpf_timer *timer;
+	int key = 0;
+
+	timer = bpf_map_lookup_elem(&array_map, &key);
+	if (!timer)
+		return 0;
+
+	bpf_timer_init(timer, &array_map, 1);
+	bpf_timer_set_callback(timer, timer_cb);
+	bpf_timer_start(timer, timer_nsec, 0);
+	return 1;
+}
+
+SEC("syscall")
+__success __retval(1)
+int syscall_this_ptr_in_timer(void *ctx)
+{
+	return bpf_testmod_ops3_call_test_1();
+}
+
+SEC(".struct_ops.link")
+struct bpf_testmod_ops3 testmod_this_ptr = {
+	.test_1 = (void *)test1,
+	.data = 1234,
+};
+
+
diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
index f692ee43d25c..65953cd63b7c 100644
--- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
+++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
@@ -1157,6 +1157,7 @@ static const struct bpf_verifier_ops bpf_testmod_verifier_ops = {
 };
 
 static const struct bpf_verifier_ops bpf_testmod_verifier_ops3 = {
+	.get_func_proto	 = bpf_base_func_proto,
 	.is_valid_access = bpf_testmod_ops_is_valid_access,
 };
 
-- 
2.47.1


