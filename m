Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D8A4447A65
	for <lists+bpf@lfdr.de>; Mon,  8 Nov 2021 07:13:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237687AbhKHGQa convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Mon, 8 Nov 2021 01:16:30 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:22634 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233642AbhKHGQ3 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 8 Nov 2021 01:16:29 -0500
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1A80nK3A006520
        for <bpf@vger.kernel.org>; Sun, 7 Nov 2021 22:13:45 -0800
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3c698wdk73-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Sun, 07 Nov 2021 22:13:45 -0800
Received: from intmgw001.27.prn2.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Sun, 7 Nov 2021 22:13:43 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id B70DF84C49CA; Sun,  7 Nov 2021 22:13:31 -0800 (PST)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>
Subject: [PATCH bpf-next 07/11] libbpf: make perf_buffer__new() use OPTS-based interface
Date:   Sun, 7 Nov 2021 22:13:12 -0800
Message-ID: <20211108061316.203217-8-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211108061316.203217-1-andrii@kernel.org>
References: <20211108061316.203217-1-andrii@kernel.org>
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-GUID: QiE8PWGXj75ppRRYqN-tRLv_cYhp_lhH
X-Proofpoint-ORIG-GUID: QiE8PWGXj75ppRRYqN-tRLv_cYhp_lhH
Content-Transfer-Encoding: 8BIT
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-08_01,2021-11-03_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 clxscore=1015
 adultscore=0 suspectscore=0 bulkscore=0 spamscore=0 mlxscore=0
 mlxlogscore=999 malwarescore=0 phishscore=0 lowpriorityscore=0
 priorityscore=1501 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2110150000 definitions=main-2111080041
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add new variants of perf_buffer__new() and perf_buffer__new_raw() that
use OPTS-based options for future extensibility ([0]). Given all the
currently used API names are best fits, re-use them and use
___libbpf_override() approach and symbol versioning to preserve ABI and
source code compatibility. struct perf_buffer_opts and struct
perf_buffer_raw_opts are kept as well, but they are restructured such
that they are OPTS-based when used with new APIs. For struct
perf_buffer_raw_opts we keep few fields intact, so we have to also
preserve the memory location of them both when used as OPTS and for
legacy API variants. This is achieved with anonymous padding for OPTS
"incarnation" of the struct.  These pads can be eventually used for new
options.

  [0] Closes: https://github.com/libbpf/libbpf/issues/311

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/libbpf.c   | 70 +++++++++++++++++++++++++-------
 tools/lib/bpf/libbpf.h   | 86 ++++++++++++++++++++++++++++++++++------
 tools/lib/bpf/libbpf.map |  4 ++
 3 files changed, 132 insertions(+), 28 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index d869ebee1e27..cc08d677c5c0 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -10564,11 +10564,18 @@ perf_buffer__open_cpu_buf(struct perf_buffer *pb, struct perf_event_attr *attr,
 static struct perf_buffer *__perf_buffer__new(int map_fd, size_t page_cnt,
 					      struct perf_buffer_params *p);
 
-struct perf_buffer *perf_buffer__new(int map_fd, size_t page_cnt,
-				     const struct perf_buffer_opts *opts)
+DEFAULT_VERSION(perf_buffer__new_v0_6_0, perf_buffer__new, LIBBPF_0.6.0)
+struct perf_buffer *perf_buffer__new_v0_6_0(int map_fd, size_t page_cnt,
+					    perf_buffer_sample_fn sample_cb,
+					    perf_buffer_lost_fn lost_cb,
+					    void *ctx,
+					    const struct perf_buffer_opts *opts)
 {
 	struct perf_buffer_params p = {};
-	struct perf_event_attr attr = { 0, };
+	struct perf_event_attr attr = {};
+
+	if (!OPTS_VALID(opts, perf_buffer_opts))
+		return libbpf_err_ptr(-EINVAL);
 
 	attr.config = PERF_COUNT_SW_BPF_OUTPUT;
 	attr.type = PERF_TYPE_SOFTWARE;
@@ -10577,29 +10584,62 @@ struct perf_buffer *perf_buffer__new(int map_fd, size_t page_cnt,
 	attr.wakeup_events = 1;
 
 	p.attr = &attr;
-	p.sample_cb = opts ? opts->sample_cb : NULL;
-	p.lost_cb = opts ? opts->lost_cb : NULL;
-	p.ctx = opts ? opts->ctx : NULL;
+	p.sample_cb = sample_cb;
+	p.lost_cb = lost_cb;
+	p.ctx = ctx;
 
 	return libbpf_ptr(__perf_buffer__new(map_fd, page_cnt, &p));
 }
 
-struct perf_buffer *
-perf_buffer__new_raw(int map_fd, size_t page_cnt,
-		     const struct perf_buffer_raw_opts *opts)
+COMPAT_VERSION(perf_buffer__new_deprecated, perf_buffer__new, LIBBPF_0.0.4)
+struct perf_buffer *perf_buffer__new_deprecated(int map_fd, size_t page_cnt,
+						const struct perf_buffer_opts *opts)
+{
+	return perf_buffer__new_v0_6_0(map_fd, page_cnt,
+				       opts ? opts->sample_cb : NULL,
+				       opts ? opts->lost_cb : NULL,
+				       opts ? opts->ctx : NULL,
+				       NULL);
+}
+
+DEFAULT_VERSION(perf_buffer__new_raw_v0_6_0, perf_buffer__new_raw, LIBBPF_0.6.0)
+struct perf_buffer *perf_buffer__new_raw_v0_6_0(int map_fd, size_t page_cnt,
+						struct perf_event_attr *attr,
+						perf_buffer_event_fn event_cb, void *ctx,
+						const struct perf_buffer_raw_opts *opts)
 {
 	struct perf_buffer_params p = {};
 
-	p.attr = opts->attr;
-	p.event_cb = opts->event_cb;
-	p.ctx = opts->ctx;
-	p.cpu_cnt = opts->cpu_cnt;
-	p.cpus = opts->cpus;
-	p.map_keys = opts->map_keys;
+	if (page_cnt == 0 || !attr)
+		return libbpf_err_ptr(-EINVAL);
+
+	if (!OPTS_VALID(opts, perf_buffer_raw_opts))
+		return libbpf_err_ptr(-EINVAL);
+
+	p.attr = attr;
+	p.event_cb = event_cb;
+	p.ctx = ctx;
+	p.cpu_cnt = OPTS_GET(opts, cpu_cnt, 0);
+	p.cpus = OPTS_GET(opts, cpus, NULL);
+	p.map_keys = OPTS_GET(opts, map_keys, NULL);
 
 	return libbpf_ptr(__perf_buffer__new(map_fd, page_cnt, &p));
 }
 
+COMPAT_VERSION(perf_buffer__new_raw_deprecated, perf_buffer__new_raw, LIBBPF_0.0.4)
+struct perf_buffer *perf_buffer__new_raw_deprecated(int map_fd, size_t page_cnt,
+						    const struct perf_buffer_raw_opts *opts)
+{
+	LIBBPF_OPTS(perf_buffer_raw_opts, inner_opts,
+		.cpu_cnt = opts->cpu_cnt,
+		.cpus = opts->cpus,
+		.map_keys = opts->map_keys,
+	);
+
+	return perf_buffer__new_raw_v0_6_0(map_fd, page_cnt, opts->attr,
+					   opts->event_cb, opts->ctx, &inner_opts);
+}
+
 static struct perf_buffer *__perf_buffer__new(int map_fd, size_t page_cnt,
 					      struct perf_buffer_params *p)
 {
diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index 039058763173..47d4585a79bb 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -775,18 +775,52 @@ typedef void (*perf_buffer_lost_fn)(void *ctx, int cpu, __u64 cnt);
 
 /* common use perf buffer options */
 struct perf_buffer_opts {
-	/* if specified, sample_cb is called for each sample */
-	perf_buffer_sample_fn sample_cb;
-	/* if specified, lost_cb is called for each batch of lost samples */
-	perf_buffer_lost_fn lost_cb;
-	/* ctx is provided to sample_cb and lost_cb */
-	void *ctx;
+	union {
+		size_t sz;
+		struct { /* DEPRECATED: will be removed in v1.0 */
+			/* if specified, sample_cb is called for each sample */
+			perf_buffer_sample_fn sample_cb;
+			/* if specified, lost_cb is called for each batch of lost samples */
+			perf_buffer_lost_fn lost_cb;
+			/* ctx is provided to sample_cb and lost_cb */
+			void *ctx;
+		};
+	};
 };
+#define perf_buffer_opts__last_field sz
 
+/**
+ * @brief **perf_buffer__new()** creates BPF perfbuf manager for a specified
+ * BPF_PERF_EVENT_ARRAY map
+ * @param map_fd FD of BPF_PERF_EVENT_ARRAY BPF map that will be used by BPF
+ * code to send data over to user-space
+ * @param page_cnt number of memory pages allocated for each per-CPU buffer
+ * @param sample_cb function called on each received data record
+ * @param lost_cb function called when record loss has occurred
+ * @param ctx user-provided extra context passed into *sample_cb* and *lost_cb*
+ * @return a new instance of struct perf_buffer on success, NULL on error with
+ * *errno* containing an error code
+ */
 LIBBPF_API struct perf_buffer *
 perf_buffer__new(int map_fd, size_t page_cnt,
+		 perf_buffer_sample_fn sample_cb, perf_buffer_lost_fn lost_cb, void *ctx,
 		 const struct perf_buffer_opts *opts);
 
+LIBBPF_API struct perf_buffer *
+perf_buffer__new_v0_6_0(int map_fd, size_t page_cnt,
+			perf_buffer_sample_fn sample_cb, perf_buffer_lost_fn lost_cb, void *ctx,
+			const struct perf_buffer_opts *opts);
+
+LIBBPF_API LIBBPF_DEPRECATED_SINCE(0, 7, "use new variant of perf_buffer__new() instead")
+struct perf_buffer *perf_buffer__new_deprecated(int map_fd, size_t page_cnt,
+						const struct perf_buffer_opts *opts);
+
+#define perf_buffer__new(...) ___libbpf_overload(___perf_buffer_new, __VA_ARGS__)
+#define ___perf_buffer_new6(map_fd, page_cnt, sample_cb, lost_cb, ctx, opts) \
+	perf_buffer__new(map_fd, page_cnt, sample_cb, lost_cb, ctx, opts)
+#define ___perf_buffer_new3(map_fd, page_cnt, opts) \
+	perf_buffer__new_deprecated(map_fd, page_cnt, opts)
+
 enum bpf_perf_event_ret {
 	LIBBPF_PERF_EVENT_DONE	= 0,
 	LIBBPF_PERF_EVENT_ERROR	= -1,
@@ -800,12 +834,21 @@ typedef enum bpf_perf_event_ret
 
 /* raw perf buffer options, giving most power and control */
 struct perf_buffer_raw_opts {
-	/* perf event attrs passed directly into perf_event_open() */
-	struct perf_event_attr *attr;
-	/* raw event callback */
-	perf_buffer_event_fn event_cb;
-	/* ctx is provided to event_cb */
-	void *ctx;
+	union {
+		struct {
+			size_t sz;
+			long :0;
+			long :0;
+		};
+		struct { /* DEPRECATED: will be removed in v1.0 */
+			/* perf event attrs passed directly into perf_event_open() */
+			struct perf_event_attr *attr;
+			/* raw event callback */
+			perf_buffer_event_fn event_cb;
+			/* ctx is provided to event_cb */
+			void *ctx;
+		};
+	};
 	/* if cpu_cnt == 0, open all on all possible CPUs (up to the number of
 	 * max_entries of given PERF_EVENT_ARRAY map)
 	 */
@@ -815,11 +858,28 @@ struct perf_buffer_raw_opts {
 	/* if cpu_cnt > 0, map_keys specify map keys to set per-CPU FDs for */
 	int *map_keys;
 };
+#define perf_buffer_raw_opts__last_field map_keys
 
 LIBBPF_API struct perf_buffer *
-perf_buffer__new_raw(int map_fd, size_t page_cnt,
+perf_buffer__new_raw(int map_fd, size_t page_cnt, struct perf_event_attr *attr,
+		     perf_buffer_event_fn event_cb, void *ctx,
 		     const struct perf_buffer_raw_opts *opts);
 
+LIBBPF_API struct perf_buffer *
+perf_buffer__new_raw_v0_6_0(int map_fd, size_t page_cnt, struct perf_event_attr *attr,
+			    perf_buffer_event_fn event_cb, void *ctx,
+			    const struct perf_buffer_raw_opts *opts);
+
+LIBBPF_API LIBBPF_DEPRECATED_SINCE(0, 7, "use new variant of perf_buffer__new_raw() instead")
+struct perf_buffer *perf_buffer__new_raw_deprecated(int map_fd, size_t page_cnt,
+						    const struct perf_buffer_raw_opts *opts);
+
+#define perf_buffer__new_raw(...) ___libbpf_overload(___perf_buffer_new_raw, __VA_ARGS__)
+#define ___perf_buffer_new_raw6(map_fd, page_cnt, attr, event_cb, ctx, opts) \
+	perf_buffer__new_raw(map_fd, page_cnt, attr, event_cb, ctx, opts)
+#define ___perf_buffer_new_raw3(map_fd, page_cnt, opts) \
+	perf_buffer__new_raw_deprecated(map_fd, page_cnt, opts)
+
 LIBBPF_API void perf_buffer__free(struct perf_buffer *pb);
 LIBBPF_API int perf_buffer__epoll_fd(const struct perf_buffer *pb);
 LIBBPF_API int perf_buffer__poll(struct perf_buffer *pb, int timeout_ms);
diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
index c51411d46c9e..19396e1c59f9 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -407,4 +407,8 @@ LIBBPF_0.6.0 {
 		btf__type_cnt;
 		btf_dump__new;
 		btf_dump__new_deprecated;
+		perf_buffer__new;
+		perf_buffer__new_deprecated;
+		perf_buffer__new_raw;
+		perf_buffer__new_raw_deprecated;
 } LIBBPF_0.5.0;
-- 
2.30.2

