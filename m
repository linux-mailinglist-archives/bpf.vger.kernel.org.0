Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62D68324B4A
	for <lists+bpf@lfdr.de>; Thu, 25 Feb 2021 08:34:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233498AbhBYHeO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 25 Feb 2021 02:34:14 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:18270 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233773AbhBYHeD (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 25 Feb 2021 02:34:03 -0500
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 11P7UF0e014149
        for <bpf@vger.kernel.org>; Wed, 24 Feb 2021 23:33:22 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=e8i5e5S33deykB6qLRz7HxAIb2nx7xt+KS2Qu2j1oHg=;
 b=OrSuSvsdxcavrAcoRYmgktTWA6m+F+njAj813QZUbN+1UwXldr0DRr53AIbm/uKpf3h3
 uwmBg3diUZuz7zahoR3Lys0zgIMftUyHja1hDQxl3oA2GcE18dbFAhuzxSe8mEEXkRSI
 g7K9V50+vMsuYeq3MIDDvAxGlGEYATl/NLk= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 36wbu3r97u-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 24 Feb 2021 23:33:22 -0800
Received: from intmgw002.06.ash9.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::e) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 24 Feb 2021 23:33:19 -0800
Received: by devbig003.ftw2.facebook.com (Postfix, from userid 128203)
        id 0E0293705D0E; Wed, 24 Feb 2021 23:33:17 -0800 (PST)
From:   Yonghong Song <yhs@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH bpf-next v3 07/11] libbpf: move function is_ldimm64() earlier in libbpf.c
Date:   Wed, 24 Feb 2021 23:33:17 -0800
Message-ID: <20210225073317.4121312-1-yhs@fb.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20210225073309.4119708-1-yhs@fb.com>
References: <20210225073309.4119708-1-yhs@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-02-25_04:2021-02-24,2021-02-25 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxlogscore=999
 lowpriorityscore=0 impostorscore=0 malwarescore=0 mlxscore=0 spamscore=0
 adultscore=0 bulkscore=0 clxscore=1015 suspectscore=0 priorityscore=1501
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102250062
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

