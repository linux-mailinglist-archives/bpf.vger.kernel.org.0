Return-Path: <bpf+bounces-5399-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D5CCA75A30D
	for <lists+bpf@lfdr.de>; Thu, 20 Jul 2023 02:03:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C490281BBE
	for <lists+bpf@lfdr.de>; Thu, 20 Jul 2023 00:03:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE3514698;
	Thu, 20 Jul 2023 00:02:34 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93E944426
	for <bpf@vger.kernel.org>; Thu, 20 Jul 2023 00:02:34 +0000 (UTC)
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49BF61BF2
	for <bpf@vger.kernel.org>; Wed, 19 Jul 2023 17:02:32 -0700 (PDT)
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36JMM8Yp002332
	for <bpf@vger.kernel.org>; Wed, 19 Jul 2023 17:02:32 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=xy4lF57aVI4FZNQFgX6upxnO5plyNT8/591KoFCQ4pU=;
 b=HSMNyt7T6j9cNzEqRw9FQ++mRoxARPZZGtiSRWSKSL2G8Pnb2Dknpq8KGTGYEzaZOFVa
 Dvp8UdTZa2Y6+ZWtpbTKLmWtjqcnic2b4o/RWe1YL6otqC6lKxp4vG1tSO1sFISXobrt
 gJCa5gaUVifSOBNhi+Hivr3Ghh2Il9LVOZg= 
Received: from maileast.thefacebook.com ([163.114.130.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3rxjpcku4y-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Wed, 19 Jul 2023 17:02:31 -0700
Received: from twshared34392.14.frc2.facebook.com (2620:10d:c0a8:1b::2d) by
 mail.thefacebook.com (2620:10d:c0a8:83::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 19 Jul 2023 17:02:28 -0700
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
	id DA3A72354EA60; Wed, 19 Jul 2023 17:02:17 -0700 (PDT)
From: Yonghong Song <yhs@fb.com>
To: <bpf@vger.kernel.org>
CC: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        <bpf@ietf.org>, Daniel Borkmann <daniel@iogearbox.net>,
        Fangrui Song
	<maskray@google.com>, <kernel-team@fb.com>
Subject: [PATCH bpf-next v3 14/17] selftests/bpf: Add unit tests for new sdiv/smod insns
Date: Wed, 19 Jul 2023 17:02:17 -0700
Message-ID: <20230720000217.111976-1-yhs@fb.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230720000103.99949-1-yhs@fb.com>
References: <20230720000103.99949-1-yhs@fb.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: PlTpVghhbwXWKdol0M8ZSmE78H9tTZRa
X-Proofpoint-ORIG-GUID: PlTpVghhbwXWKdol0M8ZSmE78H9tTZRa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-19_16,2023-07-19_01,2023-05-22_02
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Add unit tests for sdiv/smod insns.

Signed-off-by: Yonghong Song <yhs@fb.com>
---
 .../selftests/bpf/prog_tests/verifier.c       |   2 +
 .../selftests/bpf/progs/verifier_sdiv.c       | 767 ++++++++++++++++++
 2 files changed, 769 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_sdiv.c

diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/te=
sting/selftests/bpf/prog_tests/verifier.c
index 885532540bc3..a591d7b673f1 100644
--- a/tools/testing/selftests/bpf/prog_tests/verifier.c
+++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
@@ -54,6 +54,7 @@
 #include "verifier_ringbuf.skel.h"
 #include "verifier_runtime_jit.skel.h"
 #include "verifier_scalar_ids.skel.h"
+#include "verifier_sdiv.skel.h"
 #include "verifier_search_pruning.skel.h"
 #include "verifier_sock.skel.h"
 #include "verifier_spill_fill.skel.h"
@@ -159,6 +160,7 @@ void test_verifier_regalloc(void)             { RUN(v=
erifier_regalloc); }
 void test_verifier_ringbuf(void)              { RUN(verifier_ringbuf); }
 void test_verifier_runtime_jit(void)          { RUN(verifier_runtime_jit=
); }
 void test_verifier_scalar_ids(void)           { RUN(verifier_scalar_ids)=
; }
+void test_verifier_sdiv(void)                 { RUN(verifier_sdiv); }
 void test_verifier_search_pruning(void)       { RUN(verifier_search_prun=
ing); }
 void test_verifier_sock(void)                 { RUN(verifier_sock); }
 void test_verifier_spill_fill(void)           { RUN(verifier_spill_fill)=
; }
diff --git a/tools/testing/selftests/bpf/progs/verifier_sdiv.c b/tools/te=
sting/selftests/bpf/progs/verifier_sdiv.c
new file mode 100644
index 000000000000..381b0d73fd58
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/verifier_sdiv.c
@@ -0,0 +1,767 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
+
+SEC("socket")
+__description("SDIV32, non-zero imm divisor, check 1")
+__success __success_unpriv __retval(-20)
+__naked void sdiv32_non_zero_imm_1(void)
+{
+	asm volatile ("					\
+	w0 =3D -41;					\
+	w0 s/=3D 2;					\
+	exit;						\
+"	::: __clobber_all);
+}
+
+SEC("socket")
+__description("SDIV32, non-zero imm divisor, check 2")
+__success __success_unpriv __retval(-20)
+__naked void sdiv32_non_zero_imm_2(void)
+{
+	asm volatile ("					\
+	w0 =3D 41;					\
+	w0 s/=3D -2;					\
+	exit;						\
+"	::: __clobber_all);
+}
+
+SEC("socket")
+__description("SDIV32, non-zero imm divisor, check 3")
+__success __success_unpriv __retval(20)
+__naked void sdiv32_non_zero_imm_3(void)
+{
+	asm volatile ("					\
+	w0 =3D -41;					\
+	w0 s/=3D -2;					\
+	exit;						\
+"	::: __clobber_all);
+}
+
+SEC("socket")
+__description("SDIV32, non-zero imm divisor, check 4")
+__success __success_unpriv __retval(-21)
+__naked void sdiv32_non_zero_imm_4(void)
+{
+	asm volatile ("					\
+	w0 =3D -42;					\
+	w0 s/=3D 2;					\
+	exit;						\
+"	::: __clobber_all);
+}
+
+SEC("socket")
+__description("SDIV32, non-zero imm divisor, check 5")
+__success __success_unpriv __retval(-21)
+__naked void sdiv32_non_zero_imm_5(void)
+{
+	asm volatile ("					\
+	w0 =3D 42;					\
+	w0 s/=3D -2;					\
+	exit;						\
+"	::: __clobber_all);
+}
+
+SEC("socket")
+__description("SDIV32, non-zero imm divisor, check 6")
+__success __success_unpriv __retval(21)
+__naked void sdiv32_non_zero_imm_6(void)
+{
+	asm volatile ("					\
+	w0 =3D -42;					\
+	w0 s/=3D -2;					\
+	exit;						\
+"	::: __clobber_all);
+}
+
+SEC("socket")
+__description("SDIV32, non-zero imm divisor, check 7")
+__success __success_unpriv __retval(21)
+__naked void sdiv32_non_zero_imm_7(void)
+{
+	asm volatile ("					\
+	w0 =3D 42;					\
+	w0 s/=3D 2;					\
+	exit;						\
+"	::: __clobber_all);
+}
+
+SEC("socket")
+__description("SDIV32, non-zero imm divisor, check 8")
+__success __success_unpriv __retval(20)
+__naked void sdiv32_non_zero_imm_8(void)
+{
+	asm volatile ("					\
+	w0 =3D 41;					\
+	w0 s/=3D 2;					\
+	exit;						\
+"	::: __clobber_all);
+}
+
+SEC("socket")
+__description("SDIV32, non-zero reg divisor, check 1")
+__success __success_unpriv __retval(-20)
+__naked void sdiv32_non_zero_reg_1(void)
+{
+	asm volatile ("					\
+	w0 =3D -41;					\
+	w1 =3D 2;						\
+	w0 s/=3D w1;					\
+	exit;						\
+"	::: __clobber_all);
+}
+
+SEC("socket")
+__description("SDIV32, non-zero reg divisor, check 2")
+__success __success_unpriv __retval(-20)
+__naked void sdiv32_non_zero_reg_2(void)
+{
+	asm volatile ("					\
+	w0 =3D 41;					\
+	w1 =3D -2;					\
+	w0 s/=3D w1;					\
+	exit;						\
+"	::: __clobber_all);
+}
+
+SEC("socket")
+__description("SDIV32, non-zero reg divisor, check 3")
+__success __success_unpriv __retval(20)
+__naked void sdiv32_non_zero_reg_3(void)
+{
+	asm volatile ("					\
+	w0 =3D -41;					\
+	w1 =3D -2;					\
+	w0 s/=3D w1;					\
+	exit;						\
+"	::: __clobber_all);
+}
+
+SEC("socket")
+__description("SDIV32, non-zero reg divisor, check 4")
+__success __success_unpriv __retval(-21)
+__naked void sdiv32_non_zero_reg_4(void)
+{
+	asm volatile ("					\
+	w0 =3D -42;					\
+	w1 =3D 2;						\
+	w0 s/=3D w1;					\
+	exit;						\
+"	::: __clobber_all);
+}
+
+SEC("socket")
+__description("SDIV32, non-zero reg divisor, check 5")
+__success __success_unpriv __retval(-21)
+__naked void sdiv32_non_zero_reg_5(void)
+{
+	asm volatile ("					\
+	w0 =3D 42;					\
+	w1 =3D -2;					\
+	w0 s/=3D w1;					\
+	exit;						\
+"	::: __clobber_all);
+}
+
+SEC("socket")
+__description("SDIV32, non-zero reg divisor, check 6")
+__success __success_unpriv __retval(21)
+__naked void sdiv32_non_zero_reg_6(void)
+{
+	asm volatile ("					\
+	w0 =3D -42;					\
+	w1 =3D -2;					\
+	w0 s/=3D w1;					\
+	exit;						\
+"	::: __clobber_all);
+}
+
+SEC("socket")
+__description("SDIV32, non-zero reg divisor, check 7")
+__success __success_unpriv __retval(21)
+__naked void sdiv32_non_zero_reg_7(void)
+{
+	asm volatile ("					\
+	w0 =3D 42;					\
+	w1 =3D 2;						\
+	w0 s/=3D w1;					\
+	exit;						\
+"	::: __clobber_all);
+}
+
+SEC("socket")
+__description("SDIV32, non-zero reg divisor, check 8")
+__success __success_unpriv __retval(20)
+__naked void sdiv32_non_zero_reg_8(void)
+{
+	asm volatile ("					\
+	w0 =3D 41;					\
+	w1 =3D 2;						\
+	w0 s/=3D w1;					\
+	exit;						\
+"	::: __clobber_all);
+}
+
+SEC("socket")
+__description("SDIV64, non-zero imm divisor, check 1")
+__success __success_unpriv __retval(-20)
+__naked void sdiv64_non_zero_imm_1(void)
+{
+	asm volatile ("					\
+	r0 =3D -41;					\
+	r0 s/=3D 2;					\
+	exit;						\
+"	::: __clobber_all);
+}
+
+SEC("socket")
+__description("SDIV64, non-zero imm divisor, check 2")
+__success __success_unpriv __retval(-20)
+__naked void sdiv64_non_zero_imm_2(void)
+{
+	asm volatile ("					\
+	r0 =3D 41;					\
+	r0 s/=3D -2;					\
+	exit;						\
+"	::: __clobber_all);
+}
+
+SEC("socket")
+__description("SDIV64, non-zero imm divisor, check 3")
+__success __success_unpriv __retval(20)
+__naked void sdiv64_non_zero_imm_3(void)
+{
+	asm volatile ("					\
+	r0 =3D -41;					\
+	r0 s/=3D -2;					\
+	exit;						\
+"	::: __clobber_all);
+}
+
+SEC("socket")
+__description("SDIV64, non-zero imm divisor, check 4")
+__success __success_unpriv __retval(-21)
+__naked void sdiv64_non_zero_imm_4(void)
+{
+	asm volatile ("					\
+	r0 =3D -42;					\
+	r0 s/=3D 2;					\
+	exit;						\
+"	::: __clobber_all);
+}
+
+SEC("socket")
+__description("SDIV64, non-zero imm divisor, check 5")
+__success __success_unpriv __retval(-21)
+__naked void sdiv64_non_zero_imm_5(void)
+{
+	asm volatile ("					\
+	r0 =3D 42;					\
+	r0 s/=3D -2;					\
+	exit;						\
+"	::: __clobber_all);
+}
+
+SEC("socket")
+__description("SDIV64, non-zero imm divisor, check 6")
+__success __success_unpriv __retval(21)
+__naked void sdiv64_non_zero_imm_6(void)
+{
+	asm volatile ("					\
+	r0 =3D -42;					\
+	r0 s/=3D -2;					\
+	exit;						\
+"	::: __clobber_all);
+}
+
+SEC("socket")
+__description("SDIV64, non-zero reg divisor, check 1")
+__success __success_unpriv __retval(-20)
+__naked void sdiv64_non_zero_reg_1(void)
+{
+	asm volatile ("					\
+	r0 =3D -41;					\
+	r1 =3D 2;						\
+	r0 s/=3D r1;					\
+	exit;						\
+"	::: __clobber_all);
+}
+
+SEC("socket")
+__description("SDIV64, non-zero reg divisor, check 2")
+__success __success_unpriv __retval(-20)
+__naked void sdiv64_non_zero_reg_2(void)
+{
+	asm volatile ("					\
+	r0 =3D 41;					\
+	r1 =3D -2;					\
+	r0 s/=3D r1;					\
+	exit;						\
+"	::: __clobber_all);
+}
+
+SEC("socket")
+__description("SDIV64, non-zero reg divisor, check 3")
+__success __success_unpriv __retval(20)
+__naked void sdiv64_non_zero_reg_3(void)
+{
+	asm volatile ("					\
+	r0 =3D -41;					\
+	r1 =3D -2;					\
+	r0 s/=3D r1;					\
+	exit;						\
+"	::: __clobber_all);
+}
+
+SEC("socket")
+__description("SDIV64, non-zero reg divisor, check 4")
+__success __success_unpriv __retval(-21)
+__naked void sdiv64_non_zero_reg_4(void)
+{
+	asm volatile ("					\
+	r0 =3D -42;					\
+	r1 =3D 2;						\
+	r0 s/=3D r1;					\
+	exit;						\
+"	::: __clobber_all);
+}
+
+SEC("socket")
+__description("SDIV64, non-zero reg divisor, check 5")
+__success __success_unpriv __retval(-21)
+__naked void sdiv64_non_zero_reg_5(void)
+{
+	asm volatile ("					\
+	r0 =3D 42;					\
+	r1 =3D -2;					\
+	r0 s/=3D r1;					\
+	exit;						\
+"	::: __clobber_all);
+}
+
+SEC("socket")
+__description("SDIV64, non-zero reg divisor, check 6")
+__success __success_unpriv __retval(21)
+__naked void sdiv64_non_zero_reg_6(void)
+{
+	asm volatile ("					\
+	r0 =3D -42;					\
+	r1 =3D -2;					\
+	r0 s/=3D r1;					\
+	exit;						\
+"	::: __clobber_all);
+}
+
+SEC("socket")
+__description("SMOD32, non-zero imm divisor, check 1")
+__success __success_unpriv __retval(-1)
+__naked void smod32_non_zero_imm_1(void)
+{
+	asm volatile ("					\
+	w0 =3D -41;					\
+	w0 s%%=3D 2;					\
+	exit;						\
+"	::: __clobber_all);
+}
+
+SEC("socket")
+__description("SMOD32, non-zero imm divisor, check 2")
+__success __success_unpriv __retval(1)
+__naked void smod32_non_zero_imm_2(void)
+{
+	asm volatile ("					\
+	w0 =3D 41;					\
+	w0 s%%=3D -2;					\
+	exit;						\
+"	::: __clobber_all);
+}
+
+SEC("socket")
+__description("SMOD32, non-zero imm divisor, check 3")
+__success __success_unpriv __retval(-1)
+__naked void smod32_non_zero_imm_3(void)
+{
+	asm volatile ("					\
+	w0 =3D -41;					\
+	w0 s%%=3D -2;					\
+	exit;						\
+"	::: __clobber_all);
+}
+
+SEC("socket")
+__description("SMOD32, non-zero imm divisor, check 4")
+__success __success_unpriv __retval(0)
+__naked void smod32_non_zero_imm_4(void)
+{
+	asm volatile ("					\
+	w0 =3D -42;					\
+	w0 s%%=3D 2;					\
+	exit;						\
+"	::: __clobber_all);
+}
+
+SEC("socket")
+__description("SMOD32, non-zero imm divisor, check 5")
+__success __success_unpriv __retval(0)
+__naked void smod32_non_zero_imm_5(void)
+{
+	asm volatile ("					\
+	w0 =3D 42;					\
+	w0 s%%=3D -2;					\
+	exit;						\
+"	::: __clobber_all);
+}
+
+SEC("socket")
+__description("SMOD32, non-zero imm divisor, check 6")
+__success __success_unpriv __retval(0)
+__naked void smod32_non_zero_imm_6(void)
+{
+	asm volatile ("					\
+	w0 =3D -42;					\
+	w0 s%%=3D -2;					\
+	exit;						\
+"	::: __clobber_all);
+}
+
+SEC("socket")
+__description("SMOD32, non-zero reg divisor, check 1")
+__success __success_unpriv __retval(-1)
+__naked void smod32_non_zero_reg_1(void)
+{
+	asm volatile ("					\
+	w0 =3D -41;					\
+	w1 =3D 2;						\
+	w0 s%%=3D w1;					\
+	exit;						\
+"	::: __clobber_all);
+}
+
+SEC("socket")
+__description("SMOD32, non-zero reg divisor, check 2")
+__success __success_unpriv __retval(1)
+__naked void smod32_non_zero_reg_2(void)
+{
+	asm volatile ("					\
+	w0 =3D 41;					\
+	w1 =3D -2;					\
+	w0 s%%=3D w1;					\
+	exit;						\
+"	::: __clobber_all);
+}
+
+SEC("socket")
+__description("SMOD32, non-zero reg divisor, check 3")
+__success __success_unpriv __retval(-1)
+__naked void smod32_non_zero_reg_3(void)
+{
+	asm volatile ("					\
+	w0 =3D -41;					\
+	w1 =3D -2;					\
+	w0 s%%=3D w1;					\
+	exit;						\
+"	::: __clobber_all);
+}
+
+SEC("socket")
+__description("SMOD32, non-zero reg divisor, check 4")
+__success __success_unpriv __retval(0)
+__naked void smod32_non_zero_reg_4(void)
+{
+	asm volatile ("					\
+	w0 =3D -42;					\
+	w1 =3D 2;						\
+	w0 s%%=3D w1;					\
+	exit;						\
+"	::: __clobber_all);
+}
+
+SEC("socket")
+__description("SMOD32, non-zero reg divisor, check 5")
+__success __success_unpriv __retval(0)
+__naked void smod32_non_zero_reg_5(void)
+{
+	asm volatile ("					\
+	w0 =3D 42;					\
+	w1 =3D -2;					\
+	w0 s%%=3D w1;					\
+	exit;						\
+"	::: __clobber_all);
+}
+
+SEC("socket")
+__description("SMOD32, non-zero reg divisor, check 6")
+__success __success_unpriv __retval(0)
+__naked void smod32_non_zero_reg_6(void)
+{
+	asm volatile ("					\
+	w0 =3D -42;					\
+	w1 =3D -2;					\
+	w0 s%%=3D w1;					\
+	exit;						\
+"	::: __clobber_all);
+}
+
+SEC("socket")
+__description("SMOD64, non-zero imm divisor, check 1")
+__success __success_unpriv __retval(-1)
+__naked void smod64_non_zero_imm_1(void)
+{
+	asm volatile ("					\
+	r0 =3D -41;					\
+	r0 s%%=3D 2;					\
+	exit;						\
+"	::: __clobber_all);
+}
+
+SEC("socket")
+__description("SMOD64, non-zero imm divisor, check 2")
+__success __success_unpriv __retval(1)
+__naked void smod64_non_zero_imm_2(void)
+{
+	asm volatile ("					\
+	r0 =3D 41;					\
+	r0 s%%=3D -2;					\
+	exit;						\
+"	::: __clobber_all);
+}
+
+SEC("socket")
+__description("SMOD64, non-zero imm divisor, check 3")
+__success __success_unpriv __retval(-1)
+__naked void smod64_non_zero_imm_3(void)
+{
+	asm volatile ("					\
+	r0 =3D -41;					\
+	r0 s%%=3D -2;					\
+	exit;						\
+"	::: __clobber_all);
+}
+
+SEC("socket")
+__description("SMOD64, non-zero imm divisor, check 4")
+__success __success_unpriv __retval(0)
+__naked void smod64_non_zero_imm_4(void)
+{
+	asm volatile ("					\
+	r0 =3D -42;					\
+	r0 s%%=3D 2;					\
+	exit;						\
+"	::: __clobber_all);
+}
+
+SEC("socket")
+__description("SMOD64, non-zero imm divisor, check 5")
+__success __success_unpriv __retval(-0)
+__naked void smod64_non_zero_imm_5(void)
+{
+	asm volatile ("					\
+	r0 =3D 42;					\
+	r0 s%%=3D -2;					\
+	exit;						\
+"	::: __clobber_all);
+}
+
+SEC("socket")
+__description("SMOD64, non-zero imm divisor, check 6")
+__success __success_unpriv __retval(0)
+__naked void smod64_non_zero_imm_6(void)
+{
+	asm volatile ("					\
+	r0 =3D -42;					\
+	r0 s%%=3D -2;					\
+	exit;						\
+"	::: __clobber_all);
+}
+
+SEC("socket")
+__description("SMOD64, non-zero imm divisor, check 7")
+__success __success_unpriv __retval(0)
+__naked void smod64_non_zero_imm_7(void)
+{
+	asm volatile ("					\
+	r0 =3D 42;					\
+	r0 s%%=3D 2;					\
+	exit;						\
+"	::: __clobber_all);
+}
+
+SEC("socket")
+__description("SMOD64, non-zero imm divisor, check 8")
+__success __success_unpriv __retval(1)
+__naked void smod64_non_zero_imm_8(void)
+{
+	asm volatile ("					\
+	r0 =3D 41;					\
+	r0 s%%=3D 2;					\
+	exit;						\
+"	::: __clobber_all);
+}
+
+SEC("socket")
+__description("SMOD64, non-zero reg divisor, check 1")
+__success __success_unpriv __retval(-1)
+__naked void smod64_non_zero_reg_1(void)
+{
+	asm volatile ("					\
+	r0 =3D -41;					\
+	r1 =3D 2;						\
+	r0 s%%=3D r1;					\
+	exit;						\
+"	::: __clobber_all);
+}
+
+SEC("socket")
+__description("SMOD64, non-zero reg divisor, check 2")
+__success __success_unpriv __retval(1)
+__naked void smod64_non_zero_reg_2(void)
+{
+	asm volatile ("					\
+	r0 =3D 41;					\
+	r1 =3D -2;					\
+	r0 s%%=3D r1;					\
+	exit;						\
+"	::: __clobber_all);
+}
+
+SEC("socket")
+__description("SMOD64, non-zero reg divisor, check 3")
+__success __success_unpriv __retval(-1)
+__naked void smod64_non_zero_reg_3(void)
+{
+	asm volatile ("					\
+	r0 =3D -41;					\
+	r1 =3D -2;					\
+	r0 s%%=3D r1;					\
+	exit;						\
+"	::: __clobber_all);
+}
+
+SEC("socket")
+__description("SMOD64, non-zero reg divisor, check 4")
+__success __success_unpriv __retval(0)
+__naked void smod64_non_zero_reg_4(void)
+{
+	asm volatile ("					\
+	r0 =3D -42;					\
+	r1 =3D 2;						\
+	r0 s%%=3D r1;					\
+	exit;						\
+"	::: __clobber_all);
+}
+
+SEC("socket")
+__description("SMOD64, non-zero reg divisor, check 5")
+__success __success_unpriv __retval(0)
+__naked void smod64_non_zero_reg_5(void)
+{
+	asm volatile ("					\
+	r0 =3D 42;					\
+	r1 =3D -2;					\
+	r0 s%%=3D r1;					\
+	exit;						\
+"	::: __clobber_all);
+}
+
+SEC("socket")
+__description("SMOD64, non-zero reg divisor, check 6")
+__success __success_unpriv __retval(0)
+__naked void smod64_non_zero_reg_6(void)
+{
+	asm volatile ("					\
+	r0 =3D -42;					\
+	r1 =3D -2;					\
+	r0 s%%=3D r1;					\
+	exit;						\
+"	::: __clobber_all);
+}
+
+SEC("socket")
+__description("SMOD64, non-zero reg divisor, check 7")
+__success __success_unpriv __retval(0)
+__naked void smod64_non_zero_reg_7(void)
+{
+	asm volatile ("					\
+	r0 =3D 42;					\
+	r1 =3D 2;						\
+	r0 s%%=3D r1;					\
+	exit;						\
+"	::: __clobber_all);
+}
+
+SEC("socket")
+__description("SMOD64, non-zero reg divisor, check 8")
+__success __success_unpriv __retval(1)
+__naked void smod64_non_zero_reg_8(void)
+{
+	asm volatile ("					\
+	r0 =3D 41;					\
+	r1 =3D 2;						\
+	r0 s%%=3D r1;					\
+	exit;						\
+"	::: __clobber_all);
+}
+
+SEC("socket")
+__description("SDIV32, zero divisor")
+__success __success_unpriv __retval(0)
+__naked void sdiv32_zero_divisor(void)
+{
+	asm volatile ("					\
+	w0 =3D 42;					\
+	w1 =3D 0;						\
+	w2 =3D -1;					\
+	w2 s/=3D w1;					\
+	w0 =3D w2;					\
+	exit;						\
+"	::: __clobber_all);
+}
+
+SEC("socket")
+__description("SDIV64, zero divisor")
+__success __success_unpriv __retval(0)
+__naked void sdiv64_zero_divisor(void)
+{
+	asm volatile ("					\
+	r0 =3D 42;					\
+	r1 =3D 0;						\
+	r2 =3D -1;					\
+	r2 s/=3D r1;					\
+	r0 =3D r2;					\
+	exit;						\
+"	::: __clobber_all);
+}
+
+SEC("socket")
+__description("SMOD32, zero divisor")
+__success __success_unpriv __retval(-1)
+__naked void smod32_zero_divisor(void)
+{
+	asm volatile ("					\
+	w0 =3D 42;					\
+	w1 =3D 0;						\
+	w2 =3D -1;					\
+	w2 s%%=3D w1;					\
+	w0 =3D w2;					\
+	exit;						\
+"	::: __clobber_all);
+}
+
+SEC("socket")
+__description("SMOD64, zero divisor")
+__success __success_unpriv __retval(-1)
+__naked void smod64_zero_divisor(void)
+{
+	asm volatile ("					\
+	r0 =3D 42;					\
+	r1 =3D 0;						\
+	r2 =3D -1;					\
+	r2 s%%=3D r1;					\
+	r0 =3D r2;					\
+	exit;						\
+"	::: __clobber_all);
+}
+
+char _license[] SEC("license") =3D "GPL";
--=20
2.34.1


