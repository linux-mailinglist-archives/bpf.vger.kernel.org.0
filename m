Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B7863E8586
	for <lists+bpf@lfdr.de>; Tue, 10 Aug 2021 23:37:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234353AbhHJVh2 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Tue, 10 Aug 2021 17:37:28 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:63812 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234877AbhHJVh1 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 10 Aug 2021 17:37:27 -0400
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17ALWp3v031886
        for <bpf@vger.kernel.org>; Tue, 10 Aug 2021 14:37:04 -0700
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3aby7hs35u-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 10 Aug 2021 14:37:04 -0700
Received: from intmgw001.37.frc1.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:11d::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 10 Aug 2021 14:37:02 -0700
Received: by devbig012.ftw2.facebook.com (Postfix, from userid 137359)
        id 6B7A83D405A0; Tue, 10 Aug 2021 14:36:59 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH v4 bpf-next 10/14] libbpf: add bpf_cookie support to bpf_link_create() API
Date:   Tue, 10 Aug 2021 14:36:30 -0700
Message-ID: <20210810213634.272111-11-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210810213634.272111-1-andrii@kernel.org>
References: <20210810213634.272111-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-GUID: TL236MF6O6q_Uyp78WEsXa5EGksxRJXf
X-Proofpoint-ORIG-GUID: TL236MF6O6q_Uyp78WEsXa5EGksxRJXf
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-10_08:2021-08-10,2021-08-10 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 impostorscore=0
 suspectscore=0 mlxscore=0 clxscore=1015 bulkscore=0 adultscore=0
 phishscore=0 priorityscore=1501 malwarescore=0 mlxlogscore=999 spamscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108100142
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add ability to specify bpf_cookie value when creating BPF perf link with
bpf_link_create() low-level API.

Given BPF_LINK_CREATE command is growing and keeps getting new fields that are
specific to the type of BPF_LINK, extend libbpf side of bpf_link_create() API
and corresponding OPTS struct to accomodate such changes. Add extra checks to
prevent using incompatible/unexpected combinations of fields.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/bpf.c             | 32 +++++++++++++++++++++++++-------
 tools/lib/bpf/bpf.h             |  8 +++++++-
 tools/lib/bpf/libbpf_internal.h | 32 ++++++++++++++++++++++----------
 3 files changed, 54 insertions(+), 18 deletions(-)

diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
index 86dcac44f32f..2401fad090c5 100644
--- a/tools/lib/bpf/bpf.c
+++ b/tools/lib/bpf/bpf.c
@@ -684,8 +684,13 @@ int bpf_link_create(int prog_fd, int target_fd,
 	iter_info_len = OPTS_GET(opts, iter_info_len, 0);
 	target_btf_id = OPTS_GET(opts, target_btf_id, 0);
 
-	if (iter_info_len && target_btf_id)
-		return libbpf_err(-EINVAL);
+	/* validate we don't have unexpected combinations of non-zero fields */
+	if (iter_info_len || target_btf_id) {
+		if (iter_info_len && target_btf_id)
+			return libbpf_err(-EINVAL);
+		if (!OPTS_ZEROED(opts, target_btf_id))
+			return libbpf_err(-EINVAL);
+	}
 
 	memset(&attr, 0, sizeof(attr));
 	attr.link_create.prog_fd = prog_fd;
@@ -693,14 +698,27 @@ int bpf_link_create(int prog_fd, int target_fd,
 	attr.link_create.attach_type = attach_type;
 	attr.link_create.flags = OPTS_GET(opts, flags, 0);
 
-	if (iter_info_len) {
-		attr.link_create.iter_info =
-			ptr_to_u64(OPTS_GET(opts, iter_info, (void *)0));
-		attr.link_create.iter_info_len = iter_info_len;
-	} else if (target_btf_id) {
+	if (target_btf_id) {
 		attr.link_create.target_btf_id = target_btf_id;
+		goto proceed;
 	}
 
+	switch (attach_type) {
+	case BPF_TRACE_ITER:
+		attr.link_create.iter_info = ptr_to_u64(OPTS_GET(opts, iter_info, (void *)0));
+		attr.link_create.iter_info_len = iter_info_len;
+		break;
+	case BPF_PERF_EVENT:
+		attr.link_create.perf_event.bpf_cookie = OPTS_GET(opts, perf_event.bpf_cookie, 0);
+		if (!OPTS_ZEROED(opts, perf_event))
+			return libbpf_err(-EINVAL);
+		break;
+	default:
+		if (!OPTS_ZEROED(opts, flags))
+			return libbpf_err(-EINVAL);
+		break;
+	}
+proceed:
 	fd = sys_bpf(BPF_LINK_CREATE, &attr, sizeof(attr));
 	return libbpf_err_errno(fd);
 }
diff --git a/tools/lib/bpf/bpf.h b/tools/lib/bpf/bpf.h
index 4f758f8f50cd..6fffb3cdf39b 100644
--- a/tools/lib/bpf/bpf.h
+++ b/tools/lib/bpf/bpf.h
@@ -177,8 +177,14 @@ struct bpf_link_create_opts {
 	union bpf_iter_link_info *iter_info;
 	__u32 iter_info_len;
 	__u32 target_btf_id;
+	union {
+		struct {
+			__u64 bpf_cookie;
+		} perf_event;
+	};
+	size_t :0;
 };
-#define bpf_link_create_opts__last_field target_btf_id
+#define bpf_link_create_opts__last_field perf_event
 
 LIBBPF_API int bpf_link_create(int prog_fd, int target_fd,
 			       enum bpf_attach_type attach_type,
diff --git a/tools/lib/bpf/libbpf_internal.h b/tools/lib/bpf/libbpf_internal.h
index f7b691d5f9eb..533b0211f40a 100644
--- a/tools/lib/bpf/libbpf_internal.h
+++ b/tools/lib/bpf/libbpf_internal.h
@@ -196,6 +196,17 @@ void *libbpf_add_mem(void **data, size_t *cap_cnt, size_t elem_sz,
 		     size_t cur_cnt, size_t max_cnt, size_t add_cnt);
 int libbpf_ensure_mem(void **data, size_t *cap_cnt, size_t elem_sz, size_t need_cnt);
 
+static inline bool libbpf_is_mem_zeroed(const char *p, ssize_t len)
+{
+	while (len > 0) {
+		if (*p)
+			return false;
+		p++;
+		len--;
+	}
+	return true;
+}
+
 static inline bool libbpf_validate_opts(const char *opts,
 					size_t opts_sz, size_t user_sz,
 					const char *type_name)
@@ -204,16 +215,9 @@ static inline bool libbpf_validate_opts(const char *opts,
 		pr_warn("%s size (%zu) is too small\n", type_name, user_sz);
 		return false;
 	}
-	if (user_sz > opts_sz) {
-		size_t i;
-
-		for (i = opts_sz; i < user_sz; i++) {
-			if (opts[i]) {
-				pr_warn("%s has non-zero extra bytes\n",
-					type_name);
-				return false;
-			}
-		}
+	if (!libbpf_is_mem_zeroed(opts + opts_sz, (ssize_t)user_sz - opts_sz)) {
+		pr_warn("%s has non-zero extra bytes\n", type_name);
+		return false;
 	}
 	return true;
 }
@@ -233,6 +237,14 @@ static inline bool libbpf_validate_opts(const char *opts,
 			(opts)->field = value;	\
 	} while (0)
 
+#define OPTS_ZEROED(opts, last_nonzero_field)				      \
+({									      \
+	ssize_t __off = offsetofend(typeof(*(opts)), last_nonzero_field);     \
+	!(opts) || libbpf_is_mem_zeroed((const void *)opts + __off,	      \
+					(opts)->sz - __off);		      \
+})
+
+
 int parse_cpu_mask_str(const char *s, bool **mask, int *mask_sz);
 int parse_cpu_mask_file(const char *fcpu, bool **mask, int *mask_sz);
 int libbpf__load_raw_btf(const char *raw_types, size_t types_len,
-- 
2.30.2

