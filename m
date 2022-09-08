Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 397235B133F
	for <lists+bpf@lfdr.de>; Thu,  8 Sep 2022 06:14:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230092AbiIHENu (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 8 Sep 2022 00:13:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229914AbiIHENZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 8 Sep 2022 00:13:25 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7348DC2F93;
        Wed,  7 Sep 2022 21:13:15 -0700 (PDT)
Received: from dggpeml500026.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MNQcd4GglzmVGB;
        Thu,  8 Sep 2022 12:09:37 +0800 (CST)
Received: from huawei.com (10.175.101.6) by dggpeml500026.china.huawei.com
 (7.185.36.106) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 8 Sep
 2022 12:13:12 +0800
From:   Zhengchao Shao <shaozhengchao@huawei.com>
To:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <bpf@vger.kernel.org>, <davem@davemloft.net>,
        <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
        <jhs@mojatatu.com>, <xiyou.wangcong@gmail.com>, <jiri@resnulli.us>,
        <martin.lau@linux.dev>
CC:     <daniel@iogearbox.net>, <john.fastabend@gmail.com>,
        <ast@kernel.org>, <andrii@kernel.org>, <song@kernel.org>,
        <yhs@fb.com>, <kpsingh@kernel.org>, <sdf@google.com>,
        <haoluo@google.com>, <jolsa@kernel.org>, <weiyongjun1@huawei.com>,
        <yuehaibing@huawei.com>, <shaozhengchao@huawei.com>
Subject: [PATCH net-next,v3 08/22] net: sched: act_gact: get rid of tcf_gact_walker and tcf_gact_search
Date:   Thu, 8 Sep 2022 12:14:40 +0800
Message-ID: <20220908041454.365070-9-shaozhengchao@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220908041454.365070-1-shaozhengchao@huawei.com>
References: <20220908041454.365070-1-shaozhengchao@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.101.6]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpeml500026.china.huawei.com (7.185.36.106)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

tcf_gact_walker() and tcf_gact_search() do the same thing as generic
walk/search function, so remove them.

Signed-off-by: Zhengchao Shao <shaozhengchao@huawei.com>
Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>
---
 net/sched/act_gact.c | 19 -------------------
 1 file changed, 19 deletions(-)

diff --git a/net/sched/act_gact.c b/net/sched/act_gact.c
index ede896a7ee6b..abe1bcc5c797 100644
--- a/net/sched/act_gact.c
+++ b/net/sched/act_gact.c
@@ -221,23 +221,6 @@ static int tcf_gact_dump(struct sk_buff *skb, struct tc_action *a,
 	return -1;
 }
 
-static int tcf_gact_walker(struct net *net, struct sk_buff *skb,
-			   struct netlink_callback *cb, int type,
-			   const struct tc_action_ops *ops,
-			   struct netlink_ext_ack *extack)
-{
-	struct tc_action_net *tn = net_generic(net, act_gact_ops.net_id);
-
-	return tcf_generic_walker(tn, skb, cb, type, ops, extack);
-}
-
-static int tcf_gact_search(struct net *net, struct tc_action **a, u32 index)
-{
-	struct tc_action_net *tn = net_generic(net, act_gact_ops.net_id);
-
-	return tcf_idr_search(tn, a, index);
-}
-
 static size_t tcf_gact_get_fill_size(const struct tc_action *act)
 {
 	size_t sz = nla_total_size(sizeof(struct tc_gact)); /* TCA_GACT_PARMS */
@@ -307,8 +290,6 @@ static struct tc_action_ops act_gact_ops = {
 	.stats_update	=	tcf_gact_stats_update,
 	.dump		=	tcf_gact_dump,
 	.init		=	tcf_gact_init,
-	.walk		=	tcf_gact_walker,
-	.lookup		=	tcf_gact_search,
 	.get_fill_size	=	tcf_gact_get_fill_size,
 	.offload_act_setup =	tcf_gact_offload_act_setup,
 	.size		=	sizeof(struct tcf_gact),
-- 
2.17.1

