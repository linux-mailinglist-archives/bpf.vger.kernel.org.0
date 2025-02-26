Return-Path: <bpf+bounces-52690-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A5FFA46B19
	for <lists+bpf@lfdr.de>; Wed, 26 Feb 2025 20:31:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E01A316E9EB
	for <lists+bpf@lfdr.de>; Wed, 26 Feb 2025 19:31:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C624024394B;
	Wed, 26 Feb 2025 19:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="ncB0tepn"
X-Original-To: bpf@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazolkn19013081.outbound.protection.outlook.com [52.103.46.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C81021ABA9;
	Wed, 26 Feb 2025 19:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.46.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740598302; cv=fail; b=Z+334S90cjBFwTnealpg3D9QaTikr7sLWq6aq7sTD77RO3Nb0toONEmrzaBUOQzRTGLtbsCIbpYxkQr+g/6L5kq01N0jyiOR6c1GSpcfJpZKTmSWIIoI1+KPAA9tEKtwBFEcb1K0hYQvbnRgWKleWOwDfcP/h3SDWFRn2bNru7o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740598302; c=relaxed/simple;
	bh=IH3wKq6USU6wPOjQBZgjQWmtNZ/GcrG0I9gnWi2xGq8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nAYHgMmhwpREFmmRdQ5zxCGRQBu990w08Ox+udaz9b5S2CcGUJyFie+7IhetNTjAmPlHCdFLakmFB/D5vJHdcBOdcFED/8QId4w2ofCFcHUcdhA1VoCCxd+DA2Ep+2wlSGxigYyymPsovLbz5UqonpNgaykWCIXs6WJn3M60s4w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=ncB0tepn; arc=fail smtp.client-ip=52.103.46.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dvSVdW6Yidu3Q780Q2Mjuor24aDo+22cSN8Ll2Qw//KdkCkiJZZ2c5jIRmhbHlGgbO7VhGIaw+3/v+1IIVV7pm0CwLOdtfcb9j+lJ9iEPIJQXs6fUBB7U4KWXo4vC7qUOGrJWSiMd9qLkdnC9oa9dRtajWeWxdJR6R6NQEvx0pwWfMP/3gYza6cV+SpYuBINfjSTD5VJbKFQaM+SlFjQa01Wo12R3TTxvYProx6+WWJKQgoCi3Ssrs+XM1phQuqBlbxqp7/ENd74xYrQtWDYcefC2xqzo2JLGkPosPleTLbyElwiPxj9cHF/ZScQ7uV6uVSWw8AAdV70CSCEk1Es8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GJn1KS2QtzN5zmkzWyOj1v4nTuLUZgcItlDeIfoYU/s=;
 b=Eaf3eVPFRIkJZjvEnllJXqT5DntVddBdTg2a6u5/k6JswWI8GkiiXxZTf0/joTh3BLhLw5qMGa8g3JnOtGOcBDtZUcUvx9dOxs5trtw07IePlVNkIKrtXEOd/Rl+iLzW4+8u9fvIJ7QT/Bnl4vWGC8hkx9xxyIhxshsqPsYhxBfuoDoIGoOTZd+ntMLtflsdgz36om2FjttLhHULDQahRnEx3hc+mSy4apGzVAjQN+NgQgOj6rlVNlM4/EQqdcmGI/CqE3I5tdcEoAKU/ldW6/oG65XLuvLQQocxddZKiZcEcD4DzNWAYzHdD9YCznBj8AGOp6cs1GgNjSJoZ4BGhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GJn1KS2QtzN5zmkzWyOj1v4nTuLUZgcItlDeIfoYU/s=;
 b=ncB0tepnhYEUtFzrnZnOyIPqaKkWEyfCrdsWGaTK+So2R+8aUMCXAw5bdTaCWhjNmRyOZSuteu083FsMWW5OAOP8ySg0YLUAZG3CECyCNO79ORxomY2Kp8OkVieE0+EuEtELFEQAouc4ZDk9vx/grwjcZKieWHX1tvLCl1s+VjXMDl6v8q8o6q1vbIaG682s7tHCucMm9OZIQZpUFoAeRtq7I4qi9qLn2Qt66IOOgw+aqD23SRcFziY3vbtj+evpBVJx0wpplfa5iniRHxNTfFZl3hdY3kiga9mBMZzyxAbXP/DQeqvYRzh2NYSIEWExeNcgIAOMdb1BPM6z2hwBTg==
Received: from AM6PR03MB5080.eurprd03.prod.outlook.com (2603:10a6:20b:90::20)
 by DBBPR03MB7451.eurprd03.prod.outlook.com (2603:10a6:10:20e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.19; Wed, 26 Feb
 2025 19:31:37 +0000
Received: from AM6PR03MB5080.eurprd03.prod.outlook.com
 ([fe80::a16:9eb8:6868:f6d8]) by AM6PR03MB5080.eurprd03.prod.outlook.com
 ([fe80::a16:9eb8:6868:f6d8%5]) with mapi id 15.20.8466.016; Wed, 26 Feb 2025
 19:31:37 +0000
From: Juntong Deng <juntong.deng@outlook.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	memxor@gmail.com,
	tj@kernel.org,
	void@manifault.com,
	arighi@nvidia.com,
	changwoo@igalia.com
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH sched_ext/for-6.15 v3 2/5] sched_ext: Declare context-sensitive kfunc groups that can be used by different SCX operations
Date: Wed, 26 Feb 2025 19:28:17 +0000
Message-ID:
 <AM6PR03MB508018ABBD34FBAA089DD9F799C22@AM6PR03MB5080.eurprd03.prod.outlook.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <AM6PR03MB50806070E3D56208DDB8131699C22@AM6PR03MB5080.eurprd03.prod.outlook.com>
References: <AM6PR03MB50806070E3D56208DDB8131699C22@AM6PR03MB5080.eurprd03.prod.outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0349.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18d::12) To AM6PR03MB5080.eurprd03.prod.outlook.com
 (2603:10a6:20b:90::20)
X-Microsoft-Original-Message-ID:
 <20250226192820.156545-2-juntong.deng@outlook.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR03MB5080:EE_|DBBPR03MB7451:EE_
X-MS-Office365-Filtering-Correlation-Id: dc60035a-f980-47fe-0f2e-08dd569c2f7b
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199028|15080799006|19110799003|8060799006|5072599009|13041999003|440099028|3412199025;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pwj1XCMOrLlrtEYdIQUGJgJIU0GHL8ok+K4KN7Ul0jbiCkTx8kszrxxmJNTR?=
 =?us-ascii?Q?KVmKpvKZavCFuoNM77nwbiypGTkeYPoCQHlxbpzY6jdsZ8PVZ8nhDrsfYgt+?=
 =?us-ascii?Q?WcFEAOxDSKA14AMR+KNCBf62Ya7CPu+ssIaU/Qb+Sb0zkQelP09xaLvKdMTi?=
 =?us-ascii?Q?MOQ7tt0WZ0YfrpKMCoYFY77wmIrOXsRu0gDlWbsEPibNNlTSkaq+xBc8Ll7d?=
 =?us-ascii?Q?KAFmbJsEskSMq0GN6nYfhFqCWP5OJv5lGWl2RfnVP/aM0AJvD7WrkTz6YXe0?=
 =?us-ascii?Q?e3cX+LoPrahEwanMLgOdPQX5euVPOi/EcFfzoAaoX6xNNwdbIqbkX21NbM+C?=
 =?us-ascii?Q?23KDhzCmYbadQan/23AF84gW3XBr4+sI836sN0gNqEIHXy/XcAAxD/9m/7Cj?=
 =?us-ascii?Q?ERCrAuje14rlZXa9yW8KAMl2Qwwhr+X+4uj0ri229GpzqE/OGp6MkN8qWWFH?=
 =?us-ascii?Q?ayss5PnloC3dG5y1ZSeOG0blIFOF3pfF/ajYK2oGmqBzgLrQ+FR6JMQX4FFS?=
 =?us-ascii?Q?t4t8lncf3FsaK7eGSo7+IOSxFzdwmzgDve54R0C5VzNsXDy2KAzKz83Xd7ek?=
 =?us-ascii?Q?Il1jvqdlNZikuo353pSgR5pc+vYwUHaTgsgimqMoVbvu5OJ05VpUqeIZKv10?=
 =?us-ascii?Q?yQG0V5jX66f25v84gjPHFvlZ+ZDgwX8HmjHxPNuF1YFWAcnCd4kkFjoYaT8j?=
 =?us-ascii?Q?N4Rp0ulpgo336FyEBINzbH6QEESA30XrYnn7D0khCC2h24grpW4XLal713Cj?=
 =?us-ascii?Q?1vQNcs6DJHA8kabH84TcKM/d1DtVG7RkhEg3r0avztx8VPgUdXIXva3Ipkc0?=
 =?us-ascii?Q?bc7j1UXvYEbaB1+PZsYbJxYbv/zJykVQig1PbaULU9rBM/FV1GpUKeWNsCPO?=
 =?us-ascii?Q?WnRiUJSEnN2L3uU8vP24UpKaDNKh0aXNdRsIu15T1Lf+Tp926AgaSlIha7ni?=
 =?us-ascii?Q?dzEUyUknMS326WKSS5JXwmXhJZ4v77Juh59+/Jj6gbQA9cMwc2DqJa8WIfHQ?=
 =?us-ascii?Q?E7gLcy6sVaAf4rBnTGezN/enkl2SrapXjnNQPpk0yUouD75ze+vPAcXYniv8?=
 =?us-ascii?Q?Q3rZWVxlwNR2b/GxgH89KhqWNGUKYw=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?w1NNkXpG8JCxVGBFSr5XGTYULhdZEmqEfPyjG8osBrfrilltOA3TSYDuMFGl?=
 =?us-ascii?Q?fynCF3RIXZ8CJHtNzLVUavVWrfCfLz6n6gpaJlVN4nnJnFnylI1vj3RfTPQl?=
 =?us-ascii?Q?/S5z/bza4OHklQmFHwd7ZqoXT+0UZlpVOFo/rqSoOyUJIJdAVjS4sROMmM6s?=
 =?us-ascii?Q?nQoZ7bNyXebYXm8T14SyrJqtmBqzVRV5j/4+oOdhf79NhWcZJNzWSb/CK8bf?=
 =?us-ascii?Q?ur9ZgJd0pxq1vGTkzArHhIAeA2H4JvSN+3CeT6CLQdSPWJe7eIihNL2nkWnn?=
 =?us-ascii?Q?IALSCnIp1+hh2xeCrJZc3CpVQPvujJpcUpsNDKjJch4U6ZfqyWP98PUm898d?=
 =?us-ascii?Q?7Rm03POcvz4mG63Z/ogf4Q70N3bOKBGQFH0R9KVS4lE7Jvqxa2Uza1uT/A6V?=
 =?us-ascii?Q?mwkG1Tag74HTajaRwr3UXcEkQ9/UgctYDdrmaNrfzFGn0wsgDKvr1kc4vHt1?=
 =?us-ascii?Q?8jDO9lcgKPbqWfc1pKgW6R+/M84up3gM8LtZwpbcaovRVhAe/Cadyqy3WI+M?=
 =?us-ascii?Q?DXRjYtX8XrbrTm3JVvKBcTFEveo0gyjVyq+ktotqH45s+xf2zn3BYcftddMz?=
 =?us-ascii?Q?M/XqsZaEbabYLfBdVPEfu8zec5+l/lfCg+PhMqj9CkfzSBHnWsqhySeIqFjI?=
 =?us-ascii?Q?IuP6UjxNb/2evlykH84wOxKqKdIot0NiJwzABLXI7ezjTeOsnWCtY6NlYooQ?=
 =?us-ascii?Q?nBomVVj8JN+iIfagOFOPsaEIR4cY/LPjPvXvq4ayp9KfA8DTMnOzx4RdFdwv?=
 =?us-ascii?Q?OmaGr55sZyQ7x9AVOOnPFKTtuHBcTnhVU5Zj9g9aUC6SfXzunuCrGi7cxvfZ?=
 =?us-ascii?Q?4Ss2sUyeAmlwvrq2oz+o20KuOhNAB37dLtdsw6bGOZvWcfnHEgKa5zzemEjY?=
 =?us-ascii?Q?BNKWL49x9Cqo6+HL+MbjKsT/+uXuF6JTA3Mxr9KUCxtH/bub2XmgZ8GaOo27?=
 =?us-ascii?Q?9leWLJ95NBN0dJWaI93rrvCIFuvbS5Jt3N0J5lcCg7sXpFsoVXblO912J6o6?=
 =?us-ascii?Q?H7Jv5oW0H/+Zk3gaw9peetrFlMfDu152fWItyUlFGR1tUCRIWDTpk5aDiju/?=
 =?us-ascii?Q?/KTqgahVoQ+f35weBwVmSY3U+GyvQL/CXA3KWDrEFl3mJJGvouIhFntdxd+/?=
 =?us-ascii?Q?8s47O50DZO4Njov4B/9XcX8eLHAZdIgevOtuTTh0D8HsRbii1nt2DvZIzbja?=
 =?us-ascii?Q?ZoUtvT+zB2Jw1iGOO0UoDXn/Y9DcEMMmzM98/fVb0EoNk/VXkyZDIr+Y1Vrh?=
 =?us-ascii?Q?SSuo2/luSxGOmEq4my/r?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc60035a-f980-47fe-0f2e-08dd569c2f7b
X-MS-Exchange-CrossTenant-AuthSource: AM6PR03MB5080.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2025 19:31:37.0169
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR03MB7451

This patch declare context-sensitive kfunc groups that can be used by
different SCX operations.

In SCX, some kfuncs are context-sensitive and can only be used in
specific SCX operations.

Currently context-sensitive kfuncs can be grouped into UNLOCKED,
CPU_RELEASE, DISPATCH, ENQUEUE, SELECT_CPU.

In this patch enum scx_ops_kf_flags was added to represent these groups,
which is based on scx_kf_mask.

SCX_OPS_KF_ANY is a special value that indicates kfuncs can be used in
any context.

scx_ops_context_flags is used to declare the groups of kfuncs that can
be used by each SCX operation. An SCX operation can use multiple groups
of kfuncs.

Signed-off-by: Juntong Deng <juntong.deng@outlook.com>
---
 kernel/sched/ext.c | 48 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 74b247c36b3d..15fac968629e 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -730,6 +730,54 @@ struct sched_ext_ops {
 	char name[SCX_OPS_NAME_LEN];
 };
 
+/* Each flag corresponds to a btf kfunc id set */
+enum scx_ops_kf_flags {
+	SCX_OPS_KF_ANY			= 0,
+	SCX_OPS_KF_UNLOCKED		= 1 << 1,
+	SCX_OPS_KF_CPU_RELEASE		= 1 << 2,
+	SCX_OPS_KF_DISPATCH		= 1 << 3,
+	SCX_OPS_KF_ENQUEUE		= 1 << 4,
+	SCX_OPS_KF_SELECT_CPU		= 1 << 5,
+};
+
+static const u32 scx_ops_context_flags[] = {
+	[SCX_OP_IDX(select_cpu)]		= SCX_OPS_KF_SELECT_CPU | SCX_OPS_KF_ENQUEUE,
+	[SCX_OP_IDX(enqueue)]			= SCX_OPS_KF_ENQUEUE,
+	[SCX_OP_IDX(dequeue)]			= SCX_OPS_KF_ANY,
+	[SCX_OP_IDX(dispatch)]			= SCX_OPS_KF_DISPATCH | SCX_OPS_KF_ENQUEUE,
+	[SCX_OP_IDX(tick)]			= SCX_OPS_KF_ANY,
+	[SCX_OP_IDX(runnable)]			= SCX_OPS_KF_ANY,
+	[SCX_OP_IDX(running)]			= SCX_OPS_KF_ANY,
+	[SCX_OP_IDX(stopping)]			= SCX_OPS_KF_ANY,
+	[SCX_OP_IDX(quiescent)]			= SCX_OPS_KF_ANY,
+	[SCX_OP_IDX(yield)]			= SCX_OPS_KF_ANY,
+	[SCX_OP_IDX(core_sched_before)]		= SCX_OPS_KF_ANY,
+	[SCX_OP_IDX(set_weight)]		= SCX_OPS_KF_ANY,
+	[SCX_OP_IDX(set_cpumask)]		= SCX_OPS_KF_ANY,
+	[SCX_OP_IDX(update_idle)]		= SCX_OPS_KF_ANY,
+	[SCX_OP_IDX(cpu_acquire)]		= SCX_OPS_KF_ANY,
+	[SCX_OP_IDX(cpu_release)]		= SCX_OPS_KF_CPU_RELEASE,
+	[SCX_OP_IDX(init_task)]			= SCX_OPS_KF_UNLOCKED,
+	[SCX_OP_IDX(exit_task)]			= SCX_OPS_KF_ANY,
+	[SCX_OP_IDX(enable)]			= SCX_OPS_KF_ANY,
+	[SCX_OP_IDX(disable)]			= SCX_OPS_KF_ANY,
+	[SCX_OP_IDX(dump)]			= SCX_OPS_KF_DISPATCH,
+	[SCX_OP_IDX(dump_cpu)]			= SCX_OPS_KF_ANY,
+	[SCX_OP_IDX(dump_task)]			= SCX_OPS_KF_ANY,
+#ifdef CONFIG_EXT_GROUP_SCHED
+	[SCX_OP_IDX(cgroup_init)]		= SCX_OPS_KF_UNLOCKED,
+	[SCX_OP_IDX(cgroup_exit)]		= SCX_OPS_KF_UNLOCKED,
+	[SCX_OP_IDX(cgroup_prep_move)]		= SCX_OPS_KF_UNLOCKED,
+	[SCX_OP_IDX(cgroup_move)]		= SCX_OPS_KF_UNLOCKED,
+	[SCX_OP_IDX(cgroup_cancel_move)]	= SCX_OPS_KF_UNLOCKED,
+	[SCX_OP_IDX(cgroup_set_weight)]		= SCX_OPS_KF_UNLOCKED,
+#endif	/* CONFIG_EXT_GROUP_SCHED */
+	[SCX_OP_IDX(cpu_online)]		= SCX_OPS_KF_UNLOCKED,
+	[SCX_OP_IDX(cpu_offline)]		= SCX_OPS_KF_UNLOCKED,
+	[SCX_OP_IDX(init)]			= SCX_OPS_KF_UNLOCKED,
+	[SCX_OP_IDX(exit)]			= SCX_OPS_KF_UNLOCKED,
+};
+
 enum scx_opi {
 	SCX_OPI_BEGIN			= 0,
 	SCX_OPI_NORMAL_BEGIN		= 0,
-- 
2.39.5


