Return-Path: <bpf+bounces-71715-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8010ABFC002
	for <lists+bpf@lfdr.de>; Wed, 22 Oct 2025 15:00:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D12131892A47
	for <lists+bpf@lfdr.de>; Wed, 22 Oct 2025 12:57:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C9D834C147;
	Wed, 22 Oct 2025 12:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HYjBTA8m"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 447FA30146F;
	Wed, 22 Oct 2025 12:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761137553; cv=none; b=RVAJzsBzsYpJTe92Q+VQsxwxHKB0XsjeF+Ynt+rrV8f8j8OiZiz/CdA5M3DzCQ+msQ1bF8ofjS2Y9BXV3h/9cQkeJNZ3jtpWeMJNFXSgVeC22I9nytogiMGexhCb3EMSOUHq72JIeqQHByI7lxeMnjZoAVpZo65XO23tx0iIiX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761137553; c=relaxed/simple;
	bh=IaCQcTDBj0kFmNuYDUGM+K7gxPxn9DP50DtPbHJw95k=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=obev7ql5L5Hkv5q12C1pSpDh/VX6GBSE6m7PXq2lP4bThwYfzwxhXb18R8q3JYzpBlp5gS2hgEiGtfqCS091gf+kn/4ocAjZ6bHlkWQiGegjlLpvB6f0qJ43YRWQmSdKmqhF97Rd1t7HSrjzdCNau4/MlNt95iuAqJ4NIod489Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HYjBTA8m; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761137549; x=1792673549;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=IaCQcTDBj0kFmNuYDUGM+K7gxPxn9DP50DtPbHJw95k=;
  b=HYjBTA8mKZctMHU8F1iydrvNuSzeO/Lm0SZvQEfTOYTG8xntJPYx8er3
   8rpsErPH60xwZ23qYiUlCoD9hNpYZ3GQ1ZGzfAJDBrDVGwy+IsXRHRKi0
   MnZ8wPDW/wTEk8yinmx/M6qx0vuqWdxoqGHM46Y//p2wLUfk8cGyBVTaO
   qfa27FJAhUmdi3owbsT+fZhNHzZq1LNvc6gwPabSJN6sVQsBlAgaQaWtQ
   dUnHK7xhxobCzJ0UrkNI8J9lBNeMqgA351Biiu1i24hqFHj6Dj3dV4D3C
   4+1YgjPcR/xUPx/R0YYkbC0AgQlYuZuplu9mWcDn7lTI26CZ2Y/F3Cis/
   Q==;
X-CSE-ConnectionGUID: acYAWrvcQEWFNHMfGZJ19Q==
X-CSE-MsgGUID: lmQd+zyPR6SkjrV6khxnxw==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="63190441"
X-IronPort-AV: E=Sophos;i="6.19,247,1754982000"; 
   d="scan'208";a="63190441"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2025 05:52:25 -0700
X-CSE-ConnectionGUID: SbVft9cuT2aqfhs8M8Kn+w==
X-CSE-MsgGUID: xKi31hSvS3e6mVYWtjnnfQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,247,1754982000"; 
   d="scan'208";a="207534773"
Received: from boxer.igk.intel.com ([10.102.20.173])
  by fmviesa002.fm.intel.com with ESMTP; 22 Oct 2025 05:52:22 -0700
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org
Cc: netdev@vger.kernel.org,
	magnus.karlsson@intel.com,
	aleksander.lobakin@intel.com,
	ilias.apalodimas@linaro.org,
	toke@redhat.com,
	lorenzo@kernel.org,
	kuba@kernel.org,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Subject: [PATCH v3 bpf 0/2] xdp: fix page_pool leaks
Date: Wed, 22 Oct 2025 14:52:07 +0200
Message-Id: <20251022125209.2649287-1-maciej.fijalkowski@intel.com>
X-Mailer: git-send-email 2.38.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

v1:
https://lore.kernel.org/bpf/20251003140243.2534865-1-maciej.fijalkowski@intel.com/
v1->v2:
- add skb to xdp_buff converter (Jakub)
- postpone restoration of veth's xdp_rxq_info mem model (AI)

v2:
https://lore.kernel.org/bpf/20251017143103.2620164-1-maciej.fijalkowski@intel.com/T/
v2->v3:
- make skb->xdp_buff conversion agnostic of current skb->data position
  (Toke)
- do not pull mac header in veth (Toke)
- use virt_to_head_page() when checking if xdp->data comes from
  page_pool (Olek)
- add ack from Toke

Hi,

here we fix page_pool leaks which happen when fragment is released
within XDP program and memory type is set incorrectly. The reports come
from syzbot and AF_XDP test suite.

Most of the changes are about pulling out the common code for
init/prepare xdp_buff based on existing skb and supplying it with
correct xdp_rxq_info's mem_type that is assigned to xdp_buff. A bit more
stuff, page_pool related, had to be done on veth side.

Originally, this work was started by Octavian Purdila.

Thanks!


Maciej Fijalkowski (2):
  xdp: introduce xdp_convert_skb_to_buff()
  veth: update mem type in xdp_buff

 drivers/net/veth.c | 43 ++++++++++++++++++++++++++-----------------
 include/net/xdp.h  | 27 +++++++++++++++++++++++++++
 net/core/dev.c     | 25 ++++---------------------
 3 files changed, 57 insertions(+), 38 deletions(-)

-- 
2.43.0


