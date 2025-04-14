Return-Path: <bpf+bounces-55883-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7415A88840
	for <lists+bpf@lfdr.de>; Mon, 14 Apr 2025 18:15:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1FCC3AFC36
	for <lists+bpf@lfdr.de>; Mon, 14 Apr 2025 16:15:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8CA118C031;
	Mon, 14 Apr 2025 16:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IXU1v6CO"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com [209.85.221.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2781528466A
	for <bpf@vger.kernel.org>; Mon, 14 Apr 2025 16:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744647306; cv=none; b=EAXdSqso2+CIE8aKQIReJhmDyPrp3GzvVpAu66X0KRC6bdFqoQI6O3ywzEUhFfBu1Cwl/u9nOORjXxyPPnblDcWjKq7M/xeSkx4wQkRdr1iDhXGdp//VFrL/DoYo07VyfRTVzNV7+FHgZfRBM4z0PhgAVSRwE3cv+EjapqMeG9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744647306; c=relaxed/simple;
	bh=QguIH1z80V5cNJuVx131OTvghBk8Z4Xi80xxA2eGwH0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oztKm6+T1qwbmJJE4/xR7h4BleCv2illeKSyp01ZwnMxk3sHGd2OEDNnOI1ya9iOXp78rwY66J8C7cw+xTiscVn+Eqj1MQxA7wV+9KXN52Sa6BQt9zaKPbA/nwNY2vY4qQ5t5sbxKcAyAH8JacyO3du/K9znxQ1P1R4pWeZt4Co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IXU1v6CO; arc=none smtp.client-ip=209.85.221.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f67.google.com with SMTP id ffacd0b85a97d-39141ffa9fcso5906364f8f.0
        for <bpf@vger.kernel.org>; Mon, 14 Apr 2025 09:15:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744647302; x=1745252102; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XCzapY3TRrZegaQHEW5ua4H390UyCLjHITvhvd7+/lI=;
        b=IXU1v6COgIoGMdPpR9rbt6IUFe28W0ppYyEf5CMKafi6kuFnFs0T3Tto75QwNS3dLC
         Iybvt4sYA0i0VLGaD95QC818QV++dgXwzM7HUjt/k8Z/9BDH5FvUbobcIIQZU3I1830Y
         QgXKmtrtzyvo+WeHMVhF3o1jhmnIdGx3s3RblGZssG/avDqCLf3DdxPEBOTrZp9VP8+m
         /Y+Vbd8uNjUjwX/q6WLVzWwoqElAOYABW3fb3F0Ms+WfK5MlCQ3VCqE1E2/t1lCn6opp
         XzamsCdIvkrGZr7kXgxI1NxnYBntIaqOt1lS6Z6T9mfpiWpjhTEybjTkizljpth+mC8A
         UR5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744647302; x=1745252102;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XCzapY3TRrZegaQHEW5ua4H390UyCLjHITvhvd7+/lI=;
        b=Y7wmmd3NuUUEre8oLaoFCm20sejx7dbDQ8oZrvd7KFrSi2RSlg1lZWP59FKPLZse9o
         rFKrEE2O+R41/SaeJw/UVb+Hw5GGfl6SeU+rY/zu2s730jp0ep1tW9IvmirrCl6qQ+th
         e1Fcjct3wyJsYULoEYVXYdrt1hy+G5txmGUTgUcrgo3/gGLZ/atxAz2Z7RbmH0TXXVeU
         FhI7lm5qBpOX6t0Kp9Nj2VH596VMCSHP2s2nwcvjG8+MJzYIt23uI5tIRpirFC71SIq8
         iBNsxlq1pqjxEWRIKNd1Mm8cdbEIgcH6zaVKNPMuT8f/zuUiC4V4jFzbWBj88mk81Gmi
         JSYQ==
X-Gm-Message-State: AOJu0Yywd5SfyUS+/eWQSOwYs40tBl2UikxSIJoGPDqvXlaAZFCV5h2K
	M9aWxyk8ss2X+DmlQf8ZeowbYQ8tW1PBynMBaiJ1cRTDZ2yLHS4gKp51iC7Decg=
X-Gm-Gg: ASbGncvjphc6PmFsb9gyyJ51F76cW3DvV40KJjGgthikeIq7sgsJGSunDNn5anoxqSi
	BX88+DLdK4Dcs0c7wfTxeZhsfTnWzyeiPUz6cS425cHlpBlii2DuGyZhigSd0mCE9xtoTcc/YmF
	ZRp51P6Hy4+KVy7DVOff/oPJO64ZA/x2uvEgNVoTLYQcSd0OFwtGMPSwkaiSrh+yVJj7ERSQFbU
	GczWxjIoJ12Z52+BJd85RdKGBEWWyhPS5Mz1QHRK3szWjd5zCjY78dR/cirwRCc1dD5xxUdlYX3
	rUwLcMurlJ+ah/YPAhUNNCxv4vONjZg=
X-Google-Smtp-Source: AGHT+IHVjycceOFOM3llgyTaLamhJyleTafUCjarP/c3mgGA9l/KmPK2K6HxWK/B58lMFLzDj5+qkw==
X-Received: by 2002:a05:6000:2287:b0:391:4c0c:c807 with SMTP id ffacd0b85a97d-39eaaec7a57mr10659966f8f.53.1744647301913;
        Mon, 14 Apr 2025 09:15:01 -0700 (PDT)
Received: from localhost ([2a03:2880:31ff:70::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39eae96403dsm11220042f8f.4.2025.04.14.09.15.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Apr 2025 09:15:01 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Barret Rhoden <brho@google.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [RFC PATCH bpf-next/net v1 13/13] selftests/bpf: Add tests for prog streams
Date: Mon, 14 Apr 2025 09:14:43 -0700
Message-ID: <20250414161443.1146103-14-memxor@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250414161443.1146103-1-memxor@gmail.com>
References: <20250414161443.1146103-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=12039; h=from:subject; bh=QguIH1z80V5cNJuVx131OTvghBk8Z4Xi80xxA2eGwH0=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBn/TOKgb9gJ4FgOUEI9Ozv8/CtqTazGpctNSoeEqMH U3bjddSJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZ/0zigAKCRBM4MiGSL8RytHzD/ 9hJ1s1Pq1ivw6ZJhkAl+1Tkob5Ah706dpEzS64nwxmgn6cjmL3y1g00PNtjcO5tH6J7Re4PiCJkyq5 OUL1t4vHqpgvv7ospLZbN9CzQPo7jRL0lomIZ6T7JErUZdkcYSDUA2tCXah/7gp1qJb1oa5nQgi30X Mmh/qLnJebCkuGXbLbn7Q5Zz86lypxq1/mJyfEI4TAKykk3vhD2t8kgSWAU19gZzk+cHwFVXJWdh9L OBhQ7C7ZxXIDHaK+BUQzbhanDO8X8HbHed9swWsJqRrL81yM5K//LGiSUQpRqiKEohPKAc5BGhkhRL mFR/HGdAMpRLJ22M3vQz6lwfbN9j05cAcruPyHnfMrY2Smlh/cve+ZnXkqkyMqst5P+8OeSabZWhNG DWUwm9MwX5O7tnqy76ICLWIknFEO9gsLI0tjp2lW7L8jrsGAiZ/Uw1goQ3tnVqbaQie6HG+b3oSKcT t3DItKuMr6Ek6zQVhqIxo2dLm7h3WbPBZEyDMr3EaquWSnyAQmozvk040w6+lHv2VQ+MzYkOcsVPlv O/Jnl7Hz+HlYYCZa26oLEQC/O7ufFF7kG51GVHDcV59jMRFqVwx5ejg0LLPHh6ysjt5nJevyV4/vXH kKaDQvsT1n7jL5NVRpoZKqup6zV2gf8pM+a15dhaDEwlwikEfA5fCPYytcFQ==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

Add selftests to stress test the various facets of the stream API,
memory allocation pattern, and ensuring dumping support is tested
and functional.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 .../testing/selftests/bpf/prog_tests/stream.c |  57 +++++++
 .../testing/selftests/bpf/progs/dynptr_fail.c |  28 ++++
 tools/testing/selftests/bpf/progs/stream.c    | 150 ++++++++++++++++++
 .../selftests/bpf/progs/stream_bpftool.c      | 142 +++++++++++++++++
 .../testing/selftests/bpf/progs/stream_fail.c |  38 +++++
 5 files changed, 415 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/stream.c
 create mode 100644 tools/testing/selftests/bpf/progs/stream.c
 create mode 100644 tools/testing/selftests/bpf/progs/stream_bpftool.c
 create mode 100644 tools/testing/selftests/bpf/progs/stream_fail.c

diff --git a/tools/testing/selftests/bpf/prog_tests/stream.c b/tools/testing/selftests/bpf/prog_tests/stream.c
new file mode 100644
index 000000000000..b01cb18d8de5
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/stream.c
@@ -0,0 +1,57 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2025 Meta Platforms, Inc. and affiliates. */
+#include <test_progs.h>
+#include <sys/mman.h>
+
+#include "stream.skel.h"
+#include "stream_fail.skel.h"
+
+#include "stream_bpftool.skel.h"
+
+void test_stream_failure(void)
+{
+	RUN_TESTS(stream_fail);
+}
+
+void test_stream_success(void)
+{
+	RUN_TESTS(stream);
+	RUN_TESTS(stream_bpftool);
+	return;
+}
+
+static int process_sample(void *ctx, void *data, size_t len)
+{
+	fprintf(stderr, "%s", (char *)data);
+	return 0;
+}
+
+void test_stream_ringbuf_output(void)
+{
+	LIBBPF_OPTS(bpf_test_run_opts, opts);
+	struct ring_buffer *ringbuf;
+	struct stream_bpftool *skel;
+	int fd, ret;
+
+	skel = stream_bpftool__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "stream_bpftool_open_and_load"))
+		return;
+
+	fd = bpf_map__fd(skel->maps.ringbuf);
+
+	ringbuf = ring_buffer__new(fd, process_sample, NULL, NULL);
+	if (!ASSERT_OK_PTR(ringbuf, "ringbuf_new"))
+		goto end;
+
+	do {
+		skel->bss->written_count = skel->bss->written_size = 0;
+		ret = bpf_prog_test_run_opts(bpf_program__fd(skel->progs.stream_bpftool_dump_prog_stream), &opts);
+		ASSERT_EQ(ring_buffer__consume_n(ringbuf, skel->bss->written_count), skel->bss->written_count, "consume");
+	} while (!ret && opts.retval == EAGAIN);
+
+	ASSERT_OK(ret, "ret");
+	ASSERT_EQ(opts.retval, 0, "retval");
+
+end:
+	stream_bpftool__destroy(skel);
+}
diff --git a/tools/testing/selftests/bpf/progs/dynptr_fail.c b/tools/testing/selftests/bpf/progs/dynptr_fail.c
index 7c67797a5aac..545831b43fc8 100644
--- a/tools/testing/selftests/bpf/progs/dynptr_fail.c
+++ b/tools/testing/selftests/bpf/progs/dynptr_fail.c
@@ -1734,3 +1734,31 @@ int test_dynptr_reg_type(void *ctx)
 	global_call_bpf_dynptr((const struct bpf_dynptr *)current);
 	return 0;
 }
+
+SEC("?syscall")
+__failure __msg("Expected an initialized dynptr as arg #2")
+int test_dynptr_source_release_btf(void *ctx)
+{
+	struct bpf_stream_elem_batch *elem_batch;
+	struct bpf_stream_elem *elem;
+	struct bpf_stream *stream;
+	struct bpf_dynptr dptr;
+	char buf[8];
+
+	stream = bpf_stream_get(BPF_STDERR, NULL);
+	if (!stream)
+		return 0;
+	elem_batch = bpf_stream_next_elem_batch(stream);
+	if (!elem_batch)
+		return 0;
+	elem = bpf_stream_next_elem(elem_batch);
+	if (!elem) {
+		bpf_stream_free_elem_batch(elem_batch);
+		return 0;
+	}
+	bpf_dynptr_from_mem_slice(&elem->mem_slice, 0, &dptr);
+	bpf_stream_free_elem(elem);
+
+	bpf_dynptr_read(buf, sizeof(buf), &dptr, 0, 0);
+	return 0;
+}
diff --git a/tools/testing/selftests/bpf/progs/stream.c b/tools/testing/selftests/bpf/progs/stream.c
new file mode 100644
index 000000000000..8616e6200bde
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/stream.c
@@ -0,0 +1,150 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2025 Meta Platforms, Inc. and affiliates. */
+#include <vmlinux.h>
+#include <bpf/bpf_tracing.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
+
+#define _STR "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
+
+#define STREAM_STR (u64)(_STR _STR _STR _STR)
+
+int stream_page_cnt;
+int stream_page_next_cnt;
+
+static __noinline void exhaust_stream_memory(int id)
+{
+	struct bpf_stream *stream;
+
+	bpf_repeat(32) {
+		stream = bpf_stream_get(id, NULL);
+		if (!stream)
+			break;
+		bpf_stream_vprintk(stream, "...", &(u64){0}, 0);
+	}
+}
+
+static __noinline int stream_exercise(int id, int N)
+{
+	struct bpf_stream_elem *elem, *earr[56] = {};
+	struct bpf_stream_elem_batch *batch;
+	struct bpf_stream *stream;
+	int ret;
+	u32 i;
+
+	if (N > 56)
+		return 56;
+
+	stream = bpf_stream_get(id, NULL);
+	if (!stream)
+		return 1;
+	for (i = 0; i < N; i++)
+		if ((ret = bpf_stream_vprintk(stream, "%llu%s", &(u64[]){i, STREAM_STR}, 16)) < 0) {
+			bpf_printk("bpf_stream_vprintk ret=%d", ret);
+			return 2;
+		}
+	batch = bpf_stream_next_elem_batch(stream);
+	if (!batch)
+		return 3;
+	ret = 0;
+	for (i = 0; i < N; i++) {
+		elem = bpf_stream_next_elem(batch);
+		if (!elem) {
+			ret = 4;
+			break;
+		}
+		earr[i] = elem;
+
+		if (elem->flags & BPF_STREAM_ELEM_F_PAGE)
+			stream_page_cnt++;
+		if (elem->flags & BPF_STREAM_ELEM_F_NEXT)
+			stream_page_next_cnt++;
+	}
+	for (i = 0; i < N; i++)
+		if (earr[i])
+			bpf_stream_free_elem(earr[i]);
+	bpf_stream_free_elem_batch(batch);
+	return ret;
+}
+
+static __noinline int stream_exercise_nums(int id)
+{
+	int ret = 0;
+
+	ret = ret ?: stream_exercise(id, 56);
+	ret = ret ?: stream_exercise(id, 42);
+	ret = ret ?: stream_exercise(id, 28);
+	ret = ret ?: stream_exercise(id, 10);
+	ret = ret ?: stream_exercise(id, 1);
+
+	return ret;
+}
+
+SEC("syscall")
+__success __retval(0)
+int stream_test(void *ctx)
+{
+	unsigned long flags;
+	int ret;
+
+	bpf_local_irq_save(&flags);
+
+	/*
+	 * We grab 32 entries from a supposedly filled cache, so we'll have a
+	 * case of elements mixing bpf_mem_alloc() and bpf_stream_page
+	 * allocations.
+	 *
+	 * This also ensures that we test the path where the batch dequeued from
+	 * the kernel contains extra non-extracted elements, that are then freed
+	 * to the respective memory allocator depending on if they come from a
+	 * page or not.
+	 */
+	exhaust_stream_memory(BPF_STDOUT);
+
+	bpf_repeat(50) {
+		ret = stream_exercise_nums(BPF_STDOUT);
+		if (ret)
+			break;
+		if (!stream_page_cnt)
+			break;
+	}
+
+	if (ret) {
+		bpf_local_irq_restore(&flags);
+		return ret;
+	}
+
+	if (!stream_page_cnt) {
+		bpf_local_irq_restore(&flags);
+		return 41;
+	}
+
+	stream_page_cnt = 0;
+
+	bpf_repeat(100) {
+		stream_page_cnt = 0;
+		ret = stream_exercise_nums(BPF_STDERR);
+		if (ret)
+			break;
+	}
+
+	exhaust_stream_memory(BPF_STDOUT);
+
+	bpf_local_irq_restore(&flags);
+
+	if (ret)
+		return ret;
+
+	if (!stream_page_cnt)
+		return 42;
+
+	if (!stream_page_next_cnt)
+		return 43;
+
+	ret = stream_exercise_nums(BPF_STDOUT);
+	if (ret)
+		return ret;
+	return stream_exercise_nums(BPF_STDERR);
+}
+
+char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/progs/stream_bpftool.c b/tools/testing/selftests/bpf/progs/stream_bpftool.c
new file mode 100644
index 000000000000..438c01a96efc
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/stream_bpftool.c
@@ -0,0 +1,142 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2025 Meta Platforms, Inc. and affiliates. */
+#include <vmlinux.h>
+#include <bpf/bpf_tracing.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
+#include "bpf_experimental.h"
+
+struct {
+	__uint(type, BPF_MAP_TYPE_RINGBUF);
+	__uint(max_entries, 1024 * 1024);
+	//__uint(max_entries, 4096 * 2);
+} ringbuf SEC(".maps");
+
+struct value {
+	struct bpf_stream_elem_batch __kptr *batch;
+	struct bpf_res_spin_lock lock;
+};
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__type(key, int);
+	__type(value, struct value);
+	__uint(max_entries, 1);
+} array SEC(".maps");
+
+int written_size;
+int written_count;
+int stream_id;
+int prog_id;
+
+#define ENOENT 2
+#define EAGAIN 11
+#define EFAULT 14
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARENA);
+	__uint(map_flags, BPF_F_MMAPABLE);
+	__uint(max_entries, 100); /* number of pages */
+} arena SEC(".maps");
+
+#define __arena __attribute__((address_space(1)))
+
+void *ptr;
+int zero;
+
+static __noinline void foo(struct bpf_stream *stream)
+{
+	struct value *v1, *v2;
+	int i;
+
+	ptr = &arena;
+
+	v1 = bpf_map_lookup_elem(&array, &(int){0});
+	if (!v1)
+		return;
+	v2 = bpf_map_lookup_elem(&array, &(int){0});
+	if (!v2)
+		return;
+
+	if (!bpf_res_spin_lock(&v1->lock)) {
+		if (!bpf_res_spin_lock(&v2->lock))
+			bpf_res_spin_unlock(&v2->lock);
+		bpf_res_spin_unlock(&v1->lock);
+	}
+
+#ifdef __BPF_FEATURE_ADDR_SPACE_CAST
+	*(u64 __arena *)0xfaceb00c = *(u64 __arena *)0xdeadbeef;
+#endif
+	i = zero;
+	while (can_loop)
+		i = i * 2;
+
+}
+
+bool init = false;
+
+SEC("syscall")
+__success
+int stream_bpftool_dump_prog_stream(void *ctx)
+{
+	struct bpf_stream_elem_batch *elem_batch;
+	struct bpf_stream_elem *elem;
+	struct bpf_stream *stream;
+	bool cont = false;
+	struct value *v;
+	bool ret = 0;
+
+	stream = bpf_stream_get(BPF_STDERR, 0);
+	if (!stream)
+		return ENOENT;
+	if (!init) {
+		foo(stream);
+		init = true;
+	}
+
+	v = bpf_map_lookup_elem(&array, &(int){0});
+
+	if (v->batch)
+		elem_batch = bpf_kptr_xchg(&v->batch, NULL);
+	else
+		elem_batch = bpf_stream_next_elem_batch(stream);
+	if (!elem_batch)
+		goto end;
+
+	while ((elem = bpf_stream_next_elem(elem_batch))) {
+		struct bpf_dynptr dst_dptr, src_dptr;
+		int size = elem->mem_slice.len;
+
+		if (bpf_dynptr_from_mem_slice(&elem->mem_slice, 0, &src_dptr))
+			ret = EFAULT;
+		if (bpf_ringbuf_reserve_dynptr(&ringbuf, size, 0, &dst_dptr))
+			ret = EFAULT;
+		if (bpf_dynptr_copy(&dst_dptr, 0, &src_dptr, 0, size))
+			ret = EFAULT;
+		bpf_ringbuf_submit_dynptr(&dst_dptr, 0);
+
+		written_count++;
+		written_size += size;
+
+		bpf_stream_free_elem(elem);
+
+		/* Probe and exit if no more space, probe for twice the typical size.*/
+		if (bpf_ringbuf_reserve_dynptr(&ringbuf, 2048, 0, &dst_dptr))
+			cont = true;
+		bpf_ringbuf_discard_dynptr(&dst_dptr, 0);
+
+		if (ret || cont)
+			break;
+		cond_break;
+	}
+
+	if (cont)
+		elem_batch = bpf_kptr_xchg(&v->batch, elem_batch);
+	if (elem_batch)
+		bpf_stream_free_elem_batch(elem_batch);
+end:
+
+	return ret ? ret : (cont ? EAGAIN : 0);
+}
+
+char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/progs/stream_fail.c b/tools/testing/selftests/bpf/progs/stream_fail.c
new file mode 100644
index 000000000000..c44590b3ceda
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/stream_fail.c
@@ -0,0 +1,38 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2025 Meta Platforms, Inc. and affiliates. */
+#include <vmlinux.h>
+#include <bpf/bpf_tracing.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
+
+struct map_value {
+	struct bpf_stream_elem_batch __kptr *batch;
+};
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__uint(max_entries, 1);
+	__type(key, int);
+	__type(value, struct map_value);
+} arrmap SEC(".maps");
+
+
+SEC("?tc")
+__failure __msg("untrusted_ptr_bpf_stream_elem_batch()")
+int stream_kptr_ptr_untrusted(struct __sk_buff *ctx)
+{
+	struct bpf_stream_elem_batch *batch;
+	struct map_value *v;
+	int key = 0;
+
+	v = bpf_map_lookup_elem(&arrmap, &key);
+	if (!v)
+		return 0;
+	batch = v->batch;
+	if (!batch)
+		return 0;
+	v->batch = (void *)batch->node->next->next->next;
+	return 0;
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.47.1


