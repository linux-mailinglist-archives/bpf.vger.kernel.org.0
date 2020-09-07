Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BF1C25FDD9
	for <lists+bpf@lfdr.de>; Mon,  7 Sep 2020 17:59:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729820AbgIGP7Y (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 7 Sep 2020 11:59:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730004AbgIGOtE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 7 Sep 2020 10:49:04 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C189C061795
        for <bpf@vger.kernel.org>; Mon,  7 Sep 2020 07:48:35 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id z1so16128438wrt.3
        for <bpf@vger.kernel.org>; Mon, 07 Sep 2020 07:48:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HvozQHes9NCAIlJe5t1kqMTRgWB1n5u3io5910Bjnj0=;
        b=K7AOBaa7VY6wI1kAgnnIzKu1DIQp6xhuGkyutmjvIJJLKmK/K/YuLF0I9Tq/jcRc7N
         ZhwL+lvG4LRBabGQEO+BSYybYHtRQXL2fy9mQAKNXuoA3PtPOTiEcDQTUteHU+yzojGU
         MqJOCEDf2GmC8M2Pk3lMSQdQmza5jLZnTIA5E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HvozQHes9NCAIlJe5t1kqMTRgWB1n5u3io5910Bjnj0=;
        b=tWtEEoyB84eC1rDttcpoKHlix5o668RVqPW9DHneuoNSqFBWIlu1Mge9sAhxf7uIE7
         mowgszyfy5MCJBdDQK4bsFu+R5FEAevPtVl1582/6zkbPEwnO6APsUQWO6rwGBxfPksf
         Wf55dto2XiFuJGxBy2r0GNSEEepFhXYBlh/QdKAtDC61sbj8RGupGAyOXT18kY3ToqBJ
         ZQT1eyPxzRyF0kB6uzGU5cQ92XGB7MJc+HPd1mKX/fY4znZLsYkQL03somJ7Vx7vVzgo
         bvMqAgfSuQ4Et3KyP6mIPemN9yA2D58AEIYGa/VOGru0nbbFsw9K2+OLd5CK/fc0Lpl4
         5mxA==
X-Gm-Message-State: AOAM531q8Y6kqgdJ+/uZyIqIzZv+ugIB5uIzDZlLVxzlihMbN3K+UpBI
        2aLUkMhqKLDodoh5lIv3PVmiZA==
X-Google-Smtp-Source: ABdhPJyCjY14U1/W2QJqCOt4VjB1cImP2r2c6RLICktK3GL3/wpWtK8rhp0QH3A2nt230h+vIJqBZw==
X-Received: by 2002:adf:dcc3:: with SMTP id x3mr21495196wrm.120.1599490113997;
        Mon, 07 Sep 2020 07:48:33 -0700 (PDT)
Received: from antares.lan (2.e.3.8.e.0.6.b.6.2.5.e.8.e.4.b.f.f.6.2.a.5.a.7.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:7a5a:26ff:b4e8:e526:b60e:83e2])
        by smtp.gmail.com with ESMTPSA id 59sm8816834wro.82.2020.09.07.07.48.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2020 07:48:33 -0700 (PDT)
From:   Lorenz Bauer <lmb@cloudflare.com>
To:     ast@kernel.org, yhs@fb.com, daniel@iogearbox.net,
        jakub@cloudflare.com, john.fastabend@gmail.com, kafai@fb.com
Cc:     bpf@vger.kernel.org, kernel-team@cloudflare.com,
        Lorenz Bauer <lmb@cloudflare.com>
Subject: [PATCH bpf-next v4 5/7] selftests: bpf: Ensure that BTF sockets cannot be released
Date:   Mon,  7 Sep 2020 15:46:59 +0100
Message-Id: <20200907144701.44867-6-lmb@cloudflare.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200907144701.44867-1-lmb@cloudflare.com>
References: <20200907144701.44867-1-lmb@cloudflare.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Being able to pass a BTF struct sock* to bpf_sk_release would screw up
reference counting, and must therefore be prevented. Add a test which
ensures that this property holds.

Signed-off-by: Lorenz Bauer <lmb@cloudflare.com>
---
 .../bpf/prog_tests/reference_tracking.c       | 20 ++++++++++++++++++-
 .../bpf/progs/test_sk_ref_track_invalid.c     | 20 +++++++++++++++++++
 2 files changed, 39 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/bpf/progs/test_sk_ref_track_invalid.c

diff --git a/tools/testing/selftests/bpf/prog_tests/reference_tracking.c b/tools/testing/selftests/bpf/prog_tests/reference_tracking.c
index ac1ee10cffd8..3f19c8a16bb4 100644
--- a/tools/testing/selftests/bpf/prog_tests/reference_tracking.c
+++ b/tools/testing/selftests/bpf/prog_tests/reference_tracking.c
@@ -1,7 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <test_progs.h>
+#include "test_sk_ref_track_invalid.skel.h"
 
-void test_reference_tracking(void)
+static void test_sk_lookup(void)
 {
 	const char *file = "test_sk_lookup_kern.o";
 	const char *obj_name = "ref_track";
@@ -50,3 +51,20 @@ void test_reference_tracking(void)
 cleanup:
 	bpf_object__close(obj);
 }
+
+static void test_sk_release_invalid(void)
+{
+	struct test_sk_ref_track_invalid *skel;
+	int duration = 0;
+
+	skel = test_sk_ref_track_invalid__open_and_load();
+	if (CHECK(skel, "open_and_load", "verifier accepted sk_release of BTF struct sock*\n"))
+		test_sk_ref_track_invalid__destroy(skel);
+}
+
+void test_reference_tracking(void)
+{
+	test_sk_lookup();
+	if (test__start_subtest("invalid sk_release"))
+		test_sk_release_invalid();
+}
diff --git a/tools/testing/selftests/bpf/progs/test_sk_ref_track_invalid.c b/tools/testing/selftests/bpf/progs/test_sk_ref_track_invalid.c
new file mode 100644
index 000000000000..9017d92a807b
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_sk_ref_track_invalid.c
@@ -0,0 +1,20 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (c) 2020 Cloudflare
+
+#include "bpf_iter.h"
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_endian.h>
+#include <bpf/bpf_tracing.h>
+
+char _license[] SEC("license") = "GPL";
+
+SEC("iter/bpf_sk_storage_map")
+int dump_bpf_sk_storage_map(struct bpf_iter__bpf_sk_storage_map *ctx)
+{
+	struct sock *sk = ctx->sk;
+
+	if (sk)
+		bpf_sk_release((struct bpf_sock *)sk);
+
+	return 0;
+}
-- 
2.25.1

