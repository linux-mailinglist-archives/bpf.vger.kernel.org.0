Return-Path: <bpf+bounces-47043-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A53D49F3541
	for <lists+bpf@lfdr.de>; Mon, 16 Dec 2024 17:05:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8FBDD1883EB7
	for <lists+bpf@lfdr.de>; Mon, 16 Dec 2024 16:05:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93C5714D70F;
	Mon, 16 Dec 2024 16:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NY+HGrwO"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5590A14A0BC;
	Mon, 16 Dec 2024 16:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734365094; cv=fail; b=Nh/cJslBpP4Z4SYlZYkdPI/QF5DiPIYpsBCzPI7vsq6A1ktAEh1uTaUZ6+Fkm84BueHaYn24V6PCClN9VxRyL3BMgN/xstwK2QGw7j9IcaLreIKLrJWBG1/q3A+G+50Mw8sJ4OgX8/gXhf7onTrEsMPbTTegkc7nPxN3mF1XUvU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734365094; c=relaxed/simple;
	bh=r1RnwUiqPjgtD21V4TV3EhUf64EEybrtmTmCZuKWc1I=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=d3V/ayGPNiDdFKkFrLsm+6AiUNsbCXrEsPIDf2oStuEdQpt4ZNUS9u2BaTMxRd3HcVLvrJMTM5I17lOYlPMszFbWGmpeU9PQgQdxevOkjMWscxWTUy/tEp6FCrK17BUKwoj7uyJccdsJEy2ec09alf4zIfreiSvTiDH8SoHAn+0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NY+HGrwO; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734365092; x=1765901092;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=r1RnwUiqPjgtD21V4TV3EhUf64EEybrtmTmCZuKWc1I=;
  b=NY+HGrwOemIEBqIXDCvlv0FpKV2vU91b8bpFQ0jPRcdx09qkpu46RGZS
   dXknOsPjl07O3rDxPGwentT3eQpi+9WHMtjs7RbbCKPv6Ejiq2LstJbD9
   SYz1lzRbvquC3qsy5hi1j8V2D7uaYi93oWkqsyb9uCE6+40zQ8g515kXI
   xxU93XrVulWksjhGGo/HHScgt66uNOnE7WdeAm1r+pwd5v+uDHtXGKHis
   LjNOyRvuz/nQx3K2ssN8+AS61cfmaUpVhIktLX0PD9u+o/mKn+SomVY9P
   DnCXetPkZkUCrVbOeIiBHyjvXNX4VJy4X8KhONRnRgEYCDfiY+D7wwDs3
   w==;
X-CSE-ConnectionGUID: Qqr1JHxURnWD379hJL2TNw==
X-CSE-MsgGUID: g6DyNCjKScC92lCLhyInzg==
X-IronPort-AV: E=McAfee;i="6700,10204,11288"; a="52278520"
X-IronPort-AV: E=Sophos;i="6.12,239,1728975600"; 
   d="scan'208";a="52278520"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2024 08:03:53 -0800
X-CSE-ConnectionGUID: B9pUZRcyTteIIHf6m0R8IQ==
X-CSE-MsgGUID: YkrY12WER4G8Pbs+J0lF1Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="97688579"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 16 Dec 2024 08:03:53 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 16 Dec 2024 08:03:52 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Mon, 16 Dec 2024 08:03:52 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.173)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 16 Dec 2024 08:03:50 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UJwBZUlx5gXCkG/L8A7UXTA/rk8DybfAvb4ddOehk3i0w0wbcaJGnO1Df05yDz/rRyBS+KHwndVa55Xv25mu42oaNQeZjkNqDPEKMo8Rhkg9s9HSNoDOJtK8e3CQMaPYN2VqOPFD42nYDWBEMO39blG3mo8h4jiCMHt7S2Y0lolyl4RR6VE00lVRjEXwKVYmCQvCPm//wLeLa7TtMTu3B48Ju2zUTgE8yD2TzVHbastijUzbxABLVPaXpzjSfg9/yLSPfIwzcUXBOBWy5SBX+Z9p4Ljb9VTc6cgEZrUMvzurgmqcXxQBiiemg/JTAp3jS2jUJT7UMhxHxyCnAEoUuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DDn/pYQVTdoKQoTNmPZhxBUpdwfetYhB6Y29zVVQIGk=;
 b=L2Gp5XqT4KT5FaG1fDBQijR6Kd3UR71cj3GO95dcRvPS99/rmF5VDKrAZbqOg/Em1D6VpVbKAL0U7a9WS7l7xhwt5DtyRsgqEuuUl29UKKlqM2+oL/ua7RSflR28JWGL3djxZ8JRTpwGXd8tCzBZezZR/dqGsbLU+OZUuUiVKnJxo+WQgz8K0HJsC9E7/ToyBkdyWumOXk4nH7tlXKgRnDBXIUnfAW2McZxU6AwdJrPnPHAkvea+BJ6YYPQj9GpCDXxa7i/fZbGLcaj+FJUsozoL6OC+L/Kcdd2T1U5jz4Def/9PWlRYcMlvyEUFxaW6icL+nAV2Hv24zV+kwMQxDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by SN7PR11MB6922.namprd11.prod.outlook.com (2603:10b6:806:2a9::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.20; Mon, 16 Dec
 2024 16:03:06 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808%4]) with mapi id 15.20.8251.015; Mon, 16 Dec 2024
 16:03:06 +0000
Message-ID: <24a07b8c-0217-4186-a65b-b14405b56cd0@intel.com>
Date: Mon, 16 Dec 2024 17:02:42 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 11/12] jump_label: export
 static_key_slow_{inc,dec}_cpuslocked()
To: Josh Poimboeuf <jpoimboe@kernel.org>
CC: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov
	<ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, John Fastabend
	<john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, "Peter
 Zijlstra" <peterz@infradead.org>, "Jose E. Marchesi"
	<jose.marchesi@oracle.com>, =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?=
	<toke@redhat.com>, Magnus Karlsson <magnus.karlsson@intel.com>, "Maciej
 Fijalkowski" <maciej.fijalkowski@intel.com>, Przemek Kitszel
	<przemyslaw.kitszel@intel.com>, Jason Baron <jbaron@akamai.com>, "Casey
 Schaufler" <casey@schaufler-ca.com>, Nathan Chancellor <nathan@kernel.org>,
	<nex.sw.ncis.osdt.itp.upstreaming@intel.com>, <bpf@vger.kernel.org>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20241211172649.761483-1-aleksander.lobakin@intel.com>
 <20241211172649.761483-12-aleksander.lobakin@intel.com>
 <20241211174000.tpnavd77pyfq7hw3@jpoimboe>
 <a4af5958-38bd-44c3-b539-8e112a0c0be6@intel.com>
 <20241214032431.algrflxqdp4jilnr@jpoimboe>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <20241214032431.algrflxqdp4jilnr@jpoimboe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR09CA0161.eurprd09.prod.outlook.com
 (2603:10a6:800:120::15) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|SN7PR11MB6922:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b36d0d7-a9ee-44b3-d1a4-08dd1deb20c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cVh4QlYwUGVvb2k0UDJGZFJMelU0dXhlSVI2eW5XMWdhRjNpVExYZTM0UmxW?=
 =?utf-8?B?bjVid29lRWlRelJ4K3lMWXAwY0U3V1JvRlc2bW9XeTJRTW82c1FTMm9DRWlk?=
 =?utf-8?B?WGNCMVNNSW5ia05HNXJWc0l2Q0VCMS85UzNseDk0WmRxSGlWV3JFQWJyZGFp?=
 =?utf-8?B?cDQxUkc3NlE3cUMvaXNVZUlLMVlKdlpBcThHbGhKb3ZSQ1RsaUF2cm8xanVp?=
 =?utf-8?B?UG5Sam5NODNBZ0VSSkdoSmZ1aGdXczl1OHNnSFhaOVJQSW45RDM3bnZIdWdl?=
 =?utf-8?B?VVMwWDhEVU02STJJYXBrc0JCcWZTdHYvZ2dCWkJBeG9hejRtR2pXTUJVNEZ3?=
 =?utf-8?B?MW9jS3N6ZU9TTkhaSVZaTzVianRhSnB2L2ZkTDdxRkRzK0p2d1BYdVQ3cmg3?=
 =?utf-8?B?VDBOZWRLZmZXZDNzbjdPR0k3Z2g0MUpCM3FpR01OekFyemJ5VlNBeUpHODlV?=
 =?utf-8?B?WGNFSFNTY2NxRFZVTXhyaWFhQlA5cGZTbHY5Zy9JSWRhSVZjVTFqTkZXVjcv?=
 =?utf-8?B?SVovTlJOZHZHaW1id1NnQnk3RmF1UTAyS2FIYTIwSWdlY3FGM3lXVzJwRXJX?=
 =?utf-8?B?ejdSRXFIRVBzTVdRckVUOVdneVJkR3drRzV4Y2l1cVI4RHpMSG1GbjIxMEVr?=
 =?utf-8?B?WncrYUlHWk9BVS9ha2x1MGpET0k3K0NLVlF4MkhzRnp4ZStYcXJ2SU9Sdng1?=
 =?utf-8?B?UUhrZE4vOWp2TTgwa2wvbXJtSGRlSWErT0pOZ2psdmkvMGVJM0ZqSDdqMGxs?=
 =?utf-8?B?S3NhRVpGcVlySU15MTM5ZU1OUWtPb0N2MGlVNGFvZFpEL1VrZHRuTWJuamM1?=
 =?utf-8?B?dFNRRUt2RVRiRE5PRnVrU09qRk1hS2VaRGJmLzZkNzQrS3JXTlM2WlM4OVFr?=
 =?utf-8?B?dEZhMHovanJEYTgveFZwajRRKzNjVEQ0cG8vSGxNU05JekVzajVSdEdlTHVC?=
 =?utf-8?B?cXBNYmIzNFdJWkdJTHFnY0w3djhsYXJ0cnFhM3o0WDAvMmdabUd0TmVIWjhj?=
 =?utf-8?B?NDJsRU5yMG9oTzBZMEtZdmxjUnJYeFVxN09MVkdwajY5UHVxWmhIdzRwL3Q0?=
 =?utf-8?B?clpUcUxFaHFma1lhY3pRZUl0KytJaU5icy81VW8wRTBvMUNUR25LRzF1ZlY2?=
 =?utf-8?B?ZWlnTGQ2d2pqSkdtR1ZBemN6Y0JuZUE1bEZCY0NENXh5aGxkdXdLUmN3SHBJ?=
 =?utf-8?B?cjlxdDYwZDJ2T1RnYUEyVjRiYithaUJJcTVVZWRkM3JiQWZRUjJVRWFBbVhQ?=
 =?utf-8?B?QS84NVFMcFlBNVlBbTVJYUV2ZDZOekkyakYvemViM0FZQ1FySGh2d2JXSElo?=
 =?utf-8?B?czNUdlJZTFh5bW12VGwyeWFFanRaQTFSY01aeHVMNXF6ZE5ncFBtVjJTLzhG?=
 =?utf-8?B?K1J5WEJDSmpxYnFBU3dzRDFnY0dENUdBU3M1dk02NkY2cjBWYWtYODQrVkpw?=
 =?utf-8?B?YWFXM29Lb3U1YVFGeFVuOVpTVVlVQTZ2VHZKZUNFT09LSmFmWERMZnJIUnBK?=
 =?utf-8?B?cndZM1duSERxYS93VTNrV2E2QzVwSTZONnFoN1R5Z2tlbExGOU1hM1RiLy85?=
 =?utf-8?B?Q1VPTU4ycndWY2p5UGhJUlJibm5HVmlBdFptb2Z4dHlldnRWSERRd1RQejhH?=
 =?utf-8?B?NzRpZXQzbEdManEyUHZvaDRXSXNlSEZmd0J2YzVXRmRWaWtZTnZuYXV6U1pz?=
 =?utf-8?B?dmVlcDhPbTRGemlUcFB1M2p4YVFSNjRJVkMzOUpMdXcvMmtpQnVieE51bGJh?=
 =?utf-8?B?NXRPSzVUaWJ4eE9VZjV6RmgybzYvT0NEQ21ZOVdLcDYzK2tyZnhheG1CMWxq?=
 =?utf-8?B?WmJmV1Q1NDNxMFVQek5COTBmWndoZ2J1bG96MWdqZDRkNkFwWVlTWkhKSjVx?=
 =?utf-8?Q?X0UYG3SEuY5V8?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VzFJRmhKeUZuYlBBclV0L2RDTDBaRHFreHNiSXBuS3R6WTdFc3B3UVZUcTVF?=
 =?utf-8?B?NkhlOE5mVVNuQlNFR0F1cjBvM1hXSVVIRVJaNCtGK1h3VVArYTBIV0lHeXg2?=
 =?utf-8?B?SlFEQWNONld2ZWh3RTNsaDV5RmxkbDVVQmFkSENXcEhOOWFZcENML2dxakJT?=
 =?utf-8?B?ZmUxNFVwTFBNL1BPRFVLWU1Uall4NXRJRUltZFc4b1hVNzF6MDdseVNNRlBv?=
 =?utf-8?B?dlFieEVQa0hhQ0M3T2R1TWliTlJwandoQmNlVEFtRXIxL3hoOEJWUFVaYUpq?=
 =?utf-8?B?MDV3Y296clhXZGNXanora3MxdUd2bytRUjRCRjEwM0diVThxRmpRdngwc1RW?=
 =?utf-8?B?UW1kcVkzZUorSjN3RjBPdGtIUGYvSjVvdlF6ZElvZ0ZscUhBQ2hCRG9oSTky?=
 =?utf-8?B?eTdJRDdIRWI4d0p0bXU0M05qMHVOSkxwWE1aODBSMksrKzlBZ0pqV0hmK0Iw?=
 =?utf-8?B?M0F6ZXhGbnZNVlRJYWZYV0NwcEVZbWlsNU1ZUlJVVEM5OGZUZmpseHVvUERB?=
 =?utf-8?B?a0dpQjkxOGkxMTZINktiMVJaRHo4TXlGVGgvOVYrZE80UDRWZlY1dEtYQmlG?=
 =?utf-8?B?UENoK0tCMDdSckY4YTB0aGZxczlXRThEMUFmeTlvbEt0UmwrS0NnemU4Wlg5?=
 =?utf-8?B?RmxUQmxGdkVRbzRpU0Q4Z0RNdnNpRWlpeHFZMnR5TUhaZ2ZDYmxLK0dQU2FJ?=
 =?utf-8?B?YWZFVEJ4b0RIQzRuaXpZWENER1lnc3Q4Q2R6NTdLYU4rcFdUMHlEMkZKNklx?=
 =?utf-8?B?Y0h5bUNXWXNPOU50SE5UaW1vbW9Od2xQYnUyeW5GNy9RTEdtSHBteEdoVHVn?=
 =?utf-8?B?NVpLYnRzRThUNnZJUW9Ga0pORG9nUytHbGZxclZWYWU1UzJjODFZZ0hDeFli?=
 =?utf-8?B?dG40TGFJSVJpbEx1NmdQTEQ3QXVJSDQwK3A5SWVXS1QyQldpMmd4SEZRTjly?=
 =?utf-8?B?WmZyWUNNbGFZTzB5Q2VMTTJXSkpWYmkxZjcxc21ORVFwejhwVE1rRGcyQU0v?=
 =?utf-8?B?TTNoZVNxbm03SE82R2RGMU5TK3Y1c3JJWDBEclh2UktFbmlvdUxUQ1luUnRL?=
 =?utf-8?B?cmNROE1MN09QK1dvNFk1QnZWaTRiV09oaThWckg3cWxFMi9lNGVDY2tvQm82?=
 =?utf-8?B?TlhJeEZBYlhzbXB1U3NWTUFQOUUwOGowdi9LWERIdjZDNE54cjBHUTVqWExX?=
 =?utf-8?B?WXQrc2NSTzZYaVZ6UC9ZUnRRUU42cWVxTGhCelV1OU9hUFB6dlZOYlcrYkN1?=
 =?utf-8?B?L3JjQSt2Q3BMWThaVTdicjZPVHdUTnBEeHdFdEt5TWNZL1lUVDFvYUs3WHBV?=
 =?utf-8?B?ekhWNklTU3c1MUZyQnZadm5Rd0hyUUx5VkFCNmdrQW1xMDgzVEExU1pCbXZh?=
 =?utf-8?B?czZSZk9ZWDlQQVpDZDh0Vms0Z1hiUVh6SjRLbFJBcWN3Q1h1d29sdWg5VzA4?=
 =?utf-8?B?TjBUN2tPeEJLUjE3aWEwbEovdWc2MUNvQXhhazlTUlpLN2k4OEVMbHNvNlNW?=
 =?utf-8?B?TnpUaHNLdmZ5UHEvZm51TXU1MHBnZDZERFBUdDRGWVQ3VXZnbUQ5STFqZEhE?=
 =?utf-8?B?RHRHMEQ0WUdpMTFybnhuQjRSV1R2TTJvWWx1TXNWL2tHUXlOdzUrUmUvais2?=
 =?utf-8?B?OTBlWTlHM1BISFFTbkxBRUxJTWcrQVB0RDhDd0hDTmt4V1EvRm44YTVkK3FD?=
 =?utf-8?B?NzZYbEJ5TUhNQ3RqeWwyWmZFVXdpUGhtZjdRV05LcGNlWUxsUWVEVzdSS2hB?=
 =?utf-8?B?ZUxKa01KQ0l1SmpjQzBEdDQ1TFBIcVN2bVl1SlpMUDhVMDJNMTFMbkM0cHFh?=
 =?utf-8?B?aUJqd1V6enNaanR2M2NZL3VuLzc4dThVUlFqb0F3N1p3OFBVMjJNM1BaMFZ6?=
 =?utf-8?B?NGIyNmc4Z3NISkFIOXBSdnF6MndkRllQZVhnVTBjeDJrUHFCdnd2SnlLQXpn?=
 =?utf-8?B?N1ZZcXo2c05GVGplUVBJTHl2c0RGdDVyZCtyWEdaUDl0M2dBdXdYRHRaQU05?=
 =?utf-8?B?UlAzc3JSRSs2UFBDT2tWQy9haEhaNWFXSzBqVWRFbmtTZVVNTDdUaGExSFdR?=
 =?utf-8?B?QVVJOFc5aTJQbzhtK3R3cUlhQzdGbXp0T0duTWtoZkhVeUxPSDFIS3dUUFJz?=
 =?utf-8?B?Y3NxOVdvam9jUTRndVE2Z1FMVTZFZzR1b3o4UGo5N2c3WVhMaGcvZ0lyVFJX?=
 =?utf-8?B?V1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b36d0d7-a9ee-44b3-d1a4-08dd1deb20c9
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2024 16:03:06.3941
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kRjxDQku1um1nP4xpyJUy12VFV3iwSk8Bglv22tiKtR6makufixUcp0Eyn071Rxxz+BNPokOcPb4Zx0HfrgWdlF0xrTYCPmVPZq04Bi+QVo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6922
X-OriginatorOrg: intel.com

From: Josh Poimboeuf <jpoimboe@kernel.org>
Date: Fri, 13 Dec 2024 19:24:31 -0800

> On Fri, Dec 13, 2024 at 06:22:51PM +0100, Alexander Lobakin wrote:
>> From: Josh Poimboeuf <jpoimboe@kernel.org>
>>>> +EXPORT_SYMBOL_GPL(static_key_slow_dec_cpuslocked);
>>>
>>> Where's the code which uses this?
>>
>> It's not in this series -- the initial one was too large, so it was split.
> 
> It's best to put the patch exporting the symbol adjacent to (or squashed
> with) the patch using it so the justification for exporting it can be
> reviewed at the same time.

Sure, I'll move this one to the next series.

Thanks,
Olek

