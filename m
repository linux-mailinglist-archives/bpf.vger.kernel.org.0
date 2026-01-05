Return-Path: <bpf+bounces-77845-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A79ECF4809
	for <lists+bpf@lfdr.de>; Mon, 05 Jan 2026 16:48:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7C9953030223
	for <lists+bpf@lfdr.de>; Mon,  5 Jan 2026 15:48:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53F683446CF;
	Mon,  5 Jan 2026 15:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TNG9ST42"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B4193446B7;
	Mon,  5 Jan 2026 15:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767628090; cv=fail; b=K/fmOAubKDrg7daH+QA+gJgwMTV2Uckpk3UDl1OSySGjytOMIYl77fObmyt2V/lI1k+/lWlvbfsQ0LJQDHyO3MOfDc+GZXzIia+RA0t8DZI6LNOXp5Qi1mVe3bUzF0hU+bdhNeZLt4TYh7G17qtma2OaQEgwTq3ptxKaUu7MG1E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767628090; c=relaxed/simple;
	bh=0oD2/pxa5pDGQH+Yvj6uTNCkkYD+GCo8bsdig/g51Kw=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=W7ae9mT1a951BVD9yqxigL1PYtdQ0o7vpiCtTBtuCV/qJEHIaYHRkjhZcClzFM+7Tk1xpqtYTdWYJ6mzAh7ugZGeVEyoDtvDFZZ5HwYz6ND/MMFNVibb6vgdxxIkxp9Kjwq1cEvOSgLNJOgEoXlGRXymvJ5MJQGoD0p0KrDEUnY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TNG9ST42; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1767628089; x=1799164089;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=0oD2/pxa5pDGQH+Yvj6uTNCkkYD+GCo8bsdig/g51Kw=;
  b=TNG9ST42PaxgeV3NUyRgjpX7WbD+BBdYl2ezVjFvTYCUC88xWrHZoqyz
   4aNz6R/SMDMdnEWtZtekqtD1yaxQI+M9S4PmjHtd8rQfHdpHkUpvUEgRb
   +q9X+qdxeUCrXyiQcHi4p3bnyTpd355bzq8rpFIffOp2pXoGNeX2tB/2X
   KD+l//j8/L+XmzCk32QwZ56zix8XFr1VhN1zds0XLf5N4ZxmASvY2s+of
   LSoPYlSFAT2axuQxClmWeZ9qvISh93P+oD7nqeOkWet+K++yvpNtiDCAn
   WU9cRj8JBWLUrWvoN5do/nukMOQGCg+tbki64M42vzU1NH5v3jSZUax5M
   g==;
X-CSE-ConnectionGUID: EnRLvQO6RqSoaC/Z+gv48g==
X-CSE-MsgGUID: TZYVIrT2TGq5x6Y5zYyokQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11662"; a="68005494"
X-IronPort-AV: E=Sophos;i="6.21,203,1763452800"; 
   d="scan'208";a="68005494"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2026 07:48:09 -0800
X-CSE-ConnectionGUID: L6pvG9EDQUikCbts7hVGHA==
X-CSE-MsgGUID: KcSaS7OKTo6f9g8BoWGV5Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,203,1763452800"; 
   d="scan'208";a="225959958"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2026 07:48:08 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Mon, 5 Jan 2026 07:48:08 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Mon, 5 Jan 2026 07:48:08 -0800
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.6) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Mon, 5 Jan 2026 07:48:08 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v9gOgF+vd2sehGIpsmeP3ciNmk/olPk+f7ay4QqxMBcIOxQqwE9/+okfACwU4WABLu8yT6PIAvWGcL+mRgYlalEAiMOGUSxeuXE3PQW0YSDY/LdNP+iksSHiWSwfiFFUidENyZuxS5uxD9dODZQBVlIzd6I3AUfW3nfDoy4WprvHQUJa9x69wuMEBMToIdWz7L37PHwqclQfP9GECeAn4h2zWlUahIjLxmvL6KIVanBnJw2R/gbd4F427vBSLk6OS1iyKHK4hRU3Uir/l5vKAmWJthA4PEGJ6rVa+yDcTWiP1/3lAi7mYTYBRWfsD3Ku8lX+JDnVAUGN1PCqfJh1rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DcTR9+7JWye2GTPjqcEl1zX0QN+tT/AID8igiDgQDGE=;
 b=awQsIfeXJ0ia0eO1THpJ43e/DESVrYIFraWUM3FZqRuxM2vFaHoHhyF0NX3ujqlOFai+dDdjxfTppVty0DxWDWsE1450AXo9ss1wtpFFLGigb234WIFtnK/OdnkXt5+o8mhQJFZQb9BRlDIW3FxLh8D6UHuf/+jFsJleZ1PDsHQarjqNK4lI+u3fmOSO752moac/8RdzN0iW3fzm2q5kzHArc9/fvU/LzFxIN5rpzwuFFkX5iOZBZs/ICMLkF0Es/wFohmC4dccZdAby27MG+kF0jycel0i/GOgMjnqTa+pWXJq3lMftLfk6hXLrysKPQGgWvx8F9tFKFEGdNou8qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by SN7PR11MB7091.namprd11.prod.outlook.com (2603:10b6:806:29a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Mon, 5 Jan
 2026 15:48:01 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808%4]) with mapi id 15.20.9478.004; Mon, 5 Jan 2026
 15:48:01 +0000
Message-ID: <1c8c6856-fbf4-4060-b81c-9bf867009ea7@intel.com>
Date: Mon, 5 Jan 2026 16:45:09 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-next v4] idpf: export RX hardware timestamping
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
References: <20251223194649.3050648-1-almasrymina@google.com>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <20251223194649.3050648-1-almasrymina@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TLZP290CA0011.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:9::19) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|SN7PR11MB7091:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d4265aa-d561-4491-261e-08de4c71ce53
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?azFBc3o1bjZ2QW9rWFE5UWtZYnhQcTRUbDVTV01OVjhxSmcvc3gzNGZYYzhj?=
 =?utf-8?B?VDA1NTMvVzZtQmlzMmxRdXR4Z0VHYjhXL04raTRtZEphZUNSZGhPZVJPM0o2?=
 =?utf-8?B?M091Rmt1SVJmOWJSZElUNVRJbE1YYUtYMEJqNytvYkF5SFg3YXN6OGYxdE9z?=
 =?utf-8?B?Q1d1QVFlZGMvMGsraTNuYk9vVUk2ZFUvTllwNi90T3pxaWdnN0lYenQwcDJw?=
 =?utf-8?B?Z3NDMjJwQlJQY1J0UDNWdFJzMTdibUNZZzVLaGpHcWE3VWhFRHFHWmcycXh1?=
 =?utf-8?B?VDVhamJySllXV29BM0FEeE0xUGlMR0NXakhpZndRdjl5ZTFlOWY0clJBQmhD?=
 =?utf-8?B?R1pVWnNLblhTSmxQRkp2N3dsbzAwSUl3KzZOYU15M1h5ei9VcEpya2x4MWJD?=
 =?utf-8?B?QVhZSkdXb3hYZURHSklVdU9FVVdWSUxtcWt6VnZCUW9JSU0xQUd5RnBIMkRr?=
 =?utf-8?B?VG1RTWN5WUlUWHVCcnE1S3dMWDhoaWpqemRSV1hXdGFQVkQwVlpVUE81UWUy?=
 =?utf-8?B?MzI0ZzRHUFVWcis5bEZMUDMyQ0xxNUlJTW1uOTR0K1FXbEc3azhqZVkwSW5p?=
 =?utf-8?B?bHREemc3aTdOQzdyNDdRWm5iNFAxZ1Rsd1d1UE8rZlRlR1hNNkl0NFBpK2hC?=
 =?utf-8?B?dEdXdHkxRUlEMlRySzd1aVV6QXFNb1A2YnUwYkNRQitvbWpMdTF4ZU0zaHNl?=
 =?utf-8?B?MENPWHZPaDB5cXlPeUJ4S2lrT0xBZTVWZDAybXNTL1ZHVW5keUVNSThha3l0?=
 =?utf-8?B?WGdLMXZMdWVVWlQzZ0xpZFVsZjMxZkord3dTTWFtKzNta3kzUnRFV2VpUi84?=
 =?utf-8?B?TWdRUkVEdHM5eHE5bElkYVNROXpkaVhrMHNMZ3NrS05sRWdObDVRakhFbzNt?=
 =?utf-8?B?bWJZQjMyYndHckh2MjUzK1g5a2ZkS1psS0hXZ1h4VWhTci9FSUUwRmtka1JI?=
 =?utf-8?B?NjhZWnZXbU9rUjMzelovaTJDb0xIaGpWNFJaTGEzQWFzOGtyZTNYVzB3ZHNC?=
 =?utf-8?B?a3hxQWpnQnVZMExtMFY2THlyY1IrNjRtUUx0T1ZuZGhlVWpDdlhueGFldHhI?=
 =?utf-8?B?UEhIZU5WVlQ3RVVHeFBCOEU1c1pyN3Q5L1o1WG4zQXlKbGJiYzZ3cG1Ga3V2?=
 =?utf-8?B?c3JQeUk0SUZkWlY1NEZIU2F1aFdIR0tuQkhCY3RCbnN3ck5OaW04Q0t1NmVr?=
 =?utf-8?B?ZlltOEZlaU9yaDFpUUhHMEhwUzVZN25KQmovakRqK2NDbzcyRitheFNPanpW?=
 =?utf-8?B?cnhyZ0gzYVhqaG5UemZKRVBKYmgwOVpFL0ZCcEMrUFdXbnpLZW5rNlZPSitw?=
 =?utf-8?B?bVZsRkJ5blR3czRHR3dZQ1V1cE1sR3NmTXBtQzBOMUlucHdBRmFDZ0VXWmho?=
 =?utf-8?B?SkdGd1hsVkZhUVhqVFlOS2dFOUlCeHpKNGZRNGQxSXh2OElMRzhyRkVGaUhQ?=
 =?utf-8?B?eHBkUzFYUllXWDY4cVpPbm5QNUNabE5sTElkTGt1U1FyRXM3bVM0c1BZSjFO?=
 =?utf-8?B?cW10M1RtZzlSbVg2Qkx1Y2d6dDZ1MnIvTXp1b0N4NHlIV3dMSExJUWNpVUlQ?=
 =?utf-8?B?amFOTEp3VmpBTytNdS9RUXVSY1I5VS9FNzE2QnUzSGxNYWxMWkdlT01hZ2cy?=
 =?utf-8?B?a3lwSmwvdUhKNXFxRkl2dTRoVW8zMEIxaUlIb29yWEduM1VJbmE0MUJNUytK?=
 =?utf-8?B?cW91VmNMK3dkMlY0cElpUEpZYm9MRmF0ZTVSMVh2RmRPQ0pZejk5b2YzNnY3?=
 =?utf-8?B?akcvcVNOYjVqZmdEYUVHWkFpQytZc3BwMEZIazNEdTJPbk9QcHBGL0FFSy9o?=
 =?utf-8?B?VGFCeWw4Tm9FMmU0MDM4MzFqeHE0WXVvV21rNXVYazkrcFNQcDFQMDFCQnlJ?=
 =?utf-8?B?TXlDV1UrblIySm1FRHpNRHVCT0kvSkJ1SEk3Z3JMWnNYWkhJaE1xOVZmRWFU?=
 =?utf-8?Q?ogslwKb31CBhgerzcCCZn6RT5ugW3MBH?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NU5MTWhENHZ6UndOaEFmTWcrU2Z2TlhKbjkzTkhBUnVwWTBQeTVWdFIwRHdT?=
 =?utf-8?B?UDJVZXAzc0c5Rnd0OUNnVDYxM3VuSk9xbkRaeFA4MVVyVy9VVFh0eDVBNVhn?=
 =?utf-8?B?YjN2blkwZDFWUWl4OEl5KzlISElEVFVVcWFVMjJjcjl4UGR1T2R1TENXeGUx?=
 =?utf-8?B?YTJtVWFpbUdQVDhjeDdWY0grb1JtK21TOVJXN0lNTW1VQ3IrTVozektwZWU1?=
 =?utf-8?B?dWM5RWF6dGVGaC9IUEU3SVRza2xHWW00LzdUeWllM001WWxKcDJzMEwwdEs4?=
 =?utf-8?B?aUprbFJvSnNkNUk1ZVFjT2VUSnJDRXdkR1lLcWs0bVRTU21tQ1M0aTJaQmF4?=
 =?utf-8?B?VStvMWtyNk8rZWNGZGE3Q2ZIVGgzWGVBSTdZK0RzY2tvOHlFeFp5WTYvcW5r?=
 =?utf-8?B?RW5mMFIyc1AyOEdpU1FpTElSN3BFV2dpam13V3FOenQ0YXZ1My8rTVFaRXlj?=
 =?utf-8?B?TFBjNG00bGxNYy9xTVBjM01GYjQzUWNvMWRTY0x2cUdDMWdwNmRZSVhqQkNi?=
 =?utf-8?B?UGdZWXhybVVZRlR0YXpUUEVRSXV2MWxkbFVRRWtRNXpFakRIeFhJMU4rRG9p?=
 =?utf-8?B?NkZhY3hWWEFGN3Rrb3ROS2dIRWxVUjVmNnp5MVFsZ3M0ZFZEZFdSV3lWNDhL?=
 =?utf-8?B?bkVBVmNIcHp6czkvK3FLR2k0VjM4VUZsaTRyKzNuK0R5aWRkK0FiUElnb1da?=
 =?utf-8?B?OVNHUTlzWnczVlM2NjFMdUNMWU9GVjhrenQ4ZC9QWnBwSk9qMElucmdGWXdp?=
 =?utf-8?B?NVlOcm5NUUtnS0RhY1FrM3NQeHJwcG12T3ZJemViZEJja2dDUFBrTHQ2eC9Q?=
 =?utf-8?B?SGRNdVlnVjlQaktuYlhHcStYMFFheXVDUUlPeHN2RWVkcmFTR1lraVh3cmRq?=
 =?utf-8?B?MG5GbTZvZk1qQUtYdXBIMmhpWFNrZldNVFluWXloc3lNSHFjYjFVUlN4bmRR?=
 =?utf-8?B?eVBiZW5MRHd0OVVLdFh3aUVIbFluaXhLUitiYlhUSEg3Mkx6ck0rTGhFMUVG?=
 =?utf-8?B?V1V6R3h2dDlTMGpVTjdJQUVjZ29YL0k5eHR1NVk3Uk9yeWFDSnNKRWJ6U3hh?=
 =?utf-8?B?UVdEY2tpTmNzNzBXTW9XOGw2OWJ4dkIrS2xrdnROeFhkZjJNUVRuaFVsYU9Z?=
 =?utf-8?B?WHRDUVpQTzNpQnpWLzBIbU1XRC8vS3E0SWhiakVqa204MGx3eVNzdUY2UWNK?=
 =?utf-8?B?OFhZeGV1dUplVHBqUFdtK0Z0Q3BCSFVnNktZaC9jeHhIR0tmc0thWTdGckRx?=
 =?utf-8?B?aFVER2VXQUREMEpoVmV1MkVHbHhtWWJ5b1d1OVZOZEhZWjhCelQzMjk0ZGRv?=
 =?utf-8?B?S004SG52eG8zelRCMXN1d3ZRWXA5dE5jUEFEMERFeVBQODYzY3dwWHFUbEZk?=
 =?utf-8?B?L2pNbWt1WW9KQ0twRHFsN2RNRkhQQjRCRWVyL0tZeU5rTmlLSzM4ZGZ4RVY0?=
 =?utf-8?B?R1NYUmRnSWZKRTR3ODBmbHNZTm0wRTNQZnR1UlNENzh3aGFvY2l5Z3RNMjJE?=
 =?utf-8?B?Y1NOZHdYcmFwT1hpdXZVblQxcm9hc0lyTHAxUkVZN280MFhMVTFtZm5CL2s1?=
 =?utf-8?B?eTlVVlBpVklVNDhGNzloaTErS1J0am1lenM4OG42QU4xMlBFbnhrUERVdFRr?=
 =?utf-8?B?UElHSTlNRGo3R3Y1S2puOWV3bkwzb01YQ0FFSjBoTXhLMkVqMXBLVWZlMnRH?=
 =?utf-8?B?bTRqdCtJY0QvNzQrZDVJV1lsRXpHVW5FVHVSN05lYlVnWlVSd2JNNHZiVkk1?=
 =?utf-8?B?MzZNdzVKWDJtcE80dnNJbTRIMko0eUtyV3E4UTRUeEZzbFpoOUxKK2llenZG?=
 =?utf-8?B?N3JaOU5PUityYjA4czRzUGpNOU5SbHFmcVVZTjloSWNJajVKdXl2dVViazdZ?=
 =?utf-8?B?Mnhlc1BaMS83OWVzR1ZNUWgrR3VYTGNzRVc2VG4xOXpjU2VlOTNnNUpxbS9q?=
 =?utf-8?B?TVgyNVJyN01OTllxTU5FNWQzWDUzdmdWbG5tZEl5eHYvQVFnVkhxWTZHN3M5?=
 =?utf-8?B?RlNwQnVkL0Z5b2lQOXRDNkpyNUJ0Sm1WOUlXdi9vSnpMQXVqOGhEeENHYnB2?=
 =?utf-8?B?MHdkT0FZZm53MXhNWWZ1UHJzL3psejIwQjJjNENvbkwySEZhMHV3TXVzWCtW?=
 =?utf-8?B?NFRoQU5maCtXSm1FcjRXcFhZZGZFSHpYWWVTRTdoR1FWRlYzRnFOY3BCNWNW?=
 =?utf-8?B?NzNqUWZVMFRkc1IwWTJHRGNuUVp5QlVWR0c2eDdzZ1FqZDdSeGVMYmkyd0dB?=
 =?utf-8?B?Zk1Ockd1RFVTbU15bHRzRC9sdmI1K1JjRStKVTJ1YzhPUjFiR0ZuazFhNkJz?=
 =?utf-8?B?dHFvSGRwU0pWdmNJR0RpVWtKczUweVcxcGYwbXQ2ZktqVURoY0QzNFFCMU85?=
 =?utf-8?Q?rDV0uNKlo8DWoy3s=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d4265aa-d561-4491-261e-08de4c71ce53
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2026 15:48:01.2400
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QSZOM/18XR1WSY+3K7nqmCpCpoBSqdxSvI5RfoVjQXDJz06ZTS2exXx0BQJ8Me30GEm5LRPlIsV/roJa12S/OFcdITgWdR91U6MdvXFwAuM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7091
X-OriginatorOrg: intel.com

From: Mina Almasry <almasrymina@google.com>
Date: Tue, 23 Dec 2025 19:46:46 +0000

> From: YiFei Zhu <zhuyifei@google.com>
> 
> The logic is similar to idpf_rx_hwtstamp, but the data is exported
> as a BPF kfunc instead of appended to an skb to support grabbing
> timestamps in xsk packets.
> 
> A idpf_queue_has(PTP, rxq) condition is added to check the queue
> supports PTP similar to idpf_rx_process_skb_fields.
> 
> Tested using an xsk connection and checking xdp timestamps are
> retreivable in received packets.
> 
> Cc: intel-wired-lan@lists.osuosl.org
> Signed-off-by: YiFei Zhu <zhuyifei@google.com>
> Signed-off-by: Mina Almasry <almasrymina@google.com>
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

Reviewed-by: Alexander Lobakin <aleksander.lobakin@intel.com>

Thanks,
Olek

