Return-Path: <bpf+bounces-55077-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AE6F7A77BCF
	for <lists+bpf@lfdr.de>; Tue,  1 Apr 2025 15:12:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8741F7A2AA1
	for <lists+bpf@lfdr.de>; Tue,  1 Apr 2025 13:11:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39C68203717;
	Tue,  1 Apr 2025 13:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JBij1Kfp"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7179AC2C6;
	Tue,  1 Apr 2025 13:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743513140; cv=fail; b=BnQ9zo0NOfm6kJws1HFz/Fhn3oXW7c9ZszXSybxrqSRth9xC7yJSiPmvULsoySTwLlrJJ4ZBK2C+Qd8aQ4bIzL1TAWD7UENiAbku4P/3IJr8ETrdEtQistmvHhFIAdfhf7B5E2vSG9bhwgOJIcS8sqFddAIuwxhrZWARssW71uY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743513140; c=relaxed/simple;
	bh=+BlnvcN2502buB+kjjaaREFrqx1lfo5mSCe2cEyEqJ4=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Gf6y/W+qTcpSG070rQeuhkzSIR1dm46A0udBAjZnu0QM5zTM+9IPAxnTHtGkfDE7be8/zf6obWE7KrLL5yjjpkb7gl/4cZR8p04szGsAgoiGlX8e+wtYhCNRDrjHhT/gLL7kNwRJWMfedRZ5XPNsJKxWgfvyOUmyR3yT64be5cw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JBij1Kfp; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743513138; x=1775049138;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=+BlnvcN2502buB+kjjaaREFrqx1lfo5mSCe2cEyEqJ4=;
  b=JBij1KfpvpoqxUDRv54LEgQlUp3AolkOSYfCkLUargQ94dHnfORZB8FG
   2bU4BQNXg9V4k7pQ3TfQapp4WHIY/IW0fbuLyVem9WY3nh4ajrFpVtAod
   Yh1QKcKNl9azUF5lj90WY8LCF+M6XcdhiKlsDNinumWcrRrCbwiMO4R1q
   8VV6RBYsA/4h+Vh8tLBULY1gbD4nOXEwRKHM22SrGbOjLBKDIBFxzyvd9
   Hzg07eZRZBBUfm0KgjJVGqdRn9FtV8WXpvsxMNd3e2wrSUnAluY/jYGKg
   0Z5GaTqlmcYLqQhYuK72E5fxEeJEp0vLlE9Npm7jyYPThnnJkM3rhHcOo
   A==;
X-CSE-ConnectionGUID: vK+LAVKNTXeFJOWiSKi9gg==
X-CSE-MsgGUID: Aj5iiajRRm6m+dlgsJSAZg==
X-IronPort-AV: E=McAfee;i="6700,10204,11391"; a="56203041"
X-IronPort-AV: E=Sophos;i="6.14,293,1736841600"; 
   d="scan'208";a="56203041"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2025 06:12:16 -0700
X-CSE-ConnectionGUID: EFu+WBksQM+jw5gZIOOTJA==
X-CSE-MsgGUID: EqDlUT6KSxCCKfz4k/9n7A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,293,1736841600"; 
   d="scan'208";a="130518914"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2025 06:12:15 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 1 Apr 2025 06:12:14 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 1 Apr 2025 06:12:14 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.46) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 1 Apr 2025 06:12:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SLJEyUQ34quRQf7NKefaeMWuAo0Yw7G+OOjn0i00AcsgWFqgSIcCkIBrV5JvqD6juvxrQYBRjgGd2bApbJJK/3NZCQV/X1Q3iG+jk/wPZx74zrCNa7dA/p3SJbKp2saHySmLiVJ12Rtr7+vrT/hRp+Ot7p/UZ2Irs6isYZ3+WIe8nYxErj/aBYinZVRAaJMeeUAe1CRo0sSwvPRkAu6B1YPjc2YcXeuZQ/b9i1mlZoiFpGmLhS7KdhagL9E/vtlEFcd2rCtS7WyKDVPyXc2HZyXU3BU6ymIXljW85Pk6D/XYp/II5o71aNV6/QFk4zqereSqWMEY4+cGloX3LfKzFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2oMiIKOZefCi3H0jLXTTW0zzp4Kjhz6jdWBYXfW36EE=;
 b=IDWctC3PFyQvhncLDUxgPfTK9nB8hBDKZajfYydHXbOj8wJ9JRGebqS7cBTI+L6aXbS9bK2PrIFZGPM2fNGOyFYdOlPVv7CPsPUt9kYAvR9pM7rk+KdKh7lrBTUMjH7cwe3wewGUze/txyB+BPqcfWqcWIJU0smYWC8X8eGkLJtT670H9B8WPVlffpm0u5lZDTqnS9xGfyVPsqYuuMCxlhWREoSY1j1J+bxrrqd5JhQ8A8iRlkHeK0izCWcbmL/fuUZ+LjAS88NejSW4ZTjfmFXwvrBCdsmd3yF4pFmgwECrIpN7W+8e0FBrGPkAgzETmSzsDm2Y+4O7L3TTBlZ+UA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by DS7PR11MB7887.namprd11.prod.outlook.com (2603:10b6:8:e2::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Tue, 1 Apr
 2025 13:11:57 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808%5]) with mapi id 15.20.8534.048; Tue, 1 Apr 2025
 13:11:56 +0000
Message-ID: <247bdd01-830e-434a-ae38-0c68fcc62051@intel.com>
Date: Tue, 1 Apr 2025 15:11:50 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 03/16] libeth: add a couple of XDP helpers
 (libeth_xdp)
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
CC: <intel-wired-lan@lists.osuosl.org>, Michal Kubiak
	<michal.kubiak@intel.com>, Tony Nguyen <anthony.l.nguyen@intel.com>, "Przemek
 Kitszel" <przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Alexei
 Starovoitov" <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
	"Jesper Dangaard Brouer" <hawk@kernel.org>, John Fastabend
	<john.fastabend@gmail.com>, Simon Horman <horms@kernel.org>,
	<bpf@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <20250305162132.1106080-1-aleksander.lobakin@intel.com>
 <20250305162132.1106080-4-aleksander.lobakin@intel.com>
 <Z9BDMrydhXrNlhVV@boxer> <fc94190c-3ea1-4034-a65d-7b5e8684812d@intel.com>
 <Z9ruoGbEg/4iJG9/@boxer>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <Z9ruoGbEg/4iJG9/@boxer>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA2P291CA0037.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1f::17) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|DS7PR11MB7887:EE_
X-MS-Office365-Filtering-Correlation-Id: ebd1113d-ed5d-49ec-347f-08dd711ec753
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MDM2aTRVN0U3VVBMbko3cGgwbjJBbVlIb254aThMR0x5azhyNWtJVk4raStp?=
 =?utf-8?B?Rm9td2N4bjNLY3ZMd0cvSWpDei8welJneC9COGd0dzhiWllYQkx3cVR3WUl2?=
 =?utf-8?B?TExLVU1mOGdqd1VHVTJ3QWYwdUZTcXM5QlpsaXhGQXo1SmFuNVI5cnYyeksz?=
 =?utf-8?B?THc0cDZDRTltR245S3RSMDF5TWRDanRrYklFWXlXLzBzbHZvYlZMQXVuRjZu?=
 =?utf-8?B?NVFKdk9IMVRCejhIc1VjOHY1VTV6SU54aG15Mk15Qy95c1dJLzNmWjFiUFF4?=
 =?utf-8?B?a0NUenRXM3Y5dXd6OUpnWEYxaW9Sb1RGTVV3ZHlETUNZMHhaU3NiNlJpQnJ4?=
 =?utf-8?B?enRMaklhemdmaThFREZrZlpRa1ZxNDB4bzE3MExCUUYrUkFIN05BOW5tUUoz?=
 =?utf-8?B?aWVHNFl5Y2NNdVpzeU13ZFk1WCtLQjNUQmxqaElBZlhEbU9Ta1dOcWlCeTMw?=
 =?utf-8?B?NTRTWExkRm5BWnV2NFRlWHJYbnltVTBzejQwR2dnK000eFh0d0ltOS9zL2V2?=
 =?utf-8?B?SGlvYlc3dVJVM0ttaEVxRXo4QUdwVStTWTljaGJSeDZtZHc2enlQZjVyK2ls?=
 =?utf-8?B?cm9uTFNPOTJkNVVMbVk0QXFiRk5Vc093b3ZqYUVZYkZDMWhlUnFVbFZzQnBn?=
 =?utf-8?B?S2haMzBMZDF5dFAvVXdwZVAyT1hoM2M5alhCZUkrZFV4Rk5RZDVjRUtyNS9x?=
 =?utf-8?B?ekJuUGZsUEV0cjd2ZHI2WUFuQkV3Mzl3RjFMa2lsbXdYN2krWTVSM1JwRE1m?=
 =?utf-8?B?SjhHckFjSHVhT05ITzF5MkdzNTNlb2lrS2tNckNEY3IrWnJTSk1BTEtyR2F2?=
 =?utf-8?B?dElKZ1c2OVd6YnNtU1F4SWFPNjlTSCtpTjR1dUFneVJXQUdyckJyK3JKcDlE?=
 =?utf-8?B?dGROejlJdk5qcy9SM252Y1ZhMWlOSmxyNExoOXhLb3I1cmpDQTYybSszV3NS?=
 =?utf-8?B?S1gvVDNZVXVGMEMvRG5Xcnhmem0yMzRhNVQ3Y2xKQzR5RVc2RHJlcGtLWk8v?=
 =?utf-8?B?YzFmZlBxeTdQL1VSNER0bUx3TTd5VlVVQ3huZTFpckk4ZUdQUDNTRnNsVDZj?=
 =?utf-8?B?SGMyR0V0NkloQnpDdW5QN3d2ZFZla2wyRmpkcFZ5cTNQQWRBWFY3cFNYUG4y?=
 =?utf-8?B?b3VTMlZZNkpuS1dGRU1iOFBUL3Bjdzlibnk2MlBkaHV3Y3l5NTNsWWZTd045?=
 =?utf-8?B?WGs2NVh5Q2hxNUFTeVFCV1E3aFRVRUJ1TlRxZEJNSXFNTlZwamljRW5qNWlW?=
 =?utf-8?B?OEM4SmE0cG5KekNmZVV0QmN2YVRkVzlLSzVDS3lyMkg4TS9SdDFrcUxyd0ZH?=
 =?utf-8?B?MXJDVER1QytsOWo5dmd6Z0lYenl3NXlqZzgzczIwY0NuWmNJWWdaR3N3dDNj?=
 =?utf-8?B?K3FPMUtjd2swQTQ1cVdhay9KdUJjQlpOYmN3ZFVkOGFpRVdnQ1diMWVObW04?=
 =?utf-8?B?aWNIRFhpc0JWSThYUUlCZng2YUZmd3pna3ZMcW9tVkVlaGIrZEtVeVhPN08x?=
 =?utf-8?B?N29tRVA2T1BSamExWHV6Tzl4eEUva3pHOVNSK2F2RGhQRGVGbDlGVGl2N2hN?=
 =?utf-8?B?cWszbVhUQmp4c2dxQlQzMHhzQkRyWDNiRGowUnpzeWdjWXN4U1Bvc3dIY2RI?=
 =?utf-8?B?TEl5aS9jbGNyQVNUWFVQVDBhSTFLdnltWmRrWHA0c2Vlc2NmMkVtVHkxT2xC?=
 =?utf-8?B?L09BbGVFbEJ4STFRVFNyR2RmRmxRTEprVEI0MDUxdFplYW9TS0VGVEZxSGxP?=
 =?utf-8?B?M01ObFNFQlNRd2M0cndkVEQwblduaG9PbDdKakNENVhtSmJEUEJ6RHJNTnU0?=
 =?utf-8?B?eWlOL3JYOWx6Y2IwWHpacURKM05RMHZKRUxzSWJTdmdGdzVWeWdWdGwrY2oy?=
 =?utf-8?Q?lWtENbuWzX0fA?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OUdSbEJ5SmppVURzVWx1cTI4MGlrUHlyM2hxUWUwL2o3bmR5MnZXbS92Y0xQ?=
 =?utf-8?B?eXppb0JSNUVYY292Rmk3NkloakRzRUdjZ2tXZkRxa1JDZkc5dDZpRHpoNllD?=
 =?utf-8?B?cWtMdzJ0YXNVcFdKdTk1RDlnSU4zUzVkajljNXF6YUNNaUFWcSs4TlUvNkg5?=
 =?utf-8?B?TGd5dUZDcFhXSzJ6dGxMOTJCVHhUWGZsM2ZpZUdubGFIdWFvbXhiVDBiTVpT?=
 =?utf-8?B?NlJHYUNvWFhKNGZ3d3dQZ3ZXTjc3M0lZb05aK3IzZElSQnNBdUpySXVicGox?=
 =?utf-8?B?TUhwQWgvVnAxUERxTFhUL3hQVjFNU21FV2k1NVFlWkVVekVINzNSRHVKdkRP?=
 =?utf-8?B?ZGlpUXdzbjN1WnF2cXVZOVZ2bit2VW1oRkdyZmV4Sjl2SVovbUFOMnJLNVhw?=
 =?utf-8?B?UGpYRW41Y1NSV3BRemJ5cThuTHZjSUcrbW4xN04wcUNxdmpOYTRVWVUxd2R4?=
 =?utf-8?B?VVRsVkhtNVcyUVNQcTBvT0NBNFVFRFlCZzZsNlpBd25qakJIK2xvT2x3VGZr?=
 =?utf-8?B?Z2s5V2tKeWY2ZGF3dWdwdWJleTVDRUtMQlp6ZitReS8wR1hPYVMzRGtRTHpR?=
 =?utf-8?B?NmppUHNoQmI3V0RFMitOTk5ERFk5NzZjL0ZVSkk4M3ZqNkNKMFBMZjRkZzlE?=
 =?utf-8?B?Q2VmOU5PbnNwK3FGMTN5NXZFR2tuSXpHMFd3TXBuQlYrMkx3dnl4Qk5NWDJm?=
 =?utf-8?B?NGVTcmY0bHlKdmhFTGdiNnlVNjhsWkdpcG5lTFE0WEo0S2RiajdxdXlaUE9W?=
 =?utf-8?B?dXYwSUVoaWQwRnBzc0ZoVHJNdXUycWlnbWY5WmdMZFFvbjZnaVhFM1dHQzVu?=
 =?utf-8?B?cXBVZmJTakFXUkZOL1Z6eFo3ZXJyUU1oTEpBNHBqWUp4Ump4OHNLRFZMcnM3?=
 =?utf-8?B?UnByTldmaEx6ZEQ3Z3E3U0Zxc3g3OGlFdjdPOXNHZEJENU9EdXJSNTNOYTVu?=
 =?utf-8?B?UGc1VUJLNDExMTFxWFFEWnNrQnE5UXNVMTgyZGVMMDFGa3A1cVk1Y1NhOHhF?=
 =?utf-8?B?S3JqR2FBdUpOd2dSc1BpZUJ3YzVPMitBSkZlK3ZQUnpYYmxjWHdraFJjdVZO?=
 =?utf-8?B?U3FUVGU3eC9RYkJ2cm5ucFZTVk1vM2g4aGtWK2JwNHNIdldhaDhxTDhxcXp0?=
 =?utf-8?B?Q2hVRVJ4VWpaR1FtazJTUjJYUVkzV3FueThwSXB4MHN2QThUd2lqejBlNnhK?=
 =?utf-8?B?U2wvUGd6M1Bobk5aV3U1bkF0dmplNWNuUmV0WkwzYm4wZmZUWWQ5WjlVT0Zr?=
 =?utf-8?B?OU02M2pwWGJlUnp6bGxWcGR3N3czZ3NLbm11VTB6L0lkQm9EcFpVUXE1TFFk?=
 =?utf-8?B?QytlS1JRUTBxeUhiQTFNc1JCNzN6S25ENndQWFdKZkVsaDBRZjM0R0Ewc2s0?=
 =?utf-8?B?N3ZGU0pOcFVicllMMFRodWQ0V3JtbGk4Ky95NVhZVEdUbGdlZ3ZjK0JWS3k4?=
 =?utf-8?B?R1g1anNiYzJJNWJLRzc2UTh4U2lZVVU0a08rdW5UMWRab3FNd1JCOHdyWk5L?=
 =?utf-8?B?eTNUa0c1SzN0TnhFZjY5bXl5MUNkd2VHdmFCQ1RkUjBnMnpuVStDVXAwZ2NW?=
 =?utf-8?B?WnNYZ2MvbHRCK2xLb3k4Wnp4NVhjckNzWU45RXlsK0wwaEk4QzdOZVlEZ05u?=
 =?utf-8?B?bXl1dGlYeWtFeW9iL1pUWmtka2kwMThSejRUV1dVWExoRXA3QjU5VCt3bk5S?=
 =?utf-8?B?QnR1UkczYVVDUHBzRFJrQXVWRW9oV1lRMWJMVVd0RFN2MjhWdGpYT3JNUmtj?=
 =?utf-8?B?cEU4SDdCcnNNZlkreWRoUnNOV1pKMDUyY3BpUVFkUDl5Wm5tb3RjMUNEWmh1?=
 =?utf-8?B?UnplblRxaEo3Z1VzZmxpRmRMRXVEbGU4YTB4VVlEb0w1cm5XbXRFOWJuRTY5?=
 =?utf-8?B?MG8rc2VuOG84TzQwTUVzUUUzbTVuMmhYY1RDSHlkdWZ0dkczcURLZ3hKWURs?=
 =?utf-8?B?YWtOZmtkMDliNlFCVm02RUJHNWdMT1hTbm9aWU1kT1Qxc1lSV2lOUWwxVG1j?=
 =?utf-8?B?RFlTWGZnNk9EL3BhbGpCQU9vVDkrd2wwK0Z3aHdJUTMzS3BYUVlVUzFSVU1w?=
 =?utf-8?B?MVVycW1IN3YxNTkvWWNyV05NdjRJL1I0Nm0wVUkvcmtJYWJMVmdNZElvdmYz?=
 =?utf-8?B?cVdIQWlaN1NpODExemxaZ2s4TERRR3l6TUVKWjVGMFpBdWFQb2RkUlo2UVIz?=
 =?utf-8?B?WHc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ebd1113d-ed5d-49ec-347f-08dd711ec753
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2025 13:11:56.6708
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J0ok4ddz9tBXJZoA/zcvXkQ1tQOE6YnusoaHtHo7Rco+y0Jp398tfy10RJb99Ax7xgEm6IFmmHfdHLQRdcS7/pW6cTD/IAcC0SuulwEhfg4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB7887
X-OriginatorOrg: intel.com

From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Date: Wed, 19 Mar 2025 17:19:44 +0100

> On Mon, Mar 17, 2025 at 04:26:04PM +0100, Alexander Lobakin wrote:
>> From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
>> Date: Tue, 11 Mar 2025 15:05:38 +0100
>>
>>> On Wed, Mar 05, 2025 at 05:21:19PM +0100, Alexander Lobakin wrote:
>>>> "Couple" is a bit humbly... Add the following functionality to libeth:
>>>>
>>>> * XDP shared queues managing
>>>> * XDP_TX bulk sending infra
>>>> * .ndo_xdp_xmit() infra
>>>> * adding buffers to &xdp_buff
>>>> * running XDP prog and managing its verdict
>>>> * completing XDP Tx buffers
>>>>
>>>> Suggested-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com> # lots of stuff
>>>> Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
>>>
>>> Patch is really big and I'm not sure how to trim this TBH to make my
>>> comments bearable. I know this is highly optimized but it's rather hard to
>>> follow with all of the callbacks, defines/aligns and whatnot. Any chance
>>> to chop this commit a bit?
>>
>> Sometimes "highly optimized" code means "not really readable". See
>> PeterZ's code :D I mean, I'm not able to write it to look more readable
>> without hurting object code or not provoking code duplications. Maybe
>> it's an art which I don't possess.
>> I tried by best and left the documentation, even with pseudo-examples.
>> Sorry if it doesn't help =\
> 
> Do you mean doxygen descriptions or what kind of documentation - I must be
> missing something?

Yes and not only, I meant all of the comments. There are even some
pseudo-code example blocks for complicated stuff.

> 
> You cut out all of the stuff I asked about in this review - are you going
> to address any of those or what should I expect?

I haven't read all of them yet, a bit of patience. Of course I didn't
cut it to not address at all :D

> 
>>
>>>
>>> Timers and locking logic could be pulled out to separate patches I think.
>>> You don't ever say what improvement gave you the __LIBETH_WORD_ACCESS
>>> approach. You've put a lot of thought onto this work and I feel like this
>>
>> I don't record/remember all of the perf changes. Couple percent for
>> sure. Plus lighter object code.
>> I can recall ~ -50-60 bytes in libeth_xdp_process_buff(), even though
>> there's only 1 64-bit write replacing 2 32-bit writes. When there's a
>> lot, like descriptor filling, it was 100+ bytes off, esp. when unrolling.
> 
> I just wanted to hint that it felt like this feature could be stripped
> from this huge patch and then on of top of it you would have it as 'this
> is my awesome feature that gave me X improvement, eat it'. As I tried to
> say any small pullouts would make it easier to comprehend, at least from
> reviewer's POV...

Makes sense, but unfortunately this won't cut off a lot. But I'll try,
to the degree where I'd need to provide stubs.

> 
>>
>>> is not explained/described thoroughly. What would be nice to see is to
>>> have this in the separate commit as well with a comment like 'this gave me
>>> +X% performance boost on Y workload'. That would be probably a non-zero
>>> effort to restructure it but generally while jumping back and forth
>>
>> Yeah it would be quite a big. I had a bit of hard time splitting it into
>> 2 commits (XDP and XSk) from one, that request would cost a bunch more.
>>
>> Dunno if it would make sense at all? Defines, alignments etc, won't go
>> away. Same for "head-scratching moments". Moreover, sometimes splitting
> 
> maybe ask yourself this - if you add a new ethernet driver, are you adding
> this in a single commit or do you send a patch set that is structured in
> some degree:) I have a feeling that this patch could be converted to a
> patch set where each bullet from commit message is a separate patch.
> 
>> the code borns more questions as it feels incomplete until the last
>> patch and then there'll be a train of replies like "this will be
>> added/changes in patch number X", which I don't like to do :s
> 
> I agree here it's a tradeoff which given that user of lib is driver would
> be tricky to split properly.
> 
>> I mean, I would like to not sacrifice time splitting it only for the
>> sake of split, depends on how critical this is and what it would give.
> 
> Not sure what to say here. Your time dedicated for making this work easier
> to swallow means less time dedicated for going through this by reviewer.

Also correct.

> 
> I like the end result though and how driver side looks like when using
> this lib. Sorry for trying to understand the internals:)
> 
>>
>>> through this code I had a lot of head-scratching moments.

I'll process the rest of your review really soon.

Thanks,
Olek

