Return-Path: <bpf+bounces-29693-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0581F8C55F8
	for <lists+bpf@lfdr.de>; Tue, 14 May 2024 14:24:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6D41CB2110E
	for <lists+bpf@lfdr.de>; Tue, 14 May 2024 12:24:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C3C753E37;
	Tue, 14 May 2024 12:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FP8uviXK"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FA30DDC0
	for <bpf@vger.kernel.org>; Tue, 14 May 2024 12:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715689435; cv=none; b=EBz/zIbz7kf+KK34agc1syyPSk3+O5sJ5+u9U/lO7aWmHLNMJ3grKNmBBWvyzwQ0Uyh4DX5vcM6xbvHgmtE/e04YsG+Rt9PhtG0GNf8L6d5ogLvDBiREAQlVoxH7D8I6j4VS+nTPEjH68xGXrR7YoPBN2L1VHxVjsnMz33zpqmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715689435; c=relaxed/simple;
	bh=NDml+X0Q0Q1ym/XKHhKRFO91+hyquvu/T9mSRiZZvAg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sFeDGnFoZGn6FCzX4EgmQSBQ3qPUNaNaJPy27VbZRzXFses5/YNokwqqS57BM5rpEgeVQ7lJ0jAsmDnoAvdrvCGc/I25v1dL924oejd5Amh5vrax4BkbmTZtikA+le8w1VfzbULApDDo11M6zFFWkHMoZ7s28dFlm1DCi3MHGo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FP8uviXK; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-43df44ef2f9so35244531cf.1
        for <bpf@vger.kernel.org>; Tue, 14 May 2024 05:23:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715689433; x=1716294233; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/VP2qmNVvYKu7jaFSob2OgHGamWZNxeVPT1CsJCS9Rg=;
        b=FP8uviXKtE7rvGRIN1wIx6A1lqB9b8sMEG/eBKEX+1yfP27aUyYi6ULxwT0/Xt5Xfz
         7iXQDoYUfK5o9lxnOrD991KSOxidn7Pj5ik87+y+EBVWd+256+V/Cxn4J91i0wgy8dix
         tHacx5kx10U9PWjOqyQYmis05jJAGN21NZCS2NRUDUfUSZbGF4udzQSQUbjVhWA0SdjZ
         DP8KLHrpvuPEMN0VjGPifXVD1pMNBflF0orbFjOskmmTNAAPEIpbtZsh8bNDXKInSWW9
         30gptpKukT+cP2gNqbflNF30LCU5v6JisdXOc2MuCsDMTffpXSsoXHErME10IclOOXjf
         5DSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715689433; x=1716294233;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/VP2qmNVvYKu7jaFSob2OgHGamWZNxeVPT1CsJCS9Rg=;
        b=oOPcpz8YZmr0fW4herFFe32Hq0goUdkyyND3ZcPwj34DKszqSJzD6RIPDbOXVAUSss
         xP2phl9LyA6zVtvyXWTn2ujBv238NBouQZC0niqUuZgMdIR0iKuZDroxBWjtYSrCHQpA
         g9+mk8dajBniDWap+6VgnIr7llD17cSbqgilZyViyboJQAU7UrolyzqEf6L6eV2X0nry
         sbH2gcwFLtHx6gRvnE7++fYY/k8WXnMVq73ehdotBAHCz1BbODgeuM3U//cDqtw4SgWx
         D0RLUFqA44Bm0MsbhwYSY9RK818o8DsMp1Rnrw9N2eVqvD3FzAjDeolNH1gf3lFl//Dn
         JEcQ==
X-Gm-Message-State: AOJu0YzrO1XN9epWeF399gLsoP2t2+SvGyzxC54lMteEVQXsmSN5HtrK
	iXj8KpU+6Ec5CbakGd062se4nTd+E8EC+X/BewPu9NrZ9PYtkmwPXaFu2w==
X-Google-Smtp-Source: AGHT+IFwY7Tf73WUNHOwxE1ptIkIqpm+4Dv4mOFlAXoDSAhUsmFGHtbCjqKjukbMZgm42AdMDevARA==
X-Received: by 2002:a05:622a:15c1:b0:43a:74ea:89b with SMTP id d75a77b69052e-43dfdb4969cmr142018401cf.16.1715689433138;
        Tue, 14 May 2024 05:23:53 -0700 (PDT)
Received: from fedora.. ([2607:b400:30:a100:6442:5b0e:54ab:110b])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-43e25735ceesm11861811cf.11.2024.05.14.05.23.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 May 2024 05:23:52 -0700 (PDT)
From: Siddharth Chintamaneni <sidchintamaneni@gmail.com>
To: bpf@vger.kernel.org
Cc: alexei.starovoitov@gmail.com,
	daniel@iogearbox.net,
	olsajiri@gmail.com,
	andrii@kernel.org,
	yonghong.song@linux.dev,
	rjsu26@vt.edu,
	sairoop@vt.edu,
	miloc@vt.edu,
	memxor@gmail.com,
	Siddharth Chintamaneni <sidchintamaneni@gmail.com>
Subject: [PATCH v2 bpf-next 2/2] selftests/bpf: Added selftests to check deadlocks in queue and stack map
Date: Tue, 14 May 2024 08:23:36 -0400
Message-ID: <20240514122337.1239800-1-sidchintamaneni@gmail.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Added selftests to check for nested deadlocks in queue  and stack maps.

test_map_queue_stack_nesting_success:PASS:test_queue_stack_nested_map__open 0 nsec
test_map_queue_stack_nesting_success:PASS:test_queue_stack_nested_map__load 0 nsec
test_map_queue_stack_nesting_success:PASS:test_queue_stack_nested_map__attach 0 nsec
test_map_queue_stack_nesting_success:PASS:MAP Write 0 nsec
test_map_queue_stack_nesting_success:PASS:no map nesting 0 nsec
test_map_queue_stack_nesting_success:PASS:no map nesting 0 nsec
384/1   test_queue_stack_nested_map/map_queue_nesting:OK
test_map_queue_stack_nesting_success:PASS:test_queue_stack_nested_map__open 0 nsec
test_map_queue_stack_nesting_success:PASS:test_queue_stack_nested_map__load 0 nsec
test_map_queue_stack_nesting_success:PASS:test_queue_stack_nested_map__attach 0 nsec
test_map_queue_stack_nesting_success:PASS:MAP Write 0 nsec
test_map_queue_stack_nesting_success:PASS:no map nesting 0 nsec
384/2   test_queue_stack_nested_map/map_stack_nesting:OK
384     test_queue_stack_nested_map:OK
Summary: 1/2 PASSED, 0 SKIPPED, 0 FAILED

Signed-off-by: Siddharth Chintamaneni <sidchintamaneni@gmail.com>
---
 samples/bpf/Makefile                          |   3 +
 .../prog_tests/test_queue_stack_nested_map.c  |  69 +++++++++++
 .../bpf/progs/test_queue_stack_nested_map.c   | 116 ++++++++++++++++++
 3 files changed, 188 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/test_queue_stack_nested_map.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_queue_stack_nested_map.c

diff --git a/samples/bpf/Makefile b/samples/bpf/Makefile
index 9aa027b144df..9e1abf0e21ad 100644
--- a/samples/bpf/Makefile
+++ b/samples/bpf/Makefile
@@ -7,6 +7,7 @@ pound := \#
 
 # List of programs to build
 tprogs-y := test_lru_dist
+tprogs-y += sid_queue_stack
 tprogs-y += sock_example
 tprogs-y += fds_example
 tprogs-y += sockex1
@@ -98,6 +99,7 @@ ibumad-objs := ibumad_user.o
 hbm-objs := hbm.o $(CGROUP_HELPERS)
 
 xdp_router_ipv4-objs := xdp_router_ipv4_user.o $(XDP_SAMPLE)
+sid_queue_stack-objs := sid_queue_stack_user.o
 
 # Tell kbuild to always build the programs
 always-y := $(tprogs-y)
@@ -149,6 +151,7 @@ always-y += task_fd_query_kern.o
 always-y += ibumad_kern.o
 always-y += hbm_out_kern.o
 always-y += hbm_edt_kern.o
+always-y += sid_queue_stack_kern.o
 
 TPROGS_CFLAGS = $(TPROGS_USER_CFLAGS)
 TPROGS_LDFLAGS = $(TPROGS_USER_LDFLAGS)
diff --git a/tools/testing/selftests/bpf/prog_tests/test_queue_stack_nested_map.c b/tools/testing/selftests/bpf/prog_tests/test_queue_stack_nested_map.c
new file mode 100644
index 000000000000..fc46561788af
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/test_queue_stack_nested_map.c
@@ -0,0 +1,69 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <test_progs.h>
+#include <network_helpers.h>
+
+#include "test_queue_stack_nested_map.skel.h"
+
+
+static void test_map_queue_stack_nesting_success(bool is_map_queue)
+{
+	struct test_queue_stack_nested_map *skel;
+	int err;
+
+	skel = test_queue_stack_nested_map__open();
+	if (!ASSERT_OK_PTR(skel, "test_queue_stack_nested_map__open"))
+		return;
+
+	err = test_queue_stack_nested_map__load(skel);
+	if (!ASSERT_OK(err, "test_queue_stack_nested_map__load"))
+		goto out;
+
+	skel->bss->pid = getpid();
+	err = test_queue_stack_nested_map__attach(skel);
+	if (!ASSERT_OK(err, "test_queue_stack_nested_map__attach"))
+		goto out;
+
+	/* trigger map from userspace to check nesting */
+	int value = 0;
+
+	do {
+		if (is_map_queue) {
+			err = bpf_map_update_elem(bpf_map__fd(skel->maps.map_queue),
+								NULL, &value, 0);
+			if (err < 0)
+				break;
+			err = bpf_map_lookup_and_delete_elem(bpf_map__fd(skel->maps.map_queue),
+								 NULL, &value);
+		} else {
+			err = bpf_map_update_elem(bpf_map__fd(skel->maps.map_stack),
+								NULL, &value, 0);
+			if (err < 0)
+				break;
+			err = bpf_map_lookup_and_delete_elem(bpf_map__fd(skel->maps.map_stack),
+								NULL, &value);
+		}
+	} while (0);
+
+
+	if (!ASSERT_OK(err, "MAP Write"))
+		goto out;
+
+	if (is_map_queue) {
+		ASSERT_EQ(skel->bss->err_queue_push, -EBUSY, "no map nesting");
+		ASSERT_EQ(skel->bss->err_queue_pop, -EBUSY, "no map nesting");
+	} else {
+		ASSERT_EQ(skel->bss->err_stack, -EBUSY, "no map nesting");
+	}
+out:
+	test_queue_stack_nested_map__destroy(skel);
+}
+
+void test_test_queue_stack_nested_map(void)
+{
+	if (test__start_subtest("map_queue_nesting"))
+		test_map_queue_stack_nesting_success(true);
+	if (test__start_subtest("map_stack_nesting"))
+		test_map_queue_stack_nesting_success(false);
+
+}
+
diff --git a/tools/testing/selftests/bpf/progs/test_queue_stack_nested_map.c b/tools/testing/selftests/bpf/progs/test_queue_stack_nested_map.c
new file mode 100644
index 000000000000..893a37593206
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_queue_stack_nested_map.c
@@ -0,0 +1,116 @@
+// SPDX-License-Identifier: GPL-2.0
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+struct {
+	__uint(type, BPF_MAP_TYPE_STACK);
+	__uint(max_entries, 32);
+	__uint(key_size, 0);
+	__uint(value_size, sizeof(__u32));
+} map_stack SEC(".maps");
+
+struct {
+	__uint(type, BPF_MAP_TYPE_QUEUE);
+	__uint(max_entries, 32);
+	__uint(key_size, 0);
+	__uint(value_size, sizeof(__u32));
+} map_queue SEC(".maps");
+
+
+int err_queue_push;
+int err_queue_pop;
+int err_stack;
+int pid;
+__u32 trigger_flag_queue_push;
+__u32 trigger_flag_queue_pop;
+__u32 trigger_flag_stack;
+
+SEC("fentry/queue_stack_map_push_elem")
+int BPF_PROG(test_queue_stack_push_trigger, raw_spinlock_t *lock, unsigned long flags)
+{
+
+	if ((bpf_get_current_pid_tgid() >> 32) != pid)
+		return 0;
+
+
+	trigger_flag_queue_push = 1;
+
+	return 0;
+}
+
+SEC("fentry/queue_map_pop_elem")
+int BPF_PROG(test_queue_pop_trigger, raw_spinlock_t *lock, unsigned long flags)
+{
+
+	if ((bpf_get_current_pid_tgid() >> 32) != pid)
+		return 0;
+
+	trigger_flag_queue_pop = 1;
+
+	return 0;
+}
+
+
+SEC("fentry/stack_map_pop_elem")
+int BPF_PROG(test_stack_pop_trigger, raw_spinlock_t *lock, unsigned long flags)
+{
+
+	if ((bpf_get_current_pid_tgid() >> 32) != pid)
+		return 0;
+
+	trigger_flag_stack = 1;
+
+	return 0;
+}
+
+SEC("fentry/_raw_spin_unlock_irqrestore")
+int BPF_PROG(test_queue_pop_nesting, raw_spinlock_t *lock, unsigned long flags)
+{
+	__u32 val;
+
+	if ((bpf_get_current_pid_tgid() >> 32) != pid || trigger_flag_queue_pop != 1)
+		return 0;
+
+
+	err_queue_pop = bpf_map_pop_elem(&map_queue, &val);
+
+	trigger_flag_queue_pop = 0;
+
+	return 0;
+}
+
+SEC("fentry/_raw_spin_unlock_irqrestore")
+int BPF_PROG(test_stack_nesting, raw_spinlock_t *lock, unsigned long flags)
+{
+	__u32 val;
+
+	if ((bpf_get_current_pid_tgid() >> 32) != pid || trigger_flag_stack != 1)
+		return 0;
+
+
+	err_stack = bpf_map_pop_elem(&map_stack, &val);
+
+	trigger_flag_stack = 0;
+
+	return 0;
+}
+
+
+SEC("fentry/_raw_spin_unlock_irqrestore")
+int BPF_PROG(test_queue_push_nesting, raw_spinlock_t *lock, unsigned long flags)
+{
+	__u32 val = 1;
+
+	if ((bpf_get_current_pid_tgid() >> 32) != pid || trigger_flag_queue_push != 1) {
+		return 0;
+	}
+
+	err_queue_push = bpf_map_push_elem(&map_queue, &val, 0);
+
+	trigger_flag_queue_push = 0;
+
+	return 0;
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.44.0


