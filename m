Return-Path: <bpf+bounces-59605-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E546ACD44E
	for <lists+bpf@lfdr.de>; Wed,  4 Jun 2025 03:27:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0BF6C1896D4A
	for <lists+bpf@lfdr.de>; Wed,  4 Jun 2025 01:23:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC29426A0CC;
	Wed,  4 Jun 2025 01:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZH6yICfF"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7211026A0AE;
	Wed,  4 Jun 2025 01:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748999051; cv=none; b=Fl9DJZsmV5Ox1id231TzF9GksPeLZIFEue1Ob8RLVeFdqS49CdpHyg0MXvbqspvyrAKSHCd9CqgIk3CWfWqYAfOrryZgg/FQFf1z8KfvesO5ezLkyZnAh9I+JByWXYpFWsb8I1TfMtSsmj/fcMbXfVLYgX9AAxbcVezgxDjseKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748999051; c=relaxed/simple;
	bh=qd3BFSh58DalsF60jW7VYQ2dcwD3H1trjQydJgggFR0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dVQGhp2oyqk/VOl5SeKipAl385QFuODeJUW+p4AHLFZuGDP4NbDLxz6uJfzD0lAWi5FNaQVXRYRMw6LAB1aFXkIOWRmsbuBEuzrFwc7d982l8nIIwBpL7IXACWKYsM6a6oentt72zsIiky8JR9giLVX6n+7fBYbBCS7k/rSbJGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZH6yICfF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 461CCC4CEF2;
	Wed,  4 Jun 2025 01:04:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748999051;
	bh=qd3BFSh58DalsF60jW7VYQ2dcwD3H1trjQydJgggFR0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZH6yICfFHNRfRaDVxzIOsSbNx0xKejwJCJvh2hbDDfzeCLF7oR5qEiQSSqmOxkLAR
	 WJwCzWcHXJ7NT4Uz1fP8ncfj1e8t3Rfm0aXpnR5YKMWufR0pc8GLAxIL3B3irayZiu
	 trd/lg7t5P0sBjl0XpapR/rpPh4VYGTpzjHjS5DPPcG4bCkivvdqhlQQalX/X6DA0g
	 X/bWyuJmshHbr4V1z/JKtWg6HVbZSdg9E2KE8Yr8RVhqQsNaTuVkaKeHiBz2ZDqQ8X
	 i/uqowe0A15F5FzhwQTgvAiRUaHwyMijRCAMQI/sghLzy8mg7rBNcz5AJt68sah8FJ
	 PATGPoo6oKtXQ==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Hou Tao <houtao1@huawei.com>,
	syzbot+dce5aae19ae4d6399986@syzkaller.appspotmail.com,
	Alexei Starovoitov <ast@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	daniel@iogearbox.net,
	andrii@kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 04/46] bpf: Check rcu_read_lock_trace_held() in bpf_map_lookup_percpu_elem()
Date: Tue,  3 Jun 2025 21:03:22 -0400
Message-Id: <20250604010404.5109-4-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250604010404.5109-1-sashal@kernel.org>
References: <20250604010404.5109-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.140
Content-Transfer-Encoding: 8bit

From: Hou Tao <houtao1@huawei.com>

[ Upstream commit d4965578267e2e81f67c86e2608481e77e9c8569 ]

bpf_map_lookup_percpu_elem() helper is also available for sleepable bpf
program. When BPF JIT is disabled or under 32-bit host,
bpf_map_lookup_percpu_elem() will not be inlined. Using it in a
sleepable bpf program will trigger the warning in
bpf_map_lookup_percpu_elem(), because the bpf program only holds
rcu_read_lock_trace lock. Therefore, add the missed check.

Reported-by: syzbot+dce5aae19ae4d6399986@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/bpf/000000000000176a130617420310@google.com/
Signed-off-by: Hou Tao <houtao1@huawei.com>
Link: https://lore.kernel.org/r/20250526062534.1105938-1-houtao@huaweicloud.com
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

**YES** This commit should be backported to stable kernel trees based on
my analysis: ## Analysis **1. Clear Bug Fix:** This commit fixes a
legitimate bug where `bpf_map_lookup_percpu_elem()` triggers warnings in
sleepable BPF programs when the BPF JIT is disabled or on 32-bit hosts.
The warning occurs because sleepable BPF programs hold
`rcu_read_lock_trace` instead of `rcu_read_lock`, but the function only
checked for the latter. **2. Minimal, Contained Change:** The fix is
extremely small and surgical - it only adds
`!rcu_read_lock_trace_held()` to the existing warning condition in
`bpf_map_lookup_percpu_elem()` at kernel/bpf/helpers.c:132-133. This
follows the exact same pattern established by the previous similar fix.
**3. Strong Historical Precedent:** Multiple similar commits have been
successfully backported: - **Commit 169410eba271** (Similar Commit #1 -
Backport Status: YES) - Added the same `rcu_read_lock_trace_held()`
check to `bpf_map_{lookup,update,delete}_elem()` helpers with identical
reasoning - **Commit 29a7e00ffadd** (Similar Commit #4 - Backport
Status: YES) - Fixed missed RCU read lock in `bpf_task_under_cgroup()`
for sleepable programs **4. Clear User Impact:** The commit was reported
by syzbot and fixes a concrete issue affecting users running sleepable
BPF programs. Without this fix, users see spurious warnings that
indicate potential RCU usage bugs. **5. Low Regression Risk:** The
change only expands the conditions under which the warning is suppressed
- it doesn't change any functional behavior, just makes the assertion
more accurate for sleepable BPF programs. **6. Part of Ongoing
Pattern:** This is the missing piece in a series of similar fixes that
have systematically addressed RCU assertions for sleepable BPF programs.
The previous commit 169410eba271 fixed the basic map helpers but missed
this percpu variant. **7. Stable Tree Criteria Alignment:** - Fixes
important functionality (eliminates false warnings) - No architectural
changes - Minimal risk of regression - Confined to BPF subsystem - Clear
side effects (none beyond fixing the warning) The commit perfectly
matches the stable tree backporting criteria and follows the established
pattern of similar successful backports.

 kernel/bpf/helpers.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 4fef0a0155255..94e85d311641b 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -125,7 +125,8 @@ const struct bpf_func_proto bpf_map_peek_elem_proto = {
 
 BPF_CALL_3(bpf_map_lookup_percpu_elem, struct bpf_map *, map, void *, key, u32, cpu)
 {
-	WARN_ON_ONCE(!rcu_read_lock_held() && !rcu_read_lock_bh_held());
+	WARN_ON_ONCE(!rcu_read_lock_held() && !rcu_read_lock_trace_held() &&
+		     !rcu_read_lock_bh_held());
 	return (unsigned long) map->ops->map_lookup_percpu_elem(map, key, cpu);
 }
 
-- 
2.39.5


