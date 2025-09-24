Return-Path: <bpf+bounces-69587-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 18E83B9B20B
	for <lists+bpf@lfdr.de>; Wed, 24 Sep 2025 19:52:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 46CC31B2670B
	for <lists+bpf@lfdr.de>; Wed, 24 Sep 2025 17:53:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82285315D52;
	Wed, 24 Sep 2025 17:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FKuFRR6N"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 034742F56;
	Wed, 24 Sep 2025 17:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758736362; cv=none; b=uAXgxKuBHUMrtS8pUZcy2G7+PSmC4/rZVOKycKfg43yWaMOF/8ZBucayQ21/FbswF5+B8JBK5jkZnewZGwXOlyGdrhUv6J207G+TyyYrwvqeZntQYiDD1gYWAoYY9HKLZrP10r9V4SpIH8tw+h52v58u311zP8BqVN9A/pSi2zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758736362; c=relaxed/simple;
	bh=vAIbmnGn1LqX/ob/sk8mZRl/P2aV8mq0sMHp91VAbSg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QnkTTiKfARjuzjtVeQeJlDLLwUXSgqUcNfUiSduBr9Tu+H1KamaxC13Kah+lqdGjvPiEKzWDWKhX0+cEcQttfVvGlZZfrQzYwyxNQ34ABeIE8Z5UcQreqx+9qC4UjfblcYDHzaFiO6Ca6Tek9994CYw4Cc7TdgVcOIzGMzx5Vfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FKuFRR6N; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758736360; x=1790272360;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=vAIbmnGn1LqX/ob/sk8mZRl/P2aV8mq0sMHp91VAbSg=;
  b=FKuFRR6NrUC8bEP2k4SL82VwHkcf2RaAt5mhoXm+33HKM3idPVL3ZTeN
   SD0etIvCwF8syNlCDKbqeOLUhIqpUFeNlS1OhK9cquq8/nyAuavdLy5fS
   Q1y1eKji0PAwgmF1CumKuuCl9nKP9RzN93jDnzl4WhKp6XyC1tamf11xj
   zp5nH+eH5w12y/4zRtJdQljDi8XxpFHLpaNJ7j8HrE6MSvU0bPfClyKlU
   BxN/A3qshGJ3iN6yTSZmNPzGu0odm2XAXEhgA+QwoyuldExq5xt8TSIr1
   4Jsq7deh5zRMkv0BkCzX0qrNQZgfXT88wZVPOiwmWarY+vODR99yqVx03
   w==;
X-CSE-ConnectionGUID: S1MnL4rrSS+JrelokzXjtg==
X-CSE-MsgGUID: InCriXRxQK+J5ufRptRC/A==
X-IronPort-AV: E=McAfee;i="6800,10657,11563"; a="61152213"
X-IronPort-AV: E=Sophos;i="6.18,291,1751266800"; 
   d="scan'208";a="61152213"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2025 10:52:39 -0700
X-CSE-ConnectionGUID: KMxoSUyCSVypizdtyEvZgA==
X-CSE-MsgGUID: Ly4WvsvwT22ZCFX2IY1alg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,291,1751266800"; 
   d="scan'208";a="176701831"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa007.fm.intel.com with ESMTP; 24 Sep 2025 10:52:38 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
	aleksander.lobakin@intel.com,
	michal.kubiak@intel.com,
	maciej.fijalkowski@intel.com,
	magnus.karlsson@intel.com,
	przemyslaw.kitszel@intel.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	horms@kernel.org,
	sdf@fomichev.me,
	nxne.cnse.osdt.itp.upstreaming@intel.com,
	bpf@vger.kernel.org
Subject: [PATCH net-next 0/5][pull request] idpf: add XSk support
Date: Wed, 24 Sep 2025 10:52:23 -0700
Message-ID: <20250924175230.1290529-1-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Alexander Lobakin says:

Add support for XSk xmit and receive using libeth_xdp.

This includes adding interfaces to reconfigure/enable/disable only
a particular set of queues and support for checksum offload XSk Tx
metadata.
libeth_xdp's implementation mostly matches the one of ice: batched
allocations and sending, unrolled descriptor writes etc. But unlike
other Intel drivers, XSk wakeup is implemented using CSD/IPI instead
of HW "software interrupt". In lots of different tests, this yielded
way better perf than SW interrupts, but also, this gives better
control over which CPU will handle the NAPI loop (SW interrupts are
a subject to irqbalance and stuff, while CSDs are strictly pinned
1:1 to the core of the same index).
Note that the header split is always disabled for XSk queues, as
for now we see no reasons to have it there.

XSk xmit perf is up to 3x comparing to ice. XSk XDP_PASS is also
faster a bunch as it uses system percpu page_pools, so that the
only overhead left is memcpy(). The rest is at least comparable.
---
IWL: https://lore.kernel.org/intel-wired-lan/20250911162233.1238034-1-aleksander.lobakin@intel.com/

The following are changes since commit dc1dea796b197aba2c3cae25bfef45f4b3ad46fe:
  tcp: Remove stale locking comment for TFO.
and are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue 200GbE

Alexander Lobakin (3):
  idpf: implement XSk xmit
  idpf: implement Rx path for AF_XDP
  idpf: enable XSk features and ndo_xsk_wakeup

Michal Kubiak (2):
  idpf: add virtchnl functions to manage selected queues
  idpf: add XSk pool initialization

 drivers/net/ethernet/intel/idpf/Makefile      |    1 +
 drivers/net/ethernet/intel/idpf/idpf.h        |    7 +
 .../net/ethernet/intel/idpf/idpf_ethtool.c    |    8 +-
 drivers/net/ethernet/intel/idpf/idpf_lib.c    |   10 +-
 drivers/net/ethernet/intel/idpf/idpf_txrx.c   |  451 ++++++-
 drivers/net/ethernet/intel/idpf/idpf_txrx.h   |   72 +-
 .../net/ethernet/intel/idpf/idpf_virtchnl.c   | 1160 +++++++++++------
 .../net/ethernet/intel/idpf/idpf_virtchnl.h   |   32 +-
 drivers/net/ethernet/intel/idpf/xdp.c         |   44 +-
 drivers/net/ethernet/intel/idpf/xdp.h         |    3 +
 drivers/net/ethernet/intel/idpf/xsk.c         |  633 +++++++++
 drivers/net/ethernet/intel/idpf/xsk.h         |   33 +
 12 files changed, 1977 insertions(+), 477 deletions(-)
 create mode 100644 drivers/net/ethernet/intel/idpf/xsk.c
 create mode 100644 drivers/net/ethernet/intel/idpf/xsk.h

-- 
2.47.1


