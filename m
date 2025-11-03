Return-Path: <bpf+bounces-73369-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D95B3C2D956
	for <lists+bpf@lfdr.de>; Mon, 03 Nov 2025 19:06:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B6FD24F59E9
	for <lists+bpf@lfdr.de>; Mon,  3 Nov 2025 18:04:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF3EA31B124;
	Mon,  3 Nov 2025 18:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZrEtuORC"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 468B3199230;
	Mon,  3 Nov 2025 18:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762192991; cv=none; b=F3Tm7qiKiDU1hFXEp7T+pYaqpjquUUAbBdd16qgefs6wfO4+NIUwu0bDVSpxVhFtOSGUJQ/tOgkU3nXRBYTMJe9kEbFx6ahW3elLtnj9iONUiMjQJoShz1ekK5+4HZPXB8HE9V2fS4s0vekxNnyaNQcoaPimUnNqn3L6bw/Lr4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762192991; c=relaxed/simple;
	bh=nykU3KuIG39Hkra9YtKgZFir7eDFsIkuzXIsan3RTp8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JngC1kQf9Fow26ibCWf+hycUsawfmCA1xlYh9+LA8ZSdZK5QkH+TRuxp68r841mZirHmgiuLcIGay1Lwi+MolilcBmSxg28pIpfdqJ4l5+ExP9VW8KXsW0cg5TNJEKbqqd0B0+14p8mnGiWBzvjZgGSJMaKFyLUY1Y1frirk5l0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZrEtuORC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23B54C4CEE7;
	Mon,  3 Nov 2025 18:03:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762192990;
	bh=nykU3KuIG39Hkra9YtKgZFir7eDFsIkuzXIsan3RTp8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZrEtuORCC3S4NsYgY7iRrKIJnWxcsZ9jjavEvCeseaVvZ6qtlgIJtb5fYsJUTNXA4
	 zbexLqS15mwujAxsk2c3eUDsDZQUhV2J9ge6gh0pzzNrw+gPyrYISJ2nU1J51lSA5d
	 U1S2V/ZwhdBVcyobaL4rmfyQ7N/BPI7rRgeGDrrqSYR1gDAf9JWeB37wn0mITUkIcw
	 /o+P27LvhtIO1nf7uN6iZSHbmCS334iMbCjYvisZBXsi6oHQ1Xa5byIL3ZMfA2gwNV
	 Y2OOKrohBMxNNfxrIptb3bA5CJ76lOUrR8gsKiCoQctrAU1XyyEAUAOECTzkVYJbE9
	 2mJnpQdjZmvgA==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Emil Tsalapatis <etsal@meta.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"Emil Tsalapatis (Meta)" <emil@etsalapatis.com>,
	Andrea Righi <arighi@nvidia.com>,
	Tejun Heo <tj@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	mingo@redhat.com,
	peterz@infradead.org,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH AUTOSEL 6.17] sched_ext: defer queue_balance_callback() until after ops.dispatch
Date: Mon,  3 Nov 2025 13:02:25 -0500
Message-ID: <20251103180246.4097432-12-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251103180246.4097432-1-sashal@kernel.org>
References: <20251103180246.4097432-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.17.7
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Emil Tsalapatis <etsal@meta.com>

[ Upstream commit a8ad873113d3fe01f9b5d737d4b0570fa36826b0 ]

The sched_ext code calls queue_balance_callback() during enqueue_task()
to defer operations that drop multiple locks until we can unpin them.
The call assumes that the rq lock is held until the callbacks are
invoked, and the pending callbacks will not be visible to any other
threads. This is enforced by a WARN_ON_ONCE() in rq_pin_lock().

However, balance_one() may actually drop the lock during a BPF dispatch
call. Another thread may win the race to get the rq lock and see the
pending callback. To avoid this, sched_ext must only queue the callback
after the dispatch calls have completed.

CPU 0                   CPU 1           CPU 2

scx_balance()
  rq_unpin_lock()
  scx_balance_one()
    |= IN_BALANCE	scx_enqueue()
    ops.dispatch()
      rq_unlock()
                        rq_lock()
                        queue_balance_callback()
                        rq_unlock()
                                        [WARN] rq_pin_lock()
      rq_lock()
    &= ~IN_BALANCE
rq_repin_lock()

Changelog

v2-> v1 (https://lore.kernel.org/sched-ext/aOgOxtHCeyRT_7jn@gpd4)

- Fixed explanation in patch description (Andrea)
- Fixed scx_rq mask state updates (Andrea)
- Added Reviewed-by tag from Andrea

Reported-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Emil Tsalapatis (Meta) <emil@etsalapatis.com>
Reviewed-by: Andrea Righi <arighi@nvidia.com>
Signed-off-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

Based on my comprehensive analysis using semantic code analysis tools
and repository examination, here is my recommendation:

## **ANSWER: YES** (with critical caveat)

This commit **should be backported to stable kernel trees**, BUT the
follow-up fix commit a3c4a0a42e61a ("sched_ext: fix flag check for
deferred callbacks") **MUST be included together**, as the original
patch has a bug.

---

## **Extensive Analysis:**

### **1. Feature Availability Analysis**

Using git history analysis, I determined:
- **sched_ext was introduced in v6.12-rc1** (commit f0e1a0643a59b)
- **v6.11 and earlier kernels DO NOT have sched_ext** (verified with
  `git ls-tree`)
- **Only stable trees v6.12+ need this fix** (v6.12.x, v6.13.x, v6.16.x,
  v6.17.x all have kernel/sched/ext.c)

### **2. Semantic Code Analysis Using MCP Tools**

**Functions analyzed:**
- `mcp__semcode__find_function`: Located schedule_deferred(),
  balance_one(), balance_scx()
- `mcp__semcode__find_callers`: Traced call graph to understand impact
  scope

**Call chain discovered:**
```
Core scheduler → balance_scx (.balance callback)
  ↓
balance_one() [sets SCX_RQ_IN_BALANCE flag]
  ↓
ops.dispatch() [BPF scheduler callback - CAN DROP RQ LOCK]
  ↓
[RACE WINDOW - other CPUs can acquire lock]
  ↓
schedule_deferred() → queue_balance_callback()
  ↓
WARN_ON_ONCE() in rq_pin_lock() on CPU 2
```

**Impact scope:**
- schedule_deferred() called by: direct_dispatch()
- direct_dispatch() called by: do_enqueue_task()
- do_enqueue_task() called by: enqueue_task_scx, put_prev_task_scx,
  scx_bpf_reenqueue_local
- These are **core scheduler operations** triggered by normal task
  scheduling
- **User-space exposure**: Yes, any process using sched_ext can trigger
  this

### **3. Bug Severity Analysis**

**Race condition mechanism** (from commit message and code):
1. CPU 0: balance_one() sets IN_BALANCE flag, calls ops.dispatch()
2. ops.dispatch() **drops rq lock** during BPF execution
3. CPU 1: Acquires lock, calls schedule_deferred(), sees IN_BALANCE,
   queues callback
4. CPU 2: Calls rq_pin_lock(), sees pending callback → **WARN_ON_ONCE()
   triggers**

**Code reference** (kernel/sched/sched.h:1790-1797):
```c
static inline void rq_pin_lock(struct rq *rq, struct rq_flags *rf)
{
    rf->cookie = lockdep_pin_lock(__rq_lockp(rq));
    rq->clock_update_flags &= (RQCF_REQ_SKIP|RQCF_ACT_SKIP);
    rf->clock_update_flags = 0;
    WARN_ON_ONCE(rq->balance_callback &&
                 rq->balance_callback != &balance_push_callback);  // ←
VIOLATION
}
```

**Severity**: Medium-High
- Not a crash, but scheduler correctness issue
- Generates kernel warnings in logs
- Indicates inconsistent scheduler state
- Reported by Jakub Kicinski (well-known kernel developer)

### **4. Code Changes Analysis**

**Changes are minimal and focused:**
- kernel/sched/ext.c: +29 lines, -2 lines
- kernel/sched/sched.h: +1 line (new flag SCX_RQ_BAL_CB_PENDING)

**Behavioral change:**
- BEFORE: queue_balance_callback() called immediately when
  SCX_RQ_IN_BALANCE set
- AFTER: Set SCX_RQ_BAL_CB_PENDING flag, defer actual queuing until
  after ops.dispatch()
- NEW: maybe_queue_balance_callback() called after balance_one()
  completes

**No architectural changes:** Just timing adjustment to avoid race
window

### **5. Critical Follow-up Fix Required**

**Commit a3c4a0a42e61a analysis:**
```diff
- if (rq->scx.flags & SCX_RQ_BAL_PENDING)
+       if (rq->scx.flags & SCX_RQ_BAL_CB_PENDING)
```

The original patch checks the **wrong flag** in schedule_deferred().
This means:
- Without the follow-up, multiple deferred operations could be queued
  incorrectly
- **Both commits must be backported together**

### **6. Stable Tree Compliance**

✅ **Fixes important bug**: Race condition causing kernel warnings
✅ **No new features**: Pure bug fix
✅ **No architectural changes**: Small, contained fix
✅ **Minimal regression risk**: Changes only affect sched_ext code path
✅ **Subsystem confined**: Only affects sched_ext subsystem

### **7. Backport Recommendation**

**YES**, backport to all stable trees with sched_ext (v6.12+), with
these requirements:

1. **MUST include both commits:**
   - a8ad873113d3 ("sched_ext: defer queue_balance_callback()")
   - a3c4a0a42e61a ("sched_ext: fix flag check for deferred callbacks")

2. **Target stable trees:** 6.12.x, 6.13.x, 6.14.x, 6.15.x, 6.16.x,
   6.17.x

3. **Not needed for:** v6.11.x and earlier (no sched_ext code)

**Reasoning:** This is a correctness fix for a real race condition in
core scheduler code that can be triggered by normal scheduling
operations when using BPF extensible schedulers. The fix is small,
contained, and follows all stable kernel rules.

 kernel/sched/ext.c   | 29 +++++++++++++++++++++++++++--
 kernel/sched/sched.h |  1 +
 2 files changed, 28 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 040ca7419b4f9..b796ce247fffd 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -820,13 +820,23 @@ static void schedule_deferred(struct rq *rq)
 	if (rq->scx.flags & SCX_RQ_IN_WAKEUP)
 		return;
 
+	/* Don't do anything if there already is a deferred operation. */
+	if (rq->scx.flags & SCX_RQ_BAL_PENDING)
+		return;
+
 	/*
 	 * If in balance, the balance callbacks will be called before rq lock is
 	 * released. Schedule one.
+	 *
+	 *
+	 * We can't directly insert the callback into the
+	 * rq's list: The call can drop its lock and make the pending balance
+	 * callback visible to unrelated code paths that call rq_pin_lock().
+	 *
+	 * Just let balance_one() know that it must do it itself.
 	 */
 	if (rq->scx.flags & SCX_RQ_IN_BALANCE) {
-		queue_balance_callback(rq, &rq->scx.deferred_bal_cb,
-				       deferred_bal_cb_workfn);
+		rq->scx.flags |= SCX_RQ_BAL_CB_PENDING;
 		return;
 	}
 
@@ -2043,6 +2053,19 @@ static void flush_dispatch_buf(struct scx_sched *sch, struct rq *rq)
 	dspc->cursor = 0;
 }
 
+static inline void maybe_queue_balance_callback(struct rq *rq)
+{
+	lockdep_assert_rq_held(rq);
+
+	if (!(rq->scx.flags & SCX_RQ_BAL_CB_PENDING))
+		return;
+
+	queue_balance_callback(rq, &rq->scx.deferred_bal_cb,
+				deferred_bal_cb_workfn);
+
+	rq->scx.flags &= ~SCX_RQ_BAL_CB_PENDING;
+}
+
 static int balance_one(struct rq *rq, struct task_struct *prev)
 {
 	struct scx_sched *sch = scx_root;
@@ -2190,6 +2213,8 @@ static int balance_scx(struct rq *rq, struct task_struct *prev,
 #endif
 	rq_repin_lock(rq, rf);
 
+	maybe_queue_balance_callback(rq);
+
 	return ret;
 }
 
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 72fb9129afb6a..c7f67f54d4e3e 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -782,6 +782,7 @@ enum scx_rq_flags {
 	SCX_RQ_BAL_KEEP		= 1 << 3, /* balance decided to keep current */
 	SCX_RQ_BYPASSING	= 1 << 4,
 	SCX_RQ_CLK_VALID	= 1 << 5, /* RQ clock is fresh and valid */
+	SCX_RQ_BAL_CB_PENDING	= 1 << 6, /* must queue a cb after dispatching */
 
 	SCX_RQ_IN_WAKEUP	= 1 << 16,
 	SCX_RQ_IN_BALANCE	= 1 << 17,
-- 
2.51.0


