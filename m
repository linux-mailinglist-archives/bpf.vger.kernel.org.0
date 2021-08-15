Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6AD63EC7D2
	for <lists+bpf@lfdr.de>; Sun, 15 Aug 2021 09:06:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235091AbhHOHHK convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Sun, 15 Aug 2021 03:07:10 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:33548 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S234351AbhHOHHJ (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sun, 15 Aug 2021 03:07:09 -0400
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.43/8.16.0.43) with SMTP id 17F6veUx010394
        for <bpf@vger.kernel.org>; Sun, 15 Aug 2021 00:06:39 -0700
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0001303.ppops.net with ESMTP id 3ae9gyc35r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Sun, 15 Aug 2021 00:06:39 -0700
Received: from intmgw001.37.frc1.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Sun, 15 Aug 2021 00:06:38 -0700
Received: by devbig012.ftw2.facebook.com (Postfix, from userid 137359)
        id 0EBE03D405A0; Sun, 15 Aug 2021 00:06:33 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Rafael David Tinoco <rafaeldtinoco@gmail.com>
Subject: [PATCH v5 bpf-next 11/16] libbpf: add bpf_cookie to perf_event, kprobe, uprobe, and tp attach APIs
Date:   Sun, 15 Aug 2021 00:06:04 -0700
Message-ID: <20210815070609.987780-12-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210815070609.987780-1-andrii@kernel.org>
References: <20210815070609.987780-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-GUID: SUK4iMrC0dUJ6R0CiTN56lJpZ3DUyWna
X-Proofpoint-ORIG-GUID: SUK4iMrC0dUJ6R0CiTN56lJpZ3DUyWna
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-15_02:2021-08-13,2021-08-15 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 bulkscore=0 adultscore=0
 clxscore=1015 phishscore=0 priorityscore=1501 impostorscore=0 spamscore=0
 suspectscore=0 mlxscore=0 lowpriorityscore=0 mlxlogscore=999
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108150048
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
index 5dc15f5b4b78..62ce878cb8e0 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -9014,12 +9014,16 @@ static void bpf_link_perf_dealloc(struct bpf_link *link)
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
@@ -9040,7 +9044,10 @@ struct bpf_link *bpf_program__attach_perf_event(struct bpf_program *prog, int pf
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
@@ -9050,6 +9057,12 @@ struct bpf_link *bpf_program__attach_perf_event(struct bpf_program *prog, int pf
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
@@ -9076,6 +9089,11 @@ struct bpf_link *bpf_program__attach_perf_event(struct bpf_program *prog, int pf
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
@@ -9184,8 +9202,9 @@ static int perf_event_open_probe(bool uprobe, bool retprobe, const char *name,
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
@@ -9197,6 +9216,7 @@ bpf_program__attach_kprobe_opts(struct bpf_program *prog,
 
 	retprobe = OPTS_GET(opts, retprobe, false);
 	offset = OPTS_GET(opts, offset, 0);
+	pe_opts.bpf_cookie = OPTS_GET(opts, bpf_cookie, 0);
 
 	pfd = perf_event_open_probe(false /* uprobe */, retprobe, func_name,
 				    offset, -1 /* pid */);
@@ -9206,7 +9226,7 @@ bpf_program__attach_kprobe_opts(struct bpf_program *prog,
 			libbpf_strerror_r(pfd, errmsg, sizeof(errmsg)));
 		return libbpf_err_ptr(pfd);
 	}
-	link = bpf_program__attach_perf_event(prog, pfd);
+	link = bpf_program__attach_perf_event_opts(prog, pfd, &pe_opts);
 	err = libbpf_get_error(link);
 	if (err) {
 		close(pfd);
@@ -9261,14 +9281,22 @@ static struct bpf_link *attach_kprobe(const struct bpf_sec_def *sec,
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
@@ -9279,7 +9307,7 @@ struct bpf_link *bpf_program__attach_uprobe(struct bpf_program *prog,
 			libbpf_strerror_r(pfd, errmsg, sizeof(errmsg)));
 		return libbpf_err_ptr(pfd);
 	}
-	link = bpf_program__attach_perf_event(prog, pfd);
+	link = bpf_program__attach_perf_event_opts(prog, pfd, &pe_opts);
 	err = libbpf_get_error(link);
 	if (err) {
 		close(pfd);
@@ -9292,6 +9320,16 @@ struct bpf_link *bpf_program__attach_uprobe(struct bpf_program *prog,
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
@@ -9342,14 +9380,21 @@ static int perf_event_open_tracepoint(const char *tp_category,
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
@@ -9357,7 +9402,7 @@ struct bpf_link *bpf_program__attach_tracepoint(struct bpf_program *prog,
 			libbpf_strerror_r(pfd, errmsg, sizeof(errmsg)));
 		return libbpf_err_ptr(pfd);
 	}
-	link = bpf_program__attach_perf_event(prog, pfd);
+	link = bpf_program__attach_perf_event_opts(prog, pfd, &pe_opts);
 	err = libbpf_get_error(link);
 	if (err) {
 		close(pfd);
@@ -9369,6 +9414,13 @@ struct bpf_link *bpf_program__attach_tracepoint(struct bpf_program *prog,
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

