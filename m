Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D9E5471F14
	for <lists+bpf@lfdr.de>; Mon, 13 Dec 2021 02:07:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230448AbhLMBHO convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Sun, 12 Dec 2021 20:07:14 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:62762 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229587AbhLMBHO (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sun, 12 Dec 2021 20:07:14 -0500
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1BCHSFFK010744
        for <bpf@vger.kernel.org>; Sun, 12 Dec 2021 17:07:13 -0800
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3cwcd5bdbn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Sun, 12 Dec 2021 17:07:13 -0800
Received: from intmgw002.46.prn1.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Sun, 12 Dec 2021 17:07:12 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 7C5D6CDEEF7B; Sun, 12 Dec 2021 17:07:07 -0800 (PST)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>
Subject: [PATCH bpf-next] libbpf: don't validate TYPE_ID relo's original imm value
Date:   Sun, 12 Dec 2021 17:07:06 -0800
Message-ID: <20211213010706.100231-1-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-GUID: kQHgjiedJPYffGI7PzLFiFsDGH3hJETU
X-Proofpoint-ORIG-GUID: kQHgjiedJPYffGI7PzLFiFsDGH3hJETU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-12_10,2021-12-10_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 impostorscore=0
 lowpriorityscore=0 phishscore=0 mlxlogscore=999 adultscore=0 spamscore=0
 priorityscore=1501 bulkscore=0 suspectscore=0 clxscore=1015 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112130005
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

During linking, type IDs in the resulting linked BPF object file can
change, and so ldimm64 instructions corresponding to
BPF_CORE_TYPE_ID_TARGET and BPF_CORE_TYPE_ID_LOCAL CO-RE relos can get
their imm value out of sync with actual CO-RE relocation information
that's updated by BPF linker properly during linking process.

We could teach BPF linker to adjust such instructions, but it feels
a bit too much for linker to re-implement good chunk of
bpf_core_patch_insns logic just for this. This is a redundant safety
check for TYPE_ID relocations, as the real validation is in matching
CO-RE specs, so if that works fine, it's very unlikely that there is
something wrong with the instruction itself.

So, instead, teach libbpf (and kernel) to ignore insn->imm for
BPF_CORE_TYPE_ID_TARGET and BPF_CORE_TYPE_ID_LOCAL relos.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/relo_core.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/tools/lib/bpf/relo_core.c b/tools/lib/bpf/relo_core.c
index 32464f0ab4b1..c770483b4c36 100644
--- a/tools/lib/bpf/relo_core.c
+++ b/tools/lib/bpf/relo_core.c
@@ -709,10 +709,14 @@ static int bpf_core_calc_field_relo(const char *prog_name,
 
 static int bpf_core_calc_type_relo(const struct bpf_core_relo *relo,
 				   const struct bpf_core_spec *spec,
-				   __u32 *val)
+				   __u32 *val, bool *validate)
 {
 	__s64 sz;
 
+	/* by default, always check expected value in bpf_insn */
+	if (validate)
+		*validate = true;
+
 	/* type-based relos return zero when target type is not found */
 	if (!spec) {
 		*val = 0;
@@ -722,6 +726,11 @@ static int bpf_core_calc_type_relo(const struct bpf_core_relo *relo,
 	switch (relo->kind) {
 	case BPF_CORE_TYPE_ID_TARGET:
 		*val = spec->root_type_id;
+		/* type ID, embedded in bpf_insn, might change during linking,
+		 * so enforcing it is pointless
+		 */
+		if (validate)
+			*validate = false;
 		break;
 	case BPF_CORE_TYPE_EXISTS:
 		*val = 1;
@@ -861,8 +870,8 @@ static int bpf_core_calc_relo(const char *prog_name,
 			res->fail_memsz_adjust = true;
 		}
 	} else if (core_relo_is_type_based(relo->kind)) {
-		err = bpf_core_calc_type_relo(relo, local_spec, &res->orig_val);
-		err = err ?: bpf_core_calc_type_relo(relo, targ_spec, &res->new_val);
+		err = bpf_core_calc_type_relo(relo, local_spec, &res->orig_val, &res->validate);
+		err = err ?: bpf_core_calc_type_relo(relo, targ_spec, &res->new_val, NULL);
 	} else if (core_relo_is_enumval_based(relo->kind)) {
 		err = bpf_core_calc_enumval_relo(relo, local_spec, &res->orig_val);
 		err = err ?: bpf_core_calc_enumval_relo(relo, targ_spec, &res->new_val);
@@ -1213,7 +1222,8 @@ int bpf_core_apply_relo_insn(const char *prog_name, struct bpf_insn *insn,
 
 	/* TYPE_ID_LOCAL relo is special and doesn't need candidate search */
 	if (relo->kind == BPF_CORE_TYPE_ID_LOCAL) {
-		targ_res.validate = true;
+		/* bpf_insn's imm value could get out of sync during linking */
+		targ_res.validate = false;
 		targ_res.poison = false;
 		targ_res.orig_val = local_spec->root_type_id;
 		targ_res.new_val = local_spec->root_type_id;
@@ -1227,7 +1237,6 @@ int bpf_core_apply_relo_insn(const char *prog_name, struct bpf_insn *insn,
 		return -EOPNOTSUPP;
 	}
 
-
 	for (i = 0, j = 0; i < cands->len; i++) {
 		err = bpf_core_spec_match(local_spec, cands->cands[i].btf,
 					  cands->cands[i].id, cand_spec);
-- 
2.30.2

