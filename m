Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3A6731DEFD
	for <lists+bpf@lfdr.de>; Wed, 17 Feb 2021 19:19:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234781AbhBQSS4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 17 Feb 2021 13:18:56 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:45110 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234782AbhBQSSy (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 17 Feb 2021 13:18:54 -0500
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 11HIAZxG030123
        for <bpf@vger.kernel.org>; Wed, 17 Feb 2021 10:18:14 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=31XmVbYT0l4MUTf7wzpZ0w8b+lx8KFvnmkxOUhkqGXo=;
 b=gPFMMe/xbOk0RzO5yg6V8zFBCYSb7bEFEtmD3cVHg0Emmv44vfDdSZjMQagc1cURTtaB
 WnOP0hL9jfInXC5eAtnoBowweD1ul9A6R/TexHY05YAD+YNSzYxdYZUe3Nnf92gFnq6+
 gdSjCrxtCY7FSB2v1DdfhT43UqzI79a+QG8= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 36s10tase3-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 17 Feb 2021 10:18:14 -0800
Received: from intmgw001.38.frc1.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:11d::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 17 Feb 2021 10:18:13 -0800
Received: by devbig003.ftw2.facebook.com (Postfix, from userid 128203)
        id 8A9723704F7A; Wed, 17 Feb 2021 10:18:12 -0800 (PST)
From:   Yonghong Song <yhs@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>
Subject: [PATCH bpf-next v2 08/11] libbpf: support local function pointer relocation
Date:   Wed, 17 Feb 2021 10:18:12 -0800
Message-ID: <20210217181812.3191397-1-yhs@fb.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20210217181803.3189437-1-yhs@fb.com>
References: <20210217181803.3189437-1-yhs@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-02-17_13:2021-02-16,2021-02-17 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0 clxscore=1015
 phishscore=0 suspectscore=0 impostorscore=0 lowpriorityscore=0
 mlxlogscore=860 bulkscore=0 malwarescore=0 spamscore=0 priorityscore=1501
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102170133
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

A new relocation RELO_SUBPROG_ADDR is added to capture
local (static) function pointers loaded with ld_imm64
insns. Such ld_imm64 insns are marked with
BPF_PSEUDO_FUNC and will be passed to kernel so
kernel can replace them with proper actual jited
func addresses.

Signed-off-by: Yonghong Song <yhs@fb.com>
---
 tools/lib/bpf/libbpf.c | 40 +++++++++++++++++++++++++++++++++++++---
 1 file changed, 37 insertions(+), 3 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 21a3eedf070d..772c7455f1a2 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -188,6 +188,7 @@ enum reloc_type {
 	RELO_CALL,
 	RELO_DATA,
 	RELO_EXTERN,
+	RELO_SUBPROG_ADDR,
 };
=20
 struct reloc_desc {
@@ -579,6 +580,11 @@ static bool is_ldimm64(struct bpf_insn *insn)
 	return insn->code =3D=3D (BPF_LD | BPF_IMM | BPF_DW);
 }
=20
+static bool insn_is_pseudo_func(struct bpf_insn *insn)
+{
+	return is_ldimm64(insn) && insn->src_reg =3D=3D BPF_PSEUDO_FUNC;
+}
+
 static int
 bpf_object__init_prog(struct bpf_object *obj, struct bpf_program *prog,
 		      const char *name, size_t sec_idx, const char *sec_name,
@@ -3406,6 +3412,16 @@ static int bpf_program__record_reloc(struct bpf_pr=
ogram *prog,
 		return -LIBBPF_ERRNO__RELOC;
 	}
=20
+	if (GELF_ST_BIND(sym->st_info) =3D=3D STB_LOCAL &&
+	    GELF_ST_TYPE(sym->st_info) =3D=3D STT_SECTION &&
+	    (!shdr_idx || shdr_idx =3D=3D obj->efile.text_shndx) &&
+	    !(sym->st_value % BPF_INSN_SZ)) {
+		reloc_desc->type =3D RELO_SUBPROG_ADDR;
+		reloc_desc->insn_idx =3D insn_idx;
+		reloc_desc->sym_off =3D sym->st_value;
+		return 0;
+	}
+
 	if (sym_is_extern(sym)) {
 		int sym_idx =3D GELF_R_SYM(rel->r_info);
 		int i, n =3D obj->nr_extern;
@@ -6172,6 +6188,10 @@ bpf_object__relocate_data(struct bpf_object *obj, =
struct bpf_program *prog)
 			}
 			relo->processed =3D true;
 			break;
+		case RELO_SUBPROG_ADDR:
+			insn[0].src_reg =3D BPF_PSEUDO_FUNC;
+			/* will be handled as a follow up pass */
+			break;
 		case RELO_CALL:
 			/* will be handled as a follow up pass */
 			break;
@@ -6358,11 +6378,11 @@ bpf_object__reloc_code(struct bpf_object *obj, st=
ruct bpf_program *main_prog,
=20
 	for (insn_idx =3D 0; insn_idx < prog->sec_insn_cnt; insn_idx++) {
 		insn =3D &main_prog->insns[prog->sub_insn_off + insn_idx];
-		if (!insn_is_subprog_call(insn))
+		if (!insn_is_subprog_call(insn) && !insn_is_pseudo_func(insn))
 			continue;
=20
 		relo =3D find_prog_insn_relo(prog, insn_idx);
-		if (relo && relo->type !=3D RELO_CALL) {
+		if (relo && relo->type !=3D RELO_CALL && relo->type !=3D RELO_SUBPROG_=
ADDR) {
 			pr_warn("prog '%s': unexpected relo for insn #%zu, type %d\n",
 				prog->name, insn_idx, relo->type);
 			return -LIBBPF_ERRNO__RELOC;
@@ -6374,8 +6394,22 @@ bpf_object__reloc_code(struct bpf_object *obj, str=
uct bpf_program *main_prog,
 			 * call always has imm =3D -1, but for static functions
 			 * relocation is against STT_SECTION and insn->imm
 			 * points to a start of a static function
+			 *
+			 * for local func relocation, the imm field encodes
+			 * the byte offset in the corresponding section.
+			 */
+			if (relo->type =3D=3D RELO_CALL)
+				sub_insn_idx =3D relo->sym_off / BPF_INSN_SZ + insn->imm + 1;
+			else
+				sub_insn_idx =3D relo->sym_off / BPF_INSN_SZ + insn->imm / BPF_INSN_=
SZ + 1;
+		} else if (insn_is_pseudo_func(insn)) {
+			/*
+			 * RELO_SUBPROG_ADDR relo is always emitted even if both
+			 * functions are in the same section, so it shouldn't reach here.
 			 */
-			sub_insn_idx =3D relo->sym_off / BPF_INSN_SZ + insn->imm + 1;
+			pr_warn("prog '%s': missing relo for insn #%zu, type %d\n",
+				prog->name, insn_idx, relo->type);
+			return -LIBBPF_ERRNO__RELOC;
 		} else {
 			/* if subprogram call is to a static function within
 			 * the same ELF section, there won't be any relocation
--=20
2.24.1

