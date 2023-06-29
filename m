Return-Path: <bpf+bounces-3715-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3691D74207A
	for <lists+bpf@lfdr.de>; Thu, 29 Jun 2023 08:38:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7743280D71
	for <lists+bpf@lfdr.de>; Thu, 29 Jun 2023 06:38:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99DF253AE;
	Thu, 29 Jun 2023 06:38:15 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C1081FA1
	for <bpf@vger.kernel.org>; Thu, 29 Jun 2023 06:38:15 +0000 (UTC)
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A05A2D52
	for <bpf@vger.kernel.org>; Wed, 28 Jun 2023 23:38:14 -0700 (PDT)
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35T0R9iY017243
	for <bpf@vger.kernel.org>; Wed, 28 Jun 2023 23:38:14 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=og0e4iKHUIoe0+cKOyI57AFFZhLEToDn2RvsMZs9LLA=;
 b=SwUGWzZQjOrgjN5/pjxwIyvQZwLHAWZiNH89E1CwvX0GMz+pH15PtQ5udQniBn1aDxde
 Ju4AuFvdjBcz2lsHGOrR5uURZl9240sQoV3Ue0km9e6/FQ2VAPnFqWVnJfLjc5I4wHQY
 3bGrYv5wRHT7K6vQLEsQKlNIqGQ307PyzYI= 
Received: from maileast.thefacebook.com ([163.114.130.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3rgye42cej-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Wed, 28 Jun 2023 23:38:13 -0700
Received: from twshared15133.05.ash9.facebook.com (2620:10d:c0a8:1c::11) by
 mail.thefacebook.com (2620:10d:c0a8:82::d) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 28 Jun 2023 23:38:12 -0700
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
	id A18A1221E7DA8; Wed, 28 Jun 2023 23:38:02 -0700 (PDT)
From: Yonghong Song <yhs@fb.com>
To: <bpf@vger.kernel.org>
CC: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Fangrui Song <maskray@google.com>, <kernel-team@fb.com>
Subject: [RFC PATCH bpf-next 08/13] selftests/bpf: Add unit tests for new sign-extension load insns
Date: Wed, 28 Jun 2023 23:38:02 -0700
Message-ID: <20230629063802.1652905-1-yhs@fb.com>
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
X-Proofpoint-GUID: raIlW0bV5SxMqwrhO15Xfhpg5xjugz3c
X-Proofpoint-ORIG-GUID: raIlW0bV5SxMqwrhO15Xfhpg5xjugz3c
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
 .../selftests/bpf/progs/verifier_lds.c        | 46 +++++++++++++++++++
 2 files changed, 48 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_lds.c

diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/te=
sting/selftests/bpf/prog_tests/verifier.c
index 070a13833c3f..bc05391174c7 100644
--- a/tools/testing/selftests/bpf/prog_tests/verifier.c
+++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
@@ -31,6 +31,7 @@
 #include "verifier_int_ptr.skel.h"
 #include "verifier_jeq_infer_not_null.skel.h"
 #include "verifier_ld_ind.skel.h"
+#include "verifier_lds.skel.h"
 #include "verifier_leak_ptr.skel.h"
 #include "verifier_loops1.skel.h"
 #include "verifier_lwt.skel.h"
@@ -132,6 +133,7 @@ void test_verifier_helper_value_access(void)  { RUN(v=
erifier_helper_value_access
 void test_verifier_int_ptr(void)              { RUN(verifier_int_ptr); }
 void test_verifier_jeq_infer_not_null(void)   { RUN(verifier_jeq_infer_n=
ot_null); }
 void test_verifier_ld_ind(void)               { RUN(verifier_ld_ind); }
+void test_verifier_lds(void)                  { RUN(verifier_lds); }
 void test_verifier_leak_ptr(void)             { RUN(verifier_leak_ptr); =
}
 void test_verifier_loops1(void)               { RUN(verifier_loops1); }
 void test_verifier_lwt(void)                  { RUN(verifier_lwt); }
diff --git a/tools/testing/selftests/bpf/progs/verifier_lds.c b/tools/tes=
ting/selftests/bpf/progs/verifier_lds.c
new file mode 100644
index 000000000000..85f3030e0cfd
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/verifier_lds.c
@@ -0,0 +1,46 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
+
+SEC("socket")
+__description("LDS, S8")
+__success __success_unpriv __retval(-2)
+__naked void lds_s8(void)
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
+__description("LDS, S16")
+__success __success_unpriv __retval(-2)
+__naked void lds_s16(void)
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
+__description("LDS, S32")
+__success __success_unpriv __retval(-2)
+__naked void lds_s32(void)
+{
+	asm volatile ("					\
+	r1 =3D 0xfffffffe;				\
+	*(u64 *)(r10 - 8) =3D r1;				\
+	r0 =3D *(s32 *)(r10 - 8);				\
+	exit;						\
+"	::: __clobber_all);
+}
+
+char _license[] SEC("license") =3D "GPL";
--=20
2.34.1


