Return-Path: <bpf+bounces-70298-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F7A7BB71B7
	for <lists+bpf@lfdr.de>; Fri, 03 Oct 2025 16:03:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8FA324ECD80
	for <lists+bpf@lfdr.de>; Fri,  3 Oct 2025 14:03:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DEF61F8908;
	Fri,  3 Oct 2025 14:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AsmlG6qG"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 227B7145A05;
	Fri,  3 Oct 2025 14:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759500180; cv=none; b=QyKalBX6koVSrBVbEYLHa6RClrZ/luLj6pe0MLxRd258ha8KSgVVot0qgV4gbigp1smq33IQT04tPc1t23Q0KrOFBaAYnFAe6Nxk3w7sm2y0XHVSrQAvV10qLItsJoMYao4FYN/nocnSYOuC/Hea1Fuw1wk5Z4nTxoM7IvHiRD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759500180; c=relaxed/simple;
	bh=rq+YwpIOMBzoU/l5wqfVyMWKdEwOx3HnZoI42+hqRIs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ExOXmoDAEwf8UbYPR9J8p5OIUNa1+e/nLwlF76UiOcedLBcGi3NbcbkrHk3/jqVlONUNo5aG98GALTzDwAGDbMhJUDBJW7JRyr2AO171WmUuYDdHdoUQ4aK78WZfAVkORDb3vr5NFaDpD2LH0PkXH9tbBmJeCGxPurkx/q6Y4/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AsmlG6qG; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759500179; x=1791036179;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=rq+YwpIOMBzoU/l5wqfVyMWKdEwOx3HnZoI42+hqRIs=;
  b=AsmlG6qGlr3leuait0DUiqmZJRYXVhfKxYTKNQWNb9va/PzuV0XeAU6h
   IQxwkKQ6+FuRbiFBmEDXV1g/gI2JdRA4cEJOGQxZzowURHtVgHBkbTDhx
   y4hDr+PaJ3gUuErvontSfg4bkJ+FAqkFF/egP/8vk5LZoOSndFD0m81XA
   xdghv7/QW5sI3VyFfKjjjPNOG65BRimfDMrEIJEUkGwtytkGNoh1AsO5O
   ae2yIBCfnwra4Ue8+c0VCZFU2Chvwf2zoc2ev8qzffe/nEoviXQEr9PL/
   80YysJTR1/nr941U4HdChSf7fd8rfB7aeWJtmPdk/FXjgL3pDqFe2InGr
   w==;
X-CSE-ConnectionGUID: PilrNKSFR1a8TLs+jdPU9A==
X-CSE-MsgGUID: trxa6DaGR9G21uP2gM4XyQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11571"; a="73210261"
X-IronPort-AV: E=Sophos;i="6.18,312,1751266800"; 
   d="scan'208";a="73210261"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2025 07:02:59 -0700
X-CSE-ConnectionGUID: P6EQ8x++SnmA4sD7gPhlBw==
X-CSE-MsgGUID: bsWnFHAFS1yRCPguQeJkIg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,312,1751266800"; 
   d="scan'208";a="183580040"
Received: from boxer.igk.intel.com ([10.102.20.173])
  by orviesa004.jf.intel.com with ESMTP; 03 Oct 2025 07:02:56 -0700
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
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Subject: [PATCH bpf 0/2] xdp: fix page_pool leaks
Date: Fri,  3 Oct 2025 16:02:41 +0200
Message-Id: <20251003140243.2534865-1-maciej.fijalkowski@intel.com>
X-Mailer: git-send-email 2.38.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

this set fixes page_pool leaks which happen when fragment is released
within XDP program and memory type is set incorrectly. The reports come
from syzbot and AF_XDP test suite.

This work was started by Octavian Purdila, below you can find links to
two revisions:
v2:
https://lore.kernel.org/bpf/20251001074704.2817028-1-tavip@google.com/
- use a local xdp_rxq_info structure and update mem.type instead of
  skipping using page pool if the netdev xdp_rxq_info is not set to
  MEM_TYPE_PAGE_POOL (which is always the case currently)
v1:
https://lore.kernel.org/netdev/20250924060843.2280499-1-tavip@google.com/


In this approach we use a small helper that utilizes
page_pool_page_is_pp(), which is enough for setting correct mem type in
xdp_rxq_info.

Thanks!

Maciej Fijalkowski (2):
  xdp: update xdp_rxq_info's mem type in XDP generic hook
  veth: update mem type in xdp_buff

 drivers/net/veth.c | 2 ++
 include/net/xdp.h  | 7 +++++++
 net/core/dev.c     | 2 ++
 3 files changed, 11 insertions(+)

-- 
2.43.0


