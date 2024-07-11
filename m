Return-Path: <bpf+bounces-34550-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C38992E69C
	for <lists+bpf@lfdr.de>; Thu, 11 Jul 2024 13:28:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 80BF11C20EDC
	for <lists+bpf@lfdr.de>; Thu, 11 Jul 2024 11:28:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DACB715F300;
	Thu, 11 Jul 2024 11:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="k3OMPxit"
X-Original-To: bpf@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazolkn19013013.outbound.protection.outlook.com [52.103.32.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82AC014A4E5;
	Thu, 11 Jul 2024 11:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.32.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720697038; cv=fail; b=X85hqC7W1p0v4NqKhLHd7kbOYVSPDlBbcO7RxlNUvwAxjqrZLfff6kUxxa6757FyKo8t/UPYTwFLabnp7JNt8TtOcoFsiDxfNJqFa+MYP8Hf6w5HZ43rn42BYyePgH51aTn797jzEydJM9h2uVEXWg4/Q9rximuj9aRC6dNuJk8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720697038; c=relaxed/simple;
	bh=HQFydNqnDpEVEqqyYpysIENwzRq083Ki37ql3puGGEU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ADsyFooE8SsC+FB6W9SU8KIVwg/YBZ9XWvCSu6TtQHrOioB47gIXgqx5kmZaBtbpK/hY7LHcBunWJ7/mD6XIXhFR/x2w4jLuXh/hGwfAlG2P95B3FfemWLytP2ravHgrfYKZAR9bhYEedMOAQkbYnLVsB7tnHyxkylhPY5rS9RI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=k3OMPxit; arc=fail smtp.client-ip=52.103.32.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UPHxQEBXiL/XcvuS0oFbqCNF+unaFc9NTSTAnD5MS0aI2BEbYY9W8J0KKq1thOjzAWMuSmzOtf2UWgDV13HwHdslTxhAgvJJ1zQkKmDVg4JAYqwT9XH36RUPIjJGUmeJiJz0pOizvBYuYAXK63D+ptOQyF3DA/ms8E4wdtZ6svHwvjZ3CdXT3GW6C3lHszpi82YAFQNlwPOec+UG0glasTYXbv0/1ynUnVkrBEtIhT7bLHRW6x9jiXnpTwe9/Qem3S48HJjRLGoaHmuHwzZbXOUKOR6anRPvyvHXhDPsBqdJ7/8pt9CCiilzTUCrIVEBHQX0z3LvYfqZ+NGf8dY4aQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T5nHZceVkH3kpV0UIy7v/XCBmKwfmdeJyMCpuufML9E=;
 b=qXMfk9Cbgrb8pxB5LYqcgPvOZQtzTWUgiB4XFBx1ON6IJQYlleUoYai4D+OC7iuDrKMYBRYz90+W063vk+fyojTudOb4BBy4HE3u6rU2lxdeejSI8qfJ+wqmA2t5kFln8tx5A7dhpq+82gKD38gBLGi8vZ0TcDKnBaXBL0pyyhYBGHOjCfMSOOJvwjmHZPz6o4IVSkPQL0LHwfIO6y/UPE6M9WsryUtgE4cwMDsyTm7ZIHzGhPsANSeok9JGC0eyGsOkR7ePaGkpLSgop1Hwn8pmlwh/tpBLLM0NzoKq2odVEOWRw/BY4RAIbmoxxTvDhXQyh8h7e8HI6H2VifL/yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T5nHZceVkH3kpV0UIy7v/XCBmKwfmdeJyMCpuufML9E=;
 b=k3OMPxitlLxjL86G15+kpq91WxOQb7QN5GcwnHOje7F+hpaSr+weIJxhd2aUtMQnOS0ZJvWnzFl1IhNAKPOiCurA5TzCDfADIxItR5M/3s8lS95Sx+QF8Htg9dozwayQm/ibdFBRpIHr6kQWOiYXVo3CB+KHz+U8VU7vBowwa7CtalLbLTLDWPI0YIsnQhmjofvF+gYPbtw8qQmHMWwz2HxzUSt7TPxS8bwHTyoZ1ogJnPMHy5XcfSKTHJo1131kqv2U1scvhgMHEg6+cgjLHXSx5LAuBaO+MQ5xP1qXMB9NTThheiB4zUci6kmctBj8Jlola3wQ4N3Gg6MUJhrDuA==
Received: from AM6PR03MB5848.eurprd03.prod.outlook.com (2603:10a6:20b:e4::10)
 by GV1PR03MB10233.eurprd03.prod.outlook.com (2603:10a6:150:166::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Thu, 11 Jul
 2024 11:23:53 +0000
Received: from AM6PR03MB5848.eurprd03.prod.outlook.com
 ([fe80::4b97:bbdb:e0ac:6f7]) by AM6PR03MB5848.eurprd03.prod.outlook.com
 ([fe80::4b97:bbdb:e0ac:6f7%6]) with mapi id 15.20.7762.020; Thu, 11 Jul 2024
 11:23:53 +0000
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
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH bpf-next RESEND 10/16] bpf/crib: Add struct sk_buff related CRIB kfuncs
Date: Thu, 11 Jul 2024 12:19:32 +0100
Message-ID:
 <AM6PR03MB5848F90A17DE6AAD6EF65BA499A52@AM6PR03MB5848.eurprd03.prod.outlook.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <AM6PR03MB58488045E4D0FA6AEDC8BDE099A52@AM6PR03MB5848.eurprd03.prod.outlook.com>
References: <AM6PR03MB58488045E4D0FA6AEDC8BDE099A52@AM6PR03MB5848.eurprd03.prod.outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [yz1DmCL6DdSaEH18YTkp4OoDPsVtt4t0]
X-ClientProxiedBy: SI2P153CA0031.APCP153.PROD.OUTLOOK.COM (2603:1096:4:190::7)
 To AM6PR03MB5848.eurprd03.prod.outlook.com (2603:10a6:20b:e4::10)
X-Microsoft-Original-Message-ID:
 <20240711111938.11722-10-juntong.deng@outlook.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR03MB5848:EE_|GV1PR03MB10233:EE_
X-MS-Office365-Filtering-Correlation-Id: b2f6566a-93d4-44e5-3e50-08dca19bf21b
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199028|19110799003|8060799006|440099028|3412199025;
X-Microsoft-Antispam-Message-Info:
	1GTr2RnIRTxRXAhIefU75Xk4TjlxB5FvNhA/Jkhqw986/vqeFp+wxnA1UobHLXlY0vJRxWrSMhwB+AkAe7wQNVQJByJV9owb/tikJevPfEXwnk9AzcTJiX2Jrw6vQSD/3j1K3iZJ7LTfdlnGH7P9+sTz5gVz2olzER1X+F1Gjm5F+0Z7Hmm7acCOv+hfcK5RpQA1dmEtpJbOdkz3NizIj3gXbibwbtPys0d4C/YeBvFFfFIZLTbquEi9+HX5fu4HnASwqFT2s1iDBK2SPd+DFw+hTuKv8jlYZ8y/0SVpn4BjCCK597QfiXJQqWQEW/WPkcEUAEWDGBitH8NNCgh+cX18oF90LhviFFiWHlIf0icSDHwQFdUbyyeP5nK+/meBGmsrQuntg19Kqun6nSVpDukZW2qBCV3aZs2ExKeBgZF7ZH7zEPHedDE4SHTH0UjnE09TQV69S10ayHyFqa2aP/TlJJsqUzlJa1oAkMdIMWNNv1XdzjplUrk7cfsIifyglU4YSkMNRZikzW3FM6a/4trnDapZCdcgcRzEz/GRsN44n9qcTb2fpA3tR4+sQeWlFrik0hSD8Ow1nLs9A7H9r6qo0+Q6sy9c87cd3aoCpH/Qh6FWVXMKdRX/EtZYz3DccZDBKSxGlPv1n/Iuxz5nYg==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?oWudlq3xWJ81wPPAdBZcNrFbZHl2fAai4J2R7brCXsFsyGCTn0FqqCalJNRF?=
 =?us-ascii?Q?tVJswHkSjCExudkjyata3PcsJLjt4FG5fiQVNV5y0MiaIgd1TD4Oughm/Yj0?=
 =?us-ascii?Q?b7uX8osIctwj5accXkNbbODTG0eVjrGhg4ulvsgfdMKoByqJcFx5weSty0nG?=
 =?us-ascii?Q?WAVDTCIb2kfpA37OBETQ+e08WlBzQwon405Mf6eMcNCsRUNGBhXoiUnzzNPZ?=
 =?us-ascii?Q?rdv5AsJ21l9tCXWbpjB5hF89tNCw6XKhYMPdRIapStPVDPJgSlrIBiRQB4Yy?=
 =?us-ascii?Q?ZyHvTdufcfm3+N6FbEQg2zVW5kHeaAoXpNyN7iCG69q/T67C3P4el4h/89mT?=
 =?us-ascii?Q?rBs28qnkvRhz855eMt382vluXVPWhXdaRMP9xMnWC04ec+Mr4s2pPtqligh+?=
 =?us-ascii?Q?OGFYslrkir0IUBp8kUc29UwJNZt2yEU1CfrfU9H5uu12H7or8oeiL8ZoEfCZ?=
 =?us-ascii?Q?4DIQArJrsEbgaeuXIFk7Re+gV9ta0udYD/qivd2LG/PQiGplW99MqYy8MV5T?=
 =?us-ascii?Q?2ByrzguhPK8AUg8sTaAUGEUYEER4fdvblXQscT7oUaznMv2qqHABRFjHXW1/?=
 =?us-ascii?Q?NA4J3vDC8reKbzi0eE/zhi+P//QNbAteOW/I/Mh7YDUZypjOGiytRULP/75w?=
 =?us-ascii?Q?hjs3uAIJChtboIo8iaacWrvyjQhGNrHw/SgATK1Uh9pKqt878KitUgEFSnEO?=
 =?us-ascii?Q?XS4DBM7dfkKzGQq9HmyH9htnhsICXP08arJc9U9UQEIANEFlSO4tqCxar4/V?=
 =?us-ascii?Q?gTZPmwCkcx5/0WSIghMa0mTJg9osGF752o9iMHucC1KgnpuPPtEyJFArvYfG?=
 =?us-ascii?Q?yfoQaj1qPVVy48hOZxKorHNYJLe59Y57QlocrCS75tzyC9QQlEO43fXnkkhf?=
 =?us-ascii?Q?6V89oDHGABgP7bf102Z8AAK7Gp2W+pWLklRk4d08vfy7q4HNiyWfLyXC6nMd?=
 =?us-ascii?Q?CsVcwyre3OlxNe/sNvutkryjIowVcooZcc4uIh8GbCsByrTLVm+yg0doRVkO?=
 =?us-ascii?Q?Lx6aLx4QSngtAE3TuFS6zhd2WtGfXccdl65+n++aeFWB1Pe14xL+qhRcLpfb?=
 =?us-ascii?Q?VTkn57OCOWCJRmmgyNTAlmGIp22nM5FpQphG4zhwJZZcLwy/8CasMY/GVeE+?=
 =?us-ascii?Q?YwkyoHqxYhkQO7YCkw0bNM54ix+hblfQsWKSwLGHxj/rU94Tk1qDFA+jLjvF?=
 =?us-ascii?Q?l/7Il62ja3zOkhyDRiXzw3iej6vzxfzUmNhiq1kHA8j6Ub0v9rRSfFg+kA0?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2f6566a-93d4-44e5-3e50-08dca19bf21b
X-MS-Exchange-CrossTenant-AuthSource: AM6PR03MB5848.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2024 11:23:53.6401
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR03MB10233

This patch adds struct sk_buff related CRIB kfuncs.

bpf_skb_peek_tail() is used to get a pointer to the skb at the tail of
the socket queue.

bpf_cal_skb_size() is used to calculate the overall size of the skb data
(starting from the head).

bpf_skb_acquire()/bpf_skb_release() are used to acquire/release
references on struct sk_buff.

Signed-off-by: Juntong Deng <juntong.deng@outlook.com>
---
 kernel/bpf/crib/bpf_checkpoint.c | 14 +++++++++
 kernel/bpf/crib/bpf_crib.c       | 50 ++++++++++++++++++++++++++++++++
 2 files changed, 64 insertions(+)

diff --git a/kernel/bpf/crib/bpf_checkpoint.c b/kernel/bpf/crib/bpf_checkpoint.c
index 4d48f08324ef..d8cd4a1b73dc 100644
--- a/kernel/bpf/crib/bpf_checkpoint.c
+++ b/kernel/bpf/crib/bpf_checkpoint.c
@@ -10,6 +10,7 @@
 #include <linux/fdtable.h>
 #include <net/inet_common.h>
 #include <net/ipv6.h>
+#include <linux/skbuff.h>
 
 extern void bpf_file_release(struct file *file);
 
@@ -148,4 +149,17 @@ __bpf_kfunc int bpf_inet6_dst_addr_from_socket(struct socket *sock, struct socka
 	return inet6_getname(sock, (struct sockaddr *)addr, 1);
 }
 
+/**
+ * bpf_cal_skb_size() - Calculate the overall size of the data of specified skb
+ * (starting from the head)
+ *
+ * @skb: specified skb
+ *
+ * @returns the overall size of the data
+ */
+__bpf_kfunc int bpf_cal_skb_size(struct sk_buff *skb)
+{
+	return skb_end_offset(skb) + skb->data_len;
+}
+
 __bpf_kfunc_end_defs();
diff --git a/kernel/bpf/crib/bpf_crib.c b/kernel/bpf/crib/bpf_crib.c
index e33fa37f8f72..21889efa620c 100644
--- a/kernel/bpf/crib/bpf_crib.c
+++ b/kernel/bpf/crib/bpf_crib.c
@@ -13,6 +13,8 @@
 #include <linux/net.h>
 #include <linux/udp.h>
 #include <linux/tcp.h>
+#include <linux/skbuff.h>
+#include <linux/spinlock.h>
 
 __bpf_kfunc_start_defs();
 
@@ -209,6 +211,49 @@ __bpf_kfunc struct sk_buff_head *bpf_reader_queue_from_udp_sock(struct udp_sock
 	return &up->reader_queue;
 }
 
+/**
+ * bpf_skb_acquire() - Acquire a reference to struct sk_buff
+ *
+ * @skb: struct sk_buff that needs to acquire a reference
+ *
+ * @returns struct sk_buff that has acquired the reference
+ */
+__bpf_kfunc struct sk_buff *bpf_skb_acquire(struct sk_buff *skb)
+{
+	return skb_get(skb);
+}
+
+/**
+ * bpf_skb_release() - Release the reference acquired on struct sk_buff
+ *
+ * @skb: struct sk_buff that has acquired the reference
+ */
+__bpf_kfunc void bpf_skb_release(struct sk_buff *skb)
+{
+	consume_skb(skb);
+}
+
+/**
+ * bpf_skb_peek_tail() - peek at the tail of socket queue (sk_buff_head)
+ *
+ * Note that this function acquires a reference to struct sk_buff.
+ *
+ * @head: socket queue
+ *
+ * @returns pointer to the tail skb (sk_buff)
+ */
+__bpf_kfunc struct sk_buff *bpf_skb_peek_tail(struct sk_buff_head *head)
+{
+	struct sk_buff *skb;
+	unsigned long flags;
+
+	spin_lock_irqsave(&head->lock, flags);
+	skb = skb_peek_tail(head);
+	spin_unlock_irqrestore(&head->lock, flags);
+
+	return bpf_skb_acquire(skb);
+}
+
 __bpf_kfunc_end_defs();
 
 BTF_KFUNCS_START(bpf_crib_kfuncs)
@@ -239,6 +284,11 @@ BTF_ID_FLAGS(func, bpf_inet_dst_addr_from_socket, KF_TRUSTED_ARGS)
 BTF_ID_FLAGS(func, bpf_inet6_src_addr_from_socket, KF_TRUSTED_ARGS)
 BTF_ID_FLAGS(func, bpf_inet6_dst_addr_from_socket, KF_TRUSTED_ARGS)
 
+BTF_ID_FLAGS(func, bpf_skb_acquire, KF_ACQUIRE | KF_TRUSTED_ARGS)
+BTF_ID_FLAGS(func, bpf_skb_release, KF_RELEASE)
+BTF_ID_FLAGS(func, bpf_cal_skb_size, KF_TRUSTED_ARGS)
+BTF_ID_FLAGS(func, bpf_skb_peek_tail, KF_ACQUIRE | KF_TRUSTED_ARGS | KF_RET_NULL)
+
 BTF_KFUNCS_END(bpf_crib_kfuncs)
 
 static int bpf_prog_run_crib(struct bpf_prog *prog,
-- 
2.39.2


