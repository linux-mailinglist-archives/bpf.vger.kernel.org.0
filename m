Return-Path: <bpf+bounces-18529-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C85381B887
	for <lists+bpf@lfdr.de>; Thu, 21 Dec 2023 14:48:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F9D41C23C5D
	for <lists+bpf@lfdr.de>; Thu, 21 Dec 2023 13:48:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F6A364ABD;
	Thu, 21 Dec 2023 13:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="blgy6dS3"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3122864AB8;
	Thu, 21 Dec 2023 13:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703165226; x=1734701226;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=xHIsuzxJ0t1s7E2GQ2IXc8tRENtEmDYxmpzkrgrHzlM=;
  b=blgy6dS3XKpM559HDuJG0PAfmQxyR2I17lsBwuoYlEOij73Okv9r1gvE
   t+sHWBe/ets4TpKQWFMOC6M8tP0g/jq0rai1E3gNY3w4hHZb+orvDc0qs
   h+uYANSUzIi/+q8n2w8WpE62r63HXDPO9FNAMC/B04GsMRRbQhI1+ox4J
   DPBCfWT09eYkBerpc7nDeaW/Imb9hBvejSOENBTcgIZ7UqWV4FxYr93SK
   8GjP1qupuGK/Z1x5a5DDdzolx5gpTO27kM/lQL0aZr8kE21w+rI7LolPf
   Wdtrrs/CAU1GKgbvyh7SJi5F1d5TcvuhBwNOh+jjmr57tV9yG4u2a2mPO
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10930"; a="3205535"
X-IronPort-AV: E=Sophos;i="6.04,293,1695711600"; 
   d="scan'208";a="3205535"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2023 05:27:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,293,1695711600"; 
   d="scan'208";a="24955762"
Received: from boxer.igk.intel.com ([10.102.20.173])
  by orviesa001.jf.intel.com with ESMTP; 21 Dec 2023 05:27:03 -0800
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org
Cc: netdev@vger.kernel.org,
	magnus.karlsson@intel.com,
	bjorn@kernel.org,
	maciej.fijalkowski@intel.com,
	echaudro@redhat.com,
	lorenzo@kernel.org,
	tirthendu.sarkar@intel.com
Subject: [PATCH v3 bpf 0/4] net: bpf_xdp_adjust_tail() fixes
Date: Thu, 21 Dec 2023 14:26:52 +0100
Message-Id: <20231221132656.384606-1-maciej.fijalkowski@intel.com>
X-Mailer: git-send-email 2.35.3
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

this set is about fixing bpf_xdp_adjust_tail() usage in XDP progs for
multi-buffer AF_XDP. Both copy and zero-copy modes were broken.

Thanks,
Maciej

v3:
- add acks
- s/xsk_buff_tail_del/xsk_buff_del_tail
- address i40e as well (thanks Tirthendu)

v2:
- fix !CONFIG_XDP_SOCKETS builds
- add reviewed-by tag to patch 3

Maciej Fijalkowski (3):
  xsk: recycle buffer in case Rx queue was full
  xsk: fix usage of multi-buffer BPF helpers for ZC XDP
  ice: work on pre-XDP prog frag count

Tirthendu Sarkar (1):
  i40e: handle multi-buffer packets that are shrunk by xdp prog

 drivers/net/ethernet/intel/i40e/i40e_txrx.c   | 42 +++++++++-------
 drivers/net/ethernet/intel/ice/ice_txrx.c     | 14 ++++--
 drivers/net/ethernet/intel/ice/ice_txrx.h     |  1 +
 drivers/net/ethernet/intel/ice/ice_txrx_lib.h | 31 ++++++++----
 include/net/xdp_sock_drv.h                    | 26 ++++++++++
 net/core/filter.c                             | 48 +++++++++++++++----
 net/xdp/xsk.c                                 | 12 +++--
 7 files changed, 129 insertions(+), 45 deletions(-)

-- 
2.34.1


