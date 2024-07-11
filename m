Return-Path: <bpf+bounces-34547-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 33F6092E693
	for <lists+bpf@lfdr.de>; Thu, 11 Jul 2024 13:27:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B547F1F21D8D
	for <lists+bpf@lfdr.de>; Thu, 11 Jul 2024 11:27:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C6B416D305;
	Thu, 11 Jul 2024 11:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="EuizLnNk"
X-Original-To: bpf@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazolkn19010008.outbound.protection.outlook.com [52.103.33.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1145815ECCF;
	Thu, 11 Jul 2024 11:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.33.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720696981; cv=fail; b=TZfdVkSzZs77zW5JENt3mDkENG/xA3iH+cZnFbE+Wy3hQV6WfQAUUipieydXDMBusdBLUx9D6qD8SZUTOp+I/1FtKu3VmXLh78z8lNd4W5qMed+J+HaaM+q4Q3YPdlyswsDfnNCAjRbcQUcGMHDjnsU87It3Nbj//blbDW/UEz8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720696981; c=relaxed/simple;
	bh=cDuPnEMg04Uv1rTocjZFvg8Dxz5QqjYI4XdbER057dQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bvHkP4hC9GcZpYL45voy77mVdbUsXsEfvGER8yZYTjpZmjR+FWBv/ROzJtA46mYYKMJY3BC/50R08QwrzG8o99YhYmvRmOSGGwIJkZJpWlc8D2uhqhDL48hrY/he6LT+NAamRX4kfE/aRLqRp/kjKx/lQ41aEeL/pJgctLPTVCg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=EuizLnNk; arc=fail smtp.client-ip=52.103.33.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EPw5wpxjY2DhI3qNK+vgbTiv/kXEtNNajAUG1uG6sIBcTcdN2Nb24BqdWt8qc9e3nQW9fHA3Y7SbpV1nFp0xls4+POingmkpMVabbctZPXfmD/myogoK+Ic5hlWJTmn9Kr6yLndWfwS4h/XlYr/SwSwYkIg49ceLyrvxhMKALRqnlMfpVWtLBQpBzr0qwjXS4MXRQEo2DH38io7wjuiaHp4gTuKQfScS9/7N7RscbxjU4X69kkD70ncvfoFN9Z7JIUz7KzinjePUd3xpDei24TAMvgIjOeRanQuy4USVlz17a5ittVs9nmJnwi2l+ZDTGjayA/FrWjA1M/zFiFjD9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=epPvZUVJLFCfITLfmee8fBtxZMqqIsLm5Kg+Eba8emw=;
 b=akMGZ+F++xqxXysJbZX0vQXOAnUBXULMgxoQMJ2McD4GSRdQ2S/bVdChZLggJZPsPR9b1peBAc2SIaO0DY28mOIhlowTnA3KZ3+gBUbkSKGvHppBNqLK5RdEYVUxoRf6fLCqfTOC2tLd7HQgWbas63IoQkRLPR+SXEqa6xMU1zUA1A02bnE6nhta690Ltn6Y8Rc08Ow0yRZ1tBQ3T5sxMg8zmtUhljDalVyPHUz/hbqDMYFlXVdWV4T7sK0AdfH+Tt9a9A5G86YLPKmPJkv25glO2vuzv6ARnCE/XPNZC+ODdDipTsHCSbcVXzIl4xy3JJawUeZZzy5SPJui/Nyj4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=epPvZUVJLFCfITLfmee8fBtxZMqqIsLm5Kg+Eba8emw=;
 b=EuizLnNk29XP0hZXRCmcDCCKKPr6d6OTDfp9hXMbnNOCsJaJioN0cmVooorX4ZY7Iq1W1p+dTLjehkIIb6KfoL8E4JGbFKMo7TXW1rVeU2jcuw+PFXIMO1niyemm7XB9PaL6KznvMalKRyYDeQqVZwn6BjDYsIK1GhtHBs8Ov2NzI6ic0U2lGlbHj/6U+BxSzOJO2g9a0ypAULbrNzuGe9NGTLKhVdCb81D5e0l7U+yQSQVnY676P2ibyrPpCzXGJ+dgICsEmEfwiosWGjNHGKwH+kI/dgSVqFUU8NBIurAB1L4VmrfQE0ec5h8y4UxLwCKXFAaSdBqJ7weyIhM3Qg==
Received: from AM6PR03MB5848.eurprd03.prod.outlook.com (2603:10a6:20b:e4::10)
 by GV1PR03MB10233.eurprd03.prod.outlook.com (2603:10a6:150:166::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Thu, 11 Jul
 2024 11:22:56 +0000
Received: from AM6PR03MB5848.eurprd03.prod.outlook.com
 ([fe80::4b97:bbdb:e0ac:6f7]) by AM6PR03MB5848.eurprd03.prod.outlook.com
 ([fe80::4b97:bbdb:e0ac:6f7%6]) with mapi id 15.20.7762.020; Thu, 11 Jul 2024
 11:22:56 +0000
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
Subject: [RFC PATCH bpf-next RESEND 07/16] bpf/crib: Add struct sock related CRIB kfuncs
Date: Thu, 11 Jul 2024 12:19:29 +0100
Message-ID:
 <AM6PR03MB5848D2C74800C9FA88AB62AF99A52@AM6PR03MB5848.eurprd03.prod.outlook.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <AM6PR03MB58488045E4D0FA6AEDC8BDE099A52@AM6PR03MB5848.eurprd03.prod.outlook.com>
References: <AM6PR03MB58488045E4D0FA6AEDC8BDE099A52@AM6PR03MB5848.eurprd03.prod.outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [bapnTE9qtzAYbkzdVd24f8rZrgrxo/fY]
X-ClientProxiedBy: SI2P153CA0031.APCP153.PROD.OUTLOOK.COM (2603:1096:4:190::7)
 To AM6PR03MB5848.eurprd03.prod.outlook.com (2603:10a6:20b:e4::10)
X-Microsoft-Original-Message-ID:
 <20240711111938.11722-7-juntong.deng@outlook.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR03MB5848:EE_|GV1PR03MB10233:EE_
X-MS-Office365-Filtering-Correlation-Id: 66ed3f69-6d3b-414b-577a-08dca19bd029
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199028|19110799003|8060799006|440099028|3412199025;
X-Microsoft-Antispam-Message-Info:
	8+E1uuubuON4CR3BsKwi410zpxefQL/j4B83dBofgxmBxqcE/W7PNLVPAJMUvyBbAemoaTDahD/rLzSMAnIocZ5ijn2FQmq3fe+u+84Rj9YRfXV7BhHwwFEsvTWrvs05hIHTyc/oTpqaCI2CLXQLc0miVS2ewYnQB8MTa6Qj1VOu/YocdUatQciNLGtvmodn6B4HLbouRpQMwEbvGKlIGnyYUNViXCwKeL2bHMLYO5terFGgu06rgOtgnAXU+xw1wlhY6j08h4K5jzzk27L09eYaKdZ0uty6exqk30YwLDpMnv2SRa8mloy2i+jd/ejPw0keotOBKlNg9XP7FG763wYfPjyEKb1qlxpUngQxpRfxCELgNAUNEEbtqiC4obljLGNKcyT34UvXMpYdUrbdNSCeVLW+kkAVlzMvCSIiqKNnoKdLgHkvflLWgwMAuoc4fol7ErVGjduwDnsMTJqKsthxp+wU/Mi/0aD7B3ahkTq5GFJkdA/at4mi/9vSheIud3Kq3PcU7MJ2Ry+HzjAUH37I8iD4VxBiyt7Bwf0ucpRUg/BmGDN9sDRvwi+eJKxX9NsgYUqQX/fv9btcIvH17sg9TYv83WNorIGshhr0YyyrfogMuDcG9blzwFJCO50BrIc7owVrqErzykllYmisBQ==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?U3CLBYUYau637LklFEJrDeSqzcJhqt9ySwipSrdWrm5xAdJotlMDoNKYBFoc?=
 =?us-ascii?Q?Azfl0o7z91CGLDu5BIsGcXfLT3Yp5BkohHqr5+gTabC8fcpxQYsIMTMWjAq9?=
 =?us-ascii?Q?HVMaEisr4ujNyz1KVI2N6xSJDGM7a4zrANJ+Hd5H+lPuobfrA03BEUx2ETHI?=
 =?us-ascii?Q?Vn9AOeUhDnHH5PCAQpBq1m/1Sj81T/4V20S1squZ/IM/Ne/OlSPKvHDzGl5V?=
 =?us-ascii?Q?iB86VdgH18TfZyW4R30lz6hmUspWBj6PrVxOqVr7oQMj4tl+mmqJCMw8fBFw?=
 =?us-ascii?Q?ZNZdCLUQcuEY1aOQOZCkvcBOhfB4KP0xdt8YuXZSjNfX6Cne96VDEiRJay9T?=
 =?us-ascii?Q?ggpZ/BXGv86YYAFFHkLbiyUwHqvknYw86rPoEGTr0vLiuNhh5ZkX5BzqtN66?=
 =?us-ascii?Q?8dDlOc9K52ezQrpj1cGq5Sp83saMTjAF1ySw9/wwRlcm0CIwhg1tEpuktvE/?=
 =?us-ascii?Q?i6r3HyjmiQmxj59FMWudGGocRdtUWdRpPO7einOrTZyJVzi4MNERf3B46dNA?=
 =?us-ascii?Q?QHd9YKARZ7wuVO3Ttpb7z75XpPcffdlbpkE76KBcXeTHzV9MVyecsK2Y/MvB?=
 =?us-ascii?Q?taa+vdZ0RXpJmzEV9IK2qWyZIWq/L8Gxr+lhHHf5MH1AhyHLcYG1HltD7ZdK?=
 =?us-ascii?Q?rgoZYKOF1943T8Uhd/WBN0f+XC8IbNUJuz7HyrJXKEpPSyrshkqiKFLFN+qW?=
 =?us-ascii?Q?w6CwnXW3XXYUKuqyApkqdiXTnaLjTe1rbpTjKx3FbwVPBOuW/pPvRrlQTeme?=
 =?us-ascii?Q?B35gr9X1p9szH0cDhq/eU6ENQDOFil66F7GENGS1ZpwA2Lx6CNZuiKyK32TA?=
 =?us-ascii?Q?PNg09/8UdDASK50So2R3kZaDnXvdfXUBX0KjW+wjmZoHfeK0W0pGlDcRHCwA?=
 =?us-ascii?Q?hXcBgGSKzMqzH9Wt+jZW4+8ETojYYalLF3csDXiytARXGLQ5NLXgI2qfrnxT?=
 =?us-ascii?Q?Y6xTaxmfonkUdG1oXIIipURr/pCiylWKxAqMpVEyX31pVl6vmdE5eUBAWwzC?=
 =?us-ascii?Q?bfjhtuWajt+zJBX9iHI7EsYVILQA2VFOxnAi763P/t0CfP5kpPfFKGM8FUQK?=
 =?us-ascii?Q?DprXHwd/iQrBInM1kGJbHA2P2XFEAGMZlAHu5br6jtINsgfIH/jCu/JrJwo2?=
 =?us-ascii?Q?46pEsoyX218mTLbZRc3WVNUkiRDROl2oxOX/Z218sWkCeRltAIEbVazlZE1Y?=
 =?us-ascii?Q?Pgpzrh+nb3AITQV8BGEviGJO/kpDKJPDTa+8JZJf79h6zF5iA0UaY4hvrsU?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66ed3f69-6d3b-414b-577a-08dca19bd029
X-MS-Exchange-CrossTenant-AuthSource: AM6PR03MB5848.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2024 11:22:56.7131
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR03MB10233

This patch adds struct sock related CRIB kfuncs.

bpf_sock_from_socket() is used to get struct sock from struct socket
and bpf_sock_from_task_fd() is used to get the struct sock corresponding
to the task file descriptor. Both kfuncs will acquires a reference to
struct sock.

bpf_sock_acquire()/bpf_sock_release() are used to acquire/release
reference on struct sock.

Signed-off-by: Juntong Deng <juntong.deng@outlook.com>
---
 kernel/bpf/crib/bpf_crib.c | 82 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 82 insertions(+)

diff --git a/kernel/bpf/crib/bpf_crib.c b/kernel/bpf/crib/bpf_crib.c
index b901d7d60290..d83e5f0e8bfc 100644
--- a/kernel/bpf/crib/bpf_crib.c
+++ b/kernel/bpf/crib/bpf_crib.c
@@ -9,6 +9,7 @@
 #include <linux/bpf_crib.h>
 #include <linux/init.h>
 #include <linux/fdtable.h>
+#include <net/sock.h>
 
 __bpf_kfunc_start_defs();
 
@@ -45,6 +46,82 @@ __bpf_kfunc void bpf_file_release(struct file *file)
 	fput(file);
 }
 
+/**
+ * bpf_sock_acquire() - Acquire a reference to struct sock
+ *
+ * @sk: struct sock that needs to acquire a reference
+ *
+ * @returns struct sock that has acquired the reference
+ */
+__bpf_kfunc struct sock *bpf_sock_acquire(struct sock *sk)
+{
+	sock_hold(sk);
+	return sk;
+}
+
+/**
+ * bpf_sock_release() - Release the reference acquired on struct sock.
+ *
+ * @sk: struct sock that has acquired the reference
+ */
+__bpf_kfunc void bpf_sock_release(struct sock *sk)
+{
+	sock_put(sk);
+}
+
+/**
+ * bpf_sock_from_socket() - Get struct sock from struct socket, and acquire
+ * a reference to struct sock.
+ *
+ * Note that this function acquires a reference to struct sock.
+ *
+ * @sock: specified struct socket
+ *
+ * @returns a pointer to the struct sock
+ */
+__bpf_kfunc struct sock *bpf_sock_from_socket(struct socket *sock)
+{
+	struct sock *sk = sock->sk;
+
+	bpf_sock_acquire(sk);
+	return sk;
+}
+
+/**
+ * bpf_sock_from_task_fd() - Get a pointer to the struct sock
+ * corresponding to the task file descriptor.
+ *
+ * Note that this function acquires a reference to struct sock.
+ *
+ * @task: specified struct task_struct
+ * @fd: file descriptor
+ *
+ * @returns the corresponding struct sock pointer if found,
+ * otherwise returns NULL.
+ */
+__bpf_kfunc struct sock *bpf_sock_from_task_fd(struct task_struct *task, int fd)
+{
+	struct file *file;
+	struct socket *sock;
+	struct sock *sk;
+
+	file = bpf_file_from_task_fd(task, fd);
+	if (!file)
+		return NULL;
+
+	sock = sock_from_file(file);
+	if (!sock) {
+		bpf_file_release(file);
+		return NULL;
+	}
+
+	sk = sock->sk;
+
+	bpf_sock_acquire(sk);
+	bpf_file_release(file);
+	return sk;
+}
+
 __bpf_kfunc_end_defs();
 
 BTF_KFUNCS_START(bpf_crib_kfuncs)
@@ -57,6 +134,11 @@ BTF_ID_FLAGS(func, bpf_iter_task_file_next, KF_ITER_NEXT | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_iter_task_file_get_fd, KF_ITER_GETTER)
 BTF_ID_FLAGS(func, bpf_iter_task_file_destroy, KF_ITER_DESTROY)
 
+BTF_ID_FLAGS(func, bpf_sock_acquire, KF_ACQUIRE | KF_TRUSTED_ARGS)
+BTF_ID_FLAGS(func, bpf_sock_release, KF_RELEASE)
+BTF_ID_FLAGS(func, bpf_sock_from_socket, KF_ACQUIRE | KF_TRUSTED_ARGS)
+BTF_ID_FLAGS(func, bpf_sock_from_task_fd, KF_ACQUIRE | KF_TRUSTED_ARGS | KF_RET_NULL)
+
 BTF_KFUNCS_END(bpf_crib_kfuncs)
 
 static int bpf_prog_run_crib(struct bpf_prog *prog,
-- 
2.39.2


