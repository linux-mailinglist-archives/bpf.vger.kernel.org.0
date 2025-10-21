Return-Path: <bpf+bounces-71489-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DF2CCBF4B30
	for <lists+bpf@lfdr.de>; Tue, 21 Oct 2025 08:23:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7415718C3ADF
	for <lists+bpf@lfdr.de>; Tue, 21 Oct 2025 06:23:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 849A325D540;
	Tue, 21 Oct 2025 06:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ry0pm+G9"
X-Original-To: bpf@vger.kernel.org
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011006.outbound.protection.outlook.com [52.101.57.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 694E4223DDD;
	Tue, 21 Oct 2025 06:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761027806; cv=fail; b=ACQV+//hjrUoOlYqsY7WbbBjPBnxH009Waa3KCxdqC7NSBrSduRBWsdki7BwZuM7rKXtxC7Y06UqUf3nJb6fKx61J/4d9FmuaUTZUUkTNCufMoeCPdWHuLeMPvOjCpljhBBGekJPCJ3tFTU9VEb8QlRB2SHFYwhPbwX68ffjw6Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761027806; c=relaxed/simple;
	bh=J/FEreLYqdI3bqXgNSWTeS5esP4b7McdgAcKxPsI9rg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=dMF0Hgb9tgQGYAIz1BuN8dqsPv0p/9Yk6iNytfp5wrdf5G9ZbKKg/Ly/oWCvhTQFvEmcTKORcUhQXDiJsJtV6eaJ4B/EZZu3e13F8kB9hM4Lv1zUVHSXOMUQSsZrvR3xd65aXspHd2SIwVEObQFkKra14UpROO9EgFOxD0RS1lU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ry0pm+G9; arc=fail smtp.client-ip=52.101.57.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Sx4axM8tuIyKQwGY6L5AAfd9ADPutYvPBla13h8+qOYzMPkqjcZlwUoigSayZL32itmeMWBKF/NdfmcJ/pCCgtdzD0vt2v3V6vlaDua6ApUgL/QWPZuxw8znEJTUhVRcObELIC7/yYhSoR3bAx7qYiwH364GXciCPmNZ0sSsBhAwx3x0PK5IaGoIDHVmCQpq10ORhHQIYg/8CRA1pw7riGURe+ySjD9l/Ea7wwof+Mz5ixqSoIYx0D64Q//SR3d1QIEJd4bwUQtVwHhmjvfn7fsiMVw31ApdtHtqq2syeDhtOC/Y2YeSJ3Zu8BTYyZBlr/HM+Tsp2zykf0GcxRpT1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eJwPjxzHgQCW+j1BdEUKFZUH47ge4CFZq786+Fgph4M=;
 b=d6vRzD+LbZI39uJrbz60laOEmqH1oJ4Rt5NxFDscuc3/YOzd+y2ZX8jOYj47mO//iD1hEcNBiLg+wQkMZSpanN26xPxj6NS04DhmVlSsslthtf+NYacv6cAK4hYNgE9qFcD+SHDaKWWfQOPOwWaH51wtrkwr/RSblrQzf0R68uQ+CpJA18uORCV1a+OeZvVHSNH+66eVVYsAvZQxN2UYSweTEUEWdhd/SXMrvrDd57DB78p5EbN1sq9GCiK0bbv/SvANTxFBnx9ytaEg3G0ZGr0LJIdyFU7LktPBBEypkEohNdVIRjcgRP/ZwV9+DFyFCb8jVEYyrypCvjFGFATlyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eJwPjxzHgQCW+j1BdEUKFZUH47ge4CFZq786+Fgph4M=;
 b=ry0pm+G9kEFza7Vgxj30nXF1l3zqHW7xKXNfPnfdZSyzIsLHwnynOnBQAs+//o1PFyunC+WZsSc2kDUSp7mFuDvxgnRwY8sao3JLmVi6oeHf4YREU0/+F/DY4yoDw1llvvOdSAkskX3YNrS1ftc8UXx9OkU1Hc3bdG9/z2k1wqKWs3J5m4vjh5e7bg0O27H/OOzusVj+dMc7f8pSDJIB1c9YNDU2Uary/LQ2Hu6drOjm79XqbOLZcnpxPJiwbwHnON7bAcd6N/aPua9udbfMrByVZLuSXOPH0/qslUhQ09tQW4vYmoP5Kt0P/gl1D/wQdD/t09kiZdUKDtwgmBFRow==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by MW4PR12MB7468.namprd12.prod.outlook.com (2603:10b6:303:212::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.17; Tue, 21 Oct
 2025 06:23:20 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%3]) with mapi id 15.20.9228.015; Tue, 21 Oct 2025
 06:23:13 +0000
Date: Tue, 21 Oct 2025 08:23:09 +0200
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
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 07/14] sched/debug: Add support to change sched_ext
 server params
Message-ID: <aPcmzc9ZX3O-wBUU@gpd4>
References: <20251017093214.70029-1-arighi@nvidia.com>
 <20251017093214.70029-8-arighi@nvidia.com>
 <aPYu_obVO4QjbqUL@jlelli-thinkpadt14gen4.remote.csb>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aPYu_obVO4QjbqUL@jlelli-thinkpadt14gen4.remote.csb>
X-ClientProxiedBy: ZR0P278CA0197.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:44::8) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|MW4PR12MB7468:EE_
X-MS-Office365-Filtering-Correlation-Id: 48e4ae19-6c44-4f2c-c6c7-08de106a5064
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Xy2+evLwJKB/HSiqb2y8f8BFZVXxuwJ4UAekCmWpEcG3RDjtX7eXTY6BHK3t?=
 =?us-ascii?Q?YXagGD2sNmuhjgE1/fW92rqYYsb6/4+hKoDARQbhYkjHr7cgeRltw8vAMXf3?=
 =?us-ascii?Q?GbmbgUofeYFNbOI1AIrz/yLMMdtZwJVK1iuXZW9BVRqnOErFkJsm1mDg1FC+?=
 =?us-ascii?Q?Y88uSmM3osgh6vqVztgxNAYKVeprxLZXhIhitr1ALuCPX9JqALMUfbE5FpII?=
 =?us-ascii?Q?IoZxza11+mLlR8oQuF5KZe/3oCwFJaifeDS5hhznWbLYOlk8KL9hu4oYPalo?=
 =?us-ascii?Q?xs4fapbUy0isragUIurIxTsnFq7if3WVwFgIG5PwFMLupVBJ+kZnaUBKjjUj?=
 =?us-ascii?Q?n9wtKlc9iPHU/I9WfEC+q1L8jjR0459X8F02LBQKidRSAJy0OimlfhyOIgt5?=
 =?us-ascii?Q?jUXEdGkqP8ii102FsMX2QTKVvnFUnFKrpFdvbZUMiwLkjh++b8SkUlMzQ1zF?=
 =?us-ascii?Q?WCyTU7/B09dXYgWmmSMzlhncN89eRRRzuaxllcfKnMU2AaOlgaX+DsHHalz2?=
 =?us-ascii?Q?PledZHhL0GBUt6Vmm2ODKQ/BlpKyzyYg1Vqu8v9P7YHeyTooJ28M/KbqUoJ/?=
 =?us-ascii?Q?y9P7/Ynw6D8FVX0VrY0gbsMqmYlBb6uzPK/Rwrwb1rs/aWjIK4EBAR0u36Ve?=
 =?us-ascii?Q?JvElI2IeQIB8qY3wFaMVbL6Zk6IGGE/rXFQzK3rLoaQ8guztTy7zvUGNV88S?=
 =?us-ascii?Q?w+8kkpGdOxg6ifgcql7cnTKjnVK8Lwdevd6Aq2DwQWD15bPjhWN3MDG/GDMm?=
 =?us-ascii?Q?ofE+UpRcD8ZsJoyJvtBk7Wzm0OUE6oYRI2yM5o79YNZ1ucEFuo0c9z4pt9tk?=
 =?us-ascii?Q?vVUuu2Lgoe0Mu/J5y8VtjvDwW0OKsX1E63Pkwa6tNcsanSg0l2739/lyiqVo?=
 =?us-ascii?Q?7PaIOpf5zipwBiR8isPJbcDZw6Rc8eDfpaqCDNg31nslYKPBMEmyvfygbgIa?=
 =?us-ascii?Q?eeXzwDZ47anIo58sb2zBYQX4bnkrgURXJ3kP7hwYHEnybVsoALVSckY19vd9?=
 =?us-ascii?Q?7nzMvTzUQpkom2viU/fnZRBT2clohC/oaKaC4A5fxY8E8dTMNcDfb8WCNfkR?=
 =?us-ascii?Q?6LAxMdmvA0yDt0CPer6JtWSI+PPfQ55j7cs3cGUzRglvUxs6RbbhCmx+Bi3T?=
 =?us-ascii?Q?31QUUCLowUFoz3/O7rR0K90th9MM6htiBQobAhUgr+VMFTeS6qBxkplVQPrR?=
 =?us-ascii?Q?V7b3aopmbnnUJpabZk8CqhTWUWWFrsTRr/G2y6ngRNq+Mnzjc9YGmTPA6554?=
 =?us-ascii?Q?tvQqmX9xJFDLokAKSgwX1QuiJaeoHY35xS4YXO/6gjePzfGx8Pv3pCRqjnwC?=
 =?us-ascii?Q?Cz1MrAi3krUlM9E25qJlS2euE87jyLs/lq9v2cwaMQsYTZRhZxHwuYktaqp0?=
 =?us-ascii?Q?D5INpH4NJjT6n8DJJtC5rz5ii8imKzjEgcOvWfjzgSyP/2irbP3rQ88K47P1?=
 =?us-ascii?Q?LqzDvRzuP/W0tVwGpF1dFem6fhtwk2Le?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?nACOhBzMxs7xyBYBfsfwIfNTDI1Zc2Nm3nwRKaIbPWlQPRsio2ILU5XX8Va9?=
 =?us-ascii?Q?iS2DHK3EcU39D/DvGHvMe9OwIMV3WDlu2uqHdjRVYo8RDa9sXydZnoBV2wJU?=
 =?us-ascii?Q?axrpj/28lkiwsQJLD1QvW6ip3RTQv9sIoemmzzDm+jWoV5cdqsLIeDDuL8qR?=
 =?us-ascii?Q?11hGyz1NqGajN3QTLytArmVpVLo3RbHftqB55kTygA+CUdzPVFq1cvcnYrDp?=
 =?us-ascii?Q?BZINJq2IdD//2Y1p29MPZSZtzP8F4m16T4ibhackz9SoysbdNszp5vIYuiz+?=
 =?us-ascii?Q?tfasEO2NVXpEttJ7+1HFHdCrViHBtUb6blxp+sVu/sO1PrmR3z+tw3Os3uZz?=
 =?us-ascii?Q?zRs2Sw7DdvExuCoGe/HA5eqlgWv3gjAcT7ieVwP5ITO/ZafJSwoxS2+w0+JO?=
 =?us-ascii?Q?44/yWnrNN0Zgf3wiLAj1FhjWJSSazr35GEiWXU9iHlVAEbXqxbAuG0tg/wOA?=
 =?us-ascii?Q?7miVsIcO8pkQNrrFsDH+DdUvU9SofT+y+rRlfUyC+o3QraN7NOirK8s2jrA2?=
 =?us-ascii?Q?DKGu364pkQxhmHqmB6bdr1Ob2KyR2beHB1WH9n376sgsHsTa/qjK08DE86au?=
 =?us-ascii?Q?conMi/ebJo2ttkiFEK/rF7hYsQWcNmPKbAnbykA6a8FflYFtqaY1bIbadzIh?=
 =?us-ascii?Q?Cvn3rAwHaz76lxpYEzIhzUhqGa76Io4tJSph3AXvzAcoIL4gl0Ipp2nO8mVp?=
 =?us-ascii?Q?CvtT99sPP57dTRLGzMFCqBhWJyzQ/jU7lIHC9nJOP0+md9SvvzYV5/1CEhK2?=
 =?us-ascii?Q?2Hc2rn+zyXS8b3ObvhzeqMU53qt+5i0Op3KGTabkeQwjFJgIGh0YWzI5nSbT?=
 =?us-ascii?Q?2Z9T5j7jRZN+jrTcdik1ULVav//RwDU3QubOD7wa8QGmbdlWJigWi1rd5mCu?=
 =?us-ascii?Q?iHlHGy080Q6A2S210G/s0gPR/y3TpHKr1gqpvKSgLhuQsfWpY/XUjRhlrxce?=
 =?us-ascii?Q?6veKiytXCnDgrwpSpeLYrNmjV/tmyAUgRWVeA5ffUg3BZzoYWMgX6H3hwCKy?=
 =?us-ascii?Q?aZyOFK0JH9pr38uyHKW+VS3gdHz1hlk1e9ZMuHKWKub1ocC+hoY3qoy8MqtS?=
 =?us-ascii?Q?RpXZbAYmw2ikfsT28SDnwk/XBYuQ0SSoC5PQcfzIg28AfT0ZYUKVBlmXt+C+?=
 =?us-ascii?Q?juLOTDc4Ca+RTB0cWS/WgxU9warNzRXrn1UduRfib+Hw5kDz9pbRp2TcpUP9?=
 =?us-ascii?Q?lfgaCUTvjRSrhoN19A6Zc/lOe+pI8VP0UT8MTYCVIMqb48QLRTdQIz6EldKa?=
 =?us-ascii?Q?ooxL3pOGszLotN4nRXq3RSHMVoAX6+w28uZfOQpyc7Za4DJcDmG85ZGnhWB6?=
 =?us-ascii?Q?EAkp2weVoYjFYZ82nRCgweChAhp9AKNxygbEVKVsJFDCZPUCZVQkVKQ9qa3K?=
 =?us-ascii?Q?0mNoqwFRdooFT8UqIA9pmjPzmNB0RIjVwS6mhbpdgjFBas9ukPVm2DLHP/8+?=
 =?us-ascii?Q?PBl/CkWcSDKtRx55wWCf7DsJtmxPj96xYfndChSJJv/bdjBLKOoHtTmFI7lk?=
 =?us-ascii?Q?RckH4JXj2sKoNa33CcYmRMAxCMgOyf8rfFt4oxMiLBArEoChf7oYDiqcbnVZ?=
 =?us-ascii?Q?uYQbr6JkIdoCUerc4Jkgb1jKkUIBT+fa8APGul2A?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48e4ae19-6c44-4f2c-c6c7-08de106a5064
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2025 06:23:13.6502
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Zetcnteje2GHwmD5q1NLcJrQGMrSUQS5t6+H6IbNgpmnWGwZLbqONtsTzCcMQhCRjfQSrGbpJqj0rKzAYMs4qw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7468

On Mon, Oct 20, 2025 at 02:45:50PM +0200, Juri Lelli wrote:
> Hi!
> 
> On 17/10/25 11:25, Andrea Righi wrote:
> > From: Joel Fernandes <joelagnelf@nvidia.com>
> > 
> > When a sched_ext server is loaded, tasks in CFS are converted to run in
> > sched_ext class. Add support to modify the ext server parameters similar
> > to how the fair server parameters are modified.
> > 
> > Re-use common code between ext and fair servers as needed.
> > 
> > [ arighi: Use dl_se->dl_server to determine if dl_se is a DL server, as
> >           suggested by PeterZ. ]
> > 
> > Co-developed-by: Andrea Righi <arighi@nvidia.com>
> > Signed-off-by: Andrea Righi <arighi@nvidia.com>
> > Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
> > ---
> 
> ...
> 
> > @@ -373,25 +375,25 @@ static ssize_t sched_fair_server_write(struct file *filp, const char __user *ubu
> >  		}
> >  
> >  		if (runtime > period ||
> > -		    period > fair_server_period_max ||
> > -		    period < fair_server_period_min) {
> > +		    period > dl_server_period_max ||
> > +		    period < dl_server_period_min) {
> >  			return  -EINVAL;
> >  		}
> >  
> > -		is_active = dl_server_active(&rq->fair_server);
> > +		is_active = dl_server_active(dl_se);
> >  		if (is_active) {
> >  			update_rq_clock(rq);
> > -			dl_server_stop(&rq->fair_server);
> > +			dl_server_stop(dl_se);
> >  		}
> >  
> > -		retval = dl_server_apply_params(&rq->fair_server, runtime, period, 0);
> > +		retval = dl_server_apply_params(dl_se, runtime, period, 0);
> >  
> >  		if (!runtime)
> > -			printk_deferred("Fair server disabled in CPU %d, system may crash due to starvation.\n",
> > -					cpu_of(rq));
> > +			printk_deferred("%s server disabled on CPU %d, system may crash due to starvation.\n",
> > +					server == &rq->fair_server ? "Fair" : "Ext", cpu_of(rq));
> 
> Guess this might get convoluted if are ever going to add an additional
> dl-server, but I fail to see that happening atm (to service what?).

We could add a ->server_class() method that returns the name or something
similar, but it's probably a bit overkill, since we have just two dl
servers at the moment (and I don't see any use case to have more...).

Thanks,
-Andrea

> 
> Reviewed-by: Juri Lelli <juri.lelli@redhat.com>
> 
> Thanks,
> Juri
> 

