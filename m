Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 913C01C8E0A
	for <lists+bpf@lfdr.de>; Thu,  7 May 2020 16:11:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728066AbgEGOLB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 7 May 2020 10:11:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728103AbgEGOIe (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 7 May 2020 10:08:34 -0400
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F8A5C05BD10
        for <bpf@vger.kernel.org>; Thu,  7 May 2020 07:08:30 -0700 (PDT)
Received: by mail-qt1-x849.google.com with SMTP id d35so6851559qtc.20
        for <bpf@vger.kernel.org>; Thu, 07 May 2020 07:08:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=T1oY202fZuRBk7edtCBgt9wERwBLTlqKZ66WoSf5lZY=;
        b=f2yVzmCHXRdeuATp6UNXLsr9j3vzi+Fv2Pc89/g7pt6XFIZ6WPUU4+XdZMsW7DVnF4
         n2yZWIQNIU5uqr+QnGNi+54MDJHMCWmbz2aEHJzBHDHNSpzBjA+CBfwG7Z59S/rpdkPG
         LRP5O+hDySUXieGDfzzT//qs6ihTwulTSUtefd8x5FObJPRVzJXVd4QcN330/hjd5ClY
         NhpLete2Rc2Yo/B6a+rGhWPckBE91Xb8xmV8Mire4qGR+afiBQH4cNzelPKX1KAbaf4j
         NTdOMBmo0exMGpP1rC3C3K3g3ZQSEcEPqXl443gJphFVGOQ9u1D//QClKbOKVbY7+eLV
         JByQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=T1oY202fZuRBk7edtCBgt9wERwBLTlqKZ66WoSf5lZY=;
        b=SlGCmlPNEUXtbX0c29/6Y3Y1VvCB3Bsrt0aOKcEQMTG+CyUIH66JDlFGN7eR+8L0kP
         TsEOxlrOh9Jp/HQdPMnv0bHydvLC/UCMivpoa8U/6s+h3j9dJyRZ6y22EAizbIxYQKgr
         Rxk+WEQSMzBQviGwW995ljK4ylCgdEx0FGJJCDHd77PiCqANxHp9phvqV0R3WHWsFyDj
         rWU6KJK6IAuhaVs1bOcLR8Kpr5DWhTPK8EAUzDtgj3DWDl4rgzUPiCzP+us226vatbCd
         1gwcc+Jd+KZGqAno5AaYdzLoRh0O1cY9yKB9d5OXKrYrZbVEXtMBuzr5fs39lRkvZv8G
         yYyA==
X-Gm-Message-State: AGi0Pub58Fbg7pa5+a+aAl4NBDCSIbDkA5+fnoQOaE64sreeJR75cAR7
        H5khW45uN/t1gWfysRdYmPz1DDnWn9Q1
X-Google-Smtp-Source: APiQypKv4Wz5aiAH7yNT+t1Ra+WCZoSjlEFRIBMgUe/3Qo7oXj9ACmTXXXNfvkVwVq5B54XWjvc0IQzGw+4b
X-Received: by 2002:a05:6214:1262:: with SMTP id r2mr13718869qvv.126.1588860509690;
 Thu, 07 May 2020 07:08:29 -0700 (PDT)
Date:   Thu,  7 May 2020 07:07:59 -0700
In-Reply-To: <20200507140819.126960-1-irogers@google.com>
Message-Id: <20200507140819.126960-4-irogers@google.com>
Mime-Version: 1.0
References: <20200507140819.126960-1-irogers@google.com>
X-Mailer: git-send-email 2.26.2.526.g744177e7f7-goog
Subject: [RFC PATCH v2 03/23] perf metrics: fix parse errors in skylake metrics
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

Fixes: fd5500989c8f (perf vendor events intel: Update metrics from TMAM 3.5)
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/arch/x86/skylakex/skx-metrics.json | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/skylakex/skx-metrics.json b/tools/perf/pmu-events/arch/x86/skylakex/skx-metrics.json
index b4f91137f40c..390bdab1be9d 100644
--- a/tools/perf/pmu-events/arch/x86/skylakex/skx-metrics.json
+++ b/tools/perf/pmu-events/arch/x86/skylakex/skx-metrics.json
@@ -328,13 +328,13 @@
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
-- 
2.26.2.526.g744177e7f7-goog

