Return-Path: <bpf+bounces-72311-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D37AC0D716
	for <lists+bpf@lfdr.de>; Mon, 27 Oct 2025 13:14:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 09BFA34D3E5
	for <lists+bpf@lfdr.de>; Mon, 27 Oct 2025 12:14:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BBFE3016EB;
	Mon, 27 Oct 2025 12:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RtjSS1Il"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44B7E3016F7;
	Mon, 27 Oct 2025 12:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761567272; cv=none; b=eSQZQO65XpMkfpWs0dyb9oQiFhdrW9lK+8cRiJkPBhDZZZR23h/g+GZdCzOnjBIPg5k7oBNO/7+baB9DCBcaW1lQIIfQZ1vmNt/8L1l1ijDd/dIqioq9n7oN9zrpnK7OTBROLY2CGnT0nnlYU4HtB4hqaS5Y1LeASIEw8w26pAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761567272; c=relaxed/simple;
	bh=Ti9RDmDz14kzH2Kr7FVg0DILw6qjcoWbvQScE3vQ7xA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=MU7Pw4Zq06aRoM/0pjkiZyOBZOuCtvW74ER/uELsJ//ltXZ/nuZRCtH2lJrsy+zeu4gNSbFqGjI6WCdGAcvZbMTbs9VPr4ozJDs4Ye62g8zLi4ba+q6v7wojR8hTozSDRSLdDI3w75Tvgyx7Z5PGUOOx5ZDo/4enQDen0WG9tt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RtjSS1Il; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761567271; x=1793103271;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Ti9RDmDz14kzH2Kr7FVg0DILw6qjcoWbvQScE3vQ7xA=;
  b=RtjSS1IlGl4ieKf1L28JKOXIpDCi6WDsor7NfkCRmVlXJMAYjAadsx/K
   wWt7KdrZQnYFPyU3mc/cgLpozpNLvrJpGwVGAYsGJTlGX2/ww2jnmIoaS
   8tSQ06ncjw/TremFCvUciUCDQmBjDjEDeEsChHRlGBO1XRnu5kWIVhloE
   e6YT+uHIbLedP4tYfwNTKlvjlGgTRIwUUmJI5Teibw2r2LkJx8Gy9fxe3
   QNMCNKiyuJN37B4XscLjLjFoKXMLdV4WoiHrpJRJ/Hm9auosoOrb6gY28
   rMBPLYJGfJAH+0MogPBZLSsXeZSQrRdZz0n5q7qvSsCVq44nZP0mx/r3V
   A==;
X-CSE-ConnectionGUID: sXUVfaa2Tga1z7p3ARtLvw==
X-CSE-MsgGUID: B72GGaPoQAuT/5IBM93gXA==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="63532357"
X-IronPort-AV: E=Sophos;i="6.19,258,1754982000"; 
   d="scan'208";a="63532357"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2025 05:13:23 -0700
X-CSE-ConnectionGUID: wLQaQlCsS7SIJCTXdKd10g==
X-CSE-MsgGUID: HT/xle1PSH2sql7vb7xwtg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,258,1754982000"; 
   d="scan'208";a="184923458"
Received: from boxer.igk.intel.com ([10.102.20.173])
  by fmviesa006.fm.intel.com with ESMTP; 27 Oct 2025 05:13:21 -0700
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
Subject: [PATCH v4 bpf 0/2] xdp: fix page_pool leaks
Date: Mon, 27 Oct 2025 13:13:16 +0100
Message-Id: <20251027121318.2679226-1-maciej.fijalkowski@intel.com>
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

v3:
https://lore.kernel.org/bpf/20251022125209.2649287-1-maciej.fijalkowski@intel.com/
v3->v4:
- include skb->head when calculating packet length (Toke, lkp)


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
 include/net/xdp.h  | 25 +++++++++++++++++++++++++
 net/core/dev.c     | 25 ++++---------------------
 3 files changed, 55 insertions(+), 38 deletions(-)

-- 
2.43.0


