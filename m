Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1EFC40D17F
	for <lists+bpf@lfdr.de>; Thu, 16 Sep 2021 03:59:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233688AbhIPCAX convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Wed, 15 Sep 2021 22:00:23 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:55156 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233565AbhIPCAX (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 15 Sep 2021 22:00:23 -0400
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18FM43Qu030421
        for <bpf@vger.kernel.org>; Wed, 15 Sep 2021 18:59:03 -0700
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3b3pnh251f-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 15 Sep 2021 18:59:03 -0700
Received: from intmgw001.37.frc1.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Wed, 15 Sep 2021 18:59:02 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 57E1A422A299; Wed, 15 Sep 2021 18:58:53 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>
Subject: [PATCH bpf-next 7/7] libbpf: constify all high-level program attach APIs
Date:   Wed, 15 Sep 2021 18:58:36 -0700
Message-ID: <20210916015836.1248906-8-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210916015836.1248906-1-andrii@kernel.org>
References: <20210916015836.1248906-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-GUID: YtL9JZnzUkf4sa-X1B8kJclfEBgjglja
X-Proofpoint-ORIG-GUID: YtL9JZnzUkf4sa-X1B8kJclfEBgjglja
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-15_07,2021-09-15_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 phishscore=0 spamscore=0 bulkscore=0 priorityscore=1501 malwarescore=0
 mlxscore=0 clxscore=1015 adultscore=0 suspectscore=0 impostorscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109030001 definitions=main-2109160010
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Attach APIs shouldn't need to modify bpf_program/bpf_map structs, so
change all struct bpf_program and struct bpf_map pointers to const
pointers. This is completely backwards compatible with no functional
change.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/libbpf.c | 68 +++++++++++++++++++++---------------------
 tools/lib/bpf/libbpf.h | 36 +++++++++++-----------
 2 files changed, 52 insertions(+), 52 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 6aeeb0e82acc..da65a1666a5e 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -220,7 +220,7 @@ struct reloc_desc {
 
 struct bpf_sec_def;
 
-typedef struct bpf_link *(*attach_fn_t)(struct bpf_program *prog);
+typedef struct bpf_link *(*attach_fn_t)(const struct bpf_program *prog);
 
 struct bpf_sec_def {
 	const char *sec;
@@ -7947,12 +7947,12 @@ void bpf_program__set_expected_attach_type(struct bpf_program *prog,
 	__VA_ARGS__							    \
 }
 
-static struct bpf_link *attach_kprobe(struct bpf_program *prog);
-static struct bpf_link *attach_tp(struct bpf_program *prog);
-static struct bpf_link *attach_raw_tp(struct bpf_program *prog);
-static struct bpf_link *attach_trace(struct bpf_program *prog);
-static struct bpf_link *attach_lsm(struct bpf_program *prog);
-static struct bpf_link *attach_iter(struct bpf_program *prog);
+static struct bpf_link *attach_kprobe(const struct bpf_program *prog);
+static struct bpf_link *attach_tp(const struct bpf_program *prog);
+static struct bpf_link *attach_raw_tp(const struct bpf_program *prog);
+static struct bpf_link *attach_trace(const struct bpf_program *prog);
+static struct bpf_link *attach_lsm(const struct bpf_program *prog);
+static struct bpf_link *attach_iter(const struct bpf_program *prog);
 
 static const struct bpf_sec_def section_defs[] = {
 	BPF_PROG_SEC("socket",			BPF_PROG_TYPE_SOCKET_FILTER),
@@ -9092,7 +9092,7 @@ static void bpf_link_perf_dealloc(struct bpf_link *link)
 	free(perf_link);
 }
 
-struct bpf_link *bpf_program__attach_perf_event_opts(struct bpf_program *prog, int pfd,
+struct bpf_link *bpf_program__attach_perf_event_opts(const struct bpf_program *prog, int pfd,
 						     const struct bpf_perf_event_opts *opts)
 {
 	char errmsg[STRERR_BUFSIZE];
@@ -9167,7 +9167,7 @@ struct bpf_link *bpf_program__attach_perf_event_opts(struct bpf_program *prog, i
 	return libbpf_err_ptr(err);
 }
 
-struct bpf_link *bpf_program__attach_perf_event(struct bpf_program *prog, int pfd)
+struct bpf_link *bpf_program__attach_perf_event(const struct bpf_program *prog, int pfd)
 {
 	return bpf_program__attach_perf_event_opts(prog, pfd, NULL);
 }
@@ -9332,7 +9332,7 @@ static int perf_event_kprobe_open_legacy(bool retprobe, const char *name, uint64
 }
 
 struct bpf_link *
-bpf_program__attach_kprobe_opts(struct bpf_program *prog,
+bpf_program__attach_kprobe_opts(const struct bpf_program *prog,
 				const char *func_name,
 				const struct bpf_kprobe_opts *opts)
 {
@@ -9389,7 +9389,7 @@ bpf_program__attach_kprobe_opts(struct bpf_program *prog,
 	return link;
 }
 
-struct bpf_link *bpf_program__attach_kprobe(struct bpf_program *prog,
+struct bpf_link *bpf_program__attach_kprobe(const struct bpf_program *prog,
 					    bool retprobe,
 					    const char *func_name)
 {
@@ -9400,7 +9400,7 @@ struct bpf_link *bpf_program__attach_kprobe(struct bpf_program *prog,
 	return bpf_program__attach_kprobe_opts(prog, func_name, &opts);
 }
 
-static struct bpf_link *attach_kprobe(struct bpf_program *prog)
+static struct bpf_link *attach_kprobe(const struct bpf_program *prog)
 {
 	DECLARE_LIBBPF_OPTS(bpf_kprobe_opts, opts);
 	unsigned long offset = 0;
@@ -9432,7 +9432,7 @@ static struct bpf_link *attach_kprobe(struct bpf_program *prog)
 }
 
 LIBBPF_API struct bpf_link *
-bpf_program__attach_uprobe_opts(struct bpf_program *prog, pid_t pid,
+bpf_program__attach_uprobe_opts(const struct bpf_program *prog, pid_t pid,
 				const char *binary_path, size_t func_offset,
 				const struct bpf_uprobe_opts *opts)
 {
@@ -9472,7 +9472,7 @@ bpf_program__attach_uprobe_opts(struct bpf_program *prog, pid_t pid,
 	return link;
 }
 
-struct bpf_link *bpf_program__attach_uprobe(struct bpf_program *prog,
+struct bpf_link *bpf_program__attach_uprobe(const struct bpf_program *prog,
 					    bool retprobe, pid_t pid,
 					    const char *binary_path,
 					    size_t func_offset)
@@ -9532,7 +9532,7 @@ static int perf_event_open_tracepoint(const char *tp_category,
 	return pfd;
 }
 
-struct bpf_link *bpf_program__attach_tracepoint_opts(struct bpf_program *prog,
+struct bpf_link *bpf_program__attach_tracepoint_opts(const struct bpf_program *prog,
 						     const char *tp_category,
 						     const char *tp_name,
 						     const struct bpf_tracepoint_opts *opts)
@@ -9566,14 +9566,14 @@ struct bpf_link *bpf_program__attach_tracepoint_opts(struct bpf_program *prog,
 	return link;
 }
 
-struct bpf_link *bpf_program__attach_tracepoint(struct bpf_program *prog,
+struct bpf_link *bpf_program__attach_tracepoint(const struct bpf_program *prog,
 						const char *tp_category,
 						const char *tp_name)
 {
 	return bpf_program__attach_tracepoint_opts(prog, tp_category, tp_name, NULL);
 }
 
-static struct bpf_link *attach_tp(struct bpf_program *prog)
+static struct bpf_link *attach_tp(const struct bpf_program *prog)
 {
 	char *sec_name, *tp_cat, *tp_name;
 	struct bpf_link *link;
@@ -9597,7 +9597,7 @@ static struct bpf_link *attach_tp(struct bpf_program *prog)
 	return link;
 }
 
-struct bpf_link *bpf_program__attach_raw_tracepoint(struct bpf_program *prog,
+struct bpf_link *bpf_program__attach_raw_tracepoint(const struct bpf_program *prog,
 						    const char *tp_name)
 {
 	char errmsg[STRERR_BUFSIZE];
@@ -9627,7 +9627,7 @@ struct bpf_link *bpf_program__attach_raw_tracepoint(struct bpf_program *prog,
 	return link;
 }
 
-static struct bpf_link *attach_raw_tp(struct bpf_program *prog)
+static struct bpf_link *attach_raw_tp(const struct bpf_program *prog)
 {
 	const char *tp_name = prog->sec_name + prog->sec_def->len;
 
@@ -9635,7 +9635,7 @@ static struct bpf_link *attach_raw_tp(struct bpf_program *prog)
 }
 
 /* Common logic for all BPF program types that attach to a btf_id */
-static struct bpf_link *bpf_program__attach_btf_id(struct bpf_program *prog)
+static struct bpf_link *bpf_program__attach_btf_id(const struct bpf_program *prog)
 {
 	char errmsg[STRERR_BUFSIZE];
 	struct bpf_link *link;
@@ -9664,28 +9664,28 @@ static struct bpf_link *bpf_program__attach_btf_id(struct bpf_program *prog)
 	return (struct bpf_link *)link;
 }
 
-struct bpf_link *bpf_program__attach_trace(struct bpf_program *prog)
+struct bpf_link *bpf_program__attach_trace(const struct bpf_program *prog)
 {
 	return bpf_program__attach_btf_id(prog);
 }
 
-struct bpf_link *bpf_program__attach_lsm(struct bpf_program *prog)
+struct bpf_link *bpf_program__attach_lsm(const struct bpf_program *prog)
 {
 	return bpf_program__attach_btf_id(prog);
 }
 
-static struct bpf_link *attach_trace(struct bpf_program *prog)
+static struct bpf_link *attach_trace(const struct bpf_program *prog)
 {
 	return bpf_program__attach_trace(prog);
 }
 
-static struct bpf_link *attach_lsm(struct bpf_program *prog)
+static struct bpf_link *attach_lsm(const struct bpf_program *prog)
 {
 	return bpf_program__attach_lsm(prog);
 }
 
 static struct bpf_link *
-bpf_program__attach_fd(struct bpf_program *prog, int target_fd, int btf_id,
+bpf_program__attach_fd(const struct bpf_program *prog, int target_fd, int btf_id,
 		       const char *target_name)
 {
 	DECLARE_LIBBPF_OPTS(bpf_link_create_opts, opts,
@@ -9721,24 +9721,24 @@ bpf_program__attach_fd(struct bpf_program *prog, int target_fd, int btf_id,
 }
 
 struct bpf_link *
-bpf_program__attach_cgroup(struct bpf_program *prog, int cgroup_fd)
+bpf_program__attach_cgroup(const struct bpf_program *prog, int cgroup_fd)
 {
 	return bpf_program__attach_fd(prog, cgroup_fd, 0, "cgroup");
 }
 
 struct bpf_link *
-bpf_program__attach_netns(struct bpf_program *prog, int netns_fd)
+bpf_program__attach_netns(const struct bpf_program *prog, int netns_fd)
 {
 	return bpf_program__attach_fd(prog, netns_fd, 0, "netns");
 }
 
-struct bpf_link *bpf_program__attach_xdp(struct bpf_program *prog, int ifindex)
+struct bpf_link *bpf_program__attach_xdp(const struct bpf_program *prog, int ifindex)
 {
 	/* target_fd/target_ifindex use the same field in LINK_CREATE */
 	return bpf_program__attach_fd(prog, ifindex, 0, "xdp");
 }
 
-struct bpf_link *bpf_program__attach_freplace(struct bpf_program *prog,
+struct bpf_link *bpf_program__attach_freplace(const struct bpf_program *prog,
 					      int target_fd,
 					      const char *attach_func_name)
 {
@@ -9771,7 +9771,7 @@ struct bpf_link *bpf_program__attach_freplace(struct bpf_program *prog,
 }
 
 struct bpf_link *
-bpf_program__attach_iter(struct bpf_program *prog,
+bpf_program__attach_iter(const struct bpf_program *prog,
 			 const struct bpf_iter_attach_opts *opts)
 {
 	DECLARE_LIBBPF_OPTS(bpf_link_create_opts, link_create_opts);
@@ -9810,12 +9810,12 @@ bpf_program__attach_iter(struct bpf_program *prog,
 	return link;
 }
 
-static struct bpf_link *attach_iter(struct bpf_program *prog)
+static struct bpf_link *attach_iter(const struct bpf_program *prog)
 {
 	return bpf_program__attach_iter(prog, NULL);
 }
 
-struct bpf_link *bpf_program__attach(struct bpf_program *prog)
+struct bpf_link *bpf_program__attach(const struct bpf_program *prog)
 {
 	if (!prog->sec_def || !prog->sec_def->attach_fn)
 		return libbpf_err_ptr(-ESRCH);
@@ -9833,7 +9833,7 @@ static int bpf_link__detach_struct_ops(struct bpf_link *link)
 	return 0;
 }
 
-struct bpf_link *bpf_map__attach_struct_ops(struct bpf_map *map)
+struct bpf_link *bpf_map__attach_struct_ops(const struct bpf_map *map)
 {
 	struct bpf_struct_ops *st_ops;
 	struct bpf_link *link;
@@ -10918,7 +10918,7 @@ int bpf_object__attach_skeleton(struct bpf_object_skeleton *s)
 		if (!prog->sec_def || !prog->sec_def->attach_fn)
 			continue;
 
-		*link = prog->sec_def->attach_fn(prog);
+		*link = bpf_program__attach(prog);
 		err = libbpf_get_error(*link);
 		if (err) {
 			pr_warn("failed to auto-attach program '%s': %d\n",
diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index 52b7ee090037..c90e3d79e72c 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -246,7 +246,7 @@ LIBBPF_API int bpf_link__detach(struct bpf_link *link);
 LIBBPF_API int bpf_link__destroy(struct bpf_link *link);
 
 LIBBPF_API struct bpf_link *
-bpf_program__attach(struct bpf_program *prog);
+bpf_program__attach(const struct bpf_program *prog);
 
 struct bpf_perf_event_opts {
 	/* size of this struct, for forward/backward compatiblity */
@@ -257,10 +257,10 @@ struct bpf_perf_event_opts {
 #define bpf_perf_event_opts__last_field bpf_cookie
 
 LIBBPF_API struct bpf_link *
-bpf_program__attach_perf_event(struct bpf_program *prog, int pfd);
+bpf_program__attach_perf_event(const struct bpf_program *prog, int pfd);
 
 LIBBPF_API struct bpf_link *
-bpf_program__attach_perf_event_opts(struct bpf_program *prog, int pfd,
+bpf_program__attach_perf_event_opts(const struct bpf_program *prog, int pfd,
 				    const struct bpf_perf_event_opts *opts);
 
 struct bpf_kprobe_opts {
@@ -277,10 +277,10 @@ struct bpf_kprobe_opts {
 #define bpf_kprobe_opts__last_field retprobe
 
 LIBBPF_API struct bpf_link *
-bpf_program__attach_kprobe(struct bpf_program *prog, bool retprobe,
+bpf_program__attach_kprobe(const struct bpf_program *prog, bool retprobe,
 			   const char *func_name);
 LIBBPF_API struct bpf_link *
-bpf_program__attach_kprobe_opts(struct bpf_program *prog,
+bpf_program__attach_kprobe_opts(const struct bpf_program *prog,
                                 const char *func_name,
                                 const struct bpf_kprobe_opts *opts);
 
@@ -300,11 +300,11 @@ struct bpf_uprobe_opts {
 #define bpf_uprobe_opts__last_field retprobe
 
 LIBBPF_API struct bpf_link *
-bpf_program__attach_uprobe(struct bpf_program *prog, bool retprobe,
+bpf_program__attach_uprobe(const struct bpf_program *prog, bool retprobe,
 			   pid_t pid, const char *binary_path,
 			   size_t func_offset);
 LIBBPF_API struct bpf_link *
-bpf_program__attach_uprobe_opts(struct bpf_program *prog, pid_t pid,
+bpf_program__attach_uprobe_opts(const struct bpf_program *prog, pid_t pid,
 				const char *binary_path, size_t func_offset,
 				const struct bpf_uprobe_opts *opts);
 
@@ -317,35 +317,35 @@ struct bpf_tracepoint_opts {
 #define bpf_tracepoint_opts__last_field bpf_cookie
 
 LIBBPF_API struct bpf_link *
-bpf_program__attach_tracepoint(struct bpf_program *prog,
+bpf_program__attach_tracepoint(const struct bpf_program *prog,
 			       const char *tp_category,
 			       const char *tp_name);
 LIBBPF_API struct bpf_link *
-bpf_program__attach_tracepoint_opts(struct bpf_program *prog,
+bpf_program__attach_tracepoint_opts(const struct bpf_program *prog,
 				    const char *tp_category,
 				    const char *tp_name,
 				    const struct bpf_tracepoint_opts *opts);
 
 LIBBPF_API struct bpf_link *
-bpf_program__attach_raw_tracepoint(struct bpf_program *prog,
+bpf_program__attach_raw_tracepoint(const struct bpf_program *prog,
 				   const char *tp_name);
 LIBBPF_API struct bpf_link *
-bpf_program__attach_trace(struct bpf_program *prog);
+bpf_program__attach_trace(const struct bpf_program *prog);
 LIBBPF_API struct bpf_link *
-bpf_program__attach_lsm(struct bpf_program *prog);
+bpf_program__attach_lsm(const struct bpf_program *prog);
 LIBBPF_API struct bpf_link *
-bpf_program__attach_cgroup(struct bpf_program *prog, int cgroup_fd);
+bpf_program__attach_cgroup(const struct bpf_program *prog, int cgroup_fd);
 LIBBPF_API struct bpf_link *
-bpf_program__attach_netns(struct bpf_program *prog, int netns_fd);
+bpf_program__attach_netns(const struct bpf_program *prog, int netns_fd);
 LIBBPF_API struct bpf_link *
-bpf_program__attach_xdp(struct bpf_program *prog, int ifindex);
+bpf_program__attach_xdp(const struct bpf_program *prog, int ifindex);
 LIBBPF_API struct bpf_link *
-bpf_program__attach_freplace(struct bpf_program *prog,
+bpf_program__attach_freplace(const struct bpf_program *prog,
 			     int target_fd, const char *attach_func_name);
 
 struct bpf_map;
 
-LIBBPF_API struct bpf_link *bpf_map__attach_struct_ops(struct bpf_map *map);
+LIBBPF_API struct bpf_link *bpf_map__attach_struct_ops(const struct bpf_map *map);
 
 struct bpf_iter_attach_opts {
 	size_t sz; /* size of this struct for forward/backward compatibility */
@@ -355,7 +355,7 @@ struct bpf_iter_attach_opts {
 #define bpf_iter_attach_opts__last_field link_info_len
 
 LIBBPF_API struct bpf_link *
-bpf_program__attach_iter(struct bpf_program *prog,
+bpf_program__attach_iter(const struct bpf_program *prog,
 			 const struct bpf_iter_attach_opts *opts);
 
 struct bpf_insn;
-- 
2.30.2

