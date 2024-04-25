Return-Path: <bpf+bounces-27814-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56E658B2383
	for <lists+bpf@lfdr.de>; Thu, 25 Apr 2024 16:07:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 790B51C20DF0
	for <lists+bpf@lfdr.de>; Thu, 25 Apr 2024 14:07:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4A1614A0B9;
	Thu, 25 Apr 2024 14:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="JQjfvC9i"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEF66149DF2
	for <bpf@vger.kernel.org>; Thu, 25 Apr 2024 14:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714053997; cv=none; b=p7ChM9yQwSNShFQofxi17O8vKrOhedtceKJiA0LOuVXeLb5kDN8xcLpNEAQA19UVFvfzTwU8wFU8Y1SlZhiQQglS3U5gToXZPmdzdzrz35I1UMn90Id1tD1BXTFkgyOhUwcI0CNul8vdNhHdlWNHah1mZBrdRlZxkzwzoYYQ3ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714053997; c=relaxed/simple;
	bh=Q3g+6ofJpLBNf+HLKHawyQ42slgc2UN1G8OZfWSRq44=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BIQ2tx58GnN17cn8f7+n6Xk96kyVyw5Kf9g3tAWsplpDv/r07sbEAz/Rq8G9LZMEmTSAoiJvfOl+iG5RMkxJTohgQGDoYxnbZd9hiJGofdw1W/MYnLBFtjZM5A36/UpKZS/44BVZFaGxMko4XXrOgl8g1pNiZztZ5H3o69aolCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=JQjfvC9i; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com [209.85.218.69])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 037F040590
	for <bpf@vger.kernel.org>; Thu, 25 Apr 2024 14:06:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1714053994;
	bh=V1TI5VVR79l+ulg44q4XIVnhXI7V0A+GbqXJ3j0KGPU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
	b=JQjfvC9iI2dOSyyIrQwm5J4Mz5PHeS/YD+dpYqBJlWjNXNno0Xo4M528wG/aje/6i
	 RjZ6Ojn1PjwiFxr3parWxDvrXrpi3M8pHSIflBmbb/CGS/cG4wW09q9572FfRAZ7W0
	 jVs8z7dFyaG0n8ffY1U+BVCFzmVHXH9NIAVEh0RePhl/4BNKuZbyqyZDC++YbF9lMh
	 7kUy+MMzmhgnplOThVqP6434pWJZ/LmxK5iKjtM/A3OF6U5rFSqvUwRGxxHTizdkCj
	 x9RfyoguTU13ag9IJ8fNS75vSeUJuaMDzZ6h+K3jQ84IbEF46EhlkruZLOjGtjb/Vd
	 8Fi6XGrOzfKkA==
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-a5741ee352bso58760166b.1
        for <bpf@vger.kernel.org>; Thu, 25 Apr 2024 07:06:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714053993; x=1714658793;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V1TI5VVR79l+ulg44q4XIVnhXI7V0A+GbqXJ3j0KGPU=;
        b=hIx9Ea2kZaX+QKuKBk3nguDuKdPZfnha9AVsKjIQthb+g9AxQhlNqZii+joHfsMWnP
         P4wslkOOG8vc2IVGSVtFi13nw9CL3ySLn5YplGXfLbc2IQ8xdYyOwudWFDOhHMNiOJ+F
         sq31AwSSYSVGFyAUUd/Fde3O+Z7wszPzTanlc6+oxGGYKQyD6Qi4jsXUHc5v/oXA72fx
         Ar5ZKRiA/Rg2EMDuvqGx3dZvXJIIzb77EmXq0Cb74K57G4TOLt3kQeQ5nu4hqloX7etO
         sbUC2D5a5HqNjftNByvy3fqw+QXYdEpT/2Y/2dNsxfTj1AydlWSDTtuZ18MhfFzWb9/n
         Ghfg==
X-Forwarded-Encrypted: i=1; AJvYcCX9Zmyyk232XvqnmrHC8uB6oFYuLUwN5MVWwOvviYgBYAOKNlRQ6IkOyISehAU772+wjh65uxtPNpsThBU6LiAETKz8
X-Gm-Message-State: AOJu0YzHGkVlvBmFZ6FtKvAlebnxSSmzAl8Qddp+dA31dM3fqgyvhcoz
	Kv9nEPZIVE/hMDfQ68C59BDd2wadyh5jH7x0+E6T2fKJCBm4WM7OXxzXvKggQUzLNCPHGpqH8xE
	cS3LqiKX/Byq55fJSk4dHTNycl4QgISX9YXdlu1FQ5vVsWEi9Q8WpBbUi1RsP+Dk49w==
X-Received: by 2002:a17:906:3084:b0:a52:5baf:23d with SMTP id 4-20020a170906308400b00a525baf023dmr3962803ejv.15.1714053993258;
        Thu, 25 Apr 2024 07:06:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFa2f8PAzJ3OQlHx9WNBtlqYR5xi/NhF34vqLSqy387TGnWHhGna/SnTXOoR5J8Da7s5EM3Bw==
X-Received: by 2002:a17:906:3084:b0:a52:5baf:23d with SMTP id 4-20020a170906308400b00a525baf023dmr3962769ejv.15.1714053992668;
        Thu, 25 Apr 2024 07:06:32 -0700 (PDT)
Received: from localhost.localdomain (host-82-49-69-7.retail.telecomitalia.it. [82.49.69.7])
        by smtp.gmail.com with ESMTPSA id bi14-20020a170907368e00b00a5588ed8fa2sm8023018ejc.113.2024.04.25.07.06.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Apr 2024 07:06:32 -0700 (PDT)
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
	Jiri Olsa <jolsa@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Andrea Righi <andrea.righi@canonical.com>
Subject: [PATCH v3] selftests/bpf: Add ring_buffer__consume_n test.
Date: Thu, 25 Apr 2024 16:06:27 +0200
Message-ID: <20240425140627.112728-1-andrea.righi@canonical.com>
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
 .../selftests/bpf/prog_tests/ringbuf.c        | 64 +++++++++++++++++++
 .../selftests/bpf/progs/test_ringbuf_n.c      | 47 ++++++++++++++
 3 files changed, 112 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/bpf/progs/test_ringbuf_n.c

ChangeLog v2 -> v3:
 - move skel_n inside ringbuf_n_subtest()

ChangeLog v1 -> v2:
 - replace CHECK() with ASSERT_EQ()
 - fix skel -> skel_n
 - drop unused "seq" field from struct sample

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
index 48c5695b7abf..2f064d6952f0 100644
--- a/tools/testing/selftests/bpf/prog_tests/ringbuf.c
+++ b/tools/testing/selftests/bpf/prog_tests/ringbuf.c
@@ -13,6 +13,7 @@
 #include <linux/perf_event.h>
 #include <linux/ring_buffer.h>
 #include "test_ringbuf.lskel.h"
+#include "test_ringbuf_n.lskel.h"
 #include "test_ringbuf_map_key.lskel.h"
 
 #define EDONE 7777
@@ -326,6 +327,67 @@ static void ringbuf_subtest(void)
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
+	ASSERT_EQ(s->value, SAMPLE_VALUE, "sample_value");
+
+	return 0;
+}
+
+static void ringbuf_n_subtest(void)
+{
+	struct test_ringbuf_n_lskel *skel_n;
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
+	skel_n->bss->value = SAMPLE_VALUE;
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
@@ -384,6 +446,8 @@ void test_ringbuf(void)
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
index 000000000000..8669eb42dbe0
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_ringbuf_n.c
@@ -0,0 +1,47 @@
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
+	sample->value = value;
+	bpf_get_current_comm(sample->comm, sizeof(sample->comm));
+
+	bpf_ringbuf_submit(sample, 0);
+
+	return 0;
+}
-- 
2.43.0


