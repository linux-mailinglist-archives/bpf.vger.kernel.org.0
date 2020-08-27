Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C360253C73
	for <lists+bpf@lfdr.de>; Thu, 27 Aug 2020 06:11:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725988AbgH0EL0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 27 Aug 2020 00:11:26 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:33750 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725909AbgH0ELZ (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 27 Aug 2020 00:11:25 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07R4BO6f023554
        for <bpf@vger.kernel.org>; Wed, 26 Aug 2020 21:11:24 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=ntTmQNRD+8fYl9UC4BVxTL8CF17LxuFlKlseIdHVLrQ=;
 b=BuI32tboKQV6Rnf4OCrcyB2DK2era9zpgb5MsrkM2aNo66R8ux3WafY5M+yK2CaWbkdG
 8+d4x65QA2e9DE5XWWreB1V+pwxa3n0Qq1JmJsrTCImhpDlQL93VKUOJ73uiUTrn3pph
 NN1DKipfKrl5SjL2H3HsGM2Jx2Qdenoggug= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 335up8kaq4-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 26 Aug 2020 21:11:24 -0700
Received: from intmgw005.03.ash8.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 26 Aug 2020 21:11:20 -0700
Received: by devbig012.ftw2.facebook.com (Postfix, from userid 137359)
        id 6ABE32EC6348; Wed, 26 Aug 2020 21:11:10 -0700 (PDT)
Smtp-Origin-Hostprefix: devbig
From:   Andrii Nakryiko <andriin@fb.com>
Smtp-Origin-Hostname: devbig012.ftw2.facebook.com
To:     <bpf@vger.kernel.org>, <netdev@vger.kernel.org>, <ast@fb.com>,
        <daniel@iogearbox.net>
CC:     <andrii.nakryiko@gmail.com>, <kernel-team@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        Naresh Kamboju <naresh.kamboju@linaro.org>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH v2 bpf-next] libbpf: fix compilation warnings for 64-bit printf args
Date:   Wed, 26 Aug 2020 21:11:09 -0700
Message-ID: <20200827041109.3613090-1-andriin@fb.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-26_14:2020-08-26,2020-08-26 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 malwarescore=0
 lowpriorityscore=0 mlxlogscore=999 clxscore=1015 bulkscore=0 adultscore=0
 impostorscore=0 priorityscore=1501 phishscore=0 spamscore=0 mlxscore=0
 suspectscore=8 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008270034
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Fix compilation warnings due to __u64 defined differently as `unsigned lo=
ng`
or `unsigned long long` on different architectures (e.g., ppc64le differs=
 from
x86-64). Also cast one argument to size_t to fix printf warning of simila=
r
nature.

Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
Fixes: eacaaed784e2 ("libbpf: Implement enum value-based CO-RE relocation=
s")
Fixes: 50e09460d9f8 ("libbpf: Skip well-known ELF sections when iterating=
 ELF")
Signed-off-by: Andrii Nakryiko <andriin@fb.com>
---
 tools/lib/bpf/libbpf.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 2e2523d8bb6d..c97a06226f90 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -2823,7 +2823,8 @@ static int bpf_object__elf_collect(struct bpf_objec=
t *obj)
 			obj->efile.bss =3D data;
 			obj->efile.bss_shndx =3D idx;
 		} else {
-			pr_info("elf: skipping section(%d) %s (size %zu)\n", idx, name, sh.sh=
_size);
+			pr_info("elf: skipping section(%d) %s (size %zu)\n", idx, name,
+				(size_t)sh.sh_size);
 		}
 	}
=20
@@ -5244,7 +5245,8 @@ static int bpf_core_patch_insn(struct bpf_program *=
prog,
 		if (res->validate && imm !=3D orig_val) {
 			pr_warn("prog '%s': relo #%d: unexpected insn #%d (LDIMM64) value: go=
t %llu, exp %u -> %u\n",
 				bpf_program__title(prog, false), relo_idx,
-				insn_idx, imm, orig_val, new_val);
+				insn_idx, (unsigned long long)imm,
+				orig_val, new_val);
 			return -EINVAL;
 		}
=20
@@ -5252,7 +5254,7 @@ static int bpf_core_patch_insn(struct bpf_program *=
prog,
 		insn[1].imm =3D 0; /* currently only 32-bit values are supported */
 		pr_debug("prog '%s': relo #%d: patched insn #%d (LDIMM64) imm64 %llu -=
> %u\n",
 			 bpf_program__title(prog, false), relo_idx, insn_idx,
-			 imm, new_val);
+			 (unsigned long long)imm, new_val);
 		break;
 	}
 	default:
--=20
2.24.1

