Return-Path: <bpf+bounces-76322-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DFE2CAE7C8
	for <lists+bpf@lfdr.de>; Tue, 09 Dec 2025 01:19:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8B66330C5B99
	for <lists+bpf@lfdr.de>; Tue,  9 Dec 2025 00:17:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87EC7222582;
	Tue,  9 Dec 2025 00:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RGC7K4TE"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB4E9221554;
	Tue,  9 Dec 2025 00:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765239423; cv=none; b=Dh2OzDU+QkOYv99KXCE+PIocOxG+2AhBQSzvnboB9Kf9OzMXKouXwueq/dXY2DZ7MZn8nh9P6cOjd2l5inkIQlNMLsjUiUM14PsN2yE8H132uIGaou197wL1JCFK0ic+eEeBj6kPF9pcn9Pt2rpbP18RmPGEVt4sG9sfVLde5go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765239423; c=relaxed/simple;
	bh=HQ0yU4ubZDH6sXSyIkS8w1UFtEGkWWNP/Gh2hOCim50=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PX0eA7sE0KfhE9hkXevnb0nxS9aJDhVxcH7LDcrrA8O72Jf6lGTrnX7jaPgEAQEz6Rgxf+p4VtmLAxv5thHBdsVIQd2kglUJMsl783qyWxkBaoBjt6uns6Gagfg1f7NA5A4JDcDbQpN4DsPQMLkB44a69vCqoqci1/t5L06o0Ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RGC7K4TE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A9DDC19421;
	Tue,  9 Dec 2025 00:17:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765239422;
	bh=HQ0yU4ubZDH6sXSyIkS8w1UFtEGkWWNP/Gh2hOCim50=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RGC7K4TEL1Dp/vfnUmRwCjTaetBbIcjqtaNQp/p2p4wEsRYr5OErneOINfp++gUkr
	 ZcEJhJOF7eOlev8dkyuNOfgvjHRtjq4AAR9RZJuX8dDmC1NJtmfY7Ub6kMw9SziIy+
	 DpsShmtartMLziaajHas3BaZppGa/h/S7r/RpRJUi9u/EDvZLw4bgdHEofVo5TMPo0
	 J0ra94stXqjvT51D0uHScrjqd6Q2RBohEBFcPNNbJHTOKJQXxv1BpUAtVwW2frpxTG
	 xU4b7X6PR4M3bsuZiTelnPYJDmORFk64QXjSTySxO06k3Q2ampsPoWXRlms18yrxs5
	 r7CEQJqHL4LwA==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: KaFai Wan <kafai.wan@linux.dev>,
	Kaiyan Mei <M202472210@hust.edu.cn>,
	Yinhao Hu <dddddd@hust.edu.cn>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	daniel@iogearbox.net,
	andrii@kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH AUTOSEL 6.18-6.12] bpf: Skip bounds adjustment for conditional jumps on same scalar register
Date: Mon,  8 Dec 2025 19:15:06 -0500
Message-ID: <20251209001610.611575-14-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251209001610.611575-1-sashal@kernel.org>
References: <20251209001610.611575-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.18
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: KaFai Wan <kafai.wan@linux.dev>

[ Upstream commit d43ad9da8052eda714caa38f243adbf32a8614cb ]

When conditional jumps are performed on the same scalar register
(e.g., r0 <= r0, r0 > r0, r0 < r0), the BPF verifier incorrectly
attempts to adjust the register's min/max bounds. This leads to
invalid range bounds and triggers a BUG warning.

The problematic BPF program:
   0: call bpf_get_prandom_u32
   1: w8 = 0x80000000
   2: r0 &= r8
   3: if r0 > r0 goto <exit>

The instruction 3 triggers kernel warning:
   3: if r0 > r0 goto <exit>
   true_reg1: range bounds violation u64=[0x1, 0x0] s64=[0x1, 0x0] u32=[0x1, 0x0] s32=[0x1, 0x0] var_off=(0x0, 0x0)
   true_reg2: const tnum out of sync with range bounds u64=[0x0, 0xffffffffffffffff] s64=[0x8000000000000000, 0x7fffffffffffffff] var_off=(0x0, 0x0)

Comparing a register with itself should not change its bounds and
for most comparison operations, comparing a register with itself has
a known result (e.g., r0 == r0 is always true, r0 < r0 is always false).

Fix this by:
1. Enhance is_scalar_branch_taken() to properly handle branch direction
   computation for same register comparisons across all BPF jump operations
2. Adds early return in reg_set_min_max() to avoid bounds adjustment
   for unknown branch directions (e.g., BPF_JSET) on the same register

The fix ensures that unnecessary bounds adjustments are skipped, preventing
the verifier bug while maintaining correct branch direction analysis.

Reported-by: Kaiyan Mei <M202472210@hust.edu.cn>
Reported-by: Yinhao Hu <dddddd@hust.edu.cn>
Closes: https://lore.kernel.org/all/1881f0f5.300df.199f2576a01.Coremail.kaiyanm@hust.edu.cn/
Signed-off-by: KaFai Wan <kafai.wan@linux.dev>
Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Link: https://lore.kernel.org/r/20251103063108.1111764-2-kafai.wan@linux.dev
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

Now I have a complete picture. Let me do a comprehensive summary and
analysis:

## Complete Analysis

### 1. COMMIT MESSAGE ANALYSIS

**Subject:** "bpf: Skip bounds adjustment for conditional jumps on same
scalar register"

**Key indicators:**
- **Fix keyword:** The commit message clearly describes a bug fix
  ("incorrectly attempts", "invalid range bounds", "triggers a BUG
  warning")
- **No stable tag:** The commit does not have explicit "Cc:
  stable@vger.kernel.org"
- **No Fixes: tag:** No explicit Fixes: tag pointing to a prior commit
- **Reported-by tags:** The commit has two "Reported-by:" tags and a
  "Closes:" link to a lore.kernel.org bug report
- **Acked-by:** Eduard Zingerman (BPF maintainer) acknowledged this fix
- **Merged by:** Alexei Starovoitov (BPF maintainer) signed off

The commit message describes:
1. When comparing a register with itself (e.g., `r0 > r0`), the verifier
   incorrectly adjusts bounds
2. This leads to invalid range bounds (umin > umax, etc.)
3. Triggers the `reg_bounds_sanity_check()` BUG warning

### 2. CODE CHANGE ANALYSIS

**Files changed:** 1 file (`kernel/bpf/verifier.c`)

**Two modifications:**

**Modification 1 - `is_scalar_branch_taken()` (lines 15996-16020 in
diff):**
Adds a new code block at the beginning of the function to handle same-
register comparisons:

```c
if (reg1 == reg2) {
    switch (opcode) {
    case BPF_JGE:
    case BPF_JLE:
    case BPF_JSGE:
    case BPF_JSLE:
    case BPF_JEQ:
        return 1;  /* Always true: r0 >= r0, r0 <= r0, r0 == r0 */
    case BPF_JGT:
    case BPF_JLT:
    case BPF_JSGT:
    case BPF_JSLT:
    case BPF_JNE:
        return 0;  /* Always false: r0 > r0, r0 < r0, r0 != r0 */
    case BPF_JSET:
        if (tnum_is_const(t1))
            return t1.value != 0;
        else
            return (smin1 <= 0 && smax1 >= 0) ? -1 : 1;
    default:
        return -1;
    }
}
```

This correctly determines branch direction for same-register
comparisons:
- `r0 == r0`, `r0 >= r0`, `r0 <= r0` are always true (return 1)
- `r0 > r0`, `r0 < r0`, `r0 != r0` are always false (return 0)
- `r0 JSET r0` depends on whether any bits are set

**Modification 2 - `reg_set_min_max()` (lines 16446-16452 in diff):**
Adds early return when both register arguments point to the same memory:

```c
/* We compute branch direction for same SCALAR_VALUE registers in
 - is_scalar_branch_taken(). For unknown branch directions (e.g.,
   BPF_JSET)
 - on the same registers, we don't need to adjust the min/max values.
 */
if (false_reg1 == false_reg2)
    return 0;
```

This prevents `regs_refine_cond_op()` from corrupting bounds when called
with the same pointer for both registers.

### 3. ROOT CAUSE OF THE BUG

When a BPF program compares a register with itself (e.g., `if r0 > r0`):

1. In `check_cond_jmp_op()`, both `dst_reg` and `src_reg` point to the
   same `bpf_reg_state` in memory because `&regs[insn->dst_reg] ==
   &regs[insn->src_reg]`

2. If `is_branch_taken()` returns -1 (unknown), `reg_set_min_max()` is
   called

3. `regs_refine_cond_op()` is then called with `reg1 == reg2` (same
   pointer)

4. For `BPF_JGT` (which becomes `BPF_JLT` after `flip_opcode`), the code
   does:
  ```c
  reg1->umax_value = min(reg1->umax_value, reg2->umax_value - 1);
  reg2->umin_value = max(reg1->umin_value + 1, reg2->umin_value);
  ```

  Since `reg1 == reg2`, this becomes:
   - First line: `reg->umax_value = reg->umax_value - 1` (decreases max)
   - Second line reads the already-decreased `umax_value`, then:
     `reg->umin_value = max(reg->umin_value + 1, reg->umin_value)`
     (increases min)

5. This results in `umin_value > umax_value`, which is an invalid range!

6. `reg_bounds_sanity_check()` detects this and triggers a BUG warning

### 4. CLASSIFICATION

- **Type:** Bug fix
- **Security impact:** Not a CVE, but triggers BUG (kernel
  warning/crash) - denial of service by unprivileged users (if
  unprivileged BPF is enabled)
- **Exception categories:** None (this is a straightforward bug fix, not
  a device ID, quirk, DT update, or build fix)

### 5. SCOPE AND RISK ASSESSMENT

- **Lines changed:** ~30 new lines of code
- **Files touched:** 1 file (`kernel/bpf/verifier.c`)
- **Complexity:** Low - adds early return checks for pointer equality
- **Subsystem:** BPF verifier (core BPF infrastructure)
- **Risk of regression:** Low - the changes are defensive checks that
  prevent invalid states

**Why low risk:**
1. The `reg1 == reg2` check is a simple pointer comparison
2. The logic for determining branch direction when comparing a register
   with itself is mathematically correct
3. The early return in `reg_set_min_max()` prevents unnecessary
   processing, not actual verification

### 6. USER IMPACT

**Who is affected:**
- Any system running BPF programs that compare a register with itself
- The triggering program is simple and can be crafted by any user with
  BPF access
- Systems with unprivileged BPF enabled are at higher risk (denial of
  service)

**Severity:**
- Triggers kernel BUG warning (can cause system instability)
- `reg_bounds_sanity_check()` calls `verifier_bug()` which prints
  warnings and may affect system stability
- The verifier marks the register as unbounded after the bug, which
  could potentially lead to incorrect verification

**Bug trigger:**
The commit message shows a simple 4-instruction BPF program that
triggers the bug:
```
0: call bpf_get_prandom_u32
1: w8 = 0x80000000
2: r0 &= r8
3: if r0 > r0 goto <exit>
```

### 7. STABILITY INDICATORS

- **Tested-by:** No explicit tested-by, but tested as part of the bug
  report
- **Reviewed/Acked-by:** Eduard Zingerman (BPF maintainer)
- **Signed-off-by:** Alexei Starovoitov (BPF co-maintainer)
- **Time in mainline:** This is a relatively new commit

### 8. DEPENDENCY CHECK

**Dependencies:**
- The fix depends on `reg_bounds_sanity_check()` which was added in v6.8
  (commit 5f99f312bd3be)
- Without the sanity check, the bug would silently corrupt bounds
  (worse!)
- The underlying bug in `is_scalar_branch_taken()` and
  `reg_set_min_max()` has existed since v5.0

**Affected versions:**
- The visible bug (BUG warning) affects kernels ≥ v6.8 (when sanity
  check was added)
- The silent bounds corruption affects all kernels since v5.0

### 9. BACKPORT CONSIDERATIONS

**Should be backported to:** v6.8, v6.6 (LTS), and later stable trees

**Reasons:**
1. Fixes a real, reproducible bug that triggers kernel warnings
2. Small, surgical fix with clear scope
3. Low regression risk
4. Affects core BPF infrastructure used widely
5. Easy to trigger with a simple BPF program
6. Has maintainer acknowledgment

**Backport notes:**
- The patch should apply cleanly to v6.8+ where
  `reg_bounds_sanity_check()` exists
- For v6.6 LTS, need to verify if the sanity check was backported
- For older stable trees (v5.15, v5.10, etc.), the sanity check doesn't
  exist, so the bug manifests as silent bounds corruption which is
  arguably worse but harder to detect

### CONCLUSION

This commit fixes a real BPF verifier bug that:
1. Is easily reproducible with a simple BPF program
2. Triggers kernel BUG warnings (denial of service potential)
3. Has a small, well-contained fix
4. Has been acknowledged by BPF maintainers
5. Affects commonly-used infrastructure (BPF verifier)

The fix is obviously correct - comparing a register with itself should
have deterministic results (e.g., r0 == r0 is always true), and
adjusting bounds based on such comparisons is logically wrong.

**YES**

 kernel/bpf/verifier.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index fbe4bb91c564a..515e4d1807c92 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -15950,6 +15950,30 @@ static int is_scalar_branch_taken(struct bpf_reg_state *reg1, struct bpf_reg_sta
 	s64 smin2 = is_jmp32 ? (s64)reg2->s32_min_value : reg2->smin_value;
 	s64 smax2 = is_jmp32 ? (s64)reg2->s32_max_value : reg2->smax_value;
 
+	if (reg1 == reg2) {
+		switch (opcode) {
+		case BPF_JGE:
+		case BPF_JLE:
+		case BPF_JSGE:
+		case BPF_JSLE:
+		case BPF_JEQ:
+			return 1;
+		case BPF_JGT:
+		case BPF_JLT:
+		case BPF_JSGT:
+		case BPF_JSLT:
+		case BPF_JNE:
+			return 0;
+		case BPF_JSET:
+			if (tnum_is_const(t1))
+				return t1.value != 0;
+			else
+				return (smin1 <= 0 && smax1 >= 0) ? -1 : 1;
+		default:
+			return -1;
+		}
+	}
+
 	switch (opcode) {
 	case BPF_JEQ:
 		/* constants, umin/umax and smin/smax checks would be
@@ -16396,6 +16420,13 @@ static int reg_set_min_max(struct bpf_verifier_env *env,
 	if (false_reg1->type != SCALAR_VALUE || false_reg2->type != SCALAR_VALUE)
 		return 0;
 
+	/* We compute branch direction for same SCALAR_VALUE registers in
+	 * is_scalar_branch_taken(). For unknown branch directions (e.g., BPF_JSET)
+	 * on the same registers, we don't need to adjust the min/max values.
+	 */
+	if (false_reg1 == false_reg2)
+		return 0;
+
 	/* fallthrough (FALSE) branch */
 	regs_refine_cond_op(false_reg1, false_reg2, rev_opcode(opcode), is_jmp32);
 	reg_bounds_sync(false_reg1);
-- 
2.51.0


