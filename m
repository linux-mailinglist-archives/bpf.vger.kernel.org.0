Return-Path: <bpf+bounces-47014-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09BBF9F2A4D
	for <lists+bpf@lfdr.de>; Mon, 16 Dec 2024 07:48:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D31A166BD5
	for <lists+bpf@lfdr.de>; Mon, 16 Dec 2024 06:48:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 890AE1CD208;
	Mon, 16 Dec 2024 06:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="axzr4p6y"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BACFA48;
	Mon, 16 Dec 2024 06:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734331727; cv=none; b=dwss8QWZuYdf42qpKmeZPjS3pFAJz0lZe5FKfjpOU5kRLcMvBZtebcSioeSXOZc5h//19PnjZAuWIsLNZBJWsIfaVsctHOPkqcYcpqSD3P6GIp3peva3gBUBJKk/s9+a9bgyYylaD51GorMOqbA95H3CWuAT9Vs27xV/TrflPsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734331727; c=relaxed/simple;
	bh=f6imVHIwBO5y+VNI+OBSEm0607sjuDvEWjjMWJjz7Jo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=LQUcQjzpNVYE1HWqdnIlC1Crh0pNjSeVTgsOE1X/OjuG6io07Rv1jTUZFffqn7FsCSe4r6qEiopkP4vUj6nnbn3Ne7m4UUIk5AQghmcZyVDytwq/TId2BqeJb5MJh4VLfQoZ0mjbQUctvEgm2acWXHO9R3+9X1s/bOvihN53lWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=axzr4p6y; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734331726; x=1765867726;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=f6imVHIwBO5y+VNI+OBSEm0607sjuDvEWjjMWJjz7Jo=;
  b=axzr4p6yAP+9nMzGJ69RuIT0i95RSIaRTYalP34zXqdvci0XbevwKu7j
   Yt0rn28tmBQNL5QJlyHe9XiaPamc4axHuAx3ZUAJXCKontlvjzZXjbKlT
   GUvrqCqwmPFtYAZtHDXQgyCmz711ZliRXBGJOvkMrBepNLNMkb45Q9p8Y
   rApP/dNnc8wu4GCIxlNSB9yOgphQneDzwFkV8MJXPo/xiCHR0yKENHDX2
   ZbzmPFwyVleVmcwm4Yhvk6lxyuj+f7yuruULeuwx1dsR1aFcCcIQIZGvA
   TKdTNzfvJscOHU1xETZHYY0MCyp+q1Ce359aAhqXllsF9HhDJVm7mdAHT
   A==;
X-CSE-ConnectionGUID: ODhR4mkWTdW53j3l7VaA/g==
X-CSE-MsgGUID: kMKFXXGVRI+QnOOnVRFB4w==
X-IronPort-AV: E=McAfee;i="6700,10204,11287"; a="34848179"
X-IronPort-AV: E=Sophos;i="6.12,237,1728975600"; 
   d="scan'208";a="34848179"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2024 22:48:45 -0800
X-CSE-ConnectionGUID: 0ZYhOhqLRF2QZFp/LSt1ow==
X-CSE-MsgGUID: H+0+CYdpREuAj9JqRrXIKw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="128101836"
Received: from mohdfai2-ilbpg12-1.png.intel.com ([10.88.227.73])
  by fmviesa001.fm.intel.com with ESMTP; 15 Dec 2024 22:48:41 -0800
From: Faizal Rahim <faizal.abdul.rahim@linux.intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Vinicius Costa Gomes <vinicius.gomes@intel.com>
Cc: Faizal Rahim <faizal.abdul.rahim@linux.intel.com>,
	intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH iwl-next 0/9] igc: Add support for Frame Preemption feature in IGC
Date: Mon, 16 Dec 2024 01:47:11 -0500
Message-Id: <20241216064720.931522-1-faizal.abdul.rahim@linux.intel.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduces support for the FPE feature in the IGC driver.

The patches aligns with the upstream FPE API:
https://patchwork.kernel.org/project/netdevbpf/cover/20230220122343.1156614-1-vladimir.oltean@nxp.com/
https://patchwork.kernel.org/project/netdevbpf/cover/20230119122705.73054-1-vladimir.oltean@nxp.com/

It builds upon earlier work:
https://patchwork.kernel.org/project/netdevbpf/cover/20220520011538.1098888-1-vinicius.gomes@intel.com/

The first four patches in this series are preparation work for the subsequent patches.

The patch series adds the following functionalities to the IGC driver:
a) Configure FPE using `ethtool --set-mm`.
b) Display FPE settings via `ethtool --show-mm`.
c) View FPE statistics using `ethtool --include-statistics --show-mm'.
e) Enable preemptible/express queue with `fp`:
   tc qdisc add ... root taprio \
   fp E E P P

Note:
1. preemption can occur with or without the verification handshake,
   depending on the value of the verify_enabled field, which can be
   configured using ethtool --set-mm.
2. Enabling FPE with mqprio offload is not covered in this series, but
   existing code prevents user from configuring FPE alongside mqprio offload.

Faizal Rahim (6):
  igc: Rename xdp_get_tx_ring() for non-xdp usage
  igc: Add support to set MAC Merge data via ethtool
  igc: Add support for frame preemption verification
  igc: Add support for preemptible traffic class in taprio
  igc: Add support to get MAC Merge data via ethtool
  igc: Add support to get frame preemption statistics via ethtool

Vinicius Costa Gomes (3):
  igc: Optimize the TX packet buffer utilization
  igc: Set the RX packet buffer size for TSN mode
  igc: Add support for receiving frames with all zeroes address

 drivers/net/ethernet/intel/igc/igc.h         |  45 ++-
 drivers/net/ethernet/intel/igc/igc_defines.h |  15 +-
 drivers/net/ethernet/intel/igc/igc_ethtool.c |  96 ++++++
 drivers/net/ethernet/intel/igc/igc_main.c    |  80 ++++-
 drivers/net/ethernet/intel/igc/igc_regs.h    |  19 ++
 drivers/net/ethernet/intel/igc/igc_tsn.c     | 330 ++++++++++++++++++-
 drivers/net/ethernet/intel/igc/igc_tsn.h     |  15 +
 7 files changed, 586 insertions(+), 14 deletions(-)

--
2.25.1


