Return-Path: <bpf+bounces-34437-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 756F692D88B
	for <lists+bpf@lfdr.de>; Wed, 10 Jul 2024 20:47:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0349E1F243BE
	for <lists+bpf@lfdr.de>; Wed, 10 Jul 2024 18:47:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88060196D98;
	Wed, 10 Jul 2024 18:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="IunBHVvS"
X-Original-To: bpf@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazolkn19011018.outbound.protection.outlook.com [52.103.32.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 337C619939E;
	Wed, 10 Jul 2024 18:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.32.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720637021; cv=fail; b=Or1sxWwTNBLb2PlV2SuCPWqSO727YfjN9KoyO1sWOaMmVfqyxLhl/3572T5EpH7fuotq4K8gMxUMu5qy2yg2T5EsS7pDSJWfRfZTJKnY+VgmfQqGLF8wMW2HDrdz97PCgblWLp5+7Lbo4TlSk/6ChsMVXo0MOJ59ZCnsukXYE9M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720637021; c=relaxed/simple;
	bh=FvHTQDE3p16wuWz9aM7RjyEAYfk1Q5AMjLIflanPGJc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fxXs7hhpeHn4KRtkYOym12EM9OzldBHbOGS3nmhJ53/VzkTUrTAoTqJsocC9tPZQek9kmxT5ic3lF+0jFUgRO9KDkM/V8e+sYZmCJtu5NRePR+T+LLfNXbeOlVCxFW/sS8iS5UDtae42EQuEDfU6HwOXbabnezFollleoNsyS0g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=IunBHVvS; arc=fail smtp.client-ip=52.103.32.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O6bRnaojVU1eT/Y0IAwBlt8mD2815Ou1kf3wPd9dRmwbh34IwDxVY9T56aaga9tSWZNJGuk2gWcyBE16lAtr9fuQZ0VtspzsM3EnkvXRKXaAy/gyuagiZrJXU5u0dMXe3voDP48OUFx2wKCL3HJopqC7jvl2YDvSkeTtjUg+qVNSDoQleDGtA/F3JVuqvH44cYpevcnUZo3hpNIt9+ZQpyDryhibWu0cai7exrwUTWNIUhGSDlWNkx5AZXfxBGsnI2PmprbW0OJlemPqI+sQtB1xlJc4CFHXU3elf690ko3D6wSvBsKwtjTZm95YcX88G/q866d4U0vkSAOdrvOyIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5BuvugXW+Fdk3yqLfSThp7L96+nhopl+ZSPgDBW6qaY=;
 b=FJgBpWgOzwvyDBy6aJcLhLb7hzd8U7XW9pQYdySZRkzOtjyfpwDRp7h0Nvt2UToRqillgkQId06WYrsUof1+cRvSrc9Su//CMEbQSZsaCFYFQOVuuU3o7dfIERqYVwlJgjgZpER6iIVrgphgeqRdNFZ1CupXChKT1L51wWqBtC3nyV9iY+2mGYa8zmx3WIn449G7gz57XQHfHBW5HUaLvFfB+H3oI4XPOpRnx+9z9YutSJj9w5PnAn0Lr4cxzFdyqrs32F37NZ9uG4mkzzk6cs8J5qLm+xclMu9tqoudItV9XSXefZBwEerVXrxQtCBNrkgufLqDbeDAH9FLDleLHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5BuvugXW+Fdk3yqLfSThp7L96+nhopl+ZSPgDBW6qaY=;
 b=IunBHVvSedOaJ3g64mDGmhEkwvkOjlk8QoNn4VVi408JLXCjvGLRIibevopESEfN8xEa61ruAJ4H/vlZ4tjVpzWw5noFZ0YVLaL9vSRuwC/ZEZSBYQoS266XetWFU3ZgBtG/yfR6d5908OiNda0WQQIcqDGBtfGYhWotI/X5vXygXG8iU4fI1uL/mr4vrePS/12+VJWBqSN6Q1OLmpLZqlgLKgBs4efIvtuozY7z1r963q5dCZAEYm4u7K8w/n1b8h+AXnTVtBLuvQoPYKGoXb7vCToCf4N/sQMTOD/Rm62U58Wud4cSjCzoSwd+V0HeSuN8NOCmuk10q7BGfUyNHQ==
Received: from AM6PR03MB5848.eurprd03.prod.outlook.com (2603:10a6:20b:e4::10)
 by AS8PR03MB9935.eurprd03.prod.outlook.com (2603:10a6:20b:628::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Wed, 10 Jul
 2024 18:43:37 +0000
Received: from AM6PR03MB5848.eurprd03.prod.outlook.com
 ([fe80::4b97:bbdb:e0ac:6f7]) by AM6PR03MB5848.eurprd03.prod.outlook.com
 ([fe80::4b97:bbdb:e0ac:6f7%6]) with mapi id 15.20.7741.033; Wed, 10 Jul 2024
 18:43:37 +0000
From: Juntong Deng <juntong.deng@outlook.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	andrii@kernel.org,
	avagin@gmail.com,
	snorcht@gmail.com
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 11/16] bpf/crib: Introduce skb open-coded iterator kfuncs
Date: Wed, 10 Jul 2024 19:40:55 +0100
Message-ID:
 <AM6PR03MB5848C54C9277B0057B4F0F9F99A42@AM6PR03MB5848.eurprd03.prod.outlook.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240710184100.297261-1-juntong.deng@outlook.com>
References: <20240710184100.297261-1-juntong.deng@outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [jQ5rzj3ixYuWcjReUsk3G+ByAAC3Olgy]
X-ClientProxiedBy: SI2PR02CA0027.apcprd02.prod.outlook.com
 (2603:1096:4:195::14) To AM6PR03MB5848.eurprd03.prod.outlook.com
 (2603:10a6:20b:e4::10)
X-Microsoft-Original-Message-ID:
 <20240710184100.297261-12-juntong.deng@outlook.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR03MB5848:EE_|AS8PR03MB9935:EE_
X-MS-Office365-Filtering-Correlation-Id: 898f276a-90ec-49d5-803a-08dca1103574
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|8060799006|19110799003|461199028|3412199025|440099028;
X-Microsoft-Antispam-Message-Info:
	g3UqrDqLpT/ODVTI8YCJiUz3g5GR/IwykCHoR2k5PyYk/Zhks26GYM4xWdHQ3QMFAhsxCEIVVQZGq5VJWILcTbYRvunkdF70Pzy8lq+kHEkapG6qpbDKNgRkl/ANIeLSNa5+vnNt6GhmxKV2teE5Pr9XVJ6uLIu6zcldKpZ50rwpxlgFEldS9j5F9TpaKG/4LL9r+w/dXX4Yl8/i1r8cypWkfonSfLZzpHhcybblJ6XuWBRWenAnwZ2NTzDwAyTeLxTSCQiw/zSsT8RaL9GcY9VN751Er+Wpb6JIsh1rhjdz0Nekfcw0cK49f0yShQgHzaMWP8TOBXqVUohAj6Bjxn/h2ipyM9R/tLVh84PebfZ/iPT3vigom53ZBxxyQpP+KFjrzGE7qworDx4lp5FIE5lG0O8LrITf4C3CLh7dGa3VvAZr7uiBaT5hJ3VRbbnJN1amUH2VliOPDpLPCe/YeyMP0j5jxIgA07rozgR9qYWNuahV73Yfu0PKDU5Y+ccE6YAB/yXtJkMoEWyOlNfCWYUjSsIsNlngbE0PLiVaIZ8y7xsOD6Nh4W/yl33b8qlhQxC4sx+Oe43ldaGMpfe1sG3VIA+NCQuyiScC4Zg1dthitY2GPhUI2MedQ6XBMusqWkRv3lZHr1RRhZwVpVo/iA==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Alo70uSdV8G+oRbAssw2N5Tp3lMc6f/LubAwAny04RFE3Gz4HSH9OLvkSqp4?=
 =?us-ascii?Q?2U+jIc0Nx/F5DvdDrKu8rV2hbhaVQ+lKPYIL7cnzMyW6wBgMv8hotokjK3II?=
 =?us-ascii?Q?ejGGdPYgJuUd2ddF5WFcAsDvgZROYKyaeKXKJlTQCdHcMbV6pLT6Ajfdy8rk?=
 =?us-ascii?Q?SAK/d8oUmfHfyvWxMLhplO/hpEWWXZRvTrdTzjR3AG5+WrGosu30msQhNMkK?=
 =?us-ascii?Q?OMOA3qw6ij6lZML1GBkxZ1GUIxOzeU6UppCE1CjadylpreuNi3PtFi7ltxMj?=
 =?us-ascii?Q?YzcjmXBSxkLt13OW11e2Taf0NE/cT1RtGqNzq6mgJblJ5ToAfXIz7wgDAITW?=
 =?us-ascii?Q?Zt+w29feVcGshV7v9bal3zJdZZgPVMvnjNWNIXR8R/60/WonNkn6jTnEF9U6?=
 =?us-ascii?Q?bt1EAAg57QlNSvUjwp8kco1Tx97PSMuw0X7N97JfCBHbiORxIPA18lQP8kEb?=
 =?us-ascii?Q?AjxFGKNe86Y+CYuh+RpkJH+53HsvyxLfG/fN/AgmjdwwkDK2YR0jXmdNQkHh?=
 =?us-ascii?Q?SRyLzNusyxq2Fwid+zdoa4+2hElCbY9NBoXWYOV0EKi/TU0YqZis8csiuSKm?=
 =?us-ascii?Q?5bNpzxQYsNzwwon9Zry2fyEGe6QRqNWwluWfSV6jptLGyqFdH5yYOHwIcBDK?=
 =?us-ascii?Q?5xUzIbblMtLgjyzCIHhQlZlNFvUW/Bk0zkGLQLvYkbstljMiOX6mtlVrWpjA?=
 =?us-ascii?Q?RpbXTvCGwQ//iMAmVAHIw2CkqwPWS2VNdByaJqRqwbpuuCaxnRh0XNyst4KJ?=
 =?us-ascii?Q?Wu0xUTmbgt9/gNTNRSw3GQuZQS4bHUkQ9eI5bd9rzv/PQ8Fk+V+vyQ3OFK1N?=
 =?us-ascii?Q?MmAoGZmdRGfkqCZ2VoSWKMLnEbcPc7uqAjFPmj8keLnyMQ4zKEEC9iCkg/xM?=
 =?us-ascii?Q?yqCYJS3pTTOTwts2BwI4Byl8KZQiI6xBInJ9jGl+9CINGaGKywBvDS3HNpW0?=
 =?us-ascii?Q?0lWg463HCBMRYwpsuy7Kst1FxSkhJJPMMuQgIj8Z2MWwS7W1pQACoo2RLPMl?=
 =?us-ascii?Q?Tw30bpTnyXU79fYfhmwqQsOTUvjDlKg1C7QaV6dW3r/EebeTrfthIHbfAj5S?=
 =?us-ascii?Q?JWWD6dAwCIRTliJ0CcH5bcsOp6aQVQ2ZTb4lm8e2gI7X7QESoG6an40yNaAc?=
 =?us-ascii?Q?ull+kLfm40soOj7z1rQau0jV0/ZU0KuQdfAqobMpQPX5luzbF1vrsldqKWim?=
 =?us-ascii?Q?qRRh5F8exVJwl+HMDmKhLUZU1cjTClLtoDkyW6e8dIJnS/JDuKh2g1oFfAA?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 898f276a-90ec-49d5-803a-08dca1103574
X-MS-Exchange-CrossTenant-AuthSource: AM6PR03MB5848.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2024 18:43:37.0293
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR03MB9935

This patch adds open-coded iterator style socket queue skb iterator
kfuncs bpf_iter_skb_{new,next,destroy} that iterates over all skb
(struct sk_buff) in the specified socket queue (struct sk_buff_head) .

The reference to struct sk_buff acquired by the previous
bpf_iter_skb_next() is released in the next bpf_iter_skb_next(),
and the last reference is released in the last bpf_iter_skb_next()
that returns NULL.

In the bpf_iter_skb_destroy(), if the iterator does not iterate to the end,
then the last struct sk_buff reference is released at this time.

Signed-off-by: Juntong Deng <juntong.deng@outlook.com>
---
 include/linux/bpf_crib.h         |  9 ++++
 kernel/bpf/crib/bpf_checkpoint.c | 79 ++++++++++++++++++++++++++++++++
 kernel/bpf/crib/bpf_crib.c       |  4 ++
 3 files changed, 92 insertions(+)

diff --git a/include/linux/bpf_crib.h b/include/linux/bpf_crib.h
index 468ae87fa1a5..e7cfa9c1ae6b 100644
--- a/include/linux/bpf_crib.h
+++ b/include/linux/bpf_crib.h
@@ -23,4 +23,13 @@ struct bpf_iter_task_file_kern {
 	int fd;
 } __aligned(8);
 
+struct bpf_iter_skb {
+	__u64 __opaque[2];
+} __aligned(8);
+
+struct bpf_iter_skb_kern {
+	struct sk_buff_head *head;
+	struct sk_buff *skb;
+} __aligned(8);
+
 #endif /* _BPF_CRIB_H */
diff --git a/kernel/bpf/crib/bpf_checkpoint.c b/kernel/bpf/crib/bpf_checkpoint.c
index d8cd4a1b73dc..c95844faecbc 100644
--- a/kernel/bpf/crib/bpf_checkpoint.c
+++ b/kernel/bpf/crib/bpf_checkpoint.c
@@ -14,6 +14,10 @@
 
 extern void bpf_file_release(struct file *file);
 
+extern struct sk_buff *bpf_skb_acquire(struct sk_buff *skb);
+
+extern void bpf_skb_release(struct sk_buff *skb);
+
 __bpf_kfunc_start_defs();
 
 /**
@@ -162,4 +166,79 @@ __bpf_kfunc int bpf_cal_skb_size(struct sk_buff *skb)
 	return skb_end_offset(skb) + skb->data_len;
 }
 
+/**
+ * bpf_iter_skb_new() - Initialize a new skb iterator for a socket
+ * queue (sk_buff_head), used to iterates over all skb in the specified
+ * socket queue
+ *
+ * @it: The new bpf_iter_skb to be created
+ * @head: A pointer pointing to a sk_buff_head to be iterated over
+ */
+__bpf_kfunc int bpf_iter_skb_new(struct bpf_iter_skb *it,
+		struct sk_buff_head *head)
+{
+	struct bpf_iter_skb_kern *kit = (void *)it;
+
+	BUILD_BUG_ON(sizeof(struct bpf_iter_skb_kern) != sizeof(struct bpf_iter_skb));
+	BUILD_BUG_ON(__alignof__(struct bpf_iter_skb_kern) != __alignof__(struct bpf_iter_skb));
+
+	kit->head = head;
+	kit->skb = NULL;
+
+	return 0;
+}
+
+/**
+ * bpf_iter_skb_next() - Get the next skb in bpf_iter_skb
+ *
+ * bpf_iter_skb_next() acquires a reference to the returned struct sk_buff.
+ *
+ * The reference to struct sk_buff acquired by the previous bpf_iter_skb_next()
+ * is released in the next bpf_iter_skb_next(), and the last reference is
+ * released in the last bpf_iter_skb_next() that returns NULL.
+ *
+ * @it: bpf_iter_skb to be checked
+ *
+ * @returns a pointer to the struct sk_buff of the next skb if further skbs
+ * are available, otherwise returns NULL.
+ */
+__bpf_kfunc struct sk_buff *bpf_iter_skb_next(struct bpf_iter_skb *it)
+{
+	struct bpf_iter_skb_kern *kit = (void *)it;
+	unsigned long flags;
+
+	if (kit->skb)
+		bpf_skb_release(kit->skb);
+
+	spin_lock_irqsave(&kit->head->lock, flags);
+
+	if (!kit->skb)
+		kit->skb = skb_peek(kit->head);
+	else
+		kit->skb = skb_peek_next(kit->skb, kit->head);
+
+	spin_unlock_irqrestore(&kit->head->lock, flags);
+
+	if (kit->skb)
+		bpf_skb_acquire(kit->skb);
+
+	return kit->skb;
+}
+
+/**
+ * bpf_iter_skb_destroy() - Destroy a bpf_iter_skb
+ *
+ * If the iterator does not iterate to the end, then the last
+ * struct sk_buff reference is released at this time.
+ *
+ * @it: bpf_iter_skb to be destroyed
+ */
+__bpf_kfunc void bpf_iter_skb_destroy(struct bpf_iter_skb *it)
+{
+	struct bpf_iter_skb_kern *kit = (void *)it;
+
+	if (kit->skb)
+		bpf_skb_release(kit->skb);
+}
+
 __bpf_kfunc_end_defs();
diff --git a/kernel/bpf/crib/bpf_crib.c b/kernel/bpf/crib/bpf_crib.c
index 21889efa620c..fda34d8143f1 100644
--- a/kernel/bpf/crib/bpf_crib.c
+++ b/kernel/bpf/crib/bpf_crib.c
@@ -289,6 +289,10 @@ BTF_ID_FLAGS(func, bpf_skb_release, KF_RELEASE)
 BTF_ID_FLAGS(func, bpf_cal_skb_size, KF_TRUSTED_ARGS)
 BTF_ID_FLAGS(func, bpf_skb_peek_tail, KF_ACQUIRE | KF_TRUSTED_ARGS | KF_RET_NULL)
 
+BTF_ID_FLAGS(func, bpf_iter_skb_new, KF_ITER_NEW | KF_TRUSTED_ARGS)
+BTF_ID_FLAGS(func, bpf_iter_skb_next, KF_ITER_NEXT | KF_RET_NULL)
+BTF_ID_FLAGS(func, bpf_iter_skb_destroy, KF_ITER_DESTROY)
+
 BTF_KFUNCS_END(bpf_crib_kfuncs)
 
 static int bpf_prog_run_crib(struct bpf_prog *prog,
-- 
2.39.2


