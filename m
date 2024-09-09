Return-Path: <bpf+bounces-39365-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D874972553
	for <lists+bpf@lfdr.de>; Tue, 10 Sep 2024 00:34:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ED4CAB23228
	for <lists+bpf@lfdr.de>; Mon,  9 Sep 2024 22:34:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 219A218C915;
	Mon,  9 Sep 2024 22:34:49 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from 66-220-155-178.mail-mxout.facebook.com (66-220-155-178.mail-mxout.facebook.com [66.220.155.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35E1B8F5A
	for <bpf@vger.kernel.org>; Mon,  9 Sep 2024 22:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.155.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725921288; cv=none; b=HOFgTF/KmXu3D4zOq7gEFIeyzqLMfQ53gf7qpH9Cgaoo1G9Px+iyIj+Xskk/zkf6JWYgiSucVODQGUJs6svjIAEjF8MW4LeV5+bjvW3Qc/BgrjcT7O2Pe/GSQuZm8vpdg05eYRujuOcAtVBx6Jjq4jM5ndOtFbAY0mQTlGpU/BU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725921288; c=relaxed/simple;
	bh=2t/fYXuR5msLivlNZT97R8B6BADCg/mWyKZ248n1wV8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NP5Y/NV+yJCq9RRTE4vPxtNnLIIkA26dmuhvmFtZ3XCPbMAkSFq3x67dgyLPXvAM2SPmPGt0y9PsJrwsXlalsQmgoNuaorURS1soqT729MrETFr3VHSuNP/zHp7ouTq84L2UUyPm/RAP1SGCGu/gQ/k1qcBsthNSuLM2RZX1SPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.155.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
	id E67858C748DC; Mon,  9 Sep 2024 15:34:31 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next v3] selftests/bpf: Fix arena_atomics failure due to llvm change
Date: Mon,  9 Sep 2024 15:34:31 -0700
Message-ID: <20240909223431.1666305-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

llvm change [1] made a change such that __sync_fetch_and_{and,or,xor}()
will generate atomic_fetch_*() insns even if the return value is not used=
.
This is a deliberate choice to make sure barrier semantics are preserved
from source code to asm insn.

But the change in [1] caused arena_atomics selftest failure.

  test_arena_atomics:PASS:arena atomics skeleton open 0 nsec
  libbpf: prog 'and': BPF program load failed: Permission denied
  libbpf: prog 'and': -- BEGIN PROG LOAD LOG --
  arg#0 reference type('UNKNOWN ') size cannot be determined: -22
  0: R1=3Dctx() R10=3Dfp0
  ; if (pid !=3D (bpf_get_current_pid_tgid() >> 32)) @ arena_atomics.c:87
  0: (18) r1 =3D 0xffffc90000064000       ; R1_w=3Dmap_value(map=3Darena_=
at.bss,ks=3D4,vs=3D4)
  2: (61) r6 =3D *(u32 *)(r1 +0)          ; R1_w=3Dmap_value(map=3Darena_=
at.bss,ks=3D4,vs=3D4) R6_w=3Dscalar(smin=3D0,smax=3Dumax=3D0xffffffff,v
ar_off=3D(0x0; 0xffffffff))
  3: (85) call bpf_get_current_pid_tgid#14      ; R0_w=3Dscalar()
  4: (77) r0 >>=3D 32                     ; R0_w=3Dscalar(smin=3D0,smax=3D=
umax=3D0xffffffff,var_off=3D(0x0; 0xffffffff))
  5: (5d) if r0 !=3D r6 goto pc+11        ; R0_w=3Dscalar(smin=3D0,smax=3D=
umax=3D0xffffffff,var_off=3D(0x0; 0xffffffff)) R6_w=3Dscalar(smin=3D0,sma=
x=3Dumax=3D0xffffffff,var_off=3D(0x0; 0x)
  ; __sync_fetch_and_and(&and64_value, 0x011ull << 32); @ arena_atomics.c=
:91
  6: (18) r1 =3D 0x100000000060           ; R1_w=3Dscalar()
  8: (bf) r1 =3D addr_space_cast(r1, 0, 1)        ; R1_w=3Darena
  9: (18) r2 =3D 0x1100000000             ; R2_w=3D0x1100000000
  11: (db) r2 =3D atomic64_fetch_and((u64 *)(r1 +0), r2)
  BPF_ATOMIC stores into R1 arena is not allowed
  processed 9 insns (limit 1000000) max_states_per_insn 0 total_states 0 =
peak_states 0 mark_read 0
  -- END PROG LOAD LOG --
  libbpf: prog 'and': failed to load: -13
  libbpf: failed to load object 'arena_atomics'
  libbpf: failed to load BPF skeleton 'arena_atomics': -13
  test_arena_atomics:FAIL:arena atomics skeleton load unexpected error: -=
13 (errno 13)
  #3       arena_atomics:FAIL

The reason of the failure is due to [2] where atomic{64,}_fetch_{and,or,x=
or}() are not
allowed by arena addresses.

Version 2 of the patch fixed the issue by using inline asm ([3]). But fur=
ther discussion
suggested to find a way from source to generate locked insn which is more=
 user
friendly. So in not-merged llvm patch ([4]), if relax memory ordering is =
used and
the return value is not used, locked insn could be generated.

So with llvm patch [4] to compile the bpf selftest, the following code
  __c11_atomic_fetch_and(&and64_value, 0x011ull << 32, memory_order_relax=
ed);
is able to generate locked insn, hence fixing the selftest failure.

  [1] https://github.com/llvm/llvm-project/pull/106494
  [2] d503a04f8bc0 ("bpf: Add support for certain atomics in bpf_arena to=
 x86 JIT")
  [3] https://lore.kernel.org/bpf/20240803025928.4184433-1-yonghong.song@=
linux.dev/
  [4] https://github.com/llvm/llvm-project/pull/107343

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 .../selftests/bpf/progs/arena_atomics.c       | 32 ++++++++++++++++++-
 1 file changed, 31 insertions(+), 1 deletion(-)

Changelogs:
  v2 -> v3:
    - use c11 atomic functions. when relaxed memory ordering is specified=
 and return
      value is not used, locked insn will be generated and this can make =
selftests pass.
  v1 -> v2:
    - Add __BPF_FEATURE_ADDR_SPACE_CAST to guard newly added asm codes fo=
r llvm >=3D 19

diff --git a/tools/testing/selftests/bpf/progs/arena_atomics.c b/tools/te=
sting/selftests/bpf/progs/arena_atomics.c
index bb0acd79d28a..40dd57fca5cc 100644
--- a/tools/testing/selftests/bpf/progs/arena_atomics.c
+++ b/tools/testing/selftests/bpf/progs/arena_atomics.c
@@ -4,6 +4,7 @@
 #include <bpf/bpf_helpers.h>
 #include <bpf/bpf_tracing.h>
 #include <stdbool.h>
+#include <stdatomic.h>
 #include "bpf_arena_common.h"
=20
 struct {
@@ -77,8 +78,13 @@ int sub(const void *ctx)
 	return 0;
 }
=20
+#ifdef __BPF_FEATURE_ATOMIC_MEM_ORDERING
+_Atomic __u64 __arena_global and64_value =3D (0x110ull << 32);
+_Atomic __u32 __arena_global and32_value =3D 0x110;
+#else
 __u64 __arena_global and64_value =3D (0x110ull << 32);
 __u32 __arena_global and32_value =3D 0x110;
+#endif
=20
 SEC("raw_tp/sys_enter")
 int and(const void *ctx)
@@ -86,16 +92,25 @@ int and(const void *ctx)
 	if (pid !=3D (bpf_get_current_pid_tgid() >> 32))
 		return 0;
 #ifdef ENABLE_ATOMICS_TESTS
-
+#ifdef __BPF_FEATURE_ATOMIC_MEM_ORDERING
+	__c11_atomic_fetch_and(&and64_value, 0x011ull << 32, memory_order_relax=
ed);
+	__c11_atomic_fetch_and(&and32_value, 0x011, memory_order_relaxed);
+#else
 	__sync_fetch_and_and(&and64_value, 0x011ull << 32);
 	__sync_fetch_and_and(&and32_value, 0x011);
+#endif
 #endif
=20
 	return 0;
 }
=20
+#ifdef __BPF_FEATURE_ATOMIC_MEM_ORDERING
+_Atomic __u32 __arena_global or32_value =3D 0x110;
+_Atomic __u64 __arena_global or64_value =3D (0x110ull << 32);
+#else
 __u32 __arena_global or32_value =3D 0x110;
 __u64 __arena_global or64_value =3D (0x110ull << 32);
+#endif
=20
 SEC("raw_tp/sys_enter")
 int or(const void *ctx)
@@ -103,15 +118,25 @@ int or(const void *ctx)
 	if (pid !=3D (bpf_get_current_pid_tgid() >> 32))
 		return 0;
 #ifdef ENABLE_ATOMICS_TESTS
+#ifdef __BPF_FEATURE_ATOMIC_MEM_ORDERING
+	__c11_atomic_fetch_or(&or64_value, 0x011ull << 32, memory_order_relaxed=
);
+	__c11_atomic_fetch_or(&or32_value, 0x011, memory_order_relaxed);
+#else
 	__sync_fetch_and_or(&or64_value, 0x011ull << 32);
 	__sync_fetch_and_or(&or32_value, 0x011);
+#endif
 #endif
=20
 	return 0;
 }
=20
+#ifdef __BPF_FEATURE_ATOMIC_MEM_ORDERING
+_Atomic __u64 __arena_global xor64_value =3D (0x110ull << 32);
+_Atomic __u32 __arena_global xor32_value =3D 0x110;
+#else
 __u64 __arena_global xor64_value =3D (0x110ull << 32);
 __u32 __arena_global xor32_value =3D 0x110;
+#endif
=20
 SEC("raw_tp/sys_enter")
 int xor(const void *ctx)
@@ -119,8 +144,13 @@ int xor(const void *ctx)
 	if (pid !=3D (bpf_get_current_pid_tgid() >> 32))
 		return 0;
 #ifdef ENABLE_ATOMICS_TESTS
+#ifdef __BPF_FEATURE_ATOMIC_MEM_ORDERING
+	__c11_atomic_fetch_xor(&xor64_value, 0x011ull << 32, memory_order_relax=
ed);
+	__c11_atomic_fetch_xor(&xor32_value, 0x011, memory_order_relaxed);
+#else
 	__sync_fetch_and_xor(&xor64_value, 0x011ull << 32);
 	__sync_fetch_and_xor(&xor32_value, 0x011);
+#endif
 #endif
=20
 	return 0;
--=20
2.43.5


