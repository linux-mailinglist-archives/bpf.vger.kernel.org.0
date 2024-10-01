Return-Path: <bpf+bounces-40669-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2085598BE1F
	for <lists+bpf@lfdr.de>; Tue,  1 Oct 2024 15:39:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 444461C21CD0
	for <lists+bpf@lfdr.de>; Tue,  1 Oct 2024 13:39:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB2421C57B0;
	Tue,  1 Oct 2024 13:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="MWGA9bLz"
X-Original-To: bpf@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010063.outbound.protection.outlook.com [52.101.69.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 137FA1C3F3E;
	Tue,  1 Oct 2024 13:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727789955; cv=fail; b=WyHh2xQH6KNuZ3tVkWfALwpWlsN2fThnkYJpmn88v6D54TiLFBfsRuVt5p/aohjWsddVI6pOkkBPXy/Sj0ukQJywzlw+y+KcCzY3VaPaZ/EAio5uuF6iQa3X7BRVEx21c8PZOivXBq/ZQqGXhtDv+EacaSnCGsdRvedl7f6vy10=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727789955; c=relaxed/simple;
	bh=z0WZyC9s7Bbc2/waBrDLbW4NFaG86rPobHxHMu6dZp0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Ct8fRQ87YWRIDWe3Maok/ffbfE8F5BVyoRoOc0KWyu/TYTqyuQWXXBnyxN6F5AAcEgSu0wY4siDM8YZ7FgQfyAvd1CD0Fn4KiVdaRFV66rvMDX2tMALloETQY4V/yfDFhvu1JIEFf3bHaxL9aX7CbZVsDV+O6tiEr/kzJ08dlpI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=MWGA9bLz; arc=fail smtp.client-ip=52.101.69.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kER7ggCjBd7Wkwt+DYx7YZ9IT0PFtq1kS9vjpoggbXfLdPBHAXblw51dcxSG1dejO+DJIrxBaV8ENStBZOX5dxNjGWIe8x4fRR8yFowYwys31z4CJMjojsTif5vM4dFAfyoRNHeRL2VKR7SegnyzQ3VPzPmapV7YdJ1+NU52nUFG1E+RtBuO5BZ0dlegmTaWNqQmjhsZQgRMmVSMlUbryEgZ8B6T6uwQGvnugD9v8XL0akanhV8SWCdCZ81/QuXsxtPNISdIxZmhSJvN7loa4KqQglj7TbE2X3qOyXgXcctUp2RxIzm6CkvdwD5C30KDr6a1ac79DF4gOiVM+6wGNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z0WZyC9s7Bbc2/waBrDLbW4NFaG86rPobHxHMu6dZp0=;
 b=ZKkj54kGzuQuHFlKURhtmfUbyWucsnbTpGFaOua9tB8oI3J4UXJmIoAnryb4X+FWY6sB8WH56j8sJf9z/gn7fkUBria6PewUjQVjwTG0kDHXePSU0t5MXp6fo0gujehRs63srPUYcHSLGhdaK7BvVLU3BMVN7SGNA09hZl1aymy6c6sraxGTzX8vII5Cx/MeOgSsDLuda11ce/jfIlEBl5wgZWpFC8VAvkDmvgVCeRhJ4mQ7WoN/r2kJMhsTvuSZzRLxJ5lCbb52J96VNUhRSFScPkaPd9ybhueFXwPRd1yMK2hsUVPogMQtPSIxsKv7o9O37kVPhT+zi0AYCaGitA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z0WZyC9s7Bbc2/waBrDLbW4NFaG86rPobHxHMu6dZp0=;
 b=MWGA9bLzyqcs0FTob/ZLOn1JXxEHaxU6GIpbRi0+RwsUc2q2I8/FWL3TpSu1o4y0K/kJjaIe5Cz9oNRh8j839tkHGf9+SArVGzwHbV0moT9IjRy8xHmo3V4z8ptIWlj83m5G07nI4F14dBrbPtoLsjBXaQcrV4pKR7YfFbsQjLTFX2jhpZHWwGxOIpglB54I2zrm8r/oehr2+BFFStFtc/Amk3t6CGvXciDy1PLSZFUf4YmAYFhTKwAPI65grk/MNE+O0yhWkNpyZccUuWXGbHPTqCRr2ABhSOG9RepEFYgs0MlRKyCBRjvUL6sPsXXFN/icQffbKxtbAK/019Coyg==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by PA2PR04MB10085.eurprd04.prod.outlook.com (2603:10a6:102:3ff::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.27; Tue, 1 Oct
 2024 13:39:10 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%6]) with mapi id 15.20.7918.024; Tue, 1 Oct 2024
 13:39:09 +0000
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
Subject: RE: [PATCH v2 net 3/3] net: enetc: disable IRQ after Rx and Tx BD
 rings are disabled
Thread-Topic: [PATCH v2 net 3/3] net: enetc: disable IRQ after Rx and Tx BD
 rings are disabled
Thread-Index: AQHbEhvKg7CI8w3+3UGT+l2bnqYKr7Jw5MKAgAEBQGA=
Date: Tue, 1 Oct 2024 13:39:09 +0000
Message-ID:
 <PAXPR04MB85102EFDDEBED7C602ACBD4888772@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20240929024506.1527828-1-wei.fang@nxp.com>
 <20240929024506.1527828-4-wei.fang@nxp.com>
 <20240930220249.dio23fh7mqw4pojn@skbuf>
In-Reply-To: <20240930220249.dio23fh7mqw4pojn@skbuf>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|PA2PR04MB10085:EE_
x-ms-office365-filtering-correlation-id: c8482eb3-e7f1-474c-77d4-08dce21e6dba
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|7416014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?gb2312?B?ZlVWV3dYaW40eDRpeUU2ZVBONFVwMnVmcHZ2cTNPbTMwaVVNOHhXVEhHeVo4?=
 =?gb2312?B?eFVPdmt4OWZRT1hwdk5iMkNnNFZacEZMM1pUZG9tekd5ZXlnbno2QTArVitu?=
 =?gb2312?B?bW16b0xONURJamhoYnZScXZYRitRRk9XVE5jWXpucm5sY2prR1NHMGVjR0xr?=
 =?gb2312?B?SVYwSkMraE9SanFsM3NjNVk0c3dVVDJLaGFrSWREN01QTVVMbFdlWWFJZUow?=
 =?gb2312?B?Q0FnSDRxNVFJZFptZWRPNTVxb1pQSm9Ma09rL1pYSVMxVVoyTXYxdnBuT3dG?=
 =?gb2312?B?SnRBWmoxdlJLNk9OdHRUNG95MkZ3NUpRK3Zwd215aWVBK2VibzhWeS93KzUx?=
 =?gb2312?B?dDl5aU5mSEU4WmFnUjNtNHJzYVlvekVmNVlkWW9pUDIvQnNIdUI3Z1dLNnc1?=
 =?gb2312?B?WUVRbU12dHcvendlR29hd1VkYVJKYVN4cElGZ0dlM0pZVUNBVDlrYzQrbDdx?=
 =?gb2312?B?S3pvOGxaZ245b3VvMGVWdjhOWElFcGEyRmgxVkRVRUdpUFlJaGNWczVycThD?=
 =?gb2312?B?Z0o1VW9WNTA4T3BKbWdWRklsQ3F2N29oWWZKakVpajZFNnZXRGpRcUt1b0xR?=
 =?gb2312?B?czdKWm4rYXFWekZDVis3MVp1MlNkMDN6K0dKcWs4TU5zcUJXU0xZNlQzNE1w?=
 =?gb2312?B?b09lOGpsTU1HS3prdnV3dm5wV0FjSS9JNUpmV2NZektXdnFXOWNLNmhJSWtC?=
 =?gb2312?B?U2hUOUZCTXhMWmQvSWdqVE1FcVZneHF5R3JKZGJianNhd0xST1ZxL3NoeTlF?=
 =?gb2312?B?bTJTT1JqMWo5a2IrdkpvUXo1Tmc0VzlTS0V1NXdpK0Qrdm5RV1l5MU5mT3RC?=
 =?gb2312?B?NTN3QVd0LzNjaGhPdzlzNDlUb2x5b2VFQy9US3Bhb0dsUjdUdWJCTmZCMFky?=
 =?gb2312?B?cGlndk9GUjNXRW1VVWNxbG04akFoSTdWempHaXliMnIvL1lFOWR3dDFQenpu?=
 =?gb2312?B?VHpyQmRnY082SlBpOTdKbEdhUkdGc0dWclhJQzVnL2JKMWZSL0swem0zQnNl?=
 =?gb2312?B?TnAzNHlDWlFCWWJTQkJsMjZsVzI3NE5vNGVjWmRzVVA3a1Y1WTdBMUM2bVFh?=
 =?gb2312?B?VWRXaCtJNi9BVXBKNG5iZkIrdUtjblE0cHdqNzhGOWVZemxxbzRhOE1Cb3hv?=
 =?gb2312?B?SW9JSk5hd3NkOVA2alhPdjYzbHlJYWpxcUNPMitBQkEyWTlMMmhJbC9Bc2dV?=
 =?gb2312?B?Y0htM0VxemFhV2Z5TlNzTkJlUnBCaExpVDgwS2E0RHBRS3R5NlRkTFhNQ0ZB?=
 =?gb2312?B?VU5YVlVWM3U3UkJSbzdQNXJIUEcwa1dCZzBUQWFCL0JDbGN0K2NKOGM0MW1Q?=
 =?gb2312?B?aTlWbG5qZmxNM2ZtdzY0MjNNdTlEbGUvR0FaZi9DOGFkQWpsTU9McGI3NVZ0?=
 =?gb2312?B?UHBYSnBUNlk4c1p5R0UyWFBUbmRTUUtqR1hRL2FrSzlZUWxQajM4MGFQUmhs?=
 =?gb2312?B?dGEvQWdDVis1eWRhU3NTbkJmS0x2M2ZlQVZ3M1BybVZ2RmM0aC9oR0tmT1lD?=
 =?gb2312?B?T1hUbUhJU09ndks1N3V2RXVNeERBVkhnbHJvTnhaY2hqZXdWUDBDVjBTZU1P?=
 =?gb2312?B?blFLNElvMlUzVlhnb0Y0WGxldUxJclJjc2tpdENaSmx4SjhCZFRqODVpYjk0?=
 =?gb2312?B?S2pwa01aWll6VkZsV1Z0Ym1reUMwVkRIQ2NRMmpXVUt6amVIbFBFN25ESk84?=
 =?gb2312?B?TkpQU0VhVFgwM0pFTzR6L2s1V1I0RzhncFM1UE1QL3RpQ3htRFBuQUM0TGlM?=
 =?gb2312?B?SXBnOXVOaFJSS1hiNWpBRVIwOXBrVVRBeEtzK0JENU1yYkRjZC9NR0F1bi9F?=
 =?gb2312?B?QkZxSWFGUno2alRuR0M2Zz09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?NGxZNmFTaDFUQ2VlMkhuV3l3a29NSUp4TW93WkUvRnZmWDZJeG1iTWNiVmtH?=
 =?gb2312?B?YjBjR0RNZUV6VGFGQTd2b1QwdW9TeEtJSFVaVWFlQkQrNnpldG5icDJrbk5K?=
 =?gb2312?B?SmZva2cwTzhwRSsxYjVKM29USmV0WUVHYnZSUHZBOUcwUDhudWlGM2c0VG9r?=
 =?gb2312?B?VmN6Rkx2ZHUxVHVnWUZDOXRmVjdZNmZ1d1RJTndwUjAvb0wzV2hKOFc0U3lH?=
 =?gb2312?B?WTUxNVJhaVRUbHdQSjhad3NmN2pQTFBqalF2RkRZMVpIZTRRTjh2c0xYaUQ0?=
 =?gb2312?B?Rm90R0JPd2o5R1dOVDAzaVBQdXpGUEdxTWowdzBDcm1oUy83eG9kMklnak1n?=
 =?gb2312?B?UWx1NStYTkxtZENGcnNSM2psZnVnYk9IQnlzeFZPYUhXb0NvbEtkMG9tTjFQ?=
 =?gb2312?B?VlNsSHpsZFBab05jY1ZtQjViWnVnMEpJdWlxRlh1a0MvSGRieUVCV1A5VUJi?=
 =?gb2312?B?U3NTN2hEZEliWkNkSVlsQ2dSYkRUazNDN3hRbmU4bzFaZVNyYTJvaEkydkhD?=
 =?gb2312?B?WmpvSjJWcjhzRnBOZnV6SGpjQkNFS2c0UWUzNzFZUUp6c3ppU3V5UXFRVnh6?=
 =?gb2312?B?cjFMNmRwZVpRdHBOdFgranFDNHAxZ0pvWEpDOTNhZGRsY0hEbzdVSWtoRW9v?=
 =?gb2312?B?YVpPZStHNFM4TVIrRHJkT3FjWUJtalNYeFA1ZUpWOVQxZllVZWhYNnp4OXVM?=
 =?gb2312?B?aTRsaGZ4dUVtWldybkl4dndWSDBVbzdMNU9oQ2NiMTdRazdCdENQYUNLQnhu?=
 =?gb2312?B?dUVyQ3ZERzgwc2p1M3MrL1dTdGVncmJZdm42aVdxNzQ0dG8ybUl3QnlkN2Z2?=
 =?gb2312?B?QlQ1ZStQZ2NUZnNCYTE3V2NDMHVDSFlFUjVUQTFoN0MyRGl0QysrbERibHJi?=
 =?gb2312?B?UFBWL2Zxb0tnUW5IektCTk8wV3JXdDM0Z3JHbW9aRWhaOGFaM3lWdmF2Ylg1?=
 =?gb2312?B?U0F1K1EzcDQ0bXo3eTNEdjVOZnR4M2tLc3llRVlEcnJ3cGpxMnBTUndaT3dB?=
 =?gb2312?B?ZjFaaXAwME0xbjVrSDZ0OW9JakJHS0pOQUdDYy9mZlJoZDI2TncvbWcwRHZm?=
 =?gb2312?B?K1g2T2R5dVFzTzB6dE1ZRVFTZlROV0l5d2FEYk5VV00yZW4wU05rV09nV2Nn?=
 =?gb2312?B?KzkxU3kwdlRZbGc0YkNjcE80Q2ZLRVhuK2g2TjlLVTFxV2ttWW5OY29zMFVZ?=
 =?gb2312?B?VTZGZHVhdGNySjBIZnlkMlhOZUl3c2FuYVlDeitWbDhzR0xHQXdGZW4yaVJS?=
 =?gb2312?B?ZVhZQTdsTnlOQnVPc1N3TDE3T2lEMlc4b3hxZXFFTFJkOTNIUTFXQUVUOXJy?=
 =?gb2312?B?c2FxZTgrY2dPY2ZpUENSOWdBRWZRUWw4T0NqMWJBTVFYM0FCSEFQZkFLT3Vo?=
 =?gb2312?B?VndjOCtXUXZrSHZtRGoxb1hGVkhtcUJJVGEwbDdQWWxzWXBSQTREL2QxWUVu?=
 =?gb2312?B?QUJoQUdReWoxcWg2cWM5ZXNaSnk3QmV5Q1hHYmVVemVvNGJ2NHhGY3M3UGYy?=
 =?gb2312?B?NXRjMTMrSnY2b09DVG9EbG1mR3FvVGRrYUJYVk9iNFdFOEV6bFZMK2I3WURQ?=
 =?gb2312?B?bDdLb3ZrSkwwdWt1eFRzZnRCbUUwSXdORklxcXFicWdEUE81UlE0dFhJNC9q?=
 =?gb2312?B?SFZDVVJ0QWJyKysrNDg5blFjWXcxVDJsY2ZIT3VlR1VmcEE3QldkZHRpWTJX?=
 =?gb2312?B?VURXT3E2ZnZtWFljRFFrYnNwc3hLMUhZemhDc0hnTFVHSDBoWWpIdnE1ck1X?=
 =?gb2312?B?NFlXNWsraEpSaDhOZjRXSy85MzZFYXQ4VUM1NHBxZTBBd2Z2MkYwOWNweExs?=
 =?gb2312?B?NkJmbCtmTDhrdEVqK3lUUHZNSkFVbSt2c3BlRW0rV2xteW1rajdsSldRWW9k?=
 =?gb2312?B?eGxjcHZ3em9aYmdmOVEwTDREWUIyeFQ3SThaMU95ZkxzditMSVlCS3JmNmxO?=
 =?gb2312?B?RDR5OTg4SkNTSmIzcmVhK0x2eTYwL2lLd3NsS3ZnQ3FNbzdyQ1lCeHdzRGFF?=
 =?gb2312?B?QUNuVEJVbmtUOXFmbG1wSDZnSkE0RE5oV2V1dHBjVDVjaldheWx2dXJMRW1Y?=
 =?gb2312?B?OXFVOTZkQVd3UGNURHI1NktudkxwM2NHZ2gzbEpnT3VKQVEzTXlVVUNkQVhK?=
 =?gb2312?Q?Qjmw=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: c8482eb3-e7f1-474c-77d4-08dce21e6dba
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2024 13:39:09.6979
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ci1mqc1oymVqQAbvjVC74+tyBVl8p0eaoxwHUyvRPnA+H14v1MSdiYOn5DreJiZdv/6ImZu4Hef5AaxznszDog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR04MB10085

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBWbGFkaW1pciBPbHRlYW4gPHZs
YWRpbWlyLm9sdGVhbkBueHAuY29tPg0KPiBTZW50OiAyMDI0xOoxMNTCMcjVIDY6MDMNCj4gVG86
IFdlaSBGYW5nIDx3ZWkuZmFuZ0BueHAuY29tPg0KPiBDYzogZGF2ZW1AZGF2ZW1sb2Z0Lm5ldDsg
ZWR1bWF6ZXRAZ29vZ2xlLmNvbTsga3ViYUBrZXJuZWwub3JnOw0KPiBwYWJlbmlAcmVkaGF0LmNv
bTsgQ2xhdWRpdSBNYW5vaWwgPGNsYXVkaXUubWFub2lsQG54cC5jb20+Ow0KPiBhc3RAa2VybmVs
Lm9yZzsgZGFuaWVsQGlvZ2VhcmJveC5uZXQ7IGhhd2tAa2VybmVsLm9yZzsNCj4gam9obi5mYXN0
YWJlbmRAZ21haWwuY29tOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOw0KPiBuZXRkZXZA
dmdlci5rZXJuZWwub3JnOyBicGZAdmdlci5rZXJuZWwub3JnOyBzdGFibGVAdmdlci5rZXJuZWwu
b3JnOw0KPiBpbXhAbGlzdHMubGludXguZGV2OyBya2Fubm90aEBtYXJ2ZWxsLmNvbTsgbWFjaWVq
LmZpamFsa293c2tpQGludGVsLmNvbTsNCj4gc2JoYXR0YUBtYXJ2ZWxsLmNvbQ0KPiBTdWJqZWN0
OiBSZTogW1BBVENIIHYyIG5ldCAzLzNdIG5ldDogZW5ldGM6IGRpc2FibGUgSVJRIGFmdGVyIFJ4
IGFuZCBUeCBCRCByaW5ncw0KPiBhcmUgZGlzYWJsZWQNCj4gDQo+IE9uIFN1biwgU2VwIDI5LCAy
MDI0IGF0IDEwOjQ1OjA2QU0gKzA4MDAsIFdlaSBGYW5nIHdyb3RlOg0KPiA+IFdoZW4gcnVubmlu
ZyAieGRwLWJlbmNoIHR4IGVubzAiIHRvIHRlc3QgdGhlIFhEUF9UWCBmZWF0dXJlIG9mIEVORVRD
DQo+ID4gb24gTFMxMDI4QSwgaXQgd2FzIGZvdW5kIHRoYXQgaWYgdGhlIGNvbW1hbmQgd2FzIHJl
LXJ1biBtdWx0aXBsZSB0aW1lcywNCj4gPiBSeCBjb3VsZCBub3QgcmVjZWl2ZSB0aGUgZnJhbWVz
LCBhbmQgdGhlIHJlc3VsdCBvZiB4ZG8tYmVuY2ggc2hvd2VkDQo+ID4gdGhhdCB0aGUgcnggcmF0
ZSB3YXMgMC4NCj4gPg0KPiA+IHJvb3RAbHMxMDI4YXJkYjp+IyAuL3hkcC1iZW5jaCB0eCBlbm8w
DQo+ID4gSGFpcnBpbm5pbmcgKFhEUF9UWCkgcGFja2V0cyBvbiBlbm8wIChpZmluZGV4IDM7IGRy
aXZlciBmc2xfZW5ldGMpDQo+ID4gU3VtbWFyeSAgICAgICAgICAgICAgICAgICAgICAyMDQ2IHJ4
L3MgICAgICAgICAgICAgICAgICAwDQo+IGVycixkcm9wL3MNCj4gPiBTdW1tYXJ5ICAgICAgICAg
ICAgICAgICAgICAgICAgIDAgcngvcyAgICAgICAgICAgICAgICAgIDANCj4gZXJyLGRyb3Avcw0K
PiA+IFN1bW1hcnkgICAgICAgICAgICAgICAgICAgICAgICAgMCByeC9zICAgICAgICAgICAgICAg
ICAgMA0KPiBlcnIsZHJvcC9zDQo+ID4gU3VtbWFyeSAgICAgICAgICAgICAgICAgICAgICAgICAw
IHJ4L3MgICAgICAgICAgICAgICAgICAwDQo+IGVycixkcm9wL3MNCj4gPg0KPiA+IEJ5IG9ic2Vy
dmluZyB0aGUgUnggUElSIGFuZCBDSVIgcmVnaXN0ZXJzLCB3ZSBmb3VuZCB0aGF0IENJUiBpcyBh
bHdheXMNCj4gPiBlcXVhbCB0byAweDdGRiBhbmQgUElSIGlzIGFsd2F5cyAweDdGRSwgd2hpY2gg
bWVhbnMgdGhhdCB0aGUgUnggcmluZw0KPiA+IGlzIGZ1bGwgYW5kIGNhbiBubyBsb25nZXIgYWNj
b21tb2RhdGUgb3RoZXIgUnggZnJhbWVzLiBUaGVyZWZvcmUsIHdlDQo+ID4gY2FuIGNvbmNsdWRl
IHRoYXQgdGhlIHByb2JsZW0gaXMgY2F1c2VkIGJ5IHRoZSBSeCBCRCByaW5nIG5vdCBiZWluZw0K
PiA+IGNsZWFuZWQgdXAuDQo+ID4NCj4gPiBGdXJ0aGVyIGFuYWx5c2lzIG9mIHRoZSBjb2RlIHJl
dmVhbGVkIHRoYXQgdGhlIFJ4IEJEIHJpbmcgd2lsbCBvbmx5DQo+ID4gYmUgY2xlYW5lZCBpZiB0
aGUgImNsZWFuZWRfY250ID4geGRwX3R4X2luX2ZsaWdodCIgY29uZGl0aW9uIGlzIG1ldC4NCj4g
PiBUaGVyZWZvcmUsIHNvbWUgZGVidWcgbG9ncyB3ZXJlIGFkZGVkIHRvIHRoZSBkcml2ZXIgYW5k
IHRoZSBjdXJyZW50DQo+ID4gdmFsdWVzIG9mIGNsZWFuZWRfY250IGFuZCB4ZHBfdHhfaW5fZmxp
Z2h0IHdlcmUgcHJpbnRlZCB3aGVuIHRoZSBSeA0KPiA+IEJEIHJpbmcgd2FzIGZ1bGwuIFRoZSBs
b2dzIGFyZSBhcyBmb2xsb3dzLg0KPiA+DQo+ID4gWyAgMTc4Ljc2MjQxOV0gW1hEUCBUWF0gPj4g
Y2xlYW5lZF9jbnQ6MTcyOCwgeGRwX3R4X2luX2ZsaWdodDoyMTQwDQo+ID4gWyAgMTc4Ljc3MTM4
N10gW1hEUCBUWF0gPj4gY2xlYW5lZF9jbnQ6MTk0MSwgeGRwX3R4X2luX2ZsaWdodDoyMTEwDQo+
ID4gWyAgMTc4Ljc3NjA1OF0gW1hEUCBUWF0gPj4gY2xlYW5lZF9jbnQ6MTc5MiwgeGRwX3R4X2lu
X2ZsaWdodDoyMTEwDQo+ID4NCj4gPiBGcm9tIHRoZSByZXN1bHRzLCB3ZSBjYW4gc2VlIHRoYXQg
dGhlIG1heCB2YWx1ZSBvZiB4ZHBfdHhfaW5fZmxpZ2h0DQo+ID4gaGFzIHJlYWNoZWQgMjE0MC4g
SG93ZXZlciwgdGhlIHNpemUgb2YgdGhlIFJ4IEJEIHJpbmcgaXMgb25seSAyMDQ4Lg0KPiA+IFRo
aXMgaXMgaW5jcmVkaWJsZSwgc28gd2UgY2hlY2tlZCB0aGUgY29kZSBhZ2FpbiBhbmQgZm91bmQg
dGhhdA0KPiA+IHhkcF90eF9pbl9mbGlnaHQgZGlkIG5vdCBkcm9wIHRvIDAgd2hlbiB0aGUgYnBm
IHByb2dyYW0gd2FzIHVuaW5zdGFsbGVkDQo+ID4gYW5kIGl0IHdhcyBub3QgcmVzZXQgd2hlbiB0
aGUgYmZwIHByb2dyYW0gd2FzIGluc3RhbGxlZCBhZ2Fpbi4gVGhlDQo+ID4gcm9vdCBjYXVzZSBp
cyB0aGF0IHRoZSBJUlEgaXMgZGlzYWJsZWQgdG9vIGVhcmx5IGluIGVuZXRjX3N0b3AoKSwNCj4g
PiByZXN1bHRpbmcgaW4gZW5ldGNfcmVjeWNsZV94ZHBfdHhfYnVmZigpIG5vdCBiZWluZyBjYWxs
ZWQsIHRoZXJlZm9yZSwNCj4gPiB4ZHBfdHhfaW5fZmxpZ2h0IGlzIG5vdCBjbGVhcmVkLg0KPiA+
DQo+ID4gRml4ZXM6IGZmNThmZGEwOTA5NiAoIm5ldDogZW5ldGM6IHByaW9yaXRpemUgYWJpbGl0
eSB0byBnbyBkb3duIG92ZXIgcGFja2V0DQo+IHByb2Nlc3NpbmciKQ0KPiA+IENjOiBzdGFibGVA
dmdlci5rZXJuZWwub3JnDQo+ID4gU2lnbmVkLW9mZi1ieTogV2VpIEZhbmcgPHdlaS5mYW5nQG54
cC5jb20+DQo+ID4gLS0tDQo+ID4gdjIgY2hhbmdlczoNCj4gPiAxLiBNb2RpZnkgdGhlIHRpdGls
ZSBhbmQgcmVwaHJhc2UgdGhlIGNvbW1pdCBtZWVzYWdlLg0KPiA+IDIuIFVzZSB0aGUgbmV3IHNv
bHV0aW9uIGFzIGRlc2NyaWJlZCBpbiB0aGUgdGl0bGUNCj4gPiAtLS0NCj4gDQo+IEkgZ2F2ZSB0
aGlzIGFub3RoZXIgdGVzdCB1bmRlciBhIGJpdCBkaWZmZXJlbnQgc2V0IG9mIGNpcmN1bXN0YW5j
ZXMgdGhpcyB0aW1lLA0KPiBhbmQgSSdtIGNvbmZpZGVudCB0aGF0IHRoZXJlIGFyZSBzdGlsbCBw
cm9ibGVtcywgd2hpY2ggSSBoYXZlbid0IGlkZW50aWZpZWQNCj4gdGhvdWdoICh5ZXQpLg0KPiAN
Cj4gV2l0aCA2NCBieXRlIGZyYW1lcyBhdCAyLjUgR2JwcywgSSBzZWUgdGhpcyBnb2luZyBvbjoN
Cj4gDQo+ICQgeGRwLWJlbmNoIHR4IGVubzAgJg0KPiAkIHdoaWxlIDo7IGRvIHRhc2tzZXQgJCgo
MSA8PCAwKSkgaHdzdGFtcF9jdGwgLWkgZW5vMCAtciAxICYmIHNsZWVwIDEgJiYgdGFza3NldA0K
PiAkKCgxIDw8IDApKSBod3N0YW1wX2N0bCAtaSBlbm8wIC1yIDAgJiYgc2xlZXAgMTsgZG9uZQ0K
PiBjdXJyZW50IHNldHRpbmdzOg0KPiB0eF90eXBlIDANCj4gcnhfZmlsdGVyIDANCj4gbmV3IHNl
dHRpbmdzOg0KPiB0eF90eXBlIDANCj4gcnhfZmlsdGVyIDENCj4gU3VtbWFyeSAgICAgICAgICAg
ICAgICAgMSw1NTYsOTUyIHJ4L3MgICAgICAgICAgICAgICAgICAwIGVycixkcm9wL3MNCj4gU3Vt
bWFyeSAgICAgICAgICAgICAgICAgICAgICAgICAwIHJ4L3MgICAgICAgICAgICAgICAgICAwIGVy
cixkcm9wL3MNCj4gU3VtbWFyeSAgICAgICAgICAgICAgICAgICAgICAgICAwIHJ4L3MgICAgICAg
ICAgICAgICAgICAwIGVycixkcm9wL3MNCj4gY3VycmVudCBzZXR0aW5nczoNCj4gdHhfdHlwZSAw
DQo+IHJ4X2ZpbHRlciAxDQo+IFN1bW1hcnkgICAgICAgICAgICAgICAgICAgICAgICAgMCByeC9z
ICAgICAgICAgICAgICAgICAgMCBlcnIsZHJvcC9zDQo+IFsgIDg4My43ODAzNDZdIGZzbF9lbmV0
YyAwMDAwOjAwOjAwLjAgZW5vMDogdGltZW91dCBmb3IgdHggcmluZyAjNiBjbGVhciAoaXRzDQo+
IFJYIHJpbmcgaGFzIDIwNzIgWERQX1RYIGZyYW1lcyBpbiBmbGlnaHQpDQo+IG5ldyBzZXR0aW5n
czoNCj4gdHhfdHlwZSAwDQo+IHJ4X2ZpbHRlciAwDQo+IFN1bW1hcnkgICAgICAgICAgICAgICAg
ICAgICAxLDAyNyByeC9zICAgICAgICAgICAgICAgICAgMCBlcnIsZHJvcC9zDQo+IGN1cnJlbnQg
c2V0dGluZ3M6DQo+IHR4X3R5cGUgMA0KPiByeF9maWx0ZXIgMA0KPiBTdW1tYXJ5ICAgICAgICAg
ICAgICAgICAgICAgICAgIDAgcngvcyAgICAgICAgICAgICAgICAgIDAgZXJyLGRyb3Avcw0KPiAN
Cj4gd2hpY2ggbG9va3MgbGlrZSB0aGUgc3ltcHRvbXMgdGhhdCB0aGUgcGF0Y2ggdHJpZXMgdG8g
c29sdmUuDQo+IA0KPiBNeSBwcmV2aW91cyB0ZXN0aW5nIHdhcyB3aXRoIDM5MCBieXRlIGZyYW1l
cywgYW5kIHRoaXMgZGlkIG5vdCBoYXBwZW4uDQo+IA0KPiBQbGVhc2UgZG8gbm90IG1lcmdlIHRo
aXMuDQoNCk9oLCBpdCBsb29rcyBsaWtlIHRoZXJlIGFyZSBzdGlsbCBzb21lIGlzc3VlcyB3ZSBk
b24ndCBrbm93IGFib3V0LiBJIGRpZA0KdGVzdCB1c2luZyA2NCBieXRlcyBidXQgbm90IGF0IHRo
YXQgaGlnaCBvZiBhIHJhdGUuIEFsc28gSSBkaWRuJ3QgdHVybiBvbg0KdGltZXN0YW1wLiBBbnl3
YXksIEkgd2lsbCB0cnkgdG8gcmVwcm9kdWNlIHRoZSBpc3N1ZSB3aGVuIEknbSBiYWNrIHRvDQpv
ZmZpY2UgbmV4dCBUdWVzZGF5LiBJdCB3b3VsZCBiZSBuaWNlIGlmIHlvdSBjYW4gaGVscCBmaW5k
IHRoZSByb290IGNhdXNlDQpiZWZvcmUgbmV4dCBUdWVzZGF5LCB0aGFua3MhDQo=

