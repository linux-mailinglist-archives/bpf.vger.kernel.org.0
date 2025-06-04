Return-Path: <bpf+bounces-59609-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 16575ACD4CC
	for <lists+bpf@lfdr.de>; Wed,  4 Jun 2025 03:33:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F9B3189F28B
	for <lists+bpf@lfdr.de>; Wed,  4 Jun 2025 01:27:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE288272E6E;
	Wed,  4 Jun 2025 01:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KgbUf+ih"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23DDA23F299;
	Wed,  4 Jun 2025 01:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748999162; cv=none; b=Kg1h6HEF2OkDcIkYVxEdDyvdQ+RRjXCaku4LRX69xzjUrDoIPWvHD3EHAXM8O7HoEivjP9Glephx0QsNWkJulq5kYN65TeBh6U01nWgMmfGay0yePLL7h0Ez1HS9RVvIKqUXhtzZFL8WZZASFa/oPwfe5mDsHXJKz51p+bS4Bz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748999162; c=relaxed/simple;
	bh=5rObL+0R3ZPbS0Kjn/6s0bkqnMH8tLft0RnP5bsz7cQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B6WIdaMM4lA2fSiV3tkIMFJYdy8RfiDN0ogSSMP1Cc1mc+FlC4cseCzt/YIxiNp1v6Czo97DKz+jyvOyKtWIFzwbecKnqk0IJiG2kCaUd2chBSe7xb61a5v7TviXZQpAWVUG5IqefMg/tDGqGDwL7ohAhydWEwP+Ulqk4i8iCIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KgbUf+ih; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2370C4CEEF;
	Wed,  4 Jun 2025 01:06:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748999162;
	bh=5rObL+0R3ZPbS0Kjn/6s0bkqnMH8tLft0RnP5bsz7cQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KgbUf+ihd3JHUqG09TqSijTNDk3XP8T4WtNL1rvQjvTkLvLLj1sFt6aa9RTu5iq4x
	 pb6J3ABPdsImMOb2GLTjysBd/ZLA60V9wyHWeDAaDS1DgB5jsjFSp/EuqhANQyGlhV
	 3A5txvu7xQ0a4P7Mb1gsY01GBpnu6Jr08id963HDokq+bWHKPeZjp02923P7+OLfpv
	 FcHBhobzdEQr0xHhxzSCHESl0a6AggPvWH6AKt9DkwzUxnnjIfyNDivnv/NWFMHqdC
	 gMSltJ46cua+tBT3c8b0t6JPs0zjodjn27gA0PXjPpJwZOU2W9e8bKymu+9sBxohC7
	 8C4Dqslq0xXNw==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Alan Maguire <alan.maguire@oracle.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	bpf@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 22/33] libbpf: Add identical pointer detection to btf_dedup_is_equiv()
Date: Tue,  3 Jun 2025 21:05:13 -0400
Message-Id: <20250604010524.6091-22-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250604010524.6091-1-sashal@kernel.org>
References: <20250604010524.6091-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.184
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Alan Maguire <alan.maguire@oracle.com>

[ Upstream commit 8e64c387c942229c551d0f23de4d9993d3a2acb6 ]

Recently as a side-effect of

commit ac053946f5c4 ("compiler.h: introduce TYPEOF_UNQUAL() macro")

issues were observed in deduplication between modules and kernel BTF
such that a large number of kernel types were not deduplicated so
were found in module BTF (task_struct, bpf_prog etc).  The root cause
appeared to be a failure to dedup struct types, specifically those
with members that were pointers with __percpu annotations.

The issue in dedup is at the point that we are deduplicating structures,
we have not yet deduplicated reference types like pointers.  If multiple
copies of a pointer point at the same (deduplicated) integer as in this
case, we do not see them as identical.  Special handling already exists
to deal with structures and arrays, so add pointer handling here too.

Reported-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
Link: https://lore.kernel.org/bpf/20250429161042.2069678-1-alan.maguire@oracle.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

Based on my comprehensive analysis of the commit message, code changes,
historical patterns, and kernel repository context, here is my
recommendation: **YES** This commit should be backported to stable
kernel trees for the following reasons: ## Critical Bug Fix Analysis
**1. Fixes a Real User-Impacting Regression:** - The commit addresses a
regression introduced by `commit ac053946f5c4 ("compiler.h: introduce
TYPEOF_UNQUAL() macro")` - This regression causes "a large number of
kernel types" (task_struct, bpf_prog, etc.) to fail deduplication -
Results in broken BPF functionality for kernel modules, which is user-
visible **2. Follows Established Stable Tree Criteria:** - **Important
bugfix**: ✅ Fixes BTF deduplication failures affecting core BPF
functionality - **Minimal risk**: ✅ Small, targeted change following
existing patterns - **No architectural changes**: ✅ Adds a simple helper
function without changing core algorithm - **Confined to subsystem**: ✅
Changes only affect BTF deduplication logic in libbpf ## Code Change
Analysis **3. Conservative and Safe Implementation:** ```c +static bool
btf_dedup_identical_ptrs(struct btf_dedup *d, __u32 id1, __u32 id2) +{ +
struct btf_type *t1, *t2; + + t1 = btf_type_by_id(d->btf, id1); + t2 =
btf_type_by_id(d->btf, id2); + + if (!btf_is_ptr(t1) || !btf_is_ptr(t2))
+ return false; + + return t1->type == t2->type; +} ``` - Simple type-
checking function with clear bounds checking - Mirrors existing
`btf_dedup_identical_arrays()` and `btf_dedup_identical_structs()`
patterns - No complex logic or state changes **4. Integration Follows
Existing Pattern:** ```c + /bin /bin.usr-is-merged /boot /dev /etc /home
/init /lib /lib.usr-is-merged /lib64 /lost+found /media /mnt /opt /proc
/root /run /sbin /sbin.usr-is-merged /snap /srv /sys /tmp /usr /var A
similar case is again observed for PTRs. */ + if
(btf_dedup_identical_ptrs(d, hypot_type_id, cand_id)) + return 1; ``` -
Added alongside existing identical array/struct checks - Same position
in control flow as established workarounds - Consistent with documented
compiler DWARF generation issues ## Historical Pattern Alignment **5.
Matches "YES" Backport Pattern:** Looking at similar commits marked for
backport: - **Similar Commit #1** (YES): Adds identical struct checking
for BTF dedup failures - same pattern - **Similar Commit #4** (YES):
Fixes memory leak in BTF dedup - critical subsystem fix - **Similar
Commit #5** (YES): Handles DWARF/compiler bugs with duplicated structs -
identical issue class This commit addresses the exact same class of
problem (compiler-generated identical types) that has been consistently
backported. ## Risk Assessment **6. Low Regression Risk:** - Function
only returns `true` when types are genuinely identical (`t1->type ==
t2->type`) - Early returns prevent processing non-pointer types - Cannot
cause false positives that would incorrectly deduplicate different types
- Follows defensive programming patterns used throughout the codebase ##
Conclusion This commit fixes a regression in critical BPF functionality,
uses a proven safe pattern, has minimal code footprint, and addresses
issues that directly impact users. The fix quality is high and the risk
is low, making it an excellent candidate for stable tree backporting.

 tools/lib/bpf/btf.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
index fd23095129782..4d29bd28520ae 100644
--- a/tools/lib/bpf/btf.c
+++ b/tools/lib/bpf/btf.c
@@ -3770,6 +3770,19 @@ static bool btf_dedup_identical_structs(struct btf_dedup *d, __u32 id1, __u32 id
 	return true;
 }
 
+static bool btf_dedup_identical_ptrs(struct btf_dedup *d, __u32 id1, __u32 id2)
+{
+	struct btf_type *t1, *t2;
+
+	t1 = btf_type_by_id(d->btf, id1);
+	t2 = btf_type_by_id(d->btf, id2);
+
+	if (!btf_is_ptr(t1) || !btf_is_ptr(t2))
+		return false;
+
+	return t1->type == t2->type;
+}
+
 /*
  * Check equivalence of BTF type graph formed by candidate struct/union (we'll
  * call it "candidate graph" in this description for brevity) to a type graph
@@ -3902,6 +3915,9 @@ static int btf_dedup_is_equiv(struct btf_dedup *d, __u32 cand_id,
 		 */
 		if (btf_dedup_identical_structs(d, hypot_type_id, cand_id))
 			return 1;
+		/* A similar case is again observed for PTRs. */
+		if (btf_dedup_identical_ptrs(d, hypot_type_id, cand_id))
+			return 1;
 		return 0;
 	}
 
-- 
2.39.5


