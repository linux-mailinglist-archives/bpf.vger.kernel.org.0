Return-Path: <bpf+bounces-59175-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 953DFAC6C55
	for <lists+bpf@lfdr.de>; Wed, 28 May 2025 16:55:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 79D591899AE9
	for <lists+bpf@lfdr.de>; Wed, 28 May 2025 14:55:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81BF928B504;
	Wed, 28 May 2025 14:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ls+g7pjT"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67AF813EFF3;
	Wed, 28 May 2025 14:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748444092; cv=fail; b=l4W/C8Xg6w1Cms4kq+efE2vwP73amdE0f+toTZF6hMprapL+sE47P6XpG+asM+Grp3YsTnXvYk3u08otF83/bA4Tmg+ipLW5kF9YDnW79oFNu9RpBOgVfATV01KAAuY0iNbRSr9sXUcWt1UXZFrmUyuL3ex+V1JRBEuB8zpOPZY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748444092; c=relaxed/simple;
	bh=0kQQ8QvbLlOqqt8+2B0dg+PdV7I/r2iY9AA4X+IpOyQ=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Niz5DsiH8QsALTs3MWfkS14tcqOfPU76yD7fmvPGLTYGr27mrJUU5QQle4gOSqllKBINpKfsyjJZ8a0jYCWKwHdYy7Jd9TAJTtA/yozrk1cJg068W/mqqNqRuyYP4/m6lje6zmNkV8IKBdQtogOv/709cef7XuQ1Qkuoa9q/pTA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ls+g7pjT; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748444090; x=1779980090;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=0kQQ8QvbLlOqqt8+2B0dg+PdV7I/r2iY9AA4X+IpOyQ=;
  b=Ls+g7pjTWuAMT3uPAE+Te9e6IR/2WN1HwbwQbeeRNPpGDEb8Yi2Mq83f
   6cdF4W7YSpBkAFu0rL4Jhtuw42w6tbsGcj9tk5lmbIwI83KvccC3jhqG7
   WTE5MHJYMyulyisyPCNptNech+KVkboq53MNqLu9EL6bttjHBF7+IAnR/
   Zh2jfKkROeSNeC00F9cHEKUqsBOrE0MThvkuf+AKDA6tFZiP8sSKjZ2aT
   opgfmmL8bENhCZPJ1AtIbad21hmS7QE0ct3dcd2fbmwKgJQT4HpFBXJRs
   h4ym7F9+iMbk0mMaKY70KBU8u2XgoHUs9NG2xAPaNBcepYvBHruF+HLn9
   g==;
X-CSE-ConnectionGUID: HKMtauRPSu6OcJVtub9JwA==
X-CSE-MsgGUID: lRCj5uUNTySNsPQgWYzmkQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11447"; a="50174477"
X-IronPort-AV: E=Sophos;i="6.15,321,1739865600"; 
   d="scan'208";a="50174477"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2025 07:54:49 -0700
X-CSE-ConnectionGUID: CoELSQpmSKinQ5TBNyaCfA==
X-CSE-MsgGUID: nNeQIP0lRvqZKbqc/mNzuA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,321,1739865600"; 
   d="scan'208";a="148027582"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2025 07:54:49 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 28 May 2025 07:54:49 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Wed, 28 May 2025 07:54:49 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (40.107.94.54) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Wed, 28 May 2025 07:54:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RkaX51e5TLm+NqA0u6mKdoNd1R/PY2aHSc5EV9IUorwLc7w24pQxVf2Lt9DJ+SyFeFh9rF4+4jFg1JkgRfmzlBqSFHZnHc5EP+9pLjfQ9yZIhBpKsg5f3YeZMU5dDFYp9x/Gp3yamIZPhIoGIB864qZIZKcpyBjCQqWtyBjwG/4xP+KtiT92ftPBh3D9P+Y4ciOTeGxXur+tC0MPXm5PoFILqcOmNr7o8AZ/j9JUjGNmCHf/Auhqbxynwp8PcT1y0ZSd5uc7K+htLF7o+6jyzsvKrR5NaLx+NPYHNVO3W8CJDI9SxEcRaEIi6MXW8p60ixOvi0Il2dOcJshCPDEZRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PtBvH/CXZOG/vHGQJ1kBYDzMq/5+yUJG5yBSUuBIvGI=;
 b=L1fR2J5QdPqOkYxghX1vcUfdU+CA3PQo/7NxWCbFJTD3tJ9wv1Dq7ZPeACCO+sMLquOEVVWaAgz/id8e03w5HivBUqId7LMZag+R5ervbSUC+pg9AT/G24wOrFu4sejcgDehJBH81xM/sSXA2BSZ5iz0Ivg1C9Sxi10rU/RyCLMmg0NPwmIVWvUfmqDtWYwUK5ZdFBQIUMQu9mnmhO0CM19OQcZTInJcnWiMI8d32ZlxoiRFClAsc3hZYxs72/9xCyYwjn3TV8Iq3D2ThYSSsHCjYat9ULOhEFX4GvpImqHz2U5ezYaXsN1r4wGZ0lr2BDlt0gLM7FtOJCs21fDUXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by SJ0PR11MB4815.namprd11.prod.outlook.com (2603:10b6:a03:2dd::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.27; Wed, 28 May
 2025 14:54:46 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808%3]) with mapi id 15.20.8769.025; Wed, 28 May 2025
 14:54:46 +0000
Message-ID: <20d9b588-f813-4bad-a4da-e058508322df@intel.com>
Date: Wed, 28 May 2025 16:54:39 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 01/16] libeth: convert to netmem
To: Jakub Kicinski <kuba@kernel.org>
CC: Tony Nguyen <anthony.l.nguyen@intel.com>, <davem@davemloft.net>,
	<pabeni@redhat.com>, <edumazet@google.com>, <andrew+netdev@lunn.ch>,
	<netdev@vger.kernel.org>, <maciej.fijalkowski@intel.com>,
	<magnus.karlsson@intel.com>, <michal.kubiak@intel.com>,
	<przemyslaw.kitszel@intel.com>, <ast@kernel.org>, <daniel@iogearbox.net>,
	<hawk@kernel.org>, <john.fastabend@gmail.com>, <horms@kernel.org>,
	<bpf@vger.kernel.org>, Mina Almasry <almasrymina@google.com>
References: <20250520205920.2134829-1-anthony.l.nguyen@intel.com>
 <20250520205920.2134829-2-anthony.l.nguyen@intel.com>
 <20250527185749.5053f557@kernel.org>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <20250527185749.5053f557@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR0502CA0017.eurprd05.prod.outlook.com
 (2603:10a6:803:1::30) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|SJ0PR11MB4815:EE_
X-MS-Office365-Filtering-Correlation-Id: f502ca7a-d451-44f0-b0ed-08dd9df7963a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?c3FJQ2hBK0JSZ3pqaHByUFRxbE51MFVYVHBoY2hhMUZHMnppRnFaZ0dUMlBB?=
 =?utf-8?B?eXZhWUpaKzgvUFdUb1BNcWw2UTdIMnY0MEJ3dWhJSHdEOGZLRFZnMVY2ZFBz?=
 =?utf-8?B?Q3ZWQjE4UVBRQk9nTE9Wc01NSENwWTI2UmhRbGlqUyt5MERtKy95U0RtOVpF?=
 =?utf-8?B?MCtpQmpxNU9STmdLYkFOZ0NidXNySmMyenErS1hkN3U2ZVFlQmZEVXpHYmpi?=
 =?utf-8?B?N0orTTlLdEppN1YzY2V0eW9kb3p0a3pROVkzcFZTdDdaMWxOK2MzeFBvVGhD?=
 =?utf-8?B?SDFFclFMYjloZW00cFMzL1lXMURLcU1JQTlsclFBSFZmZWJ0MlM5OG1xQURm?=
 =?utf-8?B?blI3dE0zc05pa1ppeVZtZTlRNitDN1N4OGFJRWNUdEVPR0ZMMEJ1UVhFVTJn?=
 =?utf-8?B?eHhmd2x3VmRpaFJyWXRZZGdON09YNnpua1BOcWFhL0dpejA0Mncxd2pPQzZU?=
 =?utf-8?B?Y04xdkhwc1hRMHBKeG53NG5rbEpoV2E3R29VUGVMQkxDTzVJRkxkSDRZRlpR?=
 =?utf-8?B?c2VweGp5SWxNelZRUFB2OVJId2JMT3Y2ci96Q3lYSjhua0dYdkJtWldPaGV2?=
 =?utf-8?B?Q25IRE52djlrSnl3NElZMXpWaUh6Mi9jSEVBRE1DM0ZCd0I4dzk5RGsvV0Ez?=
 =?utf-8?B?MXl6azM2UFI0WnRLaGRkd2QyRXRLb3FkMDZlalJMT2dMakFPbW9ZQjFGN2sy?=
 =?utf-8?B?ZnllYTlONHZiRExnUzNMYU1nYlBYSW02WjNjaFFGa2E2a1JZYmtkb28reTc2?=
 =?utf-8?B?OEhmM3pkMFlwK1VKY3c4TmNEOTRuMWpNMlNGRktqMWloQ0xJQVVDTEpqYVp6?=
 =?utf-8?B?YVU3d2UydE00UysvUi9qUWRrWVVkNC9TKzBMWk9OYWhxY0dEYVJCVzJ2Vzdy?=
 =?utf-8?B?ZnhlZWgvaHNqeUpkN2NBWUlNalhTMzNpU25GWEtKU21EU2p0L1ljcFgvSzIv?=
 =?utf-8?B?WndLUWZGbzdpaGNGRDA4T0NKRnd5V2NNUThKSlpMUXpKRG1YSHhyVkZOUHlG?=
 =?utf-8?B?NFJoWUNjQnVSVkxEREJrZVRXOTBjMmxJNkkyZTIrMGZ5QS9md2tXS1dqd1Bo?=
 =?utf-8?B?dHJyT1hpN1RENXcwT2ZScFFReXgzVkRsc2R0Y2MyR1BhM3ZUNGRlUHZxb3J6?=
 =?utf-8?B?cnBpL1hrYVg0dEp4YWU3MVpTTUhMUHhscE85VXZ4WXF0T0kzaWZoQ2d4aUg3?=
 =?utf-8?B?TzJDaE5VKys1eDN6ajVNNW82ak5sL0tkVHhKQWV4VVVYT3o4YS9ZcHBaam1U?=
 =?utf-8?B?dDFneHV5cUdMcUcySUZxZTBLajJzdU5raFk3NDNHNXVwdzdCYW1ySTRZcFYx?=
 =?utf-8?B?VjlKZGI0SUhyWGJob0VQeDNaU2tIeDlkdlBQaktJUnIrdVFOTmIrZDc4bTQw?=
 =?utf-8?B?ZjR4TVM3elVnb1p2Z0MyT1pHVFlxNlhjNXRkNEdPR3NDY05WM3l0bStzeEVp?=
 =?utf-8?B?Z3VjWmMvcUtnamd2SVdXNlI3QkQwanRCSEZWODUwaUk5Um5Uc3czT1J4YUE0?=
 =?utf-8?B?dmt2cWtJMVJmRk9kS1BMSVJTRXpkM0dWUGJNUFFMNkFCMVExSjJlakY5QTlz?=
 =?utf-8?B?TzJkYmpuVVBUM0cwaEtoQWR5ZzNUemhYQWQzKzVEbVdWRmdST3dDNWJDQnpQ?=
 =?utf-8?B?RWRSTnhjN2NyaVFYYUZRM3JLeEhYRTd1OEVqL2V4U2dObGJFaGdkd1R6Qzc3?=
 =?utf-8?B?SUdEMW1xVW9XdHNBYWlTd0xVQ3k3T2tTSXNhbkVMa2FnVzVJa25lazIra3cz?=
 =?utf-8?B?b1hhbDlXNUl0aEpHYkpSNGppYXdNVytyVDdaRkZ5RGIrd3kxN2lzeXBxb1Y2?=
 =?utf-8?B?Z1A0M3huVjRIWGdQa09TaTlVVUV4Y0dMamNFRmt4SGV2VEp0dDc1Q3JtN0hR?=
 =?utf-8?B?RzQ3L1RpS0svM0NXNG53VEh0bHNCT2tTa2RwQ3lYRUNvQm5ZaG5EN3dId2dY?=
 =?utf-8?Q?LuzfNYDx0vA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bXBxdCtYd2xJNU1GUi9GNFphSWhXTEpaM0tTcEk1RmVKd1hBY3lZRlVFU1pB?=
 =?utf-8?B?VFdXOWxuaG9SNEdrVnJlVW8zSnZFR2FKYlM4YkRQVWhSczN6aThKTDhzL285?=
 =?utf-8?B?c3BXMWM1djV3MFdwZm54SytTMVRXeFNkYWZQZ2htRTRHczF3dlQ2UjM5dm9B?=
 =?utf-8?B?VVZXWjF1cmE5T2Z4QTVWWjJBOUZsR05XTnFaS1lwMFVISkkxUUlWdXRYUGJm?=
 =?utf-8?B?ZjRaSGRNenpheDVqN3lxSEFmcWtWWXdUSzZRWlJXMnZ6SXZkM0p6UXFXaEdw?=
 =?utf-8?B?NVVQU0t0UG9UUTg2czM2T0VoVSt4SEErNjlzY0UxeXRHTmk3YURjb21wS1lj?=
 =?utf-8?B?b05LQ0NMdVl4Mnlsd1h1N1dXNUNxOW1QVnF2YnlLWEwxYjJXelNBRTB5ZXFo?=
 =?utf-8?B?MFU3UmlLeFlmc1Bza3lVbldGeGpENjg0dzRqRFl4KzFackhYY3dYeXdPd1Mv?=
 =?utf-8?B?bXdJV0dkaWQ3ek5mMGpiTGljK0UxSGtlbHZRa2ZTaXQ0RWRFS00weWh3MGVl?=
 =?utf-8?B?Q1lHR3ZFWFcvL3Y1TU1nOUMvSFJ2QVJ1eFVWZ29KejczNWt0bm12NjVUVzFv?=
 =?utf-8?B?amtKZVltRHVLbzhQczNrYzlJR0t6WngxdEV4aEMwWXNCckZMNGdzTXR5eVhx?=
 =?utf-8?B?YzZqbEk4VmxUMmlHaDdRRmFvdmRyYldIRERVRmNSdU4vSDdNUTdDVXdvUllw?=
 =?utf-8?B?N0kwdDhvME5MRUxVY0ZuSHNsTENtTHF2NzQ4aTd5QnJHRXlDSGxjdkVEeG5m?=
 =?utf-8?B?cmprRTRLN2EyRG1zNnpBTnBVRXRYa3ZPZ1kvblNVYnc0NEhhTG5IU3VoYkJL?=
 =?utf-8?B?cUc0M3JzdUU2eXBxeW9uZkdSRW5BTGJQTVJXZ0tQclBuc1Z3UzRrVnZRbXMz?=
 =?utf-8?B?NndwVldTSW9wTXpralJYY3V4VldSK2Rhc3JqZXlZWmdOd1czSThqWnF6dm1n?=
 =?utf-8?B?Ukl6UmNva085a2VJUDhBOThlaWdvRTZzVzdpUEQ1QjB1OWVNdzdHOXp6KzRC?=
 =?utf-8?B?UmdvaFBDUXJwT285Q1VWU0hNVTRWcG9xK0t2TlZoVUlJSGxDc0xuSjNySlds?=
 =?utf-8?B?MkNDaG9kalFRZXNCSVFvTk5LYWIxN3p1dXpJcVR5bjBnNUtRNU9sNEhzdCsw?=
 =?utf-8?B?VktMK0lKMW14QTFuMklEOGRYRDMyaVIvclQrbk41eEU1ZmU5aE4zYUo2WkJo?=
 =?utf-8?B?cjRreTNCaE55WGluOWJmMDdVeXUwWnhBcUNYTnVzOC9TTUdSTnNRQW5Dd0ZV?=
 =?utf-8?B?dVo4RmtaUVZFVWMvOXprdnVCTHlGcmlCbDBXdkYxTmxQcWRvdXdQM0FkNDRn?=
 =?utf-8?B?ZmU0R3Q4aTh2QXMxUXN6Tmk4enAzcERBS2RydlY1MzNUeEp2VFFpeTd2d0Yv?=
 =?utf-8?B?U09TTmtZQitBSG1vWDBmaUhWTnJXT2JsaW9PNzZtdFB3anBTc1FJdmdRUDIv?=
 =?utf-8?B?WWZqSlo1ZEU2d29LRlk4aUhhM081aVBTRzNPZnFGVm82WGtpdHZVbHl1TlIw?=
 =?utf-8?B?QTh1RVROWWl0cXJvdXRJcDFrNSt4RXcvNHJtRHVBQ2NJYVRmUE9wSi9FNC94?=
 =?utf-8?B?Smt2RlNiaG5WVGNJYW1pOUJtUlRFOFZOOXhvdExtekYrdWZkaDFhY0lFenNj?=
 =?utf-8?B?WHpESkd1dSticmtOVDhJdzlnNG9uMFVpWHdKVmhhSGpRYWJseC9mSFIwenhp?=
 =?utf-8?B?TTBTbzRRVUN4TUE1ZDRMd1IwZVdlQ1VSQkhxbUR5RjRkaDk3Q29XUU5TWmlr?=
 =?utf-8?B?bUNvS0hselZlK2xTcGx4OHZ6SlNrWktpV3dyb2MzZEE2dDRiSiszZXZRQUUv?=
 =?utf-8?B?dnV0L0VmTWpKTjZ4VytLMndZOGdVV1l2ODY4THFIU2xxbUZyeHJlYitEWmlV?=
 =?utf-8?B?WVFTUFdQL3pmSysrMS94NW9ENWtQOHgvbTJiMXIxQmFzc0VxWmIyWVYrYWli?=
 =?utf-8?B?ZGd3ak4yMmMrYzh5SElnMkw3YUx0SHRYWUhja0krU3A0aHdVclNBd1dxQzE2?=
 =?utf-8?B?V3VUMmVXWWdjb2dPZXhhV2htY2xnQ2VzNTBadlk2RldwSGMrU1psRGhJcmty?=
 =?utf-8?B?OGJtT0RYS1VmUjEzUGx3c3Y5ZVpnVmJPRVNDcXE0OGp0L2RjMnorOUJrbHla?=
 =?utf-8?B?STI3dVk3a3ZJVEZCNER5RW5zZzdVUmFjWndEUTIrb2VOV2JtaytacDNNSG9F?=
 =?utf-8?B?c1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f502ca7a-d451-44f0-b0ed-08dd9df7963a
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2025 14:54:46.2030
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A3gyE4wRfV/i4LQD31fVG2cv0ZIBneUJyyruZscqBmnYSTS08wBBov2bDP5uPhklHBdLSrH1ZNNkzKkqRadAM5rburKf100DFaIXd5O/0Pk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4815
X-OriginatorOrg: intel.com

From: Jakub Kicinski <kuba@kernel.org>
Date: Tue, 27 May 2025 18:57:49 -0700

> On Tue, 20 May 2025 13:59:02 -0700 Tony Nguyen wrote:
>> @@ -3277,16 +3277,20 @@ static u32 idpf_rx_hsplit_wa(const struct libeth_fqe *hdr,
>>  			     struct libeth_fqe *buf, u32 data_len)
>>  {
>>  	u32 copy = data_len <= L1_CACHE_BYTES ? data_len : ETH_HLEN;
>> +	struct page *hdr_page, *buf_page;
>>  	const void *src;
>>  	void *dst;
>>  
>> -	if (!libeth_rx_sync_for_cpu(buf, copy))
>> +	if (unlikely(netmem_is_net_iov(buf->netmem)) ||
>> +	    !libeth_rx_sync_for_cpu(buf, copy))
>>  		return 0;
> 
> So what happens to the packet that landed in a netmem buffer in case
> when HDS failed? I don't see the handling.

This should not happen in general, as in order to use TCP devmem, you
need to isolate the traffic, and idpf parses all TCP frames correctly.
If this condition is true, then napi_build_skb() will be called with the
devmem buffer passed as head. Should I drop such packets, so that this
would never happen?

> 
>> -	dst = page_address(hdr->page) + hdr->offset + hdr->page->pp->p.offset;
>> -	src = page_address(buf->page) + buf->offset + buf->page->pp->p.offset;
>> -	memcpy(dst, src, LARGEST_ALIGN(copy));
>> +	hdr_page = __netmem_to_page(hdr->netmem);
>> +	buf_page = __netmem_to_page(buf->netmem);
>> +	dst = page_address(hdr_page) + hdr->offset + hdr_page->pp->p.offset;
>> +	src = page_address(buf_page) + buf->offset + buf_page->pp->p.offset;
>>  
>> +	memcpy(dst, src, LARGEST_ALIGN(copy));
>>  	buf->offset += copy;
>>  
>>  	return copy;
>> @@ -3302,11 +3306,12 @@ static u32 idpf_rx_hsplit_wa(const struct libeth_fqe *hdr,
>>   */
>>  struct sk_buff *idpf_rx_build_skb(const struct libeth_fqe *buf, u32 size)
>>  {
>> -	u32 hr = buf->page->pp->p.offset;
>> +	struct page *buf_page = __netmem_to_page(buf->netmem);
>> +	u32 hr = buf_page->pp->p.offset;
>>  	struct sk_buff *skb;
>>  	void *va;
>>  
>> -	va = page_address(buf->page) + buf->offset;
>> +	va = page_address(buf_page) + buf->offset;
>>  	prefetch(va + hr);
> 
> If you don't want to have to validate the low bit during netmem -> page
> conversions - you need to clearly maintain the separation between 
> the two in the driver. These __netmem_to_page() calls are too much of 
> a liability.

This is only for the header buffers. They always are in the host memory.
The separation is done in the idpf_buf_queue structure. There are 2 PPs:
hdr_pp and pp, and the first one is always host.
We never allow to build an skb with a devmem head, right? So why check
it here...

Thanks,
Olek

