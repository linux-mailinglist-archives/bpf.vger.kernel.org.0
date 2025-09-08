Return-Path: <bpf+bounces-67703-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8776BB48CC4
	for <lists+bpf@lfdr.de>; Mon,  8 Sep 2025 14:03:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 61D041B24520
	for <lists+bpf@lfdr.de>; Mon,  8 Sep 2025 12:03:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85C852F8BF7;
	Mon,  8 Sep 2025 12:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="moR06agl"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 496311EE033;
	Mon,  8 Sep 2025 12:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757332980; cv=fail; b=IKqt1r8sIDU5MCDUinthR9Re3ueNPx8pmZxZ91Mdiw/FY5xG1WI2uEaAul2LhYfa8vzjGuWPPWshOwGxppyTMoE9IDYkB1nYz2Q+q/5ohmMDNXviSUVF4a3R09ezipk0pa/TimuMhKf9EWqJ9OAuKUG7W+oGBpEyQqQH4Gjzi60=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757332980; c=relaxed/simple;
	bh=nbZkZjWYxrg0DScKYPZb5i/ykx/Nm2q2Me/AesztML0=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=eV3mI1UPxYpB/nChRLwTn4Vksw6DO3f2hSGr9Mf/CyyYN4zlWgMcqiUP5SINzQCqdOI2bFR+d2qon2SguzEjFj5xHff0DBaocg2YcXyOrWjT4odN0L1wPLiUDYRytgJfPIEvGIh2jctpeyWpF1K9rFyzdgsMQ7pFkq6hRjNfzTw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=moR06agl; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757332978; x=1788868978;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=nbZkZjWYxrg0DScKYPZb5i/ykx/Nm2q2Me/AesztML0=;
  b=moR06aglCupW7xH/noKNPXeGcF9Gvwe6ZaR7uvQPm1jt3hvbqIzG0NGM
   Mnml3Zt0uDOXEwAPBAghEUIOFxpEPOZaJaFt9I8lPFqX2DUodROZ9RVX1
   M+HaWlxl6eyvpJeQ3tpeR7RhfKJp2gIijcV/Ty66Bc+2L4JGUhgSKxk7q
   dQ+ZPpIAdOYWuWcgF1l5dLf/47N/lGpyPiAPBy0t/zyubC4kRcJVMshWB
   q71+E9wky9z6AUY4auRzny8zKafN29z41qbbW94CR/ixSZlcWvL+lX91P
   +a49SOhxdQbPfkjNF9xmJ17bjA8i3Oz5t+GHG1RNLj2FX2I5+MB+hXP26
   A==;
X-CSE-ConnectionGUID: NOnY6RlyTAKAL+0mtvsnPQ==
X-CSE-MsgGUID: ZD2wmIc6S8aRTBaX+v2VwA==
X-IronPort-AV: E=McAfee;i="6800,10657,11546"; a="85030102"
X-IronPort-AV: E=Sophos;i="6.18,248,1751266800"; 
   d="scan'208";a="85030102"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2025 05:02:57 -0700
X-CSE-ConnectionGUID: cns7eKQ6T0WQa1CCth04+g==
X-CSE-MsgGUID: WnwPHxLwTpeiPYkvSFcxEw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,248,1751266800"; 
   d="scan'208";a="173562373"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2025 05:02:57 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 8 Sep 2025 05:02:55 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Mon, 8 Sep 2025 05:02:55 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (40.107.237.83)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 8 Sep 2025 05:02:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Lf2hxAtbT5sInzjX4YSUm7sbv/pyZLsr1elJMphDQVrprSWGbzfbz0C8uriY0k8o/XBurkNR3HMx+8TcyBcClXP1YsAAuFoEw9xbhLxfw1yFX4a183uKs0YXjf70iJA497gR96jtERvVaVydoj5f/nUHPb3+Fa5EO+ETa5dMi3r0rJRcSwLTQ0OH2maieMF7G+xKJ/jrsjibgZz87LoUsRVvJud1lbtqfi0o4Q4qHjvCU9Zs6kowF3ANRcF2gjSUk4QWNkuZ5KquiNozcI1pw8KU6xVVsZhFBOTNfxI1ZJqWx3JDWW6/oUKKCZzqnEgyxTm0q5oGJ8S97QhFaFblRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ntSyZNzrnzLv3ZG+HrBwsI4n+I3Uh3K2OX4+AtqR7Aw=;
 b=HKygH4NaeM0F+0mU+1IkLr1cDEbsjIwAuNAsqoGSs52L2QfIGZbHcbCUTrL5KRXJu1NRmuD2iK45K90iX5mIrUA54ZkjI+5wmBvWLi17pog2JD0cBVUCLlz2o74QFfaZZOBn/JF2L9rSKLMl4z/qOj0LEKf7FUqEb0tV0Gl3ks15gyvu6JTb7V4uezfcczVC4re3fhPcpiA8aepiWGB/pCGpTadQLv7j1wMWZBKrjOPT6Q6efQvcrZYUM+czaGbjMvswFn6OvwB0+dI/oV1/F6cExaRdPJbOgfh8oXtdoTIs/MIc1zcIg+6Z6DElUPot+CR0/4/0LlPFb+PwscqLXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by SA0PR11MB4749.namprd11.prod.outlook.com (2603:10b6:806:9a::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.19; Mon, 8 Sep
 2025 12:02:46 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808%4]) with mapi id 15.20.9094.018; Mon, 8 Sep 2025
 12:02:46 +0000
Message-ID: <2d630a13-ca07-40df-8544-7b0e9373eaf1@intel.com>
Date: Mon, 8 Sep 2025 14:02:05 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 0/2] net: xdp: handle frags with unreadable
 memory
To: Jakub Kicinski <kuba@kernel.org>
CC: <davem@davemloft.net>, <netdev@vger.kernel.org>, <edumazet@google.com>,
	<pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>,
	<daniel@iogearbox.net>, <hawk@kernel.org>, <john.fastabend@gmail.com>,
	<sdf@fomichev.me>, <michael.chan@broadcom.com>, <anthony.l.nguyen@intel.com>,
	<marcin.s.wojtas@gmail.com>, <tariqt@nvidia.com>, <mbloch@nvidia.com>,
	<jasowang@redhat.com>, <bpf@vger.kernel.org>, <pavan.chebbi@broadcom.com>,
	<przemyslaw.kitszel@intel.com>
References: <20250905221539.2930285-1-kuba@kernel.org>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <20250905221539.2930285-1-kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TL2P290CA0010.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:2::8)
 To DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|SA0PR11MB4749:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ac4596f-6cb5-483f-cfef-08ddeecf9fad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?K25HUk5URWxZOXNXcFh2UGFIOW9ibFV4blFWcFNpN2ZWWGhra3dBeDhMUWkr?=
 =?utf-8?B?ODlRS242SXI3bUwydmxrVGxQRUZxZ1pWSDhjdWl2ajNtYmp3b2VyUjdabUNh?=
 =?utf-8?B?V0N0WHhZcnkvZDBEblJOYW9sbVVEODhyamQwVVJrTlVIcVlDeDVQa0tQRU1Z?=
 =?utf-8?B?cVI2MEZScHk3TmpSYkdnK09WUjNJQXpTV0FrYU9NNVBlemNXVEptbklXeENn?=
 =?utf-8?B?SlZMenZPbDFJdzUwQ0dkcWtNOVd4TGh3T0NDRlROSDQ5VXd6L3BpWVVCSGR2?=
 =?utf-8?B?d09HdTA2US9PcnQrMFZVc1BxaUZkU3dRVzhDM3Zhck5rTXVhcldaOGxITC8v?=
 =?utf-8?B?aFcwelFMeDdQclYyd3F3QmN1TmVFUFNDRXhIVVhYck1PUmhYUWdMM05ZNVkr?=
 =?utf-8?B?dU9EWW53K1VSQi9xaG9NN2dCSllzdUtaK3NYT3ZRdUQrL1UrRlFqczRoT1Vr?=
 =?utf-8?B?bzdSOFNUT0pGc3UrQkxZWnFZTXlOajNGUjlDam1iWmVRMTRlSmlRSlJGUCtG?=
 =?utf-8?B?Q3dFSW1NRUNZdkFGSmV3eHU4bWgvbmo4cE9pUHZIUllZWVZ6SU1uUDAxai8v?=
 =?utf-8?B?eDhPWXRhcHp0SEdMV0RQclhuVEs5QnhZOWsyNE83S1p1ZUlJV1BJNWNpTnhz?=
 =?utf-8?B?S1I3Y2hnSmQ1S2QxTEl2b3VsVEkyR2hsYzF2MHprd1JKZURNQk9oay91Z3lI?=
 =?utf-8?B?MnR0MUN4Zm5WUG5XWFZ2ZnF4T1VXVXpmdzZLLzdsaDhMWGxrWUVaZm9UNkFE?=
 =?utf-8?B?bHpmWDJCZEJ2aTJ0WkQ5OWZGSFUrQ3N3bUJBMm90My8weXdVdy8wV1h1QTZL?=
 =?utf-8?B?TUVTZVU1WWdvVzU3Nysyb29ZVXQ5eVB5UmRwSmxZbnU1aHhoNC94Y3YrZkhB?=
 =?utf-8?B?YUNzZ1paSGdrRkdGQnRaaSttUVJFODRrMTdBdkhFSWIvUU5IVXhDdXFKcTJH?=
 =?utf-8?B?TXJ4VVJ2VTNxMkIzNElSMlZJS1QyNTYxd1BnNUtVWEdEMk1zdm9CbE03aFpr?=
 =?utf-8?B?RUZweHcrKzFTbFlpSUFFKzZmS3pJWmk3TWR3SCtVdHJNMFo5OHNyblVMcDNh?=
 =?utf-8?B?RFkyejFpZXlLeTBNNFFJUEtQaStqR0EyYjFIb3FZVnNoTFpFcXYrVkwzZ0JR?=
 =?utf-8?B?S2xYcVJsbTNSUkppMjJIQ0p1ZFBBR2diVExIVkdUWWg5LzFMNS9DK0tnaTVr?=
 =?utf-8?B?dHlLYks2R1pDM2RkbHBmVzdXVGhiTjN5cGwrcE1jaGlOYkdBNWhKOCtseCtV?=
 =?utf-8?B?UEwyYTBIK1JvQ2M4eXhLV09tcXAybDRzemdDY2RLemNxcmhmOFIyQ2E4ZTVF?=
 =?utf-8?B?bGhzZ211ZXQrRC9DK25nSmlzRWsxejlRaEgvckI5dTVlcWErL2JOeXk4aVNH?=
 =?utf-8?B?MmhvdkdBaTRwNmVzWlc5dG1zQm0wZUk0cnZ1SHZKVU9SRTcxV3U0ZUM0VUk3?=
 =?utf-8?B?TDFXbDZxNzNGN2lSUVJhdmtFend1ZmttV0ttSXpFSTRPTE9lN0FCZmlRYTNC?=
 =?utf-8?B?amxZVHQxM1dvb2I5cUVlRzRJYkozLzVLQ0kyQzVNeWx3S0pxZCtmcU8wS1BI?=
 =?utf-8?B?czFPcmN3TXFISml1UUROVDMxdTFvdGFEajYvVTN3eThWRHl3dzRMckVyV0Nz?=
 =?utf-8?B?RkI3WUc5Yys4WlhzRkxFUkhYS1J6U2wxRnJ4cEc1SVprWFIwVWp3ZDJKSEpi?=
 =?utf-8?B?dElrMWxBU3ZzVUlqbTEyVTRaekJvZVJ1b3BHZklzZzhLbnQ1MEZKM1hibkVK?=
 =?utf-8?B?U3VsZmdvNDA5ZTIyL2pPRFA5MnNpNVlVNlhXL200OEpaRUNxNmwwMnpjWHp6?=
 =?utf-8?Q?gSVUKDiw0FObFoCMctbgYme2W9raL0PkODi94=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aVljVEY0b3JaZWNvWitxbVhOLzdhVGQ4V1ZMa0o2SW1pOFZHcktxMkh2b1Fy?=
 =?utf-8?B?WkZPQm02TEZvcEN0Mk8rUUdLbjcyM2Q0MWtOeWR6Y1NibVNBajQ5NEhGVDdH?=
 =?utf-8?B?NFlpeEt6VEhBTDBkcmhCMk1qczZhTUY5S05IaWZORjBveTlveXY2NkF3NjI0?=
 =?utf-8?B?Qll4enEzVThHYW9YWkZBV3hZZEVieU0va2FMRjc4RG5CS1BHK000VEFmSGhD?=
 =?utf-8?B?MFpuL3ArU01jMHlKZEtobmhRWURSRmRrM241MjdRcnI4TVlmVFRCdTRwdnVO?=
 =?utf-8?B?VDRMREF1THpYdjcwTkVGZWpkRkV1TU4rdVVibVYyZHRQWEFQcnpvc0pEaHpX?=
 =?utf-8?B?N2NLVzBBdXgvSWhqNlBjMVhqMzNobXcvVlJCVEYyZUhMcDE3cys0YlgwSndE?=
 =?utf-8?B?VnZob1ZDeVd3bkRMNDF5aUJnSUo4VzU3SlM2RlhlcXhpUXhaRWF4Wkt1Mzgw?=
 =?utf-8?B?QmNCdURJSEIyZ0lYQndRVEZtaHBlL0ozcHNFM2E3SUJ2UHBjbTVDOUI3QUtm?=
 =?utf-8?B?MS9HeHZyalpCdmVWcG5EVG4vaVVGc3Q2SFJ0N2JoSDhCZTZWYnNsbnRrc3NT?=
 =?utf-8?B?NkloaDZTM2w3dXlMWExRdDNJRGtZMjFqMkpjamREaURUZGI4Nlo0ZUZHY3JL?=
 =?utf-8?B?ZzVVOExBd1VGcWdkZXZlbklYd2VhTThYMHU1aE91MktKTExzVEMzMkkvQktu?=
 =?utf-8?B?ell6Y0hZdTdGYTRDQ0IxaUd0N3Z1ZnZMT3E0d2g1bWM0ZjBkRU44Vlc5MkQ0?=
 =?utf-8?B?ZU1ZczRJcWxzUDFPVmtaa3pQb3NZVi9wdjlkVXIrUGhMZUxIaHpxb2Y5alZJ?=
 =?utf-8?B?V1luaVJPdkc3WFJKMjJsSEV3elVLWXRINzhEWklpekNQTUFQMVpUNXIrb3RQ?=
 =?utf-8?B?eS83WENqU0VhT1BNUUZFVGFibGZMU1MrcXpsd01nTlI4WHdjdlNONUZPeTVO?=
 =?utf-8?B?UmJzV3FGYTM4Y0N5QS92ZHJ4dkZCY3hla1F1QXpCd2xTTG91S0hLQVV0b2tV?=
 =?utf-8?B?RkdUQmxhZThCRzBYeFk3WiszbDdKSFZkZ1VBN3NEaXk1ZDMzb0JYQlo2U2hx?=
 =?utf-8?B?Wk9COXVhNWdMZ0Z0NzZ2a3BEZmNFdlAwajlrUTBvN2N5NWJKVVB4RUgraXBH?=
 =?utf-8?B?RCtObjlEc1VtUVVJUFhXZVFoenN6UXJ6VmZnS1Fudm1tNjBSTjZzNXUxZ0FQ?=
 =?utf-8?B?WXp5OXNrTlB6OU1rQ29rVEVtWXFPeHQ3bFFEdDlNZ1lOV2YzcDQ1S1hZa3FR?=
 =?utf-8?B?NElMQ1N6dlgzeWREQ290SlV0SENzMHZRdm52M00zOEpic2FLbEFjREVwSHI2?=
 =?utf-8?B?USs1SXhMV0pwTFBxaFM2VlBUTjExK21nK0lpRStta2ZZeXhmeElkbm5SUC96?=
 =?utf-8?B?U29zcDRqME5WYlJRVWNhb3ltTyszelg1cWEzV0NnYVFJaUNzbnVxS1BSTG1Q?=
 =?utf-8?B?ZG9kK1NMLzlSeHpmWHpyNWJwWDF3MTRZeHJjdlBSb1BmcnFxWlBzVnRzLzNV?=
 =?utf-8?B?cXlsM2hPNlkvaFVId25TTkxKSm1qaitXd2VwbXZxOHRuM21HZytZVUJmQVFY?=
 =?utf-8?B?R1lMbTNyeUpQZ2dsLzNhVERnMUFQRFE3UzlPQ1pWNVNPaGJqZEZtRFlPYVdB?=
 =?utf-8?B?Nnkzbk96Zk90bkVhYUxoeE0xRE1rSlltS0tVdnpLcXRmdnkrSll2RTN1WFM1?=
 =?utf-8?B?ZllZTktDUU16NUV3VVRsc3BWeHRnSEk0TzI2dGhmZ0tNYXVXZGZqbVUxeWRM?=
 =?utf-8?B?MGRacEVWN25LQzBEWGxpakpNWVR4TFJsTXZWaHFjWGtOYi9iWlFhbkxLTzJL?=
 =?utf-8?B?UzRqYmI0eC9QK1dKVklDTERZN2lMdDNGNi9aUzBoRCttekl2NTVzTHFWNTQw?=
 =?utf-8?B?dkRUaGVEcmhvbjNOQWtOSW9KbnNPdk54d2tyVjI0VXo4RWV4RWpzYlBTSUxk?=
 =?utf-8?B?eWRGZlYycnd5MWV1ZlNWUnZJbGZ6SzQrSlcrK3ZCcUFRVDNMOHU1cWFmZ2Yy?=
 =?utf-8?B?OGlkdXRFc2YxeTRwQXVVbWN6SkZ2M2RORGlhbGR1eVdQWHptcnFaSUJnZjli?=
 =?utf-8?B?S0ttWXBWVk1CZnFUbTVvMHZQUTlZd1hvYXBIZG5jVUJZbTdkOWZ1MjBvSjRD?=
 =?utf-8?B?eVRjVXpITDZZWXo4MEdlcHgyTlB2UDVBSjFDRktVNERFT1JJL3JsazdQMFdS?=
 =?utf-8?B?N1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ac4596f-6cb5-483f-cfef-08ddeecf9fad
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2025 12:02:46.4787
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3VVO4tuTtG9vliqxHOKBvfsJZx7PY7KDjLJ5wS+8kB8rMDpXu7puuzORfArQW7bqKMG9R0qBh6WEwu/J8bTo7H48SLz5SKQ8dWBtCgaxvvw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4749
X-OriginatorOrg: intel.com

From: Jakub Kicinski <kuba@kernel.org>
Date: Fri,  5 Sep 2025 15:15:37 -0700

> Make XDP helpers compatible with unreadable memory. This is very
> similar to how we handle pfmemalloc frags today. Record the info
> in xdp_buf flags as frags get added and then update the skb once
> allocated.
> 
> This series adds the unreadable memory metadata tracking to drivers
> using xdp_build_skb_from*() with no changes on the driver side - hence
> the only driver changes here are refactoring. Obviously, unreadable memory
> is incompatible with XDP today, but thanks to xdp_build_skb_from_buf()
> increasing number of drivers have a unified datapath, whether XDP is
> enabled or not.
> 
> RFC: https://lore.kernel.org/20250812161528.835855-1-kuba@kernel.org

Reviewed-by: Alexander Lobakin <aleksander.lobakin@intel.com>

I have plans to add possibility to run XDP progs on devmem/io_uring
queues when it's known that the program doesn't heed to access the
payload, only the headers. Currently no free time slots for this, but
eventually we'll get there. This is a good prereq for this.

Thanks,
Olek

