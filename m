Return-Path: <bpf+bounces-57528-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E636BAAC7DF
	for <lists+bpf@lfdr.de>; Tue,  6 May 2025 16:25:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A938524A2E
	for <lists+bpf@lfdr.de>; Tue,  6 May 2025 14:25:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFF572820C6;
	Tue,  6 May 2025 14:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="r11SRD1Y";
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="VSuCf7OH"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-002c1b01.pphosted.com (mx0b-002c1b01.pphosted.com [148.163.155.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4A5E278E5D;
	Tue,  6 May 2025 14:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.155.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746541534; cv=fail; b=XPZskMUj0/efw4AzF1jV51w8N0Brjir76L1HFbTQ8+jX7AHkINJHOF7D0ARSNjwSfsgXJFIMYhExj+Jt9ERzMMdlqpu/zxCHWu+GrNOiq9dIaemdocGKsBil0LSa20yGlz5Yg6XuPA3dLmn4DGZDph4tU03TwKotsLkaZu26VQ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746541534; c=relaxed/simple;
	bh=O4tWmjCuF+gPLAeljRtul+yvT/yT5JNSVLttBryN4fw=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=EbphHs+JCNdi4I0T4MJkukza4lv39OUNeunSeLCSlRTb9vftYqsnrJf0uvuFDoe8zedAnGMrWFBBnppRVOgl0CMq48URp3/hy5Jedi2KdSogJFKOZCZM7be32zCF4+XyNgwjjWQ2qicuNVtOR/tmPCfjCEyPwEAgTjwICqz0n1Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com; spf=pass smtp.mailfrom=nutanix.com; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=r11SRD1Y; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=VSuCf7OH; arc=fail smtp.client-ip=148.163.155.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nutanix.com
Received: from pps.filterd (m0127843.ppops.net [127.0.0.1])
	by mx0b-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5469cgWM015395;
	Tue, 6 May 2025 07:25:09 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
	content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=proofpoint20171006; bh=AmgPAAMNwBjxe
	65/nCaU/gdaUpgRo83fg1W7BYpKF6w=; b=r11SRD1Y+NZqSuqG0Ut8OpgTvSUIP
	i0A678hx3Ck1y5Y8AT6qWXnxCs3OxnlvXsxdn8S/wBOO4+0zk6icZQzQhJKiLqyu
	ULgPz/CKu9avEwWRUII0QRF7QvjB3UrUWLEvmNWkLTs6NeVST7pRMAHBdlkLjU1V
	ZJoQs0iI4rBgwb7Bsvq9NV6CFN92M+RSJoFsoSLXacNIZDpOUmVm2tBOlw+yE6fK
	t017taiUjg6CifVmIBjJJbydQ47vLWuORZ/gZKCEJZzTn6DVlMymBXCmeVDMy57v
	5/batm/ZDY5LFT7ugiqufOJy3zknW/sGefjNBpOMhrs371t+/Lbm6c8/A==
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2175.outbound.protection.outlook.com [104.47.57.175])
	by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 46dh8hx7fm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 06 May 2025 07:25:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NvSaI3CSQcHDyF6vB8TusXIPGeYlMVPrgSAU0AZdqv2i5Oq/7ETZzt1jPLiQjpz/nuMD2W6eTBsA9dmuf1mQ3DMGHrRLZG8My6q6JjgqOH9YSzj8gn3wWlyrH0Hwi8VpLiL23uqriI64ngO4eO7U/OpV+c8OOv3UYczvVK3Ilty7L/PjelFql8UI6gZa9g5G/8C+xmdOWQNZIhFjgjuS0GiA+7aFyVnHyWwfG4TQUiiKvRefdi8TDtyEHICGlwBZfRH2rb3c/+bnESTJtFof7ey9auz4MCoUyVLLcVVHlKX5Lq0dkHqozIADRnQF0r9zCRAt5dYxi4CbK12tGRJ3bA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AmgPAAMNwBjxe65/nCaU/gdaUpgRo83fg1W7BYpKF6w=;
 b=SLKwKoM4z/VgiCtO1bxgKA+RT8GwrS7xuoXhOe0GvZkSzVFc/R+JmIE/GIdgTJ9d6gdIYcxJmEhtu7C4ll5s5UTMB9MavMhgPXI5a/28i9AVecUHDkodH/cftwgJzkaRE+859X5svnwuFvEND8LoTyxa9iyGsXNQV/zHOlbFIuOIl743oDgHJFkEXhshlwSv8ABaZ/nHngwjrB7JBjbjenq2wQ27Ph/CVMVBFYkUOKg7o0RneWgqW4I4CIYgz288rR3TNf6pkLkr/tE1zOu5LzsbSzr6f2Vz+zT4w0bu+yhPLUv+Mg7hJgWhc8lorU8C6BqEP0j5UyW/xzgjD18s0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AmgPAAMNwBjxe65/nCaU/gdaUpgRo83fg1W7BYpKF6w=;
 b=VSuCf7OH6+EKGLf34kh/GdiiIQCLCDS/SXcLfTKsQzeXy7XnPCjZg7KbRURMJwIB1lIUZvOjmiMdnf2nTWkNo9T1o+rgKZay8nguhp+wxS7ThX6sS9IyDZO3ENTNBf7H+TeyIpuAnNVEOhPJCassCjPCqUJa9HvU+/rk+CEjY/uv9V86lV0mAzAyc6OFUVOQv0tXsO0q+94oJzSeQiEEZEdI/mU0Uc/kSaSbDOBVvqlzBRKIMPRe3qDGQfhwusQpS1XJzuAHiiuqVKG0WTRdSoZJU9GRC+D0Ymh7hee/gYOOPnoX0iQ/LGV9/eYjMYIcFPMpniNDLQPChW7ETNLXXA==
Received: from LV8PR02MB10287.namprd02.prod.outlook.com
 (2603:10b6:408:1fa::10) by IA1PR02MB9181.namprd02.prod.outlook.com
 (2603:10b6:208:42b::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.20; Tue, 6 May
 2025 14:25:03 +0000
Received: from LV8PR02MB10287.namprd02.prod.outlook.com
 ([fe80::b769:6234:fd94:5054]) by LV8PR02MB10287.namprd02.prod.outlook.com
 ([fe80::b769:6234:fd94:5054%4]) with mapi id 15.20.8699.012; Tue, 6 May 2025
 14:25:02 +0000
From: Jon Kohler <jon@nutanix.com>
To: ast@kernel.org, daniel@iogearbox.net, davem@davemloft.net, kuba@kernel.org,
        hawk@kernel.org, john.fastabend@gmail.com, netdev@vger.kernel.org,
        bpf@vger.kernel.org, jon@nutanix.com, aleksander.lobakin@intel.com
Subject: [PATCH net-next 0/4] tun: optimize SKB allocation with NAPI cache
Date: Tue,  6 May 2025 07:55:25 -0700
Message-ID: <20250506145530.2877229-1-jon@nutanix.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR04CA0006.namprd04.prod.outlook.com
 (2603:10b6:a03:40::19) To LV8PR02MB10287.namprd02.prod.outlook.com
 (2603:10b6:408:1fa::10)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR02MB10287:EE_|IA1PR02MB9181:EE_
X-MS-Office365-Filtering-Correlation-Id: e21d66ac-ea07-4bd7-7750-08dd8ca9c9c6
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|376014|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Bxfn1TDArYBNeiqyGP9I3ap8hCa/2Nt3AzHle2dgPwLANbZNY7qkdx4eVKIC?=
 =?us-ascii?Q?Eog4mIZnCN5nP36Qv3GoQzlWjEFq3zYaIkvwjGY4m7U+qtVGxuRpOKtodpVp?=
 =?us-ascii?Q?RdzNZd3parol4sZW8aoC1Gnx3OonEsosaBe7d+CeqeXo8/pnA1PzVxiS7GD7?=
 =?us-ascii?Q?Pcmx4wrHIOZzVCxN8yLXbHAK+LObiCbpEc1H+Qsv//L4HsU5w3p9EYeCljbc?=
 =?us-ascii?Q?7vGHc4vWrhNPjvD/d0gzoT7VRor/CHc5SWHdxGIYjn+MIlPGQM54+3G/GrQo?=
 =?us-ascii?Q?JrUX5GwZX2ACjrHh4QsUlt9ijJBzshKHAaYpmadOiREBCUxc4ePHK1mLCrXs?=
 =?us-ascii?Q?1Zzz7W05K1YP+7zXqjIiN9M+GaOEQ2vN9odsV532jjxyReoi3nvsLAWoqafI?=
 =?us-ascii?Q?ge+vpaCUOXVXokjSC7PWypQP43/0hDc7uZmM3w0yPQsfueDMLOisgXfDbCNO?=
 =?us-ascii?Q?RE054YWKyuX3JmdwuLtBXN/J4d1zopO3J1ZGQLI6UCoo8brsfZ/WS76TKXoX?=
 =?us-ascii?Q?0Gvhrg3Ube/QPO0MgSwXgk0RndIK4Azc371Ug1eVrtXXE8c1xjlTRwhSAeQy?=
 =?us-ascii?Q?I7+5FYt6zLMQUsm1dmNYdbc7DsxaD+dYgFtf6lwMgpBVZhgicBkEfxkJuJUM?=
 =?us-ascii?Q?/FHagc1ytL/I0yuvJ7UTbF7MyadgvfetihZQ/fSORJ/97lq+s9Qxw29187ZA?=
 =?us-ascii?Q?/zjkTgOxR66AOX/HwFFann7m8xR8+ZxDEuiEjd81xefBt0xQ3eoKK9HsewYL?=
 =?us-ascii?Q?irS8HodDIrQPzAGt7CC6canCjS0PlkiDsZkIuk3Yt20GEedsI/omDE06xmGS?=
 =?us-ascii?Q?tG0tulp6eNv1tskmTli/pbPuL2QzPnhUz2mZg/Fv1gFGaEYOZTd4e0m+cHdY?=
 =?us-ascii?Q?uRDZD6phAIDKc8FKTSOeNjG/qKHvYDl6lhe6mxXKNk4ovKuVVjBPCxLF+QgN?=
 =?us-ascii?Q?2Z/tuoN3mX7RTOjt9gWeYJH3R1FZTgWuf76tbE7tyZWsN4mO1+KAeYWgTtMW?=
 =?us-ascii?Q?q7qRD0Q1EgOXeXDYHTHgWV9oUCTWFBF2z3vkdIPtRj32uKDlCLG8cSR5jxSj?=
 =?us-ascii?Q?m/el1H8h01W3Npr9YBonblBkbeH8FE3je11B2GmTAptdn0lG1jRU1A0VjLEt?=
 =?us-ascii?Q?nw7IbDGVx2+dxjzuJm/+c347gr0MIE4uL03x0I/OrmyuKBNwmQNBQgHfsXzx?=
 =?us-ascii?Q?hc3DzkoMaDhDLtkE+O8Rl5ZaOGlTfUoFxskgtKFYL9uCuHNd/9BPvic3ULM7?=
 =?us-ascii?Q?Esh+CGCi4TrxvAM5mxWJwO5YrPEw3JgTmAKOnmrzzuTRxjxQwxDJTImOHJ5z?=
 =?us-ascii?Q?dFHPrcbUUAHVv8XJYyB/oz/3v0k9DPux4X3qitQV1pN2S5xo9tG0Ymydv5KE?=
 =?us-ascii?Q?cHnZ/soDV5yipJbwZtPTa29aHBfuYYZjJZJ6VWL+ojBD8gXMJ+jXZv95sFex?=
 =?us-ascii?Q?kFc3qODsnZGIDo3pOQIJ7lewJmmnQNjlju01UjnHfzayzFLSNShnzZWPFp/4?=
 =?us-ascii?Q?MY6c69oMSqjuwss=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR02MB10287.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(366016)(38350700014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZLb3zJyM6AhrvlqxwQLZSujskheqiliWZV3f/Dg+Bic9atpuXZ4NN5+q2r2y?=
 =?us-ascii?Q?iFzKwi0u9ipJObuYCYRZpgaJPDKZnPg7bJxv3/SppvzTEjkd6Q3Myf3XoBoN?=
 =?us-ascii?Q?K2q3mZJX5qyl4n7SMRJHytxjugjTcxylfk78isiP541zxEC75IaqRz3z/YuU?=
 =?us-ascii?Q?qN70mP6noh1SGHJ6ze0OkcTxEeuOfTq/aaZD2eihTgs+mLa184aA3Eo2f7KW?=
 =?us-ascii?Q?+gfpIHwlOZur29XjS3cllwiS1U040VdwbAMyJhmaui8NhPX2GN+oSbsq+xbR?=
 =?us-ascii?Q?uFx/p/QNnAXrBru9guloht14KWFVdkQmEpFlUr8Ve074Mx98n71ZnlC9wvSY?=
 =?us-ascii?Q?GHYKFCRD1MLeRFZCJjfbJ9rwPRJzj6b43lI8lKkBQx4AHELVyggD+Hkpvet1?=
 =?us-ascii?Q?sdBI6+EKX4zj4xVzN04imJlUAvXQ+cP1VRGkOb5a7gpqV7gtxCbqguxKljKt?=
 =?us-ascii?Q?g7NDjn3wJtZ3La/FEl+Hx2Z3pWyPas7sZOE6YfmJIoFZGWlxvjsdzd9O3FdG?=
 =?us-ascii?Q?Gf9MRWyAEB3hMW4inC94+RsZTkLZu5E934zz7I/XEfYEKjEAg2knNAZ5Sv86?=
 =?us-ascii?Q?qn2nJJ7InVgZkHPWuyA4AvtKTo45RoRO0zwgWjz4/71WaRsq1UgDItPOU0yA?=
 =?us-ascii?Q?q9DI2zHJ+25iqPNIhghI4LSR5PIvO1A6KPcM1xFatDWE1r8LtrIPPAFHxowT?=
 =?us-ascii?Q?oFaOTF1oenKmT/9h/kMzKnBi6OYbNeXOSKxh0zG2YcoBgRJZsau39ty+2ElD?=
 =?us-ascii?Q?bNEfsOl++lnOPD0lKRLNlnsdb8nQUsDQrXqgQdDVuiCqul8eM6yHAfvW5HeZ?=
 =?us-ascii?Q?tY8keaJyBhwq0nwKZiXXkG12dAIE58IZYK93/+rd6Ie6dtXEDxPY9Dt0Aboj?=
 =?us-ascii?Q?hZH9qdtaj8jaKiCQYKLSDVmaCgs5l0a0CKOO9qZ21OgkcxBOp4rqH7KMmfEt?=
 =?us-ascii?Q?ql7FTMzzcOXmIgV9OlNIA6niUY29U9oU6PQRjUGLsYM+4IubWa9REecqlA7V?=
 =?us-ascii?Q?VYx2pj7ILuILDbTJCLB2kLYdxXb1c7sRJmbEvowvQny01iGWSlw33XkL8QSR?=
 =?us-ascii?Q?umad5a4lR/7paU5FzZbuPQkCIahgwyX6pVS0AZwjX4OYgY4O3mDPZr/Fg3X5?=
 =?us-ascii?Q?tG811xfp4y7eoVy0neXKYCPr9UEfnKJzo2yXqu/7vHIgfQqJacHCs12KVIWu?=
 =?us-ascii?Q?KJ+QJYiQX/pK7yi9vDH0qElq4sSeUYEuyXmecL4mWnlzUzx7qfIembSLl2sD?=
 =?us-ascii?Q?FgQpkEpQ9/YkwVqmwQSzymO4eb2lIZyBJn5KIieyf97FdFv3gX/RkkWrsNu3?=
 =?us-ascii?Q?eI8Sp6bpLP6tRljpEFpltPjmkF/qqX/Fsq4lurypgkPz62f7fnHsoxQXXHcZ?=
 =?us-ascii?Q?9pj+wqyehqmyGno7CmCIq0IN8hB5zqTb3acjBAklsNEhgsbRkWoIi8EiKzu2?=
 =?us-ascii?Q?PJvcD9BhgP4+DWmeavADXgixXoXe1udzJ8JU6BNZuOd+EQkc3YJ/nCzb9q/B?=
 =?us-ascii?Q?uu1x2ZdrBU5zUG+JlQr8+AAqEBhM0qsgVwJzC0LBxiobYsAO0fF9lCIqjNLP?=
 =?us-ascii?Q?C41UAQGolCBEVA7+0nbtEX2H83kwB7tTVzWQOye7myRaTbjhd6MpHpucDuwV?=
 =?us-ascii?Q?GQ=3D=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e21d66ac-ea07-4bd7-7750-08dd8ca9c9c6
X-MS-Exchange-CrossTenant-AuthSource: LV8PR02MB10287.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2025 14:25:02.1804
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pNtLZPSAh77v6SJ/ZKo6qxVr0kh60Us9u1JWoXdBUGjHtvQcS6ZqVEhe5bMMBHY6aVJsgdaSRAbfP5K4sozLVLU2TjtszImOUXnVXeMbn/4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR02MB9181
X-Authority-Analysis: v=2.4 cv=B/y50PtM c=1 sm=1 tr=0 ts=681a1bc5 cx=c_pps a=p6j+uggflNHdUAyuNTtjyw==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=dt9VzEwgFbYA:10
 a=0kUYKlekyDsA:10 a=--Kwpk6OmPtTc2wPIbAA:9
X-Proofpoint-ORIG-GUID: jC3Hd0w6bPbyKLa8rcsFI2C_xWqbokED
X-Proofpoint-GUID: jC3Hd0w6bPbyKLa8rcsFI2C_xWqbokED
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA2MDEzOSBTYWx0ZWRfX7NC+OdHbKela 8rQ/BOO2lUTmLICowVdkfxH2vwCsfJ7D3yawmoJ6pQr3fbWyN+TjslHl8EzJbFnDyW81jiTz5ie mBclMU9kZmyf/NbHoaI99opG8oJqVdBmx1p3sIUNxqrGzOJ4iy4dvEdHEeL+5G0fi3LUvH2fyhz
 DKNkP45DYFcJM8eGJr/WXpVljfFfoGG0sBDWXKrRPf4av3Rj99ZmBrVVY3upNBt+jaTJ/PbAqEd dO57+8WyKBhn9vNUkPm9b4ruD9LxXbRqZ3X96dvGQKHufkNKWXWT7BLr/OOkYO7SKAt6sSokD5K /3PW+u7RqD+z9FtLJNoKYDkGR+BVfOCAUzuuWoHdubUa7uG3FCIG2p62XCd5q1PY6GbLs6BuZvQ
 kZpyeBQ5srzJ7ZO5uWaEU5AjKbT0yr9MQbd+P620jw7bUJzDXfCqfYEOKAfnWaeaHChCxavI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-06_06,2025-05-05_01,2025-02-21_01
X-Proofpoint-Spam-Reason: safe

Use the per-CPU NAPI cache for SKB allocation, leveraging bulk
allocation since the batch size is known at submission time. This
improves efficiency by reducing allocation overhead, particularly when
using IFF_NAPI and GRO, which can replenish the cache in a tight loop.

Additionally, utilize napi_build_skb and napi_consume_skb to further
benefit from the NAPI cache.

Note: This series does not address the large payload path in
tun_alloc_skb, which spans sock.c and skbuff.c. A separate series will
handle privatizing the allocation code in tun and integrating the NAPI
cache for that path.

Thanks all,
Jon

Jon Kohler (4):
  tun: rcu_deference xdp_prog only once per batch
  tun: optimize skb allocation in tun_xdp_one
  tun: use napi_build_skb in __tun_build_skb
  tun: use napi_consume_skb in tun_do_read

 drivers/net/tun.c | 60 +++++++++++++++++++++++++++++++++--------------
 1 file changed, 42 insertions(+), 18 deletions(-)

-- 
2.43.0


