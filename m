Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E7815E742A
	for <lists+bpf@lfdr.de>; Fri, 23 Sep 2022 08:32:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229821AbiIWGcP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 23 Sep 2022 02:32:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbiIWGcN (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 23 Sep 2022 02:32:13 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2E95286DA;
        Thu, 22 Sep 2022 23:32:08 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id c7so11353254pgt.11;
        Thu, 22 Sep 2022 23:32:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date;
        bh=WxUdEGsTik62n83zEbnQyADA3Q8HNpRJ7Vr3hU7nFw0=;
        b=PB8Yxyqu1cIZcHpdPwqeaHjRmkAABHhkwP3yW/+hbyJjzahc7UuNkwT1sbRtAPt6Lg
         +KUyviXuQmaOchCHZ0JLrMBF25g0GBT7QBa+RDp7K53VkJp4u81WBg2UMU/fneJZ3RRl
         qcD5RSQzO2tM1hgrgrY6lpEk702AUh5xwBkyvFdf9fMQ2qPf4sC90m6Tm0Els7MvJ8vP
         5qgeuWezWuK4kEvcqMp3zyKdvxzAvX+KxtGQjWNQ3pdyPtgwcP8TuTkT5CwZm82fBqfQ
         /1eOPveorjOZG/kQ+PD2b3LC0N9EtbzxfKd9XI7zOx0qj7AmyzTxEsZp63WedPHS0ev9
         lcyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date;
        bh=WxUdEGsTik62n83zEbnQyADA3Q8HNpRJ7Vr3hU7nFw0=;
        b=oIViQA02km2Dk4vsWQAZsFPEwEr00RbPEBtabvqjHNuox90/79ZM4rEX8OymLZhD+f
         KIXrCxhGj/bcEcuvkMHvIcdMHbSNGFduHxO7a2qKO5KmyChgsB7qg7VTmiMs67Vq2Hoj
         E8pw7cNa2SqSICSFxaUbugJPgK4UN3aOUKJy5hUXyQULXRhUx8IIulj4rrZCdMUHz4X3
         ZaMyV51jLkEP73D3Yus5d+SESBVfRYgFlS+LZZTW+tJVtNhB5jqfg2eB2DuISCTKOqJn
         f6ZqheJZ2O0O77z3lbi77lYXR7OkvO2cZTaEXTdS78C+hx+CTde4BW2vOHuwj0e5041v
         Cibg==
X-Gm-Message-State: ACrzQf3LBvT8Hf3ONu6vU/krx1h9ekaz2/cPVqf5RgRQTjQ+R1vl5Ap0
        opckDbvmFd7QSnr+3ovZuME=
X-Google-Smtp-Source: AMsMyM6hUweZRrI93R9swAaBczAnHNHAfr1wi+miQizHQWMHV5ieI1kRO1XhGpOptNaz6D4vD8lOlw==
X-Received: by 2002:a63:fd0c:0:b0:42b:93a2:af0b with SMTP id d12-20020a63fd0c000000b0042b93a2af0bmr6340661pgh.315.1663914727687;
        Thu, 22 Sep 2022 23:32:07 -0700 (PDT)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:6780:1040:5e8b:4a9e:477b:b254])
        by smtp.gmail.com with ESMTPSA id y23-20020aa78f37000000b0053e61633057sm5535477pfr.132.2022.09.22.23.32.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Sep 2022 23:32:07 -0700 (PDT)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org, Song Liu <songliubraving@fb.com>,
        Hao Luo <haoluo@google.com>, bpf@vger.kernel.org
Subject: [PATCH v4] perf tools: Get a perf cgroup more portably in BPF
Date:   Thu, 22 Sep 2022 23:32:05 -0700
Message-Id: <20220923063205.772936-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.37.3.998.g577e59143f-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The perf_event_cgrp_id can be different on other configurations.
To be more portable as CO-RE, it needs to get the cgroup subsys id
using the bpf_core_enum_value() helper.

Suggested-by: Ian Rogers <irogers@google.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
v4 changes)
 * add a missing check in the off_cpu

v3 changes)
 * check compiler features for enum value

v2 changes)
 * fix off_cpu.bpf.c too
 * get perf_subsys_id only once

 tools/perf/util/bpf_skel/bperf_cgroup.bpf.c | 11 ++++++++++-
 tools/perf/util/bpf_skel/off_cpu.bpf.c      | 18 ++++++++++++++----
 2 files changed, 24 insertions(+), 5 deletions(-)

diff --git a/tools/perf/util/bpf_skel/bperf_cgroup.bpf.c b/tools/perf/util/bpf_skel/bperf_cgroup.bpf.c
index 292c430768b5..8e7520e273db 100644
--- a/tools/perf/util/bpf_skel/bperf_cgroup.bpf.c
+++ b/tools/perf/util/bpf_skel/bperf_cgroup.bpf.c
@@ -48,6 +48,7 @@ const volatile __u32 num_cpus = 1;
 
 int enabled = 0;
 int use_cgroup_v2 = 0;
+int perf_subsys_id = -1;
 
 static inline int get_cgroup_v1_idx(__u32 *cgrps, int size)
 {
@@ -58,7 +59,15 @@ static inline int get_cgroup_v1_idx(__u32 *cgrps, int size)
 	int level;
 	int cnt;
 
-	cgrp = BPF_CORE_READ(p, cgroups, subsys[perf_event_cgrp_id], cgroup);
+	if (perf_subsys_id == -1) {
+#if __has_builtin(__builtin_preserve_enum_value)
+		perf_subsys_id = bpf_core_enum_value(enum cgroup_subsys_id,
+						     perf_event_cgrp_id);
+#else
+		perf_subsys_id = perf_event_cgrp_id;
+#endif
+	}
+	cgrp = BPF_CORE_READ(p, cgroups, subsys[perf_subsys_id], cgroup);
 	level = BPF_CORE_READ(cgrp, level);
 
 	for (cnt = 0; i < MAX_LEVELS; i++) {
diff --git a/tools/perf/util/bpf_skel/off_cpu.bpf.c b/tools/perf/util/bpf_skel/off_cpu.bpf.c
index c4ba2bcf179f..38e3b287dbb2 100644
--- a/tools/perf/util/bpf_skel/off_cpu.bpf.c
+++ b/tools/perf/util/bpf_skel/off_cpu.bpf.c
@@ -94,6 +94,8 @@ const volatile bool has_prev_state = false;
 const volatile bool needs_cgroup = false;
 const volatile bool uses_cgroup_v1 = false;
 
+int perf_subsys_id = -1;
+
 /*
  * Old kernel used to call it task_struct->state and now it's '__state'.
  * Use BPF CO-RE "ignored suffix rule" to deal with it like below:
@@ -119,11 +121,19 @@ static inline __u64 get_cgroup_id(struct task_struct *t)
 {
 	struct cgroup *cgrp;
 
-	if (uses_cgroup_v1)
-		cgrp = BPF_CORE_READ(t, cgroups, subsys[perf_event_cgrp_id], cgroup);
-	else
-		cgrp = BPF_CORE_READ(t, cgroups, dfl_cgrp);
+	if (!uses_cgroup_v1)
+		return BPF_CORE_READ(t, cgroups, dfl_cgrp, kn, id);
+
+	if (perf_subsys_id == -1) {
+#if __has_builtin(__builtin_preserve_enum_value)
+		perf_subsys_id = bpf_core_enum_value(enum cgroup_subsys_id,
+						     perf_event_cgrp_id);
+#else
+		perf_subsys_id = perf_event_cgrp_id;
+#endif
+	}
 
+	cgrp = BPF_CORE_READ(t, cgroups, subsys[perf_subsys_id], cgroup);
 	return BPF_CORE_READ(cgrp, kn, id);
 }
 
-- 
2.37.3.998.g577e59143f-goog

