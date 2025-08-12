Return-Path: <bpf+bounces-65443-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B072B22E53
	for <lists+bpf@lfdr.de>; Tue, 12 Aug 2025 18:53:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1153E16CA2E
	for <lists+bpf@lfdr.de>; Tue, 12 Aug 2025 16:50:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AACF2F8BFC;
	Tue, 12 Aug 2025 16:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZWB2FpNC"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 937F919ABB6;
	Tue, 12 Aug 2025 16:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755017427; cv=fail; b=Ga7/6qLwV7M3nSinbgM5cQ+7/6NgI+bd65Von3Iq5nSAsLrRSkGWrBP/qXZngL0Rh7r8wSckDaebdnUG48bK/JUowJ5nmtrvwWRUGSP/6Jv+PZe6m2/94W/G4TONXVIA1N9Gr65GIZS/GI5qjNlKUVaMQ8zEknfxESWC/F+isyk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755017427; c=relaxed/simple;
	bh=h/M9dNPwFY2cN/IkDW3AqNPMYCX/WhWCxZ7Rt0t3Ydw=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=WkgjzPtvPFKh5mLEZlY3HsxmXDBW9rpKiXbCX3vQ3B4/L6yzRYKLnm8GdVqhzd3DFfqLpwQqMkB80yGw1ttpBb1p9OqQ6IribqCoz9MNvEam/x6Ibv0HGnb9ArPGqtKx6oyeaa7m4ocXzofpzktrQwwHW7MRIeqVqhK0doQ4dY8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZWB2FpNC; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755017425; x=1786553425;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=h/M9dNPwFY2cN/IkDW3AqNPMYCX/WhWCxZ7Rt0t3Ydw=;
  b=ZWB2FpNC39raUR0ImqIJrW+gq7fYABJWf/msXN0Tudzo1YPA4/5tsLwO
   5TrdfoMC48NE3cYH9G9LXvic/12oq3rcZjHTV+/SMaQYLRbKnbvyzg1Qz
   W7mLROnn93FfqjA13eosGuRJH0URaGw1t7/5aFhrevlJ0/rfdShTYD5tC
   2HEFn2dkwjmobLKUUW4sluQskxkcGm/+aGF6sMHEvQN2+mWfFhIGkOInb
   tE5HY/K02bS60To3pFMwdZcFPdpieYLUfnacoYfOLfuuNePqdzcie82j3
   LDK8NBPPw/Ao9szzVQuIj/0/9zVp/PG6hCnKK6taSHHerLqDopsuIyy2Q
   A==;
X-CSE-ConnectionGUID: D7TZXd43RfG95Ao3yeIY0Q==
X-CSE-MsgGUID: NsXVufrzR4WsoP7fojf1gQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11520"; a="57446949"
X-IronPort-AV: E=Sophos;i="6.17,284,1747724400"; 
   d="scan'208";a="57446949"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2025 09:50:24 -0700
X-CSE-ConnectionGUID: xPaLOEhNTH2Z55LFxFBZ+w==
X-CSE-MsgGUID: B29YNpd9R96c1ADzjBBL3w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,284,1747724400"; 
   d="scan'208";a="197099965"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2025 09:50:24 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Tue, 12 Aug 2025 09:50:23 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Tue, 12 Aug 2025 09:50:23 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (40.107.92.81) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Tue, 12 Aug 2025 09:50:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GnrGDemObOo6re+DKBp7Pop05nuAG8cSa4vI6CIaosAFSxm3HCEKaugwsOuBUClTSWs1OVGLJlCw5uWsGoEriF078jkI04OH0DV+4PWu6txRWbUcGGp4cxP6irMG6hOtwDYOS5nGkUvLhiW4EwXoV9ilOZxT3YOWbV18qAAHZPGcuhf85UzuvKADeSMOQWYuLqEVID0Rd4Gj5+meXNcXXW7CNMm0JOKpUrO4GLOLPQeKpLJlbrqJFVnfYuRMxGw1GOTzbyIhuQ+RBBDinHpFRk4BA4K/m8O4A/bCJeD07MHrKIUVvx2Ir4/8w7cYPATR2t3ECQ/LiPMsD0NmhUVKdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UnujoV3phMPbywS99YEQ4ISN/pGJf9sXXHpuB00RkvM=;
 b=npkvRPKfxOfzyc9zDa43bXgaDZIRxCpUhLOyBa6crESyn0aNAWJbQCCTyZAwE5psIMnNEMHqemFRPIdA6dnSkjEMt/36RI8MyQsQyWh+u/+AbGTTrZc1vuvAhMvyZ8u7W7sKqPpZTb0sl/o/YNkUFYKII8bo5TXJYvCESIvGj6d1c1yCsUZejmUhABbQgZ13SLaYYRo6+L53+7MBFzNF4q40TWNUUZHifdsiNEa3Rw2wuz10FopdesFFjsSuCH5bMCEokbsX6Zyt6cjAGd9P3v3ikC/z+aiEtN8my3CKyTOZcp9cjymXYHkSFjdHB9coQRt/6SDYpvBcGX+tM2a0yA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by SA1PR11MB6822.namprd11.prod.outlook.com (2603:10b6:806:29f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.21; Tue, 12 Aug
 2025 16:50:20 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808%6]) with mapi id 15.20.9031.012; Tue, 12 Aug 2025
 16:50:20 +0000
Message-ID: <46470d2b-4828-48ad-a94e-9d874de1b2fc@intel.com>
Date: Tue, 12 Aug 2025 18:48:25 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] xdp: pass flags to xdp_update_skb_shared_info() directly
To: Jakub Kicinski <kuba@kernel.org>
CC: <netdev@vger.kernel.org>, <bpf@vger.kernel.org>, <ast@kernel.org>,
	<daniel@iogearbox.net>, <hawk@kernel.org>, <lorenzo@kernel.org>,
	<toke@redhat.com>, <john.fastabend@gmail.com>, <sdf@fomichev.me>,
	<michael.chan@broadcom.com>, <anthony.l.nguyen@intel.com>,
	<przemyslaw.kitszel@intel.com>, <marcin.s.wojtas@gmail.com>,
	<tariqt@nvidia.com>, <mbloch@nvidia.com>, <eperezma@redhat.com>
References: <20250812161528.835855-1-kuba@kernel.org>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <20250812161528.835855-1-kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU2PR04CA0026.eurprd04.prod.outlook.com
 (2603:10a6:10:3b::31) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|SA1PR11MB6822:EE_
X-MS-Office365-Filtering-Correlation-Id: 324019d8-980a-41cb-4d3f-08ddd9c052b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NzJwTCswUG8wVjBzRGtlbVQvYWNUS3RwZ1NMQnB1bERXcmNUNUlJTW5ENnpm?=
 =?utf-8?B?SXkzRXZCYkc0R284S1ZVY0pqbDNONU9acDVEcURlWlBwRGpKSEVuUndhVGtT?=
 =?utf-8?B?MGsxdGN0NTJIaENxQ09vOWFtNlF1UCtuZm8zT056U1Bpem9QZWFmTmRUSXRO?=
 =?utf-8?B?L1N3ZlZ1VlNRaXZTUk8wVWpGM1h6OXA5VHRUMzJuK1FtcDJxL2Ruell1b3NM?=
 =?utf-8?B?Y2lsMTJHZEhQRGsxZnE5NXJxRnZadEIzVkxubTBpMmRCWUF4RjkzcWo5QnRv?=
 =?utf-8?B?QlViaWVoSGU5R3RKU0M0a0xBUDh2QTJJNkcxSzlENHNicjc4bmNLTklCS1BX?=
 =?utf-8?B?cG5lUFJyMythMUE5VDhOTlJ1cmRQTGp0dnp4diszZWVDWXBkMUFGUzlNZEZu?=
 =?utf-8?B?ckFZNjRjOGl2VzIyKzFTclIrVVB3U2pkSVFtbFVhS3cwYllrWHlFSVI5VlQw?=
 =?utf-8?B?Y2hqdUtsZEYxQXFVdmJUR2wybmV1c3U3ZERZNi9lTGZ3Vm9ia0ZDNmM0MS95?=
 =?utf-8?B?UTdCUHJISHpWNXVuMHdhSlo4OUNWRWFUZlA1UkJkeE1XSm4vZ1ZPZnNTTmg3?=
 =?utf-8?B?NDlpV0ljY1FtRk9nWXpUUmR3TWdSVzg0Z2tUNG8rRC9ZNmJZSUtqZXh3NDl6?=
 =?utf-8?B?dDR0RXpZTjV1eDFQQlB4TWlTYy9ldEpEYVFBSU4vakxEWHVpVGwzUzAvbVNR?=
 =?utf-8?B?ZXIwSm01L2pXRjFlZm9TcWQ4TTlZMlMxUnp5R3BIcmVlTm9qYW1HUWtFbUMv?=
 =?utf-8?B?RW1BbGFicXZzMUc1RkQ0VVUvRVRha05sWCtKUkdUZXVrWjFQbEhQNmI5OS9y?=
 =?utf-8?B?SEp2MzZHbDlvQTN3dzJqQ0E0S1A3WHI1b05TM3ZDWHVKVkpUdnM2VHh5RE9J?=
 =?utf-8?B?ZWdhdUVNNFk2MnFBZFVpQUErQXVVME9uN3lSYmR4ZWorSGowRWZKTjNMSUND?=
 =?utf-8?B?SnRkK2V4MlhsWThoZVd6aDFHRStVdDh5VU5xazdscmdPQTN1eTRJc1FaMWhk?=
 =?utf-8?B?ZXNCODFDSlJyelpRaTR5T3Z2NFV4cHNqbUVJR2xMc1JJQy9UeTdLQmJsVmRn?=
 =?utf-8?B?d2FhZmdhbnN0emY2S1hLajBGWHZhWkptTUUzSUtlcHlyeHRCWSs3RVpzNFRh?=
 =?utf-8?B?eGRDNGxUWkZLeWhLMDF2YytBYlp1RHkwaGlBYXMyVUtOZjRHT2hvazZzaGR3?=
 =?utf-8?B?dVQwWjFHeXVxdE9aMHl5all1ZTVpdzNZNjY2cTVOSHFFN1NKUlpMU0E4Q0pI?=
 =?utf-8?B?M3ZYMTFnSnVXazZWdWRkNmJ3NFZvay9oRTNpMHRESUJwZ3hUeXpNNFJ3M3Ew?=
 =?utf-8?B?TFh0Z2Zaa3lGdlg5dzMvekJYRE05dUFoVU1XdFVUUURxeHBSd0RKZFdMNFJJ?=
 =?utf-8?B?c05ZQ2FvZ0VkWWdNK0c1V3g2emZRUldNQWU2RGVjNVBlaHJMdndvVmowNEE4?=
 =?utf-8?B?aEQvUzArUzlIK29HdXRZdzR0RytuNjExWHdIZkZJS3dic29BOW13aEZlUEVH?=
 =?utf-8?B?Vnp5TDcxZkE5MVhrMmI1eXZhSlNwMVc3Q3lQZGFEWXkyRU5CNCsydjJMYThq?=
 =?utf-8?B?SW8zd1F0YkQzY1A4SGNxUWVSWnJZY3NnOTFWMTZqMTdtZU9GQndzZWg2ZkU3?=
 =?utf-8?B?UTdFNDZNcGlIVzExQlVuMlI0WG5DQys3RVpDa0VmMXhLT1lCalRpZ080M0c5?=
 =?utf-8?B?c3oxRjVYMVZjNGVkTXVZTU01QklEOTZBWVpPeFU3WTRNd1R6UnR6NVVYbUVY?=
 =?utf-8?B?YkF0aXlza3lyWXV4VERlWVEvY0F1MktHTlhRVWErVk03UW5UUk5XNEYxVEZq?=
 =?utf-8?B?OVNoYTlyRUQzejNCcVZjY0hySkFVdlNLbklrZzZCODdKRlFONGJRNGNYVytT?=
 =?utf-8?B?T0JucnMvbzVET2V0M0xrakV6TVU3U2dUMXZqbmYvVG93ekRWTkRDR0hqOXBF?=
 =?utf-8?Q?zm5cicudjaY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RnlVc2Y2WWtXcnZGbjVIWVFvTlQxNkNuZWhWMm1iUWI1NlZiSkVFdmhkSWVE?=
 =?utf-8?B?azkwenZyQjNZM3J4RXRSNVlSbVdwL3FRY2ZlTmRXdytpTmtnYU9ydCt0b2xv?=
 =?utf-8?B?R0tPazBYRDdpSXRFTEZiL3NXZzlkU3Blcy9IUkFvWTdqNEhTelR3anF5Q0FK?=
 =?utf-8?B?SWZIWVpDQ3l1VzkrTlN1Y0pjMzNGTVg2R3dDbW5DYWlFMkowekhScWVUcncw?=
 =?utf-8?B?SDg0Nm1UcnIvSXAwMm1Cd0Q3M2ZFdnRYMVZTYk1jci9HWVdVSTREQ3RwbHA0?=
 =?utf-8?B?SlR5eHFIVjA3c01hMkthcktHVkFPMXRFN0hzWGtrZFBaeHkrdmMvczNsTHJt?=
 =?utf-8?B?OTR5KzFGRWpLY09ReGhhZHZRVTVFc1VPYmFidmZkNGRvRzlteHpxNEt4U0E4?=
 =?utf-8?B?ZW9nY1J1TVF5ekFTYjYwNjk1eHpRdVBFVENVaitFS3RxMWlFSW8yUlhtMGIz?=
 =?utf-8?B?L0diLy90SmhhQm5aYmVKbmJGRk1CYUdScmc1b0wyekgvYXVTeGlYOTJEWmli?=
 =?utf-8?B?QktOWkV2cWI0QkYyTmZiMVFYaXovRW5GWFZSUHFpb0lKSnFocDVUKzlDUWdW?=
 =?utf-8?B?dnRJQ1doV3NTdnhSTEkyVFlTaEgwZEVYMDNlNEdndlE1REZsam8zT2hCV285?=
 =?utf-8?B?RGRqQ0pIR25NZUZFVGtRUXNIMUpNc1BIN1lxaE1MZmEzQjBTQnpFZHZYNlY4?=
 =?utf-8?B?a0hTV3NpMndWa0Z2Tzk1aVJMSmJkblRjQlQzeVJML2c0eGlVblgxYUEyV0Fm?=
 =?utf-8?B?QTRqNlNnb1VEUEV1NlNvTFN5blJtL1d5cmlPSTd2a1RLclViVENvZU8yaFhU?=
 =?utf-8?B?aUp4dnlUR3ZQTExnbkgwN1BrN1JKNldqdUZFanljQnJWcDQ5Y1Q2b25PTWR5?=
 =?utf-8?B?NnB6RFVqUUFuMjhqZk05elFIeDg4T2FvNjFLQStVRTh3TGVudVR3OUJ1NVNo?=
 =?utf-8?B?NWdPbGl6MXFoMktUWFNZbWZKRTV3NmVyMkxTMHRoTVZIYzYwdFlPOTZ0R2xs?=
 =?utf-8?B?TUF5Mkg3V1ByZlpRTE5rMlRQYzFEb1lONktaNVpXdE9GNE05Qld5UHFLeDVq?=
 =?utf-8?B?SHp5djd5V1lDNmIzY2c4bW1rQ2QwcXBTOXdlb1Z2ZnhoakJOUnFKa1lhbVIv?=
 =?utf-8?B?ZEoyOG9LQkg4SVhVZjY5TWw1bFE3TW91T0FWcVZ2amxPdHhGaW4zUEpRajRx?=
 =?utf-8?B?WDdjU2hTd05jRmZVWTBMY1hiRk1BZ3F6S0gwUG53U2hPeTMxbVI0cm8vdHZJ?=
 =?utf-8?B?WC93Ry8zWjlPUFdMMUh5L2t6VWdFcmoydW1HL3VjNVQ1MDgvaDU0RlhlL0Fy?=
 =?utf-8?B?RjRNR2VlUHovUk5MY0RMb2tmRkNoWmtVNmJ2R0paNkNia2U4MDFwUElrRzBW?=
 =?utf-8?B?WURZVDhTSG8xVlVJcnJ5dXhoS1FGbGtMQjBSeXpkcC9kRWREOUxOdlVrOUFq?=
 =?utf-8?B?RDh6SXArY01TanlvYW9TN0Y2azZ4cnpGeTJER1ArTzVBMjJOczdxV0ZOSnc4?=
 =?utf-8?B?STVEVlhWdUtGT3FqYnJmcENJUG83ZDVhbUoxZURhcmJhVmg0aEV4b1lUQlh2?=
 =?utf-8?B?TzFFQU0yd0x2UEZ6djJSbytWRXBka0FBQXloaitpbFRsbllaSDF1ME5jcWpp?=
 =?utf-8?B?QnVFYWV1ZlNWSFJ1Rko0VkNzRzQzSDNkTndQMVJBdWNrZXBDOXhsVzBaUFpl?=
 =?utf-8?B?d2pNVHNqYXZaUitwQUcrZSs2TXBtOVowZmRjMmF3RGFkUFlicHBWckV6TTZw?=
 =?utf-8?B?aXdhNEhFcmFqNW9hS1ZRdXZWMGpUMGUyYWxjUEJGVHR0Zkp5S3JkWk1KVmYz?=
 =?utf-8?B?THVBRlhTYmMvbkkxMzdxWDJsZEl5TTE4UmpYMk5XUzhsTGdhTTdkQ2hpWWg2?=
 =?utf-8?B?TUw1Wk5jbXNQeitHUUUvREdoU2EyZDVvVEhSZmkybHYzaWZaSDE1T1JnNC9y?=
 =?utf-8?B?YVhQa2FQOTlmckcybnRyTkpJTjdtQ0lyRS85NlJ2YzhaaGVqbUt4UWZCYWRj?=
 =?utf-8?B?VGJydVFGUWsyQkZod1MzZTFpdnp4S0huajB0V0I3dGtoQ0tZazhKNnFUU3JN?=
 =?utf-8?B?UUE1MWhmbzUvV2JmNGNVbEJPTDZ5VFAvWlNYWlhoQVBJa0FsOUc0a0NtR1Jw?=
 =?utf-8?B?ZTdMT0t2OW54OVMvM05yOXZQSTh6WjhVb1FGSy9wZEpac2QyaWtwTjRHTlFu?=
 =?utf-8?B?SlE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 324019d8-980a-41cb-4d3f-08ddd9c052b4
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2025 16:50:20.4156
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Cy69b1GvsFs/C/aqKJo66xZe3IbdAqcjQ8lNqsdY3MutY8/KuYyd9wLl4napOt5cGBN7if9HUjWffHujIK3zV7g5EQZmzZmnboH2nEBDI80=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6822
X-OriginatorOrg: intel.com

From: Jakub Kicinski <kuba@kernel.org>
Date: Tue, 12 Aug 2025 09:15:28 -0700

> xdp_update_skb_shared_info() needs to update skb state which
> was maintained in xdp_buff / frame. Pass full flags into it,
> instead of breaking it out bit by bit. We will need to add
> a bit for unreadable frags (even tho XDP doesn't support
> those the driver paths may be common), at which point almost
> all call sites would become:
> 
>     xdp_update_skb_shared_info(skb, num_frags,
>                                sinfo->xdp_frags_size,
>                                MY_PAGE_SIZE * num_frags,
>                                xdp_buff_is_frag_pfmemalloc(xdp),
>                                xdp_buff_is_frag_unreadable(xdp));

Yeah I think this doesn't make sense, it just doesn't scale. We can make
more flags in future and adding a new argument for each is not a good
idea, even if more drivers would switch to generic
xdp_build_skb_from_buff().

> 
> Keep a helper for accessing the flags, in case we need to
> transform them somehow in the future (e.g. to cover up xdp_buff
> vs xdp_frame differences).
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> Does anyone prefer the current form of the API, or can we change
> as prosposed?
> 
> Bonus question: while Im messing with this API could I rename
> xdp_update_skb_shared_info()? Maybe to xdp_update_skb_state() ?
> Not sure why the function name has "shared_info" when most of
> what it updates is skb fields.

I can only suspect that the author decided to name it this way due to
that it's only used when xdp_buff has frags (and frags are in shinfo).
But I agree it's not the best choice. xdp_update_skb_state() sounds fine
to me, but given that it's all about frags, maybe something like
xdp_update_skb_frags_info/state() or so?

> 
> CC: ast@kernel.org
> CC: daniel@iogearbox.net
> CC: hawk@kernel.org
> CC: lorenzo@kernel.org
> CC: toke@redhat.com
> CC: john.fastabend@gmail.com
> CC: sdf@fomichev.me
> CC: michael.chan@broadcom.com
> CC: anthony.l.nguyen@intel.com
> CC: przemyslaw.kitszel@intel.com
> CC: marcin.s.wojtas@gmail.com
> CC: tariqt@nvidia.com
> CC: mbloch@nvidia.com
> CC: eperezma@redhat.com
> CC: bpf@vger.kernel.org
> ---
>  include/net/xdp.h                             | 21 +++++++++----------
>  drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c |  2 +-
>  drivers/net/ethernet/intel/i40e/i40e_txrx.c   |  4 ++--
>  drivers/net/ethernet/intel/ice/ice_txrx.c     |  4 ++--
>  drivers/net/ethernet/marvell/mvneta.c         |  2 +-
>  .../net/ethernet/mellanox/mlx5/core/en_rx.c   |  7 +++----
>  drivers/net/virtio_net.c                      |  2 +-
>  net/core/xdp.c                                | 11 +++++-----
>  8 files changed, 26 insertions(+), 27 deletions(-)

Thanks,
Olek

