Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED4EC5B3E41
	for <lists+bpf@lfdr.de>; Fri,  9 Sep 2022 19:53:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231808AbiIIRwt (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 9 Sep 2022 13:52:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231752AbiIIRwr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 9 Sep 2022 13:52:47 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73DE712EDA5;
        Fri,  9 Sep 2022 10:52:46 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id 9so2454328plj.11;
        Fri, 09 Sep 2022 10:52:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date;
        bh=R/Un3jPNK+3vfi+QVT0kN6ybavOhwptFNDHmeMY+Fvg=;
        b=Al1HQQaG1N7GdsJGbw2dOJLsEx3YgSO0Q6jb4gNJOTrscMphMfJemXgv2d0CYIzmT9
         m0pHa+Mn/4xIw5FSp5aBdR7j0kISDswJqIPGdwdaquENe2WRAAYHLgO7nhqSubf/bHcw
         xw8UAZQtu/BWhIu3sE81VZpH5k32q+l/k2DLQbqbIXP+v37HyRsVFD/gLVOaDbImJnFF
         iTmgJaIm3C/+XXs2tSbQh1q/xQOaySGbj3NFtnpcI2bIrfVRib3dHWYnOOKsws0ACAMY
         Yf4F/R6V6SX98GmbHmHd0dlOu8ohxme4egLJXs1oYqfO8mRvONcG4NBhLNjXBICwdGGJ
         Ya1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date;
        bh=R/Un3jPNK+3vfi+QVT0kN6ybavOhwptFNDHmeMY+Fvg=;
        b=b/dUYNla1IwQWaoXYbuLuVkNO0/jifKgY9Qs1eSiyKMn1UxtWm5TWbauE4Kej9wOna
         69SGDmDfr6JLhv6cyV8cn1A93aTbM0kH8FvBoC5rYNC3Q+Dj9lPBXLnWEsz+7JOCmdEN
         uot6SxFPWu56VTgc9wCcGucgs+5I1gZBUQJGu/jfcfOfy0VY3WWXpjOjQwTXBZ05kBpH
         Xsxfua1NeUOZ7jzhUKIZXjNOHFIKc5i/FLhvNp5IecmizQqWgqemS/dlrjOWDSom3ebP
         14Xv5WK38DAaSmG61ITgy7Nvpce8tK8SnaH1Cq6HTUMtE1H+/8d0xovfshwqKyDSb3hU
         MbLQ==
X-Gm-Message-State: ACgBeo1bLRworYAbQZTmlmjPqf8vPA5Seu0Zu7wE0ytILOeKgQ091bOc
        GHoME26AdYvTB8RlocdnjF8rASxuzwA=
X-Google-Smtp-Source: AA6agR4sv30OTSZPB0uPYzoQ1BvrUivAsPMPIQ4EcOhO4kvfCjFvYQVvAhe0wZDzWSua9CG/6D1YNg==
X-Received: by 2002:a17:902:e78e:b0:175:5313:2a46 with SMTP id cp14-20020a170902e78e00b0017553132a46mr15163924plb.53.1662745965901;
        Fri, 09 Sep 2022 10:52:45 -0700 (PDT)
Received: from youngsil.svl.corp.google.com ([2620:15c:2d4:203:b77b:e812:1879:ec2f])
        by smtp.gmail.com with ESMTPSA id w207-20020a627bd8000000b0052d46b43006sm4275pfc.156.2022.09.09.10.52.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Sep 2022 10:52:45 -0700 (PDT)
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
Subject: [PATCH 3/3] perf test: Add a new test for perf stat cgroup BPF counter
Date:   Fri,  9 Sep 2022 10:52:39 -0700
Message-Id: <20220909175239.206268-4-namhyung@kernel.org>
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
In-Reply-To: <20220909175239.206268-1-namhyung@kernel.org>
References: <20220909175239.206268-1-namhyung@kernel.org>
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
2.37.2.789.g6183377224-goog

