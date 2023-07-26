Return-Path: <bpf+bounces-6021-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 85E9376422A
	for <lists+bpf@lfdr.de>; Thu, 27 Jul 2023 00:33:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3FC4128209D
	for <lists+bpf@lfdr.de>; Wed, 26 Jul 2023 22:33:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D125CA93C;
	Wed, 26 Jul 2023 22:33:37 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA9B4A930
	for <bpf@vger.kernel.org>; Wed, 26 Jul 2023 22:33:37 +0000 (UTC)
Received: from 66-220-155-178.mail-mxout.facebook.com (66-220-155-178.mail-mxout.facebook.com [66.220.155.178])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E2D1273B
	for <bpf@vger.kernel.org>; Wed, 26 Jul 2023 15:33:16 -0700 (PDT)
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
	id 3897323B7A060; Wed, 26 Jul 2023 15:08:27 -0700 (PDT)
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
Subject: [PATCH bpf-next v4 11/17] selftests/bpf: Add unit tests for new sign-extension load insns
Date: Wed, 26 Jul 2023 15:08:27 -0700
Message-Id: <20230726220827.1100979-1-yonghong.song@linux.dev>
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
X-Spam-Status: No, score=-0.3 required=5.0 tests=BAYES_00,RDNS_DYNAMIC,
	SPF_HELO_PASS,SPF_SOFTFAIL,TVD_RCVD_IP,T_SCC_BODY_TEXT_LINE
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Add unit tests for new ldsx insns. The test includes sign-extension
with a single value or with a value range.

If cpuv4 is not supported due to
  (1) older compiler, e.g., less than clang version 18, or
  (2) test runner test_progs and test_progs-no_alu32 which tests
      cpu v2 and v3, or
  (3) non-x86_64 arch not supporting new insns in jit yet,
a dummy program is added with below output:
  #318/1   verifier_ldsx/cpuv4 is not supported by compiler or jit, use a=
 dummy test:OK
  #318     verifier_ldsx:OK
to indicate the test passed with a dummy test instead of actually
testing cpuv4. I am using a dummy prog to avoid changing the
verifier testing infrastructure. Once clang 18 is widely available
and other architectures support cpuv4, at least for CI run,
the dummy program can be removed.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 .../selftests/bpf/prog_tests/verifier.c       |   2 +
 .../selftests/bpf/progs/verifier_ldsx.c       | 131 ++++++++++++++++++
 2 files changed, 133 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_ldsx.c

diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/te=
sting/selftests/bpf/prog_tests/verifier.c
index c375e59ff28d..6eec6a9463c8 100644
--- a/tools/testing/selftests/bpf/prog_tests/verifier.c
+++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
@@ -31,6 +31,7 @@
 #include "verifier_int_ptr.skel.h"
 #include "verifier_jeq_infer_not_null.skel.h"
 #include "verifier_ld_ind.skel.h"
+#include "verifier_ldsx.skel.h"
 #include "verifier_leak_ptr.skel.h"
 #include "verifier_loops1.skel.h"
 #include "verifier_lwt.skel.h"
@@ -133,6 +134,7 @@ void test_verifier_helper_value_access(void)  { RUN(v=
erifier_helper_value_access
 void test_verifier_int_ptr(void)              { RUN(verifier_int_ptr); }
 void test_verifier_jeq_infer_not_null(void)   { RUN(verifier_jeq_infer_n=
ot_null); }
 void test_verifier_ld_ind(void)               { RUN(verifier_ld_ind); }
+void test_verifier_ldsx(void)                  { RUN(verifier_ldsx); }
 void test_verifier_leak_ptr(void)             { RUN(verifier_leak_ptr); =
}
 void test_verifier_loops1(void)               { RUN(verifier_loops1); }
 void test_verifier_lwt(void)                  { RUN(verifier_lwt); }
diff --git a/tools/testing/selftests/bpf/progs/verifier_ldsx.c b/tools/te=
sting/selftests/bpf/progs/verifier_ldsx.c
new file mode 100644
index 000000000000..3c3d1bddd67f
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/verifier_ldsx.c
@@ -0,0 +1,131 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
+
+#if defined(__TARGET_ARCH_x86) && __clang_major__ >=3D 18
+
+SEC("socket")
+__description("LDSX, S8")
+__success __success_unpriv __retval(-2)
+__naked void ldsx_s8(void)
+{
+	asm volatile ("					\
+	r1 =3D 0x3fe;					\
+	*(u64 *)(r10 - 8) =3D r1;				\
+	r0 =3D *(s8 *)(r10 - 8);				\
+	exit;						\
+"	::: __clobber_all);
+}
+
+SEC("socket")
+__description("LDSX, S16")
+__success __success_unpriv __retval(-2)
+__naked void ldsx_s16(void)
+{
+	asm volatile ("					\
+	r1 =3D 0x3fffe;					\
+	*(u64 *)(r10 - 8) =3D r1;				\
+	r0 =3D *(s16 *)(r10 - 8);				\
+	exit;						\
+"	::: __clobber_all);
+}
+
+SEC("socket")
+__description("LDSX, S32")
+__success __success_unpriv __retval(-1)
+__naked void ldsx_s32(void)
+{
+	asm volatile ("					\
+	r1 =3D 0xfffffffe;				\
+	*(u64 *)(r10 - 8) =3D r1;				\
+	r0 =3D *(s32 *)(r10 - 8);				\
+	r0 >>=3D 1;					\
+	exit;						\
+"	::: __clobber_all);
+}
+
+SEC("socket")
+__description("LDSX, S8 range checking, privileged")
+__log_level(2) __success __retval(1)
+__msg("R1_w=3Dscalar(smin=3D-128,smax=3D127)")
+__naked void ldsx_s8_range_priv(void)
+{
+	asm volatile ("					\
+	call %[bpf_get_prandom_u32];			\
+	*(u64 *)(r10 - 8) =3D r0;				\
+	r1 =3D *(s8 *)(r10 - 8);				\
+	/* r1 with s8 range */				\
+	if r1 s> 0x7f goto l0_%=3D;			\
+	if r1 s< -0x80 goto l0_%=3D;			\
+	r0 =3D 1;						\
+l1_%=3D:							\
+	exit;						\
+l0_%=3D:							\
+	r0 =3D 2;						\
+	goto l1_%=3D;					\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("LDSX, S16 range checking")
+__success __success_unpriv __retval(1)
+__naked void ldsx_s16_range(void)
+{
+	asm volatile ("					\
+	call %[bpf_get_prandom_u32];			\
+	*(u64 *)(r10 - 8) =3D r0;				\
+	r1 =3D *(s16 *)(r10 - 8);				\
+	/* r1 with s16 range */				\
+	if r1 s> 0x7fff goto l0_%=3D;			\
+	if r1 s< -0x8000 goto l0_%=3D;			\
+	r0 =3D 1;						\
+l1_%=3D:							\
+	exit;						\
+l0_%=3D:							\
+	r0 =3D 2;						\
+	goto l1_%=3D;					\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("LDSX, S32 range checking")
+__success __success_unpriv __retval(1)
+__naked void ldsx_s32_range(void)
+{
+	asm volatile ("					\
+	call %[bpf_get_prandom_u32];			\
+	*(u64 *)(r10 - 8) =3D r0;				\
+	r1 =3D *(s32 *)(r10 - 8);				\
+	/* r1 with s16 range */				\
+	if r1 s> 0x7fffFFFF goto l0_%=3D;			\
+	if r1 s< -0x80000000 goto l0_%=3D;		\
+	r0 =3D 1;						\
+l1_%=3D:							\
+	exit;						\
+l0_%=3D:							\
+	r0 =3D 2;						\
+	goto l1_%=3D;					\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
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


