Return-Path: <bpf+bounces-17177-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 407B580A231
	for <lists+bpf@lfdr.de>; Fri,  8 Dec 2023 12:30:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EDC7E281776
	for <lists+bpf@lfdr.de>; Fri,  8 Dec 2023 11:30:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFDD51B28C;
	Fri,  8 Dec 2023 11:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kF4c5kya"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E01E610FC;
	Fri,  8 Dec 2023 03:30:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702035008; x=1733571008;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=tYqEvHtn0Q0d543Mf2cILh/GdfDdFM2i6Skt++1S+qw=;
  b=kF4c5kyaCVpa6Oe0ZQNnAvxTtyv9ATQQtoMBDh87S9s9bmvRBxuv1oM0
   8eb92BWhNABgeKnIvz7PxD8TADLIsxmAGsF1gpcLVjWiH6pXary+bhlf1
   LSKPLPJ9dxIR71RtKaY4CUYqiPxB99NYQA7AzoISeciJ+5nSd+WcpwHr0
   DkTLZqIJ4zPzIGKiOiNlPML5MnWEIoRxcGmZyaJf150BzoDE+GNTb/84P
   kW2WV9/v4kyujgmK9LwnnnlSXrnspgrqqXEbvqUlaZ7JaMcC9Srb/5XoM
   04eXGL8GB1teJbsCH28rJmCoqJW8QLllZ8eI8LVTSa7fJT+GfDJmjH6bC
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10917"; a="458705885"
X-IronPort-AV: E=Sophos;i="6.04,260,1695711600"; 
   d="scan'208";a="458705885"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2023 03:30:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10917"; a="862828124"
X-IronPort-AV: E=Sophos;i="6.04,260,1695711600"; 
   d="scan'208";a="862828124"
Received: from boxer.igk.intel.com ([10.102.20.173])
  by FMSMGA003.fm.intel.com with ESMTP; 08 Dec 2023 03:30:05 -0800
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
Subject: [PATCH bpf 0/3] net: bpf_xdp_adjust_tail() fixes
Date: Fri,  8 Dec 2023 12:29:42 +0100
Message-Id: <20231208112945.313687-1-maciej.fijalkowski@intel.com>
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

Maciej Fijalkowski (3):
  xsk: recycle buffer in case Rx queue was full
  xsk: fix usage of multi-buffer BPF helpers for ZC XDP
  ice: work on pre-XDP prog frag count

 drivers/net/ethernet/intel/ice/ice_txrx.c     | 14 ++++---
 drivers/net/ethernet/intel/ice/ice_txrx.h     |  1 +
 drivers/net/ethernet/intel/ice/ice_txrx_lib.h | 31 ++++++++++----
 include/net/xdp_sock_drv.h                    | 17 ++++++++
 net/core/filter.c                             | 41 +++++++++++++++----
 net/xdp/xsk.c                                 | 12 ++++--
 6 files changed, 89 insertions(+), 27 deletions(-)

-- 
2.34.1


