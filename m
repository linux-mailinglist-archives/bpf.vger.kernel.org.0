Return-Path: <bpf+bounces-36767-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2973B94D012
	for <lists+bpf@lfdr.de>; Fri,  9 Aug 2024 14:21:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E1FB1C20F63
	for <lists+bpf@lfdr.de>; Fri,  9 Aug 2024 12:21:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0599194141;
	Fri,  9 Aug 2024 12:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Rzlg8yrO"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77E60161904;
	Fri,  9 Aug 2024 12:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723206051; cv=fail; b=Kqgq/zNo6FxZbK9lE4AxJyN/dJNGMwfI5hZkUuDFv1DVpbas+10xC8WKs6YZZU+Oddjg5xaylls9wa6vPIXBDt5BFxXR+Wa26DRjGdnZ9eVvRYaqoBuOxgwofUIPj9OM7BGSyycvVb/A6MpMYKsMQaJkMwdm0SF+94M18QmDBg4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723206051; c=relaxed/simple;
	bh=2p/JSga9kJ5lGqowDLGGETTcxsRv3SNF+VWS+gDDK5o=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=WtnxFydZvZsnGMqM7FcoIAcYNg2zTkMFwG+DwJh1GABEDn7MOBEA45y8qTB7erY5yPUVI3WrXQMs3yDROouN/MAXTfSdM4iElavvs/U4izFV86pSKA4eZWbRJUdvfcBHwnhVCaJwoSQ1upw4iFSeEQhGDdX+ntNwmP+R88777HY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Rzlg8yrO; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723206049; x=1754742049;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=2p/JSga9kJ5lGqowDLGGETTcxsRv3SNF+VWS+gDDK5o=;
  b=Rzlg8yrOlw0B/+ltfo9j+FmDihMNoCJM/EHeqsoxWEiOzT/fHYMcw+hq
   1oYj9dBu98bOOA+Gsn9/7F5porkASI1VLxxa1DFv4TCG1jWCiTV2BZTpd
   PagG1mkrXtMOzw9pA4k+9AzJbazdJ7sVjpjySZeGLBA7L6pjvhH4mQynk
   7xoEalhQsz6pz2ZxrSIJD2Ej3Jrt37T3ciHqdT/Er72NZ0UcO5XdxFOe7
   hBPBl5LdfEbUN6/wgGcZwHX169ZseGVLMe3LXEblRnb7gGqqLz+fqRxz4
   ywaj4Eld3dyWVU9w1CFHuU3jdSOS2Edc/whGfNuoqOuCsFYaxmPtUggiX
   A==;
X-CSE-ConnectionGUID: +/WSNX6ITMSYVuErBKdF5Q==
X-CSE-MsgGUID: lrwFpI22TgmpKR0lpyMiKg==
X-IronPort-AV: E=McAfee;i="6700,10204,11158"; a="12933360"
X-IronPort-AV: E=Sophos;i="6.09,276,1716274800"; 
   d="scan'208";a="12933360"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2024 05:20:48 -0700
X-CSE-ConnectionGUID: N4BUIJIDRkiONsZR7vW7QQ==
X-CSE-MsgGUID: gkxdE/QXR4m6MboAT+BJWQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,276,1716274800"; 
   d="scan'208";a="61670354"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Aug 2024 05:20:47 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 9 Aug 2024 05:20:47 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 9 Aug 2024 05:20:46 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 9 Aug 2024 05:20:46 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.47) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 9 Aug 2024 05:20:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xPyf23gc4BZ/1r6rdu7YSYSseG8wnJ803g2K8g9djSPVWh34eHb+mGOC6ZpR57PB2nB249mIADYy8V8Ui1sP51a0lWd+qoBJxwRP5Igsja2j/+RlMOpjSXpmzIxziT9lESzdW9+bhe1eE4H815TcBYRan99EwMYxM0VifLLDW1QbKz9/9D4cPKUJBqKvBNmRMOKWwArScGRpy1OvjJCpQIW4owcUp1M9WcEHzWKFNWkXxCbFewbhKZfK86uyr2fLgYSpg6tXce6wdvRteEi4jqYKf01gFflNuyvGk8881PzLI3SmE6urHDzl2FY75VCPSyECNTTWy2J7BJLCBS/TCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b5ErDjdkddfRPC6eL/tHk9TUxh1V2Z9WF5v7Dq90kVc=;
 b=yNMXiw0l+2h5o+93jspM2HnT6ws9TR1mO1gcI6E06Vb3xTz1LdKiprF9ovh5Dd2TgzOM8fHl4vXgh5TTsQ4RYF8nmizZODzhUFFKERyB+bDEai378hBfn33oZyKhUp/o+Ie77V8kPq+GidnlCIHIwSU26tr+3aFRG98kM0uIgCiUTRFyooMjSHU8Ta8BEuYktBcVIouEbSPdNikKImzWtF4FFai9O6uQUbfCyqSzl2O4xeXOqHOjnJvWtvzNrHw6c6ICaVcF7crJSoUm9s4BFGbA6qGcD2/y1LEvS5h9Rdhng/3k70muU4u4/PM7xPPBEYERY9YlQMPQQzpuMvLp/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by CH3PR11MB8443.namprd11.prod.outlook.com (2603:10b6:610:1bd::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.21; Fri, 9 Aug
 2024 12:20:43 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808%5]) with mapi id 15.20.7828.023; Fri, 9 Aug 2024
 12:20:43 +0000
Message-ID: <99662019-7e9b-410d-99fe-a85d04af215c@intel.com>
Date: Fri, 9 Aug 2024 14:20:25 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [xdp-hints] Re: [PATCH RFC bpf-next 32/52] bpf, cpumap: switch to
 GRO from netif_receive_skb_list()
To: Daniel Xu <dxu@dxuuu.xyz>
CC: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>, Alexander Lobakin
	<alexandr.lobakin@intel.com>, Alexei Starovoitov <ast@kernel.org>, "Daniel
 Borkmann" <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, Larysa
 Zaremba <larysa.zaremba@intel.com>, Michal Swiatkowski
	<michal.swiatkowski@linux.intel.com>, Jesper Dangaard Brouer
	<hawk@kernel.org>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
	Magnus Karlsson <magnus.karlsson@intel.com>, Maciej Fijalkowski
	<maciej.fijalkowski@intel.com>, Jonathan Lemon <jonathan.lemon@gmail.com>,
	"toke@redhat.com" <toke@redhat.com>, Lorenzo Bianconi <lorenzo@kernel.org>,
	David Miller <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Jesse
 Brandeburg" <jesse.brandeburg@intel.com>, John Fastabend
	<john.fastabend@gmail.com>, Yajun Deng <yajun.deng@linux.dev>, "Willem de
 Bruijn" <willemb@google.com>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<xdp-hints@xdp-project.net>
References: <20220628194812.1453059-1-alexandr.lobakin@intel.com>
 <20220628194812.1453059-33-alexandr.lobakin@intel.com>
 <cadda351-6e93-4568-ba26-21a760bf9a57@app.fastmail.com>
 <ZrRPbtKk7RMXHfhH@lore-rh-laptop>
 <54aab7ec-80e9-44fd-8249-fe0cabda0393@intel.com>
 <308fd4f1-83a9-4b74-a482-216c8211a028@app.fastmail.com>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <308fd4f1-83a9-4b74-a482-216c8211a028@app.fastmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SCYP152CA0017.LAMP152.PROD.OUTLOOK.COM (2603:10d6:300:7::7)
 To DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|CH3PR11MB8443:EE_
X-MS-Office365-Filtering-Correlation-Id: c09f8430-35fa-42c8-ef08-08dcb86db062
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MDhMWUw1Qyt5TnRxekVINmJWVWJlNzNzWlhPSml4ZFVhNlk5NGNLU1V5QW5s?=
 =?utf-8?B?bjBBR2tLRFd5dDBGRUZ3NmUrWjdWTmVYYjI0Sm4vQUYwMjBZS2N2WW1YcTdt?=
 =?utf-8?B?WFJuelpjK2Y5QjVNdGVIN2s2cFo2VzdKci85bjJlT0VjcGVJalZobXFnS0d6?=
 =?utf-8?B?MDI4NXhSNlFLaURreXFJL1Boa1ZKMU1odm1lVlNxQWV2NkEwcFlYMmdIbkhr?=
 =?utf-8?B?SGpSUGR2VXVOeklzaXNjak90RHRjaXRWbitDek1mMElMUGhtS2NXZUNzdlR6?=
 =?utf-8?B?VDFBdXF1RnN0UGtVNG5vU2RLeG5iaGUwTFF1N25Na2JTYlQ3N3hQcy9LYlNW?=
 =?utf-8?B?SUtmN09ZSFBFRWVJSlpKekJjdC9uNW9ZMlNNNTdYTzBQa0lwcWZJUVoyd3A5?=
 =?utf-8?B?UlR5Qnc5WnQybnE0RWlmSk1FV0JsVDl3YzNZTGZTN2wreWxHWGtLYkpXSzFp?=
 =?utf-8?B?TkpaSzhwRmV5Rm5JaGhlRGwyWEh1ZjArYytQa0dXQXc0N1kvUDNWUFB0S2lW?=
 =?utf-8?B?S045bWt0MEFTNUdXZnNOeXZzM2pWSGdFKzQyT3VYOGtoT3NSelRZdjN1ejNY?=
 =?utf-8?B?cDUrbFBjTWE2ampUWXJ5b2xiRUNvMHlvVnN3SXhZSVQzOU0wUThqT0tQYXQ0?=
 =?utf-8?B?SUM3VUsxczVuZFU3azhHQ3lxdmhrWnVpTVJ2ODVzaDl2N244VVU3UXBGZ2s1?=
 =?utf-8?B?ckFSYjNhWGVKTG5NZmc4R1JtaDFqVzhtQmFSWFhLMzF6ODc0VWtrRWZPL0cz?=
 =?utf-8?B?aXFleWtmUndmK0ltY3FVdHFISjFxQVRuTDEyeU1RSklxc2FOb2NlMlUyUERw?=
 =?utf-8?B?M1ZiQWJCZ0Z6TzBFY0kwQU93Rml0NFVXQTBrMUdlN3FnYVlsV2Mwc2NUblQ4?=
 =?utf-8?B?UlNBTHphVHdpQkJiL3hoZ3VWa3lnZlBpREg4Vi9YOXdBczB6VFl2QkNyZHpp?=
 =?utf-8?B?RVp1UzJUb0QvTFhTRU5IMkhSVUtxc3FWajJpU3d5Q0xMcU9sVzZrdElxbzF0?=
 =?utf-8?B?OEFmb1MyY1BIZCtGRXJucWdlSWVTQlIyck5ad3UwSzV4ZlczT1VtNEZ6RHRU?=
 =?utf-8?B?TlRXQmRkbDcvTFZHWkFLUFI1NkVkdWE0bWRDQkZIYXdoM2tuS3pKd2xzbWFM?=
 =?utf-8?B?UjV5WTFLelV3dzVLR0M3MW56K0hVbEU4a2FOWFM2QmIzdklnZHpMa2h1VWVo?=
 =?utf-8?B?akJoQ00vMVhvSCtjYWlQY0lUOEdIVG4zZFFZWG1sK3B4UmVtT3hldHNKM0I5?=
 =?utf-8?B?bjlkbzdITmpINHBzZzRsR0E4dXBwelErbjZ1Z0dEcjV4ZUxpUTk2S1BDL21x?=
 =?utf-8?B?R1hWUTZBWVJKOVk4NFQ2VWJLUUVac1h1Qjdzekl3ZzgzNWhkM3Z4YzNOQ2Yv?=
 =?utf-8?B?aklQV3h5WnRLUjArUlQzK0lvV2xXb1ZkVWhRVjczMkdQbGhLSjVwQXh6SmVI?=
 =?utf-8?B?ODRlQnlET0I1ZkdXUUxvWXdWZVZRU3k1QTFuL01xeThCcjhPeTRVUGhoNUJt?=
 =?utf-8?B?K0RGUkliYXEyU2oxTXVHakNJME5Ucy9BY3A3Tjdkd3o3YWJNV2tZdnd2c2tk?=
 =?utf-8?B?aDVoNm9pWFdyRHZvYngrcG8raFkxMHdNWGdIajd3ZVIyRlp2aGNXUkpFNVdX?=
 =?utf-8?B?TFJ3TXdScTkvMCszckloMDdWQSsvaGxxZlhkWW1MZUo3NTg3aVkwaWt5UytL?=
 =?utf-8?B?dk9hb1Zsa01zTHpGNVNscDZ6STBaR3BaWisvYzdsaG1YSEgxbnVObEdXMWo2?=
 =?utf-8?Q?6+J3AWD/DiWINvolkMyZ4saIcSp4pUb0kgJ1wdu?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RUZzeC9UajRCWlQ0UlFBRnUvWVBKQzN0R1hCNU8zUnAyWnFxQmVKVktzU1JI?=
 =?utf-8?B?VFFkQ25TTXFHQks2dmR6VTJQbmdZazBtMk5BTE0va3JJcUQ0ZUxDcDJXRGJI?=
 =?utf-8?B?OW5BcTFmKzJTWkhBN0tpL01DWm9nNnRGMUxWb3Uvb3RZd3AxdzVMK21reGhI?=
 =?utf-8?B?bHJiT1R4eG5BSkwyazE5MDhtbG01Y1FPTWNZaEZCdXpiZzh1T1dRTWljK0Vs?=
 =?utf-8?B?MjVTaHY5emROVm84clhwYTlCemZGRnJYNVp6RWFtV2tNckdEL2ZmSkg4c2xO?=
 =?utf-8?B?ZWRCRHBJc0cvL1M4NlpnVjluMndSM0N2Q0JsS1hxdWN4UzQxS3VPL1VpRjND?=
 =?utf-8?B?SkRjYVZGYWNrYk9abE9TbEZ0NTQ0YWhXMjI5U240K0ZPQ3hadmlLcEJqYm8r?=
 =?utf-8?B?TEROeUt3RjYweDI3ZlBFUUtiNjNZUXlsMjFPOG1HMDJrUXRHSnNkUHlYRGRD?=
 =?utf-8?B?TE5Fb3FObEtjNUhWcWhEMHcraVZ4VU5tdmVidWJXYWwyc1kzeXRCQk5mZ2hk?=
 =?utf-8?B?L2gvWW80czl6a2FGdjZ0VXgyYU9iZVdpeFJMUUFYUXJxWUp5czNGdllQaktE?=
 =?utf-8?B?M2lGTGZOcmRsaDhLZnl0dElLNlVlaXpUR0Q4Zm16aTQ4d1RnQmxJcjUxVGlZ?=
 =?utf-8?B?dUxzVFFTTFhUc3oxMWNpcVc4SDBNQjRxMk5oNlN3cnYrNWpMUFRvemFKKzZo?=
 =?utf-8?B?aStrdmxiS1ZXdUpiTm1iS1IwRktrdVhjb3BNNW1saHJrSjVaWmZ4SmFpRG14?=
 =?utf-8?B?V0xZdHl0VXVFc1dQa2ozNnJqdWpnV1VJMTY3MThhSnE3aFF4V2ErK2drR0l3?=
 =?utf-8?B?VWpEWDdoakh6MVk3OTBDYTdrNlV6dFhFaEI1QnpORytvVitvTC9YSUxES3B1?=
 =?utf-8?B?UnFPZy9XUVJweXhISFI2WlJpenJ3dnFlaUdzd0J6QURiWllObitUUTY3SEIv?=
 =?utf-8?B?OHBMUmpNKzE4bG14amt5K2tJZi8wVm9CZUhCZHNMSVJIT0gwa3hWem5VaUNV?=
 =?utf-8?B?U3JMV1V1SlN2WHdQendZNmFmemZVMWpBSDZIUWx4elZxQVMwOW5GRUpRVTJS?=
 =?utf-8?B?bU9RTjBsZFJOTUVsTlovdnJWSzIyK3c0OTdNaXVwUEp6MHl6M1BSMXIwWmF0?=
 =?utf-8?B?SWhjMjhBeGNybkozWXVLaDlRNm1iV0tGeHVhQWd4SGFHbVVUZXhmZHJ2L0ha?=
 =?utf-8?B?UU94TXkvWnNXRGVOaVJiYVdETTh1S1JRajN5TmEzRVI4OWphVWlJWWwvTFZr?=
 =?utf-8?B?bnorMTJFcmdkeGlwUHRqS25YdmVLVllKcHBuVG9FU2hoRVBYcE42eHRhZ1pz?=
 =?utf-8?B?aWE3S0JsdjUzMzF1UWtBQ0tDTlVGZllHdHVHWEc4bXN6UnVMMGJ0STRvQXVS?=
 =?utf-8?B?ZXlCNDhjMkJmaHQvNXFtOXUraG0yYUdUMTZEYkR6WFIxeTFxU1NhUjdmdmhK?=
 =?utf-8?B?dmdTRmIweERuNTNhV3NyTjc3V1NIbWp4ZGF2VXRvZERUc1BTRnp2UDBYRnU5?=
 =?utf-8?B?SitLTmFKMjExTnhhbDljU29scW5nTGdLM0x3SUs0U3JlZ0UwR09lWEZlNTJI?=
 =?utf-8?B?bDIvUEpFWkt5bHFCMkJyQVpZdnlDS0NLVisyN3A4ai9DQjJqVWlhWDdHbVA2?=
 =?utf-8?B?ZVl5RkpQbGpLRlJaRk96L1Vtc0xYZjVXYzd3Q1ljV283YVowMVk2UGhZTXEv?=
 =?utf-8?B?bWkxeWp4SlVCb01hc3FDc2VMWVBGZVVhRjdLZy96QVVtSmlvWkZZb3kwbUo2?=
 =?utf-8?B?WEl1TnI3L2FrWEdiK2RUb2UrZXhmaUMzOHpGY0tKOTRCRGN3N1NMTDBFRVM0?=
 =?utf-8?B?RlVkNk4xNlM4OE5MbDl3OHZJazhYalp3aUxTdTcrYkdvWmFEays4OExER3d0?=
 =?utf-8?B?M3AzRzQ5SDgzUlhWY0lQZ0RGbUxpYXpVZGFCdkJjc0NrL0NWdm1PWVlFY3g4?=
 =?utf-8?B?VmovYUZEeW1GWXR4cEJNS3VUdDFDN1RCY1RIV2ZLVUtBNEpNT3VxVDdaQ2lW?=
 =?utf-8?B?TVJJRjArQXF4eTQ4bTAxcEV6aDRlYVVoTytnc1dYSXFEb2ZsNjIxN0FvbTV5?=
 =?utf-8?B?U3lac3hRSmZBb3NRc1BRUmJaRzlOSXBPQ3lHeTBpNTN3KzVYaUw1WEtNSG12?=
 =?utf-8?B?aWg0NFBScnFneGZEM21NY1hWUXF4VldNOFBOWXRPazVmdWpzN3NwREVZWVJ5?=
 =?utf-8?B?ZHc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c09f8430-35fa-42c8-ef08-08dcb86db062
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2024 12:20:43.2628
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3aqntzexIKaRjvIjweiPb8FXBGQflmgdQWdRsJ8yf151cVeVPyBnQNEF4ArDwIrPDbwb/g5vkdKKjbowGODtyxbtJBV6sol/8JQcJ8A6tN4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8443
X-OriginatorOrg: intel.com

From: Daniel Xu <dxu@dxuuu.xyz>
Date: Thu, 08 Aug 2024 16:52:51 -0400

> Hi,
> 
> On Thu, Aug 8, 2024, at 7:57 AM, Alexander Lobakin wrote:
>> From: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
>> Date: Thu, 8 Aug 2024 06:54:06 +0200
>>
>>>> Hi Alexander,
>>>>
>>>> On Tue, Jun 28, 2022, at 12:47 PM, Alexander Lobakin wrote:
>>>>> cpumap has its own BH context based on kthread. It has a sane batch
>>>>> size of 8 frames per one cycle.
>>>>> GRO can be used on its own, adjust cpumap calls to the
>>>>> upper stack to use GRO API instead of netif_receive_skb_list() which
>>>>> processes skbs by batches, but doesn't involve GRO layer at all.
>>>>> It is most beneficial when a NIC which frame come from is XDP
>>>>> generic metadata-enabled, but in plenty of tests GRO performs better
>>>>> than listed receiving even given that it has to calculate full frame
>>>>> checksums on CPU.
>>>>> As GRO passes the skbs to the upper stack in the batches of
>>>>> @gro_normal_batch, i.e. 8 by default, and @skb->dev point to the
>>>>> device where the frame comes from, it is enough to disable GRO
>>>>> netdev feature on it to completely restore the original behaviour:
>>>>> untouched frames will be being bulked and passed to the upper stack
>>>>> by 8, as it was with netif_receive_skb_list().
>>>>>
>>>>> Signed-off-by: Alexander Lobakin <alexandr.lobakin@intel.com>
>>>>> ---
>>>>>  kernel/bpf/cpumap.c | 43 ++++++++++++++++++++++++++++++++++++++-----
>>>>>  1 file changed, 38 insertions(+), 5 deletions(-)
>>>>>
>>>>
>>>> AFAICT the cpumap + GRO is a good standalone improvement. I think
>>>> cpumap is still missing this.
>>
>> The only concern for having GRO in cpumap without metadata from the NIC
>> descriptor was that when the checksum status is missing, GRO calculates
>> the checksum on CPU, which is not really fast.
>> But I remember sometimes GRO was faster despite that.
> 
> Good to know, thanks. IIUC some kind of XDP hint support landed already?
> 
> My use case could also use HW RSS hash to avoid a rehash in XDP prog.

Unfortunately, for now it's impossible to get HW metadata such as RSS
hash and checksum status in cpumap. They're implemented via kfuncs
specific to a particular netdevice and this info is available only when
running XDP prog.

But I think one solution could be:

1. We create some generic structure for cpumap, like

struct cpumap_meta {
	u32 magic;
	u32 hash;
}

2. We add such check in the cpumap code

	if (xdpf->metalen == sizeof(struct cpumap_meta) &&
	    <here we check magic>)
		skb->hash = meta->hash;

3. In XDP prog, you call Rx hints kfuncs when they're available, obtain
RSS hash and then put it in the struct cpumap_meta as XDP frame metadata.

> And HW RX timestamp to not break SO_TIMESTAMPING. These two
> are on one of my TODO lists. But I can’t get to them for at least
> a few weeks. So free to take it if you’d like.
> 
>>
>>>>
>>>> I have a production use case for this now. We want to do some intelligent
>>>> RX steering and I think GRO would help over list-ified receive in some cases.
>>>> We would prefer steer in HW (and thus get existing GRO support) but not all
>>>> our NICs support it. So we need a software fallback.
>>>>
>>>> Are you still interested in merging the cpumap + GRO patches?
>>
>> For sure I can revive this part. I was planning to get back to this
>> branch and pick patches which were not related to XDP hints and send
>> them separately.
>>
>>>
>>> Hi Daniel and Alex,
>>>
>>> Recently I worked on a PoC to add GRO support to cpumap codebase:
>>> - https://github.com/LorenzoBianconi/bpf-next/commit/a4b8264d5000ecf016da5a2dd9ac302deaf38b3e
>>>   Here I added GRO support to cpumap through gro-cells.
>>> - https://github.com/LorenzoBianconi/bpf-next/commit/da6cb32a4674aa72401c7414c9a8a0775ef41a55
>>>   Here I added GRO support to cpumap trough napi-threaded APIs (with a some
>>>   changes to them).
>>
>> Hmm, when I was testing it, adding a whole NAPI to cpumap was sorta
>> overkill, that's why I separated GRO structure from &napi_struct.
>>
>> Let me maybe find some free time, I would then test all 3 solutions
>> (mine, gro_cells, threaded NAPI) and pick/send the best?
> 
> Sounds good. Would be good to compare results.
> 
> […]
> 
> Thanks,
> Daniel

Thanks,
Olek

