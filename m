Return-Path: <bpf+bounces-47546-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 669829FAEF6
	for <lists+bpf@lfdr.de>; Mon, 23 Dec 2024 14:52:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C468516577E
	for <lists+bpf@lfdr.de>; Mon, 23 Dec 2024 13:52:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 385741A8F9E;
	Mon, 23 Dec 2024 13:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="B4yH53M/"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B50F34C92;
	Mon, 23 Dec 2024 13:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734961939; cv=fail; b=j7MgUtdHGLPEvYctqMZrbzjcDemi0j3bYM8DTse5vClg6N3NeE7m1W15LPxtO1CT9nWyK9PodPEGdgNoeddEqAY0V09aw+7bK6WnGwQjBhrbUJ/8DArEhwQyFdvnpmQOpFAOLT0gfSdBS2oEuF0WJs7BUL+uOG42aJlmOQ6k/aI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734961939; c=relaxed/simple;
	bh=gf5F5a4V96aTs2ibZnHgGK1PKQ4bTO1mlmC98dvFrps=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=MW/0xKdCd2UTC04cHYLdme1tpJz2M5fMLOfKIA6vxVIM3Bg67FO00/AzLdFmN18ZaSUpvpPv+ToUs86ugidmOl98JnIKp4ysj76HWLlvzkjWjZZvkoN48uZW4290hB3YvDy3Y/lr68bO0fuc4BzStvk8t3NMAE1S634cZ8rbQtA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=B4yH53M/; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734961937; x=1766497937;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=gf5F5a4V96aTs2ibZnHgGK1PKQ4bTO1mlmC98dvFrps=;
  b=B4yH53M/07fglvTh7b+uJO/WuUvHkpHE9zjVV1pSu1fpQvuhhi1T8V6Y
   HH2Jc1Z8HKmW0qDJHyBPJq3mwqbmtzp+GCnW/Yo28OZUyOaYfxTYAXC+h
   qC9QQR1VwFe+oJYAsz2siZMxDCHFJam01SrYr/2lKhk2bdZVXlEFPMdhW
   8HSHTbptki8wVW1zbPHgv4IV+gtxGwY0YFFCmv2zRVWqP9/uegr6lkLUp
   gb1lmAq4V4pQ9CycSk0eMUyTY39jWD6blIp7tdC+eP6GXAKFmCS2J8ULd
   XCSClTyB02Jb4Y0jHTfdCSNuEL5FxHv31DSJ1ZdjT7KzTvagbw2AnC/PY
   Q==;
X-CSE-ConnectionGUID: 8occCdgVSoCN90vk5986TA==
X-CSE-MsgGUID: Rcq5eIn3Q7aat0oAwe0T0Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11295"; a="52954873"
X-IronPort-AV: E=Sophos;i="6.12,257,1728975600"; 
   d="scan'208";a="52954873"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Dec 2024 05:52:16 -0800
X-CSE-ConnectionGUID: shsLiT0UQfeTjtKCw6J2KA==
X-CSE-MsgGUID: +P/DTzN3Q7Ch1jMsOCWFrw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="130180076"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 Dec 2024 05:52:15 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 23 Dec 2024 05:52:15 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Mon, 23 Dec 2024 05:52:15 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.174)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 23 Dec 2024 05:52:14 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qbXNP/4HlrVjU7QLAgbKbmLnrrL/2UkbYaacNOGA628P/Bt6wzNXNKl6CPFuYQDvFiIWvpt4o2Bbkada3PFkQJg3feEMthbCuxJsSkw5JV8Lsujrg41qUw6nB+DbOki/kKKRvhGJ66wT3J0dOgj7tDJTalkVoAjmMflL2/24OnWX/0AE/q40rtahGkfDa22ROsCuw5ErrWGyCokpW2VJrpG/pBrmrWFW9M5Ql3dQRMmLDQq1h8yiPvpCaV7px4Z2TTidfl/ittivQ16gPoB1dhH9Q1kz7BllQVfQNs1kl8/ojCwdj/gnxZ6kjkUa2yWvuY2nGchzn80C62edbUzjfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z7CdKN8dmC1P4Qq1SP72tJ8qbiSjpY9NCjFSobi5UeI=;
 b=QJTiGNjhy5C23ZjM2rCkIzoItdoWW66Dik/zpV+WjJSQhSo8YDv9BledbRoS2dAYO4E/1o9V7+At0zwmWRotQgGLCQtilh+cyAQROx+p0uCzgWP0I1FVsVSufndxCAKdfmCfApBrRHsEJi+ci9dIBMgyHttKU4c9fLSS9VBzW/bMpIGyFbZylRpztQJGCiZkqBsXXyI/3CvCn0SVRpyyD+l2C7jjs5u6uuoVp2gOcQ3CsxqxnNyA7A6ABWuSGPPD8ZuvYsNAVfAElOrEHHzwU9eIX9yYjThTMHtTLD8C36MOTUj4wgmpDUN6cG1+B/NtrKRojOfSxEK8lwgmZOdzOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by LV3PR11MB8767.namprd11.prod.outlook.com (2603:10b6:408:215::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.19; Mon, 23 Dec
 2024 13:52:07 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808%4]) with mapi id 15.20.8272.013; Mon, 23 Dec 2024
 13:52:07 +0000
Message-ID: <28af573f-2718-4d09-9dbd-0bb5764dc794@intel.com>
Date: Mon, 23 Dec 2024 14:50:54 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 6/7] xsk: add helper to get &xdp_desc's DMA and
 meta pointer in one go
To: Jakub Kicinski <kuba@kernel.org>
CC: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
	<pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
	<daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, "Andrii
 Nakryiko" <andrii@kernel.org>, "Jose E. Marchesi" <jose.marchesi@oracle.com>,
	=?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>, "Magnus
 Karlsson" <magnus.karlsson@intel.com>, Maciej Fijalkowski
	<maciej.fijalkowski@intel.com>, Przemek Kitszel
	<przemyslaw.kitszel@intel.com>, Jason Baron <jbaron@akamai.com>, "Casey
 Schaufler" <casey@schaufler-ca.com>, Nathan Chancellor <nathan@kernel.org>,
	<bpf@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <20241218174435.1445282-1-aleksander.lobakin@intel.com>
 <20241218174435.1445282-7-aleksander.lobakin@intel.com>
 <20241219195058.7910c10a@kernel.org>
 <388fe411-d06f-4cb4-b58a-a2b9b5eb08ce@intel.com>
 <20241220092647.63affabc@kernel.org>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <20241220092647.63affabc@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MI1P293CA0030.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:3::17) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|LV3PR11MB8767:EE_
X-MS-Office365-Filtering-Correlation-Id: db14b3df-dc11-4060-d6a9-08dd2358fd6f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QlEyRW9YTkVjc3Ywd1BYOUVMckJBKzVncGpyYmpjRnAyYXgzQlBTM1RDUVdW?=
 =?utf-8?B?blAyM1JVZk9sN29vWThud3JFdExTcm0vMGkzbFJSMnYvYWV2bklNbU9oOHcv?=
 =?utf-8?B?V0EwY1p5Wit2TDk0ZUJ5SVpSMjA5bFZDVSttYVFST1g4cWZmUkx5Wi95cTlL?=
 =?utf-8?B?RkdyZ3JMK2MwTzV2d1NlK0JSMUx4dlFLSktWYVRhWklpclFIUzFiSGMvdjRk?=
 =?utf-8?B?UGNlZ09ZUWcxT01rdCtzWE5zVFZnaU5UTFI0SUtodHhoZUw2QWZxUHdiazdm?=
 =?utf-8?B?dnVQVm9vT0pUSFRiZm02QWlsZk1XRXVtNW9sbTlzK1JkQ1NVcGdOcUJsdnVO?=
 =?utf-8?B?aVlPZitpRUFMTDFnK0ZQUlpobGhpcWJSY2RkcEZBYUFIMUV3d1ZucmQ3RUlq?=
 =?utf-8?B?TWJGamZGV2YzYUtVbVZmZ0l0T2NObHJVdmE0c25YUEJmaFNuNndkNkx4My92?=
 =?utf-8?B?SnVFVzhNN3ROcXkvS0UyTW5XazE4WEdMdzVld3l5L3ZETndFTlJNQVg4Rk9n?=
 =?utf-8?B?cHdlR2lWbm91M2ltTjRIK0l6SUZlVlpEeXliekJxTnFjVXBQMUN6TUhYcHcz?=
 =?utf-8?B?Um9qa0dZN3FjNXloUEVzZnI0cXJzTzBQeXI4ckVRMzN2LzJkVm9HY1N2MWVB?=
 =?utf-8?B?c2J6bnkxbmljZkpsYXJ6alY0ZzhCYzdvOCtQSUdWVk16eDVvd25Nckp0SDc1?=
 =?utf-8?B?UmhLc2pKSGVEVEg4dmpsRXZBUnZwRmU1QWFMbEpwYlFLY2puMW4raVRVZStu?=
 =?utf-8?B?eENsSzUzcm1oVmxyRjlUVForaW12UkxEQ3VIdVV3V0lOSXp6VlFhY1V0TlBj?=
 =?utf-8?B?eDlWNFhOTm8xeWV1QklQNTQyYzB1b2t3cHFRR3Uya25MK3AzVnRvNUFRQm94?=
 =?utf-8?B?YlBzZkhVQnpmTnhWYXBuUWtUQzBmcWw4SURmMzRjclZaRkVFZW9IcGdtRW9L?=
 =?utf-8?B?eWdPYlBzVkFQMElYdzhxK3NXVXFLenY2c0NGQklsTWplcnhUOVRmMG9xSkF1?=
 =?utf-8?B?aHFVVE4zYlFLWGwwbGFJa2FlL3pFMVNFY0l4U1FhY3lxWVplcGh2ZzQ2eGFN?=
 =?utf-8?B?OExGZ3ZPY1gwYlIrdWszOVRWeGI2M3N4Q3FwOGpkcDNuSndOV3gwc2srYStw?=
 =?utf-8?B?czdBU1Fwd1dWS2xvMlllUTFMU1haVktWekNRci9EQll5ZXYyY2s1YVpnb09P?=
 =?utf-8?B?VVpoS3VZcmEzcjF0RWN2NTdrZ3NvTFBmY1IxQUZJQlg2ZCtML1JWTGl6OWZm?=
 =?utf-8?B?cDZ4NEw4S3ZtQm40NFRUOXQ1VEQyUTdURjd0Wi82c0NXZVpKMWpYOTExTUVO?=
 =?utf-8?B?anFxTnhpUU9HRGVQeGI5WmJNY1FVSlF6VitURWxpSXhOSm9ZaGdiUDhyclFn?=
 =?utf-8?B?M0dTbks0dCtFamtwQjJGdklYQWNZcURxUldQMHVyeDdNV2wxdlQ4QUtweFJ2?=
 =?utf-8?B?WWppaTRRKzBDM290TXdIT1JHcDhKTFErdjExZmNFYnRDanN4cXBtVHZGNU1D?=
 =?utf-8?B?KzVJKzNNT3JPaXFITnMxMHlDbDBOMjRtNnkxVkVDbEU1SXM2ZnU1ZTJqVzJL?=
 =?utf-8?B?aG0rNnpmb0NsVzVwS2NUN09YUG1MY0Z0bi80Yk5IU01ZTWx1aFd5bTZjbGhV?=
 =?utf-8?B?bklzWTFGeFd4MjlEMkxVTFRtQWtHTC9ycG0zMWFEakQ4blQyT3cycWhzY3lJ?=
 =?utf-8?B?bFo3Q0MzTGlZellxTERZQjViODFYbE1ZaDVHRHRtQmM4bWRVVC9JUnl1ZjVB?=
 =?utf-8?B?ZUxSMG9pcThaTFdJL09qUDloVm9YdGlGL0FtYWhwdHhHeFY3djZPNDN5REt4?=
 =?utf-8?B?SE9od0V4VjVMU3JIbytqdVQ3K1JqRzN0RTJJdWVlbk13c1BCZnB6aUpaTldQ?=
 =?utf-8?Q?hiEP1MdJBC+LZ?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b2xRUjlWU2M3alpOZHRTdUhrOVZzODVBMGEyU2t1akc3aFQzUnRBL2traGlU?=
 =?utf-8?B?dUpWS1JpcjZTcEJXOTE3MzZETnZKTHBjNU1IOWozZFEzTzRTMDNxc0hzTlNV?=
 =?utf-8?B?L2dIUDNDTVZCR1c2ZklOOElVQmh3cWFhMVUxM3RLdzU4eVhXeVIzbzc0dkVq?=
 =?utf-8?B?OFY5WExaNHZOUUMrNmwrVUdOa1JEM1lRWWJHajJQMkpyTWtCd0Jnc1g3ek5u?=
 =?utf-8?B?ZVgyTVQ5QUYrUTllYlE4YTBPL0FxNS9wbVZvV3ZUV2FGV290cnFIaW1WUW93?=
 =?utf-8?B?TmhzcVRrSExPYllzalJ6S1VFakd1bnJyWjdvSVptRW9TYjdMR1NOZXRuOVhz?=
 =?utf-8?B?Nmx2Z3BFUklsRElscTNZSzljT3o5NDVlcU1VWk1TMnNQYWdFOWRGUGZhSzVi?=
 =?utf-8?B?bGt2elRZNWJkS3A5MXA4ZlovZXFPbFUxT3VpTGkzK04yaGo5MEh2d2tJVmtU?=
 =?utf-8?B?K2FVV1BvL2UxMHZhOFhWdkdhK0FMVElWR3Y5SHN4bENrWE53QlBuTVRmQ01P?=
 =?utf-8?B?ZTNoc3pMVTg5L1JzVWU3dzlObmE5K3gwNStkS0MxUk5WQVMvTjJmR3kvUXds?=
 =?utf-8?B?Y05uSEZISjBIWXBCZXlobmFOUWxldllzSWdYL1VkZUM5TGFSc1l1MVd0NlNv?=
 =?utf-8?B?NUhwbmFSSldKb3QvOWdxN1NhZnZiQktvcHQ3RVZ0cTBhUm1oMUZwVk10RTc2?=
 =?utf-8?B?U0JUcGNYOUl2NWg5SUswcWFVSDM5b3hSbW50YjV6RStIeXBJUDk2aGFnUGp5?=
 =?utf-8?B?ZXlQYitKcHpqZ1BoTHhkNUo2SlNZVVdoMVBBUi9hSjl2a1Vuc0Eza2F2RVFE?=
 =?utf-8?B?bzUwUjdab1dGaDN2TmNFQkc3VEJxd05UT0tHR3M1Ulp0OWYvOUlVSjZqZE8x?=
 =?utf-8?B?bG1wTkFHUEJ5TXhBMTdHN1I0cGlFOVEwK2lzbjlkTlNtaCswWERyNEtKQXh5?=
 =?utf-8?B?QUlISkludGJ6THRqeHN3UkFsTG1UZGJsUUFhY0ZYY21DTmZPZ3ViRkRRdWlH?=
 =?utf-8?B?aGFjbzQyRVNGSlpKRXdsUFpEVHlNUi9sYWlYTXBOM1NqR3ZoVDRHUTVNbTJI?=
 =?utf-8?B?QkVGRUdiekhoR1V6amthWW9STy83MlpRWVVaWDE5QUpQR0YxT0haWFB0VHlP?=
 =?utf-8?B?cEFyYVJpMjFsS1RtckJIM0JWcGt0QlJHaUt2ZXF2eU92Ui93ekxrRzBEbU1L?=
 =?utf-8?B?T2I5dTZibnVYcG1xVi8xeWFpRXlGS1E2bHZ4a2RVM2w4MkZFT3JoK25EVDJl?=
 =?utf-8?B?TmxoSkJhbWZBL0thcWlTQlZCWDJTekIyMUdORENhQ0UrNzVuMXcydXRSL1Rr?=
 =?utf-8?B?SHpMZXhjNndBalloeTcvck1lYWRzMysyTnU5VEI1dnRnYVJSenJueUxMaVV3?=
 =?utf-8?B?dWxibGc5Zys4WWNuajZScTVMMUFMbHpmRjM2MnV4RFpXcy9TVGpFWkk2OE9C?=
 =?utf-8?B?OWZhS2s2YWtMcFoxNEJZbmhhemZKQllDcGJPWmFIeUZ6RzdGOE1FK3pIS2Mz?=
 =?utf-8?B?UHNxZEtWTGMybmQ4Qk5DVjc1Vm5BMmVYaUc0c0k3WmNkdEh4SmtVMXhTUFdw?=
 =?utf-8?B?eHN2SzZYVHhlVEFZSnRqV2dtZVhhZ2pNU25CUTZBb28wQ1piQ21tWlNtZ3ZM?=
 =?utf-8?B?eEo3SVR3UDNBcm9KRDVubGx3eTJnS3oza1hSUXQwTTFaZWZ4ZzVDbm16QTd3?=
 =?utf-8?B?SHhrVDNiU0wvZVlkMmN0OGo0cTZYbEE2TW5kMlNuZW11SFVRQkVhemJwTnph?=
 =?utf-8?B?U01SR2RDZUtvQTRtRFV2TmM1dDdYaXdCQVo1SnBaNEpmd1NzQUhxTGRObnI0?=
 =?utf-8?B?d0o5M0tFS0hENlFhTSt1SXJ0Q2FlZE9iSmVITTdrVExCZHJrUHNZUUtWM240?=
 =?utf-8?B?T1pQWGRTUlplNFAveXJuMCtyVWhTTkVoYU1BbWJFQ3drYStuYUtKcFdkQ2xP?=
 =?utf-8?B?eWU2WHZNOVo3SlovaFhJNGJOZ1VIQU1KOStKcWs0R1NIYUw4YzNZZ2pjL0dk?=
 =?utf-8?B?Mk5TQXVpOXN4Tk85bXFKa3QybFJWVHVnZ2UwRWl3bGhlY25mZUpkdVdBRith?=
 =?utf-8?B?ODFGVXJvUmZtUjNGR1k4N2Q0RWJlS05vT3FBZ2pSTHpzSUdsSGxYQXpEZHU2?=
 =?utf-8?B?WjdEaUJNbVd1UnE3dEt1czBNS2xJdm9ZWmN2M1Z1SE05a000OEkybnVqNk5j?=
 =?utf-8?B?Z1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: db14b3df-dc11-4060-d6a9-08dd2358fd6f
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Dec 2024 13:52:07.5326
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NjCSDlz8u+4Kns+AH5zMcIG2hj0IbXP2Shr69bvZr5hIYi9XAE7PKvF/sU74V9e8COIIDMxsO0T9DjCJS/KSZxvQ6sR/wp+UWSZrdDE/W/M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR11MB8767
X-OriginatorOrg: intel.com

From: Jakub Kicinski <kuba@kernel.org>
Date: Fri, 20 Dec 2024 09:26:47 -0800

> On Fri, 20 Dec 2024 16:58:57 +0100 Alexander Lobakin wrote:
>>> On Wed, 18 Dec 2024 18:44:34 +0100 Alexander Lobakin wrote:  
>>>> +	ret = (typeof(ret)){
>>>> +		/* Same logic as in xp_raw_get_dma() */
>>>> +		.dma	= (pool->dma_pages[addr >> PAGE_SHIFT] &
>>>> +			   ~XSK_NEXT_PG_CONTIG_MASK) + (addr & ~PAGE_MASK),
>>>> +	};  
>>>
>>> This is quite ugly IMHO  
>>
>> What exactly: that the logic is copied or how that code (>> & ~ + & ~)
>> looks like?
>>
>> If the former, I already thought of making a couple internal defs to
>> avoid copying.
>> If the latter, I also thought of this, just wanted to be clear that it's
>> the same as in xp_raw_get_dma(). But it can be refactored to look more
>> fancy anyway.
>>
>> Or the compound return looks ugly? Or the struct initialization?
> 
> Compound using typeof() and the fact it's multi line.
> 
> It's a two member struct, which you return by value,
> so unlikely to grow. Why not init the members manually?

BTW sometimes such compound initializations are faster than
member-by-member assignment. *Not* in this case, however, so sure,
done already.

> 
> And you could save the intermediate computations to a temp variable
> (addr >> PAGE_SHIFT, addr & ~PAGE_MASK) to make the line shorter.

I'll just derive it into a oneliner to not copy the same stuff again
between functions; also, page helpers like PHYS_PFN() and
offset_in_page() can be used here instead of open-coding.

Merry holidays!
Olek

