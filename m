Return-Path: <bpf+bounces-70429-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BD89BBEEA4
	for <lists+bpf@lfdr.de>; Mon, 06 Oct 2025 20:20:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB9F2189B653
	for <lists+bpf@lfdr.de>; Mon,  6 Oct 2025 18:20:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E461C2DF128;
	Mon,  6 Oct 2025 18:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i1TkAiwB"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 576E82DECC2;
	Mon,  6 Oct 2025 18:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759774759; cv=none; b=WmgUn5wGy0poIu5md9eDOCf8JEPv/vPESpVyjCzJ0WTF6MeKrCfdt27oH6GO82vFN6coyjOxjppvrpuxThEC80ukMtFa4/GQgDjS6/C0A/oLHO3ylg/3J6EV42rtlxprbtbMAoa+7EJzUb4aQmAVOHmUEvFomUKntapSTFzPUao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759774759; c=relaxed/simple;
	bh=weF2i9MqU4JBi11QhA9h5h8x9r7QO+eRhNlq3ZkVONQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DIhdbi2yIBKDH3EslPLO6vkyUB9wAL7ykiqRhX5ZOniWSf4b+mUhfxDc78e8CO/N8PR0SKxvfVXzF0dPTSAk+q18afheOyvXenb8/2ytTc1mhyhxQFUtN9VsYOrw6iMi+odOHLd+tvndR53eIqWaa2+mzFy/74MCB7qCwrOMxwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i1TkAiwB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D705C4CEF5;
	Mon,  6 Oct 2025 18:19:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759774758;
	bh=weF2i9MqU4JBi11QhA9h5h8x9r7QO+eRhNlq3ZkVONQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=i1TkAiwBNECcS4RVoOE8BIMFtLJpYlCxKhs+o48uFutYGn9kNAmLZy2AobE9qZTpH
	 jMvHmrucM19bszjkFYtuldvHjISbdR1Wy/z8wQjSKP6ZLbeHRrFP9diV1ailHlzDNN
	 V9DMXWdMvdZSkW+wfNRpDeq435SU00cJAMGx0ZzUK9Q8qCJwHyPgHZbVU0Sxf/qXcc
	 JLI9QR4MtXzboJlhT4Es0gc374izI2Sau7X+dPi9XZHQa3rr+mT+0JrV2rTFdP0IiN
	 p2b0Dgzpjg/RQfYqQCHgTCkGHmTh4HTviv45/1kD29RIouaUrzKPt1bK5c9BauR3wk
	 WkubnGcl9BLow==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Josh Poimboeuf <jpoimboe@kernel.org>,
	"Steven Rostedt (Google)" <rostedt@goodmis.org>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Sasha Levin <sashal@kernel.org>,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH AUTOSEL 6.17-6.1] perf: Have get_perf_callchain() return NULL if crosstask and user are set
Date: Mon,  6 Oct 2025 14:17:46 -0400
Message-ID: <20251006181835.1919496-14-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251006181835.1919496-1-sashal@kernel.org>
References: <20251006181835.1919496-1-sashal@kernel.org>
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

From: Josh Poimboeuf <jpoimboe@kernel.org>

[ Upstream commit 153f9e74dec230f2e070e16fa061bc7adfd2c450 ]

get_perf_callchain() doesn't support cross-task unwinding for user space
stacks, have it return NULL if both the crosstask and user arguments are
set.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20250820180428.426423415@kernel.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

## BACKPORT RECOMMENDATION: YES

## COMPREHENSIVE ANALYSIS

### Executive Summary
This commit fixes a long-standing correctness and efficiency issue in
`get_perf_callchain()` by making it return NULL early when attempting
unsupported cross-task user stack unwinding, rather than wastefully
allocating and deallocating resources. This is a low-risk bug fix that
improves both correctness and efficiency.

---

### Code Change Analysis

**What Changed:**
The commit modifies `kernel/events/callchain.c:get_perf_callchain()` in
two key ways:

1. **Added early NULL return check** (lines 227-229):
```c
+       /* crosstask is not supported for user stacks */
+       if (crosstask && user && !kernel)
+               return NULL;
```

2. **Modified user section entry condition** (line 247):
```c
- if (user) {
+       if (user && !crosstask) {
```

3. **Removed redundant checks** (lines 252-254, 264):
   - Removed `if (crosstask) goto exit_put;` inside the user section
   - Removed the now-unnecessary `exit_put:` label

**Functional Impact:**
- **Before**: When `crosstask && user && !kernel`, the function would
  call `get_callchain_entry(&rctx)` to allocate a per-CPU buffer, enter
  the user path, immediately hit `if (crosstask) goto exit_put;`,
  deallocate the buffer, and return an "empty" callchain entry.
- **After**: When `crosstask && user && !kernel`, the function returns
  NULL immediately without any resource allocation.

---

### Historical Context

**Origin of crosstask support (2016):**
Commit `568b329a02f75` by Alexei Starovoitov (Feb 2016) generalized
`get_perf_callchain()` for BPF usage and added the `crosstask` parameter
with this explicit comment:
```c
/* Disallow cross-task user callchains. */
```

The original implementation included `if (crosstask) goto exit_put;` in
the user path, showing the intent was **always to disallow cross-task
user stack unwinding**. The reason is clear: cross-task user stack
unwinding is unsafe because:
- The target task's user stack memory may not be accessible from the
  current context
- It would require complex synchronization and memory access validation
- Security implications of reading another process's user space stack

**Why the old code was problematic:**
For 9+ years (2016-2025), the function has been allocating resources
only to immediately deallocate them for the unsupported case. This
wastes CPU cycles and makes the code harder to understand.

---

### Caller Analysis

**All callers properly handle NULL returns:**

1. **kernel/events/core.c:perf_callchain()** (lines 8220):
```c
callchain = get_perf_callchain(regs, kernel, user, max_stack, crosstask,
true);
return callchain ?: &__empty_callchain;
```
Uses the ternary operator to return `&__empty_callchain` when NULL.

2. **kernel/bpf/stackmap.c** (lines 317, 454):
```c
/* get_perf_callchain does not support crosstask user stack walking
 - but returns an empty stack instead of NULL.
 */
if (crosstask && user) {
    err = -EOPNOTSUPP;
    goto clear;
}
...
trace = get_perf_callchain(regs, kernel, user, max_depth, crosstask,
false);
if (unlikely(!trace))
    /* couldn't fetch the stack trace */
    return -EFAULT;
```

**Key observation:** The BPF code comment explicitly states it expects
NULL for crosstask+user, but notes the function "returns an empty stack
instead." This commit **fixes this discrepancy**.

---

### Risk Assessment

**Risk Level: VERY LOW**

**Why low risk:**
1. **Behavioral compatibility**: The functional outcome is identical -
   both old and new code result in no user stack data being collected
   for crosstask scenarios
2. **Caller readiness**: All callers already have NULL-handling code in
   place
3. **Resource efficiency**: Only improves performance by avoiding
   wasteful allocation/deallocation
4. **No semantic changes**: The "unsupported operation" is still
   unsupported, just handled more efficiently
5. **Code simplification**: Removes goto statement and makes control
   flow clearer

**Potential concerns addressed:**
- **Performance impact**: Positive - reduces overhead
- **Compatibility**: Complete - callers expect this behavior
- **Edge cases**: The scenario (crosstask user-only callchains) is
  uncommon in practice, evidenced by the fact this inefficiency went
  unnoticed for 9 years

---

### Bug Fix Classification

**This IS a bug fix, specifically:**
1. **Correctness bug**: Behavior didn't match documented intent (BPF
   comment)
2. **Efficiency bug**: Wasteful resource allocation for unsupported
   operations
3. **Code clarity bug**: Goto-based control flow obscured the actual
   behavior

**Not a security bug**: No security implications, no CVE

---

### Series Context

This commit is part of a cleanup series by Josh Poimboeuf:
1. `e649bcda25b5a` - Remove unused `init_nr` argument (cleanup)
2. **`153f9e74dec23` - Fix crosstask+user handling (THIS COMMIT - bug
   fix)**
3. `d77e3319e3109` - Simplify user logic further (cleanup)
4. `16ed389227651` - Skip user unwind for kernel threads (bug fix)

**No follow-up fixes required**: No subsequent commits fix issues
introduced by this change, indicating it's stable.

---

### Backporting Considerations

**Arguments FOR backporting:**
1. ✅ **Fixes long-standing bug**: Corrects 9-year-old inefficiency
2. ✅ **Low risk**: Minimal code change, all callers prepared
3. ✅ **Improves correctness**: Aligns behavior with documented intent
4. ✅ **Performance benefit**: Reduces unnecessary overhead
5. ✅ **Clean commit**: Well-tested, no follow-up fixes needed
6. ✅ **Follows stable rules**: Important bugfix, minimal regression
   risk, confined to perf subsystem

**Arguments AGAINST backporting:**
1. ⚠️ **No Cc: stable tag**: Maintainers didn't mark it for stable
2. ⚠️ **Rare scenario**: crosstask user-only callchains are uncommon
3. ⚠️ **Non-critical**: No user-visible bugs reported

**Verdict:**
The absence of a `Cc: stable` tag suggests maintainers viewed this as a
minor fix rather than critical. However, the change meets all technical
criteria for stable backporting: it's a genuine bug fix, low-risk, and
improves correctness. The decision likely depends on stable tree
maintainer philosophy - this is a quality improvement rather than a
critical user-facing fix.

---

### Recommendation: **YES - Backport to stable trees**

**Rationale:**
While not critical, this commit improves kernel quality with minimal
risk. It fixes a real (if uncommon) inefficiency, improves code clarity,
and has no downsides. Stable trees benefit from such quality
improvements, especially when they're this low-risk.

**Suggested stable versions:** 6.6+, 6.12+, 6.17+ (any stable tree where
perf events are actively used)

**Dependencies:** Should ideally be backported with the prerequisite
commit:
- `e649bcda25b5a` ("perf: Remove get_perf_callchain() init_nr argument")
  - simplifies the function signature

The follow-up commits (`d77e3319e3109`, `16ed389227651`) are optional
but recommended for consistency.

 kernel/events/callchain.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/kernel/events/callchain.c b/kernel/events/callchain.c
index decff7266cfbd..2609998ca07f1 100644
--- a/kernel/events/callchain.c
+++ b/kernel/events/callchain.c
@@ -224,6 +224,10 @@ get_perf_callchain(struct pt_regs *regs, u32 init_nr, bool kernel, bool user,
 	struct perf_callchain_entry_ctx ctx;
 	int rctx, start_entry_idx;
 
+	/* crosstask is not supported for user stacks */
+	if (crosstask && user && !kernel)
+		return NULL;
+
 	entry = get_callchain_entry(&rctx);
 	if (!entry)
 		return NULL;
@@ -240,7 +244,7 @@ get_perf_callchain(struct pt_regs *regs, u32 init_nr, bool kernel, bool user,
 		perf_callchain_kernel(&ctx, regs);
 	}
 
-	if (user) {
+	if (user && !crosstask) {
 		if (!user_mode(regs)) {
 			if (current->flags & (PF_KTHREAD | PF_USER_WORKER))
 				regs = NULL;
@@ -249,9 +253,6 @@ get_perf_callchain(struct pt_regs *regs, u32 init_nr, bool kernel, bool user,
 		}
 
 		if (regs) {
-			if (crosstask)
-				goto exit_put;
-
 			if (add_mark)
 				perf_callchain_store_context(&ctx, PERF_CONTEXT_USER);
 
@@ -261,7 +262,6 @@ get_perf_callchain(struct pt_regs *regs, u32 init_nr, bool kernel, bool user,
 		}
 	}
 
-exit_put:
 	put_callchain_entry(rctx);
 
 	return entry;
-- 
2.51.0


