Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78B985757FB
	for <lists+bpf@lfdr.de>; Fri, 15 Jul 2022 01:21:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232822AbiGNXVw convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Thu, 14 Jul 2022 19:21:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232546AbiGNXVv (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 14 Jul 2022 19:21:51 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E04F265D0
        for <bpf@vger.kernel.org>; Thu, 14 Jul 2022 16:21:50 -0700 (PDT)
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26END7dm023809
        for <bpf@vger.kernel.org>; Thu, 14 Jul 2022 16:21:50 -0700
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3hat59rwk8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 14 Jul 2022 16:21:50 -0700
Received: from snc-exhub201.TheFacebook.com (2620:10d:c085:21d::7) by
 snc-exhub202.TheFacebook.com (2620:10d:c085:21d::5) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Thu, 14 Jul 2022 16:21:49 -0700
Received: from twshared31479.05.prn5.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:21d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Thu, 14 Jul 2022 16:21:49 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id C00EE1C5925C6; Thu, 14 Jul 2022 16:21:44 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>,
        Connor O'Brien <connoro@google.com>
Subject: [PATCH bpf-next] libbpf: fallback to tracefs mount point if debugfs is not mounted
Date:   Thu, 14 Jul 2022 16:21:43 -0700
Message-ID: <20220714232143.3728834-1-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: A7NvS0BHRMJp7Z9MUvTN4tqQK7DT0HIb
X-Proofpoint-ORIG-GUID: A7NvS0BHRMJp7Z9MUvTN4tqQK7DT0HIb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-14_19,2022-07-14_01,2022-06-22_01
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Teach libbpf to fallback to tracefs mount point (/sys/kernel/tracing) if
debugfs (/sys/kernel/debug/tracing) isn't mounted.

Suggested-by: Connor O'Brien <connoro@google.com>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/libbpf.c | 33 +++++++++++++++++++++++----------
 1 file changed, 23 insertions(+), 10 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 68da1aca406c..4acdc174cc73 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -9828,6 +9828,19 @@ static int append_to_file(const char *file, const char *fmt, ...)
 	return err;
 }
 
+#define DEBUGFS "/sys/kernel/debug/tracing"
+#define TRACEFS "/sys/kernel/tracing"
+
+static bool use_debugfs(void)
+{
+	static int has_debugfs = -1;
+
+	if (has_debugfs < 0)
+		has_debugfs = access(DEBUGFS, F_OK) == 0;
+
+	return has_debugfs == 1;
+}
+
 static void gen_kprobe_legacy_event_name(char *buf, size_t buf_sz,
 					 const char *kfunc_name, size_t offset)
 {
@@ -9840,7 +9853,7 @@ static void gen_kprobe_legacy_event_name(char *buf, size_t buf_sz,
 static int add_kprobe_event_legacy(const char *probe_name, bool retprobe,
 				   const char *kfunc_name, size_t offset)
 {
-	const char *file = "/sys/kernel/debug/tracing/kprobe_events";
+	const char *file = use_debugfs() ? DEBUGFS"/kprobe_events" : TRACEFS"/kprobe_events";
 
 	return append_to_file(file, "%c:%s/%s %s+0x%zx",
 			      retprobe ? 'r' : 'p',
@@ -9850,7 +9863,7 @@ static int add_kprobe_event_legacy(const char *probe_name, bool retprobe,
 
 static int remove_kprobe_event_legacy(const char *probe_name, bool retprobe)
 {
-	const char *file = "/sys/kernel/debug/tracing/kprobe_events";
+	const char *file = use_debugfs() ? DEBUGFS"/kprobe_events" : TRACEFS"/kprobe_events";
 
 	return append_to_file(file, "-:%s/%s", retprobe ? "kretprobes" : "kprobes", probe_name);
 }
@@ -9859,8 +9872,8 @@ static int determine_kprobe_perf_type_legacy(const char *probe_name, bool retpro
 {
 	char file[256];
 
-	snprintf(file, sizeof(file),
-		 "/sys/kernel/debug/tracing/events/%s/%s/id",
+	snprintf(file, sizeof(file), "%s/events/%s/%s/id",
+		 use_debugfs() ? DEBUGFS : TRACEFS,
 		 retprobe ? "kretprobes" : "kprobes", probe_name);
 
 	return parse_uint_from_file(file, "%d\n");
@@ -10213,7 +10226,7 @@ static void gen_uprobe_legacy_event_name(char *buf, size_t buf_sz,
 static inline int add_uprobe_event_legacy(const char *probe_name, bool retprobe,
 					  const char *binary_path, size_t offset)
 {
-	const char *file = "/sys/kernel/debug/tracing/uprobe_events";
+	const char *file = use_debugfs() ? DEBUGFS"/uprobe_events" : TRACEFS"/uprobe_events";
 
 	return append_to_file(file, "%c:%s/%s %s:0x%zx",
 			      retprobe ? 'r' : 'p',
@@ -10223,7 +10236,7 @@ static inline int add_uprobe_event_legacy(const char *probe_name, bool retprobe,
 
 static inline int remove_uprobe_event_legacy(const char *probe_name, bool retprobe)
 {
-	const char *file = "/sys/kernel/debug/tracing/uprobe_events";
+	const char *file = use_debugfs() ? DEBUGFS"/uprobe_events" : TRACEFS"/uprobe_events";
 
 	return append_to_file(file, "-:%s/%s", retprobe ? "uretprobes" : "uprobes", probe_name);
 }
@@ -10232,8 +10245,8 @@ static int determine_uprobe_perf_type_legacy(const char *probe_name, bool retpro
 {
 	char file[512];
 
-	snprintf(file, sizeof(file),
-		 "/sys/kernel/debug/tracing/events/%s/%s/id",
+	snprintf(file, sizeof(file), "%s/events/%s/%s/id",
+		 use_debugfs() ? DEBUGFS : TRACEFS,
 		 retprobe ? "uretprobes" : "uprobes", probe_name);
 
 	return parse_uint_from_file(file, "%d\n");
@@ -10782,8 +10795,8 @@ static int determine_tracepoint_id(const char *tp_category,
 	char file[PATH_MAX];
 	int ret;
 
-	ret = snprintf(file, sizeof(file),
-		       "/sys/kernel/debug/tracing/events/%s/%s/id",
+	ret = snprintf(file, sizeof(file), "%s/events/%s/%s/id",
+		       use_debugfs() ? DEBUGFS : TRACEFS,
 		       tp_category, tp_name);
 	if (ret < 0)
 		return -errno;
-- 
2.30.2

