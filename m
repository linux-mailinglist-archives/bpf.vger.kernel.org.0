Return-Path: <bpf+bounces-41402-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DFE5996B28
	for <lists+bpf@lfdr.de>; Wed,  9 Oct 2024 15:00:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B1B771C23AF5
	for <lists+bpf@lfdr.de>; Wed,  9 Oct 2024 13:00:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FE3619AD7D;
	Wed,  9 Oct 2024 12:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="cpBohDbQ"
X-Original-To: bpf@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013035.outbound.protection.outlook.com [52.101.67.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D96E199FA8;
	Wed,  9 Oct 2024 12:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728478605; cv=fail; b=UrXBCb2g4YyohfPw/xDLZQxk8cetHzW12UTaaR7Te9RLWu+zBLl/JVW2k/Y54O95GDpX530raiLCNvX/ZrtGvj8kPiSH8biL00wBVaz87b0iLz0mmKJk8Srfq1OkbDBWHpEHLxyuXQB0wRPQMjOzow/XkIf9EjaxDX7c4BMhwwM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728478605; c=relaxed/simple;
	bh=fSGavvfmbSBl8gyO/WZ9M4gAESj/ppZuDD+qSU0fYAY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=chOqxaTj7bS59MDXQbnAzUGOJOLC4e3LqFAS3ieHYQb1QuqjFnyKrtmGy7fcWeu6gB13B7lm7ysnp/i5DunMs5C5p/ELMPg3UohmdvXL4KrH62S79UFwYUSG7a5u2EoipahsAflKbRigputcLChbM9St4y/rJpvA8kCLWxPmbVE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=cpBohDbQ; arc=fail smtp.client-ip=52.101.67.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K5QxY2w7OQ8X4oxTkk4MmdL3AA7Z1pT4pe8Png6uR1A9y/0kavIBKd5eMx4yd641b2J/p5O/O1eGRY9GtdvZMy3va2MOhAHe7nqNFacdlK8p2mR9KLKGBz3EKvQIOHkYaK6iljydzEF77J4MPMH461tErVP8biMaNRXnu4pwNUAdCiKgte0MMABZVXSSOz0pqfbil55Vhz8wAuygyS0QMFVxYxWjmrFQgbY5zZJbki0hqEAj80irkmGLxamWWutahidnrKd83SpiJqwPmB/cQPK82l4F7XJ8CnEhJ5enTBZYDFsXmQywTmMz0H1YSE+8mkYs+sZUKosNc/CI5nghDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fSGavvfmbSBl8gyO/WZ9M4gAESj/ppZuDD+qSU0fYAY=;
 b=hrceYMGRUpjJouKUabAC2HTgEl9CVvRMh0ro/7DNHYzp3vGlEYc4BmywL9mx0XLFrcdojCxfhR3V0a0+zIxZeFKad9WvB+dqK5wgijzqVrsZIi171oVLu5wkSXggWjaqZMUY2ab9cTb2IEOVNwsioC7pBKeZx+bFAGAGSlTVw8Y7DyPi4Gcw7oc+qws151gY299dW0Z8K3szsF1ONtRytsOrWY+vwFkMGcRaZ8z6oC8pcOvipE+T5bWQ4seUeUDSNWWaLVkFTRt4UHyXPvxMIpCrvnDDHhvyhkw4L9bWx4KoAxmkwrDtqrru+NaYUcbn0aOoiB4Qvcb+NILt6H9UDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fSGavvfmbSBl8gyO/WZ9M4gAESj/ppZuDD+qSU0fYAY=;
 b=cpBohDbQl6WtXRgZozajEZ0KGX7czFmcj0JM6D8iy22vVY2nZDPd7GncpYQgL7eKl93iD1i0BPbtk4QcJsTelHiGSNApPUa6/Ob84jjy/TkdlJIvLJL1wE0X08n99e6Piy34LhzGtJK76/X2/RCJzJs4rbzU68gEIEpLv8TIyZx5TorRNUn0hIc/vptW7AlDTaomh9I2LD1outeYmxUEddagXLf8W1aNnIlxd9ahTVpBCypb6rImcHmOpI8yYEZ/yrI1BRD8LGSnhf95r79ld1p/v5OaH3IpcdSXSrsulat2yGB2mMx7EHc1SE9EDLbMJkvNBCWUT9UJK39KvEjxtQ==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by AS1PR04MB9698.eurprd04.prod.outlook.com (2603:10a6:20b:481::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.22; Wed, 9 Oct
 2024 12:56:38 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%7]) with mapi id 15.20.8026.019; Wed, 9 Oct 2024
 12:56:38 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
CC: "davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, Claudiu Manoil
	<claudiu.manoil@nxp.com>, "ast@kernel.org" <ast@kernel.org>,
	"daniel@iogearbox.net" <daniel@iogearbox.net>, "hawk@kernel.org"
	<hawk@kernel.org>, "john.fastabend@gmail.com" <john.fastabend@gmail.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "bpf@vger.kernel.org"
	<bpf@vger.kernel.org>, "stable@vger.kernel.org" <stable@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>, "rkannoth@marvell.com"
	<rkannoth@marvell.com>, "maciej.fijalkowski@intel.com"
	<maciej.fijalkowski@intel.com>, "sbhatta@marvell.com" <sbhatta@marvell.com>
Subject: RE: [PATCH v3 net 3/3] net: enetc: disable IRQ after Rx and Tx BD
 rings are disabled
Thread-Topic: [PATCH v3 net 3/3] net: enetc: disable IRQ after Rx and Tx BD
 rings are disabled
Thread-Index: AQHbGiw1XHu403XnVUeM1N3bqeUD47J+U/jkgAAL2NA=
Date: Wed, 9 Oct 2024 12:56:38 +0000
Message-ID:
 <PAXPR04MB8510D29BA035DDC3902374C3887F2@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20241009090327.146461-1-wei.fang@nxp.com>
 <20241009090327.146461-1-wei.fang@nxp.com>
 <20241009090327.146461-4-wei.fang@nxp.com>
 <20241009090327.146461-4-wei.fang@nxp.com>
 <20241009120952.whmd6jemqagkwkoq@skbuf>
In-Reply-To: <20241009120952.whmd6jemqagkwkoq@skbuf>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|AS1PR04MB9698:EE_
x-ms-office365-filtering-correlation-id: 16c3fc82-4c06-4ec7-1011-08dce861d020
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|7416014|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?gb2312?B?WWUxanNEMnIzUXlJelI3S3JYdjlCcGtxdEJUZ0k5Y0lHUkpMVS9UNEFCWGFu?=
 =?gb2312?B?YzNGY1Vieng0eFhLelBuZnRrQ0dxVlgzcUg3b28yU3YrL1BGWURzaXUxZkdQ?=
 =?gb2312?B?NGd3NWxCVG0zWXI2QTgyRHRrbG1ER1JqYzVCWVJweUxUdE5PS3ozQXNWWnFS?=
 =?gb2312?B?SHhabk9pTnBPNVpQNWtoQ08rQVlkcGt0YkcwLzgwSmtWSkxpR2VNVW1OdSsz?=
 =?gb2312?B?c3B6UGw3WUdhUSt3bUR5emlWbGREUzVNU1BVbXlsaHdHaG9VUDY2VWlXTzRr?=
 =?gb2312?B?M1QzUEg4ZS9leTNHR2UxWnBZYUkxRksrWUV4Q2s4WE9XMysrZ1pwdXNheTkr?=
 =?gb2312?B?VFMwVkJib29NY2NoaStuck9vQTlodys2N0hXMGhER3RzN1R6K1hSWjd1aDlj?=
 =?gb2312?B?cnRTVWlFbDQ2eEVxcGFBWWxUdkRla2NzOGwwYzlvQ1RPc2hvQUxCYmNrYktj?=
 =?gb2312?B?bmxsbmJMUFpVZ1BYOW5ZWHpUSWZCSkpIa0ZLUFVFTVBBeWtPSG5tMG1sUFFZ?=
 =?gb2312?B?anNoR2tVSjU2aW1YOVdFMzduRVRtcUZpMkZ5QjVwT1ZDWWN0MkVDNzJIMFV6?=
 =?gb2312?B?ZWVhSmVudXE0WFl3QWRQT3FGc2tSMU10ZENHUndwa2pBTC91enBJdUZuaU9r?=
 =?gb2312?B?OFovQllaTXVFeFVtaE5KMTJEMTRmUXhaeVkvZ0twclJObkhwM3d4aVlaWEpS?=
 =?gb2312?B?TTh4U0ZQbzl6SVZTTVJjTXpXSDNvZ0R3MHJRZVJyOS9BdURTZW1hMDhiUkFt?=
 =?gb2312?B?VjRFTGl5dm1uR3hFaXhPU04weGRhS2dQSldXait4NEt6QnhaOHJvRDVXUU00?=
 =?gb2312?B?VnJtcGtwMGxmK3F0eEdwVWx4Y085cHBIRVJKUDNXSmN3WHgyYzU1elN0L2Fa?=
 =?gb2312?B?V0J6SGNqKzYzWW1aeTVkbFhlK29yQzAzVWNqR0IyVENBR1p3VmhpTE9ObHVJ?=
 =?gb2312?B?MDVuQ0hBZFV3QVlLVkh0dmoyY3d0RXlscWRqR0diN2VqOWVhc2tpYVJpdVE0?=
 =?gb2312?B?SnF3NDJybXRFbVVIMVpDTDJ2WjB5Tm9vNHltTnNTdkdwK2swOGUxQjFyYW5m?=
 =?gb2312?B?eEdJTkpkem5vUlRka2RSM091RGFaS0U0aGxGM1FMaThsMUwwOE5XVHZzV0l5?=
 =?gb2312?B?aEdqTmgxYjFMc0lTdTVhUmpTYjRRa3VtaEZoWmpJTDNHdFVNNjczblRIVmRF?=
 =?gb2312?B?QTdrS2ZrNGhkamJvOUJCUDV2YlN5dmFCNGx3dVlsdXRyWVk5QllWTm1Qalhz?=
 =?gb2312?B?dmVvaE9kTUR0b3BZa0Y2QlhselFBbldJa3RCSjIrdmM0ZHR4ejZqUW1iOFVj?=
 =?gb2312?B?ZUFEdll2ZkJyUllJdTJIbUUyK2pORzhTbGtzbHVQeDQwU3c0aGN5anRxTFNi?=
 =?gb2312?B?RUNSZytDQ3c5MUhDNEE0NTliSGpPWDJvR3RDWlJBZTdtb2FZYVROMDNSL3hW?=
 =?gb2312?B?TVQrWnZCcTZsM25Kd2hSbVM1aGRHVXNYckJZMUlGQ1VBTDRmcmRESDI1cGpR?=
 =?gb2312?B?TEtzUVNWSjhtL2lMQzZOcFN0SUFOL05EMUp4MDlmYjFlSzZBQVVmZzdzQXdt?=
 =?gb2312?B?ZlF2Z0k3dElxd3lzM3RKUEhjZXBXNVFjWFBZbU5TRDg3dUp6MmR1WTNXZWNV?=
 =?gb2312?B?SnhFVWQwejZWTU43Rms1empVNVd1bTlmVlZPcVYvUk16ZG5Jc3MzODFraDhl?=
 =?gb2312?B?M3dtS1FQaVJrTmFkUFU4b3ZzY3ZFM2cya2s4eHRpaVFLR1J2SWk5VFhla0dE?=
 =?gb2312?B?Ni92QlozZ0FOSzNTUFZsU1RUNkRzVGJBOVJPRFRsSzliMks1WEhseDBYWDBq?=
 =?gb2312?B?VkhoUS94OFk5VjZwbnpYUT09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?OG1ybHZVNncwWHJKbWZNSjhtZFE1c2owamxhV1JMSFBuYmVuQThhTE1IaGRa?=
 =?gb2312?B?cm1PSDEwUXgxVVBKYVVyamdyS0l1Wm9VZTlqL3RsRjVOV1hUVWE5UkFpYXpD?=
 =?gb2312?B?VzFaSS9URG5vTHJpOVQ3MDducDBGaU9PR0MzaTVxcTNwMlFFaW14Z3JNemVm?=
 =?gb2312?B?OFNOZWM0Ym0xbVlIOElqQ1ZEYWhtQVZaSTlTNCtKbWwyUmc2QjhsNXpVZ2Zi?=
 =?gb2312?B?d0lRNlNyRExzVVIzaGFVaEVFQlBUYjhoOEFvMmNxU1NzeGZPb1dhbFdXQkI5?=
 =?gb2312?B?VlhPd1o2c2xwck4vT2NmOE5iQnN3N3AwbnkrNUlEYXpkS1Z6RGkxZGhJSU9m?=
 =?gb2312?B?YlBUUk5MblJsZmxmSGNTSjROSFE5TU5XSE0yQXBOSEtZamNMSjhPdC9TVTNy?=
 =?gb2312?B?ZVRCT2pFc3JmeGhjbmxVNG8vS3R4Q3RrQVZ3UWErTEpzSVZjMXgzeHpLUys1?=
 =?gb2312?B?L1pta2UwV1AvRnRpaXdnYUpGOFRPajQydTJqdTBJYVJXN3UxdjlGcDNyYU00?=
 =?gb2312?B?eDdYQ0pmcGhXVjJhTXdtS2ZQWlNPOEI5cjdzeXhBZVRWUGNLMW11MW9scEE5?=
 =?gb2312?B?OUhkVmRKeHNyQkdoZzBBTlVQVk1wWTdCbFZIaTR5dVhTcllnSmlCQUFPR2pj?=
 =?gb2312?B?OWRWUnFIcjY0VGFXS3VINmxXaklFSEY4cjNzZiswMXgvbjJ5NXY5VXNjcUNW?=
 =?gb2312?B?SEVMZjh0bWw2T0Fkb0JMaWhtVkhuVkEvOWE5dlpsSFRac2FMZzc2MDcyTUJZ?=
 =?gb2312?B?OXR6WWN0MUxucU1zRTBhU20vNjVYdmRlK09TUTdaTnd6VjhPRHJGNHJSYlN5?=
 =?gb2312?B?NUJ0UGkzTGNvZm96cm45SElleUpqZ1JJL0xiWDRjdDlrSkUzL2paTEpuOC9H?=
 =?gb2312?B?VXdWeUd2VUh5SS9XZnRwNmVIMHFnZVFSS0NScHc2VFg1UmpvN05BVUNsRFZD?=
 =?gb2312?B?YnVjNXBWU01CQWw4cUh0aW1KYkh1UTVETmxkZWhvVlhGbHZnTWxzbFNYZFhE?=
 =?gb2312?B?YlNJUE1PTmoreTdPS3l0NXJwV2U0bGd2TFowWW1qbjJmejQ5QnArbUNod2Ev?=
 =?gb2312?B?RFgydGJ2aG0wdFpZRzl4RFNtaEtrMU1lVzRxWjdpcUZmc1MyQmVud01SM2Rv?=
 =?gb2312?B?QWRFOEFJYmc2S2VzZTBreDN0Mm5lVkIxZUIyd3hxQ3Z5Z284d3IrR3RYZHZ5?=
 =?gb2312?B?NGtXUmkrbnNlS2cvenZ0U1g5bzBxdCtydFNGRlBWM3ZLbm1oajhBSmpZVnk0?=
 =?gb2312?B?b2JRenNRQWNSZGMwMXI0TEZYcGt4TXhlSGlsaFNnVHFad0w4ZW5UU1VuT3p2?=
 =?gb2312?B?c25kdkFhSE5FYnJFNXgyckNmZjZLVDhLbytJblp2WlE1bzkwbXdoOWhtNk9N?=
 =?gb2312?B?bU5OOERFOENlWFAwM201Tjc0U3p1NGV2UElXMkhvRmkvOEdPaEV5bWVvdGtF?=
 =?gb2312?B?VWMyYVpGbjJIWjZLQWFQbE9YYXd5Q2d3dURqenNFVTVYNUM0S1NHM21uOUtS?=
 =?gb2312?B?NjNaUnpSdzJFT2ZiTVBtNmY5SVFnQWNWajNOalhBdWZzMXNKNlYxdUFRWWJQ?=
 =?gb2312?B?YUFSU25naWwxaEE3ZExlbkVMR2R4OS9IWVJyR2hldnJydkRUM0JFdU5pNjBX?=
 =?gb2312?B?WmkzVkN5cVZLVUZYMEpNN2NUT2lrTGNNZGJxSm15TWZkVlhjbjUrMUcvMks5?=
 =?gb2312?B?YktrSThVT1JzSmtZWVhjbjExaE9DMnJqNDhCVksrSVFwdU8zQTljaHdxeEta?=
 =?gb2312?B?emk4OTFlMCsySXFzUlZ6cGlKT3pZZmlhRkF0OGtacXRuYTBPMGVGK3ZWbWRT?=
 =?gb2312?B?M1lQNTFjN24rUldzT2JPTCtqYllocVovdm5DUm44YVF6ZXFYZTNYNDN6SkY1?=
 =?gb2312?B?SElBMVN4Y1ZVdjNsS1BkSDlpeEtuckpnaEJ1T21DdTFGSGRHeDdleXZzeDJO?=
 =?gb2312?B?SUFITWdhTGdZUGpreThmYkJUcFJVODgxa2R6aEhNNXcxR2Vvd01xQzVXTThv?=
 =?gb2312?B?RlczMERYMUJKemFOZE9sZzlyVmNHWktuTEk5YUNYUlNJa1FZajQ3TEpNY0h3?=
 =?gb2312?B?emdnQnl5NVBpNjZ3N3hucktIM2cxeFA0UGNkK0NBZUVxUTBhSXFzQmFlRFRI?=
 =?gb2312?Q?Do7A=3D?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16c3fc82-4c06-4ec7-1011-08dce861d020
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Oct 2024 12:56:38.0534
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MnQekmhcnd4rce4Pv+uwbwp+nt1qoOLjK6fHR4NNxZ3LLT30lTB+CsB+aHkWvtf1W0oZoAr3f+UD1YAGA7YMLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9698

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFZsYWRpbWlyIE9sdGVhbiA8
dmxhZGltaXIub2x0ZWFuQG54cC5jb20+DQo+IFNlbnQ6IDIwMjTE6jEw1MI5yNUgMjA6MTANCj4g
VG86IFdlaSBGYW5nIDx3ZWkuZmFuZ0BueHAuY29tPg0KPiBDYzogZGF2ZW1AZGF2ZW1sb2Z0Lm5l
dDsgZWR1bWF6ZXRAZ29vZ2xlLmNvbTsga3ViYUBrZXJuZWwub3JnOw0KPiBwYWJlbmlAcmVkaGF0
LmNvbTsgQ2xhdWRpdSBNYW5vaWwgPGNsYXVkaXUubWFub2lsQG54cC5jb20+Ow0KPiBhc3RAa2Vy
bmVsLm9yZzsgZGFuaWVsQGlvZ2VhcmJveC5uZXQ7IGhhd2tAa2VybmVsLm9yZzsNCj4gam9obi5m
YXN0YWJlbmRAZ21haWwuY29tOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOw0KPiBuZXRk
ZXZAdmdlci5rZXJuZWwub3JnOyBicGZAdmdlci5rZXJuZWwub3JnOyBzdGFibGVAdmdlci5rZXJu
ZWwub3JnOw0KPiBpbXhAbGlzdHMubGludXguZGV2OyBya2Fubm90aEBtYXJ2ZWxsLmNvbTsgbWFj
aWVqLmZpamFsa293c2tpQGludGVsLmNvbTsNCj4gc2JoYXR0YUBtYXJ2ZWxsLmNvbQ0KPiBTdWJq
ZWN0OiBSZTogW1BBVENIIHYzIG5ldCAzLzNdIG5ldDogZW5ldGM6IGRpc2FibGUgSVJRIGFmdGVy
IFJ4IGFuZCBUeCBCRCByaW5ncw0KPiBhcmUgZGlzYWJsZWQNCj4gDQo+IE9uIFdlZCwgT2N0IDA5
LCAyMDI0IGF0IDA1OjAzOjI3UE0gKzA4MDAsIFdlaSBGYW5nIHdyb3RlOg0KPiA+IFdoZW4gcnVu
bmluZyAieGRwLWJlbmNoIHR4IGVubzAiIHRvIHRlc3QgdGhlIFhEUF9UWCBmZWF0dXJlIG9mIEVO
RVRDDQo+ID4gb24gTFMxMDI4QSwgaXQgd2FzIGZvdW5kIHRoYXQgaWYgdGhlIGNvbW1hbmQgd2Fz
IHJlLXJ1biBtdWx0aXBsZSB0aW1lcywNCj4gPiBSeCBjb3VsZCBub3QgcmVjZWl2ZSB0aGUgZnJh
bWVzLCBhbmQgdGhlIHJlc3VsdCBvZiB4ZG8tYmVuY2ggc2hvd2VkDQo+IA0KPiB4ZHAtYmVuY2gN
Cj4gDQo+ID4gdGhhdCB0aGUgcnggcmF0ZSB3YXMgMC4NCj4gPg0KPiA+IHJvb3RAbHMxMDI4YXJk
Yjp+IyAuL3hkcC1iZW5jaCB0eCBlbm8wDQo+ID4gSGFpcnBpbm5pbmcgKFhEUF9UWCkgcGFja2V0
cyBvbiBlbm8wIChpZmluZGV4IDM7IGRyaXZlciBmc2xfZW5ldGMpDQo+ID4gU3VtbWFyeSAgICAg
ICAgICAgICAgICAgICAgICAyMDQ2IHJ4L3MgICAgICAgICAgICAgICAgICAwDQo+IGVycixkcm9w
L3MNCj4gPiBTdW1tYXJ5ICAgICAgICAgICAgICAgICAgICAgICAgIDAgcngvcyAgICAgICAgICAg
ICAgICAgIDANCj4gZXJyLGRyb3Avcw0KPiA+IFN1bW1hcnkgICAgICAgICAgICAgICAgICAgICAg
ICAgMCByeC9zICAgICAgICAgICAgICAgICAgMA0KPiBlcnIsZHJvcC9zDQo+ID4gU3VtbWFyeSAg
ICAgICAgICAgICAgICAgICAgICAgICAwIHJ4L3MgICAgICAgICAgICAgICAgICAwDQo+IGVycixk
cm9wL3MNCj4gPg0KPiA+IEJ5IG9ic2VydmluZyB0aGUgUnggUElSIGFuZCBDSVIgcmVnaXN0ZXJz
LCB3ZSBmb3VuZCB0aGF0IENJUiBpcyBhbHdheXMNCj4gPiBlcXVhbCB0byAweDdGRiBhbmQgUElS
IGlzIGFsd2F5cyAweDdGRSwgd2hpY2ggbWVhbnMgdGhhdCB0aGUgUnggcmluZw0KPiA+IGlzIGZ1
bGwgYW5kIGNhbiBubyBsb25nZXIgYWNjb21tb2RhdGUgb3RoZXIgUnggZnJhbWVzLiBUaGVyZWZv
cmUsIHdlDQo+ID4gY2FuIGNvbmNsdWRlIHRoYXQgdGhlIHByb2JsZW0gaXMgY2F1c2VkIGJ5IHRo
ZSBSeCBCRCByaW5nIG5vdCBiZWluZw0KPiA+IGNsZWFuZWQgdXAuDQo+ID4NCj4gPiBGdXJ0aGVy
IGFuYWx5c2lzIG9mIHRoZSBjb2RlIHJldmVhbGVkIHRoYXQgdGhlIFJ4IEJEIHJpbmcgd2lsbCBv
bmx5DQo+ID4gYmUgY2xlYW5lZCBpZiB0aGUgImNsZWFuZWRfY250ID4geGRwX3R4X2luX2ZsaWdo
dCIgY29uZGl0aW9uIGlzIG1ldC4NCj4gPiBUaGVyZWZvcmUsIHNvbWUgZGVidWcgbG9ncyB3ZXJl
IGFkZGVkIHRvIHRoZSBkcml2ZXIgYW5kIHRoZSBjdXJyZW50DQo+ID4gdmFsdWVzIG9mIGNsZWFu
ZWRfY250IGFuZCB4ZHBfdHhfaW5fZmxpZ2h0IHdlcmUgcHJpbnRlZCB3aGVuIHRoZSBSeA0KPiA+
IEJEIHJpbmcgd2FzIGZ1bGwuIFRoZSBsb2dzIGFyZSBhcyBmb2xsb3dzLg0KPiA+DQo+ID4gWyAg
MTc4Ljc2MjQxOV0gW1hEUCBUWF0gPj4gY2xlYW5lZF9jbnQ6MTcyOCwgeGRwX3R4X2luX2ZsaWdo
dDoyMTQwDQo+ID4gWyAgMTc4Ljc3MTM4N10gW1hEUCBUWF0gPj4gY2xlYW5lZF9jbnQ6MTk0MSwg
eGRwX3R4X2luX2ZsaWdodDoyMTEwDQo+ID4gWyAgMTc4Ljc3NjA1OF0gW1hEUCBUWF0gPj4gY2xl
YW5lZF9jbnQ6MTc5MiwgeGRwX3R4X2luX2ZsaWdodDoyMTEwDQo+ID4NCj4gPiBGcm9tIHRoZSBy
ZXN1bHRzLCB3ZSBjYW4gc2VlIHRoYXQgdGhlIG1heCB2YWx1ZSBvZiB4ZHBfdHhfaW5fZmxpZ2h0
DQo+ID4gaGFzIHJlYWNoZWQgMjE0MC4gSG93ZXZlciwgdGhlIHNpemUgb2YgdGhlIFJ4IEJEIHJp
bmcgaXMgb25seSAyMDQ4Lg0KPiA+IFRoaXMgaXMgaW5jcmVkaWJsZSwgc28gd2UgY2hlY2tlZCB0
aGUgY29kZSBhZ2FpbiBhbmQgZm91bmQgdGhhdA0KPiA+IHhkcF90eF9pbl9mbGlnaHQgZGlkIG5v
dCBkcm9wIHRvIDAgd2hlbiB0aGUgYnBmIHByb2dyYW0gd2FzIHVuaW5zdGFsbGVkDQo+ID4gYW5k
IGl0IHdhcyBub3QgcmVzZXQgd2hlbiB0aGUgYmZwIHByb2dyYW0gd2FzIGluc3RhbGxlZCBhZ2Fp
bi4NCj4gDQo+IFBsZWFzZSBtYWtlIGl0IGNsZWFyIHRoYXQgdGhpcyBpcyBtb3JlIGdlbmVyYWwg
YW5kIGl0IGhhcHBlbnMgd2hlbmV2ZXINCj4gZW5ldGNfc3RvcCgpIGlzIGNhbGxlZC4NCj4gDQo+
ID4gVGhlIHJvb3QgY2F1c2UgaXMgdGhhdCB0aGUgSVJRIGlzIGRpc2FibGVkIHRvbyBlYXJseSBp
biBlbmV0Y19zdG9wKCksDQo+ID4gcmVzdWx0aW5nIGluIGVuZXRjX3JlY3ljbGVfeGRwX3R4X2J1
ZmYoKSBub3QgYmVpbmcgY2FsbGVkLCB0aGVyZWZvcmUsDQo+ID4geGRwX3R4X2luX2ZsaWdodCBp
cyBub3QgY2xlYXJlZC4NCj4gDQo+IEkgZmVlbCB0aGF0IHRoZSBwcm9ibGVtIGlzIG5vdCBzbyBt
dWNoIHRoZSBJUlEsIGFzIHRoZSBOQVBJIChzb2Z0aXJxKSwNCj4gcmVhbGx5LiBVbmRlciBoZWF2
eSB0cmFmZmljIHdlIGRvbid0IGV2ZW4gZ2V0IHRoYXQgbWFueSBoYXJkaXJxcyAoaWYgYW55KSwN
Cj4gYnV0IE5BUEkganVzdCByZXNjaGVkdWxlcyBpdHNlbGYgYmVjYXVzZSBvZiB0aGUgYnVkZ2V0
IHdoaWNoIGNvbnN0YW50bHkNCj4gZ2V0cyBleGNlZWRlZC4gUGxlYXNlIG1ha2UgdGhpcyBhbHNv
IGNsZWFyIGluIHRoZSBjb21taXQgdGl0bGUsDQo+IHNvbWV0aGluZyBsaWtlICJuZXQ6IGVuZXRj
OiBkaXNhYmxlIE5BUEkgb25seSBhZnRlciBUWCByaW5ncyBhcmUgZW1wdHkiLg0KPiANCj4gSSB3
b3VsZCByZXN0YXRlIHRoZSBwcm9ibGVtIGFzOiAiVGhlIHJvb3QgY2F1c2UgaXMgdGhhdCB3ZSBk
aXNhYmxlIE5BUEkNCj4gdG9vIGFnZ3Jlc3NpdmVseSwgd2l0aG91dCBoYXZpbmcgd2FpdGVkIGZv
ciB0aGUgcGVuZGluZyBYRFBfVFggZnJhbWVzIHRvDQo+IGJlIHRyYW5zbWl0dGVkLCBhbmQgdGhl
aXIgYnVmZmVycyByZWN5Y2xlZCwgc28gdGhhdCB0aGUgeGRwX3R4X2luX2ZsaWdodA0KPiBjb3Vu
dGVyIGNhbiBuYXR1cmFsbHkgZHJvcCB0byB6ZXJvLiBMYXRlciwgZW5ldGNfZnJlZV90eF9yaW5n
KCkgZG9lcw0KPiBmcmVlIHRob3NlIHN0YWxlLCB1bnRyYW5zbWl0dGVkIFhEUF9UWCBwYWNrZXRz
LCBidXQgaXQgaXMgbm90IGNvZGVkIHVwDQo+IHRvIGFsc28gcmVzZXQgdGhlIHhkcF90eF9pbl9m
bGlnaHQgY291bnRlciwgaGVuY2UgdGhlIG1hbmlmZXN0YXRpb24gb2YNCj4gdGhlIGJ1Zy4iDQo+
IA0KPiBBbmQgdGhlbiB3ZSBzaG91bGQgaGF2ZSBhIHBhcmFncmFwaCB0aGF0IGRlc2NyaWJlcyB0
aGUgc29sdXRpb24gYXMgd2VsbC4NCj4gIk9uZSBvcHRpb24gd291bGQgYmUgdG8gY292ZXIgdGhp
cyBleHRyYSBjb25kaXRpb24gaW4gZW5ldGNfZnJlZV90eF9yaW5nKCksDQo+IGJ1dCBub3cgdGhh
dCB0aGUgRU5FVENfVFhfRE9XTiBleGlzdHMsIHdlIGhhdmUgY3JlYXRlZCBhIHdpbmRvdyBhdCB0
aGUNCj4gYmVnaW5uaW5nIG9mIGVuZXRjX3N0b3AoKSB3aGVyZSBOQVBJIGNhbiBzdGlsbCBiZSBz
Y2hlZHVsZWQsIGJ1dCBhbnkNCj4gY29uY3VycmVudCBlbnF1ZXVlIHdpbGwgYmUgYmxvY2tlZC4g
VGhlcmVmb3JlLCB3ZSBjYW4gY2FsbCBlbmV0Y193YWl0X2JkcnMoKQ0KPiBhbmQgZW5ldGNfZGlz
YWJsZV90eF9iZHJzKCkgd2l0aCBOQVBJIHN0aWxsIHNjaGVkdWxlZCwgYW5kIGl0IGlzDQo+IGd1
YXJhbnRlZWQgdGhhdCB0aGlzIHdpbGwgbm90IHdhaXQgaW5kZWZpbml0ZWx5LCBidXQgaW5zdGVh
ZCBnaXZlIHVzIGFuDQo+IGluZGljYXRpb24gdGhhdCB0aGUgcGVuZGluZyBUWCBmcmFtZXMgaGF2
ZSBvcmRlcmx5IGRyb3BwZWQgdG8gemVyby4NCj4gT25seSB0aGVuIHNob3VsZCB3ZSBjYWxsIG5h
cGlfZGlzYWJsZSgpLg0KPiANCj4gVGhpcyB3YXksIGVuZXRjX2ZyZWVfdHhfcmluZygpIGJlY29t
ZXMgZW50aXJlbHkgcmVkdW5kYW50IGFuZCBjYW4gYmUNCj4gZHJvcHBlZCBhcyBwYXJ0IG9mIHN1
YnNlcXVlbnQgY2xlYW51cC4NCj4gDQo+IFRoZSBjaGFuZ2UgYWxzbyByZWZhY3RvcnMgZW5ldGNf
c3RhcnQoKSBzbyB0aGF0IGl0IGxvb2tzIGxpa2UgdGhlIG1pcnJvcg0KPiBvcHBvc2l0ZSBwcm9j
ZWR1cmUgb2YgZW5ldGNfc3RvcCgpLiINCj4gDQo+IEkgdGhpbmsgZGVzY3JpYmluZyB0aGUgcHJv
YmxlbSBhbmQgc29sdXRpb24gaW4gdGhlc2UgdGVybXMgZ2l2ZXMgdGhlDQo+IHJldmlld2VycyBt
b3JlIHZlcnNlZCBpbiBOQVBJIGEgYmV0dGVyIGNoYW5jZSBvZiB1bmRlcnN0YW5kaW5nIHdoYXQg
aXMNCj4gZ29pbmcgb24gYW5kIHdoYXQgd2UgYXJlIHRyeWluZyB0byBhY2hpZXZlLg0KDQpUaGFu
a3MgZm9yIGhlbHBpbmcgcmVwaHJhc2UgdGhlIGNvbW1pdCBtZXNzYWdlLCBJIHdpbGwgYXBwbHlp
bmcgaXQgdG8NCnRoZSBuZXh0IHZlcnNpb24uDQo=

