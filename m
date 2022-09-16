Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB3725BB251
	for <lists+bpf@lfdr.de>; Fri, 16 Sep 2022 20:41:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230194AbiIPSlv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 16 Sep 2022 14:41:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230212AbiIPSlq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 16 Sep 2022 14:41:46 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A383CB8A52;
        Fri, 16 Sep 2022 11:41:41 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id ge9so10362528pjb.1;
        Fri, 16 Sep 2022 11:41:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date;
        bh=0/bkNBIX3FOAe3t6O/p7ZuS8G0HQozWMCrCw3+mytvI=;
        b=GvEkctg++Q6fJds7LzttNVl0aKX4dNXXNkoMO0dhUrNIjoZ9wvpwE+Hd9/C1fZiJXL
         bDXHvObELfjOqhy9FrzfJE730SLk9vD2A2m5uvjZo93kZixkWCrgBTFdg8V6EqUDv/a2
         0pLvmgGeWMYD5KmbPTR5IzfOGw6wsoZUPgzLe4ZQyS7vYuwOuzeJPaf4WyzyQYD6n9xM
         m8WLYBFjQampXy0PM7+SO7gV2ECyPCHx4LmSMam3RwNBJ20+0ZoeDJBS2bXBM4jsaiph
         JGbTS+47OTz1mnCyc62iCu29Mkj7bf3JtS3Q9egCkhIA4kwpwTy8ZW+lHhgVLAEwmmXC
         KQhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date;
        bh=0/bkNBIX3FOAe3t6O/p7ZuS8G0HQozWMCrCw3+mytvI=;
        b=jxOMmMxMSIkKC0j3L1UADTb0m4knNptCB/YOwOcFvSi4Zk4EcsARbcxLFYDdNgeWII
         coJcLdBuV373oNJDrQMpVeibeN2rNiFRoDwVpSpGTYFLRxpWHUsEBgbg5DTf3OCB+dmF
         +cQooU5mMkgkpWPFrMWrCWYLmiiYTtaiHE9omq/Miy+NEXUvPpAfcVXckMHDM68xFRVA
         dqWN5qePXgqR6eWrjg0OcCCFnBKNpoDDujVrJ6dD40NwWzbZmijKWwAEaen514GVJLDX
         a4ehg2/tqiytuLUQi5rkaEqSB0+aiqxR4OWsNa+xSbnY4dABjhmP3m3kmRCRFi6zTMtw
         kLgA==
X-Gm-Message-State: ACrzQf1nPUH7q1SPrFSfvhCvkcOKf3KXUPbcKUDVFPrlU45V3e1LVGC1
        +4AiHw1yeLxFNkxgvIY1g2Gzc3Mxm9k=
X-Google-Smtp-Source: AMsMyM7jcgvmzEsZVo12t0OpJ0R1AciFz3zwCi5TRJg0s+6ib/GU+qgvBWSJXeDOaB7b7chBonw2uw==
X-Received: by 2002:a17:90b:4c45:b0:202:6308:d9c4 with SMTP id np5-20020a17090b4c4500b002026308d9c4mr6982509pjb.40.1663353700675;
        Fri, 16 Sep 2022 11:41:40 -0700 (PDT)
Received: from youngsil.svl.corp.google.com ([2620:15c:2d4:203:2952:dee7:a35e:6428])
        by smtp.gmail.com with ESMTPSA id y18-20020a170902b49200b0016dcbdf9492sm15093004plr.92.2022.09.16.11.41.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Sep 2022 11:41:40 -0700 (PDT)
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
Subject: [PATCH 4/4] perf test: Add a new test for perf stat cgroup BPF counter
Date:   Fri, 16 Sep 2022 11:41:32 -0700
Message-Id: <20220916184132.1161506-5-namhyung@kernel.org>
X-Mailer: git-send-email 2.37.3.968.ga6b4b080e4-goog
In-Reply-To: <20220916184132.1161506-1-namhyung@kernel.org>
References: <20220916184132.1161506-1-namhyung@kernel.org>
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

  $ sudo ./perf test -v each-cgroup
   96: perf stat --bpf-counters --for-each-cgroup test                 :
  --- start ---
  test child forked, pid 79600
  test child finished with 0
  ---- end ----
  perf stat --bpf-counters --for-each-cgroup test: Ok

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 .../tests/shell/stat_bpf_counters_cgrp.sh     | 83 +++++++++++++++++++
 1 file changed, 83 insertions(+)
 create mode 100755 tools/perf/tests/shell/stat_bpf_counters_cgrp.sh

diff --git a/tools/perf/tests/shell/stat_bpf_counters_cgrp.sh b/tools/perf/tests/shell/stat_bpf_counters_cgrp.sh
new file mode 100755
index 000000000000..d724855d097c
--- /dev/null
+++ b/tools/perf/tests/shell/stat_bpf_counters_cgrp.sh
@@ -0,0 +1,83 @@
+#!/bin/sh
+# perf stat --bpf-counters --for-each-cgroup test
+# SPDX-License-Identifier: GPL-2.0
+
+set -e
+
+test_cgroups=
+if [ "$1" = "-v" ]; then
+	verbose="1"
+fi
+
+# skip if --bpf-counters --for-each-cgroup is not supported
+check_bpf_counter()
+{
+	if ! perf stat -a --bpf-counters --for-each-cgroup / true > /dev/null 2>&1; then
+		if [ "${verbose}" = "1" ]; then
+			echo "Skipping: --bpf-counters --for-each-cgroup not supported"
+			perf --no-pager stat -a --bpf-counters --for-each-cgroup / true || true
+		fi
+		exit 2
+	fi
+}
+
+# find two cgroups to measure
+find_cgroups()
+{
+	# try usual systemd slices first
+	if [ -d /sys/fs/cgroup/system.slice -a -d /sys/fs/cgroup/user.slice ]; then
+		test_cgroups="system.slice,user.slice"
+		return
+	fi
+
+	# try root and self cgroups
+	local self_cgrp=$(grep perf_event /proc/self/cgroup | cut -d: -f3)
+	if [ -z ${self_cgrp} ]; then
+		# cgroup v2 doesn't specify perf_event
+		self_cgrp=$(grep ^0: /proc/self/cgroup | cut -d: -f3)
+	fi
+
+	if [ -z ${self_cgrp} ]; then
+		test_cgroups="/"
+	else
+		test_cgroups="/,${self_cgrp}"
+	fi
+}
+
+# As cgroup events are cpu-wide, we cannot simply compare the result.
+# Just check if it runs without failure and has non-zero results.
+check_system_wide_counted()
+{
+	local output
+
+	output=$(perf stat -a --bpf-counters --for-each-cgroup ${test_cgroups} -e cpu-clock -x, sleep 1  2>&1)
+	if echo ${output} | grep -q -F "<not "; then
+		echo "Some system-wide events are not counted"
+		if [ "${verbose}" = "1" ]; then
+			echo ${output}
+		fi
+		exit 1
+	fi
+}
+
+check_cpu_list_counted()
+{
+	local output
+
+	output=$(perf stat -C 1 --bpf-counters --for-each-cgroup ${test_cgroups} -e cpu-clock -x, taskset -c 1 sleep 1  2>&1)
+	if echo ${output} | grep -q -F "<not "; then
+		echo "Some CPU events are not counted"
+		if [ "${verbose}" = "1" ]; then
+			echo ${output}
+		fi
+		exit 1
+	fi
+}
+
+check_bpf_counter
+find_cgroups
+
+check_system_wide_counted
+check_cpu_list_counted
+
+exit 0
-- 
2.37.3.968.ga6b4b080e4-goog

