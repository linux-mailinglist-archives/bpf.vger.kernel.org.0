Return-Path: <bpf+bounces-70841-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91FB2BD6B62
	for <lists+bpf@lfdr.de>; Tue, 14 Oct 2025 01:11:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C1B8405929
	for <lists+bpf@lfdr.de>; Mon, 13 Oct 2025 23:10:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BACED2FE062;
	Mon, 13 Oct 2025 23:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EtzCm87d"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAE7D29D275;
	Mon, 13 Oct 2025 23:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760397052; cv=fail; b=opk9C3KXM8920lyUiZs89MyQ0VNuCxOX62thW9AFZ0ISRGGmLZsHXI4B8euIv9wiKtTcU7PeatIB/nkDBGBYYXuyehmsDZhJmY8s6I3oX4ceW+Qns6kbn1fnwTu5sIKzgcTJCru8Vc4xng/BCXv2CyDczCvik1J87U9aElGZzSE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760397052; c=relaxed/simple;
	bh=lssEbyhpWd4mRolZDScz0c7ieq3hlo40gnQQB6oFZa4=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Z/fQUbNwnNN364LQ5fO7ze2wv8SC+R/hBwo4yNgXO0qQktaV0BWJvDdvxpDMUytm8dV/GieqBklKv5EsSWZ/loYMcBuKNmGEqdTvjpsQcykMUUdTJ07IUuImlee76a4h6N/jOHf2W569v/F2riDMd6aXBkuxUGFdIcM8c8V7SPg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EtzCm87d; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760397050; x=1791933050;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:mime-version;
  bh=lssEbyhpWd4mRolZDScz0c7ieq3hlo40gnQQB6oFZa4=;
  b=EtzCm87dJJ1ZCmWoV9jfmvUqSMNM0xbQicqx8WBkqVxp97Ca9Vm4rUyh
   A51ELODeYrpnt7tWSdxp66CQeTX8lD564CiWyHal9WLCwx8dVzVYL10Ag
   xggOIIXqrD3NaMH66/HzvQanO/YCN1cBR1VsGxLmh3JKTNo2FyYcLhqoY
   E/Lw0q4dX09QapYSAWTELjaSvAJ1bJbbraFMDGFh3kEM9VzT6LyV7TaD1
   7sycwkgU+/du1lru/MpNJuh6wD63G6135FVpCzwXnobrHOuRxR+6zsQmB
   jws61YtniwG5ZVfttjKkiiMm7UgLF0AZFjhFgMgQlLZDmVCWMXUv/HosF
   A==;
X-CSE-ConnectionGUID: OmJYZxIlScujGYP8iZiXaA==
X-CSE-MsgGUID: n5Hc9tWoT96kEeeh2zc8CA==
X-IronPort-AV: E=McAfee;i="6800,10657,11581"; a="62587648"
X-IronPort-AV: E=Sophos;i="6.19,226,1754982000"; 
   d="asc'?scan'208";a="62587648"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2025 16:10:50 -0700
X-CSE-ConnectionGUID: 8ZCTxDSiS3SCU09yWrOiyw==
X-CSE-MsgGUID: GXBTxrsmRAqWnSaaXwwjYQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,226,1754982000"; 
   d="asc'?scan'208";a="185745396"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2025 16:10:49 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 13 Oct 2025 16:10:48 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Mon, 13 Oct 2025 16:10:48 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.5) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 13 Oct 2025 16:10:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EWbgttAKFaR4I3Qbo4LjBE0+mEBO3ufY8oAh5JJrTL5GDSV2lu2e5U7a3N9xVgt8ca1jbteh0M4bRq8RIU6eN5jEkTEA32LIT6xkS8cWP/VrF9WOGtpXtTi+bSZmytkvAfQFkpCna99llm4fIHugy7eWMFeuy8RRNNKR3p1AxEbotMyzD6Yq0I2UUCKa4ELCq2G8FQISx6ExTp6n1n+hjxUjfILQNW8yGRqijobQypk4S3C4FX1KiwdVQ9zwfe5bNHT4e0vFy6zKHtE+ndJSeVfw6huc46WA+FdR45NqxpkWY79+HA5CsjWKQD2J/PitR/XXgkcMS+m5qngLTzM5RA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tU6vXampCWrLB0UZDAJzB7tujz5uiSimDeh4lTTKgHM=;
 b=e+PgfktaQcZThacllvuGB9wmDvlGGESTBOElMnY6zgniVYuH0sOkn/lYp/LDi9odjLw6HlHLXovfDE6pfZYTcjLdbkpO7ud2Vrd2BBvfvVrb0OfLr7KrtJkZwSBx55rkIHAg7Sr85blO5UKZfs+uGfgx6pRJeGJYwiU/HvBMAkTzoixB5oFE9YB1GLraeU/j4rE1JAqQfSWW90+d6u5+f1NxkxNrZ9RBKrHWiY5PkG5XaFDkM19hiN3I2Km6NUZa1Cf9mG3czTtXeiHWRYgL7hUlNHXsryDTVQmI4mYrRyx+zAfVCe2fa1eZygcD4jY2UPsggJMKm4Bmopy3hPt+hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by IA3PR11MB9327.namprd11.prod.outlook.com (2603:10b6:208:57a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.12; Mon, 13 Oct
 2025 23:10:44 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3%4]) with mapi id 15.20.9203.009; Mon, 13 Oct 2025
 23:10:44 +0000
Message-ID: <611a6e2e-c22a-48dd-8450-f79005771568@intel.com>
Date: Mon, 13 Oct 2025 16:10:41 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 0/6] tools: ynl-gen: generate flags better
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
In-Reply-To: <20251013165005.83659-1-ast@fiberby.net>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="------------ZbgJ4pgpojzox4mr1sQlFNid"
X-ClientProxiedBy: MW4PR03CA0321.namprd03.prod.outlook.com
 (2603:10b6:303:dd::26) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|IA3PR11MB9327:EE_
X-MS-Office365-Filtering-Correlation-Id: c430fa3d-b245-4640-9ffe-08de0aadbc2e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SkhIcHJ0a2toS0E0cGlvbWFRU3NPMC9uUzJnazVzOTFrYWR3aERaaXpxeENu?=
 =?utf-8?B?ME9FRWVsRnZ4ejNTTTROeDgwMDlTSWErZUVjam1la1dKWVNCb205UkFMT0hK?=
 =?utf-8?B?bmJUZkdld3hRWmVMUW5tZ3VUM2preW5lM0lZaXMyRWdNV0J0Q1dxS3NxRzZo?=
 =?utf-8?B?YjYvQXBKaEJ5SktKSjc5MmtnbkFmc0txWHhMdy9uWDNsSTBQZUJHSGtQMmNY?=
 =?utf-8?B?TDZxOTM2bHhoWG9NaDVjeTY1cTFKVE83RVJHc0FPaG1QMFNhck9SZlVtOWkv?=
 =?utf-8?B?L2NrWE5jQXlyS1JWMzZGdnhiNi9CTXdSWktLclY0MFZWYi9sem5pWStJOTRC?=
 =?utf-8?B?NnQvUnR1a2JZK1NQNXgwQkw4NnVUVW1SMU55MnNyd096NmgyeXFKaEd2WTRh?=
 =?utf-8?B?dG1MblhZWWtuOGFOZkJwNVVMcjl0amZMRVdyRkgyaUcwUW5KNlFKa3poczEz?=
 =?utf-8?B?N1NtMlZlTTBHQ3pCdFptYmR3TjFwRWVmQ3VDL1dBUm1OSSt6UjBmc0NQRTVT?=
 =?utf-8?B?T2lLa05xaG1aamlMWkg3UG9vNWNJT2d5d2xCVWVQUUlKTThOcFUxZ0JHMDk5?=
 =?utf-8?B?Z0o5V3c1UXJVa3VQVHRkWTUxUGdEeGNOQ21uK1lBdXBvdGlybzNHMmN0M3pD?=
 =?utf-8?B?dUlGdklNaHhEUHR5Ym5xdVJZWFN5VDZ6OVhBWDROZHRoSVBXVlpJd2hxRTNF?=
 =?utf-8?B?UHA4SnhIMjBnQnhWM3QxZWgwei91M0FDTGJzZ2VhdmpHYkZhL05Tbm1od0Zl?=
 =?utf-8?B?aGpTMEZSMUhRU01UUDAxTUxHejE3K1VnY3JVL1dlWWh4R0dvcUFJU0I4WDdG?=
 =?utf-8?B?dGxBSE9KWmFETlJaM2FieGhSR1NSM2ZZZ1B4bEg3L3pKSXVScUVrMkZCNE5a?=
 =?utf-8?B?UHFWY2dyQ09hREtBZlpDeVp3TnhsOFhPZjFnT21mZm5wNlB6QnRZQWpoU3p1?=
 =?utf-8?B?VXVtZ2k1c2VFc0t0OEF4NTdleHNoUUVBaDJOOE54dHpVZWNUbDh6WGhZdHNB?=
 =?utf-8?B?ZHdrUlhLTUh5Y2ZJdHdpMUxobzFmUVd4dG03SllVdFhhZTRLOTIrbUFlM3lU?=
 =?utf-8?B?NytWOC9HQ0hqMk43VGtlRjdBSlBVUEZRYkpaY0E1RlJaTGpQeEFkVVQvVFhs?=
 =?utf-8?B?VFdHL0s5ZVBEUW5waGlwa1JKcTBhaUVTbUFOM1JRK0RXUDBZOVBOekpJZlFm?=
 =?utf-8?B?dlRXN2gyNUo4KzYwbGhleFN3L3loOGlEbGU4UkdXbFVlTnRDZjZLalMza2pX?=
 =?utf-8?B?MzdsTlJwdXd0U2R4WGswWDFJL2NrMnBlQ1lZK1IrTitEemg1VnFZWUQxTVBz?=
 =?utf-8?B?dGdFZVk2cmtzR3FDcXNmZTJaenlseTY2Wmo3R250N0l6RHZIQkU3cVB3NDRZ?=
 =?utf-8?B?Y3dFR1FDWmpyM1gxU3NJQjNIaVk2b0cyT3RiWTBnT0h4VVU5NXlYSnlGc1pR?=
 =?utf-8?B?emN4eC9CSGU4aUoybW5BcmoyaDVQQ2IwT25wUkRadXJhNDNrY1FDWnBhdXlL?=
 =?utf-8?B?U0xEM1I2NU92OFNBaWYyK2t3eEpSaVNkbVVWNmVBaXVoSVNNTGNHeUhLQzBZ?=
 =?utf-8?B?SjdVdjhRTHlyWktZWEhJS2FNeFVzbEVCeFgweUFQVUNHWU1jZnRyV3k4TGND?=
 =?utf-8?B?ekNlRTY4SnduTzRiVzRPWjNWQ21YTzhnNDVwV1BzL2ZXYm52TEFsN0RFT0NP?=
 =?utf-8?B?YjZKK0V4QXZLcWRIS3d0UHRWQVdNbDdNbGRXdFN0OXhURXNqTVVDZXhDSk50?=
 =?utf-8?B?aWlFS0t4K3d4NjA5K05rM1NiYUVQYW91eFVVWnF6ZE95TGV4UXJER2d2dDlL?=
 =?utf-8?B?cU5iRzg1cmVTRmpwZG82SWtZaXRudXl1R3paMlNXOTlzaVNDQnptQ2pHMXU3?=
 =?utf-8?B?OUNzbGFmRlFxYXkxYnJOSEliZkxYSTFTZE1qandpaDZ5Rzk5YW5QU1NtUFgw?=
 =?utf-8?Q?xS6L/vIGKxIe6m0VhM+HK2VDi9W/Tya1?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QVdxSWx0WG4wdTRTdjVYbjVJRnArVlVqcllOSUpaZFZQbXVWL1F0Z0xwZVE5?=
 =?utf-8?B?Y0UwQ3JOV1F2di9oNTFkYk9IdExIY0VUTERVNkovMndMVjU5U0hkRFZRRzZI?=
 =?utf-8?B?MmFHYW5KYS9ROWlrdmFQOU5HbzJaMUIvVy9SSUNmaTNlU3RzRVhxWm9Nejlx?=
 =?utf-8?B?MU9CaFI0RnpNaEZOMktNS21JMFpRY29CTmFPazh0Vnk0UWdOUkJaWkdYK0o2?=
 =?utf-8?B?eE13VWdsWVlUQlREbVExc2ZFYkhhaktlRHhmQlhoTUcrZTlBaEhQM25BZERw?=
 =?utf-8?B?Qk5QbFVLOWpzMkxod2JyRHF1MUlnbjgxMEU2WTN6Y3hnTDRqSlBjY3hSano0?=
 =?utf-8?B?WU83aFVNcE96a3h0OTBxY3JFaFZuMnQvT1FTQWg5aWplMXVJV2VuTzVoUTly?=
 =?utf-8?B?cFhyN2V3a0xWMThTazJ0ODdmdXF1YTR0UXhNSDBlbkkwRERLMVJjT3drdm5m?=
 =?utf-8?B?dloyVHErejliUkFwaHpEOGR2VTBXaFFnSkNwSzF4YXhURUVVTkNGRjJuYVhk?=
 =?utf-8?B?S3F3aGE0THM5ZTJpa3VxWXd4eWJFTVljKzJ4Vlk4Nkt4eW44NHdkS05kQmFY?=
 =?utf-8?B?MXJnR1plb3hJUGxxWXVjRzh6UTM0M1Z4cFZXUnYvQTQxVXBuMGNtSzQ3cGFJ?=
 =?utf-8?B?TU8rUEhOakhrbkpHZ3BldUJCNXRhUmczUCtqb0gvN3I5UFZ4VlRWNWk4eFNS?=
 =?utf-8?B?Vkx5MDF2UFg0cUdKd0F1Z1NGOXJHSGJKSGttVDNFbk5FNFdaM1V0V1VlRWNB?=
 =?utf-8?B?WXAvNWJSRG5lRkNRL1BFYXpONFJJSjR3MzRQV2JzbkVHT1ZqdlhQMEFlRVFr?=
 =?utf-8?B?V0xDSDhCQ29kNFZVMEc4WnVCelNLcWhhNUV4RWJWNFA4WFJwNXlqQ2c1THdC?=
 =?utf-8?B?ZzErUTdhT05GcGhXRDJTSjlBRURKdExLcm5ma2NJcGR5MTdVdDhKYkZYRUov?=
 =?utf-8?B?UTU3WW8rSE5jdldEd3ZRU3FpR0NKNUcxL0E1WC9rUURJWjcrWHJJUEZJTmZv?=
 =?utf-8?B?ZE1rd3pLVkVrQzltM1kzUXJ2OS9aMDd3RDYwdmRxYjhPWWpERDArR0FpcDZH?=
 =?utf-8?B?WmpnZ0ZKSk1McE5aT0tXUVl6TlR5WnlGZGJ4ZzFyMUF3Y0g5MlZ0aldyTFdW?=
 =?utf-8?B?RTJlbG9VaHVOT2VXMERQMm1qM1RRVVhJTkdxWksyK3BIMHk5QllqNUhIckho?=
 =?utf-8?B?anJHc3dQNWd6WWNNWStaU3Q0bE42NVE1WWlmRUhSeUMyTUMwdkx4MUFlYStn?=
 =?utf-8?B?eGVRbUkweG96VmxvRGVkQkpRNEZ0dDRheTBUMGRwYWJMQ0hDRkhMSTZZOGJG?=
 =?utf-8?B?Ly9ta1N5MEg5cGNJblpCeFRyaXQvbUh1c0VXdkdVcTR4VG5FNytTUXp1emdO?=
 =?utf-8?B?aktDS0xPcjE4bm9LNUtvVUl5QStLRHVjNCs0MmlyRm40aHZKWTRJSWtDNElC?=
 =?utf-8?B?VGR4QjBqaFNQLzVvSWpzRXJlVzgreGJWK3l1NGVNeE5hei9wVDlzT2d2R1F1?=
 =?utf-8?B?dGZ3TFJ1ZnRBdWZJa1RVcnhFZXJ5amgrODNGeVpYd252Wm12TDVGWE1uYWxq?=
 =?utf-8?B?R1lnWjFZR0hTVjBFVDVwb29veTZsQTZZZEt0Y2d0cU02cXpKODBvVWZ0NmVz?=
 =?utf-8?B?VFFGZG5HWE9zL3lLb1ZiUVhncE5lSkJoZW5KVloxOTZDY3RscGgwZE43em1T?=
 =?utf-8?B?TWU0bnZOUnV5TC91dGVjS21sWXBCaU9MaHp0TkJBRElGUUZQNFNXbm1RQkl3?=
 =?utf-8?B?MTBDcDcxWVpiT2FmcnFGeGdDS2ZlNmZkZlZLTHFwTVNuY29KV3RQcVVybzBM?=
 =?utf-8?B?WGF4WlRWU1VTcVhEaXU3ZFQrcGtGY2RJUEh4KzVkTDZ6NzFLS3FKdi93TVlS?=
 =?utf-8?B?c05Vc09qcGtTM3RHOWFHczRYZ0VNOWRURUVuRXhoQ0p1VXltTjVwZHhzUmsz?=
 =?utf-8?B?dmdpOUFPeklQbFNhU0daNTZsSWFnZWx0WnlVaDdBdVNBVTVFUngwekQrMmVT?=
 =?utf-8?B?OXhrOHFLQzR6WGZJWjRoZldMUisvaHBRWWVsNTNaS3krbS9NdExndWxVdUdi?=
 =?utf-8?B?c0hyUnp5WUZPZnQybU5PalI2RmlucmpadW1oRy8rSjJSbWlrUXhnMFFzVjF4?=
 =?utf-8?B?OTcvcWZWbnl4clh2WjZKQnFGdGJEcVk2VHQ0Y2NIeithN2dQbExiWjNPdWlp?=
 =?utf-8?B?Vmc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c430fa3d-b245-4640-9ffe-08de0aadbc2e
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2025 23:10:43.9608
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qaQOqhj7kgv5c2VTZVx6t09BJ8412F8IQKwQTGrFzogFzg5fzX1bFfl08BDWMb3s7cfzjd8yRCIr9EzGH9nVSYsDRnnIHtWn33XHnlgLIqM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR11MB9327
X-OriginatorOrg: intel.com

--------------ZbgJ4pgpojzox4mr1sQlFNid
Content-Type: multipart/mixed; boundary="------------iUS7ZZW00J7Ms1bi0mgrwBNu";
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
Message-ID: <611a6e2e-c22a-48dd-8450-f79005771568@intel.com>
Subject: Re: [PATCH net-next 0/6] tools: ynl-gen: generate flags better
References: <20251013165005.83659-1-ast@fiberby.net>
In-Reply-To: <20251013165005.83659-1-ast@fiberby.net>

--------------iUS7ZZW00J7Ms1bi0mgrwBNu
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable



On 10/13/2025 9:49 AM, Asbj=C3=B8rn Sloth T=C3=B8nnesen wrote:
> This series focusses on increasing the quality of
> the C code generated by ynl-gen for flags.
>=20
> NB: I included a note in patch 6, on usage of the private
> NETDEV_XDP_ACT_MASK in user-space.
>=20

Everything here is an improvement over the existing output. I would like
if we could use "BIT(N)" instead of "1U << N", but I think its better
than the current pre-computed values that you have to parse as bit values=
=2E

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

> Asbj=C3=B8rn Sloth T=C3=B8nnesen (6):
>   tools: ynl-gen: bitshift the flag values in the generated code
>   tools: ynl-gen: refactor render-max enum generation
>   tools: ynl-gen: use uapi mask definition in NLA_POLICY_MASK
>   tools: ynl-gen: add generic p_wrap() helper
>   tools: ynl-gen: construct bitflag masks in generated headers
>   tools: ynl-gen: allow custom naming of render-max definitions
>=20
>  Documentation/netlink/genetlink-c.yaml        |  3 +
>  Documentation/netlink/genetlink-legacy.yaml   |  3 +
>  .../userspace-api/netlink/c-code-gen.rst      |  7 +-
>  include/uapi/linux/dpll.h                     |  6 +-
>  .../uapi/linux/ethtool_netlink_generated.h    | 20 ++---
>  include/uapi/linux/netdev.h                   | 34 ++++----
>  net/psp/psp-nl-gen.h                          |  4 +-
>  tools/include/uapi/linux/netdev.h             | 34 ++++----
>  tools/net/ynl/pyynl/lib/nlspec.py             |  7 +-
>  tools/net/ynl/pyynl/ynl_gen_c.py              | 79 +++++++++++--------=

>  10 files changed, 117 insertions(+), 80 deletions(-)
>=20


--------------iUS7ZZW00J7Ms1bi0mgrwBNu--

--------------ZbgJ4pgpojzox4mr1sQlFNid
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQQgQFSp1zOQVirsQx5qll0+bw8o6AUCaO2G8gUDAAAAAAAKCRBqll0+bw8o6Lut
AP9gQ8aFU/jMuXHvw8F+xfca6s6GqnuBfkvGmRh6T1ht2AEAo/ccD5l1KJpiE0eTdvUwcAMbtwNm
ZFXHujALla1gbQI=
=+AUo
-----END PGP SIGNATURE-----

--------------ZbgJ4pgpojzox4mr1sQlFNid--

