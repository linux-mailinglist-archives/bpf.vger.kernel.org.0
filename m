Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E33C6412951
	for <lists+bpf@lfdr.de>; Tue, 21 Sep 2021 01:18:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238949AbhITXUG convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Mon, 20 Sep 2021 19:20:06 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:49720 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238967AbhITXSG (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 20 Sep 2021 19:18:06 -0400
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18KHwREp005276
        for <bpf@vger.kernel.org>; Mon, 20 Sep 2021 16:16:38 -0700
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3b6v27u3ra-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 20 Sep 2021 16:16:38 -0700
Received: from intmgw001.05.prn6.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:21d::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Mon, 20 Sep 2021 16:16:36 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id C92CE487A9E6; Mon, 20 Sep 2021 16:16:32 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>
Subject: [PATCH bpf-next 4/4] libbpf: add legacy uprobe attaching support
Date:   Mon, 20 Sep 2021 16:16:17 -0700
Message-ID: <20210920231617.3141867-5-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210920231617.3141867-1-andrii@kernel.org>
References: <20210920231617.3141867-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-GUID: 9rT_4ZyArzL9E1UEN2tOTcB-PkpPmQSq
X-Proofpoint-ORIG-GUID: 9rT_4ZyArzL9E1UEN2tOTcB-PkpPmQSq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-20_07,2021-09-20_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 clxscore=1015 mlxscore=0
 phishscore=0 malwarescore=0 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 spamscore=0 bulkscore=0 mlxlogscore=999 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109030001 definitions=main-2109200135
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Similarly to recently added legacy kprobe attach interface support
through tracefs, support attaching uprobes using the legacy interface if
host kernel doesn't support newer FD-based interface.

For uprobes event name consists of "libbpf_" prefix, PID, sanitized
binary path and offset within that binary. Structuraly the code is
aligned with kprobe logic refactoring in previous patch. struct
bpf_link_perf is re-used and all the same legacy_probe_name and
legacy_is_retprobe fields are used to ensure proper cleanup on
bpf_link__destroy().

Users should be aware, though, that on old kernels which don't support
FD-based interface for kprobe/uprobe attachment, if the application
crashes before bpf_link__destroy() is called, uprobe legacy
events will be left in tracefs. This is the same limitation as with
legacy kprobe interfaces.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/libbpf.c | 130 ++++++++++++++++++++++++++++++++++++++---
 1 file changed, 122 insertions(+), 8 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index aa842f0721cb..ef5db34bf913 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -9021,6 +9021,7 @@ struct bpf_link_perf {
 };
 
 static int remove_kprobe_event_legacy(const char *probe_name, bool retprobe);
+static int remove_uprobe_event_legacy(const char *probe_name, bool retprobe);
 
 static int bpf_link_perf_detach(struct bpf_link *link)
 {
@@ -9034,11 +9035,14 @@ static int bpf_link_perf_detach(struct bpf_link *link)
 		close(perf_link->perf_event_fd);
 	close(link->fd);
 
-	/* legacy kprobe needs to be removed after perf event fd closure */
+	/* legacy uprobe/kprobe needs to be removed after perf event fd closure */
 	if (perf_link->legacy_probe_name) {
 		if (perf_link->legacy_is_kprobe) {
 			err = remove_kprobe_event_legacy(perf_link->legacy_probe_name,
 							 perf_link->legacy_is_retprobe);
+		} else {
+			err = remove_uprobe_event_legacy(perf_link->legacy_probe_name,
+							 perf_link->legacy_is_retprobe);
 		}
 	}
 
@@ -9450,17 +9454,96 @@ static struct bpf_link *attach_kprobe(const struct bpf_program *prog)
 	return link;
 }
 
+static void gen_uprobe_legacy_event_name(char *buf, size_t buf_sz,
+					 const char *binary_path, uint64_t offset)
+{
+	int i;
+
+	snprintf(buf, buf_sz, "libbpf_%u_%s_0x%zx", getpid(), binary_path, (size_t)offset);
+
+	/* sanitize binary_path in the probe name */
+	for (i = 0; buf[i]; i++) {
+		if (!isalnum(buf[i]))
+			buf[i] = '_';
+	}
+}
+
+static inline int add_uprobe_event_legacy(const char *probe_name, bool retprobe,
+					  const char *binary_path, size_t offset)
+{
+	const char *file = "/sys/kernel/debug/tracing/uprobe_events";
+
+	return append_to_file(file, "%c:%s/%s %s:0x%zx",
+			      retprobe ? 'r' : 'p',
+			      retprobe ? "uretprobes" : "uprobes",
+			      probe_name, binary_path, offset);
+}
+
+static inline int remove_uprobe_event_legacy(const char *probe_name, bool retprobe)
+{
+	const char *file = "/sys/kernel/debug/tracing/uprobe_events";
+
+	return append_to_file(file, "-:%s/%s", retprobe ? "uretprobes" : "uprobes", probe_name);
+}
+
+static int determine_uprobe_perf_type_legacy(const char *probe_name, bool retprobe)
+{
+	char file[512];
+
+	snprintf(file, sizeof(file),
+		 "/sys/kernel/debug/tracing/events/%s/%s/id",
+		 retprobe ? "uretprobes" : "uprobes", probe_name);
+
+	return parse_uint_from_file(file, "%d\n");
+}
+
+static int perf_event_uprobe_open_legacy(const char *probe_name, bool retprobe,
+					 const char *binary_path, size_t offset, int pid)
+{
+	struct perf_event_attr attr;
+	int type, pfd, err;
+
+	err = add_uprobe_event_legacy(probe_name, retprobe, binary_path, offset);
+	if (err < 0) {
+		pr_warn("failed to add legacy uprobe event for %s:0x%zx: %d\n",
+			binary_path, (size_t)offset, err);
+		return err;
+	}
+	type = determine_uprobe_perf_type_legacy(probe_name, retprobe);
+	if (type < 0) {
+		pr_warn("failed to determine legacy uprobe event id for %s:0x%zx: %d\n",
+			binary_path, offset, err);
+		return type;
+	}
+
+	memset(&attr, 0, sizeof(attr));
+	attr.size = sizeof(attr);
+	attr.config = type;
+	attr.type = PERF_TYPE_TRACEPOINT;
+
+	pfd = syscall(__NR_perf_event_open, &attr,
+		      pid < 0 ? -1 : pid, /* pid */
+		      pid == -1 ? 0 : -1, /* cpu */
+		      -1 /* group_fd */,  PERF_FLAG_FD_CLOEXEC);
+	if (pfd < 0) {
+		err = -errno;
+		pr_warn("legacy uprobe perf_event_open() failed: %d\n", err);
+		return err;
+	}
+	return pfd;
+}
+
 LIBBPF_API struct bpf_link *
 bpf_program__attach_uprobe_opts(const struct bpf_program *prog, pid_t pid,
 				const char *binary_path, size_t func_offset,
 				const struct bpf_uprobe_opts *opts)
 {
 	DECLARE_LIBBPF_OPTS(bpf_perf_event_opts, pe_opts);
-	char errmsg[STRERR_BUFSIZE];
+	char errmsg[STRERR_BUFSIZE], *legacy_probe = NULL;
 	struct bpf_link *link;
 	size_t ref_ctr_off;
 	int pfd, err;
-	bool retprobe;
+	bool retprobe, legacy;
 
 	if (!OPTS_VALID(opts, bpf_uprobe_opts))
 		return libbpf_err_ptr(-EINVAL);
@@ -9469,15 +9552,35 @@ bpf_program__attach_uprobe_opts(const struct bpf_program *prog, pid_t pid,
 	ref_ctr_off = OPTS_GET(opts, ref_ctr_offset, 0);
 	pe_opts.bpf_cookie = OPTS_GET(opts, bpf_cookie, 0);
 
-	pfd = perf_event_open_probe(true /* uprobe */, retprobe, binary_path,
-				    func_offset, pid, ref_ctr_off);
+	legacy = determine_uprobe_perf_type() < 0;
+	if (!legacy) {
+		pfd = perf_event_open_probe(true /* uprobe */, retprobe, binary_path,
+					    func_offset, pid, ref_ctr_off);
+	} else {
+		char probe_name[512];
+
+		if (ref_ctr_off)
+			return libbpf_err_ptr(-EINVAL);
+
+		gen_uprobe_legacy_event_name(probe_name, sizeof(probe_name),
+					     binary_path, func_offset);
+
+		legacy_probe = strdup(probe_name);
+		if (!legacy_probe)
+			return libbpf_err_ptr(-ENOMEM);
+
+		pfd = perf_event_uprobe_open_legacy(legacy_probe, retprobe,
+						    binary_path, func_offset, pid);
+	}
 	if (pfd < 0) {
+		err = -errno;
 		pr_warn("prog '%s': failed to create %s '%s:0x%zx' perf event: %s\n",
 			prog->name, retprobe ? "uretprobe" : "uprobe",
 			binary_path, func_offset,
-			libbpf_strerror_r(pfd, errmsg, sizeof(errmsg)));
-		return libbpf_err_ptr(pfd);
+			libbpf_strerror_r(err, errmsg, sizeof(errmsg)));
+		goto err_out;
 	}
+
 	link = bpf_program__attach_perf_event_opts(prog, pfd, &pe_opts);
 	err = libbpf_get_error(link);
 	if (err) {
@@ -9486,9 +9589,20 @@ bpf_program__attach_uprobe_opts(const struct bpf_program *prog, pid_t pid,
 			prog->name, retprobe ? "uretprobe" : "uprobe",
 			binary_path, func_offset,
 			libbpf_strerror_r(err, errmsg, sizeof(errmsg)));
-		return libbpf_err_ptr(err);
+		goto err_out;
+	}
+	if (legacy) {
+		struct bpf_link_perf *perf_link = container_of(link, struct bpf_link_perf, link);
+
+		perf_link->legacy_probe_name = legacy_probe;
+		perf_link->legacy_is_kprobe = false;
+		perf_link->legacy_is_retprobe = retprobe;
 	}
 	return link;
+err_out:
+	free(legacy_probe);
+	return libbpf_err_ptr(err);
+
 }
 
 struct bpf_link *bpf_program__attach_uprobe(const struct bpf_program *prog,
-- 
2.30.2

