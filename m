Return-Path: <bpf+bounces-51921-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A244A3BAED
	for <lists+bpf@lfdr.de>; Wed, 19 Feb 2025 10:58:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E8991782F6
	for <lists+bpf@lfdr.de>; Wed, 19 Feb 2025 09:50:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EEAD1CC8B0;
	Wed, 19 Feb 2025 09:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="si2O//wy"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E2391C5D7A;
	Wed, 19 Feb 2025 09:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.148.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739958597; cv=fail; b=XyFTp8Zreq+9udPlKosFh7oPlpZfsB9LmwqhSlmgMFdexPj0OoccVQl3Zl8EHl8DN9JTYYJ+WPHtIdP9fqMdTczo2b7hSa9yFcrHXf3rT/RTLwiabi+N4AxLzTIk3XbbadBgErYzUdf9faUCxf5nQa/gEr9cd7oiy13NHrTEzqQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739958597; c=relaxed/simple;
	bh=ESEApvbaP8pRP5DiHXWyGj34iZEWRcTlG7K9wpPxxxE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mfFLeC6wgs3cyrhIjdChwTP0kahN73dy8T9dyqa6EbkVkqIyvbEI5HjVnL3pzudxLT7+dc89ZsuLO3FKJaWCCRV13Vt8VaTniWId0k9IXnZfviD5JVSdmabEU4SSWhEdYFydbhLAt/enFMl97snkoh+fYhvBxFyZL4tPTn1/t18=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=si2O//wy; arc=fail smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51J8iaoJ013970;
	Wed, 19 Feb 2025 01:49:32 -0800
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 44wc2883wh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Feb 2025 01:49:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tnwypkBN1xT3yW3J431JjqDFZ83ayyiZakGe23xeuvwRRvgGZGgyFT8Aa9PoAxvE22AmGh8SF/GqKCK4nHadM8QmYvTTot/fn898nYeutZhnydkhdAUGFu/NT0r7qBQ13eE9t000uer5XLM8uTyi7+RItBkFnmFXeuEGqhJVrTiWdrd9riMDCWPZIApFrY6ey+tR81Z3tC6pykIWxDZK+KozOV464VimxjjjoH7Zyku0DOhjACjjsUQq+clG/gt+1sRwrTikz5W629SVvuolkFI+HBsnf18+7ba4wyrVdqhoqC2bJONUiwbDRRV7iJtuc25hsNYVjiVXZc+PXYFidA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ESEApvbaP8pRP5DiHXWyGj34iZEWRcTlG7K9wpPxxxE=;
 b=q0JXO/QbtcEbEvBiwCXh5yscbeUjplLKpRiD6VuIK1dHbvKM5WXI79lVLuaEiLK3GDg/Yxbs9kf0cCKQ1i1b/0s12+0sXt0jqkHxu44IUp32reTfNC6paqj6cf4AcMCsRcH2glP6myAtW0rBRrIDiHllfaX5CYdWFgHnjmDdixRkQQq5pFrZZkiBEE+/MXrJv0Cvvj8AMzTrnaQ7CMdFrmkABuR1zmCdbvxcPh8AbGxN3Lu5hiT4cnOBE/FlWOa5d3sEr9Vi8KHSnUGFgvptqbRVbhodD0REVfmxpnRGFmsrG1XpOMZpJJNuQlVoK5QNbWMUqibKTXusaM6oS+B8kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ESEApvbaP8pRP5DiHXWyGj34iZEWRcTlG7K9wpPxxxE=;
 b=si2O//wyHJamvptSOXUf/zepz1jaN0k/UOGjqJqu1CFJk8QXf80wVEb5cyPZPM9EnDPAReKpwBqyCTValhQ4CSxaanV0xkMdg4no66bo8kwsAwl9nOC6RGqqzYBWFNeQFrTqYlSj0MrBV9XUFAb6pDvlFusxeHwhPz7iZ6qv0bo=
Received: from SJ0PR18MB5216.namprd18.prod.outlook.com (2603:10b6:a03:430::6)
 by IA2PR18MB5849.namprd18.prod.outlook.com (2603:10b6:208:4b0::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Wed, 19 Feb
 2025 09:49:29 +0000
Received: from SJ0PR18MB5216.namprd18.prod.outlook.com
 ([fe80::2bf5:960a:a348:fad1]) by SJ0PR18MB5216.namprd18.prod.outlook.com
 ([fe80::2bf5:960a:a348:fad1%4]) with mapi id 15.20.8445.013; Wed, 19 Feb 2025
 09:49:29 +0000
From: Suman Ghosh <sumang@marvell.com>
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
CC: "horms@kernel.org" <horms@kernel.org>,
        Sunil Kovvuri Goutham
	<sgoutham@marvell.com>,
        Geethasowjanya Akula <gakula@marvell.com>,
        Subbaraya
 Sundeep Bhatta <sbhatta@marvell.com>,
        Hariprasad Kelam <hkelam@marvell.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com"
	<edumazet@google.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        Linu Cherian <lcherian@marvell.com>, Jerin
 Jacob <jerinj@marvell.com>,
        "john.fastabend@gmail.com"
	<john.fastabend@gmail.com>,
        Bharat Bhushan <bbhushan2@marvell.com>,
        "hawk@kernel.org" <hawk@kernel.org>,
        "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>,
        "ast@kernel.org" <ast@kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "bpf@vger.kernel.org"
	<bpf@vger.kernel.org>,
        "larysa.zaremba@intel.com" <larysa.zaremba@intel.com>
Subject: RE: [EXTERNAL] Re: [net-next PATCH v6 3/6] octeontx2-pf: AF_XDP zero
 copy receive support
Thread-Topic: [EXTERNAL] Re: [net-next PATCH v6 3/6] octeontx2-pf: AF_XDP zero
 copy receive support
Thread-Index: AQHbfdimTCrInk+2SEelCx/NyLWzuLNNL0yAgAE7hYA=
Date: Wed, 19 Feb 2025 09:49:29 +0000
Message-ID:
 <SJ0PR18MB52167E19B3C11FAE6363AA9CDBC52@SJ0PR18MB5216.namprd18.prod.outlook.com>
References: <20250213053141.2833254-1-sumang@marvell.com>
 <20250213053141.2833254-4-sumang@marvell.com> <Z7Sf9VksFLFq2GwA@boxer>
In-Reply-To: <Z7Sf9VksFLFq2GwA@boxer>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR18MB5216:EE_|IA2PR18MB5849:EE_
x-ms-office365-filtering-correlation-id: ce0e8d29-a671-419f-a2ee-08dd50cab45d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?WitYRDA0S3VSTVlMaXVCc3IvQ3JGQ1JxKzlER0Q1M0dPMndZODlSbGtJbUhB?=
 =?utf-8?B?NnlFazB5aTQrWE9wRHhCbkp4ZklSd0hzcVhGbWpGYmdCS20vM3I1WHY1SnJo?=
 =?utf-8?B?RTRhMGJXeTVoWFVqVytlQkZCUnk5ZXQzRDM3RGlkQlU5NjdHMEo4T1FiT0ZG?=
 =?utf-8?B?N21oU3lRQ3hLYW9UejVpMmNFWXVTMUJDUEFvRGJadG50NWNaNktsNzJ4WlQz?=
 =?utf-8?B?Q2tCRUZPbmdzNHlyUUszTnA2THA3ZlVhNHF5bnlSL0ZYVG44RGFOU3RhdGZp?=
 =?utf-8?B?d2Y2T3VPL3p3Y1hlcXl4SHVaTHBqSERYdzRCdTh2REo0MTB5SHprUUQyYkVh?=
 =?utf-8?B?bjNUdUZJSTE3cll2cmRwR1MxV05kNmdNTTZpMVlvTSs4Rm15YWp4NVhHdTZP?=
 =?utf-8?B?Q0Q3a0pRSWFpRHRGZTc3YVUxSW9yWi9xZFF0WHZUbmMvT2RsVDZ5U1R3WkxS?=
 =?utf-8?B?aWFFanRqSld0Tm9ZWm1aQk5POE1RYU9tSHJDNjl1WGV6eGgrdk5nQUdUWGZ6?=
 =?utf-8?B?dS80cDhaY3hWYmkyU00rdEYxMURscHdpTFNTemQxWFJxNjQ0S1Mzd1BjMThi?=
 =?utf-8?B?cnRsWDNxR1NrS29QODF3VnZhbDhReC9PVGJWd0Zwd2o5TUlvZkl1T0E0MG9J?=
 =?utf-8?B?bUF4azlxcTExUzd2YVlEL09BZ2x2bjdsb3UrZkxodThzY1JHZ2FaMU8zN1F3?=
 =?utf-8?B?UWpnUGsyR1lCY1l3QTZuU0RhYzVuSllNOUN5TWlKV3VyUlVRSnV4SStvRG9N?=
 =?utf-8?B?VkFNUS92Nk0wQldiTFl2WVhMQ2VHdEVFbzY0cGtmWHBaeTNad0d0d25laFcy?=
 =?utf-8?B?cjRHTzdzbmtYYjBidk5tcVZTRFhCRWhTNWFNUWk2elpBSHdmeHFyTkJvODRr?=
 =?utf-8?B?ZFgyalZhZW5vc2pYcmZGSHB0b3pJSThFMTdDMjJvZTJIL3hvMUZNZUxnRlZv?=
 =?utf-8?B?aDJzR1BMb3NacFRDODl0c29OcHNnMEozc1J5ZDFNZS9UNjZGRHd3b0lXQnli?=
 =?utf-8?B?OTlRREZXcEpLYkRCTCtrSElua09aZDdkblE4cmxPcmNhU3ZlMDlaeW5mRzFO?=
 =?utf-8?B?WThYb1FUZGFDNmYrNG54VENJVGh0NVhCYkNjRk9YNys1VGpwVHFJMFZHZjE4?=
 =?utf-8?B?c3NnbVdRSGVqZ2YyWFdFWUxIWmh0dkQydVdxT1MrcVo4Y3dUMEdmVTFHbmRO?=
 =?utf-8?B?NmJhUDdoZlowbm5Pb0Q0OFBxMERoMVNxMDZvM1VWR1pUejhuQW9NMU1KUkcr?=
 =?utf-8?B?U3JXN3ltemR4NldNSmZ5aG9LNDRwRWtWa3hqZlVlS3JWeHl6ZTRLSjU3Z296?=
 =?utf-8?B?M2xVSzdDK0lGMUphZVVkMWxTYTBEMGNvRXBhbW1DdnJiN3lONWRVTHE0UDVW?=
 =?utf-8?B?WndwOEJnUklTcElBdUlvRUVDZDFSSFUzK2xJbDJJUFJiWjlVNjF6WXJPK3Rv?=
 =?utf-8?B?RWQyZU02bEs2RTlNem5YMHhPSWhZNmdNWUNnWHpzMU4xNWdzWHZkam9vMGsw?=
 =?utf-8?B?eWd4S24zN1RFMnpJZUkwY0I2NDN1bGt3NEZtUGNtUEJLTG13WDdxeEltZmNG?=
 =?utf-8?B?SExWK2Vra015RndpOXVJdm9wV01JZGxkR0Z2WSs1Ti9kamFwRy9UUGlMMWpm?=
 =?utf-8?B?dkhqUnhwNFIwMjFpUHB3V0ZvUG5tRVZZWklGaEdWVExxLy9HOUxkTVVZVVVV?=
 =?utf-8?B?SWxVTW9lTXNvVlBGT2wyRXNhWVJJcEVmbzR3WXc1K2pXNHNkOFpOT3Y4OSta?=
 =?utf-8?B?bW1OclRINmZ1ZG5FcGNiaTFncWQyVXZjSFBhajV3SFpvL2d4NXppVndKKzcv?=
 =?utf-8?B?SE44QTJLTDFFcVg2Zis5VDJWbzduMytEVWgxWWg1QzJMNE4xTlJ3RzVPWUw4?=
 =?utf-8?B?ZHpBbXdGdDYzQXdhZVkvc0ZjM2Qyb0JkNDhqTFJPd24xanZxWnhkQUN5TTdL?=
 =?utf-8?Q?YrJGe7TlC+zOYON5gHMHw/V+pwPLv3vM?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR18MB5216.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?OUhvdGVEbWdkYjVKZ1pmUCtJQzVsaGwrbWpJY3VZbVkvQ2RZNFhhM1lqcE1l?=
 =?utf-8?B?VCtTMXpiVjUxMThtWkNkbm5jWEZkK3dSeU5HZk1kaTFta2lLbHhPYUt3VjA4?=
 =?utf-8?B?TTVMUTJ2c0RocXFTU0NkVnZ4MytGRWZLeSsvWEtwS3A4aGNpS2FMWS90Y2Ni?=
 =?utf-8?B?M0Nhd3ZMV2h5eFBtMExJZHZHY2lFeUdjek92RGdHcllVNzJpUyt1WVN4TWpi?=
 =?utf-8?B?YWd5b0FPTjRHVUwwdEpyaHlpQlU4bGpCamRhZmVWcVBzNzA0aURoSmEwN2F6?=
 =?utf-8?B?VXNWb1k1NUVsLys1c21GS2RIaUJIVjBTQnFmOHlWN3RNK2llcUkyLzlJeWFQ?=
 =?utf-8?B?b0MrSi8xa3J3T1VFeDA2OUt2QW9RN2tUZ1dOUUtobXh1UFE3WVJDa0hSb1o4?=
 =?utf-8?B?Q0dHelZqckhiT1p5dDdNQ3hScVBYUlVGWnNIZE0yTnM5MnY2YUkwUXBydlI5?=
 =?utf-8?B?MTBrajM3cTJqZHlMYlgzbmMwUlZ5MzJ1WW5xbFAreGdjTkxRWFgzV0Vvdm9W?=
 =?utf-8?B?RDRGNGtudUVFbWNBaGF1c1plSWVSWXB4SGp5aEtJR2NuSVlZOXFVOFREdGFC?=
 =?utf-8?B?RFc2cG9TTE9YaEhaTU9SRENRS21ZOEo0UFc2MFNFYTBYVVVLWGYra2NUOUdw?=
 =?utf-8?B?cENVRHQ0eEFPQWU1cVJGWHNPSFN6akMwV3hPdmx5eUJ0eGh1ckVHUmRsY2tI?=
 =?utf-8?B?aXhYNmdGd0N6YmNGdTNTdXUrQ2xLMXJxUEl2cUNFb1dlTXhObjdFeXhXUW9J?=
 =?utf-8?B?OU45VlAwdHRhSVBicExRQW5nb3k0M3BMY0ZLRlo3b3lXQy9mVHljejF2N2I0?=
 =?utf-8?B?RGs4eEFlZ2JKd0k3amlOcVN5d3c4MmpIY2xXcjMvMnBLaUFPT0ZMa3RxQXBz?=
 =?utf-8?B?N0YxdHhoemtvMnVIQ0E0STZHSko5WHlFQ2ZmZjRzc3F4bFo0OGRnUTBJcUFH?=
 =?utf-8?B?cm93M0h4RTdlQVBoZW1Uc3I4NTNLeklOcjJtTXRpQktmd2l5Rks1Ylo5bi85?=
 =?utf-8?B?Q1F2Tm9SdmNralBQQTRTdHdEMSs0Ny9tVG9KaUZZRWY1T2NiMTlRMll3WDNm?=
 =?utf-8?B?NDRFWWc3SUZCWHJGSFZKNS93clZUaFcrVEV2OG9VOU5ONGZQMlpoVkk4K0xV?=
 =?utf-8?B?T3hUT1lOTG1MWVJIMm53MWFvTmRkZ3h2UkViQ2pQZHJERDcwS1BaSU5nOXNu?=
 =?utf-8?B?Tk5qb1RvSGdjaHp0S2JKNysrQmEwblJ0UFhNSFhqai9DK3ltNlo5L040b3JR?=
 =?utf-8?B?MGp3Y3dhc1E3bUlGNVVtZHk2RktlMWZMOWU4TmVKamdrUzU3ZUdPNjFDU1BK?=
 =?utf-8?B?bUJIM0tPT0JiT2xWcFZDL2NJaEJhcFhLZ0xNc21rNi9nY2dNME02NndjMFhi?=
 =?utf-8?B?YmJaVFg5azUySGhvckg4NEtPZk9xRkRNMmVFR1lLNXZyc0Vqc1pZMmlyQjEv?=
 =?utf-8?B?MFBuaUdHbWFpdkdrTTBXdGZlRE8vY3E5U1JlUHJLcnI5ZkNpQTR5MjNyWVFh?=
 =?utf-8?B?TzlkNi95V0Y1eSs0NE5yKy9ET3pLaTFZNytvWUNRZHZUQXAxa2pxNG0xc2NN?=
 =?utf-8?B?YTcwcEhydXoydmZMVW5DellYSnNKbm1rTTlDdnR1QzkwVFpLN3RFVUdwSmdw?=
 =?utf-8?B?aUFoUHdLZ0dNLy8zSmVCdlM0b2lFblk3WWplUEs2QUlMRDdRaWdocDJQZ0xr?=
 =?utf-8?B?bXRXWFMyN0V0TWVabzBENlJXRG1zcE9xN0dMVjgzdGxqeExkT1l3WnFkQXha?=
 =?utf-8?B?TVVvNnJoOS95TXZoQnhyMXQzUE51VWFlTnVPQWVnVGE0cVVWZ0xMN2Z5ZkVv?=
 =?utf-8?B?cEI1V3dReDVFYXpxZ0I0dGhEb0JPeUcvT002ZVFudXpDbW5ocHNFN3BBSnVH?=
 =?utf-8?B?UEVUMzY1WTlvYmE4bFZWTDdNRzJ6QXcrcWJpNllzeTlEcStnZmNLcWNTb3A2?=
 =?utf-8?B?MXoxY3dEVUFDRWFiUmJseXc1N2hHbkxoYXczM21zVkJoUlJKdExhUTNjbWxX?=
 =?utf-8?B?SUlBMXoxUUNidU8va3NpVTJEOExYWjhjdCtCWW8zZU9rcFJHSkhKU1BrNHRy?=
 =?utf-8?B?VlVKa3M5b0ZGV3ZVckhtNU9Bb3VleFVRRFFLaFcwYlFDTTdycU9DSGp6SUxZ?=
 =?utf-8?Q?6jhA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR18MB5216.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce0e8d29-a671-419f-a2ee-08dd50cab45d
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Feb 2025 09:49:29.6016
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aDgWnL78UsoU/Q78InHFV+aq5RzmqKkB/48V7HBoHkz6n+BnH/yhz+D2i5yeRa1+xp8wRO6M4cYwzxTC1eG2fw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA2PR18MB5849
X-Proofpoint-ORIG-GUID: Ffw3J2RsRhyI8y0dXUiS49kHO7ZF3gg8
X-Proofpoint-GUID: Ffw3J2RsRhyI8y0dXUiS49kHO7ZF3gg8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-19_04,2025-02-18_01,2024-11-22_01

Pj4NCj4+IC0JcHBfcGFyYW1zLm9yZGVyID0gZ2V0X29yZGVyKGJ1Zl9zaXplKTsNCj4+IC0JcHBf
cGFyYW1zLmZsYWdzID0gUFBfRkxBR19ETUFfTUFQOw0KPj4gLQlwcF9wYXJhbXMucG9vbF9zaXpl
ID0gbWluKE9UWDJfUEFHRV9QT09MX1NaLCBudW1wdHJzKTsNCj4+IC0JcHBfcGFyYW1zLm5pZCA9
IE5VTUFfTk9fTk9ERTsNCj4+IC0JcHBfcGFyYW1zLmRldiA9IHBmdmYtPmRldjsNCj4+IC0JcHBf
cGFyYW1zLmRtYV9kaXIgPSBETUFfRlJPTV9ERVZJQ0U7DQo+PiAtCXBvb2wtPnBhZ2VfcG9vbCA9
IHBhZ2VfcG9vbF9jcmVhdGUoJnBwX3BhcmFtcyk7DQo+PiAtCWlmIChJU19FUlIocG9vbC0+cGFn
ZV9wb29sKSkgew0KPj4gLQkJbmV0ZGV2X2VycihwZnZmLT5uZXRkZXYsICJDcmVhdGlvbiBvZiBw
YWdlIHBvb2wgZmFpbGVkXG4iKTsNCj4+IC0JCXJldHVybiBQVFJfRVJSKHBvb2wtPnBhZ2VfcG9v
bCk7DQo+PiArCS8qIFNldCBYU0sgcG9vbCB0byBzdXBwb3J0IEFGX1hEUCB6ZXJvLWNvcHkgKi8N
Cj4+ICsJeHNrX3Bvb2wgPSB4c2tfZ2V0X3Bvb2xfZnJvbV9xaWQocGZ2Zi0+bmV0ZGV2LCBwb29s
X2lkKTsNCj4+ICsJaWYgKHhza19wb29sKSB7DQo+PiArCQlwb29sLT54c2tfcG9vbCA9IHhza19w
b29sOw0KPj4gKwkJcG9vbC0+eGRwX2NudCA9IG51bXB0cnM7DQo+PiArCQlwb29sLT54ZHAgPSBk
ZXZtX2tjYWxsb2MocGZ2Zi0+ZGV2LA0KPj4gKwkJCQkJIG51bXB0cnMsIHNpemVvZihzdHJ1Y3Qg
eGRwX2J1ZmYgKiksDQo+R0ZQX0tFUk5FTCk7DQo+DQo+V2hhdCBpcyB0aGUgcmF0aW9uYWxlIGJl
aGluZCBoYXZpbmcgYSBidWZmZXIgcG9vbCB3aXRoaW4geW91ciBkcml2ZXINCj53aGlsZSB5b3Ug
aGF2ZSB0aGlzIHZlcnkgc2FtZSB0aGluZyB3aXRoaW4geHNrX2J1ZmZfcG9vbD8NCj4NCj5Zb3Un
cmUgZG91YmxpbmcgeW91ciB3b3JrLiBKdXN0IHVzZSB0aGUgeHNrX2J1ZmZfYWxsb2NfYmF0Y2go
KSBhbmQgaGF2ZQ0KPmEgc2ltcGxlciBaQyBpbXBsZW1lbnRhdGlvbiBpbiB5b3VyIGRyaXZlci4N
CltTdW1hbl0gVGhpcyBzZXJpZXMgaXMgdGhlIGluaXRpYWwgY2hhbmdlLCB3ZSB3aWxsIHVzZSB0
aGUgYmF0Y2ggQVBJIGluIGZvbGxvd2luZyB1cGRhdGUgcGF0Y2hlcy4NCj4NCj4+ICsJCWlmIChJ
U19FUlIocG9vbC0+eGRwKSkgew0KPj4gKwkJCW5ldGRldl9lcnIocGZ2Zi0+bmV0ZGV2LCAiQ3Jl
YXRpb24gb2YgeHNrIHBvb2wNCj5mYWlsZWRcbiIpOw0KPj4gKwkJCXJldHVybiBQVFJfRVJSKHBv
b2wtPnhkcCk7DQo+PiArCQl9DQo+PiAgCX0NCj4+DQo+PiAgCXJldHVybiAwOw0KPj4gQEAgLTE1
NDMsOSArMTU3OCwxOCBAQCBpbnQgb3R4Ml9zcV9hdXJhX3Bvb2xfaW5pdChzdHJ1Y3Qgb3R4Ml9u
aWMNCj4qcGZ2ZikNCj4+ICAJCX0NCj4+DQo+PiAgCQlmb3IgKHB0ciA9IDA7IHB0ciA8IG51bV9z
cWJzOyBwdHIrKykgew0KPj4gLQkJCWVyciA9IG90eDJfYWxsb2NfcmJ1ZihwZnZmLCBwb29sLCAm
YnVmcHRyKTsNCj4+IC0JCQlpZiAoZXJyKQ0KPj4gKwkJCWVyciA9IG90eDJfYWxsb2NfcmJ1Zihw
ZnZmLCBwb29sLCAmYnVmcHRyLCBwb29sX2lkLCBwdHIpOw0KPj4gKwkJCWlmIChlcnIpIHsNCj4+
ICsJCQkJaWYgKHBvb2wtPnhza19wb29sKSB7DQo+PiArCQkJCQlwdHItLTsNCj4+ICsJCQkJCXdo
aWxlIChwdHIgPj0gMCkgew0KPj4gKwkJCQkJCXhza19idWZmX2ZyZWUocG9vbC0+eGRwW3B0cl0p
Ow0KPj4gKwkJCQkJCXB0ci0tOw0KPj4gKwkJCQkJfQ0KPj4gKwkJCQl9DQo+PiAgCQkJCWdvdG8g
ZXJyX21lbTsNCj4+ICsJCQl9DQo+PiArDQo+PiAgCQkJcGZ2Zi0+aHdfb3BzLT5hdXJhX2ZyZWVw
dHIocGZ2ZiwgcG9vbF9pZCwgYnVmcHRyKTsNCj4+ICAJCQlzcS0+c3FiX3B0cnNbc3EtPnNxYl9j
b3VudCsrXSA9ICh1NjQpYnVmcHRyOw0KPj4gIAkJfQ0KPj4gQEAgLTE1OTUsMTEgKzE2MzksMTkg
QEAgaW50IG90eDJfcnFfYXVyYV9wb29sX2luaXQoc3RydWN0IG90eDJfbmljDQo+KnBmdmYpDQo+
PiAgCS8qIEFsbG9jYXRlIHBvaW50ZXJzIGFuZCBmcmVlIHRoZW0gdG8gYXVyYS9wb29sICovDQo+
PiAgCWZvciAocG9vbF9pZCA9IDA7IHBvb2xfaWQgPCBody0+cnFwb29sX2NudDsgcG9vbF9pZCsr
KSB7DQo+PiAgCQlwb29sID0gJnBmdmYtPnFzZXQucG9vbFtwb29sX2lkXTsNCj4+ICsNCj4+ICAJ
CWZvciAocHRyID0gMDsgcHRyIDwgbnVtX3B0cnM7IHB0cisrKSB7DQo+PiAtCQkJZXJyID0gb3R4
Ml9hbGxvY19yYnVmKHBmdmYsIHBvb2wsICZidWZwdHIpOw0KPj4gLQkJCWlmIChlcnIpDQo+PiAr
CQkJZXJyID0gb3R4Ml9hbGxvY19yYnVmKHBmdmYsIHBvb2wsICZidWZwdHIsIHBvb2xfaWQsIHB0
cik7DQo+PiArCQkJaWYgKGVycikgew0KPj4gKwkJCQlpZiAocG9vbC0+eHNrX3Bvb2wpIHsNCj4+
ICsJCQkJCXdoaWxlIChwdHIpDQo+PiArCQkJCQkJeHNrX2J1ZmZfZnJlZShwb29sLT54ZHBbLS1w
dHJdKTsNCj4+ICsJCQkJfQ0KPj4gIAkJCQlyZXR1cm4gLUVOT01FTTsNCj4+ICsJCQl9DQo+PiAr
DQo+PiAgCQkJcGZ2Zi0+aHdfb3BzLT5hdXJhX2ZyZWVwdHIocGZ2ZiwgcG9vbF9pZCwNCj4+ICsJ
CQkJCQkgICBwb29sLT54c2tfcG9vbCA/IGJ1ZnB0ciA6DQo+PiAgCQkJCQkJICAgYnVmcHRyICsg
T1RYMl9IRUFEX1JPT00pOw0KPj4gIAkJfQ0KPj4gIAl9DQo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9uZXQvZXRoZXJuZXQvbWFydmVsbC9vY3Rlb250eDIvbmljL290eDJfY29tbW9uLmgNCj4+IGIv
ZHJpdmVycy9uZXQvZXRoZXJuZXQvbWFydmVsbC9vY3Rlb250eDIvbmljL290eDJfY29tbW9uLmgN
Cj4+IGluZGV4IGQ1ZmJjY2IyODlkZi4uNjA1MDg5NzFiNjJmIDEwMDY0NA0KPj4gLS0tIGEvZHJp
dmVycy9uZXQvZXRoZXJuZXQvbWFydmVsbC9vY3Rlb250eDIvbmljL290eDJfY29tbW9uLmgNCj4+
ICsrKyBiL2RyaXZlcnMvbmV0L2V0aGVybmV0L21hcnZlbGwvb2N0ZW9udHgyL25pYy9vdHgyX2Nv
bW1vbi5oDQo+PiBAQCAtNTMyLDYgKzUzMiw4IEBAIHN0cnVjdCBvdHgyX25pYyB7DQo+Pg0KPj4g
IAkvKiBJbmxpbmUgaXBzZWMgKi8NCj4+ICAJc3RydWN0IGNuMTBrX2lwc2VjCWlwc2VjOw0KPj4g
KwkvKiBhZl94ZHAgemVyby1jb3B5ICovDQo+PiArCXVuc2lnbmVkIGxvbmcJCSphZl94ZHBfemNf
cWlkeDsNCj4+ICB9Ow0KPj4NCj4+ICBzdGF0aWMgaW5saW5lIGJvb2wgaXNfb3R4Ml9sYmt2Zihz
dHJ1Y3QgcGNpX2RldiAqcGRldikgQEAgLTEwMDMsNw0KPj4gKzEwMDUsNyBAQCB2b2lkIG90eDJf
dHhzY2hxX2ZyZWVfb25lKHN0cnVjdCBvdHgyX25pYyAqcGZ2ZiwgdTE2IGx2bCwNCj4+IHUxNiBz
Y2hxKTsgIHZvaWQgb3R4Ml9mcmVlX3BlbmRpbmdfc3FlKHN0cnVjdCBvdHgyX25pYyAqcGZ2Zik7
ICB2b2lkDQo+PiBvdHgyX3NxYl9mbHVzaChzdHJ1Y3Qgb3R4Ml9uaWMgKnBmdmYpOyAgaW50IG90
eDJfYWxsb2NfcmJ1ZihzdHJ1Y3QNCj4+IG90eDJfbmljICpwZnZmLCBzdHJ1Y3Qgb3R4Ml9wb29s
ICpwb29sLA0KPj4gLQkJICAgIGRtYV9hZGRyX3QgKmRtYSk7DQo+PiArCQkgICAgZG1hX2FkZHJf
dCAqZG1hLCBpbnQgcWlkeCwgaW50IGlkeCk7DQo+PiAgaW50IG90eDJfcnh0eF9lbmFibGUoc3Ry
dWN0IG90eDJfbmljICpwZnZmLCBib29sIGVuYWJsZSk7ICB2b2lkDQo+PiBvdHgyX2N0eF9kaXNh
YmxlKHN0cnVjdCBtYm94ICptYm94LCBpbnQgdHlwZSwgYm9vbCBucGEpOyAgaW50DQo+PiBvdHgy
X25peF9jb25maWdfYnAoc3RydWN0IG90eDJfbmljICpwZnZmLCBib29sIGVuYWJsZSk7IEBAIC0x
MDMzLDYNCj4+ICsxMDM1LDggQEAgdm9pZCBvdHgyX3BmYWZfbWJveF9kZXN0cm95KHN0cnVjdCBv
dHgyX25pYyAqcGYpOyAgdm9pZA0KPj4gb3R4Ml9kaXNhYmxlX21ib3hfaW50cihzdHJ1Y3Qgb3R4
Ml9uaWMgKnBmKTsgIHZvaWQNCj4+IG90eDJfZGlzYWJsZV9uYXBpKHN0cnVjdCBvdHgyX25pYyAq
cGYpOyAgaXJxcmV0dXJuX3QNCj4+IG90eDJfY3FfaW50cl9oYW5kbGVyKGludCBpcnEsIHZvaWQg
KmNxX2lycSk7DQo+PiAraW50IG90eDJfcnFfaW5pdChzdHJ1Y3Qgb3R4Ml9uaWMgKnBmdmYsIHUx
NiBxaWR4LCB1MTYgbHBiX2F1cmEpOyBpbnQNCj4+ICtvdHgyX2NxX2luaXQoc3RydWN0IG90eDJf
bmljICpwZnZmLCB1MTYgcWlkeCk7DQo+Pg0KPj4gIC8qIFJTUyBjb25maWd1cmF0aW9uIEFQSXMq
Lw0KPj4gIGludCBvdHgyX3Jzc19pbml0KHN0cnVjdCBvdHgyX25pYyAqcGZ2Zik7IGRpZmYgLS1n
aXQNCj4+IGEvZHJpdmVycy9uZXQvZXRoZXJuZXQvbWFydmVsbC9vY3Rlb250eDIvbmljL290eDJf
cGYuYw0KPj4gYi9kcml2ZXJzL25ldC9ldGhlcm5ldC9tYXJ2ZWxsL29jdGVvbnR4Mi9uaWMvb3R4
Ml9wZi5jDQo+PiBpbmRleCA0MzQ3YTNjOTUzNTAuLjUwYTQyY2Q1ZDUwYSAxMDA2NDQNCj4+IC0t
LSBhL2RyaXZlcnMvbmV0L2V0aGVybmV0L21hcnZlbGwvb2N0ZW9udHgyL25pYy9vdHgyX3BmLmMN
Cj4+ICsrKyBiL2RyaXZlcnMvbmV0L2V0aGVybmV0L21hcnZlbGwvb2N0ZW9udHgyL25pYy9vdHgy
X3BmLmMNCj4+IEBAIC0yNyw2ICsyNyw3IEBADQo+PiAgI2luY2x1ZGUgInFvcy5oIg0KPj4gICNp
bmNsdWRlIDxydnVfdHJhY2UuaD4NCj4+ICAjaW5jbHVkZSAiY24xMGtfaXBzZWMuaCINCj4+ICsj
aW5jbHVkZSAib3R4Ml94c2suaCINCj4+DQo+PiAgI2RlZmluZSBEUlZfTkFNRQkicnZ1X25pY3Bm
Ig0KPj4gICNkZWZpbmUgRFJWX1NUUklORwkiTWFydmVsbCBSVlUgTklDIFBoeXNpY2FsIEZ1bmN0
aW9uIERyaXZlciINCj4+IEBAIC0xNjYyLDkgKzE2NjMsNyBAQCB2b2lkIG90eDJfZnJlZV9od19y
ZXNvdXJjZXMoc3RydWN0IG90eDJfbmljICpwZikNCj4+ICAJc3RydWN0IG5peF9sZl9mcmVlX3Jl
cSAqZnJlZV9yZXE7DQo+PiAgCXN0cnVjdCBtYm94ICptYm94ID0gJnBmLT5tYm94Ow0KPj4gIAlz
dHJ1Y3Qgb3R4Ml9jcV9xdWV1ZSAqY3E7DQo+PiAtCXN0cnVjdCBvdHgyX3Bvb2wgKnBvb2w7DQo+
PiAgCXN0cnVjdCBtc2dfcmVxICpyZXE7DQo+PiAtCWludCBwb29sX2lkOw0KPj4gIAlpbnQgcWlk
eDsNCj4+DQo+PiAgCS8qIEVuc3VyZSBhbGwgU1FFIGFyZSBwcm9jZXNzZWQgKi8NCj4+IEBAIC0x
NzA1LDEzICsxNzA0LDYgQEAgdm9pZCBvdHgyX2ZyZWVfaHdfcmVzb3VyY2VzKHN0cnVjdCBvdHgy
X25pYw0KPipwZikNCj4+ICAJLyogRnJlZSBSUSBidWZmZXIgcG9pbnRlcnMqLw0KPj4gIAlvdHgy
X2ZyZWVfYXVyYV9wdHIocGYsIEFVUkFfTklYX1JRKTsNCj4+DQo+PiAtCWZvciAocWlkeCA9IDA7
IHFpZHggPCBwZi0+aHcucnhfcXVldWVzOyBxaWR4KyspIHsNCj4+IC0JCXBvb2xfaWQgPSBvdHgy
X2dldF9wb29sX2lkeChwZiwgQVVSQV9OSVhfUlEsIHFpZHgpOw0KPj4gLQkJcG9vbCA9ICZwZi0+
cXNldC5wb29sW3Bvb2xfaWRdOw0KPj4gLQkJcGFnZV9wb29sX2Rlc3Ryb3kocG9vbC0+cGFnZV9w
b29sKTsNCj4+IC0JCXBvb2wtPnBhZ2VfcG9vbCA9IE5VTEw7DQo+PiAtCX0NCj4+IC0NCj4+ICAJ
b3R4Ml9mcmVlX2NxX3JlcyhwZik7DQo+Pg0KPj4gIAkvKiBGcmVlIGFsbCBpbmdyZXNzIGJhbmR3
aWR0aCBwcm9maWxlcyBhbGxvY2F0ZWQgKi8gQEAgLTI3ODgsNg0KPj4gKzI3ODAsOCBAQCBzdGF0
aWMgaW50IG90eDJfeGRwKHN0cnVjdCBuZXRfZGV2aWNlICpuZXRkZXYsIHN0cnVjdA0KPm5ldGRl
dl9icGYgKnhkcCkNCj4+ICAJc3dpdGNoICh4ZHAtPmNvbW1hbmQpIHsNCj4+ICAJY2FzZSBYRFBf
U0VUVVBfUFJPRzoNCj4+ICAJCXJldHVybiBvdHgyX3hkcF9zZXR1cChwZiwgeGRwLT5wcm9nKTsN
Cj4+ICsJY2FzZSBYRFBfU0VUVVBfWFNLX1BPT0w6DQo+PiArCQlyZXR1cm4gb3R4Ml94c2tfcG9v
bF9zZXR1cChwZiwgeGRwLT54c2sucG9vbCwgeGRwLQ0KPj54c2sucXVldWVfaWQpOw0KPj4gIAlk
ZWZhdWx0Og0KPj4gIAkJcmV0dXJuIC1FSU5WQUw7DQo+PiAgCX0NCj4+IEBAIC0yODY1LDYgKzI4
NTksNyBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IG5ldF9kZXZpY2Vfb3BzDQo+b3R4Ml9uZXRkZXZf
b3BzID0gew0KPj4gIAkubmRvX3NldF92Zl92bGFuCT0gb3R4Ml9zZXRfdmZfdmxhbiwNCj4+ICAJ
Lm5kb19nZXRfdmZfY29uZmlnCT0gb3R4Ml9nZXRfdmZfY29uZmlnLA0KPj4gIAkubmRvX2JwZgkJ
PSBvdHgyX3hkcCwNCj4+ICsJLm5kb194c2tfd2FrZXVwCQk9IG90eDJfeHNrX3dha2V1cCwNCj4+
ICAJLm5kb194ZHBfeG1pdCAgICAgICAgICAgPSBvdHgyX3hkcF94bWl0LA0KPj4gIAkubmRvX3Nl
dHVwX3RjCQk9IG90eDJfc2V0dXBfdGMsDQo+PiAgCS5uZG9fc2V0X3ZmX3RydXN0CT0gb3R4Ml9u
ZG9fc2V0X3ZmX3RydXN0LA0KPj4gQEAgLTMyMDMsMTYgKzMxOTgsMjYgQEAgc3RhdGljIGludCBv
dHgyX3Byb2JlKHN0cnVjdCBwY2lfZGV2ICpwZGV2LA0KPmNvbnN0IHN0cnVjdCBwY2lfZGV2aWNl
X2lkICppZCkNCj4+ICAJLyogRW5hYmxlIGxpbmsgbm90aWZpY2F0aW9ucyAqLw0KPj4gIAlvdHgy
X2NneF9jb25maWdfbGlua2V2ZW50cyhwZiwgdHJ1ZSk7DQo+Pg0KPj4gKwlwZi0+YWZfeGRwX3pj
X3FpZHggPSBiaXRtYXBfemFsbG9jKHFjb3VudCwgR0ZQX0tFUk5FTCk7DQo+DQo+aWYgdGhpcyBp
cyB0YWtlbiBmcm9tIGljZSBkcml2ZXJzIHRoZW4gYmUgYXdhcmUgd2UgZ290IHJpZCBvZiBiaXRt
YXANCj50cmFja2luZyB6YyBlbmFibGVkIHF1ZXVlcy4gc2VlIGFkYmY1YTQyMzQxZiAoImljZTog
cmVtb3ZlIGFmX3hkcF96Y19xcHMNCj5iaXRtYXAiKS4NCj4NCj5pbiBjYXNlIHlvdSB3b3VsZCBz
dGlsbCBoYXZlIGEgbmVlZCBmb3IgdGhhdCBhZnRlciBnb2luZyB0aHJvdWdoDQo+cmVmZXJlbmNl
ZCBjb21taXQsIHBsZWFzZSBwcm92aWRlIHVzIHNvbWUganVzdGlmaWNhdGlvbiB3aHkuDQpbU3Vt
YW5dIFRoYW5rcyBmb3IgcG9pbnRpbmcgaXQgb3V0LiBJIHdpbGwgY2hlY2sgaWYgaXQgY2FuIGJl
IGF2b2lkZWQuDQo=

