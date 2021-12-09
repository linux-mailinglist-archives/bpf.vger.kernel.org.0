Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF3DE46DF77
	for <lists+bpf@lfdr.de>; Thu,  9 Dec 2021 01:31:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241489AbhLIAee convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Wed, 8 Dec 2021 19:34:34 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:45386 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241500AbhLIAee (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 8 Dec 2021 19:34:34 -0500
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B8MnAST026975
        for <bpf@vger.kernel.org>; Wed, 8 Dec 2021 16:31:01 -0800
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3cu5u5rgty-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 08 Dec 2021 16:31:00 -0800
Received: from intmgw001.27.prn2.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 8 Dec 2021 16:31:00 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id C8D48C51D69A; Wed,  8 Dec 2021 16:30:49 -0800 (PST)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>
Subject: [PATCH bpf-next 07/12] libbpf: add per-program log buffer setter and getter
Date:   Wed, 8 Dec 2021 16:30:28 -0800
Message-ID: <20211209003033.3962657-8-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211209003033.3962657-1-andrii@kernel.org>
References: <20211209003033.3962657-1-andrii@kernel.org>
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-GUID: L8sZqB1A2pT08DVfQZ7DA9d01YLj-ULb
X-Proofpoint-ORIG-GUID: L8sZqB1A2pT08DVfQZ7DA9d01YLj-ULb
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

Allow to set user-provided log buffer on a per-program basis ([0]). This
gives great deal of flexibility in terms of which programs are loaded
with logging enabled and where corresponding logs go.

Log buffer set with bpf_program__set_log_buf() overrides kernel_log_buf
and kernel_log_size settings set at bpf_object open time through
bpf_object_open_opts, if any.

Adjust bpf_object_load_prog_instance() logic to not perform own log buf
allocation and load retry if custom log buffer is provided by the user.

  [0] Closes: https://github.com/libbpf/libbpf/issues/418

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/libbpf.c   | 92 ++++++++++++++++++++++++++++++++--------
 tools/lib/bpf/libbpf.h   |  7 +++
 tools/lib/bpf/libbpf.map |  2 +
 3 files changed, 84 insertions(+), 17 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 3fd4e3d5a11f..e3e56bebd014 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -331,7 +331,11 @@ struct bpf_program {
 
 	struct reloc_desc *reloc_desc;
 	int nr_reloc;
-	int log_level;
+
+	/* BPF verifier log settings */
+	char *log_buf;
+	size_t log_size;
+	__u32 log_level;
 
 	struct {
 		int nr;
@@ -713,6 +717,9 @@ bpf_object__init_prog(struct bpf_object *obj, struct bpf_program *prog,
 	prog->instances.fds = NULL;
 	prog->instances.nr = -1;
 
+	/* inherit object's log_level */
+	prog->log_level = obj->log_level;
+
 	prog->sec_name = strdup(sec_name);
 	if (!prog->sec_name)
 		goto errout;
@@ -6591,8 +6598,10 @@ static int bpf_object_load_prog_instance(struct bpf_object *obj, struct bpf_prog
 	const char *prog_name = NULL;
 	char *cp, errmsg[STRERR_BUFSIZE];
 	size_t log_buf_size = 0;
-	char *log_buf = NULL;
+	char *log_buf = NULL, *tmp;
 	int btf_fd, ret, err;
+	bool own_log_buf = true;
+	__u32 log_level = prog->log_level;
 
 	if (prog->type == BPF_PROG_TYPE_UNSPEC) {
 		/*
@@ -6627,7 +6636,7 @@ static int bpf_object_load_prog_instance(struct bpf_object *obj, struct bpf_prog
 		load_attr.line_info_rec_size = prog->line_info_rec_size;
 		load_attr.line_info_cnt = prog->line_info_cnt;
 	}
-	load_attr.log_level = prog->log_level;
+	load_attr.log_level = log_level;
 	load_attr.prog_flags = prog->prog_flags;
 	load_attr.fd_array = obj->fd_array;
 
@@ -6648,21 +6657,42 @@ static int bpf_object_load_prog_instance(struct bpf_object *obj, struct bpf_prog
 		*prog_fd = -1;
 		return 0;
 	}
-retry_load:
-	if (log_buf_size) {
-		log_buf = malloc(log_buf_size);
-		if (!log_buf)
-			return -ENOMEM;
 
-		*log_buf = 0;
+retry_load:
+	/* if log_level is zero, we don't request logs initiallly even if
+	 * custom log_buf is specified; if the program load fails, then we'll
+	 * bump log_level to 1 and use either custom log_buf or we'll allocate
+	 * our own and retry the load to get details on what failed
+	 */
+	if (log_level) {
+		if (prog->log_buf) {
+			log_buf = prog->log_buf;
+			log_buf_size = prog->log_size;
+			own_log_buf = false;
+		} else if (obj->log_buf) {
+			log_buf = obj->log_buf;
+			log_buf_size = obj->log_size;
+			own_log_buf = false;
+		} else {
+			log_buf_size = max((size_t)BPF_LOG_BUF_SIZE, log_buf_size * 2);
+			tmp = realloc(log_buf, log_buf_size);
+			if (!tmp) {
+				ret = -ENOMEM;
+				goto out;
+			}
+			log_buf = tmp;
+			log_buf[0] = '\0';
+			own_log_buf = true;
+		}
 	}
 
 	load_attr.log_buf = log_buf;
 	load_attr.log_size = log_buf_size;
-	ret = bpf_prog_load(prog->type, prog_name, license, insns, insns_cnt, &load_attr);
+	load_attr.log_level = log_level;
 
+	ret = bpf_prog_load(prog->type, prog_name, license, insns, insns_cnt, &load_attr);
 	if (ret >= 0) {
-		if (log_buf && load_attr.log_level) {
+		if (log_level && own_log_buf) {
 			pr_debug("prog '%s': -- BEGIN PROG LOAD LOG --\n%s-- END PROG LOAD LOG --\n",
 				 prog->name, log_buf);
 		}
@@ -6690,19 +6720,26 @@ static int bpf_object_load_prog_instance(struct bpf_object *obj, struct bpf_prog
 		goto out;
 	}
 
-	if (!log_buf || errno == ENOSPC) {
-		log_buf_size = max((size_t)BPF_LOG_BUF_SIZE,
-				   log_buf_size << 1);
-		free(log_buf);
+	if (log_level == 0) {
+		log_level = 1;
 		goto retry_load;
 	}
+	/* On ENOSPC, increase log buffer size and retry, unless custom
+	 * log_buf is specified.
+	 * Be careful to not overflow u32, though. Kernel's log buf size limit
+	 * isn't part of UAPI so it can always be bumped to full 4GB. So don't
+	 * multiply by 2 unless we are sure we'll fit within 32 bits.
+	 * Currently, we'll get -EINVAL when we reach (UINT_MAX >> 2).
+	 */
+	if (own_log_buf && errno == ENOSPC && log_buf_size <= UINT_MAX / 2)
+		goto retry_load;
 
 	ret = -errno;
 	cp = libbpf_strerror_r(errno, errmsg, sizeof(errmsg));
 	pr_warn("prog '%s': BPF program load failed: %s\n", prog->name, cp);
 	pr_perm_msg(ret);
 
-	if (log_buf && log_buf[0] != '\0') {
+	if (own_log_buf && log_buf && log_buf[0] != '\0') {
 		pr_warn("prog '%s': -- BEGIN PROG LOAD LOG --\n%s-- END PROG LOAD LOG --\n",
 			prog->name, log_buf);
 	}
@@ -6712,7 +6749,8 @@ static int bpf_object_load_prog_instance(struct bpf_object *obj, struct bpf_prog
 	}
 
 out:
-	free(log_buf);
+	if (own_log_buf)
+		free(log_buf);
 	return ret;
 }
 
@@ -8498,6 +8536,26 @@ int bpf_program__set_log_level(struct bpf_program *prog, __u32 log_level)
 	return 0;
 }
 
+const char *bpf_program__log_buf(const struct bpf_program *prog, size_t *log_size)
+{
+	*log_size = prog->log_size;
+	return prog->log_buf;
+}
+
+int bpf_program__set_log_buf(struct bpf_program *prog, char *log_buf, size_t log_size)
+{
+	if (log_size && !log_buf)
+		return -EINVAL;
+	if (prog->log_size > UINT_MAX)
+		return -EINVAL;
+	if (prog->obj->loaded)
+		return -EBUSY;
+
+	prog->log_buf = log_buf;
+	prog->log_size = log_size;
+	return 0;
+}
+
 #define SEC_DEF(sec_pfx, ptype, atype, flags, ...) {			    \
 	.sec = sec_pfx,							    \
 	.prog_type = BPF_PROG_TYPE_##ptype,				    \
diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index 5c984c63859f..dacde55bebff 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -591,8 +591,15 @@ bpf_program__set_expected_attach_type(struct bpf_program *prog,
 
 LIBBPF_API __u32 bpf_program__flags(const struct bpf_program *prog);
 LIBBPF_API int bpf_program__set_flags(struct bpf_program *prog, __u32 flags);
+
+/* Per-program log level and log buffer getters/setters.
+ * See bpf_object_open_opts comments regarding log_level and log_buf
+ * interactions.
+ */
 LIBBPF_API __u32 bpf_program__log_level(const struct bpf_program *prog);
 LIBBPF_API int bpf_program__set_log_level(struct bpf_program *prog, __u32 log_level);
+LIBBPF_API const char *bpf_program__log_buf(const struct bpf_program *prog, size_t *log_size);
+LIBBPF_API int bpf_program__set_log_buf(struct bpf_program *prog, char *log_buf, size_t log_size);
 
 LIBBPF_API int
 bpf_program__set_attach_target(struct bpf_program *prog, int attach_prog_fd,
diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
index 08cdfe840436..4d483af7dba6 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -423,6 +423,8 @@ LIBBPF_0.6.0 {
 LIBBPF_0.7.0 {
 	global:
 		bpf_btf_load;
+		bpf_program__log_buf;
 		bpf_program__log_level;
+		bpf_program__set_log_buf;
 		bpf_program__set_log_level;
 };
-- 
2.30.2

