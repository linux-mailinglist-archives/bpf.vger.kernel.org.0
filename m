Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4E14326679
	for <lists+bpf@lfdr.de>; Fri, 26 Feb 2021 18:49:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229622AbhBZRsr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 26 Feb 2021 12:48:47 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:27050 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229745AbhBZRsp (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 26 Feb 2021 12:48:45 -0500
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 11QHkqpq011677
        for <bpf@vger.kernel.org>; Fri, 26 Feb 2021 09:48:05 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=facebook; bh=tJucv9sfZwcyWXHDPPr8yijZTmgHZsmEDIMbiksHiQc=;
 b=S54FbEyQ1+dhyor4LSW5rmDDMiRNE1yCpv2v1+IK/0cfDGMGPnF3sG5lL2K5obFMEpRE
 q3DOehkJdUX1NYnAbJ4zmPU7SDDY8IM6URChhp5AZY4l37Y9vKreIaadkv10hPWL4te9
 JnjWkTC3V3o0SnZSQ2gQDqF24fMQf5c77LM= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 36xkfkd83k-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 26 Feb 2021 09:48:04 -0800
Received: from intmgw001.06.ash9.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c085:21d::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Fri, 26 Feb 2021 09:48:04 -0800
Received: by devbig003.ftw2.facebook.com (Postfix, from userid 128203)
        id 61C843704C96; Fri, 26 Feb 2021 09:48:00 -0800 (PST)
From:   Yonghong Song <yhs@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>,
        zhenwei pi <pizhenwei@bytedance.com>
Subject: [PATCH bpf-next] selftests/bpf: add a verifier scale test with unknown bounded loop
Date:   Fri, 26 Feb 2021 09:48:00 -0800
Message-ID: <20210226174800.2928132-1-yhs@fb.com>
X-Mailer: git-send-email 2.24.1
X-FB-Internal: Safe
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-02-26_05:2021-02-26,2021-02-26 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0 suspectscore=0
 adultscore=0 clxscore=1015 malwarescore=0 phishscore=0 impostorscore=0
 lowpriorityscore=0 mlxlogscore=858 spamscore=0 bulkscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102260132
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The orignal bcc pull request
  https://github.com/iovisor/bcc/pull/3270
exposed a verifier failure with Clang 12/13 while
Clang 4 works fine. Further investigation exposed two issues.
  Issue 1: LLVM may generate code which uses less refined
     value. The issue is fixed in llvm patch
     https://reviews.llvm.org/D97479
  Issue 2: Spills with initial value 0 are marked as precise
     which makes later state pruning less effective.
     This is my rough initial analysis and further investigation
     is needed to find how to improve verifier pruning
     in such cases.

With the above llvm patch, for the new loop6.c test, which has
smaller loop bound compared to original test, I got
  $ test_progs -s -n 10/16
  ...
  stack depth 64
  processed 405099 insns (limit 1000000) max_states_per_insn 92
      total_states 8866 peak_states 889 mark_read 6
  #10/16 loop6.o:OK

Use the original loop bound, i.e., commenting out "#define WORKAROUND",
I got
  $ test_progs -s -n 10/16
  ...
  BPF program is too large. Processed 1000001 insn
  stack depth 64
  processed 1000001 insns (limit 1000000) max_states_per_insn 91
      total_states 23176 peak_states 5069 mark_read 6
  ...
  #10/16 loop6.o:FAIL

The purpose of this patch is to provide a regression
test for the above llvm fix and also provide a test
case for further analyzing the verifier pruning issue.

Cc: zhenwei pi <pizhenwei@bytedance.com>
Signed-off-by: Yonghong Song <yhs@fb.com>
---
 tools/testing/selftests/bpf/README.rst        |  39 +++++++
 .../bpf/prog_tests/bpf_verif_scale.c          |   1 +
 tools/testing/selftests/bpf/progs/loop6.c     | 101 ++++++++++++++++++
 3 files changed, 141 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/loop6.c

diff --git a/tools/testing/selftests/bpf/README.rst b/tools/testing/selftes=
ts/bpf/README.rst
index fd148b8410fa..dbc8f6cc5c67 100644
--- a/tools/testing/selftests/bpf/README.rst
+++ b/tools/testing/selftests/bpf/README.rst
@@ -111,6 +111,45 @@ available in 10.0.1. The patch is available in llvm 11=
.0.0 trunk.
=20
 __  https://reviews.llvm.org/D78466
=20
+bpf_verif_scale/loop6.o test failure with Clang 12
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
+
+With Clang 12, the following bpf_verif_scale test failed:
+  * ``bpf_verif_scale/loop6.o``
+
+The verifier output looks like
+
+.. code-block:: c
+
+  R1 type=3Dctx expected=3Dfp
+  The sequence of 8193 jumps is too complex.
+
+The reason is compiler generating the following code
+
+.. code-block:: c
+
+  ;       for (i =3D 0; (i < VIRTIO_MAX_SGS) && (i < num); i++) {
+      14:       16 05 40 00 00 00 00 00 if w5 =3D=3D 0 goto +64 <LBB0_6>
+      15:       bc 51 00 00 00 00 00 00 w1 =3D w5
+      16:       04 01 00 00 ff ff ff ff w1 +=3D -1
+      17:       67 05 00 00 20 00 00 00 r5 <<=3D 32
+      18:       77 05 00 00 20 00 00 00 r5 >>=3D 32
+      19:       a6 01 01 00 05 00 00 00 if w1 < 5 goto +1 <LBB0_4>
+      20:       b7 05 00 00 06 00 00 00 r5 =3D 6
+  00000000000000a8 <LBB0_4>:
+      21:       b7 02 00 00 00 00 00 00 r2 =3D 0
+      22:       b7 01 00 00 00 00 00 00 r1 =3D 0
+  ;       for (i =3D 0; (i < VIRTIO_MAX_SGS) && (i < num); i++) {
+      23:       7b 1a e0 ff 00 00 00 00 *(u64 *)(r10 - 32) =3D r1
+      24:       7b 5a c0 ff 00 00 00 00 *(u64 *)(r10 - 64) =3D r5
+
+Note that insn #15 has w1 =3D w5 and w1 is refined later but
+r5(w5) is eventually saved on stack at insn #24 for later use.
+This cause later verifier failure. The bug has been `fixed`__ in
+Clang 13.
+
+__  https://reviews.llvm.org/D97479
+
 BPF CO-RE-based tests and Clang version
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=20
diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_verif_scale.c b/too=
ls/testing/selftests/bpf/prog_tests/bpf_verif_scale.c
index e698ee6bb6c2..3d002c245d2b 100644
--- a/tools/testing/selftests/bpf/prog_tests/bpf_verif_scale.c
+++ b/tools/testing/selftests/bpf/prog_tests/bpf_verif_scale.c
@@ -76,6 +76,7 @@ void test_bpf_verif_scale(void)
 		{ "loop2.o", BPF_PROG_TYPE_RAW_TRACEPOINT },
 		{ "loop4.o", BPF_PROG_TYPE_SCHED_CLS },
 		{ "loop5.o", BPF_PROG_TYPE_SCHED_CLS },
+		{ "loop6.o", BPF_PROG_TYPE_KPROBE },
=20
 		/* partial unroll. 19k insn in a loop.
 		 * Total program size 20.8k insn.
diff --git a/tools/testing/selftests/bpf/progs/loop6.c b/tools/testing/self=
tests/bpf/progs/loop6.c
new file mode 100644
index 000000000000..fe535922bed8
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/loop6.c
@@ -0,0 +1,101 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/ptrace.h>
+#include <stddef.h>
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
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
+int nested_loops(volatile struct pt_regs* ctx)
+{
+	struct scatterlist **sgs =3D PT_REGS_PARM2(ctx);
+	unsigned int num1 =3D PT_REGS_PARM3(ctx);
+	unsigned int num2 =3D PT_REGS_PARM4(ctx);
+	struct scatterlist *sgp =3D NULL;
+	__u64 length1 =3D 0, length2 =3D 0;
+	unsigned int i, n, len;
+
+	if (config !=3D 0)
+		return 0;
+
+	for (i =3D 0; (i < VIRTIO_MAX_SGS) && (i < num1); i++) {
+		for (n =3D 0, sgp =3D get_sgp(sgs, i); sgp && (n < SG_MAX);
+		     sgp =3D __sg_next(sgp)) {
+			bpf_probe_read_kernel(&len, sizeof(len), &sgp->length);
+			length1 +=3D len;
+			n++;
+		}
+	}
+
+	for (i =3D 0; (i < VIRTIO_MAX_SGS) && (i < num2); i++) {
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
2.24.1

