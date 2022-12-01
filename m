Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A392163E6F2
	for <lists+bpf@lfdr.de>; Thu,  1 Dec 2022 02:12:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229775AbiLABL6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 30 Nov 2022 20:11:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229808AbiLABLz (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 30 Nov 2022 20:11:55 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FF7C934CA
        for <bpf@vger.kernel.org>; Wed, 30 Nov 2022 17:11:54 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-39afd53dcdbso2273607b3.8
        for <bpf@vger.kernel.org>; Wed, 30 Nov 2022 17:11:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=oFSiCLMztxmBrlKciOzd82krEOdHrodzMvizxq5cjHs=;
        b=WfNADfu2A09ZAZR95Fo09dv3M34iWn+WVpYddQA5XqJmWj/iXj+uxB4dzxGVkichxS
         yaButpPPFnBUnXKGWpbRfWM+vIFPf1XyyO8w9cmnj6YIdYirB1wjjGoM+DkgmtoUwnZE
         vf7C1936q/r2gC3d8Jb0EcRV5NoUlw+yab1n0hKZloESXA4h0Tp6hTa45bIEn7O323D4
         g4eMQLGBW4kjfeYXuTPO4Hk4NAFqiM3/+7ZSq3wDvAOlZjzrN0qZR4U+mvZCutdm8oMX
         DIwMkNPYYZcaqSRy/JnNC6XYsC/U4iM+H/8w8JjlIkJ1Pp55xQGRE2F1LV+Q6KFl4tUY
         RSrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oFSiCLMztxmBrlKciOzd82krEOdHrodzMvizxq5cjHs=;
        b=JprnDTKxWWLhsZMy6KMj3iIxkGTQgO9q9thYDGDwEeYusNgQfa3Vcj0ixGFUx/jppg
         Jtw7PTFcTNTvjlWegi6EP6c+87u7M3+lXty+2izLYvJ1z13o5u4KOFDsobRZJ4zT5DHz
         MmXucRm8IsF1yBFSBZsS1+DppDW7kdn9vIMnbwwVHwCeY0uyZNGs77Thz7sUxlaQObK9
         JCHafsaKyDt1UQRfYsp1VSDMH5rOe5a1eDfaMSlOTowh/DqgOwZwhdWxhEnl4zHi61H9
         hk5iwjOBsdanXvySR/mv3UcOdGbOkKQ5geOspyg7ji5+VXXDqdwIUTeoZNByiMkwFhvt
         vglA==
X-Gm-Message-State: ANoB5pleNtaUvV/ICl1hdAIyqFwP7PsGMoiC4beGX14pbeBV4sS5nhp2
        E4X96SNiYM4vRAQfYytwvTRKhVafN6YLRvjJpvwxknqURUxZ4T6WCxUtGSDsSqM9EeSWc0Dz9zw
        SMGjro8ibAP5dTKiLAvofVbTfxifARWj6UZpAu9GGq0pu2Rp4bta7IYGR4vtoqZdUUwt4
X-Google-Smtp-Source: AA0mqf6ZbkLrSnUIbgeq5/RLmSPSofz6SBQLtGHwMohMSnPH3We2ism/qqJZnqhWdGZpsfiBHw0Qc519BXXKoEkl
X-Received: from pnaduthota.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:4e5])
 (user=pnaduthota job=sendgmr) by 2002:a25:d089:0:b0:6f2:e321:6368 with SMTP
 id h131-20020a25d089000000b006f2e3216368mr29095812ybg.318.1669857113599; Wed,
 30 Nov 2022 17:11:53 -0800 (PST)
Date:   Thu,  1 Dec 2022 01:11:35 +0000
In-Reply-To: <20221201011135.1589838-1-pnaduthota@google.com>
Mime-Version: 1.0
References: <20221201011135.1589838-1-pnaduthota@google.com>
X-Mailer: git-send-email 2.38.1.584.g0f3c55d4c2-goog
Message-ID: <20221201011135.1589838-3-pnaduthota@google.com>
Subject: [PATCH net-next v2 2/2] Add a selftest for devmap pinning.
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

Add a selftest

Signed-off-by: Pramukh Naduthota <pnaduthota@google.com>
---
 .../testing/selftests/bpf/prog_tests/devmap.c | 20 +++++++++++++++++++
 .../selftests/bpf/progs/test_pinned_devmap.c  | 17 ++++++++++++++++
 2 files changed, 37 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/devmap.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_pinned_devmap.c

diff --git a/tools/testing/selftests/bpf/prog_tests/devmap.c b/tools/testing/selftests/bpf/prog_tests/devmap.c
new file mode 100644
index 000000000000..50c5006c1416
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/devmap.c
@@ -0,0 +1,20 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2022 Google */
+#include "testing_helpers.h"
+#include "test_progs.h"
+#include "test_pinned_devmap.skel.h"
+
+void test_devmap_pinning(void)
+{
+	struct test_pinned_devmap *ptr;
+
+	ptr = test_pinned_devmap__open_and_load()
+	ASSERT_OK_PTR(ptr, "first load");
+	test_pinned_devmap__destroy(ptr);
+	ASSERT_OK_PTR(test_pinned_devmap__open_and_load(), "re-load");
+}
+
+void test_devmap(void)
+{
+	test_devmap_pinning();
+}
diff --git a/tools/testing/selftests/bpf/progs/test_pinned_devmap.c b/tools/testing/selftests/bpf/progs/test_pinned_devmap.c
new file mode 100644
index 000000000000..2e9b25fe657c
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
+} repinned_dev_map SEC(".maps");
+
+
+char _license[] SEC("license") = "GPL";
-- 
2.30.2

