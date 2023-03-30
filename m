Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DD426CFB02
	for <lists+bpf@lfdr.de>; Thu, 30 Mar 2023 07:56:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229486AbjC3F4Y (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 30 Mar 2023 01:56:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229925AbjC3F4Y (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 30 Mar 2023 01:56:24 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0166F61AD
        for <bpf@vger.kernel.org>; Wed, 29 Mar 2023 22:56:22 -0700 (PDT)
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32TKZ9nv023186
        for <bpf@vger.kernel.org>; Wed, 29 Mar 2023 22:56:22 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=cdVBTmppb2Zc7nOaR2ZJaZJR7ujQn5noXozWykg21wE=;
 b=avvBc9o537+jqx2dm1Tdray/tT6igxaTacJx9suX38dGISvd7LZOoqT/vxIoOSpgrm86
 WKZW+id/DV7vSiBJx2khP6qg4h+tTsiuWQGv80TDjR1AWA3B9hbnzAWbINA27ACZ23VX
 XapbRHXLMwwyza2mj1cNJBat63fNmCd3Dio= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3pmvg5aqaq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 29 Mar 2023 22:56:22 -0700
Received: from twshared17808.08.ash9.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c085:11d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Wed, 29 Mar 2023 22:56:21 -0700
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
        id 6A1291BA2D763; Wed, 29 Mar 2023 22:56:10 -0700 (PDT)
From:   Yonghong Song <yhs@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>,
        Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next 2/7] selftests/bpf: Add tests for non-constant cond_op NE/EQ bound deduction
Date:   Wed, 29 Mar 2023 22:56:10 -0700
Message-ID: <20230330055610.89177-1-yhs@fb.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230330055600.86870-1-yhs@fb.com>
References: <20230330055600.86870-1-yhs@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: WVdNu4x7mPVWc0Cf7RHCmWzSVhIS8iVv
X-Proofpoint-ORIG-GUID: WVdNu4x7mPVWc0Cf7RHCmWzSVhIS8iVv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-30_02,2023-03-30_01,2023-02-09_01
X-Spam-Status: No, score=-0.6 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
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
 .../selftests/bpf/prog_tests/verifier.c       |  2 +
 .../verifier_bounds_deduction_non_const.c     | 93 +++++++++++++++++++
 2 files changed, 95 insertions(+)
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
index 000000000000..c07af47c489e
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/verifier_bounds_deduction_non_con=
st.c
@@ -0,0 +1,93 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
+
+SEC("socket")
+__description("check deducing bounds from non-const, jmp64, <non_const> =
=3D=3D <const>")
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
!=3D <const>")
+__success __retval(0)
+__naked void deducing_bounds_from_non_const_2(void)
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
+__description("check deducing bounds from non-const, jmp32, <non_const> =
=3D=3D <const>")
+__success __retval(0)
+__naked void deducing_bounds_from_non_const_3(void)
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
!=3D <const>")
+__success __retval(0)
+__naked void deducing_bounds_from_non_const_4(void)
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
+char _license[] SEC("license") =3D "GPL";
--=20
2.34.1

