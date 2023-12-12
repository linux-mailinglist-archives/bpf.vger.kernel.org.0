Return-Path: <bpf+bounces-17518-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD7D080ECA8
	for <lists+bpf@lfdr.de>; Tue, 12 Dec 2023 13:58:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C20D281704
	for <lists+bpf@lfdr.de>; Tue, 12 Dec 2023 12:58:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9F6260EE7;
	Tue, 12 Dec 2023 12:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lsvvZr0E"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B72DEA;
	Tue, 12 Dec 2023 04:58:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702385883; x=1733921883;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=TkoSadS1lmZIZcSuoADu6CiLkg/e9nxH/ErOFUjQY4k=;
  b=lsvvZr0EWGElGcjNdQZlaaYYd+uzCQMJqlwZvP7S79nJM7CD85pdqscE
   nZauGFbuZT9EU1SsnvjS+JKmi2hlMd2Je4/jk/qMTxrD4E82Y7tmSj/4T
   fIcjD9Iku2k4PulQv6KCIKTgRPBJ0i4ZUC3H1HyF3UQfqnM3zM1vBGAM1
   KXgtgKVrCzXMsxiO2VPcCbggWXsW3D2jj4OtU0+C7nd7+qgAVZoxSdjxG
   C0AwT4tQP+HBhlvOGQa6iJiKB8a/J+Ffwuy9DP4QFcgXzgittKsNmjX04
   mOXPaiiNE3NRWQcoEOuXgN0HWhAseLh14a1NIMQJEi8i6Z40+QETV/rqV
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10921"; a="394549035"
X-IronPort-AV: E=Sophos;i="6.04,270,1695711600"; 
   d="scan'208";a="394549035"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2023 04:58:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10921"; a="896912330"
X-IronPort-AV: E=Sophos;i="6.04,270,1695711600"; 
   d="scan'208";a="896912330"
Received: from boxer.igk.intel.com ([10.102.20.173])
  by orsmga004.jf.intel.com with ESMTP; 12 Dec 2023 04:57:59 -0800
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
	lorenzo@kernel.org
Subject: [PATCH v2 bpf 0/3] net: bpf_xdp_adjust_tail() fixes
Date: Tue, 12 Dec 2023 13:57:10 +0100
Message-Id: <20231212125713.336271-1-maciej.fijalkowski@intel.com>
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

v2:
- fix !CONFIG_XDP_SOCKETS builds
- add reviewed-by tag to patch 3

Maciej Fijalkowski (3):
  xsk: recycle buffer in case Rx queue was full
  xsk: fix usage of multi-buffer BPF helpers for ZC XDP
  ice: work on pre-XDP prog frag count

 drivers/net/ethernet/intel/ice/ice_txrx.c     | 14 ++++--
 drivers/net/ethernet/intel/ice/ice_txrx.h     |  1 +
 drivers/net/ethernet/intel/ice/ice_txrx_lib.h | 31 ++++++++----
 include/net/xdp_sock_drv.h                    | 26 ++++++++++
 net/core/filter.c                             | 48 +++++++++++++++----
 net/xdp/xsk.c                                 | 12 +++--
 6 files changed, 105 insertions(+), 27 deletions(-)

-- 
2.34.1


