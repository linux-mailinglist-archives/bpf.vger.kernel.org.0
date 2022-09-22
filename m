Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CF515E5A4D
	for <lists+bpf@lfdr.de>; Thu, 22 Sep 2022 06:40:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229677AbiIVEk2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 22 Sep 2022 00:40:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbiIVEk0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 22 Sep 2022 00:40:26 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39250883C9;
        Wed, 21 Sep 2022 21:40:26 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id x1so7685551plv.5;
        Wed, 21 Sep 2022 21:40:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date;
        bh=2zbl9tgj4NFm7PKmvB7l9G8vYBtZS9R+8WUfma5ExAI=;
        b=DDA0pYsyC5qYwF9YM2ZWl5MdN+7D9C/mok35NucRg7vcjW92j/ateO/hg/Ppsqrj4f
         tTkGNqUHzu1ME/j+1KW+UX/Mq8Wfi1exK1r7ovbZ2Wp3dr3UC+CWC5eXxhU3XVaywvoF
         x0KWWUbHhesCBSKWMhkEd/y0yawVrvdmLUDZt5NolHjsYMGxwhk2tKU5A/TyMpVciHoG
         P69EJSCzCpzsDpVuXEQPZ6xsWRyI7XsbWABMB8i6DujvwmUurdhFxTfMnYfe45rwd4gq
         trEAtYlOWNigxdbiC0/+zlvXJTvCqsJgWER8cVIiIX2NIB4/Rk7OEoGY7FK/J9mIwUV+
         eMQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date;
        bh=2zbl9tgj4NFm7PKmvB7l9G8vYBtZS9R+8WUfma5ExAI=;
        b=xxS7ed/DHV6vyNq9mU36Mghna211Tc2sSrjiVDSj09+dSCUS0bfBbhio+NWFgweB7O
         GG7pHGp6ejEEXX/a5uMLbtcPQV91kMpvoD7Oj5RpQEeRIl9owenHLLapqnP+1+008Hzo
         NGanE0qGBC0Vb3slOfK77vi4+6iUAPZgEKym023w3zDKk554vcaFHVC7ETcunXkrcpIN
         MvwKLSXIAPyDUnshKdhwRTbigteZvC7Kogb/T6NI+y8NMtTqsu2X5nOJb4g02ISPVkxP
         sDdnyvWJ7c/VJxkXm+NFgKiTL2T0lY4I0E1UdrKAlQ4TvPqGXMKi9pZ+ct73ZZd2c6N5
         Oo0A==
X-Gm-Message-State: ACrzQf0v3L7bytixqpwryq8u6piNPXhD/deVUPNz7EnZf28p2tw3RqUS
        WlTiA5k1ETMsq+M+VoqCzyXSfmn0S4w=
X-Google-Smtp-Source: AMsMyM6wrlwxHyHurrkjoPuow6mGwsc8PMAfGjNdtWn7WGiVInHdHgDaBVr6v3pesSu6JSe+8by7Dg==
X-Received: by 2002:a17:902:7887:b0:178:5e8a:e84e with SMTP id q7-20020a170902788700b001785e8ae84emr1600930pll.64.1663821625529;
        Wed, 21 Sep 2022 21:40:25 -0700 (PDT)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:6780:1040:796c:caf8:4dcf:320d])
        by smtp.gmail.com with ESMTPSA id 207-20020a6215d8000000b00537a6b81bb7sm3183996pfv.148.2022.09.21.21.40.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Sep 2022 21:40:25 -0700 (PDT)
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
        bpf@vger.kernel.org
Subject: [PATCH v2] perf tools: Get a perf cgroup more portably in BPF
Date:   Wed, 21 Sep 2022 21:40:23 -0700
Message-Id: <20220922044023.718774-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.37.3.968.ga6b4b080e4-goog
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
v2 changes)
 * fix off_cpu.bpf.c too
 * get perf_subsys_id only once

 tools/perf/util/bpf_skel/bperf_cgroup.bpf.c |  6 +++++-
 tools/perf/util/bpf_skel/off_cpu.bpf.c      | 12 ++++++++----
 2 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/tools/perf/util/bpf_skel/bperf_cgroup.bpf.c b/tools/perf/util/bpf_skel/bperf_cgroup.bpf.c
index 292c430768b5..9223e4b87fe9 100644
--- a/tools/perf/util/bpf_skel/bperf_cgroup.bpf.c
+++ b/tools/perf/util/bpf_skel/bperf_cgroup.bpf.c
@@ -48,6 +48,7 @@ const volatile __u32 num_cpus = 1;
 
 int enabled = 0;
 int use_cgroup_v2 = 0;
+int perf_subsys_id = -1;
 
 static inline int get_cgroup_v1_idx(__u32 *cgrps, int size)
 {
@@ -58,7 +59,10 @@ static inline int get_cgroup_v1_idx(__u32 *cgrps, int size)
 	int level;
 	int cnt;
 
-	cgrp = BPF_CORE_READ(p, cgroups, subsys[perf_event_cgrp_id], cgroup);
+	if (perf_subsys_id == -1)
+		perf_subsys_id = bpf_core_enum_value(enum cgroup_subsys_id, perf_event_cgrp_id);
+
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
2.37.3.968.ga6b4b080e4-goog

