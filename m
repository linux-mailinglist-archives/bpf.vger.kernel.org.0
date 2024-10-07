Return-Path: <bpf+bounces-41106-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF270992BA4
	for <lists+bpf@lfdr.de>; Mon,  7 Oct 2024 14:25:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4DCE9B24A3A
	for <lists+bpf@lfdr.de>; Mon,  7 Oct 2024 12:25:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAFD11547D4;
	Mon,  7 Oct 2024 12:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hIs5J/NA"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B85FB1D1F63;
	Mon,  7 Oct 2024 12:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728303905; cv=none; b=bVNgPSa4yHFmxRcd90eDiHXgh/9vaOj5MtOwvaR+cFhWUIoXBsEd9/DYSVz4/VzMxhr2wT4+H3Izibq12Y7B3tXIaCJD1TE+xdSM8E1SAzDJ+qKoBVnnaSvIavDQ2tQYSS1795z01oNL0Gh1LlScTdu1c8YgdEX4EnX7kXFbqw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728303905; c=relaxed/simple;
	bh=KM/R8kxq+tX9uW5KByhaNYSrISz1iNoMmr6A5Xg6M4g=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=etwxEhikPADyjsiMvPwfzY++YuwlW5jirBYtGT9+jfLtdTlgDVQvhxkI1E3pHOAy9AXOUiKlxj8xpwQqjexOYOGK14VEJp2iGWtdhwDA3fqMGz+EWHKf+WMbbPS3vYSKghfBis2Nm+J7QxiLVnBu8c2/7WJZKEv7F2NrJS/8++o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hIs5J/NA; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728303903; x=1759839903;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=KM/R8kxq+tX9uW5KByhaNYSrISz1iNoMmr6A5Xg6M4g=;
  b=hIs5J/NANjEhdrAQnO6wUTxxnBwO7upyIgvD2zLRc6SZe/V9krcMrdiK
   rxEWNaeNxQQNHEKSFSFTdUxMdstfBLEpEIU8GqQ5+kVqM5p8sMf7y1dA5
   7Du5iNelVl4nL5t28s6LEftlOhNCbjdwP0RuHQ1mrVUmGLDqUkE+gwDgF
   j/e7EHfi1YWHcTFyQ7ptkV8VxRBHzcEEeW6r6eWPbAokpoa8eIPZ2gqvE
   KtBUuVngf8X9F2d6fvmm1jS2LEmb23+SDuqYsfvxGoM1MghBz+IlP6hwk
   mJrr51ykJSPtY1PselHlwCAHJoSPFzvjYUaxdHAlC5M6NBGFetdmCmg+w
   A==;
X-CSE-ConnectionGUID: DTEwBBVLQz2mdJHaI3951w==
X-CSE-MsgGUID: ZEOHRnBuSZun10ZDNfrb6g==
X-IronPort-AV: E=McAfee;i="6700,10204,11217"; a="15066323"
X-IronPort-AV: E=Sophos;i="6.11,184,1725346800"; 
   d="scan'208";a="15066323"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2024 05:25:03 -0700
X-CSE-ConnectionGUID: yGhsJb9+RnerBSXT+QdGgw==
X-CSE-MsgGUID: CERSh+i9TMuL9nkKpugotQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,184,1725346800"; 
   d="scan'208";a="80250810"
Received: from boxer.igk.intel.com ([10.102.20.173])
  by orviesa005.jf.intel.com with ESMTP; 07 Oct 2024 05:25:01 -0700
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org
Cc: netdev@vger.kernel.org,
	magnus.karlsson@intel.com,
	bjorn@kernel.org,
	maciej.fijalkowski@intel.com,
	vadfed@meta.com
Subject: [PATCH v2 bpf-next 0/6] xsk: struct diet and cleanups
Date: Mon,  7 Oct 2024 14:24:52 +0200
Message-Id: <20241007122458.282590-1-maciej.fijalkowski@intel.com>
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

v1->v2:
* fix build issues on patch 1 (Daniel, CI)
* be smarter about xsk_buff_pool layout in patch 4 (Vadim)

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


