Return-Path: <bpf+bounces-70583-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 991E4BC4259
	for <lists+bpf@lfdr.de>; Wed, 08 Oct 2025 11:22:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D4243B2532
	for <lists+bpf@lfdr.de>; Wed,  8 Oct 2025 09:22:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75E912F547E;
	Wed,  8 Oct 2025 09:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aOY4VpLb"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 967332F532B;
	Wed,  8 Oct 2025 09:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759915366; cv=fail; b=C6qxDsAH01zl2ZDE81UE8XIMmdwnHGMrKHSeQxnzK7VxCmiWXxTi45NoScX2Zp6OhpTj35d8Juv1Earq9cHN0MdlZAhvmpxYSuxjeoA4WhaO0dbD1ebOw915ueXwFo8P25FFRwv2UkBBu2xhGdsov29iB17VB3oImkUmwP/gkks=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759915366; c=relaxed/simple;
	bh=9JQMXqy7GFTo6AZwOQ8V0OSx0wKlTHmQpnFkx/tGeUs=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Uxmv3N6KoaS+0Z3gtkhUeO2TjsYPVtsrMhhcGcmFDEZ5z3nzqFZEqR4PlZUtLJkjDniWYR5U87L940DtjhYih/geCJIwHUeQJJx8AclImfl3ymAB5E0b8oyeRC24ds5cs6xtBe+IiKIFd1cT3TFovRgqK1MU4vKZSvWK1xC9QSU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aOY4VpLb; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759915363; x=1791451363;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=9JQMXqy7GFTo6AZwOQ8V0OSx0wKlTHmQpnFkx/tGeUs=;
  b=aOY4VpLblPpMOQesgKbVG+L1Dpuo+vdMrqsR5EXODBfPvx4MlHGHNb4b
   vRA5SFVPtEqLxfVYySXanrxA4+QjBb89LUr98PQzElFSVmVwr0fj5bYRW
   FDfAuEMXeF/ulWHR3EzpIOmWDOb32eS2OHrfD9QMNbV80BEj2HEIVlix6
   3O2u+oP5BxOU3GlRY+l/v94ywyzfY4hR/OFXCR/E+y7tFWMnBK8Ily9US
   iXcgphKPxJsb8NrIElHObKHb2Ozq7dLOFE0cbVEZ6vr/cdnooq5+zfXE/
   40aGX7RDDngI0u6RMwgSXmZYhl59cjF15TRNBmznBZ7ty11ts7m5OGuNW
   A==;
X-CSE-ConnectionGUID: X+KrMBMFRu69h9ugjn5+Ew==
X-CSE-MsgGUID: f4K0eJStTDGFE9cQkoD7+g==
X-IronPort-AV: E=McAfee;i="6800,10657,11575"; a="79539725"
X-IronPort-AV: E=Sophos;i="6.18,323,1751266800"; 
   d="scan'208";a="79539725"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2025 02:22:43 -0700
X-CSE-ConnectionGUID: M7Mpp2QrT5uLKuvtxXza1w==
X-CSE-MsgGUID: HS62H+twTymcnPrM0Jto8A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,323,1751266800"; 
   d="scan'208";a="180218933"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2025 02:22:44 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 8 Oct 2025 02:22:42 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Wed, 8 Oct 2025 02:22:42 -0700
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.16) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 8 Oct 2025 02:22:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Rqw52414S/dvBbS+jIh+jQF4Fu06EQZh76cnZotytVLlzdg7hJVO8DSSiE5SnYXBRKIxi+/ibOHfOkUVN897CGFK+o/em6u2kYXWraQaZnmZkmTBOH87/gMgK+35FREhtp+fPlnX9DpzsuqXkch6sTieuaxwV9HZY0Uz8hSotQYtXytdLM6NO5qTqfm8xIkqNVeTCe7UzzxArLty6c8U3OZzeH1HdZJ5my+u8dNQuzgVS0yu9Zvu+ij2oUll0dXqkg6Lf2CgvlASg6yyvDIyLVwoaUrIg3r6ex8b+iXASib+idZrlPSq0Ve8Y5lCXyEg+7VfSbwN2u/4kke7OIQo2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5PaN4sPp2mMkexbfktjQbGyYWcamjTXRzfjGImQPyuY=;
 b=H/jT1azwyPiQ9voYZ37S9+X9twpZOeZAkhN/2ljd+Dnr11j6DgsOiAOsk19v/tUvs/ay87uOk2E+zv6pwcFZ8YWtNJNhvdzgX4OKeqPtIrqgzG1XKbecp9aVucSSKryCGWEyuNGr8wWmDFL+XfyNvwaaxaDhiqXtWVWBvEsaUsNa1NwiWN8LRvFW5qkJaHaJt3roZQHwuc9OKYtvPFuAbEo9vpAg4p41+77twy808BVnVRsPEaEN+f/c8zCobtRgCCkrXQmtN0kaJIi0SWQZQ99/L9phOdtDJn4jc8j2P7cqFsGD5UZJ12l75DttMwWzJCLDIrMdIVDnTMs/ghxQLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 SN7PR11MB7590.namprd11.prod.outlook.com (2603:10b6:806:348::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Wed, 8 Oct
 2025 09:22:39 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca%4]) with mapi id 15.20.9203.007; Wed, 8 Oct 2025
 09:22:39 +0000
Date: Wed, 8 Oct 2025 11:22:26 +0200
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
	<hawk@kernel.org>, <ilias.apalodimas@linaro.org>, <toke@redhat.com>,
	<lorenzo@kernel.org>, <netdev@vger.kernel.org>, <magnus.karlsson@intel.com>,
	<andrii@kernel.org>, <stfomichev@gmail.com>, <aleksander.lobakin@intel.com>
Subject: Re: [PATCH bpf 2/2] veth: update mem type in xdp_buff
Message-ID: <aOYtUmUiplUpj2Pj@boxer>
References: <20251003140243.2534865-1-maciej.fijalkowski@intel.com>
 <20251003140243.2534865-3-maciej.fijalkowski@intel.com>
 <20251003161026.5190fcd2@kernel.org>
 <aOUqyXZvmxjhJnEe@boxer>
 <20251007181153.5bfa78f8@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251007181153.5bfa78f8@kernel.org>
X-ClientProxiedBy: TL0P290CA0015.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:5::7)
 To DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|SN7PR11MB7590:EE_
X-MS-Office365-Filtering-Correlation-Id: 3956280b-4632-4370-81b7-08de064c3a03
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NS9mRWlTRC9wSzlRWVZmQnZDMGVTYkpQekU5cEpsL0ZZUUxVTlZGY1VnaFhY?=
 =?utf-8?B?T0FsVVIwVDg5ZE1jTHR5Y3daRFJlTHhFYUxlaUt2UjcrZlZLY2tTWDhnLzZJ?=
 =?utf-8?B?UFRraC95Unp0YXBRVlJlT1crbTZLWUNueGFCeGg4SDczQTV4QjNFRURhN2V0?=
 =?utf-8?B?QWpDUGZ0bDc5N3BwanBneEVEbTVGSHUxc0tndlBMSURIYkpKYjVxKzFEQWpL?=
 =?utf-8?B?TVNrRW43LytPa3J4WWQ1Nm0rZ1dnSmk3bnAwZ1dJcHcyZmx6b2M4MnFIQk12?=
 =?utf-8?B?KzFFN0EwUjd3czJIdS9ibGVvZ1FvN0l2bzFYQjZKWC9nNmZzZjFDbDQ5NzRI?=
 =?utf-8?B?eURxZlBjOWw1dlpNcXB0aGpETkViU093OUxsL082T1U3WlE3T1B6WGtKUUwr?=
 =?utf-8?B?dnF3N2N3cGxFMFhuTWtRNFk4VzVFclhuVmRrNWppd3J5czBRUnJIUkhkRWdC?=
 =?utf-8?B?WG5RblVjS0JQYmVJZXNiTWJqb1pmR1RCTWJUTE5ZZVdpZC9EeTkwb0kwQWUr?=
 =?utf-8?B?K0lEblE1YnIxeUZPSm1OZGM0Qjd2b1RDMVkzcytKUnFlTCtZMUJCNUVGd1NW?=
 =?utf-8?B?dzc1WSt1VEdzZ0ZNMDV4bys2MkdGZGoyTEs1eXVpOFRaQWZZVXNUVnQ5MFc1?=
 =?utf-8?B?TzAwU2lzbTBpRzNKMGtlUjFnTXRENDYyUm9kQ1BiaFo2OHhEcS9OZXFSYVRo?=
 =?utf-8?B?WHhHaFBLZlJyYW5rSmZoSS83djU5MWJZMlQ0aVBvZFFVZVlPa0ZsemY3ZkRw?=
 =?utf-8?B?bmxNcVp3V3NETytyd0NXSDNveHdxZEFqb0x3RVVxbHZMbXFyZkxoWTJRZUVm?=
 =?utf-8?B?NlY2dTVFU2VqZ3MwSDNJcVRzUC9nSmpJZGR0eUx1OU5vbURDVnYyTXl6NmY5?=
 =?utf-8?B?WmVHTHByUDJLN1A2R0J3V3JBRzFMNmZtY0RMQVZ6aVZvY0lKVDQ5Yy93eVpK?=
 =?utf-8?B?TE5TTFhkV3ZaUno5My9MbXQzT2hJc25pRmppOWpvQS82LytLV0lETklVSktz?=
 =?utf-8?B?aDR1U2VMWDM3WDQ4YlBUZ0NxTDg1aVR1aWYwV1N6R2FVdmpNZndVNVBaQysv?=
 =?utf-8?B?YndEaE9lYm43RVA3K01GZzhOTjJnWGFTTTVabHp1cmJUcmw0M1ltL0FKRWFY?=
 =?utf-8?B?Q2dWNVhGUnlMQWZEck9WMVFudzIzTjNGRFhoaWVlMDBmaXhzQzkzQ2RKR1Vr?=
 =?utf-8?B?N2VUZ3kreUhVOWlsbFd6UHU5bHFQdFEvNnFFelBmSDhRaFpFT2UzdFlqdHpX?=
 =?utf-8?B?dzJWY3ZCQ2FTa0pIeEo1QVdOeldWQVNPTmxuUGVURmpKSnJ1bldOejA3TEgy?=
 =?utf-8?B?Z2xFemRhaDREVmxtTTc5Q0tWZ0FZcDJCSjFuc0pKcFNWV2IzdVJ3TVZkZEpz?=
 =?utf-8?B?RG85eXM3NWExVFpMVE8veldkdXpPTnB0SnhKdndJYXI2UXNNV3VlS1c2TG5R?=
 =?utf-8?B?eXNjQk5JSXlnZU5NYWhaUmQvSDY5QnhOR0RLeno2clJjZXJJRGIzVGp4Z3BF?=
 =?utf-8?B?Mjd0alBZcVIzSE51NEY4RUN6MEgrdWZBVFAwSnV1TUd2VUtXOWd2UEpSSEJ0?=
 =?utf-8?B?L1JLdDFrdnNVaDl4VndEOTM2MnNNb1BOSUw1M2RXd1VNNWYwSWtZZ1QxZStn?=
 =?utf-8?B?bWxxTU9ZVGhQanNUUGl5UThaUkM2aGZyOXpSMnRQclBxR2tLNTU2REd6eUk2?=
 =?utf-8?B?SmlFaDJyUjF3MGhJTXo0alBIeUErOHRvVGE2d05RNXNsQ3AyTW5acVBTS1Fv?=
 =?utf-8?B?V0VXRldaanQ2aDFYeTZIVEhOd0tidEpTa080endjL2dsdVdnSXlpSStITksv?=
 =?utf-8?B?ajBZRW9LMWRQSFA2SlVtMlc1YmN4ZmtzajBpb0x5SldMbTB1Sm96NU9ISE5P?=
 =?utf-8?B?MEVSb0RXYUx6UjhQVzVMdDYrV1grc2l4N2hGaGdSTE9wdVhJVlRDeW9KSkxE?=
 =?utf-8?Q?Y5pSD2YrfrZ2zSmOmqBF4ysj5PlPbB+g?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c0ZxeWFxVGFHSHJzb1VwNk9lbEsvbzNLZkpRZFpMOUVlQUU5U1hqMlN4MUZC?=
 =?utf-8?B?cWFlcTZ6M3l1UW81Uyt2Z3NvNWtxaEdOR2RvY0NOdWp6V3I4bmlBSWhIYTV4?=
 =?utf-8?B?aXYyZjU4OU8veEs5Y1FYd2pRaUI5d3AydGRpUUdHY3BiT0dsMTZDOVhTU2Qv?=
 =?utf-8?B?UnI0elZaNlQ1dGw3L0lDcmxOaUhSRXl2c1Y1akxmL0p1QkFhczFRQkhJbTlq?=
 =?utf-8?B?eHAwYkVIeEZLcnB1bEJwNnQxWEUvcDd5bEx6ZWxJTElmY01FcVlXMHVsSTZF?=
 =?utf-8?B?NmIvOExiSDhyZTRFV253Uys5enFRZUdCbjE3UDdibU82S08vUFZLcnhydTB5?=
 =?utf-8?B?M29haWYwbUhUeTR4d3U4ZERIT3NVUW1lc3JYMkE5dDhzZWJ3c1ZPYnd2Tlhx?=
 =?utf-8?B?Nk95K2NoT2lsNThzY3V0aW1VWG9NNnBxSTVRWnhzQlVXZTNvQktvTjF2MkFx?=
 =?utf-8?B?anF5MHB5MngyV1RWTittaFhtNEJDeFZZV2t2WG1vVll4ZWVZam5XVkVmSEpo?=
 =?utf-8?B?dnRwTEJjSU8zUmtYOEZ5TzBtem94QUd3bFcvVFFSQk5rUG0zMThpby9OdzFy?=
 =?utf-8?B?RXZIbElxVGdQa2ZUaEo4VTc3STZNOFlaSXFDZzJTL2YzbkJtbXhxZGNKS2Nu?=
 =?utf-8?B?T2RhWVhIZ1ZBK29xcHV6TEZ6VUprL1c2T1lYYnU5TXNoVklpcnV4YXJRbkMv?=
 =?utf-8?B?WFNlRW85c3hndUkweXIrUkFFRkl3U2lPT0pwQUUwODZKTm16OFBZeDNsckgw?=
 =?utf-8?B?VmhuS1lVazlhUWEwYlh4d2ZZSDRDVDl3MXRqNG80Y3Z4YmZoN1g0QkNWTXdy?=
 =?utf-8?B?Ym1YRFhhL1AyMWFGOTRKOWcvQk1EbnFKN3l5YnEraUdrTnh6dnQ4aHVZUDZF?=
 =?utf-8?B?SlFya29KWnFaenBhQ0Q5K3ZSRXQ5TnRCbU9lTHkzRVZ5TzhmVnhUMEFUN2gx?=
 =?utf-8?B?QURIRis2Q0Z4cURZSjcvN05IK3hJMWZoWXlZMzI3Slh1SWtBOFVxZGYxbUtI?=
 =?utf-8?B?aVhWSWJibjlMZCtXdy95MXFReGllcmhXTWgxQkhwR0NYaTRiYndaZXE5bGNY?=
 =?utf-8?B?Vm4xMUNqbjlHY1BRTjVnSG5kZFVQRUVGT1hnWlkwejBxTFdMSHQxdUt2STFL?=
 =?utf-8?B?QkEvS25qMzNSK3pSSVlkU3owYWdhRkNIa0ZLZUVDMDZnc0FPbWxIbTZNa0pE?=
 =?utf-8?B?bUlHUk9QUzh2cVE1QjZpcVd2SzAyTkN4bUozR0RDYkEyVkYwSmxJVVRsZ290?=
 =?utf-8?B?MGFiVkplN2hTVzZnT2l2Nzk5R20xVmZmTEF3QzF0WllUZlpudDg0ZkJOU0lK?=
 =?utf-8?B?RjFpKzlKOW5UK1pRa3JzZ0oxWThINjRaMUVyby9IR3pGRnppT3lWaVhFb3JR?=
 =?utf-8?B?UzNuYlRNQmk3T3ZEMzZMUmFzWmVKMVNNT09FQVhLSk1DK1ZlM0lQbTgwOUtX?=
 =?utf-8?B?TVVkaHdhQkJjUnNsbG05cW90VkU5dVpYNThlNnZZT1BYbjRnSXg2Kzl4M2Za?=
 =?utf-8?B?a0VZdjFZMlpnaUhDeFpHbGJLSDdPdUtHOUF5UGdUVGxWV1lLTU5zd0x6SXhB?=
 =?utf-8?B?WFlWeEZqZGx3anBFZGx6bFRxNzNjT1BKUlhVODZmM0hQVnM3RWpSeVlFSlpF?=
 =?utf-8?B?U2F2Qy9odm5TM1dveDhvMzVvMUloNDQwQVNMNVlKMHdOQ1VOQUNTWG9TalJM?=
 =?utf-8?B?anF5MytWanhnL1hUQ3NGVm14Z3laOTVNL1NqRS9NbjVibU1wekJjUGtTZWZ4?=
 =?utf-8?B?dDdBMC9qOWsxYlgzU3kxZC9hM1l0YnExeUdVNzV2Sk91eWVXdXhkbktLOEFj?=
 =?utf-8?B?KzBmcUhiSDc5dU1XN00yMmEyTUNFU3EvSnlBdHEyTHRNaGZ0dUdUM0FkeExX?=
 =?utf-8?B?c2Yya2s3eDRRY3FHaDhLNnBtNWk0UlkyN1lUVkNucklyekFZbGFxVG4rMDlv?=
 =?utf-8?B?eURUQmFiTGJsL1FySU14V2RBQmMrbDRZUU4rMHN4YTVEUHRhdEl2ZmxxMUIr?=
 =?utf-8?B?Q0hMVkJXZE9QTHRqS3V2SlVDMlRUazJaMlVwZkdNOXZ3UkphdVhHYVFrOUdN?=
 =?utf-8?B?M0xpakIwT244Mm9UeW9Rb1VWd3VqWHVTbHpsMllDYU5oTytqaDVOcGZiR05E?=
 =?utf-8?B?WUg4SEJDUjNScDFaWDlyMXU3NHZsd0R4V2EydlVjNTZmSXgxa29LVzl3V0lP?=
 =?utf-8?B?a0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3956280b-4632-4370-81b7-08de064c3a03
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2025 09:22:39.5614
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FnTNfc0OozwKrJJBN/p7Pd2yYqCjQwSybZR41Zfb2BnHOoac7bSDzJGzK3Ifhl7tif5hP5X4CXBv2qnhu11DpVkU/xwBBF9z5ulEBN7k+yo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7590
X-OriginatorOrg: intel.com

On Tue, Oct 07, 2025 at 06:11:53PM -0700, Jakub Kicinski wrote:
> On Tue, 7 Oct 2025 16:59:21 +0200 Maciej Fijalkowski wrote:
> > > My thinking was that we should try to bake the rxq into "conversion"
> > > APIs, draft diff below, very much unfinished and I'm probably missing
> > > some cases but hopefully gets the point across:  
> > 
> > That is not related IMHO. The bugs being fixed have existing rxqs. It's
> > just the mem type that needs to be correctly set per packet.
> > 
> > Plus we do *not* convert frame to buff here which was your initial (on
> > point) comment WRT onstack rxqs. Traffic comes as skbs from peer's
> > ndo_start_xmit(). What you're referring to is when source is xdp_frame (in
> > veth case this is when ndo_xdp_xmit or XDP_TX is used).
> 
> I guess we're slipping into a philosophical discussion but I'd say 
> that the problem is that rxq stores part of what is de facto xdp buff
> state. It is evacuated into the xdp frame when frame is constructed,
> as packet is detached from driver context. We need to reconstitute it
> when we convert frame (skb, or anything else) back info an xdp buff.

So let us have mem type per xdp_buff then. Feels clunky anyways to change
it on whole rxq on xdp_buff basis. Maybe then everyone will be happy?

> 
> xdp_convert_buff_to_frame() and xdp_convert_frame_to_buff() should be
> a mirror image of each other, to put it more concisely.
> 
> > However the problem pointed out by AI (!) is something we should fix as
> > for XDP_{TX,REDIRECT} xdp_rxq_info is overwritten and mem type update is
> > lost.
> 
> > > +/* Initialize an xdp_buff from an skb.
> > > + *
> > > + * Note: if skb has frags skb_cow_data_for_xdp() must be called first,
> > > + * or caller must otherwise guarantee that the frags come from a page pool
> > > + */
> > > +static inline
> > > +void xdp_convert_skb_to_buff(const struct xdp_frame *frame,
> > > +			     struct xdp_buff *xdp, struct xdp_rxq_info *rxq)  
> > 
> > I would expect to get skb as an input here
> 
> Joł. Don't nit pick my draft diff :D It's not meant as a working patch.

Polish sneaked in so this got really under your skin :D

> 

