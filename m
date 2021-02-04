Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36718310103
	for <lists+bpf@lfdr.de>; Fri,  5 Feb 2021 00:49:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231213AbhBDXtV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 4 Feb 2021 18:49:21 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:16700 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231254AbhBDXtV (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 4 Feb 2021 18:49:21 -0500
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 114NkcrM017987
        for <bpf@vger.kernel.org>; Thu, 4 Feb 2021 15:48:40 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=QCXkLSG8z5I0Tomm56d8WLLIY1UmhzvgbAfaeyBYBxo=;
 b=c3j081RlbgOQZiII8vEEOYpgunmSvcCtByqN1IcfQZCZapve/cs5DxnzA5PXaAtAUnw1
 0s6f34Rkd5k1qKX8q7eU6+YeSgMvSocV3OT2gCJ6r+dGy6Nuu+LwLwzoRXMregL+TWvB
 PmcomagkIsCwOA+NfGNtNFyjtCjtr1RmKbs= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 36fcrbe2ny-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 04 Feb 2021 15:48:40 -0800
Received: from intmgw001.38.frc1.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:11d::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 4 Feb 2021 15:48:39 -0800
Received: by devbig003.ftw2.facebook.com (Postfix, from userid 128203)
        id 20C233704E75; Thu,  4 Feb 2021 15:48:32 -0800 (PST)
From:   Yonghong Song <yhs@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>
Subject: [PATCH bpf-next 5/8] libbpf: support local function pointer relocation
Date:   Thu, 4 Feb 2021 15:48:32 -0800
Message-ID: <20210204234832.1629393-1-yhs@fb.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20210204234827.1628857-1-yhs@fb.com>
References: <20210204234827.1628857-1-yhs@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.737
 definitions=2021-02-04_13:2021-02-04,2021-02-04 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 impostorscore=0 malwarescore=0 phishscore=0 mlxlogscore=994 clxscore=1015
 bulkscore=0 suspectscore=0 priorityscore=1501 spamscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102040144
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

A new relocation RELO_LOCAL_FUNC is added to capture
local (static) function pointers loaded with ld_imm64
insns. Such ld_imm64 insns are marked with
BPF_PSEUDO_FUNC and will be passed to kernel so
kernel can replace them with proper actual jited
func addresses.

Signed-off-by: Yonghong Song <yhs@fb.com>
---
 tools/lib/bpf/libbpf.c | 33 ++++++++++++++++++++++++++++++---
 1 file changed, 30 insertions(+), 3 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 2abbc3800568..a5146c9e3e06 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -188,6 +188,7 @@ enum reloc_type {
 	RELO_CALL,
 	RELO_DATA,
 	RELO_EXTERN,
+	RELO_LOCAL_FUNC,
 };
=20
 struct reloc_desc {
@@ -574,6 +575,12 @@ static bool insn_is_subprog_call(const struct bpf_in=
sn *insn)
 	       insn->off =3D=3D 0;
 }
=20
+static bool insn_is_pseudo_func(const struct bpf_insn *insn)
+{
+	return insn->code =3D=3D (BPF_LD | BPF_IMM | BPF_DW) &&
+	       insn->src_reg =3D=3D BPF_PSEUDO_FUNC;
+}
+
 static int
 bpf_object__init_prog(struct bpf_object *obj, struct bpf_program *prog,
 		      const char *name, size_t sec_idx, const char *sec_name,
@@ -3395,6 +3402,16 @@ static int bpf_program__record_reloc(struct bpf_pr=
ogram *prog,
 		return 0;
 	}
=20
+	if (insn->code =3D=3D (BPF_LD | BPF_IMM | BPF_DW) &&
+	    GELF_ST_BIND(sym->st_info) =3D=3D STB_LOCAL &&
+	    GELF_ST_TYPE(sym->st_info) =3D=3D STT_SECTION &&
+	    shdr_idx =3D=3D obj->efile.text_shndx) {
+		reloc_desc->type =3D RELO_LOCAL_FUNC;
+		reloc_desc->insn_idx =3D insn_idx;
+		reloc_desc->sym_off =3D sym->st_value;
+		return 0;
+	}
+
 	if (insn->code !=3D (BPF_LD | BPF_IMM | BPF_DW)) {
 		pr_warn("prog '%s': invalid relo against '%s' for insns[%d].code 0x%x\=
n",
 			prog->name, sym_name, insn_idx, insn->code);
@@ -6172,6 +6189,9 @@ bpf_object__relocate_data(struct bpf_object *obj, s=
truct bpf_program *prog)
 			}
 			relo->processed =3D true;
 			break;
+		case RELO_LOCAL_FUNC:
+			insn[0].src_reg =3D BPF_PSEUDO_FUNC;
+			/* fallthrough */
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
+		if (relo && relo->type !=3D RELO_CALL && relo->type !=3D RELO_LOCAL_FU=
NC) {
 			pr_warn("prog '%s': unexpected relo for insn #%zu, type %d\n",
 				prog->name, insn_idx, relo->type);
 			return -LIBBPF_ERRNO__RELOC;
@@ -6374,8 +6394,15 @@ bpf_object__reloc_code(struct bpf_object *obj, str=
uct bpf_program *main_prog,
 			 * call always has imm =3D -1, but for static functions
 			 * relocation is against STT_SECTION and insn->imm
 			 * points to a start of a static function
+			 *
+			 * for local func relocation, the imm field encodes
+			 * the byte offset in the corresponding section.
 			 */
-			sub_insn_idx =3D relo->sym_off / BPF_INSN_SZ + insn->imm + 1;
+			if (relo->type =3D=3D RELO_CALL)
+				sub_insn_idx =3D relo->sym_off / BPF_INSN_SZ + insn->imm + 1;
+			else
+				sub_insn_idx =3D relo->sym_off / BPF_INSN_SZ +
+					       insn->imm / BPF_INSN_SZ + 1;
 		} else {
 			/* if subprogram call is to a static function within
 			 * the same ELF section, there won't be any relocation
--=20
2.24.1

