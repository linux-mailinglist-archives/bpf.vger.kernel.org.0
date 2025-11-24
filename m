Return-Path: <bpf+bounces-75366-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id BBC15C8196F
	for <lists+bpf@lfdr.de>; Mon, 24 Nov 2025 17:33:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1A442348CA7
	for <lists+bpf@lfdr.de>; Mon, 24 Nov 2025 16:32:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7924F29ACC6;
	Mon, 24 Nov 2025 16:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dh6RNLsB"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC22E25A2BB;
	Mon, 24 Nov 2025 16:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764001918; cv=fail; b=RVmCztMgHopKW/0ADBKmrXrV7rkmWBsTAaQNQMvuus8kPJc2XeY5WzB1hz+1h9So43S1wqqQ4OIsRVxkQg5cZsMe2bLWhdVn2+q4jSWW0iYFKIgo1/hcb4Qig2pPPLwmeeAdZ+EgTZwqNOyjesFJbx83vzxiFbl8ire5Ycfe6hU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764001918; c=relaxed/simple;
	bh=xIYJ9OHnyoDt+OSwINSmnkniDlcloSumV49eULLOWQc=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Rt8LG5MckrcuXXwuK10VTGrmvexCGXJZ5p8BVCbJcZ8OrrwI5xwib5E9Erd3Wh+X6zNaIqkDZFVQmL7Krl1DyRTnwMpHDPJVu+1iseM+WwSGF/vcK6nFdD+YFH2GUZ/IFT5nHnvdpJ5mG/fQBIcDPLGOMOKHsZVlzSlF2ES9QKo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dh6RNLsB; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764001916; x=1795537916;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=xIYJ9OHnyoDt+OSwINSmnkniDlcloSumV49eULLOWQc=;
  b=dh6RNLsBWxJ4EXmyvQkfi7p+/M0diAusGnkofzM0iqnAK4NeAWaVHhUX
   HUCqIg8uVtvqcHC6bygWSR/+YbPH7a/e3U7LScDnv16jVtP3JttQdEIFC
   Xv2MO29gpRyTkB1bERh5ltviMn5jPhE3qlU2+mz84CfALUxphcNl8Arqi
   0mz+gTNTzGFbEuWd1KfrQ7rPedWVej6tKoQPQNNdNhyNHpOrQ09dG1q6J
   xEj7Nn6wdLhF/OiMMPy52T9GjH9bQXojMVQjJRuH6TKSdE3oFZmBUIP/0
   jjCOL7leNHdQDliRzOoIf76PMEEusPLFzryKJgbxuWIWayGbK9TG7uqta
   w==;
X-CSE-ConnectionGUID: jpdxavVDQcSpjRIHjZKc8w==
X-CSE-MsgGUID: Rn0GtTMmTRyGetAZLyradg==
X-IronPort-AV: E=McAfee;i="6800,10657,11623"; a="65189701"
X-IronPort-AV: E=Sophos;i="6.20,223,1758610800"; 
   d="scan'208";a="65189701"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2025 08:31:55 -0800
X-CSE-ConnectionGUID: +V3Hns6hQ0ewJguX7jnkLw==
X-CSE-MsgGUID: Ge5gpVT9Q6CWlNFGAV9sAQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,223,1758610800"; 
   d="scan'208";a="229663110"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2025 08:31:54 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Mon, 24 Nov 2025 08:31:52 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Mon, 24 Nov 2025 08:31:52 -0800
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.43) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 24 Nov 2025 08:31:52 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zGCvGJUd7rTEML7dEys8qN6wQ3HF86S3585mc04PU6sB06vcCgC7pSr4HIl60kFZ1HoLWsoFe4uD7KMAgRdzcJBa1aGD8+h4v1koRCmdCF8gvf2xOuWGyv1tudfFZJrSA2wSshYw1Zm7jiJjUD7WKfHUlPx39P7FyfUwDW5cEFi1GQN381fjohgO84qCQKbDpLLkhO7jtu83J+iTDEh9+q8MVyfAdqh7zZmYwNZp1cPRMh3c4crnmlCshor7yX35FqoLYgM62QjNW356NLLaQWREDhVRIlNLg+HYkRHwKg9WOtGxOVcC+q+6MYQUu9GTO4EM/UQ3ZLRQAXP4WzNWOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zoUO+Bl1VoZHfagWhz1KQQeDTzm3L1xhuvc6nviUQIM=;
 b=DXfvZU1FnX2chOLHgvLjbuy7OdYbuOkSkKNAPvFYpq431yUSULXngGT0kgfl9uquN+vOMPT8u4rVzmEwuI5yfcwm0K8POEoDD3s9FFlPKor/XKJ//ilSKje25lcskbiOiTz/Nl7VJ1iIz9G/kXlTsRaAWPHZyn0smC36x+bj6ubQByzav+pe/6L7ZgMOE50UlBRrg1+Sk1Y0tQSpw2izSb8pf2eDYZrxTazb24oUw+nI80zCg5qkjzMtCWvBL8VQHdxDWnmk1sjZJm9Gl1/r3TOyc7umwJDszD2yBlrRQYeU6ITOJUVU20KF/vItBzcZiG+qQjyaQtjztUMy87Gjiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 DM4PR11MB8091.namprd11.prod.outlook.com (2603:10b6:8:182::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.17; Mon, 24 Nov 2025 16:31:49 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca%4]) with mapi id 15.20.9343.011; Mon, 24 Nov 2025
 16:31:49 +0000
Date: Mon, 24 Nov 2025 17:31:42 +0100
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Jason Xing <kerneljasonxing@gmail.com>
CC: Fernando Fernandez Mancera <fmancera@suse.de>, <netdev@vger.kernel.org>,
	<csmate@nop.hu>, <bpf@vger.kernel.org>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<horms@kernel.org>, <sdf@fomichev.me>, <hawk@kernel.org>,
	<daniel@iogearbox.net>, <ast@kernel.org>, <john.fastabend@gmail.com>,
	<magnus.karlsson@intel.com>
Subject: Re: [PATCH net v5] xsk: avoid data corruption on cq descriptor number
Message-ID: <aSSIbjlUGVaLUDKd@boxer>
References: <20251120110228.4288-1-fmancera@suse.de>
 <CAL+tcoDKxaOT7DiLg2=jQPLo+6OJqL7ZkDurXZAGXo-xbxoDWw@mail.gmail.com>
 <01a09fe7-9f58-4fc5-a84d-12d5b4b92bbd@suse.de>
 <CAL+tcoBueigrGnKASad7XFybXMHvj5jAOcZS8_bY3J-7XVZShQ@mail.gmail.com>
 <c68423d1-d4e6-4d13-973b-44a791a3c806@suse.de>
 <CAL+tcoAE6_15tOjZFrdif1ixBja3_qeUKL2GUvOyypcimLFJXw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL+tcoAE6_15tOjZFrdif1ixBja3_qeUKL2GUvOyypcimLFJXw@mail.gmail.com>
X-ClientProxiedBy: WA2P291CA0014.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1e::25) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|DM4PR11MB8091:EE_
X-MS-Office365-Filtering-Correlation-Id: 9952d58c-3e16-4b2f-016e-08de2b76f766
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dDM0bmxNWk0rNlJJMkxhYitSeSt3WlVFK1dhZnB1SDFmQzJVK09IRmg3T2g5?=
 =?utf-8?B?ejJiZDNSaEJ0ZTJGYUI4SHh1emxIVzFMQ3BoemdodWZaZzNRd1ZlQnBRdDhB?=
 =?utf-8?B?bXk0QWdjKzJUM0dYUnZQZ3BDRWxBc1RXc2xOZklYRytZdHRhZ2duKzVLTStO?=
 =?utf-8?B?N2Q3Nm1wQ1dkSEtzTU9OdFIxYnZGMDF0R0hxUDhMa09HQXd6MkgzRmJCN1pQ?=
 =?utf-8?B?OXZvTHpYQnJtM0V4SmVva0xRRGN0VFk2czVDS0tNbXFHdVpNNmZna0ZTQk45?=
 =?utf-8?B?M0hNZjRFSWQrSko5OWxJOGtiUFMxSEdtM1dRTll1dE16a1NPZEpwZGNoMUVz?=
 =?utf-8?B?RnFPU1FDRkpqbUdXenpSUE5zeTRqODZKNjBnQTRxSW90dk05NHZkMlpHc243?=
 =?utf-8?B?YkNJNkNNUEdSWEZDaitwTHc2SitZMlNaVG9LVGIvRmEvcjJoVk56NDM1VVM4?=
 =?utf-8?B?V0xFSmhVbStjdUJESjZmdGZaUmxmZDVLa1dCSUVPQWxmbzRacVFBWkxNT3Bp?=
 =?utf-8?B?K2UvUU00OUczK1dIYW1FYnhLTHBFQVptOWFPQm1TcGtPV3NoT1VSeTBsZ0Vk?=
 =?utf-8?B?V25ZbjkydDczQXJQdFlyYmlab1NaMklDWjdJY3ZUd2sxRWV1VFMyVlRUSC9X?=
 =?utf-8?B?OW1UT2I0S3diOFhvRUx6a0xBNThmdnhCRmxDenBWZFR5RmxBUjlNalJ0ZDBt?=
 =?utf-8?B?NmUxSjczM2ZyNVkyN0drZVo4SWFSQytmMlFRNHRGMG5qMmRscGpUK1licndV?=
 =?utf-8?B?a1ZCdHRmdWpvNklieXBYQ0hFU3p6UDdBaE9yNjk1ZEJCRVVSMG5kN0wyMjZu?=
 =?utf-8?B?dTRZVGVnZ2NLcW96elFUbXZ6Q1JtYktGNVMrUGR3T1Q4d3lGY1lIVnNOMjQy?=
 =?utf-8?B?ZDhzODBMbjEwckpiSWxnRytwM3BoZkFKR1JvZ3RiY1dPSm5QS3prTFdUOWt3?=
 =?utf-8?B?RHRYc0htTTJXZ2Z1bmo1MStxaVhiZVJKWGZiT3U1L25BTXFnUXBBcktpMEFV?=
 =?utf-8?B?TG16eHBvTnJvOVg1T1VmWmhXdnUzMnQ5eHVmbFhxQ3N5bmZtbm8rckd2ZkU2?=
 =?utf-8?B?UVdHK1E3bUpDK01IRERveForVTI0b1l3ZW42REFjZ3hJcThxREdHT0ErQ0hO?=
 =?utf-8?B?SU5SbjZsT0wrdlNtd2MrcFJ0bVMyMm1ucVo1T3NNeGJZanRsVUEwd3lPdjg5?=
 =?utf-8?B?dUx2YjM4YkxUQkVCbHNuMVV0V1ZxWExxQmJaTXpGWXVJdEdwc1k2UXR4THVQ?=
 =?utf-8?B?MDBUMEYrL2VqcWwyKzZUSy9WOXlwK2hGNjcvQjcrdlBRUkFscldjb0tkMlVQ?=
 =?utf-8?B?MFdxbzR2VGVqUGhoTHZUNmdYZzAxL3JqdDdXWmJ2Z2tablNiQytBRHVLdElF?=
 =?utf-8?B?VytndjhTZUh2Mm42S0hTM1kxbEU3empVWEZaeGl1VGpEY1NnTnBjVFcxdFNV?=
 =?utf-8?B?ZWVCeG9XK2YwUXQ1RmNuOHVZOTlCR2x6RHZNM3FLc2x4KytRb0pJS2ZBOStS?=
 =?utf-8?B?MTI1bDZ3TnZGWkMyc0NVTHNkeTZlN2xYYnRRelY2bFhtNm5hODFUd1NLU25C?=
 =?utf-8?B?M1FvOTVGTHRlbzhPQUprVzc0ckpGTW01QTR0SU9idGNiY0hUVk4vTVNKRGVv?=
 =?utf-8?B?emVNTlQ1ZWcra2hQUE1IYzRONXVhdFZYQ1A4NVpIbG4zd0dLTldqelJtd2xI?=
 =?utf-8?B?bml3WjFGSEliVGVNTXIxNUhROVY3eUR2ZkRjc3B4NDhhc092Z2RLMHFoQXd4?=
 =?utf-8?B?dUxuVWdKYVVNQTErR09pUUtLcDd2VldQdmErNGtOK0ErWTZiSmJTQVRNd3Nu?=
 =?utf-8?B?R3NVNzRVbUpZT245aWxtVlR6T2hjd1lLVmFVS3NLSWhlVkV6VWQzL1o0K1Bw?=
 =?utf-8?B?OFA1Zkozb3ZxbXlVaHJQVVlyR3VMVFYwSVF2enk3RUp6NEtWbC95QXNRQWt1?=
 =?utf-8?Q?HWk2m7mFVRvLcfTTIa+R5Tj/J+W0oObQ?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NXhDRTBjM0N5THA2QTg5N2FBVk8vcWdiNVNKSTVQUWFWOUFTd3BRcDlqVEdx?=
 =?utf-8?B?RHJPWEs4UVFPSjk3N2pkUHY4akJGak8zOTk3NFNnU0VtVVRMKzdGbUR4S3pP?=
 =?utf-8?B?a1Vmd0FrMHJoNmp0UzgwVHV6WVk3UnRTOWQvVUpaL3JqOGErNTM3am55QnlG?=
 =?utf-8?B?enJ5Z0QvWWtPZzlFN2t3MGx2TDJGYTRtWmR5L1hIa1hYN0xRTERZVkZyeERh?=
 =?utf-8?B?dHhlT2VxaTM4bUR1SnJiZDdZZVNobVBGV1F0L0VGZlRabWNtblVhQ21hYW5F?=
 =?utf-8?B?d3hSVzB4MmIyUUNhVHpzTzNxSXNRTlZjNk0vZ2tucW5XemROWUxNK3owTHUw?=
 =?utf-8?B?NGtiZ1NDaDFzamMwbEFBTFF4bHUyY0tQMGxvQ0NJUEVlM2JiMU5laEpQVGtK?=
 =?utf-8?B?UXNuWnZyM0pXWjRBeEhBRFhHRlpLZmkzdXJoNTk5SHUzOGNLZjU3MHBkK0NL?=
 =?utf-8?B?YlpOcmIxSEQrVUl2TzB4RHE0ZmszU2REOHU1WmZCRXo1eDdtRXhITWhWVnF3?=
 =?utf-8?B?UVlPMEVhck5TSVdRL3dUeE5WcW9pTDRkT1hzMmhiQ0dRQWpub2pJbnhEQnR3?=
 =?utf-8?B?bzAyc3hPK0lPQXBUR1FZRHBuaEh5MVZJUmducHlHNStDMjV5SU12ZFdqeWsx?=
 =?utf-8?B?dXpVckc2Wmg4M0dxRFY0NlFLL2lTTjRac0N4RjFiSGZYeEd4STlYZXkxcEpr?=
 =?utf-8?B?Z1RMbGpScmlUN0hvU1NTRnpKelcxTkRmTFJ3R3pCUHNySi9JczlVM3VkNjUx?=
 =?utf-8?B?b0pDVnoyeXZ3SmUwTURNNDhLTXhFSHhFYnVlZEwzbStVNmNHWnk3SXI5RzdZ?=
 =?utf-8?B?dFZHMmpuemFDUmlxSmdPdE1zbFllMmIxRU8zclpnZmdqRTJUS3hYS1dpWjVx?=
 =?utf-8?B?eHJiK25BQ1FBUmd5TUh2NGlVcG5BaC9tTTBVT2N2OU1iZlBRTWE2d3BoN3Rx?=
 =?utf-8?B?TjRPQTI0YkEvNHdTalNsV3lRK0RUV0ZwNG9WSkc3ZktsTEZzcVFhRE1oeVJy?=
 =?utf-8?B?M016YTRHc2JpdjU5SEliS2pITWhQaTRBamo4SStFWDNtZEU2WTlZWWdTU0JT?=
 =?utf-8?B?S2VUSmVKK3ZoTWhYYzQ5YzcyOGdtakFYY0JiRlk3UmR4dW14Tkd1T3A0dEdt?=
 =?utf-8?B?SkJxeDFoQ3l4MFh6dE1TMzZBUzhWOEdZN3VFSDNvcmRyTnQ1UzhPbFk2RDdz?=
 =?utf-8?B?UGFDbXIySm91RzluSmIrbGxnWVVFQWFCVVZZUllBY25QMHR4R0pFRkEvQnZp?=
 =?utf-8?B?dlBoQW4rUHVXc3BReGRaRk9hWUtVc0NaTnh4dktFZUdiVzB5N2dUZWlzbG9H?=
 =?utf-8?B?b1RjUnNwRlJ6QjcveWkxZjhUOUNUc2N1YjJTNHZhZU9XWTg0TE9peGhnOGMw?=
 =?utf-8?B?M0pJQnFWVWtPN3BSd3BKREV6VXlDTUZzcmtIWEhNRTZZZTlhQlV3MVpZQ2hO?=
 =?utf-8?B?VmZxSzNJb2FXTlcvWHF2RFRSQWUvU3VTVmgwSkxITzgxYmhGRWkvZS9UTStq?=
 =?utf-8?B?YU9kNVNpMEtkQURCYlBWdFV5dXl5bjh3cFBUUzduMHYwSldXWFhTbVArUXdQ?=
 =?utf-8?B?K0U0d1hHOEc2aFJCNTA5SkEzU1FVemJFVmZkWHJZUmZkcEVCUXJIQVRFV1F5?=
 =?utf-8?B?VUw4czFoaDhBd3pZZlJqaXJiNkNuTk5KU3JReTZ4cWU1TElyU3o4UENQTWNk?=
 =?utf-8?B?Z1RwTThQS0xOaXoxZk9SNC9zcWx2WWRvR3ExaCsvdlNIRmtIa2MwN0F3Szla?=
 =?utf-8?B?azAzZVhtT3F4azF6UkxZMDV4Zm1YeXNnM29EalVNQjlVTjIwa0VkeEQ4cVdt?=
 =?utf-8?B?S0Y1MkxpenZkZXVlanpHcUZ3Q3hRbEY3aFUwV2VXdFhTQjRNTjkvb1p5T0pt?=
 =?utf-8?B?RDhWb3R0UmJxSlIzUTNFdGRCRnIrNVVNT3NHQmNkSDNkTHJTazlaSUJjSDIv?=
 =?utf-8?B?eWNsaTNWa2JGdDVObE9tR1RXaXZXNnZhTXlkN29DRDkvNXBrRUU2VmNKR3Ay?=
 =?utf-8?B?QWk3SDAwdCtsc09IeDhxVjR1Q01nb3IrT2NWbVIvNHoyQWYwRWp6UG53eGNB?=
 =?utf-8?B?Nnh1dm1RK3IrNnRrZlZSZlp1UGpFVUs2LzEyN1N4N3JtVnRhakw0bjBIUUp4?=
 =?utf-8?B?T0JCUlVzYzM0bXo2aEhybWFXWi9GcEQ5UEs3Y09GTUF3Yy9KS2owNDZ0TzFP?=
 =?utf-8?B?MVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9952d58c-3e16-4b2f-016e-08de2b76f766
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2025 16:31:49.3066
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wFApZ4odlOi9mg5moIot0lkyuzLDgvAw+1HQmY0uFExgTojCmNy7fr/snb5/b2EewFYBmoLxRtgZSCcIWwANjOLtu0p2WnnnobGKrfHPGeE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB8091
X-OriginatorOrg: intel.com

On Thu, Nov 20, 2025 at 09:55:32PM +0800, Jason Xing wrote:
> On Thu, Nov 20, 2025 at 9:47 PM Fernando Fernandez Mancera
> <fmancera@suse.de> wrote:
> >
> > On 11/20/25 2:40 PM, Jason Xing wrote:
> > > On Thu, Nov 20, 2025 at 9:16 PM Fernando Fernandez Mancera
> > > <fmancera@suse.de> wrote:
> > >>
> > >> On 11/20/25 1:56 PM, Jason Xing wrote:
> > >>> On Thu, Nov 20, 2025 at 7:02 PM Fernando Fernandez Mancera
> > >>> <fmancera@suse.de> wrote:
> > >>>>
> > >>>> Since commit 30f241fcf52a ("xsk: Fix immature cq descriptor
> > >>>> production"), the descriptor number is stored in skb control block and
> > >>>> xsk_cq_submit_addr_locked() relies on it to put the umem addrs onto
> > >>>> pool's completion queue.
> > >>>>
> > >>>> skb control block shouldn't be used for this purpose as after transmit
> > >>>> xsk doesn't have control over it and other subsystems could use it. This
> > >>>> leads to the following kernel panic due to a NULL pointer dereference.
> > >>>>
> > >>>>    BUG: kernel NULL pointer dereference, address: 0000000000000000
> > >>>>    #PF: supervisor read access in kernel mode
> > >>>>    #PF: error_code(0x0000) - not-present page
> > >>>>    PGD 0 P4D 0
> > >>>>    Oops: Oops: 0000 [#1] SMP NOPTI
> > >>>>    CPU: 2 UID: 1 PID: 927 Comm: p4xsk.bin Not tainted 6.16.12+deb14-cloud-amd64 #1 PREEMPT(lazy)  Debian 6.16.12-1
> > >>>>    Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.17.0-debian-1.17.0-1 04/01/2014
> > >>>>    RIP: 0010:xsk_destruct_skb+0xd0/0x180
> > >>>>    [...]
> > >>>>    Call Trace:
> > >>>>     <IRQ>
> > >>>>     ? napi_complete_done+0x7a/0x1a0
> > >>>>     ip_rcv_core+0x1bb/0x340
> > >>>>     ip_rcv+0x30/0x1f0
> > >>>>     __netif_receive_skb_one_core+0x85/0xa0
> > >>>>     process_backlog+0x87/0x130
> > >>>>     __napi_poll+0x28/0x180
> > >>>>     net_rx_action+0x339/0x420
> > >>>>     handle_softirqs+0xdc/0x320
> > >>>>     ? handle_edge_irq+0x90/0x1e0
> > >>>>     do_softirq.part.0+0x3b/0x60
> > >>>>     </IRQ>
> > >>>>     <TASK>
> > >>>>     __local_bh_enable_ip+0x60/0x70
> > >>>>     __dev_direct_xmit+0x14e/0x1f0
> > >>>>     __xsk_generic_xmit+0x482/0xb70
> > >>>>     ? __remove_hrtimer+0x41/0xa0
> > >>>>     ? __xsk_generic_xmit+0x51/0xb70
> > >>>>     ? _raw_spin_unlock_irqrestore+0xe/0x40
> > >>>>     xsk_sendmsg+0xda/0x1c0
> > >>>>     __sys_sendto+0x1ee/0x200
> > >>>>     __x64_sys_sendto+0x24/0x30
> > >>>>     do_syscall_64+0x84/0x2f0
> > >>>>     ? __pfx_pollwake+0x10/0x10
> > >>>>     ? __rseq_handle_notify_resume+0xad/0x4c0
> > >>>>     ? restore_fpregs_from_fpstate+0x3c/0x90
> > >>>>     ? switch_fpu_return+0x5b/0xe0
> > >>>>     ? do_syscall_64+0x204/0x2f0
> > >>>>     ? do_syscall_64+0x204/0x2f0
> > >>>>     ? do_syscall_64+0x204/0x2f0
> > >>>>     entry_SYSCALL_64_after_hwframe+0x76/0x7e
> > >>>>     </TASK>
> > >>>>    [...]
> > >>>>    Kernel panic - not syncing: Fatal exception in interrupt
> > >>>>    Kernel Offset: 0x1c000000 from 0xffffffff81000000 (relocation range: 0xffffffff80000000-0xffffffffbfffffff)
> > >>>>
> > >>>> Instead use the skb destructor_arg pointer along with pointer tagging.
> > >>>> As pointers are always aligned to 8B, use the bottom bit to indicate
> > >>>> whether this a single address or an allocated struct containing several
> > >>>> addresses.
> > >>>>
> > >>>> Fixes: 30f241fcf52a ("xsk: Fix immature cq descriptor production")
> > >>>> Closes: https://lore.kernel.org/netdev/0435b904-f44f-48f8-afb0-68868474bf1c@nop.hu/
> > >>>> Suggested-by: Jakub Kicinski <kuba@kernel.org>
> > >>>> Signed-off-by: Fernando Fernandez Mancera <fmancera@suse.de>
> > >>>> ---
> > >>>> v2: remove some leftovers on skb_build and simplify fragmented traffic
> > >>>> logic
> > >>>>
> > >>>> v3: drop skb extension approach, instead use pointer tagging in
> > >>>> destructor_arg to know whether we have a single address or an allocated
> > >>>> struct with multiple ones. Also, move from bpf to net as requested
> > >>>>
> > >>>> v4: repost after rebasing
> > >>>>
> > >>>> v5: fixed increase logic so -EOVERFLOW is handled correctly as
> > >>>> suggested by Jason. Also dropped the acks/reviewed tags as code changed.
> > >>>> ---
> > >>>>    net/xdp/xsk.c | 141 ++++++++++++++++++++++++++++++--------------------
> > >>>>    1 file changed, 85 insertions(+), 56 deletions(-)
> > >>>>
> > >>>> diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> > >>>> index 7b0c68a70888..f87cc4c89339 100644
> > >>>> --- a/net/xdp/xsk.c
> > >>>> +++ b/net/xdp/xsk.c
> > >>>> @@ -36,20 +36,13 @@
> > >>>>    #define TX_BATCH_SIZE 32
> > >>>>    #define MAX_PER_SOCKET_BUDGET 32
> > >>>>
> > >>>> -struct xsk_addr_node {
> > >>>> -       u64 addr;
> > >>>> -       struct list_head addr_node;
> > >>>> -};
> > >>>> -
> > >>>> -struct xsk_addr_head {
> > >>>> +struct xsk_addrs {
> > >>>>           u32 num_descs;
> > >>>> -       struct list_head addrs_list;
> > >>>> +       u64 addrs[MAX_SKB_FRAGS + 1];
> > >>>>    };
> > >>>>
> > >>>>    static struct kmem_cache *xsk_tx_generic_cache;
> > >>>>
> > >>>> -#define XSKCB(skb) ((struct xsk_addr_head *)((skb)->cb))
> > >>>> -
> > >>>>    void xsk_set_rx_need_wakeup(struct xsk_buff_pool *pool)
> > >>>>    {
> > >>>>           if (pool->cached_need_wakeup & XDP_WAKEUP_RX)
> > >>>> @@ -558,29 +551,63 @@ static int xsk_cq_reserve_locked(struct xsk_buff_pool *pool)
> > >>>>           return ret;
> > >>>>    }
> > >>>>
> > >>>> +static bool xsk_skb_destructor_is_addr(struct sk_buff *skb)
> > >>>> +{
> > >>>> +       return (uintptr_t)skb_shinfo(skb)->destructor_arg & 0x1UL;
> > >>>> +}
> > >>>> +
> > >>>> +static u64 xsk_skb_destructor_get_addr(struct sk_buff *skb)
> > >>>> +{
> > >>>> +       return (u64)((uintptr_t)skb_shinfo(skb)->destructor_arg & ~0x1UL);
> > >>>> +}
> > >>>> +
> > >>>> +static void xsk_inc_num_desc(struct sk_buff *skb)
> > >>>> +{
> > >>>> +       struct xsk_addrs *xsk_addr;
> > >>>> +
> > >>>> +       if (!xsk_skb_destructor_is_addr(skb)) {
> > >>>
> > >>> It's the condition that causes the above issues. Please see the
> > >>> following comment.
> > >>>
> > >>>> +               xsk_addr = (struct xsk_addrs *)skb_shinfo(skb)->destructor_arg;
> > >>>> +               xsk_addr->num_descs++;
> > >>>> +       }
> > >>>> +}
> > >>>> +
> > >>>> +static u32 xsk_get_num_desc(struct sk_buff *skb)
> > >>>> +{
> > >>>> +       struct xsk_addrs *xsk_addr;
> > >>>> +
> > >>>> +       if (xsk_skb_destructor_is_addr(skb))
> > >>>> +               return 1;
> > >>>> +
> > >>>> +       xsk_addr = (struct xsk_addrs *)skb_shinfo(skb)->destructor_arg;
> > >>>> +
> > >>>> +       return xsk_addr->num_descs;
> > >>>> +}
> > >>>> +
> > >>>>    static void xsk_cq_submit_addr_locked(struct xsk_buff_pool *pool,
> > >>>>                                         struct sk_buff *skb)
> > >>>>    {
> > >>>> -       struct xsk_addr_node *pos, *tmp;
> > >>>> +       u32 num_descs = xsk_get_num_desc(skb);
> > >>>> +       struct xsk_addrs *xsk_addr;
> > >>>>           u32 descs_processed = 0;
> > >>>>           unsigned long flags;
> > >>>> -       u32 idx;
> > >>>> +       u32 idx, i;
> > >>>>
> > >>>>           spin_lock_irqsave(&pool->cq_lock, flags);
> > >>>>           idx = xskq_get_prod(pool->cq);
> > >>>>
> > >>>> -       xskq_prod_write_addr(pool->cq, idx,
> > >>>> -                            (u64)(uintptr_t)skb_shinfo(skb)->destructor_arg);
> > >>>> -       descs_processed++;
> > >>>> +       if (unlikely(num_descs > 1)) {
> > >>>> +               xsk_addr = (struct xsk_addrs *)skb_shinfo(skb)->destructor_arg;
> > >>>>
> > >>>> -       if (unlikely(XSKCB(skb)->num_descs > 1)) {
> > >>>> -               list_for_each_entry_safe(pos, tmp, &XSKCB(skb)->addrs_list, addr_node) {
> > >>>> +               for (i = 0; i < num_descs; i++) {
> > >>>>                           xskq_prod_write_addr(pool->cq, idx + descs_processed,
> > >>>> -                                            pos->addr);
> > >>>> +                                            xsk_addr->addrs[i]);
> > >>>>                           descs_processed++;
> > >>>> -                       list_del(&pos->addr_node);
> > >>>> -                       kmem_cache_free(xsk_tx_generic_cache, pos);
> > >>>>                   }
> > >>>> +               kmem_cache_free(xsk_tx_generic_cache, xsk_addr);
> > >>>> +       } else {
> > >>>> +               xskq_prod_write_addr(pool->cq, idx,
> > >>>> +                                    xsk_skb_destructor_get_addr(skb));
> > >>>> +               descs_processed++;
> > >>>>           }
> > >>>>           xskq_prod_submit_n(pool->cq, descs_processed);
> > >>>>           spin_unlock_irqrestore(&pool->cq_lock, flags);
> > >>>> @@ -595,16 +622,6 @@ static void xsk_cq_cancel_locked(struct xsk_buff_pool *pool, u32 n)
> > >>>>           spin_unlock_irqrestore(&pool->cq_lock, flags);
> > >>>>    }
> > >>>>
> > >>>> -static void xsk_inc_num_desc(struct sk_buff *skb)
> > >>>> -{
> > >>>> -       XSKCB(skb)->num_descs++;
> > >>>> -}
> > >>>> -
> > >>>> -static u32 xsk_get_num_desc(struct sk_buff *skb)
> > >>>> -{
> > >>>> -       return XSKCB(skb)->num_descs;
> > >>>> -}
> > >>>> -
> > >>>>    static void xsk_destruct_skb(struct sk_buff *skb)
> > >>>>    {
> > >>>>           struct xsk_tx_metadata_compl *compl = &skb_shinfo(skb)->xsk_meta;
> > >>>> @@ -621,27 +638,22 @@ static void xsk_destruct_skb(struct sk_buff *skb)
> > >>>>    static void xsk_skb_init_misc(struct sk_buff *skb, struct xdp_sock *xs,
> > >>>>                                 u64 addr)
> > >>>>    {
> > >>>> -       BUILD_BUG_ON(sizeof(struct xsk_addr_head) > sizeof(skb->cb));
> > >>>> -       INIT_LIST_HEAD(&XSKCB(skb)->addrs_list);
> > >>>>           skb->dev = xs->dev;
> > >>>>           skb->priority = READ_ONCE(xs->sk.sk_priority);
> > >>>>           skb->mark = READ_ONCE(xs->sk.sk_mark);
> > >>>> -       XSKCB(skb)->num_descs = 0;
> > >>>>           skb->destructor = xsk_destruct_skb;
> > >>>> -       skb_shinfo(skb)->destructor_arg = (void *)(uintptr_t)addr;
> > >>>> +       skb_shinfo(skb)->destructor_arg = (void *)((uintptr_t)addr | 0x1UL);
> > >>>>    }
> > >>>>
> > >>>>    static void xsk_consume_skb(struct sk_buff *skb)
> > >>>>    {
> > >>>>           struct xdp_sock *xs = xdp_sk(skb->sk);
> > >>>>           u32 num_descs = xsk_get_num_desc(skb);
> > >>>> -       struct xsk_addr_node *pos, *tmp;
> > >>>> +       struct xsk_addrs *xsk_addr;
> > >>>>
> > >>>>           if (unlikely(num_descs > 1)) {
> > >>>> -               list_for_each_entry_safe(pos, tmp, &XSKCB(skb)->addrs_list, addr_node) {
> > >>>> -                       list_del(&pos->addr_node);
> > >>>> -                       kmem_cache_free(xsk_tx_generic_cache, pos);
> > >>>> -               }
> > >>>> +               xsk_addr = (struct xsk_addrs *)skb_shinfo(skb)->destructor_arg;
> > >>>> +               kmem_cache_free(xsk_tx_generic_cache, xsk_addr);
> > >>>>           }
> > >>>>
> > >>>>           skb->destructor = sock_wfree;
> > >>>> @@ -701,7 +713,6 @@ static struct sk_buff *xsk_build_skb_zerocopy(struct xdp_sock *xs,
> > >>>>    {
> > >>>>           struct xsk_buff_pool *pool = xs->pool;
> > >>>>           u32 hr, len, ts, offset, copy, copied;
> > >>>> -       struct xsk_addr_node *xsk_addr;
> > >>>>           struct sk_buff *skb = xs->skb;
> > >>>>           struct page *page;
> > >>>>           void *buffer;
> > >>>> @@ -727,16 +738,26 @@ static struct sk_buff *xsk_build_skb_zerocopy(struct xdp_sock *xs,
> > >>>>                                   return ERR_PTR(err);
> > >>>>                   }
> > >>>>           } else {
> > >>>> -               xsk_addr = kmem_cache_zalloc(xsk_tx_generic_cache, GFP_KERNEL);
> > >>>> -               if (!xsk_addr)
> > >>>> -                       return ERR_PTR(-ENOMEM);
> > >>>> +               struct xsk_addrs *xsk_addr;
> > >>>> +
> > >>>> +               if (xsk_skb_destructor_is_addr(skb)) {
> > >>>> +                       xsk_addr = kmem_cache_zalloc(xsk_tx_generic_cache,
> > >>>> +                                                    GFP_KERNEL);
> > >>>> +                       if (!xsk_addr)
> > >>>> +                               return ERR_PTR(-ENOMEM);
> > >>>> +
> > >>>> +                       xsk_addr->num_descs = 1;
> > >>>
> > >>> At this point, actually @num_descs should be equal to 2. I know it
> > >>> will be incremented by one at the end of xsk_build_skb().My concern
> > >>
> > >> Why? if we reach this it means this is the first time we see fragmented
> > >> traffic therefore we allocate xsk_addrs struct, store the previous umem
> > >> address in addrs[0] and num_descs = 1 and finally if no -EOVERFLOW
> > >> happens then the new desc->addr is added to addrs[num_descs] (which is
> > >> addrs[1]).
> > >>
> > >> Later, at the end of xsk_build_skb() or if -EOVERFLOW happens we
> > >> increase num_descs so if xsk_cq_cancel_locked() or
> > >> xsk_cq_submit_addr_locked() is called we have the right number of
> > >> descriptors.
> > >>
> > >> If we set @num_descs to 2 here, then when do we increase? I do not
> > >> understand that.
> > >
> > > I'm not saying the above logic is not right :)
> > >
> > >>
> > >>> is when skb only carries one descriptor, I don't see any place setting
> > >>> @num_descs to 1?
> > >>>
> > >>
> > >> When skb carries only one descriptor i.e traffic isn't segmented then
> > >> xsk_addr struct isn't allocated and destructor_arg is carrying just an
> > >> umem address.
> > >>
> > >> This is why xsk_get_num_desc() returns 1 if destructor_arg is an umem
> > >> address, because it means there is just a single descriptor.
> > >
> > > Here, It's the case that I'm worried about.
> > >
> > > Ah, well, I see your point. I previously thought this function would
> > > return @num_descs directly.
> > >
> > > Surely it works. However, from my perspective I feel it's a bit weird
> > > because when the skb only carries one desc, the @num_descs remains
> > > zero which doesn't reflect the fact. I understand you use that
> > > function to return one instead of reading @num_descs in this case.
> > > Just a bit weird. I'm not sure what Maciej's opinion is here.
> > >
> >
> > FWIW, @num_descs isn't zero it just doesn't exist. num_descs is a field
> > of xsk_addr struct which is only allocated for fragmented traffic. This
> > is why xsk_get_num_desc() must be always used.
> 
> Right, I'm totally fine with it. And I don't think you need to repost
> it with that minor change unless Maciej asked you to do so :)
> 
> Thanks,
> Jason
> 
> >
> > Thanks,
> > Fernando.
> >
> > > Anyway, thanks as always for fixing this:
> > > Reviewed-by: Jason Xing <kerneljasonxing@gmail.com>
> > >
> > > Thanks,
> > > Jason
> > >
> > >
> > >>
> > >>>> +                       xsk_addr->addrs[0] = xsk_skb_destructor_get_addr(skb);
> > >>>> +                       skb_shinfo(skb)->destructor_arg = (void *)xsk_addr;
> > >>>> +               } else {
> > >>>> +                       xsk_addr = (struct xsk_addrs *)skb_shinfo(skb)->destructor_arg;
> > >>>> +               }
> > >>>>
> > >>>>                   /* in case of -EOVERFLOW that could happen below,
> > >>>>                    * xsk_consume_skb() will release this node as whole skb
> > >>>>                    * would be dropped, which implies freeing all list elements
> > >>>>                    */
> > >>>> -               xsk_addr->addr = desc->addr;
> > >>>> -               list_add_tail(&xsk_addr->addr_node, &XSKCB(skb)->addrs_list);
> > >>>> +               xsk_addr->addrs[xsk_addr->num_descs] = desc->addr;
> > >>>>           }
> > >>>>
> > >>>>           len = desc->len;
> > >>>> @@ -813,10 +834,25 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
> > >>>>                           }
> > >>>>                   } else {
> > >>>>                           int nr_frags = skb_shinfo(skb)->nr_frags;
> > >>>> -                       struct xsk_addr_node *xsk_addr;
> > >>>> +                       struct xsk_addrs *xsk_addr;
> > >>>>                           struct page *page;
> > >>>>                           u8 *vaddr;
> > >>>>
> > >>>> +                       if (xsk_skb_destructor_is_addr(skb)) {
> > >>>> +                               xsk_addr = kmem_cache_zalloc(xsk_tx_generic_cache,
> > >>>> +                                                            GFP_KERNEL);
> > >>>> +                               if (!xsk_addr) {
> > >>>> +                                       err = -ENOMEM;
> > >>>> +                                       goto free_err;
> > >>>> +                               }
> > >>>> +
> > >>>> +                               xsk_addr->num_descs = 1;
> > >>>
> > >>> same for here.
> > >>>
> > >>>> +                               xsk_addr->addrs[0] = xsk_skb_destructor_get_addr(skb);
> > >>>> +                               skb_shinfo(skb)->destructor_arg = (void *)xsk_addr;
> > >>>> +                       } else {
> > >>>> +                               xsk_addr = (struct xsk_addrs *)skb_shinfo(skb)->destructor_arg;
> > >>>> +                       }
> > >>>> +
> > >>>>                           if (unlikely(nr_frags == (MAX_SKB_FRAGS - 1) && xp_mb_desc(desc))) {
> > >>>>                                   err = -EOVERFLOW;
> > >>>>                                   goto free_err;
> > >>>> @@ -828,13 +864,6 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
> > >>>>                                   goto free_err;
> > >>>>                           }
> > >>>>
> > >>>> -                       xsk_addr = kmem_cache_zalloc(xsk_tx_generic_cache, GFP_KERNEL);
> > >>>> -                       if (!xsk_addr) {
> > >>>> -                               __free_page(page);
> > >>>> -                               err = -ENOMEM;
> > >>>> -                               goto free_err;
> > >>>> -                       }
> > >>>> -
> > >>>>                           vaddr = kmap_local_page(page);
> > >>>>                           memcpy(vaddr, buffer, len);
> > >>>>                           kunmap_local(vaddr);
> > >>>> @@ -842,12 +871,12 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
> > >>>>                           skb_add_rx_frag(skb, nr_frags, page, 0, len, PAGE_SIZE);
> > >>>>                           refcount_add(PAGE_SIZE, &xs->sk.sk_wmem_alloc);
> > >>>>
> > >>>> -                       xsk_addr->addr = desc->addr;
> > >>>> -                       list_add_tail(&xsk_addr->addr_node, &XSKCB(skb)->addrs_list);
> > >>>> +                       xsk_addr->addrs[xsk_addr->num_descs] = desc->addr;
> > >>>>                   }
> > >>>>           }
> > >>>>
> > >>>> -       xsk_inc_num_desc(skb);
> > >>>> +       if (!xsk_skb_destructor_is_addr(skb))
> > >>>
> > >>> nit: duplicate if statement
> > >>>
> > >>> IIUC, I'm afraid you have to repost this patch after 24 hour...
> > >>>
> > >>
> > >> Thanks, yes this if statement isn't necessary. Thanks! I will repost
> > >> after 24 hours.

Fernando, if you repost, maybe we could include a helper function for
setting destructor arg?

static void xsk_skb_destructor_set_addr(struct sk_buff *skb, u64 addr)
{
	skb_shinfo(skb)->destructor_arg = (void *)((uintptr_t)addr | 0x1UL);
}

when reading code it was sort of missing for me when seeing
xsk_skb_destructor_{is,get}_addr().

> > >>
> > >>> Thanks,
> > >>> Jason
> > >>>
> > >>>> +               xsk_inc_num_desc(skb);
> > >>>>
> > >>>>           return skb;
> > >>>>
> > >>>> @@ -1904,7 +1933,7 @@ static int __init xsk_init(void)
> > >>>>                   goto out_pernet;
> > >>>>
> > >>>>           xsk_tx_generic_cache = kmem_cache_create("xsk_generic_xmit_cache",
> > >>>> -                                                sizeof(struct xsk_addr_node),
> > >>>> +                                                sizeof(struct xsk_addrs),
> > >>>>                                                    0, SLAB_HWCACHE_ALIGN, NULL);
> > >>>>           if (!xsk_tx_generic_cache) {
> > >>>>                   err = -ENOMEM;
> > >>>> --
> > >>>> 2.51.1
> > >>>>
> > >>>
> > >>
> >

