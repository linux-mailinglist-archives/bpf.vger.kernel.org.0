Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 450BB424655
	for <lists+bpf@lfdr.de>; Wed,  6 Oct 2021 20:56:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231804AbhJFS6g (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 6 Oct 2021 14:58:36 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:8012 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238898AbhJFS6g (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 6 Oct 2021 14:58:36 -0400
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 196HxAxF028002
        for <bpf@vger.kernel.org>; Wed, 6 Oct 2021 11:56:43 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=bVLyt3aCcalV7BPn3S20SOLYJWufv486qO8fdp9L8+Y=;
 b=TfqZFVXgTbeZrk9r0p7lAtd0D/KCBfXNJLG891ESeNVdntL+3zcPMJvo7ZIrDixgWyxr
 Nr+PhOCs9DvCqC9TOsNqPiuNcArTbEy2zgIcXdsyH1vmBg1MD2LcX3EceK9ZaQS4F9Xi
 RzRCNBeOTyei9lxZaWIGLQIQDZMjl+aimkU= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3bhfw4rwvg-6
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 06 Oct 2021 11:56:43 -0700
Received: from intmgw002.48.prn1.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Wed, 6 Oct 2021 11:56:23 -0700
Received: by devvm2661.vll0.facebook.com (Postfix, from userid 200310)
        id 27BE84BDB5B5; Wed,  6 Oct 2021 11:56:20 -0700 (PDT)
From:   Yucong Sun <fallentree@fb.com>
To:     <bpf@vger.kernel.org>
CC:     <andrii@kernel.org>, <sunyucong@gmail.com>
Subject: [PATCH bpf-next v6 05/14] selftests/bpf: adding read_perf_max_sample_freq() helper
Date:   Wed, 6 Oct 2021 11:56:10 -0700
Message-ID: <20211006185619.364369-6-fallentree@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211006185619.364369-1-fallentree@fb.com>
References: <20211006185619.364369-1-fallentree@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-ORIG-GUID: W8lHfXMsNk4tl4iiKxIdnCGtEXgnpchJ
X-Proofpoint-GUID: W8lHfXMsNk4tl4iiKxIdnCGtEXgnpchJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-10-06_04,2021-10-06_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 clxscore=1015 mlxscore=0
 malwarescore=0 bulkscore=0 priorityscore=1501 suspectscore=0 adultscore=0
 mlxlogscore=999 spamscore=0 phishscore=0 lowpriorityscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110060117
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Yucong Sun <sunyucong@gmail.com>

This patch moved a helper function to test_progs and make all tests
setting sampling frequency use it to read current perf_max_sample_freq,
this will avoid triggering EINVAL error.

Signed-off-by: Yucong Sun <sunyucong@gmail.com>
---
 .../selftests/bpf/prog_tests/bpf_cookie.c     |  2 +-
 .../selftests/bpf/prog_tests/perf_branches.c  |  4 ++--
 .../selftests/bpf/prog_tests/perf_link.c      |  2 +-
 .../bpf/prog_tests/stacktrace_build_id_nmi.c  | 19 ++-----------------
 tools/testing/selftests/bpf/test_progs.c      | 15 +++++++++++++++
 tools/testing/selftests/bpf/test_progs.h      |  1 +
 6 files changed, 22 insertions(+), 21 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_cookie.c b/tools/=
testing/selftests/bpf/prog_tests/bpf_cookie.c
index 5eea3c3a40fe..19c9f7b53cfa 100644
--- a/tools/testing/selftests/bpf/prog_tests/bpf_cookie.c
+++ b/tools/testing/selftests/bpf/prog_tests/bpf_cookie.c
@@ -193,7 +193,7 @@ static void pe_subtest(struct test_bpf_cookie *skel)
 	attr.type =3D PERF_TYPE_SOFTWARE;
 	attr.config =3D PERF_COUNT_SW_CPU_CLOCK;
 	attr.freq =3D 1;
-	attr.sample_freq =3D 4000;
+	attr.sample_freq =3D read_perf_max_sample_freq();
 	pfd =3D syscall(__NR_perf_event_open, &attr, -1, 0, -1, PERF_FLAG_FD_CL=
OEXEC);
 	if (!ASSERT_GE(pfd, 0, "perf_fd"))
 		goto cleanup;
diff --git a/tools/testing/selftests/bpf/prog_tests/perf_branches.c b/too=
ls/testing/selftests/bpf/prog_tests/perf_branches.c
index 12c4f45cee1a..6b2e3dced619 100644
--- a/tools/testing/selftests/bpf/prog_tests/perf_branches.c
+++ b/tools/testing/selftests/bpf/prog_tests/perf_branches.c
@@ -110,7 +110,7 @@ static void test_perf_branches_hw(void)
 	attr.type =3D PERF_TYPE_HARDWARE;
 	attr.config =3D PERF_COUNT_HW_CPU_CYCLES;
 	attr.freq =3D 1;
-	attr.sample_freq =3D 4000;
+	attr.sample_freq =3D read_perf_max_sample_freq();
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
+	attr.sample_freq =3D read_perf_max_sample_freq();
 	pfd =3D syscall(__NR_perf_event_open, &attr, -1, 0, -1, PERF_FLAG_FD_CL=
OEXEC);
 	if (CHECK(pfd < 0, "perf_event_open", "err %d\n", pfd))
 		return;
diff --git a/tools/testing/selftests/bpf/prog_tests/perf_link.c b/tools/t=
esting/selftests/bpf/prog_tests/perf_link.c
index b1abd0c46607..74e5bd5f1c19 100644
--- a/tools/testing/selftests/bpf/prog_tests/perf_link.c
+++ b/tools/testing/selftests/bpf/prog_tests/perf_link.c
@@ -38,7 +38,7 @@ void test_perf_link(void)
 	attr.type =3D PERF_TYPE_SOFTWARE;
 	attr.config =3D PERF_COUNT_SW_CPU_CLOCK;
 	attr.freq =3D 1;
-	attr.sample_freq =3D 4000;
+	attr.sample_freq =3D read_perf_max_sample_freq();
 	pfd =3D syscall(__NR_perf_event_open, &attr, -1, 0, -1, PERF_FLAG_FD_CL=
OEXEC);
 	if (!ASSERT_GE(pfd, 0, "perf_fd"))
 		goto cleanup;
diff --git a/tools/testing/selftests/bpf/prog_tests/stacktrace_build_id_n=
mi.c b/tools/testing/selftests/bpf/prog_tests/stacktrace_build_id_nmi.c
index 0a91d8d9954b..150536f01442 100644
--- a/tools/testing/selftests/bpf/prog_tests/stacktrace_build_id_nmi.c
+++ b/tools/testing/selftests/bpf/prog_tests/stacktrace_build_id_nmi.c
@@ -2,21 +2,6 @@
 #include <test_progs.h>
 #include "test_stacktrace_build_id.skel.h"
=20
-static __u64 read_perf_max_sample_freq(void)
-{
-	__u64 sample_freq =3D 5000; /* fallback to 5000 on error */
-	FILE *f;
-	__u32 duration =3D 0;
-
-	f =3D fopen("/proc/sys/kernel/perf_event_max_sample_rate", "r");
-	if (f =3D=3D NULL)
-		return sample_freq;
-	CHECK(fscanf(f, "%llu", &sample_freq) !=3D 1, "Get max sample rate",
-		  "return default value: 5000,err %d\n", -errno);
-	fclose(f);
-	return sample_freq;
-}
-
 void test_stacktrace_build_id_nmi(void)
 {
 	int control_map_fd, stackid_hmap_fd, stackmap_fd;
@@ -34,8 +19,6 @@ void test_stacktrace_build_id_nmi(void)
 	int build_id_matches =3D 0;
 	int retry =3D 1;
=20
-	attr.sample_freq =3D read_perf_max_sample_freq();
-
 retry:
 	skel =3D test_stacktrace_build_id__open();
 	if (CHECK(!skel, "skel_open", "skeleton open failed\n"))
@@ -48,6 +31,8 @@ void test_stacktrace_build_id_nmi(void)
 	if (CHECK(err, "skel_load", "skeleton load failed: %d\n", err))
 		goto cleanup;
=20
+	attr.sample_freq =3D read_perf_max_sample_freq();
+
 	pmu_fd =3D syscall(__NR_perf_event_open, &attr, -1 /* pid */,
 			 0 /* cpu 0 */, -1 /* group id */,
 			 0 /* flags */);
diff --git a/tools/testing/selftests/bpf/test_progs.c b/tools/testing/sel=
ftests/bpf/test_progs.c
index 2ac922f8aa2c..66825313414b 100644
--- a/tools/testing/selftests/bpf/test_progs.c
+++ b/tools/testing/selftests/bpf/test_progs.c
@@ -1500,3 +1500,18 @@ int main(int argc, char **argv)
=20
 	return env.fail_cnt ? EXIT_FAILURE : EXIT_SUCCESS;
 }
+
+__u64 read_perf_max_sample_freq(void)
+{
+	__u64 sample_freq =3D 1000; /* fallback to 1000 on error */
+	FILE *f;
+	__u32 duration =3D 0;
+
+	f =3D fopen("/proc/sys/kernel/perf_event_max_sample_rate", "r");
+	if (f =3D=3D NULL)
+		return sample_freq;
+	CHECK(fscanf(f, "%llu", &sample_freq) !=3D 1, "Get max sample rate",
+	      "return default value: 5000,err %d\n", -errno);
+	fclose(f);
+	return sample_freq;
+}
diff --git a/tools/testing/selftests/bpf/test_progs.h b/tools/testing/sel=
ftests/bpf/test_progs.h
index b239dc9fcef0..d5ca0d36cc96 100644
--- a/tools/testing/selftests/bpf/test_progs.h
+++ b/tools/testing/selftests/bpf/test_progs.h
@@ -327,6 +327,7 @@ int extract_build_id(char *build_id, size_t size);
 int kern_sync_rcu(void);
 int trigger_module_test_read(int read_sz);
 int trigger_module_test_write(int write_sz);
+__u64 read_perf_max_sample_freq(void);
=20
 #ifdef __x86_64__
 #define SYS_NANOSLEEP_KPROBE_NAME "__x64_sys_nanosleep"
--=20
2.30.2

