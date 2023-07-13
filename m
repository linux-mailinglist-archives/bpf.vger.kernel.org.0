Return-Path: <bpf+bounces-4937-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DB37C75189D
	for <lists+bpf@lfdr.de>; Thu, 13 Jul 2023 08:09:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F32381C21266
	for <lists+bpf@lfdr.de>; Thu, 13 Jul 2023 06:09:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67FBF6118;
	Thu, 13 Jul 2023 06:08:44 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 472BB6112
	for <bpf@vger.kernel.org>; Thu, 13 Jul 2023 06:08:44 +0000 (UTC)
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB492212E
	for <bpf@vger.kernel.org>; Wed, 12 Jul 2023 23:08:40 -0700 (PDT)
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36CMvdvu027189
	for <bpf@vger.kernel.org>; Wed, 12 Jul 2023 23:08:40 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=txDEwgegHeiAN04McoM/wyxhAYcvhGp9QbbyR7Ij3mw=;
 b=hqaFu284TVzmqITL+2qc1lrBPAxiIcosq9PzQL1T1+nvnfgtVrB28glcFkEZtjBmC6NB
 b6ceH8ZvcAXob46Pwn30Qz4JWSWN8RpZxHCJe8JkItmtGCuf9OTtWCR/YTGRxwIZC7Jy
 /ARgSz5wYKObg6OoeD7tXVfjR2NRVMPRv5c= 
Received: from mail.thefacebook.com ([163.114.132.120])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3rsfwkk2eh-4
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Wed, 12 Jul 2023 23:08:39 -0700
Received: from twshared34392.14.frc2.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:21d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 12 Jul 2023 23:08:38 -0700
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
	id CF7D122EFA49E; Wed, 12 Jul 2023 23:08:36 -0700 (PDT)
From: Yonghong Song <yhs@fb.com>
To: <bpf@vger.kernel.org>
CC: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Fangrui Song <maskray@google.com>, <kernel-team@fb.com>
Subject: [PATCH bpf-next v2 13/15] selftests/bpf: Add unit tests for new gotol insn
Date: Wed, 12 Jul 2023 23:08:36 -0700
Message-ID: <20230713060836.396990-1-yhs@fb.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230713060718.388258-1-yhs@fb.com>
References: <20230713060718.388258-1-yhs@fb.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: rrvcbaVSgxKUpML9PpD9viQrgXRHbHDE
X-Proofpoint-ORIG-GUID: rrvcbaVSgxKUpML9PpD9viQrgXRHbHDE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-13_03,2023-07-11_01,2023-05-22_02
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
	SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Add unit tests for gotol insn.

Signed-off-by: Yonghong Song <yhs@fb.com>
---
 .../selftests/bpf/prog_tests/verifier.c       |  2 ++
 .../selftests/bpf/progs/verifier_gotol.c      | 30 +++++++++++++++++++
 2 files changed, 32 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_gotol.c

diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/te=
sting/selftests/bpf/prog_tests/verifier.c
index a591d7b673f1..e3e68c97b40c 100644
--- a/tools/testing/selftests/bpf/prog_tests/verifier.c
+++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
@@ -25,6 +25,7 @@
 #include "verifier_direct_stack_access_wraparound.skel.h"
 #include "verifier_div0.skel.h"
 #include "verifier_div_overflow.skel.h"
+#include "verifier_gotol.skel.h"
 #include "verifier_helper_access_var_len.skel.h"
 #include "verifier_helper_packet_access.skel.h"
 #include "verifier_helper_restricted.skel.h"
@@ -131,6 +132,7 @@ void test_verifier_direct_packet_access(void) { RUN(v=
erifier_direct_packet_acces
 void test_verifier_direct_stack_access_wraparound(void) { RUN(verifier_d=
irect_stack_access_wraparound); }
 void test_verifier_div0(void)                 { RUN(verifier_div0); }
 void test_verifier_div_overflow(void)         { RUN(verifier_div_overflo=
w); }
+void test_verifier_gotol(void)                { RUN(verifier_gotol); }
 void test_verifier_helper_access_var_len(void) { RUN(verifier_helper_acc=
ess_var_len); }
 void test_verifier_helper_packet_access(void) { RUN(verifier_helper_pack=
et_access); }
 void test_verifier_helper_restricted(void)    { RUN(verifier_helper_rest=
ricted); }
diff --git a/tools/testing/selftests/bpf/progs/verifier_gotol.c b/tools/t=
esting/selftests/bpf/progs/verifier_gotol.c
new file mode 100644
index 000000000000..78870ea4d468
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/verifier_gotol.c
@@ -0,0 +1,30 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
+
+SEC("socket")
+__description("gotol, small_imm")
+__success __success_unpriv __retval(1)
+__naked void gotol_small_imm(void)
+{
+	asm volatile ("					\
+	call %[bpf_ktime_get_ns];			\
+	if r0 =3D=3D 0 goto l0_%=3D;				\
+	gotol l1_%=3D;					\
+l2_%=3D:							\
+	gotol l3_%=3D;					\
+l1_%=3D:							\
+	r0 =3D 1;						\
+	gotol l2_%=3D;					\
+l0_%=3D:							\
+	r0 =3D 2;						\
+l3_%=3D:							\
+	exit;						\
+"	:
+	: __imm(bpf_ktime_get_ns)
+	: __clobber_all);
+}
+
+char _license[] SEC("license") =3D "GPL";
--=20
2.34.1


