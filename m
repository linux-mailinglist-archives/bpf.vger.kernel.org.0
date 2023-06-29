Return-Path: <bpf+bounces-3716-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F41D274207B
	for <lists+bpf@lfdr.de>; Thu, 29 Jun 2023 08:38:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F59B1C20924
	for <lists+bpf@lfdr.de>; Thu, 29 Jun 2023 06:38:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 251F153B5;
	Thu, 29 Jun 2023 06:38:27 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4FEB15D2
	for <bpf@vger.kernel.org>; Thu, 29 Jun 2023 06:38:26 +0000 (UTC)
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D872D2D52
	for <bpf@vger.kernel.org>; Wed, 28 Jun 2023 23:38:25 -0700 (PDT)
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35T0kAIO022928
	for <bpf@vger.kernel.org>; Wed, 28 Jun 2023 23:38:25 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=DjEJ2NM0GqIhQRWFSSgKEPFHuQy0FwURj5jjEqhYxZU=;
 b=NS57aLosEtkY4CNix3PHC18YcOtiPVofFkrt+7G58A7tzWTYintV5OiyEDILMeWAOzoI
 P2GyyD1llv9hxHiY21N/53bQf3FpMmOiT2OZ80Shn5G2IOrACRKPRXku22Ws0TGwwy/B
 jpdEpBhu/9eIj7B4EQ2c8gePgX/jgiwKHPU= 
Received: from maileast.thefacebook.com ([163.114.130.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3rgypq29t4-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Wed, 28 Jun 2023 23:38:25 -0700
Received: from twshared32300.07.ash9.facebook.com (2620:10d:c0a8:1b::30) by
 mail.thefacebook.com (2620:10d:c0a8:83::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 28 Jun 2023 23:38:23 -0700
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
	id 34CDC221E7DEB; Wed, 28 Jun 2023 23:38:18 -0700 (PDT)
From: Yonghong Song <yhs@fb.com>
To: <bpf@vger.kernel.org>
CC: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Fangrui Song <maskray@google.com>, <kernel-team@fb.com>
Subject: [RFC PATCH bpf-next 10/13] selftests/bpf: Add unit tests for new bswap insns
Date: Wed, 28 Jun 2023 23:38:18 -0700
Message-ID: <20230629063818.1654472-1-yhs@fb.com>
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
X-Proofpoint-GUID: e3c7g-d79LYRw1_Trz330xjPz4MZFQlM
X-Proofpoint-ORIG-GUID: e3c7g-d79LYRw1_Trz330xjPz4MZFQlM
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
 .../selftests/bpf/progs/verifier_bswap.c      | 45 +++++++++++++++++++
 2 files changed, 47 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_bswap.c

diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/te=
sting/selftests/bpf/prog_tests/verifier.c
index a4d9fc57aff2..63112b3755cb 100644
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
@@ -114,6 +115,7 @@ void test_verifier_bounds_deduction(void)     { RUN(v=
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
index 000000000000..b85474a46296
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/verifier_bswap.c
@@ -0,0 +1,45 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
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
+char _license[] SEC("license") =3D "GPL";
--=20
2.34.1


