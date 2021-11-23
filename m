Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BF4345ACF8
	for <lists+bpf@lfdr.de>; Tue, 23 Nov 2021 21:01:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239343AbhKWUEf convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Tue, 23 Nov 2021 15:04:35 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:4356 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S239128AbhKWUEd (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 23 Nov 2021 15:04:33 -0500
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.1.2/8.16.1.2) with SMTP id 1ANIdVUb031347
        for <bpf@vger.kernel.org>; Tue, 23 Nov 2021 12:01:24 -0800
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0001303.ppops.net with ESMTP id 3ch07y3atq-14
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 23 Nov 2021 12:01:24 -0800
Received: from intmgw002.48.prn1.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:21d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Tue, 23 Nov 2021 12:01:18 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 7E7C3A5FEC98; Tue, 23 Nov 2021 12:01:06 -0800 (PST)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>,
        Song Liu <songliubraving@fb.com>
Subject: [PATCH v2 bpf-next 1/2] libbpf: load global data maps lazily on legacy kernels
Date:   Tue, 23 Nov 2021 12:01:04 -0800
Message-ID: <20211123200105.387855-1-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-ORIG-GUID: foMUEDSh5jz1F7E4XTh_lylKGyok8Lyu
X-Proofpoint-GUID: foMUEDSh5jz1F7E4XTh_lylKGyok8Lyu
Content-Transfer-Encoding: 8BIT
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-23_07,2021-11-23_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 impostorscore=0
 malwarescore=0 mlxscore=0 priorityscore=1501 spamscore=0 phishscore=0
 clxscore=1015 lowpriorityscore=0 mlxlogscore=999 bulkscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111230098
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Load global data maps lazily, if kernel is too old to support global
data. Make sure that programs are still correct by detecting if any of
the to-be-loaded programs have relocation against any of such maps.

This allows to solve the issue ([0]) with bpf_printk() and Clang
generating unnecessary and unreferenced .rodata.strX.Y sections, but it
also goes further along the CO-RE lines, allowing to have a BPF object
in which some code can work on very old kernels and relies only on BPF
maps explicitly, while other BPF programs might enjoy global variable
support. If such programs are correctly set to not load at runtime on
old kernels, bpf_object will load and function correctly now.

  [0] https://lore.kernel.org/bpf/CAK-59YFPU3qO+_pXWOH+c1LSA=8WA1yabJZfREjOEXNHAqgXNg@mail.gmail.com/

Fixes: aed659170a31 ("libbpf: Support multiple .rodata.* and .data.* BPF maps")
Acked-by: Song Liu <songliubraving@fb.com>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/libbpf.c | 34 ++++++++++++++++++++++++++++++----
 1 file changed, 30 insertions(+), 4 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index af405c38aadc..27695bf31250 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -5006,6 +5006,24 @@ bpf_object__create_maps(struct bpf_object *obj)
 	for (i = 0; i < obj->nr_maps; i++) {
 		map = &obj->maps[i];
 
+		/* To support old kernels, we skip creating global data maps
+		 * (.rodata, .data, .kconfig, etc); later on, during program
+		 * loading, if we detect that at least one of the to-be-loaded
+		 * programs is referencing any global data map, we'll error
+		 * out with program name and relocation index logged.
+		 * This approach allows to accommodate Clang emitting
+		 * unnecessary .rodata.str1.1 sections for string literals,
+		 * but also it allows to have CO-RE applications that use
+		 * global variables in some of BPF programs, but not others.
+		 * If those global variable-using programs are not loaded at
+		 * runtime due to bpf_program__set_autoload(prog, false),
+		 * bpf_object loading will succeed just fine even on old
+		 * kernels.
+		 */
+		if (bpf_map__is_internal(map) &&
+		    !kernel_supports(obj, FEAT_GLOBAL_DATA))
+			continue;
+
 		retried = false;
 retry:
 		if (map->pin_path) {
@@ -5605,6 +5623,14 @@ bpf_object__relocate_data(struct bpf_object *obj, struct bpf_program *prog)
 				insn[0].src_reg = BPF_PSEUDO_MAP_IDX_VALUE;
 				insn[0].imm = relo->map_idx;
 			} else {
+				const struct bpf_map *map = &obj->maps[relo->map_idx];
+
+				if (bpf_map__is_internal(map) &&
+				    !kernel_supports(obj, FEAT_GLOBAL_DATA)) {
+					pr_warn("prog '%s': relo #%d: kernel doesn't support global data\n",
+						prog->name, i);
+					return -ENOTSUP;
+				}
 				insn[0].src_reg = BPF_PSEUDO_MAP_VALUE;
 				insn[0].imm = obj->maps[relo->map_idx].fd;
 			}
@@ -6139,6 +6165,8 @@ bpf_object__relocate(struct bpf_object *obj, const char *targ_btf_path)
 		 */
 		if (prog_is_subprog(obj, prog))
 			continue;
+		if (!prog->load)
+			continue;
 
 		err = bpf_object__relocate_calls(obj, prog);
 		if (err) {
@@ -6152,6 +6180,8 @@ bpf_object__relocate(struct bpf_object *obj, const char *targ_btf_path)
 		prog = &obj->programs[i];
 		if (prog_is_subprog(obj, prog))
 			continue;
+		if (!prog->load)
+			continue;
 		err = bpf_object__relocate_data(obj, prog);
 		if (err) {
 			pr_warn("prog '%s': failed to relocate data references: %d\n",
@@ -6939,10 +6969,6 @@ static int bpf_object__sanitize_maps(struct bpf_object *obj)
 	bpf_object__for_each_map(m, obj) {
 		if (!bpf_map__is_internal(m))
 			continue;
-		if (!kernel_supports(obj, FEAT_GLOBAL_DATA)) {
-			pr_warn("kernel doesn't support global data\n");
-			return -ENOTSUP;
-		}
 		if (!kernel_supports(obj, FEAT_ARRAY_MMAP))
 			m->def.map_flags ^= BPF_F_MMAPABLE;
 	}
-- 
2.30.2

