Return-Path: <bpf+bounces-36704-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 74B3294C474
	for <lists+bpf@lfdr.de>; Thu,  8 Aug 2024 20:36:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF32B289370
	for <lists+bpf@lfdr.de>; Thu,  8 Aug 2024 18:36:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2949148FF6;
	Thu,  8 Aug 2024 18:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LrdqSezu"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EC9F78281;
	Thu,  8 Aug 2024 18:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723142165; cv=none; b=tpPyduarZFrv+g9Kg/M0z/tTjxXLZNot8A3ECmhT0vq4MpYiapABNH7cauVhyaLZniBSeljCp6SRW6iPlH5zTlTI8sPTR6FTm5fszRBevQF70lijMHHV1a3CTD3f60C/ssUEBl6xa+pmjv5PljBxSLojhEaTXtOg312jbeEp1Zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723142165; c=relaxed/simple;
	bh=A81gnDNyVV1Bk3ZdwfAWH0gZ95Mtqteb2SDcghELrso=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=vFSPenLht0z9HW2gncKK7eLMAaWT1ZuvLRguqn8dBKqvODzLybh3h3/fmj42Z802D/qYhJj88/06hrWoa5Jeb4cQXedVKBvR4np9Kk5yuPu+of+tm/CkyhH+tZ9oUa+ugEBFqo/AjYMNHOGTT5fCKQUEtuU6WyvpXpzKSYV9Qbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LrdqSezu; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723142164; x=1754678164;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=A81gnDNyVV1Bk3ZdwfAWH0gZ95Mtqteb2SDcghELrso=;
  b=LrdqSezu7k24jLhnGg1wppqfSXVMULM6IX5bnbRJ3R/Doj06fM6+N34h
   9m1sTFowaO/i1NnJpQsX4tfrR/1LSQsrMxqZ8JtHs4nismIq2Q/QfKDbY
   cuRGaSxRFcErIyzUoh0uZsyr6eBAyf6tgikPcRz4iHYvWswc7odqHTgpm
   wj4TPPGc235knITJqO/t7mss7VVm7kFM/KwtSpCCyEmYS9f9J4aFbx6zl
   iCmkF07xaRWquRVPnu344tVCWdVDqK3Zjso2y8tUdRydK+undfoXGDBrB
   xjCv6WcSqErUon6Lvwx2/oDBxmH6WD2s+FI8sLQS2JF7mjhK7s9Ug7Mjt
   w==;
X-CSE-ConnectionGUID: tHCNYXrRSByiKeLfUSdXCQ==
X-CSE-MsgGUID: zAMmujeITParvhUBiCnGkQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11158"; a="43807471"
X-IronPort-AV: E=Sophos;i="6.09,273,1716274800"; 
   d="scan'208";a="43807471"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2024 11:36:03 -0700
X-CSE-ConnectionGUID: n9hSAvorSHCOtgfi/o/Zew==
X-CSE-MsgGUID: RY8vFNshTPmY6LI49wxBGg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,273,1716274800"; 
   d="scan'208";a="57279473"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa008.fm.intel.com with ESMTP; 08 Aug 2024 11:36:01 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
	maciej.fijalkowski@intel.com,
	magnus.karlsson@intel.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	bpf@vger.kernel.org,
	kurt@linutronix.de,
	sriram.yagnaraman@ericsson.com,
	richardcochran@gmail.com,
	benjamin.steinke@woks-audio.com,
	bigeasy@linutronix.de
Subject: [PATCH net-next 0/4][pull request] igb: Add support for AF_XDP zero-copy
Date: Thu,  8 Aug 2024 11:35:50 -0700
Message-ID: <20240808183556.386397-1-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Kurt Kanzenbach says:

Since Sriram's duties changed I am sending this instead. Additionally,
I've tested this on real hardware, Intel i210 [1].

Changes since iwl-next v4:

 - Rebase to v6.10
 - Fix issue reported by kernel test robot
 - Provide napi_id for for xdp_rxq_info_reg() so that busy polling works
 - Set olinfo_status in igb_xmit_zc() so that frames are transmitted

Link to v4: https://lore.kernel.org/intel-wired-lan/20230804084051.14194-1-sriram.yagnaraman@est.tech/

[1] - https://github.com/Linutronix/TSN-Testbench/tree/main/tests/busypolling_i210

Original cover letter:

The first couple of patches adds helper functions to prepare for AF_XDP
zero-copy support which comes in the last couple of patches, one each
for Rx and TX paths.

As mentioned in v1 patchset [0], I don't have access to an actual IGB
device to provide correct performance numbers. I have used Intel 82576EB
emulator in QEMU [1] to test the changes to IGB driver.

The tests use one isolated vCPU for RX/TX and one isolated vCPU for the
xdp-sock application [2]. Hope these measurements provide at the least
some indication on the increase in performance when using ZC, especially
in the TX path. It would be awesome if someone with a real IGB NIC can
test the patch.

AF_XDP performance using 64 byte packets in Kpps.
Benchmark:	XDP-SKB		XDP-DRV		XDP-DRV(ZC)
rxdrop		220		235		350
txpush		1.000		1.000		410
l2fwd 		1.000		1.000		200

AF_XDP performance using 1500 byte packets in Kpps.
Benchmark:	XDP-SKB		XDP-DRV		XDP-DRV(ZC)
rxdrop		200		210		310
txpush		1.000		1.000		410
l2fwd 		0.900		1.000		160

[0]: https://lore.kernel.org/intel-wired-lan/20230704095915.9750-1-sriram.yagnaraman@est.tech/
[1]: https://www.qemu.org/docs/master/system/devices/igb.html
[2]: https://github.com/xdp-project/bpf-examples/tree/master/AF_XDP-example
---
iwl-next: https://lore.kernel.org/intel-wired-lan/20240711-b4-igb_zero_copy-v5-0-f3f455113b11@linutronix.de/

The following are changes since commit 91d516d4de48532d967a77967834e00c8c53dfe6:
  net: mvpp2: Increase size of queue_name buffer
and are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue 1GbE

Sriram Yagnaraman (4):
  igb: prepare for AF_XDP zero-copy support
  igb: Introduce XSK data structures and helpers
  igb: add AF_XDP zero-copy Rx support
  igb: add AF_XDP zero-copy Tx support

 drivers/net/ethernet/intel/igb/Makefile   |   2 +-
 drivers/net/ethernet/intel/igb/igb.h      |  35 +-
 drivers/net/ethernet/intel/igb/igb_main.c | 189 ++++++--
 drivers/net/ethernet/intel/igb/igb_xsk.c  | 522 ++++++++++++++++++++++
 4 files changed, 700 insertions(+), 48 deletions(-)
 create mode 100644 drivers/net/ethernet/intel/igb/igb_xsk.c

-- 
2.42.0


