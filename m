Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1656287F34
	for <lists+bpf@lfdr.de>; Fri,  9 Oct 2020 01:40:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731022AbgJHXk1 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Thu, 8 Oct 2020 19:40:27 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:37074 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731066AbgJHXk1 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 8 Oct 2020 19:40:27 -0400
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 098NeDhs007710
        for <bpf@vger.kernel.org>; Thu, 8 Oct 2020 16:40:27 -0700
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3429h8gvt4-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 08 Oct 2020 16:40:26 -0700
Received: from intmgw004.08.frc2.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c085:21d::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 8 Oct 2020 16:40:25 -0700
Received: by devbig012.ftw2.facebook.com (Postfix, from userid 137359)
        id F3FE12EC7C76; Thu,  8 Oct 2020 16:40:20 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <dwarves@vger.kernel.org>
CC:     <bpf@vger.kernel.org>, <kernel-team@fb.com>, <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Andrii Nakryiko <andriin@fb.com>
Subject: [PATCH v2 dwarves 8/8] btf_encoder: support cross-compiled ELF binaries with different endianness
Date:   Thu, 8 Oct 2020 16:40:00 -0700
Message-ID: <20201008234000.740660-9-andrii@kernel.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20201008234000.740660-1-andrii@kernel.org>
References: <20201008234000.740660-1-andrii@kernel.org>
MIME-Version: 1.0
X-FB-Internal: Safe
Content-Type: text/plain
Content-Transfer-Encoding: 8BIT
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-10-08_15:2020-10-08,2020-10-08 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 phishscore=0
 clxscore=1034 impostorscore=0 priorityscore=1501 mlxscore=0
 mlxlogscore=999 lowpriorityscore=0 malwarescore=0 suspectscore=13
 bulkscore=0 spamscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2010080167
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Andrii Nakryiko <andriin@fb.com>

Ensure that output BTF endianness corresponds to target ELF's endianness. This
makes it finally possible to use pahole to generate BTF for cross-compiled
kernels with different endianness.

Signed-off-by: Andrii Nakryiko <andriin@fb.com>
---
 libbtf.c | 24 ++++++++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

diff --git a/libbtf.c b/libbtf.c
index 27aa3e5a986e..babf4fe8cd9e 100644
--- a/libbtf.c
+++ b/libbtf.c
@@ -87,6 +87,8 @@ struct btf_elf *btf_elf__new(const char *filename, Elf *elf)
 		btfe->raw_btf  = true;
 		btfe->wordsize = sizeof(long);
 		btfe->is_big_endian = BYTE_ORDER == BIG_ENDIAN;
+		btf__set_endianness(btfe->btf,
+				    btfe->is_big_endian ? BTF_BIG_ENDIAN : BTF_LITTLE_ENDIAN);
 		return btfe;
 	}
 
@@ -118,8 +120,14 @@ struct btf_elf *btf_elf__new(const char *filename, Elf *elf)
 	}
 
 	switch (btfe->ehdr.e_ident[EI_DATA]) {
-	case ELFDATA2LSB: btfe->is_big_endian = false; break;
-	case ELFDATA2MSB: btfe->is_big_endian = true;  break;
+	case ELFDATA2LSB:
+		btfe->is_big_endian = false;
+		btf__set_endianness(btfe->btf, BTF_LITTLE_ENDIAN);
+		break;
+	case ELFDATA2MSB:
+		btfe->is_big_endian = true;
+		btf__set_endianness(btfe->btf, BTF_BIG_ENDIAN);
+		break;
 	default:
 		fprintf(stderr, "%s: unknown elf endianness.\n", __func__);
 		goto errout;
@@ -704,6 +712,18 @@ static int btf_elf__write(const char *filename, struct btf *btf)
 		goto out;
 	}
 
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
-- 
2.24.1

