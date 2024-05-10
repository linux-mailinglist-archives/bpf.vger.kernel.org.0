Return-Path: <bpf+bounces-29436-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECFB58C1ECE
	for <lists+bpf@lfdr.de>; Fri, 10 May 2024 09:14:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1BE371C21E3D
	for <lists+bpf@lfdr.de>; Fri, 10 May 2024 07:14:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B21A215F40B;
	Fri, 10 May 2024 07:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KiIU8C0a"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD69315CD7D;
	Fri, 10 May 2024 07:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715325206; cv=fail; b=dDmozwXmofnMNhmPYA0+3K35eoNz9+mD2TecItaK+haAKXX8R5Crla/0ef9Y1SnS6GMhCcpjYNT2/iUGqhZQbvxgWNBQhmx/LPxohoOYMSXkV9hqSq53mgkJ3dUiqOA213Q48b/HvObOMX8CUpYSF/qmHyIvUx+quHn2iZE4Xkk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715325206; c=relaxed/simple;
	bh=78yVetB+W65F2gRG6OK2jBZ7tx/kpWbczXQp0JODtSM=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=pDgkJVN25yNZcMSz2WzzW/hi7zGekF3q9aUwrSZpFWLSpKtY7ucHMwRnsNCDcjj9EqCb5mxwICrgKNbgXEqfL6yYnjazSiMpSOh+eJgMcBQx6NQf3epSzKzX+OtBV1pSs2GTvWiEU/G7VmT6S7ej5Ejs4I2Cn8XNV0B1QIq2f+Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KiIU8C0a; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715325204; x=1746861204;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=78yVetB+W65F2gRG6OK2jBZ7tx/kpWbczXQp0JODtSM=;
  b=KiIU8C0aJCc4DLhIPCiRZpsPsCx7ZpQcJTwca/DD0DxjdBN8OmYzZX0O
   4u/THyja9uZqfuON3Re6sRneWTAveR5PiXrpcMliE9nz/Ad9fCtEMogUF
   kQugj9A0ROMBfdlg2+TFEy8dwtsk6L4D9dDys0EYIi878Xi8DcAPH5bvc
   voY3NDVFsBq/EX9/hWnzEnglEt/tw1ocwfLzOsdp+mSMz3dahS6Hi7p01
   gxG6ge2sjoXYSglCPB05k52roJKO1bTdgW7mTYVVBW8S7pGKon5i97oSZ
   SZNdfAiAcTPnmqxSNVJD/gF7E4X1Hb5l/8nULe2tnnDCBJVtyGu44DMW5
   A==;
X-CSE-ConnectionGUID: 6EZys/5cR02QQkCeRZyM6Q==
X-CSE-MsgGUID: MiQoQAGdQHOP1/owa6gngw==
X-IronPort-AV: E=McAfee;i="6600,9927,11068"; a="11421034"
X-IronPort-AV: E=Sophos;i="6.08,150,1712646000"; 
   d="scan'208";a="11421034"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2024 00:13:23 -0700
X-CSE-ConnectionGUID: SXp2Sh+GQeqDhFD4oylpgA==
X-CSE-MsgGUID: +i3YvLAIT4GaBdJfgWAUBw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,150,1712646000"; 
   d="scan'208";a="34055286"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 10 May 2024 00:13:22 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 10 May 2024 00:13:21 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 10 May 2024 00:13:21 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 10 May 2024 00:12:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vh8HeXcfoWdRZdNFH4TBCzGcA2hktdhv7JPghN4cE+b/+MnZlnVrMyIX3jCL4+vk/LIzx+S5vKRMLPjUJBCMLyyx2cI4x2GGlY8FTTBjfMQPfVuPFMoMQhD1VDWgGURi/SZwzoItX0XAxHKMHtlRdHnn16yiaOkn+218Vcihoo/BlQ0irc56cVK+ibMX3/qfJ1afrz+imdyU0YxWC5qGTwhMgFBprcUIZa5BZBOD3/6UkS4v9MGKwLTO1lABijK850QW49jbowPdplZIkjOpmQmcjNevbDmX5zXw/cV2XEUEw57R+i549Yr5f+K2hsGh5bTCpV+Jt8feZtsJlK5Vyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9Pi8U1zrJs82MXgc6ZdBXnP1uCJ/xKO/OUGX172AI1A=;
 b=ilwIHdhbfV0IudHfn7oYTOrmkIGL1J5GJHNVk26ex79GvbqNi/sQlg4E9dg69UeMcU+EavXl8qmtZ81XnR7Rup88zpLcb+lUSB1SbQzHj5V/EXsZKgEH9yf2khL+d7U7Ihcq6QmoRbcz1UtbK+QVuBhpfF26FJzCZHJoBCQ5yFXWFiEV3y5dClqBpTOhZuNDZntdiqzL2nMeDhByF6vOGdhTeqObg+wKfmoCsctzx+4zjOsw1SB1PEee6wSvdSjnZ+VjwBcQRoptXSZhOVgLTkLQCKipVJLNZT7ywlMTXC4mCKRpHhmmKKcXsOVOIM8xTNi+1HdCnkxThmBYaxzYfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by SA2PR11MB5065.namprd11.prod.outlook.com (2603:10b6:806:115::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.47; Fri, 10 May
 2024 07:12:53 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::bfb:c63:7490:93eb]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::bfb:c63:7490:93eb%3]) with mapi id 15.20.7544.048; Fri, 10 May 2024
 07:12:53 +0000
Message-ID: <5af0aeaf-c713-406d-9eed-ee24ce129b03@intel.com>
Date: Fri, 10 May 2024 09:12:46 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dma: fix DMA sync for drivers not calling dma_set_mask*()
To: Alexander Lobakin <aleksander.lobakin@intel.com>, Christoph Hellwig
	<hch@lst.de>
CC: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>, Steven Price
	<steven.price@arm.com>, Robin Murphy <robin.murphy@arm.com>, Joerg Roedel
	<joro@8bytes.org>, Will Deacon <will@kernel.org>, "Rafael J. Wysocki"
	<rafael@kernel.org>, Magnus Karlsson <magnus.karlsson@intel.com>,
	<nex.sw.ncis.osdt.itp.upstreaming@intel.com>, <bpf@vger.kernel.org>,
	<netdev@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>
References: <20240509144616.938519-1-aleksander.lobakin@intel.com>
Content-Language: en-US
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
In-Reply-To: <20240509144616.938519-1-aleksander.lobakin@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA2P291CA0001.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1e::20) To MN6PR11MB8102.namprd11.prod.outlook.com
 (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|SA2PR11MB5065:EE_
X-MS-Office365-Filtering-Correlation-Id: a12c0b9a-1ed6-4155-1a36-08dc70c09be3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|7416005|376005|1800799015;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZytvT3NXdGVFSEM3V2JrQk9sb1A0TVROcnBGYzVyMU84K0VpNWl2aEtwRG9I?=
 =?utf-8?B?R01hWDVXcWYzUGRmNGdCa0phVitiYjNtWEVjYkRjOGVGNW5WaW9aTDZMT0p4?=
 =?utf-8?B?TkZBWlFDYmRHRG16d01iaitSSXpxQ1ljMGxrQlJYbGJ6dUhtcjBSdVRTZ1BG?=
 =?utf-8?B?Z2pSOSs4MkZ1Y3NXRU81MHRmaW5ObW5iTFcrcCtRQWc2Qi9OSG5FclQ4ODFL?=
 =?utf-8?B?YmZQNTcrWEd4WkwyNHUxS0JpeGg4bytLNEtNbnp6UngxYlBBVThKdGFWTXor?=
 =?utf-8?B?cThLY1FjUWFOcWFiSHl6MmZadmUzNFdEQ2RLOEVpTjBiTDRzeHNCNlVKZEJp?=
 =?utf-8?B?VnZEUnZZQjZ4elg5WGdwMmVPSFI1SWhaSFlncFh6SzVFQ1VHMXZ5ZTdQRkZR?=
 =?utf-8?B?UTRCUjQyWW14OGtXZDJKK2pDUzJnMVBEOEk4V0xDVmlKSmJTOWJDODRFMjdr?=
 =?utf-8?B?Yk1UamlhaXM2UmU2dmlpa01hTnYrbGNHb2l4L1BmdTVLdk5heVZ3OTl3ekFG?=
 =?utf-8?B?U016YkpaeUVrUWYxOWh4R1NFSnQ5U0tkM3BzRWRjNjhWUlZEYk9jMWV0Y0NR?=
 =?utf-8?B?aVMwTEx3R0MrT0lUSjdxNVV1Wk02YTRsMVdwL1RvN1pRakh2VlBXdVJwYito?=
 =?utf-8?B?WGV0TC9lTzNOWGNjeHNWbU02N2xsbEFHQWc1anlTcjJFSzFrM3I2YWxCQlVD?=
 =?utf-8?B?MUE3UjIwY29CTUhVSytMc252dmhlRlBkTkVHN0F6a0pObVBQRkcvS2dLNVVU?=
 =?utf-8?B?UC9yUFA2Z3kvaGxucG8yckFIVzR0bVBLN1ZnYloybEdmbkk1Uy9BK0tta1JP?=
 =?utf-8?B?NVNXQ2ZxdzkvRUJnQVc4Z3paMHlNckNsOE9aMHNDMVpQS01PbklYVVovd08w?=
 =?utf-8?B?RjRQb3RlNmRRYlAvR1hUMDR5alNpRHJ5angvdmlQQkFkbThPTnBNcUc0d1kr?=
 =?utf-8?B?S0NlQ3JpNUZ3L2lPclh1KzJoRUVLRVhwSFkzYVZFVW1YbEluN2o0TUhVZWFU?=
 =?utf-8?B?S3J0N25ocUo5dHFlUGRhd2tIL2x4Q2l2MnExZURwMHJiMkZ0MnliMjBLcFZQ?=
 =?utf-8?B?Z3k5TytwWitycjIzNm9SMlJPa3dpR0psVkt6M0R0a1J1R3R3R1NreC94ZDZz?=
 =?utf-8?B?bDd4N3FZVG1zbjA4K3crYmYzVi8yNTByelNIRERlMzVRYktsT3NIeTFwYlMv?=
 =?utf-8?B?TlZTWnp0d1N3VmlHd3J4ak9FUE9YTXdCVU1FTSs2Wk5ianNNbG1ZU0JydzBv?=
 =?utf-8?B?RTZOQ09UVVVQT3lWOTFrU2lkL1VsUzc1TU96WWovdDg2N3owYjJMT1dIK1Jy?=
 =?utf-8?B?YW9ERkRpOVl1WHpnciszbnhnSW5MV2xHdFNOK1NCY0VCUUdVc1R5MnUrZ1I0?=
 =?utf-8?B?ZW9BSVRXUkpCcFRrRS8rbG1hRzhGOVFsdTR4SFh1ZEI1bFZBRCtzemdvUzho?=
 =?utf-8?B?Yk51azllai92QnlhK1hJaGgrZHpUdndURUpZbFF5U1krZ0NYVXVBY0RycUZo?=
 =?utf-8?B?U01QRElWYTJ6RGs0MnlFWFBBa2o1b1lQcW54S0t3V3p6RXg1SFc0blBPSWpG?=
 =?utf-8?B?R1JyY0NUdG91SlNab2VIQnBPblZnVG9ucitvVzFVZ1ByR0xrZWpGRTMxY1Bl?=
 =?utf-8?Q?edAU2aNYUxAQITu0iAMv7jc1Vt7DNWJgosQG7eKSdsyg=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(7416005)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bHJFZnBWRDhEbXU1OVluNUdtUXJQQU41YWRPaDY0UFlVNWRKUjRmV3ZrMVk2?=
 =?utf-8?B?ZlFoYWtEQjZOK01WQ0hFNFhxZ3ZzaHpvVnAxYy91dkIxVWh5L3g5U2pOVVd6?=
 =?utf-8?B?Z1RRendiazF0Z3ErY2FQdTZzVEFwSnNtblVGeXZNSVY4dkVOWmVWRnNyc3pw?=
 =?utf-8?B?eFZVMmRzemZvQlhRNXpiUEhadnRzQ0R1NDBlQmIxZWROSkFqdDZrbnIwTnJZ?=
 =?utf-8?B?ZitkTjd4TnI0S0tIZkZlNDRLam5iTjl5MHdtbk5YS1JlSTFubVV6d3p0MllY?=
 =?utf-8?B?WCs1ZU5CbXRwMS9ENjdnajZyS3ZXMWxJZXJYOTZ3K0ZRUE9tWXN0S2l0Y2Na?=
 =?utf-8?B?eUhFS204Tm9FSXduMlBvUkZDeUM1MDN2UXlLMzNFN2F3TkFlZFFaMCtHWEU3?=
 =?utf-8?B?ZCtiajRHdVoxZjYzSlNZTldFdmh1a3J0MUpzbnhIaW9seS91U29WdDJ5NXJo?=
 =?utf-8?B?d1JnTElaSHFWZi8vdGRtSXhWc3RIb0Y0aUhLajVzQytKYnAzb0x0ZU5FZC9h?=
 =?utf-8?B?M0ZicXpHU0RMYUo0VXZFMy85YjA1MVJLNVBLSjJrN2FmT1RLU2FubHpUd0s5?=
 =?utf-8?B?WnZUYmVwRE9FcFEra0tzOXNhd3RYT2FNUXp5K2dMSXdscGl6d3ZCTC9vMkQw?=
 =?utf-8?B?OVBTV2RIbHR0WlZBUWkyR1ZvWUp4V3lGdVpueXVxaExZYTBIWk1pODY2dHo2?=
 =?utf-8?B?V1Q4dFNiRWNaclFJZjlTSjNDcUhHVnROZDZIbDRHZTMvbkZoRnA3dHB0d2h4?=
 =?utf-8?B?WEJPRDBkTEtxQUJXWEVnUlRZOGJmM1ZCS0NtTFVtOWVCejBGK2I2bTIrUGMv?=
 =?utf-8?B?U2ZKc3ZDTkdQUVVQSmNvL3ZFRCs0WHZBOGgrRGJpclhXb2xHR1k3MGVGMG1S?=
 =?utf-8?B?N0dIc0UxOThHN3NRTXpVOWEyM2IvaGtEdHFYWDlYSXhNeWlSZkg1WFd1Q2JR?=
 =?utf-8?B?Z1pka3NFRndtS0xpVWxMTmcwWU9FcFhjaU04djVUOFdkbGlPV2ZoTGtlOUZD?=
 =?utf-8?B?WU8wSUxSY2VUSklabTh5elBiR1VtTHJyUStIbUFPWmRiZ1d1MkxKQVBzTFZp?=
 =?utf-8?B?YzRGREQ3Ly8zSmF1dEptak82UjlLMHg2MHdRREk0R1J0bld0c3FTTjhKVjNY?=
 =?utf-8?B?TDUxY3dEd3lTQnFxRTcvb3F5Wi94NEh5UTVsb056alViSjBSMGpnSEtXQjNU?=
 =?utf-8?B?bE5QYW1XT1JZMHpkdzkzaEh2YUtYVnpYeEZRTEkveGx4NTJENllJNWNkKzhI?=
 =?utf-8?B?RlU5UjBLKy9lYXVRVnFIdFlmUDVyUVpFWElFRFpmRGlBMFhEZlluZlFtWmNi?=
 =?utf-8?B?S0dzVkNWQkpzcmxvQmJxVVE1ZFhUV2tkVFRrajJ0cy9TeWN3RHZOS2crK2Vk?=
 =?utf-8?B?U3VqTmY3ejVPUUhlVVQyMkFwZFM1OGRnZVM1NkZrK25pS0hJaU8rVTBZbndt?=
 =?utf-8?B?YzVNM2ZFcW9jZi8rUUVadkx2N1RFV0RNYTNoQVVoNWwrZ2xhcVZ2ZmdlTys4?=
 =?utf-8?B?dFh3N3pYTXVvdVI5QzVxakM1eGdvRFdRVzVnMDdEempJQTU2L3BENFhHRGZC?=
 =?utf-8?B?UWpFTDNOUi9Tc0tlc1ZudWxoc0IxSUJOK2liVmhlUnAvUjVnTC9tNFdibGRo?=
 =?utf-8?B?ZnRzWVAvZnhzbWZvOHk2M2lOZHd0anNvZi8xZTVqVjdiTXlQZU02WEtzVHFi?=
 =?utf-8?B?NE51cWlYbEJaSnZGREhPWFJkVUxoMy96TWlQUGhvck15VG1URXpXVE04ZWpU?=
 =?utf-8?B?MVJFd2JOWlRaRVV4dWFsWW5EK0xXTG50cUJtNlR3VlQ4RlpNOVVuWlpXZzJU?=
 =?utf-8?B?cEFHYm1hS3NVVUozaDVVTTlXMHlMdEFEM3FidVgxUmJibENkNGFJZm9obmdM?=
 =?utf-8?B?R2QvV09CYmpBYmNiWFFMZWlsNzkxUGZ0akwxT25VYm9sVlIrcUQrb0t4c0dI?=
 =?utf-8?B?ZEF2WkNvV0JCaEl2OVJDdHZnV01DM29tMTFDV1F2VjBOYk1qdWR5SWlKYW80?=
 =?utf-8?B?Njg2VE9GNHN0YTQzTW0yY2FnZ0NlbWVGRmF1MHFieVlTNW1ybm5rUmJOcjhk?=
 =?utf-8?B?aUlkZGlvNWRyUjFkOTJmbkVKaFI1UG83TTVYT0ZVdTlSVnNlbC9nb0FiNlZU?=
 =?utf-8?B?VDJUSmo0RVlaUzcyNjVseU5TcllNMlIwamE1WHhZUGtxcm1MOEMvMUdnNG54?=
 =?utf-8?B?Unc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a12c0b9a-1ed6-4155-1a36-08dc70c09be3
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2024 07:12:53.2507
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7o0DN8YpdqdcK6k1GTipZ9P6ArMgEAt7NLjfeC2tbmmOmjFBRyvUuGvPDfUKrarbumjdLgkB8n5xX/ZoWstZfFwvZc89dHKmycQ+rjf3i5k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5065
X-OriginatorOrg: intel.com

On 5/9/24 16:46, Alexander Lobakin wrote:
> There are several reports that the DMA sync shortcut broke non-coherent
> devices.
> dev->dma_need_sync is false after the &device allocation and if a driver
> didn't call dma_set_mask*(), it will still be false even if the device
> is not DMA-coherent and thus needs synchronizing. Due to historical
> reasons, there's still a lot of drivers not calling it.
> Invert the boolean, so that the sync will be performed by default and
> the shortcut will be enabled only when calling dma_set_mask*().
> 
> Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Closes: https://lore.kernel.org/lkml/46160534-5003-4809-a408-6b3a3f4921e9@samsung.com
> Reported-by: Steven Price <steven.price@arm.com>
> Closes: https://lore.kernel.org/lkml/010686f5-3049-46a1-8230-7752a1b433ff@arm.com
> Fixes: 32ba8b823252 ("dma: avoid redundant calls for sync operations")
> Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
> ---
>   include/linux/device.h      |  4 ++--
>   include/linux/dma-map-ops.h |  4 ++--
>   include/linux/dma-mapping.h |  2 +-
>   kernel/dma/mapping.c        | 10 +++++-----
>   kernel/dma/swiotlb.c        |  2 +-
>   5 files changed, 11 insertions(+), 11 deletions(-)
> 
> diff --git a/include/linux/device.h b/include/linux/device.h
> index ed95b829f05b..d4b50accff26 100644
> --- a/include/linux/device.h
> +++ b/include/linux/device.h
> @@ -691,7 +691,7 @@ struct device_physical_location {
>    *		and optionall (if the coherent mask is large enough) also
>    *		for dma allocations.  This flag is managed by the dma ops
>    *		instance from ->dma_supported.
> - * @dma_need_sync: The device needs performing DMA sync operations.
> + * @dma_skip_sync: DMA sync operations can be skipped for coherent buffers.
>    *
>    * At the lowest level, every device in a Linux system is represented by an
>    * instance of struct device. The device structure contains the information
> @@ -805,7 +805,7 @@ struct device {
>   	bool			dma_ops_bypass : 1;
>   #endif
>   #ifdef CONFIG_DMA_NEED_SYNC
> -	bool			dma_need_sync:1;
> +	bool			dma_skip_sync:1;
>   #endif
>   };
>   

very good solution with inverting the flag,
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>

// ...

