Return-Path: <bpf+bounces-69086-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 122A5B8BF72
	for <lists+bpf@lfdr.de>; Sat, 20 Sep 2025 06:58:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A1CFD1C03EED
	for <lists+bpf@lfdr.de>; Sat, 20 Sep 2025 04:58:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F63722652D;
	Sat, 20 Sep 2025 04:58:23 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from 69-171-232-181.mail-mxout.facebook.com (69-171-232-181.mail-mxout.facebook.com [69.171.232.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02A7B2F872
	for <bpf@vger.kernel.org>; Sat, 20 Sep 2025 04:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=69.171.232.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758344302; cv=none; b=WshRE6VXr9fKFScx+CGy+v5gDd1RI3v2sNTtx1zH29gaw3Rvm6YghJAdxgd8TU7xlU8e+nBYMBfzTwgfJFPjGK1tchtGP6njsAzkgoZY4jFY2BAtcwMvquZ7Zxa33Kw6ftLEz3VxdAhz2xEuJWEJrX571bJvHtiqnlucNvsLIx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758344302; c=relaxed/simple;
	bh=u6OOuLBE6v6wViD8SVkyzeKDSdt28GwjOQSCslc/5Z4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=scK9+wx7KGdn62xU7by97OZ7ZnW62y4Nh8vzpeiL7Q1rfuAOtgYs1lcDQGhO603+RTyhtvZ5xevVeK7PzAd2XJRs74mZWCmfk6VDGd/X+/kpl6IxdUp4mtcv58hAGPOdjDuuYRuq1u/DOjGdkQiY/p79zJDQ3gj58eNZL5lBFGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=69.171.232.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id 00CBC10881060; Fri, 19 Sep 2025 21:58:05 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next] selftests/bpf: Fix selftest verifier_arena_large failure
Date: Fri, 19 Sep 2025 21:58:05 -0700
Message-ID: <20250920045805.3288551-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

With latest llvm22, I got the following verification failure:

  ...
  ; int big_alloc2(void *ctx) @ verifier_arena_large.c:207
  0: (b4) w6 =3D 1                        ; R6_w=3D1
  ...
  ; if (err) @ verifier_arena_large.c:233
  53: (56) if w6 !=3D 0x0 goto pc+62      ; R6=3D0
  54: (b7) r7 =3D -4                      ; R7_w=3D-4
  55: (18) r8 =3D 0x7f4000000000          ; R8_w=3Dscalar()
  57: (bf) r9 =3D addr_space_cast(r8, 0, 1)       ; R8_w=3Dscalar() R9_w=3D=
arena
  58: (b4) w6 =3D 5                       ; R6_w=3D5
  ; pg =3D page[i]; @ verifier_arena_large.c:238
  59: (bf) r1 =3D r7                      ; R1_w=3D-4 R7_w=3D-4
  60: (07) r1 +=3D 4                      ; R1_w=3D0
  61: (79) r2 =3D *(u64 *)(r9 +0)         ; R2_w=3Dscalar() R9_w=3Darena
  ; if (*pg !=3D i) @ verifier_arena_large.c:239
  62: (bf) r3 =3D addr_space_cast(r2, 0, 1)       ; R2_w=3Dscalar() R3_w=3D=
arena
  63: (71) r3 =3D *(u8 *)(r3 +0)          ; R3_w=3Dscalar(smin=3Dsmin32=3D=
0,smax=3Dumax=3Dsmax32=3Dumax32=3D255,var_off=3D(0x0; 0xff))
  64: (5d) if r1 !=3D r3 goto pc+51       ; R1_w=3D0 R3_w=3D0
  ; bpf_arena_free_pages(&arena, (void __arena *)pg, 2); @ verifier_arena=
_large.c:241
  65: (18) r1 =3D 0xff11000114548000      ; R1_w=3Dmap_ptr(map=3Darena,ks=
=3D0,vs=3D0)
  67: (b4) w3 =3D 2                       ; R3_w=3D2
  68: (85) call bpf_arena_free_pages#72675      ;
  69: (b7) r1 =3D 0                       ; R1_w=3D0
  ; page[i + 1] =3D NULL; @ verifier_arena_large.c:243
  70: (7b) *(u64 *)(r8 +8) =3D r1
  R8 invalid mem access 'scalar'
  processed 61 insns (limit 1000000) max_states_per_insn 0 total_states 6=
 peak_states 6 mark_read 2
  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
  #489/5   verifier_arena_large/big_alloc2:FAIL

The main reason is that 'r8' in insn '70' is not an arena pointer.
Further debugging at llvm side shows that llvm commit ([1]) caused
the failure. For the original code:
  page[i] =3D NULL;
  page[i + 1] =3D NULL;
the llvm transformed it to something like below at source level:
  __builtin_memset(&page[i], 0, 16)
Such transformation prevents llvm BPFCheckAndAdjustIR pass from
generating proper addr_space_cast insns ([2]).

Adding support in llvm BPFCheckAndAdjustIR pass should work, but
not sure that such a pattern exists or not in real applications.
At the same time, simply adding a memory barrier between two 'page'
assignment can fix the issue.

  [1] https://github.com/llvm/llvm-project/pull/155415
  [2] https://github.com/llvm/llvm-project/pull/84410

Cc: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 tools/testing/selftests/bpf/progs/verifier_arena_large.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_arena_large.c b/t=
ools/testing/selftests/bpf/progs/verifier_arena_large.c
index 9dbdf123542d..f19e15400b3e 100644
--- a/tools/testing/selftests/bpf/progs/verifier_arena_large.c
+++ b/tools/testing/selftests/bpf/progs/verifier_arena_large.c
@@ -240,6 +240,7 @@ int big_alloc2(void *ctx)
 			return 5;
 		bpf_arena_free_pages(&arena, (void __arena *)pg, 2);
 		page[i] =3D NULL;
+		barrier();
 		page[i + 1] =3D NULL;
 		cond_break;
 	}
--=20
2.47.3


