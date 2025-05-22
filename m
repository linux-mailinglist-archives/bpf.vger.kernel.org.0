Return-Path: <bpf+bounces-58707-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1073AC0168
	for <lists+bpf@lfdr.de>; Thu, 22 May 2025 02:28:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2DC7C7B241C
	for <lists+bpf@lfdr.de>; Thu, 22 May 2025 00:27:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 523FD18027;
	Thu, 22 May 2025 00:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="UUSQmrLd"
X-Original-To: bpf@vger.kernel.org
Received: from CY4PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11020099.outbound.protection.outlook.com [40.93.198.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39DB12F41;
	Thu, 22 May 2025 00:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.99
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747873686; cv=fail; b=c1SPwWz92iJcAR8/SWl9vtaoJewBnWAIT6Rju+BRGFYohzKBgA9UbBi6AmBOmdPxdsNY2hDIgI+n/BKx29vqW7slgmAA9iU2M2wM5Zxj2vw2G0/qPJn3BX4qdxJVIL/Hx+KSJagRu2zUPZPVHu3EbHh4UlpZhQPQyUPTQ4d5LDQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747873686; c=relaxed/simple;
	bh=ZxH5pFBS8MQTBbshM+F99XFuOaj+jcQto3jJncth6PU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=iTpbWZwfk3q1DK71iVWP9hxfuF9i9Uk+2jMmErlRh8rqd0K5kG0egYHmQh2ubvszx+Xf9/qLzXCl94R17Lg41AUpgyr5B9RYt88RUGsblqlvbRAep2VhBz8ImolbVBj8VDBn1AHnRSIH6zLT2VNVPfjW4lLcBq5/tZ2IGUUvnCc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=UUSQmrLd; arc=fail smtp.client-ip=40.93.198.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ov2BVy1O3UgGpbcbOkVmmVs3+KWwY5LAM0RlF9czJMVizaJp4/wEyQvQstLAyDb9g0n+rg3p0p95Rp66FvgdNh8KBiSoA0JtmMkVtNSoe9jYD/3af/XeCIQOVmfPdWsEGDAEkkb9fsnNjBM6Q0E8BkhLR4XH0ka92EYXVc4MW7Jim1srzYpT/H0h2bAmOnpaTfHGeDjHLgUkjjTNqKrNz3zhTrAxsrUnPHD6dus38FYne21m1OnoQlhfCM0Okq47fisQfHCP2speonzfkE9zryhDj6Uv1go9oDOOw4zY6sKHGiUqlM8ZPFugyiagZJAhNV4IbpFQl12WQsuhXYr1EA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GyMO0bzPeVhS1Boh8a/0HYN5TsNhuLvu4gCqhhvpDf4=;
 b=to2BV1y5HXy50sRQCyvoSwaJSW1xbqc9FlDoxbWNQpT0rELev07R07pOBaP1K0HTuT0BVAnVaprEvXeSIFtQqlF8U2tX96Sfdzin2N+G+8CpIW1VW6Qq9oA920lPJLKGO6fNf0gQE0ilOAYNQLG4JAkeOzMvWRfbRXlsPl8h2NysI8LbZB6OKSUFe7WEOpLUD1Yqaj4WbxZvMWwFxQ0bCsUmzFZVKUqgG4JZP9Tz8Li3hOx2FFQJvEjxViRSLkN7j+ksh8YLMwxtylMRiL0o1KzDfKfpv9ivAn/WZkKLL4FHzA/eSEPcd7bt0nPpFG35D3bPpE4NjfRHXwMjmx1c1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GyMO0bzPeVhS1Boh8a/0HYN5TsNhuLvu4gCqhhvpDf4=;
 b=UUSQmrLdcqel/iNek8sJqMHuFCKfDm3/cMnBGrfvebXuOX20AtF6b9Jdh+eALts285wHZxD+0G8OFUYvQM8Qca0XHPUiXrxiggQOCVMNn8zand89iQHeVgm9XATOPq9W2agehTua/7Uk2555dLBVF98fydHsE61us38I4uWc+n8=
Received: from MN0PR21MB3437.namprd21.prod.outlook.com (2603:10b6:208:3d2::17)
 by BL1PR21MB3232.namprd21.prod.outlook.com (2603:10b6:208:398::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.5; Thu, 22 May
 2025 00:28:02 +0000
Received: from MN0PR21MB3437.namprd21.prod.outlook.com
 ([fe80::5125:461:1c07:1a97]) by MN0PR21MB3437.namprd21.prod.outlook.com
 ([fe80::5125:461:1c07:1a97%4]) with mapi id 15.20.8769.019; Thu, 22 May 2025
 00:28:01 +0000
From: Haiyang Zhang <haiyangz@microsoft.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, Dexuan Cui
	<decui@microsoft.com>, "stephen@networkplumber.org"
	<stephen@networkplumber.org>, KY Srinivasan <kys@microsoft.com>, Paul
 Rosswurm <paulros@microsoft.com>, "olaf@aepfle.de" <olaf@aepfle.de>,
	"vkuznets@redhat.com" <vkuznets@redhat.com>, "davem@davemloft.net"
	<davem@davemloft.net>, "wei.liu@kernel.org" <wei.liu@kernel.org>,
	"edumazet@google.com" <edumazet@google.com>, "pabeni@redhat.com"
	<pabeni@redhat.com>, "leon@kernel.org" <leon@kernel.org>, Long Li
	<longli@microsoft.com>, "ssengar@linux.microsoft.com"
	<ssengar@linux.microsoft.com>, "linux-rdma@vger.kernel.org"
	<linux-rdma@vger.kernel.org>, "daniel@iogearbox.net" <daniel@iogearbox.net>,
	"john.fastabend@gmail.com" <john.fastabend@gmail.com>, "bpf@vger.kernel.org"
	<bpf@vger.kernel.org>, "ast@kernel.org" <ast@kernel.org>, "hawk@kernel.org"
	<hawk@kernel.org>, "tglx@linutronix.de" <tglx@linutronix.de>,
	"shradhagupta@linux.microsoft.com" <shradhagupta@linux.microsoft.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, Konstantin Taranov
	<kotaranov@microsoft.com>, "horms@kernel.org" <horms@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [EXTERNAL] Re: [PATCH net-next,v4] net: mana: Add handler for
 hardware servicing events
Thread-Topic: [EXTERNAL] Re: [PATCH net-next,v4] net: mana: Add handler for
 hardware servicing events
Thread-Index: AQHbxQ8aGwJ02PB/20SlKvrJreDKI7PWBTYAgAfRH3A=
Date: Thu, 22 May 2025 00:28:01 +0000
Message-ID:
 <MN0PR21MB3437D613402940F84D110944CA99A@MN0PR21MB3437.namprd21.prod.outlook.com>
References: <1747254637-3537-1-git-send-email-haiyangz@microsoft.com>
 <20250516180440.0db7b35a@kernel.org>
In-Reply-To: <20250516180440.0db7b35a@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=2a196993-6976-4e57-ab53-c8887edf2bec;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2025-05-22T00:26:56Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR21MB3437:EE_|BL1PR21MB3232:EE_
x-ms-office365-filtering-correlation-id: deed64b4-63dc-4a0a-08cd-08dd98c782ea
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|7416014|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?wG3qKFhsAiGWfP6ImD5rZGyZky9XuOaVw3BFyKiMResfSD8/Q6/LSng3eTi8?=
 =?us-ascii?Q?04d+mxOYNA57f8GaUftqUDuibjvis3SALi+LP8kIhK75TTTsW9ZewzX9DYbU?=
 =?us-ascii?Q?LDiMwNKTha8RsQOLCYow+xmJ9/LY3dIkVy+9j0Bnh3gRYrCJ2YTFpchL75sK?=
 =?us-ascii?Q?H2WPtBGtaWK52WbL8XFRNAKFTCWhvjDn7lLSTdW+MS7TlaiacqSh7kUKcLe1?=
 =?us-ascii?Q?eK8ZPAN3KR1THnNXyWgyx4+YRyo7gbbAtPaD/dznuSh1hz7IvGP3lW4gRWYl?=
 =?us-ascii?Q?dEEOJgeYQnOn2Au2r6xMSda6aI2ojRc+kKzux5OWubgzjuyr3Uiag4t0w2NQ?=
 =?us-ascii?Q?f+Uhhe7lgzGaL+xb5Mz5uWmcPfufbMd0bQ3A3pVonH8NruD9nkwKbZGK615V?=
 =?us-ascii?Q?hncFXKL9kyUXSYt8Zh0v1e6SW9mk6hntXRqizPb6sVxOYiGby8d8CPDYpS1f?=
 =?us-ascii?Q?TqDIoJK3UhJSJ1WRvlyyL0xMuQm5deRbCzv3CYlwrq8irBgrsopH0hSnQ824?=
 =?us-ascii?Q?41fIQL9kHKmq01ObZdGFf/2seEMqfyNZATiJhszqMVelv1PW3yMJqU3ca1Ok?=
 =?us-ascii?Q?NyXwyWpVRYzLHh92LiXabTmnrSspW4WtUuuEPwVsw9sad4+tPP3ZyU56JMIe?=
 =?us-ascii?Q?/6j2LSUsCu8JoPuA6GcxElaqmD38D/TyRpb3ipKJn5VQhz0ju1q/tZZ2FOOp?=
 =?us-ascii?Q?/fs6WCM8jiE4vNXbLHR2Wj5k+i0c/+K8Y2m5AjRlG05kWv3Xg91tT6FUAYeB?=
 =?us-ascii?Q?wCj/aa6x6BpH8TOgWmd7WAEM6Jklei1z3TFFgrI1bH8/MEYKcQK4vAv0Inv+?=
 =?us-ascii?Q?hRV4pajBvaavTIVfH/UOiv9moOTEpLU6q5ejUWD9pN4XsX5ZWLle549hmo/m?=
 =?us-ascii?Q?FnHKV3QiMA2VoyPtu3ZUKCi1Mg4Q6SctMNKwSlqXCGQNuzXK++8Dw46nBF0P?=
 =?us-ascii?Q?bScqyHzEDAt9AygRIaGWAnR5bgWYXClOSpdbmldqWnX4VQ5oum4d0eMOyNQO?=
 =?us-ascii?Q?SKTHk6ZihXmR520JYM1maMao8P4UZ46W/kRE9OjIITpjAatULBDhWWIUorTa?=
 =?us-ascii?Q?gp+VUrpDMP77/Sksi7RcUFbI+/Hx2Cnw6LuaA8fjGg4tuCbJqtN3W+u9vBLh?=
 =?us-ascii?Q?t2HZVVZRSBfiJgP6f0M0npdhHLdAAYfh8XDwTuHf4PgYNpqs8fQOlINjs2pR?=
 =?us-ascii?Q?ypfG7vOLbqnMmcFhUTqNHGd7c4AvsiSxZKU+63/LVizfse51K3up5Vnn52PS?=
 =?us-ascii?Q?TpCWBd71HYnzFkVc0Z9M6oh1btfPbEchq0jlC6EHQh9s5kuynZPLyx0ammH6?=
 =?us-ascii?Q?JHcfLwRVwRMk2lsl3NxNu3DQx0MwY6fnU7Jn0lBaaun86Jet0j24hQmjF/Fu?=
 =?us-ascii?Q?y+lFkeKMlBZW6r3mkz+pq71ysPfR8qjmz1Pet76Vx0Htti3ORi5vTgKyrs/Z?=
 =?us-ascii?Q?dmxWc8MEQv19GfSuqtmKLPFPYdnjGULRbMhFZVJJnu0m8ubX9OREXg=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR21MB3437.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?ZNFf9vpiUM8uXjphy/Cvq/gdIaSPqW1f6yVm+7jV86WA7VqBgrgnXKwLfo/k?=
 =?us-ascii?Q?MrU4Q9CLou3ezPhSiaVbaR9kiIF+NHyO/pvTUGqQtBsBK5xT5cBSPQ7x93Zd?=
 =?us-ascii?Q?HFnRaARgyrIC1d8Rs8rxVZNJ1IBYfHS/nmcgzHoCaGIfuFLXtERSnEgG0vIB?=
 =?us-ascii?Q?GtMsnAKdw44oaBFprt6+gIHnsgNXNUwfzMKw8SP3cIDP5zqeHZ0Z3I6Kz3xY?=
 =?us-ascii?Q?P4NTRxR2lTJXYT8Ony1BlxJa0RDurCXr7qRu+VRmDmzdeVM3XTSKvLr65Ck/?=
 =?us-ascii?Q?JM/m06W1QdiVGtDlQRfBNcXxXhFd8R8XswsbcfiImucHbw0vuRM6+jVLGtPx?=
 =?us-ascii?Q?C5VHBTNlx2H4dsn85jF3wv7rNxotj8hek9aOk6En32ErxnVoAPUWkP91JQnc?=
 =?us-ascii?Q?ucWBtoTf1slsJ9lByrjUSArfsjTCI64kIqSBfc41Xs5qdRUQTxROB1ktwFCe?=
 =?us-ascii?Q?1M0IEzGd/816TTiZcx1B5oZnuBUvlgR4LdWQL4uWeKqlwIRNzfUicy/UEAr7?=
 =?us-ascii?Q?mctZQuOf89NFG7mZcrVu7i7jpxJlT4TBykmyXKtWpg514xQW9GNldm6V4e3y?=
 =?us-ascii?Q?L617Xfx2z/SzgyKl5o8UMn3rLclduqlGrGqYAHclEnvQizIQEehcrT4jdMjr?=
 =?us-ascii?Q?ss1I/wM8bIImQZke9DntsruUWmf05pi5ZlHsPY8z8m1xa3v1iqn925Gq0aoz?=
 =?us-ascii?Q?nVg2GFdPqmk19nrxE4M4vZhaMS+5apaRoDYIMO59szBaoahImYY+/Dsie+4P?=
 =?us-ascii?Q?DvcOIhP5/xtuXtHU7jmmy9O4Uwm3qIY0XHhsAQaTQ/Aw1Iqubf2SHFnALOHM?=
 =?us-ascii?Q?YfB3ThgmoDJRb/6ApbszkAfKWNu/aGQL4Cxeq/916WLIFOWMSiWCHeov54Ty?=
 =?us-ascii?Q?qc855nWEhZ0rlyAzy97f5z6OpdAkB433fWqH2M9cC4b259pvUNfMeue3czF/?=
 =?us-ascii?Q?+q2eWjOs1Ko2rwX7sY4aVg07Zr/1RT0IhGItzRZyDwb6lTM/wI/5DkQUqFmZ?=
 =?us-ascii?Q?4khlon/kwHsKTHmyNZAT5ZngdNtF2uSIosYNUDnBYJ1RjBIv0W5VkIIQn7k/?=
 =?us-ascii?Q?Mu2gNEt2dg0cyRMgJM3WPisi2lR89EvwjtOiGGE8oGokOiZNvU4glgU0xSt6?=
 =?us-ascii?Q?sFXoFbVjDLyP2blmayGQeKb9unMxdc2Iu8t2E1jb7ZuMD4GnemoEWCHG8QFQ?=
 =?us-ascii?Q?5sPL8T7Og16SCiCHVpvgzXFLLObH/AOK0L4+4453f/CxKGOgPKQip1PkdV1O?=
 =?us-ascii?Q?9GLTJzCeYKIs2I610cfANq+hOEH7yu9qBLZBAHskMFMa1VYYzD+IDBdgFusY?=
 =?us-ascii?Q?6jNENDtZsUvT9NjGAx9iFRTIMyGhbEhKWL1vQiZf7exbsivGMLIKcm7ikcg6?=
 =?us-ascii?Q?EffOqILfuLnRnXJ0EBCOiUGXTJMqpNxuAMEer2bcc1jh8eM8iS5bBypdGt9i?=
 =?us-ascii?Q?Gik5vUGEU4q4Odsky3NnH3OXVh7kff/mAOwEWdGrHQRgRDd1TDSpZVlfBFWF?=
 =?us-ascii?Q?e5jM4OhDNW+OsGPuzH8LhMFLbDKaKvLEd6+xLM8efbJXOGDWb/kuHNZjb55i?=
 =?us-ascii?Q?KAdk7TL7Tkb5zmkX925x9dYFpeL0MKpHCS6CoWY3?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR21MB3437.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: deed64b4-63dc-4a0a-08cd-08dd98c782ea
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 May 2025 00:28:01.8151
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XP/sqDSq0JNaFWx9MYk1+TXgv7gSqhYZGbhzGlNmNV20MwDSk8JBQtG69MlppJwo0/Qzs39fabtGQ3LCmXyd3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR21MB3232



> -----Original Message-----
> From: Jakub Kicinski <kuba@kernel.org>
> Sent: Friday, May 16, 2025 9:05 PM
> To: Haiyang Zhang <haiyangz@microsoft.com>
> Cc: linux-hyperv@vger.kernel.org; netdev@vger.kernel.org; Dexuan Cui
> <decui@microsoft.com>; stephen@networkplumber.org; KY Srinivasan
> <kys@microsoft.com>; Paul Rosswurm <paulros@microsoft.com>;
> olaf@aepfle.de; vkuznets@redhat.com; davem@davemloft.net;
> wei.liu@kernel.org; edumazet@google.com; pabeni@redhat.com;
> leon@kernel.org; Long Li <longli@microsoft.com>;
> ssengar@linux.microsoft.com; linux-rdma@vger.kernel.org;
> daniel@iogearbox.net; john.fastabend@gmail.com; bpf@vger.kernel.org;
> ast@kernel.org; hawk@kernel.org; tglx@linutronix.de;
> shradhagupta@linux.microsoft.com; andrew+netdev@lunn.ch; Konstantin
> Taranov <kotaranov@microsoft.com>; horms@kernel.org; linux-
> kernel@vger.kernel.org
> Subject: [EXTERNAL] Re: [PATCH net-next,v4] net: mana: Add handler for
> hardware servicing events
>=20
> On Wed, 14 May 2025 13:30:37 -0700 Haiyang Zhang wrote:
> > +		dev_info(gc->dev, "Start MANA service type:%d\n", type);
> > +		gc->in_service =3D true;
> > +		mns_wk->pdev =3D to_pci_dev(gc->dev);
> > +		INIT_WORK(&mns_wk->serv_work, mana_serv_func);
> > +		schedule_work(&mns_wk->serv_work);
>=20
> I don't see any refcounting in this patch, and the work is not
> canceled. What if the device is removed between work being scheduled
> and running?

Thanks for the review. I added refcnt handling, and submitted a new
patch.

- Haiyang

