Return-Path: <bpf+bounces-27318-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 00C958ABC48
	for <lists+bpf@lfdr.de>; Sat, 20 Apr 2024 17:59:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5B3C2815BF
	for <lists+bpf@lfdr.de>; Sat, 20 Apr 2024 15:59:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49FA5376FE;
	Sat, 20 Apr 2024 15:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="LIPxk7PH"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B566625
	for <bpf@vger.kernel.org>; Sat, 20 Apr 2024 15:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713628760; cv=none; b=GDhoivFOvs2iSZkbWYimoGI91Ae9pePB6GdK8HoIQwtYy+1xuBHtzd50dRB+nO5DZwWrwFwuu9A6iErx6tKbXx3sAKDARPnu63+yzZqP2Uf9lQ8Ko6xXzVwIWTnfckhI4XC/vDCNBt/qXcLsJlUBNRCf5Nl87sUePu6ERvKJXrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713628760; c=relaxed/simple;
	bh=nNRohb4TCqxwIK1Y/PiM1fnTGVi7tniX1l39w0EWGdQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=X7bNGxBjiTyU5sTWtt+wSpDzibA3GCrexqf7f3jttzRiIDIvqkIZ+1POwINtIaHFR8uGQnlvSkKSIOQp4ozhJmz8GI4j0KaB4E9lvEVCJyWt52LnXluDahePNx/AwH+iXd/tEMcr04X4AfhjK0iU785FrPfVB7m1hhYOBhIfbmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=LIPxk7PH; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com [209.85.128.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id E8CDA3F626
	for <bpf@vger.kernel.org>; Sat, 20 Apr 2024 15:59:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1713628755;
	bh=L2v1NeYeJE3K4VQPmxfg+80DARtMgvysXIKgeUBdR7A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
	b=LIPxk7PHqN2WqphaRY9jgEXQC94B3y6EZ6CSEWzJwsOoorWp891yEB+yiH5R/Z6L2
	 bMiruy4mjcSkO3w/5TwXjiOvT8TzlQqOLX14L9CoguBzZW1RwFD+eM0ZEzEjC/3ra7
	 TGNaDAI5fg0t61oNDKpNSVfPhSN58trO99gHe5GnMCd5GUCE8TGYA68vwoSkSP/Q73
	 ZlxhmUDgpJd2vrGqeWrp7dHrp5zPk9eEte3nfp7dceyKzVNKB6DWJibXvw35Aj4Q34
	 jyh0qdmN2XcTBqxNqVcU3ol08+/1awu/zJ0j1vAMxCmhXkL8vgA1H55eIxJIOlyE56
	 kEZuKt7riqiNw==
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-419e3f83aeeso4124945e9.1
        for <bpf@vger.kernel.org>; Sat, 20 Apr 2024 08:59:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713628755; x=1714233555;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L2v1NeYeJE3K4VQPmxfg+80DARtMgvysXIKgeUBdR7A=;
        b=G2jVP2rSpBajbqMvCXaVAK5Pvq00HOeaBWouIs9H08itZ1OE3GeZEhBDKn46nplXAP
         T7ajj8kX/9dOhx+Afkxrh+wiOSbYEVnkgKEZ+KBzUWzUA0L5yScGq84E7n0Po3ZmF9p9
         i3RYltrXshFPj894+Wrd+aapAU5b4fbvg7tVe7yuG3HgSw7sFx6wY1Ly6aIad/Brvhvm
         lDawDWZ46MKO2ASzyjTUu6UjNKh6ASnONchf+sgVh9NI3Fp2oBrkH23O0HYdMULfwXdC
         BjtB9MEvOb8LCONQFR0cehx8VFYQ6igaQ7yhqzFGjU3t5syCMofO6litiugHXDIsZORr
         uQfA==
X-Forwarded-Encrypted: i=1; AJvYcCUVWRN7l3U66BXiO7oCgnWVSflzHycWwGebFw7mRWlhSyzNeiT72M52ivSwKJh7XOvDRCBVPbFvtdIwGW/BdV2xe+vb
X-Gm-Message-State: AOJu0Yyo/1/6bI49a4qx+FoZTN7IOe7GPnzJpeWcflZBN7piwb04GNA8
	W2d3vhlgXB3fBGYBCFBoeRBswaXOxLAtrkE39WW084AXk85p6EG1xl3iiIW6xkW5lKtHYuVaIVT
	psqjUyrggFd/2CpS++X5Pr2J4b058kMISODYf+1GWjneWzQ1ZdrWYgFT+Bl10NQJM8Q==
X-Received: by 2002:a05:600c:5008:b0:419:db01:f391 with SMTP id n8-20020a05600c500800b00419db01f391mr2064587wmr.12.1713628755019;
        Sat, 20 Apr 2024 08:59:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IES1yNyzlrb+9WaiK0MZQfB1d9PfHUIaT+JsnQy9N4roDXlEI01EQiBXdSmC1jsqyYTOTc6dQ==
X-Received: by 2002:a05:600c:5008:b0:419:db01:f391 with SMTP id n8-20020a05600c500800b00419db01f391mr2064560wmr.12.1713628754198;
        Sat, 20 Apr 2024 08:59:14 -0700 (PDT)
Received: from gpd.. ([151.57.165.71])
        by smtp.gmail.com with ESMTPSA id r16-20020a5d6950000000b003477d26736dsm7154350wrw.94.2024.04.20.08.59.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Apr 2024 08:59:13 -0700 (PDT)
From: Andrea Righi <andrea.righi@canonical.com>
To: Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Mykola Lysenko <mykolal@fb.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Shuah Khan <shuah@kernel.org>,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Andrea Righi <andrea.righi@canonical.com>
Subject: [PATCH] selftests/bpf: Add ring_buffer__consume_n test.
Date: Sat, 20 Apr 2024 17:59:04 +0200
Message-ID: <20240420155904.1450768-1-andrea.righi@canonical.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a testcase for the ring_buffer__consume_n() API.

The test produces multiple samples in a ring buffer, using a
sys_getpid() fentry prog, and consumes them from user-space in batches,
rather than consuming all of them greedily, like ring_buffer__consume()
does.

Link: https://lore.kernel.org/lkml/CAEf4BzaR4zqUpDmj44KNLdpJ=Tpa97GrvzuzVNO5nM6b7oWd1w@mail.gmail.com
Signed-off-by: Andrea Righi <andrea.righi@canonical.com>
---
 tools/testing/selftests/bpf/Makefile          |  2 +-
 .../selftests/bpf/prog_tests/ringbuf.c        | 65 +++++++++++++++++++
 .../selftests/bpf/progs/test_ringbuf_n.c      | 52 +++++++++++++++
 3 files changed, 118 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/bpf/progs/test_ringbuf_n.c

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index edc73f8f5aef..6332277edeca 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -455,7 +455,7 @@ LINKED_SKELS := test_static_linked.skel.h linked_funcs.skel.h		\
 LSKELS := fentry_test.c fexit_test.c fexit_sleep.c atomics.c 		\
 	trace_printk.c trace_vprintk.c map_ptr_kern.c 			\
 	core_kern.c core_kern_overflow.c test_ringbuf.c			\
-	test_ringbuf_map_key.c
+	test_ringbuf_n.c test_ringbuf_map_key.c
 
 # Generate both light skeleton and libbpf skeleton for these
 LSKELS_EXTRA := test_ksyms_module.c test_ksyms_weak.c kfunc_call_test.c \
diff --git a/tools/testing/selftests/bpf/prog_tests/ringbuf.c b/tools/testing/selftests/bpf/prog_tests/ringbuf.c
index 48c5695b7abf..7e085bfce9b5 100644
--- a/tools/testing/selftests/bpf/prog_tests/ringbuf.c
+++ b/tools/testing/selftests/bpf/prog_tests/ringbuf.c
@@ -13,6 +13,7 @@
 #include <linux/perf_event.h>
 #include <linux/ring_buffer.h>
 #include "test_ringbuf.lskel.h"
+#include "test_ringbuf_n.lskel.h"
 #include "test_ringbuf_map_key.lskel.h"
 
 #define EDONE 7777
@@ -60,6 +61,7 @@ static int process_sample(void *ctx, void *data, size_t len)
 }
 
 static struct test_ringbuf_map_key_lskel *skel_map_key;
+static struct test_ringbuf_n_lskel *skel_n;
 static struct test_ringbuf_lskel *skel;
 static struct ring_buffer *ringbuf;
 
@@ -326,6 +328,67 @@ static void ringbuf_subtest(void)
 	test_ringbuf_lskel__destroy(skel);
 }
 
+/*
+ * Test ring_buffer__consume_n() by producing N_TOT_SAMPLES samples in the ring
+ * buffer, via getpid(), and consuming them in chunks of N_SAMPLES.
+ */
+#define N_TOT_SAMPLES	32
+#define N_SAMPLES	4
+
+/* Sample value to verify the callback validity */
+#define SAMPLE_VALUE	42L
+
+static int process_n_sample(void *ctx, void *data, size_t len)
+{
+	struct sample *s = data;
+
+	CHECK(s->value != SAMPLE_VALUE,
+	      "sample_value", "exp %ld, got %ld\n", SAMPLE_VALUE, s->value);
+
+	return 0;
+}
+
+static void ringbuf_n_subtest(void)
+{
+	int err, i;
+
+	skel_n = test_ringbuf_n_lskel__open();
+	if (!ASSERT_OK_PTR(skel_n, "test_ringbuf_n_lskel__open"))
+		return;
+
+	skel_n->maps.ringbuf.max_entries = getpagesize();
+	skel_n->bss->pid = getpid();
+
+	err = test_ringbuf_n_lskel__load(skel_n);
+	if (!ASSERT_OK(err, "test_ringbuf_n_lskel__load"))
+		goto cleanup;
+
+	ringbuf = ring_buffer__new(skel_n->maps.ringbuf.map_fd,
+				   process_n_sample, NULL, NULL);
+	if (!ASSERT_OK_PTR(ringbuf, "ring_buffer__new"))
+		goto cleanup;
+
+	err = test_ringbuf_n_lskel__attach(skel_n);
+	if (!ASSERT_OK(err, "test_ringbuf_n_lskel__attach"))
+		goto cleanup_ringbuf;
+
+	/* Produce N_TOT_SAMPLES samples in the ring buffer by calling getpid() */
+	skel->bss->value = SAMPLE_VALUE;
+	for (i = 0; i < N_TOT_SAMPLES; i++)
+		syscall(__NR_getpgid);
+
+	/* Consume all samples from the ring buffer in batches of N_SAMPLES */
+	for (i = 0; i < N_TOT_SAMPLES; i += err) {
+		err = ring_buffer__consume_n(ringbuf, N_SAMPLES);
+		ASSERT_EQ(err, N_SAMPLES, "rb_consume");
+	}
+
+cleanup_ringbuf:
+	ring_buffer__free(ringbuf);
+cleanup:
+	test_ringbuf_n_lskel__destroy(skel_n);
+}
+
 static int process_map_key_sample(void *ctx, void *data, size_t len)
 {
 	struct sample *s;
@@ -384,6 +447,8 @@ void test_ringbuf(void)
 {
 	if (test__start_subtest("ringbuf"))
 		ringbuf_subtest();
+	if (test__start_subtest("ringbuf_n"))
+		ringbuf_n_subtest();
 	if (test__start_subtest("ringbuf_map_key"))
 		ringbuf_map_key_subtest();
 }
diff --git a/tools/testing/selftests/bpf/progs/test_ringbuf_n.c b/tools/testing/selftests/bpf/progs/test_ringbuf_n.c
new file mode 100644
index 000000000000..b98b5bb20699
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_ringbuf_n.c
@@ -0,0 +1,52 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (c) 2024 Andrea Righi <andrea.righi@canonical.com>
+
+#include <linux/bpf.h>
+#include <sched.h>
+#include <unistd.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
+
+char _license[] SEC("license") = "GPL";
+
+#define TASK_COMM_LEN 16
+
+struct sample {
+	int pid;
+	int seq;
+	long value;
+	char comm[16];
+};
+
+struct {
+	__uint(type, BPF_MAP_TYPE_RINGBUF);
+} ringbuf SEC(".maps");
+
+int pid = 0;
+long value = 0;
+
+/* inner state */
+long seq = 0;
+
+SEC("fentry/" SYS_PREFIX "sys_getpgid")
+int test_ringbuf_n(void *ctx)
+{
+	int cur_pid = bpf_get_current_pid_tgid() >> 32;
+	struct sample *sample;
+
+	if (cur_pid != pid)
+		return 0;
+
+	sample = bpf_ringbuf_reserve(&ringbuf, sizeof(*sample), 0);
+	if (!sample)
+		return 0;
+
+	sample->pid = pid;
+	sample->seq = seq++;
+	sample->value = value;
+	bpf_get_current_comm(sample->comm, sizeof(sample->comm));
+
+	bpf_ringbuf_submit(sample, 0);
+
+	return 0;
+}
-- 
2.43.0


