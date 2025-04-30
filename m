Return-Path: <bpf+bounces-57095-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AD1B0AA566B
	for <lists+bpf@lfdr.de>; Wed, 30 Apr 2025 23:05:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 113324E2D0E
	for <lists+bpf@lfdr.de>; Wed, 30 Apr 2025 21:05:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CE9B2798FD;
	Wed, 30 Apr 2025 21:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WsVUzpIa"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 074AA182D7;
	Wed, 30 Apr 2025 21:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746047136; cv=fail; b=Mh7KTju7IsQc9DAoalHKKfkhlqkGXTukq/MeZJcNTB+P4bXHr6fLazGuvvQgHpLOZnsQn2PN5tkLd59BE5wZB8qvVrYI3aT1zi20Oyc485OQ977j0k6X4w+PXS0GdlNsLEiXO/+NoEhq2FmOMH1eynLaoXYI3qXrnSectcb5BoY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746047136; c=relaxed/simple;
	bh=pAnojoKolXSpnycvJCwnZHUCH4obHl9BC2YK7ykA5XY=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=RUjJvTZ7g7edsq4l80X7a9NDpAphPQ9Kem23A/AfCVhsymFGSaX9IR3HwTpm6B4vodtAiCrb0Wszr78Mto9joA5GYP9lE+2WTqKBiUK/BC+pjnUXuqrDS3qgwdKH6t3oqK4pZziCrDGX6c+EA+6SUBqRXPWVLn4795D8Zqh/6Ks=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WsVUzpIa; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746047134; x=1777583134;
  h=message-id:date:subject:to:references:from:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=pAnojoKolXSpnycvJCwnZHUCH4obHl9BC2YK7ykA5XY=;
  b=WsVUzpIaB2mhf/DwWSBeUf05SM/g2nI8eMidpEfVIpVfL+d9QWZkMbIL
   ctxmhT56nwrtV1/0Hi3JDeX1XDKTiYBlVLeIQ2wbkHnehVoFNZPWVDOQb
   i+0MRqZxypDWiveF4gsG05P1y4n3S3vEGdjh2co55Sj9zjhPs1lN59LMm
   NoQ0mmtaUUiMgwJO6YwIrrXdQah3yHAAS1whFaWGUBVUDgTcyG07qGsKc
   2kOes96Jb5FZiIbQ7lQg6N99aRrhkt31pOKmIoD0zmLCDkkp0bMmgGOqj
   wpQ6dKkyiZhX7ZZu6mw91yDxRh+XQJcbihHMybxrCfQ0clvjRvTX4bced
   Q==;
X-CSE-ConnectionGUID: E5MJKcBlSAqG/S+vZweSIw==
X-CSE-MsgGUID: o5qHHOihT1SSAV3ffhkmVg==
X-IronPort-AV: E=McAfee;i="6700,10204,11419"; a="51538351"
X-IronPort-AV: E=Sophos;i="6.15,252,1739865600"; 
   d="scan'208";a="51538351"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2025 14:05:32 -0700
X-CSE-ConnectionGUID: Mzuk+iKESUWds7ej8ZeoSw==
X-CSE-MsgGUID: WdMcF+BQQCSdnizNyiAWjQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,252,1739865600"; 
   d="scan'208";a="134727236"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2025 14:05:33 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 30 Apr 2025 14:05:31 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 30 Apr 2025 14:05:31 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.171)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 30 Apr 2025 14:05:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B3UGEnVg1SWW+RYMUsWs9B4H7aLknu3W8DoUv4A7GeO4pm6KEGxMYXT6xHfn1/tdCVBP6p09173TIdRgzoDDX0L4zo2o30rIKDMbmQggDC9SWEHbWjFzuK7GNXhwjnX9GzAKG1ijZ10ZFZDHMIfCyDMcJJ1ufchhhHO/g1qRg71Ot9+YhpNE1ogMPX+35UORwOA4y17dkVGaK5oUfedszXdUf6/rYi4XdRqC24PCbP2VI0EQpoOSPKeqhEx07XXQmrA08QUoPA7axtp+dsvVHwNIFLGywK0CAFOuVInmezsEgJktYbus+PRLi+ydC/P4Dtt+SiW/quurpsvskOpOgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BA/bPsdCeI27D1MulC1j33GXpzaRsDp+0SDX6V26e5k=;
 b=ySzm/Ej1VayBZBJQcMfTC7JjJJbZtPnMgPf4FQ0Fz8X7Y05wo1vmWno6uoLiAILTTE3ozEAIP5IMfB+pTRjGAQfhUVbDcZoWZZc8T/3RTysOr4sFqbB2wWx0Dj7gvitlgYNMwtx6K0r96s6KvGCgCa5BE5ia/umylRi+xOuxFp7IwxaF/Y/ZENV3MTXO9OF8g63b4va1GJzJT62a0+MJDtO2xdUR3s+fHgoFUeO5oVqz8qwEUHrUkxIHsGRXz0cQkJJTZaFUA4hvK59IHTroLT7ZWJInBKPINX4bZdj8HVV8vkoJ15LkvjMxDrvKgNvQWyfVRXB/V7mfVdOYa8MNEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by SA2PR11MB4939.namprd11.prod.outlook.com (2603:10b6:806:115::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.19; Wed, 30 Apr
 2025 21:05:27 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%5]) with mapi id 15.20.8699.019; Wed, 30 Apr 2025
 21:05:27 +0000
Message-ID: <81b94959-324c-495c-948a-622752fcc2d0@intel.com>
Date: Wed, 30 Apr 2025 14:05:25 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2] xdp: Add helpers for head length, headroom,
 and metadata length
To: Jon Kohler <jon@nutanix.com>, Willem de Bruijn
	<willemdebruijn.kernel@gmail.com>, Jason Wang <jasowang@redhat.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
	<daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, "John
 Fastabend" <john.fastabend@gmail.com>, Simon Horman <horms@kernel.org>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<bpf@vger.kernel.org>
References: <20250430201120.1794658-1-jon@nutanix.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20250430201120.1794658-1-jon@nutanix.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0138.namprd04.prod.outlook.com
 (2603:10b6:303:84::23) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|SA2PR11MB4939:EE_
X-MS-Office365-Filtering-Correlation-Id: c8737ba6-9ff1-47e4-4e4c-08dd882abba9
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016|7053199007|921020;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MkhJYk5nL2NyOXAvZTNlOFhYY3ZCaFViREFuazJsSEtHTnFWTjd3clE2TkZU?=
 =?utf-8?B?MURxUDBzMGNYS3VxZ2JEYy9KaTB3bkE5OGpyTFMxMW1pOGJnV3ZzaU9mME90?=
 =?utf-8?B?YlRtN3hHS0hSMnlVdmpuOXkxNkhKZ2EvVGRHM1Z6TDF3R0pDclhaTHJsK05o?=
 =?utf-8?B?SlZaUlBoUkYwdC8ybVFwcHp3VmQvVDh3OVhSVjlDNk91RitqNzFlczJWc3pD?=
 =?utf-8?B?U2JVTXZMaS9JK0V1a1JSbHFaUWthVzlHbTFrN2NNajE5OUNPVGI2UVlPUjlV?=
 =?utf-8?B?bFZLd3ZtOXZaTk40SFJIeWNNVGk1V3IvYU50OWl5c0M5T2h2NzU1ZUxhdjZk?=
 =?utf-8?B?TnJwY3hLWFJhVHFUME1wekRTaGdublBCTW83NkJNNHlSVHh5dWRNaG5TWkx4?=
 =?utf-8?B?bWFBU3IyZTVyV1g0YllvU0FEMS8yR2FNNTQ5MGxyeWY5a0lyZVd1M2tSYmVU?=
 =?utf-8?B?YjJqVGZGK0NMUE40TFNjMUJNd0lpSGF2ZzlHU3ljbDg3N2RQSGZFL3VyNHFB?=
 =?utf-8?B?dVhpTjRDdEwvL1lCUnEwUXZsVHRiK1ppRkd1Nm91ZDZXMHV1S0JuTGFUSEpS?=
 =?utf-8?B?Ui9YQXowSGJVNytwbm5oSXU2T2RPRklxRVU2VzVlZGVDUEptUHByVXloQ0Vr?=
 =?utf-8?B?VjlsNnV5RGhBYVV0MnhZRWI0YTJFRTFudTRvZWUxbkVxOUtOUkkvdktGczRD?=
 =?utf-8?B?QW9LdnFHalRHeUg5MUNnSnlJWFdETHhEZmpWTjdub3dDNEVUL1Fud2hwN0NV?=
 =?utf-8?B?aFRpaTJzb1oxL1E1WGlPaU01OUZnVDJsbXh3bUVEMzVmQTlWcVVnNUkySm15?=
 =?utf-8?B?Ry8wbTVnOUhKNFp6ZXNqNDYwVks3WkptVTkrTnlnWW9BK3JkMzg0Z1ArZHRp?=
 =?utf-8?B?Nk9FVStCemtITEtHa2RtcXVaNlpVMnVNbmNaTGx4cjdxUmNRbk5FSVBxMTNz?=
 =?utf-8?B?akpIQVVPRFVvbXFRTzQ3SjJYblJEZmdqSDB4OG5Xb2xMNWJOckc5K1daSVU0?=
 =?utf-8?B?bWJ3c0N3WHc2eE0vbEltM2JuYkh0STlwT3BUWkx4MWhyZjZRT0h1dG5lN2NU?=
 =?utf-8?B?dzlUT1Mvam9hbTVBc3I1WUl2TldiaktjZGNMckJWaks0ZURFVC9rVWVtZ0d2?=
 =?utf-8?B?alE4R1dQOVFyczBQSkFuN0pOM1dMSks2TGk3UU9HTE1lRW9UMUFlQWNOUWFG?=
 =?utf-8?B?Sy8yYStaZEtZZFR5THpyNzNRQ0s2RHFKTUVMQWNoNnRONi82dnY4aGkyWjdz?=
 =?utf-8?B?d0JycHBHemtwK3lFa2x5S1lFV3IyQ2dQRGVXZWVkcXZsK2JsRVB4MmNJeXRE?=
 =?utf-8?B?YVRTQTI0bXZRMEVQY2xvbkhOR1JLTlJNMmFxa2pvWXZvNzdJUUlNK0hOMnpr?=
 =?utf-8?B?Yi9ncEhtYzlUR0htL1R1bnpMTVdvV0Ywa1FkNEF3UkczN05PY0Zpam1ra25k?=
 =?utf-8?B?ekJsRzQ2dWtwUGx1aFUvaE9PTWEwVzRrSHNvQ3Awa2hPeVdSMHBueG43MHpo?=
 =?utf-8?B?SWxZa0JCNkFPUXVQWFRhUHRUV0pHWUt4dERZSDVXai8zeVFsajkxeG8rNHZx?=
 =?utf-8?B?WmZ1a21UWUhsWm8wMGd4T2JHbjd1L1lpN1dOeW15MDBBNElJN0VrSjNVeStn?=
 =?utf-8?B?M2kvUFVzQ2JpZnpUT3hEK3lPMVdERFF2WUhBaStURXZOUmovN3JwVHJkRXFx?=
 =?utf-8?B?QXh5YWZaMGRRMDFtVHp3b0hhYmtnNVEva0F1TkNnNEdYMFZSWkFVNjJGODhy?=
 =?utf-8?B?UTNlK0NYUStwOTF2cTZDV1RRQkJnQVJvcHFyU1QyYVdaamZ1czZCY05DeWsy?=
 =?utf-8?B?VDY4UzgvVy90MEdHNlRIbEErZDFIaUt5ZXJSMzE5YzhuTDJRM1hWWmdQV3pi?=
 =?utf-8?B?WHE3cG41cjJOZW5sSkIrcG42TnJEWk9wYm9YcmR2d0tHUWpXay9CVktqeHZL?=
 =?utf-8?B?QkZubDlBUG00T3o4aDcwTWd0ZUx4bThQUmZ5MzZUOFNnOXg3WC9lcXdsdDVN?=
 =?utf-8?B?Y3dZTVZ1bGhRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(7053199007)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QTBUbHJ2SHJXMFVRaW1FVGQxWThBVEdxdTNRVWlBcno1QkVZZkphNTh1ZVBQ?=
 =?utf-8?B?TWVPUDlhdjhHQWZsU2I3WkJ0R3RLTGZSZ2g4S0xIZk1IN0djbHhrdDg2N2FV?=
 =?utf-8?B?dFdnQzlLK3FkL1hYalpFUnRuNWxBNWZEZWNRTlpvK0NPOFVVRXpIYUJiYVNw?=
 =?utf-8?B?Q2dTeHVpdUpOQys3YktWZWM4dVphYXdERjdOeDA3MDY3Zk1SSlJ2RFYzcXhz?=
 =?utf-8?B?c1ZNaFZuTXB3MWRLN1dWdFBmaEI3NU0zNGxFaHQxYkRja1ZpTHlVVER3TzJM?=
 =?utf-8?B?L0s0dkZkQkFpVStwM3VSL1JHSUJUQm5rcEZUa0REbjdjMXFMZ2ovYnNUQ1k0?=
 =?utf-8?B?K0ZXdVlyU1MxU3k2TDMxS1owMGpFZ0tqNlp0OTNud1c3Nlo2NHlxOURtWWFY?=
 =?utf-8?B?QVBLN09Nd3JiOXdSZGx0ZDVCWWFPNHZNTERicmVuSDg2QklDaTh6and6Qjg2?=
 =?utf-8?B?TFVrL205Tys2OXZxWW4yUWUwRm5Demh0cDVwL1lkYktBTkl4WXdKR05sRDBI?=
 =?utf-8?B?TitoU2FBcy9zc3JSTXdSbVBnNzdFajlnS3VyTk9qQUVUaVh2UWU2Mk01WGxE?=
 =?utf-8?B?cVZkdWxxT25PSW1mSnNsVEp3TjJnREw3UENTVlNicmdPY3gvalM5Q251SVNl?=
 =?utf-8?B?Yk1mT3QwWUkvK21MMUhpUnIwZzZvUm9zWjJqWWR4bWQ1cGNiY3pMMCtLVTBO?=
 =?utf-8?B?cEtIbXYzNVlLOVhGcHJEaFoxaXJsTEgyK1BxU3hNNDlHdWtKaWFINVd6bUlq?=
 =?utf-8?B?K0lXNjh4ai91UW81d1BqV0twVUtOcEd5b0tYMm9uYWl1MTFsV3dWK1NDRzht?=
 =?utf-8?B?Q0Nod1QyMnNPeEhIUTR2bXkyZUZuMlQ4emtYWjJwaUhScDcvQm5sZm5nRzNU?=
 =?utf-8?B?VTYvdHJMUG9mMU5wRHZ0VGdLT3MxYVVtZUFzc3BmOEpSUmlFTitwUTdJYU01?=
 =?utf-8?B?RFVkaWdMaFFsTGlIejh3Qk14TG5wVEg0aWVOZFdLaE5SN1ZybjFhYXN5dVQr?=
 =?utf-8?B?Zm5TVXhPMUpnREFIWkswRC8yckZQR1lFNFZJMU9ReVFhOUpsOU5pZ0lhc3Aw?=
 =?utf-8?B?M05yVkRoRTJRcHRBYXVGWURCc2pwY1VjNG1OSER3UlU2cDJRRkk0bnJaOE5q?=
 =?utf-8?B?R3dpanNmMjBvNmlyc200MldWb2VNZkZDYkxvVlNLOVU5OXE3MkNyakZzZW5u?=
 =?utf-8?B?a0dBdkpielg5L0hQWUVKaHB0cDJKaTZsbHA3UlFaYXVkSEJQUUxWSWdQVUsr?=
 =?utf-8?B?VTN4YmJ0US9tTWNleVl6NmkxZDc4WUNyNjdNNEMxOXdmdjlVS09CRXRXYXJW?=
 =?utf-8?B?dk1TTStaMVhvQmhxTmdQdU5wazVUNzhNYloxMUZyV2RPL255YlY0anVkalhY?=
 =?utf-8?B?RExaY1ZjN09pY2c0WThvSGkzbHBod1Vyd1dVOHViOStUenlldW10bW5yNlFx?=
 =?utf-8?B?aHp3VVdiNmpLNFVWS3R5QVVEOExwencvVWpuUW1oQXhGbTd2c0ZYUVQ3VVg5?=
 =?utf-8?B?ZFBLSFhwQlF0VG1udXJ0K0w2U3ZvRDRXak9UTlZOTmpQNi90bHZBd25HTGFE?=
 =?utf-8?B?NU1vV21aWlEwQlpIK1VKT1ZaTXJpRDU2RmczREpmeDhNdEJpQ3Z0eU0xakNM?=
 =?utf-8?B?d3pSVk9sZDR5VFBWd29QbURFN0V2eE14d3d6MkcxcXQ1RTY4TXQwQjlSWXF4?=
 =?utf-8?B?WEhPaU1jNGxDVlZObDJJeTgvbWJwOXhIV0EzOTlqT0JlU2o1KzVrU3JjM1dm?=
 =?utf-8?B?MFNLaXR1NWpiU0NSUzhld0pFZU9Sck9INnFvMnEwWlYyV0hERVhFZUNWSzdI?=
 =?utf-8?B?OWpyY0k1NGNOTTZKaHREZlV2aGQ0VjNEQ3cvaUJSMnhia1MxYnhOcWs1amdm?=
 =?utf-8?B?dmNtTGsrMHlrQVI4d1V5ejAvRUJCbkFWaWR2L2IxZDU5OWp6SWkwZGRlSWhD?=
 =?utf-8?B?bTBZYVN1MTJqSmRIS0FiaVhQT3hvbmR1OHQrRG5pY1NyQ2kvNGVmSEZrUW5w?=
 =?utf-8?B?RWNPclg1N3o0MDhxM1czcFZwcGFNNmV3SWREdVM2YlVqRW9ESkdJWldselVD?=
 =?utf-8?B?N08yZHNPV3ArWS96UCt5b3lVVmlRdjNSUk5jbjcrYVZYTGE5Sml4aU9YOE04?=
 =?utf-8?B?KzhkNXJ1ZktNSm0zOU81aHlHSHpoalJ3bkIyQVZXU2N1OVJaR2Q2MnVFZG5Z?=
 =?utf-8?B?YUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c8737ba6-9ff1-47e4-4e4c-08dd882abba9
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2025 21:05:27.5978
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JdF86qJqX6C4i7eEgclzkVpyvlfi7nPConRMPwCHpIRIUX351N0AXRwMyU7Vqorx3qfd5XpAqbuSSXItJ9+oEQrBz1E9YmyN2nJd+fqsnBk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4939
X-OriginatorOrg: intel.com



On 4/30/2025 1:11 PM, Jon Kohler wrote:
> Introduce new XDP helpers:
> - xdp_headlen: Similar to skb_headlen
> - xdp_headroom: Similar to skb_headroom
> - xdp_metadata_len: Similar to skb_metadata_len
> 
> Integrate these helpers into tap, tun, and XDP implementation to start.
> 
> No functional changes introduced.
> 
> Signed-off-by: Jon Kohler <jon@nutanix.com>
> ---
Seems reasonable to me, the helpers are a bit shorter, and match
existing API for SKBs. I like it.

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

