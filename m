Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F0115AE77F
	for <lists+bpf@lfdr.de>; Tue,  6 Sep 2022 14:13:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239724AbiIFMNX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 6 Sep 2022 08:13:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239718AbiIFMMj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 6 Sep 2022 08:12:39 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62CE979A7F;
        Tue,  6 Sep 2022 05:11:55 -0700 (PDT)
Received: from dggpeml500026.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MMPM363c5znV26;
        Tue,  6 Sep 2022 20:09:19 +0800 (CST)
Received: from huawei.com (10.175.101.6) by dggpeml500026.china.huawei.com
 (7.185.36.106) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 6 Sep
 2022 20:11:52 +0800
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
Subject: [PATCH net-next,v2 15/22] net: sched: act_pedit: get rid of tcf_pedit_walker and tcf_pedit_search
Date:   Tue, 6 Sep 2022 20:13:39 +0800
Message-ID: <20220906121346.71578-16-shaozhengchao@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220906121346.71578-1-shaozhengchao@huawei.com>
References: <20220906121346.71578-1-shaozhengchao@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.101.6]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
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

tcf_pedit_walker() and tcf_pedit_search() do the same thing as generic
walk/search function, so remove them.

Signed-off-by: Zhengchao Shao <shaozhengchao@huawei.com>
---
 net/sched/act_pedit.c | 19 -------------------
 1 file changed, 19 deletions(-)

diff --git a/net/sched/act_pedit.c b/net/sched/act_pedit.c
index 0951cd1e277e..94ed5857ce67 100644
--- a/net/sched/act_pedit.c
+++ b/net/sched/act_pedit.c
@@ -491,23 +491,6 @@ static int tcf_pedit_dump(struct sk_buff *skb, struct tc_action *a,
 	return -1;
 }
 
-static int tcf_pedit_walker(struct net *net, struct sk_buff *skb,
-			    struct netlink_callback *cb, int type,
-			    const struct tc_action_ops *ops,
-			    struct netlink_ext_ack *extack)
-{
-	struct tc_action_net *tn = net_generic(net, act_pedit_ops.net_id);
-
-	return tcf_generic_walker(tn, skb, cb, type, ops, extack);
-}
-
-static int tcf_pedit_search(struct net *net, struct tc_action **a, u32 index)
-{
-	struct tc_action_net *tn = net_generic(net, act_pedit_ops.net_id);
-
-	return tcf_idr_search(tn, a, index);
-}
-
 static int tcf_pedit_offload_act_setup(struct tc_action *act, void *entry_data,
 				       u32 *index_inc, bool bind,
 				       struct netlink_ext_ack *extack)
@@ -552,8 +535,6 @@ static struct tc_action_ops act_pedit_ops = {
 	.dump		=	tcf_pedit_dump,
 	.cleanup	=	tcf_pedit_cleanup,
 	.init		=	tcf_pedit_init,
-	.walk		=	tcf_pedit_walker,
-	.lookup		=	tcf_pedit_search,
 	.offload_act_setup =	tcf_pedit_offload_act_setup,
 	.size		=	sizeof(struct tcf_pedit),
 };
-- 
2.17.1

