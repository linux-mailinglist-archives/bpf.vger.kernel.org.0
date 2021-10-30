Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C2B5440784
	for <lists+bpf@lfdr.de>; Sat, 30 Oct 2021 06:59:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231253AbhJ3FCW convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Sat, 30 Oct 2021 01:02:22 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:10674 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S230002AbhJ3FCV (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sat, 30 Oct 2021 01:02:21 -0400
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.1.2/8.16.1.2) with SMTP id 19U4rXYl007013
        for <bpf@vger.kernel.org>; Fri, 29 Oct 2021 21:59:51 -0700
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0001303.ppops.net with ESMTP id 3c0yc9r0yj-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 29 Oct 2021 21:59:51 -0700
Received: from intmgw001.27.prn2.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Fri, 29 Oct 2021 21:59:50 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 7B1657830513; Fri, 29 Oct 2021 21:59:47 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>,
        Hengqi Chen <hengqi.chen@gmail.com>
Subject: [PATCH bpf-next 02/14] libbpf: add bpf() syscall wrapper into public API
Date:   Fri, 29 Oct 2021 21:59:29 -0700
Message-ID: <20211030045941.3514948-3-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211030045941.3514948-1-andrii@kernel.org>
References: <20211030045941.3514948-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-ORIG-GUID: 31kLJ6NWj5hs-nOicv081bJhzlL-CLrz
X-Proofpoint-GUID: 31kLJ6NWj5hs-nOicv081bJhzlL-CLrz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-30_01,2021-10-29_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 lowpriorityscore=0 suspectscore=0 impostorscore=0 clxscore=1015
 adultscore=0 bulkscore=0 malwarescore=0 spamscore=0 mlxlogscore=637
 phishscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2110300025
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Move internal sys_bpf() helper into bpf.h and expose as public API.
__NR_bpf definition logic is also moved. Renamed sys_bpf() into bpf() to
follow libbpf naming conventions. Adapt internal uses accordingly.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/bpf.c | 76 ++++++++++++++-------------------------------
 tools/lib/bpf/bpf.h | 30 ++++++++++++++++++
 2 files changed, 54 insertions(+), 52 deletions(-)

diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
index c09cbb868c9f..4b4fd2dae3bf 100644
--- a/tools/lib/bpf/bpf.c
+++ b/tools/lib/bpf/bpf.c
@@ -32,45 +32,17 @@
 #include "libbpf.h"
 #include "libbpf_internal.h"
 
-/*
- * When building perf, unistd.h is overridden. __NR_bpf is
- * required to be defined explicitly.
- */
-#ifndef __NR_bpf
-# if defined(__i386__)
-#  define __NR_bpf 357
-# elif defined(__x86_64__)
-#  define __NR_bpf 321
-# elif defined(__aarch64__)
-#  define __NR_bpf 280
-# elif defined(__sparc__)
-#  define __NR_bpf 349
-# elif defined(__s390__)
-#  define __NR_bpf 351
-# elif defined(__arc__)
-#  define __NR_bpf 280
-# else
-#  error __NR_bpf not defined. libbpf does not support your arch.
-# endif
-#endif
-
 static inline __u64 ptr_to_u64(const void *ptr)
 {
 	return (__u64) (unsigned long) ptr;
 }
 
-static inline int sys_bpf(enum bpf_cmd cmd, union bpf_attr *attr,
-			  unsigned int size)
-{
-	return syscall(__NR_bpf, cmd, attr, size);
-}
-
 static inline int sys_bpf_fd(enum bpf_cmd cmd, union bpf_attr *attr,
 			     unsigned int size)
 {
 	int fd;
 
-	fd = sys_bpf(cmd, attr, size);
+	fd = bpf(cmd, attr, size);
 	return ensure_good_fd(fd);
 }
 
@@ -465,7 +437,7 @@ int bpf_map_update_elem(int fd, const void *key, const void *value,
 	attr.value = ptr_to_u64(value);
 	attr.flags = flags;
 
-	ret = sys_bpf(BPF_MAP_UPDATE_ELEM, &attr, sizeof(attr));
+	ret = bpf(BPF_MAP_UPDATE_ELEM, &attr, sizeof(attr));
 	return libbpf_err_errno(ret);
 }
 
@@ -479,7 +451,7 @@ int bpf_map_lookup_elem(int fd, const void *key, void *value)
 	attr.key = ptr_to_u64(key);
 	attr.value = ptr_to_u64(value);
 
-	ret = sys_bpf(BPF_MAP_LOOKUP_ELEM, &attr, sizeof(attr));
+	ret = bpf(BPF_MAP_LOOKUP_ELEM, &attr, sizeof(attr));
 	return libbpf_err_errno(ret);
 }
 
@@ -494,7 +466,7 @@ int bpf_map_lookup_elem_flags(int fd, const void *key, void *value, __u64 flags)
 	attr.value = ptr_to_u64(value);
 	attr.flags = flags;
 
-	ret = sys_bpf(BPF_MAP_LOOKUP_ELEM, &attr, sizeof(attr));
+	ret = bpf(BPF_MAP_LOOKUP_ELEM, &attr, sizeof(attr));
 	return libbpf_err_errno(ret);
 }
 
@@ -508,7 +480,7 @@ int bpf_map_lookup_and_delete_elem(int fd, const void *key, void *value)
 	attr.key = ptr_to_u64(key);
 	attr.value = ptr_to_u64(value);
 
-	ret = sys_bpf(BPF_MAP_LOOKUP_AND_DELETE_ELEM, &attr, sizeof(attr));
+	ret = bpf(BPF_MAP_LOOKUP_AND_DELETE_ELEM, &attr, sizeof(attr));
 	return libbpf_err_errno(ret);
 }
 
@@ -522,7 +494,7 @@ int bpf_map_lookup_and_delete_elem_flags(int fd, const void *key, void *value, _
 	attr.value = ptr_to_u64(value);
 	attr.flags = flags;
 
-	return sys_bpf(BPF_MAP_LOOKUP_AND_DELETE_ELEM, &attr, sizeof(attr));
+	return bpf(BPF_MAP_LOOKUP_AND_DELETE_ELEM, &attr, sizeof(attr));
 }
 
 int bpf_map_delete_elem(int fd, const void *key)
@@ -534,7 +506,7 @@ int bpf_map_delete_elem(int fd, const void *key)
 	attr.map_fd = fd;
 	attr.key = ptr_to_u64(key);
 
-	ret = sys_bpf(BPF_MAP_DELETE_ELEM, &attr, sizeof(attr));
+	ret = bpf(BPF_MAP_DELETE_ELEM, &attr, sizeof(attr));
 	return libbpf_err_errno(ret);
 }
 
@@ -548,7 +520,7 @@ int bpf_map_get_next_key(int fd, const void *key, void *next_key)
 	attr.key = ptr_to_u64(key);
 	attr.next_key = ptr_to_u64(next_key);
 
-	ret = sys_bpf(BPF_MAP_GET_NEXT_KEY, &attr, sizeof(attr));
+	ret = bpf(BPF_MAP_GET_NEXT_KEY, &attr, sizeof(attr));
 	return libbpf_err_errno(ret);
 }
 
@@ -560,7 +532,7 @@ int bpf_map_freeze(int fd)
 	memset(&attr, 0, sizeof(attr));
 	attr.map_fd = fd;
 
-	ret = sys_bpf(BPF_MAP_FREEZE, &attr, sizeof(attr));
+	ret = bpf(BPF_MAP_FREEZE, &attr, sizeof(attr));
 	return libbpf_err_errno(ret);
 }
 
@@ -585,7 +557,7 @@ static int bpf_map_batch_common(int cmd, int fd, void  *in_batch,
 	attr.batch.elem_flags  = OPTS_GET(opts, elem_flags, 0);
 	attr.batch.flags = OPTS_GET(opts, flags, 0);
 
-	ret = sys_bpf(cmd, &attr, sizeof(attr));
+	ret = bpf(cmd, &attr, sizeof(attr));
 	*count = attr.batch.count;
 
 	return libbpf_err_errno(ret);
@@ -631,7 +603,7 @@ int bpf_obj_pin(int fd, const char *pathname)
 	attr.pathname = ptr_to_u64((void *)pathname);
 	attr.bpf_fd = fd;
 
-	ret = sys_bpf(BPF_OBJ_PIN, &attr, sizeof(attr));
+	ret = bpf(BPF_OBJ_PIN, &attr, sizeof(attr));
 	return libbpf_err_errno(ret);
 }
 
@@ -674,7 +646,7 @@ int bpf_prog_attach_xattr(int prog_fd, int target_fd,
 	attr.attach_flags  = OPTS_GET(opts, flags, 0);
 	attr.replace_bpf_fd = OPTS_GET(opts, replace_prog_fd, 0);
 
-	ret = sys_bpf(BPF_PROG_ATTACH, &attr, sizeof(attr));
+	ret = bpf(BPF_PROG_ATTACH, &attr, sizeof(attr));
 	return libbpf_err_errno(ret);
 }
 
@@ -687,7 +659,7 @@ int bpf_prog_detach(int target_fd, enum bpf_attach_type type)
 	attr.target_fd	 = target_fd;
 	attr.attach_type = type;
 
-	ret = sys_bpf(BPF_PROG_DETACH, &attr, sizeof(attr));
+	ret = bpf(BPF_PROG_DETACH, &attr, sizeof(attr));
 	return libbpf_err_errno(ret);
 }
 
@@ -701,7 +673,7 @@ int bpf_prog_detach2(int prog_fd, int target_fd, enum bpf_attach_type type)
 	attr.attach_bpf_fd = prog_fd;
 	attr.attach_type = type;
 
-	ret = sys_bpf(BPF_PROG_DETACH, &attr, sizeof(attr));
+	ret = bpf(BPF_PROG_DETACH, &attr, sizeof(attr));
 	return libbpf_err_errno(ret);
 }
 
@@ -766,7 +738,7 @@ int bpf_link_detach(int link_fd)
 	memset(&attr, 0, sizeof(attr));
 	attr.link_detach.link_fd = link_fd;
 
-	ret = sys_bpf(BPF_LINK_DETACH, &attr, sizeof(attr));
+	ret = bpf(BPF_LINK_DETACH, &attr, sizeof(attr));
 	return libbpf_err_errno(ret);
 }
 
@@ -785,7 +757,7 @@ int bpf_link_update(int link_fd, int new_prog_fd,
 	attr.link_update.flags = OPTS_GET(opts, flags, 0);
 	attr.link_update.old_prog_fd = OPTS_GET(opts, old_prog_fd, 0);
 
-	ret = sys_bpf(BPF_LINK_UPDATE, &attr, sizeof(attr));
+	ret = bpf(BPF_LINK_UPDATE, &attr, sizeof(attr));
 	return libbpf_err_errno(ret);
 }
 
@@ -814,7 +786,7 @@ int bpf_prog_query(int target_fd, enum bpf_attach_type type, __u32 query_flags,
 	attr.query.prog_cnt	= *prog_cnt;
 	attr.query.prog_ids	= ptr_to_u64(prog_ids);
 
-	ret = sys_bpf(BPF_PROG_QUERY, &attr, sizeof(attr));
+	ret = bpf(BPF_PROG_QUERY, &attr, sizeof(attr));
 
 	if (attach_flags)
 		*attach_flags = attr.query.attach_flags;
@@ -837,7 +809,7 @@ int bpf_prog_test_run(int prog_fd, int repeat, void *data, __u32 size,
 	attr.test.data_size_in = size;
 	attr.test.repeat = repeat;
 
-	ret = sys_bpf(BPF_PROG_TEST_RUN, &attr, sizeof(attr));
+	ret = bpf(BPF_PROG_TEST_RUN, &attr, sizeof(attr));
 
 	if (size_out)
 		*size_out = attr.test.data_size_out;
@@ -869,7 +841,7 @@ int bpf_prog_test_run_xattr(struct bpf_prog_test_run_attr *test_attr)
 	attr.test.ctx_size_out = test_attr->ctx_size_out;
 	attr.test.repeat = test_attr->repeat;
 
-	ret = sys_bpf(BPF_PROG_TEST_RUN, &attr, sizeof(attr));
+	ret = bpf(BPF_PROG_TEST_RUN, &attr, sizeof(attr));
 
 	test_attr->data_size_out = attr.test.data_size_out;
 	test_attr->ctx_size_out = attr.test.ctx_size_out;
@@ -902,7 +874,7 @@ int bpf_prog_test_run_opts(int prog_fd, struct bpf_test_run_opts *opts)
 	attr.test.data_in = ptr_to_u64(OPTS_GET(opts, data_in, NULL));
 	attr.test.data_out = ptr_to_u64(OPTS_GET(opts, data_out, NULL));
 
-	ret = sys_bpf(BPF_PROG_TEST_RUN, &attr, sizeof(attr));
+	ret = bpf(BPF_PROG_TEST_RUN, &attr, sizeof(attr));
 
 	OPTS_SET(opts, data_size_out, attr.test.data_size_out);
 	OPTS_SET(opts, ctx_size_out, attr.test.ctx_size_out);
@@ -920,7 +892,7 @@ static int bpf_obj_get_next_id(__u32 start_id, __u32 *next_id, int cmd)
 	memset(&attr, 0, sizeof(attr));
 	attr.start_id = start_id;
 
-	err = sys_bpf(cmd, &attr, sizeof(attr));
+	err = bpf(cmd, &attr, sizeof(attr));
 	if (!err)
 		*next_id = attr.next_id;
 
@@ -1005,7 +977,7 @@ int bpf_obj_get_info_by_fd(int bpf_fd, void *info, __u32 *info_len)
 	attr.info.info_len = *info_len;
 	attr.info.info = ptr_to_u64(info);
 
-	err = sys_bpf(BPF_OBJ_GET_INFO_BY_FD, &attr, sizeof(attr));
+	err = bpf(BPF_OBJ_GET_INFO_BY_FD, &attr, sizeof(attr));
 
 	if (!err)
 		*info_len = attr.info.info_len;
@@ -1065,7 +1037,7 @@ int bpf_task_fd_query(int pid, int fd, __u32 flags, char *buf, __u32 *buf_len,
 	attr.task_fd_query.buf = ptr_to_u64(buf);
 	attr.task_fd_query.buf_len = *buf_len;
 
-	err = sys_bpf(BPF_TASK_FD_QUERY, &attr, sizeof(attr));
+	err = bpf(BPF_TASK_FD_QUERY, &attr, sizeof(attr));
 
 	*buf_len = attr.task_fd_query.buf_len;
 	*prog_id = attr.task_fd_query.prog_id;
@@ -1102,6 +1074,6 @@ int bpf_prog_bind_map(int prog_fd, int map_fd,
 	attr.prog_bind_map.map_fd = map_fd;
 	attr.prog_bind_map.flags = OPTS_GET(opts, flags, 0);
 
-	ret = sys_bpf(BPF_PROG_BIND_MAP, &attr, sizeof(attr));
+	ret = bpf(BPF_PROG_BIND_MAP, &attr, sizeof(attr));
 	return libbpf_err_errno(ret);
 }
diff --git a/tools/lib/bpf/bpf.h b/tools/lib/bpf/bpf.h
index 6fffb3cdf39b..6ef9e1e464c0 100644
--- a/tools/lib/bpf/bpf.h
+++ b/tools/lib/bpf/bpf.h
@@ -27,6 +27,10 @@
 #include <stdbool.h>
 #include <stddef.h>
 #include <stdint.h>
+#include <unistd.h>
+#include <asm/unistd.h>
+#include <sys/syscall.h>
+#include <sys/types.h>
 
 #include "libbpf_common.h"
 
@@ -34,6 +38,32 @@
 extern "C" {
 #endif
 
+/*
+ * Kernel headers might be outdated, so define __NR_bpf explicitly, if necessary.
+ */
+#ifndef __NR_bpf
+# if defined(__i386__)
+#  define __NR_bpf 357
+# elif defined(__x86_64__)
+#  define __NR_bpf 321
+# elif defined(__aarch64__)
+#  define __NR_bpf 280
+# elif defined(__sparc__)
+#  define __NR_bpf 349
+# elif defined(__s390__)
+#  define __NR_bpf 351
+# elif defined(__arc__)
+#  define __NR_bpf 280
+# else
+#  error __NR_bpf not defined. libbpf does not support your arch.
+# endif
+#endif
+
+static inline long bpf(enum bpf_cmd cmd, union bpf_attr *attr, unsigned int size)
+{
+	return syscall(__NR_bpf, cmd, attr, size);
+}
+
 struct bpf_create_map_attr {
 	const char *name;
 	enum bpf_map_type map_type;
-- 
2.30.2

