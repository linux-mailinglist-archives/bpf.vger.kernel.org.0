Return-Path: <bpf+bounces-34438-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C7B292D88D
	for <lists+bpf@lfdr.de>; Wed, 10 Jul 2024 20:47:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 20A2F1F2443B
	for <lists+bpf@lfdr.de>; Wed, 10 Jul 2024 18:47:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCBC9199E83;
	Wed, 10 Jul 2024 18:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="fkEMjE7f"
X-Original-To: bpf@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazolkn19011017.outbound.protection.outlook.com [52.103.32.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AC08198A2C;
	Wed, 10 Jul 2024 18:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.32.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720637030; cv=fail; b=ASF6LwRKNQCrvHjxBhE9uwiLSGiUZ7v+wGBhfL22p6RaU3vxaBZ3fvr9z0x6fpktyNozY55QKi5JQtRBWff8DZZu7KudF2SYSshlwmMMN9P6lnVwar7txxej1GvwQ7YTbHFrcMc4mtzQdRE4uKyWk+dH18sYLCZKSgx6FHAy8Nc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720637030; c=relaxed/simple;
	bh=b4E7pEvHSlooW5kM/GHXqHjYvTC2iOpkyNSk6ILcu44=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=D0qa4DKnZrpyshh+ihZxWxYeB1bkH2CZvaeu39oXyHKKgfTVUezR2Q4sNatPJ8t9r7l/zXOgZiL+1YhoJMdWOaEXwcyIzBV8AYKpaMpx6zTHAc39xHsBKAQE3Z942UfudU12rgbP8KG0zgL+t/hAodapCONhsM3yXMPHPeG/eR8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=fkEMjE7f; arc=fail smtp.client-ip=52.103.32.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nXJdvDQEToPzGc3vFucEZatch2RyscTjeVbYbIIASgZmPqv54ZixUag8lIBsB1HPLpr+8Er1IydbnAAG2qnBmUbEBMl137NjiPAqejKNoUqWcaw2shJI96sGzfPzpScEZx9JyJxubPXM5bciUCLtOhAjg7lPL1jgfc4cWph6TaOe4xqkfDRvVbU/rR6/04vTjFImfvGO+A5r/DVEpE8HzJiQGbJiZamDyr6tfjUJN2s5dzWwrx3LDEAr63t/fT320Y7GoRb17CkisJcChElHPjq1h2Vqu7LQ3gWOERJmFAnO82UjV5+CV8nk/h2Sq9vJndlNmZmK1dP3iqdJnT+a8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j6i4MicK2b/3Q7z+U/fTVZjgwdZKerVi+nFpvOSivug=;
 b=nj0UqJ6AXhWKqIKGM7yx5awRzB4T2rx+3RxLwSs8/RsaVy3DsCcRn4O1YNwRY4K+eYUuFde8YdcBQY7C2s/RUPKSS/EKzasDLVcYWjeMWDe7G41lZPjMOlglAhCWf5PeWuES2/2AfGkGL+87J9AbTckrJ0scJGcG2d97ULCAIbB0tp9zaLNSbYvuIdveX04nO4CHGpagrx65vgM6kFGri5l3pTtbOV06vqp4NSApF95c465Tdp0x1Nu5qWXQxqcjeo3Vj9cnqxZLqOx22AucWcowvqrcLEldVSd+iPfv0odgdnWQzeWARO8fOCwQ5Zkr97hrAxVPLlky3zuH3IqwOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j6i4MicK2b/3Q7z+U/fTVZjgwdZKerVi+nFpvOSivug=;
 b=fkEMjE7fZmz0CCRua2KtLXm19gbZd1g6xeyCjAGQzr9KN08a7kLEJlHtCWLxMhLkTSQzIMInbG++yiJyV6oNOttCHA25vMkpYDUxzTzKUOt7UmU21Olm8QFvGPz44izS5j3zNrb8HdEuxKuQ1KVOwfNdM6cZDe7GNWyoqteFecdSkXeaStXHvHANME84BWcREpO1eAQII8ncLSKLk2cRQveM2kBpqAkHDf/A7Qh+KDVh9UNHB7wMFB+WjMwWKS4FmCUNe/BN7q8FQEouOdtfNjOb0BpZcpkwb/bZ0lEnhNsaczn+tuKN6GuijDncg51qi+FDBNrh0xTek4H9TILuww==
Received: from AM6PR03MB5848.eurprd03.prod.outlook.com (2603:10a6:20b:e4::10)
 by AS8PR03MB9935.eurprd03.prod.outlook.com (2603:10a6:20b:628::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Wed, 10 Jul
 2024 18:43:44 +0000
Received: from AM6PR03MB5848.eurprd03.prod.outlook.com
 ([fe80::4b97:bbdb:e0ac:6f7]) by AM6PR03MB5848.eurprd03.prod.outlook.com
 ([fe80::4b97:bbdb:e0ac:6f7%6]) with mapi id 15.20.7741.033; Wed, 10 Jul 2024
 18:43:44 +0000
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
Subject: [RFC PATCH 12/16] bpf/crib: Introduce skb_data open-coded iterator kfuncs
Date: Wed, 10 Jul 2024 19:40:56 +0100
Message-ID:
 <AM6PR03MB5848E92F29EA82BE32F9BA2F99A42@AM6PR03MB5848.eurprd03.prod.outlook.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240710184100.297261-1-juntong.deng@outlook.com>
References: <20240710184100.297261-1-juntong.deng@outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [Wde/bjNnppQAvSf2dE9aynfWEd+9nTaU]
X-ClientProxiedBy: SI2PR02CA0027.apcprd02.prod.outlook.com
 (2603:1096:4:195::14) To AM6PR03MB5848.eurprd03.prod.outlook.com
 (2603:10a6:20b:e4::10)
X-Microsoft-Original-Message-ID:
 <20240710184100.297261-13-juntong.deng@outlook.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR03MB5848:EE_|AS8PR03MB9935:EE_
X-MS-Office365-Filtering-Correlation-Id: a37f28be-2276-49b1-b93d-08dca11039ba
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|8060799006|19110799003|461199028|3412199025|440099028;
X-Microsoft-Antispam-Message-Info:
	FeO9hBUa90zzGdAqOagJE3WDrYV5TMa3qLW3U3Xd4bRwxUWVb+cVhrVTiyCh/V+TqfEDIO1TAjy2LJFMDrsOmuzRvfWvuOH0UJWJhfZh75svEJ6/VL18hucY2hFHXdoZWMnwEzjmoKqPW1Lt8UfmKoh5xOsPRZ0w4jJTtxYNGp/PFQ5gmee8JNnltLnegw/NBQLStyjQ6zzreGzarBi/ytT4+wW8LZCNZaxPVoL7HO8AHyQkTRLcEFrYUzifyDKR5WQwazy6fcyPUyemtT1BAs+PjXk/kWt30EzBmJkuDZHClIxvnVBubegxV6AXbPRqqCp12mt1TienZL9bVvOxgxLJCzT8TTJpYF/AtgidvRAiuLOkn/k86bzcId8jemO2PKuizNbRxtzcLiYPjoLwAqyl86FmQABAHV868zkfHT2FIUoKH21Sggm48a63aGVasCUX1CrBbM70uy0yAobwXlTS+i+ibXA0bI6M23VP0wy6OzW1Yrr01D9qrZjPTGW+qgXvVZAH5livpn0wBMaHxGc/oRJbYYYV3EhQzjZaNWwlkskRbfNZF5tGBL/FCnXI9xEmUEdluFJ8FkqBdUcXVrqQwYu7S4W/ONdFXu8Xd0D1DyT9A4ZgQYfc/G/eDjOLxgqA9SyS1Mf3HDUPN0LuFQ==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?w4HEHyI4Vk+mhufZ/wtKvwEwFIJpdGLOIn3r6g6+bTer2SeB6pFVm6NN6Qgz?=
 =?us-ascii?Q?ZZ+NYOCzHHQmsn7XGxMSITjfpCmdLWEydZjLz1aSyZE5g/UO1VlAsAv6qVRZ?=
 =?us-ascii?Q?ZvdkE2tnvFuDgJnf0B1vpaxkOVZIEL1PDCfUx+RQeHmgYNgU3lkpVWnH1Nmw?=
 =?us-ascii?Q?Wqs/fsW7gcp9g8EQsLSFpep3jtTTHEe7xaLCW4KcLByuaASRLJot0l4Ee2Oj?=
 =?us-ascii?Q?WzO9Ew/RI83dbgtxxVVd2KHD1mqRiGBonVYGqLotbXolgr6ZR6NXdFfhUxh7?=
 =?us-ascii?Q?jvHhIAN0iQuECvLS+OWrXsvCzRlG0b2OfRovPmr5rGwDyQqSPZAyYm9000Md?=
 =?us-ascii?Q?FuYc9IQ3t4AWGMrhdMiL3zXVOzyBFHwvBTdGyyP9cZ1W07awk2ywBQGWVA/6?=
 =?us-ascii?Q?MyqaPqA+1RwTUc9J+Lvg/aaU0rbIyW4bUczIYiu2QHRCAGMJoE/pInrF9BBU?=
 =?us-ascii?Q?CXXt4MZJyOZVeE82IANxjQHpFl4nrM5iRs3gbfHNA4xlT+suVnVdw1Bqp0j1?=
 =?us-ascii?Q?7V+gyhrF6/Te9o94XOLyBGS8qbmFpC3l+e7JIAO3GL0nOuxQq1UF9h1kcyy7?=
 =?us-ascii?Q?jQhzNafA7lv2+zvvyfGmuv4+jr+OBDwpXnqdQRU/A0ZHOEdQS1KZgZNOr9Lm?=
 =?us-ascii?Q?UT0mWeEiRwyGRKhzLtvxGQ50oMa2lwV5Q5CCgQzv6PfY+h9CpYfxWoNeCq+C?=
 =?us-ascii?Q?OCTNNLsqCRu6I84jHFhuf3+MGMRf366fc/Lgn+eDrlDRtqntCyZ5lUGtR4n1?=
 =?us-ascii?Q?hXbh2wLcd5iPFj2ueLRRkJDPuM6QDJMZHrrLoD4fTGhrzI2JQ+ZNyv5+nNdk?=
 =?us-ascii?Q?j9zpqARLXNMyaR7NUXhWLgrmuYG7cUeBEBMeN6tTwYh2WWPt2gzgVJ3LLCal?=
 =?us-ascii?Q?rWc2YvkmgvYp+PlDDISNI8CYvtachZX471ff0IAa2NgxxsjtgllcU32vKLcj?=
 =?us-ascii?Q?0AdYaZPgxKj6/7CAhOPRBvIF9u4PaWVq+cu0J/9iao69x/pQ81linNp/kbuB?=
 =?us-ascii?Q?Aqm+vjOC2LXBhHEzxaBcn+nh+Oloy95YUk4P5SULFNfvEQDsvPEawyQxDsHl?=
 =?us-ascii?Q?n390NwNz1RKPBU+AeKxV34q4AVvUUCXpccgct0Ag6dRWi6NnpaD1Z2bPeEM1?=
 =?us-ascii?Q?FF1RPSBczUHoSNX8PLhMWuwg1WCXaYIYOdcFcbxn6SKyevjQ9u/HqfAEN18T?=
 =?us-ascii?Q?njP5nRmOTi3IRL25YrOlfjO+7oZ0/2M5nLcbrUpTA1u7U08jrpotVdDgzG4?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a37f28be-2276-49b1-b93d-08dca11039ba
X-MS-Exchange-CrossTenant-AuthSource: AM6PR03MB5848.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2024 18:43:44.1173
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR03MB9935

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


