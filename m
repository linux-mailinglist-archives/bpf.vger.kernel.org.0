Return-Path: <bpf+bounces-3717-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1498A74207C
	for <lists+bpf@lfdr.de>; Thu, 29 Jun 2023 08:39:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C39F7280D71
	for <lists+bpf@lfdr.de>; Thu, 29 Jun 2023 06:39:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E5C55384;
	Thu, 29 Jun 2023 06:38:30 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 585A95687
	for <bpf@vger.kernel.org>; Thu, 29 Jun 2023 06:38:30 +0000 (UTC)
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4CE12705
	for <bpf@vger.kernel.org>; Wed, 28 Jun 2023 23:38:28 -0700 (PDT)
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35T0NU8g030396
	for <bpf@vger.kernel.org>; Wed, 28 Jun 2023 23:38:28 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=czFGdXXFRrO60rg8Ok2Gyqtkx2AWKjNGoLXvlbMAO1I=;
 b=qdUiFxeqGnJyqL3/rdHTREFBk5DpGAhtOnPUAoh/wL4D/7wgKZ/xrBugdTPndMyBiWRw
 EhfSqBKZd1V8VoxnGWgHfVDuFP9LqUoXBBLY41nPtja868pxw/D4y7OKOc0qB+Gjb5iM
 M2SLNpikIhx/2l0a3Eit+bpIN1O+otkm9Bk= 
Received: from mail.thefacebook.com ([163.114.132.120])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3rgyc1aatn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Wed, 28 Jun 2023 23:38:27 -0700
Received: from twshared52565.14.frc2.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:21d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 28 Jun 2023 23:38:26 -0700
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
	id D79B5221E7DD3; Wed, 28 Jun 2023 23:38:11 -0700 (PDT)
From: Yonghong Song <yhs@fb.com>
To: <bpf@vger.kernel.org>
CC: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Fangrui Song <maskray@google.com>, <kernel-team@fb.com>
Subject: [RFC PATCH bpf-next 09/13] selftests/bpf: Add unit tests for new sign-extension mov insns
Date: Wed, 28 Jun 2023 23:38:11 -0700
Message-ID: <20230629063811.1654342-1-yhs@fb.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230629063715.1646832-1-yhs@fb.com>
References: <20230629063715.1646832-1-yhs@fb.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 0qtl2v_JxSBVqZDeGrNdWPlep_jHd4iS
X-Proofpoint-GUID: 0qtl2v_JxSBVqZDeGrNdWPlep_jHd4iS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-28_14,2023-06-27_01,2023-05-22_02
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
	SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Signed-off-by: Yonghong Song <yhs@fb.com>
---
 .../selftests/bpf/prog_tests/verifier.c       |  2 +
 .../selftests/bpf/progs/verifier_movs.c       | 67 +++++++++++++++++++
 2 files changed, 69 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_movs.c

diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/te=
sting/selftests/bpf/prog_tests/verifier.c
index bc05391174c7..a4d9fc57aff2 100644
--- a/tools/testing/selftests/bpf/prog_tests/verifier.c
+++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
@@ -41,6 +41,7 @@
 #include "verifier_map_ret_val.skel.h"
 #include "verifier_masking.skel.h"
 #include "verifier_meta_access.skel.h"
+#include "verifier_movs.skel.h"
 #include "verifier_netfilter_ctx.skel.h"
 #include "verifier_netfilter_retcode.skel.h"
 #include "verifier_prevent_map_lookup.skel.h"
@@ -143,6 +144,7 @@ void test_verifier_map_ptr_mixing(void)       { RUN(v=
erifier_map_ptr_mixing); }
 void test_verifier_map_ret_val(void)          { RUN(verifier_map_ret_val=
); }
 void test_verifier_masking(void)              { RUN(verifier_masking); }
 void test_verifier_meta_access(void)          { RUN(verifier_meta_access=
); }
+void test_verifier_movs(void)                 { RUN(verifier_movs); }
 void test_verifier_netfilter_ctx(void)        { RUN(verifier_netfilter_c=
tx); }
 void test_verifier_netfilter_retcode(void)    { RUN(verifier_netfilter_r=
etcode); }
 void test_verifier_prevent_map_lookup(void)   { RUN(verifier_prevent_map=
_lookup); }
diff --git a/tools/testing/selftests/bpf/progs/verifier_movs.c b/tools/te=
sting/selftests/bpf/progs/verifier_movs.c
new file mode 100644
index 000000000000..575d2a708a01
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/verifier_movs.c
@@ -0,0 +1,67 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
+
+SEC("socket")
+__description("MOV32S, S8")
+__success __success_unpriv __retval(0x23)
+__naked void mov32s_s8(void)
+{
+	asm volatile ("					\
+	w0 =3D 0xff23;					\
+	w0 =3D (s8)w0;					\
+	exit;						\
+"	::: __clobber_all);
+}
+
+SEC("socket")
+__description("MOV32S, S16")
+__success __success_unpriv __retval(0xFFFFff23)
+__naked void mov32s_s16(void)
+{
+	asm volatile ("					\
+	w0 =3D 0xff23;					\
+	w0 =3D (s16)w0;					\
+	exit;						\
+"	::: __clobber_all);
+}
+
+SEC("socket")
+__description("MOV64S, S8")
+__success __success_unpriv __retval(-2)
+__naked void mov64s_s8(void)
+{
+	asm volatile ("					\
+	r0 =3D 0x1fe;					\
+	r0 =3D (s8)r0;					\
+	exit;						\
+"	::: __clobber_all);
+}
+
+SEC("socket")
+__description("MOV64S, S16")
+__success __success_unpriv __retval(0xf23)
+__naked void mov64s_s16(void)
+{
+	asm volatile ("					\
+	r0 =3D 0xf0f23;					\
+	r0 =3D (s16)r0;					\
+	exit;						\
+"	::: __clobber_all);
+}
+
+SEC("socket")
+__description("MOV64S, S32")
+__success __success_unpriv __retval(-2)
+__naked void mov64s_s32(void)
+{
+	asm volatile ("					\
+	r0 =3D 0xfffffffe;				\
+	r0 =3D (s32)r0;					\
+	exit;						\
+"	::: __clobber_all);
+}
+
+char _license[] SEC("license") =3D "GPL";
--=20
2.34.1


