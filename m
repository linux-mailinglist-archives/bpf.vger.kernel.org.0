Return-Path: <bpf+bounces-28762-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E3E418BDAE9
	for <lists+bpf@lfdr.de>; Tue,  7 May 2024 07:56:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 73A8C1F21C08
	for <lists+bpf@lfdr.de>; Tue,  7 May 2024 05:56:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 046F76E613;
	Tue,  7 May 2024 05:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U0A30WY9"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EAF76CDC2
	for <bpf@vger.kernel.org>; Tue,  7 May 2024 05:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715061379; cv=none; b=TRbM1QgbBtriVngRO/GWDjJp8uLzpTMJepDKlWOxiSuys93x946aDaal0vZx3O1T3zfPE/NPNq2XmRUhwGJJ25mpYtz3EmKZJYAA5lWBJR2NAmYPYFXuJM85QS0gh7d1vKEuivmltxu2T5VgQ5YXuaIpS9IzTuwiS82/d5weS1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715061379; c=relaxed/simple;
	bh=i2I8DLeyGNfUX4yYt4rgQ8tn4yJjH6icPbJ/Y5yGxyE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZJokI0q8f1kartWAUqL1mfF7dtvxixl47A3KFRyKg8qihE+NYO7A7nDLJQQ4qjEKNX9Uc4wK1PWbLmIuu5TjlAyp16fLX+51Vr2GlR/IAfWE9Nb4MKeGMLhxGqCc8Xi+Uk1cMOy5BOkgTn5OGoJdVJPNaI2WK56LgEiVwfgpV64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U0A30WY9; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-6eb86b69e65so1709780a34.3
        for <bpf@vger.kernel.org>; Mon, 06 May 2024 22:56:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715061376; x=1715666176; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MGAa9uCzEmcTsMh8N8SEx76nhZ7H6AlOyI9aIHDOpoA=;
        b=U0A30WY9JroI6z36QBLbbllM76cAkKWeQeU6T8WWQ+E0xU3vYM5/zNh3cMdwFA9h2l
         J1+3DhAmt/vjISuPUDJPweoVrxiu+1Zh0O9/cCNjnokUp8YPTJyQjW9x/cM5yj+v2Ro6
         WpfBGfm+OgVpU9uCijuAz9UoWpMzCp3GXhZ11J5CWGHXpZ+N/GtClVEJDBHhSBy1SHpz
         3rVDVkyoXYo62CL7OlawJIJTG70P2XMHfC3/U9zZsj9imYEEflDvT0XSSjRALyKz3Pm6
         XMJx8o1VLPXf2ETwkc6SlXGDEgwfGoDUxerf09noWHi/n3Or7/eDuZ+UwzDAJFs7nHxn
         Rpkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715061376; x=1715666176;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MGAa9uCzEmcTsMh8N8SEx76nhZ7H6AlOyI9aIHDOpoA=;
        b=ZtUzcNGlP+C/1LGc8b9RULF8PZxBkSBmCDtK1vi28DKQYKKYCr5kItuCnF7oJYFFHW
         LxZ9RiJj0sPvqx6NtuuNm6ugZZqGZBw/KNnHJ2h2SD3jVLj5hTRPZHNsziu6cwVX4BII
         qN/+P/+ppWeaB/+M+DGHUpNHwsoWNY6iaJDtdn4v2/3RLt1OIM2GcqLPp855K9satVqq
         ZV9QgwHoMT4pA42YNznStCtA8kO+D2JBnd0FhtSU0Z3/AIUJjHNJTJ4ZVSLC6L8ZlLMu
         PdBD4YeTZIHvT20wItx0ahq13WfaSt11JxfKZMsd7SeJRAkogej8Cn72Uh3540XD5Cwu
         dZNQ==
X-Gm-Message-State: AOJu0YzhAwJjf6Af17LgxrkFg84ICcGlEyp/yK/q1J2FXsh+r+Pet4iU
	iM966qGJoRI+Q+no9WVrGlBYSE3t1843fixoNTSxarYYNO2yu8E81NjUAg==
X-Google-Smtp-Source: AGHT+IHJTTO5N6IdiuyKzqjwxz/c6dyoREvwbB9KqAiBVYMbLY+Vq+urEbY4w5QEUhAjQl9N/DvqVA==
X-Received: by 2002:a9d:6494:0:b0:6ee:ead5:25c with SMTP id g20-20020a9d6494000000b006eeead5025cmr14400712otl.1.1715061376592;
        Mon, 06 May 2024 22:56:16 -0700 (PDT)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:2e7d:922e:d30d:e503])
        by smtp.gmail.com with ESMTPSA id eo8-20020a0568200f0800b005a586b0906esm2317011oob.26.2024.05.06.22.56.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 May 2024 22:56:16 -0700 (PDT)
From: Kui-Feng Lee <thinker.li@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	kernel-team@meta.com,
	andrii@kernel.org
Cc: sinquersw@gmail.com,
	kuifeng@meta.com,
	Kui-Feng Lee <thinker.li@gmail.com>
Subject: [PATCH bpf-next v2 4/6] selftests/bpf: test struct_ops with epoll
Date: Mon,  6 May 2024 22:55:58 -0700
Message-Id: <20240507055600.2382627-5-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240507055600.2382627-1-thinker.li@gmail.com>
References: <20240507055600.2382627-1-thinker.li@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Verify whether a user space program is informed through epoll with EPOLLHUP
when a struct_ops object is detached.

Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
---
 .../selftests/bpf/bpf_testmod/bpf_testmod.c   | 13 +++++
 .../bpf/bpf_testmod/bpf_testmod_kfunc.h       |  1 +
 .../bpf/prog_tests/test_struct_ops_module.c   | 57 +++++++++++++++++++
 .../selftests/bpf/progs/struct_ops_detach.c   | 31 ++++++++++
 4 files changed, 102 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_detach.c

diff --git a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
index e24a18bfee14..c89a6414c69f 100644
--- a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
+++ b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
@@ -10,6 +10,7 @@
 #include <linux/percpu-defs.h>
 #include <linux/sysfs.h>
 #include <linux/tracepoint.h>
+#include <linux/workqueue.h>
 #include "bpf_testmod.h"
 #include "bpf_testmod_kfunc.h"
 
@@ -498,6 +499,9 @@ __bpf_kfunc void bpf_kfunc_call_test_sleepable(void)
 {
 }
 
+static DEFINE_MUTEX(detach_mutex);
+static struct bpf_link *link_to_detach;
+
 BTF_KFUNCS_START(bpf_testmod_check_kfunc_ids)
 BTF_ID_FLAGS(func, bpf_testmod_test_mod_kfunc)
 BTF_ID_FLAGS(func, bpf_kfunc_call_test1)
@@ -577,11 +581,20 @@ static int bpf_dummy_reg(void *kdata, struct bpf_link *link)
 	if (ops->test_2)
 		ops->test_2(4, ops->data);
 
+	mutex_lock(&detach_mutex);
+	if (!link_to_detach)
+		link_to_detach = link;
+	mutex_unlock(&detach_mutex);
+
 	return 0;
 }
 
 static void bpf_dummy_unreg(void *kdata, struct bpf_link *link)
 {
+	mutex_lock(&detach_mutex);
+	if (link == link_to_detach)
+		link_to_detach = NULL;
+	mutex_unlock(&detach_mutex);
 }
 
 static int bpf_testmod_test_1(void)
diff --git a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod_kfunc.h b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod_kfunc.h
index ce5cd763561c..9f9b60880fd3 100644
--- a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod_kfunc.h
+++ b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod_kfunc.h
@@ -105,6 +105,7 @@ void bpf_kfunc_call_test_fail1(struct prog_test_fail1 *p);
 void bpf_kfunc_call_test_fail2(struct prog_test_fail2 *p);
 void bpf_kfunc_call_test_fail3(struct prog_test_fail3 *p);
 void bpf_kfunc_call_test_mem_len_fail1(void *mem, int len);
+int bpf_dummy_do_link_detach(void) __ksym;
 
 void bpf_kfunc_common_test(void) __ksym;
 #endif /* _BPF_TESTMOD_KFUNC_H */
diff --git a/tools/testing/selftests/bpf/prog_tests/test_struct_ops_module.c b/tools/testing/selftests/bpf/prog_tests/test_struct_ops_module.c
index bd39586abd5a..f39455b81664 100644
--- a/tools/testing/selftests/bpf/prog_tests/test_struct_ops_module.c
+++ b/tools/testing/selftests/bpf/prog_tests/test_struct_ops_module.c
@@ -2,8 +2,12 @@
 /* Copyright (c) 2024 Meta Platforms, Inc. and affiliates. */
 #include <test_progs.h>
 #include <time.h>
+#include <network_helpers.h>
+
+#include <sys/epoll.h>
 
 #include "struct_ops_module.skel.h"
+#include "struct_ops_detach.skel.h"
 
 static void check_map_info(struct bpf_map_info *info)
 {
@@ -174,6 +178,57 @@ static void test_struct_ops_incompatible(void)
 	struct_ops_module__destroy(skel);
 }
 
+/* Detach a link from a user space program */
+static void test_detach_link(void)
+{
+	struct epoll_event ev, events[2];
+	struct struct_ops_detach *skel;
+	struct bpf_link *link = NULL;
+	int fd, epollfd = -1, nfds;
+	int err;
+
+	skel = struct_ops_detach__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "struct_ops_detach__open_and_load"))
+		return;
+
+	link = bpf_map__attach_struct_ops(skel->maps.testmod_do_detach);
+	if (!ASSERT_OK_PTR(link, "attach_struct_ops"))
+		goto cleanup;
+
+	fd = bpf_link__fd(link);
+	if (!ASSERT_GE(fd, 0, "link_fd"))
+		goto cleanup;
+
+	epollfd = epoll_create1(0);
+	if (!ASSERT_GE(epollfd, 0, "epoll_create1"))
+		goto cleanup;
+
+	ev.events = EPOLLHUP;
+	ev.data.fd = fd;
+	err = epoll_ctl(epollfd, EPOLL_CTL_ADD, fd, &ev);
+	if (!ASSERT_OK(err, "epoll_ctl"))
+		goto cleanup;
+
+	err = bpf_link__detach(link);
+	if (!ASSERT_OK(err, "detach_link"))
+		goto cleanup;
+
+	/* Wait for EPOLLHUP */
+	nfds = epoll_wait(epollfd, events, 2, 500);
+	if (!ASSERT_EQ(nfds, 1, "epoll_wait"))
+		goto cleanup;
+
+	if (!ASSERT_EQ(events[0].data.fd, fd, "epoll_wait_fd"))
+		goto cleanup;
+	if (!ASSERT_TRUE(events[0].events & EPOLLHUP, "events[0].events"))
+		goto cleanup;
+
+cleanup:
+	close(epollfd);
+	bpf_link__destroy(link);
+	struct_ops_detach__destroy(skel);
+}
+
 void serial_test_struct_ops_module(void)
 {
 	if (test__start_subtest("test_struct_ops_load"))
@@ -182,5 +237,7 @@ void serial_test_struct_ops_module(void)
 		test_struct_ops_not_zeroed();
 	if (test__start_subtest("test_struct_ops_incompatible"))
 		test_struct_ops_incompatible();
+	if (test__start_subtest("test_detach_link"))
+		test_detach_link();
 }
 
diff --git a/tools/testing/selftests/bpf/progs/struct_ops_detach.c b/tools/testing/selftests/bpf/progs/struct_ops_detach.c
new file mode 100644
index 000000000000..aeb355b3bea3
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/struct_ops_detach.c
@@ -0,0 +1,31 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2024 Meta Platforms, Inc. and affiliates. */
+#include <vmlinux.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+#include "../bpf_testmod/bpf_testmod.h"
+#include "../bpf_testmod/bpf_testmod_kfunc.h"
+
+char _license[] SEC("license") = "GPL";
+
+int test_1_result = 0;
+int test_2_result = 0;
+
+SEC("struct_ops/test_1")
+int BPF_PROG(test_1)
+{
+	test_1_result = 0xdeadbeef;
+	return 0;
+}
+
+SEC("struct_ops/test_2")
+void BPF_PROG(test_2, int a, int b)
+{
+	test_2_result = a + b;
+}
+
+SEC(".struct_ops.link")
+struct bpf_testmod_ops testmod_do_detach = {
+	.test_1 = (void *)test_1,
+	.test_2 = (void *)test_2,
+};
-- 
2.34.1


