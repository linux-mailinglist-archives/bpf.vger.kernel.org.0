Return-Path: <bpf+bounces-59608-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28844ACD44A
	for <lists+bpf@lfdr.de>; Wed,  4 Jun 2025 03:27:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7F0F07A3BAE
	for <lists+bpf@lfdr.de>; Wed,  4 Jun 2025 01:24:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 610E986338;
	Wed,  4 Jun 2025 01:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T6mohSgp"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D054722DA0B;
	Wed,  4 Jun 2025 01:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748999119; cv=none; b=UmslrhNqHcb9eJQ2ohs0xdTr7HzA7uaVkQEnqQNlqg+EYpULvmXZVvzWDIK1y9BDrvglybOGzZbSk87zXTwkziFOwoYbDSKuGFhhSoUt7/WliZsziTIAGduIWg0m6i5mR5IDosAnml6LCn3nhhfzWPmVhFxSrMYeT06ULWh+/ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748999119; c=relaxed/simple;
	bh=slcB+BKMBJ/rh9gvE08uCtdFYOoqKoBEDIaASYrVBCY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sLy6qs90L6nyXac7qHvi7L0QJRn+aJ+LBSutpkDzcTmjtdG2EPe1P58tuctEyUtNwBomeXEA5msgUWcFhPZcrLtMy++M1hmA1Gt3veIFS1x9DttuLl5M25oWjTkM8EY8m49L04tLZAps1zBjAOqs97+5GgJJsCOWPNO7xRdGaeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T6mohSgp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD206C4CEED;
	Wed,  4 Jun 2025 01:05:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748999119;
	bh=slcB+BKMBJ/rh9gvE08uCtdFYOoqKoBEDIaASYrVBCY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=T6mohSgpJ1cyvgDAJt8+/r5bdZRctjSt15ZCyNOzN2K3mWjldl+xvaES7Q0X9eh1m
	 WRd5f3rD1TaiTEFjixKxXO4y7Wc8hQXUV5hGG0EN+nnh1KxKTOo8f7ajL+yURnFf98
	 OIBLBzrnqr4BrEkoQwN3GU+t7KN9gkPxIRUeAd9ocVaJLKjZPQszIibMSbREjaZext
	 MatqLeY0spdxH5SD9x4TC4pNg2nWE6/WK6PpOvlBfQYnkgGmdHJqnQ4Cpt5ON5QFWf
	 vgprWu46nGOSY5Go7Sasl9a8QRbuLekPs4U3JEpU82K+Qf0pjzqjcK+i9ubwNf2s81
	 qXHdlvB3A3tJA==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>,
	Alexei Starovoitov <ast@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	john.fastabend@gmail.com,
	jakub@cloudflare.com,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 44/46] bpf, sockmap: Fix data lost during EAGAIN retries
Date: Tue,  3 Jun 2025 21:04:02 -0400
Message-Id: <20250604010404.5109-44-sashal@kernel.org>
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Jiayuan Chen <jiayuan.chen@linux.dev>

[ Upstream commit 7683167196bd727ad5f3c3fc6a9ca70f54520a81 ]

We call skb_bpf_redirect_clear() to clean _sk_redir before handling skb in
backlog, but when sk_psock_handle_skb() return EAGAIN due to sk_rcvbuf
limit, the redirect info in _sk_redir is not recovered.

Fix skb redir loss during EAGAIN retries by restoring _sk_redir
information using skb_bpf_set_redir().

Before this patch:
'''
./bench sockmap -c 2 -p 1 -a --rx-verdict-ingress
Setting up benchmark 'sockmap'...
create socket fd c1:13 p1:14 c2:15 p2:16
Benchmark 'sockmap' started.
Send Speed 1343.172 MB/s, BPF Speed 1343.238 MB/s, Rcv Speed   65.271 MB/s
Send Speed 1352.022 MB/s, BPF Speed 1352.088 MB/s, Rcv Speed   0 MB/s
Send Speed 1354.105 MB/s, BPF Speed 1354.105 MB/s, Rcv Speed   0 MB/s
Send Speed 1355.018 MB/s, BPF Speed 1354.887 MB/s, Rcv Speed   0 MB/s
'''
Due to the high send rate, the RX processing path may frequently hit the
sk_rcvbuf limit. Once triggered, incorrect _sk_redir will cause the flow
to mistakenly enter the "!ingress" path, leading to send failures.
(The Rcv speed depends on tcp_rmem).

After this patch:
'''
./bench sockmap -c 2 -p 1 -a --rx-verdict-ingress
Setting up benchmark 'sockmap'...
create socket fd c1:13 p1:14 c2:15 p2:16
Benchmark 'sockmap' started.
Send Speed 1347.236 MB/s, BPF Speed 1347.367 MB/s, Rcv Speed   65.402 MB/s
Send Speed 1353.320 MB/s, BPF Speed 1353.320 MB/s, Rcv Speed   65.536 MB/s
Send Speed 1353.186 MB/s, BPF Speed 1353.121 MB/s, Rcv Speed   65.536 MB/s
'''

Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
Link: https://lore.kernel.org/r/20250407142234.47591-2-jiayuan.chen@linux.dev
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

**YES** This commit should be backported to stable kernel trees. ##
Extensive Analysis ### **Critical Bug Fix Nature** This is a **data loss
bug** in the BPF sockmap subsystem that causes silent packet drops under
load conditions. The commit adds a single line that restores essential
redirect information during EAGAIN retry scenarios. ### **Code Change
Analysis** The fix adds exactly one line at `net/core/skmsg.c:694`: ```c
skb_bpf_set_redir(skb, psock->sk, ingress); ``` This line restores
redirect information that was previously cleared by
`skb_bpf_redirect_clear(skb)` at line 684. When `sk_psock_handle_skb()`
returns `-EAGAIN` due to memory pressure or socket buffer limits, the
work is rescheduled, but without this fix, the redirect information
(`skb->_sk_redir`) would be lost. ### **Impact Without the Fix** 1.
**Silent Data Loss**: When EAGAIN occurs, subsequent retry attempts find
no redirect target (`skb_bpf_redirect_fetch()` returns NULL), causing
packets to be dropped in `sk_psock_skb_redirect()` at lines 935-938. 2.
**BPF Policy Bypass**: Packets that should be redirected according to
BPF program logic get dropped instead, effectively bypassing network
policies. 3. **Production Impact**: The commit message shows concrete
performance degradation - receive speeds dropping from 65+ MB/s to 0
MB/s under high load conditions. ### **Backport Suitability Factors**
**✅ Minimal and Surgical:** - Single line addition - No API changes or
structural modifications - Uses existing stable function
`skb_bpf_set_redir()` **✅ Self-Contained:** - Fix only affects the
specific error path (`ret == -EAGAIN`) - No dependencies on other
concurrent changes - Uses well-established APIs present across kernel
versions **✅ Clear Bug Fix Semantics:** - Restores state that was
previously cleared - Follows the established pattern: clear → try →
restore on failure - The comment explicitly states "Restore redir info
we cleared before" **✅ Critical Subsystem:** - Affects BPF sockmap, a
core networking infrastructure component - Used by service meshes,
container networking, and load balancers - Failure causes silent data
loss that's difficult to debug ### **Comparison with Similar Commits**
Looking at the provided historical examples: - Similar to commit #2 and
#4 (both marked YES) which also fix sockmap data handling issues -
Unlike commit #1, #3, and #5 (marked NO) which involved more complex
architectural changes - This fix addresses a fundamental correctness
issue rather than optimizations ### **Risk Assessment** **Low Risk:** -
The fix is in an error recovery path, so it only executes when problems
already exist - Restoring redirect information cannot make the situation
worse - The function `skb_bpf_set_redir()` is a simple state restoration
operation ### **Stable Tree Criteria Compliance** 1. **Important
bugfix**: ✅ Fixes silent data loss 2. **Minimal risk**: ✅ Single line,
error path only 3. **No new features**: ✅ Pure bug fix 4. **Confined
scope**: ✅ Limited to sockmap redirect handling 5. **User-visible
impact**: ✅ Prevents packet loss under load This commit perfectly fits
the stable tree criteria for important, low-risk bug fixes that address
user-visible problems in critical subsystems.

 net/core/skmsg.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/core/skmsg.c b/net/core/skmsg.c
index 5a790cd1121b1..0065a5a65afc0 100644
--- a/net/core/skmsg.c
+++ b/net/core/skmsg.c
@@ -678,7 +678,8 @@ static void sk_psock_backlog(struct work_struct *work)
 			if (ret <= 0) {
 				if (ret == -EAGAIN) {
 					sk_psock_skb_state(psock, state, len, off);
-
+					/* Restore redir info we cleared before */
+					skb_bpf_set_redir(skb, psock->sk, ingress);
 					/* Delay slightly to prioritize any
 					 * other work that might be here.
 					 */
-- 
2.39.5


