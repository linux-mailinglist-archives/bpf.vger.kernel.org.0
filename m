Return-Path: <bpf+bounces-34545-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E542D92E689
	for <lists+bpf@lfdr.de>; Thu, 11 Jul 2024 13:26:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14C701C212DF
	for <lists+bpf@lfdr.de>; Thu, 11 Jul 2024 11:26:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B91B016C453;
	Thu, 11 Jul 2024 11:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="tWtCykOo"
X-Original-To: bpf@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazolkn19010014.outbound.protection.outlook.com [52.103.33.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A09ED16B75F;
	Thu, 11 Jul 2024 11:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.33.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720696938; cv=fail; b=ZZeC1/bfQ5Zw4UTyaffYB4miIhFZt9fqGTwv6zGln0fmABjHSDhyAsLjr1wBASYvlCeDK3bS6kf6PYdqasi99lKpW0k5rzPZsWLdWCDH9QNFxaRodGi8oSPmxmmx54huXNJMrUsPo+iI3ik9nA7GGlQr/54DWKKYmAtIkDgXcOQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720696938; c=relaxed/simple;
	bh=nhvKRb+Yls5UR7AMA4Dx8jWAvsk+gA+QOEFw0H1E2Jc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sKatjHUoKX4rAKi4N8LkgLlsSVlHJ3gjbwuKjaZ+KepnNeuP+aAPOQrAibw2TdWRWo8afrXQwOicSxU2Xod8juNn7Z/Vnj3tfxk8qtg5Zd+vlyjqTr93TsgG760qrapOVTNfPvalQ8cflUZzWRD/MKlM6Eo75jDpYwfeANBgfpg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=tWtCykOo; arc=fail smtp.client-ip=52.103.33.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JZo2ydwzjpNGJ5160nJ/ik1fVsqPGFt5l4O5D5Y4SI+D2MtWb2NwiWSLwHQZPttECOoV5+t6Gqx4wvE1cunQuoI2c2i0mBX2KYNIHpYbq+f0mqJ8eyqZNX0L0Bqgs94PXF2mwAl7F9XdcfU7dp302LqwQpP6+xD+56RnaP6ZwnbpmuVphr0Kg0eW9zyxleKNA/Bko3kcD4CXUge2mh/nEaqeuswGgCiArM2gTwrf4THwWeaS55Tfgi6i190UdA9v/KOOsWNxUD71bcOBCn5XgDR/VsnnxHa14FHSzk6yEoSeMabSZTwRltz6EWEpcxLNYV8awxq1cREZ4ZJbk6Tyjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D01jDLQAupn+yFXzKYkZ/4dpOZ4AixU+vSFOGqybkRU=;
 b=Zs4bzAyAJT6j64cevxxAnp5Ol1NqoFtUYff7t/etZZ1v00HAZUDUOGoRtBqHIhRSzQdKViojn5PXt+SVKHjDUQ4gfw04LEcSm8jDrkeipwTYDbAqcjOd6Ert05p8Mn2BEQp47gjBY31APMVytQ9XoZtXQ1FiEe1ylFlsAZSnVSJ4pptJmHPOOjMCcl3pCOKax9fzY8M4KmXDAJuM1LlhnVqsGVchrOTCCadiHyk8bKEfGpr9e0JqzYc98494YnyWqD149CBvLORMC6nborpoAlRZ/Gc0qHIT38CXLzzmJXr7r7Ea/Ib7eLC7iEAhTYgTn3sKMTXq6VltvJrOKnQA4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D01jDLQAupn+yFXzKYkZ/4dpOZ4AixU+vSFOGqybkRU=;
 b=tWtCykOoioKGGpff62Eqcv2MlOYsdLYW+Zei3u6zf481ksC/w5UWhetp4H8ipEd5xUsaO1iGr3nmH3Kp2k8sc+y5NIs2F/zoJrgGoeCsO89jS8yBgyVWHoiy4aqFHzKaAQIMHsnAME5dd7hJxKbpS/VYBPfzVkqw/zu3NM9r6+RSt2Ka57UKOWtlCCZzpERPCTHS2TYbwXc+ttwyTY5G9ltKtieBIxc4cJwiYa+amOxcTabdPypTm3WgXqNveV7DCheSvzjUkQxJx9+c5wXK0Zw89thyrRwzeZNL0ACXAhOMh9FWxrkFePKC/yhT5lSQ2cUhVtnvfBNx9WqlYzAz4Q==
Received: from AM6PR03MB5848.eurprd03.prod.outlook.com (2603:10a6:20b:e4::10)
 by GV1PR03MB10233.eurprd03.prod.outlook.com (2603:10a6:150:166::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Thu, 11 Jul
 2024 11:22:13 +0000
Received: from AM6PR03MB5848.eurprd03.prod.outlook.com
 ([fe80::4b97:bbdb:e0ac:6f7]) by AM6PR03MB5848.eurprd03.prod.outlook.com
 ([fe80::4b97:bbdb:e0ac:6f7%6]) with mapi id 15.20.7762.020; Thu, 11 Jul 2024
 11:22:13 +0000
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
Subject: [RFC PATCH bpf-next RESEND 05/16] bpf/crib: Add struct file related CRIB kfuncs
Date: Thu, 11 Jul 2024 12:19:27 +0100
Message-ID:
 <AM6PR03MB5848DCE9DC6D96454E9C3EBD99A52@AM6PR03MB5848.eurprd03.prod.outlook.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <AM6PR03MB58488045E4D0FA6AEDC8BDE099A52@AM6PR03MB5848.eurprd03.prod.outlook.com>
References: <AM6PR03MB58488045E4D0FA6AEDC8BDE099A52@AM6PR03MB5848.eurprd03.prod.outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [q/Zb/uX7ndiqEOGPuH+FUeRqgzpjd/B6]
X-ClientProxiedBy: SI2P153CA0031.APCP153.PROD.OUTLOOK.COM (2603:1096:4:190::7)
 To AM6PR03MB5848.eurprd03.prod.outlook.com (2603:10a6:20b:e4::10)
X-Microsoft-Original-Message-ID:
 <20240711111938.11722-5-juntong.deng@outlook.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR03MB5848:EE_|GV1PR03MB10233:EE_
X-MS-Office365-Filtering-Correlation-Id: 843fdfe0-4773-4dcd-927e-08dca19bb66f
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199028|19110799003|8060799006|440099028|3412199025;
X-Microsoft-Antispam-Message-Info:
	GZTjokqCpZ3Bzpk5Erx9rASI4Y54akaB4m6NOyZwOuQIUlGnVAHzF8AmRLYArN4HJqurrddafTulokRjwfvELek2ibQaC3yHjdqzSI8TqdWnCYEQ0UjllaWSNALJwfkRgNUnlqV+Idx1k58seUigIdsS71emxEqrQsF8kDJC+7wkBAeet4ou2YKZgqUtXjtGMMnATWM4uUIQuyCyxj5+7VYNd9rWos84nBidjkaE8L/pRh5QqVPewhMlY5vsbeapZguoeaqbkSV8g1mdND1EDzeIgAX24cEkUgUnMKNe831jDB2/iL39db6q3Zdh9WV/112c8Q9yXJTyCbFqMQuNBTLFqPFfvEH6Hn1hItyq4yKnxuJS+yJMLcODa03qdUVcDuO0odmYKmHDLdEC6o/Kr8aM3kAmN7D0NHdqnuqwG+r+8JMlL2hiGtGaHyqHHD4Eo0GYusp4y6Er/iDTewU7+t5q3rGvZ1ko5MYvTwEodpi5d8YHTv1fzxen3dslQQn5ld8tgCRZLVWkvfdebdLrn3tBF6VFWBAPxzxMAso7tOkFiAEPbUdtfjw8wTKPLtnvp5RqapHrbl6us9Iumk9A8zeA90WD6tARvKaorqVlOduVSni3u0AoEJlL/VCbiKVjxsak8SlAB7Myy5CJQOUNqA==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?nVxyAOAHnQTeLJoADNt7ydSW/CxxyQ8MkqXqiG9wKnjj+PVIpxp4SzNbaWJo?=
 =?us-ascii?Q?7IFqpha3n1mpaws91CJgikYsCuJemgQOSNpHdeeDHncWl4KkmgIERPQxN0vz?=
 =?us-ascii?Q?gIU+rCQL38MeS+ZRPdwVkMP5oWKjBFBLUGfFPylW7ttx1SjZOiYHMcrOR/SK?=
 =?us-ascii?Q?nwCsUyq71UPqtseL57KM9Ucppes3gPnU15+UB8X83UPs1VklfOnoP1clQUrw?=
 =?us-ascii?Q?KwjatJSKUMzQpP+i18YKKwuKzN90WsUkbnG8NVT7gwHrqVzOxj1qfqY0UzIY?=
 =?us-ascii?Q?RuPizJDrbtqPB4EvZsc2ofl7iwY99jEAGBZ2caL07BamdibQSBAh1wQWggx1?=
 =?us-ascii?Q?fh9sNBImAJwDYmSznOBEAoSQmBGaBpE+NW69Vrg2nH5wQf97Qq3tbYcBNfex?=
 =?us-ascii?Q?wGR8jv0Qj/xbFt4cCMaAFUWPOLr/Gx4INQakV0lrNfh/3/4cIZGwDqKMVvdJ?=
 =?us-ascii?Q?XRW8WYeywolomkOiZA2ghtnHhx86QXzsj3pPo8Tfd7AsBBuMj4xXyl3XsMMv?=
 =?us-ascii?Q?ClbKtcGXwe/CIWwaLFBe6vwBLece368dmet/gP8gG+mX/eIZ25g47WsVD2h/?=
 =?us-ascii?Q?xzwQwOkUcBb/61tToqcs048fEI1p9ReQHY1iIzAI3LqnYd/KKdafW+VdeiXm?=
 =?us-ascii?Q?9pCYd1BTvfrUKXRCL5n+D74hPe5TpMdZYPsmYarbFBq3R8K11CtZaT7JOYXv?=
 =?us-ascii?Q?/HkDVRj3lehuGkCgSqxXH5kA87S2mSz4vhDUHclnkWzyR6seLhTOjNbVz24t?=
 =?us-ascii?Q?2RYz6DXAeqolmwExuF8tkcPFPKTIlhzJ+bKufo5mC6J1Tj98vpBq7Za/rtrW?=
 =?us-ascii?Q?GA0AJvduVPltCXGOZL86v2HkkcEdsI5JzbHlj/F37qH4LlFuNbU3+FfE6bzd?=
 =?us-ascii?Q?AFD1JiPKXOL33HmadnHFNArBiu8iTfMpfHUmBr1Jh2jS4L4YPLAWqPdYr7cC?=
 =?us-ascii?Q?TpsQnReac6MGbsA0l1mEVFdajaBynSbaHmSiVrVgj9ugoHaMVBfAdC4qZVjm?=
 =?us-ascii?Q?MevbOBQL6/m3eAl37Kpwt3IOe/JpRqn2uvWObgCBxRmbvX5RLouxjDk9EjrS?=
 =?us-ascii?Q?TaSDG0fj5MpwNSxaXzBBWonZ8GJp4nMcHRPxZppChTO7isp9kQg8r5DWYOaw?=
 =?us-ascii?Q?yMaywf33AZwq4aYOuIiDma/n49B1lcUr9qod6dFXeuitP9L3tjjRG2xkYvua?=
 =?us-ascii?Q?UqvvQbYMoqJWpOUEVpGZRetBisPHv7P16fiHhOreyZsH7Talm8XzpEGPP64?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 843fdfe0-4773-4dcd-927e-08dca19bb66f
X-MS-Exchange-CrossTenant-AuthSource: AM6PR03MB5848.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2024 11:22:13.4827
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR03MB10233

This patch adds struct file related CRIB kfuncs.

bpf_file_from_task_fd() is used to get a pointer to the struct file
corresponding to the task file descriptor. Note that this function
acquires a reference to struct file.

bpf_file_release() is used to release the reference acquired on
struct file.

Signed-off-by: Juntong Deng <juntong.deng@outlook.com>
---
 kernel/bpf/crib/bpf_crib.c | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/kernel/bpf/crib/bpf_crib.c b/kernel/bpf/crib/bpf_crib.c
index 9ef2d61955bf..1c1729ddf233 100644
--- a/kernel/bpf/crib/bpf_crib.c
+++ b/kernel/bpf/crib/bpf_crib.c
@@ -8,13 +8,50 @@
 
 #include <linux/bpf_crib.h>
 #include <linux/init.h>
+#include <linux/fdtable.h>
 
 __bpf_kfunc_start_defs();
 
+/**
+ * bpf_file_from_task_fd() - Get a pointer to the struct file
+ * corresponding to the task file descriptor.
+ *
+ * Note that this function acquires a reference to struct file.
+ *
+ * @task: specified struct task_struct
+ * @fd: file descriptor
+ *
+ * @returns the corresponding struct file pointer if found,
+ * otherwise returns NULL.
+ */
+__bpf_kfunc struct file *bpf_file_from_task_fd(struct task_struct *task, int fd)
+{
+	struct file *file;
+
+	rcu_read_lock();
+	file = task_lookup_fdget_rcu(task, fd);
+	rcu_read_unlock();
+
+	return file;
+}
+
+/**
+ * bpf_file_release() - Release the reference acquired on struct file.
+ *
+ * @file: struct file that has acquired the reference
+ */
+__bpf_kfunc void bpf_file_release(struct file *file)
+{
+	fput(file);
+}
+
 __bpf_kfunc_end_defs();
 
 BTF_KFUNCS_START(bpf_crib_kfuncs)
 
+BTF_ID_FLAGS(func, bpf_file_from_task_fd, KF_ACQUIRE | KF_TRUSTED_ARGS | KF_RET_NULL)
+BTF_ID_FLAGS(func, bpf_file_release, KF_RELEASE)
+
 BTF_KFUNCS_END(bpf_crib_kfuncs)
 
 static int bpf_prog_run_crib(struct bpf_prog *prog,
-- 
2.39.2


