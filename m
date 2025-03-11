Return-Path: <bpf+bounces-53867-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E9B2A5D256
	for <lists+bpf@lfdr.de>; Tue, 11 Mar 2025 23:12:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03BE83B45EC
	for <lists+bpf@lfdr.de>; Tue, 11 Mar 2025 22:11:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C805F264FBC;
	Tue, 11 Mar 2025 22:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nxd25GYc"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8A3025EF94;
	Tue, 11 Mar 2025 22:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741731120; cv=fail; b=k+0bnhJ/h/nIpjlI04dUOMsvAxJnO/joySVdb0yFKnb9WJxMZ+3rimEOVcwMbZQF92YLN238wvKLVdO0/LE/k9aF1e+OODJT7Y9UQPalkz3ybAV9VZa+d0kb5NJBHk8SDP51uZDsdultDiT5c/iFl56EXz9/pDJbmnSR6a+MwE8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741731120; c=relaxed/simple;
	bh=7omAehPEyAfBvNrpIVbIMXGFbQrLRK3+AxjkmUKUDDQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=QxRnCedgpustLJpnw2MK4wZW09t8rEjxBK+IEr3Wc+8fvbX2CKqQTqkCs+/XtAoynoo8lHaoPBBIQ798YS9RVT81RPqHbgls11rmx/kk9PKNli/BInrp46Tpe2aEfUcQS06amgpx1QL2UkR3j+8qvX0rBB3ykauuq2809Nu/amg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nxd25GYc; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741731118; x=1773267118;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=7omAehPEyAfBvNrpIVbIMXGFbQrLRK3+AxjkmUKUDDQ=;
  b=nxd25GYcz+NkSVNYveyDZlmui97swH7cfcU44GIV4o9W2DewMFRbalJ6
   ytEOx3yYvnuYCbTIy26jreBmy+qMw1pdnAa70lf+g0NnXIz1xLkuUkJ1E
   KmXVKIfaj/Ts6QmG5FN/lzmKn4hO8yakFJLRJWGSWwuba76y1O24+dGZo
   aScnoQhc7OVodCGrFP2h2jcZRVYpXt9z/Y8nGQz6vNJqQ434ipnhKlsXV
   rjSy7j/uydsialiIp/ECdZ8vftaGKuQYBJgB+pUU2ztXd2WMuBejpidXd
   NcYyOzQdA5tX8M6fEyqY4kwqruTqqtE8AK15kf3p+Ml9OXJ7KFhR4fZX/
   A==;
X-CSE-ConnectionGUID: iknflR6sQd6rsI/VuIxUcw==
X-CSE-MsgGUID: 7Chz1tY8RKSlwTIfIfGy/Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11370"; a="53433625"
X-IronPort-AV: E=Sophos;i="6.14,240,1736841600"; 
   d="scan'208";a="53433625"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2025 15:11:57 -0700
X-CSE-ConnectionGUID: y1ZGn25QQXWr7QxTU6gbag==
X-CSE-MsgGUID: ftz1Qr4GRguAMHxVubk5/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,240,1736841600"; 
   d="scan'208";a="120946085"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2025 15:11:58 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 11 Mar 2025 15:11:56 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 11 Mar 2025 15:11:56 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.170)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 11 Mar 2025 15:11:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yWf423Vtfo61WR6u19tjFxaHHPGWEwkkRptbe/SPO0QpYxBJzGqMkJaCclSp9S3SD7IWpng8aGsk9rL4fi9ogG9XJI+EYp+XoVQ3SvCuph65zZ2AbercEqXY7rwXCRUd4Uf7Hy30rhFEnMCt9njIt4td71fBVCJMNZxeBC0fwhO4lIUc5/FqbeAbZ4zh+cqg84+ixK5IvzgVZOo2VYPPIZRqiboKwLq89hwxZk6MZd6u60QEPoQRbGhTF9/6Dfu3YPpqZacb1vhkcyRb4Pq1wUZHrO0x3TBUhCvzv8GpYTBcRg2qVo7+Yj3z6eSplncH6HJ4FAhIQ48OfHCVxbqwjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v+Kroaw2YRi5Q7Ek8lJT2jWcQdD9ExxrG0wET11PWBA=;
 b=edRukgTM2utC7saQhEPWWzixkXj7LcJb1X9W7ve1l/i8NhYFLNeWc8AKFUQdVk4AdS25cpfyI6cFtUA5fFmAxM0uI6+IM14r6buEjV85+gbhmOlfW4qtns/L9m3IAnCvgfahzPSRdmWJdj2s3fgVhcbXAR5+Pn96+62D/42vAwhkHTpe9DVHKqzp1KI7NnUi4v8XfXxm562s/Zg9CyR7Wo0vmrI5i0xmAmHxH+6qYYfatMxF6Knl3ncSAMlqZFDcldUz5FLymiTF+kNS5JU8te+kjuCticpi+ikhddr3A2HjU8xywtrxqP1EYFIC7tqYDc5xd59o0+jDaKfVgUeA/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 CH3PR11MB8315.namprd11.prod.outlook.com (2603:10b6:610:17e::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8511.27; Tue, 11 Mar 2025 22:11:23 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca%3]) with mapi id 15.20.8511.026; Tue, 11 Mar 2025
 22:11:23 +0000
Date: Tue, 11 Mar 2025 23:11:11 +0100
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Tushar Vyavahare <tushar.vyavahare@intel.com>
CC: <bpf@vger.kernel.org>, <netdev@vger.kernel.org>, <bjorn@kernel.org>,
	<magnus.karlsson@intel.com>, <jonathan.lemon@gmail.com>,
	<davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<ast@kernel.org>, <daniel@iogearbox.net>, <tirthendu.sarkar@intel.com>
Subject: Re: [PATCH bpf-next v3 2/2] selftests/xsk: Add tail adjustment tests
 and support check
Message-ID: <Z9C0/2uFFQPGozkr@boxer>
References: <20250305141813.286906-1-tushar.vyavahare@intel.com>
 <20250305141813.286906-3-tushar.vyavahare@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250305141813.286906-3-tushar.vyavahare@intel.com>
X-ClientProxiedBy: MI1P293CA0024.ITAP293.PROD.OUTLOOK.COM (2603:10a6:290:3::6)
 To DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|CH3PR11MB8315:EE_
X-MS-Office365-Filtering-Correlation-Id: e781514d-154d-4339-f3d5-08dd60e9a8e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?oMHoqXwR6mRBIRXoxbHRhxxnFec63Hl7rU4SXXlyatpSwoqxJ87CnN6N10hB?=
 =?us-ascii?Q?Mz9JY4Dyg8UrI0UVQE2UtiIdTPBFdLNQgUqz2cFxiVEE9YtJrWSe3vlwt9HD?=
 =?us-ascii?Q?YL9pOK14CMo2b+f20u2msBT9nf3MGicghAk7jnsrUJZurLsVzCSXiK05grQN?=
 =?us-ascii?Q?0b2Jm76O6KEtW+oL3JllcZvTNqokIHjRSHNF4rhEqnrI3S0OiUs/cMoFlsC6?=
 =?us-ascii?Q?wQNg6vjj6+PYeZGZFo/cSPEBaZ+c477qUtvdN94sGnMkNJKKjimMbQOf06qA?=
 =?us-ascii?Q?2MQjFwZrZUVaHiZITM5tUiAys9t+bZM6T6V+H+EgwOsPGQ84RUrjaENCU6+g?=
 =?us-ascii?Q?XzZgwq+8SuhRtUX7M+ZTetXw63XKFf9XllC1ArTh+svNwlg4lTx08ncixwOy?=
 =?us-ascii?Q?RhFgw+5TXMwNU2mou0gxrg3tTotwd9aqupiHJESxtvEy+jlsioQzaoG7cc4G?=
 =?us-ascii?Q?JdifX82NyIR/uQCW3FQdGzska9pb9UKji35Rox/uDEZhd6wRWR7x3IWCnGC2?=
 =?us-ascii?Q?j0d7AXEDXMBSzXvGnyQYqb9+i4HoLUv7W5FoZrvdgtPhIYUPSaKQ3labwUbx?=
 =?us-ascii?Q?RaKYqLp372Tas1Z7sMPIiNoI9FtcfU/8QrdKj8FwglgmpXyVIzOYXZaO+Ijt?=
 =?us-ascii?Q?8PPXTY+PaR89ejl4gh6rkp6gUpkdKYhPg97XF65hqyKVgoxvZw2ZsbExy+5l?=
 =?us-ascii?Q?k8ptcaA7kFIHGOsTvggKDB4txKrUfT4RuEG+w/YV6ycmUMpdMgmmhdFzo3yr?=
 =?us-ascii?Q?9iiaT32JS/1n2LbuIJN3wOikIsCm+qQgIQL0DO31jsSiDwrkr2L4IIz/Exbc?=
 =?us-ascii?Q?9/vsN+wn0jhk3YpqsbPojk8hYTK4Aonz+a7NKu22sAhvr1eNV4zhXsYAK1f0?=
 =?us-ascii?Q?6KaEIGdwJkp37zhyYnUfBOyvwGpBcDT1k7MMsqQ/JZaDGSAUYtG5DXL2SQfT?=
 =?us-ascii?Q?iuR0GFM/T35G7kooxvoQgU2gL2B4JNA1kW2z7ZTFYOKAgac1yfnS9jEOnAC0?=
 =?us-ascii?Q?06rb1zfQ11F2ZdHvvkCZjQSSP5CSB0Qp9kbiIMYKGA+mzNdtGgdhgjFPjuH/?=
 =?us-ascii?Q?e243DKAFokTeqXQw+nlB3mAInr13yyh1ylTYdswAPRemG14vBtH/vK6Hat+X?=
 =?us-ascii?Q?q4gXv1pTCloAhy5tclzVtKBTgoyep2FPufZMtryS6LgO2B0HUQ8vktlhxLyG?=
 =?us-ascii?Q?28NTUvCmo0CT3t+hfIBW/vFDnfNmbCmPxx/C9sV7wKrbanAN4O0fCU+Upbbp?=
 =?us-ascii?Q?Sb3ZqOUYKIQBmm4wRu2BN1O0SwUevwWzaguhDIl8nYQrAK+iAJJxEKVL1z3c?=
 =?us-ascii?Q?s/sLBZCmgulhhtnR8+LiRFxjOYNrrwktKVLoTbrFl+Hfjip7AsEuMN9qrjes?=
 =?us-ascii?Q?kn36jsgmvmkbq9LgkmChUh1vEl4W?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uevSmu3apj0zgDI3PYhGK3kr/tWGKJ7tlBg0z5AgMS3hVJOIg1ODpKUC8qKP?=
 =?us-ascii?Q?kfZxDLtEYE4QnE1xQ2FR/j36L3NP8GfYhGP6QDTbYK00UCFTlAQX4JUtaeXz?=
 =?us-ascii?Q?dzCrFLfvPpP0mcLa8g7aTiwjn5HPuD5K34MXXNUxIc29JEt+iAJsk5gkkrcS?=
 =?us-ascii?Q?gCbZCjzhBE8wuWr7q0fvJ+4X6I+ZYr5i/MCYP1RC7ap1jFOxGS7JVtNSm2cP?=
 =?us-ascii?Q?aC3anEDLi+58HQ8wG7HFPBwWWvJn5HywrM9Y+bZiIbWHjMeYtupNfZqNjaL/?=
 =?us-ascii?Q?h+6j7AO5sU57M1d8DNu2myQCDSAiSiXXdk0LkyIxBwDlZq6yw1Z3XQKx1ciw?=
 =?us-ascii?Q?hfWVTjWD3CJ/EU1CwDRgPXBC9tU+Dnzh4xWUlodvzQftzobbNi57wOTw9NL+?=
 =?us-ascii?Q?eA/tkiDyt/tQhxuUG5LNUlhyyUAGJMHyJ2FWwtmRXkKHzzt8VfecUnjmE7ch?=
 =?us-ascii?Q?x/tgfoRhGBXmpPSy7Fe+hqGa5E9oXaSi8IVv9i0NbatjQQRMkwdt9JEtXhk7?=
 =?us-ascii?Q?1hGcCdkqir2teQMZtpTZAncMk49LScmWWwEtQZeYnC8ZP+mD20/fgRg2GRIm?=
 =?us-ascii?Q?aNM5ch+djQDq4+HYnkDUOoGME3h7ujTcxx7kEaqn6oE9WyFyB/Sfml5WirJf?=
 =?us-ascii?Q?Wj9unyRcTJEM6TvXugCWFgKcrOaOX+AlVUgiHx4wd5ZaZ5sylncKFvEcSmGT?=
 =?us-ascii?Q?OtZSH371NPC1h4xLO+QvkiDdoDSg8+TcIJAIZmDet1cMDD3ZMxzqDAa8F+NI?=
 =?us-ascii?Q?vgie8RGsLFsb4oIvdeTl07kS2Iy9Mwn5PR0j0DLPEzTSbFUbb7lMPFznNYlk?=
 =?us-ascii?Q?chD/nsSqTk966w1XQIiGlId+6By5hC5NhzwimfDewIBEK0Z9WUlmFv+aCjHR?=
 =?us-ascii?Q?yEU1h6FXrCXBZQ7vReA7dtm/k0Op1jJdfT0iVOh902fjuBIfw5o6qePfNqvx?=
 =?us-ascii?Q?fEYhsdjSsSbP5tRrqt8gq56roMARNlg4NTFKLrZi+WuDXDolZC/P6cWVgBRX?=
 =?us-ascii?Q?fubPF+x0V1jiFvmbZ/oyq0+sbiXjVYPGLUMAMT/smBFT9lfRSoVqvpoCGUvD?=
 =?us-ascii?Q?Wd91lD0WsbkVbnJFGy61PkjtGcJ65+7WZ9lfF6lFW0GC8IdIaTnBkSfVoCcY?=
 =?us-ascii?Q?rX/4Byg3gM3Q8YaUBuStPMjJPJOZ6WKNqqmX2e5ISsjNKH7hVy2Ob3mIDhoE?=
 =?us-ascii?Q?QVjvAkTREXHfCPW4spKldbl+1jsYVdilsjFh+uOUMgUmIcyOGHbdv/aoTJKB?=
 =?us-ascii?Q?M/9qk81yfvrWBPjEus1QHfGgSnkhhclJneZrevHZaynlYj3PqY4GQsvuPLuJ?=
 =?us-ascii?Q?zmkbFqIMpVX3EotLQPZ6yESWDHNqLtYIjbzYURVsK/UMOSlJkne6lF+a2pwW?=
 =?us-ascii?Q?dO3QJ1NtoR7GOyflS1EdUIZTQO4M4jxOHVIJvGJpJXuGNbVqAMiicF/O8JU1?=
 =?us-ascii?Q?PXQUg/05liQl5vng1oKGiurh6XTRiAvRWkhQshK/Mc1lmcRfrCs2c4G7XcNw?=
 =?us-ascii?Q?HEbdK+XOhyfAmbGq8o0BNO40pYl2dMG7eJgf7S9bsJmCyEJ7ZkPSpR2KtEeE?=
 =?us-ascii?Q?q2BVVhW0RHXGkfUqsl4kE5cusUMgc1cGPXDh6M38adwa0uvmvWM3kqF4PeOn?=
 =?us-ascii?Q?eA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e781514d-154d-4339-f3d5-08dd60e9a8e4
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2025 22:11:23.6807
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mFnF24pSOZ1CIZWttymb/x2MRJeYN6wsyj8xCRp/hCggjANE6HkdSialqQloCwVwuAcbq02L3kiWGto9aRHWQiyUH6slXE5LqgPRbLEO4KY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8315
X-OriginatorOrg: intel.com

On Wed, Mar 05, 2025 at 02:18:13PM +0000, Tushar Vyavahare wrote:
> Introduce tail adjustment functionality in xskxceiver using
> bpf_xdp_adjust_tail(). Add `xsk_xdp_adjust_tail` to modify packet sizes
> and drop unmodified packets. Implement `is_adjust_tail_supported` to check
> helper availability. Develop packet resizing tests, including shrinking
> and growing scenarios, with functions for both single-buffer and
> multi-buffer cases. Update the test framework to handle various scenarios
> and adjust MTU settings. These changes enhance the testing of packet tail
> adjustments, improving AF_XDP framework reliability.
> 
> Signed-off-by: Tushar Vyavahare <tushar.vyavahare@intel.com>
> ---
>  .../selftests/bpf/progs/xsk_xdp_progs.c       |  49 ++++++++
>  tools/testing/selftests/bpf/xsk_xdp_common.h  |   1 +
>  tools/testing/selftests/bpf/xskxceiver.c      | 107 +++++++++++++++++-
>  tools/testing/selftests/bpf/xskxceiver.h      |   2 +
>  4 files changed, 157 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/bpf/progs/xsk_xdp_progs.c b/tools/testing/selftests/bpf/progs/xsk_xdp_progs.c
> index ccde6a4c6319..34c832a5a98c 100644
> --- a/tools/testing/selftests/bpf/progs/xsk_xdp_progs.c
> +++ b/tools/testing/selftests/bpf/progs/xsk_xdp_progs.c
> @@ -4,6 +4,8 @@
>  #include <linux/bpf.h>
>  #include <bpf/bpf_helpers.h>
>  #include <linux/if_ether.h>
> +#include <linux/ip.h>
> +#include <linux/errno.h>
>  #include "xsk_xdp_common.h"
>  
>  struct {
> @@ -14,6 +16,7 @@ struct {
>  } xsk SEC(".maps");
>  
>  static unsigned int idx;
> +int adjust_value = 0;
>  int count = 0;
>  
>  SEC("xdp.frags") int xsk_def_prog(struct xdp_md *xdp)
> @@ -70,4 +73,50 @@ SEC("xdp") int xsk_xdp_shared_umem(struct xdp_md *xdp)
>  	return bpf_redirect_map(&xsk, idx, XDP_DROP);
>  }
>  
> +SEC("xdp.frags") int xsk_xdp_adjust_tail(struct xdp_md *xdp)
> +{
> +	__u32 buff_len, curr_buff_len;
> +	int ret;
> +
> +	buff_len = bpf_xdp_get_buff_len(xdp);
> +	if (buff_len == 0)
> +		return XDP_DROP;
> +
> +	ret = bpf_xdp_adjust_tail(xdp, adjust_value);
> +	if (ret < 0) {
> +		/* Handle unsupported cases */
> +		if (ret == -EOPNOTSUPP) {
> +			/* Set adjust_value to -EOPNOTSUPP to indicate to userspace that this case
> +			 * is unsupported
> +			 */
> +			adjust_value = -EOPNOTSUPP;
> +			return bpf_redirect_map(&xsk, 0, XDP_DROP);

so in this case you will proceed with running whole traffic? IMHO test
should be stopped for very first notsupp case, but not sure if it's worth
the hassle.

> +		}
> +
> +		return XDP_DROP;
> +	}
> +
> +	curr_buff_len = bpf_xdp_get_buff_len(xdp);
> +	if (curr_buff_len != buff_len + adjust_value)
> +		return XDP_DROP;
> +
> +	if (curr_buff_len > buff_len) {
> +		__u32 *pkt_data = (void *)(long)xdp->data;
> +		__u32 len, words_to_end, seq_num;
> +
> +		len = curr_buff_len - PKT_HDR_ALIGN;
> +		words_to_end = len / sizeof(*pkt_data) - 1;
> +		seq_num = words_to_end;
> +
> +		/* Convert sequence number to network byte order. Store this in the last 4 bytes of
> +		 * the packet. Use 'adjust_value' to determine the position at the end of the
> +		 * packet for storing the sequence number.
> +		 */
> +		seq_num = __constant_htonl(words_to_end);
> +		bpf_xdp_store_bytes(xdp, curr_buff_len - adjust_value, &seq_num, sizeof(seq_num));

what is the purpose of that? test suite expects seq_num to be at the end
of the packet so you have to double it here?

> +	}
> +
> +	return bpf_redirect_map(&xsk, 0, XDP_DROP);
> +}
> +
>  char _license[] SEC("license") = "GPL";
> diff --git a/tools/testing/selftests/bpf/xsk_xdp_common.h b/tools/testing/selftests/bpf/xsk_xdp_common.h
> index 5a6f36f07383..45810ff552da 100644
> --- a/tools/testing/selftests/bpf/xsk_xdp_common.h
> +++ b/tools/testing/selftests/bpf/xsk_xdp_common.h
> @@ -4,6 +4,7 @@
>  #define XSK_XDP_COMMON_H_
>  
>  #define MAX_SOCKETS 2
> +#define PKT_HDR_ALIGN (sizeof(struct ethhdr) + 2) /* Just to align the data in the packet */
>  
>  struct xdp_info {
>  	__u64 count;
> diff --git a/tools/testing/selftests/bpf/xskxceiver.c b/tools/testing/selftests/bpf/xskxceiver.c
> index d60ee6a31c09..bcc265fc784c 100644
> --- a/tools/testing/selftests/bpf/xskxceiver.c
> +++ b/tools/testing/selftests/bpf/xskxceiver.c
> @@ -524,6 +524,8 @@ static void __test_spec_init(struct test_spec *test, struct ifobject *ifobj_tx,
>  	test->nb_sockets = 1;
>  	test->fail = false;
>  	test->set_ring = false;
> +	test->adjust_tail = false;
> +	test->adjust_tail_support = false;
>  	test->mtu = MAX_ETH_PKT_SIZE;
>  	test->xdp_prog_rx = ifobj_rx->xdp_progs->progs.xsk_def_prog;
>  	test->xskmap_rx = ifobj_rx->xdp_progs->maps.xsk;
> @@ -992,6 +994,31 @@ static bool is_metadata_correct(struct pkt *pkt, void *buffer, u64 addr)
>  	return true;
>  }
>  
> +static bool is_adjust_tail_supported(struct xsk_xdp_progs *skel_rx)
> +{
> +	struct bpf_map *data_map;
> +	int adjust_value = 0;
> +	int key = 0;
> +	int ret;
> +
> +	data_map = bpf_object__find_map_by_name(skel_rx->obj, "xsk_xdp_.bss");
> +	if (!data_map || !bpf_map__is_internal(data_map)) {
> +		ksft_print_msg("Error: could not find bss section of XDP program\n");
> +		exit_with_error(errno);
> +	}
> +
> +	ret = bpf_map_lookup_elem(bpf_map__fd(data_map), &key, &adjust_value);
> +	if (ret) {
> +		ksft_print_msg("Error: bpf_map_lookup_elem failed with error %d\n", ret);
> +		return false;

exit_with_error(errno) to be consistent?

> +	}
> +
> +	/* Set the 'adjust_value' variable to -EOPNOTSUPP in the XDP program if the adjust_tail
> +	 * helper is not supported. Skip the adjust_tail test case in this scenario.
> +	 */
> +	return adjust_value != -EOPNOTSUPP;
> +}
> +
>  static bool is_frag_valid(struct xsk_umem_info *umem, u64 addr, u32 len, u32 expected_pkt_nb,
>  			  u32 bytes_processed)
>  {
> @@ -1768,8 +1795,13 @@ static void *worker_testapp_validate_rx(void *arg)
>  
>  	if (!err && ifobject->validation_func)
>  		err = ifobject->validation_func(ifobject);
> -	if (err)
> -		report_failure(test);
> +
> +	if (err) {
> +		if (test->adjust_tail && !is_adjust_tail_supported(ifobject->xdp_progs))
> +			test->adjust_tail_support = false;

how about setting is_adjust_tail_supported() as validation_func? Would
that work? Special casing this check specially for tail manipulation tests
seems a bit odd.

> +		else
> +			report_failure(test);
> +	}
>  
>  	pthread_exit(NULL);
>  }
> @@ -2516,6 +2548,73 @@ static int testapp_hw_sw_max_ring_size(struct test_spec *test)
>  	return testapp_validate_traffic(test);
>  }
>  
> +static int testapp_xdp_adjust_tail(struct test_spec *test, int adjust_value)
> +{
> +	struct xsk_xdp_progs *skel_rx = test->ifobj_rx->xdp_progs;
> +	struct xsk_xdp_progs *skel_tx = test->ifobj_tx->xdp_progs;
> +
> +	test_spec_set_xdp_prog(test, skel_rx->progs.xsk_xdp_adjust_tail,
> +			       skel_tx->progs.xsk_xdp_adjust_tail,
> +			       skel_rx->maps.xsk, skel_tx->maps.xsk);
> +
> +	skel_rx->bss->adjust_value = adjust_value;
> +
> +	return testapp_validate_traffic(test);
> +}
> +
> +static int testapp_adjust_tail(struct test_spec *test, u32 value, u32 pkt_len)
> +{
> +	u32 pkt_cnt = DEFAULT_BATCH_SIZE;

you don't need this variable

> +	int ret;
> +
> +	test->adjust_tail_support = true;
> +	test->adjust_tail = true;
> +	test->total_steps = 1;
> +
> +	pkt_stream_replace_ifobject(test->ifobj_tx, pkt_cnt, pkt_len);
> +	pkt_stream_replace_ifobject(test->ifobj_rx, pkt_cnt, pkt_len + value);
> +
> +	ret = testapp_xdp_adjust_tail(test, value);
> +	if (ret)
> +		return ret;
> +
> +	if (!test->adjust_tail_support) {
> +		ksft_test_result_skip("%s %sResize pkt with bpf_xdp_adjust_tail() not supported\n",
> +				      mode_string(test), busy_poll_string(test));
> +	return TEST_SKIP;

missing indent

> +	}
> +
> +	return 0;
> +}
> +
> +static int testapp_adjust_tail_common(struct test_spec *test, int adjust_value, u32 len,
> +				      bool set_mtu)
> +{
> +	if (set_mtu)
> +		test->mtu = MAX_ETH_JUMBO_SIZE;

could you remove this and instead of bool_set_mtu just pass the value of
mtu?

static int testapp_adjust_tail(struct test_spec *test, u32 value, u32 pkt_len, u32 mtu)
{
	(...)
	if (test->mtu != mtu)
		test->mtu = mtu;
	(...)
}

static int testapp_adjust_tail_shrink(struct test_spec *test)
{
	return testapp_adjust_tail(test, -4, MIN_PKT_SIZE, MAX_ETH_PKT_SIZE);
}

static int testapp_adjust_tail_shrink_mb(struct test_spec *test)
{
	return testapp_adjust_tail(test, -4, XSK_RING_PROD__DEFAULT_NUM_DESCS * 3,
				   MAX_ETH_JUMBO_SIZE);
}

no need for _common func.

> +	return testapp_adjust_tail(test, adjust_value, len);
> +}
> +
> +static int testapp_adjust_tail_shrink(struct test_spec *test)
> +{
> +	return testapp_adjust_tail_common(test, -4, MIN_PKT_SIZE, false);
> +}
> +
> +static int testapp_adjust_tail_shrink_mb(struct test_spec *test)
> +{
> +	return testapp_adjust_tail_common(test, -4, XSK_RING_PROD__DEFAULT_NUM_DESCS * 3, true);

Am I reading this right that you are modifying the size by just 4 bytes?
The bugs that drivers had were for cases when packets got modified by
value bigger than frag size which caused for example underlying page being
freed.

If that is the case tests do nothing valuable from my perspective.

> +}
> +
> +static int testapp_adjust_tail_grow(struct test_spec *test)
> +{
> +	return testapp_adjust_tail_common(test, 4, MIN_PKT_SIZE, false);
> +}
> +
> +static int testapp_adjust_tail_grow_mb(struct test_spec *test)
> +{
> +	return testapp_adjust_tail_common(test, 4, XSK_RING_PROD__DEFAULT_NUM_DESCS * 3, true);
> +}
> +
>  static void run_pkt_test(struct test_spec *test)
>  {
>  	int ret;
> @@ -2622,6 +2721,10 @@ static const struct test_spec tests[] = {
>  	{.name = "TOO_MANY_FRAGS", .test_func = testapp_too_many_frags},
>  	{.name = "HW_SW_MIN_RING_SIZE", .test_func = testapp_hw_sw_min_ring_size},
>  	{.name = "HW_SW_MAX_RING_SIZE", .test_func = testapp_hw_sw_max_ring_size},
> +	{.name = "XDP_ADJUST_TAIL_SHRINK", .test_func = testapp_adjust_tail_shrink},
> +	{.name = "XDP_ADJUST_TAIL_SHRINK_MULTI_BUFF", .test_func = testapp_adjust_tail_shrink_mb},
> +	{.name = "XDP_ADJUST_TAIL_GROW", .test_func = testapp_adjust_tail_grow},
> +	{.name = "XDP_ADJUST_TAIL_GROW_MULTI_BUFF", .test_func = testapp_adjust_tail_grow_mb},
>  	};
>  
>  static void print_tests(void)
> diff --git a/tools/testing/selftests/bpf/xskxceiver.h b/tools/testing/selftests/bpf/xskxceiver.h
> index e46e823f6a1a..67fc44b2813b 100644
> --- a/tools/testing/selftests/bpf/xskxceiver.h
> +++ b/tools/testing/selftests/bpf/xskxceiver.h
> @@ -173,6 +173,8 @@ struct test_spec {
>  	u16 nb_sockets;
>  	bool fail;
>  	bool set_ring;
> +	bool adjust_tail;
> +	bool adjust_tail_support;
>  	enum test_mode mode;
>  	char name[MAX_TEST_NAME_SIZE];
>  };
> -- 
> 2.34.1
> 

