Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FB65468D41
	for <lists+bpf@lfdr.de>; Sun,  5 Dec 2021 21:32:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238658AbhLEUgX convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Sun, 5 Dec 2021 15:36:23 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:5592 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238661AbhLEUgU (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sun, 5 Dec 2021 15:36:20 -0500
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B5FFnFr010116
        for <bpf@vger.kernel.org>; Sun, 5 Dec 2021 12:32:53 -0800
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3crrq4thfm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Sun, 05 Dec 2021 12:32:53 -0800
Received: from intmgw001.25.frc3.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Sun, 5 Dec 2021 12:32:51 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 389A3BFD77A4; Sun,  5 Dec 2021 12:32:44 -0800 (PST)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>
Subject: [PATCH bpf-next 03/11] libbpf: allow passing user log setting through bpf_object_open_opts
Date:   Sun, 5 Dec 2021 12:32:26 -0800
Message-ID: <20211205203234.1322242-4-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211205203234.1322242-1-andrii@kernel.org>
References: <20211205203234.1322242-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-GUID: 4_HZpJJohuziVQ6gzZS-Nvq0mK9RDST0
X-Proofpoint-ORIG-GUID: 4_HZpJJohuziVQ6gzZS-Nvq0mK9RDST0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-05_11,2021-12-02_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 suspectscore=0
 priorityscore=1501 adultscore=0 mlxscore=0 clxscore=1034 spamscore=0
 mlxlogscore=999 bulkscore=0 impostorscore=0 lowpriorityscore=0
 malwarescore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2110150000 definitions=main-2112050124
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Allow users to provide their own custom log_buf, log_size, and log_level
at bpf_object level through bpf_object_open_opts. This log_buf will be
used during BTF loading. Subsequent patch will use same log_buf during
BPF program loading, unless overriden at per-bpf_program level.

When such custom log_buf is provided, libbpf won't be attempting
retrying loading of BTF to try to provide its own log buffer to capture
kernel's error log output. User is responsible to provide big enough
buffer, otherwise they run a risk of getting -ENOSPC error from the
bpf() syscall.

See also comments in bpf_object_open_opts regarding log_level and
log_buf interactions.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/bpf.h    |  3 ++-
 tools/lib/bpf/libbpf.c | 24 +++++++++++++++++++++++-
 tools/lib/bpf/libbpf.h | 41 ++++++++++++++++++++++++++++++++++++++++-
 3 files changed, 65 insertions(+), 3 deletions(-)

diff --git a/tools/lib/bpf/bpf.h b/tools/lib/bpf/bpf.h
index 5f7d9636643d..94e553a0ff9d 100644
--- a/tools/lib/bpf/bpf.h
+++ b/tools/lib/bpf/bpf.h
@@ -195,8 +195,9 @@ struct bpf_load_program_attr {
 /* Flags to direct loading requirements */
 #define MAPS_RELAX_COMPAT	0x01
 
-/* Recommend log buffer size */
+/* Recommended log buffer size */
 #define BPF_LOG_BUF_SIZE (UINT32_MAX >> 8) /* verifier maximum in kernels <= 5.1 */
+
 LIBBPF_DEPRECATED_SINCE(0, 7, "use bpf_prog_load() instead")
 LIBBPF_API int bpf_load_program_xattr(const struct bpf_load_program_attr *load_attr,
 				      char *log_buf, size_t log_buf_sz);
diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 6db0b5e8540e..38999e9c08e0 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -573,6 +573,11 @@ struct bpf_object {
 	size_t btf_module_cnt;
 	size_t btf_module_cap;
 
+	/* optional log settings passed to BPF_BTF_LOAD and BPF_PROG_LOAD commands */
+	char *log_buf;
+	size_t log_size;
+	__u32 log_level;
+
 	void *priv;
 	bpf_object_clear_priv_t clear_priv;
 
@@ -3017,7 +3022,9 @@ static int bpf_object__sanitize_and_load_btf(struct bpf_object *obj)
 		 */
 		btf__set_fd(kern_btf, 0);
 	} else {
-		err = btf__load_into_kernel(kern_btf);
+		/* currently BPF_BTF_LOAD only supports log_level 1 */
+		err = btf_load_into_kernel(kern_btf, obj->log_buf, obj->log_size,
+					   obj->log_level ? 1 : 0);
 	}
 	if (sanitize) {
 		if (!err) {
@@ -6932,6 +6939,9 @@ __bpf_object__open(const char *path, const void *obj_buf, size_t obj_buf_sz,
 	struct bpf_object *obj;
 	char tmp_name[64];
 	int err;
+	char *log_buf;
+	size_t log_size;
+	__u32 log_level;
 
 	if (elf_version(EV_CURRENT) == EV_NONE) {
 		pr_warn("failed to init libelf for %s\n",
@@ -6954,10 +6964,22 @@ __bpf_object__open(const char *path, const void *obj_buf, size_t obj_buf_sz,
 		pr_debug("loading object '%s' from buffer\n", obj_name);
 	}
 
+	log_buf = OPTS_GET(opts, kernel_log_buf, NULL);
+	log_size = OPTS_GET(opts, kernel_log_size, 0);
+	log_level = OPTS_GET(opts, kernel_log_level, 0);
+	if (log_size > UINT_MAX)
+		return ERR_PTR(-EINVAL);
+	if (log_size && !log_buf)
+		return ERR_PTR(-EINVAL);
+
 	obj = bpf_object__new(path, obj_buf, obj_buf_sz, obj_name);
 	if (IS_ERR(obj))
 		return obj;
 
+	obj->log_buf = log_buf;
+	obj->log_size = log_size;
+	obj->log_level = log_level;
+
 	btf_tmp_path = OPTS_GET(opts, btf_custom_path, NULL);
 	if (btf_tmp_path) {
 		if (strlen(btf_tmp_path) >= PATH_MAX) {
diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index c0d62dd37c5d..ae7cda7ad731 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -108,8 +108,47 @@ struct bpf_object_open_opts {
 	 * struct_ops, etc) will need actual kernel BTF at /sys/kernel/btf/vmlinux.
 	 */
 	const char *btf_custom_path;
+	/* Pointer to a buffer for storing kernel logs for applicable BPF
+	 * commands. Valid kernel_log_size has to be specified as well and are
+	 * passed-through to bpf() syscall. Keep in mind that kernel might
+	 * fail operation with -ENOSPC error if provided buffer is too small
+	 * to contain entire log output.
+	 * See the comment below for kernel_log_level for interaction between
+	 * log_buf and log_level settings.
+	 *
+	 * If specified, this log buffer will be passed for:
+	 *   - each BPF progral load (BPF_PROG_LOAD) attempt, unless overriden
+	 *     with bpf_program__set_log() on per-program level, to get
+	 *     BPF verifier log output.
+	 *   - during BPF object's BTF load into kernel (BPF_BTF_LOAD) to get
+	 *     BTF sanity checking log.
+	 *
+	 * Each BPF command (BPF_BTF_LOAD or BPF_PROG_LOAD) will overwrite
+	 * previous contents, so if you need more fine-grained control, set
+	 * per-program buffer with bpf_program__set_log_buf() to preserve each
+	 * individual program's verification log. Keep using kernel_log_buf
+	 * for BTF verification log, if necessary.
+	 */
+	char *kernel_log_buf;
+	size_t kernel_log_size;
+	/*
+	 * Log level can be set independently from log buffer. Log_level=0
+	 * means that libbpf will attempt loading BTF or program without any
+	 * logging requested, but will retry with either its own or custom log
+	 * buffer, if provided, and log_level=1 on any error.
+	 * And vice versa, setting log_level>0 will request BTF or prog
+	 * loading with verbose log from the first attempt (and as such also
+	 * for successfully loaded BTF or program), and the actual log buffer
+	 * could be either libbpf's own auto-allocated log buffer, if
+	 * kernel_log_buffer is NULL, or user-provided custom kernel_log_buf.
+	 * If user didn't provide custom log buffer, libbpf will emit captured
+	 * logs through its print callback.
+	 */
+	__u32 kernel_log_level;
+
+	size_t :0;
 };
-#define bpf_object_open_opts__last_field btf_custom_path
+#define bpf_object_open_opts__last_field kernel_log_level
 
 LIBBPF_API struct bpf_object *bpf_object__open(const char *path);
 LIBBPF_API struct bpf_object *
-- 
2.30.2

