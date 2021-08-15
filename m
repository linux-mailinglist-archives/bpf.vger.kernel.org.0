Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA2A93EC7D7
	for <lists+bpf@lfdr.de>; Sun, 15 Aug 2021 09:07:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235457AbhHOHHn convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Sun, 15 Aug 2021 03:07:43 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:6372 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235480AbhHOHHV (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sun, 15 Aug 2021 03:07:21 -0400
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17F6xAAc026213
        for <bpf@vger.kernel.org>; Sun, 15 Aug 2021 00:06:49 -0700
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3aebnwbk5g-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Sun, 15 Aug 2021 00:06:49 -0700
Received: from intmgw006.03.ash8.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:11d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Sun, 15 Aug 2021 00:06:47 -0700
Received: by devbig012.ftw2.facebook.com (Postfix, from userid 137359)
        id 3BC4C3D405A0; Sun, 15 Aug 2021 00:06:41 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH v5 bpf-next 15/16] libbpf: add uprobe ref counter offset support for USDT semaphores
Date:   Sun, 15 Aug 2021 00:06:08 -0700
Message-ID: <20210815070609.987780-16-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210815070609.987780-1-andrii@kernel.org>
References: <20210815070609.987780-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-ORIG-GUID: u8w56NKgmBYQTBuPSg2FExBMVcK3fui5
X-Proofpoint-GUID: u8w56NKgmBYQTBuPSg2FExBMVcK3fui5
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-15_02:2021-08-13,2021-08-15 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 impostorscore=0
 priorityscore=1501 malwarescore=0 phishscore=0 lowpriorityscore=0
 adultscore=0 bulkscore=0 clxscore=1015 mlxlogscore=999 suspectscore=0
 mlxscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108150048
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

When attaching to uprobes through perf subsystem, it's possible to specify
offset of a so-called USDT semaphore, which is just a reference counted u16,
used by kernel to keep track of how many tracers are attached to a given
location. Support for this feature was added in [0], so just wire this through
uprobe_opts. This is important to enable implementing USDT attachment and
tracing through libbpf's bpf_program__attach_uprobe_opts() API.

  [0] a6ca88b241d5 ("trace_uprobe: support reference counter in fd-based uprobe")

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/libbpf.c | 17 +++++++++++++----
 tools/lib/bpf/libbpf.h |  4 ++++
 2 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 62ce878cb8e0..88d8825fc6f6 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -9152,13 +9152,19 @@ static int determine_uprobe_retprobe_bit(void)
 	return parse_uint_from_file(file, "config:%d\n");
 }
 
+#define PERF_UPROBE_REF_CTR_OFFSET_BITS 32
+#define PERF_UPROBE_REF_CTR_OFFSET_SHIFT 32
+
 static int perf_event_open_probe(bool uprobe, bool retprobe, const char *name,
-				 uint64_t offset, int pid)
+				 uint64_t offset, int pid, size_t ref_ctr_off)
 {
 	struct perf_event_attr attr = {};
 	char errmsg[STRERR_BUFSIZE];
 	int type, pfd, err;
 
+	if (ref_ctr_off >= (1ULL << PERF_UPROBE_REF_CTR_OFFSET_BITS))
+		return -EINVAL;
+
 	type = uprobe ? determine_uprobe_perf_type()
 		      : determine_kprobe_perf_type();
 	if (type < 0) {
@@ -9181,6 +9187,7 @@ static int perf_event_open_probe(bool uprobe, bool retprobe, const char *name,
 	}
 	attr.size = sizeof(attr);
 	attr.type = type;
+	attr.config |= (__u64)ref_ctr_off << PERF_UPROBE_REF_CTR_OFFSET_SHIFT;
 	attr.config1 = ptr_to_u64(name); /* kprobe_func or uprobe_path */
 	attr.config2 = offset;		 /* kprobe_addr or probe_offset */
 
@@ -9219,7 +9226,7 @@ bpf_program__attach_kprobe_opts(struct bpf_program *prog,
 	pe_opts.bpf_cookie = OPTS_GET(opts, bpf_cookie, 0);
 
 	pfd = perf_event_open_probe(false /* uprobe */, retprobe, func_name,
-				    offset, -1 /* pid */);
+				    offset, -1 /* pid */, 0 /* ref_ctr_off */);
 	if (pfd < 0) {
 		pr_warn("prog '%s': failed to create %s '%s' perf event: %s\n",
 			prog->name, retprobe ? "kretprobe" : "kprobe", func_name,
@@ -9289,6 +9296,7 @@ bpf_program__attach_uprobe_opts(struct bpf_program *prog, pid_t pid,
 	DECLARE_LIBBPF_OPTS(bpf_perf_event_opts, pe_opts);
 	char errmsg[STRERR_BUFSIZE];
 	struct bpf_link *link;
+	size_t ref_ctr_off;
 	int pfd, err;
 	bool retprobe;
 
@@ -9296,10 +9304,11 @@ bpf_program__attach_uprobe_opts(struct bpf_program *prog, pid_t pid,
 		return libbpf_err_ptr(-EINVAL);
 
 	retprobe = OPTS_GET(opts, retprobe, false);
+	ref_ctr_off = OPTS_GET(opts, ref_ctr_offset, 0);
 	pe_opts.bpf_cookie = OPTS_GET(opts, bpf_cookie, 0);
 
-	pfd = perf_event_open_probe(true /* uprobe */, retprobe,
-				    binary_path, func_offset, pid);
+	pfd = perf_event_open_probe(true /* uprobe */, retprobe, binary_path,
+				    func_offset, pid, ref_ctr_off);
 	if (pfd < 0) {
 		pr_warn("prog '%s': failed to create %s '%s:0x%zx' perf event: %s\n",
 			prog->name, retprobe ? "uretprobe" : "uprobe",
diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index 1f4a67285365..f177d897c5f7 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -284,6 +284,10 @@ bpf_program__attach_kprobe_opts(struct bpf_program *prog,
 struct bpf_uprobe_opts {
 	/* size of this struct, for forward/backward compatiblity */
 	size_t sz;
+	/* offset of kernel reference counted USDT semaphore, added in
+	 * a6ca88b241d5 ("trace_uprobe: support reference counter in fd-based uprobe")
+	 */
+	size_t ref_ctr_offset;
 	/* custom user-provided value fetchable through bpf_get_attach_cookie() */
 	__u64 bpf_cookie;
 	/* uprobe is return probe, invoked at function return time */
-- 
2.30.2

