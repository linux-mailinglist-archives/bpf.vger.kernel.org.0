Return-Path: <bpf+bounces-4935-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F2E80751899
	for <lists+bpf@lfdr.de>; Thu, 13 Jul 2023 08:09:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B5B71C21284
	for <lists+bpf@lfdr.de>; Thu, 13 Jul 2023 06:09:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 698BE568D;
	Thu, 13 Jul 2023 06:08:43 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1249E567B
	for <bpf@vger.kernel.org>; Thu, 13 Jul 2023 06:08:43 +0000 (UTC)
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 371E81FF1
	for <bpf@vger.kernel.org>; Wed, 12 Jul 2023 23:08:39 -0700 (PDT)
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36CMvdvr027189
	for <bpf@vger.kernel.org>; Wed, 12 Jul 2023 23:08:38 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=pQO9E9xjUMDLK/O5IygYnCEnC+OrpuI7KTPeD4smup8=;
 b=oAewK5EF6qgFva2d2z7rOhx4b1XIKUfNZKgv2Lj/7f+DuimNcQD7hM6/oGlGkZrihWFS
 JpHxKuLAzm4D0RYNd0ERDgfinC71sV/XANvTySv4PTAzBOSFNgmj8TIAY81GqeuzBg2A
 8EFzhqMiUsW2ZxNMC9JIUzkcyFlVNhdxPOk= 
Received: from mail.thefacebook.com ([163.114.132.120])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3rsfwkk2eh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Wed, 12 Jul 2023 23:08:38 -0700
Received: from twshared52232.38.frc1.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:21d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 12 Jul 2023 23:08:36 -0700
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
	id 6326222EFA47D; Wed, 12 Jul 2023 23:08:31 -0700 (PDT)
From: Yonghong Song <yhs@fb.com>
To: <bpf@vger.kernel.org>
CC: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Fangrui Song <maskray@google.com>, <kernel-team@fb.com>
Subject: [PATCH bpf-next v2 12/15] selftests/bpf: Add unit tests for new sdiv/smod insns
Date: Wed, 12 Jul 2023 23:08:31 -0700
Message-ID: <20230713060831.396527-1-yhs@fb.com>
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
X-Proofpoint-GUID: v5H1_YmYIFugWuVB3gjat33S4PPuAlry
X-Proofpoint-ORIG-GUID: v5H1_YmYIFugWuVB3gjat33S4PPuAlry
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

Add unit tests for sdiv/smod insns.

Signed-off-by: Yonghong Song <yhs@fb.com>
---
 .../selftests/bpf/prog_tests/verifier.c       |   2 +
 .../selftests/bpf/progs/verifier_sdiv.c       | 763 ++++++++++++++++++
 2 files changed, 765 insertions(+)
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
index 000000000000..d92098d670ef
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/verifier_sdiv.c
@@ -0,0 +1,763 @@
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
+__success __success_unpriv __retval(42)
+__naked void sdiv32_zero_divisor(void)
+{
+	asm volatile ("					\
+	w0 =3D 42;					\
+	w1 =3D 0;						\
+	w2 =3D -1;					\
+	w2 s/=3D w1;					\
+	exit;						\
+"	::: __clobber_all);
+}
+
+SEC("socket")
+__description("SDIV64, zero divisor")
+__success __success_unpriv __retval(42)
+__naked void sdiv64_zero_divisor(void)
+{
+	asm volatile ("					\
+	r0 =3D 42;					\
+	r1 =3D 0;						\
+	r2 =3D -1;					\
+	r2 s/=3D r1;					\
+	exit;						\
+"	::: __clobber_all);
+}
+
+SEC("socket")
+__description("SMOD32, zero divisor")
+__success __success_unpriv __retval(42)
+__naked void smod32_zero_divisor(void)
+{
+	asm volatile ("					\
+	w0 =3D 42;					\
+	w1 =3D 0;						\
+	w2 =3D -1;					\
+	w2 s%%=3D w1;					\
+	exit;						\
+"	::: __clobber_all);
+}
+
+SEC("socket")
+__description("SMOD64, zero divisor")
+__success __success_unpriv __retval(42)
+__naked void smod64_zero_divisor(void)
+{
+	asm volatile ("					\
+	r0 =3D 42;					\
+	r1 =3D 0;						\
+	r2 =3D -1;					\
+	r2 s%%=3D r1;					\
+	exit;						\
+"	::: __clobber_all);
+}
+
+char _license[] SEC("license") =3D "GPL";
--=20
2.34.1


