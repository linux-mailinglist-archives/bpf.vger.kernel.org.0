Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 457EA46DFBE
	for <lists+bpf@lfdr.de>; Thu,  9 Dec 2021 01:49:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241555AbhLIAxP convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Wed, 8 Dec 2021 19:53:15 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:52368 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229846AbhLIAxP (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 8 Dec 2021 19:53:15 -0500
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B8KQu3K010102
        for <bpf@vger.kernel.org>; Wed, 8 Dec 2021 16:49:42 -0800
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3cttqh5kh8-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 08 Dec 2021 16:49:42 -0800
Received: from intmgw001.05.prn6.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 8 Dec 2021 16:49:41 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 82ACAC523FA0; Wed,  8 Dec 2021 16:49:33 -0800 (PST)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>
Subject: [PATCH v2 bpf-next 05/12] libbpf: improve logging around BPF program loading
Date:   Wed, 8 Dec 2021 16:49:13 -0800
Message-ID: <20211209004920.4085377-6-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211209004920.4085377-1-andrii@kernel.org>
References: <20211209004920.4085377-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-ORIG-GUID: 3o5tc1yWumIc8WOhxa480onakVWWqSCO
X-Proofpoint-GUID: 3o5tc1yWumIc8WOhxa480onakVWWqSCO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-08_08,2021-12-08_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 mlxscore=0
 lowpriorityscore=0 malwarescore=0 mlxlogscore=999 suspectscore=0
 phishscore=0 adultscore=0 bulkscore=0 priorityscore=1501 clxscore=1015
 impostorscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2110150000 definitions=main-2112090002
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add missing "prog '%s': " prefixes in few places and use consistently
markers for beginning and end of program load logs. Here's an example of
log output:

libbpf: prog 'handler': BPF program load failed: Permission denied
libbpf: -- BEGIN PROG LOAD LOG ---
arg#0 reference type('UNKNOWN ') size cannot be determined: -22
; out1 = in1;
0: (18) r1 = 0xffffc9000cdcc000
2: (61) r1 = *(u32 *)(r1 +0)

...

81: (63) *(u32 *)(r4 +0) = r5
 R1_w=map_value(id=0,off=16,ks=4,vs=20,imm=0) R4=map_value(id=0,off=400,ks=4,vs=16,imm=0)
invalid access to map value, value_size=16 off=400 size=4
R4 min value is outside of the allowed memory range
processed 63 insns (limit 1000000) max_states_per_insn 0 total_states 0 peak_states 0 mark_read 0
 -- END PROG LOAD LOG --
libbpf: failed to load program 'handler'
libbpf: failed to load object 'test_skeleton'

The entire verifier log, including BEGIN and END markers are now always
youtput during a single print callback call. This should make it much
easier to post-process or parse it, if necessary. It's not an explicit
API guarantee, but it can be reasonably expected to stay like that.

Also __bpf_object__open is renamed to bpf_object_open() as it's always
an adventure to find the exact function that implements bpf_object's
open phase, so drop the double underscored and use internal libbpf
naming convention.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/libbpf.c                        | 38 +++++++++----------
 .../selftests/bpf/prog_tests/bpf_tcp_ca.c     |  6 ++-
 2 files changed, 23 insertions(+), 21 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 38999e9c08e0..f07ff39a9d20 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -6662,8 +6662,10 @@ static int bpf_object_load_prog_instance(struct bpf_object *obj, struct bpf_prog
 	ret = bpf_prog_load(prog->type, prog_name, license, insns, insns_cnt, &load_attr);
 
 	if (ret >= 0) {
-		if (log_buf && load_attr.log_level)
-			pr_debug("verifier log:\n%s", log_buf);
+		if (log_buf && load_attr.log_level) {
+			pr_debug("prog '%s': -- BEGIN PROG LOAD LOG --\n%s-- END PROG LOAD LOG --\n",
+				 prog->name, log_buf);
+		}
 
 		if (obj->has_rodata && kernel_supports(obj, FEAT_PROG_BIND_MAP)) {
 			struct bpf_map *map;
@@ -6676,8 +6678,8 @@ static int bpf_object_load_prog_instance(struct bpf_object *obj, struct bpf_prog
 
 				if (bpf_prog_bind_map(ret, bpf_map__fd(map), NULL)) {
 					cp = libbpf_strerror_r(errno, errmsg, sizeof(errmsg));
-					pr_warn("prog '%s': failed to bind .rodata map: %s\n",
-						prog->name, cp);
+					pr_warn("prog '%s': failed to bind map '%s': %s\n",
+						prog->name, map->real_name, cp);
 					/* Don't fail hard if can't bind rodata. */
 				}
 			}
@@ -6691,23 +6693,22 @@ static int bpf_object_load_prog_instance(struct bpf_object *obj, struct bpf_prog
 	if (!log_buf || errno == ENOSPC) {
 		log_buf_size = max((size_t)BPF_LOG_BUF_SIZE,
 				   log_buf_size << 1);
-
 		free(log_buf);
 		goto retry_load;
 	}
 	ret = errno ? -errno : -LIBBPF_ERRNO__LOAD;
 	cp = libbpf_strerror_r(errno, errmsg, sizeof(errmsg));
-	pr_warn("load bpf program failed: %s\n", cp);
+	pr_warn("prog '%s': BPF program load failed: %s\n", prog->name, cp);
 	pr_perm_msg(ret);
 
 	if (log_buf && log_buf[0] != '\0') {
 		ret = -LIBBPF_ERRNO__VERIFY;
-		pr_warn("-- BEGIN DUMP LOG ---\n");
-		pr_warn("\n%s\n", log_buf);
-		pr_warn("-- END LOG --\n");
-	} else if (insns_cnt >= BPF_MAXINSNS) {
-		pr_warn("Program too large (%d insns), at most %d insns\n",
-			insns_cnt, BPF_MAXINSNS);
+		pr_warn("prog '%s': -- BEGIN PROG LOAD LOG --\n%s-- END PROG LOAD LOG --\n",
+			prog->name, log_buf);
+	}
+	if (insns_cnt >= BPF_MAXINSNS) {
+		pr_warn("prog '%s': program too large (%d insns), at most %d insns\n",
+			prog->name, insns_cnt, BPF_MAXINSNS);
 		ret = -LIBBPF_ERRNO__PROG2BIG;
 	} else if (prog->type != BPF_PROG_TYPE_KPROBE) {
 		/* Wrong program type? */
@@ -6931,9 +6932,8 @@ static int bpf_object_init_progs(struct bpf_object *obj, const struct bpf_object
 	return 0;
 }
 
-static struct bpf_object *
-__bpf_object__open(const char *path, const void *obj_buf, size_t obj_buf_sz,
-		   const struct bpf_object_open_opts *opts)
+static struct bpf_object *bpf_object_open(const char *path, const void *obj_buf, size_t obj_buf_sz,
+					  const struct bpf_object_open_opts *opts)
 {
 	const char *obj_name, *kconfig, *btf_tmp_path;
 	struct bpf_object *obj;
@@ -7033,7 +7033,7 @@ __bpf_object__open_xattr(struct bpf_object_open_attr *attr, int flags)
 		return NULL;
 
 	pr_debug("loading %s\n", attr->file);
-	return __bpf_object__open(attr->file, NULL, 0, &opts);
+	return bpf_object_open(attr->file, NULL, 0, &opts);
 }
 
 struct bpf_object *bpf_object__open_xattr(struct bpf_object_open_attr *attr)
@@ -7059,7 +7059,7 @@ bpf_object__open_file(const char *path, const struct bpf_object_open_opts *opts)
 
 	pr_debug("loading %s\n", path);
 
-	return libbpf_ptr(__bpf_object__open(path, NULL, 0, opts));
+	return libbpf_ptr(bpf_object_open(path, NULL, 0, opts));
 }
 
 struct bpf_object *
@@ -7069,7 +7069,7 @@ bpf_object__open_mem(const void *obj_buf, size_t obj_buf_sz,
 	if (!obj_buf || obj_buf_sz == 0)
 		return libbpf_err_ptr(-EINVAL);
 
-	return libbpf_ptr(__bpf_object__open(NULL, obj_buf, obj_buf_sz, opts));
+	return libbpf_ptr(bpf_object_open(NULL, obj_buf, obj_buf_sz, opts));
 }
 
 struct bpf_object *
@@ -7086,7 +7086,7 @@ bpf_object__open_buffer(const void *obj_buf, size_t obj_buf_sz,
 	if (!obj_buf || obj_buf_sz == 0)
 		return errno = EINVAL, NULL;
 
-	return libbpf_ptr(__bpf_object__open(NULL, obj_buf, obj_buf_sz, &opts));
+	return libbpf_ptr(bpf_object_open(NULL, obj_buf, obj_buf_sz, &opts));
 }
 
 static int bpf_object_unload(struct bpf_object *obj)
diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c b/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c
index 94e03df69d71..8daca0ac909f 100644
--- a/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c
+++ b/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c
@@ -217,14 +217,16 @@ static bool found;
 static int libbpf_debug_print(enum libbpf_print_level level,
 			      const char *format, va_list args)
 {
-	char *log_buf;
+	const char *log_buf;
 
 	if (level != LIBBPF_WARN ||
-	    strcmp(format, "libbpf: \n%s\n")) {
+	    !strstr(format, "-- BEGIN PROG LOAD LOG --")) {
 		vprintf(format, args);
 		return 0;
 	}
 
+	/* skip prog_name */
+	va_arg(args, char *);
 	log_buf = va_arg(args, char *);
 	if (!log_buf)
 		goto out;
-- 
2.30.2

