Return-Path: <bpf+bounces-67309-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DDADDB42577
	for <lists+bpf@lfdr.de>; Wed,  3 Sep 2025 17:31:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 065B91BC5CD2
	for <lists+bpf@lfdr.de>; Wed,  3 Sep 2025 15:30:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56078247DEA;
	Wed,  3 Sep 2025 15:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ko0eT/4J"
X-Original-To: bpf@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2042.outbound.protection.outlook.com [40.107.244.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A1BC236A70;
	Wed,  3 Sep 2025 15:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756913092; cv=fail; b=UKhYvmPGJPP+ituZx+uLULKb1Jygy8yfjqgC+uRUpozjTs4qKfg/iUk35HMZ2qgRGLKwUH2Ts2Tf2g00HKyWKLNXLWcmR5aaP0ygHUFDSqQWnVzjS+I20CtakvftoaC3SBUUiO0nREGjcjkA6fy/1acOn8XiqJwHSLS3gzP8O84=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756913092; c=relaxed/simple;
	bh=CkPPWJYMv0mXUuBLDmZvOk7XTd+4SoqG0T1PIoWz5DM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=fZ86eeKMR8+z0vYap6CSbRTkaDAkI7L0zndytb9Ko45+wF4QhKos2I/sKoBGkmlIIP0TH4mzMdfMPjCsuHMSPp3+9GpwpgEkwnOppj+nVoNZILZBe/NnmtcKGrnlLXX2R6hBp9ziteenq0IQ1ne/GIPIliOpnNAsnqIPXi3/H6E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ko0eT/4J; arc=fail smtp.client-ip=40.107.244.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fHu92xgjiyUc/LuUlNV/rTSDARoqHdLciZywFotZIxGSXD1+Gj4jq9kxUCpLJngNZV4uliJtMoLtUuf4CkTVOA8qJuHoUIFLhoDP6GtNc91dACya1Z91FUBxAaMcEXq+10yDDdPF/7OrR9gO89N7n3KrOv5q2RUScM2i172CAXAu/SzCYgvPcWHYlEaP2OYbq0Rf/QifNLo4p86PCsJB/CE5NC+JSyP5m6isRFhF32FGwtqbMs3woTsYhta9FSgxLXsNL7ugBaD+nGt+AIwE8Xv7MRgODjZsBaJyLRt6B79tfSNJpStkSM6DwFwscVM3SXTSmPZeNnQx1tEoA7me5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xQfbOsTRW44wlGzjdIEX5i/aFdpEAn3/Y2krZSiIUPw=;
 b=FW9VVHcYuK3Kq4Y3s1S7NiulMxLI6X2/qdkNluWCUk9Ijb2BZzW1CyW7UWz/n42hTU/dqiPmDF/lZ/oyRcrLRjIDBeYYQpcRfpyfkflgwpPbMmnBZqo4MwXF7HpR36gUq4NvnleYlu+aFKL+409lzwEmaK/+JwCtvpvcwy8/S2OPbbK7KBkJf7Ka6/v15KnPAz6iV9ePS1j9s1f8PgaJKOGDG7OzwjzAZNReV7eZoFC6pwRyxpvNH2AbBJmnsfoh4xq7hZvPl7S1Jg5phII0m+xI6uff6oiwo19kkai0TDZu1bkktFUajKcGIP4Q3njBv2rFTR/DEIcizUpPUgDeaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xQfbOsTRW44wlGzjdIEX5i/aFdpEAn3/Y2krZSiIUPw=;
 b=ko0eT/4JGp9aCI9eEBjuHJH7GNuaV9hY0STYK3ehvMNADVrQrWKsIu1nKaf5x60pfXR65okazMy2/lj/Bf6uwNT8B8xLrpgiNoRsPIpgjYPb1D5l5AKaYdkRKWlm/8ZvFUFwgdnLgMQEFxx5UEQCXKHmqQVcIbs45OQA+EYzv98JZF6LoGxDg9+23foPkVeDn9d/427SLIyKdZ5DkQzJFr+fKJSMRMynAu6VWfET3UPCo4yydX59HLjTzBdY+SSWEqmOtMZTbzqpGC1upmmgwtnUhj2pKTfVzO9tnfGKGtAcG8kk/zHCR1+BqLkHRNMgEKb9dnIeD8WZI1mxKQkGgg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by CH2PR12MB4200.namprd12.prod.outlook.com (2603:10b6:610:ac::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.17; Wed, 3 Sep
 2025 15:24:48 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%5]) with mapi id 15.20.9073.026; Wed, 3 Sep 2025
 15:24:48 +0000
Date: Wed, 3 Sep 2025 17:24:45 +0200
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
	Luca Abeni <luca.abeni@santannapisa.it>,
	Yuri Andriaccio <yurand2000@gmail.com>
Subject: Re: [PATCH 05/16] sched/deadline: Return EBUSY if dl_bw_cpus is zero
Message-ID: <aLhdvY1D_RZF_ahw@gpd4>
References: <20250903095008.162049-1-arighi@nvidia.com>
 <20250903095008.162049-6-arighi@nvidia.com>
 <aLhWh9_bJ5oKlQ3O@jlelli-thinkpadt14gen4.remote.csb>
 <aLhafcdtmW6s-ydD@gpd4>
 <aLhbhv1oiwxQ2E6b@jlelli-thinkpadt14gen4.remote.csb>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aLhbhv1oiwxQ2E6b@jlelli-thinkpadt14gen4.remote.csb>
X-ClientProxiedBy: MI1P293CA0015.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:2::14) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|CH2PR12MB4200:EE_
X-MS-Office365-Filtering-Correlation-Id: 65c5af4a-aed3-4800-2542-08ddeafe04d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Nu+r+mt/rVO+Pe3tqYqezsoOIPeQSRs9GlzTsS2QGMa468p5cJFD+hoG5Ucs?=
 =?us-ascii?Q?zhKs4Le86MgH9ybySWiufqNgrwaYuQBGMl8a1iI3U0ohNXOUhShPGovMqea+?=
 =?us-ascii?Q?gbVmjTaJz3Yq2Mh6NyD8HKKnKEjpnWCD88Xpk75gePXGWMlOAAIsPERQJiXO?=
 =?us-ascii?Q?3OuX0o9ytyvgxcYRWxL/6Yj/F/gUugaW2MuQFHNqDwDvt/4lyxkRERI2zvhg?=
 =?us-ascii?Q?jlCRKFiMcKOxU2sB8Hl/x1b3uYeW5mDoJ+sRa3HT/ORQTMLvo5RuJpOy8EJu?=
 =?us-ascii?Q?iIW6q954uEUvsCpL9bmhy2VF2fBXaE5oFm073S903TOkpgsepYYeckW956X1?=
 =?us-ascii?Q?hEjjFTFq24EC34hu8RdQByuqgrPOi39LV5IM5w0cvRVI82mQ8cpDdOiR3UIS?=
 =?us-ascii?Q?DRPStYaQ+a6oF64NsTk35/i8vErXaQNM7SyduENs+lN/5j9+oV7z67wUUrhf?=
 =?us-ascii?Q?XKWouwh5v/z5SICpnBmZgc8qimIsHtM3uqzTqP5FJZ6XxdbQAV4hUBfM5NMZ?=
 =?us-ascii?Q?Mw4NLhU4QUjQonLA39y4jC0jwMC4xVub6ATD0hPRltJZOG2CnKtFOVGGMpKi?=
 =?us-ascii?Q?TQYsc2QemmLJoRdZLul0yASYPfqRUXXpWJ7t7uzcX1r1Z/Rx0LGUn/g8UcoH?=
 =?us-ascii?Q?ZQgds9Nj0YA9XzVmrYZ4H9rdTicVN+qKb+DhAZmTP6lEL+21UpgrjMg+WzI5?=
 =?us-ascii?Q?LHm/3siYMRDC9ohEUWvv+hsKoWbk+9dJ/P2Ot3R3w/by+yhDSxo4Z2uLbBvw?=
 =?us-ascii?Q?V+mRDfdG64Fch2arA6rYO7t6JBYPSGh788RtbmDNCfpEfQaQmlfl8WVthP+8?=
 =?us-ascii?Q?M4FUHkDf5Ei2wvZ3RugW6PkH/1VntobZq5PUqvnRcyjFYR2w7tcPrdsgfoAv?=
 =?us-ascii?Q?9TJgSDC8FJW/PG84Dras2kDDTDxiK2UAyDyk4ulJmOfrnIeixzPc1WDrI2OL?=
 =?us-ascii?Q?XCGNq/HFboxMbO1WLtLpqCnKwJI1mkNj57035N5a0GAcTHdHMLp/noaVSr53?=
 =?us-ascii?Q?t9bEsWUZAnSaIb4Hsugu8W3LrZm/It9+AzCddpMlpOzGQxcyLj+nFpJItr3J?=
 =?us-ascii?Q?Hui1qObC2SUaYZ48UzSSOA8O9XA3IxA4vyGEo+cF30ZmKSc9U3ajSt6lhU6B?=
 =?us-ascii?Q?X0RqUMiBQg+u2inkLV9MgSa+AGrf6h1JCYiB4PsWaKTpj0MFhkmOYNZdXsc/?=
 =?us-ascii?Q?JEAWRd9xaMhnx9DK1w6+RYGZL0l+3vdWZ2PM/BSQipYxAn0ZyVkhbF8tWP+G?=
 =?us-ascii?Q?0DF87Nbs8Ip4Y+CLQnBBrNJxcAaqQ+48Mpdm0tD2dWyGcym0v/I430iJxNlx?=
 =?us-ascii?Q?wfqe0/OP1bPx1hxY0lRtXSRwC2Hl3lQLHc99Tuy3kkXluFF1n88Z1/hBADaf?=
 =?us-ascii?Q?3wQLGFwiezOrJaEgUESyEp2f366GPEjEzhKGgcggo+v3C/pcBaI2wyH1Tbmg?=
 =?us-ascii?Q?GfINo9ytiw4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sG+jFjGK3IQWsEFJnHZdx8TCsFTGhry+wN2lqCXJGHHpNwmv7SaFgWSNWmCm?=
 =?us-ascii?Q?ZSIdfR01IJIgOKOUgUW0zuv08mVIcwHIRha03l2IH2ItQgdFZWbuhzi7noRI?=
 =?us-ascii?Q?c17BMfzVhpLdlIMCKlr9Pp4VQpj1BaO8Q7ouBsXSXw2Ntf0GwSTJXpC/Xnjv?=
 =?us-ascii?Q?YidpH4ajz6u3mnViZn6llFkD/QfrcDBNJe2NmxWzrFKPmEOz3dKQVPGxyiVh?=
 =?us-ascii?Q?Em94Q4XBWfEyt0sDZ73AQ7XHrSw1b6pfKenawN/DI3c0g3SCWMR8d6E0GI7D?=
 =?us-ascii?Q?IzoENwYCC1aQMIQZlywWtSMPRHqF9ouuclpNDpPmWNFkqjPTq2zg+Sf6hb7j?=
 =?us-ascii?Q?nTFcY8uqt4Q+jUHoTEqjc80XDYRgNRpTmQwhsywSLaygJ7b1npW2M/7g8vjY?=
 =?us-ascii?Q?pT7SpTnOvKN/4ajC2JapBfwSoI6G7/vSxudGSoCYVqdcAPxpsVOSbRGGiEcz?=
 =?us-ascii?Q?u59NCgQ8NWUoOJDR6oCo7CbDLUlWdnWcwG/ITUhO0MUZXZu4sw32FRb84qp1?=
 =?us-ascii?Q?qZ5XZ+tBpoeA4EidxzWAAklk0uwOs6lNYcq6HXWwLshYA2HZR1GRwQTyostO?=
 =?us-ascii?Q?7aGCM3I9MM4+zMrE+TDPtNVZkWUODCamOIptlOrbQsfTtVJPDmPbsOqykWiU?=
 =?us-ascii?Q?0d/ygMCrAYSp+C57ysxH5yII6D3UWM5K0w7CkFqKLs6bLtXFmFwDJ1Nyxp0B?=
 =?us-ascii?Q?Z655oPWCimbxUtrlmyNPQMMv/1uPV/rucuVCwx+7PuCyorL8ltq+RywhTU2X?=
 =?us-ascii?Q?CtRnKZUMr2811L0iL1cJ88VeTndGpRCi5f4kUNgciPcS6mdqLww5YXmduV29?=
 =?us-ascii?Q?OYxkVraK2Bkra3SmmPtbekGkULiTJ3JTcR7CwfgY/Jt8wwg4WXYJM8uTbaoR?=
 =?us-ascii?Q?dVcPaoUVjGFuP20ynWh8nXOzWYJG3MrYdSP82W1QpEjtm1v4zGxfbbSk+Xxz?=
 =?us-ascii?Q?uXNHbP+d9/K95lLsP/0xVW53GkoZ1WVj0hjT7WT5E2ByePcuKB5ZC7Fe8fqD?=
 =?us-ascii?Q?ppIsslF9/OiYgdmxz9d79HsVdkivKZcZ+2X+HqhIJqjn59AhB0gwMZN81MCc?=
 =?us-ascii?Q?3bzKFc9oERIUfRXSR+TlzrQXPiXvwxJtI+t3uPZE9PKmuTB7ZZs29gOr9Qfl?=
 =?us-ascii?Q?47Iw1jR5f91uODOOLFxkmZdbrcPgTp5H5OVeL6yhOngigjLA4+7g5lZcZVfF?=
 =?us-ascii?Q?jGgd0PPEcIDmjA4QFLJioVrVC71rqSIHUCXZlFvFcFMRNkIrhMoxVrMgNIRV?=
 =?us-ascii?Q?p/rnDrdcyh7dcRHVCwtTkrgZOWSVhBAsZd7oBk8afcRaLAwfd6O9/iaHLAMO?=
 =?us-ascii?Q?PBZFA+jy3by61L3tbSlyd3Nwp6is3k3bNp81eIU9w6Nc6T9+L+QkjcfxCPHG?=
 =?us-ascii?Q?mEp5eRUR5t5bd7vuG+Wda1e6l/adopRGbuJtWNs77bR/Wp+n2fh96VDixC2B?=
 =?us-ascii?Q?MX2V7OmA9URyOhRZ4+4UnGREOYmElVVrLf19D3lbyJxDROhxStukxf9xKsZb?=
 =?us-ascii?Q?jMVpRQFXwCfxz6j7TW8km42lkS3dcoDbvTwkoZa1M+LYRQda9SJ2ZsHw8LJ+?=
 =?us-ascii?Q?cw3hMOlfuyPsRX88m6XQrjrFktGqW0wk7b+pL1mf?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65c5af4a-aed3-4800-2542-08ddeafe04d8
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2025 15:24:48.2659
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R1Wh3iSnkAY+W+n3zw3bs9mJ8sDvOZlEQfBdg1CzwOydIIJQxAyz66Frt9fOWoLsU6gBNL4inXgkZ6H+31FOlg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4200

On Wed, Sep 03, 2025 at 05:15:18PM +0200, Juri Lelli wrote:
> On 03/09/25 17:10, Andrea Righi wrote:
> > On Wed, Sep 03, 2025 at 04:53:59PM +0200, Juri Lelli wrote:
> > > Hi,
> > > 
> > > On 03/09/25 11:33, Andrea Righi wrote:
> > > > From: Joel Fernandes <joelagnelf@nvidia.com>
> > > > 
> > > > Hotplugged CPUs coming online do an enqueue but are not a part of any
> > > > root domain containing cpu_active() CPUs. So in this case, don't mess
> > > > with accounting and we can retry later. Without this patch, we see
> > > > crashes with sched_ext selftest's hotplug test due to divide by zero.
> > > > 
> > > > Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
> > > > ---
> > > >  kernel/sched/deadline.c | 7 ++++++-
> > > >  1 file changed, 6 insertions(+), 1 deletion(-)
> > > > 
> > > > diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> > > > index 3c478a1b2890d..753e50b1e86fc 100644
> > > > --- a/kernel/sched/deadline.c
> > > > +++ b/kernel/sched/deadline.c
> > > > @@ -1689,7 +1689,12 @@ int dl_server_apply_params(struct sched_dl_entity *dl_se, u64 runtime, u64 perio
> > > >  	cpus = dl_bw_cpus(cpu);
> > > >  	cap = dl_bw_capacity(cpu);
> > > >  
> > > > -	if (__dl_overflow(dl_b, cap, old_bw, new_bw))
> > > > +	/*
> > > > +	 * Hotplugged CPUs coming online do an enqueue but are not a part of any
> > > > +	 * root domain containing cpu_active() CPUs. So in this case, don't mess
> > > > +	 * with accounting and we can retry later.
> > > > +	 */
> > > > +	if (!cpus || __dl_overflow(dl_b, cap, old_bw, new_bw))
> > > >  		return -EBUSY;
> > > >  
> > > >  	if (init) {
> > > 
> > > Yuri is proposing to ignore dl-servers bandwidth contribution from
> > > admission control (as they essentially operate on the remaining
> > > bandwidth portion not available to RT/DEADLINE tasks):
> > > 
> > > https://lore.kernel.org/lkml/20250903114448.664452-1-yurand2000@gmail.com/
> > > 
> > > His patch should make this patch not required. Would you be able and
> > > willing to test this assumption?
> > 
> > I'll run some tests with Yuri's patch applied and dropping this one (and we
> > may also need to drop "[PATCH 10/16] sched/deadline: Account ext server
> > bandwidth").
> 
> Please mind that Yuri's change is still under discussion! :))
> 
> I just wanted to mention it here as it might change how we account for
> dl-servers if we decide to go that way.

That's fine, I've already done a quick test. :)

It seems to work (more or less), meaning that in case of RT/sched_ext
contention the sched_ext tasks seem to get the right amount of CPU
bandwidth (5%), but the total_bw kselftest is quite broken and it's always
reporting a bw value of 0... in any case, even if we go this way there's no
major disruption apparently.

-Andrea

