Return-Path: <bpf+bounces-54819-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54131A732FD
	for <lists+bpf@lfdr.de>; Thu, 27 Mar 2025 14:07:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2C2597A5E52
	for <lists+bpf@lfdr.de>; Thu, 27 Mar 2025 13:06:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1053821517F;
	Thu, 27 Mar 2025 13:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZhnRXNfQ"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E0DA4C6D;
	Thu, 27 Mar 2025 13:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743080845; cv=fail; b=l0cyWIif3Dtnkmyf/5U/kXvE+57+QD/Z7KLvptnbIBy6oBM9A17GNqZ9pLq+xm5RE20X3CKgk/2ekZhDSHI0XKTu4tPAlU+0SODdbBJRwtYnS5qQAnhKpxy9pL8lJG41+y+X0Jilr7S8bjB2FFWlSKhxrsJ81KrWD7sEzjYY4ks=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743080845; c=relaxed/simple;
	bh=GLKMxiRYk8g2lu8uGaZ4Mu6TpM9CPDmrFGaLjOg+Yhw=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=YImsd9meZ6pH4imTQ4MDF65TbOiu2GNGDyEvMwn93pF/lPMnVFoabt2tD7mz4CyHgfbm+JtOSP217Sq3DOTB2SFxyLCz5AZPOOQdCwLuIihnFTtHHM8JLJRujciH8BvP0MrJriI8jiBRTbRJqWlLPYbrU8IrSzINHUTSCYJ+n2Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZhnRXNfQ; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743080843; x=1774616843;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=GLKMxiRYk8g2lu8uGaZ4Mu6TpM9CPDmrFGaLjOg+Yhw=;
  b=ZhnRXNfQx0gfkfeuNMXQo/HRfd7ipmJejXC9GYKfiYZxohlufjH1B1r+
   +RF0uCRTJCjhXLp6d90ytwz5ns+J7iSgiipTCXwXbPzWrDi34lF+VI21+
   1mJbjaMl1bm2Qp0gMTj77a1V7GJGtr4RBuTf/j389CQLBtxY+bEl2WwE0
   YpHLA/2+RzCW8SX3y7MZ0S107X4xGKdHgYBzLOj5TyK0l90slolWQnNlt
   AzeAQiAXzfoh1Fs49ng/VrOcjd41WhG44FkkDcB2GvEYqg1mO1JAt7CkR
   hLyLgqfBfx0ZizaJCU65rA8yERbyNnJWJ02yyB4a1fpidKKPSbKT89M2q
   Q==;
X-CSE-ConnectionGUID: E5U6YR+1TPmPr3cn6Vjqvw==
X-CSE-MsgGUID: SWsOqF7lTlCy53yJsvE9lQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11385"; a="44427222"
X-IronPort-AV: E=Sophos;i="6.14,280,1736841600"; 
   d="scan'208";a="44427222"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2025 06:07:23 -0700
X-CSE-ConnectionGUID: Qe8WVGTkQm2K+7i9+c4glg==
X-CSE-MsgGUID: LsJtXZQgTdmi+Jozsrjc/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,280,1736841600"; 
   d="scan'208";a="125352847"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Mar 2025 06:07:22 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 27 Mar 2025 06:07:21 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 27 Mar 2025 06:07:21 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.40) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 27 Mar 2025 06:07:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WPCa1PmqkVuAhFqeYHWXGgx3OcOCB2fiMVzm4lek6vN5OLw5uNsN4JmnTFsntfD82zUf0XP0M7sDIY+wrnX31dkyEC7Ino+vzv8cU4uKQg8UK5xdH92uw+4ZiYWsk+zv9UsXFtPWEqysKBEzM8aQYPZtR1sUJ807O4X0x8XbpiQX1KPlBhn5C+pctz2kyd2Bzjjs/YbZC7Z3VmhJGt9EEpAPCLPAaiig7StN8k8Mxp8f8pzkLtvbzIsKafjKxnvhXSnZ9zjVzWfFzrzY7rwNOisnvtb9lc0bHLAIXFm2B+8CvRbRqjpBH0xEXvrjEjXQ9asqaIE/8NnSxPev1BrNXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ySGMrn/pLxQ0GsDRJCWG9ZwDOqdrf6hM2kTHDA2apTE=;
 b=lbMv/TJqu3r1nrpIDEE7kyEcngUpZoiAkqjmOxbveHjC0HwT+uztPvIL93V2PMuzxP4UWVwmlqrSyS+SNVwvLN7V0NiFRY8ptE7uPhQTLxbb1uuWKu+CyP9JVZFtR+YbXH3TSvoUeaC7YkoFS9YQF8yfEHrUXRH8YJnHPEQVRB9nqlDbfiSBoICASaNqcQTOo8o7NNVk4h8XSXFRjTULRdWDxlJx8nJXsP42wZS81FbFsdKYJd5OJYKjk35jKfpsAoAoAR5x2haImY+Pu7+Vya0D/wKLXmxc1LqeTx1zBQMXsjXSptYpOTjZMgB80e6hOsPMW3kCFZzDsuYybOEn2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6310.namprd11.prod.outlook.com (2603:10b6:8:a7::12) by
 SN7PR11MB7639.namprd11.prod.outlook.com (2603:10b6:806:32a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Thu, 27 Mar
 2025 13:07:17 +0000
Received: from DM4PR11MB6310.namprd11.prod.outlook.com
 ([fe80::c07c:bc6f:3a1c:b018]) by DM4PR11MB6310.namprd11.prod.outlook.com
 ([fe80::c07c:bc6f:3a1c:b018%3]) with mapi id 15.20.8534.043; Thu, 27 Mar 2025
 13:07:17 +0000
Message-ID: <0f2227e3-10f5-4915-be92-e130a875fc67@intel.com>
Date: Thu, 27 Mar 2025 15:07:08 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH net-next] igc: Fix TX drops in XDP ZC
To: Zdenek Bouska <zdenek.bouska@siemens.com>, Tony Nguyen
	<anthony.l.nguyen@intel.com>, Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, "Daniel
 Borkmann" <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>, Andre Guedes
	<andre.guedes@intel.com>, Vedang Patel <vedang.patel@intel.com>, "Maciej
 Fijalkowski" <maciej.fijalkowski@intel.com>, Jithu Joseph
	<jithu.joseph@intel.com>, Song Yoong Siang <yoong.siang.song@intel.com>,
	Florian Bezdeka <florian.bezdeka@siemens.com>
CC: <intel-wired-lan@lists.osuosl.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>
References: <20250319-igc-fix-tx-zero-copy-drops-v1-1-d90bc63a4dc4@siemens.com>
Content-Language: en-US
From: Mor Bar-Gabay <morx.bar.gabay@intel.com>
In-Reply-To: <20250319-igc-fix-tx-zero-copy-drops-v1-1-d90bc63a4dc4@siemens.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TL2P290CA0003.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:2::20) To CY5PR11MB6307.namprd11.prod.outlook.com
 (2603:10b6:930:21::20)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6310:EE_|SN7PR11MB7639:EE_
X-MS-Office365-Filtering-Correlation-Id: a0b7a0ae-a8a9-45ec-285d-08dd6d304c8d
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016|7053199007|921020;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cTMyMVhkS2tHMnZEam1iY05DOWtPaitqeFFlVTNPWEpsazJZaWVrUmRkblFs?=
 =?utf-8?B?U2U1S3pib0J3cjV1VlY3dlFaRngrS3dVUGZvajRzTHdaaHY1OFNmZ2ZlMU9I?=
 =?utf-8?B?eER3SnpZMXI3UDNUMVE1ZTZsV3lDQlU4L2hTOTgraDZFOE9KSWpMUGR1VlAr?=
 =?utf-8?B?SHNOcDFuVUdXbExqdmJlb2MyM1daS1ZNSnpaa2dwWXFKTDd3dFYyck56Y2Nu?=
 =?utf-8?B?REJCMThZSllsKzJjOUtTL3dBTnhBWmcrMVR0UUFLV29EWGhickE4d0ZnRXN5?=
 =?utf-8?B?TWlqUWFPNnpuMCtnOXhycEZ6SlloekFhR2xnRmxDdFhNMHZrNncwRVNvN2M1?=
 =?utf-8?B?SGt0eVJ1RERDYUN1anN3SXBQak51UnJPbXFqc0dka041UFNCenNiTVZxYXVG?=
 =?utf-8?B?QUJIMzFFK0EwZFVrREZ2MEVlOHNFWEVTcFZuTDRySzVtZkZISWg4M0NLcTNB?=
 =?utf-8?B?RlQ2Q1ZXamxtWXBjK0V2V1lIN3VHRkNXR0FMdzZESloxTmgyM3VKMWZFblhE?=
 =?utf-8?B?R1ozUlJVM2hiODB3VUdZSy90UVpPbGpwdkUxVlYxcERoaXJwaGd6TFZoNHJi?=
 =?utf-8?B?ektUOGFoWjRNTS85TkFWQVljaS8xaFYwdnpXek13WXNVZ052MGRlNFNnNmFB?=
 =?utf-8?B?RFQzbWpIVktWRnFTL2ovOE5FdGFHMmZDcWdsWG96dzBIeHpuNVRvM1dkNVc5?=
 =?utf-8?B?QkFCUU1saWx4cDY4TWN3UndiM2RPTVRZMU8zSTh4MnFxTWltZDN2czJvK1FS?=
 =?utf-8?B?TTUxMmMrUUhOWElGRVdkenljbzhLRHNhU090UXlzUkJmZmFFR2J6bDNteWpW?=
 =?utf-8?B?TFNKYnBZUkVmRFk0dmRHQ1FyeXVKQ1RaMVFpTkJ4STIvWFJya25yRUVJcllR?=
 =?utf-8?B?dVJ0N1pHZ2ticVVnN0VRUTVlaU52ZTZxdGxkU3hKa1RvNjlrMEpVUC8vOElO?=
 =?utf-8?B?T2wwQWxubHFiekVXKzZqRisrSTdyWTMzbzg0YUxvQWJXenJheDJFbFdZNTh1?=
 =?utf-8?B?U1hOM2NjdUJmaEg2ZFJwSHVXdXlaTWt0aGUyanNtTHRPRGlrazFpTHNvQXlM?=
 =?utf-8?B?MzQwM1czKy90eFVnanlmOGlNZnZmbk9LOUVLWU9zUWhZYW1DZXgxMitJV0VM?=
 =?utf-8?B?Wm9ydm5uS2M4SDREemtPMnVuZEZORExJVHhad21xUWg0S1ZKQ1RsVXJFbzJG?=
 =?utf-8?B?dk1ncHo1UGJFSTljVDdzRlNFSWVyOEo4NjVKYlovS0xTdW03d0lkS3czRW5n?=
 =?utf-8?B?bkp5OTBzbTRLOUlwYjMxVk9ySWJzN3ZyaFhhM1pIWXduUGlyU0JmTlVHQ0Fv?=
 =?utf-8?B?YXcyK2dvYmtlcjZVT2Ztai8xRDFrLzJYWXFCRWVxTXhGemMxUlNlK2V3NTFR?=
 =?utf-8?B?TWRNbVM4Q3MvcWRoS21rbUxpZW05czYzSTlCY2FlM21RR3hGZmt4VGMxeGFp?=
 =?utf-8?B?dGl5MjVuUitmekMzcC8zS3FCUVlROVMrK3hoRTBDN3pQQnBvd2NNZ0ViUlVn?=
 =?utf-8?B?a3NCRndjZlNwcWNRZXJWcXBGaVNMQy9aL0hwbm91dk45L1g2RnN2RktJS1NY?=
 =?utf-8?B?TWJ1VXhIK05DTzVlWXF5b1A3NXBOMlc4SXlrUklRRFdiRFcrRjRMUEtwNFZ0?=
 =?utf-8?B?bVkza0ZvT2tlM1ZYVGI1bFpkTVRoUnFna2RZRkZ5aDFiMDR5T2lFdS9DNU8v?=
 =?utf-8?B?UGFLU2hMMHVzZnZXSUN1TjVKR3J1UjlBbTNrcHl4dDQvR1hlNmNia0JDL2VE?=
 =?utf-8?B?S1ZMa2NMdlN0TW5wcVR4WExrZzdZN0JpWFU4dysyTFpiYTBsQTRvM0xiamFs?=
 =?utf-8?B?OXJjZlZYa25rQ09iOVJBREpuaFlLbFZPUm12Tmp5VExzdExJdW9oNStXbGhC?=
 =?utf-8?B?eFVQRzJEcjB6aXg4alVCcHU0L0RsZFhtQ3BwN3p6MURSaVEreS91VGNtbEVu?=
 =?utf-8?Q?uSB60SqJlz0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6310.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(7053199007)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NkJEVWFOb0tYZHRiMEFyYVFaZVJEZUlTZDdrYjYxRUtZNVFIekRWcUp1WDFu?=
 =?utf-8?B?cDJGcFlDWSsvcnN3VDBqa0QweTQxTWdHN0JiY3grQjQ5UzFHQVBnSVY1NUNn?=
 =?utf-8?B?MzJEMDBoSUg2NUZWZEdzaFJZNHFDZnNEeTVra1JkRWY1M2NQeGVGSHM4M252?=
 =?utf-8?B?WnVRSkhTWkdOSkltVkdiRzFHT0FaWm1qeS84UERrejdHemFJVStBcXRyaXpF?=
 =?utf-8?B?YjRtcXhmcmExc25PdGpMS1ZNVHNwdkZ5V2s0R2RQT3dzQWgzS25SclJrRkly?=
 =?utf-8?B?SEhzdWZNNHYyZjZoUlczd0MvNWRTcVgvelg1OHhsYmhyNnRML2QvM29Bc0dj?=
 =?utf-8?B?aldxbUJzcUJnQmJHV3dXQ0dzRjlqSVpHdzNxMWJWMVBiZ1pxYWZ0VkU1UlVD?=
 =?utf-8?B?WFR6c1U0WHpIQ0Q2dTI5QVRjbkQ0czNoVEp6UEtnbW9pbytNRnBjTHBRd1hq?=
 =?utf-8?B?WENvS3djQ3pXUW1WTXdaUklqQjBTYnlZZ2oyQnBOYTd3enlLWkxIRU9BdUVz?=
 =?utf-8?B?N29wTUZKSm5OaGpGNGp0ak51Uk9TZTFtNG1zYk8vNEZORmpiMkhKeEMrak5h?=
 =?utf-8?B?U1VDOEdvRk9IVFF4MFZmekFvNzB3T290TjZpMnk2LzM1ZUpERWVVaGluN3Fv?=
 =?utf-8?B?Tm5xR2V5TUc1d3Fpd2Z4SXN5UHFCQ0I1S2M3YXZZYStqcm5IcmN1L29iT3Bi?=
 =?utf-8?B?RklQSXVXZlFaV01UdTFoalhIb2N5ai93Z0xzWVRzbnRUZlJhbXJSRyttNWxC?=
 =?utf-8?B?T0t6VHNSRzJpN0FTZmdhUGFjNFF1R2xleDZVcnRsZVJnSFNMT0o1UUYvMFRu?=
 =?utf-8?B?aTQxOUpEcDJ4SGNYNEMvaXZ6YldiUkw4Wjg4UkRZTXdBOG5NRXFCSU5vdkFm?=
 =?utf-8?B?ekNWekVhckNTMnJtTmZybXR6OEg0c29lWnRvLzkvc3lRSFJpbUpVVnBNNm50?=
 =?utf-8?B?MXJPY0F1RHo3NVNXdC9hVFgrdFBxaFpmV0kybm5pR2t2UTV2T082ZkFDdGps?=
 =?utf-8?B?OUVqNHJ5S0g1ZHBZb1VYUnU2Ukp0ditCWkNjbWNkcjU3d3hHZEE5a05RcU9P?=
 =?utf-8?B?d1owaUpRZlQxTGxrUlV4NzJ0WkVVdVFzeFlaWUl5WHlDQWdjZlJ1YWw4dE5k?=
 =?utf-8?B?Mko2RCtQeFZLQ281RmFZRSt0Y3hSNjFob0FrMVNiL2NyeDJ0NTNwSUtMQlFB?=
 =?utf-8?B?RVFWNEJiNG1namJYdXMwS0RaOElwc3YyaVE4ZFpJTi9nN2lkUTRwTXM2bjYw?=
 =?utf-8?B?ZUpVVi93QVg1dDl1Qk8wd1FKQ3NaL3VBcXlvSENmaHZtb1hyVVRDbUZJNllG?=
 =?utf-8?B?SE1aTU45VDkyS0d5TzcxbkM1aEsyaURrUDY3eHpmSzF6eENBTXlJYnhkU3Uv?=
 =?utf-8?B?N2hHNUs3cURRZStwdHQ0amxabURTRSt0amJjT0xEQzVxUE1RRVdTWXZOT1c5?=
 =?utf-8?B?STNBVXE2Rk1vN25TTUFnSGtDT2s4ckVNdlF2ckpnZVlwYUZLWGZ6bEFpQ2xV?=
 =?utf-8?B?YjYzSERFc3Uycll3VnZHSVF4OU0wT3BuZEg4TG5GR21Zc1JHazVEUWVjelU5?=
 =?utf-8?B?Z1lSSWdmb2hHNzBEQTB4aExDV0kveEJscXltVWIyWG9LRHlpUVFSV2RtUG5o?=
 =?utf-8?B?c1Fwb2NsMCtXYkttOGptenV2NEJjQ25GeXBWL1MzdGNOSnhDanpKbkVTZGxm?=
 =?utf-8?B?eEQ5NlVsM0pFNUlkcmptRzF4ODdJQWZ2SkU4eTFOYmoyTnl5RGZXblowMmYv?=
 =?utf-8?B?bmwwUm1tSEU1NEVSaEtPT1h5dmVRZEZ0OUtJU01Ba05vRHVLQzY3aTQyaThk?=
 =?utf-8?B?Ry9oK0N1VHg3UHM1enc1NW84MXMwMVo0QmdKQU1vcmhyWk5WQXpBMS8vVy9V?=
 =?utf-8?B?eld4U1RjQkoyWGZNSWkzUHFra1dVeEt2dnVzVG1zTDhCTEVKekhqSXd1U09I?=
 =?utf-8?B?d09OS3JYOGpVd0tTZkwyYUNIYU5tTGtDMFhVdENnR0FuQWpwcXlzbEt4RmxX?=
 =?utf-8?B?Sm80b1lwQUZUa0pVSVJCRS85bDFvOE9IWk1BMDFRZWw0cm5hUWE4aWlwbWpv?=
 =?utf-8?B?dHFoVEE1WklnU09BWFowU3BPV01BdkZQa1phVnp3QTh5VUlHcVlTTVVrYXNG?=
 =?utf-8?B?dU5tWENoVXpOL0p1NlhhYWhudGtjNURnT29OUkZEZzhiTmVGVjFPeEJhWU5S?=
 =?utf-8?B?MUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a0b7a0ae-a8a9-45ec-285d-08dd6d304c8d
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6307.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2025 13:07:17.4275
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3MXIo/C1f7cOfKsDPKbILe30/cii453hpjHdE1WJCqta9L8a6U/P0yjVa5FqqBuK78kXaizdWI7rkRm1g84jrxbBY+TLsRbFhh/uEONHYe8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7639
X-OriginatorOrg: intel.com

On 19/03/2025 16:18, Zdenek Bouska wrote:
> Fixes TX frame drops in AF_XDP zero copy mode when budget < 4.
> xsk_tx_peek_desc() consumed TX frame and it was ignored because of
> low budget. Not even AF_XDP completion was done for dropped frames.
> 
> It can be reproduced on i226 by sending 100000x 60 B frames with
> launch time set to minimal IPG (672 ns between starts of frames)
> on 1Gbit/s. Always 1026 frames are not sent and are missing a
> completion.
> 
> Fixes: 9acf59a752d4c ("igc: Enable TX via AF_XDP zero-copy")
> Signed-off-by: Zdenek Bouska <zdenek.bouska@siemens.com>
> Reviewed-by: Song Yoong Siang <yoong.siang.song@intel.com>
> Reviewed-by: Florian Bezdeka <florian.bezdeka@siemens.com>
> ---
>   drivers/net/ethernet/intel/igc/igc_main.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
Tested-by: Mor Bar-Gabay <morx.bar.gabay@intel.com>

