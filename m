Return-Path: <bpf+bounces-69441-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08504B96A1A
	for <lists+bpf@lfdr.de>; Tue, 23 Sep 2025 17:43:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFBAB324FAE
	for <lists+bpf@lfdr.de>; Tue, 23 Sep 2025 15:43:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68AE3255F31;
	Tue, 23 Sep 2025 15:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dpw8qN6P"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 360AA1DC9B1;
	Tue, 23 Sep 2025 15:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758642229; cv=fail; b=OXsazF2Si4X1AT0xnYpF9OwrUdzYrH4Nv/6myw3n0Q2nMf4GYXQ0iT0SGzEn/7FjZiFEFxZYL3B1P7uB9B/MjqLKMXRFS14vlLYLTTEEjDeU48IhVnMflRFgV8UZHz3+ikX3ECgvrbxK9zeEMicfapReD74SpcP5DPj1phVzaVQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758642229; c=relaxed/simple;
	bh=7UkA/RRgnVx8VEqM9fyRLlusGmtExym5qEQ7t3AsSBU=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=cDO/hTb1wlI/wi7iFd6BmuSHG8FlpODOUIy/wY/9rQAq2rxx7V8E4/GvfUDA7FxhdR4LoeH2bK3mFm31UB5miwaAE+sXXp4148bR838jFYJKp1PbRqkbf3Pcc5bAZkY9yMsQMT/f9NDFjlmGL44qiGIbvIqGlNpPDNWJ00CaVnY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dpw8qN6P; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758642229; x=1790178229;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=7UkA/RRgnVx8VEqM9fyRLlusGmtExym5qEQ7t3AsSBU=;
  b=dpw8qN6PQ13F2A6SpFpSKygCi3tX7PIKffMSz/jpDaTnYT8pbPZaYpPE
   IPpJ/jIvv4ovCHTje8jlJTA+tI2RPpCi6QTpQkZU/b8sg1STKRLw2sl64
   DD7D4ozkLWPrdcXq+YYcRB/9uAFNrd7gMhz2WBQTNhPkrlG01gqnWr06L
   B5M1S/f1gukrFWAzqUtWVatd+3cdkAt5pC997CMHmuqScxfifPUptRRwE
   oAc+iUU73WHaGQxPigprl+KAKcE85ANvFWMVGpWlZEqEllCB8I0kVuF6y
   Bknq50c7qLk4UU0PYzTsZ1hOTVJzynrrUDDsL/6uvoQy0H+TzqJyvDA2M
   Q==;
X-CSE-ConnectionGUID: K45Alk7vQW6MvfC6+LI/BQ==
X-CSE-MsgGUID: HtE+mgJ3TuSib1dtAGuDLA==
X-IronPort-AV: E=McAfee;i="6800,10657,11561"; a="60816808"
X-IronPort-AV: E=Sophos;i="6.18,288,1751266800"; 
   d="scan'208";a="60816808"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2025 08:43:48 -0700
X-CSE-ConnectionGUID: E++qsPkoTnS+8RNE76aXow==
X-CSE-MsgGUID: 8YJ9r38xThyIn7heCRRAlg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,288,1751266800"; 
   d="scan'208";a="176740332"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2025 08:43:47 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 23 Sep 2025 08:43:46 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Tue, 23 Sep 2025 08:43:46 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.63)
 by edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 23 Sep 2025 08:43:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LOamGkCQwTKVt1E8OUWTTlZ0x+TWg+MuL15vip8RQRcLFK6b0LGYGzzRQ9XZO0PT+IEBH01TJKLO6xI4JsDFyEU6vRSOSJ6x6akciOGCGtLCwoXQAfATwZCfb2hVSl1wJiN4orc+TZQ1rHHYRUazV2RsNhy27O7nkQamVxCt4+cLJqSek82m4698Bo8DZCXbydzjSEZfpkq7mKRR0Uxvd36jKGQ9vvPT+rjqwFUgaWkTVA0er7TBl2PuLR9mpx+rWaGqDfmCp9dFvdAxhtkhWo+sLzyOip/ljo4kL0vqTICV/G6Wia9p/bXbKpLxlgu1Alvr8eEgBZGgLxZYpMXVgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U/nfE+U4hyoorGWTSR6+TPnO5NfUFh2uMGueLaqs6K4=;
 b=CKlCWT8ptQypKwv++Lw8w0wUjtqislq+nQ4ytt+EhHcV7mGcfCSiN0G3TCpvFWqi3cUZpUVCZmjysLAGqvZxpE1SRXWO5drRdLAePEa9eiPRu4B9cm+P4vGRrQgapQdA2egeEP79xmC6TV5aDgT2FdIVbLMiPAWbr7JuQWBN7CsxJfPnUwGdC4ZH5uLPMtt8/9ZGuwcg0KcIfLw7pcAlpoetF+kXGJTdVwcwL/9c7rHNU2BoPZNrVMby03uOo+bM1yO8aYDmZBIl5iambbNGoGFS1DllMtt1V7HVVWGzDY7zDNM5ugCNnIYkizl/zhmC78TeEVQB0dCWEFfJdsK4nA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 IA1PR11MB7774.namprd11.prod.outlook.com (2603:10b6:208:3f2::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.19; Tue, 23 Sep
 2025 15:43:40 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca%4]) with mapi id 15.20.9137.018; Tue, 23 Sep 2025
 15:43:40 +0000
Date: Tue, 23 Sep 2025 17:43:32 +0200
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Stanislav Fomichev <stfomichev@gmail.com>
CC: <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
	<andrii@kernel.org>, <netdev@vger.kernel.org>, <magnus.karlsson@intel.com>,
	<kerneljasonxing@gmail.com>
Subject: Re: [PATCH bpf-next 1/3] xsk: avoid overwriting skb fields for
 multi-buffer traffic
Message-ID: <aNLAJJoWLibivhXR@boxer>
References: <20250922152600.2455136-1-maciej.fijalkowski@intel.com>
 <20250922152600.2455136-2-maciej.fijalkowski@intel.com>
 <aNGGjMFT_bsByxcZ@mini-arch>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <aNGGjMFT_bsByxcZ@mini-arch>
X-ClientProxiedBy: TLZP290CA0009.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:9::18) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|IA1PR11MB7774:EE_
X-MS-Office365-Filtering-Correlation-Id: 837fbbf5-5c0f-498c-2038-08ddfab7f817
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?YSdSJckgeKhzfRXnEDCe8EU74Tn6Z6vKrnO0w70u3gGb/sHUIhrJYegD3qVp?=
 =?us-ascii?Q?edxI/usC1W0cnjd9j3qyexXxPyGcuIM9dyPcCJUb+pNqz38pnMNJTFq5QKc4?=
 =?us-ascii?Q?AewURgzZ8MvMdiTIbjoreQwrRkiu0tINMZ1PjJX11fMcsH4q2E8z2q0YMnm3?=
 =?us-ascii?Q?+iXupKBnsIg9RB16rtcyEgBlnyAEQ3Supa47EbqwByb1ku5ymACKzjM+WmzL?=
 =?us-ascii?Q?11MVJ5OJf424F8u2Son6V7F4eEwQRiuYhVvVXWEysvAFrzkRpH6qxcHTyGvC?=
 =?us-ascii?Q?U/GsoTA1FJ0/8LNcd2H0/6bk0O7b+lRL90ZIRbMaJfBvAUTVr9E/JKdCRlvE?=
 =?us-ascii?Q?r5cIWpczXNG9QjgtY2PTcfPC79WGlLmb21wUUaEPsR9UY+hqugD4jZTmUYj/?=
 =?us-ascii?Q?KTjgYf8FhAx8Xh0LIiPlYkSy9XkdhrZ70n38q/o09Z4HhmbtiFI5QWMoMcsY?=
 =?us-ascii?Q?NCKoPmi9AcUmpC83w60hipBYlnPbJ8gmNhw7HO/vS+xclHAuSV9NnIQXxzsT?=
 =?us-ascii?Q?IfhaIlPo7BCNOH+ChqjT7anh/7uicTBj+ZYMP1ufK1iMiLNawYpdwe2vF83p?=
 =?us-ascii?Q?nLunnX0U9szoxYdMhCOGZvvWDj8d5s6QAKbocchFTKdAos0BWcuuYOOM9U9v?=
 =?us-ascii?Q?m3D56VdFf5WYKxTzoM/xGSHIzu649ajmy4uAud8F0Ss/h6qroZ15fCc1+L48?=
 =?us-ascii?Q?+eahKzFri1a76Fs2hDAJip6/tCfN37kF26qiZMb2s9t8T5ck6LVj9c0HssmU?=
 =?us-ascii?Q?7dmzsWZG2M60O37biCLlqJKjT2ST97rRbgrkn3TRqGLjgEtNcGC/t+Sz+KNL?=
 =?us-ascii?Q?gGPAfIX9md3UnKYVtG1drvK6/Ip7UKmTa/HMJeqPbjC0uoDR4YwQvGCOZJYN?=
 =?us-ascii?Q?4XtzAYhW1iIlAl4vHfaNSreeZbKpjJX3/ll4pTnHjTkKA+1GUND+moioc5TX?=
 =?us-ascii?Q?xod5I3Spq3gGJmPMHnbErxQqpEtXIEgCEQLW3CSRYWGuKUN+lx7p+f9R5P9x?=
 =?us-ascii?Q?Z0yg1lnECZccmAN8614FqcqE3FsxeoyQycZujRmKJZo+P6fI377JiQz8Vnqg?=
 =?us-ascii?Q?ITj9ehYCpQTo0mC/0biv7yHIHjvemkJw5CyK8tbG0+tHlKcXUy+amvL4KJe4?=
 =?us-ascii?Q?l7S4jXksqs35GoFwSPjkxaODLF7UvcDns/2zU7mAuZqmGjRs/0PZvUBtVS01?=
 =?us-ascii?Q?myqcdqkjXI5kocstZC5ZCIcH5iKGYShkzrIEoAxDtpkvaGXhQ5TJQhZYNB52?=
 =?us-ascii?Q?j2NI2iuIDiKeSCzMz7vFBRlEqE3K57m0hDGz/q3L6b1/xmSiBOj4ZBtV9sZe?=
 =?us-ascii?Q?1YkF9xAGe8SgYuO2DnEleJCKOVzWAZ6xwT2jH7gELdcDXHqhA15WC0Thy7vm?=
 =?us-ascii?Q?b8x7PLggxueD5QRbD/xIBFf1PAxNgY8Qlu7/P3dcN8mwuOJLfDgji7A3/ePQ?=
 =?us-ascii?Q?V1A4+MR43Z0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YM/3axmXPBC63IPLRE6C+t2CnQtlWHNpsc1Dy7yer5n5VLXVnDkDj7ys8qKC?=
 =?us-ascii?Q?qKkT5ynvh8dVhgJRH+drXBNn4Nqs9zMSsFYlSkcI+kg9CJg/4tgIrqBZb0sp?=
 =?us-ascii?Q?GSMLCZn5lTq/Zwpsvl77cwnns/DLeH9gKLOxnjIhEhudRd5UoTO14p7Q/Wyy?=
 =?us-ascii?Q?HcU7Ryse51kWcAWZilo/5j1bRe6BkTv09M0U/4kgYRIf3n91Ub3DKaCiXDUj?=
 =?us-ascii?Q?aHZo3pwYjGLdZ/Kuzo6IP56fhyL925hpqsRQtv4sjyRGjRgxharQ7cvlxrW4?=
 =?us-ascii?Q?+vjPOaQwL9svduK0Z7wUQQgxGyfLCuGOIy8SSeLQbXlT596eu4a7p6m/+3Oc?=
 =?us-ascii?Q?t3Igpp24nIWDNEScXq6jNs5p3Q0tpKq9CfPIi4B8dSODbVAj7rIW4znCrmYd?=
 =?us-ascii?Q?1YzEzoLbQKc5IbDcnGwonoQWTWgMyulQ9GBN0lwTsrHdSvspG5KfltBrxx0V?=
 =?us-ascii?Q?6y14TMqauT0TfAYKeA0U4F6kOmbHXAuZm9CJsdJ89FLslRROILy8qyd3pYP9?=
 =?us-ascii?Q?xKYV/YRZbu0/l7vEZmBctSE3JwpFIFRlo6oa6rFXr5mUQq1fRTdnthMNFW8e?=
 =?us-ascii?Q?huKs4Bywb11SW74vi5v2V7wmJXpHsByh8Ne22pX2BJObUTXyWtn48BmZlVHg?=
 =?us-ascii?Q?gH/PdYhXzb3rozQP4G4fCJi6DuFz51TO38fo7LThC4HDdjsZ+1MoBIlJxQfY?=
 =?us-ascii?Q?PRlk0MmBR/1ysOLuvWAQyZh4dK4ZLAA80RVfpbcwVfXHVwpnKTSeYTk9iSOz?=
 =?us-ascii?Q?AUEhmT1cqb889DCitvhyZUC5R3nFvnMSK+HA4QxFjeAv8Pj6yJlT3u23SAQs?=
 =?us-ascii?Q?u6Hgn2ZNyZmeq+nXtoc1Kl8M6LT9gbPTpKBSpNOu0q4F3zJAGuyqWUjjgCVU?=
 =?us-ascii?Q?Egc5hFmIBP1rEsisyHijZVemXwHPyv4O83Qy84TY1JkZDh/eHff/APhG9XF7?=
 =?us-ascii?Q?eYQ1aYt+PkN4mvZkgX30TJQniBEfoaYmXHjim1AgzMsPtolcahZBQacaPQxF?=
 =?us-ascii?Q?BV6wWbVjHwqEeyZM3loeMyyj3wdNlSsCGrqTryfR1x6XoKyjbMQI9zhOysts?=
 =?us-ascii?Q?JMGUNqwh5Hi+mP2aGH6wJbn8LX5Q7con5hFWDLJGlFQ57Aq/THLaNjhKGVbT?=
 =?us-ascii?Q?0J0SwqtRQhDMcQ2Y2HlcKZOgx2X/u/MurEMBmMeOB9cAbevuHVxwj6MnObwb?=
 =?us-ascii?Q?NeHe4wyWAvtLBZGxy8MuzeLVS8ictewbM8aueLDP1AkGkxRaHOhmmeVrclpr?=
 =?us-ascii?Q?sdUYbg+nVKUdVFAJULCI1WFJJc2L5nVCcjVSVaYHeTcanIFd0BDnUhK8ZtuF?=
 =?us-ascii?Q?o5bPc7eW63TQjoJzkgW9wpigS9JXCd9A6bZhdSVtaWrrUoQ7T1WZ1gLB7P4K?=
 =?us-ascii?Q?UWxLc4yERBx1dsbZiyaBibQSE4HmeW99KpEiQ2v2357kC5+zzAsDCOSbrRsV?=
 =?us-ascii?Q?u4fBpWkOVFKzj5ThceMEstuxXp5dRiUWdCQ/1MY8sYiUGJwDLeWGNAoDkZpx?=
 =?us-ascii?Q?vDB9i+Rahh/mdpBDMtXr2/x73cwuEEtArDspORY3DJ8qNCSbv+Q4usssMmvc?=
 =?us-ascii?Q?RyiFIB8gjsOe+8cZcihfFLr13uqLxNDBCpEYVyJXX2vvECCplwDxULuipm/D?=
 =?us-ascii?Q?ig=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 837fbbf5-5c0f-498c-2038-08ddfab7f817
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2025 15:43:40.6273
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fhI4HUb+DHf+aojdr64YzDChUVV7W1XHitF7NqS1e0zBR3j7/MHyIIEEgbdf7ilq6XiEBkRq/upSP6KaN8hKqupHg9pzkcF8idnB3pI5BVE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7774
X-OriginatorOrg: intel.com

On Mon, Sep 22, 2025 at 10:25:32AM -0700, Stanislav Fomichev wrote:
> On 09/22, Maciej Fijalkowski wrote:
> > We are unnecessarily setting a bunch of skb fields per each processed
> > descriptor, which is redundant for fragmented frames.
> > 
> > Let us set these respective members for first fragment only.
> > 
> > Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> > ---
> >  net/xdp/xsk.c | 10 +++++-----
> >  1 file changed, 5 insertions(+), 5 deletions(-)
> > 
> > diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> > index 72e34bd2d925..72194f0a3fc0 100644
> > --- a/net/xdp/xsk.c
> > +++ b/net/xdp/xsk.c
> > @@ -758,6 +758,10 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
> >  				goto free_err;
> >  
> >  			xsk_set_destructor_arg(skb, desc->addr);
> > +			skb->dev = dev;
> > +			skb->priority = READ_ONCE(xs->sk.sk_priority);
> > +			skb->mark = READ_ONCE(xs->sk.sk_mark);
> > +			skb->destructor = xsk_destruct_skb;
> >  		} else {
> >  			int nr_frags = skb_shinfo(skb)->nr_frags;
> >  			struct xsk_addr_node *xsk_addr;
> > @@ -826,14 +830,10 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
> >  
> >  			if (meta->flags & XDP_TXMD_FLAGS_LAUNCH_TIME)
> >  				skb->skb_mstamp_ns = meta->request.launch_time;
> > +			xsk_tx_metadata_to_compl(meta, &skb_shinfo(skb)->xsk_meta);
> >  		}
> >  	}
> >  
> > -	skb->dev = dev;
> > -	skb->priority = READ_ONCE(xs->sk.sk_priority);
> > -	skb->mark = READ_ONCE(xs->sk.sk_mark);
> > -	skb->destructor = xsk_destruct_skb;
> > -	xsk_tx_metadata_to_compl(meta, &skb_shinfo(skb)->xsk_meta);
> >  	xsk_inc_num_desc(skb);
> 
> What about IFF_TX_SKB_NO_LINEAR case? I'm not super familiar with
> it, but I don't see priority/mark being set over there after this change.

The thing is I tricked myself with running xskxceiver against the changes
and not seeing issues :< so IFF_TX_SKB_NO_LINEAR case needs a test
coverage pretty badly I'd say...

