Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD4165B944F
	for <lists+bpf@lfdr.de>; Thu, 15 Sep 2022 08:28:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229653AbiIOG2z (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 15 Sep 2022 02:28:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbiIOG2y (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 15 Sep 2022 02:28:54 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B19689829;
        Wed, 14 Sep 2022 23:28:53 -0700 (PDT)
Received: from dggpeml500026.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MSnHj2J6qzmVM6;
        Thu, 15 Sep 2022 14:25:05 +0800 (CST)
Received: from huawei.com (10.175.101.6) by dggpeml500026.china.huawei.com
 (7.185.36.106) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Thu, 15 Sep
 2022 14:28:50 +0800
From:   Zhengchao Shao <shaozhengchao@huawei.com>
To:     <netdev@vger.kernel.org>, <bpf@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>, <jhs@mojatatu.com>,
        <xiyou.wangcong@gmail.com>, <jiri@resnulli.us>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <shuah@kernel.org>
CC:     <ast@kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>,
        <martin.lau@linux.dev>, <song@kernel.org>, <yhs@fb.com>,
        <john.fastabend@gmail.com>, <kpsingh@kernel.org>, <sdf@google.com>,
        <haoluo@google.com>, <jolsa@kernel.org>, <weiyongjun1@huawei.com>,
        <yuehaibing@huawei.com>, <shaozhengchao@huawei.com>
Subject: [PATCH net-next,v3 1/9] net/sched: cls_api: add helper for tc cls walker stats updating
Date:   Thu, 15 Sep 2022 14:30:30 +0800
Message-ID: <20220915063038.20010-2-shaozhengchao@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220915063038.20010-1-shaozhengchao@huawei.com>
References: <20220915063038.20010-1-shaozhengchao@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.101.6]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
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

The walk implementation of most tc cls modules is basically the same.
That is, the values of count and skip are checked first. If count is
greater than or equal to skip, the registered fn function is executed.
Otherwise, increase the value of count. So we can reconstruct them.

Signed-off-by: Zhengchao Shao <shaozhengchao@huawei.com>
Reviewed-by: Jamal Hadi Salim <jhs@mojatatu.com>
---
 include/net/pkt_cls.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/include/net/pkt_cls.h b/include/net/pkt_cls.h
index d9d90e6925e1..d3cbbabf7592 100644
--- a/include/net/pkt_cls.h
+++ b/include/net/pkt_cls.h
@@ -81,6 +81,19 @@ int tcf_classify(struct sk_buff *skb,
 		 const struct tcf_proto *tp, struct tcf_result *res,
 		 bool compat_mode);
 
+static inline bool tc_cls_stats_update(struct tcf_proto *tp,
+				       struct tcf_walker *arg,
+				       void *filter)
+{
+	if (arg->count >= arg->skip && arg->fn(tp, filter, arg) < 0) {
+		arg->stop = 1;
+		return false;
+	}
+
+	arg->count++;
+	return true;
+}
+
 #else
 static inline bool tcf_block_shared(struct tcf_block *block)
 {
-- 
2.17.1

