Return-Path: <bpf+bounces-34430-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35B4392D87A
	for <lists+bpf@lfdr.de>; Wed, 10 Jul 2024 20:44:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E05C6282B5F
	for <lists+bpf@lfdr.de>; Wed, 10 Jul 2024 18:44:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 683B6198E7E;
	Wed, 10 Jul 2024 18:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="OeQQJZWw"
X-Original-To: bpf@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazolkn19011073.outbound.protection.outlook.com [52.103.32.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B23D195FEC;
	Wed, 10 Jul 2024 18:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.32.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720636957; cv=fail; b=u/uAwu7O+h0qUiXexdzaeOlTgC2u9O11RBohqStfzowf0y6G9IEpMt5l0kPAB1PuKCTdLUCWhoOVflq8vrnIRH4IBt07ZKTxmC6IrsdPK1zrMeuovwiALRzk0ZPyb7z/Lz5Gma/qRVrsWmkG0+Ubxnd+lQXTMpECOQLEoILndYw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720636957; c=relaxed/simple;
	bh=toLCOAeQcWKVCy6tBoaJfr6rl22TOb92yFiiPxWFopU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZOcexvWkntCCeegGMCvDyA7w0aSQAaTWcCUl1msIfbUOC2TWcX7+TSyvSs4KN5tDoxRD3I0AMujB9ukrjrn2HJYMWRse89jWE+Bbqt88xRkQ6muWEdItHwC+K7MowSbkj6itBdvQcObO6xZhKPWK2inpKREI8k1IjHOnJtCUWZY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=OeQQJZWw; arc=fail smtp.client-ip=52.103.32.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U7lAMBcVsZdQf2t1XT/1KYbIYzdSRB9dUTJZ0thSJ4Ofsh4Cm2wkshfSfM5Nc5DT+M5Q5oKFT1XFyuVEQD6cKVIRTG6wR92TJz2g/EOZJCB/eyoaWXtlbDid/o3EsuHpOz/KXavCDkYGpKDc3SBQytCl9UIwj39pjpRscYYQ2GUHqyYkgsBeUQuoqe6GK52EgEp2zTDe7MuVawK+57ncX1fKSVrFZQSj8NUz+Lb0poK4UsglIPxzeeHvBZmLtkllA0hnjmFT+dgitGvkThjvTcFfGqLslw6dauxDjUe40hER9N9lldVY9e/d03qO0RleQBu10UCBWRPAvOyx/Xc8xQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fs0q5gAh9cQAldUvCtX/itxD7miVjLG4u3q1LUKA9nQ=;
 b=GsS5d1NLdytKmYmOHBJkMJZuNan2PItnadA437R/JBWokeloXEye1TkURHxARZR7BZjPZpALVjszVk49x29a+0z+ABViaVF42fCdq69V6P5RHaowzoKJB4HaLMkFjiQq9y8s+e0p1wPllDs7cP58Njr5MoiUSLLL1ezdtE6aZxoWFtdWKqminmvzrWHphk9ULpf+CjHKYYoy1CbRfIgeU32WFMw3LU6mZMTOXrYSvF0uGQ++vllq6ndlW7pardwkKB0qE5KHhW0PXSSjFnqbNIM/OMmIHZXU8Jr5T4itFJmc4N/+1bAbFWBLz3VCHJNV6zIAIfq8u/CeADSEwLLaYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fs0q5gAh9cQAldUvCtX/itxD7miVjLG4u3q1LUKA9nQ=;
 b=OeQQJZWwcyH/tXg6uDuOyFtITN2M0ktqo+U+vGLpFZY+zzw93rkMy2aKqM6/2Uu3h2KIfa1ZDZZvRAmEFud8ndATVwPz7r1udQs/rK2Lyn3dRyMN6BrpHZtzSMl8vPgT0RRXLIQ6iQkiRSTyk4yVuNdW/Y9HhVZtkKKvP9Dup1shj5gaTUprS++/8cHUrIyzkJHsorImyJweUakY+AO+upw8w0UMx29hzRgxtOJH8erMgP2xZliNHOTwNY3qFWHYOzuRz1Ms7jLwJ048ij1tQZM6TBzgmA4To/b+rzkIxbjrJ8HZ4DwM+GnkA+W1OpxajbGrXmPMN2vJh3iV9FxriQ==
Received: from AM6PR03MB5848.eurprd03.prod.outlook.com (2603:10a6:20b:e4::10)
 by AS8PR03MB9935.eurprd03.prod.outlook.com (2603:10a6:20b:628::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Wed, 10 Jul
 2024 18:42:30 +0000
Received: from AM6PR03MB5848.eurprd03.prod.outlook.com
 ([fe80::4b97:bbdb:e0ac:6f7]) by AM6PR03MB5848.eurprd03.prod.outlook.com
 ([fe80::4b97:bbdb:e0ac:6f7%6]) with mapi id 15.20.7741.033; Wed, 10 Jul 2024
 18:42:30 +0000
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
Subject: [RFC PATCH 04/16] bpf: Add bpf_task_from_vpid() kfunc
Date: Wed, 10 Jul 2024 19:40:48 +0100
Message-ID:
 <AM6PR03MB5848CCE1B0608F690A10A70F99A42@AM6PR03MB5848.eurprd03.prod.outlook.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240710184100.297261-1-juntong.deng@outlook.com>
References: <20240710184100.297261-1-juntong.deng@outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [/25l0NBcp70PH7AITPtlDf9bHH56O41R]
X-ClientProxiedBy: SI2PR02CA0027.apcprd02.prod.outlook.com
 (2603:1096:4:195::14) To AM6PR03MB5848.eurprd03.prod.outlook.com
 (2603:10a6:20b:e4::10)
X-Microsoft-Original-Message-ID:
 <20240710184100.297261-5-juntong.deng@outlook.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR03MB5848:EE_|AS8PR03MB9935:EE_
X-MS-Office365-Filtering-Correlation-Id: 83c60e7c-4b35-4faa-5e03-08dca1100d7d
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|8060799006|19110799003|461199028|3412199025|440099028;
X-Microsoft-Antispam-Message-Info:
	xc2dbvyvtEA9kWLwYQG2M7yFp0cu8ZuGo+Ah+XTSHOUNnbA8axJOtN0aw9KcsLVWKWg2nkZkpKkIsSavC1mHJDnmo6O0fPdBVwn46uIIhDu08E5H9v1M4+gQhEAoO5tcOS0QRfQmv5oH4y2hJvkf+vABYLBHEheXAqJkK9E9fVheqTuvyN9gKyEki1oiOpefxJrR7AIqvB8WCTDDjEcJiyQll8td6E1MsWNjvcIEAF2rlmowVa5vBNSOniZ4J/AoCQ+iSvif4TrA96d+A/aoUZyC24vSNuLa8HQk5pDjVU+owEoR4Va0DYoqWPh/njYSul9dwFnP4tAsnGIR7DxMlTdrnBVu10xcpDPjmPEwIdWISV0p/q2gLi1uau/B0N2gx57lIm0CBlm842j/Uc2fdWEUhhKACNSH7PgVrimDvubawdW0XgIsNn+TKoYh86cKvN8efPMJevzCs/1V6TSRf6fOyh2XY49BfE38qmTRXu5U4unLudi+BUnmGojjbTk9kCtBL226x1gywBFltHCPpN249Ao7MiWV56Lil6qlQZXhL3oEG/fgdlXgDx5RLKKAPcpK9Ntg0KOpSWGwcTTZIy9g47yPwTifJApI+6eRSFYMWBxOoMNFoOA5KBOQBhPgeNDBYjHjxVHy/sZaHW5DQg==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?aomytwXsIu8EEGWFuyxOE1Nle/iCsCrwgwxtNL/IWGshFggbufH4rJuXVscW?=
 =?us-ascii?Q?ravZjGoEEofay3vyyf+FTak7X9yMC9MDGbkaaESYIAMy68QkldzFso19iqUB?=
 =?us-ascii?Q?yUY02fXtujsWueHXz3WVF1/B0ksr55XjyX1d8ga3yVxzHmViJsm8z4tIYbTn?=
 =?us-ascii?Q?TJBvh52vCm4XladqHDHos/wq/QVv7L0t550tuFqA/xIkPdLf5g7OBALircq1?=
 =?us-ascii?Q?AKkWPo+o5CEbAtsKkowWBSRtnYgSBCuwlz5aDTSG6rTyuzTGumIczHhxy9ho?=
 =?us-ascii?Q?v4jnYGGuvHv7PjtnvmtvWImnc4HL7NjvSqPeMNfFfKGuVqCMeNfdqgeNo+oW?=
 =?us-ascii?Q?leRpMpgWHEcsCfkYOKkSnbkILsa4FDNAUF6bq9hlfzMslbhTxguvlaPNq1mg?=
 =?us-ascii?Q?lnLBhmi9QCxuAiahPn68kAn9x9VfUONYbw6lcDtqoZ66BzsTWDurX0yqruot?=
 =?us-ascii?Q?cC1j2J+5YjiDKRE+MtbIhNANr9zTtv5lfzzlAKeDRfRN+LJhKrYeM21IhuKT?=
 =?us-ascii?Q?6NljffWnjJrP8if1PZY48Bi7WA2Vtr4qK4+bX612zJwn0jI5SIp5lULhCNRT?=
 =?us-ascii?Q?EWIJU3P0LlP+2KBFyMrqCISFmAY378BnrBTIrlJKlIjm0NZ55qQrryahqWgf?=
 =?us-ascii?Q?bu1MOd6rjG+O91X9bzouag0L/T4zwqLL43aLmJckkTLBENrZUQ5m5z+Z+HKo?=
 =?us-ascii?Q?jgklLBBrZV0BqfhjgqhDdRHoSxod4fze5g6xHBW6Efm1ULw3kGdV59aNSMgL?=
 =?us-ascii?Q?VM1dYZzfWGg5JCAl1/ywWpyGISBEgaI8XJ5sllOOH1F00EyHFmI+7Umv2pBe?=
 =?us-ascii?Q?Q6CvNNgsISdNStO8VYbum//kCx8EuOzpk8s2Z7T7I9p+wvHFK07q9XjivBcW?=
 =?us-ascii?Q?oN4VVzAwQaSZyvFdO0snddO8etfSzr1WKZA1Pmk133p2gHdWaBUeQCOAX0HA?=
 =?us-ascii?Q?FpH1ihBCBjc28tgKvtGr3I2Z3/J/qGEl1AOUEGXu5oQ0nqHcCi12/7Q3KpNo?=
 =?us-ascii?Q?JT44rwepRWYmMJAiHgoqAc/xAlgDy+8KYfcoZa37sABoF9P+4370QdWmYt6J?=
 =?us-ascii?Q?4q+h1gNHZAIhZqslbB19uNbL3GwIGL/5WwD0f925h+4eewlRWWg9VrmBxYZV?=
 =?us-ascii?Q?OZFIx81R4MoN8jIYCUD3F9JX3nqebw5dTnSpZdyeK1kdqm33RbSBPTachOgP?=
 =?us-ascii?Q?j6VGAscjybGJBcsGrvnWro58zRw64zdqV+swOYpu0y69ShI1SKPD+u64+Ko?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83c60e7c-4b35-4faa-5e03-08dca1100d7d
X-MS-Exchange-CrossTenant-AuthSource: AM6PR03MB5848.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2024 18:42:30.0129
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR03MB9935

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


