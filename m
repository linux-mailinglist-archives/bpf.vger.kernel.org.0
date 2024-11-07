Return-Path: <bpf+bounces-44266-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 06D249C0B4B
	for <lists+bpf@lfdr.de>; Thu,  7 Nov 2024 17:20:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D56D1F23EF0
	for <lists+bpf@lfdr.de>; Thu,  7 Nov 2024 16:20:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E85F221A6F3;
	Thu,  7 Nov 2024 16:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="B9bluWKY"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF16D21A4DD;
	Thu,  7 Nov 2024 16:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730996078; cv=none; b=uUe+QqMc3BCrYqn2yQIk3WU3EvnbJAD9UM3z9YsnCQ+fqflpluOlUmQrJESddjDkNq+kM6G1zAwMg4DwAi+ibeGDKDHptWKnKaPCmwmCbZx/t6VJb264cfnL2tQZXEZdesNA254RwpzlB6PflT2bzFRoSH9SRVsyt3Q+Li9NqAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730996078; c=relaxed/simple;
	bh=e5HN06V8sUAbvrE1VRjupxomFxjPnp1tXPPH+D4Q7ws=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RZkuUfo4OrHbjTRnd5VjnpCxs3mRnApLNdhtJFYo+F3rn9o7lEkrRr0UUKIhLLpouCCe2E5NfWR0x+WZah1jB0FRIf94zdb0Heh7zndUtF3t3IJ8SxgenaLuK+c0Jyn6LaxNjenHF3cDVX0Dz4IKAv8hdBihFSTv2Qr02CJv0/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=B9bluWKY; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730996077; x=1762532077;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=e5HN06V8sUAbvrE1VRjupxomFxjPnp1tXPPH+D4Q7ws=;
  b=B9bluWKYUxtvMsGHgTy5oy6dJqzzx7NA3J+A3kfwIjGx2JvxHIrd4wZ2
   b4k+TLOUERnDTbjBByJqBv4S6Cn04jdGnk2Ogj+vmBARlUCXW6Yqeduhr
   IMudlXcq/x/yaJvdlMfFIeKLEiYtb3Mz8Oj1dP5h1dr1Be8arD4YFZqI1
   +NK+VE1ZzSKX15exdB1L9JZBPmzsgLKd709w0uYwwYUZN3vNnLDvUqYeT
   yMbemrMtQefVdn/uWYmAVIJt6S1r9mIuh/F0QtZvXr/N5K+OLjbgQMIhl
   eJdehT+497/9Yi+bMr+F4Ys/GqcEYbBs9U+jKWLdVMr16cK554IhpMqN4
   w==;
X-CSE-ConnectionGUID: Ft3lZzL7SkSkmqyqg/kG9w==
X-CSE-MsgGUID: nU9OKv/9TneqG0z/3JXBbA==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="41956014"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="41956014"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2024 08:14:36 -0800
X-CSE-ConnectionGUID: CJuwHcmtQYCIe8PhDwIPIw==
X-CSE-MsgGUID: WbgMHrBSTHKcwCC/rZ4UYA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,135,1728975600"; 
   d="scan'208";a="90258232"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by orviesa004.jf.intel.com with ESMTP; 07 Nov 2024 08:14:33 -0800
From: Alexander Lobakin <aleksander.lobakin@intel.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>,
	=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Magnus Karlsson <magnus.karlsson@intel.com>,
	nex.sw.ncis.osdt.itp.upstreaming@intel.com,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v4 13/19] xsk: align &xdp_buff_xsk harder
Date: Thu,  7 Nov 2024 17:10:20 +0100
Message-ID: <20241107161026.2903044-14-aleksander.lobakin@intel.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241107161026.2903044-1-aleksander.lobakin@intel.com>
References: <20241107161026.2903044-1-aleksander.lobakin@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

After the series "XSk buff on a diet" by Maciej, the greatest pow-2
which &xdp_buff_xsk can be divided got reduced from 16 to 8 on x86_64.
Also, sizeof(xdp_buff_xsk) now is 120 bytes, which, taking the previous
sentence into account, leads to that it leaves 8 bytes at the end of
cacheline, which means an array of buffs will have its elements
messed between the cachelines chaotically.
Use __aligned_largest for this struct. This alignment is usually 16
bytes, which makes it fill two full cachelines and align an array
nicely. ___cacheline_aligned may be excessive here, especially on
arches with 128-256 byte CLs, as well as 32-bit arches (76 -> 96
bytes on MIPS32R2), while not doing better than _largest.

Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
---
 include/net/xsk_buff_pool.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/net/xsk_buff_pool.h b/include/net/xsk_buff_pool.h
index 3832997cc605..50779406bc2d 100644
--- a/include/net/xsk_buff_pool.h
+++ b/include/net/xsk_buff_pool.h
@@ -29,7 +29,7 @@ struct xdp_buff_xsk {
 	dma_addr_t frame_dma;
 	struct xsk_buff_pool *pool;
 	struct list_head list_node;
-};
+} __aligned_largest;
 
 #define XSK_CHECK_PRIV_TYPE(t) BUILD_BUG_ON(sizeof(t) > offsetofend(struct xdp_buff_xsk, cb))
 #define XSK_TX_COMPL_FITS(t) BUILD_BUG_ON(sizeof(struct xsk_tx_metadata_compl) > sizeof(t))
-- 
2.47.0


