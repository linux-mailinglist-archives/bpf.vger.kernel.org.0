Return-Path: <bpf+bounces-34439-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6095292D88F
	for <lists+bpf@lfdr.de>; Wed, 10 Jul 2024 20:47:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25BB9283EFD
	for <lists+bpf@lfdr.de>; Wed, 10 Jul 2024 18:47:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F728199E9A;
	Wed, 10 Jul 2024 18:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="X2ZH4uOY"
X-Original-To: bpf@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazolkn19011017.outbound.protection.outlook.com [52.103.32.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7128B198A32;
	Wed, 10 Jul 2024 18:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.32.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720637034; cv=fail; b=NGO97ks6QaP91zVNhURJY9QFZvoNgBvjqzD5htk3FiANyEShknPyTlVMqtqjQSVGktVvOQybugZOLYnu/o5wr1InVGvVG3BMoarv14IL5Fbgu35Et6sC3zuQcZammwoITtKi0ufUJW7qfW5lkux+Fkvov+xSAUpu2pIhttFNMMk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720637034; c=relaxed/simple;
	bh=VMtAYDhtgHGRgwlDQFX3tZNyn2Zt5lY5JD65kF0Nnb8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qFQizqMP18ruuQ4Sg3h4a7vkkxn5N/MDeKKzFKQOrCBpnN43zJxcvjBVNjCubB7dmnJrzlwiFEirnSlY44DxRyJZy0boPzxfzn4b6J2f1IZ8SM+RisfSaAIG0wHXkC1M4QQn3SOqKHh6w0m9gag7E7cicaSIhxk+KkxlvkP0O+0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=X2ZH4uOY; arc=fail smtp.client-ip=52.103.32.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dBCmuVpSmP1x+g+h79N/0J/ml9spGP0GQwHOWGFfZ2UpFc4zf3yF6IDnvc10M2SZT4Xfbacpvq6aZeUFQHTreAqpA9xDJuaaMSsYd6SOCV0O8iq3qXyjNEEsB1N1zshEfRQN/SUcT1LJU/Ah2vyPbYtd6LvrcbPuPmXWPjQcqJH+8f1MoH5vMgExqgovKrhwa+q7aBWtYE/T1udr3vGBi8qj0c77ZaPgNnfQtAs+Ue8ocXsZiMqUa/w0QQ6k4LajD6M9RzgAfZc4DwSJjYPbS3Qcc5BeZRAx8DDjxb774YUpRav2lXA6iRY6mccvMQ5kWbcsVfVxk1Gq5KbjM7vIqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=blZrm13GUso40hHswj2V1eWhQe/RYEiayKzuIpi2toE=;
 b=Yhfq1/o5gWJFUzyvvKJIYT5F9jLwnKW/daBZIGP5oD0+Cr8lniGsLHW0rYSJ8WPfysV5cQlSLmfvqwjIw2TNEVZJznNifO1NawaO4Phe6aCCFXQ0clKNrgGhYMjBIicaeGu1ibrASi8zhnC3DI+1baCfBKCxB510T+kNulDeGmKO0R5FJpsV6/k3Jkr+3AQx8jVxyxhlw6C1JA2jFYBVWOxm5CDcig7dGHoP1C6AdWnGobzfgh2shF4dgLrkIfQFcjslV+Gi2sTrRajuH+g/5+PFnnifKp1qxH9apiF7Z232gzEAR6EmdOXd6onSNIKjHoTh7jxuy6Ey1+AS/o8Yjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=blZrm13GUso40hHswj2V1eWhQe/RYEiayKzuIpi2toE=;
 b=X2ZH4uOYzhOK6yQdo+SfnDoUyrKJx1gUjKaA7pfdv+9Hd9B9LCGsVx+XqXZ5csJ84dCvP306uPoFXvGy+aot1C/u+lAcolWdeYVNHJ+OPkDZumXXR5C2mNgbZkmMJ6A0Sf1JM3ish5kVzEOfJcULgBf2NI8X8NAYEws3ImUcnoQttSxZs9hA/mrPeOmr5l5XHp8mSb0OA11U96Vo+qoTmUQ3yWGm1aGe3ppStcO/G2kinngdCLCf1cjcxPrk82sTjeTBK64EebSIKbhkyXa1mdpONkI1wm5RnyMFSpx53xO+oUXTGb53cdCG15OWxhYxRDDbLmaAtZdTvZA6SSDnUA==
Received: from AM6PR03MB5848.eurprd03.prod.outlook.com (2603:10a6:20b:e4::10)
 by AS8PR03MB9935.eurprd03.prod.outlook.com (2603:10a6:20b:628::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Wed, 10 Jul
 2024 18:43:50 +0000
Received: from AM6PR03MB5848.eurprd03.prod.outlook.com
 ([fe80::4b97:bbdb:e0ac:6f7]) by AM6PR03MB5848.eurprd03.prod.outlook.com
 ([fe80::4b97:bbdb:e0ac:6f7%6]) with mapi id 15.20.7741.033; Wed, 10 Jul 2024
 18:43:50 +0000
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
Subject: [RFC PATCH 13/16] bpf/crib: Add CRIB kfuncs for restoring data in skb
Date: Wed, 10 Jul 2024 19:40:57 +0100
Message-ID:
 <AM6PR03MB58481A73841F273E1C374D4299A42@AM6PR03MB5848.eurprd03.prod.outlook.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240710184100.297261-1-juntong.deng@outlook.com>
References: <20240710184100.297261-1-juntong.deng@outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [tiuzTlMuxXUaVQw9ZmKqW2zVFqf4bFuy]
X-ClientProxiedBy: SI2PR02CA0027.apcprd02.prod.outlook.com
 (2603:1096:4:195::14) To AM6PR03MB5848.eurprd03.prod.outlook.com
 (2603:10a6:20b:e4::10)
X-Microsoft-Original-Message-ID:
 <20240710184100.297261-14-juntong.deng@outlook.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR03MB5848:EE_|AS8PR03MB9935:EE_
X-MS-Office365-Filtering-Correlation-Id: f4c65e89-b463-4b99-26ac-08dca1103d52
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|8060799006|19110799003|461199028|3412199025|440099028;
X-Microsoft-Antispam-Message-Info:
	DSEwffJvZMXkIfidbj/r8YqXNhaTFPeodqUEHku6sVz8IVGeUAbQBFUtUANxmpcroVS64is7vJt6sAe+lKmdQj3Zfhq9MMYj7Iq/26ws7XFJx5NeI+S6OeA2mznMoF1f4pEWwhh6uDKkX1xqLs6/zM7mSMl9jyYM2W+Bhs+9ubWKluqk0WYSq5NH5p/NNKvgJ8C8whpVOa6Ag7zQlX//G0+C1rPJf8ThNr2Ed7hqhgQ3Xc+QQV11uzWiwMRx9B3ckFWtzdaAkBMAqHGHb/W1iALeUKACUzyi73LVUabvHxgKMB19jEMK3QiftHweAYfDFan1UcTKUC5zvciD5DFveD3E/to+owM2bgsBoe0OdA/ld/CbvmPRFmWmDuUkgoYYVCAsgVOAD60PQhxy3NlVXabHz4svTUO0qUCrglEfh0wG95D/ClWvTh19McDc9hoYMZsKeki2+Aj9FO0rgw6cwnR3vxLzpnTyImwSTZSdD7zYlOVxmfZAwv5YyWOzBtGvj41kTe5bLa8B48Dwte9gUdXNS754biUv73I+XVozcng4JHdccrnHH04NizySOeeY1b4oUGjKb/VgM2xRQh8vVlDs94AbqDlhcH2ZYyc6Gpxr+/mGoU2ohiu00YNLzsPdbucnTnVsMjKyFgXqTSImnQ==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PPimNz8K3ZQIoibeL0Jn7KpGsttwYuyJUDoTnTS5OAr4e37/8xln/7xOmufV?=
 =?us-ascii?Q?xXVkhqwQmRAnn3rv1Ed436rOCq5LLl/aczzYLqAZzX13563u821EirkUygwe?=
 =?us-ascii?Q?SHxlRSj270BN5fi0fn0yHK3ntwXpdlJcJ6c4uCtKvPco7rxIi2KgGYPchf7k?=
 =?us-ascii?Q?Yck6jxq8DdDu3tn6XiwcwObTjrH5WNbXHH90ImBsgkW1NdGhAi3T5TDtsr1W?=
 =?us-ascii?Q?juDkJY5ncr+KJE5W+QOvXLslSQw2b4qDeUNUYg29K1PClRujIUevpuIYhQjR?=
 =?us-ascii?Q?Rl96SbgBF8E8wx0O7iVEP9z0VR7TyBdqXJQJBTf7Db4xU0/lKC+UnS+aDJ1e?=
 =?us-ascii?Q?S8fiHKSnRQKKvetXfcHZRlgbmVtxoOS0Py36Rb/XAV89iaojvhtRJ0D3b+gv?=
 =?us-ascii?Q?toj9PLcSI/Vgw4ME/4tmOuQsn91w9MJQ1ebTfnK2q6ZZsI/X/bZrW7X/trz1?=
 =?us-ascii?Q?pa7pxF596QD7DsRlO0YfQErBNu1UUoWLQEnRg4C63NdfKrn/8qkAieMgXK/+?=
 =?us-ascii?Q?/q+c6Nze1f7AfXzW3A3z0owGx+TkyZdLNwWyaHGm5TE0p3sdjcDCe3SUVsmc?=
 =?us-ascii?Q?fNFS9TOWpk2y1InjHlvJQmUZj/bC2zlW2hNI9dfly1B+bsq95ppMrbeQSGu6?=
 =?us-ascii?Q?25kPdDKdNrL6J5VrAn3VsR0/NYLEygbkLSPwGu3lRtXRalMiwW6RfQ/QE0d5?=
 =?us-ascii?Q?iPSRPrJt4OovE3faa8mV7Kov04sr7Vdr8keUjEgvqVLBLw+Q+jRE2yjcg7Uf?=
 =?us-ascii?Q?LOUbVuHllhwE1Ri+FgL2o/P59Ki9sNu6HWiGiv6mwg4HBbg1I2JA7XmNfa3h?=
 =?us-ascii?Q?L8QnPBC8oBwrFw+QRTvByp11JEMgaaU/qPinGBjB0Gtc2mX9GEdRmlFpZabL?=
 =?us-ascii?Q?jaAT6hE93H02Q8XZsXCLBL++HdJPWVGR0j1i8g/Yn3onQ1yoyzsmGnVDrJPk?=
 =?us-ascii?Q?br8DVds+lS0XDFHhHZrXumN0YhtzqRctF1pmCQlcbp+styd5ahOeHsuRKfpR?=
 =?us-ascii?Q?nnqwjEZ+A944uYTjymHO1DmCd8KaZbQuM4VaPku6XdXV71YELxZVoLT6v3Wr?=
 =?us-ascii?Q?VtHngvG7hSiBek1VFsdPHBt2EKSAH1L6nmdK3ePNQN1/iNQDwtpHWdBX7WqX?=
 =?us-ascii?Q?zF2dESF7MpWw206hR9nT76SnEobEhclb1quMHHAbvIw8xbyG7RXVYzXtOf7z?=
 =?us-ascii?Q?Pnm3AZWTO+Zb9kZ2bInEd9tUhHzFkmUekIfNSV8u8zom6kforK9oEPZ82rY?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4c65e89-b463-4b99-26ac-08dca1103d52
X-MS-Exchange-CrossTenant-AuthSource: AM6PR03MB5848.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2024 18:43:50.2491
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR03MB9935

This patch adds CRIB kfuncs for restoring data in skb.

bpf_restore_skb_rcv_queue() is used to create a new skb based on
the previously dumped skb information and add it to the tail of
the specified receive queue.

bpf_restore_skb_data() is used to restore data in the skb and
must be used after bpf_restore_skb_rcv_queue().

Signed-off-by: Juntong Deng <juntong.deng@outlook.com>
---
 include/linux/bpf_crib.h      | 13 +++++++
 kernel/bpf/crib/bpf_crib.c    |  3 ++
 kernel/bpf/crib/bpf_restore.c | 67 +++++++++++++++++++++++++++++++++++
 3 files changed, 83 insertions(+)

diff --git a/include/linux/bpf_crib.h b/include/linux/bpf_crib.h
index c073166e60a0..5b7d44642f80 100644
--- a/include/linux/bpf_crib.h
+++ b/include/linux/bpf_crib.h
@@ -46,4 +46,17 @@ struct bpf_iter_skb_data_kern {
 	unsigned int chunklen;
 } __aligned(8);
 
+struct bpf_crib_skb_info {
+	int headerlen;
+	int len;
+	int size;
+	int tstamp;
+	int dev_scratch;
+	int protocol;
+	int csum;
+	int transport_header;
+	int network_header;
+	int mac_header;
+} __aligned(8);
+
 #endif /* _BPF_CRIB_H */
diff --git a/kernel/bpf/crib/bpf_crib.c b/kernel/bpf/crib/bpf_crib.c
index 462ae1ab50e5..beada526021a 100644
--- a/kernel/bpf/crib/bpf_crib.c
+++ b/kernel/bpf/crib/bpf_crib.c
@@ -300,6 +300,9 @@ BTF_ID_FLAGS(func, bpf_iter_skb_data_get_chunk_len, KF_ITER_GETTER)
 BTF_ID_FLAGS(func, bpf_iter_skb_data_get_offset, KF_ITER_GETTER)
 BTF_ID_FLAGS(func, bpf_iter_skb_data_destroy, KF_ITER_DESTROY)
 
+BTF_ID_FLAGS(func, bpf_restore_skb_rcv_queue, KF_ACQUIRE | KF_TRUSTED_ARGS | KF_RET_NULL)
+BTF_ID_FLAGS(func, bpf_restore_skb_data, KF_TRUSTED_ARGS)
+
 BTF_KFUNCS_END(bpf_crib_kfuncs)
 
 static int bpf_prog_run_crib(struct bpf_prog *prog,
diff --git a/kernel/bpf/crib/bpf_restore.c b/kernel/bpf/crib/bpf_restore.c
index 6bbb4b01e34b..7966c02e416e 100644
--- a/kernel/bpf/crib/bpf_restore.c
+++ b/kernel/bpf/crib/bpf_restore.c
@@ -7,7 +7,74 @@
  */
 
 #include <linux/bpf_crib.h>
+#include <linux/skbuff.h>
+#include <net/sock.h>
+
+extern struct sk_buff *bpf_skb_acquire(struct sk_buff *skb);
 
 __bpf_kfunc_start_defs();
 
+/**
+ * bpf_restore_skb_rcv_queue() - Create a new skb based on the previously
+ * dumped skb information and add it to the tail of the specified queue to
+ * achieve restoring the skb
+ *
+ * Note that this function acquires a reference to struct sk_buff.
+ *
+ * @head: queue that needs to restore the skb
+ * @sk: struct sock where the queue is located.
+ * @skb_info: previously dumped skb information
+ *
+ * @returns a pointer to the skb if the restoration of the skb
+ * was successful, otherwise returns NULL.
+ */
+__bpf_kfunc struct sk_buff *
+bpf_restore_skb_rcv_queue(struct sk_buff_head *head, struct sock *sk,
+			  struct bpf_crib_skb_info *skb_info)
+{
+	struct sk_buff *skb;
+
+	skb = alloc_skb(skb_info->size, GFP_KERNEL);
+	if (!skb)
+		return NULL;
+
+	skb_reserve(skb, skb_info->headerlen);
+	skb_put(skb, skb_info->len);
+
+	skb->tstamp = skb_info->tstamp;
+	skb->dev_scratch = skb_info->dev_scratch;
+	skb->protocol = skb_info->protocol;
+	skb->csum = skb_info->csum;
+	skb->transport_header = skb_info->transport_header;
+	skb->network_header = skb_info->network_header;
+	skb->mac_header = skb_info->mac_header;
+
+	lock_sock(sk);
+	skb_queue_tail(head, skb);
+	skb_set_owner_r(skb, sk);
+	release_sock(sk);
+
+	return bpf_skb_acquire(skb);
+}
+
+/**
+ * bpf_restore_skb_data() - Restore the data in skb
+ *
+ * @skb: skb that needs to restore data
+ * @offset: data offset in skb
+ * @data: data buffer
+ * @len: data length
+ *
+ * @returns the number of bytes of data restored if
+ * the restoration was successful, otherwise returns -1.
+ */
+__bpf_kfunc int bpf_restore_skb_data(struct sk_buff *skb, int offset, char *data, int len)
+{
+	if (offset + len > skb_headroom(skb) + skb->len)
+		return -1;
+
+	memcpy(skb->head + offset, data, len);
+	return len;
+}
+
 __bpf_kfunc_end_defs();
-- 
2.39.2


