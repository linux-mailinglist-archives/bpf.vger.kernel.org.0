Return-Path: <bpf+bounces-71397-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 995F7BF1A3F
	for <lists+bpf@lfdr.de>; Mon, 20 Oct 2025 15:52:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B9F461881D3B
	for <lists+bpf@lfdr.de>; Mon, 20 Oct 2025 13:51:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BABFD31B810;
	Mon, 20 Oct 2025 13:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="hPhuEEQ8"
X-Original-To: bpf@vger.kernel.org
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011046.outbound.protection.outlook.com [52.101.57.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C97E221FD0;
	Mon, 20 Oct 2025 13:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760968279; cv=fail; b=f93VpeJJhmNPNk/CXIdD79ZBqXvLGcMTicAFR1vOMYATjgf+v8Yl2eTwDDOHD7Bj3F1CTtCd7T0nm23invTOjMCfsikz5CA5CTMiqHNQpPMIaMwwKT6jElSzzIjrnvil9cjjyawp5IqrbDvlNqetpXJZ/MpLrhQgjjVQTdcFFB8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760968279; c=relaxed/simple;
	bh=Hp1JzN1T3elYwpVbevImfVjQmZ6Gz6wJuc6BwPAtYys=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=LEdTlB1E4RsJ06pi1WS5v8fDHwYNxH1Avn2IaGjBXBNjP6iXDQmk7Y9yh5krb9fcj1oULC8BZjQ/PhKeMwJVopqIKeSwH7fc+vhdXadU7DnL3FkddcRi9SSnPUt1+so/E62eTpVZds0ppbVm7wBj8E3SHAhqqGJPqdhMOohqJC4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=hPhuEEQ8; arc=fail smtp.client-ip=52.101.57.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N6CLU+rsrjdGbih7EPyZUvd7ssxOv3SJs8kCBZARZESfsAKH/63Y8fQwwKRwxJcN/dZtd96B2cuDJ93BJYFZrNZrqoHX0U9YYekoV9vaq0JDgEuqsBE90qDmlWUIbAwUYB4LVeqE5ITJNfjDN4LrlUEVlaAslsozWuMlDCJsBWalnOPqDcgi6eEj4fI9yA7xc+fLjBJmEZ0gfb+IUcTEBvj2iOSleKYjhOO7STFA4YZHnsBcKGQ1JcDTpR3dzeci7tgq8QZCxPLnEMUQN7biReNEeX06hBkARQGiskh9D2grlj6NV2/uP0DNl+Uw4x6nL8wV/phlWr+1pRo/An/wCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P0faKgUt1J0zQk0reutBB2CRGdht91tGBUejcA0aqko=;
 b=LP2ctBgYHLjxlBaKdA8wHelaHJ6g6VZ5aeUuq0ef3MH9DqAqxXyk3XpGKozOGQKDOxT0u2QwM0CW2fPG/9b1jGTyjuDOw7V/xgri0K+/XpGtlqP1UZ762S4/QnzK1K9H2OQyAK2NH5BgaAIwFJrPqCj3zkS3R4p9RI+QP7PnFVfy3ccpqdVpaThCbpgEzVI7VHQcDtDLXvN2xug9vVoo3D1vNdf9W/SKq42rIcvXuVpc9PEyZqSfZ3iuC0B/6+XIyUFG0RX9/dL7BxWxkwvjY3U7+/Z6mh3F1vp846QCPytkwISUy6aeczAa9AOm9VLzev9l7ieLuhe5antghTOGjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P0faKgUt1J0zQk0reutBB2CRGdht91tGBUejcA0aqko=;
 b=hPhuEEQ8DrfNLXgZJQnsi1l1H6OwpYXILEPtavHIZvJuQOn/DmzPSgZzmylj03i+IDzw0c5Dkrs5JOdAtXeWEgJMYtnzRIzGo0Ixy2uKvNLApwaQXPb7sHa/kSMF4kc1zaIio2iGHLor16pqMrLd7bWJO08Aiew1ZkEDv/cs0F7gyagDUEoLAnmaFGp33kNIfPUaUaL9K9irMpbvT10TGFXx4RS+iJutXaneiGP6sa3pS/l96onu2AbjcHxbptFeLYnbM57CZ9W3g+6U+xGsVRZJMc2th7LfJjlRux8Wq5w2Dn6mdx461ALu5i/yAeAumfCqFrzPcjayZktTKToOoQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by DS7PR12MB5840.namprd12.prod.outlook.com (2603:10b6:8:7b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.16; Mon, 20 Oct
 2025 13:51:12 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%3]) with mapi id 15.20.9228.015; Mon, 20 Oct 2025
 13:51:12 +0000
Date: Mon, 20 Oct 2025 15:50:56 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Juri Lelli <juri.lelli@redhat.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Joel Fernandes <joelagnelf@nvidia.com>, Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>, Shuah Khan <shuah@kernel.org>,
	sched-ext@lists.linux.dev, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Luigi De Matteis <ldematteis123@gmail.com>
Subject: Re: [PATCH 06/14] sched_ext: Add a DL server for sched_ext tasks
Message-ID: <aPY-QOXV5USEHVIq@gpd4>
References: <20251017093214.70029-1-arighi@nvidia.com>
 <20251017093214.70029-7-arighi@nvidia.com>
 <aPYj-iOdvgUYQFpn@jlelli-thinkpadt14gen4.remote.csb>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aPYj-iOdvgUYQFpn@jlelli-thinkpadt14gen4.remote.csb>
X-ClientProxiedBy: ZR0P278CA0031.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:1c::18) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|DS7PR12MB5840:EE_
X-MS-Office365-Filtering-Correlation-Id: f0b5a873-717c-45a1-2b8d-08de0fdfbb25
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WC9srpTXTyyncuip8+ezFkVz248JYRvmKdU7Cz5lGRB9PNEQBv548dSpqCS4?=
 =?us-ascii?Q?VnVCye3+JRnNEk7cQRKHy9AXYAX5U5cGjFYrdmCEt5AagaGJjlYJPtga+Kdp?=
 =?us-ascii?Q?wyfNuh5SkU6d1HbNyRrE8Potm9Hhjsxp0Yl1lEzkkIcxM9oylSpCcTBFF2K+?=
 =?us-ascii?Q?IOFhmoFUAkhg58qIi5geIlYqXDNPW/Ax8BdR9b6wJpE4wqgU45/NsEZMQQh8?=
 =?us-ascii?Q?NGmAyNr8fJDpNbhy3YNOqWDc0rfuVSiEWsIP8KgNDd0mR5w5YmJVmqfrlaJo?=
 =?us-ascii?Q?zrjCNFi3OVFivL8QAai2uXHWYFc9nYzK4lGqxUVAXwJ8hUertX0vxXeho6i0?=
 =?us-ascii?Q?qFHBNhaB7o6J27f9j4XwJApcYOIxoe/dpeLzgoVm/FteseyrHCTtdzyDnMS3?=
 =?us-ascii?Q?noJfKsK+cisjEYiwZEGlY8LgqS6F0+jDz2zKTQdN+Fo5gfcxLMCxkWf9AdOd?=
 =?us-ascii?Q?K+x2Sp3MWb7OqQqhRs5iQ2T/z78jQe1F6weFWe8l1PY8WCWrucYzMAmnB+qm?=
 =?us-ascii?Q?Klzd36lkdMMpzY22HEsj8kciiTJ/3GqlWaE6uWkgLEweawqE6M65nlyBYJhk?=
 =?us-ascii?Q?YYy7dNcWY+fJKt5porHieN/H/ypmNyhe6ZPWONDDLn+dKcjxVOn3cst8bt9J?=
 =?us-ascii?Q?XnDywkn5okrP688MliEZaEB9qdDifxyjbboqkUSLAm8ERnAZFw1DS/o+R6fJ?=
 =?us-ascii?Q?b8rPdqHo1xzOYSG+1fFA2iHgfxei5tvvDT5E8yo/GKEccGFinlL3BbqlRGC+?=
 =?us-ascii?Q?Ekf4DvOif5eZGgN0jel54E2gPDnSjkgojIZ4GXLRcG7R3co/rDhUK4GbT9fm?=
 =?us-ascii?Q?R/CMQDBJCYHpWyRJPa5cGgEtWYhSUUxbpPbKbSxJEUUcOBHg1L3S/2Dj18hw?=
 =?us-ascii?Q?m1XR8RNEB0BcpH4Sb+ClcjNIy9mLKlBhnd/HolPiVFrlvSNR5phTScwG7mcX?=
 =?us-ascii?Q?+cEWPJD+M/oqV3w5L2NindLGeGUuVXMPU+nFMQReaNIhyZxfP5RlQkKAomVA?=
 =?us-ascii?Q?AiRMkG3uJg3jMW8iETvyfpjfRz0ytti2AZ+CJZjOszuFyaiOeJJd22k4hGZT?=
 =?us-ascii?Q?KWNEG+Gdr5Jj91xKREhA6z0eHNNbbFOerFr21P0b5Bau7HXgSPMiFTRkYxpg?=
 =?us-ascii?Q?Voiue5cGgOC+L5NwyKafIkn9QLInacaf3/jo9qbN4LW1yuydQX323Eq3/bmj?=
 =?us-ascii?Q?7ezm522zScTNV78MgN+rHJ7UPd5ZEFXbhjWouTgdKx/kdJ9fUEQeZwsbXOeH?=
 =?us-ascii?Q?KO16HkBOIXZiwZIT7il61/Ra8DrMeDMaZGkiSpqq+XZ/j+EkcmCwO9ZBXmc3?=
 =?us-ascii?Q?9mABSafdhJ6hY2Cx2gP7WhetJWiuBq7jNYyQxOLtPUfnZdKeR7xKqnwPXwxE?=
 =?us-ascii?Q?XdvA3BWVwE/FP72vUx1ZkMVbFZaHpEmtVnj3EubWfjzSS9Fj8RDNTV19mK80?=
 =?us-ascii?Q?I2lQRA508pQWcRu4LZIDPHIjV+bPNK4+?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5YmPemrlvuSvqgm6XlCt/UUVhZNqAaUU+opxhm83LukZeWocgKAHh5QOCBIz?=
 =?us-ascii?Q?xiZ4GlYnsrORkNAbzgMlaL188dee1okA0hv9h0LGImLEo5S9pAl20KwGI07Z?=
 =?us-ascii?Q?mhyo19XB/qXyIZgjP2WoQ4lbRum7JAvrSbWBQwX4ghmMGr9WyNn4GcwsxVa5?=
 =?us-ascii?Q?E8MdmHyuKJouQgaiPnMI45idZxvS0pcXCxbn/hzfPGBuMiR4j9OZQ8JgKJH/?=
 =?us-ascii?Q?GKl1UiavYS1MZUd/kwKCZrFpeVtd8FfCVbWO6gwzQGlRRsLkj1zEUYankN7K?=
 =?us-ascii?Q?OtFY1kJRQbLKKpf7vf907ajuYfDcHcQFPQSoRuyXevI1R5p7ps2JcV9JFGuu?=
 =?us-ascii?Q?q9kA17NHljFc71b9S20310tL1uHlKqvwf9o6cYl1ZuWEn/BQAncHfMOtYaXY?=
 =?us-ascii?Q?1aBIUQGj0cRrqVXbf1QWzVBGG70rhRmBZCJavw9aoVR0x5U5tdRSRiDyqnY1?=
 =?us-ascii?Q?FVGcxjVEkhnJrefWHC7E46gv7Rz76zeMXK4TfsOCyaksfNVLdSDBiR+NQkuL?=
 =?us-ascii?Q?pD6k3y7vj0ukQs54iCz+AR3dZmueufX1VbDzUIP0nUVKfeoM9u/TH8P4RKJk?=
 =?us-ascii?Q?AYfp1nkaoNNWZbRWhe9UUZPIN7Na5BSmCWae61J5cgM5F0xMYdwhVUs6YFKV?=
 =?us-ascii?Q?I7X1H1HQ+6sSjs4Wm3T0q5U9jxvsJuCnSOs2RBaZ34WAE/deyNujKYyAZrB0?=
 =?us-ascii?Q?+u4xixC8T8zGY3pSOCffmCw1kgptZ/PjL1DQCb0XGUt8mcJQClA7J6S6t+bQ?=
 =?us-ascii?Q?RBRLkZ4Yul5ikt33v74pNTfQ8jSSB1yTKlFTBsbmCt0ZCc3WjtFh8XGHFuPN?=
 =?us-ascii?Q?8fc1cx1xULf/1AT0DQjkbvcbWcLS+9wVU9mAwB75aPEYym5w9NYDNCXyf0i/?=
 =?us-ascii?Q?/Bm+Sg7jh/X6TrNEp8zw+4b+NFSXfU4lpi+o/Hq8ycf6/MYCZ0d5ZfaGCJYv?=
 =?us-ascii?Q?zwFbYNIfOmBBknWwBcDwDdSMz4IiuN749RiYtqUsmUEw+9iiRnuGBVKQGt/+?=
 =?us-ascii?Q?fXKsDJo4Du6gPtd3B9pxiSea72GSgYM5jDmUsiWGeULorHhOQl6Nw/qee6aK?=
 =?us-ascii?Q?hD3OKL9m0+VM5RBRhpV/1ETgaHbMxz5VgX1Welkbs+KraXdr1AGCGUJvOK+u?=
 =?us-ascii?Q?aoiBUKlnNq/X9D0rdkKJq+2AFh8wZrYBDoKTJWgkcgDKb86OJG4px4fDyzLQ?=
 =?us-ascii?Q?BlpLlHv9MLtFTYWTmadwNzYv7ks+Tc5F5DJ2dspA6g1Sxao26D4N5aeeK6C7?=
 =?us-ascii?Q?hvXshcu0Z4dyBW6eZ9BS4PaDn0n6zArqh6mYOXiZwCaBxC9KKaSYOCene0sC?=
 =?us-ascii?Q?oT4DRdfYNRnPivnv1wVgeLySZrENqJCUmLOkEva+KqZtUpIW+Mc6efsI9C3g?=
 =?us-ascii?Q?Qog3v/T8Rtb1RZhS51k+xr8MGIPKiSHQCyWfxEN3cC2msAw7og42SOYCGT4C?=
 =?us-ascii?Q?A4DsyFITVzV0X02D+LWOKb4FiKr2FGhFh5i+uhGkCJorfuFQnsxNp4Ep/P6h?=
 =?us-ascii?Q?LROxz3ECd/ygjtZpqEbxVsHwEdkMpoU2brxl5O1HT+gFFEX/7WSwbMZG/Xpd?=
 =?us-ascii?Q?qxxZ0stM3uQzlkzOWfLz+zJo4TQJQnyLgrBw/0db?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0b5a873-717c-45a1-2b8d-08de0fdfbb25
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2025 13:51:12.6776
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JyRl1isKMp/ihBeM8wuY989T4tscxKT7ETAVGtMA5FFgMnWlArprqLohhvQQPchcFFxwsL+ULIMbU7Ao7SJf0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5840

Hi Juri,

On Mon, Oct 20, 2025 at 01:58:50PM +0200, Juri Lelli wrote:
> Hi!
> 
> On 17/10/25 11:25, Andrea Righi wrote:
> > From: Joel Fernandes <joelagnelf@nvidia.com>
> > 
> > sched_ext currently suffers starvation due to RT. The same workload when
> > converted to EXT can get zero runtime if RT is 100% running, causing EXT
> > processes to stall. Fix it by adding a DL server for EXT.
> > 
> > A kselftest is also provided later to verify:
> > 
> > ./runner -t rt_stall
> > ===== START =====
> > TEST: rt_stall
> > DESCRIPTION: Verify that RT tasks cannot stall SCHED_EXT tasks
> > OUTPUT:
> > TAP version 13
> > 1..1
> > ok 1 PASS: CFS task got more than 4.00% of runtime
> > 
> > [ arighi: drop ->balance() now that pick_task() has an rf argument ]
> > 
> > Cc: Luigi De Matteis <ldematteis123@gmail.com>
> > Co-developed-by: Andrea Righi <arighi@nvidia.com>
> > Signed-off-by: Andrea Righi <arighi@nvidia.com>
> > Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
> > ---
> >  kernel/sched/core.c     |  3 +++
> >  kernel/sched/deadline.c |  2 +-
> >  kernel/sched/ext.c      | 51 +++++++++++++++++++++++++++++++++++++++--
> >  kernel/sched/sched.h    |  2 ++
> >  4 files changed, 55 insertions(+), 3 deletions(-)
> > 
> > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > index 096e8d03d85e7..31a9c9381c63f 100644
> > --- a/kernel/sched/core.c
> > +++ b/kernel/sched/core.c
> > @@ -8679,6 +8679,9 @@ void __init sched_init(void)
> >  		hrtick_rq_init(rq);
> >  		atomic_set(&rq->nr_iowait, 0);
> >  		fair_server_init(rq);
> > +#ifdef CONFIG_SCHED_CLASS_EXT
> > +		ext_server_init(rq);
> > +#endif
> >  
> >  #ifdef CONFIG_SCHED_CORE
> >  		rq->core = rq;
> > diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> > index 0680e0186577a..3c1fd2190949e 100644
> > --- a/kernel/sched/deadline.c
> > +++ b/kernel/sched/deadline.c
> > @@ -1504,7 +1504,7 @@ static void update_curr_dl_se(struct rq *rq, struct sched_dl_entity *dl_se, s64
> >  	 * The fair server (sole dl_server) does not account for real-time
> 
> Fair server is not alone anymore. :))
> 
> Please update the comment as well.
> 
> >  	 * workload because it is running fair work.
> >  	 */
> > -	if (dl_se == &rq->fair_server)
> > +	if (dl_se->dl_server)
> >  		return;
> >  
> >  #ifdef CONFIG_RT_GROUP_SCHED
> 
> ...
> 
> > @@ -1487,6 +1499,11 @@ static bool dequeue_task_scx(struct rq *rq, struct task_struct *p, int deq_flags
> >  	sub_nr_running(rq, 1);
> >  
> >  	dispatch_dequeue(rq, p);
> > +
> > +	/* Stop the server if this was the last task */
> > +	if (rq->scx.nr_running == 0)
> > +		dl_server_stop(&rq->ext_server);
> > +
> 
> Do we want to use the delayed stop behavior for scx-server as we have
> for fair-server? Wonder if it's a matter of removing this explicit stop
> and wait for a full period to elapse as we do for fair. It should reduce
> timer reprogramming overhead for scx as well.

So, IIUC we could just remove this explicit dl_server_stop() and the server
would naturally stop at the end of its current deadline period, if there
are still no runnable tasks, right?

In that case it's worth a try.

Thanks,
-Andrea

