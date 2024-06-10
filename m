Return-Path: <bpf+bounces-31723-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 756EE9025E7
	for <lists+bpf@lfdr.de>; Mon, 10 Jun 2024 17:45:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31DD81F21F06
	for <lists+bpf@lfdr.de>; Mon, 10 Jun 2024 15:45:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 892CC140369;
	Mon, 10 Jun 2024 15:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VWn/11Ul"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D3AB13C3E6;
	Mon, 10 Jun 2024 15:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718034303; cv=none; b=D92HjTXZwUv+XrxfvyeZevmENLnGnrFXaozl8ESVOvFDZcz76cM2yVGyxRCtD2zXd4vXP1Af9ToTiZU6TIwJNabuo4tJXcCCjz4s9xc/7xCUuKWTQRkZ9CKZTSY23aV8MV1Y8dAzIXJuh/rgEW1zpqH4oU5KOs8L6jSUF7+kumY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718034303; c=relaxed/simple;
	bh=ds9g/JKEqawI/ajkSavWOl6Obm7xM2HBK3q/teNQHeQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ACs58CJNvdr/S5T3txQlRAb+A7V5f0LXiIip69Hi8gzzKefcgnoRsnKpq9uLQqQmBnKR1CfAPsiEkO3p2sXO+gH4IdLNwnTKVsa5m3nbd+my1EbZG15LSvyO+cDooc426IqxdE82SFamYvEWZELUICCRb+c9XrrOiuyPyg3qAnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VWn/11Ul; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718034301; x=1749570301;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ds9g/JKEqawI/ajkSavWOl6Obm7xM2HBK3q/teNQHeQ=;
  b=VWn/11Ul9DNMz5/EQxd2uxjzzOkShnIR7MSRgf2PgHQqVjw43+kjFJAo
   Krg4WH9mf1z7+va/jQUasj11Mj5RR9xVxJ5mbkmfG2sh718gsj9E+nR2e
   JQepmskEgcK1V0+eE8S0iJCcD447z7nZcJ9ZiYRCtla517qNwoOky1Ay/
   IcQ5nafWFq7uIF+ZIXrz0nVFNyQEv3tWlmlq6ecO5lzqEzo0TgB4yO/+d
   8jLIHOg3kNt1JlRfj14AmrIxNgydQqzhsoYJ7FdLXsm6/8EI6rEsIjzUR
   IeVpfV7FE3zx7Hvs/QJPjOo+QANEDa6CocmE07A3MreAho9AqkQvhbN95
   Q==;
X-CSE-ConnectionGUID: psWTxMC2Sr2ReAiBFTdxBA==
X-CSE-MsgGUID: 8pdGu4WxT22ze9YX4NAV0A==
X-IronPort-AV: E=McAfee;i="6600,9927,11099"; a="26119830"
X-IronPort-AV: E=Sophos;i="6.08,227,1712646000"; 
   d="scan'208";a="26119830"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2024 08:45:00 -0700
X-CSE-ConnectionGUID: YSJi+AyAS96z2cNVxtFXyg==
X-CSE-MsgGUID: 5mxwVqsETaORA2iS9NgDPw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,227,1712646000"; 
   d="scan'208";a="43679757"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by fmviesa004.fm.intel.com with ESMTP; 10 Jun 2024 08:44:55 -0700
Received: from lincoln.igk.intel.com (lincoln.igk.intel.com [10.102.21.235])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 4A7AE312D4;
	Mon, 10 Jun 2024 16:44:40 +0100 (IST)
From: Larysa Zaremba <larysa.zaremba@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: Larysa Zaremba <larysa.zaremba@intel.com>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	magnus.karlsson@intel.com,
	Michal Kubiak <michal.kubiak@intel.com>
Subject: [PATCH iwl-net 0/3] ice: fix synchronization between .ndo_bpf() and reset
Date: Mon, 10 Jun 2024 17:37:12 +0200
Message-ID: <20240610153716.31493-1-larysa.zaremba@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix the problems that are triggered by tx_timeout and ice_xdp() calls,
including both pool and program operations.

PF reset can be triggered asynchronously, e.g. by tx_timeout. With some
unfortunate timings both reset and .ndo_bpf will try to access and modify
XDP rings at the same time, causing system crash, such as the one below:

[ +1.999878] ice 0000:b1:00.0: Registered XDP mem model MEM_TYPE_XSK_BUFF_POOL on Rx ring 14
[ +2.002992] ice 0000:b1:00.0: Registered XDP mem model MEM_TYPE_XSK_BUFF_POOL on Rx ring 18
[Mar15 18:17] ice 0000:b1:00.0 ens801f0np0: NETDEV WATCHDOG: CPU: 38: transmit queue 14 timed out 80692736 ms
[ +0.000093] ice 0000:b1:00.0 ens801f0np0: tx_timeout: VSI_num: 6, Q 14, NTC: 0x0, HW_HEAD: 0x0, NTU: 0x0, INT: 0x4000001
[ +0.000012] ice 0000:b1:00.0 ens801f0np0: tx_timeout recovery level 1, txqueue 14
[ +0.394718] ice 0000:b1:00.0: PTP reset successful
[ +0.006184] BUG: kernel NULL pointer dereference, address: 0000000000000098
[ +0.000045] #PF: supervisor read access in kernel mode
[ +0.000023] #PF: error_code(0x0000) - not-present page
[ +0.000023] PGD 0 P4D 0
[ +0.000018] Oops: 0000 [#1] PREEMPT SMP NOPTI
[ +0.000023] CPU: 38 PID: 7540 Comm: kworker/38:1 Not tainted 6.8.0-rc7 #1
[ +0.000031] Hardware name: Intel Corporation S2600WFT/S2600WFT, BIOS SE5C620.86B.02.01.0014.082620210524 08/26/2021
[ +0.000036] Workqueue: ice ice_service_task [ice]
[ +0.000183] RIP: 0010:ice_clean_tx_ring+0xa/0xd0 [ice]
[...]
[ +0.000013] Call Trace:
[ +0.000016] <TASK>
[ +0.000014] ? __die+0x1f/0x70
[ +0.000029] ? page_fault_oops+0x171/0x4f0
[ +0.000029] ? schedule+0x3b/0xd0
[ +0.000027] ? exc_page_fault+0x7b/0x180
[ +0.000022] ? asm_exc_page_fault+0x22/0x30
[ +0.000031] ? ice_clean_tx_ring+0xa/0xd0 [ice]
[ +0.000194] ice_free_tx_ring+0xe/0x60 [ice]
[ +0.000186] ice_destroy_xdp_rings+0x157/0x310 [ice]
[ +0.000151] ice_vsi_decfg+0x53/0xe0 [ice]
[ +0.000180] ice_vsi_rebuild+0x239/0x540 [ice]
[ +0.000186] ice_vsi_rebuild_by_type+0x76/0x180 [ice]
[ +0.000145] ice_rebuild+0x18c/0x840 [ice]
[ +0.000145] ? delay_tsc+0x4a/0xc0
[ +0.000022] ? delay_tsc+0x92/0xc0
[ +0.000020] ice_do_reset+0x140/0x180 [ice]
[ +0.000886] ice_service_task+0x404/0x1030 [ice]
[ +0.000824] process_one_work+0x171/0x340
[ +0.000685] worker_thread+0x277/0x3a0
[ +0.000675] ? preempt_count_add+0x6a/0xa0
[ +0.000677] ? _raw_spin_lock_irqsave+0x23/0x50
[ +0.000679] ? __pfx_worker_thread+0x10/0x10
[ +0.000653] kthread+0xf0/0x120
[ +0.000635] ? __pfx_kthread+0x10/0x10
[ +0.000616] ret_from_fork+0x2d/0x50
[ +0.000612] ? __pfx_kthread+0x10/0x10
[ +0.000604] ret_from_fork_asm+0x1b/0x30
[ +0.000604] </TASK>

Larysa Zaremba (3):
  ice: synchronize XDP setup with reset
  ice: fix locking in ice_xsk_pool_setup()
  ice: make NAPI setting code aware that rtnl-locked request is waiting

 drivers/net/ethernet/intel/ice/ice.h      |  2 ++
 drivers/net/ethernet/intel/ice/ice_lib.c  | 23 ++++++++++---
 drivers/net/ethernet/intel/ice/ice_main.c | 39 ++++++++++++++++++++---
 drivers/net/ethernet/intel/ice/ice_xsk.c  | 12 ++-----
 4 files changed, 57 insertions(+), 19 deletions(-)

-- 
2.43.0


