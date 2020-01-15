Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7133813CCD7
	for <lists+bpf@lfdr.de>; Wed, 15 Jan 2020 20:09:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726362AbgAOTJK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 15 Jan 2020 14:09:10 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:6302 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726408AbgAOTJJ (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 15 Jan 2020 14:09:09 -0500
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00FJ6Uhj032166
        for <bpf@vger.kernel.org>; Wed, 15 Jan 2020 11:09:08 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=facebook;
 bh=NV7TS+75iDSwuIMyakiYMnCqDKkCl2ltmwicK3MpCKc=;
 b=N8AfD8rb0GdMVdOMtvhIgRmhlnOczorGN//jbHcv1wPuaKG8E399JqEOiqHCde7mAzbT
 nf6WK5hPxlRug4NDGqN/qZaFdHFlwC3Jihw5ynYPHCqvh8JpR9vqctmCT40v4s1TErFM
 TqApY5DOuoTcUJGMuQFIOB7zZFSoNDNy6YQ= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2xhwp4av2y-6
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 15 Jan 2020 11:09:08 -0800
Received: from intmgw001.03.ash8.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 15 Jan 2020 11:09:05 -0800
Received: by devbig012.ftw2.facebook.com (Postfix, from userid 137359)
        id 74B242EC18C3; Wed, 15 Jan 2020 11:08:58 -0800 (PST)
Smtp-Origin-Hostprefix: devbig
From:   Andrii Nakryiko <andriin@fb.com>
Smtp-Origin-Hostname: devbig012.ftw2.facebook.com
To:     <bpf@vger.kernel.org>, <netdev@vger.kernel.org>, <ast@fb.com>,
        <daniel@iogearbox.net>, <yhs@fb.com>
CC:     <andrii.nakryiko@gmail.com>, <kernel-team@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        Alexei Starovoitov <ast@kernel.org>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH v2 bpf-next] libbpf: support .text sub-calls relocations
Date:   Wed, 15 Jan 2020 11:08:56 -0800
Message-ID: <20200115190856.2391325-1-andriin@fb.com>
X-Mailer: git-send-email 2.17.1
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-15_02:2020-01-15,2020-01-15 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 suspectscore=0
 clxscore=1015 mlxscore=0 mlxlogscore=999 malwarescore=0 bulkscore=0
 phishscore=0 priorityscore=1501 spamscore=0 adultscore=0 impostorscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-2001150145
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The LLVM patch https://reviews.llvm.org/D72197 makes LLVM emit function call
relocations within the same section. This includes a default .text section,
which contains any BPF sub-programs. This wasn't the case before and so libbpf
was able to get a way with slightly simpler handling of subprogram call
relocations.

This patch adds support for .text section relocations. It needs to ensure
correct order of relocations, so does two passes:
- first, relocate .text instructions, if there are any relocations in it;
- then process all the other programs and copy over patched .text instructions
for all sub-program calls.

v1->v2:
- break early once .text program is processed.

Cc: Yonghong Song <yhs@fb.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Andrii Nakryiko <andriin@fb.com>
---
 tools/lib/bpf/libbpf.c | 29 ++++++++++++++++++++++-------
 1 file changed, 22 insertions(+), 7 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 0c229f00a67e..23868883477f 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -4692,13 +4692,7 @@ bpf_program__reloc_text(struct bpf_program *prog, struct bpf_object *obj,
 	size_t new_cnt;
 	int err;
 
-	if (prog->idx == obj->efile.text_shndx) {
-		pr_warn("relo in .text insn %d into off %d (insn #%d)\n",
-			relo->insn_idx, relo->sym_off, relo->sym_off / 8);
-		return -LIBBPF_ERRNO__RELOC;
-	}
-
-	if (prog->main_prog_cnt == 0) {
+	if (prog->idx != obj->efile.text_shndx && prog->main_prog_cnt == 0) {
 		text = bpf_object__find_prog_by_idx(obj, obj->efile.text_shndx);
 		if (!text) {
 			pr_warn("no .text section found yet relo into text exist\n");
@@ -4728,6 +4722,7 @@ bpf_program__reloc_text(struct bpf_program *prog, struct bpf_object *obj,
 			 text->insns_cnt, text->section_name,
 			 prog->section_name);
 	}
+
 	insn = &prog->insns[relo->insn_idx];
 	insn->imm += relo->sym_off / 8 + prog->main_prog_cnt - relo->insn_idx;
 	return 0;
@@ -4807,8 +4802,28 @@ bpf_object__relocate(struct bpf_object *obj, const char *targ_btf_path)
 			return err;
 		}
 	}
+	/* ensure .text is relocated first, as it's going to be copied as-is
+	 * later for sub-program calls
+	 */
+	for (i = 0; i < obj->nr_programs; i++) {
+		prog = &obj->programs[i];
+		if (prog->idx != obj->efile.text_shndx)
+			continue;
+
+		err = bpf_program__relocate(prog, obj);
+		if (err) {
+			pr_warn("failed to relocate '%s'\n", prog->section_name);
+			return err;
+		}
+		break;
+	}
+	/* now relocate everything but .text, which by now is relocated
+	 * properly, so we can copy raw sub-program instructions as is safely
+	 */
 	for (i = 0; i < obj->nr_programs; i++) {
 		prog = &obj->programs[i];
+		if (prog->idx == obj->efile.text_shndx)
+			continue;
 
 		err = bpf_program__relocate(prog, obj);
 		if (err) {
-- 
2.17.1

