Return-Path: <bpf+bounces-60979-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C1B70ADF2D4
	for <lists+bpf@lfdr.de>; Wed, 18 Jun 2025 18:44:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 269BA7A423B
	for <lists+bpf@lfdr.de>; Wed, 18 Jun 2025 16:42:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D8B12F234A;
	Wed, 18 Jun 2025 16:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IDuPh+5Q"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E84F31A239D;
	Wed, 18 Jun 2025 16:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750265042; cv=fail; b=M3WatKsBXRHJtwzNSJIcZdeon2vdhu55G8pm7ViHCNPnwBvM0k9VIlqD6cR99RBjAqAnl3ie4gpnGbdwQHRZoWBZ7hiaWQzqQvq/kfBVdhg9CGmEHaaaMRNwOf4NtgKBHXhZJ2/yi3ltb731S97sAoOlnQ8jcBZByP9St4KKwhw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750265042; c=relaxed/simple;
	bh=dWMyrMF1UzYsWDtPMcqhCaiiGBTHMBS+t32nsCaYRYo=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=bTxnCYpnz2VlRveHZKP/rq7FUOvmAAM5I/3+dL0gq9degFpj2UabLrOfjDs4t0hXMhXbDAFa4GMDG54LH0Q3TFeHzV8G/Y1OggBmSBNpfJtRNjz9aSUBwnPvKooK1oeef/CiTPVv+Cqn8bu4iZMuSFPh0Qqt/OougFN68mnP8tA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IDuPh+5Q; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750265042; x=1781801042;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=dWMyrMF1UzYsWDtPMcqhCaiiGBTHMBS+t32nsCaYRYo=;
  b=IDuPh+5QeQxaN2Y11JuOKbAlqf0c/UjmgXkh+lGauRZQydqEqkBTEafh
   5LHgRv6FK41Qo8NUu3OafcWqpvzuplrA9Zak9kxWGESg6WSQfkR0GEPm6
   i8y4SM2q6mYj7Mnu2cuAbDe3gy/Lmr4MWIAGhmG6L0+Hmpx+crK29W3ZL
   bmheBwweZBzCJ7tnhLNMZtKrJUy7x2m0kVQAZxNnE7ZJL1Ds+tukxROT1
   oJel9tC8txwh2lSPyW8AIaszpl7p/MkhEpcOHJtYVstnCdp8L0IaiC+6Y
   fI9uOYbyl6jGBto1OM9Z0yo72akgVEiq6yYs7HIL1ONciDjvpoKQD1MfP
   g==;
X-CSE-ConnectionGUID: oSOsLCLLQiCVCWhut1k05g==
X-CSE-MsgGUID: VbmGZqQxR+KzAi1BRtmBqg==
X-IronPort-AV: E=McAfee;i="6800,10657,11468"; a="52193005"
X-IronPort-AV: E=Sophos;i="6.16,246,1744095600"; 
   d="scan'208";a="52193005"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2025 09:44:01 -0700
X-CSE-ConnectionGUID: ZlnhPa6sT+etwhMnt+m2+g==
X-CSE-MsgGUID: BpkMnaS8Q8KXBk1dFOU0mA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,246,1744095600"; 
   d="scan'208";a="149631214"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2025 09:43:59 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 18 Jun 2025 09:43:58 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Wed, 18 Jun 2025 09:43:58 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (40.107.243.49)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 18 Jun 2025 09:43:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QP1wQsq0N3/f2cXG/qlYpzzi3uRcT9A2UqF7mes56Sh5CIX4cBHaHwiuvBnBDB6lRRrNGKCCmH47KCVV8gfyBxgj/KGGgHcR595WgX3QJysrB44NlY+Mg1Cv6pd6JBwmB8YPBJ1PRSqjTH1/Wlt38jhA6Z4sKwswE5Kc3Xoa32pmeeWfLeFJ6KzOKtdHE5GWyH9Cje49VEx4eb+HZKbGDGjG+91ATzwj27TOUfTy/dgCQrqLJ2fChqxEnzjsp9z4nw/gnAmTfA7wb/nipqCdGtdxtxOIPBt+9m/bMkIWKiiKBs/hFZjiJOAKGT7rsgqsikmxVNfYXFdyjr9UNee5Yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ekMcA2L2ha2FmB+qhxLxITJEq5PXoIwusTYAyykscXw=;
 b=il0LESlX8jqd8E1Mj69kzwst+9curEXaSM7gV9BXO+uLIbMyZzEvzbKsSgEmDqVKFyHD+FsFAUm2oqVJVRW/+MmtRvy3XiEihXBdj9zCxyiLYyRUNPXihB7oM2GCiifKmjItYUs0zjw7MimxLINCGGByrNfJsWIrCxpIIa9SJ6IPsXECsrgm4wOK2EkJ02QP/M+L6e/3GS+AbioWBQFhjlw15P/5Fxeaq0MX/NvkEqYz7KZglWIh8MntIKvDW6MfFRpOWsKXx2msedUqlTh/65tp/5iGpp+ZQ1QKqiQ1SZDIsKZt2CloTrCPhQtCfu+H8jx4QgTONb3v9kIkg1nCug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by PH7PR11MB6676.namprd11.prod.outlook.com (2603:10b6:510:1ae::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.28; Wed, 18 Jun
 2025 16:43:56 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808%3]) with mapi id 15.20.8835.027; Wed, 18 Jun 2025
 16:43:56 +0000
Message-ID: <996136f1-9271-42db-8b8f-8d595098a3a7@intel.com>
Date: Wed, 18 Jun 2025 18:43:50 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: Configurable XDP Generic Packet Headroom to avoid SKB
 re-allocation
To: Til Kaiser <mail@tk154.de>
CC: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
	<daniel@iogearbox.net>, "David S. Miller" <davem@davemloft.net>, "Jakub
 Kicinski" <kuba@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>, "John
 Fastabend" <john.fastabend@gmail.com>, <netdev@vger.kernel.org>,
	<bpf@vger.kernel.org>
References: <d02c6db8-6bd8-48b0-b235-cf132d42057f@tk154.de>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <d02c6db8-6bd8-48b0-b235-cf132d42057f@tk154.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DB8P191CA0008.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:130::18) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|PH7PR11MB6676:EE_
X-MS-Office365-Filtering-Correlation-Id: 0cb7c8e4-955a-406a-f0f8-08ddae87511b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|13003099007|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dU1NTDdqdno2YllnbTZQTWJQNldITERFbmFzUis1U3RWWGJ0QnpzR09IOGRW?=
 =?utf-8?B?YVo0T1BMaktJQm54VkpEZHVlSnhUSG1HRzhRNk41Vk5ydUFZYXhDbEVvTWQv?=
 =?utf-8?B?MFNGaG1TejRBNUxRTk4rUG5YRGVVaDhDMGhWdnBEQWhSMTNybXBWVjhyQ0pu?=
 =?utf-8?B?aXNHUHdiYTV0SnRVUllodmZCWmZoZWFkRHJYbk1IUVFRRHE0MDU1MHFOejZF?=
 =?utf-8?B?NnVSU0RIb0MzeXE4ZmE4b3Y4RzBveUdxK1dPckcvWU5vRnFpeHd3UTFiYWZi?=
 =?utf-8?B?cW1MMmV2SzQybjFjeG5XYll0R0pjNjNsWThrOStGOWxHUXFmQlRiQnFUQ2tq?=
 =?utf-8?B?K2oza3lVc3JjQWluYXRDc2tybjVEOGhLbFVmTDhsUUhaWngrRkh6YXBGWjAy?=
 =?utf-8?B?NGxXOWFBSlJjbVhUajJHL0FsZVp3Tk9SSnZIeTAraGxqWFI0aWpMdnFBeklE?=
 =?utf-8?B?VG9JYXRiQTB5T1M0cXovRUdHNnhmWklJdXhIU09IczRoWmIrWTZEQkx4bGRz?=
 =?utf-8?B?Vmh3ZGV3MGFDbnZlUHhYV0I4SDExQXRsdklTcDlZL21sZXRHL3U0Tm9BU1V6?=
 =?utf-8?B?RGpqaGtrZldRay9uR1o1MTV4OFF0SlM2NlFRWFB3RkRiSVJhUGV0dDJaTk9S?=
 =?utf-8?B?VWtOTXdEbWc5djl3RStkeFdJNjlNMlZ6d09kd0NTZCs0VFJoVWwrK2Vnc1BX?=
 =?utf-8?B?c1ZOMk0vaGdaVTYxbFdPRFI5Z3YyTGJHREVlajNTL0svRm11eDY5NW9GYk1X?=
 =?utf-8?B?bEJPeHpBNkQyMmsvcml2MlkwcmgyZTJUdWxDL2poOU81MUU2c3MrTVJCT1d3?=
 =?utf-8?B?TlJFcjZjaXNrdjJQYk5NYjdYTStEajRkTUszaTV5NVAwSnUyK2RsTCtXOFJH?=
 =?utf-8?B?VWFJMHJlR1M0NXdmYWFLUDNiQjJwcWF4bW5hRnFCcGtlaHpUNDVSOU5mZG1Z?=
 =?utf-8?B?YXlWR25tQUVWWjhaSUNHSG45Q0VONGp0OXhOVHF1czJONmxjUklCbFd3eGJO?=
 =?utf-8?B?aDBrRk95N1ZsTmhMRmJKaExUdWN1M2svNjNiTVVkeXgraXdpVWJLM3lIb2Zh?=
 =?utf-8?B?bjBRV2xQOWw4WkUxVy9OSEd4TEEyRlBLL1ZGNnFUMEtucXUyNGhjT0ZMd3Vy?=
 =?utf-8?B?OWR6OEx6OGtTbGhvL3RDWUV0Z2FqdXIzTW9mTFJkV21xVDByQjhFQXVxZFI0?=
 =?utf-8?B?L1pCT1JuLytLWnVvc2JYZlVKVXkrODNqYUtvNm1DV1Zzc3ZwWDlYbE5xaGRo?=
 =?utf-8?B?U3hueHMrcStrK1gvTnFmbXQvZVdaMjJJeElhZ3hOb0t6dy9YUnIralNjWVpE?=
 =?utf-8?B?YkJOQSsrTnRYWVRmT0RESWZ0alRWRG5GNVpTano3Q0NnMDJpRUlGbXNVVjRY?=
 =?utf-8?B?ZU9ZaklNUnBzU3R6bEFkMVlwdS9PQzBFTWF0ZUU4eG5HV3dNa0dkUTZGUXV6?=
 =?utf-8?B?czBaU1J6VnlmT21vZFJPbVR3b0ttdnkxNXRLb3BxZVppNitIWWx4RnY1Rlhy?=
 =?utf-8?B?WXN4ZEYvdmQ3M2NBdXlrYmVIVktiSmp5MDltajMzbzNNSVBXcUZGSXZFMWho?=
 =?utf-8?B?MXJUT1M3NmxHTGIzbCtSNnVYbU5tRkJoalAvclhGRG96eXREUkZuTWk2N0h6?=
 =?utf-8?B?WWVQTTZPK0xpWFBoSGFPWjNxajBtMHdKTFY2RnVPUG5tRml6NUdodm1TSVJS?=
 =?utf-8?B?TnIwZzV0VWhna0pRMW9aQ3NOa3Z5VlVJTnFxbE51ZlY4b083aE04VEtGMlc0?=
 =?utf-8?B?aVRYcG85TVo2b3dtUG4rUmJQTHJQL3o0NkR4L2x6bVFCMVpvVkwxU1BhWkRk?=
 =?utf-8?B?UlVIQXRpcjFSNDFsNThvT045THpsOFYvR3lVcHdhZjBXc1pmU2QxZlppVklx?=
 =?utf-8?B?Z1BWcFdGVDBQSExnckxHMmVDeEQ4YWxNTjJHdElUaDRybk9kOXdvRmozMjB5?=
 =?utf-8?Q?IGJym8iIkwc=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(13003099007)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YTMrWUZ4ZXdvb25BWDZtRWpWbk9jcTBFS21PSjJsVVhnTitNbTFtZWV1TGky?=
 =?utf-8?B?Rms5RVZBVTkyUUpCb0pLRVBmcmNqSktLdUxNSU5hb3NYbDgrVzNJSXFYZjhx?=
 =?utf-8?B?dzkyeWNqODlVb3VpNmNscExHbnJ2aUExaktqUEdSYVNtVXM1a1M5djVsdHNU?=
 =?utf-8?B?UUxpTUNORjh5Y01Dc01GZlAwYURkZ3R6Yjd0TlduQjhIU2tUY1BpdFpqWFVR?=
 =?utf-8?B?UkVkK0ttUCtobTFQSnlRWiswck9jMzdtajRoN1Nib3lJczlOeDdVRTNKSkkv?=
 =?utf-8?B?eHlYNVVaS2hnMStvMHNOdWhzMS85YTg2eTZsZzV3ZUIzLzZnTEVBQnZWdXlq?=
 =?utf-8?B?OVVsOG5QVnVKNmVPeUxsRXFLQ2dpTE1FWE5aeStUVkJYVnBxMUdnOUhNWVky?=
 =?utf-8?B?dXFpYVo3MDFYOHJRWDE4RzhTenNNektiZS93Q3RzZHVxUHZPeGx4K3ZBYnNs?=
 =?utf-8?B?SEJFak5rOTEydE9YNDcrSy9CZWV3a09HU0xQeVRndGYwQ2MrdTUxbnZHeFFi?=
 =?utf-8?B?eWw1S1l3cmg1aVFpVXVUV2ZCNlYxV0FQRGRIYUxSdHFYUDZMS2hsOFZmMU1m?=
 =?utf-8?B?UzVqMHNXaTNVdFJaNXRucWJGc0dwZVl2NmlJQ1VXT2RhaG5wS1hiMnFSaWxG?=
 =?utf-8?B?V25BMHhLOS9yeTJ0QmdsT3czOXMxTU9lMEM3OU1xNFFNVW1CNkFUQ2lLM0hw?=
 =?utf-8?B?SFVzeUtYRDdaTGk3WXpxVWQ3bGVscUYxS0lFcU14eERhbXBEdGhZeUxieXNn?=
 =?utf-8?B?eDVIdGZyNlBNakJrL21VYUN5SlRPcVUwSURNY0p5NEdTS1VCUHI1VkdkcldW?=
 =?utf-8?B?QnZDOXpyaWJjOENuMldnZVhkSmxNWUMwTTBrK2l3dXByQk1PUGxBREFUMjhN?=
 =?utf-8?B?cU5XQjBWeTdseCtJbkZrTTN1aFRyTzZDY2Y4Mk1sTGJNZmVqYUFwM0w0eUxv?=
 =?utf-8?B?bS82cmJWTUpVNGYxbkJ3OE55aVhQSUVJZk9UQW1YRldOcVZQSnlaOXlPcUNi?=
 =?utf-8?B?ZU1uTEVLallMaFA3NEFpWGwyQzVpWU1GMURkbDlPSFVaUWZKLzBnMG1NZ2Q0?=
 =?utf-8?B?V25yQWx4OHB3aFp4SWRwWDZLelFrMWN6NXJDM2NlYmhKaFA1eTB4Vjl2U3Ry?=
 =?utf-8?B?SUd2dDZuekNJVnF5MjZRekdmeHZPNlNuT3pCZHhaeE9JcHBSSUVlQ2svcUY0?=
 =?utf-8?B?QkZQazVHWG10U3NLZlNhOEZubjBJNVBnVXVrNEZNemFaZ1BtTzk0c08yKzJZ?=
 =?utf-8?B?ejYybW9GcStCSlFuSXA2K24wM0VEYVBjVTlrTHJmWHB6Zm1MRVNNdXU0bmpm?=
 =?utf-8?B?VEsvemJTYUZNZTVOTW4vWElxOUNGM3QzTTNERWtUQ3p2K051dEVsZEhqVGtJ?=
 =?utf-8?B?UXhZZUhMV05UaHZIeEh4M3FxS2NPdFFZT1dtK2hZREtjZ1diMzFtMXUwNGRo?=
 =?utf-8?B?OVFNemh0T00xVTVHN1FNSUM0RW80KzNDN01sZHFybVVNaS84MHp4ejlrajRV?=
 =?utf-8?B?czNicUtKS1Y0LzZ6bk9oemhSY1JCNm1zTHdqN29icGw2alZPU1BIbEZhRzVR?=
 =?utf-8?B?aWNTTGJrbVJaRnFtMXR0TVE1TWR2cVVKaEd6eW1lRWh6U3c4SEFWWnpvaERs?=
 =?utf-8?B?YTZDaC9tdmJJQUVOMWo4VHdlQyt0UGgxNVh1T0FFbDVvNzQrOTQwUjZucGVI?=
 =?utf-8?B?N0dQMStOTGk5V1VyRDNCR2E3czBtSExvNXRQWWFsV2xCQmtIKzRmeVhoZjZ4?=
 =?utf-8?B?Y2RRb1RHV2NCaG9hTUlJY0FWeHJtK3VLTFVROHhlUGRnT29ETzlNbW5qODZO?=
 =?utf-8?B?T29uVEV5SzhYZjRSdC9XQlNhQmN6QitzZGdTcUl3NnRrcVhZWmZEVmc3SGJs?=
 =?utf-8?B?bkdiSTVUS3pMZXBTQjhvMWZLLzRpbG0wYlBGV3N3Yklzd0ZjbjM5dE1OUFpS?=
 =?utf-8?B?eFI5dUM5UzJzbERXV2xFREdPKzJEc2dNUVp2S1d4U2pqRElmMHo5bkIrKzdE?=
 =?utf-8?B?L2trM1J2bWwzM0pYOUNGaFlUeXd1a2FOOGs2T0Y4cXgvNmZKV3pFM2RML2xB?=
 =?utf-8?B?MXVpanJhUVc5aC9pa3FWbDN0dkszYUtCdWRTYTVRQlpOY3AwMkMySXFJbWJF?=
 =?utf-8?B?Zk9sckhJcmZiSU5WbHZwR28xYWtleGNaRE5JNUszM0l2R0R3Y0dWdnRnN2tR?=
 =?utf-8?B?bFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cb7c8e4-955a-406a-f0f8-08ddae87511b
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2025 16:43:56.5378
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a4ynZyfMTCwaaPk2geXLORUQjqwuZ1+na8E4QUME/MwjY4QIFjfdvK6Q2DSA3MbkP+Ai5LfHyVmHMUjNBCczQypDwmOWEdII7HW0VwdT2l8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6676
X-OriginatorOrg: intel.com

From: Til Kaiser <mail@tk154.de>
Date: Wed, 18 Jun 2025 17:03:49 +0200

> Hello,
> 
> While investigating performance issues with XDP in generic mode, I
> noticed frequent SKB re-allocations due to insufficient headroom, an
> issue also discussed in earlier proposals such as [1] and [2].
> Currently, netif_receive_generic_xdp() checks against a fixed
> XDP_PACKET_HEADROOM (256 Bytes) [3].

Every more or less serious driver implements driver-side XDP and the
generic one is not performance-oriented due to being generic and how it
does work.

> 
> I would like to propose making the generic XDP headroom configurable per
> interface via a new member in struct net_device, e.g.,
> xdp_generic_headroom initialized to XDP_PACKET_HEADROOM at device
> allocation. The user can change its value via Netlink and/or sysfs
> before the XDP Generic program is attached to the interface, and
> netif_receive_generic_xdp() then uses this instead of the hardcoded
> headroom. When the XDP Generic program is detached, it is automatically
> reset to the default XDP_PACKET_HEADROOM value to avoid conflicts with
> future programs.
> 
> This would allow users to avoid unnecessary SKB re-allocations if they
> know their program’s headroom requirements in advance.
> Would this be a viable alternative? I’d be happy to prototype a patch.

What I also thought of:

1. Can we notify the drivers that the user installed an XDP prog, so
   that the driver could adjust its headroom even in case of generic
   XDP?
2. Can we maybe extract the needed headroom from the program itself in
   the verifier?

> 
> Kind regards
> Til
> 
> [1] https://patchwork.kernel.org/project/netdevbpf/
> patch/039064e87f19f93e0d0347fc8e5c692c789774e6.1647630686.git.lorenzo@kernel.org
> [2] https://patchwork.kernel.org/project/netdevbpf/
> patch/20220314102210.92329-1-nbd@nbd.name
> [3] https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/
> tree/net/core/dev.c?h=v6.15.2#n5279

Thanks,
Olek

