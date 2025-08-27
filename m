Return-Path: <bpf+bounces-66722-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 30B28B38B14
	for <lists+bpf@lfdr.de>; Wed, 27 Aug 2025 22:42:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 069107B3162
	for <lists+bpf@lfdr.de>; Wed, 27 Aug 2025 20:41:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB55A2F3C18;
	Wed, 27 Aug 2025 20:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ko3VYDBz"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60FBF1DE4CA;
	Wed, 27 Aug 2025 20:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756327365; cv=fail; b=ip+ZLi9lTKEwOWB9GfsITReww/7DZxfVwTkahk71FuVjiN3804CCSei7B1NiG2PjvoLrzf7KzEs6hpgYKJvUXIa4wy1zy65EQtxTXN4jCh2C5t3uu8GbCU3wUYtGogqIfsvPFBJff1iwLBeYOUTlo2O43Q/a8Eqo0Cns53hZnXE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756327365; c=relaxed/simple;
	bh=b2beKKMn+SG9AemLQzopQLsdnMBK4JghVNDmEQWL/V8=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=u4HvIKx5Mb8lGghQqteQoI7lWUa2in59UfC6qq5KA+f1zwBhhmdaDoin2BenEgoj09HRFP03FjwAxdPHSH7zuWoUwmxUdABYoJTxBxzAq/sc+3z0FT1kaFi8VucNQMm4mPtA9hoCsryFKwCXiOgUWR7oFjFtd9dNqt7Nrb6iWw8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ko3VYDBz; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756327363; x=1787863363;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=b2beKKMn+SG9AemLQzopQLsdnMBK4JghVNDmEQWL/V8=;
  b=Ko3VYDBzymMVqc8WKBI8GD5Ad9ta/VkNORN/OkjViPXVv62r8dvtx7TJ
   DPMQDGMIc4qOZi89w5anqQmAqGtHkMlnoCd5SIouBQGJoypU+pEwYOiGN
   EQk1qDx++UMOlWx+KjTwhBO8GzSvs3dUOSNOx8W+yB3D9yaF3ykkZyTLa
   BscFp40Z85iQXGS2o0KxJm8P1mxwBeWSOd3JHCP1gylPZ8winULP788a0
   gExk7nTX4VmWVB34gUg4bH8xSpyAHa/nUZb+tLphPoXtUsqmz9mta6uS0
   4D2rmWyrj4C35mEbFha917HDwLuKjyfvZcGCCkTQS36XdLo1FRSp/cYLU
   Q==;
X-CSE-ConnectionGUID: 9Ome1sSwSrW0VYJPTCoCEQ==
X-CSE-MsgGUID: CfLaOt8VQcuUMBc2LquBkw==
X-IronPort-AV: E=McAfee;i="6800,10657,11535"; a="68860045"
X-IronPort-AV: E=Sophos;i="6.18,217,1751266800"; 
   d="scan'208";a="68860045"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2025 13:42:43 -0700
X-CSE-ConnectionGUID: Xs9a44jZRvSAKEbmffX8SA==
X-CSE-MsgGUID: 1Rwep/4cT+K5rB4zMzkDIQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,217,1751266800"; 
   d="scan'208";a="169864022"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2025 13:42:43 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 27 Aug 2025 13:42:42 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Wed, 27 Aug 2025 13:42:42 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (40.107.237.40)
 by edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 27 Aug 2025 13:42:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=my47w04ZB3tNK3TzT8hakjRdksQLLZ10ossZM5mXH8YXoTJGON4e2wkpPku0+/eyZWMfdIO6zGg95Mzajwfbt8gKHOEc8C3DpiakRsgijbrt8euJzfh4vRdcFO4dQwM5F1PwYfPs52CAzrmVG95/7Rb0QYqWAfJyTvXaErDdrB5TcDfDyUFRNnTf8B+tq6/oPAmN6fZXLCuBGvl7soy+1xl9PT1FUkQqznIoeQevf+YS/4LuDo/YzCyBAEcj/zJqWfMP4e848owApd30MwOcb/D9AZyPAF/T7ei7t3F1On6fqvYK8noLS4mHJ+d/aoWmU8UyjYzSpFNHUkOB45B+/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6j+K34PM6Mya3vWXbFztB18jeF3wsKiocAT0z93zRqQ=;
 b=DRKFFkiuPlRHJ4p200SBuVwv7s/ENXBwxxBnEGu0+F6RmKcFuojzVrteBu/boRuAIsJWVCjC2RgDy9BqcBTZpX/hEMuDd25pwWGyyYS1ySnxBxE0IfPzLHfikcgm56XUSoTb4mXPL8UHXdUNH0z7jVp6ftAiEPpzXzslx/9rHKfU1qYUHnu3xppLDV30v9sz7DA6JO7IPaLRdA14PKoYI/bVNWK6aA+f/x7LFTgydDY5qrk8K93TPgC644NEfs3teNm/aamwklbzgvkW7WAyWL6ddVZy28u3pZeTQ3IynDtZ45W2rdzUebM2WDsoPVaGRsqbAxn4o/UY06LtdIgbIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL3PR11MB6435.namprd11.prod.outlook.com (2603:10b6:208:3bb::9)
 by CY8PR11MB7082.namprd11.prod.outlook.com (2603:10b6:930:52::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.16; Wed, 27 Aug
 2025 20:42:39 +0000
Received: from BL3PR11MB6435.namprd11.prod.outlook.com
 ([fe80::24ab:bc69:995b:e21]) by BL3PR11MB6435.namprd11.prod.outlook.com
 ([fe80::24ab:bc69:995b:e21%5]) with mapi id 15.20.9009.013; Wed, 27 Aug 2025
 20:42:39 +0000
Message-ID: <26255031-9f8e-4d22-bbb2-f2a61655c1d6@intel.com>
Date: Wed, 27 Aug 2025 13:42:35 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-next v5 00/13] idpf: add XDP support
To: Simon Horman <horms@kernel.org>, Alexander Lobakin
	<aleksander.lobakin@intel.com>
CC: <intel-wired-lan@lists.osuosl.org>, Michal Kubiak
	<michal.kubiak@intel.com>, Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
	<daniel@iogearbox.net>, <nxne.cnse.osdt.itp.upstreaming@intel.com>,
	<bpf@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <20250826155507.2138401-1-aleksander.lobakin@intel.com>
 <20250827172828.GP10519@horms.kernel.org>
Content-Language: en-US
From: Tony Nguyen <anthony.l.nguyen@intel.com>
In-Reply-To: <20250827172828.GP10519@horms.kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0083.namprd04.prod.outlook.com
 (2603:10b6:303:6b::28) To BL3PR11MB6435.namprd11.prod.outlook.com
 (2603:10b6:208:3bb::9)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL3PR11MB6435:EE_|CY8PR11MB7082:EE_
X-MS-Office365-Filtering-Correlation-Id: c9150ac6-7db4-446d-5162-08dde5aa437c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Tk5PYWpxQjJSdURHUFROU1JBYnlha2c5cnlITzIzRE5QeXgvNVMwaFJtQkYz?=
 =?utf-8?B?Z3BwR0t6bk9DQ3ZGUWRJUUkxaDh4VjJ5aHhxT1FWa1NEa1FTN1gwT0hOZVRy?=
 =?utf-8?B?RGtsekV6VjFjc2ZvSVozY1V3NVM3YVFOQVJGcWFRdXJldjhxY2dhbnlYMWQ2?=
 =?utf-8?B?U1gvZGF4MlozMit1RnlONXdjMms0YWR2Y3RIdkpRVSs0b1JZbmlLaDdRNjNh?=
 =?utf-8?B?VGVkOENFUjJ1eXlHK200em8vdE1qWFJ3NHp1VDh3b3Vob0krUWV5dTlCZXhP?=
 =?utf-8?B?R1ZxS3c1M1NUTGRoUGJYRkJHazZlR3F0VE43R0RhVmJ1Sis1V09ZMHFpMzJ2?=
 =?utf-8?B?MEU0UVEvKzlkTUhMM0xldmxIQXc4QWhwWm1yYkxPRG02L0UyZWhXZ1hxUVZD?=
 =?utf-8?B?TUpjUEpDQzdoUHNrUjQ0ZnQwcXJtYnRoVkZremc4S3l3Vyt1dzNKWkhQeFBG?=
 =?utf-8?B?SlpkTTA0eFBrQTFCcjJZMnZwc2R5YUZEcW5lYU1QNU1WU3dxY1VLK0ZrL0R6?=
 =?utf-8?B?VVBhU3VmZWhhTG5xSytBYkxxQW9wNTMxaEJITlVkeGhDazltcDhsb2ttS0Fr?=
 =?utf-8?B?ZFN2eHl4dis0T1MzREJ0NUdPeHlpbGNkYnVPT3dqTUZHNjMwZUtVeHBIOTlr?=
 =?utf-8?B?Vk9ldFF5M3ZCdDc0TEhheGIzVENVT2lOUmFXSkYxTHE3Vm5ieGJBS1licXhC?=
 =?utf-8?B?ajhYY0lNOE1Bc3RQVUV5aWI1QVQxSElPWnIydWxRRzFEcDYyODMzSTNERzQr?=
 =?utf-8?B?R1FBQ1Y1d00ySjdzb1BaUWYvb2RXNlJSWjFidkw3MHBOZ2tleXFaOUxiMXBz?=
 =?utf-8?B?anpZUHJWVUh4c2ZEd1lXUzlMVm5mWmh2VGt0cmc4UVdXSytaRUxIdWNzQ0dD?=
 =?utf-8?B?cmp4bE5Ldk13YlJtQW9kbjZiZ0JDWDN6V1g5ZFJYV1dxZkJLcVpGQ1BjM2pa?=
 =?utf-8?B?Sk5zejBkN21zLzdTa0FOUjBwSk1iZVJodGZ6dFpJTDJhYSs5WE5LaGcraHdL?=
 =?utf-8?B?WXlmWkxtU1lObWgrSnk1WU5xU2NHb01tTTFpb3hLTkwyclBDM2tLWWxKSTMr?=
 =?utf-8?B?QlduL05IWWlXVVVUbm1vRERLSm8rS0VSWUhOVldVUkJXVWEzQnByeEtRVFNi?=
 =?utf-8?B?eDNoa3pXeW9zV0ZZTkp3Qkh1T3N6dHRreGV6a2xQNnpVR01aL0t3cE5VSmty?=
 =?utf-8?B?dHhVNzdTS09ZcjRTQkV6Y3g0ZjF0TzVzV1JndGU0RlF0d0pqRjdBV0VlTXhT?=
 =?utf-8?B?eGgrTXZMMXRlVGJETTZTMm54SVVTNkpkR2NkUHd4cTBLNzFnWGRyS2UyVUNU?=
 =?utf-8?B?R24zTGdpQWJ4NkNGcVE0a3dOdFZWc201TTlXSHJFS1JodXJJZ1prejZNUW81?=
 =?utf-8?B?SkV1SXNtdlo3OTJrTWpTQTB6cGJjcCtFRUJqeEdYb3NneFFWVlNXMmhUMVlS?=
 =?utf-8?B?TCtxYjhhWjJndDFsSUNQU05JNkg4U1NObkpiTXYyWjNBazJ3dldoc1kxRUcy?=
 =?utf-8?B?ZXZaVno5ejRWODdGZjIyd3hTbUFPeWVBRlIxU0ljYUIveVN1UmhVOGh5Nkc2?=
 =?utf-8?B?Qm5USlZOZGExT09uNzRmSDZNbXFBREljeEVweWNqKzhHSTF4U29VbDBnME84?=
 =?utf-8?B?RkFFVmlSVkM1b1hMN0tTMlYxUTRmR242S0trUGQyR0srTk9xZ0ZubWo2NC8v?=
 =?utf-8?B?MzcyWll5VzFvZjJtWWpvQkMxeklYMEozcXBGZHBtOXJLMWpwdW1IRnYyejR4?=
 =?utf-8?B?dGR3eVlNcTMwK29Zd1lsYUk5MXNZMHdqNHByeUNsbmlWYXduQlM0Z1RURXR5?=
 =?utf-8?B?eS85L2ltTmFqWWVVYjgxY3Q2SE41bDhHamRkNFJ6b3JjODk5NE93UkcwM0xa?=
 =?utf-8?B?TGRQaEZHejRSdFNYa1UvRkxMb29vdHRCYm5zRmgxVnZaRGhFNWdZeWZKY1Ux?=
 =?utf-8?Q?IeoL0ZVTUQI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR11MB6435.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OWRaLzlNSnR6b2Ria3Y0NDlhRU1XRjJFQTE4UDJrQ0RXZXpqd3JmNnZvSURy?=
 =?utf-8?B?amNndDhCeE1pOHM1YWc5ZFFtVDFNcXBlcHRaeUFLMUl5R0V4K0NaMjRKb3dl?=
 =?utf-8?B?Q2VrL2kxbTJVSUlsTkZjZDZCWmJLTFJFcFVPUGdPR1paNWd1ZkZpT0NWN3Fi?=
 =?utf-8?B?NmRCb21sVHdnL3hPQ2RpSTVjRENGc2FvdXdBNUkxeloyZmh1WCtxS2RTRThI?=
 =?utf-8?B?WkwrNFR0NHZmbENBcUh2MENJOFpqb3MzSklaS3FsREpSMFdLVEpaRWlkZHhS?=
 =?utf-8?B?eWdPUTVOMU0vbkhNZHlzR1pqL2ZxYUQ1THVWTEdacmtxMmdncTVHWm9VWlFG?=
 =?utf-8?B?dWVqdDlUbEQzTjgzd0FQUk01MWpFRGxjL1UxM296dWc4enk0a2dlSUMzOXEw?=
 =?utf-8?B?RVhQYmY4VG9QVmZjWEZzMUlZRWZNZGE1dXFQSjgrK2ZNTVVOdzdNdXhUb0ZU?=
 =?utf-8?B?UXdCWnBiUDR2MmNGY2dCOXZqdmkweml4Rko3ZEVTTW5QbzZIK3M5c05TL21R?=
 =?utf-8?B?Vm45cVRxUHU5ZXdPTzBQVDR2dm9xcnpCaWxrUFpwRkcyVW1Dc1R3MUNSaTVk?=
 =?utf-8?B?TTN1Zm1WeEQ0RFVHcTZvcWs5aEVVNWtPU2VmMzcxano4dk1JWFBpMjhBVG9R?=
 =?utf-8?B?NitRM2RIeGY0TEtxV1E2d3N1V1JoT3ZkZmxqMlVvcG80SmJUMEo3UjltWEJu?=
 =?utf-8?B?U2tMaEgxdVBxWDBjU20yZ2V1SmhINHRtOWpFVWVMeStObmdaVHFKUHJ4eE9n?=
 =?utf-8?B?MS9NZzhsUHZxeHB3MFVIemR3ZEtsNGd0SzYyUWFrbjUxU21kd1FHSXBWUGkz?=
 =?utf-8?B?dVBCUWw5RzJJdXVGVEVNWDVWV3ZEUW1aTWs1eWV6R2lVdFVJdDJoNVdnL2FY?=
 =?utf-8?B?ZDMvajlsOFVEOHpjVjRsNEZxY0kxeG9OZUhSQUl3K0NxbmRNWmxtZGZiczZV?=
 =?utf-8?B?TEVCTjBISjhWMzREak54Rk04UVZXa0FqWURTamxjSFlITG0wN2gwUnplWWh2?=
 =?utf-8?B?RUIwYlhEVEt1cE5vRGhiUmpZREhNRm5NNmhvdmk3SnRadi9Ga0tFOFZ6dHps?=
 =?utf-8?B?dTJDQzZTdVEwR2t6eUhYb2ZEMitvWTlMSHpzZmsrODBDS0tyVVh4dUtXd1gr?=
 =?utf-8?B?RmNvOTFrZlJ4UjV1SzZhbXdtTFJ5N2JyNHdkYkNXNTZaRTZidEg0RWRTdFFL?=
 =?utf-8?B?di9NaDNJeEVJL0VoWGh1Zm9QaTk5V1l0azJZTGFDRnZyNFhldFUwa20rejJB?=
 =?utf-8?B?TnpmSGpHWFU1UmdQT3grN2I1d1RjN1YyRGpaRm9jRjlMcE92aWp1SHhJYnFZ?=
 =?utf-8?B?U3BVY21BTXVuNWtOY0ZCUXZrU0oxOTZoQkJHSHlTbEYxQTQvU2tSYkQrR1BD?=
 =?utf-8?B?Y0ZwSlJ6U0hUbjV0dVhpWGF6M1NOemlMaTV0TytIQWZUVzZRUFJKRUFLaE5h?=
 =?utf-8?B?Y3FLSnVsQVdkMzV2TWxiTHpqZ200eTBCdkx1cUhFOWRwQk82L3o2dUR5Sm95?=
 =?utf-8?B?eEFlaVZCU0RJa2VhdElFeTRwa2NkTFlzT0Q1eEZ5U1czOFEzTGc2Q3FaMmRn?=
 =?utf-8?B?VFI2aURjWDR0S2F3SWpxOU11TWplRld6SW5LWkF2R1hIak5PeVJsNUZLc2hJ?=
 =?utf-8?B?NnFVQ1dWU2dVMURHYkZYRUhFbEprdjNveVppUC84Vk93R0RCaFNMdHFSQ3NT?=
 =?utf-8?B?VitxUjZuR2dkUi9maFJmUnZmMWRoUStYcDRvK2xtZE9mSUxyczRkTjJKQWFr?=
 =?utf-8?B?ZEF1SEFiNUxvVktmU0hOZjZuT1lLWFNLZ1NSRWQvQjBhWXQ4M0xGTkZ4eFdt?=
 =?utf-8?B?czNPOTZTSHB4MzdxakQ4THRtNk9oOEVveGdZOU1MMGYrdWJFYStLcFN1bkJ3?=
 =?utf-8?B?QkVBWmVpaXppekhteTVjdTlHSk9VSXVtK0xwVWJmVVExekZRZGxXdUVaLzZM?=
 =?utf-8?B?c1VlczZsNk5JWHAzbHRKNUlGSXQydXVNUlg1bHZZK3dGVnJhbS9abUVxR014?=
 =?utf-8?B?SVZIdFYxeFEvWmhFN2EvZG1MZVB5OERGcDBlVUVNeWlWMHZFM0poazdMTzdj?=
 =?utf-8?B?R1BPcldGdTJ0dzlHdU8xbHEvOVZwTmFkeHZBb3VHM1dUc3YwVm1CZThxTWwv?=
 =?utf-8?B?QTh5WGpreURCcGJZODU0dHhSbGQ0bW5EMXIyUWZ4aGVleGNIdlExU3R2cS9M?=
 =?utf-8?B?OHc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c9150ac6-7db4-446d-5162-08dde5aa437c
X-MS-Exchange-CrossTenant-AuthSource: BL3PR11MB6435.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2025 20:42:39.7612
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Tpxy61280Pz/e1BnFEcoVW+f9T9J+uCwg/ABJN7Tq7eoLZlq47YEFUxwdbtrsX6V49j2hBPNAQwZdZvurK+kp0jq4XiOW80Sh8HN0vkOoNs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7082
X-OriginatorOrg: intel.com



On 8/27/2025 10:28 AM, Simon Horman wrote:
> On Tue, Aug 26, 2025 at 05:54:54PM +0200, Alexander Lobakin wrote:
>> Add XDP support (w/o XSk for now) to the idpf driver using the libeth_xdp
>> sublib. All possible verdicts, .ndo_xdp_xmit(), multi-buffer etc. are here.
>> In general, nothing outstanding comparing to ice, except performance --
>> let's say, up to 2x for .ndo_xdp_xmit() on certain platforms and
>> scenarios.
>> idpf doesn't support VLAN Rx offload, so only the hash hint is
>> available for now.
>>
>> Patches 1-7 are prereqs, without which XDP would either not work at all or
>> work slower/worse/...
> 
> Hi Alexander,
> 
> I'm wondering if you could give a hash that this patch-set applies to.
> Or a branch where it has been applied.

Hi Simon,

I believe this will apply to net-next if you apply this series [1] 
beforehand; it should merge into net-next this week. Alternatively,
you could use IWL next-queue/dev-queue [2] and replace the patches there 
(v4) with this these.

Thanks,
Tony

[1] 
https://lore.kernel.org/netdev/20250821180100.401955-1-anthony.l.nguyen@intel.com/
[2] 
https://web.git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue.git/

> I suspect it's terribly obvious how to do this, but I'm drawing a blank here.
> 
> Thanks!


