Return-Path: <bpf+bounces-16926-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C1D3A8079EC
	for <lists+bpf@lfdr.de>; Wed,  6 Dec 2023 22:01:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C13011C21145
	for <lists+bpf@lfdr.de>; Wed,  6 Dec 2023 21:01:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53EFC49F7E;
	Wed,  6 Dec 2023 21:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ahauyE9B"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16CFBD5B;
	Wed,  6 Dec 2023 13:00:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701896456; x=1733432456;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=gf6A/da8Ph5wHaBV8QGdKg/10gFjzFHD4tYQbfo/VI0=;
  b=ahauyE9Bz60beOqkLel9ZKDpiLHEcyARHb2ZQW4753nu/RfyfF1pDNU/
   og+kJ5CU0bXdA5Rj5w6Dw00nu/WjmLoCh/JYM7UDgVAgepSBFqR1Ylud0
   Cw1sfWt2G6+I6WFTQHD4M5ZIX0fM+tU+M4izSksfGAObVmJyl6uTCoLQJ
   Mb4p4BoocSrmIBcPzhMxztgDlLAT9XpkyxbI80fDU5sFWEcWGSN+SdbTm
   w4CkizQ0BAUSgDOgggfpK9ZekhkoygHttCorcMuM7v7sEjzMVADTyNDTC
   IruZO921IopS7WP0Ria+KcfhuSaPxBr3V7C2BEg3eNnMlWzK722teXr+3
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10916"; a="425278149"
X-IronPort-AV: E=Sophos;i="6.04,256,1695711600"; 
   d="scan'208";a="425278149"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2023 13:00:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10916"; a="837448530"
X-IronPort-AV: E=Sophos;i="6.04,256,1695711600"; 
   d="scan'208";a="837448530"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by fmsmga008.fm.intel.com with ESMTP; 06 Dec 2023 13:00:52 -0800
Received: from lincoln.igk.intel.com (lincoln.igk.intel.com [10.102.21.235])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id AD25E32A17;
	Wed,  6 Dec 2023 21:00:50 +0000 (GMT)
From: Larysa Zaremba <larysa.zaremba@intel.com>
To: bpf@vger.kernel.org
Cc: Larysa Zaremba <larysa.zaremba@intel.com>,
	netdev@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Magnus Karlsson <magnus.karlsson@gmail.com>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Yunsheng Lin <linyunsheng@huawei.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Aleksander Lobakin <aleksander.lobakin@intel.com>
Subject: [PATCH bpf-next v4 0/2] Allow data_meta size > 32
Date: Wed,  6 Dec 2023 21:59:17 +0100
Message-ID: <20231206205919.404415-1-larysa.zaremba@intel.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, there is no reason for data_meta to be limited to 32 bytes.
Loosen this limitation and make maximum meta size 252 (max value of u8,
aligned to 4). Details in the second patch.

Also, modify the selftest, so test_xdp_context_error does not complain
about the unexpected success.

v3->v4:
* Explain limit of 252 in cover letter and commit message

v2->v3:
* Fix main patch author
* Add selftests path

v1->v2:
* replace 'typeof(metalen)' with the actual type

Aleksander Lobakin (1):
  net, xdp: allow metadata > 32

Larysa Zaremba (1):
  selftests/bpf: increase invalid metadata size

 include/linux/skbuff.h                              | 13 ++++++++-----
 include/net/xdp.h                                   |  7 ++++++-
 .../selftests/bpf/prog_tests/xdp_context_test_run.c |  4 ++--
 3 files changed, 16 insertions(+), 8 deletions(-)

-- 
2.41.0


