Return-Path: <bpf+bounces-37161-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B5366951715
	for <lists+bpf@lfdr.de>; Wed, 14 Aug 2024 10:55:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 23703B276EC
	for <lists+bpf@lfdr.de>; Wed, 14 Aug 2024 08:55:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1C42142E9D;
	Wed, 14 Aug 2024 08:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Xbw0yqQl"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DA3E26AC6;
	Wed, 14 Aug 2024 08:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723625734; cv=fail; b=X+rsAJN5idF5s8lbXq3OfPrY9GzKf9RbNyWaEGa1gS8qnU+0r3eFAPqQ7QexaWukFNKqhbQtzcDeS0GdKU9xTTLiUucItvI5P3gkr1ruLxHG59Wb9dpoHXurXt/MrX8SiD/Z3qPrsRPlR0hXTvvbREBYDzwJl/6RDmCaqE7qGQ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723625734; c=relaxed/simple;
	bh=4gW8fSqbX479nv327A706fU2QHrlJI1qXIqrfOboQ/E=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=od50JANTkQto9Y8fklrvF+SH+RKVC9+Lw0t2c96l2ZWgf0Z80zRuuw7XZdMekup8f2quw3d0BrN/K+fhxDcoq/4zl174AzL6cCMohgE5zAdjyaSLNmiDk5C/6tBgpsL4Li/Phz/bVuyBJCwzLadiZNtt3sVEr7k6a30cUbTIthQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Xbw0yqQl; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723625733; x=1755161733;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=4gW8fSqbX479nv327A706fU2QHrlJI1qXIqrfOboQ/E=;
  b=Xbw0yqQlgXuj6Xb8yPpysp7VZQuhuTAwICbyetqcka5RpH1lLHULCVGT
   r0mXecO8DXfK+QFD6UVP5Jo9ZqyceY78Sd2KJyLeup0bWebcLqkjmNvk3
   b8HbFgoCFyYZGG1hMLIRMxoe2HKwCzQNB1xFG+AoQeRKNaM59C35A5ZbF
   jbSlT0/hWZfkJfhZMRJgWp4Xz0ryJ0o5QAVvxagZ9KJVqslNbhanliwBq
   HZq+SVoviH27ZTHXxEpcTdsVirb2Kw0jk49DEOQrvn7aN+sUawRp38BOX
   8y+9w9dlg8PPAaQPxPUZgLYN2UX1AKJ+2dETcyC8tn1zQ+RDpRr6/6nK/
   g==;
X-CSE-ConnectionGUID: sht9UmTdSFqUpfoXWr235g==
X-CSE-MsgGUID: +7K09krST1uxyg4D75DmtA==
X-IronPort-AV: E=McAfee;i="6700,10204,11163"; a="21699808"
X-IronPort-AV: E=Sophos;i="6.09,288,1716274800"; 
   d="scan'208";a="21699808"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2024 01:55:32 -0700
X-CSE-ConnectionGUID: IALwDFZOR6KOpMbhSoKuRw==
X-CSE-MsgGUID: O2fbG5ShSByiWiUC1jRKPA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,288,1716274800"; 
   d="scan'208";a="89641458"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Aug 2024 01:55:31 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 14 Aug 2024 01:55:30 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 14 Aug 2024 01:55:30 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.43) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 14 Aug 2024 01:55:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L8cIwdu0CxdNAyQhkqQf6yUKV2M8uDeC3HS/Gwl3ULEqSlKzA8gPEkRMyGc55LZjwIx7y9XT/Ar/6uRmS2T3z49n3VJ0lw3kJyhlan6HBIj1gDtdgtjOwQzOUxG3Poy0V83OgrW2RwUksvYMhsFEGNh1Z0qTW9kny8mxlFH+MP2SUiSO3nDPvrVIAzHIh9b7jws5snUTMuPW16zigdtEloNOC3nJf4+hJGQu9NRJWfF8NsfdbKGoNgAbhVbZ/WP22991q9fwznWrmBDzg/vth3i/aSSj6jnnmnuUQV1HTf3A2aOWe+GUjD1Yf5suZXXx+viRCozlel0BL0JtP2/RdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=up6A+dAOnKye+szGLJf9spkzoPnnA3SVMJwFbIbkNWY=;
 b=v+08r+HrLZvYAHu5gxY4SZAaa0wXTYeWD7syFca7O+kEGlJ3k3ZV4opqZJzqdUerZsPev2ON5NbyUGHAeIYJ76sbps8AhADcOnXmg8q2PG60Mmd5KW9ZF8v2oc+WWfZNOmrUxfJE17TDLdEFzUhYIKe3ZoMX/Y8FCpZIQjcWyngF0uEDOwaczQcRl6jvAob/7DAcWwAEwkEA4qdfmVMwr+LZ4Rbvwi0C6XamzaZB2kYldaSfGzxCbT5wKYITq1NRNdya+877eQTVaC7rGw9y3zObdZ+Md5meKgePCxYrLIaTpMlWrNPrPYLhzZHdsLZeQCNJ34b4FBs22uIF8VkS+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 CY8PR11MB7898.namprd11.prod.outlook.com (2603:10b6:930:7b::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7828.33; Wed, 14 Aug 2024 08:55:27 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca%4]) with mapi id 15.20.7875.016; Wed, 14 Aug 2024
 08:55:27 +0000
Date: Wed, 14 Aug 2024 10:55:20 +0200
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
Subject: Re: [PATCH net-next 4/4] igb: add AF_XDP zero-copy Tx support
Message-ID: <Zrxw+FI7rbYHXN2d@boxer>
References: <20240808183556.386397-1-anthony.l.nguyen@intel.com>
 <20240808183556.386397-5-anthony.l.nguyen@intel.com>
 <Zrd0vnsU2l0OTsvj@boxer>
 <874j7nzejz.fsf@kurt.kurt.home>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <874j7nzejz.fsf@kurt.kurt.home>
X-ClientProxiedBy: MI1P293CA0007.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:2::18) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|CY8PR11MB7898:EE_
X-MS-Office365-Filtering-Correlation-Id: 30bf5643-cf99-4daf-b07f-08dcbc3ed7fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ivSs/CG14e1ffGxqcQ/7A40bZtnY7G7Mkrdj1wfJqMIfCSqweFhOdNvFPHZW?=
 =?us-ascii?Q?Emob+iwmPT4dQu1mGKYdPSswx+Q5whrIPeG7iH9JpaVeDVYekiSJXgM7+khc?=
 =?us-ascii?Q?CoXMo0YTHL0/XrUFwvJjCvdPh90NPI0l7qEQA6oyuvV7YMVoopBnX+Uk1FxU?=
 =?us-ascii?Q?/00SftXsfu41qQeOUhoETNH2vUg6v2Qq3A189B4JHDci9Uzmb0z1PskLYpvF?=
 =?us-ascii?Q?KzZaBCBPEbBiPY60R+qgssayw1ZnmtBr8L01goL8xKji3khvs7gY5tSQT+4q?=
 =?us-ascii?Q?kIJvXHAw7TrzA8UZcpn7dB/e/xeWKIgBBwIyFT+nRqtXRxb2VRfFBJ9OtWoH?=
 =?us-ascii?Q?zGyOkw+06TnJrcX3tuU8OF//I3TWki0HRcwVsyc/DXffrOcUebWh+1Chyn+p?=
 =?us-ascii?Q?2EKUXYNFhLC944Vz3XHYYQd2uCFtY+IzDtxycMp2gDe7Bgp1p9LNqsUciz2w?=
 =?us-ascii?Q?1lfqysfW9VNszdZQPosQCzGMF4/GT86mzAHZeNEgh71CdwMMmuia5+qHV9aE?=
 =?us-ascii?Q?sqNnY51qDvZKLw73DqnNA1KGU0pSNidIWzvmgu9CGFIdUIpzMdw7Ew5Bet5P?=
 =?us-ascii?Q?xcpVgCerI4fjHpAcy9UbhUqtoSrM3tVCp0GE9vlPgLZ8Dtf5EnATLIcA52++?=
 =?us-ascii?Q?70tC2S2w6rZzEGRJ0mUBFXgwS63WS4fB9c/DbUzA4AaXM5PvzqRGFAP62egD?=
 =?us-ascii?Q?ME4NwaR/CEaCXPnIk1870X3sqtGFnqFoz5oizRooNU+GaF8xn2QC70Tlr25e?=
 =?us-ascii?Q?GccEWrDlj1YN66kjjqBL6EjeD/MirAjZxgY2C390u6C6J9eUSG77jVOmE0e3?=
 =?us-ascii?Q?2QLE69jx3arLjWNNeBRSpwZxov0oGiCbK69UF4gPZ7oMTQxXvCoIJVWTYgDF?=
 =?us-ascii?Q?qvdzHRv+H7vrIcvl60butJVTIaLLR/PpRYMBqbLPerbV5KiWQWiwuBqVthKy?=
 =?us-ascii?Q?s2jPqRZG/jR3Zf/5MTwodU6pqSutuHbFuH51NU/qR85gUmY4D3uGeESgL9YB?=
 =?us-ascii?Q?33mNLDL0l9WJGUh6tZ9/DktiJFhKnkFo71GdXp35xNR7OC6npjOK0kFtFMpi?=
 =?us-ascii?Q?FgbVxtcmxtVYXmo7xr7QOMoU/cuzkKMEfdZ6vN6ghumM9T2cx7eOwNCKkCP1?=
 =?us-ascii?Q?6Eu0JjNDG6x+mks1HG++lGI6rymqYaSFNveIMqsKIJ64Q3+A1UpmYneG6kl0?=
 =?us-ascii?Q?QFP1DQJORFrDyeF2rfYPNeKwWZDyC0TVXK0S34FL2tcbWJAVpAjguL2mJx+l?=
 =?us-ascii?Q?aXfFURLdbgcoHsC1pf79nRUo8fxqECbaLv/U9DnGfmFfuYzXl1s1OQcfCon1?=
 =?us-ascii?Q?1Jf8/Hn3pBup35HA9qYHLO0EXJubdljRlveGfuLslUv5bw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uNTDsnrSVUMXoyhucXUm4iGBb4zZ92EVy4jPJR/cuPeANpBATXStWmEo24j1?=
 =?us-ascii?Q?cLbc2VTdHHd3Bbj4/c9NycsujOCGut8/VhRZyPAn1L/sKra3+A+0vzXN0qtx?=
 =?us-ascii?Q?nlbJXfj+5adpv4N1lVT4Rz56hbq1JryTa6fYd3QuvAI4r1imxAZ1PJI+N6JJ?=
 =?us-ascii?Q?oZnQ2ZfewRwS7SOX2pP6tZs/PuzqnazuyUY0ugJ/XCYAJNtU4NMKlsom5WFy?=
 =?us-ascii?Q?8vXHzIWjCdXr8jUDPTgCl3JxkKmsExeS8PUo32uNwyccteeMl4u8lx+KT4eM?=
 =?us-ascii?Q?soAS/dqVmtQkqrkfMWLGUVxfyiixolaK0AGdoA7CNXwqhAVKgaPOOtucsbZG?=
 =?us-ascii?Q?nbCIwiRqeDF4zjox0rtsabZp3j5ISPYKpgw60A9DT7Ftk5fSdCmWbSortGyz?=
 =?us-ascii?Q?XPOKloHJ0nuDQw22vCDK3iRHZ6oJaFnySnYsqLDQofEV0cYMbCd3/qOTTi0w?=
 =?us-ascii?Q?CpwjoUtAbWx9gCT7xzNrTLHL1sVREg3t0K1Kh6at3J7z4iHR1gsmdZ2NJ5D/?=
 =?us-ascii?Q?FUhpa9zqs16OVL5YzYQa/JbKIDzNiPvqi8FvZEpSQTz5FXcfgZOu2yDIvqvU?=
 =?us-ascii?Q?9vOmqte6T8M6Y2BIi4QA9rEX3015T2lvC/JXXSH8h6FXZjcSyzH/OilxdUon?=
 =?us-ascii?Q?NYpzAsejNaFeWMyuDvpLH3w6dK8jTP891VJxGl81z5BhgO5UUUm92N8QlDzF?=
 =?us-ascii?Q?gH3jjqrrD6o7r8mVfIpvhzGwhd9gIb89BkIGZ5z4Q/N89PJ4onbaZn9Qnek0?=
 =?us-ascii?Q?S/Y6sR8bB2WhE6r2xYeENMmC+znUhEOTpRleFCmI+gpKqxzPW8SPdkQQewhz?=
 =?us-ascii?Q?rw1yfDsDWFA98qVf8W/J8fhqhUrhOVTc7egudrDUViJRAhvcAoZ+D+0UdxU1?=
 =?us-ascii?Q?Kjfr9Kq3iz0ECIcZ2S6nvb5OOhvc8J2ocwh7Wz0G1pfiIShFcUDuSocdOqGe?=
 =?us-ascii?Q?t9smpHAglRQE2XrdyVmhaNKafQNrxZNz5ivYnF1MX9A3dPHW31rAUBRtdLgL?=
 =?us-ascii?Q?ADl1R0FU2kzRJLGlpkojgVIGEJLBbZ52GIO0SJ/ZdqcHFZcN80CM9ysQXqzI?=
 =?us-ascii?Q?+4vxWqdYgCQ7ODTddLNka3Py3wyliU3Q50FJFn/Ogw6YdGWkP27evSZHVXTc?=
 =?us-ascii?Q?+vnALujJOE0O6nKnGuhKnar8XRSNks4R5aB4Dsn38x3dgn1XEeFlBqGtQFyt?=
 =?us-ascii?Q?BeoWLsNhlJVwnZMSSPPrVUl0HqNy47GdPn9AGNh8Iq0KQuxOXV2dJFE0olt2?=
 =?us-ascii?Q?q2/LTzOqYXN+GmAQPRLiaMjoI6hYDmKzRHoJeA7Jf0sP+bmr1HCRB7CEHzJx?=
 =?us-ascii?Q?bmUxFoK0DbuTjdvABzZg/NMAC8lQYP7qNsWuCcr5RtvfEwZkM+fGQh/KIXyD?=
 =?us-ascii?Q?VPS+sL/qVaBIxmqNREI6NKCXNNzKAaOfG992Z/BELZs+n2liR9rkkEWk3fWR?=
 =?us-ascii?Q?0Lwydicb8F6LyuDfjVezytc4waWiKDU/kb0ZsGPVS+D5AEUR37qtexzNZ2gM?=
 =?us-ascii?Q?JesIYYwpyShKspQfFWqTXQuyGXLNWFgq9oyU5y0842xF76nw4nYi9WYSgeiN?=
 =?us-ascii?Q?NDvJ3BYHzwQjL3mu7GwXKnIQl/Xv1jJzav8Nt7sKt0yNsjw1Q8RoYl7wZuuH?=
 =?us-ascii?Q?Ag=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 30bf5643-cf99-4daf-b07f-08dcbc3ed7fe
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2024 08:55:27.8613
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: teIh//YOm3X5YRi9ozmHCnQmrBVoHUW1O5Ibfh41hZEylFZn/l57bn2DUuNVzJZdfVjJ0QMfuL9bktoobKbqJOIfT/jZEjbEfY5P5E6lifQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7898
X-OriginatorOrg: intel.com

On Wed, Aug 14, 2024 at 10:36:32AM +0200, Kurt Kanzenbach wrote:
> On Sat Aug 10 2024, Maciej Fijalkowski wrote:
> >> +	nb_pkts = xsk_tx_peek_release_desc_batch(pool, budget);
> >> +	if (!nb_pkts)
> >> +		return true;
> >> +
> >> +	while (nb_pkts-- > 0) {
> >> +		dma = xsk_buff_raw_get_dma(pool, descs[i].addr);
> >> +		xsk_buff_raw_dma_sync_for_device(pool, dma, descs[i].len);
> >> +
> >> +		tx_buffer_info = &tx_ring->tx_buffer_info[tx_ring->next_to_use];
> >> +		tx_buffer_info->bytecount = descs[i].len;
> >> +		tx_buffer_info->type = IGB_TYPE_XSK;
> >> +		tx_buffer_info->xdpf = NULL;
> >> +		tx_buffer_info->gso_segs = 1;
> >> +		tx_buffer_info->time_stamp = jiffies;
> >> +
> >> +		tx_desc = IGB_TX_DESC(tx_ring, tx_ring->next_to_use);
> >> +		tx_desc->read.buffer_addr = cpu_to_le64(dma);
> >> +
> >> +		/* put descriptor type bits */
> >> +		cmd_type = E1000_ADVTXD_DTYP_DATA | E1000_ADVTXD_DCMD_DEXT |
> >> +			   E1000_ADVTXD_DCMD_IFCS;
> >> +		olinfo_status = descs[i].len << E1000_ADVTXD_PAYLEN_SHIFT;
> >> +
> >> +		cmd_type |= descs[i].len | IGB_TXD_DCMD;
> >
> > This is also sub-optimal as you are setting RS bit on each Tx descriptor,
> > which will in turn raise a lot of irqs. See how ice sets RS bit only on
> > last desc from a batch and then, on cleaning side, how it finds a
> > descriptor that is supposed to have DD bit written by HW.
> 
> I see your point. That requires changes to the cleaning side. However,
> igb_clean_tx_irq() is shared between normal and zero-copy path.

Ok if that's too much of a hassle then let's leave it as-is. I can address
that in some nearby future.

> 
> The amount of irqs can be also controlled by irq coalescing or even
> using busy polling. So I'd rather keep this implementation as simple as
> it is now.

That has nothing to do with what I was describing.

> 
> Thanks,
> Kurt



