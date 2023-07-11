Return-Path: <bpf+bounces-4752-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 771A674EC35
	for <lists+bpf@lfdr.de>; Tue, 11 Jul 2023 13:04:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A75201C20DBD
	for <lists+bpf@lfdr.de>; Tue, 11 Jul 2023 11:04:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69B2718AF2;
	Tue, 11 Jul 2023 11:03:54 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F82A18AE0;
	Tue, 11 Jul 2023 11:03:53 +0000 (UTC)
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D43B89B;
	Tue, 11 Jul 2023 04:03:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689073432; x=1720609432;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=2z8vFLqHk500DH3zjJmCwfv18DCdlP/1TrxcY47vKvs=;
  b=Nije7ER/otFlzaaKJOjnJvYryAad7hFs2XHYJ0g7SovKk/bgdpagpgrI
   npex7XmMwuO7DSJQUaNHKEkVboklydIykaB62hQeENKVkNNd/Mw0yCZDt
   DYOmpKSPhBvenKvT/78cAf+82967q9UELn4s9eQQqBprGkrD8yOfqCsOh
   xnE9Bi3z0YXc02K6Wd0D0bhKliqWb1lIqiVUG56+xmroEBx3iQ8AlYu4P
   KHwDoNdlgKhlv+OY+RuPlqZTLpW8pDylw1Z2deO0+z1dvaFb22sBefhkS
   qwhKUC1jTYRLCVndq0u+YY0n4xB6ITNc5fT6IVlBkrNQwpvJ9meto7lyw
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10767"; a="368088771"
X-IronPort-AV: E=Sophos;i="6.01,196,1684825200"; 
   d="scan'208";a="368088771"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2023 04:03:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10767"; a="715144199"
X-IronPort-AV: E=Sophos;i="6.01,196,1684825200"; 
   d="scan'208";a="715144199"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by orsmga007.jf.intel.com with ESMTP; 11 Jul 2023 04:03:48 -0700
Received: from lincoln.igk.intel.com (lincoln.igk.intel.com [10.102.21.235])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id CA4BA3491D;
	Tue, 11 Jul 2023 12:03:46 +0100 (IST)
From: Larysa Zaremba <larysa.zaremba@intel.com>
To: bpf@vger.kernel.org,
	Stanislav Fomichev <sdf@google.com>
Cc: Larysa Zaremba <larysa.zaremba@intel.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf] xdp: use trusted arguments in XDP hints kfuncs
Date: Tue, 11 Jul 2023 12:59:26 +0200
Message-ID: <20230711105930.29170-1-larysa.zaremba@intel.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Currently, verifier does not reject XDP programs that pass NULL pointer to
hints functions. At the same time, this case is not handled in any driver
implementation (including veth). For example, changing

bpf_xdp_metadata_rx_timestamp(ctx, &timestamp);

to

bpf_xdp_metadata_rx_timestamp(ctx, NULL);

in xdp_metadata test successfully crashes the system.

Add KF_TRUSTED_ARGS flag to hints kfunc definitions, so driver code
does not have to worry about getting invalid pointers.

Fixes: 3d76a4d3d4e5 ("bpf: XDP metadata RX kfuncs")
Reported-by: Stanislav Fomichev <sdf@google.com>
Closes: https://lore.kernel.org/bpf/ZKWo0BbpLfkZHbyE@google.com/
Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
---
 net/core/xdp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/core/xdp.c b/net/core/xdp.c
index 41e5ca8643ec..8362130bf085 100644
--- a/net/core/xdp.c
+++ b/net/core/xdp.c
@@ -741,7 +741,7 @@ __bpf_kfunc int bpf_xdp_metadata_rx_hash(const struct xdp_md *ctx, u32 *hash,
 __diag_pop();
 
 BTF_SET8_START(xdp_metadata_kfunc_ids)
-#define XDP_METADATA_KFUNC(_, name) BTF_ID_FLAGS(func, name, 0)
+#define XDP_METADATA_KFUNC(_, name) BTF_ID_FLAGS(func, name, KF_TRUSTED_ARGS)
 XDP_METADATA_KFUNC_xxx
 #undef XDP_METADATA_KFUNC
 BTF_SET8_END(xdp_metadata_kfunc_ids)
-- 
2.41.0


