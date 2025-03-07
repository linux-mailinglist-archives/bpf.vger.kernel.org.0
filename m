Return-Path: <bpf+bounces-53575-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DCCFEA568ED
	for <lists+bpf@lfdr.de>; Fri,  7 Mar 2025 14:28:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B0F08166D70
	for <lists+bpf@lfdr.de>; Fri,  7 Mar 2025 13:28:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68A2621A447;
	Fri,  7 Mar 2025 13:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aLqgsNhk"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56EE2219A95;
	Fri,  7 Mar 2025 13:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741354072; cv=fail; b=Kf4Knmm/Cy8ak+TPYzmORQXaFUXHpGzd5/h099MhGeZ43A5nlzGVTEYd/QVFsfGY4Ja0XhnDROhWKHiw2irbIJWEcxaqCesTpY7epgsVDGaExeUag//pMh25qXb8bFtaqD/PF10Kh9n5gB+Xd+HgalcCbrRe1izKiU/iWagQcBE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741354072; c=relaxed/simple;
	bh=77RESmwNJYiGxqshTD4ntoMVzFx3JDtrOM3yTqbhsZk=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=eesqPSj+TzLY3GvsvpaHsLLmR8NV7Htu2xr31jiYVMOaO8h6pr5xvWtCGxy4/5qzYYjmV7ObW0u5saHlKMQYd/7QZwSYB/TxhuC+teIFe0M/5IgQ80P0koXgk7ThLlJWbbFJJ0gtAD4Q0pv2/bPUwPSu4a3dTdRSqT2u03SS/DQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aLqgsNhk; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741354070; x=1772890070;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=77RESmwNJYiGxqshTD4ntoMVzFx3JDtrOM3yTqbhsZk=;
  b=aLqgsNhkhhdatmfp8xBMhPtgLt/I/VVX8Hhg9fx3sXSIIy4jlkr4eGeh
   YVYtUfpGxVtnobKqlYuNtPcXEhGI/MVOwBgEedmlSMZ+oNQAnue8T2x1i
   zKjETt7UeabWP1Fk83SUllMdM6LPclyVkXaIuf795iAz9BNnldPXw2YPZ
   4DgSTwT1JrpeBTqw2Eu7LqFrK1cnBd4BS9Wx3exaAoIzQ+pRoUKJBmZ8L
   AvJjO4Oqji/omVLVPm4D5ryJ2XSDXkvO4XsLei35Q+luCt5i0wC1xflfx
   VkYU6snTdPu7+GPrq9/kp+0avJZSZ//N0OeSR9p+2qaRlMBoSVII5VEas
   Q==;
X-CSE-ConnectionGUID: TKdbR2lPRR6EvOjrROvY8A==
X-CSE-MsgGUID: 9oHPjBTFSMqIvDK5NgLV6A==
X-IronPort-AV: E=McAfee;i="6700,10204,11365"; a="42312593"
X-IronPort-AV: E=Sophos;i="6.14,229,1736841600"; 
   d="scan'208";a="42312593"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2025 05:27:48 -0800
X-CSE-ConnectionGUID: eqsIWdL2RvynsOLUtXBbJA==
X-CSE-MsgGUID: AgmOR0H1TO6KXkVP8nOn9Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,229,1736841600"; 
   d="scan'208";a="124353734"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 07 Mar 2025 05:27:48 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Fri, 7 Mar 2025 05:27:48 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Fri, 7 Mar 2025 05:27:48 -0800
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.48) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 7 Mar 2025 05:27:47 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Br7r/j7p66F97lkGBwTCidVkwlVvuCVaWdQDfmcpFTTH5Po7hO0f5x8p6+QrD8Mlu4DyVghMk617laAqSZ4jlNnxd8U9gCZQHT0sF8khvs22+frUZ8X1kqWhdoJsy/l5hrjCLJ0NRCfrth1+1s6xFssiEaa1r7lJm23CdrIy/FJF9JhUVgwoE+al5HxBJ2D8EnvLtjPpJgB+ME+U4WPRqemgjJo80hF45g3lBtlxtVtn+iemtbzayolpZGIiK2fK495JUSXKmxSyDEfKO7LjPYn6W5x7Gw0uGGNLywLXZPSXHu+kNJw3tKmsqPvagpPQaPNkYNFySGeZ7gupq9mPWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RtDyha/fgUwgCsUep4al4kqvI0Is/uMX3aNYUe2R2pE=;
 b=Ks/QCHys/UrTW7MgaJRjixPmhKWNUVnd5s3dZ0lD5aXAvkRVsZ9BeH76gWwR6KWcDPx1x8Y/5AWWp1fnUE5q/Z7nOx2l+lqBGio+pSsnL+IVoB8wmUm3nm27PLumtYfIY/EJzXCsl8RqYzZAX7DfMH4HF2ar6hK/fWFwOn/aLZoqvxQAxEdLvupkBkY/nEGofpn1bbRjS4IajWEI8QOd5dpckRsA9mVZhio4bMJzLF30Gyem3Oyw+zKOO1fGvh//SWSDuLimi0EqgzzlNJg2+mX/CCUWF2o5fVdPsQZhyYjq46R1oThkar2ekUeFB+sxy2EN7S37qGCKP4W2Ub3pHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 DS0PR11MB7804.namprd11.prod.outlook.com (2603:10b6:8:f3::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8511.17; Fri, 7 Mar 2025 13:27:26 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca%3]) with mapi id 15.20.8511.017; Fri, 7 Mar 2025
 13:27:26 +0000
Date: Fri, 7 Mar 2025 14:27:13 +0100
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
CC: <intel-wired-lan@lists.osuosl.org>, Michal Kubiak
	<michal.kubiak@intel.com>, Tony Nguyen <anthony.l.nguyen@intel.com>, "Przemek
 Kitszel" <przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Alexei
 Starovoitov" <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
	"Jesper Dangaard Brouer" <hawk@kernel.org>, John Fastabend
	<john.fastabend@gmail.com>, Simon Horman <horms@kernel.org>,
	<bpf@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next 11/16] idpf: prepare structures to support XDP
Message-ID: <Z8r0MagKeUNHwfQk@boxer>
References: <20250305162132.1106080-1-aleksander.lobakin@intel.com>
 <20250305162132.1106080-12-aleksander.lobakin@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250305162132.1106080-12-aleksander.lobakin@intel.com>
X-ClientProxiedBy: WA1P291CA0011.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:19::8) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|DS0PR11MB7804:EE_
X-MS-Office365-Filtering-Correlation-Id: b29296f6-c7f0-4c2a-b61f-08dd5d7bccf9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?qWVDqDi2caDFhkGbqoSkchMBrHq8tvPp0IpiBgM4pGxmt71h9dnSyOUWTiBS?=
 =?us-ascii?Q?o6V/t5gKzeiDLxGWUzlPuzWUQvEd4RiJOtYw3dfJ+LCwZULbn2hmRC0o6bLi?=
 =?us-ascii?Q?/DvSZ5vcvCK15qvcvaK8QKvVaozvbCDK36lAMXVIpodKJ6BAfyeLkBLKbdEi?=
 =?us-ascii?Q?GdQ2/OxHDZfBejo+0RwqxhIU2CdIWMtw32QjcfFOiTkh5jGk6S+ApwezvxSU?=
 =?us-ascii?Q?q7lmsEx4FtOWElk2fE8iXvNzBJ2UCCGBKI2VS4lHtxmxvoWU/OMkRKRu1Rel?=
 =?us-ascii?Q?t6+26cfUEkFznMzrb1xPS9cjO8InJGElwt1oohdwTtHrLy8oRA/AFN8F2Wx4?=
 =?us-ascii?Q?VS39aFBlk/a438+e/ccl502eTv34S9WL3+APkoLHa2KvHNnJkQkrfP+OlFSJ?=
 =?us-ascii?Q?D0VZfAK44Wpp9BXTkOplyOPecYz0rRSsbCT46ze1n2Iz/s8y4wVwatP17PZD?=
 =?us-ascii?Q?tlljQBYWlPILbYGM5okomRaMbs3n+r/+YiQhcK5f0NeGJB5ra7bCDxGDiqOS?=
 =?us-ascii?Q?MeS/PITIGBtp3yvh2o9gHLrsGePybwsf42uvf7wUUG3cD2EstI//AB44zd8F?=
 =?us-ascii?Q?56nWWXaHYxk/Vj/5ps1VTRksRrUi37d0ZbpWS2Arn7Wa0V+eJAqQGE7HrZHH?=
 =?us-ascii?Q?OBY57mOFdTLJfItyNu/1C5G0sBO0MAuERW+22vsoEjwA8ObG310hl3FZIc+Y?=
 =?us-ascii?Q?oHPr6tWaZbIl6zPdcFZ0a7zrkUGrG8Pq1sNAc3HvYaq48Uh3FQGvi+oLiqs/?=
 =?us-ascii?Q?wMZSAAI7lseAkL2bHMumXLwF9JzGSiqhb5Iae8i2b0ubnxmnvAvBvSYV06hV?=
 =?us-ascii?Q?hQfPJpzasNpSAUGr8aXkSMXlQ5sOFACREGSNkSQiuoxII1RJXWkvN6tJfA1X?=
 =?us-ascii?Q?CLWscHTimcnHmn47y1aTL2vqNFM/OdU1dHO0vD1GWKyRO3aTu6pAJiVcfWsA?=
 =?us-ascii?Q?U1n3/Giay7vXMpu+XyjQc1TVpqntWaJkRhQi3MbPSnx3MLLpd7A46pLdQALL?=
 =?us-ascii?Q?/mPjVnwsJvO+b76/u0rFpWqQPjbZsrjELzE15uR436jRjcx9RIKltXmSjIN4?=
 =?us-ascii?Q?nAsdieNhDWRQhIyPMM4k+9N/iTA2Hrjp3HgUWPTbnXVVjHL8838ouFY13Zu5?=
 =?us-ascii?Q?dmt1GcH+rVKCVBkkCAU8Q6Dydztvn8up6zp9N6logk9Y7UHPL0yT+vztdoWW?=
 =?us-ascii?Q?fBhCnIvdn2diF5ys7yQ43WR5WnyWarpw2+Sr5MJHEfe9r5XCARVhGbU59Yle?=
 =?us-ascii?Q?/G7mY3ISpLoqan/8p5CBOsCNuEZfrNcbOlkz2CGDBrvpQCVTNjMaC/oVGfoE?=
 =?us-ascii?Q?yeMeLvnt1q6M9szNTP9gKP7VksRQVd1bxvdryPFOIonBShqvYwBPZ9xCmdee?=
 =?us-ascii?Q?aKNfv468DhbNfP7eMWSYj/ASzVia?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yJ5MDhWqSyXWci6DoBNwD5+DCU6w9GFXQ82zj4xlm8IQhkPPsYICciZ/i80b?=
 =?us-ascii?Q?WHZZObKEC3F04H4VxtYLq97zzlBmNLtRQ2gixqvdE3jSMsGxDdt3zjgCK0fP?=
 =?us-ascii?Q?5mnfTDWU6DQOLbh0cU/XoDN/UCJt+KB5Ne5VW/WwR2lONnekYkI1AiVgRlri?=
 =?us-ascii?Q?uOk4dKj7oBHBEI/YNOLZxtU3wb8N8vlxXLNgk5AVXKoF1QcsF/D3FGucKZv0?=
 =?us-ascii?Q?RFa/uAJwkvcCMKKX/MpVN3ChDV2rrX6j2fqU/dfjdrRebQXh8U6sfXAkHl2I?=
 =?us-ascii?Q?haNBxfCEX2PpsNUKAy+EsTm4U3Yc3bsD3zVl3BNUbjWsQiwOXjMwdChFWHRz?=
 =?us-ascii?Q?GveXq9FHQD7AiSjW6L83/iIA2R19ymSCq+KJOmos1P3Kalq8JjSUDN73zFSe?=
 =?us-ascii?Q?9KnhdQEd4SIC9nmRd8Xfqmg3de6GTJgil6jGh+iPG9V5Ij4AuDllT4/somuL?=
 =?us-ascii?Q?7MDlKB/jWpNa/I4H7KSdndScxJJ9WD3cys01lEg1vw5fERZLft2bBx1Z98Ji?=
 =?us-ascii?Q?FUWSEG0N3qWOW/DsIU2AGYMdpOjxeg1V5UphsdYd/slTo6lTyXDC8875gp3l?=
 =?us-ascii?Q?HcniH/r5uRDWyifh8MuVGFG8XlUJeXt8mgRAtNBz8C/MXh00lifCyAUseXas?=
 =?us-ascii?Q?l5V4fj04u70E5fsoiaLJxg4m51ACoZsE5Elav/rrpXyIPE/QagpthjVgrhMR?=
 =?us-ascii?Q?l9EbwkRjdZoWwZhB6woz8Mo5zBlBl3sdvaM5fFp6FGWILkg5wCj8DJvcqRej?=
 =?us-ascii?Q?pnCMyNifpUO4gfCcFlxiQgUaE1Yase9R4fry/i5zcVTY0UXwjTT8R2TU8oFp?=
 =?us-ascii?Q?ufZ9DlISujhAvTJIeV9PGIiDWWNWhXTNcnOE01vDUEd3TaztalT1s+GZB7gU?=
 =?us-ascii?Q?ymRjcTo/JnHiD59sRbyjdc1C01m9i2C2PN++ow1dv5D4eY3FsEUMu/rv0iWE?=
 =?us-ascii?Q?GdLms1ddv7jcy4dOXmxLTME4UmE7Gx3A+lqGCGDIoPzJtCCHF3CifRKmLqOF?=
 =?us-ascii?Q?/pBwzvckA4Vhtz3+5PriRHsQ52U9Z9X+AOKmRPO3tb1QVLxpJbdzlZUKO22Z?=
 =?us-ascii?Q?0hsbYCnhfLvTKP3syp9ovnKgDom0UvCZ2pqdbzShXocUFrnzlJUSia7qRnpq?=
 =?us-ascii?Q?4TQHnT2/tiNmUZD+7JnGmRZXEhhN7w5Pn2NHi3HmFY4wJQqp0rhxYmbcXjZB?=
 =?us-ascii?Q?lCjPEjUh8jTJv02v+Gvr7WOqJi5FC9dCinyHeGBp8h9ELx4ZAtQ3gYLHePMn?=
 =?us-ascii?Q?jqPkzYSBxW/vKkv9uvHZC1v2Tw24fAIGP4/Hoop/UGo0Z/6x8eqvY+AqKl2d?=
 =?us-ascii?Q?FoP05dfM0gMA0kZahsxGu0fks2Fh3ZM/pN6BHo13kQ9bFre60t5Fv/H4OPyJ?=
 =?us-ascii?Q?bYztd4SmSm20DmsVTNzpazfrh3PtqOgJ5iiUOmGiXRXJruGeR8+YvKQ2GQs2?=
 =?us-ascii?Q?Yy1HEHMk2EYekRRE9Kuvkyi0an3h9XeyI1DW30X2F5xFUj6xCkVDRsZyPM2c?=
 =?us-ascii?Q?WZS26Vv0fgh/vk650DWXHVoWhK95tnJD2Qq/eRs3pa2cWnHC1eCypJv9S30l?=
 =?us-ascii?Q?yM7Nfie5jXDlhj3jG+Grkc3udwPta6sZ6uImEylNehspijNR5GIguIZULbkI?=
 =?us-ascii?Q?IQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b29296f6-c7f0-4c2a-b61f-08dd5d7bccf9
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2025 13:27:25.9036
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S6cPtZsyHTIP2jT/kt98AOtIIjZ20GWNSgea15GKdb+uxCr4EMV/9skAIJt2rDX4Obsc1t9QuKtK0OZfHvkGrOc0bSor2E5SPhpmy7U4il0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7804
X-OriginatorOrg: intel.com

On Wed, Mar 05, 2025 at 05:21:27PM +0100, Alexander Lobakin wrote:
> From: Michal Kubiak <michal.kubiak@intel.com>
> 
> Extend basic structures of the driver (e.g. 'idpf_vport', 'idpf_*_queue',
> 'idpf_vport_user_config_data') by adding members necessary to support XDP.
> Add extra XDP Tx queues needed to support XDP_TX and XDP_REDIRECT actions
> without interfering with regular Tx traffic.
> Also add functions dedicated to support XDP initialization for Rx and
> Tx queues and call those functions from the existing algorithms of
> queues configuration.
> 
> Signed-off-by: Michal Kubiak <michal.kubiak@intel.com>
> Co-developed-by: Alexander Lobakin <aleksander.lobakin@intel.com>
> Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
> ---
>  drivers/net/ethernet/intel/idpf/Kconfig       |   2 +-
>  drivers/net/ethernet/intel/idpf/Makefile      |   2 +
>  drivers/net/ethernet/intel/idpf/idpf.h        |  20 ++
>  drivers/net/ethernet/intel/idpf/idpf_txrx.h   |  86 ++++++--
>  drivers/net/ethernet/intel/idpf/xdp.h         |  17 ++
>  .../net/ethernet/intel/idpf/idpf_ethtool.c    |   6 +-
>  drivers/net/ethernet/intel/idpf/idpf_lib.c    |  21 +-
>  drivers/net/ethernet/intel/idpf/idpf_main.c   |   1 +
>  .../ethernet/intel/idpf/idpf_singleq_txrx.c   |   8 +-
>  drivers/net/ethernet/intel/idpf/idpf_txrx.c   | 109 +++++++---
>  .../net/ethernet/intel/idpf/idpf_virtchnl.c   |  26 +--
>  drivers/net/ethernet/intel/idpf/xdp.c         | 189 ++++++++++++++++++
>  12 files changed, 415 insertions(+), 72 deletions(-)
>  create mode 100644 drivers/net/ethernet/intel/idpf/xdp.h
>  create mode 100644 drivers/net/ethernet/intel/idpf/xdp.c
> 
> diff --git a/drivers/net/ethernet/intel/idpf/Kconfig b/drivers/net/ethernet/intel/idpf/Kconfig
> index 1addd663acad..7207ee4dbae8 100644
> --- a/drivers/net/ethernet/intel/idpf/Kconfig
> +++ b/drivers/net/ethernet/intel/idpf/Kconfig
> @@ -5,7 +5,7 @@ config IDPF
>  	tristate "Intel(R) Infrastructure Data Path Function Support"
>  	depends on PCI_MSI
>  	select DIMLIB
> -	select LIBETH
> +	select LIBETH_XDP
>  	help
>  	  This driver supports Intel(R) Infrastructure Data Path Function
>  	  devices.
> diff --git a/drivers/net/ethernet/intel/idpf/Makefile b/drivers/net/ethernet/intel/idpf/Makefile
> index 2ce01a0b5898..c58abe6f8f5d 100644
> --- a/drivers/net/ethernet/intel/idpf/Makefile
> +++ b/drivers/net/ethernet/intel/idpf/Makefile
> @@ -17,3 +17,5 @@ idpf-y := \
>  	idpf_vf_dev.o
>  
>  idpf-$(CONFIG_IDPF_SINGLEQ)	+= idpf_singleq_txrx.o
> +
> +idpf-y				+= xdp.o
> diff --git a/drivers/net/ethernet/intel/idpf/idpf.h b/drivers/net/ethernet/intel/idpf/idpf.h
> index 50dde09c525b..4847760744ff 100644
> --- a/drivers/net/ethernet/intel/idpf/idpf.h
> +++ b/drivers/net/ethernet/intel/idpf/idpf.h
> @@ -257,6 +257,10 @@ struct idpf_port_stats {
>   * @txq_model: Split queue or single queue queuing model
>   * @txqs: Used only in hotpath to get to the right queue very fast
>   * @crc_enable: Enable CRC insertion offload
> + * @xdpq_share: whether XDPSQ sharing is enabled
> + * @num_xdp_txq: number of XDPSQs
> + * @xdp_txq_offset: index of the first XDPSQ (== number of regular SQs)
> + * @xdp_prog: installed XDP program
>   * @num_rxq: Number of allocated RX queues
>   * @num_bufq: Number of allocated buffer queues
>   * @rxq_desc_count: RX queue descriptor count. *MUST* have enough descriptors
> @@ -303,6 +307,11 @@ struct idpf_vport {
>  	struct idpf_tx_queue **txqs;
>  	bool crc_enable;
>  
> +	bool xdpq_share;
> +	u16 num_xdp_txq;
> +	u16 xdp_txq_offset;
> +	struct bpf_prog *xdp_prog;
> +
>  	u16 num_rxq;
>  	u16 num_bufq;
>  	u32 rxq_desc_count;
> @@ -380,6 +389,7 @@ struct idpf_rss_data {
>   *		      ethtool
>   * @num_req_rxq_desc: Number of user requested RX queue descriptors through
>   *		      ethtool
> + * @xdp_prog: requested XDP program to install
>   * @user_flags: User toggled config flags
>   * @mac_filter_list: List of MAC filters
>   *
> @@ -391,6 +401,7 @@ struct idpf_vport_user_config_data {
>  	u16 num_req_rx_qs;
>  	u32 num_req_txq_desc;
>  	u32 num_req_rxq_desc;
> +	struct bpf_prog *xdp_prog;
>  	DECLARE_BITMAP(user_flags, __IDPF_USER_FLAGS_NBITS);
>  	struct list_head mac_filter_list;
>  };
> @@ -604,6 +615,15 @@ static inline int idpf_is_queue_model_split(u16 q_model)
>  	       q_model == VIRTCHNL2_QUEUE_MODEL_SPLIT;
>  }
>  
> +/**
> + * idpf_xdp_is_prog_ena - check if there is an XDP program on adapter
> + * @vport: vport to check
> + */
> +static inline bool idpf_xdp_is_prog_ena(const struct idpf_vport *vport)
> +{
> +	return vport->adapter && vport->xdp_prog;
> +}

(...)

> +
> +#endif /* _IDPF_XDP_H_ */
> diff --git a/drivers/net/ethernet/intel/idpf/idpf_ethtool.c b/drivers/net/ethernet/intel/idpf/idpf_ethtool.c
> index 59b1a1a09996..1ca322bfe92f 100644
> --- a/drivers/net/ethernet/intel/idpf/idpf_ethtool.c
> +++ b/drivers/net/ethernet/intel/idpf/idpf_ethtool.c
> @@ -186,9 +186,11 @@ static void idpf_get_channels(struct net_device *netdev,
>  {
>  	struct idpf_netdev_priv *np = netdev_priv(netdev);
>  	struct idpf_vport_config *vport_config;
> +	const struct idpf_vport *vport;
>  	u16 num_txq, num_rxq;
>  	u16 combined;
>  
> +	vport = idpf_netdev_to_vport(netdev);
>  	vport_config = np->adapter->vport_config[np->vport_idx];
>  
>  	num_txq = vport_config->user_config.num_req_tx_qs;
> @@ -202,8 +204,8 @@ static void idpf_get_channels(struct net_device *netdev,
>  	ch->max_rx = vport_config->max_q.max_rxq;
>  	ch->max_tx = vport_config->max_q.max_txq;
>  
> -	ch->max_other = IDPF_MAX_MBXQ;
> -	ch->other_count = IDPF_MAX_MBXQ;
> +	ch->max_other = IDPF_MAX_MBXQ + vport->num_xdp_txq;
> +	ch->other_count = IDPF_MAX_MBXQ + vport->num_xdp_txq;

That's new I think. Do you explain somewhere that other `other` will carry
xdpq count? Otherwise how would I know to interpret this value?

Also from what I see num_txq carries (txq + xdpq) count. How is that
affecting the `combined` from ethtool_channels?

>  
>  	ch->combined_count = combined;
>  	ch->rx_count = num_rxq - combined;
> diff --git a/drivers/net/ethernet/intel/idpf/idpf_lib.c b/drivers/net/ethernet/intel/idpf/idpf_lib.c
> index 2594ca38e8ca..0f4edc9cd1ad 100644

(...)

> +
> +/**
> + * __idpf_xdp_rxq_info_init - Setup XDP RxQ info for a given Rx queue
> + * @rxq: Rx queue for which the resources are setup
> + * @arg: flag indicating if the HW works in split queue mode
> + *
> + * Return: 0 on success, negative on failure.
> + */
> +static int __idpf_xdp_rxq_info_init(struct idpf_rx_queue *rxq, void *arg)
> +{
> +	const struct idpf_vport *vport = rxq->q_vector->vport;
> +	bool split = idpf_is_queue_model_split(vport->rxq_model);
> +	const struct page_pool *pp;
> +	int err;
> +
> +	err = __xdp_rxq_info_reg(&rxq->xdp_rxq, vport->netdev, rxq->idx,
> +				 rxq->q_vector->napi.napi_id,
> +				 rxq->rx_buf_size);
> +	if (err)
> +		return err;
> +
> +	pp = split ? rxq->bufq_sets[0].bufq.pp : rxq->pp;
> +	xdp_rxq_info_attach_page_pool(&rxq->xdp_rxq, pp);
> +
> +	if (!split)
> +		return 0;

why do you care about splitq model if on next patch you don't allow
XDP_SETUP_PROG for that?

> +
> +	rxq->xdpqs = &vport->txqs[vport->xdp_txq_offset];
> +	rxq->num_xdp_txq = vport->num_xdp_txq;
> +
> +	return 0;
> +}
> +
> +/**
> + * idpf_xdp_rxq_info_init_all - initialize RxQ info for all Rx queues in vport
> + * @vport: vport to setup the info
> + *
> + * Return: 0 on success, negative on failure.
> + */
> +int idpf_xdp_rxq_info_init_all(const struct idpf_vport *vport)
> +{
> +	return idpf_rxq_for_each(vport, __idpf_xdp_rxq_info_init, NULL);
> +}
> +
> +/**
> + * __idpf_xdp_rxq_info_deinit - Deinit XDP RxQ info for a given Rx queue
> + * @rxq: Rx queue for which the resources are destroyed
> + * @arg: flag indicating if the HW works in split queue mode
> + *
> + * Return: always 0.
> + */
> +static int __idpf_xdp_rxq_info_deinit(struct idpf_rx_queue *rxq, void *arg)
> +{
> +	if (idpf_is_queue_model_split((size_t)arg)) {
> +		rxq->xdpqs = NULL;
> +		rxq->num_xdp_txq = 0;
> +	}
> +
> +	xdp_rxq_info_detach_mem_model(&rxq->xdp_rxq);
> +	xdp_rxq_info_unreg(&rxq->xdp_rxq);
> +
> +	return 0;
> +}
> +
> +/**
> + * idpf_xdp_rxq_info_deinit_all - deinit RxQ info for all Rx queues in vport
> + * @vport: vport to setup the info
> + */
> +void idpf_xdp_rxq_info_deinit_all(const struct idpf_vport *vport)
> +{
> +	idpf_rxq_for_each(vport, __idpf_xdp_rxq_info_deinit,
> +			  (void *)(size_t)vport->rxq_model);
> +}
> +
> +int idpf_vport_xdpq_get(const struct idpf_vport *vport)
> +{
> +	struct libeth_xdpsq_timer **timers __free(kvfree) = NULL;

please bear with me here - so this array will exist as long as there is a
single timers[i] allocated? even though it's a local var?

this way you avoid the need to store it in vport?

> +	struct net_device *dev;
> +	u32 sqs;
> +
> +	if (!idpf_xdp_is_prog_ena(vport))
> +		return 0;
> +
> +	timers = kvcalloc(vport->num_xdp_txq, sizeof(*timers), GFP_KERNEL);
> +	if (!timers)
> +		return -ENOMEM;
> +
> +	for (u32 i = 0; i < vport->num_xdp_txq; i++) {
> +		timers[i] = kzalloc_node(sizeof(*timers[i]), GFP_KERNEL,
> +					 cpu_to_mem(i));
> +		if (!timers[i]) {
> +			for (int j = i - 1; j >= 0; j--)
> +				kfree(timers[j]);
> +
> +			return -ENOMEM;
> +		}
> +	}
> +
> +	dev = vport->netdev;
> +	sqs = vport->xdp_txq_offset;
> +
> +	for (u32 i = sqs; i < vport->num_txq; i++) {
> +		struct idpf_tx_queue *xdpq = vport->txqs[i];
> +
> +		xdpq->complq = xdpq->txq_grp->complq;
> +
> +		idpf_queue_clear(FLOW_SCH_EN, xdpq);
> +		idpf_queue_clear(FLOW_SCH_EN, xdpq->complq);
> +		idpf_queue_set(NOIRQ, xdpq);
> +		idpf_queue_set(XDP, xdpq);
> +		idpf_queue_set(XDP, xdpq->complq);
> +
> +		xdpq->timer = timers[i - sqs];
> +		libeth_xdpsq_get(&xdpq->xdp_lock, dev, vport->xdpq_share);
> +
> +		xdpq->pending = 0;
> +		xdpq->xdp_tx = 0;
> +		xdpq->thresh = libeth_xdp_queue_threshold(xdpq->desc_count);
> +	}
> +
> +	return 0;
> +}
> +
> +void idpf_vport_xdpq_put(const struct idpf_vport *vport)
> +{
> +	struct net_device *dev;
> +	u32 sqs;
> +
> +	if (!idpf_xdp_is_prog_ena(vport))
> +		return;
> +
> +	dev = vport->netdev;
> +	sqs = vport->xdp_txq_offset;
> +
> +	for (u32 i = sqs; i < vport->num_txq; i++) {
> +		struct idpf_tx_queue *xdpq = vport->txqs[i];
> +
> +		if (!idpf_queue_has_clear(XDP, xdpq))
> +			continue;
> +
> +		libeth_xdpsq_put(&xdpq->xdp_lock, dev);
> +
> +		kfree(xdpq->timer);
> +		idpf_queue_clear(NOIRQ, xdpq);
> +	}
> +}
> -- 
> 2.48.1
> 

