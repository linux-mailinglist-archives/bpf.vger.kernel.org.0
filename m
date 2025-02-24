Return-Path: <bpf+bounces-52364-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FCAEA42390
	for <lists+bpf@lfdr.de>; Mon, 24 Feb 2025 15:45:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BE4D87A2CA3
	for <lists+bpf@lfdr.de>; Mon, 24 Feb 2025 14:44:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34B7315C140;
	Mon, 24 Feb 2025 14:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="G/NYhdTQ"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5E8514A62A;
	Mon, 24 Feb 2025 14:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740408253; cv=fail; b=WQrH0WV+Xgu88XV4VD7nNgmu1acZwFBy9wIhNQGRXnrvjdPzrISRx8IbJh9/c1MREEEkDILz6xZzAaP+tIqpERqOZhsO6Q5syFtlV+HXdkuAIQy4D8mq2K9f/NjM4rWINwS8PRz76EtkSrBM5IqeCLF5AnjhonshW2guZwz7GwM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740408253; c=relaxed/simple;
	bh=vJaJyTdY3K+3uLuNFe81T7fxhK4lfxCBgUC3kQUZGBA=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ZqMMZpK1LkJ3UGVUzjBPwkvlpYICs3qPW+4Dr48bWpnoKLCpTfq9CB5yFdgmItzSpxdG4AGk55WDSKDt1pLXzbfL3UptEJVlZ7RM8qZMd/Vpbo9R86Vuo4qNhroSDqssdNcCH9IY8BYhsqefEjle8TNGqys5lRiHKxe8DlgxZPA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=G/NYhdTQ; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740408252; x=1771944252;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=vJaJyTdY3K+3uLuNFe81T7fxhK4lfxCBgUC3kQUZGBA=;
  b=G/NYhdTQ5wMURM1lPbXGq2tdoeaZsge+hS4oh5ND2fHunQGwcSO8CdC4
   wg1GUaaSkkH1cEyB5Mqsyn8pCmQmKb5qURuKxgvS1Kikc0mH0nN62Tokf
   OsGli/m6zlyVv4rFspzW+Uax+bli8b9X0Feppd2Vn24S0HBISLJJFLQH6
   rdxu2NG+J0jI6mE3yYfOfRjgb99Dv6+eaUfrcX6OAW3lsHBXzbYNIYCCL
   +JRAwsp+nLH6l9gOmrdHGe3MciHvzcbI0hzCaeg6pwerCCL3+D+MCZ2C8
   UTfhaKajKc7On+FTBTXset4yanR7TFEjw6CB+m5DjLLDEC9hMR7h6pjZh
   A==;
X-CSE-ConnectionGUID: 0ozYHtogTNKfdEaMaiXWdQ==
X-CSE-MsgGUID: qKeCD6ZbSRGr93k8plV8Sg==
X-IronPort-AV: E=McAfee;i="6700,10204,11355"; a="45072082"
X-IronPort-AV: E=Sophos;i="6.13,309,1732608000"; 
   d="scan'208";a="45072082"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2025 06:44:11 -0800
X-CSE-ConnectionGUID: 5EJZ5YUvSY2cYrkgkRp8Tw==
X-CSE-MsgGUID: pSLwCKNgR5K1opP3DDjCtw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,309,1732608000"; 
   d="scan'208";a="121171356"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 24 Feb 2025 06:44:10 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 24 Feb 2025 06:44:09 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Mon, 24 Feb 2025 06:44:09 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.46) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 24 Feb 2025 06:44:07 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vN3cH12qcy1m6NS97EylSfXrT6mS42jd8Y7DpxI/xDkbtelBU7ffJcowDo7U4o53cL4F4eUA5q5qvqO78OCuNpLiY0wQz5J30joaD1tTrqbSam0Ky0DK9xzDtcOe4VVkk/BmxaS3qgCzN2TimI32IEu7/Q8EbLQMKpC7m6kjtQPEwbNjd3NC66K5IRFRXwSHW//3bFU59/OfzAn56PoTFjy0CblZlZgkdYzA3IvDHwFCtp0kDvlMA4Vx9BZM5geoKSfrujG5Y9bv1CK1CO4BWsoDeu6wylo1YsToFgxIzEgOnngMOYHqEUx3qPT8KhKj/m079FggNTUqsKicWXErFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eiB7csBYqiY+vNDqPYtaYmSKQVMVt/hn85ACZN5Qsr4=;
 b=nPGnrP40mncd4U2VU3MCdGEO71S7NHjt1/aQpIle31N6Fgl4foz9U26V+qJYYsLrQBKuk4a3dGlCrkeOf3sXgz4PpkZT8BSvr5jHZT8j5qbAyt6rCuikROLrC1OldxCLSoJ9BkDF9hYaMtfh+3Db3MQCkhWOHFPTSlWWBIah6uQ701ThUHOmT/akNE7NKpOfAQ5ph5cKNJAIFVZwfm+r4gBMoQdihKvhdH2z74JkrsseqmmHOrCIJ/NcphVOl/32A+lNQbIJ8XKVXsAo4iB2n1Hylw5YkXXu4URIpAjGHhPTzpiWhWKswkUsBATEW7sgh94KN5HgHK7w8W/VgjGO1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6139.namprd11.prod.outlook.com (2603:10b6:930:29::17)
 by PH7PR11MB8454.namprd11.prod.outlook.com (2603:10b6:510:30c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.18; Mon, 24 Feb
 2025 14:43:51 +0000
Received: from CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::7141:316f:77a0:9c44]) by CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::7141:316f:77a0:9c44%3]) with mapi id 15.20.8466.016; Mon, 24 Feb 2025
 14:43:51 +0000
Date: Mon, 24 Feb 2025 08:43:45 -0600
From: Lucas De Marchi <lucas.demarchi@intel.com>
To: Daniel Gomez <da.gomez@kernel.org>
CC: Luis Chamberlain <mcgrof@kernel.org>, Alexei Starovoitov
	<alexei.starovoitov@gmail.com>, Daniel Gomez <da.gomez@samsung.com>, "Petr
 Pavlu" <petr.pavlu@suse.com>, Sami Tolvanen <samitolvanen@google.com>,
	"Alexei Starovoitov" <ast@kernel.org>, Daniel Borkmann
	<daniel@iogearbox.net>, "Andrii Nakryiko" <andrii@kernel.org>, Martin KaFai
 Lau <martin.lau@linux.dev>, "Eduard Zingerman" <eddyz87@gmail.com>, Song Liu
	<song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, John Fastabend
	<john.fastabend@gmail.com>, "KP Singh" <kpsingh@kernel.org>, Stanislav
 Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa
	<jolsa@kernel.org>, Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers
	<ndesaulniers@google.com>, "Bill Wendling" <morbo@google.com>, Justin Stitt
	<justinstitt@google.com>, <linux-modules@vger.kernel.org>, LKML
	<linux-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>, clang-built-linux
	<llvm@lists.linux.dev>, iovisor-dev <iovisor-dev@lists.iovisor.org>,
	<gost.dev@samsung.com>
Subject: Re: [PATCH 2/2] moderr: add module error injection tool
Message-ID: <ccofyygi4rerybdmecqswldykihtabx6yco7ztylqnbmw4a5qw@ye7zoq7mcol2>
References: <CGME20250122131159eucas1p17693e311a9b7674288eb3c34014b6f2c@eucas1p1.samsung.com>
 <20250122-modules-error-injection-v1-0-910590a04fd5@samsung.com>
 <20250122-modules-error-injection-v1-2-910590a04fd5@samsung.com>
 <CAADnVQJ8tYSx-ujszq54m2XyecoJUgQZ6HQheTrohhfQS6Y9sQ@mail.gmail.com>
 <Z5lEoUxV4fBzKf4i@bombadil.infradead.org>
 <qnfhjhyqlagmrmk3dwfb2ay37ihi6dlkzs67bzxpu7izz6wqc5@aiohaxlgzx5r>
 <Z7je7Kryipdq6AV4@bombadil.infradead.org>
 <4xh2oviqumypm4r7jch25af5jtesof7wnejqybncuopayq6yiq@skayuieidaq7>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4xh2oviqumypm4r7jch25af5jtesof7wnejqybncuopayq6yiq@skayuieidaq7>
X-ClientProxiedBy: MW4PR03CA0148.namprd03.prod.outlook.com
 (2603:10b6:303:8c::33) To CY5PR11MB6139.namprd11.prod.outlook.com
 (2603:10b6:930:29::17)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6139:EE_|PH7PR11MB8454:EE_
X-MS-Office365-Filtering-Correlation-Id: e15b3131-044d-4a92-18a2-08dd54e1a794
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OVVmM09uL1dXQnRkZnNxZmhYQ2xnTGp6c3luWThvUHlYN0E0a1NRMFp5aXZ0?=
 =?utf-8?B?Nm1FRS9kQTNzbGJuREVsRFVGWGhmQTBNWHBUUU9TQWVQVjlkc3l0UlBiMkZH?=
 =?utf-8?B?bjc0bHhTWkdmbUs2VDFqRWg3T2FpNEVmWGNzVnNEK2JlMHU0UkRRU2l4ZmJ6?=
 =?utf-8?B?MitnV3JqTU5BU3hCWWllOGtrL2NQWGtEWFF2ZEpqKzdpMXNrd3VPZWRXWXcv?=
 =?utf-8?B?TzB3RC9aOVVDTXJOTHk0bUhNV0hHSEszS2w3ZmUwZmhLQ2dEVVhLRUFTV0Yy?=
 =?utf-8?B?bWdyWjhqOG9IbFYvZjVzU1Y2RVF0VzVSdW1tZ0M0Q3dCUGN5NnNFSzNScnlR?=
 =?utf-8?B?ekhvQksyWUg3N2FGRlEyZXkyQzRSK1BTRm1TMm52Z1pPaGhPVjlhbURQRjZp?=
 =?utf-8?B?K3lraDFoK1RhNVpIcFZVNXFIODFKaVlJeTFVWlptMjBsTjNHU1Z6UWYzY2tu?=
 =?utf-8?B?WW1LWXplaXpzM0Y3OVVEa1dQY28zVG1pNS9PZ21aSW5Ody84aWRBeHFiMmpr?=
 =?utf-8?B?clErdHRqTURoMmUwUjE0Q283emFTZGN2L3QyLzNKSUdFajRJWGRIOXNmdE1l?=
 =?utf-8?B?Z2FLSTJpMjZDeHV1TmtZVU9OOFQrN3dSN2RnZFF0cnljMnVMKzlsc1ZMTGtN?=
 =?utf-8?B?VFErVWg4MEIzckJwQkY4TE40SWc1VEZ0SmdLQmMrNFVnZDg0QmZNaHBISHNW?=
 =?utf-8?B?bjJpS1gzeUk5N1E5M1U4clhJZWllWWtVenVmSFFpaENNTnpBZVlNdnppL0w4?=
 =?utf-8?B?UzZ3b2RRWnUxOUJwVVpnb2QvWHRnNUJuM2N2RkhubEtuOUpwcndnTTVVck0w?=
 =?utf-8?B?QnRoZGUvdGZDemdPN2VDTmQ0M1ArSURWOEl4MkdFUjlqRDEvTllSM3I4b0Ru?=
 =?utf-8?B?aUJSc0xHLzU1dFdnZGNrVTNuemJFcStrT1pHL0VXQ2l5bEdaRFYxYnZSMFZH?=
 =?utf-8?B?QXZVN3daeEFNbHhiRXZHMFVKRzhJTWtpMmRMOUlEUlptblhqa0xYUUFkRjho?=
 =?utf-8?B?bXJLU3NvTXZtN3VVelBEWmVFTUV0U0hCL1VtMDZHTyt2cEhWUFBNbmZuUmlo?=
 =?utf-8?B?bXdkR0gwZ0dVbUNkVHN0ZjBvdWhUeDdqZ3hyOXRtQWtvMHhWeU11MWZmQlhl?=
 =?utf-8?B?OUlPUGFiZ3ZqRVF1UjgxTzhmaS94b24yekRWT1lBY1ZYQVlOeW5tdkE2TGFY?=
 =?utf-8?B?dzdZNXE4eXBzNlBYOWZVSXhiZktLQVNEUlhWb3FqUUI1YnhNY3hvVkhOaldJ?=
 =?utf-8?B?ODZvY3RnYTJBZkIxQ1BWeDNnenE4WVptUkpDcStsbWdwVWVnQTFJcTRmV1Z2?=
 =?utf-8?B?OGo4K3BEU3FoaXM1UkxtSm42dFgxSTNJa24rckFsTmptbTVmYkZsbmRqWm9N?=
 =?utf-8?B?L3oyeEc2NzJDVUJNQWhpUDI0bWpOdWtPRjVmUE1qTTV4NURqb3hIVEcxTlBm?=
 =?utf-8?B?eTVrWXkyWDNRdzJhNW05b2daYmlBcDMrbHRSMHhmRlJaS0JjRUltZC8xelhM?=
 =?utf-8?B?czk3a2F1UXRxbWk1MXhCQ2hnakp2bkhaZk9TRnZsU3ZJMHFWNTIzSWhDSzdq?=
 =?utf-8?B?c0tiWjJaYjIzMnZhRXl3TFZ5eWFPLzJvdUhucGhDMjZrNkxWNWJCb25ML3VG?=
 =?utf-8?B?R05VczFoK2ZKeEFDYWxGd1IvR1Q0MGh4a1VQWm9ZRUNCNlVidVVDanRVM0o5?=
 =?utf-8?B?Zm1GUE9KbXRmMGtDeXNYVDBoWTRUTHY0emlPZTlWVEx1Sk5sNVR6ODFuQlNG?=
 =?utf-8?B?UmhXajBIUGN5VzhuUFE1WXlINzlyZmhkZjRrejA1ZVZBYStlUGlYYTNYcjlD?=
 =?utf-8?B?bXJZMUVFUGxuNUh5YS9Gdz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6139.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bGdPeEMvV2pCYWFaZUFGclhiMXVFdzZwRDNwVWxWRG5BNWRwZER2ZWRCSjNz?=
 =?utf-8?B?aG12azZJcEMyd1JXTTJFN0g4N1NHeDNKUjFRdlJnK1IyYWhmbTNUL0h6REEy?=
 =?utf-8?B?MkEyQXFJa2VaRjN0UWR5WG1TQVdUTG1yeHRBd2IwS1ZIZFBjajdwL09qdFJo?=
 =?utf-8?B?WGVlSnB1MWx5QStBYzdUNitSaitrTFNrOUdRT0JRWmVCT3lYcVovMitYcWtL?=
 =?utf-8?B?eDN0SlJ5bEZzSUlBY0s5dXZJaWNyT0FsbGc3L3hTTk4vZ3pUYm5sUW9jdEQw?=
 =?utf-8?B?bkNCVEEwRTJoTm9FWEtjZmdFd05SZHpHMDNaWGxlMXFLOGxjMkh4eWNQVVpR?=
 =?utf-8?B?b1ViOW9lVkUrVGtaak9MY3VsN250MVMrZlpYK1VnMlpBVVRNTFdRMFFPckVs?=
 =?utf-8?B?QU10T1lRZnc5YzIraG52VmlhM1h1N0M2TmYwRm1LZHNweHR1b2NtUGJrUmlw?=
 =?utf-8?B?R1dDUmJFTjNpaU5MSmRVL3B3T3p0eHNJRlovNS9ZcjlLQ0NzZnRERCtJN1dE?=
 =?utf-8?B?ZlhYcjJVcjM3WmdRbmM2eHE1QllvaC9QRlZIclZnVWNqNiszb1JucmN5Uk54?=
 =?utf-8?B?QkEvVU1MMHJhcEprRVJLWnZvd3htci9HUDYxT2x5ZEprR1JoNmN4WnNKSjFM?=
 =?utf-8?B?YWwrdndhNTVQZWtoWHZka29qQ1p0WFBrK2RVZEZ5T3o3VkMvSGdXbkNpRmNk?=
 =?utf-8?B?alRqOXQ1M2lzdWk1M29Ubm05RUplYzFTZTZyaDFFcmNFOVB6NUVIUHlsTVFE?=
 =?utf-8?B?Z1VBMzJLK0VBRTR4dGpUNTd3Wm16UkRQb1BJcEV2dWV2VXBTdEVEaXZ5aFRW?=
 =?utf-8?B?ZkRWTG9XS3U2MGxuTTJKaU1tNy9PQzVLNWk3VTZVV0N5UVAzTGtoWmlLa0FF?=
 =?utf-8?B?QUh3eDA1aWVPLzdwMWk5WUNGSWxqTU8wQWExSldzUDJRWHZiZ21wRksyLzEv?=
 =?utf-8?B?ait1cHhwYmx0bXFRVTI0L2w0eFpzaWNCOXAxazFMMkphUWtSY1U5UzRDaHNl?=
 =?utf-8?B?NU9xNzhpOTAvS2JZVEtpRzM0bjNVSm9hYnlFendzSnI0dFhZakx6MHZFUmtX?=
 =?utf-8?B?NDRsUXV2dndMbVV5eTl1TlZ1VzlIZWpTU01iNlZyZ1dheVVCb0RiZzFvN0R5?=
 =?utf-8?B?NmJKUGV5VEF1em8rN29FWllOMFJRSHVRekRsV2JRT2I1bXhMR0o2Tmdna3RS?=
 =?utf-8?B?SG53dlVZdWgvZmlYak5GeW5JUGJqaW5XZ1VVL3ZRckJWd3hoWER5S2F1Sm8x?=
 =?utf-8?B?aDYyK1JhYWlXNVpDUkFSMisrMHV4OFBTN1lzMjd0MzV0MTY5VkJhdjdJb1lt?=
 =?utf-8?B?dUZkWE9nTUJwWGxZeU1NTCtuaTcwU3Q2dThVNGt3eUpCOG9TeWhpUGxkZGFV?=
 =?utf-8?B?THdOMVlmYkdaYitFSXpvdkVRK2MzWmQ4dVAzZFZYRmU0LzcyTXpKR1VXY3dM?=
 =?utf-8?B?MGFBS3kraWdCeStXRGU3T1pPUll2emEvaTgvZmNFNVZoZGZ5UnJuUGM2OFdY?=
 =?utf-8?B?eittV1NxQ1B0RnpWdUlUSmJ5cEFFdDczOUQ2blRNcTdIeG8rampwYVNYeHhV?=
 =?utf-8?B?OEFxZkdJZlF0MlFGWjJXMDVaNGhzMTJzZ0VjbGg1czRWeTN4QUgxdlFtQktW?=
 =?utf-8?B?THdxMVlmY0FxYnFPY3QwT1cwQVZoOTF1b3pEVTlpN29XcmZHcE5hd3hqZmFO?=
 =?utf-8?B?NnlKcXRFS2VIUFVyQUdPL1dmTER6MExSRFp1aWx0Um1kSXVDV0Nqd2FGWnZI?=
 =?utf-8?B?R1ZFYVBzR2VJdkluMGtmM2JkNEFzblg5Sklpc2RFYzlsUlJPS2JvVHpNR09v?=
 =?utf-8?B?QXFjNHl4eWg2ZnVKb2tZcFhpTDQrUDRmUkxZNHFpWk8zRFhTYnhlc2JLTWFD?=
 =?utf-8?B?ZlhkeC9rSERiTHA3VnlVd0FTTDllRzd2MVNLQVltRE1ISVNvSUNjT0kwS1hW?=
 =?utf-8?B?ekxGWXplNm02SGdDU2VMVko2WU9Oc2pwalYrUCsrdGNLYlNyVkx0NWJmZk9i?=
 =?utf-8?B?SEYxZkhGZWcwWXZpdS9JQWFUeHIxQlkvZUN2RVdQSlVENVpyMkp2Nk5HNmRm?=
 =?utf-8?B?d2lxbUVqOGVmR3VlMThwOVRrTUNxd3JPRzNoZVlIMDJaNFRvNDJYSnJjYUts?=
 =?utf-8?B?Z293VEhNYXdpYmtiKzNsZDY3UklicjdVS2J4WXd4YzJBTyt0NVd0UFJiQUNC?=
 =?utf-8?B?emc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e15b3131-044d-4a92-18a2-08dd54e1a794
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6139.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2025 14:43:51.5481
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W9D4lXvVXMEiwfrvdiIeAXctEYV+AN8dfAz7v3Dd59IQFFF3iunPC1OxvjrfKr9ukrKxS5gK8Y3vjTR4DlxmqtFeage/gWx/Tny3YUVccNs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8454
X-OriginatorOrg: intel.com

On Sat, Feb 22, 2025 at 10:35:07PM +0100, Daniel Gomez wrote:
>On Fri, Feb 21, 2025 at 12:15:40PM +0100, Luis Chamberlain wrote:
>> On Wed, Feb 19, 2025 at 02:17:48PM -0600, Lucas De Marchi wrote:
>> > On Tue, Jan 28, 2025 at 12:57:05PM -0800, Luis Chamberlain wrote:
>> > > On Wed, Jan 22, 2025 at 09:02:19AM -0800, Alexei Starovoitov wrote:
>> > > > On Wed, Jan 22, 2025 at 5:12 AM Daniel Gomez <da.gomez@samsung.com> wrote:
>> > > > >
>> > > > > Add support for a module error injection tool. The tool
>> > > > > can inject errors in the annotated module kernel functions
>> > > > > such as complete_formation(), do_init_module() and
>> > > > > module_enable_rodata_after_init(). Module name and module function are
>> > > > > required parameters to have control over the error injection.
>> > > > >
>> > > > > Example: Inject error -22 to module_enable_rodata_ro_after_init for
>> > > > > brd module:
>> > > > >
>> > > > > sudo moderr --modname=brd --modfunc=module_enable_rodata_ro_after_init \
>> > > > > --error=-22 --trace
>> > > > > Monitoring module error injection... Hit Ctrl-C to end.
>> > > > > MODULE     ERROR FUNCTION
>> > > > > brd        -22   module_enable_rodata_after_init()
>> > > > >
>> > > > > Kernel messages:
>> > > > > [   89.463690] brd: module loaded
>> > > > > [   89.463855] brd: module_enable_rodata_ro_after_init() returned -22,
>> > > > > ro_after_init data might still be writable
>> > > > >
>> > > > > Signed-off-by: Daniel Gomez <da.gomez@samsung.com>
>> > > > > ---
>> > > > >  tools/bpf/Makefile            |  13 ++-
>> > > > >  tools/bpf/moderr/.gitignore   |   2 +
>> > > > >  tools/bpf/moderr/Makefile     |  95 +++++++++++++++++
>> > > > >  tools/bpf/moderr/moderr.bpf.c | 127 +++++++++++++++++++++++
>> > > > >  tools/bpf/moderr/moderr.c     | 236 ++++++++++++++++++++++++++++++++++++++++++
>> > > > >  tools/bpf/moderr/moderr.h     |  40 +++++++
>> > > > >  6 files changed, 510 insertions(+), 3 deletions(-)
>> > > >
>> > > > The tool looks useful, but we don't add tools to the kernel repo.
>> > > > It has to stay out of tree.
>> > >
>> > > For selftests we do add random tools.
>> > >
>> > > > The value of error injection is not clear to me.
>> > >
>> > > It is of great value, since it deals with corner cases which are
>> > > otherwise hard to reproduce in places which a real error can be
>> > > catostrophic.
>> > >
>> > > > Other places in the kernel use it to test paths in the kernel
>> > > > that are difficult to do otherwise.
>> > >
>> > > Right.
>> > >
>> > > > These 3 functions don't seem to be in this category.
>> > >
>> > > That's the key here we should focus on. The problem is when a maintainer
>> > > *does* agree that adding an error injection entry is useful for testing,
>> > > and we have a developer willing to do the work to help test / validate
>> > > it. In this case, this error case is rare but we do want to strive to
>> > > test this as we ramp up and extend our modules selftests.
>> > >
>> > > Then there is the aspect of how to mitigate how instrusive code changes
>> > > to allow error injection are. In 2021 we evaluated the prospect of error
>> > > injection in-kernel long ago for other areas like the block layer for
>> > > add_disk() failures [0] but the minimal interface to enable this from
>> > > userspace with debugfs was considered just too intrusive.
>> > >
>> > > This effort tried to evaluate what this could look like with eBPF to
>> > > mitigate the required in-kernel code, and I believe the light weight
>> > > nature of it by just requiring a sprinkle with ALLOW_ERROR_INJECTION()
>> > > suffices to my taste.
>> > >
>> > > So, perhaps the tools aspect can just go in:
>> > >
>> > > tools/testing/selftests/module/
>> >
>> > but why would it be module-specific?
>>
>> Gotta start somewhere.
>>
>> > Based on its current implementation
>> > and discussion about inject.py it seems to be generic enough to be
>> > useful to test any function annotated with ALLOW_ERROR_INJECTION().
>> >
>> > As xe driver maintainer, it may be interesting to use such a tool:
>> >
>> > 	$ git grep ALLOW_ERROR_INJECT -- drivers/gpu/drm/xe | wc -l  	23
>> >
>> > How does this approach compare to writing the function name on debugfs
>> > (the current approach in xe's testsuite)?
>> >
>> > 	fail_function @ https://docs.kernel.org/fault-injection/fault-injection.html#fault-injection-capabilities-infrastructure
>> > 	https://gitlab.freedesktop.org/drm/igt-gpu-tools/-/blob/master/tests/intel/xe_fault_injection.c?ref_type=heads#L108
>> >
>> > If you decide to have the tool to live somewhere else, then kmod repo
>> > could be a candidate.
>>
>> Would we install this upon install target?
>>
>> Danny can decide on this :)
>>
>> > Although I think having it in kernel tree is
>> > simpler maintenance-wise.
>>
>> I think we have at least two users upstream who can make use of it. If
>> we end up going through tools/testing/selftests/module/ first, can't
>> you make use of it later?
>
>What are the features in debugfs required to be useful for xe that we can
>port to an eBPF version? I see from the link provided the use of probability,
>interval, times and space but these are configured to allways trigger the error.
>Is that right?

I don't think we use them... we just set them to "always trigger" and
then create the conditions for that to happen.  But my question still
remains:  what is the benefit of using the bpf approach over writing
these files?

Lucas De Marchi

>
>>
>>   Luis

