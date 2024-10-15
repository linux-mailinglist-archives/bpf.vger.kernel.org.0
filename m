Return-Path: <bpf+bounces-41908-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CB2299DADA
	for <lists+bpf@lfdr.de>; Tue, 15 Oct 2024 02:50:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40F8528300D
	for <lists+bpf@lfdr.de>; Tue, 15 Oct 2024 00:50:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6989649625;
	Tue, 15 Oct 2024 00:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="aknKwej1"
X-Original-To: bpf@vger.kernel.org
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54C7D433B9
	for <bpf@vger.kernel.org>; Tue, 15 Oct 2024 00:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728953444; cv=none; b=dmfA6IVre1shkvzns79Nb2fkG7xaHuQ+8MeTGZx5FloirLAMa1v9ZpTn0OCWN79NR37CkVZjpwlIAiG6G9mTqD57XfAfxE0+JQ5gOZTMttOBY48Os9G4dj2/jLtwa1eH/qz1ot9EJbtQ2a2MI2jJNU+iItfGXtp1f5XQY3M8IXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728953444; c=relaxed/simple;
	bh=IqG8elDJ1M3DcxAKy/Mq4tIICfQQeQ/RkryWOrCZDTU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WjuomcuZiOArHXdPgE+jYV7DtiJD6ESHhtp1yxfRx8oJPjESvwR5EUITEDgzszoFUIjUbLig1ys7UVZ+0XbOaHAZBKjQyN3GdjPpvI1mPmy/kf341aRetGVatYrkajb+8Arvb5VWKC0k5SPcfxfJW12ZjvSVnK+xRv1JuT3HvfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=aknKwej1; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1728953440;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JAGWdl0BorP87+LSwxIlzGu/6VkaEQ4WgDnn6hoAGic=;
	b=aknKwej1ccjBRDQZ3D6OPAwSCE1Qfi/ZurBLv3ajEPJwMtbcNRbJ/0nXZ5kfHUmpgPRq0Q
	zEsRVzKKAA75k/xWgJGIEjBaTcjntfL3W1ji9dqRVhwZKhUh6dK4FDFLfWmKJ93A4y7HX4
	w2TL0vw1qoUVI9qDL8uz+RZPLyZPgU0=
From: Martin KaFai Lau <martin.lau@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Kui-Feng Lee <thinker.li@gmail.com>,
	kernel-team@meta.com
Subject: [PATCH v5 bpf-next 09/12] selftests/bpf: Test a uptr struct spanning across pages.
Date: Mon, 14 Oct 2024 17:49:59 -0700
Message-ID: <20241015005008.767267-10-martin.lau@linux.dev>
In-Reply-To: <20241015005008.767267-1-martin.lau@linux.dev>
References: <20241015005008.767267-1-martin.lau@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Martin KaFai Lau <martin.lau@kernel.org>

This patch tests the case when uptr has a struct spanning across two
pages. It is not supported now and EOPNOTSUPP is expected from the
syscall update_elem.

Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
---
 .../bpf/prog_tests/task_local_storage.c       | 39 +++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/task_local_storage.c b/tools/testing/selftests/bpf/prog_tests/task_local_storage.c
index 4c8eadd1f083..9a081aaa26a3 100644
--- a/tools/testing/selftests/bpf/prog_tests/task_local_storage.c
+++ b/tools/testing/selftests/bpf/prog_tests/task_local_storage.c
@@ -8,6 +8,7 @@
 #include <sys/syscall.h>   /* For SYS_xxx definitions */
 #include <sys/types.h>
 #include <sys/eventfd.h>
+#include <sys/mman.h>
 #include <test_progs.h>
 #include "task_local_storage_helpers.h"
 #include "task_local_storage.skel.h"
@@ -367,6 +368,42 @@ static void test_uptr_basic(void)
 	close(parent_task_fd);
 }
 
+static void test_uptr_across_pages(void)
+{
+	int page_size = getpagesize();
+	struct value_type value = {};
+	struct task_ls_uptr *skel;
+	int err, task_fd, map_fd;
+	void *mem;
+
+	task_fd = sys_pidfd_open(getpid(), 0);
+	if (!ASSERT_OK_FD(task_fd, "task_fd"))
+		return;
+
+	mem = mmap(NULL, page_size * 2, PROT_READ | PROT_WRITE,
+		   MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+	if (!ASSERT_OK_PTR(mem, "mmap(page_size * 2)")) {
+		close(task_fd);
+		return;
+	}
+
+	skel = task_ls_uptr__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "skel_open_and_load"))
+		goto out;
+
+	map_fd = bpf_map__fd(skel->maps.datamap);
+	value.udata = mem + page_size - offsetof(struct user_data, b);
+	err = bpf_map_update_elem(map_fd, &task_fd, &value, 0);
+	if (!ASSERT_ERR(err, "update_elem(udata)"))
+		goto out;
+	ASSERT_EQ(errno, EOPNOTSUPP, "errno");
+
+out:
+	task_ls_uptr__destroy(skel);
+	close(task_fd);
+	munmap(mem, page_size * 2);
+}
+
 void test_task_local_storage(void)
 {
 	if (test__start_subtest("sys_enter_exit"))
@@ -379,4 +416,6 @@ void test_task_local_storage(void)
 		test_nodeadlock();
 	if (test__start_subtest("uptr_basic"))
 		test_uptr_basic();
+	if (test__start_subtest("uptr_across_pages"))
+		test_uptr_across_pages();
 }
-- 
2.43.5


