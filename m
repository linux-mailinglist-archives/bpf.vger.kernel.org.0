Return-Path: <bpf+bounces-22039-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AB2FB85574A
	for <lists+bpf@lfdr.de>; Thu, 15 Feb 2024 00:30:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D06F21C21A61
	for <lists+bpf@lfdr.de>; Wed, 14 Feb 2024 23:30:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7B971419AC;
	Wed, 14 Feb 2024 23:30:08 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from 69-171-232-181.mail-mxout.facebook.com (69-171-232-181.mail-mxout.facebook.com [69.171.232.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2912A1DDD7
	for <bpf@vger.kernel.org>; Wed, 14 Feb 2024 23:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=69.171.232.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707953408; cv=none; b=pQGDt+kfmBhENp9L5ev8JF88AgdkwfLUjutGugYGZ9eAyj4wzW8Dvt7dzN+v3EA4GTeS/yJYehbcmIHDVlauJczVWDITMaOsR7NIEIxfPMJUJQLe+5T2LDOZmMOWPyQlBuhEY7u9Yhru8lPAQduVwe9IOPwqaUJMNuDA27nzsJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707953408; c=relaxed/simple;
	bh=pxDHzXWJmDGVGOvrXZ/R9rO7lIRxGd+YfzpLHOoAQko=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=PTvvaeZiZ3vJVVOJBO1/EC0WcVeE2xBdoEtG7BzZXMr0PfNWzaiqNmfGvSH9dRUHhnh3ezK6sgy2cWKynBaG0rBX72r/vhQv3tf1nLruZ8q5nKOQ0c9nBdhMZRkLctJbYgEOT56AQNyOfVfCT5GsCEBGA9ayqUNx5pveeJSfQNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=69.171.232.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
	id 7D5546490FF; Wed, 14 Feb 2024 15:29:51 -0800 (PST)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next v4] bpf: Fix test verif_scale_strobemeta_subprogs failure due to llvm19
Date: Wed, 14 Feb 2024 15:29:51 -0800
Message-Id: <20240214232951.4113094-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

With latest llvm19, I hit the following selftest failures with

  $ ./test_progs -j
  libbpf: prog 'on_event': BPF program load failed: Permission denied
  libbpf: prog 'on_event': -- BEGIN PROG LOAD LOG --
  combined stack size of 4 calls is 544. Too large
  verification time 1344153 usec
  stack depth 24+440+0+32
  processed 51008 insns (limit 1000000) max_states_per_insn 19 total_stat=
es 1467 peak_states 303 mark_read 146
  -- END PROG LOAD LOG --
  libbpf: prog 'on_event': failed to load: -13
  libbpf: failed to load object 'strobemeta_subprogs.bpf.o'
  scale_test:FAIL:expect_success unexpected error: -13 (errno 13)
  #498     verif_scale_strobemeta_subprogs:FAIL

The verifier complains too big of the combined stack size (544 bytes) whi=
ch
exceeds the maximum stack limit 512. This is a regression from llvm19 ([1=
]).

In the above error log, the original stack depth is 24+440+0+32.
To satisfy interpreter's need, in verifier the stack depth is adjusted to
32+448+32+32=3D544 which exceeds 512, hence the error. The same adjusted
stack size is also used for jit case.

But the jitted codes could use smaller stack size.

  $ egrep -r stack_depth | grep round_up
  arm64/net/bpf_jit_comp.c:       ctx->stack_size =3D round_up(prog->aux-=
>stack_depth, 16);
  loongarch/net/bpf_jit.c:        bpf_stack_adjust =3D round_up(ctx->prog=
->aux->stack_depth, 16);
  powerpc/net/bpf_jit_comp.c:     cgctx.stack_size =3D round_up(fp->aux->=
stack_depth, 16);
  riscv/net/bpf_jit_comp32.c:             round_up(ctx->prog->aux->stack_=
depth, STACK_ALIGN);
  riscv/net/bpf_jit_comp64.c:     bpf_stack_adjust =3D round_up(ctx->prog=
->aux->stack_depth, 16);
  s390/net/bpf_jit_comp.c:        u32 stack_depth =3D round_up(fp->aux->s=
tack_depth, 8);
  sparc/net/bpf_jit_comp_64.c:            stack_needed +=3D round_up(stac=
k_depth, 16);
  x86/net/bpf_jit_comp.c:         EMIT3_off32(0x48, 0x81, 0xEC, round_up(=
stack_depth, 8));
  x86/net/bpf_jit_comp.c: int tcc_off =3D -4 - round_up(stack_depth, 8);
  x86/net/bpf_jit_comp.c:                     round_up(stack_depth, 8));
  x86/net/bpf_jit_comp.c: int tcc_off =3D -4 - round_up(stack_depth, 8);
  x86/net/bpf_jit_comp.c:         EMIT3_off32(0x48, 0x81, 0xC4, round_up(=
stack_depth, 8));

In the above, STACK_ALIGN in riscv/net/bpf_jit_comp32.c is defined as 16.
So stack is aligned in either 8 or 16, x86/s390 having 8-byte stack align=
ment and
the rest having 16-byte alignment.

This patch calculates total stack depth based on 16-byte alignment if jit=
 is requested.
For the above failing case, the new stack size will be 32+448+0+32=3D512 =
and no verification
failure. llvm19 regression will be discussed separately in llvm upstream.

The verifier change caused three test failures as these tests compared me=
ssages
with stack size. More specifically,
  - test_global_funcs/global_func1: fail with interpreter mode and succes=
s with jit mode.
    Adjusted stack sizes so both jit and interpreter modes will fail.
  - async_stack_depth/{pseudo_call_check, async_call_root_check}: since j=
it and interpreter
    will calculate different stack sizes, the failure msg is adjusted to =
omit those
    specific stack size numbers.

  [1] https://lore.kernel.org/bpf/32bde0f0-1881-46c9-931a-673be566c61d@li=
nux.dev/

Suggested-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 kernel/bpf/verifier.c                          | 18 +++++++++++++-----
 .../selftests/bpf/progs/async_stack_depth.c    |  4 ++--
 .../selftests/bpf/progs/test_global_func1.c    |  8 ++++++--
 3 files changed, 21 insertions(+), 9 deletions(-)

Changelogs:
  v3 -> v4:
    - make a change in test_global_funcs/global_func1 so both interpreter=
 and
      jit modes failed the test.
  v2 -> v3:
    - fix async_stack_depth test failure if jit is turned off
  v1 -> v2:
    - fix some selftest failures

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index aa192dc735a9..011d54a1dc53 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -5812,6 +5812,17 @@ static int check_ptr_alignment(struct bpf_verifier=
_env *env,
 					   strict);
 }
=20
+static int round_up_stack_depth(struct bpf_verifier_env *env, int stack_=
depth)
+{
+	if (env->prog->jit_requested)
+		return round_up(stack_depth, 16);
+
+	/* round up to 32-bytes, since this is granularity
+	 * of interpreter stack size
+	 */
+	return round_up(max_t(u32, stack_depth, 1), 32);
+}
+
 /* starting from main bpf function walk all instructions of the function
  * and recursively walk all callees that given function can call.
  * Ignore jump and exit insns.
@@ -5855,10 +5866,7 @@ static int check_max_stack_depth_subprog(struct bp=
f_verifier_env *env, int idx)
 			depth);
 		return -EACCES;
 	}
-	/* round up to 32-bytes, since this is granularity
-	 * of interpreter stack size
-	 */
-	depth +=3D round_up(max_t(u32, subprog[idx].stack_depth, 1), 32);
+	depth +=3D round_up_stack_depth(env, subprog[idx].stack_depth);
 	if (depth > MAX_BPF_STACK) {
 		verbose(env, "combined stack size of %d calls is %d. Too large\n",
 			frame + 1, depth);
@@ -5952,7 +5960,7 @@ static int check_max_stack_depth_subprog(struct bpf=
_verifier_env *env, int idx)
 	 */
 	if (frame =3D=3D 0)
 		return 0;
-	depth -=3D round_up(max_t(u32, subprog[idx].stack_depth, 1), 32);
+	depth -=3D round_up_stack_depth(env, subprog[idx].stack_depth);
 	frame--;
 	i =3D ret_insn[frame];
 	idx =3D ret_prog[frame];
diff --git a/tools/testing/selftests/bpf/progs/async_stack_depth.c b/tool=
s/testing/selftests/bpf/progs/async_stack_depth.c
index 3517c0e01206..36734683acbd 100644
--- a/tools/testing/selftests/bpf/progs/async_stack_depth.c
+++ b/tools/testing/selftests/bpf/progs/async_stack_depth.c
@@ -30,7 +30,7 @@ static int bad_timer_cb(void *map, int *key, struct bpf=
_timer *timer)
 }
=20
 SEC("tc")
-__failure __msg("combined stack size of 2 calls is 576. Too large")
+__failure __msg("combined stack size of 2 calls is")
 int pseudo_call_check(struct __sk_buff *ctx)
 {
 	struct hmap_elem *elem;
@@ -45,7 +45,7 @@ int pseudo_call_check(struct __sk_buff *ctx)
 }
=20
 SEC("tc")
-__failure __msg("combined stack size of 2 calls is 608. Too large")
+__failure __msg("combined stack size of 2 calls is")
 int async_call_root_check(struct __sk_buff *ctx)
 {
 	struct hmap_elem *elem;
diff --git a/tools/testing/selftests/bpf/progs/test_global_func1.c b/tool=
s/testing/selftests/bpf/progs/test_global_func1.c
index 17a9f59bf5f3..fc69ff18880d 100644
--- a/tools/testing/selftests/bpf/progs/test_global_func1.c
+++ b/tools/testing/selftests/bpf/progs/test_global_func1.c
@@ -5,7 +5,7 @@
 #include <bpf/bpf_helpers.h>
 #include "bpf_misc.h"
=20
-#define MAX_STACK (512 - 3 * 32 + 8)
+#define MAX_STACK 260
=20
 static __attribute__ ((noinline))
 int f0(int var, struct __sk_buff *skb)
@@ -30,6 +30,10 @@ int f3(int, struct __sk_buff *skb, int);
 __attribute__ ((noinline))
 int f2(int val, struct __sk_buff *skb)
 {
+	volatile char buf[MAX_STACK] =3D {};
+
+	__sink(buf[MAX_STACK - 1]);
+
 	return f1(skb) + f3(val, skb, 1);
 }
=20
@@ -44,7 +48,7 @@ int f3(int val, struct __sk_buff *skb, int var)
 }
=20
 SEC("tc")
-__failure __msg("combined stack size of 4 calls is 544")
+__failure __msg("combined stack size of 3 calls is")
 int global_func1(struct __sk_buff *skb)
 {
 	return f0(1, skb) + f1(skb) + f2(2, skb) + f3(3, skb, 4);
--=20
2.39.3


