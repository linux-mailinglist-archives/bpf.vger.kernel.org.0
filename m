Return-Path: <bpf+bounces-48534-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B1326A08C35
	for <lists+bpf@lfdr.de>; Fri, 10 Jan 2025 10:35:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A0978188D707
	for <lists+bpf@lfdr.de>; Fri, 10 Jan 2025 09:35:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4244209F4D;
	Fri, 10 Jan 2025 09:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="KlI83ISR"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 882541F0E40;
	Fri, 10 Jan 2025 09:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.148.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736501694; cv=fail; b=SvU3PLxjjMWqvP7KXhA1hJ9F3BywoHi8AVuCUzeqptDgh2C3MsEMG/nkl8iWGeWOXsaSJYiakuvj0ff3ISnuFkmZUgtS7/lvOXZGzVwDKTN2RD6HPqc1z3Z/otx6bSb6wVWxHfaQIZ2XtEA9zEKvgd3tTi8ZuIY1mzbUWT8fs50=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736501694; c=relaxed/simple;
	bh=9dDKL9eik/cXsi4xkkgJUxDDZUDfHOMzdUwYBcbncT8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HoB2KfKNAkBepmLESlP4ObK5j9Lfrb2iNk+mbY6vtAW5b/2pv8xEnbZoSyYQlWLfKDI1IqA8F9UspMiC+FCO34nsM5S4P+1DkrHYB4GI2HplAjnk76Rh1es2gfHg00jmFmpfoVGW7hnxvYVEUA9wyNcEpUac3GvvH8oZo26wgdU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=KlI83ISR; arc=fail smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50A9Y6ab008188;
	Fri, 10 Jan 2025 01:34:23 -0800
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2044.outbound.protection.outlook.com [104.47.58.44])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 44311d001c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 Jan 2025 01:34:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HULqw0XIytGeexCFQ2hwiQt0HGnsD7csfM5gKxL3dT08RkQ5UPkFh4sR3tHUxKjmJlxBDhq/EtoqAXT379PYSjraGrXJEu3f5TSBU6oaRasxroAvxDitXTpNEm7nTezkckq42HfTYSFxzMGsF5IiHH58K4wPFwk5/ZJBSxPUZnnjpI7ZjQt/diwJ4KP2G1dxf/rj8z6nhAdut56WbnsXgSjhaqLvVS1YTZX8mbAXzTCHBMJlEureYGNLc7IdvJZ7pSfTTP1ZRLxPWEj5Tb3CR6vL5wtvVkbw/jPqyToado4DW5qu6LFBOjXD3iBz69v1mZIU4bOXjqN16KJF9R2a1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9dDKL9eik/cXsi4xkkgJUxDDZUDfHOMzdUwYBcbncT8=;
 b=rtdzO0GxXtwVZeHswNGLohfKwN55JES1GCXchpIlpYn2gInhYbqrMyH3dMCMlEa5oVHW9HDsH9+hTvLDFZ9oPTP/VLoa4czU7zCBYDTMBtHBw+m/5UFWvbSlY3nmopwYREggEXQTfbEG1sFTaIyroKCw/fe7BeDrBkyIbiy5R01TcIM/5Zx09j94/PF84bSBppx+r5xpSOMZCHUVQjJ7TliX5sBQi3+psSd2kzsddzAxIxIhIQIqhjcsXRlylr91Qzu8q6w0UMeDO6IfR2Xgbhw64VpgaIu12OjNEmUv7yrd0qssuun5ygiEJvzlCH11uRUhgl4SAbzDf6y8d4Q2Cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9dDKL9eik/cXsi4xkkgJUxDDZUDfHOMzdUwYBcbncT8=;
 b=KlI83ISR4UwpuUQEJFG5t6mD7OADGlzV5Hht37ZMzzJNPC9Z1/XDxaBix7tj6FWav2FZ2DHSAQcmUxxPkI2tEgXWFR0lO9/nXWzBP2hcoUBMT9sJGaMd920mli+9QON9QfW8tKmsY0JBfIcXqZHk7eSSrvw5qr6kyAEW8ev/huc=
Received: from SJ0PR18MB5216.namprd18.prod.outlook.com (2603:10b6:a03:430::6)
 by PH7PR18MB5356.namprd18.prod.outlook.com (2603:10b6:510:24f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.11; Fri, 10 Jan
 2025 09:34:20 +0000
Received: from SJ0PR18MB5216.namprd18.prod.outlook.com
 ([fe80::2bf5:960a:a348:fad1]) by SJ0PR18MB5216.namprd18.prod.outlook.com
 ([fe80::2bf5:960a:a348:fad1%5]) with mapi id 15.20.8335.011; Fri, 10 Jan 2025
 09:34:20 +0000
From: Suman Ghosh <sumang@marvell.com>
To: Simon Horman <horms@kernel.org>
CC: Sunil Kovvuri Goutham <sgoutham@marvell.com>,
        Geethasowjanya Akula
	<gakula@marvell.com>,
        Subbaraya Sundeep Bhatta <sbhatta@marvell.com>,
        Hariprasad Kelam <hkelam@marvell.com>,
        "davem@davemloft.net"
	<davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linu Cherian
	<lcherian@marvell.com>, Jerin Jacob <jerinj@marvell.com>,
        "john.fastabend@gmail.com" <john.fastabend@gmail.com>,
        Bharat Bhushan
	<bbhushan2@marvell.com>,
        "hawk@kernel.org" <hawk@kernel.org>,
        "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
        "ast@kernel.org"
	<ast@kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: RE: [EXTERNAL] Re: [net-next PATCH v2 3/6] octeontx2-pf: Add AF_XDP
 zero copy support for rx side
Thread-Topic: [EXTERNAL] Re: [net-next PATCH v2 3/6] octeontx2-pf: Add AF_XDP
 zero copy support for rx side
Thread-Index: AQHbYfvlYF6ezsSXU0WRY7oZC9skmLMOnwQAgAEiglA=
Date: Fri, 10 Jan 2025 09:34:20 +0000
Message-ID:
 <SJ0PR18MB5216E69E76EEA7F4A1F0D386DB1C2@SJ0PR18MB5216.namprd18.prod.outlook.com>
References: <20250108183329.2207738-1-sumang@marvell.com>
 <20250108183329.2207738-4-sumang@marvell.com>
 <20250109161400.GK7706@kernel.org>
In-Reply-To: <20250109161400.GK7706@kernel.org>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR18MB5216:EE_|PH7PR18MB5356:EE_
x-ms-office365-filtering-correlation-id: 66ee317c-a7ef-42bc-f76f-08dd3159f5c8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?dy9FMzB4ZytTaUk0YjJLNTR5MEYrTUxkRFVhR1VYMzR2RW5DWG1DWHIyME5l?=
 =?utf-8?B?MkQwQXd4ZE5Jb3NHWmpFNHU1QXMrQSthM3B2azZBMVJiRHhjZGFhQkdqa1Mv?=
 =?utf-8?B?UVhLVk9SY20wYktqaFJHVkVZR3kxMCtWaVlrbkM2NHd2cUxRTVRzVHR3M0xZ?=
 =?utf-8?B?emM4SkpDMFh5Y3ZrVHphOWtLR2puOXRVUGUzc3FLSUl3bWM4VElPL3Vsd0Ev?=
 =?utf-8?B?NGhqbCtpcmVFQllobldDYXMxcUJ1RHVyM3dBNk9hUWhCYTZNMXRLWFpGUDZy?=
 =?utf-8?B?U0FwN3VMeWhxV1U4aVgvSkJmL3RKOTk4MnBnNU10VnY2azlCd1dMUHFhbXQz?=
 =?utf-8?B?QmFzeVVPUmFBeVBlYlJ1Q29ENlVZdldvdlVLRnhSM2FaWVhPM1dRekJpY3Nk?=
 =?utf-8?B?YXNrZVI1Q2REWU5EYWtBUVVxeHMrd2lLbVEwanU1ZUFoZ3B4bTJjWGM0Yys2?=
 =?utf-8?B?d1pZZkJGN25PazhBSjRGTitCTGMxbjNjb2FqUHZVcmJhR2xIWmpwT0lpdHZu?=
 =?utf-8?B?UEphTTZkaWxvRWZQMXBrN1dES2Z6TkhZaDFIK2llSXVPN1RZV0VpQTRUUmxG?=
 =?utf-8?B?OGVEWW5ub3dPMTJxemlvclJLczg3R0pObWRybTRPaDN0Wm5MOXVyd2dFVm5m?=
 =?utf-8?B?UGtraDI5K0xLSEFXWWNwYjVIOU9ab0dEanU3aTE1cHFHbnZISFE1NzFrNVh1?=
 =?utf-8?B?TW9lR3lFQS9KYm9aZFVUWGw3eVU3L2dHM3E2Tnl0b2Zva0lVNm5MVy9XenFj?=
 =?utf-8?B?Y2ViVVZIRi8vQkRFL3E5aCtlRWJ1U2h4VURsMFVJOEV6Y1huL3NHWlZ2YTZq?=
 =?utf-8?B?aTd1dWgxbVRMbFh2dm1wdXJHSnlSNGNFekYrL1JYLzRGNXlwd1hla1ZvcXpQ?=
 =?utf-8?B?TFlVZ2hIaE9iR2NKd3FKa1FvT1hVL2ZtbWlKMnZZNmwxVUhieXJ4VFlYOGpO?=
 =?utf-8?B?d2hQNC80b3BZVzQ2QWVHbTRzZkVOWjZOTEdxSHE2QkVvR2t5OXQ5UVNqMWMx?=
 =?utf-8?B?WGg0djNZTTd3amR5c0p2eTNFOUJsQ2xQcW03dzFoMVkxVHo3NUVsYzJidHkx?=
 =?utf-8?B?WVplZzNpazN0ZE05MVlVOHFDM2t0SG1FSkxYN2JtSnJEUkRoSEhIS3RYMS9R?=
 =?utf-8?B?bm1YdUJRZ3JwQjA5ZnFMY25mdWRmSzc0Y3ZCZ1hqSmljY2pDclpSQVVxR2lF?=
 =?utf-8?B?N21QY2c0SUZtQWViamdiQlNydnBheHMwbkxsaUxzZlUxRkx6RG5uSkxtZVh1?=
 =?utf-8?B?NitCMEJEN2xSUXRQalk2N0orczZtOEtCYms2MnRLK2tSejBwOXZtRm5xOUNl?=
 =?utf-8?B?bG1BcTY5YjllY0tncEY0czdRWmVKeThQeW5xcUVHc0tuSXJYWGYzekNlZGha?=
 =?utf-8?B?SWxMM083NDNXUXREaVhCa3JyY0VrbGxOekUyZnpESGhTN2lYVEhSWmw3OVo0?=
 =?utf-8?B?Y2lGR1VqQ2YvWm44ZWtWZVpNaXR6UXFVVStZRHdrVmpZR3drdGdhMTBtWlhj?=
 =?utf-8?B?VDJsM3JiVXFWUlJ6SXFWVjJGdjZFWXpnRDNoNSs0bFdjNzdGL2RMdWY3UzNj?=
 =?utf-8?B?Q0xqcng4TjQwUTRPMjVnZGxvbFUzbVBTQUY0eUk1cVdleWpwRnBpU3B3WlZm?=
 =?utf-8?B?RmpleW9FMlUyK2ZpR2hoU3ZpZ2Z1dzVsYnN6citSNmovUW0yYUxwS2xZc1NX?=
 =?utf-8?B?WE1HZWRRYzhkNzI1aSs5RWZad2IrM0lHWVRYS05zTjJVTmpOY0lTbmVHbDFa?=
 =?utf-8?B?cXMyOHcyZWxtb0pCeVpnOVNBekRpcytFQWplaFZwUTIvNGpzU0pRUUc1Ry8r?=
 =?utf-8?B?Yk5Fa3BMZFNxam5lYmtnWGVubnlPaHNrSWRHbTRrcGY0WnBwaUpVd2RFQzJN?=
 =?utf-8?B?dXhJN0hrMis2ZGpKQk5odW95anNCZHN5ZU1XZFRkMGNuYkhyczkxZUNJYW9V?=
 =?utf-8?Q?51fZHOsfGPPn1AnxYkKw5350jhla/4Pc?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR18MB5216.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?YUg2MGZrWHlYVXBZenVKUktxc1ZGWVhNTXcxa3d3eXcwa1lGVHlMbUQxYnZm?=
 =?utf-8?B?VWNZQlFCekpSMERHUzlMcGNJZVFkWjlIT2pjcXFhVGg2RGxBRTg5YUZ0Ukkz?=
 =?utf-8?B?OEpJclFzbXUzWDNGV2E2V1N6K01GWldYakRwQ3RqSGI0c2tXbEpTVytvRXMy?=
 =?utf-8?B?OHhyVngvWEJtOEYxRVNaa1VTbWgvRmxRcE80dnBzUVgxSHZNOWM2eXd2Tktj?=
 =?utf-8?B?UWV2YWZXdDFUaGFUbERoeWErZkRBTjUyK1A5dW1NU24weSszc2ZMTjlDTWZw?=
 =?utf-8?B?UnRLVERqd0VSNXBENzY5eFUxKzBlZE5Wdkt4dkhSYVdkZjU5dnJHcDJ1d3Np?=
 =?utf-8?B?Tk1QRkN2N0dXTmNZN3Q2ZHY5T2NtU1BhRDZmbkx1aVNjUExLclZYb1lWdkhh?=
 =?utf-8?B?NW5oTURKeHR0R0NteC9BdlV3N2N1bCtXQWlDM0VtbzdxaG5QclhxZ2ViZTkz?=
 =?utf-8?B?V3dNUjI4ZDU3TnI1cEZ0U1MrM2FFeFVUbnZOWjZrMlNKQTdWQXJWRTV2a2g0?=
 =?utf-8?B?QzVZZFljQ0NnWnhDM01yY3R2OFVHVjZPRGpsZHNVRFlubHdNL0J1dFRrZ2lp?=
 =?utf-8?B?V2dMcmNxdWIyK0ZEc1BiTytqNXBhRnFBdHJzOFdESHhqYzNCTHByeTUyRGdm?=
 =?utf-8?B?NDNNUDgyODdOOVZoeHVwOVFMa2UvemlEYjA2OVFyTDZkbXZjU20rY2pNV2lW?=
 =?utf-8?B?cndwb0U5MEhieXZ6OFZrcFJPMjNsNUVoNTF6Rk1Kdmc2Y1g1S3hYdFdPb09u?=
 =?utf-8?B?TEptTzBZbEY1d25TSXYyMnJpK052ZjNIeXNVVjg4UkdRWXgvUDhXVis0Yzlx?=
 =?utf-8?B?d0ZDM0drYjVBYmd1R3E3TW9FRGFzU1JLdHZQOTN2MlkzdmRrV1o1bXE4NTJq?=
 =?utf-8?B?M3EyazdQb1UvUlZ2WkFzaTA0cDBWc1BCZUF0alQrRGIxYVRIYWdQQjB3OUZh?=
 =?utf-8?B?dXBRNHBsM1hTVzFHU0VzS3VqSDEzdEViQXgzZHRxTVhITjNoSXhldmI0dEgw?=
 =?utf-8?B?cUVIb1ozL3kzbzFJVlpBcTQ2UWRkcGR6aVpvZzJNMDk4Z0F5VVdzVUZLRVph?=
 =?utf-8?B?b0hRbVpaZlB5Zm5zODZhVXd3TTJvK1NKRHgwRFd3ZHRvVUowbVhBY1FjTXB3?=
 =?utf-8?B?TS82bnp2cTROSWtTK2h5ZnNjb2hQVkJYaktOU05ENkpMRVh6UzZ1TENRNGU2?=
 =?utf-8?B?Zmo1S051bGhUNHV5UGltQ2JNdzJaMExxcDhiS1d6bkJwYzlTSGkvd01ZNnN1?=
 =?utf-8?B?eFlQdGxHUlArSDI3a3dpWVVrbUNma3ZPMGJNRlVwazdGRzBxNGMzZ0R4d3o5?=
 =?utf-8?B?K0s0ZWlOL1pNNDdKSlExdkUwQk9pbTFsaDNVTEpyWmxFQ0daZFhwMjVGajBP?=
 =?utf-8?B?Sk9vYStnVHB5TDlOcis3YmJjVTFjcDZIK2d1ZVlqd0p6WWN1S1o1QjViTmpi?=
 =?utf-8?B?TDVSSHlWOFhrMEMrZDU5THBkZEVqOXVicGRRQ01PNEV4TTNRUVc5VFJrZ1VQ?=
 =?utf-8?B?b29BanRQaXVQWlFadllNVkMwaStxK0lXUU0ycW16RDdLWjBSSHlGaXhLcHdF?=
 =?utf-8?B?V3dOV1R4Q2NMNWRGbWJ6ckd1b0I5bStUaGhBN2JlK2lCbWQrMThwa0psMHJz?=
 =?utf-8?B?dElTdHF6TVpvYjJwKzNmeHBNdHYwLzJEb1puVHhQcHVtNVJCZ241T1Jya0x0?=
 =?utf-8?B?ekFYRmNiK21id3V1ZnV2bmRYTGlVK2ZHODRKNXUxcTJuYWErWGdKOXhzN3Jz?=
 =?utf-8?B?UUlKOWk3cnFaSTRuWXMxbko3NUQ2Z2ZYaDVSUDF3T2NjUnlvQUZYcjd2UEdK?=
 =?utf-8?B?K2piMC80ZTNVdklvUWV6T2Y2d1dkdExhM1dwZTNjRGExTi95NENBUERQTE5J?=
 =?utf-8?B?WEhYZXdORVBJMTlkY1J1bWR1YmJ3THRtelRxZFFwNEt5U1Z5d1dsT3RuSFFi?=
 =?utf-8?B?SnpON0s1elR0Rm1CZmNyaXZTaXpsSEVlMkltODMzVFhkZEthVkdFUFVvd0ty?=
 =?utf-8?B?TXc5QzRxTjFhSVZuQS9EQitVSzBGbG10NTRlZStMNHdTVWlrelhyaVFUYkRn?=
 =?utf-8?B?VWp2c3lLWjgxbEpHNC9nUUdZZzdPR3JwWDJ1UzFYd0ZEMVVjMUtMb0N1Wno1?=
 =?utf-8?Q?/rvw=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 66ee317c-a7ef-42bc-f76f-08dd3159f5c8
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jan 2025 09:34:20.1842
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KmMNvPSJVaUGA9H6pIyqvcXnkv8JeEiTeUp+C7K9/FwdLJsohpdqu5TSAnbPN+l+DOxeO8SDhyYGqAwQCKUo9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR18MB5356
X-Proofpoint-GUID: CtdNipp9uhvvACzIEKd6AqIwxYlzvijD
X-Proofpoint-ORIG-GUID: CtdNipp9uhvvACzIEKd6AqIwxYlzvijD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.687,Hydra:6.0.235,FMLib:17.0.607.475
 definitions=2020-10-13_15,2020-10-13_02,2020-04-07_01

SGkgU2ltb24sDQoNCj4+IEBAIC01NzIsMjAgKzU3NSwzMSBAQCBpbnQgb3R4Ml9uYXBpX2hhbmRs
ZXIoc3RydWN0IG5hcGlfc3RydWN0ICpuYXBpLA0KPmludCBidWRnZXQpDQo+PiAgCQlpZiAocGZ2
Zi0+ZmxhZ3MgJiBPVFgyX0ZMQUdfQURQVFZfSU5UX0NPQUxfRU5BQkxFRCkNCj4+ICAJCQlvdHgy
X2FkanVzdF9hZGFwdGl2ZV9jb2FsZXNlKHBmdmYsIGNxX3BvbGwpOw0KPj4NCj4+ICsJCWlmIChs
aWtlbHkoY3EpKQ0KPj4gKwkJCXBvb2wgPSAmcGZ2Zi0+cXNldC5wb29sW2NxLT5jcV9pZHhdOw0K
Pj4gKw0KPg0KPkhpIFN1bWFuLA0KPg0KPkZXSUlXLCBTbWF0Y2ggaXMgc3RpbGwgY29uY2VybmVk
IHRoYXQgY3EgbWF5IGJlIHVzZWQgdW5pbml0aWFsaXNlZCBoZXJlLg0KPg0KW1N1bWFuXSBhY2sN
Cj4uLi4NCj4NCj4+IEBAIC0xNDI5LDEzICsxNDQ3LDI0IEBAIHN0YXRpYyBib29sIG90eDJfeGRw
X3Jjdl9wa3RfaGFuZGxlcihzdHJ1Y3QNCj5vdHgyX25pYyAqcGZ2ZiwNCj4+ICAJdW5zaWduZWQg
Y2hhciAqaGFyZF9zdGFydDsNCj4+ICAJc3RydWN0IG90eDJfcG9vbCAqcG9vbDsNCj4+ICAJaW50
IHFpZHggPSBjcS0+Y3FfaWR4Ow0KPj4gLQlzdHJ1Y3QgeGRwX2J1ZmYgeGRwOw0KPj4gKwlzdHJ1
Y3QgeGRwX2J1ZmYgeGRwLCAqeHNrX2J1ZmYgPSBOVUxMOw0KPj4gIAlzdHJ1Y3QgcGFnZSAqcGFn
ZTsNCj4+ICAJdTY0IGlvdmEsIHBhOw0KPj4gIAl1MzIgYWN0Ow0KPj4gIAlpbnQgZXJyOw0KPg0K
PlBsZWFzZSBjb25zaWRlciBwcmVzZXJ2aW5nIHJldmVyc2UgeG1hcyB0cmVlIG9yZGVyIC0gbG9u
Z2VzdCBsaW5lIHRvDQo+c2hvcnRlc3QgLSBmb3IgbG9jYWwgdmFyaWFibGUgZGVjbGFyYXRpb25z
Lg0KW1N1bWFuXSBhY2sNCj4NCj4uLi4NCg==

