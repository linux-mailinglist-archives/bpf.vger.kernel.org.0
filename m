Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E496441B493
	for <lists+bpf@lfdr.de>; Tue, 28 Sep 2021 18:56:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241922AbhI1Q6V convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Tue, 28 Sep 2021 12:58:21 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:12682 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S241940AbhI1Q6R (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 28 Sep 2021 12:58:17 -0400
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.1.2/8.16.1.2) with SMTP id 18SD8Fl7011731
        for <bpf@vger.kernel.org>; Tue, 28 Sep 2021 09:56:37 -0700
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0089730.ppops.net with ESMTP id 3bc3nj1vx1-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 28 Sep 2021 09:56:37 -0700
Received: from intmgw001.37.frc1.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:21d::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Tue, 28 Sep 2021 09:56:34 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 7692350FA642; Tue, 28 Sep 2021 09:20:56 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>,
        Dave Marchevsky <davemarchevsky@fb.com>
Subject: [PATCH v4 bpf-next 09/10] libbpf: add opt-in strict BPF program section name handling logic
Date:   Tue, 28 Sep 2021 09:19:45 -0700
Message-ID: <20210928161946.2512801-10-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210928161946.2512801-1-andrii@kernel.org>
References: <20210928161946.2512801-1-andrii@kernel.org>
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-ORIG-GUID: hyHRam33eUk9i7tY9-dtHWzP82z9V5EN
X-Proofpoint-GUID: hyHRam33eUk9i7tY9-dtHWzP82z9V5EN
Content-Transfer-Encoding: 8BIT
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-28_05,2021-09-28_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 priorityscore=1501 suspectscore=0 mlxscore=0 mlxlogscore=999 phishscore=0
 clxscore=1015 impostorscore=0 spamscore=0 bulkscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2109280099
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Implement strict ELF section name handling for BPF programs. It utilizes
`libbpf_set_strict_mode()` framework and adds new flag: LIBBPF_STRICT_SEC_NAME.

If this flag is set, libbpf will enforce exact section name matching for
a lot of program types that previously allowed just partial prefix
match. E.g., if previously SEC("xdp_whatever_i_want") was allowed, now
in strict mode only SEC("xdp") will be accepted, which makes SEC("")
definitions cleaner and more structured. SEC() now won't be used as yet
another way to uniquely encode BPF program identifier (for that
C function name is better and is guaranteed to be unique within
bpf_object). Now SEC() is strictly BPF program type and, depending on
program type, extra load/attach parameter specification.

Libbpf completely supports multiple BPF programs in the same ELF
section, so multiple BPF programs of the same type/specification easily
co-exist together within the same bpf_object scope.

Additionally, a new (for now internal) convention is introduced: section
name that can be a stand-alone exact BPF program type specificator, but
also could have extra parameters after '/' delimiter. An example of such
section is "struct_ops", which can be specified by itself, but also
allows to specify the intended operation to be attached to, e.g.,
"struct_ops/dctcp_init". Note, that "struct_ops_some_op" is not allowed.
Such section definition is specified as "struct_ops+".

This change is part of libbpf 1.0 effort ([0], [1]).

  [0] Closes: https://github.com/libbpf/libbpf/issues/271
  [1] https://github.com/libbpf/libbpf/wiki/Libbpf:-the-road-to-v1.0#stricter-and-more-uniform-bpf-program-section-name-sec-handling

Acked-by: Dave Marchevsky <davemarchevsky@fb.com>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/libbpf.c        | 136 ++++++++++++++++++++++------------
 tools/lib/bpf/libbpf_legacy.h |   9 +++
 2 files changed, 99 insertions(+), 46 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 4ba67dff6b0d..3e1f6211b9b9 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -242,6 +242,8 @@ enum sec_def_flags {
 	SEC_ATTACH_BTF = 4,
 	/* BPF program type allows sleeping/blocking in kernel */
 	SEC_SLEEPABLE = 8,
+	/* allow non-strict prefix matching */
+	SEC_SLOPPY_PFX = 16,
 };
 
 struct bpf_sec_def {
@@ -7987,16 +7989,16 @@ static struct bpf_link *attach_lsm(const struct bpf_program *prog, long cookie);
 static struct bpf_link *attach_iter(const struct bpf_program *prog, long cookie);
 
 static const struct bpf_sec_def section_defs[] = {
-	SEC_DEF("socket",		SOCKET_FILTER, 0, SEC_NONE),
-	SEC_DEF("sk_reuseport/migrate",	SK_REUSEPORT, BPF_SK_REUSEPORT_SELECT_OR_MIGRATE, SEC_ATTACHABLE),
-	SEC_DEF("sk_reuseport",		SK_REUSEPORT, BPF_SK_REUSEPORT_SELECT, SEC_ATTACHABLE),
+	SEC_DEF("socket",		SOCKET_FILTER, 0, SEC_NONE | SEC_SLOPPY_PFX),
+	SEC_DEF("sk_reuseport/migrate",	SK_REUSEPORT, BPF_SK_REUSEPORT_SELECT_OR_MIGRATE, SEC_ATTACHABLE | SEC_SLOPPY_PFX),
+	SEC_DEF("sk_reuseport",		SK_REUSEPORT, BPF_SK_REUSEPORT_SELECT, SEC_ATTACHABLE | SEC_SLOPPY_PFX),
 	SEC_DEF("kprobe/",		KPROBE,	0, SEC_NONE, attach_kprobe),
 	SEC_DEF("uprobe/",		KPROBE,	0, SEC_NONE),
 	SEC_DEF("kretprobe/",		KPROBE, 0, SEC_NONE, attach_kprobe),
 	SEC_DEF("uretprobe/",		KPROBE, 0, SEC_NONE),
-	SEC_DEF("classifier",		SCHED_CLS, 0, SEC_NONE),
 	SEC_DEF("tc",			SCHED_CLS, 0, SEC_NONE),
-	SEC_DEF("action",		SCHED_ACT, 0, SEC_NONE),
+	SEC_DEF("classifier",		SCHED_CLS, 0, SEC_NONE | SEC_SLOPPY_PFX),
+	SEC_DEF("action",		SCHED_ACT, 0, SEC_NONE | SEC_SLOPPY_PFX),
 	SEC_DEF("tracepoint/",		TRACEPOINT, 0, SEC_NONE, attach_tp),
 	SEC_DEF("tp/",			TRACEPOINT, 0, SEC_NONE, attach_tp),
 	SEC_DEF("raw_tracepoint/",	RAW_TRACEPOINT, 0, SEC_NONE, attach_raw_tp),
@@ -8015,44 +8017,44 @@ static const struct bpf_sec_def section_defs[] = {
 	SEC_DEF("syscall",		SYSCALL, 0, SEC_SLEEPABLE),
 	SEC_DEF("xdp_devmap/",		XDP, BPF_XDP_DEVMAP, SEC_ATTACHABLE),
 	SEC_DEF("xdp_cpumap/",		XDP, BPF_XDP_CPUMAP, SEC_ATTACHABLE),
-	SEC_DEF("xdp",			XDP, BPF_XDP, SEC_ATTACHABLE_OPT),
-	SEC_DEF("perf_event",		PERF_EVENT, 0, SEC_NONE),
-	SEC_DEF("lwt_in",		LWT_IN, 0, SEC_NONE),
-	SEC_DEF("lwt_out",		LWT_OUT, 0, SEC_NONE),
-	SEC_DEF("lwt_xmit",		LWT_XMIT, 0, SEC_NONE),
-	SEC_DEF("lwt_seg6local",	LWT_SEG6LOCAL, 0, SEC_NONE),
-	SEC_DEF("cgroup_skb/ingress",	CGROUP_SKB, BPF_CGROUP_INET_INGRESS, SEC_ATTACHABLE_OPT),
-	SEC_DEF("cgroup_skb/egress",	CGROUP_SKB, BPF_CGROUP_INET_EGRESS, SEC_ATTACHABLE_OPT),
-	SEC_DEF("cgroup/skb",		CGROUP_SKB, 0, SEC_NONE),
-	SEC_DEF("cgroup/sock_create",	CGROUP_SOCK, BPF_CGROUP_INET_SOCK_CREATE, SEC_ATTACHABLE),
-	SEC_DEF("cgroup/sock_release",	CGROUP_SOCK, BPF_CGROUP_INET_SOCK_RELEASE, SEC_ATTACHABLE),
-	SEC_DEF("cgroup/sock",		CGROUP_SOCK, BPF_CGROUP_INET_SOCK_CREATE, SEC_ATTACHABLE_OPT),
-	SEC_DEF("cgroup/post_bind4",	CGROUP_SOCK, BPF_CGROUP_INET4_POST_BIND, SEC_ATTACHABLE),
-	SEC_DEF("cgroup/post_bind6",	CGROUP_SOCK, BPF_CGROUP_INET6_POST_BIND, SEC_ATTACHABLE),
-	SEC_DEF("cgroup/dev",		CGROUP_DEVICE, BPF_CGROUP_DEVICE, SEC_ATTACHABLE_OPT),
-	SEC_DEF("sockops",		SOCK_OPS, BPF_CGROUP_SOCK_OPS, SEC_ATTACHABLE_OPT),
-	SEC_DEF("sk_skb/stream_parser",	SK_SKB, BPF_SK_SKB_STREAM_PARSER, SEC_ATTACHABLE_OPT),
-	SEC_DEF("sk_skb/stream_verdict",SK_SKB, BPF_SK_SKB_STREAM_VERDICT, SEC_ATTACHABLE_OPT),
-	SEC_DEF("sk_skb",		SK_SKB, 0, SEC_NONE),
-	SEC_DEF("sk_msg",		SK_MSG, BPF_SK_MSG_VERDICT, SEC_ATTACHABLE_OPT),
-	SEC_DEF("lirc_mode2",		LIRC_MODE2, BPF_LIRC_MODE2, SEC_ATTACHABLE_OPT),
-	SEC_DEF("flow_dissector",	FLOW_DISSECTOR, BPF_FLOW_DISSECTOR, SEC_ATTACHABLE_OPT),
-	SEC_DEF("cgroup/bind4",		CGROUP_SOCK_ADDR, BPF_CGROUP_INET4_BIND, SEC_ATTACHABLE),
-	SEC_DEF("cgroup/bind6",		CGROUP_SOCK_ADDR, BPF_CGROUP_INET6_BIND, SEC_ATTACHABLE),
-	SEC_DEF("cgroup/connect4",	CGROUP_SOCK_ADDR, BPF_CGROUP_INET4_CONNECT, SEC_ATTACHABLE),
-	SEC_DEF("cgroup/connect6",	CGROUP_SOCK_ADDR, BPF_CGROUP_INET6_CONNECT, SEC_ATTACHABLE),
-	SEC_DEF("cgroup/sendmsg4",	CGROUP_SOCK_ADDR, BPF_CGROUP_UDP4_SENDMSG, SEC_ATTACHABLE),
-	SEC_DEF("cgroup/sendmsg6",	CGROUP_SOCK_ADDR, BPF_CGROUP_UDP6_SENDMSG, SEC_ATTACHABLE),
-	SEC_DEF("cgroup/recvmsg4",	CGROUP_SOCK_ADDR, BPF_CGROUP_UDP4_RECVMSG, SEC_ATTACHABLE),
-	SEC_DEF("cgroup/recvmsg6",	CGROUP_SOCK_ADDR, BPF_CGROUP_UDP6_RECVMSG, SEC_ATTACHABLE),
-	SEC_DEF("cgroup/getpeername4",	CGROUP_SOCK_ADDR, BPF_CGROUP_INET4_GETPEERNAME, SEC_ATTACHABLE),
-	SEC_DEF("cgroup/getpeername6",	CGROUP_SOCK_ADDR, BPF_CGROUP_INET6_GETPEERNAME, SEC_ATTACHABLE),
-	SEC_DEF("cgroup/getsockname4",	CGROUP_SOCK_ADDR, BPF_CGROUP_INET4_GETSOCKNAME, SEC_ATTACHABLE),
-	SEC_DEF("cgroup/getsockname6",	CGROUP_SOCK_ADDR, BPF_CGROUP_INET6_GETSOCKNAME, SEC_ATTACHABLE),
-	SEC_DEF("cgroup/sysctl",	CGROUP_SYSCTL, BPF_CGROUP_SYSCTL, SEC_ATTACHABLE),
-	SEC_DEF("cgroup/getsockopt",	CGROUP_SOCKOPT, BPF_CGROUP_GETSOCKOPT, SEC_ATTACHABLE),
-	SEC_DEF("cgroup/setsockopt",	CGROUP_SOCKOPT, BPF_CGROUP_SETSOCKOPT, SEC_ATTACHABLE),
-	SEC_DEF("struct_ops",		STRUCT_OPS, 0, SEC_NONE),
+	SEC_DEF("xdp",			XDP, BPF_XDP, SEC_ATTACHABLE_OPT | SEC_SLOPPY_PFX),
+	SEC_DEF("perf_event",		PERF_EVENT, 0, SEC_NONE | SEC_SLOPPY_PFX),
+	SEC_DEF("lwt_in",		LWT_IN, 0, SEC_NONE | SEC_SLOPPY_PFX),
+	SEC_DEF("lwt_out",		LWT_OUT, 0, SEC_NONE | SEC_SLOPPY_PFX),
+	SEC_DEF("lwt_xmit",		LWT_XMIT, 0, SEC_NONE | SEC_SLOPPY_PFX),
+	SEC_DEF("lwt_seg6local",	LWT_SEG6LOCAL, 0, SEC_NONE | SEC_SLOPPY_PFX),
+	SEC_DEF("cgroup_skb/ingress",	CGROUP_SKB, BPF_CGROUP_INET_INGRESS, SEC_ATTACHABLE_OPT | SEC_SLOPPY_PFX),
+	SEC_DEF("cgroup_skb/egress",	CGROUP_SKB, BPF_CGROUP_INET_EGRESS, SEC_ATTACHABLE_OPT | SEC_SLOPPY_PFX),
+	SEC_DEF("cgroup/skb",		CGROUP_SKB, 0, SEC_NONE | SEC_SLOPPY_PFX),
+	SEC_DEF("cgroup/sock_create",	CGROUP_SOCK, BPF_CGROUP_INET_SOCK_CREATE, SEC_ATTACHABLE | SEC_SLOPPY_PFX),
+	SEC_DEF("cgroup/sock_release",	CGROUP_SOCK, BPF_CGROUP_INET_SOCK_RELEASE, SEC_ATTACHABLE | SEC_SLOPPY_PFX),
+	SEC_DEF("cgroup/sock",		CGROUP_SOCK, BPF_CGROUP_INET_SOCK_CREATE, SEC_ATTACHABLE_OPT | SEC_SLOPPY_PFX),
+	SEC_DEF("cgroup/post_bind4",	CGROUP_SOCK, BPF_CGROUP_INET4_POST_BIND, SEC_ATTACHABLE | SEC_SLOPPY_PFX),
+	SEC_DEF("cgroup/post_bind6",	CGROUP_SOCK, BPF_CGROUP_INET6_POST_BIND, SEC_ATTACHABLE | SEC_SLOPPY_PFX),
+	SEC_DEF("cgroup/dev",		CGROUP_DEVICE, BPF_CGROUP_DEVICE, SEC_ATTACHABLE_OPT | SEC_SLOPPY_PFX),
+	SEC_DEF("sockops",		SOCK_OPS, BPF_CGROUP_SOCK_OPS, SEC_ATTACHABLE_OPT | SEC_SLOPPY_PFX),
+	SEC_DEF("sk_skb/stream_parser",	SK_SKB, BPF_SK_SKB_STREAM_PARSER, SEC_ATTACHABLE_OPT | SEC_SLOPPY_PFX),
+	SEC_DEF("sk_skb/stream_verdict",SK_SKB, BPF_SK_SKB_STREAM_VERDICT, SEC_ATTACHABLE_OPT | SEC_SLOPPY_PFX),
+	SEC_DEF("sk_skb",		SK_SKB, 0, SEC_NONE | SEC_SLOPPY_PFX),
+	SEC_DEF("sk_msg",		SK_MSG, BPF_SK_MSG_VERDICT, SEC_ATTACHABLE_OPT | SEC_SLOPPY_PFX),
+	SEC_DEF("lirc_mode2",		LIRC_MODE2, BPF_LIRC_MODE2, SEC_ATTACHABLE_OPT | SEC_SLOPPY_PFX),
+	SEC_DEF("flow_dissector",	FLOW_DISSECTOR, BPF_FLOW_DISSECTOR, SEC_ATTACHABLE_OPT | SEC_SLOPPY_PFX),
+	SEC_DEF("cgroup/bind4",		CGROUP_SOCK_ADDR, BPF_CGROUP_INET4_BIND, SEC_ATTACHABLE | SEC_SLOPPY_PFX),
+	SEC_DEF("cgroup/bind6",		CGROUP_SOCK_ADDR, BPF_CGROUP_INET6_BIND, SEC_ATTACHABLE | SEC_SLOPPY_PFX),
+	SEC_DEF("cgroup/connect4",	CGROUP_SOCK_ADDR, BPF_CGROUP_INET4_CONNECT, SEC_ATTACHABLE | SEC_SLOPPY_PFX),
+	SEC_DEF("cgroup/connect6",	CGROUP_SOCK_ADDR, BPF_CGROUP_INET6_CONNECT, SEC_ATTACHABLE | SEC_SLOPPY_PFX),
+	SEC_DEF("cgroup/sendmsg4",	CGROUP_SOCK_ADDR, BPF_CGROUP_UDP4_SENDMSG, SEC_ATTACHABLE | SEC_SLOPPY_PFX),
+	SEC_DEF("cgroup/sendmsg6",	CGROUP_SOCK_ADDR, BPF_CGROUP_UDP6_SENDMSG, SEC_ATTACHABLE | SEC_SLOPPY_PFX),
+	SEC_DEF("cgroup/recvmsg4",	CGROUP_SOCK_ADDR, BPF_CGROUP_UDP4_RECVMSG, SEC_ATTACHABLE | SEC_SLOPPY_PFX),
+	SEC_DEF("cgroup/recvmsg6",	CGROUP_SOCK_ADDR, BPF_CGROUP_UDP6_RECVMSG, SEC_ATTACHABLE | SEC_SLOPPY_PFX),
+	SEC_DEF("cgroup/getpeername4",	CGROUP_SOCK_ADDR, BPF_CGROUP_INET4_GETPEERNAME, SEC_ATTACHABLE | SEC_SLOPPY_PFX),
+	SEC_DEF("cgroup/getpeername6",	CGROUP_SOCK_ADDR, BPF_CGROUP_INET6_GETPEERNAME, SEC_ATTACHABLE | SEC_SLOPPY_PFX),
+	SEC_DEF("cgroup/getsockname4",	CGROUP_SOCK_ADDR, BPF_CGROUP_INET4_GETSOCKNAME, SEC_ATTACHABLE | SEC_SLOPPY_PFX),
+	SEC_DEF("cgroup/getsockname6",	CGROUP_SOCK_ADDR, BPF_CGROUP_INET6_GETSOCKNAME, SEC_ATTACHABLE | SEC_SLOPPY_PFX),
+	SEC_DEF("cgroup/sysctl",	CGROUP_SYSCTL, BPF_CGROUP_SYSCTL, SEC_ATTACHABLE | SEC_SLOPPY_PFX),
+	SEC_DEF("cgroup/getsockopt",	CGROUP_SOCKOPT, BPF_CGROUP_GETSOCKOPT, SEC_ATTACHABLE | SEC_SLOPPY_PFX),
+	SEC_DEF("cgroup/setsockopt",	CGROUP_SOCKOPT, BPF_CGROUP_SETSOCKOPT, SEC_ATTACHABLE | SEC_SLOPPY_PFX),
+	SEC_DEF("struct_ops+",		STRUCT_OPS, 0, SEC_NONE),
 	SEC_DEF("sk_lookup/",		SK_LOOKUP, BPF_SK_LOOKUP, SEC_ATTACHABLE),
 };
 
@@ -8060,11 +8062,53 @@ static const struct bpf_sec_def section_defs[] = {
 
 static const struct bpf_sec_def *find_sec_def(const char *sec_name)
 {
-	int i, n = ARRAY_SIZE(section_defs);
+	const struct bpf_sec_def *sec_def;
+	enum sec_def_flags sec_flags;
+	int i, n = ARRAY_SIZE(section_defs), len;
+	bool strict = libbpf_mode & LIBBPF_STRICT_SEC_NAME;
 
 	for (i = 0; i < n; i++) {
-		if (str_has_pfx(sec_name, section_defs[i].sec))
-			return &section_defs[i];
+		sec_def = &section_defs[i];
+		sec_flags = sec_def->cookie;
+		len = strlen(sec_def->sec);
+
+		/* "type/" always has to have proper SEC("type/extras") form */
+		if (sec_def->sec[len - 1] == '/') {
+			if (str_has_pfx(sec_name, sec_def->sec))
+				return sec_def;
+			continue;
+		}
+
+		/* "type+" means it can be either exact SEC("type") or
+		 * well-formed SEC("type/extras") with proper '/' separator
+		 */
+		if (sec_def->sec[len - 1] == '+') {
+			len--;
+			/* not even a prefix */
+			if (strncmp(sec_name, sec_def->sec, len) != 0)
+				continue;
+			/* exact match or has '/' separator */
+			if (sec_name[len] == '\0' || sec_name[len] == '/')
+				return sec_def;
+			continue;
+		}
+
+		/* SEC_SLOPPY_PFX definitions are allowed to be just prefix
+		 * matches, unless strict section name mode
+		 * (LIBBPF_STRICT_SEC_NAME) is enabled, in which case the
+		 * match has to be exact.
+		 */
+		if ((sec_flags & SEC_SLOPPY_PFX) && !strict)  {
+			if (str_has_pfx(sec_name, sec_def->sec))
+				return sec_def;
+			continue;
+		}
+
+		/* Definitions not marked SEC_SLOPPY_PFX (e.g.,
+		 * SEC("syscall")) are exact matches in both modes.
+		 */
+		if (strcmp(sec_name, sec_def->sec) == 0)
+			return sec_def;
 	}
 	return NULL;
 }
diff --git a/tools/lib/bpf/libbpf_legacy.h b/tools/lib/bpf/libbpf_legacy.h
index df0d03dcffab..74e6f860f703 100644
--- a/tools/lib/bpf/libbpf_legacy.h
+++ b/tools/lib/bpf/libbpf_legacy.h
@@ -46,6 +46,15 @@ enum libbpf_strict_mode {
 	 */
 	LIBBPF_STRICT_DIRECT_ERRS = 0x02,
 
+	/*
+	 * Enforce strict BPF program section (SEC()) names.
+	 * E.g., while prefiously SEC("xdp_whatever") or SEC("perf_event_blah") were
+	 * allowed, with LIBBPF_STRICT_SEC_PREFIX this will become
+	 * unrecognized by libbpf and would have to be just SEC("xdp") and
+	 * SEC("xdp") and SEC("perf_event").
+	 */
+	LIBBPF_STRICT_SEC_NAME = 0x04,
+
 	__LIBBPF_STRICT_LAST,
 };
 
-- 
2.30.2

