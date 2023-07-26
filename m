Return-Path: <bpf+bounces-6005-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBD767641E0
	for <lists+bpf@lfdr.de>; Thu, 27 Jul 2023 00:08:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6ACD128184F
	for <lists+bpf@lfdr.de>; Wed, 26 Jul 2023 22:08:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F9DA198A1;
	Wed, 26 Jul 2023 22:08:41 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0A421BF04
	for <bpf@vger.kernel.org>; Wed, 26 Jul 2023 22:08:40 +0000 (UTC)
X-Greylist: delayed 60 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 26 Jul 2023 15:08:39 PDT
Received: from 66-220-155-179.mail-mxout.facebook.com (66-220-155-179.mail-mxout.facebook.com [66.220.155.179])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51A00270B
	for <bpf@vger.kernel.org>; Wed, 26 Jul 2023 15:08:39 -0700 (PDT)
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
	id 6331323B7A0A0; Wed, 26 Jul 2023 15:08:32 -0700 (PDT)
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
Subject: [PATCH bpf-next v4 12/17] selftests/bpf: Add unit tests for new sign-extension mov insns
Date: Wed, 26 Jul 2023 15:08:32 -0700
Message-Id: <20230726220832.1101417-1-yonghong.song@linux.dev>
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

Add unit tests for movsx insns.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 .../selftests/bpf/prog_tests/verifier.c       |   2 +
 .../selftests/bpf/progs/verifier_movsx.c      | 213 ++++++++++++++++++
 2 files changed, 215 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_movsx.c

diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/te=
sting/selftests/bpf/prog_tests/verifier.c
index 6eec6a9463c8..037af7799cdf 100644
--- a/tools/testing/selftests/bpf/prog_tests/verifier.c
+++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
@@ -41,6 +41,7 @@
 #include "verifier_map_ret_val.skel.h"
 #include "verifier_masking.skel.h"
 #include "verifier_meta_access.skel.h"
+#include "verifier_movsx.skel.h"
 #include "verifier_netfilter_ctx.skel.h"
 #include "verifier_netfilter_retcode.skel.h"
 #include "verifier_prevent_map_lookup.skel.h"
@@ -144,6 +145,7 @@ void test_verifier_map_ptr_mixing(void)       { RUN(v=
erifier_map_ptr_mixing); }
 void test_verifier_map_ret_val(void)          { RUN(verifier_map_ret_val=
); }
 void test_verifier_masking(void)              { RUN(verifier_masking); }
 void test_verifier_meta_access(void)          { RUN(verifier_meta_access=
); }
+void test_verifier_movsx(void)                 { RUN(verifier_movsx); }
 void test_verifier_netfilter_ctx(void)        { RUN(verifier_netfilter_c=
tx); }
 void test_verifier_netfilter_retcode(void)    { RUN(verifier_netfilter_r=
etcode); }
 void test_verifier_prevent_map_lookup(void)   { RUN(verifier_prevent_map=
_lookup); }
diff --git a/tools/testing/selftests/bpf/progs/verifier_movsx.c b/tools/t=
esting/selftests/bpf/progs/verifier_movsx.c
new file mode 100644
index 000000000000..9568089932d7
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/verifier_movsx.c
@@ -0,0 +1,213 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
+
+#if defined(__TARGET_ARCH_x86) && __clang_major__ >=3D 18
+
+SEC("socket")
+__description("MOV32SX, S8")
+__success __success_unpriv __retval(0x23)
+__naked void mov32sx_s8(void)
+{
+	asm volatile ("					\
+	w0 =3D 0xff23;					\
+	w0 =3D (s8)w0;					\
+	exit;						\
+"	::: __clobber_all);
+}
+
+SEC("socket")
+__description("MOV32SX, S16")
+__success __success_unpriv __retval(0xFFFFff23)
+__naked void mov32sx_s16(void)
+{
+	asm volatile ("					\
+	w0 =3D 0xff23;					\
+	w0 =3D (s16)w0;					\
+	exit;						\
+"	::: __clobber_all);
+}
+
+SEC("socket")
+__description("MOV64SX, S8")
+__success __success_unpriv __retval(-2)
+__naked void mov64sx_s8(void)
+{
+	asm volatile ("					\
+	r0 =3D 0x1fe;					\
+	r0 =3D (s8)r0;					\
+	exit;						\
+"	::: __clobber_all);
+}
+
+SEC("socket")
+__description("MOV64SX, S16")
+__success __success_unpriv __retval(0xf23)
+__naked void mov64sx_s16(void)
+{
+	asm volatile ("					\
+	r0 =3D 0xf0f23;					\
+	r0 =3D (s16)r0;					\
+	exit;						\
+"	::: __clobber_all);
+}
+
+SEC("socket")
+__description("MOV64SX, S32")
+__success __success_unpriv __retval(-1)
+__naked void mov64sx_s32(void)
+{
+	asm volatile ("					\
+	r0 =3D 0xfffffffe;				\
+	r0 =3D (s32)r0;					\
+	r0 >>=3D 1;					\
+	exit;						\
+"	::: __clobber_all);
+}
+
+SEC("socket")
+__description("MOV32SX, S8, range_check")
+__success __success_unpriv __retval(1)
+__naked void mov32sx_s8_range(void)
+{
+	asm volatile ("					\
+	call %[bpf_get_prandom_u32];			\
+	w1 =3D (s8)w0;					\
+	/* w1 with s8 range */				\
+	if w1 s> 0x7f goto l0_%=3D;			\
+	if w1 s< -0x80 goto l0_%=3D;			\
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
+__description("MOV32SX, S16, range_check")
+__success __success_unpriv __retval(1)
+__naked void mov32sx_s16_range(void)
+{
+	asm volatile ("					\
+	call %[bpf_get_prandom_u32];			\
+	w1 =3D (s16)w0;					\
+	/* w1 with s16 range */				\
+	if w1 s> 0x7fff goto l0_%=3D;			\
+	if w1 s< -0x80ff goto l0_%=3D;			\
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
+__description("MOV32SX, S16, range_check 2")
+__success __success_unpriv __retval(1)
+__naked void mov32sx_s16_range_2(void)
+{
+	asm volatile ("					\
+	r1 =3D 65535;					\
+	w2 =3D (s16)w1;					\
+	r2 >>=3D 1;					\
+	if r2 !=3D 0x7fffFFFF goto l0_%=3D;			\
+	r0 =3D 1;						\
+l1_%=3D:							\
+	exit;						\
+l0_%=3D:							\
+	r0 =3D 0;						\
+	goto l1_%=3D;					\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("MOV64SX, S8, range_check")
+__success __success_unpriv __retval(1)
+__naked void mov64sx_s8_range(void)
+{
+	asm volatile ("					\
+	call %[bpf_get_prandom_u32];			\
+	r1 =3D (s8)r0;					\
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
+__description("MOV64SX, S16, range_check")
+__success __success_unpriv __retval(1)
+__naked void mov64sx_s16_range(void)
+{
+	asm volatile ("					\
+	call %[bpf_get_prandom_u32];			\
+	r1 =3D (s16)r0;					\
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
+__description("MOV64SX, S32, range_check")
+__success __success_unpriv __retval(1)
+__naked void mov64sx_s32_range(void)
+{
+	asm volatile ("					\
+	call %[bpf_get_prandom_u32];			\
+	r1 =3D (s32)r0;					\
+	/* r1 with s32 range */				\
+	if r1 s> 0x7fffffff goto l0_%=3D;			\
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


