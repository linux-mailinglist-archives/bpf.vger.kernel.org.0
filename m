Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD670440789
	for <lists+bpf@lfdr.de>; Sat, 30 Oct 2021 07:00:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231409AbhJ3FC3 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Sat, 30 Oct 2021 01:02:29 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:30456 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231539AbhJ3FC2 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sat, 30 Oct 2021 01:02:28 -0400
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19U2vOiu027807
        for <bpf@vger.kernel.org>; Fri, 29 Oct 2021 21:59:58 -0700
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3c0wq90btc-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 29 Oct 2021 21:59:58 -0700
Received: from intmgw001.05.prn6.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:11d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Fri, 29 Oct 2021 21:59:55 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id A22EC7830534; Fri, 29 Oct 2021 21:59:53 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>,
        Hengqi Chen <hengqi.chen@gmail.com>
Subject: [PATCH bpf-next 05/14] libbpf: unify low-level BPF_PROG_LOAD APIs into bpf_prog_load()
Date:   Fri, 29 Oct 2021 21:59:32 -0700
Message-ID: <20211030045941.3514948-6-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211030045941.3514948-1-andrii@kernel.org>
References: <20211030045941.3514948-1-andrii@kernel.org>
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-ORIG-GUID: NnH7nNjxZ5PHba6xotlT7ZA9ALzscVFp
X-Proofpoint-GUID: NnH7nNjxZ5PHba6xotlT7ZA9ALzscVFp
Content-Transfer-Encoding: 8BIT
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-30_01,2021-10-29_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 malwarescore=0
 bulkscore=0 mlxlogscore=999 priorityscore=1501 clxscore=1015 spamscore=0
 impostorscore=0 suspectscore=0 adultscore=0 lowpriorityscore=0
 phishscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2110300025
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add a new unified OPTS-based low-level API for program loading,
bpf_prog_load() ([0]).  bpf_prog_load() accepts few "mandatory"
parameters as input arguments (program type, name, license,
instructions) and all the other optional (as in not required to specify
for all types of BPF programs) fields into struct bpf_prog_load_opts.

This makes all the other non-extensible APIs variant for BPF_PROG_LOAD
obsolete and they are slated for deprecation in libbpf v0.7:
  - bpf_load_program();
  - bpf_load_program_xattr();
  - bpf_verify_program().

Implementation-wise, internal helper libbpf__bpf_prog_load is refactored
to become a public bpf_prog_load() API. struct bpf_prog_load_params used
internally is replaced by public struct bpf_prog_load_opts.

Unfortunately, while conceptually all this is pretty straightforward,
the biggest complication comes from the already existing bpf_prog_load()
*high-level* API, which has nothing to do with BPF_PROG_LOAD command.

We try really hard to have a new API named bpf_prog_load(), though,
because it maps naturally to BPF_PROG_LOAD command.

For that, we rename old bpf_prog_load() into bpf_prog_load_deprecated()
and mark it as COMPAT_VERSION() for shared library users compiled
against old version of libbpf. Statically linked users and shared lib
users compiled against new version of libbpf headers will get "rerouted"
to bpf_prog_deprecated() through a macro helper that decides whether to
use new or old bpf_prog_load() based on number of input arguments (see
___libbpf_overload in libbpf_common.h).

To test that existing
bpf_prog_load()-using code compiles and works as expected, I've compiled
and ran selftests as is. I had to remove (locally) selftest/bpf/Makefile
-Dbpf_prog_load=bpf_prog_test_load hack because it was conflicting with
the macro-based overload approach. I don't expect anyone else to do
something like this in practice, though. This is testing-specific way to
replace bpf_prog_load() calls with special testing variant of it, which
adds extra prog_flags value. After testing I kept this selftests hack,
but ensured that we use a new bpf_prog_load_deprecated name for this.

This patch also marks bpf_prog_load() and bpf_prog_load_xattr() as deprecated.
bpf_object interface has to be used for working with struct bpf_program.
Libbpf doesn't support loading just a bpf_program.

The silver lining is that when we get to libbpf 1.0 all these
complication will be gone and we'll have one clean bpf_prog_load()
low-level API with no backwards compatibility hackery surrounding it.

  [0] Closes: https://github.com/libbpf/libbpf/issues/284

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/bpf.c                  | 149 ++++++++++++++++-----------
 tools/lib/bpf/bpf.h                  |  73 ++++++++++++-
 tools/lib/bpf/bpf_gen_internal.h     |   8 +-
 tools/lib/bpf/gen_loader.c           |  30 +++---
 tools/lib/bpf/libbpf.c               |  51 +++++----
 tools/lib/bpf/libbpf.h               |   5 +-
 tools/lib/bpf/libbpf.map             |   2 +
 tools/lib/bpf/libbpf_common.h        |  12 +++
 tools/lib/bpf/libbpf_internal.h      |  31 ------
 tools/testing/selftests/bpf/Makefile |   2 +-
 10 files changed, 223 insertions(+), 140 deletions(-)

diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
index 7bb4ab16d4f6..796f17d72230 100644
--- a/tools/lib/bpf/bpf.c
+++ b/tools/lib/bpf/bpf.c
@@ -28,6 +28,7 @@
 #include <asm/unistd.h>
 #include <errno.h>
 #include <linux/bpf.h>
+#include <limits.h>
 #include "bpf.h"
 #include "libbpf.h"
 #include "libbpf_internal.h"
@@ -226,58 +227,91 @@ alloc_zero_tailing_info(const void *orecord, __u32 cnt,
 	return info;
 }
 
-int libbpf__bpf_prog_load(const struct bpf_prog_load_params *load_attr)
+DEFAULT_VERSION(bpf_prog_load_v0_6_0, bpf_prog_load, LIBBPF_0.6.0)
+int bpf_prog_load_v0_6_0(enum bpf_prog_type prog_type,
+		         const char *prog_name, const char *license,
+		         const struct bpf_insn *insns, size_t insn_cnt,
+		         const struct bpf_prog_load_opts *opts)
 {
 	void *finfo = NULL, *linfo = NULL;
+	const char *func_info, *line_info;
+	__u32 log_size, log_level, attach_prog_fd, attach_btf_obj_fd;
+	__u32 func_info_rec_size, line_info_rec_size;
+	int fd, attempts;
 	union bpf_attr attr;
-	int fd;
+	char *log_buf;
 
-	if (!load_attr->log_buf != !load_attr->log_buf_sz)
+	if (!OPTS_VALID(opts, bpf_prog_load_opts))
 		return libbpf_err(-EINVAL);
 
-	if (load_attr->log_level > (4 | 2 | 1) || (load_attr->log_level && !load_attr->log_buf))
+	attempts = OPTS_GET(opts, attempts, 0);
+	if (attempts < 0)
 		return libbpf_err(-EINVAL);
+	if (attempts == 0)
+		attempts = PROG_LOAD_ATTEMPTS;
 
 	memset(&attr, 0, sizeof(attr));
-	attr.prog_type = load_attr->prog_type;
-	attr.expected_attach_type = load_attr->expected_attach_type;
 
-	if (load_attr->attach_prog_fd)
-		attr.attach_prog_fd = load_attr->attach_prog_fd;
-	else
-		attr.attach_btf_obj_fd = load_attr->attach_btf_obj_fd;
-	attr.attach_btf_id = load_attr->attach_btf_id;
+	attr.prog_type = prog_type;
+	attr.expected_attach_type = OPTS_GET(opts, expected_attach_type, 0);
 
-	attr.prog_ifindex = load_attr->prog_ifindex;
-	attr.kern_version = load_attr->kern_version;
+	attr.prog_btf_fd = OPTS_GET(opts, prog_btf_fd, 0);
+	attr.prog_flags = OPTS_GET(opts, prog_flags, 0);
+	attr.prog_ifindex = OPTS_GET(opts, prog_ifindex, 0);
+	attr.kern_version = OPTS_GET(opts, kern_version, 0);
 
-	attr.insn_cnt = (__u32)load_attr->insn_cnt;
-	attr.insns = ptr_to_u64(load_attr->insns);
-	attr.license = ptr_to_u64(load_attr->license);
+	if (prog_name)
+		strncat(attr.prog_name, prog_name, sizeof(attr.prog_name) - 1);
+	attr.license = ptr_to_u64(license);
 
-	attr.log_level = load_attr->log_level;
-	if (attr.log_level) {
-		attr.log_buf = ptr_to_u64(load_attr->log_buf);
-		attr.log_size = load_attr->log_buf_sz;
-	}
+	if (insn_cnt > UINT_MAX)
+		return libbpf_err(-E2BIG);
 
-	attr.prog_btf_fd = load_attr->prog_btf_fd;
-	attr.prog_flags = load_attr->prog_flags;
+	attr.insns = ptr_to_u64(insns);
+	attr.insn_cnt = (__u32)insn_cnt;
 
-	attr.func_info_rec_size = load_attr->func_info_rec_size;
-	attr.func_info_cnt = load_attr->func_info_cnt;
-	attr.func_info = ptr_to_u64(load_attr->func_info);
+	attach_prog_fd = OPTS_GET(opts, attach_prog_fd, 0);
+	attach_btf_obj_fd = OPTS_GET(opts, attach_btf_obj_fd, 0);
 
-	attr.line_info_rec_size = load_attr->line_info_rec_size;
-	attr.line_info_cnt = load_attr->line_info_cnt;
-	attr.line_info = ptr_to_u64(load_attr->line_info);
-	attr.fd_array = ptr_to_u64(load_attr->fd_array);
+	if (attach_prog_fd && attach_btf_obj_fd)
+		return libbpf_err(-EINVAL);
 
-	if (load_attr->name)
-		memcpy(attr.prog_name, load_attr->name,
-		       min(strlen(load_attr->name), (size_t)BPF_OBJ_NAME_LEN - 1));
+	attr.attach_btf_id = OPTS_GET(opts, attach_btf_id, 0);
+	if (attach_prog_fd)
+		attr.attach_prog_fd = attach_prog_fd;
+	else
+		attr.attach_btf_obj_fd = attach_btf_obj_fd;
 
-	fd = sys_bpf_prog_load(&attr, sizeof(attr), PROG_LOAD_ATTEMPTS);
+	log_buf = OPTS_GET(opts, log_buf, NULL);
+	log_size = OPTS_GET(opts, log_size, 0);
+	log_level = OPTS_GET(opts, log_level, 0);
+
+	if (!!log_buf != !!log_size)
+		return libbpf_err(-EINVAL);
+	if (log_level > (4 | 2 | 1))
+		return libbpf_err(-EINVAL);
+	if (log_level && !log_buf)
+		return libbpf_err(-EINVAL);
+
+	attr.log_level = log_level;
+	attr.log_buf = ptr_to_u64(log_buf);
+	attr.log_size = log_size;
+
+	func_info_rec_size = OPTS_GET(opts, func_info_rec_size, 0);
+	func_info = OPTS_GET(opts, func_info, NULL);
+	attr.func_info_rec_size = func_info_rec_size;
+	attr.func_info = ptr_to_u64(func_info);
+	attr.func_info_cnt = OPTS_GET(opts, func_info_cnt, 0);
+
+	line_info_rec_size = OPTS_GET(opts, line_info_rec_size, 0);
+	line_info = OPTS_GET(opts, line_info, NULL);
+	attr.line_info_rec_size = line_info_rec_size;
+	attr.line_info = ptr_to_u64(line_info);
+	attr.line_info_cnt = OPTS_GET(opts, line_info_cnt, 0);
+
+	attr.fd_array = ptr_to_u64(OPTS_GET(opts, fd_array, NULL));
+
+	fd = sys_bpf_prog_load(&attr, sizeof(attr), attempts);
 	if (fd >= 0)
 		return fd;
 
@@ -287,11 +321,11 @@ int libbpf__bpf_prog_load(const struct bpf_prog_load_params *load_attr)
 	 */
 	while (errno == E2BIG && (!finfo || !linfo)) {
 		if (!finfo && attr.func_info_cnt &&
-		    attr.func_info_rec_size < load_attr->func_info_rec_size) {
+		    attr.func_info_rec_size < func_info_rec_size) {
 			/* try with corrected func info records */
-			finfo = alloc_zero_tailing_info(load_attr->func_info,
-							load_attr->func_info_cnt,
-							load_attr->func_info_rec_size,
+			finfo = alloc_zero_tailing_info(func_info,
+							attr.func_info_cnt,
+							func_info_rec_size,
 							attr.func_info_rec_size);
 			if (!finfo) {
 				errno = E2BIG;
@@ -299,13 +333,12 @@ int libbpf__bpf_prog_load(const struct bpf_prog_load_params *load_attr)
 			}
 
 			attr.func_info = ptr_to_u64(finfo);
-			attr.func_info_rec_size = load_attr->func_info_rec_size;
+			attr.func_info_rec_size = func_info_rec_size;
 		} else if (!linfo && attr.line_info_cnt &&
-			   attr.line_info_rec_size <
-			   load_attr->line_info_rec_size) {
-			linfo = alloc_zero_tailing_info(load_attr->line_info,
-							load_attr->line_info_cnt,
-							load_attr->line_info_rec_size,
+			   attr.line_info_rec_size < line_info_rec_size) {
+			linfo = alloc_zero_tailing_info(line_info,
+							attr.line_info_cnt,
+							line_info_rec_size,
 							attr.line_info_rec_size);
 			if (!linfo) {
 				errno = E2BIG;
@@ -313,26 +346,26 @@ int libbpf__bpf_prog_load(const struct bpf_prog_load_params *load_attr)
 			}
 
 			attr.line_info = ptr_to_u64(linfo);
-			attr.line_info_rec_size = load_attr->line_info_rec_size;
+			attr.line_info_rec_size = line_info_rec_size;
 		} else {
 			break;
 		}
 
-		fd = sys_bpf_prog_load(&attr, sizeof(attr), PROG_LOAD_ATTEMPTS);
+		fd = sys_bpf_prog_load(&attr, sizeof(attr), attempts);
 		if (fd >= 0)
 			goto done;
 	}
 
-	if (load_attr->log_level || !load_attr->log_buf)
+	if (log_level || !log_buf)
 		goto done;
 
 	/* Try again with log */
-	attr.log_buf = ptr_to_u64(load_attr->log_buf);
-	attr.log_size = load_attr->log_buf_sz;
+	log_buf[0] = 0;
+	attr.log_buf = ptr_to_u64(log_buf);
+	attr.log_size = log_size;
 	attr.log_level = 1;
-	load_attr->log_buf[0] = 0;
 
-	fd = sys_bpf_prog_load(&attr, sizeof(attr), PROG_LOAD_ATTEMPTS);
+	fd = sys_bpf_prog_load(&attr, sizeof(attr), attempts);
 done:
 	/* free() doesn't affect errno, so we don't need to restore it */
 	free(finfo);
@@ -343,14 +376,13 @@ int libbpf__bpf_prog_load(const struct bpf_prog_load_params *load_attr)
 int bpf_load_program_xattr(const struct bpf_load_program_attr *load_attr,
 			   char *log_buf, size_t log_buf_sz)
 {
-	struct bpf_prog_load_params p = {};
+	LIBBPF_OPTS(bpf_prog_load_opts, p);
 
 	if (!load_attr || !log_buf != !log_buf_sz)
 		return libbpf_err(-EINVAL);
 
-	p.prog_type = load_attr->prog_type;
 	p.expected_attach_type = load_attr->expected_attach_type;
-	switch (p.prog_type) {
+	switch (load_attr->prog_type) {
 	case BPF_PROG_TYPE_STRUCT_OPS:
 	case BPF_PROG_TYPE_LSM:
 		p.attach_btf_id = load_attr->attach_btf_id;
@@ -364,12 +396,9 @@ int bpf_load_program_xattr(const struct bpf_load_program_attr *load_attr,
 		p.prog_ifindex = load_attr->prog_ifindex;
 		p.kern_version = load_attr->kern_version;
 	}
-	p.insn_cnt = load_attr->insns_cnt;
-	p.insns = load_attr->insns;
-	p.license = load_attr->license;
 	p.log_level = load_attr->log_level;
 	p.log_buf = log_buf;
-	p.log_buf_sz = log_buf_sz;
+	p.log_size = log_buf_sz;
 	p.prog_btf_fd = load_attr->prog_btf_fd;
 	p.func_info_rec_size = load_attr->func_info_rec_size;
 	p.func_info_cnt = load_attr->func_info_cnt;
@@ -377,10 +406,10 @@ int bpf_load_program_xattr(const struct bpf_load_program_attr *load_attr,
 	p.line_info_rec_size = load_attr->line_info_rec_size;
 	p.line_info_cnt = load_attr->line_info_cnt;
 	p.line_info = load_attr->line_info;
-	p.name = load_attr->name;
 	p.prog_flags = load_attr->prog_flags;
 
-	return libbpf__bpf_prog_load(&p);
+	return bpf_prog_load(load_attr->prog_type, load_attr->name, load_attr->license,
+			     load_attr->insns, load_attr->insns_cnt, &p);
 }
 
 int bpf_load_program(enum bpf_prog_type type, const struct bpf_insn *insns,
diff --git a/tools/lib/bpf/bpf.h b/tools/lib/bpf/bpf.h
index aac6bb4d8c82..f864d908f260 100644
--- a/tools/lib/bpf/bpf.h
+++ b/tools/lib/bpf/bpf.h
@@ -102,6 +102,71 @@ LIBBPF_API int bpf_create_map_in_map(enum bpf_map_type map_type,
 				     int inner_map_fd, int max_entries,
 				     __u32 map_flags);
 
+struct bpf_prog_load_opts {
+	size_t sz; /* size of this struct for forward/backward compatibility */
+
+	/* libbpf can retry BPF_PROG_LOAD command if bpf() syscall returns
+	 * -EAGAIN. This field determines how many attempts libbpf has to
+	 *  make. If not specified, libbpf will use default value of 5.
+	 */
+	int attempts;
+
+	enum bpf_attach_type expected_attach_type;
+	__u32 prog_btf_fd;
+	__u32 prog_flags;
+	__u32 prog_ifindex;
+	__u32 kern_version;
+
+	__u32 attach_btf_id;
+	__u32 attach_prog_fd;
+	__u32 attach_btf_obj_fd;
+
+	const int *fd_array;
+
+	/* .BTF.ext func info data */
+	const void *func_info;
+	__u32 func_info_cnt;
+	__u32 func_info_rec_size;
+
+	/* .BTF.ext line info data */
+	const void *line_info;
+	__u32 line_info_cnt;
+	__u32 line_info_rec_size;
+
+	/* verifier log options */
+	__u32 log_level;
+	__u32 log_size;
+	char *log_buf;
+};
+#define bpf_prog_load_opts__last_field log_buf
+
+LIBBPF_API int bpf_prog_load(enum bpf_prog_type prog_type,
+			     const char *prog_name, const char *license,
+			     const struct bpf_insn *insns, size_t insn_cnt,
+			     const struct bpf_prog_load_opts *opts);
+/* this "specialization" should go away in libbpf 1.0 */
+LIBBPF_API int bpf_prog_load_v0_6_0(enum bpf_prog_type prog_type,
+				    const char *prog_name, const char *license,
+				    const struct bpf_insn *insns, size_t insn_cnt,
+				    const struct bpf_prog_load_opts *opts);
+
+/* This is an elaborate way to not conflict with deprecated bpf_prog_load()
+ * API, defined in libbpf.h. Once we hit libbpf 1.0, all this will be gone.
+ * With this approach, if someone is calling bpf_prog_load() with
+ * 4 arguments, they will use the deprecated API, which keeps backwards
+ * compatibility (both source code and binary). If bpf_prog_load() is called
+ * with 6 arguments, though, it gets redirected to __bpf_prog_load.
+ * So looking forward to libbpf 1.0 when this hack will be gone and
+ * __bpf_prog_load() will be called just bpf_prog_load().
+ */
+#ifndef bpf_prog_load
+#define bpf_prog_load(...) ___libbpf_overload(___bpf_prog_load, __VA_ARGS__)
+#define ___bpf_prog_load4(file, type, pobj, prog_fd) \
+	bpf_prog_load_deprecated(file, type, pobj, prog_fd)
+#define ___bpf_prog_load6(prog_type, prog_name, license, insns, insn_cnt, opts) \
+	bpf_prog_load(prog_type, prog_name, license, insns, insn_cnt, opts)
+#endif /* bpf_prog_load */
+
 struct bpf_load_program_attr {
 	enum bpf_prog_type prog_type;
 	enum bpf_attach_type expected_attach_type;
@@ -133,13 +198,15 @@ struct bpf_load_program_attr {
 
 /* Recommend log buffer size */
 #define BPF_LOG_BUF_SIZE (UINT32_MAX >> 8) /* verifier maximum in kernels <= 5.1 */
-LIBBPF_API int
-bpf_load_program_xattr(const struct bpf_load_program_attr *load_attr,
-		       char *log_buf, size_t log_buf_sz);
+LIBBPF_DEPRECATED_SINCE(0, 7, "use bpf_prog_load() instead")
+LIBBPF_API int bpf_load_program_xattr(const struct bpf_load_program_attr *load_attr,
+				      char *log_buf, size_t log_buf_sz);
+LIBBPF_DEPRECATED_SINCE(0, 7, "use bpf_prog_load() instead")
 LIBBPF_API int bpf_load_program(enum bpf_prog_type type,
 				const struct bpf_insn *insns, size_t insns_cnt,
 				const char *license, __u32 kern_version,
 				char *log_buf, size_t log_buf_sz);
+LIBBPF_DEPRECATED_SINCE(0, 7, "use bpf_prog_load() instead")
 LIBBPF_API int bpf_verify_program(enum bpf_prog_type type,
 				  const struct bpf_insn *insns,
 				  size_t insns_cnt, __u32 prog_flags,
diff --git a/tools/lib/bpf/bpf_gen_internal.h b/tools/lib/bpf/bpf_gen_internal.h
index d26e5472fe50..75ca9fb857b2 100644
--- a/tools/lib/bpf/bpf_gen_internal.h
+++ b/tools/lib/bpf/bpf_gen_internal.h
@@ -3,6 +3,8 @@
 #ifndef __BPF_GEN_INTERNAL_H
 #define __BPF_GEN_INTERNAL_H
 
+#include "bpf.h"
+
 struct ksym_relo_desc {
 	const char *name;
 	int kind;
@@ -50,8 +52,10 @@ int bpf_gen__finish(struct bpf_gen *gen);
 void bpf_gen__free(struct bpf_gen *gen);
 void bpf_gen__load_btf(struct bpf_gen *gen, const void *raw_data, __u32 raw_size);
 void bpf_gen__map_create(struct bpf_gen *gen, struct bpf_create_map_params *map_attr, int map_idx);
-struct bpf_prog_load_params;
-void bpf_gen__prog_load(struct bpf_gen *gen, struct bpf_prog_load_params *load_attr, int prog_idx);
+void bpf_gen__prog_load(struct bpf_gen *gen,
+			enum bpf_prog_type prog_type, const char *prog_name,
+			const char *license, struct bpf_insn *insns, size_t insn_cnt,
+			struct bpf_prog_load_opts *load_attr, int prog_idx);
 void bpf_gen__map_update_elem(struct bpf_gen *gen, int map_idx, void *value, __u32 value_size);
 void bpf_gen__map_freeze(struct bpf_gen *gen, int map_idx);
 void bpf_gen__record_attach_target(struct bpf_gen *gen, const char *name, enum bpf_attach_type type);
diff --git a/tools/lib/bpf/gen_loader.c b/tools/lib/bpf/gen_loader.c
index 502dea53a742..203d88f5b512 100644
--- a/tools/lib/bpf/gen_loader.c
+++ b/tools/lib/bpf/gen_loader.c
@@ -900,27 +900,27 @@ static void cleanup_relos(struct bpf_gen *gen, int insns)
 }
 
 void bpf_gen__prog_load(struct bpf_gen *gen,
-			struct bpf_prog_load_params *load_attr, int prog_idx)
+			enum bpf_prog_type prog_type, const char *prog_name,
+			const char *license, struct bpf_insn *insns, size_t insn_cnt,
+			struct bpf_prog_load_opts *load_attr, int prog_idx)
 {
 	int attr_size = offsetofend(union bpf_attr, fd_array);
-	int prog_load_attr, license, insns, func_info, line_info;
+	int prog_load_attr, license_off, insns_off, func_info, line_info;
 	union bpf_attr attr;
 
 	memset(&attr, 0, attr_size);
-	pr_debug("gen: prog_load: type %d insns_cnt %zd\n",
-		 load_attr->prog_type, load_attr->insn_cnt);
+	pr_debug("gen: prog_load: type %d insns_cnt %zd\n", prog_type, insn_cnt);
 	/* add license string to blob of bytes */
-	license = add_data(gen, load_attr->license, strlen(load_attr->license) + 1);
+	license_off = add_data(gen, license, strlen(license) + 1);
 	/* add insns to blob of bytes */
-	insns = add_data(gen, load_attr->insns,
-			 load_attr->insn_cnt * sizeof(struct bpf_insn));
+	insns_off = add_data(gen, insns, insn_cnt * sizeof(struct bpf_insn));
 
-	attr.prog_type = load_attr->prog_type;
+	attr.prog_type = prog_type;
 	attr.expected_attach_type = load_attr->expected_attach_type;
 	attr.attach_btf_id = load_attr->attach_btf_id;
 	attr.prog_ifindex = load_attr->prog_ifindex;
 	attr.kern_version = 0;
-	attr.insn_cnt = (__u32)load_attr->insn_cnt;
+	attr.insn_cnt = (__u32)insn_cnt;
 	attr.prog_flags = load_attr->prog_flags;
 
 	attr.func_info_rec_size = load_attr->func_info_rec_size;
@@ -933,15 +933,15 @@ void bpf_gen__prog_load(struct bpf_gen *gen,
 	line_info = add_data(gen, load_attr->line_info,
 			     attr.line_info_cnt * attr.line_info_rec_size);
 
-	memcpy(attr.prog_name, load_attr->name,
-	       min((unsigned)strlen(load_attr->name), BPF_OBJ_NAME_LEN - 1));
+	memcpy(attr.prog_name, prog_name,
+	       min((unsigned)strlen(prog_name), BPF_OBJ_NAME_LEN - 1));
 	prog_load_attr = add_data(gen, &attr, attr_size);
 
 	/* populate union bpf_attr with a pointer to license */
-	emit_rel_store(gen, attr_field(prog_load_attr, license), license);
+	emit_rel_store(gen, attr_field(prog_load_attr, license), license_off);
 
 	/* populate union bpf_attr with a pointer to instructions */
-	emit_rel_store(gen, attr_field(prog_load_attr, insns), insns);
+	emit_rel_store(gen, attr_field(prog_load_attr, insns), insns_off);
 
 	/* populate union bpf_attr with a pointer to func_info */
 	emit_rel_store(gen, attr_field(prog_load_attr, func_info), func_info);
@@ -973,12 +973,12 @@ void bpf_gen__prog_load(struct bpf_gen *gen,
 		emit(gen, BPF_STX_MEM(BPF_W, BPF_REG_0, BPF_REG_7,
 				      offsetof(union bpf_attr, attach_btf_obj_fd)));
 	}
-	emit_relos(gen, insns);
+	emit_relos(gen, insns_off);
 	/* emit PROG_LOAD command */
 	emit_sys_bpf(gen, BPF_PROG_LOAD, prog_load_attr, attr_size);
 	debug_ret(gen, "prog_load %s insn_cnt %d", attr.prog_name, attr.insn_cnt);
 	/* successful or not, close btf module FDs used in extern ksyms and attach_btf_obj_fd */
-	cleanup_relos(gen, insns);
+	cleanup_relos(gen, insns_off);
 	if (gen->attach_kind)
 		emit_sys_close_blob(gen,
 				    attr_field(prog_load_attr, attach_btf_obj_fd));
diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 742d1a388179..902831b10216 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -221,7 +221,7 @@ struct reloc_desc {
 struct bpf_sec_def;
 
 typedef int (*init_fn_t)(struct bpf_program *prog, long cookie);
-typedef int (*preload_fn_t)(struct bpf_program *prog, struct bpf_prog_load_params *attr, long cookie);
+typedef int (*preload_fn_t)(struct bpf_program *prog, struct bpf_prog_load_opts *opts, long cookie);
 typedef struct bpf_link *(*attach_fn_t)(const struct bpf_program *prog, long cookie);
 
 /* stored as sec_def->cookie for all libbpf-supported SEC()s */
@@ -6374,16 +6374,16 @@ static int libbpf_find_attach_btf_id(struct bpf_program *prog, const char *attac
 
 /* this is called as prog->sec_def->preload_fn for libbpf-supported sec_defs */
 static int libbpf_preload_prog(struct bpf_program *prog,
-			       struct bpf_prog_load_params *attr, long cookie)
+			       struct bpf_prog_load_opts *opts, long cookie)
 {
 	enum sec_def_flags def = cookie;
 
 	/* old kernels might not support specifying expected_attach_type */
 	if ((def & SEC_EXP_ATTACH_OPT) && !kernel_supports(prog->obj, FEAT_EXP_ATTACH_TYPE))
-		attr->expected_attach_type = 0;
+		opts->expected_attach_type = 0;
 
 	if (def & SEC_SLEEPABLE)
-		attr->prog_flags |= BPF_F_SLEEPABLE;
+		opts->prog_flags |= BPF_F_SLEEPABLE;
 
 	if ((prog->type == BPF_PROG_TYPE_TRACING ||
 	     prog->type == BPF_PROG_TYPE_LSM ||
@@ -6402,11 +6402,11 @@ static int libbpf_preload_prog(struct bpf_program *prog,
 
 		/* but by now libbpf common logic is not utilizing
 		 * prog->atach_btf_obj_fd/prog->attach_btf_id anymore because
-		 * this callback is called after attrs were populated by
-		 * libbpf, so this callback has to update attr explicitly here
+		 * this callback is called after opts were populated by
+		 * libbpf, so this callback has to update opts explicitly here
 		 */
-		attr->attach_btf_obj_fd = btf_obj_fd;
-		attr->attach_btf_id = btf_type_id;
+		opts->attach_btf_obj_fd = btf_obj_fd;
+		opts->attach_btf_id = btf_type_id;
 	}
 	return 0;
 }
@@ -6415,8 +6415,9 @@ static int
 load_program(struct bpf_program *prog, struct bpf_insn *insns, int insns_cnt,
 	     char *license, __u32 kern_version, int *pfd)
 {
-	struct bpf_prog_load_params load_attr = {};
+	LIBBPF_OPTS(bpf_prog_load_opts, load_attr);
 	struct bpf_object *obj = prog->obj;
+	const char *prog_name = NULL;
 	char *cp, errmsg[STRERR_BUFSIZE];
 	size_t log_buf_size = 0;
 	char *log_buf = NULL;
@@ -6435,13 +6436,9 @@ load_program(struct bpf_program *prog, struct bpf_insn *insns, int insns_cnt,
 	if (!insns || !insns_cnt)
 		return -EINVAL;
 
-	load_attr.prog_type = prog->type;
 	load_attr.expected_attach_type = prog->expected_attach_type;
 	if (kernel_supports(obj, FEAT_PROG_NAME))
-		load_attr.name = prog->name;
-	load_attr.insns = insns;
-	load_attr.insn_cnt = insns_cnt;
-	load_attr.license = license;
+		prog_name = prog->name;
 	load_attr.attach_btf_id = prog->attach_btf_id;
 	load_attr.attach_prog_fd = prog->attach_prog_fd;
 	load_attr.attach_btf_obj_fd = prog->attach_btf_obj_fd;
@@ -6475,7 +6472,8 @@ load_program(struct bpf_program *prog, struct bpf_insn *insns, int insns_cnt,
 	}
 
 	if (obj->gen_loader) {
-		bpf_gen__prog_load(obj->gen_loader, &load_attr,
+		bpf_gen__prog_load(obj->gen_loader, prog->type, prog->name,
+				   license, insns, insns_cnt, &load_attr,
 				   prog - obj->programs);
 		*pfd = -1;
 		return 0;
@@ -6490,8 +6488,8 @@ load_program(struct bpf_program *prog, struct bpf_insn *insns, int insns_cnt,
 	}
 
 	load_attr.log_buf = log_buf;
-	load_attr.log_buf_sz = log_buf_size;
-	ret = libbpf__bpf_prog_load(&load_attr);
+	load_attr.log_size = log_buf_size;
+	ret = bpf_prog_load(prog->type, prog_name, license, insns, insns_cnt, &load_attr);
 
 	if (ret >= 0) {
 		if (log_buf && load_attr.log_level)
@@ -6537,19 +6535,19 @@ load_program(struct bpf_program *prog, struct bpf_insn *insns, int insns_cnt,
 		pr_warn("-- BEGIN DUMP LOG ---\n");
 		pr_warn("\n%s\n", log_buf);
 		pr_warn("-- END LOG --\n");
-	} else if (load_attr.insn_cnt >= BPF_MAXINSNS) {
-		pr_warn("Program too large (%zu insns), at most %d insns\n",
-			load_attr.insn_cnt, BPF_MAXINSNS);
+	} else if (insns_cnt >= BPF_MAXINSNS) {
+		pr_warn("Program too large (%d insns), at most %d insns\n",
+			insns_cnt, BPF_MAXINSNS);
 		ret = -LIBBPF_ERRNO__PROG2BIG;
-	} else if (load_attr.prog_type != BPF_PROG_TYPE_KPROBE) {
+	} else if (prog->type != BPF_PROG_TYPE_KPROBE) {
 		/* Wrong program type? */
 		int fd;
 
-		load_attr.prog_type = BPF_PROG_TYPE_KPROBE;
 		load_attr.expected_attach_type = 0;
 		load_attr.log_buf = NULL;
-		load_attr.log_buf_sz = 0;
-		fd = libbpf__bpf_prog_load(&load_attr);
+		load_attr.log_size = 0;
+		fd = bpf_prog_load(BPF_PROG_TYPE_KPROBE, prog_name, license,
+				   insns, insns_cnt, &load_attr);
 		if (fd >= 0) {
 			close(fd);
 			ret = -LIBBPF_ERRNO__PROGTYPE;
@@ -9144,8 +9142,9 @@ long libbpf_get_error(const void *ptr)
 	return -errno;
 }
 
-int bpf_prog_load(const char *file, enum bpf_prog_type type,
-		  struct bpf_object **pobj, int *prog_fd)
+COMPAT_VERSION(bpf_prog_load_deprecated, bpf_prog_load, LIBBPF_0.0.1)
+int bpf_prog_load_deprecated(const char *file, enum bpf_prog_type type,
+			     struct bpf_object **pobj, int *prog_fd)
 {
 	struct bpf_prog_load_attr attr;
 
diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index 9de0f299706b..2e4f0dcd8da6 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -676,8 +676,9 @@ struct bpf_prog_load_attr {
 
 LIBBPF_API int bpf_prog_load_xattr(const struct bpf_prog_load_attr *attr,
 				   struct bpf_object **pobj, int *prog_fd);
-LIBBPF_API int bpf_prog_load(const char *file, enum bpf_prog_type type,
-			     struct bpf_object **pobj, int *prog_fd);
+LIBBPF_DEPRECATED_SINCE(0, 7, "use bpf_object__open() and bpf_object__load() instead")
+LIBBPF_API int bpf_prog_load_deprecated(const char *file, enum bpf_prog_type type,
+					struct bpf_object **pobj, int *prog_fd);
 
 /* XDP related API */
 struct xdp_link_info {
diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
index 43580eb47740..b895861a13c0 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -395,6 +395,8 @@ LIBBPF_0.6.0 {
 		bpf_object__next_program;
 		bpf_object__prev_map;
 		bpf_object__prev_program;
+		bpf_prog_load_deprecated;
+		bpf_prog_load;
 		bpf_program__insn_cnt;
 		bpf_program__insns;
 		btf__add_btf;
diff --git a/tools/lib/bpf/libbpf_common.h b/tools/lib/bpf/libbpf_common.h
index 0967112b933a..b21cefc9c3b6 100644
--- a/tools/lib/bpf/libbpf_common.h
+++ b/tools/lib/bpf/libbpf_common.h
@@ -41,6 +41,18 @@
 #define __LIBBPF_MARK_DEPRECATED_0_7(X)
 #endif
 
+/* This set of internal macros allows to do "function overloading" based on
+ * number of arguments provided by used in backwards-compatible way during the
+ * transition to libbpf 1.0
+ * It's ugly but necessary evil that will be cleaned up when we get to 1.0.
+ * See bpf_prog_load() overload for example.
+ */
+#define ___libbpf_cat(A, B) A ## B
+#define ___libbpf_select(NAME, NUM) ___libbpf_cat(NAME, NUM)
+#define ___libbpf_nth(_1, _2, _3, _4, _5, _6, N, ...) N
+#define ___libbpf_cnt(...) ___libbpf_nth(__VA_ARGS__, 6, 5, 4, 3, 2, 1)
+#define ___libbpf_overload(NAME, ...) ___libbpf_select(NAME, ___libbpf_cnt(__VA_ARGS__))(__VA_ARGS__)
+
 /* Helper macro to declare and initialize libbpf options struct
  *
  * This dance with uninitialized declaration, followed by memset to zero,
diff --git a/tools/lib/bpf/libbpf_internal.h b/tools/lib/bpf/libbpf_internal.h
index aeb79e3a8ff9..c1e34794b829 100644
--- a/tools/lib/bpf/libbpf_internal.h
+++ b/tools/lib/bpf/libbpf_internal.h
@@ -276,37 +276,6 @@ int parse_cpu_mask_file(const char *fcpu, bool **mask, int *mask_sz);
 int libbpf__load_raw_btf(const char *raw_types, size_t types_len,
 			 const char *str_sec, size_t str_len);
 
-struct bpf_prog_load_params {
-	enum bpf_prog_type prog_type;
-	enum bpf_attach_type expected_attach_type;
-	const char *name;
-	const struct bpf_insn *insns;
-	size_t insn_cnt;
-	const char *license;
-	__u32 kern_version;
-	__u32 attach_prog_fd;
-	__u32 attach_btf_obj_fd;
-	__u32 attach_btf_id;
-	__u32 prog_ifindex;
-	__u32 prog_btf_fd;
-	__u32 prog_flags;
-
-	__u32 func_info_rec_size;
-	const void *func_info;
-	__u32 func_info_cnt;
-
-	__u32 line_info_rec_size;
-	const void *line_info;
-	__u32 line_info_cnt;
-
-	__u32 log_level;
-	char *log_buf;
-	size_t log_buf_sz;
-	int *fd_array;
-};
-
-int libbpf__bpf_prog_load(const struct bpf_prog_load_params *load_attr);
-
 struct bpf_create_map_params {
 	const char *name;
 	enum bpf_map_type map_type;
diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index f49cb5fc85af..43e5e5182317 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -24,7 +24,7 @@ SAN_CFLAGS	?=
 CFLAGS += -g -O0 -rdynamic -Wall $(GENFLAGS) $(SAN_CFLAGS)		\
 	  -I$(CURDIR) -I$(INCLUDE_DIR) -I$(GENDIR) -I$(LIBDIR)		\
 	  -I$(TOOLSINCDIR) -I$(APIDIR) -I$(OUTPUT)			\
-	  -Dbpf_prog_load=bpf_prog_test_load				\
+	  -Dbpf_prog_load_deprecated=bpf_prog_test_load			\
 	  -Dbpf_load_program=bpf_test_load_program
 LDLIBS += -lcap -lelf -lz -lrt -lpthread
 
-- 
2.30.2

