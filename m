Return-Path: <bpf+bounces-2939-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 85EB27371B6
	for <lists+bpf@lfdr.de>; Tue, 20 Jun 2023 18:34:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B656D1C20BF4
	for <lists+bpf@lfdr.de>; Tue, 20 Jun 2023 16:34:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CBDA1DDD5;
	Tue, 20 Jun 2023 16:30:40 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C80C18C3F
	for <bpf@vger.kernel.org>; Tue, 20 Jun 2023 16:30:40 +0000 (UTC)
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com [IPv6:2001:4860:4864:20::2e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7E471726;
	Tue, 20 Jun 2023 09:30:36 -0700 (PDT)
Received: by mail-oa1-x2e.google.com with SMTP id 586e51a60fabf-1a49716e9c5so4880387fac.1;
        Tue, 20 Jun 2023 09:30:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687278635; x=1689870635;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+yg3oyB1aA8EDGcuJKMbke6ndCq042NOuKuhG7HtCWg=;
        b=LmDEI2GJ6daj42TcQdHOfDcLrbzLSubN76eoGAZPfPyE1WWZU+nhmqSYwLKS/pPYnL
         eSzcc4WnrWsge3DKC1wstjCLwL50Ag7tLcrNco1ZiFjRyzFr8gXK+dvMeuad25OsRLDP
         nim8kv7lAPkC3oJyTBa7gjeFzdOjWAYr35EQDkkAkabXzShc+aOVT4Ps6V12F+bl11TF
         fVrdCTm+yINKeEJo17zBADNuHd2HWfVTHY6nqxUGZApVOmbdtSIgGYrrj6iiBqbu61QY
         aPHu9JBjS2qlxl+t6r4lUyg4ep8hBLmqTuKGmoCl0SQ5dEbfXin9ed5qsWMg+8UAYlm9
         rXvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687278635; x=1689870635;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+yg3oyB1aA8EDGcuJKMbke6ndCq042NOuKuhG7HtCWg=;
        b=hWzRQRGQkm2uPC26tz0KoAEh79+nN3zFigjUaxp12LrT5KYkI80dQ6QVJrc6hfd2Ub
         RtgGk3FLbjPU2LV8HXX2C/QfeAFf/TANCfSPbuahTMayHPdPA3y3m550U6DhTZM8GN5L
         U8KOWH//YNB9l2CnGDhoErUW/610KiYVtEp2YHV3k4zhRTaKv22f9uPZjRJCox+9nACo
         5LgX1SsmW507xqPwXKkMS7zaCIyq9r12anvBzRpJLHUINDn/9RBgWV/J0+QKQ3N2+3+X
         FqrEFxlrw6OsH8qPv7P2TJtSZnpqf+3nRbigb/mIqIApJMBfP0atWJAK/9fxqu7KtgDe
         3qkQ==
X-Gm-Message-State: AC+VfDzGA1RSbFd1GeB98PM9NGzIgAdxMZ1nFVc05/4DTcSwrn+F0df3
	2i86/D0sBJTlHRMkPPi6lao=
X-Google-Smtp-Source: ACHHUZ4l0Nkewmd6HpHHCkwMRB/Uu1WXwvsoLgxJajd4WtNILtL8MyCpzCEJ6285aKko2gufSoqCrw==
X-Received: by 2002:a54:4090:0:b0:398:4a82:76e1 with SMTP id i16-20020a544090000000b003984a8276e1mr13371472oii.36.1687278635392;
        Tue, 20 Jun 2023 09:30:35 -0700 (PDT)
Received: from vultr.guest ([2001:19f0:ac02:b96:5400:4ff:fe7b:3b23])
        by smtp.gmail.com with ESMTPSA id t8-20020a17090a3b4800b0025c1cfdb93esm1854286pjf.13.2023.06.20.09.30.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jun 2023 09:30:34 -0700 (PDT)
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
Subject: [PATCH v4 bpf-next 10/11] bpftool: Add perf event names
Date: Tue, 20 Jun 2023 16:30:07 +0000
Message-Id: <20230620163008.3718-11-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20230620163008.3718-1-laoar.shao@gmail.com>
References: <20230620163008.3718-1-laoar.shao@gmail.com>
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
index 90b51de..9274d59 100644
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


