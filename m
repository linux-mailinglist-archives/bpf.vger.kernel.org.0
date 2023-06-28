Return-Path: <bpf+bounces-3661-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E4AD8741082
	for <lists+bpf@lfdr.de>; Wed, 28 Jun 2023 13:55:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F11D280E2A
	for <lists+bpf@lfdr.de>; Wed, 28 Jun 2023 11:55:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2A7BC2E5;
	Wed, 28 Jun 2023 11:53:52 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D19D4BA32
	for <bpf@vger.kernel.org>; Wed, 28 Jun 2023 11:53:52 +0000 (UTC)
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3979430C0;
	Wed, 28 Jun 2023 04:53:51 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-66f3fc56ef4so617918b3a.0;
        Wed, 28 Jun 2023 04:53:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687953230; x=1690545230;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bZbLxco0Ofu4f2+jSlKqxXwiBG58604fkff8iqQqj3g=;
        b=Je17GfKPsUaJwNgDjv8NofN7dGzKWM8JuZwCDPH/+6hFcQ1mkslZ8lMMxgPf+K68sM
         LWfgnQ4nhpjthCplMD7L3t+Jcrj2ul8FM05x5TYx+q2orgRVPWl0K1qAu4uarU9cGgmp
         bc0qRL6I55+NZMiee4LqIW5TmxYiuBB2NqywC7XBSk6nhXoAQsyy1E6F9vp83kRRgizM
         NQaTs1dtFWHwJgANJaOvjcaNQToB0gyx1MA1d77zv4sP/aFd/RqPRzi3M1499SRMHVkK
         18MW2CHFG7ED8Su+lFISh3NNMDdlMzL3FcrN1Px9jD1Cy6MjuylIo1E+DwAFBFercvGv
         bJxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687953230; x=1690545230;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bZbLxco0Ofu4f2+jSlKqxXwiBG58604fkff8iqQqj3g=;
        b=jMocGsGapyAMQWqUbSF0E2nTqahNgAbomd4ZSCTOKY0vICBKAnCA+c4h0C50yuoTWT
         v64gQsSaMNjpzzJoZoZSYQ/lfG1lduQx9ZHn0C0QQ/TgPSOIqKGlJw6kDk/T681yCVA7
         HnCd3eaD9ibiK/xi20rGkJFCJgNsO2PkpMMz+8VabXzbp7ZqWNeXTdAqlNinUUPM1Ssy
         8qZLZQJqeie7Moj1K1zF0NVGc6gIOowVY/79rhAmuy1ftyIQ601sI4yrWZumYr9tE1Mx
         63sCxrGH2/8qxtIO/aAIMvjd2fJ15mu9bXTVOLcgDqEVbSY68uHrjAeYzEsveemPrrcq
         IYww==
X-Gm-Message-State: AC+VfDyjF3SuW8RrqE+Yn12pqxo+X880NxvApHg0YuexLQDCTcKDNF2r
	leXkPqKXi5gCQ6q5YOkmhyk=
X-Google-Smtp-Source: ACHHUZ67zh7HBk77qFYds65CxDQBGAX+6IDuifKway3Tykvx/cOVl1hOq8O+/Ink3l3rLAbisHZ8fw==
X-Received: by 2002:a17:90b:4fcc:b0:262:eb20:2dd8 with SMTP id qa12-20020a17090b4fcc00b00262eb202dd8mr1319105pjb.20.1687953230659;
        Wed, 28 Jun 2023 04:53:50 -0700 (PDT)
Received: from vultr.guest ([2001:19f0:ac02:b79:5400:4ff:fe7d:3e26])
        by smtp.gmail.com with ESMTPSA id n91-20020a17090a5ae400b002471deb13fcsm8000504pji.6.2023.06.28.04.53.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jun 2023 04:53:50 -0700 (PDT)
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
Subject: [PATCH v6 bpf-next 10/11] bpftool: Add perf event names
Date: Wed, 28 Jun 2023 11:53:28 +0000
Message-Id: <20230628115329.248450-11-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20230628115329.248450-1-laoar.shao@gmail.com>
References: <20230628115329.248450-1-laoar.shao@gmail.com>
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

Add new functions and macros to get perf event names. These names except
the perf_type_name are all copied from
tool/perf/util/{parse-events,evsel}.c, so that in the future we will
have a good chance to use the same code.

Suggested-by: Jiri Olsa <olsajiri@gmail.com>
Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
Reviewed-by: Quentin Monnet <quentin@isovalent.com>
---
 tools/bpf/bpftool/link.c | 67 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 67 insertions(+)

diff --git a/tools/bpf/bpftool/link.c b/tools/bpf/bpftool/link.c
index 34fa17cd9d2a..ba67ea9d77fb 100644
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
2.39.3


