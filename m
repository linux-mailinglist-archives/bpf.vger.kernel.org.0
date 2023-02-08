Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A106A68F930
	for <lists+bpf@lfdr.de>; Wed,  8 Feb 2023 21:57:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231434AbjBHU5d (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 8 Feb 2023 15:57:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232310AbjBHU5X (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 8 Feb 2023 15:57:23 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9BF846D53
        for <bpf@vger.kernel.org>; Wed,  8 Feb 2023 12:57:16 -0800 (PST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 318KLbYE031107;
        Wed, 8 Feb 2023 20:57:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=9/ssolxQmTFPqO/3UNEynIV9kEEr8KE6tlYLV/4x8YE=;
 b=pmmEJ3mN2A8NdfSZAguokChMrh8Yk6qL21YGp70dVw2NSLNR01R5Sj3iq6acZcEOpbcX
 8SliUNL5KzBYpWVSl1vIaoYYM15KiqyzT4fCgQQ9ADwJ7RcTFkrZ0NEWAAuPJ6/QytCw
 QSkpdA3wU1G0SpFmVi/vSUjMWikqqSMrEpwCjWRV9ieY97oLTwsC/Z9PxB7a6epnzYxU
 Qeu09KbRjXho5X/7GRrxXrunXkC7OKkcM/cToA/rHNbHiTxLce25ASoORgO+H9c+rZlT
 QqX4L2ZCGiXnrJ0DMicv2QyQSO0opAaNLYX2lEulZQJKOnFRK7LJR3JbioEOY7sUz++c jg== 
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nmjq3rr3s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Feb 2023 20:57:02 +0000
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 318KrUdM016244;
        Wed, 8 Feb 2023 20:57:00 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
        by ppma04fra.de.ibm.com (PPS) with ESMTPS id 3nhf06usug-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Feb 2023 20:57:00 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
        by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 318KuumQ47841538
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 8 Feb 2023 20:56:56 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7216A20043;
        Wed,  8 Feb 2023 20:56:56 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E71F420040;
        Wed,  8 Feb 2023 20:56:55 +0000 (GMT)
Received: from heavy.ibmuc.com (unknown [9.179.24.149])
        by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Wed,  8 Feb 2023 20:56:55 +0000 (GMT)
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH bpf-next 8/9] libbpf: Add MSan annotations
Date:   Wed,  8 Feb 2023 21:56:41 +0100
Message-Id: <20230208205642.270567-9-iii@linux.ibm.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230208205642.270567-1-iii@linux.ibm.com>
References: <20230208205642.270567-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: HcAOcaDrqI6OoQMGjF0OrOtoM7GUf5NM
X-Proofpoint-ORIG-GUID: HcAOcaDrqI6OoQMGjF0OrOtoM7GUf5NM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-08_09,2023-02-08_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 impostorscore=0
 priorityscore=1501 phishscore=0 suspectscore=0 bulkscore=0
 lowpriorityscore=0 spamscore=0 mlxlogscore=533 malwarescore=0
 clxscore=1015 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302080175
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

MSan runs into a few false positives in libbpf. They all come from the
fact that MSan does not know anything about the bpf syscall,
particularly, what it writes to.

Add libbpf_mark_defined() function to mark memory modified by the bpf
syscall. Use the abstract name (it could be e.g.
libbpf_msan_unpoison()), because it can be used for valgrind in the
future as well.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 tools/lib/bpf/bpf.c             | 70 +++++++++++++++++++++++++++++++--
 tools/lib/bpf/btf.c             |  1 +
 tools/lib/bpf/libbpf.c          |  1 +
 tools/lib/bpf/libbpf_internal.h | 14 +++++++
 4 files changed, 82 insertions(+), 4 deletions(-)

diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
index 9aff98f42a3d..12fdc4ce1780 100644
--- a/tools/lib/bpf/bpf.c
+++ b/tools/lib/bpf/bpf.c
@@ -92,6 +92,10 @@ int sys_bpf_prog_load(union bpf_attr *attr, unsigned int size, int attempts)
 		fd = sys_bpf_fd(BPF_PROG_LOAD, attr, size);
 	} while (fd < 0 && errno == EAGAIN && --attempts > 0);
 
+	if (attr->log_buf)
+		libbpf_mark_defined((void *)(unsigned long)attr->log_buf,
+				    attr->log_size);
+
 	return fd;
 }
 
@@ -395,6 +399,33 @@ int bpf_map_update_elem(int fd, const void *key, const void *value,
 	return libbpf_err_errno(ret);
 }
 
+static void mark_map_value_defined(int fd, void *value)
+{
+#ifdef HAVE_LIBBPF_MARK_DEFINED
+	struct bpf_map_info info;
+	size_t size = 0;
+	__u32 info_len;
+	int num_cpus;
+	int err;
+
+	info_len = sizeof(info);
+	err = bpf_obj_get_info_by_fd(fd, &info, &info_len);
+	if (!err) {
+		size = info.value_size;
+		if (info.type == BPF_MAP_TYPE_PERCPU_ARRAY ||
+		    info.type == BPF_MAP_TYPE_PERCPU_HASH ||
+		    info.type == BPF_MAP_TYPE_LRU_PERCPU_HASH ||
+		    info.type == BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE) {
+			num_cpus = libbpf_num_possible_cpus();
+			if (num_cpus > 0)
+				size *= num_cpus;
+		}
+	}
+	if (size)
+		libbpf_mark_defined(value, size);
+#endif
+}
+
 int bpf_map_lookup_elem(int fd, const void *key, void *value)
 {
 	const size_t attr_sz = offsetofend(union bpf_attr, flags);
@@ -407,6 +438,8 @@ int bpf_map_lookup_elem(int fd, const void *key, void *value)
 	attr.value = ptr_to_u64(value);
 
 	ret = sys_bpf(BPF_MAP_LOOKUP_ELEM, &attr, attr_sz);
+	if (!ret)
+		mark_map_value_defined(fd, value);
 	return libbpf_err_errno(ret);
 }
 
@@ -423,6 +456,8 @@ int bpf_map_lookup_elem_flags(int fd, const void *key, void *value, __u64 flags)
 	attr.flags = flags;
 
 	ret = sys_bpf(BPF_MAP_LOOKUP_ELEM, &attr, attr_sz);
+	if (!ret)
+		mark_map_value_defined(fd, value);
 	return libbpf_err_errno(ret);
 }
 
@@ -438,6 +473,8 @@ int bpf_map_lookup_and_delete_elem(int fd, const void *key, void *value)
 	attr.value = ptr_to_u64(value);
 
 	ret = sys_bpf(BPF_MAP_LOOKUP_AND_DELETE_ELEM, &attr, attr_sz);
+	if (!ret)
+		mark_map_value_defined(fd, value);
 	return libbpf_err_errno(ret);
 }
 
@@ -454,6 +491,8 @@ int bpf_map_lookup_and_delete_elem_flags(int fd, const void *key, void *value, _
 	attr.flags = flags;
 
 	ret = sys_bpf(BPF_MAP_LOOKUP_AND_DELETE_ELEM, &attr, attr_sz);
+	if (!ret)
+		mark_map_value_defined(fd, value);
 	return libbpf_err_errno(ret);
 }
 
@@ -823,10 +862,12 @@ int bpf_prog_query_opts(int target_fd,
 {
 	const size_t attr_sz = offsetofend(union bpf_attr, query);
 	union bpf_attr attr;
+	__u32 *prog_ids;
 	int ret;
 
 	if (!OPTS_VALID(opts, bpf_prog_query_opts))
 		return libbpf_err(-EINVAL);
+	prog_ids = OPTS_GET(opts, prog_ids, NULL);
 
 	memset(&attr, 0, attr_sz);
 
@@ -834,11 +875,15 @@ int bpf_prog_query_opts(int target_fd,
 	attr.query.attach_type	= type;
 	attr.query.query_flags	= OPTS_GET(opts, query_flags, 0);
 	attr.query.prog_cnt	= OPTS_GET(opts, prog_cnt, 0);
-	attr.query.prog_ids	= ptr_to_u64(OPTS_GET(opts, prog_ids, NULL));
+	attr.query.prog_ids	= ptr_to_u64(prog_ids);
 	attr.query.prog_attach_flags = ptr_to_u64(OPTS_GET(opts, prog_attach_flags, NULL));
 
 	ret = sys_bpf(BPF_PROG_QUERY, &attr, attr_sz);
 
+	if (!ret && prog_ids)
+		libbpf_mark_defined(prog_ids,
+				    attr.query.prog_cnt * sizeof(*prog_ids));
+
 	OPTS_SET(opts, attach_flags, attr.query.attach_flags);
 	OPTS_SET(opts, prog_cnt, attr.query.prog_cnt);
 
@@ -868,10 +913,14 @@ int bpf_prog_test_run_opts(int prog_fd, struct bpf_test_run_opts *opts)
 {
 	const size_t attr_sz = offsetofend(union bpf_attr, test);
 	union bpf_attr attr;
+	void *data_out;
+	void *ctx_out;
 	int ret;
 
 	if (!OPTS_VALID(opts, bpf_test_run_opts))
 		return libbpf_err(-EINVAL);
+	data_out = OPTS_GET(opts, data_out, NULL);
+	ctx_out = OPTS_GET(opts, ctx_out, NULL);
 
 	memset(&attr, 0, attr_sz);
 	attr.test.prog_fd = prog_fd;
@@ -885,12 +934,19 @@ int bpf_prog_test_run_opts(int prog_fd, struct bpf_test_run_opts *opts)
 	attr.test.data_size_in = OPTS_GET(opts, data_size_in, 0);
 	attr.test.data_size_out = OPTS_GET(opts, data_size_out, 0);
 	attr.test.ctx_in = ptr_to_u64(OPTS_GET(opts, ctx_in, NULL));
-	attr.test.ctx_out = ptr_to_u64(OPTS_GET(opts, ctx_out, NULL));
+	attr.test.ctx_out = ptr_to_u64(ctx_out);
 	attr.test.data_in = ptr_to_u64(OPTS_GET(opts, data_in, NULL));
-	attr.test.data_out = ptr_to_u64(OPTS_GET(opts, data_out, NULL));
+	attr.test.data_out = ptr_to_u64(data_out);
 
 	ret = sys_bpf(BPF_PROG_TEST_RUN, &attr, attr_sz);
 
+	if (!ret) {
+		if (data_out)
+			libbpf_mark_defined(data_out, attr.test.data_size_out);
+		if (ctx_out)
+			libbpf_mark_defined(ctx_out, attr.test.ctx_size_out);
+	}
+
 	OPTS_SET(opts, data_size_out, attr.test.data_size_out);
 	OPTS_SET(opts, ctx_size_out, attr.test.ctx_size_out);
 	OPTS_SET(opts, duration, attr.test.duration);
@@ -1039,8 +1095,10 @@ int bpf_obj_get_info_by_fd(int bpf_fd, void *info, __u32 *info_len)
 	attr.info.info = ptr_to_u64(info);
 
 	err = sys_bpf(BPF_OBJ_GET_INFO_BY_FD, &attr, attr_sz);
-	if (!err)
+	if (!err) {
 		*info_len = attr.info.info_len;
+		libbpf_mark_defined(info, attr.info.info_len);
+	}
 	return libbpf_err_errno(err);
 }
 
@@ -1103,6 +1161,8 @@ int bpf_btf_load(const void *btf_data, size_t btf_size, const struct bpf_btf_loa
 		attr.btf_log_level = 1;
 		fd = sys_bpf_fd(BPF_BTF_LOAD, &attr, attr_sz);
 	}
+	if (log_buf)
+		libbpf_mark_defined(log_buf, attr.btf_log_size);
 	return libbpf_err_errno(fd);
 }
 
@@ -1122,6 +1182,8 @@ int bpf_task_fd_query(int pid, int fd, __u32 flags, char *buf, __u32 *buf_len,
 	attr.task_fd_query.buf_len = *buf_len;
 
 	err = sys_bpf(BPF_TASK_FD_QUERY, &attr, attr_sz);
+	if (!err && buf)
+		libbpf_mark_defined(buf, attr.task_fd_query.buf_len + 1);
 
 	*buf_len = attr.task_fd_query.buf_len;
 	*prog_id = attr.task_fd_query.prog_id;
diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
index 64841117fbb2..24a957604a97 100644
--- a/tools/lib/bpf/btf.c
+++ b/tools/lib/bpf/btf.c
@@ -1388,6 +1388,7 @@ struct btf *btf_get_from_fd(int btf_fd, struct btf *base_btf)
 		goto exit_free;
 	}
 
+	libbpf_mark_defined(ptr, btf_info.btf_size);
 	btf = btf_new(ptr, btf_info.btf_size, base_btf);
 
 exit_free:
diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 4191a78b2815..3e32ae5f0cce 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -5443,6 +5443,7 @@ static int load_module_btfs(struct bpf_object *obj)
 			pr_warn("failed to get BTF object #%d info: %d\n", id, err);
 			goto err_out;
 		}
+		libbpf_mark_defined(name, info.name_len + 1);
 
 		/* ignore non-module BTFs */
 		if (!info.kernel_btf || strcmp(name, "vmlinux") == 0) {
diff --git a/tools/lib/bpf/libbpf_internal.h b/tools/lib/bpf/libbpf_internal.h
index fbaf68335394..4e4622f66fdf 100644
--- a/tools/lib/bpf/libbpf_internal.h
+++ b/tools/lib/bpf/libbpf_internal.h
@@ -577,4 +577,18 @@ static inline bool is_pow_of_2(size_t x)
 #define PROG_LOAD_ATTEMPTS 5
 int sys_bpf_prog_load(union bpf_attr *attr, unsigned int size, int attempts);
 
+#if defined(__has_feature)
+#if __has_feature(memory_sanitizer)
+#define LIBBPF_MSAN
+#endif
+#endif
+
+#ifdef LIBBPF_MSAN
+#define HAVE_LIBBPF_MARK_DEFINED
+#include <sanitizer/msan_interface.h>
+#define libbpf_mark_defined __msan_unpoison
+#else
+static inline void libbpf_mark_defined(void *s, size_t n) {}
+#endif
+
 #endif /* __LIBBPF_LIBBPF_INTERNAL_H */
-- 
2.39.1

