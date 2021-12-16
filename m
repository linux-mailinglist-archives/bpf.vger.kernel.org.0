Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47727476AC6
	for <lists+bpf@lfdr.de>; Thu, 16 Dec 2021 08:05:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231792AbhLPHFa convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Thu, 16 Dec 2021 02:05:30 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:3248 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231839AbhLPHF3 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 16 Dec 2021 02:05:29 -0500
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1BG4A4nw025368
        for <bpf@vger.kernel.org>; Wed, 15 Dec 2021 23:05:28 -0800
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3cyvcyh78c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 15 Dec 2021 23:05:28 -0800
Received: from intmgw003.48.prn1.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 15 Dec 2021 23:04:56 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 4599ED51C030; Wed, 15 Dec 2021 23:04:45 -0800 (PST)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>,
        Dave Marchevsky <davemarchevsky@fb.com>,
        Julia Kartseva <hex@fb.com>
Subject: [PATCH bpf-next 1/3] libbpf: rework feature-probing APIs
Date:   Wed, 15 Dec 2021 23:04:40 -0800
Message-ID: <20211216070442.1492204-2-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211216070442.1492204-1-andrii@kernel.org>
References: <20211216070442.1492204-1-andrii@kernel.org>
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-ORIG-GUID: fu01jJQNMInFY2rWv31zXzwOwjJF1SHu
X-Proofpoint-GUID: fu01jJQNMInFY2rWv31zXzwOwjJF1SHu
Content-Transfer-Encoding: 8BIT
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-16_02,2021-12-14_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 impostorscore=0
 clxscore=1015 mlxlogscore=999 lowpriorityscore=0 mlxscore=0 suspectscore=0
 priorityscore=1501 bulkscore=0 phishscore=0 spamscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112160040
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Create three extensible alternatives to inconsistently named
feature-probing APIs:
  - libbpf_probe_bpf_prog_type() instead of bpf_probe_prog_type();
  - libbpf_probe_bpf_map_type() instead of bpf_probe_map_type();
  - libbpf_probe_bpf_helper() instead of bpf_probe_helper().

Set up return values such that libbpf can report errors (e.g., if some
combination of input arguments isn't possible to validate, etc), in
addition to whether the feature is supported (return value 1) or not
supported (return value 0).

Also schedule deprecation of those three APIs. Also schedule deprecation
of bpf_probe_large_insn_limit().

Also fix all the existing detection logic for various program and map
types that never worked:
  - BPF_PROG_TYPE_LIRC_MODE2;
  - BPF_PROG_TYPE_TRACING;
  - BPF_PROG_TYPE_LSM;
  - BPF_PROG_TYPE_EXT;
  - BPF_PROG_TYPE_SYSCALL;
  - BPF_PROG_TYPE_STRUCT_OPS;
  - BPF_MAP_TYPE_STRUCT_OPS;
  - BPF_MAP_TYPE_BLOOM_FILTER.

Above prog/map types needed special setups and detection logic to work.
Subsequent patch adds selftests that will make sure that all the
detection logic keeps working for all current and future program and map
types, avoiding otherwise inevitable bit rot.

  [0] Closes: https://github.com/libbpf/libbpf/issues/312

Cc: Dave Marchevsky <davemarchevsky@fb.com>
Cc: Julia Kartseva <hex@fb.com>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/libbpf.h        |  52 +++++++-
 tools/lib/bpf/libbpf.map      |   3 +
 tools/lib/bpf/libbpf_probes.c | 235 ++++++++++++++++++++++++++--------
 3 files changed, 236 insertions(+), 54 deletions(-)

diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index 42b2f36fd9f0..85dfef88b3d2 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -1052,13 +1052,57 @@ bpf_prog_linfo__lfind(const struct bpf_prog_linfo *prog_linfo,
  * user, causing subsequent probes to fail. In this case, the caller may want
  * to adjust that limit with setrlimit().
  */
-LIBBPF_API bool bpf_probe_prog_type(enum bpf_prog_type prog_type,
-				    __u32 ifindex);
+LIBBPF_DEPRECATED_SINCE(0, 8, "use libbpf_probe_bpf_prog_type() instead")
+LIBBPF_API bool bpf_probe_prog_type(enum bpf_prog_type prog_type, __u32 ifindex);
+LIBBPF_DEPRECATED_SINCE(0, 8, "use libbpf_probe_bpf_map_type() instead")
 LIBBPF_API bool bpf_probe_map_type(enum bpf_map_type map_type, __u32 ifindex);
-LIBBPF_API bool bpf_probe_helper(enum bpf_func_id id,
-				 enum bpf_prog_type prog_type, __u32 ifindex);
+LIBBPF_DEPRECATED_SINCE(0, 8, "use libbpf_probe_bpf_helper() instead")
+LIBBPF_API bool bpf_probe_helper(enum bpf_func_id id, enum bpf_prog_type prog_type, __u32 ifindex);
+LIBBPF_DEPRECATED_SINCE(0, 8, "implement your own or use bpftool for feature detection")
 LIBBPF_API bool bpf_probe_large_insn_limit(__u32 ifindex);
 
+/**
+ * @brief **libbpf_probe_bpf_prog_type()** detects if host kernel supports
+ * BPF programs of a given type.
+ * @param prog_type BPF program type to detect kernel support for
+ * @param opts reserved for future extensibility, should be NULL
+ * @return 1, if given program type is supported; 0, if given program type is
+ * not supported; negative error code if feature detection failed or can't be
+ * performed
+ *
+ * Make sure the process has required set of CAP_* permissions (or runs as
+ * root) when performing feature checking.
+ */
+LIBBPF_API int libbpf_probe_bpf_prog_type(enum bpf_prog_type prog_type, const void *opts);
+/**
+ * @brief **libbpf_probe_bpf_map_type()** detects if host kernel supports
+ * BPF maps of a given type.
+ * @param map_type BPF map type to detect kernel support for
+ * @param opts reserved for future extensibility, should be NULL
+ * @return 1, if given map type is supported; 0, if given map type is
+ * not supported; negative error code if feature detection failed or can't be
+ * performed
+ *
+ * Make sure the process has required set of CAP_* permissions (or runs as
+ * root) when performing feature checking.
+ */
+LIBBPF_API int libbpf_probe_bpf_map_type(enum bpf_map_type map_type, const void *opts);
+/**
+ * @brief **libbpf_probe_bpf_helper()** detects if host kernel supports the
+ * use of a given BPF helper from specified BPF program type.
+ * @param prog_type BPF program type used to check the support of BPF helper
+ * @param helper_id BPF helper ID (enum bpf_func_id) to check support for
+ * @param opts reserved for future extensibility, should be NULL
+ * @return 1, if given combination of program type and helper is supported; 0,
+ * if the combination is not supported; negative error code if feature
+ * detection for provided input arguments failed or can't be performed
+ *
+ * Make sure the process has required set of CAP_* permissions (or runs as
+ * root) when performing feature checking.
+ */
+LIBBPF_API int libbpf_probe_bpf_helper(enum bpf_prog_type prog_type,
+				       enum bpf_func_id helper_id, const void *opts);
+
 /*
  * Get bpf_prog_info in continuous memory
  *
diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
index b3938b3f8fc9..529783967793 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -427,5 +427,8 @@ LIBBPF_0.7.0 {
 		bpf_program__log_level;
 		bpf_program__set_log_buf;
 		bpf_program__set_log_level;
+		libbpf_probe_bpf_helper;
+		libbpf_probe_bpf_map_type;
+		libbpf_probe_bpf_prog_type;
 		libbpf_set_memlock_rlim_max;
 };
diff --git a/tools/lib/bpf/libbpf_probes.c b/tools/lib/bpf/libbpf_probes.c
index 4bdec69523a7..65232bcaa84c 100644
--- a/tools/lib/bpf/libbpf_probes.c
+++ b/tools/lib/bpf/libbpf_probes.c
@@ -64,12 +64,20 @@ static int get_kernel_version(void)
 	return (version << 16) + (subversion << 8) + patchlevel;
 }
 
-static void
-probe_load(enum bpf_prog_type prog_type, const struct bpf_insn *insns,
-	   size_t insns_cnt, char *buf, size_t buf_len, __u32 ifindex)
+static int probe_prog_load(enum bpf_prog_type prog_type,
+			   const struct bpf_insn *insns, size_t insns_cnt,
+			   char *log_buf, size_t log_buf_sz,
+			   __u32 ifindex)
 {
-	LIBBPF_OPTS(bpf_prog_load_opts, opts);
-	int fd;
+	LIBBPF_OPTS(bpf_prog_load_opts, opts,
+		.log_buf = log_buf,
+		.log_size = log_buf_sz,
+		.log_level = log_buf ? 1 : 0,
+		.prog_ifindex = ifindex,
+	);
+	int fd, err, exp_err = 0;
+	const char *exp_msg = NULL;
+	char buf[4096];
 
 	switch (prog_type) {
 	case BPF_PROG_TYPE_CGROUP_SOCK_ADDR:
@@ -84,6 +92,38 @@ probe_load(enum bpf_prog_type prog_type, const struct bpf_insn *insns,
 	case BPF_PROG_TYPE_KPROBE:
 		opts.kern_version = get_kernel_version();
 		break;
+	case BPF_PROG_TYPE_LIRC_MODE2:
+		opts.expected_attach_type = BPF_LIRC_MODE2;
+		break;
+	case BPF_PROG_TYPE_TRACING:
+	case BPF_PROG_TYPE_LSM:
+		opts.log_buf = buf;
+		opts.log_size = sizeof(buf);
+		opts.log_level = 1;
+		if (prog_type == BPF_PROG_TYPE_TRACING)
+			opts.expected_attach_type = BPF_TRACE_FENTRY;
+		else
+			opts.expected_attach_type = BPF_MODIFY_RETURN;
+		opts.attach_btf_id = 1;
+
+		exp_err = -EINVAL;
+		exp_msg = "attach_btf_id 1 is not a function";
+		break;
+	case BPF_PROG_TYPE_EXT:
+		opts.log_buf = buf;
+		opts.log_size = sizeof(buf);
+		opts.log_level = 1;
+		opts.attach_btf_id = 1;
+
+		exp_err = -EINVAL;
+		exp_msg = "Cannot replace kernel functions";
+		break;
+	case BPF_PROG_TYPE_SYSCALL:
+		opts.prog_flags = BPF_F_SLEEPABLE;
+		break;
+	case BPF_PROG_TYPE_STRUCT_OPS:
+		exp_err = -524; /* -EOPNOTSUPP */
+		break;
 	case BPF_PROG_TYPE_UNSPEC:
 	case BPF_PROG_TYPE_SOCKET_FILTER:
 	case BPF_PROG_TYPE_SCHED_CLS:
@@ -103,25 +143,42 @@ probe_load(enum bpf_prog_type prog_type, const struct bpf_insn *insns,
 	case BPF_PROG_TYPE_RAW_TRACEPOINT:
 	case BPF_PROG_TYPE_RAW_TRACEPOINT_WRITABLE:
 	case BPF_PROG_TYPE_LWT_SEG6LOCAL:
-	case BPF_PROG_TYPE_LIRC_MODE2:
 	case BPF_PROG_TYPE_SK_REUSEPORT:
 	case BPF_PROG_TYPE_FLOW_DISSECTOR:
 	case BPF_PROG_TYPE_CGROUP_SYSCTL:
-	case BPF_PROG_TYPE_TRACING:
-	case BPF_PROG_TYPE_STRUCT_OPS:
-	case BPF_PROG_TYPE_EXT:
-	case BPF_PROG_TYPE_LSM:
-	default:
 		break;
+	default:
+		return -EOPNOTSUPP;
 	}
 
-	opts.prog_ifindex = ifindex;
-	opts.log_buf = buf;
-	opts.log_size = buf_len;
-
-	fd = bpf_prog_load(prog_type, NULL, "GPL", insns, insns_cnt, NULL);
+	fd = bpf_prog_load(prog_type, NULL, "GPL", insns, insns_cnt, &opts);
+	err = -errno;
 	if (fd >= 0)
 		close(fd);
+	if (exp_err) {
+		if (fd >= 0 || err != exp_err)
+			return 0;
+		if (exp_msg && !strstr(buf, exp_msg))
+			return 0;
+		return 1;
+	}
+	return fd >= 0 ? 1 : 0;
+}
+
+int libbpf_probe_bpf_prog_type(enum bpf_prog_type prog_type, const void *opts)
+{
+	struct bpf_insn insns[] = {
+		BPF_MOV64_IMM(BPF_REG_0, 0),
+		BPF_EXIT_INSN()
+	};
+	const size_t insn_cnt = ARRAY_SIZE(insns);
+	int ret;
+
+	if (opts)
+		return libbpf_err(-EINVAL);
+
+	ret = probe_prog_load(prog_type, insns, insn_cnt, NULL, 0, 0);
+	return libbpf_err(ret);
 }
 
 bool bpf_probe_prog_type(enum bpf_prog_type prog_type, __u32 ifindex)
@@ -131,12 +188,16 @@ bool bpf_probe_prog_type(enum bpf_prog_type prog_type, __u32 ifindex)
 		BPF_EXIT_INSN()
 	};
 
+	/* prefer libbpf_probe_bpf_prog_type() unless offload is requested */
+	if (ifindex == 0)
+		return libbpf_probe_bpf_prog_type(prog_type, NULL) == 1;
+
 	if (ifindex && prog_type == BPF_PROG_TYPE_SCHED_CLS)
 		/* nfp returns -EINVAL on exit(0) with TC offload */
 		insns[0].imm = 2;
 
 	errno = 0;
-	probe_load(prog_type, insns, ARRAY_SIZE(insns), NULL, 0, ifindex);
+	probe_prog_load(prog_type, insns, ARRAY_SIZE(insns), NULL, 0, ifindex);
 
 	return errno != EINVAL && errno != EOPNOTSUPP;
 }
@@ -197,16 +258,18 @@ static int load_local_storage_btf(void)
 				     strs, sizeof(strs));
 }
 
-bool bpf_probe_map_type(enum bpf_map_type map_type, __u32 ifindex)
+static int probe_map_create(enum bpf_map_type map_type, __u32 ifindex)
 {
-	int key_size, value_size, max_entries, map_flags;
+	LIBBPF_OPTS(bpf_map_create_opts, opts);
+	int key_size, value_size, max_entries;
 	__u32 btf_key_type_id = 0, btf_value_type_id = 0;
-	int fd = -1, btf_fd = -1, fd_inner;
+	int fd = -1, btf_fd = -1, fd_inner = -1, exp_err = 0, err;
+
+	opts.map_ifindex = ifindex;
 
 	key_size	= sizeof(__u32);
 	value_size	= sizeof(__u32);
 	max_entries	= 1;
-	map_flags	= 0;
 
 	switch (map_type) {
 	case BPF_MAP_TYPE_STACK_TRACE:
@@ -215,7 +278,7 @@ bool bpf_probe_map_type(enum bpf_map_type map_type, __u32 ifindex)
 	case BPF_MAP_TYPE_LPM_TRIE:
 		key_size	= sizeof(__u64);
 		value_size	= sizeof(__u64);
-		map_flags	= BPF_F_NO_PREALLOC;
+		opts.map_flags	= BPF_F_NO_PREALLOC;
 		break;
 	case BPF_MAP_TYPE_CGROUP_STORAGE:
 	case BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE:
@@ -234,17 +297,25 @@ bool bpf_probe_map_type(enum bpf_map_type map_type, __u32 ifindex)
 		btf_value_type_id = 3;
 		value_size = 8;
 		max_entries = 0;
-		map_flags = BPF_F_NO_PREALLOC;
+		opts.map_flags = BPF_F_NO_PREALLOC;
 		btf_fd = load_local_storage_btf();
 		if (btf_fd < 0)
-			return false;
+			return btf_fd;
 		break;
 	case BPF_MAP_TYPE_RINGBUF:
 		key_size = 0;
 		value_size = 0;
 		max_entries = 4096;
 		break;
-	case BPF_MAP_TYPE_UNSPEC:
+	case BPF_MAP_TYPE_STRUCT_OPS:
+		/* we'll get -ENOTSUPP for invalid BTF type ID for struct_ops */
+		opts.btf_vmlinux_value_type_id = 1;
+		exp_err = -524; /* -ENOTSUPP */
+		break;
+	case BPF_MAP_TYPE_BLOOM_FILTER:
+		key_size = 0;
+		max_entries = 1;
+		break;
 	case BPF_MAP_TYPE_HASH:
 	case BPF_MAP_TYPE_ARRAY:
 	case BPF_MAP_TYPE_PROG_ARRAY:
@@ -263,49 +334,114 @@ bool bpf_probe_map_type(enum bpf_map_type map_type, __u32 ifindex)
 	case BPF_MAP_TYPE_XSKMAP:
 	case BPF_MAP_TYPE_SOCKHASH:
 	case BPF_MAP_TYPE_REUSEPORT_SOCKARRAY:
-	case BPF_MAP_TYPE_STRUCT_OPS:
-	default:
 		break;
+	case BPF_MAP_TYPE_UNSPEC:
+	default:
+		return -EOPNOTSUPP;
 	}
 
 	if (map_type == BPF_MAP_TYPE_ARRAY_OF_MAPS ||
 	    map_type == BPF_MAP_TYPE_HASH_OF_MAPS) {
-		LIBBPF_OPTS(bpf_map_create_opts, opts);
-
 		/* TODO: probe for device, once libbpf has a function to create
 		 * map-in-map for offload
 		 */
 		if (ifindex)
-			return false;
+			goto cleanup;
 
 		fd_inner = bpf_map_create(BPF_MAP_TYPE_HASH, NULL,
 					  sizeof(__u32), sizeof(__u32), 1, NULL);
 		if (fd_inner < 0)
-			return false;
+			goto cleanup;
 
 		opts.inner_map_fd = fd_inner;
-		fd = bpf_map_create(map_type, NULL, sizeof(__u32), sizeof(__u32), 1, &opts);
-		close(fd_inner);
-	} else {
-		LIBBPF_OPTS(bpf_map_create_opts, opts);
-
-		/* Note: No other restriction on map type probes for offload */
-		opts.map_flags = map_flags;
-		opts.map_ifindex = ifindex;
-		if (btf_fd >= 0) {
-			opts.btf_fd = btf_fd;
-			opts.btf_key_type_id = btf_key_type_id;
-			opts.btf_value_type_id = btf_value_type_id;
-		}
+	}
 
-		fd = bpf_map_create(map_type, NULL, key_size, value_size, max_entries, &opts);
+	if (btf_fd >= 0) {
+		opts.btf_fd = btf_fd;
+		opts.btf_key_type_id = btf_key_type_id;
+		opts.btf_value_type_id = btf_value_type_id;
 	}
+
+	fd = bpf_map_create(map_type, NULL, key_size, value_size, max_entries, &opts);
+	err = -errno;
+
+cleanup:
 	if (fd >= 0)
 		close(fd);
+	if (fd_inner >= 0)
+		close(fd_inner);
 	if (btf_fd >= 0)
 		close(btf_fd);
 
-	return fd >= 0;
+	if (exp_err)
+		return fd < 0 && err == exp_err ? 1 : 0;
+	else
+		return fd >= 0 ? 1 : 0;
+}
+
+int libbpf_probe_bpf_map_type(enum bpf_map_type map_type, const void *opts)
+{
+	int ret;
+
+	if (opts)
+		return libbpf_err(-EINVAL);
+
+	ret = probe_map_create(map_type, 0);
+	return libbpf_err(ret);
+}
+
+bool bpf_probe_map_type(enum bpf_map_type map_type, __u32 ifindex)
+{
+	return probe_map_create(map_type, ifindex) == 1;
+}
+
+int libbpf_probe_bpf_helper(enum bpf_prog_type prog_type, enum bpf_func_id helper_id,
+			    const void *opts)
+{
+	struct bpf_insn insns[] = {
+		BPF_EMIT_CALL((__u32)helper_id),
+		BPF_EXIT_INSN(),
+	};
+	const size_t insn_cnt = ARRAY_SIZE(insns);
+	char buf[4096];
+	int ret;
+
+	if (opts)
+		return libbpf_err(-EINVAL);
+
+	/* we can't successfully load all prog types to check for BPF helper
+	 * support, so bail out with -EOPNOTSUPP error
+	 */
+	switch (prog_type) {
+	case BPF_PROG_TYPE_TRACING:
+	case BPF_PROG_TYPE_EXT:
+	case BPF_PROG_TYPE_LSM:
+	case BPF_PROG_TYPE_STRUCT_OPS:
+		return -EOPNOTSUPP;
+	default:
+		break;
+	}
+
+	buf[0] = '\0';
+	ret = probe_prog_load(prog_type, insns, insn_cnt, buf, sizeof(buf), 0);
+	if (ret < 0)
+		return libbpf_err(ret);
+
+	/* If BPF verifier doesn't recognize BPF helper ID (enum bpf_func_id)
+	 * at all, it will emit something like "invalid func unknown#181".
+	 * If BPF verifier recognizes BPF helper but it's not supported for
+	 * given BPF program type, it will emit "unknown func bpf_sys_bpf#166".
+	 * In both cases, provided combination of BPF program type and BPF
+	 * helper is not supported by the kernel.
+	 * In all other cases, probe_prog_load() above will either succeed (e.g.,
+	 * because BPF helper happens to accept no input arguments or it
+	 * accepts one input argument and initial PTR_TO_CTX is fine for
+	 * that), or we'll get some more specific BPF verifier error about
+	 * some unsatisfied conditions.
+	 */
+	if (ret == 0 && (strstr(buf, "invalid func ") || strstr(buf, "unknown func ")))
+		return 0;
+	return 1; /* assume supported */
 }
 
 bool bpf_probe_helper(enum bpf_func_id id, enum bpf_prog_type prog_type,
@@ -318,8 +454,7 @@ bool bpf_probe_helper(enum bpf_func_id id, enum bpf_prog_type prog_type,
 	char buf[4096] = {};
 	bool res;
 
-	probe_load(prog_type, insns, ARRAY_SIZE(insns), buf, sizeof(buf),
-		   ifindex);
+	probe_prog_load(prog_type, insns, ARRAY_SIZE(insns), buf, sizeof(buf), ifindex);
 	res = !grep(buf, "invalid func ") && !grep(buf, "unknown func ");
 
 	if (ifindex) {
@@ -351,8 +486,8 @@ bool bpf_probe_large_insn_limit(__u32 ifindex)
 	insns[BPF_MAXINSNS] = BPF_EXIT_INSN();
 
 	errno = 0;
-	probe_load(BPF_PROG_TYPE_SCHED_CLS, insns, ARRAY_SIZE(insns), NULL, 0,
-		   ifindex);
+	probe_prog_load(BPF_PROG_TYPE_SCHED_CLS, insns, ARRAY_SIZE(insns), NULL, 0,
+			ifindex);
 
 	return errno != E2BIG && errno != EINVAL;
 }
-- 
2.30.2

