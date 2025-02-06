Return-Path: <bpf+bounces-50680-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4F84A2B131
	for <lists+bpf@lfdr.de>; Thu,  6 Feb 2025 19:34:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D501C7A3127
	for <lists+bpf@lfdr.de>; Thu,  6 Feb 2025 18:33:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1227919D062;
	Thu,  6 Feb 2025 18:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NYiy6Hrz"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD11518B03;
	Thu,  6 Feb 2025 18:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738866627; cv=none; b=OhlDJQJVRYA8+JC+cqI6ysb0rICF+qiNcmAHJ/QIhd5u0uFB8nGCv3uOZ/3RnXLXHrVVmkdsv+Fo+8ZtqYtjpoQLak7gJkLH+r8njaGw4XSISM3gltk44QgoAIFQqjGRSJ+w+e19QFoh/TehZefBNj1xOUm/hu7RCTahX7vg1Hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738866627; c=relaxed/simple;
	bh=BnYJlH4rr0VHSY3PpIvQ/yYitDxtWFPagarnTGQOlhg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OLcIp49m/XMr8r/JIkg3zy/G9MW6WMq3UeRMpUO9TwN8Z7KJNGoh2eCQrcH+ipnspJNs1U6F6VNPmGFu7VyOnygCP5Cvn5RImDKXD3rKzESZObxyfPk8NwfQnvHgYsRKWSq/4r4yAeRvAqMCcPgoAc1Z+NE9Yn1zKpCGofGCK4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NYiy6Hrz; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738866626; x=1770402626;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=BnYJlH4rr0VHSY3PpIvQ/yYitDxtWFPagarnTGQOlhg=;
  b=NYiy6HrzbTGjiHoqQNRi/BK0AsGlKKursNw20KG5Ax/GKC24wwq9sLIS
   ldlksF+5SA0tUv+wS+F3Xb5wiEQEU6IdjOOG40tqAB2fxQg3tbPSeruTk
   k1ypIuTuLlKjF/VEOqUvy5hnz3/4mWC+lFnCkoCKJChbmk3Be38wmtm8+
   y8dc3DR1vypPvqicFQMkNQK7l0FrtSsPsSjdWeDmiDL0SsseeIvkkwjOQ
   GNeG2T4YQ0rUc4svFkOdX20FEhIbzmETwg/RCFxpOdeuni5ewWrhoyeDD
   X6y3pdyB42bfL3tCy++PnSC77B77Xgm0TEGZmdJ/jmk6zhZyliQhdZoQU
   Q==;
X-CSE-ConnectionGUID: AG7DGk9GSTmATS5uhoIj3A==
X-CSE-MsgGUID: aU24Cst3QzyNjgyQpgAYgA==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="49734400"
X-IronPort-AV: E=Sophos;i="6.13,264,1732608000"; 
   d="scan'208";a="49734400"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2025 10:30:24 -0800
X-CSE-ConnectionGUID: xcGUcqkbS0SgQC+pW8peeg==
X-CSE-MsgGUID: WgcGRZxOROayyX7uKsLYgg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,264,1732608000"; 
   d="scan'208";a="111065865"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by orviesa009.jf.intel.com with ESMTP; 06 Feb 2025 10:30:19 -0800
From: Alexander Lobakin <aleksander.lobakin@intel.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	"Jose E. Marchesi" <jose.marchesi@oracle.com>,
	=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	Magnus Karlsson <magnus.karlsson@intel.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Jason Baron <jbaron@akamai.com>,
	Casey Schaufler <casey@schaufler-ca.com>,
	Nathan Chancellor <nathan@kernel.org>,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 0/4] xsk: the lost bits from Chapter III
Date: Thu,  6 Feb 2025 19:26:25 +0100
Message-ID: <20250206182630.3914318-1-aleksander.lobakin@intel.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Before introducing libeth_xdp, we need to add a couple more generic
helpers. Notably:

* 01: add generic loop unrolling hint helpers;
* 04: add helper to get both xdp_desc's DMA address and metadata
  pointer in one go, saving several cycles and hotpath object
  code size in drivers (especially when unrolling).

Bonus:

* 02, 03: convert two drivers which were using custom macros to
  generic unrolled_count() (trivial, no object code changes).

Alexander Lobakin (4):
  unroll: add generic loop unroll helpers
  i40e: use generic unrolled_count() macro
  ice: use generic unrolled_count() macro
  xsk: add helper to get &xdp_desc's DMA and meta pointer in one go

 drivers/net/ethernet/intel/i40e/i40e_xsk.h | 10 +----
 drivers/net/ethernet/intel/ice/ice_xsk.h   |  8 ----
 include/linux/unroll.h                     | 44 +++++++++++++++++++++
 include/net/xdp_sock_drv.h                 | 43 ++++++++++++++++++--
 include/net/xsk_buff_pool.h                |  8 ++++
 drivers/net/ethernet/intel/i40e/i40e_xsk.c |  4 +-
 drivers/net/ethernet/intel/ice/ice_xsk.c   |  4 +-
 net/xdp/xsk_buff_pool.c                    | 46 ++++++++++++++++++++--
 8 files changed, 141 insertions(+), 26 deletions(-)

---
Note: 04 had reviews already; in this series, I reused the existing
helpers instead of copying them and eliminated the compound
assignment in favor of a field-by-field one, which generates
the same Asm code (requested by Jakub).
-- 
2.48.1


