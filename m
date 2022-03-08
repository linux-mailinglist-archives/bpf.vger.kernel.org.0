Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 431DB4D2223
	for <lists+bpf@lfdr.de>; Tue,  8 Mar 2022 21:05:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349822AbiCHUGb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 8 Mar 2022 15:06:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239451AbiCHUGa (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 8 Mar 2022 15:06:30 -0500
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBED34A3E9
        for <bpf@vger.kernel.org>; Tue,  8 Mar 2022 12:05:32 -0800 (PST)
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 228IorEh027361
        for <bpf@vger.kernel.org>; Tue, 8 Mar 2022 12:05:32 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=8+mQ2x69D+1MvQgZ7Z0exucApY1tzvNYYZ17y4p5VAM=;
 b=gvbWS/oapaFVEB7Bj7GcubjhSHRYdJLoY4DbmjMHZD2fpdbZqVsQLOdLO7MAKrMdSMVB
 Vet4FFyzhotin11xtCpfi9MQoHfmWK3+WJxhlpdSmW+XDmBQm25v7kit4KdP4PuwF2Mc
 pjdf28pUF4GxKbvqrValZDqK2LWnXJ7qm/M= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3emr97scrb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 08 Mar 2022 12:05:31 -0800
Received: from twshared21672.25.frc3.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:11d::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 8 Mar 2022 12:05:29 -0800
Received: by devvm4897.frc0.facebook.com (Postfix, from userid 537053)
        id 8FD343EBB705; Tue,  8 Mar 2022 12:05:23 -0800 (PST)
From:   Mykola Lysenko <mykolal@fb.com>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <andrii@kernel.org>,
        <daniel@iogearbox.net>
CC:     <yhs@fb.com>, Mykola Lysenko <mykolal@fb.com>
Subject: [PATCH v4 bpf-next 1/3] Improve perf related BPF tests (sample_freq issue)
Date:   Tue, 8 Mar 2022 12:04:47 -0800
Message-ID: <20220308200449.1757478-2-mykolal@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220308200449.1757478-1-mykolal@fb.com>
References: <20220308200449.1757478-1-mykolal@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: nfR4Dvutt8iBA9N0pEnrZFON4n10Jg3P
X-Proofpoint-GUID: nfR4Dvutt8iBA9N0pEnrZFON4n10Jg3P
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

Linux kernel may automatically reduce kernel.perf_event_max_sample_rate
value when running tests in parallel on slow systems. Linux kernel checks
against this limit when opening perf event with freq=3D1 parameter set.
The lower bound is 1000. This patch reduces sample_freq value to 1000
in all BPF tests that use sample_freq to ensure they always can open
perf event.

Signed-off-by: Mykola Lysenko <mykolal@fb.com>
Acked-by: Yonghong Song <yhs@fb.com>
---
 tools/testing/selftests/bpf/prog_tests/bpf_cookie.c    | 2 +-
 tools/testing/selftests/bpf/prog_tests/find_vma.c      | 2 +-
 tools/testing/selftests/bpf/prog_tests/perf_branches.c | 4 ++--
 tools/testing/selftests/bpf/prog_tests/perf_link.c     | 2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_cookie.c b/tools/=
testing/selftests/bpf/prog_tests/bpf_cookie.c
index cd10df6cd0fc..0612e79a9281 100644
--- a/tools/testing/selftests/bpf/prog_tests/bpf_cookie.c
+++ b/tools/testing/selftests/bpf/prog_tests/bpf_cookie.c
@@ -199,7 +199,7 @@ static void pe_subtest(struct test_bpf_cookie *skel)
 	attr.type =3D PERF_TYPE_SOFTWARE;
 	attr.config =3D PERF_COUNT_SW_CPU_CLOCK;
 	attr.freq =3D 1;
-	attr.sample_freq =3D 4000;
+	attr.sample_freq =3D 1000;
 	pfd =3D syscall(__NR_perf_event_open, &attr, -1, 0, -1, PERF_FLAG_FD_CL=
OEXEC);
 	if (!ASSERT_GE(pfd, 0, "perf_fd"))
 		goto cleanup;
diff --git a/tools/testing/selftests/bpf/prog_tests/find_vma.c b/tools/te=
sting/selftests/bpf/prog_tests/find_vma.c
index b74b3c0c555a..743a094c9510 100644
--- a/tools/testing/selftests/bpf/prog_tests/find_vma.c
+++ b/tools/testing/selftests/bpf/prog_tests/find_vma.c
@@ -30,7 +30,7 @@ static int open_pe(void)
 	attr.type =3D PERF_TYPE_HARDWARE;
 	attr.config =3D PERF_COUNT_HW_CPU_CYCLES;
 	attr.freq =3D 1;
-	attr.sample_freq =3D 4000;
+	attr.sample_freq =3D 1000;
 	pfd =3D syscall(__NR_perf_event_open, &attr, 0, -1, -1, PERF_FLAG_FD_CL=
OEXEC);
=20
 	return pfd >=3D 0 ? pfd : -errno;
diff --git a/tools/testing/selftests/bpf/prog_tests/perf_branches.c b/too=
ls/testing/selftests/bpf/prog_tests/perf_branches.c
index 12c4f45cee1a..bc24f83339d6 100644
--- a/tools/testing/selftests/bpf/prog_tests/perf_branches.c
+++ b/tools/testing/selftests/bpf/prog_tests/perf_branches.c
@@ -110,7 +110,7 @@ static void test_perf_branches_hw(void)
 	attr.type =3D PERF_TYPE_HARDWARE;
 	attr.config =3D PERF_COUNT_HW_CPU_CYCLES;
 	attr.freq =3D 1;
-	attr.sample_freq =3D 4000;
+	attr.sample_freq =3D 1000;
 	attr.sample_type =3D PERF_SAMPLE_BRANCH_STACK;
 	attr.branch_sample_type =3D PERF_SAMPLE_BRANCH_USER | PERF_SAMPLE_BRANC=
H_ANY;
 	pfd =3D syscall(__NR_perf_event_open, &attr, -1, 0, -1, PERF_FLAG_FD_CL=
OEXEC);
@@ -151,7 +151,7 @@ static void test_perf_branches_no_hw(void)
 	attr.type =3D PERF_TYPE_SOFTWARE;
 	attr.config =3D PERF_COUNT_SW_CPU_CLOCK;
 	attr.freq =3D 1;
-	attr.sample_freq =3D 4000;
+	attr.sample_freq =3D 1000;
 	pfd =3D syscall(__NR_perf_event_open, &attr, -1, 0, -1, PERF_FLAG_FD_CL=
OEXEC);
 	if (CHECK(pfd < 0, "perf_event_open", "err %d\n", pfd))
 		return;
diff --git a/tools/testing/selftests/bpf/prog_tests/perf_link.c b/tools/t=
esting/selftests/bpf/prog_tests/perf_link.c
index ede07344f264..224eba6fef2e 100644
--- a/tools/testing/selftests/bpf/prog_tests/perf_link.c
+++ b/tools/testing/selftests/bpf/prog_tests/perf_link.c
@@ -39,7 +39,7 @@ void serial_test_perf_link(void)
 	attr.type =3D PERF_TYPE_SOFTWARE;
 	attr.config =3D PERF_COUNT_SW_CPU_CLOCK;
 	attr.freq =3D 1;
-	attr.sample_freq =3D 4000;
+	attr.sample_freq =3D 1000;
 	pfd =3D syscall(__NR_perf_event_open, &attr, -1, 0, -1, PERF_FLAG_FD_CL=
OEXEC);
 	if (!ASSERT_GE(pfd, 0, "perf_fd"))
 		goto cleanup;
--=20
2.30.2

