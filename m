Return-Path: <bpf+bounces-70840-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2BB9BD6B23
	for <lists+bpf@lfdr.de>; Tue, 14 Oct 2025 01:07:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 371FD40544A
	for <lists+bpf@lfdr.de>; Mon, 13 Oct 2025 23:07:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D810C2FBE0B;
	Mon, 13 Oct 2025 23:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XJxrShpL"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F21C6220F38;
	Mon, 13 Oct 2025 23:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760396851; cv=fail; b=pZzEksOw9iFNUbtw83l0Hh/oJjE5JFZpMs/LcoawJwO/nZtgSZ0YS7tXRT7IeZky06Vkp+0e1ZLTkP/xplTNjFuXDZDNjRYVOVlkSmo1iWDrOhp/YShNkfNjuHLbjJNi/h0xgyYk2DwuglJIacQXFzt8bUKfUV6A04roLOdiL5Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760396851; c=relaxed/simple;
	bh=0Me1mp3YYyrvHwirxc+seOzfLneCnpRLD9cX8ZOL3aI=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=sxPfdSbBBk0Yxhsrk8nB4n6q/rAiqk5L/4hEuvnq10Jx+Wir1BRpd+f0GR2WuiT/dHibgMHW+JTufBiprH4T1gZpGVIHjl90L22OpI25K6OAVH+0BcD7CZDcvPrO+tTGE/mrKubrfaXa+aBe6/GvK4E8FMh59TIamByr/3Idx9g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XJxrShpL; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760396851; x=1791932851;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:mime-version;
  bh=0Me1mp3YYyrvHwirxc+seOzfLneCnpRLD9cX8ZOL3aI=;
  b=XJxrShpL2PiCvtAjHVDo1Icw3HuJF+mPEU1yQQFromtY+Hq2t2uwLSvc
   m8af6AvMWB8fVaSRR3A0u2OYuGtucWdjrOaTJvEGRcMRMy/FvD/v0EQe5
   mkM1C79QnLieDRM8VmgURSGtVtoDzaMufq3qocmZk2SRtg6K97z1wS5iU
   UZXKli+4zN4FSf5tFPZB342356gPYFc3QWrzSPJVbx3/b/Vt9R1LYaOMR
   NpkTxgyVC3V+Q+LcVHrs4xy8lJ6IWrbIi/wIjpOymM1hgWUUYvsD7Il0L
   U01vyV9QsKs1TEzTO3S3AE7Nu/TvfuFoxZC8T9VWd/rAsfkgJOxW0lRyu
   A==;
X-CSE-ConnectionGUID: 2orgXwEnRT+cxInZM/YkGQ==
X-CSE-MsgGUID: lOOuFRxRSY6hU8qclwaswA==
X-IronPort-AV: E=McAfee;i="6800,10657,11581"; a="62587294"
X-IronPort-AV: E=Sophos;i="6.19,226,1754982000"; 
   d="asc'?scan'208";a="62587294"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2025 16:07:29 -0700
X-CSE-ConnectionGUID: VkQ/FbnsQNmskpR++DgdxA==
X-CSE-MsgGUID: 5vtcAyQJS0ym/EP83C9NmA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,226,1754982000"; 
   d="asc'?scan'208";a="182179174"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2025 16:07:27 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 13 Oct 2025 16:07:26 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Mon, 13 Oct 2025 16:07:26 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.31) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 13 Oct 2025 16:07:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C7AWkE3e12hUZdgR17dVIFo1PWVZK7dCNHe5CSwpnFo5XJN5y8mb3ms9krqZt+SWLaPsWOK76qCcYbetJIAAkErAmsLbONU3vXcWiUMSwbGvCp4PwxSz9ef1iG7kCYCk55YtKxclKy4M793XVGJJ3jyYm/9NgQWYm1miP1mQlyFzo680YNCITRX5hVvxNLQORCpLIn+aHywAR+feLdxgeNxtyFvHy5RbVaUfTlkueteXDPjmRx2FR/oFYxGQVZVfd9m+Zo0hS8jXLjhBdg34I79tKkSHlySGzoNlQBgzXq2gmhSzzgvC/z5UOeF5N24ORiut3Cvgw8nj5g85NpKzow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0Me1mp3YYyrvHwirxc+seOzfLneCnpRLD9cX8ZOL3aI=;
 b=WoGoMLVfnyGbIeb3YT7m5rmmTWYpntjxd3F9m6eH2tF5tLbf9S11n7OhxwggMKxV6u7qwJJd3CaQA/CS4xhuKTgvxvjjYLnMAktLSWKCpWg9UH5G/FHK0J7iWBEeRAb13lAqth5RHD2unGmGxYx9vsUzdynHD/1OCKkGZTieanM7H08x8+nS0IbVHjo5ZaK5AhHioeZFK5xOXReP26qKp8RQw/3Q2vvNKJU04afUX/z0NfGPEYImC6W/hAAKC4YEZVXFg/Vr2HkstySVMUcsMQM6Qs1gkAZ6CFh/4gZEj0YhDu344Gb2dKgiLvheZFNFP6QHZnSB7QEj1WiRnufBLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by IA1PR11MB7271.namprd11.prod.outlook.com (2603:10b6:208:429::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.12; Mon, 13 Oct
 2025 23:07:23 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3%4]) with mapi id 15.20.9203.009; Mon, 13 Oct 2025
 23:07:23 +0000
Message-ID: <a3835375-6eea-467f-8488-fff62ce4262b@intel.com>
Date: Mon, 13 Oct 2025 16:07:22 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/6] tools: ynl-gen: bitshift the flag values in
 the generated code
To: =?UTF-8?Q?Asbj=C3=B8rn_Sloth_T=C3=B8nnesen?= <ast@fiberby.net>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
CC: Alexei Starovoitov <ast@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>, Daniel Borkmann
	<daniel@iogearbox.net>, Daniel Zahka <daniel.zahka@gmail.com>, Donald Hunter
	<donald.hunter@gmail.com>, Jesper Dangaard Brouer <hawk@kernel.org>, "Jiri
 Pirko" <jiri@resnulli.us>, Joe Damato <jdamato@fastly.com>, John Fastabend
	<john.fastabend@gmail.com>, Jonathan Corbet <corbet@lwn.net>, Simon Horman
	<horms@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	=?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>, "Vadim
 Fedorenko" <vadim.fedorenko@linux.dev>, Willem de Bruijn
	<willemb@google.com>, <bpf@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20251013165005.83659-1-ast@fiberby.net>
 <20251013165005.83659-2-ast@fiberby.net>
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
In-Reply-To: <20251013165005.83659-2-ast@fiberby.net>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="------------B0v3ntT8TkL9fITRxLdugWIh"
X-ClientProxiedBy: MW4PR03CA0319.namprd03.prod.outlook.com
 (2603:10b6:303:dd::24) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|IA1PR11MB7271:EE_
X-MS-Office365-Filtering-Correlation-Id: bd6ff143-5bb8-44c2-9307-08de0aad44f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SVY2N1pBMnZWUnNxMUI4YjdkVEZQeHJGTTJ5MksyVWRxaE16RC9JanFVc2tL?=
 =?utf-8?B?RHRCbXdkVmJlcWs2c1dUZDJaUThoR2dwUHhGdm1TZlN5UzBvbmRocFp0ZDND?=
 =?utf-8?B?eTFObWtvdXpUNlhCNTEydUgyTjNiUTFqM09JU3FNc0gvS1hTOGozYUVrVzBN?=
 =?utf-8?B?dStLbGVOK1hOdk12L0NJMFdIeDhza3VHN0Q5R21QWlNFelF1ZUdoMktqMlpU?=
 =?utf-8?B?ZktsYVkrZHBTSWVEdEc3TklUK1ZCUzBiMEh4SE1CV0JXZzA1VlFjcnFZK2NO?=
 =?utf-8?B?eUNXN3ljRzBxUG1CU0krcnFSNTlTK1dBTG15UVdjd3JwYU5JWm90bzJIK1Y0?=
 =?utf-8?B?aUJ6alREb2Y3Z29lZm5vUXU3bUlzclo3SGZiYmJ0QmpqbDZMVDRBWko5MFBN?=
 =?utf-8?B?Unk2Nk5LK21LZmxHWU0xdWlHTXhSbS9hbVlMT2VHeFk0aGZsSHgwR3VmSE5B?=
 =?utf-8?B?TzlGTjIxZUJ0NFlKL2NZd2lVeDRwSnVPN2RyTWJWb3pxUHM1bXBuTXFnWGwz?=
 =?utf-8?B?UERnUnIyZWxnUDVTeHBGanpySjBEQmsrckswV3NqckR3VFlEbC9ZZmtSYytY?=
 =?utf-8?B?Tm9LZVhTREQwWXJNTjRCaDVPOUs2RHdrQW5qNXppamY5WmpMZGZ0bzN1cXAx?=
 =?utf-8?B?RE9yVVZjQklBRFh2Y29xbm1DcHRCY0ZWSVBPMXVUd0lJMStwcWJCQityc083?=
 =?utf-8?B?TjVQMWdCYXZ5SmZHWjllZGk2bWc3UnpIN0lKRUJYbmpJb3JoTG1pZVF3VVE4?=
 =?utf-8?B?OTFiYzIxbE5xckk1V29aM0E0Tm9qdXdtZExOZFByd1RGWVkwN3piRWE5OXBY?=
 =?utf-8?B?bkxYMWdPdCtnbTNrK2lzOFNzTFhnRm9kVHg3YnpIUzVRWWhPYzZlTlUrU0ZM?=
 =?utf-8?B?Nkw0NWFld0N3V2krek1FZEpUTFQ3eW5SZWwwN0dUTTJyU3NzMDRSc01KTkdC?=
 =?utf-8?B?S2R2VWlOMVFXcVNxLzc5U3ducTJ4SUh3Q1RQSnlDeU83cTd5VzNFaFZUbDBS?=
 =?utf-8?B?WWRMY3Y0TTVjVi92TWNIdFJ2ZVFnVDdsYXc5Q0VpMDBLbXN4QU5sb01ENlRM?=
 =?utf-8?B?Vy9RaVpsQmZYeDJwUWJMVTFlbmU3VHdLMVFoVUwwSVdlR2xQWDN5ck00cU1R?=
 =?utf-8?B?ckllcitGWlhidTBGY3BvSkVKcHk1MlFHNWxjUENvSzYzZ0hvMG5xc0RIVldi?=
 =?utf-8?B?VWJSZDFkcy9tQ3JtamJxRENJeTdRWm5TaHIzUk9vSjQ2Ym16MUNVaXJlK0cz?=
 =?utf-8?B?amUxdGJWc3JhREtLSlZzeDJyVWtpck83eWN2NFBOTmdkemxjdnRTRnVmRytu?=
 =?utf-8?B?V1dHT2lQVXNvSlhIQ1VLZ3BxMDZUYksvTUlGKzdFVkc1L09ObHFqS0VvRC9G?=
 =?utf-8?B?NGNZaXRweTVYbVV4MDVzdGYxSVFGcTAxZk9La0N5dUZ3SEtFVFNjUzZjemgx?=
 =?utf-8?B?QitnNkZJaGxPVlplYXUzdTVrWGxGMTRiS042Z1BJbm1yRXhTUXVZTEhFNWZR?=
 =?utf-8?B?SXBqNlcyejAvTy9zOHJMaG1IS1dFNDNUZ1Q4N29vVWZIMjB1b0NZWVcvUzRY?=
 =?utf-8?B?VC9PYm9MOGVqbWEwQ2xNNUVJQ1ZRbHdoRnZNMUthWXRRTE82V0dUaTdDM1RZ?=
 =?utf-8?B?WUxZOXFVenQ4d3hzYnowbWdDeVVVYzg5M2I5MXI0SXFsN2MzdUJKS1VWSUI1?=
 =?utf-8?B?NnhpWjVTZ04vQ293U2Foc1ZBOHZFZ3RTZk9Lamh6N0RQUFBtWXNoTjJxZDhV?=
 =?utf-8?B?SFp4cDM4WHpYTTVIQlJoZHNUUFJNbHRnVjRFR2l5SStnYVNrNTZYWkZITHlQ?=
 =?utf-8?B?ZnRjTklqZ09kd3g2RTJ5Uk1tSzNVQ3FVS1FmTHBEOUxTS2dMSk9vUUp2MXhU?=
 =?utf-8?B?dmg3bVFta2hXZGlmZnNTMTRBbS9nU2F1WmxxbFZJS09hZG5odFdVOGpUdk1Z?=
 =?utf-8?Q?7Ap7dY3emkwAGpcIRYwdFsOM2RwV6eNZ?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VTIrS3M1UmRUL1dqZGZ3eXRtTVFzWlBzcHJwRGVDWkNPU1hOSWxCdkRvMEc4?=
 =?utf-8?B?QWIza0doaXl2UVdhQzdSbTJValhYcjZMUGU3NkJoUlhxaCtLV0ttT1RhUFhQ?=
 =?utf-8?B?dGtNVDlYbjFqWEF4elNuWHlGd1ArOVRxekZjNDI3Ylo2NHNyUFVtb2J2MUty?=
 =?utf-8?B?NXNod3hYc2U4L1JJQ1k3d2x3L0kyeTZBd2FuMGMxTWllaFhlZkZucTBsc0x5?=
 =?utf-8?B?WlZRdXFJZnZMemdSOTB5RnIzKzRqQTZmVEMwdWN3S1FFYTJRME9UbzgxeTVt?=
 =?utf-8?B?cURLSUt5SmcwV2ZyczJWakN4VWtzL29vNlB0dDA3czNXTG1VZmNNT1hsVGFW?=
 =?utf-8?B?MWxGZ0xsS0xqVm8wR3ppc25DSTNxTHRqQ2NLYURXc0YwWG1aQzRGVmZRbDNi?=
 =?utf-8?B?K2ZOQzJpZk4vN1gyQ09tTFVCRXg3WGF0d3dPNnZGRmQ5TnpTSHZBR0Y3N3NZ?=
 =?utf-8?B?Y1J5LzVXbk0wS2FuUHlwd28rajlkdjVGa3BZVFJtUHdzN3lPaDEyU0FqZGVM?=
 =?utf-8?B?Rm0yVFRCVlpvUW1hNzBjb0lpQS9LUkt1T0t1WnJuMmtaQ1BsbVQ0a2NDNFZK?=
 =?utf-8?B?c0tNc09RMTNmdWpnNUhweEM4c0NDSWVxOVgwM0dGeGZGeC8rSnlialE0QWRo?=
 =?utf-8?B?cFhVdEtBSmZ1Z0FRdlNiLzVHbllVUzk0WUtTT1RvczRzNGNRRmVSamFQOGVZ?=
 =?utf-8?B?WFlrUllPOTFsVHdReExDemlxNGRCWlRBOXJ3WExjUjZmTG94WWg0WGU3TkN5?=
 =?utf-8?B?eWN6Si9VNTdKemltcUM2QVc2eGJkMVFhOFFTaXpUNEZRRldlMDBzN2pLcmJG?=
 =?utf-8?B?MXRMUDlGaWdXd2g2THorNE1JbHZiUmxuQWtST0prWFczRlNnNG1XTzVRWkJz?=
 =?utf-8?B?aEw0aVoraGdTanNuTG1YVnNtTjR6TWU2NHU2eWtFUmh6Z1lFaG1CWjZTQy9t?=
 =?utf-8?B?eXBtbVZDYjVxNmlsN0Yrb2Z2c2VyaHRXc1UvQjBVSCtvd2IwZnFXSGw0WjZ0?=
 =?utf-8?B?SlZ3NWFualM1TjVVbDFYWk4vZlF4K01Bc0RENzEzUFY4TGF3M3FxWVpQalRF?=
 =?utf-8?B?OGtZTkZvN21iL01mdEd5UndMUlE0T1g0bit4Q2VlanRUenUvUk1IekJ1NHp5?=
 =?utf-8?B?YnZzZmtPaXcva3h0UlFDMTVuczVXa25rUUx4TkhQbU1rR3JmMFZrNHlvTElJ?=
 =?utf-8?B?UmpnWlFSY1NqTzlBZTRPbUdRc1dyMk1odnFKU0U4NGhGZTFSTkp2R1VETGlk?=
 =?utf-8?B?SFM4MzdGRTI3WlpRQUJOM1FjZkMzcDNqMWgvUXNieXFSWEFZbTR3OXAySHB5?=
 =?utf-8?B?MVl2QlBUTU54VGFJYjNibWV6RmlWYXVpcjl2cFJldTRWbmtMMEtPWWZoVDZu?=
 =?utf-8?B?RnBmLzYwYTdiTjByVUh2Q0k3WEZIQnFZWmhDSVZETDh0d3FoUWQ1dFZ4c09z?=
 =?utf-8?B?cXBRdUxvN3JNVy9LVTUvajNBdGszY0MrbmJqTWI0Rzd3YXhNdkhxTlBzVFhs?=
 =?utf-8?B?c01PQlE4M2djc1dKT0RQWTVaZThQeS9LaXJQN1ZvQllFSGpIYXQ0U3pRSUNR?=
 =?utf-8?B?aFV1ditkblFwMFpLWjN3alpOaEd2bzR0ZzhhZjBVWHg5U0RkMkFRUEk3S01i?=
 =?utf-8?B?K1RxYnVIN0VDVDF2b2NIYmJPUjhhMmFlRmcySlRQTUtidHJFcVVoNitzZlRs?=
 =?utf-8?B?eE5oUFlIZEdZMWlCaTYrbldVd2Q4YmFoTU10MjNiZmRqbVYvTjZZbG1jRHl0?=
 =?utf-8?B?M0JnaGpvckNXNkkvUHpIYnkyL2poT1RDSzBON3BHWVdNZFVGbE1BQXFqaXZp?=
 =?utf-8?B?VHdHajg2WENVNW1CaEFxVDI3SFFUWkU3RVdzdmZCUEVycHFUaGdxN3I3c0hS?=
 =?utf-8?B?YmFjbGlrNHRnR0hlcUhMa3IzMUFtdkpYNlVtVDk3V3VwQjcra1ZFbUxKdHBG?=
 =?utf-8?B?TVlzYmhrR1VBenc0aWk1TGR4UVpxVXhpS1RXeWE5V255bUsyZklPclVhMWFK?=
 =?utf-8?B?dittQ3dIWWF0UTJ5N2Q4V0JCVlhyTlV6Vzh5eXJHTkJrWnF4OC92Wm5aNE5Q?=
 =?utf-8?B?MUFlNFJWclpyMG1mN05NemhiYTVMU3J6VGppcC8vOGI5bzRnbE53T3JxN2N3?=
 =?utf-8?B?N29qUHJwcmtoNGhVNUI0ejNrdW5OOU0vSThZSmtxMCtPeG42R3Y0YW5RSEcv?=
 =?utf-8?B?c3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: bd6ff143-5bb8-44c2-9307-08de0aad44f8
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2025 23:07:23.7672
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0DLLMQ2EI7h8gD+6DMlv9sS5Vjepa6CaRMsLXMrt8pEmtdZzkRyx1YBiStx+dzX9nxbHHCavW8nUlP0pcpZfAdmjp4jBjqozsi6GfjVNThQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7271
X-OriginatorOrg: intel.com

--------------B0v3ntT8TkL9fITRxLdugWIh
Content-Type: multipart/mixed; boundary="------------XO5w00UmpH8igKveQ8TWLsiN";
 protected-headers="v1"
From: Jacob Keller <jacob.e.keller@intel.com>
To: =?UTF-8?Q?Asbj=C3=B8rn_Sloth_T=C3=B8nnesen?= <ast@fiberby.net>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 Daniel Borkmann <daniel@iogearbox.net>, Daniel Zahka
 <daniel.zahka@gmail.com>, Donald Hunter <donald.hunter@gmail.com>,
 Jesper Dangaard Brouer <hawk@kernel.org>, Jiri Pirko <jiri@resnulli.us>,
 Joe Damato <jdamato@fastly.com>, John Fastabend <john.fastabend@gmail.com>,
 Jonathan Corbet <corbet@lwn.net>, Simon Horman <horms@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>,
 =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
 Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 Willem de Bruijn <willemb@google.com>, bpf@vger.kernel.org,
 netdev@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Message-ID: <a3835375-6eea-467f-8488-fff62ce4262b@intel.com>
Subject: Re: [PATCH net-next 1/6] tools: ynl-gen: bitshift the flag values in
 the generated code
References: <20251013165005.83659-1-ast@fiberby.net>
 <20251013165005.83659-2-ast@fiberby.net>
In-Reply-To: <20251013165005.83659-2-ast@fiberby.net>

--------------XO5w00UmpH8igKveQ8TWLsiN
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable



On 10/13/2025 9:49 AM, Asbj=C3=B8rn Sloth T=C3=B8nnesen wrote:
> Instead of pre-computing the flag values within the code generator,
> then move the bitshift operation into the generated code.
>=20
> This IMHO makes the generated code read more like handwritten code.
>=20
> No functional changes.
>=20

Could we use BIT() here? or is that not available within uAPI headers?

Thanks,
Jake

--------------XO5w00UmpH8igKveQ8TWLsiN--

--------------B0v3ntT8TkL9fITRxLdugWIh
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQQgQFSp1zOQVirsQx5qll0+bw8o6AUCaO2GKgUDAAAAAAAKCRBqll0+bw8o6GS+
AP498tD7brlhwjraRuuUeeRH6LtlivhwR7G1vDYmVLOX5gEAuaE1X5FesBoQj1785jwtKe7TWpg0
P+Qo0iHkM9v1Wgw=
=2vue
-----END PGP SIGNATURE-----

--------------B0v3ntT8TkL9fITRxLdugWIh--

