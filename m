Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFE7527DF82
	for <lists+bpf@lfdr.de>; Wed, 30 Sep 2020 06:28:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725817AbgI3E20 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 30 Sep 2020 00:28:26 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:42110 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725792AbgI3E20 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 30 Sep 2020 00:28:26 -0400
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.42/8.16.0.42) with SMTP id 08U4PsoE027881
        for <bpf@vger.kernel.org>; Tue, 29 Sep 2020 21:28:25 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=/wphFbtfizr247YhuIGvyoKb3Cenmq9hKVJ+Uk9uLzI=;
 b=Je/jzJOoaVqlLSw5fgNmtnWT1MRcyd0ZyoV4bb+jm/q/qz0CTRd9KDMnpkWPx/lhc1Sk
 6iNRd1ft+8jUIpj5lg023ZEqhoSmTQDQpyKfU220Yseck4a1Ts5NIA9+GLc6zkAkehtU
 1kz8OwHDwxJtyZ7a1kEw0aGUtjyhVrUWNd0= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0089730.ppops.net with ESMTP id 33t14yhbwp-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 29 Sep 2020 21:28:24 -0700
Received: from intmgw003.03.ash8.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c085:21d::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 29 Sep 2020 21:28:23 -0700
Received: by devbig012.ftw2.facebook.com (Postfix, from userid 137359)
        id ED1012EC77F1; Tue, 29 Sep 2020 21:28:15 -0700 (PDT)
From:   Andrii Nakryiko <andriin@fb.com>
To:     <dwarves@vger.kernel.org>
CC:     <bpf@vger.kernel.org>, Andrii Nakryiko <andriin@fb.com>
Subject: [PATCH dwarves 11/11] btf_encoder: support cross-compiled ELF binaries with different endianness
Date:   Tue, 29 Sep 2020 21:27:42 -0700
Message-ID: <20200930042742.2525310-12-andriin@fb.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200930042742.2525310-1-andriin@fb.com>
References: <20200930042742.2525310-1-andriin@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-30_01:2020-09-29,2020-09-30 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 malwarescore=0
 lowpriorityscore=0 mlxlogscore=999 priorityscore=1501 phishscore=0
 spamscore=0 adultscore=0 bulkscore=0 mlxscore=0 clxscore=1015
 impostorscore=0 suspectscore=13 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2006250000 definitions=main-2009300032
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Ensure that output BTF endianness corresponds to target ELF's endianness.=
 This
makes it finally possible to use pahole to generate BTF for cross-compile=
d
kernels with different endianness.

Signed-off-by: Andrii Nakryiko <andriin@fb.com>
---
 libbtf.c | 24 ++++++++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

diff --git a/libbtf.c b/libbtf.c
index 4829651b76c4..6b0fb4e4c137 100644
--- a/libbtf.c
+++ b/libbtf.c
@@ -87,6 +87,8 @@ struct btf_elf *btf_elf__new(const char *filename, Elf =
*elf)
 		btfe->raw_btf  =3D true;
 		btfe->wordsize =3D sizeof(long);
 		btfe->is_big_endian =3D BYTE_ORDER =3D=3D BIG_ENDIAN;
+		btf__set_endianness(btfe->btf,
+				    btfe->is_big_endian ? BTF_BIG_ENDIAN : BTF_LITTLE_ENDIAN);
 		return btfe;
 	}
=20
@@ -117,8 +119,14 @@ struct btf_elf *btf_elf__new(const char *filename, E=
lf *elf)
 	}
=20
 	switch (btfe->ehdr.e_ident[EI_DATA]) {
-	case ELFDATA2LSB: btfe->is_big_endian =3D false; break;
-	case ELFDATA2MSB: btfe->is_big_endian =3D true;  break;
+	case ELFDATA2LSB:
+		btfe->is_big_endian =3D false;
+		btf__set_endianness(btfe->btf, BTF_LITTLE_ENDIAN);
+		break;
+	case ELFDATA2MSB:
+		btfe->is_big_endian =3D true;
+		btf__set_endianness(btfe->btf, BTF_BIG_ENDIAN);
+		break;
 	default:
 		fprintf(stderr, "%s: unknown elf endianness.\n", __func__);
 		goto errout;
@@ -701,6 +709,18 @@ static int btf_elf__write(const char *filename, stru=
ct btf *btf)
 		goto out;
 	}
=20
+	switch (ehdr_mem.e_ident[EI_DATA]) {
+	case ELFDATA2LSB:
+		btf__set_endianness(btf, BTF_LITTLE_ENDIAN);
+		break;
+	case ELFDATA2MSB:
+		btf__set_endianness(btf, BTF_BIG_ENDIAN);
+		break;
+	default:
+		fprintf(stderr, "%s: unknown elf endianness.\n", __func__);
+		goto out;
+	}
+
 	/*
 	 * First we look if there was already a .BTF section to overwrite.
 	 */
--=20
2.24.1

