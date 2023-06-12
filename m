Return-Path: <bpf+bounces-2414-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66AFE72C9A3
	for <lists+bpf@lfdr.de>; Mon, 12 Jun 2023 17:17:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 128C5281094
	for <lists+bpf@lfdr.de>; Mon, 12 Jun 2023 15:17:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A433B1DDF2;
	Mon, 12 Jun 2023 15:16:33 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74F2919511
	for <bpf@vger.kernel.org>; Mon, 12 Jun 2023 15:16:33 +0000 (UTC)
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC8F8E5F;
	Mon, 12 Jun 2023 08:16:26 -0700 (PDT)
Received: by mail-qv1-xf32.google.com with SMTP id 6a1803df08f44-62b671e0a0dso30655296d6.1;
        Mon, 12 Jun 2023 08:16:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686582986; x=1689174986;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J4o/ujNBffQluZLgK8PAKCwIeuiFgex/iYZvXGfAS/o=;
        b=DESA7ZGwbmHUDJsTbustftcRp7e7gqkSP3OcqVCNE4W33CcDI0pjTO5jl+SZRB3miE
         3cnquGYXHZ/o3tI3d1SFw5AAQQZZzuNnHa1cStvmcE/+6KeziEwybJsvkoZ8GXx2xttS
         nPQN+Z/L3fUtDgjvm8/nt8b3uObDHPHJhu+E4NrJMol/i55d/WmMg7OYsQouorp54AbC
         rSng+sSHqE+WTqQEf1bFKODIajOIR9gMldigfFPdLyrXOgjbLByt5lnw3owRQK5G5LmG
         lz2Q9X1hebnxTjQUJSno8qr8eZmDRY2d3dn2g0e4b/SAHIWdpLMBQdGiJaUrlzZ4+IlL
         xJ9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686582986; x=1689174986;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J4o/ujNBffQluZLgK8PAKCwIeuiFgex/iYZvXGfAS/o=;
        b=T++g1i23Jxaqh7Ar6ypcicGJ+dAO0tKa7LMsiuwom+5Lgfa0lNZ1SyCc1dHFg7IrEo
         7hI8hQv0M8xvLUyW/Ma98xqzAlcPwI7V9uHfPUN/noAUQ66EO71Tvg3mJN5FPdv047VW
         mD64JU4S12T4qFEIeOkPRZnAw+0o/MBYDeWCXnEiin1sRmSW7isQQF/UBASLZ4OcsPZr
         VItox1Xml5OBbnUAPLgNhsFVSTrunUw8JwtiVkf1pFYsy4UMDvhaQ3G0fLLCUtX1Nygo
         hkW/77oQP6/S+Civ5j1b9B/wtJCZdsV9m7HHycwuZEjFrBpkFA5fLf3uCd4fYVgjRuJ7
         Ie6g==
X-Gm-Message-State: AC+VfDxvMlmnry0qU802GFTvjBFCWnxTJtXE26DHKeIxkHZw/8x75Umu
	qxEdelVGpU1ZB9/2RojO58g=
X-Google-Smtp-Source: ACHHUZ6/Ca7uEzoPbZX+VimYeKRMREZrQry3oY5SmSq4H7rAbfirMxXSYwvPCPkTq++xff53cYykcA==
X-Received: by 2002:a05:6214:d4b:b0:623:c96a:e735 with SMTP id 11-20020a0562140d4b00b00623c96ae735mr13088356qvr.1.1686582985789;
        Mon, 12 Jun 2023 08:16:25 -0700 (PDT)
Received: from vultr.guest ([108.61.23.146])
        by smtp.gmail.com with ESMTPSA id o17-20020a0cf4d1000000b0062de0dde008sm1533953qvm.64.2023.06.12.08.16.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 08:16:25 -0700 (PDT)
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
Subject: [PATCH v3 bpf-next 09/10] bpftool: Add perf event names
Date: Mon, 12 Jun 2023 15:16:07 +0000
Message-Id: <20230612151608.99661-10-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20230612151608.99661-1-laoar.shao@gmail.com>
References: <20230612151608.99661-1-laoar.shao@gmail.com>
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
 tools/bpf/bpftool/perf.c | 107 +++++++++++++++++++++++++++++++++++++++++++++++
 tools/bpf/bpftool/perf.h |  11 +++++
 2 files changed, 118 insertions(+)
 create mode 100644 tools/bpf/bpftool/perf.h

diff --git a/tools/bpf/bpftool/perf.c b/tools/bpf/bpftool/perf.c
index 9174344..fbdf88c 100644
--- a/tools/bpf/bpftool/perf.c
+++ b/tools/bpf/bpftool/perf.c
@@ -18,6 +18,113 @@
 #include <bpf/bpf.h>
 
 #include "main.h"
+#include "perf.h"
+
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
+const char *perf_type_str(enum perf_type_id t)
+{
+	if (t < 0 || t >= ARRAY_SIZE(perf_type_name))
+		return NULL;
+
+	return perf_type_name[t];
+}
+
+const char *perf_hw_str(enum perf_hw_id t)
+{
+	if (t < 0 || t >= ARRAY_SIZE(event_symbols_hw))
+		return NULL;
+
+	return event_symbols_hw[t];
+}
+
+const char *perf_hw_cache_str(enum perf_hw_cache_id t)
+{
+	if (t < 0 || t >= ARRAY_SIZE(evsel__hw_cache))
+		return NULL;
+
+	return evsel__hw_cache[t];
+}
+
+const char *perf_hw_cache_op_str(enum perf_hw_cache_op_id t)
+{
+	if (t < 0 || t >= ARRAY_SIZE(evsel__hw_cache_op))
+		return NULL;
+
+	return evsel__hw_cache_op[t];
+}
+
+const char *perf_hw_cache_op_result_str(enum perf_hw_cache_op_result_id t)
+{
+	if (t < 0 || t >= ARRAY_SIZE(evsel__hw_cache_result))
+		return NULL;
+
+	return evsel__hw_cache_result[t];
+}
+
+const char *perf_sw_str(enum perf_sw_ids t)
+{
+	if (t < 0 || t >= ARRAY_SIZE(event_symbols_sw))
+		return NULL;
+
+	return event_symbols_sw[t];
+}
 
 /* 0: undecided, 1: supported, 2: not supported */
 static int perf_query_supported;
diff --git a/tools/bpf/bpftool/perf.h b/tools/bpf/bpftool/perf.h
new file mode 100644
index 0000000..3fd7e42
--- /dev/null
+++ b/tools/bpf/bpftool/perf.h
@@ -0,0 +1,11 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+/* Copyright (C) 2023 Yafang Shao <laoar.shao@gmail.com> */
+
+#include <linux/perf_event.h>
+
+const char *perf_type_str(enum perf_type_id t);
+const char *perf_hw_str(enum perf_hw_id t);
+const char *perf_hw_cache_str(enum perf_hw_cache_id t);
+const char *perf_hw_cache_op_str(enum perf_hw_cache_op_id t);
+const char *perf_hw_cache_op_result_str(enum perf_hw_cache_op_result_id t);
+const char *perf_sw_str(enum perf_sw_ids t);
-- 
1.8.3.1


