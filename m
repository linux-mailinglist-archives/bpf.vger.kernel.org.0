Return-Path: <bpf+bounces-59599-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 36841ACD391
	for <lists+bpf@lfdr.de>; Wed,  4 Jun 2025 03:19:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D3E34189C2B5
	for <lists+bpf@lfdr.de>; Wed,  4 Jun 2025 01:15:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C9561DE4E6;
	Wed,  4 Jun 2025 01:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JmPuZqof"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 941CE16D9BF;
	Wed,  4 Jun 2025 01:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748998878; cv=none; b=CZG1Qvq2mXryr9kVK71BaM5ZpJ4oY+SX3Ut6rp/LEegoaLMhxAahraHOe4JS2iMl7gRsT+V6S0dFCOxm+TYMjRz8vAZoX/FO+hPxNVRI+L3aW+t42DRZY62bBxSNJCALA0iAAc8P+ZGEdmrWkk1t490GkmB4HAWL+o3loQl5W9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748998878; c=relaxed/simple;
	bh=xrbVIrODA0xNVk8j0F/sq5bDWaqDJHmLHFLBk9Cc75A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V8IdDqJKq59gROrfZHrzgKeHCGag25df3X61pBVqUvnQDJgAtp2xJ/ygSG2JvSGz6PWzYPtXRANPWia4jFI7VJknRIXCBVGQdJcklNGlTjaezlc07v9BgB9IdgPDauewhl/yEqIQp5O78f/3ypyP7wQ8/G7OqNnluuwfm4ThJkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JmPuZqof; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2AF6C4CEF2;
	Wed,  4 Jun 2025 01:01:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748998878;
	bh=xrbVIrODA0xNVk8j0F/sq5bDWaqDJHmLHFLBk9Cc75A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JmPuZqoffLmrO+IN+UZkfWCRX9PBDN+d2qMl8y2tniX2k5n4o0CNqgYeRgv5nNBz2
	 QX8/ShIOyv6pMY39YBTx4yQYNpKBo4aoMJDg6kNqXlb6AtSlL75u6E9Wo3UXJZUOtu
	 xmAfohgUhAd+35tRQEZooJ/zcEA+F/MX79fUzDvv4SX5WCLpFg+RSNFe4DyXbm4M4A
	 4xVPI0yNIsjCCJE7giAqykIpcgh2osJablxaMMYrtCw5nYeMSW2+pEuozh3e4gx9qa
	 wOo3l4uIQa9GpEaig+oVGz2JdV6nDNLNN7f9VPhzM72t5uCkX+2tPAWeNy6qMU70mj
	 P0ECdbqv5GB9A==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Shung-Hsi Yu <shung-hsi.yu@suse.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Sasha Levin <sashal@kernel.org>,
	martin.lau@linux.dev,
	ast@kernel.org,
	daniel@iogearbox.net,
	bpf@vger.kernel.org
Subject: [PATCH AUTOSEL 6.12 64/93] bpf: Use proper type to calculate bpf_raw_tp_null_args.mask index
Date: Tue,  3 Jun 2025 20:58:50 -0400
Message-Id: <20250604005919.4191884-64-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250604005919.4191884-1-sashal@kernel.org>
References: <20250604005919.4191884-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.31
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Shung-Hsi Yu <shung-hsi.yu@suse.com>

[ Upstream commit 53ebef53a657d7957d35dc2b953db64f1bb28065 ]

The calculation of the index used to access the mask field in 'struct
bpf_raw_tp_null_args' is done with 'int' type, which could overflow when
the tracepoint being attached has more than 8 arguments.

While none of the tracepoints mentioned in raw_tp_null_args[] currently
have more than 8 arguments, there do exist tracepoints that had more
than 8 arguments (e.g. iocost_iocg_forgive_debt), so use the correct
type for calculation and avoid Smatch static checker warning.

Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Signed-off-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Link: https://lore.kernel.org/bpf/20250418074946.35569-1-shung-hsi.yu@suse.com

Closes: https://lore.kernel.org/r/843a3b94-d53d-42db-93d4-be10a4090146@stanley.mountain/
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

Now I have enough context to analyze this commit: **Analysis:** **YES**
- This commit should be backported to stable kernel trees. **Extensive
Explanation:** ## Issue Description The commit fixes a potential integer
overflow in the BPF BTF subsystem. The bug is in lines 6830 and 6833 of
`kernel/bpf/btf.c` where the calculation `(arg capability_test
capability_test.c f2fs_folio_analysis.md ipv4_multipath_analysis.md
ipv6_route_allocation_rcu_analysis.md ixgbe_e610_set_phys_id_analysis.md
linux lpfc_timeout_analysis.md rtl_bb_delay_analysis.md
rtw89_mlo_analysis.md tcp_multipath_load_balance_analysis.md
type_size_check type_size_check.c veth_driver_analysis.md 4)` is done
with `int` type when `arg` can theoretically be large enough to cause
overflow. ## Code Analysis 1. **Variable Types**: - `arg` is declared as
`u32` (from `btf_ctx_arg_idx` return type) - The shift operation was
using `int` arithmetic: `(0x1 << (arg capability_test capability_test.c
f2fs_folio_analysis.md ipv4_multipath_analysis.md
ipv6_route_allocation_rcu_analysis.md ixgbe_e610_set_phys_id_analysis.md
linux lpfc_timeout_analysis.md rtl_bb_delay_analysis.md
rtw89_mlo_analysis.md tcp_multipath_load_balance_analysis.md
type_size_check type_size_check.c veth_driver_analysis.md 4))` - The fix
changes it to `unsigned long long`: `(0x1ULL << (arg capability_test
capability_test.c f2fs_folio_analysis.md ipv4_multipath_analysis.md
ipv6_route_allocation_rcu_analysis.md ixgbe_e610_set_phys_id_analysis.md
linux lpfc_timeout_analysis.md rtl_bb_delay_analysis.md
rtw89_mlo_analysis.md tcp_multipath_load_balance_analysis.md
type_size_check type_size_check.c veth_driver_analysis.md 4))` 2. **The
Overflow Scenario**: - When `arg >= 8`, the expression `(arg
capability_test capability_test.c f2fs_folio_analysis.md
ipv4_multipath_analysis.md ipv6_route_allocation_rcu_analysis.md
ixgbe_e610_set_phys_id_analysis.md linux lpfc_timeout_analysis.md
rtl_bb_delay_analysis.md rtw89_mlo_analysis.md
tcp_multipath_load_balance_analysis.md type_size_check type_size_check.c
veth_driver_analysis.md 4)` could be >= 32 - Shifting by >= 32 bits on a
32-bit `int` causes undefined behavior - Even on 64-bit systems, large
values could overflow the intermediate calculation 3. **Specific
Changes**: ```c // Before (vulnerable): if (raw_tp_null_args[i].mask &
(0x1 << (arg capability_test capability_test.c f2fs_folio_analysis.md
ipv4_multipath_analysis.md ipv6_route_allocation_rcu_analysis.md
ixgbe_e610_set_phys_id_analysis.md linux lpfc_timeout_analysis.md
rtl_bb_delay_analysis.md rtw89_mlo_analysis.md
tcp_multipath_load_balance_analysis.md type_size_check type_size_check.c
veth_driver_analysis.md 4))) if (raw_tp_null_args[i].mask & (0x2 << (arg
capability_test capability_test.c f2fs_folio_analysis.md
ipv4_multipath_analysis.md ipv6_route_allocation_rcu_analysis.md
ixgbe_e610_set_phys_id_analysis.md linux lpfc_timeout_analysis.md
rtl_bb_delay_analysis.md rtw89_mlo_analysis.md
tcp_multipath_load_balance_analysis.md type_size_check type_size_check.c
veth_driver_analysis.md 4))) // After (fixed): if
(raw_tp_null_args[i].mask & (0x1ULL << (arg capability_test
capability_test.c f2fs_folio_analysis.md ipv4_multipath_analysis.md
ipv6_route_allocation_rcu_analysis.md ixgbe_e610_set_phys_id_analysis.md
linux lpfc_timeout_analysis.md rtl_bb_delay_analysis.md
rtw89_mlo_analysis.md tcp_multipath_load_balance_analysis.md
type_size_check type_size_check.c veth_driver_analysis.md 4))) if
(raw_tp_null_args[i].mask & (0x2ULL << (arg capability_test
capability_test.c f2fs_folio_analysis.md ipv4_multipath_analysis.md
ipv6_route_allocation_rcu_analysis.md ixgbe_e610_set_phys_id_analysis.md
linux lpfc_timeout_analysis.md rtl_bb_delay_analysis.md
rtw89_mlo_analysis.md tcp_multipath_load_balance_analysis.md
type_size_check type_size_check.c veth_driver_analysis.md 4))) ``` ##
Why This Should Be Backported 1. **Bug Fix**: This is a clear bug fix
addressing undefined behavior that could cause incorrect BPF program
verification. 2. **Small and Contained**: The fix is minimal - only
changes two lines by adding `ULL` suffix to ensure 64-bit arithmetic. 3.
**No Side Effects**: The change maintains the same logic but uses proper
types, eliminating undefined behavior without changing functionality. 4.
**Critical Subsystem**: This affects BPF verification, which is
security-critical. Incorrect verification could lead to security issues.
5. **Static Analysis Detection**: The commit was triggered by a Smatch
static checker warning, indicating this is a real issue that static
analysis tools flag. 6. **Potential Real-World Impact**: While the
commit mentions no current tracepoints have >8 arguments, the code path
could be triggered by future tracepoints or module tracepoints, making
this a defensive fix. 7. **Follows Stable Criteria**: - Important bugfix
✓ - Minimal risk ✓ - No architectural changes ✓ - Confined to BPF
subsystem ✓ ## Comparison with Similar Commits Looking at the historical
examples, this commit is most similar to "Similar Commit #5" which was
marked as "Backport Status: YES" - it's a small type safety fix in BPF
BTF code that prevents undefined behavior. The fix prevents a subtle but
potentially serious issue in BPF program verification, making it an
excellent candidate for stable backporting.

 kernel/bpf/btf.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 2c54c148a94f3..f83bd019db141 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -6684,10 +6684,10 @@ bool btf_ctx_access(int off, int size, enum bpf_access_type type,
 			/* Is this a func with potential NULL args? */
 			if (strcmp(tname, raw_tp_null_args[i].func))
 				continue;
-			if (raw_tp_null_args[i].mask & (0x1 << (arg * 4)))
+			if (raw_tp_null_args[i].mask & (0x1ULL << (arg * 4)))
 				info->reg_type |= PTR_MAYBE_NULL;
 			/* Is the current arg IS_ERR? */
-			if (raw_tp_null_args[i].mask & (0x2 << (arg * 4)))
+			if (raw_tp_null_args[i].mask & (0x2ULL << (arg * 4)))
 				ptr_err_raw_tp = true;
 			break;
 		}
-- 
2.39.5


