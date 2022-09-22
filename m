Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F0215E6D65
	for <lists+bpf@lfdr.de>; Thu, 22 Sep 2022 22:53:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229578AbiIVUxI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 22 Sep 2022 16:53:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229871AbiIVUxF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 22 Sep 2022 16:53:05 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D65F710E5D4;
        Thu, 22 Sep 2022 13:53:04 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id e67so4230944pgc.12;
        Thu, 22 Sep 2022 13:53:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date;
        bh=OEiYqQ5XMiZEsacnAM3U6vllLLEEWGSHG5V5hJfSBLU=;
        b=Dm/XGtOHUuh9qDFLOe7p4DdAUZO7iM314X5cc4JpfK9kYIOYoM1b4UF7mBai7qihfs
         N/Z2XL5t6WdMEdNl3ABr5A23WTkr9hJkIReoHglVx/hUMs7KXd6KQF/5vte33u5h+LER
         PVgMc0Bpch4I05li8IE1FJuH04tEyK5zdLRl2Rlyb5Xcljo6tPP8OrPLlwW7IIJ2hO1S
         h75uS1/IFW2pRnHwfOYSygVKjoljOg0N7yzlqKiWKE3ohvLQLcA2MTD1A1KuWdINWWYn
         WBcxh6XyRTkPgXC3EWozvnlwZxB/KTcH2zhThrw8HzgIISzrYfrzz8b8tyvT4jPPkB+7
         yzUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date;
        bh=OEiYqQ5XMiZEsacnAM3U6vllLLEEWGSHG5V5hJfSBLU=;
        b=q4CsjS24y+400Z9uNcWddaqsW9nXdluYg+hrOsaHGL1mM04t4EBsyPZO9hdS+vyGbj
         z01NcG/XvmK/xp40GIIBNsGT6RnPgEYQzk2JwTGyCjNgYgQqdiXI4qRSgjHIKHTZSgXI
         ZcUjzKUdmPcokDFEc5Ba5dAIaY9KvPvEAmzbBg9RoixVMEQSTrRsmCeK16rVOhnHXMaj
         LJxCsM3doN2X2Qs82sl0A8oXfRCljD4xcSyXt41yA6gFZz58QbYux5NvRBW3kAz0GEWU
         38xNtFGXSl5MkFialjpy0OiTsvHQm6HsjFNEXO1BMZIz1iJNbqwcvc3+ivqBtMPQlpNm
         VEgw==
X-Gm-Message-State: ACrzQf00YzGuuGoD/cPY5tdVq4s+vaDMxu+CbDmT6qR1Ajp/G/ZnjXPv
        MYvoYvVzw0oaZFxoCSgdMao=
X-Google-Smtp-Source: AMsMyM6ayFSD3xpD5oqX2Zh/XuTEcTs+sreA32ohXSExSoLYAy9gzsn+WpsB/hhUxCGNXhHlhoFDog==
X-Received: by 2002:a63:6905:0:b0:43c:d4:eef4 with SMTP id e5-20020a636905000000b0043c00d4eef4mr4513265pgc.126.1663879984312;
        Thu, 22 Sep 2022 13:53:04 -0700 (PDT)
Received: from balhae.corp.google.com ([2620:0:1000:1610:206:3611:6db0:fc8f])
        by smtp.gmail.com with ESMTPSA id y7-20020a623207000000b0053f9466b1b2sm4889916pfy.35.2022.09.22.13.53.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Sep 2022 13:53:03 -0700 (PDT)
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
Subject: [PATCH v3] perf tools: Get a perf cgroup more portably in BPF
Date:   Thu, 22 Sep 2022 13:53:02 -0700
Message-Id: <20220922205302.749274-1-namhyung@kernel.org>
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
v3 changes)
 * check compiler features for enum value

v2 changes)
 * fix off_cpu.bpf.c too
 * get perf_subsys_id only once

 tools/perf/util/bpf_skel/bperf_cgroup.bpf.c | 11 ++++++++++-
 tools/perf/util/bpf_skel/off_cpu.bpf.c      | 12 ++++++++----
 2 files changed, 18 insertions(+), 5 deletions(-)

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
index c4ba2bcf179f..e917ef7b8875 100644
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
@@ -119,11 +121,13 @@ static inline __u64 get_cgroup_id(struct task_struct *t)
 {
 	struct cgroup *cgrp;
 
-	if (uses_cgroup_v1)
-		cgrp = BPF_CORE_READ(t, cgroups, subsys[perf_event_cgrp_id], cgroup);
-	else
-		cgrp = BPF_CORE_READ(t, cgroups, dfl_cgrp);
+	if (!uses_cgroup_v1)
+		return BPF_CORE_READ(t, cgroups, dfl_cgrp, kn, id);
+
+	if (perf_subsys_id == -1)
+		perf_subsys_id = bpf_core_enum_value(enum cgroup_subsys_id, perf_event_cgrp_id);
 
+	cgrp = BPF_CORE_READ(t, cgroups, subsys[perf_subsys_id], cgroup);
 	return BPF_CORE_READ(cgrp, kn, id);
 }
 
-- 
2.37.3.998.g577e59143f-goog

