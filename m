Return-Path: <bpf+bounces-37514-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D643B956DDB
	for <lists+bpf@lfdr.de>; Mon, 19 Aug 2024 16:51:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 075931C23BCB
	for <lists+bpf@lfdr.de>; Mon, 19 Aug 2024 14:51:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66B81175D35;
	Mon, 19 Aug 2024 14:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="f5FON725"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30BCE171E5F;
	Mon, 19 Aug 2024 14:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724079068; cv=fail; b=sXPC7PccI3gz80VoDuHrJSW3dDHxKRaF18SM+IFbAjOokD/paZ+BBdWEghxusduWhaED14r+HZyyu/OJq/jCOIDQfawv5LnT7CmE+R3Fe8FYZ9Az++mlR0E6ZeKavBLQru15YLT0CclioV4kEBDP/To9xP4W49/S1aFLN9h/3u0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724079068; c=relaxed/simple;
	bh=+XONgPgxu7I0IFZlN3Mul8zMGrRRQBBJdprJMcfFg60=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=NipMyqYacpdmPospEcub3NrNxwaYEEDLOI2o2U63o88GiVsWAinav45xngBPsqH/C4LMqhte0i2g4vwqubxqd4rqA+3C3iui5+QU33N9q/gwzK2cMZZtW610g81MVj7tATPhTGVFkxzHfVzHnnE/rt378gqRgDd+tVN4rN2sTo4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=f5FON725; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724079068; x=1755615068;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=+XONgPgxu7I0IFZlN3Mul8zMGrRRQBBJdprJMcfFg60=;
  b=f5FON725ZDNqTqC9j+x1D7oYB8kszRdalgQg3/UYniVPNkOGKT0R7V8r
   USUOGPUwguZHMTlqazSnGgCQPrlh30P7/dSV7lqzH7rCiLbY0bpVe53BP
   y8IoCFth6UR0Mhf0bWr5R51Y2w05+GtyanfUKLQMFf67dzi6ThdsUNRZt
   iNCRd3/KdHwx7ZfRwsWRsDnF287obICkMCDVgIDcI6DznR7DvNFsUO+Hy
   h6elXDQasaFYv9rUXrso7ZhpU2ZZPP3iDVLyfv4DwGxeFXl6m4qJjV5PK
   TQjnVatq+404FFJQmQlhmpEos6lpbE5GDeuybz0DjyiclUYLGKAs95bzh
   g==;
X-CSE-ConnectionGUID: Y3IuEI8bSkGNXU7EZ37YLA==
X-CSE-MsgGUID: bIkilW/JQfy+mrIFFWrbXg==
X-IronPort-AV: E=McAfee;i="6700,10204,11169"; a="22472896"
X-IronPort-AV: E=Sophos;i="6.10,159,1719903600"; 
   d="scan'208";a="22472896"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2024 07:51:06 -0700
X-CSE-ConnectionGUID: 2+2w9tU5TamNDqVwqPa1/w==
X-CSE-MsgGUID: k8rsIJERSzCRjYrakMlzug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,159,1719903600"; 
   d="scan'208";a="60708570"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Aug 2024 07:51:06 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 19 Aug 2024 07:51:05 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 19 Aug 2024 07:51:04 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 19 Aug 2024 07:51:04 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.41) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 19 Aug 2024 07:51:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DZ54FNImAdYLVIqSxujyttAk3WNNYSZ7S8toQBpaOfqdxbkX+ewvtcVbxzmqMlkoweXA7GolWtax/NIX5e7a1dzHx+H5IpFr/vijWLVRt5UdRi0WUZR9PjGo8xM+0L6dwhs3k+ry1uwEnqT2lNyvMxOL8ng/bcpJkG144vA6eM+8O4gsxWt1WrzyfNpjvPPKdjD5yBJIddBrrklcP+H5dQ9E0xlrbDAfR3+Qe4yM4TvFeBYj6PZEBARk3yVgq0w29zGTgrGp5pIGbMZslwNmLh+6gNkYp4t+kpSC56NDkSZjtVrbht6JsbUePYgO4LWomrfkV/fvaHtsPhYoYXfiMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4KmD1Oz+6O3VQhfusFsJ5P04JQ6ttuGSpkaqOK2TfM0=;
 b=NwPPFpOYk7RB0PoIoK73ZOdeeAXmrmX/iLp7wbk9MqvRDTi1IrIMZrFTnfrOmBYNvm8YWPW9qJT7IT6PAOVjgVO7Vni4b0OfiBMIgopzcmF//ykAYmXagH20Y5rIKO5EczSAh7z40DwjCYH45i12auYK0l4IIQwsfLSkoJhoEAtHy3UmXreT4XGxuMJgfnrBtMevdYB+v7VzHy2ymF+Kdq/KiNp3tqGJ/p3YnLlr+pTtqy1W5RdBt2ODINkHJ9Rk642djcE2jf+dVfHdTr7f1FbLHFx7ynA0Pwk0g7HdITVWpOv5Op6RXhInDc2GAQOKqnl4W/EbHdaNENZUmIPA4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by SA3PR11MB8001.namprd11.prod.outlook.com (2603:10b6:806:2f5::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Mon, 19 Aug
 2024 14:51:01 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808%5]) with mapi id 15.20.7875.019; Mon, 19 Aug 2024
 14:51:01 +0000
Message-ID: <c596dff4-1e8b-4184-8eb6-590b4da2d92a@intel.com>
Date: Mon, 19 Aug 2024 16:50:52 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [xdp-hints] Re: [PATCH RFC bpf-next 32/52] bpf, cpumap: switch to
 GRO from netif_receive_skb_list()
To: Jesper Dangaard Brouer <hawk@kernel.org>,
	=?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>, "Lorenzo
 Bianconi" <lorenzo.bianconi@redhat.com>, Daniel Xu <dxu@dxuuu.xyz>
CC: Alexander Lobakin <alexandr.lobakin@intel.com>, Alexei Starovoitov
	<ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko
	<andrii@kernel.org>, Larysa Zaremba <larysa.zaremba@intel.com>, "Michal
 Swiatkowski" <michal.swiatkowski@linux.intel.com>,
	=?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, Magnus Karlsson
	<magnus.karlsson@intel.com>, Maciej Fijalkowski
	<maciej.fijalkowski@intel.com>, Jonathan Lemon <jonathan.lemon@gmail.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>, David Miller <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, John Fastabend <john.fastabend@gmail.com>, "Yajun
 Deng" <yajun.deng@linux.dev>, Willem de Bruijn <willemb@google.com>,
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <xdp-hints@xdp-project.net>
References: <20220628194812.1453059-1-alexandr.lobakin@intel.com>
 <20220628194812.1453059-33-alexandr.lobakin@intel.com>
 <cadda351-6e93-4568-ba26-21a760bf9a57@app.fastmail.com>
 <ZrRPbtKk7RMXHfhH@lore-rh-laptop>
 <54aab7ec-80e9-44fd-8249-fe0cabda0393@intel.com>
 <e0616dcc-1007-4faf-8825-6bf536799cbf@intel.com> <874j7oean6.fsf@toke.dk>
 <34cc17a1-dee2-4eb0-9b24-7b264cb63521@kernel.org>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <34cc17a1-dee2-4eb0-9b24-7b264cb63521@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MI1P293CA0003.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:2::19) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|SA3PR11MB8001:EE_
X-MS-Office365-Filtering-Correlation-Id: 664ffd8c-5ede-447a-f5d0-08dcc05e57d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UDZzbHpMeUZSeXluSnRaclIrSXJTRGFWVk4vSFozZ0t2dXBST3BDTXQ5V0xm?=
 =?utf-8?B?SHJhNzZXV01WOGIrczdBenpNZW5HQ0tlaXF1RUhxL2JsNUVieTNYa2xsaWVB?=
 =?utf-8?B?ZDlUTExtK1ZXQWFqVE1hYXgyWDdUM3dROVJUR2g5M3kxVnFGQkVhcVJ3ODZ6?=
 =?utf-8?B?RW9Td0toTXZVdWx5dmpiODdISFUxVXBMbERQMFZXUG9EamlqanhvQ29US244?=
 =?utf-8?B?TUREdEg2dVdNd2JlNDcrRlNVVjdVNDhla0l0eDZuOGMyK1VlenhVaU1zTnFV?=
 =?utf-8?B?SzAvVVZCRlVYeXY2b1V2em01OUFBUmV5NElBdWxYWVlJM1BpcEs3ZnUxSVRV?=
 =?utf-8?B?NSt2d3BReXkrSk54WXpQQkk1ZjBVRnFqUHR5MTZibHlZR2RCS01IaU0yV2Fi?=
 =?utf-8?B?NUthbGdFeFppcVNTYUxHbWQ2Q2R3RjJuN2NoUk9jUkhvclJPa0pESURDZVhz?=
 =?utf-8?B?REh2OTg2TTBQR1dwc1NOc2tnUGZDcVFTSTh5NUN0NDA4cUpzV3Z0Y0N4cWRh?=
 =?utf-8?B?dmROSTJFejRQT1dPMHFYTklnSEV2aWUwT1pQRWdxNmRwUEtrSXFvQ0dZQUxW?=
 =?utf-8?B?dERLaXQ5Q2QvVTNQZ2h5QWhkZGFhU3hHSDI2VEFzR1VwSTh5RU9LRUxIRktp?=
 =?utf-8?B?VFE5WEMySkVuSFNKaW40VXNKZTBCK0lOTmFlelo2K1BHTlEwS0lGWXBKd09J?=
 =?utf-8?B?V25FQU5OWUVEYzExMWpEN29HbnJYYWtLRXR3WE9xRk1DZFlESXhjcUFXdjdj?=
 =?utf-8?B?YVRIa0VpZ0gxR0Rwa0NiZVhjeDBhYmZKWnpHWWlZT2lmWXozQUtTRnUrdGxi?=
 =?utf-8?B?S2Y5UDVTSGh5N0NXRTZMSERNVzJqKy9aZHAxdmo4a1lDNjhhVXJyS05mdzZz?=
 =?utf-8?B?REVrdTA1bjNoV3B3WVZoeEdKY0NnUzVKK1QzdzBNTTJCYWtKM25MU1FaRVJF?=
 =?utf-8?B?S0RvL05tTTJrckFpVmNKQVdmNmJWbVhQcnF0bmhxbitxKzA2bUNVVnJWWFNW?=
 =?utf-8?B?a1FqR2ZRK0dWYlhEUm5lNnRnSE9XUmU3dDI2azdROTF0ekZlblpGR05oeEEv?=
 =?utf-8?B?b05sVncyQTRGd3JuM2NUZjZzZjkweDlVNXJ6Q1dQRVFPZ3NETGloTzhhLzRL?=
 =?utf-8?B?NEJRL0dOV1BwVzRISk5hYitMQlhnYVl5TlVOVVBWZjBBWkdKalU5WVNWRTli?=
 =?utf-8?B?RlhsbFpkMGd2Rms1dXhoZHg5US8zN25Vdk5SR3dTNVJvOEY1ZWFkclYweCtL?=
 =?utf-8?B?TG1FVmdjS0UzS1RDbHhoN1dPN2xIcVJ2c3pReVJlYzcveHU0Ti94ZHgzcVVG?=
 =?utf-8?B?RVppc21uSVpqeC85UXJER0VnK2hKNWpzaEJqQnpMWkxhRFlGRVdLY2dKSFQ5?=
 =?utf-8?B?Q212WU1PVzlaKzVUbHVkVjRxUnNuVktnTGh5bHpPS1lOQk4rUG1QN21QNjll?=
 =?utf-8?B?V3VIb3RvUVdPMlBLL0ZwOGRVKzYwZFRiZmt1VXZwazdJeE44RzZxVDdoRzc3?=
 =?utf-8?B?MVpqbDF0eGc0L1orMzMxTHYwZ2VJYnE1VUZyOXFTazF3NVFTWDFyTUZ3aGww?=
 =?utf-8?B?U1VONkg4VkZ6V2lISDZtd1UzSU9LelcrandyT2dUc2VXUHNMcUxnSCtxMWJP?=
 =?utf-8?B?OW1zSWZsZmEzUVZ0a3VNZWE5bGkyUmZmSHBFaHJQUXdjYmgvLy9qb050OGFz?=
 =?utf-8?B?RVJjMGplMzZNLzQ5S1RRdU5yV21Kc25qelJyK3EzMGFBUGlFNERadGRqb255?=
 =?utf-8?Q?94xzOJckHi30NvfSJw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N25EWTIxWnphS3NvdmhKS0JOTEJRZjk1ak84VElHeE9ZM21KaUtuQXM1REwz?=
 =?utf-8?B?UVhZOE9ITWEvcENFeVdmcWRmR1dxaXFIc2pYY0h6dk1hUTF4SHdUZEVzbG83?=
 =?utf-8?B?cDhHK0wyYW81ZDRWTnlKZHorQXNPNjhrUU84ZmkraytXS1F4V21JVEVqNXk1?=
 =?utf-8?B?ZlVINDRCVHJKZ3RVdTB1dDBuN1hhcERBQ0FEeHJkWXFxUituZmk1Z2JmU1Zs?=
 =?utf-8?B?cW0vTXNpaC9NSjhmVkFsM0VFTlRBTEEvWS9xTXNzRjlmaEdRMnQ2L3BiUGVM?=
 =?utf-8?B?RnhrbzAzWkdGUTJCT1g2VmszOVBkQzM2M2hlZ0xCQ1RpNDVyelRjRkdjbVFY?=
 =?utf-8?B?T2F5Mk5tTjRzTC9WNnVpRXAvTnJob2pzK0ZiWThsbEFzQitHSG56Y0tMZGcy?=
 =?utf-8?B?SDhlendOazlMZUpzN2ZEQU9pSTlkYk9SZjdORDh1NXFOazVQOXJYNS96SWln?=
 =?utf-8?B?bysydXN6Rm50RWQrL01TN0JYV20yVEFkWDFKdUxZOGNENHc4RG5oVmI5OUFz?=
 =?utf-8?B?dWhRMXdoaGlRbnB2eExVY3pKS3FoYjNpRGU1UEFOREFqY1JTa1BXS1dqd2gy?=
 =?utf-8?B?czl1VGxDaHY4TTRuV1hxM2VkMk1JOHY0WW9MckFrd25sekJiblVsZkJxOXlq?=
 =?utf-8?B?bkhiTERINjhsU0V3aUFJQk12aU9VMWJFUHNrZW1uVW5RZ09lK0NjYmUrNk53?=
 =?utf-8?B?MXRsdm1TdktrdndWSUhwWW5CcElLNmJ4dk5XOFhkN0FZY2VCVDhiSzh1Ui9o?=
 =?utf-8?B?UmMvUkFVYUFDTHB2cHlaa052Yzd4cHNHUFRvVXRndUl0dlVKUS91dVp6R3Uw?=
 =?utf-8?B?N1RmK2dTQ1VHRWZqWHcvTGJ2SnJ4QzBGUXI1a05TRFRaRkRZelhpa1NxbVli?=
 =?utf-8?B?WFh4R2NXR3BjQU1aVHdOVW52TXMrWmlTZllXcThDTCtldHp5bXdtd2h3eXpv?=
 =?utf-8?B?SjZyYUhmaWhYZXZ5YUJEZ0JFSHpYUnNwMkErTlV4K2J0RkJ2MjFKbDNiR2NU?=
 =?utf-8?B?d3N2ZW83NkRoZTdmVXp0dElxZnNJMFRRV3BXL2YrVUNSR0NKVytRR0NRVHVi?=
 =?utf-8?B?V0tOMU5TQmhYS0UyclNzTGZWSWNGaUhZM3owQ25VQWZRcUJpb2JZQzBabjcv?=
 =?utf-8?B?Q1hlY25sZDNCR05vVHJwQVpsUWJ1S0tYMzNIOHcvVXp4Z0hwd1RMN3Rzd0pF?=
 =?utf-8?B?VW1oOVpqUVNBR0dOaU14d2Y2ZnprdVNLdzlENFVwY2ZMK21DUkVQd2R4ZktE?=
 =?utf-8?B?dEFwL281SUF2dmhSekx6MGpVUi8ra0RvaHQwK1d4SVcxTGU4TElwdlY5UmFM?=
 =?utf-8?B?c2wwWWtLY3NUUEFwOGUvZjM4ZEdVaTVheGVHVGZ1dWlCcnV3UTFBRnR2aGR4?=
 =?utf-8?B?RytmeDdRR1l2eFZ0TzBkMzM1UEgwdm5HMEFtdGhOay9sWVBpUFIvYS9CQldH?=
 =?utf-8?B?aVVydXYra0tUMGp2M29LNFBxcUR1bXgxQ2NLem9pR0Ivd2djT3pDSE9mU0lS?=
 =?utf-8?B?czFZWDlPUk9OLzFuWlFVdURLWmRuenY0RHMzZ3pIdUtQWjVHdFRNVEEwdFJn?=
 =?utf-8?B?R0kwWWFaMmUzS0JYekRiUVp2Yk9BNmVrdkVpRVJCTm5aMTF6Y1BzS244WmZj?=
 =?utf-8?B?RGw0dXExMnBrUVhYOU9UTjFicTllR1k0dkpIVytYcFBZbDBxQ0VMUlMyY3p5?=
 =?utf-8?B?R1A1b25KaGRmaHVBR0NqcExSdlA5Nm5uZExHblNNdmpPdUI5d0lzZGlYeDdQ?=
 =?utf-8?B?ejI0YjdFUGE2R25kanNCMTZDWThyakVRMTBFVVZGdnhlZkRzbVNJOHpjWUNm?=
 =?utf-8?B?c2dRYTkvbDZyczAzK1hORlBjZnpkRjlwNTdrTUJUMFVKRDNia21Nd0pMcXRm?=
 =?utf-8?B?MWsyOXdyWExDWFBHZTRnYjdMamhPZ0JzWjMvUkNrZDBZcEZSNVkvbkwwS0pn?=
 =?utf-8?B?V0EwK2xOd0RlVEw2RUtERUlwTHk5S3RXMUJ4TnBZbjdCWDB2NDdTaUMvMmQw?=
 =?utf-8?B?K3MrRC9TdGFaTlIvSGVjV1V3RGxUMUFManpqZjYwaUptOFl4VnJDM1V1aEov?=
 =?utf-8?B?eGhraUNBWHdVMDNQbGhYdWROYzZkQUNLK0diV0Fqam8yNGVqeHRuakRaaE5x?=
 =?utf-8?B?MENKcGN4V1BuT2J6TE8zRWJFckgyT29qODVFZ2YzOUl0V25iMk1CckpLTy9J?=
 =?utf-8?B?Nnc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 664ffd8c-5ede-447a-f5d0-08dcc05e57d5
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2024 14:51:01.4411
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: acJvuyRaa2m/XdOXRmS67VzfwzOaf3HTckY1e+ch50CnKNy2oYjzb+hoiPZmh5K4Di+F+rsocdcr2FYK+HlUyPubJudFXAsvEBgZb/kfnps=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB8001
X-OriginatorOrg: intel.com

From: Jesper Dangaard Brouer <hawk@kernel.org>
Date: Tue, 13 Aug 2024 17:57:44 +0200

> 
> 
> On 13/08/2024 16.54, Toke Høiland-Jørgensen wrote:
>> Alexander Lobakin <aleksander.lobakin@intel.com> writes:
>>
>>> From: Alexander Lobakin <aleksander.lobakin@intel.com>
>>> Date: Thu, 8 Aug 2024 13:57:00 +0200
>>>
>>>> From: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
>>>> Date: Thu, 8 Aug 2024 06:54:06 +0200
>>>>
>>>>>> Hi Alexander,

[...]

>>> I did tests on both threaded NAPI for cpumap and my old implementation
>>> with a traffic generator and I have the following (in Kpps):
>>>
> 
> What kind of traffic is the traffic generator sending?
> 
> E.g. is this a type of traffic that gets GRO aggregated?

Yes. It's UDP, with the UDP GRO enabled on the receiver.

> 
>>>              direct Rx    direct GRO    cpumap    cpumap GRO
>>> baseline    2900         5800          2700      2700 (N/A)
>>> threaded                               2300      4000
>>> old GRO                                2300      4000
>>>
> 
> Nice results. Just to confirm, the units are in Kpps.

Yes. I.e. cpumap was giving 2.7 Mpps without GRO, then 4.0 Mpps with it.

> 
> 
>>> IOW,
>>>
>>> 1. There are no differences in perf between Lorenzo's threaded NAPI
>>>     GRO implementation and my old implementation, but Lorenzo's is also
>>>     a very nice cleanup as it switches cpumap to threaded NAPI
>>> completely
>>>     and the final diffstat even removes more lines than adds, while mine
>>>     adds a bunch of lines and refactors a couple hundred, so I'd go with
>>>     his variant.
>>>
>>> 2. After switching to NAPI, the performance without GRO decreases (2.3
>>>     Mpps vs 2.7 Mpps), but after enabling GRO the perf increases hugely
>>>     (4 Mpps vs 2.7 Mpps) even though the CPU needs to compute checksums
>>>     manually.
>>
>> One question for this: IIUC, the benefit of GRO varies with the traffic
>> mix, depending on how much the GRO logic can actually aggregate. So did
>> you test the pathological case as well (spraying packets over so many
>> flows that there is basically no aggregation taking place)? Just to make
>> sure we don't accidentally screw up performance in that case while
>> optimising for the aggregating case :)
>>
> 
> For the GRO use-case, I think a basic TCP stream throughput test (like
> netperf) should show a benefit once cpumap enable GRO, Can you confirm
> this?

Yes, TCP benefits as well.

> Or does the missing hardware RX-hash and RX-checksum cause TCP GRO not
> to fully work, yet?

GRO works well for both TCP and UDP. The main bottleneck is that GRO
calculates the checksum manually on the CPU now, since there's no
checksum status from the NIC.
Also, missing Rx hash means GRO will place packets from every flow into
the same bucket, but it's not a big deal (they get compared layer by
layer anyway).

> 
> Thanks A LOT for doing this benchmarking!

I optimized the code a bit and picked my old patches for bulk NAPI skb
cache allocation and today I got 4.7 Mpps 🎉
IOW, the result of the series (7 patches totally, but 2 are not
networking-related) is 2.7 -> 4.7 Mpps == 75%!

Daniel,

if you want, you can pick my tree[0], either full or just up to

"bpf: cpumap: switch to napi_skb_cache_get_bulk()"

(13 patches total: 6 for netdev_feature_t and 7 for the cpumap)

and test with your usecases. Would be nice to see some real world
results, not my synthetic tests :D

> --Jesper

[0]
https://github.com/alobakin/linux/compare/idpf-libie-new~52...idpf-libie-new/

Thanks,
Olek

