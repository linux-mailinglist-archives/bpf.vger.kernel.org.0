Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F00C842464B
	for <lists+bpf@lfdr.de>; Wed,  6 Oct 2021 20:56:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232002AbhJFS6S (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 6 Oct 2021 14:58:18 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:17198 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231826AbhJFS6R (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 6 Oct 2021 14:58:17 -0400
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 196Fppn6024374
        for <bpf@vger.kernel.org>; Wed, 6 Oct 2021 11:56:25 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=yI/7IylHHToBYN/mQWMSmJoslxdzOikCNq6PmCNtpGU=;
 b=NQTtuC3HsppKXbnFP50+Gy3vy6bJF7axMwSVERceVsMmVTsdVWoWjkm0adCnKPEjZRsX
 bPmTzbSkAuotLWluVMjZlx/XR9ExibS34G0QigZ6UMogcQSH8w9d52yucA85YP/lHcim
 R06cElMbBB6cKXXmQ4oyu/m3KpdBGwBTRwI= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3bhetf9kvt-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 06 Oct 2021 11:56:25 -0700
Received: from intmgw002.48.prn1.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::d) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Wed, 6 Oct 2021 11:56:23 -0700
Received: by devvm2661.vll0.facebook.com (Postfix, from userid 200310)
        id 3BEED4BDB5BD; Wed,  6 Oct 2021 11:56:20 -0700 (PDT)
From:   Yucong Sun <fallentree@fb.com>
To:     <bpf@vger.kernel.org>
CC:     <andrii@kernel.org>, <sunyucong@gmail.com>
Subject: [PATCH bpf-next v6 09/14] selftests/bpf: Make uprobe tests use different attach functions.
Date:   Wed, 6 Oct 2021 11:56:14 -0700
Message-ID: <20211006185619.364369-10-fallentree@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211006185619.364369-1-fallentree@fb.com>
References: <20211006185619.364369-1-fallentree@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-GUID: 1n0YDHSQmuSzlCo3ZL4B48NmSLMA-QX3
X-Proofpoint-ORIG-GUID: 1n0YDHSQmuSzlCo3ZL4B48NmSLMA-QX3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-10-06_04,2021-10-06_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=1 lowpriorityscore=0
 bulkscore=0 phishscore=0 clxscore=1015 impostorscore=0 malwarescore=0
 suspectscore=0 mlxscore=1 priorityscore=1501 adultscore=0 spamscore=1
 mlxlogscore=228 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110060117
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Yucong Sun <sunyucong@gmail.com>

Using same address on different processes of the same binary often fail
with EINVAL, this patch make these tests use distinct methods, so they
can run in parallel.

Signed-off-by: Yucong Sun <sunyucong@gmail.com>
---
 tools/testing/selftests/bpf/prog_tests/attach_probe.c | 8 ++++++--
 tools/testing/selftests/bpf/prog_tests/bpf_cookie.c   | 8 ++++++--
 tools/testing/selftests/bpf/prog_tests/task_pt_regs.c | 8 ++++++--
 3 files changed, 18 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/attach_probe.c b/tool=
s/testing/selftests/bpf/prog_tests/attach_probe.c
index 6c511dcd1465..eff36ba9c148 100644
--- a/tools/testing/selftests/bpf/prog_tests/attach_probe.c
+++ b/tools/testing/selftests/bpf/prog_tests/attach_probe.c
@@ -5,6 +5,10 @@
 /* this is how USDT semaphore is actually defined, except volatile modif=
ier */
 volatile unsigned short uprobe_ref_ctr __attribute__((unused)) __attribu=
te((section(".probes")));
=20
+static int method() {
+	return get_base_addr();
+}
+
 void test_attach_probe(void)
 {
 	DECLARE_LIBBPF_OPTS(bpf_uprobe_opts, uprobe_opts);
@@ -33,7 +37,7 @@ void test_attach_probe(void)
 	if (CHECK(base_addr < 0, "get_base_addr",
 		  "failed to find base addr: %zd", base_addr))
 		return;
-	uprobe_offset =3D get_uprobe_offset(&get_base_addr, base_addr);
+	uprobe_offset =3D get_uprobe_offset(&method, base_addr);
=20
 	ref_ctr_offset =3D get_rel_offset((uintptr_t)&uprobe_ref_ctr);
 	if (!ASSERT_GE(ref_ctr_offset, 0, "ref_ctr_offset"))
@@ -98,7 +102,7 @@ void test_attach_probe(void)
 		goto cleanup;
=20
 	/* trigger & validate uprobe & uretprobe */
-	get_base_addr();
+	method();
=20
 	if (CHECK(skel->bss->uprobe_res !=3D 3, "check_uprobe_res",
 		  "wrong uprobe res: %d\n", skel->bss->uprobe_res))
diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_cookie.c b/tools/=
testing/selftests/bpf/prog_tests/bpf_cookie.c
index 19c9f7b53cfa..5ebd8ba988e2 100644
--- a/tools/testing/selftests/bpf/prog_tests/bpf_cookie.c
+++ b/tools/testing/selftests/bpf/prog_tests/bpf_cookie.c
@@ -8,6 +8,10 @@
 #include <test_progs.h>
 #include "test_bpf_cookie.skel.h"
=20
+static int method() {
+	return get_base_addr();
+}
+
 static void kprobe_subtest(struct test_bpf_cookie *skel)
 {
 	DECLARE_LIBBPF_OPTS(bpf_kprobe_opts, opts);
@@ -66,7 +70,7 @@ static void uprobe_subtest(struct test_bpf_cookie *skel=
)
 	ssize_t base_addr;
=20
 	base_addr =3D get_base_addr();
-	uprobe_offset =3D get_uprobe_offset(&get_base_addr, base_addr);
+	uprobe_offset =3D get_uprobe_offset(&method, base_addr);
=20
 	/* attach two uprobes */
 	opts.bpf_cookie =3D 0x100;
@@ -99,7 +103,7 @@ static void uprobe_subtest(struct test_bpf_cookie *ske=
l)
 		goto cleanup;
=20
 	/* trigger uprobe && uretprobe */
-	get_base_addr();
+	method();
=20
 	ASSERT_EQ(skel->bss->uprobe_res, 0x100 | 0x200, "uprobe_res");
 	ASSERT_EQ(skel->bss->uretprobe_res, 0x1000 | 0x2000, "uretprobe_res");
diff --git a/tools/testing/selftests/bpf/prog_tests/task_pt_regs.c b/tool=
s/testing/selftests/bpf/prog_tests/task_pt_regs.c
index 37c20b5ffa70..4d2f1435be90 100644
--- a/tools/testing/selftests/bpf/prog_tests/task_pt_regs.c
+++ b/tools/testing/selftests/bpf/prog_tests/task_pt_regs.c
@@ -3,6 +3,10 @@
 #include <test_progs.h>
 #include "test_task_pt_regs.skel.h"
=20
+static int method() {
+	return get_base_addr();
+}
+
 void test_task_pt_regs(void)
 {
 	struct test_task_pt_regs *skel;
@@ -14,7 +18,7 @@ void test_task_pt_regs(void)
 	base_addr =3D get_base_addr();
 	if (!ASSERT_GT(base_addr, 0, "get_base_addr"))
 		return;
-	uprobe_offset =3D get_uprobe_offset(&get_base_addr, base_addr);
+	uprobe_offset =3D get_uprobe_offset(&method, base_addr);
=20
 	skel =3D test_task_pt_regs__open_and_load();
 	if (!ASSERT_OK_PTR(skel, "skel_open"))
@@ -32,7 +36,7 @@ void test_task_pt_regs(void)
 	skel->links.handle_uprobe =3D uprobe_link;
=20
 	/* trigger & validate uprobe */
-	get_base_addr();
+	method();
=20
 	if (!ASSERT_EQ(skel->bss->uprobe_res, 1, "check_uprobe_res"))
 		goto cleanup;
--=20
2.30.2

