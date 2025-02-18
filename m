Return-Path: <bpf+bounces-51827-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 460CAA39CBB
	for <lists+bpf@lfdr.de>; Tue, 18 Feb 2025 14:02:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD1271754EE
	for <lists+bpf@lfdr.de>; Tue, 18 Feb 2025 13:01:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28DEB267B1E;
	Tue, 18 Feb 2025 13:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WCPpaWGH"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB4FA266F19;
	Tue, 18 Feb 2025 13:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739883687; cv=fail; b=QNkh01rH4QS79nibvgJN4Uv2Hm/QJZgin+AXR1ADPR2hwHNtZUsTpWAYQ6tRlqLH/ZQ9Iw6d7Y3q1jATz4FDOrjdShNLzfjEDrZycA3e0pa3RWNu17EK8xqkUbuoKNA9xEd0rENcyReAftyG5DLBj6Qo35bs3T7h/ACBUIaruII=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739883687; c=relaxed/simple;
	bh=g7yMXstoGrKlaU/8VPlsb1F7o293ZUYoJfXt73MXqk0=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Xmede0J7rFyBLNbcQuk6FHA8wT1yzf215sDfdoMf037xvUzlaYTPfG98uWqjX5Ds3DGHFZ/PZIFfZCOAXZWhM+qlW1MLmp7JqccAmGea8IwjI5Gcdszw/mBUCJevCmGlcULhHiu1sq3uOBFMoIe1g7FcddGH73fYdLP4OWZHoXk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WCPpaWGH; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739883686; x=1771419686;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=g7yMXstoGrKlaU/8VPlsb1F7o293ZUYoJfXt73MXqk0=;
  b=WCPpaWGHnYYsptEjQJ/lmwaMZh+KgJNljCMwQI3HxmZs2MX0dWvuWtDq
   zG1/uxlyrRgKdDbJSmJWOrsEYuHAg92zEMG4XtyEHQ5VrGOz77Xq2e2hs
   sgfy+qjIYZ0VpZmaT4DzniOOs/X4nHpRw6DS8sPp5zPyClEZYff+VS5jI
   SH6MoGBFrj5BWELWLGlZECjElMbg7p8beY23fiszOdkBVWoweTN/QH6c7
   6P3Arpwe0kJicfBy38qur+kNxCQc29H8BjGWHsbUEyUuNVa5b2rpkPDsX
   WveiT8QuZJb9i0V0UgajOhJgGJ96EDXUo9PRzi5NrtHnTObFJD1j+CQDE
   w==;
X-CSE-ConnectionGUID: SnXsl/iKTBqCWm8IKG9X3w==
X-CSE-MsgGUID: s19VQffoRWC6QWuIoiU9Ow==
X-IronPort-AV: E=McAfee;i="6700,10204,11348"; a="63053119"
X-IronPort-AV: E=Sophos;i="6.13,296,1732608000"; 
   d="scan'208";a="63053119"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2025 05:01:21 -0800
X-CSE-ConnectionGUID: RzXAepHiSCuyLTxkZiPf4A==
X-CSE-MsgGUID: p0ubQJeBRkCB9SU5zX4GkA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,296,1732608000"; 
   d="scan'208";a="114590695"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 18 Feb 2025 05:01:19 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 18 Feb 2025 05:01:19 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 18 Feb 2025 05:01:19 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.175)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 18 Feb 2025 05:01:17 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hg0tB5zMFes/Ne2pOdvIRbpH7r/VMG2rrM8o8Mx7rbKZvU/KioCVNzOOc3zK5eiECfiNWBPKtCcQmt89K/1n8XvlpRW5Uilt3bfmuWnbNfYqWsApbwy9xDb9Fa2Is19BEm+1r+BB2qkdmBqjQyDyAcYXNqvtNY/2CsBv7ssjnmmvpAMiBm704+Efd+zU1QvB5xsakP7TrvSiTecKveJ4xmiQdXlK/b37fiL3CR8ZotH/6Pmsv2fZb7tgzLXHBzFrFqCNPf+NfktbJDsMt6vBbXItTIiZP2SvKNQbTNHfm05L+PVv9APQvI0ZdlyMlhltLUdi+NCCtFlt9WhhkBZKTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3tuGUEpYwdv69tlCLeDPoHvXwfHyOxt8uxFJ3lI7Itg=;
 b=Xcq7AWlc5ms875Vri/bNHYMNaN5cHj377cOv06gKdpnVKh5/DEe3vMvSM3BDYFJtpLudbZXD0T2whO4PbzUoRr9zuE8VSebVi5Ks0buWCxc9cP0yWgNMx3NClylCUxRgnnDJ6MaoBjxX8P+q5DK2v7I71onLdOGVKRGujt/Lz4ryexjQ4ORX3T9V2YdEx1awzmTO5TsTQwkDfFIUwTz35VJYrdTngCMDBeqIFquQv7QcivlkkZVUdTHoZNALarZVpw8lRhOrTLewKAExUZunWHwNCcCSUUTvycUYZDh3hnQyAdmMCQCNWG3GyT04Wrzf4DAouGtFmJkG/tAOy2o/NQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB6097.namprd11.prod.outlook.com (2603:10b6:208:3d7::17)
 by DM4PR11MB6165.namprd11.prod.outlook.com (2603:10b6:8:ae::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8466.14; Tue, 18 Feb 2025 13:01:15 +0000
Received: from IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::8f29:c6c9:9eb2:6392]) by IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::8f29:c6c9:9eb2:6392%7]) with mapi id 15.20.8445.017; Tue, 18 Feb 2025
 13:01:15 +0000
Date: Tue, 18 Feb 2025 14:01:09 +0100
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Suman Ghosh <sumang@marvell.com>
CC: <horms@kernel.org>, <sgoutham@marvell.com>, <gakula@marvell.com>,
	<sbhatta@marvell.com>, <hkelam@marvell.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<lcherian@marvell.com>, <jerinj@marvell.com>, <john.fastabend@gmail.com>,
	<bbhushan2@marvell.com>, <hawk@kernel.org>, <andrew+netdev@lunn.ch>,
	<ast@kernel.org>, <daniel@iogearbox.net>, <bpf@vger.kernel.org>,
	<larysa.zaremba@intel.com>
Subject: Re: [net-next PATCH v6 6/6] octeontx2-pf: AF_XDP zero copy transmit
 support
Message-ID: <Z7SEleIJ636O+XZI@boxer>
References: <20250213053141.2833254-1-sumang@marvell.com>
 <20250213053141.2833254-7-sumang@marvell.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250213053141.2833254-7-sumang@marvell.com>
X-ClientProxiedBy: DB6PR0301CA0069.eurprd03.prod.outlook.com
 (2603:10a6:6:30::16) To IA1PR11MB6097.namprd11.prod.outlook.com
 (2603:10b6:208:3d7::17)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB6097:EE_|DM4PR11MB6165:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ab6637c-0b46-4d9c-7845-08dd501c53c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?zQj5pPqDIZso+eHbJOXbR2BklNadjq6nFMqcqUiZykh1SXwmkIyPXvVeieMn?=
 =?us-ascii?Q?eliebBR91L4YCtwGQoUOqVves1/pzfWN9I+AZa9avg6+BfkunYyzM0I7klbY?=
 =?us-ascii?Q?YQ0GNuSzrgq+dCjzWu8/meCbsHNnevstUKZK4buO9MiIyFsaW7yNYk9J3NCX?=
 =?us-ascii?Q?OH2zYZlahu3oumoGQsfZHEKtLXOhN1tmLQzaTHyqgA/8B12ZY5XlpPqukr/P?=
 =?us-ascii?Q?6hhB7Rotu3CU/pYi1PQNvZ0h5Y6JQ2FfzRvSMO3rrzNq7r7WFcp5ol0prYvA?=
 =?us-ascii?Q?02crE0enOyT06JdiZUwGcziCGEKyziMXZqCIKP80/PjsMztxlvyw2hx82vNp?=
 =?us-ascii?Q?3VS3SOdAhoVLEYoakpybfQNDX9C78tZUm1oQmTjoICKczvYSQyybFkWTRbjz?=
 =?us-ascii?Q?xuEuXkdwtFQNxSBeIXpW5d/bMCYO88kt5J/0SFgL7VRz946q1K78l3FvAb2M?=
 =?us-ascii?Q?OVIevrHY7Xo2yJYhGrmx+aobmA7ADKXnzePl5phpZne27aJg1RZo2V+31fFq?=
 =?us-ascii?Q?pxT+jhPHYOYitJ4WIiNRXICZdSv5U1d8gDC3qfHhEc5PwILwm7wA6r0yNNsM?=
 =?us-ascii?Q?QHNJptY4w4IJzERXdFkIWXnPHu84J4j8nUb5z/w7/Gf6PhXe7fpYuJvpSAF0?=
 =?us-ascii?Q?Q8ULLi7M9hEfiKXaZY+OBsR2u66BwcS2BPD1wGbuwrDHKq1tcrvv/QhgdFXa?=
 =?us-ascii?Q?EXLBPN/RSbr0geSwlndyB7BrgvLBKWgf7G5M9qRzKptmPeUpUNnUPlSaoewi?=
 =?us-ascii?Q?hFDICxs5kgBXXwK8a1JHwm4NM5IQvzxFn/7dLp/yvcCwuAQAyQpvsEa223Mx?=
 =?us-ascii?Q?jNtV00BsK9sLWavOS/a62KZzYLJpj0GAU4c+SIz5yg2fh+HG7g9a3xEWeCr0?=
 =?us-ascii?Q?PZg+OiCNsi1SFpOrzvScI/KisgY/c82QCmrMK70gAab9Vf5LFtY58hLty0bB?=
 =?us-ascii?Q?yFS+NErWdBUbhdgMQ6QtM04gyUwSgcnKWCqDLMSehqDq8LX+tYhWBuZ2MCf6?=
 =?us-ascii?Q?qt2eMlOIow2PCBByqUMJqjx0KbIGt+j/4RJ6396+qLoeB/KyZkglZXfCrrDM?=
 =?us-ascii?Q?pCTf86VnQOeHtDGvLKn/90Z2QEx8qXC5TYK44n+vijKN30BNLM1wGhlNV7dC?=
 =?us-ascii?Q?5+jTCAVSSAT8UbvKqCRMauqvkaFpYWtY3oUEFPz556BNsucpOKviLaoqX/TX?=
 =?us-ascii?Q?j8pl0QGyZsPkFi6vdLX0Zffo3uCJgsi9lyrXI4uYh2SsNagFd+Sn0/epxzjK?=
 =?us-ascii?Q?opseD41jKkNUzGt3b8WVTcAvqPjSTx1yfSoEAU5ks+eGu+TYx1bhLq6D2Qt1?=
 =?us-ascii?Q?LSc9FVP6C8UoeT3SJho/rmxfrIOpfbkvYIDGgSFwmPaUiJwyKNP8KPjsWzS0?=
 =?us-ascii?Q?GpYIfTGvn9WYGTAZNNikAi94Aeu+?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6097.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mTTXPPPjc+RRONEuM/RKMsvMe95XZdMU8FI2k4YKqjQVRG5FIM0OuaNlQFf9?=
 =?us-ascii?Q?D1+L8V7RRS7tsQBf2NjiktDe4NxZtn2rbERImtscGzzPWm/zvEWu5KChX6HQ?=
 =?us-ascii?Q?M/3aeguBrDbZuPAdvsVVDyunBqSms7T3QHx7e8Gu8HksoKRcSYhw2cYOoNnI?=
 =?us-ascii?Q?JqN8CNR7sQBUTABo6K2u5vBRxH3irmYz2xGFs2OBG2idPl7YLUHLjgYAYq04?=
 =?us-ascii?Q?YpCcIqirdRlp3TsSNPu5dVMcgQeM4ts3/6iRR+opaFmfmvphEIWdk0jvnCUR?=
 =?us-ascii?Q?Cw/APvSQ1mpvA8WfyKTibpaN8gToSRskIvq4/60SlJCl+ZLzwwPTzGwIRwFf?=
 =?us-ascii?Q?k2mc8ZW6KxNoPsjPdz4u57F7CI8srn7coKCscCpYmTzoXPohZbeP1JlnFzee?=
 =?us-ascii?Q?ZQuZ0RKU+hcX5CYlUTEXmwBeeVT+fBMpa7lcY48om95hPqiOt4CPLvzW8kKa?=
 =?us-ascii?Q?DHU3oDM6NW3PxIPZOwE4r6BmMJO/o9Bx9ZUGQe+Ox9H1NW78Yhm3mAssBmZS?=
 =?us-ascii?Q?ntc8x8NXLaQT+EeMOJJKbaynpeFlR5BZNd77GvRe1vJCIAjOxXVH8SFAFybd?=
 =?us-ascii?Q?Mg1JMpwSBwF+IxlN76AMBjthDY3OcYF6aoW+dnY1M/StFXdqG04AGyYr1R16?=
 =?us-ascii?Q?npvdg+9wQkfCKA5ViAi60AoVBnByOgJMd5GTuJQi14TcKlJkV8qljo4G4nLD?=
 =?us-ascii?Q?IldaPZod8fUh+eq6fACFTljWRCEqO/RMNLUf+XBpUnT6DJi7TLD0KJsUxNel?=
 =?us-ascii?Q?+9HQogXG6AfthD69nxBZYSmE69oVUE+gLFniq+MiKZ3tPEodNNPdKsfehgQ6?=
 =?us-ascii?Q?RjFeWZSBOvL3tnJTpsGAEnY4zEGRDXDFHEC9StQvvqlRZkAzF1rFy3sIOhpF?=
 =?us-ascii?Q?BfYgrBAO3+uHpANiTK5ChVTSNNfWsTQr7LbAPGN4HShBNr4Aoi2VIxQFzX9f?=
 =?us-ascii?Q?/gCYUuSVRQem/iYqHk6nLMrVeeGmsO4toVl6DKzOoG/KA3BCeVRzWbyRXCuz?=
 =?us-ascii?Q?r8mTRdssJ+EA/5Tp2Bk92r3nnxLyTSxiRkN3A0C7Badj85xWJfOt+f+w9Mzw?=
 =?us-ascii?Q?m8KnVphZY85FLg1dJgENJ25WNU3D5O5eASwu6DcwvYEoQf3sg6FiCm6HTPPL?=
 =?us-ascii?Q?byQSO9ZHEn9F5du+phURKYXkTyQna3gU3lGKp7X1vIpxXVl0tFYVgTe68J/O?=
 =?us-ascii?Q?qtHwxLI6vYMcZTPH0e+BSsTxXhAxoxAY/Aj9oFHB3P8PPV0AMeRL0T0Fj5gk?=
 =?us-ascii?Q?5yVDiu5IQIbPQQ7CjOy+AUWhk0CF7qnAON9LKYCHi1nHmFhIOTgtsalmnDbI?=
 =?us-ascii?Q?S/UEHCQOf6xTC6EUm52SJetlJVks5FWNZ5pEuAHC0VpHptwLS0Et0arC3X+8?=
 =?us-ascii?Q?+O/uQFIni4LGSPXkOh4siFTQw3h5fAo5yeNmZshRM1B6O3Ah5wqtOjVSna7+?=
 =?us-ascii?Q?FBooiiLxBDXTch+4QGrDrwzJGcdq73jRbCXrR3jP/SglxfvnIdQditKo+I2B?=
 =?us-ascii?Q?PZcf2mGyb4YXcDDtJBy3IUKJNCFZCzx3rQChpe+GpsR5UOrFK4WKPqpjHcm5?=
 =?us-ascii?Q?8MVZWs8WlQ8q/LqjnSDnt6oGa14gYMo6xfshDnDuEtKsoZRfoFGWUD60SChL?=
 =?us-ascii?Q?YQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ab6637c-0b46-4d9c-7845-08dd501c53c0
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6097.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2025 13:01:15.2364
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lcQsbruGqBD9v3VzAT5mCKWNUKNEtMH8rLcjQwxUkKZvwxYmGXfdrUwTwij2DQRTXVWWCdR/BvDEHG2S9g/pvWTpisDyJEOAeS/vJ4jIhdk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6165
X-OriginatorOrg: intel.com

On Thu, Feb 13, 2025 at 11:01:41AM +0530, Suman Ghosh wrote:
> This patch implements below changes,
> 
> 1. To avoid concurrency with normal traffic uses
>    XDP queues.
> 2. Since there are chances that XDP and AF_XDP can
>    fall under same queue uses separate flags to handle
>    dma buffers.
> 
> Signed-off-by: Hariprasad Kelam <hkelam@marvell.com>
> Signed-off-by: Suman Ghosh <sumang@marvell.com>
> ---

[...]

> +void otx2_zc_napi_handler(struct otx2_nic *pfvf, struct xsk_buff_pool *pool,
> +			  int queue, int budget)
> +{
> +	struct xdp_desc *xdp_desc = pool->tx_descs;
> +	int err, i, work_done = 0, batch;
> +
> +	budget = min(budget, otx2_read_free_sqe(pfvf, queue));
> +	batch = xsk_tx_peek_release_desc_batch(pool, budget);
> +	if (!batch)
> +		return;
> +
> +	for (i = 0; i < batch; i++) {
> +		dma_addr_t dma_addr;
> +
> +		dma_addr = xsk_buff_raw_get_dma(pool, xdp_desc[i].addr);
> +		err = otx2_xdp_sq_append_pkt(pfvf, NULL, dma_addr, xdp_desc[i].len,
> +					     queue, OTX2_AF_XDP_FRAME);
> +		if (!err) {
> +			netdev_err(pfvf->netdev, "AF_XDP: Unable to transfer packet err%d\n", err);
> +			break;
> +		}
> +		work_done++;
> +	}
> +
> +	if (work_done)
> +		xsk_tx_release(pool);

this is broken actually. the batch api you're using above is doing tx
release internally for you.

Sorry for not catching this earlier but i was never CCed in this series.

> +}
> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_xsk.h b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_xsk.h
> index 022b3433edbb..8047fafee8fe 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_xsk.h
> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_xsk.h
> @@ -17,5 +17,8 @@ int otx2_xsk_pool_disable(struct otx2_nic *pf, u16 qid);
>  int otx2_xsk_pool_alloc_buf(struct otx2_nic *pfvf, struct otx2_pool *pool,
>  			    dma_addr_t *dma, int idx);
>  int otx2_xsk_wakeup(struct net_device *dev, u32 queue_id, u32 flags);
> +void otx2_zc_napi_handler(struct otx2_nic *pfvf, struct xsk_buff_pool *pool,
> +			  int queue, int budget);
> +void otx2_attach_xsk_buff(struct otx2_nic *pfvf, struct otx2_snd_queue *sq, int qidx);
>  
>  #endif /* OTX2_XSK_H */
> -- 
> 2.25.1
> 
> 

