Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 711F2576700
	for <lists+bpf@lfdr.de>; Fri, 15 Jul 2022 20:58:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbiGOS6E convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Fri, 15 Jul 2022 14:58:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230050AbiGOS54 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 15 Jul 2022 14:57:56 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 172F157209
        for <bpf@vger.kernel.org>; Fri, 15 Jul 2022 11:57:54 -0700 (PDT)
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26FGH8FL005538
        for <bpf@vger.kernel.org>; Fri, 15 Jul 2022 11:57:53 -0700
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3hae0waxw7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 15 Jul 2022 11:57:53 -0700
Received: from twshared3657.05.prn5.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Fri, 15 Jul 2022 11:57:52 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 940AC1C635E6A; Fri, 15 Jul 2022 11:57:38 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>,
        Yonghong Song <yhs@fb.com>, Connor O'Brien <connoro@google.com>
Subject: [PATCH v2 bpf-next] libbpf: fallback to tracefs mount point if debugfs is not mounted
Date:   Fri, 15 Jul 2022 11:57:36 -0700
Message-ID: <20220715185736.898848-1-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: S4gK41AXPnOni7uJPLXSGE5OaCR1n3-v
X-Proofpoint-ORIG-GUID: S4gK41AXPnOni7uJPLXSGE5OaCR1n3-v
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-15_10,2022-07-15_01,2022-06-22_01
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Teach libbpf to fallback to tracefs mount point (/sys/kernel/tracing) if
debugfs (/sys/kernel/debug/tracing) isn't mounted.

Acked-by: Yonghong Song <yhs@fb.com>
Suggested-by: Connor O'Brien <connoro@google.com>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/libbpf.c | 61 +++++++++++++++++++++++++++---------------
 1 file changed, 40 insertions(+), 21 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 68da1aca406c..92a775c11e3e 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -9828,6 +9828,34 @@ static int append_to_file(const char *file, const char *fmt, ...)
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
+static const char *tracefs_path(void)
+{
+	return use_debugfs() ? DEBUGFS : TRACEFS;
+}
+
+static const char *tracefs_kprobe_events(void)
+{
+	return use_debugfs() ? DEBUGFS"/kprobe_events" : TRACEFS"/kprobe_events";
+}
+
+static const char *tracefs_uprobe_events(void)
+{
+	return use_debugfs() ? DEBUGFS"/uprobe_events" : TRACEFS"/uprobe_events";
+}
+
 static void gen_kprobe_legacy_event_name(char *buf, size_t buf_sz,
 					 const char *kfunc_name, size_t offset)
 {
@@ -9840,9 +9868,7 @@ static void gen_kprobe_legacy_event_name(char *buf, size_t buf_sz,
 static int add_kprobe_event_legacy(const char *probe_name, bool retprobe,
 				   const char *kfunc_name, size_t offset)
 {
-	const char *file = "/sys/kernel/debug/tracing/kprobe_events";
-
-	return append_to_file(file, "%c:%s/%s %s+0x%zx",
+	return append_to_file(tracefs_kprobe_events(), "%c:%s/%s %s+0x%zx",
 			      retprobe ? 'r' : 'p',
 			      retprobe ? "kretprobes" : "kprobes",
 			      probe_name, kfunc_name, offset);
@@ -9850,18 +9876,16 @@ static int add_kprobe_event_legacy(const char *probe_name, bool retprobe,
 
 static int remove_kprobe_event_legacy(const char *probe_name, bool retprobe)
 {
-	const char *file = "/sys/kernel/debug/tracing/kprobe_events";
-
-	return append_to_file(file, "-:%s/%s", retprobe ? "kretprobes" : "kprobes", probe_name);
+	return append_to_file(tracefs_kprobe_events(), "-:%s/%s",
+			      retprobe ? "kretprobes" : "kprobes", probe_name);
 }
 
 static int determine_kprobe_perf_type_legacy(const char *probe_name, bool retprobe)
 {
 	char file[256];
 
-	snprintf(file, sizeof(file),
-		 "/sys/kernel/debug/tracing/events/%s/%s/id",
-		 retprobe ? "kretprobes" : "kprobes", probe_name);
+	snprintf(file, sizeof(file), "%s/events/%s/%s/id",
+		 tracefs_path(), retprobe ? "kretprobes" : "kprobes", probe_name);
 
 	return parse_uint_from_file(file, "%d\n");
 }
@@ -10213,9 +10237,7 @@ static void gen_uprobe_legacy_event_name(char *buf, size_t buf_sz,
 static inline int add_uprobe_event_legacy(const char *probe_name, bool retprobe,
 					  const char *binary_path, size_t offset)
 {
-	const char *file = "/sys/kernel/debug/tracing/uprobe_events";
-
-	return append_to_file(file, "%c:%s/%s %s:0x%zx",
+	return append_to_file(tracefs_uprobe_events(), "%c:%s/%s %s:0x%zx",
 			      retprobe ? 'r' : 'p',
 			      retprobe ? "uretprobes" : "uprobes",
 			      probe_name, binary_path, offset);
@@ -10223,18 +10245,16 @@ static inline int add_uprobe_event_legacy(const char *probe_name, bool retprobe,
 
 static inline int remove_uprobe_event_legacy(const char *probe_name, bool retprobe)
 {
-	const char *file = "/sys/kernel/debug/tracing/uprobe_events";
-
-	return append_to_file(file, "-:%s/%s", retprobe ? "uretprobes" : "uprobes", probe_name);
+	return append_to_file(tracefs_uprobe_events(), "-:%s/%s",
+			      retprobe ? "uretprobes" : "uprobes", probe_name);
 }
 
 static int determine_uprobe_perf_type_legacy(const char *probe_name, bool retprobe)
 {
 	char file[512];
 
-	snprintf(file, sizeof(file),
-		 "/sys/kernel/debug/tracing/events/%s/%s/id",
-		 retprobe ? "uretprobes" : "uprobes", probe_name);
+	snprintf(file, sizeof(file), "%s/events/%s/%s/id",
+		 tracefs_path(), retprobe ? "uretprobes" : "uprobes", probe_name);
 
 	return parse_uint_from_file(file, "%d\n");
 }
@@ -10782,9 +10802,8 @@ static int determine_tracepoint_id(const char *tp_category,
 	char file[PATH_MAX];
 	int ret;
 
-	ret = snprintf(file, sizeof(file),
-		       "/sys/kernel/debug/tracing/events/%s/%s/id",
-		       tp_category, tp_name);
+	ret = snprintf(file, sizeof(file), "%s/events/%s/%s/id",
+		       tracefs_path(), tp_category, tp_name);
 	if (ret < 0)
 		return -errno;
 	if (ret >= sizeof(file)) {
-- 
2.30.2

