Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F8583FE343
	for <lists+bpf@lfdr.de>; Wed,  1 Sep 2021 21:44:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344061AbhIATpq (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 1 Sep 2021 15:45:46 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:44566 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1343495AbhIATpp (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 1 Sep 2021 15:45:45 -0400
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 181Jgsi7015656
        for <bpf@vger.kernel.org>; Wed, 1 Sep 2021 12:44:48 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=G4XqKn0qoxed39SjvtawqzBAk1z6ZTYRpyfKZ0uJEzw=;
 b=H+uJXDicc3aaiNt4hfkaO870nrIrG38scMej/ukodeJD0SGLX9oaeMRFdnr65VaVo+Ir
 /P9eFaHhJhujO0s0D6kMIQ8Dm1xvqduY2roqZoaeriSEtui8ImaogY+jFRXro01m4eYW
 qnRtWD0xlDwWX+hEgaOwmKG8ta20k9u/FeA= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3ate02udm6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 01 Sep 2021 12:44:48 -0700
Received: from intmgw001.38.frc1.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:11d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Wed, 1 Sep 2021 12:44:47 -0700
Received: by devvm3431.ftw0.facebook.com (Postfix, from userid 239838)
        id 81FDA9CDE405; Wed,  1 Sep 2021 12:44:45 -0700 (PDT)
From:   Matt Smith <alastorze@fb.com>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <andriin@kernel.org>,
        <daniel@iogearbox.net>, <kernel-team@fb.com>
CC:     Matt Smith <alastorze@fb.com>
Subject: [PATCH v2 bpf-next 3/3] selftests/bpf: Add checks for X__elf_bytes skeleton helper
Date:   Wed, 1 Sep 2021 12:44:39 -0700
Message-ID: <20210901194439.3853238-4-alastorze@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210901194439.3853238-1-alastorze@fb.com>
References: <20210901194439.3853238-1-alastorze@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-ORIG-GUID: 1b3FbBTbYhgXP4QEerc7tQ7QKdXKbYHs
X-Proofpoint-GUID: 1b3FbBTbYhgXP4QEerc7tQ7QKdXKbYHs
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-09-01_05:2021-09-01,2021-09-01 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 impostorscore=0
 spamscore=0 clxscore=1011 malwarescore=0 phishscore=0 priorityscore=1501
 mlxscore=0 adultscore=0 bulkscore=0 lowpriorityscore=0 mlxlogscore=625
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2108310000 definitions=main-2109010114
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This patch adds two checks for the X__elf_bytes bpf skeleton helper
method.  The first asserts that the pointer returned from the helper
method is valid, the second asserts that the provided size pointer is
set.

Signed-off-by: Matt Smith <alastorze@fb.com>
---
 tools/testing/selftests/bpf/prog_tests/skeleton.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/skeleton.c b/tools/te=
sting/selftests/bpf/prog_tests/skeleton.c
index f6f130c99b8c..963a4f5f596d 100644
--- a/tools/testing/selftests/bpf/prog_tests/skeleton.c
+++ b/tools/testing/selftests/bpf/prog_tests/skeleton.c
@@ -18,6 +18,9 @@ void test_skeleton(void)
 	struct test_skeleton__data *data;
 	struct test_skeleton__rodata *rodata;
 	struct test_skeleton__kconfig *kcfg;
+	const void *eb;
+	size_t ebs_val =3D 0;
+	size_t *ebs =3D &ebs_val;
=20
 	skel =3D test_skeleton__open();
 	if (CHECK(!skel, "skel_open", "failed to open skeleton\n"))
@@ -91,6 +94,10 @@ void test_skeleton(void)
 	CHECK(bss->kern_ver !=3D kcfg->LINUX_KERNEL_VERSION, "ext2",
 	      "got %d !=3D exp %d\n", bss->kern_ver, kcfg->LINUX_KERNEL_VERSION=
);
=20
+	eb =3D test_skeleton__elf_bytes(ebs);
+	ASSERT_OK_PTR(eb, "elf_bytes_not_null");
+	ASSERT_NEQ(*ebs, 0, "elf_bytes_size_not_zero");
+
 cleanup:
 	test_skeleton__destroy(skel);
 }
--=20
2.30.2

