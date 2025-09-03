Return-Path: <bpf+bounces-67351-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C351B42C0A
	for <lists+bpf@lfdr.de>; Wed,  3 Sep 2025 23:41:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7DBFD1B27B66
	for <lists+bpf@lfdr.de>; Wed,  3 Sep 2025 21:41:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6429A2EBB92;
	Wed,  3 Sep 2025 21:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="nkCSFcxj"
X-Original-To: bpf@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2080.outbound.protection.outlook.com [40.107.92.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CD342BF00D;
	Wed,  3 Sep 2025 21:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756935653; cv=fail; b=GyAMoC8l5RAxBXjI6LZSi65e1j4oxHQ42dhBbK/ZvfnThFtVRuRdXFKZvqm5OzE8u4eYKg6NXNYOJdc04yMl918iGzgELhmXX6B3nDAfWekimzkVWUrDWZbz8ZKdjparIT/tWJMJAJ2ERyC5ILe6g/I1p4PvTgP3NqTjEQy9F4E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756935653; c=relaxed/simple;
	bh=f8GhXaLbRvu7Lsz+YlMVBEfJvrJm+SUWC25F7JFJDHI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=tKNeVXQgCaj4iMVb7h0LPdFyABj3WaT2ggLIbj5PFIQWz6OdVuq3WP0/ZQg/zwkEBcGxI0L0SnvaMAUpoCt53lG8o1ivhv9DXIks6UUiPlOkmSnTa08kLfhSCFcmlpy03/ws4Cc05+ER/fqguBe4sA2boWBcT2qjWsrSGynzWIE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=nkCSFcxj; arc=fail smtp.client-ip=40.107.92.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H2k0AGCKYwPbOqo/KPQfLeAxLA85QRuzyb9tuB+p8YKV32WK1ek0SlVFou/zbfdpkv+/IsxBd7H9BhgU9oqBUK3uPnMrtTXcKKR9f71cp5ybbchT57+5DVmAY0o/0wjqOsabIj93rpUnuNz0XdBdgsgGdHoCn25TM3kMw88FKEJ6W0ejPRU17qTaQiwFt8fPBoxP4RTIyg92u48VNbHwPnurYVuI4vZM+lRG1uC5CdUi6SHCTwaxzL06WMi4lH+RVx7KNsIHjIme4/rCwKWYpygDlEzJWpTIBmBHLO/R0oXThzgeEFqMAKTEO1Udo3kc508f14+YO1eh9xbFAzLJrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+b7DrzjzKxssdzdzjv7vzZ7Lvlkswal6uNwXomp6Jb0=;
 b=o67OyQqGOUQc8VGxLtYB5jb5BMeFEmXGtkjBbjzfSu1msCLUg/JYBmI6mMkXWh3rqJbUrPcztD9CE4UbIEEjKhQ2vZJwdKCqFVMAbPtQ4+kNKeEq27RzXOdxsnG4ldQbXYSxQym/cr8qC6VykFQ18QgxQ8Bv4JPvpwZg1XFnQ3NR09cS2ugHb3AxZdyOq1zAYcYtkdI1xTfGhD4pyro0ObeLn8JalehdnlXtgQ8gWKTS7JHbVXlBzKsYxC/KSrnljGdyZV79UpO6eWkNO0pQTMVs5sCSBvoy6WKR8Fpuj5zDpJ0YYvOvvwS08KJbWLrn1CIgBsVlW2rs0Gm/ACg/Og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+b7DrzjzKxssdzdzjv7vzZ7Lvlkswal6uNwXomp6Jb0=;
 b=nkCSFcxjKF+uoG4dGgTwwE2mzsFWSWxzw4139thWM93ZjT/bFkGIBNGWfA6jnTQ4VnetV/ZtT3ZGq3Qg++lR/M+cHRnEJD2iedJ0kY43xVjoPwUrYNwS/ESndaRn+1xheLKW8Bj8c/PyAgCbDb0sYvQFLURuqzyjyQ9G4rA88zTecgl4E8AUTolt9BWSVQoA2/2OdcqenviVe+rt1CFjY78eFrf47YoZcdW5Rh582GeR4bzHguZY5Ay9SG9uLU0VkY8iQD05Ov/DsbDFPpe4x4Qb9v2egoExwKPNsFr/jklADhohuqP4M97fUO3UJU4KNAngtrnnmAnRnPbTTwKDVw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by MW6PR12MB9000.namprd12.prod.outlook.com (2603:10b6:303:24b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Wed, 3 Sep
 2025 21:40:49 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%5]) with mapi id 15.20.9073.026; Wed, 3 Sep 2025
 21:40:49 +0000
Date: Wed, 3 Sep 2025 23:40:46 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>, Shuah Khan <shuah@kernel.org>,
	sched-ext@lists.linux.dev, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/16] sched_ext: Exit early on hotplug events during
 attach
Message-ID: <aLi13oYFKMOe1GuD@gpd4>
References: <20250903095008.162049-1-arighi@nvidia.com>
 <20250903095008.162049-2-arighi@nvidia.com>
 <aLiaoEvjBfBsp-tR@slm.duckdns.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aLiaoEvjBfBsp-tR@slm.duckdns.org>
X-ClientProxiedBy: MI2P293CA0011.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:45::11) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|MW6PR12MB9000:EE_
X-MS-Office365-Filtering-Correlation-Id: c99602d2-c913-43ab-a3f3-08ddeb328c1b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vrSS67/GidWFxy9vzl9oaYJzoFugaQnLNh5EdTl5b5xIFbxkIdMorwFAEbY9?=
 =?us-ascii?Q?izi9E6VwwzSuoIWUgWJCcQSz4pe4NvQEG6AgSfOvVDQv3UcLOYo/MBMcdAuP?=
 =?us-ascii?Q?F7482ofxS01nfPZ+V0syynukLnVUxpISzSS2ssk45cGH4mGko8a6DlrJH9wT?=
 =?us-ascii?Q?xEWZbgbBAbttpbHR3gvdjUqH6Y/oMkSm8AWCwmgL2vFUJoqB8BMIOXtipY0i?=
 =?us-ascii?Q?q1quw3C2f0unCzFFwnWoYqf9+AgIacOgm8Y00uEkyZt9BNn0mU27eG8kFrAQ?=
 =?us-ascii?Q?xx9AvPDskOyCagL3NAdiMEtilHYp1XSkUJhZa5h9uAX/U7RtxTyWqdetKvrx?=
 =?us-ascii?Q?E1sPc9Uh9VYr2ykZ/u/BMGi1dgb+qNeAV48f/pnnB+827eM8+JO04GAlN6N4?=
 =?us-ascii?Q?tOphbDZHTJENifFrHs3etjfLBfgrW0qOIg2p4503+QtO2n4FVP2xwYZzNAYs?=
 =?us-ascii?Q?GW+sbqvyRbSpSGI4T333Ta/dT7elJmdOPBHEFi8hXCHaZF0LedjhSJdeLFA7?=
 =?us-ascii?Q?UmBTlbFQtJ1lm+T5qBPaF9OBloOPQ0lOhw6B0X0o0JRSPGhB33vOJHcWnGwi?=
 =?us-ascii?Q?maWv8iFbInbFkNIfmZi/q4weUQBy8ESc7blym+o0YHa06awOw9rAxWt+kBpm?=
 =?us-ascii?Q?fV/vdSpzBVZyp84uv/4oO8ZVH0tFhVAC6Wg9RBt2KS29Vh/lOc2WzeT+/RB0?=
 =?us-ascii?Q?3lWdJN2Fas6Yh1AwJlDyJ1XYu9Ey7/zvxoI28hHNHyDrpTVrmUbOXQGDS6bm?=
 =?us-ascii?Q?/vGOdhPlJ7hbQlPYHg7bUklZ0vxfz9gztWtEiGfqxuMhdorkpauCd1ibwzHh?=
 =?us-ascii?Q?hpLXcb234iWwQV7I5EGYrHEvM8XHJf3i0RUHo0QrpOG7N9xaiYVWQyfv1k2z?=
 =?us-ascii?Q?E4zB9hO/DoyE6B6wDF19BrziwSEl01ZQ8AmbmERt3/WKSe9fP3Lrjwg8wkL0?=
 =?us-ascii?Q?Ht25KSbb6P0RGT+zXj23fXzTY3ab35UDqXK90VDm/B+66nyWl50xr6zyKcRX?=
 =?us-ascii?Q?B6pSCZXDSNnmdXttdoze29CAKnP0aagmEg0xccP88RuCjRNAcbAzWAdhbTx9?=
 =?us-ascii?Q?aLQQsZc0sg7QlG6Y/ZQFUnxy7uQjlHf22sKd8Hc0KjPhlyFu7TPyXvHEGSCc?=
 =?us-ascii?Q?9PkQI6+9m+Qa2ucrLpobQl1IMxahojl4QrMst+VAmlGMYFdt070SRUl8YUD0?=
 =?us-ascii?Q?5xWcEF1bKhQWyip9HazJAS8Ba6k6CkBAPAkOWlC4xjfAXfslM5XAu6ETctIy?=
 =?us-ascii?Q?C/YV4FXrgowcZGG/QfG0ednjY2qDLNCWAAsx3I5C4YPu17PtObOj3BeS5lk9?=
 =?us-ascii?Q?5EtXfDwONQxXPZ6BBtVQwc38/YO0FmRHuXjFph6fpq8JoIaGccQbrXHEHIAL?=
 =?us-ascii?Q?fTgkqMio1kRZPIyzpCYjQm5I4Pj+gprTVNmw62QQl6pxKVVfs3/fZp9ZVGbS?=
 =?us-ascii?Q?Tdi+SiGrL0I=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DCs024BfSvTINsAiZJGFJL2tL0g/gEkf74ZpNqKSV02ld4KYO5Q0ihNOdfJL?=
 =?us-ascii?Q?e4bAendIfMiA/uimmpuhpWElSoyvh4uRZV/WuldqD20XAuilpFny0rQ8pnVC?=
 =?us-ascii?Q?k6kTkwXQ+V09GVT1JjdLJl1ACv8ONpM72F1SMNkQ2zueDkf+8Sprd4IqMRlL?=
 =?us-ascii?Q?tInobU643ygPIsxTSISH2RFZdWI1Qwfg17mYD0B2R06WniaP10tuqqsaB2nf?=
 =?us-ascii?Q?ZRl+5T8kOzNYVS6WzQuM3x5tLCsSGEp6pXFN50n7eIJRNW2NM0ZyVxxjzUWm?=
 =?us-ascii?Q?H3J5Pc6mhAtArdDC4EDp46wQyd33ShOPwv5itJF93pO+373qxgnXxPGTyu4R?=
 =?us-ascii?Q?Gb9BsUZME1L0ecvijYyfTimtTi169MAWKfTD3WNECq5wtj9BmmpQ/vbmzJoq?=
 =?us-ascii?Q?a0Ybz/6FGHwj2glWSe1Tjs/907vxh442zmR6teTECCojUXpg5GJCWSrVNkYp?=
 =?us-ascii?Q?kMOJoWvrlkyz2vRFDXPAWIz9Xvv5taSgFUQmdOY3LXLjqrvRd0i5cVjXahem?=
 =?us-ascii?Q?0uCI3rFgbW1eXyNcDRQUpqMuzh0n7cwpGwHqG4omkdxbjbw4WRMBEEpsPCYD?=
 =?us-ascii?Q?9EY/D1zcxz5VC1Vk6qOVDiNpyjN/LsTYKHiJwEwObFdXNPdj5bxiLJWT1g0v?=
 =?us-ascii?Q?fhEcLCShsr8JwN6NbLCJW4lThMR2/mjVwOM1J+iH4JT9sBGPJfu5ytsDi1XT?=
 =?us-ascii?Q?QeMMQIZ7xn1jYdC+MfAkJSo+ZdFFmfM5itumOgFZ91qy2l+oPoRzVLGaP7I2?=
 =?us-ascii?Q?SWDsXIp5bYLGbqjEL55MeS04JswKec5bqPkHeqd31KYns7KMlvPJOFz4aw/d?=
 =?us-ascii?Q?otaEqbIJjLOKflCvKLj7kZRdCH2Iq3HbmLSr7L2UyBsV6vs0NxKkV4skFvZa?=
 =?us-ascii?Q?ZKbWdL2lW0NxoGwH3lTf+QgMpPnIeiDorC/i9UGMGyxmsxtaZYQJoDiwShHn?=
 =?us-ascii?Q?f/zAC31w283NvMYEVSoJtLqu7Zyds3EHIP5+ry3DJ+L8DJry6cgQtKio2u+o?=
 =?us-ascii?Q?WlNoS0jA6hGzegF4JmFpUmpHG4ymYvxsaSG7+NRpVnL+zPCUFvi59pCbKkoF?=
 =?us-ascii?Q?RE0vajbZEgzAkhHhrNiKKWMMj+u+C5pb7GpKWSDjWRCBM4e8YzegjK6iCjoR?=
 =?us-ascii?Q?iZub7wxs79YSM/1+5yDU/4usfVT2UbRIK5O+L89KHDMvewPsNs5I4x2xNOhe?=
 =?us-ascii?Q?v6xR+Pek1mXXEVJ2P0y/AmQ6djvi+Ld0V8198z/zJSy3UGsz5PNk1v+0x3n3?=
 =?us-ascii?Q?yEniXQjY4FDthSezdc1UeI4BQhUbbdx09dp5zWtPqdqPdWUVs+9vxNdaVg/t?=
 =?us-ascii?Q?LL5yJziI2viojWkcAhQf3QkV5+RzAcxl6GdjikkdyM186EOvckwJAEw3fCuy?=
 =?us-ascii?Q?JSn4VeIobLl3oQh85Y6HUe9z/y9Gm0nVPQYlidh21BK22Sh4NZrMYXm+N4b+?=
 =?us-ascii?Q?27HklTJDYJ4znlc0pbjVyR9WXQJF9YP8LEMP/4yuh+hjYFOd+EmKzK5D8Sr+?=
 =?us-ascii?Q?8/jNFE/c2ixaw4qT95CNvLSYmMu2OpjeTKF4au5/071EFdyYd+897greYtTR?=
 =?us-ascii?Q?8/pIGm2NUzSaT/AydXSbgr/BAR9SoGLHRg3kl782?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c99602d2-c913-43ab-a3f3-08ddeb328c1b
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2025 21:40:48.9447
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O8FISIYy+qeC9tPQ4tqNREGK0dSBLVgzVDiWqP12ZqeuRSEHruw6HZkFkbeqRqeWGyMEVgOQnKFkl9sZQ6c5dQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB9000

On Wed, Sep 03, 2025 at 09:44:32AM -1000, Tejun Heo wrote:
> Hello,
> 
> On Wed, Sep 03, 2025 at 11:33:27AM +0200, Andrea Righi wrote:
> >  static int validate_ops(struct scx_sched *sch, const struct sched_ext_ops *ops)
> > @@ -5627,11 +5630,15 @@ static int scx_enable(struct sched_ext_ops *ops, struct bpf_link *link)
> >  		if (((void (**)(void))ops)[i])
> >  			set_bit(i, sch->has_op);
> >  
> > -	check_hotplug_seq(sch, ops);
> > -	scx_idle_update_selcpu_topology(ops);
> > +	ret = check_hotplug_seq(sch, ops);
> > +	if (!ret)
> > +		scx_idle_update_selcpu_topology(ops);
> >  
> >  	cpus_read_unlock();
> >  
> > +	if (ret)
> > +		goto err_disable;
> 
> The double testing is a bit jarring. Maybe just add cpus_read_unlock() in
> the error block so that error return can take place right after
> check_hotplug_seq()? Alternatively, create a new error jump target - e.g.
> err_disable_unlock_cpus and share it between here and the init failure path?

Makes sense, I'll adjust this in the next version.

Actually, this patch doesn't necessarily need to be part of this series,
I'll probably submit it separately.

Thanks,
-Andrea

