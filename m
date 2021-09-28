Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AE1241B487
	for <lists+bpf@lfdr.de>; Tue, 28 Sep 2021 18:55:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241914AbhI1Q5Y convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Tue, 28 Sep 2021 12:57:24 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:13638 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241912AbhI1Q5U (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 28 Sep 2021 12:57:20 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18SFQLuX016424
        for <bpf@vger.kernel.org>; Tue, 28 Sep 2021 09:55:40 -0700
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3bc5pegqpm-11
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 28 Sep 2021 09:55:40 -0700
Received: from intmgw002.46.prn1.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Tue, 28 Sep 2021 09:55:35 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id AA64150F907C; Mon, 27 Sep 2021 23:20:50 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>,
        Dave Marchevsky <davemarchevsky@fb.com>
Subject: [PATCH v4 bpf-next 07/10] libbpf: refactor ELF section handler definitions
Date:   Mon, 27 Sep 2021 23:20:31 -0700
Message-ID: <20210928062034.1800660-8-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210928062034.1800660-1-andrii@kernel.org>
References: <20210928062034.1800660-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-ORIG-GUID: X1FRjU11rZcgDNxzShoxEZ3IAgBylpD8
X-Proofpoint-GUID: X1FRjU11rZcgDNxzShoxEZ3IAgBylpD8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-28_05,2021-09-28_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 phishscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 bulkscore=0 adultscore=0
 priorityscore=1501 impostorscore=0 mlxlogscore=999 spamscore=0
 malwarescore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2109230001 definitions=main-2109280099
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Refactor ELF section handler definitions table to use a set of flags and
unified SEC_DEF() macro. This allows for more succinct and table-like
set of definitions, and allows to more easily extend the logic without
adding more verbosity (this is utilized in later patches in the series).

This approach is also making libbpf-internal program pre-load callback
not rely on bpf_sec_def definition, which demonstrates that future
pluggable ELF section handlers will be able to achieve similar level of
integration without libbpf having to expose extra types and APIs.

For starters, update SEC_DEF() definitions and make them more succinct.
Also convert BPF_PROG_SEC() and BPF_APROG_COMPAT() definitions to
a common SEC_DEF() use.

Acked-by: Dave Marchevsky <davemarchevsky@fb.com>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/libbpf.c | 195 ++++++++++++++++++-----------------------
 1 file changed, 84 insertions(+), 111 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index f87ffd4d7eab..954c135a8adf 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -224,19 +224,35 @@ typedef int (*init_fn_t)(struct bpf_program *prog, long cookie);
 typedef int (*preload_fn_t)(struct bpf_program *prog, struct bpf_prog_load_params *attr, long cookie);
 typedef struct bpf_link *(*attach_fn_t)(const struct bpf_program *prog, long cookie);
 
+/* stored as sec_def->cookie for all libbpf-supported SEC()s */
+enum sec_def_flags {
+	SEC_NONE = 0,
+	/* expected_attach_type is optional, if kernel doesn't support that */
+	SEC_EXP_ATTACH_OPT = 1,
+	/* legacy, only used by libbpf_get_type_names() and
+	 * libbpf_attach_type_by_name(), not used by libbpf itself at all.
+	 * This used to be associated with cgroup (and few other) BPF programs
+	 * that were attachable through BPF_PROG_ATTACH command. Pretty
+	 * meaningless nowadays, though.
+	 */
+	SEC_ATTACHABLE = 2,
+	SEC_ATTACHABLE_OPT = SEC_ATTACHABLE | SEC_EXP_ATTACH_OPT,
+	/* attachment target is specified through BTF ID in either kernel or
+	 * other BPF program's BTF object */
+	SEC_ATTACH_BTF = 4,
+	/* BPF program type allows sleeping/blocking in kernel */
+	SEC_SLEEPABLE = 8,
+};
+
 struct bpf_sec_def {
 	const char *sec;
 	enum bpf_prog_type prog_type;
 	enum bpf_attach_type expected_attach_type;
-	bool is_exp_attach_type_optional;
-	bool is_attachable;
-	bool is_attach_btf;
-	bool is_sleepable;
+	long cookie;
 
 	init_fn_t init_fn;
 	preload_fn_t preload_fn;
 	attach_fn_t attach_fn;
-	long cookie;
 };
 
 /*
@@ -6100,26 +6116,30 @@ static int bpf_object__sanitize_prog(struct bpf_object *obj, struct bpf_program
 	return 0;
 }
 
-static int libbpf_find_attach_btf_id(struct bpf_program *prog, int *btf_obj_fd, int *btf_type_id);
+static int libbpf_find_attach_btf_id(struct bpf_program *prog, const char *attach_name,
+				     int *btf_obj_fd, int *btf_type_id);
 
 /* this is called as prog->sec_def->preload_fn for libbpf-supported sec_defs */
 static int libbpf_preload_prog(struct bpf_program *prog,
 			       struct bpf_prog_load_params *attr, long cookie)
 {
+	enum sec_def_flags def = cookie;
+
 	/* old kernels might not support specifying expected_attach_type */
-	if (prog->sec_def->is_exp_attach_type_optional &&
-	    !kernel_supports(prog->obj, FEAT_EXP_ATTACH_TYPE))
+	if ((def & SEC_EXP_ATTACH_OPT) && !kernel_supports(prog->obj, FEAT_EXP_ATTACH_TYPE))
 		attr->expected_attach_type = 0;
 
-	if (prog->sec_def->is_sleepable)
+	if (def & SEC_SLEEPABLE)
 		attr->prog_flags |= BPF_F_SLEEPABLE;
 
 	if ((prog->type == BPF_PROG_TYPE_TRACING ||
 	     prog->type == BPF_PROG_TYPE_LSM ||
 	     prog->type == BPF_PROG_TYPE_EXT) && !prog->attach_btf_id) {
 		int btf_obj_fd = 0, btf_type_id = 0, err;
+		const char *attach_name;
 
-		err = libbpf_find_attach_btf_id(prog, &btf_obj_fd, &btf_type_id);
+		attach_name = strchr(prog->sec_name, '/') + 1;
+		err = libbpf_find_attach_btf_id(prog, attach_name, &btf_obj_fd, &btf_type_id);
 		if (err)
 			return err;
 
@@ -7956,15 +7976,14 @@ void bpf_program__set_expected_attach_type(struct bpf_program *prog,
 		.sec = string,						    \
 		.prog_type = ptype,					    \
 		.expected_attach_type = eatype,				    \
-		.is_exp_attach_type_optional = eatype_optional,		    \
-		.is_attachable = attachable,				    \
-		.is_attach_btf = attach_btf,				    \
+		.cookie = (long) (					    \
+			(eatype_optional ? SEC_EXP_ATTACH_OPT : 0) |   \
+			(attachable ? SEC_ATTACHABLE : 0) |		    \
+			(attach_btf ? SEC_ATTACH_BTF : 0)		    \
+		),							    \
 		.preload_fn = libbpf_preload_prog,			    \
 	}
 
-/* Programs that can NOT be attached. */
-#define BPF_PROG_SEC(string, ptype) BPF_PROG_SEC_IMPL(string, ptype, 0, 0, 0, 0)
-
 /* Programs that can be attached. */
 #define BPF_APROG_SEC(string, ptype, atype) \
 	BPF_PROG_SEC_IMPL(string, ptype, atype, true, 1, 0)
@@ -7977,14 +7996,11 @@ void bpf_program__set_expected_attach_type(struct bpf_program *prog,
 #define BPF_PROG_BTF(string, ptype, eatype) \
 	BPF_PROG_SEC_IMPL(string, ptype, eatype, false, 0, 1)
 
-/* Programs that can be attached but attach type can't be identified by section
- * name. Kept for backward compatibility.
- */
-#define BPF_APROG_COMPAT(string, ptype) BPF_PROG_SEC(string, ptype)
-
-#define SEC_DEF(sec_pfx, ptype, ...) {					    \
+#define SEC_DEF(sec_pfx, ptype, atype, flags, ...) {			    \
 	.sec = sec_pfx,							    \
 	.prog_type = BPF_PROG_TYPE_##ptype,				    \
+	.expected_attach_type = atype,					    \
+	.cookie = (long)(flags),					    \
 	.preload_fn = libbpf_preload_prog,				    \
 	__VA_ARGS__							    \
 }
@@ -7997,93 +8013,50 @@ static struct bpf_link *attach_lsm(const struct bpf_program *prog, long cookie);
 static struct bpf_link *attach_iter(const struct bpf_program *prog, long cookie);
 
 static const struct bpf_sec_def section_defs[] = {
-	BPF_PROG_SEC("socket",			BPF_PROG_TYPE_SOCKET_FILTER),
+	SEC_DEF("socket",		SOCKET_FILTER, 0, SEC_NONE),
 	BPF_EAPROG_SEC("sk_reuseport/migrate",	BPF_PROG_TYPE_SK_REUSEPORT,
 						BPF_SK_REUSEPORT_SELECT_OR_MIGRATE),
 	BPF_EAPROG_SEC("sk_reuseport",		BPF_PROG_TYPE_SK_REUSEPORT,
 						BPF_SK_REUSEPORT_SELECT),
-	SEC_DEF("kprobe/", KPROBE,
-		.attach_fn = attach_kprobe),
-	BPF_PROG_SEC("uprobe/",			BPF_PROG_TYPE_KPROBE),
-	SEC_DEF("kretprobe/", KPROBE,
-		.attach_fn = attach_kprobe),
-	BPF_PROG_SEC("uretprobe/",		BPF_PROG_TYPE_KPROBE),
-	BPF_PROG_SEC("classifier",		BPF_PROG_TYPE_SCHED_CLS),
-	BPF_PROG_SEC("tc",			BPF_PROG_TYPE_SCHED_CLS),
-	BPF_PROG_SEC("action",			BPF_PROG_TYPE_SCHED_ACT),
-	SEC_DEF("tracepoint/", TRACEPOINT,
-		.attach_fn = attach_tp),
-	SEC_DEF("tp/", TRACEPOINT,
-		.attach_fn = attach_tp),
-	SEC_DEF("raw_tracepoint/", RAW_TRACEPOINT,
-		.attach_fn = attach_raw_tp),
-	SEC_DEF("raw_tp/", RAW_TRACEPOINT,
-		.attach_fn = attach_raw_tp),
-	SEC_DEF("tp_btf/", TRACING,
-		.expected_attach_type = BPF_TRACE_RAW_TP,
-		.is_attach_btf = true,
-		.attach_fn = attach_trace),
-	SEC_DEF("fentry/", TRACING,
-		.expected_attach_type = BPF_TRACE_FENTRY,
-		.is_attach_btf = true,
-		.attach_fn = attach_trace),
-	SEC_DEF("fmod_ret/", TRACING,
-		.expected_attach_type = BPF_MODIFY_RETURN,
-		.is_attach_btf = true,
-		.attach_fn = attach_trace),
-	SEC_DEF("fexit/", TRACING,
-		.expected_attach_type = BPF_TRACE_FEXIT,
-		.is_attach_btf = true,
-		.attach_fn = attach_trace),
-	SEC_DEF("fentry.s/", TRACING,
-		.expected_attach_type = BPF_TRACE_FENTRY,
-		.is_attach_btf = true,
-		.is_sleepable = true,
-		.attach_fn = attach_trace),
-	SEC_DEF("fmod_ret.s/", TRACING,
-		.expected_attach_type = BPF_MODIFY_RETURN,
-		.is_attach_btf = true,
-		.is_sleepable = true,
-		.attach_fn = attach_trace),
-	SEC_DEF("fexit.s/", TRACING,
-		.expected_attach_type = BPF_TRACE_FEXIT,
-		.is_attach_btf = true,
-		.is_sleepable = true,
-		.attach_fn = attach_trace),
-	SEC_DEF("freplace/", EXT,
-		.is_attach_btf = true,
-		.attach_fn = attach_trace),
-	SEC_DEF("lsm/", LSM,
-		.is_attach_btf = true,
-		.expected_attach_type = BPF_LSM_MAC,
-		.attach_fn = attach_lsm),
-	SEC_DEF("lsm.s/", LSM,
-		.is_attach_btf = true,
-		.is_sleepable = true,
-		.expected_attach_type = BPF_LSM_MAC,
-		.attach_fn = attach_lsm),
-	SEC_DEF("iter/", TRACING,
-		.expected_attach_type = BPF_TRACE_ITER,
-		.is_attach_btf = true,
-		.attach_fn = attach_iter),
-	SEC_DEF("syscall", SYSCALL,
-		.is_sleepable = true),
+	SEC_DEF("kprobe/",		KPROBE,	0, SEC_NONE, attach_kprobe),
+	SEC_DEF("uprobe/",		KPROBE,	0, SEC_NONE),
+	SEC_DEF("kretprobe/",		KPROBE, 0, SEC_NONE, attach_kprobe),
+	SEC_DEF("uretprobe/",		KPROBE, 0, SEC_NONE),
+	SEC_DEF("classifier",		SCHED_CLS, 0, SEC_NONE),
+	SEC_DEF("tc",			SCHED_CLS, 0, SEC_NONE),
+	SEC_DEF("action",		SCHED_ACT, 0, SEC_NONE),
+	SEC_DEF("tracepoint/",		TRACEPOINT, 0, SEC_NONE, attach_tp),
+	SEC_DEF("tp/",			TRACEPOINT, 0, SEC_NONE, attach_tp),
+	SEC_DEF("raw_tracepoint/",	RAW_TRACEPOINT, 0, SEC_NONE, attach_raw_tp),
+	SEC_DEF("raw_tp/",		RAW_TRACEPOINT, 0, SEC_NONE, attach_raw_tp),
+	SEC_DEF("tp_btf/",		TRACING, BPF_TRACE_RAW_TP, SEC_ATTACH_BTF, attach_trace),
+	SEC_DEF("fentry/",		TRACING, BPF_TRACE_FENTRY, SEC_ATTACH_BTF, attach_trace),
+	SEC_DEF("fmod_ret/",		TRACING, BPF_MODIFY_RETURN, SEC_ATTACH_BTF, attach_trace),
+	SEC_DEF("fexit/",		TRACING, BPF_TRACE_FEXIT, SEC_ATTACH_BTF, attach_trace),
+	SEC_DEF("fentry.s/",		TRACING, BPF_TRACE_FENTRY, SEC_ATTACH_BTF | SEC_SLEEPABLE, attach_trace),
+	SEC_DEF("fmod_ret.s/",		TRACING, BPF_MODIFY_RETURN, SEC_ATTACH_BTF | SEC_SLEEPABLE, attach_trace),
+	SEC_DEF("fexit.s/",		TRACING, BPF_TRACE_FEXIT, SEC_ATTACH_BTF | SEC_SLEEPABLE, attach_trace),
+	SEC_DEF("freplace/",		EXT, 0, SEC_ATTACH_BTF, attach_trace),
+	SEC_DEF("lsm/",			LSM, BPF_LSM_MAC, SEC_ATTACH_BTF, attach_lsm),
+	SEC_DEF("lsm.s/",		LSM, BPF_LSM_MAC, SEC_ATTACH_BTF | SEC_SLEEPABLE, attach_lsm),
+	SEC_DEF("iter/",		TRACING, BPF_TRACE_ITER, SEC_ATTACH_BTF, attach_iter),
+	SEC_DEF("syscall",		SYSCALL, 0, SEC_SLEEPABLE),
 	BPF_EAPROG_SEC("xdp_devmap/",		BPF_PROG_TYPE_XDP,
 						BPF_XDP_DEVMAP),
 	BPF_EAPROG_SEC("xdp_cpumap/",		BPF_PROG_TYPE_XDP,
 						BPF_XDP_CPUMAP),
 	BPF_APROG_SEC("xdp",			BPF_PROG_TYPE_XDP,
 						BPF_XDP),
-	BPF_PROG_SEC("perf_event",		BPF_PROG_TYPE_PERF_EVENT),
-	BPF_PROG_SEC("lwt_in",			BPF_PROG_TYPE_LWT_IN),
-	BPF_PROG_SEC("lwt_out",			BPF_PROG_TYPE_LWT_OUT),
-	BPF_PROG_SEC("lwt_xmit",		BPF_PROG_TYPE_LWT_XMIT),
-	BPF_PROG_SEC("lwt_seg6local",		BPF_PROG_TYPE_LWT_SEG6LOCAL),
+	SEC_DEF("perf_event",		PERF_EVENT, 0, SEC_NONE),
+	SEC_DEF("lwt_in",		LWT_IN, 0, SEC_NONE),
+	SEC_DEF("lwt_out",		LWT_OUT, 0, SEC_NONE),
+	SEC_DEF("lwt_xmit",		LWT_XMIT, 0, SEC_NONE),
+	SEC_DEF("lwt_seg6local",	LWT_SEG6LOCAL, 0, SEC_NONE),
 	BPF_APROG_SEC("cgroup_skb/ingress",	BPF_PROG_TYPE_CGROUP_SKB,
 						BPF_CGROUP_INET_INGRESS),
 	BPF_APROG_SEC("cgroup_skb/egress",	BPF_PROG_TYPE_CGROUP_SKB,
 						BPF_CGROUP_INET_EGRESS),
-	BPF_APROG_COMPAT("cgroup/skb",		BPF_PROG_TYPE_CGROUP_SKB),
+	SEC_DEF("cgroup/skb",		CGROUP_SKB, 0, SEC_NONE),
 	BPF_EAPROG_SEC("cgroup/sock_create",	BPF_PROG_TYPE_CGROUP_SOCK,
 						BPF_CGROUP_INET_SOCK_CREATE),
 	BPF_EAPROG_SEC("cgroup/sock_release",	BPF_PROG_TYPE_CGROUP_SOCK,
@@ -8102,7 +8075,7 @@ static const struct bpf_sec_def section_defs[] = {
 						BPF_SK_SKB_STREAM_PARSER),
 	BPF_APROG_SEC("sk_skb/stream_verdict",	BPF_PROG_TYPE_SK_SKB,
 						BPF_SK_SKB_STREAM_VERDICT),
-	BPF_APROG_COMPAT("sk_skb",		BPF_PROG_TYPE_SK_SKB),
+	SEC_DEF("sk_skb",		SK_SKB, 0, SEC_NONE),
 	BPF_APROG_SEC("sk_msg",			BPF_PROG_TYPE_SK_MSG,
 						BPF_SK_MSG_VERDICT),
 	BPF_APROG_SEC("lirc_mode2",		BPF_PROG_TYPE_LIRC_MODE2,
@@ -8139,16 +8112,14 @@ static const struct bpf_sec_def section_defs[] = {
 						BPF_CGROUP_GETSOCKOPT),
 	BPF_EAPROG_SEC("cgroup/setsockopt",	BPF_PROG_TYPE_CGROUP_SOCKOPT,
 						BPF_CGROUP_SETSOCKOPT),
-	BPF_PROG_SEC("struct_ops",		BPF_PROG_TYPE_STRUCT_OPS),
+	SEC_DEF("struct_ops",		STRUCT_OPS, 0, SEC_NONE),
 	BPF_EAPROG_SEC("sk_lookup/",		BPF_PROG_TYPE_SK_LOOKUP,
 						BPF_SK_LOOKUP),
 };
 
 #undef BPF_PROG_SEC_IMPL
-#undef BPF_PROG_SEC
 #undef BPF_APROG_SEC
 #undef BPF_EAPROG_SEC
-#undef BPF_APROG_COMPAT
 #undef SEC_DEF
 
 #define MAX_TYPE_NAME_SIZE 32
@@ -8176,8 +8147,15 @@ static char *libbpf_get_type_names(bool attach_type)
 	buf[0] = '\0';
 	/* Forge string buf with all available names */
 	for (i = 0; i < ARRAY_SIZE(section_defs); i++) {
-		if (attach_type && !section_defs[i].is_attachable)
-			continue;
+		const struct bpf_sec_def *sec_def = &section_defs[i];
+
+		if (attach_type) {
+			if (sec_def->preload_fn != libbpf_preload_prog)
+				continue;
+
+			if (!(sec_def->cookie & SEC_ATTACHABLE))
+				continue;
+		}
 
 		if (strlen(buf) + strlen(section_defs[i].sec) + 2 > len) {
 			free(buf);
@@ -8501,20 +8479,13 @@ static int find_kernel_btf_id(struct bpf_object *obj, const char *attach_name,
 	return -ESRCH;
 }
 
-static int libbpf_find_attach_btf_id(struct bpf_program *prog, int *btf_obj_fd, int *btf_type_id)
+static int libbpf_find_attach_btf_id(struct bpf_program *prog, const char *attach_name,
+				     int *btf_obj_fd, int *btf_type_id)
 {
 	enum bpf_attach_type attach_type = prog->expected_attach_type;
 	__u32 attach_prog_fd = prog->attach_prog_fd;
-	const char *attach_name;
 	int err = 0;
 
-	if (!prog->sec_def || !prog->sec_def->is_attach_btf) {
-		pr_warn("failed to identify BTF ID based on ELF section name '%s'\n",
-			prog->sec_name);
-		return -ESRCH;
-	}
-	attach_name = prog->sec_name + strlen(prog->sec_def->sec);
-
 	/* BPF program's BTF ID */
 	if (attach_prog_fd) {
 		err = libbpf_find_prog_btf_id(attach_name, attach_prog_fd);
@@ -8564,7 +8535,9 @@ int libbpf_attach_type_by_name(const char *name,
 		return libbpf_err(-EINVAL);
 	}
 
-	if (!sec_def->is_attachable)
+	if (sec_def->preload_fn != libbpf_preload_prog)
+		return libbpf_err(-EINVAL);
+	if (!(sec_def->cookie & SEC_ATTACHABLE))
 		return libbpf_err(-EINVAL);
 
 	*attach_type = sec_def->expected_attach_type;
-- 
2.30.2

