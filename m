Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77F59444AAC
	for <lists+bpf@lfdr.de>; Wed,  3 Nov 2021 23:09:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230310AbhKCWLp convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Wed, 3 Nov 2021 18:11:45 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:10368 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S230343AbhKCWLo (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 3 Nov 2021 18:11:44 -0400
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.1.2/8.16.1.2) with SMTP id 1A3KAeB5017257
        for <bpf@vger.kernel.org>; Wed, 3 Nov 2021 15:09:07 -0700
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0001303.ppops.net with ESMTP id 3c3dcf0qew-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 03 Nov 2021 15:09:07 -0700
Received: from intmgw001.37.frc1.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:11d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Wed, 3 Nov 2021 15:09:03 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id CA54F7D65E4E; Wed,  3 Nov 2021 15:08:55 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>,
        Hengqi Chen <hengqi.chen@gmail.com>
Subject: [PATCH v2 bpf-next 04/12] libbpf: remove internal use of deprecated bpf_prog_load() variants
Date:   Wed, 3 Nov 2021 15:08:37 -0700
Message-ID: <20211103220845.2676888-5-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211103220845.2676888-1-andrii@kernel.org>
References: <20211103220845.2676888-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-GUID: 82sIq8L7pjskJyk8UG9c2Wok3Gb51LOG
X-Proofpoint-ORIG-GUID: 82sIq8L7pjskJyk8UG9c2Wok3Gb51LOG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-03_06,2021-11-03_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 malwarescore=0 spamscore=0 priorityscore=1501 phishscore=0 bulkscore=0
 mlxlogscore=999 suspectscore=0 clxscore=1015 adultscore=0 mlxscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111030116
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Remove all the internal uses of bpf_load_program_xattr(), which is
slated for deprecation in v0.7.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/bpf.c           |   8 ++-
 tools/lib/bpf/libbpf.c        | 119 +++++++++++-----------------------
 tools/lib/bpf/libbpf_probes.c |  20 +++---
 tools/lib/bpf/xsk.c           |  34 ++++------
 4 files changed, 64 insertions(+), 117 deletions(-)

diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
index 8f2a701cb079..4ff45749f8cf 100644
--- a/tools/lib/bpf/bpf.c
+++ b/tools/lib/bpf/bpf.c
@@ -401,8 +401,12 @@ int bpf_prog_load_v0_6_0(enum bpf_prog_type prog_type,
 	return libbpf_err_errno(fd);
 }
 
+__attribute__((alias("bpf_load_program_xattr2")))
 int bpf_load_program_xattr(const struct bpf_load_program_attr *load_attr,
-			   char *log_buf, size_t log_buf_sz)
+			   char *log_buf, size_t log_buf_sz);
+
+static int bpf_load_program_xattr2(const struct bpf_load_program_attr *load_attr,
+				   char *log_buf, size_t log_buf_sz)
 {
 	LIBBPF_OPTS(bpf_prog_load_opts, p);
 
@@ -456,7 +460,7 @@ int bpf_load_program(enum bpf_prog_type type, const struct bpf_insn *insns,
 	load_attr.license = license;
 	load_attr.kern_version = kern_version;
 
-	return bpf_load_program_xattr(&load_attr, log_buf, log_buf_sz);
+	return bpf_load_program_xattr2(&load_attr, log_buf, log_buf_sz);
 }
 
 int bpf_verify_program(enum bpf_prog_type type, const struct bpf_insn *insns,
diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 7a82b81b8859..5751cade0f66 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -4282,30 +4282,20 @@ int bpf_map__resize(struct bpf_map *map, __u32 max_entries)
 static int
 bpf_object__probe_loading(struct bpf_object *obj)
 {
-	struct bpf_load_program_attr attr;
 	char *cp, errmsg[STRERR_BUFSIZE];
 	struct bpf_insn insns[] = {
 		BPF_MOV64_IMM(BPF_REG_0, 0),
 		BPF_EXIT_INSN(),
 	};
-	int ret;
+	int ret, insn_cnt = ARRAY_SIZE(insns);
 
 	if (obj->gen_loader)
 		return 0;
 
 	/* make sure basic loading works */
-
-	memset(&attr, 0, sizeof(attr));
-	attr.prog_type = BPF_PROG_TYPE_SOCKET_FILTER;
-	attr.insns = insns;
-	attr.insns_cnt = ARRAY_SIZE(insns);
-	attr.license = "GPL";
-
-	ret = bpf_load_program_xattr(&attr, NULL, 0);
-	if (ret < 0) {
-		attr.prog_type = BPF_PROG_TYPE_TRACEPOINT;
-		ret = bpf_load_program_xattr(&attr, NULL, 0);
-	}
+	ret = bpf_prog_load(BPF_PROG_TYPE_SOCKET_FILTER, NULL, "GPL", insns, insn_cnt, NULL);
+	if (ret < 0)
+		ret = bpf_prog_load(BPF_PROG_TYPE_TRACEPOINT, NULL, "GPL", insns, insn_cnt, NULL);
 	if (ret < 0) {
 		ret = errno;
 		cp = libbpf_strerror_r(ret, errmsg, sizeof(errmsg));
@@ -4329,28 +4319,19 @@ static int probe_fd(int fd)
 
 static int probe_kern_prog_name(void)
 {
-	struct bpf_load_program_attr attr;
 	struct bpf_insn insns[] = {
 		BPF_MOV64_IMM(BPF_REG_0, 0),
 		BPF_EXIT_INSN(),
 	};
-	int ret;
+	int ret, insn_cnt = ARRAY_SIZE(insns);
 
 	/* make sure loading with name works */
-
-	memset(&attr, 0, sizeof(attr));
-	attr.prog_type = BPF_PROG_TYPE_SOCKET_FILTER;
-	attr.insns = insns;
-	attr.insns_cnt = ARRAY_SIZE(insns);
-	attr.license = "GPL";
-	attr.name = "test";
-	ret = bpf_load_program_xattr(&attr, NULL, 0);
+	ret = bpf_prog_load(BPF_PROG_TYPE_SOCKET_FILTER, "test", "GPL", insns, insn_cnt, NULL);
 	return probe_fd(ret);
 }
 
 static int probe_kern_global_data(void)
 {
-	struct bpf_load_program_attr prg_attr;
 	struct bpf_create_map_attr map_attr;
 	char *cp, errmsg[STRERR_BUFSIZE];
 	struct bpf_insn insns[] = {
@@ -4359,7 +4340,7 @@ static int probe_kern_global_data(void)
 		BPF_MOV64_IMM(BPF_REG_0, 0),
 		BPF_EXIT_INSN(),
 	};
-	int ret, map;
+	int ret, map, insn_cnt = ARRAY_SIZE(insns);
 
 	memset(&map_attr, 0, sizeof(map_attr));
 	map_attr.map_type = BPF_MAP_TYPE_ARRAY;
@@ -4378,13 +4359,7 @@ static int probe_kern_global_data(void)
 
 	insns[0].imm = map;
 
-	memset(&prg_attr, 0, sizeof(prg_attr));
-	prg_attr.prog_type = BPF_PROG_TYPE_SOCKET_FILTER;
-	prg_attr.insns = insns;
-	prg_attr.insns_cnt = ARRAY_SIZE(insns);
-	prg_attr.license = "GPL";
-
-	ret = bpf_load_program_xattr(&prg_attr, NULL, 0);
+	ret = bpf_prog_load(BPF_PROG_TYPE_SOCKET_FILTER, NULL, "GPL", insns, insn_cnt, NULL);
 	close(map);
 	return probe_fd(ret);
 }
@@ -4500,30 +4475,24 @@ static int probe_kern_array_mmap(void)
 
 static int probe_kern_exp_attach_type(void)
 {
-	struct bpf_load_program_attr attr;
+	LIBBPF_OPTS(bpf_prog_load_opts, opts, .expected_attach_type = BPF_CGROUP_INET_SOCK_CREATE);
 	struct bpf_insn insns[] = {
 		BPF_MOV64_IMM(BPF_REG_0, 0),
 		BPF_EXIT_INSN(),
 	};
+	int fd, insn_cnt = ARRAY_SIZE(insns);
 
-	memset(&attr, 0, sizeof(attr));
 	/* use any valid combination of program type and (optional)
 	 * non-zero expected attach type (i.e., not a BPF_CGROUP_INET_INGRESS)
 	 * to see if kernel supports expected_attach_type field for
 	 * BPF_PROG_LOAD command
 	 */
-	attr.prog_type = BPF_PROG_TYPE_CGROUP_SOCK;
-	attr.expected_attach_type = BPF_CGROUP_INET_SOCK_CREATE;
-	attr.insns = insns;
-	attr.insns_cnt = ARRAY_SIZE(insns);
-	attr.license = "GPL";
-
-	return probe_fd(bpf_load_program_xattr(&attr, NULL, 0));
+	fd = bpf_prog_load(BPF_PROG_TYPE_CGROUP_SOCK, NULL, "GPL", insns, insn_cnt, &opts);
+	return probe_fd(fd);
 }
 
 static int probe_kern_probe_read_kernel(void)
 {
-	struct bpf_load_program_attr attr;
 	struct bpf_insn insns[] = {
 		BPF_MOV64_REG(BPF_REG_1, BPF_REG_10),	/* r1 = r10 (fp) */
 		BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, -8),	/* r1 += -8 */
@@ -4532,26 +4501,21 @@ static int probe_kern_probe_read_kernel(void)
 		BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_probe_read_kernel),
 		BPF_EXIT_INSN(),
 	};
+	int fd, insn_cnt = ARRAY_SIZE(insns);
 
-	memset(&attr, 0, sizeof(attr));
-	attr.prog_type = BPF_PROG_TYPE_KPROBE;
-	attr.insns = insns;
-	attr.insns_cnt = ARRAY_SIZE(insns);
-	attr.license = "GPL";
-
-	return probe_fd(bpf_load_program_xattr(&attr, NULL, 0));
+	fd = bpf_prog_load(BPF_PROG_TYPE_KPROBE, NULL, "GPL", insns, insn_cnt, NULL);
+	return probe_fd(fd);
 }
 
 static int probe_prog_bind_map(void)
 {
-	struct bpf_load_program_attr prg_attr;
 	struct bpf_create_map_attr map_attr;
 	char *cp, errmsg[STRERR_BUFSIZE];
 	struct bpf_insn insns[] = {
 		BPF_MOV64_IMM(BPF_REG_0, 0),
 		BPF_EXIT_INSN(),
 	};
-	int ret, map, prog;
+	int ret, map, prog, insn_cnt = ARRAY_SIZE(insns);
 
 	memset(&map_attr, 0, sizeof(map_attr));
 	map_attr.map_type = BPF_MAP_TYPE_ARRAY;
@@ -4568,13 +4532,7 @@ static int probe_prog_bind_map(void)
 		return ret;
 	}
 
-	memset(&prg_attr, 0, sizeof(prg_attr));
-	prg_attr.prog_type = BPF_PROG_TYPE_SOCKET_FILTER;
-	prg_attr.insns = insns;
-	prg_attr.insns_cnt = ARRAY_SIZE(insns);
-	prg_attr.license = "GPL";
-
-	prog = bpf_load_program_xattr(&prg_attr, NULL, 0);
+	prog = bpf_prog_load(BPF_PROG_TYPE_SOCKET_FILTER, NULL, "GPL", insns, insn_cnt, NULL);
 	if (prog < 0) {
 		close(map);
 		return 0;
@@ -4619,19 +4577,14 @@ static int probe_module_btf(void)
 
 static int probe_perf_link(void)
 {
-	struct bpf_load_program_attr attr;
 	struct bpf_insn insns[] = {
 		BPF_MOV64_IMM(BPF_REG_0, 0),
 		BPF_EXIT_INSN(),
 	};
 	int prog_fd, link_fd, err;
 
-	memset(&attr, 0, sizeof(attr));
-	attr.prog_type = BPF_PROG_TYPE_TRACEPOINT;
-	attr.insns = insns;
-	attr.insns_cnt = ARRAY_SIZE(insns);
-	attr.license = "GPL";
-	prog_fd = bpf_load_program_xattr(&attr, NULL, 0);
+	prog_fd = bpf_prog_load(BPF_PROG_TYPE_TRACEPOINT, NULL, "GPL",
+				insns, ARRAY_SIZE(insns), NULL);
 	if (prog_fd < 0)
 		return -errno;
 
@@ -9168,22 +9121,12 @@ long libbpf_get_error(const void *ptr)
 	return -errno;
 }
 
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
-	return bpf_prog_load_xattr(&attr, pobj, prog_fd);
-}
-
+__attribute__((alias("bpf_prog_load_xattr2")))
 int bpf_prog_load_xattr(const struct bpf_prog_load_attr *attr,
-			struct bpf_object **pobj, int *prog_fd)
+			struct bpf_object **pobj, int *prog_fd);
+
+static int bpf_prog_load_xattr2(const struct bpf_prog_load_attr *attr,
+				struct bpf_object **pobj, int *prog_fd)
 {
 	struct bpf_object_open_attr open_attr = {};
 	struct bpf_program *prog, *first_prog = NULL;
@@ -9254,6 +9197,20 @@ int bpf_prog_load_xattr(const struct bpf_prog_load_attr *attr,
 	return 0;
 }
 
+COMPAT_VERSION(bpf_prog_load_deprecated, bpf_prog_load, LIBBPF_0.0.1)
+int bpf_prog_load_deprecated(const char *file, enum bpf_prog_type type,
+			     struct bpf_object **pobj, int *prog_fd)
+{
+	struct bpf_prog_load_attr attr;
+
+	memset(&attr, 0, sizeof(struct bpf_prog_load_attr));
+	attr.file = file;
+	attr.prog_type = type;
+	attr.expected_attach_type = 0;
+
+	return bpf_prog_load_xattr2(&attr, pobj, prog_fd);
+}
+
 struct bpf_link {
 	int (*detach)(struct bpf_link *link);
 	void (*dealloc)(struct bpf_link *link);
diff --git a/tools/lib/bpf/libbpf_probes.c b/tools/lib/bpf/libbpf_probes.c
index 68f2dbf364aa..02c401e314c7 100644
--- a/tools/lib/bpf/libbpf_probes.c
+++ b/tools/lib/bpf/libbpf_probes.c
@@ -68,21 +68,21 @@ static void
 probe_load(enum bpf_prog_type prog_type, const struct bpf_insn *insns,
 	   size_t insns_cnt, char *buf, size_t buf_len, __u32 ifindex)
 {
-	struct bpf_load_program_attr xattr = {};
+	LIBBPF_OPTS(bpf_prog_load_opts, opts);
 	int fd;
 
 	switch (prog_type) {
 	case BPF_PROG_TYPE_CGROUP_SOCK_ADDR:
-		xattr.expected_attach_type = BPF_CGROUP_INET4_CONNECT;
+		opts.expected_attach_type = BPF_CGROUP_INET4_CONNECT;
 		break;
 	case BPF_PROG_TYPE_CGROUP_SOCKOPT:
-		xattr.expected_attach_type = BPF_CGROUP_GETSOCKOPT;
+		opts.expected_attach_type = BPF_CGROUP_GETSOCKOPT;
 		break;
 	case BPF_PROG_TYPE_SK_LOOKUP:
-		xattr.expected_attach_type = BPF_SK_LOOKUP;
+		opts.expected_attach_type = BPF_SK_LOOKUP;
 		break;
 	case BPF_PROG_TYPE_KPROBE:
-		xattr.kern_version = get_kernel_version();
+		opts.kern_version = get_kernel_version();
 		break;
 	case BPF_PROG_TYPE_UNSPEC:
 	case BPF_PROG_TYPE_SOCKET_FILTER:
@@ -115,13 +115,11 @@ probe_load(enum bpf_prog_type prog_type, const struct bpf_insn *insns,
 		break;
 	}
 
-	xattr.prog_type = prog_type;
-	xattr.insns = insns;
-	xattr.insns_cnt = insns_cnt;
-	xattr.license = "GPL";
-	xattr.prog_ifindex = ifindex;
+	opts.prog_ifindex = ifindex;
+	opts.log_buf = buf;
+	opts.log_size = buf_len;
 
-	fd = bpf_load_program_xattr(&xattr, buf, buf_len);
+	fd = bpf_prog_load(prog_type, NULL, "GPL", insns, insns_cnt, NULL);
 	if (fd >= 0)
 		close(fd);
 }
diff --git a/tools/lib/bpf/xsk.c b/tools/lib/bpf/xsk.c
index 81f8fbc85e70..fdb22f5405c9 100644
--- a/tools/lib/bpf/xsk.c
+++ b/tools/lib/bpf/xsk.c
@@ -364,7 +364,6 @@ int xsk_umem__create_v0_0_2(struct xsk_umem **umem_ptr, void *umem_area,
 static enum xsk_prog get_xsk_prog(void)
 {
 	enum xsk_prog detected = XSK_PROG_FALLBACK;
-	struct bpf_load_program_attr prog_attr;
 	struct bpf_create_map_attr map_attr;
 	__u32 size_out, retval, duration;
 	char data_in = 0, data_out;
@@ -375,7 +374,7 @@ static enum xsk_prog get_xsk_prog(void)
 		BPF_EMIT_CALL(BPF_FUNC_redirect_map),
 		BPF_EXIT_INSN(),
 	};
-	int prog_fd, map_fd, ret;
+	int prog_fd, map_fd, ret, insn_cnt = ARRAY_SIZE(insns);
 
 	memset(&map_attr, 0, sizeof(map_attr));
 	map_attr.map_type = BPF_MAP_TYPE_XSKMAP;
@@ -389,13 +388,7 @@ static enum xsk_prog get_xsk_prog(void)
 
 	insns[0].imm = map_fd;
 
-	memset(&prog_attr, 0, sizeof(prog_attr));
-	prog_attr.prog_type = BPF_PROG_TYPE_XDP;
-	prog_attr.insns = insns;
-	prog_attr.insns_cnt = ARRAY_SIZE(insns);
-	prog_attr.license = "GPL";
-
-	prog_fd = bpf_load_program_xattr(&prog_attr, NULL, 0);
+	prog_fd = bpf_prog_load(BPF_PROG_TYPE_XDP, NULL, "GPL", insns, insn_cnt, NULL);
 	if (prog_fd < 0) {
 		close(map_fd);
 		return detected;
@@ -495,10 +488,13 @@ static int xsk_load_xdp_prog(struct xsk_socket *xsk)
 	};
 	struct bpf_insn *progs[] = {prog, prog_redirect_flags};
 	enum xsk_prog option = get_xsk_prog();
+	LIBBPF_OPTS(bpf_prog_load_opts, opts,
+		.log_buf = log_buf,
+		.log_size = log_buf_size,
+	);
 
-	prog_fd = bpf_load_program(BPF_PROG_TYPE_XDP, progs[option], insns_cnt[option],
-				   "LGPL-2.1 or BSD-2-Clause", 0, log_buf,
-				   log_buf_size);
+	prog_fd = bpf_prog_load(BPF_PROG_TYPE_XDP, NULL, "LGPL-2.1 or BSD-2-Clause",
+				progs[option], insns_cnt[option], &opts);
 	if (prog_fd < 0) {
 		pr_warn("BPF log buffer:\n%s", log_buf);
 		return prog_fd;
@@ -725,14 +721,12 @@ static int xsk_link_lookup(int ifindex, __u32 *prog_id, int *link_fd)
 
 static bool xsk_probe_bpf_link(void)
 {
-	DECLARE_LIBBPF_OPTS(bpf_link_create_opts, opts,
-			    .flags = XDP_FLAGS_SKB_MODE);
-	struct bpf_load_program_attr prog_attr;
+	LIBBPF_OPTS(bpf_link_create_opts, opts, .flags = XDP_FLAGS_SKB_MODE);
 	struct bpf_insn insns[2] = {
 		BPF_MOV64_IMM(BPF_REG_0, XDP_PASS),
 		BPF_EXIT_INSN()
 	};
-	int prog_fd, link_fd = -1;
+	int prog_fd, link_fd = -1, insn_cnt = ARRAY_SIZE(insns);
 	int ifindex_lo = 1;
 	bool ret = false;
 	int err;
@@ -744,13 +738,7 @@ static bool xsk_probe_bpf_link(void)
 	if (link_fd >= 0)
 		return true;
 
-	memset(&prog_attr, 0, sizeof(prog_attr));
-	prog_attr.prog_type = BPF_PROG_TYPE_XDP;
-	prog_attr.insns = insns;
-	prog_attr.insns_cnt = ARRAY_SIZE(insns);
-	prog_attr.license = "GPL";
-
-	prog_fd = bpf_load_program_xattr(&prog_attr, NULL, 0);
+	prog_fd = bpf_prog_load(BPF_PROG_TYPE_XDP, NULL, "GPL", insns, insn_cnt, NULL);
 	if (prog_fd < 0)
 		return ret;
 
-- 
2.30.2

