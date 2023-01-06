Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CDD6660210
	for <lists+bpf@lfdr.de>; Fri,  6 Jan 2023 15:26:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234251AbjAFO0B (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 6 Jan 2023 09:26:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235022AbjAFOZw (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 6 Jan 2023 09:25:52 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3CD94166B
        for <bpf@vger.kernel.org>; Fri,  6 Jan 2023 06:25:50 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id v9-20020a259d89000000b007b515f139e0so1983636ybp.17
        for <bpf@vger.kernel.org>; Fri, 06 Jan 2023 06:25:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=kC1oBRAXE838EyqcFtArpyyQWxtXQZCkq8gbe8hpVg4=;
        b=DQbR51Biav8RW8cOre9crR/Cih3nKjqFKDEeGB3Vzb6WLdeL6VgDdEY0m9IzEDCgrN
         cpAKhqH/MyXqYXG58AMkrIMXmqOH9z1eFuRMnCKzMvISBKAJH+V9UESk4I5TAuvNYXEk
         0vHO4JLod2K+wj6DvdrtkZcdxfMvdsDMRzYMnpqZ98BOvclvUDCDI4bh72+5iOY4O+DX
         R1cMezttAzMW0x/PXmONyk0cmTVL7Ohf+gaRYzCZRwWjzu9ZtuYYU+cHiv/EHb/6fL7D
         lREvj57YppLZcivTMT7ICPNvpU2ba2yERIkGPY2Vq1wbOYbveGs+I2+CJBR7QrAOINNZ
         fIrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kC1oBRAXE838EyqcFtArpyyQWxtXQZCkq8gbe8hpVg4=;
        b=Lv25iCQrc/DJrpq8tu7d8/EwHR2VYjf3+NLm+81emsBNjOLdx8h/LmUNjqJ2L/sFS5
         GFNVxgHWnxS1l2lgfrgt8+f4dY0Ne4Qvh14w9I582ok1yFVScqDfNXZzXxq65k/De5rX
         SC1zdbdeWm+Nw9tMD2gcvJ7AEC3GkKyzclIWS4MNatY1t0iYlMVcZaoj7lJWKin1mc6e
         W1dCdIO61rcy09QgEtOZHiNHqEQGAUt2kBAN93+F7FvKXaCrI5ccgsEygE64qjJV3iFr
         F8K2uDq/QpXG0usT6T7OciYFrye927ZqiOeH2uC8iCD+AznDEzZwTLDXrU+0id+ugKEM
         bmOA==
X-Gm-Message-State: AFqh2kpVelmw4jeOvBS9CgkmP0r1RlFNdvAusL6FO79ZoXhorbTONBiI
        4OwFSsmru15Ip9C2Z/zWbxrHpOwOWONd
X-Google-Smtp-Source: AMrXdXssgHQfc2+9CJD0DISmI/eT1XOavZLaNqX+X6gT55ye+JxJrY74HJ53cDxcXjh9CaNg2Q33jZsFN+Pd
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:b317:a30:653a:18e5])
 (user=irogers job=sendgmr) by 2002:a81:9281:0:b0:391:ea94:ec9b with SMTP id
 j123-20020a819281000000b00391ea94ec9bmr149767ywg.57.1673015149991; Fri, 06
 Jan 2023 06:25:49 -0800 (PST)
Date:   Fri,  6 Jan 2023 06:25:36 -0800
Message-Id: <20230106142537.607399-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Subject: [PATCH v2 1/2] perf build: Properly guard libbpf includes
From:   Ian Rogers <irogers@google.com>
To:     Mike Leach <mike.leach@linaro.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, acme@kernel.org, irogers@google.com,
        peterz@infradead.org, mingo@redhat.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Including libbpf header files should be guarded by
HAVE_LIBBPF_SUPPORT. In bpf_counter.h, move the skeleton utilities
under HAVE_BPF_SKEL.

Fixes: d6a735ef3277 ("perf bpf_counter: Move common functions to bpf_counter.h")
Reported-by: Mike Leach <mike.leach@linaro.org>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-trace.c    |  2 +
 tools/perf/util/bpf_counter.h | 85 ++++++++++++++++++-----------------
 2 files changed, 46 insertions(+), 41 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 86e06f136f40..d21fe0f32a6d 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -16,7 +16,9 @@
 
 #include "util/record.h"
 #include <api/fs/tracing_path.h>
+#ifdef HAVE_LIBBPF_SUPPORT
 #include <bpf/bpf.h>
+#endif
 #include "util/bpf_map.h"
 #include "util/rlimit.h"
 #include "builtin.h"
diff --git a/tools/perf/util/bpf_counter.h b/tools/perf/util/bpf_counter.h
index 4dbf26408b69..9113c8bf5cb0 100644
--- a/tools/perf/util/bpf_counter.h
+++ b/tools/perf/util/bpf_counter.h
@@ -4,9 +4,12 @@
 
 #include <linux/list.h>
 #include <sys/resource.h>
+
+#ifdef HAVE_LIBBPF_SUPPORT
 #include <bpf/bpf.h>
 #include <bpf/btf.h>
 #include <bpf/libbpf.h>
+#endif
 
 struct evsel;
 struct target;
@@ -42,6 +45,47 @@ int bpf_counter__read(struct evsel *evsel);
 void bpf_counter__destroy(struct evsel *evsel);
 int bpf_counter__install_pe(struct evsel *evsel, int cpu_map_idx, int fd);
 
+static inline __u32 bpf_link_get_id(int fd)
+{
+	struct bpf_link_info link_info = { .id = 0, };
+	__u32 link_info_len = sizeof(link_info);
+
+	bpf_obj_get_info_by_fd(fd, &link_info, &link_info_len);
+	return link_info.id;
+}
+
+static inline __u32 bpf_link_get_prog_id(int fd)
+{
+	struct bpf_link_info link_info = { .id = 0, };
+	__u32 link_info_len = sizeof(link_info);
+
+	bpf_obj_get_info_by_fd(fd, &link_info, &link_info_len);
+	return link_info.prog_id;
+}
+
+static inline __u32 bpf_map_get_id(int fd)
+{
+	struct bpf_map_info map_info = { .id = 0, };
+	__u32 map_info_len = sizeof(map_info);
+
+	bpf_obj_get_info_by_fd(fd, &map_info, &map_info_len);
+	return map_info.id;
+}
+
+/* trigger the leader program on a cpu */
+static inline int bperf_trigger_reading(int prog_fd, int cpu)
+{
+	DECLARE_LIBBPF_OPTS(bpf_test_run_opts, opts,
+			    .ctx_in = NULL,
+			    .ctx_size_in = 0,
+			    .flags = BPF_F_TEST_RUN_ON_CPU,
+			    .cpu = cpu,
+			    .retval = 0,
+		);
+
+	return bpf_prog_test_run_opts(prog_fd, &opts);
+}
+
 #else /* HAVE_BPF_SKEL */
 
 #include <linux/err.h>
@@ -87,45 +131,4 @@ static inline void set_max_rlimit(void)
 	setrlimit(RLIMIT_MEMLOCK, &rinf);
 }
 
-static inline __u32 bpf_link_get_id(int fd)
-{
-	struct bpf_link_info link_info = { .id = 0, };
-	__u32 link_info_len = sizeof(link_info);
-
-	bpf_obj_get_info_by_fd(fd, &link_info, &link_info_len);
-	return link_info.id;
-}
-
-static inline __u32 bpf_link_get_prog_id(int fd)
-{
-	struct bpf_link_info link_info = { .id = 0, };
-	__u32 link_info_len = sizeof(link_info);
-
-	bpf_obj_get_info_by_fd(fd, &link_info, &link_info_len);
-	return link_info.prog_id;
-}
-
-static inline __u32 bpf_map_get_id(int fd)
-{
-	struct bpf_map_info map_info = { .id = 0, };
-	__u32 map_info_len = sizeof(map_info);
-
-	bpf_obj_get_info_by_fd(fd, &map_info, &map_info_len);
-	return map_info.id;
-}
-
-/* trigger the leader program on a cpu */
-static inline int bperf_trigger_reading(int prog_fd, int cpu)
-{
-	DECLARE_LIBBPF_OPTS(bpf_test_run_opts, opts,
-			    .ctx_in = NULL,
-			    .ctx_size_in = 0,
-			    .flags = BPF_F_TEST_RUN_ON_CPU,
-			    .cpu = cpu,
-			    .retval = 0,
-		);
-
-	return bpf_prog_test_run_opts(prog_fd, &opts);
-}
-
 #endif /* __PERF_BPF_COUNTER_H */
-- 
2.39.0.314.g84b9a713c41-goog

