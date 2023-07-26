Return-Path: <bpf+bounces-5965-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 93E3D7638D4
	for <lists+bpf@lfdr.de>; Wed, 26 Jul 2023 16:16:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E754281B8F
	for <lists+bpf@lfdr.de>; Wed, 26 Jul 2023 14:16:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2355253C3;
	Wed, 26 Jul 2023 14:16:07 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7507B253B5;
	Wed, 26 Jul 2023 14:16:07 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2E4F4222;
	Wed, 26 Jul 2023 07:15:51 -0700 (PDT)
Received: from canpemm500010.china.huawei.com (unknown [172.30.72.56])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4R9wqX13Z2zTlkL;
	Wed, 26 Jul 2023 22:13:44 +0800 (CST)
Received: from huawei.com (10.175.101.6) by canpemm500010.china.huawei.com
 (7.192.105.118) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 26 Jul
 2023 22:15:17 +0800
From: Liu Jian <liujian56@huawei.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <john.fastabend@gmail.com>, <jakub@cloudflare.com>,
	<dsahern@kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
	<netdev@vger.kernel.org>, <bpf@vger.kernel.org>
CC: <liujian56@huawei.com>
Subject: [PATCH bpf 1/2] net: introduce __sk_rmem_schedule() helper
Date: Wed, 26 Jul 2023 22:20:28 +0800
Message-ID: <20230726142029.2867663-2-liujian56@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230726142029.2867663-1-liujian56@huawei.com>
References: <20230726142029.2867663-1-liujian56@huawei.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.175.101.6]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 canpemm500010.china.huawei.com (7.192.105.118)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Compared with sk_wmem_schedule(), sk_rmem_schedule() not only performs
rmem accounting, but also checks skb_pfmemalloc. The __sk_rmem_schedule()
helper function is introduced here to perform only rmem accounting related
activities.

Signed-off-by: Liu Jian <liujian56@huawei.com>
---
 include/net/sock.h | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/include/net/sock.h b/include/net/sock.h
index 2eb916d1ff64..58bf26c5c041 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -1617,16 +1617,20 @@ static inline bool sk_wmem_schedule(struct sock *sk, int size)
 	return delta <= 0 || __sk_mem_schedule(sk, delta, SK_MEM_SEND);
 }
 
-static inline bool
-sk_rmem_schedule(struct sock *sk, struct sk_buff *skb, int size)
+static inline bool __sk_rmem_schedule(struct sock *sk, int size)
 {
 	int delta;
 
 	if (!sk_has_account(sk))
 		return true;
 	delta = size - sk->sk_forward_alloc;
-	return delta <= 0 || __sk_mem_schedule(sk, delta, SK_MEM_RECV) ||
-		skb_pfmemalloc(skb);
+	return delta <= 0 || __sk_mem_schedule(sk, delta, SK_MEM_RECV);
+}
+
+static inline bool
+sk_rmem_schedule(struct sock *sk, struct sk_buff *skb, int size)
+{
+	return __sk_rmem_schedule(sk, size) || skb_pfmemalloc(skb);
 }
 
 static inline int sk_unused_reserved_mem(const struct sock *sk)
-- 
2.34.1


