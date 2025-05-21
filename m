Return-Path: <bpf+bounces-58655-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAFDFABF4DB
	for <lists+bpf@lfdr.de>; Wed, 21 May 2025 14:55:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54C6617A499
	for <lists+bpf@lfdr.de>; Wed, 21 May 2025 12:54:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBE7726D4F0;
	Wed, 21 May 2025 12:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RerL1LqQ"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1092267B83;
	Wed, 21 May 2025 12:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747832015; cv=fail; b=XZ9qAdYnr3lXu5VcHar6fjv7L9oSVixhHLBm1ClPEHQmt1Q1RIdL6DLClAyYQjO2BvTjnQk1317/dDxwyNtbOQ9kZksCArphqvU9FZFaBXwzrDbjJQuWNW14xDdiB9yocEYvULqKTz3gPxd5tMChkVansIv2agx6w8e15AivBbo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747832015; c=relaxed/simple;
	bh=Fp9Rcf/JcLX+H96sp1rFmhSVHGL7VIBuNd4YooTySSs=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=e5LsRZ5XRhxNRjeh02rrXc/xwG3YJx0lvSFBa4dmmr/gExXFIA6FMlC/QVa3GM/TG6jZ0pudHnRQXxxJ6DBnN9xsiVXDBbk3KlYA1RPjHUcV2QwZQDlfH+42N6gtTqCtqpbKAIrszbEnIWRuN97oR0sQ9PocoY//eW5zebgsw7c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RerL1LqQ; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747832013; x=1779368013;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Fp9Rcf/JcLX+H96sp1rFmhSVHGL7VIBuNd4YooTySSs=;
  b=RerL1LqQawn0YwJuw/oSZWnlto8T11dhPLB4FVIoIo6xVRdHpQBXMGVw
   xBA11QwibjRBzJCdcSZ/GZSI6FQNQEc61HoJX31U5QYybP5jpjPP/6Xj8
   MCkG8f82bNMMT8xjGCRHtiImAX2JoiAhx2rOB1lop6SFdX9sYR1ecuQ7K
   AyNTXIBya5WY5B+nklz8b2zQbHZJ4sahsaaVu0L6vTjghohNvkEWHomWz
   fACdht1T4lYTw5crwnINy0xeXqLEPt7MPNpAA8KJWcCMQMhCanDDp+Od0
   mmkQ0zwXP5avT85wP/Dk1Ny9ZaIbAfWUaN+UOfaxRqQtDpjPp8Rziz5EW
   g==;
X-CSE-ConnectionGUID: I5kgACTPTDmDxnt8ZYNSpQ==
X-CSE-MsgGUID: R70MPtulSMO+A5IQOWFZCQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11440"; a="49711712"
X-IronPort-AV: E=Sophos;i="6.15,303,1739865600"; 
   d="scan'208";a="49711712"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2025 05:53:32 -0700
X-CSE-ConnectionGUID: dvWGBRNTTcaCQvQSQZ96VQ==
X-CSE-MsgGUID: CO8iRcJwS+eDgOLzhDqmXw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,303,1739865600"; 
   d="scan'208";a="140575748"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2025 05:53:32 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 21 May 2025 05:53:31 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Wed, 21 May 2025 05:53:31 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Wed, 21 May 2025 05:53:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sUTrzHii/OeQL2Y+dZxHfPMkXZaOpk0eyIf99Qp4BGSTM+gznu6NwhwAaUppDuqXTp9Uc3RGWjLFiiwqjTyy/p+upqT0aw4Rb59UQV2g8MnHovhN42stzqhJnywhOfcLx9/a4ClEF5MO4zkrj/dXctY+sP/FoPNOW51P1YbbuWDfJ2IQn7aL2M4WIJewbVU9XbUdPJjwxmWzRk/IckDNdV7g4EBt+mhBE86tAjweM10rtyhNpmtJ4Dk9tQ9IdZlEhCyG7hC6s9YMePPbHGw9Fkb1Q8MV0ZZqkYw926o3r5ewgt+xOwCwRFrkwNZOzh2IMvN78nBbQcKNmcrlVKc1gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bob/xP+uGrXoBq9EopTgLI4By+mVw+IdWgq5y6VOzN4=;
 b=X6balMZ71EAhXBMXqghc85nLg8KwmEqT/5IPa6paGVs+YCBPEOgam6fb+ogI6PsZHuSGUfnvwQHIRs9je73KY5V/giuVIc9tVS6fzOHBtNXKSTwCjXd8sWfltGHSRfB3JKkPZuqTvyFKR3DT2g1wbdnstnP+Xa2Rv3evadCmmHfZfj0BJb8RfeIrNSQsa4hJ5jvq7WTca9kieH6FXJJtEZAlYhSyC1GYh2Y3xF2WqaI5EP7fkTKa5dKbR4ucw3PAIfr+cvflO8LUQJhD7+3ZL/7QBSyYDK2PjnjoegAr83UzM0R6Dbf1FELlXjxxq0UEcavGBqQqj02c86cI0Uf2og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by IA0PR11MB7354.namprd11.prod.outlook.com (2603:10b6:208:434::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Wed, 21 May
 2025 12:53:29 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808%6]) with mapi id 15.20.8699.024; Wed, 21 May 2025
 12:53:28 +0000
Message-ID: <73e378b8-a51a-473a-a8db-c8e989e2ee0a@intel.com>
Date: Wed, 21 May 2025 14:53:22 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [REPOST PATCH net-next] xsk: add missing virtual address
 conversion for page
To: Bui Quang Minh <minhquangbui99@gmail.com>
CC: <netdev@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, "Daniel
 Borkmann" <daniel@iogearbox.net>, "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>, Eric Dumazet
	<edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>, Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	<bpf@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20250521090035.92592-1-minhquangbui99@gmail.com>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <20250521090035.92592-1-minhquangbui99@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1P194CA0041.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:803:3c::30) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|IA0PR11MB7354:EE_
X-MS-Office365-Filtering-Correlation-Id: 9477de6e-34ff-4ac3-a678-08dd98667b94
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OUFiK3l3LzRaeFhRcEMrTkY2MG5BYytsR044N294dkpnUm04YW1KUUs5TWtj?=
 =?utf-8?B?UjZodHRub0FyU2Mwdm4yMjFXNExUcWhQTXNtcStLc2x6dXBHajZuTG9uei9p?=
 =?utf-8?B?WUhUZS9PMCs4M2pwU0UzTFhRdzRVV3EwaUlJVjJRUUR6UFlld0dVR0VCQzNq?=
 =?utf-8?B?ajVoWUc2MFpvUUJ4NlhrYXNuMFBmbDBSRjhNdW5LenRDK1hiVW4xMzY1MEhv?=
 =?utf-8?B?ZVhTYkMyekZhcXlCRUd4QzFZalFTUFE5YTd2UXBYaXViUnZkV24ycUdQdE05?=
 =?utf-8?B?UEhwaXRHdHpEcXJFeUE3LzRFNEpYUUwzU3hubVRpaHdCclVLNjl0VUhmZ1ZD?=
 =?utf-8?B?cmhXblg1cEFxQjd4N3M1NDQweEFxQXIzRkVndmJ3eWFlSHlKS0o2eXFVOXRG?=
 =?utf-8?B?TlB4anNyOUwrbDZZM3g2VDMvTEZSYnloanBmaVpTbDcrOWtLZFlLckh5RW1j?=
 =?utf-8?B?QTc2SThRK3Awbk9qVTZXdzgrc1VsLzJ5ZEU2eXRBazEzMFJqSThnbnR3Z3Ft?=
 =?utf-8?B?Mk13MTRtN1V1MW92S09iQWRMLzl6ZnZsb09nNVNJaVhYN05PaWI3SzVzTlgr?=
 =?utf-8?B?S2xDdW01a3NpKzI1NDV0NlZDMkJBa05lVGEwVEdWMjlFZWVMSElVTHJ5K0VO?=
 =?utf-8?B?Zll2dEVtaDhVaWwvNHBzSDc2azB3NUhlSG0xNkE2dVJRS3o5VXVrVEw4WmdL?=
 =?utf-8?B?TC9tTTg0ZmpVVDdhdVFqN0ZPS0Q4V05IakQ2b3ZZMnJod3Q5Y3NEdUVpVmpY?=
 =?utf-8?B?R2Z6Qnp5MUM1UE1TMjJ1T2k5aFF5ckJDOXd5KytoZHJ1eXQ2cHE4QkVGNTZ0?=
 =?utf-8?B?Y0dBNkxidmFLeGR5ME1aOUFEcllYd2t3dklCaUN6Sjg0ZmtjSTVUTVFkSnlm?=
 =?utf-8?B?YUx5TXFPOHBZWnZ0MGJjRU9XdkZpZkhsdElsRXYwUzFOYXRKZTBnNGRqa0Rz?=
 =?utf-8?B?TjdzNWpuVXc3UjZaa29CNkdtSVU3eDN1TzN2ZGJXN0ZnWVc3cHpXcEtvb2pM?=
 =?utf-8?B?U0NxSU9hSVROeTA4NDlnaUtueXNrcG5pNWp1UEJJWXd5d0pqTjBJckFrK1VB?=
 =?utf-8?B?RXNVbjJXVEZVZHJqK2hTQ2t6RW5XOXMwditISTNHTkUvdGFVV3dKQ0g2dGlB?=
 =?utf-8?B?Q05HRzF6YW9zbW8vcURENVNESDFMMzY0bStCSXl4dTc4MXV3dDgwSkxpNWd4?=
 =?utf-8?B?c3FHQ0xycW91RXRkTzNmbUhrRnBYSkx5eG90eVEwbGRQanJoVTdxUW5ONU4w?=
 =?utf-8?B?VVBDZGU1aTRGbVpSK2VQWDdib3ZNd2tlY09FZUZVdXlSTmthZFVzb0dwTlBL?=
 =?utf-8?B?TFFzdUVuM0NMSFBpN3NPVXdGT0RNS09PcXpjdGlkeUN0eGxuV1ltelYrbEJq?=
 =?utf-8?B?aFBzWXF5SkNyeDZEQU9pdHZwNlBpSWNSTHNkRTlNWUpGK3RWSXBZaDdwTG9H?=
 =?utf-8?B?aVZQMDQ1cGorVlNNYjhSNTlmNU9uVGkxa3dxclpSb0hJMG83N2YxN003TFpU?=
 =?utf-8?B?Z0U4eVYzTTlUbVE5RFNEam1HMkJzNlZsaVlRcVZ2TTVDQVZReGxqSFlFQkQ1?=
 =?utf-8?B?OFRoUWFBWGpQMGlBZ29ZaXh4WHJFZU9PWUJCUzJ3QzlUSnN1SXp3SldyQzFm?=
 =?utf-8?B?dkZVSzFBKzBZS2YwSDNkSForV3VNMmgyNjA3RmwvUHBzN3dVOUJZbHByNHJs?=
 =?utf-8?B?OWJOR0NBeGRTRGR1Y0c0NXhReWVPbTQ3LzRJMWZIK0NpRTlITVNuQjJxNkht?=
 =?utf-8?B?dEljS0dBbUQyMGRCZzI2MkdvS3dlNVFPenA3c3M1cHo3aXJSVXYrbERIdDJu?=
 =?utf-8?B?bHlJSGRrcW1QUzRTdUJMUElvZWpodXZhZldvempvR01mMEprSHNzWEtrYUdV?=
 =?utf-8?B?NkhodGR1VTFwdmtFazY0NDk3Y0lDTm9OclY4N2tmbVpIN0J2eS9yclBTZU5W?=
 =?utf-8?Q?n9dkVl3p4WA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SURtMFRLV0Nrd1dUK3JMY3cwa3RhSnVjc2ZNZzdVeTV2d3ZsVnVmaERvUkJU?=
 =?utf-8?B?YW4vSE9jaVZtQlllQXV0SEJlL2hLN2lqWWZDYW9uamxEeUd3Vi93RlE2SzJm?=
 =?utf-8?B?YjRuSy9PTHhJU0YxS2hKNWtpempHbS9ZR1lReE8vS1B1MktGRE85d1NybG45?=
 =?utf-8?B?clJHUExnVHduTENoRHpSRzJpcW04N0RrVHZCKzFKNk9hTWVHMUZpWExobE9U?=
 =?utf-8?B?bHB4cjNrWHpEZW1GOWFrK01UZTMxQUtMb0c1ZzRDelRVNW9ReWxSdjZxaDYv?=
 =?utf-8?B?VEZPNFN3U3o4dWR1T25VSnBDdDlxbFMrMU9XWURmZlFVOWVUZ09nNWhZL1gy?=
 =?utf-8?B?Tlh3bEdwem1zRlBMNkc0SkxmcGFLNnl0MW1FeFB2S29YUEdVMThKUldIeGhl?=
 =?utf-8?B?YkZaT0RHbmxuKzU3OHlEWko4U1I0SE5XOXdLd3lHVlJ3bWNQMzlhNEpYYnhQ?=
 =?utf-8?B?bTg2UHk5SUtPeVdnMnNmNlJPQXdaaHhNYmhJNzB0VWo0NFJ5Y0YrQkludXhn?=
 =?utf-8?B?NGlPUGF1OWFGL3N6TjNOSFpKNXVwQVNLQlBSYVVTUEQwTklZdjRJYWtrVWN0?=
 =?utf-8?B?bHJKSWx3RGZzSFFGRFFhRHl2ZEVCdXpSbEdzVHU1UHV2MTc1K2kwWm92S2Qz?=
 =?utf-8?B?RDZ5K05Tenl1eUFJSy9KQ0cwT2NMMWpBTmdhbmRVbm9HY1VIN1M4SEF6OHly?=
 =?utf-8?B?VVNyWjFFVGRmWlZ0ZTdPME9JOGV2Znc0WGlsMmtlVnpSTEp5N2tzekhNSEJD?=
 =?utf-8?B?T3V1dzVQOFo5dVU0STd2SXBId2JvbUM1WDc3U05JTkJ2NGh5aVN5emNCSmZB?=
 =?utf-8?B?bytYalJTUzlHazhPT3llSm5mdnhOc0lvSmlBSmJSeFBsTG9DVXYvenhCb1ly?=
 =?utf-8?B?NDdBWFZWdjhOaFp5YWxWdE1RMHRmRTE0cjhhUU81M2ZjN0hBZTcxUG8zSGZU?=
 =?utf-8?B?SFcvMDU2em9JenVwQnZZTEZ5OGtKYmUzK21VNnhqaytCbEJLdzlFd2JiNWRC?=
 =?utf-8?B?YThsUkFDUjZHdHFxeWlab1dPSUpzS3FTcjc2Uk85ckRIcEIxVGxod1VjOG5O?=
 =?utf-8?B?cHhWakZVMWFlQ2xBV1d2MFBKd3hsN1g1N1k0R0tqdUtMNXFpVHpZWHZtYTJn?=
 =?utf-8?B?YkNtdDJJYXdKN1h4M1ZWdWZROTQ1NVpIR0F3L1c2VWZaeEJDZ2pwQ3BnSmNz?=
 =?utf-8?B?aW9QaE50WEVSS2dDNnhma1dZTm53NHg5MEdBM1o1OFFrSENhbWVMaVhVWmFa?=
 =?utf-8?B?SGV2MjZHUUxEL3RMRDVGeHdWYmluMVJRSlJqOXVMeWNjVzNrVThtMXo4ZDlw?=
 =?utf-8?B?d1NPaFJML0VHdVIrV0JpWFFiVjZDZHpNMVo3aFpuQnI0SlhWeVZKNjYyUXlq?=
 =?utf-8?B?cWsrMFMxYVQwMkJTSXlmdS9iNGRWSVdEVW83c3Vod3E5UFhGS05YMVJOcnVF?=
 =?utf-8?B?OW5MdWdyWmxXTHJXaEFMOUZpWHZ2NHptMFFLdkc1R0dKSHhVOWxHMjlmTTVw?=
 =?utf-8?B?S0lpbndZWFJHU0RkVU80eGQvZDd0elcxNmY4cG12andwZXBtanFORXpMNlQy?=
 =?utf-8?B?NnVEOXg5ZEtmY2IwZ1FhTUdOV3N4c2RmdERLcGFxMzhXMFpSTUlBbkNmdlNv?=
 =?utf-8?B?cEwrWjNMVEVUczR4Sk1HUWtOcDdNSG5Bdmd5a0NJcHJXTW9ZR3V2UG9RVVhj?=
 =?utf-8?B?bmE0ajNlaktlN2RpZ1p2SmpBR05ON0N2TW91VUcwdkJSVmpwSXhyVzU4VDFy?=
 =?utf-8?B?Q042eWxpQ1ViMzJDN3MzOVVwNVBjdytCUnZQUno1aHJqQzg2YzVSYTVFWEhx?=
 =?utf-8?B?ak5XcktncHdlSWhLbUJ5WExtZ1lUSE0zVGo1RzZ1WlloN3NVeXdkMHpYT3ZY?=
 =?utf-8?B?R1c2VDJtTlpxN0QxemNrLzZhT2lZZVgxeEttT0xLMkNiOHlpYVg1Yk4wdnh1?=
 =?utf-8?B?ek9vSE11TitkaE5paG1sOTNVdDlOQTYxcWRGQVdUKzRUUVV0SVk5aG4xUzA4?=
 =?utf-8?B?ZjB5NmI3YlFaaWRPdWVCZGFZT0hJc1B5M2w5dU9vQUNsazdJekljYWsySUM3?=
 =?utf-8?B?Q3orKzlHT2xoMDczeDRxazZzSzJ5YUIvOVB1MEM4eTY5ZHpWSXFNSXlKZkZh?=
 =?utf-8?B?c2VqQU92eDNBZlVrQ055Z043MHhSMjdIbFBvaDd5aXVjWStmbFlYYTdndytI?=
 =?utf-8?B?aEE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9477de6e-34ff-4ac3-a678-08dd98667b94
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2025 12:53:28.9106
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z6MsbTmcrktf2D2hcDQwq5zv9zivnmxaMVkUg7J42MdE/Sh3IDAidlvQRKP1bC75fcYN4p0sR4rqt0b8xoWh9+VlurLqlBcIX/nSRtKBVxI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7354
X-OriginatorOrg: intel.com

From: Bui Quang Minh <minhquangbui99@gmail.com>
Date: Wed, 21 May 2025 16:00:35 +0700

> In commit 7ead4405e06f ("xsk: convert xdp_copy_frags_from_zc() to use
> page_pool_dev_alloc()"), when converting from netmem to page, I missed a
> call to page_address() around skb_frag_page(frag) to get the virtual
> address of the page. This commit uses skb_frag_address() helper to fix
> the issue.
> 
> Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>

As for the code, then:

Reviewed-by: Alexander Lobakin <aleksander.lobakin@intel.com>

But you need to add "Fixes:" tag pointing to the commit you mention.

> ---
>  net/core/xdp.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/net/core/xdp.c b/net/core/xdp.c
> index e6f22ba61c1e..491334b9b8be 100644
> --- a/net/core/xdp.c
> +++ b/net/core/xdp.c
> @@ -709,8 +709,7 @@ static noinline bool xdp_copy_frags_from_zc(struct sk_buff *skb,
>  			return false;
>  		}
>  
> -		memcpy(page_address(page) + offset,
> -		       skb_frag_page(frag) + skb_frag_off(frag),
> +		memcpy(page_address(page) + offset, skb_frag_address(frag),
>  		       LARGEST_ALIGN(len));
>  		__skb_fill_page_desc_noacc(sinfo, i, page, offset, len);

Thanks,
Olek

