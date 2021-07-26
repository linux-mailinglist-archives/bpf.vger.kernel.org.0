Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC5353D61B1
	for <lists+bpf@lfdr.de>; Mon, 26 Jul 2021 18:14:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233759AbhGZPch convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Mon, 26 Jul 2021 11:32:37 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:50552 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233240AbhGZPcO (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 26 Jul 2021 11:32:14 -0400
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16QG3iVK004606
        for <bpf@vger.kernel.org>; Mon, 26 Jul 2021 09:12:43 -0700
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3a1ydj0f06-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 26 Jul 2021 09:12:42 -0700
Received: from intmgw006.03.ash8.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:11d::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 26 Jul 2021 09:12:41 -0700
Received: by devbig012.ftw2.facebook.com (Postfix, from userid 137359)
        id 2B4E33D405AD; Mon, 26 Jul 2021 09:12:37 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Rafael David Tinoco <rafaeldtinoco@gmail.com>
Subject: [PATCH v2 bpf-next 11/14] libbpf: add user_ctx to perf_event, kprobe, uprobe, and tp attach APIs
Date:   Mon, 26 Jul 2021 09:12:08 -0700
Message-ID: <20210726161211.925206-12-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210726161211.925206-1-andrii@kernel.org>
References: <20210726161211.925206-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: ZSlYrDEjgTE3OnkbOckISpyWpKn1FYbF
X-Proofpoint-GUID: ZSlYrDEjgTE3OnkbOckISpyWpKn1FYbF
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-26_10:2021-07-26,2021-07-26 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 suspectscore=0 spamscore=0 priorityscore=1501 mlxscore=0 bulkscore=0
 mlxlogscore=999 clxscore=1034 adultscore=0 phishscore=0 impostorscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2107260093
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Wire through user_ctx for all attach APIs that use perf_event_open under the
hood:
  - for kprobes, extend existing bpf_kprobe_opts with user_ctx field;
  - for perf_event, uprobe, and tracepoint APIs, add their _opts variants and
    pass user_ctx through opts.

For kernel that don't support BPF_LINK_CREATE for perf_events, and thus
user_ctx is not supported either, return error and log warning for user.

Cc: Rafael David Tinoco <rafaeldtinoco@gmail.com>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/libbpf.c   | 78 +++++++++++++++++++++++++++++++++-------
 tools/lib/bpf/libbpf.h   | 71 +++++++++++++++++++++++++++++-------
 tools/lib/bpf/libbpf.map |  3 ++
 3 files changed, 127 insertions(+), 25 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 682e7aa8f90b..5836d3627ba6 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -10274,12 +10274,16 @@ static void bpf_link_perf_dealloc(struct bpf_link *link)
 	free(perf_link);
 }
 
-struct bpf_link *bpf_program__attach_perf_event(struct bpf_program *prog, int pfd)
+struct bpf_link *bpf_program__attach_perf_event_opts(struct bpf_program *prog, int pfd,
+						     const struct bpf_perf_event_opts *opts)
 {
 	char errmsg[STRERR_BUFSIZE];
 	struct bpf_link_perf *link;
 	int prog_fd, link_fd = -1, err;
 
+	if (!OPTS_VALID(opts, bpf_perf_event_opts))
+		return libbpf_err_ptr(-EINVAL);
+
 	if (pfd < 0) {
 		pr_warn("prog '%s': invalid perf event FD %d\n",
 			prog->name, pfd);
@@ -10300,7 +10304,10 @@ struct bpf_link *bpf_program__attach_perf_event(struct bpf_program *prog, int pf
 	link->perf_event_fd = pfd;
 
 	if (kernel_supports(prog->obj, FEAT_PERF_LINK)) {
-		link_fd = bpf_link_create(prog_fd, pfd, BPF_PERF_EVENT, NULL);
+		DECLARE_LIBBPF_OPTS(bpf_link_create_opts, link_opts,
+			.perf_event.user_ctx = OPTS_GET(opts, user_ctx, 0));
+
+		link_fd = bpf_link_create(prog_fd, pfd, BPF_PERF_EVENT, &link_opts);
 		if (link_fd < 0) {
 			err = -errno;
 			pr_warn("prog '%s': failed to create BPF link for perf_event FD %d: %d (%s)\n",
@@ -10310,6 +10317,12 @@ struct bpf_link *bpf_program__attach_perf_event(struct bpf_program *prog, int pf
 		}
 		link->link.fd = link_fd;
 	} else {
+		if (OPTS_GET(opts, user_ctx, 0)) {
+			pr_warn("prog '%s': user context value is not supported\n", prog->name);
+			err = -EOPNOTSUPP;
+			goto err_out;
+		}
+
 		if (ioctl(pfd, PERF_EVENT_IOC_SET_BPF, prog_fd) < 0) {
 			err = -errno;
 			pr_warn("prog '%s': failed to attach to perf_event FD %d: %s\n",
@@ -10336,6 +10349,11 @@ struct bpf_link *bpf_program__attach_perf_event(struct bpf_program *prog, int pf
 	return libbpf_err_ptr(err);
 }
 
+struct bpf_link *bpf_program__attach_perf_event(struct bpf_program *prog, int pfd)
+{
+	return bpf_program__attach_perf_event_opts(prog, pfd, NULL);
+}
+
 /*
  * this function is expected to parse integer in the range of [0, 2^31-1] from
  * given file using scanf format string fmt. If actual parsed value is
@@ -10444,8 +10462,9 @@ static int perf_event_open_probe(bool uprobe, bool retprobe, const char *name,
 struct bpf_link *
 bpf_program__attach_kprobe_opts(struct bpf_program *prog,
 				const char *func_name,
-				struct bpf_kprobe_opts *opts)
+				const struct bpf_kprobe_opts *opts)
 {
+	DECLARE_LIBBPF_OPTS(bpf_perf_event_opts, pe_opts);
 	char errmsg[STRERR_BUFSIZE];
 	struct bpf_link *link;
 	unsigned long offset;
@@ -10457,6 +10476,7 @@ bpf_program__attach_kprobe_opts(struct bpf_program *prog,
 
 	retprobe = OPTS_GET(opts, retprobe, false);
 	offset = OPTS_GET(opts, offset, 0);
+	pe_opts.user_ctx = OPTS_GET(opts, user_ctx, 0);
 
 	pfd = perf_event_open_probe(false /* uprobe */, retprobe, func_name,
 				    offset, -1 /* pid */);
@@ -10466,7 +10486,7 @@ bpf_program__attach_kprobe_opts(struct bpf_program *prog,
 			libbpf_strerror_r(pfd, errmsg, sizeof(errmsg)));
 		return libbpf_err_ptr(pfd);
 	}
-	link = bpf_program__attach_perf_event(prog, pfd);
+	link = bpf_program__attach_perf_event_opts(prog, pfd, &pe_opts);
 	err = libbpf_get_error(link);
 	if (err) {
 		close(pfd);
@@ -10521,14 +10541,22 @@ static struct bpf_link *attach_kprobe(const struct bpf_sec_def *sec,
 	return link;
 }
 
-struct bpf_link *bpf_program__attach_uprobe(struct bpf_program *prog,
-					    bool retprobe, pid_t pid,
-					    const char *binary_path,
-					    size_t func_offset)
+LIBBPF_API struct bpf_link *
+bpf_program__attach_uprobe_opts(struct bpf_program *prog, pid_t pid,
+				const char *binary_path, size_t func_offset,
+				const struct bpf_uprobe_opts *opts)
 {
+	DECLARE_LIBBPF_OPTS(bpf_perf_event_opts, pe_opts);
 	char errmsg[STRERR_BUFSIZE];
 	struct bpf_link *link;
 	int pfd, err;
+	bool retprobe;
+
+	if (!OPTS_VALID(opts, bpf_uprobe_opts))
+		return libbpf_err_ptr(-EINVAL);
+
+	retprobe = OPTS_GET(opts, retprobe, false);
+	pe_opts.user_ctx = OPTS_GET(opts, user_ctx, 0);
 
 	pfd = perf_event_open_probe(true /* uprobe */, retprobe,
 				    binary_path, func_offset, pid);
@@ -10539,7 +10567,7 @@ struct bpf_link *bpf_program__attach_uprobe(struct bpf_program *prog,
 			libbpf_strerror_r(pfd, errmsg, sizeof(errmsg)));
 		return libbpf_err_ptr(pfd);
 	}
-	link = bpf_program__attach_perf_event(prog, pfd);
+	link = bpf_program__attach_perf_event_opts(prog, pfd, &pe_opts);
 	err = libbpf_get_error(link);
 	if (err) {
 		close(pfd);
@@ -10552,6 +10580,16 @@ struct bpf_link *bpf_program__attach_uprobe(struct bpf_program *prog,
 	return link;
 }
 
+struct bpf_link *bpf_program__attach_uprobe(struct bpf_program *prog,
+					    bool retprobe, pid_t pid,
+					    const char *binary_path,
+					    size_t func_offset)
+{
+	DECLARE_LIBBPF_OPTS(bpf_uprobe_opts, opts, .retprobe = retprobe);
+
+	return bpf_program__attach_uprobe_opts(prog, pid, binary_path, func_offset, &opts);
+}
+
 static int determine_tracepoint_id(const char *tp_category,
 				   const char *tp_name)
 {
@@ -10602,14 +10640,21 @@ static int perf_event_open_tracepoint(const char *tp_category,
 	return pfd;
 }
 
-struct bpf_link *bpf_program__attach_tracepoint(struct bpf_program *prog,
-						const char *tp_category,
-						const char *tp_name)
+struct bpf_link *bpf_program__attach_tracepoint_opts(struct bpf_program *prog,
+						     const char *tp_category,
+						     const char *tp_name,
+						     const struct bpf_tracepoint_opts *opts)
 {
+	DECLARE_LIBBPF_OPTS(bpf_perf_event_opts, pe_opts);
 	char errmsg[STRERR_BUFSIZE];
 	struct bpf_link *link;
 	int pfd, err;
 
+	if (!OPTS_VALID(opts, bpf_tracepoint_opts))
+		return libbpf_err_ptr(-EINVAL);
+
+	pe_opts.user_ctx = OPTS_GET(opts, user_ctx, 0);
+
 	pfd = perf_event_open_tracepoint(tp_category, tp_name);
 	if (pfd < 0) {
 		pr_warn("prog '%s': failed to create tracepoint '%s/%s' perf event: %s\n",
@@ -10617,7 +10662,7 @@ struct bpf_link *bpf_program__attach_tracepoint(struct bpf_program *prog,
 			libbpf_strerror_r(pfd, errmsg, sizeof(errmsg)));
 		return libbpf_err_ptr(pfd);
 	}
-	link = bpf_program__attach_perf_event(prog, pfd);
+	link = bpf_program__attach_perf_event_opts(prog, pfd, &pe_opts);
 	err = libbpf_get_error(link);
 	if (err) {
 		close(pfd);
@@ -10629,6 +10674,13 @@ struct bpf_link *bpf_program__attach_tracepoint(struct bpf_program *prog,
 	return link;
 }
 
+struct bpf_link *bpf_program__attach_tracepoint(struct bpf_program *prog,
+						const char *tp_category,
+						const char *tp_name)
+{
+	return bpf_program__attach_tracepoint_opts(prog, tp_category, tp_name, NULL);
+}
+
 static struct bpf_link *attach_tp(const struct bpf_sec_def *sec,
 				  struct bpf_program *prog)
 {
diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index 1271d99bb7aa..85d336bcb510 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -104,17 +104,6 @@ struct bpf_object_open_opts {
 };
 #define bpf_object_open_opts__last_field btf_custom_path
 
-struct bpf_kprobe_opts {
-	/* size of this struct, for forward/backward compatiblity */
-	size_t sz;
-	/* function's offset to install kprobe to */
-	unsigned long offset;
-	/* kprobe is return probe */
-	bool retprobe;
-	size_t :0;
-};
-#define bpf_kprobe_opts__last_field retprobe
-
 LIBBPF_API struct bpf_object *bpf_object__open(const char *path);
 LIBBPF_API struct bpf_object *
 bpf_object__open_file(const char *path, const struct bpf_object_open_opts *opts);
@@ -255,24 +244,82 @@ LIBBPF_API int bpf_link__destroy(struct bpf_link *link);
 
 LIBBPF_API struct bpf_link *
 bpf_program__attach(struct bpf_program *prog);
+
+struct bpf_perf_event_opts {
+	/* size of this struct, for forward/backward compatiblity */
+	size_t sz;
+	/* custom user-provided value fetchable through bpf_get_user_ctx() */
+	__u64 user_ctx;
+};
+#define bpf_perf_event_opts__last_field user_ctx
+
 LIBBPF_API struct bpf_link *
 bpf_program__attach_perf_event(struct bpf_program *prog, int pfd);
+
+LIBBPF_API struct bpf_link *
+bpf_program__attach_perf_event_opts(struct bpf_program *prog, int pfd,
+				    const struct bpf_perf_event_opts *opts);
+
+struct bpf_kprobe_opts {
+	/* size of this struct, for forward/backward compatiblity */
+	size_t sz;
+	/* custom user-provided value fetchable through bpf_get_user_ctx() */
+	__u64 user_ctx;
+	/* function's offset to install kprobe to */
+	unsigned long offset;
+	/* kprobe is return probe */
+	bool retprobe;
+	size_t :0;
+};
+#define bpf_kprobe_opts__last_field retprobe
+
 LIBBPF_API struct bpf_link *
 bpf_program__attach_kprobe(struct bpf_program *prog, bool retprobe,
 			   const char *func_name);
 LIBBPF_API struct bpf_link *
 bpf_program__attach_kprobe_opts(struct bpf_program *prog,
                                 const char *func_name,
-                                struct bpf_kprobe_opts *opts);
+                                const struct bpf_kprobe_opts *opts);
+
+struct bpf_uprobe_opts {
+	/* size of this struct, for forward/backward compatiblity */
+	size_t sz;
+	/* custom user-provided value fetchable through bpf_get_user_ctx() */
+	__u64 user_ctx;
+	/* uprobe is return probe, invoked at function return time */
+	bool retprobe;
+	size_t :0;
+};
+#define bpf_uprobe_opts__last_field retprobe
+
 LIBBPF_API struct bpf_link *
 bpf_program__attach_uprobe(struct bpf_program *prog, bool retprobe,
 			   pid_t pid, const char *binary_path,
 			   size_t func_offset);
+LIBBPF_API struct bpf_link *
+bpf_program__attach_uprobe_opts(struct bpf_program *prog, pid_t pid,
+				const char *binary_path, size_t func_offset,
+				const struct bpf_uprobe_opts *opts);
+
+struct bpf_tracepoint_opts {
+	/* size of this struct, for forward/backward compatiblity */
+	size_t sz;
+	/* custom user-provided value fetchable through bpf_get_user_ctx() */
+	__u64 user_ctx;
+};
+#define bpf_tracepoint_opts__last_field user_ctx
+
 LIBBPF_API struct bpf_link *
 bpf_program__attach_tracepoint(struct bpf_program *prog,
 			       const char *tp_category,
 			       const char *tp_name);
 LIBBPF_API struct bpf_link *
+bpf_program__attach_tracepoint_opts(struct bpf_program *prog,
+				    const char *tp_category,
+				    const char *tp_name,
+				    const struct bpf_tracepoint_opts *opts);
+
+LIBBPF_API struct bpf_link *
 bpf_program__attach_raw_tracepoint(struct bpf_program *prog,
 				   const char *tp_name);
 LIBBPF_API struct bpf_link *
diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
index c240d488eb5e..a156f012e23d 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -374,6 +374,9 @@ LIBBPF_0.5.0 {
 		bpf_map__pin_path;
 		bpf_map_lookup_and_delete_elem_flags;
 		bpf_program__attach_kprobe_opts;
+		bpf_program__attach_perf_event_opts;
+		bpf_program__attach_tracepoint_opts;
+		bpf_program__attach_uprobe_opts;
 		bpf_object__gen_loader;
 		btf_dump__dump_type_data;
 		libbpf_set_strict_mode;
-- 
2.30.2

