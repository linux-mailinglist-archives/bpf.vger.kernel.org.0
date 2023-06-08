Return-Path: <bpf+bounces-2110-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB003727CF7
	for <lists+bpf@lfdr.de>; Thu,  8 Jun 2023 12:37:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9660F281557
	for <lists+bpf@lfdr.de>; Thu,  8 Jun 2023 10:37:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F5FE1094D;
	Thu,  8 Jun 2023 10:35:47 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14FB1C8FD
	for <bpf@vger.kernel.org>; Thu,  8 Jun 2023 10:35:47 +0000 (UTC)
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C31C0272D
	for <bpf@vger.kernel.org>; Thu,  8 Jun 2023 03:35:44 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id 6a1803df08f44-6260e8a1424so3507916d6.2
        for <bpf@vger.kernel.org>; Thu, 08 Jun 2023 03:35:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686220544; x=1688812544;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DM9iAlLzD6FAPOXhyqRgOn4jy8JggVrXZ+3w6h7Ykuw=;
        b=aewEulSOkyI57tFlqPY/eLFLU7F+cj8kZe51lL0ORZp5zZmXK3dVLl2HpmUrwNI9ud
         sDdeIGRYQhYj6Xca/7N/Ude4H5bdmShRXaUtJPaHdneDHb0GPN1FVUwW1E6KIkI1rYAt
         hqmqlLc++aXKiCVb+TT13owfMkacMquWYtYolnqM7YxNqKS7/TcvBsD8MrlwoUe+P7/8
         BZ6pRp5MCTr+oJifgjHd+hDhRfPWGX858BUgB4VA9pAPlHzkFwCLNH2swv3+OKZtboKE
         MtEaAW3GWRP/2X7Mx8vNQzbgW9AZovooqAnxWkUWKfWv1M20lxJpjzLP+1Giin4hdFCX
         +X1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686220544; x=1688812544;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DM9iAlLzD6FAPOXhyqRgOn4jy8JggVrXZ+3w6h7Ykuw=;
        b=REAxRoQUCXAoCl1UcIsYt02ZVyHnfgqF4LjgUounWKGDv2dWg6vvC7HYmoJFtfPwr0
         Z3vwqmhwuKLfRg99wXnQK2AcljJy3hEuDmP+jTfvTApm+Lah/dRmeb9qvhXrzOIGJ7EA
         op4Q0LAGMXQzQ4qLfsVjHVzvD/ph0zs5MPWBP9rcDbooH3LdAVWjYwmRspRB18PWCwZK
         1+Bv7lROMd3LS7idw65VVu4Vf4ETcKz8oK30LcJjFx4e6GIv1a5HY1qtOG1Ica75JXn1
         z8CDzH6tJ+sRqh/De692GNrlPZFK8idBRTt3XVeNfqGaZTSyPpGs8MN8T9uJbE+ITwXb
         Heyg==
X-Gm-Message-State: AC+VfDyoKHvQQir0zun+eGg38Bdrjnrj8fAMIhR7R8UiibIWn42lQ1x8
	YvoXFM6R6WiWwNHG4RUgM4+2/DmOsJvH2uyv9lY=
X-Google-Smtp-Source: ACHHUZ7/3MLtfL+S/ZSgA9WLZcEaTu3mtSl+t4TZfT+CrDv9x9HOs5R4Jcol7p838GWs+yYxjtVJBA==
X-Received: by 2002:a05:6214:19e1:b0:626:e55:dfad with SMTP id q1-20020a05621419e100b006260e55dfadmr1186473qvc.41.1686220543852;
        Thu, 08 Jun 2023 03:35:43 -0700 (PDT)
Received: from vultr.guest ([2001:19f0:1000:2418:5400:4ff:fe77:b548])
        by smtp.gmail.com with ESMTPSA id p16-20020a0cf550000000b0062839fc6e36sm302714qvm.70.2023.06.08.03.35.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jun 2023 03:35:43 -0700 (PDT)
From: Yafang Shao <laoar.shao@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	yhs@fb.com,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@google.com,
	haoluo@google.com,
	jolsa@kernel.org,
	quentin@isovalent.com
Cc: bpf@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH v2 bpf-next 09/11] libbpf: Add perf event names
Date: Thu,  8 Jun 2023 10:35:21 +0000
Message-Id: <20230608103523.102267-10-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20230608103523.102267-1-laoar.shao@gmail.com>
References: <20230608103523.102267-1-laoar.shao@gmail.com>
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

Add libbpf API to get generic perf event name.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 tools/lib/bpf/libbpf.c   | 107 +++++++++++++++++++++++++++++++++++++++++++++++
 tools/lib/bpf/libbpf.h   |  56 +++++++++++++++++++++++++
 tools/lib/bpf/libbpf.map |   6 +++
 3 files changed, 169 insertions(+)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 47632606..27d396f 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -119,6 +119,64 @@
 	[BPF_STRUCT_OPS]		= "struct_ops",
 };
 
+static const char * const perf_type_name[] = {
+	[PERF_TYPE_HARDWARE]		= "hardware",
+	[PERF_TYPE_SOFTWARE]		= "software",
+	[PERF_TYPE_TRACEPOINT]		= "tracepoint",
+	[PERF_TYPE_HW_CACHE]		= "hw_cache",
+	[PERF_TYPE_RAW]			= "raw",
+	[PERF_TYPE_BREAKPOINT]		= "breakpoint",
+};
+
+static const char * const perf_hw_name[] = {
+	[PERF_COUNT_HW_CPU_CYCLES]		= "cpu_cycles",
+	[PERF_COUNT_HW_INSTRUCTIONS]		= "instructions",
+	[PERF_COUNT_HW_CACHE_REFERENCES]	= "cache_references",
+	[PERF_COUNT_HW_CACHE_MISSES]		= "cache_misses",
+	[PERF_COUNT_HW_BRANCH_INSTRUCTIONS]	= "branch_instructions",
+	[PERF_COUNT_HW_BRANCH_MISSES]		= "branch_misses",
+	[PERF_COUNT_HW_BUS_CYCLES]		= "bus_cycles",
+	[PERF_COUNT_HW_STALLED_CYCLES_FRONTEND]	= "stalled_cycles_frontend",
+	[PERF_COUNT_HW_STALLED_CYCLES_BACKEND]	= "stalled_cycles_backend",
+	[PERF_COUNT_HW_REF_CPU_CYCLES]		= "ref_cpu_cycles",
+};
+
+static const char * const perf_hw_cache_name[] = {
+	[PERF_COUNT_HW_CACHE_L1D]		= "l1d",
+	[PERF_COUNT_HW_CACHE_L1I]		= "l1i",
+	[PERF_COUNT_HW_CACHE_LL]		= "ll",
+	[PERF_COUNT_HW_CACHE_DTLB]		= "dtlb",
+	[PERF_COUNT_HW_CACHE_ITLB]		= "itlb",
+	[PERF_COUNT_HW_CACHE_BPU]		= "bpu",
+	[PERF_COUNT_HW_CACHE_NODE]		= "node",
+};
+
+static const char * const perf_hw_cache_op_name[] = {
+	[PERF_COUNT_HW_CACHE_OP_READ]		= "read",
+	[PERF_COUNT_HW_CACHE_OP_WRITE]		= "write",
+	[PERF_COUNT_HW_CACHE_OP_PREFETCH]	= "prefetch",
+};
+
+static const char * const perf_hw_cache_op_result_name[] = {
+	[PERF_COUNT_HW_CACHE_RESULT_ACCESS]	= "access",
+	[PERF_COUNT_HW_CACHE_RESULT_MISS]	= "miss",
+};
+
+static const char * const perf_sw_name[] = {
+	[PERF_COUNT_SW_CPU_CLOCK]		= "cpu_clock",
+	[PERF_COUNT_SW_TASK_CLOCK]		= "task_clock",
+	[PERF_COUNT_SW_PAGE_FAULTS]		= "page_faults",
+	[PERF_COUNT_SW_CONTEXT_SWITCHES]	= "context_switches",
+	[PERF_COUNT_SW_CPU_MIGRATIONS]		= "cpu_migrations",
+	[PERF_COUNT_SW_PAGE_FAULTS_MIN]		= "page_faults_min",
+	[PERF_COUNT_SW_PAGE_FAULTS_MAJ]		= "page_faults_maj",
+	[PERF_COUNT_SW_ALIGNMENT_FAULTS]	= "alignment_faults",
+	[PERF_COUNT_SW_EMULATION_FAULTS]	= "emulation_faults",
+	[PERF_COUNT_SW_DUMMY]			= "dummy",
+	[PERF_COUNT_SW_BPF_OUTPUT]		= "bpf_output",
+	[PERF_COUNT_SW_CGROUP_SWITCHES]		= "cgroup_switches",
+};
+
 static const char * const link_type_name[] = {
 	[BPF_LINK_TYPE_UNSPEC]			= "unspec",
 	[BPF_LINK_TYPE_RAW_TRACEPOINT]		= "raw_tracepoint",
@@ -8953,6 +9011,55 @@ const char *libbpf_bpf_attach_type_str(enum bpf_attach_type t)
 	return attach_type_name[t];
 }
 
+const char *libbpf_perf_type_str(enum perf_type_id t)
+{
+	if (t < 0 || t >= ARRAY_SIZE(perf_type_name))
+		return NULL;
+
+	return perf_type_name[t];
+}
+
+const char *libbpf_perf_hw_str(enum perf_hw_id t)
+{
+	if (t < 0 || t >= ARRAY_SIZE(perf_hw_name))
+		return NULL;
+
+	return perf_hw_name[t];
+}
+
+const char *libbpf_perf_hw_cache_str(enum perf_hw_cache_id t)
+{
+	if (t < 0 || t >= ARRAY_SIZE(perf_hw_cache_name))
+		return NULL;
+
+	return perf_hw_cache_name[t];
+}
+
+const char *libbpf_perf_hw_cache_op_str(enum perf_hw_cache_op_id t)
+{
+	if (t < 0 || t >= ARRAY_SIZE(perf_hw_cache_op_name))
+		return NULL;
+
+	return perf_hw_cache_op_name[t];
+}
+
+const char *
+libbpf_perf_hw_cache_op_result_str(enum perf_hw_cache_op_result_id t)
+{
+	if (t < 0 || t >= ARRAY_SIZE(perf_hw_cache_op_result_name))
+		return NULL;
+
+	return perf_hw_cache_op_result_name[t];
+}
+
+const char *libbpf_perf_sw_str(enum perf_sw_ids t)
+{
+	if (t < 0 || t >= ARRAY_SIZE(perf_sw_name))
+		return NULL;
+
+	return perf_sw_name[t];
+}
+
 const char *libbpf_bpf_link_type_str(enum bpf_link_type t)
 {
 	if (t < 0 || t >= ARRAY_SIZE(link_type_name))
diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index 754da73..4123e4c 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -16,6 +16,7 @@
 #include <stdbool.h>
 #include <sys/types.h>  // for size_t
 #include <linux/bpf.h>
+#include <linux/perf_event.h>
 
 #include "libbpf_common.h"
 #include "libbpf_legacy.h"
@@ -61,6 +62,61 @@ enum libbpf_errno {
 LIBBPF_API const char *libbpf_bpf_attach_type_str(enum bpf_attach_type t);
 
 /**
+ * @brief **libbpf_perf_type_str()** converts the provided perf type value
+ * into a textual representation.
+ * @param t The perf type.
+ * @return Pointer to a static string identifying the perf type. NULL is
+ * returned for unknown **perf_type_id** values.
+ */
+LIBBPF_API const char *libbpf_perf_type_str(enum perf_type_id t);
+
+/**
+ * @brief **libbpf_perf_hw_str()** converts the provided perf hw id
+ * into a textual representation.
+ * @param t The perf hw id.
+ * @return Pointer to a static string identifying the perf hw id. NULL is
+ * returned for unknown **perf_hw_id** values.
+ */
+LIBBPF_API const char *libbpf_perf_hw_str(enum perf_hw_id t);
+
+/**
+ * @brief **libbpf_perf_hw_cache_str()** converts the provided perf hw cache
+ * id into a textual representation.
+ * @param t The perf hw cache id.
+ * @return Pointer to a static string identifying the perf hw cache id.
+ * NULL is returned for unknown **perf_hw_cache_id** values.
+ */
+LIBBPF_API const char *libbpf_perf_hw_cache_str(enum perf_hw_cache_id t);
+
+/**
+ * @brief **libbpf_perf_hw_cache_op_str()** converts the provided perf hw
+ * cache op id into a textual representation.
+ * @param t The perf hw cache op id.
+ * @return Pointer to a static string identifying the perf hw cache op id.
+ * NULL is returned for unknown **perf_hw_cache_op_id** values.
+ */
+LIBBPF_API const char *libbpf_perf_hw_cache_op_str(enum perf_hw_cache_op_id t);
+
+/**
+ * @brief **libbpf_perf_hw_cache_op_result_str()** converts the provided
+ * perf hw cache op result id into a textual representation.
+ * @param t The perf hw cache op result id.
+ * @return Pointer to a static string identifying the perf hw cache op result
+ * id. NULL is returned for unknown **perf_hw_cache_op_result_id** values.
+ */
+LIBBPF_API const char *
+libbpf_perf_hw_cache_op_result_str(enum perf_hw_cache_op_result_id t);
+
+/**
+ * @brief **libbpf_perf_sw_str()** converts the provided perf sw id
+ * into a textual representation.
+ * @param t The perf sw id.
+ * @return Pointer to a static string identifying the perf sw id. NULL is
+ * returned for unknown **perf_sw_ids** values.
+ */
+LIBBPF_API const char *libbpf_perf_sw_str(enum perf_sw_ids t);
+
+/**
  * @brief **libbpf_bpf_link_type_str()** converts the provided link type value
  * into a textual representation.
  * @param t The link type.
diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
index 7521a2f..6ae0a36 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -395,4 +395,10 @@ LIBBPF_1.2.0 {
 LIBBPF_1.3.0 {
 	global:
 		bpf_obj_pin_opts;
+		libbpf_perf_hw_cache_op_result_str;
+		libbpf_perf_hw_cache_op_str;
+		libbpf_perf_hw_cache_str;
+		libbpf_perf_hw_str;
+		libbpf_perf_sw_str;
+		libbpf_perf_type_str;
 } LIBBPF_1.2.0;
-- 
1.8.3.1


