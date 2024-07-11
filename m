Return-Path: <bpf+bounces-34551-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F5EF92E69F
	for <lists+bpf@lfdr.de>; Thu, 11 Jul 2024 13:28:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 268B7281E54
	for <lists+bpf@lfdr.de>; Thu, 11 Jul 2024 11:28:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB36915FCED;
	Thu, 11 Jul 2024 11:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="kyAJxFAc"
X-Original-To: bpf@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazolkn19013067.outbound.protection.outlook.com [52.103.32.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 841A214A4E5;
	Thu, 11 Jul 2024 11:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.32.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720697045; cv=fail; b=oB2XAaAEjcOY5JVVLUToUJ/E75GyTFvNFWV/+3HrnftPezbgvMXNmn7VtObRV0QCXJZwXuiGh77YtPFK8kFolfCJB8mPjZZrH2T0z45N0l+wnC2OuHbfn5x6apd/uMQTvhEzewGmpSqhVII8FfvsW1/qZe7Y3jlebdbf3PQC3Hc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720697045; c=relaxed/simple;
	bh=FvHTQDE3p16wuWz9aM7RjyEAYfk1Q5AMjLIflanPGJc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=isX5DKsdxwApzChCcjmVOFWi4IWJlHw8syhbMfjSjRzVdNmyVs+SQDOiA5XWMDahsODiEBnpc+VbkmqPi2L1krW6MyBCmoJdlMaDxTcSFSSALxCdREs5cUHNkEtmcqGvR5a03VJp6AFKZqiii29OPE5ChYjCYMefimtrp0NlIL0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=kyAJxFAc; arc=fail smtp.client-ip=52.103.32.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DcEfaomjUL4Q+Ztexor93zj3586a9fTy7zbQe8B9b1i9dcxUe6sv58Gj4YQIVMOSVzglfwEzG2tDVfoxiv1iaheG8uAfECe7X1LJT/dsXUAQZIpQ9aOvkqCHCFN6hzbctbn2SpNVnEX+NOk882EDN/Gx9H9bMgCtW2bGWt++zwSL64UYGXkFL8sA2sIbc3WS4rgw+S4xkd00JMXvSLZXf7Uwx526RTjT7ENVz+xMPWwpPJt8Fn6kZz3ILgij0oDV/imOsIiEXKcHCwWsMMeRxFn9oY61wkqZg2Ig0PgUzwjMcIkSaKrXUNtM6d3FDnaIu/vkyxl1tjOSAQq3x/Bv0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5BuvugXW+Fdk3yqLfSThp7L96+nhopl+ZSPgDBW6qaY=;
 b=x9OaoBabqnq/zSqoOjHjMrRCh5eQpL5jfh7NKsGpqQj3kcCoGlem+X7bEVUjdKrkiWRLak4YUlLh2F3n5BfItCEUqS2MrJEea4VL81amUZe1yYYUaAPOeGiEAkDiR91BCI/exPiQ0JFhs1zvzYRDaqvXdBVtQoyEegkMW9ph29G+gFzHhuBLM7p9DOKXw1q3DHmB4KrPNN3Z9lJsaZrrblYqATMHQZJcuuvqWAGlVbTBLT7pFxz/ljfe5W1gO/gqyUVN4/SwBmHdDmCOOrAN1pcuWpCz3ANVN00tmpmOKcJu+JxND8Wm7i/BDp9SSPiFgnlqjGvrEZdolC5V6LuGcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5BuvugXW+Fdk3yqLfSThp7L96+nhopl+ZSPgDBW6qaY=;
 b=kyAJxFAchgykgCHlMZgBixEBUQ60qN0u2HMFPod+4QncpMnnO/d4N8SatCiP3J+VOvnxlXnCRDwdpu62YhIiLA/FFumn46aRrvV3fPsv+E1LuQlO4iBkvKbdG0JWe+oU3NKX5jshj8tV0dwH4YgJxTs96Mano7hZhsMzG7PKU0tAKPTkBvXQsCsJwaVuf3QAybROcatqDgvPjQFgPo8tuhXq6YfoWZwfWJx99gK2QMVT4hLBbkyBf8VRz2WtANDqy+eRE74EAekhbI1xSG3lPb5KJRTdbnXljpYWwjStPncMsxE8tNN0OoLGuyYemSc1X7TFE00vMYVO0bBAzS/Daw==
Received: from AM6PR03MB5848.eurprd03.prod.outlook.com (2603:10a6:20b:e4::10)
 by GV1PR03MB10233.eurprd03.prod.outlook.com (2603:10a6:150:166::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Thu, 11 Jul
 2024 11:24:00 +0000
Received: from AM6PR03MB5848.eurprd03.prod.outlook.com
 ([fe80::4b97:bbdb:e0ac:6f7]) by AM6PR03MB5848.eurprd03.prod.outlook.com
 ([fe80::4b97:bbdb:e0ac:6f7%6]) with mapi id 15.20.7762.020; Thu, 11 Jul 2024
 11:24:00 +0000
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
Subject: [RFC PATCH bpf-next RESEND 11/16] bpf/crib: Introduce skb open-coded iterator kfuncs
Date: Thu, 11 Jul 2024 12:19:33 +0100
Message-ID:
 <AM6PR03MB5848EDA002E3D7EACA7C6BDA99A52@AM6PR03MB5848.eurprd03.prod.outlook.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <AM6PR03MB58488045E4D0FA6AEDC8BDE099A52@AM6PR03MB5848.eurprd03.prod.outlook.com>
References: <AM6PR03MB58488045E4D0FA6AEDC8BDE099A52@AM6PR03MB5848.eurprd03.prod.outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [2XDViwXCQzMIVGVmL4LRbUeX5pajzNZW]
X-ClientProxiedBy: SI2P153CA0031.APCP153.PROD.OUTLOOK.COM (2603:1096:4:190::7)
 To AM6PR03MB5848.eurprd03.prod.outlook.com (2603:10a6:20b:e4::10)
X-Microsoft-Original-Message-ID:
 <20240711111938.11722-11-juntong.deng@outlook.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR03MB5848:EE_|GV1PR03MB10233:EE_
X-MS-Office365-Filtering-Correlation-Id: b697182a-fc50-41aa-256b-08dca19bf60f
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199028|19110799003|8060799006|440099028|3412199025;
X-Microsoft-Antispam-Message-Info:
	WtT0pOnawIWNxq85JUJ4B8QihcyCyJZua/X70RPKS5lTYrMbIR4aKGJ/pkgf3pgfMAe+33KbITn8LRygxKcdiwB8gMBdWn3VjHm6UcEVK8zXJ3p7qh4Q+ajKCSwSmTMvnhhmzcLeMx6j7WdHMpKp3UB1LldG6sHJjUubHnd6uLI9ptvq9T9PiQLzcXcg3RFdYL4DuIAhu66RVBaJHTe77GFJCPr6Og7Nddr/gvEchAZtBLtwKmnXBYmIVVkuvJuMIfQr3x8llqIy7uY4npEjkZS3wB97/tbTUh4Zw8xVlGTotrqYSAdSuujWPOZpc1CftRFHcYJjvpwavEuQr5DeLhSl2Z65PPlqVdfA8VcgD50EnO+ecF2ZQupQTeoaMJ7hW0T2XzPIp2YnBunXKHYJlwzLnSH58lGBfqilbeOKgccESzbhJU0w9xEfzCH44NiytGOB+ElNSPt+MKeGTQhWRIA7BGEpOkaRNy9uI39esx/FWlmXtCBbhS2Ge/OssUAEI2pAnrf3ReulyLva2+n/fHKjNAdTrlmvlg7hbk9XzSBfln9pvAeg7QSfGkUjmyrC+qA2X2rG9VBFwYBTjMNBjoTXdxQhFfBEH77D5CkGLYv9DXjkbnKhonQQOwIVFaFSTUcHdCSG1izdrFINWj1+eg==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gtVModP6AXsv1cPOVrbTejs4C8T0hfqS9z5FfpJksZTTFtDr/aQX+XBsr0cG?=
 =?us-ascii?Q?kySXxBk6sK0COExpe3ypimnfbS0UJXpj52AV9g5lxp08E9+7EXb9vJ4/HhiU?=
 =?us-ascii?Q?3/dLkRGOEMRYffnoQG/H1/ouKhnOrPQXWLg1aQ5OnUhFWS9Le8ZCV1n1IVHl?=
 =?us-ascii?Q?KsBd9iNeVd/zsVn1GOEA9Auk7cqfMTOxLXYYT5OsyJvY8mdNyBH8SJ8V/ZvR?=
 =?us-ascii?Q?fZuKbTsQOB/M25GddPczQUDCYxmUUJUNX5C9rsejfvOoheSOp2x4geBrjnIP?=
 =?us-ascii?Q?qRdGpk/4iO4LW2FxzD+KiVYmjRIzoUjNEenQnkK/+jd9mDDJ+vZjEA5auV3u?=
 =?us-ascii?Q?CZE+Peod6csl5IN5yvG7Qki0X3HB1mIZi+lAxflfxmZmzc37QsL43Qu/nSJc?=
 =?us-ascii?Q?dMK6dWASmP2CuG6ogNrYRgHXs988d1UQkkVrNeDF8KeYCRXd2XZj+XaqqKnS?=
 =?us-ascii?Q?UNbMMth8s4I/JG+YhnJiTgncJYem59K1A/kwA2Yx7ux2TaKzXfgP6Pck4/Zp?=
 =?us-ascii?Q?T/5osbbU23X1BaMMoob7DfmHtmmwjHoexQQl21fR7cQjd35TGXbAlbc1GJfB?=
 =?us-ascii?Q?2VKEx5LZMpOatsNFtkA1CYfhthLmLq2scgCMmDvxCIknMvhfAE4ppPEBWrPh?=
 =?us-ascii?Q?u39ioX4JnnrVBtb+re+o6jC8E2k7AZJQ2hW2bzhXNvWlR3m6Mg8OG14mUpf3?=
 =?us-ascii?Q?D3Kp+IXfOoY5x7oCM4Pv5fVNR0WhbhwbEcQP+kG92V5tMw7BgB5/o5WHEAqk?=
 =?us-ascii?Q?9b7vwGkliEc2XRbtqkl2fz/A60ZxHjjV5F8gWzBlAyYWCZRqSlllTAz4xz0H?=
 =?us-ascii?Q?+U55GiCdxnRcnrVM80TVr+wSXQ1KF632UyBjQwEuHwzg2gTDdVca2stLE5BT?=
 =?us-ascii?Q?kTC8IyNMwCu4Lh5Y09r+T9CCltfJ+jiMjNWvxdyjhvL17C1KBnDs+LuNdiHg?=
 =?us-ascii?Q?0T3stqrTSNOJCAFNhS9Bu1E++CWhMMDYpmWs2HQxaYr3x3Clv88OOtM1l7Bq?=
 =?us-ascii?Q?+Mjw7CABFS3VC91sfRYA6d2d3ehCd9FV8JxUOR6Ha4/QzPpm6viDPRCHjM70?=
 =?us-ascii?Q?Zds3ecd6M+z4IZCLODKUONS234J9INC+xqwiPEuKm6utcBXeh2gJcoJD0JLy?=
 =?us-ascii?Q?aOJr+kkoVbRaDx+GWLeuVK6zceQdluQv7NVzel2Vx6RfXPVWMYuzFQkxz5k9?=
 =?us-ascii?Q?6U1DaD6xcVtFVOoD903O+SCT7/H3jhhG1usP3A72GMvwXfRVcuuZLv4Uuks?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b697182a-fc50-41aa-256b-08dca19bf60f
X-MS-Exchange-CrossTenant-AuthSource: AM6PR03MB5848.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2024 11:24:00.2499
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR03MB10233

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


