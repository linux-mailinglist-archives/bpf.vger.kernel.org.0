Return-Path: <bpf+bounces-41105-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4E15992B5C
	for <lists+bpf@lfdr.de>; Mon,  7 Oct 2024 14:16:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 518BC285137
	for <lists+bpf@lfdr.de>; Mon,  7 Oct 2024 12:16:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB09A1D27A4;
	Mon,  7 Oct 2024 12:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KuB7COvW"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86DE11D2708;
	Mon,  7 Oct 2024 12:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728303385; cv=fail; b=IkejNuOFznjSd9AoZ4yjXAw04G8Y79HrJ34LexHxBV20vMm8l+hfFW1oLI8LMTJ3ZlrgtlQJWSietKR/5JFOMRaAZ9ZNAYZCrvvCWuuuDHNlo9MysuZE0QOqutzOif1P9oSyctbhWLHmc1/BOtJm4jqAyO24xmhMFA7vKRtAezs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728303385; c=relaxed/simple;
	bh=9CzAps/FN6J7dX9cphzeEVg5alGEk0ehWGA2BOU9PsU=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=MPExTcvPmK/mMzl3z+4WBG39tNEpgOaXroFCl0LoYcVSxGYiPHyi9UkLCEkti7n7Wwofk6l9/3Br95/WEfhWAm2vXen4twVKcuK/EZBU0Fjiu0N/d32GyUjT8nd15JMwOEn1R/SPjdVeS5UqI0wdeCm24K3O7nH/uDzeGqKyNcQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KuB7COvW; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728303384; x=1759839384;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=9CzAps/FN6J7dX9cphzeEVg5alGEk0ehWGA2BOU9PsU=;
  b=KuB7COvWwrK2kTAusEqrYXfUbwSK1qnpK5phrTtQPuE1C3r8Srz6kOGo
   MODW030ES777O6SELUGPOYQPeFIwpkFOTyHdULCpz43Ph3mYRqM9hVa8T
   IPyuNWyzLpJPc8HXNWXdK89jespj+yA1DpWkzVDHx3ZTcI/KzXGekqqeb
   H3RK3jRj+pHKioFtORGnp29SeILDUaGgsBwZUKClkukC02QfPIqqmewqX
   h3MZkRDMlpX16JMR5//se25EfJV6iVbnWIxW1zCeJgWgOz8yJ/ruG+luU
   e4mruSg/gkO1SYeggr9X9C9MnWDdMK/ABwDRDTZfAjbVZYQyzG4WUym7s
   w==;
X-CSE-ConnectionGUID: Ho/WDyVxR9CzfpXlH/ChKg==
X-CSE-MsgGUID: FmkBk8BRR+iqN7kH9Dj3XQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11217"; a="44914425"
X-IronPort-AV: E=Sophos;i="6.11,184,1725346800"; 
   d="scan'208";a="44914425"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2024 05:16:23 -0700
X-CSE-ConnectionGUID: OaBXaILWSx27n1SAHXdy+Q==
X-CSE-MsgGUID: NoCy1sfXRDaAYfUQBImgVg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,184,1725346800"; 
   d="scan'208";a="75704135"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 07 Oct 2024 05:16:23 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 7 Oct 2024 05:16:22 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 7 Oct 2024 05:16:22 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.43) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 7 Oct 2024 05:16:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uoa30EynVB45NoHepoelXrl2OGJDAa+XkGMjUFAKCV80ns4AezNFqw21i/AkbzXDuRqcxpbjIMiTEZWcBvtDW0KaAZEUlZzV3W7ufr9w5cAMQ7oSLrmPETK4SRFwdbmXRnuqMIrmhb1/Q03Xi/5gJMXksMWymetkAd8FyvuBc3w2kcNk9+e9Djlx2rreba7H7tTwJyS2kpVW2ggLERarPX1apt1KFGqBqSfEiJyiPprjWdZQ7lTsppqJPXtAw9fRv57vC7vCmUPdP7uo+oy5hkVBwMCxjKYQKV7SBDP93nvTcKtPiI54bJEQQnAT3tOD32pyvx5aRTrHV8QmtfPiuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uNVRFyRjTfJZmwzO8xOpla2VSof1ZPi1dXLcNSK60b4=;
 b=MuIJnWOIZVZBi2UQO7xGpV7M1RoQLp4M63b6sI/v7F5JEy44P+f8ArCUEOPwlmtM2NKehIAeY9lGkRT8FvCqf2isQY7K8s5+3LduanYHexJYXI4dDdfGZT53q1t74JfBMpIQqFsyrrqLUzLAcvbKknQuX2ZdubAYbQ486bAWfyW9rU6jyrvbI1pqsYOWIhGNyKHxYxaj0MW6k15Nu7BhFSYjoheRh0G4skPh0Do1XPZp2NrLOdev6TrQpJxwqGNvGvi2QyJokziU4RXEm2pyHY2Ahp/hCCz9W7zb3/cKe7CrCC4B7bJqye4K6sV2m7PqzKAdI6Ut/pfR0jCoAtr+JQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 SA3PR11MB7525.namprd11.prod.outlook.com (2603:10b6:806:31a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.22; Mon, 7 Oct
 2024 12:16:19 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca%4]) with mapi id 15.20.8026.020; Mon, 7 Oct 2024
 12:16:19 +0000
Date: Mon, 7 Oct 2024 14:16:14 +0200
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Daniel Borkmann <daniel@iogearbox.net>
CC: <bpf@vger.kernel.org>, <ast@kernel.org>, <andrii@kernel.org>,
	<netdev@vger.kernel.org>, <magnus.karlsson@intel.com>, <bjorn@kernel.org>
Subject: Re: [PATCH bpf-next 1/6] xsk: get rid of xdp_buff_xsk::xskb_list_node
Message-ID: <ZwPRDgPKss2s/CvB@boxer>
References: <20241002155441.253956-1-maciej.fijalkowski@intel.com>
 <20241002155441.253956-2-maciej.fijalkowski@intel.com>
 <51371534-5813-480f-b797-f073c31df5de@iogearbox.net>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <51371534-5813-480f-b797-f073c31df5de@iogearbox.net>
X-ClientProxiedBy: MI1P293CA0018.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:3::12) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|SA3PR11MB7525:EE_
X-MS-Office365-Filtering-Correlation-Id: 576d5f19-f6df-45f6-e219-08dce6c9d9b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Zg69bFLLFj/z+sXqY8O3M96YeKb6lwKzFOsRGzW/AtAFa3aU7ZkrgbA7tR9p?=
 =?us-ascii?Q?D9RkH0n6e3ket0ofNj93Ah0cOleeOnLejMY4+c1fUAokDkydspdRMHCYDrZN?=
 =?us-ascii?Q?jfqKPyXZ+/ee7/Lhb926fad/soye3bxPrdg60KtMY07bxeuAnK8IZycJJL5x?=
 =?us-ascii?Q?wXSjqccu/xAEchyFYeSCs34Zd7N5EJoI49m8H6WRRofX7N+ka558sfhGryl5?=
 =?us-ascii?Q?ZMSdIS5QbOMk5q8uJC/OOeabjXiXMYUU0DAg85gTAN38jGeUcET6DkWGopOR?=
 =?us-ascii?Q?kF2boteW0e8B9AwO0Qc5GvOtiI8JY/0rQYZEDIVbXJdyAnff22yabFnPNJEI?=
 =?us-ascii?Q?fn6JV5UYYsHigpBVCRkX/ifT8cyH9wx9UxjLJ5HwSD0S91/HSpoJRljLz629?=
 =?us-ascii?Q?LuR5HzbzmcwDAgmPn9Icqey9zS3wlUQLJPfzy5iq31fFZZT8JDx8HB2j4p+l?=
 =?us-ascii?Q?BAiHDSZZJX83ajOISPaUKMRHrf5guRHWt+sBcoqhzfi+ps4eH1fykfQMTlwv?=
 =?us-ascii?Q?2v5tkF/jYyOtdzjBi29mP0LmEjoFT5FKBHseexSNJBmsLY9Cct3b2lK0utcV?=
 =?us-ascii?Q?ZUGUkW43odhyvmgZAQaHurtVcjyrQQPJQ6b5ngcsqFCq69BWXQSfQNbCtVTp?=
 =?us-ascii?Q?Yud31R7TtHD4mQDvd4kRUL+C7VV9gVTywdPUYf0u9f1y0bGrngywSqqpJhyT?=
 =?us-ascii?Q?KakAt/M3shKQ7d8F7JQks29FlwiAUCts1OX1cQFSpFgyqIdQV1Mqt+5sDGp6?=
 =?us-ascii?Q?FAd6NKBwAbfz7tE40kgG28HDav2LGZEWp4DqismStmWImGPZ3MSgeUnTIswv?=
 =?us-ascii?Q?5Qh9bPJtvJ1uj4sfNgXNSBW0dPAzZDVMEGI97K95EaPzi+T/E1P8L9dAvunp?=
 =?us-ascii?Q?oImIxuWVTff8GBU3QlSKEoDe+NiFDaEp8Qw/+0hxv7qWUz0vmq43nHCu6r5m?=
 =?us-ascii?Q?0gukhOd8B2joBj+SF4sbTEd4bK7JZ6sXPjxjtKaf8eUd8UGYQrVVARARh4Ln?=
 =?us-ascii?Q?jJ2bvkRT+Zrifa1TR0ehiYUMMXHMXil74moakvVfCgQ3/xmle8VIE/9G0EX4?=
 =?us-ascii?Q?0jkt1ni9Xlq5BdUzGcZOAgOD3c8JgKkrzpU/Yh/BU2QG9RG8UmfHUsN1J8/u?=
 =?us-ascii?Q?bwvqTv6fFV6dbmAHOMZWV/IL+gqIqwgVe+9XuEdp8IjO8q72hfN+QmruxJ8A?=
 =?us-ascii?Q?aBXR4vJQT8jxgmfvTuhno7NsGYaGA2Bf5xE/L+fD6YPAYCnzDFXu33iAh4M?=
 =?us-ascii?Q?=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TbtaTBh5OPjtIkTPrlntqs/ONkZzoVs+kVgjXAUsgOQogoHkGLTgTDmsigXf?=
 =?us-ascii?Q?he551yYjA0fwnPcE4WRZo3VS6lxMgppZIU/SJT1HIG4C2vY+BRU3PDOXxhVI?=
 =?us-ascii?Q?DZELUqWD9PM0xctCtToGaIGgIFW/vA0b/6VpG8W1xEUd7a3L+8EAKsVVkZMT?=
 =?us-ascii?Q?BenrQfWt10+11zRn1jnppHjYexbBmP38oC7FxRZIoWoHa+QuqIpAgVTnWCwc?=
 =?us-ascii?Q?dbiBOh0QL+5nLMbLQJ+5XqU4l98YRb+b1V7X71Cz6ry4yfzYQGX2RsYF65fo?=
 =?us-ascii?Q?iwWxE4nF9HxCQ/408zEBfEaRg7daSSAHw9A4S5XjNhZCn8ysjIHTGdSK78Uy?=
 =?us-ascii?Q?QQGbcR/oOsqVI1gJPpDrgrQ8kX8ZT1sWcBtLjIePzcuFx4m2ZkYsv90m9f5L?=
 =?us-ascii?Q?8atgIG04OCKVPJcE0CKRBQ7YOnk3rnqR8565x+NG8Ri6SRJ/OKe/cGrZkABi?=
 =?us-ascii?Q?WvT7g6Po18N5z9q9igBQRICBu8CdPCiVxZm9wIw9rqwtlc2W60xgDuJoHDIk?=
 =?us-ascii?Q?WtVZbXRRt329bFDHt4Gigga/zka04U1Vc7tJtqkXJLNSmiOUI2xXwGTsR/th?=
 =?us-ascii?Q?MbePVu0nNYLsiZbETOAG32+fLnxRocarSHXowq1OCtWdEicgOX+UywCZdtQC?=
 =?us-ascii?Q?fILKjV+K+cds2hLGKB/by4Lni8QCZoQStVBOTpgC98G4bHLQxo1rp74qJ1Nm?=
 =?us-ascii?Q?Ero4YPdgQEg4lzI1Tb6prmOI+BuHQsYu9lhrqSFyj6oc6sycNgk73vjGnLKT?=
 =?us-ascii?Q?8WaZ6HwELKOhcnPl4SsYFMQpeg/DwhKwolRhc84/AT7KEm0zeOpd4MT1JGUf?=
 =?us-ascii?Q?IMNHYPeoPAdIrjjQpYRdblX8jKY+CHKOAfA7bOM6AGROyDd7O5RLBvrFHLGd?=
 =?us-ascii?Q?BHJsO/ROY6FuWoQQFBkM7l3xqeuD3FrFY8UZu0HcagvJ9l+NhHhSJxGHwNfo?=
 =?us-ascii?Q?E+cxgLGqEOtNNG8XAOKLGOwf2m4ClfMqeY/AD3oBButYzCoJB+dI7gMN9P8A?=
 =?us-ascii?Q?Kl4eHzxRkp58+5qlkbeWFZ8/dU6T6Vk3sVf05aFYCENkbzasAai0FW0bcW0d?=
 =?us-ascii?Q?+qCmSY5ZWGKliXm8Vqioinr7l4fo1wQ6NjxY94bs310uDsNhUkX2CjuFbdhe?=
 =?us-ascii?Q?QT6Q/nwk1JPFwBhYl1FnT71fl7J33jOAQw/W8yrQVRRIEZnB0PwXgMBSfrdE?=
 =?us-ascii?Q?I85vXyGLBoNZknAPsqkIHMM//+296hFfbEV2phUlKLEhKhwPi+5wF6AL769G?=
 =?us-ascii?Q?KWsNwaEWv2vO6Pjzv0eQazz8Z8EjV9oMud3zedChNGiw2RmfmJgHaGjfq81C?=
 =?us-ascii?Q?e0CLR/BD5+VvXBVK84rWB+cwwS1Bmz9q+EGCooRwl3I1a2/3pNyhjy+jZb3B?=
 =?us-ascii?Q?qCBKj/9ZsDk4xN+p90d+VonZ2U+dyNqtxQDBGrPFGTdni9cns+K8U5x6MvOf?=
 =?us-ascii?Q?bKcq016Kgz+1K3mJ+HHpu9UpPbO/FO95/HPgd2yBlKmUABDUKxxLpOZHGTDO?=
 =?us-ascii?Q?XprJc/K1kErWakGh1llVzlf9N5EWgBCB4Ab3f9ULeytq1OGeb5pT0//54WWv?=
 =?us-ascii?Q?+spOa2nnQJooLoRr6du3T2WXJRnvcDglOi9mYGcY/NzLucSA24/Bko7jo6t1?=
 =?us-ascii?Q?IQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 576d5f19-f6df-45f6-e219-08dce6c9d9b4
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2024 12:16:19.6503
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mNh3NEmKyP0TJmKAyZRbh6MoJ3RF/4TbEACMkcN6yUF7bo5DKCQo2/cAyAsESfFKa0qyOssn5GghaG7YO/XKS/nWPhxVK7GC/wevM8/THlc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7525
X-OriginatorOrg: intel.com

On Fri, Oct 04, 2024 at 02:08:38PM +0200, Daniel Borkmann wrote:
> On 10/2/24 5:54 PM, Maciej Fijalkowski wrote:
> > Let's bring xdp_buff_xsk back to occupying 2 cachelines by removing
> > xskb_list_node - for the purpose of gathering the xskb frags
> > free_list_node can be used, head of the list (xsk_buff_pool::xskb_list)
> > stays as-is, just reuse the node ptr.
> > 
> > It is safe to do as a single xdp_buff_xsk can never reside in two
> > pool's lists simultaneously.
> > 
> > Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> 
> Given you send v2 anyway, pls also double check the clang errors from netdev CI:
> https://netdev.bots.linux.dev/static/nipa/894909/13820003/build_clang/summary

Thanks, fixed in v2.

