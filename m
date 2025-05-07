Return-Path: <bpf+bounces-57683-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74957AAE79A
	for <lists+bpf@lfdr.de>; Wed,  7 May 2025 19:18:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC7784E6AA7
	for <lists+bpf@lfdr.de>; Wed,  7 May 2025 17:18:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51B7728C5B6;
	Wed,  7 May 2025 17:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VX8iBf+9"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com [209.85.221.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE6CA28B509
	for <bpf@vger.kernel.org>; Wed,  7 May 2025 17:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746638261; cv=none; b=H8kaj7qBjVoG9fufmK1vF3LnrXXvCP5W+Mj/bn226ptljAY/AXp6gxE5yDfDSC7lUNyyWk5X0C+XY/8JX4nfQG/80/eRElK6GT+NRDOoejrCpAgvlmnS1CjjWi8UJX8We9WCnnX36t1p0hPGUU+YJUMG6rkzxonXXpL4g+Lc0js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746638261; c=relaxed/simple;
	bh=Rd4RWUQ21T8NqvcF8OU/Rgeuune/dHxtsoMzGoe2VSk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L+QbzOUy2t95oDZxuaOj5Uhi3W3cFtTKarq/5z3RdrVnDe14zY/HncyrQ1Y7suuSWKtUwfO0POtxThQdvb1dsjcZ8LSUksyYLEajAOA6PvKzBnw7eafgTQB7kmOutCDBtaGgSpn4h9wUJZPIjnU5DI8pBhURZJdjjXgiaAhstrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VX8iBf+9; arc=none smtp.client-ip=209.85.221.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f68.google.com with SMTP id ffacd0b85a97d-39c0dfad22aso108481f8f.2
        for <bpf@vger.kernel.org>; Wed, 07 May 2025 10:17:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746638258; x=1747243058; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aqxFoKSZ/6Z+uqkCTEyZsLmCqvrPwHJq2R70yDfw+uw=;
        b=VX8iBf+9OxQpFT0WGByKYOJVtPZMPjYRa+fMuX7AmSnIBEx6F9ZqHjxjgUiK3f3syd
         qBXhxKSBLV/VunElZDYt7bgTxkNLBXiWfh+VGxlG2jgL7phy49eygWzexxLYWqTIaWWN
         wYRrnDQMdpiwb3G8d4/PIoPeGpVXIm3Jx0DL/wIZiV0F9rj07GaSACQBUJc4NnM13K1S
         hj3g8Fp71ieOtpzUHq4ROCdA+L5notqBUXMGeUT/4e7uMKsfC/vzwy/91XeBiO0V4MQ8
         JZLJCHWurEtDYzH6Jtvd5Dz+BtniRQYUEdQP6ZvbaZ+T73UhNB/lyFG6czfUAOHcbTHa
         5mfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746638258; x=1747243058;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aqxFoKSZ/6Z+uqkCTEyZsLmCqvrPwHJq2R70yDfw+uw=;
        b=LJluKkl+JMH2RLPLABk63nsfhn/sSSTTHZIp3yHEwb3BK12Q6qQgsK/byxS1dO0XqM
         lyftpV3opbhZKJtID5sNHqXrAJ7wZq5b+qxSh3xMrbhTfpASCXAN9RWNbjKzKRvLALPR
         OQ3zKQ0V4PZKTowxbrstHVXV8dTtMvlQyq944f324U2CKn4UhtrCzYbQhmXtrulW6CFT
         xHIrEX2RClFpmw0VOGT9cohOC1+zwJJGb2P2UCzY0P8b3dR5eBeqqTRDwSC0ct8Wc4fd
         HR5vfJWyRhFoAMynbSFvm5Qch1qefao0jSFVUziMp0aq+VFy6b9a2KruHsOQcbLoWor9
         Cs6Q==
X-Gm-Message-State: AOJu0YzlGLig4F2ZnHNJ+JNn8GzOVIC6HiGDKXdLx3q6Yrz6Ek02TbWl
	A4HnoCLrZA/5OE7R9ZVZ1Yxxe/N8VWje8pRLp6O6rlPnCDK8kKRrjSn3QO0fURE=
X-Gm-Gg: ASbGnctg7CHMZMYtN2L8kXOMw3uM1MJZbKGapqpqRZlSZHVfNeQdF2lXe+kG2J87sh1
	9kvpcxoXdMPon67FbtyCua+7O9UkKZOAjfvsKLiMdkpVe3HjmK0kSfv4z3xlCZ0bihZ3aoX4VC2
	Gv13KYeonJ9VA6YPdwoI5yRMtSjvvAfzGPDiXb+7iECKAJh1jvrELJp2FSrSnyda5+KWnFBE6vY
	vmf0DU/dZroVwwSq9AYJ/TUneFGxy2RJFneD8iYBhl6tIhVuOVzS88nPGhnui/vxgqYPTUOvzJn
	swo8ddrBtcy0JlTOL286t5eVnyZVgfQ=
X-Google-Smtp-Source: AGHT+IFR3fDXz2qz7Y9KPM5sRKiVG8JZEPWB/nkpX+bxwDDsfrZbliB4zO6JXUWstbNQliYvcLfLmA==
X-Received: by 2002:a05:6000:1ace:b0:39f:e7b:2c87 with SMTP id ffacd0b85a97d-3a0b4a22c7fmr3630676f8f.29.1746638257609;
        Wed, 07 May 2025 10:17:37 -0700 (PDT)
Received: from localhost ([2a03:2880:31ff:70::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a099ae0c31sm17708579f8f.10.2025.05.07.10.17.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 May 2025 10:17:36 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Barret Rhoden <brho@google.com>,
	Matt Bobrowski <mattbobrowski@google.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 11/11] selftests/bpf: Add tests for prog streams
Date: Wed,  7 May 2025 10:17:20 -0700
Message-ID: <20250507171720.1958296-12-memxor@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250507171720.1958296-1-memxor@gmail.com>
References: <20250507171720.1958296-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=9391; h=from:subject; bh=Rd4RWUQ21T8NqvcF8OU/Rgeuune/dHxtsoMzGoe2VSk=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBoG5WKLaQNieDcLnvCOEf8QTDtmFLigqJcPVD+9g8q uNKuYNCJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCaBuVigAKCRBM4MiGSL8RylbAD/ 0YqJ5Q/sS7YijE2JCI25fL6xjuhOuL6xmYqOwUw6tLte/EiE9QP5R8xnEHtr+Mcv2UV+lktV7/JMsg Ws2/f37K+Bud+PCjl0+H+XBObgkdQtJyb3V1YAg2Xe6di72SMpV/S5l9gVDOg4EidR2TSP5u8iMuN4 Czx2loWJxvq9W+Im2wzWvpW5KVWeO2sxi1T1VlCnKO66KsF5GLXUkdELqqooGKhPTEX+KNlYlPdKFW nPD2jwHzLTlIEYm+yiGP3e//FtoBY66r2xk4bm/5JkFtW5QJCsctoT+q9L1qPWR3gLVVrG0HNGK6mF vkxGutuz9g9ynTVuCspP4HThvXbGY6ARIv9pRq/1ATk0unOn8+Ybc1Rx9DGouy9VZoSr5P99XeAizx 4CpUSgxeJczrVhQGcXQIY5+FA9mmjCZeK9FTgYVBhAKpLIL5OCkbbdQyEn8icAdFRWePeRFwav/6Kr OYHA91hTK87hRM7Y4vy0nsHHqp8CuzR4LWeKEeR/QVJn65QspDMccrOShnpYltTRImAjYUOQP414KN um4ybxIgvuDkKsV0byF9ZC+9LXJwWcRViGGGOtX0jF4fWkm1ei6Q3BhA6GVqveW74Td8F/2QeRscsu sWrR+DkjZS9IPi2QxW2HLIp7wR1mHXF3sK0Jv46PdnoTtGD8TuQefgzZohDw==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

Add selftests to stress test the various facets of the stream API,
memory allocation pattern, and ensuring dumping support is tested and
functional. Create symlink to bpftool stream.bpf.c and use it to test
the support to dump messages to ringbuf in user space, and verify
output.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 .../testing/selftests/bpf/prog_tests/stream.c |  95 +++++++++++++
 tools/testing/selftests/bpf/progs/stream.c    | 127 ++++++++++++++++++
 .../selftests/bpf/progs/stream_bpftool.c      |   1 +
 .../testing/selftests/bpf/progs/stream_fail.c |  90 +++++++++++++
 4 files changed, 313 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/stream.c
 create mode 100644 tools/testing/selftests/bpf/progs/stream.c
 create mode 120000 tools/testing/selftests/bpf/progs/stream_bpftool.c
 create mode 100644 tools/testing/selftests/bpf/progs/stream_fail.c

diff --git a/tools/testing/selftests/bpf/prog_tests/stream.c b/tools/testing/selftests/bpf/prog_tests/stream.c
new file mode 100644
index 000000000000..7b97b783ff1f
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/stream.c
@@ -0,0 +1,95 @@
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
+typedef int (*sample_cb_t)(void *, void *, size_t);
+
+static void stream_ringbuf_output(int prog_id, sample_cb_t sample_cb)
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
+	ringbuf = ring_buffer__new(fd, sample_cb, NULL, NULL);
+	if (!ASSERT_OK_PTR(ringbuf, "ringbuf_new"))
+		goto end;
+
+	skel->bss->prog_id = prog_id;
+	skel->bss->stream_id = 1;
+	do {
+		skel->bss->written_count = skel->bss->written_size = 0;
+		ret = bpf_prog_test_run_opts(bpf_program__fd(skel->progs.bpftool_dump_prog_stream), &opts);
+		if (ret)
+			break;
+		ret = ring_buffer__consume_n(ringbuf, skel->bss->written_count);
+		if (!ASSERT_EQ(ret, skel->bss->written_count, "consume"))
+			break;
+		ret = 0;
+	} while (opts.retval == EAGAIN);
+
+	ASSERT_OK(ret, "ret");
+	ASSERT_EQ(opts.retval, 0, "retval");
+
+end:
+	stream_bpftool__destroy(skel);
+}
+
+int cnt = 0;
+
+static int process_sample(void *ctx, void *data, size_t len)
+{
+	char buf[64];
+
+	snprintf(buf, sizeof(buf), "num=%d\n", cnt++);
+	ASSERT_TRUE(strcmp(buf, (char *)data) == 0, "sample strcmp");
+	return 0;
+}
+
+void test_stream_output(void)
+{
+	LIBBPF_OPTS(bpf_test_run_opts, opts);
+	struct bpf_prog_info info = {};
+	__u32 info_len = sizeof(info);
+	struct stream *skel;
+	int ret;
+
+	skel = stream__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "stream__open_and_load"))
+		return;
+
+	ASSERT_OK(bpf_prog_get_info_by_fd(bpf_program__fd(skel->progs.stream_test_output), &info, &info_len), "get info");
+	ret = bpf_prog_test_run_opts(bpf_program__fd(skel->progs.stream_test_output), &opts);
+	ASSERT_OK(ret, "ret");
+	ASSERT_OK(opts.retval, "retval");
+	stream_ringbuf_output(info.id, process_sample);
+
+	ASSERT_EQ(cnt, 1000, "cnt");
+
+	stream__destroy(skel);
+	return;
+}
diff --git a/tools/testing/selftests/bpf/progs/stream.c b/tools/testing/selftests/bpf/progs/stream.c
new file mode 100644
index 000000000000..14cb8690824f
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/stream.c
@@ -0,0 +1,127 @@
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
+static __noinline int stream_exercise(int id, int N)
+{
+	struct bpf_stream_elem *elem, *earr[56] = {};
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
+	ret = 0;
+	for (i = 0; i < N; i++) {
+		elem = bpf_stream_next_elem(stream);
+		if (!elem) {
+			ret = 4;
+			break;
+		}
+		earr[i] = elem;
+	}
+	elem = bpf_stream_next_elem(stream);
+	if (elem) {
+		bpf_stream_free_elem(elem);
+		ret = 5;
+	}
+	for (i = 0; i < N; i++)
+		if (earr[i])
+			bpf_stream_free_elem(earr[i]);
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
+	bpf_repeat(50) {
+		ret = stream_exercise_nums(BPF_STDOUT);
+		if (ret)
+			break;
+	}
+	if (ret) {
+		bpf_local_irq_restore(&flags);
+		return ret;
+	}
+	bpf_repeat(100) {
+		ret = stream_exercise_nums(BPF_STDERR);
+		if (ret)
+			break;
+	}
+	bpf_local_irq_restore(&flags);
+
+	if (ret)
+		return ret;
+
+	ret = stream_exercise_nums(BPF_STDOUT);
+	if (ret)
+		return ret;
+	return stream_exercise_nums(BPF_STDERR);
+}
+
+SEC("syscall")
+__success __retval(0)
+int stream_test_output(void *ctx)
+{
+	for (int i = 0; i < 1000; i++)
+		bpf_stream_printk(BPF_STDOUT, "num=%d\n", i);
+	return 0;
+}
+
+SEC("syscall")
+__success __retval(0)
+int stream_test_limit(void *ctx)
+{
+	struct bpf_stream *stream;
+	bool failed = false;
+
+	stream = bpf_stream_get(BPF_STDOUT, NULL);
+	if (!stream)
+		return 2;
+
+	bpf_repeat(BPF_MAX_LOOPS) {
+		failed = bpf_stream_vprintk(stream, "%s%s%s", &(u64[]){STREAM_STR, STREAM_STR}, 16) != 0;
+		if (failed)
+			break;
+	}
+
+	if (failed)
+		return 0;
+	return 1;
+}
+
+char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/progs/stream_bpftool.c b/tools/testing/selftests/bpf/progs/stream_bpftool.c
new file mode 120000
index 000000000000..5904c0d92edc
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/stream_bpftool.c
@@ -0,0 +1 @@
+../../../../bpf/bpftool/skeleton/stream.bpf.c
\ No newline at end of file
diff --git a/tools/testing/selftests/bpf/progs/stream_fail.c b/tools/testing/selftests/bpf/progs/stream_fail.c
new file mode 100644
index 000000000000..50f70b9878b8
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/stream_fail.c
@@ -0,0 +1,90 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2025 Meta Platforms, Inc. and affiliates. */
+#include <vmlinux.h>
+#include <bpf/bpf_tracing.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_core_read.h>
+#include "bpf_misc.h"
+
+SEC("syscall")
+__failure __msg("R1 type=trusted_ptr_or_null_ expected=")
+int stream_get_trusted(void *ctx) {
+	struct bpf_stream *stream;
+
+	stream = bpf_stream_get(BPF_STDOUT, NULL);
+	bpf_this_cpu_ptr(stream);
+	return 0;
+}
+
+SEC("tc")
+__failure __msg("calling kernel function bpf_prog_stream_get is not allowed")
+int stream_get_prog_fail(void *ctx) {
+	struct bpf_stream *stream;
+
+	stream = bpf_prog_stream_get(BPF_STDOUT, 0);
+	if (!stream)
+		return 0;
+	bpf_this_cpu_ptr(stream);
+	return 0;
+}
+
+SEC("syscall")
+__failure __msg("R1 type=ptr_or_null_ expected=")
+int stream_get_prog_trusted(void *ctx) {
+	struct bpf_stream *stream;
+
+	stream = bpf_prog_stream_get(BPF_STDOUT, 0);
+	bpf_this_cpu_ptr(stream);
+	return 0;
+}
+
+SEC("syscall")
+__failure __msg("Unreleased reference")
+int stream_get_put_missing(void *ctx) {
+	struct bpf_stream *stream;
+
+	stream = bpf_prog_stream_get(BPF_STDOUT, 0);
+	if (!stream)
+		return 0;
+	return 0;
+}
+
+SEC("syscall")
+__failure __msg("R1 must be referenced or trusted")
+int stream_next_untrusted_arg(void *ctx)
+{
+	struct bpf_stream *stream;
+
+	stream = bpf_core_cast((void *)0xdeadbeef, typeof(*stream));
+	bpf_stream_next_elem(stream);
+	return 0;
+}
+
+SEC("syscall")
+__failure __msg("Possibly NULL pointer passed")
+int stream_next_null_arg(void *ctx)
+{
+	bpf_stream_next_elem(NULL);
+	return 0;
+}
+
+SEC("syscall")
+__failure __msg("R1 must be referenced or trusted")
+int stream_vprintk_untrusted_arg(void *ctx)
+{
+	struct bpf_stream *stream;
+
+	stream = bpf_core_cast((void *)0xfaceb00c, typeof(*stream));
+	bpf_stream_vprintk(stream, "", NULL, 0);
+	return 0;
+}
+
+SEC("syscall")
+__failure __msg("Possibly NULL pointer passed")
+int stream_vprintk_null_arg(void *ctx)
+{
+	bpf_stream_vprintk(NULL, "", NULL, 0);
+	return 0;
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.47.1


