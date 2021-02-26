Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34DE53268E6
	for <lists+bpf@lfdr.de>; Fri, 26 Feb 2021 21:54:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230124AbhBZUuR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 26 Feb 2021 15:50:17 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:17648 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230128AbhBZUuQ (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 26 Feb 2021 15:50:16 -0500
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 11QKjrSE031653
        for <bpf@vger.kernel.org>; Fri, 26 Feb 2021 12:49:36 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=e8i5e5S33deykB6qLRz7HxAIb2nx7xt+KS2Qu2j1oHg=;
 b=UHW1yidkLtsmWrIbYTrHPhlUohSdiEqPNp/xb4uQ5X4pIqg4qsq5LNBpj9bveVsSLYGY
 QGI9V2SyxmAjryiq/d1csZox7CggTfVI778S251/1V0qq1JEOSSqxWHSAA4ytaOKmG8u
 VNchgogKtBL5QzRmsKanTWYRj5af2R5KqQU= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 36xd17s14m-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 26 Feb 2021 12:49:36 -0800
Received: from intmgw001.05.ash9.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Fri, 26 Feb 2021 12:49:33 -0800
Received: by devbig003.ftw2.facebook.com (Postfix, from userid 128203)
        id 880CF3705324; Fri, 26 Feb 2021 12:49:29 -0800 (PST)
From:   Yonghong Song <yhs@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH bpf-next v5 08/12] libbpf: move function is_ldimm64() earlier in libbpf.c
Date:   Fri, 26 Feb 2021 12:49:29 -0800
Message-ID: <20210226204929.3885295-1-yhs@fb.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20210226204920.3884074-1-yhs@fb.com>
References: <20210226204920.3884074-1-yhs@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-02-26_09:2021-02-26,2021-02-26 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 malwarescore=0
 clxscore=1015 priorityscore=1501 adultscore=0 mlxscore=0 phishscore=0
 bulkscore=0 mlxlogscore=999 impostorscore=0 suspectscore=0 spamscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102260155
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Move function is_ldimm64() close to the beginning of libbpf.c,
so it can be reused by later code and the next patch as well.
There is no functionality change.

Acked-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Yonghong Song <yhs@fb.com>
---
 tools/lib/bpf/libbpf.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index d43cc3f29dae..21a3eedf070d 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -574,6 +574,11 @@ static bool insn_is_subprog_call(const struct bpf_in=
sn *insn)
 	       insn->off =3D=3D 0;
 }
=20
+static bool is_ldimm64(struct bpf_insn *insn)
+{
+	return insn->code =3D=3D (BPF_LD | BPF_IMM | BPF_DW);
+}
+
 static int
 bpf_object__init_prog(struct bpf_object *obj, struct bpf_program *prog,
 		      const char *name, size_t sec_idx, const char *sec_name,
@@ -3395,7 +3400,7 @@ static int bpf_program__record_reloc(struct bpf_pro=
gram *prog,
 		return 0;
 	}
=20
-	if (insn->code !=3D (BPF_LD | BPF_IMM | BPF_DW)) {
+	if (!is_ldimm64(insn)) {
 		pr_warn("prog '%s': invalid relo against '%s' for insns[%d].code 0x%x\=
n",
 			prog->name, sym_name, insn_idx, insn->code);
 		return -LIBBPF_ERRNO__RELOC;
@@ -5566,11 +5571,6 @@ static void bpf_core_poison_insn(struct bpf_progra=
m *prog, int relo_idx,
 	insn->imm =3D 195896080; /* =3D> 0xbad2310 =3D> "bad relo" */
 }
=20
-static bool is_ldimm64(struct bpf_insn *insn)
-{
-	return insn->code =3D=3D (BPF_LD | BPF_IMM | BPF_DW);
-}
-
 static int insn_bpf_size_to_bytes(struct bpf_insn *insn)
 {
 	switch (BPF_SIZE(insn->code)) {
--=20
2.24.1

