Return-Path: <bpf+bounces-54569-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8476EA6CA35
	for <lists+bpf@lfdr.de>; Sat, 22 Mar 2025 14:02:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 629F11B635CF
	for <lists+bpf@lfdr.de>; Sat, 22 Mar 2025 13:02:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F20A621C9ED;
	Sat, 22 Mar 2025 13:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FI1VPa/d"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D87B51E522;
	Sat, 22 Mar 2025 13:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742648560; cv=fail; b=MSuNQOUnggmMuGldJzdFgr7inloWpD9LlGhER1MTy4ljHVDlvbQgeHxM1P0GaI+a1dwzM2BKCKZizmsO7l+6m/pQUkR/dKo7W8nU804sKnfXuYjW3vcco/UVIXUT59gC+o8MKtxO7V3/fQ+VEzC8RR8moxer8/FPG0gzWNGdueI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742648560; c=relaxed/simple;
	bh=BUn09CiaGdiMC7k8Zcew+ysguzfefMu8TYaNS7cPOH4=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Bb2jHtjBiUX8LidyoDSqdZKJuyaNtW+miRRmeRBUru6ogjEzOok+2ijvdBwielEEJrTyPHBeBezNg0Di5FkjTqOeWcnN1G68WjSdfe74dpznRX6TLnDlaiYYQC1usZnlnUOjZq4CVEU/fzfvAUcghv18hTJqavwl5udT3hNw6KA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FI1VPa/d; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742648559; x=1774184559;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=BUn09CiaGdiMC7k8Zcew+ysguzfefMu8TYaNS7cPOH4=;
  b=FI1VPa/deNZNUBMhhp31MKBCl8nSTWaax2W5d+PJyzOLbj8/N0EOlWe9
   ktjwJ+bsiZPH2Z8wqduXcW7U6ajQvTG7eGSvEQhxSCw1B4ZEDLAJ1KL4e
   MsKi+zGu02nju4ntCcEh9Ghcn8aJa5ug2mh6khhcUCbcn2UwnrWEo3Y+j
   c6YofACwXo09oSCg8oQ0GRSaOk6f7Y1/NCvRSr3HPe5yKgUJPqKkUudfz
   Qc7Vsl11Pw4fw3IFdBF3yC1bFLq5KAKNYNeShtPRs4roeizmiAEib1e+7
   KyxW1yAWqsyLYOwI34geoan+aGGhI452E19rinU8F+Uju7bhdGnNvsrJI
   Q==;
X-CSE-ConnectionGUID: 2TGuAzypSa289JeUaMgXGw==
X-CSE-MsgGUID: Cg25KkuLR2i1BcLZUtqE4Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11381"; a="31499566"
X-IronPort-AV: E=Sophos;i="6.14,267,1736841600"; 
   d="scan'208";a="31499566"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2025 06:02:38 -0700
X-CSE-ConnectionGUID: o8+t7B1uSCW/K1wOWt9VHQ==
X-CSE-MsgGUID: ulrU27rzQmG3DNZ/1vUSsg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,267,1736841600"; 
   d="scan'208";a="160863260"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2025 06:02:38 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Sat, 22 Mar 2025 06:02:37 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Sat, 22 Mar 2025 06:02:37 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Sat, 22 Mar 2025 06:02:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=njWdUgaynzprZ1pZxHpt+PFCRN4ThyN7uJbK79uM4DQeEfkBW1L33G9nVWohPJg1vXJLxbZ4/iihAUF1BaqyPUBo3eK6C6n5WWukWHHbntUdbEmVLSE+FqXk/gNMoW8iX7sarpYvWJwGPL/XiICAgmYbhSvilL4fHxaRPyzRw1Ote91kSXjS1Q5eqoN2XVNh5h3EzOANBNua81+rKPM8Ju2a/Eq1qNyIs19w55q6mJNHtUrhX+O40j9Pgq2YotsDuiWkiwJPUsTpjD05bufrGfAfcbZRvPfcGrbpTUuDpZHMl4SLnvFZXHDk2la06Ltvd7E4x8WGcX0qjrc8xvsv/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DCcnku9kGHbpq41VgWTAk7swMTKPXIajpADeP3YtaA0=;
 b=NxO25m89pEjrBszSgTlPP8qxUgNlxzSnvBNLZIMoc9buO/IOHjUxb23iaVwcEOX5WCaI9AM7Iq5uUHM0qk9xvsjLyZIAYFH2VY8atSaGIn5/nfxnxixxPY91mFHkWQXQHW2SwoE8M3/6PEFLPk36Fs3VBd/8e4kfdPFwL4cyztPm3ZW5uthDkYvlbGNNDBJmgtxDyg7IomQFX3meBX29tFUVpllfhUPePLfnoRxSGLhqtPD0fiQdEkamOcp6k5vfKCNSZvXd+1KMb9SlME/8wvlVpKZwkUAny+dJCrFGXvl0hXBmXj0VfOr36NS/+HcyhpvHiXV/VrnxjPzjYFf8KA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 PH7PR11MB6427.namprd11.prod.outlook.com (2603:10b6:510:1f5::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Sat, 22 Mar
 2025 13:02:33 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca%3]) with mapi id 15.20.8534.036; Sat, 22 Mar 2025
 13:02:32 +0000
Date: Sat, 22 Mar 2025 14:02:26 +0100
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Tushar Vyavahare <tushar.vyavahare@intel.com>
CC: <bpf@vger.kernel.org>, <netdev@vger.kernel.org>, <bjorn@kernel.org>,
	<magnus.karlsson@intel.com>, <jonathan.lemon@gmail.com>,
	<davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<ast@kernel.org>, <daniel@iogearbox.net>, <tirthendu.sarkar@intel.com>
Subject: Re: [PATCH bpf-next v4 1/2] selftests/xsk: Add packet stream
 replacement function
Message-ID: <Z9604qRXSb2eCwSg@boxer>
References: <20250321005419.684036-1-tushar.vyavahare@intel.com>
 <20250321005419.684036-2-tushar.vyavahare@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250321005419.684036-2-tushar.vyavahare@intel.com>
X-ClientProxiedBy: DU7P189CA0007.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:10:552::35) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|PH7PR11MB6427:EE_
X-MS-Office365-Filtering-Correlation-Id: 0bca41a4-41d0-4f36-69b8-08dd6941cecd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?7GI/CjOPeauclyqpapMfretZJzHqHfou6vgq1suH5EICD4St80yhjOorGS/j?=
 =?us-ascii?Q?R+i1G6eL6aWFQQiBq1XpTgos/STdGeF8mvCjbVwRwYrMM4rXdNbMX06r7N2R?=
 =?us-ascii?Q?hqnnYnoUmapEFRKyGXK12zCVSuK0i1MfxMUCRe2w7/V3pV/75TLsnvXMv8zQ?=
 =?us-ascii?Q?HwAdvIC36s+NeXXn8oox3s6HyjhFUYsnX17gjRZXAQaSgFqNwGOkFKL0/z9G?=
 =?us-ascii?Q?dC1xhhkhM0QgdywL/1p0KaH/MLqymEn4i3nxHd/ZyTgf7dlR4H8A1P8YlzPR?=
 =?us-ascii?Q?PunCxDGL9TYbKgyR+RcSFsGLdisAt3EsUfHiM50h8DmT4AoECX8QwgC02KsP?=
 =?us-ascii?Q?0Xo9GEaQTzc/AU9RUMPsLX0YiHKStXCoJUOUqX9u8FMk3gX5bvjmmZSWLAq0?=
 =?us-ascii?Q?pEUgEc4/BtDdpkVwqgKlPebcO+2lCWWL+AWq/n30mUx7u7ZOrfxuoGfmgc+B?=
 =?us-ascii?Q?K7VrAaXukXfJd75MoNMRNSlk1FqXnhi9RInNx0kAe/ym1moe1xz0W7d/HVX5?=
 =?us-ascii?Q?z0yQRkBy/X9XYJnFuCB/G3yjBrlQLdELwpCsy4vQY+yUzXsSp4U3famn/lH0?=
 =?us-ascii?Q?VGDWrjkXMG23uAXxJD+id6QzYYwwNuf7ccQci+lnjYIz+f3htk0bEYUZR7n2?=
 =?us-ascii?Q?jIkIvhfB3n+baPnyCl33RUOhdBh9wcKU3h3NzptQllEJHPvybP+DOQrmkP6p?=
 =?us-ascii?Q?5qZJ76h1Smu2dIuvKEraGt2CQVbbwXVhGrCU6t9EnjUlr7ZMEmWWJi/azDIF?=
 =?us-ascii?Q?9QM0AiiQRsyI2XmdGeDBT4Yg6JpRht3BeJyeNgHEEAgRG0taSk9iAjSngv7Y?=
 =?us-ascii?Q?xxE8E35JJaT/+iSeGprMrOiL1OkUsbK/7cPlHMNkHXk7TTr/NJaAANsSy1jH?=
 =?us-ascii?Q?gjwvsPdk+2OFGYGlyi3EkutjDUgAh83QVm+OB0dPZbhJtKpxPKP7fPLswm5f?=
 =?us-ascii?Q?OZndIoWcToNvDRWnBDWfCob3v0/Er4gJ/9A3cQ6XjSCANdaCGeUmG7m0xdJV?=
 =?us-ascii?Q?GV448kwukWDUDWrNoDs+TXjBL3NNlvwcfN0SVsgGmvujunHfaBNiJqv149vZ?=
 =?us-ascii?Q?pJNAZdzaEGF80LVot9uRDY2OjrxxLIQra4o8ezfZ/w1489ZCSfJPQFNNZsXD?=
 =?us-ascii?Q?9yDOGegbiIG31lPyHdzsgw7RYm2Ncq/Rj8Je5zTYXbAESki6oIEkWlkFcUID?=
 =?us-ascii?Q?OfnSx8/eXgyGCWiKZ0kBN5iADU79SOKpuP9f1CVW9CKG9qDjQejwvMkITtSE?=
 =?us-ascii?Q?3medX+zCKrnzqNypZjVvrPomwzpjNhcM3AD8HZmx9LDkhZzRxAaw/FjK/1me?=
 =?us-ascii?Q?K5HEKhiaqSIBAO4bTzTM7ROms4lLis28y4LSoe3qk9Ec44iiwJCisOpe4koZ?=
 =?us-ascii?Q?A3KxioS8BeIhNw+Gim/0TJCHdoNo?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SUnMpXT029yqqryxZeSWTwHR1jJCVRhgdYgDVao5YbQ45xp8wW4C12i6vN+9?=
 =?us-ascii?Q?/8oUBrOBcEO1ZyXjBY9Eb9TPFRtZHrOIADp8TNEYO/Gv0XbWpr/BgkFZRx4S?=
 =?us-ascii?Q?LRLomCmV+UQcNf+O88pATsxtX7hwf+wE3V69ZdhfCNVPn5lJaiR0vMRdeQjQ?=
 =?us-ascii?Q?G7NM7BHuBSbNGVRtB3qffILol6qey4E56KsBcTAOHYBI7aqslrLV+jwhxusY?=
 =?us-ascii?Q?lBrp72yupLeGrx03DeOTiWs/+Edft9ObJSKZQ326kRzAYeqIrtw0DfWH1DWO?=
 =?us-ascii?Q?pk4B9prEt1fits/So5vZ+eNMnVYBvxHAmIXfQpM2mx9fXrDeZCLeu2KJJUo6?=
 =?us-ascii?Q?Hb1LNtLa1W2aT5gS66hzoTuLognPop57lxXrlvm1Plwua1lGWQHZrIw45oTE?=
 =?us-ascii?Q?sQWLSmDfaHxlToHu4yKa6ofjxGWcV9KUlRwZC10+2rpbr+BJWZUtqiVZc4qt?=
 =?us-ascii?Q?kz6pEhgzrMpO9bc88H8YsZpRf4u/4qPusyzzWo2A77B2bnqzoTHYDmo027zh?=
 =?us-ascii?Q?d0Q2MLrsfiGZk/QOmHz1jnr25x3x+2usTKsZN77F+ARohGVMu8vER4uyw0no?=
 =?us-ascii?Q?v0YH4eD9y9WZDGuD3KxARYDz2LRyL8PX9H+2j6ANw0SjE7Jeiy0BPkSLxqyy?=
 =?us-ascii?Q?ER8nMcruN0stG+Q2RKWS/bg1a0z/nlfdvZ5AQDYU63o359auV1mzsUyE1DoO?=
 =?us-ascii?Q?PZvuh9U/kCpSjHVY+MZVBBJuqkkyrS0voaFRqCTqE+qy49kQaMRUb1YA/44x?=
 =?us-ascii?Q?Ot9OERsFK9MnEUlZVPpQ1Nu8ii8WFMWP/dN8Ca0C18yrxVu5ynWMSXi2GERI?=
 =?us-ascii?Q?5LhJBSVI92s8YqcIGaXhtcaBj8pcxjSpvW9aqIL4zPZpF3J0v8JF6Vg9l6Ux?=
 =?us-ascii?Q?zWYM69vX1tDMUHsYl5kNOyXo/8bxuznm2dKRBsK8tiQ08vi13e+XwPy06jwH?=
 =?us-ascii?Q?QbREtMeBmSbh/XmQOJE2lRP6TqXWYRB+36qy2Q+oo2/gklH8S4RJyxfWsyF3?=
 =?us-ascii?Q?Rk0SmQWb6genIReKcGh8H4iiZjbKoBjdbP7Dzjoy2+aKXglO9o7Jy/crhR2B?=
 =?us-ascii?Q?8c4vYlzA+iIkTHCL/IphwUTy5ODU5or4JBv6354VCQaQFWSutlDBgwBSWbIP?=
 =?us-ascii?Q?Ifd77unyFe1QaRQGya+wuzs7yWv7KyhlKq+I96NQHzuqfQdGdTx6RPbpam9H?=
 =?us-ascii?Q?Kw7dxZQN6qtrMwnzlUA8pdJrPaTmwBNbOmUfm8TRYOz5yIQMIqYUtp0ztxXP?=
 =?us-ascii?Q?B8xFgs0XbU+mzcyHC7++sc7VvMUgT0OCT0UFy8sQq8mLTlNyw1fksHzTcOKo?=
 =?us-ascii?Q?gbIql4Ic/bEbrO3gZ137SAHG+iZxF93o5oG8A3yqKADXY/4YvLkLo+L2xA+v?=
 =?us-ascii?Q?Y9u7LuUbCt47Tp4hFJHH2zNKtsiqpI8LA/Eqrtc0TJpnxkUgIbhUBpSlgdY5?=
 =?us-ascii?Q?Geo+d/g919loQHr5jEcqZJybt4uXTe0A2yFdGF4wqizLDgLzYHn8jdLacecC?=
 =?us-ascii?Q?JiqaTb7pbnmeN3rt9XrPfVL7HihNygr39j9xnqP94x+vbssAqAMf/j6X8mn/?=
 =?us-ascii?Q?rWyPvb60SF2vyNpLwVfRP4Xdi43KcHggfqk+JDNGyFjFEwCdwuLZN441FiY6?=
 =?us-ascii?Q?SQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bca41a4-41d0-4f36-69b8-08dd6941cecd
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2025 13:02:32.1294
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uPU4hWC/HQslN7IZ53aTZTiVt95K5uOt1UKzhIjfVsRU33bmNm3WlsiMWsi+tch6SffY3j+FGifV7H82LOz5n/R92WHW4BQKsZeNHLH4k9o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6427
X-OriginatorOrg: intel.com

On Fri, Mar 21, 2025 at 12:54:18AM +0000, Tushar Vyavahare wrote:
> Add pkt_stream_replace_ifobject function to replace the packet stream for
> a given ifobject.
> 
> Enable separate TX and RX packet replacement, allowing RX side packet
> length adjustments using bpf_xdp_adjust_tail() in the upcoming patch.
> Currently, pkt_stream_replace() works on both TX and RX packet streams,
> and this new function provides the ability to modify one of them.
> 
> Signed-off-by: Tushar Vyavahare <tushar.vyavahare@intel.com>
> ---
>  tools/testing/selftests/bpf/xskxceiver.c | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)

Reviewed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>

> 
> diff --git a/tools/testing/selftests/bpf/xskxceiver.c b/tools/testing/selftests/bpf/xskxceiver.c
> index 11f047b8af75..d60ee6a31c09 100644
> --- a/tools/testing/selftests/bpf/xskxceiver.c
> +++ b/tools/testing/selftests/bpf/xskxceiver.c
> @@ -757,14 +757,15 @@ static struct pkt_stream *pkt_stream_clone(struct pkt_stream *pkt_stream)
>  	return pkt_stream_generate(pkt_stream->nb_pkts, pkt_stream->pkts[0].len);
>  }
>  
> -static void pkt_stream_replace(struct test_spec *test, u32 nb_pkts, u32 pkt_len)
> +static void pkt_stream_replace_ifobject(struct ifobject *ifobj, u32 nb_pkts, u32 pkt_len)
>  {
> -	struct pkt_stream *pkt_stream;
> +	ifobj->xsk->pkt_stream = pkt_stream_generate(nb_pkts, pkt_len);
> +}
>  
> -	pkt_stream = pkt_stream_generate(nb_pkts, pkt_len);
> -	test->ifobj_tx->xsk->pkt_stream = pkt_stream;
> -	pkt_stream = pkt_stream_generate(nb_pkts, pkt_len);
> -	test->ifobj_rx->xsk->pkt_stream = pkt_stream;
> +static void pkt_stream_replace(struct test_spec *test, u32 nb_pkts, u32 pkt_len)
> +{
> +	pkt_stream_replace_ifobject(test->ifobj_tx, nb_pkts, pkt_len);
> +	pkt_stream_replace_ifobject(test->ifobj_rx, nb_pkts, pkt_len);
>  }
>  
>  static void __pkt_stream_replace_half(struct ifobject *ifobj, u32 pkt_len,
> -- 
> 2.34.1
> 

