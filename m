Return-Path: <bpf+bounces-705-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75994705E87
	for <lists+bpf@lfdr.de>; Wed, 17 May 2023 06:04:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 659381C20D13
	for <lists+bpf@lfdr.de>; Wed, 17 May 2023 04:04:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A94303C24;
	Wed, 17 May 2023 04:04:15 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A2F72100
	for <bpf@vger.kernel.org>; Wed, 17 May 2023 04:04:15 +0000 (UTC)
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 128473A8D
	for <bpf@vger.kernel.org>; Tue, 16 May 2023 21:04:11 -0700 (PDT)
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
	by m0001303.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 34GMH67m017678
	for <bpf@vger.kernel.org>; Tue, 16 May 2023 21:04:11 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=RLFekfe6Tgu6KbwfrIHaJ8myb754X6FMJN2cl/dBErM=;
 b=F9NGovw4SfiHMiwzcHTOfwo5irz3xlKOGqM1xbwpfMFCedGbVqCjP3MkWw5J+m6B9Msb
 ULhVXUUTSQtBSQEd88NpSDWtEkvxx5LfqOd8OklENU8HSk2NlVasLyUxeLM0zR0S7uWZ
 xwG27FaVaDhGqnOv2++meDo8RrUefIzVRbM= 
Received: from mail.thefacebook.com ([163.114.132.120])
	by m0001303.ppops.net (PPS) with ESMTPS id 3qm8uye56q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Tue, 16 May 2023 21:04:11 -0700
Received: from twshared4382.03.ash8.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:11d::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 16 May 2023 21:04:09 -0700
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
	id D50FD1FB5DD0B; Tue, 16 May 2023 21:04:04 -0700 (PDT)
From: Yonghong Song <yhs@fb.com>
To: <bpf@vger.kernel.org>
CC: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>,
        Martin KaFai
 Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next 1/2] selftests/bpf: Fix dynptr/test_dynptr_is_null
Date: Tue, 16 May 2023 21:04:04 -0700
Message-ID: <20230517040404.4023912-1-yhs@fb.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: _cAE-0TxrB1t4kdBH0s4bRAdSIFrYD7W
X-Proofpoint-ORIG-GUID: _cAE-0TxrB1t4kdBH0s4bRAdSIFrYD7W
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-16_14,2023-05-16_01,2023-02-09_01
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
	SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

With latest llvm17, dynptr/test_dynptr_is_null subtest failed in my
testing VM. The failure log looks like below:
  All error logs:
  tester_init:PASS:tester_log_buf 0 nsec
  process_subtest:PASS:obj_open_mem 0 nsec
  process_subtest:PASS:Can't alloc specs array 0 nsec
  verify_success:PASS:dynptr_success__open 0 nsec
  verify_success:PASS:bpf_object__find_program_by_name 0 nsec
  verify_success:PASS:dynptr_success__load 0 nsec
  verify_success:PASS:bpf_program__attach 0 nsec
  verify_success:FAIL:err unexpected err: actual 4 !=3D expected 0
  #65/9    dynptr/test_dynptr_is_null:FAIL

The error happens for bpf prog test_dynptr_is_null in dynptr_success.c.
        if (bpf_dynptr_is_null(&ptr2)) {
                err =3D 4;
                goto exit;
        }

The bpf_dynptr_is_null(&ptr) unexpectedly returned a non-zero
value and the control went to the error path.

Digging further, I found the root cause is due to function
signature difference between kernel and user space.

In kernel, we have
  __bpf_kfunc bool bpf_dynptr_is_null(struct bpf_dynptr_kern *ptr)
while in bpf_kfuncs.h we have
  extern int bpf_dynptr_is_null(const struct bpf_dynptr *ptr) __ksym;

The kernel bpf_dynptr_is_null disasm code:
  ffffffff812f1a90 <bpf_dynptr_is_null>:
  ffffffff812f1a90: f3 0f 1e fa           endbr64
  ffffffff812f1a94: 0f 1f 44 00 00        nopl    (%rax,%rax)
  ffffffff812f1a99: 53                    pushq   %rbx
  ffffffff812f1a9a: 48 89 fb              movq    %rdi, %rbx
  ffffffff812f1a9d: e8 ae 29 17 00        callq   0xffffffff81464450 <__a=
san_load8_noabort>
  ffffffff812f1aa2: 48 83 3b 00           cmpq    $0x0, (%rbx)
  ffffffff812f1aa6: 0f 94 c0              sete    %al
  ffffffff812f1aa9: 5b                    popq    %rbx
  ffffffff812f1aaa: c3                    retq

Note that only 1-byte register %al is set and the other 7-bytes are not t=
ouched.

In bpf program, the asm code for the above bpf_dynptr_is_null(&ptr2):
       266:       85 10 00 00 ff ff ff ff call -0x1
       267:       b4 01 00 00 04 00 00 00 w1 =3D 0x4
       268:       16 00 03 00 00 00 00 00 if w0 =3D=3D 0x0 goto +0x3 <LBB=
9_8>

Basically, 4-byte subregister is tested. This might cause error
as the value other than the lowest byte might not be 0.

This patch fixed the issue by using the identical func prototype
across kernel and selftest user space. The fixed bpf asm code:
       267:       85 10 00 00 ff ff ff ff call -0x1
       268:       54 00 00 00 01 00 00 00 w0 &=3D 0x1
       269:       b4 01 00 00 04 00 00 00 w1 =3D 0x4
       270:       16 00 03 00 00 00 00 00 if w0 =3D=3D 0x0 goto +0x3 <LBB=
9_8>

Signed-off-by: Yonghong Song <yhs@fb.com>
---
 tools/testing/selftests/bpf/bpf_kfuncs.h            | 2 +-
 tools/testing/selftests/bpf/progs/dynptr_fail.c     | 1 +
 tools/testing/selftests/bpf/progs/dynptr_success.c  | 1 +
 tools/testing/selftests/bpf/progs/test_xdp_dynptr.c | 1 +
 4 files changed, 4 insertions(+), 1 deletion(-)

NOTE: It would be we can auto generate a header file for all kfunc's.
Similar to bpf_helper_defs.h, all kfunc prototypes can be put into
autogenerated bpf_kfunc_defs.h which can be used by selftests and
applications.

diff --git a/tools/testing/selftests/bpf/bpf_kfuncs.h b/tools/testing/sel=
ftests/bpf/bpf_kfuncs.h
index f3c41f8902a0..821c25b7d0df 100644
--- a/tools/testing/selftests/bpf/bpf_kfuncs.h
+++ b/tools/testing/selftests/bpf/bpf_kfuncs.h
@@ -36,7 +36,7 @@ extern void *bpf_dynptr_slice_rdwr(const struct bpf_dyn=
ptr *ptr, __u32 offset,
 			      void *buffer, __u32 buffer__szk) __ksym;
=20
 extern int bpf_dynptr_adjust(const struct bpf_dynptr *ptr, __u32 start, =
__u32 end) __ksym;
-extern int bpf_dynptr_is_null(const struct bpf_dynptr *ptr) __ksym;
+extern bool bpf_dynptr_is_null(const struct bpf_dynptr *ptr) __ksym;
 extern int bpf_dynptr_is_rdonly(const struct bpf_dynptr *ptr) __ksym;
 extern __u32 bpf_dynptr_size(const struct bpf_dynptr *ptr) __ksym;
 extern int bpf_dynptr_clone(const struct bpf_dynptr *ptr, struct bpf_dyn=
ptr *clone__init) __ksym;
diff --git a/tools/testing/selftests/bpf/progs/dynptr_fail.c b/tools/test=
ing/selftests/bpf/progs/dynptr_fail.c
index c2f0e18af951..7ce7e827d5f0 100644
--- a/tools/testing/selftests/bpf/progs/dynptr_fail.c
+++ b/tools/testing/selftests/bpf/progs/dynptr_fail.c
@@ -3,6 +3,7 @@
=20
 #include <errno.h>
 #include <string.h>
+#include <stdbool.h>
 #include <linux/bpf.h>
 #include <bpf/bpf_helpers.h>
 #include <linux/if_ether.h>
diff --git a/tools/testing/selftests/bpf/progs/dynptr_success.c b/tools/t=
esting/selftests/bpf/progs/dynptr_success.c
index 0c053976f8f9..5985920d162e 100644
--- a/tools/testing/selftests/bpf/progs/dynptr_success.c
+++ b/tools/testing/selftests/bpf/progs/dynptr_success.c
@@ -2,6 +2,7 @@
 /* Copyright (c) 2022 Facebook */
=20
 #include <string.h>
+#include <stdbool.h>
 #include <linux/bpf.h>
 #include <bpf/bpf_helpers.h>
 #include "bpf_misc.h"
diff --git a/tools/testing/selftests/bpf/progs/test_xdp_dynptr.c b/tools/=
testing/selftests/bpf/progs/test_xdp_dynptr.c
index 25ee4a22e48d..78c368e71797 100644
--- a/tools/testing/selftests/bpf/progs/test_xdp_dynptr.c
+++ b/tools/testing/selftests/bpf/progs/test_xdp_dynptr.c
@@ -2,6 +2,7 @@
 /* Copyright (c) 2022 Meta */
 #include <stddef.h>
 #include <string.h>
+#include <stdbool.h>
 #include <linux/bpf.h>
 #include <linux/if_ether.h>
 #include <linux/if_packet.h>
--=20
2.34.1


