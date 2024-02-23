Return-Path: <bpf+bounces-22594-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0C8E861716
	for <lists+bpf@lfdr.de>; Fri, 23 Feb 2024 17:09:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C241D1C24F2D
	for <lists+bpf@lfdr.de>; Fri, 23 Feb 2024 16:09:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 357E283A14;
	Fri, 23 Feb 2024 16:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YHlcJxL7"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CF1884A2B;
	Fri, 23 Feb 2024 16:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708704490; cv=fail; b=oSbTHOVXEZWBAS96sJMBBhca11YV+sBdtpkjg8E9WDGtSqTvvNsvRvWbluNFVZnfSs0nz8ZqJ9hnsGF5pJWRWT9daWwi49aCbQkbAyZqODT20AJ3nLPGAXBFS34KBXdL3dFyaID4cJiRWh7ElHTF5vF6X6lWFGmXDWeMIAsK6Fc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708704490; c=relaxed/simple;
	bh=8gAGmUiW6G4OkszLeLAt8it5gUY1jy34C1K9DWE4DD4=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=V3+R7dI45kF4AYxiGLS6BYm2dVUN2UPqzRFw78lgdbkeQgPhJwAcSPc5VMx1RMfDLIBK/0WJ7kEn2kfWNO1K0HU8bHc4LmUStqKW7wbqDKXPUB+x6/E8TI+rdYq5AoNO70A+wjd1kUACSU/LQeg1YV0e2kPgVIWw1JSsRYy8n1w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YHlcJxL7; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708704489; x=1740240489;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=8gAGmUiW6G4OkszLeLAt8it5gUY1jy34C1K9DWE4DD4=;
  b=YHlcJxL7atkRJLS6dm7nZ3Xk38dXxGHoKi015MDf5jdBk37AwDMjVY53
   RjB1siW2Qw0K/GzMqdm5tiJIUF1ztfpLQSmImAh6pQblcnscsthRDUEI1
   ReAaBV8imywJH31qM9qLMonw7HCzXL+0i1Jyh/GL3x/HdMSreXz1d/19e
   cTdSWhL4LNp5ya9+lluBHkPoELoUOz1XQHGsFRUetayAGQbN3YPc7LLSc
   IYEyJl++gbcQ/Ug93GZX2GGG1TYTAktSzpmlFyakInuJs679s8vwmkdmA
   Lu5hvCvSUCxs50rTnEgSUVuL+hcL8M+u4ULmdSrk1oEyCIRuEGcpDf01I
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10993"; a="6811349"
X-IronPort-AV: E=Sophos;i="6.06,180,1705392000"; 
   d="scan'208";a="6811349"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2024 08:08:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,180,1705392000"; 
   d="scan'208";a="5970471"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 Feb 2024 08:08:05 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 23 Feb 2024 08:08:05 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 23 Feb 2024 08:08:04 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 23 Feb 2024 08:08:04 -0800
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.41) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 23 Feb 2024 08:08:04 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z75kGDx86C55wYg6YHxnYo/E++PXEBQiemDKQ0yP8tmEg5yecUXdCGk1hv8LsWLXJ2Wg8pl6W2hTAiyITpvat2u92Jdk9UwQpnp09QQnT4qFuNr2b4fJCQYUlG0IBtdoJPrKrUo5Cm2up0ekoho0iEgrC+DptwxKxMfUG5kswImtsqYC8s/8ulESvdvVL6I1eWXVaSmx8M3JzpdbD8Bl0C/HOPa3ut4RVx4bwlzRXWXpQc1VFdduQKlRjACn0v+hmMsNZosJ4swYirWVdZDY0mH7OoN2szB0ovyuv81Qvxkpvi/3Xk0pLy/xtzsS4/mJxedEQ/9ww6qyzxmrYKIL8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9FAgM2UAhcMh+B/Sgoj4J/ch35fNqJ+wj+FcXAPtxzI=;
 b=J63nrzp07+tlrKgbHxXnDdRVUFXmtHuNbcGk6nxbS3ibnrpa/tyiHGaVyZDlyeMS9UAALug1i7q4oT4SzZDAVTjj5B+GMCyE2fLWRm3MEoocmLUK1lM7KnLRHTodD+hbbjRwtLksLZ5ym0cWvpj5Ti7dEo4ZRX/UiLtp5JfcC2p6ltNBeub8aURzfvoQQpOS1l5N/f0W9mBZw4lwNv7fu4DBNX4kx+voCkn91nyECXoFlA+yrRPNq6aqO3nwVK+X3cNhSmKqD6aju2v7dY8nHF9mN1Srb1o2/5KDPvrfZFBqIY7ifXm40qQeBsIKKA1fx0ff4nAAOQK/R7B0hkjw/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 LV3PR11MB8460.namprd11.prod.outlook.com (2603:10b6:408:1b4::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7339.10; Fri, 23 Feb 2024 16:07:56 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::ccab:b5f4:e200:ee47]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::ccab:b5f4:e200:ee47%6]) with mapi id 15.20.7339.009; Fri, 23 Feb 2024
 16:07:56 +0000
Date: Fri, 23 Feb 2024 17:07:47 +0100
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: Jamal Hadi Salim <jhs@mojatatu.com>, <netdev@vger.kernel.org>,
	<deb.chatterjee@intel.com>, <anjali.singhai@intel.com>,
	<namrata.limaye@intel.com>, <tom@sipanda.io>, <mleitner@redhat.com>,
	<Mahesh.Shirshyad@amd.com>, <Vipin.Jain@amd.com>, <tomasz.osinski@intel.com>,
	<jiri@resnulli.us>, <xiyou.wangcong@gmail.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <pabeni@redhat.com>, <vladbu@nvidia.com>,
	<horms@kernel.org>, <khalidm@nvidia.com>, <toke@redhat.com>,
	<mattyk@nvidia.com>, <daniel@iogearbox.net>, <bpf@vger.kernel.org>,
	<dan.daly@intel.com>, <andy.fingerhut@gmail.com>,
	<chris.sommers@keysight.com>, <pctammela@mojatatu.com>, <victor@mojatatu.com>
Subject: Re: [PATCH net-next v11 0/5] Introducing P4TC (series 1)
Message-ID: <ZdjC002yiviuAqh1@boxer>
References: <20240223131728.116717-1-jhs@mojatatu.com>
 <20240223073802.13d2d3d8@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240223073802.13d2d3d8@kernel.org>
X-ClientProxiedBy: DUZPR01CA0346.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b8::29) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|LV3PR11MB8460:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a92fced-87b6-40ab-ae1a-08dc348998cd
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iWsUFUE+oatMRlAPfAc3uVIwfzcyZblyRIIyb9YULo6YhBVZrbeSUYeVpF5MW7aB3m3DHD1gcIAqDLauvRFH0rcuQ5wBTPJDc/jvMqlpqrZs93FI6AdwQBwUx/7yXcCKiIYXmB9zQM3ux7pB1AingPYUUIsbBYFPrqP195h/lZk6dGi8TAQYuD3XJzKoLvaVdZLRHNAvrzmls02K3/rWxb/NEcmsiJiXOJVEDvzj4Rl42d8d7MpKV1Mcui+FWotP6ifg7yv3FZyrhY0djh6kzlnHPaHElAGTvxM5pfsMgmEDwo7suSjQgtVxDaGvd38T4BX4100dY6fvHs2Azdo+cME5RkMriPTfc2Zd7l6h6CCIpuVXxM+zK61B0clkuinlyfIJ1xfO9xEudcX6O4L3LAG6KFT1nVgjiSVGEd/NMWqog5LFrS4dJaxazJcfisBpzpwRiIWcTH7FVmSqI1FGWNSK6+BH+jRr090Xt33uoiGd7t8nE4C+ICq6luGQZU3aaifeHRv4Q82kowF5IoyyEh4d+PKV08MsZZWRttD5nPc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?E+909spxpj9zI5NdNwnopnd1AJpaeK2PGHRaSDvo+HG8FQuZuVmQILjdKB5L?=
 =?us-ascii?Q?9ilAio17Y5IqZdCvp8NoURh/N9M4qZ3xgTgd1/PaHBbfrD06lJiaw5tBdPoR?=
 =?us-ascii?Q?B7S9YOiZQq01Mop3XOTCkRom0gnsoI6gQ60dOMJ/0l27tx3Ovr6eJZQKo9d8?=
 =?us-ascii?Q?kvTym3qGocTr/qtg/l1/LKBT7IS1hRrceVYqddE32QDwpz95y8P2W0i8sA91?=
 =?us-ascii?Q?LXt14RAJfh+bdEsflffLUJpJEG92rOhK9Rk6FXxjeMpYg/uzzmNu51qoEHDS?=
 =?us-ascii?Q?6y4PbOaKRX0UqeWgXkeSHXlJw/Gqq9S/RM1spAvMwM3sFZ5098ZYHA+b7tKu?=
 =?us-ascii?Q?G9GVOzzSOkCauWPXESe/eYl6BwA/7arvDuvG8xAoDoivS/FtcSjFCPp3ZD7x?=
 =?us-ascii?Q?4TyysvZaO81iPU+SX08GbNBvI2Mg/vqQ5oM+BMN6W33iKmzVAtNNpnjhQFGa?=
 =?us-ascii?Q?AVhIe4YmQtaL/97vtPZiJHM4bo6idX5tW+T0mWmdf+7+U11VeBxeT/hQ1tgo?=
 =?us-ascii?Q?CRHWwKfONAK6HDHM0APnXMimB5yPc3G039FRcmyjj595qTfO10mSsoYWGfKW?=
 =?us-ascii?Q?ImxoQEFuCjD0u4bztrVa4tHys0xOiRn6JiBCNKsBVJDLllVBAMafVtwgtvim?=
 =?us-ascii?Q?GbpeAi8piTfrfnmTjvW/EJPqv0S4KphjnnYP3GS8OF9/FZvvc6pRe1RWTNJZ?=
 =?us-ascii?Q?AGTq/64ZXlwuaN1WTCdtsi5uj9I7JyvsS3KE4HCA4q5lifjE2firjaOhuT8v?=
 =?us-ascii?Q?J4qocA5EnnQ1QqbO6xTnpF8wYqAHvnSzB56OTvpzcHbjxX7AP2MAgR4by4yH?=
 =?us-ascii?Q?kcC8M4HHpY3itVLmC1BIEFeLVaiW8qhT8FCU6ESLBUBeoe2c+o1+I9J8iq78?=
 =?us-ascii?Q?sbLb8A4NnAKm1WtVOmHB7Sxk4IIFj5i9fxEl9uei9CkvXTp6nDKJD3kM1D2v?=
 =?us-ascii?Q?sNs6Uvwm5iknqmQaGMSUL1khCsDlhmtEgNsAjsQOtvEU9CAK7tjg73SierXM?=
 =?us-ascii?Q?215B4t7FPboGTT+GHtimonsOWZibmUILUf55JRX8KiuuuXPQTZ1q+8At7uKw?=
 =?us-ascii?Q?hAB9EtgvE60Idx50HU4JtLx8Tdm6vE8SuO+Pn9Mim49O+kFFkcu16ZWjgb54?=
 =?us-ascii?Q?KAmfzhD/Yb3Y36l/tj/wYR16zyLACNQgumzbB7xZJJbc0EwEjsnkQykkiUa/?=
 =?us-ascii?Q?D4NI/88X9RiZK+59p2FeWcx0Fa2rYAgE5E+x+HSQm/RMr7HwrAOVlJL/dVGN?=
 =?us-ascii?Q?RZnM+Ni4ZWCJyY4pw4Lw6AcUOfksQOVYWjTH+HubjlM/6GiZqEAkV1u7w7i0?=
 =?us-ascii?Q?quDuP3GgUts5TuV002yLsL7GLFKNBM/+ZG9jR/MAT3uX+b3+HXzypZM8aNVW?=
 =?us-ascii?Q?A8OpqLgJxzq3wuCZtv5v0Zj5KEYgRF4VAPRbyvoIw5by/e20lMPuqPSy+fuE?=
 =?us-ascii?Q?VMNw2slixo3eGTjuaEsma+cyKb/mNNkej0unaUEMSGxojyPBcsaA9eUsvZLy?=
 =?us-ascii?Q?7h7WENTcsIP9+Ni/NLXe+O7Cpj1Pi9i16mZNNQCRxNKOLQpI5a8GCu0durtx?=
 =?us-ascii?Q?Cd7PZ1QUwy75z1ERpq/IZgRK778kvjwv0ecS4RzrVd7RZRxuWHNSiLyhcKBK?=
 =?us-ascii?Q?HA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a92fced-87b6-40ab-ae1a-08dc348998cd
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2024 16:07:55.9937
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e/3uzMQIKGbP/XKqwtu52Z/OAN/Kcaw3SEwvr3UlpBeHXuQBhpidulaJuBCZxrLZlTaECbAAsgReTbqPSDrZSuFzKS0NUGEENBvOIYR68cE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR11MB8460
X-OriginatorOrg: intel.com

On Fri, Feb 23, 2024 at 07:38:02AM -0800, Jakub Kicinski wrote:
> On Fri, 23 Feb 2024 08:17:23 -0500 Jamal Hadi Salim wrote:
> > This is the first patchset of two. In this patch we are only submitting 5
> > patches which touch the general TC code given these are trivial. We will be
> > posting a second patchset which handles the P4 objects and associated infra
> > (which includes 10 patches that we have already been posting to hit the 15
> > limit).
> 
> Don't use the limit as a justification for questionable tactics :|
> If there's still BPF in it, it's not getting merged without BPF
> maintainers's acks. So we're going to merge these 5 and then what?
> 
> BTW the diffstat at the end of the commit message is from the full set.

...and it is followed by the current one, but that old scary diffstat
sould better go away ;)

> 

