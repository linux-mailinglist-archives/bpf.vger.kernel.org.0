Return-Path: <bpf+bounces-53912-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ADFF5A5E262
	for <lists+bpf@lfdr.de>; Wed, 12 Mar 2025 18:17:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF9C13A9574
	for <lists+bpf@lfdr.de>; Wed, 12 Mar 2025 17:17:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 983DD1E8327;
	Wed, 12 Mar 2025 17:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="oGUfbe1e"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27671259C;
	Wed, 12 Mar 2025 17:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741799827; cv=fail; b=orMkcEfybUu8Z23uBsgkE65iiEHexkZEXkjPucjruqhgIyIZEAb4+oI87X42FXi8j53Xr23sVMy7vWI96Iomv/UbOB5X9iwlT4XWOs6i91H3fdA2SAB6k2k15pqax90QogR7n6fhYGIsU2s3zhs1FjoQ9mxUWk6vmxQAvg9nUIE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741799827; c=relaxed/simple;
	bh=J1kXquuTYEH54eF60j4AjF7JbptLLZevqiak7O20I3Q=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=jqUu+eJn+4QonRCL91OTgSU7onaPerqj6HX3l4Ba0azRyBnw0uS9Sn7bbOgWM1fmTYEypmUbtv16puLP1i6RbaFTZqudECR0zPeerKsOMcPtXiYiKtHLuRI903tUhAh7F0YKGSc5L/3qm8hRkweqLURvlX3TRHRN4brOhCRsj3A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=oGUfbe1e; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741799825; x=1773335825;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=J1kXquuTYEH54eF60j4AjF7JbptLLZevqiak7O20I3Q=;
  b=oGUfbe1etqpBeHuligcGo2iURCXzIdLjYRRdoANM+zg9qqh56aOxfgcu
   4YCW8pc20yV2loolgJCKqo48dpBrc/hu0EfXv1q+vgzlaMuGplFVN/5qq
   BtYFkglyh+q7UFPVKxrB+Speglcd3H70Cn4Uw7Sjr8sSgnoYzhtd0hjaK
   TW229EvPZ2vYnfDJYwVVl685WjNN3/v+3d4RcGXEzKH9gETTRt8JJnbGm
   Q2Rkf/t9IRWazBMH5oWVwBls0NzmumTlQszObd4vEI4KCfoibr1ouabzl
   bHRbiS1seDvCD/OzOcswBou/AiMcPlODB4S6DwXJfiWBYdzKGizll1P93
   w==;
X-CSE-ConnectionGUID: w2/daU7pT4O27kbzcx8RUg==
X-CSE-MsgGUID: c3idU5MbSOeprW+dc9cWpA==
X-IronPort-AV: E=McAfee;i="6700,10204,11371"; a="42768627"
X-IronPort-AV: E=Sophos;i="6.14,242,1736841600"; 
   d="scan'208";a="42768627"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2025 10:17:04 -0700
X-CSE-ConnectionGUID: ELLVkzt5SfKW4Z94djqc6A==
X-CSE-MsgGUID: mB6PCkizQs6lXRbGCowSXw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,242,1736841600"; 
   d="scan'208";a="120658222"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2025 10:17:04 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 12 Mar 2025 10:17:03 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 12 Mar 2025 10:17:03 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.41) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 12 Mar 2025 10:17:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=okE0/DKyZkr1Sneqb+t9W9yjgVc2an7mYwGPSP815TUdg+yc3zkkBOv6HNyfSXAPU2W8QSAsdppe//iVpGyc4KO4gXsX2mikBnXCmXyhCp2TPAwkeYwwrxW8ZQyq2pqHhaFx5zimZ79K/MhdsWnoYs+lV6Ika0o+LqVS7JdKhHgw1lQO5pstKYMmAVTMAXh6GocAI2nDhY7HnmY2qbn1RKKmwQra4FuPAcQJxIBC719oOC6k7Jb/157XfoRKidGK1tnBaSwNKiGie3EYC23wOj+WTF5d0F4EQdmbQVl4fNUY7yv/9S290UuYJ47TezkPu7UCm0H1pgrG8T5yUZOm6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YC2GH+DbJ6MhsO+aez6I84cWmQKTgojhPF2sPP0c4LM=;
 b=gMMX7rHdQ4R5yPF6moT0oDt7nwNnscHK+ItE8HdxERbtCUGTHkM/AE6ECgPSeMtAjEt3Y8S+sWMi0aOPjBRm0C/V04bAWP+aU4prJ9Kg5XMOqs451+XJ9N7bchSVr6nV8v7QAr6Um8nvphukFfYP+3XYiXcr+hd+jyO1uxua3e8OzWcMQE6d7zuokzJr1L5a/TXniUYjngXkOCjmSaU+EKKmE7ZSMW7xJzUBBYn4nv3pgb5jmFdgs9YUDqBjzFrvr2wqP7+jeFW8JbzT73zFD9eFWv9q0jc0ssR+iq/GYeVjD1FGMJS/RTGcvYHg03FmGYRSq8ib99pprCt675K9hQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by DM4PR11MB6406.namprd11.prod.outlook.com (2603:10b6:8:8b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Wed, 12 Mar
 2025 17:16:17 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808%5]) with mapi id 15.20.8511.026; Wed, 12 Mar 2025
 17:16:17 +0000
Message-ID: <5c2dd43f-2890-44db-a5ab-68a86dd2d89a@intel.com>
Date: Wed, 12 Mar 2025 18:16:11 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 07/16] idpf: link NAPIs to queues
To: Eric Dumazet <edumazet@google.com>
CC: <intel-wired-lan@lists.osuosl.org>, Michal Kubiak
	<michal.kubiak@intel.com>, Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>, Przemek Kitszel
	<przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, "Daniel
 Borkmann" <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>, Simon Horman <horms@kernel.org>,
	<bpf@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <20250305162132.1106080-1-aleksander.lobakin@intel.com>
 <20250305162132.1106080-8-aleksander.lobakin@intel.com>
 <CANn89iKyyayTrepHuPbnkhVpu3trkRohdKxeT8RVefP95wognA@mail.gmail.com>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <CANn89iKyyayTrepHuPbnkhVpu3trkRohdKxeT8RVefP95wognA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MI1P293CA0020.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:3::18) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|DM4PR11MB6406:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b81eaae-3fcf-4d01-2892-08dd61899949
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7416014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eUdUc1dJKzhsaE1YaDRtRm9wVXNuVFpYMGl4ZDhscXM5VXowbDFVb05xYWxG?=
 =?utf-8?B?c2NZNlZZSDFRM3F2UUN0VytuZUpMWUFocUhPb3Y4eENVTUw2YytnMmxPOStX?=
 =?utf-8?B?N1RNbVphalpGeGRJNk1xSkpkcHppOVZOSnp1UGs4UGFqRjczRHBHTWpzYndW?=
 =?utf-8?B?cGI4UFA2ckl0dnIza0dHOHZuS3dZUzAxYUJkbmdoUGhFNHhTWHp0dnJROUxo?=
 =?utf-8?B?YzE2TXNDOFB6VGlxcEJCWHluQ1I1S0o0bDZHcThDeTRRTFhJRTAzYUZIS2Y0?=
 =?utf-8?B?TFNIdCtPL0dIRU9hekFXbUZqaWtTTFhUSVlrUDNvRnN2dVJzQkNTOEp1U2RK?=
 =?utf-8?B?aStHUkI3Z21mT3gyZDJabEp5QjBWYnBnbVJpMldFNVZYZzZqdGNzajhkcHI3?=
 =?utf-8?B?ZHBRcm1Ea0NmT0VhR3dGeE95aFJHVFExVXBsakwrMnorRzNuZ3JFRzFiZnNW?=
 =?utf-8?B?RFFtVm5LL0xTTkRHc0FIb0FnWjQrZDVzaWpWMEZ6STVybWlhd1BkbTdzeGdK?=
 =?utf-8?B?K1ZvWnRmdmViZDhlZGNHTFI5d2E5L3E5Vm1UaXdVVlk2dmxleWUvNUdVd1U5?=
 =?utf-8?B?WXVETXF1Rm1kaDd0US9Dbkp1Z2NlRlgyUW9xQi9mM1JTR1A1SFcxOUlRWG9R?=
 =?utf-8?B?M0FIcWNicE1lRjFSRU5SbnFCZ3JvbHZmaHdoOG5SRldjTzFoUGx2UFZFa2pZ?=
 =?utf-8?B?aEZnUDZENWNPOVRQd3JZNWVLdHluUE9raCtYbmoyTDFxOVBYKzd4aVBuVVZa?=
 =?utf-8?B?aWFtZ3U1Ym5zbjRJNG55YU80OEV3b3g0SUo1STlEdXRIeXY4UmpkSmhtU0ZI?=
 =?utf-8?B?V1VSREk4eitKZTMxTzczU0luQ3hvMy9aTXpXUFIrZlJPcXFaSXdkYmtXb0Y4?=
 =?utf-8?B?WXZkeE5pVDVBSzdpaU5wK01PZWtVNExxQTY0eDIraFh5TDZlV1EwMkZJK1Jy?=
 =?utf-8?B?amk2R1RCRTFEV0dGRjFlT3NmQVpIWTVlWjg0Vm01b3REeXFvV3YzSkxpZ1Ru?=
 =?utf-8?B?MXRMb25lNjQvdnN4b1BvMFU4WHBTYzd0MlNxNWV4NDMrWXVxNXRqTlIza0VZ?=
 =?utf-8?B?cmpCVlpTTWxyZ1dkRi9xdnRDckM5NFpxWEdCOHhvbDM3VTQxSmcvVWNsa2J2?=
 =?utf-8?B?akxIaWx6MjhsQ1ZpWVVacENHcmhQeVFDMGl1N1pvak91RmUxQkp2ak50WWwv?=
 =?utf-8?B?clM0OUF0M1JxQWFpN0p4ZDdOYVJqS2Z4bjYrNWN5bnlqWGxPNWFEM1J2cUNz?=
 =?utf-8?B?dWVnWnZZTm52alRwQ2lFRHU1VnlXL1RLbjZsK0ZJeUppUVZlZ1poSytNVDVm?=
 =?utf-8?B?MzkvZm1Qb0Fkbm4za1JtTXFYK1Qyd0xFbVUyMDBrS3J6RDRvQ09wNm54QzJQ?=
 =?utf-8?B?bUlmWk40L29Fbk5sT2RzaE1Va1ZpYTBIejAxam04OTJTbWFjdm15UjNqdDFz?=
 =?utf-8?B?VDdOV3ZCNDJ3bGd3QzRaakR2bnF2K3RvYkx1em1sTlUzQVU5c0xqSSs2QzlM?=
 =?utf-8?B?M1hHUy81VCtMaWwweHZoUU4vNmR3RnBlYkIwTVJvclN1WGRhNWM4K3MzbUJK?=
 =?utf-8?B?USsrYmFFNUdJeU8xeGhYbisvVWJ4SXJ1UndRNWlxUTBjS3pFcThmTUtkUnpa?=
 =?utf-8?B?NTRVeFc0T1Z3ME5KNEVpZTMrSGFrRFRYa1NlQUJ5SnEvZ2k1VFhHZ1kwV0kz?=
 =?utf-8?B?MnNTUmQxa2l3NFdEamt0QmpXQXhGd21XVmR5ZTdWNDFzb3MyKzR1ekFxcXc1?=
 =?utf-8?B?UGNiWEVzYTkzK3VaVkFwaVFuZE9GM1BOT3Y3UDl1U3NQOC9GTjQ5NnZ3R0tl?=
 =?utf-8?B?cEdjemlmOWcrYVJZaFczeElLTHc0aDUyVW1GZ3Avc2l0WEZheC9scWtyb3pm?=
 =?utf-8?Q?kdAz4hIZWhx7o?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RCtNQTFZWlBidk9lN3FnYkZUZlZaSjJ3YTdhejNsK1M5T2dxL2UwZC8rUkVh?=
 =?utf-8?B?L1hFWUpBb2hsQUFINGVCMVhuQTRGcUxHL0NyVjhxUUs3S0Q5U1QwR2JOTWRU?=
 =?utf-8?B?M2tmZlJZcGx1c1poRG5ycDhVM1JxUzkvd0wxeWE0VjZkclNGVkFucTVXSlVs?=
 =?utf-8?B?WGRQS1BRY0JCcUFIdE1iclJzQlBYRFlVNSt6aDd1U256TzBkajArUit2dy9k?=
 =?utf-8?B?U2o1NUZpNmRBODNFZmxOWEVQdzg2clM0MlJLWExGbC9sWVJyS2pSZnBFMUpl?=
 =?utf-8?B?S1BRME5UNGlhbGx5bnpJblBvams4ZlQvd0swQnFBZWt4MjZnMGJKUER2d3px?=
 =?utf-8?B?STBDUzFuS3BpWVcwUytlYU5tY2gzK1UzLzRsSEhtM3QvQ3krL0RyRGxVWHlT?=
 =?utf-8?B?Z08ydXplZUVST1J0SDdaN20xT0VKcTViZ0lWdTIxbEFpRnJyOGdTTytVelBo?=
 =?utf-8?B?SEl1eWFhakk3aVpkeHlsVkFubjRlM1FHTnlMb29Lc1RpRDRtaTJFdEpPRlVh?=
 =?utf-8?B?UFI3M1FqSmEzTmxzMnZrb0JKWG95TEJhcDB6VXZoSFlWU0lRUlM1UzB2NVkr?=
 =?utf-8?B?MEZHaWJ2cjJ5aTZ4bTJsWC9VT2VHRGl3a01rUFVzcmp5eTUzekI2Tit4aUQ0?=
 =?utf-8?B?aFVUSy9MVEdBc3JWa0V5UEtvOUpYUEoyV2dpYURFZytKdTh4SEJKS1ErL3VR?=
 =?utf-8?B?SVFZM29NTGp2RzhRR002ZlRja0FvOFNYcDJKYWNiZG1nK05ya2ZVYWowQ3Fs?=
 =?utf-8?B?RXBHY3MwZjZoTkFyWEZxTDRGNTVRQTFlVFZ4c1JHTUlnN2lMNytwUGhuWlR6?=
 =?utf-8?B?SGFVbE9pRmxVbCtPMUVFZnlUWWxUdmJKbnFwV2NscXUydnNtb1lyUTVkdEQx?=
 =?utf-8?B?UUhLYU1DNTh4NXpTcVF1K3pEMFlJTXZlMGVDWHpSUkRVdnRPRXM1U2NVZ21h?=
 =?utf-8?B?czJzY1hlcXFCTlRrSXJMd2prRWw4cm5POGxGUlZ0eVNnU3dZTlhoSzgrYVZq?=
 =?utf-8?B?cjNaMTk3Z3BZb00vWnRETmJRMzdqOW04VW9PQXhuTDJjRVg1cVl4eG5yc2tz?=
 =?utf-8?B?aC9yNkNxQ05uQmdxOTVQdSt4TklOdTY0MkR6WTVvZXBhUEUvRGh2WnU0SW4x?=
 =?utf-8?B?YzZJd3c2QnZ2VGFQMEhuT2Zxbys2MVZtNlJrVlNPVm1YaWNaSG9yeDFqWkxU?=
 =?utf-8?B?MnJ2N1NSUkg2RkhXQVorTlZ4NDdxS2dSSS9KK3dMT1lyaDlOemJ5clF4NmVC?=
 =?utf-8?B?WEd0NGFuRVJHUGtCaU5VNS9PSmVsL0sxNGRyQ3BiYkdLQXovRnpxVXlkUWg1?=
 =?utf-8?B?a1ZqQVV6bmFPSlpWZVg3c3Y1cDJ4b0ZyNEtCWWxWSlBueUdSTE1ucG1oVWdy?=
 =?utf-8?B?cDZVUGNndzF5WUNlZzc3MjY1ekROQzFGRDlFWUFINndCWWczczVoZUFBMmgw?=
 =?utf-8?B?UEFBYWJyei9PKzZaMVpoQUNDWjI0NGJ4ajc1UnRXTk9YY3RMY1Q3UEd2ampk?=
 =?utf-8?B?NkFod0tNcmVWRTVSY09IQUtrakhoRlFRRkZtVFpYVmx3d3lDYkRYVHYzWUhR?=
 =?utf-8?B?WWhkRzZTL3orbGk4RDlESWM5cVJteDhZNkZ6bWVxZTc3WUZ0dkRVeU1DTHJX?=
 =?utf-8?B?SDZPcThZYmVUMUVNb0xwc3ZLSFpnYmsyOEZkVHhqa3E3a3JRQ1ZxY2pOamNo?=
 =?utf-8?B?WTlBd3dqT1Bqd2szVW9rL2k0WVIxd1J3SGpsQjBLNUsvUnhhWFIvTC9GMHc0?=
 =?utf-8?B?ZmkwWTN0Y1lJL3J2K0VERUpXYWV2WjRpODBHOS94czJyUWFnV2FZUDl4RzAz?=
 =?utf-8?B?ZExPRWwraW16Sk9PMkNORllpQUZNa0ZLZWFadkc1MTlVa3N4OTVIbHdVTTha?=
 =?utf-8?B?S3hPL0tTeXo4eEcrcTlYOWpzSWRtREM4S0lBOVZLMWRvTGJpSnlYLzJIZ0tk?=
 =?utf-8?B?RHNhd09GdUdybXluei9UUzRNYmtNazhGaGIzNFlBbUM4UGZHKzFzRTJqMHJG?=
 =?utf-8?B?KzlwVkdsWlBqOGdrdGZ4S3dhaUFsU2dRVkJIQnRLY2xsRjVRUGhxbVBzSUNS?=
 =?utf-8?B?bHlFQmk5MDg4WXlCaEk3K3I3NEtuVUtCOVJHSk1wYXVLekh6QUJZanoxaTB4?=
 =?utf-8?B?WGN4Y1FXYjduOFpvS1BXWnArQVgycVFDQk9SQm4yRlcrZXBEV0NRekdReHBJ?=
 =?utf-8?B?NGc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b81eaae-3fcf-4d01-2892-08dd61899949
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2025 17:16:16.9064
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DElIj+p84sizz2DraM45eH9ddLUHNZnnHCOCIKPMIipTpPeRtm316MzXuZitwZvq1xF+yTxaqJSIz6dzeEutC7MEHEGJQ0LlPY54BkEtKi8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6406
X-OriginatorOrg: intel.com

From: Eric Dumazet <edumazet@google.com>
Date: Fri, 7 Mar 2025 11:28:36 +0100

> On Wed, Mar 5, 2025 at 5:22 PM Alexander Lobakin
> <aleksander.lobakin@intel.com> wrote:
>>
>> Add the missing linking of NAPIs to netdev queues when enabling
>> interrupt vectors in order to support NAPI configuration and
>> interfaces requiring get_rx_queue()->napi to be set (like XSk
>> busy polling).
>>
>> Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
>> ---
>>  drivers/net/ethernet/intel/idpf/idpf_txrx.c | 30 +++++++++++++++++++++
>>  1 file changed, 30 insertions(+)
>>
>> diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.c b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
>> index 2f221c0abad8..a3f6e8cff7a0 100644
>> --- a/drivers/net/ethernet/intel/idpf/idpf_txrx.c
>> +++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
>> @@ -3560,8 +3560,11 @@ void idpf_vport_intr_rel(struct idpf_vport *vport)
>>  static void idpf_vport_intr_rel_irq(struct idpf_vport *vport)
>>  {
>>         struct idpf_adapter *adapter = vport->adapter;
>> +       bool unlock;
>>         int vector;
>>
>> +       unlock = rtnl_trylock();
> 
> This is probably not what you want here ?
> 
> If another thread is holding RTNL, then rtnl_ttrylock() will not add
> any protection.

Yep I know. trylock() is because this function can be called in two
scenarios:

1) .ndo_close(), when RTNL is already locked;
2) "soft reset" aka "stop the traffic, reallocate the queues, start the
   traffic", when RTNL is not taken.

The second one spits a WARN without the RTNL being locked. So this
trylock() will do nothing for the first scenario and will take the lock
for the second one.

If that is not correct, let me know, I'll do it a different way (maybe
it's better to unconditionally take the lock on the callsite for the
second case?).

Thanks,
Olek

