Return-Path: <bpf+bounces-30176-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE3848CB630
	for <lists+bpf@lfdr.de>; Wed, 22 May 2024 00:53:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E294C1C21A77
	for <lists+bpf@lfdr.de>; Tue, 21 May 2024 22:53:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A54D6149C40;
	Tue, 21 May 2024 22:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RNY5WKH5"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD4E13DB89
	for <bpf@vger.kernel.org>; Tue, 21 May 2024 22:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716331990; cv=none; b=WeLkWWVYhrXdyEYm6Z85wb54tfwXkU1wf3vOMXDcyYksRHGZax1nrL8EJOGowV+9h/S51JFxz1DuG4207zmu4GQIMBWRDp1fnWgnhcJjif7pOIOCCGiLNg3qfWhrcvOHUm+KxTSercM8p6H+t03G5jzJQA71adi+VXxPEw4XuwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716331990; c=relaxed/simple;
	bh=0moVWm5H0/PxkymYi1Wkc4v/Yc9p3AxXBq0vFZgiFh0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RRdYhBPOAga6n1XNMQtGo2DWZOfobesb5fWqWnM8PlGRgsive4g5nUvYWZVAoET7c+DbTbZyVKOsORlhGussQoql+YsWywim0nGAYI55beJD97uwG91MgyzOI2QMrayM306iKGW9rBRlPa339QVE5p1sNk82zk4wO9tA8Jaftv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RNY5WKH5; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-df475159042so3688215276.1
        for <bpf@vger.kernel.org>; Tue, 21 May 2024 15:53:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716331987; x=1716936787; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WzaF0DPOk0k2y1diONsO/hU9U1jewZi8cQG8L4Jq9yg=;
        b=RNY5WKH5g+Fkj0nBFC2eISp9Pt/4P/2e9FgRtVabB/41hMZ5B5BhqpfpOry6x/EJGh
         FgJLs6XFcwWb95jEOdU+xufwdvE+kNNdQmgnHma3AZLoVoKD85alVZ2hSlB7M8+a7yFe
         gOyfFZi7BTc2BO1m9qIzGlj7OH9YMZe+m1rkzsSTI5FzY1I6cWPSGDeLkLOGxfwqMNJK
         qcvhxp1TpGI2jc2zCklQ9NWYlb3u4aml3tnYhFWwV02W/RvOjK0BDm7AAP08ZNhKMilf
         PrkmFopqubtqYdhSa7Z2MedjVhVJEHn6HB8tt6d2cH1ZoYh9FL94jkYeoE24Lj2HB4rd
         emPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716331987; x=1716936787;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WzaF0DPOk0k2y1diONsO/hU9U1jewZi8cQG8L4Jq9yg=;
        b=GzG6J09E9fyc9x1LwLIZ+8H5lavYrZ+3TZFyruR+Pjmfec4fiJJFG5Ccv71Hsw/G6I
         YOnTQaqyKPGIyqs65ddehcIiAgpssHGjHesJW9J9txlBPPe0KFdpNjtXbRnDX2YS8MbG
         pHl9NlfNViF6a5PllUBLCedaE9dcWVA1G3V5qe+TFXiIaF2aZrZxNOIVQf0iiyC9S1nV
         Jo4CbnJdP98pW2LGAonqXhe4rL13h/60jQsMoq1+Rx2f6mGnEVjuRc/8hqaxs08nXX3q
         0WB0D4do3mLEcoGe2SimLGNt2SAk5TejntlOvZnXIe3++WZXxkUUJWdPylxcrTfmFc7+
         Ylkg==
X-Gm-Message-State: AOJu0YwAKjYdDMjL57jIeu+aitfdhnm+eWsleo37UWZ5SwDRFBF5wnRc
	6M6tywP4tP2DhfXDVM+ZpkrlI36oK8veOTe/5gHNkST6kB/B9AsDisE9lQ==
X-Google-Smtp-Source: AGHT+IH52BZVgM3CFeX62JGOjES9NfTSwcUJ+Wnb6793zKObFVbHDLPbMm4g8gkYGDZn/DaVA9mnAg==
X-Received: by 2002:a25:d3c4:0:b0:dcd:df0:e672 with SMTP id 3f1490d57ef6-df4e0d9bb11mr463869276.47.1716331987343;
        Tue, 21 May 2024 15:53:07 -0700 (PDT)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:1437:59a6:29be:9221])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-debd385be51sm5584956276.54.2024.05.21.15.53.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 May 2024 15:53:06 -0700 (PDT)
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
Subject: [PATCH bpf-next v4 5/7] selftests/bpf: test struct_ops with epoll
Date: Tue, 21 May 2024 15:51:19 -0700
Message-Id: <20240521225121.770930-6-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240521225121.770930-1-thinker.li@gmail.com>
References: <20240521225121.770930-1-thinker.li@gmail.com>
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


