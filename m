Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5C28327BEF
	for <lists+bpf@lfdr.de>; Mon,  1 Mar 2021 11:24:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233393AbhCAKXQ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 1 Mar 2021 05:23:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233710AbhCAKVv (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 1 Mar 2021 05:21:51 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBFEEC061794
        for <bpf@vger.kernel.org>; Mon,  1 Mar 2021 02:19:29 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id e10so15258407wro.12
        for <bpf@vger.kernel.org>; Mon, 01 Mar 2021 02:19:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0cxlavmTIp/zACJRiVyk8HpP0iu1cIzGXAbVh/+DaW8=;
        b=cxdmnu8AkMrWe5Q7sfpX+33HEIPlQVJyzYl0Uxe7KifBNMeNmS5+6TzuP5G/JPrtE2
         x1PFTYgxVMXoT+WxEyfbXekqvXPTnw3T/0NXBtjuYi4oUB+psEdZ4sEazDq59HlDXd6i
         LfM4dGk9gocZ5uypbwToTIksnoCFy36ddfctc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0cxlavmTIp/zACJRiVyk8HpP0iu1cIzGXAbVh/+DaW8=;
        b=ESNd4RW0kUlwP0hHwp7W9PkqcUlDwP0EQ43AMdRCc9g+QEUImG5GTnOF7afEjgAbMk
         h+7b1apx2wOAUYUYcWQv5TyvtBJ6vRXx+vYynDsahTuEosXvZSpXt70BkI7MttQI5A/H
         9lX3M8UM9Sy1vAA/JAvis+sUToqi0Fgk/X0z92TLWZ2d0DUk73pbhI1tF6VRfbU2dDW/
         tGj9Omi6iUsbFVFaj4EMX69xWVVcIceE2JkigllVaNAq0Z/DJVlGMUaQg+0D82JP9Aqr
         cOwaiuGFttRn2g9qow5LglTTVwT3QxoLQL6zNjSkp502pWkOetw3cIKuTFVZw2avVq3/
         5x9A==
X-Gm-Message-State: AOAM533j791dj44HoVXWQAhm4Oog3Zel8O3xL1AA9tDQW+DH+MCn1GH0
        pnvZOs0+XKcJnXkxvfQjWiaHwA==
X-Google-Smtp-Source: ABdhPJxHUEsygIiKUxI/P+qUs2Hq37votbQ3u1YVyjHlNeSjFG7zoUZAr0VjT3SzB8dmmDYhd+LkCw==
X-Received: by 2002:a5d:638a:: with SMTP id p10mr16486501wru.286.1614593968707;
        Mon, 01 Mar 2021 02:19:28 -0800 (PST)
Received: from localhost.localdomain (2.b.a.d.8.4.b.a.9.e.4.2.1.8.0.5.f.f.6.2.a.5.a.7.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:7a5a:26ff:5081:24e9:ab48:dab2])
        by smtp.gmail.com with ESMTPSA id a198sm14134600wmd.11.2021.03.01.02.19.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Mar 2021 02:19:28 -0800 (PST)
From:   Lorenz Bauer <lmb@cloudflare.com>
To:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org
Cc:     kernel-team@cloudflare.com, netdev@vger.kernel.org,
        bpf@vger.kernel.org, Lorenz Bauer <lmb@cloudflare.com>
Subject: [PATCH bpf-next v3 4/5] selftests: bpf: check that PROG_TEST_RUN repeats as requested
Date:   Mon,  1 Mar 2021 10:18:58 +0000
Message-Id: <20210301101859.46045-5-lmb@cloudflare.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210301101859.46045-1-lmb@cloudflare.com>
References: <20210301101859.46045-1-lmb@cloudflare.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Extend a simple prog_run test to check that PROG_TEST_RUN adheres
to the requested repetitions. Convert it to use BPF skeleton.

Signed-off-by: Lorenz Bauer <lmb@cloudflare.com>
---
 .../selftests/bpf/prog_tests/prog_run_xattr.c | 51 +++++++++++++++----
 1 file changed, 42 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/prog_run_xattr.c b/tools/testing/selftests/bpf/prog_tests/prog_run_xattr.c
index 935a294f049a..131d7f7eeb42 100644
--- a/tools/testing/selftests/bpf/prog_tests/prog_run_xattr.c
+++ b/tools/testing/selftests/bpf/prog_tests/prog_run_xattr.c
@@ -2,12 +2,31 @@
 #include <test_progs.h>
 #include <network_helpers.h>
 
-void test_prog_run_xattr(void)
+#include "test_pkt_access.skel.h"
+
+static const __u32 duration;
+
+static void check_run_cnt(int prog_fd, __u64 run_cnt)
 {
-	const char *file = "./test_pkt_access.o";
-	struct bpf_object *obj;
-	char buf[10];
+	struct bpf_prog_info info = {};
+	__u32 info_len = sizeof(info);
 	int err;
+
+	err = bpf_obj_get_info_by_fd(prog_fd, &info, &info_len);
+	if (CHECK(err, "get_prog_info", "failed to get bpf_prog_info for fd %d\n", prog_fd))
+		return;
+
+	CHECK(run_cnt != info.run_cnt, "run_cnt",
+	      "incorrect number of repetitions, want %llu have %llu\n", run_cnt, info.run_cnt);
+}
+
+void test_prog_run_xattr(void)
+{
+	struct test_pkt_access *skel;
+	int err, stats_fd = -1;
+	char buf[10] = {};
+	__u64 run_cnt = 0;
+
 	struct bpf_prog_test_run_attr tattr = {
 		.repeat = 1,
 		.data_in = &pkt_v4,
@@ -16,12 +35,15 @@ void test_prog_run_xattr(void)
 		.data_size_out = 5,
 	};
 
-	err = bpf_prog_load(file, BPF_PROG_TYPE_SCHED_CLS, &obj,
-			    &tattr.prog_fd);
-	if (CHECK_ATTR(err, "load", "err %d errno %d\n", err, errno))
+	stats_fd = bpf_enable_stats(BPF_STATS_RUN_TIME);
+	if (CHECK_ATTR(stats_fd < 0, "enable_stats", "failed %d\n", errno))
 		return;
 
-	memset(buf, 0, sizeof(buf));
+	skel = test_pkt_access__open_and_load();
+	if (CHECK_ATTR(!skel, "open_and_load", "failed\n"))
+		goto cleanup;
+
+	tattr.prog_fd = bpf_program__fd(skel->progs.test_pkt_access);
 
 	err = bpf_prog_test_run_xattr(&tattr);
 	CHECK_ATTR(err != -1 || errno != ENOSPC || tattr.retval, "run",
@@ -34,8 +56,12 @@ void test_prog_run_xattr(void)
 	CHECK_ATTR(buf[5] != 0, "overflow",
 	      "BPF_PROG_TEST_RUN ignored size hint\n");
 
+	run_cnt += tattr.repeat;
+	check_run_cnt(tattr.prog_fd, run_cnt);
+
 	tattr.data_out = NULL;
 	tattr.data_size_out = 0;
+	tattr.repeat = 2;
 	errno = 0;
 
 	err = bpf_prog_test_run_xattr(&tattr);
@@ -46,5 +72,12 @@ void test_prog_run_xattr(void)
 	err = bpf_prog_test_run_xattr(&tattr);
 	CHECK_ATTR(err != -EINVAL, "run_wrong_size_out", "err %d\n", err);
 
-	bpf_object__close(obj);
+	run_cnt += tattr.repeat;
+	check_run_cnt(tattr.prog_fd, run_cnt);
+
+cleanup:
+	if (skel)
+		test_pkt_access__destroy(skel);
+	if (stats_fd != -1)
+		close(stats_fd);
 }
-- 
2.27.0

