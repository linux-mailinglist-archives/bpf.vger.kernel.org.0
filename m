Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 895FC447A66
	for <lists+bpf@lfdr.de>; Mon,  8 Nov 2021 07:13:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233642AbhKHGQb convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Mon, 8 Nov 2021 01:16:31 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:38244 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237689AbhKHGQa (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 8 Nov 2021 01:16:30 -0500
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1A80xwfZ027649
        for <bpf@vger.kernel.org>; Sun, 7 Nov 2021 22:13:46 -0800
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3c6gykkhkk-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Sun, 07 Nov 2021 22:13:46 -0800
Received: from intmgw002.25.frc3.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Sun, 7 Nov 2021 22:13:45 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id E66DD84C49D8; Sun,  7 Nov 2021 22:13:39 -0800 (PST)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>
Subject: [PATCH bpf-next 11/11] bpftool: update btf_dump__new() and perf_buffer__new_raw() calls
Date:   Sun, 7 Nov 2021 22:13:16 -0800
Message-ID: <20211108061316.203217-12-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211108061316.203217-1-andrii@kernel.org>
References: <20211108061316.203217-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-ORIG-GUID: rDHCutxK2sOCc-BNIRko9vt1S5wHGPKE
X-Proofpoint-GUID: rDHCutxK2sOCc-BNIRko9vt1S5wHGPKE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-08_01,2021-11-03_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 clxscore=1015 spamscore=0
 mlxscore=0 malwarescore=0 adultscore=0 priorityscore=1501 bulkscore=0
 mlxlogscore=999 suspectscore=0 phishscore=0 impostorscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111080040
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Use v1.0-compatible variants of btf_dump and perf_buffer "constructors".
This is also a demonstration of reusing struct perf_buffer_raw_opts as
OPTS-style option struct for new perf_buffer__new_raw() API.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/bpf/bpftool/btf.c           | 2 +-
 tools/bpf/bpftool/gen.c           | 2 +-
 tools/bpf/bpftool/map_perf_ring.c | 9 +++------
 3 files changed, 5 insertions(+), 8 deletions(-)

diff --git a/tools/bpf/bpftool/btf.c b/tools/bpf/bpftool/btf.c
index 015d2758f826..223ac7676027 100644
--- a/tools/bpf/bpftool/btf.c
+++ b/tools/bpf/bpftool/btf.c
@@ -418,7 +418,7 @@ static int dump_btf_c(const struct btf *btf,
 	struct btf_dump *d;
 	int err = 0, i;
 
-	d = btf_dump__new(btf, NULL, NULL, btf_dump_printf);
+	d = btf_dump__new(btf, btf_dump_printf, NULL, NULL);
 	if (IS_ERR(d))
 		return PTR_ERR(d);
 
diff --git a/tools/bpf/bpftool/gen.c b/tools/bpf/bpftool/gen.c
index 5c18351290f0..89f0e828bbfa 100644
--- a/tools/bpf/bpftool/gen.c
+++ b/tools/bpf/bpftool/gen.c
@@ -218,7 +218,7 @@ static int codegen_datasecs(struct bpf_object *obj, const char *obj_name)
 	char sec_ident[256], map_ident[256];
 	int i, err = 0;
 
-	d = btf_dump__new(btf, NULL, NULL, codegen_btf_dump_printf);
+	d = btf_dump__new(btf, codegen_btf_dump_printf, NULL, NULL);
 	if (IS_ERR(d))
 		return PTR_ERR(d);
 
diff --git a/tools/bpf/bpftool/map_perf_ring.c b/tools/bpf/bpftool/map_perf_ring.c
index b98ea702d284..6b0c410152de 100644
--- a/tools/bpf/bpftool/map_perf_ring.c
+++ b/tools/bpf/bpftool/map_perf_ring.c
@@ -124,7 +124,7 @@ int do_event_pipe(int argc, char **argv)
 		.wakeup_events = 1,
 	};
 	struct bpf_map_info map_info = {};
-	struct perf_buffer_raw_opts opts = {};
+	LIBBPF_OPTS(perf_buffer_raw_opts, opts);
 	struct event_pipe_ctx ctx = {
 		.all_cpus = true,
 		.cpu = -1,
@@ -190,14 +190,11 @@ int do_event_pipe(int argc, char **argv)
 		ctx.idx = 0;
 	}
 
-	opts.attr = &perf_attr;
-	opts.event_cb = print_bpf_output;
-	opts.ctx = &ctx;
 	opts.cpu_cnt = ctx.all_cpus ? 0 : 1;
 	opts.cpus = &ctx.cpu;
 	opts.map_keys = &ctx.idx;
-
-	pb = perf_buffer__new_raw(map_fd, MMAP_PAGE_CNT, &opts);
+	pb = perf_buffer__new_raw(map_fd, MMAP_PAGE_CNT, &perf_attr,
+				  print_bpf_output, &ctx, &opts);
 	err = libbpf_get_error(pb);
 	if (err) {
 		p_err("failed to create perf buffer: %s (%d)",
-- 
2.30.2

