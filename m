Return-Path: <bpf+bounces-65445-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 08A7DB23048
	for <lists+bpf@lfdr.de>; Tue, 12 Aug 2025 19:50:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1BFC5188C1A2
	for <lists+bpf@lfdr.de>; Tue, 12 Aug 2025 17:49:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB109257435;
	Tue, 12 Aug 2025 17:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MwQNhJIi"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37A8A2D46AC;
	Tue, 12 Aug 2025 17:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755020968; cv=fail; b=JjQEKSLfx+RaW0K4Ul5F3l0nj+DcfSTT754XitHHwHnwaN5w8PlUxdL29bDPQMNYupLfZmuYzR6ex+BMNnV2f3J/J6fH62GbhBIAW+UGBobGYDmVBGSaD5tsdjYmxiC4E02u/qGf9HFD+F+ZbZtXh+kN8IXSAcuTM7go2Exy2+w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755020968; c=relaxed/simple;
	bh=eThFjvzFCQ4WTHNbZ+0xHnzRPUDPgnYyqrQQsahWhbA=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Fzcnn0hF/TUgI9WA0b49KQmtdFPP3enwYMN3eUDAlX9fCQubadK70GqOZdEy8BmZbXUB7EKvENpsznbGGyxMbPEWQGaFHgQSZULOt0HPFErbgOfDxX9suhYVkPnms2GaC/h5OEPdnFV/heZtn3s3PQzkGvIKOqz5Cfxui+IpAOQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MwQNhJIi; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755020967; x=1786556967;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=eThFjvzFCQ4WTHNbZ+0xHnzRPUDPgnYyqrQQsahWhbA=;
  b=MwQNhJIi0SMsu1MjLtIEgzX4DDfYbZ52Rb8Y8Bitq/KNtZuH0OxzW1tE
   zl75m9I7ILh5rdP2ryEBJclZSaPDLROBXVpi7iW/4ALhlPIBxOAnhustJ
   D2JpKL2vVXuSK2+T2xV1d/3j56sJ5kO07+qHj8QXFcNY0sMCz9dKvfijQ
   nUCapL1rfm7I2o7DRub3ZWQU86g56J0woi45BDUIomTOR3k1rqWhYZkv7
   +Kmy2F2rXXCuMrlI//KQ9nRFDq0LWJAaxcqdKmfCs2QjlNEgVDMui2eUy
   ysqBC53ev8FPSuAgUHTc3XJOid27VVeay+qT17YKbG2jIP7m1nkfnYSJW
   Q==;
X-CSE-ConnectionGUID: UXSAUkGcQMCx8yEEUYgm2A==
X-CSE-MsgGUID: 1x4PUFoYTeK52TKZ+vB6mw==
X-IronPort-AV: E=McAfee;i="6800,10657,11520"; a="74754518"
X-IronPort-AV: E=Sophos;i="6.17,284,1747724400"; 
   d="scan'208";a="74754518"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2025 10:49:26 -0700
X-CSE-ConnectionGUID: vB6d6PWnRSiaujFA5YTqeA==
X-CSE-MsgGUID: vz4nEucQTr2Jt3rmxv7hcg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,284,1747724400"; 
   d="scan'208";a="171516507"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2025 10:49:25 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 12 Aug 2025 10:49:24 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Tue, 12 Aug 2025 10:49:24 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (40.107.93.73) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Tue, 12 Aug 2025 10:49:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E+0HibOipOzW0RcCySV/Ci0Q3u2A2qHnS6/AeNCmgSylbQNi+A5fpIMF72NZfWCY5PipQTr+IhCLHc/9mtUue11F/c7XVW3tbs7rzmhFVxPGYmGXQ0/waZdfhGpPIz+tt0WuEGSRJeXk3qBK2Ky8aV7CavzSQbmZr4UR6LNRqE7vTHOAfciqMHk67IhAvgvmg1wj16qKX4/aR+YybLZBNk4R135+uU5biDc1HCiQyK46zJhZLEjH+E11FsSfRkfBRaJwfi/GilYkZF/y7syQKBtne/aIGo88eiWwWg9sTRlduvIzmW3YTNhOUxoS1/VeLITvFpzl26sFaCAtkZFwIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=94b7T5gjXQOcfZF4ftU9xp2treRw42a/sRqeo/fkrjo=;
 b=K8YX4JozErEBGrGOE18O95oK8TaHvWSQyRnfuwmEcwklCQp0U8qThBzmE8JeoFeaaEjjX6MSK9Je2/U3U02Kr8CThXLwyl+aJpRLN6f/l7K2enfExVIN/PrTdw7TGIScTmhRcUZXYWmc26eY24534QZ8iZAYhiIGI+ILgptYhg2RCqF8pcjW0cD++AurrfnLYt3y+T5HbxsL2wllTM5lieZLEkKSBELEd3UM3eCX26ZQ+120KAc1qjejG8J0xrAM9rlYm0m5C9poaUxXtB+9RBlLGTtGXQrXX/axwH71twJipIagVzhExjEdzqXWnjy+qMWZ5wXHEZokrZtQznlHIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 CO1PR11MB4947.namprd11.prod.outlook.com (2603:10b6:303:99::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9009.21; Tue, 12 Aug 2025 17:49:16 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca%4]) with mapi id 15.20.9031.012; Tue, 12 Aug 2025
 17:49:16 +0000
Date: Tue, 12 Aug 2025 19:49:04 +0200
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Jesper Dangaard Brouer <hawk@kernel.org>
CC: Jason Xing <kerneljasonxing@gmail.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<bjorn@kernel.org>, <magnus.karlsson@intel.com>, <jonathan.lemon@gmail.com>,
	<sdf@fomichev.me>, <ast@kernel.org>, <daniel@iogearbox.net>,
	<john.fastabend@gmail.com>, <horms@kernel.org>, <andrew+netdev@lunn.ch>,
	<bpf@vger.kernel.org>, <netdev@vger.kernel.org>, Jason Xing
	<kernelxing@tencent.com>
Subject: Re: [PATCH net-next 2/2] xsk: support generic batch xmit in copy mode
Message-ID: <aJt+kBqXT/RgLGvR@boxer>
References: <20250811131236.56206-1-kerneljasonxing@gmail.com>
 <20250811131236.56206-3-kerneljasonxing@gmail.com>
 <b07b8930-e644-45a2-bef8-06f4494e7a39@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <b07b8930-e644-45a2-bef8-06f4494e7a39@kernel.org>
X-ClientProxiedBy: DB9PR01CA0020.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:1d8::25) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|CO1PR11MB4947:EE_
X-MS-Office365-Filtering-Correlation-Id: a45259c1-cc13-4fcd-d52d-08ddd9c88ea8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?qj9QeW/SU8rZiMkopDtrnJHGct49eHH1p0w50Sy87xw2OwSMqFEhiCICUrvx?=
 =?us-ascii?Q?W2FONEgQSGdrpHz2bFUEGCHsuBm9HX1NTG4OOkK695z8EvqZepvt2GF2xuE7?=
 =?us-ascii?Q?3Di3PDqGgWM1NTQjrg9YMeSeYqVkjdOrQgnZs4isIpJRvCh8K0H3s6bnwyD+?=
 =?us-ascii?Q?WJqfICw6AjlhDMBfIA+WKkg/BeUJZdJmhibBGc8r+6MzcSu12I6fDw19sT6I?=
 =?us-ascii?Q?Eqx7iKmvm/yUEg2p9qJo8qCiSaw4lY0Mi7wqgVyIYAsi0Yi0b39NEQB7e1Yd?=
 =?us-ascii?Q?wkdyxNpwcSC5r1Hq7o+uKNavrxDRPkCuDbyZhyvlm+E899O5LMgZzzSaLYc4?=
 =?us-ascii?Q?YLLd6RQI1I2K9JbIFmiMetuSiCr3mb7UFZEPb5Qdjb2Va4jHyRL4hS+JE5hZ?=
 =?us-ascii?Q?vhJRRIOSnMIDQk3jCHTIChhDYWu1Qz7qKw/8fyvd1Hv1IqtMPBVXgak8IqEJ?=
 =?us-ascii?Q?aiF9khnx0RiyE8MxE1d9Vil7w0zTE0bQUUc/W/sGkMHnx2ODNQhgJ1dunpAb?=
 =?us-ascii?Q?ewNZ66ZMkCsMIYEu3NDBfCVwoCbHsIBV04iTaJ/L3jeJXHTJ5Fnm+Igwdo1V?=
 =?us-ascii?Q?PuZ7NKr9Pim6lHklHm4ZfxHr+z+4RYCK/4n+VLwc7x2yUL59sgeF7o0vPkKv?=
 =?us-ascii?Q?4gxACrvwmbcg8yDPFLZ6bbRhslpFfknmYDng+yQUfWCvMc6Xau18EeXpNWiO?=
 =?us-ascii?Q?hhDZuDoUpGk0xnP6WILKYVjqRzARimpY1vLKW/8gjyrqTZ89CbJ7jMl9RCJ3?=
 =?us-ascii?Q?ZzcYYN1ydWzz2y3rx3NTwqa3PcNtWEHrlRvbWemen66pW4AzepNZqa5gIY8T?=
 =?us-ascii?Q?a3vqZMiUnJnzNWLBCjfsuj/BhQRNxf1F+y3xXnm0Nrcn6CUzsLxGAAYX25T3?=
 =?us-ascii?Q?vDqrzkdxpBnldx/MU1ZVyMY+6j2a6qCvr0TUS4ft/FYv1GZIRxqoOno70qI1?=
 =?us-ascii?Q?khaO6cm3iR41AFhfUgAnX2IKLYpQHvl/x5av7y+sL0ZSiDalWnfpo7PIg398?=
 =?us-ascii?Q?Avi9EhyM8ToyDZQ/KcxUgVgc8o6nh0pxiN7EIU333Up30Gy7DkDLkE8flTGo?=
 =?us-ascii?Q?qIaEEzbs2BALGumQGae4sxx+V9BiTpnUAgUgu1Zv48EdtiOYk0RCoeZ64moS?=
 =?us-ascii?Q?1MpTqcZ2pJsXydpx/97eJfZBU38XaXXMR0ijz9FEXbbRhQM0CARNz1ZXjPh6?=
 =?us-ascii?Q?DBY+oesn0pOEhELZ6Ainf/qQBL6w/1M2QsKKALode6ncb7ggwXZVuJvWArWX?=
 =?us-ascii?Q?PzCZGYQwGF4NR1VgcEpLj6GtTdGnusVl1hQkvk5zAtjf4WdFGxGDTckjSBEZ?=
 =?us-ascii?Q?OMdcQrqDGzOSVQrghR3Z7AzFTBLgvjUUrSzf3EF1sejor2bOFBQ4SPz3PKvv?=
 =?us-ascii?Q?pAHDXVxXHT40A62UPKD5pc+SyC9L+h06kyJF+kjJTz71a6w+lciIlM99sl53?=
 =?us-ascii?Q?WND5qVN6q4A=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Oze0Z7Rjv9cLLy61nFX+bT3Z6GP/MJyTT35PSe0FeUNyVA0iLEOXcRCY/e7A?=
 =?us-ascii?Q?z7iR9Kw+/L+vvJEM4VfxNwL1Tr5Zkl7CV4W7TkkQBaVQD1jeshWcRQn6YoCu?=
 =?us-ascii?Q?syPeOB0ZmiCeyJpZdo9eGedc/gZ7KZ3Ri6aRafNixXKE1lQcCcJllqaADaQo?=
 =?us-ascii?Q?IFP8JqSjGBqpU3k00+NGEQ8JP4jHZhACW6q1fI0xhxkbqxSqI1F7IjhQcSlK?=
 =?us-ascii?Q?utBjrMjvntUFG3QjxXgbJxi5g/jmU6jphWUWdSF+WtibA2n5E7KqEgN4kvD0?=
 =?us-ascii?Q?cF/Vnv52FiEuBJrHPFLnYBHBaulIpQ2rC5yzn8ODAtltQpEcMEZnpD9zf4fK?=
 =?us-ascii?Q?oYKCtSv0faFVm1y3xc/KHvPIxjBycqwYciKAzQbnDxe5ilgfrU/DrmbCA3cu?=
 =?us-ascii?Q?eAOnzZ2mb+OJibi4zIvxab34SopKDsrv7CKYHV2wb1w8hGzz09MRV1VDfHER?=
 =?us-ascii?Q?nL/FDtuGlvwf2DGN2A0fURBYDq0yGfc/HtzfYEYJsLYcO0CGDX8u/OXQM3fl?=
 =?us-ascii?Q?3RaQUUFiyDsZL90nq9Z1P9VTnjKBRCRxiIziEFs3nq80P3ZlZUq/Yh13pANW?=
 =?us-ascii?Q?1j9gvZNO3Fca4M/BvUxFfdLcjeE8dR4GBUesM8Q/KRIVGoCX7HMhURch7mpF?=
 =?us-ascii?Q?qLKOYxVMeWcc2gCTelbnQ2B+fI6/IY7eNCb8Wi4HXbHG3airGQNjv3aCYcPH?=
 =?us-ascii?Q?57yHhDHys8ffwgWo20BQPnhfIP5BTZmghg3SSCeB3Bv1GJ4L+9FT/y56UJYN?=
 =?us-ascii?Q?W0VCVi0UY8YGhvn/5+VRf0A1AEEMffqT7I4UZb+8qDR6fl2mgDK9v4Dk8/2Y?=
 =?us-ascii?Q?3ZApzf+M6Q9dqZK0jr4FhZ6+9z2VED4iMiKgWZCx5AfvjJsDfQpsWLLT93LT?=
 =?us-ascii?Q?8YKpXFMgu2f6ufILYg9j+KAmMX46BxVboqDOWHdrML1i10Un3IXzspKo4Mne?=
 =?us-ascii?Q?nlGO1fXrG6ZVOlsU+ZAtd4Cgvodh76YQ0zzbdgCSPxCYiVOhVyMrzaSikG0O?=
 =?us-ascii?Q?7XMD/dIEl1ze/OFuwVHKhgqGq6umpuqp6J046R346UlyJvPOB4P4GQ4Gw4wF?=
 =?us-ascii?Q?afAiG18sO5x4U8oQlNO9P4WCQJgKYN9nGV7FQDEMGTqHBHEpvLYVIzfDZ6ID?=
 =?us-ascii?Q?cfHoJMZaDf149n3TgWKymfDS+2qYXSNRo9POxo7XkbkJtoktQTcNM4jET0Xv?=
 =?us-ascii?Q?zE7/z2jMnkRHRyYgpyStKjAdqh+/6NYCoMWtpceBPAgjgwykZqmJJ64Kypj1?=
 =?us-ascii?Q?2+kSYCGhzsCUDU1nBZ10bEuYh8c6uEc0eOEzLArRS0QqIAfbIvSvG6m2AG2I?=
 =?us-ascii?Q?AOgWPovrSHco6l6cP57V5T3/PhdRg/+nHYTl7AAgQn8wO0oWSvVAhMP+hXzs?=
 =?us-ascii?Q?c5D6MLNU5TE/PlZsVPi1OdGeGlvMKIxlEAHsdw50jpRjGEhtWMgorp/Mkn6V?=
 =?us-ascii?Q?TDX2qo4BX9jO5uhXM6lvy+EFXes+h4datPBMxzgRenvFmn4evz5Yqo5eFpEv?=
 =?us-ascii?Q?DAECH5sEATaq+RekUWxRdXsF5erLDi7+64BkPVajCD2k97POsz0AR65yL8wq?=
 =?us-ascii?Q?Wzxz+VcET/NIfirL1qtUFcySrjcQHY0lHe7y1IGxXRqJ1oBczCqWQKqHw3xu?=
 =?us-ascii?Q?dw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a45259c1-cc13-4fcd-d52d-08ddd9c88ea8
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2025 17:49:16.8166
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n+HeTjvFWnqHgrvMgamPDng2a+22rw31IMNbYMxNqXsCQ+LXWVieC+/qtZ6f+xwsB7kCQX+GRI8djke9pIpm5yWy3YR+hIg1B63ec1QBv40=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4947
X-OriginatorOrg: intel.com

On Tue, Aug 12, 2025 at 04:30:03PM +0200, Jesper Dangaard Brouer wrote:
> 
> 
> On 11/08/2025 15.12, Jason Xing wrote:
> > From: Jason Xing <kernelxing@tencent.com>
> > 
> > Zerocopy mode has a good feature named multi buffer while copy mode has
> > to transmit skb one by one like normal flows. The latter might lose the
> > bypass power to some extent because of grabbing/releasing the same tx
> > queue lock and disabling/enabling bh and stuff on a packet basis.
> > Contending the same queue lock will bring a worse result.
> > 
> 
> I actually think that it is worth optimizing the non-zerocopy mode for
> AF_XDP.  My use-case was virtual net_devices like veth.
> 
> 
> > This patch supports batch feature by permitting owning the queue lock to
> > send the generic_xmit_batch number of packets at one time. To further
> > achieve a better result, some codes[1] are removed on purpose from
> > xsk_direct_xmit_batch() as referred to __dev_direct_xmit().
> > 
> > [1]
> > 1. advance the device check to granularity of sendto syscall.
> > 2. remove validating packets because of its uselessness.
> > 3. remove operation of softnet_data.xmit.recursion because it's not
> >     necessary.
> > 4. remove BQL flow control. We don't need to do BQL control because it
> >     probably limit the speed. An ideal scenario is to use a standalone and
> >     clean tx queue to send packets only for xsk. Less competition shows
> >     better performance results.
> > 
> > Experiments:
> > 1) Tested on virtio_net:
> 
> If you also want to test on veth, then an optimization is to increase
> dev->needed_headroom to XDP_PACKET_HEADROOM (256), as this avoids non-zc
> AF_XDP packets getting reallocated by veth driver. I never completed
> upstreaming this[1] before I left Red Hat.  (virtio_net might also benefit)
> 
>  [1] https://github.com/xdp-project/xdp-project/blob/main/areas/core/veth_benchmark04.org
> 
> 
> (more below...)
> 
> > With this patch series applied, the performance number of xdpsock[2] goes
> > up by 33%. Before, it was 767743 pps; while after it was 1021486 pps.
> > If we test with another thread competing the same queue, a 28% increase
> > (from 405466 pps to 521076 pps) can be observed.
> > 2) Tested on ixgbe:
> > The results of zerocopy and copy mode are respectively 1303277 pps and
> > 1187347 pps. After this socket option took effect, copy mode reaches
> > 1472367 which was higher than zerocopy mode impressively.
> > 
> > [2]: ./xdpsock -i eth1 -t  -S -s 64
> > 
> > It's worth mentioning batch process might bring high latency in certain
> > cases. The recommended value is 32.

Given the issue I spotted on your ixgbe batching patch, the comparison
against zc performance is probably not reliable.

> > 
> > Signed-off-by: Jason Xing <kernelxing@tencent.com>
> > ---
> >   include/linux/netdevice.h |   2 +
> >   net/core/dev.c            |  18 +++++++
> >   net/xdp/xsk.c             | 103 ++++++++++++++++++++++++++++++++++++--
> >   3 files changed, 120 insertions(+), 3 deletions(-)
> > 
> > diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
> > index 5e5de4b0a433..27738894daa7 100644
> > --- a/include/linux/netdevice.h
> > +++ b/include/linux/netdevice.h
> > @@ -3352,6 +3352,8 @@ u16 dev_pick_tx_zero(struct net_device *dev, struct sk_buff *skb,
> >   int __dev_queue_xmit(struct sk_buff *skb, struct net_device *sb_dev);
> >   int __dev_direct_xmit(struct sk_buff *skb, u16 queue_id);
> > +int xsk_direct_xmit_batch(struct sk_buff **skb, struct net_device *dev,
> > +			  struct netdev_queue *txq, u32 max_batch, u32 *cur);
> >   static inline int dev_queue_xmit(struct sk_buff *skb)
> >   {
> > diff --git a/net/core/dev.c b/net/core/dev.c
> > index 68dc47d7e700..7a512bd38806 100644
> > --- a/net/core/dev.c
> > +++ b/net/core/dev.c
> > @@ -4742,6 +4742,24 @@ int __dev_queue_xmit(struct sk_buff *skb, struct net_device *sb_dev)
> >   }
> >   EXPORT_SYMBOL(__dev_queue_xmit);
> > +int xsk_direct_xmit_batch(struct sk_buff **skb, struct net_device *dev,
> > +			  struct netdev_queue *txq, u32 max_batch, u32 *cur)
> > +{
> > +	int ret = NETDEV_TX_BUSY;
> > +
> > +	local_bh_disable();
> > +	HARD_TX_LOCK(dev, txq, smp_processor_id());
> > +	for (; *cur < max_batch; (*cur)++) {
> > +		ret = netdev_start_xmit(skb[*cur], dev, txq, false);
> 
> The last argument ('false') to netdev_start_xmit() indicate if there are
> 'more' packets to be sent. This allows the NIC driver to postpone
> writing the tail-pointer/doorbell. For physical hardware this is a large
> performance gain.
> 
> If index have not reached 'max_batch' then we know 'more' packets are true.
> 
>   bool more = !!(*cur != max_batch);
> 
> Can I ask you to do a test with netdev_start_xmit() using the 'more' boolian
> ?
> 
> 
> > +		if (ret != NETDEV_TX_OK)
> > +			break;
> > +	}
> > +	HARD_TX_UNLOCK(dev, txq);
> > +	local_bh_enable();
> > +
> > +	return ret;
> > +}
> > +
> >   int __dev_direct_xmit(struct sk_buff *skb, u16 queue_id)
> >   {
> >   	struct net_device *dev = skb->dev;
> > diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> > index 7a149f4ac273..92ad82472776 100644
> > --- a/net/xdp/xsk.c
> > +++ b/net/xdp/xsk.c
> > @@ -780,9 +780,102 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
> >   	return ERR_PTR(err);
> >   }
> > -static int __xsk_generic_xmit(struct sock *sk)
> > +static int __xsk_generic_xmit_batch(struct xdp_sock *xs)
> > +{
> > +	u32 max_batch = READ_ONCE(xs->generic_xmit_batch);
> > +	struct sk_buff **skb = xs->skb_batch;
> > +	struct net_device *dev = xs->dev;
> > +	struct netdev_queue *txq;
> > +	bool sent_frame = false;
> > +	struct xdp_desc desc;
> > +	u32 i = 0, j = 0;
> > +	u32 max_budget;
> > +	int err = 0;
> > +
> > +	mutex_lock(&xs->mutex);
> > +
> > +	/* Since we dropped the RCU read lock, the socket state might have changed. */
> > +	if (unlikely(!xsk_is_bound(xs))) {
> > +		err = -ENXIO;
> > +		goto out;
> > +	}
> > +
> > +	if (xs->queue_id >= dev->real_num_tx_queues)
> > +		goto out;
> > +
> > +	if (unlikely(!netif_running(dev) ||
> > +		     !netif_carrier_ok(dev)))
> > +		goto out;
> > +
> > +	max_budget = READ_ONCE(xs->max_tx_budget);
> > +	txq = netdev_get_tx_queue(dev, xs->queue_id);
> > +	do {
> > +		for (; i < max_batch && xskq_cons_peek_desc(xs->tx, &desc, xs->pool); i++) {

here we should think how to come up with slightly modified version of
xsk_tx_peek_release_desc_batch() for generic xmit needs, or what could we
borrow from this approach that will be applicable here.

> > +			if (max_budget-- == 0) {
> > +				err = -EAGAIN;
> > +				break;
> > +			}
> > +			/* This is the backpressure mechanism for the Tx path.
> > +			 * Reserve space in the completion queue and only proceed
> > +			 * if there is space in it. This avoids having to implement
> > +			 * any buffering in the Tx path.
> > +			 */
> > +			err = xsk_cq_reserve_addr_locked(xs->pool, desc.addr);
> > +			if (err) {
> > +				err = -EAGAIN;
> > +				break;
> > +			}
> > +
> > +			skb[i] = xsk_build_skb(xs, &desc);
> 
> There is a missed opportunity for bulk allocating the SKBs here
> (via kmem_cache_alloc_bulk).

+1

> 
> But this also requires changing the SKB alloc function used by
> xsk_build_skb(). As a seperate patch, I recommend that you change the
> sock_alloc_send_skb() to instead use build_skb (or build_skb_around).
> I expect this will be a large performance improvement on it's own.
> Can I ask you to benchmark this change before the batch xmit change?
> 
> Opinions needed from other maintainers please (I might be wrong!):
> I don't think the socket level accounting done in sock_alloc_send_skb()
> is correct/relevant for AF_XDP/XSK, because the "backpressure mechanism"
> code comment above.

Thanks for bringing this up, I had the same feeling.

> 
> --Jesper
> 
> > +			if (IS_ERR(skb[i])) {
> > +				err = PTR_ERR(skb[i]);
> > +				break;
> > +			}
> > +
> > +			xskq_cons_release(xs->tx);
> > +
> > +			if (xp_mb_desc(&desc))
> > +				xs->skb = skb[i];
> > +		}
> > +
> > +		if (i) {
> > +			err = xsk_direct_xmit_batch(skb, dev, txq, i, &j);
> > +			if  (err == NETDEV_TX_BUSY) {
> > +				err = -EAGAIN;
> > +			} else if (err == NET_XMIT_DROP) {
> > +				j++;
> > +				err = -EBUSY;
> > +			}
> > +
> > +			sent_frame = true;
> > +			xs->skb = NULL;
> > +		}
> > +
> > +		if (err)
> > +			goto out;
> > +		i = j = 0;
> > +	} while (xskq_cons_peek_desc(xs->tx, &desc, xs->pool));

from the quick glance i don't follow why you have this call here whilst
having it above in the while loop.

BTW do we have something bulk skb freeing in the kernel? given we're gonna
eventually do kmem_cache_alloc_bulk for skbs then could we do
kmem_cache_free_bulk() as well?

> > +
> > +	if (xskq_has_descs(xs->tx)) {
> > +		if (xs->skb)
> > +			xsk_drop_skb(xs->skb);
> > +		xskq_cons_release(xs->tx);
> > +	}
> > +
> > +out:
> > +	for (; j < i; j++) {
> > +		xskq_cons_cancel_n(xs->tx, xsk_get_num_desc(skb[j]));
> > +		xsk_consume_skb(skb[j]);
> > +	}
> > +	if (sent_frame)
> > +		__xsk_tx_release(xs);
> > +
> > +	mutex_unlock(&xs->mutex);
> > +	return err;
> > +}
> > +
> > +static int __xsk_generic_xmit(struct xdp_sock *xs)
> >   {
> > -	struct xdp_sock *xs = xdp_sk(sk);
> >   	bool sent_frame = false;
> >   	struct xdp_desc desc;
> >   	struct sk_buff *skb;
> > @@ -871,11 +964,15 @@ static int __xsk_generic_xmit(struct sock *sk)
> >   static int xsk_generic_xmit(struct sock *sk)
> >   {
> > +	struct xdp_sock *xs = xdp_sk(sk);
> >   	int ret;
> >   	/* Drop the RCU lock since the SKB path might sleep. */
> >   	rcu_read_unlock();
> > -	ret = __xsk_generic_xmit(sk);
> > +	if (READ_ONCE(xs->generic_xmit_batch))
> > +		ret = __xsk_generic_xmit_batch(xs);
> > +	else
> > +		ret = __xsk_generic_xmit(xs);
> >   	/* Reaquire RCU lock before going into common code. */
> >   	rcu_read_lock();
> 
> 

