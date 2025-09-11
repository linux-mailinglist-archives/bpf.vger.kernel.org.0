Return-Path: <bpf+bounces-68156-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE890B5391C
	for <lists+bpf@lfdr.de>; Thu, 11 Sep 2025 18:25:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 041F3AC044C
	for <lists+bpf@lfdr.de>; Thu, 11 Sep 2025 16:24:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD28335AAC3;
	Thu, 11 Sep 2025 16:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Qrkp3D2l"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4761D35AAA1;
	Thu, 11 Sep 2025 16:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757607802; cv=none; b=nY1yQsnYVDVMQL0IGz+WeLxNK4ydnO1moG/+fNdH4o/gDn9TnVEZMH+B14+/KxvmtlSq6rMygvoyEebiwLo7/NQ1F8heOI9zOtUZHK5Iz1m1XMWRqyM3xm9BItdSbOSlNt1foVGgut1jkwNbB5eB+V1YMKztoAt7sDGEZyoD0mQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757607802; c=relaxed/simple;
	bh=DYL7IWUsaDbfVJZ2joy03x7CTtObGiVRcUw+SmpLj54=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kmYoll7gCoAad/4YpuspnXEN+Rk6pX0RY+dOnlGe/GMVbsYXxIMyv9HZM2H02IDUAE2T1HT9GzJne5RWaV22SlMwUzv0y32lSIV21Jv1vZpGgm1wXyfcThIqG+j4Hm9rX+4DBGhFgvQ9SiRrAbedMyjFxZxBcAn78Y6NryGFFg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Qrkp3D2l; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757607800; x=1789143800;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=DYL7IWUsaDbfVJZ2joy03x7CTtObGiVRcUw+SmpLj54=;
  b=Qrkp3D2lCP/gVFNuaFDsyiGSF1U07WsLtFd/cAraSuXQf/9ArB3BqlS8
   89RsDfGLGesXujdDxTO+wLlJkTeJnEaxG6DBVlMBPVGd3gsRkHCnNn5F4
   75MuzQ5k0V6/OISe2K5VPfZxqCBm2hZDRwyM6rhJUi9NyMI+00IuD0Mtk
   +DjDMct3QUh2ORWV0kLK60MEgWI1sbsKkCG8YP5/vbgKnW7NnQBZroN3Y
   6Q9PTtcGGSt8qJ3DkzARp1nSgVMVyr4gQYUNYeyQyPQcIRLJF6CkFN9pM
   t6YXD1EPtP6B3tbkxLHsjyAW7vFbK99Brk5aEPJANm2LjLSGcc2YzhCBc
   Q==;
X-CSE-ConnectionGUID: YeBSWbJkR3K1MXS+WwNZSA==
X-CSE-MsgGUID: QkH8XAPrQAOVUHEkyqfj4w==
X-IronPort-AV: E=McAfee;i="6800,10657,11549"; a="70635155"
X-IronPort-AV: E=Sophos;i="6.18,257,1751266800"; 
   d="scan'208";a="70635155"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2025 09:23:19 -0700
X-CSE-ConnectionGUID: x5zKOf7hSfabZCo0ADEN1w==
X-CSE-MsgGUID: zLbzXO2QS7+fmXCgos7fOQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,257,1751266800"; 
   d="scan'208";a="173284615"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by orviesa009.jf.intel.com with ESMTP; 11 Sep 2025 09:23:14 -0700
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
Subject: [PATCH iwl-next 0/5] idpf: add XSk support
Date: Thu, 11 Sep 2025 18:22:28 +0200
Message-ID: <20250911162233.1238034-1-aleksander.lobakin@intel.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
only overlead left is memcpy(). The rest is at least comparable.

Alexander Lobakin (3):
  idpf: implement XSk xmit
  idpf: implement Rx path for AF_XDP
  idpf: enable XSk features and ndo_xsk_wakeup

Michal Kubiak (2):
  idpf: add virtchnl functions to manage selected queues
  idpf: add XSk pool initialization

 drivers/net/ethernet/intel/idpf/Makefile      |    1 +
 drivers/net/ethernet/intel/idpf/idpf.h        |    7 +
 drivers/net/ethernet/intel/idpf/idpf_txrx.h   |   72 +-
 .../net/ethernet/intel/idpf/idpf_virtchnl.h   |   32 +-
 drivers/net/ethernet/intel/idpf/xdp.h         |    3 +
 drivers/net/ethernet/intel/idpf/xsk.h         |   33 +
 .../net/ethernet/intel/idpf/idpf_ethtool.c    |    8 +-
 drivers/net/ethernet/intel/idpf/idpf_lib.c    |   10 +-
 drivers/net/ethernet/intel/idpf/idpf_txrx.c   |  451 ++++++-
 .../net/ethernet/intel/idpf/idpf_virtchnl.c   | 1160 +++++++++++------
 drivers/net/ethernet/intel/idpf/xdp.c         |   44 +-
 drivers/net/ethernet/intel/idpf/xsk.c         |  633 +++++++++
 12 files changed, 1977 insertions(+), 477 deletions(-)
 create mode 100644 drivers/net/ethernet/intel/idpf/xsk.h
 create mode 100644 drivers/net/ethernet/intel/idpf/xsk.c

---
Apply to either net-next or next-queue, but *before* Pavan's series.

Testing hints:

For testing XSk, you can use basic xdpsock from [0]. There are 3 modes:
`rxdrop` will check XSk Rx, `txonly` -- XSk xmit, `l2fwd` takes care of
both. You can run several instances on different queues.
To get the best perf, make sure xdpsock isn't run on the same CPU which
is responsible for the corresponding NIC queue handling (official XSk
documentation).

[0] https://github.com/xdp-project/bpf-examples/tree/main/AF_XDP-example
-- 
2.51.0


