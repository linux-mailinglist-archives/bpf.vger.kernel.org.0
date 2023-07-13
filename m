Return-Path: <bpf+bounces-4934-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B355751898
	for <lists+bpf@lfdr.de>; Thu, 13 Jul 2023 08:09:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 004E5281B01
	for <lists+bpf@lfdr.de>; Thu, 13 Jul 2023 06:09:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A41135694;
	Thu, 13 Jul 2023 06:08:31 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 815535681
	for <bpf@vger.kernel.org>; Thu, 13 Jul 2023 06:08:31 +0000 (UTC)
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEB7B1BC6
	for <bpf@vger.kernel.org>; Wed, 12 Jul 2023 23:08:29 -0700 (PDT)
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36D4c51K015854
	for <bpf@vger.kernel.org>; Wed, 12 Jul 2023 23:08:29 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=SLZ+vam5muq2jF4XcMDbCbzPhu8I05sOzukFXjM4AeQ=;
 b=RU3uawmgFmIaeNfUtf+lVlWh3C1CYT7t4+Vt/ps3MdI5R1DUNE1My48TXa0Oi0kkJbyu
 htr8hNh8A9GFnoDJDDLtiRQOz7dNrGwi7WvefBdqn6Uj/H0XdCAU6M0VuNG2bMImhvnC
 gffEbq4R0kS/CUgDA/EdNKfMKIDSoz0Dlr0= 
Received: from maileast.thefacebook.com ([163.114.130.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3rtad8ghbp-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Wed, 12 Jul 2023 23:08:29 -0700
Received: from twshared37136.03.ash8.facebook.com (2620:10d:c0a8:1b::2d) by
 mail.thefacebook.com (2620:10d:c0a8:83::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 12 Jul 2023 23:08:27 -0700
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
	id C8C6B22EFA40D; Wed, 12 Jul 2023 23:08:13 -0700 (PDT)
From: Yonghong Song <yhs@fb.com>
To: <bpf@vger.kernel.org>
CC: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Fangrui Song <maskray@google.com>, <kernel-team@fb.com>
Subject: [PATCH bpf-next v2 10/15] selftests/bpf: Add unit tests for new sign-extension mov insns
Date: Wed, 12 Jul 2023 23:08:13 -0700
Message-ID: <20230713060813.394351-1-yhs@fb.com>
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
X-Proofpoint-GUID: 4cX0pP9FkhDlSAEJ4QvWPBTvJFQ6vOMJ
X-Proofpoint-ORIG-GUID: 4cX0pP9FkhDlSAEJ4QvWPBTvJFQ6vOMJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-13_03,2023-07-11_01,2023-05-22_02
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
	SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Add unit tests for movsx insns.

Signed-off-by: Yonghong Song <yhs@fb.com>
---
 .../selftests/bpf/prog_tests/verifier.c       |   2 +
 .../selftests/bpf/progs/verifier_movsx.c      | 177 ++++++++++++++++++
 2 files changed, 179 insertions(+)
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
index 000000000000..2bfb9358e8e2
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/verifier_movsx.c
@@ -0,0 +1,177 @@
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
+__success __success_unpriv __retval(-2)
+__naked void mov64sx_s32(void)
+{
+	asm volatile ("					\
+	r0 =3D 0xfffffffe;				\
+	r0 =3D (s32)w0;					\
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


