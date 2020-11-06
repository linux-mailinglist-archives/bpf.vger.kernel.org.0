Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC92F2A8EDE
	for <lists+bpf@lfdr.de>; Fri,  6 Nov 2020 06:26:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726105AbgKFF0C convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Fri, 6 Nov 2020 00:26:02 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:27648 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725979AbgKFF0B (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 6 Nov 2020 00:26:01 -0500
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0A65OfiW016481
        for <bpf@vger.kernel.org>; Thu, 5 Nov 2020 21:26:01 -0800
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 34mr9ba68n-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 05 Nov 2020 21:26:01 -0800
Received: from intmgw002.03.ash8.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 5 Nov 2020 21:25:59 -0800
Received: by devbig012.ftw2.facebook.com (Postfix, from userid 137359)
        id A7E322EC8EF6; Thu,  5 Nov 2020 21:25:55 -0800 (PST)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <dwarves@vger.kernel.org>, <acme@kernel.org>, <bpf@vger.kernel.org>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>
Subject: [PATCH dwarves 2/4] libbtf: improve variable naming and error reporting when writing out BTF
Date:   Thu, 5 Nov 2020 21:25:47 -0800
Message-ID: <20201106052549.3782099-3-andrii@kernel.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20201106052549.3782099-1-andrii@kernel.org>
References: <20201106052549.3782099-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-06_01:2020-11-05,2020-11-06 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 malwarescore=0
 phishscore=0 clxscore=1034 lowpriorityscore=0 mlxlogscore=802
 suspectscore=8 mlxscore=0 priorityscore=1501 impostorscore=0 bulkscore=0
 adultscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011060037
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Rename few local variables to reflects the purpose a bit better. Also separate
writing out BTF raw data and objcopy invocation into two separate steps and
improve error reporting for each.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 libbtf.c | 33 +++++++++++++++++++++------------
 1 file changed, 21 insertions(+), 12 deletions(-)

diff --git a/libbtf.c b/libbtf.c
index babf4fe8cd9e..b6ddd7599395 100644
--- a/libbtf.c
+++ b/libbtf.c
@@ -679,11 +679,11 @@ static int btf_elf__write(const char *filename, struct btf *btf)
 {
 	GElf_Shdr shdr_mem, *shdr;
 	GElf_Ehdr ehdr_mem, *ehdr;
-	Elf_Data *btf_elf = NULL;
+	Elf_Data *btf_data = NULL;
 	Elf_Scn *scn = NULL;
 	Elf *elf = NULL;
-	const void *btf_data;
-	uint32_t btf_size;
+	const void *raw_btf_data;
+	uint32_t raw_btf_size;
 	int fd, err = -1;
 	size_t strndx;
 
@@ -735,18 +735,18 @@ static int btf_elf__write(const char *filename, struct btf *btf)
 			continue;
 		char *secname = elf_strptr(elf, strndx, shdr->sh_name);
 		if (strcmp(secname, ".BTF") == 0) {
-			btf_elf = elf_getdata(scn, btf_elf);
+			btf_data = elf_getdata(scn, btf_data);
 			break;
 		}
 	}
 
-	btf_data = btf__get_raw_data(btf, &btf_size);
+	raw_btf_data = btf__get_raw_data(btf, &raw_btf_size);
 
-	if (btf_elf) {
+	if (btf_data) {
 		/* Exisiting .BTF section found */
-		btf_elf->d_buf = (void *)btf_data;
-		btf_elf->d_size = btf_size;
-		elf_flagdata(btf_elf, ELF_C_SET, ELF_F_DIRTY);
+		btf_data->d_buf = (void *)raw_btf_data;
+		btf_data->d_size = raw_btf_size;
+		elf_flagdata(btf_data, ELF_C_SET, ELF_F_DIRTY);
 
 		if (elf_update(elf, ELF_C_NULL) >= 0 &&
 		    elf_update(elf, ELF_C_WRITE) >= 0)
@@ -770,12 +770,21 @@ static int btf_elf__write(const char *filename, struct btf *btf)
 			goto out;
 		}
 
+		if (write(fd, raw_btf_data, raw_btf_size) != raw_btf_size) {
+			fprintf(stderr, "%s: write of %d bytes to '%s' failed: %d!\n",
+				__func__, raw_btf_size, tmp_fn, errno);
+			goto out;
+		}
+
 		snprintf(cmd, sizeof(cmd), "%s --add-section .BTF=%s %s",
 			 llvm_objcopy, tmp_fn, filename);
+		if (system(cmd)) {
+			fprintf(stderr, "%s: failed to add .BTF section to '%s': %d!\n",
+				__func__, tmp_fn, errno);
+			goto out;
+		}
 
-		if (write(fd, btf_data, btf_size) == btf_size && !system(cmd))
-			err = 0;
-
+		err = 0;
 		unlink(tmp_fn);
 	}
 
-- 
2.24.1

