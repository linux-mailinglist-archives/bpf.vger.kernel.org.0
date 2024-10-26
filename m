Return-Path: <bpf+bounces-43244-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BABA9B19DD
	for <lists+bpf@lfdr.de>; Sat, 26 Oct 2024 18:51:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD9AC2827ED
	for <lists+bpf@lfdr.de>; Sat, 26 Oct 2024 16:51:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91B3B1534E6;
	Sat, 26 Oct 2024 16:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QJhZo3Fw"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C30A42F36;
	Sat, 26 Oct 2024 16:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729961500; cv=fail; b=BIJpBEuLRef7DXW4vdITn6af46SoH5kTmucQhmv/BvdTHA1PkeBpqbym5Eumt9evGt5ctjjb5eUiAOdp+AHqbbQwV8McWLS0+u8ZKJ3g5KJj8lGEkxGBXBgpmAPcLHBX0ZMuVrXVHoZwNp1qCbqwrbzpgSwVZehkxlkwXaeT5qA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729961500; c=relaxed/simple;
	bh=rJyldPd/Ds3RrknfcIMmJBILSebrEQlcv/1JtclCQMA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gJ5GrCAjs00hA6A7qxdTHS9/R7VkyhtkregKeDS/2WRoD0+biVegx6q7Sl9FKab2WJXkgaIahTq4+fQePSHMCAhkYLu5gp62J1+3QfZlR0daP6/KJ7mXUv0Rn4x6x6Lr88adXfSeofWIl7wxfWH0YOfTe2m7uqXrlH+HW23/Hgg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QJhZo3Fw; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729961498; x=1761497498;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=rJyldPd/Ds3RrknfcIMmJBILSebrEQlcv/1JtclCQMA=;
  b=QJhZo3FwmiiJdhYWvqTeu/BQolDey433W1tlXJSFn/bsrpgIQi4ccj+Q
   I18zXj0v1dMy9HVb9qcaaRvHe9PmplqOKmTeOIbQhq2KQwRKTqzFh0Fja
   Q7S0H7xS1Slb23fUsPI/ul2q4wOs0CKyMKutMWYFc20o1e4QmOXww7qCn
   bV+54WEcC0zgG3b2WJ7ZM7dszb5wm+6DCu7OSszXAWc47JgIJUuBl64K1
   geLK6wi8OcXowFLW+B/7FQfBZqQ4MGKgh9n/Ee07n1J1JWAEMQRoDCBcu
   JpubYdrPDIrO9kg5Gr0E2H8qGpmUk2gxzvwR59n4M+vDv/5A9oR0PqCNt
   Q==;
X-CSE-ConnectionGUID: OxPVakChQNOv4rBYBqd9sg==
X-CSE-MsgGUID: VPmlBgYkRDCxxCmeDA7OnA==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="29753177"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="29753177"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2024 09:51:36 -0700
X-CSE-ConnectionGUID: we+0TEdcR2W+4hPVQdRCyQ==
X-CSE-MsgGUID: y+hV3D8xS6GJSgeXHqqN1w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,235,1725346800"; 
   d="scan'208";a="112053793"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Oct 2024 09:51:36 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sat, 26 Oct 2024 09:51:35 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Sat, 26 Oct 2024 09:51:35 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.173)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sat, 26 Oct 2024 09:51:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tVudUAYhyxn7bceWtw/8dEQlP2r+p3HeLY8xnOZRaPVDIRGbVTBC+Rb+BNaFg1/KiYcpwAofXkiMyUTkI8xHWZ//UmSrhb4lSntmqpm1ZTXIlwGUatUrgrsN+w5KKQ/f+zjcAu76e9wKI2NskXfH1kP1ilbFA4HgmhfIW+SwzXY0AzcKTuGTPeq+RedSQorb27KrDVNqNgYHsTEPvRqE42awPMQbfw8oBY4TBkMlDex26vDjyThW/bMVDJbA3xwnGwh3jP+918v/Xhms1Sat4P0K4UTCEhkxQm1zHKAyDZ6i8VkFhcyvjdTd7ElbVAdGKrPxeOawTppQNF1iLNRuRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rJyldPd/Ds3RrknfcIMmJBILSebrEQlcv/1JtclCQMA=;
 b=y5g9rA6l3OePc3cN8hyphCwRERNWfE308Z3AstM0GYshYdoH8qHb+zRwlyG/i4g8NBHAfn4xMeEKSSphX4nki6DuxPQegnOVpoOd8vYpoIYp91dlRMlaWgRaW7NJ7UYfdYwrTSJJBBdGTPCM+3861/mwuXZIe0+GOOyZ8S+TOSVWs8AOverVibATBOUCaF6iAOx5ZXjH1cqwmbBbVPjVhYuDAW0TvNAJCCc3UzpKS+UzSslWOn0brV0Y8Z3hjyLE5maY5yy5kmUuewXbFSiRgwNNdmsDoMf+DJqmzckg8+qWVcp28k21EkVIgm8gnby9Z1SYSHTrHX7YLMWIPgabqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5144.namprd11.prod.outlook.com (2603:10b6:510:3e::20)
 by DM6PR11MB4676.namprd11.prod.outlook.com (2603:10b6:5:2a7::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.23; Sat, 26 Oct
 2024 16:51:32 +0000
Received: from PH0PR11MB5144.namprd11.prod.outlook.com
 ([fe80::5889:7208:6024:bbcf]) by PH0PR11MB5144.namprd11.prod.outlook.com
 ([fe80::5889:7208:6024:bbcf%4]) with mapi id 15.20.8093.023; Sat, 26 Oct 2024
 16:51:32 +0000
From: "Kuruvinakunnel, George" <george.kuruvinakunnel@intel.com>
To: Kurt Kanzenbach <kurt@linutronix.de>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>
CC: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
	<daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, "John
 Fastabend" <john.fastabend@gmail.com>, Richard Cochran
	<richardcochran@gmail.com>, Sriram Yagnaraman
	<sriram.yagnaraman@ericsson.com>, Benjamin Steinke
	<benjamin.steinke@woks-audio.com>, Sebastian Andrzej Siewior
	<bigeasy@linutronix.de>, "Fijalkowski, Maciej"
	<maciej.fijalkowski@intel.com>, "intel-wired-lan@lists.osuosl.org"
	<intel-wired-lan@lists.osuosl.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>, Sriram
 Yagnaraman <sriram.yagnaraman@est.tech>
Subject: RE: [Intel-wired-lan] [PATCH iwl-next v9 5/6] igb: Add AF_XDP
 zero-copy Rx support
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next v9 5/6] igb: Add AF_XDP
 zero-copy Rx support
Thread-Index: AQHbITlqRL2r8o+A8ky7G3FNsN4w6bKZS8SA
Date: Sat, 26 Oct 2024 16:51:32 +0000
Message-ID: <PH0PR11MB5144ED4AE2331EF902E54687E2482@PH0PR11MB5144.namprd11.prod.outlook.com>
References: <20241018-b4-igb_zero_copy-v9-0-da139d78d796@linutronix.de>
 <20241018-b4-igb_zero_copy-v9-5-da139d78d796@linutronix.de>
In-Reply-To: <20241018-b4-igb_zero_copy-v9-5-da139d78d796@linutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5144:EE_|DM6PR11MB4676:EE_
x-ms-office365-filtering-correlation-id: 9e9181d8-7492-4a5d-d48e-08dcf5de720e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?OS9kR3ppVkVjQWFHYk9wVDRlRjJzOE5ITzhTSlN1bExOcTlwemtRdDBIekRL?=
 =?utf-8?B?SUJlV2sxckptcXpVUG5PaXYyNU9pSGN1bXhWWWd2dGZPcGgrRE5jeEJTUjlv?=
 =?utf-8?B?ZmFzTE5LcWt2ZlUyUlR2ODMxOEM4RWFONExpWlM5ejhmamV3UnUxRGtvRGRw?=
 =?utf-8?B?T1RvaElabS9adXQ4UEgrc2YvM3N6ellUQmo3eUk2bUhBd2hQR0RzQjFzUXdG?=
 =?utf-8?B?Zjg2MG82bTM1QjRQNndENUNBalI5T0tmLzdMUVNHTTJtZ0NPY0VPSWRQbjFa?=
 =?utf-8?B?VVR0ZU9SampCWEQ3QVh1SVpINVFpcFN5bE5kS1hjMmhCUi9JTENxRFVHc0V1?=
 =?utf-8?B?RnlmSjZjUmowazkrU3VOeWlvQWdjN0lYZk9JOVAzc3FldkpIa3c3L0w4ZWt5?=
 =?utf-8?B?UGtWOStoMHNtQkRibzlrUkRwQ1V2UENKSzcvM0lHMWlHV1pHQmc5ZVZBeVRX?=
 =?utf-8?B?bXYrQ2VDRWptU1J5bDBmZmxUY1o1TDNqWk9BdVdBSE9HTmY1SWtIN1pCUGFn?=
 =?utf-8?B?K0pEWE8zYWZQZWt5MzgrUEJRQjJrVkhIWkwvSmNnMmlnZkVPTGVsUmJYaFVu?=
 =?utf-8?B?L3J0U2FlbmpZSnNUS0plbWxzbXAraGRPdHdPdWlKaXV2ZisxTlVFSGphcVhF?=
 =?utf-8?B?RUJJQXA0WjRBVlgzWjY3RUNnMGJZdUN1dWZrYXE0RmpOZXZCUnQrSUx6ODF3?=
 =?utf-8?B?akdkWHJ0bSthZ1JxR2c1MUNaQjNZZWZLMXVIVVhJOFExd3VWNHlJZmVVeElE?=
 =?utf-8?B?Wk95Y09ETHoxSnl4Yk84SnJ5bmNMU1hXS2cvNlJZNVhjeElVb3pRYXVNc0N3?=
 =?utf-8?B?VzJwN1dybDR5NFpndHpRem5BSndaM1h6aHg5VS9ubXp3UU9FTUt1VkFUWUFX?=
 =?utf-8?B?bHlPNU9vWCtYbVlFNEVFc09KR25jMmFUQVJNcVF2TkVORWUvekVtMUJYZWdq?=
 =?utf-8?B?S0pTK3l3MjgwYVBLMmdtckxUcndUQ2txYUNEYjA2ZDRmbURFb2w5cldWcVdr?=
 =?utf-8?B?TXMwUTNTYzVQVCt6RC9abWFJaTh3VE4yelF2eGtNZUk1bVhFb0c5Mk8xZmJU?=
 =?utf-8?B?YTFCZXY2Sm5yVVVkV3dQVWZuZ2RZYW9Pdy9aSTJ1cjQvUzU0dWxEcWNiS25n?=
 =?utf-8?B?T2MzSjdlVEtlWDR3bitnQVhMRWJ3R1k1ak5OWnJjUUlGc005VGRZNUFOUEI5?=
 =?utf-8?B?b0hPR0drcUhzTXBmRFFRM2dPOXh1V3ovVFlGb0RMOEpTSmtWTEtRdUloaG5J?=
 =?utf-8?B?NDArMk1oL3I5R0JLdERmTERTM2VMYU85Znk5UWlySWEreFkrSXVHQXZ6Slkr?=
 =?utf-8?B?dmFTYUV0QjJyR3F3bStKcklyN0k4eEVpcTFJTmoyenhqTnFyQTYvczVqa2pF?=
 =?utf-8?B?WDBOdTNhUDZFcUtnUEcrWHQxZWoyTEtLUkFKTk16SUZCTHdoT0Z1bWJicEl1?=
 =?utf-8?B?aWhXNm9zcmcxQ1J6ZG02VGRLL3lKeklsN0FUcHlCaERFTFJSdjRyajlndE16?=
 =?utf-8?B?NDBsblhhMkp3V2dUUm5WSERVQlpMZ2VaaUVJdkt1VGc5d3UzMDQ2aFhCRUw2?=
 =?utf-8?B?QS8zZjNGZGhPSnNUb0lMSDQrRG82aWpDNC9IQTZnYVdVMlVnS0hLU1BVOEFX?=
 =?utf-8?B?MzJ4N0F0WUhXWERwWEJ1S21Bb2FvR0JlTld0QTVONFl3VEptZUlmb25uZXVD?=
 =?utf-8?B?WTY5YUFqTWp2czMzQUIrMzR2a1lPOWRpenFkUEpnbnBKK1RwbURzbFIxazc0?=
 =?utf-8?B?Z2VrblB2ZjZ5QjI4YWNOMUJscEtVaXB6UzFwTlkyM2s2YzUvcDl2cm9OdTFw?=
 =?utf-8?Q?2jrA7I9Wa5UFBHdCTan6Ji8xiPPjJ9aSzmTUM=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5144.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NndwTDh4Nmt5VWltZmtYTGRnU3V5N3FlL3JwSjJrcERmaEp4L29EMW84eERB?=
 =?utf-8?B?OVF0MzdmVEhVVVpOOXZXT1ovUTl6THFoV2hzZnJkcUswQlpFcUswVTM3Vm5U?=
 =?utf-8?B?VjAxTnoyaXMwc25LdmVZUDlQM0ZibVNTRVRLelhjaWU1YXdqYUc4NnYyc0sz?=
 =?utf-8?B?TVN2bkVHQ3orY0MxbFh2TzRRSm5ZMEYzWkU4ZUVid0VrMEQzVS8zK09WWWM5?=
 =?utf-8?B?emRxcUJWZ1paaVdOT2lYMTNxRE1SSTNDL2srL0pIakZHSE5aeTNiNUVHTTdI?=
 =?utf-8?B?Z2RxWmdPZis4bHdoUDFaUDkwK29iTW5ha3ZLVmxmSWhkR0VtY1lSNHlJVmIx?=
 =?utf-8?B?SGhPTHFhVm5ubjJYNWhBZjBZSTFVV0NrNGpvOThVNjRDUTdxMWlVaVpWZnAx?=
 =?utf-8?B?WnJBdHYyOGQrUWttZ0hxMVp1VUJ1Q3JnMEFOTXlQM0pTbkxHN0NqWVlSS3Np?=
 =?utf-8?B?RWYxUGxQQWg0SUphQVhWNG1RYnpIdEFHU2RYNEVsb3MwOG9rU0x5OW1RSzcy?=
 =?utf-8?B?U2h2QnZROEtTckxJcXYwMUpTbEQ4NzQ0dTR4V0dGL2ozMnI3Nnl1QlFsMDdw?=
 =?utf-8?B?VkJzWnY1aG42cmpKdnFEU1orNW55V282ZlNpeTlSSStpNCtDTVdrYkFjeG5X?=
 =?utf-8?B?U0h6T1hhM0NlcVlwMHpmSktEclJsVnJ2MDhuYWwwbDEyWUl4cFEyQnpaQXd4?=
 =?utf-8?B?eCtodGQxcGdkdEFqa2d3T3N3M0R2UmJOOWN5V2pyWndBQ09JY00raDNkZ0JG?=
 =?utf-8?B?eDU0WFRFQU1LZEtHc0R6T3hwaVNTWnRPRno1V1EvU3dPN1hCaVNIZEhwSW1X?=
 =?utf-8?B?RjBZaktKT3oyaFhDd2dWc1VCUEtiaHlNTnlTZjc0TDZ4MDlyRW5XWTVoYXZj?=
 =?utf-8?B?eVBDclNsN0xYMzVmVmdUMHdUTDVtMEdxeEdFV09lTWozVHFRbjBPZmVjYmE3?=
 =?utf-8?B?WS9zUnRQZGl5SVFXWEpXNVpiSW9Wdm5KTnNlRGVzRDNXbVY0a1BpUTd6UGcw?=
 =?utf-8?B?eDRzRzZQNHdjTFVCcU01aXNXVUhMb01tdjFZanJlNm9YMXloU1dQMit0Q2ZH?=
 =?utf-8?B?UFloRG55bGJQYnArTXp2MDZtZmxWZG9JUG5rK2tWRHpwc3Y0TENzbUNIak5S?=
 =?utf-8?B?RktrcnQ0OXUwUlNiNUpsMzdVSm94OGtMQWhzVnRhQitCL24wdEJlZ3MrcDdH?=
 =?utf-8?B?WXE4Rm5CQWUzZmh5WGRzSXU2TnVrY1JyVjVxb1ovTUsvQ1BlVlk3TFRYQ3B2?=
 =?utf-8?B?cE5UdGZINFdxUjdibmZzUGtNcFpvd3V5STMwNXI4N2xxOGtMUktPVWdTWjdl?=
 =?utf-8?B?ZDlmTnZLcldMM0FQQjdSMVk2bit4bE1FUjk3NnBBSnArVFE4bDJrdjZQejJ6?=
 =?utf-8?B?Z0wzVzlwb29McFJKLzJteU1JSmY1dEEzaDhXT01nZHNmTWlzeTByRmxaa2Y0?=
 =?utf-8?B?ajR0QUR3TTVndmdUemhMY29JWENaMzZZbFpoSzBsdU5iaW9BTGx3dE95eURQ?=
 =?utf-8?B?N29BYTlNSDRiWWNORE5SZFdyaUQ0UXl6bkJsUGc0UFhaQWY4ODY5bGVWdjhs?=
 =?utf-8?B?bExPdTdaMThyMXJFeUwyekpvdklyZXlNTWhZNFFHejFsdkNyNkdCYzlXOG9y?=
 =?utf-8?B?MHJsUkVpV29KYzNuRE5ucitGbkxNdERaS3BjbGpidmVzNFNGMjZ2ek52a2xJ?=
 =?utf-8?B?Nm1qQmV6THp3OVJNZVFrMXIxYzFYTTNwbUx4aHZ2OWtIbWs3K2lLRVdJK1dP?=
 =?utf-8?B?bjczK1VTNm0yc0pTdkV4cWRNV01WSksyZWxZWm9vSTNUeEk3RzdBSzh4a3Fl?=
 =?utf-8?B?N1ZOdzdaR0NZTFg2NyswY2dOWTQ4U2k0TFUxdWhSeGJnQUFoYlhMRmRrRGtX?=
 =?utf-8?B?K1lpbHA1WWFKb1AxT3pOVjZSYXJ4Z0ZmMVphUmd4dlF2QXlibnRGa1M3NDNj?=
 =?utf-8?B?emQyNDVESFhXamlVYkZVQXdiZ0JsZzcxY01SM0VyZFpFVmZpbTdoeGMzUzBI?=
 =?utf-8?B?QXRpc0l2NmFUSmk3Nk5ENExmbER0ZncxUit1b3JOb3pCZmUydHUydzEzU1N3?=
 =?utf-8?B?QlVHa1JZWkxEWVNyazZQQTlLaDdhc2hiM29pckphVUpNZ01QSEFqL2kyQTI2?=
 =?utf-8?B?Q3VLNnF5WW8yS1ZYUFhLNGhVc0hyQStCWVRRdWtmR01lV1RXM2RYSWlHNTk5?=
 =?utf-8?B?UlE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5144.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e9181d8-7492-4a5d-d48e-08dcf5de720e
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Oct 2024 16:51:32.4260
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XG6XtNNQGnDYh8L+sFJN0YOhAEHL7H5+g05XCXSt7XXxt6XDhWIM5hKsGVnidMCNy6FhGz8taubOR1tQSM9IjLzeYUMxptppxiwqs5BERZM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4676
X-OriginatorOrg: intel.com

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBJbnRlbC13aXJlZC1sYW4gPGlu
dGVsLXdpcmVkLWxhbi1ib3VuY2VzQG9zdW9zbC5vcmc+IE9uIEJlaGFsZiBPZg0KPiBLdXJ0IEth
bnplbmJhY2gNCj4gU2VudDogRnJpZGF5LCBPY3RvYmVyIDE4LCAyMDI0IDE6NDAgQU0NCj4gVG86
IE5ndXllbiwgQW50aG9ueSBMIDxhbnRob255Lmwubmd1eWVuQGludGVsLmNvbT47IEtpdHN6ZWws
IFByemVteXNsYXcNCj4gPHByemVteXNsYXcua2l0c3plbEBpbnRlbC5jb20+DQo+IENjOiBEYXZp
ZCBTLiBNaWxsZXIgPGRhdmVtQGRhdmVtbG9mdC5uZXQ+OyBFcmljIER1bWF6ZXQNCj4gPGVkdW1h
emV0QGdvb2dsZS5jb20+OyBKYWt1YiBLaWNpbnNraSA8a3ViYUBrZXJuZWwub3JnPjsgUGFvbG8g
QWJlbmkNCj4gPHBhYmVuaUByZWRoYXQuY29tPjsgQWxleGVpIFN0YXJvdm9pdG92IDxhc3RAa2Vy
bmVsLm9yZz47IERhbmllbA0KPiBCb3JrbWFubiA8ZGFuaWVsQGlvZ2VhcmJveC5uZXQ+OyBKZXNw
ZXIgRGFuZ2FhcmQgQnJvdWVyDQo+IDxoYXdrQGtlcm5lbC5vcmc+OyBKb2huIEZhc3RhYmVuZCA8
am9obi5mYXN0YWJlbmRAZ21haWwuY29tPjsgUmljaGFyZA0KPiBDb2NocmFuIDxyaWNoYXJkY29j
aHJhbkBnbWFpbC5jb20+OyBTcmlyYW0gWWFnbmFyYW1hbg0KPiA8c3JpcmFtLnlhZ25hcmFtYW5A
ZXJpY3Nzb24uY29tPjsgQmVuamFtaW4gU3RlaW5rZQ0KPiA8YmVuamFtaW4uc3RlaW5rZUB3b2tz
LWF1ZGlvLmNvbT47IFNlYmFzdGlhbiBBbmRyemVqIFNpZXdpb3INCj4gPGJpZ2Vhc3lAbGludXRy
b25peC5kZT47IEZpamFsa293c2tpLCBNYWNpZWogPG1hY2llai5maWphbGtvd3NraUBpbnRlbC5j
b20+Ow0KPiBpbnRlbC13aXJlZC1sYW5AbGlzdHMub3N1b3NsLm9yZzsgbmV0ZGV2QHZnZXIua2Vy
bmVsLm9yZzsNCj4gYnBmQHZnZXIua2VybmVsLm9yZzsgU3JpcmFtIFlhZ25hcmFtYW4gPHNyaXJh
bS55YWduYXJhbWFuQGVzdC50ZWNoPjsNCj4gS3VydCBLYW56ZW5iYWNoIDxrdXJ0QGxpbnV0cm9u
aXguZGU+DQo+IFN1YmplY3Q6IFtJbnRlbC13aXJlZC1sYW5dIFtQQVRDSCBpd2wtbmV4dCB2OSA1
LzZdIGlnYjogQWRkIEFGX1hEUCB6ZXJvLWNvcHkNCj4gUnggc3VwcG9ydA0KPiANCj4gRnJvbTog
U3JpcmFtIFlhZ25hcmFtYW4gPHNyaXJhbS55YWduYXJhbWFuQGVzdC50ZWNoPg0KPiANCj4gQWRk
IHN1cHBvcnQgZm9yIEFGX1hEUCB6ZXJvLWNvcHkgcmVjZWl2ZSBwYXRoLg0KPiANCj4gV2hlbiBB
Rl9YRFAgemVyby1jb3B5IGlzIGVuYWJsZWQsIHRoZSByeCBidWZmZXJzIGFyZSBhbGxvY2F0ZWQg
ZnJvbSB0aGUgeHNrDQo+IGJ1ZmYgcG9vbCB1c2luZyBpZ2JfYWxsb2NfcnhfYnVmZmVyc196Yygp
Lg0KPiANCj4gVXNlIHhza19wb29sX2dldF9yeF9mcmFtZV9zaXplKCkgdG8gc2V0IFNSUkNUTCBy
eCBidWYgc2l6ZSB3aGVuIHplcm8tY29weSBpcw0KPiBlbmFibGVkLg0KPiANCj4gU2lnbmVkLW9m
Zi1ieTogU3JpcmFtIFlhZ25hcmFtYW4gPHNyaXJhbS55YWduYXJhbWFuQGVzdC50ZWNoPg0KPiBb
S3VydDogUG9ydCB0byB2Ni4xMiBhbmQgcHJvdmlkZSBuYXBpX2lkIGZvciB4ZHBfcnhxX2luZm9f
cmVnKCksDQo+ICAgICAgICBSQ1QsIHJlbW92ZSBORVRERVZfWERQX0FDVF9YU0tfWkVST0NPUFks
IHVwZGF0ZSBOVEMgaGFuZGxpbmcsDQo+ICAgICAgICBSRUFEX09OQ0UoKSB4c2tfcG9vbCwgbGlr
ZWx5ZnkgZm9yIFhEUF9SRURJUkVDVCBjYXNlXQ0KPiBTaWduZWQtb2ZmLWJ5OiBLdXJ0IEthbnpl
bmJhY2ggPGt1cnRAbGludXRyb25peC5kZT4NCj4gQWNrZWQtYnk6IE1hY2llaiBGaWphbGtvd3Nr
aSA8bWFjaWVqLmZpamFsa293c2tpQGludGVsLmNvbT4NCj4gLS0tDQo+ICBkcml2ZXJzL25ldC9l
dGhlcm5ldC9pbnRlbC9pZ2IvaWdiLmggICAgICB8ICAgNiArDQo+ICBkcml2ZXJzL25ldC9ldGhl
cm5ldC9pbnRlbC9pZ2IvaWdiX21haW4uYyB8ICA3OSArKysrKystLQ0KPiBkcml2ZXJzL25ldC9l
dGhlcm5ldC9pbnRlbC9pZ2IvaWdiX3hzay5jICB8IDI5NA0KPiArKysrKysrKysrKysrKysrKysr
KysrKysrKysrKy0NCj4gIDMgZmlsZXMgY2hhbmdlZCwgMzYwIGluc2VydGlvbnMoKyksIDE5IGRl
bGV0aW9ucygtKQ0KPiANCg0KVGVzdGVkLWJ5OiBHZW9yZ2UgS3VydXZpbmFrdW5uZWwgPGdlb3Jn
ZS5rdXJ1dmluYWt1bm5lbEBpbnRlbC5jb20+DQoNCg==

