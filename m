Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1165D443A49
	for <lists+bpf@lfdr.de>; Wed,  3 Nov 2021 01:10:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232403AbhKCAM7 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Tue, 2 Nov 2021 20:12:59 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:11318 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232377AbhKCAMz (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 2 Nov 2021 20:12:55 -0400
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1A2LZtXD003797
        for <bpf@vger.kernel.org>; Tue, 2 Nov 2021 17:10:19 -0700
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3c3dcs0y5v-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 02 Nov 2021 17:10:19 -0700
Received: from intmgw001.38.frc1.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Tue, 2 Nov 2021 17:10:18 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 4E9C77C14DF5; Tue,  2 Nov 2021 17:10:15 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>
Subject: [PATCH bpf-next 5/5] libbpf: improve ELF relo sanitization
Date:   Tue, 2 Nov 2021 17:10:03 -0700
Message-ID: <20211103001003.398812-6-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211103001003.398812-1-andrii@kernel.org>
References: <20211103001003.398812-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-GUID: iMDUrnPxUlG7URvR40XVdEEq4Fuv8S4C
X-Proofpoint-ORIG-GUID: iMDUrnPxUlG7URvR40XVdEEq4Fuv8S4C
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-02_08,2021-11-02_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 bulkscore=0
 malwarescore=0 lowpriorityscore=0 impostorscore=0 suspectscore=0
 adultscore=0 mlxscore=0 phishscore=0 priorityscore=1501 clxscore=1015
 spamscore=0 mlxlogscore=872 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2110150000 definitions=main-2111020125
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add few sanity checks for relocations to prevent div-by-zero and
out-of-bounds array accesses in libbpf.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/libbpf.c | 24 +++++++++++++++++++-----
 1 file changed, 19 insertions(+), 5 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index ecea4dfaca82..de8569ff4d47 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -3307,6 +3307,10 @@ static int bpf_object__elf_collect(struct bpf_object *obj)
 		} else if (sh->sh_type == SHT_REL) {
 			int targ_sec_idx = sh->sh_info; /* points to other section */
 
+			if (sh->sh_entsize != sizeof(Elf64_Rel) ||
+			    targ_sec_idx >= obj->efile.sec_cnt)
+				return -LIBBPF_ERRNO__FORMAT;
+
 			/* Only do relo for section with exec instructions */
 			if (!section_have_execinstr(obj, targ_sec_idx) &&
 			    strcmp(name, ".rel" STRUCT_OPS_SEC) &&
@@ -4026,7 +4030,7 @@ static int
 bpf_object__collect_prog_relos(struct bpf_object *obj, Elf64_Shdr *shdr, Elf_Data *data)
 {
 	const char *relo_sec_name, *sec_name;
-	size_t sec_idx = shdr->sh_info;
+	size_t sec_idx = shdr->sh_info, sym_idx;
 	struct bpf_program *prog;
 	struct reloc_desc *relos;
 	int err, i, nrels;
@@ -4037,6 +4041,9 @@ bpf_object__collect_prog_relos(struct bpf_object *obj, Elf64_Shdr *shdr, Elf_Dat
 	Elf64_Sym *sym;
 	Elf64_Rel *rel;
 
+	if (sec_idx >= obj->efile.sec_cnt)
+		return -EINVAL;
+
 	scn = elf_sec_by_idx(obj, sec_idx);
 	scn_data = elf_sec_data(obj, scn);
 
@@ -4056,16 +4063,23 @@ bpf_object__collect_prog_relos(struct bpf_object *obj, Elf64_Shdr *shdr, Elf_Dat
 			return -LIBBPF_ERRNO__FORMAT;
 		}
 
-		sym = elf_sym_by_idx(obj, ELF64_R_SYM(rel->r_info));
+		sym_idx = ELF64_R_SYM(rel->r_info);
+		sym = elf_sym_by_idx(obj, sym_idx);
 		if (!sym) {
-			pr_warn("sec '%s': symbol 0x%zx not found for relo #%d\n",
-				relo_sec_name, (size_t)ELF64_R_SYM(rel->r_info), i);
+			pr_warn("sec '%s': symbol #%zu not found for relo #%d\n",
+				relo_sec_name, sym_idx, i);
+			return -LIBBPF_ERRNO__FORMAT;
+		}
+
+		if (sym->st_shndx >= obj->efile.sec_cnt) {
+			pr_warn("sec '%s': corrupted symbol #%zu pointing to invalid section #%zu for relo #%d\n",
+				relo_sec_name, sym_idx, (size_t)sym->st_shndx, i);
 			return -LIBBPF_ERRNO__FORMAT;
 		}
 
 		if (rel->r_offset % BPF_INSN_SZ || rel->r_offset >= scn_data->d_size) {
 			pr_warn("sec '%s': invalid offset 0x%zx for relo #%d\n",
-				relo_sec_name, (size_t)ELF64_R_SYM(rel->r_info), i);
+				relo_sec_name, (size_t)rel->r_offset, i);
 			return -LIBBPF_ERRNO__FORMAT;
 		}
 
-- 
2.30.2

