Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DFC0F134B72
	for <lists+bpf@lfdr.de>; Wed,  8 Jan 2020 20:21:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728437AbgAHTVg (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 8 Jan 2020 14:21:36 -0500
Received: from mail-qt1-f202.google.com ([209.85.160.202]:34919 "EHLO
        mail-qt1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727191AbgAHTVg (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 8 Jan 2020 14:21:36 -0500
Received: by mail-qt1-f202.google.com with SMTP id m30so2677310qtb.2
        for <bpf@vger.kernel.org>; Wed, 08 Jan 2020 11:21:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=Ju/AO1IRJPsMivaKOL4EhPXQ6aA0ulflVKiBGBofhrQ=;
        b=g1G7Qbdbiuu2ZTQDhrVhtetFi5kxAQ6ieTHoAX6vA1jvNfQXe51yWgSNra4KSf9CAp
         GB6OQLTcHAQmL3Smm+6FIGVTZyFr9HtIVYaAFutHkzyJx5FSQJHuTPLUqU1ocb3Qzqnb
         xdpljD6r0RAE3iP2UALQtHbWRZnC/Al44n7d9yKlNhVSl5XEeAG66eJo1tjc7s2S3y4I
         4R5vJ5DLb0xzRFoCL2i51gD5ZZuIm0aDep9Qi8gMlazBDpRE5G0hmOefb/TjbsptX1C8
         8hYYypEo31FRIOv7hemRb/hvUIKAqyhg++BdI3QZ4hlIu7dp/5igE7jn7Org1GMRJLd3
         aeiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=Ju/AO1IRJPsMivaKOL4EhPXQ6aA0ulflVKiBGBofhrQ=;
        b=Mn1p2SLbtEcMA/JKO3J/RebMDBEacyGsFdTwlm171UC6PehGJQ0MaHiWy4pEEKttrk
         cVGH/7go4SqVJ7BVYOQ3jWASwDGQ1YY+WwvLVvPGfU3OXJnRZqYfqWrbELvs3UIprmal
         Wuf9L1+lj2TzsNaMrEROB9BIjj72S9udFYaa8/jU9da/xPIJ3Scbdw0zCu7we4veMHBD
         mbkWI2JVPctn0dbDw6Q+vfYMXKyTA1kRzR6Zdhgc/1CHNbxEVGP3Pzqwz6QiO0v0pi1r
         ZEAgaUXUPrF6NfXiGQjFM6GTwrWjcmST9nRz2JUkmrJ0HVdt3KilrnWnanPqXOABxnCZ
         gpiw==
X-Gm-Message-State: APjAAAVBXmVNC/8BanVrcM3J627JA9eXaBGh1hBK7plFKV0nCCsD9uFY
        GsYS585IC1irclpKYROahL/u71M=
X-Google-Smtp-Source: APXvYqzHwMr2tTJiuJPDn51u6hGLLuzKJWd5qvREys/bTKaKX2lcq5L++IenVjKJB2VeZKAWJQ6IzWM=
X-Received: by 2002:ac8:2f03:: with SMTP id j3mr4903197qta.180.1578511294969;
 Wed, 08 Jan 2020 11:21:34 -0800 (PST)
Date:   Wed,  8 Jan 2020 11:21:32 -0800
Message-Id: <20200108192132.189221-1-sdf@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.24.1.735.g03f4e72817-goog
Subject: [PATCH bpf-next] selftests/bpf: restore original comm in test_overhead
From:   Stanislav Fomichev <sdf@google.com>
To:     netdev@vger.kernel.org, bpf@vger.kernel.org
Cc:     davem@davemloft.net, ast@kernel.org, daniel@iogearbox.net,
        Stanislav Fomichev <sdf@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

test_overhead changes task comm in order to estimate BPF trampoline
overhead but never sets the comm back to the original one.
We have the tests (like core_reloc.c) that have 'test_progs'
as hard-coded expected comm, so let's try to preserve the
original comm.

Currently, everything works because the order of execution is:
first core_recloc, then test_overhead; but let's make it a bit
future-proof.

Other related changes: use 'test_overhead' as new comm instead of
'test' to make it easy to debug and drop '\n' at the end.

Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 tools/testing/selftests/bpf/prog_tests/test_overhead.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/test_overhead.c b/tools/testing/selftests/bpf/prog_tests/test_overhead.c
index c32aa28bd93f..465b371a561d 100644
--- a/tools/testing/selftests/bpf/prog_tests/test_overhead.c
+++ b/tools/testing/selftests/bpf/prog_tests/test_overhead.c
@@ -2,6 +2,7 @@
 /* Copyright (c) 2019 Facebook */
 #define _GNU_SOURCE
 #include <sched.h>
+#include <sys/prctl.h>
 #include <test_progs.h>
 
 #define MAX_CNT 100000
@@ -17,7 +18,7 @@ static __u64 time_get_ns(void)
 static int test_task_rename(const char *prog)
 {
 	int i, fd, duration = 0, err;
-	char buf[] = "test\n";
+	char buf[] = "test_overhead";
 	__u64 start_time;
 
 	fd = open("/proc/self/comm", O_WRONLY|O_TRUNC);
@@ -66,6 +67,10 @@ void test_test_overhead(void)
 	struct bpf_object *obj;
 	struct bpf_link *link;
 	int err, duration = 0;
+	char comm[16] = {};
+
+	if (CHECK_FAIL(prctl(PR_GET_NAME, comm, 0L, 0L, 0L)))
+		return;
 
 	obj = bpf_object__open_file("./test_overhead.o", NULL);
 	if (CHECK(IS_ERR(obj), "obj_open_file", "err %ld\n", PTR_ERR(obj)))
@@ -138,5 +143,6 @@ void test_test_overhead(void)
 	test_run("fexit");
 	bpf_link__destroy(link);
 cleanup:
+	prctl(PR_SET_NAME, comm, 0L, 0L, 0L);
 	bpf_object__close(obj);
 }
-- 
2.24.1.735.g03f4e72817-goog

