Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26C3B4CE1C7
	for <lists+bpf@lfdr.de>; Sat,  5 Mar 2022 02:01:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229627AbiCEBCa convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Fri, 4 Mar 2022 20:02:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbiCEBC2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 4 Mar 2022 20:02:28 -0500
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 683AE1AE677
        for <bpf@vger.kernel.org>; Fri,  4 Mar 2022 17:01:39 -0800 (PST)
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 224HQYBQ021594
        for <bpf@vger.kernel.org>; Fri, 4 Mar 2022 17:01:38 -0800
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3ek4je9g6j-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 04 Mar 2022 17:01:38 -0800
Received: from twshared13930.42.prn1.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Fri, 4 Mar 2022 17:01:37 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 33CFB132C992D; Fri,  4 Mar 2022 17:01:32 -0800 (PST)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v5 bpf-next 1/3] libbpf: allow BPF program auto-attach handlers to bail out
Date:   Fri, 4 Mar 2022 17:01:27 -0800
Message-ID: <20220305010129.1549719-2-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220305010129.1549719-1-andrii@kernel.org>
References: <20220305010129.1549719-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: qAh7KAApSxVkc1nii6tKM8sxfMUAX2IH
X-Proofpoint-ORIG-GUID: qAh7KAApSxVkc1nii6tKM8sxfMUAX2IH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-04_09,2022-03-04_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 priorityscore=1501
 phishscore=0 mlxscore=0 bulkscore=0 adultscore=0 impostorscore=0
 suspectscore=0 malwarescore=0 clxscore=1015 mlxlogscore=999
 lowpriorityscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2202240000 definitions=main-2203050002
X-FB-Internal: deliver
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Allow some BPF program types to support auto-attach only in subste of
cases. Currently, if some BPF program type specifies attach callback, it
is assumed that during skeleton attach operation all such programs
either successfully attach or entire skeleton attachment fails. If some
program doesn't support auto-attachment from skeleton, such BPF program
types shouldn't have attach callback specified.

This is limiting for cases when, depending on how full the SEC("")
definition is, there could either be enough details to support
auto-attach or there might not be and user has to use some specific API
to provide more details at runtime.

One specific example of such desired behavior might be SEC("uprobe"). If
it's specified as just uprobe auto-attach isn't possible. But if it's
SEC("uprobe/<some_binary>:<some_func>") then there are enough details to
support auto-attach. Note that there is a somewhat subtle difference
between auto-attach behavior of BPF skeleton and using "generic"
bpf_program__attach(prog) (which uses the same attach handlers under the
cover). Skeleton allow some programs within bpf_object to not have
auto-attach implemented and doesn't treat that as an error. Instead such
BPF programs are just skipped during skeleton's (optional) attach step.
bpf_program__attach(), on the other hand, is called when user *expects*
auto-attach to work, so if specified program doesn't implement or
doesn't support auto-attach functionality, that will be treated as an
error.

Another improvement to the way libbpf is handling SEC()s would be to not
require providing dummy kernel function name for kprobe. Currently,
SEC("kprobe/whatever") is necessary even if actual kernel function is
determined by user at runtime and bpf_program__attach_kprobe() is used
to specify it. With changes in this patch, it's possible to support both
SEC("kprobe") and SEC("kprobe/<actual_kernel_function"), while only in
the latter case auto-attach will be performed. In the former one, such
kprobe will be skipped during skeleton attach operation.

Reviewed-by: Alan Maguire <alan.maguire@oracle.com>
Tested-by: Alan Maguire <alan.maguire@oracle.com>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/libbpf.c | 140 +++++++++++++++++++++++++----------------
 1 file changed, 85 insertions(+), 55 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 81bf01d67671..1da4a438ba00 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -201,11 +201,12 @@ struct reloc_desc {
 	};
 };
 
-struct bpf_sec_def;
-
-typedef int (*init_fn_t)(struct bpf_program *prog, long cookie);
-typedef int (*preload_fn_t)(struct bpf_program *prog, struct bpf_prog_load_opts *opts, long cookie);
-typedef struct bpf_link *(*attach_fn_t)(const struct bpf_program *prog, long cookie);
+typedef int (*libbpf_prog_setup_fn_t)(struct bpf_program *prog, long cookie);
+typedef int (*libbpf_prog_prepare_load_fn_t)(struct bpf_program *prog,
+					     struct bpf_prog_load_opts *opts, long cookie);
+/* If auto-attach is not supported, callback should return 0 and set link to NULL */
+typedef int (*libbpf_prog_attach_fn_t)(const struct bpf_program *prog, long cookie,
+				       struct bpf_link **link);
 
 /* stored as sec_def->cookie for all libbpf-supported SEC()s */
 enum sec_def_flags {
@@ -239,9 +240,9 @@ struct bpf_sec_def {
 	enum bpf_attach_type expected_attach_type;
 	long cookie;
 
-	init_fn_t init_fn;
-	preload_fn_t preload_fn;
-	attach_fn_t attach_fn;
+	libbpf_prog_setup_fn_t prog_setup_fn;
+	libbpf_prog_prepare_load_fn_t prog_prepare_load_fn;
+	libbpf_prog_attach_fn_t prog_attach_fn;
 };
 
 /*
@@ -6572,9 +6573,9 @@ static int bpf_object__sanitize_prog(struct bpf_object *obj, struct bpf_program
 static int libbpf_find_attach_btf_id(struct bpf_program *prog, const char *attach_name,
 				     int *btf_obj_fd, int *btf_type_id);
 
-/* this is called as prog->sec_def->preload_fn for libbpf-supported sec_defs */
-static int libbpf_preload_prog(struct bpf_program *prog,
-			       struct bpf_prog_load_opts *opts, long cookie)
+/* this is called as prog->sec_def->prog_prepare_load_fn for libbpf-supported sec_defs */
+static int libbpf_prepare_prog_load(struct bpf_program *prog,
+				    struct bpf_prog_load_opts *opts, long cookie)
 {
 	enum sec_def_flags def = cookie;
 
@@ -6670,8 +6671,8 @@ static int bpf_object_load_prog_instance(struct bpf_object *obj, struct bpf_prog
 	load_attr.fd_array = obj->fd_array;
 
 	/* adjust load_attr if sec_def provides custom preload callback */
-	if (prog->sec_def && prog->sec_def->preload_fn) {
-		err = prog->sec_def->preload_fn(prog, &load_attr, prog->sec_def->cookie);
+	if (prog->sec_def && prog->sec_def->prog_prepare_load_fn) {
+		err = prog->sec_def->prog_prepare_load_fn(prog, &load_attr, prog->sec_def->cookie);
 		if (err < 0) {
 			pr_warn("prog '%s': failed to prepare load attributes: %d\n",
 				prog->name, err);
@@ -6971,8 +6972,8 @@ static int bpf_object_init_progs(struct bpf_object *obj, const struct bpf_object
 		/* sec_def can have custom callback which should be called
 		 * after bpf_program is initialized to adjust its properties
 		 */
-		if (prog->sec_def->init_fn) {
-			err = prog->sec_def->init_fn(prog, prog->sec_def->cookie);
+		if (prog->sec_def->prog_setup_fn) {
+			err = prog->sec_def->prog_setup_fn(prog, prog->sec_def->cookie);
 			if (err < 0) {
 				pr_warn("prog '%s': failed to initialize: %d\n",
 					prog->name, err);
@@ -8593,16 +8594,16 @@ int bpf_program__set_log_buf(struct bpf_program *prog, char *log_buf, size_t log
 	.prog_type = BPF_PROG_TYPE_##ptype,				    \
 	.expected_attach_type = atype,					    \
 	.cookie = (long)(flags),					    \
-	.preload_fn = libbpf_preload_prog,				    \
+	.prog_prepare_load_fn = libbpf_prepare_prog_load,		    \
 	__VA_ARGS__							    \
 }
 
-static struct bpf_link *attach_kprobe(const struct bpf_program *prog, long cookie);
-static struct bpf_link *attach_tp(const struct bpf_program *prog, long cookie);
-static struct bpf_link *attach_raw_tp(const struct bpf_program *prog, long cookie);
-static struct bpf_link *attach_trace(const struct bpf_program *prog, long cookie);
-static struct bpf_link *attach_lsm(const struct bpf_program *prog, long cookie);
-static struct bpf_link *attach_iter(const struct bpf_program *prog, long cookie);
+static int attach_kprobe(const struct bpf_program *prog, long cookie, struct bpf_link **link);
+static int attach_tp(const struct bpf_program *prog, long cookie, struct bpf_link **link);
+static int attach_raw_tp(const struct bpf_program *prog, long cookie, struct bpf_link **link);
+static int attach_trace(const struct bpf_program *prog, long cookie, struct bpf_link **link);
+static int attach_lsm(const struct bpf_program *prog, long cookie, struct bpf_link **link);
+static int attach_iter(const struct bpf_program *prog, long cookie, struct bpf_link **link);
 
 static const struct bpf_sec_def section_defs[] = {
 	SEC_DEF("socket",		SOCKET_FILTER, 0, SEC_NONE | SEC_SLOPPY_PFX),
@@ -8752,7 +8753,7 @@ static char *libbpf_get_type_names(bool attach_type)
 		const struct bpf_sec_def *sec_def = &section_defs[i];
 
 		if (attach_type) {
-			if (sec_def->preload_fn != libbpf_preload_prog)
+			if (sec_def->prog_prepare_load_fn != libbpf_prepare_prog_load)
 				continue;
 
 			if (!(sec_def->cookie & SEC_ATTACHABLE))
@@ -9135,7 +9136,7 @@ int libbpf_attach_type_by_name(const char *name,
 		return libbpf_err(-EINVAL);
 	}
 
-	if (sec_def->preload_fn != libbpf_preload_prog)
+	if (sec_def->prog_prepare_load_fn != libbpf_prepare_prog_load)
 		return libbpf_err(-EINVAL);
 	if (!(sec_def->cookie & SEC_ATTACHABLE))
 		return libbpf_err(-EINVAL);
@@ -10109,14 +10110,13 @@ struct bpf_link *bpf_program__attach_kprobe(const struct bpf_program *prog,
 	return bpf_program__attach_kprobe_opts(prog, func_name, &opts);
 }
 
-static struct bpf_link *attach_kprobe(const struct bpf_program *prog, long cookie)
+static int attach_kprobe(const struct bpf_program *prog, long cookie, struct bpf_link **link)
 {
 	DECLARE_LIBBPF_OPTS(bpf_kprobe_opts, opts);
 	unsigned long offset = 0;
-	struct bpf_link *link;
 	const char *func_name;
 	char *func;
-	int n, err;
+	int n;
 
 	opts.retprobe = str_has_pfx(prog->sec_name, "kretprobe/");
 	if (opts.retprobe)
@@ -10126,21 +10126,19 @@ static struct bpf_link *attach_kprobe(const struct bpf_program *prog, long cooki
 
 	n = sscanf(func_name, "%m[a-zA-Z0-9_.]+%li", &func, &offset);
 	if (n < 1) {
-		err = -EINVAL;
 		pr_warn("kprobe name is invalid: %s\n", func_name);
-		return libbpf_err_ptr(err);
+		return -EINVAL;
 	}
 	if (opts.retprobe && offset != 0) {
 		free(func);
-		err = -EINVAL;
 		pr_warn("kretprobes do not support offset specification\n");
-		return libbpf_err_ptr(err);
+		return -EINVAL;
 	}
 
 	opts.offset = offset;
-	link = bpf_program__attach_kprobe_opts(prog, func, &opts);
+	*link = bpf_program__attach_kprobe_opts(prog, func, &opts);
 	free(func);
-	return link;
+	return libbpf_get_error(*link);
 }
 
 static void gen_uprobe_legacy_event_name(char *buf, size_t buf_sz,
@@ -10395,14 +10393,13 @@ struct bpf_link *bpf_program__attach_tracepoint(const struct bpf_program *prog,
 	return bpf_program__attach_tracepoint_opts(prog, tp_category, tp_name, NULL);
 }
 
-static struct bpf_link *attach_tp(const struct bpf_program *prog, long cookie)
+static int attach_tp(const struct bpf_program *prog, long cookie, struct bpf_link **link)
 {
 	char *sec_name, *tp_cat, *tp_name;
-	struct bpf_link *link;
 
 	sec_name = strdup(prog->sec_name);
 	if (!sec_name)
-		return libbpf_err_ptr(-ENOMEM);
+		return -ENOMEM;
 
 	/* extract "tp/<category>/<name>" or "tracepoint/<category>/<name>" */
 	if (str_has_pfx(prog->sec_name, "tp/"))
@@ -10412,14 +10409,14 @@ static struct bpf_link *attach_tp(const struct bpf_program *prog, long cookie)
 	tp_name = strchr(tp_cat, '/');
 	if (!tp_name) {
 		free(sec_name);
-		return libbpf_err_ptr(-EINVAL);
+		return -EINVAL;
 	}
 	*tp_name = '\0';
 	tp_name++;
 
-	link = bpf_program__attach_tracepoint(prog, tp_cat, tp_name);
+	*link = bpf_program__attach_tracepoint(prog, tp_cat, tp_name);
 	free(sec_name);
-	return link;
+	return libbpf_get_error(*link);
 }
 
 struct bpf_link *bpf_program__attach_raw_tracepoint(const struct bpf_program *prog,
@@ -10452,7 +10449,7 @@ struct bpf_link *bpf_program__attach_raw_tracepoint(const struct bpf_program *pr
 	return link;
 }
 
-static struct bpf_link *attach_raw_tp(const struct bpf_program *prog, long cookie)
+static int attach_raw_tp(const struct bpf_program *prog, long cookie, struct bpf_link **link)
 {
 	static const char *const prefixes[] = {
 		"raw_tp/",
@@ -10472,10 +10469,11 @@ static struct bpf_link *attach_raw_tp(const struct bpf_program *prog, long cooki
 	if (!tp_name) {
 		pr_warn("prog '%s': invalid section name '%s'\n",
 			prog->name, prog->sec_name);
-		return libbpf_err_ptr(-EINVAL);
+		return -EINVAL;
 	}
 
-	return bpf_program__attach_raw_tracepoint(prog, tp_name);
+	*link = bpf_program__attach_raw_tracepoint(prog, tp_name);
+	return libbpf_get_error(link);
 }
 
 /* Common logic for all BPF program types that attach to a btf_id */
@@ -10518,14 +10516,16 @@ struct bpf_link *bpf_program__attach_lsm(const struct bpf_program *prog)
 	return bpf_program__attach_btf_id(prog);
 }
 
-static struct bpf_link *attach_trace(const struct bpf_program *prog, long cookie)
+static int attach_trace(const struct bpf_program *prog, long cookie, struct bpf_link **link)
 {
-	return bpf_program__attach_trace(prog);
+	*link = bpf_program__attach_trace(prog);
+	return libbpf_get_error(*link);
 }
 
-static struct bpf_link *attach_lsm(const struct bpf_program *prog, long cookie)
+static int attach_lsm(const struct bpf_program *prog, long cookie, struct bpf_link **link)
 {
-	return bpf_program__attach_lsm(prog);
+	*link = bpf_program__attach_lsm(prog);
+	return libbpf_get_error(*link);
 }
 
 static struct bpf_link *
@@ -10654,17 +10654,33 @@ bpf_program__attach_iter(const struct bpf_program *prog,
 	return link;
 }
 
-static struct bpf_link *attach_iter(const struct bpf_program *prog, long cookie)
+static int attach_iter(const struct bpf_program *prog, long cookie, struct bpf_link **link)
 {
-	return bpf_program__attach_iter(prog, NULL);
+	*link = bpf_program__attach_iter(prog, NULL);
+	return libbpf_get_error(*link);
 }
 
 struct bpf_link *bpf_program__attach(const struct bpf_program *prog)
 {
-	if (!prog->sec_def || !prog->sec_def->attach_fn)
-		return libbpf_err_ptr(-ESRCH);
+	struct bpf_link *link = NULL;
+	int err;
+
+	if (!prog->sec_def || !prog->sec_def->prog_attach_fn)
+		return libbpf_err_ptr(-EOPNOTSUPP);
 
-	return prog->sec_def->attach_fn(prog, prog->sec_def->cookie);
+	err = prog->sec_def->prog_attach_fn(prog, prog->sec_def->cookie, &link);
+	if (err)
+		return libbpf_err_ptr(err);
+
+	/* When calling bpf_program__attach() explicitly, auto-attach support
+	 * is expected to work, so NULL returned link is considered an error.
+	 * This is different for skeleton's attach, see comment in
+	 * bpf_object__attach_skeleton().
+	 */
+	if (!link)
+		return libbpf_err_ptr(-EOPNOTSUPP);
+
+	return link;
 }
 
 static int bpf_link__detach_struct_ops(struct bpf_link *link)
@@ -11805,16 +11821,30 @@ int bpf_object__attach_skeleton(struct bpf_object_skeleton *s)
 			continue;
 
 		/* auto-attaching not supported for this program */
-		if (!prog->sec_def || !prog->sec_def->attach_fn)
+		if (!prog->sec_def || !prog->sec_def->prog_attach_fn)
 			continue;
 
-		*link = bpf_program__attach(prog);
-		err = libbpf_get_error(*link);
+		/* if user already set the link manually, don't attempt auto-attach */
+		if (*link)
+			continue;
+
+		err = prog->sec_def->prog_attach_fn(prog, prog->sec_def->cookie, link);
 		if (err) {
-			pr_warn("failed to auto-attach program '%s': %d\n",
+			pr_warn("prog '%s': failed to auto-attach: %d\n",
 				bpf_program__name(prog), err);
 			return libbpf_err(err);
 		}
+
+		/* It's possible that for some SEC() definitions auto-attach
+		 * is supported in some cases (e.g., if definition completely
+		 * specifies target information), but is not in other cases.
+		 * SEC("uprobe") is one such case. If user specified target
+		 * binary and function name, such BPF program can be
+		 * auto-attached. But if not, it shouldn't trigger skeleton's
+		 * attach to fail. It should just be skipped.
+		 * attach_fn signals such case with returning 0 (no error) and
+		 * setting link to NULL.
+		 */
 	}
 
 	return 0;
-- 
2.30.2

