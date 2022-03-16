Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B60EC4DB778
	for <lists+bpf@lfdr.de>; Wed, 16 Mar 2022 18:38:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237335AbiCPRjn (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 16 Mar 2022 13:39:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244497AbiCPRjn (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 16 Mar 2022 13:39:43 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30C953AA66
        for <bpf@vger.kernel.org>; Wed, 16 Mar 2022 10:38:28 -0700 (PDT)
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.1.2/8.16.1.2) with ESMTP id 22GHCc2f003225
        for <bpf@vger.kernel.org>; Wed, 16 Mar 2022 10:38:27 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=KNV0hdc2o5avtAdOtlpLziaNMeGs8doBPSiKjBM2ra0=;
 b=FlF670r9LMRbel50GRlRl1iUJWzbuI9gSaNRHfjoqJ8pnoZCKmFNVXDNF1sY7WUyHMow
 uL95IY2tUAKDoSc4riOUIXuN0LQhx0+ftiBxa5dUl4zBMKZ8RKYbupuEmNwX5G1eo6au
 rgV1SVnO+jGtsIlDfMtt4UAhKE9/rqkd22o= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0001303.ppops.net (PPS) with ESMTPS id 3eugsft01p-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 16 Mar 2022 10:38:27 -0700
Received: from twshared27297.14.frc2.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:11d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Wed, 16 Mar 2022 10:38:25 -0700
Received: by devbig933.frc1.facebook.com (Postfix, from userid 6611)
        id 42FA62186537; Wed, 16 Mar 2022 10:38:23 -0700 (PDT)
From:   Martin KaFai Lau <kafai@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        <kernel-team@fb.com>, Stanislav Fomichev <sdf@google.com>
Subject: [PATCH v2 bpf-next 1/3] bpf: selftests: Add helpers to directly use the capget and capset syscall
Date:   Wed, 16 Mar 2022 10:38:23 -0700
Message-ID: <20220316173823.2036955-1-kafai@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220316173816.2035581-1-kafai@fb.com>
References: <20220316173816.2035581-1-kafai@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: HNQpN4m0g6psqw9GbMy9czZR56L6tYvq
X-Proofpoint-ORIG-GUID: HNQpN4m0g6psqw9GbMy9czZR56L6tYvq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-16_07,2022-03-15_01,2022-02-23_01
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

After upgrading to the newer libcap (>=3D 2.60),
the libcap commit aca076443591 ("Make cap_t operations thread safe.")
added a "__u8 mutex;" to the "struct _cap_struct".  It caused a few byte
shift that breaks the assumption made in the "struct libcap" definition
in test_verifier.c.

The bpf selftest usage only needs to enable and disable the effective
caps of the running task.  It is easier to directly syscall the
capget and capset instead.  It can also remove the libcap
library dependency.

The cap_helpers.{c,h} is added.  One __u64 is used for all CAP_*
bits instead of two __u32.

Acked-by: John Fastabend <john.fastabend@gmail.com>
Signed-off-by: Martin KaFai Lau <kafai@fb.com>
---
 tools/testing/selftests/bpf/cap_helpers.c | 67 +++++++++++++++++++++++
 tools/testing/selftests/bpf/cap_helpers.h | 19 +++++++
 2 files changed, 86 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/cap_helpers.c
 create mode 100644 tools/testing/selftests/bpf/cap_helpers.h

diff --git a/tools/testing/selftests/bpf/cap_helpers.c b/tools/testing/se=
lftests/bpf/cap_helpers.c
new file mode 100644
index 000000000000..d5ac507401d7
--- /dev/null
+++ b/tools/testing/selftests/bpf/cap_helpers.c
@@ -0,0 +1,67 @@
+// SPDX-License-Identifier: GPL-2.0
+#include "cap_helpers.h"
+
+/* Avoid including <sys/capability.h> from the libcap-devel package,
+ * so directly declare them here and use them from glibc.
+ */
+int capget(cap_user_header_t header, cap_user_data_t data);
+int capset(cap_user_header_t header, const cap_user_data_t data);
+
+int cap_enable_effective(__u64 caps, __u64 *old_caps)
+{
+	struct __user_cap_data_struct data[_LINUX_CAPABILITY_U32S_3];
+	struct __user_cap_header_struct hdr =3D {
+		.version =3D _LINUX_CAPABILITY_VERSION_3,
+	};
+	__u32 cap0 =3D caps;
+	__u32 cap1 =3D caps >> 32;
+	int err;
+
+	err =3D capget(&hdr, data);
+	if (err)
+		return err;
+
+	if (old_caps)
+		*old_caps =3D (__u64)(data[1].effective) << 32 | data[0].effective;
+
+	if ((data[0].effective & cap0) =3D=3D cap0 &&
+	    (data[1].effective & cap1) =3D=3D cap1)
+		return 0;
+
+	data[0].effective |=3D cap0;
+	data[1].effective |=3D cap1;
+	err =3D capset(&hdr, data);
+	if (err)
+		return err;
+
+	return 0;
+}
+
+int cap_disable_effective(__u64 caps, __u64 *old_caps)
+{
+	struct __user_cap_data_struct data[_LINUX_CAPABILITY_U32S_3];
+	struct __user_cap_header_struct hdr =3D {
+		.version =3D _LINUX_CAPABILITY_VERSION_3,
+	};
+	__u32 cap0 =3D caps;
+	__u32 cap1 =3D caps >> 32;
+	int err;
+
+	err =3D capget(&hdr, data);
+	if (err)
+		return err;
+
+	if (old_caps)
+		*old_caps =3D (__u64)(data[1].effective) << 32 | data[0].effective;
+
+	if (!(data[0].effective & cap0) && !(data[1].effective & cap1))
+		return 0;
+
+	data[0].effective &=3D ~cap0;
+	data[1].effective &=3D ~cap1;
+	err =3D capset(&hdr, data);
+	if (err)
+		return err;
+
+	return 0;
+}
diff --git a/tools/testing/selftests/bpf/cap_helpers.h b/tools/testing/se=
lftests/bpf/cap_helpers.h
new file mode 100644
index 000000000000..6d163530cb0f
--- /dev/null
+++ b/tools/testing/selftests/bpf/cap_helpers.h
@@ -0,0 +1,19 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __CAP_HELPERS_H
+#define __CAP_HELPERS_H
+
+#include <linux/types.h>
+#include <linux/capability.h>
+
+#ifndef CAP_PERFMON
+#define CAP_PERFMON		38
+#endif
+
+#ifndef CAP_BPF
+#define CAP_BPF			39
+#endif
+
+int cap_enable_effective(__u64 caps, __u64 *old_caps);
+int cap_disable_effective(__u64 caps, __u64 *old_caps);
+
+#endif
--=20
2.30.2

