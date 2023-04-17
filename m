Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA12C6E54A8
	for <lists+bpf@lfdr.de>; Tue, 18 Apr 2023 00:21:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229662AbjDQWVp (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 17 Apr 2023 18:21:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjDQWVo (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 17 Apr 2023 18:21:44 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AD515275
        for <bpf@vger.kernel.org>; Mon, 17 Apr 2023 15:21:43 -0700 (PDT)
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 33HLILE6002684
        for <bpf@vger.kernel.org>; Mon, 17 Apr 2023 15:21:42 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=GPYalpHtfOVNhATfw9wv0mL6ZAvcDw1vR90CC6gKpZ8=;
 b=dRo4c8Ts8FkmNjeXfc4RytFfhYN3h3j8R72uVIjqFkuTyPx2Qa7Jz1uBrrCAIuuNnHFJ
 LiuNrwU82ru6OsvaH/iPL5epZdHmbc3/yQuTQ+hSPJsteNHbkhhhyMl7hT8leE+WM2tM
 Ubbn/QbZXp91vgM5rSf8AwM4K5omkkeuQEs= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0001303.ppops.net (PPS) with ESMTPS id 3q12g04n9j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 17 Apr 2023 15:21:42 -0700
Received: from twshared52565.14.frc2.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::e) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 17 Apr 2023 15:21:41 -0700
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
        id A75241D6B11B6; Mon, 17 Apr 2023 15:21:39 -0700 (PDT)
From:   Yonghong Song <yhs@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v2 2/2] selftests/bpf: Add a selftest for checking subreg equality
Date:   Mon, 17 Apr 2023 15:21:39 -0700
Message-ID: <20230417222139.360607-1-yhs@fb.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230417222134.359714-1-yhs@fb.com>
References: <20230417222134.359714-1-yhs@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: PpGSPOS-xB3ww_wg9jmy7lJiTr_sCXCV
X-Proofpoint-ORIG-GUID: PpGSPOS-xB3ww_wg9jmy7lJiTr_sCXCV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-17_14,2023-04-17_01,2023-02-09_01
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add a selftest to ensure subreg equality if source register
upper 32bit is 0. Without previous patch, the test will
fail verification.

Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Yonghong Song <yhs@fb.com>
---
 .../selftests/bpf/prog_tests/verifier.c       |  2 +
 .../selftests/bpf/progs/verifier_reg_equal.c  | 58 +++++++++++++++++++
 2 files changed, 60 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_reg_equal.=
c

v1 -> v2:
  - Add some comments for the test
  - Add a negative test

diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/te=
sting/selftests/bpf/prog_tests/verifier.c
index 73dff693d411..25bc8958dbfe 100644
--- a/tools/testing/selftests/bpf/prog_tests/verifier.c
+++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
@@ -31,6 +31,7 @@
 #include "verifier_meta_access.skel.h"
 #include "verifier_raw_stack.skel.h"
 #include "verifier_raw_tp_writable.skel.h"
+#include "verifier_reg_equal.skel.h"
 #include "verifier_ringbuf.skel.h"
 #include "verifier_spill_fill.skel.h"
 #include "verifier_stack_ptr.skel.h"
@@ -95,6 +96,7 @@ void test_verifier_masking(void)              { RUN(ver=
ifier_masking); }
 void test_verifier_meta_access(void)          { RUN(verifier_meta_access=
); }
 void test_verifier_raw_stack(void)            { RUN(verifier_raw_stack);=
 }
 void test_verifier_raw_tp_writable(void)      { RUN(verifier_raw_tp_writ=
able); }
+void test_verifier_reg_equal(void)            { RUN(verifier_reg_equal);=
 }
 void test_verifier_ringbuf(void)              { RUN(verifier_ringbuf); }
 void test_verifier_spill_fill(void)           { RUN(verifier_spill_fill)=
; }
 void test_verifier_stack_ptr(void)            { RUN(verifier_stack_ptr);=
 }
diff --git a/tools/testing/selftests/bpf/progs/verifier_reg_equal.c b/too=
ls/testing/selftests/bpf/progs/verifier_reg_equal.c
new file mode 100644
index 000000000000..dc1d8c30fb0e
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/verifier_reg_equal.c
@@ -0,0 +1,58 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
+
+SEC("socket")
+__description("check w reg equal if r reg upper32 bits 0")
+__success
+__naked void subreg_equality_1(void)
+{
+	asm volatile ("					\
+	call %[bpf_ktime_get_ns];			\
+	*(u64 *)(r10 - 8) =3D r0;				\
+	r2 =3D *(u32 *)(r10 - 8);				\
+	/* At this point upper 4-bytes of r2 are 0,	\
+	 * thus insn w3 =3D w2 should propagate reg id,	\
+	 * and w2 < 9 comparison would also propagate	\
+	 * the range for r3.				\
+	 */						\
+	w3 =3D w2;					\
+	if w2 < 9 goto l0_%=3D;				\
+	exit;						\
+l0_%=3D:	if r3 < 9 goto l1_%=3D;				\
+	/* r1 read is illegal at this point */		\
+	r0 -=3D r1;					\
+l1_%=3D:	exit;						\
+"	:
+	: __imm(bpf_ktime_get_ns)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("check w reg not equal if r reg upper32 bits not 0")
+__failure __msg("R1 !read_ok")
+__naked void subreg_equality_2(void)
+{
+	asm volatile ("					\
+	call %[bpf_ktime_get_ns];			\
+	r2 =3D r0;					\
+	/* Upper 4-bytes of r2 may not be 0, thus insn	\
+	 * w3 =3D w2 should not propagate reg id,	and	\
+	 * w2 < 9 comparison should not propagate	\
+	 * the range for r3 either.			\
+	 */						\
+	w3 =3D w2;					\
+	if w2 < 9 goto l0_%=3D;				\
+	exit;						\
+l0_%=3D:	if r3 < 9 goto l1_%=3D;				\
+	/* r1 read is illegal at this point */		\
+	r0 -=3D r1;					\
+l1_%=3D:	exit;						\
+"	:
+	: __imm(bpf_ktime_get_ns)
+	: __clobber_all);
+}
+
+char _license[] SEC("license") =3D "GPL";
--=20
2.34.1

