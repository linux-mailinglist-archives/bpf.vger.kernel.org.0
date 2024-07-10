Return-Path: <bpf+bounces-34435-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AC8592D886
	for <lists+bpf@lfdr.de>; Wed, 10 Jul 2024 20:46:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B129E1F2409A
	for <lists+bpf@lfdr.de>; Wed, 10 Jul 2024 18:46:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FABE199236;
	Wed, 10 Jul 2024 18:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="gff9MYaF"
X-Original-To: bpf@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazolkn19011074.outbound.protection.outlook.com [52.103.32.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 596CA199230;
	Wed, 10 Jul 2024 18:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.32.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720637009; cv=fail; b=NSNRas+xhvOkKd7lN/Fgg4YOw7tAbgNumGR+/YEDkdjaQK84vnGy9nD8LVCcPsMfQn32HrrwXvDXGAIt/6Nd700cgtP51eYFKXlbwgBYcdgoC9VceJCzBzt3XscW3xPbeORsFknRkUh5y0EHCb3JKOBx56UUCookuDdCe3Rookw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720637009; c=relaxed/simple;
	bh=BZ+ao6oDtD30qjRDcCY34g+/0uU9zp5HdwclRLhI7EY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MROvgsjPDdzm7NI0LekMUqo0Daa25s3+SN8ADqRtv6LvDrEav96z9nbBfvIVPAlvjgXmVjUGNTW3YQYRyXLPolV2udV8FDmVr6Kurx2mU3SL4JXKRKSdrQGGmbOqFEyK0pw41jMp+T7cCyaGvtvH0mXVznSiaNC9mdoThvA8+EQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=gff9MYaF; arc=fail smtp.client-ip=52.103.32.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PzaZK3Y2FfZZwIz1mMaYnVq9YPiD4MKwNjUeHgiOOVwj+bSXgRVu6yUnDK7n8SRtIKBeALu3cLSg9tbmZswAxqJ9CuA1BCTF5IrHr4OcLGAbVyHjqOAoWQLkLl5NWfbydgrGgMELiQU8K3Y481ojhCh+3++HP3hjzsB1JRmHt4KNwoWeF+Ih4jXIuJhZ/R10Cifsk906/lVH7Z8vrTy9hc2uRFD5jSBVbCfTBfuaLDbTRFbeknlTZPTMsWY+pJm8QJHmZ/ast1F2pEtmwxijqfLB/O7BpgQfBT9bRXR+1qHnPbhJtzDKBkcA9yLvHLbdqAPUY7BRmuMfMMiAzHcVAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qEUp/ew7Ko4H7jVboFNJcm9Y9hE5ozL9AGtg1Unr0io=;
 b=ivtKwXEWa+H70twP2g5GtB2t6YEQIwJdYjSigqt/UvsskW7LTKBVPaEg73NjldwLdLScLWgVq5VHYRJkg61VrJqMNloqwuKPeRLPV1NVBN997u9W1TNoCoYTYGPWYpqPZXgR3FiUC3//P15X9NDLPHqT5P3lXGM3TstVgsdSRk43zx85tFulg0WDgeqlP15/9dfI5f5ruoJ9yE5GbjGyebT9TTn/n5RyvPBwrzH5oVIuBq4Q09VLKZu7fcyLg2n4wcjFrSeo83D742csHk6GPcBr4S3BXQup8OIZfzDBOns3c7DQVHGiZTu9tMa37JywDRAroBZ1CvQPi8GfNF0H3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qEUp/ew7Ko4H7jVboFNJcm9Y9hE5ozL9AGtg1Unr0io=;
 b=gff9MYaFIJ31GMgbB8MdSmJCv+d5MnTveBolr0nj86sewHsKcOBzeO0CnXXsnDdjA0T0sSsZYs2SfghZwszJ8BuhfoTXJhADAi3jEBWm85NAetUXYGo7tiHn6T4mYjESVWnzALbcq04QQb+JbdifliGWrg19VbPqphkOBja/k/TRAE3IpiEN68te0aTJRTYfyu/DakAM4SxE7CXG6eHocoFZubXzvmfdp5T9f6WQu6IcyffRmC3CblMKQhAOQM2nz/1pzGChACg6ICj4GNVqsp7P4nMWMyNiTyK0acKKKBlyxjmJe5KtQbUhgLqEKmoZ2G+faZuPkKajcUgn0uHyxQ==
Received: from AM6PR03MB5848.eurprd03.prod.outlook.com (2603:10a6:20b:e4::10)
 by AS8PR03MB9935.eurprd03.prod.outlook.com (2603:10a6:20b:628::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Wed, 10 Jul
 2024 18:43:25 +0000
Received: from AM6PR03MB5848.eurprd03.prod.outlook.com
 ([fe80::4b97:bbdb:e0ac:6f7]) by AM6PR03MB5848.eurprd03.prod.outlook.com
 ([fe80::4b97:bbdb:e0ac:6f7%6]) with mapi id 15.20.7741.033; Wed, 10 Jul 2024
 18:43:25 +0000
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
Subject: [RFC PATCH 09/16] bpf/crib: Add CRIB kfuncs for getting socket source/destination addresses
Date: Wed, 10 Jul 2024 19:40:53 +0100
Message-ID:
 <AM6PR03MB584831E68265B20D7DA57D4199A42@AM6PR03MB5848.eurprd03.prod.outlook.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240710184100.297261-1-juntong.deng@outlook.com>
References: <20240710184100.297261-1-juntong.deng@outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [JfDxfI3Cpj/ZvVw/PBq76pHGNZmtcN1H]
X-ClientProxiedBy: SI2PR02CA0027.apcprd02.prod.outlook.com
 (2603:1096:4:195::14) To AM6PR03MB5848.eurprd03.prod.outlook.com
 (2603:10a6:20b:e4::10)
X-Microsoft-Original-Message-ID:
 <20240710184100.297261-10-juntong.deng@outlook.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR03MB5848:EE_|AS8PR03MB9935:EE_
X-MS-Office365-Filtering-Correlation-Id: b9260d70-723b-4073-69af-08dca1102e46
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|8060799006|19110799003|461199028|3412199025|440099028;
X-Microsoft-Antispam-Message-Info:
	QT23+QXJl30IR2w9aSowJoGOJFEFfhtjeAR8Q0KK9OeO3gVFunTgUYqec9aK2r9UZMvVPI+pzxjx/O7PQJ1FU+xNgopDlcn3RXqgCwTnY5SqBgA9Tbjn8F2ztENR1+Xes6GRR+D5OQRZGBSOngm4Jih3DGnTq91cuR5nJP1yQCGidiQyIKYvLUmLMyxtEfkVc/h4qmuerEnDA/uCE33taF5Km0Ohk40VrJZ69GjHIl6svThqyBASx1UKHLAwKDnAoxnRDgkJE8ZcNnz0mPnRd6d8f5w7h11gHd1aDwPxEvjbSib+p6WkzgOr7N809YtGxOTvlBmBmhfV/c8+IAtveHzDbNhYtvfpYdy9PAz1t8N5m69mUkP2tE0PH3IE8wLgWpI4MlZ/bTepmymW3GY5zYYKOMz7wkSCOX81UlzRLVsUDK6dBt/6BMpkqdysp67XMVz/Iwk2S2/gzPg7IeWydYEXEi4SIiC4AiYjWvyTBXxHzPT754/QoMm8xaE4PxEH6xpPMbEg3ANhba/PRnL96AiCUlcowFlYNwFZ8TXD5xUHrSr1FXFTuM+BPEFDGL00pmjSe8OWM21dW1xMHwDdPiBSiQl0x7JV5FkXd+58KxroQbD3/oBdOBF/rSf+MSPu4pc0JrhBJsnnhf8FzHGQOQ==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UGqW936WEjkiOWvBvIPUoI4LPenSdjbM2U7ky7wB4/BRMbhCsqefzsBaiqiX?=
 =?us-ascii?Q?HbhGZzTxMcMjB+09tuCYwk4PmG8hFsbo9SQqnHcfkM2KsXPlHnQe+H10BZ5W?=
 =?us-ascii?Q?9ldx3T5yQTLQJRuiinpkinW7Pxx5ppVz3++mdqZhIHw5UGqkmsWTdk9rt1MJ?=
 =?us-ascii?Q?qdra8QuAZIpKplZbDU2RUXQmtyeGX5bf93+yjY4eXduIhTghWFecrR9phWuv?=
 =?us-ascii?Q?KTftK1tuPr5ZXV/7MxYjOyAyiwLjRmiOIAjsgBsgh/kjv/fNMbjemdJKQmOQ?=
 =?us-ascii?Q?Nk8bpL9FuUuzYAhXOKLO06mzVgdP5aHUthMdBuynH3/by6L10uLA1bZmFFw0?=
 =?us-ascii?Q?Myif2iLvORrlExHG7UmOd7SJ8VEiSn78aouIQnRsZqseOmJxNNiIX6oEQTE/?=
 =?us-ascii?Q?cU3zt8wXTYW5aVrcQxuVecDFLmynIra1z48rAuzXuKl3j3BeW3Zz7nMcHbX2?=
 =?us-ascii?Q?7654lc/ZaKF+0MoPfi/ym2IGndHLCdlJGERyT4j3W+21ldMjJr7/vaTlJfNZ?=
 =?us-ascii?Q?q7zlSsHWx8b6hLB0iwNWwTZqks9yTRbnwPQOr7JXbqLnZWyPQp/UOEI6dkVB?=
 =?us-ascii?Q?F7k9XhiUS76koA7NowKPVCeAe4qje2rW7Q/uXKsQcO0ypfPY596pDAUfKbNe?=
 =?us-ascii?Q?7yfdm/nRPpuLz9yFzXOb0v9zEBIVUuQrK9GOPRGdjoL5BGI+fiIzblCaiLNK?=
 =?us-ascii?Q?u1Okm1VgloKJMesQdRpjanDF1lXx+vKrHmNx8EoNqKI+XxepB2uuXajrxCF4?=
 =?us-ascii?Q?czckvo/iu8PD1UuKdzMk2JXSeVhC6RSzo4R5ve6WlgTVclfexGPg0MEJw5D6?=
 =?us-ascii?Q?2InSlVdmxyOwfwoH8sFs9Cx5Ssv2nAUOMoZcMUzDV1+ZGldgWWBJ31GuLemb?=
 =?us-ascii?Q?yF5Y8K4OBvtl/tnM70o2KRQoFLa4gcGBUHxoWvkh/4r38uIy/0eyhtPck/yj?=
 =?us-ascii?Q?leFlZh7nR2KZ0EomV1itK+nAdKwVryhbTsuq/Pp30h81V1sxqpyY0kwi2EJQ?=
 =?us-ascii?Q?kxArgx97iqNbKdBYRwM8DhOjHfUqrObiaXHDNB5S8HMOqXiLTjnTZFw41WoV?=
 =?us-ascii?Q?webBhcXw0F4Uof6WpjcqsuOzkM7mI3rdF1LEfYLhs4g6wiRekcAAPFHlELtA?=
 =?us-ascii?Q?8LA/EXQvyOP68NTS9/ZX71vKYJEyaXU8crRNGq92Kb3S0HgV1p42jihHsufj?=
 =?us-ascii?Q?/s3us9Ny1d7Vr/9DibFkj/e5GCR+/cqtqag/miHbeabsrZjOh26YNZ61b/0?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9260d70-723b-4073-69af-08dca1102e46
X-MS-Exchange-CrossTenant-AuthSource: AM6PR03MB5848.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2024 18:43:24.9788
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR03MB9935

This patch adds CRIB kfuncs for getting socket source/destination
addresses, which are wrappers for inet_getname() and inet6_getname().

Signed-off-by: Juntong Deng <juntong.deng@outlook.com>
---
 kernel/bpf/crib/bpf_checkpoint.c | 50 ++++++++++++++++++++++++++++++++
 kernel/bpf/crib/bpf_crib.c       |  5 ++++
 2 files changed, 55 insertions(+)

diff --git a/kernel/bpf/crib/bpf_checkpoint.c b/kernel/bpf/crib/bpf_checkpoint.c
index 28ad26986053..4d48f08324ef 100644
--- a/kernel/bpf/crib/bpf_checkpoint.c
+++ b/kernel/bpf/crib/bpf_checkpoint.c
@@ -8,6 +8,8 @@
 
 #include <linux/bpf_crib.h>
 #include <linux/fdtable.h>
+#include <net/inet_common.h>
+#include <net/ipv6.h>
 
 extern void bpf_file_release(struct file *file);
 
@@ -98,4 +100,52 @@ __bpf_kfunc void bpf_iter_task_file_destroy(struct bpf_iter_task_file *it)
 		bpf_file_release(kit->file);
 }
 
+/**
+ * bpf_inet_src_addr_from_socket() - Wrap inet_getname to get the source
+ * IPv4 address and source port of the specified socket
+ *
+ * @sock: specified socket
+ * @addr: buffer
+ */
+__bpf_kfunc int bpf_inet_src_addr_from_socket(struct socket *sock, struct sockaddr_in *addr)
+{
+	return inet_getname(sock, (struct sockaddr *)addr, 0);
+}
+
+/**
+ * bpf_inet_dst_addr_from_socket() - Wrap inet_getname to get the destination
+ * IPv4 address and destination port of the specified socket
+ *
+ * @sock: specified socket
+ * @addr: buffer
+ */
+__bpf_kfunc int bpf_inet_dst_addr_from_socket(struct socket *sock, struct sockaddr_in *addr)
+{
+	return inet_getname(sock, (struct sockaddr *)addr, 1);
+}
+
+/**
+ * bpf_inet6_src_addr_from_socket() - Wrap inet6_getname to get the source
+ * IPv6 address and source port of the specified socket
+ *
+ * @sock: specified socket
+ * @addr: buffer
+ */
+__bpf_kfunc int bpf_inet6_src_addr_from_socket(struct socket *sock, struct sockaddr_in6 *addr)
+{
+	return inet6_getname(sock, (struct sockaddr *)addr, 0);
+}
+
+/**
+ * bpf_inet6_dst_addr_from_socket() - Wrap inet6_getname to get the destination
+ * IPv6 address and destination port of the specified socket
+ *
+ * @sock: specified socket
+ * @addr: buffer
+ */
+__bpf_kfunc int bpf_inet6_dst_addr_from_socket(struct socket *sock, struct sockaddr_in6 *addr)
+{
+	return inet6_getname(sock, (struct sockaddr *)addr, 1);
+}
+
 __bpf_kfunc_end_defs();
diff --git a/kernel/bpf/crib/bpf_crib.c b/kernel/bpf/crib/bpf_crib.c
index da545f55b4eb..e33fa37f8f72 100644
--- a/kernel/bpf/crib/bpf_crib.c
+++ b/kernel/bpf/crib/bpf_crib.c
@@ -234,6 +234,11 @@ BTF_ID_FLAGS(func, bpf_receive_queue_from_sock, KF_OBTAIN)
 BTF_ID_FLAGS(func, bpf_write_queue_from_sock, KF_OBTAIN)
 BTF_ID_FLAGS(func, bpf_reader_queue_from_udp_sock, KF_OBTAIN)
 
+BTF_ID_FLAGS(func, bpf_inet_src_addr_from_socket, KF_TRUSTED_ARGS)
+BTF_ID_FLAGS(func, bpf_inet_dst_addr_from_socket, KF_TRUSTED_ARGS)
+BTF_ID_FLAGS(func, bpf_inet6_src_addr_from_socket, KF_TRUSTED_ARGS)
+BTF_ID_FLAGS(func, bpf_inet6_dst_addr_from_socket, KF_TRUSTED_ARGS)
+
 BTF_KFUNCS_END(bpf_crib_kfuncs)
 
 static int bpf_prog_run_crib(struct bpf_prog *prog,
-- 
2.39.2


