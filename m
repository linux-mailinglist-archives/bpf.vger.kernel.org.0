Return-Path: <bpf+bounces-48971-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 00197A12B00
	for <lists+bpf@lfdr.de>; Wed, 15 Jan 2025 19:34:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5C5F3A821B
	for <lists+bpf@lfdr.de>; Wed, 15 Jan 2025 18:33:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AF9A1D7E26;
	Wed, 15 Jan 2025 18:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="rb4Xt6jY"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BC3E1D5172;
	Wed, 15 Jan 2025 18:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.148.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736965907; cv=fail; b=pqMxL+I6Y4oHAGjv/6Xytp5uwIZjzZFAnDc8N5VYUnb880/QK6l9peZp4x41kHPoZGn/BXQVaCmFtJTEYRTYPqSMSdbv4W78OhXjzZCNiK7UdP8+k/pnfOiBNcR7G8XQzzwDsKOMcGGvuXWFSQ+kBh/Vr8hnls/eYW/PqBoaxrI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736965907; c=relaxed/simple;
	bh=nXTUVbMsGpwmmJGNd3293iiN7F1MPVSKXnnS0y1zG4I=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=IDTXDPnt8pLCMG6oriEjWd3lY6Cxqn01cihTlrDc0V8hETigWADJTeevwqCwI2j/bxRvuw0mQ3IsiVBHJmZy5tn34bNxYqwwSN41gTWFYh7oDP8Vn51n392MnYPQO4mYCUg69K6A/xzUJuHs1lYwqHf30gilQcMFjT9smyF90Bs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=rb4Xt6jY; arc=fail smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50FF3iY8024421;
	Wed, 15 Jan 2025 10:31:25 -0800
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2040.outbound.protection.outlook.com [104.47.58.40])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 446fb30f5t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 Jan 2025 10:31:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=COIKWv77V6B94Lx82CS3UX97xZlJhy+lsbsI3oCJTu1ZxUQ1n5WSnHW7/B3lAyzwzrlcuLlrXVO83sBIPdtxRI/C0ax30PIkmLUxk083qfGAlB2Ntszl+RXz5f3dhGr0iQGyHv4Ah7N2ZwygLVj0eO+gNWon0G7zVG/FxZIJVw8Ujg12N/HqRETd+GYgW5BDulW3uixO3oXELYvDMORJeNZWHZg4d0U8GdJ7QsR8QKTivhd0OI8iQmW5Kkc6FwoOwsrhk4TBXd7x+5JFzGr1zcnp3HO8cDaJE3eHt2mRsZXGGq7/mbfkYQBq7tSEbh3osB0oSqeloEk7pdubQj7LDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nXTUVbMsGpwmmJGNd3293iiN7F1MPVSKXnnS0y1zG4I=;
 b=IoeVjGuNID04sZSzMSCZiE/GRttoy8f1rKq8dHRogNnV9yl56cp7tnI6D8wLgW/g8jA2/cRY7OfWhkJR2EO9S4Ytnjxzv7mniu6q/G/03N7kh1deElL2vVOG7De/CzseQvzB/9nAoOfG1PClmE+tr0BHQhto9r+x0Yx8DJeq8Ngm8YJTXUO1BKnmhWstwZnLf4tfuynArbPSgLJkhMPsNV/MuvLM8Fbm2AzWvmW4sn/bBdiioO+EMoBkwLxtII1Jt0YvW6mMeAUF6hbmWdEX6PFjoG+msAPNrrGM2seONXlHJgrF9e5cso/lRyiD1b6sPB/aW6HUfV20ffWFK7De4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nXTUVbMsGpwmmJGNd3293iiN7F1MPVSKXnnS0y1zG4I=;
 b=rb4Xt6jYZJ5JRFpJz+QfkUeXY593TBXvjBhgQpxTiAU9vydXMVCR6zsC7CzrXXX3oCiieIMmbsz3s7oM8nX2JEGGRy3mDE3lAzcKJ6vubZ8mKGj+AZx5p4EKOX0BEASz62IjmaFhRab/626zspYAhrQU0cSc9ktBN3yFWPT3b+U=
Received: from SJ0PR18MB5216.namprd18.prod.outlook.com (2603:10b6:a03:430::6)
 by DM6PR18MB3537.namprd18.prod.outlook.com (2603:10b6:5:2a4::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.14; Wed, 15 Jan
 2025 18:31:22 +0000
Received: from SJ0PR18MB5216.namprd18.prod.outlook.com
 ([fe80::2bf5:960a:a348:fad1]) by SJ0PR18MB5216.namprd18.prod.outlook.com
 ([fe80::2bf5:960a:a348:fad1%5]) with mapi id 15.20.8356.010; Wed, 15 Jan 2025
 18:31:22 +0000
From: Suman Ghosh <sumang@marvell.com>
To: Paolo Abeni <pabeni@redhat.com>, "horms@kernel.org" <horms@kernel.org>,
        Sunil Kovvuri Goutham <sgoutham@marvell.com>,
        Geethasowjanya Akula
	<gakula@marvell.com>,
        Subbaraya Sundeep Bhatta <sbhatta@marvell.com>,
        Hariprasad Kelam <hkelam@marvell.com>,
        "davem@davemloft.net"
	<davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
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
	<bpf@vger.kernel.org>
Subject: RE: [EXTERNAL] Re: [net-next PATCH v3 3/6] octeontx2-pf: AF_XDP zero
 copy receive support
Thread-Topic: [EXTERNAL] Re: [net-next PATCH v3 3/6] octeontx2-pf: AF_XDP zero
 copy receive support
Thread-Index: AQHbY0Nx43bEYrYu2EOhQMHw2kVr7bMWPjkAgAHyg1A=
Date: Wed, 15 Jan 2025 18:31:22 +0000
Message-ID:
 <SJ0PR18MB52164594C0C0C24C0AD50C71DB192@SJ0PR18MB5216.namprd18.prod.outlook.com>
References: <20250110093807.2451954-1-sumang@marvell.com>
 <20250110093807.2451954-4-sumang@marvell.com>
 <49043623-f34e-4274-ab4d-494d8319cb32@redhat.com>
In-Reply-To: <49043623-f34e-4274-ab4d-494d8319cb32@redhat.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR18MB5216:EE_|DM6PR18MB3537:EE_
x-ms-office365-filtering-correlation-id: 22a92510-b2ff-4dc9-d811-08dd3592cff5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014|921020|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?cG5GeXU1RlRMcUQxWk1xSjdDTEhITWpZQ2N5aUJGaUNDcW9VSnFndENZZkty?=
 =?utf-8?B?ay80ZCsrZFVoWkd2cE1YV1k2UUdNcStPTlB5VUdmM01LZk9mV1NhMXU1Vkk1?=
 =?utf-8?B?ZmNuVkRtVmVIMW1YUFZtWlFjTk1SaUpFcmZyTmdKRWJISjhsQTFtMVppcXNw?=
 =?utf-8?B?UW93OXgxMmdJTHVuYWZ1UkZUWGQ0a0JvMldzTXN6RzEveTl4TXJWaWpIb3dQ?=
 =?utf-8?B?dGpSV3c5TmtQQmFiZlczVTdwTUFJQmFXaldsaEIwOCtpQW5OLzdKUHcyc0Zk?=
 =?utf-8?B?LzdEUUQyYzNjQUxmMXBsY09wckhybE5vRzByaml6WG1iaThKbC9JN1RiYjVv?=
 =?utf-8?B?MTd5NW5tRkR2cGpHTjNMM0JXT0x2L09kUGg0SjRNMDV3S3RtZGg5d2NpMnBh?=
 =?utf-8?B?RGZOdHJVWUVrWnRQajVIbkc0akU3YXJhMlR6QzNLdE96eEtDeGQ5T2FqYzcx?=
 =?utf-8?B?ekUrQkM2amlrcC9Md3prS2RUL2hyajY3aGhCVVp6M1hYdzBmc2N1dElLVGpu?=
 =?utf-8?B?dGRyUnJzdDFLRmpUOGVTdEg4aUxZMW5CdXcxbXp2dHhWeE01RUV6UGdZemMw?=
 =?utf-8?B?RXVWSmFHUElXWlJEVTRtd0w0a3p4R2ExMnloM0NjZXBIZ3hkcU1ETCtxbTA5?=
 =?utf-8?B?SG9ScWFEUXhWYndDVWxiZEs1MzYrUUhiemxBMWRrZUZLKzBtUEdxUXdDaWdi?=
 =?utf-8?B?ODZla1JtMDJ3Y0J0M3J3eWF6VEZiQXNHb0FWc0dONFhpS2ozMHdBMUJCU2x2?=
 =?utf-8?B?ZGx3SFdmekVhYTRqcjBXYXJpMndveUQ1eGxCSC9WUXNGNWkybzlmUFFJQWNs?=
 =?utf-8?B?VVQ0eDYyU3pHZjBSQmMrcXZ5NFNhejhzTHE3aDJkdDNMMnZKMG5GRGc5bkI2?=
 =?utf-8?B?OXMvUmlPUHFDL3JDaVlpZDRHOGJwRVdRWHVXUVVlWUc2a0pvTzcxMzFOVWI1?=
 =?utf-8?B?QVFPM2NPWlI3Z0t0TVhXaTR1UFVqc1NGTWs0VW5kSzN3c2ZWMFhRcTBxR2NG?=
 =?utf-8?B?M3Rmdjdmb1V5NUp3bTRyUllHTXA4SEF2RGcvMUpQSE04ZDFjdjlXeUFKeERv?=
 =?utf-8?B?SWRCNUFISUZUK3FSQlJscjBOWVh0emppNm5YaXlYUmhBWTI0OUt1TU1aSzdC?=
 =?utf-8?B?WTRnNmtJUUVRSjA5dDVibnl5MnZNOVR4WW5KcTgrcitTK2ZGNWN2V0NBVzZy?=
 =?utf-8?B?WDJ1eXU4ZzRWZUFjWUdmRmxLd2VYUkRZRGxuTU9aV3VJS1NFVzFaY0JzUVJE?=
 =?utf-8?B?ZEFGNUxYVWkzNWpPQkRuTmlCQjhCa3ppaHRTZTV0eE52ejE2TXpZaVFyLzZ5?=
 =?utf-8?B?Q0JtSWFrbk82SnNhcWliN2JvSE4vTXhJUEREQUhUUThrMm5OYmVQdlhzMjV2?=
 =?utf-8?B?dWxxbXB1aDBCdHlRVythUHlyQXQzbG1qY0dYTUs5TEp5WW1naFpyblJYU0Jj?=
 =?utf-8?B?SFZGS0VIbm0zSHRKWE9WRDFka1ptUENEWm5CU0sxdERDZ3pQN0tNL0Z4aWlt?=
 =?utf-8?B?R3hrTTVYTS9CNG1hSmxVcU4zdmtUUDhySlNxaGRTN0Iyam16a3RNYkhKREg5?=
 =?utf-8?B?cXlxazRueEllTFFEUlZGVloxWkJxZEYwUVpuVFVYRTU5VGVKTko0eWR6U1d3?=
 =?utf-8?B?c1AwRklETUVZZEZwbytxdTlzcmFSYzlDemlqUDlCaXVWdkU2bVJtZ290K0JH?=
 =?utf-8?B?QXFEQko1SnRXOUhCQmxkbk5nczFkU1QwakV1NVFPK1NMQno5TDVjSnFSaWZk?=
 =?utf-8?B?V2pOVXRQNU9pWkk1NDMvM3dOUnBxOUY4Z1dXWk91dVhQSDBBblRPWkR4aVQ2?=
 =?utf-8?B?VUkwQUpxYWhoUEplMFUvZlowRVkxYUcrT0xzam1ROVg3aElJbDl2QU9XVEQv?=
 =?utf-8?B?YUVjK0JoTTZ4ZVBtT0ZFcVhWVzBJa3hVNXVYcWsxNUhZT2g4NDVXQ1V4WVA5?=
 =?utf-8?B?cGF4YnBTQ2c0dUh2Q1J6bUk2eXl2clJ2U0h5SmgvRTFaTkExK20wWDFPNm9w?=
 =?utf-8?B?d1FwcXo5QjV3PT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR18MB5216.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(921020)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?K2NZKzlIcFZTN0p1NFYwTmtGVEpHb3lFOGkrdnAvc25FTnp6TnFITkY4RStS?=
 =?utf-8?B?amZuMysxTDdRMWoraHc2Y3J4WDM5QjUyOThtZjNrdWRhdUhIU0NUb0NjTGhw?=
 =?utf-8?B?QU5wM1pWcXhQcDhCTmErQ0RLaCt3TTFveFpKbjBPeC9kUjBtZExpbU85N2Ny?=
 =?utf-8?B?QXpqcFJkSXhMaVpYaFJyMVcrZXZwblYwNE9jTnR4UDNDRnA3dU5lczI2elph?=
 =?utf-8?B?NzZ2V1EvZHRWZlA3dlVaWks3TklmZkt5c1U4djBZV3pIUS8yeWJBRmg2QkFt?=
 =?utf-8?B?bStXWnNNcWo2a0RhYlU4aGJoMUV1UVdvQ0NTZ3h1cG43UHdacDZNdlEyWk1N?=
 =?utf-8?B?MHFkL0lNSmdTR21yMFJEdXNvZ2p5azlLaWd2UlBIZllMaXFqM1lNdjB2ejR2?=
 =?utf-8?B?R0lmNGZ5Q0NweUZ1aThZSkkvRHlHOWFOeGpjUGJEbnZVaFZtdEU1N205YUxX?=
 =?utf-8?B?VkliRDRFU0JNc3FMOWZrMmpyTWdIRlFSbnVFdWNwc3RuVUZBZHlEZFN3NGxX?=
 =?utf-8?B?Ry9NY2dUVVo4aTZkTU1xNWx4ci85ODRMZTFybjFTTHA5SWtpbC9QK2c4SVdF?=
 =?utf-8?B?MHRBYWpoRkk1SWI4TnkrNzF0Q1FwYWY5Y3VlUzUrS09Qa2lYdERnK0NaVWt6?=
 =?utf-8?B?eVZxN2ZFVkZDRVYwMkRvM2daeldaN29IY1Z3TERTU0QrQ3FoUVdhTWpqcEN5?=
 =?utf-8?B?T0FCMGs4UmpTemRmaU1xc3M5M29VVTJxRHBEQ1VHd2xJdHRoemJFQ3FJc01T?=
 =?utf-8?B?Y0xtRTdjWW1ORmFDK1NrZTBacjIwQ08yMDYxVDZ6YWJiR3NQN1A5am9WY3hv?=
 =?utf-8?B?UGhPQkVxdFpEVC80dGJPai9ZWFdjd2pMcFB1YWJQZEcwemtqUXRvaHF0VjU4?=
 =?utf-8?B?ZWFqSzd4M3d1eFpmUEljYVNyZGFaOE9Tc2wwRWgrQ3FWTjVBZ3A4UWpkMGZa?=
 =?utf-8?B?QUlVZXZ0a29rQW5MRzBxbGQrNXAzbE9QMzRKS1RxWE0zZFZ2VGxLRzBaMUZ1?=
 =?utf-8?B?eWIwUXI3V21zcTNxMXNVdjVBcjByYXluVE9FV2FyenRSVVZrcWd4c2tDcFEy?=
 =?utf-8?B?MkxMVUJTbW14d1dWU2o2Z2NsdFcxems2WUFVYlFZRHFKaEVVNlVYcXFYcWlo?=
 =?utf-8?B?ays3aU4xRU10TTFNYUxNR2V5YlZLaHA1S2tGYlN1ZWNYRFV6Q2dHRUpLSGU2?=
 =?utf-8?B?NFRuNDdjeVVwSkdzYlpkMHFVTTlJWExBSnZaVFVtRGEvVWJ1VkJnY1phVXdM?=
 =?utf-8?B?clJHdVRVU3JxWGF0a09WSG52RVpjUVZKRTVYSk5NcGtBbEZSdWxGQ3kyZG5C?=
 =?utf-8?B?WWZzdjBROVM0SzUzRXRTWnBvL0pxUS9zakNzazZ3d3JCTlJZekhnMWtDd3l3?=
 =?utf-8?B?SUFIbzUzWjZrK2RkSnZ2SkJyY0FWMkNzZkpCakZweVFraWE0WW9maVRrdUxi?=
 =?utf-8?B?WHVsUVVXYUhiaVdRQzBBdkRDdHBNVEhCYmVFM2czRjBGaG85WklvajkzNTl2?=
 =?utf-8?B?NlppQmpSMGF5RDFGOVNPVXV0QzZtdEZNNDl6MWdKSldvR1RybVJRWGx0Mllv?=
 =?utf-8?B?NXN3YW9GLzNsbVJzd2dFNytLT015WWFKOG9wRVZScFQvRG1ZZHh5cGRidG9a?=
 =?utf-8?B?WlhuVHBFOEF6VU1GSFdldFdpM0pHYkRNZ0tOMURSU2dYWHAxWnhzUWZYT1FG?=
 =?utf-8?B?ZGdCank1RHRpc3ZVbGUxUXF3YVRseUp4WEhHQzZxdWNNcFR3UExrLzBCRktU?=
 =?utf-8?B?M290aUx6MlgyMUtQSFZaZEVhVmtPVWN2Z1diU2tRcnhtdE5BSC9nUWdPd3Ft?=
 =?utf-8?B?dTExV2RnRFpjU091aHBqczZhOHVOK3hUZVRrUGpCTC9za0JoTVcrMUJjR2sx?=
 =?utf-8?B?enpyYU85R3VucFFRTGxRbEhJMWx1Vk9RUXV3V0hGUGVFZTM3MUI1ZkRZYU41?=
 =?utf-8?B?ZW9YUVVBVThxZXMzL2FvSGE2ZjR5R1NXckUzczNYUSt5YmRsVDNrNDE1amFN?=
 =?utf-8?B?RncyUWhLYk1mTk5JL0UxTG1rSWplN1hXNE1sWmVjait5TStGV0t6RzhSSlFl?=
 =?utf-8?B?TXZyaEpLUFNPaWtnK1NjMThlUzJ5NERwd0h6UERRaDRMOCthbklvZjZjNEFh?=
 =?utf-8?Q?45A1aL8Tis7PwJdWpv3NAu1yz?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 22a92510-b2ff-4dc9-d811-08dd3592cff5
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jan 2025 18:31:22.6927
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mfmo+E+LMxuzF6ZvRYPYU+iFeMI13iWW+BKeG+/VFmK2L1VIX9MO3Qu+O19fPmZFfZMZ1gb8x1ABhZ2qJyonvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR18MB3537
X-Proofpoint-GUID: spzx4SecSvpgc2KiWQHtJiriKTVnYq6R
X-Proofpoint-ORIG-GUID: spzx4SecSvpgc2KiWQHtJiriKTVnYq6R
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-15_08,2025-01-15_02,2024-11-22_01

Pj4gQEAgLTEzMzcsOCArMTM1OCwxMiBAQCB2b2lkIG90eDJfYXVyYV9wb29sX2ZyZWUoc3RydWN0
IG90eDJfbmljICpwZnZmKQ0KPj4gIAkJcG9vbCA9ICZwZnZmLT5xc2V0LnBvb2xbcG9vbF9pZF07
DQo+PiAgCQlxbWVtX2ZyZWUocGZ2Zi0+ZGV2LCBwb29sLT5zdGFjayk7DQo+PiAgCQlxbWVtX2Zy
ZWUocGZ2Zi0+ZGV2LCBwb29sLT5mY19hZGRyKTsNCj4+IC0JCXBhZ2VfcG9vbF9kZXN0cm95KHBv
b2wtPnBhZ2VfcG9vbCk7DQo+PiAtCQlwb29sLT5wYWdlX3Bvb2wgPSBOVUxMOw0KPj4gKwkJaWYg
KHBvb2wtPnBhZ2VfcG9vbCkgew0KPj4gKwkJCXBhZ2VfcG9vbF9kZXN0cm95KHBvb2wtPnBhZ2Vf
cG9vbCk7DQo+PiArCQkJcG9vbC0+cGFnZV9wb29sID0gTlVMTDsNCj4+ICsJCX0NCj4NCj5JdCBs
b29rcyBsaWtlIHRoZSBhYm92ZSBkZWx0YSBpcyBub3QgbmVlZGVkOiBwYWdlX3Bvb2xfZGVzdHJv
eSgpIGhhbmRsZXMNCj5jb3JyZWN0bHkgTlVMTCB2YWx1ZSBmb3IgdGhlIHBhZ2UgcG9vbC4NCltT
dW1hbl0gYWNrLCB3aWxsIHVwZGF0ZSBpbiB2NA0KPg0KPi9QDQoNCg==

