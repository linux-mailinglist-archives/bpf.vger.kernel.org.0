Return-Path: <bpf+bounces-6132-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 26FB4766112
	for <lists+bpf@lfdr.de>; Fri, 28 Jul 2023 03:14:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F1291C215BF
	for <lists+bpf@lfdr.de>; Fri, 28 Jul 2023 01:14:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F8B517EC;
	Fri, 28 Jul 2023 01:13:31 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E15957C
	for <bpf@vger.kernel.org>; Fri, 28 Jul 2023 01:13:30 +0000 (UTC)
Received: from 69-171-232-181.mail-mxout.facebook.com (69-171-232-181.mail-mxout.facebook.com [69.171.232.181])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBFFC30E1
	for <bpf@vger.kernel.org>; Thu, 27 Jul 2023 18:13:29 -0700 (PDT)
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
	id 0619A23C74A9F; Thu, 27 Jul 2023 18:13:15 -0700 (PDT)
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
Subject: [PATCH bpf-next v5 13/17] selftests/bpf: Add unit tests for new bswap insns
Date: Thu, 27 Jul 2023 18:13:14 -0700
Message-Id: <20230728011314.3720109-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230728011143.3710005-1-yonghong.song@linux.dev>
References: <20230728011143.3710005-1-yonghong.song@linux.dev>
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

Add unit tests for bswap insns.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 .../selftests/bpf/prog_tests/verifier.c       |  2 +
 .../selftests/bpf/progs/verifier_bswap.c      | 59 +++++++++++++++++++
 2 files changed, 61 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_bswap.c

diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/te=
sting/selftests/bpf/prog_tests/verifier.c
index 037af7799cdf..885532540bc3 100644
--- a/tools/testing/selftests/bpf/prog_tests/verifier.c
+++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
@@ -11,6 +11,7 @@
 #include "verifier_bounds_deduction_non_const.skel.h"
 #include "verifier_bounds_mix_sign_unsign.skel.h"
 #include "verifier_bpf_get_stack.skel.h"
+#include "verifier_bswap.skel.h"
 #include "verifier_btf_ctx_access.skel.h"
 #include "verifier_cfg.skel.h"
 #include "verifier_cgroup_inv_retcode.skel.h"
@@ -115,6 +116,7 @@ void test_verifier_bounds_deduction(void)     { RUN(v=
erifier_bounds_deduction);
 void test_verifier_bounds_deduction_non_const(void)     { RUN(verifier_b=
ounds_deduction_non_const); }
 void test_verifier_bounds_mix_sign_unsign(void) { RUN(verifier_bounds_mi=
x_sign_unsign); }
 void test_verifier_bpf_get_stack(void)        { RUN(verifier_bpf_get_sta=
ck); }
+void test_verifier_bswap(void)                { RUN(verifier_bswap); }
 void test_verifier_btf_ctx_access(void)       { RUN(verifier_btf_ctx_acc=
ess); }
 void test_verifier_cfg(void)                  { RUN(verifier_cfg); }
 void test_verifier_cgroup_inv_retcode(void)   { RUN(verifier_cgroup_inv_=
retcode); }
diff --git a/tools/testing/selftests/bpf/progs/verifier_bswap.c b/tools/t=
esting/selftests/bpf/progs/verifier_bswap.c
new file mode 100644
index 000000000000..724bb38988b5
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/verifier_bswap.c
@@ -0,0 +1,59 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
+
+#if defined(__TARGET_ARCH_x86) && __clang_major__ >=3D 18
+
+SEC("socket")
+__description("BSWAP, 16")
+__success __success_unpriv __retval(0x23ff)
+__naked void bswap_16(void)
+{
+	asm volatile ("					\
+	r0 =3D 0xff23;					\
+	r0 =3D bswap16 r0;				\
+	exit;						\
+"	::: __clobber_all);
+}
+
+SEC("socket")
+__description("BSWAP, 32")
+__success __success_unpriv __retval(0x23ff0000)
+__naked void bswap_32(void)
+{
+	asm volatile ("					\
+	r0 =3D 0xff23;					\
+	r0 =3D bswap32 r0;				\
+	exit;						\
+"	::: __clobber_all);
+}
+
+SEC("socket")
+__description("BSWAP, 64")
+__success __success_unpriv __retval(0x34ff12ff)
+__naked void bswap_64(void)
+{
+	asm volatile ("					\
+	r0 =3D %[u64_val] ll;					\
+	r0 =3D bswap64 r0;				\
+	exit;						\
+"	:
+	: [u64_val]"i"(0xff12ff34ff56ff78ull)
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


