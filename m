Return-Path: <bpf+bounces-70684-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 10007BCA1A1
	for <lists+bpf@lfdr.de>; Thu, 09 Oct 2025 18:17:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 942834FD5F7
	for <lists+bpf@lfdr.de>; Thu,  9 Oct 2025 16:10:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A41572FD1A3;
	Thu,  9 Oct 2025 16:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tKXOtb6n"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22F7C2FCBF7;
	Thu,  9 Oct 2025 16:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760025678; cv=none; b=YW9DOGxRgAYkdYWDPO1QBuXjkRQN5x95wUlSzVgAZUdQO4arHS/3H50CR5K2tc1PnqqrQQm6hJw/ryBdnfQv86qFWkOgIJHxDiLtg96QuRBhH74mcKZ0oC+h8sbxH1/9ZFP7dLjkXyDOdEx2cyM2wAFodkP+Tk2Nbm3HGd9jbeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760025678; c=relaxed/simple;
	bh=bihbgTF2TGoEjbEUqXNjtSwj7Jb47wUUHQ4FbuwxonM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Gu/3oC/AewPy9FegZNAyInA37OAVV/VR7mMd6wgkC7t3LDx4nGq8sicmu1XWrSQdnN/ngliZDKMZ01jO0zNUgeTYxiimtecRyljQfPxmX3MaPY8Pu13m8JTVryw1aFRKmIu24XGNTegzzZe8ghYR9LoCjQemHk1WfBi4DJZMs2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tKXOtb6n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D032C4CEE7;
	Thu,  9 Oct 2025 16:01:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760025678;
	bh=bihbgTF2TGoEjbEUqXNjtSwj7Jb47wUUHQ4FbuwxonM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tKXOtb6nZrffDbmZT2j2Y88POvOYV/cdH4HiXEsFJV5CKq8kL8Kbszq4lUnxjpsS3
	 GgOlTRSBQuK3WmqsfU8UY6JvFOKyh3syZ00aoQ3qNVi+NqT18w5I1WdRDclbKrU69I
	 ubIzbVC+cXVFsrYdfqPDjurVmQkysRgtbNueXF9Plhc6s4V8xdIzxeq390/QZaxCkm
	 0r5hzDAQkvr4hCGxbSvo6p7lQH9aOzMQL9uXx1vrLhIa6kg5kHmA+IelOahz8zzwqq
	 vBLCQk9XOW6NeqnCmQ+9GJtQHzx6jjfDFO2v1NZqDgUwIXjzF2kdYWbHlCR+GxG9Ne
	 LvQiJETAWt8tA==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Chenghao Duan <duanchenghao@kylinos.cn>,
	Pu Lehui <pulehui@huawei.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	daniel@iogearbox.net,
	andrii@kernel.org,
	bjorn@kernel.org,
	pjw@kernel.org,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	bpf@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: [PATCH AUTOSEL 6.17-6.6] riscv: bpf: Fix uninitialized symbol 'retval_off'
Date: Thu,  9 Oct 2025 11:56:16 -0400
Message-ID: <20251009155752.773732-110-sashal@kernel.org>
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

From: Chenghao Duan <duanchenghao@kylinos.cn>

[ Upstream commit d0bf7cd5df18466d969bb60e8890b74cf96081ca ]

In the __arch_prepare_bpf_trampoline() function, retval_off is only
meaningful when save_ret is true, so the current logic is correct.
However, in the original logic, retval_off is only initialized under
certain conditions; for example, in the fmod_ret logic, the compiler is
not aware that the flags of the fmod_ret program (prog) have set
BPF_TRAMP_F_CALL_ORIG, which results in an uninitialized symbol
compilation warning.

So initialize retval_off unconditionally to fix it.

Signed-off-by: Chenghao Duan <duanchenghao@kylinos.cn>
Reviewed-by: Pu Lehui <pulehui@huawei.com>
Link: https://lore.kernel.org/r/20250922062244.822937-2-duanchenghao@kylinos.cn
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

YES

- What changed: The patch moves `retval_off = stack_size;` out of the
  `if (save_ret)` block so it’s always initialized. Previously
  `retval_off` was only assigned when `save_ret` was true.
  - Before: `retval_off` assigned only inside `if (save_ret) { ... }`
  - After: `retval_off` assigned unconditionally immediately after the
    optional `stack_size += 16`
  - Reference: arch/riscv/net/bpf_jit_comp64.c:1066

- Why it matters: `retval_off` is used in code paths not explicitly
  guarded by `save_ret`, which makes compilers think it can be used
  uninitialized and emit a warning (e.g., -Wmaybe-uninitialized), even
  though, logically, those paths only occur with flags that imply
  `save_ret` must be true.
  - Unconditional uses in fmod_ret path:
    - Zeroing return value slot: arch/riscv/net/bpf_jit_comp64.c:1157
    - Loading return value: arch/riscv/net/bpf_jit_comp64.c:1163
  - Unconditional uses in call-orig path:
    - Store original function’s return in reserved slot:
      arch/riscv/net/bpf_jit_comp64.c:1176
    - Store BPF R0: arch/riscv/net/bpf_jit_comp64.c:1177
  - Final restore guarded by `save_ret`, confirming the semantic intent:
    arch/riscv/net/bpf_jit_comp64.c:1209

- Bug scope and user impact:
  - This is a build correctness fix that eliminates spurious “maybe-
    uninitialized” warnings that can be promoted to errors in some
    configurations or toolchains. It does not change runtime behavior
    because the only meaningful use of `retval_off` (e.g., restoring
    return values) is already guarded by `save_ret`. When `save_ret` is
    false, `retval_off`’s value is ignored by the logic that matters.
  - The warning can affect users building with stricter warning settings
    or newer compilers; resolving it improves build reliability for
    RISC-V with BPF trampolines.

- Containment and risk:
  - The change is tiny and contained to a single file/function in the
    RISC-V BPF JIT trampoline.
  - No new features, APIs, or architectural changes; no functional logic
    changed for valid flag combinations.
  - Safe even if misused flags were ever passed: `retval_off` now has a
    defined value, avoiding UB from uninitialized use.

- Applicability to stable trees:
  - The affected pattern exists in stable series that have the RISC-V
    BPF trampoline (e.g., v6.6 shows the same conditional
    initialization, with unconditional uses later). See v6.6 code where
    `retval_off` is only set under `if (save_ret)` and is used in the
    fmod_ret block and call-orig sequence without an explicit `save_ret`
    guard, mirroring the warning scenario.
  - Mainline commit: d0bf7cd5df184 (“riscv: bpf: Fix uninitialized
    symbol 'retval_off'”).
  - Likely Fixes: 25ad10658dc10 (“riscv, bpf: Adapt bpf trampoline to
    optimized riscv ftrace framework”), which introduced the trampoline
    structure that uses `retval_off` this way.

- Stable criteria check:
  - Fixes a real build issue (warnings that can become errors).
  - Small, self-contained change in one function and one file.
  - No functional side effects; does not alter behavior except removing
    undefined initialization state.
  - Not a feature or refactor; low regression risk; localized to RISC-V
    BPF trampoline.

Conclusion: This is a good and safe candidate for backporting to all
stable trees that include the RISC-V BPF trampoline code path (e.g.,
6.6.y and newer where applicable).

 arch/riscv/net/bpf_jit_comp64.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/riscv/net/bpf_jit_comp64.c b/arch/riscv/net/bpf_jit_comp64.c
index 9883a55d61b5b..8475a8ab57151 100644
--- a/arch/riscv/net/bpf_jit_comp64.c
+++ b/arch/riscv/net/bpf_jit_comp64.c
@@ -1079,10 +1079,9 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im,
 	stack_size += 16;
 
 	save_ret = flags & (BPF_TRAMP_F_CALL_ORIG | BPF_TRAMP_F_RET_FENTRY_RET);
-	if (save_ret) {
+	if (save_ret)
 		stack_size += 16; /* Save both A5 (BPF R0) and A0 */
-		retval_off = stack_size;
-	}
+	retval_off = stack_size;
 
 	stack_size += nr_arg_slots * 8;
 	args_off = stack_size;
-- 
2.51.0


