Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2CBC443A47
	for <lists+bpf@lfdr.de>; Wed,  3 Nov 2021 01:10:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232384AbhKCAM4 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Tue, 2 Nov 2021 20:12:56 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:48568 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232124AbhKCAMx (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 2 Nov 2021 20:12:53 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1A2LbpdM032509
        for <bpf@vger.kernel.org>; Tue, 2 Nov 2021 17:10:18 -0700
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3c3ddp8yme-11
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 02 Nov 2021 17:10:17 -0700
Received: from intmgw001.38.frc1.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Tue, 2 Nov 2021 17:10:11 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 1D6597C14DB6; Tue,  2 Nov 2021 17:10:11 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>
Subject: [PATCH bpf-next 3/5] libbpf: validate that .BTF and .BTF.ext sections contain data
Date:   Tue, 2 Nov 2021 17:10:01 -0700
Message-ID: <20211103001003.398812-4-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211103001003.398812-1-andrii@kernel.org>
References: <20211103001003.398812-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-ORIG-GUID: s_alJ4OriW5Z-JJqLu5r4SpQCLN4Lsxl
X-Proofpoint-GUID: s_alJ4OriW5Z-JJqLu5r4SpQCLN4Lsxl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-02_08,2021-11-02_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 clxscore=1015
 adultscore=0 mlxscore=0 priorityscore=1501 bulkscore=0 malwarescore=0
 impostorscore=0 phishscore=0 lowpriorityscore=0 spamscore=0
 mlxlogscore=999 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2110150000 definitions=main-2111020125
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

.BTF and .BTF.ext ELF sections should have SHT_PROGBITS type and contain
data. If they are not, ELF is invalid or corrupted, so bail out.
Otherwise this can lead to data->d_buf being NULL and SIGSEGV later on.
Reported by oss-fuzz project.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/libbpf.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 4537ce6d54ce..757604b9f869 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -3271,8 +3271,12 @@ static int bpf_object__elf_collect(struct bpf_object *obj)
 		} else if (strcmp(name, MAPS_ELF_SEC) == 0) {
 			obj->efile.btf_maps_shndx = idx;
 		} else if (strcmp(name, BTF_ELF_SEC) == 0) {
+			if (sh->sh_type != SHT_PROGBITS)
+				return -LIBBPF_ERRNO__FORMAT;
 			btf_data = data;
 		} else if (strcmp(name, BTF_EXT_ELF_SEC) == 0) {
+			if (sh->sh_type != SHT_PROGBITS)
+				return -LIBBPF_ERRNO__FORMAT;
 			btf_ext_data = data;
 		} else if (sh->sh_type == SHT_SYMTAB) {
 			/* already processed during the first pass above */
-- 
2.30.2

