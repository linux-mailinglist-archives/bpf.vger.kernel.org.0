Return-Path: <bpf+bounces-51221-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C69DA31F56
	for <lists+bpf@lfdr.de>; Wed, 12 Feb 2025 07:45:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 669873A3430
	for <lists+bpf@lfdr.de>; Wed, 12 Feb 2025 06:45:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BE571FCFD8;
	Wed, 12 Feb 2025 06:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="tk611ifx"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8816D1BB6BA;
	Wed, 12 Feb 2025 06:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.156.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739342743; cv=fail; b=tsl+pOCRNOveduWQRFQgaXZrE1vXg4oTkr03L0RrUKqI5Y8jzHwTLvzFlm3Gcq//NoSXfIiajWSI1C6MhH3fjbo/Rz5qjmZkXqFrG+NvNuqrn1W3S2huh/fCfk/EfGRaFLCB2n6hbntsnghKK2/aXAlYTPWlmL5eg2TpD87jxOY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739342743; c=relaxed/simple;
	bh=Aqp0VJEBae4Y6byqkWX/fBfqB60ZgdEB8Bn0bQ4Msa0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gj69fZJkpYBum/C+FBfrF85QQeZ5sCTBYr4PVRH++6Bs4A4SZBKVaKN7CgP1lXxQWRnBKypoc41UXXUyQFVgmBIaeJ85UxpqFIvtODx2GW+49hKm+vPQPXwWgxviWjuIke8C2IYdhisGZNQiMIlGMTffoYKQR2Jh4qjpMjinhi4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=tk611ifx; arc=fail smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51C6Wrwq026989;
	Tue, 11 Feb 2025 22:45:19 -0800
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2043.outbound.protection.outlook.com [104.47.66.43])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 44rpfcr0qq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Feb 2025 22:45:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DPBVhSzMM2WiM3Dle4EkxvqwWy0m643r4doYjEsKOtzhJDU/e3bcC3fcad3KdDXsUm8qUDJywjELTSq2GT2aX9fJ/xjJJiTZv6Ih0+nmQOkWh0c6109scT5P0I33kY6YSAIO6cOIIT74xvFlvLoWhH8WIOrpgVmH4NDye8fl1g6jFxx6ts01yuYMk4hn1sERQXoK1y1A8PxHuHhgZRCJMlfJH/iagvksolJOw+iDAZM4Pr3R4n0v31qI3eZMOclqqdPSVYrf+PwfSRpYOkEZTPX7WknCYoUfbjJtLcOr9Eri0Dll0Fy+Uiz2PxJWFGItYBaKJQx6kb/TxEZE/waUdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Aqp0VJEBae4Y6byqkWX/fBfqB60ZgdEB8Bn0bQ4Msa0=;
 b=NWxr7ND64FyYVFrH+PiSkO03dDkOfb8CEj0YJLvuuX3gx20J0B50UT2llnsG7KKOzB3x/m0dd5XkHKPpcqt+Nl4ykjMNpEP7LBqlZcifPnxE0kcc1uqd8tSoy4QtX1Z93PfBDTGV15y6SVRB3Xek8zZR7bhjxDQJAneKgcOXdwLK+OEdSpPJeIt6d47LnMmPnq9O4KdA8ktkildFxwQla6Uk5SmJWi6Rsw30CMWxZ1+IM5GhAKfqKGRw/OtG4Ywe7ecKaJHKI9VN23knfqqnxs1q7ho7tONI2WApASCWt1BrLXTQBNjJNZWHYnjaNa/DxW3FH99mGl03O2uVsfcPQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Aqp0VJEBae4Y6byqkWX/fBfqB60ZgdEB8Bn0bQ4Msa0=;
 b=tk611ifxCWs7SefSh5BO5Gitt84pThBV5FV2bEvpD5UFkEyq0wARnE7sQqhcfdDkvAz3Jysc48HEWoMpjXvKf9DUBS8Ic/x7PQU9UjG9CAV2isRE9EsT+qMlwxs+YQWBCC2pxAjENVrwgRiI3Jmn1lKM/uZeSmnEPm9Yz+uMgJA=
Received: from SJ0PR18MB5216.namprd18.prod.outlook.com (2603:10b6:a03:430::6)
 by LV8PR18MB5654.namprd18.prod.outlook.com (2603:10b6:408:186::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.11; Wed, 12 Feb
 2025 06:45:17 +0000
Received: from SJ0PR18MB5216.namprd18.prod.outlook.com
 ([fe80::2bf5:960a:a348:fad1]) by SJ0PR18MB5216.namprd18.prod.outlook.com
 ([fe80::2bf5:960a:a348:fad1%4]) with mapi id 15.20.8422.012; Wed, 12 Feb 2025
 06:45:16 +0000
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
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "larysa.zaremba@intel.com"
	<larysa.zaremba@intel.com>
Subject: RE: [EXTERNAL] Re: [net-next PATCH v5 1/6] octeontx2-pf: use
 xdp_return_frame() to free xdp buffers
Thread-Topic: [EXTERNAL] Re: [net-next PATCH v5 1/6] octeontx2-pf: use
 xdp_return_frame() to free xdp buffers
Thread-Index: AQHbeHRMkvDltmfsOk27Y2q9umEI8rNAv/OAgAAYYwCAAmnyMA==
Date: Wed, 12 Feb 2025 06:45:16 +0000
Message-ID:
 <SJ0PR18MB52165A2B9D6A396C3946EE29DBFC2@SJ0PR18MB5216.namprd18.prod.outlook.com>
References: <20250206085034.1978172-1-sumang@marvell.com>
 <20250206085034.1978172-2-sumang@marvell.com>
 <20250210162543.GF554665@kernel.org> <20250210175300.GH554665@kernel.org>
In-Reply-To: <20250210175300.GH554665@kernel.org>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR18MB5216:EE_|LV8PR18MB5654:EE_
x-ms-office365-filtering-correlation-id: 7b3cafa0-f063-472c-50a7-08dd4b30cf8f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?b2EzMnVxcFFMbzF3czhMbFJrZGdPblVJY2NpZ0FiTHlvMHVpOWlwbnZpTlRZ?=
 =?utf-8?B?NWhvS0FkVlAvQVBOMTZPM0Q4RE1HVngwYzAxNXl3QlNVRHpTQkhCTSttVWpm?=
 =?utf-8?B?bUVwOTRqcFB2UzNiVkgrK0IxSEl5ZGo4Y28zSFUzQkg3TG1CMDRyMWQ2NHo0?=
 =?utf-8?B?M2VuNGdHTjhOTTBaaXM5NE1FWGR3Q3hJVzc2TUExbFgyeDlkOS8zdFZOOEdl?=
 =?utf-8?B?aVlQYjRrVVlkY1RBZWVXT2Z3bHJiS1gvMFdObkZtSnFWZjc0WWdtR2dya1Jt?=
 =?utf-8?B?YVdVWDg2U3MrWFUydFJUNEd3UGpMR3pLdS9sZldhYVM2WVJrRFVleXJoMFZl?=
 =?utf-8?B?aTR4R1JNVHNPc044d0pUTGZCbnVucDlacVhPamtDSm4xK1JEVUxDRktCM0kx?=
 =?utf-8?B?Z0Vycm4rVzVhZDJpdFBEZG1mdHRsODJVNGtNT0FPZmdraFphOEZUOVUzODVy?=
 =?utf-8?B?ZFRPakM4M2FFZGpNSkxmQmtvalp4MHV0Yit3ckJGY3dsckkxdWsvMVlGZmh3?=
 =?utf-8?B?c1FSeUZoVW5KNUtqVGpzc3F0TFdFckcxdmluTTl2K3cwbHUxU3VpRjZaMkow?=
 =?utf-8?B?VnZ5YkN1bHJvU3BTczJTaW5ad0pza3g3MVBOUEVCdXdYMUorclVSU3RFa2Fw?=
 =?utf-8?B?M253dHhudTA3RHFLWGVLQStISTRjeWVna0pNdUJvUzdSTGZ6UFRRNFhYYUpK?=
 =?utf-8?B?ZC9uWnNhcWh6VlRzMG9PQnJtTE9kQUNaM29ET1BtZmtJMnRDOG0rbSttQVQ4?=
 =?utf-8?B?UHNTWnRDcnJhd3JYK0c0OUxkRzUrVjRrTXhSRDNWYnZXOEkzRHZ1cUQ2WTdP?=
 =?utf-8?B?TW1aV0RtdjJtdm1oZWtQbFVBM3hqMGFxUS9kanBBNHhEOHhvOU94QmRxejIw?=
 =?utf-8?B?bjdjWDVyS085MExJSFBjUlY4MzZBUDNseUZZbEF0TTFBYXpNdzJPU3A4R0d5?=
 =?utf-8?B?TnB3UnVQRUg5eFk0UGNkb2RxWjhwYTVzZ0dJVS90N2EwblJ3MStDb2o4OFFk?=
 =?utf-8?B?NlNhUE1SeS9HblIzM040YjRWaWV4QnhQNERQUWk4cmpPV3FmdFd6a0wyWDFM?=
 =?utf-8?B?YzRJRG4rU1JKTUhDSjhNejBWdWtNRTVKMkNXeTRHQXBYaGhab3dmZUp5K05R?=
 =?utf-8?B?ektUYXV2WXBkZXJzU2s0K2oybUtIalkyVEFHZmdoNkF0Y1FYQXpiMk5SOTF1?=
 =?utf-8?B?NjlFbGpWR3U0elJOa3VreDl1VTlBSzJvb2Z2elV1cE5VWENpcjVlQlgzanV3?=
 =?utf-8?B?cVl5REZyZ3hDWDJJRml3c05ONVAwcWxuYnpGNW9WaFZwdlkvQXNKclJOR3lO?=
 =?utf-8?B?T21UeXh5ODB6bDBzaHRsQTNEK1hhUUlVb0g3NDZVUTlCWmJacFk0OHFFbjFh?=
 =?utf-8?B?MnlGNnZQaGRtRlgzSjNqMWhWRm13YWZFN1htVDBCR3M2ak5oVW84bFcyV010?=
 =?utf-8?B?Ny9veExueVFHR0k5S2tOK3JrN2FxYXhSRldtbGRidTFCMWpKQ0JMWkd2b2Zx?=
 =?utf-8?B?M0VBRkF2TCthcTNDZFhvSjU1ZWwrWnhXRzdPSEIySVJMcUJVOFlmVEVNVUVE?=
 =?utf-8?B?Rkh4SVNPeXBzbmdSQklXWWYyb29LOXcvcUtvRXdhZWltOGRSZFN5WDg1UUR2?=
 =?utf-8?B?UG16NUZOWlNhU25tK0l1UE5iNGZwYkZLdU83cGFNT3lxZ0RhWS83SEJ2cDB3?=
 =?utf-8?B?S1dHVVVCWnFPMjdYMGU4ODR4NEJZNW9XUmJveEdGM1ltcTJOWUl1MWNNL2dO?=
 =?utf-8?B?QXphazk5VTRoNTZ1c0N2Wnl1MW5iVWx6dGRJdG1KU2lVdThKWTFZbWFJYmpZ?=
 =?utf-8?B?bk5YMzBoSlZIUXhZelIxcUV0cldlZG1ZWkNCZjh3alhnaUdlZkZmNWx3THB6?=
 =?utf-8?B?VXJwNzRZenB6S2RkcEY1Y3NhYzBvdzgraHB0QWl4ODVyOGJvT1NoS0JxTmtv?=
 =?utf-8?Q?ZKyIib7brVfQpPT8SYvNSRxHXcgLKLnU?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR18MB5216.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WkZBYlFWRUFncWkyVDRRb3J1RjlPbXlaVmQ3akg2SXdDUCtoVVlYTlI4bjhq?=
 =?utf-8?B?TVlPK1FrN1ZZa0ZiQUxSU3UxZFZFWlJESlpuZlFEZzQzWFhmU2hJQ091UUVM?=
 =?utf-8?B?cWFWaUo3VjRHblp6TFR1U0R0aS9nUmpROFVtc0x0UzhUaGlaWjBvUkpmMjhZ?=
 =?utf-8?B?VFVaUHdSRDJmcHVLRy9WOHdlR2s3K0lnOGhua24waDNPM2tVaXEvc1J6QjlJ?=
 =?utf-8?B?NWFPajIxV09MRnRXRklGalR5NWhSNnpnUnd4QzZNVlBSWWNLNXVLQ1FGWEs0?=
 =?utf-8?B?WW1OdS93V2JRc0xYTW9xZHhoRm90Qk12a0FlWXB6WlNSNENWVmdFYUFFQlFw?=
 =?utf-8?B?VTNTcEpZdlRoUnFTUGo2elkya2ZtQjJVRmpYTUN0TU9vRUFkc0tlUEszYVFS?=
 =?utf-8?B?S21VMWxoTnc3UWUvbWhvZXZtanNCNXdvYkVFMWtHRGI4cEZLZVV3c0xVZ0po?=
 =?utf-8?B?UkRxTHZ3V3N0QkdEVFlRTWhMREhUUEp4ZHVFTWZheUIyRFYxdmVGeVA1dWY3?=
 =?utf-8?B?RmhMYXlHNzdKb2R3QlBlbVRZekVWZnBrMjk2YUFkMFlVMzcrVjFtL0VnY0dD?=
 =?utf-8?B?MHF3Y2xWNGlGRFJpUjZaNW0xYXVldXlabm84NVFLUnlwMVo4ZlRpUHpJZFR6?=
 =?utf-8?B?b2lOZStrbVNPT21qdWdaSUYxcm1NQnVBeDIwUXpndS9YVU9xQ2JLSnFoWmtD?=
 =?utf-8?B?VVc0VnhOZzNIdVg4RGN3RU9BVHpYUGdWeTVsLzRyZXNHdHV3bU5aMmFlK3My?=
 =?utf-8?B?YS9lelNoMlBoVHZwc2I4MHp1a0pFN0dMY0wvejNtOTkrYXRGSHlrMCtQdDhU?=
 =?utf-8?B?T3BSQUpQenNuQkRkS3BvVWUwK2h1bGJDejBTT3RIVUJXMTlxT2NkTmJYWUd6?=
 =?utf-8?B?aFllU29wdkJNMjBSTUZaS0ovaGRCVU1vOVVhcWQ0ZTlLcWlNNytjUkVUZ0pG?=
 =?utf-8?B?eVR1bUhDZDE1Mk80MXNPS1JXWmptOTh5eDBVOGQrVVJVK28xUW9lekQ4V3RL?=
 =?utf-8?B?MDZZVmVxdjViYlVzY1JuekJkeW1DOGxndUYvcExYUEdqSEN4cVh2UWhZWTN6?=
 =?utf-8?B?L1pjbjVMcWxhMW05RkdTRzhJWWc2V3EyUXQ2T3B0SlQ4a1hIQXNtSStpZ3pm?=
 =?utf-8?B?cVVseS9RWUN0ZmRMWE91cHYxL210L3NhQ1UwdWhCZTB5VHJPTGthZTROb1pO?=
 =?utf-8?B?YXJ3aUN4dlB1SU9pckkweURkRVZsR1dualVRODRMNWVsNmhqQlFwN1kzNmt6?=
 =?utf-8?B?aWkyaUpUbnlmUHB3aHV5MlFNWHFGaWdRRTNtZlBwejk2V1dOSmtibnEwYVN5?=
 =?utf-8?B?YXdhNEZqUStVcTg5SWdHVTM2S214SEJ2dE1RMnNwelp6dGtkYkk4amp5TWp6?=
 =?utf-8?B?eHQ1NWM1d3h5aHhhVG1sNzdLZERra0xKOHRKTkhXblVYRkxXNWgrT3hlVjFR?=
 =?utf-8?B?eWtwWEpGdUpaWE5xa1dUY3JRUzFzMVhmNGUxOE4zZjhYVXN2VEpCcEdlSmJH?=
 =?utf-8?B?Q3hhdWhqUW02ZVZWb1M5MmE0d0E2a1NKeUF0QkdvSU5INmZuT3J4aFYxUm4y?=
 =?utf-8?B?bmVJT28rOEJENVF6MmVLbHp6RTN3b1czZFlLclp5emxSYzNuUWsrRkNUemtu?=
 =?utf-8?B?aEQ4dGZFTTVrRFRRY3NtaU1ReXBMRXpoYVY4cklFZUR6VkY4dkw4VmE1Q0gw?=
 =?utf-8?B?WndDMVdNaFFZS3lLNlNzYytBT0drOWRxdGE0cXh5OEg2eEdXTXhlWThNREl2?=
 =?utf-8?B?cmFMOGtjNWRWYW1uaG5YN3JUMmZvaGN0VHZLNWtheVBaWUlVL1RCd2xDYmpR?=
 =?utf-8?B?NEdhaHFIL3JFVzBrT3hjNFhuVGFhSG1JYjg3SlJJbVRxSGFEVFVZUVp1V0xV?=
 =?utf-8?B?Rk9lNG9BRjFvOFpaNGV5MlY5WEcvWHFXYTI3NStNZHhQK0o1VnRFMUFNbFh4?=
 =?utf-8?B?ZFdRSUhRT1pPeVpocHI4TU9peGFmZGo1eC8yeGhiWkpuNFJXQUNuNm94NkNt?=
 =?utf-8?B?eWh0QlRyV2ZVMGprOTl1NFJrN0V0NGJtUDdtK2swdlI5Z3JaRjVMT0l0QkFN?=
 =?utf-8?B?QmVKK1pLNEtaRXhMcTBZby9FU0tHamswTG5UWWtlNlByS2xlQTAwZ1o4bitW?=
 =?utf-8?Q?HPV8=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b3cafa0-f063-472c-50a7-08dd4b30cf8f
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Feb 2025 06:45:16.8654
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: r/fptLDUhp+Zdgne8UbjhFmV6T9QeyQS9wc7hBdwDlQyh60TpAcDjTy0JQHd1OlZbiru7mYiXLgfE4bxlbXuWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR18MB5654
X-Proofpoint-ORIG-GUID: 4zOYzQ_fTdS3-CxbH8XGAu5TPRH4nqYp
X-Proofpoint-GUID: 4zOYzQ_fTdS3-CxbH8XGAu5TPRH4nqYp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-12_02,2025-02-11_01,2024-11-22_01

Pj4gPiAtCXU2NCBwYTsNCj4+ID4gKwl1NjQgcGEsIGlvdmE7DQo+PiA+DQo+PiA+ICAJc2cgPSAm
c3EtPnNnW3NuZF9jb21wLT5zcWVfaWRdOw0KPj4gPg0KPj4gPiAtCXBhID0gb3R4Ml9pb3ZhX3Rv
X3BoeXMocGZ2Zi0+aW9tbXVfZG9tYWluLCBzZy0+ZG1hX2FkZHJbMF0pOw0KPj4gPiAtCW90eDJf
ZG1hX3VubWFwX3BhZ2UocGZ2Ziwgc2ctPmRtYV9hZGRyWzBdLA0KPj4gPiAtCQkJICAgIHNnLT5z
aXplWzBdLCBETUFfVE9fREVWSUNFKTsNCj4+ID4gKwlpb3ZhID0gc2ctPmRtYV9hZGRyWzBdOw0K
Pj4gPiArCXBhID0gb3R4Ml9pb3ZhX3RvX3BoeXMocGZ2Zi0+aW9tbXVfZG9tYWluLCBpb3ZhKTsN
Cj4+ID4gIAlwYWdlID0gdmlydF90b19wYWdlKHBoeXNfdG9fdmlydChwYSkpOw0KPj4gPiAtCXB1
dF9wYWdlKHBhZ2UpOw0KPj4NCj4+IEhpIFN1bWFuLA0KPj4NCj4+IFdpdGggdGhpcyBwYXRjaCBh
cHBsaWVkIHBhZ2UgaXMgYXNzaWduZWQgYnV0IG90aGVyd2lzZSB1bnVzZWQgaW4gdGhpcw0KPj4g
ZnVuY3Rpb24uIFNvIHVubGVzcyB0aGVyZSBhcmUgc29tZSBzaWRlIGVmZmVjdHMgb2YgdGhlIGFi
b3ZlLCBJIHRoaW5rDQo+PiBwYWdlIGFuZCBpbiB0dXJuIHBhIGFuZCBpb3ZhIGNhbiBiZSByZW1v
dmVkLg0KPg0KPkkgbm93IHNlZSB0aGF0IHBhZ2UgYW5kIHBhIGFyZSByZW1vdmVkIGluIHBhdGNo
IDYvNiwgYWx0aG91Z2ggaW92YSBpcw0KPmxlZnQgYmVoaW5kLiBJIHRoaW5rIGl0IHdvdWxkIGJl
IGJlc3QgdG8gbW92ZSB0aGUgY2xlYW51cCBmb3J3YXJkIHRvDQo+dGhpcyBwYXRjaC4NCltTdW1h
bl0gYWNrLCB3aWxsIHVwZGF0ZSBpbiB2Ng0K

