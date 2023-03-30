Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56C5B6CFB08
	for <lists+bpf@lfdr.de>; Thu, 30 Mar 2023 07:56:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229990AbjC3F4s (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 30 Mar 2023 01:56:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229963AbjC3F4l (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 30 Mar 2023 01:56:41 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2CC661A4
        for <bpf@vger.kernel.org>; Wed, 29 Mar 2023 22:56:40 -0700 (PDT)
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32TJU3NF014048
        for <bpf@vger.kernel.org>; Wed, 29 Mar 2023 22:56:40 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=LmvBzCYaaFsFTF0h4yOXb9G1yi+mrYnF+dtCWiOBGeo=;
 b=Wz9sSMudFydnx9J0yVWTn6NSXEWd6SpwbTWl8hS+bXhhdzBKEJXqZ0pAirKfA0kNTC3c
 QwQX/fr6dV+AaxHzjTKS1MvB5UTTTdYJavqasODaQqqpjkfsUnQ/r5stPpJKcrfY9uo3
 PuknN44Sdz/Cw9loon/MHxHV7hRC5vNNbpo= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3pmesc7qj0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 29 Mar 2023 22:56:39 -0700
Received: from twshared8216.02.ash9.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:11d::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Wed, 29 Mar 2023 22:56:38 -0700
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
        id 2DEAB1BA2D9A7; Wed, 29 Mar 2023 22:56:36 -0700 (PDT)
From:   Yonghong Song <yhs@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>,
        Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next 7/7] selftests/bpf: Add a new test based on loop6.c
Date:   Wed, 29 Mar 2023 22:56:36 -0700
Message-ID: <20230330055636.93471-1-yhs@fb.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230330055600.86870-1-yhs@fb.com>
References: <20230330055600.86870-1-yhs@fb.com>
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: scVFfalzIoz9BlUVR-Uq-79qcU_L1zst
X-Proofpoint-ORIG-GUID: scVFfalzIoz9BlUVR-Uq-79qcU_L1zst
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
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

With LLVM commit [1], loop6.c will fail verification without Commit 3c2611b=
ac08a
("selftests/bpf: Fix trace_virtqueue_add_sgs test issue with LLVM 17.").
Also, there is an effort to fix LLVM since LLVM17 may be used by old kernels
for bpf development.

A new test is added by manually doing similar transformation in [1]
so it can be used to test related verifier changes.

  [1] https://reviews.llvm.org/D143726

Signed-off-by: Yonghong Song <yhs@fb.com>
---
 .../bpf/prog_tests/bpf_verif_scale.c          |   5 +
 tools/testing/selftests/bpf/progs/loop7.c     | 102 ++++++++++++++++++
 2 files changed, 107 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/loop7.c

diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_verif_scale.c b/too=
ls/testing/selftests/bpf/prog_tests/bpf_verif_scale.c
index 731c343897d8..cb708235e654 100644
--- a/tools/testing/selftests/bpf/prog_tests/bpf_verif_scale.c
+++ b/tools/testing/selftests/bpf/prog_tests/bpf_verif_scale.c
@@ -180,6 +180,11 @@ void test_verif_scale_loop6()
 	scale_test("loop6.bpf.o", BPF_PROG_TYPE_KPROBE, false);
 }
=20
+void test_verif_scale_loop7()
+{
+	scale_test("loop7.bpf.o", BPF_PROG_TYPE_KPROBE, false);
+}
+
 void test_verif_scale_strobemeta()
 {
 	/* partial unroll. 19k insn in a loop.
diff --git a/tools/testing/selftests/bpf/progs/loop7.c b/tools/testing/self=
tests/bpf/progs/loop7.c
new file mode 100644
index 000000000000..b234ed6f0038
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/loop7.c
@@ -0,0 +1,102 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/ptrace.h>
+#include <stddef.h>
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+#include "bpf_misc.h"
+
+char _license[] SEC("license") =3D "GPL";
+
+/* typically virtio scsi has max SGs of 6 */
+#define VIRTIO_MAX_SGS	6
+
+/* Verifier will fail with SG_MAX =3D 128. The failure can be
+ * workarounded with a smaller SG_MAX, e.g. 10.
+ */
+#define WORKAROUND
+#ifdef WORKAROUND
+#define SG_MAX		10
+#else
+/* typically virtio blk has max SEG of 128 */
+#define SG_MAX		128
+#endif
+
+#define SG_CHAIN	0x01UL
+#define SG_END		0x02UL
+
+struct scatterlist {
+	unsigned long   page_link;
+	unsigned int    offset;
+	unsigned int    length;
+};
+
+#define sg_is_chain(sg)		((sg)->page_link & SG_CHAIN)
+#define sg_is_last(sg)		((sg)->page_link & SG_END)
+#define sg_chain_ptr(sg)	\
+	((struct scatterlist *) ((sg)->page_link & ~(SG_CHAIN | SG_END)))
+
+static inline struct scatterlist *__sg_next(struct scatterlist *sgp)
+{
+	struct scatterlist sg;
+
+	bpf_probe_read_kernel(&sg, sizeof(sg), sgp);
+	if (sg_is_last(&sg))
+		return NULL;
+
+	sgp++;
+
+	bpf_probe_read_kernel(&sg, sizeof(sg), sgp);
+	if (sg_is_chain(&sg))
+		sgp =3D sg_chain_ptr(&sg);
+
+	return sgp;
+}
+
+static inline struct scatterlist *get_sgp(struct scatterlist **sgs, int i)
+{
+	struct scatterlist *sgp;
+
+	bpf_probe_read_kernel(&sgp, sizeof(sgp), sgs + i);
+	return sgp;
+}
+
+int config =3D 0;
+int result =3D 0;
+
+SEC("kprobe/virtqueue_add_sgs")
+int BPF_KPROBE(trace_virtqueue_add_sgs, void *unused, struct scatterlist *=
*sgs,
+	       unsigned int out_sgs, unsigned int in_sgs)
+{
+	struct scatterlist *sgp =3D NULL;
+	__u64 length1 =3D 0, length2 =3D 0;
+	unsigned int i, n, len, upper;
+
+	if (config !=3D 0)
+		return 0;
+
+	upper =3D out_sgs < VIRTIO_MAX_SGS ? out_sgs : VIRTIO_MAX_SGS;
+	for (i =3D 0; i < upper; i++) {
+		for (n =3D 0, sgp =3D get_sgp(sgs, i); sgp && (n < SG_MAX);
+		     sgp =3D __sg_next(sgp)) {
+			bpf_probe_read_kernel(&len, sizeof(len), &sgp->length);
+			length1 +=3D len;
+			n++;
+		}
+	}
+
+	upper =3D in_sgs < VIRTIO_MAX_SGS ? in_sgs : VIRTIO_MAX_SGS;
+	for (i =3D 0; i < upper; i++) {
+		for (n =3D 0, sgp =3D get_sgp(sgs, i); sgp && (n < SG_MAX);
+		     sgp =3D __sg_next(sgp)) {
+			bpf_probe_read_kernel(&len, sizeof(len), &sgp->length);
+			length2 +=3D len;
+			n++;
+		}
+	}
+
+	config =3D 1;
+	result =3D length2 - length1;
+	return 0;
+}
--=20
2.34.1

