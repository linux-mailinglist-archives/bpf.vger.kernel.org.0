Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8632143DE0C
	for <lists+bpf@lfdr.de>; Thu, 28 Oct 2021 11:48:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230144AbhJ1Ju6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 28 Oct 2021 05:50:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230175AbhJ1Juw (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 28 Oct 2021 05:50:52 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A0FBC0613B9
        for <bpf@vger.kernel.org>; Thu, 28 Oct 2021 02:48:25 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 67-20020a1c1946000000b0030d4c90fa87so4557913wmz.2
        for <bpf@vger.kernel.org>; Thu, 28 Oct 2021 02:48:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wPEEI/42En9uKSJ0rR6svxJibQPpLgl3/xd+Q1CAzs4=;
        b=ZaAreBeSojAVPrdAUspWmFMN01Pw9vpD9iNJLz69uRDTgfjNojHGm4jITuhKRBxEeZ
         jCEFnusSdYFQG1mz7NV801OW+4Xau5zhrUxj4gPK0kVknJrsg+mxY/eDuE3T6VLLKhby
         SO8kKacYT8u+LlES/iknuTHDgSWkt4ogyHPDE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wPEEI/42En9uKSJ0rR6svxJibQPpLgl3/xd+Q1CAzs4=;
        b=B+5Mv50L5sZ21o7T/NjT3kFwcgnVzI+YeKQsUMHQSg06psplg/vbT5H8u3NyEkABBS
         XHFoIcU3tEkA0WAf+7gWJNQNgWKPclwR0mhUHFOdR9//KYqQzTbcQvBlGzpA+K+nhiFU
         j4jkK2QZNL8rjWW8HY9awlPgazUaKdA6JA+tRHEqHhGaTKFsSeH7YLMc5E7cHRJ22XEL
         NRFAyTQpb4Vi0YhRrvqh+bmqdXtBHICHlo+9S8HCmQWQ6gNc/iMgccxp6AFZxNbMVHBH
         K5EVNOi2lzn75alhMkYvmqgS6u9K9lH2AlTy6deMv7lL6d3TwE+OPmo2D59M5qRER7Yj
         eg7Q==
X-Gm-Message-State: AOAM532xkqar29ukC4n7m+e6XggSlwPVN1qMesp5N4MuLMXz2kmsEHaT
        yROuGMWToppOb49TW+wZcC5vEg==
X-Google-Smtp-Source: ABdhPJx6yn8XpE55PL/NDDyWj0wiSNcnZKApHrqoLEGCBiHaSDslHVx/ymfDR2GLyqJZ/7SX0JBR4A==
X-Received: by 2002:a1c:f319:: with SMTP id q25mr3310603wmq.33.1635414503789;
        Thu, 28 Oct 2021 02:48:23 -0700 (PDT)
Received: from altair.lan (2.f.6.6.b.3.3.0.3.a.d.b.6.0.6.0.f.f.6.2.a.5.a.7.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:7a5a:26ff:606:bda3:33b:66f2])
        by smtp.googlemail.com with ESMTPSA id i6sm3378029wry.71.2021.10.28.02.48.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Oct 2021 02:48:23 -0700 (PDT)
From:   Lorenz Bauer <lmb@cloudflare.com>
To:     viro@zeniv.linux.org.uk, Shuah Khan <shuah@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     mszeredi@redhat.com, gregkh@linuxfoundation.org,
        Lorenz Bauer <lmb@cloudflare.com>,
        linux-kselftest@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v3 4/4] selftests: bpf: test RENAME_EXCHANGE and RENAME_NOREPLACE on bpffs
Date:   Thu, 28 Oct 2021 10:47:24 +0100
Message-Id: <20211028094724.59043-5-lmb@cloudflare.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211028094724.59043-1-lmb@cloudflare.com>
References: <20211028094724.59043-1-lmb@cloudflare.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add tests to exercise the behaviour of RENAME_EXCHANGE and RENAME_NOREPLACE
on bpffs. The former checks that after an exchange the inode of two
directories has changed. The latter checks that the source still exists
after a failed rename.

Signed-off-by: Lorenz Bauer <lmb@cloudflare.com>
---
 .../selftests/bpf/prog_tests/test_bpffs.c     | 65 ++++++++++++++++++-
 1 file changed, 64 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/test_bpffs.c b/tools/testing/selftests/bpf/prog_tests/test_bpffs.c
index 533e3f3a459a..d29ebfeef9c5 100644
--- a/tools/testing/selftests/bpf/prog_tests/test_bpffs.c
+++ b/tools/testing/selftests/bpf/prog_tests/test_bpffs.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright (c) 2020 Facebook */
 #define _GNU_SOURCE
+#include <stdio.h>
 #include <sched.h>
 #include <sys/mount.h>
 #include <sys/stat.h>
@@ -29,7 +30,8 @@ static int read_iter(char *file)
 
 static int fn(void)
 {
-	int err;
+	struct stat a, b, c;
+	int err, map;
 
 	err = unshare(CLONE_NEWNS);
 	if (!ASSERT_OK(err, "unshare"))
@@ -67,6 +69,67 @@ static int fn(void)
 	err = read_iter(TDIR "/fs2/progs.debug");
 	if (!ASSERT_OK(err, "reading " TDIR "/fs2/progs.debug"))
 		goto out;
+
+	err = mkdir(TDIR "/fs1/a", 0777);
+	if (!ASSERT_OK(err, "creating " TDIR "/fs1/a"))
+		goto out;
+	err = mkdir(TDIR "/fs1/a/1", 0777);
+	if (!ASSERT_OK(err, "creating " TDIR "/fs1/a/1"))
+		goto out;
+	err = mkdir(TDIR "/fs1/b", 0777);
+	if (!ASSERT_OK(err, "creating " TDIR "/fs1/b"))
+		goto out;
+
+	map = bpf_create_map(BPF_MAP_TYPE_ARRAY, 4, 4, 1, 0);
+	if (!ASSERT_GT(map, 0, "create_map(ARRAY)"))
+		goto out;
+	err = bpf_obj_pin(map, TDIR "/fs1/c");
+	if (!ASSERT_OK(err, "pin map"))
+		goto out;
+	close(map);
+
+	/* Check that RENAME_EXCHANGE works for directories. */
+	err = stat(TDIR "/fs1/a", &a);
+	if (!ASSERT_OK(err, "stat(" TDIR "/fs1/a)"))
+		goto out;
+	err = renameat2(0, TDIR "/fs1/a", 0, TDIR "/fs1/b", RENAME_EXCHANGE);
+	if (!ASSERT_OK(err, "renameat2(/fs1/a, /fs1/b, RENAME_EXCHANGE)"))
+		goto out;
+	err = stat(TDIR "/fs1/b", &b);
+	if (!ASSERT_OK(err, "stat(" TDIR "/fs1/b)"))
+		goto out;
+	if (!ASSERT_EQ(a.st_ino, b.st_ino, "b should have a's inode"))
+		goto out;
+	err = access(TDIR "/fs1/b/1", F_OK);
+	if (!ASSERT_OK(err, "access(" TDIR "/fs1/b/1)"))
+		goto out;
+
+	/* Check that RENAME_EXCHANGE works for mixed file types. */
+	err = stat(TDIR "/fs1/c", &c);
+	if (!ASSERT_OK(err, "stat(" TDIR "/fs1/map)"))
+		goto out;
+	err = renameat2(0, TDIR "/fs1/c", 0, TDIR "/fs1/b", RENAME_EXCHANGE);
+	if (!ASSERT_OK(err, "renameat2(/fs1/c, /fs1/b, RENAME_EXCHANGE)"))
+		goto out;
+	err = stat(TDIR "/fs1/b", &b);
+	if (!ASSERT_OK(err, "stat(" TDIR "/fs1/b)"))
+		goto out;
+	if (!ASSERT_EQ(c.st_ino, b.st_ino, "b should have c's inode"))
+		goto out;
+	err = access(TDIR "/fs1/c/1", F_OK);
+	if (!ASSERT_OK(err, "access(" TDIR "/fs1/c/1)"))
+		goto out;
+
+	/* Check that RENAME_NOREPLACE works. */
+	err = renameat2(0, TDIR "/fs1/b", 0, TDIR "/fs1/a", RENAME_NOREPLACE);
+	if (!ASSERT_ERR(err, "renameat2(RENAME_NOREPLACE)")) {
+		err = -EINVAL;
+		goto out;
+	}
+	err = access(TDIR "/fs1/b", F_OK);
+	if (!ASSERT_OK(err, "access(" TDIR "/fs1/b)"))
+		goto out;
+
 out:
 	umount(TDIR "/fs1");
 	umount(TDIR "/fs2");
-- 
2.32.0

