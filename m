Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 483B9697199
	for <lists+bpf@lfdr.de>; Wed, 15 Feb 2023 00:12:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232871AbjBNXM5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 14 Feb 2023 18:12:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232862AbjBNXM4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 14 Feb 2023 18:12:56 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D5E5A26F
        for <bpf@vger.kernel.org>; Tue, 14 Feb 2023 15:12:53 -0800 (PST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31EMplxu010452;
        Tue, 14 Feb 2023 23:12:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=hIZa3GdgiesmkkLViFk1lUVpEduzQoPEU8xith61XtM=;
 b=KKpVho+fps9AtzNFMHK2EFBws8AT8G+vr5+927WECPkid+QcnbcUa3uiVOSSiRo3ogm3
 14GalG16UvUOXFNgvSU7m7wi2JU2ZwHHL/GjQfIz2vqy0qHnW2E82+qh+SzmySZkNsif
 uqVSFcUj+9diaQBWk3V5w9o+4s+7wxPkaaTY8lcKfMrdrCMd5QzQn5nwCRxiThhjGwaV
 YP3xTprIrmT6YWXQ6BG/ihorGH4r74yOwUEvZ6AjJuhNt7cKAO0G9y4E/y7nsAw0bQRh
 GoN91U0qklBDF9icajxmFev//Ryo00JjamtW8zHgJNvKV6kXraUmQSzjP9hl50C5zPrh pA== 
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nrkferftm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Feb 2023 23:12:38 +0000
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 31E69hpN027597;
        Tue, 14 Feb 2023 23:12:36 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
        by ppma02fra.de.ibm.com (PPS) with ESMTPS id 3np2n6kefr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Feb 2023 23:12:36 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
        by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 31ENCWwo25035236
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Feb 2023 23:12:32 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 69EEA2004B;
        Tue, 14 Feb 2023 23:12:32 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D728220043;
        Tue, 14 Feb 2023 23:12:31 +0000 (GMT)
Received: from heavy.lan (unknown [9.171.53.135])
        by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Tue, 14 Feb 2023 23:12:31 +0000 (GMT)
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH bpf-next v3 7/8] libbpf: Add MSan annotations
Date:   Wed, 15 Feb 2023 00:12:20 +0100
Message-Id: <20230214231221.249277-8-iii@linux.ibm.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230214231221.249277-1-iii@linux.ibm.com>
References: <20230214231221.249277-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: SLTuCRVRdNNgWtnZI2tkwwJgaLQ0-ULV
X-Proofpoint-ORIG-GUID: SLTuCRVRdNNgWtnZI2tkwwJgaLQ0-ULV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-14_15,2023-02-14_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=865 spamscore=0
 malwarescore=0 suspectscore=0 priorityscore=1501 lowpriorityscore=0
 phishscore=0 bulkscore=0 impostorscore=0 clxscore=1015 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302140198
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

Add __libbpf_mark_mem_written() function to mark memory modified by the
bpf syscall, and a few convenience wrappers. Use the abstract name (it
could be e.g. libbpf_msan_unpoison()), because it can be used for
Valgrind in the future as well.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 tools/lib/bpf/bpf.c             | 161 ++++++++++++++++++++++++++++++--
 tools/lib/bpf/btf.c             |   1 +
 tools/lib/bpf/libbpf.c          |   1 +
 tools/lib/bpf/libbpf_internal.h |  38 ++++++++
 4 files changed, 194 insertions(+), 7 deletions(-)

diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
index b562019271fe..8440d38c781c 100644
--- a/tools/lib/bpf/bpf.c
+++ b/tools/lib/bpf/bpf.c
@@ -69,6 +69,11 @@ static inline __u64 ptr_to_u64(const void *ptr)
 	return (__u64) (unsigned long) ptr;
 }
 
+static inline void *u64_to_ptr(__u64 val)
+{
+	return (void *) (unsigned long) val;
+}
+
 static inline int sys_bpf(enum bpf_cmd cmd, union bpf_attr *attr,
 			  unsigned int size)
 {
@@ -92,6 +97,8 @@ int sys_bpf_prog_load(union bpf_attr *attr, unsigned int size, int attempts)
 		fd = sys_bpf_fd(BPF_PROG_LOAD, attr, size);
 	} while (fd < 0 && errno == EAGAIN && --attempts > 0);
 
+	libbpf_mark_mem_written(u64_to_ptr(attr->log_buf), attr->log_size);
+
 	return fd;
 }
 
@@ -395,6 +402,26 @@ int bpf_map_update_elem(int fd, const void *key, const void *value,
 	return libbpf_err_errno(ret);
 }
 
+/* Tell memory checkers that the given value of the given map is initialized. */
+static void libbpf_mark_map_value_written(int fd, void *value)
+{
+#ifdef HAVE_LIBBPF_MARK_MEM_WRITTEN
+	struct bpf_map_info info;
+	__u32 info_len;
+	size_t size;
+	int err;
+
+	info_len = sizeof(info);
+	err = bpf_map_get_info_by_fd(fd, &info, &info_len);
+	if (!err) {
+		size = info.value_size;
+		if (is_percpu_bpf_map_type(info.type))
+			size = roundup(size, 8) * libbpf_num_possible_cpus();
+		libbpf_mark_mem_written(value, size);
+	}
+#endif
+}
+
 int bpf_map_lookup_elem(int fd, const void *key, void *value)
 {
 	const size_t attr_sz = offsetofend(union bpf_attr, flags);
@@ -407,6 +434,8 @@ int bpf_map_lookup_elem(int fd, const void *key, void *value)
 	attr.value = ptr_to_u64(value);
 
 	ret = sys_bpf(BPF_MAP_LOOKUP_ELEM, &attr, attr_sz);
+	if (!ret)
+		libbpf_mark_map_value_written(fd, value);
 	return libbpf_err_errno(ret);
 }
 
@@ -423,6 +452,8 @@ int bpf_map_lookup_elem_flags(int fd, const void *key, void *value, __u64 flags)
 	attr.flags = flags;
 
 	ret = sys_bpf(BPF_MAP_LOOKUP_ELEM, &attr, attr_sz);
+	if (!ret)
+		libbpf_mark_map_value_written(fd, value);
 	return libbpf_err_errno(ret);
 }
 
@@ -438,6 +469,8 @@ int bpf_map_lookup_and_delete_elem(int fd, const void *key, void *value)
 	attr.value = ptr_to_u64(value);
 
 	ret = sys_bpf(BPF_MAP_LOOKUP_AND_DELETE_ELEM, &attr, attr_sz);
+	if (!ret)
+		libbpf_mark_map_value_written(fd, value);
 	return libbpf_err_errno(ret);
 }
 
@@ -454,6 +487,8 @@ int bpf_map_lookup_and_delete_elem_flags(int fd, const void *key, void *value, _
 	attr.flags = flags;
 
 	ret = sys_bpf(BPF_MAP_LOOKUP_AND_DELETE_ELEM, &attr, attr_sz);
+	if (!ret)
+		libbpf_mark_map_value_written(fd, value);
 	return libbpf_err_errno(ret);
 }
 
@@ -823,10 +858,12 @@ int bpf_prog_query_opts(int target_fd,
 {
 	const size_t attr_sz = offsetofend(union bpf_attr, query);
 	union bpf_attr attr;
+	__u32 *prog_ids;
 	int ret;
 
 	if (!OPTS_VALID(opts, bpf_prog_query_opts))
 		return libbpf_err(-EINVAL);
+	prog_ids = OPTS_GET(opts, prog_ids, NULL);
 
 	memset(&attr, 0, attr_sz);
 
@@ -834,11 +871,15 @@ int bpf_prog_query_opts(int target_fd,
 	attr.query.attach_type	= type;
 	attr.query.query_flags	= OPTS_GET(opts, query_flags, 0);
 	attr.query.prog_cnt	= OPTS_GET(opts, prog_cnt, 0);
-	attr.query.prog_ids	= ptr_to_u64(OPTS_GET(opts, prog_ids, NULL));
+	attr.query.prog_ids	= ptr_to_u64(prog_ids);
 	attr.query.prog_attach_flags = ptr_to_u64(OPTS_GET(opts, prog_attach_flags, NULL));
 
 	ret = sys_bpf(BPF_PROG_QUERY, &attr, attr_sz);
 
+	libbpf_mark_mem_written_if(prog_ids,
+				   attr.query.prog_cnt * sizeof(*prog_ids),
+				   !ret);
+
 	OPTS_SET(opts, attach_flags, attr.query.attach_flags);
 	OPTS_SET(opts, prog_cnt, attr.query.prog_cnt);
 
@@ -868,10 +909,14 @@ int bpf_prog_test_run_opts(int prog_fd, struct bpf_test_run_opts *opts)
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
@@ -885,12 +930,15 @@ int bpf_prog_test_run_opts(int prog_fd, struct bpf_test_run_opts *opts)
 	attr.test.data_size_in = OPTS_GET(opts, data_size_in, 0);
 	attr.test.data_size_out = OPTS_GET(opts, data_size_out, 0);
 	attr.test.ctx_in = ptr_to_u64(OPTS_GET(opts, ctx_in, NULL));
-	attr.test.ctx_out = ptr_to_u64(OPTS_GET(opts, ctx_out, NULL));
+	attr.test.ctx_out = ptr_to_u64(ctx_out);
 	attr.test.data_in = ptr_to_u64(OPTS_GET(opts, data_in, NULL));
-	attr.test.data_out = ptr_to_u64(OPTS_GET(opts, data_out, NULL));
+	attr.test.data_out = ptr_to_u64(data_out);
 
 	ret = sys_bpf(BPF_PROG_TEST_RUN, &attr, attr_sz);
 
+	libbpf_mark_mem_written_if(data_out, attr.test.data_size_out, !ret);
+	libbpf_mark_mem_written_if(ctx_out, attr.test.ctx_size_out, !ret);
+
 	OPTS_SET(opts, data_size_out, attr.test.data_size_out);
 	OPTS_SET(opts, ctx_size_out, attr.test.ctx_size_out);
 	OPTS_SET(opts, duration, attr.test.duration);
@@ -1039,15 +1087,100 @@ int bpf_obj_get_info_by_fd(int bpf_fd, void *info, __u32 *info_len)
 	attr.info.info = ptr_to_u64(info);
 
 	err = sys_bpf(BPF_OBJ_GET_INFO_BY_FD, &attr, attr_sz);
-	if (!err)
+	if (!err) {
 		*info_len = attr.info.info_len;
+		libbpf_mark_mem_written(info, attr.info.info_len);
+	}
 	return libbpf_err_errno(err);
 }
 
+/* Helper macros for telling memory checkers that an array pointed to by
+ * a struct bpf_{btf,link,map,prog}_info member is initialized. Before doing
+ * that, they make sure that kernel has provided the respective member.
+ */
+
+/* Handle arrays with a certain element size. */
+#define __MARK_INFO_ARRAY_WRITTEN(ptr, nr, elem_size) do {		       \
+	if (info_len >= offsetofend(typeof(*info), ptr) &&		       \
+	    info_len >= offsetofend(typeof(*info), nr) &&		       \
+	    info->ptr)							       \
+		libbpf_mark_mem_written(u64_to_ptr(info->ptr),		       \
+					info->nr * elem_size);		       \
+} while (0)
+
+/* Handle arrays with a certain element type. */
+#define MARK_INFO_ARRAY_WRITTEN(ptr, nr, type)				       \
+	__MARK_INFO_ARRAY_WRITTEN(ptr, nr, sizeof(type))
+
+/* Handle arrays with element size defined by a struct member. */
+#define MARK_INFO_REC_ARRAY_WRITTEN(ptr, nr, rec_size) do {		       \
+	if (info_len >= offsetofend(typeof(*info), rec_size))		       \
+		__MARK_INFO_ARRAY_WRITTEN(ptr, nr, info->rec_size);	       \
+} while (0)
+
+/* Handle null-terminated strings. */
+#define MARK_INFO_STR_WRITTEN(ptr, nr) do {				       \
+	if (info_len >= offsetofend(typeof(*info), ptr) &&		       \
+	    info_len >= offsetofend(typeof(*info), nr) &&		       \
+	    info->ptr)							       \
+		libbpf_mark_mem_written(u64_to_ptr(info->ptr),		       \
+					info->nr + 1);			       \
+} while (0)
+
+/* Helper functions for telling memory checkers that arrays pointed to by
+ * bpf_{btf,link,map,prog}_info members are initialized.
+ */
+
+static void mark_prog_info_written(struct bpf_prog_info *info, __u32 info_len)
+{
+	MARK_INFO_ARRAY_WRITTEN(map_ids, nr_map_ids, __u32);
+	MARK_INFO_ARRAY_WRITTEN(jited_ksyms, nr_jited_ksyms, __u64);
+	MARK_INFO_ARRAY_WRITTEN(jited_func_lens, nr_jited_func_lens, __u32);
+	MARK_INFO_REC_ARRAY_WRITTEN(func_info, nr_func_info,
+				    func_info_rec_size);
+	MARK_INFO_REC_ARRAY_WRITTEN(line_info, nr_line_info,
+				    line_info_rec_size);
+	MARK_INFO_REC_ARRAY_WRITTEN(jited_line_info, nr_jited_line_info,
+				    jited_line_info_rec_size);
+	MARK_INFO_ARRAY_WRITTEN(prog_tags, nr_prog_tags, __u8[BPF_TAG_SIZE]);
+}
+
+static void mark_btf_info_written(struct bpf_btf_info *info, __u32 info_len)
+{
+	MARK_INFO_ARRAY_WRITTEN(btf, btf_size, __u8);
+	MARK_INFO_STR_WRITTEN(name, name_len);
+}
+
+static void mark_link_info_written(struct bpf_link_info *info, __u32 info_len)
+{
+	switch (info->type) {
+	case BPF_LINK_TYPE_RAW_TRACEPOINT:
+		MARK_INFO_STR_WRITTEN(raw_tracepoint.tp_name,
+				      raw_tracepoint.tp_name_len);
+		break;
+	case BPF_LINK_TYPE_ITER:
+		MARK_INFO_STR_WRITTEN(iter.target_name, iter.target_name_len);
+		break;
+	default:
+		break;
+	}
+}
+
+#undef MARK_INFO_STR_WRITTEN
+#undef MARK_INFO_REC_ARRAY_WRITTEN
+#undef MARK_INFO_ARRAY_WRITTEN
+#undef __MARK_INFO_ARRAY_WRITTEN
+
 int bpf_prog_get_info_by_fd(int prog_fd, struct bpf_prog_info *info,
 			    __u32 *info_len)
 {
-	return bpf_obj_get_info_by_fd(prog_fd, info, info_len);
+	int err;
+
+	err = bpf_obj_get_info_by_fd(prog_fd, info, info_len);
+	if (!err)
+		mark_prog_info_written(info, *info_len);
+
+	return err;
 }
 
 int bpf_map_get_info_by_fd(int map_fd, struct bpf_map_info *info,
@@ -1059,13 +1192,25 @@ int bpf_map_get_info_by_fd(int map_fd, struct bpf_map_info *info,
 int bpf_btf_get_info_by_fd(int btf_fd, struct bpf_btf_info *info,
 			   __u32 *info_len)
 {
-	return bpf_obj_get_info_by_fd(btf_fd, info, info_len);
+	int err;
+
+	err = bpf_obj_get_info_by_fd(btf_fd, info, info_len);
+	if (!err)
+		mark_btf_info_written(info, *info_len);
+
+	return err;
 }
 
 int bpf_link_get_info_by_fd(int link_fd, struct bpf_link_info *info,
 			    __u32 *info_len)
 {
-	return bpf_obj_get_info_by_fd(link_fd, info, info_len);
+	int err;
+
+	err = bpf_obj_get_info_by_fd(link_fd, info, info_len);
+	if (!err)
+		mark_link_info_written(info, *info_len);
+
+	return err;
 }
 
 int bpf_raw_tracepoint_open(const char *name, int prog_fd)
@@ -1127,6 +1272,7 @@ int bpf_btf_load(const void *btf_data, size_t btf_size, const struct bpf_btf_loa
 		attr.btf_log_level = 1;
 		fd = sys_bpf_fd(BPF_BTF_LOAD, &attr, attr_sz);
 	}
+	libbpf_mark_mem_written(log_buf, attr.btf_log_size);
 	return libbpf_err_errno(fd);
 }
 
@@ -1146,6 +1292,7 @@ int bpf_task_fd_query(int pid, int fd, __u32 flags, char *buf, __u32 *buf_len,
 	attr.task_fd_query.buf_len = *buf_len;
 
 	err = sys_bpf(BPF_TASK_FD_QUERY, &attr, attr_sz);
+	libbpf_mark_mem_written_if(buf, attr.task_fd_query.buf_len + 1, !err);
 
 	*buf_len = attr.task_fd_query.buf_len;
 	*prog_id = attr.task_fd_query.prog_id;
diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
index 9181d36118d2..6535a758a530 100644
--- a/tools/lib/bpf/btf.c
+++ b/tools/lib/bpf/btf.c
@@ -1388,6 +1388,7 @@ struct btf *btf_get_from_fd(int btf_fd, struct btf *base_btf)
 		goto exit_free;
 	}
 
+	libbpf_mark_mem_written(ptr, btf_info.btf_size);
 	btf = btf_new(ptr, btf_info.btf_size, base_btf);
 
 exit_free:
diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 2d47a8e4f7e4..9a12dd773e49 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -5443,6 +5443,7 @@ static int load_module_btfs(struct bpf_object *obj)
 			pr_warn("failed to get BTF object #%d info: %d\n", id, err);
 			goto err_out;
 		}
+		libbpf_mark_mem_written(name, info.name_len + 1);
 
 		/* ignore non-module BTFs */
 		if (!info.kernel_btf || strcmp(name, "vmlinux") == 0) {
diff --git a/tools/lib/bpf/libbpf_internal.h b/tools/lib/bpf/libbpf_internal.h
index d6098b9c9e8e..5caf38300280 100644
--- a/tools/lib/bpf/libbpf_internal.h
+++ b/tools/lib/bpf/libbpf_internal.h
@@ -585,4 +585,42 @@ static inline bool is_percpu_bpf_map_type(__u32 type)
 	       type == BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE;
 }
 
+/* Check whether the code is compiled with the Memory Sanitizer. This needs to
+ * be two #if statements: if they are combined into one and __has_feature is
+ * not defined, then its usage will generate a syntax error.
+ */
+#if defined(__has_feature)
+#if __has_feature(memory_sanitizer)
+#define LIBBPF_MSAN
+#endif
+#endif
+
+/* __libbpf_mark_mem_written(): tell memory checkers that a certain address
+ * range should be treated as initialized. Currently supports Memory Sanitizer;
+ * Valgrind support can be added in the future.
+ */
+#ifdef LIBBPF_MSAN
+#define HAVE_LIBBPF_MARK_MEM_WRITTEN
+#include <sanitizer/msan_interface.h>
+#define __libbpf_mark_mem_written __msan_unpoison
+#else
+static inline void __libbpf_mark_mem_written(void *s, size_t n) {}
+#endif
+
+/* Convenience wrappers around __libbpf_mark_mem_written(). */
+
+static inline void libbpf_mark_mem_written(void *s, size_t n)
+{
+	if (s && n)
+		__libbpf_mark_mem_written(s, n);
+}
+
+static inline void libbpf_mark_mem_written_if(void *s, size_t n, bool c)
+{
+	if (c)
+		libbpf_mark_mem_written(s, n);
+}
+
+#define libbpf_mark_var_written(v) libbpf_mark_mem_written(&(v), sizeof(v))
+
 #endif /* __LIBBPF_LIBBPF_INTERNAL_H */
-- 
2.39.1

