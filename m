Return-Path: <bpf+bounces-71974-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 237E5C03FBB
	for <lists+bpf@lfdr.de>; Fri, 24 Oct 2025 02:57:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 283F635404E
	for <lists+bpf@lfdr.de>; Fri, 24 Oct 2025 00:57:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83BD81991C9;
	Fri, 24 Oct 2025 00:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lxAzt+BM"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFC391514DC;
	Fri, 24 Oct 2025 00:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761267429; cv=fail; b=nVvOXeLfWgo/D7+pJWeAxmEIdnQrVCnN8ssVzEToAjVE6sCxUxVJ8j6f+4gsi7M+3Fc/U+NrLFM8kYcXarpDId1uPvJkO7F1tdI2wcqxAXWSicRlAO2Pjb0YecARUsiwlr+dpyUag2XHc54oYi/ljcUcCB9DvEyuwX2bzG/Cebc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761267429; c=relaxed/simple;
	bh=FdoVHGIkAcYZuJ/mRiQchegDVcqibYl2CM2b/T45Jws=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=lLN8DEqprC2LHgIPkVD4M1p4fURcTyu/16n2BDiqVfyUVTio3U8cYztBzSpIJ92MAtz2B6qmmW7YiuJZaAlvKDibdSNXiHFBdXwXKXaAnng+nrZllQMTfF6zMjmfBeDzLMseRq9GaDcAUyTRRULqhHTjmybEWTXlye/0RTsaFgc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lxAzt+BM; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761267428; x=1792803428;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:mime-version;
  bh=FdoVHGIkAcYZuJ/mRiQchegDVcqibYl2CM2b/T45Jws=;
  b=lxAzt+BMhklfUJj9Y2MBGWonz3pzGwj7WwiEemeusV3aHPkFV+MBLR6y
   TD5cbAoqVFCAmBhflndB3zUaqq27K3EhmDQy3zJRpgfPz6//uTMgGFPuG
   mH/S0klsdupkzaytCRVHRdwmnTxMNuT8VJ8anEBbs+blVKOid4ja6YgNW
   X86oRfwj6YkQ4eniSbhUDT9PAt/v+6+6018FckC4NTJKME78qx9L1Az6t
   yo0DcQVl5Fe3ZzfsJ/qXJZ9kPdW3x89SkkeP3K7oQvNWyCr29VmVMvXUi
   yxrh8PqODwlgysSwXfl5XmZ+v3WoGHMwQrjlo4PfmD5QfCefD50v8Fed/
   Q==;
X-CSE-ConnectionGUID: 96pTLfywSEa86ma7Mu43+Q==
X-CSE-MsgGUID: hTvzLhw6SUKncnLwhOHjZg==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="63489178"
X-IronPort-AV: E=Sophos;i="6.19,251,1754982000"; 
   d="asc'?scan'208";a="63489178"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2025 17:57:04 -0700
X-CSE-ConnectionGUID: WmZkMI8uSvSaBSZBNH1aLw==
X-CSE-MsgGUID: pNfERtFjRqySWuGlqUNfeg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,251,1754982000"; 
   d="asc'?scan'208";a="215225655"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2025 17:57:04 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 23 Oct 2025 17:57:03 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Thu, 23 Oct 2025 17:57:03 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.31)
 by edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 23 Oct 2025 17:57:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EyHydH5OkOgUZkaokLFltfGFzSO07qCuOSiJ2pCSru8eHxOdDcToyGHOegnqwq1YGE1TzvAmUBCja3DukQlXjdBKYvQop7Kvm9MJt7sXqcSOyTW4eLZM01b5StDaQeJ/ulYPpZcaT1zd6xaKVnMJ7PEBWo9prioAK1CyniQX5izxwNl2SMZwX5hUMy6kXKix09Axc8LPi4qRWyEunsV5+PT8D5d8BU+9PDEmAvg3Lsh4hBtb/H4StIzUWGh5zJYi1gbDjaNwlO6+FecEywMhj7qSR9hk+f96f+5iFsu0xTuVXucJN6zF5+/MkCa9BbZLfKwWL1VcMJbPcFg99Jgktw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FdoVHGIkAcYZuJ/mRiQchegDVcqibYl2CM2b/T45Jws=;
 b=TIzjKZpcJVSob2nihlGqzJlxis5//w3mAgLwKKiEW/3oPHCggFtViYmD3KCg0wQxidPbVWRDWdEgKBTioCFj8dQcnCntGa/GRBLAJLn5RkGRDeWhHX9OUkcmD0qSXkWSWz/jd1smffncS6YGmi2oC0Fdwm7EAa96vJ7MtZtThXNYNJFrwPhvsHXN4A3RX6ltXlx1vKXpMglcITNMPbJq0Bw6BeaZZmtZbLpYEaJ0bdI5g76484uNuH2QjZkYKK8zHDtyAQbmHQfzecoRVFybNBNQFo1w97gw3rMjYYJSVLyoR7rqKpQFmRscjx4DTNJ0vQebFELvnQhUYM9VLb+RJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by BL4PR11MB8800.namprd11.prod.outlook.com (2603:10b6:208:5a7::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Fri, 24 Oct
 2025 00:57:01 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3%3]) with mapi id 15.20.9253.011; Fri, 24 Oct 2025
 00:57:01 +0000
Message-ID: <def1cb92-c0cd-440f-933a-55a5be71251b@intel.com>
Date: Thu, 23 Oct 2025 17:56:58 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 0/6] Add AF_XDP zero copy support
To: Meghana Malladi <m-malladi@ti.com>, <horms@kernel.org>,
	<namcao@linutronix.de>, <vadim.fedorenko@linux.dev>,
	<christian.koenig@amd.com>, <sumit.semwal@linaro.org>, <sdf@fomichev.me>,
	<john.fastabend@gmail.com>, <hawk@kernel.org>, <daniel@iogearbox.net>,
	<ast@kernel.org>, <pabeni@redhat.com>, <kuba@kernel.org>,
	<edumazet@google.com>, <davem@davemloft.net>, <andrew+netdev@lunn.ch>
CC: <linaro-mm-sig@lists.linaro.org>, <dri-devel@lists.freedesktop.org>,
	<linux-media@vger.kernel.org>, <bpf@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <srk@ti.com>, Vignesh Raghavendra
	<vigneshr@ti.com>, Roger Quadros <rogerq@kernel.org>, <danishanwar@ti.com>
References: <20251023093927.1878411-1-m-malladi@ti.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
Autocrypt: addr=jacob.e.keller@intel.com; keydata=
 xjMEaFx9ShYJKwYBBAHaRw8BAQdAE+TQsi9s60VNWijGeBIKU6hsXLwMt/JY9ni1wnsVd7nN
 J0phY29iIEtlbGxlciA8amFjb2IuZS5rZWxsZXJAaW50ZWwuY29tPsKTBBMWCgA7FiEEIEBU
 qdczkFYq7EMeapZdPm8PKOgFAmhcfUoCGwMFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AA
 CgkQapZdPm8PKOiZAAEA4UV0uM2PhFAw+tlK81gP+fgRqBVYlhmMyroXadv0lH4BAIf4jLxI
 UPEL4+zzp4ekaw8IyFz+mRMUBaS2l+cpoBUBzjgEaFx9ShIKKwYBBAGXVQEFAQEHQF386lYe
 MPZBiQHGXwjbBWS5OMBems5rgajcBMKc4W4aAwEIB8J4BBgWCgAgFiEEIEBUqdczkFYq7EMe
 apZdPm8PKOgFAmhcfUoCGwwACgkQapZdPm8PKOjbUQD+MsPBANqBUiNt+7w0dC73R6UcQzbg
 cFx4Yvms6cJjeD4BAKf193xbq7W3T7r9BdfTw6HRFYDiHXgkyoc/2Q4/T+8H
In-Reply-To: <20251023093927.1878411-1-m-malladi@ti.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="------------UbVYYvkAH96igME0OzfUYtsy"
X-ClientProxiedBy: MW4PR04CA0126.namprd04.prod.outlook.com
 (2603:10b6:303:84::11) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|BL4PR11MB8800:EE_
X-MS-Office365-Filtering-Correlation-Id: 837b58eb-1ecb-47ad-d217-08de12983d36
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016|921020;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VytjclRjdFEyNVV4eVR5aFZvZU1tWENGbEZkOWJ0d0M4ZVNXTFlFNmk3Zmw1?=
 =?utf-8?B?YjZQTU1vRkZpZUZlU0YyMzhPdHBHTVVQcHlWWkx6ek5VMjlpc3JKTHd5d1dy?=
 =?utf-8?B?dDVHWE03TFRlL2ptUFRUL2lQTFN6YmFpVHhVRXFWVkJvWUFtVnZmTHRUZG1m?=
 =?utf-8?B?bUNBK2VDN29SRTVhMWhZOTdtTVdJK0VEVXFGY3UvMmNreGNLK2hyMkF2K05u?=
 =?utf-8?B?U0NmdW96VC94MCtoNkt6cWNZWnY5QjZyRTFYTkhkd2RmelBBdFRxSlduQVdp?=
 =?utf-8?B?TlhraE9pa1V1QTdxZlRRcVkvNU1Ec09yODBHaHBOenBZSHlCbGJjaTVuNjB0?=
 =?utf-8?B?M1RyUGFhalpWTi8wNjltYjZISXc3VVd3VVhHMnl0WE5RdWhUWXFhcTJFWkt6?=
 =?utf-8?B?NFZ1WDN6VGRHV1FOMlVvQXFkOFRISmpvQXUwSm11REt0OFlmdHRGaEZhU2Mw?=
 =?utf-8?B?d0RPSkRQSEZQcVhGak4zWW1TL0JXY1NUcERrMXcwNjEyN2xnN0tVSUNoMUZa?=
 =?utf-8?B?ZXQyMmE3ZFVURkhEZnM3Y0ZNMDA4U0xmbVNSNU1XbTg1bjl4NWJRRk1ueExq?=
 =?utf-8?B?bjJuNWFtUW8xeHV2WDlGQXY0K2Z0T29TYXpZUU9SazVwVXZIVGJyY2djMDNT?=
 =?utf-8?B?NGdHSVZPa0ZvUWhTemxVMU5laU1sMEFUNWRnaTUxNk9oVjBmRUVrV3lpYUVP?=
 =?utf-8?B?VThsVWNtVGdDRFF5QXlEVEpkSXpzZTh4SDVoUkFyMk12WCs3ekl4eE5lc2hV?=
 =?utf-8?B?cm9XTG5QcitqaC9jS1JyWHNpKzh4RnFwOE9oZ0w1NmhXS0tNRjBZK0hKVE1s?=
 =?utf-8?B?QWRoalFhUGRXeUxVSU9wZkRNcHVPQ3BiTTBOM1pmR1JTUUtSTGZsbXlrdWh5?=
 =?utf-8?B?WWZhbEtKNHlLQXIrTitibFRYa0E3bTNIUGg4ZXFweFJ0ZU1xR2NrL0Rtdk10?=
 =?utf-8?B?bTRqUnVoZUJJWmNKUUhhTXI5WE5lT3B2V3g2SWhhNEtCUFdLL1lPdytmV3Ur?=
 =?utf-8?B?Ky9qaWE5K3FydE9XOGVUbkZxT2NSV2d6MDVDQWhoMUt1SktOenpYWThGaWs0?=
 =?utf-8?B?NGVCNFZ6R0IxQldRb0tIU0psVW03aW9LQzBST0xCbWlaOGlZeExKTnFFd25o?=
 =?utf-8?B?NzE2aTdLWEg4Mjh0aTJ5VkpBL0IxOW5LMVFuVjRLckNhVWRUd1Y5MzlPVFNu?=
 =?utf-8?B?S24vUUxhZjIrRnBwTzM3dUdjczZqUy9zSDlMZkVvbHBUQjFxa2U1TEdtMk9I?=
 =?utf-8?B?RENFbFdXV0Mxc1NpZEZqSWI4anp4alZLYUFNanFPUUV1c2h0SG1oaTVVL0tH?=
 =?utf-8?B?MFp5MTRhMVU4R2VOZlVPaHN4RFRlalpKWUQ1LytaVGw0aVpPMEsvenpFaCt6?=
 =?utf-8?B?R3o4eldwQVhWRm5vOVQ0L1hMbHRHZU1yRmR2MlkvZ1AxSU1FSk9kT2N3NlRW?=
 =?utf-8?B?ZDAwTnJGV2FsbGF2SlRZQ2RDTHdKaWlWRXlRVnFzSllxVVpLanJtSHVXK0Q0?=
 =?utf-8?B?M0tvcW9HZStvMkdrdHVjVytzNHJndHE5WFNKK29kR25WOE9ZZ0N0NXhlcytH?=
 =?utf-8?B?VDBiaUI1WmRrQ3YyZ3B3YlVMUWkxUC9PT1dOc05BRi8vdURBZEptWWFFL3h4?=
 =?utf-8?B?Y2dEaWFNVWc0bmpxTlFaY3ZLMm9oQW1aSng0STN2blREN3o2b3Z1b2FVNDZC?=
 =?utf-8?B?RnA1WTV2dzU1WDFHSU9IckMyODE0QURydS9BWHhnMlRFV3AxSy8vYWhGK2hI?=
 =?utf-8?B?ODhId2JMQURxdUlsT1F4TjJXNmtiVTdMY3ZsS0dkMEdlT1l4OG4yeW0wOWdC?=
 =?utf-8?B?Vi9RdWRaajVOb09tV201VEpYNlZod3I3K3BPL0crNDczTUltNTVYTTRkTjlV?=
 =?utf-8?B?a21xZHdBdEdZSjI3NzVkT2p6U2ErQmMwNkU4d1g1aG5GR3p1V3h6RFZRQ1NF?=
 =?utf-8?B?clBBMHBmcDYxa1JRbHNKdFgwMUVlZndnQ2lENGdTRlNRbkNocTkzbmZKdGE1?=
 =?utf-8?Q?3YRPqYJcUS9k/k7Q2FzrUq4j8IYHrU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V3h5dWJpR2V6Q0ZNZHB3MzFYMktzQ3ZUcHBPRW4raUZzdlhHTDdlNFU3c21w?=
 =?utf-8?B?c3hFaDY4QjlCMjl4dXhIZ2RDV1RDaXpzMnk0OThZVDEvQzhpdDFVZE9Yalhu?=
 =?utf-8?B?Z3E1MWtHdDBYYU1LUStlRnB2ZHJZVlczTHlxTVNUYUJ4eUNLTFN3cWFQd0JR?=
 =?utf-8?B?NUp6VytWK1c1ZEFET1VnRno0WTVseHMwMmNPMG1wVi9ZK2NWTlc1MklFVzdh?=
 =?utf-8?B?Wm8wK0JPMmpqQ2NlUGdjcUFza1E0aVdlMkhXMDBIeUIzNGdLQStDTDVXNVdZ?=
 =?utf-8?B?YlZwODd1bTFVUWtmUXE2ZUUxemFxUThQOUNLVEVsVG1JTnB1aS96UURmUnFy?=
 =?utf-8?B?Qmh6RmZEdFJEWFN4SXhVSVhac2FmZlN0S1E1QkkwZXkyRWNTRVNGOU43Q0pm?=
 =?utf-8?B?dVUxZDRRS2ozaTlRQ2VVejJ0dTN5ZGRiRXcwY012N0NQdjR3bTh3S0F0b2Qr?=
 =?utf-8?B?RGJIYVJSNFN3VEZEcUxadm1kYzNyenBiRXNMSmVLWXJaQ0VRZXU3MUNPWm8z?=
 =?utf-8?B?OGNaVm5uVEo0RWpIYS81allLN0hVdjRPTXpwT0w0M01UaGpXT1ZUK21hb2tn?=
 =?utf-8?B?SHQ1UWxWam1ZRDJQK1E3eXpOQVB1VWViNVh0MG1sOGNZYWF6VVRUNjlKR29h?=
 =?utf-8?B?R1d6S1lSVnJqV2ZrN1FJTjVNdlVnSDVWaGwzdWpMdHVTSUIzc3N1MHE5Q0FD?=
 =?utf-8?B?RUl4dS9SMTJpQStnaHAzVllIa0VTZUZsdEF3ZSsyQ0hBaEUvTnNCSnVBSUpU?=
 =?utf-8?B?d1NuWTZJV21mR3N2S0FTNHJZVEhjVHl3M0hvdDVMTS9WOHhjSzQ3YWdYVmpW?=
 =?utf-8?B?TjhDNnBTYWdoREdlY0JMdGRkRjZMaFZVY3dlTG1MaE1aUlQzQ0tyMkJramly?=
 =?utf-8?B?d3p4SUs3ejJudklISGZIeGkzaUpiZXhYbGEvV0FqcEZKOXhnQzhwVlZ5bzRx?=
 =?utf-8?B?UDJlM2RTVHhBUXNqL0t3bndjRVA0OVNDUVZwZjZ5Y0tlc2xRWVgrUkdGeHBW?=
 =?utf-8?B?K3llMkNPekFXZTBIL0dOeHptR2dsUDd5NVNsSWM3clhtR0g1Tjdsd3hhVG1m?=
 =?utf-8?B?UWJjbCtVaTBjVDhya2M2bmpma1krQ3pxR0Nzc1dzc3B2WGgvbm9VYklBVHIz?=
 =?utf-8?B?TXNNNUthTE9VSjRnVlpMUTR0SWg0Y1BsZXE0a3dvb1g5dEhmSm5hdGJMT3pl?=
 =?utf-8?B?bE9obVZ0Y0Q0dko0WWlzYUpsRDUzS2gxYTN0MHAwZzdRdEFPYVp6a0Q1WVNr?=
 =?utf-8?B?eEpEcWxwcGNPMkp3RDJOTWJLczZyKzcvamNwRGo2Q0ZHMHJxRmJGWFFGaWVp?=
 =?utf-8?B?dG9QeVRyQ0Y2eHhjd0FXSkhzSUxiZFM5K3IxZUJvUHcrd2ZlU0tTMUpwSWVx?=
 =?utf-8?B?bEZMeFdTeXErSWFab0c1cC8rRlkwWWU3YTUxMTkwdmhaTGY0d1d0VjNaUkUz?=
 =?utf-8?B?eS95VDFQcWJvOEQrWUdOYjdiVXNSd0p5bkFjTXd1RlNLeWNPbzZ1VUtueUU5?=
 =?utf-8?B?R0krZGxxMUJFTWJmRUhSV1VtalVoRVZ6NmQ4aTAxRVM5TTJhOStsQ05VTlJW?=
 =?utf-8?B?dDBwQXg5ZWI4K25GWnpyRE5PYXkyNlVUTFBRVUM5MnZvTlZVM1F0Wmg1ajIw?=
 =?utf-8?B?Y0ozWnlyTlR1dVpOTlVFNnk1QUpjbmNnOGlac0VRNnVoaklyRG1mZWo0R0xq?=
 =?utf-8?B?SWlYSmlUUkJOREpod1hWM2J6V09wS2VGTUgxVThKeHIyaE1SaGN4bUVEZjNR?=
 =?utf-8?B?NkREWDA5N2dDb25uSDYvdTlPME8xbUlvU2FPTHBrbGFMRWppOHRMZ2N0Rkl5?=
 =?utf-8?B?VEdxV2orZVBYU2k5cHVRSFFITGZkVjNraEU0V2g4SVZYYlBtMjdBQXVIVXZS?=
 =?utf-8?B?MFdPTXRhZGFMeHN1OVRTbGw3Z2FHUU9TSVlOTytWSGRZREJDUXg3OHVUcjQr?=
 =?utf-8?B?Wklsd3hRTlVhR0RJUG1hZWhyTmVFdXdyT3ZDZE9rMlVGVjFuVTlFWWIzZVZU?=
 =?utf-8?B?b2cwYjdrQ1ZJZXJubGRPR21DckFuc0NOWTg0STlmT09XWEhVbG5uYVhOUnU2?=
 =?utf-8?B?OUZZRkQ0SG9OM3BtU1ZsaDRkRzJoQVFzQ2ZHeEFtQ1RSbDg5TE16dldYTDdR?=
 =?utf-8?B?MlVXenlsR25EOFRmRHRtYUVkNHc1OC95eisrYXIrQW01Z1FIeVBTQzRqeEI0?=
 =?utf-8?B?ckE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 837b58eb-1ecb-47ad-d217-08de12983d36
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2025 00:57:00.9576
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4X3264gsmh43kB6urLSnJUKfhXDzawNjL54aPmI/2ubbAMYcY6jIAEe5ZmuSwO0s+K8S7PuzDD4MCTwmxGayTnlPSh2ld8PMQ3jmT1q12Ck=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR11MB8800
X-OriginatorOrg: intel.com

--------------UbVYYvkAH96igME0OzfUYtsy
Content-Type: multipart/mixed; boundary="------------dOWzGw0FK0BvC99UUv0Al4I3";
 protected-headers="v1"
Message-ID: <def1cb92-c0cd-440f-933a-55a5be71251b@intel.com>
Date: Thu, 23 Oct 2025 17:56:58 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 0/6] Add AF_XDP zero copy support
To: Meghana Malladi <m-malladi@ti.com>, horms@kernel.org,
 namcao@linutronix.de, vadim.fedorenko@linux.dev, christian.koenig@amd.com,
 sumit.semwal@linaro.org, sdf@fomichev.me, john.fastabend@gmail.com,
 hawk@kernel.org, daniel@iogearbox.net, ast@kernel.org, pabeni@redhat.com,
 kuba@kernel.org, edumazet@google.com, davem@davemloft.net,
 andrew+netdev@lunn.ch
Cc: linaro-mm-sig@lists.linaro.org, dri-devel@lists.freedesktop.org,
 linux-media@vger.kernel.org, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, srk@ti.com,
 Vignesh Raghavendra <vigneshr@ti.com>, Roger Quadros <rogerq@kernel.org>,
 danishanwar@ti.com
References: <20251023093927.1878411-1-m-malladi@ti.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
Autocrypt: addr=jacob.e.keller@intel.com; keydata=
 xjMEaFx9ShYJKwYBBAHaRw8BAQdAE+TQsi9s60VNWijGeBIKU6hsXLwMt/JY9ni1wnsVd7nN
 J0phY29iIEtlbGxlciA8amFjb2IuZS5rZWxsZXJAaW50ZWwuY29tPsKTBBMWCgA7FiEEIEBU
 qdczkFYq7EMeapZdPm8PKOgFAmhcfUoCGwMFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AA
 CgkQapZdPm8PKOiZAAEA4UV0uM2PhFAw+tlK81gP+fgRqBVYlhmMyroXadv0lH4BAIf4jLxI
 UPEL4+zzp4ekaw8IyFz+mRMUBaS2l+cpoBUBzjgEaFx9ShIKKwYBBAGXVQEFAQEHQF386lYe
 MPZBiQHGXwjbBWS5OMBems5rgajcBMKc4W4aAwEIB8J4BBgWCgAgFiEEIEBUqdczkFYq7EMe
 apZdPm8PKOgFAmhcfUoCGwwACgkQapZdPm8PKOjbUQD+MsPBANqBUiNt+7w0dC73R6UcQzbg
 cFx4Yvms6cJjeD4BAKf193xbq7W3T7r9BdfTw6HRFYDiHXgkyoc/2Q4/T+8H
In-Reply-To: <20251023093927.1878411-1-m-malladi@ti.com>

--------------dOWzGw0FK0BvC99UUv0Al4I3
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable



On 10/23/2025 2:39 AM, Meghana Malladi wrote:
> This series adds AF_XDP zero coppy support to icssg driver.
>=20
> Tests were performed on AM64x-EVM with xdpsock application [1].
>=20
> A clear improvement is seen Transmit (txonly) and receive (rxdrop)
> for 64 byte packets. 1500 byte test seems to be limited by line
> rate (1G link) so no improvement seen there in packet rate
>=20
> Having some issue with l2fwd as the benchmarking numbers show 0
> for 64 byte packets after forwading first batch packets and I am
> currently looking into it.
>=20

Do you think this means there is an issue with the patches or your test
setup?

I didn't see anything stand out as a problem to me when reading the serie=
s:

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>


--------------dOWzGw0FK0BvC99UUv0Al4I3--

--------------UbVYYvkAH96igME0OzfUYtsy
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQQgQFSp1zOQVirsQx5qll0+bw8o6AUCaPrO2wUDAAAAAAAKCRBqll0+bw8o6Drr
AP9buHM8MtKLnXl8D2XpED5hSSLHqaqL+NKDNMXWI2IvmQEAwYtuFmhW7Wa7mB9dOKRy9pBkoBuF
kltE6Qpmw7i+zgI=
=ZBus
-----END PGP SIGNATURE-----

--------------UbVYYvkAH96igME0OzfUYtsy--

