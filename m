Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E74335ECC1B
	for <lists+bpf@lfdr.de>; Tue, 27 Sep 2022 20:24:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231627AbiI0SYQ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 27 Sep 2022 14:24:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231293AbiI0SYP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 27 Sep 2022 14:24:15 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40B91106511
        for <bpf@vger.kernel.org>; Tue, 27 Sep 2022 11:24:14 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-349e6acbac9so98828717b3.2
        for <bpf@vger.kernel.org>; Tue, 27 Sep 2022 11:24:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date;
        bh=hW2QxEBEOmjvzo0GbBfxTe7MyGxNoyV/eslZfaDgl3o=;
        b=hprAO3fh8xc5XlaK33kmXB/B/OMejzJo8PONZhLhfjfJhOZZaU4B+ZiO9awH2Kv7ZP
         6fjJwDefPN/PAdMCAVL+Ha95OSC9hDtkfdPlrwk7q68zwUZ6rHF3025nOienDD2ejBKd
         FbJ2cgY9SHwvOKdmTypdeH0CafgU3IMXYDjTeYV/wR6WZKAiGrc09JwL40PHNuPXfucF
         mWEIXlcgt7nm8TtHWNlv0Oyb4MPdG7eSgB6FfSPjWaUhubRAyAFXH1QuXsf2iRvbnt+p
         ArkWjGwP9h2jNnZGXKu7wJYJw6NRSDoLc6fm+UC7Q5V1t77h2uTmLstxmdpwUBXltR3R
         H0Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date;
        bh=hW2QxEBEOmjvzo0GbBfxTe7MyGxNoyV/eslZfaDgl3o=;
        b=f+xOLI3KNwpWCVZIhLOnpI6Nqb3tAX94AVWvvhBsvuc1J00hU2vrC3xsPBpjWhK5Qq
         tzl88ZN+AnIKJuIeR12zCH2e6LPb+S/G98IRGS8VDZBj6TRUKbBGbttcKnkMPyOCoL5/
         RjknFylWLyA3mUqGTltlAkrynbBDNOhOQH/DYUSQscu/2Ajmv/EcFgvhfQ7hxypi9HCJ
         fPWCFfOREEMw3LedS4AuC9PvR0d1ndoJROSdltxj708vqq9HhPss3zZt0HfN3gDbbevc
         MRYxhSvY6c5k6raZB83G7Og8RHlOhUmBFLe4g2b3fgQi8cKxSK+Ob03yp0EQTz/Kg7um
         YLPw==
X-Gm-Message-State: ACrzQf20FUY8mBfhRHX7dikfzTJXDMbbIacRNMrlgEkyiyjBnag9rWFT
        /x4KEcbtHTLcIuc1B9YvZRzFw6RxhoVbCkeFCmeRqgQd4De/3FCQRXjax0oOZfhGvPVT4Nbb310
        0nIOVzrvnZAni0+0Kz3bch3BovboX5nUG0cpRUgi2ig3XwdNrm7vxaINYaeKi2AcsQT+s
X-Google-Smtp-Source: AMsMyM7CxE4k6fF6Iyjsg/gBG8uRIP4vauuozKOp9wI8x56Q+n5YEPkOo/tJsTs1T+gotJy4ZztnqupLik51UHaX
X-Received: from pnaduthota.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:4e5])
 (user=pnaduthota job=sendgmr) by 2002:a05:6902:1088:b0:6b0:2054:7dfd with
 SMTP id v8-20020a056902108800b006b020547dfdmr27134915ybu.163.1664303053450;
 Tue, 27 Sep 2022 11:24:13 -0700 (PDT)
Date:   Tue, 27 Sep 2022 18:23:45 +0000
In-Reply-To: <20220927182345.149171-1-pnaduthota@google.com>
Mime-Version: 1.0
References: <20220927182345.149171-1-pnaduthota@google.com>
X-Mailer: git-send-email 2.37.3.998.g577e59143f-goog
Message-ID: <20220927182345.149171-3-pnaduthota@google.com>
Subject: [PATCH bpf 2/2] Add selftests for devmap pinning
From:   Pramukh Naduthota <pnaduthota@google.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org,
        Pramukh Naduthota <pnaduthota@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add a test for devmap pinning.

Signed-off-by: Pramukh Naduthota <pnaduthota@google.com>
---
 .../testing/selftests/bpf/prog_tests/devmap.c | 21 +++++++++++++++++++
 .../selftests/bpf/progs/test_pinned_devmap.c  | 17 +++++++++++++++
 2 files changed, 38 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/devmap.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_pinned_devmap.c

diff --git a/tools/testing/selftests/bpf/prog_tests/devmap.c b/tools/testing/selftests/bpf/prog_tests/devmap.c
new file mode 100644
index 000000000000..735333d3ac07
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/devmap.c
@@ -0,0 +1,21 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (c) 2022 Google
+#include "testing_helpers.h"
+#include "test_progs.h"
+#include "test_pinned_devmap.skel.h"
+#include "test_pinned_devmap_rdonly_prog.skel.h"
+
+void test_devmap_pinning(void)
+{
+	struct test_pinned_devmap *ptr;
+
+	ASSERT_OK_PTR(ptr = test_pinned_devmap__open_and_load(), "first load");
+	test_pinned_devmap__destroy(ptr);
+	ASSERT_OK_PTR(test_pinned_devmap__open_and_load(), "re-load");
+}
+
+void test_devmap(void)
+{
+	if (test__start_subtest("pinned_devmap"))
+		test_devmap_pinning();
+}
diff --git a/tools/testing/selftests/bpf/progs/test_pinned_devmap.c b/tools/testing/selftests/bpf/progs/test_pinned_devmap.c
new file mode 100644
index 000000000000..63879de18ad3
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_pinned_devmap.c
@@ -0,0 +1,17 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2022 Google */
+#include <stddef.h>
+#include <linux/bpf.h>
+#include <linux/types.h>
+#include <bpf/bpf_helpers.h>
+
+struct {
+	__uint(type, BPF_MAP_TYPE_DEVMAP_HASH);
+	__uint(max_entries, 32);
+	__type(key, int);
+	__type(value, int);
+	__uint(pinning, LIBBPF_PIN_BY_NAME);
+} dev_map SEC(".maps");
+
+
+char _license[] SEC("license") = "GPL";
-- 
2.30.2

