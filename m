Return-Path: <bpf+bounces-34553-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F27FD92E6B0
	for <lists+bpf@lfdr.de>; Thu, 11 Jul 2024 13:30:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 424C5B23742
	for <lists+bpf@lfdr.de>; Thu, 11 Jul 2024 11:30:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD95C15CD46;
	Thu, 11 Jul 2024 11:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="njhPh593"
X-Original-To: bpf@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazolkn19011024.outbound.protection.outlook.com [52.103.33.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85231158DC1;
	Thu, 11 Jul 2024 11:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.33.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720697103; cv=fail; b=UiPqfmOlyAqoyNeq3QupYzHk2sc0PGkLcZXABICXOLHoIZJh6xdKFstqW8a2StzrCPux+1mEg2aKDeGJNiQ7AJPlaPsJ/ckZ2l5rGU9K198+y0qstQe2h4pRDybU5fvapfmmc4KLEp0fa5nzfkqbBSDa0NUFhHcrOGkmOrj0prM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720697103; c=relaxed/simple;
	bh=VMtAYDhtgHGRgwlDQFX3tZNyn2Zt5lY5JD65kF0Nnb8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=k/wIoNuie8M6/CtxopaFcQciPV/D9Tu0yF0HaFAKkXbij9DrQ5+YFHCDXmwtPHfsLc4E3s7BoqJ5mIbZNL79Qo040qbjOFbz6WS1a+Mpvc/P0CUT2oVPjN9aFUYUbsZq40zrGphta+EXqY0XwG140gW7NaoqmCenHToB60dpUzc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=njhPh593; arc=fail smtp.client-ip=52.103.33.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AyrGysHvlbELkUz+wVQq5VMpd7NQg0O9/DU2TBX7djaPCaVUMeYfs9Ce9LkzIKYj85Ie4hpFe5ijzUZ0UGQlwUn6FrKhbj7ShIya8+H3lM/s5TE/kXwhR0H8YG1juXhi/qqDTgUNIbrl+tlY3wpyRRHgnh/IX1+lwMCQnTdO5+B3uywa3qwnNKTXOAiyBc1Z4IM/l2/O/LslpEZdsmQ49HB82F4OwGKLXdNMVSgRdIYoY6ZRKetd3iV+o6f+KA1Rq8WCCBRzQj+lODJJYLy2IAxTqoHIo0mj8BoWMuaZ54EwwXzwDalSYGgQ1pvpDSAFzfeEUvJ0YmFtPb7pKW2TFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=blZrm13GUso40hHswj2V1eWhQe/RYEiayKzuIpi2toE=;
 b=XDvo7a8TCFRma1qL5wdKXBxZOFBrzAk1jDuve0w04nxcNAAnm0S+FHNkI40kHxjQlAfF1I7wi5+bcfo1mr0bfDaRvH+mkUtDI1t6yraNmhwYoKzIlmQ4MhDzGyeQliFUpQMBPdlt+2GEV16DWoq81Cx//Iu9rD5TKbk91+YTxh7rXSfSwYnsUZcoNbvZzf7TLu7+wKjAyUpmtNgL+HhAXHc2nXXNQKCHRGtzmbnp4Zp9apIRhNKxOhYiHL51pW67F7pCIaeLElQhhHHA4P5d3qAUW37HabJL2tmad42A7hwI91iZ95JAChT4oG3Z1pZvQcnszssukToav3sGHiC8Fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=blZrm13GUso40hHswj2V1eWhQe/RYEiayKzuIpi2toE=;
 b=njhPh593qKC18l0Ah/oo6Uk9DDe0l1pmNKa/yPhCVkbKbtcHiDnn7oJfqGOJX6TiBcoVfwB0AUntA0fGuy2COKI04pWnTQ/6T6MjqKfNLBlqbtFbVJWF91bDrDBMxll+J9lJkclnZPB7n9xKMsGACGDBOe7K2XNFo1odPQOnVAmId2snNANYOFyAvc600jrhUgpCe3fDQQJEHlTX2UqLK9eeqbnl96ujK92o9PaY1rClxD9WTsqwsEOEdPqNjPh90iea8bPB92jIp3PdmEbvyWu4o3IExew0EBxcJy0+QivFWmB+JeWFKSlr4bzF6lSO12xrZ30uOMa2bypbacISZg==
Received: from AM6PR03MB5848.eurprd03.prod.outlook.com (2603:10a6:20b:e4::10)
 by GV1PR03MB10233.eurprd03.prod.outlook.com (2603:10a6:150:166::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Thu, 11 Jul
 2024 11:24:58 +0000
Received: from AM6PR03MB5848.eurprd03.prod.outlook.com
 ([fe80::4b97:bbdb:e0ac:6f7]) by AM6PR03MB5848.eurprd03.prod.outlook.com
 ([fe80::4b97:bbdb:e0ac:6f7%6]) with mapi id 15.20.7762.020; Thu, 11 Jul 2024
 11:24:58 +0000
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
Subject: [RFC PATCH bpf-next RESEND 13/16] bpf/crib: Add CRIB kfuncs for restoring data in skb
Date: Thu, 11 Jul 2024 12:19:35 +0100
Message-ID:
 <AM6PR03MB5848A1727BC77469E23D84EB99A52@AM6PR03MB5848.eurprd03.prod.outlook.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <AM6PR03MB58488045E4D0FA6AEDC8BDE099A52@AM6PR03MB5848.eurprd03.prod.outlook.com>
References: <AM6PR03MB58488045E4D0FA6AEDC8BDE099A52@AM6PR03MB5848.eurprd03.prod.outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [soSlfipkRHSsXhA3hStu1t+WuiccJ1X+]
X-ClientProxiedBy: SI2P153CA0031.APCP153.PROD.OUTLOOK.COM (2603:1096:4:190::7)
 To AM6PR03MB5848.eurprd03.prod.outlook.com (2603:10a6:20b:e4::10)
X-Microsoft-Original-Message-ID:
 <20240711111938.11722-13-juntong.deng@outlook.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR03MB5848:EE_|GV1PR03MB10233:EE_
X-MS-Office365-Filtering-Correlation-Id: df3d3151-6506-44a3-625e-08dca19c18bf
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199028|19110799003|8060799006|440099028|3412199025;
X-Microsoft-Antispam-Message-Info:
	n2AutJ+yvIOb5DeD/v2g6veqMo/AC/zpdxWZsXvQhhCAeauiDB5EyU0Uho9GrHNDOPDHT9OuO4PhzdGGK8Qv4E8Bl3Pknkn4E1/huUzwkjTC4gYjFaqsfuQCJsOfM2+m2Hz+/YHe34C//Rvu239tfx0vEB0yJ+5dpsxWyV+BQDmzN+iWoEw/n5zdD5qbFUFiOZK/boXjB+rn+vPFEQVt9QPA7zbskFvtcVxmf22JmIhuPPkbFuRNqRJbG2s8pGweh03MftwIzUpqJreSDHCz8niuTn6Nxj7wRdlZrzvUzNOAHPw9QRTmg04GJKuYDlVxcBvSlM5dme5zavvTNGtVRjmFG+xCeY/PO1laiyKAAc+yyNNLWaks8ZQk0uVKiK0AoNpwgQy90H+fXd0Ai51lf9UPzBsPHNtqFAKtyPCXJYRPvFsQ7hWkTnQqqW9XdUKT5y3DDBerbFkjHDoU47YkcUN+3OYbcr6P3ud6oKocRzHdFmOJjglQW4oGpWDeTAKTW0L1zvenM/7otoYKCq1VBwNmdrqkvvFhXeWY6LlPCmJ+RZga4/ujMJqa8KP9I9UHWqPgyqlD6CdLJzwaR1q3ujYOGk3bn93jXXs2kIoWuaLXYK0kfF7oiV6b1huWQBO3ygRC0MiNrpJ+pzZxrPIB9Q==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PpDz9ztaWGTlCb1X48Fp4vjjLLPm6CxAJwXjUEy67v22psWV6LEOk2ICPSM5?=
 =?us-ascii?Q?rjuKQhU248CxaCNdnpZGw9gCaTPDbQJJk7ZiBXTI9wjQjLKa1Isg5TVtOBCo?=
 =?us-ascii?Q?Jlw4fBsC2EuM+oM2xGaAnaEpgyWSyLG9yzOcJqOzDQh9v8+KiSW7FioePQqf?=
 =?us-ascii?Q?vrA5TdfGjVNRfK0vRvP2NF97NDC+8+vmyXY3VpckkstD/0pv3W/3bFHSenMo?=
 =?us-ascii?Q?/OOPBd03yPqR32py011njLgjgDj7lu0KSRik8aNwD85yOGzqynQ16WwowqSx?=
 =?us-ascii?Q?AwZMo4LVYsp/y9e8tF+v5k/nt8eABiP9QWP5LA66eCo3s8/MGqcym/YCatsY?=
 =?us-ascii?Q?DPysPejrQcYXbVQ7g6fkUN3u4/AAyp0rC0WoCgcXIaTeGnNW5yhsx1V+3hfd?=
 =?us-ascii?Q?ROUao7qu0NdzNIzapWLeUA7+wJYZFF6E5vlNH8nWl5A/gu0p8X4o9ZhQjLiS?=
 =?us-ascii?Q?MyzccXfvjRjaJxX6FUiNEXO1OjIRV+fyhkdWa7CDQtjFGvKZJEEam8V8spC2?=
 =?us-ascii?Q?OgObJvrVHAt4sCUblP3b9CPC7hqw+Mo9U/EI98+7DDf5QkXWsa+d1VfBYb3Y?=
 =?us-ascii?Q?L66rOxsmknhPcrqT7h3NtFDyG3LSXvCuc0rCpdkoqt42fdmneoRXOQmdZCRm?=
 =?us-ascii?Q?FIDcVKohyG46zYSAA9zRHISI28LNmtpGanr8WS7LVffY7Vz+dx21xseBn338?=
 =?us-ascii?Q?hkJKTflV5hVGJzr9XdInF11Q0qgCpXzbC45ECYGAI0c2aEewSsELsHXCtcT6?=
 =?us-ascii?Q?OkjHIXB6RBFWoLD2udLAaS6+EbjSZ0RokP1QdZ1dKhYdSISr0PgkiFO6IMc8?=
 =?us-ascii?Q?/vGgiXhT3daL1jFNlKSaJldWBW/vDvFTJ/c1z/UjyZqD52fDz7vQ/dtLhdIA?=
 =?us-ascii?Q?NtGlbjQ2LsikLdT2aLbFXvm4jX1VPamOAz/9XssfwLMV30KjdBjlIFK67ZwW?=
 =?us-ascii?Q?6KRBBoEmE+KuQqw2ri/UZi/kWLHaZY13JlZFAPfHQoRV6XvY1oZ//NP3FPEn?=
 =?us-ascii?Q?my3RzgFAhfimvcSUL7O+Y+a6VRn4bCOhMcBT3rq+YGiRSDLiPvI2n143nKgt?=
 =?us-ascii?Q?U9rWuq4qrirIIgSbFuzJKmUiP2prwjr/s6tiEro2BK91faj7JYuHlgw6z9Sg?=
 =?us-ascii?Q?bntCByMt5ZEujmO+BOxoOecgVruuNAkaYXQwJFrEdnwfpJSsT6Z2mcLQ1Ts5?=
 =?us-ascii?Q?clO7C9UL9nDuzaH5GY/k28qshBO3G5mUpg1z/RG2RWmzfh7Fqy1poVqJOFg?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df3d3151-6506-44a3-625e-08dca19c18bf
X-MS-Exchange-CrossTenant-AuthSource: AM6PR03MB5848.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2024 11:24:58.4361
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR03MB10233

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


