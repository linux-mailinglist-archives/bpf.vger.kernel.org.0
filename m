Return-Path: <bpf+bounces-37655-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C7B3F95904C
	for <lists+bpf@lfdr.de>; Wed, 21 Aug 2024 00:12:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 004D41C20B58
	for <lists+bpf@lfdr.de>; Tue, 20 Aug 2024 22:12:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 958021C7B6B;
	Tue, 20 Aug 2024 22:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Cnsg41fN"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 825CC1E86E;
	Tue, 20 Aug 2024 22:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724191949; cv=fail; b=HV4w2ozDwSvG6aMDRr2E7xIJyY/KLlzHysl8godind+JJ+EjPONzoc/WHehHuQ5wEwegUR/3IbZ0RsawQMCMn1dACUSiX9GzHYUFUUFpTqrKeyW4Mj4dnmNfggTs7bpQJRhf+LJfqg2KN4cOy9sm3X1IRFQO/brL6u3eoCKIatw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724191949; c=relaxed/simple;
	bh=K0yaXGRtHl/UsxhAI21mRLm9KUMz2kd0QxSkLPDDAlc=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=IO0f6iEoxEXiVaqAtKR0XMcs8aGGqzFqDeyHDeey0To16YrErfEisfrEq+Z4CVqz8tpXx+/pwxPMpZzoINLEK2Rtnv7CY6k4MC+ILBRpCyjQP/L5oaxwsK6kMRqg/3CcBagSfIws/B1vlxY30adMok/ToF3hnPAbGqF8MoLrJX8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Cnsg41fN; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724191947; x=1755727947;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=K0yaXGRtHl/UsxhAI21mRLm9KUMz2kd0QxSkLPDDAlc=;
  b=Cnsg41fNXpZ7vtQyZ0rqfOwyvsD/gQp1S+BnlBzqFM2KG6JZ3winXydv
   GCdKzqe9XTgnYHagQPLdURkaHP/si8fxcF35/6Jk2HlWnxRTfgperdByT
   f8vwR/IISa9MawYlhrT55DryPCr6YVRs/H5rfT5oh2wiSROMx8rZsxMU4
   HUxn95yGMeA+bjiSqjsmSnqOrJyx2cvtA1zelLyKvbRFl3EQo8UMYxJrJ
   jCgQN5wICcpPoo1WAdph4p0vmMxwuNol73SdjWNlV4k+MF1ytxv/SNnpm
   ehIW86BVex18doSjjjnDpB0+7adx0kX87GCxu3zw8SckXh3sN3fvytC1Z
   A==;
X-CSE-ConnectionGUID: i2Sxdz8VTji7hZLgWGLy1A==
X-CSE-MsgGUID: Xu4HCIXqSFy3CHvponUhTQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11170"; a="26324494"
X-IronPort-AV: E=Sophos;i="6.10,163,1719903600"; 
   d="scan'208";a="26324494"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2024 15:12:26 -0700
X-CSE-ConnectionGUID: 0VKgrZldQiSEsWsM28tlVg==
X-CSE-MsgGUID: S2R2KipJRl2bYvxf6C+/5A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,163,1719903600"; 
   d="scan'208";a="60583679"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Aug 2024 15:12:25 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 20 Aug 2024 15:12:24 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 20 Aug 2024 15:12:24 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 20 Aug 2024 15:12:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TF/msEMu1aRTQ+xgfw/1FU/p1+njQ16tzsmcJZPcNYPZEoh0o5cuQSAhjbjUiaHE4vGi1D9qa8W6FQwE+CLiT0K7Btz4f0vnw0srMOvlN25QGx+4Dzq9nLy/wFPtnz7kch0bn2975Jedz909MMW2bZcAFjcE09Euvm1R8xNGRwpmiEOQLGs631N4SwcLXZB3sDNLwH9bmuSbNSa/ZB9FiFaZg7h9yLguCYWAu8Co+zwIDfxHIX+ImDdCGP5Z0BROennT79LxW/EE89S8jVK3IVBXUP4vO8samq+04FcZqgGgHLkOLRlBEfupVYdbQf6dRraDucpXEDzyXHUsjVCKMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9AiW2ejMtPBXPBERyj7BoR4/hhv56OVl2S5odoAkTr0=;
 b=bHT2dKuDX3YwFOhCxEXKx1VITLTzvFjhP/qZdp+sYTaz79B96hP4OaZEd7NBpze5heTz3CJZFIDLK/xsDgk9XlVRLDdBXGEdnbKoc62guLTsBlkm/4OUJHTxd/A0q7JNpD6DXeeseozo/Nkc1ko0Ty2iprXX2z4jV31NpHxWsdR6E825mT74JCRcf+KQfTEIsa2YuqZiv8mcC3wwc2c81X2qGC8T8zCGZrmAQjzHHct7Easi276TKfQ218BbwR+Xon9cfREToaLroO1wj1yJ1POwn8Y5eTgTozMJ8cydVt5f1KER2NGVg3YypIWlNKgCTWJuALs/iX8JnlGEBEERcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by SA0PR11MB4526.namprd11.prod.outlook.com (2603:10b6:806:96::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Tue, 20 Aug
 2024 22:12:22 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%2]) with mapi id 15.20.7875.023; Tue, 20 Aug 2024
 22:12:22 +0000
Message-ID: <91b5e7da-ec4e-40f8-908f-faf7082b2f63@intel.com>
Date: Tue, 20 Aug 2024 15:12:20 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 3/4] ice: fix truesize operations for PAGE_SIZE >=
 8192
To: Tony Nguyen <anthony.l.nguyen@intel.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<netdev@vger.kernel.org>
CC: Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	<magnus.karlsson@intel.com>, <ast@kernel.org>, <daniel@iogearbox.net>,
	<hawk@kernel.org>, <john.fastabend@gmail.com>, <bpf@vger.kernel.org>, "Luiz
 Capitulino" <luizcap@redhat.com>, Chandan Kumar Rout
	<chandanx.rout@intel.com>
References: <20240820215620.1245310-1-anthony.l.nguyen@intel.com>
 <20240820215620.1245310-4-anthony.l.nguyen@intel.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20240820215620.1245310-4-anthony.l.nguyen@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR10CA0023.namprd10.prod.outlook.com
 (2603:10b6:a03:255::28) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|SA0PR11MB4526:EE_
X-MS-Office365-Filtering-Correlation-Id: c7c721f8-93c0-4577-01a0-08dcc1652a4c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dlBDa1VSTkc4dWorbWh3MG55MXRPR1FJbEZxNVBHc21CQ2dMYm1ucFdVVUpZ?=
 =?utf-8?B?S1ppOWNxRGlFWFFkSHhmMTFNaTVvRXZiclZoS094OUhqeEdzdmhoOTJyYTRr?=
 =?utf-8?B?eG15VkF0OHRYQmloSVRKV0gzaURVKzlsQis4Um5WV0JWTWtreGZxaTJ1UkNx?=
 =?utf-8?B?SXJ2dHp1Y2l2UjR5ZllxdWhWRXVmTTU4MW13bVNGT1hLK2ErUHRsdWt2Q2ds?=
 =?utf-8?B?Rm0xVHpNcE56cXYzL213K0FZS1RzT0I0eVpwdndzN3B0bVBIOVA5TXRSbnFY?=
 =?utf-8?B?MEI4by9PdlRHYlJwWW13bjFtZTd4QVB4MGNkODRmMmZ6bVF2bFhJUUFpdng4?=
 =?utf-8?B?U2ZnTkhjUnJ1M3llMUxWZkNwdVJkTyszYlllVzR6MEMyM1U3TGNjbytNN0V2?=
 =?utf-8?B?ayt5TS90YXBaT21iU2J4M0xyMkc5MytRdGtLUlRndE5CS3dtV2E2S2xNUVps?=
 =?utf-8?B?cWM0TmFxQ1lBS1p0UkxpWjJyTXVPdFpDbVd2Y3BvZ2Z4TEdQZlNVWUdQdW1t?=
 =?utf-8?B?VTNlM0F0VG1GSFJ4Y1d6d2twblN5UHhwK3UvV1dzdEIvR2MraDlmejRHSFR6?=
 =?utf-8?B?ZnZmaFNySDlCWjdveUNINzhYampBcG83c2VOdW96bkpKV3hDS0VUVk9zOXEz?=
 =?utf-8?B?Yk83SVVtYkNZa1pkd0s4WmZaVWQ1K1pZblZWQTlNbGJjTGtMSU5oWDZaZC9F?=
 =?utf-8?B?SUpVZmN3T0JHOEJxUWI1TmpyaGt4L1RiQVdaVTIyZjVJbnBEbjdqQnMwMlFB?=
 =?utf-8?B?aFkzQmxSbDRhWmFaSEdPNVlPY2pvZTR3R2FEZVpodzE2bXFGSGdHYWk1VmVy?=
 =?utf-8?B?T0pubGNRdkdVempkcmcvZnRBLzFpRnUzS0Fkc05FRWE0OUVUeG9UN2JhaFQr?=
 =?utf-8?B?ZmxBdmZZRUlIeGl4MkV4TWlmU0wxWjNzN1kzTWhVZ09LZzExZk9kZU10N2pw?=
 =?utf-8?B?T3lJOGtLWGltZnBMYVlGT2ZNUTQvU1dTdHlQV2l4YzZXNERqMzRYSzhkUS9P?=
 =?utf-8?B?R09uZkNiZXZOUEdxVE5zRENUVVUvNXlSYUx3WXdIK2pLZGJWRXFyOFVCU0NN?=
 =?utf-8?B?eGZ1NjR0dWsyU2pQbHl5WDZTYWZMUHVqei93Y2x6dVJIalYyOE5GM2ZhcFFj?=
 =?utf-8?B?NUl1NEkrMkFaUU1pbk4xWkJxMGZPTVVuZXJ3emltNlBJZXBIdW5lRFBzcFhO?=
 =?utf-8?B?ck54Tkg3UURYcU1QbzdrQjNUdEpLNkxvMWFJaC9EdlE1MTY1VExHN08zRGtB?=
 =?utf-8?B?bHRLejBHMUtsTXN2emtrZUc4RjFFNmdaR0tCaVNFbUVoV0poWEsvemdMNzNW?=
 =?utf-8?B?MFdmeVViNHF6dGNqc2FUdWpqY01sME1vZHhKa3IzZXFLdi9ZNXNMN0JJQ3FG?=
 =?utf-8?B?eHZTZ21lQWFMU01va3VpN29rb2ozeTBmanRjUUdkcmhIZXVNZkV6MkxNa3J2?=
 =?utf-8?B?ZHkwV3hIVUtkZjhMdzgxb0tPMGpMbTZFWldGRFhGUFRvTGZzVWV5eXAyQ3dV?=
 =?utf-8?B?SnZaaVVuUGozRm5ENWVmWDhGRnNUSjU1bU9EL1Zzd1c4NENtWVZEU25GbVdz?=
 =?utf-8?B?L1ZpS0tJYVBOakw1U3IyV2RBZEZzVnAvY2VjQVBHYVlGTDNld0V6NFZUOEp1?=
 =?utf-8?B?cTNCWmNVMmlvM2sxSjBMeUIxc2hPYlZ1RFBDMVdwVDgxS040RU5xdWM0eWlE?=
 =?utf-8?B?OFhlN3BwLzJYbWFWZVVaemZwTXIrZWV5ZXpERVMvcWlOak1ZRVlFZDVYdDRW?=
 =?utf-8?Q?XxdXnQC6V2BGhtAMw0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UjU0VXgxMUswNCtwVTJwVllzNWlHYmlCdkozbjB0U3hHVktDOG1lTlV3MElB?=
 =?utf-8?B?cWJsRGlXNktCQ3Q3Yk1jUFNwVjB1TElWaXR2eE9nZGtRaHAzZjNTb1lqdDFi?=
 =?utf-8?B?MmhudlovdnU3SkpHZFB2THlLajBScEU5bFV6cFFkWHdNSnlkY0ZQTDFGUEhP?=
 =?utf-8?B?QXVnQllnK1dZbU5LNDdxTTIzaW0zRnE2cEkzTjJuNDNWeU1zZS9QZDA5ZEZV?=
 =?utf-8?B?eS9SYTNtaENiaWRyZDJVNU0vR25nSzBZOG5WZDVZc21xREFXMjRuYVk4MVZ6?=
 =?utf-8?B?azFpcXlWUlBvK05aWFVIbXVJTjdSdXdMMTdDRjJvNmVpZDNGczBKZ0hYWGhK?=
 =?utf-8?B?QWtITnpVN0VTNzlWZkNHMk5qcUxRcXEzU1Vhd3BNY0E5RkRtRUdZV2c0a2xZ?=
 =?utf-8?B?SEl3MTlPaVBCakFEOWF3YTVJQ2tHZCtMNm1WSXlzZGpELzlFU0JuSDZ1Z2dw?=
 =?utf-8?B?a0tsWm9TbUVDT1paa1grR0pKdVhCaFZoUVk2ei9lNzRsL0FlTkZZMTJTaWx2?=
 =?utf-8?B?ZXZQWHg1NG9KUHM3S3VDOHJ0OERMTFJFeWZxU3F6aEY1UzZ1bjJHK3kvQnlv?=
 =?utf-8?B?VU5sMlFVSHVJclR1WnpVbk5hR09kM3hhMEozb3R5eUNtT1hDQmpxcDhXZm9O?=
 =?utf-8?B?czMxckgwVzZLdW53L2Y3VjNqQ1hEaERaZTBJSFJ0Q1doYk1MODNrZnZFblpK?=
 =?utf-8?B?Z2xWTWg0b0tSTjBzUlNta1k0ajdmY2FoUWo3MXpFa09CSFR1VEF4dG9IOEd2?=
 =?utf-8?B?cXB3eURObVRzU2tpdlRhMjBQaWxzQ3doM0F1TGlkRnQvODhsSTBkM3VxWTBN?=
 =?utf-8?B?U0FORzNHQnVmOW9QaWhzWE5ZU0dkQUYwTk5wd2NTVzZoeWhDS2QvS29jK1c1?=
 =?utf-8?B?ZXFkK204VTFJZnROQTYyR2xMT0RYcDdUOHpWelFUZ2d5UjlYWXdET2dENWkz?=
 =?utf-8?B?RGs1TkI2Qk90dTVrdXAzcXM4cHd5WklJbDc5YlNWY1RuTWZCM2ZxR2ZFcVhs?=
 =?utf-8?B?QTJ3RW9QWm0rc0hhRDlkU1A2Z2MrMnplcVpuR2xCQ0xaeXNMRTJqNU0yeVl0?=
 =?utf-8?B?Y3puQk1rcFpWSGp4ZHhkN3JxUzdHRVhSSGZCdDBSamNBdWJibHNlRHJiaUhG?=
 =?utf-8?B?di9KVWlXU21hbkl3SGszakJ4VHN6UHVKWHNkOFBNYTZHZEh1TXd3V09QYW1K?=
 =?utf-8?B?Q0t6TGhRWU9nZXd1dU1TYlQyMVNPdkhKZ2lYKzQxVGQvaUVML2pJektLdFh1?=
 =?utf-8?B?NTFZTG1CUHVHa0QxQjNORzJlTVZVYnptc0RlVFhkVzdFRi9xT2ptc2ZhcTNv?=
 =?utf-8?B?elhVckg5VXJTUWJ6VGF1d0pZTTI1aGZPOG5aOHI1a1p4dk85SjJxQkhta3Jr?=
 =?utf-8?B?bCsxS3J3YzBvYWdlWi9TcVRyRUlkanNzQ1FBdVRrNEJ4REdxU29sc0lwb0Ns?=
 =?utf-8?B?Sk9PQzQyWG9GSkYxS1dZdVkzUGRTVzFEaExkTW1GcUQyVmkrdFBsM05tbThF?=
 =?utf-8?B?QkFxcVNkS2hMd2JIc2FKWERsbmN1aHNWVGRVR1oxRzA5TGhLQVpKTms3Z0Ur?=
 =?utf-8?B?STYya09TMlY5ZmV5LzVyRGd5RlkvTTljSFAwUy9XbjdTZjdHZis1eFZudTNI?=
 =?utf-8?B?M21wRmd3UW1OL2NoeGoxMWYvbkVEdisyT1BlNCt3R1VCbDlBL1puYUdmbFpM?=
 =?utf-8?B?emhjcFFrYWVqcDVUbmFoOGM4ejZFWUgxa3FRbEo1a2xhSCtnQ3VrekRIWGFa?=
 =?utf-8?B?eXBaWVR1TGVyYThZNmxBdkRncVF0cWNaczRjaFEvaGVjZnJNRW5pMmxMRnF0?=
 =?utf-8?B?dldtd1lHZUlodWF5LzIrNHVXUGNoaUNDeEoySHBiNmpzM2ZndmNiSnEyVk9m?=
 =?utf-8?B?TmlXZkplWU9lbERISWhvZVVIMVBOaUVaMnh1YjhpdjQram5ieERyWVVIR2tH?=
 =?utf-8?B?YTMzVVNlK2wrTitmdGtmdlcvb3g4UHFoSWttTGJvTkp3dWw4eHRLQlpMaCtw?=
 =?utf-8?B?aGJCV3lwNW9UR1pCenQ2R1hGdkFPTXRJVzcxOTcyZUo2b0d3RXE0ejUyOFJC?=
 =?utf-8?B?dFJCVjZMc0dCUU1INDZlWTFxdGVxSVlpemFzMk95S1dyY0daTGNYckxiWTdj?=
 =?utf-8?B?T1U4dEN2VVdic3podVlYUW8rUm5OTWM5OUpudHFpMkJiZjRmc0dQNmRnQ1Z3?=
 =?utf-8?B?alE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c7c721f8-93c0-4577-01a0-08dcc1652a4c
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2024 22:12:22.6310
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x0IFyd/dnzFntIC6YftOjFoZMisjC3EwZ2x34G6ahiBMdsf7tlQOumOLf3qiws/UjjqYxAI9zYrMRbnP81uG17hgJkJm72syJvWU1eeiJYc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4526
X-OriginatorOrg: intel.com



On 8/20/2024 2:56 PM, Tony Nguyen wrote:
> From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> 
> When working on multi-buffer packet on arch that has PAGE_SIZE >= 8192,
> truesize is calculated and stored in xdp_buff::frame_sz per each
> processed Rx buffer. This means that frame_sz will contain the truesize
> based on last received buffer, but commit 1dc1a7e7f410 ("ice:
> Centrallize Rx buffer recycling") assumed this value will be constant
> for each buffer, which breaks the page recycling scheme and mess up the
> way we update the page::page_offset.
> 
> To fix this, let us work on constant truesize when PAGE_SIZE >= 8192
> instead of basing this on size of a packet read from Rx descriptor. This
> way we can simplify the code and avoid calculating truesize per each
> received frame and on top of that when using
> xdp_update_skb_shared_info(), current formula for truesize update will
> be valid.
> 
> This means ice_rx_frame_truesize() can be removed altogether.
> Furthermore, first call to it within ice_clean_rx_irq() for 4k PAGE_SIZE
> was redundant as xdp_buff::frame_sz is initialized via xdp_init_buff()
> in ice_vsi_cfg_rxq(). This should have been removed at the point where
> xdp_buff struct started to be a member of ice_rx_ring and it was no
> longer a stack based variable.
> 
> There are two fixes tags as my understanding is that the first one
> exposed us to broken truesize and page_offset handling and then second
> introduced broken skb_shared_info update in ice_{construct,build}_skb().
> 
> Reported-and-tested-by: Luiz Capitulino <luizcap@redhat.com>
> Closes: https://lore.kernel.org/netdev/8f9e2a5c-fd30-4206-9311-946a06d031bb@redhat.com/
> Fixes: 1dc1a7e7f410 ("ice: Centrallize Rx buffer recycling")
> Fixes: 2fba7dc5157b ("ice: Add support for XDP multi-buffer on Rx side")
> Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> Tested-by: Chandan Kumar Rout <chandanx.rout@intel.com> (A Contingent Worker at Intel)
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---

Much simpler too!

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

