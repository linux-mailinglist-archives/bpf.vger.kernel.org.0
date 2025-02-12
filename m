Return-Path: <bpf+bounces-51224-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11B6BA32002
	for <lists+bpf@lfdr.de>; Wed, 12 Feb 2025 08:32:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D1D677A20B5
	for <lists+bpf@lfdr.de>; Wed, 12 Feb 2025 07:31:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2D3120468F;
	Wed, 12 Feb 2025 07:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="ODZUil7I"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 908D41DACB1;
	Wed, 12 Feb 2025 07:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.148.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739345565; cv=fail; b=o1Cg71GG1htYfcpbzZCaQJrDboKpMCeA0Px5OBhG0tXVIs8dp49lD85OV3GrtmOMQygnRFOKnXXrwdXDY3n26fLCmlqp0sZZt82BzjI1UM7MUzRZdU16L0+RxoU+4Stb+JsYac7az8WxC0tSyb9zaEha3MlGQpMRz3Sk5MY9hP8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739345565; c=relaxed/simple;
	bh=iCMSiQ2GBzkelAtkjYBcVvi30iPqYbl0NwOhdxr7YHg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dCsZ03lZkO2fEK0FLo1dv69qKsDznpliIQkQ8/k/wgUx++8JU35s581s880GBUjy8EbYNPy0SkT0EakZOOuYRH7fvdEs2KFL73+96URm/MJaAxsWePGdBvOR5Xo3mNYtVJbCLYXjuUQ1goHyqoAowj4BmltEeH8VsXUk9t95Rco=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=ODZUil7I; arc=fail smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51C6jGWN031709;
	Tue, 11 Feb 2025 23:32:20 -0800
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2048.outbound.protection.outlook.com [104.47.55.48])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 44rpn202dr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Feb 2025 23:32:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D+zq5jed6WlE88BeKzX+buIZTBtv/hZs7vJHwz8C/1jlEiEzxN/tfHvAFju85lI1sDy8BOpyNoX9Y522p7lP0vl8bBGlcVNQEQM8Tp5AIO3dlP2KGzHomH2/0vlw3Fe6j8ogTRsmJM6PqEs+l4vJi8Ilxcp+0sxODmkT3i1vt0lDJUPzREZvyqekqlaJY9IX2T4qn3hAeb0Xzp8KGGVg91D5+cQUSfJhyJQjCBrM/KI6kIIRD8zp3z8WQx5GcX7jOdvu8bSrdMHcfd/9LvQckJwVxDDKRumCTYmSeyZtDKD5OC6ma0ptwA5dnghcFY1WX1kqW3d2j+uIc4skmCXWoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iCMSiQ2GBzkelAtkjYBcVvi30iPqYbl0NwOhdxr7YHg=;
 b=JflsMLbDyC4HICm+P5+HSo6OjCGflvTIJ6vuhiJ5vAVDvBqMYezYAt2vgpMjasge1cz05Ldvq8CrvzKzILPc5C+3IPoJlVgs6+Dv+npRAYkxmqca20I/N0HCkxJTS6l/HouxSnS/b8ffrNee3SMCbMsadX/rjkOx9Vqw/nLmsKe+C4zfNlygZX3Jo54aeowV0jmHte2uPGduQ3pMKwz9YNiijRzauA1roJZhcW6KGKv+IATpEOAVQ3hQ3GAGwPUeSz3T/kLGPACbopay85yjBhtRut1LdsiJ8Y2bajbHgJM7BsaMWRVJ/IAV2Gs31YkLcsQvCVERFxmuQA5/QnzatQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iCMSiQ2GBzkelAtkjYBcVvi30iPqYbl0NwOhdxr7YHg=;
 b=ODZUil7IZvu0v9ctj7OuGddQb4rNIrGSOK3h+JV2A776McZ/qGRuJWk0eAl/t/JbqWN/wEy2qNyIYMu4uuWejByNshJ60QbnrQSEaWPJ+94oG7iKnPYQiTzOAeIpzdr/iVVA4PsDdbnj3LqlmaaIKVhFi4wIZedBKF8z8FpMS/0=
Received: from SJ0PR18MB5216.namprd18.prod.outlook.com (2603:10b6:a03:430::6)
 by SJ2PR18MB5612.namprd18.prod.outlook.com (2603:10b6:a03:555::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.11; Wed, 12 Feb
 2025 07:32:17 +0000
Received: from SJ0PR18MB5216.namprd18.prod.outlook.com
 ([fe80::2bf5:960a:a348:fad1]) by SJ0PR18MB5216.namprd18.prod.outlook.com
 ([fe80::2bf5:960a:a348:fad1%4]) with mapi id 15.20.8422.012; Wed, 12 Feb 2025
 07:32:17 +0000
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
Subject: RE: [EXTERNAL] Re: [net-next PATCH v5 3/6] octeontx2-pf: AF_XDP zero
 copy receive support
Thread-Topic: [EXTERNAL] Re: [net-next PATCH v5 3/6] octeontx2-pf: AF_XDP zero
 copy receive support
Thread-Index: AQHbeHROzktGfVhuCkaypOQI/GDnAbNA2VSAgAJuPEA=
Date: Wed, 12 Feb 2025 07:32:17 +0000
Message-ID:
 <SJ0PR18MB521685CB3D9FC5849049BA80DBFC2@SJ0PR18MB5216.namprd18.prod.outlook.com>
References: <20250206085034.1978172-1-sumang@marvell.com>
 <20250206085034.1978172-4-sumang@marvell.com>
 <20250210175633.GJ554665@kernel.org>
In-Reply-To: <20250210175633.GJ554665@kernel.org>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR18MB5216:EE_|SJ2PR18MB5612:EE_
x-ms-office365-filtering-correlation-id: 989f8a12-2718-4715-5f81-08dd4b3760ce
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?eGtQOWlEZ3Frei9LNmhCdGZ5OUZpcnNDcEFkM1ZwMVptWWxCamFzMWxxcjRo?=
 =?utf-8?B?OU84Nmd1MDhFUWJUWEtlZDNieFpqWkJFKy85RytoKzNmSWVpZFhxejdCVTZ0?=
 =?utf-8?B?WlFPYU9hMU1ldmpCNHByS0QrdWt3RXoveDFBSk82bXRzRFl0UEpCb05KL3Zn?=
 =?utf-8?B?WVdNc0hqVHZVZFZEWWJRZWR4a1VQcXJxcHFOakJ0OEZHWFZuL0xBSTBEcGl3?=
 =?utf-8?B?TnRrdVBtaUt6enB6RTV2bXBCdS9zbjBYcjhGVTZlSVVGWFllVkpNbjMremhx?=
 =?utf-8?B?bEFCRTNQTG1YSXE2MERGQTZ6REpQUmxzdUtSd21KOUU2UnBiMzZNcWk5dE9O?=
 =?utf-8?B?VHFyTWJDZlhGRS9vTW5WZlZ1cTV5SGxlcVY3QzUvaHNVQ2RzcnpESXdVU08z?=
 =?utf-8?B?YVhtWUdBUUtObTFoajVrMG1heXN2THpmODhKZDZBT0lCbVBPWmhmT2VHWVV5?=
 =?utf-8?B?QmlxZGZXQVBWOElJV0ZqZmdUZ3REVkZaejdQaGZyZzdNQ0w0MVJJdklvc3Ur?=
 =?utf-8?B?QzFyOEVzaG4rSjVuTjVpLzBwOGRUTGl5VWZJVExNWitjT2pBVFAySnk5akcx?=
 =?utf-8?B?ejFjaXpFS3pXK0c5cHJMR2xyY0E5M1NUejk1TWRDdkZTSHNFdUtlRy9rSTVQ?=
 =?utf-8?B?aCtEcTZJNE9uaXo1NnRPSDVJOXU1bzFscTk3UTljT09iUGt0ZWZ3RFdobUsr?=
 =?utf-8?B?ODVCZ3E1OUZNRS9qc0cvZjlvMjUvemlBNWExTGkxc29RSEp1RWtoTGNKV3hv?=
 =?utf-8?B?STk5bTJ0ZTV6WTNKQS9tU3RSeklQRS8reUs3bHEydUxvUmhFSTlzSHZaekVo?=
 =?utf-8?B?REwyYUZONXdKeU5MamNmV1JiNElxQ0ZYUU9xTWx4WFJJOWIyeEJ4RnpvN1p4?=
 =?utf-8?B?ekRMdWVVcHhxYktPczg4MlN6L0ZZNm1xQ05YWTQranY3eDNPTGorTmlyTWJR?=
 =?utf-8?B?cE5MUFM5NkVGdlptRkxYM0FPMkxRUlQ1UFZLNVJ4Y1BUTGtVQ29FdUVhNXJt?=
 =?utf-8?B?QkdQYi90enVSRVdXMUdDaWd2YWMvd3pIUUsvaE4xM0ZOWk1oRVBXeHBWVHBa?=
 =?utf-8?B?amwwVkl0U29Rdi9wN1dpSENodU9wMVZJYXd4bHRsWURMNllGbFlmZytuVlds?=
 =?utf-8?B?S04rR2lBdi9VNGM5cGNKd2pxbGZVeWkzTE8vYmNNaVp2L01UMlVlcjYxdmYx?=
 =?utf-8?B?REErSGw0K1IwRElwdDFVVjFtSnA3VVZiWStPUE51UGlST3VPVFFaS1B3c2lM?=
 =?utf-8?B?VWsyZHlhSlkyZmtBRmZUR3J0ZTlHL085NUxSZEtheUlWbUNQdTBSZE01Y05M?=
 =?utf-8?B?eDZxN2lmaFhkUGVCTE1ReTZCcU5yWFZHWXg3dkV3Sll5ZXVKUGt4c2dLck1Y?=
 =?utf-8?B?QVFsL3QzTG12VnpwV0QxRGlDY2VxUURGZmdTQnZjZWlZWXhaQUJuQkdsWnJN?=
 =?utf-8?B?OEt4Zll1VXpEeVVTYXhpTEUxZ2gxYXJTV1ZjcExnOGNUQzFGSW12STc4VjBm?=
 =?utf-8?B?bnppSzdWZkwrNFgydTZkL0lUTzB2M0tDM1FrMC9YNDgwNVE4UEtjL2drWjgv?=
 =?utf-8?B?YnNYOS9oeGdkemxaZzZxd0FGcFA3WjV1dHZsMk9TWFpDTDdqdTZEN0VobkZG?=
 =?utf-8?B?bC9yK0QzdHJKUFFKNk54UVpod3lBaFp1MDM5ejJxRnNBb1BhRFNSLzFIcUVN?=
 =?utf-8?B?SUxvM0dIZmF5UnNpMzk1THZBQ0ovM3A5K1ZSNE8yVkl6ZEtkaFRMZC9BRkFT?=
 =?utf-8?B?TWdMSDZXdFNKS1ViMm1jTVJMT3VEV3FtaTE3M05sTU81dERIdURXeE1kMXV0?=
 =?utf-8?B?c3lhNERpSS9jQ3FLZUMvYlowWmlNUmg3eE1ndHNOT1I3UktFR2s0eHVLUito?=
 =?utf-8?B?UVFaNXAzTTZrYkZUMHZmRGxBUGFIYzY1TDJreHdGTTNEQzRETDNwSllveUZu?=
 =?utf-8?Q?w2bVzudAI+B2MTrWdn7pn14uIwT1B5AF?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR18MB5216.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?b2pEd1lOMjVZZHQzWTF5QXdLb0xSZis0WHRBSVlGT3J1bkNmdHdoZjFpeHUv?=
 =?utf-8?B?VGNIakdXM1NqU21WWm1SVGNiSXNiSUlZaWR5amErODAvOHlXWHJaSVZyS0pk?=
 =?utf-8?B?czAzeGNBdDd4TUxRRkdEYkJ3ZXJaYjhaaEJSYnRDTkhyTXJsbFZvdnB6djVl?=
 =?utf-8?B?Skh6bHI4SXNmTndtTENSLy9iaE5UTEc5SHJENlpDSjRHbS9NRnRUdTErZHR1?=
 =?utf-8?B?azJ3K256aWNpaitYRkFTS0MyRGEyMEI4MjM5VTM4b1RzWjlYNWdpN0lzQnYx?=
 =?utf-8?B?cDhISEthallsa3lQaFlmSmJZaFkveWtHNXYrNDVYUkkybEtNcFFscnBUQzBY?=
 =?utf-8?B?emJzeUxMczJWWWdBRUpSRFYyNnlKby8zTCtTM1NUbk5DQlNWaHcwNVhFcWxT?=
 =?utf-8?B?TjJrRVBxQmFySE9GWlJNRWtjUE9wMlhMUGNzbHoraTJySUVqUWFjM29oNWpS?=
 =?utf-8?B?TVA5UmFweDBCWTRyeEl2ZHRicVZhTzBCN0FBd0g2T1ZwWU1YWlppVFJLV0Ew?=
 =?utf-8?B?YVluc0JZR1BBdDZrbUlTRGdxT3g4UEt0NVRKUW5QR1M3cDRBbmp6MERNeDd2?=
 =?utf-8?B?TFV4NWw5N1RRWDcva05Ea1dFWE1QSmdOSzE4NWw3UjArOXc0QnBreHg2anNJ?=
 =?utf-8?B?aGpqR2hVR2J6QXlrQlZpcHU3VDFnL2J1OGxGenJSU044NzdSVFhpcllyN3U1?=
 =?utf-8?B?MTJwTi9JTmNUbGcvT1NvMzR2YWYzMXFtbklyTnZBSTdoREVVY2tIMVpyRGg3?=
 =?utf-8?B?TGhzaC9QSVErcmxXd1l4VlVaZmRZVmZ0c1psVllqNk9SQkduQ1BnSW1wUFRE?=
 =?utf-8?B?KzB0eWZwVXhVZEdsbFIzamozS2F0NHQ1eUk2aldENDFTMXc3Q1g4bnhYTzZr?=
 =?utf-8?B?OURqeUpSRGIyN2pqWUp1b09UVWFQZ09KMEFTR2VhNFc1am5zZXpyNXpBWjJD?=
 =?utf-8?B?MVY4T3E1OTEyZkVpeGl0T1pKUzEyOUJXaDJmL1Z0Z2J4QWsxMU9NM1pwSWZr?=
 =?utf-8?B?QkpncXA2L3ZxN2Z3dFJTVDhoSFR2YXdlK2dIM0hGYlJGYWFRZDBGYzBGcmtQ?=
 =?utf-8?B?YUdXdXJPejIvcE9QY2F3SHowN1JoVnNxZVphdGhydmNzVGFoZUhLQU1aOG5h?=
 =?utf-8?B?RG5aWVg0MGlCc2tpZFhUdmZ1TUV5TVhwcXVHaEJTU0QwMmUxNlVpTzk2Qk9I?=
 =?utf-8?B?cFZHKzVIdzcvQXJSR1BXOEdHZFVxcm9icFR0YXZRZUZqV1ZTdUtOdlQ5V0g0?=
 =?utf-8?B?aTdSZzVZM1dic3VDdUUxQnV6cVIxV3dvV0FydDU2Tzc5bkpLeE1qUHNBcm9h?=
 =?utf-8?B?Y3Q5S05KNS9iNjRyMVU3NFh2Z242Y0x2VkMvc0VXamNVU1kwTHBmV3NBRkx2?=
 =?utf-8?B?eWtmYTV4U0lidW5oRGNrbFNxNk8zRU8rS0g4NmgydXFUWlB1OGRNNHlWU3N1?=
 =?utf-8?B?ZndFZjFMWGZjWURCbXJ2bnY4eVNWS2NHVmQ3K1AySzBFMm0wOXVwYnR0REZk?=
 =?utf-8?B?M0JtNGpXWktjdk9TcUJVRFRXYWM1cnUyWHM4MDJaZndMMlFIbTBZKzZka2pP?=
 =?utf-8?B?cTYvRXB4Q0NlZk1SaUhnUExXZlhicFUxdmdrVVMxRi90VTZiSzRFVndYaGZH?=
 =?utf-8?B?dW1hQjdQNStPbmgzK1FXOFliZkFLa2trZzJaTDNOcFBmRTUrNDNZQ2g1Nldz?=
 =?utf-8?B?eUpvZS80V1ZoYVVOZ29KMjN4ODZjVVVZVVNmVC93VGhuKzBZclBYTmx4MnVj?=
 =?utf-8?B?K3poTVBUaGRCM0xQd2g2SDdPTTJYaHZFM042VGpZNi9vdFg1MnB5Zlc5aDBL?=
 =?utf-8?B?WVlLb01EWnk5elpWZEs4YXJuU0tKMWRWWjNZeGdSeER4MWRBTDcwVjNiUm50?=
 =?utf-8?B?aHhwOVQwRVZ1aUJpNkFMS1pMRWVCZFEwZFdYTEdEL0YxSDBhcENYOFlIVkkr?=
 =?utf-8?B?UUtsQmtUb0NRcnRuY1lNdWdscmVqNk80UmgyR1JrK0dydGM1b29WcHp2YXhC?=
 =?utf-8?B?aWZHYnM4QlQwUjJiS2tUekkwT29Oa0hTR3BVUXRmZWdjbmFOeTc0WE1EWHhQ?=
 =?utf-8?B?WVdZeWFSdHkyQ3plczBaK3JhTUxXMUJvN0ZxLzB5SUhsdVhIaWhvcndYMHdx?=
 =?utf-8?Q?MUfM=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 989f8a12-2718-4715-5f81-08dd4b3760ce
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Feb 2025 07:32:17.5807
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MeRCOOa2y364Zs8Mx6OiQk3jDgUCMgb1cIWBY0xUORTatJxbSutb67I6qtfdkqX1oVmKAEFXA7FR0Sq7vZG0UA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR18MB5612
X-Proofpoint-GUID: C-lk1ZFopDJybXH63G-eCaXVUKd4BT7R
X-Proofpoint-ORIG-GUID: C-lk1ZFopDJybXH63G-eCaXVUKd4BT7R
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-12_02,2025-02-11_01,2024-11-22_01

Pj4gQEAgLTEyNCw3ICsxMjcsOCBAQCBpbnQgY24xMGtfcmVmaWxsX3Bvb2xfcHRycyh2b2lkICpk
ZXYsIHN0cnVjdA0KPm90eDJfY3FfcXVldWUgKmNxKQ0KPj4gIAkJCWJyZWFrOw0KPj4gIAkJfQ0K
Pj4gIAkJY3EtPnBvb2xfcHRycy0tOw0KPj4gLQkJcHRyc1tudW1fcHRyc10gPSAodTY0KWJ1ZnB0
ciArIE9UWDJfSEVBRF9ST09NOw0KPj4gKwkJcHRyc1tudW1fcHRyc10gPSBwb29sLT54c2tfcG9v
bCA/ICh1NjQpYnVmcHRyIDogKHU2NClidWZwdHIgKw0KPj4gK09UWDJfSEVBRF9ST09NOw0KPg0K
PlBsZWFzZSBjb25zaWRlciBsaW1pdGluZyBsaW5lcyB0byA4MCBjb2x1bW5zIHdpZGUgb3IgbGVz
cyBpbiBOZXR3b3JraW5nDQo+Y29kZSB3aGVyZSBpdCBjYW4gYmUgZG9uZSB3aXRob3V0IHJlZHVj
aW5nIHJlYWRhYmlsaXR5IChzdWJqZWN0aXZlIHRvIGJlDQo+c3VyZSkuDQpbU3VtYW5dIGFjaw0K
Pg0KPj4gKw0KPj4gIAkJbnVtX3B0cnMrKzsNCj4+ICAJCWlmIChudW1fcHRycyA9PSBOUEFfTUFY
X0JVUlNUIHx8IGNxLT5wb29sX3B0cnMgPT0gMCkgew0KPj4gIAkJCV9fY24xMGtfYXVyYV9mcmVl
cHRyKHBmdmYsIGNxLT5jcV9pZHgsIHB0cnMsDQo+DQo+Li4uDQo+DQo+PiBkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9uZXQvZXRoZXJuZXQvbWFydmVsbC9vY3Rlb250eDIvbmljL290eDJfY29tbW9uLmMN
Cj4+IGIvZHJpdmVycy9uZXQvZXRoZXJuZXQvbWFydmVsbC9vY3Rlb250eDIvbmljL290eDJfY29t
bW9uLmMNCj4NCj4uLi4NCj4NCj4+IEBAIC0xMzEyLDggKzEzMjYsOCBAQCB2b2lkIG90eDJfZnJl
ZV9hdXJhX3B0cihzdHJ1Y3Qgb3R4Ml9uaWMgKnBmdmYsDQo+PiBpbnQgdHlwZSkNCj4+DQo+PiAg
CS8qIEZyZWUgU1FCIGFuZCBSUUIgcG9pbnRlcnMgZnJvbSB0aGUgYXVyYSBwb29sICovDQo+PiAg
CWZvciAocG9vbF9pZCA9IHBvb2xfc3RhcnQ7IHBvb2xfaWQgPCBwb29sX2VuZDsgcG9vbF9pZCsr
KSB7DQo+PiAtCQlpb3ZhID0gb3R4Ml9hdXJhX2FsbG9jcHRyKHBmdmYsIHBvb2xfaWQpOw0KPj4g
IAkJcG9vbCA9ICZwZnZmLT5xc2V0LnBvb2xbcG9vbF9pZF07DQo+PiArCQlpb3ZhID0gb3R4Ml9h
dXJhX2FsbG9jcHRyKHBmdmYsIHBvb2xfaWQpOw0KPj4gIAkJd2hpbGUgKGlvdmEpIHsNCj4+ICAJ
CQlpZiAodHlwZSA9PSBBVVJBX05JWF9SUSkNCj4+ICAJCQkJaW92YSAtPSBPVFgyX0hFQURfUk9P
TTsNCj4NCj5UaGlzIGh1bmsgc2VlbXMgdW5uZWNlc3NhcnkuDQpbU3VtYW5dIGFjaw0KPg0KPi4u
Lg0KPg0KPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L2V0aGVybmV0L21hcnZlbGwvb2N0ZW9u
dHgyL25pYy9vdHgyX3R4cnguYw0KPj4gYi9kcml2ZXJzL25ldC9ldGhlcm5ldC9tYXJ2ZWxsL29j
dGVvbnR4Mi9uaWMvb3R4Ml90eHJ4LmMNCj4NCj4uLi4NCj4NCj4+IEBAIC01MjksOSArNTMwLDEw
IEBAIHN0YXRpYyB2b2lkIG90eDJfYWRqdXN0X2FkYXB0aXZlX2NvYWxlc2Uoc3RydWN0DQo+PiBv
dHgyX25pYyAqcGZ2Ziwgc3RydWN0IG90eDJfY3FfcCAgaW50IG90eDJfbmFwaV9oYW5kbGVyKHN0
cnVjdA0KPj4gbmFwaV9zdHJ1Y3QgKm5hcGksIGludCBidWRnZXQpICB7DQo+PiAgCXN0cnVjdCBv
dHgyX2NxX3F1ZXVlICpyeF9jcSA9IE5VTEw7DQo+PiArCXN0cnVjdCBvdHgyX2NxX3F1ZXVlICpj
cSA9IE5VTEw7DQo+PiAgCXN0cnVjdCBvdHgyX2NxX3BvbGwgKmNxX3BvbGw7DQo+PiAgCWludCB3
b3JrZG9uZSA9IDAsIGNxX2lkeCwgaTsNCj4+IC0Jc3RydWN0IG90eDJfY3FfcXVldWUgKmNxOw0K
Pj4gKwlzdHJ1Y3Qgb3R4Ml9wb29sICpwb29sOw0KPj4gIAlzdHJ1Y3Qgb3R4Ml9xc2V0ICpxc2V0
Ow0KPj4gIAlzdHJ1Y3Qgb3R4Ml9uaWMgKnBmdmY7DQo+PiAgCWludCBmaWxsZWRfY250ID0gLTE7
DQo+PiBAQCAtNTU2LDYgKzU1OCw3IEBAIGludCBvdHgyX25hcGlfaGFuZGxlcihzdHJ1Y3QgbmFw
aV9zdHJ1Y3QgKm5hcGksDQo+PiBpbnQgYnVkZ2V0KQ0KPj4NCj4+ICAJaWYgKHJ4X2NxICYmIHJ4
X2NxLT5wb29sX3B0cnMpDQo+PiAgCQlmaWxsZWRfY250ID0gcGZ2Zi0+aHdfb3BzLT5yZWZpbGxf
cG9vbF9wdHJzKHBmdmYsIHJ4X2NxKTsNCj4+ICsNCj4+ICAJLyogQ2xlYXIgdGhlIElSUSAqLw0K
Pj4gIAlvdHgyX3dyaXRlNjQocGZ2ZiwgTklYX0xGX0NJTlRYX0lOVChjcV9wb2xsLT5jaW50X2lk
eCksDQo+QklUX1VMTCgwKSk7DQo+Pg0KPg0KPj4gQEAgLTU2OCwyMCArNTcxLDMxIEBAIGludCBv
dHgyX25hcGlfaGFuZGxlcihzdHJ1Y3QgbmFwaV9zdHJ1Y3QgKm5hcGksDQo+aW50IGJ1ZGdldCkN
Cj4+ICAJCWlmIChwZnZmLT5mbGFncyAmIE9UWDJfRkxBR19BRFBUVl9JTlRfQ09BTF9FTkFCTEVE
KQ0KPj4gIAkJCW90eDJfYWRqdXN0X2FkYXB0aXZlX2NvYWxlc2UocGZ2ZiwgY3FfcG9sbCk7DQo+
Pg0KPj4gKwkJaWYgKGxpa2VseShjcSkpDQo+PiArCQkJcG9vbCA9ICZwZnZmLT5xc2V0LnBvb2xb
Y3EtPmNxX2lkeF07DQo+DQo+cG9vbCBpcyBpbml0aWFsaXNlZCBjb25kaXRpb25hbGx5IGhlcmUu
DQpbU3VtYW5dIGFjaywgd2lsbCB1cGRhdGUgaW4gdjYNCj4NCj4+ICsNCj4+ICAJCWlmICh1bmxp
a2VseSghZmlsbGVkX2NudCkpIHsNCj4+ICAJCQlzdHJ1Y3QgcmVmaWxsX3dvcmsgKndvcms7DQo+
PiAgCQkJc3RydWN0IGRlbGF5ZWRfd29yayAqZHdvcms7DQo+Pg0KPj4gLQkJCXdvcmsgPSAmcGZ2
Zi0+cmVmaWxsX3dya1tjcS0+Y3FfaWR4XTsNCj4+IC0JCQlkd29yayA9ICZ3b3JrLT5wb29sX3Jl
ZmlsbF93b3JrOw0KPj4gLQkJCS8qIFNjaGVkdWxlIGEgdGFzayBpZiBubyBvdGhlciB0YXNrIGlz
IHJ1bm5pbmcgKi8NCj4+IC0JCQlpZiAoIWNxLT5yZWZpbGxfdGFza19zY2hlZCkgew0KPj4gLQkJ
CQl3b3JrLT5uYXBpID0gbmFwaTsNCj4+IC0JCQkJY3EtPnJlZmlsbF90YXNrX3NjaGVkID0gdHJ1
ZTsNCj4+IC0JCQkJc2NoZWR1bGVfZGVsYXllZF93b3JrKGR3b3JrLA0KPj4gLQkJCQkJCSAgICAg
IG1zZWNzX3RvX2ppZmZpZXMoMTAwKSk7DQo+PiArCQkJaWYgKGxpa2VseShjcSkpIHsNCj4NCj5B
bmQgaGVyZSBpdCBpcyBhc3N1bWVkIHRoYXQgdGhlIHNhbWUgY29uZGl0aW9uIG1heSBub3QgYmUg
bWV0Lg0KW1N1bWFuXSBhY2ssIHdpbGwgdXBkYXRlIGluIHY2DQo+DQo+PiArCQkJCXdvcmsgPSAm
cGZ2Zi0+cmVmaWxsX3dya1tjcS0+Y3FfaWR4XTsNCj4+ICsJCQkJZHdvcmsgPSAmd29yay0+cG9v
bF9yZWZpbGxfd29yazsNCj4+ICsJCQkJLyogU2NoZWR1bGUgYSB0YXNrIGlmIG5vIG90aGVyIHRh
c2sgaXMgcnVubmluZyAqLw0KPj4gKwkJCQlpZiAoIWNxLT5yZWZpbGxfdGFza19zY2hlZCkgew0K
Pj4gKwkJCQkJd29yay0+bmFwaSA9IG5hcGk7DQo+PiArCQkJCQljcS0+cmVmaWxsX3Rhc2tfc2No
ZWQgPSB0cnVlOw0KPj4gKwkJCQkJc2NoZWR1bGVfZGVsYXllZF93b3JrKGR3b3JrLA0KPj4gKwkJ
CQkJCQkgICAgICBtc2Vjc190b19qaWZmaWVzKDEwMCkpOw0KPj4gKwkJCQl9DQo+PiAgCQkJfQ0K
Pj4gKwkJCS8qIENhbGwgZm9yIHdha2UtdXAgZm9yIG5vdCBhYmxlIHRvIGZpbGwgYnVmZmVycyAq
Lw0KPj4gKwkJCWlmIChwb29sLT54c2tfcG9vbCkNCj4NCj4+ICsJCQkJeHNrX3NldF9yeF9uZWVk
X3dha2V1cChwb29sLT54c2tfcG9vbCk7DQo+DQo+QnV0IGhlcmUgcG9vbCBpcyBkZXJlZmVyZW5j
ZXMgd2l0aG91dCBiZWluZyBndWFyZGVkIGJ5IHRoZSBzYW1lDQo+Y29uZGl0aW9uLiBUaGlzIHNl
ZW1zIGluY29uc2lzdGVudC4NCltTdW1hbl0gYWNrLCB3aWxsIHVwZGF0ZSBpbiB2Ng0KPg0KPj4g
IAkJfSBlbHNlIHsNCj4+ICsJCQkvKiBDbGVhciB3YWtlLXVwLCBzaW5jZSBidWZmZXJzIGFyZSBm
aWxsZWQgc3VjY2Vzc2Z1bGx5DQo+Ki8NCj4+ICsJCQlpZiAocG9vbC0+eHNrX3Bvb2wpDQo+PiAr
CQkJCXhza19jbGVhcl9yeF9uZWVkX3dha2V1cChwb29sLT54c2tfcG9vbCk7DQo+DQo+QW5kIGl0
IGlzIG5vdCBvYnZpb3VzIHRvIG1lIChvciBTbWF0Y2gsIHdoaWNoIGZsYWdnZWQgdGhpcyBvbmUp
IHRoYXQNCj5wb29sIGlzIGluaXRpYWxpc2VkIGhlcmUuDQpbU3VtYW5dIGFjaywgd2lsbCB1cGRh
dGUgaW4gdjYNCj4NCj4+ICAJCQkvKiBSZS1lbmFibGUgaW50ZXJydXB0cyAqLw0KPj4gIAkJCW90
eDJfd3JpdGU2NChwZnZmLA0KPj4gIAkJCQkgICAgIE5JWF9MRl9DSU5UWF9FTkFfVzFTKGNxX3Bv
bGwtPmNpbnRfaWR4KSwNCj4NCj4uLi4NCj4NCj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC9l
dGhlcm5ldC9tYXJ2ZWxsL29jdGVvbnR4Mi9uaWMvb3R4Ml92Zi5jDQo+PiBiL2RyaXZlcnMvbmV0
L2V0aGVybmV0L21hcnZlbGwvb2N0ZW9udHgyL25pYy9vdHgyX3ZmLmMNCj4+IGluZGV4IGU5MjZj
NmNlOTZjZi4uZTQzZWNmYjYzM2Y4IDEwMDY0NA0KPj4gLS0tIGEvZHJpdmVycy9uZXQvZXRoZXJu
ZXQvbWFydmVsbC9vY3Rlb250eDIvbmljL290eDJfdmYuYw0KPj4gKysrIGIvZHJpdmVycy9uZXQv
ZXRoZXJuZXQvbWFydmVsbC9vY3Rlb250eDIvbmljL290eDJfdmYuYw0KPj4gQEAgLTcyMiwxNSAr
NzIyLDI1IEBAIHN0YXRpYyBpbnQgb3R4MnZmX3Byb2JlKHN0cnVjdCBwY2lfZGV2ICpwZGV2LA0K
PmNvbnN0IHN0cnVjdCBwY2lfZGV2aWNlX2lkICppZCkNCj4+ICAJaWYgKGVycikNCj4+ICAJCWdv
dG8gZXJyX3NodXRkb3duX3RjOw0KPj4NCj4+ICsJdmYtPmFmX3hkcF96Y19xaWR4ID0gYml0bWFw
X3phbGxvYyhxY291bnQsIEdGUF9LRVJORUwpOw0KPj4gKwlpZiAoIXZmLT5hZl94ZHBfemNfcWlk
eCkgew0KPj4gKwkJZXJyID0gLUVOT01FTTsNCj4+ICsJCWdvdG8gZXJyX2FmX3hkcF96YzsNCj4+
ICsJfQ0KPj4gKw0KPj4gICNpZmRlZiBDT05GSUdfRENCDQo+PiAgCWVyciA9IG90eDJfZGNibmxf
c2V0X29wcyhuZXRkZXYpOw0KPj4gIAlpZiAoZXJyKQ0KPj4gLQkJZ290byBlcnJfc2h1dGRvd25f
dGM7DQo+PiArCQlnb3RvIGVycl9kY2JubF9zZXRfb3BzOw0KPj4gICNlbmRpZg0KPj4gIAlvdHgy
X3Fvc19pbml0KHZmLCBxb3NfdHhxcyk7DQo+Pg0KPj4gIAlyZXR1cm4gMDsNCj4+DQo+PiArZXJy
X2RjYm5sX3NldF9vcHM6DQo+PiArCWJpdG1hcF9mcmVlKHZmLT5hZl94ZHBfemNfcWlkeCk7DQo+
PiArZXJyX2FmX3hkcF96YzoNCj4+ICsJb3R4Ml91bnJlZ2lzdGVyX2RsKHZmKTsNCj4NCj5QbGVh
c2UgY29uc2lkZXIgbmFtaW5nIHRoZSBsYWJlbHMgYWJvdmUgYWZ0ZXIgd2hhdCB0aGV5IGRvIHJh
dGhlciB0aGFuDQo+d2hlcmUgdGhleSBjb21lIGZyb20sIGFzIHNlZW1zIHRvIGJlIHRoZSBjYXNl
IGZvciB0aGUgZXhpc3RpbmcgbGFiZWxzDQo+YmVsb3csIGFuZCBpcyBwcmVmZXJyZWQgaW4gTmV0
d29ya2luZyBjb2RlLg0KW1N1bWFuXSBhY2ssIHdpbGwgdXBkYXRlIGluIHY2DQo+DQo+PiAgZXJy
X3NodXRkb3duX3RjOg0KPj4gIAlvdHgyX3NodXRkb3duX3RjKHZmKTsNCj4+ICBlcnJfdW5yZWdf
bmV0ZGV2Og0KPg0KPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L2V0aGVybmV0L21hcnZlbGwv
b2N0ZW9udHgyL25pYy9vdHgyX3hzay5jDQo+PiBiL2RyaXZlcnMvbmV0L2V0aGVybmV0L21hcnZl
bGwvb2N0ZW9udHgyL25pYy9vdHgyX3hzay5jDQo+DQo+Li4uDQo+DQo+PiArc3RhdGljIGludCBv
dHgyX3hza19jdHhfZGlzYWJsZShzdHJ1Y3Qgb3R4Ml9uaWMgKnBmdmYsIHUxNiBxaWR4LCBpbnQN
Cj4+ICthdXJhX2lkKSB7DQo+PiArCXN0cnVjdCBuaXhfY24xMGtfYXFfZW5xX3JlcSAqY24xMGtf
cnFfYXE7DQo+PiArCXN0cnVjdCBucGFfYXFfZW5xX3JlcSAqYXVyYV9hcTsNCj4+ICsJc3RydWN0
IG5wYV9hcV9lbnFfcmVxICpwb29sX2FxOw0KPj4gKwlzdHJ1Y3Qgbml4X2FxX2VucV9yZXEgKnJx
X2FxOw0KPj4gKw0KPj4gKwlpZiAodGVzdF9iaXQoQ04xMEtfTE1UU1QsICZwZnZmLT5ody5jYXBf
ZmxhZykpIHsNCj4+ICsJCWNuMTBrX3JxX2FxID0gb3R4Ml9tYm94X2FsbG9jX21zZ19uaXhfY24x
MGtfYXFfZW5xKCZwZnZmLQ0KPj5tYm94KTsNCj4+ICsJCWlmICghY24xMGtfcnFfYXEpDQo+PiAr
CQkJcmV0dXJuIC1FTk9NRU07DQo+PiArCQljbjEwa19ycV9hcS0+cWlkeCA9IHFpZHg7DQo+PiAr
CQljbjEwa19ycV9hcS0+cnEuZW5hID0gMDsNCj4+ICsJCWNuMTBrX3JxX2FxLT5ycV9tYXNrLmVu
YSA9IDE7DQo+PiArCQljbjEwa19ycV9hcS0+Y3R5cGUgPSBOSVhfQVFfQ1RZUEVfUlE7DQo+PiAr
CQljbjEwa19ycV9hcS0+b3AgPSBOSVhfQVFfSU5TVE9QX1dSSVRFOw0KPj4gKwl9IGVsc2Ugew0K
Pj4gKwkJcnFfYXEgPSBvdHgyX21ib3hfYWxsb2NfbXNnX25peF9hcV9lbnEoJnBmdmYtPm1ib3gp
Ow0KPj4gKwkJaWYgKCFycV9hcSkNCj4+ICsJCQlyZXR1cm4gLUVOT01FTTsNCj4+ICsJCXJxX2Fx
LT5xaWR4ID0gcWlkeDsNCj4+ICsJCXJxX2FxLT5zcS5lbmEgPSAwOw0KPj4gKwkJcnFfYXEtPnNx
X21hc2suZW5hID0gMTsNCj4+ICsJCXJxX2FxLT5jdHlwZSA9IE5JWF9BUV9DVFlQRV9SUTsNCj4+
ICsJCXJxX2FxLT5vcCA9IE5JWF9BUV9JTlNUT1BfV1JJVEU7DQo+PiArCX0NCj4+ICsNCj4+ICsJ
YXVyYV9hcSA9IG90eDJfbWJveF9hbGxvY19tc2dfbnBhX2FxX2VucSgmcGZ2Zi0+bWJveCk7DQo+
PiArCWlmICghYXVyYV9hcSkgew0KPj4gKwkJb3R4Ml9tYm94X3Jlc2V0KCZwZnZmLT5tYm94Lm1i
b3gsIDApOw0KPj4gKwkJcmV0dXJuIC1FTk9NRU07DQo+DQo+SXQncyBub3QgYSBiaWcgZGVhbCwg
YnV0IEZXSUlXIEkgd291bGQgaGF2ZSB1c2VkIGEgZ290byBsYWJlbCBoZXJlLg0KW1N1bWFuXSBh
Y2sNCj4NCj4+ICsJfQ0KPj4gKw0KPj4gKwlhdXJhX2FxLT5hdXJhX2lkID0gYXVyYV9pZDsNCj4+
ICsJYXVyYV9hcS0+YXVyYS5lbmEgPSAwOw0KPj4gKwlhdXJhX2FxLT5hdXJhX21hc2suZW5hID0g
MTsNCj4+ICsJYXVyYV9hcS0+Y3R5cGUgPSBOUEFfQVFfQ1RZUEVfQVVSQTsNCj4+ICsJYXVyYV9h
cS0+b3AgPSBOUEFfQVFfSU5TVE9QX1dSSVRFOw0KPj4gKw0KPj4gKwlwb29sX2FxID0gb3R4Ml9t
Ym94X2FsbG9jX21zZ19ucGFfYXFfZW5xKCZwZnZmLT5tYm94KTsNCj4+ICsJaWYgKCFwb29sX2Fx
KSB7DQo+PiArCQlvdHgyX21ib3hfcmVzZXQoJnBmdmYtPm1ib3gubWJveCwgMCk7DQo+PiArCQly
ZXR1cm4gLUVOT01FTTsNCj4NCj5BbmQgcmUtdXNlZCBpdCBoZXJlLg0KW1N1bWFuXSBhY2sNCj4N
Cj4+ICsJfQ0KPj4gKw0KPj4gKwlwb29sX2FxLT5hdXJhX2lkID0gYXVyYV9pZDsNCj4+ICsJcG9v
bF9hcS0+cG9vbC5lbmEgPSAwOw0KPj4gKwlwb29sX2FxLT5wb29sX21hc2suZW5hID0gMTsNCj4+
ICsNCj4+ICsJcG9vbF9hcS0+Y3R5cGUgPSBOUEFfQVFfQ1RZUEVfUE9PTDsNCj4+ICsJcG9vbF9h
cS0+b3AgPSBOUEFfQVFfSU5TVE9QX1dSSVRFOw0KPj4gKw0KPj4gKwlyZXR1cm4gb3R4Ml9zeW5j
X21ib3hfbXNnKCZwZnZmLT5tYm94KTsgfQ0KPg0KPi4uLg0K

