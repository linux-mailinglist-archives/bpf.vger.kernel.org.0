Return-Path: <bpf+bounces-70430-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 15AF9BBEEC8
	for <lists+bpf@lfdr.de>; Mon, 06 Oct 2025 20:21:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2D0A3B260E
	for <lists+bpf@lfdr.de>; Mon,  6 Oct 2025 18:20:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35BD92DFA2F;
	Mon,  6 Oct 2025 18:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gzRtzlHE"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A72102DCBFA;
	Mon,  6 Oct 2025 18:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759774766; cv=none; b=JdaYeEWD/99Tlp5ikqGosvsFWyKPsTh98H/PMv+5Xdn0Ypa5qOzHrJIcZwif5yCrzeYoPnLwLwO5wE07tJSpLZnkyjk11TP0308DnJOXC7YSbklP9Pj+SfMMclEMJiBe5SEAvBjmjVMD7h92Sd//zffy/alLNf9Lu5h53MCvmYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759774766; c=relaxed/simple;
	bh=5PAMSdqpznyRIDro+mhrKwqraYqge29gpObzkd+H/KY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=vEdQFp1Y70kyV/6VmfdF3WXZW8l8ZpUEGz1aeJudEKv5JJMu5H5AxzIakVcQr2l9bry5zNx+7BwR4JRwSo72Isnb3lCMaxvcsE5Cou4OfzOQtJfD/vuHICDNalQ+4CmF4in+2WAeMUUQgCCQLAUSKRJvxEUA1Zb53YPv38RnKGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gzRtzlHE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57B3AC4CEF5;
	Mon,  6 Oct 2025 18:19:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759774766;
	bh=5PAMSdqpznyRIDro+mhrKwqraYqge29gpObzkd+H/KY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gzRtzlHExe7K4JiGtGjLcW5fhCNF6CaTgT+fhhTPKOF2rxZYcvL62vDJ+U6qM6j7t
	 ZlvXtRsupVLFXoP4lsNC6pxy+WCaJ6e1j9L8UO6IpvVgao+e2LSfSN0ov29k4GEUsg
	 Joch2JAnyh2rjYSTVO9i1Jt/H2tcD5dXa2xCJOnJkEdtdPhJ7KvB2lxlK7CSVI9kq9
	 G5Yw82q05pNZQJRDNEV6/UU5YWqt6u9mxftsMfLqlXw6XM2weeRB0Qh0G7FWG/kKAO
	 jVbiJHvJRokcVIMQGU9JSiSgdy3pJeGtnWBG/pzWyB2uZn7rMElngmCunLRWGjm9pG
	 z3HeITgtBC86g==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Andrea Righi <arighi@nvidia.com>,
	Sasha Levin <sashal@kernel.org>,
	changwoo@igalia.com,
	me@mostlynerdless.de,
	ggherdovich@suse.com,
	jameshongleiwang@126.com,
	sched-ext@lists.linux.dev,
	bpf@vger.kernel.org
Subject: [PATCH AUTOSEL 6.17-6.12] sched_ext: Make qmap dump operation non-destructive
Date: Mon,  6 Oct 2025 14:17:50 -0400
Message-ID: <20251006181835.1919496-18-sashal@kernel.org>
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

From: Tejun Heo <tj@kernel.org>

[ Upstream commit d452972858e5cfa4262320ab74fe8f016460b96f ]

The qmap dump operation was destructively consuming queue entries while
displaying them. As dump can be triggered anytime, this can easily lead to
stalls. Add a temporary dump_store queue and modify the dump logic to pop
entries, display them, and then restore them back to the original queue.
This allows dump operations to be performed without affecting the
scheduler's queue state.

Note that if racing against new enqueues during dump, ordering can get
mixed up, but this is acceptable for debugging purposes.

Acked-by: Andrea Righi <arighi@nvidia.com>
Signed-off-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

## Backport Analysis: YES

**This commit SHOULD be backported to stable kernel trees** (and
notably, it has already been backported to 6.17 stable as commit
2f64156df4204 by Sasha Levin on Oct 1, 2025).

### Detailed Analysis

#### 1. **Nature of the Bug (Critical Factor)**

The bug is **real and impactful**, not theoretical:

- **Location**: `tools/sched_ext/scx_qmap.bpf.c` lines 567-588
  (qmap_dump function)
- **Problem**: The dump operation uses `bpf_map_pop_elem(fifo, &pid)` to
  display queue contents but **never restores the entries**
- **Impact**: Tasks are permanently removed from scheduler queues,
  causing **system stalls**
- **Trigger**: Can be invoked at any time via SysRq-D (as documented in
  commit 07814a9439a3b) or during error exits

From the old code (lines 581-586):
```c
bpf_repeat(4096) {
    if (bpf_map_pop_elem(fifo, &pid))
        break;
    scx_bpf_dump(" %d", pid);  // ← Never restored!
}
```

This is a destructive read that removes tasks from the runnable queue,
effectively "losing" them from the scheduler.

#### 2. **The Fix is Simple and Safe**

The fix adds 17 insertions, 1 deletion (well under the 100-line limit):

- Adds one new queue map (`dump_store`) for temporary storage
- Modifies dump logic to: pop → store → display → restore
- Two `bpf_repeat` loops: first to pop and display, second to restore
- Low regression risk: only affects dump operations, not scheduling path

**Code changes at lines 579-600:**
```c
// First loop: pop from queue, save to dump_store, display
bpf_map_push_elem(&dump_store, &pid, 0);  // ← Save for restoration
scx_bpf_dump(" %d", pid);

// Second loop: restore from dump_store back to original queue
bpf_map_push_elem(fifo, &pid, 0);  // ← Restore to scheduler queue
```

#### 3. **Meets Stable Kernel Criteria**

Per `Documentation/process/stable-kernel-rules.rst`:

✅ **Already in mainline**: Upstream commit d452972858e5c
✅ **Obviously correct**: Simple save-restore pattern
✅ **Small size**: 41 total lines of diff
✅ **Fixes real bug**: Prevents stalls from destructive dump operations
✅ **User impact**: Anyone triggering dumps (SysRq-D, error exits) on
systems running scx_qmap would experience task loss

#### 4. **Why This Qualifies Despite Being in tools/**

While `tools/` changes are typically not backported, this case is
exceptional:

1. **BPF programs run in kernel space**: `scx_qmap.bpf.c` is not
   userspace tooling—it's a BPF program loaded into the kernel that
   implements actual scheduling decisions

2. **sched_ext schedulers are functional**: Although documented as
   "example schedulers" in the README (lines 6-15), they are
   **production-capable**. The README states: "Some of the examples are
   performant, production-ready schedulers" (line 11)

3. **Debugging is critical infrastructure**: The dump operation (added
   in commit 07814a9439a3b "Print debug dump after an error exit") is
   essential for debugging BPF scheduler failures. A broken dump that
   causes stalls defeats its purpose

4. **Already validated by stable maintainer**: Sasha Levin backported
   this on Oct 1, 2025, confirming it meets stable criteria

#### 5. **Historical Context**

- **sched_ext introduced**: v6.12-rc1 (commit f0e1a0643a59b)
- **Dump operations added**: June 18, 2024 (commit 07814a9439a3b)
- **Bug window**: ~15 months of potential stalls from dump operations
- **Fix date**: September 23, 2025 (upstream d452972858e5c)

#### 6. **No Security CVE, But Real Impact**

My search specialist agent found no CVE assigned to this issue, but that
doesn't diminish its importance:

- Stalls impact system availability
- Debugging a broken scheduler with a broken dump tool compounds
  problems
- Users investigating scheduler issues via SysRq-D would inadvertently
  cause more stalls

#### 7. **Risk Assessment**

**Regression risk**: **Very Low**
- Only modifies dump operations (debugging path)
- Does not touch scheduling hot paths
- Temporary storage pattern is standard and safe
- Race condition with concurrent enqueues is explicitly acceptable (per
  commit message: "ordering can get mixed up, but this is acceptable for
  debugging purposes")

**Benefit**: **High for affected users**
- Makes dump operations actually usable
- Prevents cascading failures during debugging
- Enables proper root cause analysis of scheduler issues

### Conclusion

**YES - This commit should be backported.** It fixes a real bug causing
system stalls, is small and safe, and affects functionality that users
rely on for debugging. The fact that it has already been accepted into
6.17 stable by Sasha Levin validates this assessment. This is an
appropriate stable backport that improves system reliability for users
of sched_ext schedulers.

 tools/sched_ext/scx_qmap.bpf.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/tools/sched_ext/scx_qmap.bpf.c b/tools/sched_ext/scx_qmap.bpf.c
index 69d877501cb72..cd50a94326e3a 100644
--- a/tools/sched_ext/scx_qmap.bpf.c
+++ b/tools/sched_ext/scx_qmap.bpf.c
@@ -56,7 +56,8 @@ struct qmap {
   queue1 SEC(".maps"),
   queue2 SEC(".maps"),
   queue3 SEC(".maps"),
-  queue4 SEC(".maps");
+  queue4 SEC(".maps"),
+  dump_store SEC(".maps");
 
 struct {
 	__uint(type, BPF_MAP_TYPE_ARRAY_OF_MAPS);
@@ -578,11 +579,26 @@ void BPF_STRUCT_OPS(qmap_dump, struct scx_dump_ctx *dctx)
 			return;
 
 		scx_bpf_dump("QMAP FIFO[%d]:", i);
+
+		/*
+		 * Dump can be invoked anytime and there is no way to iterate in
+		 * a non-destructive way. Pop and store in dump_store and then
+		 * restore afterwards. If racing against new enqueues, ordering
+		 * can get mixed up.
+		 */
 		bpf_repeat(4096) {
 			if (bpf_map_pop_elem(fifo, &pid))
 				break;
+			bpf_map_push_elem(&dump_store, &pid, 0);
 			scx_bpf_dump(" %d", pid);
 		}
+
+		bpf_repeat(4096) {
+			if (bpf_map_pop_elem(&dump_store, &pid))
+				break;
+			bpf_map_push_elem(fifo, &pid, 0);
+		}
+
 		scx_bpf_dump("\n");
 	}
 }
-- 
2.51.0


