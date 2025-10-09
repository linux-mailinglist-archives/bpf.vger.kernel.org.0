Return-Path: <bpf+bounces-70674-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 7001DBC9F7B
	for <lists+bpf@lfdr.de>; Thu, 09 Oct 2025 18:07:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4D5CB4FE162
	for <lists+bpf@lfdr.de>; Thu,  9 Oct 2025 16:05:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3B722F8BFA;
	Thu,  9 Oct 2025 15:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RCKWNiRJ"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E0B42EF64C;
	Thu,  9 Oct 2025 15:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760025515; cv=none; b=XJorkoIbgGP5OznXd6KrHZckO3TwS0x3ak3AVzTWC+VwY44Ukv+y9UVpHzZOTBJki9BMw2Zv2mGh8G7+Tma9aA8LuZsd6hmznDA9OKsMh542UXgZMtm7UNB1gHntncYWZ2UOmtZPRxD0OKrbgu3fYidPs5c507oR1xfpcmc5tHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760025515; c=relaxed/simple;
	bh=1iRDjH71Xort7nzuEJ/Yj6ipa0Fw7mhO9+8jp/KYEQM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Fhs7a5WsJKLGmQCbtqcDUj+e5TMEWIeKZKeWdpdh+JitiqXVTOZGdC/8OWIC4dYGxfsdW0sV2GZMkVY3xLLtd0tiqUPBi/iuFdQKRbEe9P1NvTPIP27oITsKzFlx4iWZL+uG3eTgmEXRfFA0yhYJn+6A9G+cxDSXf9r9X2iBKO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RCKWNiRJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A65E7C4CEF7;
	Thu,  9 Oct 2025 15:58:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760025515;
	bh=1iRDjH71Xort7nzuEJ/Yj6ipa0Fw7mhO9+8jp/KYEQM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RCKWNiRJENLlbumPe7yr1G0RGPArbzW3csd8f7F0pVj3VqJIKTH+ZgRUDBPPUZiyV
	 q6xSZj8/XoDDEkvYKvq8YYkyCGCF0r3D8Tz22ZuKD2RTJFnn37ZtWVuaxE0ANI5WZu
	 uM00EMya8K51lRv+QTjimtwnwc0Eoh3OKB80hNgXGB4Q2x5GALt0Qo2V3tlhoOqOMe
	 wjdL21LUTlHdlXU1W5qjTenTLPA/hqsjcqfUcaCtgN+YhQp6ozECicAM+vj+QEbILf
	 T1TeaPH9NpqhVyQA5VheNIVt85/vOF8gLVDkYZXXWgDEIzEAaVl+KgilUP0HZYxkzg
	 fTdJRxKLDfx+w==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Yonghong Song <yonghong.song@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	nathan@kernel.org,
	memxor@gmail.com,
	andrii@kernel.org,
	emil@etsalapatis.com,
	bpf@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH AUTOSEL 6.17-6.12] selftests/bpf: Fix selftest verifier_arena_large failure
Date: Thu,  9 Oct 2025 11:54:50 -0400
Message-ID: <20251009155752.773732-24-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251009155752.773732-1-sashal@kernel.org>
References: <20251009155752.773732-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.17.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Yonghong Song <yonghong.song@linux.dev>

[ Upstream commit 5a427fddec5e76360725a0f03df3a2a003efbe2e ]

With latest llvm22, I got the following verification failure:

  ...
  ; int big_alloc2(void *ctx) @ verifier_arena_large.c:207
  0: (b4) w6 = 1                        ; R6_w=1
  ...
  ; if (err) @ verifier_arena_large.c:233
  53: (56) if w6 != 0x0 goto pc+62      ; R6=0
  54: (b7) r7 = -4                      ; R7_w=-4
  55: (18) r8 = 0x7f4000000000          ; R8_w=scalar()
  57: (bf) r9 = addr_space_cast(r8, 0, 1)       ; R8_w=scalar() R9_w=arena
  58: (b4) w6 = 5                       ; R6_w=5
  ; pg = page[i]; @ verifier_arena_large.c:238
  59: (bf) r1 = r7                      ; R1_w=-4 R7_w=-4
  60: (07) r1 += 4                      ; R1_w=0
  61: (79) r2 = *(u64 *)(r9 +0)         ; R2_w=scalar() R9_w=arena
  ; if (*pg != i) @ verifier_arena_large.c:239
  62: (bf) r3 = addr_space_cast(r2, 0, 1)       ; R2_w=scalar() R3_w=arena
  63: (71) r3 = *(u8 *)(r3 +0)          ; R3_w=scalar(smin=smin32=0,smax=umax=smax32=umax32=255,var_off=(0x0; 0xff))
  64: (5d) if r1 != r3 goto pc+51       ; R1_w=0 R3_w=0
  ; bpf_arena_free_pages(&arena, (void __arena *)pg, 2); @ verifier_arena_large.c:241
  65: (18) r1 = 0xff11000114548000      ; R1_w=map_ptr(map=arena,ks=0,vs=0)
  67: (b4) w3 = 2                       ; R3_w=2
  68: (85) call bpf_arena_free_pages#72675      ;
  69: (b7) r1 = 0                       ; R1_w=0
  ; page[i + 1] = NULL; @ verifier_arena_large.c:243
  70: (7b) *(u64 *)(r8 +8) = r1
  R8 invalid mem access 'scalar'
  processed 61 insns (limit 1000000) max_states_per_insn 0 total_states 6 peak_states 6 mark_read 2
  =============
  #489/5   verifier_arena_large/big_alloc2:FAIL

The main reason is that 'r8' in insn '70' is not an arena pointer.
Further debugging at llvm side shows that llvm commit ([1]) caused
the failure. For the original code:
  page[i] = NULL;
  page[i + 1] = NULL;
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
Link: https://lore.kernel.org/r/20250920045805.3288551-1-yonghong.song@linux.dev
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

YES

**Why this matters**
- Fixes a real, reproducible selftest failure with LLVM 22 where two
  adjacent pointer stores get optimized into a memset, breaking BPF
  verifier expectations and causing “R8 invalid mem access 'scalar'”
  during big_alloc2.
- Keeps BPF selftests reliable across toolchains without changing
  kernel/runtime behavior.

**What changed**
- Adds a single compiler barrier between two consecutive NULL
  assignments to break LLVM’s store-combining optimization:
  - Before: `page[i] = NULL;` immediately followed by `page[i + 1] =
    NULL;`
  - After: inserts `barrier();` between them to prevent transformation
    into `__builtin_memset(...)`.
- Location in tree:
  `tools/testing/selftests/bpf/progs/verifier_arena_large.c`
  - In the “Free pairs of pages” loop: after freeing 2 pages
    (`bpf_arena_free_pages`), the code does:
    - `page[i] = NULL;` at
      tools/testing/selftests/bpf/progs/verifier_arena_large.c:242
    - [PATCH] `barrier();` added between the two stores
    - `page[i + 1] = NULL;` at
      tools/testing/selftests/bpf/progs/verifier_arena_large.c:243
- The barrier macro is available via the already-included
  `bpf/bpf_helpers.h` (`barrier()` is defined as an empty inline asm
  memory clobber), used elsewhere in BPF selftests, and is safe for BPF.

**Root cause and effect**
- LLVM 22 transforms two adjacent stores into a 16-byte memset when it
  sees:
  - `page[i] = NULL;`
  - `page[i + 1] = NULL;`
- This prevents LLVM’s BPFCheckAndAdjustIR pass from inserting necessary
  `addr_space_cast` for arena pointers, leading to the verifier seeing a
  scalar pointer (R8) on the subsequent store and rejecting the program.
- The inserted `barrier()` prevents that transformation, ensuring LLVM
  keeps separate stores and the IR pass emits `addr_space_cast`, fixing
  the verifier error.

**Risk and scope**
- Minimal risk:
  - Single-line change in a selftest program.
  - No ABI changes, no functional changes to kernel subsystems.
  - Barrier only affects compiler optimization; runtime semantics remain
    identical.
- Selftest-only change:
  - Does not affect production kernel behavior.
  - Improves test robustness across compilers.

**Stable criteria fit**
- Important bugfix: prevents a deterministic selftest failure with a
  widely used toolchain (LLVM 22).
- Small and contained: one-line addition in a single selftest file.
- No architectural changes and no cross-subsystem impact.
- No side effects beyond keeping IR and verifier expectations aligned
  for this test.
- Even without an explicit “Cc: stable”, selftest fixes like this are
  commonly accepted to keep CI and developer workflows healthy across
  toolchains.

**Dependencies and compatibility**
- The code path is guarded by `__BPF_FEATURE_ADDR_SPACE_CAST` (see block
  starting at
  tools/testing/selftests/bpf/progs/verifier_arena_large.c:168), so it
  only builds where the feature is available, reducing risk on older
  compilers.
- `barrier()` is already defined for BPF programs via `bpf_helpers.h`,
  which is included at
  tools/testing/selftests/bpf/progs/verifier_arena_large.c:6, ensuring
  portability across supported clang versions.

Given the above, this is a low-risk, self-contained fix for a real
breakage in selftests caused by a compiler change. It should be
backported to stable trees that contain this selftest.

 tools/testing/selftests/bpf/progs/verifier_arena_large.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_arena_large.c b/tools/testing/selftests/bpf/progs/verifier_arena_large.c
index 9dbdf123542d3..f19e15400b3e1 100644
--- a/tools/testing/selftests/bpf/progs/verifier_arena_large.c
+++ b/tools/testing/selftests/bpf/progs/verifier_arena_large.c
@@ -240,6 +240,7 @@ int big_alloc2(void *ctx)
 			return 5;
 		bpf_arena_free_pages(&arena, (void __arena *)pg, 2);
 		page[i] = NULL;
+		barrier();
 		page[i + 1] = NULL;
 		cond_break;
 	}
-- 
2.51.0


