Return-Path: <bpf+bounces-6009-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 85BE17641E4
	for <lists+bpf@lfdr.de>; Thu, 27 Jul 2023 00:09:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 407C5282027
	for <lists+bpf@lfdr.de>; Wed, 26 Jul 2023 22:09:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59BC6198B4;
	Wed, 26 Jul 2023 22:09:03 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ADA61BF04
	for <bpf@vger.kernel.org>; Wed, 26 Jul 2023 22:09:02 +0000 (UTC)
Received: from 69-171-232-180.mail-mxout.facebook.com (69-171-232-180.mail-mxout.facebook.com [69.171.232.180])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8CD1270D
	for <bpf@vger.kernel.org>; Wed, 26 Jul 2023 15:09:01 -0700 (PDT)
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
	id 648E923B7A36F; Wed, 26 Jul 2023 15:08:48 -0700 (PDT)
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
Subject: [PATCH bpf-next v4 15/17] selftests/bpf: Add unit tests for new gotol insn
Date: Wed, 26 Jul 2023 15:08:48 -0700
Message-Id: <20230726220848.1103236-1-yonghong.song@linux.dev>
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

Add unit tests for gotol insn.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 .../selftests/bpf/prog_tests/verifier.c       |  2 +
 .../selftests/bpf/progs/verifier_gotol.c      | 44 +++++++++++++++++++
 2 files changed, 46 insertions(+)
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
index 000000000000..ce48f7757db2
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/verifier_gotol.c
@@ -0,0 +1,44 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
+
+#if defined(__TARGET_ARCH_x86) && __clang_major__ >=3D 18
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


