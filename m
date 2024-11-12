Return-Path: <bpf+bounces-44645-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 48DC19C5DB1
	for <lists+bpf@lfdr.de>; Tue, 12 Nov 2024 17:50:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D3ADBB3840E
	for <lists+bpf@lfdr.de>; Tue, 12 Nov 2024 15:20:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF6A820012F;
	Tue, 12 Nov 2024 15:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WvbJvWrk"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B5F41FF046;
	Tue, 12 Nov 2024 15:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731424826; cv=fail; b=hUYjpfSpLEqZ3Tki2EXikkKkcMnbPNRVjvpugDdzrdrk0DL+OftRS/UYC5pdDlGMUMer3gbs+zjYrOh/klNJMaEM9uKt9JKimIdCPd9y/hI2jzB+LHZ4fuzwaJjcTXeTKpnkXgXVOvNNjHzkGYS9e0kFlzdpQ1dXnOylpokx/os=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731424826; c=relaxed/simple;
	bh=ZF9+2vDlA2gsHbJ51zvOE7MOJKewJ3gP/yBSVXeHxQ4=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=GWyKGO1M/UgrWqXKjQw7/2vULeun3VQkHl5twud3d7I8uhEoM+pDf/afknj1lx8WJPD/cXtNzXmnEmLb0W1GT3b3NlxunsttkIVrYP++MqrW3dEWo2XfjOpWO4ygkSvLj6TeeZm7xCV8kz8NwseQDnJuyiGPBRdMFqY0STATIrI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WvbJvWrk; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731424824; x=1762960824;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ZF9+2vDlA2gsHbJ51zvOE7MOJKewJ3gP/yBSVXeHxQ4=;
  b=WvbJvWrkgrtlrHQIoHueSJgvnVOM28Mr5JiLTZAtvweBNLBacHZe/APD
   F6IisJBc4fya3iwFW8lx++tx3/Dc57D5Tqcd5TFrQlmIq3+H99I1QJwrQ
   ZM3MbEY1Hap53Ar6Bh15kPJQPhEU1q7YsLF9RR1JhQ+1g0qiMf9R3TCLJ
   GxNcfXAfLXwWNItZO7qY1xyM17BiX9jkdp21ZdPQDg18mNysyKTIb2uKv
   cb/B5SRLDQNRPAPyukv4xVfwFOv06+eAA2dyjLOg2K+kU9t3uxS6n9gGU
   P50up3Tp65VCSe7eceQwDPfbKeGD2uP5swYxCAZ9W2MZL6u6DpDyzJ9ku
   Q==;
X-CSE-ConnectionGUID: oiJiYHnQS9muu74hvCo+yQ==
X-CSE-MsgGUID: BPhdHP0WTxWvBgn3s+8ZKg==
X-IronPort-AV: E=McAfee;i="6700,10204,11254"; a="30667450"
X-IronPort-AV: E=Sophos;i="6.12,148,1728975600"; 
   d="scan'208";a="30667450"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2024 07:20:23 -0800
X-CSE-ConnectionGUID: 1H1Ua9t5RI+oOX4ydm2o/A==
X-CSE-MsgGUID: 9rAMXKC4StiyBh4W5hDnOw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,148,1728975600"; 
   d="scan'208";a="92276726"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Nov 2024 07:20:23 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 12 Nov 2024 07:20:22 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 12 Nov 2024 07:20:22 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.176)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 12 Nov 2024 07:20:22 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ocg4yva7KkVthms0FQOJ/YER1d23rQSGUsRvXpCmyQ0CyLS2VNm/mJrRXeH9WwTNysKiZuEUlzx78CuXnxB1fYb/j+wusnC24z2nvwz124M/mu77qVRUM0gdQyGxw98wuFFJCxNPR22Dcdr5HqKFl58VP/rF/Hfxgcml6zcBAKgFmbK+BYYM8RW1S9zhuqO1N0uMJXtb9Xj21mmyW9yViGkSGcJ5wTWY9PgdCIn4qo/M+lwsu09PnwI8ugTLlZP7cOx30/r8jUJZsxuj9d4eGSBCW9w/ALKvBIihGFoyHhMc6JwEdDQHP71m5WgCdiB7NNO1VykdF89lAhM/9xQEUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xkqJTzKk9RL9iNVh3s9jjr92TuHMX2fMT8qgk2IIiBA=;
 b=hXcTToOaMcAFDdw/9zWcgu01QkwQoCj3ZN9Ob0M3S2nbvcbdNiYIkNa6n7ZW5tyUSGfFosutTq0aPQm//IDgDvmCYjHVjA4VqTH8SXr+4sMfeP/9T6luKxn48pDUjOZ0V2S0WOt054Kbinp6soocwZ/wKKYzQ0Qj68crEABohy0HSP1XCY+UJ5eBR6wqZ3fu7ai3MDi1scCejMaLsmv2hLtXmXWUF033wPktcYnpazw1O72GkS3Um3s36XIar1WHip3DPdddMoJ1OE2NYDxJn/1Jfz+cZsd/lvilGYoO4Z+NNmAAlcRoOkziFM6x/KRxTlMa9tSTjgz9B9QZ+mAaDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by PH0PR11MB4792.namprd11.prod.outlook.com (2603:10b6:510:32::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.29; Tue, 12 Nov
 2024 15:20:19 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808%4]) with mapi id 15.20.8137.027; Tue, 12 Nov 2024
 15:20:19 +0000
Message-ID: <e35afda3-a64a-432e-a69d-80519eb0ff33@intel.com>
Date: Tue, 12 Nov 2024 16:20:12 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 12/19] xdp: add generic
 xdp_build_skb_from_buff()
To: =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
CC: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
	<daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, "Andrii
 Nakryiko" <andrii@kernel.org>, Maciej Fijalkowski
	<maciej.fijalkowski@intel.com>, Stanislav Fomichev <sdf@fomichev.me>, "Magnus
 Karlsson" <magnus.karlsson@intel.com>,
	<nex.sw.ncis.osdt.itp.upstreaming@intel.com>, <bpf@vger.kernel.org>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20241107161026.2903044-1-aleksander.lobakin@intel.com>
 <20241107161026.2903044-13-aleksander.lobakin@intel.com>
 <875xot67xk.fsf@toke.dk>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <875xot67xk.fsf@toke.dk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MI0P293CA0015.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:44::8) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|PH0PR11MB4792:EE_
X-MS-Office365-Filtering-Correlation-Id: 931cc2fa-a0ab-41ba-92ba-08dd032d848c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NzNMLy9XQmJmZnhsV2FLRWpuQUZjY2lITjMzN0pFektiSThRWWhWTTAxbFFw?=
 =?utf-8?B?dzlIcVloWWJBTkhyMEd1dFUwMEtyOFdNUGt3Tk1EL1ZXd1E0LzQ1RHVGSVFs?=
 =?utf-8?B?QXViMVQ3MkQvYVFycnRCWkVGU2s1ZGh1eGhFbWYyUjlPeUtFdWRLd1FNQnN3?=
 =?utf-8?B?ay8yaVpmblh1N3VJeUd2b3hjK0pOclh6SXlrbTRBTzBYNnhyWW1tSVkwajBW?=
 =?utf-8?B?MEF3NXlXcnNlbG1oTW0vdFkvbFh1NDBOS2RTT3lFdmU4Vk9WMVNUUUN2Z2FP?=
 =?utf-8?B?R3dUSjV3NWx4bmgxVmJuWVVMVXFid0l5K1RseWNXYmtpMG5OR0lyenY4T2ts?=
 =?utf-8?B?L284UkZMdXlwcmg1VmpmWTZudlU1NXJTNmtRekRqWURPSXBhYkRQZWhmcEVx?=
 =?utf-8?B?SGVTOGtOcTdGUTdQNVNldXJHbHhvMVY4S3FhbmxVSFVYOGd0eExVTGNJcCtM?=
 =?utf-8?B?QXI5K20zVzUrR0t0Z1hEazlaOHhmV0k2Zm9ZdjgzN1FqcEV2T3dEeVo2N3cz?=
 =?utf-8?B?cGFDbzhkajN1Q1pWUUt0eEpDS0RFMytiNkFGL3V2a1lJT1ZsUEFYVStMeGFm?=
 =?utf-8?B?aHdvMlRwa2d5Zll3bTVFbGc2VjdvamdudjRQakFLa1ZVQ1VRWGtvcE1UUXV4?=
 =?utf-8?B?aVE5YWo0NDlpcjN6b09pZnFzMi95YWY5TjZOenVsdjdQSW1YSmwwTG15Vmdm?=
 =?utf-8?B?QlRzR0R1ZVNuZm9FcXRyM284MjFEaFllM2xKR1NNc0JnUzhpV296Z1l0WUQx?=
 =?utf-8?B?N3locWNtVHF3NXQ3SVNqbm94bmE0RjdFMStLY1ZKM3ExV1FMcGgrblkwdW9r?=
 =?utf-8?B?VTBQOWJTamhOc2FIVXZwOXovSU82bGQwVXlMTVduTEJJdWMzUkZPVm1senBv?=
 =?utf-8?B?Q2l3VU52NEh3TTZ4ckF1ekNTV0NxVDUraEpnV3Mvcm50ZGR3ZkxEdEQzVisx?=
 =?utf-8?B?RmJzQUpSSlFhNnVEbGtjMmo4Z1FyLzUwalhDMUlqdzdnbGdKTkd3Yi9yc1hh?=
 =?utf-8?B?Mnd3UFZ1K2o0ckJyR1hQUTgrUXpTOWRMV3lydGk4OTR6U0k0elEyU2UxWURI?=
 =?utf-8?B?QnpjZ3JRSkhIUWJ3VUZEaG1hSUp5QUxsNkpiTHhpQy90cVdBd3QxM0NEZnlX?=
 =?utf-8?B?TklURkdDeVViOEcxQmV1eXRCM3RYTjFQTU91N2IxR0tHdWlmUktVTFRzd09D?=
 =?utf-8?B?aURhNldwbGVhMU5FUUd2cU9qZFFnQk1lSDRuelVobGdVdHdxdkd6WVRkbU5y?=
 =?utf-8?B?SHl4VW1BRGZ5dmNrVHlBOGpKY3NVS1lPaTJ4YnVRZUZEajhUcFp1WllHbHJP?=
 =?utf-8?B?dXExamdCcmN1R01oajNyQWNGMnJYVnVNZm5KMENuRTQzUnhlbzY1dGRTd1NT?=
 =?utf-8?B?U25zMnZyeXBwQUdKamZRdThuRVRuUUtLWk1Xd056ZlJ0V3pEYnZuMEdvb1Zq?=
 =?utf-8?B?RnRPWHkzeFljV3VpeXVFSWRxTHJCdmwzb2RHck1wY2FoV0diNGdYT2tDTjF2?=
 =?utf-8?B?aFVrVG1QSS80NGRpMWwzRlVxbXZRRm1ScnF5VnZkRkI4aDJqMHVlL2pMTkY5?=
 =?utf-8?B?Q243RFBEY1I2U3Y5NnZXQ0NBSXVmYkY0alRmcXVqSVhnNEZMQ1M2UWptZm9u?=
 =?utf-8?B?MnhnSHVwTkc2UWJ2dXNlelJlRml4U3FaS2h1OWRxeGFMMEdvWUpaTGlVVHJY?=
 =?utf-8?B?T1VsL3AyNFNVRFluV2NFeTlobnZ3VE5UeUlXWHluMVYySSszZTdHTmduUVAr?=
 =?utf-8?Q?eYwzCoCS4H7v+AF+pw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b2UrSHc1M05CSGJGaTQ1Tys3SHdMdWdtckNDV3VLOVFKdWNZV0JCRTFaUGNu?=
 =?utf-8?B?ZWZrRjhiZHk4dkFWdnJpUS9wNjdJVzJQZjliREFXUFlZQjkrMkZJV0g5L2VD?=
 =?utf-8?B?YitHVVNxUFRxenlCUCtXRWxjQ3krOENhejZIcm5WeWdnRGR0RmpwbXBBZXJn?=
 =?utf-8?B?eUcrMTV6VTdoaVBFcFNuZHF3U2Fsc3JXVzlKM0U5dFlIbmcxUVJXdk5lTWVM?=
 =?utf-8?B?dXl0ZHhFWUFRVnBRWUZZRFRoUElGU3BWamY0SWRDeWx5elR5SHZEd2dsUTZT?=
 =?utf-8?B?MFh5VDZka01mYVd2TjdaNWlpbVBZRXcwQlJGTncxeWJpUWRFRHdORys2d0dT?=
 =?utf-8?B?WGtpY3IxVG9MY0g4VG1takhBR1hNVXg3d0hYWkcrK2lQZzhmejduNWMwbGRw?=
 =?utf-8?B?SHdEU0dlQ2Q0T2pvekRtRVhOZC91bmhnK2pDaHJOZHFWWDkxb2JQVGFWQ0gv?=
 =?utf-8?B?TGJWWU5COTRqRjc3NzFrdzAvOHVjQkRMMVBYbWZpYTZjbVFRcjR3cmFWZWFZ?=
 =?utf-8?B?YjdoTjR4cVgwM3ZITDJkNU0rQjIrRzdnbWFtQThJTkJmdVhiTjN1eUFHSkk4?=
 =?utf-8?B?R1BVTWd0a2ZzR2l0ZW0zaVlwMlh3ZEh0UGM0QnkzSEpiYmxBQUdOK3VvRlJ0?=
 =?utf-8?B?WUR6dkllbU0yUWwreE8xdzFFTEsxcGhuSVRvTEFQZWowdnlNZTBmOWlaNUJJ?=
 =?utf-8?B?RG5hYUp1ZStzLzllOVV4WUVlbGhRc0hzWFMvb2RjaVBRblBwSlVlNC85L1NH?=
 =?utf-8?B?cWNYZVdYUTRwdW9KMCsyN0hhWlJIU2lXb3UwOUpQOW1DNFVqY00ra0ZCakRG?=
 =?utf-8?B?b1luVll6Qmdrckt5NWF1bHFwVi9qSjVITzE5WWwxWlBZVjYxZElwdGNNY1BG?=
 =?utf-8?B?Q080b0orMm9pa0RiUFJDVXYraGxWaUxLN1g4bjBDZnZtNHUzWEJrNW5yM0JV?=
 =?utf-8?B?K0syUXFqYVA1c2N5Q09ibmdSejR2NS9wUDRZREZjY0lpU01qaTMrdGFRdnhK?=
 =?utf-8?B?YlFsbGR6cHVtMW9BMUl5Vi9tdFdHVFFwV29mTkIrUHZLZ2FocmhFdGpIdGlN?=
 =?utf-8?B?RHBuSUwwRGVvTktZVDJHdlZlaDlkaUtQYVJ4d0JuU2pjNEMvNlpIU1hrdy9n?=
 =?utf-8?B?b0t3N01vdTNOZlphZ1FDYUd2YmxBL2Y0Sk5GSzIrdGVCR2NPL0lOdHpvbGc1?=
 =?utf-8?B?NWFybE5mYW9NYWgxbkU4clVaeFJ1WE03WXJ6NnlPdC9JY0lyR0RnUFlmUlIz?=
 =?utf-8?B?ZzVMd0txN1luMHZlaWkyVjBka2NnUjYyK1dKTStyTzFVMnNoYnJLNDJLdjhL?=
 =?utf-8?B?S1h3Tmc3SnVoNFR1N2dZSmUrdWtSOUJjMUtnNStRQVVUNGRFUXArMWw1bkt5?=
 =?utf-8?B?VFkvM2dWRXR4c0Ftd3BNd0luWC9QMWZzSFJ3S052YktQSDdRa0sybjk4bSs4?=
 =?utf-8?B?QW9oRXk5UjRqZytOTmhtTWd3R3laMVhZZDg5MVlVcmViQUIreVlpL1BQY3lZ?=
 =?utf-8?B?bEZuSlo1S0lOdm4wdnAxV3h6U3RtVjJqYUpHMm8yNE80RGFkaEEyNDFJVThO?=
 =?utf-8?B?VnlWYVdRZlliVGRIbGZQY1BIVnhDNkhEMlQydVhsYTQ4YmE5K0Q2aFk3NlRZ?=
 =?utf-8?B?QlJIeEVQUFFCRmgzVjJUOGY3Q29McS9CYTFsdU14UjJpR052clhUblh0UzZw?=
 =?utf-8?B?d1d0VkVBWlFQMXpkTklhLzRaNERIUnh3aXl5WHh6SkoyMk9wTTBpc3JRZEw4?=
 =?utf-8?B?ajVyZk5sSFNzMCtvSlRhVzdjWnhuUFNmZUlFZWRLUVNaTklUeFR6eW9XOU5r?=
 =?utf-8?B?NUMwUnloTXFWYjlaQ3l4U1Y1Ry9FdDVUWjU2cXZRMHh3WlZnZnRoM0hDWGRW?=
 =?utf-8?B?VkVkTjBOVnVTaGhGYUM4NzZOZXYyb3FOWGRpemVLdzA2Rm5HMEUzeG84WHc3?=
 =?utf-8?B?cFExckQzdHBsYjFxRmxsSmdLY1RUREQ2ajc0Skw4VjErZ3RNcXpUQThaeU4z?=
 =?utf-8?B?YkdYSC9TajJuTi96aDlvdnRBQjNnaUpYcEErUnRSaGJBZlQvWWtDQ3NVcy9S?=
 =?utf-8?B?WkJlUGcrY1kxOTlTZndtT0owSE5uSnpKUzduM01UQkw5RVA3eVkraU5KY3ZF?=
 =?utf-8?B?OXY4dExzN2d3UzNYSnJ2NE01WU5SWUQ2VTErVHRjaEpkeWxzYVJrb0RyVGhX?=
 =?utf-8?B?ZUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 931cc2fa-a0ab-41ba-92ba-08dd032d848c
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2024 15:20:19.1701
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bPPt3hTqZjLEyEJd++v/Ot8wSTvhmfrgpsNr5DqMd0OMC4LoVWRu2Bl1hnGBwDTw/9invGTsY2Bzgdr+1aSXrsZx0bCpdQ3IqUfWtmy2H7g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4792
X-OriginatorOrg: intel.com

From: Toke Høiland-Jørgensen <toke@redhat.com>
Date: Mon, 11 Nov 2024 17:39:51 +0100

> Alexander Lobakin <aleksander.lobakin@intel.com> writes:
> 
>> The code which builds an skb from an &xdp_buff keeps multiplying itself
>> around the drivers with almost no changes. Let's try to stop that by
>> adding a generic function.
>> Unlike __xdp_build_skb_from_frame(), always allocate an skbuff head
>> using napi_build_skb() and make use of the available xdp_rxq pointer to
>> assign the Rx queue index. In case of PP-backed buffer, mark the skb to
>> be recycled, as every PP user's been switched to recycle skbs.
>>
>> Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
>> ---
>>  include/net/xdp.h |  1 +
>>  net/core/xdp.c    | 55 +++++++++++++++++++++++++++++++++++++++++++++++
>>  2 files changed, 56 insertions(+)
>>
>> diff --git a/include/net/xdp.h b/include/net/xdp.h
>> index 4c19042adf80..b0a25b7060ff 100644
>> --- a/include/net/xdp.h
>> +++ b/include/net/xdp.h
>> @@ -330,6 +330,7 @@ xdp_update_skb_shared_info(struct sk_buff *skb, u8 nr_frags,
>>  void xdp_warn(const char *msg, const char *func, const int line);
>>  #define XDP_WARN(msg) xdp_warn(msg, __func__, __LINE__)
>>  
>> +struct sk_buff *xdp_build_skb_from_buff(const struct xdp_buff *xdp);
>>  struct xdp_frame *xdp_convert_zc_to_xdp_frame(struct xdp_buff *xdp);
>>  struct sk_buff *__xdp_build_skb_from_frame(struct xdp_frame *xdpf,
>>  					   struct sk_buff *skb,
>> diff --git a/net/core/xdp.c b/net/core/xdp.c
>> index b1b426a9b146..3a9a3c14b080 100644
>> --- a/net/core/xdp.c
>> +++ b/net/core/xdp.c
>> @@ -624,6 +624,61 @@ int xdp_alloc_skb_bulk(void **skbs, int n_skb, gfp_t gfp)
>>  }
>>  EXPORT_SYMBOL_GPL(xdp_alloc_skb_bulk);
>>  
>> +/**
>> + * xdp_build_skb_from_buff - create an skb from an &xdp_buff
>> + * @xdp: &xdp_buff to convert to an skb
>> + *
>> + * Perform common operations to create a new skb to pass up the stack from
>> + * an &xdp_buff: allocate an skb head from the NAPI percpu cache, initialize
>> + * skb data pointers and offsets, set the recycle bit if the buff is PP-backed,
>> + * Rx queue index, protocol and update frags info.
>> + *
>> + * Return: new &sk_buff on success, %NULL on error.
>> + */
>> +struct sk_buff *xdp_build_skb_from_buff(const struct xdp_buff *xdp)
>> +{
>> +	const struct xdp_rxq_info *rxq = xdp->rxq;
>> +	const struct skb_shared_info *sinfo;
>> +	struct sk_buff *skb;
>> +	u32 nr_frags = 0;
>> +	int metalen;
>> +
>> +	if (unlikely(xdp_buff_has_frags(xdp))) {
>> +		sinfo = xdp_get_shared_info_from_buff(xdp);
>> +		nr_frags = sinfo->nr_frags;
>> +	}
> 
> Why this separate branch at the start of the function? nr_frags is no
> used until the other branch below, so why not just make that branch on
> xdp_buff_has_frags() and keep everything frags-related together in one
> block?

Because napi_build_skb() will call build_skb_around() which will
memset() a piece of shared info including nr_frags.
xdp_build_skb_from_frame() has the same logic. I'd be happy to have only
one block, but I can't =\

> 
> -Toke

Thanks,
Olek

