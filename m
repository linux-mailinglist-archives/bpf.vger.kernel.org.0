Return-Path: <bpf+bounces-34552-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 787FA92E6A2
	for <lists+bpf@lfdr.de>; Thu, 11 Jul 2024 13:29:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2ADBA28274B
	for <lists+bpf@lfdr.de>; Thu, 11 Jul 2024 11:29:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CC3916DC15;
	Thu, 11 Jul 2024 11:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="H/5TQ/Jd"
X-Original-To: bpf@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazolkn19011023.outbound.protection.outlook.com [52.103.32.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7CFE16DC09;
	Thu, 11 Jul 2024 11:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.32.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720697051; cv=fail; b=S39ZKKiA2vALNVK8uABLp+1PEWUKg9/6dXeTSiNiHesmryjRVkBqmOhLl6dWoPcXWTQ2hgVvzD+xGXvIrxrjczLM7nxGKtObLU2yoyxa8/ODGQ88TsVC7I5PCQSvjmap3Y+Q1E6vGoK5bVhlDfzcZm7NigR/UtmP5fEVSBpJS3o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720697051; c=relaxed/simple;
	bh=b4E7pEvHSlooW5kM/GHXqHjYvTC2iOpkyNSk6ILcu44=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lIR3Mr74FdWwU6bUsy68oHH4+0t0KK0BPEv1dyuWOYsBz7ipZ1JFGiAQzmLITgV73HMK53lIvUNgLYi4OH9c84MQ3d58OrwHd0ZlEabkQ+A5np44nvOp3sZY1D1ytslkQuG/O9G2XweVcsmpsZfTkKQLuGGaXf0tv+ujEgPv8Rc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=H/5TQ/Jd; arc=fail smtp.client-ip=52.103.32.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Eu5FlWyI6aNducMcHDgcFqSIwCMMSoK34Ee9jgzujCouJhdJY6fTdqp36JsxOV0e0ThqVt8Z1TPKOOGHh54XZGwbsyFq032gfhm06h8hyY/42tfBZvFUz7POEDe8FpQQIiQEdO5q2WymkNMTMqWiW80BquYxsVlvraR4ihLN7MujL5vHzp8UheAo6MobBTDNmxOUUgV8q0e5IghWe8ySVwFhqlizHjCNiZyf9sN+9YDKbeerUXcBqJgf6iZosMDu3mi5GCbSG+4bqHb10i6hAB7OAsiHkMuCgLU8tdUXU6/kc1AQwvgX15ntJXDnumdeAcwlUNZlV0VJcAzbqCxp3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j6i4MicK2b/3Q7z+U/fTVZjgwdZKerVi+nFpvOSivug=;
 b=vnNN3dFx10axH3O9vsERrzDlTWpt+veC3RHSCLE2zDCeV2EFpsM6BRios+bhD0CsiHeWjpteNcP3Fp4ruajvBJLEjYZ0v2bjz3RH/w9D2s9QY0tHRQ+rycVLCxST08PhyMgQqXCPXtRGAWFX94dnzecGVXCjHErSZYo4Mrv5vZHBJO++RE0X1gFww13iXuY/ydVOio/RVTl8VDFrmzAJki/0P2TU8KwPKYPn7wmg2PJnrVsGK1cBoPbpD78xi+LpHt2x6aq4qBeGlYyHFz17op+xUeJJvWCFcfiQz2vrO5ypVpDd6jHMZlfVaH9oErqh1ovMxnGxXjKwsZ8Ccd7vHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j6i4MicK2b/3Q7z+U/fTVZjgwdZKerVi+nFpvOSivug=;
 b=H/5TQ/JdYQqvJOme/xD1hpuQnL2LThurjwTKyC8R6OhqgdpbQQfS1j+Xrjc+TjchwkC7fn/q4apcBwrEAxD+vBsUTt1EKLdvNizmUej/mZbTdlzpTDtxgTYro2cHIGjmtnzCsgAQmw0EiCQxvFCyzxoThS4N2zjrXp8p1Rj9dEXEFYkwgrSwGWgTzYC+/L90bfFD+L4hzlO69HTs4nADFvBxJWopvtFxumyqXuzxgyCJUgOCf0K1eAojsRvrHHei5zXZ+irdnTxQt7zHlz7M79FpiIRJQJtCJjltuiq33xZJEnAz4/BVlbbRIF2RiaUKhicxEGgbCqdJIfIIM5URVw==
Received: from AM6PR03MB5848.eurprd03.prod.outlook.com (2603:10a6:20b:e4::10)
 by GV1PR03MB10233.eurprd03.prod.outlook.com (2603:10a6:150:166::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Thu, 11 Jul
 2024 11:24:06 +0000
Received: from AM6PR03MB5848.eurprd03.prod.outlook.com
 ([fe80::4b97:bbdb:e0ac:6f7]) by AM6PR03MB5848.eurprd03.prod.outlook.com
 ([fe80::4b97:bbdb:e0ac:6f7%6]) with mapi id 15.20.7762.020; Thu, 11 Jul 2024
 11:24:06 +0000
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
Subject: [RFC PATCH bpf-next RESEND 12/16] bpf/crib: Introduce skb_data open-coded iterator kfuncs
Date: Thu, 11 Jul 2024 12:19:34 +0100
Message-ID:
 <AM6PR03MB5848DE102F47F592D8B479E999A52@AM6PR03MB5848.eurprd03.prod.outlook.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <AM6PR03MB58488045E4D0FA6AEDC8BDE099A52@AM6PR03MB5848.eurprd03.prod.outlook.com>
References: <AM6PR03MB58488045E4D0FA6AEDC8BDE099A52@AM6PR03MB5848.eurprd03.prod.outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [kpVB+rpQiObCfYHj3B1EGxfjQH2TzM0w]
X-ClientProxiedBy: SI2P153CA0031.APCP153.PROD.OUTLOOK.COM (2603:1096:4:190::7)
 To AM6PR03MB5848.eurprd03.prod.outlook.com (2603:10a6:20b:e4::10)
X-Microsoft-Original-Message-ID:
 <20240711111938.11722-12-juntong.deng@outlook.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR03MB5848:EE_|GV1PR03MB10233:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b337eac-ff48-4019-977f-08dca19bfa03
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199028|19110799003|8060799006|440099028|3412199025;
X-Microsoft-Antispam-Message-Info:
	4cUlS8i4ltiDBk1uHBVMkGbdoxuMq9jpNLQZ6Ku3MOSWnyZJEY5GUXgOjagKLY9UKVjUbX9cwDE4W5CYY95fL+mb/ggC6xSR6/VKPxyr4Djt/pma/ZraKvDuWtHV02dQSA4HBcwAlhb/xxHDFa+SwKLn+q9/MQACeiLJyq0DwzUdAwqsSPGPOzXjC7/64h6CpcGoUt4GlG2cE1FXW2jjdFsyLaKc3K+MvdZmpeWs6cZvbltjXTDT7cLb3d1/N/1XjVoOt8TQxUkFQUonw+j1kbK2tMq3oxs4Pk6jwPksKcEjT4P/JoLh9Chh0rbJpBLDAQlLCX9jjO215ujYFDOwAPM1y0g7RwFjt8uGzGE1XKCB2BfFlvvfgxFV+HP5jwXBjorh0pD3JR35iFRat859S5UFd13O1SAB10fcO/VnM81yuDxNz6twu03vsC1bEU08Y2y24higx85O4N55bpsTz0nZ+zTKPZEZMGFqPX+FWeNa7bh35870cg1g2xTFNhA3oBQK48UE5+uY9RDTeHNmjd+sab5AV8hdP2yQZAUtHqkY9cwAInIpm5p/m03ZDmrSX5CUkJku8BTNW7nhOpB+rI2bdMAU61mDiuumNDind5eZHB7TeRFuUqrJgvT2Wk7XuMNZyZTcMSU9b9z2mK5OIQ==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?F7LM5oCYxGMHhT2CscgwZxu1bmBZXPdRkdgbyHHSs9+Guf7G1tiqKX4Mccx4?=
 =?us-ascii?Q?tUndXcgKkuEuIT8NzYVHm9C8oNdIIUfUKWV5U+zSvyoLGhnDAzCRZHHHMLd8?=
 =?us-ascii?Q?gVJEAj9bIUkkWL7qJlmnzcfa5QTD6teJ6ex1I0vCVZgYwBo4jF+z+dJ9ylaB?=
 =?us-ascii?Q?Turks42xXm4Z/+nFuUax7J52O0AJyMi5PZACZFyEQmqwFSyHsPaFd/xoIxF8?=
 =?us-ascii?Q?YuLNkTuZtip+0EiFTamhB2HV4e97adbQVwzxzYeF/DNIKt0aHaUIxKABhoVe?=
 =?us-ascii?Q?i5kmttcH865l8FBsQQWC10oZ4swiKyZHYoSRSzDGfMuUqh13Ik6GC1oXwfIa?=
 =?us-ascii?Q?QlouGTQhtc+eNzUxiwmYe3+AUNwxg291MQmzk1yuYT7i3pBZMZ37ZoDC8YI7?=
 =?us-ascii?Q?4B1woQUwE6eRwgdVrHBq4g4g+hEFwiQxxWJ6+aevyqevyP1e3ZeYa8wDc5v4?=
 =?us-ascii?Q?xrDuQDWSHdPBGPA+TM6gfDLCfqrr3YLWoUQvSl5+2h5DDVjYIFmcFSFyZSjJ?=
 =?us-ascii?Q?qB2rLf3erOXtDr0AX5Lj2qdsbYAB3smdk0Z82W6n1hFGyGYImA4scjjoFc/v?=
 =?us-ascii?Q?yvxJHd7U8zOBOVVYf/mtQ/+mrSrh7+AxduS4LEwUS8zgL6UfxWdX8L0QY/w1?=
 =?us-ascii?Q?CMmy+zQKGo2DDB8S8128QxysI8H8F1SRWU0Bk7OThPbfwCFF1Luq7TSJ/WuY?=
 =?us-ascii?Q?ZGLejO1rh0zuZNg1nk/weZeq4borSiQYZCNorjmE0w5NL3gktuzxoxNax/JO?=
 =?us-ascii?Q?hNdZAm2niTvZtqCLHiEC67lwkk0fz3hxPdD+b+5xk2jWiTmzWWUykLW0Qgn/?=
 =?us-ascii?Q?SRrn3Nb8Ak4chU1Z73AMDV/HJAAkOSf7wLcK/xczidzzGug33BYs8SSUT85d?=
 =?us-ascii?Q?sysQabXwPSwQ/Wt5Rc8oDKmT+e2B8WOM7qz1tU0xTADYYpuZeQh6/mu66zLL?=
 =?us-ascii?Q?9V/GOT6j425EDO7Sm6+KZv2y2f+rVVTiWvj8k0PZwwSyOUd/Z+I6ffzWiQFc?=
 =?us-ascii?Q?5bT3xPISWkUuixnACv2fsLZiCryeWvjWRZpLY+ih+2IU+/JQZu1MVWgHZS+a?=
 =?us-ascii?Q?WJ/vgvxzgoHBFHCfKq9E9jB7RgsCjVt+NbqTYKg+OMqJ3LXXrvgS72NFu2q1?=
 =?us-ascii?Q?ACEYrtGQssJtLf+xo1muyk4Uqi1TSWC4UF0Ox8SItk8gg7/uQ7AaNtvE28OX?=
 =?us-ascii?Q?RnFbL1BMvPQ0HNkWziuyi8fjiysvaFcik5KQdE7GquMcgRoHKowKRxmvuWo?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b337eac-ff48-4019-977f-08dca19bfa03
X-MS-Exchange-CrossTenant-AuthSource: AM6PR03MB5848.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2024 11:24:06.8556
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR03MB10233

This patch adds open-coded iterator style skb data iterator kfuncs
bpf_iter_skb_data_{new,next,destroy} that iterates over all data in
the specified skb (struct sk_buff).

This iterator is designed for checkpointing, and thus iterates over
all data in the skb (starting with head), not just application-level
data (starting with data).

Each iteration (next) copies the data to the specified buffer and
updates the offset.

The skb_data iterator has two getters
bpf_iter_skb_data_get_offset()/bpf_iter_skb_data_get_chunk_len(),
which are used to get the offset/the size of the chunk read in the
current iteration.

The skb_data iterator has a setter bpf_iter_skb_data_set_buf(),
which is used to set the buffer and the size of the buffer for
dumping the skb data during iteration.

Signed-off-by: Juntong Deng <juntong.deng@outlook.com>
---
 include/linux/bpf_crib.h         |  14 ++++
 kernel/bpf/crib/bpf_checkpoint.c | 116 +++++++++++++++++++++++++++++++
 kernel/bpf/crib/bpf_crib.c       |   7 ++
 3 files changed, 137 insertions(+)

diff --git a/include/linux/bpf_crib.h b/include/linux/bpf_crib.h
index e7cfa9c1ae6b..c073166e60a0 100644
--- a/include/linux/bpf_crib.h
+++ b/include/linux/bpf_crib.h
@@ -32,4 +32,18 @@ struct bpf_iter_skb_kern {
 	struct sk_buff *skb;
 } __aligned(8);
 
+struct bpf_iter_skb_data {
+	__u64 __opaque[5];
+} __aligned(8);
+
+struct bpf_iter_skb_data_kern {
+	struct sk_buff *skb;
+	char *buf;
+	unsigned int buflen;
+	int offset;
+	unsigned int headerlen;
+	unsigned int size;
+	unsigned int chunklen;
+} __aligned(8);
+
 #endif /* _BPF_CRIB_H */
diff --git a/kernel/bpf/crib/bpf_checkpoint.c b/kernel/bpf/crib/bpf_checkpoint.c
index c95844faecbc..5c56f1cbf3c8 100644
--- a/kernel/bpf/crib/bpf_checkpoint.c
+++ b/kernel/bpf/crib/bpf_checkpoint.c
@@ -241,4 +241,120 @@ __bpf_kfunc void bpf_iter_skb_destroy(struct bpf_iter_skb *it)
 		bpf_skb_release(kit->skb);
 }
 
+/**
+ * bpf_iter_skb_data_new() - Initialize a new skb data iterator for a skb
+ * (sk_buff), used to iterates over all skb data in the specified skb
+ *
+ * @it: new bpf_iter_skb_data to be created
+ * @skb: a pointer to a sk_buff to be iterated over
+ * @buf: buffer for dumping skb data
+ * @buflen: buffer length
+ */
+__bpf_kfunc int bpf_iter_skb_data_new(struct bpf_iter_skb_data *it,
+		struct sk_buff *skb, char *buf, int buflen)
+{
+	struct bpf_iter_skb_data_kern *kit = (void *)it;
+
+	BUILD_BUG_ON(sizeof(struct bpf_iter_skb_data_kern) > sizeof(struct bpf_iter_skb_data));
+	BUILD_BUG_ON(__alignof__(struct bpf_iter_skb_data_kern) !=
+		     __alignof__(struct bpf_iter_skb_data));
+
+	int headerlen = skb_headroom(skb);
+
+	kit->skb = skb;
+	kit->headerlen = headerlen;
+	kit->offset = 0;
+	kit->chunklen = 0;
+	kit->size = headerlen + skb->len;
+	kit->buf = buf;
+	kit->buflen = buflen;
+
+	return 0;
+}
+
+/**
+ * bpf_iter_skb_data_next() - Dumps the corresponding data in skb to
+ * the buffer based on the current offset and buffer size, and updates
+ * the offset after copying the data
+ *
+ * @it: bpf_iter_skb_data to be checked
+ *
+ * @returns a pointer to the buffer if further data is available,
+ * otherwise returns NULL
+ */
+__bpf_kfunc char *bpf_iter_skb_data_next(struct bpf_iter_skb_data *it)
+{
+	struct bpf_iter_skb_data_kern *kit = (void *)it;
+
+	if (!kit->buf || kit->buflen <= 0)
+		return NULL;
+
+	if (kit->offset >= kit->size)
+		return NULL;
+
+	kit->chunklen = (kit->offset + kit->buflen > kit->size) ?
+			kit->size - kit->offset : kit->buflen;
+
+	skb_copy_bits(kit->skb, kit->offset - kit->headerlen, kit->buf, kit->chunklen);
+
+	kit->offset += kit->chunklen;
+
+	return kit->buf;
+}
+
+/**
+ * bpf_iter_skb_data_set_buf() - Set the buffer for dumping the skb data
+ * during iteration
+ *
+ * @it: bpf_iter_skb_data to be set
+ * @buf: buffer
+ * @buflen: buffer length
+ */
+__bpf_kfunc void bpf_iter_skb_data_set_buf(struct bpf_iter_skb_data *it, char *buf, int buflen)
+{
+	struct bpf_iter_skb_data_kern *kit = (void *)it;
+
+	kit->buf = buf;
+	kit->buflen = buflen;
+}
+
+/**
+ * bpf_iter_skb_data_get_chunk_len() - get the size of the chunk read
+ * in the current iteration
+ *
+ * @it: bpf_iter_skb_data to be checked
+ *
+ * @returns read size in the current iteration
+ */
+__bpf_kfunc int bpf_iter_skb_data_get_chunk_len(struct bpf_iter_skb_data *it)
+{
+	struct bpf_iter_skb_data_kern *kit = (void *)it;
+
+	return kit->chunklen;
+}
+
+/**
+ * bpf_iter_skb_data_get_offset() - get the offset of the chunk read
+ * in the current iteration
+ *
+ * @it: bpf_iter_skb_data to be checked
+ *
+ * @returns offset in the current iteration
+ */
+__bpf_kfunc int bpf_iter_skb_data_get_offset(struct bpf_iter_skb_data *it)
+{
+	struct bpf_iter_skb_data_kern *kit = (void *)it;
+
+	return kit->offset - kit->chunklen;
+}
+
+/**
+ * bpf_iter_skb_destroy() - Destroy a bpf_iter_skb_data
+ *
+ * @it: bpf_iter_skb_data to be destroyed
+ */
+__bpf_kfunc void bpf_iter_skb_data_destroy(struct bpf_iter_skb_data *it)
+{
+}
+
 __bpf_kfunc_end_defs();
diff --git a/kernel/bpf/crib/bpf_crib.c b/kernel/bpf/crib/bpf_crib.c
index fda34d8143f1..462ae1ab50e5 100644
--- a/kernel/bpf/crib/bpf_crib.c
+++ b/kernel/bpf/crib/bpf_crib.c
@@ -293,6 +293,13 @@ BTF_ID_FLAGS(func, bpf_iter_skb_new, KF_ITER_NEW | KF_TRUSTED_ARGS)
 BTF_ID_FLAGS(func, bpf_iter_skb_next, KF_ITER_NEXT | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_iter_skb_destroy, KF_ITER_DESTROY)
 
+BTF_ID_FLAGS(func, bpf_iter_skb_data_new, KF_ITER_NEW | KF_TRUSTED_ARGS)
+BTF_ID_FLAGS(func, bpf_iter_skb_data_next, KF_ITER_NEXT | KF_RET_NULL)
+BTF_ID_FLAGS(func, bpf_iter_skb_data_set_buf, KF_ITER_SETTER | KF_TRUSTED_ARGS)
+BTF_ID_FLAGS(func, bpf_iter_skb_data_get_chunk_len, KF_ITER_GETTER)
+BTF_ID_FLAGS(func, bpf_iter_skb_data_get_offset, KF_ITER_GETTER)
+BTF_ID_FLAGS(func, bpf_iter_skb_data_destroy, KF_ITER_DESTROY)
+
 BTF_KFUNCS_END(bpf_crib_kfuncs)
 
 static int bpf_prog_run_crib(struct bpf_prog *prog,
-- 
2.39.2


