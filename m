Return-Path: <bpf+bounces-4520-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E8A6974C081
	for <lists+bpf@lfdr.de>; Sun,  9 Jul 2023 04:58:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A37F828102C
	for <lists+bpf@lfdr.de>; Sun,  9 Jul 2023 02:58:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8311A256C;
	Sun,  9 Jul 2023 02:56:58 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CB5A23BC
	for <bpf@vger.kernel.org>; Sun,  9 Jul 2023 02:56:58 +0000 (UTC)
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56852E46;
	Sat,  8 Jul 2023 19:56:57 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-666fb8b1bc8so2845488b3a.1;
        Sat, 08 Jul 2023 19:56:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688871417; x=1691463417;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lmn/J0m18ChUNDG/jbgxTf8qt/gy0+Rcvl4FysRc17s=;
        b=iG30GLEwKUVXpgrlWpKzj1MkKwo9CBiDRco/LA3H8spD2XlPEt7FPL3VwlGWGVlHAy
         o2bn07B7xbZwD85oo7mgJbbQzz1iTmvkLchKeKkC09X8rBWsORtBHAoQx/3UYQGmybT3
         AxZWM3ThEgw8ItdbruhmEUSSGu8PCtJYUoWFx1xUqmiSHcMGdMLpvhAJ4lsZ1y56a3Oy
         fpgFYpQktqCAnEkrmQ9Iu+5N2TahLjpry7FlgamHfGNV4beTR3kx+WcDzHR2b9FEe3Hr
         xjseWWC44HGZLVoT7W/cIBgJtKD8ooesiBcSrml/Gx7mJ82AYQa0DHqwjF7CD+3M+2+9
         8Hpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688871417; x=1691463417;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lmn/J0m18ChUNDG/jbgxTf8qt/gy0+Rcvl4FysRc17s=;
        b=BnFtg6W5OYBl6fSvqDZmAaIFrupq+XnaNZXJ7nlc59/kVkxEvY/P9AcaX/eRMt1UAk
         NGw16mVj68tKmKT5E9UOavIG0mqZl2l3w6KL4XR9tZIEfdgbJDz0+wI2xuOzkd6vxY+4
         FuUJ5Is2Q39XntouuTc18qN2IIUZ0GU0AYEnkwESnfT7QeraWHJtJ2H1iMqyw6xJcMJw
         Jv146AVlSt2/1fpwe8cv9VruXeZ+MCF+5pyrd9t5AGkQ/5FfNeCWR08JTziVTsk0VMm0
         YTUVc7KGlXgBJ2fw/LnzBH/34RwXJdTNuiQFeccBPZLNM8LcOHbZl6NF0ehSO6KeoaMM
         GsWw==
X-Gm-Message-State: ABy/qLaMi8HhgQLPtedeo3bUeO4H+OgfGUQ76LQNApaR7nk0WYB4W5xQ
	jXJ5YPt3jrmwlyxTX7Wes0U=
X-Google-Smtp-Source: APBJJlEt8F7/3IeKeoQKunK70wYNQiLJs6f+BseKejb/EGTtwLQeSWO1V148eLwWX7mLBhnyz35Efw==
X-Received: by 2002:a05:6a00:b51:b0:668:8545:cbeb with SMTP id p17-20020a056a000b5100b006688545cbebmr13048378pfo.15.1688871416758;
        Sat, 08 Jul 2023 19:56:56 -0700 (PDT)
Received: from vultr.guest ([2001:19f0:ac01:14bb:5400:4ff:fe80:41df])
        by smtp.gmail.com with ESMTPSA id e9-20020aa78249000000b00682ad247e5fsm5043421pfn.179.2023.07.08.19.56.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Jul 2023 19:56:56 -0700 (PDT)
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
Subject: [PATCH v7 bpf-next 09/10] bpftool: Add perf event names
Date: Sun,  9 Jul 2023 02:56:29 +0000
Message-Id: <20230709025630.3735-10-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20230709025630.3735-1-laoar.shao@gmail.com>
References: <20230709025630.3735-1-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Add new functions and macros to get perf event names. These names except
the perf_type_name are all copied from
tool/perf/util/{parse-events,evsel}.c, so that in the future we will
have a good chance to use the same code.

Suggested-by: Jiri Olsa <olsajiri@gmail.com>
Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
Reviewed-by: Quentin Monnet <quentin@isovalent.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/bpf/bpftool/link.c | 67 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 67 insertions(+)

diff --git a/tools/bpf/bpftool/link.c b/tools/bpf/bpftool/link.c
index a4f5a436777f..8e4d9176a6e8 100644
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
 static struct dump_data dd;
 
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
2.30.1 (Apple Git-130)


