Return-Path: <bpf+bounces-15962-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D4557FA945
	for <lists+bpf@lfdr.de>; Mon, 27 Nov 2023 19:51:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3946B2817D3
	for <lists+bpf@lfdr.de>; Mon, 27 Nov 2023 18:51:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B8D23A8D8;
	Mon, 27 Nov 2023 18:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HBIBKxFM"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 959B81A1;
	Mon, 27 Nov 2023 10:51:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701111102; x=1732647102;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=fFpHfP4ITdLtgR0u/kz6TTamJSgRwMGF34hlG9l1BU0=;
  b=HBIBKxFMLIrqxD3Nm7iwEe8xtkGmiia1YbG3QyskUsyzcMUQZciGYrUT
   fsB0kFkc1fhgv7aYzDza8eFqf4KIMS1/JgdEnqJMaAennCzRkkTo6mtH7
   inarQNKt6esBnjG2pEEb0sMAcRX9/99A91Ae1/pVJyKdBP/0V3xRxsscg
   C8Ot7iKDkimkbZaoCAHy6uAwa81G4ze0OwGr6YaXtTvmcsW3/Pxzeppxq
   FQ7zuOAYtWM8kabMOr2RQk1l6RKgC3M6ZcS7wAtsR7jMtR22znoIITxL0
   ETtcoFJNPNmRAVvholcNhHxj5hzI27KnN+x/C0d3dbWlACbf0NLONQqvg
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10907"; a="389921339"
X-IronPort-AV: E=Sophos;i="6.04,231,1695711600"; 
   d="scan'208";a="389921339"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2023 10:51:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,231,1695711600"; 
   d="scan'208";a="16376300"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by orviesa001.jf.intel.com with ESMTP; 27 Nov 2023 10:51:38 -0800
Received: from lincoln.igk.intel.com (lincoln.igk.intel.com [10.102.21.235])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id B002838D80;
	Mon, 27 Nov 2023 18:33:48 +0000 (GMT)
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
Subject: [PATCH bpf-next v3 0/2] Allow data_meta size > 32
Date: Mon, 27 Nov 2023 19:32:14 +0100
Message-ID: <20231127183216.269958-1-larysa.zaremba@intel.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, there is no reason for data_meta to be limited to 32 bytes.
Loosen this limitation and make maximum meta size 252.

Also, modify the selftest, so test_xdp_context_error does not complain
about the unexpected success.

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


