Return-Path: <bpf+bounces-46151-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ED919E5356
	for <lists+bpf@lfdr.de>; Thu,  5 Dec 2024 12:06:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6907C16251C
	for <lists+bpf@lfdr.de>; Thu,  5 Dec 2024 11:06:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF7D21DDA31;
	Thu,  5 Dec 2024 11:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="m5aCFoDk"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA676190059;
	Thu,  5 Dec 2024 11:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733396806; cv=fail; b=czSys7vrM99oGgrxnvAjo3JL3tOGJyDtK8aQKAfMDHT6WLsyvVGPSa7+BIBiMQoZ65nbiFmVhoUO0POG5uIWQSmJ6Rgo4EFgwKqI/OzLCQGj+mJ0blaMg6npZGIdE2BUyJWEfSK231we3kjh208Ra0xX5HL+OG5Y8hKnLPpjmaQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733396806; c=relaxed/simple;
	bh=OShlYBsLH/Z/CJCV9ze1oaaiEnhfMSWXVJIVt8iBDYw=;
	h=Message-ID:Date:Subject:From:To:CC:References:In-Reply-To:
	 Content-Type:MIME-Version; b=pzd/ctJXPWpRBZ6j0WHWMSoXwhIr2ht1BcopOVEyrOuGeYaKeW21paTWzP+66MAF2/8zOq14XpOeAFWgPeESq0pUXXDZ+hJMk6tu71IhbFVz2WjgeibLHJFONm5tpENjXaQGjy8KSmAZxZVJhF8mmGDw2C6TkuR3+m7Yb3K7V+o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=m5aCFoDk; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733396802; x=1764932802;
  h=message-id:date:subject:from:to:cc:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=OShlYBsLH/Z/CJCV9ze1oaaiEnhfMSWXVJIVt8iBDYw=;
  b=m5aCFoDkFL8PLvvY9TG4upx7PmWzFLQ27V7jvsSC8Ehbra7yjA2jkEOG
   Gxal02zi4zEGz5gdgX0gUUtu6tnVrEZ7sDTlOcwItHPqR5oAcwN8mKbQm
   gZHmLIKhm+NhU1RDreMfhoa4Xfjx45E3QRwUisecFwOw4++FP43Uh7+cX
   OkzPvcbcavkHMS1LA6otqJ/a3GWfEVeeMSYVaxJXU1QRDxq+Ro0G7wLGp
   f7awga8ykR237CSErmMpWAgIqe/TlTDVKlZZb/10udjSEToDh/7zJBCE2
   ujEpJZNw+fvb5G+3UpBBvlUpIC3brNRHiY8tJR7SdFZD8C74KQ+OeYBT+
   g==;
X-CSE-ConnectionGUID: Di3FWmnvTLqldBfHWtYOPg==
X-CSE-MsgGUID: 02LLExNoRUavje7eRT/eng==
X-IronPort-AV: E=McAfee;i="6700,10204,11276"; a="45082176"
X-IronPort-AV: E=Sophos;i="6.12,210,1728975600"; 
   d="scan'208";a="45082176"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2024 03:06:41 -0800
X-CSE-ConnectionGUID: mOU21E5lSTyXeCy7z0D8JA==
X-CSE-MsgGUID: rc+zQYVDTQCSE2ZxyptwVg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,210,1728975600"; 
   d="scan'208";a="98130002"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Dec 2024 03:06:41 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 5 Dec 2024 03:06:40 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 5 Dec 2024 03:06:40 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.177)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 5 Dec 2024 03:06:40 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dLnn62Ky558XQbu3lID7h45bnG8zBc7q4exIL1NgfFV+tbwZmagMWFcoc8vhm6rzL7PnoUsSFciCMNZViGDwetvCJ3wJukCPq4dcpbcW4iWihTs1JYSzDeWFnf8ukyMGN08BKIdsqO9VH84M38nkBIGN581e3qEXcRQX93D1/sI7x3EUi0pM65819F/k5x/xqKTJNqkOzhfZwZt03gXORIfOHZpSOmbqCRlajcTaruRlmy2SjMQpUxiEdAP+AFRhIjcNOzn9mzA0w7Kz1cUcRrBg7RrJioxNgnWkL+ZzYysYxHh5G9HjHLHq7LYjpRfaj8xqisfs8BSVQxeAfA2peg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kaY6/Wdj74H7xAgjX4Pz3yn79WQWI5rDcCctuHXOqyA=;
 b=d/dsm+7Cch+/Njt9WXCQLooBDDEwsHi9sp22jYJIUD/nAqtwok4v5tNVWEkKwcAG1fxIa36g49UPRM7bsloLdd8krU1AuDCZMsizla61Kxo3Huv+E4xngbtcXEqzrLUwrHo0g/9OkYAN+tumY0ufm3WT3AW2GEtcOZu4qOimrj7+VGB7ZjOtCBKcL680skNizxpv6rOHX+Q+qvpzKsXWQ3+YLpkSCVTraW51xih3cmDUiu8ksXc2+bgBpStlHosm8rbeviIPf2knj4SI0qa08xXsdLzr1ZCg0y5hxOaQ/AiZ+2UDQZeFfrjmx4/luZFXyaGmzACllfiIZ7XAdQLxqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by PH0PR11MB7470.namprd11.prod.outlook.com (2603:10b6:510:288::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.19; Thu, 5 Dec
 2024 11:06:38 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808%7]) with mapi id 15.20.8230.010; Thu, 5 Dec 2024
 11:06:36 +0000
Message-ID: <27b2c3d4-c866-471c-ab33-e132370751e3@intel.com>
Date: Thu, 5 Dec 2024 12:06:29 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC/RFT v2 0/3] Introduce GRO support to cpumap codebase
From: Alexander Lobakin <aleksander.lobakin@intel.com>
To: Daniel Xu <dxu@dxuuu.xyz>
CC: Jakub Kicinski <kuba@kernel.org>, Lorenzo Bianconi
	<lorenzo.bianconi@redhat.com>, Lorenzo Bianconi <lorenzo@kernel.org>,
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>, Alexei Starovoitov
	<ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko
	<andrii@kernel.org>, John Fastabend <john.fastabend@gmail.com>, "Jesper
 Dangaard Brouer" <hawk@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>,
	David Miller <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	"Paolo Abeni" <pabeni@redhat.com>, <netdev@vger.kernel.org>
References: <cover.1726480607.git.lorenzo@kernel.org>
 <amx5t3imrrh56m7vtsmlhdzlggtv2mlhywk6266syjmijpgs2o@s2z7dollcf7l>
 <ZwZe6Bg5ZrXLkDGW@lore-desk> <55d2ac1c-0619-4b24-b8ab-6eb5f553c1dd@intel.com>
 <ZwZ7fr_STZStsnln@lore-desk> <c3e20036-2bb3-4bca-932c-33fd3801f138@intel.com>
 <c21dc62c-f03e-4b26-b097-562d45407618@intel.com>
 <01dcfecc-ab8e-43b8-b20c-96cc476a826d@intel.com>
 <b319014e-519c-4c2d-8b6d-1632357e66cd@app.fastmail.com>
 <rntmnecd6w7ntnazqloxo44dub2snqf73zn2jqwuur6io2xdv7@4iqbg5odgmfq>
 <05991551-415c-49d0-8f14-f99cb84fc5cb@intel.com>
 <a2ebba59-bf19-4bb9-9952-c2f63123b7cd@app.fastmail.com>
 <6db67537-6b7b-4700-9801-72b6640fc609@intel.com>
 <20241202144739.7314172d@kernel.org>
 <4f49d319-bd12-4e81-9516-afd1f1a1d345@intel.com>
 <20241203165157.19a85915@kernel.org>
 <a0f4d9d8-86da-41f1-848d-32e53c092b34@intel.com>
 <ad43f37e-6e39-4443-9d42-61ebe8f78c54@app.fastmail.com>
 <51c6e099-b915-4597-9f5a-3c51b1a4e2c6@intel.com>
Content-Language: en-US
In-Reply-To: <51c6e099-b915-4597-9f5a-3c51b1a4e2c6@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA2P291CA0009.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1e::6) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|PH0PR11MB7470:EE_
X-MS-Office365-Filtering-Correlation-Id: df4d3c5a-1842-4b6c-6850-08dd151ce291
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?L1c5eHBlb3Fudi9DMG42Z2NJa1gxNHFERS9lQ0Y1T0ZocVV4bUpTOGNXN2V3?=
 =?utf-8?B?Y0R3UWZqRC9ydG5ZZnlzUUdRdmZ0bVZIUkJZeVZwRFJBbUUxd0x2WXZnRkNU?=
 =?utf-8?B?cXpCYU1wWGtGTnRRZU0wMndiWWtHdkcyWmk2ZXM2T0o5V2ZXZEErdFZoYkVB?=
 =?utf-8?B?L2g5bzNSWGpFbTdBTjNSbFRHTjhyb29BSWJEK0FBbGhWVlFlRWt1S253K25H?=
 =?utf-8?B?eEJzVDc0cVNCYzluMk93dkVsYUdibWJCaFRXWHlQcWVid3ZqbUxTM3VEVlJR?=
 =?utf-8?B?amltL3NyNXVwUkd3RDEyb0V0K0g2eU4wVTFpU2l5Q3RDNE5EcDM1TDFVY2dS?=
 =?utf-8?B?UEdTbjVMaDlxeVBaOVhWWVoxamJKeTZwN2pnSlFpRDcrYmprQ0RPUFZIcDg2?=
 =?utf-8?B?MkhNU0t3UVVuYU5rcGRnam9kOEFxdlF2M3ZQYmZLQ2tSQzc1SWxwcGF0SGJW?=
 =?utf-8?B?SFM0dURjZFBnUUsvOWNyQUVZNVpiNDRUcDhXQ1FMR1M4NllUbFlJelV6Z2Jo?=
 =?utf-8?B?bDV1MHJ2c2F4MXlJMDFqU2U0d3B4L3c4WTB1TXVqR0pVemJtbTdra3lxT1FE?=
 =?utf-8?B?MEFkN2g1WkFCVTlSVkY1SU5Qbys0TVI2UmFBRTlBbFd1TWFSaXZram9BWjM2?=
 =?utf-8?B?dytMR2U1RzN6UG92bk9PY0FCUFdyTHZ5SlZNTGRBb0Y5UGV6dW92ZDVnK2F6?=
 =?utf-8?B?aWZOK0ZtTXJIdnVzMXdkazBCL0M1NHZaSWJvMmtNekpwVDZlVnhqdnRra1Ez?=
 =?utf-8?B?OG5hYVVDNDJVV1I4dnR4a1FwRmpXM3JNRzJkVzBZZXhiZWlVTmVpdWJhTmRz?=
 =?utf-8?B?NzRWNUtsU2VhbXdxdGlrYkhxVVBENDJVZ2pHSVFxb01XZ28zQ3MwWDJLTkRJ?=
 =?utf-8?B?VHpTMHMxNDJJNGdCY1pkVHQ0dU0wZGt1SlRsSzB0cHprUGNNNm1BL0JyTjMz?=
 =?utf-8?B?SUxVQzd1UUlaZ0ZMc0lud243VGxhOGRkWUpHeWowaTh1ZVVuRUhFOFM0K0tG?=
 =?utf-8?B?RGxjeUpWVWwrWmZoVVcvOGk1ZkRmaFJsMDVMaGw1MkJ1K2MzRjEzckhETHYy?=
 =?utf-8?B?SUduem5mOWd6MWxFWGw4UnNwcjJIcUV5Rm5CekdxaEFER2h3dHdzT1N3Yksv?=
 =?utf-8?B?ZngwQldKbWhQbGF4Um9IR0hkM1BaeDNEdnBwaXVWVDZ3MnMvRCs0UHhBdWR5?=
 =?utf-8?B?U3V1LzZHVndpaElWSkdSNGlrZXVSUk81WHkxMTJqdGp3Mm83UFB4NzZOU2VL?=
 =?utf-8?B?NG55S1FsR3M4WWxtcVFYVWFEcHhKSTArbWpxRlRKenFYQ0l4QVUzQWx0aWd5?=
 =?utf-8?B?M3JmdWhuSS9mc1drTFYyRDRTMlYvUmg4TTU4SWtUT2VpMUNiNjBXK1Y1OWJJ?=
 =?utf-8?B?MVVoMnBaWVFvNks4NmkxVWRTMmZ2aGRLby9pelNyTm5NKzdIeXppY1Nrd3FQ?=
 =?utf-8?B?ZTBKeHh1ODNjM3RpN2ZpQlhFVTNMblVseitQY0lqaGNrMko3dklpSm1nWlBV?=
 =?utf-8?B?d09kQURQL3pDRDVhTmh2Nk4yKzFkM1hTT0R2SE84M0s5Y1Bpa095ZVRpdlBC?=
 =?utf-8?B?QmpINmVGVVExbzZDWnBhMElXTGVkZHBWdHhBSGpUbEE4Y3ZIT1JOZXNCdDF0?=
 =?utf-8?B?c1BHSUdjYnJ4YWx5U21ZS21rVzZHVDFSY1RBRG1IVHQ0dFFwc0pqRlJkVDN1?=
 =?utf-8?B?TjhiRGM3OCtJaUdidmV6VmQ5RVFCdm1VOUZxYnNjaWNhRWQwVFh4U0xxbEF4?=
 =?utf-8?B?V0FhVGw0bnkrT1prOTIveXFmTk05bEF6Wkp5SUZUamY1MmZoV28ybnljQVBU?=
 =?utf-8?B?T2RZTXRmZ1FvNkZQV3dlZz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dEhkMlJEaU4xSHBtRFN1TUJIcnFIa2JmOUJYK2tkTFozRzQwRDNxMXJ2SW1x?=
 =?utf-8?B?Q3ZtaTF3dFNnSHNka29UQVRmeWlIemNuNHJsVUZwTkYwcWorK1RuK0I4UU00?=
 =?utf-8?B?YkhtZEQraDN4K0lsN0FvU3BmSWJMMzlLbTIrKyszVWwyRkJPN3RNM3hhQnFR?=
 =?utf-8?B?SUNrN2hoeTJzT1NtdFB5RFlqaU1vWFg4clRxSktHanJ0c2dYQ0RscnJzMUty?=
 =?utf-8?B?NVpkdGhRUU5qOVdtTkV6S0gxRUFDZGZiVDRhejVyZjVKMUtxWHlEV2hmNnE1?=
 =?utf-8?B?bHJWaFdXY3NLM3Y0dUhjWnJvMlIrM3VuN1JJaDNFNEFjQ2VleGtkb3o5RFFi?=
 =?utf-8?B?SEhSS2llSWRwSW5yeUE0Y09yd2Zwb1RUTEdZTmltTzRoME1qQU9oZEVmYmRh?=
 =?utf-8?B?Wjk4blArekQwcFlvZjBZK2Rnc1N2bHRTN0tZanBxTU1QL3ppQ0NDUGtUVWN2?=
 =?utf-8?B?WktLKzdVTG5lOTJnckNGS281a0JOSFUwalVXc25SdGZnZzNkWCt1RXFob3dN?=
 =?utf-8?B?ZW1nQ1UwSjhOeHBGbmdXQ1lPWlZEU2I0TlU3cEpyaGNlckpBUzBEbnFPUGNU?=
 =?utf-8?B?SkRXdTNma1RqTWs4UlBQRGtQNnpXT3YvYXdJcUEra3FoNnJ6SnhUQzZrL2Ur?=
 =?utf-8?B?Z3NHOTlCRHdHVGs4TUdDWGpTR3JFMEwvV3hKam1uWVJyZ3Awd2YvY1FSQ3B5?=
 =?utf-8?B?L2pMaXB4QlhKMXY5MThRTEZpdGMyamRHNW1SWVNUVGZrRERzZUQyNUZEUVdK?=
 =?utf-8?B?VVA3YUV0T0l0N2NJRER3UFkvbElqYm95RWpWbDVqbUhsa25KWjRXRmExa2lL?=
 =?utf-8?B?WXh6TkZBcks3dldkOXdMSS9yTFRsVE5qY1FqOUIvR285UFlqbzEzMTl0c3h2?=
 =?utf-8?B?RTl1UmcyWTJ1SjdTenkwUFVLYzhONDR2N2N5cFFEL2NPc0pYWGdYUmFkS1ZC?=
 =?utf-8?B?bFJNa1pTMmVCaHJqQ0k4bEdBTC9XSXk3UkpIMitLN3JEVWN1Rm1ST1ZLL2g1?=
 =?utf-8?B?Z2pvSkRvZ2R3Z3hxcTZiVWZYTDBLWWgwVEJtSUF2Q1llSWQ4WkVlWkxiVFUv?=
 =?utf-8?B?cEt2WWVlaXdWV1ltVENySGJoVVYrWWw2Wk9YMmtoZFplVWpiY1I3RXpSQ3cz?=
 =?utf-8?B?SnVPdnFpSkw2OFc1TDdMbmZIeGhqdTVHSmtDQlFlcE1iMFlTeXZiQ09ZaWxm?=
 =?utf-8?B?Y2lUSWdENk9YdHNIT0FURGV0N2lOQUpZUk44MlpSMlkvWXEyeHQ3eGJacElP?=
 =?utf-8?B?dkdQOHhTcmthcTdSV001Ym1Ic1V1MnozZGNCd1JuUURnWmNsQ2ZPbWYwYkhG?=
 =?utf-8?B?TCtEcEdJWERKa3V2RGlXOE41dFZ5a2tvVk5HZzR6VDJwQ0VacVBaUnVzdmJI?=
 =?utf-8?B?LzFLTVNLSFpWaVZsNUY4Y0wzV3p5QUZUZkpXcWUvcjU3cmtrVmdvd2tBRk92?=
 =?utf-8?B?ZmhQdHVhb0pYYW5lOWtZQXcrQ1BUUjUrUXVFZURmcFA2YzJ1SkNwNjRTMy9s?=
 =?utf-8?B?Yml6NjZEblVrdDNmQ0JqVFVGa0pHVEFrMS93TkxzTTk4bGtUTGNYRHlxUUIx?=
 =?utf-8?B?TVhIMEIyaE05WUVUUUdaSTVaZ29wSWswNVZNOWJySHZsWjVXUmZpQUF2R09S?=
 =?utf-8?B?OFhQUy9PMG9uNHU1aXVFSG1PZzFCY3huR1M0WXpTMGxrTXRkSFFkc3ZNWm5h?=
 =?utf-8?B?dVJOWGIwbHFMemp5NkFhM29ldTRoSHcwaG1KdmpDR0JXRUtsV254eHJRdVFm?=
 =?utf-8?B?YlZHS0pBMmRXVjVEbS93SFV3Y09Ncm5XRzVuMTFSMml3T0V1OVBuT3QzVlFI?=
 =?utf-8?B?Qms5NkFrcDJhTE0zMldVMUthcnRDbU5oaWRDZEpNY0t6YXZ0bFNUTlhHdUN6?=
 =?utf-8?B?VTRjY0ZXaGpZZFh5dHMxTEcvWWd3NHJJeEdsd2YwTGFYQnJBc3pDSFJYQ0lN?=
 =?utf-8?B?SUVnL2V0Si96SWhEdlNzMlVzYVZKdUw2SC8vZ3Bwd2JWM3IvZVBTdnB5cXVE?=
 =?utf-8?B?Q1ZQL01lSUgzNTlqRkJBV3hmbXF4ZGRZWVJobFNCMGFvZ3hYa1gvaFd0Nndw?=
 =?utf-8?B?QXpwdWk5QmNSSXRVVW5UUjEzSjhCcXBZUnhmL3ZCaVhkZHo4dHN1OTNzYXo3?=
 =?utf-8?B?RmN2STJBc1JiYmhhWXRJTzRLZlNEWkRSWjNQcTJZcWhIcmxHK2oxZFdLVTNO?=
 =?utf-8?B?Y1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: df4d3c5a-1842-4b6c-6850-08dd151ce291
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2024 11:06:36.3902
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1DkxedjuGMh/nBA/Od4HTagrDwgOTyZeX7sWepHTXBolJjKtQTTApA5QPn4/yi++D1SHVZYOI+T8+MivOcowRjtEEzwp4VooxA/UC+xhovk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7470
X-OriginatorOrg: intel.com

From: Alexander Lobakin <aleksander.lobakin@intel.com>
Date: Thu, 5 Dec 2024 11:38:11 +0100

> From: Daniel Xu <dxu@dxuuu.xyz>
> Date: Wed, 04 Dec 2024 13:51:08 -0800
> 
>>
>>
>> On Wed, Dec 4, 2024, at 8:42 AM, Alexander Lobakin wrote:
>>> From: Jakub Kicinski <kuba@kernel.org>
>>> Date: Tue, 3 Dec 2024 16:51:57 -0800
>>>
>>>> On Tue, 3 Dec 2024 12:01:16 +0100 Alexander Lobakin wrote:
>>>>>>> @ Jakub,  
>>>>>>
>>>>>> Context? What doesn't work and why?  
>>>>>
>>>>> My tests show the same perf as on Lorenzo's series, but I test with UDP
>>>>> trafficgen. Daniel tests TCP and the results are much worse than with
>>>>> Lorenzo's implementation.
>>>>> I suspect this is related to that how NAPI performs flushes / decides
>>>>> whether to repoll again or exit vs how kthread does that (even though I
>>>>> also try to flush only every 64 frames or when the ring is empty). Or
>>>>> maybe to that part of the kthread happens in process context outside any
>>>>> softirq, while when using NAPI, the whole loop is inside RX softirq.
>>>>>
>>>>> Jesper said that he'd like to see cpumap still using own kthread, so
>>>>> that its priority can be boosted separately from the backlog. That's why
>>>>> we asked you whether it would be fine to have cpumap as threaded NAPI in
>>>>> regards to all this :D
>>>>
>>>> Certainly not without a clear understanding what the problem with 
>>>> a kthread is.
>>>
>>> Yes, sure thing.
>>>
>>> Bad thing's that I can't reproduce Daniel's problem >_< Previously, I
>>> was testing with the UDP trafficgen and got up to 80% improvement over
>>> the baseline. Now I tested TCP and got up to 70% improvement, no
>>> regressions whatsoever =\
>>>
>>> I don't know where this regression on Daniel's setup comes from. Is it
>>> multi-thread or single-thread test? 
>>
>> 8 threads with 16 flows over them (-T8 -F16)
>>
>>> What app do you use: iperf, netperf,
>>> neper, Microsoft's app (forgot the name)?
>>
>> neper, tcp_stream.
> 
> Let me recheck with neper -T8 -F16, I'll post my results soon.

kernel     direct T1    direct T8F16    cpumap    cpumap T8F16
clean      28           51              13        9               Gbps
GRO        28           51              26        18              Gbps

100% gain, no regressions =\

My XDP prog is simple (upstream xdp-tools repo with no changes):

numactl -N 0 xdp-tools/xdp-bench/xdp-bench redirect-cpu -c 23 -s -p
no-touch ens802f0np0

IOW it simply redirects everything to CPU 23 (same NUMA node) from any
Rx queue without looking into headers or packet.
Do you test with more sophisticated XDP prog?

Thanks,
Olek

