Return-Path: <bpf+bounces-75159-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id D264DC73E75
	for <lists+bpf@lfdr.de>; Thu, 20 Nov 2025 13:11:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 393A2353C43
	for <lists+bpf@lfdr.de>; Thu, 20 Nov 2025 12:09:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C052A3321D0;
	Thu, 20 Nov 2025 12:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lPYUEP0+"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 349EC3321B3;
	Thu, 20 Nov 2025 12:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763640545; cv=none; b=aeme+HK+14bxJ4S5R9yjlseeU6G0OmDDX2AzPK5kMi4T3EvP3yTwKx5w1Msiz9xsQIPSLXQTz250qACKv7cSdpAlfbeBduTgf6RjkXM6N4KAGYvuE6N5TISztcLzKMy12g8lKwfE2Q6W6iC3jrmA0H6LG2ZMz0PoQ8NosevU9+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763640545; c=relaxed/simple;
	bh=er+N64HiCFnnKCQWTgMhP3huAK297jwVKx9StqhKXCQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oYR5g1gEzRBv6acphmUrAsLbnOm1U20z4JX1xixlM3coYR1LYL1ZGlHyJ4SY12t2bHp+WZeA1AaCmYFUN1mTDuVPN4iKmYG6ssPK4zLMnJY3Y6e5TqwxWCMZ4xvCqd2PsoFNXJ/7IpuvoCmGwgoS5nGuMS6fktFXk0Ik/hRK/u8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lPYUEP0+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4E55C4CEF1;
	Thu, 20 Nov 2025 12:09:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763640545;
	bh=er+N64HiCFnnKCQWTgMhP3huAK297jwVKx9StqhKXCQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lPYUEP0+N1vJ65Gz/SOTmmJOKUa1NwAiMqX6NoT8Wwnb+v4YPqSPkFBZPqtPuolUd
	 A3g6bdsW+F4emkgqv6jsxupE/6C+gdr+FXGICZh7jQ8rFKC1VrDHLn+BEzA+oq7Hhx
	 HKEHpdTS1BLDi7jpgZbbYzQxEtm7kRVo4kRGy8WWohYM+HKrVlROgvaSUmFyVpma0t
	 4vEECdpg845ICgjF1kvKWGPks3npe4FCVlbDrEQ//uhzIwnKOv8TYpUCOf3Yq7CaCd
	 0ceAHKDX/8wHG9WkfwLAdZIq9vKjcD4oL0NMTY4UrCE+EhDweylTlBz2qcgiGq/MUa
	 8IJGAhONWsB6w==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Song Liu <song@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	"Steven Rostedt (Google)" <rostedt@goodmis.org>,
	Sasha Levin <sashal@kernel.org>,
	mhiramat@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH AUTOSEL 6.17-6.1] ftrace: bpf: Fix IPMODIFY + DIRECT in modify_ftrace_direct()
Date: Thu, 20 Nov 2025 07:08:23 -0500
Message-ID: <20251120120838.1754634-14-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251120120838.1754634-1-sashal@kernel.org>
References: <20251120120838.1754634-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.17.8
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Song Liu <song@kernel.org>

[ Upstream commit 3e9a18e1c3e931abecf501cbb23d28d69f85bb56 ]

ftrace_hash_ipmodify_enable() checks IPMODIFY and DIRECT ftrace_ops on
the same kernel function. When needed, ftrace_hash_ipmodify_enable()
calls ops->ops_func() to prepare the direct ftrace (BPF trampoline) to
share the same function as the IPMODIFY ftrace (livepatch).

ftrace_hash_ipmodify_enable() is called in register_ftrace_direct() path,
but not called in modify_ftrace_direct() path. As a result, the following
operations will break livepatch:

1. Load livepatch to a kernel function;
2. Attach fentry program to the kernel function;
3. Attach fexit program to the kernel function.

After 3, the kernel function being used will not be the livepatched
version, but the original version.

Fix this by adding __ftrace_hash_update_ipmodify() to
__modify_ftrace_direct() and adjust some logic around the call.

Signed-off-by: Song Liu <song@kernel.org>
Reviewed-by: Jiri Olsa <jolsa@kernel.org>
Link: https://lore.kernel.org/r/20251027175023.1521602-3-song@kernel.org
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Acked-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

## COMPREHENSIVE ANALYSIS: ftrace: bpf: Fix IPMODIFY + DIRECT in
modify_ftrace_direct()

### 1. COMMIT MESSAGE ANALYSIS

This commit fixes a critical bug in the interaction between ftrace
IPMODIFY (livepatching) and DIRECT (BPF trampolines) operations. The
commit message clearly describes:

**Problem**: `ftrace_hash_ipmodify_enable()` is called in the
`register_ftrace_direct()` path but **NOT** in the
`modify_ftrace_direct()` path. This asymmetry causes livepatch to break
when BPF programs are attached in a specific sequence.

**Bug scenario**:
1. Load livepatch to a kernel function (IPMODIFY set)
2. Attach fentry program (works - register path has the check)
3. Attach fexit program (breaks - modify path missing the check)
4. Result: Function executes original code, **bypassing the livepatch**

**Fix**: Add `__ftrace_hash_update_ipmodify()` to
`__modify_ftrace_direct()` with appropriate logic adjustments.

**Key observations**:
- NO "Fixes:" tag (but bug origin is clear: commit 53cd885bc5c3e from
  v6.0)
- NO "Cc: stable@vger.kernel.org" tag (unusual for a bug fix)
- Part of a 2-patch series (companion commit 56b3c85e153b8 **does have**
  "Cc: stable@vger.kernel.org # v6.6+")
- Multiple maintainer acknowledgments: Reviewed-by Jiri Olsa, Acked-by
  Steven Rostedt, Signed-off-by Alexei Starovoitov

### 2. DEEP CODE RESEARCH

#### Bug Introduction History

I traced the bug to **commit 53cd885bc5c3e** (July 2022, merged in
v6.0-rc1):
- "ftrace: Allow IPMODIFY and DIRECT ops on the same function"
- This commit introduced the mechanism for livepatch and BPF trampolines
  to coexist on the same function
- It added `ops_func()` callbacks that get invoked to coordinate between
  IPMODIFY and DIRECT operations
- The register path correctly calls `ftrace_hash_ipmodify_enable()`
  which invokes this callback
- **The modify path was missing this check from day one**

#### Technical Mechanism of the Bug

**IPMODIFY** (used by livepatching): Modifies function entry points to
redirect to patched code
**DIRECT** (used by BPF): Directly calls custom trampolines (BPF
programs)

When both are on the same function, they must cooperate:
- The ftrace core calls `ops->ops_func(ops,
  FTRACE_OPS_CMD_ENABLE_SHARE_IPMODIFY_SELF)`
- This tells the BPF trampoline to set `BPF_TRAMP_F_SHARE_IPMODIFY` flag
- With this flag, BPF generates trampolines with
  `BPF_TRAMP_F_ORIG_STACK` to preserve livepatch behavior
- Without this coordination, the BPF trampoline jumps to the original
  function, **bypassing the livepatch**

**The bug**: In `__modify_ftrace_direct()` (lines 6107-6154 in current
code):
```c
static int __modify_ftrace_direct(struct ftrace_ops *ops, unsigned long
addr)
{
    // ... registers tmp_ops ...
    err = register_ftrace_function_nolock(&tmp_ops);
    // BUG: No call to __ftrace_hash_update_ipmodify() here!
    // ... updates direct call addresses ...
    unregister_ftrace_function(&tmp_ops);
}
```

The function modifies where direct calls jump to, but never checks if
there's an IPMODIFY conflict requiring coordination.

#### The Fix in Detail

The patch makes these changes:

1. **Adds new parameter to `__ftrace_hash_update_ipmodify()`**: `bool
   update_target`
   - When `false`: Only checks differences between old_hash and new_hash
     (existing behavior)
   - When `true`: Processes all entries even if old_hash == new_hash
     (needed for modify case)

2. **Updates the check logic** (lines 2007-2011):
```c
// OLD: Skip if no difference
if (in_old == in_new)
    continue;

// NEW: Skip only if not updating target AND no difference
if (!update_target && (in_old == in_new))
    continue;
```

3. **Fixes FTRACE_WARN_ON condition** (lines 2024-2034): Makes it aware
   that `update_target` scenario is valid

4. **Adds the missing call in `__modify_ftrace_direct()`** (lines
   6147-6157):
```c
err = register_ftrace_function_nolock(&tmp_ops);
if (err)
    return err;

// NEW: Call the check that was missing!
err = __ftrace_hash_update_ipmodify(ops, hash, hash, true);
if (err)
    goto out;
```

5. **Updates all existing callers** to pass `false` for backward
   compatibility

#### Why This Works

When `modify_ftrace_direct()` is called:
- It passes `old_hash == new_hash` because it's not changing which
  functions to trace, just where to jump
- With `update_target=true`, the code processes all entries anyway
- This triggers `ops->ops_func(ops,
  FTRACE_OPS_CMD_ENABLE_SHARE_IPMODIFY_SELF)` if needed
- The BPF trampoline updates its flags and regenerates with proper
  livepatch support
- The livepatch is no longer bypassed

### 3. SECURITY ASSESSMENT

**Severity: HIGH**

This is a **security-relevant correctness bug**:
- Livepatching is commonly used to apply **security fixes** without
  rebooting
- Silently bypassing a livepatch means security vulnerabilities remain
  exploitable
- Users have no indication that their security patch isn't working
- Affects production systems running observability tools (BPF) alongside
  security patching

**Attack scenario**:
1. Admin applies critical security livepatch
2. Observability team runs BPF tracing (fentry/fexit)
3. Livepatch silently stops working
4. System remains vulnerable to the security issue the livepatch was
   meant to fix

**No CVE mentioned**, but this is the type of issue that could warrant
one.

### 4. FEATURE VS BUG FIX CLASSIFICATION

**Unambiguously a BUG FIX**:
- Fixes broken functionality (livepatch bypass)
- No new features added
- Restores expected behavior (livepatch should work with BPF)
- Keywords: "Fix", "broken", specific bug scenario described

### 5. CODE CHANGE SCOPE ASSESSMENT

**Small and surgical**:
- Single file: `kernel/trace/ftrace.c`
- ~40 lines changed (net +18 lines)
- Changes:
  - Add one parameter to existing function
  - Update 4 call sites to pass `false` (maintains existing behavior)
  - Add one new call in `__modify_ftrace_direct()`
  - Update comments and conditional logic
  - Add error handling path
- **No new APIs, no exported symbol changes, no ABI impact**

### 6. BUG TYPE AND SEVERITY

**Type**: Logic error / Missing check
**Severity**: **HIGH**
- **Impact**: Security patches silently bypassed
- **Triggering**: Specific but realistic sequence (livepatch + BPF
  fentry/fexit)
- **Detection**: Silent failure (no error, no warning to user)
- **Consequences**: System remains vulnerable after applying security
  patches

### 7. USER IMPACT EVALUATION

**Affected users**:
- **High-security environments** using livepatching for security updates
- **Cloud providers** running observability (BPF) on production systems
- **Enterprise Linux users** (RHEL, SLES, Ubuntu LTS) who rely on
  livepatching
- **Any system** combining livepatch with BPF tracing tools (bpftrace,
  bcc, etc.)

**Impact scope**:
- Moderate likelihood: Both livepatch and BPF are common, but the
  specific sequence (attach fentry then fexit) is less common
- High consequence: When it happens, security is compromised
- Silent failure: No indication to user that livepatch stopped working

**Affected kernel versions**: v6.0 onwards (when IPMODIFY+DIRECT sharing
was introduced)

### 8. REGRESSION RISK ANALYSIS

**Risk: LOW**

**Why low risk**:
1. **Small, focused change**: Adds a missing check, doesn't refactor
   existing code
2. **Parallel to existing code**: The register path already has this
   check working fine
3. **Well-tested**: Part of a patch series with selftests
   (0e0e608f72422)
4. **Multiple expert reviews**: Reviewed/Acked by ftrace and BPF
   maintainers
5. **Conservative approach**: Only affects the modify path when
   IPMODIFY+DIRECT interact
6. **Proper error handling**: Returns error if check fails, doesn't
   crash

**Potential issues**:
- Could theoretically reject modify operations that were previously
  (incorrectly) succeeding
- But those operations were broken anyway (bypassing livepatch)
- Failure mode is explicit error return, not silent corruption or crash

### 9. MAINLINE STABILITY

**Very recent commit**: October 27, 2025 (only in v6.18-rc6)

**Concerning**: Limited time in mainline for testing

**Mitigating factors**:
- Part of a tested patch series
- Multiple maintainer reviews
- Addresses a known issue with clear reproducer
- Similar to existing working code in register path
- Companion commit (56b3c85e153b8) explicitly tagged for stable v6.6+

### 10. COMMIT SERIES CONTEXT

This is part of a **2-commit fix series**:

**Commit 1** (56b3c85e153b8): "ftrace: Fix BPF fexit with livepatch"
- Fixes register path issues
- **Has "Fixes: d05cb470663a"**
- **Has "Cc: stable@vger.kernel.org # v6.6+"**
- Reported by production user at CrowdStrike
- Acked-and-tested-by production user

**Commit 2** (3e9a18e1c3e93): "ftrace: bpf: Fix IPMODIFY + DIRECT in
modify_ftrace_direct()" (THIS COMMIT)
- Fixes modify path issues
- **NO Fixes tag, NO stable tag**
- Part of same series (Link:
  .../20251027175023.1521602-3-song@kernel.org)

**Analysis**: The companion commit was explicitly tagged for stable,
making it unusual that this one wasn't. They're addressing the same
problem space (livepatch + BPF interaction), and both should go together
for complete fix.

### 11. STABLE KERNEL APPLICABILITY

**Applies to**: All stable trees from v6.0 onwards

**Reasoning**:
- Bug introduced in v6.0 (commit 53cd885bc5c3e)
- Code exists in all v6.0+ kernels
- Should apply cleanly (no major refactoring in this area)

**Relevant stable trees**:
- v6.0.y through v6.17.y (if still maintained)
- LTS: v6.1.y, v6.6.y, v6.12.y (most important)

### 12. MEETS STABLE KERNEL RULES?

Checking against Documentation/process/stable-kernel-rules.rst:

✅ **Obviously correct**: Yes - adds missing check parallel to existing
code
✅ **Tested**: Yes - part of series with selftests, multiple reviews
✅ **Fixes real bug**: Yes - livepatch bypass is real, has reproducer
✅ **Important issue**: Yes - security implications (patch bypass)
✅ **Small and contained**: Yes - ~40 lines, single file, surgical
❌ **No new features**: Correct - pure bug fix
✅ **Should apply cleanly**: Yes - no dependencies beyond v6.0 feature

**Verdict**: Meets all stable kernel criteria

---

## FINAL DECISION

This commit fixes a serious correctness bug where livepatches can be
silently bypassed when BPF fentry/fexit programs are attached. The bug
has been present since v6.0 (July 2022) when IPMODIFY+DIRECT sharing was
introduced.

**Security Impact**: Livepatches are often used to deploy security fixes
without rebooting. Bypassing them means systems remain vulnerable
despite appearing to be patched. This is a silent failure - users have
no indication their security patches aren't working.

**Technical Quality**: The fix is small (~40 lines), surgical, and
parallels existing code in the register path. It adds the missing
`__ftrace_hash_update_ipmodify()` call to the modify path, ensuring
proper coordination between livepatch (IPMODIFY) and BPF trampolines
(DIRECT).

**Review and Testing**: Multiple expert maintainers reviewed and acked
this (Jiri Olsa, Steven Rostedt, Alexei Starovoitov). It's part of a
tested patch series that includes selftests. The companion commit
(56b3c85e153b8) explicitly has "Cc: stable@vger.kernel.org # v6.6+".

**Regression Risk**: LOW. The change is well-contained, adds a check
that should have existed from the start, and has proper error handling.
The failure mode (if any) is an explicit error return, not silent
corruption.

**Stable Applicability**: Should backport to all v6.0+ stable trees. The
code is present and should apply cleanly. Most critical for LTS trees
(v6.1.y, v6.6.y, v6.12.y) where users depend on both livepatching and
BPF.

**Why No Stable Tag?**: Unclear why the maintainer didn't add "Cc:
stable@vger.kernel.org" when the companion commit has one. This appears
to be an oversight, as both commits address the same problem space and
were submitted together.

**Conclusion**: This is exactly the type of fix stable trees need - it
addresses a real, security-relevant bug affecting production systems
with a small, well-reviewed patch. The lack of an explicit stable tag
appears to be an oversight given that the companion commit has one. Both
commits should be backported together for a complete fix.

**YES**

 kernel/trace/ftrace.c | 40 +++++++++++++++++++++++++++++++---------
 1 file changed, 31 insertions(+), 9 deletions(-)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 42bd2ba68a821..5ad1138a1894c 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -1971,7 +1971,8 @@ static void ftrace_hash_rec_enable_modify(struct ftrace_ops *ops)
  */
 static int __ftrace_hash_update_ipmodify(struct ftrace_ops *ops,
 					 struct ftrace_hash *old_hash,
-					 struct ftrace_hash *new_hash)
+					 struct ftrace_hash *new_hash,
+					 bool update_target)
 {
 	struct ftrace_page *pg;
 	struct dyn_ftrace *rec, *end = NULL;
@@ -2006,10 +2007,13 @@ static int __ftrace_hash_update_ipmodify(struct ftrace_ops *ops,
 		if (rec->flags & FTRACE_FL_DISABLED)
 			continue;
 
-		/* We need to update only differences of filter_hash */
+		/*
+		 * Unless we are updating the target of a direct function,
+		 * we only need to update differences of filter_hash
+		 */
 		in_old = !!ftrace_lookup_ip(old_hash, rec->ip);
 		in_new = !!ftrace_lookup_ip(new_hash, rec->ip);
-		if (in_old == in_new)
+		if (!update_target && (in_old == in_new))
 			continue;
 
 		if (in_new) {
@@ -2020,7 +2024,16 @@ static int __ftrace_hash_update_ipmodify(struct ftrace_ops *ops,
 				if (is_ipmodify)
 					goto rollback;
 
-				FTRACE_WARN_ON(rec->flags & FTRACE_FL_DIRECT);
+				/*
+				 * If this is called by __modify_ftrace_direct()
+				 * then it is only changing where the direct
+				 * pointer is jumping to, and the record already
+				 * points to a direct trampoline. If it isn't,
+				 * then it is a bug to update ipmodify on a direct
+				 * caller.
+				 */
+				FTRACE_WARN_ON(!update_target &&
+					       (rec->flags & FTRACE_FL_DIRECT));
 
 				/*
 				 * Another ops with IPMODIFY is already
@@ -2076,7 +2089,7 @@ static int ftrace_hash_ipmodify_enable(struct ftrace_ops *ops)
 	if (ftrace_hash_empty(hash))
 		hash = NULL;
 
-	return __ftrace_hash_update_ipmodify(ops, EMPTY_HASH, hash);
+	return __ftrace_hash_update_ipmodify(ops, EMPTY_HASH, hash, false);
 }
 
 /* Disabling always succeeds */
@@ -2087,7 +2100,7 @@ static void ftrace_hash_ipmodify_disable(struct ftrace_ops *ops)
 	if (ftrace_hash_empty(hash))
 		hash = NULL;
 
-	__ftrace_hash_update_ipmodify(ops, hash, EMPTY_HASH);
+	__ftrace_hash_update_ipmodify(ops, hash, EMPTY_HASH, false);
 }
 
 static int ftrace_hash_ipmodify_update(struct ftrace_ops *ops,
@@ -2101,7 +2114,7 @@ static int ftrace_hash_ipmodify_update(struct ftrace_ops *ops,
 	if (ftrace_hash_empty(new_hash))
 		new_hash = NULL;
 
-	return __ftrace_hash_update_ipmodify(ops, old_hash, new_hash);
+	return __ftrace_hash_update_ipmodify(ops, old_hash, new_hash, false);
 }
 
 static void print_ip_ins(const char *fmt, const unsigned char *p)
@@ -6106,7 +6119,7 @@ EXPORT_SYMBOL_GPL(unregister_ftrace_direct);
 static int
 __modify_ftrace_direct(struct ftrace_ops *ops, unsigned long addr)
 {
-	struct ftrace_hash *hash;
+	struct ftrace_hash *hash = ops->func_hash->filter_hash;
 	struct ftrace_func_entry *entry, *iter;
 	static struct ftrace_ops tmp_ops = {
 		.func		= ftrace_stub,
@@ -6126,13 +6139,21 @@ __modify_ftrace_direct(struct ftrace_ops *ops, unsigned long addr)
 	if (err)
 		return err;
 
+	/*
+	 * Call __ftrace_hash_update_ipmodify() here, so that we can call
+	 * ops->ops_func for the ops. This is needed because the above
+	 * register_ftrace_function_nolock() worked on tmp_ops.
+	 */
+	err = __ftrace_hash_update_ipmodify(ops, hash, hash, true);
+	if (err)
+		goto out;
+
 	/*
 	 * Now the ftrace_ops_list_func() is called to do the direct callers.
 	 * We can safely change the direct functions attached to each entry.
 	 */
 	mutex_lock(&ftrace_lock);
 
-	hash = ops->func_hash->filter_hash;
 	size = 1 << hash->size_bits;
 	for (i = 0; i < size; i++) {
 		hlist_for_each_entry(iter, &hash->buckets[i], hlist) {
@@ -6147,6 +6168,7 @@ __modify_ftrace_direct(struct ftrace_ops *ops, unsigned long addr)
 
 	mutex_unlock(&ftrace_lock);
 
+out:
 	/* Removing the tmp_ops will add the updated direct callers to the functions */
 	unregister_ftrace_function(&tmp_ops);
 
-- 
2.51.0


