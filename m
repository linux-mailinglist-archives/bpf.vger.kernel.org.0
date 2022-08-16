Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF47A596615
	for <lists+bpf@lfdr.de>; Wed, 17 Aug 2022 01:40:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229472AbiHPXkV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 16 Aug 2022 19:40:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237482AbiHPXkU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 16 Aug 2022 19:40:20 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C70CF75CDD
        for <bpf@vger.kernel.org>; Tue, 16 Aug 2022 16:40:18 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-334370e5ab9so33241737b3.22
        for <bpf@vger.kernel.org>; Tue, 16 Aug 2022 16:40:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc;
        bh=D08oWd4LjFqivxR059JhoCieMYjNYb3QgJK4ULKJads=;
        b=Zd3BC7tgcxZnVGrjx21FVrnzY80tCScyV8zDCKSI+7F3gEaY56vZZcgjbaX+ZcwRQc
         HZ/Wu390bK80ivlifGXr9LF9OjpnJgcHdlAN6/+kQsh4fnm02aO3v518wNfWMO7vEsh8
         6FlZgcS14qYwXC7gGmtTXj4JyINBIh4mtFkaeh8icfL1r/HMSvGijpysXJSL2af8/b44
         9lUKgKYKSDrJ8tlmc184899jxmmsb07fOYenHKZHSRRIHhcNHz+vDjGZXeccPEBaBV5t
         UpkzDmgLfBcTysKw2hwq81ayyaXRVrZFObFAFssMbKqUipJndVhEPOAp3NVCLDwglk8T
         J8Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc;
        bh=D08oWd4LjFqivxR059JhoCieMYjNYb3QgJK4ULKJads=;
        b=uOW5QSfatxC0KIrWZIpPsGRehFAF3Uzz7Kegmsxx6XYMXlv8Lu4fCL5FyhwfCBopOM
         Yj+xkYcuv/fiOBSuc6eEYg6qraNwk6pprZqNk4Jf+sgZGWp+eMAaREZjOnSN5bGLlhrS
         QFG6hMsiUbi1bbtYvzdt6PqnvV6BTFViqdKePK49wkCCLSuhJdbTpmDj2EwFFPxhnJWf
         voq1Ysj29Z7zQ82rWPgU6Ovkwrn48EyPUPYDPa7vNUbYDPJIbGjvNjvmh53ygidF2ziI
         uJ8yp8q6b0eD+1w2pXasFOt/O9Tt9DpaCv0a4Z4y6WEQqT2g3DRefZ5A4YL09bhaAWUd
         RLrw==
X-Gm-Message-State: ACgBeo3ML5jIM3F1DbxgTWqmXSWVWFVb8nPzev9ROoMa+gHifbnmb8Kr
        W//A+r2C7Kns68WrHFlstgxTvsBSA7c=
X-Google-Smtp-Source: AA6agR6agp/FjD0u3wYPK2e4qb7uNMXZOBvd/d4O6snkHxKspfot09Y1KmGgtlJ6DmBU+Qib6xRCaQngUhE=
X-Received: from haoluo.svl.corp.google.com ([2620:15c:2d4:203:7e6e:c287:3dc6:d4d8])
 (user=haoluo job=sendgmr) by 2002:a05:6902:72c:b0:676:d795:d6f8 with SMTP id
 l12-20020a056902072c00b00676d795d6f8mr17854320ybt.406.1660693218147; Tue, 16
 Aug 2022 16:40:18 -0700 (PDT)
Date:   Tue, 16 Aug 2022 16:40:12 -0700
In-Reply-To: <20220816234012.910255-1-haoluo@google.com>
Message-Id: <20220816234012.910255-2-haoluo@google.com>
Mime-Version: 1.0
References: <20220816234012.910255-1-haoluo@google.com>
X-Mailer: git-send-email 2.37.1.595.g718a3a8f04-goog
Subject: [PATCH bpf-next v2 2/2] selftests/bpf: Tests libbpf autoattach APIs
From:   Hao Luo <haoluo@google.com>
To:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        Jiri Olsa <jolsa@kernel.org>, KP Singh <kpsingh@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Stanislav Fomichev <sdf@google.com>,
        Yosry Ahmed <yosryahmed@google.com>,
        Hao Luo <haoluo@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Adds test for libbpf APIs that toggle bpf program auto-attaching.

Signed-off-by: Hao Luo <haoluo@google.com>
---
 .../selftests/bpf/prog_tests/autoattach.c     | 30 +++++++++++++++++++
 .../selftests/bpf/progs/test_autoattach.c     | 23 ++++++++++++++
 2 files changed, 53 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/autoattach.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_autoattach.c

diff --git a/tools/testing/selftests/bpf/prog_tests/autoattach.c b/tools/testing/selftests/bpf/prog_tests/autoattach.c
new file mode 100644
index 000000000000..b34b5945d297
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/autoattach.c
@@ -0,0 +1,30 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2022 Google */
+
+#include <test_progs.h>
+#include "test_autoattach.skel.h"
+
+void test_autoattach(void)
+{
+	struct test_autoattach* skel;
+
+	skel = test_autoattach__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "skel_open_and_load"))
+		goto cleanup;
+
+	/* disable auto-attach for prog2 */
+	bpf_program__set_autoattach(skel->progs.prog2, false);
+	ASSERT_TRUE(bpf_program__autoattach(skel->progs.prog1), "autoattach_prog1");
+	ASSERT_FALSE(bpf_program__autoattach(skel->progs.prog2), "autoattach_prog2");
+	if (!ASSERT_OK(test_autoattach__attach(skel), "skel_attach"))
+		goto cleanup;
+
+	usleep(1);
+
+	ASSERT_TRUE(skel->bss->prog1_called, "attached_prog1");
+	ASSERT_FALSE(skel->bss->prog2_called, "attached_prog2");
+
+cleanup:
+	test_autoattach__destroy(skel);
+}
+
diff --git a/tools/testing/selftests/bpf/progs/test_autoattach.c b/tools/testing/selftests/bpf/progs/test_autoattach.c
new file mode 100644
index 000000000000..11a44493ebce
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_autoattach.c
@@ -0,0 +1,23 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2022 Google */
+
+#include "vmlinux.h"
+#include <bpf/bpf_tracing.h>
+
+bool prog1_called = false;
+bool prog2_called = false;
+
+SEC("raw_tp/sys_enter")
+int prog1(const void *ctx)
+{
+	prog1_called = true;
+	return 0;
+}
+
+SEC("raw_tp/sys_exit")
+int prog2(const void *ctx)
+{
+	prog2_called = true;
+	return 0;
+}
+
-- 
2.37.1.595.g718a3a8f04-goog

