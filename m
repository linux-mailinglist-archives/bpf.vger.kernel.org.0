Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B36DA633283
	for <lists+bpf@lfdr.de>; Tue, 22 Nov 2022 02:59:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229730AbiKVB7S (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 21 Nov 2022 20:59:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231905AbiKVB7Q (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 21 Nov 2022 20:59:16 -0500
Received: from zg8tmja2lje4os4yms4ymjma.icoremail.net (zg8tmja2lje4os4yms4ymjma.icoremail.net [206.189.21.223])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 4F447C5B4E
        for <bpf@vger.kernel.org>; Mon, 21 Nov 2022 17:59:15 -0800 (PST)
Received: from 102.wangsu.com (unknown [59.61.78.232])
        by app2 (Coremail) with SMTP id SyJltADnLkvOLHxjiGsAAA--.531S5;
        Tue, 22 Nov 2022 09:58:56 +0800 (CST)
From:   Pengcheng Yang <yangpc@wangsu.com>
To:     bpf@vger.kernel.org, netdev@vger.kernel.org,
        John Fastabend <john.fastabend@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jakub Sitnicki <jakub@cloudflare.com>,
        Lorenz Bauer <lmb@cloudflare.com>
Cc:     Pengcheng Yang <yangpc@wangsu.com>
Subject: [PATCH RESEND bpf 3/4] bpf, sockmap: Fix data loss caused by using apply_bytes on ingress redirect
Date:   Tue, 22 Nov 2022 09:58:28 +0800
Message-Id: <1669082309-2546-4-git-send-email-yangpc@wangsu.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1669082309-2546-1-git-send-email-yangpc@wangsu.com>
References: <1669082309-2546-1-git-send-email-yangpc@wangsu.com>
X-CM-TRANSID: SyJltADnLkvOLHxjiGsAAA--.531S5
X-Coremail-Antispam: 1UD129KBjvdXoWrKr4ftw4rGrW8Xr45CryDZFb_yoWfWwbE9r
        W0yF9xGry8WF1IkF4Du3y5tF92grs2vFn3Kr1xJFW7t348AFyUArs5XFn3ZFWkWFW2yFyq
        g34kXr4UZa4aqjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJ3UbIYCTnIWIevJa73UjIFyTuYvj4RJUUUUUUUU
X-CM-SenderInfo: p1dqw1nf6zt0xjvxhudrp/
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,T_SPF_PERMERROR autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Use apply_bytes on ingress redirect, when apply_bytes is less than
the length of msg data, some data may be skipped and lost in
bpf_tcp_ingress().
If there is still data in the scatterlist that has not been consumed,
we cannot move the msg iter.

Fixes: 604326b41a6f ("bpf, sockmap: convert to generic sk_msg interface")
Signed-off-by: Pengcheng Yang <yangpc@wangsu.com>
---
 net/ipv4/tcp_bpf.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/ipv4/tcp_bpf.c b/net/ipv4/tcp_bpf.c
index 1390d72..3cc0346 100644
--- a/net/ipv4/tcp_bpf.c
+++ b/net/ipv4/tcp_bpf.c
@@ -45,8 +45,11 @@ static int bpf_tcp_ingress(struct sock *sk, struct sk_psock *psock,
 		tmp->sg.end = i;
 		if (apply) {
 			apply_bytes -= size;
-			if (!apply_bytes)
+			if (!apply_bytes) {
+				if (sge->length)
+					sk_msg_iter_var_prev(i);
 				break;
+			}
 		}
 	} while (i != msg->sg.end);
 
-- 
1.8.3.1

