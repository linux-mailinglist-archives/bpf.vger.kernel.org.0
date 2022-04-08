Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 049894F9E40
	for <lists+bpf@lfdr.de>; Fri,  8 Apr 2022 22:35:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232768AbiDHUg4 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Fri, 8 Apr 2022 16:36:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235764AbiDHUgz (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 8 Apr 2022 16:36:55 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4014A18856C
        for <bpf@vger.kernel.org>; Fri,  8 Apr 2022 13:34:50 -0700 (PDT)
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 238JaCOH021855
        for <bpf@vger.kernel.org>; Fri, 8 Apr 2022 13:34:49 -0700
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3fankkb884-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 08 Apr 2022 13:34:49 -0700
Received: from twshared27284.14.frc2.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Fri, 8 Apr 2022 13:34:48 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 9555516FC5A19; Fri,  8 Apr 2022 13:34:38 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>
Subject: [PATCH bpf-next 1/3] libbpf: allow "incomplete" basic tracing SEC() definitions
Date:   Fri, 8 Apr 2022 13:34:31 -0700
Message-ID: <20220408203433.2988727-2-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220408203433.2988727-1-andrii@kernel.org>
References: <20220408203433.2988727-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: naZDIht-CjETtuaNrFf9o5eV_KDZsDZL
X-Proofpoint-GUID: naZDIht-CjETtuaNrFf9o5eV_KDZsDZL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-04-08_08,2022-04-08_01,2022-02-23_01
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

In a lot of cases the target of kprobe/kretprobe, tracepoint, raw
tracepoint, etc BPF program might not be known at the compilation time
and will be discovered at runtime. This was always a supported case by
libbpf, with APIs like bpf_program__attach_{kprobe,tracepoint,etc}()
accepting full target definition, regardless of what was defined in
SEC() definition in BPF source code.

Unfortunately, up till now libbpf still enforced users to specify at
least something for the fake target, e.g., SEC("kprobe/whatever"), which
is cumbersome and somewhat misleading.

This patch allows target-less SEC() definitions for basic tracing BPF
program types:
  - kprobe/kretprobe;
  - multi-kprobe/multi-kretprobe;
  - tracepoints;
  - raw tracepoints.

Such target-less SEC() definitions are meant to specify declaratively
proper BPF program type only. Attachment of them will have to be handled
programmatically using correct APIs. As such, skeleton's auto-attachment
of such BPF programs is skipped and generic bpf_program__attach() will
fail, if attempted, due to the lack of enough target information.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/libbpf.c | 69 +++++++++++++++++++++++++++++++-----------
 1 file changed, 51 insertions(+), 18 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 9deb1fc67f19..81911a1e1f3e 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -8668,22 +8668,22 @@ static const struct bpf_sec_def section_defs[] = {
 	SEC_DEF("socket",		SOCKET_FILTER, 0, SEC_NONE | SEC_SLOPPY_PFX),
 	SEC_DEF("sk_reuseport/migrate",	SK_REUSEPORT, BPF_SK_REUSEPORT_SELECT_OR_MIGRATE, SEC_ATTACHABLE | SEC_SLOPPY_PFX),
 	SEC_DEF("sk_reuseport",		SK_REUSEPORT, BPF_SK_REUSEPORT_SELECT, SEC_ATTACHABLE | SEC_SLOPPY_PFX),
-	SEC_DEF("kprobe/",		KPROBE,	0, SEC_NONE, attach_kprobe),
+	SEC_DEF("kprobe+",		KPROBE,	0, SEC_NONE, attach_kprobe),
 	SEC_DEF("uprobe+",		KPROBE,	0, SEC_NONE, attach_uprobe),
-	SEC_DEF("kretprobe/",		KPROBE, 0, SEC_NONE, attach_kprobe),
+	SEC_DEF("kretprobe+",		KPROBE, 0, SEC_NONE, attach_kprobe),
 	SEC_DEF("uretprobe+",		KPROBE, 0, SEC_NONE, attach_uprobe),
-	SEC_DEF("kprobe.multi/",	KPROBE,	BPF_TRACE_KPROBE_MULTI, SEC_NONE, attach_kprobe_multi),
-	SEC_DEF("kretprobe.multi/",	KPROBE,	BPF_TRACE_KPROBE_MULTI, SEC_NONE, attach_kprobe_multi),
+	SEC_DEF("kprobe.multi+",	KPROBE,	BPF_TRACE_KPROBE_MULTI, SEC_NONE, attach_kprobe_multi),
+	SEC_DEF("kretprobe.multi+",	KPROBE,	BPF_TRACE_KPROBE_MULTI, SEC_NONE, attach_kprobe_multi),
 	SEC_DEF("usdt+",		KPROBE,	0, SEC_NONE, attach_usdt),
 	SEC_DEF("tc",			SCHED_CLS, 0, SEC_NONE),
 	SEC_DEF("classifier",		SCHED_CLS, 0, SEC_NONE | SEC_SLOPPY_PFX | SEC_DEPRECATED),
 	SEC_DEF("action",		SCHED_ACT, 0, SEC_NONE | SEC_SLOPPY_PFX),
-	SEC_DEF("tracepoint/",		TRACEPOINT, 0, SEC_NONE, attach_tp),
-	SEC_DEF("tp/",			TRACEPOINT, 0, SEC_NONE, attach_tp),
-	SEC_DEF("raw_tracepoint/",	RAW_TRACEPOINT, 0, SEC_NONE, attach_raw_tp),
-	SEC_DEF("raw_tp/",		RAW_TRACEPOINT, 0, SEC_NONE, attach_raw_tp),
-	SEC_DEF("raw_tracepoint.w/",	RAW_TRACEPOINT_WRITABLE, 0, SEC_NONE, attach_raw_tp),
-	SEC_DEF("raw_tp.w/",		RAW_TRACEPOINT_WRITABLE, 0, SEC_NONE, attach_raw_tp),
+	SEC_DEF("tracepoint+",		TRACEPOINT, 0, SEC_NONE, attach_tp),
+	SEC_DEF("tp+",			TRACEPOINT, 0, SEC_NONE, attach_tp),
+	SEC_DEF("raw_tracepoint+",	RAW_TRACEPOINT, 0, SEC_NONE, attach_raw_tp),
+	SEC_DEF("raw_tp+",		RAW_TRACEPOINT, 0, SEC_NONE, attach_raw_tp),
+	SEC_DEF("raw_tracepoint.w+",	RAW_TRACEPOINT_WRITABLE, 0, SEC_NONE, attach_raw_tp),
+	SEC_DEF("raw_tp.w+",		RAW_TRACEPOINT_WRITABLE, 0, SEC_NONE, attach_raw_tp),
 	SEC_DEF("tp_btf/",		TRACING, BPF_TRACE_RAW_TP, SEC_ATTACH_BTF, attach_trace),
 	SEC_DEF("fentry/",		TRACING, BPF_TRACE_FENTRY, SEC_ATTACH_BTF, attach_trace),
 	SEC_DEF("fmod_ret/",		TRACING, BPF_MODIFY_RETURN, SEC_ATTACH_BTF, attach_trace),
@@ -10411,6 +10411,12 @@ static int attach_kprobe(const struct bpf_program *prog, long cookie, struct bpf
 	char *func;
 	int n;
 
+	*link = NULL;
+
+	/* no auto-attach for SEC("kprobe") and SEC("kretprobe") */
+	if (strcmp(prog->sec_name, "kprobe") == 0 || strcmp(prog->sec_name, "kretprobe") == 0)
+		return 0;
+
 	opts.retprobe = str_has_pfx(prog->sec_name, "kretprobe/");
 	if (opts.retprobe)
 		func_name = prog->sec_name + sizeof("kretprobe/") - 1;
@@ -10441,6 +10447,13 @@ static int attach_kprobe_multi(const struct bpf_program *prog, long cookie, stru
 	char *pattern;
 	int n;
 
+	*link = NULL;
+
+	/* no auto-attach for SEC("kprobe.multi") and SEC("kretprobe.multi") */
+	if (strcmp(prog->sec_name, "kprobe.multi") == 0 ||
+	    strcmp(prog->sec_name, "kretprobe.multi") == 0)
+		return 0;
+
 	opts.retprobe = str_has_pfx(prog->sec_name, "kretprobe.multi/");
 	if (opts.retprobe)
 		spec = prog->sec_name + sizeof("kretprobe.multi/") - 1;
@@ -11145,6 +11158,12 @@ static int attach_tp(const struct bpf_program *prog, long cookie, struct bpf_lin
 	if (!sec_name)
 		return -ENOMEM;
 
+	*link = NULL;
+
+	/* no auto-attach for SEC("tp") or SEC("tracepoint") */
+	if (strcmp(prog->sec_name, "tp") == 0 || strcmp(prog->sec_name, "tracepoint") == 0)
+		return 0;
+
 	/* extract "tp/<category>/<name>" or "tracepoint/<category>/<name>" */
 	if (str_has_pfx(prog->sec_name, "tp/"))
 		tp_cat = sec_name + sizeof("tp/") - 1;
@@ -11196,20 +11215,34 @@ struct bpf_link *bpf_program__attach_raw_tracepoint(const struct bpf_program *pr
 static int attach_raw_tp(const struct bpf_program *prog, long cookie, struct bpf_link **link)
 {
 	static const char *const prefixes[] = {
-		"raw_tp/",
-		"raw_tracepoint/",
-		"raw_tp.w/",
-		"raw_tracepoint.w/",
+		"raw_tp",
+		"raw_tracepoint",
+		"raw_tp.w",
+		"raw_tracepoint.w",
 	};
 	size_t i;
 	const char *tp_name = NULL;
 
+	*link = NULL;
+
 	for (i = 0; i < ARRAY_SIZE(prefixes); i++) {
-		if (str_has_pfx(prog->sec_name, prefixes[i])) {
-			tp_name = prog->sec_name + strlen(prefixes[i]);
-			break;
-		}
+		size_t pfx_len;
+
+		if (!str_has_pfx(prog->sec_name, prefixes[i]))
+			continue;
+
+		pfx_len = strlen(prefixes[i]);
+		/* no auto-attach case of, e.g., SEC("raw_tp") */
+		if (prog->sec_name[pfx_len] == '\0')
+			return 0;
+
+		if (prog->sec_name[pfx_len] != '/')
+			continue;
+
+		tp_name = prog->sec_name + pfx_len + 1;
+		break;
 	}
+
 	if (!tp_name) {
 		pr_warn("prog '%s': invalid section name '%s'\n",
 			prog->name, prog->sec_name);
-- 
2.30.2

