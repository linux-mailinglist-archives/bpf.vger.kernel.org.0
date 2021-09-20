Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA891412950
	for <lists+bpf@lfdr.de>; Tue, 21 Sep 2021 01:18:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239668AbhITXUD convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Mon, 20 Sep 2021 19:20:03 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:7742 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232799AbhITXSC (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 20 Sep 2021 19:18:02 -0400
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18KHwI1J008496
        for <bpf@vger.kernel.org>; Mon, 20 Sep 2021 16:16:35 -0700
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3b6mgsnmw4-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 20 Sep 2021 16:16:35 -0700
Received: from intmgw001.27.prn2.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Mon, 20 Sep 2021 16:16:32 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 3666A487A9E1; Mon, 20 Sep 2021 16:16:30 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>
Subject: [PATCH bpf-next 3/4] libbpf: refactor and simplify legacy kprobe code
Date:   Mon, 20 Sep 2021 16:16:16 -0700
Message-ID: <20210920231617.3141867-4-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210920231617.3141867-1-andrii@kernel.org>
References: <20210920231617.3141867-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-GUID: UByT5-lawpbkLV8IXTIBqAJHTtOpCMuE
X-Proofpoint-ORIG-GUID: UByT5-lawpbkLV8IXTIBqAJHTtOpCMuE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-20_07,2021-09-20_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 suspectscore=0 mlxscore=0
 priorityscore=1501 clxscore=1034 phishscore=0 mlxlogscore=999 spamscore=0
 impostorscore=0 adultscore=0 bulkscore=0 lowpriorityscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109030001
 definitions=main-2109200135
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Refactor legacy kprobe handling code to follow the same logic as uprobe
legacy logic added in the next patchs:
  - add append_to_file() helper that makes it simpler to work with
    tracefs file-based interface for creating and deleting probes;
  - move out probe/event name generation outside of the code that
    adds/removes it, which simplifies bookkeeping significantly;
  - change the probe name format to start with "libbpf_" prefix and
    include offset within kernel function;
  - switch 'unsigned long' to 'size_t' for specifying kprobe offsets,
    which is consistent with how uprobes define that, simplifies
    printf()-ing internally, and also avoids unnecessary complications on
    architectures where sizeof(long) != sizeof(void *).

This patch also implicitly fixes the problem with invalid open() error
handling present in poke_kprobe_events(), which (the function) this
patch removes.

Fixes: ca304b40c20d ("libbpf: Introduce legacy kprobe events support")
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/libbpf.c | 159 ++++++++++++++++++++++-------------------
 tools/lib/bpf/libbpf.h |   2 +-
 2 files changed, 88 insertions(+), 73 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 6d2f12db6034..aa842f0721cb 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -9011,59 +9011,17 @@ int bpf_link__unpin(struct bpf_link *link)
 	return 0;
 }
 
-static int poke_kprobe_events(bool add, const char *name, bool retprobe, uint64_t offset)
-{
-	int fd, ret = 0;
-	pid_t p = getpid();
-	char cmd[260], probename[128], probefunc[128];
-	const char *file = "/sys/kernel/debug/tracing/kprobe_events";
-
-	if (retprobe)
-		snprintf(probename, sizeof(probename), "kretprobes/%s_libbpf_%u", name, p);
-	else
-		snprintf(probename, sizeof(probename), "kprobes/%s_libbpf_%u", name, p);
-
-	if (offset)
-		snprintf(probefunc, sizeof(probefunc), "%s+%zu", name, (size_t)offset);
-
-	if (add) {
-		snprintf(cmd, sizeof(cmd), "%c:%s %s",
-			 retprobe ? 'r' : 'p',
-			 probename,
-			 offset ? probefunc : name);
-	} else {
-		snprintf(cmd, sizeof(cmd), "-:%s", probename);
-	}
-
-	fd = open(file, O_WRONLY | O_APPEND, 0);
-	if (!fd)
-		return -errno;
-	ret = write(fd, cmd, strlen(cmd));
-	if (ret < 0)
-		ret = -errno;
-	close(fd);
-
-	return ret;
-}
-
-static inline int add_kprobe_event_legacy(const char *name, bool retprobe, uint64_t offset)
-{
-	return poke_kprobe_events(true, name, retprobe, offset);
-}
-
-static inline int remove_kprobe_event_legacy(const char *name, bool retprobe)
-{
-	return poke_kprobe_events(false, name, retprobe, 0);
-}
-
 struct bpf_link_perf {
 	struct bpf_link link;
 	int perf_event_fd;
 	/* legacy kprobe support: keep track of probe identifier and type */
 	char *legacy_probe_name;
+	bool legacy_is_kprobe;
 	bool legacy_is_retprobe;
 };
 
+static int remove_kprobe_event_legacy(const char *probe_name, bool retprobe);
+
 static int bpf_link_perf_detach(struct bpf_link *link)
 {
 	struct bpf_link_perf *perf_link = container_of(link, struct bpf_link_perf, link);
@@ -9077,9 +9035,12 @@ static int bpf_link_perf_detach(struct bpf_link *link)
 	close(link->fd);
 
 	/* legacy kprobe needs to be removed after perf event fd closure */
-	if (perf_link->legacy_probe_name)
-		err = remove_kprobe_event_legacy(perf_link->legacy_probe_name,
-						 perf_link->legacy_is_retprobe);
+	if (perf_link->legacy_probe_name) {
+		if (perf_link->legacy_is_kprobe) {
+			err = remove_kprobe_event_legacy(perf_link->legacy_probe_name,
+							 perf_link->legacy_is_retprobe);
+		}
+	}
 
 	return err;
 }
@@ -9202,18 +9163,6 @@ static int parse_uint_from_file(const char *file, const char *fmt)
 	return ret;
 }
 
-static int determine_kprobe_perf_type_legacy(const char *func_name, bool is_retprobe)
-{
-	char file[192];
-
-	snprintf(file, sizeof(file),
-		 "/sys/kernel/debug/tracing/events/%s/%s_libbpf_%d/id",
-		 is_retprobe ? "kretprobes" : "kprobes",
-		 func_name, getpid());
-
-	return parse_uint_from_file(file, "%d\n");
-}
-
 static int determine_kprobe_perf_type(void)
 {
 	const char *file = "/sys/bus/event_source/devices/kprobe/type";
@@ -9296,21 +9245,79 @@ static int perf_event_open_probe(bool uprobe, bool retprobe, const char *name,
 	return pfd;
 }
 
-static int perf_event_kprobe_open_legacy(bool retprobe, const char *name, uint64_t offset, int pid)
+static int append_to_file(const char *file, const char *fmt, ...)
+{
+	int fd, n, err = 0;
+	va_list ap;
+
+	fd = open(file, O_WRONLY | O_APPEND, 0);
+	if (fd < 0)
+		return -errno;
+
+	va_start(ap, fmt);
+	n = vdprintf(fd, fmt, ap);
+	va_end(ap);
+
+	if (n < 0)
+		err = -errno;
+
+	close(fd);
+	return err;
+}
+
+static void gen_kprobe_legacy_event_name(char *buf, size_t buf_sz,
+					 const char *kfunc_name, size_t offset)
+{
+	snprintf(buf, buf_sz, "libbpf_%u_%s_0x%zx", getpid(), kfunc_name, offset);
+}
+
+static int add_kprobe_event_legacy(const char *probe_name, bool retprobe,
+				   const char *kfunc_name, size_t offset)
+{
+	const char *file = "/sys/kernel/debug/tracing/kprobe_events";
+
+	return append_to_file(file, "%c:%s/%s %s+0x%zx",
+			      retprobe ? 'r' : 'p',
+			      retprobe ? "kretprobes" : "kprobes",
+			      probe_name, kfunc_name, offset);
+}
+
+static int remove_kprobe_event_legacy(const char *probe_name, bool retprobe)
+{
+	const char *file = "/sys/kernel/debug/tracing/kprobe_events";
+
+	return append_to_file(file, "-:%s/%s", retprobe ? "kretprobes" : "kprobes", probe_name);
+}
+
+static int determine_kprobe_perf_type_legacy(const char *probe_name, bool retprobe)
+{
+	char file[256];
+
+	snprintf(file, sizeof(file),
+		 "/sys/kernel/debug/tracing/events/%s/%s/id",
+		 retprobe ? "kretprobes" : "kprobes", probe_name);
+
+	return parse_uint_from_file(file, "%d\n");
+}
+
+static int perf_event_kprobe_open_legacy(const char *probe_name, bool retprobe,
+					 const char *kfunc_name, size_t offset, int pid)
 {
 	struct perf_event_attr attr = {};
 	char errmsg[STRERR_BUFSIZE];
 	int type, pfd, err;
 
-	err = add_kprobe_event_legacy(name, retprobe, offset);
+	err = add_kprobe_event_legacy(probe_name, retprobe, kfunc_name, offset);
 	if (err < 0) {
-		pr_warn("failed to add legacy kprobe event: %s\n",
+		pr_warn("failed to add legacy kprobe event for '%s+0x%zx': %s\n",
+			kfunc_name, offset,
 			libbpf_strerror_r(err, errmsg, sizeof(errmsg)));
 		return err;
 	}
-	type = determine_kprobe_perf_type_legacy(name, retprobe);
+	type = determine_kprobe_perf_type_legacy(probe_name, retprobe);
 	if (type < 0) {
-		pr_warn("failed to determine legacy kprobe event id: %s\n",
+		pr_warn("failed to determine legacy kprobe event id for '%s+0x%zx': %s\n",
+			kfunc_name, offset,
 			libbpf_strerror_r(type, errmsg, sizeof(errmsg)));
 		return type;
 	}
@@ -9340,7 +9347,7 @@ bpf_program__attach_kprobe_opts(const struct bpf_program *prog,
 	char errmsg[STRERR_BUFSIZE];
 	char *legacy_probe = NULL;
 	struct bpf_link *link;
-	unsigned long offset;
+	size_t offset;
 	bool retprobe, legacy;
 	int pfd, err;
 
@@ -9357,17 +9364,23 @@ bpf_program__attach_kprobe_opts(const struct bpf_program *prog,
 					    func_name, offset,
 					    -1 /* pid */, 0 /* ref_ctr_off */);
 	} else {
+		char probe_name[256];
+
+		gen_kprobe_legacy_event_name(probe_name, sizeof(probe_name),
+					     func_name, offset);
+
 		legacy_probe = strdup(func_name);
 		if (!legacy_probe)
 			return libbpf_err_ptr(-ENOMEM);
 
-		pfd = perf_event_kprobe_open_legacy(retprobe, func_name,
+		pfd = perf_event_kprobe_open_legacy(legacy_probe, retprobe, func_name,
 						    offset, -1 /* pid */);
 	}
 	if (pfd < 0) {
-		err = pfd;
-		pr_warn("prog '%s': failed to create %s '%s' perf event: %s\n",
-			prog->name, retprobe ? "kretprobe" : "kprobe", func_name,
+		err = -errno;
+		pr_warn("prog '%s': failed to create %s '%s+0x%zx' perf event: %s\n",
+			prog->name, retprobe ? "kretprobe" : "kprobe",
+			func_name, offset,
 			libbpf_strerror_r(err, errmsg, sizeof(errmsg)));
 		goto err_out;
 	}
@@ -9375,8 +9388,9 @@ bpf_program__attach_kprobe_opts(const struct bpf_program *prog,
 	err = libbpf_get_error(link);
 	if (err) {
 		close(pfd);
-		pr_warn("prog '%s': failed to attach to %s '%s': %s\n",
-			prog->name, retprobe ? "kretprobe" : "kprobe", func_name,
+		pr_warn("prog '%s': failed to attach to %s '%s+0x%zx': %s\n",
+			prog->name, retprobe ? "kretprobe" : "kprobe",
+			func_name, offset,
 			libbpf_strerror_r(err, errmsg, sizeof(errmsg)));
 		goto err_out;
 	}
@@ -9384,6 +9398,7 @@ bpf_program__attach_kprobe_opts(const struct bpf_program *prog,
 		struct bpf_link_perf *perf_link = container_of(link, struct bpf_link_perf, link);
 
 		perf_link->legacy_probe_name = legacy_probe;
+		perf_link->legacy_is_kprobe = true;
 		perf_link->legacy_is_retprobe = retprobe;
 	}
 
diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index c90e3d79e72c..262eb3038e83 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -269,7 +269,7 @@ struct bpf_kprobe_opts {
 	/* custom user-provided value fetchable through bpf_get_attach_cookie() */
 	__u64 bpf_cookie;
 	/* function's offset to install kprobe to */
-	unsigned long offset;
+	size_t offset;
 	/* kprobe is return probe */
 	bool retprobe;
 	size_t :0;
-- 
2.30.2

