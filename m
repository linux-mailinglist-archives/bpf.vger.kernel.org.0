Return-Path: <bpf+bounces-31924-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B3049052F1
	for <lists+bpf@lfdr.de>; Wed, 12 Jun 2024 14:50:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 125B2B2180D
	for <lists+bpf@lfdr.de>; Wed, 12 Jun 2024 12:50:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57753175541;
	Wed, 12 Jun 2024 12:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Q2H+Qu22"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A2B516FF58;
	Wed, 12 Jun 2024 12:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718196618; cv=fail; b=f2X+EyYMAWWfOHQhZmgeY5CDevsE6HiqpTKocoFK+Qrq9ebuRRW9mxR9G5yW8U3d9o+2AqpGmnAzn6DBhqBcqpoxrLWKI1h+1/k3X9uZTx4zKX12WVnUlxgIxAdBArX8z1dr5RVXoirNl56u/R440g8QvZvSokC0Bv9/SzsW++M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718196618; c=relaxed/simple;
	bh=af39E5Umm/oifoCBrawhFJPk4u04I4aZ187nCs3q1v8=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=R6FhVd385gzwq+Bnqv5MgtwT4/Gc4z4VONbBdQ2ujJ7RLIgSErpz4WQb0S2T/EgM572jjiXz279TVmZYU8YJnZL2yQWSEN1CTkRG7/+humllhogjFNFzv98FfsJhJqcyPv6ID1D5iyzWDzn41EfcG1DuqF0Ns5FPGNOJMz7lphI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Q2H+Qu22; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718196617; x=1749732617;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=af39E5Umm/oifoCBrawhFJPk4u04I4aZ187nCs3q1v8=;
  b=Q2H+Qu22b1hBaqDp+Sp99ujF3PoQsU3kGtronIcmZvtmpagCVQhpqJNb
   DSGHd+4ZJhAh13XVX+k29iV8VFsI8A7L8KRdkRWzHofX0eXjdN3Dk7PJy
   FpyesaMebadhu6EBA0gsQf+KgnRM81eZpzrX8RHVzVJdxIWn3FTNvk5rk
   ULHYP3TZH01TqhghL4x+tor+eceBSK6u48ivDAlu9dK9bczrAWlxhp+af
   HxdCRGd5z8V/HmVek3heAKRuSdwri7aW1cqxgCI9PyU63OCJDKvXjv1jf
   Hsp8JP7y9vimV58xrogA299+k1QmDvaLtrJc3gRLfj/Hweu3qgvLXwbob
   g==;
X-CSE-ConnectionGUID: Tj0+diulRzi13WLlaxWdZw==
X-CSE-MsgGUID: kTj69Q/ORpGRGGvgkMNFxA==
X-IronPort-AV: E=McAfee;i="6700,10204,11101"; a="17879439"
X-IronPort-AV: E=Sophos;i="6.08,233,1712646000"; 
   d="scan'208";a="17879439"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2024 05:50:16 -0700
X-CSE-ConnectionGUID: ZFWMUid4R368jZR4ea9JZA==
X-CSE-MsgGUID: 5PKCWxZCQaGV/4nAGrcNIA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,233,1712646000"; 
   d="scan'208";a="44170316"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Jun 2024 05:50:16 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 12 Jun 2024 05:50:15 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 12 Jun 2024 05:50:15 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 12 Jun 2024 05:50:15 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.41) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 12 Jun 2024 05:50:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KSwFRYJRm9xx5d1LQmDB1Wbqo0pwOSk9VG4Xbm9mOWXP3gK3IibtcnVIN8sNLREoTSzHawQ8H64FgQoLbTGw2mpfcJPDkgZYClNlCQjwt6582mQEzsw09SPOt5+ffF5LMeOzLafNA59JI5H3DzqzzSc5vPHVIhQFrkuQ9+NdcxtqyL08AUS+h7F35x3eJel2XMZz8fNtmSlVw1dhUAOowe2MFO1LboN9ngCzNTbB2ROMJcQleceJnyliADTC3VpysKzZWlwv4RLEbx+ovZSM1hdFDmuKxjFrKCKoT+S7is4iYnQxl3FJ5g/djcKnuEtgrywmohbveZy5oNfrDwTzFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RfI2BSnHJbfy2MlTgGhIExZIEbjY1xHosspeZ4++E94=;
 b=cgCN982bSldOktNQRLGgJr0n84+PUEU5ag2sTxVj/IsikvAUNp5RYlGS/htzqnuZMZVHX64hu23RASh1ntnlLpTsQzkKLGr81Yp9wgLRzXvUxg0HmhJY19NVI1EvsDcR+t7b02bL60G1mVFTqkWb1vbVNVfy2FrcCLTAJY717QHnMHuhQBgKRGoPYooFxqpINqiATuN3yLuaTgbixyqVSC39pco86kObHBhlpIMTKntyEuRr17GMz/fnXyv30k5ejAZkmAxT+HEN4Se5Rz1y7X6kjWtTKvVcnMhXd5Qz2szARN3pkiX7UsN8ht5wK/Ov0FAbqNKIGtee56CIUN3zKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 CH0PR11MB8215.namprd11.prod.outlook.com (2603:10b6:610:182::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.37; Wed, 12 Jun
 2024 12:50:13 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca%7]) with mapi id 15.20.7633.037; Wed, 12 Jun 2024
 12:50:13 +0000
Date: Wed, 12 Jun 2024 14:49:39 +0200
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Magnus Karlsson <magnus.karlsson@gmail.com>
CC: YiFei Zhu <zhuyifei@google.com>, <netdev@vger.kernel.org>,
	<bpf@vger.kernel.org>, =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>,
	Magnus Karlsson <magnus.karlsson@intel.com>, Jonathan Lemon
	<jonathan.lemon@gmail.com>, Alexei Starovoitov <ast@kernel.org>, "Daniel
 Borkmann" <daniel@iogearbox.net>, "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko
	<andrii@kernel.org>, Stanislav Fomichev <sdf@google.com>, Willem de Bruijn
	<willemb@google.com>
Subject: Re: [RFC PATCH net-next 0/3] selftests: Add AF_XDP functionality test
Message-ID: <ZmmZY3zim4wG7pHR@boxer>
References: <cover.1718138187.git.zhuyifei@google.com>
 <CAJ8uoz2-Kt2o-v3CuLpf2VDv2VtUJL2T307rp04di5hY2ihYHg@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAJ8uoz2-Kt2o-v3CuLpf2VDv2VtUJL2T307rp04di5hY2ihYHg@mail.gmail.com>
X-ClientProxiedBy: VI1PR03CA0048.eurprd03.prod.outlook.com
 (2603:10a6:803:50::19) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|CH0PR11MB8215:EE_
X-MS-Office365-Filtering-Correlation-Id: 8846b9db-85b1-4aac-8464-08dc8ade27e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230032|1800799016|366008|376006|7416006;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Hl3fY27tE/Al+ULAIw5H+beeRbxxyNxJoUTPH5F/t0Ed6OYYnAACX0InDqB1?=
 =?us-ascii?Q?ejgdq2be+DFSNpOz4khX0pvNU+Zqa6K3puL4EOy7C36ROkd22m20Gsa2ZAdl?=
 =?us-ascii?Q?CGjRtZBuU5314Q760BLMSuYq5y88Bu4AA8NdR/WjKL9QgY8E9zDwNFApv1r7?=
 =?us-ascii?Q?ndGXw5ITpXsaGXXRMoBP3FuLguanDk3UxluJ1PeMiW06RHNxwHx6R+KRa/5J?=
 =?us-ascii?Q?KGV1uSNm4IBXg/sbS7hpfW3/ig+KTb4TJU2G6WlSjG1v1epYhoiNCWxcnV2Q?=
 =?us-ascii?Q?VhbbrNT+J7Y6SBE1J+NsVBrlZFdJ/t9s+baoN81kqMy73TJjIs3CBP7DNZNG?=
 =?us-ascii?Q?Jx81Ewj29LkI/xoYTMEbfXPQ5HEBqcdox3x9n7mWtrC8g1su0Pqk4A3cDOLq?=
 =?us-ascii?Q?k5dWC8z8dZs8YdPbCDvK78lIevAGXJ1gns8Jd/GzwmXh8BmFJZvbHq0bygMl?=
 =?us-ascii?Q?WyuVtWQWd+IOgUBRsY/Ey0ED2qwn7Iu+hmEuX1dWXx1iG9nqi8fH6Xew4Por?=
 =?us-ascii?Q?dO27u3meOsSPWSiW2auvdfcdqBUaEuhvs0ZDDpQz/WPow/Wf7Th9X6p8m7aD?=
 =?us-ascii?Q?w5U/8EkIkopjTHL9VosnWwm7PnvHHrFeMcXDzr23NSOkamGApByIwpFeP2xv?=
 =?us-ascii?Q?wkDQvOJtTs8tCE/k2nF8Q3J4gTshH2mYjiE5/i/Do9R5XUE7EjspKW5aXZzK?=
 =?us-ascii?Q?LlMJNZMAcUrbBcHsmeyGNMBhorD0tadtOt9r3PqGFBzZo7J9COy+lY/exnmv?=
 =?us-ascii?Q?sPbyFg8DDZ+KPGi6cEFlpaVMwvVYWULu5zlheT4t0zx/ue9DWbSBPzY3JZ5X?=
 =?us-ascii?Q?Vj1F6/86m2urYgCbIGrFpbX6hKtrIu73KRI7fngebc2dFQ+v4cQl0thiT1Ou?=
 =?us-ascii?Q?bYUmxbn3PmcF8/k/1timFUr5ThYUFr7kaJ5xxzrrtnnejWfHcowjPbTvakLh?=
 =?us-ascii?Q?3pT18kbn5Cn2THpIdVvfkciaKjf62iiGYsIeHWi3vTssR5wxrvCDXQyDPmfG?=
 =?us-ascii?Q?Dp5bGzbXokw9iiKYc/nigDi+qXmjT/63kvBF6ivJbzF3gPL1PVPmvXjz1g4j?=
 =?us-ascii?Q?Ik3/uRsVYXzwd+G+45n1D+ugZV+bWgjPNnKQvV+ZVRcaBKMI9a4d/JbxDSax?=
 =?us-ascii?Q?jHzSnrnkHreeaCbcX+Ty8dXm2Wg6FRdVSsjwAXyP6hrhFYcONHXS80WNdNj2?=
 =?us-ascii?Q?wtE2tuCVM+9MF1UNrTBuyc7qMcysI775L7P+VJmyrpDoACpJ5oombhopkcol?=
 =?us-ascii?Q?EqnAUbzWiz/iqgHiwoq7GM2Tj7AkzBs34WouwY7s8HxyYZhQ2l/YoGhIe2tR?=
 =?us-ascii?Q?h3MjBV341yrM99sJgshsEtu1?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230032)(1800799016)(366008)(376006)(7416006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?eHEmBQgLJd4Y9/R+dYcVcSdy4/f63L280HKS5rkIbqmxFLOJDVyKawXdgmfl?=
 =?us-ascii?Q?0j0jSPShdydCPVXIpuDI0OdVnYfAQ/agyCS+MhcqdHKxajcohl7AvvKJnq5n?=
 =?us-ascii?Q?ATHqyqqDPW8yR2yQBiKXJrTw6NbiDOUf3ACy359mTE8lQDJjK87HILCkvTxj?=
 =?us-ascii?Q?YMZI5fUAll/COY0IMMsGVMM6jSUnuMbQYNkvnJb3T44mb1udg6i/yVrrvwn/?=
 =?us-ascii?Q?ts9KmX/NJ0Qwx2ERUCd80Czkxgzi78w8GGqqwfiDg+8y+I6/Nw5zoXtG0p6D?=
 =?us-ascii?Q?Los89G2LSd1XjrgQVCTV7hss1nsxEXuYObMxEF0xk12S198v8CgW639j5/JP?=
 =?us-ascii?Q?RCawCTsqfRGv5ehNaA1WQ5A0l006w32ETznXAATxEz4shY9nn4DcPya1ln/f?=
 =?us-ascii?Q?DR11c93luE6vFRyY7qmNrJY9dIvoLnSa2nl3taEoeJ2PO5S67Yygx+1CapSH?=
 =?us-ascii?Q?juWA8szW3SU/djsn6prsdkzKDwPE/Htf/PiluQHlZrBh6FVJUpybUCctQFfJ?=
 =?us-ascii?Q?cvnhI1mt6Zfc3QdvFuozPURN4siYm8r+iBTlZ9SD2tosPwAWJIN29YLMbbfA?=
 =?us-ascii?Q?iEI3BLDsITTbh03+eKQXVYai/aMQjkEcztzLePd8YXdDuFweyPKl8Fao9Fhx?=
 =?us-ascii?Q?sFlJjvpFLMytwEzfqoTRXfwGgse87heMZHg5R1Q9ohvuTbb29kahIHnq+5Gp?=
 =?us-ascii?Q?rWhG/d+z4ZiUt5tYngh9IjHRUg3dXa2qjlvG/MkqkLOSFUyIo0Zj0lHEexPZ?=
 =?us-ascii?Q?EgfDDp8z+xN0hP0u7CPTkQa1R4YL5Xken0pvgCOOM+yoSRYvk7dWmQMR4cmR?=
 =?us-ascii?Q?adGFJ0DvRgaUKHD+DiiqmRnKXL7OS8T6OVesTISz88BVr8QoJ1Fm7k0ICrQ2?=
 =?us-ascii?Q?f1ECYhpRSv/ZryxZlaEH8siJlnPQ/sBpG967Mv7d5/XK7k0ywjglgWx5XuPm?=
 =?us-ascii?Q?5gerh7fz00BcU8TkIHeq1Qsiq7Bcr0tR/6TPCBkqiLuv8XH9dbn8XpSgysiV?=
 =?us-ascii?Q?5JZIgfJsL7UPlrYRuvbM5EepjDUfPh041LdJjdXPmNY0JK/kG3BGO1/6fDqT?=
 =?us-ascii?Q?aKo+gB8UlZ/i9VHAXSd6zh9dX2g1YR4piagFz4TV9HuvXVB/TwHuXRj1DOxd?=
 =?us-ascii?Q?q5KWt04Q1/pHJ+col/P+SIFpTngEJJKQA8cFsjf1YLtYJ9kco2cxfQ5CiQhA?=
 =?us-ascii?Q?nuD+OwQS3lwi02bl09ZZKXfWcL/ZzycwZQIlrpimMGBL7MinWcXgGf3TN0CY?=
 =?us-ascii?Q?okRhndp/lk3ifYuQm7l285oT2eIYE+RoCzwU1n3o88WunfO5Gg9+vZBlZjcf?=
 =?us-ascii?Q?ETGlFRxC7F06xbUySxRKl5cj89a4ZUMoPRdKK/EV6VG8W+Kaposh1+kVQYp1?=
 =?us-ascii?Q?jgCQIfqE+BU+TuS9cDm0HddtwjjEr3s3sRXAbuL//jBecc7FnNbCf/hrW4wi?=
 =?us-ascii?Q?3SglA4hKrRt2fr0vwIydmdUbbpiHQ0Uc+indnb99lLWl6r248+BVEJp6MRgq?=
 =?us-ascii?Q?nd92eeMUj3ybP1+uqRIQ0bxoqpB1XmwpPqE2O3amkFhox1XCPMWDGGCjG2t4?=
 =?us-ascii?Q?dRy0Kaz9a+10rV6cKPyb6VId2x5z7o7pMs0QRsN8cj4j2Ek/AlNKkhijvMfh?=
 =?us-ascii?Q?mg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8846b9db-85b1-4aac-8464-08dc8ade27e6
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2024 12:50:12.9376
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ua59NVnBT5YNygw3PD7HvlblXYkowTKYFr2fRGNaJTM4mqzXVqLEqTaLVHpkfH2GhOAYgkKagp5HaF/2PeydYQFah2NPUOmxOjRhMl94Jfo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB8215
X-OriginatorOrg: intel.com

On Wed, Jun 12, 2024 at 01:47:06PM +0200, Magnus Karlsson wrote:
> On Tue, 11 Jun 2024 at 22:43, YiFei Zhu <zhuyifei@google.com> wrote:
> >
> > We have observed that hardware NIC drivers may have faulty AF_XDP
> > implementations, and there seem to be a lack of a test of various modes
> > in which AF_XDP could run. This series adds a test to verify that NIC
> > drivers implements many AF_XDP features by performing a send / receive
> > of a single UDP packet.
> >
> > I put the C code of the test under selftests/bpf because I'm not really
> > sure how I'd build the BPF-related code without the selftests/bpf
> > build infrastructure.
> 
> Happy to see that you are contributing a number of new tests. Would it
> be possible for you to integrate this into the xskxceiver framework?
> You can find that in selftests/bpf too. By default, it will run its
> tests using veth, but if you provide an interface name after the -i
> option, it will run the tests over a real interface. I put the NIC in
> loopback mode to use this feature, but feel free to add a new mode if
> necessary. A lot of the setup and data plane code that you add already
> exists in xskxceiver, so I would prefer if you could reuse it. Your
> tests are new though and they would be valuable to have.

+1

I just don't believe that you guys were not aware that xskxceiver exist.
Please provide us a proper explanation/justification why this was not
fulfilling your needs and you decided to go with another test suite.

> 
> You could make the default packet that is sent in xskxceiver be the
> UDP packet that you want and then add all the other logic that you
> have to a number of new tests that you introduce.
> 
> > Tested on Google Cloud, with GVE:
> >
> >   $ sudo NETIF=ens4 REMOTE_TYPE=ssh \
> >     REMOTE_ARGS="root@10.138.15.235" \
> >     LOCAL_V4="10.138.15.234" \
> >     REMOTE_V4="10.138.15.235" \
> >     LOCAL_NEXTHOP_MAC="42:01:0a:8a:00:01" \
> >     REMOTE_NEXTHOP_MAC="42:01:0a:8a:00:01" \
> >     python3 xsk_hw.py
> >
> >   KTAP version 1
> >   1..22
> >   ok 1 xsk_hw.ipv4_basic
> >   ok 2 xsk_hw.ipv4_tx_skb_copy
> >   ok 3 xsk_hw.ipv4_tx_skb_copy_force_attach
> >   ok 4 xsk_hw.ipv4_rx_skb_copy
> >   ok 5 xsk_hw.ipv4_tx_drv_copy
> >   ok 6 xsk_hw.ipv4_tx_drv_copy_force_attach
> >   ok 7 xsk_hw.ipv4_rx_drv_copy
> >   [...]
> >   # Exception| STDERR: b'/tmp/zzfhcqkg/pbgodkgjxsk_hw: recv_pfpacket: Timeout\n'
> >   not ok 8 xsk_hw.ipv4_tx_drv_zerocopy
> >   ok 9 xsk_hw.ipv4_tx_drv_zerocopy_force_attach
> >   ok 10 xsk_hw.ipv4_rx_drv_zerocopy
> >   [...]
> >   # Exception| STDERR: b'/tmp/zzfhcqkg/pbgodkgjxsk_hw: connect sync client: max_retries\n'
> >   [...]
> >   # Exception| STDERR: b'/linux/tools/testing/selftests/bpf/xsk_hw: open_xsk: Device or resource busy\n'
> >   not ok 11 xsk_hw.ipv4_rx_drv_zerocopy_fill_after_bind
> >   ok 12 xsk_hw.ipv6_basic # SKIP Test requires IPv6 connectivity
> >   [...]
> >   ok 22 xsk_hw.ipv6_rx_drv_zerocopy_fill_after_bind # SKIP Test requires IPv6 connectivity
> >   # Totals: pass:9 fail:2 xfail:0 xpass:0 skip:11 error:0
> >
> > YiFei Zhu (3):
> >   selftests/bpf: Move rxq_num helper from xdp_hw_metadata to
> >     network_helpers
> >   selftests/bpf: Add xsk_hw AF_XDP functionality test
> >   selftests: drv-net: Add xsk_hw AF_XDP functionality test
> >
> >  tools/testing/selftests/bpf/.gitignore        |   1 +
> >  tools/testing/selftests/bpf/Makefile          |   7 +-
> >  tools/testing/selftests/bpf/network_helpers.c |  27 +
> >  tools/testing/selftests/bpf/network_helpers.h |  16 +
> >  tools/testing/selftests/bpf/progs/xsk_hw.c    |  72 ++
> >  tools/testing/selftests/bpf/xdp_hw_metadata.c |  27 +-
> >  tools/testing/selftests/bpf/xsk_hw.c          | 844 ++++++++++++++++++
> >  .../testing/selftests/drivers/net/hw/Makefile |   1 +
> >  .../selftests/drivers/net/hw/xsk_hw.py        | 133 +++
> >  9 files changed, 1102 insertions(+), 26 deletions(-)
> >  create mode 100644 tools/testing/selftests/bpf/progs/xsk_hw.c
> >  create mode 100644 tools/testing/selftests/bpf/xsk_hw.c
> >  create mode 100755 tools/testing/selftests/drivers/net/hw/xsk_hw.py
> >
> > --
> > 2.45.2.505.gda0bf45e8d-goog
> >
> >
> 

