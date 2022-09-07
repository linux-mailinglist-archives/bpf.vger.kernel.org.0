Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B822A5AFB82
	for <lists+bpf@lfdr.de>; Wed,  7 Sep 2022 07:04:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229558AbiIGFEU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 7 Sep 2022 01:04:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiIGFEU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 7 Sep 2022 01:04:20 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27C9E9C2F1;
        Tue,  6 Sep 2022 22:04:19 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id 78so12491671pgb.13;
        Tue, 06 Sep 2022 22:04:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date;
        bh=Q5bAnJtVFnp319EIgRFa2Zj3l9LOhyIDjH73ZWT66P8=;
        b=QN2Fh+10PlxGBEB1nyhgecUXLy1tcGt3bU5t8A00gEsdgPGA0IYD71YML0yG7OnVon
         oZ4q6iidhcx7nEl3/vEaRoI7GAVFF5d2djWXM0XAW8X6rNTuUgljv6FPwYqohtWCoePB
         5reK0An5RPtU8rhr5Dw9zK7jD+7QnlbSaJO876HCL8Ekj7jjSdvwvJqKkX2LBkjtCJ5j
         DiWje0Rv4BTEdcicnrtytcDXnPXUWEHpjPaWrLmE0kVT5ODsH1f5Yrs1m5eu6S78yhoz
         nrqph/tt6EKamrViUTK5uIuiuCa5eRWnAA/fhROTgqqGeCFEJqOCVxbZK1134Lk0QsPl
         PGpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date;
        bh=Q5bAnJtVFnp319EIgRFa2Zj3l9LOhyIDjH73ZWT66P8=;
        b=lj8IXV+7r0yCQO+m5LIXOJ0MhiAf+LFCS/pTtrhe6qLOIxBsE0TsJpS+nUmM3BGHhz
         3Ct73Au6HhzS1M049zUKpy7OkzCd2x/55KAoE+7nS2YmzVZFCdAZmUwxF643umQdOCRO
         xayfqOKSl1mSfp3zoPGCr+hK4UR0wEJHL5KiWtO4F/HAbhqm7kgZxp03mStwA4ECS6tP
         hm+4qIb2GIFmjsc+4EoqdnGWtIApfCuv1F4qyzHn8SAknMrz3YLakN13eLzXUL9pcbkT
         p4jVgjDWt+e0r4Bfn6MQfE6o8XGJ6klQXqeNgpHgiy+3t3DAPNFb4SgRItO+lno4OaOJ
         YtQw==
X-Gm-Message-State: ACgBeo0TErcu7zC1TODYNskXYV+0leZwKlsbc5ZY3FeQ7ILznITSBmOp
        WykRJSXGjEeuaPeV9Yoxhbw=
X-Google-Smtp-Source: AA6agR6sTiTHSLBvwr+g6HRi6Ga/xBnUJar+Hfzxq2qEV5M6iE82lFM2UvwP+JZs0fhors2gUDFqnw==
X-Received: by 2002:a63:fe54:0:b0:42b:d11d:1490 with SMTP id x20-20020a63fe54000000b0042bd11d1490mr1937714pgj.51.1662527058372;
        Tue, 06 Sep 2022 22:04:18 -0700 (PDT)
Received: from youngsil.svl.corp.google.com ([2620:15c:2d4:203:31b5:b507:23a9:c4ba])
        by smtp.gmail.com with ESMTPSA id q8-20020a170902a3c800b00172897952a0sm6492116plb.283.2022.09.06.22.04.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Sep 2022 22:04:17 -0700 (PDT)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        linux-perf-users@vger.kernel.org, bpf@vger.kernel.org,
        Marco Elver <elver@google.com>,
        Song Liu <songliubraving@fb.com>
Subject: [PATCH v2] perf test: Skip sigtrap test on old kernels
Date:   Tue,  6 Sep 2022 22:04:07 -0700
Message-Id: <20220907050407.2711513-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

If it runs on an old kernel, perf_event_open would fail because of the
new fields sigtrap and sig_data.  Just skipping the test could miss an
actual bug in the kernel.

Let's check BTF if it has the perf_event_attr.sigtrap field.

Cc: Marco Elver <elver@google.com>
Cc: Song Liu <songliubraving@fb.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/tests/sigtrap.c | 46 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 45 insertions(+), 1 deletion(-)

diff --git a/tools/perf/tests/sigtrap.c b/tools/perf/tests/sigtrap.c
index e32ece90e164..32f08ce0f2b0 100644
--- a/tools/perf/tests/sigtrap.c
+++ b/tools/perf/tests/sigtrap.c
@@ -16,6 +16,8 @@
 #include <sys/syscall.h>
 #include <unistd.h>
 
+#include <bpf/btf.h>
+
 #include "cloexec.h"
 #include "debug.h"
 #include "event.h"
@@ -54,6 +56,42 @@ static struct perf_event_attr make_event_attr(void)
 	return attr;
 }
 
+static bool attr_has_sigtrap(void)
+{
+	bool ret = false;
+
+#ifdef HAVE_BPF_SKEL
+
+	struct btf *btf;
+	const struct btf_type *t;
+	const struct btf_member *m;
+	const char *name;
+	int i, id;
+
+	/* just assume it doesn't have the field */
+	btf = btf__load_vmlinux_btf();
+	if (btf == NULL)
+		return false;
+
+	id = btf__find_by_name_kind(btf, "perf_event_attr", BTF_KIND_STRUCT);
+	if (id < 0)
+		goto out;
+
+	t = btf__type_by_id(btf, id);
+	for (i = 0, m = btf_members(t); i < btf_vlen(t); i++, m++) {
+		name = btf__name_by_offset(btf, m->name_off);
+		if (!strcmp(name, "sigtrap")) {
+			ret = true;
+			break;
+		}
+	}
+out:
+	btf__free(btf);
+#endif
+
+	return ret;
+}
+
 static void
 sigtrap_handler(int signum __maybe_unused, siginfo_t *info, void *ucontext __maybe_unused)
 {
@@ -139,7 +177,13 @@ static int test__sigtrap(struct test_suite *test __maybe_unused, int subtest __m
 
 	fd = sys_perf_event_open(&attr, 0, -1, -1, perf_event_open_cloexec_flag());
 	if (fd < 0) {
-		pr_debug("FAILED sys_perf_event_open(): %s\n", str_error_r(errno, sbuf, sizeof(sbuf)));
+		if (attr_has_sigtrap()) {
+			pr_debug("FAILED sys_perf_event_open(): %s\n",
+				 str_error_r(errno, sbuf, sizeof(sbuf)));
+		} else {
+			pr_debug("perf_event_attr doesn't have sigtrap\n");
+			ret = TEST_SKIP;
+		}
 		goto out_restore_sigaction;
 	}
 
-- 
2.37.2.789.g6183377224-goog

