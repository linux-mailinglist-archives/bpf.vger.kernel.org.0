Return-Path: <bpf+bounces-47067-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 309659F3C52
	for <lists+bpf@lfdr.de>; Mon, 16 Dec 2024 22:11:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C790318888A4
	for <lists+bpf@lfdr.de>; Mon, 16 Dec 2024 21:08:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BEDB14A619;
	Mon, 16 Dec 2024 21:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="VkfzOnHy"
X-Original-To: bpf@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2054.outbound.protection.outlook.com [40.107.212.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A085A1D0F61;
	Mon, 16 Dec 2024 21:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734382842; cv=fail; b=PDcLNhr5heQf6pIlQ1JQBskqoSeJSeODd35bfXJoMT39G4GOMIsKUD3j/v28mxocPvT85F4dTdIQfO8B0XAGMqbXVwX+pV6+YyG6Nacc8BtRh/u4bYuDkt2ViYLIYO57h3Jc9y8NcEBnEYgn8Ei6k3CCVFqA3QpibMlEAajvTBE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734382842; c=relaxed/simple;
	bh=1R/ih5G/n+9ZegirDfd8LbYp4iJDeiWD6wpsFLII6Mo=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=cGusfR0CQ1RS0k1GL69DmgMaFMLKfiLBbBYsVolB7ffHqmDH5OSaoEoA4shKh4+tTRX8EHaXb34wmkJ+sWsYmxUnNyCIjZ0O6AYWOgvIz3Dk2gwUCTPKyzWtHKrKqkOKvnj3nWQQuwmi0FGyk5tzDVPdO4yY8AV1CtlHhou+nQA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=VkfzOnHy; arc=fail smtp.client-ip=40.107.212.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rvmLbc2QIQeGbnl7EenHTnaaPSO/rALElxPdgi7yTzwyAVJeY1rhWjnpnKz9BBAZ6yDmPxaGR3zu1+0xiaELiyKrOY0zI+8RfqoEN35qpFEXJOyT3/CM6IdFn4SO0F4hMsd/HX9vC79Jyg8ApiGuOiep75o68WiL/8ZBB7YTttlpPrnUlhaAngMW0+YQ5RaDByKU8sEfUqrh9OnuvXP3LnxETzw34t9aTrH2X2fdcHMJSNJQ8q+ecBha8QYfHf+iqVrUtQOvbF/JmHNLFKWgL+yLZExJmnCuVPUhlPJbmuHRBvq4vS8fQQJ3Hc33sqQOKitkZO/pkdZJv6DYoTwS3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zUKEj8YZVQZJOPG1U3viDg/wNI0v0iEmgSL4webC3Cg=;
 b=dc0fBBTmzIM4NsUSU//yrrPV6t32ES6p72VI3omOpzwDMm7U0EBnsjVcMTGRPtVkRT3T1jwzrlRMFtoehIl9AVS1UW2KIZJDR2VEzdI7R9YwVfz61KLYYxH8WfGN16GNo4kLZX3AzpyGxttD4hXe+p41tjlbGlrKSvws7knUgRbDz84aRY3wMGZ9JH7CKVqiCCd0zTCU7AW+i+ETwcf2Do/1tonpq2qvGPDDqvdVOKsFUNGDzz6Kw4CR31ZZc+sX0N/LtyNzUxp1RVah2I+LBW+Q0deME6IBeMBHHMo2lShK0VmyeAC39o/vzPt0zT2Ai7hemkEjgMwNp6nnMsEvZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zUKEj8YZVQZJOPG1U3viDg/wNI0v0iEmgSL4webC3Cg=;
 b=VkfzOnHybv2uqmuimmiHNFVqXOF8FIDgXPhyL9UhYBNZJNko5XXZxJb5ubsp6tgOO70b1LmnbrMuX2e0yDNxIhE/HD4MpIq1WgmngkGUz6C34rE62QAb1tMdF/BS7KowS6prmOz2vh/LKk/Ck/d1N8uqyQjrtA/v0aPj4Whg8asTz6s3lUhxiqSqk+gw7Dak/4FfKiVYKeOsZOb7a0WGdnNq+sCygxBXX7qzar4cH/DueTW6u5Vnttv630yOYKws492CBi3mQGLWO7jJ44iXVe1QqZk21S8KOzenPclLmfOSdZyzpfIewbPwqpSFjZrt1ZsygOyoa4ERGded63Gi6w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6405.namprd12.prod.outlook.com (2603:10b6:930:3e::17)
 by SJ2PR12MB7798.namprd12.prod.outlook.com (2603:10b6:a03:4c0::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.20; Mon, 16 Dec
 2024 21:00:35 +0000
Received: from CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5]) by CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5%3]) with mapi id 15.20.8251.015; Mon, 16 Dec 2024
 21:00:35 +0000
From: Andrea Righi <arighi@nvidia.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>
Cc: John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] bpf: Fix bpf_get_smp_processor_id() on !CONFIG_SMP
Date: Mon, 16 Dec 2024 22:00:31 +0100
Message-ID: <20241216210031.551278-1-arighi@nvidia.com>
X-Mailer: git-send-email 2.47.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MR2P264CA0040.FRAP264.PROD.OUTLOOK.COM (2603:10a6:500::28)
 To CY5PR12MB6405.namprd12.prod.outlook.com (2603:10b6:930:3e::17)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6405:EE_|SJ2PR12MB7798:EE_
X-MS-Office365-Filtering-Correlation-Id: 36a29adb-f3ae-47b7-8967-08dd1e14afcf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ysTDyLLK2nujIby9b1Hk6zalGcRhUIQSMpNjgdZPhlbMOEnv+q7SGJ19rFgH?=
 =?us-ascii?Q?dRqrsQTqaanP34T7XQA2/fOSXtKRioCp08W5zQwqB7bcyMXpe7c8JzO+qSlC?=
 =?us-ascii?Q?2/0g7IzUATurm+3VQOL608qr9o7v5DgQkU3p4ytMvsKRnsv71xYpWkTO0lNN?=
 =?us-ascii?Q?T7PzqfCzczUxci0VzkO8BpbYr7tywSjPt9tbFhqI5yK/eCkMWmPuzMChtRuC?=
 =?us-ascii?Q?DYZAQNxNWjMHUILEHfl7HjfamhPFLSTcRad9CD/3LT8JJLbYxKs+m+NYEOVx?=
 =?us-ascii?Q?BXtjnIcpmNGlgyEHx5tTdWXWN4YuMovj4tOCa9xIT9j9vQ8CchS0x95PMoUy?=
 =?us-ascii?Q?QQCfomAMuthfOi6AvA/JbK8rLjiK0rq7Pw6612pviqXftsz/+hasTD3vc7gF?=
 =?us-ascii?Q?JIX8uHTcdQW357xiTqDShS2b/XvHpKK5xz+30KVqxmr5HM5HQO70lA6xTd40?=
 =?us-ascii?Q?s7euNjfXfuIl4TvLbMrYaausbCjXQrYGFKaN0kFMfW8r7kZi+O8B7FcMiVAZ?=
 =?us-ascii?Q?06ORaTl0Q/A1pCAyinU2sLRIRgxUarf3L6S3j7o0nCnz26Zt0+0Z8NfMZ9L2?=
 =?us-ascii?Q?U9EIDTyl960N61V5/lNMbR8VlXQMTFd+YhNnFI2X7+ENY/TALTnO2bvgn44x?=
 =?us-ascii?Q?mHb11ZMaU5pTSt3PYm7ShOHvHBgmxmexdcSXBiqTyLfkwjJ3W0eB3c00i9r3?=
 =?us-ascii?Q?M1xq5eGUKHClrwyi980F+QGAphtxiM0giZnC3YjmswYFxpzW7yJWhIQRzlHd?=
 =?us-ascii?Q?aoUcpxEtmntOIcBGEgHkYFJ8Zu/d4KOot3GuB5LQBtuuG7ZJc58maHMKl6jN?=
 =?us-ascii?Q?MX1B95Ju92/Eesk7iK/2t7sKGy3yM5P/Jww41JNRPovF73wH05fCt3iEcSAj?=
 =?us-ascii?Q?0C7edVneVJkXsIlM3dHaGa93Ujig3jbWX6PLK5qr94tXv9DbCp64zIym3dVx?=
 =?us-ascii?Q?QA3mBMjfF1syJ/pzjpW3XMIFNJhkoWSwH5kG4fo91Bi2r8QrXdwungA81r8m?=
 =?us-ascii?Q?8oBpUI23/SWv/fxZvfWUHiCNygLBxWvbsCaMd/fRk1KXcRAN7ad3++Ue/3tI?=
 =?us-ascii?Q?sREe7+AyO1m21WAO//NTDTpzYbNYpW5icPl96UaDJbCXjyK/cYeAeCGdDfOg?=
 =?us-ascii?Q?l/OH6qQRDjYJRLMasgFvszkbKP+eVe99nmasDatuMi+yelqnuo9alJyFtVc2?=
 =?us-ascii?Q?+zalgdpe2h9nXVdRws4bPHkpb3smC7sKxdSqASn/rMvLtmML3yk0pXvQu/CZ?=
 =?us-ascii?Q?oy4jbQuF93RKAdoBh2kEtbcBnMIpRxQOIwpZ3gSZ5xNu02jgNBvkhNp5dNtY?=
 =?us-ascii?Q?U+ScMpeRRsOoFbbfnC0mo9SwPoGCpSaqMwRnWubzFvwS2/OJjEMihSdkd0Wj?=
 =?us-ascii?Q?qFze/sjwiw+BKajkHfB7V+tc5aqN?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6405.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rEMJm7QAfkirnnXdYkejO/1sNi5dF2rK/3c6gTcKzuiNcmc8UoJ+I+/gLprE?=
 =?us-ascii?Q?Qj/PcWHW1IdXk+kl6bIXjGi4nbdyfPqwXdCdW07pJa+S0hFN8y3Pm99Jp6ui?=
 =?us-ascii?Q?e8lVKiJjHqQRf0aKpF/y+RIbcwmcDtWDgnsn4IGYOe3y+dvM75eM1bs1g2bb?=
 =?us-ascii?Q?g3mgYfgmFz0z7RwdFWa3fXIIpw8xJbgVfS5McQ8VOkYsKItFRq/UtOE1RLDE?=
 =?us-ascii?Q?DussdEygxqCK2TBy5f5DLZw01y5pofIEwdrLOuE1KPC5yjAHI8y0Vq6uNNY+?=
 =?us-ascii?Q?AKykGP0hL283yOAakskSUd5Ecd+RpzBF9Ik5Zxv1ggn+vUfB7ZFW/Sxjn9FM?=
 =?us-ascii?Q?PCGQaJCyNtChAETmlT14xZIEXLzpDWMLLfNAC9VYGB+bGFv4WbRoWBU7BQ3M?=
 =?us-ascii?Q?DjkGIkHaMX11mG9QnpLjZ4cuqhhM0P1nuk+2GlyuvL9MRelVovXNNRDRURnb?=
 =?us-ascii?Q?O4CC8gBkvL/pbcZ3NaBqvyJI/CeAck5jG5G9jsgfdkNAS2KGluvCKcbxQsyu?=
 =?us-ascii?Q?/VkV5XdfpSJOT8LsxCjvh6Kg3NWcHFTm0hhgi56r/HKG4mp3g7+a2t/zHh5m?=
 =?us-ascii?Q?l3y/MunCcKwPRXKYrW58LznwWd1Ybfn4UUv+WUT9BtaNBPlXbiyKu8bMFixi?=
 =?us-ascii?Q?k8QYAzNxLCdbBWfQS3EL4KiKs4IJH0dDvxAmstx+hujrsquIO7zdb7H7ZilN?=
 =?us-ascii?Q?8qdXtRsfOZtj67fldWtSf0nYTXaMsZ5N0at+5tn6MbttuRhXFLxd6aOUTumw?=
 =?us-ascii?Q?tCvI46rfL6p6EXxJhaMuB+fN0DI7SNfOdp181NV6B8mzdoCfXvQWEDTLt/NN?=
 =?us-ascii?Q?l9syxTnigzJK4IdCelpWSHiOeGLejbwOfDqykOw83yS8IihccgqqU697dYYP?=
 =?us-ascii?Q?xUOaMNvkwSeOT2Fgtch+NpkYcQ43+r9HsabZKHw/KHONObYTGQFFLfLZM1lQ?=
 =?us-ascii?Q?9oUqVVCXM0023Q3rWt4Y981pCt27epyGg5CfiwDUTgBr2AHDagkhJQdr40l2?=
 =?us-ascii?Q?bDbxaP6u/PohOeyTnMmVukUmzr9YMGHh02UQa4G8x1rdK1Mw/gBpZZXSG4bq?=
 =?us-ascii?Q?QsuLuAf+8/pCHrh+hLZpnqbOpV5LkZtZLb7KerEAoUP2YVa/sZdZw1yTo9eK?=
 =?us-ascii?Q?Dc6UqQr5B2w38k0NsBCWFACY0KPddlPpeaYC1V23+X3NtFb6wGu/qu3jpTY1?=
 =?us-ascii?Q?WbFM3yGMvlgQSahe0fAOPuIflaXoFGl4GXvJDO1ezgCLxgRsLwtR6rmcgqNM?=
 =?us-ascii?Q?7J2NCd0+eurBsra7ov2Ovt/UIb+ejrhcKS33xdlXJHjVydKsU8Pa26LWzPgC?=
 =?us-ascii?Q?E0wACRtGkoDHX7y+AhEjgvJ4vgeSCYW3J3ConMMmBLwQ6VoxpDQMfZdLZTs9?=
 =?us-ascii?Q?6eoK8ZTzoCrMR+TmFZ/5ciZx0asB4rrbTaTMHYng5D426Ke/aTnj1IHBsw3N?=
 =?us-ascii?Q?kRQ/KNnrEpQtuwAHJoHnOpdj18rYSJDlZQYNEfj8C6PFe7WUcLuqym6/5PtB?=
 =?us-ascii?Q?ke9qXeiTHglN9Ih0L9CYzWtcFcraFdArhOFVUghLJgYAx+D9bWVu7kdtrJ77?=
 =?us-ascii?Q?KqzJn4T3/tHWvZZHrcIkqhnkDRlZxMLRXJfSLWxO?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36a29adb-f3ae-47b7-8967-08dd1e14afcf
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6405.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2024 21:00:35.5431
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tYpUR/zPFaJ3qMumFWtqA8uVQTp4LWbsbokxT8CQ3e26dPj2cyGG9RBdxyLlpAYzC7FczpS400hf/2rDJrKQog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7798

On x86-64 calling bpf_get_smp_processor_id() in a kernel with CONFIG_SMP
disabled can trigger the following bug, as pcpu_hot is unavailable:

 [    8.471774] BUG: unable to handle page fault for address: 00000000936a290c
 [    8.471849] #PF: supervisor read access in kernel mode
 [    8.471881] #PF: error_code(0x0000) - not-present page

Fix by inlining a return 0 in the !CONFIG_SMP case.

Fixes: 1ae6921009e5 ("bpf: inline bpf_get_smp_processor_id() helper")
Cc: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 kernel/bpf/verifier.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

ChangeLog v1 -> v2:
  - inline a "return 0" instead of not inlining bpf_get_smp_processor_id() at
    all in the !CONFIG_SMP case, as suggested by Daniel

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index f7f892a52a37..761c70899754 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -21281,11 +21281,15 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
 			 * changed in some incompatible and hard to support
 			 * way, it's fine to back out this inlining logic
 			 */
+#ifdef CONFIG_SMP
 			insn_buf[0] = BPF_MOV32_IMM(BPF_REG_0, (u32)(unsigned long)&pcpu_hot.cpu_number);
 			insn_buf[1] = BPF_MOV64_PERCPU_REG(BPF_REG_0, BPF_REG_0);
 			insn_buf[2] = BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_0, 0);
 			cnt = 3;
-
+#else
+			BPF_ALU32_REG(BPF_XOR, BPF_REG_0, BPF_REG_0),
+			cnt = 1;
+#endif
 			new_prog = bpf_patch_insn_data(env, i + delta, insn_buf, cnt);
 			if (!new_prog)
 				return -ENOMEM;
-- 
2.47.1


