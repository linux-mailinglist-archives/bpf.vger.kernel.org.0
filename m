Return-Path: <bpf+bounces-5401-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D676575A312
	for <lists+bpf@lfdr.de>; Thu, 20 Jul 2023 02:04:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12DCE1C2111B
	for <lists+bpf@lfdr.de>; Thu, 20 Jul 2023 00:04:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9070F642;
	Thu, 20 Jul 2023 00:02:55 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56398380
	for <bpf@vger.kernel.org>; Thu, 20 Jul 2023 00:02:55 +0000 (UTC)
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9182F1FDC
	for <bpf@vger.kernel.org>; Wed, 19 Jul 2023 17:02:53 -0700 (PDT)
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36JMM6JU002267
	for <bpf@vger.kernel.org>; Wed, 19 Jul 2023 17:02:53 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=gBWHgHv9nBYn2KEzPDrNky6hwmQgPcZjXQqq79msBUA=;
 b=EgR708yT5AhocHi3sihwTCOUm2+PyFqZRUxt5cm3uId2Kv7koCqWpINIAt7J2VbLR/hj
 TdeCreM9vscsKcP10weN9d5bO2l9bEdqF2NNJAQQz0CsC46j1W8BicTE4IUftedFu5vq
 eUB4Klkt9RUVRaIrpccu8PyaVTIV2cFqWj4= 
Received: from mail.thefacebook.com ([163.114.132.120])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3rxjpcku7f-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Wed, 19 Jul 2023 17:02:53 -0700
Received: from twshared10975.09.ash9.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:21d::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 19 Jul 2023 17:02:21 -0700
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
	id 955542354EA1B; Wed, 19 Jul 2023 17:02:07 -0700 (PDT)
From: Yonghong Song <yhs@fb.com>
To: <bpf@vger.kernel.org>
CC: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        <bpf@ietf.org>, Daniel Borkmann <daniel@iogearbox.net>,
        Fangrui Song
	<maskray@google.com>, <kernel-team@fb.com>
Subject: [PATCH bpf-next v3 12/17] selftests/bpf: Add unit tests for new sign-extension mov insns
Date: Wed, 19 Jul 2023 17:02:07 -0700
Message-ID: <20230720000207.110612-1-yhs@fb.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230720000103.99949-1-yhs@fb.com>
References: <20230720000103.99949-1-yhs@fb.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: yvIZw2ILF_zd6I6nm85O6GGnD_6Gm2ku
X-Proofpoint-ORIG-GUID: yvIZw2ILF_zd6I6nm85O6GGnD_6Gm2ku
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-19_16,2023-07-19_01,2023-05-22_02
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Add unit tests for movsx insns.

Signed-off-by: Yonghong Song <yhs@fb.com>
---
 .../selftests/bpf/prog_tests/verifier.c       |   2 +
 .../selftests/bpf/progs/verifier_movsx.c      | 199 ++++++++++++++++++
 2 files changed, 201 insertions(+)
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
index 000000000000..5ee7d004f8ba
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/verifier_movsx.c
@@ -0,0 +1,199 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
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
+	r0 =3D (s32)w0;					\
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
+	r1 =3D (s32)w0;					\
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
+char _license[] SEC("license") =3D "GPL";
--=20
2.34.1


