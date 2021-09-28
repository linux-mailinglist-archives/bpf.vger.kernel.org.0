Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B811F41B485
	for <lists+bpf@lfdr.de>; Tue, 28 Sep 2021 18:55:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241781AbhI1Q5V convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Tue, 28 Sep 2021 12:57:21 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:11762 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241899AbhI1Q5S (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 28 Sep 2021 12:57:18 -0400
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18SEVBhh013548
        for <bpf@vger.kernel.org>; Tue, 28 Sep 2021 09:55:37 -0700
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3bc4vn16hq-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 28 Sep 2021 09:55:36 -0700
Received: from intmgw002.25.frc3.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:21d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Tue, 28 Sep 2021 09:55:33 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 14FAC50F90E2; Mon, 27 Sep 2021 23:20:52 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>,
        Dave Marchevsky <davemarchevsky@fb.com>
Subject: [PATCH v4 bpf-next 08/10] libbpf: complete SEC() table unification for BPF_APROG_SEC/BPF_EAPROG_SEC
Date:   Mon, 27 Sep 2021 23:20:32 -0700
Message-ID: <20210928062034.1800660-9-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210928062034.1800660-1-andrii@kernel.org>
References: <20210928062034.1800660-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-GUID: sdCgLdJ_-NaPZD0RkyqCMTuVBb-cY9u_
X-Proofpoint-ORIG-GUID: sdCgLdJ_-NaPZD0RkyqCMTuVBb-cY9u_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-28_05,2021-09-28_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 impostorscore=0 suspectscore=0 adultscore=0 clxscore=1015 mlxlogscore=999
 phishscore=0 mlxscore=0 bulkscore=0 lowpriorityscore=0 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2109280099
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Complete SEC() table refactoring towards unified form by rewriting
BPF_APROG_SEC and BPF_EAPROG_SEC definitions with
SEC_DEF(SEC_ATTACHABLE_OPT) (for optional expected_attach_type) and
SEC_DEF(SEC_ATTACHABLE) (mandatory expected_attach_type), respectively.
Drop BPF_APROG_SEC, BPF_EAPROG_SEC, and BPF_PROG_SEC_IMPL macros after
that, leaving SEC_DEF() macro as the only one used.

Acked-by: Dave Marchevsky <davemarchevsky@fb.com>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/libbpf.c | 136 +++++++++++------------------------------
 1 file changed, 35 insertions(+), 101 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 954c135a8adf..4ba67dff6b0d 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -7970,32 +7970,6 @@ void bpf_program__set_expected_attach_type(struct bpf_program *prog,
 	prog->expected_attach_type = type;
 }
 
-#define BPF_PROG_SEC_IMPL(string, ptype, eatype, eatype_optional,	    \
-			  attachable, attach_btf)			    \
-	{								    \
-		.sec = string,						    \
-		.prog_type = ptype,					    \
-		.expected_attach_type = eatype,				    \
-		.cookie = (long) (					    \
-			(eatype_optional ? SEC_EXP_ATTACH_OPT : 0) |   \
-			(attachable ? SEC_ATTACHABLE : 0) |		    \
-			(attach_btf ? SEC_ATTACH_BTF : 0)		    \
-		),							    \
-		.preload_fn = libbpf_preload_prog,			    \
-	}
-
-/* Programs that can be attached. */
-#define BPF_APROG_SEC(string, ptype, atype) \
-	BPF_PROG_SEC_IMPL(string, ptype, atype, true, 1, 0)
-
-/* Programs that must specify expected attach type at load time. */
-#define BPF_EAPROG_SEC(string, ptype, eatype) \
-	BPF_PROG_SEC_IMPL(string, ptype, eatype, false, 1, 0)
-
-/* Programs that use BTF to identify attach point */
-#define BPF_PROG_BTF(string, ptype, eatype) \
-	BPF_PROG_SEC_IMPL(string, ptype, eatype, false, 0, 1)
-
 #define SEC_DEF(sec_pfx, ptype, atype, flags, ...) {			    \
 	.sec = sec_pfx,							    \
 	.prog_type = BPF_PROG_TYPE_##ptype,				    \
@@ -8014,10 +7988,8 @@ static struct bpf_link *attach_iter(const struct bpf_program *prog, long cookie)
 
 static const struct bpf_sec_def section_defs[] = {
 	SEC_DEF("socket",		SOCKET_FILTER, 0, SEC_NONE),
-	BPF_EAPROG_SEC("sk_reuseport/migrate",	BPF_PROG_TYPE_SK_REUSEPORT,
-						BPF_SK_REUSEPORT_SELECT_OR_MIGRATE),
-	BPF_EAPROG_SEC("sk_reuseport",		BPF_PROG_TYPE_SK_REUSEPORT,
-						BPF_SK_REUSEPORT_SELECT),
+	SEC_DEF("sk_reuseport/migrate",	SK_REUSEPORT, BPF_SK_REUSEPORT_SELECT_OR_MIGRATE, SEC_ATTACHABLE),
+	SEC_DEF("sk_reuseport",		SK_REUSEPORT, BPF_SK_REUSEPORT_SELECT, SEC_ATTACHABLE),
 	SEC_DEF("kprobe/",		KPROBE,	0, SEC_NONE, attach_kprobe),
 	SEC_DEF("uprobe/",		KPROBE,	0, SEC_NONE),
 	SEC_DEF("kretprobe/",		KPROBE, 0, SEC_NONE, attach_kprobe),
@@ -8041,87 +8013,49 @@ static const struct bpf_sec_def section_defs[] = {
 	SEC_DEF("lsm.s/",		LSM, BPF_LSM_MAC, SEC_ATTACH_BTF | SEC_SLEEPABLE, attach_lsm),
 	SEC_DEF("iter/",		TRACING, BPF_TRACE_ITER, SEC_ATTACH_BTF, attach_iter),
 	SEC_DEF("syscall",		SYSCALL, 0, SEC_SLEEPABLE),
-	BPF_EAPROG_SEC("xdp_devmap/",		BPF_PROG_TYPE_XDP,
-						BPF_XDP_DEVMAP),
-	BPF_EAPROG_SEC("xdp_cpumap/",		BPF_PROG_TYPE_XDP,
-						BPF_XDP_CPUMAP),
-	BPF_APROG_SEC("xdp",			BPF_PROG_TYPE_XDP,
-						BPF_XDP),
+	SEC_DEF("xdp_devmap/",		XDP, BPF_XDP_DEVMAP, SEC_ATTACHABLE),
+	SEC_DEF("xdp_cpumap/",		XDP, BPF_XDP_CPUMAP, SEC_ATTACHABLE),
+	SEC_DEF("xdp",			XDP, BPF_XDP, SEC_ATTACHABLE_OPT),
 	SEC_DEF("perf_event",		PERF_EVENT, 0, SEC_NONE),
 	SEC_DEF("lwt_in",		LWT_IN, 0, SEC_NONE),
 	SEC_DEF("lwt_out",		LWT_OUT, 0, SEC_NONE),
 	SEC_DEF("lwt_xmit",		LWT_XMIT, 0, SEC_NONE),
 	SEC_DEF("lwt_seg6local",	LWT_SEG6LOCAL, 0, SEC_NONE),
-	BPF_APROG_SEC("cgroup_skb/ingress",	BPF_PROG_TYPE_CGROUP_SKB,
-						BPF_CGROUP_INET_INGRESS),
-	BPF_APROG_SEC("cgroup_skb/egress",	BPF_PROG_TYPE_CGROUP_SKB,
-						BPF_CGROUP_INET_EGRESS),
+	SEC_DEF("cgroup_skb/ingress",	CGROUP_SKB, BPF_CGROUP_INET_INGRESS, SEC_ATTACHABLE_OPT),
+	SEC_DEF("cgroup_skb/egress",	CGROUP_SKB, BPF_CGROUP_INET_EGRESS, SEC_ATTACHABLE_OPT),
 	SEC_DEF("cgroup/skb",		CGROUP_SKB, 0, SEC_NONE),
-	BPF_EAPROG_SEC("cgroup/sock_create",	BPF_PROG_TYPE_CGROUP_SOCK,
-						BPF_CGROUP_INET_SOCK_CREATE),
-	BPF_EAPROG_SEC("cgroup/sock_release",	BPF_PROG_TYPE_CGROUP_SOCK,
-						BPF_CGROUP_INET_SOCK_RELEASE),
-	BPF_APROG_SEC("cgroup/sock",		BPF_PROG_TYPE_CGROUP_SOCK,
-						BPF_CGROUP_INET_SOCK_CREATE),
-	BPF_EAPROG_SEC("cgroup/post_bind4",	BPF_PROG_TYPE_CGROUP_SOCK,
-						BPF_CGROUP_INET4_POST_BIND),
-	BPF_EAPROG_SEC("cgroup/post_bind6",	BPF_PROG_TYPE_CGROUP_SOCK,
-						BPF_CGROUP_INET6_POST_BIND),
-	BPF_APROG_SEC("cgroup/dev",		BPF_PROG_TYPE_CGROUP_DEVICE,
-						BPF_CGROUP_DEVICE),
-	BPF_APROG_SEC("sockops",		BPF_PROG_TYPE_SOCK_OPS,
-						BPF_CGROUP_SOCK_OPS),
-	BPF_APROG_SEC("sk_skb/stream_parser",	BPF_PROG_TYPE_SK_SKB,
-						BPF_SK_SKB_STREAM_PARSER),
-	BPF_APROG_SEC("sk_skb/stream_verdict",	BPF_PROG_TYPE_SK_SKB,
-						BPF_SK_SKB_STREAM_VERDICT),
+	SEC_DEF("cgroup/sock_create",	CGROUP_SOCK, BPF_CGROUP_INET_SOCK_CREATE, SEC_ATTACHABLE),
+	SEC_DEF("cgroup/sock_release",	CGROUP_SOCK, BPF_CGROUP_INET_SOCK_RELEASE, SEC_ATTACHABLE),
+	SEC_DEF("cgroup/sock",		CGROUP_SOCK, BPF_CGROUP_INET_SOCK_CREATE, SEC_ATTACHABLE_OPT),
+	SEC_DEF("cgroup/post_bind4",	CGROUP_SOCK, BPF_CGROUP_INET4_POST_BIND, SEC_ATTACHABLE),
+	SEC_DEF("cgroup/post_bind6",	CGROUP_SOCK, BPF_CGROUP_INET6_POST_BIND, SEC_ATTACHABLE),
+	SEC_DEF("cgroup/dev",		CGROUP_DEVICE, BPF_CGROUP_DEVICE, SEC_ATTACHABLE_OPT),
+	SEC_DEF("sockops",		SOCK_OPS, BPF_CGROUP_SOCK_OPS, SEC_ATTACHABLE_OPT),
+	SEC_DEF("sk_skb/stream_parser",	SK_SKB, BPF_SK_SKB_STREAM_PARSER, SEC_ATTACHABLE_OPT),
+	SEC_DEF("sk_skb/stream_verdict",SK_SKB, BPF_SK_SKB_STREAM_VERDICT, SEC_ATTACHABLE_OPT),
 	SEC_DEF("sk_skb",		SK_SKB, 0, SEC_NONE),
-	BPF_APROG_SEC("sk_msg",			BPF_PROG_TYPE_SK_MSG,
-						BPF_SK_MSG_VERDICT),
-	BPF_APROG_SEC("lirc_mode2",		BPF_PROG_TYPE_LIRC_MODE2,
-						BPF_LIRC_MODE2),
-	BPF_APROG_SEC("flow_dissector",		BPF_PROG_TYPE_FLOW_DISSECTOR,
-						BPF_FLOW_DISSECTOR),
-	BPF_EAPROG_SEC("cgroup/bind4",		BPF_PROG_TYPE_CGROUP_SOCK_ADDR,
-						BPF_CGROUP_INET4_BIND),
-	BPF_EAPROG_SEC("cgroup/bind6",		BPF_PROG_TYPE_CGROUP_SOCK_ADDR,
-						BPF_CGROUP_INET6_BIND),
-	BPF_EAPROG_SEC("cgroup/connect4",	BPF_PROG_TYPE_CGROUP_SOCK_ADDR,
-						BPF_CGROUP_INET4_CONNECT),
-	BPF_EAPROG_SEC("cgroup/connect6",	BPF_PROG_TYPE_CGROUP_SOCK_ADDR,
-						BPF_CGROUP_INET6_CONNECT),
-	BPF_EAPROG_SEC("cgroup/sendmsg4",	BPF_PROG_TYPE_CGROUP_SOCK_ADDR,
-						BPF_CGROUP_UDP4_SENDMSG),
-	BPF_EAPROG_SEC("cgroup/sendmsg6",	BPF_PROG_TYPE_CGROUP_SOCK_ADDR,
-						BPF_CGROUP_UDP6_SENDMSG),
-	BPF_EAPROG_SEC("cgroup/recvmsg4",	BPF_PROG_TYPE_CGROUP_SOCK_ADDR,
-						BPF_CGROUP_UDP4_RECVMSG),
-	BPF_EAPROG_SEC("cgroup/recvmsg6",	BPF_PROG_TYPE_CGROUP_SOCK_ADDR,
-						BPF_CGROUP_UDP6_RECVMSG),
-	BPF_EAPROG_SEC("cgroup/getpeername4",	BPF_PROG_TYPE_CGROUP_SOCK_ADDR,
-						BPF_CGROUP_INET4_GETPEERNAME),
-	BPF_EAPROG_SEC("cgroup/getpeername6",	BPF_PROG_TYPE_CGROUP_SOCK_ADDR,
-						BPF_CGROUP_INET6_GETPEERNAME),
-	BPF_EAPROG_SEC("cgroup/getsockname4",	BPF_PROG_TYPE_CGROUP_SOCK_ADDR,
-						BPF_CGROUP_INET4_GETSOCKNAME),
-	BPF_EAPROG_SEC("cgroup/getsockname6",	BPF_PROG_TYPE_CGROUP_SOCK_ADDR,
-						BPF_CGROUP_INET6_GETSOCKNAME),
-	BPF_EAPROG_SEC("cgroup/sysctl",		BPF_PROG_TYPE_CGROUP_SYSCTL,
-						BPF_CGROUP_SYSCTL),
-	BPF_EAPROG_SEC("cgroup/getsockopt",	BPF_PROG_TYPE_CGROUP_SOCKOPT,
-						BPF_CGROUP_GETSOCKOPT),
-	BPF_EAPROG_SEC("cgroup/setsockopt",	BPF_PROG_TYPE_CGROUP_SOCKOPT,
-						BPF_CGROUP_SETSOCKOPT),
+	SEC_DEF("sk_msg",		SK_MSG, BPF_SK_MSG_VERDICT, SEC_ATTACHABLE_OPT),
+	SEC_DEF("lirc_mode2",		LIRC_MODE2, BPF_LIRC_MODE2, SEC_ATTACHABLE_OPT),
+	SEC_DEF("flow_dissector",	FLOW_DISSECTOR, BPF_FLOW_DISSECTOR, SEC_ATTACHABLE_OPT),
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
 	SEC_DEF("struct_ops",		STRUCT_OPS, 0, SEC_NONE),
-	BPF_EAPROG_SEC("sk_lookup/",		BPF_PROG_TYPE_SK_LOOKUP,
-						BPF_SK_LOOKUP),
+	SEC_DEF("sk_lookup/",		SK_LOOKUP, BPF_SK_LOOKUP, SEC_ATTACHABLE),
 };
 
-#undef BPF_PROG_SEC_IMPL
-#undef BPF_APROG_SEC
-#undef BPF_EAPROG_SEC
-#undef SEC_DEF
-
 #define MAX_TYPE_NAME_SIZE 32
 
 static const struct bpf_sec_def *find_sec_def(const char *sec_name)
-- 
2.30.2

