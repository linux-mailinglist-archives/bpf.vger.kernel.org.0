Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD1CF58D6AF
	for <lists+bpf@lfdr.de>; Tue,  9 Aug 2022 11:45:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235758AbiHIJpw (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 9 Aug 2022 05:45:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232584AbiHIJpw (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 9 Aug 2022 05:45:52 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1F251F636;
        Tue,  9 Aug 2022 02:45:50 -0700 (PDT)
Received: from canpemm500010.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4M27S100S2zmVY4;
        Tue,  9 Aug 2022 17:43:44 +0800 (CST)
Received: from huawei.com (10.175.101.6) by canpemm500010.china.huawei.com
 (7.192.105.118) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 9 Aug
 2022 17:45:47 +0800
From:   Liu Jian <liujian56@huawei.com>
To:     <john.fastabend@gmail.com>, <jakub@cloudflare.com>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <daniel@iogearbox.net>, <andrii@kernel.org>,
        <netdev@vger.kernel.org>, <bpf@vger.kernel.org>
CC:     <liujian56@huawei.com>
Subject: [PATCH bpf-next v2] skmsg: Fix wrong last sg check in sk_msg_recvmsg()
Date:   Tue, 9 Aug 2022 17:49:15 +0800
Message-ID: <20220809094915.150391-1-liujian56@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.101.6]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 canpemm500010.china.huawei.com (7.192.105.118)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Fix one kernel NULL pointer dereference as below:

[  224.462334] Call Trace:
[  224.462394]  __tcp_bpf_recvmsg+0xd3/0x380
[  224.462441]  ? sock_has_perm+0x78/0xa0
[  224.462463]  tcp_bpf_recvmsg+0x12e/0x220
[  224.462494]  inet_recvmsg+0x5b/0xd0
[  224.462534]  __sys_recvfrom+0xc8/0x130
[  224.462574]  ? syscall_trace_enter+0x1df/0x2e0
[  224.462606]  ? __do_page_fault+0x2de/0x500
[  224.462635]  __x64_sys_recvfrom+0x24/0x30
[  224.462660]  do_syscall_64+0x5d/0x1d0
[  224.462709]  entry_SYSCALL_64_after_hwframe+0x65/0xca

In commit 9974d37ea75f ("skmsg: Fix invalid last sg check in
sk_msg_recvmsg()"), we change last sg check to sg_is_last(),
but in sockmap redirection case (without stream_parser/stream_verdict/
skb_verdict), we did not mark the end of the scatterlist. Check the
sk_msg_alloc, sk_msg_page_add, and bpf_msg_push_data functions, they all
do not mark the end of sg. They are expected to use sg.end for end
judgment. So the judgment of '(i != msg_rx->sg.end)' is added back here.

Fixes: 9974d37ea75f ("skmsg: Fix invalid last sg check in sk_msg_recvmsg()")
Signed-off-by: Liu Jian <liujian56@huawei.com>
---
v1->v2: change fix commit info in fixes tag and commit message.
 net/core/skmsg.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/core/skmsg.c b/net/core/skmsg.c
index 81627892bdd4..385ae23580a5 100644
--- a/net/core/skmsg.c
+++ b/net/core/skmsg.c
@@ -462,7 +462,7 @@ int sk_msg_recvmsg(struct sock *sk, struct sk_psock *psock, struct msghdr *msg,
 
 			if (copied == len)
 				break;
-		} while (!sg_is_last(sge));
+		} while ((i != msg_rx->sg.end) && !sg_is_last(sge));
 
 		if (unlikely(peek)) {
 			msg_rx = sk_psock_next_msg(psock, msg_rx);
@@ -472,7 +472,7 @@ int sk_msg_recvmsg(struct sock *sk, struct sk_psock *psock, struct msghdr *msg,
 		}
 
 		msg_rx->sg.start = i;
-		if (!sge->length && sg_is_last(sge)) {
+		if (!sge->length && (i == msg_rx->sg.end || sg_is_last(sge))) {
 			msg_rx = sk_psock_dequeue_msg(psock);
 			kfree_sk_msg(msg_rx);
 		}
-- 
2.17.1

