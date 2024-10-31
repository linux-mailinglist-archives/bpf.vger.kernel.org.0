Return-Path: <bpf+bounces-43636-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C8CD9B7590
	for <lists+bpf@lfdr.de>; Thu, 31 Oct 2024 08:46:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 875ED1F253DA
	for <lists+bpf@lfdr.de>; Thu, 31 Oct 2024 07:46:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4105C14EC5B;
	Thu, 31 Oct 2024 07:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UgK755Rq"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D10B4146A6C;
	Thu, 31 Oct 2024 07:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730360769; cv=fail; b=ELhB3h/0VAeMObDJxopQywvAjEKaklA5HbYUK7xrEIjDf4FDfbNJk9UrwpkhJX9ERb+MuiCmjD3ixs0KGS8htstYeYuZFCPegXtMIrlXix6d9ihxr50QBTfz0CEjNA73LAuz5BLXQkCvCJPMA0DZ+0jpoeOjQFu5HHsU6QDNhvw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730360769; c=relaxed/simple;
	bh=HkVlUHkm8kH4erjBZ1/CosoPKmaIjsGYqq99aayTUFA=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=XJReqIBenZwbm5Qoq9gH0hXK3V+om61Kq8XYYKMICWfdlyNXenSD0xekEnFfqpuhMlJjFd0Ocu4JYrUoeS8Gq4wvruo1KppYDOHTTO1Ch7dN3epq4OOyy+mtk8iwOQvWAtHoDAiKxxbw11XMLLeM8F/e0VxbJYcIHr+MW7lWwIw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UgK755Rq; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730360767; x=1761896767;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=HkVlUHkm8kH4erjBZ1/CosoPKmaIjsGYqq99aayTUFA=;
  b=UgK755RqXDlR38Ru0jOEbuJIDxDu0V/4TLPVYFA/rgmcykLkj6E1xl8X
   rGvt7+0/cNDioCoRxldbVAJoL+X7FXsCr8jHnAdGHo/1h36TyjjCa0OmI
   nlwh1wzpieE9MoYoN118IS7deJbEH8s9NVbdKL0uyz5C13nBtwM0wFl1h
   h7ZIqjec0zNb54OKJzGJViWvclyeBjwJkf2pFnmtuFboWFYmlc9bsciis
   01o4SzMeekPY5SKJB1RZTy0Ae+GcI4C3oH7b8kJ1zIAZF+w8D8Jl0eMe0
   njNdVdMTILqROXROYWEXXSATV/aJQGRIOAG1tpLtYGS8ExSBddIBcdQ2j
   A==;
X-CSE-ConnectionGUID: x+Ud9J+gQGWNdP646AIV5Q==
X-CSE-MsgGUID: D0FEiZSNRjGaElnVrkOkog==
X-IronPort-AV: E=McAfee;i="6700,10204,11241"; a="29524654"
X-IronPort-AV: E=Sophos;i="6.11,247,1725346800"; 
   d="scan'208";a="29524654"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2024 00:46:05 -0700
X-CSE-ConnectionGUID: i24vwCCsTx29L8FrI/I6oA==
X-CSE-MsgGUID: moaPYm3RSfG+OnkbHQcqDQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,247,1725346800"; 
   d="scan'208";a="82664822"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 31 Oct 2024 00:46:05 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 31 Oct 2024 00:46:04 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 31 Oct 2024 00:46:04 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.174)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 31 Oct 2024 00:46:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M+Jp7kb8IiejAwYIIZI0fYXqHJtFgB2vwp9Vz53oaQumspdZVXC1pfqe6rDUPWePHkLv/Rl1IWiaAZo4OS7vS7udDdIlnUD7v0yPqfIrn2B9T8YomXjgGjL3HlvDMcMvr/R4zUg16rsahYLhM5r031j3zDoV/u0Nv83AikzjHnxIBySvOR08cA/5v0Mwm3BP/eBsKzISKeWiQnSlY5THwRQgrec+6rl8ze1XdHB1gsAGNdExYWARv65LkBWyOpefthB6+DvoFl1W6RNkbLwETik3EVXSW85FOk9uQB3mWYpLic1DonPIo/pRrBhG+LHRyavpywWDxrFegq+tH1ezaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vp73C56Ruo0+AzektHfrRKtdX5M5KWlThGYnnvyFZLo=;
 b=i210cbYZvOloTkXaDqTkIUlITnyNB7UiB4g8p4D1dBuh/Sx6UxuaEqTOdKhiiLKw5QCatN5qDjlUEYEB+nmNHudpnDa+PAdiMUvmBTSlf7y7rLtHC2X+VAq0cgW6PIMWmmgbTqKvaaCOSWWzNMqtgrJMI+rPB//xNTjMWB30KSU5rFvDhusr7SH0u4sloU33+6VrsgAjv4sd/F2MWWiv+uLVdkmnsKuqdKqmdact/f0re1eg2X8sCHqMiEStO+OSmZ1/IVVY46k1IaTdvX4DI3MObNYzkXS5/o8idd/w/woe0LxbrMZa3/thi2IDW2gyeFQ/i7KtoMbEnKMQqQrkbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by DM4PR11MB6285.namprd11.prod.outlook.com (2603:10b6:8:a8::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.20; Thu, 31 Oct
 2024 07:45:56 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6%6]) with mapi id 15.20.8093.027; Thu, 31 Oct 2024
 07:45:55 +0000
Message-ID: <59f4a6e6-23ad-4f99-b168-047f1d0d801a@intel.com>
Date: Thu, 31 Oct 2024 08:45:49 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2 net-next iwl-next] net: intel: use ethtool string
 helpers
To: Rosen Penev <rosenp@gmail.com>
CC: Tony Nguyen <anthony.l.nguyen@intel.com>, <netdev@vger.kernel.org>,
	"Andrew Lunn" <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, "Eric Dumazet" <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov
	<ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard
 Brouer <hawk@kernel.org>, "John Fastabend" <john.fastabend@gmail.com>,
	"moderated list:INTEL ETHERNET DRIVERS" <intel-wired-lan@lists.osuosl.org>,
	open list <linux-kernel@vger.kernel.org>, "open list:XDP (eXpress Data
 Path):Keyword:(?:b|_)xdp(?:b|_)" <bpf@vger.kernel.org>
References: <20241025201713.286074-1-rosenp@gmail.com>
 <ca89f03e-6dc1-44fa-bfd1-aac95ede0cbe@intel.com>
 <CAKxU2N9hhwfdZN28kTDf3qUT8GXuxLDPFsA04jBaJSWqPRaHqQ@mail.gmail.com>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
In-Reply-To: <CAKxU2N9hhwfdZN28kTDf3qUT8GXuxLDPFsA04jBaJSWqPRaHqQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: WA1P291CA0011.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:19::8) To MN6PR11MB8102.namprd11.prod.outlook.com
 (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|DM4PR11MB6285:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d1e5870-1b5b-41f2-7411-08dcf9800d6e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NmpYaEdjT0NjRXpTUVBkNFN6NUdpKzJsNUhraE1SZHFJWlBSVXJSMmVWckIw?=
 =?utf-8?B?cDJIL3Y1S1YwUFVtMnFxZmdzNXRramV6NmVZTHlNS1R2Z1pRaStYNEhia1Mw?=
 =?utf-8?B?bXZQQU1Zb0VCZXo0dlhKRDZUdUhKZFhlZkE0T3RRVEl0OU5mL3AxUXYwWHlu?=
 =?utf-8?B?RlBRbmRYRFpkc1g1VWsrQ2RPd1lDQ1JMbTZnSnhsVUxGVWpDaUZZbjVsYW8r?=
 =?utf-8?B?ZjZDQVhwaU9IRHpBeUhZRTQ1L3hENmFhOC9XSnhtQzdkd010a1I3MVhpaU1H?=
 =?utf-8?B?QUVnWEtHOE9NcEFQMDZlV05TeU83QzVQYlZscXJUTlpNak9xcUVVS2JIaFN6?=
 =?utf-8?B?Vkhmb1F0K0Roa0c4NnBZc1RadmpXeHArRzVzSzloZExTS0tjaGFCNmM5dnox?=
 =?utf-8?B?bDFPZE9kOHhleTNxODVDWnF2TDc5bUgyV0x1NEJ0ZGEwRk5UeEhLa08wTTFN?=
 =?utf-8?B?MSsyUWhNYi9zbk5lc3ovbDVHMkRQZkFVaktKandja2Y2UFNxOXE2bVZFeTdT?=
 =?utf-8?B?UDVwL2JGSU10RWIxdE1yVXdRcEJVd3NCL0k0VGdLMWRKUWVQVFZ0eStva3JR?=
 =?utf-8?B?emgvdURRQVg3bEljRmsrSTdSMFA0V0lQVVI0T3RjL21jZVZKbVJ5R09yMVYv?=
 =?utf-8?B?eG0zekRkc0dFWVVZVUE4VGJFTUhtckhrNWpqQmVxcW9tSWQyWE9neGdHSmlt?=
 =?utf-8?B?bGpKLzgwYjYxWCt6cTZKdEsyOVhsdnFmME91OEZDVGhva2ZhbkRyYXV4ZElC?=
 =?utf-8?B?ZkRnN2RHWm9wSGJNYjFsQ0JzWHJ3QWdhS2tnQkRSemZhRGtJaUlmNTJWQUtC?=
 =?utf-8?B?NDU3VzRtSXhybVlvWUVUSW9KcHpiL05wRmtvMll5VktnTUkwWkt0NkpTQUdB?=
 =?utf-8?B?ZnNTamdXcU9Cdi9RRCtTRmlxcDFHRERra1Y2S2ZGcFZPRWdXTEEvSUpWNnRV?=
 =?utf-8?B?eVZPaU5LMStBNnlJcW5UWHAwc3NBU3hGbzRJOVcyZ2ZOUGtubGxiaUlsWkVz?=
 =?utf-8?B?QkpqcFp0KzZWWEFRbU1xTmlKRFYwSzF1MlZNWElRNE1ER2crK2ZER0lJMGlp?=
 =?utf-8?B?dlNFRm9zOVkrb2s0cTIxblFhY0lUWUtMTnJ3YVdVbllDR1hVVFJIbjI1bEQ2?=
 =?utf-8?B?STZyeWNQdlVRT09GaDBRQ2VGLytTRWo4ZGNwOWw1QnNrdGZoMGhKMktVLzZE?=
 =?utf-8?B?cytwOGNPd1JrcEN1YzFIYkIydEQyT1FsSC81b3ZiQWhINEEyY2ZnSzF4RHdM?=
 =?utf-8?B?d01nYTNjQjRPTC96ajRqMjYwUGdRTVVwMWVKOW92NklrdU5SL3hqSElzdmhx?=
 =?utf-8?B?QVA4Zlh0SndJY1gvUzEwNVN6Njdaak91bDdHMnRKQmNXUUd4L1cyMEZZOHd6?=
 =?utf-8?B?b2ZHVVBncXd2RUk3Skw0aWJYZkQ3eHVNdXc0SHAycXQ0Q3pENTBLWnJDcEJp?=
 =?utf-8?B?VDhHN01BM0oyMXJxS1M1TXlEcWNqVUlyNEhvUWdQbDBCV1hzMDYxK3h1dVNK?=
 =?utf-8?B?MU9NMjFOQ0I5WWpVRUxtK0I1LzdTbWgzVmRFaWk3UHl5OXdJajdxN2oyS2dI?=
 =?utf-8?B?bitVWjJvUlgyaDNGZW16TTM1SnlZS0lnZ0thOWI4TDc4OGUwV3ZZUzhNMGor?=
 =?utf-8?B?K2kwVlN4ZEF4Z0tzSE5iTVVuMjYzTWFHMEc1dllkdUl2VjJwN2RmSC92VzBx?=
 =?utf-8?B?ak5LWEhtMWxXejNrK0ZYTHFNeFZsK3lBd2VqQlFodTdWaXM5WDRQMU5BMnV1?=
 =?utf-8?Q?kd+H0hhpgRuEj1Glog4okxrpH5y+gpa3fmy2Y5J?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eXVObWlRbTA5Y1l4OENjUCtaT3JidklZd3YxV3dLdEFxMWJOY05ISzFEKzZv?=
 =?utf-8?B?Q2Vtby9lY1Vyb0N5SThkWkFSZVNaOWxJcVBkRXhlWmZuTHJkcmtFK1hQYitS?=
 =?utf-8?B?RHBnR1RsVHYvRmxTcS8zRFRiTUw2bGdWTm5pMmpnYnZUQ0JDWEpzTk1rT2dC?=
 =?utf-8?B?YmpEZG1oanVJNVNYTzVaa1l2M1IweDhkZFA0MDR0cmswTnlzdG1GRjJOVzNI?=
 =?utf-8?B?TGlxWlFXM050WWVENzZPLzVBY0N6d3RwYjNrZmhlbkcrN2M1TUNQaDVQZXdk?=
 =?utf-8?B?Q3ViNHlxOVl3aGNyZlRPdkd5dXlQczk5N0o0ZUErU1cvaWdQNzBhR2NqYi8x?=
 =?utf-8?B?bmVMdkVzSEJsMm95bmdPaWM4Y2x5eVhJYmpEck1rSzYyd3dQdDZLZThjVnd1?=
 =?utf-8?B?RTA2cTdhaHhtZGlrT3RCaGpKdVp5SjdRUHZSQU04RlBFS0Z5TTl4a0FHbmxh?=
 =?utf-8?B?SjNkWGFrSUVyYWM3RkpyU3VPbDd4bk5nSnZHNHFYbHNVTG1FMWpHcUdKQVdH?=
 =?utf-8?B?WTVDbUJRemRoZXZUL2VKYkpXalZicWxNcTRhTUxYNG9QQk04NVJkNklSUFEv?=
 =?utf-8?B?bDdrUTYvWlltc0VnUVUxcitISUNKOGphTHZjUXhYUVVGNnNseXZQTFprN2hY?=
 =?utf-8?B?RHZJWENJOEhJQVZkU2J3Z0RpYzJxRkdnYjB3dExtTXdIRnFoWTY3ODNBVXZ0?=
 =?utf-8?B?TnZVRkNwR0xWQW5aUHp6WWJCYTR4K0YxemRIUTBEK0lHVHNZcWF6M1VZRUk2?=
 =?utf-8?B?b0o0R1ZmZm5ZOUxRMmVFcHNTODNLMHZrUXZ6WHo0em9zcUhVZmtUcm1kcmhR?=
 =?utf-8?B?VERLQlhwYVNZdVNmUmZDNVF4LzFFRkI4WlZ5d1ArcThjVzJ3QWRIOHEzcFZL?=
 =?utf-8?B?d1QrY2pya09FRTdEOWlKZG1KMzVLckhFb3JWS3dXaUJOT3FmZ1JuWW4xVGUy?=
 =?utf-8?B?TGV1Sk5wQVRXOTBEc0hhdEZvczJpeVJnSU8valVJV3NIS2t1SWk1NERHQkZ5?=
 =?utf-8?B?OHlxOUhlWjBJa096NnJHMXdYcUVjU0QrMzBuRC8xOXBUSGJBejFVWEJ0WnFY?=
 =?utf-8?B?bHg1aVVpbTBHRk5pV1VSYUp3eUxodDh0N0ZRajUxRUVqNlZURytEUGI2dEl2?=
 =?utf-8?B?Z2JlTlVMdzFoNDlmcFVaRVhKeS96SkJLWHREY1pHUjREN2JlYjIwcmtUL2R6?=
 =?utf-8?B?azUzZnNaUFgzUDVVTWN1VkYvOXRzUUNLK1J5RGY4NC9KNWhyVEZxTjNhcmVU?=
 =?utf-8?B?Vk54NWpDa1dvZzRYRjFUNGJKYmRoMUJPSCtOR25RK1Q0NnZ6Zyt6Q1c0OXlh?=
 =?utf-8?B?UndpVlFVK2cxV3lRZE9xUUUweStFR2ozQ0F2eTQ2Z3FxUC9kSEVDR0dCdjli?=
 =?utf-8?B?b2ZWOUdVTjhzWWt4dTM2OXNhZ3liSXFuZ09TNTZabjRsUGFxcFBBK09hT1BH?=
 =?utf-8?B?VkhUNkNwYzZPQ1MrSkRLcGllMFdjTTlEMXdMYk4yaFdGWkcvcDJ2cml3RjM5?=
 =?utf-8?B?ZHAxOGYrcmpjKzlubXFXYnlHc05YbXY3QWg0U0tIV3Z0a3U0REFaTnN5ci8w?=
 =?utf-8?B?cFRJekxQQ0orUk5mbFZXb0hvVlhvREVyaWVtQlZHUE9jYVloeWErOWJDdEg2?=
 =?utf-8?B?R1hySG5zQnpLVXhkanhFN2lDdFF3TlZ6TUk2WUhsOGxBbjFubHZoVDVlWU9O?=
 =?utf-8?B?aFVoMk9CRy84elR4NkZKdFJlb3pkMzY5S2lqZW9sMVNWa2ZBMmFiMEJFb21j?=
 =?utf-8?B?dUd6VWcrYXJQbUxZS0p3bFpvRC9Ea3FxNFg1b0x4c2NJeS9MVTNNU1VuUW1N?=
 =?utf-8?B?ZnBaYy9DRDlpbEx4MEc2UUhrMHNFOWhna1JlNFVVUU5JY3pTNStpcDlNRDJZ?=
 =?utf-8?B?Z0gxZ0VqK09UT2YvK21LNkp0Y3JkU3FjNnpWN1pNcDYvUkRsMDhHOUxsY2pC?=
 =?utf-8?B?RGI1Q2FLSmhLTVJMWTNZcXpJbHg4ZlEwODBhQlJMOC9IcTNMZGtMa2F4VTBy?=
 =?utf-8?B?S2Z6WWkyTXBJd3l0dmFpcDRRaFB6VHovTVBuczhFcWtRY2dUcWdKYnJPaFkx?=
 =?utf-8?B?ckpWUHF1blUyS2hDb0pHTVM4alJ4YW9mdzdRdG1QUW5pRUlGUTRZMlM1TXJz?=
 =?utf-8?B?NmhKbzZ4d0NiR2VtdGtPdmNZdm5jQVVaQXdyWncwbXZsV0RETjRLZ21qZ3VV?=
 =?utf-8?B?SlE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d1e5870-1b5b-41f2-7411-08dcf9800d6e
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2024 07:45:55.7171
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I+607GOqPQD52Umy4mOsjCiXeBO57Q+oescPH8uWYMvQAGHATRlTi/EGnUtIP2jMNVge0RA0YSSgyTAUQcZOdU6RDsJRF6lDMgh9bE9COc4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6285
X-OriginatorOrg: intel.com

On 10/30/24 23:52, Rosen Penev wrote:
> On Mon, Oct 28, 2024 at 3:13 AM Przemek Kitszel
> <przemyslaw.kitszel@intel.com> wrote:
>>
>> On 10/25/24 22:17, Rosen Penev wrote:
>>> The latter is the preferred way to copy ethtool strings.
>>>
>>> Avoids manually incrementing the pointer. Cleans up the code quite well.
>>>
>>> Signed-off-by: Rosen Penev <rosenp@gmail.com>
>>> ---
>>>    v2: add iwl-next tag. use inline int in for loops.
>>>    .../net/ethernet/intel/e1000/e1000_ethtool.c  | 10 ++---
>>>    drivers/net/ethernet/intel/e1000e/ethtool.c   | 14 +++----
>>>    .../net/ethernet/intel/fm10k/fm10k_ethtool.c  | 10 ++---
>>>    .../net/ethernet/intel/i40e/i40e_ethtool.c    |  6 +--
>>>    drivers/net/ethernet/intel/ice/ice_ethtool.c  | 37 +++++++++++--------
>>>    drivers/net/ethernet/intel/igb/igb_ethtool.c  | 35 ++++++++++--------
>>>    drivers/net/ethernet/intel/igbvf/ethtool.c    | 10 ++---
>>>    drivers/net/ethernet/intel/igc/igc_ethtool.c  | 36 +++++++++---------
>>>    .../net/ethernet/intel/ixgbe/ixgbe_ethtool.c  | 32 ++++++++--------
>>
>> for ice, igb, igc, and ixgbe the current code already uses ethtool
>> string helpers, and in many places you are just changing variable name,
>> "p" to "data", I would rather avoid that.
> well, since I'm cleaning some of this code up, might as well get rid
> of variables. That was suggested to me with other similar patches.
>>
>> sorry for not spotting that earlier, and apologies that we have so many
>> drivers to fix up in the first place
>>
>>> diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool.c b/drivers/net/ethernet/intel/ice/ice_ethtool.c
>>> index 2924ac61300d..62a152be8180 100644
>>> --- a/drivers/net/ethernet/intel/ice/ice_ethtool.c
>>> +++ b/drivers/net/ethernet/intel/ice/ice_ethtool.c
>>> @@ -83,7 +83,7 @@ static const char ice_gstrings_test[][ETH_GSTRING_LEN] = {
>>>        "Link test   (on/offline)",
>>>    };
>>>
>>> -#define ICE_TEST_LEN (sizeof(ice_gstrings_test) / ETH_GSTRING_LEN)
>>> +#define ICE_TEST_LEN ARRAY_SIZE(ice_gstrings_test)
>>>
>>>    /* These PF_STATs might look like duplicates of some NETDEV_STATs,
>>>     * but they aren't. This device is capable of supporting multiple
>>> @@ -1481,48 +1481,53 @@ static void
>>>    __ice_get_strings(struct net_device *netdev, u32 stringset, u8 *data,
>>>                  struct ice_vsi *vsi)
>>>    {
>>> +     const char *str;
>>>        unsigned int i;
>>> -     u8 *p = data;
>>>
>>>        switch (stringset) {
>>>        case ETH_SS_STATS:
>>> -             for (i = 0; i < ICE_VSI_STATS_LEN; i++)
>>> -                     ethtool_puts(&p, ice_gstrings_vsi_stats[i].stat_string);
>>> +             for (i = 0; i < ICE_VSI_STATS_LEN; i++) {
>>> +                     str = ice_gstrings_vsi_stats[i].stat_string;
>>> +                     ethtool_puts(&data, str);
>>> +             }
>>>
>>>                if (ice_is_port_repr_netdev(netdev))
>>>                        return;
>>>
>>>                ice_for_each_alloc_txq(vsi, i) {
>>> -                     ethtool_sprintf(&p, "tx_queue_%u_packets", i);
>>> -                     ethtool_sprintf(&p, "tx_queue_%u_bytes", i);
>>> +                     ethtool_sprintf(&data, "tx_queue_%u_packets", i);
>>> +                     ethtool_sprintf(&data, "tx_queue_%u_bytes", i);
>>>                }
>>>
>>>                ice_for_each_alloc_rxq(vsi, i) {
>>> -                     ethtool_sprintf(&p, "rx_queue_%u_packets", i);
>>> -                     ethtool_sprintf(&p, "rx_queue_%u_bytes", i);
>>> +                     ethtool_sprintf(&data, "rx_queue_%u_packets", i);
>>> +                     ethtool_sprintf(&data, "rx_queue_%u_bytes", i);
>>>                }
>>>
>>>                if (vsi->type != ICE_VSI_PF)
>>>                        return;
>>>
>>> -             for (i = 0; i < ICE_PF_STATS_LEN; i++)
>>> -                     ethtool_puts(&p, ice_gstrings_pf_stats[i].stat_string);
>>> +             for (i = 0; i < ICE_PF_STATS_LEN; i++) {
>>> +                     str = ice_gstrings_pf_stats[i].stat_string;
>>> +                     ethtool_puts(&data, str);
>>> +             }
>>>
>>>                for (i = 0; i < ICE_MAX_USER_PRIORITY; i++) {
>>> -                     ethtool_sprintf(&p, "tx_priority_%u_xon.nic", i);
>>> -                     ethtool_sprintf(&p, "tx_priority_%u_xoff.nic", i);
>>> +                     ethtool_sprintf(&data, "tx_priority_%u_xon.nic", i);
>>> +                     ethtool_sprintf(&data, "tx_priority_%u_xoff.nic", i);
>>>                }
>>>                for (i = 0; i < ICE_MAX_USER_PRIORITY; i++) {
>>> -                     ethtool_sprintf(&p, "rx_priority_%u_xon.nic", i);
>>> -                     ethtool_sprintf(&p, "rx_priority_%u_xoff.nic", i);
>>> +                     ethtool_sprintf(&data, "rx_priority_%u_xon.nic", i);
>>> +                     ethtool_sprintf(&data, "rx_priority_%u_xoff.nic", i);
>>>                }
>>>                break;
>>>        case ETH_SS_TEST:
>>> -             memcpy(data, ice_gstrings_test, ICE_TEST_LEN * ETH_GSTRING_LEN);
>>> +             for (i = 0; i < ICE_TEST_LEN; i++)
>>> +                     ethtool_puts(&data, ice_gstrings_test[i]);
>>>                break;
>>>        case ETH_SS_PRIV_FLAGS:
>>>                for (i = 0; i < ICE_PRIV_FLAG_ARRAY_SIZE; i++)
>>> -                     ethtool_puts(&p, ice_gstrings_priv_flags[i].name);
>>> +                     ethtool_puts(&data, ice_gstrings_priv_flags[i].name);
>>>                break;
>>>        default:
>>>                break;
>>
>> really no need to git-blame touch most of the code here>
> 
> Actually the function should be taking a double pointer here I think
> in case something gets called after it in the main function.
I mean that both @p and @data are (u8 *).
I'm fine getting rid of tmp var, and updating the originally passed
argument is fine. But you could achieve it by just changing param name.

BTW I guess it was @p to fit into 80 chars more easily ;)

