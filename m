Return-Path: <bpf+bounces-53352-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ACF1AA50486
	for <lists+bpf@lfdr.de>; Wed,  5 Mar 2025 17:22:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 070453A4EDC
	for <lists+bpf@lfdr.de>; Wed,  5 Mar 2025 16:22:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A99B318CBEC;
	Wed,  5 Mar 2025 16:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kNPSttgD"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BAD118A6B5;
	Wed,  5 Mar 2025 16:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741191738; cv=none; b=hac9IUiyaxRCYJ6MHj5Dq//37ZonFRHFYxBYKjRK5dgSNOVlWh3zHB+tPVoZrDEVxrCc+ck8gwqyFqJFFe043epYSVtN/HDPmiuF/WoAegr3TL0wScttm8qBaFGbImDcuSTzedS16hfk3nKTimTkhBnFixVkEaQh6FJIXb1Or/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741191738; c=relaxed/simple;
	bh=v13//dhbWZHhDVaFI/IbNE+FzNKUL+cXelUKHDL/Wds=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Xv09D8iJSQlabZMnfyZ/bXYWeNB0PE5LB6MAfDcGGDE4P0uveU4UOTqz4BbFk05Ba7YE9UkvQ9GKgPyb+SautgD46E9zzCigN0kgMH5NLgl0P1YFYI1cSgQmH60hthI+gvmDRpTXTcR8YiyaO4bdgl5dYMf37W6k65j7T44j9Ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kNPSttgD; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741191736; x=1772727736;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=v13//dhbWZHhDVaFI/IbNE+FzNKUL+cXelUKHDL/Wds=;
  b=kNPSttgDq/cTkHnJOosh0mYt752OZw3zgOuJydfCvVlAdXSi+xTjwEtQ
   sqN5FlSdcsurk2NJAV2VLlhMp/pyw0lJ7d57/t3NC73T+OSlLCHoFdpBX
   UTr8eBnMmyV4T/etVPOSmiwk0IvAPc4sPskCN6rKg7rsgPeN5u5tui1eH
   SdkBe0mouIkh8ex5w273fn6yTiVSCnN2606N3mV6IWF8kEjoN+e/hnWK1
   PnR178QdEsXm/HrPBhjOnVbevT5ADvgWD41/7R5MFj+EJlaOO2gbDQdwL
   3k5Ek4f6aQGB8uzg6FzeK8IiyqKJ67ND07cbXHXwsyWnW81Gx+6BWrf3s
   w==;
X-CSE-ConnectionGUID: Fx+U+SCfR4aeIIksELeHWw==
X-CSE-MsgGUID: AYKM9jKMR5eLyVuPbgm1FA==
X-IronPort-AV: E=McAfee;i="6700,10204,11363"; a="42026361"
X-IronPort-AV: E=Sophos;i="6.14,223,1736841600"; 
   d="scan'208";a="42026361"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2025 08:22:15 -0800
X-CSE-ConnectionGUID: mMOOr5OgRUKBjXWggRPiRQ==
X-CSE-MsgGUID: 1jGkdLoVSI6dWxok8TQhew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,223,1736841600"; 
   d="scan'208";a="123832845"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by fmviesa004.fm.intel.com with ESMTP; 05 Mar 2025 08:22:10 -0800
From: Alexander Lobakin <aleksander.lobakin@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>,
	Michal Kubiak <michal.kubiak@intel.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Simon Horman <horms@kernel.org>,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 00/16] idpf: add XDP support
Date: Wed,  5 Mar 2025 17:21:16 +0100
Message-ID: <20250305162132.1106080-1-aleksander.lobakin@intel.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add XDP support (w/o XSk yet) to the idpf driver using the libeth_xdp
sublib, which will be then reused in at least iavf and ice.

In general, nothing outstanding comparing to ice, except performance --
let's say, up to 2x for .ndo_xdp_xmit() on certain platforms and
scenarios. libeth_xdp doesn't reinvent the wheel, mostly just
accumulates and optimizes what was already done before to stop copying
that wheel and the bugs over and over again.
idpf doesn't support VLAN Rx offload, so only the hash hint is present
for now.

Alexander Lobakin (12):
  libeth: convert to netmem
  libeth: support native XDP and register memory model
  libeth: add a couple of XDP helpers (libeth_xdp)
  libeth: add XSk helpers
  idpf: fix Rx descriptor ready check barrier in splitq
  idpf: a use saner limit for default number of queues to allocate
  idpf: link NAPIs to queues
  idpf: add support for nointerrupt queues
  idpf: use generic functions to build xdp_buff and skb
  idpf: add support for XDP on Rx
  idpf: add support for .ndo_xdp_xmit()
  idpf: add XDP RSS hash hint

Michal Kubiak (4):
  idpf: make complq cleaning dependent on scheduling mode
  idpf: remove SW marker handling from NAPI
  idpf: prepare structures to support XDP
  idpf: implement XDP_SETUP_PROG in ndo_bpf for splitq

 drivers/net/ethernet/intel/idpf/Kconfig       |    2 +-
 drivers/net/ethernet/intel/libeth/Kconfig     |   10 +-
 drivers/net/ethernet/intel/idpf/Makefile      |    2 +
 drivers/net/ethernet/intel/libeth/Makefile    |    8 +-
 include/net/libeth/types.h                    |  106 +-
 drivers/net/ethernet/intel/idpf/idpf.h        |   35 +-
 .../net/ethernet/intel/idpf/idpf_lan_txrx.h   |    6 +-
 drivers/net/ethernet/intel/idpf/idpf_txrx.h   |  126 +-
 drivers/net/ethernet/intel/idpf/xdp.h         |  180 ++
 drivers/net/ethernet/intel/libeth/priv.h      |   37 +
 include/net/libeth/rx.h                       |   28 +-
 include/net/libeth/tx.h                       |   36 +-
 include/net/libeth/xdp.h                      | 1869 +++++++++++++++++
 include/net/libeth/xsk.h                      |  685 ++++++
 drivers/net/ethernet/intel/iavf/iavf_txrx.c   |   14 +-
 drivers/net/ethernet/intel/idpf/idpf_dev.c    |   11 +-
 .../net/ethernet/intel/idpf/idpf_ethtool.c    |    6 +-
 drivers/net/ethernet/intel/idpf/idpf_lib.c    |   29 +-
 drivers/net/ethernet/intel/idpf/idpf_main.c   |    1 +
 .../ethernet/intel/idpf/idpf_singleq_txrx.c   |  111 +-
 drivers/net/ethernet/intel/idpf/idpf_txrx.c   |  678 +++---
 drivers/net/ethernet/intel/idpf/idpf_vf_dev.c |   11 +-
 .../net/ethernet/intel/idpf/idpf_virtchnl.c   |  113 +-
 drivers/net/ethernet/intel/idpf/xdp.c         |  509 +++++
 drivers/net/ethernet/intel/libeth/rx.c        |   40 +-
 drivers/net/ethernet/intel/libeth/tx.c        |   41 +
 drivers/net/ethernet/intel/libeth/xdp.c       |  449 ++++
 drivers/net/ethernet/intel/libeth/xsk.c       |  269 +++
 28 files changed, 4925 insertions(+), 487 deletions(-)
 create mode 100644 drivers/net/ethernet/intel/idpf/xdp.h
 create mode 100644 drivers/net/ethernet/intel/libeth/priv.h
 create mode 100644 include/net/libeth/xdp.h
 create mode 100644 include/net/libeth/xsk.h
 create mode 100644 drivers/net/ethernet/intel/idpf/xdp.c
 create mode 100644 drivers/net/ethernet/intel/libeth/tx.c
 create mode 100644 drivers/net/ethernet/intel/libeth/xdp.c
 create mode 100644 drivers/net/ethernet/intel/libeth/xsk.c

---
Sending in one batch to introduce/show both the lib and the user.
Let me know if I'd better split.
-- 
2.48.1


