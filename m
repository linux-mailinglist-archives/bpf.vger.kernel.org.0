Return-Path: <bpf+bounces-29696-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E6F08C5615
	for <lists+bpf@lfdr.de>; Tue, 14 May 2024 14:41:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8294B1C21B0B
	for <lists+bpf@lfdr.de>; Tue, 14 May 2024 12:41:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1198D66B5E;
	Tue, 14 May 2024 12:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wledx+Yt"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18BDA43AD7
	for <bpf@vger.kernel.org>; Tue, 14 May 2024 12:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715690477; cv=none; b=UATu8oIkijQyXd7P/y81T+UDH+FOPT8fgF3EV4iGmLUqdHDvkcTQYDRAJxmom2D9ktba2MesxzWY9wr/qS/RLrnIMeMLPAQCyo1ydYdCawCK32dsQ81FvhS9j/oaKu3CkxXr9QAc/7Y3XNH+23RHDjfsHgaR0vq4QJI7n+LMuV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715690477; c=relaxed/simple;
	bh=LXk9vGYxJ2HMLw3PlOf9J9kzrLl4kiMKmQh4jjke1Wo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gH2qlEQrRLAdCp6WIXGgzdoOr/kuZb9VvwRx5GMNj7Om8JRnSNLHKmN9wPl79OWmqfwLjR//13CteXL32A8itjYEmYKEr5CF/Tq2T1TiyVO7q8LCLejtKpbj6PvcM9NJolO+MZtE7Ln/eGeNvz1EpZoFLnzU2vtzGtD4RAyRc60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wledx+Yt; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-43dfcbc4893so23789591cf.2
        for <bpf@vger.kernel.org>; Tue, 14 May 2024 05:41:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715690475; x=1716295275; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vfBX3qYgAOjfCsX6fTPqh2Aq3GMM/4CBu0M8ANvpTKc=;
        b=Wledx+YtRqQTRa2DkjqI+C8VmuU3+QzuoQ2E3yDbFMZNYmMuKSbhzKIyGUIqJhXh5z
         SBRBig2R8hCvQcQjkDY1gGdDUmn43QJdfAQwJQpCRz5kp7J34bOB/n06pj1+gaYhdB9J
         eEi1xi4xOliAVCpuXirFaBAqSAHM0DfmM9HOahFPCJsKNe7DwrCiVAXgpovc3Riw4Rof
         FSF46ZfW88DZqGgsNj50wUd6esuOJmoTmyQMQDTdh5FOj3Fi57zPcE7+ucoh6RZPrP5h
         YqoYzWxtCbJvjLjYpImkCuqB5E/MGoicXrWg44Ixv07rPTDqYStvvOhSKzEPGBiqbgJU
         SBCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715690475; x=1716295275;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vfBX3qYgAOjfCsX6fTPqh2Aq3GMM/4CBu0M8ANvpTKc=;
        b=hfBnTBtxnaSacoM0SsUlIrAxzKb4K1IbU7+qa8HZtVOGHxig5Pf29aU02vDjfQus9+
         YRsCLMNXBDTk7ARyHOqF8mzugw+5sJjK9EF0sMZf1n1D7ejlkgpxIr0A1LTVnw0gviEi
         s6+i0JRE8HSnPWqPOUrRk6bm0aQrwaZd59j9Tx1Bcrzgyw6V5T1AnPtn69SK5wMd7Ri8
         8jbP3SqCS0VCL7sG3jvqpM7kg53OuqyLGYTxHkb7991wJhrsOAaIK0uote4ZcbXw8plM
         JQ1KFqm7bNWj5IXeoIpr0mW+4CHNRI1CE6sEMeDHgolxZ32xYTkxubnjBqSf49DvdnzT
         1hjg==
X-Gm-Message-State: AOJu0Yz2F+F9foVLr9Dp2f8g6dgtRAUfnPR4OcoMHQLPmQxGNijtmS0v
	3ML+UbrkhQtqug0xHIcgegL3UmGsEyuvt4R78g5pAKV8KG7ltv79fIqQsg==
X-Google-Smtp-Source: AGHT+IHZNZWueCqSTDzwDB8MpmUNtcIveXWdbCuj1S3mznfhhZBqDhPaJZWv6kQYOwk/9gTv3dVsJw==
X-Received: by 2002:a05:622a:105:b0:43a:cbe9:2e32 with SMTP id d75a77b69052e-43dfdd57d93mr143179861cf.55.1715690474795;
        Tue, 14 May 2024 05:41:14 -0700 (PDT)
Received: from fedora.. ([2607:b400:30:a100:6442:5b0e:54ab:110b])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-43e12f41a0asm31923981cf.48.2024.05.14.05.41.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 May 2024 05:41:14 -0700 (PDT)
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
Subject: [PATCH v3 bpf-next 2/2] selftests/bpf: Added selftests to check deadlocks in queue and stack map
Date: Tue, 14 May 2024 08:40:51 -0400
Message-ID: <20240514124052.1240266-1-sidchintamaneni@gmail.com>
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
 .../prog_tests/test_queue_stack_nested_map.c  |  69 +++++++++++
 .../bpf/progs/test_queue_stack_nested_map.c   | 116 ++++++++++++++++++
 2 files changed, 185 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/test_queue_stack_nested_map.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_queue_stack_nested_map.c

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


