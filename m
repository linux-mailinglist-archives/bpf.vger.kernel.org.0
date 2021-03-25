Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A414F3486A6
	for <lists+bpf@lfdr.de>; Thu, 25 Mar 2021 02:53:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235994AbhCYBwz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 24 Mar 2021 21:52:55 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:20988 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235953AbhCYBw0 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 24 Mar 2021 21:52:26 -0400
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 12P1nl4J002821
        for <bpf@vger.kernel.org>; Wed, 24 Mar 2021 18:52:25 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=42lCaS5XP5gHwKHlNSk3I1lKuNsi8mAReK9eXjmwEjI=;
 b=mu9oJsWajUPSCsMToPEGQXoGk8NeYYXS/W6pJIh9BSHgSK80Zfkwc4gxzxY4N+qO/LWE
 rN7TJ86D9WMlkPsYLGK+R4Wb9eKMo1A/0VNRLPNoFiQLPUj2zy1qfPT9il0MXTg9IQVp
 7rI4zCO9q5YXZEPd1A6GwZBinZyisqOsBx4= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 37fnsxh6as-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 24 Mar 2021 18:52:25 -0700
Received: from intmgw002.25.frc3.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::d) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 24 Mar 2021 18:52:24 -0700
Received: by devbig005.ftw2.facebook.com (Postfix, from userid 6611)
        id 8625D29429D7; Wed, 24 Mar 2021 18:52:21 -0700 (PDT)
From:   Martin KaFai Lau <kafai@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>,
        <netdev@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH v2 bpf-next 09/14] libbpf: Rename RELO_EXTERN to RELO_EXTERN_VAR
Date:   Wed, 24 Mar 2021 18:52:21 -0700
Message-ID: <20210325015221.1547722-1-kafai@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210325015124.1543397-1-kafai@fb.com>
References: <20210325015124.1543397-1-kafai@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-24_14:2021-03-24,2021-03-24 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0 malwarescore=0
 lowpriorityscore=0 clxscore=1015 impostorscore=0 priorityscore=1501
 spamscore=0 mlxlogscore=851 bulkscore=0 phishscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103250011
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This patch renames RELO_EXTERN to RELO_EXTERN_VAR.
It is to avoid the confusion with a later patch adding
RELO_EXTERN_FUNC.

Acked-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Martin KaFai Lau <kafai@fb.com>
---
 tools/lib/bpf/libbpf.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 5a0cae981784..1a2dbde19b7e 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -185,7 +185,7 @@ enum reloc_type {
 	RELO_LD64,
 	RELO_CALL,
 	RELO_DATA,
-	RELO_EXTERN,
+	RELO_EXTERN_VAR,
 	RELO_SUBPROG_ADDR,
 };
=20
@@ -3454,7 +3454,7 @@ static int bpf_program__record_reloc(struct bpf_pro=
gram *prog,
 		}
 		pr_debug("prog '%s': found extern #%d '%s' (sym %d) for insn #%u\n",
 			 prog->name, i, ext->name, ext->sym_idx, insn_idx);
-		reloc_desc->type =3D RELO_EXTERN;
+		reloc_desc->type =3D RELO_EXTERN_VAR;
 		reloc_desc->insn_idx =3D insn_idx;
 		reloc_desc->sym_off =3D i; /* sym_off stores extern index */
 		return 0;
@@ -6217,7 +6217,7 @@ bpf_object__relocate_data(struct bpf_object *obj, s=
truct bpf_program *prog)
 			insn[0].imm =3D obj->maps[relo->map_idx].fd;
 			relo->processed =3D true;
 			break;
-		case RELO_EXTERN:
+		case RELO_EXTERN_VAR:
 			ext =3D &obj->externs[relo->sym_off];
 			if (ext->type =3D=3D EXT_KCFG) {
 				insn[0].src_reg =3D BPF_PSEUDO_MAP_VALUE;
--=20
2.30.2

