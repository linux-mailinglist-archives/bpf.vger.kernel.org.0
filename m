Return-Path: <bpf+bounces-51598-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59C78A366B3
	for <lists+bpf@lfdr.de>; Fri, 14 Feb 2025 21:12:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C7003AAAB3
	for <lists+bpf@lfdr.de>; Fri, 14 Feb 2025 20:11:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73E891C84B3;
	Fri, 14 Feb 2025 20:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="j24j73iM"
X-Original-To: bpf@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazolkn19011029.outbound.protection.outlook.com [52.103.33.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33C9B19259E;
	Fri, 14 Feb 2025 20:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.33.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739563920; cv=fail; b=DbxJlsK+35gZIzOrAPeZ8Zr6rAb+1nA3NjNyRtzawaGZqeemhHcte8bgv196Bp6EyBaOrmPyAn7oH67ABqKPochZFm97JaKWeTkm5T/Oqh0yDcbkSNSvn7t542sbr9xL8KwiHfA8yXd39xF+qXXnu5jjw7mvk0vOg/D6gQ6NLB8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739563920; c=relaxed/simple;
	bh=Z1LsCqTZaU1DcBqugsUpvKbcJnWQp5ZI16LeJ3p/r6Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IQTOQNA1qY4WWXyTE/FcQj410SFZE72tSLxse8e+AWMws8q6HwcT1dYvEQTLvC7wR2a772v1Yqsp0OjeEDg4IBFLgU47MYObkL7Logw0Io5+e3YnOjt8Zq3YOtLpR5E/pokfUzxa6R4PvD344gN7yIZHvUzRBkmXPZVKQTm1EnA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=j24j73iM; arc=fail smtp.client-ip=52.103.33.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cNmgzCXHlRwkEg2eqcdvYM3aJv1ZXjrUM91kToxZhSaI2Qo34QFc6tMwaScjb4wsqVBI9rTcskC3l4ilLA3Wo8jYJ0vmAVOVzYRaSDCJ8Y8ETe+IluRG7n/TwfbrPryzzN1mcuUPSK4RkSvAbjCTxQdv48z2sHfkuKLxpPRFYBndikzK9sBRskACMQK1OuIior/t7rAdEPOuAOfJc779al6GiCTx4cbYthdPD5ALVTqSynFu371ad+Bp+2gPTuqkrY5uiunFdhDKalEUZQ9+0RNljjmUWiLhOEclcD0VE+yzD+eL3wEWjcUmh9wjk5XikytOTwtGLiaps1Znw1GxZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OgVgrpxT8wpzN7jUhAp4RbhCDAbVsuOjanWmXLLoCKM=;
 b=futwx/gYXZ4BfG9VVzEVKsvkZFFtU4SsxH1xOj4hrceA9Q3+uowG4SYu1YLrd1kWBJUetF1q065rfaRT7p8hTw29JbBPOt7k5bA7/8QBP2CBpzRPzczCTwDshMliMGCDRf9H09MOt0Z1Cm8ayMexQUhDFD/o9uO3oDi7uiDudJSpsJ0rFP9J7Ammr7FXhHS3Y8pp2qOzeqqrcbsQDLXPGzW5YMLMHUYzXkbIAPxMI6iyfT94l15pUDfWUg8xd8MFz2AqzT2mlFQKPci2T39gjp7WpM9E6thufe1YCxNqAD4tavgBRZlU4bkz0k1L4m1IjdA230DWDe4d5BjOMIoC3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OgVgrpxT8wpzN7jUhAp4RbhCDAbVsuOjanWmXLLoCKM=;
 b=j24j73iM8meCjETL8ZPRZMTR2PGfpWZnrhOF4d92YROFctg3NakJsbKs4n2FazjvjdMKivmHVNNQAH7gCOqKftzWPXs7krcIpvk83iXR8mvaklg2qAcievGYlhuS+1FQK5TtYDK+f6sgR+4wZFLTIbq1xiTF1E8ZlxkSU9wnktW9Du38JyM/03hyeB97rwikxoGz7OoKYlzSbxFuz6de4fJzMt5ZoKO35CF0YqkkWJuwwomy5AYWrICf8EPv2d/uDmhi76gf7yzF8oh2pQ2e/V5P3MaiS/7z5ENi9wVksWUEQFVSDWZzo1vTq84Ie+QwyHZf5bPYLAcOT/BVs89uHg==
Received: from AM6PR03MB5080.eurprd03.prod.outlook.com (2603:10a6:20b:90::20)
 by AS2PR03MB9931.eurprd03.prod.outlook.com (2603:10a6:20b:643::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.13; Fri, 14 Feb
 2025 20:11:56 +0000
Received: from AM6PR03MB5080.eurprd03.prod.outlook.com
 ([fe80::a16:9eb8:6868:f6d8]) by AM6PR03MB5080.eurprd03.prod.outlook.com
 ([fe80::a16:9eb8:6868:f6d8%4]) with mapi id 15.20.8445.016; Fri, 14 Feb 2025
 20:11:55 +0000
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
Subject: [RFC PATCH bpf-next v2 2/5] sched_ext: Declare context-sensitive kfunc groups that can be used by different SCX operations
Date: Fri, 14 Feb 2025 20:09:26 +0000
Message-ID:
 <AM6PR03MB50806C2E3C50BA1CF2A3257099FE2@AM6PR03MB5080.eurprd03.prod.outlook.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <AM6PR03MB5080855B90C3FE9B6C4243B099FE2@AM6PR03MB5080.eurprd03.prod.outlook.com>
References: <AM6PR03MB5080855B90C3FE9B6C4243B099FE2@AM6PR03MB5080.eurprd03.prod.outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0277.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:195::12) To AM6PR03MB5080.eurprd03.prod.outlook.com
 (2603:10a6:20b:90::20)
X-Microsoft-Original-Message-ID:
 <20250214200929.190827-2-juntong.deng@outlook.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR03MB5080:EE_|AS2PR03MB9931:EE_
X-MS-Office365-Filtering-Correlation-Id: 031fd8ff-a139-4156-5cdb-08dd4d33d44b
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|5072599009|19110799003|461199028|15080799006|8060799006|3412199025|13041999003|440099028;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BTBGdMseaopMrUlp4murC3+z65A8IVOdZTCH5xY3yzUHni3j/IdWLQMlh5cC?=
 =?us-ascii?Q?nUEvztfXN398fCp6mocQYrHLbjSS6BiPYNJzuW7/rYrAmLTcbNddcYdfbi4C?=
 =?us-ascii?Q?ZXcM58TGNi9Q8A+p08xZ37e8tJZIByBY+7vItChu3MOp+cB88tS0w7hKFHA0?=
 =?us-ascii?Q?Zinin0QX9MGT8Fq0xF/Tk93kWgJuZlEgfPkRkdqZWze3U5LlwnCc/TAN0X+t?=
 =?us-ascii?Q?BbPtHaNyeqcVpJZhSaEjRDq/sghif9vgJSB6akpkax884EZX2XC8VWdXWEHS?=
 =?us-ascii?Q?6mUeAZgGE5OPc34r4zHrd8LtNe7rCWTgsezCPcKDYzb9sF/Ufe/p0ukKuGtb?=
 =?us-ascii?Q?jmmbJmOheK0D9+tGfc8fr/xO9vnFbYfdqslJm7zb94EMO0BZ5jDUz1UPIgsJ?=
 =?us-ascii?Q?ZMbCkPDi+TRQdgugx4izOfvMY7ikLgFQEXoSaUlWf86cFKprMA6vgx/wPEoD?=
 =?us-ascii?Q?wWd7VGi2NRduYIBSFOASAJilQCD3UkH/Hyj4XgrtACIDJGiqNlpNFXYlPL1f?=
 =?us-ascii?Q?dKnaxL/7Ufjdrj4t+Kglj8U4a6fjsVhFuC5hZYnQ92bP56OmW3Gg5GORd96q?=
 =?us-ascii?Q?4PQ4pUfYBQf5z8fhYbn8VgZeAy7aO9WgUciW5dwo5pWR6knTXXtUqO7xktOe?=
 =?us-ascii?Q?l7vMru/kgawF4ZoIZCexmkw0n4jzG66FegPTbYMF8K1tgWPnbRkZKhhFLIrB?=
 =?us-ascii?Q?dziqWwudv4RA1D+/JrKkUr3sBRa1H76KHOlviJUszkjDYW+y/wkcl1k4i5EP?=
 =?us-ascii?Q?KSmPqelFWo6TDLjG1UqNxabAeJIkn6PkPtW+mArE2Y0AmNs+pjcyyY7HXKfO?=
 =?us-ascii?Q?Qo6jCYqV3uiy12a6++FeUdyR2vPSAoxbtIHCrGj9tAkzZacuIMDAIK8C0jNn?=
 =?us-ascii?Q?haP4Bk+GiXE8I5M4X9ZLrVFujRLt7heaRhlqwR3C7f7TUS2NvaiEB8iipJqp?=
 =?us-ascii?Q?4vxiBItiMBbFGXiaoom5zjtmv2LrCzCPrjOvNMWE7WqDD27cOvgqIdYGjjMK?=
 =?us-ascii?Q?CbTdqOyo+zlU2GnJXD5YRun4yZPLFVxKpAU00J3wMQe+UCLGXr8p3lprfB2G?=
 =?us-ascii?Q?N8j0yXg2ieD3Zst4x2KbMxTL3YFtcg=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VYpcfGAhyxhk+Yy5/tpmFVe0Q0/V/7kuc103kB0EqrtSleTLSS9pLHjVLcih?=
 =?us-ascii?Q?DHLBXQYvkPvre1eaZ2oqvgV+m4klsv09KgcUmqwikB9B7IdGrnufX+29GMn5?=
 =?us-ascii?Q?WDYxJjTGop9m4DB2UCFSXv3L3NoJk4TCslP/BkoaiLd5C91qTq9vp3ItLGqF?=
 =?us-ascii?Q?qlf7oV9oFPM4Z0C/d7VtJR/4yQeBqfrPOM+KI7qYPDy6M5vckgiSkBJ/jpIR?=
 =?us-ascii?Q?/WOYDn+KEVmm6eBlC6KNgS67wx23seAA3S7Cs3l+aVix+iNDxLWjtwJE1bZz?=
 =?us-ascii?Q?Nj9sL5VMe1uDWlxO3KG0yQa/mCDAEh9zYM4Ug2ZyhNoeNSnM/YFyH8vWpocF?=
 =?us-ascii?Q?RHxoZTLVj+wh8eHAGX6SnehBXCCXnS4z01jhgiGN13Mv9AAENDs8WYznFJ3h?=
 =?us-ascii?Q?tZTodbGNg6K3c5XZjV0z37hCYcdjpGfEWTketbE5hRlyxgNOcLISgvEnVxSo?=
 =?us-ascii?Q?Q8/pm2uS9KZdu6P8k97dJSWjGmEms1nlwM4t6JhqSQa5HMPW0aLsLoxssJ+w?=
 =?us-ascii?Q?N+qml6YUNdqhYgyP8nvQseXk36cimGBirRshd6YIOZzWbkUl/e4nLPkLadw4?=
 =?us-ascii?Q?QASa/lo5HHqu4UFmmcULPU8OQV9txFHtGloQmGCKUwWWxIJjGODa7pza7Mg9?=
 =?us-ascii?Q?Q+7Abjj1fpfpdGgVGXzO0hFt5gVFioaQq1eGYFrt3fwp+uSB4Ei6eo+naQ/K?=
 =?us-ascii?Q?Np//2ZDsmUarANc7vCXA0/mjDL0DEQ8gbVDMtxfp2VZb3PRZrP1ki28ilOo6?=
 =?us-ascii?Q?v6fu+Jh2EuS4rdiIx3vYstX2SiR89X7/aM3NIv/NZXZtcJKfguWo9/UhlnhI?=
 =?us-ascii?Q?e17RDilCU66oSJbzjQDBKPI0H+NY9lknEqR7jw1OTcBtkejnqtb7g7DnY7Jt?=
 =?us-ascii?Q?n1pzQ6vW1KXfhQX7dJdVYjU98NkhkNMvrhUgBhSeoYOYw1Wa4XZx8srRiPB9?=
 =?us-ascii?Q?ypCEmgMygtJlmq09JobTpiZwhZ+cIqoZqa5rNooHE7N8NWNvEsP5qIWw2q/G?=
 =?us-ascii?Q?aSNJgj5SbTjbsR0VRmBzcUPqt/Yt9AWbdYvJUmhnbZRIjBQ1yrVfszCbQ7Tk?=
 =?us-ascii?Q?3FPzbEyHG6TCGBrcXX+Z12ZpM0+UiMF4+0LzeYzcD9QLx3BXrB0pqTRsMfF3?=
 =?us-ascii?Q?hU23BCm3LSczPMIlp7j8rLhUM8EFbfXDxCp4DGMyU+Xlszo/uZbrckE7ZT0F?=
 =?us-ascii?Q?Q0DL5nUykjtWifj0K05TANYrN52vm5y2xI1yKML4HnKAZFJwdgdk3MtjHhSn?=
 =?us-ascii?Q?ZNLLudHIxOwF+ZG/qDnM?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 031fd8ff-a139-4156-5cdb-08dd4d33d44b
X-MS-Exchange-CrossTenant-AuthSource: AM6PR03MB5080.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2025 20:11:55.9115
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR03MB9931

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
index 8857c0709bdd..957a125b129f 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -689,6 +689,54 @@ struct sched_ext_ops {
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


