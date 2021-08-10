Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAC913E8588
	for <lists+bpf@lfdr.de>; Tue, 10 Aug 2021 23:37:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234707AbhHJVhs convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Tue, 10 Aug 2021 17:37:48 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:55208 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S234877AbhHJVho (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 10 Aug 2021 17:37:44 -0400
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.43/8.16.0.43) with SMTP id 17ALYr6H023303
        for <bpf@vger.kernel.org>; Tue, 10 Aug 2021 14:37:09 -0700
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0089730.ppops.net with ESMTP id 3abya40ycx-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 10 Aug 2021 14:37:09 -0700
Received: from intmgw001.25.frc3.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:21d::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 10 Aug 2021 14:37:07 -0700
Received: by devbig012.ftw2.facebook.com (Postfix, from userid 137359)
        id 77B783D405A0; Tue, 10 Aug 2021 14:37:01 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Rafael David Tinoco <rafaeldtinoco@gmail.com>
Subject: [PATCH v4 bpf-next 11/14] libbpf: add bpf_cookie to perf_event, kprobe, uprobe, and tp attach APIs
Date:   Tue, 10 Aug 2021 14:36:31 -0700
Message-ID: <20210810213634.272111-12-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210810213634.272111-1-andrii@kernel.org>
References: <20210810213634.272111-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-GUID: B3MfVSZfxJhp-SyzFFqlpVEABessj2ZL
X-Proofpoint-ORIG-GUID: B3MfVSZfxJhp-SyzFFqlpVEABessj2ZL
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-10_08:2021-08-10,2021-08-10 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 suspectscore=0
 spamscore=0 priorityscore=1501 adultscore=0 clxscore=1015 malwarescore=0
 bulkscore=0 impostorscore=0 phishscore=0 mlxscore=0 lowpriorityscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108100142
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Wire through bpf_cookie for all attach APIs that use perf_event_open under the
hood:
  - for kprobes, extend existing bpf_kprobe_opts with bpf_cookie field;
  - for perf_event, uprobe, and tracepoint APIs, add their _opts variants and
    pass bpf_cookie through opts.

For kernel that don't support BPF_LINK_CREATE for perf_events, and thus
bpf_cookie is not supported either, return error and log warning for user.

Cc: Rafael David Tinoco <rafaeldtinoco@gmail.com>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/libbpf.c   | 78 +++++++++++++++++++++++++++++++++-------
 tools/lib/bpf/libbpf.h   | 71 +++++++++++++++++++++++++++++-------
 tools/lib/bpf/libbpf.map |  3 ++
 3 files changed, 127 insertions(+), 25 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index b6adb50f2711..2299ed7daf73 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -9012,12 +9012,16 @@ static void bpf_link_perf_dealloc(struct bpf_link *link)
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
@@ -9038,7 +9042,10 @@ struct bpf_link *bpf_program__attach_perf_event(struct bpf_program *prog, int pf
 	link->perf_event_fd = pfd;
 
 	if (kernel_supports(prog->obj, FEAT_PERF_LINK)) {
-		link_fd = bpf_link_create(prog_fd, pfd, BPF_PERF_EVENT, NULL);
+		DECLARE_LIBBPF_OPTS(bpf_link_create_opts, link_opts,
+			.perf_event.bpf_cookie = OPTS_GET(opts, bpf_cookie, 0));
+
+		link_fd = bpf_link_create(prog_fd, pfd, BPF_PERF_EVENT, &link_opts);
 		if (link_fd < 0) {
 			err = -errno;
 			pr_warn("prog '%s': failed to create BPF link for perf_event FD %d: %d (%s)\n",
@@ -9048,6 +9055,12 @@ struct bpf_link *bpf_program__attach_perf_event(struct bpf_program *prog, int pf
 		}
 		link->link.fd = link_fd;
 	} else {
+		if (OPTS_GET(opts, bpf_cookie, 0)) {
+			pr_warn("prog '%s': user context value is not supported\n", prog->name);
+			err = -EOPNOTSUPP;
+			goto err_out;
+		}
+
 		if (ioctl(pfd, PERF_EVENT_IOC_SET_BPF, prog_fd) < 0) {
 			err = -errno;
 			pr_warn("prog '%s': failed to attach to perf_event FD %d: %s\n",
@@ -9074,6 +9087,11 @@ struct bpf_link *bpf_program__attach_perf_event(struct bpf_program *prog, int pf
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
@@ -9182,8 +9200,9 @@ static int perf_event_open_probe(bool uprobe, bool retprobe, const char *name,
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
@@ -9195,6 +9214,7 @@ bpf_program__attach_kprobe_opts(struct bpf_program *prog,
 
 	retprobe = OPTS_GET(opts, retprobe, false);
 	offset = OPTS_GET(opts, offset, 0);
+	pe_opts.bpf_cookie = OPTS_GET(opts, bpf_cookie, 0);
 
 	pfd = perf_event_open_probe(false /* uprobe */, retprobe, func_name,
 				    offset, -1 /* pid */);
@@ -9204,7 +9224,7 @@ bpf_program__attach_kprobe_opts(struct bpf_program *prog,
 			libbpf_strerror_r(pfd, errmsg, sizeof(errmsg)));
 		return libbpf_err_ptr(pfd);
 	}
-	link = bpf_program__attach_perf_event(prog, pfd);
+	link = bpf_program__attach_perf_event_opts(prog, pfd, &pe_opts);
 	err = libbpf_get_error(link);
 	if (err) {
 		close(pfd);
@@ -9259,14 +9279,22 @@ static struct bpf_link *attach_kprobe(const struct bpf_sec_def *sec,
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
+	pe_opts.bpf_cookie = OPTS_GET(opts, bpf_cookie, 0);
 
 	pfd = perf_event_open_probe(true /* uprobe */, retprobe,
 				    binary_path, func_offset, pid);
@@ -9277,7 +9305,7 @@ struct bpf_link *bpf_program__attach_uprobe(struct bpf_program *prog,
 			libbpf_strerror_r(pfd, errmsg, sizeof(errmsg)));
 		return libbpf_err_ptr(pfd);
 	}
-	link = bpf_program__attach_perf_event(prog, pfd);
+	link = bpf_program__attach_perf_event_opts(prog, pfd, &pe_opts);
 	err = libbpf_get_error(link);
 	if (err) {
 		close(pfd);
@@ -9290,6 +9318,16 @@ struct bpf_link *bpf_program__attach_uprobe(struct bpf_program *prog,
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
@@ -9340,14 +9378,21 @@ static int perf_event_open_tracepoint(const char *tp_category,
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
+	pe_opts.bpf_cookie = OPTS_GET(opts, bpf_cookie, 0);
+
 	pfd = perf_event_open_tracepoint(tp_category, tp_name);
 	if (pfd < 0) {
 		pr_warn("prog '%s': failed to create tracepoint '%s/%s' perf event: %s\n",
@@ -9355,7 +9400,7 @@ struct bpf_link *bpf_program__attach_tracepoint(struct bpf_program *prog,
 			libbpf_strerror_r(pfd, errmsg, sizeof(errmsg)));
 		return libbpf_err_ptr(pfd);
 	}
-	link = bpf_program__attach_perf_event(prog, pfd);
+	link = bpf_program__attach_perf_event_opts(prog, pfd, &pe_opts);
 	err = libbpf_get_error(link);
 	if (err) {
 		close(pfd);
@@ -9367,6 +9412,13 @@ struct bpf_link *bpf_program__attach_tracepoint(struct bpf_program *prog,
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
index 1271d99bb7aa..1f4a67285365 100644
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
+	/* custom user-provided value fetchable through bpf_get_attach_cookie() */
+	__u64 bpf_cookie;
+};
+#define bpf_perf_event_opts__last_field bpf_cookie
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
+	/* custom user-provided value fetchable through bpf_get_attach_cookie() */
+	__u64 bpf_cookie;
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
+	/* custom user-provided value fetchable through bpf_get_attach_cookie() */
+	__u64 bpf_cookie;
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
+	/* custom user-provided value fetchable through bpf_get_attach_cookie() */
+	__u64 bpf_cookie;
+};
+#define bpf_tracepoint_opts__last_field bpf_cookie
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
index 58e0fb2c482f..bbc53bb25f68 100644
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
 		btf__load_from_kernel_by_id;
 		btf__load_from_kernel_by_id_split;
-- 
2.30.2

