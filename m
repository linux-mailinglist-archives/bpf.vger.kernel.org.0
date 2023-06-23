Return-Path: <bpf+bounces-3274-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EEA573B9C2
	for <lists+bpf@lfdr.de>; Fri, 23 Jun 2023 16:18:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A04741C21260
	for <lists+bpf@lfdr.de>; Fri, 23 Jun 2023 14:18:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E511C2DB;
	Fri, 23 Jun 2023 14:16:33 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C0A79441
	for <bpf@vger.kernel.org>; Fri, 23 Jun 2023 14:16:33 +0000 (UTC)
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com [IPv6:2001:4860:4864:20::2d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5752D1BC6;
	Fri, 23 Jun 2023 07:16:32 -0700 (PDT)
Received: by mail-oa1-x2d.google.com with SMTP id 586e51a60fabf-1a991886254so557923fac.2;
        Fri, 23 Jun 2023 07:16:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687529791; x=1690121791;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mUX+eNaIsY1dCSY5M/dWpNxYFFpDcEU4gYYhWrPWXOA=;
        b=JkK4hR8qd0peqaVuUqe0oWMXg284QvQKB4FpaYbZrYPTOs5y2XIW3f4PrGvqW9ncZ1
         iDRmtPMbKoioctbgNs88WydCZWC1fRnv10g6EEWe0i4I+Px0tYdPm3DPkVtyxD3iuw1+
         oxGOr14xK84Dvc2R7K6++yPBXG1+fFl535qN2JksDfDE9PXK3s6T3KxUgmLFKMnTG+Zq
         Mz9ckHeOYJkO2FSRW3vi2wUXooNSvCdB7CS7vykWB8MKGH6NFiftIaECjvo31zb93VxG
         c/miyNVjlY+FkPT0jS9MPeQFnejIpJ2qTI5vQUN8zYdYiGXFmCfffS/jga99kgUIxOOa
         fXlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687529791; x=1690121791;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mUX+eNaIsY1dCSY5M/dWpNxYFFpDcEU4gYYhWrPWXOA=;
        b=bjw4DF1CDS4RS7Js7Sbh9q4+uxC05SHAWInEGnNgqYALSpzE6v1NaLJ6Vzja/v2dw6
         kpL8JrdofsBm15YH5jymCli2+7uE244p5QtnrxvDlGpCnrVQoWIOmr6mgbM8+Q1PmR86
         QBAX9IkhX1QUPMNhNR2Mf6lrngNmkO1nhZuyyBfKu6U/1fCAtlCZrRH3CEzKfZF8hVvR
         8c3pnW/mVPjT1qdiCUdoAoQdCuJ7iSCvqrexgY9DrBxFyv2bvsP1uvnc2Wi/Eh5kYIab
         Z8VYaXbYflHf4VdJsKthPID/12YcshfjFLV8Us3jVq8YnWFZ0anvCU4NSIpEgXo8Ymkr
         Yn6Q==
X-Gm-Message-State: AC+VfDwxMYz2CCbYMoI4fK5eoovBVwNiZ1i9uIJP+FZ/sWyI1mKVDHNQ
	A4njNwyeFtGmQXZRUV/ra5A=
X-Google-Smtp-Source: ACHHUZ5D8E+x6QZx44clwxkP3FNsj559M0UdWNKUW8M8tUoDmUgVLoQBDbb9fp/zrF1HLYSn1k6org==
X-Received: by 2002:a05:6870:3895:b0:19a:2343:b69e with SMTP id y21-20020a056870389500b0019a2343b69emr17367598oan.40.1687529791543;
        Fri, 23 Jun 2023 07:16:31 -0700 (PDT)
Received: from vultr.guest ([2001:19f0:ac01:1058:5400:4ff:fe7c:972])
        by smtp.gmail.com with ESMTPSA id p14-20020a63e64e000000b005533c53f550sm6505942pgj.45.2023.06.23.07.16.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jun 2023 07:16:31 -0700 (PDT)
From: Yafang Shao <laoar.shao@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	yhs@fb.com,
	kpsingh@kernel.org,
	sdf@google.com,
	haoluo@google.com,
	jolsa@kernel.org,
	quentin@isovalent.com,
	rostedt@goodmis.org,
	mhiramat@kernel.org
Cc: bpf@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>,
	Jiri Olsa <olsajiri@gmail.com>
Subject: [PATCH v5 bpf-next 10/11] bpftool: Add perf event names
Date: Fri, 23 Jun 2023 14:15:45 +0000
Message-Id: <20230623141546.3751-11-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20230623141546.3751-1-laoar.shao@gmail.com>
References: <20230623141546.3751-1-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Add new functions and macros to get perf event names. These names are
copied from tool/perf/util/{parse-events,evsel}.c, so that in the future we
will have a good chance to use the same code.

Suggested-by: Jiri Olsa <olsajiri@gmail.com>
Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 tools/bpf/bpftool/link.c | 67 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 67 insertions(+)

diff --git a/tools/bpf/bpftool/link.c b/tools/bpf/bpftool/link.c
index 8461e6d..e5aeee3 100644
--- a/tools/bpf/bpftool/link.c
+++ b/tools/bpf/bpftool/link.c
@@ -5,6 +5,7 @@
 #include <linux/err.h>
 #include <linux/netfilter.h>
 #include <linux/netfilter_arp.h>
+#include <linux/perf_event.h>
 #include <net/if.h>
 #include <stdio.h>
 #include <unistd.h>
@@ -19,6 +20,72 @@
 static struct hashmap *link_table;
 static struct dump_data dd = {};
 
+static const char *perf_type_name[PERF_TYPE_MAX] = {
+	[PERF_TYPE_HARDWARE]			= "hardware",
+	[PERF_TYPE_SOFTWARE]			= "software",
+	[PERF_TYPE_TRACEPOINT]			= "tracepoint",
+	[PERF_TYPE_HW_CACHE]			= "hw-cache",
+	[PERF_TYPE_RAW]				= "raw",
+	[PERF_TYPE_BREAKPOINT]			= "breakpoint",
+};
+
+const char *event_symbols_hw[PERF_COUNT_HW_MAX] = {
+	[PERF_COUNT_HW_CPU_CYCLES]		= "cpu-cycles",
+	[PERF_COUNT_HW_INSTRUCTIONS]		= "instructions",
+	[PERF_COUNT_HW_CACHE_REFERENCES]	= "cache-references",
+	[PERF_COUNT_HW_CACHE_MISSES]		= "cache-misses",
+	[PERF_COUNT_HW_BRANCH_INSTRUCTIONS]	= "branch-instructions",
+	[PERF_COUNT_HW_BRANCH_MISSES]		= "branch-misses",
+	[PERF_COUNT_HW_BUS_CYCLES]		= "bus-cycles",
+	[PERF_COUNT_HW_STALLED_CYCLES_FRONTEND]	= "stalled-cycles-frontend",
+	[PERF_COUNT_HW_STALLED_CYCLES_BACKEND]	= "stalled-cycles-backend",
+	[PERF_COUNT_HW_REF_CPU_CYCLES]		= "ref-cycles",
+};
+
+const char *event_symbols_sw[PERF_COUNT_SW_MAX] = {
+	[PERF_COUNT_SW_CPU_CLOCK]		= "cpu-clock",
+	[PERF_COUNT_SW_TASK_CLOCK]		= "task-clock",
+	[PERF_COUNT_SW_PAGE_FAULTS]		= "page-faults",
+	[PERF_COUNT_SW_CONTEXT_SWITCHES]	= "context-switches",
+	[PERF_COUNT_SW_CPU_MIGRATIONS]		= "cpu-migrations",
+	[PERF_COUNT_SW_PAGE_FAULTS_MIN]		= "minor-faults",
+	[PERF_COUNT_SW_PAGE_FAULTS_MAJ]		= "major-faults",
+	[PERF_COUNT_SW_ALIGNMENT_FAULTS]	= "alignment-faults",
+	[PERF_COUNT_SW_EMULATION_FAULTS]	= "emulation-faults",
+	[PERF_COUNT_SW_DUMMY]			= "dummy",
+	[PERF_COUNT_SW_BPF_OUTPUT]		= "bpf-output",
+	[PERF_COUNT_SW_CGROUP_SWITCHES]		= "cgroup-switches",
+};
+
+const char *evsel__hw_cache[PERF_COUNT_HW_CACHE_MAX] = {
+	[PERF_COUNT_HW_CACHE_L1D]		= "L1-dcache",
+	[PERF_COUNT_HW_CACHE_L1I]		= "L1-icache",
+	[PERF_COUNT_HW_CACHE_LL]		= "LLC",
+	[PERF_COUNT_HW_CACHE_DTLB]		= "dTLB",
+	[PERF_COUNT_HW_CACHE_ITLB]		= "iTLB",
+	[PERF_COUNT_HW_CACHE_BPU]		= "branch",
+	[PERF_COUNT_HW_CACHE_NODE]		= "node",
+};
+
+const char *evsel__hw_cache_op[PERF_COUNT_HW_CACHE_OP_MAX] = {
+	[PERF_COUNT_HW_CACHE_OP_READ]		= "load",
+	[PERF_COUNT_HW_CACHE_OP_WRITE]		= "store",
+	[PERF_COUNT_HW_CACHE_OP_PREFETCH]	= "prefetch",
+};
+
+const char *evsel__hw_cache_result[PERF_COUNT_HW_CACHE_RESULT_MAX] = {
+	[PERF_COUNT_HW_CACHE_RESULT_ACCESS]	= "refs",
+	[PERF_COUNT_HW_CACHE_RESULT_MISS]	= "misses",
+};
+
+#define perf_event_name(array, id) ({			\
+	const char *event_str = NULL;			\
+							\
+	if ((id) >= 0 && (id) < ARRAY_SIZE(array))	\
+		event_str = array[id];			\
+	event_str;					\
+})
+
 static int link_parse_fd(int *argc, char ***argv)
 {
 	int fd;
-- 
1.8.3.1


