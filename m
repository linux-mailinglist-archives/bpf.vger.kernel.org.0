Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 784115906A6
	for <lists+bpf@lfdr.de>; Thu, 11 Aug 2022 21:07:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236169AbiHKSzG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 11 Aug 2022 14:55:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236148AbiHKSzF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 11 Aug 2022 14:55:05 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 912B09E2E7;
        Thu, 11 Aug 2022 11:55:04 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id y141so17227600pfb.7;
        Thu, 11 Aug 2022 11:55:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc;
        bh=2cod6Z7LibdeMn8uoQb1Rhaw5oJrEcLjiUxCrov59Is=;
        b=fJprRh7mUoC6596up0r7/10cQGnTTsJaaZ00ABFvuZMY2ee0sBzztjKBHcG6AZ5kLn
         SOupl0lSWwR0G0e2SiJ4hvS9/1CAdLNd5dGShuV0b4W7bjfuh6jo6K9DiHFFZIMBzr4f
         QO5/HrsTUq5bEkv+qbm+DmEwOodt3X1SrAaVswbDiK3ehKhzaqZwJB97DlUFaF7Y3b4g
         aqJh6FPRtquWg+Lp0U8fbK+o1c7914o8jOrR93pKkl4wjn8ArpUL3cDNkvjjhno3c7g/
         DAfEbMVQtLHuseBakimcbYt6wN7tCTjznq899p9O+3ikpfcDAmBZa7EbNntvSrYukwS5
         CngQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc;
        bh=2cod6Z7LibdeMn8uoQb1Rhaw5oJrEcLjiUxCrov59Is=;
        b=L4PgvUdBqzWq8wx79cjwHcvcBF+z9cp6q93IS4AAbkkGg13KKhwQ2ef4gVxt2PUrj0
         bUErPl8YfgraBXXHLSsCBAFMRTfkpGcdQkX/PU70DgNlr+iPd0ZiLIc4hCDVltTHHlx3
         VZ/Oo7ThTWPWKRjfnX5qRsEaOQ5Jc20zu7MB+FlqBRzwS7hiDH/KCX6qZ/Leeyr0V+VV
         YOLY2i1++k4HySgfNz66023eRcSzaAo25lqt+oGvCzVlaxO1cufqogbfjJ04eBxDM5Z3
         D8B7V5YrMTNZsS+FYQX6nsiVVXdYkYQwRiZ+siv6/a2Cm20zBlH6eItyJXnt15l+06zC
         nzpA==
X-Gm-Message-State: ACgBeo0yXeucE0+2fnvRbuaZtphJZP8Wn8t5HmlPhOYwlFCtNgFnEDpW
        FbJaYFwssJuIX6UIe8ygtdo=
X-Google-Smtp-Source: AA6agR6PhZYOveICAttaIRAzc9X4mUErwc/Eq67S/Mco+gQ0auKvrydAhb25F1duRW92L5pBM+CF5A==
X-Received: by 2002:a63:224a:0:b0:41e:1d36:5063 with SMTP id t10-20020a63224a000000b0041e1d365063mr306352pgm.568.1660244104049;
        Thu, 11 Aug 2022 11:55:04 -0700 (PDT)
Received: from youngsil.svl.corp.google.com ([2620:15c:2d4:203:cefb:475d:dd6d:a1e2])
        by smtp.gmail.com with ESMTPSA id r12-20020a6560cc000000b0041975999455sm66314pgv.75.2022.08.11.11.55.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Aug 2022 11:55:03 -0700 (PDT)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        linux-perf-users@vger.kernel.org, Song Liu <songliubraving@fb.com>,
        Hao Luo <haoluo@google.com>,
        Blake Jones <blakejones@google.com>,
        Milian Wolff <milian.wolff@kdab.com>, bpf@vger.kernel.org
Subject: [PATCH 2/4] perf offcpu: Parse process id separately
Date:   Thu, 11 Aug 2022 11:54:54 -0700
Message-Id: <20220811185456.194721-3-namhyung@kernel.org>
X-Mailer: git-send-email 2.37.1.595.g718a3a8f04-goog
In-Reply-To: <20220811185456.194721-1-namhyung@kernel.org>
References: <20220811185456.194721-1-namhyung@kernel.org>
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

The current target code uses thread id for tracking tasks because
perf_events need to be opened for each task.  But we can use tgid in
BPF maps and check it easily.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/bpf_off_cpu.c | 45 +++++++++++++++++++++++++++++++++--
 1 file changed, 43 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/bpf_off_cpu.c b/tools/perf/util/bpf_off_cpu.c
index 7dbcb025da87..f7ee0c7a53f0 100644
--- a/tools/perf/util/bpf_off_cpu.c
+++ b/tools/perf/util/bpf_off_cpu.c
@@ -11,6 +11,7 @@
 #include "util/cpumap.h"
 #include "util/thread_map.h"
 #include "util/cgroup.h"
+#include "util/strlist.h"
 #include <bpf/bpf.h>
 
 #include "bpf_skel/off_cpu.skel.h"
@@ -125,6 +126,8 @@ int off_cpu_prepare(struct evlist *evlist, struct target *target,
 {
 	int err, fd, i;
 	int ncpus = 1, ntasks = 1, ncgrps = 1;
+	struct strlist *pid_slist = NULL;
+	struct str_node *pos;
 
 	if (off_cpu_config(evlist) < 0) {
 		pr_err("Failed to config off-cpu BPF event\n");
@@ -143,7 +146,26 @@ int off_cpu_prepare(struct evlist *evlist, struct target *target,
 		bpf_map__set_max_entries(skel->maps.cpu_filter, ncpus);
 	}
 
-	if (target__has_task(target)) {
+	if (target->pid) {
+		pid_slist = strlist__new(target->pid, NULL);
+		if (!pid_slist) {
+			pr_err("Failed to create a strlist for pid\n");
+			return -1;
+		}
+
+		ntasks = 0;
+		strlist__for_each_entry(pos, pid_slist) {
+			char *end_ptr;
+			int pid = strtol(pos->s, &end_ptr, 10);
+
+			if (pid == INT_MIN || pid == INT_MAX ||
+			    (*end_ptr != '\0' && *end_ptr != ','))
+				continue;
+
+			ntasks++;
+		}
+		bpf_map__set_max_entries(skel->maps.task_filter, ntasks);
+	} else if (target__has_task(target)) {
 		ntasks = perf_thread_map__nr(evlist->core.threads);
 		bpf_map__set_max_entries(skel->maps.task_filter, ntasks);
 	}
@@ -185,7 +207,26 @@ int off_cpu_prepare(struct evlist *evlist, struct target *target,
 		}
 	}
 
-	if (target__has_task(target)) {
+	if (target->pid) {
+		u8 val = 1;
+
+		skel->bss->has_task = 1;
+		skel->bss->uses_tgid = 1;
+		fd = bpf_map__fd(skel->maps.task_filter);
+
+		strlist__for_each_entry(pos, pid_slist) {
+			char *end_ptr;
+			u32 tgid;
+			int pid = strtol(pos->s, &end_ptr, 10);
+
+			if (pid == INT_MIN || pid == INT_MAX ||
+			    (*end_ptr != '\0' && *end_ptr != ','))
+				continue;
+
+			tgid = pid;
+			bpf_map_update_elem(fd, &tgid, &val, BPF_ANY);
+		}
+	} else if (target__has_task(target)) {
 		u32 pid;
 		u8 val = 1;
 
-- 
2.37.1.595.g718a3a8f04-goog

