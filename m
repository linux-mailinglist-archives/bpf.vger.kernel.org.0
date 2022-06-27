Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C504B55CC27
	for <lists+bpf@lfdr.de>; Tue, 28 Jun 2022 15:00:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241066AbiF0VPo convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Mon, 27 Jun 2022 17:15:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241052AbiF0VPn (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 27 Jun 2022 17:15:43 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EEEE167C7
        for <bpf@vger.kernel.org>; Mon, 27 Jun 2022 14:15:42 -0700 (PDT)
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25RKtu6I032599
        for <bpf@vger.kernel.org>; Mon, 27 Jun 2022 14:15:42 -0700
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3gym12852g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 27 Jun 2022 14:15:42 -0700
Received: from twshared16308.14.prn3.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Mon, 27 Jun 2022 14:15:40 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id A18911BAC278E; Mon, 27 Jun 2022 14:15:33 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>
Subject: [PATCH v2 bpf-next 02/15] libbpf: remove deprecated low-level APIs
Date:   Mon, 27 Jun 2022 14:15:14 -0700
Message-ID: <20220627211527.2245459-3-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220627211527.2245459-1-andrii@kernel.org>
References: <20220627211527.2245459-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: zVym8HBelLFOWsbngwhjnVhkki2c91aQ
X-Proofpoint-GUID: zVym8HBelLFOWsbngwhjnVhkki2c91aQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-06-27_06,2022-06-24_01,2022-06-22_01
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Drop low-level APIs as well as high-level (and very confusingly named)
BPF object loading bpf_prog_load_xattr() and bpf_prog_load_deprecated()
APIs.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/bpf.c      | 174 +--------------------------------------
 tools/lib/bpf/bpf.h      |  83 -------------------
 tools/lib/bpf/libbpf.c   |  89 --------------------
 tools/lib/bpf/libbpf.h   |  16 ----
 tools/lib/bpf/libbpf.map |  16 ----
 5 files changed, 4 insertions(+), 374 deletions(-)

diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
index 240186aac8e6..2f3495d80d69 100644
--- a/tools/lib/bpf/bpf.c
+++ b/tools/lib/bpf/bpf.c
@@ -233,11 +233,10 @@ alloc_zero_tailing_info(const void *orecord, __u32 cnt,
 	return info;
 }
 
-DEFAULT_VERSION(bpf_prog_load_v0_6_0, bpf_prog_load, LIBBPF_0.6.0)
-int bpf_prog_load_v0_6_0(enum bpf_prog_type prog_type,
-		         const char *prog_name, const char *license,
-		         const struct bpf_insn *insns, size_t insn_cnt,
-		         const struct bpf_prog_load_opts *opts)
+int bpf_prog_load(enum bpf_prog_type prog_type,
+		  const char *prog_name, const char *license,
+		  const struct bpf_insn *insns, size_t insn_cnt,
+		  const struct bpf_prog_load_opts *opts)
 {
 	void *finfo = NULL, *linfo = NULL;
 	const char *func_info, *line_info;
@@ -384,94 +383,6 @@ int bpf_prog_load_v0_6_0(enum bpf_prog_type prog_type,
 	return libbpf_err_errno(fd);
 }
 
-__attribute__((alias("bpf_load_program_xattr2")))
-int bpf_load_program_xattr(const struct bpf_load_program_attr *load_attr,
-			   char *log_buf, size_t log_buf_sz);
-
-static int bpf_load_program_xattr2(const struct bpf_load_program_attr *load_attr,
-				   char *log_buf, size_t log_buf_sz)
-{
-	LIBBPF_OPTS(bpf_prog_load_opts, p);
-
-	if (!load_attr || !log_buf != !log_buf_sz)
-		return libbpf_err(-EINVAL);
-
-	p.expected_attach_type = load_attr->expected_attach_type;
-	switch (load_attr->prog_type) {
-	case BPF_PROG_TYPE_STRUCT_OPS:
-	case BPF_PROG_TYPE_LSM:
-		p.attach_btf_id = load_attr->attach_btf_id;
-		break;
-	case BPF_PROG_TYPE_TRACING:
-	case BPF_PROG_TYPE_EXT:
-		p.attach_btf_id = load_attr->attach_btf_id;
-		p.attach_prog_fd = load_attr->attach_prog_fd;
-		break;
-	default:
-		p.prog_ifindex = load_attr->prog_ifindex;
-		p.kern_version = load_attr->kern_version;
-	}
-	p.log_level = load_attr->log_level;
-	p.log_buf = log_buf;
-	p.log_size = log_buf_sz;
-	p.prog_btf_fd = load_attr->prog_btf_fd;
-	p.func_info_rec_size = load_attr->func_info_rec_size;
-	p.func_info_cnt = load_attr->func_info_cnt;
-	p.func_info = load_attr->func_info;
-	p.line_info_rec_size = load_attr->line_info_rec_size;
-	p.line_info_cnt = load_attr->line_info_cnt;
-	p.line_info = load_attr->line_info;
-	p.prog_flags = load_attr->prog_flags;
-
-	return bpf_prog_load(load_attr->prog_type, load_attr->name, load_attr->license,
-			     load_attr->insns, load_attr->insns_cnt, &p);
-}
-
-int bpf_load_program(enum bpf_prog_type type, const struct bpf_insn *insns,
-		     size_t insns_cnt, const char *license,
-		     __u32 kern_version, char *log_buf,
-		     size_t log_buf_sz)
-{
-	struct bpf_load_program_attr load_attr;
-
-	memset(&load_attr, 0, sizeof(struct bpf_load_program_attr));
-	load_attr.prog_type = type;
-	load_attr.expected_attach_type = 0;
-	load_attr.name = NULL;
-	load_attr.insns = insns;
-	load_attr.insns_cnt = insns_cnt;
-	load_attr.license = license;
-	load_attr.kern_version = kern_version;
-
-	return bpf_load_program_xattr2(&load_attr, log_buf, log_buf_sz);
-}
-
-int bpf_verify_program(enum bpf_prog_type type, const struct bpf_insn *insns,
-		       size_t insns_cnt, __u32 prog_flags, const char *license,
-		       __u32 kern_version, char *log_buf, size_t log_buf_sz,
-		       int log_level)
-{
-	union bpf_attr attr;
-	int fd;
-
-	bump_rlimit_memlock();
-
-	memset(&attr, 0, sizeof(attr));
-	attr.prog_type = type;
-	attr.insn_cnt = (__u32)insns_cnt;
-	attr.insns = ptr_to_u64(insns);
-	attr.license = ptr_to_u64(license);
-	attr.log_buf = ptr_to_u64(log_buf);
-	attr.log_size = log_buf_sz;
-	attr.log_level = log_level;
-	log_buf[0] = 0;
-	attr.kern_version = kern_version;
-	attr.prog_flags = prog_flags;
-
-	fd = sys_bpf_prog_load(&attr, sizeof(attr), PROG_LOAD_ATTEMPTS);
-	return libbpf_err_errno(fd);
-}
-
 int bpf_map_update_elem(int fd, const void *key, const void *value,
 			__u64 flags)
 {
@@ -910,62 +821,6 @@ int bpf_prog_query(int target_fd, enum bpf_attach_type type, __u32 query_flags,
 	return libbpf_err_errno(ret);
 }
 
-int bpf_prog_test_run(int prog_fd, int repeat, void *data, __u32 size,
-		      void *data_out, __u32 *size_out, __u32 *retval,
-		      __u32 *duration)
-{
-	union bpf_attr attr;
-	int ret;
-
-	memset(&attr, 0, sizeof(attr));
-	attr.test.prog_fd = prog_fd;
-	attr.test.data_in = ptr_to_u64(data);
-	attr.test.data_out = ptr_to_u64(data_out);
-	attr.test.data_size_in = size;
-	attr.test.repeat = repeat;
-
-	ret = sys_bpf(BPF_PROG_TEST_RUN, &attr, sizeof(attr));
-
-	if (size_out)
-		*size_out = attr.test.data_size_out;
-	if (retval)
-		*retval = attr.test.retval;
-	if (duration)
-		*duration = attr.test.duration;
-
-	return libbpf_err_errno(ret);
-}
-
-int bpf_prog_test_run_xattr(struct bpf_prog_test_run_attr *test_attr)
-{
-	union bpf_attr attr;
-	int ret;
-
-	if (!test_attr->data_out && test_attr->data_size_out > 0)
-		return libbpf_err(-EINVAL);
-
-	memset(&attr, 0, sizeof(attr));
-	attr.test.prog_fd = test_attr->prog_fd;
-	attr.test.data_in = ptr_to_u64(test_attr->data_in);
-	attr.test.data_out = ptr_to_u64(test_attr->data_out);
-	attr.test.data_size_in = test_attr->data_size_in;
-	attr.test.data_size_out = test_attr->data_size_out;
-	attr.test.ctx_in = ptr_to_u64(test_attr->ctx_in);
-	attr.test.ctx_out = ptr_to_u64(test_attr->ctx_out);
-	attr.test.ctx_size_in = test_attr->ctx_size_in;
-	attr.test.ctx_size_out = test_attr->ctx_size_out;
-	attr.test.repeat = test_attr->repeat;
-
-	ret = sys_bpf(BPF_PROG_TEST_RUN, &attr, sizeof(attr));
-
-	test_attr->data_size_out = attr.test.data_size_out;
-	test_attr->ctx_size_out = attr.test.ctx_size_out;
-	test_attr->retval = attr.test.retval;
-	test_attr->duration = attr.test.duration;
-
-	return libbpf_err_errno(ret);
-}
-
 int bpf_prog_test_run_opts(int prog_fd, struct bpf_test_run_opts *opts)
 {
 	union bpf_attr attr;
@@ -1162,27 +1017,6 @@ int bpf_btf_load(const void *btf_data, size_t btf_size, const struct bpf_btf_loa
 	return libbpf_err_errno(fd);
 }
 
-int bpf_load_btf(const void *btf, __u32 btf_size, char *log_buf, __u32 log_buf_size, bool do_log)
-{
-	LIBBPF_OPTS(bpf_btf_load_opts, opts);
-	int fd;
-
-retry:
-	if (do_log && log_buf && log_buf_size) {
-		opts.log_buf = log_buf;
-		opts.log_size = log_buf_size;
-		opts.log_level = 1;
-	}
-
-	fd = bpf_btf_load(btf, btf_size, &opts);
-	if (fd < 0 && !do_log && log_buf && log_buf_size) {
-		do_log = true;
-		goto retry;
-	}
-
-	return libbpf_err_errno(fd);
-}
-
 int bpf_task_fd_query(int pid, int fd, __u32 flags, char *buf, __u32 *buf_len,
 		      __u32 *prog_id, __u32 *fd_type, __u64 *probe_offset,
 		      __u64 *probe_addr)
diff --git a/tools/lib/bpf/bpf.h b/tools/lib/bpf/bpf.h
index cabc03703e29..af7baf5da74d 100644
--- a/tools/lib/bpf/bpf.h
+++ b/tools/lib/bpf/bpf.h
@@ -103,54 +103,6 @@ LIBBPF_API int bpf_prog_load(enum bpf_prog_type prog_type,
 			     const char *prog_name, const char *license,
 			     const struct bpf_insn *insns, size_t insn_cnt,
 			     const struct bpf_prog_load_opts *opts);
-/* this "specialization" should go away in libbpf 1.0 */
-LIBBPF_API int bpf_prog_load_v0_6_0(enum bpf_prog_type prog_type,
-				    const char *prog_name, const char *license,
-				    const struct bpf_insn *insns, size_t insn_cnt,
-				    const struct bpf_prog_load_opts *opts);
-
-/* This is an elaborate way to not conflict with deprecated bpf_prog_load()
- * API, defined in libbpf.h. Once we hit libbpf 1.0, all this will be gone.
- * With this approach, if someone is calling bpf_prog_load() with
- * 4 arguments, they will use the deprecated API, which keeps backwards
- * compatibility (both source code and binary). If bpf_prog_load() is called
- * with 6 arguments, though, it gets redirected to __bpf_prog_load.
- * So looking forward to libbpf 1.0 when this hack will be gone and
- * __bpf_prog_load() will be called just bpf_prog_load().
- */
-#ifndef bpf_prog_load
-#define bpf_prog_load(...) ___libbpf_overload(___bpf_prog_load, __VA_ARGS__)
-#define ___bpf_prog_load4(file, type, pobj, prog_fd) \
-	bpf_prog_load_deprecated(file, type, pobj, prog_fd)
-#define ___bpf_prog_load6(prog_type, prog_name, license, insns, insn_cnt, opts) \
-	bpf_prog_load(prog_type, prog_name, license, insns, insn_cnt, opts)
-#endif /* bpf_prog_load */
-
-struct bpf_load_program_attr {
-	enum bpf_prog_type prog_type;
-	enum bpf_attach_type expected_attach_type;
-	const char *name;
-	const struct bpf_insn *insns;
-	size_t insns_cnt;
-	const char *license;
-	union {
-		__u32 kern_version;
-		__u32 attach_prog_fd;
-	};
-	union {
-		__u32 prog_ifindex;
-		__u32 attach_btf_id;
-	};
-	__u32 prog_btf_fd;
-	__u32 func_info_rec_size;
-	const void *func_info;
-	__u32 func_info_cnt;
-	__u32 line_info_rec_size;
-	const void *line_info;
-	__u32 line_info_cnt;
-	__u32 log_level;
-	__u32 prog_flags;
-};
 
 /* Flags to direct loading requirements */
 #define MAPS_RELAX_COMPAT	0x01
@@ -158,22 +110,6 @@ struct bpf_load_program_attr {
 /* Recommended log buffer size */
 #define BPF_LOG_BUF_SIZE (UINT32_MAX >> 8) /* verifier maximum in kernels <= 5.1 */
 
-LIBBPF_DEPRECATED_SINCE(0, 7, "use bpf_prog_load() instead")
-LIBBPF_API int bpf_load_program_xattr(const struct bpf_load_program_attr *load_attr,
-				      char *log_buf, size_t log_buf_sz);
-LIBBPF_DEPRECATED_SINCE(0, 7, "use bpf_prog_load() instead")
-LIBBPF_API int bpf_load_program(enum bpf_prog_type type,
-				const struct bpf_insn *insns, size_t insns_cnt,
-				const char *license, __u32 kern_version,
-				char *log_buf, size_t log_buf_sz);
-LIBBPF_DEPRECATED_SINCE(0, 7, "use bpf_prog_load() instead")
-LIBBPF_API int bpf_verify_program(enum bpf_prog_type type,
-				  const struct bpf_insn *insns,
-				  size_t insns_cnt, __u32 prog_flags,
-				  const char *license, __u32 kern_version,
-				  char *log_buf, size_t log_buf_sz,
-				  int log_level);
-
 struct bpf_btf_load_opts {
 	size_t sz; /* size of this struct for forward/backward compatibility */
 
@@ -187,10 +123,6 @@ struct bpf_btf_load_opts {
 LIBBPF_API int bpf_btf_load(const void *btf_data, size_t btf_size,
 			    const struct bpf_btf_load_opts *opts);
 
-LIBBPF_DEPRECATED_SINCE(0, 8, "use bpf_btf_load() instead")
-LIBBPF_API int bpf_load_btf(const void *btf, __u32 btf_size, char *log_buf,
-			    __u32 log_buf_size, bool do_log);
-
 LIBBPF_API int bpf_map_update_elem(int fd, const void *key, const void *value,
 				   __u64 flags);
 
@@ -353,10 +285,6 @@ LIBBPF_API int bpf_prog_attach(int prog_fd, int attachable_fd,
 LIBBPF_API int bpf_prog_attach_opts(int prog_fd, int attachable_fd,
 				     enum bpf_attach_type type,
 				     const struct bpf_prog_attach_opts *opts);
-LIBBPF_DEPRECATED_SINCE(0, 8, "use bpf_prog_attach_opts() instead")
-LIBBPF_API int bpf_prog_attach_xattr(int prog_fd, int attachable_fd,
-				     enum bpf_attach_type type,
-				     const struct bpf_prog_attach_opts *opts);
 LIBBPF_API int bpf_prog_detach(int attachable_fd, enum bpf_attach_type type);
 LIBBPF_API int bpf_prog_detach2(int prog_fd, int attachable_fd,
 				enum bpf_attach_type type);
@@ -422,17 +350,6 @@ struct bpf_prog_test_run_attr {
 			     * out: length of cxt_out */
 };
 
-LIBBPF_DEPRECATED_SINCE(0, 7, "use bpf_prog_test_run_opts() instead")
-LIBBPF_API int bpf_prog_test_run_xattr(struct bpf_prog_test_run_attr *test_attr);
-
-/*
- * bpf_prog_test_run does not check that data_out is large enough. Consider
- * using bpf_prog_test_run_opts instead.
- */
-LIBBPF_DEPRECATED_SINCE(0, 7, "use bpf_prog_test_run_opts() instead")
-LIBBPF_API int bpf_prog_test_run(int prog_fd, int repeat, void *data,
-				 __u32 size, void *data_out, __u32 *size_out,
-				 __u32 *retval, __u32 *duration);
 LIBBPF_API int bpf_prog_get_next_id(__u32 start_id, __u32 *next_id);
 LIBBPF_API int bpf_map_get_next_id(__u32 start_id, __u32 *next_id);
 LIBBPF_API int bpf_btf_get_next_id(__u32 start_id, __u32 *next_id);
diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 335467ece75f..b11d3e689126 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -10205,95 +10205,6 @@ long libbpf_get_error(const void *ptr)
 	return -errno;
 }
 
-__attribute__((alias("bpf_prog_load_xattr2")))
-int bpf_prog_load_xattr(const struct bpf_prog_load_attr *attr,
-			struct bpf_object **pobj, int *prog_fd);
-
-static int bpf_prog_load_xattr2(const struct bpf_prog_load_attr *attr,
-				struct bpf_object **pobj, int *prog_fd)
-{
-	struct bpf_object_open_attr open_attr = {};
-	struct bpf_program *prog, *first_prog = NULL;
-	struct bpf_object *obj;
-	struct bpf_map *map;
-	int err;
-
-	if (!attr)
-		return libbpf_err(-EINVAL);
-	if (!attr->file)
-		return libbpf_err(-EINVAL);
-
-	open_attr.file = attr->file;
-	open_attr.prog_type = attr->prog_type;
-
-	obj = __bpf_object__open_xattr(&open_attr, 0);
-	err = libbpf_get_error(obj);
-	if (err)
-		return libbpf_err(-ENOENT);
-
-	bpf_object__for_each_program(prog, obj) {
-		enum bpf_attach_type attach_type = attr->expected_attach_type;
-		/*
-		 * to preserve backwards compatibility, bpf_prog_load treats
-		 * attr->prog_type, if specified, as an override to whatever
-		 * bpf_object__open guessed
-		 */
-		if (attr->prog_type != BPF_PROG_TYPE_UNSPEC) {
-			prog->type = attr->prog_type;
-			prog->expected_attach_type = attach_type;
-		}
-		if (bpf_program__type(prog) == BPF_PROG_TYPE_UNSPEC) {
-			/*
-			 * we haven't guessed from section name and user
-			 * didn't provide a fallback type, too bad...
-			 */
-			bpf_object__close(obj);
-			return libbpf_err(-EINVAL);
-		}
-
-		prog->prog_ifindex = attr->ifindex;
-		prog->log_level = attr->log_level;
-		prog->prog_flags |= attr->prog_flags;
-		if (!first_prog)
-			first_prog = prog;
-	}
-
-	bpf_object__for_each_map(map, obj) {
-		if (map->def.type != BPF_MAP_TYPE_PERF_EVENT_ARRAY)
-			map->map_ifindex = attr->ifindex;
-	}
-
-	if (!first_prog) {
-		pr_warn("object file doesn't contain bpf program\n");
-		bpf_object__close(obj);
-		return libbpf_err(-ENOENT);
-	}
-
-	err = bpf_object__load(obj);
-	if (err) {
-		bpf_object__close(obj);
-		return libbpf_err(err);
-	}
-
-	*pobj = obj;
-	*prog_fd = bpf_program__fd(first_prog);
-	return 0;
-}
-
-COMPAT_VERSION(bpf_prog_load_deprecated, bpf_prog_load, LIBBPF_0.0.1)
-int bpf_prog_load_deprecated(const char *file, enum bpf_prog_type type,
-			     struct bpf_object **pobj, int *prog_fd)
-{
-	struct bpf_prog_load_attr attr;
-
-	memset(&attr, 0, sizeof(struct bpf_prog_load_attr));
-	attr.file = file;
-	attr.prog_type = type;
-	attr.expected_attach_type = 0;
-
-	return bpf_prog_load_xattr2(&attr, pobj, prog_fd);
-}
-
 /* Replace link's underlying BPF program with the new one */
 int bpf_link__update_program(struct bpf_link *link, struct bpf_program *prog)
 {
diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index fa27969da0da..0b2de10b5878 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -1164,22 +1164,6 @@ LIBBPF_API int bpf_map__get_next_key(const struct bpf_map *map,
  */
 LIBBPF_API long libbpf_get_error(const void *ptr);
 
-struct bpf_prog_load_attr {
-	const char *file;
-	enum bpf_prog_type prog_type;
-	enum bpf_attach_type expected_attach_type;
-	int ifindex;
-	int log_level;
-	int prog_flags;
-};
-
-LIBBPF_DEPRECATED_SINCE(0, 8, "use bpf_object__open() and bpf_object__load() instead")
-LIBBPF_API int bpf_prog_load_xattr(const struct bpf_prog_load_attr *attr,
-				   struct bpf_object **pobj, int *prog_fd);
-LIBBPF_DEPRECATED_SINCE(0, 7, "use bpf_object__open() and bpf_object__load() instead")
-LIBBPF_API int bpf_prog_load_deprecated(const char *file, enum bpf_prog_type type,
-					struct bpf_object **pobj, int *prog_fd);
-
 /* XDP related API */
 struct xdp_link_info {
 	__u32 prog_id;
diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
index da7a4f928452..a480490914a4 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -1,15 +1,6 @@
 LIBBPF_0.0.1 {
 	global:
 		bpf_btf_get_fd_by_id;
-		bpf_create_map;
-		bpf_create_map_in_map;
-		bpf_create_map_in_map_node;
-		bpf_create_map_name;
-		bpf_create_map_node;
-		bpf_create_map_xattr;
-		bpf_load_btf;
-		bpf_load_program;
-		bpf_load_program_xattr;
 		bpf_map__btf_key_type_id;
 		bpf_map__btf_value_type_id;
 		bpf_map__def;
@@ -61,11 +52,7 @@ LIBBPF_0.0.1 {
 		bpf_prog_detach2;
 		bpf_prog_get_fd_by_id;
 		bpf_prog_get_next_id;
-		bpf_prog_load;
-		bpf_prog_load_xattr;
 		bpf_prog_query;
-		bpf_prog_test_run;
-		bpf_prog_test_run_xattr;
 		bpf_program__fd;
 		bpf_program__is_kprobe;
 		bpf_program__is_perf_event;
@@ -106,7 +93,6 @@ LIBBPF_0.0.1 {
 		bpf_raw_tracepoint_open;
 		bpf_set_link_xdp_fd;
 		bpf_task_fd_query;
-		bpf_verify_program;
 		btf__fd;
 		btf__find_by_name;
 		btf__free;
@@ -218,7 +204,6 @@ LIBBPF_0.0.7 {
 		bpf_object__load_skeleton;
 		bpf_object__open_skeleton;
 		bpf_probe_large_insn_limit;
-		bpf_prog_attach_xattr;
 		bpf_program__attach;
 		bpf_program__name;
 		bpf_program__is_extension;
@@ -387,7 +372,6 @@ LIBBPF_0.6.0 {
 		bpf_object__next_program;
 		bpf_object__prev_map;
 		bpf_object__prev_program;
-		bpf_prog_load_deprecated;
 		bpf_prog_load;
 		bpf_program__flags;
 		bpf_program__insn_cnt;
-- 
2.30.2

