Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF1E1506347
	for <lists+bpf@lfdr.de>; Tue, 19 Apr 2022 06:33:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347667AbiDSEf2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 19 Apr 2022 00:35:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240853AbiDSEf2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 19 Apr 2022 00:35:28 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA9BC22B31
        for <bpf@vger.kernel.org>; Mon, 18 Apr 2022 21:32:46 -0700 (PDT)
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 23J0OiDT004646
        for <bpf@vger.kernel.org>; Mon, 18 Apr 2022 21:32:46 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=facebook; bh=cCN71/11g084UR3Ve9hTUKRijsJqBmMl0YlvKjj4m2c=;
 b=SaY/GfzkmeYbmY01spmEAbDhzTRkWe0fleZnAgmAt4k/KuIdPwFK+c0z2Iqf6b1NxuzX
 nqgMcO+o5QE1UpDXKhU0bWp5/BNwCVI1YKvbWHSbEtgs43nbuGfOpnYwarZDlDiyG0oP
 lipPqzgvQWrAIY8THbr4m6efNpYKymh32Mo= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3fhjh1gupr-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 18 Apr 2022 21:32:46 -0700
Received: from twshared13345.18.frc3.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 18 Apr 2022 21:32:43 -0700
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
        id D1AF29303187; Mon, 18 Apr 2022 21:32:30 -0700 (PDT)
From:   Yonghong Song <yhs@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>
Subject: [PATCH bpf-next] selftests/bpf: limit unroll_count for pyperf600 test
Date:   Mon, 18 Apr 2022 21:32:30 -0700
Message-ID: <20220419043230.2928530-1-yhs@fb.com>
X-Mailer: git-send-email 2.30.2
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: o6P9VG4rRjGKgYtCxClOUDb5F4YzqsXS
X-Proofpoint-ORIG-GUID: o6P9VG4rRjGKgYtCxClOUDb5F4YzqsXS
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-19_01,2022-04-15_01,2022-02-23_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

LLVM commit [1] changed loop pragma behavior such that
full loop unroll is always honored with user pragma.
Previously, unroll count also depends on the unrolled
code size. For pyperf600, without [1], the loop unroll
count is 150. With [1], the loop unroll count is 600.

The unroll count of 600 caused the program size close to
298k and this caused the following code is generated:
         0:       7b 1a 00 ff 00 00 00 00 *(u64 *)(r10 - 256) =3D r1
  ;       uint64_t pid_tgid =3D bpf_get_current_pid_tgid();
         1:       85 00 00 00 0e 00 00 00 call 14
         2:       bf 06 00 00 00 00 00 00 r6 =3D r0
  ;       pid_t pid =3D (pid_t)(pid_tgid >> 32);
         3:       bf 61 00 00 00 00 00 00 r1 =3D r6
         4:       77 01 00 00 20 00 00 00 r1 >>=3D 32
         5:       63 1a fc ff 00 00 00 00 *(u32 *)(r10 - 4) =3D r1
         6:       bf a2 00 00 00 00 00 00 r2 =3D r10
         7:       07 02 00 00 fc ff ff ff r2 +=3D -4
  ;       PidData* pidData =3D bpf_map_lookup_elem(&pidmap, &pid);
         8:       18 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 r1 =3D 0 =
ll
        10:       85 00 00 00 01 00 00 00 call 1
        11:       bf 08 00 00 00 00 00 00 r8 =3D r0
  ;       if (!pidData)
        12:       15 08 15 e8 00 00 00 00 if r8 =3D=3D 0 goto -6123 <LBB0_2=
7588+0xffffffffffdae100>

Note that insn 12 has a branch offset -6123 which is clearly illegal
and will be rejected by the verifier. The negative offset is due to
the branch range is greater than INT16_MAX.

This patch changed the unroll count to be 150 to avoid above
branch target insn out-of-range issue. Also the llvm is enhanced ([2])
to assert if the branch target insn is out of INT16 range.

  [1] https://reviews.llvm.org/D119148
  [2] https://reviews.llvm.org/D123877

Signed-off-by: Yonghong Song <yhs@fb.com>
---
 tools/testing/selftests/bpf/progs/pyperf.h    |  4 ++++
 tools/testing/selftests/bpf/progs/pyperf600.c | 11 +++++++----
 2 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/pyperf.h b/tools/testing/sel=
ftests/bpf/progs/pyperf.h
index 1ed28882daf3..5d3dc4d66d47 100644
--- a/tools/testing/selftests/bpf/progs/pyperf.h
+++ b/tools/testing/selftests/bpf/progs/pyperf.h
@@ -299,7 +299,11 @@ int __on_event(struct bpf_raw_tracepoint_args *ctx)
 #ifdef NO_UNROLL
 #pragma clang loop unroll(disable)
 #else
+#ifdef UNROLL_COUNT
+#pragma clang loop unroll_count(UNROLL_COUNT)
+#else
 #pragma clang loop unroll(full)
+#endif
 #endif /* NO_UNROLL */
 		/* Unwind python stack */
 		for (int i =3D 0; i < STACK_MAX_LEN; ++i) {
diff --git a/tools/testing/selftests/bpf/progs/pyperf600.c b/tools/testing/=
selftests/bpf/progs/pyperf600.c
index cb49b89e37cd..ce1aa5189cc4 100644
--- a/tools/testing/selftests/bpf/progs/pyperf600.c
+++ b/tools/testing/selftests/bpf/progs/pyperf600.c
@@ -1,9 +1,12 @@
 // SPDX-License-Identifier: GPL-2.0
 // Copyright (c) 2019 Facebook
 #define STACK_MAX_LEN 600
-/* clang will not unroll the loop 600 times.
- * Instead it will unroll it to the amount it deemed
- * appropriate, but the loop will still execute 600 times.
- * Total program size is around 90k insns
+/* Full unroll of 600 iterations will have total
+ * program size close to 298k insns and this may
+ * cause BPF_JMP insn out of 16-bit integer range.
+ * So limit the unroll size to 150 so the
+ * total program size is around 80k insns but
+ * the loop will still execute 600 times.
  */
+#define UNROLL_COUNT 150
 #include "pyperf.h"
--=20
2.30.2

