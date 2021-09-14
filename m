Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEFCD40A2CC
	for <lists+bpf@lfdr.de>; Tue, 14 Sep 2021 03:47:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237048AbhINBtF convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Mon, 13 Sep 2021 21:49:05 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:26248 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235632AbhINBtC (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 13 Sep 2021 21:49:02 -0400
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.0.43) with SMTP id 18DM9bv9010579
        for <bpf@vger.kernel.org>; Mon, 13 Sep 2021 18:47:45 -0700
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3b1wgtf8ek-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 13 Sep 2021 18:47:45 -0700
Received: from intmgw003.48.prn1.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::e) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Mon, 13 Sep 2021 18:47:45 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 4A3FD3F9D7C4; Mon, 13 Sep 2021 18:47:41 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>
Subject: [PATCH bpf-next 3/4] libbpf: simplify BPF program auto-attach code
Date:   Mon, 13 Sep 2021 18:47:32 -0700
Message-ID: <20210914014733.2768-4-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210914014733.2768-1-andrii@kernel.org>
References: <20210914014733.2768-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-GUID: kjiq6WqOTpgXSol5L6-609PJ2Wlotbax
X-Proofpoint-ORIG-GUID: kjiq6WqOTpgXSol5L6-609PJ2Wlotbax
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-13_09,2021-09-09_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0 phishscore=0
 impostorscore=0 suspectscore=0 mlxlogscore=848 bulkscore=0 adultscore=0
 clxscore=1015 malwarescore=0 priorityscore=1501 spamscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109030001 definitions=main-2109140010
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Remove the need to explicitly pass bpf_sec_def for auto-attachable BPF
programs, as it is already recorded at bpf_object__open() time for all
recognized type of BPF programs. This further reduces number of explicit
calls to find_sec_def(), simplifying further refactorings.

No functional changes are done by this patch.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/libbpf.c | 61 +++++++++++++++---------------------------
 1 file changed, 22 insertions(+), 39 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index c8a751d03b22..cdf5249e6353 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -218,8 +218,7 @@ struct reloc_desc {
 
 struct bpf_sec_def;
 
-typedef struct bpf_link *(*attach_fn_t)(const struct bpf_sec_def *sec,
-					struct bpf_program *prog);
+typedef struct bpf_link *(*attach_fn_t)(struct bpf_program *prog);
 
 struct bpf_sec_def {
 	const char *sec;
@@ -7920,18 +7919,12 @@ void bpf_program__set_expected_attach_type(struct bpf_program *prog,
 	__VA_ARGS__							    \
 }
 
-static struct bpf_link *attach_kprobe(const struct bpf_sec_def *sec,
-				      struct bpf_program *prog);
-static struct bpf_link *attach_tp(const struct bpf_sec_def *sec,
-				  struct bpf_program *prog);
-static struct bpf_link *attach_raw_tp(const struct bpf_sec_def *sec,
-				      struct bpf_program *prog);
-static struct bpf_link *attach_trace(const struct bpf_sec_def *sec,
-				     struct bpf_program *prog);
-static struct bpf_link *attach_lsm(const struct bpf_sec_def *sec,
-				   struct bpf_program *prog);
-static struct bpf_link *attach_iter(const struct bpf_sec_def *sec,
-				    struct bpf_program *prog);
+static struct bpf_link *attach_kprobe(struct bpf_program *prog);
+static struct bpf_link *attach_tp(struct bpf_program *prog);
+static struct bpf_link *attach_raw_tp(struct bpf_program *prog);
+static struct bpf_link *attach_trace(struct bpf_program *prog);
+static struct bpf_link *attach_lsm(struct bpf_program *prog);
+static struct bpf_link *attach_iter(struct bpf_program *prog);
 
 static const struct bpf_sec_def section_defs[] = {
 	BPF_PROG_SEC("socket",			BPF_PROG_TYPE_SOCKET_FILTER),
@@ -9271,8 +9264,7 @@ struct bpf_link *bpf_program__attach_kprobe(struct bpf_program *prog,
 	return bpf_program__attach_kprobe_opts(prog, func_name, &opts);
 }
 
-static struct bpf_link *attach_kprobe(const struct bpf_sec_def *sec,
-				      struct bpf_program *prog)
+static struct bpf_link *attach_kprobe(struct bpf_program *prog)
 {
 	DECLARE_LIBBPF_OPTS(bpf_kprobe_opts, opts);
 	unsigned long offset = 0;
@@ -9281,8 +9273,8 @@ static struct bpf_link *attach_kprobe(const struct bpf_sec_def *sec,
 	char *func;
 	int n, err;
 
-	func_name = prog->sec_name + sec->len;
-	opts.retprobe = strcmp(sec->sec, "kretprobe/") == 0;
+	func_name = prog->sec_name + prog->sec_def->len;
+	opts.retprobe = strcmp(prog->sec_def->sec, "kretprobe/") == 0;
 
 	n = sscanf(func_name, "%m[a-zA-Z0-9_.]+%li", &func, &offset);
 	if (n < 1) {
@@ -9445,8 +9437,7 @@ struct bpf_link *bpf_program__attach_tracepoint(struct bpf_program *prog,
 	return bpf_program__attach_tracepoint_opts(prog, tp_category, tp_name, NULL);
 }
 
-static struct bpf_link *attach_tp(const struct bpf_sec_def *sec,
-				  struct bpf_program *prog)
+static struct bpf_link *attach_tp(struct bpf_program *prog)
 {
 	char *sec_name, *tp_cat, *tp_name;
 	struct bpf_link *link;
@@ -9456,7 +9447,7 @@ static struct bpf_link *attach_tp(const struct bpf_sec_def *sec,
 		return libbpf_err_ptr(-ENOMEM);
 
 	/* extract "tp/<category>/<name>" */
-	tp_cat = sec_name + sec->len;
+	tp_cat = sec_name + prog->sec_def->len;
 	tp_name = strchr(tp_cat, '/');
 	if (!tp_name) {
 		free(sec_name);
@@ -9500,10 +9491,9 @@ struct bpf_link *bpf_program__attach_raw_tracepoint(struct bpf_program *prog,
 	return link;
 }
 
-static struct bpf_link *attach_raw_tp(const struct bpf_sec_def *sec,
-				      struct bpf_program *prog)
+static struct bpf_link *attach_raw_tp(struct bpf_program *prog)
 {
-	const char *tp_name = prog->sec_name + sec->len;
+	const char *tp_name = prog->sec_name + prog->sec_def->len;
 
 	return bpf_program__attach_raw_tracepoint(prog, tp_name);
 }
@@ -9548,14 +9538,12 @@ struct bpf_link *bpf_program__attach_lsm(struct bpf_program *prog)
 	return bpf_program__attach_btf_id(prog);
 }
 
-static struct bpf_link *attach_trace(const struct bpf_sec_def *sec,
-				     struct bpf_program *prog)
+static struct bpf_link *attach_trace(struct bpf_program *prog)
 {
 	return bpf_program__attach_trace(prog);
 }
 
-static struct bpf_link *attach_lsm(const struct bpf_sec_def *sec,
-				   struct bpf_program *prog)
+static struct bpf_link *attach_lsm(struct bpf_program *prog)
 {
 	return bpf_program__attach_lsm(prog);
 }
@@ -9686,21 +9674,17 @@ bpf_program__attach_iter(struct bpf_program *prog,
 	return link;
 }
 
-static struct bpf_link *attach_iter(const struct bpf_sec_def *sec,
-				    struct bpf_program *prog)
+static struct bpf_link *attach_iter(struct bpf_program *prog)
 {
 	return bpf_program__attach_iter(prog, NULL);
 }
 
 struct bpf_link *bpf_program__attach(struct bpf_program *prog)
 {
-	const struct bpf_sec_def *sec_def;
-
-	sec_def = find_sec_def(prog->sec_name);
-	if (!sec_def || !sec_def->attach_fn)
+	if (!prog->sec_def || !prog->sec_def->attach_fn)
 		return libbpf_err_ptr(-ESRCH);
 
-	return sec_def->attach_fn(sec_def, prog);
+	return prog->sec_def->attach_fn(prog);
 }
 
 static int bpf_link__detach_struct_ops(struct bpf_link *link)
@@ -10779,16 +10763,15 @@ int bpf_object__attach_skeleton(struct bpf_object_skeleton *s)
 	for (i = 0; i < s->prog_cnt; i++) {
 		struct bpf_program *prog = *s->progs[i].prog;
 		struct bpf_link **link = s->progs[i].link;
-		const struct bpf_sec_def *sec_def;
 
 		if (!prog->load)
 			continue;
 
-		sec_def = find_sec_def(prog->sec_name);
-		if (!sec_def || !sec_def->attach_fn)
+		/* auto-attaching not supported for this program */
+		if (!prog->sec_def || !prog->sec_def->attach_fn)
 			continue;
 
-		*link = sec_def->attach_fn(sec_def, prog);
+		*link = prog->sec_def->attach_fn(prog);
 		err = libbpf_get_error(*link);
 		if (err) {
 			pr_warn("failed to auto-attach program '%s': %d\n",
-- 
2.30.2

