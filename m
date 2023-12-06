Return-Path: <bpf+bounces-16927-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A108A8079EF
	for <lists+bpf@lfdr.de>; Wed,  6 Dec 2023 22:01:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8296E1C21199
	for <lists+bpf@lfdr.de>; Wed,  6 Dec 2023 21:01:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56FD06DCFB;
	Wed,  6 Dec 2023 21:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hCVVu+kJ"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9227D5B;
	Wed,  6 Dec 2023 13:01:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701896461; x=1733432461;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jRJExu1kINjylZ5RqABycvnvPx8c1x03hFJra8lgzQA=;
  b=hCVVu+kJnekulgyGv1AaeY70HBI+I47OLW+BR4WZ4jVWuexiETFN2GWy
   TknUr3llsJg53N7XOMBFBVQH9g6WnRsYjhvUcbebzgYwg6slBQ42UuqXW
   TxNU+AO4D6vVkmMfCObcMJRtC8UyYBjGSEhsCfY9AgZuKdieBgZ7gqpMl
   dyIdl9ty1KOCnwyW+Y1XIBmICl4WJMdzgRYG2Lxi08CaPmHI3v+QDWLKT
   UQGyky15vaYdwkkVV3P0ySRhx3Jh2pn5OIHk53/sjTzJZrSDs/HUrvL32
   1iTekgVVT4InWE3wTdVxDLMfAefr+AcZzC7cJAJ8aW2hZ7ef809LGxGv3
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10916"; a="425278175"
X-IronPort-AV: E=Sophos;i="6.04,256,1695711600"; 
   d="scan'208";a="425278175"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2023 13:01:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10916"; a="837448537"
X-IronPort-AV: E=Sophos;i="6.04,256,1695711600"; 
   d="scan'208";a="837448537"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by fmsmga008.fm.intel.com with ESMTP; 06 Dec 2023 13:00:57 -0800
Received: from lincoln.igk.intel.com (lincoln.igk.intel.com [10.102.21.235])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 864EC33BDF;
	Wed,  6 Dec 2023 21:00:55 +0000 (GMT)
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
Subject: [PATCH bpf-next v4 1/2] selftests/bpf: increase invalid metadata size
Date: Wed,  6 Dec 2023 21:59:18 +0100
Message-ID: <20231206205919.404415-2-larysa.zaremba@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231206205919.404415-1-larysa.zaremba@intel.com>
References: <20231206205919.404415-1-larysa.zaremba@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changed check expects passed data meta to be deemed invalid.
After loosening the requirement, the size of 36 bytes becomes valid.
Therefore, increase tested meta size to 256, so we do not get an unexpected
success.

Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
---
 tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c b/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
index ab4952b9fb1d..e6a783c7f5db 100644
--- a/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
+++ b/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
@@ -77,8 +77,8 @@ void test_xdp_context_test_run(void)
 	test_xdp_context_error(prog_fd, opts, 4, sizeof(__u32), sizeof(data),
 			       0, 0, 0);
 
-	/* Meta data must be 32 bytes or smaller */
-	test_xdp_context_error(prog_fd, opts, 0, 36, sizeof(data), 0, 0, 0);
+	/* Meta data must be 255 bytes or smaller */
+	test_xdp_context_error(prog_fd, opts, 0, 256, sizeof(data), 0, 0, 0);
 
 	/* Total size of data must match data_end - data_meta */
 	test_xdp_context_error(prog_fd, opts, 0, sizeof(__u32),
-- 
2.41.0


