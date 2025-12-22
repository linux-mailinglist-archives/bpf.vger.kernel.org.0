Return-Path: <bpf+bounces-77289-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9641CCD6102
	for <lists+bpf@lfdr.de>; Mon, 22 Dec 2025 13:56:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2128D3059594
	for <lists+bpf@lfdr.de>; Mon, 22 Dec 2025 12:55:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 141CD2C11E2;
	Mon, 22 Dec 2025 12:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XuVq4J+7"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 249E42BE7AA;
	Mon, 22 Dec 2025 12:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766408114; cv=fail; b=iL7RE2N3o6BCV9LHMcvw56ddW/0wKma4mCTf9AZydB1++zP3v3MTloLrIWHRDIqBBaROLaPCirrktP5+51TVlE/7lmfmFQ7oo1g7pzHSf9PqxaNF5s4tmGB2thttq2CyApsLiKvJgP5mwdQHuq8Jte85Qu7Byqo97XQWKqfokoU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766408114; c=relaxed/simple;
	bh=Va6zn5yIg99OT03DBqRHST6fEEZpvUigfUIMZjXxPOk=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=HRLTDRiiekLlypgCjzSVd8dzuUmm1Eh3Nub/fuYQKx58Dp/fiZ5g12p3i4zDGMioIVLHJI49QPfqm56Ss/AZdfiWw0DMEjflZrpYTbOPs29P+CccBpuE0R7pYwmDkAARVeL4p4LOVzFNv4tJtIKzDkwD8KAt96qp2oFfMPEDZ9A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XuVq4J+7; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1766408113; x=1797944113;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Va6zn5yIg99OT03DBqRHST6fEEZpvUigfUIMZjXxPOk=;
  b=XuVq4J+7CUmdWbO633qGvBoPx82z+6/XmH/nNQdtGQD8hJr/1qXEZGJZ
   P9u4Fa0xSzx+gYwSrHO14spDxw/HR9L5H6UFfqZfJyda/zkwg+M3NHNxZ
   QEjvIADCNIGQiyMDiCuW6Ye0Bhh9QYISDTH/xrf6bJ0HVMqf8SXQQmt4K
   Yt3UpHglNcfGB1lVMD8L05lKE6dJQyFZIY0rj5S/H4ySq8A/QpZ/ZGrAp
   R1aFH5x5nQIZuR4QGOeeeo4dNBSTbt9FcGJ6OCDKPTENsKSNnuhP6yy0r
   g7rk1LyW6+OlWTirwJ1gDxWSQpBkhIrOYrZtYLW1V5yAsXwcrhUYop23T
   A==;
X-CSE-ConnectionGUID: +qFK/67kTcuRheNu6frxdw==
X-CSE-MsgGUID: 2NLCOIGVRV2VCR3EdTTP5A==
X-IronPort-AV: E=McAfee;i="6800,10657,11635"; a="68199843"
X-IronPort-AV: E=Sophos;i="6.20,256,1758610800"; 
   d="scan'208";a="68199843"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2025 04:55:12 -0800
X-CSE-ConnectionGUID: yyamDPu8RYexCX37yinoPA==
X-CSE-MsgGUID: dboBi9nITEWy/nOEAKik7A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,168,1763452800"; 
   d="scan'208";a="198668277"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2025 04:55:12 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Mon, 22 Dec 2025 04:55:11 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Mon, 22 Dec 2025 04:55:11 -0800
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.47) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Mon, 22 Dec 2025 04:55:10 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ts3crMGMJcfLfDd2azL3jd3EK1UieWhj/rgngg+/gcggRkUDG9f3L6iBoel6fCvrJNQSJ5WEJRPuH2U4SBF8VVZ4vd2wQzpjFVpWfCr1M944bYKv1VPrf/CnM9EbP9aD4iKDJ86dp3vN5XhTzh1kVDOCt+nrDEF1araosYE+oMRq5BXL70zhhcLqV5qenPsOlm1PrpWrcA6Kyqg6AfknjiqZQGy5M077CIPVEjK6MfPioL2EbrlD6jZaRSwzqrRgDZr5tKFMe3xgTRE0IE2UDKTDsEK767eehBbX/hMfQXkabWjy9ucun/MNhv49zRwjHL2uo3fPX2AfGO1kBI8yKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZtWSgWBJimk0jPvkDAHXD4i5kVD+wOWyMJfVFk63yjM=;
 b=UtSJHnsIuzQkT7SSf4E7Dorh7J24QMJ+QBLq3OLnJ0qdWF9H7R3rAI6BPnv8IJQelv6OHLoltUPPivyMllrPtQfF+M/2uMXbDto4E3zfslX/nuEFf8ftaS5ZgBg+0tzx9r0CF/cReg3F9nbsMcmJVVSI/E1SNTfxvDjb0/06ZNEpq1N+X/bUKpfLMyhPKJZtezae72i4AGqfTRTsSURHoercq6AOLilHO4yL4ow2tvDqkELq83AB9Syf4ww3ai0UMAasu0seOQe0AtWhYmS5ZKsi7Fb+g4aoi5j3AEH5Ti5HRq4O7SNXwM37PPS6LbmNXJ1Kbrax+AdIcMWb5Vqfbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by CH3PR11MB8382.namprd11.prod.outlook.com (2603:10b6:610:173::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.11; Mon, 22 Dec
 2025 12:55:08 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808%4]) with mapi id 15.20.9434.009; Mon, 22 Dec 2025
 12:55:08 +0000
Message-ID: <870f89e4-aec2-4eb2-8a93-c80484866c6d@intel.com>
Date: Mon, 22 Dec 2025 13:54:17 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3] idpf: export RX hardware timestamping
 information to XDP
To: Mina Almasry <almasrymina@google.com>
CC: <netdev@vger.kernel.org>, <bpf@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, YiFei Zhu <zhuyifei@google.com>, "Alexei
 Starovoitov" <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, "David
 S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, "Jesper
 Dangaard Brouer" <hawk@kernel.org>, John Fastabend
	<john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, Tony Nguyen
	<anthony.l.nguyen@intel.com>, Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>, Richard Cochran <richardcochran@gmail.com>,
	<intel-wired-lan@lists.osuosl.org>, Aleksandr Loktionov
	<aleksandr.loktionov@intel.com>
References: <20251219202957.2309698-1-almasrymina@google.com>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <20251219202957.2309698-1-almasrymina@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU2PR04CA0341.eurprd04.prod.outlook.com
 (2603:10a6:10:2b4::30) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|CH3PR11MB8382:EE_
X-MS-Office365-Filtering-Correlation-Id: 68aae0fd-9e13-47ec-5f40-08de415955f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bE5xVHRlcUI3b0hsOFB0ZFRKSmxmMU9sNHk4YXdqVndNM2JXMldPRXg0blVD?=
 =?utf-8?B?blZkUk5QVVJ1SXZRYU9EQ3RrWUpKYS9kWjhjVjNQMWZGNk03UnUrVDlSWm5K?=
 =?utf-8?B?ejNzQXY2UytOR0hSQTNiaTFuUEdOT29QV2lrblRFN0ppSUhIL2J4UHZjNWZt?=
 =?utf-8?B?TzJIMUQrTksrMHZBSVROMWdkTDJid0R6bXovNi9jSWJlVW9KZ21VeUtkT0Y5?=
 =?utf-8?B?MnpkdEgrRXFGVG9UeXRNb2FNcVQwcCtZM1ArU2NRTUFlT0dKZzBOaEZTWWk4?=
 =?utf-8?B?MU1TWklvRVM5dTRQM0w4OS9pcHgzTERpa2NoRFZVcU1ZQmNNRjNlZDlER2ti?=
 =?utf-8?B?WEpFekZjQXpqOTdSSjlBdTVCYmhCeWY1cEJiUERRL0FVMkROYkNPRmR3UXIz?=
 =?utf-8?B?WUN4eGVzY3puU1pUdGlTeUJ5V0F1bUZ5RmhndjFPWkFwS3JNU3Iyb3hCQVNv?=
 =?utf-8?B?bGdJTDFGR3RWbTNXL2t3WWp6YkxyaUhnbXFqQ1ZyLzczb3BBbDBpWHE3ZnlU?=
 =?utf-8?B?Zzd6ZXhUSW45OWlOQndGeTc2MFNmWmJNUWE1R0wyNzYwY0RHbWhpbVJwZ2oz?=
 =?utf-8?B?WkNScURuaStsMU5OeG9MVnhqRzgvZEFiUncvNVk3NjA0K2llTEIwMHJZMFh1?=
 =?utf-8?B?ZnRFZFpMbTh5ODJzQnJ1OUNrZGY4N3lzM3NSbnJTMGVxbXV5RUJQaDlXamRW?=
 =?utf-8?B?OE1HUk9pNFlIUk4yK3I5bnZ3RHc1Y0xwL2hSZ041blJzeHNVekZiV2xIT2o3?=
 =?utf-8?B?Vjg5K2hOWnMzWDFjbndQQWpic2NTZXlNN1lkUnU5WlBPemY4SnE2bjM0UUp3?=
 =?utf-8?B?UmFaQWJRbFpidENHQnQrRTZGZ3NnMFNrb2JHb0V1czFuMGxGY3hzMDJGMHdT?=
 =?utf-8?B?QXhvRnE4V2M4cVlhekNpVzUvNXNwemFxVXBUQ2xETVdQZHhEa21ZcDlCVFM1?=
 =?utf-8?B?QkhTZ3JqUm1BS0hFOWpPSzlCb0ltTUdRRFVGOFpPRGtrMDA2elpCRExzWVFX?=
 =?utf-8?B?bHg1UHRIckVVL2RvOXNMejF1UE9SVWV0M1ZKOSsyaFo1NFRwQ214elB0NE04?=
 =?utf-8?B?SnFsYTRyVGxPRHZxa1hIckFydnV4NmVGamNjc01DbEtyWTcvQzhLWDgxblgz?=
 =?utf-8?B?RjdMYXZYSGt6aVRKNXB1eHI3T1lSaVIzSHBQVWpTTzJwTWpMdjdGRllqYk9J?=
 =?utf-8?B?c3FtRDBSUkQ1WUV5K05yai9TU0ErSkFRWDhHR0tTd2sxeEZDWFJYV293Tk9n?=
 =?utf-8?B?TkdIMFFOM2Q0b1pjRmJJazhxZDRNekFEeGFJMFZ0UXpIQmZGbU5kL2RMMGVX?=
 =?utf-8?B?anRScnpJVG8vdmxZNFJHY05oMmE0R3lFa3g2QnRGOVVMM1JjclI0Q3ZvMTVM?=
 =?utf-8?B?M3RIa2NORkh5d0pmS2w3VzNHNjltYU0zZkxGWG5seUJKTzUwZ2poTC81REhI?=
 =?utf-8?B?Y0xGU3p3OXJQZk9FRnVLTk5FbTIyZnhlTExCK0pCeXdYQndSN1cxVytkUjVs?=
 =?utf-8?B?SDM4Y3FEWkVrYUJ1SllYZDVlZExvbWROTks0djJOL1RoL1ZLMHRaU0xSVjhV?=
 =?utf-8?B?V29pSXRHQmRJTHJuMGRIb3ZsWFZQQ3NFOU1mZHM5dGRNOXlhNnM2RXUyOFY3?=
 =?utf-8?B?S1FhZjRHWnJlZWt6QzYrMTNqczBrNVpVOEFDYk1oaWp6eFBmL0tHVHhGSnds?=
 =?utf-8?B?YWNaaU85YmxDL1dSakVFYlF3TGMxNnhSSWhFRDBKejlFOXgyQXJ4eEVsVjRm?=
 =?utf-8?B?M0RNZTBGazlZaC9wRWsreGFwQldQWjJ0azdxeVlJMmFMamVrN2xkZGY0a3FD?=
 =?utf-8?B?OTh2a1pmRGwyYTZyMEFmajRtZVlWL2JIRnJsU3E5dDBsdytIQ0JWbkNzZlB4?=
 =?utf-8?B?NkhyWEpQZnJscnN3TEQ4TURsYTNMSGdLMENQZ3kzaFNyZ3gvb0l1dG40Z0J2?=
 =?utf-8?B?VFV0ZkZhWmxvamx6b21qTWtmOUdoVVNMT0RuQjJRamlEcGI2ODBFa1RaN0FZ?=
 =?utf-8?B?S0gralR1UFBRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Mm5lOHpIS1kxSlQ4cDhkSHBwSEZXTkVtd2dGelRqOGhlSGVZS256U3B5Qnpo?=
 =?utf-8?B?eUIwN2xXZW94Wk9DY2UyZm91UHdBUUIyaVFETDlyOU5XOWtrN0VEWU9ERjBu?=
 =?utf-8?B?WE9UajRrVWN0enNYTi9GZTFoN2JUenlxWG8wK3ZsMVczZ0I5RTVVM2QzaThE?=
 =?utf-8?B?d0s1aXIvMDJQNGU1WDVSUURmM2JDTGxkWmxXZUV6bk1UVmt3SXRVcWwxTElQ?=
 =?utf-8?B?a0tMODZDSnRiTkw4RUZKbm9nWDBtbHhkQmJETE1jeU1vNFBUdU0xMlJ0NzVa?=
 =?utf-8?B?ckM4THVRUXpQNnB3UElYcHgydUd1WDF6NlRKZGNMMUVuWDBQbVZqQXlTMm1H?=
 =?utf-8?B?L2tEcWRrNlRHM1Y0ZkFmUzhUeTdreDFvUHNWK21OM2hoTDZ1R3hDVk9lamVL?=
 =?utf-8?B?Y05WTktPZ05kWTN2S1MxT3JKcmd3NTZtazNKYnRCcnppb05COVJyaERmRU1r?=
 =?utf-8?B?cHJoZUJmaWdOSmVDTVhrc053cCtZcWYvYTBjOU1Nb1ZFWTFmck9rSk1DamNy?=
 =?utf-8?B?WlVOdzF0dHpRazIzdDhTN3J3Z0FyelVZc2xrN21PSDNUT1kyVlNkMUhjNzkz?=
 =?utf-8?B?dFJVcGFKWlowenFMWXBodDhEMjJjaHlLa3Mrb01WaDNZYlFYU2FGMUFlcWpm?=
 =?utf-8?B?TTZVNk15NmVnRW1pa2ZhZmZNcDdLdXUrcDBBdWxoWnYwZHhPL1F6ZkJHay81?=
 =?utf-8?B?MUw2T0dKUjMvMkNEOGFhcndUcERvNlhpWi85RDJUZFZlRUVoTVpIeEJRWFR0?=
 =?utf-8?B?N3V5RmZwOEZtaGtBZkZLUC9jb2V3VmVGVDR6N01US1pOdkpJaENBQnF1MnR3?=
 =?utf-8?B?SlYra0VLRTFwdFRiSWZXKzFIbThJSlllRVlvSkUrMXo0ei9mb1VEK2FiQWYv?=
 =?utf-8?B?cDMzTGZYNE03VE5CdElVNm9iZjNKNXVHb1V6alNpT3NnaHYxRHcyakNNZUo1?=
 =?utf-8?B?aHFNRndMN2VDdWY3Y05DZEYvQ3FBdEtvWVFiTnd4L0svcmZ0N3VEKzB3NDEv?=
 =?utf-8?B?WVkzMWMwa29CaTFPdzRVNzNhNFNTajliMUo4YkVWd2pydG82M0JsS1BWQ2t4?=
 =?utf-8?B?MUZncytOaENGOWUvb2FXOEdMc3BjTzlrVXp0dkhVdzNNcWtrWTE4SDd0RFV1?=
 =?utf-8?B?QURNTzNld2VIOEFOcE9LSzV0Tk8wZFFLYnVFSFNQc2RVUW1LQUxTbzdVcmZq?=
 =?utf-8?B?MGFQcC91OG9DbUQ5NmhSZjBVUmpkVTVIZElkNGdVdGZQTEhOcVB5djVBZWNo?=
 =?utf-8?B?TVdqdThHQlp4THZlQXdtbEhYNlRuM2hpaEJlay8rZmYwTEdwU3NHNVpPR0l6?=
 =?utf-8?B?cFl4cnoxeWNMcmxHRFZxeHZTNGNsck0yWXdFSVI3aVptcCtPVW9YcXZSNlhE?=
 =?utf-8?B?WXZQeVFxQ24yUTltZys0V1dZcnFtNzd0UEdwN3RnVmNremtjbzQ1emQ3TVpm?=
 =?utf-8?B?YmhYblQyRmd3bzl3VXJNdjkyUVhWM1E3Y2RVNWo2dlcyT2FqK1ZYT3dnaDli?=
 =?utf-8?B?emo1eVVDOUVxc2h5K3RxMTQ3VGlNVzhiTGZteXhiUFN2SStFMytDdUNMOExE?=
 =?utf-8?B?eXpaWjRWcEl3cnZpc3Y0NytEem1KRHpGOFVURkYyZm1oMDZYRjhPTUFKMlM2?=
 =?utf-8?B?ZGM2bFBjaVBJRFY2REViV0NLMjNlZXJ4em43OTRjYXBJNXdUQzQ5WmpUdWRD?=
 =?utf-8?B?azN6NFY1SzZxd2F5Z1V3Vng5OTdLYk03a3ErTXBCYk9xektKRU9qNUxWKzlk?=
 =?utf-8?B?ZlJKakZWeE10WDNJUGJPN21RR0RpZlViVDlRZHhTTVoxdW9Vd25QKy9yMkdv?=
 =?utf-8?B?VCs2RWxvMTZOYVB1RUR4L1Vwc2hSQ1EyUk04aEFYaE9zNUVkaWtYRTVJNFY5?=
 =?utf-8?B?a0tMTm5CS3N2cUwxSW1FTWxJQTdwT3hPQk9XSHVxS0Y0ek5BQUU4SCtka2Fs?=
 =?utf-8?B?bXovYUV5QVBUYUwvelhKbEhDTUdQUTlFUTJTUVdoVGFxVm5DcHR3T0JOeFh0?=
 =?utf-8?B?d3Zud3F6QytSQS9FUjRjRnFsZVFadXZFWlJGN2RVTFl5OEUyMUFYRFR5akY2?=
 =?utf-8?B?WHQwdlJLTXZWUmpYSE1RRVRVMWVUaGQwR1RjcThWRUQwWmgzZ3BuSEYxNHN1?=
 =?utf-8?B?dnFNMlNnZHh2VThBRzc2MmQ1S2o0Q29FQ2lzSENXVEw4UHl3emFtdFNKbTR2?=
 =?utf-8?B?a3FuRTRNZitPUHloUExjYW9hVU5FbFJhY3ZYM0ZOR2xicWpiUUVNYlA4bnRy?=
 =?utf-8?B?UUpkeGRKV0FxNFBEbTJxRU9kYWVDd1psTU8vbjlQVG1zQmRCOTBxeFZtdzcw?=
 =?utf-8?B?SnhmVUZQS0VnVEdzaW42OHltdUxNcVRZdkpETWxSSGl0UWlOSkcwZkRrOTNN?=
 =?utf-8?Q?qVg7wU8qt+ucDb3o=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 68aae0fd-9e13-47ec-5f40-08de415955f5
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Dec 2025 12:55:08.5394
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zPp8bqqt66Wm7ja6jwJ0h5YB9eNBWJXefkCaExjkdY2ucIPIG6WI8GFrHMWUJKuhJO1ubopIyPDklVJQONDMDcRzM1MU+7674X+WhIl2l/E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8382
X-OriginatorOrg: intel.com

From: Mina Almasry <almasrymina@google.com>
Date: Fri, 19 Dec 2025 20:29:54 +0000

> From: YiFei Zhu <zhuyifei@google.com>
> 
> The logic is similar to idpf_rx_hwtstamp, but the data is exported
> as a BPF kfunc instead of appended to an skb.
> 
> A idpf_queue_has(PTP, rxq) condition is added to check the queue
> supports PTP similar to idpf_rx_process_skb_fields.
> 
> Cc: intel-wired-lan@lists.osuosl.org
> 
> Signed-off-by: YiFei Zhu <zhuyifei@google.com>
> Signed-off-by: Mina Almasry <almasrymina@google.com>
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> 
> ---
> 
> v3: https://lore.kernel.org/netdev/20251218022948.3288897-1-almasrymina@google.com/
> - Do the idpf_queue_has(PTP) check before we read qw1 (lobakin)
> - Fix _qw1 not copying over ts_low on on !__LIBETH_WORD_ACCESS systems
>   (AI)
> 
> v2: https://lore.kernel.org/netdev/20251122140839.3922015-1-almasrymina@google.com/
> - Fixed alphabetical ordering
> - Use the xdp desc type instead of virtchnl one (required some added
>   helpers)
> 
> ---
>  drivers/net/ethernet/intel/idpf/xdp.c | 31 +++++++++++++++++++++++++++
>  drivers/net/ethernet/intel/idpf/xdp.h | 22 ++++++++++++++++++-
>  2 files changed, 52 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/intel/idpf/xdp.c b/drivers/net/ethernet/intel/idpf/xdp.c
> index 958d16f87424..0916d201bf98 100644
> --- a/drivers/net/ethernet/intel/idpf/xdp.c
> +++ b/drivers/net/ethernet/intel/idpf/xdp.c
> @@ -2,6 +2,7 @@
>  /* Copyright (C) 2025 Intel Corporation */
>  
>  #include "idpf.h"
> +#include "idpf_ptp.h"
>  #include "idpf_virtchnl.h"
>  #include "xdp.h"
>  #include "xsk.h"
> @@ -391,8 +392,38 @@ static int idpf_xdpmo_rx_hash(const struct xdp_md *ctx, u32 *hash,
>  				    pt);
>  }
>  
> +static int idpf_xdpmo_rx_timestamp(const struct xdp_md *ctx, u64 *timestamp)
> +{
> +	const struct libeth_xdp_buff *xdp = (typeof(xdp))ctx;
> +	struct idpf_xdp_rx_desc desc __uninitialized;
> +	const struct idpf_rx_queue *rxq;
> +	u64 cached_time, ts_ns;
> +	u32 ts_high;
> +
> +	rxq = libeth_xdp_buff_to_rq(xdp, typeof(*rxq), xdp_rxq);
> +
> +	if (!idpf_queue_has(PTP, rxq))
> +		return -ENODATA;
> +
> +	idpf_xdp_get_qw1(&desc, xdp->desc);
> +
> +	if (!(idpf_xdp_rx_ts_low(&desc) & VIRTCHNL2_RX_FLEX_TSTAMP_VALID))
> +		return -ENODATA;
> +
> +	cached_time = READ_ONCE(rxq->cached_phc_time);
> +
> +	idpf_xdp_get_qw3(&desc, xdp->desc);
> +
> +	ts_high = idpf_xdp_rx_ts_high(&desc);
> +	ts_ns = idpf_ptp_tstamp_extend_32b_to_64b(cached_time, ts_high);
> +
> +	*timestamp = ts_ns;
> +	return 0;
> +}
> +
>  static const struct xdp_metadata_ops idpf_xdpmo = {
>  	.xmo_rx_hash		= idpf_xdpmo_rx_hash,
> +	.xmo_rx_timestamp	= idpf_xdpmo_rx_timestamp,
>  };
>  
>  void idpf_xdp_set_features(const struct idpf_vport *vport)
> diff --git a/drivers/net/ethernet/intel/idpf/xdp.h b/drivers/net/ethernet/intel/idpf/xdp.h
> index 479f5ef3c604..9daae445bde4 100644
> --- a/drivers/net/ethernet/intel/idpf/xdp.h
> +++ b/drivers/net/ethernet/intel/idpf/xdp.h
> @@ -112,11 +112,13 @@ struct idpf_xdp_rx_desc {
>  	aligned_u64		qw1;
>  #define IDPF_XDP_RX_BUF		GENMASK_ULL(47, 32)
>  #define IDPF_XDP_RX_EOP		BIT_ULL(1)
> +#define IDPF_XDP_RX_TS_LOW	GENMASK_ULL(31, 24)
>  
>  	aligned_u64		qw2;
>  #define IDPF_XDP_RX_HASH	GENMASK_ULL(31, 0)
>  
>  	aligned_u64		qw3;
> +#define IDPF_XDP_RX_TS_HIGH	GENMASK_ULL(63, 32)
>  } __aligned(4 * sizeof(u64));
>  static_assert(sizeof(struct idpf_xdp_rx_desc) ==
>  	      sizeof(struct virtchnl2_rx_flex_desc_adv_nic_3));
> @@ -128,6 +130,8 @@ static_assert(sizeof(struct idpf_xdp_rx_desc) ==
>  #define idpf_xdp_rx_buf(desc)	FIELD_GET(IDPF_XDP_RX_BUF, (desc)->qw1)
>  #define idpf_xdp_rx_eop(desc)	!!((desc)->qw1 & IDPF_XDP_RX_EOP)
>  #define idpf_xdp_rx_hash(desc)	FIELD_GET(IDPF_XDP_RX_HASH, (desc)->qw2)
> +#define idpf_xdp_rx_ts_low(desc)	FIELD_GET(IDPF_XDP_RX_TS_LOW, (desc)->qw1)
> +#define idpf_xdp_rx_ts_high(desc)	FIELD_GET(IDPF_XDP_RX_TS_HIGH, (desc)->qw3)
>  
>  static inline void
>  idpf_xdp_get_qw0(struct idpf_xdp_rx_desc *desc,
> @@ -149,7 +153,10 @@ idpf_xdp_get_qw1(struct idpf_xdp_rx_desc *desc,
>  	desc->qw1 = ((const typeof(desc))rxd)->qw1;
>  #else
>  	desc->qw1 = ((u64)le16_to_cpu(rxd->buf_id) << 32) |
> -		    rxd->status_err0_qw1;
> +			((u64)rxd->ts_low << 24) |
> +			((u64)rxd->fflags1 << 16) |
> +			((u64)rxd->status_err1 << 8) |

I'm not sure you need casts to u64 here. Pls rebuild without them and
check the objdiff / compiler warnings.
It's required for buf_id as we shift by 32.

> +			rxd->status_err0_qw1;

Why did you replace the proper indentation with two tabs in all 4 lines
above?

Even though...

>  #endif
>  }
>  
> @@ -166,6 +173,19 @@ idpf_xdp_get_qw2(struct idpf_xdp_rx_desc *desc,
>  #endif
>  }
>  
> +static inline void
> +idpf_xdp_get_qw3(struct idpf_xdp_rx_desc *desc,
> +		 const struct virtchnl2_rx_flex_desc_adv_nic_3 *rxd)
> +{
> +#ifdef __LIBETH_WORD_ACCESS
> +	desc->qw3 = ((const typeof(desc))rxd)->qw3;
> +#else
> +	desc->qw3 = ((u64)le32_to_cpu(rxd->ts_high) << 32) |
> +		    ((u64)le16_to_cpu(rxd->fmd6) << 16) |
> +		    le16_to_cpu(rxd->l2tag1);

...here you use the correct one.

> +#endif
> +}
> +
>  void idpf_xdp_set_features(const struct idpf_vport *vport);
>  
>  int idpf_xdp(struct net_device *dev, struct netdev_bpf *xdp);
> 
> base-commit: 7b8e9264f55a9c320f398e337d215e68cca50131

Thanks,
Olek

