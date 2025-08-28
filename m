Return-Path: <bpf+bounces-66835-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CB84B3A41F
	for <lists+bpf@lfdr.de>; Thu, 28 Aug 2025 17:20:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 868B8460DDB
	for <lists+bpf@lfdr.de>; Thu, 28 Aug 2025 15:18:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7818422689C;
	Thu, 28 Aug 2025 15:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lvxWhEP+"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63354226861;
	Thu, 28 Aug 2025 15:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756394248; cv=fail; b=po7Nny+BgMq9Y5YrqJrYG86XtY0cUW344e29Gm+o4Bz7Z50F7qvbYYvNFqrFuziGr8lchb3mLg7LYuMSqCj3Ofqqj6nU/BlSqDQ5+tEych0YQlEJeWa6D421T/kHX+cKZcUWcJbTUb0ZIsCmZZQJdN4pyqXj5Tl2uO3L6gM5Nvk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756394248; c=relaxed/simple;
	bh=vgTIf+ZxaEYkRMbIwZVMXHNB7QM0KEgIuiLUTPzSO+U=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=b9msdCO5EUcO3O1EegVQintZdP2l6GkXoTk2Y1THeORgUCfSupedSoYH1GeowUsQ5S8UlIcSovUq7OOOqe61wBvx8GiWpN+G83alLIj6b9IuGTsFzApJk84DIfw2vcBHaSlpIyNjokHCZ4fCFvYpyZJdp9/mKmFDZILs4Tbv1rc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lvxWhEP+; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756394247; x=1787930247;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=vgTIf+ZxaEYkRMbIwZVMXHNB7QM0KEgIuiLUTPzSO+U=;
  b=lvxWhEP+K2D7DoA4VxxbjV7VA9hkKvNcLLFnR0GClDHx1bqKzeXT8imt
   /E8tIbjjZOk6FQP4yeEN+JYagmVXSS1wrG/qJHODnYxtnRbkGHNa3/vyi
   rmu8/LQUbZwAS8gojqEyKbzQQ5bL5yVwJnzthYt7q4mK93Oo0UVUMV7JH
   RTji7YmGBP4/E3FEAVtw1Pqdoilg38T0auXCRvpxY/Dg6cE+olSSGhqzz
   2g60ijvtVyjLLWplRaX921bTYSfmkXizTOQuQgUJ/jXdSEscmzvfDioKL
   yiN8o21YfoK7HG9pMKSvIn/XgpgmDyAGcDDtKWN6TitSNLqGVa5PB3EHu
   A==;
X-CSE-ConnectionGUID: KfgZrGkYQ0OmnOMPSmUsJw==
X-CSE-MsgGUID: v3MiczM4QLOg0kBkC/kY7Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11536"; a="61300294"
X-IronPort-AV: E=Sophos;i="6.18,217,1751266800"; 
   d="scan'208";a="61300294"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2025 08:17:26 -0700
X-CSE-ConnectionGUID: d6c8pPlISFS9WjmOcivgUA==
X-CSE-MsgGUID: sxffeJx+Sv+S0LY9W0fMtg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,217,1751266800"; 
   d="scan'208";a="193798878"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2025 08:17:25 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 28 Aug 2025 08:17:24 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Thu, 28 Aug 2025 08:17:24 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (40.107.94.71) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 28 Aug 2025 08:17:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TqUeUl8Ry4aYL9jXWCdaEfbTPzpSXhtWWlb5ozSUPwbGOD+BCKo+iX84fSeWgnC9caMbLoKwCDOAG0qwUg5sD0QcSGSLtExk00lkIogSwkPFPDEI4gLZuF5/bzXZpomqnvXVyt37eUoAId+0mhblP2L1ZvPoSB+9eW1Guial6qv5DNhZnOphjsEkbWdORWEf+vH+QQ39aGigloHuGx7PjLNW1GDNP319JLx+aIObOj2rNKaBAcHyfkqluH4Og84GWTglKoIrXuVZiRBICLv3nVnvb3gmWhSwRoaRg67U4quSAQSPL5NR6ono7UOVGlIqUvaJ7qcNfVF7Df6eCEvcmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zlq0EwVzhOBzjgr36iPy07etYdWdXNwg5pw/vc9Y3SA=;
 b=sGePcIpWvDX6r8LHufnlzQlqshQ1/Nm8I6y9GLC/VEgMGHCbZGcv6RwBtUnzNAarsmss0WoO83hmQwPdibzb47PfA3A8cA5Cz3WviroZONsUVXql2kcyTkq/zhLRsSIxOg7ZbuEmNXOmW02JzWnyTEeha4Agm0p58Yu2fjLnaw8CAIATaTPrJRKrX1/wpPJ9x4Xv8jBkcI9KYZqwQgLmitYC+sAEFM+OHDwrxD+aBUEs5uPcugRSjFqXQITZ/pplbmIhS/d/FvnImNaOzGMOc+CaQX9HZccP96vL5EhiBTU7cW65B8iUBK8PwS0GLWSVYHHY4AxBgDa50Vkdd+fTGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by IA4PR11MB9370.namprd11.prod.outlook.com (2603:10b6:208:55c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Thu, 28 Aug
 2025 15:17:17 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808%4]) with mapi id 15.20.9073.017; Thu, 28 Aug 2025
 15:17:17 +0000
Message-ID: <593513fd-ffc6-44fc-9f53-59736e8fb514@intel.com>
Date: Thu, 28 Aug 2025 17:17:10 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-next v5 00/13] idpf: add XDP support
To: Simon Horman <horms@kernel.org>
CC: <intel-wired-lan@lists.osuosl.org>, Michal Kubiak
	<michal.kubiak@intel.com>, Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>, Przemek Kitszel
	<przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Alexei
 Starovoitov" <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
	<nxne.cnse.osdt.itp.upstreaming@intel.com>, <bpf@vger.kernel.org>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20250826155507.2138401-1-aleksander.lobakin@intel.com>
 <20250827172828.GP10519@horms.kernel.org>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <20250827172828.GP10519@horms.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR0102CA0085.eurprd01.prod.exchangelabs.com
 (2603:10a6:803:15::26) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|IA4PR11MB9370:EE_
X-MS-Office365-Filtering-Correlation-Id: 432823ee-d9be-49b0-42b2-08dde645f971
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bGl1RVh1UzJtRkgyQUpVT3I5MHg0RnNZTTRsQlhPREw0OTlPZjQ3NDZQa3RP?=
 =?utf-8?B?YmZ2eXd0VW41Nkw1dURvRURKcUNtNTBZWHF2ZUh4QXROUURNY2lXNlhCZEk3?=
 =?utf-8?B?WnJOZEUwV2IvYVh0cmRiWFJSMCtiSTRhSUZvOWc0dExjbXRNbEF6Q0xJNXpi?=
 =?utf-8?B?eFFnNFR4dlY4UHR2eitNRHhTTkcwSWJpU2Q0U2RWMlNPdVk5UXRLV0Y0ZXAr?=
 =?utf-8?B?YVk4UmJWUFMwSVVXSDBhYzVZb1g1Z2hiWU1iN2tuUWQ1THM4SkdoYlpPcGkx?=
 =?utf-8?B?WTcvUGFPWWN4WEU0RWNhU0czN1JIM2xYa2dYSUh4RzFnYjROdkhBK0FPMkFq?=
 =?utf-8?B?M3M3RkJHVHp2WFI4anc0VkttLzRvc0x5V3NTUVFUMXdMUnJrTzZNT0M5SGlT?=
 =?utf-8?B?T2o0clVzZGQ5c2FuVUlHQnM5T1ROQlQvZ3duZFJoTTdoZ2hCUEFWbE80NGor?=
 =?utf-8?B?R05NVExjTHIwcmJRL0VEaHZHYWExeEtMOWMrTFRNK0Yxb0d3MnkxaHg0TVdm?=
 =?utf-8?B?TDlLVytWZUplUlRvT0Fsakx0cFNUVllMQ1ZHd1VzQ3N4Q2hBa05wMnptL0dh?=
 =?utf-8?B?YUtLb2dodnhaWndjSjJsVXpxOFZMZVczNXJtTTJ3aUV6aE13eW9yeGJEY1ZY?=
 =?utf-8?B?VmwxdkxrdU9hVFRjYUNxaFg5TW9DdUt2TnE1SlJMTzBhTTJyRTlUQlI2dEsz?=
 =?utf-8?B?VGluV0kraGVGeXBZYmk3SDZibXMzL3FiK2xzZFNjcWVGVW5uZWdNQURwcjZV?=
 =?utf-8?B?Y3VmTFBxem9HOFpnSGhyTGp4U2NGSkRuN21NMjhGZzV0K3NKbDVUSWxyNzNK?=
 =?utf-8?B?Q2tKb1RUM2pYODdkam9XamFKZHZWRlVWOGcyem9GQWVjcG9yMzc3NDZkMVZO?=
 =?utf-8?B?K1A1OEtCRmFvVnMwa2ZCWlBidHQvcURLUjlDckc5U3Fud0lJRVArU1VYaUJI?=
 =?utf-8?B?RU92dm53Yi9mS1RMb1RGd0FLWFc0MncvQjE2WFBtemxjUEhESG5LODg1dTZ3?=
 =?utf-8?B?eUZMZVFqa3pOdGRITDdmdDdNU0xjWVVoYVN5ejVRL3BWbmNpYXl2bXozVWxn?=
 =?utf-8?B?N0xUaEdERHVTUm4yVE5DemJ0TlBFemc3aWtzRG5wUmd2MnJ5S2d4VXo5NkI2?=
 =?utf-8?B?N2FLSEllMUFidTFtSG1nNE1DREhDTmJlTytpajNPNno3RWh6YnQ0TUk0L3I1?=
 =?utf-8?B?YzkxN1pwSFBYVkVWR0pQS0xFdGlOdUcrTFdkSVA2VExBVWRyR3FOY0VSeXhx?=
 =?utf-8?B?SUwxc1hJVlVRWFZMRXJVZnF0MW80WDUxeUF2Y09rdmpUWndNck1QMHR4WVkr?=
 =?utf-8?B?bW51aDRkdlVzVnhxWVhWZnBvaUFFZnZRbFpobGZPMkJ1ZmNhVzAybzV4SHpn?=
 =?utf-8?B?SUcwRTRnT0xlWmZrZGFodkNCMkc1RUxSYnhuTWIwQzFYTEoxWWMwUDVsRmZx?=
 =?utf-8?B?d21LcVV3ZHlyU3dCaE9xRmdwbWlhbndzNVNoZWFpMTVmSXZYS2RBT1ZzR2Rq?=
 =?utf-8?B?anJESGF0VDJnbTBERVhpdG93SGxRZUdzcjA4RWVzQUxWSXQ0djRQMlg3VnpS?=
 =?utf-8?B?aDdWUWNJeWRNbWhiKzN1ckZORkxoVDBkY00rOHU3NnJGSlNJek5zajdPUjln?=
 =?utf-8?B?eUVHdUJpdVZTc3FNMGg1dzJvVWVESmZhRU5QNlVXd1hjUlh2Nnh3RXJLa3BB?=
 =?utf-8?B?enk0QUMzdm5RMkpnTDhpVTVocWlZYk1TNGpDMU12bVJYQkdqSlQ0Zno0QWlj?=
 =?utf-8?B?K2IvdWtIME82aGVEdVplUEdtWGZTTUUreEozcUxNVldHVzBvWDhHc1lCcUZm?=
 =?utf-8?B?VTd3bE0xNE9ZNnVDMXIySnpUOUIyOHdzbXVzOWVBVUJ0WWkwdStlQjRPbHQ2?=
 =?utf-8?B?ck9DUHF2MWtMZC9XL3JhV3N4cGY3aUt5bWlQY1o0YjJpcWt5TGc3UnZOcGhp?=
 =?utf-8?Q?PDuOGZv4KDU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R2w4Uy9yS290OU4wQzNkNnRJY2wrSS9RVElXYjVTd0ZQN0Vmcno4a29ENitY?=
 =?utf-8?B?S0QwcFQ5RWZhVUpQclUrQVlKYkJqR2hvUHZITjUzNWFPWEVtOUpDVU5XbW5L?=
 =?utf-8?B?R0Q3WVY2Q0J5Tk1UaTZGcjVPaWVYT3JKZjgzU29sQkRDOWMrbFBmUlVQTVh3?=
 =?utf-8?B?MkJBcGFaanB2TWowSk4vb1pldXlKemViOThtN0RzaVBEV0x2MXF2aWtoVnpn?=
 =?utf-8?B?cVc5Si80cE0xYm81NnpyL1dOMVllZmxlOGpNU2VPellqMldCV0lkVkVWVUJ6?=
 =?utf-8?B?cTdBYjd6QXVoeWx5aWhGdE1sRWp4M1Q4QjdWSTdUZTl1SjJpSHlKbDV1MHcx?=
 =?utf-8?B?S2tPR1B3NzZ5MGRHelF5dkQ3L2JZQTdEd0QyUFFGTm1zdHBHb1Q5bmR2UWow?=
 =?utf-8?B?U3IvRTl6VVlRQlNHV0w3akw1b0JxVFlIZWEzc2dsNWZoak10T0Q4M3Y4M0hC?=
 =?utf-8?B?Yk9XYTBOMW1SL1l4bFJqVnJSUCsvUHAzbUFrUExtVmY3aGsrcDhBcFVycmxX?=
 =?utf-8?B?N2tnM1dKL1VPVmdCaWRqWVFPeE5vSEswWFB5eVlVbXVEQWdzVWw4U1VqM3RT?=
 =?utf-8?B?VWNaN3doclIydVN3TXlKcVNWcWlWMnZwTm5oSzNkOW5DaDhGN2VzMlE0ZVRR?=
 =?utf-8?B?V2Y5clZvbklZUFhuYWtQSGd4MkRwcVZ1d2tHK1hEWkE2KzkxR1FicHNOL1Nk?=
 =?utf-8?B?SDdqUGFscUZEamtIZ0pOR2pCUEZxOGhhM2RzT0ZDaWliM1JTejBFdWo0a1Uv?=
 =?utf-8?B?aUxXSlVsb2ZBd3RLeWlsSG05WFJvaHMvN0NkcVlYU09kUlRGcmZ2ZFlSWHc4?=
 =?utf-8?B?UTFwVzJuYjFBR0x5cHdHVjBnenMrak9KeW9mSkU1NEJpVStsbHlLc2ZqZHNI?=
 =?utf-8?B?VUhBWjR2WVpxS1Z3SzR3dlJBOWl0TVByK3RjRXJFd29UeS9ZQk1zNmtUcGJz?=
 =?utf-8?B?b1lpZmxQZVhpRHp3cVA3VFBianJ3K1YxbXNRaEhCUFo3QjNQbjFNaFF6YzZa?=
 =?utf-8?B?L0FGdGwxQjNJd05oajB1blNpdTFIQmYwcG5VaXNMdEEvc29Pc2VzWVBuSzZv?=
 =?utf-8?B?QmJFZ0xtOWVqYzlkQjZyQU9Dd3V1WDVReVg3Q2Z0ejVGOTBhYjAyQ3JQZXMr?=
 =?utf-8?B?OCt2Rk5Ldzl3NG5PQU8rSm53aWhicE1wRXlycXpBOHhiRWprazJOK2xtSGgz?=
 =?utf-8?B?QVNnZVQ2UzZrUEQ5SDZxK3FZb2ZNampGbjI4ajJ4dDgyUWJMZFpMRDZ0cEFX?=
 =?utf-8?B?N2FhSjRla2hMc05HN1F3d3paaFZBRlZ3YlF2Y0pJSDlrNGVrM0JpZUdXS0lk?=
 =?utf-8?B?SWFHSHczQzl2a0dUbkFka2RBSmY4dmMxb0trc0RwLy91RWN6SmJWd2RBUHRl?=
 =?utf-8?B?bGVSZkZEbkJCakQzU3lOTk94Z25JY0h4WmtHdVh1K3I1TUVaTTNUU1ZyUE92?=
 =?utf-8?B?V0NiSVdGSGxrbldLV3NlUlZQR1Bxb1g4akRLejc0eUFMMkRPeU5HQlNSZTJX?=
 =?utf-8?B?RG1pOGxSQ21ZdjYwSzkzdWJzY05yK3V3YVgvUHJlOUNSNGgxc2hvYU9yRlNB?=
 =?utf-8?B?ZDZWaVdBZjYxeDJleWo1M21nZ09rT2QrNm1GekFzNW5VS21ZdzhjNzdOd2c0?=
 =?utf-8?B?ckpNaTV0NDVabnlWbUlUcGFweW5qY3RTQzdGMTByeHlsWm41WWhJR01tdU8w?=
 =?utf-8?B?STBpazB2MExnV3BoNVJwaHR2UVJXVm5GOUVjanRmcXMra2lqd0dCWDdzMm1y?=
 =?utf-8?B?NE1ONU15VVZiV282UU5KczBPYVM5RXcyRk11VkR0R0pWbUhwajRDc2xsYUgv?=
 =?utf-8?B?MlRHRXhuWC83aCt0YlU1WVRubGd4RFJlTktzOXg5SWZEZ1N0a2N2WHB4WFlk?=
 =?utf-8?B?TjFJckhSUHlaM1BtekNLOWp2aWxXZFhQVXVWL3lDYUFMN2JZbkx5TlRFc2dR?=
 =?utf-8?B?NGpsLzdvZUpwRXNkM2xKK2NVbGgzSkk4eUxRTEdDNnhBODJCRlVqS09sTWsy?=
 =?utf-8?B?Q01CaXpETkFYQzJsdkFWQ090VncyLzRFai82ZW5MaUpXb0dlR2xvbDJLeHV4?=
 =?utf-8?B?dVZVQUxGUHB5K0VVdkRQL2dnb2wrTmxjTkR2bHRSUHAyRm45K09LSk1sMGw3?=
 =?utf-8?B?ZzJFSE84L05ZU2oyUnUvSUtIYXVEZnRwRFErVnFaNFREVFpNNGZ6ZnhsN09K?=
 =?utf-8?B?NlE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 432823ee-d9be-49b0-42b2-08dde645f971
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2025 15:17:17.2208
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2PfhtGtPDIhw+hqTmnrLAr3DBwSdimebmvc59zuDPLi6jyH+kO4EniSUB7sQjD208FVJom3h5isFF43KZG04wQ/rjLhxIX57TzTnx0DB93M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR11MB9370
X-OriginatorOrg: intel.com

From: Simon Horman <horms@kernel.org>
Date: Wed, 27 Aug 2025 18:28:28 +0100

> On Tue, Aug 26, 2025 at 05:54:54PM +0200, Alexander Lobakin wrote:
>> Add XDP support (w/o XSk for now) to the idpf driver using the libeth_xdp
>> sublib. All possible verdicts, .ndo_xdp_xmit(), multi-buffer etc. are here.
>> In general, nothing outstanding comparing to ice, except performance --
>> let's say, up to 2x for .ndo_xdp_xmit() on certain platforms and
>> scenarios.
>> idpf doesn't support VLAN Rx offload, so only the hash hint is
>> available for now.
>>
>> Patches 1-7 are prereqs, without which XDP would either not work at all or
>> work slower/worse/...
> 
> Hi Alexander,
> 
> I'm wondering if you could give a hash that this patch-set applies to.
> Or a branch where it has been applied.
> 
> I suspect it's terribly obvious how to do this, but I'm drawing a blank here.

I could've left `base-commit-id`, but Tony does rebasing of his trees
every day, so this wouldn't help at all.
Moreover, it's to be applied to Tony's next-queue, but not on top of it,
because currently there are patches in the tree that will go *after* my
series to net-next. So it's a bit complicated.

> 
> Thanks!

Thanks,
Olek

