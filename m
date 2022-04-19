Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8299C5063C1
	for <lists+bpf@lfdr.de>; Tue, 19 Apr 2022 07:09:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233360AbiDSFLu (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 19 Apr 2022 01:11:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231609AbiDSFLt (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 19 Apr 2022 01:11:49 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D229201A1
        for <bpf@vger.kernel.org>; Mon, 18 Apr 2022 22:09:08 -0700 (PDT)
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 23J3NwBw006363
        for <bpf@vger.kernel.org>; Mon, 18 Apr 2022 22:09:07 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=facebook; bh=r/MZoFwC8905GLcFK6aRpw/ikrhIH5ZtrEdBPgBOysU=;
 b=fCUIS/pcKa5nFv6Ny98B37KoTzffmH+USOs15QM4awbwgklO2Kaox3weemtD6ePE066k
 85bzNLSFlGm6RAbBjTzYE7nmEJQ0Je0rpGArSG9fnGhvSNfvdbP08eyqZqNPxeMwDlUo
 bfo0GOQ/VdHGYV8Ys7Jst7fyoD5qw4X2Z9w= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3fhn50ra7h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 18 Apr 2022 22:09:07 -0700
Received: from twshared16483.05.ash9.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 18 Apr 2022 22:09:06 -0700
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
        id 6E3639308723; Mon, 18 Apr 2022 22:09:00 -0700 (PDT)
From:   Yonghong Song <yhs@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>
Subject: [PATCH bpf-next] selftests/bpf: Workaround a verifier issue for test exhandler
Date:   Mon, 18 Apr 2022 22:09:00 -0700
Message-ID: <20220419050900.3136024-1-yhs@fb.com>
X-Mailer: git-send-email 2.30.2
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: KfNUcV_WRVYbSCSAOsVhb3zo1cLR17aA
X-Proofpoint-ORIG-GUID: KfNUcV_WRVYbSCSAOsVhb3zo1cLR17aA
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

The llvm patch [1] enabled opaque pointer which caused selftest
'exhandler' failure.
  ...
  ; work =3D task->task_works;
  7: (79) r1 =3D *(u64 *)(r6 +2120)       ; R1_w=3Dptr_callback_head(off=3D=
0,imm=3D0) R6_w=3Dptr_task_struct(off=3D0,imm=3D0)
  ; func =3D work->func;
  8: (79) r2 =3D *(u64 *)(r1 +8)          ; R1_w=3Dptr_callback_head(off=3D=
0,imm=3D0) R2_w=3Dscalar()
  ; if (!work && !func)
  9: (4f) r1 |=3D r2
  math between ptr_ pointer and register with unbounded min value is not al=
lowed

  below is insn 10 and 11
  10: (55) if r1 !=3D 0 goto +5
  11: (18) r1 =3D 0 ll
  ...

In llvm, the code generation of 'r1 |=3D r2' happened in codegen
selectiondag phase due to difference of opaque pointer vs. non-opaque point=
er.
Without [1], the related code looks like:
  r2 =3D *(u64 *)(r6 + 2120)
  r1 =3D *(u64 *)(r2 + 8)
  if r2 !=3D 0 goto +6 <LBB0_4>
  if r1 !=3D 0 goto +5 <LBB0_4>
  r1 =3D 0 ll
  ...

I haven't found a good way in llvm to fix this issue. So let us workaround =
the
problem first so bpf CI won't be blocked.

  [1] https://reviews.llvm.org/D123300

Signed-off-by: Yonghong Song <yhs@fb.com>
---
 .../testing/selftests/bpf/progs/exhandler_kern.c  | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/exhandler_kern.c b/tools/tes=
ting/selftests/bpf/progs/exhandler_kern.c
index f5ca142abf8f..dd9b30a0f0fc 100644
--- a/tools/testing/selftests/bpf/progs/exhandler_kern.c
+++ b/tools/testing/selftests/bpf/progs/exhandler_kern.c
@@ -7,6 +7,8 @@
 #include <bpf/bpf_tracing.h>
 #include <bpf/bpf_core_read.h>
=20
+#define barrier_var(var) asm volatile("" : "=3Dr"(var) : "0"(var))
+
 char _license[] SEC("license") =3D "GPL";
=20
 unsigned int exception_triggered;
@@ -37,7 +39,16 @@ int BPF_PROG(trace_task_newtask, struct task_struct *tas=
k, u64 clone_flags)
 	 */
 	work =3D task->task_works;
 	func =3D work->func;
-	if (!work && !func)
-		exception_triggered++;
+	/* Currently verifier will fail for `btf_ptr |=3D btf_ptr` * instruction.
+	 * To workaround the issue, use barrier_var() and rewrite as below to
+	 * prevent compiler from generating verifier-unfriendly code.
+	 */
+	barrier_var(work);
+	if (work)
+		return 0;
+	barrier_var(func);
+	if (func)
+		return 0;
+	exception_triggered++;
 	return 0;
 }
--=20
2.30.2

