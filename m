Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E94A31C8E0D
	for <lists+bpf@lfdr.de>; Thu,  7 May 2020 16:11:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727953AbgEGOLX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 7 May 2020 10:11:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728083AbgEGOI3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 7 May 2020 10:08:29 -0400
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEC04C05BD0C
        for <bpf@vger.kernel.org>; Thu,  7 May 2020 07:08:28 -0700 (PDT)
Received: by mail-qv1-xf4a.google.com with SMTP id cr5so5971610qvb.14
        for <bpf@vger.kernel.org>; Thu, 07 May 2020 07:08:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=A2CqCWbomYGlREhGlvIy2Wyy+nj5upT0ckyyzFHG6Ps=;
        b=PL3FBnz4OOA6yzb+55sssITuWyhhXK8/iDtmURZAsKlGMrSA8upcA1OtUFeEGBQiER
         BDN0joRB6PXCYxrS0J9zg08hUOcV13opx30b+HGs/oHICoaP9WwVByOePDN0G8bMmOOr
         x5eR/F6kUcONDt1+BkKBKzTMqaDc0x2WEQbmsGBk2O0bF1PuwG1T1ckFLuDEL2cDzSRm
         cEVZCpd4MN4Imcvo5o0ZCBRXPulR09oc1xE9zmhik3TXZ8D7q4pjZYdhGYjzSMIIHj1z
         Ha2tRfxP9CKo92M9mROEebOFNhyhnrtMV74+9YTzm6i0w8OQ6W7smBTZdN68HIxNUGqd
         VY5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=A2CqCWbomYGlREhGlvIy2Wyy+nj5upT0ckyyzFHG6Ps=;
        b=sPrFkRxzg230wghrlzkmwvyecmC9cRXsKC9gFSWxj+RnN/bLaZoL9dkJuT8HivVKjb
         8VP85YvrmwqKgCdq7nKz4mkblu4cfSxe6wvZEv7kzTIs/vkuTrIEBQmKomCa/7YOP74P
         HlaZFQMDZZFz1z04GP5J1dJRw9CdHbH0tte6EWD+uXuaGhe00cudgalt8OL3yo1Hi9gU
         kurjWlSWeMbnq5yMthZd/07YAcCu/2AZbgugdknKJsqZwHSVr9Pk8Y7TzqCutZAJ4qpQ
         s8bDsp0sk35Q/7xjNMu4l8ypYBECxbDfGz6Sa19n5zhBghRot+P13hXNE4mML3kbJMYY
         TN0A==
X-Gm-Message-State: AGi0PuaxHdWfp1EUgUY6D092J3a83MRndk/5bx3krnMmyh0DIs+SeY5b
        keDAieB86/WVKVn24FZ0ShsI0/sLCXrC
X-Google-Smtp-Source: APiQypIBfLjchnGbgpejIe7/sa8aDyyTZfrkSafjpmLT6hYdPcXCkCK0r3M9Ed4tSV1IZJCkYFgvQL6J3FbE
X-Received: by 2002:a05:6214:8ec:: with SMTP id dr12mr2009360qvb.121.1588860507707;
 Thu, 07 May 2020 07:08:27 -0700 (PDT)
Date:   Thu,  7 May 2020 07:07:58 -0700
In-Reply-To: <20200507140819.126960-1-irogers@google.com>
Message-Id: <20200507140819.126960-3-irogers@google.com>
Mime-Version: 1.0
References: <20200507140819.126960-1-irogers@google.com>
X-Mailer: git-send-email 2.26.2.526.g744177e7f7-goog
Subject: [RFC PATCH v2 02/23] perf metrics: fix parse errors in cascade lake metrics
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Kajol Jain <kjain@linux.ibm.com>,
        Andi Kleen <ak@linux.intel.com>,
        John Garry <john.garry@huawei.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Kim Phillips <kim.phillips@amd.com>,
        linux-kernel@vger.kernel.org
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Remove over escaping with \\.
Remove extraneous if 1 if 0 == 1 else 0 else 0.

Fixes: fd5500989c8f (perf vendor events intel: Update metrics from TMAM 3.5)
Signed-off-by: Ian Rogers <irogers@google.com>
---
 .../pmu-events/arch/x86/cascadelakex/clx-metrics.json  | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/cascadelakex/clx-metrics.json b/tools/perf/pmu-events/arch/x86/cascadelakex/clx-metrics.json
index 7fde0d2943cd..d25eebce34c9 100644
--- a/tools/perf/pmu-events/arch/x86/cascadelakex/clx-metrics.json
+++ b/tools/perf/pmu-events/arch/x86/cascadelakex/clx-metrics.json
@@ -328,31 +328,31 @@
     },
     {
         "BriefDescription": "Average latency of data read request to external memory (in nanoseconds). Accounts for demand loads and L1/L2 prefetches",
-        "MetricExpr": "1000000000 * ( cha@event\\=0x36\\\\\\,umask\\=0x21@ / cha@event\\=0x35\\\\\\,umask\\=0x21@ ) / ( cha_0@event\\=0x0@ / duration_time )",
+        "MetricExpr": "1000000000 * ( cha@event\\=0x36\\,umask\\=0x21@ / cha@event\\=0x35\\,umask\\=0x21@ ) / ( cha_0@event\\=0x0@ / duration_time )",
         "MetricGroup": "Memory_Lat",
         "MetricName": "DRAM_Read_Latency"
     },
     {
         "BriefDescription": "Average number of parallel data read requests to external memory. Accounts for demand loads and L1/L2 prefetches",
-        "MetricExpr": "cha@event\\=0x36\\\\\\,umask\\=0x21@ / cha@event\\=0x36\\\\\\,umask\\=0x21\\\\\\,thresh\\=1@",
+        "MetricExpr": "cha@event\\=0x36\\,umask\\=0x21@ / cha@event\\=0x36\\,umask\\=0x21\\,thresh\\=1@",
         "MetricGroup": "Memory_BW",
         "MetricName": "DRAM_Parallel_Reads"
     },
     {
         "BriefDescription": "Average latency of data read request to external 3D X-Point memory [in nanoseconds]. Accounts for demand loads and L1/L2 data-read prefetches",
-        "MetricExpr": "( 1000000000 * ( imc@event\\=0xe0\\\\\\,umask\\=0x1@ / imc@event\\=0xe3@ ) / imc_0@event\\=0x0@ ) if 1 if 0 == 1 else 0 else 0",
+        "MetricExpr": "( 1000000000 * ( imc@event\\=0xe0\\,umask\\=0x1@ / imc@event\\=0xe3@ ) / imc_0@event\\=0x0@ )",
         "MetricGroup": "Memory_Lat",
         "MetricName": "MEM_PMM_Read_Latency"
     },
     {
         "BriefDescription": "Average 3DXP Memory Bandwidth Use for reads [GB / sec]",
-        "MetricExpr": "( ( 64 * imc@event\\=0xe3@ / 1000000000 ) / duration_time ) if 1 if 0 == 1 else 0 else 0",
+        "MetricExpr": "( ( 64 * imc@event\\=0xe3@ / 1000000000 ) / duration_time )",
         "MetricGroup": "Memory_BW",
         "MetricName": "PMM_Read_BW"
     },
     {
         "BriefDescription": "Average 3DXP Memory Bandwidth Use for Writes [GB / sec]",
-        "MetricExpr": "( ( 64 * imc@event\\=0xe7@ / 1000000000 ) / duration_time ) if 1 if 0 == 1 else 0 else 0",
+        "MetricExpr": "( ( 64 * imc@event\\=0xe7@ / 1000000000 ) / duration_time )",
         "MetricGroup": "Memory_BW",
         "MetricName": "PMM_Write_BW"
     },
-- 
2.26.2.526.g744177e7f7-goog

