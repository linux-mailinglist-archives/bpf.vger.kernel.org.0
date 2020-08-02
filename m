Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA606239C29
	for <lists+bpf@lfdr.de>; Sun,  2 Aug 2020 23:31:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727923AbgHBVa4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 2 Aug 2020 17:30:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726364AbgHBVaz (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 2 Aug 2020 17:30:55 -0400
Received: from forwardcorp1p.mail.yandex.net (forwardcorp1p.mail.yandex.net [IPv6:2a02:6b8:0:1472:2741:0:8b6:217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B769C06174A;
        Sun,  2 Aug 2020 14:30:55 -0700 (PDT)
Received: from vla1-fdfb804fb3f3.qloud-c.yandex.net (vla1-fdfb804fb3f3.qloud-c.yandex.net [IPv6:2a02:6b8:c0d:3199:0:640:fdfb:804f])
        by forwardcorp1p.mail.yandex.net (Yandex) with ESMTP id 527C32E14D5;
        Mon,  3 Aug 2020 00:30:52 +0300 (MSK)
Received: from vla5-58875c36c028.qloud-c.yandex.net (vla5-58875c36c028.qloud-c.yandex.net [2a02:6b8:c18:340b:0:640:5887:5c36])
        by vla1-fdfb804fb3f3.qloud-c.yandex.net (mxbackcorp/Yandex) with ESMTP id sPDLHtjn2X-UqqeVFmv;
        Mon, 03 Aug 2020 00:30:52 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1596403852; bh=0+K6ekHFGCKpywJPU+f+Df3pWthE/8ooVEOmlxubSu0=;
        h=In-Reply-To:Message-Id:References:Date:Subject:To:From:Cc;
        b=L98KajXH1Cj3Z8cm/ApSrI8aLxaYLMwF08NV+sugpSsbb0C7PQbiqDtPF0jbC8C5b
         Ebzl5xDpXQvKh2FqYUWVtG6T+x+Y+JVheglaswsGSJIYNkVYegfJn+7CD46K/SJRiE
         Iv5pwQV2NRGMkaCoviZFUqRN+kEnITu8xn3mNqGU=
Authentication-Results: vla1-fdfb804fb3f3.qloud-c.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from unknown (unknown [178.154.141.161])
        by vla5-58875c36c028.qloud-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id CwYyvqXlFC-UpjmUkEu;
        Mon, 03 Aug 2020 00:30:51 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
From:   Dmitry Yakunin <zeil@yandex-team.ru>
To:     alexei.starovoitov@gmail.com, daniel@iogearbox.net,
        netdev@vger.kernel.org, bpf@vger.kernel.org
Cc:     sdf@google.com
Subject: [PATCH bpf-next v5 2/2] bpf: allow to specify ifindex for skb in bpf_prog_test_run_skb
Date:   Mon,  3 Aug 2020 00:30:26 +0300
Message-Id: <20200802213026.78731-3-zeil@yandex-team.ru>
In-Reply-To: <20200802213026.78731-1-zeil@yandex-team.ru>
References: <20200802213026.78731-1-zeil@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Now skb->dev is unconditionally set to the loopback device in current net
namespace. But if we want to test bpf program which contains code branch
based on ifindex condition (eg filters out localhost packets) it is useful
to allow specifying of ifindex from userspace. This patch adds such option
through ctx_in (__sk_buff) parameter.

Signed-off-by: Dmitry Yakunin <zeil@yandex-team.ru>
---
 net/bpf/test_run.c                               | 22 ++++++++++++++++++++--
 tools/testing/selftests/bpf/prog_tests/skb_ctx.c |  5 +++++
 2 files changed, 25 insertions(+), 2 deletions(-)

diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
index 8d69295..369ce90 100644
--- a/net/bpf/test_run.c
+++ b/net/bpf/test_run.c
@@ -327,6 +327,12 @@ static int convert___skb_to_skb(struct sk_buff *skb, struct __sk_buff *__skb)
 	/* priority is allowed */
 
 	if (!range_is_zero(__skb, offsetofend(struct __sk_buff, priority),
+			   offsetof(struct __sk_buff, ifindex)))
+		return -EINVAL;
+
+	/* ifindex is allowed */
+
+	if (!range_is_zero(__skb, offsetofend(struct __sk_buff, ifindex),
 			   offsetof(struct __sk_buff, cb)))
 		return -EINVAL;
 
@@ -381,6 +387,7 @@ static void convert_skb_to___skb(struct sk_buff *skb, struct __sk_buff *__skb)
 
 	__skb->mark = skb->mark;
 	__skb->priority = skb->priority;
+	__skb->ifindex = skb->dev->ifindex;
 	__skb->tstamp = skb->tstamp;
 	memcpy(__skb->cb, &cb->data, QDISC_CB_PRIV_LEN);
 	__skb->wire_len = cb->pkt_len;
@@ -391,6 +398,8 @@ int bpf_prog_test_run_skb(struct bpf_prog *prog, const union bpf_attr *kattr,
 			  union bpf_attr __user *uattr)
 {
 	bool is_l2 = false, is_direct_pkt_access = false;
+	struct net *net = current->nsproxy->net_ns;
+	struct net_device *dev = net->loopback_dev;
 	u32 size = kattr->test.data_size_in;
 	u32 repeat = kattr->test.repeat;
 	struct __sk_buff *ctx = NULL;
@@ -432,7 +441,7 @@ int bpf_prog_test_run_skb(struct bpf_prog *prog, const union bpf_attr *kattr,
 		kfree(ctx);
 		return -ENOMEM;
 	}
-	sock_net_set(sk, current->nsproxy->net_ns);
+	sock_net_set(sk, net);
 	sock_init_data(NULL, sk);
 
 	skb = build_skb(data, 0);
@@ -446,7 +455,14 @@ int bpf_prog_test_run_skb(struct bpf_prog *prog, const union bpf_attr *kattr,
 
 	skb_reserve(skb, NET_SKB_PAD + NET_IP_ALIGN);
 	__skb_put(skb, size);
-	skb->protocol = eth_type_trans(skb, current->nsproxy->net_ns->loopback_dev);
+	if (ctx && ctx->ifindex > 1) {
+		dev = dev_get_by_index(net, ctx->ifindex);
+		if (!dev) {
+			ret = -ENODEV;
+			goto out;
+		}
+	}
+	skb->protocol = eth_type_trans(skb, dev);
 	skb_reset_network_header(skb);
 
 	switch (skb->protocol) {
@@ -502,6 +518,8 @@ int bpf_prog_test_run_skb(struct bpf_prog *prog, const union bpf_attr *kattr,
 		ret = bpf_ctx_finish(kattr, uattr, ctx,
 				     sizeof(struct __sk_buff));
 out:
+	if (dev && dev != net->loopback_dev)
+		dev_put(dev);
 	kfree_skb(skb);
 	bpf_sk_storage_free(sk);
 	kfree(sk);
diff --git a/tools/testing/selftests/bpf/prog_tests/skb_ctx.c b/tools/testing/selftests/bpf/prog_tests/skb_ctx.c
index 7021b92..25de86a 100644
--- a/tools/testing/selftests/bpf/prog_tests/skb_ctx.c
+++ b/tools/testing/selftests/bpf/prog_tests/skb_ctx.c
@@ -11,6 +11,7 @@ void test_skb_ctx(void)
 		.cb[3] = 4,
 		.cb[4] = 5,
 		.priority = 6,
+		.ifindex = 1,
 		.tstamp = 7,
 		.wire_len = 100,
 		.gso_segs = 8,
@@ -92,6 +93,10 @@ void test_skb_ctx(void)
 		   "ctx_out_priority",
 		   "skb->priority == %d, expected %d\n",
 		   skb.priority, 7);
+	CHECK_ATTR(skb.ifindex != 1,
+		   "ctx_out_ifindex",
+		   "skb->ifindex == %d, expected %d\n",
+		   skb.ifindex, 1);
 	CHECK_ATTR(skb.tstamp != 8,
 		   "ctx_out_tstamp",
 		   "skb->tstamp == %lld, expected %d\n",
-- 
2.7.4

