Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5942765026D
	for <lists+bpf@lfdr.de>; Sun, 18 Dec 2022 17:47:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231800AbiLRQr0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 18 Dec 2022 11:47:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232628AbiLRQqE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 18 Dec 2022 11:46:04 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D11CEBE07;
        Sun, 18 Dec 2022 08:16:35 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8A21BB80BA4;
        Sun, 18 Dec 2022 16:16:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDAE2C433D2;
        Sun, 18 Dec 2022 16:16:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671380193;
        bh=TGIWEGcz+HMtm3N63XsDOLdNsqymMMoONUGHq3yxGO0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Z9jGCfAuxxPlFIbpBIib8yLyOAOt7JSVC4ZuQKShWk42KTqU918v/pViVDU4JJwph
         lC9kLur6Jg+Qm00bIPDodyEqCSD9hUvrVrtRrNzoQSHf5AMCNweST4/qsBdaIch3eK
         GLfVu2WLk1Jggfm7ks1R3CDazaSq1p2zDUsclMNEPcQyMJzef5TS8TVgf/5hjPYsUD
         gdI4O+9dt0lECvg/WcXYU40DYrXNA7lgDKpwUtKryPQUWA56VZBv0sjSQ6ED2Y2h7x
         f73hEjJiziJCjTGiPMCAAVofSDc5/1xG3HXHNi7xNIaD+vR3bMqfdSWZVm4M8NS3u3
         +MREKyjZNF1kQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Stanislav Fomichev <sdf@google.com>,
        Eric Dumazet <edumazet@google.com>,
        syzbot+f635e86ec3fa0a37e019@syzkaller.appspotmail.com,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Sasha Levin <sashal@kernel.org>, daniel@iogearbox.net,
        andrii@kernel.org, martin.lau@linux.dev, davem@davemloft.net,
        kuba@kernel.org, pabeni@redhat.com, bpf@vger.kernel.org,
        netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 09/39] bpf: make sure skb->len != 0 when redirecting to a tunneling device
Date:   Sun, 18 Dec 2022 11:15:29 -0500
Message-Id: <20221218161559.932604-9-sashal@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221218161559.932604-1-sashal@kernel.org>
References: <20221218161559.932604-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Stanislav Fomichev <sdf@google.com>

[ Upstream commit 07ec7b502800ba9f7b8b15cb01dd6556bb41aaca ]

syzkaller managed to trigger another case where skb->len == 0
when we enter __dev_queue_xmit:

WARNING: CPU: 0 PID: 2470 at include/linux/skbuff.h:2576 skb_assert_len include/linux/skbuff.h:2576 [inline]
WARNING: CPU: 0 PID: 2470 at include/linux/skbuff.h:2576 __dev_queue_xmit+0x2069/0x35e0 net/core/dev.c:4295

Call Trace:
 dev_queue_xmit+0x17/0x20 net/core/dev.c:4406
 __bpf_tx_skb net/core/filter.c:2115 [inline]
 __bpf_redirect_no_mac net/core/filter.c:2140 [inline]
 __bpf_redirect+0x5fb/0xda0 net/core/filter.c:2163
 ____bpf_clone_redirect net/core/filter.c:2447 [inline]
 bpf_clone_redirect+0x247/0x390 net/core/filter.c:2419
 bpf_prog_48159a89cb4a9a16+0x59/0x5e
 bpf_dispatcher_nop_func include/linux/bpf.h:897 [inline]
 __bpf_prog_run include/linux/filter.h:596 [inline]
 bpf_prog_run include/linux/filter.h:603 [inline]
 bpf_test_run+0x46c/0x890 net/bpf/test_run.c:402
 bpf_prog_test_run_skb+0xbdc/0x14c0 net/bpf/test_run.c:1170
 bpf_prog_test_run+0x345/0x3c0 kernel/bpf/syscall.c:3648
 __sys_bpf+0x43a/0x6c0 kernel/bpf/syscall.c:5005
 __do_sys_bpf kernel/bpf/syscall.c:5091 [inline]
 __se_sys_bpf kernel/bpf/syscall.c:5089 [inline]
 __x64_sys_bpf+0x7c/0x90 kernel/bpf/syscall.c:5089
 do_syscall_64+0x54/0x70 arch/x86/entry/common.c:48
 entry_SYSCALL_64_after_hwframe+0x61/0xc6

The reproducer doesn't really reproduce outside of syzkaller
environment, so I'm taking a guess here. It looks like we
do generate correct ETH_HLEN-sized packet, but we redirect
the packet to the tunneling device. Before we do so, we
__skb_pull l2 header and arrive again at skb->len == 0.
Doesn't seem like we can do anything better than having
an explicit check after __skb_pull?

Cc: Eric Dumazet <edumazet@google.com>
Reported-by: syzbot+f635e86ec3fa0a37e019@syzkaller.appspotmail.com
Signed-off-by: Stanislav Fomichev <sdf@google.com>
Link: https://lore.kernel.org/r/20221027225537.353077-1-sdf@google.com
Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/core/filter.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/core/filter.c b/net/core/filter.c
index 4c22e6d1da74..549c5c0f3dee 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -2127,6 +2127,10 @@ static int __bpf_redirect_no_mac(struct sk_buff *skb, struct net_device *dev,
 
 	if (mlen) {
 		__skb_pull(skb, mlen);
+		if (unlikely(!skb->len)) {
+			kfree_skb(skb);
+			return -ERANGE;
+		}
 
 		/* At ingress, the mac header has already been pulled once.
 		 * At egress, skb_pospull_rcsum has to be done in case that
-- 
2.35.1

