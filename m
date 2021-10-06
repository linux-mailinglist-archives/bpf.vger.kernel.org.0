Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDA4E424652
	for <lists+bpf@lfdr.de>; Wed,  6 Oct 2021 20:56:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238494AbhJFS61 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 6 Oct 2021 14:58:27 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:26090 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S238725AbhJFS61 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 6 Oct 2021 14:58:27 -0400
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.1.2/8.16.1.2) with SMTP id 196IEsed008148
        for <bpf@vger.kernel.org>; Wed, 6 Oct 2021 11:56:34 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=OcUhUFGkQhp9r+qSJ7k5tY3dBSIcIymxKK4WN+OL6Mw=;
 b=LLuctuoQ4b9rirZ8l5iEFDHDzmfFdhHCj1imtTTSS9QhYHy72xWbFjUTeuEpPsw2EsvY
 U2lIqUMSAMQCKXtwHkhLPxqUqDIAZCwAwtdRx6q2G3uPu44Vlai3Zyx8fHvm9tEp8f/5
 Vc0FMSoqip6fdSeU8pLpWRIOgIm8bvLqxdU= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0089730.ppops.net with ESMTP id 3bhcm1tt9u-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 06 Oct 2021 11:56:34 -0700
Received: from intmgw001.05.prn6.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Wed, 6 Oct 2021 11:56:33 -0700
Received: by devvm2661.vll0.facebook.com (Postfix, from userid 200310)
        id 40B684BDB5BF; Wed,  6 Oct 2021 11:56:20 -0700 (PDT)
From:   Yucong Sun <fallentree@fb.com>
To:     <bpf@vger.kernel.org>
CC:     <andrii@kernel.org>, <sunyucong@gmail.com>
Subject: [PATCH bpf-next v6 10/14] selftests/bpf: adding pid filtering for atomics test
Date:   Wed, 6 Oct 2021 11:56:15 -0700
Message-ID: <20211006185619.364369-11-fallentree@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211006185619.364369-1-fallentree@fb.com>
References: <20211006185619.364369-1-fallentree@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-ORIG-GUID: 8IJKB4Bbo5KBJAfEUCnUUz15Hv8b9Qeo
X-Proofpoint-GUID: 8IJKB4Bbo5KBJAfEUCnUUz15Hv8b9Qeo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-10-06_04,2021-10-06_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0 phishscore=0
 spamscore=0 suspectscore=0 bulkscore=0 adultscore=0 mlxlogscore=622
 clxscore=1015 priorityscore=1501 malwarescore=0 lowpriorityscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110060117
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Yucong Sun <sunyucong@gmail.com>

This make atomics test able to run in parallel with other tests.

Signed-off-by: Yucong Sun <sunyucong@gmail.com>
---
 tools/testing/selftests/bpf/prog_tests/atomics.c |  1 +
 tools/testing/selftests/bpf/progs/atomics.c      | 16 ++++++++++++++++
 2 files changed, 17 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/atomics.c b/tools/tes=
ting/selftests/bpf/prog_tests/atomics.c
index ba0e1efe5a45..1486be5d3209 100644
--- a/tools/testing/selftests/bpf/prog_tests/atomics.c
+++ b/tools/testing/selftests/bpf/prog_tests/atomics.c
@@ -225,6 +225,7 @@ void test_atomics(void)
 		test__skip();
 		goto cleanup;
 	}
+	skel->bss->pid =3D getpid();
=20
 	if (test__start_subtest("add"))
 		test_add(skel);
diff --git a/tools/testing/selftests/bpf/progs/atomics.c b/tools/testing/=
selftests/bpf/progs/atomics.c
index c245345e41ca..16e57313204a 100644
--- a/tools/testing/selftests/bpf/progs/atomics.c
+++ b/tools/testing/selftests/bpf/progs/atomics.c
@@ -10,6 +10,8 @@ bool skip_tests __attribute((__section__(".data"))) =3D=
 false;
 bool skip_tests =3D true;
 #endif
=20
+__u32 pid =3D 0;
+
 __u64 add64_value =3D 1;
 __u64 add64_result =3D 0;
 __u32 add32_value =3D 1;
@@ -21,6 +23,8 @@ __u64 add_noreturn_value =3D 1;
 SEC("fentry/bpf_fentry_test1")
 int BPF_PROG(add, int a)
 {
+	if (pid !=3D (bpf_get_current_pid_tgid() >> 32))
+		return 0;
 #ifdef ENABLE_ATOMICS_TESTS
 	__u64 add_stack_value =3D 1;
=20
@@ -45,6 +49,8 @@ __s64 sub_noreturn_value =3D 1;
 SEC("fentry/bpf_fentry_test1")
 int BPF_PROG(sub, int a)
 {
+	if (pid !=3D (bpf_get_current_pid_tgid() >> 32))
+		return 0;
 #ifdef ENABLE_ATOMICS_TESTS
 	__u64 sub_stack_value =3D 1;
=20
@@ -67,6 +73,8 @@ __u64 and_noreturn_value =3D (0x110ull << 32);
 SEC("fentry/bpf_fentry_test1")
 int BPF_PROG(and, int a)
 {
+	if (pid !=3D (bpf_get_current_pid_tgid() >> 32))
+		return 0;
 #ifdef ENABLE_ATOMICS_TESTS
=20
 	and64_result =3D __sync_fetch_and_and(&and64_value, 0x011ull << 32);
@@ -86,6 +94,8 @@ __u64 or_noreturn_value =3D (0x110ull << 32);
 SEC("fentry/bpf_fentry_test1")
 int BPF_PROG(or, int a)
 {
+	if (pid !=3D (bpf_get_current_pid_tgid() >> 32))
+		return 0;
 #ifdef ENABLE_ATOMICS_TESTS
 	or64_result =3D __sync_fetch_and_or(&or64_value, 0x011ull << 32);
 	or32_result =3D __sync_fetch_and_or(&or32_value, 0x011);
@@ -104,6 +114,8 @@ __u64 xor_noreturn_value =3D (0x110ull << 32);
 SEC("fentry/bpf_fentry_test1")
 int BPF_PROG(xor, int a)
 {
+	if (pid !=3D (bpf_get_current_pid_tgid() >> 32))
+		return 0;
 #ifdef ENABLE_ATOMICS_TESTS
 	xor64_result =3D __sync_fetch_and_xor(&xor64_value, 0x011ull << 32);
 	xor32_result =3D __sync_fetch_and_xor(&xor32_value, 0x011);
@@ -123,6 +135,8 @@ __u32 cmpxchg32_result_succeed =3D 0;
 SEC("fentry/bpf_fentry_test1")
 int BPF_PROG(cmpxchg, int a)
 {
+	if (pid !=3D (bpf_get_current_pid_tgid() >> 32))
+		return 0;
 #ifdef ENABLE_ATOMICS_TESTS
 	cmpxchg64_result_fail =3D __sync_val_compare_and_swap(&cmpxchg64_value,=
 0, 3);
 	cmpxchg64_result_succeed =3D __sync_val_compare_and_swap(&cmpxchg64_val=
ue, 1, 2);
@@ -142,6 +156,8 @@ __u32 xchg32_result =3D 0;
 SEC("fentry/bpf_fentry_test1")
 int BPF_PROG(xchg, int a)
 {
+	if (pid !=3D (bpf_get_current_pid_tgid() >> 32))
+		return 0;
 #ifdef ENABLE_ATOMICS_TESTS
 	__u64 val64 =3D 2;
 	__u32 val32 =3D 2;
--=20
2.30.2

