Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5289324B49
	for <lists+bpf@lfdr.de>; Thu, 25 Feb 2021 08:34:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233961AbhBYHeM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 25 Feb 2021 02:34:12 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:37638 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233498AbhBYHeC (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 25 Feb 2021 02:34:02 -0500
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 11P7UaQN000540
        for <bpf@vger.kernel.org>; Wed, 24 Feb 2021 23:33:21 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=SrLuE/ipeJX6GLUXErV97FyjA1GjUkdedRlMZDUklR0=;
 b=Im3NK2jLLxC+zSoymkiCD9ss+eOdg1lLXWkDmcqvAHyqiKn73JZB5r7fhuL3ArXDjP0N
 46lKugCfJ999n3Nk168+zE6MwepJyfKQIG6mWVrJ+u/s0wC4LTSUO1mKm6jNdkrRtywV
 dGa0lyfOnDjOb59HaGxbI5Uz2ExruNBBGN0= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 36wvqdbeu9-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 24 Feb 2021 23:33:21 -0800
Received: from intmgw001.06.ash9.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:11d::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 24 Feb 2021 23:33:19 -0800
Received: by devbig003.ftw2.facebook.com (Postfix, from userid 128203)
        id 491313705D0E; Wed, 24 Feb 2021 23:33:18 -0800 (PST)
From:   Yonghong Song <yhs@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>
Subject: [PATCH bpf-next v3 08/11] libbpf: support subprog address relocation
Date:   Wed, 24 Feb 2021 23:33:18 -0800
Message-ID: <20210225073318.4121448-1-yhs@fb.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20210225073309.4119708-1-yhs@fb.com>
References: <20210225073309.4119708-1-yhs@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-02-25_04:2021-02-24,2021-02-25 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 malwarescore=0
 priorityscore=1501 suspectscore=0 clxscore=1015 mlxscore=0 mlxlogscore=999
 impostorscore=0 bulkscore=0 adultscore=0 lowpriorityscore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102250062
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

A new relocation RELO_SUBPROG_ADDR is added to capture
subprog addresses loaded with ld_imm64 insns. Such ld_imm64
insns are marked with BPF_PSEUDO_FUNC and will be passed to
kernel. For bpf_for_each_map_elem() case, kernel will
check that the to-be-used subprog address must be a static
function and replace it with proper actual jited func address.

Signed-off-by: Yonghong Song <yhs@fb.com>
---
 tools/lib/bpf/libbpf.c | 64 ++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 61 insertions(+), 3 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 21a3eedf070d..62d9ed56b081 100644
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
@@ -2979,6 +2985,23 @@ static bool sym_is_extern(const GElf_Sym *sym)
 	       GELF_ST_TYPE(sym->st_info) =3D=3D STT_NOTYPE;
 }
=20
+static bool sym_is_subprog(const GElf_Sym *sym, int text_shndx)
+{
+	int bind =3D GELF_ST_BIND(sym->st_info);
+	int type =3D GELF_ST_TYPE(sym->st_info);
+
+	/* in .text section */
+	if (sym->st_shndx !=3D text_shndx)
+		return false;
+
+	/* local function */
+	if (bind =3D=3D STB_LOCAL && type =3D=3D STT_SECTION)
+		return true;
+
+	/* global function */
+	return bind =3D=3D STB_GLOBAL && type =3D=3D STT_FUNC;
+}
+
 static int find_extern_btf_id(const struct btf *btf, const char *ext_nam=
e)
 {
 	const struct btf_type *t;
@@ -3435,6 +3458,23 @@ static int bpf_program__record_reloc(struct bpf_pr=
ogram *prog,
 		return -LIBBPF_ERRNO__RELOC;
 	}
=20
+	/* loading subprog addresses */
+	if (sym_is_subprog(sym, obj->efile.text_shndx)) {
+		/* global_func: sym->st_value =3D offset in the section, insn->imm =3D=
 0.
+		 * local_func: sym->st_value =3D 0, insn->imm =3D offset in the sectio=
n.
+		 */
+		if ((sym->st_value % BPF_INSN_SZ) || (insn->imm % BPF_INSN_SZ)) {
+			pr_warn("prog '%s': bad subprog addr relo against '%s' at offset %zu+=
%d\n",
+				prog->name, sym_name, (size_t)sym->st_value, insn->imm);
+			return -LIBBPF_ERRNO__RELOC;
+		}
+
+		reloc_desc->type =3D RELO_SUBPROG_ADDR;
+		reloc_desc->insn_idx =3D insn_idx;
+		reloc_desc->sym_off =3D sym->st_value;
+		return 0;
+	}
+
 	type =3D bpf_object__section_to_libbpf_map_type(obj, shdr_idx);
 	sym_sec_name =3D elf_sec_name(obj, elf_sec_by_idx(obj, shdr_idx));
=20
@@ -6172,6 +6212,10 @@ bpf_object__relocate_data(struct bpf_object *obj, =
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
@@ -6358,11 +6402,11 @@ bpf_object__reloc_code(struct bpf_object *obj, st=
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
@@ -6374,8 +6418,22 @@ bpf_object__reloc_code(struct bpf_object *obj, str=
uct bpf_program *main_prog,
 			 * call always has imm =3D -1, but for static functions
 			 * relocation is against STT_SECTION and insn->imm
 			 * points to a start of a static function
+			 *
+			 * for subprog addr relocation, the relo->sym_off + insn->imm is
+			 * the byte offset in the corresponding section.
 			 */
-			sub_insn_idx =3D relo->sym_off / BPF_INSN_SZ + insn->imm + 1;
+			if (relo->type =3D=3D RELO_CALL)
+				sub_insn_idx =3D relo->sym_off / BPF_INSN_SZ + insn->imm + 1;
+			else
+				sub_insn_idx =3D (relo->sym_off + insn->imm) / BPF_INSN_SZ;
+		} else if (insn_is_pseudo_func(insn)) {
+			/*
+			 * RELO_SUBPROG_ADDR relo is always emitted even if both
+			 * functions are in the same section, so it shouldn't reach here.
+			 */
+			pr_warn("prog '%s': missing subprog addr relo for insn #%zu\n",
+				prog->name, insn_idx);
+			return -LIBBPF_ERRNO__RELOC;
 		} else {
 			/* if subprogram call is to a static function within
 			 * the same ELF section, there won't be any relocation
--=20
2.24.1

