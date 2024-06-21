Return-Path: <bpf+bounces-32728-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4E94912746
	for <lists+bpf@lfdr.de>; Fri, 21 Jun 2024 16:08:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98A48286F51
	for <lists+bpf@lfdr.de>; Fri, 21 Jun 2024 14:08:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CB7712E5E;
	Fri, 21 Jun 2024 14:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="X4yjkdh5"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C8AFCA7A
	for <bpf@vger.kernel.org>; Fri, 21 Jun 2024 14:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718978915; cv=none; b=d4JB3AD9zH4N8Evud2DFM3t/pknaXaEBMJAy0iNvXZWpVipErxuWIK93joqJxjVx834swsDqQGT35VZmRkKSITaHq9NjJOOMDkAIARbXt5wGEjwx1t3MWS9SNQi5pKVRAlIDw5mpHoKlfLQ8WQgivhAJ3bXvPkCKJW2UzttzWV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718978915; c=relaxed/simple;
	bh=L7LYq+RCHqHAajibZP85M83zg24Zh7yb4lJEdUPL5Jk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SQAIVwy6yqDr/kd8414PeAeFNBp7XO1QgW3g1sc4j4/PYd4V5F8rDOy264mGOboyxGL+KdSqlpABaqNGoQtRa8LCfLxMWUxEkukOZrtg547n0Bd+QTbwsH802efzfP86lQ9MtYeoqmIKWwTZf5eigK+NtoHQoG99oUYo9pagFxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=X4yjkdh5; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=DQYTXVA8LP+pzPoqHq13D2fjuADOxAw5sfLs2pkWYJ8=; b=X4yjkdh5cQn54hfkcbo1Qc9Rzj
	UA9f9LCJ7C1nNXXujHqx3Fv9amO5e6MaNu40H08BU0aUp5QAVHekY0DYQ/XDt58Om+Ne/uYMkbTOo
	AjY3K4r6kRysHgDuJgZolTTTKJLT68QXZ3RS6jmQPnQdztKoosuwLaeI4GUNZgYHxFxAg8EjwkUZM
	A+arKSBcMGviAK52zJKYu/m1RUJjjWhlCx41UhU/d/1Ea0edos6vNKKxSxP0cDwPhh1IU2EZmpqCz
	UbPBJdS+8TNuYOzH89gQR4M4ZfRh9CU8+5cw9ljEFfIzWf3CyZ/TMeEspaE1y+WVXDJBDzgnWDmuJ
	4+1RGexg==;
Received: from 18.248.197.178.dynamic.cust.swisscom.net ([178.197.248.18] helo=localhost)
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1sKewI-000CiX-E8; Fri, 21 Jun 2024 16:08:30 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: ast@kernel.org
Cc: bpf@vger.kernel.org,
	Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH bpf v3 2/2] selftests/bpf: Add more ring buffer test coverage
Date: Fri, 21 Jun 2024 16:08:28 +0200
Message-Id: <20240621140828.18238-2-daniel@iogearbox.net>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20240621140828.18238-1-daniel@iogearbox.net>
References: <20240621140828.18238-1-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27313/Fri Jun 21 10:28:08 2024)

Add test coverage for reservations beyond the ring buffer size in order
to validate that bpf_ringbuf_reserve() rejects the request with NULL, all
other ring buffer tests keep passing as well:

  # ./vmtest.sh -- ./test_progs -t ringbuf
  [...]
  ./test_progs -t ringbuf
  [    1.165434] bpf_testmod: loading out-of-tree module taints kernel.
  [    1.165825] bpf_testmod: module verification failed: signature and/or required key missing - tainting kernel
  [    1.284001] tsc: Refined TSC clocksource calibration: 3407.982 MHz
  [    1.286871] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x311fc34e357, max_idle_ns: 440795379773 ns
  [    1.289555] clocksource: Switched to clocksource tsc
  #274/1   ringbuf/ringbuf:OK
  #274/2   ringbuf/ringbuf_n:OK
  #274/3   ringbuf/ringbuf_map_key:OK
  #274/4   ringbuf/ringbuf_write:OK
  #274     ringbuf:OK
  #275     ringbuf_multi:OK
  [...]

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
 v1 -> v2:
   - Remove old-style CHECK asserts
 v2 -> v3:
   - Add missing munmap

 tools/testing/selftests/bpf/Makefile          |  2 +-
 .../selftests/bpf/prog_tests/ringbuf.c        | 46 +++++++++++++++++++
 .../selftests/bpf/progs/test_ringbuf_write.c  | 42 +++++++++++++++++
 3 files changed, 89 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/bpf/progs/test_ringbuf_write.c

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 96c0af323341..037d2e0502ef 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -457,7 +457,7 @@ LINKED_SKELS := test_static_linked.skel.h linked_funcs.skel.h		\
 LSKELS := fentry_test.c fexit_test.c fexit_sleep.c atomics.c 		\
 	trace_printk.c trace_vprintk.c map_ptr_kern.c 			\
 	core_kern.c core_kern_overflow.c test_ringbuf.c			\
-	test_ringbuf_n.c test_ringbuf_map_key.c
+	test_ringbuf_n.c test_ringbuf_map_key.c test_ringbuf_write.c
 
 # Generate both light skeleton and libbpf skeleton for these
 LSKELS_EXTRA := test_ksyms_module.c test_ksyms_weak.c kfunc_call_test.c \
diff --git a/tools/testing/selftests/bpf/prog_tests/ringbuf.c b/tools/testing/selftests/bpf/prog_tests/ringbuf.c
index 4c6f42dae409..40fd60215353 100644
--- a/tools/testing/selftests/bpf/prog_tests/ringbuf.c
+++ b/tools/testing/selftests/bpf/prog_tests/ringbuf.c
@@ -12,9 +12,11 @@
 #include <sys/sysinfo.h>
 #include <linux/perf_event.h>
 #include <linux/ring_buffer.h>
+
 #include "test_ringbuf.lskel.h"
 #include "test_ringbuf_n.lskel.h"
 #include "test_ringbuf_map_key.lskel.h"
+#include "test_ringbuf_write.lskel.h"
 
 #define EDONE 7777
 
@@ -84,6 +86,48 @@ static void *poll_thread(void *input)
 	return (void *)(long)ring_buffer__poll(ringbuf, timeout);
 }
 
+static void ringbuf_write_subtest(void)
+{
+	struct test_ringbuf_write_lskel *skel;
+	int page_size = getpagesize();
+	size_t *mmap_ptr;
+	int err, rb_fd;
+
+	skel = test_ringbuf_write_lskel__open();
+	if (!ASSERT_OK_PTR(skel, "skel_load"))
+		return;
+
+	skel->maps.ringbuf.max_entries = 0x4000;
+
+	err = test_ringbuf_write_lskel__load(skel);
+	if (!ASSERT_OK(err, "ringbuf_write"))
+		goto cleanup;
+
+	rb_fd = skel->maps.ringbuf.map_fd;
+
+	mmap_ptr = mmap(NULL, page_size, PROT_READ | PROT_WRITE, MAP_SHARED, rb_fd, 0);
+	ASSERT_OK_PTR(mmap_ptr, "rw_cons_pos");
+	*mmap_ptr = 0x3000;
+	ASSERT_OK(munmap(mmap_ptr, page_size), "unmap_rw");
+
+	skel->bss->pid = getpid();
+
+	ringbuf = ring_buffer__new(rb_fd, process_sample, NULL, NULL);
+	if (!ASSERT_OK_PTR(ringbuf, "ringbuf_create"))
+		goto cleanup;
+
+	err = test_ringbuf_write_lskel__attach(skel);
+	if (!ASSERT_OK(err, "ringbuf_write"))
+		goto cleanup;
+
+	trigger_samples();
+	ASSERT_GE(skel->bss->discarded, 1, "discarded");
+	ASSERT_EQ(skel->bss->passed, 0, "passed");
+cleanup:
+	ring_buffer__free(ringbuf);
+	test_ringbuf_write_lskel__destroy(skel);
+}
+
 static void ringbuf_subtest(void)
 {
 	const size_t rec_sz = BPF_RINGBUF_HDR_SZ + sizeof(struct sample);
@@ -451,4 +495,6 @@ void test_ringbuf(void)
 		ringbuf_n_subtest();
 	if (test__start_subtest("ringbuf_map_key"))
 		ringbuf_map_key_subtest();
+	if (test__start_subtest("ringbuf_write"))
+		ringbuf_write_subtest();
 }
diff --git a/tools/testing/selftests/bpf/progs/test_ringbuf_write.c b/tools/testing/selftests/bpf/progs/test_ringbuf_write.c
new file mode 100644
index 000000000000..c6c67238a7c8
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_ringbuf_write.c
@@ -0,0 +1,42 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
+
+char _license[] SEC("license") = "GPL";
+
+struct {
+	__uint(type, BPF_MAP_TYPE_RINGBUF);
+} ringbuf SEC(".maps");
+
+long discarded, passed;
+int pid;
+
+SEC("fentry/" SYS_PREFIX "sys_getpgid")
+int test_ringbuf_write(void *ctx)
+{
+	int *foo, cur_pid = bpf_get_current_pid_tgid() >> 32;
+	void *sample1, *sample2;
+
+	if (cur_pid != pid)
+		return 0;
+
+	sample1 = bpf_ringbuf_reserve(&ringbuf, 0x3000, 0);
+	if (!sample1)
+		return 0;
+	/* first one can pass */
+	sample2 = bpf_ringbuf_reserve(&ringbuf, 0x3000, 0);
+	if (!sample2) {
+		bpf_ringbuf_discard(sample1, 0);
+		__sync_fetch_and_add(&discarded, 1);
+		return 0;
+	}
+	/* second one must not */
+	__sync_fetch_and_add(&passed, 1);
+	foo = sample2 + 4084;
+	*foo = 256;
+	bpf_ringbuf_discard(sample1, 0);
+	bpf_ringbuf_discard(sample2, 0);
+	return 0;
+}
-- 
2.43.0


