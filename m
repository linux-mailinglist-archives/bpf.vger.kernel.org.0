Return-Path: <bpf+bounces-2697-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 844DC732796
	for <lists+bpf@lfdr.de>; Fri, 16 Jun 2023 08:29:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3FB772815FD
	for <lists+bpf@lfdr.de>; Fri, 16 Jun 2023 06:29:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F0575661;
	Fri, 16 Jun 2023 06:28:56 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E1DE2105;
	Fri, 16 Jun 2023 06:28:55 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE1F3421C;
	Thu, 15 Jun 2023 23:28:37 -0700 (PDT)
Received: from canpemm500007.china.huawei.com (unknown [172.30.72.57])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Qj8HP4czyzqTRC;
	Fri, 16 Jun 2023 14:23:29 +0800 (CST)
Received: from localhost (10.174.179.215) by canpemm500007.china.huawei.com
 (7.192.104.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Fri, 16 Jun
 2023 14:28:29 +0800
From: YueHaibing <yuehaibing@huawei.com>
To: <bjorn@kernel.org>, <magnus.karlsson@intel.com>,
	<maciej.fijalkowski@intel.com>, <jonathan.lemon@gmail.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <ast@kernel.org>, <daniel@iogearbox.net>,
	<hawk@kernel.org>, <john.fastabend@gmail.com>
CC: <netdev@vger.kernel.org>, <bpf@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <maxtram95@gmail.com>,
	<simon.horman@corigine.com>, YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH v2 bpf-next] xsk: Remove unused inline function xsk_buff_discard()
Date: Fri, 16 Jun 2023 14:28:00 +0800
Message-ID: <20230616062800.30780-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.174.179.215]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 canpemm500007.china.huawei.com (7.192.104.62)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

commit f2f167583601 ("xsk: Remove unused xsk_buff_discard")
left behind this, remove it.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Acked-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
---
v2: resend to bpf-next tree
---
 include/net/xdp_sock_drv.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/include/net/xdp_sock_drv.h b/include/net/xdp_sock_drv.h
index 9c0d860609ba..c243f906ebed 100644
--- a/include/net/xdp_sock_drv.h
+++ b/include/net/xdp_sock_drv.h
@@ -255,10 +255,6 @@ static inline void xsk_buff_free(struct xdp_buff *xdp)
 {
 }
 
-static inline void xsk_buff_discard(struct xdp_buff *xdp)
-{
-}
-
 static inline void xsk_buff_set_size(struct xdp_buff *xdp, u32 size)
 {
 }
-- 
2.34.1


