Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4D3B6C8A5E
	for <lists+bpf@lfdr.de>; Sat, 25 Mar 2023 03:56:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231864AbjCYC4E (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 24 Mar 2023 22:56:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231636AbjCYC4C (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 24 Mar 2023 22:56:02 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87CFA1ADF1
        for <bpf@vger.kernel.org>; Fri, 24 Mar 2023 19:56:01 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id l15-20020a05600c4f0f00b003ed58a9a15eso1993636wmq.5
        for <bpf@vger.kernel.org>; Fri, 24 Mar 2023 19:56:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679712960;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xs2ypoS2S6JnTsADPKzpYsUTZpFpxWqKV2lJ3bTRuwY=;
        b=gynRurtN+DLmBAbqIG/cuRlGHeOYaQoqb53DCCDXXVMUsUbIlcLAP25TTQ38UkWQJX
         7WKm+UvvOdt6Uoib39tELVdxnDcpUUHF+Zsux+KwDg/cokxTRA59pxxK/L37sq/CUXR1
         DNNzIDNYNFyFPeDW5HbHo/5VBaSvZT9mrmLvSMfllFEiGr5me4TJqmmcxjMu6gSH9NCV
         9St0TF+aDq0SplJmK4nqLWumCbYHb/BSpgCHsPfryCUb9HtRqh5YAlLczXUH73jC6tr1
         0mHi2vVN6as7Lt1DumIiVt0LLCbJW2lnf7n5fkshhgQYQIZxH6HwSr/kNXooILjqXZ+j
         5IPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679712960;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xs2ypoS2S6JnTsADPKzpYsUTZpFpxWqKV2lJ3bTRuwY=;
        b=homn4ONS3fFFY7MgQF4FVwmYle4RC2z4MFxApWYS9I1fECJNkGa3T8PkkeGjwtvwiO
         pbGdT7Sptuk+r2pRQT64lwLi7sHKAL3tQiWSmMen10iXeaK0ngPBqwWPUlagC/DVkgCb
         2L76fnT7u6oEGEE8zjcIDs3/Wckn5SEcaU6PYjTDWv3U65pgIzKeS+fOeTofJT+9Orc6
         FrYkAQbNE2+qv38rYprq3Qkv/Wljgt0W/wHF6Mc1yaL9eBOLHmcMLWpDhXt+3RMg7mlS
         vKTQAkz1jST2DCxEKdhFLHS4KgKMiyrai+di0n4yI9fLjWlmH+lQZ90jP6fd7d8Q6GQ0
         VF0Q==
X-Gm-Message-State: AO0yUKVEJqwG9lqQVvrAQDC0uanb6CWVXuU0lWLEvcW9iOEEN9TCygaG
        Vtpslt2kcjF6S674wM9BmBu+EeSr8Gc=
X-Google-Smtp-Source: AK7set+Dhs3tSzsM6FXuCbd9XkGaBKU2+p8qJzMHk7zz0O5ZtnWqq5+Y8QAehhENATrOVojxyd/KDA==
X-Received: by 2002:a05:600c:28b:b0:3ed:5cf7:3080 with SMTP id 11-20020a05600c028b00b003ed5cf73080mr3987784wmk.5.1679712959795;
        Fri, 24 Mar 2023 19:55:59 -0700 (PDT)
Received: from bigfoot.. (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id m1-20020a05600c4f4100b003ee1e07a14asm1428724wmq.45.2023.03.24.19.55.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Mar 2023 19:55:59 -0700 (PDT)
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     bpf@vger.kernel.org, ast@kernel.org
Cc:     andrii@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
        kernel-team@fb.com, yhs@fb.com,
        Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next 05/43] selftests/bpf: prog_tests entry point for migrated test_verifier tests
Date:   Sat, 25 Mar 2023 04:54:46 +0200
Message-Id: <20230325025524.144043-6-eddyz87@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230325025524.144043-1-eddyz87@gmail.com>
References: <20230325025524.144043-1-eddyz87@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

prog_tests/verifier.c would be used as a host for verifier/*.c tests
migrated to use inline assembly and run from test_progs.

The run_test_aux() function mimics the test_verifier behavior
dropping CAP_SYS_ADMIN upon entry.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 .../selftests/bpf/prog_tests/verifier.c       | 29 +++++++++++++++++++
 1 file changed, 29 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/verifier.c

diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/testing/selftests/bpf/prog_tests/verifier.c
new file mode 100644
index 000000000000..aa63f5d84d97
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
@@ -0,0 +1,29 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <test_progs.h>
+
+#include "cap_helpers.h"
+
+__maybe_unused
+static void run_tests_aux(const char *skel_name, skel_elf_bytes_fn elf_bytes_factory)
+{
+	struct test_loader tester = {};
+	__u64 old_caps;
+	int err;
+
+	/* test_verifier tests are executed w/o CAP_SYS_ADMIN, do the same here */
+	err = cap_disable_effective(1ULL << CAP_SYS_ADMIN, &old_caps);
+	if (err) {
+		PRINT_FAIL("failed to drop CAP_SYS_ADMIN: %i, %s\n", err, strerror(err));
+		return;
+	}
+
+	test_loader__run_subtests(&tester, skel_name, elf_bytes_factory);
+	test_loader_fini(&tester);
+
+	err = cap_enable_effective(old_caps, NULL);
+	if (err)
+		PRINT_FAIL("failed to restore CAP_SYS_ADMIN: %i, %s\n", err, strerror(err));
+}
+
+#define RUN(skel) run_tests_aux(#skel, skel##__elf_bytes)
-- 
2.40.0

