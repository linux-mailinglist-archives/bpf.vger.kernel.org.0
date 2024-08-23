Return-Path: <bpf+bounces-37929-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CBA1A95C9E9
	for <lists+bpf@lfdr.de>; Fri, 23 Aug 2024 12:08:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A9261C21173
	for <lists+bpf@lfdr.de>; Fri, 23 Aug 2024 10:08:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C61416EB79;
	Fri, 23 Aug 2024 10:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Pr58wDUk"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E49B714B084;
	Fri, 23 Aug 2024 10:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724407680; cv=none; b=ezPsrfJrlNtV+0fSY+/i76lBT9xoqL6i7qZKH6R4ChV9ipBgpTrAbwc5pRp4FS1LDOPznMn0UwwAojfCV9iiWsEKGvXP0EJOjbRbVmFugn94daDSAXaSycsh7QhyswrecYDxOkjKI6KfqEWx/k75gZzQdx3nB8goB6NzipZMX0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724407680; c=relaxed/simple;
	bh=WuIZRInqS7NanstfrvWuds+EIAZ+q+AIuTPIbKp/L7I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lh5Px4ftFvHuU0B3VzKHi89PME/+SVhxYBXDVvlR1sekHLOF6fsmd5dnmr+R0pNAkozG/dkMeNzmhcHvVxLTXiqmx0Yswd+KrG5HMpseNZnFp8IIcJnlHkBYB1jn4FxcOOQ5MzJFBuV4N1Y9nttRY5XVVA6eb7dZbOKFKeEzBvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Pr58wDUk; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724407679; x=1755943679;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=WuIZRInqS7NanstfrvWuds+EIAZ+q+AIuTPIbKp/L7I=;
  b=Pr58wDUkXerfeTmhAeij7DI7ci1EyXNuvhjQni0cMLYNNdq+5+x/LE2N
   DOLruzRdPaLS+QzcPbJvnULfTQro8vMKu/Us4wl3cOKt6AJtfsoqWQaB0
   pqNnghiBfgpVtfe1p6sbS0s4OwWUHxbQ7br0dsC1DpzlotcI83o9rOPcJ
   eEIvZFawtp6yAAtaMz/n6TuWooubaPhPq1OfER7JE+wR70Q1JHsu6xx/w
   oft5L3/ARIPv9aeuHkXDVI6BQaQu6Vfc2Mm+YSRjrVgPmlRGrGYbdlddO
   O8ry4Z0CumktZvo00M+TTtarUJmGD16UvMBcYRIkKt01V6oB+/WJjmL8/
   w==;
X-CSE-ConnectionGUID: 5RHUGw7SS0GA5rRe0TL2ig==
X-CSE-MsgGUID: 0pOzmaERSweVuA0oKaWVZg==
X-IronPort-AV: E=McAfee;i="6700,10204,11172"; a="34284984"
X-IronPort-AV: E=Sophos;i="6.10,170,1719903600"; 
   d="scan'208";a="34284984"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2024 03:07:57 -0700
X-CSE-ConnectionGUID: hjSUTHu/RPi/mr1my+HMwg==
X-CSE-MsgGUID: ziZzWOGcSTCS9B0lXqleqQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,170,1719903600"; 
   d="scan'208";a="62478929"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by orviesa008.jf.intel.com with ESMTP; 23 Aug 2024 03:07:53 -0700
Received: from lincoln.igk.intel.com (lincoln.igk.intel.com [10.102.21.235])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id B358F33BD5;
	Fri, 23 Aug 2024 11:07:50 +0100 (IST)
From: Larysa Zaremba <larysa.zaremba@intel.com>
To: intel-wired-lan@lists.osuosl.org,
	Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: Larysa Zaremba <larysa.zaremba@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jacob Keller <jacob.e.keller@intel.com>,
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
	Michal Kubiak <michal.kubiak@intel.com>,
	Wojciech Drewek <wojciech.drewek@intel.com>,
	Amritha Nambiar <amritha.nambiar@intel.com>,
	przemyslaw.kitszel@intel.com,
	anirudh.venkataramanan@intel.com,
	sridhar.samudrala@intel.com
Subject: [PATCH iwl-net v4 0/6] ice: fix synchronization between .ndo_bpf() and reset
Date: Fri, 23 Aug 2024 11:59:25 +0200
Message-ID: <20240823095933.17922-1-larysa.zaremba@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

PF reset can be triggered asynchronously, by tx_timeout or by a user. With some
unfortunate timings both ice_vsi_rebuild() and .ndo_bpf will try to access and
modify XDP rings at the same time, causing system crash.

The first patch factors out rtnl-locked code from VSI rebuild code to avoid
deadlock. The following changes lock rebuild and .ndo_bpf() critical sections
with an internal mutex as well and provide complementary fixes.

v3: https://lore.kernel.org/netdev/20240819100606.15383-1-larysa.zaremba@intel.com/
v3->v4:
* fix kdoc and add an additional "Fixes:" tag in the first patch
* clear rebuild pending flag only when ice_vsi_rebuild completes successfully
* remove the deadlock part from the commit message in the fifth patch,
  this particular aspect was recently fixed in another patch
* update tags

v2: https://lore.kernel.org/netdev/20240724164840.2536605-1-larysa.zaremba@intel.com/
v2->v3:
* deconfig VSI when coalesce allocation fails in ice_vsi_rebuild (patch 2/6)
* rebase and resolve conflicts in patch 3 and 4
* add tags from v2

v1: https://lore.kernel.org/netdev/20240610153716.31493-1-larysa.zaremba@intel.com/
v1->v2:
* use mutex for locking
* redefine critical sections
* account for short time between rebuild and VSI being open
* add netif_queue_set_napi() patch, so ICE_RTNL_WAITS_FOR_RESET strategy can be
  dropped, no more rtnl-locked code in ice_vsi_rebuild()
* change the test case from waiting for tx_timeout to happen to actively firing
  resets through sysfs, this adds more minor fixes on top

Larysa Zaremba (6):
  ice: move netif_queue_set_napi to rtnl-protected sections
  ice: protect XDP configuration with a mutex
  ice: check for XDP rings instead of bpf program when unconfiguring
  ice: check ICE_VSI_DOWN under rtnl_lock when preparing for reset
  ice: remove ICE_CFG_BUSY locking from AF_XDP code
  ice: do not bring the VSI up, if it was down before the XDP setup

 drivers/net/ethernet/intel/ice/ice.h      |   2 +
 drivers/net/ethernet/intel/ice/ice_base.c |  11 +-
 drivers/net/ethernet/intel/ice/ice_lib.c  | 179 ++++++++--------------
 drivers/net/ethernet/intel/ice/ice_lib.h  |  10 +-
 drivers/net/ethernet/intel/ice/ice_main.c |  47 ++++--
 drivers/net/ethernet/intel/ice/ice_xsk.c  |  18 +--
 6 files changed, 106 insertions(+), 161 deletions(-)

-- 
2.43.0


