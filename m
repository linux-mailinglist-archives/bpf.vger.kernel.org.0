Return-Path: <bpf+bounces-40765-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B431098DFDC
	for <lists+bpf@lfdr.de>; Wed,  2 Oct 2024 17:55:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 66C321F2703F
	for <lists+bpf@lfdr.de>; Wed,  2 Oct 2024 15:55:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D83C31D0BBB;
	Wed,  2 Oct 2024 15:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Q9hYEAGf"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1F661D041E;
	Wed,  2 Oct 2024 15:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727884487; cv=none; b=RXG68msY1hOOZeK9Xxzh5ervi3UytH/a+1BZW0vH22k1VYz9CBVB3K0EZMvhLsrOKeKeE78GinzExc7Qd/g43zFcuzRRq6DEZwMq2e3vMBKcT3WXq/oRkN57Lae8UBoksQAOa57yYx7hIGNZ0H5b3u1AkvcAqc4p7/85reNB2Z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727884487; c=relaxed/simple;
	bh=8XgFlu44y/temf1ASm4EFntWa8LSvyEIndxJSXlcDXA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ACZICaJP2DzZ/FAEnU8d3JVgR9Om55msOtmH/PVVw1cR8QbazhxLuOIEZUuRwTam+svCcGTjzyRTs1a2/W9m2rt1zthzB+/ixgtiHR8ZLe+ZcFIvldQDb79CMZJyDBP3o2feGCD4CAoZHAipbW0hG8/LIYkZ42vjyDJ+GS7tNJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Q9hYEAGf; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727884487; x=1759420487;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=8XgFlu44y/temf1ASm4EFntWa8LSvyEIndxJSXlcDXA=;
  b=Q9hYEAGfz48wb3sVszOgp5uEEmLthqZd0MS2OBScrGQK3LssPt17Md5e
   8HWMPgd/aFt1ZZNStTTKvzERPomp7RUv0J+1KVglBM6c2y9uUCdy9B6bt
   BrJBshrfAYXtr5KoAvpzzmfOTDvafbVLyb6zIfTeANWLLNdlw7QIva5mS
   2QdGw0d53MMSuwe5bInLDpubMlBnIXGxAQpR/8uoJ53x/63gb8SNEu1d4
   7BC/G+VNFhSmK4w303azbnNu0y2yfnPyaDM4FeedMa6O8btU2r5Xa27so
   LaevOoQhEM8eFhA0qWhzo/YL2+q1BRu3go0QQiZX4exd2rP5P2F73OEpF
   w==;
X-CSE-ConnectionGUID: pIIRALx6TrWchazoQ8IY2A==
X-CSE-MsgGUID: 4XRuFzeDRaqmBuIfiH74tA==
X-IronPort-AV: E=McAfee;i="6700,10204,11213"; a="30762948"
X-IronPort-AV: E=Sophos;i="6.11,172,1725346800"; 
   d="scan'208";a="30762948"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2024 08:54:46 -0700
X-CSE-ConnectionGUID: iQ+0PrBySTKd0/SbpjX7GQ==
X-CSE-MsgGUID: eo8Pk1tSS5GHxGGRamJWmg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,172,1725346800"; 
   d="scan'208";a="73628713"
Received: from boxer.igk.intel.com ([10.102.20.173])
  by fmviesa006.fm.intel.com with ESMTP; 02 Oct 2024 08:54:43 -0700
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org
Cc: netdev@vger.kernel.org,
	magnus.karlsson@intel.com,
	bjorn@kernel.org,
	maciej.fijalkowski@intel.com
Subject: [PATCH bpf-next 0/6] xsk: struct diet and cleanups
Date: Wed,  2 Oct 2024 17:54:35 +0200
Message-Id: <20241002155441.253956-1-maciej.fijalkowski@intel.com>
X-Mailer: git-send-email 2.38.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi all,

this modest work brings back size of xdp_buff_xsk back to two cache
lines which in turn improves performance. Interestingly I was able to
observe on ice with HW rings sized to 512 around 12% better performance
when running xdpsock in l2fwd scenario. First three patches are behind
this. Other setups were not that impressive, I believe results may vary
based on the underlying CPU. Bottom line is that shrinking this struct
takes off a bit of work from CPU's shoulders.

Other three patches are rather cleanups.

Thanks,
Maciej



Maciej Fijalkowski (6):
  xsk: get rid of xdp_buff_xsk::xskb_list_node
  xsk: s/free_list_node/list_node
  xsk: get rid of xdp_buff_xsk::orig_addr
  xsk: carry a copy of xdp_zc_max_segs within xsk_buff_pool
  xsk: wrap duplicated code to function
  xsk: use xsk_buff_pool directly for cq functions

 include/net/xdp_sock_drv.h  | 14 +++++-----
 include/net/xsk_buff_pool.h | 23 +++++++++-------
 net/xdp/xsk.c               | 38 +++++++++++++-------------
 net/xdp/xsk_buff_pool.c     | 54 ++++++++++++++++++++-----------------
 net/xdp/xsk_queue.h         |  2 +-
 5 files changed, 69 insertions(+), 62 deletions(-)

-- 
2.34.1


