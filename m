Return-Path: <bpf+bounces-6570-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 53D6076B810
	for <lists+bpf@lfdr.de>; Tue,  1 Aug 2023 16:54:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 845541C203D8
	for <lists+bpf@lfdr.de>; Tue,  1 Aug 2023 14:54:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC8F64DC75;
	Tue,  1 Aug 2023 14:54:44 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 759E120EA
	for <bpf@vger.kernel.org>; Tue,  1 Aug 2023 14:54:44 +0000 (UTC)
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9E03120
	for <bpf@vger.kernel.org>; Tue,  1 Aug 2023 07:54:42 -0700 (PDT)
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3710O7lF008372
	for <bpf@vger.kernel.org>; Tue, 1 Aug 2023 07:54:42 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=trsVcPr7uxZWVuGvJ0WSe7hF7ghQVrsr32Hcl5RQaM4=;
 b=ZQ24oqHubyxPyvbnxFGj34GVp0LY8JxjGu6wsQ8mNAvbg5QMp7MnHY79eKKo8DcOLNiG
 L2eroI0Nvl3UwG3bkH/Vj50DzsS3eASY46J3iIpOLwSGqxOST8RB5Z0O8S9SKQWHZFSp
 QL93j1SkTpPGODgetxcsg8bw13LBDTf1ALU= 
Received: from maileast.thefacebook.com ([163.114.130.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3s6qfgwg07-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Tue, 01 Aug 2023 07:54:42 -0700
Received: from twshared6136.05.ash9.facebook.com (2620:10d:c0a8:1c::1b) by
 mail.thefacebook.com (2620:10d:c0a8:82::e) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 1 Aug 2023 07:54:40 -0700
Received: by devbig077.ldc1.facebook.com (Postfix, from userid 158236)
	id CE35822006B57; Tue,  1 Aug 2023 07:54:31 -0700 (PDT)
From: Dave Marchevsky <davemarchevsky@fb.com>
To: <bpf@vger.kernel.org>
CC: Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann
	<daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau
	<martin.lau@kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        Dave Marchevsky
	<davemarchevsky@fb.com>
Subject: [PATCH v1 bpf-next 2/2] selftests/bpf: Add test exercising bpf_find_vma's BPF_F_VMA_NEXT flag
Date: Tue, 1 Aug 2023 07:54:14 -0700
Message-ID: <20230801145414.418145-2-davemarchevsky@fb.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230801145414.418145-1-davemarchevsky@fb.com>
References: <20230801145414.418145-1-davemarchevsky@fb.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 1z_JINg1j6rVDl321_dMry3fjX5CytGT
X-Proofpoint-GUID: 1z_JINg1j6rVDl321_dMry3fjX5CytGT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-01_11,2023-08-01_01,2023-05-22_02
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Nothing is mapped to the zero page, so current find_vma tests use addr 0
to test "failure to find vma containing addr". With the BPF_F_VMA_NEXT
flag, a bpf_find_vma call on an addr 0 will return some vma, so only
small adjustments to existing tests are necessary to validate.

Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
---
 .../testing/selftests/bpf/prog_tests/find_vma.c | 17 +++++++++++++----
 tools/testing/selftests/bpf/progs/find_vma.c    |  5 +++--
 2 files changed, 16 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/find_vma.c b/tools/te=
sting/selftests/bpf/prog_tests/find_vma.c
index 5165b38f0e59..dccf1ccd7468 100644
--- a/tools/testing/selftests/bpf/prog_tests/find_vma.c
+++ b/tools/testing/selftests/bpf/prog_tests/find_vma.c
@@ -19,6 +19,7 @@ static void test_and_reset_skel(struct find_vma *skel, =
int expected_find_zero_re
 	skel->bss->found_vm_exec =3D 0;
 	skel->data->find_addr_ret =3D -1;
 	skel->data->find_zero_ret =3D -1;
+	skel->bss->find_zero_flags =3D 0;
 	skel->bss->d_iname[0] =3D 0;
 }
=20
@@ -77,16 +78,23 @@ static void test_find_vma_pe(struct find_vma *skel)
 	close(pfd);
 }
=20
-static void test_find_vma_kprobe(struct find_vma *skel)
+static void test_find_vma_kprobe(struct find_vma *skel, bool vma_next)
 {
-	int err;
+	int err, expected_find_zero_ret;
=20
 	err =3D find_vma__attach(skel);
 	if (!ASSERT_OK(err, "get_branch_snapshot__attach"))
 		return;
=20
+	if (vma_next) {
+		skel->bss->find_zero_flags =3D BPF_F_VMA_NEXT;
+		expected_find_zero_ret =3D 0;
+	} else {
+		expected_find_zero_ret =3D -ENOENT; /* no vma contains ptr 0 */
+	}
+
 	getpgid(skel->bss->target_pid);
-	test_and_reset_skel(skel, -ENOENT /* could not find vma for ptr 0 */, t=
rue);
+	test_and_reset_skel(skel, expected_find_zero_ret, true);
 }
=20
 static void test_illegal_write_vma(void)
@@ -119,7 +127,8 @@ void serial_test_find_vma(void)
 	skel->bss->addr =3D (__u64)(uintptr_t)test_find_vma_pe;
=20
 	test_find_vma_pe(skel);
-	test_find_vma_kprobe(skel);
+	test_find_vma_kprobe(skel, false);
+	test_find_vma_kprobe(skel, true);
=20
 	find_vma__destroy(skel);
 	test_illegal_write_vma();
diff --git a/tools/testing/selftests/bpf/progs/find_vma.c b/tools/testing=
/selftests/bpf/progs/find_vma.c
index 38034fb82530..73ade81722fa 100644
--- a/tools/testing/selftests/bpf/progs/find_vma.c
+++ b/tools/testing/selftests/bpf/progs/find_vma.c
@@ -17,6 +17,7 @@ pid_t target_pid =3D 0;
 char d_iname[DNAME_INLINE_LEN] =3D {0};
 __u32 found_vm_exec =3D 0;
 __u64 addr =3D 0;
+__u64 find_zero_flags =3D 0;
 int find_zero_ret =3D -1;
 int find_addr_ret =3D -1;
=20
@@ -46,7 +47,7 @@ int handle_getpid(void)
 	find_addr_ret =3D bpf_find_vma(task, addr, check_vma, &data, 0);
=20
 	/* this should return -ENOENT */
-	find_zero_ret =3D bpf_find_vma(task, 0, check_vma, &data, 0);
+	find_zero_ret =3D bpf_find_vma(task, 0, check_vma, &data, find_zero_fla=
gs);
 	return 0;
 }
=20
@@ -64,6 +65,6 @@ int handle_pe(void)
 	/* In NMI, this should return -EBUSY, as the previous call is using
 	 * the irq_work.
 	 */
-	find_zero_ret =3D bpf_find_vma(task, 0, check_vma, &data, 0);
+	find_zero_ret =3D bpf_find_vma(task, 0, check_vma, &data, find_zero_fla=
gs);
 	return 0;
 }
--=20
2.34.1


