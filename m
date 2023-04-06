Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 754E66DA45E
	for <lists+bpf@lfdr.de>; Thu,  6 Apr 2023 23:06:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237369AbjDFVGV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 6 Apr 2023 17:06:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237133AbjDFVGT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 6 Apr 2023 17:06:19 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABBEC8A51;
        Thu,  6 Apr 2023 14:06:18 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id p3-20020a17090a74c300b0023f69bc7a68so41851980pjl.4;
        Thu, 06 Apr 2023 14:06:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680815178; x=1683407178;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zxgVwiXvPJlNQaBMQo/Fw6ZQAn8/5u3aWEkaLTlJ8CU=;
        b=GPg6on8Y7wICuJC6Y8Yy09cCC7BXBxhXNQJKNIBSxkW+EK2MzySsLg9arYaqG4SqYl
         K4hy2H6oisP/93sUeLh0zv8A8LvhaYXpOBcznkiv506kVZIAIEv9ggrmztaBRGCVekdW
         2C4EkJgp7WaX5E1dI4lQaxdmNlmPoOQnXLT+PlgNHMaIf+J2bu5NvTwtV4Sqe1GnunrK
         jzgOKCZyC6/ols+Kwi3Z8pCrs8zHrKqxctEHGXS+E5zzSb8RSB7CgUrmZ5+eG2evHQFm
         o6Q/15MlUptNRyjVczPF7r9EKq4YqdSCSpYJgeBSq71CDxCeP14XtzXaNO1m5HlJIrN/
         lzbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680815178; x=1683407178;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zxgVwiXvPJlNQaBMQo/Fw6ZQAn8/5u3aWEkaLTlJ8CU=;
        b=EP5feL0ib6QEp6PQBV++/6Za9+ov7yA84VaCvJ9TtIGmd7nLN3k3q48u1Cfi1gGaaJ
         4IAx81O5C1oK0lGGaMUq83opNg1TO9p/rxZVS22JVNI5nAzUh0mb6zfC+rbUFgZj1UOn
         BNhG4fLXdOVDCe3Wlb9qPqsqNCUSUzI8+1erQMiqQ5L6BU/rFYSUV9BgJ9RRDJ0dInZl
         CeXpR8t0gUPdimUpCHoWZ1JzDxJ8X2wGWn8UZGmioQkK5R/VqNG38ZnEa6ulSnWZi6cX
         8SYcMg7OErtPt836oSGOhsH0qQc7miqXz4rk2lCazUEVjBusW69+OPVYwG2/BRyyfG6e
         +8lw==
X-Gm-Message-State: AAQBX9feH1DT8XC2oqxI1i8I+GZgD1Gv2QZxWEYKbeXCqv7SKDaWNy9R
        mL5Ukn5/9VnQSXm6ebml9rc=
X-Google-Smtp-Source: AKy350bjW0oXlp9NKLeowSyWW9oHMCv07TYsBSV9lHFASWNW0gpeNrkPIWh52Tofm9GqKD2IPk6icw==
X-Received: by 2002:a17:902:ce88:b0:19e:2fb0:a5d9 with SMTP id f8-20020a170902ce8800b0019e2fb0a5d9mr7367025plg.32.1680815177855;
        Thu, 06 Apr 2023 14:06:17 -0700 (PDT)
Received: from moohyul.svl.corp.google.com ([2620:15c:2d4:203:3301:38fe:e39e:3d51])
        by smtp.gmail.com with ESMTPSA id g5-20020a170902868500b001a0667822c8sm1777837plo.94.2023.04.06.14.06.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Apr 2023 14:06:17 -0700 (PDT)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
Cc:     Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org, Song Liu <song@kernel.org>,
        Hao Luo <haoluo@google.com>, bpf@vger.kernel.org,
        Juri Lelli <juri.lelli@redhat.com>
Subject: [PATCH 3/7] perf lock contention: Update default map size to 16384
Date:   Thu,  6 Apr 2023 14:06:07 -0700
Message-Id: <20230406210611.1622492-4-namhyung@kernel.org>
X-Mailer: git-send-email 2.40.0.577.gac1e443424-goog
In-Reply-To: <20230406210611.1622492-1-namhyung@kernel.org>
References: <20230406210611.1622492-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The BPF hash map will align the map size to a power of 2.  So 10k would
be 16k anyway.  Let's have the actual size to avoid confusions.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/Documentation/perf-lock.txt         | 3 ++-
 tools/perf/builtin-lock.c                      | 2 +-
 tools/perf/util/bpf_skel/lock_contention.bpf.c | 5 +----
 tools/perf/util/bpf_skel/lock_data.h           | 3 +++
 4 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/tools/perf/Documentation/perf-lock.txt b/tools/perf/Documentation/perf-lock.txt
index b5e5d088d51c..6e5ba3cd2b72 100644
--- a/tools/perf/Documentation/perf-lock.txt
+++ b/tools/perf/Documentation/perf-lock.txt
@@ -157,7 +157,8 @@ CONTENTION OPTIONS
 
 -M::
 --map-nr-entries=<value>::
-	Maximum number of BPF map entries (default: 10240).
+	Maximum number of BPF map entries (default: 16384).
+	This will be aligned to a power of 2.
 
 --max-stack=<value>::
 	Maximum stack depth when collecting lock contention (default: 8).
diff --git a/tools/perf/builtin-lock.c b/tools/perf/builtin-lock.c
index ef56bf90058d..9b92c7a5aefb 100644
--- a/tools/perf/builtin-lock.c
+++ b/tools/perf/builtin-lock.c
@@ -60,7 +60,7 @@ static bool show_thread_stats;
 static bool show_lock_addrs;
 static bool show_lock_owner;
 static bool use_bpf;
-static unsigned long bpf_map_entries = 10240;
+static unsigned long bpf_map_entries = MAX_ENTRIES;
 static int max_stack_depth = CONTENTION_STACK_DEPTH;
 static int stack_skip = CONTENTION_STACK_SKIP;
 static int print_nr_entries = INT_MAX / 2;
diff --git a/tools/perf/util/bpf_skel/lock_contention.bpf.c b/tools/perf/util/bpf_skel/lock_contention.bpf.c
index 3f4ee3992e81..f9d2d792ccc8 100644
--- a/tools/perf/util/bpf_skel/lock_contention.bpf.c
+++ b/tools/perf/util/bpf_skel/lock_contention.bpf.c
@@ -7,9 +7,6 @@
 
 #include "lock_data.h"
 
-/* default buffer size */
-#define MAX_ENTRIES  10240
-
 /* for collect_lock_syms().  4096 was rejected by the verifier */
 #define MAX_CPUS  1024
 
@@ -63,7 +60,7 @@ struct {
 	__uint(type, BPF_MAP_TYPE_HASH);
 	__uint(key_size, sizeof(__u64));
 	__uint(value_size, sizeof(__u32));
-	__uint(max_entries, 16384);
+	__uint(max_entries, MAX_ENTRIES);
 } lock_syms SEC(".maps");
 
 struct {
diff --git a/tools/perf/util/bpf_skel/lock_data.h b/tools/perf/util/bpf_skel/lock_data.h
index 1ba61cb4d480..260062a9f2ab 100644
--- a/tools/perf/util/bpf_skel/lock_data.h
+++ b/tools/perf/util/bpf_skel/lock_data.h
@@ -15,6 +15,9 @@ struct contention_task_data {
 	char comm[TASK_COMM_LEN];
 };
 
+/* default buffer size */
+#define MAX_ENTRIES  16384
+
 /*
  * Upper bits of the flags in the contention_data are used to identify
  * some well-known locks which do not have symbols (non-global locks).
-- 
2.40.0.577.gac1e443424-goog

