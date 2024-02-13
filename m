Return-Path: <bpf+bounces-21837-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 62186852DA6
	for <lists+bpf@lfdr.de>; Tue, 13 Feb 2024 11:15:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8683A1C21917
	for <lists+bpf@lfdr.de>; Tue, 13 Feb 2024 10:15:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C42EE22611;
	Tue, 13 Feb 2024 10:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bnbbbIdz"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CE5B224FA;
	Tue, 13 Feb 2024 10:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707819346; cv=fail; b=qKqHMX3SGczjAFtPqxt3260zOmBgbPKT5HhMU+EMqJ4KFiHn3B5OoEi/s/nSU5g1HObnhT+8x4PUC1l0qzR5vMfFOT98luf7KC3dZffdfakWHjDpT/FLZLErfT2Tk/Ncj/kX5hTr4aMMaHhQsfS87+JNxqStRC2zhuAVOm/OZZQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707819346; c=relaxed/simple;
	bh=nXlW3nUNkYQnltcmVlb6R43Irtz0s3ieTEOQvaUVh2I=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=U/+cPdr78amJSxu8Qb3KLghpFFPlMB2kNkD/gehwed23CgHTvA4Tzgwa9H6jwg2SBDQDaK1mmhka7/MkFrdFiYG/ccGMtuwlan+KwqAMqQBICa6O82Ic+j78ftgyfsabWjlDt0tI83OAhnpVCDl1vYYG+xPsx0ZK0wzcwDpIaXE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bnbbbIdz; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707819344; x=1739355344;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=nXlW3nUNkYQnltcmVlb6R43Irtz0s3ieTEOQvaUVh2I=;
  b=bnbbbIdz5V53Wbm+lHy0kt15aTzlwZYdrQN4vGCqlE/jJ4ZJEHgFH9VM
   iFSU74lyT0EabvaT4CYwnFzYjzEKjKui9PchwRLE5ontPB9LaFGy8i3L5
   1B0R6e5LEO3SsOS+WDxB/e7KRDjsJJdlYaV6G/nVVHN3BXzWLNNbBzRUR
   FoIjvMCO98ZKSHliaWo+ZMHYKQy1TiicKoVGr5vn84YAN4CvJ9PFCahLv
   xAzbpKggL6G7O+es+9SKWGnJ84tRNS8vLQHrwDFDFE9XneFq/W53FI07N
   VjOQKI+2r+ebB70SZrT3ipy6/elajEDCLVu7qAEsW/lUiDhzxt3T39zFR
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10982"; a="1694933"
X-IronPort-AV: E=Sophos;i="6.06,156,1705392000"; 
   d="scan'208";a="1694933"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2024 02:15:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,156,1705392000"; 
   d="scan'208";a="3147862"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Feb 2024 02:15:43 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 13 Feb 2024 02:15:42 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 13 Feb 2024 02:15:42 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 13 Feb 2024 02:15:42 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 13 Feb 2024 02:15:42 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Uf2LbRKu2IgwJkwlDY1O6hXCDBrW6BvC67wsSsU/bCT8ng17CwLIpcJdSYIUCk05CzLCgnqcmAeVSsdps4OAX5mfCQBzSC+HnrFTw2EY+QDeRbSSNkxs4AGMpgqsDAyxSOETqXyL6xx86ZmBtdXLwAeKqCEP33C1o8CyPtOtlMPGriHY+iKifAuRrb9g4gWpoGmELs8yjq/hDY7VShC6J1gyHzofKcqLA+lss3UzKHmNusmKOhPpgMH+YyVpyNqz3Ect0hIQOUjorlOfjMoc3ItU1wPr2osFfjb4UBBLmTtlqdA+Svlu4MzdODr26EK0/HG/pHopmV+Wxm63hJ1cSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zi83BdbVVEq52NGxDYkP24TLlKFjJb6hTnEl/zhjyyU=;
 b=R9J/K/TSc9jlepJJe8+kikyPNRmGqcHzpXQJi+vfPmP9bRE8OdzCngh0OHZHMmfJ37CA3m0GzuOZ2s31IBy+o4VhoX7rDt5o9cG84M4/AhRxWMDUKTLg6KsX9zaLiScTpYS1ze3O1VpI9fGgsqqJdKSUygjhc2XoTdGVXbEqHPI6+AtwDjV45UFfNpYhuHf2T7KyNhMcVmoouI2PpiBiI+uNZO890OGtbUpQr5UYJYsOEasusHeOp1pYAungWQ360dASgiRlqqgQxH0YBqkYy0+JY6lQjwGZdP7XxEM0xIHuLgg3m6twF8M1H5Yp80ds77Uaz3xBEyqI0KTfhwCrgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by BL1PR11MB5319.namprd11.prod.outlook.com (2603:10b6:208:31b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.38; Tue, 13 Feb
 2024 10:15:40 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::c806:4ac2:939:3f6]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::c806:4ac2:939:3f6%6]) with mapi id 15.20.7270.036; Tue, 13 Feb 2024
 10:15:40 +0000
Message-ID: <b361fa3e-d880-4755-96e0-ada89613edef@intel.com>
Date: Tue, 13 Feb 2024 11:14:29 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 1/7] dma: compile-out DMA sync op calls when
 not used
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>
CC: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Marek Szyprowski <m.szyprowski@samsung.com>, "Robin
 Murphy" <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>, Will Deacon
	<will@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael
 J. Wysocki" <rafael@kernel.org>, Magnus Karlsson <magnus.karlsson@intel.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>, Alexander Duyck
	<alexanderduyck@fb.com>, <bpf@vger.kernel.org>, <netdev@vger.kernel.org>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>
References: <20240205110426.764393-1-aleksander.lobakin@intel.com>
 <20240205110426.764393-2-aleksander.lobakin@intel.com>
 <20240213055707.GB22451@lst.de>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
In-Reply-To: <20240213055707.GB22451@lst.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0035.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1c::8) To LV8PR11MB8722.namprd11.prod.outlook.com
 (2603:10b6:408:207::12)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|BL1PR11MB5319:EE_
X-MS-Office365-Filtering-Correlation-Id: b06418fb-0a02-421e-0b21-08dc2c7cba63
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yYS4sZ9tnb+5D4Bs/z5FHNBZ2HGNN59PvXKwb/HRKjDTviqQ2lqu2nAVvzGFsD3JsojzCdeRyaJK9eJVzgYdUGEvPmsF4IoYSIkKJZtbnRqJaufm/ZUkpqH4QNsPqaFTb3oNAYRzB0h4jIENzbqYAuWM+uEOAvJ9FQnhajOy8SFsFHi0AuJJ13uDRpZPsbepuAnUQWirIfhbkooS7v4d3KYomNNwb0A3F6Ln3W6cL8SrH14sVu8m8xr8eJV7oQJkTHn/vrgMCScKsMAjRlAJRMnOyGumdhmkPCyW1+OB6yd9FYC2TZzUL8YT5M00RWJTWPSshID3XMP8D+U7WA1SOm0i9f1j9BLufJyUmhH50dDyBZtnWbJWV/XxhI3JK9qemQ8dr2GO5Ibur81pHkUpUj2nUqVHVrLz+p7hY9sTrvBI5o0ai0bhgvSHzxKFeC67+QYu+wHhem/Ok4n3JhKISUQgfjMviNswGPtlg7leeAAgyTfE/Ftz6ggOZSYbVquuxpwXKl5jmJ7s1pjN+/Ny1w21UsTeqxc/TPdtaSOhSD9SPPDUH2C1k6OAA+FUm/PA
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(376002)(396003)(136003)(366004)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(2906002)(31686004)(7416002)(4744005)(478600001)(66476007)(8936002)(6512007)(6486002)(8676002)(6916009)(4326008)(6506007)(66556008)(66946007)(5660300002)(26005)(36756003)(2616005)(41300700001)(54906003)(6666004)(316002)(38100700002)(82960400001)(86362001)(31696002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R1o0TXF4L3JlaG5lNFl1S1c0cmNSbzhmVlNoVFlHb2NVRk9XYkcxVHJXUGpR?=
 =?utf-8?B?UHJzVUtpeFpsbUJjeEJQQzIxR05heXhBNndvS1lGeTcyaFZzVmhjYnhOT3c0?=
 =?utf-8?B?enphN0wybVd2bXVGZnk2Qkd2akNCMnBqZ1RjOW1QZHRiQVhNem05QUt6WHBV?=
 =?utf-8?B?YkdEQ1dJQk1YaEg0M2ZWSUtmR1ZDV0RLUkgyNlpxbjY1Q2hGSHFvUzV2ck5x?=
 =?utf-8?B?UWkreTE1bHdzWXRiSmpmYWZpTDVJU2QrdWhselRsd0R0N2VhNSswNC94Q1Vq?=
 =?utf-8?B?U2E0YXFzTjFKUWJaR3ZwdzBHaEhwWkFvT2U2ZEN1aFA2cWNYWUpwa1hpVmxa?=
 =?utf-8?B?VloydTEzcTRUZmY3TXFVS0hvWHJ1OEFzOVp0K1RudWxJWkpRNERTR3o1ZjU2?=
 =?utf-8?B?bDFQcXZxU24wU21JYjJkK0x0eGp4WVNGNHJCK3VYUngvcTU3MDRPMXp2bVJR?=
 =?utf-8?B?djIvSHZwMHk3YUtqQzYyRG5FaFk3a1djY0I1STJobEVTcW9weHg0NHlaYzNz?=
 =?utf-8?B?MTQ0VkM0ZWNDZDQwNk9GL1lQSnRDWVl4K1FsR3BOdWlWSUJUUWdUVFVsRWQ5?=
 =?utf-8?B?OEFid04rWVdSL0N6aDFMS21OVGFkcjNkVWZQdDdVU1RUV3pzTDc5Z2JXYkFu?=
 =?utf-8?B?TTRyMEtmVXc4SGVKT1h1ekZPZ1BuNGg3RlkyajZicWJsdEJGZXhFZkEvSUJW?=
 =?utf-8?B?NTdsSUtSL1EydktYcTRwbnF1VG8zcFBuaHVsVWJoQ3Z4QXBNNWpIczV1Mmhj?=
 =?utf-8?B?cmUvb2dxa2lZdS92SDZvb2xuY0dKK2dJdmVvTWhNSE5oM3hBK3Y4cjlWV2hX?=
 =?utf-8?B?WStHL1VtWGNtZTJSaXBtd015dVlRdXFtNDAvOFA0c280emhWb01FQXMyYXUy?=
 =?utf-8?B?SEV4Mk1GOEY5ZDhoL2FLSkpJaGVESGFrV0FGWEdvQjhTdnYrWlRUSUM1OFdU?=
 =?utf-8?B?YXcvcVVlWjc1eFN6UkxOdWhVK2ltLzdkTVNUVnlJM3V2WUVMVmZKYS9IVmRV?=
 =?utf-8?B?V3dFYzZqS2x5K0lBU01KbVkyMWZ0blZxdGV4ZDFVYm1sb2hJZzVOUmFPMmpl?=
 =?utf-8?B?eWVCemFWbVdJWWFwK2pVZTc5S1VFcWNVMGg1Q1VTTlV0azErOENsN2FOMU94?=
 =?utf-8?B?Z3hIVkJvZ0hWVE5vUitra2FzcFJMLzNVYXZZZGpWWW5nMjdYNEtJRVpISkNi?=
 =?utf-8?B?ektvZURXSDlyT2loUWZWR2NTanVGTnByWGFVclRtZkZ5by9XNkFtdXY5dVBU?=
 =?utf-8?B?S3h5MHdMKzBoU2owRVl5cmRCT0J4RzdXa3ppQVc1cFdqNzYxeStBYXpPdld2?=
 =?utf-8?B?OHkxMmVtK1NmcllwcDlLOGJSMHJFRWhXTHFCajNETmZFZXR6eWtOdDQ3L3lX?=
 =?utf-8?B?UmF3YXdYa0k0cVZTVFR6TFZPdTFjZzBOVkloTVIxY3I1M28vMHlreFptTlVN?=
 =?utf-8?B?ZXlzVXBMNHlMamZEOWhobmVQZnRqM3NMR0NYWHdiVEN5WFVScnhheXo4L2xM?=
 =?utf-8?B?cC9mSy9reXEvd2hOWW5QZFZ0cUF3WE52b2VBZ3BjMExSTGV6RUxvOVVHVEVC?=
 =?utf-8?B?V1VnWkhnNXZhalIzdXd5WGJTMGdzT3lJY0tKbHJ5cnA3cVZLZ056NFhJRldM?=
 =?utf-8?B?cUJlc3Y2TGtDZ2w4MTlUNGJHT2x5U3pUd0NhbUIxYVJzRlNFLzNKWmpCVHFX?=
 =?utf-8?B?aFRWL3hEZ2QzSWdIZjBhSUpMTEFoUDhBQk9hNWYzamdMeXdIQkpidTVBOEd3?=
 =?utf-8?B?SWxuSE1XTnRkaU1MUGRmRUZNd29aSmlwUDdIYUVCanJXeWFxVERHeG01QmlG?=
 =?utf-8?B?dk5TbFZsV3dxZmVaZzFxVXEvQm5udEJJZmhCQXdXNWFpSjFPalJXVDVValJa?=
 =?utf-8?B?SWhBd1VJeWJqTHZiUWxDNzA2bVI3ZGIxMURWY3B2VENXZ0gzYnhzTVZmU0V3?=
 =?utf-8?B?OVh3NDdBbGVQV1hMQ2FieE9tdjNPdG1zbTVOUk1DQVhFUG9jcmUxaHVTZVUz?=
 =?utf-8?B?MGRYMHhUdTd0VVlobHRuc0k0K3praStvcXVBTjhteHU0REhFb2lsOGZuaFZC?=
 =?utf-8?B?MmpsZHEzZmJKMlV5SWJvdXVENDRkWGpoV2lWNCtxakRsdVhSaEtMWDRHd0k4?=
 =?utf-8?B?VFBJb3oyM2tIN0J4ZVdWUzF1U21XNlVqaUtJMUVjamFTWkNNaWdmNDd2c1RQ?=
 =?utf-8?B?Vnc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b06418fb-0a02-421e-0b21-08dc2c7cba63
X-MS-Exchange-CrossTenant-AuthSource: LV8PR11MB8722.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2024 10:15:40.1478
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YqOp5lfFpMzLYNszsE5O2bDESJAwHQvgpEdVXbRJu2nAjo/+lo3nI6RZmGYYheV4jBRzvajM42mJl4Xsu7uDAiYBddfcjTmgB5qV4RtIcfw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5319
X-OriginatorOrg: intel.com

From: Christoph Hellwig <hch@lst.de>
Date: Tue, 13 Feb 2024 06:57:07 +0100

>> +void __dma_sync_single_for_cpu(struct device *dev, dma_addr_t addr,
>> +			       size_t size, enum dma_data_direction dir);
>> +void __dma_sync_single_for_device(struct device *dev, dma_addr_t addr,
>> +				  size_t size, enum dma_data_direction dir);
>> +void __dma_sync_sg_for_cpu(struct device *dev, struct scatterlist *sg,
>> +			   int nelems, enum dma_data_direction dir);
>> +void __dma_sync_sg_for_device(struct device *dev, struct scatterlist *sg,
>> +			      int nelems, enum dma_data_direction dir);
> 
> Please stick to the two-tab indentation for continuing prototypes.
> The version here is not only much harder to read, but also keeps blowing
> up the diffs for current and future changes.

Oh okay, I didn't know this is the preferred way (differs from the
common one used in the kernel, e.g. in the networking code).

> 
> Otherwise this looks good to me.

Thanks,
Olek

