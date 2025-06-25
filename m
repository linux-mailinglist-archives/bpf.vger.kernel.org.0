Return-Path: <bpf+bounces-61520-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4DEAAE8291
	for <lists+bpf@lfdr.de>; Wed, 25 Jun 2025 14:22:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EED247AAA4D
	for <lists+bpf@lfdr.de>; Wed, 25 Jun 2025 12:20:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97A6E25E477;
	Wed, 25 Jun 2025 12:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BfOZ3x56"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5371325BF09;
	Wed, 25 Jun 2025 12:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750854102; cv=fail; b=FNk0LdgPaL4bJwLhT81W4K22jD2yqADXbCcXKcH4vKlEVDBoFxSDb15crN7afjAkFxAEcvU2WduVJbheT9flf5Iuhg3neHOPTsCE800WPPykaz5H7Z5KbRMVcFzyqJ+0vP+4wtAxa76v35q8uDTP9fcrxfZaQNQtYET4yRqMHxM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750854102; c=relaxed/simple;
	bh=MAqLuqDt0T2KMJsUPdKxfd9Zdhz4X5eyI77M41u+PbU=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=MR79kRYZvXHmb9Fhf8aS0lLpARNpLnjK0KaE7gjUz+b4aO8hDBSjEQKlOEk2ZhxGv0SrdzmzVJHRuo5sHtaZeV2O8eW450GqtqKv8CLmmECTjmtqBaDP45RpCW4qm9qCR3Dy0/p/Kckc+ja+TEKcp7cJuJ4vpJMFsJtxTUaoQmM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BfOZ3x56; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750854101; x=1782390101;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=MAqLuqDt0T2KMJsUPdKxfd9Zdhz4X5eyI77M41u+PbU=;
  b=BfOZ3x56sQguT1BgHocJPpK4nRR7UYDoOSz0agko+WJUODmlNAfHbk8d
   fPo9XwBdzkJsS/0FkUOdbVGPk1191A1FnxeOly680McZbIRgp6EaRRdtV
   sxhg7QiTwJY3ruCoGqqhm5UcJ2hnZ9XXZrZrOtzrwrmlQ2NlTu+36ZSVk
   9sAzdaNz6jO667Ao5eOnrylmitDN671KxE2YuvOQNNzmBADvnaDtiCKDw
   PUmXyICP+ivrwY/mTB3FdYJ/+hjrblYR7M1/o+ahMtEZSw4kpEPnG8ZS+
   RjGdcnDwcRnnce5MAnJf+/XMXZAroz1J1/iYLDiHzOAxSTAR6x2hGxsH6
   A==;
X-CSE-ConnectionGUID: /sN5lEcfSJOPoxXlevXlDQ==
X-CSE-MsgGUID: +XAa6iBNRUOAKSMSJQj+qA==
X-IronPort-AV: E=McAfee;i="6800,10657,11474"; a="53257361"
X-IronPort-AV: E=Sophos;i="6.16,264,1744095600"; 
   d="scan'208";a="53257361"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2025 05:21:39 -0700
X-CSE-ConnectionGUID: b/r9XhEGROy0s3hylm+nUg==
X-CSE-MsgGUID: wGRy++HpTtuFLRur3Jn0hA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,264,1744095600"; 
   d="scan'208";a="151962359"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2025 05:21:38 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 25 Jun 2025 05:21:37 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Wed, 25 Jun 2025 05:21:37 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (40.107.244.68)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 25 Jun 2025 05:21:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jMAFV5xZpa4LX2X3Wsezkyu+1HjIcmPHspKvSxSZZPJFmyWVE6Eqw5oRq5OAduau/no1y3/Y4z0yTp3dGYPPA4hh5KeUHaxSsn8NHHvQIMG427c/0GLeGIpq9h4A38lz6cfgL6/78TeMMO1mnV6UW8QozvPuIrcfeWc03/RT9RenFHuztUkKrEVSdzgJG0tUtznZoWJGK8NgARyQ4BrzHBhF85qthuwc2Eduw2fcsh2DygKOLJ67E3wcVvQnFqZBOEudkXTiNGUXnXgwfgLgNypZ7n8dhLhYXpXxbm/oYPs3RpSqilyctv7GIxcuDIUuu16QYBehOnct7agtrzfh2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bXhVvnmdPkaKji4OqbvuQexT9QGg/nfyQiWRcfV+xtU=;
 b=nF1ao85L6uk0gye9i7Nog0CuCSs80n4NUokFqmmQTZSSajA8r+BycJ2uXrEdxC+OIuVs7cOotOtPAw1bJ4g4W44eeEo3qSIdlRhOHOM9c6g0yJ/vka9L0eBa9Cu28QOaVl8t8bs+FVClbVN3m0PGRFsd7C4JwfUJG3aLwuTaNorJXt6QtT78zobxxnDGo51KQjDltEf08rrtsL1afArxp3jcrzn51LELTGwCgno7d+Vf/OpdUsXzrAKok8Jl4vnpL7qq0RvU88EvCQr5l2Op56KlaxSyKql91vR7bE9RyxfVSg5eb/iwW8xFLj5meswWxmN8MzJD8eU37rbxhWC4lQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 CY8PR11MB7800.namprd11.prod.outlook.com (2603:10b6:930:72::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8880.16; Wed, 25 Jun 2025 12:21:21 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca%4]) with mapi id 15.20.8857.026; Wed, 25 Jun 2025
 12:21:21 +0000
Date: Wed, 25 Jun 2025 14:21:14 +0200
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Jason Xing <kerneljasonxing@gmail.com>
CC: Jakub Kicinski <kuba@kernel.org>, <davem@davemloft.net>,
	<edumazet@google.com>, <pabeni@redhat.com>, <bjorn@kernel.org>,
	<magnus.karlsson@intel.com>, <jonathan.lemon@gmail.com>, <sdf@fomichev.me>,
	<ast@kernel.org>, <daniel@iogearbox.net>, <hawk@kernel.org>,
	<john.fastabend@gmail.com>, <joe@dama.to>, <willemdebruijn.kernel@gmail.com>,
	<bpf@vger.kernel.org>, <netdev@vger.kernel.org>, Jason Xing
	<kernelxing@tencent.com>
Subject: Re: [PATCH net-next v4] net: xsk: introduce XDP_MAX_TX_BUDGET
 setsockopt
Message-ID: <aFvpumY2VrER7gDj@boxer>
References: <20250623021345.69211-1-kerneljasonxing@gmail.com>
 <20250624163114.712a9c43@kernel.org>
 <CAL+tcoBQvDJO8n7npQjzKBd6HEZ8KhE08g4hRhqokU-bpTe6tw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL+tcoBQvDJO8n7npQjzKBd6HEZ8KhE08g4hRhqokU-bpTe6tw@mail.gmail.com>
X-ClientProxiedBy: WA2P291CA0038.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1f::8) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|CY8PR11MB7800:EE_
X-MS-Office365-Filtering-Correlation-Id: 054444d2-53e7-4c97-9328-08ddb3e2cb99
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eUs5Q1pQRG9pdjE3VE41UURiMjZobHVqZVZOMHRhMmk1cmlVU3hvTEdpOXR3?=
 =?utf-8?B?cDRaM1dpUmNDYnJYTzFsTDc1NW5RbmtXcDNXRXk5T2NvNk50MmhoZ0I1Ujhq?=
 =?utf-8?B?THZCRDVnemdCN01UZHZ6Y1MzSnpxdm1WUGlpelR6aW8reXoyOG5ndTNFdnRr?=
 =?utf-8?B?S1FUOFIzQXJYSVF5d2cxVUhGU0lybi81a1ZvQUVCR2Y0a2VWeEJIRXp0U1Nn?=
 =?utf-8?B?c1RBTFlpUS9pY2ltZ21TYmJRS3kzelFUNkdwY2I2M0JPbW1yc1l3azlUc2dG?=
 =?utf-8?B?Q1dCK3BYb0tIVTQ5YzFTMjNQZzdCVGxXZFNiMUNWbkhQMW44alpTeVk0UE9q?=
 =?utf-8?B?eHdlU0U0Zm56dEdsWmsrK1JLUGhLYStscmZ4Q2NldTRWcURZbFdxVFNYaGhL?=
 =?utf-8?B?aEQzR2htT3c5a2xMT3BSU3pNV01DNk1tbERwak5Ebjl1MWlicHVDVktKWlhy?=
 =?utf-8?B?cE54NSsraTM3UTB5Q1F3RUZBSXgxNGdSR1V4NkErSTFIZlppWVdnUWRGSnQ4?=
 =?utf-8?B?cnBxWGdYL25SWW9GU2Z6djZGWTZDVDNQUHJiOUQrOTZtYXp4ZFNVWlNXdFVQ?=
 =?utf-8?B?QzUyWXpoa08xNlFnYlF4dDBVdDVsNTdhRk4xd1dMN3pjY29xWUxBNzQ1S2VS?=
 =?utf-8?B?R3dnL3VFeGJ2RU12WWFSNm82SGVNbFZHbXdRKzVSdTYvdlZYQjltb3pHcVBi?=
 =?utf-8?B?bG9VYU0yRnA4cGl4VHF5SkY1WlZqRGlXNFBiYVRzQithM3dueXQvazlFU013?=
 =?utf-8?B?R0tKTGZXdFN6bUt3alRyMHVmNU1ueTFEeHpOTGRZdUx0eWpOU1poVk9RaTJT?=
 =?utf-8?B?endTY05NcFJMWklnNXFxNUJRckp1aW5ERHlrRW5oMTRvZS9EN0tlWmJaSFla?=
 =?utf-8?B?VXZVaE9BeW5qdk1MYi9EOHY4ZXNIM256L05XK3FEODdSMHRLWUMwdHBUSEw1?=
 =?utf-8?B?c2c2a3BxUXVLRFZITkxIbWlzQ0VReGo2aDB1dlk4MUNyb3ZlZWlPMVkwTkR3?=
 =?utf-8?B?cXVFUCtoRlY2aFZ0QUtuS0U3QVZyQmVtMlY2ak0vM1d3aW1UUjlTOENDdjV4?=
 =?utf-8?B?OUUyemxSZXV6S1Z1Tm5vYXBHN0dKdGU2aDZ1R21vY1p0T3dvSndUTXdaRzJ6?=
 =?utf-8?B?OXZ1c3FMaXptUzBRVVE5UzdmUXJmbW9VUjFIajVoT2pqd094K3dVV1RIeTZC?=
 =?utf-8?B?RXNGbHdJUlI4czR5clhBL0ErdWk4b1ZWQWVJMmpWOER2YjBzcklpNXZ2MlRU?=
 =?utf-8?B?YmhoaTVVbmhpWU9QZFBCditDZG9rWE40SzJZaUFRTitpL0xwMVlpVUVlTUdw?=
 =?utf-8?B?cnEvd204aVBoNnk5VjM5OWhoZGthcTJkdHVkTW9qbVVXMmNETTUwazhFV3Nu?=
 =?utf-8?B?MTVnenhjVzlLUXBhcWppVmE5S24vUU5TOG03aUs3R0lPd1JCUHEvYTNiNGI3?=
 =?utf-8?B?RU1QS1VOZ1JQdUk0OW9tMTFoRlo4Tkc1alBSMGdmdkpMTllPak1SZ05YQlpy?=
 =?utf-8?B?Mk9xOVlkZ1BVc1FyZTE2WGNjUDBVdVVadnBTTjN3RWJCVyt1cGxpM21EOEFL?=
 =?utf-8?B?R3VRWmJpNlFoM21XNGV5OEF5THNzUVNBeHpNUWx3V0ZqMUtjZDRsWEJ1NVBr?=
 =?utf-8?B?OVNrUlVIazlnWnhoN1FjYlpZMjBydjNCbElGRjRvZTRVOVdkVjNXUDBIdU10?=
 =?utf-8?B?VjlOWlNCempJY3dHZ0c0bzR3NEFhQVdhZnZ2cXFiZW9CWkpTQmJuUnRiaWpv?=
 =?utf-8?B?bkdDUXV1Y0I1RE4yUGg3aG9uVmhNdGRzVHV4VE5IdHlZdTFUdzh3eTRKaDlF?=
 =?utf-8?B?N1liT2hSQTUzTGxVQkR3K3NVSTAvTjlzOE1DRmd5cDFGWHZ5TXFhdHlhMTFs?=
 =?utf-8?B?SGs1ZFM5Ujd2Qm5DV0FrbXg4NVhYQlJPTUVXVlFOL0xBWU42bU9FOWY1QUZp?=
 =?utf-8?Q?mzjhw/fL2Ag=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R0Z2V3B2Wi94NjhNMFNEeU0vS1ZGSzBsL3dOMHBVdzk3QUVZVytYcHovdzRV?=
 =?utf-8?B?aXE3MUFieVBXZmEzemlLWFB5ZHRvSm44QTE1Y1pBK2Q1Z0pMRDlmMGhQRHRW?=
 =?utf-8?B?N2k4ZXFrSUFGelFMNUY0QWNQSGd5RUdmV0U3L281aGZNYjhOWG43MEZzVFJX?=
 =?utf-8?B?Y1VWU2tRYThDR2xQKzk5ekhFbHFwUUFlYTNIdWZCdXRDZFdiUk8yOEJSeldn?=
 =?utf-8?B?blBKT0FiK0pwbkw5aDA4WmhyZGpKa3UxQk45dWZXQTAyYUZhU1FDQ0JJQkVD?=
 =?utf-8?B?R2o4clBvRmxQUUM3bDdrT0tjSkNjcnQ0cS9SZElYYW9qQXNVd1piam8wQVZJ?=
 =?utf-8?B?a3l2MFNOcC9Cb01mNC96Um1EQ1FsRlh3Snl5ZHUrWnNrcERzeU4zNmFOcnBF?=
 =?utf-8?B?RFBEV3JwVHhqTC9ETktxa1hnbTNBekpWTjYvTm8zVDFNS256R1N5M09hS1VU?=
 =?utf-8?B?QnZOdDJEcmFIYUZqU0JESFZVMERXek1QWkxWbzVWWmEwUjRTcHpZNW9EQ2lk?=
 =?utf-8?B?MDRZQ014dG9SWDMzT280d1JYMlp0NWpIZzVsZ1ByajB3cDJ3VjZmY3R3YVJv?=
 =?utf-8?B?MnQrdXk5RTZRU1VRaHlpeTBUUDNOM3dMQ3Iza2dscllDUTAvcEJ3aHRqR25C?=
 =?utf-8?B?VEtaelJ1dE85aldTU2lNSklWSm1QcEhJalRDQlNWdm5mUGNOblR3WFJGMU9l?=
 =?utf-8?B?c3dBVnNWeFRhVTk2ODN4UmxnVGxGbVkxMkFSQXdUaG1lOHczK0t0MTlpUWZw?=
 =?utf-8?B?SldnbTB6MW9tbDVyWVo3MWcxNjZHWUR4Y0V0OXJRY1AyK3JVZ2lWcFF1Q2x3?=
 =?utf-8?B?TzNxcWtSMkIzMWFkM2tyZ0VLcmVqUmh4ajEzdXRkdzNyNlFRQ1JEZWtVZ3Fp?=
 =?utf-8?B?SVZIUG5OQ1lEMW5sb3J3N2NMSXdKME9lOUlDZHZPV281bTRvbzlFYmdNWHo2?=
 =?utf-8?B?N0RHZEdrNDJ1TWpmTFFjTFNLQUIrd2VEbUZsdFBwamNra1kwVGNzVFRzRUJY?=
 =?utf-8?B?VWRraVd6MklwNU5qZ3hqdnRlbjF5L2haTndMOGUxdWVCYWc5azkwajZtUHQ0?=
 =?utf-8?B?TXdKQ2I3QnVaOUNTaWRsclNuaUtGMjY4Yk1oNENGUkdNcCtBZjM1cVJSQUxv?=
 =?utf-8?B?M3EyVlh1VU1xOEpKdk95VDVUeHR6d1hBNGFualJJTFE5aFIvUFRUVlAvK1cz?=
 =?utf-8?B?UWVQZXZpenhCR01KUlFyUjJIdm5vR3hyWitzeHdrd3p1cXVpU1ZteUNpQzk5?=
 =?utf-8?B?OXVzTmRBVzhYQlJsUzVkNklTS200eG1lWXNyR3g4UVB4TTY1TmRMa013aFdY?=
 =?utf-8?B?MWcyVWtteWU3K3lkVUdLNjlKWEYraEh5eGQ4eW9CN2xucTdjZlJVZy85SmhM?=
 =?utf-8?B?SnF0TFo4Qzk3WkQzakwrMEl4MmNBWDBKdDFCM2pFTjJJQWxFRyt0ZXRDNnlU?=
 =?utf-8?B?YnQ3ZjByTVY5bGZtTHF6bWdhb2RGUWZxdFB6Umw3MmRSMWVQUzhDR0FFZEFv?=
 =?utf-8?B?cDhFMDAvdWhaV1R4WngzZ0w1M0xzNHRrNHhsSTZtWWVScUFwQkpxWGhuVHo2?=
 =?utf-8?B?eXo0Qmpwa3k1cDFOWjRheEVyS2RpSllSUlkwendIVGtMZ0pSRkY3OFFVdGIw?=
 =?utf-8?B?R1ltU05aeXp2TnlhWmpUazNOVzczUUFWVGVqUEtPaW03R0JON24yNEhzNTla?=
 =?utf-8?B?SGRmdGI5UG1IUkR6czRtbjRCSlpRSmp1d1JQeTdicU80NTdGaWlRNWVCeENu?=
 =?utf-8?B?T1hsaEZXOFhLS2FaY3dwZHZzaXR3Yi9LWmgvMklBeEFDZ2lzWlhwUmlTN2Jj?=
 =?utf-8?B?SkMxNnJ5Ynp2SzVDUi9pVTdXL1NsYnNpNVJVNEl1TDYyWGlMNWJIblpmeXNL?=
 =?utf-8?B?MUtHaUI1ZGNkMFRka29PM0pNaXhESytLS2dCNDVRSStUcGw2Nzk2d3lkUFl0?=
 =?utf-8?B?c2ViRTFCZFZTZkovOUlvaDIwN2FVOEhjSmUvd3YwZFpLUUhwcXczcEpLSnlY?=
 =?utf-8?B?K0xsdDdrNFNBRlJxY0x1NUpxOW03anoxNHZIcDRQTUMyQW9qUE9Nc001UEZO?=
 =?utf-8?B?S01FRWhTckhMajkxYnpJajhtOFJvMDRHYmlEVDVUcDJMNmJGSDRNTklDWkJT?=
 =?utf-8?B?UGhQa1BCOGRWcjlXL3ZFWXgzbExnbWh1ZHpOTHJWbFJqL0xTMHIrNW5WWUhZ?=
 =?utf-8?B?aVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 054444d2-53e7-4c97-9328-08ddb3e2cb99
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2025 12:21:21.7306
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vBs45EEA5YFfL0/XW/kmGTIhOsGmo1kbsjh7+r7p6YkuGfsczUBJtc4FSn1iqEj8xyl7MTyOiFczK186qYC6+dTnPLXESn1vROYIeoXvKNk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7800
X-OriginatorOrg: intel.com

On Wed, Jun 25, 2025 at 08:19:01AM +0800, Jason Xing wrote:
> On Wed, Jun 25, 2025 at 7:31 AM Jakub Kicinski <kuba@kernel.org> wrote:
> >
> > On Mon, 23 Jun 2025 10:13:45 +0800 Jason Xing wrote:
> > > @@ -424,7 +421,9 @@ bool xsk_tx_peek_desc(struct xsk_buff_pool *pool, struct xdp_desc *desc)
> > >       rcu_read_lock();
> > >  again:
> > >       list_for_each_entry_rcu(xs, &pool->xsk_tx_list, tx_list) {
> > > -             if (xs->tx_budget_spent >= MAX_PER_SOCKET_BUDGET) {
> > > +             int max_budget = READ_ONCE(xs->max_tx_budget);
> > > +
> > > +             if (xs->tx_budget_spent >= max_budget) {
> > >                       budget_exhausted = true;
> > >                       continue;
> > >               }
> >
> > I still think you're mixing two very different things. In the generic
> > xmit path the value you're changing is a budget. But xsk_tx_peek_desc()
> > *does not* exit after the "per socket budget" gets spent. The per
> > socket budget only controls how many frames we pick from a single sock
> > before we move to the next. But if we run out of budget on all sockets
> > we give every socket a full budget again and start from the first one

On point. Thanks Jakub! Let's stick to generic xmit budget.

> 
> Ah, my fault. Thanks for reminding me. I missed the 'refilling budget'
> process...
> For the record:
> xsk_tx_peek_desc()
>     -> xs->tx_budget_spent = 0;
> 
> > again.
> >
> > For the ZC case the true budget is set by the driver's NAPI loop.
> 
> True.
> 
> I will remove this one.
> 
> Thanks,
> Jason
> 
> > --
> > pw-bot: cr

