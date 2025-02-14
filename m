Return-Path: <bpf+bounces-51570-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55FA2A3623A
	for <lists+bpf@lfdr.de>; Fri, 14 Feb 2025 16:50:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B37513ABFE7
	for <lists+bpf@lfdr.de>; Fri, 14 Feb 2025 15:48:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E70C267396;
	Fri, 14 Feb 2025 15:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HVb/Gied"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4C22266561;
	Fri, 14 Feb 2025 15:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739548083; cv=fail; b=QwryFsEetL+yZtycNjvMS79+BfJK+ShUDfZ6mFRIyFMYvqlh0SnG5wnAiTkrHWnSeWUJz2IryHrjomyHV7wG78Xum7qUf3T8lk/DG43B9NflzpqR9tiIuC+KZiokwt174hgXnG3o1iA+zu44ouJqmoBPTFhIhnM1Jr6D3y8uy+4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739548083; c=relaxed/simple;
	bh=en9oyin3YN3zui2QJxRd0yIpTmA+YiEWpNcHzXk8pvs=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=nd5gdvOa1VEv/M8cElWVSgl/J7mypSQGhOqbBLVcjdR6cT2NWOj4BE8avOU8SAEqGQNy3cEUmyTitMmYNj0zpzmOpHL8eTR81hcl6zYr4aSMkw6oI5ZLb0rxiw46CNgEVEkWpmC4wo75TBKjGzMM2SoeQbQd1SpFxIAIGYIHFs4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HVb/Gied; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739548082; x=1771084082;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=en9oyin3YN3zui2QJxRd0yIpTmA+YiEWpNcHzXk8pvs=;
  b=HVb/GiedfuGFcEoHAemw5pshUNZWPA3l0qlsHgye62fLqD5/mjmmeOdm
   ETPFmjmoUW4FGJv4p/7hbDEgWHYnh+Jx/Dwj0YompRCT9moXSOBVkcytu
   NYGIC6CN8x624zU1jCB8jlr2HAp+buRyx0E1Kj7x5lHX8V2/TPZZtbMw4
   K/6pJ3hAI3cR1hhtMkdXQYw/4ize4pBpDDOXCi1f+PafLxK5ka/7eDxO/
   sPoMHTtKBoXZriaqnppDDxkZnhn1VJwqyaHN7MMXu8uiJSvk9IuJsAa5X
   2kq9WoxbQDJkhE4FsJxq+/pJ2gotl+u5cx42KoPaVSujQ6OSaUnU9uAKG
   A==;
X-CSE-ConnectionGUID: s2EKF6XqR22lsSef4+B10A==
X-CSE-MsgGUID: 1a0MIV+PRaaOHpiDYUBX8Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11345"; a="57832889"
X-IronPort-AV: E=Sophos;i="6.13,286,1732608000"; 
   d="scan'208";a="57832889"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2025 07:48:00 -0800
X-CSE-ConnectionGUID: A1TCzCNFRn2xdAcQRtYLHA==
X-CSE-MsgGUID: 4/6AfZH2ReqnG+DFTmCdQg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="144420314"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Feb 2025 07:48:00 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Fri, 14 Feb 2025 07:47:59 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Fri, 14 Feb 2025 07:47:59 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.170)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 14 Feb 2025 07:47:41 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pVC0kntszSL94HtWXBNXmIVvKC6s93EQ5Oj+2hMBhG/FgaIiw4xiTy+TbM8pQV1k6JEl9uGXSLyNvoPaqcLmdS2TYCrrWmFjT500uMNuhcflW57OcQKSgMSskHwbyjaOa1BVBibShw6uFlyyTMMd0OA5U4rB1g37jrSFNb+E1ShLaEmGG5aigesjK9cvWp5J1QkoX24rVB8kJ01zm9Svw3a9EVxXFHtbIdGrUjKtmwActHkQTiPLpd6ReQga8Pbe+BLcY3KY1T92GBGfjMAuNoWBzcf4/vDvPRDw6buEhtw09/WBQeaXvBjuHhi5DAPYs0ee75YG4334aOobC5SQ2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=re8iyX94moOePodvVHv+EJabjO6vTzkwmFsZODxPfEo=;
 b=hTN8uXjMtumxnLlTs/h6kRW/zL0MPdX+98QfECV7fXbumyGmOP/aIZi8TU7J+cuJjujTlImSIBmT4bG2EJJUH0MPKdBvkDfIA+Juew2RrprqXk8Pu60M8pk7hm8Q3gS7JtJo9zfo+RNRUrqSJ9sXNxHTYbDxQMLWUjiDTuWt+YpbQZMAY4JWwErjxtXVIJdl3UB3zaFNOOjY88YbgYJ4ZF52kuUFbBJHcgGsS8nK87Xdf8EH9miBtW1/G1zeQAAZVUJkUqhxz2NKpqluy3BKOUrx10ruGp6ngN/fdJuOFoCM34f+g2c4YI3gcGS/ouaIULzfPi1IsQOQb7E3YJhBEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by SA0PR11MB4688.namprd11.prod.outlook.com (2603:10b6:806:72::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.13; Fri, 14 Feb
 2025 15:47:39 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808%5]) with mapi id 15.20.8445.013; Fri, 14 Feb 2025
 15:47:39 +0000
Message-ID: <6311be48-641b-4411-bf6d-d97a643a5806@intel.com>
Date: Fri, 14 Feb 2025 16:43:09 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 0/8] bpf: cpumap: enable GRO for XDP_PASS
 frames
To: Jakub Kicinski <kuba@kernel.org>
CC: Eric Dumazet <edumazet@google.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>, Daniel Xu <dxu@dxuuu.xyz>, "Alexei
 Starovoitov" <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
	"Andrii Nakryiko" <andrii@kernel.org>, John Fastabend
	<john.fastabend@gmail.com>, =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?=
	<toke@kernel.org>, "Jesper Dangaard Brouer" <hawk@kernel.org>, Martin KaFai
 Lau <martin.lau@linux.dev>, <netdev@vger.kernel.org>, <bpf@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <20250205163609.3208829-1-aleksander.lobakin@intel.com>
 <79d05c4b-bcfb-4dd3-84d9-b44e64eb4e66@intel.com>
 <CANn89iLpDW5GK5WJcKezFY17hENaC2EeUW7BkkbJZuzJc5r5bw@mail.gmail.com>
 <7003bc18-bbff-4edd-9db5-dd1c17a88cc0@intel.com>
 <20250210163529.1ba7360a@kernel.org>
 <0a8aac38-a221-4046-8c8a-a019602e25dc@intel.com>
 <1dd14ece-578b-4fe6-8ef1-557b0f5d3144@intel.com>
 <20250212102936.23617f03@kernel.org>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <20250212102936.23617f03@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VE1PR08CA0009.eurprd08.prod.outlook.com
 (2603:10a6:803:104::22) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|SA0PR11MB4688:EE_
X-MS-Office365-Filtering-Correlation-Id: 740c84ed-41a9-4c3c-c574-08dd4d0ee8fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dVBjUTllREdQNUJrZGYzODdaVnVNeEF6aUI5Si9kQlArOGtTQjBHVndzTUhI?=
 =?utf-8?B?NTM1aXljalVvb1liSUdLSU1DeHAvbkVqN3MvN3BHK1plR2hkOEpCdFY1Y1hH?=
 =?utf-8?B?dmFIK2d0UHp3cEFBN2xxU2FCU05MOGZPT1NFL2RQc3orZFBlOUNyMEZ5aXMw?=
 =?utf-8?B?cDJoZUZ3aFNkSU01Y1RzZGRUdXFoamUxeEpVcnRLekhaYXYzQ0MwMXZSbUpR?=
 =?utf-8?B?TUhpa3NHNXdFTHpPaVc1bXMvb2FvRVFKWlN0a3lWVnl1SVBrQ1BIMzFpYmtK?=
 =?utf-8?B?NEEwM25rdU1GQTZ4THlEcW9Md291ZEZPalNDbkh0SldFRzBTM3FIaldZZXVv?=
 =?utf-8?B?dWxiNGZ5ZTVERXd6QVZ2N3JHVnVaQTRXMUs3Q1Q5MjFhM1A4VGZyOEd5aXVk?=
 =?utf-8?B?NjVPUnpBc1VKT2hlQjRFSlRlNEZQQWcrTm9KRWdvNGxoemE0Nm50Q2tmb2E0?=
 =?utf-8?B?cnZDM1ZRdUF4NC9YbHUzWldlUEFKYU9JYTU5ZGl1ZDhMaUdSZzR4SVpxY1Vm?=
 =?utf-8?B?WE1XdFFwWFpyQ1VsaEJ1SDMzbmVoV2dYNERoVUlOMWF6c21ybEIwV2pGaXZ6?=
 =?utf-8?B?Rm14bVNVdVNFZGdHUTZ4aXpsd2pHdHRUVk05dHZGb1c1TEsvWkgxdmRzblQ0?=
 =?utf-8?B?dmsrNkNFellXc2FtNUVSaEgzYS9OMTYwWGpvWmViZVhhOWo4MEs2cjJPR2Jj?=
 =?utf-8?B?OSs4NEppNXhrYzIzdmE0dkRTSGZ4MlowRlFWTDhxb3liQ3g4WERkaTFvMkxk?=
 =?utf-8?B?KzFUZ09XTFBlSHpEWW01WHJ6N0R0Um9TNjAwMlNrMUllOGYyWEF6a2h0dUto?=
 =?utf-8?B?clEzYkxTaW1OVnhNRjNBS3REMFF4QVA1ZWV2U2VncGNLUEVVcjNsTEJUcUlH?=
 =?utf-8?B?Z0ZBOW9mVXlROXlQNHVPbllEV2lOcmJqd0tGQlFLWUpUQ0sxWE9EK25oRmVp?=
 =?utf-8?B?TGxpU3BjUjJURDI2OTlMQi8zOXI3b3lMdFRWU3A5dTJlOEFEazFEeEQ5UTV4?=
 =?utf-8?B?M2pOLzQzaWdGNEI2NkpyaU5mcmd3ZnVoWkpyemRtWlNaTzU4djI5eEU5NElY?=
 =?utf-8?B?ZllUV2g3bDJBU28yVFVjS0Y0eERJZXRHODJCM0pCZ2psQnAvaFlra1BLaW9P?=
 =?utf-8?B?SXdhb1M0Q2tVcWViSEVxNVpYbzQ1OWsxSmt6V3hLc3RJRVlrRnFBcGd1OG9w?=
 =?utf-8?B?UVFKcUxqZjJiRkM2VFYyQVRSYkxvTmdSWVpjbzJoOXZHc0sxOUx6dEN4ODBT?=
 =?utf-8?B?SEhWN3ppWjZVeGNHV0s3bnJRY1ZsWnlRMENEWVprSTB0Ym5mVC80S0s4Tm9W?=
 =?utf-8?B?MkNqNzA5UzNwbnhXMFgveE5hZmsyR0xTa1owc2hNNXNnY1JmbEF4NFVsWDJC?=
 =?utf-8?B?NEttd01JTjlsSmgxWGh0SUhkOSszei9RdFg5MmpLaTlOUFlvRWFkWmtDS21S?=
 =?utf-8?B?UU41QTdITmJ6UHdJWmxCRTl1ZFlnVnVmeVk2M1BDVmxWYTdyZFBJajlIeDQv?=
 =?utf-8?B?Zjk5Z1BhOXNHTFVvaWtRcGoyelcySjYwaG9La0RydDU2Uk5ydXJlRTNJUHhp?=
 =?utf-8?B?VjlLMVZCWllMUHJYUTV3U2U4S1RYTmlaUy82L0tSSVp1bndOcnBYSkxMdkFS?=
 =?utf-8?B?S0FGaEc5MkIwTzhMS1BiOTVWU3ZwZUFNTEZzOFo3cml4bDBzcTBPRWtJa040?=
 =?utf-8?B?ZVRPeXFHaFNScEttalNxdEl6UlB6TkI5cmhCSXRmQkp6OGsrMm1sM3cvWU5B?=
 =?utf-8?B?WTNnRkI3Y1lybjZaL09LS3RieGZlclVPRzlnbEpvS1lIM0xqK2xIbms5ak5i?=
 =?utf-8?B?TzFlNi9PNmZIa1NBRmE5MlhxdmJJNWU5UHdpelRyYUpJRjlwTHhxeWZEL0dJ?=
 =?utf-8?Q?2gLr5UmuO9JW9?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TDdhNDdZVURiYzZ3Rk5aRmRacitybWxaalVHeHVUbzlxcjQxQUk5dzdsdmo0?=
 =?utf-8?B?b0VvQmM5WGNEYW13eVhNU1FCelEwVVpvdWRGa1ZMbDBpSmJPSlpLaGR4ZXJS?=
 =?utf-8?B?aks5NEtyaVMwdlEvZ3ZmOEptZmh5ejRDUlN2aGIyUE1sQmcyRWtvL3lSM24r?=
 =?utf-8?B?RzdpWHBjNlBtZ0xHUzhVa09ZZmtQNnQ0OFBYVE9tbk4xUEZEbnIxTUM3RGFi?=
 =?utf-8?B?NWlYRTBWZ3JUNEg0T2MvSUpTbUJ6MzAwWjl5Vmxrb0lIeUtzcEZwaHBIbUt4?=
 =?utf-8?B?N1ZOK1hCb3VoSUF4dXExMWxoNk1MR2RwRE1ObGZOYVdxVmNFM2FWQmtFN05p?=
 =?utf-8?B?UVhJbWRxSHJiaER2Y1cyUWRvTG9JTExyZ2RBVlFhYlpmM1JCRUt4TTJEcjQ2?=
 =?utf-8?B?azh3YTNob1Y0OG5qVUNOcWp0RzRqSlNIY05aWGRBVU9IK1ROYzVETlN3T3B2?=
 =?utf-8?B?RmlTbVZKc1c4dE9ieDUvczM3bnI4ZGxvUDdEM3JVbGREbjFVVUc2NXFjRXpo?=
 =?utf-8?B?bkxnNWhkcE5lWnNHbmJnZGhnaG9Ia0c1TXV3S2VlOG8wbGhBMkw0Q2hSV3Rt?=
 =?utf-8?B?d3lJeURIV2dSRFpYeVMrdDR4R01lSWhNaGlSSTJTei81ZWF3UmFVNTJ5enZq?=
 =?utf-8?B?b3NmcU96dUl6bW05L080U1NBOHVhZGpQQmpPK3JmMGxOWmxQd3NDQ1JDWWpx?=
 =?utf-8?B?SnBEZFhqNWU4cnNrcVhtMGk3b2V6aWQwYnVvdllheGZjN3FUZnZ6TEF5dFdq?=
 =?utf-8?B?SXljdkRNYnp0YzNoTnlEaGxEVmdRU3ZDbnV5KzR4b045aGtyR3ZkVWRxWUw0?=
 =?utf-8?B?SzF2b1dnUmRFd0N0TmJDZUFQeXU1MU1NRCtjRHVvcEhuT0dHWnVyY1dFSnpO?=
 =?utf-8?B?RWVpa2cybG42cWFTSEU5QXU1ajk0VlJScjk5Y2FkOFIvbEVqNk9sOVMxSnRW?=
 =?utf-8?B?Z1pPSmYrMGluNWpZMXUyVmE0SEE1eHo3QnBVOG1vTGlYNHlOTU5ONmNhQW9X?=
 =?utf-8?B?b2lnSlErVVRRanlDRVlwTEozdEEvcEdEdW9RVGxiUjNvUDVnM25QSjdkU1pE?=
 =?utf-8?B?SThMRGxaN3hZQnNNeW1RU1VPU0FvUHhOY0J6a3VlNkk0OS9sREo3eWZNWW95?=
 =?utf-8?B?TGxoVERaaVplWlFLcU9jakR1WEM4akZpK2s1WVB3S0VWQjlRZUI2YU9IcVVr?=
 =?utf-8?B?WDA3VXNHYnZ0TnZHVTliN1hhbk42eE9pR3hwdG5XWUJma3J6RzkrSTRwQmRw?=
 =?utf-8?B?bjBFblg5T0dyS1d1RzRkWUs3SW1rWGtJT2lqNUw2NWJSWXhFY1FSVnMzdm5E?=
 =?utf-8?B?a1V4NWhvOE1WeXJ3aXZ1TFZuNWx1aUluRk4waXFxOVA0ZEhQc0Z5UDNVTUFZ?=
 =?utf-8?B?WnZXZERUd0NhOGpiVTRpVXJaUVRiRUdkQXZRZ01iRmp0TEJ2RlVSQkZsWHRS?=
 =?utf-8?B?VmY0SVQ4UTRhUlJFRjVZVGI5WHhhbzF2a0pJWGw3VXdVMkc0a0UzQ3ZvR3ZQ?=
 =?utf-8?B?ZFRiQTJaZWZFME00VUlUMkdLRnhZTDhDZGErdGp0azdaKy9ReHB3MDEwSVVD?=
 =?utf-8?B?VDEvUEJHbU90ZGRXbGdtNUJ3TEx3dC9RNUdWeWdSU25aL1drOCtlMlhjazdh?=
 =?utf-8?B?aENwYUpTbHJMcitKVXlhbVd2YThuSVpiNkt2TDJHMi9pc3h0STdpQ1V0RmZD?=
 =?utf-8?B?eER1S1RUbi9oN0JHakwvWUFYd3N5cGd4WU43NWZzYlQvaGpYWmFNSG9MZlRo?=
 =?utf-8?B?SjN6WVpHUkR3Q2NkdmJGbDJPTjZMbS9paWNIOXd0OXQ5K3VkdWZFbTA5L0xo?=
 =?utf-8?B?bnl5cEdsUHhIaVNWUUpuSEE3K2ZlL2YxRnpZcXNhZTh4SXo5Tmp5MkQvbHFU?=
 =?utf-8?B?STFBS2VLb2kzQ1JuSlNvbjF3RGFJc2FMTzk1RUQwNmFnLzRLV013eXcrVlNG?=
 =?utf-8?B?ZUJrMkgzNW00MzBqTmdKaGtwSDJ4UE00aUl1UjlUcDBOck80ME1nSDZWMWxB?=
 =?utf-8?B?dUVEOGYrRldnczd3K3FsdVRHbjJYY1VPemRzeHFCTFRwNmVMUzRWSUJzbm9j?=
 =?utf-8?B?V0lZUTZLUk5BeFZQK1NEOEIvWkNHVlRzMEY3aTA4SXlTK0hkVERmNzIvaDdB?=
 =?utf-8?B?dlRndmdKY3BvL3RWbFVYQ2NpYmEwKytaRVhLWlAwdjViUDBjMGhnRkJFTS9l?=
 =?utf-8?B?U0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 740c84ed-41a9-4c3c-c574-08dd4d0ee8fd
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2025 15:47:39.1806
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u87GRh6tGiu8wOcaS7UnPhFUoWyMDXyINmK9vrm0HE0GHDWwIShHE5mmN3eqEHZNXzcfUAGwCF+cNjii9JfwcYmN7ZFIhtJj3cz7csOl9LM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4688
X-OriginatorOrg: intel.com

From: Jakub Kicinski <kuba@kernel.org>
Date: Wed, 12 Feb 2025 10:29:36 -0800

> On Wed, 12 Feb 2025 16:55:52 +0100 Alexander Lobakin wrote:
>>> You mean to cache napi_id in gro_node?
>>>
>>> Then we get +8 bytes to sizeof(napi_struct) for little reason...
> 
> Right but I think the expectation would be that we don't ever touch
> that on the fast path, right? The "real" napi_id would basically
> go down below:
> 
> 	/* control-path-only fields follow */
> 
> 8B of cold data doesn't matter at all. But I haven't checked if
> we need the napi->napi_id access anywhere hot, do we?

Hmm, if the "hot" napi_id will be in cached in gro_node, then maybe
napi_struct::napi_id could really be in the cold part, let me recheck.

> 
>>> Dunno, if you really prefer, I can do it that way.  
>>
>> Alternative to avoid +8 bytes:
>>
>> struct napi_struct {
>> 	...
>>
>> 	union {
>> 		struct gro_node	gro;
>> 		struct {
>> 			u8 pad[offsetof(struct gro_node, napi_id)];
>> 			u32 napi_id;
>> 		};
>> 	};
>>
>> This is effectively the same what struct_group() does, just more ugly.
>> But allows to declare gro_node separately.

Thanks,
Olek

