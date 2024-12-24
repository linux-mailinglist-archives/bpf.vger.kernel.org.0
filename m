Return-Path: <bpf+bounces-47584-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E1A6D9FBAD1
	for <lists+bpf@lfdr.de>; Tue, 24 Dec 2024 09:58:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D3F0161FDB
	for <lists+bpf@lfdr.de>; Tue, 24 Dec 2024 08:58:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38777196D8F;
	Tue, 24 Dec 2024 08:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="N9uNw1cI"
X-Original-To: bpf@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2056.outbound.protection.outlook.com [40.107.243.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09A3818FDCE;
	Tue, 24 Dec 2024 08:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735030717; cv=fail; b=ulCjtBiDu0d/ZebMoK7ywAmotz1L97ZmAgyTa6hhze2RhnZzq0xmP3QKw2caDkHr9/ljSNcgkZbnDirU7d/YAMjDQBdkBx+jTwCpktAdmU6wpCswo1p4vWN6IvewS5Z5E8+Znh7CEXWGiqKevGYfhePYqiXRwZMIS+L57cNVg8k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735030717; c=relaxed/simple;
	bh=Rlam3HDHYjCq1oJRUmVMFj2xy4RTo/t+Y8HBeYjD9ug=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=nUfsrvdN+ftqxdQ8s4WAM/2E/vJbe77PQ8x+RLJU0SKccBcrhsdOHaOiaiEa3Y5RiRgHedlmu4msj4WTjcOrb2JwmJe3JKpO9FHChx3/i9kFZsrCP+hkjbkNdt5d01hSImU9SeM1BATy8n3YvwKl9wyQQf05d75qDdA6jyC69po=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=N9uNw1cI; arc=fail smtp.client-ip=40.107.243.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o3eiB95PQM0yAxQiZtbSGYv/OMpVP1gYaE6aCCiBD7kkKcsnKFvUvNy/o1/MCVIQeyYIFIFETer11U5D9wUAT0ZEn9h0buQZCOmQ5IAPeQ217SHMlyBvP1+dsv5vAWiZKyqArKNKM1V09ooxTx0unlArQ8AFZ9E+YYAhPpSbI5r9HalQ0SZsyew4JWKJd1l/WKVdZMLHkYu9kiICYRbfgVtBYySrhZ0Js6ktZ8bEo3XhecwQp9Nm1oT22xMp0I5epscrHksuK/MF6GXPSDNEi5ctn4uA9vJqSHP2pGXHxRJ1k+m19AYJJciwUYgPyzgsvgi9nfDh03Aztniz/0mIgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bet3xbPht+OUf6xQKXzIS6ruFEKULSfPLpzMzPYjB+w=;
 b=iI1RhDXKiF8WorbmBDLHOCEmbxpHzzKeMtSmgJmUx8zyUhIZBZ8MVOMaPPKfb7ESRFL7bnWCc4QmVrnDrYky3OOxRzR0r/EKUi+L7emBtCDRhwqFxWpQxuG5TPBsEA9F57PvDZn+4cd8d6UY3IaJPVz0x527TpV6cQlt+eV+55LEvShRfUz0WuVUOzJNmP0I50n+dGrclwroThQv6I1YnAk2fgRxwxHpMP/ui1Z6guf6bicxpVz1wBp7L3F6boY80jzf9d1rngK0KP2/kqroCsfL961euSuKAJLGfLHRQEDyb4boQzDtJnrExnmjkFLe78IXfEvbc98YyC09ebnN8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bet3xbPht+OUf6xQKXzIS6ruFEKULSfPLpzMzPYjB+w=;
 b=N9uNw1cIaR9Z1t49vegISuHBoo0Ezub79kJMbIhVO+UBihzFga3wqaa+WFVOtr7o0yDGyMekIzX9lAprvVQVF185yh+k34/XVLJYVA7FPgTeaaIMYgiH/djM/g5MysSQuIx3sXhIs+JLD5s0IMS5Pz3GgVJ6sgV0SXgpI1PMAhWv+7eStAKumN+uYdbj+rkVIhq41UY17nSe8aKzhpYCDf39+NhrXNC5CwyanqIhp4k/uq0vX4GprqrgHkIbYiY8LuRH4qV/TpRk5MeDPZwwyteJIMvh58KNXk9N4onjd1yoPlZmsxftifCiVHIceCT6pOGOElstxc8SSLUmjiutCQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6405.namprd12.prod.outlook.com (2603:10b6:930:3e::17)
 by CY5PR12MB6060.namprd12.prod.outlook.com (2603:10b6:930:2f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.19; Tue, 24 Dec
 2024 08:58:29 +0000
Received: from CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5]) by CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5%3]) with mapi id 15.20.8272.013; Tue, 24 Dec 2024
 08:58:29 +0000
Date: Tue, 24 Dec 2024 09:58:25 +0100
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
	Valentin Schneider <vschneid@redhat.com>, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 09/10] sched_ext: idle: Get rid of the
 scx_selcpu_topo_numa logic
Message-ID: <Z2p3sSZJRCIfS9jA@gpd3>
References: <20241220154107.287478-1-arighi@nvidia.com>
 <20241220154107.287478-10-arighi@nvidia.com>
 <Z2n0xDaP7Ulq1DSg@yury-ThinkPad>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z2n0xDaP7Ulq1DSg@yury-ThinkPad>
X-ClientProxiedBy: FR4P281CA0017.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c9::13) To CY5PR12MB6405.namprd12.prod.outlook.com
 (2603:10b6:930:3e::17)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6405:EE_|CY5PR12MB6060:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a009c10-94b7-489f-8da9-08dd23f922b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?W5IXIPN+tyv8+NErXpJ+mO+VAYL0GeO25UMRxTya+H3akpslpu2zcr+i9pl1?=
 =?us-ascii?Q?i06l/vAO8tItTAiD92RKRAPjdXos/wQ/1Jit46jkhO1QgZYaDLn/3phcEPrB?=
 =?us-ascii?Q?N6SIh1x5BQGw6ZFM0kDUVR0L00OUc5qKrgFRlvJ0J5uXMY3VnPV+q1NxZJ63?=
 =?us-ascii?Q?0pt2bUC7TT9wnYkJYJnXm9quV0a1IqZIoaEoN0+AoNNGrb7Ruk6qc1LdK+sL?=
 =?us-ascii?Q?klU5dUyQloTvg7V3+F18NjI80z2d9XByKFSTaTt+queCpUo1lOKusSywvQUR?=
 =?us-ascii?Q?/sGTuV+9+QYAZg4VwoDgLVdJfAFxf7rmqyrp4jTYFQeuprqxY5+WRtzQ6PrQ?=
 =?us-ascii?Q?9vS8YlWnuryg6M0ni7TLmNHv0dKnLGDd0oLicZph8DvZDqnun89yiBn+abV7?=
 =?us-ascii?Q?0lEzm2XVlhGzVoqgD/0FpWmEmouX/m4WZrULoa9wuRTunzymujKDdFhzNG/o?=
 =?us-ascii?Q?IsFiEc9yij4TcruzKj5lGbOb1a6ShQSMgo8ePjn5YRZfg1ZeyM6hcOLB4pME?=
 =?us-ascii?Q?DJDLB4I9oiOpLJuoiKucPq4V8z8pgVw61N/GdxjDxSoIoey4y8yyGfdfya6Y?=
 =?us-ascii?Q?DpR4ZibBBrEmINoHS3ySS39mn5hQJxYIz8lXTFh99m/Ri00cF5mqzvEJ+yZ5?=
 =?us-ascii?Q?GaLHcgwOVde6go0cpLYWBnkdkxsRwkPu58BimCrhHHpZ7tspHhKiAkKvnBFh?=
 =?us-ascii?Q?boovG606O/iTwP8+5nKzozWgt1e8FWVZqpPviRCFbhMNgeRFa1vPrb2usdLA?=
 =?us-ascii?Q?r2J6fbQL4gViS0sXrCnLkhs51g+uKesRIPbVte4W8KWlImWkTcL2tOXCcTr3?=
 =?us-ascii?Q?d00/VE/3igkNkHKqm7R6MTVfn1qoTlsIfGHBIhdZ2UMPq1XBjYluMEau/Q56?=
 =?us-ascii?Q?BDv7AyWWO9ZWdCPsvSYvMkTAua4T7vieDLe9ESpEeLYpSyAuP1dvCmHwxogg?=
 =?us-ascii?Q?wcyi7GZMF3+GZnw/bHT5sguAPO1rC7cn37ehFSLY184t1DdCcUY7gTCCxSS8?=
 =?us-ascii?Q?Ryl/CV/DMIrf5idDK8EcsMgEK1u63diwTBbPcL/lAad4GlWoBpPFdNUqcNyK?=
 =?us-ascii?Q?+pZxjy5n+xjB5Vgcew9sJqzlamgySEN0mIWrnEhCW5x9UA+qN5ae6hPcafoq?=
 =?us-ascii?Q?YxyE/YNUGWLr+iEM/+upjSxLlEweaU/j9xpdw5O1/wNJFlOielg/C/9Qbq/l?=
 =?us-ascii?Q?Oy97IoEIIY5pDy5huvehpyCQGCk8S9VS+5qlAGc5npACahOCTuGt+gX3Qoxd?=
 =?us-ascii?Q?7v664VnoG7KmNEPq5fJI9ub8kv3uqL7RrXNYEpMorjJhRbwViGhBmxzEO3Pc?=
 =?us-ascii?Q?PK6OibRkzxsa9I0YqCMEVxda8E/UAggela/KvjtfIs6hJfsvWZsHJ9sUAj+8?=
 =?us-ascii?Q?T8q0y3pSZOYtrj4b1Sb/0ZUjvkHP?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6405.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?T/DcdO19g4gDZWDxX7zbgEY3qDuaF+OqaEJBwVnIFybw60DGBRrUTyWyLBsS?=
 =?us-ascii?Q?AZDTvppBhbnLV3OF9rjRalNK45YV7jlji5Z4zt9qXleKVI8RIWh8RV8TrOlm?=
 =?us-ascii?Q?do2/Y0Brv2x3gkC4hGjoo1JuPond6R029Jt9ugOMaJvCzuk3hxHYc8mVmtPE?=
 =?us-ascii?Q?RQQTRGWXNyg5WJWD2pVkrjlMjd6GIM7iOeBGDQb2TVXmWa4CwmaKQe21svAF?=
 =?us-ascii?Q?7LCISvehP4Jl2qidF5m7mtFYhi1lTx0EtYjWfgTQBAvtydznkZQnoB8bBZzv?=
 =?us-ascii?Q?l80dOP079MEet3/84OiMw1fu88DFHc5nO7gUNxAaWNWZxKFel9+C9m49sPGo?=
 =?us-ascii?Q?CpHuImjLFBjY6EhuC8/4oChMIUjJrudg+kDaSOVYU/PisK8Ihg8ugdxMhPyl?=
 =?us-ascii?Q?WNgnDWmaANzwsCngMA+jGtockfLuehCqrLPS1j5t1JVc/OUsXlhJBzXnPmmR?=
 =?us-ascii?Q?wTYploO+hyNPP90e18Qp9+No3AEWOMwCicnICYAZGqqqd7WUF0P2IjrFD8ra?=
 =?us-ascii?Q?gqt9U/vF7fz63jkN4GRsDzOLTl5UTs1hasl5gYJ3zxcngJfowf9Kn5PRKMJh?=
 =?us-ascii?Q?ji39i3BZaUxRB8OyIpH+9TzSlhaxjGHcek/HU8Oj96K0V6fO92x1jIrEgmUu?=
 =?us-ascii?Q?wzIfbeKQ1CAXfp0NxCWJRKG/nPKnxcHi1y3gbSCEycnJSkOwmdI0rHHLZ6nS?=
 =?us-ascii?Q?7JGIwdRtvmYNBEBI7jCOeme8fxaF+hK1mNvp3F3oo6P3FRq6JZKH8Ulxknik?=
 =?us-ascii?Q?VP2nmHl0m3aV93csmL6tGP2TPTLrqU/3CJz5vRMdQsEfYZPfXRE+kj+sOY86?=
 =?us-ascii?Q?7KXheQ+qZxMuqiVFNBI/1QvErKkHDYlSt6SfE82yXWkuyXDEvV5R7F0xM3T0?=
 =?us-ascii?Q?cSfOGGhWqvqp89TJeSE7MtPCRs8qBTbLkKFZdt8hWUQcYKg80oUvgtDYUHFy?=
 =?us-ascii?Q?aFdL2MyeboShS5HonS26+rGp+c3lvIEo6PpD8u7+85lEs2SrLe0jMdcXdAQm?=
 =?us-ascii?Q?7Bd+0D82yI4gi16Zm795FkdE5nVSizSHrk7arhXKotzRlRk2DoyMiSMAohgO?=
 =?us-ascii?Q?Tdo7Y2rtkigEg8KFypBa8s/2Fk4ZiDL2adbJuCvn4/zw+P8oMg6GCeYVogAG?=
 =?us-ascii?Q?TnMavPP6qHbBQ1hXWCkpG1pmH8dt5yd3/OBhw3ZDKie32xvfnM50S87YK2rK?=
 =?us-ascii?Q?Bbh+IzHZoC7iNq394zR7ajMx1newIngp9aFu5HKcChuvr/+EhEVQS1Jwdrkn?=
 =?us-ascii?Q?zPXgRNmI+9Z5oI85p7F8m0jJsoAyuluDYOJZRQYbt63aAI7uhYc+fTUxs55J?=
 =?us-ascii?Q?lKnBCoLp+acHeyzb+AQambHo51Sfk8kGh/3UwhZYT/ubmlOi3vA0/Dmx1oQT?=
 =?us-ascii?Q?VxJ1ucN+p8GKgNmu6K9zg0WR9heniXhyyUj1gfNgudRELjruKxMKdCpLX53F?=
 =?us-ascii?Q?pIYNPEyHIkoqi8f0SxdetI6+9EcWQFUjwlydLCHNZ/XtqzkoNLT3gPkNdPBA?=
 =?us-ascii?Q?6+39Oktqu8wrYieZAD9OwKLRPPej3iTOp6l6D8fYOc+MG5zVuNgd95LJe6Gm?=
 =?us-ascii?Q?Mcyu0A+RLGw7PGVgRkU/HZ/MNQgu+Y08OlJcWp2+?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a009c10-94b7-489f-8da9-08dd23f922b1
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6405.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Dec 2024 08:58:29.3223
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LqeWkNtEybOblhbOvhSeNZuWmQkoFkeliIFVJyJpj9ky7je7NXVrnBWmdgMI4jUolSe16+T26rIANZq/ps2Hiw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6060

On Mon, Dec 23, 2024 at 03:39:56PM -0800, Yury Norov wrote:
> On Fri, Dec 20, 2024 at 04:11:41PM +0100, Andrea Righi wrote:
> > With the introduction of separate per-NUMA node cpumasks, we
> > automatically track idle CPUs within each NUMA node.
> > 
> > This makes the special logic for determining idle CPUs in each NUMA node
> > redundant and unnecessary, so we can get rid of it.
> 
> But it looks like you do more than that... 
> 
> > Signed-off-by: Andrea Righi <arighi@nvidia.com>
> > ---
> >  kernel/sched/ext_idle.c | 93 ++++++++++-------------------------------
> >  1 file changed, 23 insertions(+), 70 deletions(-)
> > 
> > diff --git a/kernel/sched/ext_idle.c b/kernel/sched/ext_idle.c
> > index 013deaa08f12..b36e93da1b75 100644
> > --- a/kernel/sched/ext_idle.c
> > +++ b/kernel/sched/ext_idle.c
> > @@ -82,7 +82,6 @@ static void idle_masks_init(void)
> >  }
> >  
> >  static DEFINE_STATIC_KEY_FALSE(scx_selcpu_topo_llc);
> > -static DEFINE_STATIC_KEY_FALSE(scx_selcpu_topo_numa);
> >  
> >  /*
> >   * Return the node id associated to a target idle CPU (used to determine
> > @@ -259,25 +258,6 @@ static unsigned int numa_weight(s32 cpu)
> >  	return sg->group_weight;
> >  }
> >  
> > -/*
> > - * Return the cpumask representing the NUMA domain of @cpu (or NULL if the NUMA
> > - * domain is not defined).
> > - */
> > -static struct cpumask *numa_span(s32 cpu)
> > -{
> > -	struct sched_domain *sd;
> > -	struct sched_group *sg;
> > -
> > -	sd = rcu_dereference(per_cpu(sd_numa, cpu));
> > -	if (!sd)
> > -		return NULL;
> > -	sg = sd->groups;
> > -	if (!sg)
> > -		return NULL;
> > -
> > -	return sched_group_span(sg);
> 
> I didn't find llc_span() and node_span() in vanilla kernel. Does this series
> have prerequisites?

This patch set is based on the sched_ext/for-6.14 branch:
https://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext.git/

I put sched_ext/for-6.14 in the cover email, maybe it wasn't very clear.
I should have mentioned the git repo in the email.

> 
> > -}
> > -
> >  /*
> >   * Return true if the LLC domains do not perfectly overlap with the NUMA
> >   * domains, false otherwise.
> > @@ -329,7 +309,7 @@ static bool llc_numa_mismatch(void)
> >   */
> >  static void update_selcpu_topology(struct sched_ext_ops *ops)
> >  {
> > -	bool enable_llc = false, enable_numa = false;
> > +	bool enable_llc = false;
> >  	unsigned int nr_cpus;
> >  	s32 cpu = cpumask_first(cpu_online_mask);
> >  
> > @@ -348,41 +328,34 @@ static void update_selcpu_topology(struct sched_ext_ops *ops)
> >  	if (nr_cpus > 0) {
> >  		if (nr_cpus < num_online_cpus())
> >  			enable_llc = true;
> > +		/*
> > +		 * No need to enable LLC optimization if the LLC domains are
> > +		 * perfectly overlapping with the NUMA domains when per-node
> > +		 * cpumasks are enabled.
> > +		 */
> > +		if ((ops->flags & SCX_OPS_BUILTIN_IDLE_PER_NODE) &&
> > +		    !llc_numa_mismatch())
> > +			enable_llc = false;
> 
> This doesn't sound like redundancy removal. I may be wrong, but this
> looks like a sort of optimization. If so, it deserves to be a separate
> patch.

So, the initial idea was to replace the current NUMA awareness logic with
the per-node cpumasks.

But in fact, we're doing this change:

 - before:
   - NUMA-awareness logic implicitly enabled if the node CPUs don't overlap
     with LLC CPUs (as it would be redundant)

 - after :
   - NUMA-awareness logic explicitly enabled when the scx scheduler sets
     SCX_OPS_BUILTIN_IDLE_PER_NODE in .flags (and in this case implicitly
     disable LLC awareness if the node/llc CPUs are overlapping)

Maybe a better approach would be to keep the old NUMA/LLC logic exactly as
it is in sched_ext/for-6.14 if SCX_OPS_BUILTIN_IDLE_PER_NODE is not
specified, otherwise use the new logic (and implicitly disable
scx_selcpu_topo_numa).

In this way this "removal" patch would only implement the logic to disable
scx_selcpu_topo_numa when SCX_OPS_BUILTIN_IDLE_PER_NODE is used.

-Andrea

