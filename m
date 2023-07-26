Return-Path: <bpf+bounces-6007-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F6D57641E2
	for <lists+bpf@lfdr.de>; Thu, 27 Jul 2023 00:09:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42B25281FAA
	for <lists+bpf@lfdr.de>; Wed, 26 Jul 2023 22:09:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03CDF198A2;
	Wed, 26 Jul 2023 22:08:58 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AED4D1BF04
	for <bpf@vger.kernel.org>; Wed, 26 Jul 2023 22:08:57 +0000 (UTC)
Received: from 66-220-155-179.mail-mxout.facebook.com (66-220-155-179.mail-mxout.facebook.com [66.220.155.179])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87C7E270B
	for <bpf@vger.kernel.org>; Wed, 26 Jul 2023 15:08:55 -0700 (PDT)
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
	id 2C99B23B7A12B; Wed, 26 Jul 2023 15:08:42 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	bpf@vger.kernel.org,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>
Cc: David Faust <david.faust@oracle.com>,
	Fangrui Song <maskray@google.com>,
	"Jose E . Marchesi" <jose.marchesi@oracle.com>,
	kernel-team@fb.com
Subject: [PATCH bpf-next v4 14/17] selftests/bpf: Add unit tests for new sdiv/smod insns
Date: Wed, 26 Jul 2023 15:08:42 -0700
Message-Id: <20230726220842.1102558-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230726220726.1089817-1-yonghong.song@linux.dev>
References: <20230726220726.1089817-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.3 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,RDNS_DYNAMIC,SPF_HELO_PASS,SPF_SOFTFAIL,
	TVD_RCVD_IP,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Add unit tests for sdiv/smod insns.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 .../selftests/bpf/prog_tests/verifier.c       |   2 +
 .../selftests/bpf/progs/verifier_sdiv.c       | 781 ++++++++++++++++++
 2 files changed, 783 insertions(+)
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
index 000000000000..f61a9a1058c8
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/verifier_sdiv.c
@@ -0,0 +1,781 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
+
+#if defined(__TARGET_ARCH_x86) && __clang_major__ >=3D 18
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
+#else
+
+SEC("socket")
+__description("cpuv4 is not supported by compiler or jit, use a dummy te=
st")
+__success
+int dummy_test(void)
+{
+	return 0;
+}
+
+#endif
+
+char _license[] SEC("license") =3D "GPL";
--=20
2.34.1


