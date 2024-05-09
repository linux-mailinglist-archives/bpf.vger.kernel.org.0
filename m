Return-Path: <bpf+bounces-29195-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E2D08C11D5
	for <lists+bpf@lfdr.de>; Thu,  9 May 2024 17:17:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9091CB22AB0
	for <lists+bpf@lfdr.de>; Thu,  9 May 2024 15:17:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7AB615E7F3;
	Thu,  9 May 2024 15:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RPj0EA0B"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FF0D131750;
	Thu,  9 May 2024 15:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715267857; cv=fail; b=OqQbiCVsJlyBYfwhkqrURwP3vrbf00HpR+UNi+kGMPz1CEeqP0JoRtVxy6N860eKl29oMY6j5NylOwWll7y3uWNCyT1VHXODc2AJqpzLm62XD2LushRXkEMPbQjwTqt+TpFyMzz399AzdW3nyk0OVyWOb0mblvcD2DNTyJjVXus=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715267857; c=relaxed/simple;
	bh=AELbwE+favAMwO5kBIPPRY5rr+UZSjKE4JpVFLIjBWs=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=pIF6xwLXKrOAxGwd9dqCaSkpueq0pmivljtySeaDfeUKeOWU1eV79Sa6y1gAeedQjRr0tn6AwHKsIXyfDApc8ci1vvz4LZpWe9ZzS9alJ3WD/WDw2Llw7kjC+F/PaywOPWyf2K7d0g+0xjMItPK95Fcm0KYoq53pyLg64Y4rOyE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RPj0EA0B; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715267856; x=1746803856;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=AELbwE+favAMwO5kBIPPRY5rr+UZSjKE4JpVFLIjBWs=;
  b=RPj0EA0B2LRpR7SlghTNMbNzXcQRITl/hBNxKXib7cLhygKnmPJaIDtn
   EUWVK0OerWXCVYxJ44ZyzonCk3WzUmrtu0ypO6cMjCW426ryvN+/jQ4sa
   h+6niMfmWGYHTlvD91qNy1ICJ/nTzyggd7KAxvE2ZLUdq5DYhExfs1Wbl
   1URMp5DTEE07DdArgQ0z35u6DV9yW0jrvow9ypNALV4ybSgJuOwlkBTgZ
   Y5PspESWRg/vgvit94nKaYPPsu8oV/Jg6lIx1ksceTrvoe5YGXn/UbAlZ
   XfbU3cvdwlXm1mt1sH3huzmhFYtummwPCuK5N9at73XmM9o3OquCVPO23
   g==;
X-CSE-ConnectionGUID: y/FJtl0PSlqlmD9In0DgMQ==
X-CSE-MsgGUID: RofHo4M2S1iKtSTE+P91nQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11068"; a="11044239"
X-IronPort-AV: E=Sophos;i="6.08,148,1712646000"; 
   d="scan'208";a="11044239"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2024 08:16:59 -0700
X-CSE-ConnectionGUID: V3fImGyXQlmjU6JrUddT7A==
X-CSE-MsgGUID: XMTq+TsXQa6+Aq909QFziA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,148,1712646000"; 
   d="scan'208";a="29344358"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 May 2024 08:16:58 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 9 May 2024 08:16:57 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 9 May 2024 08:16:57 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.172)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 9 May 2024 08:16:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WdicS77Zoli7oq2gTPATBAlha7WaaYLobFlHTXZvOEhkxT4yIjOprczTiWzi8IMComP3geMtzTojmCwHno0ZAuaDjaVwmgy1dODmVMfasXaTLLo3Yx6RSjvPG8r7Ujmp3cD7zvczFAQ9RTHgaYCD0yE94UqJoc7dlRYqFNwpKgzKUJ1B7lpj/quKT6qoA0+DGWVtPpf/7+hMdTdi6Ewasq66wI5depNXOIkPuEmIJ6s57vnuUIkE6yJ8cHkz0okItieNRJLOn/pMSoD1N8WTSbux7vhR32W8KueYU1YztSq5cwxe2LWYS6lKSqYLaPFBLEY4JSy257J7Ohq5afE+xA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=suk+n7O+UjtRQyjBMReIbd4roa0gjZ2RFP20NruK03Y=;
 b=QRt5eN+yHA4kwKUwAhWt81Kd4s3am1DyA8mPP0SrANEcrPNeAkbCwnGr7lqxcUGGkW69GJ5op4NImnCQcLs9qxDHRsJarTKcBBvbkP2XgBaPJaAed3+rMxLfLKC9p0bJhqY5u+j/QfDaZ0B/Z8thqrbCvGAbtz6jZV0XzseTF3Iv3vNcJcSpAZzw+mJ4nKIe4zdYcIaGILLyoFggd3Qhnoq0EfLLc327lWgYqjCs4QN9u8ncKcW5Rq8y1GDgMGQqa7OGAAsW2EH3HTZvB8FLaVSHsZBQVq/KUXPy+2ejhwuQIDnVClPDhoCGRO4eqYU19/VEdA1KQqvKKwi1jcakBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by MN0PR11MB6181.namprd11.prod.outlook.com (2603:10b6:208:3c7::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.42; Thu, 9 May
 2024 15:16:47 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808%4]) with mapi id 15.20.7544.046; Thu, 9 May 2024
 15:16:47 +0000
Message-ID: <6ce428e6-3585-4ef5-af08-debef0a7c308@intel.com>
Date: Thu, 9 May 2024 17:16:13 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dma: fix DMA sync for drivers not calling dma_set_mask*()
To: Steven Price <steven.price@arm.com>, Christoph Hellwig <hch@lst.de>
CC: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy
	<robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>, Will Deacon
	<will@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Magnus Karlsson
	<magnus.karlsson@intel.com>, <nex.sw.ncis.osdt.itp.upstreaming@intel.com>,
	<bpf@vger.kernel.org>, <netdev@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>
References: <20240509144616.938519-1-aleksander.lobakin@intel.com>
 <ce83b3b8-2246-4006-a111-f2da0740bd8e@arm.com>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <ce83b3b8-2246-4006-a111-f2da0740bd8e@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0001.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:3c3::10) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|MN0PR11MB6181:EE_
X-MS-Office365-Filtering-Correlation-Id: c989dd9c-3a0b-4fff-9172-08dc703b0b44
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|7416005|1800799015;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aXk1TkVWMi90ckVsSlhFVDE5c0dvSlRVbXVUNzVqcE5FZnRqejhPUFhlSzAz?=
 =?utf-8?B?Yy96ckptbFlxVGZxdHUza1ZjTjcyODR0TlIreThKL3YvT3h5SE1oVFBxZ0Z5?=
 =?utf-8?B?cVFRVWVzeXArZ1BwbTc5aEVEUVVCMmROTXVOTkN6RnJsdWo3S1E2UkJQWDFH?=
 =?utf-8?B?L0tyTUYxckd4K09DK2pKR1dxV2greWR5dEQ2N2xlVlVSdTRnVGNsREUvMS9Y?=
 =?utf-8?B?L2tnSTZJblJMVHM0NUU2Y3JVcUxOY1RMYkxDSWVNVFIzUTV0UzhNejBGNUZ4?=
 =?utf-8?B?MVFKeXpMRlMwNmczN3pVclVDdlkrOWtzWEJjVk5mc3dRZ3hEbmtaRmJISWd5?=
 =?utf-8?B?K0FmOENBQlNwSFJPN2dCZXpLK2xKUHpibUNsRVBlVjhlMll5QmFYemF3QlNh?=
 =?utf-8?B?RVBHYnRJMHVQZGJpSERNY21GL2I2Y0NoUnlKSTc0VnFLNHJEY1BuSlFPZUZI?=
 =?utf-8?B?ZXRwWkROT1RpM2ZrUzZJN0REcmxFSXQrd1g4M3lHVC9WcUwya0t6V0R1Z0xT?=
 =?utf-8?B?Ukx3elFoR3BHYUQrZ2FIa2pjNERUYXpTemo3Wm5JL3VSb2xXUWwyZCt3REli?=
 =?utf-8?B?Q1NJNVBJM29xSWFVWVZyQlBkYzhMb1BoazRNenlNQlNaTC95ajQ3Z2hTYjhN?=
 =?utf-8?B?WjZoc3MrRUJpeC9EMVNOWjNaR3BnVEMrMi9vamVYalNiMXlsZXdFTDUxbDE4?=
 =?utf-8?B?SDZ4b2Z3VUkwdnBjNHE0bmFsUElPbElNNWsxRTF6U1dXdlRpOW9ReVFMNGFv?=
 =?utf-8?B?eWdMbXY4ZmMrbmoyS2JZemxPOFVzcVB3NWhseG53L2hjSisvV0hCcUJnemtD?=
 =?utf-8?B?WE9oUFVzMGtlb3ZEdFczS3lHOGQvWkRvQjh3LzhsTnhsc3JpaDIzV2diWDQ3?=
 =?utf-8?B?RjJZOHkzZXo2Z016eXhaUDlLUmlQZHFaby9HMkJsbWloWGhQWmg2RzRuV3hM?=
 =?utf-8?B?UlBGcXVjTjU3ZHpDNDZaaGdWWURaaHRLYzA4YlczTVBIR0lKckh6RjEwcS8v?=
 =?utf-8?B?ODI0OXF2cEgrTWtDd1FLQUZVQjNFZVZGbEpGR01BcTZhL0RLcmFqSG1yd1lm?=
 =?utf-8?B?YjVScEdEMjFHVnV2aHVSU1g4eG9UbjJXUmF5YTVEaEdHd1NHRlNDemlvNmZj?=
 =?utf-8?B?MDVPTTJzeVJSZTEyTmpXaHpIV1dCODBkUkNIQWd0UTJuY3pIRG93K0thSmZx?=
 =?utf-8?B?d1ZyV04xbG9KT00rVCtjRGkrM1A5MFdtQ0RWMUFuUTJXTmt5RWNlUnFkdHJG?=
 =?utf-8?B?VkZNdkxIOW9hZm1MK3plVWQwYU9maHgvd3RsRlRmQmtYcjllZkNRSVRPRXVr?=
 =?utf-8?B?YnN5VkJnbFRDVUZ4RmhvY0NOZTJCYyt5ZUZsZWd3cndaSW9xM3BLK1Z6Z2gy?=
 =?utf-8?B?ZzQ0Vytkck96YkNDZXYzOFVnR2RHRE5XeHB0enp5eG9Jdm1vSVY3enlIV0Nt?=
 =?utf-8?B?bzd6eTEveHBOK2R0UW9jcU00NURIcnN5emtWNE5ydUFiK0x2eXBwMUdGd1cy?=
 =?utf-8?B?S2JOQ1RSWGl1ai9nZ21tdGdBdTU1dkk5OGE1YlVpYUhHQXQ2VzlJbTYwK2dM?=
 =?utf-8?B?aEc5L2Z5VytYTm5xZXhHS2VJR2xUdy9ERFZtcHFTV0IwK3lramR5eWNNQWlH?=
 =?utf-8?B?VXA0SDZjN1dRYVdPUmlscDVtVUNjcEk5K0xJUlJCdDdGa1k5ZVFyZWJ4YVZ0?=
 =?utf-8?B?UERsZzJrYnhWemRRSE1CSVBvc2thZTQwbXRmNHUrMHlYMnpiR21LQWczOVIy?=
 =?utf-8?Q?B5uwzLdwg2koctovMg=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(7416005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cGduY2RmcEZRMXV5YmRhWWVBWkt5KzFFd1BGTjhBcmZOWHFOenhZRVozOWxh?=
 =?utf-8?B?N2c3NHRVaVV0ZTVpTytibU5uaVFtdHFsajBZU3BMQ0pabS9CaWk1NGdXZENY?=
 =?utf-8?B?ZmhBTkRTU3lRQ0luQmV4aG5mVjEyN0JwNkV0REpZM2lOU0VyVS93alRsWDlD?=
 =?utf-8?B?WnJ5RnZyTWNtMjI4ZnhzM0N0TmZGMzFQZFJmaE1qUFdkUy9qT0xhdGRhTGEx?=
 =?utf-8?B?dWRySlFtM0VEcGR0V3ZUQlN5SVhpTU1HWG1rSTl2c2hXVnV0RjNsRXlOSGcz?=
 =?utf-8?B?b1plMjd0S2V5SytYZmxXMEt1Zkx1dWZtTUd0K1d6eUtDOFN3aGFvVk5HdzR3?=
 =?utf-8?B?TlJiRXZkbEFPVEZ6SE1CN0Zrdm1DRlZOYnpsOW90ZWxCWjZjVXhwUEJNTmZV?=
 =?utf-8?B?aWorK1RLdGJpRlhRM3FOMGRaQlNKNEI0K0dtK1lwVUFTNFFJMDhxREpBWDZa?=
 =?utf-8?B?aDNQa2lIcUtkWU93KzlDS21RWHN0V3FXUFNIbFZJQkJvbUdONUFMeTZ4NXVk?=
 =?utf-8?B?MTN5cjh0dytZM3g4VGM2UVJwbFFuUlVDVFlRWXBkQ2Jtd3BOZnMrbG1GcmVw?=
 =?utf-8?B?RGo5MTVLRE9ONmRXZS93cm5HNTh2cC95c0hQRDVSNjhaSW5wclJqeVpxOUV4?=
 =?utf-8?B?ZG1NWHg0cjNtVWpMaVBNMDNFU0JZcFFEdFdUTjlWbllabVFmRC9IWGlPeEhq?=
 =?utf-8?B?dU5LNHhIWDBza1JOQXA3Vi92Si9maHRDbUFDc2VkU1pWNmFzU1Zhd09rb1Fs?=
 =?utf-8?B?TFkwR3Z0SHpTbk9kTzVBUlVsYVBmZUM4N2pvbHFjLzhTZ2ZneWgybkNWVC9R?=
 =?utf-8?B?YXFFOU51S05kV24rN2lnbUtkTHRld0dVQ25HWndwUWNyeDJTalNuc2U5VE14?=
 =?utf-8?B?R25aWExUWHMzREpCYy83SkUrT2crR1dKa3Q1VDFRaVFPV0tCeWQyOHROMW5W?=
 =?utf-8?B?ckRVOFZkWG80VXRFL1RXVW9kQTJKMTU4MnY1VG9PZ1Q5alhVMGZuUGpNRmQ1?=
 =?utf-8?B?QmdwZFhjMms0MU9uNXg0WUY5R2p2bUhxV3RsSXFtNVZNZjhvdGw1dENVRUhj?=
 =?utf-8?B?ZGw1azYvZldCVG9sZG5yUS9HZ2hseEMvaEpxc0xyaEZTSG9vSzEvbmFsdTNV?=
 =?utf-8?B?Y2Q2UW9kd0djdHhhWjd3bFE1R0Z1c3Fva05YRHpCYlJ1dXJDMWF3TEJJRHJm?=
 =?utf-8?B?bGdCdWFsTDhaaEkyUzNpQ0xWSE9zWUpkNUx0NVhRMkpnQVJXYUtvTVgySU5E?=
 =?utf-8?B?ODdEOGZLSnZHQVA3NWxVQ0pjU0dQVmxPY3hkQWI0ME1DVlNXTTRVNklneWM1?=
 =?utf-8?B?czBsQTVJdXlWdlBIRThTbGZZbWJ5WEkzSjVTYXZJbVRhcW03NzF6aXlPRkFW?=
 =?utf-8?B?YkRyY2tlNVBtTUs2Q2IwbHhyYzVrdDlOc3ZxOTRqNHBtSDRzUXZPcGpqVWpS?=
 =?utf-8?B?clphcDZ0UzBoZDF3eHJ5bzVjL3dtTXB2Unh2bWpFWWlQakZtWDF2MWNKRkFE?=
 =?utf-8?B?UTc3dmVvdDZUbmZlVmtXWWFOSHM0N0lISWJVcm05ZGs3UGRLVVJtNitsQWNu?=
 =?utf-8?B?TCtNb2JKSmh1ak54VTA4d3V4WlFGaEU3R3ZnMHFCbFpxcWNqTmxFMk5sRnUv?=
 =?utf-8?B?QmdqRVJycEY4YmUrbXZrYytQa05ZY1FvVE83cFN4eERCd293bXdCeHlISU96?=
 =?utf-8?B?SGdKQlBCSWdjK1dERFFmUXNETUI1UWs5WE5waEJ0SjZvd3ZkRGVhZE44RGRH?=
 =?utf-8?B?QmVQQ2ErRm1XcDQxTnJESmFmSWJyRDQ3MGVGd2pFeVhTZVRKd1RNaW9iZnhi?=
 =?utf-8?B?OUxpU0ZhWUswYXJVMVF5cEEzNEYvWXhYdHNFL1duWlUwa0ZwNnhDRHJjTXM0?=
 =?utf-8?B?ZENYcUI2Nk9YVnZSVTk1cFh3VnpzallFVFhSOTAwL3pESUtZSUVnZ2QzM2lR?=
 =?utf-8?B?MWlKVmRhVld5Wk9MUFJ0c0tia1FlTXlVaEtjZ1E3Y2lQcDNPY3g1eGZKd2Nw?=
 =?utf-8?B?c3M2Z3hsZzBkR2tOcVVlbm9OT29EcU03TkJ3MTRrdDgyOTI5ZnZ1KzdMQUU1?=
 =?utf-8?B?cTRKcFUySlE0VHVLR2h0UFZEd2ZjdFNBenpLM1R5OHN4Mi9Xc3p2MEJrc1hG?=
 =?utf-8?B?eU9HKzNJRi9LNWp4bVJSeEliMUNOVXlGQ3RSUjZlczNIdU5VKzF6bFBZdkd2?=
 =?utf-8?B?ZXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c989dd9c-3a0b-4fff-9172-08dc703b0b44
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2024 15:16:47.6991
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gEoQ7w6ldGW3gN3BHtAq/IX6946AdSrlrcYNz1wzj5WmqXqvUtj5gRrezFNj48fSfvh/twgOZxt9XPQyQ0NzYUCbQMMVWlWCUzgdLuMt5Qk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6181
X-OriginatorOrg: intel.com

From: Steven Price <steven.price@arm.com>
Date: Thu, 9 May 2024 16:11:26 +0100

> On 09/05/2024 15:46, Alexander Lobakin wrote:
>> There are several reports that the DMA sync shortcut broke non-coherent
>> devices.
>> dev->dma_need_sync is false after the &device allocation and if a driver
>> didn't call dma_set_mask*(), it will still be false even if the device
>> is not DMA-coherent and thus needs synchronizing. Due to historical
>> reasons, there's still a lot of drivers not calling it.
>> Invert the boolean, so that the sync will be performed by default and
>> the shortcut will be enabled only when calling dma_set_mask*().
>>
>> Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
>> Closes: https://lore.kernel.org/lkml/46160534-5003-4809-a408-6b3a3f4921e9@samsung.com
>> Reported-by: Steven Price <steven.price@arm.com>
>> Closes: https://lore.kernel.org/lkml/010686f5-3049-46a1-8230-7752a1b433ff@arm.com
>> Fixes: 32ba8b823252 ("dma: avoid redundant calls for sync operations")
>> Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
> 
> Tested-by: Steven Price <steven.price@arm.com>

Thank!

> 
> Thanks for the quick fix.
> 
> Note that the fixes hash (32ba8b823252) is not the one in linux-next -
> that's f406c8e4b770. If the branch is getting rebased then no problem, I
> just thought I should point that out.

Oh crap, it really should be f406. Wrong tree again >_<

Chris, would you fix it when applying or I should resend?

> 
> Thanks,
> Steve

Thanks,
Olek

