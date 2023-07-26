Return-Path: <bpf+bounces-5966-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E01777638DC
	for <lists+bpf@lfdr.de>; Wed, 26 Jul 2023 16:17:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D8381C21197
	for <lists+bpf@lfdr.de>; Wed, 26 Jul 2023 14:17:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91C5F253DC;
	Wed, 26 Jul 2023 14:16:10 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F3C4253A9;
	Wed, 26 Jul 2023 14:16:10 +0000 (UTC)
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43B6B4231;
	Wed, 26 Jul 2023 07:15:53 -0700 (PDT)
Received: from canpemm500010.china.huawei.com (unknown [172.30.72.53])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4R9wrK72Vhz1GDF3;
	Wed, 26 Jul 2023 22:14:25 +0800 (CST)
Received: from huawei.com (10.175.101.6) by canpemm500010.china.huawei.com
 (7.192.105.118) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 26 Jul
 2023 22:15:18 +0800
From: Liu Jian <liujian56@huawei.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <john.fastabend@gmail.com>, <jakub@cloudflare.com>,
	<dsahern@kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
	<netdev@vger.kernel.org>, <bpf@vger.kernel.org>
CC: <liujian56@huawei.com>
Subject: [PATCH bpf 2/2] bpf, sockmap: fix rmem incorrect accounting in bpf_tcp_ingress()
Date: Wed, 26 Jul 2023 22:20:29 +0800
Message-ID: <20230726142029.2867663-3-liujian56@huawei.com>
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
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

In the bpf_tcp_ingress function, the operation on parameter @sk is in the
recv direction. We should use __sk_rmem_schedule to calculate accounting.

Fixes: 604326b41a6f ("bpf, sockmap: convert to generic sk_msg interface")
Signed-off-by: Liu Jian <liujian56@huawei.com>
---
 net/ipv4/tcp_bpf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv4/tcp_bpf.c b/net/ipv4/tcp_bpf.c
index 81f0dff69e0b..6eb9b320eecc 100644
--- a/net/ipv4/tcp_bpf.c
+++ b/net/ipv4/tcp_bpf.c
@@ -49,7 +49,7 @@ static int bpf_tcp_ingress(struct sock *sk, struct sk_psock *psock,
 		sge = sk_msg_elem(msg, i);
 		size = (apply && apply_bytes < sge->length) ?
 			apply_bytes : sge->length;
-		if (!sk_wmem_schedule(sk, size)) {
+		if (!__sk_rmem_schedule(sk, size)) {
 			if (!copied)
 				ret = -ENOMEM;
 			break;
-- 
2.34.1


