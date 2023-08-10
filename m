Return-Path: <bpf+bounces-7422-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EB70777046
	for <lists+bpf@lfdr.de>; Thu, 10 Aug 2023 08:25:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4938D281F0D
	for <lists+bpf@lfdr.de>; Thu, 10 Aug 2023 06:25:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 619CA1C3A;
	Thu, 10 Aug 2023 06:25:17 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E3731C31
	for <bpf@vger.kernel.org>; Thu, 10 Aug 2023 06:25:17 +0000 (UTC)
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 451B910FF
	for <bpf@vger.kernel.org>; Wed,  9 Aug 2023 23:25:16 -0700 (PDT)
Received: from canpemm500006.china.huawei.com (unknown [172.30.72.53])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4RLxfl21xNzqShM;
	Thu, 10 Aug 2023 14:22:23 +0800 (CST)
Received: from localhost.localdomain (10.175.104.82) by
 canpemm500006.china.huawei.com (7.192.105.130) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 10 Aug 2023 14:25:13 +0800
From: Ziyang Xuan <william.xuanziyang@huawei.com>
To: <martin.lau@linux.dev>, <daniel@iogearbox.net>,
	<john.fastabend@gmail.com>, <ast@kernel.org>, <andrii@kernel.org>,
	<song@kernel.org>, <yonghong.song@linux.dev>, <kpsingh@kernel.org>,
	<sdf@google.com>, <haoluo@google.com>, <jolsa@kernel.org>,
	<bpf@vger.kernel.org>
Subject: [PATCH bpf-next 2/2] selftests/bpf: Remove unnecessary codes for updating h_proto of ethhdr
Date: Thu, 10 Aug 2023 14:25:02 +0800
Message-ID: <678786447908dad330bb02e7124ea73938c366e1.1691639830.git.william.xuanziyang@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1691639830.git.william.xuanziyang@huawei.com>
References: <cover.1691639830.git.william.xuanziyang@huawei.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.175.104.82]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 canpemm500006.china.huawei.com (7.192.105.130)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Since updating h_proto of ethhdr in kernel, remove the codes
in user bpf program.

Signed-off-by: Ziyang Xuan <william.xuanziyang@huawei.com>
---
 .../selftests/bpf/progs/test_tc_tunnel.c       | 18 ------------------
 1 file changed, 18 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/test_tc_tunnel.c b/tools/testing/selftests/bpf/progs/test_tc_tunnel.c
index e6e678aa9874..a33be22a2dc4 100644
--- a/tools/testing/selftests/bpf/progs/test_tc_tunnel.c
+++ b/tools/testing/selftests/bpf/progs/test_tc_tunnel.c
@@ -236,17 +236,6 @@ static __always_inline int __encap_ipv4(struct __sk_buff *skb, __u8 encap_proto,
 				BPF_F_INVALIDATE_HASH) < 0)
 		return TC_ACT_SHOT;
 
-	/* if changing outer proto type, update eth->h_proto */
-	if (encap_proto == IPPROTO_IPV6) {
-		struct ethhdr eth;
-
-		if (bpf_skb_load_bytes(skb, 0, &eth, sizeof(eth)) < 0)
-			return TC_ACT_SHOT;
-		eth.h_proto = bpf_htons(ETH_P_IP);
-		if (bpf_skb_store_bytes(skb, 0, &eth, sizeof(eth), 0) < 0)
-			return TC_ACT_SHOT;
-	}
-
 	return TC_ACT_OK;
 }
 
@@ -412,13 +401,6 @@ static int encap_ipv6_ipip6(struct __sk_buff *skb)
 				BPF_F_INVALIDATE_HASH) < 0)
 		return TC_ACT_SHOT;
 
-	/* update eth->h_proto */
-	if (bpf_skb_load_bytes(skb, 0, &eth, sizeof(eth)) < 0)
-		return TC_ACT_SHOT;
-	eth.h_proto = bpf_htons(ETH_P_IPV6);
-	if (bpf_skb_store_bytes(skb, 0, &eth, sizeof(eth), 0) < 0)
-		return TC_ACT_SHOT;
-
 	return TC_ACT_OK;
 }
 
-- 
2.25.1


