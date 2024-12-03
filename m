Return-Path: <bpf+bounces-45999-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C9319E1AD3
	for <lists+bpf@lfdr.de>; Tue,  3 Dec 2024 12:25:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5A26EB44A3E
	for <lists+bpf@lfdr.de>; Tue,  3 Dec 2024 11:03:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F87E1E3DC5;
	Tue,  3 Dec 2024 11:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JOCUT+J5"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1D151E32DE;
	Tue,  3 Dec 2024 11:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733223759; cv=fail; b=eWocVd6HoQKxsaAd+0BrtckDCGneczDbWY41YCC2veosNb8iVeizOFU21ymfZNntzZgbxfJTxDOIbGpTFp7PN/08+xWq5KUpK3VloQFlHKD808N/E9WjAWOSJbPNADon8rgHCKVPYfOn3PWxG/a6dzf/A/a42OyDDyLkGZG9SRM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733223759; c=relaxed/simple;
	bh=oiq6h90ZPyw9lZWljvXhds+NV2FeuJsDopg9EK8/Qyk=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=I6jFefd+zQMGMlvHvS0twGxlleeM6coRSR+mZ1uTff/21omvxr2gCfypIj+EZ/eyqluctXnF1rRAeLt3rO7HrKVcHV7GxeEgq28NRcd+VM7dtltB2xJzj+zzWVbeT8NtwkyqLP1zp5YWgK7iyKCOiexRStqCScdOr84tW5PVjwQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JOCUT+J5; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733223757; x=1764759757;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=oiq6h90ZPyw9lZWljvXhds+NV2FeuJsDopg9EK8/Qyk=;
  b=JOCUT+J5EjiwLRLrQsoHF4s/HQaREhjj7EeGClC8BLgdmPr3yauS2uCZ
   QPZapFrxLWHK3sRSqlQKfx7L9RBJTQ2DRtQkmUvx28wHmsunhzturSe4s
   GG2lK3S9qkp/NNXx5ntxmAcaIEzi/zvGjSsyieXn794xVqDxdm9hUyDP+
   DaEN6Z8VulJ0N9toMbRi+Vwj7uNatMt81nH29HwrYY3lXrI2qbd515d3g
   98dldESbK6ekS08bR+R0kDu+3PpboP21RXPEd/ddiX3sqVq+17sxERIRQ
   Yc9KEHibm1ugbQQ37XU6APcNenC0VUFWKf1G6TxqMe+PqQY8P6pV0N4Eq
   w==;
X-CSE-ConnectionGUID: oWPO15QaSjquProAcJhIGw==
X-CSE-MsgGUID: waG+hf21Tx2ZGLYDZCxfGw==
X-IronPort-AV: E=McAfee;i="6700,10204,11274"; a="33560894"
X-IronPort-AV: E=Sophos;i="6.12,205,1728975600"; 
   d="scan'208";a="33560894"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2024 03:02:36 -0800
X-CSE-ConnectionGUID: HDg2UAX7QVmHjc9Z6pbnSw==
X-CSE-MsgGUID: prdhw/nuRhiE6oPYfi2TMw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,205,1728975600"; 
   d="scan'208";a="93297225"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 03 Dec 2024 03:02:35 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 3 Dec 2024 03:02:35 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 3 Dec 2024 03:02:35 -0800
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.44) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 3 Dec 2024 03:02:35 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rt357lXvwNr6A3SqNqw+VCxPU8hlKTRACM7N3BMtASEeWPm05M5LdmYnlw61iqxH7OMG94CH7Wu3nnab6eM1OCSr6WPTx9kVQ9Sd9T62bL7UouAz8HKXXE48gBIKi/PCL+k++mF3msVrN8k+uRFNVhcSAHM6DgYQ+wLhK+pJ3C1+0lzI3iie4Cmf9Paa2Upl2mVC0zpcfe1AOmmwipUGRh4D3IsVRuWgHurMVL7zIClPUNmoYRGNbS0xZXBS3jdCRASssXHWJGLh7r+HTh1zqYJ0cCO6w2D2uR0YbREo7iXN2zKKo27PgTn8QdtQM3nyu6cd2uNNI3O7AtoCTqrPQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y44HLoUIg4bqHY3dTcsbIai8TtLEg17JjteFxqsMs2Y=;
 b=cRALvjtI3RyJH+18POfqLKDDdHIbLA4ruEp0fNXAZooUccV+eF+4+IRErEIrFYe3YKD+mi0iubgwwnLbluO20llONgwhUCk3NFgFgFbBoX1I2issWGo7zPBUWLC7c9KN4ZyLi2ydjWXGWK1fMDG4P4QJZPvhI2+e9CRbDk3relCFqhpZUhh/keyBRfEUMu+VSuqGM43F/lxgnUPnaXG9WWRg7Ad9kLJtwAWxO9M10OHsRtbwHkhLWYuhj1j209e9iOyxzJvw0auESyZypz/ia5NuCMcDmqkTEI0EgV9x6b9VvppICIMTJ4qh6sngr4UA0KtXoTRijzS+K2Qnj8qjuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by LV3PR11MB8577.namprd11.prod.outlook.com (2603:10b6:408:1b8::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.19; Tue, 3 Dec
 2024 11:02:32 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808%7]) with mapi id 15.20.8207.017; Tue, 3 Dec 2024
 11:02:32 +0000
Message-ID: <4f49d319-bd12-4e81-9516-afd1f1a1d345@intel.com>
Date: Tue, 3 Dec 2024 12:01:16 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC/RFT v2 0/3] Introduce GRO support to cpumap codebase
To: Jakub Kicinski <kuba@kernel.org>
CC: Daniel Xu <dxu@dxuuu.xyz>, Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>, "bpf@vger.kernel.org"
	<bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
	<daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, John Fastabend
	<john.fastabend@gmail.com>, Jesper Dangaard Brouer <hawk@kernel.org>, "Martin
 KaFai Lau" <martin.lau@linux.dev>, David Miller <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	<netdev@vger.kernel.org>
References: <cover.1726480607.git.lorenzo@kernel.org>
 <amx5t3imrrh56m7vtsmlhdzlggtv2mlhywk6266syjmijpgs2o@s2z7dollcf7l>
 <ZwZe6Bg5ZrXLkDGW@lore-desk> <55d2ac1c-0619-4b24-b8ab-6eb5f553c1dd@intel.com>
 <ZwZ7fr_STZStsnln@lore-desk> <c3e20036-2bb3-4bca-932c-33fd3801f138@intel.com>
 <c21dc62c-f03e-4b26-b097-562d45407618@intel.com>
 <01dcfecc-ab8e-43b8-b20c-96cc476a826d@intel.com>
 <b319014e-519c-4c2d-8b6d-1632357e66cd@app.fastmail.com>
 <rntmnecd6w7ntnazqloxo44dub2snqf73zn2jqwuur6io2xdv7@4iqbg5odgmfq>
 <05991551-415c-49d0-8f14-f99cb84fc5cb@intel.com>
 <a2ebba59-bf19-4bb9-9952-c2f63123b7cd@app.fastmail.com>
 <6db67537-6b7b-4700-9801-72b6640fc609@intel.com>
 <20241202144739.7314172d@kernel.org>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <20241202144739.7314172d@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MI1P293CA0010.ITAP293.PROD.OUTLOOK.COM (2603:10a6:290:2::7)
 To DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|LV3PR11MB8577:EE_
X-MS-Office365-Filtering-Correlation-Id: d7dedf81-87d7-4941-1123-08dd1389fc29
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TXhIME1lQzZ1RE9uY1NVZzNraHMrTVowNWZPdFkvd1pkWHdPMDQ4eUl1ekly?=
 =?utf-8?B?ZnU4TnNiK1BHeVBrUGpiVllCVjFXQnpQTFJKMm1XL21qUU1qcmJnc3diQjli?=
 =?utf-8?B?YzBKWjRJYytkNVVRdlhadzIxSFN2QkQ1NURkL0RJL0ltOU1pazZrTXd0WTkr?=
 =?utf-8?B?VXRvc0N5QVBBWmFYa3BGb2pvelhmK2FYcTlwNDMrRyt3N25UMDJaQ0dVZk16?=
 =?utf-8?B?QkdaN0ZvUWZ1RUVQK1ZqNXJ4Nnc4aVZsQWtTNWk5NUJwdUpPcmg1a2FSK2Zx?=
 =?utf-8?B?ek00WC9JTWZxUDhybENoZkFPYzFnNm1qV2lXTHpnN1NKQXJlK2VEaDNORmNa?=
 =?utf-8?B?dnBxSXJ1ZStVbnA5Rm8rWlRmaDVEdmVGSDRVS21yek92SjlqMTVjQXBvZURN?=
 =?utf-8?B?SUZYbmx6d1ZuN0hBQ0VGMHV5MFRlSSt5aGtRb1IyRzAyUmgzTFhuMzNHSG9j?=
 =?utf-8?B?RWd4NG94Vm1meHRLVWZGLzdQUzdBbElkMWZDNStTZHlGY2lWc3BldENNUjBu?=
 =?utf-8?B?cWF5aVVOZ2dHdUZMR1NrRk4xbUVyT2swaG5sL2JldGFCYlRFL0NPMDhkRlFT?=
 =?utf-8?B?NWljWmpzazVXaGlJcGlkZXBHcjNLSnByTzlLRjgrUW5nQXd3cVJQSmZJNGcy?=
 =?utf-8?B?NGRIdTU2eUlOL0EweXYyOWpTdTk0SXRqdUZpR1JBNFhMSnFydUdVa2IzM0hO?=
 =?utf-8?B?a0I4cnR1V2UzQjFJam5UMStLNVJxQnp6SzBzYTkrbzRiVksvWmk5UGpwdjlp?=
 =?utf-8?B?NTZxcjYwaWFPNXhXUFI3ZUlTZURkMlFRMk9VMXUyazVwT0Q3U3BremFVQmtP?=
 =?utf-8?B?YzZEMmcwcTlqelc2eGQ1V1d6L3BnYUM0YjdSNWJlZXRvYnUvbVFHdmp6Zzhh?=
 =?utf-8?B?c0pkRm5JZW5JSXhTL05DTGRHbjdlZ2w3RnlpQ2ZPTWNOREV2eDA0Ri9vUGtl?=
 =?utf-8?B?alpkUFYxVWRKd1BTbUt0WUt1cUVEZkhaOHhuSmt5N0cwb29DeS8wWHgrL0FC?=
 =?utf-8?B?cFhLM3N3ZCtGMlBCSmNjeVA0LzFlZDhZSElBY1Vtb2pHRjdPRnVEZ2dldERu?=
 =?utf-8?B?S1Z3RUdwYmM4MnZqNVBoeUkvekhpY0hUbUdvcllnUjg3N2lzNXUzSVdydGZK?=
 =?utf-8?B?UDM0SW9hWThUT3lNcDBoNlhJeEdQRngweXl3bHhNcmtPVnJueEl6V3gxWDFP?=
 =?utf-8?B?enU0RG9xOXJsUENIT0xtWkxnS1VXOFBqazdQbEFaNTFJQlNRVHhhaTZiMlE1?=
 =?utf-8?B?blNncnpmTnZKdWU0YkdReExQRkN2amlHc3hPa0U1SXBLOFh4UHMzbnRhRnhQ?=
 =?utf-8?B?Tnllb0NVa1ZGNUtEc2pJbmZFVDZFNEhKd3VMT2J0c2ZmTUM5ZTF4L3d3Qkxi?=
 =?utf-8?B?OWF1NW10ZmgwU0JXZnRpWURzSmV0aGtqVGo5alVZSGo1MDhzYmFkQXUwWno2?=
 =?utf-8?B?Skc4dmc1MDNndW5OdGd6UW82M2htakVTWVBmNG1ZMWVuMDI0REtpMjdzTmxL?=
 =?utf-8?B?aXE1cTF6Q0cxcWprazkwQjhYSmJqU05hWHc4Q2REYjVLV25qWHJoaGpneC9E?=
 =?utf-8?B?Q2JIczFIVnFVZGpHdzVkUjIwV0N4TS9OaTJPbjVkQmdlM0h4bnNjOVJKSGR5?=
 =?utf-8?B?YkNyWkxHTHhkNXJZaVNLUEg2Vm41TFM5T3NjcE9KMnpNOGRUNTVvanF3OEVZ?=
 =?utf-8?B?bzhoZ20yTDNjWm9RYmVFL1liL2gxUXZKSVBjVTVxWWcxWGlKeWp1OVJJUjln?=
 =?utf-8?B?M0I3NEpKa1UrT2pkem5HZWxybUYyVnl6Z016QWpnV3FFWnJGV1h3NDNVb1ls?=
 =?utf-8?B?QllJS2gvSHNVemx0eG1odz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L0s5Uys3Rm12dFA2OEMyVG9NYjR2QVBFdVFLUCtLNW5ibVFQaUZxTDlWQzU2?=
 =?utf-8?B?WndsY3JuUnAvWkZtRE9adVh2aHp2TDBpN1NsRnFxeXROOFhEL0c2b3p5dTBj?=
 =?utf-8?B?M0llODUyVUxOK0F1UkNwcjdvQWtxbDhOTEhVT012dUMxRkRNZElFUlJNY3Iz?=
 =?utf-8?B?M1ZGM2pEWGN0UEpxYktyaG93VzJRa0RQdGRWczBHUU5oYVAwR1BzNFRyLzEw?=
 =?utf-8?B?MGhmZVI4VFRnelY1dnFsQVhmVVVhajdKemVSLzk2UTJYZnl1ZmYrbEFrQWt2?=
 =?utf-8?B?ZlFGVlVmK3JvamQ5VVRNTkcvQUtGb3lJZXdmVDVQYkhRVnlLM3l0QTBjcnZK?=
 =?utf-8?B?ZlNnYlRwZ3ptMGRxOTBITXA1YkVPRWxKbGgzTnkvSWVraE9zdHQzb28xUzg5?=
 =?utf-8?B?bUg4WTFtb3c2TzNNNVVGNDNrdWtMb0wyd21VZlE2aVB6UEo1QVNBTks2UVFs?=
 =?utf-8?B?c2d6QXBKMk9sQVQrczZwcXNLMmhmREhwZDFwUS9sVms1YVEyeDJRU3JjOGll?=
 =?utf-8?B?TTdKQVltR0J6UEc4d1ROdWJDUGtXV2kvVTQ1eEhaN1RJcXZ3RGhVS2M5bUh3?=
 =?utf-8?B?RHBxVEtSZEFSdTdvMDBjdlA2b1VWSG52ZytWaGp6WmVaQXdxM2dySGU1eXJX?=
 =?utf-8?B?clZMK0dZazE3VE1VZm1BSU9Rcm9JOWxrVVl2VnFSOUpBNG5PUXpjMkFocUNO?=
 =?utf-8?B?UGpIWWRYZ3AwWTN0QndCUEtwTkc3TW9ucmRFMlZNZDRRMlNlajNsc2FtYzRw?=
 =?utf-8?B?NmJvMUNMM3FVUWYwc1BjWEwxNG04SFozRGk1T1NaYWRMKzlQd3BvbUZjZlg5?=
 =?utf-8?B?ZC8xRFBrWTZJTEt4bWtDYXExUk9oWnB4bjRZVHFXVmxtZ1J5VTE4cTRmUmRX?=
 =?utf-8?B?Z0doNTlheVY4OEpqMkw2M3ZIaEJUTHdxbzkxSzRMc3cwazFIMVBEejA0OWRn?=
 =?utf-8?B?SVNmTVl0OXM1NTJrSjI5NkJCeTRQOEl1NWNlNUsrME9XK29meDh6Q1ArYXNM?=
 =?utf-8?B?dVFYWEF0ekpQaGRnVlB0SGxQQkt1cnVCOXdLV0ltaXBIUGYyZzhIZWFvMWFL?=
 =?utf-8?B?Y1hSUlNGSDV4RmlRYi81UEl4dkVvbEt2aWNBY1NVdHhOZHQxT3NhKzh6ZHRZ?=
 =?utf-8?B?ZlVieW0xenlkc0tzeWxyT1ZDdC9EZ2J5ZVVidEVSd0FiM2dRTnpvQzFweGdr?=
 =?utf-8?B?alJGWDlYRjIxZjRRNklFbG5xQ3I4THFVWEN3MUtqK1ZpN2NJQ3ZwSU9ydFVo?=
 =?utf-8?B?dGZXWUJMYXJOVTZqL3UvZXB3WWRaRGNXK29ROEl5L3NuZ1ora0Q3YUpnYlJ4?=
 =?utf-8?B?RFJyaGttc3lCeUZWTVczSHNvb2FSb3VPeXg2VGtYRkd3Ky8yRXdlemhqODYv?=
 =?utf-8?B?YXFZbzljQlZNSFRkM3Vwc1lldWpBNmR3c1VJUWwzMDh6blRnc3pKcTkxdElB?=
 =?utf-8?B?TjZLQm1pTXUyZ2V1K3R5SVlXdnYyZlJoZXdTTEJ0bDlqUm52NUg1dkYvbS9G?=
 =?utf-8?B?YVVOUkFtQzRsYzBlNUlnamJrRFVLd1Q1QTB2dHF3YVVoWjNnaU1IdnlKdVJ2?=
 =?utf-8?B?SW5scW9ra25HekQ4Z3RRZUVBUVM4Nm5LazAvb2hZMXFkck9lOWNjWUw1TDV5?=
 =?utf-8?B?Y2plZGtBZm9QUUMvYUhYNmx0bm1veFdQdzh2aGJHbXFPNC82dFlpdncwMmZU?=
 =?utf-8?B?TVNaOGJlazZNbXRUYktJMzArN3ZRL3NROWlvc0NoaDFGWkFYdFR4ZGZJemNE?=
 =?utf-8?B?ZTZMSm1HNXFwZU4zMi9zV0MwcHUzSDFWdE9uUXB0VisrY1ZpaVFHVnFveEMz?=
 =?utf-8?B?NzhXb0E0RjVDTDlLQkdoZWtEc2VUN1lpdTdTamhUODNPNmdFd0lXdmRUSWxl?=
 =?utf-8?B?NnR2Z3RseFBkQWEyZ21IS1JHQzVYVS9ENGhRbjNvd0lGRzcwWXJOWFRiNFhB?=
 =?utf-8?B?V3VDQkQrdTJlL0dMZXY5TFdpZzB5S2p3Ylg5bXc1dk5tSFRYaEFCZEZCalJ4?=
 =?utf-8?B?VGxPbUYwZUtYem9rZGZOSGlib3B6LzhGbkpIcktnNnYwV1lNUFJGWGZhUWpC?=
 =?utf-8?B?VFFhYllTOEkzNXVmQkhBbjJ5UzUzRzI4ZlF0OTRYekp2OTloTE1YUWd5aHVJ?=
 =?utf-8?B?azRIaVVoYnphd29vY0sxWThoZXRUSmtWTEdJeXZybjNUWnZyWUxPSkpNYXRT?=
 =?utf-8?B?aVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d7dedf81-87d7-4941-1123-08dd1389fc29
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2024 11:02:32.1081
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WXifArVuXwjhMC7q5QsJdHOMo1cJQZmIEGTkPfYkwR4JJMKkX5932sbEd3gHN7ovsB1cUDazi0MifWwmIvRnooaizhAoeqHsSLpLmeMcugo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR11MB8577
X-OriginatorOrg: intel.com

From: Jakub Kicinski <kuba@kernel.org>
Date: Mon, 2 Dec 2024 14:47:39 -0800

> On Tue, 26 Nov 2024 11:36:53 +0100 Alexander Lobakin wrote:
>>> tcp_rr results were unaffected.  
>>
>> @ Jakub,
> 
> Context? What doesn't work and why?

My tests show the same perf as on Lorenzo's series, but I test with UDP
trafficgen. Daniel tests TCP and the results are much worse than with
Lorenzo's implementation.
I suspect this is related to that how NAPI performs flushes / decides
whether to repoll again or exit vs how kthread does that (even though I
also try to flush only every 64 frames or when the ring is empty). Or
maybe to that part of the kthread happens in process context outside any
softirq, while when using NAPI, the whole loop is inside RX softirq.

Jesper said that he'd like to see cpumap still using own kthread, so
that its priority can be boosted separately from the backlog. That's why
we asked you whether it would be fine to have cpumap as threaded NAPI in
regards to all this :D

Thanks,
Olek

