Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F98A64F34B
	for <lists+bpf@lfdr.de>; Fri, 16 Dec 2022 22:43:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229526AbiLPVnc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 16 Dec 2022 16:43:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbiLPVnc (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 16 Dec 2022 16:43:32 -0500
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E25932B9C
        for <bpf@vger.kernel.org>; Fri, 16 Dec 2022 13:43:31 -0800 (PST)
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 2BGJx3Pq022876
        for <bpf@vger.kernel.org>; Fri, 16 Dec 2022 13:43:30 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=UxpgzO1qFcybBG6a04570D4IOjY4BE8dRpwzVm5vqRk=;
 b=jD4LzZ5OhrmaJR83VLm/Sh/R/muuY5ufHUhVYoYGtqqG2gPpeQvxWuiW8M3+ZmPL67dj
 bWDHOjeDJgkr8+fm7wvdZERMcU8wtgufRrxMom6+AT25ETJdFjyAJBvP/65k48I77sBM
 mb8EeKp2La6ZIxPIGO89Xse6/C5akYFjUWA= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0089730.ppops.net (PPS) with ESMTPS id 3mgsfdawcr-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 16 Dec 2022 13:43:30 -0800
Received: from twshared19053.17.frc2.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:11d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Fri, 16 Dec 2022 13:43:28 -0800
Received: by devbig077.ldc1.facebook.com (Postfix, from userid 158236)
        id 1107A12A1EDAC; Fri, 16 Dec 2022 13:43:22 -0800 (PST)
From:   Dave Marchevsky <davemarchevsky@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Kernel Team <kernel-team@fb.com>, Yonghong Song <yhs@meta.com>,
        Dave Marchevsky <davemarchevsky@fb.com>,
        Yonghong Song <yhs@fb.com>
Subject: [PATCH v3 bpf-next 2/2] selftests/bpf: Add verifier test exercising jit PROBE_MEM logic
Date:   Fri, 16 Dec 2022 13:43:19 -0800
Message-ID: <20221216214319.3408356-2-davemarchevsky@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221216214319.3408356-1-davemarchevsky@fb.com>
References: <20221216214319.3408356-1-davemarchevsky@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: 8DogRcHM3Bfys6W_jW73gbU5GUlXXvVS
X-Proofpoint-ORIG-GUID: 8DogRcHM3Bfys6W_jW73gbU5GUlXXvVS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-16_14,2022-12-15_02,2022-06-22_01
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This patch adds a test exercising logic that was fixed / improved in
the previous patch in the series, as well as general sanity checking for
jit's PROBE_MEM logic which should've been unaffected by the previous
patch.

The added verifier test does the following:
  * Acquire a referenced kptr to struct prog_test_ref_kfunc using
    existing net/bpf/test_run.c kfunc
    * Helper returns ptr to a specific prog_test_ref_kfunc whose first
      two fields - both ints - have been prepopulated w/ vals 42 and
      108, respectively
  * kptr_xchg the acquired ptr into an arraymap
  * Do a direct map_value load of the just-added ptr
    * Goal of all this setup is to get an unreferenced kptr pointing to
      struct with ints of known value, which is the result of this step
  * Using unreferenced kptr obtained in previous step, do loads of
    prog_test_ref_kfunc.a (offset 0) and .b (offset 4)
  * Then incr the kptr by 8 and load prog_test_ref_kfunc.a again (this
    time at offset -8)
  * Add all the loaded ints together and return

Before the PROBE_MEM fixes in previous patch, the loads at offset 0 and
4 would succeed, while the load at offset -8 would incorrectly fail
runtime check emitted by the JIT and 0 out dst reg as a result. This
confirmed by retval of 150 for this test before previous patch - since
second .a read is 0'd out - and a retval of 192 with the fixed logic.

The test exercises the two optimizations to fixed logic added in last
patch as well:
  * First load, with insn "r8 =3D *(u32 *)(r9 + 0)" exercises "insn->off
    is 0, no need to add / sub from src_reg" optimization
  * Third load, with insn "r9 =3D *(u32 *)(r9 - 8)" exercises "src_reg =3D=
=3D
    dst_reg, no need to restore src_reg after load" optimization

Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
Acked-by: Yonghong Song <yhs@fb.com>
---
v2 -> v3: lore.kernel.org/bpf/20221216183122.2040142-2-davemarchevsky@fb.=
com
  * Remove unnecessary '\n's in asm statements (Yonghong)
  * Add Yonghong ack

v1 -> v2: lore.kernel.org/bpf/20221213182726.325137-2-davemarchevsky@fb.c=
om
  * Rewrite the test to be a "normal" C prog in selftests/bpf/progs. Resu=
lt
    is a much easier-to-understand test with assembly used only for the 3
    loads. (Yonghong)

 .../selftests/bpf/prog_tests/jit_probe_mem.c  | 28 +++++++++
 .../selftests/bpf/progs/jit_probe_mem.c       | 61 +++++++++++++++++++
 2 files changed, 89 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/jit_probe_mem.=
c
 create mode 100644 tools/testing/selftests/bpf/progs/jit_probe_mem.c

diff --git a/tools/testing/selftests/bpf/prog_tests/jit_probe_mem.c b/too=
ls/testing/selftests/bpf/prog_tests/jit_probe_mem.c
new file mode 100644
index 000000000000..5639428607e6
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/jit_probe_mem.c
@@ -0,0 +1,28 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2022 Meta Platforms, Inc. and affiliates. */
+#include <test_progs.h>
+#include <network_helpers.h>
+
+#include "jit_probe_mem.skel.h"
+
+void test_jit_probe_mem(void)
+{
+	LIBBPF_OPTS(bpf_test_run_opts, opts,
+		.data_in =3D &pkt_v4,
+		.data_size_in =3D sizeof(pkt_v4),
+		.repeat =3D 1,
+	);
+	struct jit_probe_mem *skel;
+	int ret;
+
+	skel =3D jit_probe_mem__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "jit_probe_mem__open_and_load"))
+		return;
+
+	ret =3D bpf_prog_test_run_opts(bpf_program__fd(skel->progs.test_jit_pro=
be_mem), &opts);
+	ASSERT_OK(ret, "jit_probe_mem ret");
+	ASSERT_OK(opts.retval, "jit_probe_mem opts.retval");
+	ASSERT_EQ(skel->data->total_sum, 192, "jit_probe_mem total_sum");
+
+	jit_probe_mem__destroy(skel);
+}
diff --git a/tools/testing/selftests/bpf/progs/jit_probe_mem.c b/tools/te=
sting/selftests/bpf/progs/jit_probe_mem.c
new file mode 100644
index 000000000000..1263053d1bd0
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/jit_probe_mem.c
@@ -0,0 +1,61 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2022 Meta Platforms, Inc. and affiliates. */
+#include <vmlinux.h>
+#include <bpf/bpf_tracing.h>
+#include <bpf/bpf_helpers.h>
+
+static struct prog_test_ref_kfunc __kptr_ref *v;
+long total_sum =3D -1;
+
+extern struct prog_test_ref_kfunc *bpf_kfunc_call_test_acquire(unsigned =
long *sp) __ksym;
+extern void bpf_kfunc_call_test_release(struct prog_test_ref_kfunc *p) _=
_ksym;
+
+SEC("tc")
+int test_jit_probe_mem(struct __sk_buff *ctx)
+{
+	struct prog_test_ref_kfunc *p;
+	unsigned long zero =3D 0, sum;
+
+	p =3D bpf_kfunc_call_test_acquire(&zero);
+	if (!p)
+		return 1;
+
+	p =3D bpf_kptr_xchg(&v, p);
+	if (p)
+		goto release_out;
+
+	/* Direct map value access of kptr, should be PTR_UNTRUSTED */
+	p =3D v;
+	if (!p)
+		return 1;
+
+	asm volatile (
+		"r9 =3D %[p];"
+		"%[sum] =3D 0;"
+
+		/* r8 =3D p->a */
+		"r8 =3D *(u32 *)(r9 + 0);"
+		"%[sum] +=3D r8;"
+
+		/* r8 =3D p->b */
+		"r8 =3D *(u32 *)(r9 + 4);"
+		"%[sum] +=3D r8;"
+
+		"r9 +=3D 8;"
+		/* r9 =3D p->a */
+		"r9 =3D *(u32 *)(r9 - 8);"
+		"%[sum] +=3D r9;"
+
+		: [sum] "=3Dr"(sum)
+		: [p] "r"(p)
+		: "r8", "r9"
+	);
+
+	total_sum =3D sum;
+	return 0;
+release_out:
+	bpf_kfunc_call_test_release(p);
+	return 1;
+}
+
+char _license[] SEC("license") =3D "GPL";
--=20
2.30.2

