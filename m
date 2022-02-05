Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89BBC4AA54B
	for <lists+bpf@lfdr.de>; Sat,  5 Feb 2022 02:27:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239745AbiBEB1X convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Fri, 4 Feb 2022 20:27:23 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:36288 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1349644AbiBEB1V (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 4 Feb 2022 20:27:21 -0500
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 2150pT3D007137
        for <bpf@vger.kernel.org>; Fri, 4 Feb 2022 17:27:21 -0800
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3e1dgb8k33-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 04 Feb 2022 17:27:21 -0800
Received: from twshared3399.25.prn2.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::e) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Fri, 4 Feb 2022 17:27:19 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 6D1AE1051D28B; Fri,  4 Feb 2022 17:27:11 -0800 (PST)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH bpf-next 1/3] libbpf: allow BPF program auto-attach handlers to bail out
Date:   Fri, 4 Feb 2022 17:27:02 -0800
Message-ID: <20220205012705.1077708-2-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220205012705.1077708-1-andrii@kernel.org>
References: <20220205012705.1077708-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: Rkj4riONFiNP2bqgTmwhwn-y6wrkyFUy
X-Proofpoint-GUID: Rkj4riONFiNP2bqgTmwhwn-y6wrkyFUy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-04_07,2022-02-03_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 mlxscore=0 adultscore=0
 malwarescore=0 phishscore=0 priorityscore=1501 mlxlogscore=999
 impostorscore=0 bulkscore=0 spamscore=0 suspectscore=0 clxscore=1015
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202050004
X-FB-Internal: deliver
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
support auto-attach.

Another improvement to the way libbpf is handling SEC()s would be to not
require providing dummy kernel function name for kprobe. Currently,
SEC("kprobe/whatever") is necessary even if actual kernel function is
determined by user at runtime and bpf_program__attach_kprobe() is used
to specify it. With changes in this patch, it's possible to support both
SEC("kprobe") and SEC("kprobe/<actual_kernel_function"), while only in
the latter case auto-attach will be performed. In the former one, such
kprobe will be skipped during skeleton attach operation.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/libbpf.c | 110 +++++++++++++++++++++++++----------------
 1 file changed, 67 insertions(+), 43 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 904cdf83002b..2902534def2c 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -209,11 +209,12 @@ struct reloc_desc {
 	};
 };
 
-struct bpf_sec_def;
-
-typedef int (*init_fn_t)(struct bpf_program *prog, long cookie);
-typedef int (*preload_fn_t)(struct bpf_program *prog, struct bpf_prog_load_opts *opts, long cookie);
-typedef struct bpf_link *(*attach_fn_t)(const struct bpf_program *prog, long cookie);
+typedef int (*libbpf_prog_init_fn_t)(struct bpf_program *prog, long cookie);
+typedef int (*libbpf_prog_preload_fn_t)(struct bpf_program *prog,
+					struct bpf_prog_load_opts *opts, long cookie);
+/* If auto-attach is not supported, callback should return 0 and set link to NULL */
+typedef int (*libbpf_prog_attach_fn_t)(const struct bpf_program *prog, long cookie,
+				       struct bpf_link **link);
 
 /* stored as sec_def->cookie for all libbpf-supported SEC()s */
 enum sec_def_flags {
@@ -247,9 +248,9 @@ struct bpf_sec_def {
 	enum bpf_attach_type expected_attach_type;
 	long cookie;
 
-	init_fn_t init_fn;
-	preload_fn_t preload_fn;
-	attach_fn_t attach_fn;
+	libbpf_prog_init_fn_t init_fn;
+	libbpf_prog_preload_fn_t preload_fn;
+	libbpf_prog_attach_fn_t attach_fn;
 };
 
 /*
@@ -8589,12 +8590,12 @@ int bpf_program__set_log_buf(struct bpf_program *prog, char *log_buf, size_t log
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
@@ -10101,14 +10102,13 @@ struct bpf_link *bpf_program__attach_kprobe(const struct bpf_program *prog,
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
@@ -10118,21 +10118,19 @@ static struct bpf_link *attach_kprobe(const struct bpf_program *prog, long cooki
 
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
@@ -10387,14 +10385,13 @@ struct bpf_link *bpf_program__attach_tracepoint(const struct bpf_program *prog,
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
@@ -10404,14 +10401,14 @@ static struct bpf_link *attach_tp(const struct bpf_program *prog, long cookie)
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
@@ -10444,7 +10441,7 @@ struct bpf_link *bpf_program__attach_raw_tracepoint(const struct bpf_program *pr
 	return link;
 }
 
-static struct bpf_link *attach_raw_tp(const struct bpf_program *prog, long cookie)
+static int attach_raw_tp(const struct bpf_program *prog, long cookie, struct bpf_link **link)
 {
 	static const char *const prefixes[] = {
 		"raw_tp/",
@@ -10464,10 +10461,11 @@ static struct bpf_link *attach_raw_tp(const struct bpf_program *prog, long cooki
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
@@ -10510,14 +10508,16 @@ struct bpf_link *bpf_program__attach_lsm(const struct bpf_program *prog)
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
@@ -10646,17 +10646,31 @@ bpf_program__attach_iter(const struct bpf_program *prog,
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
+	struct bpf_link *link;
+	int err;
+
 	if (!prog->sec_def || !prog->sec_def->attach_fn)
-		return libbpf_err_ptr(-ESRCH);
+		return libbpf_err_ptr(-EOPNOTSUPP);
+
+	err = prog->sec_def->attach_fn(prog, prog->sec_def->cookie, &link);
+	if (err)
+		return libbpf_err_ptr(err);
+
+	/* auto-attach support is optional (see also comment in
+	 * bpf_object__attach_skeleton()), but when explicitly expected by
+	 * user it's an error if it's not */
+	if (!link)
+		return libbpf_err_ptr(-EOPNOTSUPP);
 
-	return prog->sec_def->attach_fn(prog, prog->sec_def->cookie);
+	return link;
 }
 
 static int bpf_link__detach_struct_ops(struct bpf_link *link)
@@ -11800,13 +11814,23 @@ int bpf_object__attach_skeleton(struct bpf_object_skeleton *s)
 		if (!prog->sec_def || !prog->sec_def->attach_fn)
 			continue;
 
-		*link = bpf_program__attach(prog);
-		err = libbpf_get_error(*link);
+		err = prog->sec_def->attach_fn(prog, prog->sec_def->cookie, link);
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

