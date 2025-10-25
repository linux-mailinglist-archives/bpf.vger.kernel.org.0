Return-Path: <bpf+bounces-72192-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BEAEC09A01
	for <lists+bpf@lfdr.de>; Sat, 25 Oct 2025 18:41:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1CDE434EA19
	for <lists+bpf@lfdr.de>; Sat, 25 Oct 2025 16:41:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9939A32B988;
	Sat, 25 Oct 2025 16:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hl61JjAC"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D39D32AACA;
	Sat, 25 Oct 2025 16:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761409774; cv=none; b=nrbRqdRxUXjEml5yL2V/qMaxCF/IHkAfjqMLtPovjloPh7OpHs6wBGausuhpYeF2uZkxHXIDf6mwET7J47pH/3VxHEesGwuH0CtJgwWTUSL2qYyPkpgYVDnDsy2f8ylXMjQzMd6osxz85O+0r0JRsts97FGG8MTWxSmn/KuPA/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761409774; c=relaxed/simple;
	bh=2kPxIFj89Fg7yNGef24R/VQN1WhSSCn9kKxs2007vWs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fWPIMp5lEOrdKSpjb4zEv/BMKzOdEuVebTAOeNAi1uwetMg+kp0U4QScyINCvI3zn/xznQENVQCrogVITxsWrSSo+SJ4MtNUyUVka1fcnp/2vNAX6imTqUCfaWHW5Ha2A/m6cM2X/HW98LoqcgB6KkqlGfoVPG/EuOAME2ylI48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hl61JjAC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D588C4CEF5;
	Sat, 25 Oct 2025 16:29:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761409773;
	bh=2kPxIFj89Fg7yNGef24R/VQN1WhSSCn9kKxs2007vWs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Hl61JjACbFxkGYOOPnp0e0EzKeeBlhxqdjQgDwD++rDBTut9DnD/g9z1ZuntUVXDA
	 qq/DOCIWTUk/9A6sE9EmWRskR6hrBIyF6qMztwFTLjvFkuVR+oQU0dLXLZtG6zRTde
	 lA7PW9Q/tom4VUueZEhWR+zVTn8hZrGg3xdA2NjQfB4pW4hu6+LL3W+IQYdQHSpmH7
	 Q1mtMsrpTw+bjh8M30wtaWkkDPdLLfA/Smxq/6xf1sXU3xOmhnU+kHE7NIrf0S9vBz
	 Ej4HkAJopcbmylZ4GLceBC/SGoq/JgAS+tfvDjSc6XllJ59oDIWOXBHv1Gs3brmrSo
	 6vgDXDUL5aFRw==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Yafang Shao <laoar.shao@gmail.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Thomas Graf <tgraf@suug.ch>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH AUTOSEL 6.17-5.4] net/cls_cgroup: Fix task_get_classid() during qdisc run
Date: Sat, 25 Oct 2025 12:01:31 -0400
Message-ID: <20251025160905.3857885-460-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251025160905.3857885-1-sashal@kernel.org>
References: <20251025160905.3857885-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.17.5
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Yafang Shao <laoar.shao@gmail.com>

[ Upstream commit 66048f8b3cc7e462953c04285183cdee43a1cb89 ]

During recent testing with the netem qdisc to inject delays into TCP
traffic, we observed that our CLS BPF program failed to function correctly
due to incorrect classid retrieval from task_get_classid(). The issue
manifests in the following call stack:

        bpf_get_cgroup_classid+5
        cls_bpf_classify+507
        __tcf_classify+90
        tcf_classify+217
        __dev_queue_xmit+798
        bond_dev_queue_xmit+43
        __bond_start_xmit+211
        bond_start_xmit+70
        dev_hard_start_xmit+142
        sch_direct_xmit+161
        __qdisc_run+102             <<<<< Issue location
        __dev_xmit_skb+1015
        __dev_queue_xmit+637
        neigh_hh_output+159
        ip_finish_output2+461
        __ip_finish_output+183
        ip_finish_output+41
        ip_output+120
        ip_local_out+94
        __ip_queue_xmit+394
        ip_queue_xmit+21
        __tcp_transmit_skb+2169
        tcp_write_xmit+959
        __tcp_push_pending_frames+55
        tcp_push+264
        tcp_sendmsg_locked+661
        tcp_sendmsg+45
        inet_sendmsg+67
        sock_sendmsg+98
        sock_write_iter+147
        vfs_write+786
        ksys_write+181
        __x64_sys_write+25
        do_syscall_64+56
        entry_SYSCALL_64_after_hwframe+100

The problem occurs when multiple tasks share a single qdisc. In such cases,
__qdisc_run() may transmit skbs created by different tasks. Consequently,
task_get_classid() retrieves an incorrect classid since it references the
current task's context rather than the skb's originating task.

Given that dev_queue_xmit() always executes with bh disabled, we can use
softirq_count() instead to obtain the correct classid.

The simple steps to reproduce this issue:
1. Add network delay to the network interface:
  such as: tc qdisc add dev bond0 root netem delay 1.5ms
2. Build two distinct net_cls cgroups, each with a network-intensive task
3. Initiate parallel TCP streams from both tasks to external servers.

Under this specific condition, the issue reliably occurs. The kernel
eventually dequeues an SKB that originated from Task-A while executing in
the context of Task-B.

It is worth noting that it will change the established behavior for a
slightly different scenario:

  <sock S is created by task A>
  <class ID for task A is changed>
  <skb is created by sock S xmit and classified>

prior to this patch the skb will be classified with the 'new' task A
classid, now with the old/original one. The bpf_get_cgroup_classid_curr()
function is a more appropriate choice for this case.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: Thomas Graf <tgraf@suug.ch>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Nikolay Aleksandrov <razor@blackwall.org>
Link: https://patch.msgid.link/20250902062933.30087-1-laoar.shao@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

## BACKPORT RECOMMENDATION

**Answer: YES**

This commit should be backported to stable kernel trees, but with
careful consideration and monitoring.

---

## COMPREHENSIVE ANALYSIS

### The Bug Being Fixed

**Nature of the Issue:**

The commit fixes a functional bug in cgroup network classification where
`task_get_classid()` retrieves an incorrect classid when multiple tasks
share a single qdisc. This manifests when:

1. Task A creates an SKB and calls `dev_queue_xmit()`, which queues it
   to a qdisc (e.g., netem with delay)
2. Later, Task B (or softirq context) dequeues and transmits the SKB via
   `__qdisc_run()`
3. During transmission, the classifier calls `task_get_classid(skb)` to
   determine the cgroup classid
4. The function incorrectly uses `current` (Task B's context) instead of
   the socket's classid

**Impact:**
- Breaks BPF programs using `bpf_get_cgroup_classid()` for traffic
  classification
- Affects production systems using cgroup-based network classification
  with qdiscs
- Clear reproduction: tc qdisc with netem delay + multiple net_cls
  cgroups + parallel TCP streams

### The Fix

**Code Change (include/net/cls_cgroup.h:66):**
```c
- if (in_serving_softirq()) {
+       if (softirq_count()) {
```

**Technical Explanation:**

The key difference between these checks:

1. **`in_serving_softirq()`** = `(softirq_count() & SOFTIRQ_OFFSET)`
   - TRUE only when actively executing a softirq handler
   - Misses the case where BH is disabled but we're not in a softirq
     handler

2. **`softirq_count()`** = `(preempt_count() & SOFTIRQ_MASK)`
   - Non-zero when in softirq OR when bottom-halves are disabled
   - Correctly detects the BH-disabled state during `dev_queue_xmit()`

Since `dev_queue_xmit()` always executes with BH disabled (as noted in
the code comment on line 57-65), `softirq_count()` will always be non-
zero during packet transmission, causing the code to correctly fall back
to the socket's classid instead of using the potentially-wrong current
task's classid.

### Historical Context - Critical Finding

This bug has existed for **15 years**, introduced by commit 75e1056f5c57
(2010):

**Timeline:**
1. **2008 (f400923735ecb)**: Original implementation correctly used
   `softirq_count() != SOFTIRQ_OFFSET`
2. **2010 (75e1056f5c57)**: Changed to `in_serving_softirq()` as part of
   softirq accounting refactoring
   - The commit message stated: "Looks like many usages of in_softirq
     really want in_serving_softirq. Those changes can be made
     individually on a case by case basis."
   - This suggests the change was somewhat speculative
3. **2015 (b87a173e25d6b)**: Code refactored into `task_get_classid()`
   function (bug persisted)
4. **2025 (66048f8b3cc7e)**: Current fix corrects the 2010 mistake

The 2010 change was well-intentioned (improving softirq time accounting)
but inadvertently broke this specific use case. The current fix is
essentially reverting to the correct logic while using the modern
`softirq_count()` macro.

### Code Quality Assessment

**Strengths:**
- ✅ Minimal, surgical change (one line in include/net/cls_cgroup.h:66)
- ✅ Well-documented commit message with detailed call stack
- ✅ Clear reproduction steps provided
- ✅ Acknowledges the behavioral change for edge cases
- ✅ Suggests alternative (`bpf_get_cgroup_classid_curr()`) for the edge
  case
- ✅ No follow-up fixes or reverts found in subsequent commits

**Callers Analysis:**
- `cls_cgroup_classify()` in net/sched/cls_cgroup.c:31
- `bpf_get_cgroup_classid()` BPF helper in net/core/filter.c:3126

### Behavioral Change - Important Consideration

The commit explicitly acknowledges a behavioral change:

**Scenario:** Socket created by Task A → Task A's classid changes → SKB
transmitted

- **Old behavior**: Uses Task A's new/current classid
- **New behavior**: Uses socket's original classid

**Author's Note:** "The bpf_get_cgroup_classid_curr() function is a more
appropriate choice for this case."

This is a **correct** behavioral change because:
1. When the SKB was created, it was associated with a socket that had a
   specific classid
2. The classification should reflect the socket's identity, not the
   current task executing the qdisc
3. Alternative BPF helper exists for cases where current task's classid
   is truly desired

### Risk Assessment

**Low Risk Factors:**
- ✅ Extremely small code footprint (one line)
- ✅ Confined to cgroup network classification subsystem
- ✅ No architectural changes
- ✅ Clear understanding of the fix
- ✅ No subsequent fixes or reverts in upstream

**Moderate Risk Factors:**
- ⚠️ Changes behavior present for 15 years
- ⚠️ Potential for systems adapted to old (incorrect) behavior
- ⚠️ No explicit "Fixes:" tag or "Cc: stable" from maintainers
- ⚠️ Limited test coverage (only tools/testing/selftests/tc-
  testing/tdc.sh mentions cls_cgroup)
- ⚠️ Behavioral difference for edge case (though correctly addressed)

**Risk Mitigation:**
- The bug being fixed is more severe than potential regressions
- Clear documentation allows users to understand behavioral changes
- Alternative API exists for edge case scenarios
- Change restores original (2008) intended behavior

### Stable Tree Backporting Criteria

Evaluating against standard stable tree rules:

1. **Fixes important bug affecting users**: ✅ **YES**
   - Breaks production systems using cgroup classification with qdiscs
   - Affects BPF-based traffic classification
   - Clear reproduction provided

2. **Small and contained**: ✅ **YES**
   - One-line change
   - Single subsystem affected
   - No dependencies

3. **No new features**: ✅ **YES**
   - Only fixes existing functionality
   - No new APIs or capabilities

4. **Minimal architectural changes**: ✅ **YES**
   - Changes condition check, not architecture
   - Preserves existing interfaces

5. **Minimal regression risk**: ⚠️ **MODERATE**
   - Very small code change (low technical risk)
   - But changes long-standing behavior (moderate behavioral risk)

6. **Explicit stable mention**: ❌ **NO**
   - No "Fixes:" tag
   - No "Cc: stable@vger.kernel.org"
   - Suggests maintainers may have been cautious

### Why Maintainers May Not Have Tagged for Stable

The absence of a stable tag is notable given the clear bug fix. Possible
reasons:

1. **Long-standing behavior change**: 15 years is substantial; systems
   may have adapted
2. **Edge case behavioral difference**: Though correctly addressed,
   could affect some users
3. **Wait-and-see approach**: Let it bake in mainline before backporting
4. **Uncertainty about impact**: Without extensive testing, hard to
   predict all effects

However, the AUTOSEL system has already selected it (commit
a47bd4e6b9b10 in this tree), indicating automated analysis suggests it's
suitable for backporting.

### Related Commits

**Independent RCU Fix (June 2025):**
- Commit 7f12c33850482: "net, bpf: Fix RCU usage in task_cls_state() for
  BPF programs"
- Fixes RCU warnings when `bpf_get_cgroup_classid_curr()` is called from
  non-networking BPF programs
- **Independent of this fix** - doesn't conflict or depend on the
  current commit
- Should also be considered for backporting if present in the stable
  tree

### Testing and Validation

**Reproduction Test:**
```bash
# Setup netem qdisc with delay
tc qdisc add dev bond0 root netem delay 1.5ms

# Create two net_cls cgroups with different classids
# Run network-intensive tasks from both cgroups
# Initiate parallel TCP streams to external servers

# Expected: Classification works correctly after fix
```

**Limitation:** No comprehensive kernel selftests for this functionality
found in tools/testing/selftests/

### Recommendation Rationale

**Why YES:**

1. **Fixes Real Production Bug**: Clear, reproducible issue affecting
   users with modern BPF-based classification
2. **Correct Fix**: Changes from incorrect logic (2010 mistake) to
   correct logic (matching 2008 intent)
3. **Minimal Technical Risk**: One-line change, well-understood, no
   follow-up fixes needed
4. **Important Functionality**: Cgroup network classification is widely
   used
5. **Clear Documentation**: Commit message provides full context and
   acknowledges behavioral changes
6. **AUTOSEL Selected**: Already in autosel tree, indicating automated
   analysis supports backporting

**Why Caution:**

1. **Long-Standing Behavior**: 15 years increases adaptation risk
2. **No Maintainer Stable Tag**: Suggests some caution from maintainers
3. **Behavioral Change**: Even though correct, could surprise users
4. **Limited Testing**: No comprehensive self-tests for this
   functionality

### Backporting Recommendations

**If backported:**

1. **Monitor carefully** for regression reports
2. **Document the behavioral change** in stable release notes
3. **Backport to all maintained stable trees** where cgroup networking
   exists
4. **Consider batching** with the related RCU fix (7f12c33850482) if
   present
5. **Prepare to revert quickly** if unexpected regressions surface

**Priority:**
- Medium-High priority for systems using:
  - Cgroup-based network classification
  - BPF traffic control programs
  - QoS with qdiscs (especially netem, tbf, etc.)
- Lower priority for systems without cgroup network classification

---

## Conclusion

**YES, this commit should be backported to stable kernel trees.**

Despite the 15-year behavioral change, the fix addresses a legitimate
and reproducible bug in production-relevant functionality. The technical
risk is low (one-line change), and the behavioral change is correctly
documented and justified. The original 2010 change that introduced the
bug was part of a broader refactoring and appears to have been incorrect
for this specific use case. This fix restores the correct behavior while
using modern kernel interfaces.

However, backporting should be done with heightened awareness and
monitoring due to the long-standing nature of the incorrect behavior.
The absence of a maintainer-provided stable tag suggests some caution,
but the AUTOSEL system's selection and the clear bug description support
backporting with appropriate oversight.

 include/net/cls_cgroup.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/net/cls_cgroup.h b/include/net/cls_cgroup.h
index 7e78e7d6f0152..668aeee9b3f66 100644
--- a/include/net/cls_cgroup.h
+++ b/include/net/cls_cgroup.h
@@ -63,7 +63,7 @@ static inline u32 task_get_classid(const struct sk_buff *skb)
 	 * calls by looking at the number of nested bh disable calls because
 	 * softirqs always disables bh.
 	 */
-	if (in_serving_softirq()) {
+	if (softirq_count()) {
 		struct sock *sk = skb_to_full_sk(skb);
 
 		/* If there is an sock_cgroup_classid we'll use that. */
-- 
2.51.0


