Return-Path: <bpf+bounces-70596-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 95331BC61A5
	for <lists+bpf@lfdr.de>; Wed, 08 Oct 2025 18:58:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A3E3A4EDB70
	for <lists+bpf@lfdr.de>; Wed,  8 Oct 2025 16:58:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1BB12F5306;
	Wed,  8 Oct 2025 16:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="j+sEn+dh"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F070C2ECE8A;
	Wed,  8 Oct 2025 16:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759942672; cv=none; b=UuMnCxreCsgGjocqLKP/4g/dXwElzIVZA1s2gIY85ChCwVYB+UwIlMZZp5ciFel//fneaCMIgr48FCyv1NBShMpB9sBTytGNi2jDMQXldBvOEZBl3nHeAf0KlWZnpxThDibY6sLNjfdv1MBk3/SuU7wrghJn9I56rqnRwoe5OP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759942672; c=relaxed/simple;
	bh=Eq/1r+VZp2Evz/CTTMUVwGClrUgMN6C7oaQOpB9fUXg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bqGv9veypl/NZXr4t1SCX640uXHgPFmdNk8F/tBzoVDEoKF6WcEviiiGzuXgi5fbVuky7FMlUnB1N6LjAliai6GHii9FVLJfgJGCN5NKBlLS8YvRYV7/C3deYZbGIDI6Iy1fpsyT0BIKamyLsPZIZV7BbNx0U3DZtoIPUZcT6Fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=j+sEn+dh; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759942670; x=1791478670;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Eq/1r+VZp2Evz/CTTMUVwGClrUgMN6C7oaQOpB9fUXg=;
  b=j+sEn+dhI43ifrjcmSo6DCMXjbSzRwq9gPMElX+ogPPPC/y8YZdI+xt4
   mmDUL4X4wMlaqNLr/jKaARR3izr/Q8W4z175DWuKoiD6IM87meUeKrJSU
   EdCgC89qZ5sxZVRuF929pBV9AJ8LNzZ47oIYpOPFIQm3zBzCj9xwI27M/
   Naxkyx+6/Ln5U9dCy9mUxVR9TmngkueS4EX4AT/dlZasuyAzUbmFyfHyv
   qJNVUo5eECAci75vXyzTreS3uQBda+mMrVFNEAEWf5CzU7wXPiF0iMVaT
   v/bSapTsfB5Nf69vMCYGMJ8g4T3capBSOcgbPAiL7aL+7Z2Cu6H5X806g
   w==;
X-CSE-ConnectionGUID: Y/aM1mXCQUWeKB/A/ckrHA==
X-CSE-MsgGUID: d2B82jBjRMCjX46+/zZ0cw==
X-IronPort-AV: E=McAfee;i="6800,10657,11576"; a="73487536"
X-IronPort-AV: E=Sophos;i="6.19,213,1754982000"; 
   d="scan'208";a="73487536"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2025 09:57:49 -0700
X-CSE-ConnectionGUID: wXKPDV8WQKuQWySFSquJpg==
X-CSE-MsgGUID: oTtQcRjZRaeEq3izNJbQpQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,213,1754982000"; 
   d="scan'208";a="181255763"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by fmviesa010.fm.intel.com with ESMTP; 08 Oct 2025 09:57:45 -0700
From: Alexander Lobakin <aleksander.lobakin@intel.com>
To: Magnus Karlsson <magnus.karlsson@intel.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Kees Cook <kees@kernel.org>,
	nxne.cnse.osdt.itp.upstreaming@intel.com,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	stable@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf] xsk: harden userspace-supplied &xdp_desc validation
Date: Wed,  8 Oct 2025 18:56:59 +0200
Message-ID: <20251008165659.4141318-1-aleksander.lobakin@intel.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Turned out certain clearly invalid values passed in &xdp_desc from
userspace can pass xp_{,un}aligned_validate_desc() and then lead
to UBs or just invalid frames to be queued for xmit.

desc->len close to ``U32_MAX`` with a non-zero pool->tx_metadata_len
can cause positive integer overflow and wraparound, the same way low
enough desc->addr with a non-zero pool->tx_metadata_len can cause
negative integer overflow. Both scenarios can then pass the
validation successfully.
This doesn't happen with valid XSk applications, but can be used
to perform attacks.

Always promote desc->len to ``u64`` first to exclude positive
overflows of it. Use explicit check_{add,sub}_overflow() when
validating desc->addr (which is ``u64`` already).

bloat-o-meter reports a little growth of the code size:

add/remove: 0/0 grow/shrink: 2/1 up/down: 60/-16 (44)
Function                                     old     new   delta
xskq_cons_peek_desc                          299     330     +31
xsk_tx_peek_release_desc_batch               973    1002     +29
xsk_generic_xmit                            3148    3132     -16

but hopefully this doesn't hurt the performance much.

Fixes: 341ac980eab9 ("xsk: Support tx_metadata_len")
Cc: stable@vger.kernel.org # 6.8+
Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
---
 net/xdp/xsk_queue.h | 45 +++++++++++++++++++++++++++++++++++----------
 1 file changed, 35 insertions(+), 10 deletions(-)

diff --git a/net/xdp/xsk_queue.h b/net/xdp/xsk_queue.h
index f16f390370dc..1eb8d9f8b104 100644
--- a/net/xdp/xsk_queue.h
+++ b/net/xdp/xsk_queue.h
@@ -143,14 +143,24 @@ static inline bool xp_unused_options_set(u32 options)
 static inline bool xp_aligned_validate_desc(struct xsk_buff_pool *pool,
 					    struct xdp_desc *desc)
 {
-	u64 addr = desc->addr - pool->tx_metadata_len;
-	u64 len = desc->len + pool->tx_metadata_len;
-	u64 offset = addr & (pool->chunk_size - 1);
+	u64 len = desc->len;
+	u64 addr, offset;
 
-	if (!desc->len)
+	if (!len)
 		return false;
 
-	if (offset + len > pool->chunk_size)
+	/* Can overflow if desc->addr < pool->tx_metadata_len */
+	if (check_sub_overflow(desc->addr, pool->tx_metadata_len, &addr))
+		return false;
+
+	offset = addr & (pool->chunk_size - 1);
+
+	/*
+	 * Can't overflow: @offset is guaranteed to be < ``U32_MAX``
+	 * (pool->chunk_size is ``u32``), @len is guaranteed
+	 * to be <= ``U32_MAX``.
+	 */
+	if (offset + len + pool->tx_metadata_len > pool->chunk_size)
 		return false;
 
 	if (addr >= pool->addrs_cnt)
@@ -158,27 +168,42 @@ static inline bool xp_aligned_validate_desc(struct xsk_buff_pool *pool,
 
 	if (xp_unused_options_set(desc->options))
 		return false;
+
 	return true;
 }
 
 static inline bool xp_unaligned_validate_desc(struct xsk_buff_pool *pool,
 					      struct xdp_desc *desc)
 {
-	u64 addr = xp_unaligned_add_offset_to_addr(desc->addr) - pool->tx_metadata_len;
-	u64 len = desc->len + pool->tx_metadata_len;
+	u64 len = desc->len;
+	u64 addr, end;
 
-	if (!desc->len)
+	if (!len)
 		return false;
 
+	/* Can't overflow: @len is guaranteed to be <= ``U32_MAX`` */
+	len += pool->tx_metadata_len;
 	if (len > pool->chunk_size)
 		return false;
 
-	if (addr >= pool->addrs_cnt || addr + len > pool->addrs_cnt ||
-	    xp_desc_crosses_non_contig_pg(pool, addr, len))
+	/* Can overflow if desc->addr is close to 0 */
+	if (check_sub_overflow(xp_unaligned_add_offset_to_addr(desc->addr),
+			       pool->tx_metadata_len, &addr))
+		return false;
+
+	if (addr >= pool->addrs_cnt)
+		return false;
+
+	/* Can overflow if pool->addrs_cnt is high enough */
+	if (check_add_overflow(addr, len, &end) || end > pool->addrs_cnt)
+		return false;
+
+	if (xp_desc_crosses_non_contig_pg(pool, addr, len))
 		return false;
 
 	if (xp_unused_options_set(desc->options))
 		return false;
+
 	return true;
 }
 
-- 
2.51.0


