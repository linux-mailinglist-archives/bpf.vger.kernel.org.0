Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1172B46DF70
	for <lists+bpf@lfdr.de>; Thu,  9 Dec 2021 01:30:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241477AbhLIAeQ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Wed, 8 Dec 2021 19:34:16 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:15896 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235439AbhLIAeQ (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 8 Dec 2021 19:34:16 -0500
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B8Mn3go026808
        for <bpf@vger.kernel.org>; Wed, 8 Dec 2021 16:30:43 -0800
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3cu5u5rgru-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 08 Dec 2021 16:30:43 -0800
Received: from intmgw001.46.prn1.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:11d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 8 Dec 2021 16:30:40 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id C1E8DC51D5F1; Wed,  8 Dec 2021 16:30:38 -0800 (PST)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>
Subject: [PATCH bpf-next 02/12] libbpf: add OPTS-based bpf_btf_load() API
Date:   Wed, 8 Dec 2021 16:30:23 -0800
Message-ID: <20211209003033.3962657-3-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211209003033.3962657-1-andrii@kernel.org>
References: <20211209003033.3962657-1-andrii@kernel.org>
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-GUID: E8XtG4dwulOgK6Tv2uFXYUEtHCXabUAW
X-Proofpoint-ORIG-GUID: E8XtG4dwulOgK6Tv2uFXYUEtHCXabUAW
Content-Transfer-Encoding: 8BIT
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-08_08,2021-12-08_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 priorityscore=1501
 lowpriorityscore=0 suspectscore=0 mlxlogscore=999 bulkscore=0
 clxscore=1015 malwarescore=0 phishscore=0 impostorscore=0 spamscore=0
 mlxscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112090000
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Similar to previous bpf_prog_load() and bpf_map_create() APIs, add
bpf_btf_load() API which is taking optional OPTS struct. Schedule
bpf_load_btf() for deprecation in v0.8 ([0]).

This makes naming consistent with BPF_BTF_LOAD command, sets up an API
for extensibility in the future, moves options parameters (log-related
fields) into optional options, and also allows to pass log_level
directly.

It also removes log buffer auto-allocation logic from low-level API
(consistent with bpf_prog_load() behavior), but preserves a special
treatment of log_level == 0 with non-NULL log_buf, which matches
low-level bpf_prog_load() and high-level libbpf APIs for BTF and program
loading behaviors.

  [0] Closes: https://github.com/libbpf/libbpf/issues/419

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/bpf.c           | 59 +++++++++++++++++++++++++++++------
 tools/lib/bpf/bpf.h           | 19 +++++++++--
 tools/lib/bpf/libbpf.map      |  1 +
 tools/lib/bpf/libbpf_probes.c |  2 +-
 4 files changed, 69 insertions(+), 12 deletions(-)

diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
index c7627fc18952..61931efc4fc1 100644
--- a/tools/lib/bpf/bpf.c
+++ b/tools/lib/bpf/bpf.c
@@ -1047,24 +1047,65 @@ int bpf_raw_tracepoint_open(const char *name, int prog_fd)
 	return libbpf_err_errno(fd);
 }
 
-int bpf_load_btf(const void *btf, __u32 btf_size, char *log_buf, __u32 log_buf_size,
-		 bool do_log)
+int bpf_btf_load(const void *btf_data, size_t btf_size, const struct bpf_btf_load_opts *opts)
 {
-	union bpf_attr attr = {};
+	const size_t attr_sz = offsetofend(union bpf_attr, btf_log_level);
+	union bpf_attr attr;
+	char *log_buf;
+	size_t log_size;
+	__u32 log_level;
 	int fd;
 
-	attr.btf = ptr_to_u64(btf);
+	memset(&attr, 0, attr_sz);
+
+	if (!OPTS_VALID(opts, bpf_btf_load_opts))
+		return libbpf_err(-EINVAL);
+
+	log_buf = OPTS_GET(opts, log_buf, NULL);
+	log_size = OPTS_GET(opts, log_size, 0);
+	log_level = OPTS_GET(opts, log_level, 0);
+
+	if (log_size > UINT_MAX)
+		return libbpf_err(-EINVAL);
+	if (log_size && !log_buf)
+		return libbpf_err(-EINVAL);
+
+	attr.btf = ptr_to_u64(btf_data);
 	attr.btf_size = btf_size;
+	/* log_level == 0 and log_buf != NULL means "try loading without
+	 * log_buf, but retry with log_buf and log_level=1 on error", which is
+	 * consistent across low-level and high-level BTF and program loading
+	 * APIs within libbpf and provides a sensible behavior in practice
+	 */
+	if (log_level) {
+		attr.btf_log_buf = ptr_to_u64(log_buf);
+		attr.btf_log_size = (__u32)log_size;
+		attr.btf_log_level = log_level;
+	}
 
-retry:
-	if (do_log && log_buf && log_buf_size) {
-		attr.btf_log_level = 1;
-		attr.btf_log_size = log_buf_size;
+	fd = sys_bpf_fd(BPF_BTF_LOAD, &attr, attr_sz);
+	if (fd < 0 && log_buf && log_level == 0) {
 		attr.btf_log_buf = ptr_to_u64(log_buf);
+		attr.btf_log_size = (__u32)log_size;
+		attr.btf_log_level = log_level;
+		fd = sys_bpf_fd(BPF_BTF_LOAD, &attr, attr_sz);
 	}
+	return libbpf_err_errno(fd);
+}
+
+int bpf_load_btf(const void *btf, __u32 btf_size, char *log_buf, __u32 log_buf_size, bool do_log)
+{
+	LIBBPF_OPTS(bpf_btf_load_opts, opts);
+	int fd;
 
-	fd = sys_bpf_fd(BPF_BTF_LOAD, &attr, sizeof(attr));
+retry:
+	if (do_log && log_buf && log_buf_size) {
+		opts.log_buf = log_buf;
+		opts.log_size = log_buf_size;
+		opts.log_level = 1;
+	}
 
+	fd = bpf_btf_load(btf, btf_size, &opts);
 	if (fd < 0 && !do_log && log_buf && log_buf_size) {
 		do_log = true;
 		goto retry;
diff --git a/tools/lib/bpf/bpf.h b/tools/lib/bpf/bpf.h
index f79e5fbcf1c1..5f7d9636643d 100644
--- a/tools/lib/bpf/bpf.h
+++ b/tools/lib/bpf/bpf.h
@@ -213,6 +213,23 @@ LIBBPF_API int bpf_verify_program(enum bpf_prog_type type,
 				  char *log_buf, size_t log_buf_sz,
 				  int log_level);
 
+struct bpf_btf_load_opts {
+	size_t sz; /* size of this struct for forward/backward compatibility */
+
+	/* kernel log options */
+	char *log_buf;
+	__u32 log_level;
+	__u32 log_size;
+};
+#define bpf_btf_load_opts__last_field log_size
+
+LIBBPF_API int bpf_btf_load(const void *btf_data, size_t btf_size,
+			    const struct bpf_btf_load_opts *opts);
+
+LIBBPF_DEPRECATED_SINCE(0, 8, "use bpf_btf_load() instead")
+LIBBPF_API int bpf_load_btf(const void *btf, __u32 btf_size, char *log_buf,
+			    __u32 log_buf_size, bool do_log);
+
 LIBBPF_API int bpf_map_update_elem(int fd, const void *key, const void *value,
 				   __u64 flags);
 
@@ -340,8 +357,6 @@ LIBBPF_API int bpf_prog_query(int target_fd, enum bpf_attach_type type,
 			      __u32 query_flags, __u32 *attach_flags,
 			      __u32 *prog_ids, __u32 *prog_cnt);
 LIBBPF_API int bpf_raw_tracepoint_open(const char *name, int prog_fd);
-LIBBPF_API int bpf_load_btf(const void *btf, __u32 btf_size, char *log_buf,
-			    __u32 log_buf_size, bool do_log);
 LIBBPF_API int bpf_task_fd_query(int pid, int fd, __u32 flags, char *buf,
 				 __u32 *buf_len, __u32 *prog_id, __u32 *fd_type,
 				 __u64 *probe_offset, __u64 *probe_addr);
diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
index 715df3a27389..08cdfe840436 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -422,6 +422,7 @@ LIBBPF_0.6.0 {
 
 LIBBPF_0.7.0 {
 	global:
+		bpf_btf_load;
 		bpf_program__log_level;
 		bpf_program__set_log_level;
 };
diff --git a/tools/lib/bpf/libbpf_probes.c b/tools/lib/bpf/libbpf_probes.c
index 41f2be47c2ea..4bdec69523a7 100644
--- a/tools/lib/bpf/libbpf_probes.c
+++ b/tools/lib/bpf/libbpf_probes.c
@@ -164,7 +164,7 @@ int libbpf__load_raw_btf(const char *raw_types, size_t types_len,
 	memcpy(raw_btf + hdr.hdr_len, raw_types, hdr.type_len);
 	memcpy(raw_btf + hdr.hdr_len + hdr.type_len, str_sec, hdr.str_len);
 
-	btf_fd = bpf_load_btf(raw_btf, btf_len, NULL, 0, false);
+	btf_fd = bpf_btf_load(raw_btf, btf_len, NULL);
 
 	free(raw_btf);
 	return btf_fd;
-- 
2.30.2

