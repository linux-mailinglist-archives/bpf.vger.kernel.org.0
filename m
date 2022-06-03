Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 244FA53D219
	for <lists+bpf@lfdr.de>; Fri,  3 Jun 2022 21:03:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348706AbiFCTDv convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Fri, 3 Jun 2022 15:03:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348696AbiFCTDt (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 3 Jun 2022 15:03:49 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C40631201
        for <bpf@vger.kernel.org>; Fri,  3 Jun 2022 12:03:48 -0700 (PDT)
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 253GmLmN007248
        for <bpf@vger.kernel.org>; Fri, 3 Jun 2022 12:03:48 -0700
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3gfnmv94r0-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 03 Jun 2022 12:03:48 -0700
Received: from twshared5413.23.frc3.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Fri, 3 Jun 2022 12:03:46 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id E748B1AC9C408; Fri,  3 Jun 2022 12:03:42 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>
Subject: [PATCH bpf-next 06/15] libbpf: clean up perfbuf APIs
Date:   Fri, 3 Jun 2022 12:01:46 -0700
Message-ID: <20220603190155.3924899-7-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220603190155.3924899-1-andrii@kernel.org>
References: <20220603190155.3924899-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: CkTOA75rOCdKRPTqjOZueKG0vul6hNoD
X-Proofpoint-GUID: CkTOA75rOCdKRPTqjOZueKG0vul6hNoD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-06-03_06,2022-06-03_01,2022-02-23_01
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Remove deprecated perfbuf APIs and clean up opts structs.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/libbpf.c   | 54 +++++++-----------------------
 tools/lib/bpf/libbpf.h   | 71 ++++------------------------------------
 tools/lib/bpf/libbpf.map |  5 ---
 3 files changed, 18 insertions(+), 112 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 1b17a154bb63..422c9d4811f4 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -12012,6 +12012,9 @@ struct bpf_link *bpf_map__attach_struct_ops(const struct bpf_map *map)
 	return link;
 }
 
+typedef enum bpf_perf_event_ret (*bpf_perf_event_print_t)(struct perf_event_header *hdr,
+							  void *private_data);
+
 static enum bpf_perf_event_ret
 perf_event_read_simple(void *mmap_mem, size_t mmap_size, size_t page_size,
 		       void **copy_mem, size_t *copy_size,
@@ -12060,12 +12063,6 @@ perf_event_read_simple(void *mmap_mem, size_t mmap_size, size_t page_size,
 	return libbpf_err(ret);
 }
 
-__attribute__((alias("perf_event_read_simple")))
-enum bpf_perf_event_ret
-bpf_perf_event_read_simple(void *mmap_mem, size_t mmap_size, size_t page_size,
-			   void **copy_mem, size_t *copy_size,
-			   bpf_perf_event_print_t fn, void *private_data);
-
 struct perf_buffer;
 
 struct perf_buffer_params {
@@ -12199,12 +12196,11 @@ perf_buffer__open_cpu_buf(struct perf_buffer *pb, struct perf_event_attr *attr,
 static struct perf_buffer *__perf_buffer__new(int map_fd, size_t page_cnt,
 					      struct perf_buffer_params *p);
 
-DEFAULT_VERSION(perf_buffer__new_v0_6_0, perf_buffer__new, LIBBPF_0.6.0)
-struct perf_buffer *perf_buffer__new_v0_6_0(int map_fd, size_t page_cnt,
-					    perf_buffer_sample_fn sample_cb,
-					    perf_buffer_lost_fn lost_cb,
-					    void *ctx,
-					    const struct perf_buffer_opts *opts)
+struct perf_buffer *perf_buffer__new(int map_fd, size_t page_cnt,
+				     perf_buffer_sample_fn sample_cb,
+				     perf_buffer_lost_fn lost_cb,
+				     void *ctx,
+				     const struct perf_buffer_opts *opts)
 {
 	struct perf_buffer_params p = {};
 	struct perf_event_attr attr = {};
@@ -12226,22 +12222,10 @@ struct perf_buffer *perf_buffer__new_v0_6_0(int map_fd, size_t page_cnt,
 	return libbpf_ptr(__perf_buffer__new(map_fd, page_cnt, &p));
 }
 
-COMPAT_VERSION(perf_buffer__new_deprecated, perf_buffer__new, LIBBPF_0.0.4)
-struct perf_buffer *perf_buffer__new_deprecated(int map_fd, size_t page_cnt,
-						const struct perf_buffer_opts *opts)
-{
-	return perf_buffer__new_v0_6_0(map_fd, page_cnt,
-				       opts ? opts->sample_cb : NULL,
-				       opts ? opts->lost_cb : NULL,
-				       opts ? opts->ctx : NULL,
-				       NULL);
-}
-
-DEFAULT_VERSION(perf_buffer__new_raw_v0_6_0, perf_buffer__new_raw, LIBBPF_0.6.0)
-struct perf_buffer *perf_buffer__new_raw_v0_6_0(int map_fd, size_t page_cnt,
-						struct perf_event_attr *attr,
-						perf_buffer_event_fn event_cb, void *ctx,
-						const struct perf_buffer_raw_opts *opts)
+struct perf_buffer *perf_buffer__new_raw(int map_fd, size_t page_cnt,
+					 struct perf_event_attr *attr,
+					 perf_buffer_event_fn event_cb, void *ctx,
+					 const struct perf_buffer_raw_opts *opts)
 {
 	struct perf_buffer_params p = {};
 
@@ -12261,20 +12245,6 @@ struct perf_buffer *perf_buffer__new_raw_v0_6_0(int map_fd, size_t page_cnt,
 	return libbpf_ptr(__perf_buffer__new(map_fd, page_cnt, &p));
 }
 
-COMPAT_VERSION(perf_buffer__new_raw_deprecated, perf_buffer__new_raw, LIBBPF_0.0.4)
-struct perf_buffer *perf_buffer__new_raw_deprecated(int map_fd, size_t page_cnt,
-						    const struct perf_buffer_raw_opts *opts)
-{
-	LIBBPF_OPTS(perf_buffer_raw_opts, inner_opts,
-		.cpu_cnt = opts->cpu_cnt,
-		.cpus = opts->cpus,
-		.map_keys = opts->map_keys,
-	);
-
-	return perf_buffer__new_raw_v0_6_0(map_fd, page_cnt, opts->attr,
-					   opts->event_cb, opts->ctx, &inner_opts);
-}
-
 static struct perf_buffer *__perf_buffer__new(int map_fd, size_t page_cnt,
 					      struct perf_buffer_params *p)
 {
diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index 71b19ae1659c..5dc4271fcdb7 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -1269,17 +1269,7 @@ typedef void (*perf_buffer_lost_fn)(void *ctx, int cpu, __u64 cnt);
 
 /* common use perf buffer options */
 struct perf_buffer_opts {
-	union {
-		size_t sz;
-		struct { /* DEPRECATED: will be removed in v1.0 */
-			/* if specified, sample_cb is called for each sample */
-			perf_buffer_sample_fn sample_cb;
-			/* if specified, lost_cb is called for each batch of lost samples */
-			perf_buffer_lost_fn lost_cb;
-			/* ctx is provided to sample_cb and lost_cb */
-			void *ctx;
-		};
-	};
+	size_t sz;
 };
 #define perf_buffer_opts__last_field sz
 
@@ -1300,21 +1290,6 @@ perf_buffer__new(int map_fd, size_t page_cnt,
 		 perf_buffer_sample_fn sample_cb, perf_buffer_lost_fn lost_cb, void *ctx,
 		 const struct perf_buffer_opts *opts);
 
-LIBBPF_API struct perf_buffer *
-perf_buffer__new_v0_6_0(int map_fd, size_t page_cnt,
-			perf_buffer_sample_fn sample_cb, perf_buffer_lost_fn lost_cb, void *ctx,
-			const struct perf_buffer_opts *opts);
-
-LIBBPF_API LIBBPF_DEPRECATED_SINCE(0, 7, "use new variant of perf_buffer__new() instead")
-struct perf_buffer *perf_buffer__new_deprecated(int map_fd, size_t page_cnt,
-						const struct perf_buffer_opts *opts);
-
-#define perf_buffer__new(...) ___libbpf_overload(___perf_buffer_new, __VA_ARGS__)
-#define ___perf_buffer_new6(map_fd, page_cnt, sample_cb, lost_cb, ctx, opts) \
-	perf_buffer__new(map_fd, page_cnt, sample_cb, lost_cb, ctx, opts)
-#define ___perf_buffer_new3(map_fd, page_cnt, opts) \
-	perf_buffer__new_deprecated(map_fd, page_cnt, opts)
-
 enum bpf_perf_event_ret {
 	LIBBPF_PERF_EVENT_DONE	= 0,
 	LIBBPF_PERF_EVENT_ERROR	= -1,
@@ -1328,21 +1303,9 @@ typedef enum bpf_perf_event_ret
 
 /* raw perf buffer options, giving most power and control */
 struct perf_buffer_raw_opts {
-	union {
-		struct {
-			size_t sz;
-			long :0;
-			long :0;
-		};
-		struct { /* DEPRECATED: will be removed in v1.0 */
-			/* perf event attrs passed directly into perf_event_open() */
-			struct perf_event_attr *attr;
-			/* raw event callback */
-			perf_buffer_event_fn event_cb;
-			/* ctx is provided to event_cb */
-			void *ctx;
-		};
-	};
+	size_t sz;
+	long :0;
+	long :0;
 	/* if cpu_cnt == 0, open all on all possible CPUs (up to the number of
 	 * max_entries of given PERF_EVENT_ARRAY map)
 	 */
@@ -1354,26 +1317,13 @@ struct perf_buffer_raw_opts {
 };
 #define perf_buffer_raw_opts__last_field map_keys
 
+struct perf_event_attr;
+
 LIBBPF_API struct perf_buffer *
 perf_buffer__new_raw(int map_fd, size_t page_cnt, struct perf_event_attr *attr,
 		     perf_buffer_event_fn event_cb, void *ctx,
 		     const struct perf_buffer_raw_opts *opts);
 
-LIBBPF_API struct perf_buffer *
-perf_buffer__new_raw_v0_6_0(int map_fd, size_t page_cnt, struct perf_event_attr *attr,
-			    perf_buffer_event_fn event_cb, void *ctx,
-			    const struct perf_buffer_raw_opts *opts);
-
-LIBBPF_API LIBBPF_DEPRECATED_SINCE(0, 7, "use new variant of perf_buffer__new_raw() instead")
-struct perf_buffer *perf_buffer__new_raw_deprecated(int map_fd, size_t page_cnt,
-						    const struct perf_buffer_raw_opts *opts);
-
-#define perf_buffer__new_raw(...) ___libbpf_overload(___perf_buffer_new_raw, __VA_ARGS__)
-#define ___perf_buffer_new_raw6(map_fd, page_cnt, attr, event_cb, ctx, opts) \
-	perf_buffer__new_raw(map_fd, page_cnt, attr, event_cb, ctx, opts)
-#define ___perf_buffer_new_raw3(map_fd, page_cnt, opts) \
-	perf_buffer__new_raw_deprecated(map_fd, page_cnt, opts)
-
 LIBBPF_API void perf_buffer__free(struct perf_buffer *pb);
 LIBBPF_API int perf_buffer__epoll_fd(const struct perf_buffer *pb);
 LIBBPF_API int perf_buffer__poll(struct perf_buffer *pb, int timeout_ms);
@@ -1382,15 +1332,6 @@ LIBBPF_API int perf_buffer__consume_buffer(struct perf_buffer *pb, size_t buf_id
 LIBBPF_API size_t perf_buffer__buffer_cnt(const struct perf_buffer *pb);
 LIBBPF_API int perf_buffer__buffer_fd(const struct perf_buffer *pb, size_t buf_idx);
 
-typedef enum bpf_perf_event_ret
-	(*bpf_perf_event_print_t)(struct perf_event_header *hdr,
-				  void *private_data);
-LIBBPF_DEPRECATED_SINCE(0, 8, "use perf_buffer__poll() or  perf_buffer__consume() instead")
-LIBBPF_API enum bpf_perf_event_ret
-bpf_perf_event_read_simple(void *mmap_mem, size_t mmap_size, size_t page_size,
-			   void **copy_mem, size_t *copy_size,
-			   bpf_perf_event_print_t fn, void *private_data);
-
 struct bpf_prog_linfo;
 struct bpf_prog_info;
 
diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
index 92df305795a2..88c622b784d9 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -46,7 +46,6 @@ LIBBPF_0.0.1 {
 		bpf_object__unload;
 		bpf_object__unpin_maps;
 		bpf_object__unpin_programs;
-		bpf_perf_event_read_simple;
 		bpf_prog_attach;
 		bpf_prog_detach;
 		bpf_prog_detach2;
@@ -144,8 +143,6 @@ LIBBPF_0.0.4 {
 		btf__parse_elf;
 		libbpf_num_possible_cpus;
 		perf_buffer__free;
-		perf_buffer__new;
-		perf_buffer__new_raw;
 		perf_buffer__poll;
 } LIBBPF_0.0.3;
 
@@ -369,9 +366,7 @@ LIBBPF_0.6.0 {
 		libbpf_minor_version;
 		libbpf_version_string;
 		perf_buffer__new;
-		perf_buffer__new_deprecated;
 		perf_buffer__new_raw;
-		perf_buffer__new_raw_deprecated;
 } LIBBPF_0.5.0;
 
 LIBBPF_0.7.0 {
-- 
2.30.2

