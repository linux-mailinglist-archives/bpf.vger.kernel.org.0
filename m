Return-Path: <bpf+bounces-14794-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 669A47E82CE
	for <lists+bpf@lfdr.de>; Fri, 10 Nov 2023 20:37:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3EECD1C20A9B
	for <lists+bpf@lfdr.de>; Fri, 10 Nov 2023 19:37:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BB503A262;
	Fri, 10 Nov 2023 19:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 129991D539
	for <bpf@vger.kernel.org>; Fri, 10 Nov 2023 19:37:12 +0000 (UTC)
Received: from 69-171-232-180.mail-mxout.facebook.com (69-171-232-180.mail-mxout.facebook.com [69.171.232.180])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB88F5E61
	for <bpf@vger.kernel.org>; Fri, 10 Nov 2023 11:37:09 -0800 (PST)
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
	id BE91929A51C2D; Fri, 10 Nov 2023 11:36:44 -0800 (PST)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next v2] selftests/bpf: Fix pyperf180 compilation failure with clang18
Date: Fri, 10 Nov 2023 11:36:44 -0800
Message-Id: <20231110193644.3130906-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

With latest clang18 (main branch of llvm-project repo), when building bpf=
 selftests,
    [~/work/bpf-next (master)]$ make -C tools/testing/selftests/bpf LLVM=3D=
1 -j

The following compilation error happens:
    fatal error: error in backend: Branch target out of insn range
    ...
    Stack dump:
    0.      Program arguments: clang -g -Wall -Werror -D__TARGET_ARCH_x86=
 -mlittle-endian
      -I/home/yhs/work/bpf-next/tools/testing/selftests/bpf/tools/include
      -I/home/yhs/work/bpf-next/tools/testing/selftests/bpf -I/home/yhs/w=
ork/bpf-next/tools/include/uapi
      -I/home/yhs/work/bpf-next/tools/testing/selftests/usr/include -idir=
after
      /home/yhs/work/llvm-project/llvm/build.18/install/lib/clang/18/incl=
ude -idirafter /usr/local/include
      -idirafter /usr/include -Wno-compare-distinct-pointer-types -DENABL=
E_ATOMICS_TESTS -O2 --target=3Dbpf
      -c progs/pyperf180.c -mcpu=3Dv3 -o /home/yhs/work/bpf-next/tools/te=
sting/selftests/bpf/pyperf180.bpf.o
    1.      <eof> parser at end of file
    2.      Code generation
    ...

The compilation failure only happens to cpu=3Dv2 and cpu=3Dv3. cpu=3Dv4 i=
s okay
since cpu=3Dv4 supports 32-bit branch target offset.

The above failure is due to upstream llvm patch [1] where some inlining b=
ehavior
are changed in clang18.

To workaround the issue, previously all 180 loop iterations are fully unr=
olled.
The bpf macro __BPF_CPU_VERSION__ (implemented in clang18 recently) is us=
ed to avoid
unrolling changes if cpu=3Dv4. If __BPF_CPU_VERSION__ is not available an=
d the
compiler is clang18, the unrollng amount is unconditionally reduced.

  [1] https://github.com/llvm/llvm-project/commit/1a2e77cf9e11dbf56b5720c=
607313a566eebb16e

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 tools/testing/selftests/bpf/progs/pyperf180.c | 22 +++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/pyperf180.c b/tools/testin=
g/selftests/bpf/progs/pyperf180.c
index c39f559d3100..42c4a8b62e36 100644
--- a/tools/testing/selftests/bpf/progs/pyperf180.c
+++ b/tools/testing/selftests/bpf/progs/pyperf180.c
@@ -1,4 +1,26 @@
 // SPDX-License-Identifier: GPL-2.0
 // Copyright (c) 2019 Facebook
 #define STACK_MAX_LEN 180
+
+/* llvm upstream commit at clang18
+ *   https://github.com/llvm/llvm-project/commit/1a2e77cf9e11dbf56b5720c=
607313a566eebb16e
+ * changed inlining behavior and caused compilation failure as some bran=
ch
+ * target distance exceeded 16bit representation which is the maximum fo=
r
+ * cpu v1/v2/v3. Macro __BPF_CPU_VERSION__ is later implemented in clang=
18
+ * to specify which cpu version is used for compilation. So a smaller
+ * unroll_count can be set if __BPF_CPU_VERSION__ is less than 4, which
+ * reduced some branch target distances and resolved the compilation fai=
lure.
+ *
+ * To capture the case where a developer/ci uses clang18 but the corresp=
onding
+ * repo checkpoint does not have __BPF_CPU_VERSION__, a smaller unroll_c=
ount
+ * will be set as well to prevent potential compilation failures.
+ */
+#ifdef __BPF_CPU_VERSION__
+#if __BPF_CPU_VERSION__ < 4
+#define UNROLL_COUNT 90
+#endif
+#elif __clang_major__ =3D=3D 18
+#define UNROLL_COUNT 90
+#endif
+
 #include "pyperf.h"
--=20
2.34.1


