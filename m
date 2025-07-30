Return-Path: <bpf+bounces-64711-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D5D03B16413
	for <lists+bpf@lfdr.de>; Wed, 30 Jul 2025 18:07:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52CEE18926EA
	for <lists+bpf@lfdr.de>; Wed, 30 Jul 2025 16:08:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 755312DCF64;
	Wed, 30 Jul 2025 16:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Z8NTfixg"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 375B2CA52;
	Wed, 30 Jul 2025 16:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753891669; cv=none; b=uDdlV9/Ky0psLbwog0t0FMvjzbIPYbedeKXXnTh+zXFiDbVC2nE8w5LFkuD7WTGo4eBD0S5Q5VfjNQZfuaoQeh4sOv19AE1GS3RvPQ6QLKzAmW01xGEhK+TwOwkb4mtzu7iV7ZBwAGMLJnWh3Z1e8OC/dE1bSO4AaMUXqkX1GeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753891669; c=relaxed/simple;
	bh=NkE32OUza/abY3/2RhJRNJXE/p1m9qtlJckwPiJMCNU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Yfdx21BSgBgbahcsMXym/8IWDnqwvK4etuGeqZW1YZQ+1GwyjfHrtigZ8GfvHGo6YPL8AXg4pWzLgUsQCuTDhXoU93Y0DTEb9sVh3/K5iet2BNb579QhI+I+/v3DXO/S4481zsJXC9Ui8ZKxfaU3ZK7idfLi3HqaIcpA8VGgfjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Z8NTfixg; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753891667; x=1785427667;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=NkE32OUza/abY3/2RhJRNJXE/p1m9qtlJckwPiJMCNU=;
  b=Z8NTfixg9OzoP/3uyPssiCZ8JeyryZ7Dir7ZRel2LNnrtJFJspmB+ZUX
   GO0MT/Qsf2Nad8hdEc/vMUzIqpWYLvTeXB80SWYMUpeq7+YSOWM7wVA4e
   +Hlfd4+Bgp4QRRFc9hzQeLBA564rGwhIWDSCOd9ssHDodnGZiAHucOmxX
   Yim1++GZ52Ix4aHycuzsHV8PVj7wPVXpkBgcjmFrOK4uqq3fTDxEeTazH
   q2aBa762p1+A62Wk8ufoQH3YkDP+szQl4LIL8VVaSwejWj2+/uv0YzpCJ
   wBNbA8JfyDX0gzgBfT/2fn046arQ3a5xk+NpZS8tHTmOEPX3CW+DO6B0F
   A==;
X-CSE-ConnectionGUID: k53rbS7GSAic2I89wTkc+g==
X-CSE-MsgGUID: Jw3UWU4+Q/OUcssTz3W6tg==
X-IronPort-AV: E=McAfee;i="6800,10657,11507"; a="67278692"
X-IronPort-AV: E=Sophos;i="6.16,350,1744095600"; 
   d="scan'208";a="67278692"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2025 09:07:46 -0700
X-CSE-ConnectionGUID: SgaWh9f9SkKngM83EI++Dg==
X-CSE-MsgGUID: Gcl3eqohTU2LqAwsSMukwA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,350,1744095600"; 
   d="scan'208";a="163812831"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by fmviesa010.fm.intel.com with ESMTP; 30 Jul 2025 09:07:42 -0700
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
	Simon Horman <horms@kernel.org>,
	nxne.cnse.osdt.itp.upstreaming@intel.com,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH iwl-next v3 00/18] idpf: add XDP support
Date: Wed, 30 Jul 2025 18:06:59 +0200
Message-ID: <20250730160717.28976-1-aleksander.lobakin@intel.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add XDP support (w/o XSk for now) to the idpf driver using the libeth_xdp
sublib. All possible verdicts, .ndo_xdp_xmit(), multi-buffer etc. are here.
In general, nothing outstanding comparing to ice, except performance --
let's say, up to 2x for .ndo_xdp_xmit() on certain platforms and
scenarios.
idpf doesn't support VLAN Rx offload, so only the hash hint is
available for now.

Patches 1-6 are prereqs, without which XDP would either not work at all or
work slower/worse/...

Alexander Lobakin (8):
  idpf: fix Rx descriptor ready check barrier in splitq
  idpf: use a saner limit for default number of queues to allocate
  idpf: link NAPIs to queues
  idpf: add support for nointerrupt queues
  idpf: use generic functions to build xdp_buff and skb
  idpf: add support for XDP on Rx
  idpf: add support for .ndo_xdp_xmit()
  idpf: add XDP RSS hash hint

Joshua Hay (6):
  idpf: add support for Tx refillqs in flow scheduling mode
  idpf: improve when to set RE bit logic
  idpf: simplify and fix splitq Tx packet rollback error path
  idpf: replace flow scheduling buffer ring with buffer pool
  idpf: stop Tx if there are insufficient buffer resources
  idpf: remove obsolete stashing code

Michal Kubiak (4):
  idpf: add 4-byte completion descriptor definition
  idpf: remove SW marker handling from NAPI
  idpf: prepare structures to support XDP
  idpf: implement XDP_SETUP_PROG in ndo_bpf for splitq

 drivers/net/ethernet/intel/idpf/Kconfig       |    2 +-
 drivers/net/ethernet/intel/idpf/Makefile      |    2 +
 drivers/net/ethernet/intel/idpf/idpf.h        |   31 +-
 .../net/ethernet/intel/idpf/idpf_lan_txrx.h   |    6 +-
 drivers/net/ethernet/intel/idpf/idpf_txrx.h   |  217 ++--
 .../net/ethernet/intel/idpf/idpf_virtchnl.h   |    1 -
 drivers/net/ethernet/intel/idpf/xdp.h         |  172 +++
 drivers/net/ethernet/intel/idpf/idpf_dev.c    |   11 +-
 .../net/ethernet/intel/idpf/idpf_ethtool.c    |    6 +-
 drivers/net/ethernet/intel/idpf/idpf_lib.c    |   67 +-
 drivers/net/ethernet/intel/idpf/idpf_main.c   |    1 +
 .../ethernet/intel/idpf/idpf_singleq_txrx.c   |  171 ++-
 drivers/net/ethernet/intel/idpf/idpf_txrx.c   | 1142 +++++++----------
 drivers/net/ethernet/intel/idpf/idpf_vf_dev.c |   11 +-
 .../net/ethernet/intel/idpf/idpf_virtchnl.c   |  173 +--
 drivers/net/ethernet/intel/idpf/xdp.c         |  452 +++++++
 16 files changed, 1541 insertions(+), 924 deletions(-)
 create mode 100644 drivers/net/ethernet/intel/idpf/xdp.h
 create mode 100644 drivers/net/ethernet/intel/idpf/xdp.c

---
Sending to get reviews and to trigger Intel's validation.

Joshua's series[0] is included and goes first to resolve conflicts.
It is *not* a part of the actual series.

From v2[1]:
* rebase on top of [0] to resolve conflicts in Tony's tree;
* 02:
  * harmonize maximum number of queues to not create more Tx queues than
    completion queues or more Rx queues than buffer queues / 2;
  * fix VC timeouts on certain steppings as there processing a lot of queues
    can take more time than the minimum timeout of 2 seconds;
* 03: fix RTNL assertion fail on PCI reset.

From v1[2]:
* drop the libeth_xdp part (submitted separately and accepted);
* fix some typos and kdocs (Jakub, Maciej);
* pick a couple RBs (Maciej);
* 03: create a convenience helper (Maciej), fix rtnl assertion fail;
* 04: since XDP uses its own queue cleaning routines, don't add 4-byte
      completion support to the skb code;
* 05: don't use old weird logic with negative descriptor index (Maciej);
* 06: fix invalid interrupt vector counting in certain cases;
* 07: fix cleanup timer is fired after the queue buffers are already freed;
* 08: fix XDP program removal in corner cases such as PCI reset or
      remove request when there's no active prog (from netdev_unregister());
* 10: fix rare queue stuck -- HW requires to always have at least one free Tx
      descriptor on the queue, otherwise it thinks the queue is empty and
      there's nothing to send (true Intel HW veteran bug).

Testing hints: basic Rx and Tx (TCP, UDP, VLAN, HW GRO on/off, trafficgen
stress tests, performance comparison); xdp-tools with all possible actions
(xdp-bench for PASS, DROP, TX, REDIRECT to cpumap, devmap (inc self-redirect);
xdp-trafficgen to double-check XDP xmit). Would be nice to see a perf
comparison against ice (in percent) (idpf must be plugged into a PCIe 5.x).

[0] https://lore.kernel.org/intel-wired-lan/20250725184223.4084821-1-joshua.a.hay@intel.com
[1] https://lore.kernel.org/intel-wired-lan/20250624164515.2663137-1-aleksander.lobakin@intel.com
[2] https://lore.kernel.org/intel-wired-lan/20250305162132.1106080-1-aleksander.lobakin@intel.com
-- 
2.50.1


