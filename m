Return-Path: <bpf+bounces-70622-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D6B4BC6DC8
	for <lists+bpf@lfdr.de>; Thu, 09 Oct 2025 01:28:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B3333A575B
	for <lists+bpf@lfdr.de>; Wed,  8 Oct 2025 23:28:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3CA32C15AC;
	Wed,  8 Oct 2025 23:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="j1LO5jJz"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02CED277C9B;
	Wed,  8 Oct 2025 23:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759966112; cv=fail; b=qxrjtCY6Olk/5etrIy5j4S88BeBVWzJG9joRHZh90syN0pH7y+Hkg+LvnFKNtbBdG+5AMuS193jqGIHpI3BKNrhKTsV6xKNTs5eC9aEBmK/QcccjJzzT7ibk4+4L304Y3hAaCcjVym8e1PkStXsgygbTiRX5W3P95mQVaV1XEGI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759966112; c=relaxed/simple;
	bh=mBpbQosbcuGbXNR9F5MKD+sEqUAKmyQEKG89pwh1NNg=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=gLHJEMPhwp5lZCwB11mK+rOfQqmy59Mky5WM8MYNSyIGMWr2SFg+lpwNPqZQSy/iH5Tc4tZ878jKNd113LcEPrZD6Ia8/ts/eKMSCkOt3VFUzOh0j5YPbDXsIqfbjFL/WzX3EacL8TxNMnVJgBU/BAb/BHii4zWqsyTl48NUybY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=j1LO5jJz; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759966111; x=1791502111;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:mime-version;
  bh=mBpbQosbcuGbXNR9F5MKD+sEqUAKmyQEKG89pwh1NNg=;
  b=j1LO5jJzRqgjMW55gXhIFAevs3bPfL2m6Gu7pUmgZQZ2RO5Sg6ek2jjC
   izWZZpTn2+L5+Nvx25AGGVAr3gZOqJVnD2tp3ElkexKiuhRJCrHDeFNQE
   E9lM5ImL06XipCG1phVJ36pxRJjZ8syEBCJ1buBgtYqC5gfPDH8GvQf9l
   6VLTDoJDNNSQiiI/Vwz+t2+foTv/jbiUHV+ChOBBppeS608+3vfgaHHc2
   XzX++7qUaGUM/LbaGDgEYj9mL6RMlzorEv9rEnBAo7g0FQC3iOzKtcdg1
   wJRIIoEB1u+gqKRcvsst3RDJ6c/34mToy1gQairnvobEWSV7eaQm/m/9s
   g==;
X-CSE-ConnectionGUID: ZO2qeI3IQuGyZRYImSr/Sg==
X-CSE-MsgGUID: EqS4KqUZRymzRGUuc5B7Ow==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="62113593"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="asc'?scan'208";a="62113593"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2025 16:28:31 -0700
X-CSE-ConnectionGUID: 3rG03Rm5QSKkcnN0xF64DA==
X-CSE-MsgGUID: QqDG43WUSmqPKqpAU3RJ/A==
X-ExtLoop1: 1
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2025 16:28:30 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 8 Oct 2025 16:28:29 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Wed, 8 Oct 2025 16:28:29 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.67) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 8 Oct 2025 16:28:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ck3S6lFq3P7NkKVN5YAWTIKtUrhhU6a1TsGeFHDm35iZ0SMM92ph3Dq2+Y8ZT9myE2EU//at+qpYMcYi8W20N/SDnpmgsA04RYRl5Y80s/fWZ5LgeOKuqfu+SF6BCfX0plSdjpyqycyeqvHU/X1PWNQU7R28CsdlRyWgGPl24i0WMPvMx4yQBppn9LGmXDNUrJuOdD/X+s6xnzHMk6G0LbdHxUqaSGQQbR12xArEGSw8lhfh1GZED+VhF6+5zy6oCuftVh3ggKL/4cTW/qbJ3FTC06KdY3jE/PmyyZPi0TemIu+vsVYF9XWXy1opYquUX8RwnB6ZfGGt1tafjIh7kQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lexjnqRltMvxF6skEr/s2wJL/Fi3u1bWotX/sVW6XCg=;
 b=jL3ZIQPj9sBadMOO8Ybe/oXADSY0ipwvasUIoI+/CvLaRjvTKiUCzk7uSaW3OUVQfYzwk5i4wV4LPi1FcNrwHlykY2SEA8lg7sxDQ5BMnO72o+04NEp7QzswFd+aLSFjBtEDKC+MvpagH1Vqsivzb+AkjkEu9QcRyECO1RRlYTE+5fG+upN2jkP1QauuYIg5d5gX9/Vz1hJjyXT6sJYGERJryNHPc8j4fye8y1MiX5LKoEqNRZ+b2CGEzA38g7nvh/mxTFBpQ0mxVh6UJ48Ivmi16uq6prws6G97KWi48Q3U86mgplsKdkCQCEuUBUM13qzC+fdvOhCTbI5P2kQfCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB5095.namprd11.prod.outlook.com (2603:10b6:510:3b::14)
 by IA3PR11MB9226.namprd11.prod.outlook.com (2603:10b6:208:574::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.19; Wed, 8 Oct
 2025 23:28:18 +0000
Received: from PH0PR11MB5095.namprd11.prod.outlook.com
 ([fe80::215b:e85e:1973:8189]) by PH0PR11MB5095.namprd11.prod.outlook.com
 ([fe80::215b:e85e:1973:8189%7]) with mapi id 15.20.9203.007; Wed, 8 Oct 2025
 23:28:18 +0000
Message-ID: <affd8ea3-58c8-463b-8cdb-a8f2b9c61d77@intel.com>
Date: Wed, 8 Oct 2025 16:28:15 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2 1/9] eth: fbnic: fix missing programming of the
 default descriptor
To: Jakub Kicinski <kuba@kernel.org>, <davem@davemloft.net>
CC: <netdev@vger.kernel.org>, <edumazet@google.com>, <pabeni@redhat.com>,
	<andrew+netdev@lunn.ch>, <horms@kernel.org>, <bpf@vger.kernel.org>,
	<alexanderduyck@fb.com>, <mohsin.bashr@gmail.com>
References: <20251007232653.2099376-1-kuba@kernel.org>
 <20251007232653.2099376-2-kuba@kernel.org>
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
In-Reply-To: <20251007232653.2099376-2-kuba@kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="------------GRpJZf0DDrXn1qLe2GQjeDaV"
X-ClientProxiedBy: MW4PR04CA0269.namprd04.prod.outlook.com
 (2603:10b6:303:88::34) To PH0PR11MB5095.namprd11.prod.outlook.com
 (2603:10b6:510:3b::14)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB5095:EE_|IA3PR11MB9226:EE_
X-MS-Office365-Filtering-Correlation-Id: d8ca8649-035a-4e1b-019d-08de06c25c63
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VUc0dU8xSTZZU0RXWE1hWFROUGI1T3MyL1o5L2dMa1RnaXJyQXRPZE1aOHcr?=
 =?utf-8?B?Z0Z0eElVRU1JMjZoWDA3bGRkdElPSDhGVW5Rd1hDYTI1YXdhem9ObGxjWks4?=
 =?utf-8?B?S0t6T2lTcFI2NDBUTk9yeGlnUVE5ckFlak5vSEZGSTV6TEo0Mnlqck84TUU2?=
 =?utf-8?B?azhML0djbzZINStEVjJtd1dWVWh0Mk90QjJUd2tVNUNxSGMxOGh5MERpUFo5?=
 =?utf-8?B?eFJYanErSFloZUczSjdqNXJpZnZNWE0yVVlzWWY5M0RWRWpHR3Z5Wndxa0dL?=
 =?utf-8?B?TUZtM2Q1YmpBdVdKUU1iSS9GYU1KczBGcWd5bHdXV05vVDFaWDZMNjMrZjNl?=
 =?utf-8?B?Skx1T1RPbnJqSUJwSjV6enRGdVhrb3E5Vld6SW1LbWEvaGg1UldPUWlMQ1py?=
 =?utf-8?B?QitKcDF3cnl3M1VBMk1pRzF3NzN4VGdDd3o1RVd0K1NYeVh4NDBVT2JMMEVZ?=
 =?utf-8?B?Z1lvNm5tZ1FaQnVlQWFQWUh6b1JxUERKbVFyT1R1cDJDOHNSVkpTSnlYSGlF?=
 =?utf-8?B?WGFQNndVejNSbzVXZm1xV1BucVpsV3lGd0hXM04wNVZxbkNWdjJTaTdtVFQ1?=
 =?utf-8?B?UGVPZmZvR1VYSXoydVNNOHcrM3F1ZDBCaVBhNlVzSC9vb002Rm1NemV0L3d4?=
 =?utf-8?B?NnFPSWJmQUFKOTh3Qjh4bGlhSWxxbUtjYjJ2Q1BJVlYxRGtyOHhNSFNReXBh?=
 =?utf-8?B?VmNZYi9HMk5Jb1VZRktLK0pHN2xlQ1N6TksrbzVDWkV5UHhuOTRzY0pnRUhS?=
 =?utf-8?B?N253dmExZnJUR1BiWkRocXVZamlBKytFdTRaTGlaV2JIVW1VY1c0aDVobXl2?=
 =?utf-8?B?T3VDdlVzdjRTL2sxNmtwVFJxUy9rMVJxTEkxSkZ4ZGYxSnNZU0FOd1E2bDNm?=
 =?utf-8?B?dGZFS1hSL1lWcGVSc2FrNld1WEhtaURVWEVOdGlKTTdPMHNHYkIvRlAvSERN?=
 =?utf-8?B?bXErN1VUMW93M2hJanZWR3c5SUFGOEdsWVBzaWpsU21CN1JlOVV5V0hYTXZY?=
 =?utf-8?B?TWR2TU0xTHBjUUJTbXNvS004Qm4xcmpwcXFxZjVreGhxUUJYeWh6YTkvMHRT?=
 =?utf-8?B?NnJRalZvSlEydGEvZFhnRm1rd2xLTS9VMkdTZEVpUmRYM3lVRlFWMlowYkda?=
 =?utf-8?B?OWtjYzVPWjJJNnF4THVBQzlHckNBZ0RJbGloU28wVW5yK1Vya2JSekxOTWJV?=
 =?utf-8?B?cERFZkM0V0dFSXB3WEU0bVNFWVQ0VTlCTkhaaENveFdUYmp3bVBjM2QvTHJN?=
 =?utf-8?B?OVQrMnBJUTBPcDR4RXFKNlI4blFXOSszN0I3aENQbUkyR2c2T09LVjlOZ08r?=
 =?utf-8?B?NmY3b1J0dTZIeFdpUkJFYUxMcWcxbU1kOTNuUDlTcytMTU9MQ056NGtqUVJx?=
 =?utf-8?B?dUFxRFB3K3N2MDhVMXFUZkowTTJUamtxWCsrcEkzdC91THJBZ25IUnJJMVRz?=
 =?utf-8?B?d3ZieG9UTUdmUFdkbDdhYWx6UHZtdlI5aXBEQXhwNVB6WUZEMG1JN0tkUHdZ?=
 =?utf-8?B?WTdSMVJKeVI3VHJ2dXJqL1E4dGFxaUg4WmR6SjY4eCtTSld2RUNSNHI3NEtK?=
 =?utf-8?B?dnNPN1FCUDRrT09INHp3cGE2NTBNY2phK3ljSUJLUVB5S2ZiVkYvRzR1dWgv?=
 =?utf-8?B?VXVUTDVwR3hwck50Z25UdkZya09ISnQ3UWhJMjhicmkxQ2syOHMzVG1USEYv?=
 =?utf-8?B?VGVZV0ZXa0h3cXRYaFBXcllGdlAxa0NSZU9lWkpMbkFZbHd6MEFVenhoelVa?=
 =?utf-8?B?RHo2d2pGZEVQRkk0TUV4MGdPRFN1ZTgvV1NBclJ4OHBGNERWZmM0R3pVVHNa?=
 =?utf-8?B?TVpOS0cxamYyMVBiQ3ZKb1hRN2wvcUFKbWpwd2RJb3ZDN09sOFhSci9XNXdq?=
 =?utf-8?B?YnFqc0NlWldQZmd3UEdBRVlocXU0ZkxzOFdkOUdPVWJ3bVg0UFdTSjFldlNz?=
 =?utf-8?Q?D+zGpEhVuAfsWkCWG3ixTFHXa4UDX/Lr?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5095.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eEY1emQ3Z1FsNkd3dkxTdE13OW1tOEx6VGhRTGZ4Zjc0bkZBUTRqcjhVSkxo?=
 =?utf-8?B?RzM1Y2xXZjRBRE5pYkJRQzBsQTZNR0ljcGlGWkJuMlJibEFxckZ3SjhnbC8z?=
 =?utf-8?B?UnNpNUdsS3dwSFJvZVY3VEFxcktvTzRPRHllS3pHd1B6cW85QkV0cFdJQzVM?=
 =?utf-8?B?UTc0UUY2aGdlT2dhMmVTYlcyOU9KVXBpOTQzclN0TUZxdU41bjQzR2dJRHc0?=
 =?utf-8?B?ZkpPWTdJVjBMVm43Q2xabW51NGZoM0dXcHRmUjg2M09VU0g3VnRRejFNTjNZ?=
 =?utf-8?B?NGdac0tra3JMZmVMVUF4YUYzY1pGNTl2Y1RKVDR2cU1qSmRSclR0Tk1PR3Nv?=
 =?utf-8?B?ZkdCYXViTktGMm1ieHU2NzFyL3BhUlB0bE5mRC9Bd00ranlZZFlidkV3TUUr?=
 =?utf-8?B?NzQrYkNGVHBjeDRjcWJzUFBZaTNscVN0c1o4OUI3c0YxUVJJUEtrSmQvK2M2?=
 =?utf-8?B?TXNOYXpyZzQ1WFNKQ3VrYVI3RHlnYlNRWm9uVzF6VUtKeGNMblQrYWd0QU5l?=
 =?utf-8?B?Y1RCQUYwRmJYWTE1V3VjNDBSSHlySkY0ajFTUWhxUmNoTHozbExScmZmelBW?=
 =?utf-8?B?bmtSWE9xaXNWbnJMcm1PNzZJUHZrS2NjdVVKVnBiZEFMemZROTUvSHdsdVgw?=
 =?utf-8?B?K3ROZ2ptaG5TMnZxbUs4aXJjNExHOHZ2aDZHNUlIZUN3WlVuTjB5TmVJSkZh?=
 =?utf-8?B?R1B3N0Fya0lUTENHUDVFcjU4YXRsTTMvakJyL0ducFhKbjZUY2QwL2x0MEU5?=
 =?utf-8?B?MjhBK1g3ZWxSR2tTTUFod3Z2a0tuZ3E5U2p1NEp2VTVoem01NWQ4VFg2cHh4?=
 =?utf-8?B?WTB0dnduQ3pOaVl3YTFrbERnZU5heTluekg0S0ZNQy9sRFZTTW0yZ0lEakxU?=
 =?utf-8?B?eEgxL2pWbGxVOVgzc3pJQTZ6QlBaUnh1anRSWkx0M09oNzRYUUFBTXhPZ1FE?=
 =?utf-8?B?OFRhYWFSaWlLc3FXdkpJbUJiZzVBc3IrOUd5d3o4NDROVmdJa1N6SmhXNjB3?=
 =?utf-8?B?THloUHdWWk5RUWljQXZxM3Yxdm9Kem81Q2haVU9DSlVEUXpWeFV4YURqejcz?=
 =?utf-8?B?dDlpSDJTcE5haXFQUHJzTGovd0VEaWZsLy92dW1XUWdObTRyMjg1em5qWVZC?=
 =?utf-8?B?dU5qZnNFY1REUERNc2U1OUU3bE5MYXJXaTJSNjBESWVCKzZXcEZDTHlLMXNM?=
 =?utf-8?B?cjF3S0RldTFyL05GQytGblF0Qit3bVM4TU9DTE41YkRXM01BcVZEcklueUtF?=
 =?utf-8?B?RG5iYnhPbGJYV2NyZERqK3Q4N21VdWNVaGw4SjlpTTdSYVR4Qnh2bThmam5Y?=
 =?utf-8?B?OC9KeUpQU05ralFxZTVYZ25VMVlWVXZmbGl5YjR2QTN5bythQ1d1cDdEMGwz?=
 =?utf-8?B?cHA5ZjVpZElvZkxXSGFLT0hsai9hcG5rOW14NTcvZTZJRGlXVmtCL016V1Yw?=
 =?utf-8?B?WUhuRGJQaHFnYXJNTzdrN2VET1Z4M3NlNEx1S3BvdC9nMGtqY3lRbUNPQ09u?=
 =?utf-8?B?OU12UTFkWXk3Yjl1a25zU1BQSjNSbmtGOHQzUUcxa2lwaEpnMHNSUFdZRTBj?=
 =?utf-8?B?VVNKZW9xOGpMODdoTndjNmQ4VUtxVVhtZHAveVpiampqRFM4R09VSlYxZVpQ?=
 =?utf-8?B?ZTVQZVQzc1VWMkc3MHFmc0JLbnVETVUyTHp6N1pZSnFGdXNKQ3NoL0VEc1dn?=
 =?utf-8?B?VFpLVXhFWmgvaE1zeWlONGY4dkRUYjVKUEs3RFU1VWE2N0JmSjE0Unp3a2hH?=
 =?utf-8?B?ZmpTdWdrOGZlWXpheXZhYlU2QWlLVG8xUUJ1U1pjUXd6Z3dMaUQyc0UxUFo0?=
 =?utf-8?B?VXlGdXJVTlZYbVZYTHhTQnE3UTM4azEwdlpFb2VRamdTdkdpZnFjTnh4Q1A1?=
 =?utf-8?B?VlZzVkt5ODB2QWtUbTc3eisyTlhwS0JXTkhseGpWcXJONkNvTTlUeFQrRUdR?=
 =?utf-8?B?UjBMNm5rMDZNdC91d1NTZWphLzIxUmxYNXVyVDU4Rkh1cFlRWTlEa3U5U1Yx?=
 =?utf-8?B?RGsrald1WCtDOFZYaXNDajlyVDBKSngxQzl5MlVRZGNPSXNDcUpLcnhCT2FZ?=
 =?utf-8?B?eTJsdFRBM1BPQTRQTmRBblZEVjhUTlRTOFhhK1N6TWdNcHBHMnNEZEd4QnF2?=
 =?utf-8?B?eTBwMzZRaG9raGllMWw2L0ozWkk4bjRrRDkvYWRsQTc4c0pNTzYvVkduNHJS?=
 =?utf-8?B?RlE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d8ca8649-035a-4e1b-019d-08de06c25c63
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5095.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2025 23:28:18.1861
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OLmqsgbwLsJ1gIJNazp4SyRweXRBJO3XY+phOXmT+8sIZwtMVy9H9zVhPaISv7LEnziNrK4r64SKyMB3I8CVzO1W2tPhp0wudBnMwAHsCVg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR11MB9226
X-OriginatorOrg: intel.com

--------------GRpJZf0DDrXn1qLe2GQjeDaV
Content-Type: multipart/mixed; boundary="------------l7sFsivI9XFi0FUxkdghL7HP";
 protected-headers="v1"
From: Jacob Keller <jacob.e.keller@intel.com>
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 andrew+netdev@lunn.ch, horms@kernel.org, bpf@vger.kernel.org,
 alexanderduyck@fb.com, mohsin.bashr@gmail.com
Message-ID: <affd8ea3-58c8-463b-8cdb-a8f2b9c61d77@intel.com>
Subject: Re: [PATCH net v2 1/9] eth: fbnic: fix missing programming of the
 default descriptor
References: <20251007232653.2099376-1-kuba@kernel.org>
 <20251007232653.2099376-2-kuba@kernel.org>
In-Reply-To: <20251007232653.2099376-2-kuba@kernel.org>

--------------l7sFsivI9XFi0FUxkdghL7HP
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable



On 10/7/2025 4:26 PM, Jakub Kicinski wrote:
> XDP_TX typically uses no offloads. To optimize XDP we added a "default
> descriptor" feature to the chip, which allows us to send XDP frames wit=
h
> just the buffer descriptors (DMA address + length). All the metadata
> descriptors are derived from the queue config.
>=20
> Commit under Fixes missed adding setting the defaults up when transplan=
ting
> the code from the prototype driver. Importantly after reset the "reques=
t
> completion" bit is not set. Packets still get sent but there's no
> completion, so ring is not cleaned up. We can send one ring's worth
> of packets and then will start dropping all frames that got the XDP_TX
> action from the XDP prog.
>=20
> Reviewed-by: Simon Horman <horms@kernel.org>
> Fixes: 168deb7b31b2 ("eth: fbnic: Add support for XDP_TX action")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> CC: alexanderduyck@fb.com
> CC: jacob.e.keller@intel.com
> CC: mohsin.bashr@gmail.com
> ---

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

>  drivers/net/ethernet/meta/fbnic/fbnic_mac.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>=20
> diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_mac.c b/drivers/net/=
ethernet/meta/fbnic/fbnic_mac.c
> index 8f998d26b9a3..2a84bd1d7e26 100644
> --- a/drivers/net/ethernet/meta/fbnic/fbnic_mac.c
> +++ b/drivers/net/ethernet/meta/fbnic/fbnic_mac.c
> @@ -83,8 +83,16 @@ static void fbnic_mac_init_axi(struct fbnic_dev *fbd=
)
> =20
>  static void fbnic_mac_init_qm(struct fbnic_dev *fbd)
>  {
> +	u64 default_meta =3D FIELD_PREP(FBNIC_TWD_L2_HLEN_MASK, ETH_HLEN) |
> +			   FBNIC_TWD_FLAG_REQ_COMPLETION;
>  	u32 clock_freq;
> =20
> +	/* Configure default TWQ Metadata descriptor */
> +	wr32(fbd, FBNIC_QM_TWQ_DEFAULT_META_L,
> +	     lower_32_bits(default_meta));
> +	wr32(fbd, FBNIC_QM_TWQ_DEFAULT_META_H,
> +	     upper_32_bits(default_meta));
> +
>  	/* Configure TSO behavior */
>  	wr32(fbd, FBNIC_QM_TQS_CTL0,
>  	     FIELD_PREP(FBNIC_QM_TQS_CTL0_LSO_TS_MASK,


--------------l7sFsivI9XFi0FUxkdghL7HP--

--------------GRpJZf0DDrXn1qLe2GQjeDaV
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQQgQFSp1zOQVirsQx5qll0+bw8o6AUCaObzjwUDAAAAAAAKCRBqll0+bw8o6K+9
AQDeyVu1wd0xKYMbV0kPSyl2g+REja7RFFFm7/pzCUey7wD+Omi4zJhC3SB/0tBqP+LOsQpHMd6O
efAeArznb/YvGwE=
=+sTj
-----END PGP SIGNATURE-----

--------------GRpJZf0DDrXn1qLe2GQjeDaV--

