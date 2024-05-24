Return-Path: <bpf+bounces-30542-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C2378CEC6B
	for <lists+bpf@lfdr.de>; Sat, 25 May 2024 00:30:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 418CC281191
	for <lists+bpf@lfdr.de>; Fri, 24 May 2024 22:30:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD343129E74;
	Fri, 24 May 2024 22:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QJ2eNs45"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF8AC1272C0
	for <bpf@vger.kernel.org>; Fri, 24 May 2024 22:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716589848; cv=none; b=orwAOYNmEbUYVZSlr2+uS+UDzTCrH2eph5pH/QnNTYDHobhMA2NmeejJu/eIc8ZsDcEcDvd1GMhTSHszxNcYrZPiTpRYkMvSCvQk9kfBG2EfGkSy1ZSb9J4wfVaum2LiQxPH3T8oUykzr4eX6LZ2qrjS20oJcnv7mAEH0g6tnhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716589848; c=relaxed/simple;
	bh=0moVWm5H0/PxkymYi1Wkc4v/Yc9p3AxXBq0vFZgiFh0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UizFSX8RjJDBk75+2rnYhm2XPUzANO386/7Z2Upw8jdIftUKFtHt7/hxGCKZUSBCd/x4As3Ycsb1UxQD5GUAvrnHhlG9D/MrtrX7PerU10dHL5+J3jQfDnd1rApVkiMtjhXenglPZmym1lIm648Tj1oW+F1a02EewnBOpfl7Yko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QJ2eNs45; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-62a08438b9aso13897657b3.3
        for <bpf@vger.kernel.org>; Fri, 24 May 2024 15:30:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716589845; x=1717194645; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WzaF0DPOk0k2y1diONsO/hU9U1jewZi8cQG8L4Jq9yg=;
        b=QJ2eNs45qe1QnVeu83gi8UkEwETnOXHsvI4pvUQxs37GyBP0DquLNGGaToFqqrUTB6
         cirlQhX6oKPzZu7VLcjALdZtrX7rb+X8plCFO6DjaECWGINIhHyUXFmyrcvQbrKIxRj+
         7An5P+HBFKjhwq9M3Nffpvc0WWpxCSIFiGSJiTpT2c+iGytzvOenTWZj3Y0qACncGgpS
         GhhLiXaQGZI0k6jInhYYsyp0UPj7nNB32kBRaCnHmAH56cyNSPYHHuWzcLt/+Bb8Emp+
         lCpOU0NZZACZXQT6do+cjV0WzcJI0A+4ojDpkzAbsszmnMSSnbvkUDllMOGHpxGelCK3
         YkIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716589845; x=1717194645;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WzaF0DPOk0k2y1diONsO/hU9U1jewZi8cQG8L4Jq9yg=;
        b=R3+zLQJBQyv4LECTBCpnTiHphVo/GLWc0VXJOkoMvkQ11+m4QmFmmdQaNo8JZFmMBH
         XxvbHgJ1pAEizBofbb1WpjwWT1hSE1y1SsIDEpqwKfi3ezdjn7LeDlpPXOeh8i8KoFYy
         WgJb8J1Owcuxqcuu0YWYib743QjTFkirbb/rluzdbHUF+iyVM3LAJVQ/Gpt+DCgB4+uT
         +YwL/2kNAoS8NW4sFrEdh7MmJ4S2rW5w/z9cWkhecmITgCp5OSqiOlryBovhBwnwFRJ6
         stx2vy8SCFlAF8U77UhZFUqMx2xPcu65dkaFMHizjRaimqYqPK6aJcGEi4uAqWHSbefz
         szyA==
X-Gm-Message-State: AOJu0YyN1cx5JU1JbApXIIqMHuGe9GeWmz+BJ3X5xA4hSCaNOMcAyMTm
	PCT5BRuWpVlnY7nLdjSs2Dbf2SI3Xq8eu2WBy/z1CjmIDvozLnIb+HF7DQ==
X-Google-Smtp-Source: AGHT+IHd+DZ5SmbSjmwv4vYpMyTzkzLTJ6PRnopG6gcfDWU3Ir/juikRj2x5DCbUnctsbSfpGSFt1g==
X-Received: by 2002:a81:af02:0:b0:61b:3356:d28c with SMTP id 00721157ae682-62a08d754d1mr34090457b3.2.1716589845511;
        Fri, 24 May 2024 15:30:45 -0700 (PDT)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:6aeb:e91b:f49d:e77d])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-62a0a3bfa19sm4169987b3.44.2024.05.24.15.30.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 May 2024 15:30:45 -0700 (PDT)
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
Subject: [PATCH bpf-next v6 5/8] selftests/bpf: test struct_ops with epoll
Date: Fri, 24 May 2024 15:30:33 -0700
Message-Id: <20240524223036.318800-6-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240524223036.318800-1-thinker.li@gmail.com>
References: <20240524223036.318800-1-thinker.li@gmail.com>
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


