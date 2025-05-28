Return-Path: <bpf+bounces-59054-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 48F59AC5F4F
	for <lists+bpf@lfdr.de>; Wed, 28 May 2025 04:27:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E1C5C188CE07
	for <lists+bpf@lfdr.de>; Wed, 28 May 2025 02:27:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B51E11C862F;
	Wed, 28 May 2025 02:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jmgR3xuK"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2C5FDF5C;
	Wed, 28 May 2025 02:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748399255; cv=fail; b=iBZIyMX4iRK5t3QWnkmR5V4kaP7LW0L4667XxkLfsdd5727sdHZS32mFnbg5Jqp12TRECnwvn2RBpdaj/a7J+t0jSt+b3HAI2x/7A5BS1DfQD67MiU3WA7JurspVKa07rg4Og23RD2yPj4wubxWF3gpKx3IN55/2MeusCuaHvBY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748399255; c=relaxed/simple;
	bh=fjjCQoe6ayDpjGXmDZ5w2SMOT3m4BSinqDymq2Crxjw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ccqjoZhndqHba4Pv0hBHZ/4N83hhoErxCdCf+juLaaD2ywB6SLsSdjYADDqaGxOph2ESKZXPa9fdkEh9wx/6vDjlTHgICdBwWRIj/sWZ6bFSC61PKzCEboa6pHiyxPG6c0jSMnnljKmgyoXmiSgFSTKXCVmXf+ijnUHzcLnpoWE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jmgR3xuK; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748399254; x=1779935254;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=fjjCQoe6ayDpjGXmDZ5w2SMOT3m4BSinqDymq2Crxjw=;
  b=jmgR3xuKdXURQK6BB6FBRAfM1SINFRxDImKaZw5ZsqLurGtPrr17eTdf
   lE9VK99uQgSREHMMYqoojB4+ZMWOdoP1XaCMgDhUb/1uyG3FCrIMpNEGy
   e94y0QcCeBf+enePC/0/diV2Ma7KO6fiTj6GykQ0tjqI3KWvhLERiqcwD
   6jKPm7vQPa/m8YDVXaA7TttZvdn1VF6TeB0gxYRLD69M+2OiekBTig/Jx
   Pn41xGhXqzqKq0QOBkLBs1wzD/7ePq/HNjaMcU9C7jttp5/l8YEGB7C0/
   EsFKJ36yfQ2M1EBeo6zsMnk3kNE0YcZ6BRv5Jvlbzr9bO7fQ/k5aIkv9L
   g==;
X-CSE-ConnectionGUID: 0vceSeZ2RSGLcqdMXyNmig==
X-CSE-MsgGUID: O09LDP2nR0+qa3h+ZMbmfw==
X-IronPort-AV: E=McAfee;i="6700,10204,11446"; a="72943764"
X-IronPort-AV: E=Sophos;i="6.15,320,1739865600"; 
   d="scan'208";a="72943764"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2025 19:27:33 -0700
X-CSE-ConnectionGUID: wQHnTPBLQbq4wldSayPjaA==
X-CSE-MsgGUID: +Sk6dtQRSR2Ejc7ax0VaZA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,320,1739865600"; 
   d="scan'208";a="143098420"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2025 19:27:34 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 27 May 2025 19:27:32 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Tue, 27 May 2025 19:27:32 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (40.107.100.87)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Tue, 27 May 2025 19:27:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ib96m/mC/yRzurColpnRSr2A0ITCH+3D0jGAtRuMKuLq9d/kjxz/aIu7jw209fjUDvKSE+XEREpideuhKkdIed0kZk+RyCmRzECsWzPM666pUNRylOwfvNLI7XQkuw65voBq/4WYtJOFxNCTxBNYtokBDl39ghX1irWMRXR1TuoCfrXj5P+83fkOKq6wlPUiR6+A1XLPmfO2Hxd6SbTrlWw/IaKQS40DEH7pMHq1asy2zfGKzDTe//fL3E0+NFplP6+ZfR7yqwRJSRfrmjAxUXA1ytX5k6+BDCOy+z3B2tCpp5/mYZjeyzP3Tx10vvP8Mcf/4MGtZyFcTkY4+VfzJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fjjCQoe6ayDpjGXmDZ5w2SMOT3m4BSinqDymq2Crxjw=;
 b=lm3+e80co2qZ3gMPUtAPfT7ZotTsHhwz2emxFGusnpabf3/TINBHR91Au64vdJzYfPcvYW3iX8oRcY4A5FdofgX8sZwGGQsCor8W6Qwky4H58c611DwhalsUoQ/SlBqHfcMw9Fi72e4MwFV1UqOYTFj9cIXGw6c989hHeyz96dD6xEmGLYTEFqR/egNR1rbHBmF3h5F1paP4hBh4LCk7dggWYaZb1UsZFBiopCJ+Ok/8S0rq6L81ydBajJkjMkRaxgxciOdsNbL5h+iw6GNMa1gCbSz+9/xzzj7foUNGKE1x65PSoab7QKcLymnmWRq7F1uHdH1GXt175U5JhFxuHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB6514.namprd11.prod.outlook.com (2603:10b6:208:3a2::16)
 by CH2PR11MB8835.namprd11.prod.outlook.com (2603:10b6:610:285::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.26; Wed, 28 May
 2025 02:27:24 +0000
Received: from IA1PR11MB6514.namprd11.prod.outlook.com
 ([fe80::c633:7053:e247:2bef]) by IA1PR11MB6514.namprd11.prod.outlook.com
 ([fe80::c633:7053:e247:2bef%5]) with mapi id 15.20.8769.025; Wed, 28 May 2025
 02:27:24 +0000
From: "Vyavahare, Tushar" <tushar.vyavahare@intel.com>
To: "martin.lau@kernel.org" <martin.lau@kernel.org>
CC: "bpf@vger.kernel.org" <bpf@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "bjorn@kernel.org" <bjorn@kernel.org>, "Karlsson,
 Magnus" <magnus.karlsson@intel.com>, "Fijalkowski, Maciej"
	<maciej.fijalkowski@intel.com>, "jonathan.lemon@gmail.com"
	<jonathan.lemon@gmail.com>, "davem@davemloft.net" <davem@davemloft.net>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"ast@kernel.org" <ast@kernel.org>, "daniel@iogearbox.net"
	<daniel@iogearbox.net>, "Sarkar, Tirthendu" <tirthendu.sarkar@intel.com>
Subject: RE: [PATCH bpf-next v4 0/2] selftests/xsk: Add tests for XDP tail
 adjustment in AF_XDP
Thread-Topic: [PATCH bpf-next v4 0/2] selftests/xsk: Add tests for XDP tail
 adjustment in AF_XDP
Thread-Index: AQHbqc04MdEccjVYUE+b9xQ7EqxvB7OdJh8AgEp1YcA=
Date: Wed, 28 May 2025 02:27:23 +0000
Message-ID: <IA1PR11MB6514340777F616B917F4BA368F67A@IA1PR11MB6514.namprd11.prod.outlook.com>
References: <20250410033116.173617-1-tushar.vyavahare@intel.com>
 <174430563276.3761227.17315253449500219027.git-patchwork-notify@kernel.org>
In-Reply-To: <174430563276.3761227.17315253449500219027.git-patchwork-notify@kernel.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB6514:EE_|CH2PR11MB8835:EE_
x-ms-office365-filtering-correlation-id: 0a5e20e6-5cea-4bb1-fb2f-08dd9d8f2e6a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?eHpEV2RBa3VibDN3Zmt0a1FwQVFjbEwzSmdjNWc2WkNXTXBZRUFEWmQramVi?=
 =?utf-8?B?N1pyWWFJTTVoUmJkMlFiZVo0Z3VYdlRvbG5zeCtlRDgya1BER2dVSzlDNmdt?=
 =?utf-8?B?N0tCMUl5MWtIUGlHTXlmWExUbUdNeFF0U1RES0RaVURMRk5lcm4vME9aZFAr?=
 =?utf-8?B?bktZaFJoZkhwT1hMV2JIOEZyNXJzVVNUSGtJU1QzdCsyanlVdXFWWlVaWU5r?=
 =?utf-8?B?aDBEcUJpc0VOWDV6QUhTajZ4WmNoRkVSZDRSdmxXZTJtV2lRdTVzNG5EN21k?=
 =?utf-8?B?NzBWeDBGYnptSWtqZXNOY2dBUkZkNkNXdCtxcjJvYisrQ3ZzdXpiZGZSVzZI?=
 =?utf-8?B?VFU2d0N4Ly9TcVRaTXgzUFkxRVVhT05PRWpkSDRNMUp2OTFFWkVrUWtWWHdR?=
 =?utf-8?B?Y2V2dlowbTVJclZvbW9UOG9jVC9VZmNldzBuclBkUWFNRVRLVCt6amZkN2RP?=
 =?utf-8?B?NUxCdTByNS96MGlaRDhGOGJaUHNRdlZST0dKWXN2bDZpUEZZT2RLS053eTR0?=
 =?utf-8?B?VFpNV1pXcTVwS1JjM1QrTGJEVnRnNlB6UE9uMFRoNDZORUxGaHk0V29iQmNn?=
 =?utf-8?B?cE9pVjQvUm1CS2hBdVVEWE9NQ09vdy9zN0ZSQTVNbmhjK0Q0b21LUWdFQWZK?=
 =?utf-8?B?dDhiUUh2QWtJRWtneUErOVFxbEptRmFESHRwQnM2UlFnQ0lPN1JEVU9IekpP?=
 =?utf-8?B?LzhMaCtlRWVVQjFlSE5Kc0xOMDhSWjRVTTFjZnlFd0VVcERwaDR6Q0h1aU50?=
 =?utf-8?B?ZGVaVjdoUUJWb2ZqTmpwbHRXNnlHN2Q3WGtkOTNsazBiTVhtY0NqUXF5cDJV?=
 =?utf-8?B?SW1mZ1B2b1J6RGNOcVY2QnJpdURYdG4xaDBZdHFVYU1HNWZCTVJzdXZBbFFj?=
 =?utf-8?B?Ti9TbGQ3OW1rb2w4TVpTL1V5R0N2cEtHVXhmNHdleVZIK0FXNjdrNG92eGlZ?=
 =?utf-8?B?aExLWEtwUVRmejdYSGdPcEd5b3lxdDRoSisvbWdsK2FibzV3ajROMlVMUkM4?=
 =?utf-8?B?TWVpU2l0MFp6RlNJK1V2NzhUYzBaUVlOdTFFMTZleTlZSkZXQUJINHA1M29R?=
 =?utf-8?B?QlpvUU5CU2VzLzNrWXQ5VEpsWkQ5bHhFeFhmRXRISmM1UFBEbllKTE56dGdC?=
 =?utf-8?B?czU4UTFGNGE0UEV5dUZoUzBpbGVKZTY5N2NTT1dreGE4aEJUSmlhYkhQNmZC?=
 =?utf-8?B?SnVkaGRmb3ROWGw2aytjci9icGVZZS9sbTJsblRYQXNPQW9XamNBZTYrbS9l?=
 =?utf-8?B?Y1lQTm5BL0VScWQ1OFFjOUtJcmo4SitYYnhqcVNIQm9DZE55Z3FUWTFhL0Y2?=
 =?utf-8?B?bHVqdjBPT01vMjN5UXY1clQ5VGFEOWJVdXZEa3JqSkpaU1dYTFdiZzJjcWNs?=
 =?utf-8?B?RHRYTUorT0h5Sm5zSGh4ZnBSS0JjZ3FnRzd1cDlaMEtoZlNaeGxGeldTbTdQ?=
 =?utf-8?B?ZkNab0pVQzNlNDBkMHAwZkdnN0ZzZ2xBU1M5WHF6YW9IRC9GSXBEMHJyOWJ2?=
 =?utf-8?B?bGdlWDZsYW0xT2taWEhvM1hhdFNpV2d0aHVWKy9pcTdNMmlWenczYVdid0Ir?=
 =?utf-8?B?RW1oSy94VGNhelc4SG9KcGRHVjRiMnUwM25IYWhJZ1NiejJJdHJHQWpYQmhC?=
 =?utf-8?B?eEJoUk9PMmJrSUZxbmtoSy9Hc2VJWEl5NUw3dWE5SWkvTENmUGZIV0ZpMDJ4?=
 =?utf-8?B?WStNa1FJZjR6eVQ0NXZBQzVVaENDYWs4aDdPUEZXMmVuMkwrVGpBZVhVM05x?=
 =?utf-8?B?VS84MEJZZld5YmFBRnZEdklQSlYwRURQYmp6U05JTkdqaEdrcFp4ditJZ3pU?=
 =?utf-8?B?YWZ2RERGQUJLbHdoeTE3azFjZ0xBeWs1aEU5cFM5ci85TGtxMWFpWkQ4bGFv?=
 =?utf-8?B?REdGbVBYc1F4bi9iRTQzbmZYbWRqWW5YeFRreSt2RmxOTGVDQmhRWFhMRDVJ?=
 =?utf-8?B?NUZWVjV3SE1JZE5JZTZLanBYZzM0VmJyeDBTeUVzTloydmY5dWZ2RllZY05z?=
 =?utf-8?Q?u7pODjdwjoNf1CmOcv6+D9nkYu1iFY=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6514.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NjNzZUV6RzNLbU9wRnlvbFk4WDFZZEt2WEJTcnZoS3ZmSW43alBYbzQ0MnNh?=
 =?utf-8?B?U2hqaHh3TnR6UG9rU25Ld01uZGc2bVdwV3lrYXBSNzMyWFhMMW5lZGE5UDM4?=
 =?utf-8?B?cmRsRExvby8rcnYyTzN3a1dSYkpHNCtwVzZPTEdBdmNsWXE0YjVxTGVGK1Bl?=
 =?utf-8?B?QlVYU2hiWWthVm1wcHZzcVZmTnZTc3RGRzA2NEw2eXBWODVWT3lSVVhwamNZ?=
 =?utf-8?B?Z1kxZVExazFOQ3hQRTNIQ0lzOGlnWVBzWG4wcVMvU21pL2NmZml1dU11ZUdQ?=
 =?utf-8?B?UU9lYXNiSnF4UTdJTnhGU2l0Qm1lSVNuN05UV0RxVnQvMnc3RElrMFArWEFP?=
 =?utf-8?B?NDA5NTk2VE1KNDVnV0MvRlczQ3VQUE9SR3RoUnUzUHJWeng3UnB4NE82QWxU?=
 =?utf-8?B?ZFdsYjMzQTZjVjJrL1NKd2FJQVdDTVl4YkcvZi9laHNmK3FTSEtOaGFkSHM4?=
 =?utf-8?B?RTlnckJIOUppa3pSbXgyaXU1dFNsTjR1emJOMFlEZ1pndnlwRlRGaGJuRjZM?=
 =?utf-8?B?bUJKZ0xuNWJJbnF1UVQvRXhoMXJFemlIbXlLdUxzTkkxRkdnUWdmaUdMdW9r?=
 =?utf-8?B?QWpwTEVuUHhHRksvYTEvRFc2YnFsKzRFTDVRenpIZHVrcC9BM1QrcngxRUh6?=
 =?utf-8?B?RkY4QUNRYUozKzFJSjRSUlpHaUNpdGdJQ1VEd3hHSnhDZnZLUnNVY2dFSnhi?=
 =?utf-8?B?UStIYXlxM3FLKyswa3pDWTdFT2I3VWdmRFhwZ1BZM1VhaDFmLzg5cHRKZEx1?=
 =?utf-8?B?dXlvZFBKVThycy9pUFBzYzNKOUpKSm43ckJaZmpJeTlJZHlXRThKMFBtMVJw?=
 =?utf-8?B?QlpuN0dQK3pOTFhKcmZ5eWdDejZoV3B4eGcvNFdXcmNqR1JlY2NVWUMydEVF?=
 =?utf-8?B?bjYyL2N6aFAwcFZyOVZPYnlRWjdQSHZCeG85bGVUa0w2cUR3V3ZJbFQyVVpO?=
 =?utf-8?B?TFZFejlnR3FIZ3JwbWhwMUo4RU1lZzIrT2trSU1laHlQWHRpWXJsYU1xMHBU?=
 =?utf-8?B?NTV4YW0wdDZqemszQUxzeGJQV0VnanQxM3k5K0lOaHArWGljaElZd2tndElC?=
 =?utf-8?B?WVpNMW4yOHZ5S2I4QWR4WWJDOG1ZT1RVTU1DOFphZXB4TFovVWpBbkhqNmhG?=
 =?utf-8?B?bXZwMkZ3YTEzS05QZVZQTE15c0xWc0h3M1kvL1hYMDhWQVVxNnUrVUtJeHh4?=
 =?utf-8?B?V1hpd200YjNXUUJMQU9vMEVtWkNzWFNNRDRRUzdEeTBGU3g3U1htZzByVktG?=
 =?utf-8?B?OVk5MitCSE1HKzlHY295ZnF0MC9LSUhkWHlaanNTR3hVUUd0VzBqazl2THQ5?=
 =?utf-8?B?amdpWXVDdVlFaXgrazZUU05CcEpxbUVNN2N6ME5hRWVaR0d3QlM3cjRkZmhj?=
 =?utf-8?B?RFM4dWtVQkdmZ0tGbUdJbWlMSUpkelBVaDYwQlFSZkJHVmdPTzZDUDVjeXVF?=
 =?utf-8?B?MmFJajJZblM5VkdwbGRlYUZZZjJScit1clhyZVBaTHpWbHI5eTg2RkZacXda?=
 =?utf-8?B?RjgzYkhqOVd0cnByOVN0K212aDhBbVNOUjJpK0FlMEZnZDBpcmNlWGZMZktw?=
 =?utf-8?B?bzZGSndCSHBxenRjUFRkaldpek9SenJCYjBMYms2OVBMY3BqNVdsWWVuTEhX?=
 =?utf-8?B?WnlBS0xSendoOTRnRGl0SXFaT1F1Y2NaZ0phdFNtWE90azR2dSs2cnBjOXlS?=
 =?utf-8?B?NG83dHhJSFVVYXdWZkdydG9vSnVwK1NyTy9CZnIyS3crdTRyamVnWW5QSFdG?=
 =?utf-8?B?eHBLMVU0Ri96QStFbWNaQUZQcmUrWm9hZ1ljSWxvU0ZweHArNXhPL09ycWo5?=
 =?utf-8?B?RW4zNDNYUzc0YThBOW14VmFRenlEZFFETG14YUREaDdYSlVRR2pNMld2eDVH?=
 =?utf-8?B?SmViSk9aVTlLaUd1NHU5REErNm4yNmFlOUtDMENxb2lnQ1dLU21HOEtpWU5Y?=
 =?utf-8?B?SW9uTmNSeXZuZ3pVMlVNVDhXUTRydzI1VzhJR2RZZTFvYUgxVjN0VitTQUdH?=
 =?utf-8?B?Y3hRK0lkUXcwUE5TK3RtVXEwaExEcEkwbnQ5c3ZBNGhrTnZ3NHJ1dkRtMTBw?=
 =?utf-8?B?TE01SDdWRzFJTmdRYkFMK2tpZitybkdPbmpjNllwcmJUOUowb091SkhqZ21R?=
 =?utf-8?B?Q09ObDlnUEd6bjZraVc1bER4WGZWL1duS0pqUis2cEdrZitmY2daNDlYMkRV?=
 =?utf-8?B?Y3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6514.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a5e20e6-5cea-4bb1-fb2f-08dd9d8f2e6a
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 May 2025 02:27:24.0587
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4l69hdGiEBy4Ud/HkJSp44tHagzGgmAtVzbiK7NI2YXDenl+tebghHPI1689QB8gXdcTsZJh8MskHRuaiT9v+MbhdVc9u/0Ze5ii+9T7ErQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR11MB8835
X-OriginatorOrg: intel.com

DQpIaSBNYXJ0aW4gYW5kIFRlYW0sDQoNCkkgbm90aWNlZCBiZWxvdyBwYXRjaHNldCBhcHBsaWVk
IHRvIGJwZi1uZXh0IG9uIEFwcmlsIDEwLCAyMDI1LCBoYXNuJ3QgYmVlbiBtZXJnZWQgaW50byB0
aGUgbWFzdGVyIGJyYW5jaCB5ZXQuDQpDb3VsZCB5b3UgcGxlYXNlIHByb3ZpZGUgYW4gdXBkYXRl
IG9uIHRoZSBleHBlY3RlZCB0aW1lbGluZSBmb3IgdGhpcyBpbnRlZ3JhdGlvbj8NCklmIHRoZXJl
IGFyZSBhbnkgaXNzdWVzIG9yIGFkZGl0aW9uYWwgc3RlcHMgcmVxdWlyZWQgZnJvbSBteSBzaWRl
LCBwbGVhc2UgbGV0IG1lIGtub3cuDQoNClRoYW5rcywNCi1UdXNoYXINCg0KPiAtLS0tLU9yaWdp
bmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBwYXRjaHdvcmstYm90K25ldGRldmJwZkBrZXJuZWwu
b3JnIDxwYXRjaHdvcmstDQo+IGJvdCtuZXRkZXZicGZAa2VybmVsLm9yZz4NCj4gU2VudDogVGh1
cnNkYXksIEFwcmlsIDEwLCAyMDI1IDEwOjUxIFBNDQo+IFRvOiBWeWF2YWhhcmUsIFR1c2hhciA8
dHVzaGFyLnZ5YXZhaGFyZUBpbnRlbC5jb20+DQo+IENjOiBicGZAdmdlci5rZXJuZWwub3JnOyBu
ZXRkZXZAdmdlci5rZXJuZWwub3JnOyBiam9ybkBrZXJuZWwub3JnOyBLYXJsc3NvbiwNCj4gTWFn
bnVzIDxtYWdudXMua2FybHNzb25AaW50ZWwuY29tPjsgRmlqYWxrb3dza2ksIE1hY2llag0KPiA8
bWFjaWVqLmZpamFsa293c2tpQGludGVsLmNvbT47IGpvbmF0aGFuLmxlbW9uQGdtYWlsLmNvbTsN
Cj4gZGF2ZW1AZGF2ZW1sb2Z0Lm5ldDsga3ViYUBrZXJuZWwub3JnOyBwYWJlbmlAcmVkaGF0LmNv
bTsNCj4gYXN0QGtlcm5lbC5vcmc7IGRhbmllbEBpb2dlYXJib3gubmV0OyBTYXJrYXIsIFRpcnRo
ZW5kdQ0KPiA8dGlydGhlbmR1LnNhcmthckBpbnRlbC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFU
Q0ggYnBmLW5leHQgdjQgMC8yXSBzZWxmdGVzdHMveHNrOiBBZGQgdGVzdHMgZm9yIFhEUCB0YWls
DQo+IGFkanVzdG1lbnQgaW4gQUZfWERQDQo+IA0KPiBIZWxsbzoNCj4gDQo+IFRoaXMgc2VyaWVz
IHdhcyBhcHBsaWVkIHRvIGJwZi9icGYtbmV4dC5naXQgKG5ldCkgYnkgTWFydGluIEthRmFpIExh
dQ0KPiA8bWFydGluLmxhdUBrZXJuZWwub3JnPjoNCj4gDQo+IE9uIFRodSwgMTAgQXByIDIwMjUg
MDM6MzE6MTQgKzAwMDAgeW91IHdyb3RlOg0KPiA+IFRoaXMgcGF0Y2ggc2VyaWVzIGFkZHMgdGVz
dHMgdG8gdmFsaWRhdGUgdGhlIFhEUCB0YWlsIGFkanVzdG1lbnQNCj4gPiBmdW5jdGlvbmFsaXR5
LCBmb2N1c2luZyBvbiBpdHMgdXNlIHdpdGhpbiB0aGUgQUZfWERQIGNvbnRleHQuIFRoZQ0KPiA+
IHRlc3RzIHZlcmlmeSBkeW5hbWljIHBhY2tldCBzaXplIG1hbmlwdWxhdGlvbiB1c2luZyB0aGUN
Cj4gPiBicGZfeGRwX2FkanVzdF90YWlsKCkgaGVscGVyIGZ1bmN0aW9uLCBjb3ZlcmluZyBib3Ro
IHNpbmdsZSBhbmQgbXVsdGktYnVmZmVyDQo+IHNjZW5hcmlvcy4NCj4gPg0KPiA+IHYxIC0+IHYy
Og0KPiA+IDEuIFJldGFpbiBhbmQgZXh0ZW5kIHN0cmVhbSByZXBsYWNlbWVudDogS2VlcCBgcGt0
X3N0cmVhbV9yZXBsYWNlYA0KPiA+ICAgIHVuY2hhbmdlZC4gQWRkIGBwa3Rfc3RyZWFtX3JlcGxh
Y2VfaWZvYmplY3RgIGZvciB0YXJnZXRlZCBpZm9iamVjdA0KPiA+ICAgIGhhbmRsaW5nLg0KPiA+
DQo+ID4gWy4uLl0NCj4gDQo+IEhlcmUgaXMgdGhlIHN1bW1hcnkgd2l0aCBsaW5rczoNCj4gICAt
IFticGYtbmV4dCx2NCwxLzJdIHNlbGZ0ZXN0cy94c2s6IEFkZCBwYWNrZXQgc3RyZWFtIHJlcGxh
Y2VtZW50IGZ1bmN0aW9uDQo+ICAgICBodHRwczovL2dpdC5rZXJuZWwub3JnL2JwZi9icGYtbmV4
dC9jLzNlNzMwZmUyYWY4Ng0KPiAgIC0gW2JwZi1uZXh0LHY0LDIvMl0gc2VsZnRlc3RzL3hzazog
QWRkIHRhaWwgYWRqdXN0bWVudCB0ZXN0cyBhbmQgc3VwcG9ydA0KPiBjaGVjaw0KPiAgICAgaHR0
cHM6Ly9naXQua2VybmVsLm9yZy9icGYvYnBmLW5leHQvYy80YjMwMjA5MjU1M2MNCj4gDQo+IFlv
dSBhcmUgYXdlc29tZSwgdGhhbmsgeW91IQ0KPiAtLQ0KPiBEZWV0LWRvb3QtZG90LCBJIGFtIGEg
Ym90Lg0KPiBodHRwczovL2tvcmcuZG9jcy5rZXJuZWwub3JnL3BhdGNod29yay9wd2JvdC5odG1s
DQo+IA0KDQo=

