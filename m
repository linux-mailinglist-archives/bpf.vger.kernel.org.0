Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 873696BA3AA
	for <lists+bpf@lfdr.de>; Wed, 15 Mar 2023 00:43:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230415AbjCNXn3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 14 Mar 2023 19:43:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230153AbjCNXnP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 14 Mar 2023 19:43:15 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC11041095;
        Tue, 14 Mar 2023 16:42:53 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id x11so18252355pln.12;
        Tue, 14 Mar 2023 16:42:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678837373;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FFnAoyfpXLJ85wVKVk68j2EdKRKyiS6g/ArZlkxtTRo=;
        b=RkoV55+De2mUl77Ox/ZtUfAfqdTQAEOjZodzQ+51fsZHCBCRx0Bfo8yi41sxYL9/EY
         jEsqLFL/r9q+R8YUdR3oe8ztC613oVnhiTdAjoGuGeb5RwDaKL5EOs6Z0UAoUaTy5v+f
         m98Vm/uKUJZDSdEFv27dtsHcXTlwysILZXEumAWdsgA9O2gOptpwqLoYcoGgGTnR96TA
         Scly6/RMGzxFeqfs2Oxp2TJJFOx4LhcpOFu2gKz9PCW/wEohWYK/Gcd9YufcW+yhEWeY
         eNWNy7WLEox0NcQcPmTRhBLliJG3Y2SgkSEBuFtyUBqTBTUWlCWoGcuOrNFqf6mDUxZw
         j/Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678837373;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FFnAoyfpXLJ85wVKVk68j2EdKRKyiS6g/ArZlkxtTRo=;
        b=c4bc0rSR97le3WZZFiSKqSoKa0UwDc5PiYR6ZKgb9fzjSPTlsv6Miy1KNuskicsZEI
         XpC5nDV7owZHwN4BLJCd/r2D3QsUQCVMnQV7c6OWBWuXiI5KSpGB23cAaAbzkmdHtepI
         Uj/2clKpiYzFhcdd/NMZVZMDUgaOFybS40Gu+OK4c+BeDhLVtk/3NZHYP3I3DKH/SvVf
         ur+utbTk+a+GHRZHfqAyoWr63o7pRvRqhxLF/sYdj2J/w8/DPsf9t5geMceq0rggHQr/
         xpTuyNdFcIMXroYDiygfRj6qrsJF61L16r00XvmrA4V0JBmFXVBFwQzydcPYrSGAIOEC
         A7fQ==
X-Gm-Message-State: AO0yUKWCqZIIyRpy2upe/axRXqR0ylYBLz/uJMrpuniup6c83atq0A21
        lIhx0Nc/SqjsmEsVfLNgb1c=
X-Google-Smtp-Source: AK7set80nH9ENZKU/iAEZlc5wGC3RY3TZHfNIZbqmfOa7p2zLrPNLhd16hpi9syDt6IBNcZltbs4ww==
X-Received: by 2002:a17:90b:1b52:b0:237:b64c:6bb3 with SMTP id nv18-20020a17090b1b5200b00237b64c6bb3mr41623994pjb.11.1678837372919;
        Tue, 14 Mar 2023 16:42:52 -0700 (PDT)
Received: from moohyul.svl.corp.google.com ([2620:15c:2d4:203:3826:a5cd:1f1d:6c85])
        by smtp.gmail.com with ESMTPSA id ik13-20020a170902ab0d00b0019f39e4f120sm2280806plb.18.2023.03.14.16.42.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Mar 2023 16:42:52 -0700 (PDT)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Song Liu <song@kernel.org>,
        Stephane Eranian <eranian@google.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Leo Yan <leo.yan@linaro.org>,
        James Clark <james.clark@arm.com>, Hao Luo <haoluo@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org, bpf@vger.kernel.org
Subject: [PATCH 10/10] perf record: Update documentation for BPF filters
Date:   Tue, 14 Mar 2023 16:42:37 -0700
Message-Id: <20230314234237.3008956-11-namhyung@kernel.org>
X-Mailer: git-send-email 2.40.0.rc1.284.g88254d51c5-goog
In-Reply-To: <20230314234237.3008956-1-namhyung@kernel.org>
References: <20230314234237.3008956-1-namhyung@kernel.org>
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

Add more description and examples.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/Documentation/perf-record.txt | 47 +++++++++++++++++++++++-
 1 file changed, 46 insertions(+), 1 deletion(-)

diff --git a/tools/perf/Documentation/perf-record.txt b/tools/perf/Documentation/perf-record.txt
index 122f71726eaa..680396c56bd1 100644
--- a/tools/perf/Documentation/perf-record.txt
+++ b/tools/perf/Documentation/perf-record.txt
@@ -183,7 +183,52 @@ OPTIONS
 
 	A BPF filter can access the sample data and make a decision based on the
 	data.  Users need to set an appropriate sample type to use the BPF
-	filter.
+	filter.  BPF filters need root privilege.
+
+	The sample data field can be specified in lower case letter.  Multiple
+	filters can be separated with comma.  For example,
+
+	  --filter 'period > 1000, cpu == 1'
+	or
+	  --filter 'mem_op == load || mem_op == store, mem_lvl > l1'
+
+	The former filter only accept samples with period greater than 1000 AND
+	CPU number is 1.  The latter one accepts either load and store memory
+	operations but it should have memory level above the L1.  Since the
+	mem_op and mem_lvl fields come from the (memory) data_source, it'd only
+	work with some events which set the data_source field.
+
+	Also user should request to collect that information (with -d option in
+	the above case).  Otherwise, the following message will be shown.
+
+	  $ sudo perf record -e cycles --filter 'mem_op == load'
+	  Error: cycles event does not have PERF_SAMPLE_DATA_SRC
+	   Hint: please add -d option to perf record.
+	  failed to set filter "BPF" on event cycles with 22 (Invalid argument)
+
+	Essentially the BPF filter expression is:
+
+	  <term> <operator> <value> (("," | "||") <term> <operator> <value>)*
+
+	The <term> can be one of:
+	  ip, id, tid, pid, cpu, time, addr, period, txn, weight, phys_addr,
+	  code_pgsz, data_pgsz, weight1, weight2, weight3, ins_lat, retire_lat,
+	  p_stage_cyc, mem_op, mem_lvl, mem_snoop, mem_remote, mem_lock,
+	  mem_dtlb, mem_blk, mem_hops
+
+	The <operator> can be one of:
+	  ==, !=, >, >=, <, <=, &
+
+	The <value> can be one of:
+	  <number> (for any term)
+	  na, load, store, pfetch, exec (for mem_op)
+	  l1, l2, l3, l4, cxl, io, any_cache, lfb, ram, pmem (for mem_lvl)
+	  na, none, hit, miss, hitm, fwd, peer (for mem_snoop)
+	  remote (for mem_remote)
+	  na, locked (for mem_locked)
+	  na, l1_hit, l1_miss, l2_hit, l2_miss, any_hit, any_miss, walk, fault (for mem_dtlb)
+	  na, by_data, by_addr (for mem_blk)
+	  hops0, hops1, hops2, hops3 (for mem_hops)
 
 --exclude-perf::
 	Don't record events issued by perf itself. This option should follow
-- 
2.40.0.rc1.284.g88254d51c5-goog

