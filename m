Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C337853D221
	for <lists+bpf@lfdr.de>; Fri,  3 Jun 2022 21:04:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348724AbiFCTEI convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Fri, 3 Jun 2022 15:04:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348711AbiFCTEH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 3 Jun 2022 15:04:07 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 761EB30F7F
        for <bpf@vger.kernel.org>; Fri,  3 Jun 2022 12:04:06 -0700 (PDT)
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.17.1.5/8.17.1.5) with ESMTP id 253GmMSe021320
        for <bpf@vger.kernel.org>; Fri, 3 Jun 2022 12:04:05 -0700
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0089730.ppops.net (PPS) with ESMTPS id 3gf4yydwky-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 03 Jun 2022 12:04:05 -0700
Received: from twshared6447.05.prn5.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:21d::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Fri, 3 Jun 2022 12:04:04 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 8899F1AC9C432; Fri,  3 Jun 2022 12:03:55 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>
Subject: [PATCH bpf-next 12/15] libbpf: clean up SEC() handling
Date:   Fri, 3 Jun 2022 12:01:52 -0700
Message-ID: <20220603190155.3924899-13-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220603190155.3924899-1-andrii@kernel.org>
References: <20220603190155.3924899-1-andrii@kernel.org>
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: cm2leHTLqfovTKVd2ifE2xkK03Eysc4S
X-Proofpoint-ORIG-GUID: cm2leHTLqfovTKVd2ifE2xkK03Eysc4S
Content-Transfer-Encoding: 8BIT
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-06-03_06,2022-06-03_01,2022-02-23_01
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        UPPERCASE_50_75 autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Get rid of sloppy prefix logic and remove deprecated xdp_{devmap,cpumap}
sections.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/libbpf.c | 119 ++++++++++++++++-------------------------
 1 file changed, 47 insertions(+), 72 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index a9c71554f215..9287554fe6a8 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -346,12 +346,8 @@ enum sec_def_flags {
 	SEC_ATTACH_BTF = 4,
 	/* BPF program type allows sleeping/blocking in kernel */
 	SEC_SLEEPABLE = 8,
-	/* allow non-strict prefix matching */
-	SEC_SLOPPY_PFX = 16,
 	/* BPF program support non-linear XDP buffer */
-	SEC_XDP_FRAGS = 32,
-	/* deprecated sec definitions not supposed to be used */
-	SEC_DEPRECATED = 64,
+	SEC_XDP_FRAGS = 16,
 };
 
 struct bpf_sec_def {
@@ -6806,11 +6802,6 @@ static int libbpf_prepare_prog_load(struct bpf_program *prog,
 	if (prog->type == BPF_PROG_TYPE_XDP && (def & SEC_XDP_FRAGS))
 		opts->prog_flags |= BPF_F_XDP_HAS_FRAGS;
 
-	if (def & SEC_DEPRECATED) {
-		pr_warn("SEC(\"%s\") is deprecated, please see https://github.com/libbpf/libbpf/wiki/Libbpf-1.0-migration-guide#bpf-program-sec-annotation-deprecations for details\n",
-			prog->sec_name);
-	}
-
 	if ((def & SEC_ATTACH_BTF) && !prog->attach_btf_id) {
 		int btf_obj_fd = 0, btf_type_id = 0, err;
 		const char *attach_name;
@@ -8607,9 +8598,9 @@ static int attach_lsm(const struct bpf_program *prog, long cookie, struct bpf_li
 static int attach_iter(const struct bpf_program *prog, long cookie, struct bpf_link **link);
 
 static const struct bpf_sec_def section_defs[] = {
-	SEC_DEF("socket",		SOCKET_FILTER, 0, SEC_NONE | SEC_SLOPPY_PFX),
-	SEC_DEF("sk_reuseport/migrate",	SK_REUSEPORT, BPF_SK_REUSEPORT_SELECT_OR_MIGRATE, SEC_ATTACHABLE | SEC_SLOPPY_PFX),
-	SEC_DEF("sk_reuseport",		SK_REUSEPORT, BPF_SK_REUSEPORT_SELECT, SEC_ATTACHABLE | SEC_SLOPPY_PFX),
+	SEC_DEF("socket",		SOCKET_FILTER, 0, SEC_NONE),
+	SEC_DEF("sk_reuseport/migrate",	SK_REUSEPORT, BPF_SK_REUSEPORT_SELECT_OR_MIGRATE, SEC_ATTACHABLE),
+	SEC_DEF("sk_reuseport",		SK_REUSEPORT, BPF_SK_REUSEPORT_SELECT, SEC_ATTACHABLE),
 	SEC_DEF("kprobe+",		KPROBE,	0, SEC_NONE, attach_kprobe),
 	SEC_DEF("uprobe+",		KPROBE,	0, SEC_NONE, attach_uprobe),
 	SEC_DEF("kretprobe+",		KPROBE, 0, SEC_NONE, attach_kprobe),
@@ -8618,8 +8609,8 @@ static const struct bpf_sec_def section_defs[] = {
 	SEC_DEF("kretprobe.multi+",	KPROBE,	BPF_TRACE_KPROBE_MULTI, SEC_NONE, attach_kprobe_multi),
 	SEC_DEF("usdt+",		KPROBE,	0, SEC_NONE, attach_usdt),
 	SEC_DEF("tc",			SCHED_CLS, 0, SEC_NONE),
-	SEC_DEF("classifier",		SCHED_CLS, 0, SEC_NONE | SEC_SLOPPY_PFX | SEC_DEPRECATED),
-	SEC_DEF("action",		SCHED_ACT, 0, SEC_NONE | SEC_SLOPPY_PFX),
+	SEC_DEF("classifier",		SCHED_CLS, 0, SEC_NONE),
+	SEC_DEF("action",		SCHED_ACT, 0, SEC_NONE),
 	SEC_DEF("tracepoint+",		TRACEPOINT, 0, SEC_NONE, attach_tp),
 	SEC_DEF("tp+",			TRACEPOINT, 0, SEC_NONE, attach_tp),
 	SEC_DEF("raw_tracepoint+",	RAW_TRACEPOINT, 0, SEC_NONE, attach_raw_tp),
@@ -8641,50 +8632,48 @@ static const struct bpf_sec_def section_defs[] = {
 	SEC_DEF("syscall",		SYSCALL, 0, SEC_SLEEPABLE),
 	SEC_DEF("xdp.frags/devmap",	XDP, BPF_XDP_DEVMAP, SEC_XDP_FRAGS),
 	SEC_DEF("xdp/devmap",		XDP, BPF_XDP_DEVMAP, SEC_ATTACHABLE),
-	SEC_DEF("xdp_devmap/",		XDP, BPF_XDP_DEVMAP, SEC_ATTACHABLE | SEC_DEPRECATED),
 	SEC_DEF("xdp.frags/cpumap",	XDP, BPF_XDP_CPUMAP, SEC_XDP_FRAGS),
 	SEC_DEF("xdp/cpumap",		XDP, BPF_XDP_CPUMAP, SEC_ATTACHABLE),
-	SEC_DEF("xdp_cpumap/",		XDP, BPF_XDP_CPUMAP, SEC_ATTACHABLE | SEC_DEPRECATED),
 	SEC_DEF("xdp.frags",		XDP, BPF_XDP, SEC_XDP_FRAGS),
-	SEC_DEF("xdp",			XDP, BPF_XDP, SEC_ATTACHABLE_OPT | SEC_SLOPPY_PFX),
-	SEC_DEF("perf_event",		PERF_EVENT, 0, SEC_NONE | SEC_SLOPPY_PFX),
-	SEC_DEF("lwt_in",		LWT_IN, 0, SEC_NONE | SEC_SLOPPY_PFX),
-	SEC_DEF("lwt_out",		LWT_OUT, 0, SEC_NONE | SEC_SLOPPY_PFX),
-	SEC_DEF("lwt_xmit",		LWT_XMIT, 0, SEC_NONE | SEC_SLOPPY_PFX),
-	SEC_DEF("lwt_seg6local",	LWT_SEG6LOCAL, 0, SEC_NONE | SEC_SLOPPY_PFX),
-	SEC_DEF("cgroup_skb/ingress",	CGROUP_SKB, BPF_CGROUP_INET_INGRESS, SEC_ATTACHABLE_OPT | SEC_SLOPPY_PFX),
-	SEC_DEF("cgroup_skb/egress",	CGROUP_SKB, BPF_CGROUP_INET_EGRESS, SEC_ATTACHABLE_OPT | SEC_SLOPPY_PFX),
-	SEC_DEF("cgroup/skb",		CGROUP_SKB, 0, SEC_NONE | SEC_SLOPPY_PFX),
-	SEC_DEF("cgroup/sock_create",	CGROUP_SOCK, BPF_CGROUP_INET_SOCK_CREATE, SEC_ATTACHABLE | SEC_SLOPPY_PFX),
-	SEC_DEF("cgroup/sock_release",	CGROUP_SOCK, BPF_CGROUP_INET_SOCK_RELEASE, SEC_ATTACHABLE | SEC_SLOPPY_PFX),
-	SEC_DEF("cgroup/sock",		CGROUP_SOCK, BPF_CGROUP_INET_SOCK_CREATE, SEC_ATTACHABLE_OPT | SEC_SLOPPY_PFX),
-	SEC_DEF("cgroup/post_bind4",	CGROUP_SOCK, BPF_CGROUP_INET4_POST_BIND, SEC_ATTACHABLE | SEC_SLOPPY_PFX),
-	SEC_DEF("cgroup/post_bind6",	CGROUP_SOCK, BPF_CGROUP_INET6_POST_BIND, SEC_ATTACHABLE | SEC_SLOPPY_PFX),
-	SEC_DEF("cgroup/dev",		CGROUP_DEVICE, BPF_CGROUP_DEVICE, SEC_ATTACHABLE_OPT | SEC_SLOPPY_PFX),
-	SEC_DEF("sockops",		SOCK_OPS, BPF_CGROUP_SOCK_OPS, SEC_ATTACHABLE_OPT | SEC_SLOPPY_PFX),
-	SEC_DEF("sk_skb/stream_parser",	SK_SKB, BPF_SK_SKB_STREAM_PARSER, SEC_ATTACHABLE_OPT | SEC_SLOPPY_PFX),
-	SEC_DEF("sk_skb/stream_verdict",SK_SKB, BPF_SK_SKB_STREAM_VERDICT, SEC_ATTACHABLE_OPT | SEC_SLOPPY_PFX),
-	SEC_DEF("sk_skb",		SK_SKB, 0, SEC_NONE | SEC_SLOPPY_PFX),
-	SEC_DEF("sk_msg",		SK_MSG, BPF_SK_MSG_VERDICT, SEC_ATTACHABLE_OPT | SEC_SLOPPY_PFX),
-	SEC_DEF("lirc_mode2",		LIRC_MODE2, BPF_LIRC_MODE2, SEC_ATTACHABLE_OPT | SEC_SLOPPY_PFX),
-	SEC_DEF("flow_dissector",	FLOW_DISSECTOR, BPF_FLOW_DISSECTOR, SEC_ATTACHABLE_OPT | SEC_SLOPPY_PFX),
-	SEC_DEF("cgroup/bind4",		CGROUP_SOCK_ADDR, BPF_CGROUP_INET4_BIND, SEC_ATTACHABLE | SEC_SLOPPY_PFX),
-	SEC_DEF("cgroup/bind6",		CGROUP_SOCK_ADDR, BPF_CGROUP_INET6_BIND, SEC_ATTACHABLE | SEC_SLOPPY_PFX),
-	SEC_DEF("cgroup/connect4",	CGROUP_SOCK_ADDR, BPF_CGROUP_INET4_CONNECT, SEC_ATTACHABLE | SEC_SLOPPY_PFX),
-	SEC_DEF("cgroup/connect6",	CGROUP_SOCK_ADDR, BPF_CGROUP_INET6_CONNECT, SEC_ATTACHABLE | SEC_SLOPPY_PFX),
-	SEC_DEF("cgroup/sendmsg4",	CGROUP_SOCK_ADDR, BPF_CGROUP_UDP4_SENDMSG, SEC_ATTACHABLE | SEC_SLOPPY_PFX),
-	SEC_DEF("cgroup/sendmsg6",	CGROUP_SOCK_ADDR, BPF_CGROUP_UDP6_SENDMSG, SEC_ATTACHABLE | SEC_SLOPPY_PFX),
-	SEC_DEF("cgroup/recvmsg4",	CGROUP_SOCK_ADDR, BPF_CGROUP_UDP4_RECVMSG, SEC_ATTACHABLE | SEC_SLOPPY_PFX),
-	SEC_DEF("cgroup/recvmsg6",	CGROUP_SOCK_ADDR, BPF_CGROUP_UDP6_RECVMSG, SEC_ATTACHABLE | SEC_SLOPPY_PFX),
-	SEC_DEF("cgroup/getpeername4",	CGROUP_SOCK_ADDR, BPF_CGROUP_INET4_GETPEERNAME, SEC_ATTACHABLE | SEC_SLOPPY_PFX),
-	SEC_DEF("cgroup/getpeername6",	CGROUP_SOCK_ADDR, BPF_CGROUP_INET6_GETPEERNAME, SEC_ATTACHABLE | SEC_SLOPPY_PFX),
-	SEC_DEF("cgroup/getsockname4",	CGROUP_SOCK_ADDR, BPF_CGROUP_INET4_GETSOCKNAME, SEC_ATTACHABLE | SEC_SLOPPY_PFX),
-	SEC_DEF("cgroup/getsockname6",	CGROUP_SOCK_ADDR, BPF_CGROUP_INET6_GETSOCKNAME, SEC_ATTACHABLE | SEC_SLOPPY_PFX),
-	SEC_DEF("cgroup/sysctl",	CGROUP_SYSCTL, BPF_CGROUP_SYSCTL, SEC_ATTACHABLE | SEC_SLOPPY_PFX),
-	SEC_DEF("cgroup/getsockopt",	CGROUP_SOCKOPT, BPF_CGROUP_GETSOCKOPT, SEC_ATTACHABLE | SEC_SLOPPY_PFX),
-	SEC_DEF("cgroup/setsockopt",	CGROUP_SOCKOPT, BPF_CGROUP_SETSOCKOPT, SEC_ATTACHABLE | SEC_SLOPPY_PFX),
+	SEC_DEF("xdp",			XDP, BPF_XDP, SEC_ATTACHABLE_OPT),
+	SEC_DEF("perf_event",		PERF_EVENT, 0, SEC_NONE),
+	SEC_DEF("lwt_in",		LWT_IN, 0, SEC_NONE),
+	SEC_DEF("lwt_out",		LWT_OUT, 0, SEC_NONE),
+	SEC_DEF("lwt_xmit",		LWT_XMIT, 0, SEC_NONE),
+	SEC_DEF("lwt_seg6local",	LWT_SEG6LOCAL, 0, SEC_NONE),
+	SEC_DEF("sockops",		SOCK_OPS, BPF_CGROUP_SOCK_OPS, SEC_ATTACHABLE_OPT),
+	SEC_DEF("sk_skb/stream_parser",	SK_SKB, BPF_SK_SKB_STREAM_PARSER, SEC_ATTACHABLE_OPT),
+	SEC_DEF("sk_skb/stream_verdict",SK_SKB, BPF_SK_SKB_STREAM_VERDICT, SEC_ATTACHABLE_OPT),
+	SEC_DEF("sk_skb",		SK_SKB, 0, SEC_NONE),
+	SEC_DEF("sk_msg",		SK_MSG, BPF_SK_MSG_VERDICT, SEC_ATTACHABLE_OPT),
+	SEC_DEF("lirc_mode2",		LIRC_MODE2, BPF_LIRC_MODE2, SEC_ATTACHABLE_OPT),
+	SEC_DEF("flow_dissector",	FLOW_DISSECTOR, BPF_FLOW_DISSECTOR, SEC_ATTACHABLE_OPT),
+	SEC_DEF("cgroup_skb/ingress",	CGROUP_SKB, BPF_CGROUP_INET_INGRESS, SEC_ATTACHABLE_OPT),
+	SEC_DEF("cgroup_skb/egress",	CGROUP_SKB, BPF_CGROUP_INET_EGRESS, SEC_ATTACHABLE_OPT),
+	SEC_DEF("cgroup/skb",		CGROUP_SKB, 0, SEC_NONE),
+	SEC_DEF("cgroup/sock_create",	CGROUP_SOCK, BPF_CGROUP_INET_SOCK_CREATE, SEC_ATTACHABLE),
+	SEC_DEF("cgroup/sock_release",	CGROUP_SOCK, BPF_CGROUP_INET_SOCK_RELEASE, SEC_ATTACHABLE),
+	SEC_DEF("cgroup/sock",		CGROUP_SOCK, BPF_CGROUP_INET_SOCK_CREATE, SEC_ATTACHABLE_OPT),
+	SEC_DEF("cgroup/post_bind4",	CGROUP_SOCK, BPF_CGROUP_INET4_POST_BIND, SEC_ATTACHABLE),
+	SEC_DEF("cgroup/post_bind6",	CGROUP_SOCK, BPF_CGROUP_INET6_POST_BIND, SEC_ATTACHABLE),
+	SEC_DEF("cgroup/bind4",		CGROUP_SOCK_ADDR, BPF_CGROUP_INET4_BIND, SEC_ATTACHABLE),
+	SEC_DEF("cgroup/bind6",		CGROUP_SOCK_ADDR, BPF_CGROUP_INET6_BIND, SEC_ATTACHABLE),
+	SEC_DEF("cgroup/connect4",	CGROUP_SOCK_ADDR, BPF_CGROUP_INET4_CONNECT, SEC_ATTACHABLE),
+	SEC_DEF("cgroup/connect6",	CGROUP_SOCK_ADDR, BPF_CGROUP_INET6_CONNECT, SEC_ATTACHABLE),
+	SEC_DEF("cgroup/sendmsg4",	CGROUP_SOCK_ADDR, BPF_CGROUP_UDP4_SENDMSG, SEC_ATTACHABLE),
+	SEC_DEF("cgroup/sendmsg6",	CGROUP_SOCK_ADDR, BPF_CGROUP_UDP6_SENDMSG, SEC_ATTACHABLE),
+	SEC_DEF("cgroup/recvmsg4",	CGROUP_SOCK_ADDR, BPF_CGROUP_UDP4_RECVMSG, SEC_ATTACHABLE),
+	SEC_DEF("cgroup/recvmsg6",	CGROUP_SOCK_ADDR, BPF_CGROUP_UDP6_RECVMSG, SEC_ATTACHABLE),
+	SEC_DEF("cgroup/getpeername4",	CGROUP_SOCK_ADDR, BPF_CGROUP_INET4_GETPEERNAME, SEC_ATTACHABLE),
+	SEC_DEF("cgroup/getpeername6",	CGROUP_SOCK_ADDR, BPF_CGROUP_INET6_GETPEERNAME, SEC_ATTACHABLE),
+	SEC_DEF("cgroup/getsockname4",	CGROUP_SOCK_ADDR, BPF_CGROUP_INET4_GETSOCKNAME, SEC_ATTACHABLE),
+	SEC_DEF("cgroup/getsockname6",	CGROUP_SOCK_ADDR, BPF_CGROUP_INET6_GETSOCKNAME, SEC_ATTACHABLE),
+	SEC_DEF("cgroup/sysctl",	CGROUP_SYSCTL, BPF_CGROUP_SYSCTL, SEC_ATTACHABLE),
+	SEC_DEF("cgroup/getsockopt",	CGROUP_SOCKOPT, BPF_CGROUP_GETSOCKOPT, SEC_ATTACHABLE),
+	SEC_DEF("cgroup/setsockopt",	CGROUP_SOCKOPT, BPF_CGROUP_SETSOCKOPT, SEC_ATTACHABLE),
+	SEC_DEF("cgroup/dev",		CGROUP_DEVICE, BPF_CGROUP_DEVICE, SEC_ATTACHABLE_OPT),
 	SEC_DEF("struct_ops+",		STRUCT_OPS, 0, SEC_NONE),
-	SEC_DEF("sk_lookup",		SK_LOOKUP, BPF_SK_LOOKUP, SEC_ATTACHABLE | SEC_SLOPPY_PFX),
+	SEC_DEF("sk_lookup",		SK_LOOKUP, BPF_SK_LOOKUP, SEC_ATTACHABLE),
 };
 
 static size_t custom_sec_def_cnt;
@@ -8779,8 +8768,7 @@ int libbpf_unregister_prog_handler(int handler_id)
 	return 0;
 }
 
-static bool sec_def_matches(const struct bpf_sec_def *sec_def, const char *sec_name,
-			    bool allow_sloppy)
+static bool sec_def_matches(const struct bpf_sec_def *sec_def, const char *sec_name)
 {
 	size_t len = strlen(sec_def->sec);
 
@@ -8805,17 +8793,6 @@ static bool sec_def_matches(const struct bpf_sec_def *sec_def, const char *sec_n
 		return false;
 	}
 
-	/* SEC_SLOPPY_PFX definitions are allowed to be just prefix
-	 * matches, unless strict section name mode
-	 * (LIBBPF_STRICT_SEC_NAME) is enabled, in which case the
-	 * match has to be exact.
-	 */
-	if (allow_sloppy && str_has_pfx(sec_name, sec_def->sec))
-		return true;
-
-	/* Definitions not marked SEC_SLOPPY_PFX (e.g.,
-	 * SEC("syscall")) are exact matches in both modes.
-	 */
 	return strcmp(sec_name, sec_def->sec) == 0;
 }
 
@@ -8823,20 +8800,18 @@ static const struct bpf_sec_def *find_sec_def(const char *sec_name)
 {
 	const struct bpf_sec_def *sec_def;
 	int i, n;
-	bool strict = libbpf_mode & LIBBPF_STRICT_SEC_NAME, allow_sloppy;
 
 	n = custom_sec_def_cnt;
 	for (i = 0; i < n; i++) {
 		sec_def = &custom_sec_defs[i];
-		if (sec_def_matches(sec_def, sec_name, false))
+		if (sec_def_matches(sec_def, sec_name))
 			return sec_def;
 	}
 
 	n = ARRAY_SIZE(section_defs);
 	for (i = 0; i < n; i++) {
 		sec_def = &section_defs[i];
-		allow_sloppy = (sec_def->cookie & SEC_SLOPPY_PFX) && !strict;
-		if (sec_def_matches(sec_def, sec_name, allow_sloppy))
+		if (sec_def_matches(sec_def, sec_name))
 			return sec_def;
 	}
 
-- 
2.30.2

