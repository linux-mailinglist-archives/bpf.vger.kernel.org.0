Return-Path: <bpf+bounces-6552-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 31AAB76B608
	for <lists+bpf@lfdr.de>; Tue,  1 Aug 2023 15:39:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 624CF1C20749
	for <lists+bpf@lfdr.de>; Tue,  1 Aug 2023 13:39:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C96F22EEE;
	Tue,  1 Aug 2023 13:39:34 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA2631E503;
	Tue,  1 Aug 2023 13:39:33 +0000 (UTC)
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FA891BF9;
	Tue,  1 Aug 2023 06:39:31 -0700 (PDT)
Received: from canpemm500007.china.huawei.com (unknown [172.30.72.56])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4RFbk75R4TzLnw3;
	Tue,  1 Aug 2023 21:36:47 +0800 (CST)
Received: from localhost (10.174.179.215) by canpemm500007.china.huawei.com
 (7.192.104.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 1 Aug
 2023 21:39:29 +0800
From: Yue Haibing <yuehaibing@huawei.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <bpf@vger.kernel.org>, Yue Haibing
	<yuehaibing@huawei.com>
Subject: [PATCH net-next] udp: Remove unused function declaration udp_bpf_get_proto()
Date: Tue, 1 Aug 2023 21:39:02 +0800
Message-ID: <20230801133902.3660-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.174.179.215]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 canpemm500007.china.huawei.com (7.192.104.62)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
	RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

commit 8a59f9d1e3d4 ("sock: Introduce sk->sk_prot->psock_update_sk_prot()")
left behind this.

Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
---
 include/net/udp.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/net/udp.h b/include/net/udp.h
index 4d13424f8f72..5a8421cd9083 100644
--- a/include/net/udp.h
+++ b/include/net/udp.h
@@ -529,7 +529,6 @@ static inline void udp_post_segment_fix_csum(struct sk_buff *skb)
 
 #ifdef CONFIG_BPF_SYSCALL
 struct sk_psock;
-struct proto *udp_bpf_get_proto(struct sock *sk, struct sk_psock *psock);
 int udp_bpf_update_proto(struct sock *sk, struct sk_psock *psock, bool restore);
 #endif
 
-- 
2.34.1


