Return-Path: <bpf+bounces-37162-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E5CAA951719
	for <lists+bpf@lfdr.de>; Wed, 14 Aug 2024 10:56:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5BDED1F2477E
	for <lists+bpf@lfdr.de>; Wed, 14 Aug 2024 08:56:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FCAE143748;
	Wed, 14 Aug 2024 08:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZsGmDWK+"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12ED455E53;
	Wed, 14 Aug 2024 08:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723625763; cv=fail; b=Jvq2M3H3WDGz4Z+QYp7DT68pYrkMKCJjVNE1WVNFllEmpk4tPSqT6v5T2ET6fAx20Oy4iM5QrqaFPO/Vuwq1ocPzc+GSEHa6gS+E+22rCYjKLwW+kB0Nptqfcw0IfAdQVPDyXfSSKJK6c/l+0JJYXqLgSDdl56x0YDp930qtVJ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723625763; c=relaxed/simple;
	bh=U9mn2+Lb8eoUaLXj4//bJMOd0bYjGWNwU3XlvAc6MMw=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=nr6tz24vlvtaT+4FqX+TBmGAZRn+34+ruBpD3WOoX5Sa+BezSWcRFZy5fO3pjGzygfuLFr8xJn4u9abQ2siepu/bCNxvyBF1yoSC6Xm72qS98neCfNDCmh3Yyv60ps5vZ6qD8oKZg83Edrdh8osXk1VB4kW6j6pwxLMi7peDDFU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZsGmDWK+; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723625762; x=1755161762;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=U9mn2+Lb8eoUaLXj4//bJMOd0bYjGWNwU3XlvAc6MMw=;
  b=ZsGmDWK+4eAu8wP8Su+SjerIiB6b5MZzXkXe31w5TQSnnmTlYQ39eNDr
   17nQDpql7YkaaFYW9ifU70Yy9TGaehyo96tVqkQpbEmVszwodKeE/TIWE
   oFLJFqsX3aTC8R7mYl88UGcSGPckbMRtn6KMEJ52TDAidBc2KmJDKZw1s
   3cvyZLrLDMYTiyeJNxn020wQ5WEuoaX8k+VCwFwJ2xtOco/A2hJkMqaaD
   O9kJqFwWq47VAvkfHuewBVArrA08CMT3aczS4BgonEY0Is41GIu624/aa
   2AqB+VujGifmEaNBDl1+6WuZ5tYmGOwk9/ZkgrFA/EmIEYkUfUFo9kRvZ
   w==;
X-CSE-ConnectionGUID: Q8o4UaG/QXSE1g01iVNZPA==
X-CSE-MsgGUID: mdmTOY1SQASsc1pKy+d6Zg==
X-IronPort-AV: E=McAfee;i="6700,10204,11163"; a="21987890"
X-IronPort-AV: E=Sophos;i="6.09,288,1716274800"; 
   d="scan'208";a="21987890"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2024 01:56:02 -0700
X-CSE-ConnectionGUID: wP3nuPJHQPaQHCG3DqkMeg==
X-CSE-MsgGUID: NEXjGaUIQPe5E5tUHgZl2g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,288,1716274800"; 
   d="scan'208";a="58941722"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Aug 2024 01:56:02 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 14 Aug 2024 01:56:00 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 14 Aug 2024 01:56:00 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.42) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 14 Aug 2024 01:56:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B0Od4Ivzoi+1KtHm8YbbRYCs/hrLwyIR0M22H7O2d7SPkIpubBIcO7xdge1iRiRQ2qynHjcBkgcF1BF7EARz/KXHewdgRmfzQGxzpql2Rsiq0nrJ4os7bqLySLlKIBQa9N/2oC9Ub4OdnC32oamtpfDXttG5THSjAX0xyVR7z8e3S5WwsXMOGe10CmUKcY0N4W7khQ/smVyt1odM6ehcH45tLythRHvFyhz/vzwDqzdQ/qqXof8ak+6QvyC8jzQwtnBTIOWPydkdMk8VZZTCMdp08Ix5AVHQj0QL94fN6HFeQCBlaUmPSmx9i6uSlRQRyRLOEfL1MYAGtCDArJechw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W8FaFNnqZVUehsIUBzLtLBvPKDNKMuiOcusBOqgjlLc=;
 b=jzSJrnKxMEcof816pEzRpjdN+AmqXfQvN+/ANNDjthOVxd/jKcnZ6eDjFcr72th0KzbWGWUUUs42NsSopC8w51EZarO3b2bNWvf0zDQo2/2bXHZfE2vkWuFMGt9Y3xNbcOayjhK+iWIEl+9dcEHRyLhP2JsdvDa3H0m8E2zGIhMg6SQr5s7xZG9vx7HtoPZYNU5PBIxw7wASt5m3wyW+KxM3vG0CI/qOTkWTA0JEn9786XcIDc0iIW7NtgLg9SBYzFZ45mIxPmdU4rncj3xQGsPQ8rvOJJJo9FT7Y5TT9IOV5F0VbH9CO9FSKFod7cd/DMtFFMrWjqr2TXX4IN24Sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 CY8PR11MB7898.namprd11.prod.outlook.com (2603:10b6:930:7b::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7828.33; Wed, 14 Aug 2024 08:55:58 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca%4]) with mapi id 15.20.7875.016; Wed, 14 Aug 2024
 08:55:58 +0000
Date: Wed, 14 Aug 2024 10:55:50 +0200
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Kurt Kanzenbach <kurt@linutronix.de>
CC: Tony Nguyen <anthony.l.nguyen@intel.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<netdev@vger.kernel.org>, Sriram Yagnaraman <sriram.yagnaraman@est.tech>,
	<magnus.karlsson@intel.com>, <ast@kernel.org>, <daniel@iogearbox.net>,
	<hawk@kernel.org>, <john.fastabend@gmail.com>, <bpf@vger.kernel.org>,
	<sriram.yagnaraman@ericsson.com>, <richardcochran@gmail.com>,
	<benjamin.steinke@woks-audio.com>, <bigeasy@linutronix.de>, "Chandan Kumar
 Rout" <chandanx.rout@intel.com>
Subject: Re: [PATCH net-next 3/4] igb: add AF_XDP zero-copy Rx support
Message-ID: <ZrxxFgcCSkrghBzH@boxer>
References: <20240808183556.386397-1-anthony.l.nguyen@intel.com>
 <20240808183556.386397-4-anthony.l.nguyen@intel.com>
 <ZrdxPgcqLdzCXCAS@boxer>
 <877ccjzevq.fsf@kurt.kurt.home>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <877ccjzevq.fsf@kurt.kurt.home>
X-ClientProxiedBy: MI1P293CA0016.ITAP293.PROD.OUTLOOK.COM (2603:10a6:290:3::8)
 To DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|CY8PR11MB7898:EE_
X-MS-Office365-Filtering-Correlation-Id: a1e79c88-1453-4e8c-c46d-08dcbc3eea4c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?lVgNjtQSqjBVvNfSYB3cOHA4w6NWHArtwnYKAWZZzoTyuaGhdRAeOmryRN4A?=
 =?us-ascii?Q?PFRku6bJI5kRoVZqUHwDdgMAGPV67MJRE2+lFqFjdoPZfsYRg7pv/Wotr1jH?=
 =?us-ascii?Q?thVzaCO0JVwQGkGWM0pRIULDhhHtJ39KF3UO7vKOD+adbgQEmSL6+I45HQOd?=
 =?us-ascii?Q?ns9Ccgbzfw+HfYielzxkdwpfoDPP6+ls4q1Fd/t//1KJfweKLVkhnhaRM/Nw?=
 =?us-ascii?Q?kkx2/RoQr5utHekf8zXEppBYGwLSvp2SyFiKadSvFxck05Z7EddlqOsWAISs?=
 =?us-ascii?Q?4k5WJYtYlXafPtp1pzfl+FjZMFeqxMj5rLBqVDrhe9qQogp0YKAxh+54FkMi?=
 =?us-ascii?Q?q0NC0wzwd2+hTLtSlRxprcbxpuoSxfGiRbyGHGff3ZLfN8GPzVngssczwVWv?=
 =?us-ascii?Q?m/OFXUUEuccu1vQ73J1cGFr/2YuSU7/RCf2DkZBVptnttWyFRS1tefEvCb4P?=
 =?us-ascii?Q?/6P06JjXPIqNfttw2fnvFyEaotWGLey/77m7q9XFcDkUKlbaQw+AHQoC9Eat?=
 =?us-ascii?Q?RxmyfPZwhlA+Hi0Vm0SIykZwtS3Djx00mhNS01Z+F+Kxg5FVb+wm8x75eHzq?=
 =?us-ascii?Q?nmWcGhE/clDioQBZIClTffKjBF4Pv8k3fMiS6Ke6aAaoWGH9c+slrdafCc5x?=
 =?us-ascii?Q?zpQopSFPkl9HURBFJlN3oolTchClROvHIavfX2a/6SPbLUA3iUkLzo7ncDj5?=
 =?us-ascii?Q?iZJaZu+1zuM4z9EbQObdoWBnLRdnyd9bhMgH82rDMWM95HgD6lhCRluACVCL?=
 =?us-ascii?Q?EsMyZlGNqWn5GFwepgcp3qomSNh37FNXT5PQ5bpWfgs+Cq67Ngq8xRijphZE?=
 =?us-ascii?Q?S1+N0euBS/gJOEOGkrMnIihHy3VkcmHZZG+4luzLnFv6k7Lm2k2xcpZ+hWyX?=
 =?us-ascii?Q?/9ZZisoK8gFRs6PBrUHhqo+dlhcpmi8M6VfnDRxsfQTWBIvgWmjFPcg3AI3E?=
 =?us-ascii?Q?Ophj+G6mdIrp19m5Kt5FyAeHdL8mteGss/Bd4hd5yvdWz/qTKrVw9px33WKv?=
 =?us-ascii?Q?UUPDrA9w3XPt8Rpao7wUyt41Qn84EXdN6Bf/VCmBRWNRBXPkbURO6MaV8ER6?=
 =?us-ascii?Q?pqChiTs5Zg2geb3hIxoLRYPejOUenkbeMGAE7bfggY8l4NmxzLlcA2hNKZL/?=
 =?us-ascii?Q?9IwSPNp9F1tkSmLwv3P2COg9By9R/Z2ecWj6kMbvRZHLScUGtDjDAWa4+7v4?=
 =?us-ascii?Q?+bhyD5XxIBWo0n3gawAyhaOwuNUNU3I+BVZQMIGkQ9JPpzD/S2Q6JCljkZVW?=
 =?us-ascii?Q?JwBeMh8QZkTe9EO3auHbhThKIMbBUigxFQbmmBYe3RCBZGEH9LmxdmxGhQND?=
 =?us-ascii?Q?e9NFJLbXLsnwzde1QHFH+hsMnEUAqTBvUst+3iAjOJ09FQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TGYBkf4CQhjyLYi2WFaDIgkC09vvWjpcwRaelT3AQzKEdH9jpAq79NcvMcS+?=
 =?us-ascii?Q?8v+pECo/4Ee6Wc5wmcOaJHBzPSSovesRP/UvvqWh9zyjyRW5mF11BvhDOEZT?=
 =?us-ascii?Q?XsQxOPu8pN8+P7qi881RHV/nktQDaNmAXifryidGULdtDO9UPxUo62tIEtSJ?=
 =?us-ascii?Q?Tnr4tycTD135us4BSR3X7zI9Di4RqjQfxP6JyVQFzVpvm/Fwrt9lEn+bMynn?=
 =?us-ascii?Q?WcUeK8kdZLvBkvaBkCh3Dx4UiDu0p/n06ChVrGX3S6HzPbkartyBY6tqO69n?=
 =?us-ascii?Q?hH1FZVTfP/9a8V4vk7E46ZPUnnMSxe8ZRXd/j9bevevCnX8cPKAyA7HMPLH8?=
 =?us-ascii?Q?1Ft/R16VVpIB1lCa3hyrj3rCcUBIsudr4S6o6an4HZBix4rDxH1WR4YDCLge?=
 =?us-ascii?Q?FNs+PlR+HWtLqXRWc2H7l6dBTMC2NBOhhSukSICB0Qt2ZrD1b/4y1OTi9Bk1?=
 =?us-ascii?Q?qV/ZSftQIlq2m4Ek7KeGgz+LWkGMeff1YwVpwl+Slp1i/81wFe8d4EyJ51EC?=
 =?us-ascii?Q?qp06QPDqIT7fg92esEkVyTYqtw7nxDYSGruf1maScyqSyRMDhBL5pzHsbpyU?=
 =?us-ascii?Q?m0tVezlAI6IFIAOw4FTLQbboAYHqL5i7+gkX5su2XRI2PXCy1lBSY8vAYqpI?=
 =?us-ascii?Q?qPc6hFp/970OVYlCVyqOfYYPba3DLXUAy1g5K5G16P/AIqHwrvZs0zgSd/WQ?=
 =?us-ascii?Q?qmKC4ZQ33H8HwOtfzXzePdAU1RIE/HtS4Jd6pFqQkFn9bTaC691d9IB5ivqM?=
 =?us-ascii?Q?w0v9PbNNAATtt3y3M/2m/2IoewPkbPa4FaORqmXWgU207AhXlSJk4Zga1+G9?=
 =?us-ascii?Q?YXLA9jgq1OhIo56R7AT2byuD73QvBV9oSDTPk42Wmm0OICKBlcgrasq53YJ7?=
 =?us-ascii?Q?TmvrG28XaESD7rkGrqPcgZEcO1bgHY9mg1gZeyWhfMv5OmW4VpCZKnF+8dHh?=
 =?us-ascii?Q?toT2lHiibNpRPfOv+Ja6ZZEYNsZX9D6RmeB/ig0ROLPy9Kv4YzPGx2Egc2a1?=
 =?us-ascii?Q?/kFNrjowC4k/+rPpPNQOpYTWevp1YCs6Sm5XPJZDhwgIIoSKhUmRfcyO+ati?=
 =?us-ascii?Q?MjyX2rf0lZT+tnmUHlmnB824s2790ZlLXfdODLVNiThi452pr+M8Xx9kcMSb?=
 =?us-ascii?Q?VPfiMBYTIUA4kmQGHLvx5QU6BkjyspaTXl8ARus174YnmqOsGUjL7HLn/ymk?=
 =?us-ascii?Q?RE6W8h4BbiKBFp1rVrRPZrqRLKSVSorXbn9TlbAZY3M01b2DQCoau9vbDDhu?=
 =?us-ascii?Q?+fu2RZ4zyz3r//Uuwl0ncF9xRXfC+WCmBMtHYKc9Ri8u9Y8BHZ1UUu4qNP74?=
 =?us-ascii?Q?lUwqiYIlzjkHJFPQUwc7lFsy+261GMMApdF/bb/yY6z5q2rXPLyX5fqiJlS+?=
 =?us-ascii?Q?af94BHWDvmdfsw5EijfpC9S+U6SzbzE0HAhxr0VGj8c8e2ASlWRT+nCozg/o?=
 =?us-ascii?Q?4r+7EjY+1J6KUZC83dZeealoP3cLXkCNsCtPcoC/eyvQh8UwPGYQgrmR1uRD?=
 =?us-ascii?Q?OFHj+IUYAFbAA63Rt9bGNu9vYeZ/F5Oa6BK/qa9ZOih4o+35lpmiW0XW9mjr?=
 =?us-ascii?Q?wM5P05I3YdDqqC1IIciKRy3gNATaGAhj6A3SO7oeXM6OUm3fKQAbtEHUXDUQ?=
 =?us-ascii?Q?ww=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a1e79c88-1453-4e8c-c46d-08dcbc3eea4c
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2024 08:55:58.5698
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Fxorx0/+PIR1Oy9AKtRWUJFRRLSTPr2yEYV4INuR5fCiD9BjIy76cRA8MhBaOwmpEC0pZglU75zB9o6f76uRQnJPT3Jie/HDVjp0BIkbDMo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7898
X-OriginatorOrg: intel.com

On Wed, Aug 14, 2024 at 10:29:29AM +0200, Kurt Kanzenbach wrote:
> >>  	case XDP_REDIRECT:
> >>  		err = xdp_do_redirect(adapter->netdev, xdp, xdp_prog);
> >
> > We were introducing a ZC variant of handling XDP verdict due to a fact
> > that mostly what happens is the redirect to user space. We observed a
> > reasonable perf improvement from likely()fying XDP_REDIRECT case.
> 
> Indeed, I can observe an improvement too.
> 
> I've introduced igb_run_xdp_zc() which takes care of that
> optimization. Also it takes a pointer to the (read once) xsk_pool to
> address the other comment.

Nice, thanks!

> 
> Thanks,
> Kurt



