Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC49C38D678
	for <lists+bpf@lfdr.de>; Sat, 22 May 2021 18:23:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231250AbhEVQZN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 22 May 2021 12:25:13 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:48892 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S231249AbhEVQZN (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sat, 22 May 2021 12:25:13 -0400
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.43/8.16.0.43) with SMTP id 14MGGRN5010607
        for <bpf@vger.kernel.org>; Sat, 22 May 2021 09:23:48 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=facebook; bh=5YaFX72k/CqL5jpzM08hox9RtAXH47ptO/mNAKLdRxA=;
 b=kLQqoWq0WQWvTZeYfX/T3sanpxRNEx2TQf3HFYn65PAYD4zCUDfL6e04i4h9A2ADA1TW
 +f6FqNuzpOBfcK6IQQ24kJbDG0gy+kMp3WWoqXcH+xBLJwqdP+W3TYKMD/X0r5HZCJDE
 vzXFcBqEawimfPKRYXOjwi4khJqC8DA3h7o= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0089730.ppops.net with ESMTP id 38pwfbsck5-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Sat, 22 May 2021 09:23:47 -0700
Received: from intmgw001.37.frc1.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Sat, 22 May 2021 09:23:47 -0700
Received: by devbig003.ftw2.facebook.com (Postfix, from userid 128203)
        id 3AAD42E9275C; Sat, 22 May 2021 09:23:41 -0700 (PDT)
From:   Yonghong Song <yhs@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>
Subject: [PATCH bpf-next] libbpf: add support for new llvm bpf relocations
Date:   Sat, 22 May 2021 09:23:41 -0700
Message-ID: <20210522162341.3687617-1-yhs@fb.com>
X-Mailer: git-send-email 2.30.2
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: 9dxosDJ4cQeWYBTEYOWxfdNZu76wdrY9
X-Proofpoint-ORIG-GUID: 9dxosDJ4cQeWYBTEYOWxfdNZu76wdrY9
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-22_08:2021-05-20,2021-05-22 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0
 mlxlogscore=845 priorityscore=1501 adultscore=0 spamscore=0
 lowpriorityscore=0 phishscore=0 clxscore=1015 malwarescore=0 bulkscore=0
 impostorscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2104190000 definitions=main-2105220118
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

LLVM patch https://reviews.llvm.org/D102712
narrowed the scope of existing R_BPF_64_64
and R_BPF_64_32 relocations, and added three
new relocations, R_BPF_64_ABS64, R_BPF_64_ABS32
and R_BPF_64_NODYLD32. The main motivation is
to make relocations linker friendly.

This change, unfortunately, breaks libbpf build,
and we will see errors like below:
  libbpf: ELF relo #0 in section #6 has unexpected type 2 in
     /home/yhs/work/bpf-next/tools/testing/selftests/bpf/bpf_tcp_nogpl.o
  Error: failed to link
     '/home/yhs/work/bpf-next/tools/testing/selftests/bpf/bpf_tcp_nogpl.o':
     Unknown error -22 (-22)
The new relocation R_BPF_64_ABS64 is generated
and libbpf linker sanity check doesn't understand it.
Relocation section '.rel.struct_ops' at offset 0x1410 contains 1 entries:
    Offset             Info             Type               Symbol's Value  =
Symbol's Name
0000000000000018  0000000700000002 R_BPF_64_ABS64         0000000000000000 =
nogpltcp_init

Look at the selftests/bpf/bpf_tcp_nogpl.c,
  void BPF_STRUCT_OPS(nogpltcp_init, struct sock *sk)
  {
  }

  SEC(".struct_ops")
  struct tcp_congestion_ops bpf_nogpltcp =3D {
          .init           =3D (void *)nogpltcp_init,
          .name           =3D "bpf_nogpltcp",
  };
The new llvm relocation scheme categorizes 'nogpltcp_init' reference
as R_BPF_64_ABS64 instead of R_BPF_64_64 which is used to specify
ld_imm64 relocation in the new scheme.

Let us fix the linker sanity checking by including
R_BPF_64_ABS64 and R_BPF_64_ABS32. There is no need to
check R_BPF_64_NODYLD32 which is used for .BTF and .BTF.ext.

Signed-off-by: Yonghong Song <yhs@fb.com>
---
 tools/lib/bpf/libbpf_internal.h | 6 ++++++
 tools/lib/bpf/linker.c          | 3 ++-
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/tools/lib/bpf/libbpf_internal.h b/tools/lib/bpf/libbpf_interna=
l.h
index 55d9b4dca64f..e2db08573bf0 100644
--- a/tools/lib/bpf/libbpf_internal.h
+++ b/tools/lib/bpf/libbpf_internal.h
@@ -28,6 +28,12 @@
 #ifndef R_BPF_64_64
 #define R_BPF_64_64 1
 #endif
+#ifndef R_BPF_64_ABS64
+#define R_BPF_64_ABS64 2
+#endif
+#ifndef R_BPF_64_ABS32
+#define R_BPF_64_ABS32 3
+#endif
 #ifndef R_BPF_64_32
 #define R_BPF_64_32 10
 #endif
diff --git a/tools/lib/bpf/linker.c b/tools/lib/bpf/linker.c
index b594a88620ce..1dca41a24f75 100644
--- a/tools/lib/bpf/linker.c
+++ b/tools/lib/bpf/linker.c
@@ -892,7 +892,8 @@ static int linker_sanity_check_elf_relos(struct src_obj=
 *obj, struct src_sec *se
 		size_t sym_idx =3D ELF64_R_SYM(relo->r_info);
 		size_t sym_type =3D ELF64_R_TYPE(relo->r_info);
=20
-		if (sym_type !=3D R_BPF_64_64 && sym_type !=3D R_BPF_64_32) {
+		if (sym_type !=3D R_BPF_64_64 && sym_type !=3D R_BPF_64_32 &&
+		    sym_type !=3D R_BPF_64_ABS64 && sym_type !=3D R_BPF_64_ABS32) {
 			pr_warn("ELF relo #%d in section #%zu has unexpected type %zu in %s\n",
 				i, sec->sec_idx, sym_type, obj->filename);
 			return -EINVAL;
--=20
2.30.2

