Return-Path: <bpf+bounces-70675-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A6823BCA05F
	for <lists+bpf@lfdr.de>; Thu, 09 Oct 2025 18:12:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 380D71A647CF
	for <lists+bpf@lfdr.de>; Thu,  9 Oct 2025 16:06:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DD222F9D83;
	Thu,  9 Oct 2025 15:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GgQvjLTe"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BCC62264D3;
	Thu,  9 Oct 2025 15:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760025547; cv=none; b=s/45o5ZICHUj5JzUTDofSqu1/htD4aBGy7/44YI6mt+ZT9jekVG/PDtMki/8XAKumWriK4HztGS/SfSdV9ZPZJTrHZ/N0hKpnA05bHv0hwaQxsnOMTapZkj3Y+fbNbmgegvrQMPBjeN29+tPjciopfaeUL0NSaOn6SAFPsWdWqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760025547; c=relaxed/simple;
	bh=HO4+Tz4jqsYdxeLaF83ztinV6zh0jqaeIA+sMbiq7lI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XObbmA/TsA87cZN+xE3buNrvN4xrBKedLRVLPMUkvzAxOYqMN7jPlt7MpqjYt8G7lb6IHsh/6kXO86Mko527m6SA2dl/PEoEdFVQvp/UweynYJJ45r23cq2ybQ9roU+6R6Dl+XRQrf8ul0V9Fq34lestUHnSldNqvYo8twFyYg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GgQvjLTe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A2C3C4CEF8;
	Thu,  9 Oct 2025 15:59:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760025546;
	bh=HO4+Tz4jqsYdxeLaF83ztinV6zh0jqaeIA+sMbiq7lI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GgQvjLTeICefoY6klw103aff944WF6zlyHIkctkguQq2tYPlkcKy6D/u7MVsMPK1t
	 uO8PkYMacQD2F785YQ0iee6pDN6MaDS3zQBME7piNKs2SN/bmL4aUHvcOpe/jDglg+
	 OR2NKuLGI+RAbtZPHmYiZUVFMNXDriyTI+0Fah5M9NPkG3T+K4czv/owYQQIsc6yNj
	 zUmLK/0OIn9FYFyOf996bCLBjlO9kQqiMfollCxVAsrK2euS1is79Nvny7lRKjq1df
	 7/hNNjlJape19ZpmUtCxAKbblzcnpc69JSORzmQnjaZLoV3F8BL/4zbW8UgsF0Zire
	 GQhHQ58FYKATA==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Amery Hung <ameryhung@gmail.com>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	ast@kernel.org,
	daniel@iogearbox.net,
	davem@davemloft.net,
	kuba@kernel.org,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	edumazet@google.com,
	pabeni@redhat.com,
	andrii@kernel.org,
	martin.lau@linux.dev,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH AUTOSEL 6.17-6.1] bpf: Clear pfmemalloc flag when freeing all fragments
Date: Thu,  9 Oct 2025 11:55:05 -0400
Message-ID: <20251009155752.773732-39-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251009155752.773732-1-sashal@kernel.org>
References: <20251009155752.773732-1-sashal@kernel.org>
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

From: Amery Hung <ameryhung@gmail.com>

[ Upstream commit 8f12d1137c2382c80aada8e05d7cc650cd4e403c ]

It is possible for bpf_xdp_adjust_tail() to free all fragments. The
kfunc currently clears the XDP_FLAGS_HAS_FRAGS bit, but not
XDP_FLAGS_FRAGS_PF_MEMALLOC. So far, this has not caused a issue when
building sk_buff from xdp_buff since all readers of xdp_buff->flags
use the flag only when there are fragments. Clear the
XDP_FLAGS_FRAGS_PF_MEMALLOC bit as well to make the flags correct.

Signed-off-by: Amery Hung <ameryhung@gmail.com>
Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
Reviewed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Link: https://patch.msgid.link/20250922233356.3356453-2-ameryhung@gmail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

YES

- What it fixes
  - When shrinking non-linear XDP buffers, bpf_xdp_adjust_tail() can
    free all frags but previously only cleared the HAS_FRAGS bit,
    leaving XDP_FLAGS_FRAGS_PF_MEMALLOC set. This makes xdp_buff->flags
    inconsistent: “no frags, but pfmemalloc set”.
  - The fix adds an explicit clear for the pfmemalloc-frags bit when the
    last frag is freed, ensuring flags correctly reflect state.

- Precise code changes
  - Adds an inline helper to clear the pfmemalloc-frags bit:
    - include/net/xdp.h:139: xdp_buff_clear_frag_pfmemalloc(struct
      xdp_buff *xdp) clears XDP_FLAGS_FRAGS_PF_MEMALLOC by masking it
      off.
  - Invokes the helper when all fragments are freed in the shrink path:
    - net/core/filter.c: in bpf_xdp_frags_shrink_tail(), after computing
      that all frags are gone, it previously did:
      - xdp_buff_clear_frags_flag(xdp);
      - xdp->data_end -= offset;
      Now it also does:
      - xdp_buff_clear_frag_pfmemalloc(xdp);
    - Concretely, in this tree: net/core/filter.c:4198 starts
      bpf_xdp_frags_shrink_tail; when sinfo->nr_frags drops to zero, it
      now calls both xdp_buff_clear_frags_flag(xdp) and
      xdp_buff_clear_frag_pfmemalloc(xdp) before adjusting data_end.

- Why it matters
  - pfmemalloc indicates frags came from memory under pressure. With no
    frags, the flag must be false; leaving it set is incorrect state.
  - Current skb-build paths only read the pfmemalloc flag when there are
    frags (e.g., xdp_build_skb_from_buff uses pfmemalloc bit only if
    xdp_buff_has_frags is true; see net/core/xdp.c:666-667, 720, 826 in
    this tree). That’s why this hasn’t caused user-visible bugs yet.
    However, correctness of flags avoids subtle future regressions and
    makes the state coherent for any readers that don’t gate on
    HAS_FRAGS.

- Scope and risk assessment
  - Small, contained change: one new inline helper in a header and one
    extra call in a single function.
  - No API or ABI changes; no architectural refactoring.
  - Touches BPF/XDP fast path but only modifies a bit when
    sinfo->nr_frags becomes zero, which is the correct behavior by
    definition.
  - Extremely low regression risk; clearing a now-irrelevant bit cannot
    break consumers and only improves state consistency.

- Backport considerations
  - The bug and code paths exist in stable lines which support non-
    linear XDP buffers:
    - v6.1.y and v6.6.y have XDP_FLAGS_FRAGS_PF_MEMALLOC and the same
      shrink path which only clears HAS_FRAGS, not PF_MEMALLOC (e.g.,
      v6.6.99 net/core/filter.c shows only xdp_buff_clear_frags_flag();
      include/net/xdp.h lacks the clear helper).
  - The backport is trivial: add the inline clear helper to
    include/net/xdp.h and invoke it in bpf_xdp_frags_shrink_tail()
    alongside the existing HAS_FRAGS clear.
  - No dependencies on recent infrastructure beyond the
    FRAGS_PF_MEMALLOC flag (present since the XDP frags work was
    introduced).

- Stable criteria fit
  - Fixes a correctness bug that could lead to subtle misbehavior.
  - Minimal and surgical; not a feature.
  - No behavioral surprises or architectural changes.
  - Applies cleanly to affected stable branches that have non-linear XDP
    and the FRAGS_PF_MEMALLOC flag.

Conclusion: This is a low-risk correctness fix in BPF/XDP flag handling
and should be backported to stable.

 include/net/xdp.h | 5 +++++
 net/core/filter.c | 1 +
 2 files changed, 6 insertions(+)

diff --git a/include/net/xdp.h b/include/net/xdp.h
index b40f1f96cb117..f288c348a6c13 100644
--- a/include/net/xdp.h
+++ b/include/net/xdp.h
@@ -115,6 +115,11 @@ static __always_inline void xdp_buff_set_frag_pfmemalloc(struct xdp_buff *xdp)
 	xdp->flags |= XDP_FLAGS_FRAGS_PF_MEMALLOC;
 }
 
+static __always_inline void xdp_buff_clear_frag_pfmemalloc(struct xdp_buff *xdp)
+{
+	xdp->flags &= ~XDP_FLAGS_FRAGS_PF_MEMALLOC;
+}
+
 static __always_inline void
 xdp_init_buff(struct xdp_buff *xdp, u32 frame_sz, struct xdp_rxq_info *rxq)
 {
diff --git a/net/core/filter.c b/net/core/filter.c
index da391e2b0788d..43408bd3a87a4 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -4210,6 +4210,7 @@ static int bpf_xdp_frags_shrink_tail(struct xdp_buff *xdp, int offset)
 
 	if (unlikely(!sinfo->nr_frags)) {
 		xdp_buff_clear_frags_flag(xdp);
+		xdp_buff_clear_frag_pfmemalloc(xdp);
 		xdp->data_end -= offset;
 	}
 
-- 
2.51.0


