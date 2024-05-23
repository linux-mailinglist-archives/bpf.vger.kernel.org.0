Return-Path: <bpf+bounces-30443-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CB7DA8CDD24
	for <lists+bpf@lfdr.de>; Fri, 24 May 2024 01:09:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 41D231F2145B
	for <lists+bpf@lfdr.de>; Thu, 23 May 2024 23:09:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78740128828;
	Thu, 23 May 2024 23:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aA8AId6f"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77843128377
	for <bpf@vger.kernel.org>; Thu, 23 May 2024 23:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716505743; cv=none; b=C6BTLPf764DlzSY5y3XezbRKe8/l9QxOryUAG5qjV0f92WgPBoTQZrSebRgBh6AwKtTyCLCByAWVuuK7Uc7QYbMrRfzGdsu6gJkqVLzMSmslTGlFMm5mM62D5FcIcEDiz6ATYEWmQ1MMnY2oODojAV2j0YRT7974bxchJF8mhDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716505743; c=relaxed/simple;
	bh=0moVWm5H0/PxkymYi1Wkc4v/Yc9p3AxXBq0vFZgiFh0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EdOaMOkv2HiPGffFfkxlo8Kkn5RY/pV9Ly6ItCmPeUvQYJPl61nDAg0TrLwgmHKpxHs37gUiuBJoRQYWCFk0wxJ3WH1QF3oiiq3HGIck7vrBZAhJoDXEO1QUDiVlwhFu1Qo6Lorr82Eu2MAollnbROz4PwzCL5u+DYxG/2miRQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aA8AId6f; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-62a08270b46so3298427b3.1
        for <bpf@vger.kernel.org>; Thu, 23 May 2024 16:09:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716505740; x=1717110540; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WzaF0DPOk0k2y1diONsO/hU9U1jewZi8cQG8L4Jq9yg=;
        b=aA8AId6fFXnCGxoFV/eI5Tv1UbQY8z8cKua8FreGCA2c2YmEfeauvUi78c+AMpQV8N
         O/iCBTOkKfaTGfqN4jw/WxJ2z8r3K0PJEJZLhpW3Zk70/grnropVwuYpVFXMLS/o9fbu
         BCpFjxkoCxJbLLg3uzdevJVTtx9GWlQtdLnz5MBFGmqu2E/h7OKNxcFaQ2yZwUFJ3CDz
         ofIbzHNupKQKHXJdGuZ6BC1DK9dLUcGWZDQZwpqUZk2fruoikMS3sI3jTOF/7ZJixmRR
         B47MgqxBz2IwgHs6MBwIp06pa5xGwAjvephAvahDGMtkvu0dU1l3yZffKpMR30181Xr+
         3YXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716505740; x=1717110540;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WzaF0DPOk0k2y1diONsO/hU9U1jewZi8cQG8L4Jq9yg=;
        b=aW5n1pu8iLkUvQ5n7Vd7bEXL8vU41rFnw7+DS4iBQn5NV2lDvD2URp9MWFkSBYaPzj
         L8JkKP9B9XZ5aqdmg85XQl6THBTlYxd/U7GWFS5SHaS3zSMGk1yi16p7h67y/+nmjeqV
         +QpidXWNnn5GMhdccvPg60Vz5d8/dShdenFYu+F9wr5OakomwSskUkbOpGjwNy+U7NJk
         Daoq7/13xyvhiWPw+Zzbkpg+J01q3mJhV3BlUFq1Po7XCX+OmvezxAJSMklg6qb/0G/T
         fAOMIZzvrQ3m1OPhY7cUHSCOFRxUCL81vDkgU6DjBSHX/W7HMXGPuYTLI4l7DGjtV92U
         7biw==
X-Gm-Message-State: AOJu0YxvXnGnWiuQUDDqYDoqxUtsQFO6Re6rIXDBIE4qJK+2ld13BMfZ
	GbADSxpWThW8f/d5A6B8Q0A6vYywnPAqhySje1hY87LYMSsGNevDFiB64w==
X-Google-Smtp-Source: AGHT+IF5jbunHcaIlHq0U3DlFOFkc5XM4vOrtMm8nX9OAfKVPgoHu6WNGmy4q/7f5+hnvdL1u6HHuQ==
X-Received: by 2002:a05:690c:fcb:b0:61a:cc3c:ae69 with SMTP id 00721157ae682-62a08da023dmr6827027b3.18.1716505738322;
        Thu, 23 May 2024 16:08:58 -0700 (PDT)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:b7f1:1457:70d4:ab6c])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-62a0a37d5d0sm474087b3.16.2024.05.23.16.08.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 May 2024 16:08:57 -0700 (PDT)
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
Subject: [PATCH bpf-next v5 5/8] selftests/bpf: test struct_ops with epoll
Date: Thu, 23 May 2024 16:08:45 -0700
Message-Id: <20240523230848.2022072-6-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240523230848.2022072-1-thinker.li@gmail.com>
References: <20240523230848.2022072-1-thinker.li@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Verify whether a user space program is informed through epoll with EPOLLHUP
when a struct_ops object is detached.

The BPF code in selftests/bpf/progs/struct_ops_module.c has become
complex. Therefore, struct_ops_detach.c has been added to segregate the BPF
code for detachment tests from the BPF code for other tests based on the
recommendation of Andrii Nakryiko.

Suggested-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
---
 .../bpf/prog_tests/test_struct_ops_module.c   | 57 +++++++++++++++++++
 .../selftests/bpf/progs/struct_ops_detach.c   |  9 +++
 2 files changed, 66 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_detach.c

diff --git a/tools/testing/selftests/bpf/prog_tests/test_struct_ops_module.c b/tools/testing/selftests/bpf/prog_tests/test_struct_ops_module.c
index 29e183a80f49..bbcf12696a6b 100644
--- a/tools/testing/selftests/bpf/prog_tests/test_struct_ops_module.c
+++ b/tools/testing/selftests/bpf/prog_tests/test_struct_ops_module.c
@@ -3,9 +3,12 @@
 #include <test_progs.h>
 #include <time.h>
 
+#include <sys/epoll.h>
+
 #include "struct_ops_module.skel.h"
 #include "struct_ops_nulled_out_cb.skel.h"
 #include "struct_ops_forgotten_cb.skel.h"
+#include "struct_ops_detach.skel.h"
 
 static void check_map_info(struct bpf_map_info *info)
 {
@@ -242,6 +245,58 @@ static void test_struct_ops_forgotten_cb(void)
 	struct_ops_forgotten_cb__destroy(skel);
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
+	if (epollfd >= 0)
+		close(epollfd);
+	bpf_link__destroy(link);
+	struct_ops_detach__destroy(skel);
+}
+
 void serial_test_struct_ops_module(void)
 {
 	if (test__start_subtest("struct_ops_load"))
@@ -254,5 +309,7 @@ void serial_test_struct_ops_module(void)
 		test_struct_ops_nulled_out_cb();
 	if (test__start_subtest("struct_ops_forgotten_cb"))
 		test_struct_ops_forgotten_cb();
+	if (test__start_subtest("test_detach_link"))
+		test_detach_link();
 }
 
diff --git a/tools/testing/selftests/bpf/progs/struct_ops_detach.c b/tools/testing/selftests/bpf/progs/struct_ops_detach.c
new file mode 100644
index 000000000000..45eacc2ca657
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/struct_ops_detach.c
@@ -0,0 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2024 Meta Platforms, Inc. and affiliates. */
+#include <vmlinux.h>
+#include "../bpf_testmod/bpf_testmod.h"
+
+char _license[] SEC("license") = "GPL";
+
+SEC(".struct_ops.link")
+struct bpf_testmod_ops testmod_do_detach;
-- 
2.34.1


