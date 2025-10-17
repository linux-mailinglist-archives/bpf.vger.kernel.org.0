Return-Path: <bpf+bounces-71213-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id F097FBE9371
	for <lists+bpf@lfdr.de>; Fri, 17 Oct 2025 16:33:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 243A34FF26C
	for <lists+bpf@lfdr.de>; Fri, 17 Oct 2025 14:31:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E8352F692B;
	Fri, 17 Oct 2025 14:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="brwLrjGc"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22248339705;
	Fri, 17 Oct 2025 14:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760711488; cv=none; b=mlmMge4DKoZeCu7dexkmDSm2sOqkVMkBHhkAK+B20JaxtwdpSRImZPlzBk2eYfxl4Qjt0tj1EOKnP9l4eBIebsdOOpdljghzZG8DlJ130A2bX1LY3SuqH9z+ZkSHdHoCwsbbXVOPDL5GcwPDuP831jv9xrzvfkjOr8bo0Zy3QwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760711488; c=relaxed/simple;
	bh=3ujP/aAg+GR/CqWn1/PNYm4mr5+9jnCHoL2066ZgRnk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gSkXkwvvextaq6RFGPJzcDSmLzp4tNvIJ9EvHGViFbHQguBQ8ryAK1xAGD/K/MMII5qknxfvw8cyeN2enuby6yqw+kDSjKsJO9//UO6dtsepdiMuG6YFXRJYavXhX6g2asHvdr3XLw1yvH7Y6GjtUJXapVX2u3Ycc1GyeIB++Ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=brwLrjGc; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760711486; x=1792247486;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=3ujP/aAg+GR/CqWn1/PNYm4mr5+9jnCHoL2066ZgRnk=;
  b=brwLrjGcbx+5eyUAN/ugsY6cu8K5DS5v66tK9c7OpsJeu43AxTiGL44O
   6vN/j1X98XcpnFKgMi+EI5kOSZ72UvpPwMbVqiL//CmA9wgL1KvvKspDa
   FJgams4CjN4mrhqHLsIhALxhFc5BB7ej/1eul+ddKoBAnQYsgKqMIWHz3
   FARWT1dD6MmuDJIt5psl2KNx7bzlX2cXpR3k+F1erVUEAABIriUHU0ep2
   SXxuMiFQEtHB1+xnlzRtwSK4sGEwngUFb2b+NFU5NyrzeQ6RjmWgn51fb
   DeferjJF4MRU/+EHlw2/R5iWbtCEDmweQm3tfrNYXko3QRo8qfQHKCI+H
   Q==;
X-CSE-ConnectionGUID: B518TE0SQ/agsxf9Coy7Dw==
X-CSE-MsgGUID: 9Rz+s4ayRR2JuCE2kTs3Wg==
X-IronPort-AV: E=McAfee;i="6800,10657,11585"; a="73208017"
X-IronPort-AV: E=Sophos;i="6.19,236,1754982000"; 
   d="scan'208";a="73208017"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2025 07:31:25 -0700
X-CSE-ConnectionGUID: J/ZEkhP0T8KjIYrfXBmhIQ==
X-CSE-MsgGUID: uHcy8rQzTR+UYhXdSzuEEw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,236,1754982000"; 
   d="scan'208";a="213717388"
Received: from boxer.igk.intel.com ([10.102.20.173])
  by fmviesa001.fm.intel.com with ESMTP; 17 Oct 2025 07:31:21 -0700
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	ilias.apalodimas@linaro.org,
	toke@redhat.com,
	lorenzo@kernel.org,
	kuba@kernel.org
Cc: netdev@vger.kernel.org,
	magnus.karlsson@intel.com,
	andrii@kernel.org,
	stfomichev@gmail.com,
	aleksander.lobakin@intel.com,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Subject: [PATCH v2 bpf 0/2] xdp: fix page_pool leaks
Date: Fri, 17 Oct 2025 16:31:01 +0200
Message-Id: <20251017143103.2620164-1-maciej.fijalkowski@intel.com>
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
  xdp: update xdp_rxq_info's mem type in XDP generic hook
  veth: update mem type in xdp_buff

 drivers/net/veth.c | 43 +++++++++++++++++++++++++++----------------
 include/net/xdp.h  | 31 +++++++++++++++++++++++++++++++
 net/core/dev.c     | 25 ++++---------------------
 3 files changed, 62 insertions(+), 37 deletions(-)

-- 
2.43.0


