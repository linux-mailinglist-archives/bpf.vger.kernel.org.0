Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBD7440F1EA
	for <lists+bpf@lfdr.de>; Fri, 17 Sep 2021 08:10:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232726AbhIQGMC convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Fri, 17 Sep 2021 02:12:02 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:1188 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242835AbhIQGMC (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 17 Sep 2021 02:12:02 -0400
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18GJ02X3019386
        for <bpf@vger.kernel.org>; Thu, 16 Sep 2021 23:10:40 -0700
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3b4bpnua72-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 16 Sep 2021 23:10:40 -0700
Received: from intmgw001.25.frc3.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:11d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Thu, 16 Sep 2021 23:10:39 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id D51224392FE4; Thu, 16 Sep 2021 23:10:32 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>
Subject: [PATCH bpf-next 4/9] libbpf: refactor internal sec_def handling to enable pluggability
Date:   Thu, 16 Sep 2021 23:10:15 -0700
Message-ID: <20210917061020.821711-5-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210917061020.821711-1-andrii@kernel.org>
References: <20210917061020.821711-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-GUID: Rt6xmI4czJ82o8JlH2QO_cHEuTJiCicF
X-Proofpoint-ORIG-GUID: Rt6xmI4czJ82o8JlH2QO_cHEuTJiCicF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-17_03,2021-09-16_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxlogscore=999
 spamscore=0 bulkscore=0 phishscore=0 lowpriorityscore=0 adultscore=0
 impostorscore=0 priorityscore=1501 clxscore=1034 mlxscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109030001 definitions=main-2109170038
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Refactor internals of libbpf to allow adding custom SEC() handling logic
easily from outside of libbpf. To that effect, each SEC()-handling
registration sets mandatory program type/expected attach type for
a given prefix and can provide three callbacks called at different
points of BPF program lifetime:

  - init callback for right after bpf_program is initialized and
  prog_type/expected_attach_type is set. This happens during
  bpf_object__open() step, close to the very end of constructing
  bpf_object, so all the libbpf APIs for querying and updating
  bpf_program properties should be available;

  - pre-load callback is called right before BPF_PROG_LOAD command is
  called in the kernel. This callbacks has ability to set both
  bpf_program properties, as well as program load attributes, overriding
  and augmenting the standard libbpf handling of them;

  - optional auto-attach callback, which makes a given SEC() handler
  support auto-attachment of a BPF program through bpf_program__attach()
  API and/or BPF skeletons <skel>__attach() method.

Each callbacks gets a `long cookie` parameter passed in, which is
specified during SEC() handling. This can be used by callbacks to lookup
whatever additional information is necessary.

This is not yet completely ready to be exposed to the outside world,
mainly due to non-public nature of struct bpf_prog_load_params. Instead
of making it part of public API, we'll wait until the planned low-level
libbpf API improvements for BPF_PROG_LOAD and other typical bpf()
syscall APIs, at which point we'll have a public, probably OPTS-based,
way to fully specify BPF program load parameters, which will be used as
an interface for custom pre-load callbacks.

But this change itself is already a good first step to unify the BPF
program hanling logic even within the libbpf itself. As one example, all
the extra per-program type handling (sleepable bit, attach_btf_id
resolution, unsetting optional expected attach type) is now more obvious
and is gathered in one place.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/libbpf.c | 129 +++++++++++++++++++++++++++--------------
 1 file changed, 87 insertions(+), 42 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index da65a1666a5e..8ab2edbf7a3b 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -220,7 +220,9 @@ struct reloc_desc {
 
 struct bpf_sec_def;
 
-typedef struct bpf_link *(*attach_fn_t)(const struct bpf_program *prog);
+typedef int (*init_fn_t)(struct bpf_program *prog, long cookie);
+typedef int (*preload_fn_t)(struct bpf_program *prog, struct bpf_prog_load_params *attr, long cookie);
+typedef struct bpf_link *(*attach_fn_t)(const struct bpf_program *prog, long cookie);
 
 struct bpf_sec_def {
 	const char *sec;
@@ -231,7 +233,11 @@ struct bpf_sec_def {
 	bool is_attachable;
 	bool is_attach_btf;
 	bool is_sleepable;
+
+	init_fn_t init_fn;
+	preload_fn_t preload_fn;
 	attach_fn_t attach_fn;
+	long cookie;
 };
 
 /*
@@ -6094,6 +6100,44 @@ static int bpf_object__sanitize_prog(struct bpf_object *obj, struct bpf_program
 	return 0;
 }
 
+static int libbpf_find_attach_btf_id(struct bpf_program *prog, int *btf_obj_fd, int *btf_type_id);
+
+/* this is called as prog->sec_def->preload_fn for libbpf-supported sec_defs */
+static int libbpf_preload_prog(struct bpf_program *prog,
+			       struct bpf_prog_load_params *attr, long cookie)
+{
+	/* old kernels might not support specifying expected_attach_type */
+	if (prog->sec_def->is_exp_attach_type_optional &&
+	    !kernel_supports(prog->obj, FEAT_EXP_ATTACH_TYPE))
+		attr->expected_attach_type = 0;
+
+	if (prog->sec_def->is_sleepable)
+		attr->prog_flags |= BPF_F_SLEEPABLE;
+
+	if ((prog->type == BPF_PROG_TYPE_TRACING ||
+	     prog->type == BPF_PROG_TYPE_LSM ||
+	     prog->type == BPF_PROG_TYPE_EXT) && !prog->attach_btf_id) {
+		int btf_obj_fd = 0, btf_type_id = 0, err;
+
+		err = libbpf_find_attach_btf_id(prog, &btf_obj_fd, &btf_type_id);
+		if (err)
+			return err;
+
+		/* cache resolved BTF FD and BTF type ID in the prog */
+		prog->attach_btf_obj_fd = btf_obj_fd;
+		prog->attach_btf_id = btf_type_id;
+
+		/* but by now libbpf common logic is not utilizing
+		 * prog->atach_btf_obj_fd/prog->attach_btf_id anymore because
+		 * this callback is called after attrs were populated by
+		 * libbpf, so this callback has to update attr explicitly here
+		 */
+		attr->attach_btf_obj_fd = btf_obj_fd;
+		attr->attach_btf_id = btf_type_id;
+	}
+	return 0;
+}
+
 static int
 load_program(struct bpf_program *prog, struct bpf_insn *insns, int insns_cnt,
 	     char *license, __u32 kern_version, int *pfd)
@@ -6102,7 +6146,7 @@ load_program(struct bpf_program *prog, struct bpf_insn *insns, int insns_cnt,
 	char *cp, errmsg[STRERR_BUFSIZE];
 	size_t log_buf_size = 0;
 	char *log_buf = NULL;
-	int btf_fd, ret;
+	int btf_fd, ret, err;
 
 	if (prog->type == BPF_PROG_TYPE_UNSPEC) {
 		/*
@@ -6118,22 +6162,15 @@ load_program(struct bpf_program *prog, struct bpf_insn *insns, int insns_cnt,
 		return -EINVAL;
 
 	load_attr.prog_type = prog->type;
-	/* old kernels might not support specifying expected_attach_type */
-	if (!kernel_supports(prog->obj, FEAT_EXP_ATTACH_TYPE) && prog->sec_def &&
-	    prog->sec_def->is_exp_attach_type_optional)
-		load_attr.expected_attach_type = 0;
-	else
-		load_attr.expected_attach_type = prog->expected_attach_type;
+	load_attr.expected_attach_type = prog->expected_attach_type;
 	if (kernel_supports(prog->obj, FEAT_PROG_NAME))
 		load_attr.name = prog->name;
 	load_attr.insns = insns;
 	load_attr.insn_cnt = insns_cnt;
 	load_attr.license = license;
 	load_attr.attach_btf_id = prog->attach_btf_id;
-	if (prog->attach_prog_fd)
-		load_attr.attach_prog_fd = prog->attach_prog_fd;
-	else
-		load_attr.attach_btf_obj_fd = prog->attach_btf_obj_fd;
+	load_attr.attach_prog_fd = prog->attach_prog_fd;
+	load_attr.attach_btf_obj_fd = prog->attach_btf_obj_fd;
 	load_attr.attach_btf_id = prog->attach_btf_id;
 	load_attr.kern_version = kern_version;
 	load_attr.prog_ifindex = prog->prog_ifindex;
@@ -6152,6 +6189,16 @@ load_program(struct bpf_program *prog, struct bpf_insn *insns, int insns_cnt,
 	load_attr.log_level = prog->log_level;
 	load_attr.prog_flags = prog->prog_flags;
 
+	/* adjust load_attr if sec_def provides custom preload callback */
+	if (prog->sec_def && prog->sec_def->preload_fn) {
+		err = prog->sec_def->preload_fn(prog, &load_attr, prog->sec_def->cookie);
+		if (err < 0) {
+			pr_warn("prog '%s': failed to prepare load attributes: %d\n",
+				prog->name, err);
+			return err;
+		}
+	}
+
 	if (prog->obj->gen_loader) {
 		bpf_gen__prog_load(prog->obj->gen_loader, &load_attr,
 				   prog - prog->obj->programs);
@@ -6267,8 +6314,6 @@ static int bpf_program__record_externs(struct bpf_program *prog)
 	return 0;
 }
 
-static int libbpf_find_attach_btf_id(struct bpf_program *prog, int *btf_obj_fd, int *btf_type_id);
-
 int bpf_program__load(struct bpf_program *prog, char *license, __u32 kern_ver)
 {
 	int err = 0, fd, i;
@@ -6278,19 +6323,6 @@ int bpf_program__load(struct bpf_program *prog, char *license, __u32 kern_ver)
 		return libbpf_err(-EINVAL);
 	}
 
-	if ((prog->type == BPF_PROG_TYPE_TRACING ||
-	     prog->type == BPF_PROG_TYPE_LSM ||
-	     prog->type == BPF_PROG_TYPE_EXT) && !prog->attach_btf_id) {
-		int btf_obj_fd = 0, btf_type_id = 0;
-
-		err = libbpf_find_attach_btf_id(prog, &btf_obj_fd, &btf_type_id);
-		if (err)
-			return libbpf_err(err);
-
-		prog->attach_btf_obj_fd = btf_obj_fd;
-		prog->attach_btf_id = btf_type_id;
-	}
-
 	if (prog->instances.nr < 0 || !prog->instances.fds) {
 		if (prog->preprocessor) {
 			pr_warn("Internal error: can't load program '%s'\n",
@@ -6400,6 +6432,7 @@ static const struct bpf_sec_def *find_sec_def(const char *sec_name);
 static int bpf_object_init_progs(struct bpf_object *obj, const struct bpf_object_open_opts *opts)
 {
 	struct bpf_program *prog;
+	int err;
 
 	bpf_object__for_each_program(prog, obj) {
 		prog->sec_def = find_sec_def(prog->sec_name);
@@ -6410,8 +6443,6 @@ static int bpf_object_init_progs(struct bpf_object *obj, const struct bpf_object
 			continue;
 		}
 
-		if (prog->sec_def->is_sleepable)
-			prog->prog_flags |= BPF_F_SLEEPABLE;
 		bpf_program__set_type(prog, prog->sec_def->prog_type);
 		bpf_program__set_expected_attach_type(prog, prog->sec_def->expected_attach_type);
 
@@ -6421,6 +6452,18 @@ static int bpf_object_init_progs(struct bpf_object *obj, const struct bpf_object
 		    prog->sec_def->prog_type == BPF_PROG_TYPE_EXT)
 			prog->attach_prog_fd = OPTS_GET(opts, attach_prog_fd, 0);
 #pragma GCC diagnostic pop
+
+		/* sec_def can have custom callback which should be called
+		 * after bpf_program is initialized to adjust its properties
+		 */
+		if (prog->sec_def->init_fn) {
+			err = prog->sec_def->init_fn(prog, prog->sec_def->cookie);
+			if (err < 0) {
+				pr_warn("prog '%s': failed to initialize: %d\n",
+					prog->name, err);
+				return err;
+			}
+		}
 	}
 
 	return 0;
@@ -7918,6 +7961,7 @@ void bpf_program__set_expected_attach_type(struct bpf_program *prog,
 		.is_exp_attach_type_optional = eatype_optional,		    \
 		.is_attachable = attachable,				    \
 		.is_attach_btf = attach_btf,				    \
+		.preload_fn = libbpf_preload_prog,			    \
 	}
 
 /* Programs that can NOT be attached. */
@@ -7944,15 +7988,16 @@ void bpf_program__set_expected_attach_type(struct bpf_program *prog,
 	.sec = sec_pfx,							    \
 	.len = sizeof(sec_pfx) - 1,					    \
 	.prog_type = BPF_PROG_TYPE_##ptype,				    \
+	.preload_fn = libbpf_preload_prog,				    \
 	__VA_ARGS__							    \
 }
 
-static struct bpf_link *attach_kprobe(const struct bpf_program *prog);
-static struct bpf_link *attach_tp(const struct bpf_program *prog);
-static struct bpf_link *attach_raw_tp(const struct bpf_program *prog);
-static struct bpf_link *attach_trace(const struct bpf_program *prog);
-static struct bpf_link *attach_lsm(const struct bpf_program *prog);
-static struct bpf_link *attach_iter(const struct bpf_program *prog);
+static struct bpf_link *attach_kprobe(const struct bpf_program *prog, long cookie);
+static struct bpf_link *attach_tp(const struct bpf_program *prog, long cookie);
+static struct bpf_link *attach_raw_tp(const struct bpf_program *prog, long cookie);
+static struct bpf_link *attach_trace(const struct bpf_program *prog, long cookie);
+static struct bpf_link *attach_lsm(const struct bpf_program *prog, long cookie);
+static struct bpf_link *attach_iter(const struct bpf_program *prog, long cookie);
 
 static const struct bpf_sec_def section_defs[] = {
 	BPF_PROG_SEC("socket",			BPF_PROG_TYPE_SOCKET_FILTER),
@@ -9400,7 +9445,7 @@ struct bpf_link *bpf_program__attach_kprobe(const struct bpf_program *prog,
 	return bpf_program__attach_kprobe_opts(prog, func_name, &opts);
 }
 
-static struct bpf_link *attach_kprobe(const struct bpf_program *prog)
+static struct bpf_link *attach_kprobe(const struct bpf_program *prog, long cookie)
 {
 	DECLARE_LIBBPF_OPTS(bpf_kprobe_opts, opts);
 	unsigned long offset = 0;
@@ -9573,7 +9618,7 @@ struct bpf_link *bpf_program__attach_tracepoint(const struct bpf_program *prog,
 	return bpf_program__attach_tracepoint_opts(prog, tp_category, tp_name, NULL);
 }
 
-static struct bpf_link *attach_tp(const struct bpf_program *prog)
+static struct bpf_link *attach_tp(const struct bpf_program *prog, long cookie)
 {
 	char *sec_name, *tp_cat, *tp_name;
 	struct bpf_link *link;
@@ -9627,7 +9672,7 @@ struct bpf_link *bpf_program__attach_raw_tracepoint(const struct bpf_program *pr
 	return link;
 }
 
-static struct bpf_link *attach_raw_tp(const struct bpf_program *prog)
+static struct bpf_link *attach_raw_tp(const struct bpf_program *prog, long cookie)
 {
 	const char *tp_name = prog->sec_name + prog->sec_def->len;
 
@@ -9674,12 +9719,12 @@ struct bpf_link *bpf_program__attach_lsm(const struct bpf_program *prog)
 	return bpf_program__attach_btf_id(prog);
 }
 
-static struct bpf_link *attach_trace(const struct bpf_program *prog)
+static struct bpf_link *attach_trace(const struct bpf_program *prog, long cookie)
 {
 	return bpf_program__attach_trace(prog);
 }
 
-static struct bpf_link *attach_lsm(const struct bpf_program *prog)
+static struct bpf_link *attach_lsm(const struct bpf_program *prog, long cookie)
 {
 	return bpf_program__attach_lsm(prog);
 }
@@ -9810,7 +9855,7 @@ bpf_program__attach_iter(const struct bpf_program *prog,
 	return link;
 }
 
-static struct bpf_link *attach_iter(const struct bpf_program *prog)
+static struct bpf_link *attach_iter(const struct bpf_program *prog, long cookie)
 {
 	return bpf_program__attach_iter(prog, NULL);
 }
@@ -9820,7 +9865,7 @@ struct bpf_link *bpf_program__attach(const struct bpf_program *prog)
 	if (!prog->sec_def || !prog->sec_def->attach_fn)
 		return libbpf_err_ptr(-ESRCH);
 
-	return prog->sec_def->attach_fn(prog);
+	return prog->sec_def->attach_fn(prog, prog->sec_def->cookie);
 }
 
 static int bpf_link__detach_struct_ops(struct bpf_link *link)
-- 
2.30.2

