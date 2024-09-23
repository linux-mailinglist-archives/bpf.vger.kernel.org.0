Return-Path: <bpf+bounces-40185-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 22FA497E5B4
	for <lists+bpf@lfdr.de>; Mon, 23 Sep 2024 07:48:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 881171F217B2
	for <lists+bpf@lfdr.de>; Mon, 23 Sep 2024 05:48:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B92B4168B8;
	Mon, 23 Sep 2024 05:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Z8glwOZI"
X-Original-To: bpf@vger.kernel.org
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2071.outbound.protection.outlook.com [40.107.249.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17E251FDA;
	Mon, 23 Sep 2024 05:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727070517; cv=fail; b=aNlxRjQwEtY9uzhZNaqo4UVGXGLOBtNr90kG/n+tLrgcoWlVFFdqOU1L1peV8qYGVEAiXAO5x8yRaXFpT+gOhnwPn3Kfkyb9P53nCPjgSbtStiNgK5+Dw87stKv/oxUb0xvIx/L102UQWbv/zrxjcAijs4Wo0jCSZ/ha3b1iM2o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727070517; c=relaxed/simple;
	bh=zwqjfXNimAT/6Ei1+VxYO3UNT+2r0TnfhOTJ26DcEBQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RysVtm9ialbzdVF1IvCnacsBIXmHA7wvOn+vEFWkkOTTQAcleiBnQPMbx1nGLWZ8ppP5uGaP/dfixQ2NaPMcSdVK0iaGeiwK1GYfbIwqsDeazqEsv4GyflUI1z+87iE7uhFl9F4Mv1Hi620FIBRO8R2Dikkms8CtkOsKwRUTDbo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Z8glwOZI; arc=fail smtp.client-ip=40.107.249.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mgjClA50cui4HMLh1l/sxsivqvzw+LJcbRhI8jSo1+1caYGS/AuYv6/zia56GdSMU7srkzhrdFbpxXODdC+5vCeYk5py7bk1owJRwG0eT4be6cuDib72dYQosO62nWXw1GzM5PP50vMiJqgbtk3zLrX3DpuA314mr8ujUj89o+QwqPmwsmWo3s+G34IpCgjbzWyeSeCAZUlgEf7xPDYoKPT99qKKwNA1ZI2MYcZJF/cuig/+/b+nyVzajqlceSmb2ZYCKMEkM7slFum+CsdZQHRaAta0+6bg3tzn1vWVcOd9DO5DUEAy6iv53FF0Uefb0Gm36xI9DFYmV11nWCNsRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zwqjfXNimAT/6Ei1+VxYO3UNT+2r0TnfhOTJ26DcEBQ=;
 b=gNZhLlHRZv+VvjWHCuRBn0MVJh+hpH5cNSYktzQ8xiIqovIe2BR3mZsEbydSECjxR9GL2a7bq7ZdmZxM5C00hGdqAgOMCurOiVeqhGqX20zNscx4HzY3Ksrzh31yPSxxMSagVgmRiLyjbdrkANHMq8WkM91iE2gLGMvO3QA30VKFU7qROfXqXvcV04lMFgw8MsB0yRUss3mOU4IEXSxUQ2DrOD3HsFvh0X6s8xNHQxOayqQtltK46tFi1riehlFBpDc0m/u12bBCg/2n1wD9xj5F0ebLNnUpFH4pUfAhlkExEjVpmbUeOT/4esinNSfQJABzVFyWatsmU41iM6EVoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zwqjfXNimAT/6Ei1+VxYO3UNT+2r0TnfhOTJ26DcEBQ=;
 b=Z8glwOZIit9A4Fk90SjCCJyQYuQyMDbiP6nwJl8/z8fsUrFH8r5/28nLnXn+5bowcN7xmZkjARAbIh5H2nSsbk4JENhAkYhglgl8NtVWgA/vXVMdJVUnaogX0BNySuBn+W/JY6TUchlQuPmxe6wHB9wUCrpMVKgu73noYsU6z/VGaVIb4sWl62lp92hVDlLQSxl6kxNMqZvhDyKs7Lh1gCCDhGzzV4jT2xjSAn1EzpqYE8/IDwQpypGoSJM8DE8dTJWlKvQJkOQiutsVo7p1TF6H0anv39CzYtqMAmIgP3MitWvhk/6lEfVIdzBPgHVN/gIpwC3qMFh0CHlXn0TU0w==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by PAXPR04MB9569.eurprd04.prod.outlook.com (2603:10a6:102:24c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.24; Mon, 23 Sep
 2024 05:48:27 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%6]) with mapi id 15.20.7918.024; Mon, 23 Sep 2024
 05:48:27 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Ratheesh Kannoth <rkannoth@marvell.com>
CC: Vladimir Oltean <vladimir.oltean@nxp.com>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	Claudiu Manoil <claudiu.manoil@nxp.com>, "ast@kernel.org" <ast@kernel.org>,
	"daniel@iogearbox.net" <daniel@iogearbox.net>, "hawk@kernel.org"
	<hawk@kernel.org>, "john.fastabend@gmail.com" <john.fastabend@gmail.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "bpf@vger.kernel.org"
	<bpf@vger.kernel.org>, "stable@vger.kernel.org" <stable@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>
Subject: RE: [PATCH net 3/3] net: enetc: reset xdp_tx_in_flight when updating
 bpf program
Thread-Topic: [PATCH net 3/3] net: enetc: reset xdp_tx_in_flight when updating
 bpf program
Thread-Index: AQHbCnHT295KDDvRD0aXaVmRMCCprrJfGOYAgADMJXCABO/tAIAADehQ
Date: Mon, 23 Sep 2024 05:48:26 +0000
Message-ID:
 <PAXPR04MB8510905E1635A41BA393C8C6886F2@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20240919084104.661180-1-wei.fang@nxp.com>
 <20240919084104.661180-4-wei.fang@nxp.com>
 <20240919132154.czugz52nirmijohe@skbuf>
 <PAXPR04MB8510727BD7B77261491B4D31886C2@PAXPR04MB8510.eurprd04.prod.outlook.com>
 <20240923045620.GA3287263@maili.marvell.com>
In-Reply-To: <20240923045620.GA3287263@maili.marvell.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|PAXPR04MB9569:EE_
x-ms-office365-filtering-correlation-id: 52b21123-0bf8-47af-553f-08dcdb935878
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?gb2312?B?UmU5enFtVHk4SHpkZ0ZRYU9NZFRZWjgwc09jSFk1eWR4dnNWd2t5ajJoSTFM?=
 =?gb2312?B?dExrWmZXdGpPMlF6c2xMNzZXYUtKZGpnM3BQTUVUUjlxZ2NKakZTSy9URjNN?=
 =?gb2312?B?cEcraGpTcmVuRDZYZzYwTk1MQk9DMjBNaTFSTjQxYS84NFJrWkxaa3F3d1Yx?=
 =?gb2312?B?dmdQaFBFdW1lVldwcXVPTmxrT1ZUekNRYU02NGlmK3o1blZDZ3E3TFUzZS8w?=
 =?gb2312?B?U1VUMGNoYmdaamVmUGpXQ2QvbU1QRmJXeXVoTXZNMUlQb0IvalAzekU3Zzgr?=
 =?gb2312?B?Yzd1em1uQ20vR3lQY3VhSzdwYVQ1bk5VU3p0ZkNGYU4xODA0K2hVWXlGM1BV?=
 =?gb2312?B?KzdHWWtjSlpobkptSFpVa1RPbzZicnVuMk8rODB1QXlqMjI5Ry9xSldUNHNj?=
 =?gb2312?B?cUVWeVErdWVSYnJYeUp3TDJXVW9Zdi8yNFR4MmlmMm5GcG9hdXk3djVkdEN1?=
 =?gb2312?B?dTgyR3ArY1o0NzMzOGI1aXA2MUR6N2h0d0ZyOEJURUlqUTl5VVhOSUM5VnhJ?=
 =?gb2312?B?b2cvSUlsaGROaldqOGJqaTZHdHVEWjVLb0tEak54eEoweUhjMk0raTRFbERr?=
 =?gb2312?B?eWNwODFndXJRVGE4d2hOR0luUlVQKzFtQmJtVndGVGxianhxZFRrR0Y3TUZt?=
 =?gb2312?B?clJsYXlCNUpGblVUR0toNHJxU2FlVjNiRGg3SmJ5aHhTaEFhZ1FYZC9odnpK?=
 =?gb2312?B?NDJCSXFnbVZTTFo0MmhMcG1FZ25aVk94dHFraWd4QktZd0drOWhDbzBML2kx?=
 =?gb2312?B?Y3dEdlNwc2pIbTBhNFg1RGo3MUFrU1FHcm1zL096OXZwN0o5NEhKbjZINk1X?=
 =?gb2312?B?aFJQNCszd0g0VTFXYzhmbDNVa1BmejdvNEpUbVREczIybFRwbFdtWXltU1k4?=
 =?gb2312?B?ckQ0V2x3M3FSbkNBL3hqMXAxMEVjU3hLOGRiK1g1VTZrRjZwWUt4V1doeklx?=
 =?gb2312?B?VEtNY3pkcWhCa1dmQTJ4UHNtOUxsUDE4YXoxT2JpYkRSbFZKakJkS2dOWVln?=
 =?gb2312?B?WlhnbVNkUFZmcXBXYVpGMzFzaDJrU0FHYURFWHM4Z3ltd0d2TXRrM1RFc1dJ?=
 =?gb2312?B?MU9wUDNWTHlFQ0NmbWFNRGVMTk9ML2xFclVNblF6NXBvVWd6QXB0ZTltSUFw?=
 =?gb2312?B?M2ZEWVNwWjNuNEFWeG1yZDc1bTJKRlJGbGVjQXBsYjZvcnV4YXFKQjk5NEhl?=
 =?gb2312?B?V3Z3Q2VWb3hJRVhuNDhlOW9VaG80MXMwKyt4ekhlcStxZVZQbFNHQ29VS2VT?=
 =?gb2312?B?REk5QmpBbUFDd0MwYlNDUVpNQm5OOGVZTC9NV0F5Y3VsOUl4Zmo4czVjcGNG?=
 =?gb2312?B?S2Zsak1Pb09UYzRQR0JvMm1LUWRrTlYvU3R3MndnN0VYRHQvUUtDYWVXcnl3?=
 =?gb2312?B?bEdyVG03eWI2RWE5OW1FZS9tSTd6TXREKzhvTDc2L1FTbjA4SDBtZ296TmxX?=
 =?gb2312?B?RDh0cG5ZT2Rza0N1OUZGWjNEeGRuWUNDM3VlWmRzdEwwOGRqWDBPQXRFb3lr?=
 =?gb2312?B?cmxrTGx6NmRlUWE1SjVSaGpwRVZZdFR3dHNxdEtrSzFoRmxnaVU3eDU3dmc3?=
 =?gb2312?B?eEZKcWdFaldFVTNNUGlCUk9zQkxvYlRJb01MYUlGRi85dVp1Z0NCME1yY1lt?=
 =?gb2312?B?ZXA2RERvU3VVWXMzSnRtSW11ejc0TjUxc1lFQVZ5MCtESDV3cUgremUzYWRR?=
 =?gb2312?B?UERGTEVNZ2FyVm0yVVlLMDRFYlFxQ2ZLMzJKVHhSK2dtQXpXeC9TTkFzUFhR?=
 =?gb2312?B?aVgyUHNXeW1IcUF4S0hPdU80RlVGUHI3SXJlS0xqZjFGYmhPTTc5U3RpdzRy?=
 =?gb2312?B?ZFhYYmhKc2FLRXl3RnYzdz09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?TGtERWlWektMeUxzQndIam9iZHN2c2Q2dUR4VS9wVFhJdDFObSt3Zi9QL1lX?=
 =?gb2312?B?dlhKZUFhR3RoMm9UaGFCWlJmeVpnVzBHVXJSUXA4L1VMVVJnQStDSWV5TGRB?=
 =?gb2312?B?TCs1VVBrZCt1V3laL1lRU0YvNWhLYjZFanBST3NJMzNaYTM2QzNQeVIrWXBB?=
 =?gb2312?B?RGlyVXZ2d0U0L0NFc093VVFwMGJRZHhSMVVVK0t4WDVJQzhIR0tFYU0yZzhy?=
 =?gb2312?B?cWdiVXUwUGdxUXViVWhpYTR1blkyMGhITUtJU2RoekRMNC8vUUpaWGRtckg4?=
 =?gb2312?B?VERGMExCMFFTMzFKcTl2SE16Y3NEUG9LTTFMbjFsNnVWUWZpVUVnYTVOSGc4?=
 =?gb2312?B?MDR3VVpqSmNuN2JRUy9yN1hJbzBpT2JIM2pMeXJVSnE0TUlodkpEeldINHdj?=
 =?gb2312?B?UUhsN1AxV05nQjFwMHpOdUx0MStSLzN0QXNXNVpKY0t5VEU1SkV5cGNzVURV?=
 =?gb2312?B?RElqTk9xSldwd2pIaDk4TXRqSkVTNlVKbmQwcVRzZ0UxU0NoY3hOVkFWYWdj?=
 =?gb2312?B?Y2hhVDNNelpXZXVna2NNSktsRUw5azRTQ1FUVkhjOWQ4VzRvSXFraVNWY0s1?=
 =?gb2312?B?SkhwZkhjLzJqaUlOZ1FHRnRFYkVteGdvL29rc0twVTJFcjluaFNWbHBiSjFi?=
 =?gb2312?B?MmE4ZzlvNGt5aS8vQUZjNjlBVGFLWTQ4eVZFc0tSeUlZWURyVWFBZDdOSURB?=
 =?gb2312?B?Unpidk9zUDhXdFc4V2J6bFB5TklaTTdtYVNnRkRYa0kyNjIydnl3OFZJcDV0?=
 =?gb2312?B?dnFxcDN1Z252UHVHZzVmVktlZ0xaK1Z6am1OSzd1WTFPVzRuNUZqdDBCaXNh?=
 =?gb2312?B?WEFtNkRCU0hCUlQ5cEFERFNtL1Q2aFhhWkdGNXZDelVINXpiOEdGMzh3VExP?=
 =?gb2312?B?ckxjYVdMaTVFcktHRW9JTEdkZXZuVUpIeWE4ZWVOTG9NT1JvZ2p0OUVVL1cz?=
 =?gb2312?B?NXJuL1o2amNobVBLWTErVEZNRjFhYU9RejhzS0VqZWpybGJ1QlpqUnFLcTdt?=
 =?gb2312?B?YVZVQStPbk5zSzdmQUNzZy9yKzBtU1BGYWFxdGtnZzJhYmJEZGNFdDJDNDZT?=
 =?gb2312?B?VmFkckt2d1lEZHFDcHhpbFVySUhseTBSM3Y1ZE1GYW9BZjZaU2ZUWGFNM2dj?=
 =?gb2312?B?MGw2OWNibGxubDVzRlZCM1RBWnQ2N2pOMVR3K1lqOXh5Tjl1VURiYW1vSjJJ?=
 =?gb2312?B?aDNLdEhTZnF0cFZhT0c1UlREbUVuS3UvOHRzQXVvd2xpbHEzSGRsUENnbE0w?=
 =?gb2312?B?RmYzTkFISjd5Z2JEWEc4dHVxWCtzRWxTRGE4ejdITmhaU3VsRzZnR1VVN3Uw?=
 =?gb2312?B?TEo1TnJpbFNmRG1rU3NtbHNCQ2lCdUc1czZyWGM1eUdDa05KSncwOHc0WU5k?=
 =?gb2312?B?amltNUM0UEtFYnE0TUhhZi9yTnpmcjgzWFVBOXcrT0RtQVU1dVBNNlVtc1lo?=
 =?gb2312?B?SlB4dmNCZ3Q3eDJDRnJBeFYrWkh0aUJqTEVJVVJtNWN5eGN4dmZXcnEwWnp2?=
 =?gb2312?B?YWhVK1c5Y1pCWElteWxqUnhTRXpaMXRMTVl5YUJRczBFWngvai9oR3JXTkhO?=
 =?gb2312?B?cEFobE50WTU2bDAwRC9ULzA0bmZ2Si9MS0lHM3dvVWQ0YnU1SlRDMmtBaUM3?=
 =?gb2312?B?cUJSTU5DYlk1NG03MitPMzMzMzYzM3hDVFh2ZjhzSy9OWjZoMC94UXpXUTAx?=
 =?gb2312?B?alNNSzNlQ3RTZFZaYjBBK1k1YisvbGNDSldOQ25wdjBFYnFNVFE5OTBZaDEx?=
 =?gb2312?B?Uk1vMysxcEsxMmJJVUI5T0txVk5vWjRjdlZDRitLVTQvdEdjSllPSnFXSVVi?=
 =?gb2312?B?alZ2aytuQ2RVNnhpWUdoNWtoRnhHN2VDaEdyc2JWc1doRUgxWnZXMnRHZWNL?=
 =?gb2312?B?L3ZHaTFvZEx5RG1USDdiSlNKOHViUTRKaHAwektlampIaUIvR0NhdVZITzlo?=
 =?gb2312?B?WXc5YUt4c1p1WXBQU1lidllFbElVSzBZMVVwM01NbUlPamZIaDJpM1FNYmxN?=
 =?gb2312?B?YzNLZEhlUUtyTWp3cEhybExlY1kyOElQUktJZEFGdHRjSXZiQS9CNGt5TDFl?=
 =?gb2312?B?RXRtdTFnWkR1ZzhvK0s4QjJDZkJZbWZMNEd2S1lMS0Fmam43ODBVMHBZTUEx?=
 =?gb2312?Q?J6EM=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 52b21123-0bf8-47af-553f-08dcdb935878
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Sep 2024 05:48:27.0317
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: r96soqwNqFMQztENu8ZekAyQ80wgS6KYaIfniZxvve/9p5SyxS/dEZRzFKx/HTaLe7K7BoVK41YV4CsPmQ9Cxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9569

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBSYXRoZWVzaCBLYW5ub3RoIDxy
a2Fubm90aEBtYXJ2ZWxsLmNvbT4NCj4gU2VudDogMjAyNMTqOdTCMjPI1SAxMjo1Ng0KPiBUbzog
V2VpIEZhbmcgPHdlaS5mYW5nQG54cC5jb20+DQo+IENjOiBWbGFkaW1pciBPbHRlYW4gPHZsYWRp
bWlyLm9sdGVhbkBueHAuY29tPjsgZGF2ZW1AZGF2ZW1sb2Z0Lm5ldDsNCj4gZWR1bWF6ZXRAZ29v
Z2xlLmNvbTsga3ViYUBrZXJuZWwub3JnOyBwYWJlbmlAcmVkaGF0LmNvbTsgQ2xhdWRpdQ0KPiBN
YW5vaWwgPGNsYXVkaXUubWFub2lsQG54cC5jb20+OyBhc3RAa2VybmVsLm9yZzsgZGFuaWVsQGlv
Z2VhcmJveC5uZXQ7DQo+IGhhd2tAa2VybmVsLm9yZzsgam9obi5mYXN0YWJlbmRAZ21haWwuY29t
OyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOw0KPiBuZXRkZXZAdmdlci5rZXJuZWwub3Jn
OyBicGZAdmdlci5rZXJuZWwub3JnOyBzdGFibGVAdmdlci5rZXJuZWwub3JnOw0KPiBpbXhAbGlz
dHMubGludXguZGV2DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggbmV0IDMvM10gbmV0OiBlbmV0Yzog
cmVzZXQgeGRwX3R4X2luX2ZsaWdodCB3aGVuIHVwZGF0aW5nDQo+IGJwZiBwcm9ncmFtDQo+IA0K
PiBPbiAyMDI0LTA5LTIwIGF0IDA4OjQyOjA2LCBXZWkgRmFuZyAod2VpLmZhbmdAbnhwLmNvbSkg
d3JvdGU6DQo+ID4gZW5ldGNfcmVjeWNsZV94ZHBfdHhfYnVmZigpIHdpbGwgbm90IGJlIGNhbGxl
ZC4gQWN0dWFsbHkgYWxsIFhEUF9UWA0KPiA+IGZyYW1lcyBhcmUgc2VudCBvdXQgYW5kIFhEUF9U
WCBidWZmZXJzIHdpbGwgYmUgZnJlZWQgYnkNCj4gZW5ldGNfZnJlZV9yeHR4X3JpbmdzKCkuDQo+
IHdoeSBkaWRuJ3QgeW91IGNob29zZSBlbmV0Y19mcmVlX3J4dHhfcmluZ3MoKSB0byByZXNldCBp
bmZsaWdodCBjb3VudCB0byAwID8NCg0KSU1PLCBJIHRoaW5rIGVuZXRjX3JlY29uZmlndXJlX3hk
cF9jYigpIGlzIG1vcmUgYXBwcm9wcmlhdGUgdG8gcmVzZXQNCnhkcF90eF9pbl9mbGlnaHQgdGhh
biBlbmV0Y19mcmVlX3J4dHhfcmluZ3MoKS4NCg==

