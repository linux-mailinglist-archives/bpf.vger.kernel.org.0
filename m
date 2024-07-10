Return-Path: <bpf+bounces-34436-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A619492D888
	for <lists+bpf@lfdr.de>; Wed, 10 Jul 2024 20:46:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2AD181F2437B
	for <lists+bpf@lfdr.de>; Wed, 10 Jul 2024 18:46:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1BD119754D;
	Wed, 10 Jul 2024 18:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="ruyxM49b"
X-Original-To: bpf@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazolkn19011022.outbound.protection.outlook.com [52.103.32.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92E5619924E;
	Wed, 10 Jul 2024 18:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.32.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720637015; cv=fail; b=W0E8+rasyEumMeZG5T4dKQCIS3Gr7LdugHvtW/ySgjQCJcC2qfA+LJJ9SRyWch5c5HxmFAE3rIAyxbAkOqQEKhQlNhU/0touNKKCD1kuD2vTvGBfuJ2xjaSdlPDgFLsJgZ0GzD+DfL5r0KxTYUzfbKvDG9R8LiDuhZ/OLxRcSac=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720637015; c=relaxed/simple;
	bh=HQFydNqnDpEVEqqyYpysIENwzRq083Ki37ql3puGGEU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Lax40pIK0fqC0FsSzO4/HVt1287vn9LsNUVqWCTNSEw3vaLTYfiwtb3X4jaYoxOoRa2hE+bHwA0mC0sqNUARnUDGFwozapbdYdBanGX+BvaFsW2buU4MEa4nOCQQ+EE3JnljsqIo7oqY6kf+ZAUqi9EQZgUBF+To9a0ArNJir3M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=ruyxM49b; arc=fail smtp.client-ip=52.103.32.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fTxKjLlX+aImEvcYu45ks+wSdeNmvLI5HHU3zcnPdyyEKMsYXx1RJriPzYjkQuPN0JuIITRUkWBvXIdTfQnqeyZISKYRGg63yQPuUPs5L9+HS/0mAYG0Vy6BbynpigjcBWLo7iALkxLD5f5AOgnrH+AxMXl8dzB/ebQRhjWeIBYsWZfEAohGrT2Nk97qZlNSevsTUXnBLUPZKEc32Dnd4V6FGmfbcplZcn8AYivN2w/sw9T+nEbhJqwrfwZtwMWB4oHWwU02a1Id/bf67Tw3ln8ZJx0WZBz6BjfvWF9O3g0eZJd1N2L1ylSlOTeqggPEdFwLLpVzlWbmi+IngLo4PQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T5nHZceVkH3kpV0UIy7v/XCBmKwfmdeJyMCpuufML9E=;
 b=MWLdg9Xbm1brCdDrabsRfxEeDxBZsvwSE8Lhx0+xrri6+niGwe2wKybkT2EKkyv9KRZED4hx9HBEeSqniYvScGgGcmKqWa6T2Xsb+C4HLSISVi25QX0womvsGrjwOqnYf6KoGcIMhe1URmYM6tkkC4HEP42w0uifDnGtUch6nAaqjI2vMiSetbYlSqUqlzLfqFNyISomrQFILarBEOy880JY1EK3HvSctoBNG5crnp4WpygLiq4YNaWnT6/LS0DMpqIFZpOEOY9gjna+bZeRxqwK4BXTnW5h3RsGNbG3MiwoLFQTitwLQ9X7FcaSoXGJxRrH3Y7p582xvC6fYDTn5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T5nHZceVkH3kpV0UIy7v/XCBmKwfmdeJyMCpuufML9E=;
 b=ruyxM49bUBBVe1ohWdMMG7Ojmr7JQMdGCVnG0B1QGZEG9/Yu3ze3W0XYiqsuEw+Bq8d6VXs7wdHvfMQUB12comIa1uHomB5XAKYGEtSaflY5fjwUPQfoHYX1BXB2OjK0STNsfXm8uOtslWLzmvjYfqz9GZ9G4R+QyUtxG3ppVDfqi/yudqXzlAdk0YJenPdo9Q9kp1+wMm9cipA5uyfkYQlNXDt2M7xmMcPw0NAdzafDxgJBu5mVXcTmOm468T4S4zF6eyT70IXbnX+exAfYpheAyKqWGEuhXGEnf+/4U6W6xe4CIsMqVEp5ML4Wqd/YX381VVyGzaL/Ps96bsyniQ==
Received: from AM6PR03MB5848.eurprd03.prod.outlook.com (2603:10a6:20b:e4::10)
 by AS8PR03MB9935.eurprd03.prod.outlook.com (2603:10a6:20b:628::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Wed, 10 Jul
 2024 18:43:31 +0000
Received: from AM6PR03MB5848.eurprd03.prod.outlook.com
 ([fe80::4b97:bbdb:e0ac:6f7]) by AM6PR03MB5848.eurprd03.prod.outlook.com
 ([fe80::4b97:bbdb:e0ac:6f7%6]) with mapi id 15.20.7741.033; Wed, 10 Jul 2024
 18:43:31 +0000
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
Subject: [RFC PATCH 10/16] bpf/crib: Add struct sk_buff related CRIB kfuncs
Date: Wed, 10 Jul 2024 19:40:54 +0100
Message-ID:
 <AM6PR03MB58481BA6D59599AD7438B4EA99A42@AM6PR03MB5848.eurprd03.prod.outlook.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240710184100.297261-1-juntong.deng@outlook.com>
References: <20240710184100.297261-1-juntong.deng@outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [5RMbQ5sfUP8c0lp1GsFryvoPtvWlVvsg]
X-ClientProxiedBy: SI2PR02CA0027.apcprd02.prod.outlook.com
 (2603:1096:4:195::14) To AM6PR03MB5848.eurprd03.prod.outlook.com
 (2603:10a6:20b:e4::10)
X-Microsoft-Original-Message-ID:
 <20240710184100.297261-11-juntong.deng@outlook.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR03MB5848:EE_|AS8PR03MB9935:EE_
X-MS-Office365-Filtering-Correlation-Id: c2e4a7e0-7088-4ea3-80d4-08dca11031ea
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|8060799006|19110799003|461199028|3412199025|440099028;
X-Microsoft-Antispam-Message-Info:
	q1XQ8E+V/T9uX7cBeSdsClKnh4on20C9y0Qzcxinp3kasoEhJolgJL+5PVSdv15/hHE/850KFcw34TIeupPa7yjM391ltVxTJfKnHQL7AejLxN/QggMz9Zf1pzO40TPC33HjW6iPK3vvc1PESoiW6gc9iXF853JRmnLcYtAz/B7ltb2B39xoagMxRRPUeAiceB39pHoxDpu6s4aCk9sRTSfSobOJ1rK8NqObYH9j+OeZJLA6M0i4w6Or/yh7li0BSNliaZS+BBDJsBuRj2ujihIhNPZd53YDNhC4zWZXM7b7S20V4oQ6EDwlKbO4ehzY6QkfWLpERbY4FKOJATFRfrGaXdCrT6R7BK8ycub8RMxIhkn9DUFrHflUfp0SOZkj7hjkn0+idyjnWzKiscS1JDA0MdX/hRBUYb4zGkZfcMJwnxwQIFruULi9Vrifg0Va7AvBIbG+aBXoU8LZxQR3fLgzcFT6a6dUUOZEaBDgmDJUrfk+vJGw+pNujln9mdIwJ/znKzkB5iYEYQOnYwSzEK5pOR667aqVs9Zif7txNnKGID1jBUJkBrtq9hOJYkrRGaCk/sV0bIZr2zF6dnws6oNulrKcsJ6581dO1aJ8gX+5yiMr5oA/XhQw8TxUlBaS14Fs5ochy7loVQ14q982bg==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7PM5Dt4Cy+NIGng6n9SZwvFj6I5spQR0tDh9Vfjc3ki5rmPrsECV1/8qT9Ai?=
 =?us-ascii?Q?VKVGVLVDv188pVpdjF+QHYjBGdAQgR5EIXCOOOjrWXQWJ0E5r0hjlDm58x40?=
 =?us-ascii?Q?Nv8KnkR7GHBnp1RCrAZMcQmkRNWBvWPDA3NwNGAEETvyhPFJg1EtasLgeNTa?=
 =?us-ascii?Q?eKchs5uhvUxFG+Pag0xZBFtfbfuGG4lv/HyKmCbNLUy/vtQHMkLWvpJmYdg2?=
 =?us-ascii?Q?jxwcrTuKWHgJiSuvd/u90rANqgfa9AXzZ+2mNuazi+Ab6qPo0o7ertMk8329?=
 =?us-ascii?Q?AC0UUpapDK9pG6LM7zv4pF0eLK7bcBvkz/TOXd8Qj807p12oj46Sg0uLPoG3?=
 =?us-ascii?Q?0kLqtTZSIp0q/pLlVLg7y2W9tztPnLVFPMK7MD6OxlVoDDWMpbfoXktMCtfa?=
 =?us-ascii?Q?dUJpxCyPST0rIDHmLMDCVPNQZD8tpHHReV7IUy1aNtWNlOIEzEjvyTXkXzzs?=
 =?us-ascii?Q?LOyx3XnH2sBhew4YJ8mFm4jNTFqNIIIW82yU/+naz9Izt5pS4fYcfNdbUagP?=
 =?us-ascii?Q?hOhoV4Tre0OiTbhittwBEVDJy6DRVIfldqmsbckcjbSziMtZN22laF0m4Ske?=
 =?us-ascii?Q?pwRkUVsykq7YfpC4lh1FIXDCiVQx81C/sdN3G3wG1iC8oOeHKnyOG78N68xX?=
 =?us-ascii?Q?9EVC0/DMlixXbYy5BTStuE2ckBEOgwgqJu9KK9MZlHeQCH6XZTuOohZrV9hI?=
 =?us-ascii?Q?4N49JVRpRXu016Ub0d4GFqfNjsCKppMlhgSQ/zlU++fJXFrAioOF4zqZhk4k?=
 =?us-ascii?Q?e4dShWuV/VFpZSi4SmjxJaRw1G/OFweqIe73aiffY7dZvjytdGBYbyK8JUua?=
 =?us-ascii?Q?URhsmDLgIIwGKXLby9/b4sNN+BWMFf9UqHMY4PlAeoD+izk+NH3hF/LNMlsw?=
 =?us-ascii?Q?ZCEy16kSr2KSZqfnQFWvuuTnvaL+IqLkx+PfhsvFQ1TK5dXnjaK8ukfAIUOr?=
 =?us-ascii?Q?ALSl6zKChgxW80HNhtiw/wK1t6gPvnFx+Q1M8GvelPKt0u0ykHD6XvaFlxos?=
 =?us-ascii?Q?Vg968YMYGwx7/onB8sT5pUMMzUEgrkHVtqh65YI6a9BV+zZ9vkzL6kKLZ+Ks?=
 =?us-ascii?Q?GUHE2qy8JdyqMB0NF3/tpo/fgpZi666HuU5nIGJdLW/E8drNdJtpG+aEFWdt?=
 =?us-ascii?Q?0hAz/fomkCh8nZNFHPTU9sXXvzgkyUZHSPbiFIcUMap/FayQPsB8/RdU4sTm?=
 =?us-ascii?Q?WrM6NDmYUadTOZ538+mk8/x2Ti79vZTW08rZbXEnmotSXiv44w3jvlYIRVc?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2e4a7e0-7088-4ea3-80d4-08dca11031ea
X-MS-Exchange-CrossTenant-AuthSource: AM6PR03MB5848.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2024 18:43:31.1665
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR03MB9935

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


