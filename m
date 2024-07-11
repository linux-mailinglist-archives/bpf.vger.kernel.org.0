Return-Path: <bpf+bounces-34544-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E13392E686
	for <lists+bpf@lfdr.de>; Thu, 11 Jul 2024 13:26:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9717EB294B6
	for <lists+bpf@lfdr.de>; Thu, 11 Jul 2024 11:26:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD6FF16B38E;
	Thu, 11 Jul 2024 11:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="Oz5646qp"
X-Original-To: bpf@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazolkn19010012.outbound.protection.outlook.com [52.103.33.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7921416A954;
	Thu, 11 Jul 2024 11:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.33.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720696932; cv=fail; b=gA+OVlVvOSWJWiE35ihonWmZ/QwrUf42oHifqd+MFz8/hd2VOJ+86LkGWuxNoqosZAAneo1oHYF13l2yB/gz/s/vBSHYTHghezkZNJ227y0w9jbu8raWuSOsEB2p8tqk5Z2G1teOeuTN/WUDNDCN1K9NNpoA/LKG8LivWkZBhaM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720696932; c=relaxed/simple;
	bh=toLCOAeQcWKVCy6tBoaJfr6rl22TOb92yFiiPxWFopU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rDfclATgGuhkhyzSXV+eKo63DOD7sIZqVOfw5QTWi+f9lPyP633bceVvoyjQTKS6Qm3NXkeb16Uk7NQThiB4fBa9VBZVUYqcyLbi8Y3xWwyWDlqJX1J37bUEQAUJAIqLBvRYUuTl3j7ZGKT+MGHdzjDYogJm9FNML7bRL35dJIw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=Oz5646qp; arc=fail smtp.client-ip=52.103.33.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O7jmNhew/JWpGqPAPJuGvHvc9ihabNDnUb7NBVf9V63QwuRu8NxdN1v84X6cSKwEOT93E3v/qgdz5mA/LQjtUjMeEgDeQs6+1LZviGN27l1i6ZbURy3+8AEbDj7j5uobRB1Xxni4HlglysriWextt5Tfxk1QqWu2Y4CnqxAFtZRjWheLGCpRZpNG08eIhSrd200i3BIoGKhZaeGTsLOEeT2zXPfb4MYeCKvjMEc5ayotnX93WBdS4UxvUbFNf1q/+Gt0qQN/CiY6GrOhetGcQAYKWEkEL4ze1nla98j/zc9FoUEjyVDXazJpjg0bT+BpiZwIuXNL43xFM0cVDpyCvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fs0q5gAh9cQAldUvCtX/itxD7miVjLG4u3q1LUKA9nQ=;
 b=pte1/scvLyZ5oP4R7lhH6xFLoqkzXGk21DnLFTosM2ZRewJf7KFs7nmZ/9V/V0wequwRPi8zyBtVgGkPgI3S4UJXhC2jA4YAqdGB0b7FTo96ihRJeuKykgTnWPQp9wfaNumVLOH8k4Mcx/B0gTLAAAypUqkiKKYIKDJCm5NIt5mk27K8+bwllK/qwkmJJBRYv5z3j63NUWTDbNsuACvSQDu3tMBqYa5h7tM7O/GwOlwMcPqj86CIR2j8VIuyb1+jEgsKkrplafI3KcVfhTGkxBCVvJ1TSjDpaFoAOS2tzxShTVCjJHYGReDBw+fREQGAvSPH9WslukX91pqDXeRM6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fs0q5gAh9cQAldUvCtX/itxD7miVjLG4u3q1LUKA9nQ=;
 b=Oz5646qp0u3NUYtBYKUzT4SXkERDUw0r6V95hU70h1QJHC780AE8UQbV9xtXA/OK+/HWjNqmtIRE7EgEA14fB1IEFwoFndli1OWs8vzntDdK018nLIr/tcbITTMNfNGBLIZZZN8Y2slkegr4LFRSnKDXcRjYmPXRtoEXuMzA1YtgB5n4lOIiHyat8eu18HffR6wxo223gh+toJBqFSA8GFGEhz0rQrO6YgIquT94Cifkvwj3s5cEgbN/Q9e0tISrHiUpryrbMogEXHUD1Cc/WJ7KQas4QZHLBxTWQEHY4o3xZQQaYMnEEJVDvsfkRoYRVB8mVbcB//Gml+6tvcMs0Q==
Received: from AM6PR03MB5848.eurprd03.prod.outlook.com (2603:10a6:20b:e4::10)
 by GV1PR03MB10233.eurprd03.prod.outlook.com (2603:10a6:150:166::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Thu, 11 Jul
 2024 11:22:07 +0000
Received: from AM6PR03MB5848.eurprd03.prod.outlook.com
 ([fe80::4b97:bbdb:e0ac:6f7]) by AM6PR03MB5848.eurprd03.prod.outlook.com
 ([fe80::4b97:bbdb:e0ac:6f7%6]) with mapi id 15.20.7762.020; Thu, 11 Jul 2024
 11:22:07 +0000
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
Subject: [RFC PATCH bpf-next RESEND 04/16] bpf: Add bpf_task_from_vpid() kfunc
Date: Thu, 11 Jul 2024 12:19:26 +0100
Message-ID:
 <AM6PR03MB5848A93446546D51C603933D99A52@AM6PR03MB5848.eurprd03.prod.outlook.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <AM6PR03MB58488045E4D0FA6AEDC8BDE099A52@AM6PR03MB5848.eurprd03.prod.outlook.com>
References: <AM6PR03MB58488045E4D0FA6AEDC8BDE099A52@AM6PR03MB5848.eurprd03.prod.outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [60o1QDuVv4m0Af2k7fDRTJYJ4ZQE8Rhb]
X-ClientProxiedBy: SI2P153CA0031.APCP153.PROD.OUTLOOK.COM (2603:1096:4:190::7)
 To AM6PR03MB5848.eurprd03.prod.outlook.com (2603:10a6:20b:e4::10)
X-Microsoft-Original-Message-ID:
 <20240711111938.11722-4-juntong.deng@outlook.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR03MB5848:EE_|GV1PR03MB10233:EE_
X-MS-Office365-Filtering-Correlation-Id: 8452af9e-5a1d-4d20-0ab8-08dca19bb2a7
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199028|19110799003|8060799006|440099028|3412199025;
X-Microsoft-Antispam-Message-Info:
	KlfKETdH5h5CyDV8LvPmJZRjcYp2tYgOB6kz8SHCj3D60E1lbeexHG+oQt5HViLGHtXBUD2Pn3/t3OcgDquz7Xgz2u4WAIzZiFDauIwQHt/IVdQWhxhiIrLa/HBIeyectKReJkEIfAou3aO+5+9YkxzmC0OtJ2hui5UvBJgkDqlKA+v0h8k7gYqPe+3VNG8ZOA7wXen2rZva9Ieb9g1+2JdzA4MVczjK17KYCq0lYAxm4qKTni0/jp0axeVZSaEtLQV7VKyB5fvvZnJHHj+9qD1B+nluU+d3PvcwJkn4Mb1m5HO8tA8iM8fV4pXDgqpL+acbesUbBOXZ4Lpf8xrahb/6JOqCr4pYkBdMw6aDNno4aTecQKM/g59ewLr/uFWMklIFOVw6ZvV3DKgPMIsPCfsigDox021zULWN/zRO6nCthFurkk2qS03KTvVQMVzpto4sjSwc4Yamib46XFdMoiPb+dyB/OA7faXxMcVFHHUpyeaSgL16EoQgaPJZQBJI0Pz7oX7eJudZHxpU4MV6qZpq9V0v4hPCQ50pJYkskaUjTQnTNph5aJtBmGYaibUi43M+P+/gHCdQpWNdlbIThlGOlPyCGEW8jhtRiFiCOV2QEGa0rHN4FDzdPkSMeYWzB0mEvvX2QJSuKPdKIPRWIw==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lAl+0cwwTIk5JFBrSlKXGkNRzLufKVeCgP18/jC4gbxwXbWDOvouUrqXNYdx?=
 =?us-ascii?Q?6JuutpjVZNUrKyPLSuPR/Puf5QdzvAW2aplaeX2pJk/7zXIrr/Sb2Q1nz87a?=
 =?us-ascii?Q?ng7B57fhfqXQR8Am4t1g1FRnFAUGrduisV2+S0i0cdmBcHcHPn19NbsodR/z?=
 =?us-ascii?Q?YU9E3cxrw9GHEWlD6h+nD6hjN3AdQHT6oRlm8wZmvaylo8w8ga0gffMFDqzs?=
 =?us-ascii?Q?hLdaSOc7OK8+FTKXoJew6nrNVn8Hd87slQb85MY+VTpC/G6HzlYmzjr+YD39?=
 =?us-ascii?Q?/UngdliQHlfe/5FKfxBVRIcMByFuW2K3PcdOVz0GkK0RPLIKS7fl/Cta9D2v?=
 =?us-ascii?Q?THv82/08zyMX1xJn3pBUt14iWMVXxHTCZLvl0SIj8nPi1BG97PC9q0aw6t90?=
 =?us-ascii?Q?bKnPnMRXzXo4jbtRSvCkUZISQ3CzCoBPagWNCkuK89/PzRD4fsL94QmgZDNl?=
 =?us-ascii?Q?clTWHnQhqlUBE1qqz+Kgy1NSAgfUpKX3UCsRJmLCXynqBoxkDzfvM9Kfbb4k?=
 =?us-ascii?Q?iLdLgqdrY6cTjkixK7YnoorzD2ai8km5R7XgKqIdd/s6C4OWVDQeeAAHJ+cY?=
 =?us-ascii?Q?PgyY9GaMLl1gRCEQ/n8CbW8/Vje9f8D8eU8jwo0Ptsu5Q7FU6Wyn4rylNBEI?=
 =?us-ascii?Q?Gx6HCC1iVYDKPR5yN/NuQEh1OsEnH8+3hhU1OeGiKP8ZAaP0f6izRAKf8Yap?=
 =?us-ascii?Q?ccIYQ8pk3KtGPUyjLnBnSkUl6e4zynQFiaVxQ5xdhK7LMFaT8OmMbJjSKF20?=
 =?us-ascii?Q?ng69qnF2AouHhq8m6c+XIfzNoIR4xSF0MtykuXjBc+2B0+ZfJZFbGneqx3Ef?=
 =?us-ascii?Q?xjxJvcdUfVKMbshJi4THbWoRCFjoapC/JXzFayHsgzArrfyeu38bxC9BEhcI?=
 =?us-ascii?Q?/khVgudIBwwQzXa1puLCTOVxPvtFW8A5uRNklhUkXbEyI+8ZDv1SRne+btpN?=
 =?us-ascii?Q?UUKafMYskPfVBqDB22YlsqSjuo4JSS50CBIPeP11S8nf+zlzNeuzX7UxRO1j?=
 =?us-ascii?Q?Mc5b+Xr6ZOLR9fPaLu8J6yKJU5d0YdbCV8Q1u0ICNK88IglA/5FvMfFYHq2V?=
 =?us-ascii?Q?bNQaKk/GlsW44obI+S0aNQa264+n/sV9sY1PbnjUQxaWsETb0ggHFu1gGLUk?=
 =?us-ascii?Q?zli7juGXZ80rSBBHApugkqgApf10AHOihnN4QMyzS0AvGxQjP/GUzL8ZI3xX?=
 =?us-ascii?Q?3UJ0hKZeK+7SFcyXsS1vZCCZM79TR5wbv3H571nxLrHv+p7J3RoqqCzL8zM?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8452af9e-5a1d-4d20-0ab8-08dca19bb2a7
X-MS-Exchange-CrossTenant-AuthSource: AM6PR03MB5848.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2024 11:22:07.1444
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR03MB10233

bpf_task_from_pid() that currently exists looks up the
struct task_struct corresponding to the pid in the root pid
namespace (init_pid_ns).

This patch adds bpf_task_from_vpid() which looks up the
struct task_struct corresponding to vpid in the pid namespace
of the current process.

Signed-off-by: Juntong Deng <juntong.deng@outlook.com>
---
 kernel/bpf/helpers.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index bcd3ce9da00c..15be713f6495 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -2431,6 +2431,25 @@ __bpf_kfunc struct task_struct *bpf_task_from_pid(s32 pid)
 	return p;
 }
 
+/**
+ * bpf_task_from_vpid - Find a struct task_struct from its vpid by looking it up
+ * in the pid namespace of the current task. If a task is returned, it must
+ * either be stored in a map, or released with bpf_task_release().
+ * @vpid: The vpid of the task being looked up.
+ */
+__bpf_kfunc struct task_struct *bpf_task_from_vpid(pid_t vpid)
+{
+	struct task_struct *task;
+
+	rcu_read_lock();
+	task = find_task_by_vpid(vpid);
+	if (task)
+		task = bpf_task_acquire(task);
+	rcu_read_unlock();
+
+	return task;
+}
+
 /**
  * bpf_dynptr_slice() - Obtain a read-only pointer to the dynptr data.
  * @p: The dynptr whose data slice to retrieve
@@ -2903,6 +2922,7 @@ BTF_ID_FLAGS(func, bpf_task_under_cgroup, KF_RCU)
 BTF_ID_FLAGS(func, bpf_task_get_cgroup1, KF_ACQUIRE | KF_RCU | KF_RET_NULL)
 #endif
 BTF_ID_FLAGS(func, bpf_task_from_pid, KF_ACQUIRE | KF_RET_NULL)
+BTF_ID_FLAGS(func, bpf_task_from_vpid, KF_ACQUIRE | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_throw)
 BTF_KFUNCS_END(generic_btf_ids)
 
-- 
2.39.2


