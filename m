Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 240EA43DE08
	for <lists+bpf@lfdr.de>; Thu, 28 Oct 2021 11:48:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230189AbhJ1Ju4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 28 Oct 2021 05:50:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230135AbhJ1Juv (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 28 Oct 2021 05:50:51 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43A7BC061228
        for <bpf@vger.kernel.org>; Thu, 28 Oct 2021 02:48:24 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id z14so9090349wrg.6
        for <bpf@vger.kernel.org>; Thu, 28 Oct 2021 02:48:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=r3QcDl+qrCs7DfRcj3nDkgEldBtCcz4guF3zRxr4yw0=;
        b=V1tUt0C+yOFlv1l6b4PrP7zPJM4iHTVUGYIiH5UnTUEaG0AniQhwCxz1BJDgWfiTOr
         UWi1hgVhvCQQv+5lrpnBpaoMDmriNh1Q342XoCjlM/oJg/9lolw1gbl7XDwAeJrHzO2K
         ujDlfcvNKS6rSwtYQGaw7+zuEOlPJGPxpyYPo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=r3QcDl+qrCs7DfRcj3nDkgEldBtCcz4guF3zRxr4yw0=;
        b=L2dEMoPl5tByaJmopn4vor7xIOZk7vM/vFj1omsFyeUmhoK4sU0Pc447VNf/ql3bS/
         zBT+dulgDlz23wuw+E8cH9V3ZWKND5O7zuoT4WEV7yEVfSnocSoeBZ/1/V83rV5H8mLe
         tnm8bUPQSuuQaRgrgAelPlF5GTddZtHN+l5xZ8i//3bQveJNLMApaeRDhw4yw+Fzjg0l
         GuhUQtxtN2so8RMV5iIQWc45olvy3Q/mkTZ2Jz6fHwuLu5/+Coh4xI7mLEA52eXpYL6z
         5RKEARKas0YXh2Y1Ws6MFQ8+sgnFJHFFO4DcqHb29auv6hPAIq5SC3eomhPmMobg1J5n
         4uWQ==
X-Gm-Message-State: AOAM530QnimLBKfMR8mRwa4YeUBsXKkFMyt8F4MjNSgpPZ06+EM601ov
        ngcD+8TpShwi+bPU6po/kZairQ==
X-Google-Smtp-Source: ABdhPJzIo8pks7n2t0RUJFJiDKpZeJEfJSYFuhEHfnaygEuP2ulaLXtrXHHK1wlBmnYNMksso8MRXg==
X-Received: by 2002:adf:ee43:: with SMTP id w3mr4157256wro.198.1635414502859;
        Thu, 28 Oct 2021 02:48:22 -0700 (PDT)
Received: from altair.lan (2.f.6.6.b.3.3.0.3.a.d.b.6.0.6.0.f.f.6.2.a.5.a.7.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:7a5a:26ff:606:bda3:33b:66f2])
        by smtp.googlemail.com with ESMTPSA id i6sm3378029wry.71.2021.10.28.02.48.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Oct 2021 02:48:22 -0700 (PDT)
From:   Lorenz Bauer <lmb@cloudflare.com>
To:     viro@zeniv.linux.org.uk, Shuah Khan <shuah@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     mszeredi@redhat.com, gregkh@linuxfoundation.org,
        Lorenz Bauer <lmb@cloudflare.com>,
        linux-kselftest@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v3 3/4] selftests: bpf: convert test_bpffs to ASSERT macros
Date:   Thu, 28 Oct 2021 10:47:23 +0100
Message-Id: <20211028094724.59043-4-lmb@cloudflare.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211028094724.59043-1-lmb@cloudflare.com>
References: <20211028094724.59043-1-lmb@cloudflare.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Remove usage of deprecated CHECK macros.

Signed-off-by: Lorenz Bauer <lmb@cloudflare.com>
---
 .../selftests/bpf/prog_tests/test_bpffs.c     | 22 +++++++++----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/test_bpffs.c b/tools/testing/selftests/bpf/prog_tests/test_bpffs.c
index 172c999e523c..533e3f3a459a 100644
--- a/tools/testing/selftests/bpf/prog_tests/test_bpffs.c
+++ b/tools/testing/selftests/bpf/prog_tests/test_bpffs.c
@@ -29,43 +29,43 @@ static int read_iter(char *file)
 
 static int fn(void)
 {
-	int err, duration = 0;
+	int err;
 
 	err = unshare(CLONE_NEWNS);
-	if (CHECK(err, "unshare", "failed: %d\n", errno))
+	if (!ASSERT_OK(err, "unshare"))
 		goto out;
 
 	err = mount("", "/", "", MS_REC | MS_PRIVATE, NULL);
-	if (CHECK(err, "mount /", "failed: %d\n", errno))
+	if (!ASSERT_OK(err, "mount /"))
 		goto out;
 
 	err = umount(TDIR);
-	if (CHECK(err, "umount " TDIR, "failed: %d\n", errno))
+	if (!ASSERT_OK(err, "umount " TDIR))
 		goto out;
 
 	err = mount("none", TDIR, "tmpfs", 0, NULL);
-	if (CHECK(err, "mount", "mount root failed: %d\n", errno))
+	if (!ASSERT_OK(err, "mount tmpfs"))
 		goto out;
 
 	err = mkdir(TDIR "/fs1", 0777);
-	if (CHECK(err, "mkdir "TDIR"/fs1", "failed: %d\n", errno))
+	if (!ASSERT_OK(err, "mkdir " TDIR "/fs1"))
 		goto out;
 	err = mkdir(TDIR "/fs2", 0777);
-	if (CHECK(err, "mkdir "TDIR"/fs2", "failed: %d\n", errno))
+	if (!ASSERT_OK(err, "mkdir " TDIR "/fs2"))
 		goto out;
 
 	err = mount("bpf", TDIR "/fs1", "bpf", 0, NULL);
-	if (CHECK(err, "mount bpffs "TDIR"/fs1", "failed: %d\n", errno))
+	if (!ASSERT_OK(err, "mount bpffs " TDIR "/fs1"))
 		goto out;
 	err = mount("bpf", TDIR "/fs2", "bpf", 0, NULL);
-	if (CHECK(err, "mount bpffs " TDIR "/fs2", "failed: %d\n", errno))
+	if (!ASSERT_OK(err, "mount bpffs " TDIR "/fs2"))
 		goto out;
 
 	err = read_iter(TDIR "/fs1/maps.debug");
-	if (CHECK(err, "reading " TDIR "/fs1/maps.debug", "failed\n"))
+	if (!ASSERT_OK(err, "reading " TDIR "/fs1/maps.debug"))
 		goto out;
 	err = read_iter(TDIR "/fs2/progs.debug");
-	if (CHECK(err, "reading " TDIR "/fs2/progs.debug", "failed\n"))
+	if (!ASSERT_OK(err, "reading " TDIR "/fs2/progs.debug"))
 		goto out;
 out:
 	umount(TDIR "/fs1");
-- 
2.32.0

