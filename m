Return-Path: <bpf+bounces-66558-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C9159B36FAA
	for <lists+bpf@lfdr.de>; Tue, 26 Aug 2025 18:13:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E5C851BA144F
	for <lists+bpf@lfdr.de>; Tue, 26 Aug 2025 16:13:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31F59308F08;
	Tue, 26 Aug 2025 16:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QmvUoE9i"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAA4F1B85F8;
	Tue, 26 Aug 2025 16:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756224809; cv=none; b=gMIcuOskKmOFEjbk+g1xj1qfWT6u9BA7ICaCrZo6Qq4jQbJusXi0sWBlxLuYN5G6U5H/DASQtorOs2lpmMrdRuMjNLVC+s9GDsmz4e3V9fT2+W7RoBxPaxj2hOGjNUCBPUUT6TI1jURm9kZEqJpsfmdbzRmMjHGHjSDrfzD78Ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756224809; c=relaxed/simple;
	bh=fQ3qr7gSKNiOWy7nrlKhfuZMLVGkbuKfJR1k3nNyANI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MKZkrQ5vRK5m1Wg1AXR4VBGcwbAKhVNoJQ5On8HVLlqScIWhGRuRLEygk/bjlB6/7/56G5ikaJFeC/3DddknhXKkQfoqUrDXmpgbubOy/4xBG6JeDP/8cyPXKMpHIgfT4vVXf3/jEdD4Zyex/Zkxur8z0RfBPqUNVfoJ/5rQuec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QmvUoE9i; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756224808; x=1787760808;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=fQ3qr7gSKNiOWy7nrlKhfuZMLVGkbuKfJR1k3nNyANI=;
  b=QmvUoE9iZtQmjisDuQXofq+ySrEV9ZJzYRyPdF5URDQXJoNyUXZiq3kR
   kafTT3uwkAaq5Iy8fxLJk6yWFOk9ePM3XG6stypOzj8ByAun6NzcxoC/o
   MAF5PxjRIJKPNHmbp4AEgE/5f2AVI8CJtGmo3UTbO9nzE9UwG0VY6LXs7
   RIZ2VxkALUTEKSPmNc1Ds7VLymt69ggCD8sThmafyedWUV37b+L0Q/bdM
   gF009rCOjuysO1JFhKC0P7wlyRrbmxN9gxSXKXhvUgDN+6tg5rstvpFOU
   YgPQJjYcroSrL3C3whHnC2FCPn7JqLbMCxlXxv0WWYABPeeW5vzhLCBzz
   Q==;
X-CSE-ConnectionGUID: VBONU64oQQm5eqdISJdxbQ==
X-CSE-MsgGUID: euyyfDm+TuWjLaSLhfmO8g==
X-IronPort-AV: E=McAfee;i="6800,10657,11534"; a="46044850"
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; 
   d="scan'208";a="46044850"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2025 09:13:27 -0700
X-CSE-ConnectionGUID: yOy3j64zTuW3pL1C0sTFrA==
X-CSE-MsgGUID: x/6I4/jBRouXbhqLejwyhg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; 
   d="scan'208";a="200562024"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by orviesa002.jf.intel.com with ESMTP; 26 Aug 2025 09:13:22 -0700
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
Subject: [PATCH iwl-next v5 00/13] idpf: add XDP support
Date: Tue, 26 Aug 2025 17:54:54 +0200
Message-ID: <20250826155507.2138401-1-aleksander.lobakin@intel.com>
X-Mailer: git-send-email 2.51.0
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

Patches 1-7 are prereqs, without which XDP would either not work at all or
work slower/worse/...

Alexander Lobakin (9):
  xdp, libeth: make the xdp_init_buff() micro-optimization generic
  idpf: fix Rx descriptor ready check barrier in splitq
  idpf: use a saner limit for default number of queues to allocate
  idpf: link NAPIs to queues
  idpf: add support for nointerrupt queues
  idpf: use generic functions to build xdp_buff and skb
  idpf: add support for XDP on Rx
  idpf: add support for .ndo_xdp_xmit()
  idpf: add XDP RSS hash hint

Michal Kubiak (4):
  idpf: add 4-byte completion descriptor definition
  idpf: remove SW marker handling from NAPI
  idpf: prepare structures to support XDP
  idpf: implement XDP_SETUP_PROG in ndo_bpf for splitq

 drivers/net/ethernet/intel/idpf/Kconfig       |   2 +-
 drivers/net/ethernet/intel/idpf/Makefile      |   2 +
 drivers/net/ethernet/intel/idpf/idpf.h        |  31 +-
 .../net/ethernet/intel/idpf/idpf_lan_txrx.h   |   6 +-
 drivers/net/ethernet/intel/idpf/idpf_txrx.h   | 140 ++++--
 .../net/ethernet/intel/idpf/idpf_virtchnl.h   |   1 -
 drivers/net/ethernet/intel/idpf/xdp.h         | 172 +++++++
 include/net/libeth/xdp.h                      |  11 +-
 include/net/xdp.h                             |  28 +-
 drivers/net/ethernet/intel/idpf/idpf_dev.c    |  11 +-
 drivers/net/ethernet/intel/idpf/idpf_lib.c    |  67 ++-
 drivers/net/ethernet/intel/idpf/idpf_main.c   |   1 +
 .../ethernet/intel/idpf/idpf_singleq_txrx.c   | 110 ++---
 drivers/net/ethernet/intel/idpf/idpf_txrx.c   | 424 ++++++++--------
 drivers/net/ethernet/intel/idpf/idpf_vf_dev.c |  11 +-
 .../net/ethernet/intel/idpf/idpf_virtchnl.c   | 173 ++++---
 drivers/net/ethernet/intel/idpf/xdp.c         | 454 ++++++++++++++++++
 17 files changed, 1217 insertions(+), 427 deletions(-)
 create mode 100644 drivers/net/ethernet/intel/idpf/xdp.h
 create mode 100644 drivers/net/ethernet/intel/idpf/xdp.c

---
From v4[0]:
* 08/13: fix rare crashes when the number of XDPQSs < nr_cpu_ids -- merge
         artefacts after rebasing on top of Joshua's recent changes;
* 09/13: fix "suspicious RCU usage" during rmmod when lockdep is enabled.

From v3[1]:
* 01/13: make the xdp_init_buff() micro-opt generic, include some
         bloat-o-meter and perf diffs (Simon, Kees);
* 08/13: don't include XDPSQs in Ethtool's 'other_count' (Ethtool
         channels are interrupts!) (Jakub);
* 11/13:
  * finalize XDPSQs a bit earlier on Rx;
  * show some bloat-o-meter and performance diffs for
    __LIBETH_WORD_ACCESS (Jakub).

From v2[2]:
* rebase on top of [3] to resolve conflicts in Tony's tree;
* 02:
  * harmonize maximum number of queues to not create more Tx queues than
    completion queues or more Rx queues than buffer queues / 2;
  * fix VC timeouts on certain steppings as there processing a lot of queues
    can take more time than the minimum timeout of 2 seconds;
* 03: fix RTNL assertion fail on PCI reset.

From v1[4]:
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
comparison against ice (in percent) (idpf must be plugged into a PCIe 4+).

[0] https://lore.kernel.org/intel-wired-lan/20250811161044.32329-1-aleksander.lobakin@intel.com
[1] https://lore.kernel.org/intel-wired-lan/20250730160717.28976-1-aleksander.lobakin@intel.com
[2] https://lore.kernel.org/intel-wired-lan/20250624164515.2663137-1-aleksander.lobakin@intel.com
[3] https://lore.kernel.org/intel-wired-lan/20250725184223.4084821-1-joshua.a.hay@intel.com
[4] https://lore.kernel.org/intel-wired-lan/20250305162132.1106080-1-aleksander.lobakin@intel.com
-- 
2.51.0


