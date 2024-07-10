Return-Path: <bpf+bounces-34431-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D534692D87C
	for <lists+bpf@lfdr.de>; Wed, 10 Jul 2024 20:44:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 54F641F2433A
	for <lists+bpf@lfdr.de>; Wed, 10 Jul 2024 18:44:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE299196455;
	Wed, 10 Jul 2024 18:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="lri7HN3G"
X-Original-To: bpf@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazolkn19011017.outbound.protection.outlook.com [52.103.32.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF4A8195FE0;
	Wed, 10 Jul 2024 18:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.32.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720636979; cv=fail; b=KQjiQ8SAa3fxq2uHtg0KrLQoRCnea3D07rrrNnZDURe12nbiq/JY+IAvEvxb+F/0u2mG7ifKxxAORRTu4QsydBxwuHB05YRIm6qiL29GaxYY/NLBm/j0gYUcyvQ4tt6r9rRqNcydR1LOifWJzNNeAvKEXzzU1z6zqC1T8AL4Lfs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720636979; c=relaxed/simple;
	bh=nhvKRb+Yls5UR7AMA4Dx8jWAvsk+gA+QOEFw0H1E2Jc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BkgKQEHx7UYAP2FZ2umQ0TvEHBttEuAtGWbq39KNwJaOsh3A0aEYVd5jnG+D7NqqbKlATiIKhO3wnCgivdZsao9e60y0g87owxR1eJSBnMSnbyw3gUR1PgP3ORTmadPCguUWdn2d7RgyVmsi+3Vv9WcNnKrRoaevIwJB6n+aZBw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=lri7HN3G; arc=fail smtp.client-ip=52.103.32.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G2t5MlMMYvEDSdgP50bEfXS/ekmTt377yOMrP+2Xe3k3eBQO11QbPpmKgGKeHk183cx6gx7izdlE64qBNSQ2xobzNwwKcAeLW10QsQ5DUiFRqz6QY1F2BzFwR/UmC4nw+Pq/Zqi+/zl3wFgin7U0uKgT9g8VOAehvlHJhPG5UNYIRIXUOmfAHObkFeTGjWGZ5mh9YXUsgJQ7p8tph0ui93T48ZPecOzW2BEHPe2fNV44nyLp2Qm0bFTXs1BRro5I3u+8MALiRNZQ/nvTbED3QWQ/MdZecbEyC1oIg/X4EkF5q6rb94QE80RZ+0ZGbnAEw+8kFwP4mZ1KAOCgK89hJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D01jDLQAupn+yFXzKYkZ/4dpOZ4AixU+vSFOGqybkRU=;
 b=BgGUc8/ba0TOqnjM/MAmQIkOXSB1c5wRu7fA4E68JNT0kcQPO3zryaY9wWccmIK9xIY5t9LcBEf7mK11d38+HbWY72R8KT8RfyuRqAvy52OCAlOLCBOsozgv9W4Gx536DOMwWmbri+Ad8da7dW4Jvcd0iJgVAAsIeT+Pke6qtTkmj/5C4fm8UWdfitxP4iXkwpXM4kdbe3kfjLzUzAPQPaRU7lalCa2pkSfTeyLAIzBI4hy5uQCRfRfO8PKXJGNakxuWnFeBza2lMydWJRAZzhPiRJchDKo5VT4A5AxF8XWg5HWWRZkgOZkGDYXwmbOabtNMch190gAK8XFnvl/q9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D01jDLQAupn+yFXzKYkZ/4dpOZ4AixU+vSFOGqybkRU=;
 b=lri7HN3GlwPef5jCU+37FvkwkC7Qk/LNukmBv94d5bBBE3yE2xOCpChB3czMksGwguJ2JNbdsEnOqxNgNzSmW+zhcjl2KiI1a6ZzsPoG8/sgvVAqAXJB1zE/Ya8q3ZKnkG4jkQqrJAqaI5MUoBwmuVIJs+E4lqTsPFhB5JHul+CEpiFhI+B0WjMtcTHiulF1mkXQyoaor9vFWJsoeFKpBVGWAFIUAa+K35C/c/f85Ucs6LFl3f8fIYx/khvj9tANfFvpcfX4ObRuuK9icr9PCTQD0ZMLzuCIVLv7qlYgFPTvsIuHIOKEEAHLcKHA/STxDi3E7RKC5mGwQSuvQPKpCg==
Received: from AM6PR03MB5848.eurprd03.prod.outlook.com (2603:10a6:20b:e4::10)
 by AS8PR03MB9935.eurprd03.prod.outlook.com (2603:10a6:20b:628::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Wed, 10 Jul
 2024 18:42:54 +0000
Received: from AM6PR03MB5848.eurprd03.prod.outlook.com
 ([fe80::4b97:bbdb:e0ac:6f7]) by AM6PR03MB5848.eurprd03.prod.outlook.com
 ([fe80::4b97:bbdb:e0ac:6f7%6]) with mapi id 15.20.7741.033; Wed, 10 Jul 2024
 18:42:54 +0000
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
Subject: [RFC PATCH 05/16] bpf/crib: Add struct file related CRIB kfuncs
Date: Wed, 10 Jul 2024 19:40:49 +0100
Message-ID:
 <AM6PR03MB58481D84DFE9F207FB1A8CD299A42@AM6PR03MB5848.eurprd03.prod.outlook.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240710184100.297261-1-juntong.deng@outlook.com>
References: <20240710184100.297261-1-juntong.deng@outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [4x1z7pS1xOztjUvq6mtEagD+eorIqI+n]
X-ClientProxiedBy: SI2PR02CA0027.apcprd02.prod.outlook.com
 (2603:1096:4:195::14) To AM6PR03MB5848.eurprd03.prod.outlook.com
 (2603:10a6:20b:e4::10)
X-Microsoft-Original-Message-ID:
 <20240710184100.297261-6-juntong.deng@outlook.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR03MB5848:EE_|AS8PR03MB9935:EE_
X-MS-Office365-Filtering-Correlation-Id: 322fd70f-dc05-4eb8-0166-08dca1101c54
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|8060799006|19110799003|461199028|3412199025|440099028;
X-Microsoft-Antispam-Message-Info:
	wu0oA7RPaFBO6nRHuJcvG0E11fd/wmWFGedEixEw0eVs2tC2N4RwRK+BlhM3oYltdnaXho5a0HHdJ00BK3/gmgU/Yu7u8sfX7NjvBHNGwsTukd2Yc2nXjHpfHX9OzAraY75MgyRKXvzoh0UxBDZyDaewn5ie3fgsijP/pfTK7rkEf4QPS0x6WpIBKKV3eab5NgIzy+hD8U3qz7BUXWPkw5FBj7PGLzYiVPpeTP89TwmS09QlAxyWC7ZCKpewvXRDVb/QRzn/R8HYlCfWaPJPc6ETb89LAuiqlqHsxom8b9Z3lQ6s18Zrg3uv4L4FzQS05qrRsVspfxe0zVgLx1FinAFxX3yfNWGdXj+NaVtGdX19QhwB+gFmDVHj632YJXJE2CMIbbniq7oWRRAizlL7UjrKe6LL7wBDW7R7uW4E47olZ8i+rFQIidDxd7IzqVrJ4QAfzHr+s4e0ewwxshTHihC7MMk/DQAiuwVXJGMVDtUIQwNV7lwcmqEgKmnNupUjxjQ5k8HLGgxTkFJ3K/n2NSVxePohVJO+4QsXJ93wz2tBG+TRlrnBQgsbzLeE9RheiZb6Gh0/gEyPT+vI3lKU2iVR3sIFP/u7gzU5U+BUVZ2MdsntkLVtYR6+QlJ4GoxNPV3xqHb5uEUj2F1vKQVuoQ==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ECmLdgpXJiSixD3SDlyVfogBJQi+EQKDEbfA/cUx6XGbVnukpQtkRZg2ZKwa?=
 =?us-ascii?Q?jCw3LFi1xRf/QIsRaCypHdZcuZAixQ4zSSDlZgQsYVI/uPNdBcCFvNmQVd5i?=
 =?us-ascii?Q?7jYnpZkL4C2zSyW7nhP/JVdFb57yL06tH0ZFaqVeELaucfPtL4vzipHDvYMX?=
 =?us-ascii?Q?lfDGFB9ziwrwxDYeyrrc6tzZG8gTpT+DZovwAsslH8aARICtIWsIVL+vY5p/?=
 =?us-ascii?Q?FRL/Vm2iCqSxHF6Hq4UTXulAA9U5kfWR+nxa9BAiSUUZyLotz2dDuDx+p3JT?=
 =?us-ascii?Q?Fzuj9GGC/hjT0diidvXukqFtWMgdYhidug1Q10nGqcepWYHdo5C2u5rWpPah?=
 =?us-ascii?Q?UzdyzE0sPwUlHlRYzsgrqCvRlmHGDHiK1A5KiV8ogebQ5rHiojolBMoMIZAk?=
 =?us-ascii?Q?vtFYT1iXSa+UrrW3fhrnNT+ooJamKQP2d+9RZDmuK1td7R1EXJxKPb1v1bxq?=
 =?us-ascii?Q?hkn6SLkTxQSSWk0L7oQxUayFvPpUhVtot9eLTj+8NkOmECcrOOPI46ohE6Ef?=
 =?us-ascii?Q?L3CLDQf4/fhDVdonTPoBpzu0FTjzM9+PcAj8mraPGSIFaT+GUur0RreUNjs1?=
 =?us-ascii?Q?rLp96ernFO3H11F7vdY5bWjZWqGzSbNYAl3dPhtg5vKWzwYEcD4/dJnvTFLo?=
 =?us-ascii?Q?0oELHiFweenZf9LjYa4bjkHSbNMYGWut0VoM53YIuJMqC8jYGkhMH6pDsmc7?=
 =?us-ascii?Q?B6CMdw9QiFoh7CwRdBCS2GmaJZA4NBU0XSq9HBDIIPt/I7Faacz9UF7BFUPX?=
 =?us-ascii?Q?sR/VC6Q5MG2orlLX95EC+FFWuP6y4R/j0CCQf8LDSFCvMLmrlq3n/O/rFc7r?=
 =?us-ascii?Q?xXwukd4qPewRrM3FVBCJNMZupscQ+aEh3YBFNefoH5C42/de8HMqaTJqA0Dj?=
 =?us-ascii?Q?aVJcS8feH9W6pBYiUGHa06ZedvnI27cA62dxT9HIH6K5xN/bOfo8fkHOgnIZ?=
 =?us-ascii?Q?VzjBaV9Znbfu+LP5AHZyA2TbcYH7NMeeRa8HXrI/41kvHUjyP4Kwo1HokV3d?=
 =?us-ascii?Q?W+K9+FL3nJPgJNfqBf/kFr9lmhwe5Fwb15eb1X4wzoZwRH/ZNA4UdeqXHMHU?=
 =?us-ascii?Q?O6tb2nZIcTwlB3QRzRph9Yao2ugF8Cq7pDTptSEL9MGQhcAyw8EGB9F1x+DP?=
 =?us-ascii?Q?CXAPyrBP/HCScUQ1IZ8o6nSoGMKK9IKcJ3eU2sPYUWbzfeerr8oWjkT9NNVb?=
 =?us-ascii?Q?IeInGvaHYor/cl9Z+8f9NvGE256uKKxSG1VAj2kVgwvljMxSE43RMhAlFJ0?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 322fd70f-dc05-4eb8-0166-08dca1101c54
X-MS-Exchange-CrossTenant-AuthSource: AM6PR03MB5848.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2024 18:42:54.9021
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR03MB9935

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


