Return-Path: <bpf+bounces-63968-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ACD51B0CE70
	for <lists+bpf@lfdr.de>; Tue, 22 Jul 2025 01:53:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D35D1AA3ED5
	for <lists+bpf@lfdr.de>; Mon, 21 Jul 2025 23:53:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A5A8248F48;
	Mon, 21 Jul 2025 23:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BLIQV9T/"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7A7D12E7F;
	Mon, 21 Jul 2025 23:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753141979; cv=fail; b=EtD1edQf36Yd4HFG5o+r6cpNGoMzGBdsywAHspTakWX7ynJbKIwmP7BZeWZLoptVsD7hEGZvEq4yQ9ZyiDoMfJnrPF8acD6c1rXM/+ko91HHT+LH1a+6RL6WuWWpZzfFkZH0Pt66qjgcJyM3fEB6OkOM01z5lM+g30MhZI2f+9c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753141979; c=relaxed/simple;
	bh=06e7meUlPyyMZDL2yZE0prOrBk0PeQSz+60Y4PtLw/w=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=VVcb3Lscyq4+29GchFjWNcgWsk+8CJukjRwSGSDtNz+UZ4z2cSRSLQbG+66Ja435ecx+8EE5/6SWEX64xhKaw8ToJeOcl173/uYW5UUrqYtjF2qHNRAwf9t7LOhLiVlJqpA70gXd9YnefgcdnmVZluqtLIMxgdxQtFOXknwy+9o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BLIQV9T/; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753141978; x=1784677978;
  h=message-id:date:subject:to:references:from:in-reply-to:
   mime-version;
  bh=06e7meUlPyyMZDL2yZE0prOrBk0PeQSz+60Y4PtLw/w=;
  b=BLIQV9T/+yu2S/uvqMcXQv/SNFdTAtXqX40Jx7AWfHuURAGEp2xQgR9L
   rpdc68r3MxNW3rGh1r7pYX5sl3jC9UMNzaLTcNm9SY+VmY2b+IkBctFpG
   JAIHsDkwROlPwaUcokFD7QVZdwVxOtHFA/hHHbQqmf6SB2ebD4a8cN0ZG
   zHAhzvYQ01ymsAXi6BCFUOKACunRKrVXBmk6NyAjb13Lso0sp+PSgI8xf
   pXk+jiN4KtElyU+z9UCDhr4YXnNGAA37FiQD8yJRlqY0hxoF6u0jyyPHq
   1XNfCtZD29agxDUm0hAkvwFryIsInJ2iZHAS1rZWrwBXrrMKVbN5X3NDv
   w==;
X-CSE-ConnectionGUID: pc0dx76ZTQi6ACoUj0gdWw==
X-CSE-MsgGUID: iQPaPv6pTs6dejZ8etknYQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11499"; a="55487809"
X-IronPort-AV: E=Sophos;i="6.16,330,1744095600"; 
   d="asc'?scan'208";a="55487809"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2025 16:52:50 -0700
X-CSE-ConnectionGUID: 2Hl1YazbQaWIYlI6h7apzA==
X-CSE-MsgGUID: eycTOi5mQyKJXah9IuPf0Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,330,1744095600"; 
   d="asc'?scan'208";a="159299380"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2025 16:52:44 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Mon, 21 Jul 2025 16:52:06 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Mon, 21 Jul 2025 16:52:06 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (40.107.237.69)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Mon, 21 Jul 2025 16:52:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o+JwYG4N63dwCjT0Qd2PqbJv2qVef0HSIUFGzMOxLm6GXdBYIbz1GuWpyfwJRR0CaHmGUBi+VyB0gMccvsz4hAibCC2AcZwsUsqww6ZwnWLhmv7KB9HZM2pDwINB0VJIh3xJAw2x1KahBYQS2RC5Ekg34RyMmQjD9k1O71IGSAofz9QuuZ/Flsih3K2x3oP0UssYTWBTjp2ZtT8H4zD8oq12YwApz+eA4VkSoeO0acltjvBUkSeblwGqxq0Pc0HDnglCC8ayfYLrbK4gdA8u+2m1mYgVzJSRMzMpTZcOQ/E7Q6jFtuV3pfFac4GzvAbe9fjokwtNQGIal/Mch3rJ7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dgs4A5+u2Z+p2MbuxM27tZhixSmUrKVkUCv6O6x1GC8=;
 b=sTtxFbNylrspDN3CfRam2zt8PkM9Oh8As1rrD28QPRtR32jn+cApCpmMpadTC2YGLtv4ehQE0QWHDx7Fbe05bcQHpcNtS4aVBujVjgJTQGnv4Pt5nDyMSfALMvbmASUkkoRIMFojS3wtbr81V6VuX6JEFv3S5jhgur44vQnlNWPdHdGwbf479vx6m9WYwIVC02EjKMjUrdrGG8Jt/XHmbPvq0TwYzC//hs5nNKjL+tEV4pF2xDr5xB6exAUUF1kQKh9i7/arslmi70fao1NiGPttnsc+WpqMCbJyyRn5gxdp0B+3c3oZhqeLtsVS5wWWDt822ulRaspapShbDQp4EQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by SA1PR11MB7014.namprd11.prod.outlook.com (2603:10b6:806:2b9::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Mon, 21 Jul
 2025 23:51:13 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3%5]) with mapi id 15.20.8943.029; Mon, 21 Jul 2025
 23:51:13 +0000
Message-ID: <1d18f7dc-eca5-4daa-98fb-5c8d20ef6ac4@intel.com>
Date: Mon, 21 Jul 2025 16:51:10 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: mana: Use page pool fragments for RX buffers instead
 of full pages to improve memory efficiency and throughput.
To: Dipayaan Roy <dipayanroy@linux.microsoft.com>, <kuba@kernel.org>,
	<kys@microsoft.com>, <haiyangz@microsoft.com>, <wei.liu@kernel.org>,
	<decui@microsoft.com>, <andrew+netdev@lunn.ch>, <davem@davemloft.net>,
	<edumazet@google.com>, <pabeni@redhat.com>, <longli@microsoft.com>,
	<kotaranov@microsoft.com>, <horms@kernel.org>, <ast@kernel.org>,
	<daniel@iogearbox.net>, <hawk@kernel.org>, <john.fastabend@gmail.com>,
	<sdf@fomichev.me>, <lorenzo@kernel.org>, <michal.kubiak@intel.com>,
	<ernis@linux.microsoft.com>, <shradhagupta@linux.microsoft.com>,
	<shirazsaleem@microsoft.com>, <rosenp@gmail.com>, <netdev@vger.kernel.org>,
	<linux-hyperv@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<bpf@vger.kernel.org>, <ssengar@linux.microsoft.com>
References: <20250721101417.GA18873@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
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
In-Reply-To: <20250721101417.GA18873@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="------------ht5Je7QdfBQqMDmyQ3IuRgpB"
X-ClientProxiedBy: MW4PR04CA0280.namprd04.prod.outlook.com
 (2603:10b6:303:89::15) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|SA1PR11MB7014:EE_
X-MS-Office365-Filtering-Correlation-Id: 814952b3-7f1b-4116-79f8-08ddc8b17976
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024|921020;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eENySWRZOG8wWlZXeFh1bFRhUU5ZYndwelAyVVZaWm9uREVOaUVuZlRxT29N?=
 =?utf-8?B?b2ZIRC9hNGp6UDRONDJ5U0NWamdSNFhmeWxxamhXN1R3cjV1QjBSYzdQYzQx?=
 =?utf-8?B?RFZJUG1XNzFOUnNEMkkvOGY1MnJyQlg1UUF6ZURFRG96b05yNmkzT2F2YUlr?=
 =?utf-8?B?UStGOVo5ajM4MldBa2cwbzRNa25mRWJPbHRPMXYreW5sbjhZeWN0WEJ2cWpO?=
 =?utf-8?B?M0dna0RKTHlWNUxLcG9sQTRYV3pIdmtCejVTNE1GRDJLV3hubmUxSjdJUHgz?=
 =?utf-8?B?cFpRdDBBRjZDdUJ3cTViRFVGN3llS2h1QTdET3JzdWFJS05PeHE0c3hHYWpw?=
 =?utf-8?B?UmpZeGdGbExEMGRGWFZrQzdFMFVsOStuQ1Z0MXExeEdYUDYvL3RXUU9yNUwx?=
 =?utf-8?B?V0F6OWxNMUMrV3Y4NUxDdTBGSVZkTUZpNGZoaW5VMlBIZ1U2M2VPZnI5V3pH?=
 =?utf-8?B?NmU2bFprMjZGbnE0SkdFZ2w4TU55YXZrY1pJcXF1a2lZd3R4RGJSVVVqNHpB?=
 =?utf-8?B?bWo3OEJ3c3I4YmoycW9rSU00b2ovc0JNUFl1d0s2U2k1MWV1S1VTNHJ2QmVk?=
 =?utf-8?B?YU1FMVRxTHlFMVhyb1AwZ05mZWkrVXV1VXF1QVRaZ0QvbUl4UmpzMkVBWEpj?=
 =?utf-8?B?ZFhRMFJNcmdoRTBxV3FsYUZ3UjRsb1gzQnQ5NnVNZXZlbkZnVGxWUjJ0Tkc4?=
 =?utf-8?B?V3hWR0dYQUtZM0JMczBhYnplcjVJaUJWd3pmQjlEd3hGTlY1Wis5N2ZGcldE?=
 =?utf-8?B?N0g4WUw5NkRacnBHVW9tTTJDOEFwTkYwVmtpV2x4aThvNVBJVnZXTk1KbU9N?=
 =?utf-8?B?Q1ptWlZpa0RRNXowaHlkRkIzQUZrbkFYb1BTZmVxR3ZmM2dLM3p2QllwZ3Mw?=
 =?utf-8?B?MjdqcCtMYmRZZy9vOWVTa09USE9mcHhHN1JFcHN6ZllGSDIwL0tMK0FQcjRY?=
 =?utf-8?B?UnFFMWViaXVaM2djWkpoMWhxUDE0Y00rcWljb3JQa25xNG14bFhEY2h2YWNG?=
 =?utf-8?B?cGdLeUlNeGRQd1V5QTg4cWNacTFlVTFoQ2gvN3hzT3QybVJGd1pYRFl4MHBt?=
 =?utf-8?B?NGFmQkdqTTJrWHRvVnN5eVZnUGIrTHlZS3pNQnVLQlJKTnJ1cng1K0VKcUha?=
 =?utf-8?B?dy9kWkkrL29TU250TVR6SGN6eW9GcnRwOTBuNW1KRVhkMHIxNG9vTkJGNHZF?=
 =?utf-8?B?YWJaRG9MbkNqTVcyWjBrU0RpOGRISkhBdmQ5Mm9TZU9qM21mZjZRaFlYaDE4?=
 =?utf-8?B?SGZTQk9OZ2pmMWhnRXBOQkwzNmZiSnVxbkNVRTdaV0tMM054KzBwN2pCS0d5?=
 =?utf-8?B?THNmK09OR2ZZUU5aemQvOXZsUkFNMnhPRnM4NkYrQ3FSWmIySDZ0dkJVdmpz?=
 =?utf-8?B?Tk9VWUJpTTVlenpraWpLT3AvZ2Vtd1JaWHVLMHJqTGdpV05LTGlDUXBQdk1F?=
 =?utf-8?B?Z3A1K1R3ZEVNelAvSSs1bGRycngvSEtENWZLclQwWXpQcE45V2tvTUIyclh6?=
 =?utf-8?B?QWgrZVZWWXAwd2k5cjZEWVZzVUl2SENhbWthSEp5dVoxNFFqMFRkTUZ0M0pD?=
 =?utf-8?B?ZlhBZy9hOHlYTTZ2SDlYbXJrOEtmbXQzOWJrbkFOK01XUTM0V2VHeHpHdkxF?=
 =?utf-8?B?UWt1dmRVbmJxdzJaNWI3Z2dmTXZMVHNlZUttNGk1YUZTb0YyUXFjb0JibGV0?=
 =?utf-8?B?aHRWcXl0dEN2alU1VjR1c2dzT05NUGtZNkVDMXNVU2pmTUsvNUh1ckpNZzNW?=
 =?utf-8?B?Y0oxdWIrRTgyTXNtK20rRnl4Ri85d2VzcUlvZTk3K2dzNVR3cEwra1RNYTRm?=
 =?utf-8?B?T3piTUN5QWNvbVZNTzNGakkxUEJpa1diRGh2SHlBNEpRREJueG9waE1RN2F6?=
 =?utf-8?B?U2NuUlNZcWJReFBwdnVpRmpIQkEvQWJiUUhONktRcjRKdzgzZ29uemVBSHRV?=
 =?utf-8?B?WWxSdGplamF2TVRZcmRPM0JZRm1KQm1teXB5bEJmQnhHQVpKUjdLUmhGM2VU?=
 =?utf-8?B?UVBkSWI4b3d3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MmlqWVNOQzNUVHQ1aGxOZXNRbW1zSXM0cUNBejQ4TFBmQzZZMmFBRzBnZ0lq?=
 =?utf-8?B?OHl1M3pVVGhxcXdJQjd3aHU4cHdjTURHTmV0bFJ2RXU0RGNjVUtGdk52TUlI?=
 =?utf-8?B?V2wybkpLVHZMRXBIS1ZnRnJiTXd2WkVVNXVaZm10VHVCWUtXalI4ajVRNW1K?=
 =?utf-8?B?R01QVk1HYVZrdmFFTDVqYjFxdm5kT3JONXJ1UHJDbkNnbTZCTjdZMXdOcFll?=
 =?utf-8?B?Q05CNHBjMGtGMzcrSURvanVjLzVNazFheEhFT0VtMHFtb1kxcnRiWHFDUE1u?=
 =?utf-8?B?dGlzaE9RdmVVMnU2UDltNEt2UVVEVEtxYWZaLzRjbkhjR1dQUWpMODFuNW5V?=
 =?utf-8?B?Mm5JNDFMN01TS2Q2YUJJaTFwRUtkUDdJNi9XZVVMV2dvVkk1amZhVzJUU2t4?=
 =?utf-8?B?dU9WeC9zU1psRkc2ZzJTQlVqT24zTE5CMUgrbXdOOERPTXM0eGpXMUN6WlNp?=
 =?utf-8?B?MDg1KzV0RkJkVWlVcllib0NkUHVuNmh1Qis5YVBpZWhkWlZWNjRIeHRBWHRv?=
 =?utf-8?B?NDBzZUFJODREY3JEKzVjZG44aTlZNEpUdjNHb25YQmZUQXJlelZnQjlDU0hm?=
 =?utf-8?B?UmlscWlDNEYyN3RZOFRXVFk0VDNJRmpBcHk2N3NEb0o2OFZwSnFJWkF1NVh0?=
 =?utf-8?B?VXJNRjhmNlRER29wOTc5d2hrNTZvQXhJOFlzMTlOaVVOWFZFYlRWcnpYc0hL?=
 =?utf-8?B?dEpZblJReW9pYTZjUU93ZGoxNjhpczFIL0dkKys3TUszTDlLRnVlcTM1eEcr?=
 =?utf-8?B?WlRKcERER0dCTDRvUDFvc0w1ZEpxeXpQcG1sTDZRdXFmSkpKOEh6djZtYVl1?=
 =?utf-8?B?OXd2Ull2R0xrQStlT0J1b1ZvNnBIUjZiOTdJSWV6Z3ZSRGZ0Q1FCeExZTnAx?=
 =?utf-8?B?V3dVVWgwaEkwNm1Eb2lMcC9BUncyTVFCMGtGamVnc0hXZjJabURCU29RTTJF?=
 =?utf-8?B?SVVBMXFrbS9mZXMxQkFOdVUweWgxU0tobG1qMnFMK0I5TGdlWjFmS2V5V0Ew?=
 =?utf-8?B?bU1zbFF2SzRFT0pTaXoxY3pZcHNKVG0xSkhraUFHeVhQams2akIxY3E0WFUr?=
 =?utf-8?B?a2FpYTRQeUY3OE9QSkI1djErMVlacWV2Q21IK0ZoU2VrL3d1UmdSTlIzaE1n?=
 =?utf-8?B?aGoyZlA4eDVXa2VFRnFEWGJ3ZjhJVmpxZ25YV0hqcm1zZ0gvbnhGdXZoVVJU?=
 =?utf-8?B?QW9Nc1hKN1VZRFViNDRVWEpmTGVHRk1vckZTRS9CeUQ5U0w5SGJtbE92bkcy?=
 =?utf-8?B?WnZsRjMwWGxsVnQ5V2RPZ3hrYU1qTDNHcWRtVTRaQnVaWndCeTBLcXEybFVM?=
 =?utf-8?B?bU8wN3cwTGplT0Y2VHpQVEZDUjdTQXJJUmhpKzBibTEvdnd4UUhyM014bFVB?=
 =?utf-8?B?eTZZbHNGb2M2UHdYNDV5dnJuWE5tTTE3QnhNVERleUM2WlE1enJKUUFERzhY?=
 =?utf-8?B?ak9PaTJWeVJsTEtYT0dtRVlOQTdvK2lKN0tlcnBiTHdoaDB1bG9rZHNSVjJE?=
 =?utf-8?B?aUxaRi95TzlOazRhMXp2eWhEWFdCK3pMOGtERWoyU0VpYVdjSW9YMFlheTBm?=
 =?utf-8?B?eCtvMnNoZ0RkamxEcnI3REJQT01uU2daRnFBd3pwMlo3Yjh1RjE4YjJIOUF0?=
 =?utf-8?B?YWpENGN4ZElYWnVoUmJGdGU3QXRKS2hCK2ZqVUFWSkFoZUJxM2xxOUxwT2xX?=
 =?utf-8?B?Z3FNRm95aDhOQWxKMjNxSE9aNnlKQVpOME1NbUpES1dtNmo0TFp5aXZRb0Zl?=
 =?utf-8?B?TDM5Y3Y2V2NDdFlSM0VnRm9VZWIzK1ZHRlU2ekhBYjBWMEFhZWl3QXE5emVH?=
 =?utf-8?B?QnR6elNpMElWa3g4NTBEY1Z1MmhPbWFQbUpYeUVuVDduaEVBRE9QeXhsZjFU?=
 =?utf-8?B?TjgvYWZZTGltdVY4UWd6RFMwVzdBZjBEM1FQWE5mZ2NyWldjMGxvbHpPNis0?=
 =?utf-8?B?NTJQVDRSWElObUtlZW1tdHhrZWw2VmF4dGFTcnV4RmtKOFF6V3ZuV0F6eU1y?=
 =?utf-8?B?K3pncFR3RjlTcEQyRzJqZWdyYnFtdGZwTU1LWmo1K0prZ0F3d3RMTk94VGho?=
 =?utf-8?B?VE5RQklYZkpvdXRlVG9MNFJOdkx0STd1QlZvVzJzanFPRy9vb0R2SG5QV1RY?=
 =?utf-8?B?bWQvMHJ0akxOcUc1MUJGRDNqQzgrcnNVNDN5aTRBa0xjVG82d0tUcnV1VUpQ?=
 =?utf-8?B?dHc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 814952b3-7f1b-4116-79f8-08ddc8b17976
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2025 23:51:13.0715
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m2z6FDnGhq4y7ZSE9GKP3hsffbJp5DDO3A3w2d8XMq1bkq+twAVrDENTkyn6HcdTpqfjcS6zBfPMYAKgJ/LsqvfDUJ8lZFQ9YSDDFRCVd88=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB7014
X-OriginatorOrg: intel.com

--------------ht5Je7QdfBQqMDmyQ3IuRgpB
Content-Type: multipart/mixed; boundary="------------XzjO60PxPt9VD5taCEBSU0Fl";
 protected-headers="v1"
From: Jacob Keller <jacob.e.keller@intel.com>
To: Dipayaan Roy <dipayanroy@linux.microsoft.com>, kuba@kernel.org,
 kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, longli@microsoft.com,
 kotaranov@microsoft.com, horms@kernel.org, ast@kernel.org,
 daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com,
 sdf@fomichev.me, lorenzo@kernel.org, michal.kubiak@intel.com,
 ernis@linux.microsoft.com, shradhagupta@linux.microsoft.com,
 shirazsaleem@microsoft.com, rosenp@gmail.com, netdev@vger.kernel.org,
 linux-hyperv@vger.kernel.org, linux-rdma@vger.kernel.org,
 bpf@vger.kernel.org, ssengar@linux.microsoft.com
Message-ID: <1d18f7dc-eca5-4daa-98fb-5c8d20ef6ac4@intel.com>
Subject: Re: [PATCH] net: mana: Use page pool fragments for RX buffers instead
 of full pages to improve memory efficiency and throughput.
References: <20250721101417.GA18873@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
In-Reply-To: <20250721101417.GA18873@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>

--------------XzjO60PxPt9VD5taCEBSU0Fl
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable



On 7/21/2025 3:14 AM, Dipayaan Roy wrote:
> This patch enhances RX buffer handling in the mana driver by allocating=

> pages from a page pool and slicing them into MTU-sized fragments, rathe=
r
> than dedicating a full page per packet. This approach is especially
> beneficial on systems with 64KB page sizes.
>=20
> Key improvements:
>=20
> - Proper integration of page pool for RX buffer allocations.
> - MTU-sized buffer slicing to improve memory utilization.
> - Reduce overall per Rx queue memory footprint.
> - Automatic fallback to full-page buffers when:
>    * Jumbo frames are enabled (MTU > PAGE_SIZE / 2).
>    * The XDP path is active, to avoid complexities with fragment reuse.=

> - Removal of redundant pre-allocated RX buffers used in scenarios like =
MTU
>   changes, ensuring consistency in RX buffer allocation.
>=20
> Testing on VMs with 64KB pages shows around 200% throughput improvement=
=2E
> Memory efficiency is significantly improved due to reduced wastage in p=
age
> allocations. Example: We are now able to fit 35 Rx buffers in a single =
64KB
> page for MTU size of 1500, instead of 1 Rx buffer per page previously.
>=20
Nice to see such improvements while also reducing the overall driver
code footprint!

Do you happen to have numbers on some of the smaller page sizes? I'm not
sure how common 64KB is, but it seems like this would still be quite
beneficial even if you had 4K or 8K pages when operating at 1500 MTU.

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

--------------XzjO60PxPt9VD5taCEBSU0Fl--

--------------ht5Je7QdfBQqMDmyQ3IuRgpB
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQQgQFSp1zOQVirsQx5qll0+bw8o6AUCaH7SbgUDAAAAAAAKCRBqll0+bw8o6KIG
AP42zuC/hMENxg7MySsz8Kx+hYWAvOF1bMA27wNWD61qGwD+Kd2nrD+02Y9Tp2usKPN38Glndy09
t+3+x1RVa0inmw0=
=q9f3
-----END PGP SIGNATURE-----

--------------ht5Je7QdfBQqMDmyQ3IuRgpB--

