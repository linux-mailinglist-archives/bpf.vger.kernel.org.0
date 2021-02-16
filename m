Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA4D831C945
	for <lists+bpf@lfdr.de>; Tue, 16 Feb 2021 12:03:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230223AbhBPLCp (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 16 Feb 2021 06:02:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230139AbhBPLAk (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 16 Feb 2021 06:00:40 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B26E8C06121C
        for <bpf@vger.kernel.org>; Tue, 16 Feb 2021 02:58:23 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id l12so12412023wry.2
        for <bpf@vger.kernel.org>; Tue, 16 Feb 2021 02:58:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0cxlavmTIp/zACJRiVyk8HpP0iu1cIzGXAbVh/+DaW8=;
        b=psWWGXhZG0sX29DCrH5g7znf9h/J9mzSMMEUHll4znSBD2SIgJQg5dnfGiy5AubW15
         o8x5arIpflHOq2dOaIZoKMUJITZucX0rPHpJ4IXAyiEuVtPnyqUCfPZs4THHNVCe1aga
         ci3YzzLJXC+o3XwovwZ5iL9Pla+em8PzguanY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0cxlavmTIp/zACJRiVyk8HpP0iu1cIzGXAbVh/+DaW8=;
        b=JIVav+XlodlIGCpWU9MNcX3z6jBEJ3Jy2Ceb+3CYBM4ut0qYddGUuOLwP8t331ppX7
         jmsBdJN1/LkfPRjbMo8m32ADQcLseiBoHcCcb8Wh/yQKegaJ0zq1zHjEue0bUEq/U0JM
         tcM3oYjwxDDpBl0Hph/7JuTj2gc52nuEtmatMqo/FiJRKaYjS9lu3y4RGyIMgriMDnzr
         jqdDipBK2sHIkNSgHaUvhDe5icO1NS8OZ9Ibv/7WdGjz4bG4lHia1covuhv/5vOrvdzR
         +bVnv9rFSu2wun5p9REocaC7PksA8lavw/QuXcDseTvzUuoYX0AwGAAqeO+P299wxHuD
         vURw==
X-Gm-Message-State: AOAM530xUugCVGRMox5S7Wvp3LHNCOfj9d2qa6ytxDDUn7V3x1UnSsw4
        Tf5bqNELUmed5T8TThgMYmwgjg==
X-Google-Smtp-Source: ABdhPJwuZq/E2OsTx9xBGvIw9iUNdaB4ReccTUzvSxX4rEcvZuFONO/HooyK552+zygq5WnUiBCqng==
X-Received: by 2002:adf:bb54:: with SMTP id x20mr23823050wrg.112.1613473102467;
        Tue, 16 Feb 2021 02:58:22 -0800 (PST)
Received: from antares.lan (111.253.187.81.in-addr.arpa. [81.187.253.111])
        by smtp.gmail.com with ESMTPSA id l1sm2820238wmi.48.2021.02.16.02.58.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Feb 2021 02:58:22 -0800 (PST)
From:   Lorenz Bauer <lmb@cloudflare.com>
To:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        jakub@cloudflare.com
Cc:     kernel-team@cloudflare.com, bpf@vger.kernel.org,
        netdev@vger.kernel.org, Lorenz Bauer <lmb@cloudflare.com>
Subject: [PATCH bpf-next 8/8] selftests: bpf: check that PROG_TEST_RUN repeats as requested
Date:   Tue, 16 Feb 2021 10:57:13 +0000
Message-Id: <20210216105713.45052-9-lmb@cloudflare.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210216105713.45052-1-lmb@cloudflare.com>
References: <20210216105713.45052-1-lmb@cloudflare.com>
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

