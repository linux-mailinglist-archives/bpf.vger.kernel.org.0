Return-Path: <bpf+bounces-4933-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D234751897
	for <lists+bpf@lfdr.de>; Thu, 13 Jul 2023 08:09:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08CA5281AF5
	for <lists+bpf@lfdr.de>; Thu, 13 Jul 2023 06:09:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 832935690;
	Thu, 13 Jul 2023 06:08:26 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 559B85681
	for <bpf@vger.kernel.org>; Thu, 13 Jul 2023 06:08:26 +0000 (UTC)
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DBC51BF6
	for <bpf@vger.kernel.org>; Wed, 12 Jul 2023 23:08:24 -0700 (PDT)
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36CMvWrG011838
	for <bpf@vger.kernel.org>; Wed, 12 Jul 2023 23:08:24 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=vsDYhRf2Mj4yiIBoF3rkUyB5AzCf78obvnWjrJVwGB4=;
 b=I23rOw4Hzixhev+3gacpFMlKAqsfS8VdPKg3yUcUVED0bDVN5zmV0TMcEM5/0Sh+2lcY
 930vJqnMBgn0oOT/EGwjKkkxofCWzfaSKJ4GuMq7sFvtBzCy/K7WP/aZJA+a7yToSRH9
 ClBlv3zSYY24X00PCYFK68+LNw090Km7fqM= 
Received: from maileast.thefacebook.com ([163.114.130.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3rsg3h30aw-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Wed, 12 Jul 2023 23:08:24 -0700
Received: from ash-exhub204.TheFacebook.com (2620:10d:c0a8:83::4) by
 ash-exhub104.TheFacebook.com (2620:10d:c0a8:82::d) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 12 Jul 2023 23:08:20 -0700
Received: from twshared29562.14.frc2.facebook.com (2620:10d:c0a8:1c::1b) by
 mail.thefacebook.com (2620:10d:c0a8:83::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 12 Jul 2023 23:08:20 -0700
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
	id 6CBA122EFA3AE; Wed, 12 Jul 2023 23:08:05 -0700 (PDT)
From: Yonghong Song <yhs@fb.com>
To: <bpf@vger.kernel.org>
CC: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Fangrui Song <maskray@google.com>, <kernel-team@fb.com>
Subject: [PATCH bpf-next v2 09/15] selftests/bpf: Add unit tests for new sign-extension load insns
Date: Wed, 12 Jul 2023 23:08:05 -0700
Message-ID: <20230713060805.393133-1-yhs@fb.com>
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
X-Proofpoint-GUID: D5K0kX_AzMxb0BSCXcERnavXOYf_POkq
X-Proofpoint-ORIG-GUID: D5K0kX_AzMxb0BSCXcERnavXOYf_POkq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-13_02,2023-07-11_01,2023-05-22_02
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
	SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Add unit tests for new ldsx insns. The test includes sign-extension
with a single value or with a value range.

Signed-off-by: Yonghong Song <yhs@fb.com>
---
 .../selftests/bpf/prog_tests/verifier.c       |   2 +
 .../selftests/bpf/progs/verifier_ldsx.c       | 115 ++++++++++++++++++
 2 files changed, 117 insertions(+)
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
index 000000000000..cd90913583b9
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/verifier_ldsx.c
@@ -0,0 +1,115 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
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
+__success __success_unpriv __retval(-2)
+__naked void ldsx_s32(void)
+{
+	asm volatile ("					\
+	r1 =3D 0xfffffffe;				\
+	*(u64 *)(r10 - 8) =3D r1;				\
+	r0 =3D *(s32 *)(r10 - 8);				\
+	exit;						\
+"	::: __clobber_all);
+}
+
+SEC("socket")
+__description("LDSX, S8 range checking")
+__success __success_unpriv __retval(1)
+__naked void ldsx_s8_range(void)
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
+char _license[] SEC("license") =3D "GPL";
--=20
2.34.1


