Return-Path: <bpf+bounces-51425-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 49ACEA348C3
	for <lists+bpf@lfdr.de>; Thu, 13 Feb 2025 17:00:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 67A951888F27
	for <lists+bpf@lfdr.de>; Thu, 13 Feb 2025 16:00:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4EFE1CEEBB;
	Thu, 13 Feb 2025 15:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qTLW8UNl"
X-Original-To: bpf@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2043.outbound.protection.outlook.com [40.107.223.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0CEC1C07C3;
	Thu, 13 Feb 2025 15:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739462396; cv=fail; b=JVpHVD6HoyP6vLPzytQ50K447RSkhWOlGYBD9LfHyXuZpod21qGVrJzzbrRiRxAtl6sDwB9wiNCQ+ZV0u78S59btOjdd7OqbKJG9hrvWt2ENeNJdJb+JaGk+IvD1NO+f4AnvrKe+CYz2nRIdecAl/134feypBpD03wO/rG7SNGk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739462396; c=relaxed/simple;
	bh=oMucj0noMAtcZEIeX7TDH0lMyNl3lserhZRH+4XGNsk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=M/oTeNEGFLnBdw90FDPxXrmSIzqrL+HYuQorlk6wXmgF/56hzOMCn7c+4OO8s3LmevHkKYLiHYQSYDZB4EB2d3dnj82bZ/b/Cy2FlxBFLaP5DMtHHj6qNd3hlq0O5WMJvTOYzut7+IOTv3/egoYmnaIYWmQqJLQgnB8awEQpGOI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qTLW8UNl; arc=fail smtp.client-ip=40.107.223.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XOtq2XcRWAMTO7y6PY4r1XqQ0o20mRql8iLXl+sKc/oCIZLD8+XWf/p0M1atv/7K8d9bOB7FOjzrGEo+tFUDr6Jmd/6bokK6TMg5eL0YvtaKraWn10D0+8awspRoPz/KaZZt75o2igcmNvk/cSU/bxvB5KK7wdGm3jswm2OodFMQTDXmxa9+IK+cEgWymkbuABq+K0ZftnX5XK+Mj/zzFLMAQesnA3YaEQdS63ReVvl8rCb8XNuqDhrLM7LyeVAlS3FacsTRtLJBrapXnGNb+ldvZXWJ6/8TPtc8uF7Cm4GmJU53J5n6zucoL8Qs1SqskPo2KEN6dFy2tPKnX3gDCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aJcTOs2iSPjy8V3QQL8/lipmCKUa/NdOlcy6yRb79n8=;
 b=e7qX5aO1IMvg3hHDvX7ntk7P35qgBZ0YDX94wSgY4F6FZJS4hyhv3LlUYXsyh+WebgMTv05CseP8nz5WJATcn46+P3r9Ms7n7FwtpZbVt2grvsicwwOwWhgfzRV9gslKdhoeN1Y2sJAAVo1856olB1Oz5yWaW2uczsgWw69HPHOp7VLVSnJPCsOevv+CB2W5kSmD5nR+9kzUJdNMLkmVZL/XubpdGEdshgmGa/bWghcRIPEGvuFE6tw28fZvhmngGiSvWAdb1MRiJgy2qR87cKFJRjgnV0hG7ROGKR5TPzEUE7T1VQ4/Is2WzlbxhZGg5rnVytgPE9ZC1whZCn5jUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aJcTOs2iSPjy8V3QQL8/lipmCKUa/NdOlcy6yRb79n8=;
 b=qTLW8UNlS+aprokJdT77ZjSiabT4LVMJn9XQ6WeSu5RDkbWgEC7knftnxCU2kWVCHksggXVgYp+kTyDCpspqK7ZXcJ4CWKY6Cbp0MVhF1Ea9HEhFvrlBa2Fh5OQogMukZsPwuEUyC+xKuQukATAwoWk7FvH/SWcEzSv3xbZy4p3nGO3LOhMw1W0+UBATggRCybutZWxmtOybPDhoXoZnknZWddiwAO7J0vJN03gAU3x5EhqjH0+xIWKyenlPkdTqTLDdcgn25SKETP2BC6TjxGxWKMNhTgjNWVTyFsGeTsnp17ZwUPyr0eOl4AxXFViPzpmB24Oj22U0fAYHVxNyqA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6405.namprd12.prod.outlook.com (2603:10b6:930:3e::17)
 by SJ0PR12MB8091.namprd12.prod.outlook.com (2603:10b6:a03:4d5::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.13; Thu, 13 Feb
 2025 15:59:51 +0000
Received: from CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5]) by CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5%7]) with mapi id 15.20.8445.013; Thu, 13 Feb 2025
 15:59:49 +0000
Date: Thu, 13 Feb 2025 16:59:42 +0100
From: Andrea Righi <arighi@nvidia.com>
To: Yury Norov <yury.norov@gmail.com>
Cc: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Joel Fernandes <joel@joelfernandes.org>, Ian May <ianm@nvidia.com>,
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/7] nodemask: numa: reorganize inclusion path
Message-ID: <Z64W7t5znbuNeR65@gpd3>
References: <20250212165006.490130-1-arighi@nvidia.com>
 <20250212165006.490130-2-arighi@nvidia.com>
 <Z64P7OgJqPsPUMj6@thinkpad>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z64P7OgJqPsPUMj6@thinkpad>
X-ClientProxiedBy: FR4P281CA0081.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cd::14) To CY5PR12MB6405.namprd12.prod.outlook.com
 (2603:10b6:930:3e::17)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6405:EE_|SJ0PR12MB8091:EE_
X-MS-Office365-Filtering-Correlation-Id: 57e368f0-6230-45f1-6cbb-08dd4c477220
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fl73rse2JDARM3c41c/jkn88h1IyMXE+zW/IKZADfDPYlqpQSYFsCXAjvVAX?=
 =?us-ascii?Q?Txw+WNy8F0trhj8yVqu7MOWT4vC4xC9jEi+5P6zvDPHNRHqaG3X6qjUkUw94?=
 =?us-ascii?Q?krgCk1yoxIqhuBBgx63YKZbyJxyuhdT1RUOFkComcNIhd8BQZBtybaD0MQ2e?=
 =?us-ascii?Q?lEJPD6Z5/cEed0OlQAbJxIFsBHHa+u5/KL2TxmcmAjaxsAUy3/N8W/L5SRi8?=
 =?us-ascii?Q?8cjUjOB9it2MZ8GqRE3vE/Wf8FMUxyR2l+Y7h/q6tfHiTZmmApiq5kgmbaeQ?=
 =?us-ascii?Q?XNAKZtWEop+0RXEO+5xMDrkHsorCe0C4YYWYHaI9tXKiTkyY0JW304tbJT9p?=
 =?us-ascii?Q?YX1mPSE8xptObJpEnQh779NXQIf2sjLN7GVaF3J14AvVkI8Ohf6Z4F836yIJ?=
 =?us-ascii?Q?e1TEfRHlGiwoxVhmEhj/YGJ94J6lqCzYXPgQxzjLfuOv3S4ua40t++sLQ/6u?=
 =?us-ascii?Q?Qr3Kpf9ruaGfO90Pg0IBP7CmuchRI9cLqTExzOxZKRm0nqi6v8loVy0NocjL?=
 =?us-ascii?Q?74SVGDCJsTsTxfaCMdw5+dgkGRWSo6vnRBWLqmoioqq104KSdejrx0fmqIlb?=
 =?us-ascii?Q?+x3kChd6bx2Oblw9ky/OkKsvlshb1aAZISjTemWrghE1p1uR61ZncviC8E4e?=
 =?us-ascii?Q?Z9o3OjIGxVBRKNG7m5kDM0/afv7MgZ2Zg1HMdiMkkppY0OJ7b5iNKdNmd83I?=
 =?us-ascii?Q?d6kWWl9ZFpWCDs4AF/F72BylGX/awwy8yfY4iFJ3JRnxXQiADmq4CM2vyQBG?=
 =?us-ascii?Q?u1p1i3rc8qCyAJT2fjH0DhdnB+npmxAugQfTG7p5MGvQ0x11Cy5SiNj3UQHs?=
 =?us-ascii?Q?oLu8wfQkwaez3g9rGj4+p4XUtJGMIfYAoxcmeWDi9NR/P458DgpEhEqNNJqN?=
 =?us-ascii?Q?4ST+PgewWKPnawfyw2YtWvWLIhFTStQDrlKEnS0sItXLegSGcV9hSeA0OE5E?=
 =?us-ascii?Q?x6+kFoABigHfmzbGuN8D9KHa8wFKDUpUoexhRH9vVuyLpH9pueN1P0jj3x1I?=
 =?us-ascii?Q?aMNvCUUp8appKBpwO0gBqHxlJhXtIIWVkBz4G/5Tml84wAeJ/E4iO+J/fism?=
 =?us-ascii?Q?yTKaw1TOiJNJeieQFz2v3jbBcZSVkcPntylQghxkXM4jn5alfpB7OABpmLGf?=
 =?us-ascii?Q?uKAmM8pN0HTBcedzHKtYcKhPIfdzsFD5hX4OSxqKyoyxuXhqS+FSMDMrLza6?=
 =?us-ascii?Q?auCtxgh95iQahELBqsy5aCuJoDjhYJ+miYS45MVXiYDEEbfrN85lRc/wkvPu?=
 =?us-ascii?Q?parqqVReQMtQZd0f0SV0ghwmNuHLtbFzgBESjjqEFyDh6oSRDGWLNmGC2QME?=
 =?us-ascii?Q?b3+uExCcM74qh2ONZg7uT4VLPRC7nyF107aQ0zjUJ7UySC48snGMi1L4QM0O?=
 =?us-ascii?Q?yju8NBdM1zmHT8EWggumsWU4Tgqq?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6405.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7/08Xi3JDzpBMNfj4ivIwnLEBmZ6GmHiRa0DBc8XGZxoloc7XcYuzueeWQsQ?=
 =?us-ascii?Q?Lu4kAGkbCbl4QyBbXGyVWnfX3bPLgj910A+B5Y8twnckXFZFsJ8I1gls/3qd?=
 =?us-ascii?Q?hzp4DEb7eTt8JmufgyjtZ+/Xz2+TNl/BUuf2C4AxTimGmSI6MCSJ0ktCG/b+?=
 =?us-ascii?Q?dIAniv8oc/lxxzeQQuD5QsRb4YGJw8ih75o07JOe6JZukXrISZnp/zEwpv0L?=
 =?us-ascii?Q?SlqAHH4O1ryIFRP5Bh/Sdif7aV775ti7JOWTwsjJzuxQpM/MUUKlcAZrJNNh?=
 =?us-ascii?Q?GIfVKebXjYoz4VEFE7RGZNYOHxQOTWyhj+aoACllVqoPF9LvtWBhCBX4/8ov?=
 =?us-ascii?Q?+NjaYIU/kRxVGvsDI71NpHKDJfVCYZPRuKyw7mQrGJM3vGGXHPtGqJF8oWrQ?=
 =?us-ascii?Q?uY4EMuKqu4L30S19to0UbxJTLQt/ncGgX/pJ2x/i4FbC0FM+ghsCqDHcIa3d?=
 =?us-ascii?Q?LaiWjnbU3TzyOgJV1eCtIUnh8HhPs+tQAOFQnYntPSeSOI7NIQsAMqmnz30K?=
 =?us-ascii?Q?UgAJx//8oV175ObQSuVRwZLVCCLKnaKhYxYjg/XuPvYz1C4PHXREb8gdBPy6?=
 =?us-ascii?Q?2CJtx8WyBT5CgBLxWnahgRbii6+WClZd7sBD/8Q7d8K8oib9B5SxaBXeTjKa?=
 =?us-ascii?Q?0lVDO6/hUvI+jCEvJZrD8FwmIEIahKc1KLY0eQqpKbcBAVcmMoGaQOu9EEIn?=
 =?us-ascii?Q?gs8URXg4dGEG/13I2/H1oP+mYFoF/5EVnM4/N9NEGJJynO1FpVkmd64h4BYh?=
 =?us-ascii?Q?mYJr2i3VafXeMN35pcbqlKcGAgww8pipZ6pmS8/7aqbvbBldWVwssAIDCn31?=
 =?us-ascii?Q?AziWdBgp0L//59uv76CGAc+i1zJ9pThwmwlJBWvVdWy3KuxUXgsgHdNfg4Hy?=
 =?us-ascii?Q?myDvfXo13mREPnXC/JN0YTECQV8pRf8TR2sf9zQGecGYJtMKsRLASXjraQjO?=
 =?us-ascii?Q?bSHUmYFB+kL3mCiaeDKJhOz5iW2+EA1Z4gOb4ICt228jr8QCAtY6cvO2Ry0X?=
 =?us-ascii?Q?Ka0Ih6uZOdW+XfV8AYM3kQtKkyA1cVZWYS9J4pKC6PvSnei58yL32m2Lg1BG?=
 =?us-ascii?Q?kpmYOQ17GJNXEflNl4V75KFaUAP0Ul0T1WcGHt4R3RI1zW/Xp9nUCD85utfX?=
 =?us-ascii?Q?ZAjjmDQdfKv7O2984puL0tPiqh3nyxnMn5vqfKR3Kmu7zGLkMqIcnnberMaV?=
 =?us-ascii?Q?AgaGojYDxpy99dD6D8EkQ6oExYSX4v8j1Hfbw/WooK9FVn1GP7xilhKmjndX?=
 =?us-ascii?Q?W6JSSCN5eoiiXRaAWgqpoQ5dkwh4LYSWz/FPGX7gXRfKUAM0yt+hwk2yvzRc?=
 =?us-ascii?Q?kvOw+f3KbCgGa6ydZopgUoodDztaRpc/wBsPZuHhnWIrasdPY4DKpMF+1dmX?=
 =?us-ascii?Q?ce4LofgTdcDPQh6XnCi0HhvNHoPc1v6BVYWtRdpdv0/WVMWk9s7ycevbTFSn?=
 =?us-ascii?Q?Z3hrOrVPcfiD5M/g1P+Y5vkDVmm8C0hzAEtvxTVaezu/gCauQdiQzb2EuZB9?=
 =?us-ascii?Q?1ag0RKZzKkJXKArFmGcaYue3sVdWLjyR4ADrR0SRA3WFHpURPx81AUAEgfqa?=
 =?us-ascii?Q?0cVcKbHafDsk+I06uoADHuTQNZ3wTP61B/LEELRj?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57e368f0-6230-45f1-6cbb-08dd4c477220
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6405.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2025 15:59:49.8874
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rxJtpJD3BHVs3/6vTpBMzgKy/2jye/ZCox9aEjgDxhvBz8tmh9uYn/z/ZTFGC9Fz/GCoyDehqfUTk5ykurZAJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8091

On Thu, Feb 13, 2025 at 10:29:48AM -0500, Yury Norov wrote:
> On Wed, Feb 12, 2025 at 05:48:08PM +0100, Andrea Righi wrote:
> > From: Yury Norov <yury.norov@gmail.com>
> > 
> > Nodemasks now pull linux/numa.h for MAX_NUMNODES and NUMA_NO_NODE
> > macros. This series makes numa.h depending on nodemasks, so we hit
> > a circular dependency.
> > 
> > Nodemasks library is highly employed by NUMA code, and it would be
> > logical to resolve the circular dependency by making NUMA headers
> > dependent nodemask.h.
> > 
> > Signed-off-by: Yury Norov <yury.norov@gmail.com>
> 
> You must sign-off this patch yourself as well, if you pull it with
> your series.

Ok, will fix it in the next version.

Thanks,
-Andrea

