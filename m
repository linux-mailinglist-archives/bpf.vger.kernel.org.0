Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 922FF25D588
	for <lists+bpf@lfdr.de>; Fri,  4 Sep 2020 11:59:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726114AbgIDJ7b (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 4 Sep 2020 05:59:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729930AbgIDJ73 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 4 Sep 2020 05:59:29 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70D5AC061244
        for <bpf@vger.kernel.org>; Fri,  4 Sep 2020 02:59:29 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id a17so6106090wrn.6
        for <bpf@vger.kernel.org>; Fri, 04 Sep 2020 02:59:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=e/h3+Ww95n3DT+gRTBzlDswxR5VDT/SUUkajS/376Ns=;
        b=X6TA5Xg8zxTm+Xrlkq3BDKSTTrS6qNpYH0sUQ0PIOz66Knp6GGDiv2pusYdzj1QoEJ
         hF17XWSVoq2Xd1fv9jca0I+/GEKir4NZcfNa3SnMqnFgB8Zyu5N4M83oMlUeNFF+zr8u
         yVMP82YPt5pVQj0aHRUa7SkOhf1HYPUd6zjPI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=e/h3+Ww95n3DT+gRTBzlDswxR5VDT/SUUkajS/376Ns=;
        b=QMZ9JmTdMThQXBI8adLV3qSLqfZmRFi/4LkgJ69hfXEYdQoFjEMyWnOk1XlINXJosw
         +rJ0yjKdvytMch9bpEev+BrOb0PsC8g30uTH2ZsjJUbmSLAxWco0NiaZWcTLMEClzbfO
         tNTfJRsLItVEFqmvgEqJ3sM8gEZoXBypeqK8idC2z803sgSu7Xu32qG2TdvqARNU7My0
         zkyO+rdhFXRit4n+MoTzTDhEvLjaokerRisfl7/6La3cVx/nnVYkkdyCDb5ZYVZJNp+E
         x9Gxf9OWf9/FP/1xYfATl5TpMw8+GdgO+84g79ybFLjq6qVeQG+liMtMwprmsDvJ0Gdg
         P47Q==
X-Gm-Message-State: AOAM532/gZtmO3noj3PBaHoTFia9m51xvm9Ef7QDJiu+/0CMWL1kk2JL
        K7fwlw15MojLMDYS9lTydHicWA==
X-Google-Smtp-Source: ABdhPJxrKQ0nHyDW+1m+Rp44E7cDz2cIKZIlz3uYKr3OteBKeX5geeH/jkneHTFJYxgM5XUsuJcEdg==
X-Received: by 2002:adf:d0cb:: with SMTP id z11mr6538079wrh.192.1599213568097;
        Fri, 04 Sep 2020 02:59:28 -0700 (PDT)
Received: from antares.lan (a.6.f.d.9.5.a.d.2.b.c.0.f.d.4.2.f.f.6.2.a.5.a.7.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:7a5a:26ff:24df:cb2:da59:df6a])
        by smtp.gmail.com with ESMTPSA id c18sm11648088wrx.63.2020.09.04.02.59.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2020 02:59:27 -0700 (PDT)
From:   Lorenz Bauer <lmb@cloudflare.com>
To:     ast@kernel.org, yhs@fb.com, daniel@iogearbox.net,
        jakub@cloudflare.com, john.fastabend@gmail.com
Cc:     bpf@vger.kernel.org, kernel-team@cloudflare.com,
        Lorenz Bauer <lmb@cloudflare.com>
Subject: [PATCH bpf-next v3 4/6] selftests: bpf: Ensure that BTF sockets cannot be released
Date:   Fri,  4 Sep 2020 10:59:02 +0100
Message-Id: <20200904095904.612390-5-lmb@cloudflare.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200904095904.612390-1-lmb@cloudflare.com>
References: <20200904095904.612390-1-lmb@cloudflare.com>
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
index fc0d7f4f02cf..3147655608ab 100644
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

