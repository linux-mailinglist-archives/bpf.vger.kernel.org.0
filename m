Return-Path: <bpf+bounces-29417-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5170E8C1BC3
	for <lists+bpf@lfdr.de>; Fri, 10 May 2024 02:38:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D2FAA1F2149D
	for <lists+bpf@lfdr.de>; Fri, 10 May 2024 00:38:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C56E1535D9;
	Fri, 10 May 2024 00:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DZtpqP+D"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1EF2537F8
	for <bpf@vger.kernel.org>; Fri, 10 May 2024 00:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715300993; cv=none; b=KQ8E/ZJVlByI4puuVqLj6Hl+8y/qox00H38kvRO76ht45vPHiBnBCDPo0McER09wIQgjPZtwyX/bnYNdPCxmiJyO0g66/QVYFiLxshIzZzY0w0rVdknl1u9yhpYsXTQJbEiHFTSo7488xIo70uzYtQYXDid+dvMElnXELCXB4i8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715300993; c=relaxed/simple;
	bh=0moVWm5H0/PxkymYi1Wkc4v/Yc9p3AxXBq0vFZgiFh0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hGPfX55N01K7s4xqmHJBwtkZIsq/3CmqTXxoQdajE5HQc+Ha8GUJRx2FwrKHodmAn8vli/MZUrA+mnz+q++enOqHBBcYJh4xK8aS5a3oI2H20o0MzxjjsV/vGhVo35Eo0nrR/xV86hI27O4xylORl/1JYJ3WwDqgrwtFh5YIjnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DZtpqP+D; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-3c9996178faso24988b6e.2
        for <bpf@vger.kernel.org>; Thu, 09 May 2024 17:29:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715300990; x=1715905790; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WzaF0DPOk0k2y1diONsO/hU9U1jewZi8cQG8L4Jq9yg=;
        b=DZtpqP+DuBUXZDElkp7gpbTpTgK0FrkGookETQ3BKGSHFCWFULXF5SKi+ToLS/ZlMa
         FMcbP2Ngwt09XhgMFbBO0ngATe6kDigDmy4puoM9qkx+AVvClANfV7oEVhIsL/nLDOHs
         dz4ZgtYDljT2AjE1br42VALUIbPIaWesJSdboUinb6UoNECUgL+r1pxAmCu72go+Ej9x
         yY9GYwuCeni47YkiJDa6yTB0lZOteVhh3vRl9gnWqqfIphR5NWW5Dhq7Udo9tCYsgjH6
         oIq6qAdx4yUzEfzlpMhEy0d2kuovpo4BLFQpTdiMl6/L6JbRLKhAl5rii9BiUynclm6b
         tqKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715300990; x=1715905790;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WzaF0DPOk0k2y1diONsO/hU9U1jewZi8cQG8L4Jq9yg=;
        b=YMTUQflaJGIWfZVQ6GIIuXwLjFt86mp6CpcqS4GzD0MrNT6IEjpx8voQwMMX5xlHtK
         b7Vvjc/OU1Way4kYvaeCJJ65lceOkHqiBmo/Uhp/pNUIK18JxWAmywIBur/H6P+uzsWd
         kTlIlOslXUTQY1ibw0mdLyiIU3yK+DucWvl5Rr6mPEW7zmtIcEhTUwBgjoVnuP8GgTSP
         o+ilrzL0TwjrapLuel4mk7A9PIssSoWhw3j8fhbWmG+U7kY+kPq7Kscgf7Yy6h7l/xaz
         KwbNPlKWhltL1HTvaVRKe+8HmIr3tajGXO2Lv/liMeFFqQmJotwiNh4GZWY2EJMiXXAw
         KufA==
X-Gm-Message-State: AOJu0Yw+PUhLySB07icfw7CdFVQgHEvWd00xshLnorGNHFltylWK+sWC
	MV74i/YjhRU6yl7L7PtPsKLWUEPepK4cIZaQ0LxqmIWCdeUECvwotlFeOA==
X-Google-Smtp-Source: AGHT+IFOiDFx5bZ2ExrirjLtVVnEzaaI4xc/wqXfEtv3Ji+5mEXbqZN1gBRbOYYEOmIGhplBTo2QYQ==
X-Received: by 2002:a05:6808:5d4:b0:3c7:4fd4:ae76 with SMTP id 5614622812f47-3c9970367d4mr1378033b6e.10.1715300990595;
        Thu, 09 May 2024 17:29:50 -0700 (PDT)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:66fe:82c7:2d03:7176])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3c98fc7e00bsm433251b6e.4.2024.05.09.17.29.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 May 2024 17:29:50 -0700 (PDT)
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
Subject: [PATCH bpf-next v3 5/7] selftests/bpf: test struct_ops with epoll
Date: Thu,  9 May 2024 17:29:40 -0700
Message-Id: <20240510002942.1253354-6-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240510002942.1253354-1-thinker.li@gmail.com>
References: <20240510002942.1253354-1-thinker.li@gmail.com>
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


