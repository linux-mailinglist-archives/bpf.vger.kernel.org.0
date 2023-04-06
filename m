Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F8A16D9DD6
	for <lists+bpf@lfdr.de>; Thu,  6 Apr 2023 18:48:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229930AbjDFQsO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 6 Apr 2023 12:48:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239712AbjDFQsM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 6 Apr 2023 12:48:12 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 850D5AD3F
        for <bpf@vger.kernel.org>; Thu,  6 Apr 2023 09:47:53 -0700 (PDT)
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 336FbhpP025157
        for <bpf@vger.kernel.org>; Thu, 6 Apr 2023 09:47:53 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=rdah0lRE5lBWFCe/hs+VSMJGwGcSJAUGY1ans0uX/I0=;
 b=dCdtAVktlqWAAy3o+q7yJBCJYji3ohevPu7YdzqVVYd8SFsTmSkK6tL0tEEe3yv61vk0
 0BZ7kONDd82hYEWLiPu9zos8kjLYkUlZHFGP89eur1T0HR/hGZ9xkqTwyy2rAZiVpXb3
 M6Uo9PV78IyWkHxoeVpNH41IGSuM2j4Ttn4= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3psk7avu3k-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 06 Apr 2023 09:47:53 -0700
Received: from twshared7147.05.ash9.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Thu, 6 Apr 2023 09:47:51 -0700
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
        id AF4481C5BEE3D; Thu,  6 Apr 2023 09:45:00 -0700 (PDT)
From:   Yonghong Song <yhs@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>,
        Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next v2 2/4] selftests/bpf: Add tests for non-constant cond_op NE/EQ bound deduction
Date:   Thu, 6 Apr 2023 09:45:00 -0700
Message-ID: <20230406164500.1045715-1-yhs@fb.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230406164450.1044952-1-yhs@fb.com>
References: <20230406164450.1044952-1-yhs@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: AqnzijtCaTtZe_SmWM0BUJcAtvUHWLJR
X-Proofpoint-ORIG-GUID: AqnzijtCaTtZe_SmWM0BUJcAtvUHWLJR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-06_10,2023-04-06_03,2023-02-09_01
X-Spam-Status: No, score=-0.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add various tests for code pattern '<non-const> NE/EQ <const>' implemente=
d
in the previous verifier patch. Without the verifier patch, these new
tests will fail.

Signed-off-by: Yonghong Song <yhs@fb.com>
---
 .../selftests/bpf/prog_tests/verifier.c       |   2 +
 .../verifier_bounds_deduction_non_const.c     | 179 ++++++++++++++++++
 2 files changed, 181 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_bounds_ded=
uction_non_const.c

diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/te=
sting/selftests/bpf/prog_tests/verifier.c
index efc8cf2e18d0..73dff693d411 100644
--- a/tools/testing/selftests/bpf/prog_tests/verifier.c
+++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
@@ -7,6 +7,7 @@
 #include "verifier_array_access.skel.h"
 #include "verifier_basic_stack.skel.h"
 #include "verifier_bounds_deduction.skel.h"
+#include "verifier_bounds_deduction_non_const.skel.h"
 #include "verifier_bounds_mix_sign_unsign.skel.h"
 #include "verifier_cfg.skel.h"
 #include "verifier_cgroup_inv_retcode.skel.h"
@@ -70,6 +71,7 @@ void test_verifier_and(void)                  { RUN(ver=
ifier_and); }
 void test_verifier_array_access(void)         { RUN(verifier_array_acces=
s); }
 void test_verifier_basic_stack(void)          { RUN(verifier_basic_stack=
); }
 void test_verifier_bounds_deduction(void)     { RUN(verifier_bounds_dedu=
ction); }
+void test_verifier_bounds_deduction_non_const(void)     { RUN(verifier_b=
ounds_deduction_non_const); }
 void test_verifier_bounds_mix_sign_unsign(void) { RUN(verifier_bounds_mi=
x_sign_unsign); }
 void test_verifier_cfg(void)                  { RUN(verifier_cfg); }
 void test_verifier_cgroup_inv_retcode(void)   { RUN(verifier_cgroup_inv_=
retcode); }
diff --git a/tools/testing/selftests/bpf/progs/verifier_bounds_deduction_=
non_const.c b/tools/testing/selftests/bpf/progs/verifier_bounds_deduction=
_non_const.c
new file mode 100644
index 000000000000..fe570d866139
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/verifier_bounds_deduction_non_con=
st.c
@@ -0,0 +1,179 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
+
+SEC("socket")
+__description("check deducing bounds from non-const, jmp64, <non_const> =
=3D=3D <const>, 1")
+__success __retval(0)
+__naked void deducing_bounds_from_non_const_1(void)
+{
+	asm volatile ("					\
+	call %[bpf_ktime_get_ns];			\
+	if r0 < 3 goto l0_%=3D;				\
+	r2 =3D 2;						\
+	if r0 =3D=3D r2 goto l1_%=3D;				\
+l0_%=3D:							\
+	r0 =3D 0;						\
+	exit;						\
+l1_%=3D:							\
+	r0 -=3D r1;					\
+	exit;						\
+"	:
+	: __imm(bpf_ktime_get_ns)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("check deducing bounds from non-const, jmp64, <non_const> =
=3D=3D <const>, 2")
+__success __retval(0)
+__naked void deducing_bounds_from_non_const_2(void)
+{
+	asm volatile ("					\
+	call %[bpf_ktime_get_ns];			\
+	if r0 > 3 goto l0_%=3D;				\
+	r2 =3D 4;						\
+	if r0 =3D=3D r2 goto l1_%=3D;				\
+l0_%=3D:							\
+	r0 =3D 0;						\
+	exit;						\
+l1_%=3D:							\
+	r0 -=3D r1;					\
+	exit;						\
+"	:
+	: __imm(bpf_ktime_get_ns)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("check deducing bounds from non-const, jmp64, <non_const> =
!=3D <const>, 1")
+__success __retval(0)
+__naked void deducing_bounds_from_non_const_3(void)
+{
+	asm volatile ("					\
+	call %[bpf_ktime_get_ns];			\
+	if r0 < 3 goto l0_%=3D;				\
+	r2 =3D 2;						\
+	if r0 !=3D r2 goto l0_%=3D;				\
+	goto l1_%=3D;					\
+l0_%=3D:							\
+	r0 =3D 0;						\
+	exit;						\
+l1_%=3D:							\
+	r0 -=3D r1;					\
+	exit;						\
+"	:
+	: __imm(bpf_ktime_get_ns)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("check deducing bounds from non-const, jmp64, <non_const> =
!=3D <const>, 2")
+__success __retval(0)
+__naked void deducing_bounds_from_non_const_4(void)
+{
+	asm volatile ("					\
+	call %[bpf_ktime_get_ns];			\
+	if r0 > 3 goto l0_%=3D;				\
+	r2 =3D 4;						\
+	if r0 !=3D r2 goto l0_%=3D;				\
+	goto l1_%=3D;					\
+l0_%=3D:							\
+	r0 =3D 0;						\
+	exit;						\
+l1_%=3D:							\
+	r0 -=3D r1;					\
+	exit;						\
+"	:
+	: __imm(bpf_ktime_get_ns)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("check deducing bounds from non-const, jmp32, <non_const> =
=3D=3D <const>, 1")
+__success __retval(0)
+__naked void deducing_bounds_from_non_const_5(void)
+{
+	asm volatile ("					\
+	call %[bpf_ktime_get_ns];			\
+	if w0 < 4 goto l0_%=3D;				\
+	w2 =3D 3;						\
+	if w0 =3D=3D w2 goto l1_%=3D;				\
+l0_%=3D:							\
+	r0 =3D 0;						\
+	exit;						\
+l1_%=3D:							\
+	r0 -=3D r1;					\
+	exit;						\
+"	:
+	: __imm(bpf_ktime_get_ns)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("check deducing bounds from non-const, jmp32, <non_const> =
=3D=3D <const>, 2")
+__success __retval(0)
+__naked void deducing_bounds_from_non_const_6(void)
+{
+	asm volatile ("					\
+	call %[bpf_ktime_get_ns];			\
+	if w0 > 4 goto l0_%=3D;				\
+	w2 =3D 5;						\
+	if w0 =3D=3D w2 goto l1_%=3D;				\
+l0_%=3D:							\
+	r0 =3D 0;						\
+	exit;						\
+l1_%=3D:							\
+	r0 -=3D r1;					\
+	exit;						\
+"	:
+	: __imm(bpf_ktime_get_ns)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("check deducing bounds from non-const, jmp32, <non_const> =
!=3D <const>, 1")
+__success __retval(0)
+__naked void deducing_bounds_from_non_const_7(void)
+{
+	asm volatile ("					\
+	call %[bpf_ktime_get_ns];			\
+	if w0 < 3 goto l0_%=3D;				\
+	w2 =3D 2;						\
+	if w0 !=3D w2 goto l0_%=3D;				\
+	goto l1_%=3D;					\
+l0_%=3D:							\
+	r0 =3D 0;						\
+	exit;						\
+l1_%=3D:							\
+	r0 -=3D r1;					\
+	exit;						\
+"	:
+	: __imm(bpf_ktime_get_ns)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("check deducing bounds from non-const, jmp32, <non_const> =
!=3D <const>, 2")
+__success __retval(0)
+__naked void deducing_bounds_from_non_const_8(void)
+{
+	asm volatile ("					\
+	call %[bpf_ktime_get_ns];			\
+	if w0 > 3 goto l0_%=3D;				\
+	w2 =3D 4;						\
+	if w0 !=3D w2 goto l0_%=3D;				\
+	goto l1_%=3D;					\
+l0_%=3D:							\
+	r0 =3D 0;						\
+	exit;						\
+l1_%=3D:							\
+	r0 -=3D r1;					\
+	exit;						\
+"	:
+	: __imm(bpf_ktime_get_ns)
+	: __clobber_all);
+}
+
+char _license[] SEC("license") =3D "GPL";
--=20
2.34.1

