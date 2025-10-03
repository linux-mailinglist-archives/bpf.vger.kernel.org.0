Return-Path: <bpf+bounces-70299-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C5CBBB71C0
	for <lists+bpf@lfdr.de>; Fri, 03 Oct 2025 16:03:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4A0604E044F
	for <lists+bpf@lfdr.de>; Fri,  3 Oct 2025 14:03:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12525200BA1;
	Fri,  3 Oct 2025 14:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Gi35sd9p"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B29D7145A05;
	Fri,  3 Oct 2025 14:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759500184; cv=none; b=Vu56hKS3thMrQcv9u7WNb0uRZ45TgewAOOBFuAuo3kB6VRrxd7Dbf9KUXXbkno+LXw838KS/qsL8NLxkaNE7jxYVkh58GDbBVnZMUPPZv1lBIGq8GWOcWZdklKiXP0VMfAaZCJ6TBw3VpUiRCFvu6wrvY+JfwFDwUMVsVSRi9QY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759500184; c=relaxed/simple;
	bh=EXbl3MnNJOxBXWStcKMFxFue0Gln+qvGdduMctx2Imw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dHAoHfaM9XXfKs/TfHiCgVCP2mlOum2XDWUh4YLYeaxIGy5LnZpZNG+4YDxKY9DU3hZ2gss4yFxvHfHHjc4d3Iiz2p7y919eXurzVYKGutLZhML7kb5whT+W7aSSbT5j/N0Nzbgij9ShZ3DeZ1LE0LWGIUaVoPDp3Un+uCtNbi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Gi35sd9p; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759500183; x=1791036183;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=EXbl3MnNJOxBXWStcKMFxFue0Gln+qvGdduMctx2Imw=;
  b=Gi35sd9p1ausudeUHPJwqKNcH2WQogaXvWYsmLM//JSJAn8tfwyk420a
   +h4SrAlg7JBzvY4asIOg+xENpMpccQhPPDFLsMCyWZZPmctB55q3cOaSw
   O1mWvI8fP1YziORhl/gWl7lC7wA3k1m0xh0yqVu3C3DT8P48AjpMORwDK
   Alg2h0NkTpAyZ7D4cNSfN3T0VRgURa0FkvYWTj46SgkazzKwpI7Af14nK
   vkgABUYWWdwv/a9LfkWIWosD/W559oKixujZ1GjkKjqB8xh5FKAIDRNbu
   1Dx+mDry0Ire3fxDlpEa2ufd42yZAe5N2GLru0g8u28sQc9qFGxp5KtCa
   Q==;
X-CSE-ConnectionGUID: pftBoHtCSoiY32ZHY4egIA==
X-CSE-MsgGUID: fEXsckBZRje1rSeROBPZOQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11571"; a="73210284"
X-IronPort-AV: E=Sophos;i="6.18,312,1751266800"; 
   d="scan'208";a="73210284"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2025 07:03:03 -0700
X-CSE-ConnectionGUID: s/rdWs7ARbCzPNfchdQz1A==
X-CSE-MsgGUID: YJep8Ld6Q6Ot4NWTDwbM/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,312,1751266800"; 
   d="scan'208";a="183580086"
Received: from boxer.igk.intel.com ([10.102.20.173])
  by orviesa004.jf.intel.com with ESMTP; 03 Oct 2025 07:02:59 -0700
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	ilias.apalodimas@linaro.org,
	toke@redhat.com,
	lorenzo@kernel.org
Cc: netdev@vger.kernel.org,
	magnus.karlsson@intel.com,
	andrii@kernel.org,
	stfomichev@gmail.com,
	aleksander.lobakin@intel.com,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	syzbot+ff145014d6b0ce64a173@syzkaller.appspotmail.com,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Octavian Purdila <tavip@google.com>
Subject: [PATCH bpf 1/2] xdp: update xdp_rxq_info's mem type in XDP generic hook
Date: Fri,  3 Oct 2025 16:02:42 +0200
Message-Id: <20251003140243.2534865-2-maciej.fijalkowski@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20251003140243.2534865-1-maciej.fijalkowski@intel.com>
References: <20251003140243.2534865-1-maciej.fijalkowski@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, generic XDP hook uses xdp_rxq_info from netstack Rx queues
which do not have its XDP memory model registered. There is a case when
XDP program calls bpf_xdp_adjust_tail() BPF helper that releases
underlying memory. This happens when it consumes enough amount of bytes
and when XDP buffer has fragments. For this action the memory model
knowledge passed to XDP program is crucial so that core can call
suitable function for freeing/recycling the page.

For netstack queues it defaults to MEM_TYPE_PAGE_SHARED (0) due to lack
of mem model registration. The problem we're fixing here is when kernel
copied the skb to new buffer backed by system's page_pool and XDP buffer
is built around it. Then when bpf_xdp_adjust_tail() calls
__xdp_return(), it acts incorrectly due to mem type not being set to
MEM_TYPE_PAGE_POOL and causes a page leak.

For this purpose introduce a small helper, xdp_update_mem_type(), that
could be used on other callsites such as veth which are open to this
problem as well. Here we call it right before executing XDP program in
generic XDP hook.

This problem was triggered by syzbot as well as AF_XDP test suite which
is about to be integrated to BPF CI.

Reported-by: syzbot+ff145014d6b0ce64a173@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/netdev/6756c37b.050a0220.a30f1.019a.GAE@google.com/
Fixes: e6d5dbdd20aa ("xdp: add multi-buff support for xdp running in generic mode")
Tested-by: Ihor Solodrai <ihor.solodrai@linux.dev>
Co-developed-by: Octavian Purdila <tavip@google.com>
Signed-off-by: Octavian Purdila <tavip@google.com> # whole analysis, testing, initiating a fix
Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com> # commit msg and proposed more robust fix
---
 include/net/xdp.h | 7 +++++++
 net/core/dev.c    | 2 ++
 2 files changed, 9 insertions(+)

diff --git a/include/net/xdp.h b/include/net/xdp.h
index f288c348a6c1..5568e41cc191 100644
--- a/include/net/xdp.h
+++ b/include/net/xdp.h
@@ -336,6 +336,13 @@ xdp_update_skb_shared_info(struct sk_buff *skb, u8 nr_frags,
 	skb->pfmemalloc |= pfmemalloc;
 }
 
+static inline void
+xdp_update_mem_type(struct xdp_buff *xdp)
+{
+	xdp->rxq->mem.type = page_pool_page_is_pp(virt_to_page(xdp->data)) ?
+		MEM_TYPE_PAGE_POOL : MEM_TYPE_PAGE_SHARED;
+}
+
 /* Avoids inlining WARN macro in fast-path */
 void xdp_warn(const char *msg, const char *func, const int line);
 #define XDP_WARN(msg) xdp_warn(msg, __func__, __LINE__)
diff --git a/net/core/dev.c b/net/core/dev.c
index 93a25d87b86b..076cd4a4b73f 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -5269,6 +5269,8 @@ u32 bpf_prog_run_generic_xdp(struct sk_buff *skb, struct xdp_buff *xdp,
 	orig_bcast = is_multicast_ether_addr_64bits(eth->h_dest);
 	orig_eth_type = eth->h_proto;
 
+	xdp_update_mem_type(xdp);
+
 	act = bpf_prog_run_xdp(xdp_prog, xdp);
 
 	/* check if bpf_xdp_adjust_head was used */
-- 
2.43.0


