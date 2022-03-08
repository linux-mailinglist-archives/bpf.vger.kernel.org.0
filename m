Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F3AA4D2225
	for <lists+bpf@lfdr.de>; Tue,  8 Mar 2022 21:05:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350113AbiCHUGg (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 8 Mar 2022 15:06:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349809AbiCHUGg (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 8 Mar 2022 15:06:36 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 976174A3E9
        for <bpf@vger.kernel.org>; Tue,  8 Mar 2022 12:05:39 -0800 (PST)
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 228IopFf025017
        for <bpf@vger.kernel.org>; Tue, 8 Mar 2022 12:05:39 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=PozqKVmCONyHBnyS7Bdpuz/RFF2KXoE2Pn4Bv0wNZT4=;
 b=PdEZWmfAV1W+C8rupHKPV6m7vc3zQJfYhIBiLTFa1ftyVIvbCIknGLdPqT9CwQX7OICt
 Ht/VQtm6WInNbKmY9S9FHtp0ESHXHU9XYD+WYjKt+3unIKHbvvNksrVZ1YSCu69kpy/l
 X33HNNJN8COy1LbzGhY0FXwZK2VxOHzBqrQ= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3enu25y25n-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 08 Mar 2022 12:05:39 -0800
Received: from twshared22811.39.frc1.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:11d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 8 Mar 2022 12:05:38 -0800
Received: by devvm4897.frc0.facebook.com (Postfix, from userid 537053)
        id E00D03EBB79B; Tue,  8 Mar 2022 12:05:33 -0800 (PST)
From:   Mykola Lysenko <mykolal@fb.com>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <andrii@kernel.org>,
        <daniel@iogearbox.net>
CC:     <yhs@fb.com>, Mykola Lysenko <mykolal@fb.com>
Subject: [PATCH v4 bpf-next 3/3] Improve stability of find_vma BPF test
Date:   Tue, 8 Mar 2022 12:04:49 -0800
Message-ID: <20220308200449.1757478-4-mykolal@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220308200449.1757478-1-mykolal@fb.com>
References: <20220308200449.1757478-1-mykolal@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: ye1dqFESTi4t3PZBTjwklw3St6ABInk9
X-Proofpoint-ORIG-GUID: ye1dqFESTi4t3PZBTjwklw3St6ABInk9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-08_08,2022-03-04_01,2022-02-23_01
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Remove unneeded spleep and increase length of dummy CPU
intensive computation to guarantee test process execution.
Also, complete aforemention computation as soon as
test success criteria is met

Signed-off-by: Mykola Lysenko <mykolal@fb.com>
Acked-by: Yonghong Song <yhs@fb.com>
---
 .../selftests/bpf/prog_tests/find_vma.c       | 28 +++++++++++++------
 1 file changed, 19 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/find_vma.c b/tools/te=
sting/selftests/bpf/prog_tests/find_vma.c
index 743a094c9510..5165b38f0e59 100644
--- a/tools/testing/selftests/bpf/prog_tests/find_vma.c
+++ b/tools/testing/selftests/bpf/prog_tests/find_vma.c
@@ -7,12 +7,14 @@
 #include "find_vma_fail1.skel.h"
 #include "find_vma_fail2.skel.h"
=20
-static void test_and_reset_skel(struct find_vma *skel, int expected_find=
_zero_ret)
+static void test_and_reset_skel(struct find_vma *skel, int expected_find=
_zero_ret, bool need_test)
 {
-	ASSERT_EQ(skel->bss->found_vm_exec, 1, "found_vm_exec");
-	ASSERT_EQ(skel->data->find_addr_ret, 0, "find_addr_ret");
-	ASSERT_EQ(skel->data->find_zero_ret, expected_find_zero_ret, "find_zero=
_ret");
-	ASSERT_OK_PTR(strstr(skel->bss->d_iname, "test_progs"), "find_test_prog=
s");
+	if (need_test) {
+		ASSERT_EQ(skel->bss->found_vm_exec, 1, "found_vm_exec");
+		ASSERT_EQ(skel->data->find_addr_ret, 0, "find_addr_ret");
+		ASSERT_EQ(skel->data->find_zero_ret, expected_find_zero_ret, "find_zer=
o_ret");
+		ASSERT_OK_PTR(strstr(skel->bss->d_iname, "test_progs"), "find_test_pro=
gs");
+	}
=20
 	skel->bss->found_vm_exec =3D 0;
 	skel->data->find_addr_ret =3D -1;
@@ -36,11 +38,20 @@ static int open_pe(void)
 	return pfd >=3D 0 ? pfd : -errno;
 }
=20
+static bool find_vma_pe_condition(struct find_vma *skel)
+{
+	return skel->bss->found_vm_exec =3D=3D 0 ||
+		skel->data->find_addr_ret !=3D 0 ||
+		skel->data->find_zero_ret =3D=3D -1 ||
+		strcmp(skel->bss->d_iname, "test_progs") !=3D 0;
+}
+
 static void test_find_vma_pe(struct find_vma *skel)
 {
 	struct bpf_link *link =3D NULL;
 	volatile int j =3D 0;
 	int pfd, i;
+	const int one_bn =3D 1000000000;
=20
 	pfd =3D open_pe();
 	if (pfd < 0) {
@@ -57,10 +68,10 @@ static void test_find_vma_pe(struct find_vma *skel)
 	if (!ASSERT_OK_PTR(link, "attach_perf_event"))
 		goto cleanup;
=20
-	for (i =3D 0; i < 1000000; ++i)
+	for (i =3D 0; i < one_bn && find_vma_pe_condition(skel); ++i)
 		++j;
=20
-	test_and_reset_skel(skel, -EBUSY /* in nmi, irq_work is busy */);
+	test_and_reset_skel(skel, -EBUSY /* in nmi, irq_work is busy */, i =3D=3D=
 one_bn);
 cleanup:
 	bpf_link__destroy(link);
 	close(pfd);
@@ -75,7 +86,7 @@ static void test_find_vma_kprobe(struct find_vma *skel)
 		return;
=20
 	getpgid(skel->bss->target_pid);
-	test_and_reset_skel(skel, -ENOENT /* could not find vma for ptr 0 */);
+	test_and_reset_skel(skel, -ENOENT /* could not find vma for ptr 0 */, t=
rue);
 }
=20
 static void test_illegal_write_vma(void)
@@ -108,7 +119,6 @@ void serial_test_find_vma(void)
 	skel->bss->addr =3D (__u64)(uintptr_t)test_find_vma_pe;
=20
 	test_find_vma_pe(skel);
-	usleep(100000); /* allow the irq_work to finish */
 	test_find_vma_kprobe(skel);
=20
 	find_vma__destroy(skel);
--=20
2.30.2

