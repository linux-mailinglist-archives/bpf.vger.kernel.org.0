Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7C0820FA3D
	for <lists+bpf@lfdr.de>; Tue, 30 Jun 2020 19:13:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387736AbgF3RNJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 30 Jun 2020 13:13:09 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:55612 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729963AbgF3RNI (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 30 Jun 2020 13:13:08 -0400
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05UGFvib029333
        for <bpf@vger.kernel.org>; Tue, 30 Jun 2020 10:13:08 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=Tq6+1il9pk6akMcywfwAMr6DPQXnuUNhk/RVge8GW/E=;
 b=mw3dS25YO7OJ++iJ7r7vgR5pO24rYaFgLSPb88i/lC7peyWfIFHel++rcaClh+1tV8g+
 WDDACvyQSdS17ifbLoa0jnwLOK5Tan4r3AubohZXCjK3P3c2H5np0771wxEyjYbuJ04x
 NEheHczXAFTFDChnHuhu/cCaN/cDYm5n8Qg= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 31x3upnekj-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 30 Jun 2020 10:13:07 -0700
Received: from intmgw001.03.ash8.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:11d::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 30 Jun 2020 10:12:45 -0700
Received: by devbig003.ftw2.facebook.com (Postfix, from userid 128203)
        id BE8FE3702224; Tue, 30 Jun 2020 10:12:41 -0700 (PDT)
Smtp-Origin-Hostprefix: devbig
From:   Yonghong Song <yhs@fb.com>
Smtp-Origin-Hostname: devbig003.ftw2.facebook.com
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Wenbo Zhang <ethercflow@gmail.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH bpf 2/2] bpf: add tests for PTR_TO_BTF_ID vs. null comparison
Date:   Tue, 30 Jun 2020 10:12:41 -0700
Message-ID: <20200630171241.2523875-1-yhs@fb.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200630171240.2523628-1-yhs@fb.com>
References: <20200630171240.2523628-1-yhs@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-06-30_06:2020-06-30,2020-06-30 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 adultscore=0
 mlxlogscore=999 lowpriorityscore=0 impostorscore=0 phishscore=0
 spamscore=0 bulkscore=0 priorityscore=1501 cotscore=-2147483648
 suspectscore=13 mlxscore=0 malwarescore=0 clxscore=1015 classifier=spam
 adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006300116
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add two tests for PTR_TO_BTF_ID vs. null ptr comparison,
one for PTR_TO_BTF_ID in the ctx structure and the
other for PTR_TO_BTF_ID after one level pointer chasing.
In both cases, the test ensures condition is not
removed.

For example, for this test
 struct bpf_fentry_test_t {
     struct bpf_fentry_test_t *a;
 };
 int BPF_PROG(test7, struct bpf_fentry_test_t *arg)
 {
     if (arg =3D=3D 0)
         test7_result =3D 1;
     return 0;
 }
Before the previous verifier change, we have xlated codes:
  int test7(long long unsigned int * ctx):
  ; int BPF_PROG(test7, struct bpf_fentry_test_t *arg)
     0: (79) r1 =3D *(u64 *)(r1 +0)
  ; int BPF_PROG(test7, struct bpf_fentry_test_t *arg)
     1: (b4) w0 =3D 0
     2: (95) exit
After the previous verifier change, we have:
  int test7(long long unsigned int * ctx):
  ; int BPF_PROG(test7, struct bpf_fentry_test_t *arg)
     0: (79) r1 =3D *(u64 *)(r1 +0)
  ; if (arg =3D=3D 0)
     1: (55) if r1 !=3D 0x0 goto pc+4
  ; test7_result =3D 1;
     2: (18) r1 =3D map[id:6][0]+48
     4: (b7) r2 =3D 1
     5: (7b) *(u64 *)(r1 +0) =3D r2
  ; int BPF_PROG(test7, struct bpf_fentry_test_t *arg)
     6: (b4) w0 =3D 0
     7: (95) exit

Cc: Andrii Nakryiko <andriin@fb.com>
Cc: John Fastabend <john.fastabend@gmail.com>
Cc: Wenbo Zhang <ethercflow@gmail.com>
Signed-off-by: Yonghong Song <yhs@fb.com>
---
 net/bpf/test_run.c                            | 19 +++++++++++++++-
 .../selftests/bpf/prog_tests/fentry_fexit.c   |  2 +-
 .../testing/selftests/bpf/progs/fentry_test.c | 22 +++++++++++++++++++
 .../testing/selftests/bpf/progs/fexit_test.c  | 22 +++++++++++++++++++
 4 files changed, 63 insertions(+), 2 deletions(-)

diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
index bfd4ccd80847..b03c469cd01f 100644
--- a/net/bpf/test_run.c
+++ b/net/bpf/test_run.c
@@ -147,6 +147,20 @@ int noinline bpf_fentry_test6(u64 a, void *b, short =
c, int d, void *e, u64 f)
 	return a + (long)b + c + d + (long)e + f;
 }
=20
+struct bpf_fentry_test_t {
+	struct bpf_fentry_test_t *a;
+};
+
+int noinline bpf_fentry_test7(struct bpf_fentry_test_t *arg)
+{
+	return (long)arg;
+}
+
+int noinline bpf_fentry_test8(struct bpf_fentry_test_t *arg)
+{
+	return (long)arg->a;
+}
+
 int noinline bpf_modify_return_test(int a, int *b)
 {
 	*b +=3D 1;
@@ -185,6 +199,7 @@ int bpf_prog_test_run_tracing(struct bpf_prog *prog,
 			      const union bpf_attr *kattr,
 			      union bpf_attr __user *uattr)
 {
+	struct bpf_fentry_test_t arg =3D {};
 	u16 side_effect =3D 0, ret =3D 0;
 	int b =3D 2, err =3D -EFAULT;
 	u32 retval =3D 0;
@@ -197,7 +212,9 @@ int bpf_prog_test_run_tracing(struct bpf_prog *prog,
 		    bpf_fentry_test3(4, 5, 6) !=3D 15 ||
 		    bpf_fentry_test4((void *)7, 8, 9, 10) !=3D 34 ||
 		    bpf_fentry_test5(11, (void *)12, 13, 14, 15) !=3D 65 ||
-		    bpf_fentry_test6(16, (void *)17, 18, 19, (void *)20, 21) !=3D 111)
+		    bpf_fentry_test6(16, (void *)17, 18, 19, (void *)20, 21) !=3D 111 =
||
+		    bpf_fentry_test7((struct bpf_fentry_test_t *)0) !=3D 0 ||
+		    bpf_fentry_test8(&arg) !=3D 0)
 			goto out;
 		break;
 	case BPF_MODIFY_RETURN:
diff --git a/tools/testing/selftests/bpf/prog_tests/fentry_fexit.c b/tool=
s/testing/selftests/bpf/prog_tests/fentry_fexit.c
index 83493bd5745c..109d0345a2be 100644
--- a/tools/testing/selftests/bpf/prog_tests/fentry_fexit.c
+++ b/tools/testing/selftests/bpf/prog_tests/fentry_fexit.c
@@ -36,7 +36,7 @@ void test_fentry_fexit(void)
 	fentry_res =3D (__u64 *)fentry_skel->bss;
 	fexit_res =3D (__u64 *)fexit_skel->bss;
 	printf("%lld\n", fentry_skel->bss->test1_result);
-	for (i =3D 0; i < 6; i++) {
+	for (i =3D 0; i < 8; i++) {
 		CHECK(fentry_res[i] !=3D 1, "result",
 		      "fentry_test%d failed err %lld\n", i + 1, fentry_res[i]);
 		CHECK(fexit_res[i] !=3D 1, "result",
diff --git a/tools/testing/selftests/bpf/progs/fentry_test.c b/tools/test=
ing/selftests/bpf/progs/fentry_test.c
index 9365b686f84b..5f645fdaba6f 100644
--- a/tools/testing/selftests/bpf/progs/fentry_test.c
+++ b/tools/testing/selftests/bpf/progs/fentry_test.c
@@ -55,3 +55,25 @@ int BPF_PROG(test6, __u64 a, void *b, short c, int d, =
void * e, __u64 f)
 		e =3D=3D (void *)20 && f =3D=3D 21;
 	return 0;
 }
+
+struct bpf_fentry_test_t {
+	struct bpf_fentry_test_t *a;
+};
+
+__u64 test7_result =3D 0;
+SEC("fentry/bpf_fentry_test7")
+int BPF_PROG(test7, struct bpf_fentry_test_t *arg)
+{
+	if (arg =3D=3D 0)
+		test7_result =3D 1;
+	return 0;
+}
+
+__u64 test8_result =3D 0;
+SEC("fentry/bpf_fentry_test8")
+int BPF_PROG(test8, struct bpf_fentry_test_t *arg)
+{
+	if (arg->a =3D=3D 0)
+		test8_result =3D 1;
+	return 0;
+}
diff --git a/tools/testing/selftests/bpf/progs/fexit_test.c b/tools/testi=
ng/selftests/bpf/progs/fexit_test.c
index bd1e17d8024c..0952affb22a6 100644
--- a/tools/testing/selftests/bpf/progs/fexit_test.c
+++ b/tools/testing/selftests/bpf/progs/fexit_test.c
@@ -56,3 +56,25 @@ int BPF_PROG(test6, __u64 a, void *b, short c, int d, =
void *e, __u64 f, int ret)
 		e =3D=3D (void *)20 && f =3D=3D 21 && ret =3D=3D 111;
 	return 0;
 }
+
+struct bpf_fentry_test_t {
+	struct bpf_fentry_test *a;
+};
+
+__u64 test7_result =3D 0;
+SEC("fexit/bpf_fentry_test7")
+int BPF_PROG(test7, struct bpf_fentry_test_t *arg)
+{
+	if (arg =3D=3D 0)
+		test7_result =3D 1;
+	return 0;
+}
+
+__u64 test8_result =3D 0;
+SEC("fexit/bpf_fentry_test8")
+int BPF_PROG(test8, struct bpf_fentry_test_t *arg)
+{
+	if (arg->a =3D=3D 0)
+		test8_result =3D 1;
+	return 0;
+}
--=20
2.24.1

